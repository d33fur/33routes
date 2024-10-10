import React from 'react';
import './Button.css';

const Button = ({ label, onClick, filled }) => {
  return (
    <button className={filled ? 'filled-button' : 'outlined-button'} onClick={onClick}>
      {label}
    </button>
  );
};

export default Button;
