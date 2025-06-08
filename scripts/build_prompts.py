import yaml
import os
import glob

# This script assembles system prompts from YAML modules and markdown components.

# --- Configuration ---
# Absolute path to the directory containing this script
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
# Assumes the script is in 'scripts' and 'framework_files', 'modules' are siblings
ROOT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, '..'))
MODULES_DIR = os.path.join(ROOT_DIR, 'modules')
ROO_DIR = os.path.join(ROOT_DIR, 'framework_files', '.roo')

def load_yaml_file(path):
    """Loads a YAML file and returns its content as a dictionary."""
    if not os.path.exists(path):
        print(f"ERROR: YAML file not found, skipping: {path}")
        return {}
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f) or {}
    except Exception as e:
        print(f"ERROR: Could not parse YAML file {path}: {e}")
        return {}

def read_component_file(path):
    """Reads a text/markdown component file."""
    if not os.path.exists(path):
        print(f"ERROR: Component file not found: {path}")
        return ""
    with open(path, 'r', encoding='utf-8') as f:
        return f.read()

def main():
    """Main function to build prompts."""
    print("--- Starting Roo Framework Prompt Build Process ---")

    # 1. Load core modules that are always included
    print("Loading core rule module...")
    core_rules = load_yaml_file(os.path.join(MODULES_DIR, 'core_rules.yml'))
    if not core_rules:
        print("ERROR: Core rules are missing or empty. Aborting.")
        return

    # 2. Find all mode manifests
    manifest_paths = glob.glob(os.path.join(ROO_DIR, 'modes', '*.manifest'))
    if not manifest_paths:
        print(f"ERROR: No manifest files found in {os.path.join(ROO_DIR, 'modes')}. Aborting.")
        return

    print(f"Found {len(manifest_paths)} modes to process.")

    # 3. Process each mode
    for manifest_path in manifest_paths:
        mode_slug = os.path.basename(manifest_path).replace('.manifest', '')
        print(f"Processing mode: {mode_slug}...")

        # Start with core rules
        final_prompt_content = yaml.dump(core_rules, default_flow_style=False, allow_unicode=True, sort_keys=False)

        with open(manifest_path, 'r', encoding='utf-8') as f:
            for line in f:
                component_rel_path = line.strip()
                if not component_rel_path or component_rel_path.startswith('#'):
                    continue
                
                # All paths in manifests are relative to the ROO_DIR
                component_abs_path = os.path.join(ROO_DIR, component_rel_path.replace('.roo/', '', 1))
                
                file_content = read_component_file(component_abs_path)
                if file_content:
                    final_prompt_content += "\n\n" + file_content
        
        # 4. Write the final assembled prompt
        output_file_path = os.path.join(ROO_DIR, f"system-prompt-{mode_slug}")
        try:
            with open(output_file_path, 'w', encoding='utf-8') as out_f:
                out_f.write(final_prompt_content)
            print(f"  -> Successfully generated: {os.path.basename(output_file_path)}")
        except IOError as e:
            print(f"  -> ERROR: Failed to write prompt file: {e}")

    print("--- Prompt Build Process Finished ---")

if __name__ == "__main__":
    main()