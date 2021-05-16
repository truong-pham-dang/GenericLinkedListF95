module data
  implicit none

  private
  public :: data_int_t
  public :: data_int_ptr
  public :: data_int_ptr_constructor

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

end module data
