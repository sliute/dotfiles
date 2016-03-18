# Atom text editor

include_recipe 'atom'

if node['platform_family'] == 'debian'
  package 'atom'
end

atom_packages = [
  'atom-ctags',
  'autocomplete-clang',
  'editorconfig',
  'language-cmake', 'language-glsl', 'language-powershell',
  'linter', 'linter-alex',
  'minimap', 'minimap-autohide', 'minimap-codeglance', 'minimap-cursorline',
  'minimap-find-and-replace', 'minimap-git-diff', 'minimap-linter',
  'Zen',
]
atom_packages.each {|atom_package| atom_apm atom_package}
