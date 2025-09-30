import os
from dataclasses import dataclass
from dotenv import load_dotenv

load_dotenv()

@dataclass
class LLMConfig:
    # Providers: openai | azure | openai-compatible
    provider: str = os.getenv("LLM_PROVIDER", "openai")
    model: str = os.getenv("LLM_MODEL", "gpt-4o-mini")
    api_key: str = os.getenv("OPENAI_API_KEY", "")
    # Azure
    azure_endpoint: str = os.getenv("AZURE_OPENAI_ENDPOINT", "")
    azure_deployment: str = os.getenv("AZURE_OPENAI_DEPLOYMENT", "")
    azure_api_key: str = os.getenv("AZURE_OPENAI_API_KEY", "")
    # OpenAI-compatible (ex.: Ollama/LM Studio)
    base_url: str = os.getenv("OPENAI_BASE_URL", os.getenv("OLLAMA_BASE_URL", ""))
    local_mode: bool = os.getenv("LOCAL_MODE", "0") == "1"


@dataclass
class StartConfig:
    sprint: str = os.getenv("SPRINT", "")
    activity: str = os.getenv("OUTPUT_ACTIVITY", "")
    context: str = os.getenv("RUN_CONTEXT", "")
    orchestrators: bool = os.getenv("ORCHESTRATORS", "1") == "1"


def get_model_kwargs():
    cfg = LLMConfig()
    if cfg.provider == "azure":
        return {
            "provider": "azure",
            "azure_endpoint": cfg.azure_endpoint,
            "azure_deployment": cfg.azure_deployment,
            "api_key": cfg.azure_api_key,
            "model": cfg.model,
        }
    if cfg.provider in ("openai-compatible",) or cfg.local_mode:
        return {
            "provider": "openai-compatible",
            "base_url": cfg.base_url or "http://localhost:11434/v1",
            "api_key": cfg.api_key or "ollama",  # algumas implementações exigem qualquer string
            "model": cfg.model,
        }
    return {
        "provider": "openai",
        "api_key": cfg.api_key,
        "model": cfg.model,
    }
