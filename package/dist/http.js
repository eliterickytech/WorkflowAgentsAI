// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.
import express from "express";
import { StreamableHTTPServerTransport } from "@modelcontextprotocol/sdk/server/streamableHttp.js";
import { serverBuildAndConnect } from "./server.js";
import { packageVersion } from "./version.js";
const app = express();
app.use(express.json());
app.post('/mcp/:orgName', async (req, res) => {
    // In stateless mode, create a new instance of transport and server for each request
    // to ensure complete isolation. A single instance would cause request ID collisions
    // when multiple clients connect concurrently.
    try {
        const transport = new StreamableHTTPServerTransport({
            sessionIdGenerator: undefined,
        });
        const server = await serverBuildAndConnect(req.params.orgName, transport);
        res.on('close', () => {
            transport.close();
            server.close();
        });
        await transport.handleRequest(req, res, req.body);
    }
    catch (error) {
        console.error('Error handling MCP request:', error);
        if (!res.headersSent) {
            res.status(500).json({
                jsonrpc: '2.0',
                error: {
                    code: -32603,
                    message: 'Internal server error',
                },
                id: null,
            });
        }
    }
});
app.get('/mcp/:orgName', async (req, res) => {
    console.log('Received GET MCP request');
    res.writeHead(405).end(JSON.stringify({
        jsonrpc: "2.0",
        error: {
            code: -32000,
            message: "Method not allowed."
        },
        id: null
    }));
});
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Azure DevOps MCP Server with http transport listening on port ${PORT}. Version: ${packageVersion}`);
});
