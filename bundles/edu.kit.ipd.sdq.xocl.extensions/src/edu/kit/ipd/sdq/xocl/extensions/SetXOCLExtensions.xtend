package edu.kit.ipd.sdq.xocl.extensions

import java.util.HashSet
import java.util.Set

/**
 * A utility class providing OCL-aligned extension methods for Numbers
 * 
 */
class SetXOCLExtensions {
	/** Utility classes should not have a public or default constructor. */
	private new() {
	}
	
	/**
	 * OCL-equivalent returning the union of both sets (see OCL v2.4, section 11.7.2)
	 */
	@Pure 
	def static <T> Set<T> union(Set<T> set1, Set<T> set2) {
		val unionSet = new HashSet()
		unionSet.addAll(set1)
		unionSet.addAll(set2)
		return unionSet
	}
	
	/**
	 * OCL-equivalent returning the intersection of both sets 
	 * (i.e., the set of all elements that are in both sets).
	 * (see OCL v2.4, section 11.7.2)
	 */
	@Pure 
	def static <T> Set<T> intersection(Set<T> set1, Set<T> set2) {
		val intersectionSet = new HashSet()
		set1.forEach[if (set2.contains(it)) { intersectionSet.add(it) }]
		return intersectionSet
	}
	
	/**
	 * OCL-equivalent returning the set containing all elements of self plus the specified element.
	 * (see OCL v2.4, section 11.7.2)
	 */
	@Pure
	def static <T> Set<? super T> including(Set<? super T> set, T element) {
		val includingSet = new HashSet()
		includingSet.addAll(set)
		includingSet.add(element)
		return includingSet
	}
	
	/**
	 * OCL-equivalent returning the set containing all the elements that are in 
	 * one of both sets, but not in both. (see OCL v2.4, section 11.7.2)
	 */
	@Pure 
	def static <T> Set<T> symmetricDifference(Set<T> set1, Set<T> set2) {
		val symDiffSet = union(set1, set2)
		symDiffSet.removeAll(intersection(set1,set2))
		return symDiffSet
	}
	
	/**
	 * OCL-equivalent returning the sub-set containing the non-null elements 
	 * whose type is the specified type or a subtype of it. (see OCL v2.4, section 11.7.2)	
	 */
	@Pure
	def static <T> Set<T> selectByKind(Set<? super T> set, Class<T> type) {
		return IterableXOCLExtensions.selectByKind(set, type).toSet
	}
	
	/**
	 * OCL-equivalent returning the sub-set containing the non-null elements 
	 * whose type is the specified type but not a subtype of it. (see OCL v2.4, section 11.7.2)	
	 */
	@Pure
	def static <T> Iterable<T> selectByType(Set<? super T> set, Class<T> type) {
		return IterableXOCLExtensions.selectByType(set, type).toSet
	}

	/**
	 * OCL-equivalent returning the set of elements, consisting of all elements 
	 * of the specified set, followed by the specified object.
	  (see OCL v2.4, section 11.7.3)	
	 */
	@Pure
	def static <T> Set<? super T> append(Set<? super T> set, T object) {
		return including(set, object)
	}
}