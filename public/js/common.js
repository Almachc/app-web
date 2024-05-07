function showToast() {
  const toast = document.getElementById('toast')

  setTimeout(() => {
    toast.classList.add('show')
  }, 500)

  setTimeout(() => {
    toast.classList.remove('show')
  }, 5000)
}
