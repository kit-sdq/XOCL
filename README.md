# XOCL
OCL-aligned extension for Xtend- or Java-based languages

XOCL lets you write code that looks like OCL but directly compiles to simple Java code without dynamic evaluation, interpretation or other indirections. More specifically, it provides many methods that are identical to common OCL methods and especially all collection operators ([ISO/IEC 19507:2012](http://www.omg.org/spec/OCL/ISO/19507/PDF) pp.156-168) and collection iterators (pp. 168-174). All OCL-aligned methods of XOCL adhere---of course--- to the semantics specified in the OCL standard.

To write such OCL-aligned code you have two possibilities:

1. import the OCL-aligned static methods as [static extension methods](https://eclipse.org/xtend/documentation/202_xtend_classes_members.html#extension-imports) and call them as if they were local methods of the first argument. 

2. call the OCL-aligned static methods in Java code. This way you still profit from the semantics of OCL methods but your syntax is far away from OCL (See below).

## Installation
* Even if you already have an Eclipse you should always download a new Eclipse for XOCL (in order not to mix up versions).
* Download and run a clean [**Oxygen** Release of the **Eclipse** IDE for Java and **DSL Developers*](https://www.eclipse.org/downloads/packages/eclipse-ide-java-and-dsl-developers/oxygen/R). Do not use another Eclipse Package, i.e. also not the one for Java developers.
* Install the XOCL plug-ins from the [nightly update site](https://kit-sdq.github.io/updatesite/nightly/xocl)
  * Help - Install New Software... - Add... (paste the URL from above, it only works in Eclipse)

## 1. Calling XOCL in Xtend code via static extension imports
Thanks to Xtend's [extension method mechanism](https://eclipse.org/xtend/documentation/202_xtend_classes_members.html#extension-methods) and [nice syntax for lambdas](https://www.eclipse.org/xtend/documentation/203_xtend_expressions.html#lambdas) your Xtend code will be very close to OCL after a single import:
```java
import static extension edu.kit.ipd.sdq.xocl.extensions.XOCLExtensionsAPI.*
...
val library = ...
library.books.forAll[loans.size() <= copies.intValue]
```
This usage of XOCL methods via Xtend's extension mechanism already results in a syntax that looks almost like OCL. (Apart from minor differences, such as dots instead of arrows or square brackets instead of parentheses.) The same code written in OCL would be as follows:
```ocl
library.books->forAll(loans->size() <= copies)
``` 

## 2. Calling XOCL extension methods in Java code
As XOCL was designed for Xtend the extension methods use Xtend's equivalent to the Java Stream API. Therefore, using XOCL methods in Java code is currently more cumbersome than it would need to be:
```java
import edu.kit.ipd.sdq.xocl.extensions.XOCLExtensionsAPI;
...
Library library = ...
XOCLExtensionsAPI.forAll(library.getBooks(), new Function1<Book, Boolean>() {
          @Override
          public Boolean apply(final Book it) {
                    return it.getLoans().size() <= it.getCopies().intValue();
	}
});
```



