# Documentation (Docs-as-Code)

La documentation est versionnee dans le depot et generee automatiquement.

## Dossiers

- src/ : sources Markdown
- generated/ : docs generees

## Generation

```
./scripts/generate_docs.sh
```

## Validation

```
./scripts/validate_docs.sh
./scripts/validate_all.sh
```

## Regle d'or

Aucune fusion tant que la doc n'est pas validee par tests + review humaine.
