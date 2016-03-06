# Atom text editor

include_recipe 'atom'
package 'atom'

atom_packages = [
  'editorconfig',
  'language-powershell',
  'linter', 'linter-alex',
  'minimap',
]
atom_packages.each {|atom_package| atom_apm atom_package}
