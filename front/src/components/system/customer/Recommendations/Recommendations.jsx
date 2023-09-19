import { Badge, Button, Card } from 'reactstrap'
import Styles from './Recommendations.module.css'
import API_CONFIG from '../../../../config/api.config'

import fullHeartIcon from '../../../../assets/photos/heart_full.png'

const Recommendations = (props) => {

    return (
        <div className={`${Styles.page} container`}>
            {
                props.tags.map(
                    (item, index) => {
                        return (
                            <div className={`${Styles.tagContainer}`}>
                                <h1 className={`${Styles.tagName}`}><Badge color='primary'>{item.tag.name}</Badge></h1>
                                <Card className={`${Styles.tag}`} key={index}>
                                    {
                                        item.items.length !== 0
                                        ?
                                        item.items.map(
                                            (good, goodIndex) => {

                                                let url = good.preview_img

                                                if (url !== null && url.indexOf('http') === -1) {
                                                    url = `${API_CONFIG.PROD_BASE_URL}/files/${url}`
                                                }

                                                return (
                                                    <div key={goodIndex} className={`${Styles.item}`}>
                                                        <span
                                                            className={`${Styles.img}`}
                                                            style={{ backgroundImage: `url(${url})` }}
                                                        >
                                                            <img src={fullHeartIcon} onClick={() => props.likeGood(good.id)}/>
                                                        </span>
                                                        <span className={`${Styles.name}`} onClick={() => props.goToGood(good.id)}>{good.name}</span>
                                                    </div>
                                                )
                                            }
                                        )
                                        :
                                        <h2>Нет товаров</h2>
                                    }
                                </Card>
                            </div>
                        )
                    }
                )
            }

        </div>
    )

}

export default Recommendations