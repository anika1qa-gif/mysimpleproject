.PHONY: install lint test test-smoke test-regression package clean

install:
	python -m pip install -r requirements.txt

lint:
	flake8 src tests

test:
	mkdir -p results
	pytest --junitxml=results/junit.xml

test-smoke:
	mkdir -p results
	pytest -m smoke --junitxml=results/junit.xml

test-regression:
	mkdir -p results
	pytest -m regression --junitxml=results/junit.xml

package:
	mkdir -p dist
	tar -czf dist/app.tgz src

clean:
	rm -rf .venv __pycache__ .pytest_cache results dist
