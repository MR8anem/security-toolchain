import json, sys, glob
def count_high_bandit(path):
    with open(path) as f: data=json.load(f)
    return sum(1 for r in data.get("results", []) if r.get("issue_severity")=="HIGH")
def count_high_semgrep(path):
    with open(path) as f: data=json.load(f)
    return sum(1 for r in data.get("results", []) if r.get("extra", {}).get("severity")=="ERROR")
bandit_count=count_high_bandit("reports/bandit/bandit.json")
semgrep_count=sum(count_high_semgrep(f) for f in glob.glob("reports/semgrep/*.json"))
total_high=bandit_count+semgrep_count
print(f"Total HIGH severity findings: {total_high}")
if total_high>0: sys.exit(1)
