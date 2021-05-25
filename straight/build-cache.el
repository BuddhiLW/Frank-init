
:tanat

"27.1"

#s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data ("org-elpa" ("2021-03-15 11:02:06" nil (:local-repo nil :package "org-elpa" :type git)) "melpa" ("2021-03-15 11:02:07" nil (:type git :host github :repo "melpa/melpa" :build nil :package "melpa" :local-repo "melpa")) "gnu-elpa-mirror" ("2021-03-15 11:02:07" nil (:type git :host github :repo "emacs-straight/gnu-elpa-mirror" :build nil :package "gnu-elpa-mirror" :local-repo "gnu-elpa-mirror")) "el-get" ("2021-03-15 11:02:07" nil (:type git :host github :repo "dimitri/el-get" :build nil :files ("*.el" ("recipes" "recipes/el-get.rcp") "methods" "el-get-pkg.el") :flavor melpa :package "el-get" :local-repo "el-get")) "emacsmirror-mirror" ("2021-03-15 11:02:07" nil (:type git :host github :repo "emacs-straight/emacsmirror-mirror" :build nil :package "emacsmirror-mirror" :local-repo "emacsmirror-mirror")) "straight" ("2021-03-15 10:59:46" ("emacs") (:type git :host github :repo "raxod502/straight.el" :files ("straight*.el") :branch "master" :package "straight" :local-repo "straight.el")) "emacs-piper" ("2021-03-15 11:00:01" nil (:type git :host gitlab :repo "howardabrams/emacs-piper" :package "emacs-piper" :local-repo "emacs-piper")) "el-patch" ("2021-03-15 11:00:04" ("emacs") (:type git :flavor melpa :host github :repo "raxod502/el-patch" :package "el-patch" :local-repo "el-patch"))))

#s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data ("straight" ((straight-autoloads straight straight-x) (autoload 'straight-get-recipe "straight" "Interactively select a recipe from one of the recipe repositories.
All recipe repositories in `straight-recipe-repositories' will
first be cloned. After the recipe is selected, it will be copied
to the kill ring. With a prefix argument, first prompt for a
recipe repository to search. Only that repository will be
cloned.

From Lisp code, SOURCES should be a subset of the symbols in
`straight-recipe-repositories'. Only those recipe repositories
are cloned and searched. If it is nil or omitted, then the value
of `straight-recipe-repositories' is used. If SOURCES is the
symbol `interactive', then the user is prompted to select a
recipe repository, and a list containing that recipe repository
is used for the value of SOURCES. ACTION may be `copy' (copy
recipe to the kill ring), `insert' (insert at point), or nil (no
action, just return it).

(fn &optional SOURCES ACTION)" t nil) (autoload 'straight-visit-package-website "straight" "Interactively select a recipe, and visit the package's website." t nil) (autoload 'straight-use-package "straight" "Register, clone, build, and activate a package and its dependencies.
This is the main entry point to the functionality of straight.el.

MELPA-STYLE-RECIPE is either a symbol naming a package, or a list
whose car is a symbol naming a package and whose cdr is a
property list containing e.g. `:type', `:local-repo', `:files',
and VC backend specific keywords.

First, the package recipe is registered with straight.el. If
NO-CLONE is a function, then it is called with two arguments: the
package name as a string, and a boolean value indicating whether
the local repository for the package is available. In that case,
the return value of the function is used as the value of NO-CLONE
instead. In any case, if NO-CLONE is non-nil, then processing
stops here.

Otherwise, the repository is cloned, if it is missing. If
NO-BUILD is a function, then it is called with one argument: the
package name as a string. In that case, the return value of the
function is used as the value of NO-BUILD instead. In any case,
if NO-BUILD is non-nil, then processing halts here. Otherwise,
the package is built and activated. Note that if the package
recipe has a nil `:build' entry, then NO-BUILD is ignored
and processing always stops before building and activation
occurs.

CAUSE is a string explaining the reason why
`straight-use-package' has been called. It is for internal use
only, and is used to construct progress messages. INTERACTIVE is
non-nil if the function has been called interactively. It is for
internal use only, and is used to determine whether to show a
hint about how to install the package permanently.

Return non-nil if package was actually installed, and nil
otherwise (this can only happen if NO-CLONE is non-nil).

(fn MELPA-STYLE-RECIPE &optional NO-CLONE NO-BUILD CAUSE INTERACTIVE)" t nil) (autoload 'straight-register-package "straight" "Register a package without cloning, building, or activating it.
This function is equivalent to calling `straight-use-package'
with a non-nil argument for NO-CLONE. It is provided for
convenience. MELPA-STYLE-RECIPE is as for
`straight-use-package'.

(fn MELPA-STYLE-RECIPE)" nil nil) (autoload 'straight-use-package-no-build "straight" "Register and clone a package without building it.
This function is equivalent to calling `straight-use-package'
with nil for NO-CLONE but a non-nil argument for NO-BUILD. It is
provided for convenience. MELPA-STYLE-RECIPE is as for
`straight-use-package'.

(fn MELPA-STYLE-RECIPE)" nil nil) (autoload 'straight-use-package-lazy "straight" "Register, build, and activate a package if it is already cloned.
This function is equivalent to calling `straight-use-package'
with symbol `lazy' for NO-CLONE. It is provided for convenience.
MELPA-STYLE-RECIPE is as for `straight-use-package'.

(fn MELPA-STYLE-RECIPE)" nil nil) (autoload 'straight-use-recipes "straight" "Register a recipe repository using MELPA-STYLE-RECIPE.
This registers the recipe and builds it if it is already cloned.
Note that you probably want the recipe for a recipe repository to
include a nil `:build' property, to unconditionally
inhibit the build phase.

This function also adds the recipe repository to
`straight-recipe-repositories', at the end of the list.

(fn MELPA-STYLE-RECIPE)" nil nil) (autoload 'straight-override-recipe "straight" "Register MELPA-STYLE-RECIPE as a recipe override.
This puts it in `straight-recipe-overrides', depending on the
value of `straight-current-profile'.

(fn MELPA-STYLE-RECIPE)" nil nil) (autoload 'straight-check-package "straight" "Rebuild a PACKAGE if it has been modified.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. See also `straight-rebuild-package' and
`straight-check-all'.

(fn PACKAGE)" t nil) (autoload 'straight-check-all "straight" "Rebuild any packages that have been modified.
See also `straight-rebuild-all' and `straight-check-package'.
This function should not be called during init." t nil) (autoload 'straight-rebuild-package "straight" "Rebuild a PACKAGE.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument RECURSIVE, rebuild
all dependencies as well. See also `straight-check-package' and
`straight-rebuild-all'.

(fn PACKAGE &optional RECURSIVE)" t nil) (autoload 'straight-rebuild-all "straight" "Rebuild all packages.
See also `straight-check-all' and `straight-rebuild-package'." t nil) (autoload 'straight-prune-build-cache "straight" "Prune the build cache.
This means that only packages that were built in the last init
run and subsequent interactive session will remain; other
packages will have their build mtime information and any cached
autoloads discarded." nil nil) (autoload 'straight-prune-build-directory "straight" "Prune the build directory.
This means that only packages that were built in the last init
run and subsequent interactive session will remain; other
packages will have their build directories deleted." nil nil) (autoload 'straight-prune-build "straight" "Prune the build cache and build directory.
This means that only packages that were built in the last init
run and subsequent interactive session will remain; other
packages will have their build mtime information discarded and
their build directories deleted." t nil) (autoload 'straight-normalize-package "straight" "Normalize a PACKAGE's local repository to its recipe's configuration.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'.

(fn PACKAGE)" t nil) (autoload 'straight-normalize-all "straight" "Normalize all packages. See `straight-normalize-package'.
Return a list of recipes for packages that were not successfully
normalized. If multiple packages come from the same local
repository, only one is normalized.

PREDICATE, if provided, filters the packages that are normalized.
It is called with the package name as a string, and should return
non-nil if the package should actually be normalized.

(fn &optional PREDICATE)" t nil) (autoload 'straight-fetch-package "straight" "Try to fetch a PACKAGE from the primary remote.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM,
fetch not just from primary remote but also from upstream (for
forked packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t nil) (autoload 'straight-fetch-package-and-deps "straight" "Try to fetch a PACKAGE and its (transitive) dependencies.
PACKAGE, its dependencies, their dependencies, etc. are fetched
from their primary remotes.

PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM,
fetch not just from primary remote but also from upstream (for
forked packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t nil) (autoload 'straight-fetch-all "straight" "Try to fetch all packages from their primary remotes.
With prefix argument FROM-UPSTREAM, fetch not just from primary
remotes but also from upstreams (for forked packages).

Return a list of recipes for packages that were not successfully
fetched. If multiple packages come from the same local
repository, only one is fetched.

PREDICATE, if provided, filters the packages that are fetched. It
is called with the package name as a string, and should return
non-nil if the package should actually be fetched.

(fn &optional FROM-UPSTREAM PREDICATE)" t nil) (autoload 'straight-merge-package "straight" "Try to merge a PACKAGE from the primary remote.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM,
merge not just from primary remote but also from upstream (for
forked packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t nil) (autoload 'straight-merge-package-and-deps "straight" "Try to merge a PACKAGE and its (transitive) dependencies.
PACKAGE, its dependencies, their dependencies, etc. are merged
from their primary remotes.

PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM,
merge not just from primary remote but also from upstream (for
forked packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t nil) (autoload 'straight-merge-all "straight" "Try to merge all packages from their primary remotes.
With prefix argument FROM-UPSTREAM, merge not just from primary
remotes but also from upstreams (for forked packages).

Return a list of recipes for packages that were not successfully
merged. If multiple packages come from the same local
repository, only one is merged.

PREDICATE, if provided, filters the packages that are merged. It
is called with the package name as a string, and should return
non-nil if the package should actually be merged.

(fn &optional FROM-UPSTREAM PREDICATE)" t nil) (autoload 'straight-pull-package "straight" "Try to pull a PACKAGE from the primary remote.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM, pull
not just from primary remote but also from upstream (for forked
packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t nil) (autoload 'straight-pull-package-and-deps "straight" "Try to pull a PACKAGE and its (transitive) dependencies.
PACKAGE, its dependencies, their dependencies, etc. are pulled
from their primary remotes.

PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM,
pull not just from primary remote but also from upstream (for
forked packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t nil) (autoload 'straight-pull-all "straight" "Try to pull all packages from their primary remotes.
With prefix argument FROM-UPSTREAM, pull not just from primary
remotes but also from upstreams (for forked packages).

Return a list of recipes for packages that were not successfully
pulled. If multiple packages come from the same local repository,
only one is pulled.

PREDICATE, if provided, filters the packages that are pulled. It
is called with the package name as a string, and should return
non-nil if the package should actually be pulled.

(fn &optional FROM-UPSTREAM PREDICATE)" t nil) (autoload 'straight-push-package "straight" "Push a PACKAGE to its primary remote, if necessary.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'.

(fn PACKAGE)" t nil) (autoload 'straight-push-all "straight" "Try to push all packages to their primary remotes.

Return a list of recipes for packages that were not successfully
pushed. If multiple packages come from the same local repository,
only one is pushed.

PREDICATE, if provided, filters the packages that are normalized.
It is called with the package name as a string, and should return
non-nil if the package should actually be normalized.

(fn &optional PREDICATE)" t nil) (autoload 'straight-freeze-versions "straight" "Write version lockfiles for currently activated packages.
This implies first pushing all packages that have unpushed local
changes. If the package management system has been used since the
last time the init-file was reloaded, offer to fix the situation
by reloading the init-file again. If FORCE is
non-nil (interactively, if a prefix argument is provided), skip
all checks and write the lockfile anyway.

Currently, writing version lockfiles requires cloning all lazily
installed packages. Hopefully, this inconvenient requirement will
be removed in the future.

Multiple lockfiles may be written (one for each profile),
according to the value of `straight-profiles'.

(fn &optional FORCE)" t nil) (autoload 'straight-thaw-versions "straight" "Read version lockfiles and restore package versions to those listed." t nil) (autoload 'straight-bug-report "straight" "Test straight.el in a clean environment.
ARGS may be any of the following keywords and their respective values:
  - :pre-bootstrap (Form)...
      Forms evaluated before bootstrapping straight.el
      e.g. (setq straight-repository-branch \"develop\")
      Note this example is already in the default bootstrapping code.

  - :post-bootstrap (Form)...
      Forms evaluated in the testing environment after boostrapping.
      e.g. (straight-use-package '(example :type git :host github))

  - :interactive Boolean
      If nil, the subprocess will immediately exit after the test.
      Output will be printed to `straight-bug-report--process-buffer'
      Otherwise, the subprocess will be interactive.

  - :preserve Boolean
      If non-nil, the test directory is left in the directory stored in the
      variable `temporary-file-directory'. Otherwise, it is
      immediately removed after the test is run.

  - :executable String
      Indicate the Emacs executable to launch.
      Defaults to the path of the current Emacs executable.

  - :raw Boolean
      If non-nil, the raw process output is sent to
      `straight-bug-report--process-buffer'. Otherwise, it is
      formatted as markdown for submitting as an issue.

  - :user-dir String
      If non-nil, the test is run with `user-emacs-directory' set to STRING.
      Otherwise, a temporary directory is created and used.
      Unless absolute, paths are expanded relative to the variable
      `temporary-file-directory'.

ARGS are accessible within the :pre/:post-bootsrap phases via the
locally bound plist, straight-bug-report-args.

(fn &rest ARGS)" nil t) (function-put 'straight-bug-report 'lisp-indent-function '0) (if (fboundp 'register-definition-prefixes) (register-definition-prefixes "straight" '("straight-"))) (defvar straight-x-pinned-packages nil "List of pinned packages.") (if (fboundp 'register-definition-prefixes) (register-definition-prefixes "straight-x" '("straight-x-"))) (provide 'straight-autoloads)) "emacs-piper" ((emacs-piper-autoloads source-environment piper piper-script piper-operations) (if (fboundp 'register-definition-prefixes) (register-definition-prefixes "piper" '("eshell/piper" "hydra-piper" "piper"))) (if (fboundp 'register-definition-prefixes) (register-definition-prefixes "piper-operations" '("piper-script-"))) (if (fboundp 'register-definition-prefixes) (register-definition-prefixes "piper-script" '("piper-" "process-file-region" "shell-command-to-list"))) (if (fboundp 'register-definition-prefixes) (register-definition-prefixes "source-environment" '("source-environment"))) (provide 'emacs-piper-autoloads)) "el-patch" ((el-patch-autoloads el-patch) (let ((loads (get 'el-patch 'custom-loads))) (if (member '"el-patch" loads) nil (put 'el-patch 'custom-loads (cons '"el-patch" loads)))) (defvar el-patch-deftype-alist nil "Alist of types of definitions that can be patched with `el-patch'.
The keys are definition types, like `defun', `define-minor-mode',
etc. The values are plists; the following keywords are accepted:

`:classify' - a function which may be called with a full
definition form (a list starting with e.g. `defun') and which
returns an alist detailing what it defines. In this alist, the
keys are symbols; only the values `function' and `variable' are
allowed. The values are names of functions and variables,
respectively, that are defined by the definition form. This
argument is mandatory.

`:locate' - a function which may be called with a full definition
form (a list starting with e.g. `defun') and which returns the
actual source code of the definition, as a list. If the patch
correct and up to date, then this will actually be the same as
the definition which was passed in. This argument is optional,
but required if you want patch validation to work.

`:declare' - a list to be put in a `declare' form of the
resulting `el-patch' macro, like:

    ((doc-string 2) (indent defun))

This argument is optional.

`:macro-name' - normally the name of the macro generated for
patching a `defun' is called `el-patch-defun', but you can
override that by providing this argument. This argument is
optional.") (custom-autoload 'el-patch-deftype-alist "el-patch" t) (defvar el-patch--patches (make-hash-table :test 'equal) "Hash table of patches that have been defined.
The keys are symbols naming the objects that have been patched.
The values are hash tables mapping definition types (symbols
`defun', `defmacro', etc.) to patch definitions, which are lists
beginning with `defun', `defmacro', etc.

Note that the symbols are from the versions of patches that have
been resolved in favor of the modified version, when a patch
renames a symbol.") (autoload 'el-patch-add "el-patch" "Patch directive for inserting forms.
In the original definition, the ARGS and their containing form
are removed. In the new definition, the ARGS are spliced into the
containing s-expression.

(fn &rest ARGS)" nil t) (function-put 'el-patch-add 'lisp-indent-function '0) (autoload 'el-patch-remove "el-patch" "Patch directive for removing forms.
In the original definition, the ARGS are spliced into the
containing s-expression. In the new definition, the ARGS and
their containing form are removed.

(fn &rest ARGS)" nil t) (function-put 'el-patch-remove 'lisp-indent-function '0) (autoload 'el-patch-swap "el-patch" "Patch directive for swapping forms.
In the original definition, OLD is spliced into the containing
s-expression. In the new definition, NEW is spliced instead.

(fn OLD NEW)" nil t) (function-put 'el-patch-swap 'lisp-indent-function '0) (autoload 'el-patch-wrap "el-patch" "Patch directive for wrapping forms.
TRIML and TRIMR are optional arguments. If only one is provided,
it is assumed to be TRIML. ARGS is required, and it must be a
list.

In the original definition, the ARGS are spliced into the
containing s-expression. If TRIML is provided, the first TRIML of
the ARGS are removed first. If TRIMR is provided, the last TRIMR
are also removed. In the new definition, the ARGS and their
containing list are spliced into the containing s-expression.

(fn &optional TRIML TRIMR ARGS)" nil t) (function-put 'el-patch-wrap 'lisp-indent-function 'defun) (autoload 'el-patch-splice "el-patch" "Patch directive for splicing forms.
TRIML and TRIMR are optional arguments. If only one is provided,
it is assumed to be TRIML. ARGS is required, and it must be a
list.

In the original definition, the ARGS and their containing list
are spliced into the containing s-expression. In the new
definition, the ARGS are spliced into the containing
s-expression. If TRIML is provided, the first TRIML of the ARGS
are removed first. If TRIMR is provided, the last TRIMR are also
removed.

(fn &optional TRIML TRIMR ARGS)" nil t) (function-put 'el-patch-splice 'lisp-indent-function 'defun) (autoload 'el-patch-let "el-patch" "Patch directive for creating local el-patch bindings.
Creates local bindings according to VARLIST, then splices ARGS
into both the original and new definitions. You may bind symbols
that are also patch directives, but the bindings will not have
effect if the symbols are used at the beginning of a list (they
will act as patch directives).

(fn VARLIST &rest ARGS)" nil t) (function-put 'el-patch-let 'lisp-indent-function '1) (autoload 'el-patch-literal "el-patch" "Patch directive for treating patch directives literally.
ARGS are spliced into the containing s-expression, but are not
processed further by el-patch.

(fn &rest ARGS)" nil t) (function-put 'el-patch-literal 'lisp-indent-function '0) (autoload 'el-patch-concat "el-patch" "Patch directive for modifying string literals.
ARGS should resolve to strings; those strings are passed to
`concat' and spliced into the containing s-expression in both the
original and new definitions.

(fn &rest ARGS)" nil t) (function-put 'el-patch-concat 'lisp-indent-function '0) (autoload 'el-patch--definition "el-patch" "Activate a PATCH-DEFINITION and update `el-patch--patches'.
PATCH-DEFINITION is an unquoted list starting with `defun',
`defmacro', etc., which may contain patch directives.

(fn PATCH-DEFINITION)" nil t) (autoload 'el-patch-unpatch "el-patch" "Remove the patch given by the PATCH-DEFINITION.
This restores the original functionality of the object being
patched. NAME and TYPE are as returned by `el-patch-get'.

(fn NAME TYPE)" t nil) (cl-defmacro el-patch-deftype (type &rest kwargs &key classify locate declare macro-name) "Allow `el-patch' to patch definitions of the given TYPE.
TYPE is a symbol like `defun', `define-minor-mode', etc. This
updates `el-patch-deftype-alist' (which see) with the provided
keyword arguments and defines a macro named like
`el-patch-defun', `el-patch-define-minor-mode', etc." (declare (indent defun)) (ignore locate) (unless classify (error "You must specify `:classify' in calls to `el-patch-deftype'")) `(progn (setf (alist-get ',type el-patch-deftype-alist) (copy-tree ',kwargs)) (defmacro ,(or macro-name (intern (format "el-patch-%S" type))) (name &rest args) ,(format "Use `el-patch' to override a `%S' form.
The ARGS are the same as for `%S'." type type) ,@(when declare `((declare ,@declare))) (list #'el-patch--definition (cl-list* ',type name args))))) (el-patch-deftype cl-defun :classify el-patch-classify-function :locate el-patch-locate-function :declare ((doc-string 3) (indent defun))) (el-patch-deftype defconst :classify el-patch-classify-variable :locate el-patch-locate-variable :declare ((doc-string 3) (indent defun))) (el-patch-deftype defcustom :classify el-patch-classify-variable :locate el-patch-locate-variable :declare ((doc-string 3) (indent defun))) (el-patch-deftype define-minor-mode :classify el-patch-classify-define-minor-mode :locate el-patch-locate-function :declare ((doc-string 2) (indent defun))) (el-patch-deftype defmacro :classify el-patch-classify-function :locate el-patch-locate-function :declare ((doc-string 3) (indent defun))) (el-patch-deftype defsubst :classify el-patch-classify-function :locate el-patch-locate-function :declare ((doc-string 3) (indent defun))) (el-patch-deftype defun :classify el-patch-classify-function :locate el-patch-locate-function :declare ((doc-string 3) (indent defun))) (el-patch-deftype defvar :classify el-patch-classify-variable :locate el-patch-locate-variable :declare ((doc-string 3) (indent defun))) (autoload 'el-patch-validate "el-patch" "Validate the patch with given NAME and TYPE.
This means el-patch will attempt to find the original definition
for the function, and verify that it is the same as the original
function assumed by the patch. A warning will be signaled if the
original definition for a patched function cannot be found, or if
there is a difference between the actual and expected original
definitions.

Interactively, use `completing-read' to select a function to
inspect the patch of.

NAME is a symbol naming the object being patched; TYPE is a
symbol `defun', `defmacro', etc.

Returns nil if the patch is not valid, and otherwise returns t.
If NOMSG is non-nil, does not signal a message when the patch is
valid.

If RUN-HOOKS is non-nil, runs `el-patch-pre-validate-hook' and
`el-patch-post-validate-hook'. Interactively, this happens unless
a prefix argument is provided.

See also `el-patch-validate-all'.

(fn NAME TYPE &optional NOMSG RUN-HOOKS)" t nil) (autoload 'el-patch-validate-all "el-patch" "Validate all currently defined patches.
Runs `el-patch-pre-validate-hook' and
`el-patch-post-validate-hook'.

See `el-patch-validate'." t nil) (autoload 'el-patch-feature "el-patch" "Declare that some patches are only defined after FEATURE is loaded.
This is a convenience macro that creates a function for invoking
`require' on that feature, and then adds it to
`el-patch-pre-validate-hook' so that your patches are loaded and
`el-patch' can properly validate them.

FEATURE should be an unquoted symbol. ARGS, if given, are passed
as quoted literals along with FEATURE to
`el-patch-require-function' when `el-patch-validate-all' is
called.

(fn FEATURE &rest ARGS)" nil t) (autoload 'el-patch-get "el-patch" "Return the patch for object NAME of the given TYPE.
NAME is a symbol for the name of the definition that was patched,
and TYPE is a symbol `defun', `defmacro', etc. If the patch could
not be found, return nil.

(fn NAME TYPE)" nil nil) (autoload 'el-patch-ediff-patch "el-patch" "Show the patch for an object in Ediff.
NAME and TYPE are as returned by `el-patch-get'.

(fn NAME TYPE)" t nil) (autoload 'el-patch-ediff-conflict "el-patch" "Show a patch conflict in Ediff.
This is a diff between the expected and actual values of a
patch's original definition. NAME and TYPE are as returned by
`el-patch-get'.

(fn NAME TYPE)" t nil) (if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-patch" '("el-patch-"))) (provide 'el-patch-autoloads))))

#s(hash-table size 65 test eq rehash-size 1.5 rehash-threshold 0.8125 data (org-elpa #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 7 "melpa" nil "gnu-elpa-mirror" nil "el-get" nil "emacsmirror-mirror" nil "straight" nil "emacs-piper" nil "el-patch" nil)) melpa #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 2 "gnu-elpa-mirror" nil "el-get" (el-get :type git :flavor melpa :files ("*.el" ("recipes" "recipes/el-get.rcp") "methods" "el-get-pkg.el") :host github :repo "dimitri/el-get") "emacsmirror-mirror" nil "straight" nil "emacs-piper" nil "el-patch" (el-patch :type git :flavor melpa :host github :repo "raxod502/el-patch"))) gnu-elpa-mirror #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 3 "emacsmirror-mirror" nil "straight" nil "emacs-piper" nil)) el-get #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 1 "emacsmirror-mirror" nil "straight" nil "emacs-piper" nil)) emacsmirror-mirror #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 2 "straight" (straight :type git :host github :repo "emacsmirror/straight") "emacs-piper" nil))))

("org-elpa" "melpa" "gnu-elpa-mirror" "el-get" "emacsmirror-mirror" "straight")

t
