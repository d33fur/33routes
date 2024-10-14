import React, { useState } from 'react';
import './Toggle_switch.css';

const ToggleSwitch = ({ onToggle }) => {
  const [isOn, setIsOn] = useState(false);

  const handleToggle = () => {
    setIsOn(!isOn); // Переключаем значение
    onToggle(!isOn); // Вызываем функцию обратного вызова, если передана
  };

  return (
    <div className="toggle-switch">
      <input
        type="checkbox"
        className="toggle-switch-checkbox"
        id="toggleSwitch"
        checked={isOn}
        onChange={handleToggle}
      />
      <label className="toggle-switch-label" htmlFor="toggleSwitch">
        <span className="toggle-switch-inner" />
        <span className="toggle-switch-switch" />
      </label>
    </div>
  );
};

export default ToggleSwitch;
