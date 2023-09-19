import API_CONFIG from "../config/api.config";
import axiosInstance from "../config/axios.config";

class TagsService {

    static URL = `${API_CONFIG.PROD_BASE_URL}/tags`

    static getTagsGroups() {

        const url = `${this.URL}/group_tag`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static getAllTags() {

        const url = `${this.URL}/all?limit=100&offset=0`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static addTagToUser(id) {

        const url = `${API_CONFIG.PROD_BASE_URL}/users/tag_links?tags=${id}`
        
        let config = {
            method: 'post',
            url
        };

        return axiosInstance.request(config)

    }

}
export default TagsService