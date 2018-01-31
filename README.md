Your shell must be initialised with the buildenv and lunch combo.

1. Clone the repository in the external directory of your AOSP tree

> git clone git@github.com:fdgonthier/Aosp-Node-Prebuilts.git

2. Run make with the architecture of your choice (currently arm64 or x86_64)

> make x86

3. Run 'mm' 

If you want the Android.mk to be executed automatically, add it as a dependency of another project.

To clean and do-over, run

> m clean-node
