import Styles from './header.module.css'

import { Button, Dropdown, DropdownItem, DropdownMenu, DropdownToggle, Input, Navbar, NavbarBrand, UncontrolledDropdown } from "reactstrap"

import logo from '../../../../assets/photos/logo.png'

import basketIcon from '../../../../assets/photos/basket.png'
import heartIcon from '../../../../assets/photos/heart.png'
import blueProfileIcon from '../../../../assets/photos/blue_profile_icon.png'
import searchIcon from '../../../../assets/photos/search_icon.png'
import notifIcon from '../../../../assets/photos/notifications_ion.png'

const Header = (props) => {

    return (
        <div className={`${Styles.header}`}>
            <div className={`${Styles.container} container`}>
                <NavbarBrand >
                    <img className={`${Styles.logo}`} src={logo} onClick={props.goToCatalog} />
                    <Button color='primary' className='m-4'>Каталог</Button>
                </NavbarBrand>
                <div className={`${Styles.searchPanel}`}>
                    <div className={`${Styles.search}`} id='search'>
                        <Input type='search' id='search-line' onChange={(event) => props.onValueChange(event)} value={props.searchValue} />
                    </div>
                    <div className='icon-button' onClick={props.findProduct}>
                        <img src={searchIcon} />
                    </div>
                </div>
                <div className={`${Styles.functionals}`}>
                    <div className='icon-button' onClick={props.goToBasket}>
                        <img src={basketIcon} />
                    </div>
                    <div className='icon-button' onClick={props.goToFavorities}>
                        <img src={heartIcon} />
                    </div>
                    <div className={`${Styles.notif} icon-button ms-4`}>
                        <img src={notifIcon} id='notif-target' />
                        {
                            props.notifDropdown
                            &&
                            <div className={`${Styles.notifDropdown}`} id='search-menu'>
                                <div >
                                    <p className={`${Styles.acceptspa1n}`}>Вы часто бронировали услугу "Стрижка мужская". Запланируем ее на 19 число каждого месяца?</p>
                                    <Button color='success' className={`${Styles.acceptButton}`} >
                                        Принять
                                    </Button>

                                </div>
                                <div className={`${Styles.accept}`}>
                                    <p className={`${Styles.acceptspa1n}`}>Запланированный товар "Стиральный порошок" куплен</p>
                                </div>
                                <div className={`${Styles.accept}`}>
                                    <p className={`${Styles.acceptspa1n}`}>Вы часто смотрели товар "Носки мужские". Добавим товар в избранное?</p>
                                    <Button color='success' className={`${Styles.acceptButton}`} >
                                        Принять
                                    </Button>

                                </div>
                            </div>
                        }
                    </div>
                    <div className='icon-button' onClick={props.goToProfile} >
                        <img src={blueProfileIcon} />
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Header