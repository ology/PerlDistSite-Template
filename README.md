# PerlDistSite-Template
Template for a Web::PerlDistSite Instance

    # create the Blah-Blah tutorial directory
    mkdir blah-blah-tutorial

    # grab this template
    git clone https://github.com/ology/PerlDistSite-Template.git

    # go to the cloned checkout
    cd PerlDistSite-Template

    # install the program dependencies
    cpanm --installdeps .

    # create a new perl-dist site
    perl mirror-dist-site.pl --dest ~/sandbox/Blah-Blah/site --dist Blah-Blah

    # go to the new perl-dist site
    cd ~/sandbox/Blah-Blah/site

    # create the Blah-Blah tutorial
    ./clean-and-move.sh

And don't forget to exclude the site directory from your Blah-Blah CPAN uploads!
