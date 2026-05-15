# /init-project

Read the current directory structure. Detect the tech stack by looking for:
- `package.json` → Node.js / Bun / Deno
- `Cargo.toml` → Rust
- `go.mod` → Go
- `pyproject.toml` / `requirements.txt` → Python
- `Gemfile` → Ruby
- `composer.json` → PHP
- `pom.xml` / `build.gradle` → Java
- `CMakeLists.txt` → C++

Update `CLAUDE.md`:
1. Fill in the `## Tech Stack` section
2. Add any framework-specific rules to `## Rules`
3. Run any available setup commands (e.g., `bun install`)
