Received: from smarthost4.eviden.com (smarthost4.eviden.com [80.78.11.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528D2C21FF
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975131; cv=fail; b=YqD4ejnAlVU2XL3qJ66PDfJcERXfTVS4Gp+s3vG7Cgo3EYUMINh3CFfU4cYHOcNNk4+AimpxtNQ0Xz2mfOitLRnnXVGYmPoe7w3oy0G9b2HTFYOs2FgYo6hVHrZviulKEW7tFgO/0MQm4kwXrJICmOmw2/fa97h7rYZhgGERqKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975131; c=relaxed/simple;
	bh=+T9804akB7plV5Fhf+4l+OkRkejRMxAfy0ivVUVll7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKnjXqXK3s347Wh2Fg8qNlP4RrJUwEDBpItqa4mVwDEoxsox85v5yeYccMuf0MKAwLW7zLXXetew/QB0cuyz9XRsNdqr+FskL/SWxImhYscdaBPujiL3pXwt5HcPyiYkEfXuAvDZN09V3Svk51JQsamYLjfgK2jBq1+kxZ4PkCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com; spf=pass smtp.mailfrom=bull.com; dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b=F+BQQQP5; arc=fail smtp.client-ip=80.78.11.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bull.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b="F+BQQQP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=bull.com; i=@bull.com; q=dns/txt; s=mail;
  t=1777975127; x=1809511127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+T9804akB7plV5Fhf+4l+OkRkejRMxAfy0ivVUVll7w=;
  b=F+BQQQP5+B3HWgBP3tZW4cDlLpxOMBpsJfri1ARoohmzHhlRt/e72tUY
   pNqOoJlIF0Q9sVHt757ia6DKJ4pJMcp2r+sstiyHqhBlzowdzh98w1Rpc
   gPBP6idLDgv6Q8iYgFXhyRFRzSwNyRp6Np6FHw6QD2TjCbdL9AxCO7op0
   CPhKrXiUPXaQfoKMonxMuLIibZZAWIFRF77YdSUrubnrZ0fXhEBtsO17e
   2kwNmTFijsasQBbtm7+LXB5RTPqBK0NgTQZlbddpdUpqj8ONeQ0YLHJXq
   49YX1Nhp7NyOAPQAkrdLRUsPLgMVl37aQdbxwQ7PRB2T/dgc1ggn4u+D8
   A==;
X-CSE-ConnectionGUID: RztFkk87RJWQeiuYQVOPdQ==
X-CSE-MsgGUID: s94iy8J2RlS3YEj9/NO69Q==
IronPort-SDR: 69f9be1e_Yt/SnkC2bXXf9N9WuYdJ4ygMmPjLBN90RL/fPBNYb8xlSAy
 vlvuI2C1Wn/NaRMcBlbn9ZNiwCpSUuFjXzEMtHw==
X-IronPort-AV: E=Sophos;i="6.23,217,1770591600"; 
   d="scan'208";a="49970073"
X-MGA-submission: =?us-ascii?q?MDEcDxPoae4UM27Kt2tK/Rgi8S5Eibk28xUi5o?=
 =?us-ascii?q?puzg+frRyN6DcdI38DikHi/cyMtZi+7oVkfP6ypqdx5rATztOuFDfHT/?=
 =?us-ascii?q?+XXd9d6g05SZzdzmisbiK8q7b3CR054wF8iTqpwswcFjKsVmWZ6Der3R?=
 =?us-ascii?q?CByaeM5QDaG723L0HLdVj0LA=3D=3D?=
Received: from mail-francesouthazon11011059.outbound.protection.outlook.com (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.59])
  by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 May 2026 11:53:34 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vrl7+D3LUVsBB1402CKTD2EQiN9/i5lqSmv/gKgF0fzjWt70TS0nDumfg9dzv0MQus+N/NOVLJ+0d3uVxnB5OnBbXOraGFJdAVmUidjFHVtmANEdzhbPEYpkYx6lS1oUY+Z6rt3YGz0sgPHYsIDdYlhSdDYkiutAKeYC74hp0ViTwONvj9ybpSrPE0nFUGsjaMnc+4ZV5XwV3FD0Gy0wEBI7XO5qQIJBZ9rI9IgSnw8Q1Q0XQHgsxyrwZV5HxJoTjJ/tVjQmsxGFxPi+TFcHl0Nyl9lJmgFKdP0FI1V67vSSif7MaMBYMY3nIClIUn4DE7S2x9K5tFGa0shBsx6A3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+T9804akB7plV5Fhf+4l+OkRkejRMxAfy0ivVUVll7w=;
 b=ZA9bW2cK56Skj2ZvPYyhqZEd6DfHOYDTf794rLM+37/xh5/BONRan+gr2s5F1KegdIVeQ/EGFkVDh39VPG+4UML9ncZr25iLt1WR/WN47nlCMcMVLvJrLZpZoYvOPmUXlX2ian9wA+74pyDJMNeuM5n+7mLoR8A6zNW1PwOxmk0Iyo1UPGjqm/TfiK+RiuCiz0mbJfJn1D+WdbgFnzqyet0/LaEd9ffSeyTfcOn5AQJ9xPzuyv9nSALZdC2s9+XaxJBwrUA6ZDpMyPiv7Yxhsm4Kf5ghsvT1bXnwf3HEtMQJ0oUBsJrzLI9W+SGWVgJczLMxkwNRvtEGpJnsRx2pjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAXPR07MB8031.eurprd07.prod.outlook.com (2603:10a6:102:15e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:53:30 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:53:30 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
	<clement.mathieu--drif@bull.com>
To: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
Subject: Re: intel_iommu unit test is also failing
Thread-Topic: intel_iommu unit test is also failing
Thread-Index: AQHc3HPmLdBmXv9RqkCVNWPmcI+ykbX/MPQA
Date: Tue, 5 May 2026 09:53:30 +0000
Message-ID: <0e67d95e01efb0823fe07cd556461ad3d9a0709a.camel@bull.com>
References: <20240604143507.1041901-1-pbonzini@redhat.com>
	 <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
	 <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com>
	 <afi_HNJoObF10rwz@x1.local>
	 <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
	 <0abf41c113c9425ea4c73a108db22f28290fa395.camel@bull.com>
	 <13002aef21dec62205c252f3d12bb42ea59cf287.camel@bull.com>
	 <d4ae6782e30a05ea9d56c38f0c5d296fb6a5c7b1.camel@bull.com>
	 <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
In-Reply-To: <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAXPR07MB8031:EE_
x-ms-office365-filtering-correlation-id: e40763c4-f582-48d9-1885-08deaa8c29e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 FWftVT7eEzZb5NV+hYIiQNpN7s+kySRFblSV/aMYLqxKsMPfhnlj4KW2aAJD9PPfVdUUDAD9EJoyKT1+/c5NOzRj7tl/sKwFOiGARd1m0BaHdcGsjdoqDFykKW6kehQU06HYWM7EpyLP+dOb/I6ggI70xxhgTo+hqM5lmOzpoIHqSva5F6zJsgTVPsG7uaI4H9LFhlk+PMG4toRFcVh9MWrMy2neZqn8v7lJbuXpfuH8QoDM/HW7tVySUXRoMNghqdZgqjaGu9Rg8RgEfj7ItBG8wTC24rAy3ekpFZAd6Nc8M4jUE2Nf5L13wxAIDVa5ohN2GdKldeoR77Wfx3vATdZ1pqaFCBUb0pQ3M7aNutMCLDesRKCh5fjaMdN/8aI888pL6rfUzCNq4djSlv1rpiQufFu+HQN9EGjZf14n1a1ASWaA2CygG0rJ4JH09rGG1dSp/JUK1QuRgXFgnQQQSJ0NhaLeJ/5n3QrGkw/0dn3m4u5vl92O24EeN1MRauvOdPOpkXnyEVzosjvJR6nw1Tb8/Ive8TZqnDYh0k7IldCyhkfdDWa+3N/mTMbNkOnY7ZejoAveRrHOYFe9hRc4f89vC+QkW6EiNRSxtiOCd1Q5celDewoaDqdHbymwrn4iL/IO1gDEqZaU9lgK0syB38Uh32N3vNVv2wFHZJ4Q3rFTssszXfnJX6hnU5GbBnR23moAQ0GXxwazdWJ2i7dObQ/thSMutQ2+H5k8dZvhagmNmol1SSjqMukRyk7Owfs7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB7602.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZURNOUpwMWpENkx6Mnh5OVFyMDBCajJ5RHBYZ29IdkRVZUZpN2k3bmlSMHNa?=
 =?utf-8?B?dkh2eUcreUhPakYrblBJWjR1TXpWZnFUaEJjWDhSUWR2VFZFdjQrdnFyVk9I?=
 =?utf-8?B?bHd3a2JMTGZLcUd3RU94TWx0UXV0YzlCRlBYbVJ0U3JBb2NOTmltSGl2RFlW?=
 =?utf-8?B?T2NtUDVWTEsweUE3WjNmeFJaMVdNMENnT21ycDFJdlM1STFiWHRqYVQvZzNt?=
 =?utf-8?B?bmhIdmEwNEpaanNPcEx5d0Jzc0FyNVFjejRzeUMwdjViTkRBS055dWN1WjlB?=
 =?utf-8?B?eTRxSUVpcXNsWHNpWnFFMWhacUgyTnNxQ21lcUMxeU01elVmdUJRdVZRREty?=
 =?utf-8?B?MlBzVGtYaU5hRmt2TWRLNnVzL3p5amhucWVyelQ2NGEzQVgyMXYzVzkxTkJm?=
 =?utf-8?B?WjVZYmJoTTJVZFNTT2FBWCtQdXZtQXNwSDlJcmNXMEs0VVd4SitvaklKdUdU?=
 =?utf-8?B?dXk3Uzd5SmJRQzdlWGZhZ1FtQVNCcktFMll2TVZXZGxZbzlZYUJEOHI0dDUz?=
 =?utf-8?B?clh1SkxCWjhyc2xQZGNVaGhkTCtNTnJ0NW1IUTJTZEFqb0JMWkZIaHhTSzJV?=
 =?utf-8?B?WlJ4SitFZnRvdXpOSHR5VWdWU1pYSHdSZysyL2Zkb1lCNnFsVk52YzAxblJm?=
 =?utf-8?B?NjVHeVBNWlJtdmF3SGRSK0g4YzlTVCtuQmYvdk5JUVZ5bTFDb25Tb2NpQVkx?=
 =?utf-8?B?Mm1oWWtFb081YUQ5RGFEcnBMMVIwSTNYeHJudElPYndUK2xuMzlCL0xlNFRj?=
 =?utf-8?B?cjJ6SXFudllEMHpIWEs3VjBON1dpaGhDdEVPaXdoUHVoWVp4eHk3dTJHeXRs?=
 =?utf-8?B?bHlyZkNwRFpaT3lBeTM2WG81SW9PUW9pUjhkU0dTSzc1QjRzMHRYQjVjUjl5?=
 =?utf-8?B?MFd5T2FvNlh3endaMThnc0Z4bWI4dUFUUDNLR3NNOTFiV08wc3h0b3BYSFpn?=
 =?utf-8?B?NlprZHErWFd6TUxXdlYxcDM1bUZORUxBRldtellMdEpJa0FIT0ZzS0V5QjV5?=
 =?utf-8?B?ZE5aSEQzN2ExOXdnSFovTUxNUnNuYWgyanNZc0xpaWZsbDJQYmNEWTk3QjdE?=
 =?utf-8?B?VU9hTEZnZXBNL1pFT0pwYno1VWpYQkNRTGEzMVdGbzJQT1BISmFYd2x2LzFz?=
 =?utf-8?B?L1dTaXIvTEd6M3FmUk9WUi85SVFSSFZBZEpKOVRjTXU3b2svMzgrdXkwU0Rj?=
 =?utf-8?B?RVdqQUoyV1BLSG5hZnloSmVPSzV5bnZrTVFOTkhmT1IyL1ZmOWZ3OXEzRml3?=
 =?utf-8?B?YlM3V3VhTWVOcFRuWnRYMitvb3NoSWEvVStuUC9nemtZRVZVR0NrZ1pSdU45?=
 =?utf-8?B?MnNiQ0FjbXFpeGk1cUs0cjNwSUR1ajk3QWR5dEJ6N1J3Z3cvY1Bua0FneDlX?=
 =?utf-8?B?MGQ4VjhwTWc2dTFWbVUyL0lYU3gwUUJmZVUzUEFrOC9ydDI1SWs3Wmt6cGxk?=
 =?utf-8?B?OGlZUmlBRkxmSHJuNm1NbHRkclBzK2wvckZMWVplRGdMK29TMldrSFk3dGd2?=
 =?utf-8?B?cHJST0xJTURRSndiSlJlRlZvbGlQRTFTS3A1OGJ6TG1jWExMc0lsc0JyQ3Vl?=
 =?utf-8?B?VSt6cGZscE93OFJSYzJOL08vUDBYekQ2bTVWVXA3TmZxL1VOVTJwV3FYQURC?=
 =?utf-8?B?aUJ3TVhBcGk2b05rVGFBald0alhjYS9JWFA3a1hmNFNxcVh1by9MY0ZvSjB0?=
 =?utf-8?B?Sk05elRPcUxraE1EZnNLUmYzUlg5QzZqcWhyVEdGdU1SZHpoV0tsanoxTTd1?=
 =?utf-8?B?Y2tsZTRtK2VTWEtPTnNoTnAzdjJPZVVmMTJPdEwrY3NkZk1SVTVWMTV4c0Vy?=
 =?utf-8?B?THFOR0F3cVVHOGZONTRndXRPUDY5SnZ2bE5Wamg4Q1dvaDl6MWNXNk5wMG8v?=
 =?utf-8?B?UUY1T3c5Wmo4c2RBUk9xQnMzYVU2NUlRZjVXMWUvOGpTWE5ESVhacUhYUUZD?=
 =?utf-8?B?OGR1L0ZHTlpOelROTURhbDdqbTNJdi9rMXJ3VTBnZEN6VGc4VS9ucFE0N0JD?=
 =?utf-8?B?RTdPaDQyTFBybGNJZGZuU1dIbmFhRmh1TUxiUWpaby8rejVuRU5VUjBjWm9R?=
 =?utf-8?B?OUh4VWV3OVBWSXJmZTJtOWRCdVlJcXpRSFZXWERMYytNS0N1Y1FCN0lRMXJT?=
 =?utf-8?B?Z3MwdW82d1hqaW83WTdXMTJxUEF6KzBONnpYSW1GdTZmRFhPdXFYVHpydDBC?=
 =?utf-8?B?Ti9Hb2lQeG1adGlnL3JDNDhUcVJTa3N4d1VXbGpjNFI1UUFxaStmUGNac2pF?=
 =?utf-8?B?SzB4Z1lMNDBrY2U2ZG9USjBpMnBvRHdpRDJZVHMwTzI2QlZ5TmJCdnFBSDZh?=
 =?utf-8?B?VTFxNWpRdW5ucG5kU0hxM0FkSmpvU0w0YmJHOTE0MXM5d1A4bGRBS2dsNURo?=
 =?utf-8?Q?gf/XAVJQmfKEHCsLhcwnQvoI9rFLTBt62iwYa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <759AE90200122044825166E61272DB97@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	a4i7eYkncCwLtNjtVxKySx9ixSrbKXHgiS8f58VVuXWVMJTpk1PUsY36XFN6DCiRqEnaVO+GWfIrCpew/7co9SaGzR2T4WQDEnhvRMZBucFKiniZenppzYEAMLxG3XyMBH5IXOfgTcizdfyEsm/PpYGaVYi7W3NUhqt4uVg80+E26lo19yg6egITsIMVf7OAbQ3+s9CsKp4DXMEWcqvi68wvEx/01RHrh5cJJ/KulAYK0hHnptboOrACuBHiAmjSdD8WQo1XxEooskYFYmtO3vyM4EhWan26czmoDLnhlmGqc50wuTlQqd6Y4EWg/Lq5agXt469kDJhvpMIzkkC8yw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40763c4-f582-48d9-1885-08deaa8c29e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 09:53:30.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2bmYqnAYxHb/HijVXYjKgWS5DMDhicIM1tRbEf59GU+m3J/ouq1hxd6p3urCWKhvej+sR9A9FNpFge7gbf09I4ZDcGfFgjxFP3id0JATVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8031

CgpPbiBUdWUsIDIwMjYtMDUtMDUgYXQgMTE6NDUgKzAyMDAsIFRob21hcyBIdXRoIHdyb3RlOgo+
IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGlj
ayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4KPiAKPiAKPiBPbiAwNS8wNS8yMDI2IDExLjI3
LCBDbMOpbWVudCBNQVRISUVVLS1EUklGIHdyb3RlOgo+IAo+ID4gSSBoYWQgYSBiaXQgbW9yZSB0
aW1lIHRvIGhvb2sgaW50byBxZW11IHRvIGNoZWNrIHRoZSByb290IGNhdXNlLgo+ID4gCj4gPiBJ
dCBzZWVtcyB0aGF0IHRlc3RiIGlzc3VlcyBhIHNpbmdsZSBieXRlIHJlYWQgKG91dCBvZiB0aGUg
dmFsaWQgc2l6ZSByYW5nZSksIGFzIHdlIGNhbiBzZWUgb24gdGhlIGZvbGxvd2luZyBicmVha3Bv
aW50Ogo+ID4gCj4gPiBgYGAKPiA+IFRocmVhZCA2ICJDUFUgMC9UQ0ciIGhpdCBCcmVha3BvaW50
IDIsIG1lbW9yeV9yZWdpb25fZGlzcGF0Y2hfcmVhZCAobXI9MHg1NWQ3Mjg4M2NiMzAsIGFkZHI9
MTUyLCBwdmFsPTB4N2Y2MmQyNWY0NTkwLCBvcD1NT19CU1dBUCwgYXR0cnM9Li4uKSBhdCAuLi9z
eXN0ZW0vbWVtb3J5LmM6MTQ3Mwo+ID4gMTQ3M8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBzaXplID0g
bWVtb3Bfc2l6ZShvcCk7Cj4gPiAoZ2RiKSBuCj4gPiAxNDc0wqDCoMKgwqDCoMKgIE1lbVR4UmVz
dWx0IHI7Cj4gPiAoZ2RiKSBwIHNpemUKPiA+ICQxID0gMQo+ID4gKGdkYikKPiA+IGBgYAo+IAo+
IAo+IE91Y2ghIFRoYXQncyBhbiBleGNlbGxlbnQgZmluZGluZywgQ2zDqW1lbnQgLi4uIHNvIEdD
QyAxNiBpcyAic21hcnQiIGVub3VnaCAgCj4gdG8gc2VlIHRoYXQgd2Ugb25seSB3YW50IHRvIHRl
c3QgdGhlIGxvd2VzdCBiaXQgaGVyZSwgc28gaXQgb3B0aW1pemVzIHRoZSAgCj4gY29kZSB0byBh
Y2Nlc3Mgb25seSBvbmUgYnl0ZSBvZiBtZW1vcnkgaW5zdGVhZCBvZiA0IGJ5dGVzLi4uIHdoaWNo
IHdvdWxkIGJlICAKPiBvayBmb3Igbm9ybWFsIG1lbW9yeSwgYnV0IG5vdCBmb3IgYW4gTU1JTyBy
ZWdpc3RlciA6LS8KPiAKPiBVZ2x5IHdvcmstYXJvdW5kLCB0byBmb3JjZSBHQ0MgdG8gcmVhZCAz
MiBiaXRzOgo+IAo+IGRpZmYgLS1naXQgYS9saWIvYXNtLWdlbmVyaWMvaW8uaCBiL2xpYi9hc20t
Z2VuZXJpYy9pby5oICAKPiAtLS0gYS9saWIvYXNtLWdlbmVyaWMvaW8uaCAgCj4gKysrIGIvbGli
L2FzbS1nZW5lcmljL2lvLmggIAo+IEBAIC0zOCw3ICszOCw5IEBAIHN0YXRpYyBpbmxpbmUgdTE2
IF9fcmF3X3JlYWR3KGNvbnN0IHZvbGF0aWxlIHZvaWQgKmFkZHIpICAKPiDCoCAjaWZuZGVmIF9f
cmF3X3JlYWRsICAKPiDCoCBzdGF0aWMgaW5saW5lIHUzMiBfX3Jhd19yZWFkbChjb25zdCB2b2xh
dGlsZSB2b2lkICphZGRyKSAgCj4gwqAgeyAgCj4gLcKgwqDCoMKgwqDCoCByZXR1cm4gKihjb25z
dCB2b2xhdGlsZSB1MzIgKilhZGRyOyAgCj4gK8KgwqDCoMKgwqDCoCB1MzIgdmFsID0gKihjb25z
dCB2b2xhdGlsZSB1MzIgKilhZGRyOyAgCj4gK8KgwqDCoMKgwqDCoCBhc20gdm9sYXRpbGUgKCJc
biIgOiA6ICJyIihhZGRyKSk7ICAKPiArwqDCoMKgwqDCoMKgIHJldHVybiB2YWw7ICAKPiDCoCB9
ICAKPiDCoCAjZW5kaWYKPiAKPiAuLi4gYnV0IEkgd29uZGVyIHdoZXRoZXIgdGhpcyBzaG91bGQg
cmF0aGVyIGJlIHRyZWF0ZWQgYXMgYSBidWcgaW4gR0NDICAKPiBpbnN0ZWFkLCBzaW5jZSBpdCBz
aG91bGQgSU1ITyByZWFsbHkgbm90IGNoYW5nZSB0aGUgYWNjZXNzIHNpemUgZm9yIGEgIAo+IHZv
bGF0aWxlIG1lbW9yeSBhY2Nlc3M/CgpWb2xhdGlsZSBpcyBleHBlY3RlZCB0byBtYWtlIHN1cmUg
dGhhdCB0aGUgcmVhZCBzaWRlIGVmZmVjdCBpcyB2aXNpYmxlLiAgCkkgZG9uJ3Qga25vdyBpZiB0
aGUgc2l6ZSBvZiB0aGUgYWNjZXNzIGlzIGluIHRoZSBzY29wZSBvZiB0aGlzIGNvbnN0cmFpbnQg
b3Igbm90IG8uTyAgCgo+IAo+IMKgIFRob21hcwo+IAo+IAo+IAo+ID4gY21kCj4gPiAKPiA+IE9u
IFR1ZSwgMjAyNi0wNS0wNSBhdCAwOTozNiArMDIwMCwgQ2xlbWVudCBNYXRoaWV1LS1EcmlmIHdy
b3RlOgo+ID4gCj4gPiA+IEJhY2sgd2l0aCBzb21lIGFuc3dlcnM6Cj4gPiA+IAo+ID4gPiBUaGlz
IGlzIHRoZSBpbmNyaW1pbmF0ZWQgaHVuazoKPiA+ID4gCj4gPiA+IGBgYGRpZmYKPiA+ID4gLS0t
IDx1bm5hbWVkPgo+ID4gPiArKysgPHVubmFtZWQ+Cj4gPiA+IEBAIC0xLDE3ICsxLDE2IEBACj4g
PiA+IC3CoCA0MDQzOTU6wqDCoMKgwqDCoMKgIDhiIDgwIDk4IDAwIDAwIDAwwqDCoMKgwqDCoMKg
IG1vdsKgwqDCoCAweDk4KCVlYXgpLCVlYXgKPiA+ID4gK8KgIDQwNDQxZDrCoMKgwqDCoMKgwqAg
OGIgNDMgMzjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbW92wqDCoMKgIDB4MzgoJWVi
eCksJWVheAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgZWR1X3JlZ193cml0ZXEoZGV2LCBFRFVf
UkVHX0RNQV9EU1QsIHRvKTsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGVkdV9yZWdfd3JpdGVx
KGRldiwgRURVX1JFR19ETUFfQ09VTlQsIHNpemUpOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAg
ZWR1X3JlZ193cml0ZWwoZGV2LCBFRFVfUkVHX0RNQV9DTUQsIGNtZCk7Cj4gPiA+IAo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqAgLyogV2FpdCB1bnRpbCBETUEgZmluaXNoZWQgKi8KPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgIHdoaWxlIChlZHVfcmVnX3JlYWRsKGRldiwgRURVX1JFR19ETUFfQ01E
KSAmIEVEVV9DTURfRE1BX1NUQVJUKQo+ID4gPiAtwqAgNDA0MzliOsKgwqDCoMKgwqDCoCBhOCAw
McKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0ZXN0wqDCoCAkMHgxLCVhbAo+
ID4gPiAtwqAgNDA0MzlkOsKgwqDCoMKgwqDCoCA3NCAxMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBqZcKgwqDCoMKgIDQwNDNhZiA8ZWR1X2RtYSsweDEyMT4KPiA+ID4gLcKg
IDQwNDM5ZjrCoMKgwqDCoMKgwqAgZjMgOTDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcGF1c2UKPiA+ID4gLcKgIDQwNDNhMTrCoMKgwqDCoMKgwqAgNDjCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjwqDCoMKgICVlYXgKPiA+ID4gLcKgIDQw
NDNhMjrCoMKgwqDCoMKgwqAgOGIgNDMgMzjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bW92wqDCoMKgIDB4MzgoJWVieCksJWVheAo+ID4gPiAtwqAgNDA0M2E1OsKgwqDCoMKgwqDCoCA4
YiA4MCA5OCAwMCAwMCAwMMKgwqDCoMKgwqDCoCBtb3bCoMKgwqAgMHg5OCglZWF4KSwlZWF4Cj4g
PiA+IC3CoCA0MDQzYWI6wqDCoMKgwqDCoMKgIGE4IDAxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRlc3TCoMKgICQweDEsJWFsCj4gPiA+IC3CoCA0MDQzYWQ6wqDCoMKgwqDC
oMKgIDc1IGYwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGpuZcKgwqDCoCA0
MDQzOWYgPGVkdV9kbWErMHgxMTE+Cj4gPiA+ICvCoCA0MDQ0MjA6wqDCoMKgwqDCoMKgIGY2IDgw
IDk4IDAwIDAwIDAwIDAxwqDCoMKgIHRlc3RiwqAgJDB4MSwweDk4KCVlYXgpCj4gPiA+ICvCoCA0
MDQ0Mjc6wqDCoMKgwqDCoMKgIDc0IDBmwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGplwqDCoMKgwqAgNDA0NDM4IDxlZHVfZG1hKzB4MTFmPgo+ID4gPiArwqAgNDA0NDI5OsKg
wqDCoMKgwqDCoCBmMyA5MMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXVz
ZQo+ID4gPiArwqAgNDA0NDJiOsKgwqDCoMKgwqDCoCA0OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkZWPCoMKgwqAgJWVheAo+ID4gPiArwqAgNDA0NDJjOsKgwqDC
oMKgwqDCoCA4YiA0MyAzOMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtb3bCoMKgwqAg
MHgzOCglZWJ4KSwlZWF4Cj4gPiA+ICvCoCA0MDQ0MmY6wqDCoMKgwqDCoMKgIGY2IDgwIDk4IDAw
IDAwIDAwIDAxwqDCoMKgIHRlc3RiwqAgJDB4MSwweDk4KCVlYXgpCj4gPiA+ICvCoCA0MDQ0MzY6
wqDCoMKgwqDCoMKgIDc1IGYxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGpu
ZcKgwqDCoCA0MDQ0MjkgPGVkdV9kbWErMHgxMTA+Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY3B1X3JlbGF4KCk7Cj4gPiA+IMKgIH0KPiA+ID4gCj4gPiA+ICsgaXMg
Z2NjIDE2Cj4gPiA+IC0gaXMgZ2NjIDE1Cj4gPiA+IAo+ID4gPiBUaGUgaW5zdHJ1Y3Rpb25zIGdl
bmVyYXRlZCBieSBnY2MgMTYgYWx3YXlzIHNraXAgdGhlIGZvbGxvd2luZyBjb25kaXRpb246Cj4g
PiA+IAo+ID4gPiBgYGAKPiA+ID4gwqDCoMKgwqDCoMKgIC8qIFdhaXQgdW50aWwgRE1BIGZpbmlz
aGVkICovCj4gPiA+IMKgwqDCoMKgwqDCoCB3aGlsZSAoZWR1X3JlZ19yZWFkbChkZXYsIEVEVV9S
RUdfRE1BX0NNRCkgJiBFRFVfQ01EX0RNQV9TVEFSVCkKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjcHVfcmVsYXgoKTsKPiA+ID4gYGBgCj4gPiA+IAo+ID4gPiBBcyBhIGNvbnNl
cXVlbmNlLCB0aGUgdGVzdCBwZXJmb3JtcyB0aGUgc2Vjb25kIGRtYSBvcGVyYXRpb24gdG9vIGVh
cmx5IGFuZCByZWFkcyBhIHdyb25nIHZhbHVlLgo+ID4gPiAKPiA+ID4gUmVnYXJkcywKPiA+ID4g
Y21kCj4gPgo+IAo+IAo=
