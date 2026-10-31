# Generated files go in `tmp/`

Never leave build outputs or scratch artifacts in the repo root or next to source. Binaries, test binaries, profiles, coverage files, benchmark results and comparison output go in `tmp/` at the repo root.

- Create it self-ignoring before first use: `mkdir -p tmp && echo '*' > tmp/.gitignore`
- Name output paths explicitly; many tools default to the current directory. For Go:
  - `go build -o tmp/ ./...`, never a bare `go build`
  - `go test ... -o tmp/ -outputdir tmp` whenever profiling (`-cpuprofile`, `-memprofile`, …) or `-c`, since those write `<pkg>.test` to the current directory; `-outputdir` also places `-coverprofile` and profile files
  - Benchmark runs for comparison: `go test -bench . ... > tmp/old.txt`, then `benchstat tmp/old.txt tmp/new.txt`
- If the repo already has its own output convention (a Makefile target, `bin/`, `dist/`, `build/`), follow that instead.
