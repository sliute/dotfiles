include_recipe 'lukecarrier::dnf_copr'

execute 'dnf copr enable -y churchyard/chromium-russianfedora'
package 'chromium'
