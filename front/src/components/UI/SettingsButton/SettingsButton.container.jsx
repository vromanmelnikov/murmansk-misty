import { useState } from "react";
import SettingsButton from "./SettingsButton"

const SettingsButtonContainer = (props) => {

    const [tooltipOpen, setTooltipOpen] = useState(false);
    const toggle = () => setTooltipOpen(!tooltipOpen);

    const propsData = {
        tooltipOpen,
        toggle,
        click: props.click
    }

    return (
        <SettingsButton {...propsData} />
    )
}

export default SettingsButtonContainer