import os
from functools import lru_cache

from pydantic_settings import BaseSettings


class QdrantSettings(BaseSettings):
    collection_name: str = os.environ.get("QDRANT_COLLECTION_NAME", "")
    qdrant_url: str = os.environ.get("QDRANT_URL", "")
    qdrant_api_key: str = os.environ.get("QDRANT_API_KEY", "")


class ColpaliSettings(BaseSettings):
    colpali_model_name: str = "vidore/colqwen2.5-v0.2"


class SupabaseSettings(BaseSettings):
    supabase_key: str = os.environ.get("SUPABASE_KEY", "")
    supabase_url: str = os.environ.get("SUPABASE_URL", "")
    bucket: str = "colpali"


class OpenAISettings(BaseSettings):
    api_key: str = os.environ.get("OPENAI_API_KEY", "")
    base_url: str = os.environ.get("OPENAI_BASE_URL", "")


class Settings(BaseSettings):
    qdrant: QdrantSettings = QdrantSettings()
    colpali: ColpaliSettings = ColpaliSettings()
    supabase: SupabaseSettings = SupabaseSettings()
    openai: OpenAISettings = OpenAISettings()


@lru_cache
def get_settings() -> Settings:
    return Settings()
