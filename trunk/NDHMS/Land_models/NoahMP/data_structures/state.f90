module state_module
  implicit none

  type state_type
     !snow variables
     real,    allocatable, dimension(:,:,:)  ::  tsnoxy    ! snow temperature [k] ** refactor this!
     real,    allocatable, dimension(:,:,:)  ::  zsnsoxy   ! snow layer depth [m] ** refactor this!
     integer, allocatable, dimension(:,:)    ::  isnowxy   ! actual no. of (variable) snow layers
     real,    allocatable, dimension(:,:,:)  ::  snicexy   ! snow layer ice [mm] ** refactor this!
     real,    allocatable, dimension(:,:,:)  ::  snliqxy   ! snow layer liquid water [mm] ** refactor this!
     real,    allocatable, dimension(:,:)    ::  snow      ! snow water equivalent [mm] ** (sometime) prognostic variable
     real,    allocatable, dimension(:,:)    ::  snowh     ! physical snow depth [m] ** (sometime) prognostic variable
   contains
     procedure :: init => init_undefined
  end type state_type

contains
  !are we actually initializing?
  subroutine init_undefined(this)
    use config_base, only: noah_lsm
    implicit none
    
    class(state_type) :: this
    integer, parameter :: nsnow = 3 !as definined in module_noahmp,hrldas_driver.f. todo getting from a config later
    real, parameter :: undefined_real = 9.9692099683868690e36 ! todo getting from a config later
    integer, parameter :: undefined_int = -2147483647         ! netcdf integer fillvalue: todo getting from a config later
    integer :: xstart, xend, ystart, yend, nsoil
    
    xstart = noah_lsm%xstart
    xend = noah_lsm%xend
    ystart = noah_lsm%ystart
    yend = noah_lsm%yend
    nsoil = noah_lsm%nsoil
    
    allocate ( this%tsnoxy    (xstart:xend,-nsnow+1:0,    ystart:yend), source = undefined_real )  ! snow temperature [k]
    allocate ( this%zsnsoxy   (xstart:xend,-nsnow+1:nsoil,ystart:yend), source = undefined_real )  ! snow layer depth [m]
    allocate ( this%isnowxy   (xstart:xend,ystart:yend),  source = undefined_int )  ! actual no. of (variable) snow layers
    allocate ( this%snicexy   (xstart:xend,-nsnow+1:0,    ystart:yend), source = undefined_real )  ! snow layer ice [mm]
    allocate ( this%snliqxy   (xstart:xend,-nsnow+1:0,    ystart:yend), source = undefined_real )  ! snow layer liquid water [mm]
    allocate ( this%snow      (xstart:xend,ystart:yend), source = undefined_real )  ! snow water equivalent [mm]
    allocate ( this%snowh     (xstart:xend,ystart:yend), source = undefined_real )  ! physical snow depth [m]
    
  end subroutine init_undefined

end module state_module
