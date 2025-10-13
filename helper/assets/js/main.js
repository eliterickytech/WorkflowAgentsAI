// Navigation and Search functionality
document.addEventListener('DOMContentLoaded', function () {
  // Initialize
  initNavigation();
  initSearch();
  initSmoothScroll();
  initMobileMenu();
  highlightActiveSection();

  // Event listeners
  window.addEventListener('scroll', highlightActiveSection);
  window.addEventListener('resize', handleResize);
});

// Navigation
function initNavigation() {
  const navLinks = document.querySelectorAll('.sidebar-nav a');

  navLinks.forEach(link => {
    link.addEventListener('click', function (e) {
      // For same-page anchors
      if (this.getAttribute('href').startsWith('#')) {
        e.preventDefault();
        const targetId = this.getAttribute('href').substring(1);
        const targetElement = document.getElementById(targetId);

        if (targetElement) {
          const headerOffset = 90;
          const elementPosition = targetElement.getBoundingClientRect().top;
          const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

          window.scrollTo({
            top: offsetPosition,
            behavior: 'smooth'
          });

          // Update active state
          navLinks.forEach(l => l.classList.remove('active'));
          this.classList.add('active');
        }
      }
    });
  });
}

// Search functionality
function initSearch() {
  const searchInput = document.getElementById('searchInput');

  if (searchInput) {
    searchInput.addEventListener('input', function (e) {
      const searchTerm = e.target.value.toLowerCase();
      const navSections = document.querySelectorAll('.nav-section');

      navSections.forEach(section => {
        const links = section.querySelectorAll('li');
        let hasVisibleItems = false;

        links.forEach(link => {
          const text = link.textContent.toLowerCase();
          if (text.includes(searchTerm)) {
            link.style.display = '';
            hasVisibleItems = true;
          } else {
            link.style.display = 'none';
          }
        });

        // Hide section if no items match
        if (hasVisibleItems || searchTerm === '') {
          section.style.display = '';
        } else {
          section.style.display = 'none';
        }
      });
    });
  }
}

// Smooth scroll
function initSmoothScroll() {
  const links = document.querySelectorAll('a[href^="#"]');

  links.forEach(link => {
    link.addEventListener('click', function (e) {
      const href = this.getAttribute('href');
      if (href === '#') return;

      e.preventDefault();
      const targetId = href.substring(1);
      const targetElement = document.getElementById(targetId);

      if (targetElement) {
        const headerOffset = 90;
        const elementPosition = targetElement.getBoundingClientRect().top;
        const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

        window.scrollTo({
          top: offsetPosition,
          behavior: 'smooth'
        });
      }
    });
  });
}

// Mobile menu toggle
function initMobileMenu() {
  // Create mobile menu button if it doesn't exist
  if (window.innerWidth <= 1024 && !document.querySelector('.mobile-menu-btn')) {
    const header = document.querySelector('.header-content');
    const menuBtn = document.createElement('button');
    menuBtn.className = 'mobile-menu-btn';
    menuBtn.innerHTML = '<i class="fas fa-bars"></i>';
    menuBtn.style.cssText = `
      background: rgba(255,255,255,0.2);
      border: none;
      color: white;
      font-size: 1.5rem;
      padding: 0.5rem 1rem;
      border-radius: 8px;
      cursor: pointer;
      display: none;
    `;

    if (window.innerWidth <= 1024) {
      menuBtn.style.display = 'block';
    }

    header.insertBefore(menuBtn, header.firstChild);

    menuBtn.addEventListener('click', function () {
      const sidebar = document.querySelector('.sidebar');
      sidebar.classList.toggle('active');

      // Change icon
      const icon = this.querySelector('i');
      if (sidebar.classList.contains('active')) {
        icon.className = 'fas fa-times';
      } else {
        icon.className = 'fas fa-bars';
      }
    });

    // Close sidebar when clicking outside
    document.addEventListener('click', function (e) {
      const sidebar = document.querySelector('.sidebar');
      const menuBtn = document.querySelector('.mobile-menu-btn');

      if (sidebar.classList.contains('active') &&
        !sidebar.contains(e.target) &&
        !menuBtn.contains(e.target)) {
        sidebar.classList.remove('active');
        menuBtn.querySelector('i').className = 'fas fa-bars';
      }
    });
  }
}

// Highlight active section on scroll
function highlightActiveSection() {
  const sections = document.querySelectorAll('.content-section[id]');
  const navLinks = document.querySelectorAll('.sidebar-nav a[href^="#"]');

  let currentSection = '';
  const scrollPosition = window.pageYOffset + 100;

  sections.forEach(section => {
    const sectionTop = section.offsetTop;
    const sectionHeight = section.offsetHeight;

    if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
      currentSection = section.getAttribute('id');
    }
  });

  navLinks.forEach(link => {
    link.classList.remove('active');
    if (link.getAttribute('href') === `#${currentSection}`) {
      link.classList.add('active');
    }
  });
}

// Handle resize events
function handleResize() {
  const sidebar = document.querySelector('.sidebar');
  const menuBtn = document.querySelector('.mobile-menu-btn');

  if (window.innerWidth > 1024) {
    if (sidebar) sidebar.classList.remove('active');
    if (menuBtn) menuBtn.style.display = 'none';
  } else {
    if (menuBtn) menuBtn.style.display = 'block';
  }
}

// Copy code to clipboard
function initCodeCopy() {
  const codeBlocks = document.querySelectorAll('pre code');

  codeBlocks.forEach(block => {
    const pre = block.parentElement;
    const button = document.createElement('button');
    button.className = 'copy-code-btn';
    button.innerHTML = '<i class="fas fa-copy"></i>';
    button.style.cssText = `
      position: absolute;
      top: 0.5rem;
      right: 0.5rem;
      background: rgba(255,255,255,0.1);
      border: 1px solid rgba(255,255,255,0.2);
      color: white;
      padding: 0.5rem;
      border-radius: 4px;
      cursor: pointer;
      opacity: 0;
      transition: opacity 0.3s;
    `;

    pre.style.position = 'relative';
    pre.appendChild(button);

    pre.addEventListener('mouseenter', () => button.style.opacity = '1');
    pre.addEventListener('mouseleave', () => button.style.opacity = '0');

    button.addEventListener('click', async function () {
      const code = block.textContent;
      try {
        await navigator.clipboard.writeText(code);
        this.innerHTML = '<i class="fas fa-check"></i>';
        setTimeout(() => {
          this.innerHTML = '<i class="fas fa-copy"></i>';
        }, 2000);
      } catch (err) {
        console.error('Failed to copy code:', err);
      }
    });
  });
}

// Initialize when DOM is ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initCodeCopy);
} else {
  initCodeCopy();
}

// Table of contents generator for long pages
function generateTableOfContents() {
  const mainContent = document.querySelector('.main-content');
  const headings = mainContent.querySelectorAll('h2, h3');

  if (headings.length > 5) { // Only generate TOC if there are many headings
    const toc = document.createElement('div');
    toc.className = 'table-of-contents';
    toc.innerHTML = '<h3><i class="fas fa-list"></i> Nesta Página</h3><ul></ul>';

    const tocList = toc.querySelector('ul');

    headings.forEach((heading, index) => {
      if (!heading.id) {
        heading.id = `heading-${index}`;
      }

      const li = document.createElement('li');
      li.className = heading.tagName.toLowerCase();
      li.innerHTML = `<a href="#${heading.id}">${heading.textContent}</a>`;
      tocList.appendChild(li);
    });

    const firstSection = mainContent.querySelector('.content-section');
    if (firstSection) {
      firstSection.insertBefore(toc, firstSection.firstChild.nextSibling);
    }
  }
}

// Call TOC generator
setTimeout(generateTableOfContents, 100);

// Progress bar for reading
function initReadingProgress() {
  const progressBar = document.createElement('div');
  progressBar.className = 'reading-progress';
  progressBar.style.cssText = `
    position: fixed;
    top: var(--header-height);
    left: 0;
    width: 0%;
    height: 3px;
    background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
    z-index: 1001;
    transition: width 0.1s ease;
  `;
  document.body.appendChild(progressBar);

  window.addEventListener('scroll', function () {
    const windowHeight = window.innerHeight;
    const documentHeight = document.documentElement.scrollHeight - windowHeight;
    const scrolled = window.pageYOffset;
    const progress = (scrolled / documentHeight) * 100;
    progressBar.style.width = progress + '%';
  });
}

initReadingProgress();

// Print functionality
function initPrint() {
  const printBtns = document.querySelectorAll('.print-btn');

  printBtns.forEach(btn => {
    btn.addEventListener('click', function () {
      window.print();
    });
  });
}

// Dark mode toggle (future enhancement)
function initDarkMode() {
  const darkModeToggle = document.getElementById('darkModeToggle');

  if (darkModeToggle) {
    // Check for saved preference
    const darkMode = localStorage.getItem('darkMode');
    if (darkMode === 'enabled') {
      document.body.classList.add('dark-mode');
    }

    darkModeToggle.addEventListener('click', function () {
      document.body.classList.toggle('dark-mode');

      if (document.body.classList.contains('dark-mode')) {
        localStorage.setItem('darkMode', 'enabled');
      } else {
        localStorage.removeItem('darkMode');
      }
    });
  }
}

// Export functions for external use
window.TOTVS - WorkflowAIDocs = {
  highlightActiveSection,
    initSearch,
    initNavigation,
    generateTableOfContents
};
