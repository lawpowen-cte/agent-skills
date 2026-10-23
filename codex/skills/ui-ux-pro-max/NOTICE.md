# Snapshot and attribution

This directory packages the locally maintained UI/UX Pro Max skill snapshot as of 2026-10-24, including its search implementation, datasets, provenance records, references, and standalone runtime tests. It is not claimed to be an unmodified upstream release.

Upstream project: [Next Level Builder / UI UX Pro Max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill). The upstream MIT copyright and permission notice are retained in [LICENSE](LICENSE). Local changes and added material in this repository follow the repository MIT license unless a file states otherwise.

The snapshot contains locally expanded catalogs, search contracts, data validation, and platform guidance. Packaging changes replace Claude-specific example paths with the resolved Codex skill directory. Search code and data are otherwise preserved from the local snapshot.

Google Fonts and Phosphor records are catalog metadata, not bundled font binaries or installed icon packages. Upstream origins and license metadata are retained in `data/data-provenance.json`, `data/catalog-summary.json`, and `data/google-font-licenses.json`. Consult those sources and the relevant upstream license before adding actual font or icon assets to a product.

Search output is guidance, not a substitute for current official platform documentation. Apply `ui-design-standards` first, then use the appropriate verified interaction reference for the current task.

Repository-maintenance tests `test_catalog_refresh.py` and `test_relevance_evaluator.py` are excluded from this installable snapshot: they require refresh/evaluation tools outside the skill directory. They are not used by search or design-system generation. Runtime code and data are unchanged.
