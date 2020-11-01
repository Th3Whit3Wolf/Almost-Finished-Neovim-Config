syn keywork markdownRustStructure struct enum  nextgroup=markdownrustIdentifier skipwhite skipempty
syn keyword markdownRustKeyword   mod    trait nextgroup=markdownrustIdentifier skipwhite skipempty
syn keyword markdownRustAwait     await
syn match   markdownrustIdentifier  contains=rustIdentifierPrime "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained