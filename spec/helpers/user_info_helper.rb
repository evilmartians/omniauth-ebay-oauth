# frozen_string_literal: true

module UserInfoHelper # :nodoc:
  def stub_response_with_bad_code
    stub_request(:post, endpoint)
      .with(body: request_body, headers: headers)
      .to_return(status: 400, body: '', headers: {})
  end

  def stub_response_with_bad_status
    stub_request(:post, endpoint)
      .with(body: request_body, headers: headers)
      .to_return(status: 200, body: failure_body, headers: {})
  end

  def stub_successful_response
    stub_request(:post, endpoint)
      .with(body: request_body, headers: headers)
      .to_return(status: 200, body: successful_body, headers: {})
  end

  def failure_body
    %(
			<?xml version="1.0" encoding="UTF-8"?>
			<GetUserResponse xmlns="urn:ebay:apis:eBLBaseComponents">
				<Timestamp>2017-11-07T09:23:35.269Z</Timestamp>
				<Ack>Failure</Ack>
				<Errors>
					<ShortMessage>Invalid IAF token.</ShortMessage>
					<LongMessage>IAF token supplied is invalid. </LongMessage>
					<ErrorCode>21916984</ErrorCode>
					<SeverityCode>Error</SeverityCode>
					<ErrorClassification>RequestError</ErrorClassification>
				</Errors>
				<Version>1031</Version>
				<Build>E1031_CORE_API_18535225_R1</Build>
			</GetUserResponse>
		)
  end

  def successful_body
    %(
      <?xml version="1.0" encoding="UTF-8"?>
      <GetUserResponse xmlns="urn:ebay:apis:eBLBaseComponents">
        <Timestamp>2017-11-03T20:37:11.550Z</Timestamp>
        <Ack>Success</Ack>
        <Version>1031</Version>
        <Build>E1031_CORE_API_18535225_R1</Build>
        <User>
          <AboutMePage>false</AboutMePage>
          <EIASToken>nY+sHZ2PrBmdj6wVnY+sEZ2PrA2dj6wFk4GnC5iFoA6dj6x32Y+seQ==</EIASToken>
          <Email>john_appleseed@gmail.com</Email>
          <FeedbackScore>500</FeedbackScore>
          <UniqueNegativeFeedbackCount>0</UniqueNegativeFeedbackCount>
          <UniquePositiveFeedbackCount>0</UniquePositiveFeedbackCount>
          <PositiveFeedbackPercent>0.0</PositiveFeedbackPercent>
          <FeedbackPrivate>false</FeedbackPrivate>
          <FeedbackRatingStar>Purple</FeedbackRatingStar>
          <IDVerified>true</IDVerified>
          <eBayGoodStanding>true</eBayGoodStanding>
          <NewUser>false</NewUser>
          <RegistrationAddress>
            <Name>John Appleseed</Name>
            <Street>address</Street>
            <Street1>address</Street1>
            <CityName>city</CityName>
            <StateOrProvince>WA</StateOrProvince>
            <Country>US</Country>
            <CountryName>United States</CountryName>
            <Phone>1000085478</Phone>
            <PostalCode>98102</PostalCode>
          </RegistrationAddress>
          <RegistrationDate>2006-01-01T00:00:00.000Z</RegistrationDate>
          <Site>US</Site>
          <Status>Confirmed</Status>
          <UserID>john_appleseed</UserID>
          <UserIDChanged>true</UserIDChanged>
          <UserIDLastChanged>2017-11-01T12:06:44.000Z</UserIDLastChanged>
          <VATStatus>NoVATTax</VATStatus>
        </User>
      </GetUserResponse>
    )
  end
end
