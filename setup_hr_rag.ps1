
Write-Host "🚀 Building Enterprise RAG Platform in: $((Get-Location).Path)" -ForegroundColor Cyan

# ============================================================
# FOLDERS
# ============================================================

$folders = @(

    # Website
    "website",

    # Frontend
    "frontend",

    # Backend root
    "backend",

    # Backend layers
    "backend/api",
    "backend/auth",
    "backend/core",
    "backend/db",
    "backend/llm",
    "backend/rag",
    "backend/rag/retriever",
    "backend/rag/generator",
    "backend/rag/embedder",
    "backend/rag/prompts",
    "backend/retrieval",
    "backend/memory",
    "backend/ingestion",
    "backend/evaluation",
    "backend/retrieval_evaluation",
    "backend/monitoring",
    "backend/feedback",

    # Deployment
    "deployment",

    # Config
    "config",

    # Testing
    "test_files"
)

# ============================================================
# FILES
# ============================================================

$files = @(

    # Core config
    "backend/core/config.py",

    # Database
    "backend/db/postgres.py",
    "backend/db/schema.sql",
    "backend/db/init_db.py",

    # LLM gateway
    "backend/llm/bedrock_client.py",

    # RAG pipeline
    "backend/rag/pipeline.py",
    "backend/rag/prompts/system_prompt.txt",

    # Retrieval
    "backend/retrieval/retriever.py",

    # Memory
    "backend/memory/memory_manager.py",

    # Ingestion
    "backend/ingestion/document_loader.py",

    # Evaluation
    "backend/evaluation/rag_evaluator.py",

    # Retrieval evaluation
    "backend/retrieval_evaluation/metrics.py",
    "backend/retrieval_evaluation/recall.py",
    "backend/retrieval_evaluation/precision.py",
    "backend/retrieval_evaluation/mrr.py",
    "backend/retrieval_evaluation/evaluator.py",
    "backend/retrieval_evaluation/golden_dataset.json",

    # Monitoring
    "backend/monitoring/logger.py",

    # Feedback
    "backend/feedback/feedback_store.py",

    # API
    "backend/api/routes.py",

    # Deployment
    "deployment/deploy_lambda.sh",

    # Root config
    ".env",
    "requirements.txt",

    # Tests
    "test_files/test_db.py",
    "test_files/test_config.py"
)

# ============================================================
# CREATE FOLDERS
# ============================================================

foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -Path $folder -ItemType Directory -Force | Out-Null
        Write-Host "Created Folder: $folder" -ForegroundColor Green
    }
}

# ============================================================
# CREATE FILES
# ============================================================

foreach ($file in $files) {
    if (!(Test-Path $file)) {
        New-Item -Path $file -ItemType File -Force | Out-Null
        Write-Host "Created File:   $file" -ForegroundColor Yellow
    }
}

# ============================================================
# CREATE __init__.py FOR PYTHON PACKAGES
# ============================================================

$pythonPackages = @(
    "backend",
    "backend/api",
    "backend/auth",
    "backend/core",
    "backend/db",
    "backend/llm",
    "backend/rag",
    "backend/rag/retriever",
    "backend/rag/generator",
    "backend/rag/embedder",
    "backend/retrieval",
    "backend/memory",
    "backend/ingestion",
    "backend/evaluation",
    "backend/retrieval_evaluation",
    "backend/monitoring",
    "backend/feedback",
    "test_files"
)

foreach ($pkg in $pythonPackages) {

    $initFile = "$pkg/__init__.py"

    if (!(Test-Path $initFile)) {

        New-Item -Path $initFile -ItemType File -Force | Out-Null
        Write-Host "Created Python Package: $initFile" -ForegroundColor Cyan
    }
}

Write-Host "`n✅ Project structure created successfully." -BackgroundColor DarkGreen