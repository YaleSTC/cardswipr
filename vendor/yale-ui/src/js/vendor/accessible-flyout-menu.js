/**
 * Javascript Implementing Fly-out Mens from the W3.org site.
 * Implements the Approach 2: Use button as toggle with a slight variation with the class toggling.
 * Reference: https://www.w3.org/WAI/tutorials/menus/flyout/#flyoutnavkbbtn.
 */

// JavaScript should be made compatible with libraries other than jQuery by
// wrapping it with an "anonymous closure". See:
// - https://drupal.org/node/1446420
// - http://www.adequatelygood.com/2010/3/JavaScript-Module-Pattern-In-Depth


document.documentElement.classList.add('js');
document.documentElement.classList.remove('no-js');

window.accessibleMenu = (function (breakpoint) {

  /*
  * Polyfill for closest(). IE9+ doesn't support it.
  * https://developer.mozilla.org/en-US/docs/Web/API/Element/closest#Polyfill
  */

  if (!Element.prototype.matches) {
    Element.prototype.matches = Element.prototype.msMatchesSelector || Element.prototype.webkitMatchesSelector;
  }

  if (!Element.prototype.closest) {
    Element.prototype.closest = function(s) {
      var el = this;

      do {
        if (el.matches(s)) return el;
        el = el.parentElement || el.parentNode;
      } while (el !== null && el.nodeType === 1);
      return null;
    };
  }

  'use strict';

  let menu = document.querySelector('.accessible-flyout-menu');
  breakpoint = breakpoint || 768;
  let menuItemsSelector = '.menu-item';
  let menuItemHasSubmenu = '.has-submenu';
  let menuItems = document.querySelectorAll(menuItemHasSubmenu);
  let menuTimer = 0;

  var closeMenu = function closeMenu(el) {
    clearTimeout(menuTimer);
    el.classList.remove('open');
    el.querySelector('button').setAttribute('aria-expanded', "false");

    let button = el.querySelector('.expand-sub-button');
    let subMenu = button.nextElementSibling;

    button.classList.remove('expand-sub-button-open');
    subMenu.classList.remove('submenu-open');
  }

  var closeAllMenu = function closeAllMenu(){
    Array.prototype.forEach.call(menuItems, function(el, i) {
      closeMenu(el);
    })
  }

  var openMenu = function openMenu(el) {
    closeAllMenu();
    el.classList.add('open');
    el.querySelector('button').setAttribute('aria-expanded', "true");

    let button = el.querySelector('.expand-sub-button');
    let subMenu = button.nextElementSibling;

    button.classList.add('expand-sub-button-open');
    subMenu.classList.add('submenu-open');
  }

  var toggleDesktop = function toggleDesktop(el) {
    if (window.innerWidth < breakpoint) {
      el.classList.remove('accessible-flyout-menu-desktop');
      el.classList.add('accessible-flyout-menu-mobile');
    } else {
      el.classList.add('accessible-flyout-menu-desktop');
      el.classList.remove('accessible-flyout-menu-mobile')
    }
  }

  var checkOverflow = function(el) {
    let menuItemsWithSubmenus = el.querySelectorAll('.menu-item.has-submenu');
    if (window.innerWidth >= breakpoint) {
      Array.prototype.forEach.call(menuItemsWithSubmenus, function(item, i) {
        item.classList.remove('overflow-right');

        let sub = item.querySelector('.submenu');
        let subRect = sub.getBoundingClientRect();

        if (subRect.right >= window.innerWidth - 20) {
          item.classList.add('overflow-right');
        }
      })
    }
    else {
      Array.prototype.forEach.call(menuItemsWithSubmenus, function(item, i) {
        item.classList.remove('overflow-right');
      })
    }
  };

  window.addEventListener("resize", function(event) {
    toggleDesktop(menu);
    checkOverflow(menu);
  });

  toggleDesktop(menu);
  checkOverflow(menu);

  document.onkeydown = function(evt) {
    evt = evt || window.event;
    var isEscape = false;
    if ("key" in evt) {
      isEscape = (evt.key === "Escape" || evt.key === "Esc");
    } else {
      isEscape = (evt.keyCode === 27);
    }
    if (!isEscape) {
      return;
    }
    let menu = document.activeElement.closest(menuItemHasSubmenu + '.open');
    if (menu) {
      menu.querySelector('.expand-sub-button').focus();
    }

    closeAllMenu();
  };

  Array.prototype.forEach.call(menuItems, function(el, i) {
    var activatingA = el.querySelector('a');
    var btn = '<button class="expand-sub-button"><span class="expand-sub-inner"><span class="element__hidden">Submenu for “' + activatingA.text + '”</span></span></button>';
    activatingA.insertAdjacentHTML('afterend', btn);
    const button = el.querySelector('button');
    let subMenu = button.nextElementSibling;

    el.addEventListener("mouseover", function(event){
      if (window.innerWidth < breakpoint) {
        return;
      }
      openMenu(el);
    });

    el.addEventListener("mouseout", function(event){
      if (window.innerWidth < breakpoint) {
        return;
      }
      clearTimeout(menuTimer)
      menuTimer = setTimeout(function(event){
        closeMenu(el);
      }, 500);
    });

    button.addEventListener("click", function(event) {
      event.preventDefault();
      if (el.classList.contains('open')) {
        closeMenu(el);
        return;
      }
      openMenu(el);
    });

    let subMenuId = subMenu.id;
    if (subMenuId) {
      button.setAttribute('aria-controls', subMenuId);
    }
  });

  Array.prototype.forEach.call(menu.querySelectorAll(menuItemsSelector), function(el, i) {
    // Moving focus out of an expanded submenu collapses the submenu.
    el.addEventListener("focus", function(event){
      if ((window.innerWidth < breakpoint) || (el.classList.contains("open"))) {
        return;
      }
      closeAllMenu();
    }, true);

    el.addEventListener("blur", function(event){
      if (window.innerWidth < breakpoint || menu.contains(event.relatedTarget)) {
        return;
      }
      closeAllMenu();
    }, true);
  });

});

// Initalize Menu.
// Uncomment this to initialize here. Otherwise, initialize in your own scripts.
// window.accessibleMenu();
