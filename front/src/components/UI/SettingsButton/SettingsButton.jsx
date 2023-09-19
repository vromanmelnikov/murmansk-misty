import { Tooltip } from 'reactstrap'
import icon from '../../../assets/photos/settins_icon.png'

import Styles from './SettingsButton.module.css'

const SettingsButton = (props) => {

    return (
        <>
            <button className={`${Styles.button}`} id='settingsButton' onClick={props.click || function () {}}>
                <img src={icon} id='settingsButton' />

            </button>
            {/* <Tooltip
                autohide={true}
                isOpen={props.tooltipOpen}
                target="settingsButton"
                toggle={props.toggle}
            >
                Hello world!
            </Tooltip> */}
        </>

    )

}

export default SettingsButton