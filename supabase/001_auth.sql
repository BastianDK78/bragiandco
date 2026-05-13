-- ============================================================
-- Migration 001: Auth tables (users, magic_links, email_captures)
-- Run this first in Supabase SQL Editor
-- ============================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS users (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email               TEXT NOT NULL UNIQUE,
  purchased           BOOLEAN NOT NULL DEFAULT false,
  purchased_at        TIMESTAMPTZ,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_accessed       TIMESTAMPTZ,
  session_token       TEXT UNIQUE,
  session_expires_at  TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_users_email         ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_session_token ON users(session_token);

CREATE TABLE IF NOT EXISTS magic_links (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email       TEXT NOT NULL,
  token       TEXT NOT NULL UNIQUE,
  expires_at  TIMESTAMPTZ NOT NULL,
  used        BOOLEAN NOT NULL DEFAULT false,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_magic_links_token        ON magic_links(token);
CREATE INDEX IF NOT EXISTS idx_magic_links_email_created ON magic_links(email, created_at DESC);

CREATE TABLE IF NOT EXISTS email_captures (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email       TEXT NOT NULL UNIQUE,
  source      TEXT NOT NULL CHECK (source IN ('free_checklist', 'purchase')),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE users          ENABLE ROW LEVEL SECURITY;
ALTER TABLE magic_links    ENABLE ROW LEVEL SECURITY;
ALTER TABLE email_captures ENABLE ROW LEVEL SECURITY;
-- Service role key bypasses RLS — no public policies needed.
