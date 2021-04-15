module state_module
  implicit none

  type state_type
     !snow variables
     real,    allocatable, dimension(:,:)    ::  sneqvxy   ! snow water equivalent [mm]
     real,    allocatable, dimension(:,:)    ::  snowhxy   ! physical snow depth [m]
     real,    allocatable, dimension(:,:)    ::  sneqvxy_post  ! snow water equivalent [mm] - updated by some external DA procedure
     real,    allocatable, dimension(:,:)    ::  snowhxy_post  ! physical snow depth [m] - updated by some external DA procedure
     real,    allocatable, dimension(:,:)    ::  sneqvoxy  ! snow mass at last time step(mm h2o)
     integer, allocatable, dimension(:,:)    ::  isnowxy   ! actual no. of (variable) snow layers
     real,    allocatable, dimension(:,:,:)  ::  zsnsoxy   ! snow layer depth [m]
     real,    allocatable, dimension(:,:,:)  ::  snicexy   ! snow layer ice [mm] ** refactor this!
     real,    allocatable, dimension(:,:,:)  ::  snliqxy   ! snow layer liquid water [mm]
     real,    allocatable, dimension(:,:,:)  ::  tsnoxy    ! snow temperature [k]
     real,    allocatable, dimension(:,:,:)  ::  tslbxy    ! soil temperature [k]
   contains
     procedure :: init => init_undefined
  end type state_type

contains

  subroutine init_undefined(this)
    use config_base, only: noah_lsm
    implicit none

    class(state_type) :: this
    integer :: xstart, xend, ystart, yend, nsoil, nsnow

    xstart = noah_lsm%xstart
    xend = noah_lsm%xend
    ystart = noah_lsm%ystart
    yend = noah_lsm%yend
    nsoil = noah_lsm%nsoil
    nsnow = noah_lsm%nsnow

    allocate ( this%sneqvxy      (xstart:xend, ystart:yend), source=noah_lsm%undefined_real )  ! snow water equivalent [mm]
    allocate ( this%snowhxy      (xstart:xend, ystart:yend), source=noah_lsm%undefined_real )  ! physical snow depth [m]
    allocate ( this%sneqvxy_post (xstart:xend, ystart:yend), source=noah_lsm%undefined_real )  ! snow water equivalent [mm] - updated externally
    allocate ( this%snowhxy_post (xstart:xend, ystart:yend), source=noah_lsm%undefined_real )  ! physical snow depth [m] - updated externally
    allocate ( this%sneqvoxy     (xstart:xend, ystart:yend), source=noah_lsm%undefined_real )  ! snow water equivalent at previous timestep [mm]
    allocate ( this%isnowxy      (xstart:xend, ystart:yend),  source=noah_lsm%undefined_int )  ! actual no. of (variable) snow layers
    allocate ( this%zsnsoxy      (xstart:xend, -nsnow+1:nsoil, ystart:yend), source=noah_lsm%undefined_real )  ! snow layer depth [m]
    allocate ( this%snicexy      (xstart:xend, -nsnow+1:0,     ystart:yend), source=noah_lsm%undefined_real )  ! snow layer ice [mm]
    allocate ( this%snliqxy      (xstart:xend, -nsnow+1:0,     ystart:yend), source=noah_lsm%undefined_real )  ! snow layer liquid water [mm]
    allocate ( this%tsnoxy       (xstart:xend, -nsnow+1:0,     ystart:yend), source=noah_lsm%undefined_real )  ! snow temperature [k]
    allocate ( this%tslbxy       (xstart:xend, 1:nsoil,        ystart:yend), source=noah_lsm%undefined_real )  ! soil temperature [K]

  end subroutine init_undefined

end module state_module
