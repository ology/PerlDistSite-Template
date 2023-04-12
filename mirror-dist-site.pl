#!/usr/bin/env perl

# Process Web::PerlDistSite files with replacements
# Example:
# cpanm Web::PerlDistSite
# git clone https://github.com/ology/PerlDistSite-Template.git
# cd PerlDistSite-Template
# perl mirror-dist-site.pl --who "Your Name" --user you \
#   --dest ~/repos/Blah-Blah/docs --dist Blah-Blah \
#   --manual Manual --abstract "Do All The Things!"
# cd ~/repos/Blah-Blah/docs
# make clean ; make all

use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use File::Basename qw(basename dirname);
use File::Copy::Recursive qw(fcopy dircopy);
use File::Path qw(make_path);
use File::Slurper qw(read_text write_text);

my %opt = (
    who       => 'Gene Boggs',
    user      => 'ology',
    source    => '.',
    dest      => './docs',
    dist      => undef, # must be hyphenated, not with colons
    abstract  => 'Frobnicate Universes',
    copyright => (localtime)[5] + 1900,
    manual    => 'Tutorial',
    dryrun    => 0,
);
GetOptions(\%opt,
    'who=s',
    'user=s',
    'source=s',
    'dest=s',
    'dist=s',
    'abstract=s',
    'copyright=s',
    'manual=s',
    'dryrun',
) or die 'Error parsing command options';

die "Invalid source directory.\n" unless $opt{source} && -e $opt{source};
die "Distribution not given.\n" unless $opt{dist};

my %replacement = (
    WHO       => $opt{who},
    USER      => $opt{user},
    COPYRIGHT => $opt{copyright},
    MANUAL    => $opt{manual},
    DIST      => $opt{dist},
    ABSTRACT  => $opt{abstract} || 'ABSTRACT',
);
$replacement{LC_MANUAL}     = lc $replacement{MANUAL},
$replacement{LC_DIST}       = lc $replacement{DIST};
$replacement{HTML_ABSTRACT} = $replacement{ABSTRACT};
($replacement{MODULE} = $replacement{DIST}) =~ s/-/::/g;

$opt{source} =~ s/\/$//;
$opt{dest}   =~ s/\/$//;

while (my $file = readline(DATA)) {
    chomp $file;

    my $source = "$opt{source}/$file";

    unless (-e $source) {
        warn "WARNING: $source does not exist: $!\n";
        next;
    }

    my $content = '';

    if (-f $source) {
        $content = read_text($source);
        for my $replace (keys %replacement) {
            if ($content =~ /<%\s*$replace\s*%>/) {
                $content =~ s/<%\s*$replace\s*%>/$replacement{$replace}/g;
                #print "Replace $replace in $source\n";
            }
        }
    }

    my $dir  = dirname($file);
    my $name = basename($file);

    $dir = '' if $dir eq '.';

    my $path = $opt{dest};
    $path .= "/$dir"  if $dir;
    $path .= "/$name" if -d $name;

    if (-d $source) {
        dircopy($source, $path) unless $opt{dryrun};
        print "Copied directory $source to $path\n";
    }
    elsif (-f $source) {
        make_path($path) unless $opt{dryrun} || -e $path;
        my $dest = "$path/$name";
        write_text($dest, $content) unless $opt{dryrun};
        print "Wrote file $source to $dest\n";
    }
}

__END__
clean-and-move.sh
config.yaml
custom.scss
images
Makefile
menu.yaml
package.json
_pages/index.md
_pages/installation.md
