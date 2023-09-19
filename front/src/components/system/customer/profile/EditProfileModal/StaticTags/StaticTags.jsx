import { Badge, Input } from 'reactstrap'
import Styles from './StaticTags.module.css'
import AddButtonContainer from '../../../../../UI/AddButton/AddButton.container'

const StaticTags = (props) => {

    return (
        <>
            <div className={`${Styles.tags}`}>
                {
                    props.tags.length === 0
                    &&
                    <h1><Badge>Нет тегов</Badge></h1>
                }
                {
                    props.tags.map(
                        (item, index) => {
                            return (
                                <h4 key={index}>
                                    <Badge color='primary'>
                                        {item.tag.name}
                                    </Badge>
                                </h4>
                            )
                        }
                    )
                }
            </div>
            <AddButtonContainer callback={props.toggle}/>
            {
                props.editFlag === true
                &&
                <div className={`${Styles.groups}`}>
                    {
                        props.groups.map(
                            (item, index) => {
                                return(
                                    <Input key={index} type='select' onChange={(event) => props.onChange(event)}>
                                        {
                                            item.items.map(
                                                (tag, tagIndex) => {
                                                    return(
                                                        <option key={tagIndex} value={tag.id}>{tag.name}</option>
                                                    )
                                                }
                                            )
                                        }
                                    </Input>
                                )
                            }
                        )
                    }
                </div>
            }
        </>
    )

}

export default StaticTags