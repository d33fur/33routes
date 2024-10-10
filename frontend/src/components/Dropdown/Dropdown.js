import React, { useState } from 'react';
import './Dropdown.css';

const Dropdown = ({ options, onSelect }) => {
  const [isOpen, setIsOpen] = useState(false); // Состояние для управления открытием/закрытием
  const [selectedOption, setSelectedOption] = useState(null); // Выбранный вариант

  const toggleDropdown = () => {
    setIsOpen(!isOpen); // Переключаем состояние выпадающего списка
  };

  const handleOptionClick = (option) => {
    setSelectedOption(option); // Устанавливаем выбранный вариант
    onSelect(option); // Вызываем функцию обратного вызова с выбранным вариантом
    setIsOpen(false); // Закрываем выпадающий список
  };

  return (
    <div className="dropdown">
      <button className="dropdown-toggle" onClick={toggleDropdown}>
        {selectedOption ? selectedOption.label : 'Выберите вариант'} {/* Показываем выбранный вариант */}
      </button>
      {isOpen && (
        <ul className="dropdown-menu">
          {options.map((option) => (
            <li key={option.value} className="dropdown-item" onClick={() => handleOptionClick(option)}>
              {option.label}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default Dropdown;
