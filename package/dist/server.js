// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import * as azdev from "azure-devops-node-api";
import { DefaultAzureCredential } from "@azure/identity";
import { configurePrompts } from "./prompts.js";
import { configureAllTools } from "./tools.js";
import { userAgent } from "./utils.js";
import { packageVersion } from "./version.js";
async function getAzureDevOpsToken() {
    process.env.AZURE_TOKEN_CREDENTIALS = "dev";
    const credential = new DefaultAzureCredential(); // CodeQL [SM05138] resolved by explicitly setting AZURE_TOKEN_CREDENTIALS
    const token = await credential.getToken("499b84ac-1321-427f-aa17-267ca6975798/.default");
    return token;
}
async function getAzureDevOpsClient(orgUrl) {
    const token = await getAzureDevOpsToken();
    const authHandler = azdev.getBearerHandler(token.token);
    const connection = new azdev.WebApi(orgUrl, authHandler, undefined, {
        productName: "AzureDevOps.MCP",
        productVersion: packageVersion,
        userAgent: userAgent
    });
    return connection;
}
export async function serverBuildAndConnect(orgName, transport) {
    const server = new McpServer({
        name: "Azure DevOps MCP Server",
        version: packageVersion,
    });
    const orgUrl = "https://dev.azure.com/" + orgName;
    configurePrompts(server);
    configureAllTools(server, () => orgName, getAzureDevOpsToken, () => getAzureDevOpsClient(orgUrl));
    await server.connect(transport);
    return server;
}
