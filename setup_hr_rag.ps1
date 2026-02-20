Write-Host "🚀 Building HR-RAG System in: $((Get-Location).Path)" -ForegroundColor Cyan

# 1. Define Directories (Relative to current location)
$folders = @(
    "website",
    "frontend",
    "backend/api",
    "backend/auth",
    "backend/core",
    "backend/rag/retriever",
    "backend/rag/generator",
    "backend/rag/embedder",
    "backend/rag/prompts",
    "backend/memory",
    "backend/db",
    "backend/ingestion",
    "backend/evaluation",
    "backend/retrieval_evaluation",
    "backend/monitoring",
    "backend/feedback",
    "deployment",
    "config"
)

# 2. Define Files (Relative to current location)
$files = @(
    "backend/retrieval_evaluation/metrics.py",
    "backend/retrieval_evaluation/recall.py",
    "backend/retrieval_evaluation/precision.py",
    "backend/retrieval_evaluation/mrr.py",
    "backend/retrieval_evaluation/evaluator.py",
    "backend/retrieval_evaluation/golden_dataset.json",
    "backend/retrieval_evaluation/monitoring.py",
    ".env",
    "requirements.txt"
)

# 3. Create Folders
foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -Path $folder -ItemType Directory -Force | Out-Null
        Write-Host "Created Folder: $folder" -ForegroundColor Green
    }
}

# 4. Create Files
foreach ($file in $files) {
    if (!(Test-Path $file)) {
        New-Item -Path $file -ItemType File -Force | Out-Null
        Write-Host "Created File:   $file" -ForegroundColor Yellow
    }
}

Write-Host "`n✅ Success! All folders and files created locally." -BackgroundColor DarkGreen