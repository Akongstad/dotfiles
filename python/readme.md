# Python project setup

New package (uses the `uv_build` backend by default):

```bash
uv init --package
```

Pre-commit with ruff + commitizen (copy `.pre-commit-config.yaml` from this folder):

```bash
uv add --dev pre-commit
uv run pre-commit install
```

If the package can't be imported because uv reused a stale cached build:

```bash
uv sync --reinstall-package <package>   # targeted
uv add --no-cache <package>             # blunt: bypass the cache entirely
```
