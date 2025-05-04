# .latexmkrc – Configuration file for latexmk

# Set output directory to current directory (build/<template>)
$out_dir = '.';

# Enable glossary building
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
$clean_ext .= ' %R.auxlock %R.glsdefs';

sub makeglossaries {
    my ($base_name, $path) = fileparse(shift);
    return system("makeglossaries $base_name");
}