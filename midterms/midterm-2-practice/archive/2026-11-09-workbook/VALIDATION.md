# Validation (November 9, 2026)

- Compiled `study-guide.tex` with portable Tectonic 0.17.0, producing the
  25-page `study-guide.pdf`. Ran `build.ps1` successfully using cached resources.
- The final LaTeX log has no overfull/underfull boxes, warnings, or errors.
- Rendered the PDF pages and visually reviewed the layout, including the type
  questions, code blocks, loop program, mixed set, and reference. The mixed
  set's five questions each begin on a separate page. Code blocks stay together.
- Checked text extraction for answer areas, all five mixed question headings,
  Haskell operators, and spaces in inline code. The PDF is a reading copy,
  with no interactive form fields; answers are edited in the LaTeX source.
- GHC 9.10.3 loaded all eight optional practice modules and two support modules
  with `-fno-code -fforce-recomp -Wall`. The unfinished State exercise modules
  have expected unused-import warnings for operations the learner will use.
- Executed 13 checks of supplied State operations, supplied recursive helpers,
  list enumeration, empty-action behavior, and function-valued State tracing;
  all passed. These checks exercise infrastructure, not learner implementations.
- Verified the archived original practice against its Git contents (normalizing
  line endings). The source sample remains untouched.

Learner implementations intentionally remain `undefined`. Their example checks
are not claimed to pass, and no answer key is included. The optional Cabal file
describes the support library only; Cabal dependency resolution was not tested.
Exam scope, timing, rules, and future questions remain unconfirmed.
