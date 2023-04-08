#!/usr/bin/env perl
use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use File::Basename qw(basename dirname);
use File::Copy::Recursive qw(fcopy dircopy);
use File::Path qw(make_path);
use File::Slurper qw(read_text write_text);

my %opt = (
    user     => 'ology',
    source   => '.',
    dest     => '.',
    dist     => 'Foo-Bar',
    abstract => 'Frobnicate Universes',
);
GetOptions(\%opt,
    'source=s',
    'dest=s',
    'dist=s',
    'abstract=s',
) or die 'Error parsing command options';

die "Source directory not given.\n" unless $opt{source};
die "Distribution not given.\n" unless $opt{dist};

my %replacement;
$replacement{DIST} = $opt{dist};
$replacement{LC_DIST} = lc $replacement{DIST};
($replacement{MODULE} = $replacement{DIST}) =~ s/-/::/g;
$replacement{ABSTRACT} = $opt{abstract} || 'ABSTRACT';
$replacement{HTML_ABSTRACT} = $replacement{ABSTRACT};

$opt{source} =~ s/\/$//;
$opt{dest} =~ s/\/$//;

while (my $line = readline(DATA)) {
    chomp $line;

    my ($file, $to) = split /\s+/, $line;

    my $name = basename($file);

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
                print "Replaced $replace in $source\n";
            }
        }
    }

    $to ||= '';
    $to =~ s/\/$//;

    if (-d $source) {
        $to = $to ? "$to/$name" : $name;
    }

    my $path = "$opt{dest}/$replacement{LC_DIST}";
    $path .= "/$to" if $to;

    if (-d $source) {
        dircopy($source, $path);
        print "Copied $source to $path\n";
    }
    elsif (-f $source) {
        make_path($path) unless -e $path;
        my $dest = "$path/$name";
        write_text($dest, $content);
        print "Wrote $source to $dest\n";
    }
}

__END__
config.yaml
custom.scss
images
Makefile
menu.yaml
package.json
_pages/index.md
_pages/installation.md
README.md
