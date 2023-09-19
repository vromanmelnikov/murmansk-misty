import Styles from './AddButton.module.css'

import icon from '../../../assets/photos/add_icon.png'

const AddButton = (props) => {

    return (
        <div className={`${Styles.button}`} onClick={props.callback}>
            <img src={icon} />
        </div>
    )

}

export default AddButton