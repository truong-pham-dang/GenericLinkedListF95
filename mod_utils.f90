module mod_utils
	implicit none
	private

	public :: equal
	
	interface equal
		module procedure equal_int_arrays
	end interface

	contains
		logical function equal_int_arrays( array1, array2 )
			implicit none
			integer, dimension(:), intent(in) :: array1, array2
			integer :: i

			equal_int_arrays = size(array1) == size(array2)
			if ( equal_int_arrays ) then
				do i = 1,size(array1)
				equal_int_arrays = array1(i) == array2(i)
				if ( .not. equal_int_arrays )exit
			enddo
			endif
		end function equal_int_arrays
end module