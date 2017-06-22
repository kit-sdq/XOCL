 /*******************************************************************************
 * Copyright (c) 2015-2017 Sebastian Fiss, Max Kramer.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *    Max Kramer - extension methods
 *    Sebastian Fiss - initial API and implementation and/or initial documentation of OCL extensions
 *******************************************************************************/
package edu.kit.ipd.sdq.xocl.extensions

import com.google.common.collect.Iterables
import java.util.ArrayList
import java.util.Collection
import java.util.HashMap
import java.util.List
import java.util.Map
import java.util.Set
import org.eclipse.xtext.xbase.lib.Functions.Function1

import static extension edu.kit.ipd.sdq.xocl.extensions.ListXOCLExtensions.*
import static extension edu.kit.ipd.sdq.xocl.extensions.NumberXOCLExtensions.operator_plus
import static extension edu.kit.ipd.sdq.xocl.extensions.ObjectXOCLExtensions.*
import com.google.common.collect.Lists
import com.google.common.collect.Sets
import org.eclipse.xtext.xbase.lib.Functions.Function2

/**
 * A utility class providing OCL-aligned extension methods for Iterables
 * 
 */
class IterableXOCLExtensions {
	/** Utility classes should not have a public or default constructor. */
	private new() {
	}
	
	
	/**
	 * OCL-equivalent returning true if object is an element of the collection, false otherwise. (see OCL v2.4, section 11.7.1)
	 */
	@Pure
	def static <T> boolean includes(Iterable<? super T> collection, T element) {
		return collection.toList.contains(element)
	}
	
	/**
	 * OCL-equivalent returning true if object is not an element of the collection, false otherwise. (see OCL v2.4, section 11.7.1)
	 */
	@Pure
	public static def <T> boolean excludes(Iterable<? super T> collection, T element) {
		return !includes(collection, element)
	}
		
	/**
	 * OCL-equivalent returning the number of times the element occurs in the collection. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T> int count(Iterable<? super T> collection, T element) {
		var count = 0
		for (pivot : collection) {
			if (pivot == element) {
				count++
			}
		}
		return count
	}
	
	/**
	 * OCL-equivalent returning true if collection contains all the elements of collection2. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T> boolean includesAll(Iterable<? super T> collection, Collection<T> collection2) {
		return collection.toList.containsAll(collection2)
	}
	
	/**
	 * OCL-equivalent returning true if collection contains none of the elements of collection2. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T> boolean excludesAll(Iterable<? super T> collection, Iterable<T> collection2) {
		return collection2.map[collection.excludes(it)].forall[it]
	}
	
	/**
	 * OCL-equivalent returning true if collection is the empty collection. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static boolean isEmpty(Iterable<?> collection) {
		return !collection.iterator().hasNext
	}
	
	/**
	 * OCL-equivalent returning true if collection is not the empty collection. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static boolean notEmpty(Iterable<?> collection) {
		return !isEmpty(collection)
	}
	
	/**
	 * OCL-equivalent returning the element with the maximum value of all elements in the collection. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T extends Comparable<? super T>> Object max(Iterable<T> collection) {
		return IterableExtensions.max(collection)
	}
	
	/**
	 * OCL-equivalent returning the element with the minimum value of all elements in the collection. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T extends Comparable<? super T>> Object min(Iterable<T> collection) {
		return IterableExtensions.min(collection)
	}
		
	/**
	 * OCL-equivalent returning the addition of all elements in the collection. (see OCL v2.4, section 11.7.1)	
	 * All elements have to be of the following types: 
	 * BigDecimal, BigInteger, Double, Float, Long, Integer, Short, or Byte,
	 * otherwise an UnsupportedOperationException is thrown.
	 * Currently subclasses of Number starting with Atomic, Striped, or Unsigned
	 * are currently not supported. Furthermore, BigDecimal and BigInteger are
	 * only supported if all elements are of one of both types.
	 */
	@Pure
	def static Number sum(Iterable<? extends Number> collection) {
		var Number sum = null
		for (Number number : collection) {
			if (sum == null) {
				sum = number
			} else {
				sum = sum.operator_plus(number)
			}
		}
		return sum
	}
	
	/**
	 * OCL-equivalent returning the element type if it is not a collection type, otherwise a collection 
	 * containing all the elements of all the recursively flattened elements of self (see OCL v2.4, section 11.7.1)	
	 */
	@Pure // this annotation is the only reason why we have to provide this delegator
	def static <T> Iterable<T> flatten(Iterable<? extends Iterable<? extends T>> iterable) {
		return IterableExtensions.flatten(iterable)
	}
	
	/**
	 * OCL-equivalent returning the number of elements in the collection (see OCL v2.4, section 11.7.1)	
	 */
	@Pure // this annotation is the only reason why we have to provide this delegator
	def static int size(Iterable<?> iterable) {
		return IterableExtensions.size(iterable)
	}
	
	/**
	 * OCL-equivalent returning the cartesian product operation of both collections. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T1, T2> Map<T1, T2> product(Iterable<T1> collection1,
		Iterable<T2> collection2) {
		val cartesianProductMap = new HashMap()
		collection1.forEach[e1 |
			collection2.forEach[e2 |
				cartesianProductMap.put(e1, e2)
			]
		]
		return cartesianProductMap
	}
	
	/**
	 * OCL-equivalent returning the sub-collection containing the non-null elements 
	 * whose type is the specified type or a subtype of it. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T> Iterable<T> selectByKind(Iterable<? super T> collection, Class<T> type) {
		return collection.filter(type)
	}
	
	/**
	 * OCL-equivalent returning the sub-collection containing the non-null elements 
	 * whose type is the specified type but not a subtype of it. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T> Iterable<T> selectByType(Iterable<? super T> collection, Class<T> type) {
		return selectByKind(collection, type).filter[it.oclIsTypeOf(type)]
	}
	
	/**
	 * OCL-equivalent returning the Set containing all the elements from the collection, 
	 * with duplicates removed. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T> Set<T> asSet(Iterable<T> collection) {
		return collection.toSet
	}
	
	/**
	 * OCL-equivalent returning an ordered set that contains all the elements from the collection, 
	 * with duplicates removed, in an order dependent on the particular concrete collection type.
	 * (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T extends Comparable<? super T>> List<T> asOrderedSet(Iterable<T> collection) {
		return asSet(collection).sort()
	}
	
	/**
	 * OCL-equivalent returning a sequence that contains all the elements from self, 
	 * in an order dependent on the particular concrete collection type. (see OCL v2.4, section 11.7.1)	
	 */
	@Pure
	def static <T extends Comparable<? super T>> List<T> asSequence(Iterable<T> collection) {
		return collection.toList.sort()
	}
	
	/**
	 * OCL-equivalent returning the bag that contains all the elements from the collection.
	 * (see OCL v2.4, section 11.7.1)
	 * <p>
	 * <strong>Attention:</strong> to avoid a dependency to Guava's MultiSet the returned bag is currently
	 * an ArrayList which does not support order-independent equality!
	 * </p>
	 */
	@Pure
	def static <T> Collection<T> asBag(Iterable<T> collection) {
		return collection.toList
	}
	
	/**
	 * OCL-equivalent returning the union of both bags (see OCL v2.4, section 11.7.4)
	 */
	@Pure 
	def static <T> Iterable<T> union(Iterable<T> iterable1, Iterable<T> iterable2) {
		return Iterables.concat(iterable1, iterable2)
	}
	
	/**
	 * OCL-equivalent returning the intersection of both bags (see OCL v2.4, section 11.7.4)
	 */
	@Pure
	def static <T> Iterable<T> intersection(Iterable<T> iterable1, Iterable<T> iterable2) {
		val intersectionList = new ArrayList()
		iterable1.forEach[for (var i=0; i < iterable1.count(it) && i < iterable2.count(it); i++) {
			intersectionList.add(it)
		}]
		return intersectionList
	}
	
	/**
	 * OCL-equivalent returning the bag containing all elements of self plus the specified element
	 * (see OCL v2.4, section 11.7.4)
	 */
	@Pure
	def static <T> Iterable<? super T> including(Iterable<? super T> iterable, T element) {
		return iterable.toList.append(element)
	}
	
	/**
	 * OCL-equivalent returning the bag containing all elements of self apart from all occurrences 
	 * of the specified element (see OCL v2.4, section 11.7.4)
	 */
	@Pure
	def static <T> Iterable<? super T> excluding(Iterable<? super T> iterable, T element) {
		return iterable.toList.excluding(element)
	}

	/**
	 * Potentially impure OCL-equivalent returning the bag containing all elements of self apart from all occurrences 
	 * of the specified element (see OCL v2.4, section 7.6.1)
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given predicate can cause side-effects!
	 * </p>
	 */
	def static <T> Iterable<T> select(Iterable<T> iterable,	Function1<? super T, Boolean> predicate) {
		return iterable.filter(predicate)
	}
	
	/**
	 * Potentially impure OCL-equivalent returning the subset of all the elements of the collection 
	 * for which the expression evaluates to False (see OCL v2.4, section 7.6.1).
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given predicate can cause side-effects!
	 * </p>
	 */
	def static <T> Iterable<T> reject(Iterable<T> iterable,	Function1<? super T, Boolean> predicate) {
		return iterable.filter[!predicate.apply(it)]
	}
	
	/**
	 * Potentially impure OCL-equivalent returning a flat collection of the results of all
	 * the evaluations of the given function on the given iterable (see OCL v2.4, section 7.6.2 and 11.9.1).
	 * That is, if the collection resulting from the evaluations is not flat, then it is flattened before it is returned.
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given function can cause side-effects!
	 * </p>
	 */
	def static <T,R> Iterable<R> collect(Iterable<T> iterable, Function1<? super T, ? extends R> function) {
		val result = collectNested(iterable, function)
		// TODO MK if necessary then add a mechanism that decides whether it is faster to iterate over all elements 
		// to check whether the result is already flat or to create new immutable single element collections for every element
		val alreadyFlat = result.filter(Iterable).size == 0
		if (alreadyFlat) {
			return result
		} else {
			val List<Iterable<? extends R>> resultForFlattenning = Lists.newArrayListWithExpectedSize(result.size)
			for (element : result) {
				if (element instanceof Iterable<?>) {
					val e = element as Iterable<? extends R>
					resultForFlattenning.add(e)
				} else {
					resultForFlattenning.add(#[element])
				}
			}
			return resultForFlattenning.flatten()
		}
	}	

	/**
	 * Potentially impure OCL-equivalent returning the non-flattened collection of elements which result from applying 
	 * the function to every member of the collection (see OCL v2.4, section 11.9.1).
	 * <p>
	 * <strong>By not flattening the result, this method complies to the OCL standard but not with the Eclipse OCL 
	 * implementation of collectNested, which flattens results!</strong>
	 * </p>
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given function can cause side-effects!
	 * </p>
	 */
	def static <T,R> Iterable<R> collectNested(Iterable<T> iterable, Function1<? super T, ? extends R> function) {
		return iterable.map(function)
	}		
	
	
	/**
	 * Potentially impure OCL-equivalent evaluating to true if the given predicate is true 
	 * for all elements of the given collection (see OCL v2.4, section 7.6.3).
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given predicate can cause side-effects!
	 * </p>
	 */
	def static <T> boolean forAll(Iterable<T> iterable, Function1<? super T, Boolean> predicate) {
		return iterable.forall(predicate)
	}
	
	/**
	 * Potentially impure OCL-equivalent evaluating to true if the given predicate is true 
	 * for all elements of the Cartesian product of the collection with itself (see OCL v2.4, section 7.6.3).
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given predicate can cause side-effects!
	 * </p>
	 */
	def static <T> boolean forAll(Iterable<T> iterable, Function2<? super T, ? super T, Boolean> predicate) {
		val cartesianProduct = iterable.product(iterable)
		val holdingProductElements = cartesianProduct.filter[p1,p2 | predicate.apply(p1, p2)]
		return holdingProductElements.size == cartesianProduct.size
	}

	/**
	 * Potentially impure OCL-equivalent evaluating to true if the given predicate is true 
	 * for at least one element of the given collection (see OCL v2.4, section 7.6.4).
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given predicate can cause side-effects!
	 * </p>
	 */
	def static <T> boolean exists(Iterable<T> iterable, Function1<? super T, Boolean> predicate) {
		return IterableExtensions.exists(iterable, predicate);
	}
	
	/**
	 * Potentially impure OCL-equivalent returning the transitive closure of the given function 
	 * on the given iterable (see OCL v2.4, section 7.6.5).
	 * That is the given function is initially invoked on each element of the given iterable and 
	 * recursively invoked on every result as long as this result was not the target of a previous invocation.
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given function can cause side-effects!
	 * </p>
	 */
	def static <T,R extends T> Iterable<T> closure(Iterable<T> iterable, Function1<? super T, R> function) {
		val currentInvocationTargets = Lists.newLinkedList()
		val currentResults = Lists.newLinkedList(iterable)
		val allInvocationTargets = Sets.newHashSet()
		val allResults = Lists.newLinkedList()
		do {
			// the results of the last invocation are the targets of the next invocation
			currentInvocationTargets.clear()
			currentInvocationTargets.addAll(currentResults)
			currentResults.clear()
			for (target : currentInvocationTargets) {
				// only invoke the function on objects on which it was not invoked yet
				if (!allInvocationTargets.contains(target)) {
					allInvocationTargets.add(target)
					val result = function.apply(target)
					currentResults.add(result)
				}
			}
			allResults.addAll(currentResults)
		} while (!currentResults.isEmpty())
		return allResults
	}

	/**
	 * Potentially impure OCL-equivalent returning the result of applying 
	 * the given function to all elements of the given iterable using the given
	 * accumulator to build up the result (see OCL v2.4, section 7.6.6).
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given function can cause side-effects!
	 * </p>
	 */
	def static <T,R> R iterate(Iterable<T> iterable, R accumulator, Function2<? super R, ? super T, ? extends R> function) {
		return iterable.fold(accumulator, function)
	}
	
	/**
	 * Potentially impure OCL-equivalent returning a collection sorted by the values obtained by applying the given 
	 * key function to all elements of the given collection (see OCL v2.4, section 11.9.1)
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given key function can cause side-effects!
	 * </p>
	 */
	def static <T, C extends Comparable<? super C>> List<T> sortedBy(Iterable<T> iterable, Function1<? super T, C> key) {
		return iterable.sortBy(key)
	}
	
	/**
	 * Potentially impure OCL-equivalent returning true if there is exactly one element 
	 * in the collection for which the predicate is true (see OCL v2.4, section 11.9.1)
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given predicate can cause side-effects!
	 * </p>
	 */
	def static <T> boolean one(Iterable<T> iterable, Function1<? super T, Boolean> predicate) {
		return iterable.filter(predicate).size == 1
	}
	
	/**
	 * Potentially impure OCL-equivalent returning true if the given function evaluates to a different, 
	 * possibly null, value for each element in the collection (see OCL v2.4, section 11.9.1)
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given function can cause side-effects!
	 * </p>
	 */
	def static <T> boolean isUnique(Iterable<T> iterable, Function1<? super T, ?> function) {
		return iterable.groupBy[function.apply(it)].values.forall[it.size == 1]
	}
	
	/**
	 * Potentially impure OCL-equivalent returning an element for which the given predicate is true
	 * if there are one or more elements for which this is the case (see OCL v2.4, section 11.9.1)
	 * <p>
	 * <strong>Attention:</strong> This method can cause side-effects if the given predicate can cause side-effects!
	 * </p>
	 */
	def static <T> T any(Iterable<T> iterable, Function1<? super T, Boolean> predicate) {
		return iterable.findFirst(predicate)
	}
}