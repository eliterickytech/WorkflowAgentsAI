// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.
/**
 * Available Azure DevOps MCP domains
 */
export var Domain;
(function (Domain) {
    Domain["ADVANCED_SECURITY"] = "advanced-security";
    Domain["BUILDS"] = "builds";
    Domain["CORE"] = "core";
    Domain["RELEASES"] = "releases";
    Domain["REPOSITORIES"] = "repositories";
    Domain["SEARCH"] = "search";
    Domain["TEST_PLANS"] = "test-plans";
    Domain["WIKI"] = "wiki";
    Domain["WORK"] = "work";
    Domain["WORK_ITEMS"] = "work-items";
})(Domain || (Domain = {}));
export const ALL_DOMAINS = "all";
/**
 * Manages domain parsing and validation for Azure DevOps MCP server tools
 */
export class DomainsManager {
    static AVAILABLE_DOMAINS = Object.values(Domain);
    enabledDomains;
    constructor(domainsInput) {
        this.enabledDomains = new Set();
        const normalizedInput = DomainsManager.parseDomainsInput(domainsInput);
        this.parseDomains(normalizedInput);
    }
    /**
     * Parse and validate domains from input
     * @param domainsInput - Either "all", single domain name, array of domain names, or undefined (defaults to "all")
     */
    parseDomains(domainsInput) {
        if (!domainsInput) {
            this.enableAllDomains();
            return;
        }
        if (Array.isArray(domainsInput)) {
            this.handleArrayInput(domainsInput);
            return;
        }
        this.handleStringInput(domainsInput);
    }
    handleArrayInput(domainsInput) {
        if (domainsInput.length === 0 || domainsInput.includes(ALL_DOMAINS)) {
            this.enableAllDomains();
            return;
        }
        if (domainsInput.length === 1 && domainsInput[0] === ALL_DOMAINS) {
            this.enableAllDomains();
            return;
        }
        const domains = domainsInput.map((d) => d.trim().toLowerCase());
        this.validateAndAddDomains(domains);
    }
    handleStringInput(domainsInput) {
        if (domainsInput === ALL_DOMAINS) {
            this.enableAllDomains();
            return;
        }
        const domains = [domainsInput.trim().toLowerCase()];
        this.validateAndAddDomains(domains);
    }
    validateAndAddDomains(domains) {
        const availableDomainsAsStringArray = Object.values(Domain);
        domains.forEach((domain) => {
            if (availableDomainsAsStringArray.includes(domain)) {
                this.enabledDomains.add(domain);
            }
            else if (domain === ALL_DOMAINS) {
                this.enableAllDomains();
            }
            else {
                console.error(`Error: Specified invalid domain '${domain}'. Please specify exactly as available domains: ${Object.values(Domain).join(", ")}`);
            }
        });
        if (this.enabledDomains.size === 0) {
            this.enableAllDomains();
        }
    }
    enableAllDomains() {
        Object.values(Domain).forEach((domain) => this.enabledDomains.add(domain));
    }
    /**
     * Check if a specific domain is enabled
     * @param domain - Domain name to check
     * @returns true if domain is enabled
     */
    isDomainEnabled(domain) {
        return this.enabledDomains.has(domain);
    }
    /**
     * Get all enabled domains
     * @returns Set of enabled domain names
     */
    getEnabledDomains() {
        return new Set(this.enabledDomains);
    }
    /**
     * Get list of all available domains
     * @returns Array of available domain names
     */
    static getAvailableDomains() {
        return Object.values(Domain);
    }
    /**
     * Parse domains input from string or array to a normalized array of strings
     * @param domainsInput - Domains input to parse
     * @returns Normalized array of domain strings
     */
    static parseDomainsInput(domainsInput) {
        if (!domainsInput) {
            return [];
        }
        if (typeof domainsInput === "string") {
            return domainsInput.split(",").map((d) => d.trim().toLowerCase());
        }
        return domainsInput.map((d) => d.trim().toLowerCase());
    }
}
