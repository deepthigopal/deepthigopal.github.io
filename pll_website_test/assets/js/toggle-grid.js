var wrapper = document.getElementById("this-inventory");
var style = document.getElementById("grid-toggle-wrapper");

document.addEventListener("click", function (event) {
  if (!event.target.matches(".toggle-list")) return;

  // List view
  event.preventDefault();
  wrapper.classList.add("this-list");
  wrapper.classList.remove("this-grid");
  style.classList.add("angled");
  style.classList.remove("straight");
});

document.addEventListener("click", function (event) {
  if (!event.target.matches(".toggle-grid")) return;

  // List view
  event.preventDefault();
  wrapper.classList.add("this-grid");
  wrapper.classList.remove("this-list");
  style.classList.add("straight");
  style.classList.remove("angled");
});
