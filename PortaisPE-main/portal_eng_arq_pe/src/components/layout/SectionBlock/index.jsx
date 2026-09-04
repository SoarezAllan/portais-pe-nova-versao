import React from 'react';
import { Link } from 'react-router-dom';
import styles from './style.module.css'; // Importando o CSS Modular

const SectionBlock = ({ id, title, linkTo, linkText, children }) => {
  return (
    <section id={id} className={styles.sectionContainer}>
      <div className={styles.headerContent}>
        <div className={styles.headerRow}>
          <h2 className={styles.title}>{title}</h2>
          
          {/* Botão Desktop - Escondido no Mobile via CSS Module */}
          <Link to={linkTo} className={`${styles.btn} ${styles.desktopBtn}`}>
            {linkText}
          </Link>
        </div>
      </div>

      {/* Aqui entram os seus Cards (Servicos ou Solucoes) */}
      <div className={styles.content}>
        {children}
      </div>

      {/* Botão Mobile - Escondido no Desktop via CSS Module */}
      <div className={styles.mobileBtnContainer}>
         <Link to={linkTo} className={`${styles.btn} ${styles.mobileBtn}`}>
            {linkText}
         </Link>
      </div>
    </section>
  );
};

export default SectionBlock;