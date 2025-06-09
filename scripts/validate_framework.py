import os
import glob

# This script validates the integrity of the Roo framework configuration.

# --- Configuration ---
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, '..'))
ROO_DIR = os.path.join(ROOT_DIR, '.roo')
MODES_DIR = os.path.join(ROO_DIR, 'modes')

ALL_COMPONENTS = set()

def main():
    """Main validation function."""
    print("--- Starting Roo Framework Validation ---")
    error_count = 0
    all_referenced_files = set()

    # 1. Check if the modes directory exists
    if not os.path.isdir(MODES_DIR):
        print(f"FAIL: Modes directory not found at '{MODES_DIR}'")
        error_count += 1
        return

    manifest_paths = glob.glob(os.path.join(MODES_DIR, '*.manifest'))
    if not manifest_paths:
        print("WARNING: No manifest files found to validate.")
        return

    # 2. Check each manifest file
    print(f"Found {len(manifest_paths)} manifests to check...")
    for manifest_path in manifest_paths:
        mode_slug = os.path.basename(manifest_path)
        # print(f"  Checking {mode_slug}...")
        with open(manifest_path, 'r', encoding='utf-8') as f:
            for i, line in enumerate(f, 1):
                component_rel_path = line.strip()
                if not component_rel_path or component_rel_path.startswith('#'):
                    continue
                
                # Normalize path for the current OS
                normalized_rel_path = component_rel_path.replace('.roo/', '', 1).replace('/', os.sep)
                component_abs_path = os.path.join(ROO_DIR, normalized_rel_path)
                all_referenced_files.add(os.path.normpath(component_abs_path))

                if not os.path.exists(component_abs_path):
                    print(f"  -> FAIL in {mode_slug}: File not found on line {i}: '{component_rel_path}'")
                    error_count += 1

    # 3. Check for orphaned files (files in components, rules, sops not in any manifest)
    print("\nChecking for orphaned (unreferenced) files...")
    base_dirs = ['components', 'docs', 'rules', 'sops']
    rule_flow_dirs = [d for d in os.listdir(ROO_DIR) if os.path.isdir(os.path.join(ROO_DIR, d)) and d.startswith('rules-flow-')]
    component_dirs_to_scan = base_dirs + rule_flow_dirs
    all_existing_files = set()
    for component_dir in component_dirs_to_scan:
        search_path = os.path.join(ROO_DIR, component_dir, '**', '*')
        for f_path in glob.glob(search_path, recursive=True):
            if os.path.isfile(f_path):
                all_existing_files.add(os.path.normpath(f_path))

    orphaned_files = all_existing_files - all_referenced_files
    if orphaned_files:
        print(f"  -> WARNING: Found {len(orphaned_files)} orphaned files not referenced in any manifest:")
        for orphan in sorted(list(orphaned_files)):
             # Show path relative to ROO_DIR for clarity
            print(f"    - {os.path.relpath(orphan, ROO_DIR)}")
    else:
        print("  -> OK: No orphaned files found.")

    # 4. Final Summary
    print("\n--- Validation Finished ---")
    if error_count == 0:
        print("SUCCESS: Framework validation passed with no errors.")
    else:
        print(f"FAILURE: Framework validation failed with {error_count} error(s).")

if __name__ == "__main__":
    main()