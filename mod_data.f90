module mod_data
  use mod_generic_list, only: list_get, list_next, list_node_t, list_remove_node
  implicit none

  private
  public :: data_int_t
  public :: data_int_ptr
  public :: data_int_ptr_constructor
  public :: data_int_ptr_print
  public :: data_int_ptr_remove_node

  ! Data is stored in data_int_t
  type :: data_int_t
     integer :: n
  end type data_int_t

  ! A container for storing data_t pointers
  type :: data_int_ptr
     type(data_int_t), pointer :: p => null()
  end type data_int_ptr

  interface data_int_ptr_constructor
      module procedure data_int_ptr_initialize
  end interface data_int_ptr_constructor

  interface data_int_ptr_print
    module procedure data_int_ptr_print_list
  end interface data_int_ptr_print

  contains

  ! Implement the constructor
  function data_int_ptr_initialize(val)
      implicit none
      type(data_int_ptr)  :: data_int_ptr_initialize
      integer, intent(in) :: val

      if (.not. associated(data_int_ptr_initialize%p)) then
          allocate(data_int_ptr_initialize%p)
          data_int_ptr_initialize%p%n = val
      endif
  end function

  ! Helper method print
  subroutine data_int_ptr_print_list(list)
    implicit none
    type(list_node_t), pointer :: list
    type(data_int_ptr)         :: ptr

    do while (associated(list))
		ptr = transfer(list_get(list), ptr)
        print*, ptr%p%n
        list => list_next(list)
    end do
  end subroutine

  ! Remove node has value k
  subroutine data_int_ptr_remove_node(list, k)
    implicit none
    type(list_node_t), pointer :: list
    type(data_int_ptr)         :: ptr
	integer, intent(in)        :: k

    do while (associated(list))
		ptr = transfer(list_get(list), ptr)
        
		if (ptr%p%n == k) then
			call list_remove_node(list)
			exit
		endif

        list => list_next(list)
    end do
  end subroutine

end module mod_data
