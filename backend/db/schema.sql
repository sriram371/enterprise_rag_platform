-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;


-- =========================
-- USERS TABLE
-- =========================

CREATE TABLE users (

    id UUID PRIMARY KEY,

    email VARCHAR(255) UNIQUE NOT NULL,

    name VARCHAR(255),

    role VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


-- =========================
-- DOCUMENT STORAGE
-- =========================

CREATE TABLE documents (

    id UUID PRIMARY KEY,

    file_name TEXT,

    file_path TEXT,

    document_type TEXT,

    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


-- =========================
-- VECTOR STORE TABLE
-- =========================

CREATE TABLE document_embeddings (

    id UUID PRIMARY KEY,

    document_id UUID REFERENCES documents(id),

    content TEXT,

    embedding VECTOR(1536),

    metadata JSONB,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


-- =========================
-- CONVERSATION MEMORY
-- =========================

CREATE TABLE conversation_memory (

    id UUID PRIMARY KEY,

    user_id UUID REFERENCES users(id),

    session_id VARCHAR(255),

    user_message TEXT,

    assistant_response TEXT,

    embedding VECTOR(1536),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


-- =========================
-- USER MEMORY
-- =========================

CREATE TABLE user_memory (

    id UUID PRIMARY KEY,

    user_id UUID REFERENCES users(id),

    memory_key TEXT,

    memory_value TEXT,

    embedding VECTOR(1536),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


-- =========================
-- TASK MEMORY
-- =========================

CREATE TABLE task_memory (

    id UUID PRIMARY KEY,

    user_id UUID REFERENCES users(id),

    task TEXT,

    status TEXT,

    metadata JSONB,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


-- =========================
-- QUERY LOGGING
-- =========================

CREATE TABLE query_logs (

    id UUID PRIMARY KEY,

    user_id UUID,

    query TEXT,

    response TEXT,

    latency FLOAT,

    model_used TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


-- =========================
-- RETRIEVAL EVALUATION
-- =========================

CREATE TABLE retrieval_metrics (

    id UUID PRIMARY KEY,

    query TEXT,

    recall_at_k FLOAT,

    precision_at_k FLOAT,

    mrr FLOAT,

    hit_rate FLOAT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


-- =========================
-- FEEDBACK TABLE
-- =========================

CREATE TABLE feedback (

    id UUID PRIMARY KEY,

    user_id UUID,

    query TEXT,

    response TEXT,

    rating INT,

    comment TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


-- =========================
-- PROMPT VERSIONING
-- =========================

CREATE TABLE prompt_templates (

    id UUID PRIMARY KEY,

    name TEXT,

    version INT,

    template TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);
