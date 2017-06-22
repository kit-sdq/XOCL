# XOCL
OCL-aligned extension for Java- or Xtend-based languages

XOCL lets you write code that looks like OCL but directly compiles to simple Java code without dynamic evaluation, interpretation or other indirections. More specifically, it provides many methods that are identical to common OCL methods and especially all collection operators ([ISO/IEC 19507:2012](http://www.omg.org/spec/OCL/ISO/19507/PDF) pp.156-168) and collection iterators (pp. 168-174).

To write such OCL-aligned code you have two possibilities:

1. import the OCL-aligned static methods as [static extension methods](https://eclipse.org/xtend/documentation/202_xtend_classes_members.html#extension-imports) and call them as if they were local methods of the first argument. Apart from minor differences such as dots instead of arrows or square brackets instead of parentheses this already results in a syntax that looks almost like OCL. An of course the OCL-aligned methods adhere to the semantics specified in the OCL standard.

2. call the OCL-aligned static methods in Java code. This way you still profit from the semantics of OCL methods but your syntax is far way from OCL.

## XOCL in Xtend via static extension imports

self.books->collect(loans
.member)

## XOCL extension methods
```java
import edu.kit.ipd.sdq.xocl.extensions.XOCLExtensionsAPI;
...
Library lib = ...
XOCLExtensionsAPI.collect(library.getBooks(), new Function1<Book, Member>() {
          @Override
          public Member apply(final Book it) {
           it.getLoans()
          }
        }
``



