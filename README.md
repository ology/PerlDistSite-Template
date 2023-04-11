# PerlDistSite-Template
Template for a Web::PerlDistSite Instance

    # in a "~/sandbox" directory of repos...

    # create and clone a github pages Blah-Blah tutorial repo
    git clone https://github.com/you/blah-blah-tutorial.git

    # grab this template
    git clone https://github.com/ology/PerlDistSite-Template.git

    # go to the cloned checkout
    cd PerlDistSite-Template

    # install the program dependencies
    cpanm --installdeps .

    # create a new perl-dist-site under your Blah-Blah repo
    perl mirror-dist-site.pl --dest ~/sandbox/Blah-Blah/site --dist Blah-Blah

    # go to the perl-dist-site
    cd ~/sandbox/Blah-Blah/site

    # create the Blah-Blah tutorial
    ./clean-and-move.sh

    # go to the new tutorial directory
    cd ~/sandbox/blah-blah-tutorial

    # git add and commit the files
    git add * ; git commit -am 'Initial commit'

(And don't forget to exclude the site directory from future Blah-Blah CPAN uploads!)
