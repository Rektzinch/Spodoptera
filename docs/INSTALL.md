# Installation

Hermes can install a skill from this repository by copying or linking `skills/bug-bounty-hunter` into its skills directory according to the Hermes version in use. Keep the repository as the update source and retain the complete directory, including `references`, `workflows`, `scripts`, and `templates`.

## Local verification

```bash
cd skills/bug-bounty-hunter
python3 - <<'PY'
from pathlib import Path
text = Path('SKILL.md').read_text()
assert text.startswith('---\nname: bug-bounty-hunter\n')
assert 'description:' in text
print('SKILL.md OK')
PY
./scripts/bootstrap.sh
```

`bootstrap.sh` reports availability only; it does not install tools or run scans. Complete an authorization file before active testing.
