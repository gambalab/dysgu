#cython: language_level=3

from libcpp.vector cimport vector as cpp_vector
from libcpp.deque cimport deque as cpp_deque
from libcpp.pair cimport pair as cpp_pair
from libcpp.string cimport string as cpp_string

import cython

# from pysam.libcalignmentfile cimport AlignmentFile
# from pysam.libcalignedsegment cimport AlignedSegment
# from pysam.libchtslib cimport bam1_t, BAM_CIGAR_SHIFT, BAM_CIGAR_MASK


from libc.stdint cimport uint32_t, uint8_t

ctypedef cpp_vector[int] int_vec_t
ctypedef cpp_pair[int, int] get_val_result

# ctypedef Py_Int2IntVecMap[int, int_vec_t] node_dict_t
# ctypedef Py_IntVec2IntMap[int_vec_t, int] node_dict2_r_t


cdef extern from "wrap_map_set2.h" nogil:
    cdef cppclass DiGraph:
        DiGraph() nogil

        int addNode()
        int hasEdge(int, int) nogil
        void addEdge(int, int) nogil
        int numberOfNodes() nogil
        cpp_vector[int] forInEdgesOf(int) nogil
        cpp_vector[int] neighbors(int) nogil



cdef class Py_DiGraph:
    """DiGraph, no weight"""
    cdef DiGraph *thisptr

    cdef int addNode(self) nogil
    cdef int hasEdge(self, int u, int v) nogil
    cdef void addEdge(self, int u, int v) nogil
    cdef int numberOfNodes(self) nogil
    cdef cpp_vector[int] forInEdgesOf(self, int u) nogil
    cdef cpp_vector[int] neighbors(self, int u) nogil


cdef extern from "wrap_map_set2.h":
    cdef cppclass SimpleGraph:
        SimpleGraph()

        int addNode()
        int hasEdge(int, int)
        void addEdge(int, int, int)
        int edgeCount()
        int weight(int, int)
        cpp_vector[int] neighbors(int)
        void removeNode(int)
        cpp_vector[int] connectedComponents()
        int showSize()



cdef class Py_SimpleGraph:
    """Graph"""
    cdef SimpleGraph *thisptr

    cpdef int addNode(self)
    cpdef int hasEdge(self, int u, int v)
    cpdef void addEdge(self, int u, int v, int w)
    cpdef int edgeCount(self)
    cpdef int weight(self, int u, int v)
    cpdef cpp_vector[int] neighbors(self, int u)
    cpdef void removeNode(self, int u)
    cpdef cpp_vector[int] connectedComponents(self)
    cpdef int showSize(self)


cdef extern from "wrap_map_set2.h" nogil:
    cdef cppclass Int2IntMap:
        Int2IntMap() nogil
        void insert(int, int) nogil
        void erase(int) nogil
        int has_key(int) nogil
        int get(int) nogil
        get_val_result get_value(int key) nogil
        int size() nogil


cdef class Py_Int2IntMap:
    """Fast integer to integer unordered map using tsl::robin-map"""
    cdef Int2IntMap *thisptr

    cdef void insert(self, int key, int value) nogil
    cdef void erase(self, int key) nogil
    cdef int has_key(self, int key) nogil
    cdef int get(self, int key) nogil
    cdef get_val_result get_value(self, int key) nogil
    cdef int size(self) nogil


cdef extern from "wrap_map_set2.h" nogil:
    cdef cppclass IntSet:
        IntSet() nogil
        void insert(int) nogil
        void erase(int) nogil
        int has_key(int) nogil
        int get(int) nogil
        int size() nogil


cdef class Py_IntSet:
    """Fast 32 bit int set using tsl::robin-set"""
    cdef IntSet *thisptr

    cdef void insert(self, int key) nogil
    cdef void erase(self, int key) nogil
    cdef int has_key(self, int key) nogil
    cdef int size(self) nogil


cdef extern from "wrap_map_set2.h":
    cdef cppclass StrSet:
        StrSet()
        void insert(cpp_string) nogil
        void erase(cpp_string) nogil
        int has_key(cpp_string) nogil
        int size() nogil


cdef class Py_StrSet:
    """Fast std::string set using tsl::robin-set"""
    cdef StrSet *thisptr
    cdef void insert(self, cpp_string key) nogil
    cdef void erase(self, cpp_string key) nogil
    cdef int has_key(self, cpp_string key) nogil
    cdef int size(self) nogil


cdef int cigar_exists(r)


cdef tuple clip_sizes(r)


cdef int cigar_clip(r, int clip_length)
