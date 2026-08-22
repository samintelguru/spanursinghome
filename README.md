# SPA Nursing Home — website + admin system

Next.js project covering:
- Public marketing site (home, about, services, community, contact)
- Admin dashboard (patients, pharmacy, billing, blood bank, ambulance records)
- API routes connecting both to a shared Postgres database via Prisma

## Project structure

```
src/app/(public)/   marketing site pages
src/app/(admin)/    staff-only admin dashboard pages
src/app/api/        API routes (business logic + database access)
prisma/schema.prisma  database schema for all modules
```

## Setting up from scratch

### 1. Install Node.js
Download the LTS version from https://nodejs.org (v20 or v22). Verify with:
```
node -v
npm -v
```

### 2. Get a code editor
VS Code (https://code.visualstudio.com) is recommended. Use its built-in terminal for everything below.

### 3. Extract and open the project
```
tar -xzf spa-nursing-home-scaffold.tar.gz
cd spa-nursing-home
```
Open this folder in VS Code.

### 4. Install dependencies
```
npm install
```

### 5. Get a Postgres database
No local Postgres install needed — use a free hosted database:
- https://neon.tech, or
- https://supabase.com

Create a project and copy the connection string (looks like `postgresql://user:pass@host/dbname`).

Recommended: create **two** databases — one for development, one for production — once real patient data is involved, so testing never touches live records.

### 6. Set your environment variable
Open `.env` in the project root and replace `DATABASE_URL` with your real connection string. This file is local only and is never committed to git (see `.gitignore`).

### 7. Create the database tables
```
npx prisma generate
npx prisma migrate dev --name init
```

### 8. Run the site locally
```
npm run dev
```
Open http://localhost:3000 — changes to files show up instantly.

## Deploying to production

1. Push this project to a GitHub repository.
2. Create a project on https://vercel.com and connect it to that repo (Vercel is built for Next.js and auto-deploys on every push).
3. In the Vercel project's environment variables, add `DATABASE_URL` pointing to your **production** database (Neon/Supabase project from step 5).
4. Deploy. Vercel gives you a live URL; a custom domain (e.g. spanursinghome.org) can be attached in the Vercel project settings.

## Notes

- The pharmacy dispense API (`src/app/api/pharmacy/dispense/route.ts`) is the reference example for how modules should work: it checks stock, deducts it, and creates the matching billing line item in a single database transaction, so pharmacy and billing can never drift out of sync.
- Staff authentication and role-based access control (`Staff.role` in the schema) still need to be wired up before the admin routes are safe to expose.
