#!/usr/bin/env bash
set -euo pipefail

echo "==> Creating WealthyExpress WEX expanded scaffold..."

# ---------- Directories ----------
mkdir -p contracts scripts backend frontend/config frontend/app frontend/components frontend/public

# ---------- Root .gitignore ----------
cat > .gitignore << 'EOF'
# dependencies
node_modules/

# env
.env
.env.local
.env.*.local
frontend/.env.local

# build outputs
out/
cache/
artifacts/
.next/
frontend/.next/
dist/
build/
coverage/
coverage.json
typechain/

# logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# editor / OS
.DS_Store
Thumbs.db
.vscode/
.idea/

# misc
*.tsbuildinfo
EOF

# ---------- Root package.json ----------
cat > package.json << 'EOF'
{
  "name": "wealthyexpress-wex",
  "version": "1.0.0",
  "private": true,
  "description": "WealthyExpress ($WEX) full-stack web3 monorepo scaffold",
  "scripts": {
    "deploy": "tsx scripts/deploy.ts",
    "webhook": "tsx backend/webhook.ts",
    "frontend:dev": "npm --prefix frontend run dev",
    "frontend:build": "npm --prefix frontend run build",
    "frontend:start": "npm --prefix frontend run start"
  },
  "dependencies": {
    "dotenv": "^16.4.5",
    "express": "^4.21.1",
    "thirdweb": "^5.68.0"
  },
  "devDependencies": {
    "@types/express": "^4.17.21",
    "@types/node": "^22.8.7",
    "tsx": "^4.19.1",
    "typescript": "^5.6.3"
  }
}
EOF

# ---------- Root tsconfig ----------
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "types": ["node"],
    "outDir": "dist"
  },
  "include": ["scripts/**/*.ts", "backend/**/*.ts"]
}
EOF

# ---------- Env template ----------
cat > .env.example << 'EOF'
# ---------- Common ----------
NODE_ENV=development

# ---------- Deploy / Contracts ----------
ALCHEMY_RPC_URL=https://polygon-amoy.g.alchemy.com/v2/REPLACE_ME
PRIVATE_KEY=0xREPLACE_ME
THIRDWEB_SECRET_KEY=REPLACE_ME

# ---------- Frontend ----------
NEXT_PUBLIC_CHAIN_ID=80002
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=REPLACE_ME
NEXT_PUBLIC_WEX_TOKEN_ADDRESS=0x0000000000000000000000000000000000000000
NEXT_PUBLIC_WEX_STAKING_ADDRESS=0x0000000000000000000000000000000000000000
NEXT_PUBLIC_TRAILS_ENV=sandbox

# ---------- Webhook ----------
PORT=3001
ALCHEMY_NOTIFY_SIGNING_KEY=REPLACE_ME

# ---------- Checkout (placeholder) ----------
TRAILS_API_KEY=REPLACE_ME

# ---------- Token defaults ----------
WEX_TREASURY=0x000000000000000000000000000000000000dEaD
WEX_INITIAL_SUPPLY_WEI=1000000000000000000000000000
WEX_TRANSFER_TAX_BPS=300
WEX_BURN_BPS=100
EOF

# ---------- README ----------
cat > README.md << 'EOF'
# WealthyExpress ($WEX)

Expanded full-stack scaffold:
- ERC-20 token (`WEXToken.sol`) with tax + burn + permit + trading gate
- Single-asset staking (`WEXStaking.sol`) using rewards-per-token accounting
- thirdweb deployment script using Alchemy RPC
- HMAC-verified Alchemy Notify webhook (Express)
- Next.js frontend with wallet providers + dashboard + checkout placeholder

## Repository layout

wealthyexpress--wex/
├── .env.example
├── README.md
├── contracts/
│   ├── WEXToken.sol
│   └── WEXStaking.sol
├── scripts/
│   └── deploy.ts
├── backend/
│   └── webhook.ts
└── frontend/
    ├── package.json
    ├── next.config.ts
    ├── tsconfig.json
    ├── app/
    │   ├── globals.css
    │   ├── layout.tsx
    │   ├── page.tsx
    │   └── providers.tsx
    ├── config/
    │   └── index.ts
    └── components/
        └── TrailsCheckout.tsx

## 1) Install deps

From repo root:
```bash
npm i