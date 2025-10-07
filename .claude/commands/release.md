---
description: Release a new version
args:
  - name: version
    description: Version number (e.g., 1.0.0, 2.1.3)
    required: true
---

Release version {{version}} following these steps:

1. First, check if there are uncommitted changes and if so, create a commit using /commit
2. Update CHANGELOG.md if it exists in the project root
3. Update version in package.json if it exists and contains a "version" field
4. Update version in composer.json if it exists and contains a "version" field
5. Analyze the git history since the last tag to gather all changes
6. Create a comprehensive message including all modifications
7. Create a git tag for version {{version}} with the detailed message
8. Push the tag to GitHub using: `git push origin {{version}}`
9. Create a GitHub release with the same detailed notes

IMPORTANT:
- Do NOT create a pre-release
- Use the version format exactly as specified by the user (no "v" prefix or other modifications)
- Only update files that exist in the project
- Only update version fields that are present in the files
- Ensure all changes are committed before tagging
- If CHANGELOG.md exists, use it as the primary source for release notes
- If CHANGELOG.md does not exist, extract all commit messages since the last tag and format them as release notes
- Group changes by type when possible (features, fixes, improvements, etc.)
- The tag message and GitHub release notes should be identical and comprehensive
- The GitHub release title must be ONLY the version number (e.g., "1.1.0"), without any prefix like "Release" or "v"
