#!/bin/bash
# SessionStart hook لـ Claude Code على الويب.
# المشروع موقع ثابت بلا بناء ولا تبعيات، فالخطاف يثبّت فقط مدقق HTML
# (html-validate) خارج المستودع ويضيفه إلى PATH الجلسة.
set -euo pipefail

# يعمل على الويب فقط؛ محلياً لا يفعل شيئاً.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

TOOLS_DIR="${HOME}/.cache/montajati-tools"
BIN_DIR="${TOOLS_DIR}/node_modules/.bin"

if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
  echo "session-start: node/npm غير متوفرين، تخطي تثبيت html-validate" >&2
  exit 0
fi

# تثبيت idempotent: يُعاد فقط إذا كان الملف التنفيذي مفقوداً.
if [ ! -x "${BIN_DIR}/html-validate" ]; then
  mkdir -p "${TOOLS_DIR}"
  if [ ! -f "${TOOLS_DIR}/package.json" ]; then
    (cd "${TOOLS_DIR}" && npm init -y >/dev/null 2>&1)
  fi
  (cd "${TOOLS_DIR}" && npm install --no-audit --no-fund --loglevel=error html-validate)
fi

# إتاحة الأداة لبقية الجلسة.
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  echo "export PATH=\"${BIN_DIR}:\$PATH\"" >> "${CLAUDE_ENV_FILE}"
fi

echo "session-start: html-validate $("${BIN_DIR}/html-validate" --version | sed 's/html-validate-//') جاهز في ${BIN_DIR}"
