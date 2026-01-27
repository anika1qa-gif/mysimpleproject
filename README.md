# CI/CD Sample Pipeline (Jenkins + GitLab) with Starter Tests

This repository contains a minimal Python project with:

- **Jenkinsfile** (Declarative Pipeline with parameters and safety checks)
- **.gitlab-ci.yml** (Multi-stage pipeline with artifacts and manual deploy example)
- **Starter tests** using `pytest` with `smoke` and `regression` markers
- **Makefile** conveniences and basic linting via `flake8`

> Works on Linux/macOS/Windows (WSL). Python ≥ 3.10 recommended.

---

## Quick start (local)

```bash
python3 -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
make test        # run all tests
make test-smoke  # run smoke tests only
```

Artifacts:
- JUnit XML: `results/junit.xml`
- (optional) Packaging output: `dist/`

---

## Running in Jenkins

1. Create a **Multibranch Pipeline** or **Pipeline from SCM** job pointing to this repo.
2. The pipeline exposes parameters:
   - `TARGET_ENV`: `dev|qa|staging|prod`
   - `TEST_SUITE`: `smoke|regression|all`
   - `APPROVED`: manual checkbox required for production deploy stage
3. Click **Build with Parameters** → select values → run.
4. After the run, open **Test Result** and **Artifacts** for `results/junit.xml`.

> The pipeline blocks deployment to `prod` unless `APPROVED == true`.

---

## Running in GitLab CI

Simply push this repository to GitLab. The default pipeline uses the `python:3.11-slim` image and includes stages: `lint`, `test`, `package`, `deploy`.

- Test reports are stored as artifacts (`results/junit.xml`).
- The `deploy:prod` job is **manual** and **protected** by default rules.

---

## Project structure

```
ci-cd-sample-pipeline/
├─ Jenkinsfile
├─ .gitlab-ci.yml
├─ src/
│  └─ app.py
├─ tests/
│  ├─ test_app.py
│  └─ smoke/
│     └─ test_smoke.py
├─ requirements.txt
├─ pytest.ini
├─ Makefile
├─ scripts/
│  ├─ run_tests.sh
│  └─ package.sh
└─ README.md
```

---

## Notes
- The pipelines publish JUnit results so your CI server can show pass/fail summaries.
- Adjust `flake8` and `pytest.ini` to match your team's conventions.
- Add real deploy logic where the example currently echoes.
