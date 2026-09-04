import React, { useEffect, useState } from "react";
import { Link, useLocation } from "react-router-dom";
import "./style.css";
import Breadcrumb from "../Breadcrumb";
import siteConfig from "../../../config/siteConfig";
import { fetchSubareas } from "../../../services/api";

function normalizeId(label) {
  return (label || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9\s]/g, "")
    .trim()
    .replace(/\s+/g, "_");
}

const Header = () => {
  const [subareas, setSubareas] = useState(siteConfig.SUBAREAS || []);

  useEffect(() => {
    fetchSubareas(siteConfig.SITE_AREA).then(data => {
      if (data && data.length > 0) setSubareas(data);
    }).catch(() => {});
  }, []);

  const location = useLocation();
  const [menuOpen, setMenuOpen] = useState(false);
  const [openDropdown, setOpenDropdown] = useState(null);

  useEffect(() => {
    setMenuOpen(false);
    setOpenDropdown(null);
  }, [location.pathname, location.hash]);

  const toggleDropdown = (name, e) => {
    if (window.innerWidth <= 1024) {
      e.preventDefault();
      setOpenDropdown(openDropdown === name ? null : name);
    }
  };

  return (
    <header className="header">
      <div className="header-container">
        <div className="header-content">
          <Link
            to="/"
            className="logo-area"
            aria-label={siteConfig.SITE_TITLE}
          >
            <div className="logo-container">
              <img src="/logo-eng.png" alt={siteConfig.SITE_TITLE} className="logo-img" />
            </div>
          </Link>

          <button
            className="menu-toggle"
            onClick={() => setMenuOpen(!menuOpen)}
            aria-label="Menu"
          >
            <img
              src="/icons/hamburguer.png"
              alt="Menu"
              className="hamburger-img"
            />
          </button>

          <nav className="nav-container">
            <ul className="nav-links">
              <li>
                <Link to="/">Início</Link>
              </li>

              <li>
                <Link to="/quem-somos">Quem somos</Link>
              </li>

              <li>
                <Link to="/materias">Notícias</Link>
              </li>

              <li className="dropdown">
                <Link to="/servicos">
                  Serviços <span className="arrow">▾</span>
                </Link>

                <ul className="dropdown-menu">
                  {subareas.map((s) => (
                    <li key={s}>
                      <Link to={`/servicos#categoria-${normalizeId(s)}`}>
                        {s}
                      </Link>
                    </li>
                  ))}
                </ul>
              </li>

              <li>
                <Link to="/portifolio">Portfólio</Link>
              </li>

              <li className="dropdown">
                <Link to="/legislacao">
                  Legislação <span className="arrow">▾</span>
                </Link>

                <ul className="dropdown-menu">
                  {subareas.map((s) => (
                    <li key={s}>
                      <Link to={`/legislacao#area-${normalizeId(s)}`}>
                        {s}
                      </Link>
                    </li>
                  ))}
                </ul>
              </li>
            </ul>
          </nav>
        </div>
      </div>

      <div
        className={`mobile-overlay ${menuOpen ? "active" : ""}`}
        onClick={() => setMenuOpen(false)}
      />

      <nav className={`mobile-menu ${menuOpen ? "active" : ""}`}>
        <ul>
          {["Início", "Quem somos", "Notícias", "Portfólio"].map((item) => (
            <li key={item}>
              <Link
                to={`/${
                  item === "Início"
                    ? ""
                    : item.toLowerCase().replace(" ", "-")
                }`}
              >
                {item}
              </Link>
            </li>
          ))}

          {[
            {
              name: "Serviços",
              key: "servicos",
              links: subareas.map((s) => [
                s,
                `/servicos#categoria-${normalizeId(s)}`,
              ]),
            },
            {
              name: "Legislação",
              key: "legislacao",
              links: subareas.map((s) => [
                s,
                `/legislacao#area-${normalizeId(s)}`,
              ]),
            },
          ].map((section) => (
            <li
              key={section.key}
              className={`has-sub ${
                openDropdown === section.key ? "open" : ""
              }`}
            >
              <a href="#" onClick={(e) => toggleDropdown(section.key, e)}>
                {section.name} <span>▾</span>
              </a>

              <ul>
                {section.links.map(([label, path]) => (
                  <li key={label}>
                    <Link to={path}>{label}</Link>
                  </li>
                ))}
              </ul>
            </li>
          ))}
        </ul>
      </nav>
      <Breadcrumb />
    </header>
  );
};

export default Header;
