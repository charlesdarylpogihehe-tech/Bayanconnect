BAYANCONNECT — GITHUB PAGES + SUPABASE EDITION

This version is no longer a fake/static preview. The website files are static HTML/CSS/JS (required by GitHub Pages), while Supabase provides the live database and secure administrator authentication. Records are shared across visitors and remain saved after the site is closed.

IMPORTANT: GitHub Pages alone cannot run MySQL, PHP, Python, or server-side code. This package uses Supabase (hosted PostgreSQL + Auth) as the backend. You must complete the one-time setup below; the ZIP cannot contain your private project credentials.

SETUP
1. Create a free project at https://supabase.com/ and wait for it to finish provisioning.
2. Open SQL Editor in Supabase, create a new query, paste the complete contents of database-setup.sql, and click Run.
3. In Supabase Project Settings > API, copy the Project URL and anon/public key. Open assets/js/config.js and replace the two placeholder values. NEVER paste a service_role/secret key into this public website.
4. In Supabase Authentication > Users, add an administrator user with an email and strong password. Confirm the user if email confirmation is enabled. Copy that user's UUID.
5. In SQL Editor run: insert into public.profiles(id, role) values ('YOUR-ADMIN-USER-UUID','admin'); Replace the UUID with the actual value. This grants the admin dashboard role. Do not share the admin password.
6. Test locally by opening the folder with VS Code Live Server (recommended). Confirm public services load, submit a test request, sign in to admin, and test add/edit status/delete operations.
7. Publish to GitHub: create a repository, upload/push the CONTENTS of the BayanConnect_HTML_SQL folder (index.html must be at repository root), then go to Settings > Pages > Deploy from a branch > main > /(root) > Save. Wait for deployment.
8. If using a custom domain, add it in GitHub Pages and configure Supabase Auth URL Configuration with your deployed site URL.

FEATURES INCLUDED
- Public home page loads active services and published announcements from Supabase.
- Residents can submit service requests; requests are stored in the database.
- Admin sign-in uses Supabase Auth (email/password). Admin role is checked against profiles.
- Dashboard displays live counts and latest requests.
- Admin can update request statuses and delete requests.
- Admin can add/delete residents.
- Admin can add, publish/hide, and delete services.
- Admin can publish and delete announcements.
- Row Level Security policies protect administrator operations. Public users can only read published information and submit pending requests.

SECURITY NOTES
- Only the Supabase anon/public key belongs in config.js. It is designed to be public; database permissions are enforced by RLS. Never use the service_role key in browser JavaScript.
- The first admin profile must be assigned manually by a trusted project owner using the SQL step above. Never allow public sign-up to grant admin.
- Do not use real sensitive resident information for a school demo unless you have permission and an appropriate privacy notice.

TROUBLESHOOTING
- “Database not configured”: config.js still contains placeholders or the URL/key is wrong.
- “Invalid API key”: recopy the anon/public key from Supabase Project Settings > API.
- Admin redirects to login: make sure the signed-in Auth user's UUID has role='admin' in public.profiles.
- No services appear: run database-setup.sql and check that services have is_active=true.
- GitHub page is blank/404: ensure index.html is at repository root, not one folder deeper.

The old database.sql is retained as an archive of the original MySQL schema. Use database-setup.sql for this edition.
