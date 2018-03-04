import scrapy

class LiquorSpider(scrapy.Spider):
    SIZE_VALUE_XPATH_SELECTOR = "//*/text()[normalize-space(.)='Size:']/../../span[2]/text()"
    TYPE_VALUE_XPATH_SELECTOR = "//*/text()[normalize-space(.)='Varietal/Type:']/../../span[2]/text()"
    name = "liquor"
    start_urls = ["http://www.theliquorbarn.com/spirits/?page=1"]

    def parse(self, response):
        for liquor in response.css('h3.product-item-title'):
            liquor_link = liquor.css('a::attr(href)').extract_first()
            yield scrapy.Request(liquor_link, callback=self.parse_liquor_link)

        next_page = response.css('a.pagination-item.next::attr(href)').extract_first()
        if next_page is not None:
            yield response.follow(next_page, callback=self.parse)

    def parse_liquor_link(self, response):
        yield {
            'title':
            response.css('h1.single-product-title::text').extract_first().strip(),
            'size': response.xpath(self.SIZE_VALUE_XPATH_SELECTOR).extract_first(),
            'type': response.xpath(self.TYPE_VALUE_XPATH_SELECTOR).extract_first(),
            'link': response.url
        }
