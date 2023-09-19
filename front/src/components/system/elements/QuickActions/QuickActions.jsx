import Styles from './QuickActions.module.css'

import icon from '../../../../assets/photos/quick_actions_icon.png'

const QuickActions = (props) => {

    return (
        <>
            <div className={`${Styles.container}`}>
                <div className={`${Styles.button}`} onClick={props.toggle}>
                    <img src={icon} />
                </div>
                <div className={`${Styles.menu} ${props.isOpen && Styles.openedMenu}`}>
                    <p>Забронировать сеанс массажа</p>
                    <p>Купить стиральный порошок</p>
                    <p>Купить товары из корзины</p>
                </div>
            </div>
        </>
    )

}

export default QuickActions