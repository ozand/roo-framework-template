import yaml
import os
import glob

# This script assembles system prompts from YAML modules.
# It's a simplified version inspired by the 'greatscottymac-rooflow' project.

FRAMEWORK_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'framework_files'))
MODULES_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'modules'))
ROO_DIR = os.path.join(FRAMEWORK_DIR, '.roo')

def load_yaml_file(path):
    if not os.path.exists(path):
        print(f"WARNING: YAML file not found, skipping: {path}")
        return {}
    with open(path, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f) or {}

def main():
    print("--- Starting Roo Framework Prompt Build Process ---")

    # 1. Load core modules
    print("Loading core modules...")
    core_rules = load_yaml_file(os.path.join(MODULES_DIR, 'core_rules.yml'))
    # In a full implementation, more modules would be loaded here.

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
        
        final_prompt = {}
        with open(manifest_path, 'r', encoding='utf-8') as f:
            for line in f:
                component_path = line.strip()
                if not component_path or component_path.startswith('#'):
                    continue
                
                # Simple logic to distinguish different component types
                if 'core_rules.yml' in component_path:
                    final_prompt.update(core_rules)
                else:
                    # For .md files, we'd read them and add as a string under a key
                    # For this example, we assume all components are in modules for simplicity
                    pass

        # 4. Write the final assembled prompt
        # This is a simplified logic. A real script would merge YAMLs deeply.
        output_file_path = os.path.join(ROO_DIR, f"system-prompt-{mode_slug}")
        identity_path = os.path.join(ROO_DIR, f'system-prompt-flow-{mode_slug}')

        final_content = ""
        if os.path.exists(identity_path):
            with open(identity_path, 'r', encoding='utf-8') as id_f:
                final_content += id_f.read() + "\n\n"

        final_content += yaml.dump(final_prompt, default_flow_style=False, allow_unicode=True, sort_keys=False)

        with open(output_file_path, 'w', encoding='utf-8') as out_f:
            out_f.write(final_content)
        print(f"  -> Successfully generated: {output_file_path}")

    print("--- Prompt Build Process Finished ---")

if __name__ == "__main__":
    main()