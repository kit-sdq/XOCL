package edu.kit.ipd.sdq.xocl.extensions

import com.google.common.collect.Lists
import java.util.List

/**
 * A utility class providing OCL-aligned extension methods for Lists respectively Sequences
 * 
 */
class ListXOCLExtensions {
	/** Utility classes should not have a public or default constructor. */
	private new() {
	}

	/**
	 * OCL-equivalent returning the sequence of elements, consisting of all elements of the given list, 
	 * followed by object (see OCL v2.4, section 11.7.5)	
	 */
	@Pure
	def static <T> List<? super T> append(List<? super T> list, T object) {
		val newLastIndex = zero2OneBasedIndex(list?.size)
		return list.insertAt(newLastIndex, object)
	}
	
	@Pure	
	private def static int zero2OneBasedIndex(int i) {
		return i + 1
	}
		
	@Pure
	private def static int one2ZeroBasedIndex(int i) {
		return i - 1
	}
	
	/**
	 * OCL-equivalent returning the sequence consisting of object, followed by all elements of the given list 
	 * (see OCL v2.4, section 11.7.5)	
	 */
	@Pure
	def static <T> List<? super T> prepend(List<? super T> list, T object) {
		val firstIndex = 1
		return list.insertAt(firstIndex, object)
	}
	
	/**
	 * OCL-equivalent returning the sequence consisting of the given list with object inserted at one-based position index
	 * (see OCL v2.4, section 11.7.5)	
	 */
	@Pure	
	def static <T> List<? super T> insertAt(List<? super T> list, int index, T object) {
		val includingList = newArrayListCopy(list)
		val oneBasedJavaIndex = zero2OneBasedIndex(index)
		includingList.add(oneBasedJavaIndex, object)
		return includingList
	}
	
	@Pure	
	private def static <T> List<T> newArrayListCopy(List<T> list) {
		// TODO MK implement lazy list copying if necessary
		return Lists.newArrayList(list)
	}
	
	/**
	 * OCL-equivalent returning the sub-sequence of the given list starting at one-based index lower,
	 * up to and including the element at one-based index upper (see OCL v2.4, section 11.7.5)	
	 */
	@Pure	
	def static <T> List<? super T> subSequence(List<? super T> list, int lower, int upper) {
		// in contrast to Java's List.subList the upper index is inclusive not exclusive
		val subSequenceLength = upper - lower + 1
		// in contrast to Java both indices are one-based not zero-based
		val zeroBasedLower = one2ZeroBasedIndex(lower)
		// in contrast to Java's List.subList we have to return a new list that is not backed by the initial list
		val subList = Lists.newArrayListWithCapacity(subSequenceLength)
		val iteratorFromLowerToUpper = list?.listIterator(zeroBasedLower)?.take(subSequenceLength)
		while (iteratorFromLowerToUpper?.hasNext()) {
			val element = iteratorFromLowerToUpper.next()
			subList.add(element)
		}
		return subList
	}
	
	/**
	 * OCL-equivalent returning the element at one-based index i of the given sequence (see OCL v2.4, section 11.7.5)	
	 */
	@Pure	
	def static <T> T at(List<T> list, int index) {
		val zeroBasedIndex = one2ZeroBasedIndex(index)
		return list?.get(zeroBasedIndex)
	}
	
	/**
	 * OCL-equivalent returning the one-based index of the given object in the sequence (see OCL v2.4, section 11.7.5)	
	 */
	@Pure	
	def static <T> int indexOf(List<? super T> list, T object) {
		val zeroBasedIndex = list.indexOf(object)
		if (zeroBasedIndex == -1) {
			throw new IllegalArgumentException('''Cannot determine the index of the object '«object»'
			in the list '«list»' because it does not contain the object!''')
		}
		return zero2OneBasedIndex(zeroBasedIndex)
	}
	
	/**
	 * OCL-equivalent returning the first element in the given list (see OCL v2.4, section 11.7.5)	
	 */
	@Pure	
	def static <T> T first(List<T> list) {
		val firstOneBasedIndex = 1
		return list?.at(firstOneBasedIndex)
	}
	
	/**
	 * OCL-equivalent returning the last element in the given list (see OCL v2.4, section 11.7.5)	
	 */
	@Pure	
	def static <T> T last(List<T> list) {
		val lastOneBasedIndex = list?.size()
		return list?.at(lastOneBasedIndex)
	}
	
	/**
	 * OCL-equivalent returning the sequence containing all elements of self apart 
	 * from all occurrences of object (see OCL v2.4, section 11.7.5)	
	 */
	@Pure
	def static <T> List<? super T> excluding(List<? super T> list, T object) {
		val excludingList = newArrayListCopy(list)
		// remove all occurrences not only the first occurrence as Collection.remove(Object) would do
		excludingList.removeAll(#{object})
		return excludingList
	}
	
	/**
	 * OCL-equivalent returning the sequence containing the same elements but 
	 * with the opposite order (see OCL v2.4, section 11.7.5)	
	 */
	@Pure
	def static <T> List<T> reverse(List<T> list) {
		val reversedList = newArrayListCopy(list)
		ListExtensions.reverse(reversedList)
		return reversedList
	}
}