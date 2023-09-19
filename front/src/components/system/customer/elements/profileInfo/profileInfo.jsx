import { Badge, Button, Card, Col, Container, Row } from 'reactstrap'
import Styles from './profileInfo.module.css'

import profileIcon from '../../../../../assets/photos/profile_icon.png'
import { useState } from 'react'
import SettingsButtonContainer from '../../../../UI/SettingsButton/SettingsButton.container'

const ProfileInfo = (props) => {


    return (
        <Card className='p-4 mt-3'>
            <Row className={`${Styles.main}`}>
                {
                    props.isPersonal === true
                    &&
                    <div className={`${Styles.editButton}`}>
                        <Button onClick={props.editProfile}>
                            Редактировать
                        </Button>
                        <Button color='danger' onClick={props.logout}>
                            Выйти
                        </Button>
                    </div>
                }
                <Col xs='3'>
                    <div
                        className={`${Styles.img}`}
                        style={{ backgroundImage: `url(${props.user.img || profileIcon})` }}
                        onClick={props.updateImage}
                    >

                    </div>
                </Col>
                <Col xs='6' className={`${Styles.info}`}>
                    <Row xs='12'>
                        <h1 className={`${Styles.name}`}>{props.user.lastname} {props.user.firstname} {props.user.patronymic}</h1>
                    </Row>
                    <Row xs='12'>
                        <h3 className={`${Styles.rowHeader}`}>
                            Хакактеристики пользователя
                            {
                                props.isPersonal &&
                                <SettingsButtonContainer />
                            }
                        </h3>
                        <div className={`${Styles.tags}`}>
                            {
                                props.userTags?.static.map(
                                    (item, index) => {
                                        return (
                                            <h5 key={index}>
                                                <Badge className={`${Styles.tag}`} color='primary'>{item.tag.name}</Badge>
                                            </h5>
                                        )
                                    }
                                )
                            }
                            {
                                props.userTags.static.length === 0
                                &&
                                <h5>
                                    <Badge className={`${Styles.tag}`}>Нет тегов</Badge>
                                </h5>
                            }
                        </div>
                    </Row>
                    <Row xs='12'>
                        <h3 className={`${Styles.rowHeader}`}>
                            Интересы пользователя
                            {
                                props.isPersonal &&
                                <SettingsButtonContainer />
                            }
                        </h3>
                        <div className={`${Styles.tags}`}>
                            {
                                props.userTags.dinamic.length === 0
                                &&
                                <h5>
                                    <Badge className={`${Styles.tag}`}>Нет тегов</Badge>
                                </h5>
                            }
                            {
                                props.userTags.dinamic.map(
                                    (item, index) => {
                                        return (
                                            <h5 key={index}>
                                                <Badge className={`${Styles.tag}`} color='primary'>{item.tag.name}</Badge>
                                            </h5>
                                        )
                                    }
                                )
                            }
                        </div>
                    </Row>
                </Col>
            </Row>
        </Card>
    )
}

export default ProfileInfo