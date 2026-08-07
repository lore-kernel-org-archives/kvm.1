Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351683C8C60
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.28.197.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093041; cv=fail; b=sl0BtMkNBXavY/b6quKYKk9n05xphenQFJDMM2QATvKqu+iJ9XyP23fbCF0SBLFDq0fvRhu0/hOT9w+fTaOTKbl3svBqT7KxGVufI/8y/jN0xK8VD0bwOr9N8yRyFDL+lDbo54KXJokMSXPbHrtNwYkzF4YwkXIGfO5zUqb91I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093041; c=relaxed/simple;
	bh=BRY+cDyEwd+r+S+jlFpfhO2jln5LVCAtTxhfnUQAjn8=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:Date:Message-ID:
	 References:In-Reply-To:MIME-Version; b=UeOny68QHKh1JS5uQZskIvJnHUgW+d03BkrUZkDqcek2oBvWbAB9wIfy7mivwy1iE7Z1L6NZwysmwJumELbaXoqyCuUFJk2CfHHNcIYTZjMIUQrmov0hS1TGNqOea/y2c2xFJoUJ5IOQJgqEXBCFlvkHUv4aCKIvVNWt572iZIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=HU0gwVl0; arc=fail smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="HU0gwVl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1786093039; x=1817629039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to;
  bh=8jE79DX95pYOGYxCDFNTIJqGtGQ9N1SfQi9RxgZECMQ=;
  b=HU0gwVl0ztMLR4+bT2AjsZRHLdmchchbjOqnl0mJP1xVXeI78POxAnkJ
   JuDAhDxAX2ruvGRUkRdy/Bcjzy6FRoWZ/SfueuRWIcvCZTKASC0AXNJu/
   4jr0hCJ7eZu6OJ7Zn436buo0DFzO7qCmVI3GJjlmH4aU2XXttAx4SOvFW
   uIPnC60r0YwiY4iFnGQlmwWOx4vFcu9ckfDLlPQj4yjiqqGEpT3Lh93QY
   E9E430JdKmCKCDK7/vD8CJwMYuQhG2mgetJB4HIfzemEPAxBYcVI/cXs0
   ScoWY0CrLITWyy3NEOdQxgJlbVu6avI/k0NiUWX8kOKMAVGv5dxpjScbf
   g==;
X-CSE-ConnectionGUID: 3oGJUHvcQBmch8sMhgexcg==
X-CSE-MsgGUID: mBOaQVRjTsG8XtAtK7oSlQ==
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="6.25,210,1779148800"; 
   d="p7s'346?scan'346,208,346";a="17422759"
Content-Type: multipart/mixed; boundary="===============8007331155512735964=="
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 08:56:58 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:21404]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.40.158:2525] with esmtp (Farcaster)
 id 83a8e99a-ee9e-48bd-bd52-ca0512ccae97; Fri, 7 Aug 2026 08:56:57 +0000 (UTC)
X-Farcaster-Flow-ID: 83a8e99a-ee9e-48bd-bd52-ca0512ccae97
Received: from EX19EXOEUA002.ant.amazon.com (10.252.50.139) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 7 Aug 2026 08:56:57 +0000
Received: from CWXP265CU008.outbound.protection.outlook.com (10.252.51.199) by
 EX19EXOEUA002.ant.amazon.com (10.252.50.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Fri, 7 Aug 2026 08:56:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a98MDV2ex68+hJdMfFQ2+XZ/Ft3bZWFEnS9YNh430Gov3jwUJmi6eo0C4ovl03p3eI3VG9EB2PPALSzQbJOrmlcc6n8rgaB2lyiPJmI2C+aYyicMUpKLSHQwoOuOsUIdh5k2B6hhZxX+Se0tqS0GXAZl8gA03uDKrua7AtEwXDjXcz9CJwYuLeB8QuyL3GlRn55kCBdBBJqPwAnBEC1HTECWb9ITPOD1TFY+AOnPR4qwjlMD++3ISFMjI60qign+TxBsieMpnoy2Kf7PntnW0Qr0/X6bO0ROLCsDkthR1Y0CKbKWhEOTU1UyxlSMQa7ML7z9GoWs/E8WqRGf2585Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=v5V2ezFEkGNC/vj59iMeHI14AefxuAwVZZkR9HXtgS0=;
 b=fMbgRK1LDOaGg11UddxtE61sBlAVZenqKPGOKY8BQLVe4dEyFLGUOYdHUAmn/iHUU+q4yIip82f+w5mto61p9fxgtkvdTqNWqbXCQUesp3nqBYH568EKE6XYaEKjm1s8s3pbDe0OPZw0Gk4mnLF04xGX0+uorcu/7kQ4SqhEAMH6DugcXivUlFgNqdloqRn8smEYEQv/Lop6TXUSJBz8s2W/Cr7D9726zaTYa9Mw+iZLkpBEpXXlyebJ2mBhVlHaPWuJZMvuzv9yjX+p8OzW8o7n3UikbVqY0u7aBnzGwfIiGWKGGMpBw83Y45Fv7Mn1EncIpOGYe1X5fg/w/WQluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.co.uk; dmarc=pass action=none header.from=amazon.co.uk;
 dkim=pass header.d=amazon.co.uk; arc=none
Received: from LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4b4::12)
 by CWXP123MB3207.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 08:56:52 +0000
Received: from LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c7e3:476c:6170:8f6]) by LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c7e3:476c:6170:8f6%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 08:56:52 +0000
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: Sean Christopherson <seanjc@google.com>, Paul Durrant <paul@xen.org>
CC: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Thread-Topic: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Thread-Index: AQHdJkqwWmVHGXLW7UOQQL9xHEfghg==
Date: Fri, 7 Aug 2026 08:56:52 +0000
Message-ID: <c455d472e274b6557cb00ea57470ad5c42d7fa2a.camel@amazon.co.uk>
References: <20260805195528.3853473-1-dwmw@amazon.co.uk>
	 <20260805195528.3853473-4-dwmw@amazon.co.uk>
	 <20260805203608.D3CA61F000E9@smtp.kernel.org> <anS8C4Cxqy6ehCo3@google.com>
	 <bbb2ad42d2ee3b2c20cfc31c3d58a9fecebb77e4.camel@amazon.co.uk>
	 <anTONuMjSSD0CepY@google.com>
In-Reply-To: <anTONuMjSSD0CepY@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.co.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOZP123MB8516:EE_|CWXP123MB3207:EE_
x-ms-office365-filtering-correlation-id: d094f98a-9e5e-4c4b-f3e6-08def461d316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|6049299003|376014|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006|38070700021|4053099003|10067099003;
x-microsoft-antispam-message-info: A27QioC9imXxGCOuulQtbsYgm0cNmigPnI2s4NI4jv0bSWx4MJ/Anq6fCm6acJKzRMRiI5nB+nfJG5SH318kNXyTH0PWii7+hCL8Ur5vdQGsbJehsNCWWFujVflrNGGd2BHMWr9A/nT3dzTvqQVTXlDH+PDMKXhxwe3BW2dIiN8FqYyKBsVbKmM1gyWHSowdyI3kZrnbCPvb/165tfNZPcX4JQygF9ndbgMpAVpoXvVIeBdxNl2MDFlv8PNNfxQ4C+Zd+udXiqR1PXs02nkU5xAAsFYmt1XAUjJjNJFCuFrrrDIDFyJbEHC3vBLP01Vx4Cm5nhJBiBoD9cRwZO1uY36pFFgN7mBE68P7kbWzYEEo8qC1Dych+emvZNJhbdS/NTg2WWHBHRc6aF5mKo8NlKUlPDCWlZ/zzRBhcWqGmMlN+9/78yCQJxY/uPpR0MXYNmGRwuIuJYLERfolXGzqG5yD2GVtqTfKHnfbezlr35U/OSid4Nq0ZHPopqY+4UEsu30RHmdMHpVgQetDmclM8ZtZG5hL+3c8S/JpPU/wj0AhmFiFl9aZg6Em9P6HD/VLjnragcAui/qbEv0o1wgLlxvb7vqXI+Ho8rldsQZxRmhR+2liENoU2zehAIz9mchWa2DzVRjN5xioYkY9adbLBn5jlqT4YFhl8r30oziD4bg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(6049299003)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(38070700021)(4053099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXZjQ1RhTnFJL0FaNE1XcldQSjBLZHZDY2t2eW94dDNEMkJUQzZZWldYaytS?=
 =?utf-8?B?U0VrL2NXVzlYaDFudjdJd0NCYTlKNkg0d0h3eGpTZWdZbXh2REJ2TEg2U0g1?=
 =?utf-8?B?aWdvaDNURFc1aGY1QUxjelY2MktOeUNXVWlMUVJ3NkMzTFhLUzVZaUdQMThQ?=
 =?utf-8?B?enV4K0RlY29PRSsxK1krMXJSYnY1UFJ6QmRweXpEazFJQVVZK1ZHRWtpK2wv?=
 =?utf-8?B?bEllaWw5M3ZSSUk0K0JHTUpFdDdCQ01EY0pYTHNDZWZFelg0SmpmVFRSWXBY?=
 =?utf-8?B?eVJMTEJmZ3hhNy9nRmNGSGxmN2ZSSXI5YmRsSFBabFlyNnZvaWk1b2JoWUpO?=
 =?utf-8?B?Z1pIRUo5eTRyMHFLcCt3ZVFwV2VCZXNWa3pIL3ZrdXp4QnFEMldjWEdsZUNa?=
 =?utf-8?B?SDFLTFNJNEVWNVFEWXpTU29vU094SmZESXdlOUNnQ0lOdE8wb3kzT2F6b2pZ?=
 =?utf-8?B?ejduNncvR2h2QXJIUlVTTXhjb21tV2R4YjBBeXlQUTJMa3UvY0hOYzFOT2JS?=
 =?utf-8?B?QjBaVS9QNmJLSU1OcTRuTENqb2YwbWdxemZsMC9SeVJ6bXl3WmMvNEF0aDBP?=
 =?utf-8?B?SUQ1WnM2NXo5a1dJTS9mKy9mVXhrUDFtQUs3OFJqUm5OS1d0aEk5cFpzeTYv?=
 =?utf-8?B?UGtTSHlzbVlHdkJra281aWE1dVA3NjN4dW42UXJiS1ZyaWdjbDNaQ1dxa09k?=
 =?utf-8?B?MHova3phdGM2YWdKRUV5cllxY1NSRXdBaCt3Q3I2S00xWjJpVjRkMWJzd1g1?=
 =?utf-8?B?djlXWTh0UmxTdFZ0Rkdhd0RHRnhKYm15R3NCUEsveGcwL2ZKSklIcENjVk10?=
 =?utf-8?B?aFkxOEsrSHU3MGRUNHB5Rkl6ZVM5TmNsd09UbDBZRXBVWEEzQmtHMi85OGFa?=
 =?utf-8?B?bExvSzRoZDRMamV1Ylc5cndzNnBLU01MVTV2ckp4ZW1hdjQreG5FQi9mTGNR?=
 =?utf-8?B?S2xqQnQ5NkJMTHN0aVJqUjdIQzZGVlVYdlZMQURjNE5QSExlQm9jak1PSHpk?=
 =?utf-8?B?UVgwUE45cFZZanlqbmtqSVVKMklIWXVkeHg0TjdKbXlVYW9QWUVwK28yMGpw?=
 =?utf-8?B?bmlkeFVXb3Avd2VZdGorbzU4eUM1QXZzTW9OaDY3ZGJ2cjUvY1RPaGU0K1Nt?=
 =?utf-8?B?Y29aTy9Ua2QwZzdXZmM3YmpOQ3pHd2oyY2V5WXpSbE1TUWhNZC93bjMwNFRn?=
 =?utf-8?B?QkpwdUlpQ1cwVSs5NjNzUW96QXBZWWZFa1RwMmpkaUd1aEZ6NnFHemU3bFhz?=
 =?utf-8?B?c1Z1dkJodENUTmtLdHhOV3pEaEdCenoyclh3NWowQUtBTUNGbnZtUkJScytU?=
 =?utf-8?B?MUd3L1JPT0Q4c0Y2NGQxdHFCRFplcEZtQitZV09wbXFkVFZKWGVjZkNZeTlE?=
 =?utf-8?B?OFkvNjhtNTluSWxZaEs3NFFhdkJrNnM1alpKY1U1UXV2QXFDTHlyYXZIUnpq?=
 =?utf-8?B?VkdhMFA2N3M2ektkVHYxdWs2OWZTOVFZOTNpSDBGTXB3alB1WVhrTGtUbXdN?=
 =?utf-8?B?ak56RW9peklhK2pkUHVBZHI3YitqcWR3bWlkNkd4VnI2YVJoajlsdnhNdUJF?=
 =?utf-8?B?enJSdWNVcGluUGxvdGJ2SkJlRnBiVldocy9VbytxL0hrYXJJY0xXMk9Kd21I?=
 =?utf-8?B?WHFGSXJWZ1lreGpXb29veERSSUN3MUM2dm5NTkdLdnZBSXNOOURHTXRsakFn?=
 =?utf-8?B?R3BPQkxCQ1Q4SE9rS2RBRmJtSWkzcFVQa1o0VUFzclhMeHJOQXNkVHVxSWlX?=
 =?utf-8?B?cEJFMStZekZ4TGhreHNTam9CLzA1Qm1ybStCQ09mcXhHN2UzeWtRZTN5UUN4?=
 =?utf-8?B?K1Z6KzBRUVhpWTVqQVF1Y1lNd04vcTltOWF4MTRNUlBwVFFrdElXNVV6UTNo?=
 =?utf-8?B?ODNWNnlNNis1aW92TzUxMjhPcHJ3dGh4UXhEUDVhZVVxRnduTjRZeHpvK0pw?=
 =?utf-8?B?VzIzY2NKTzZLSDRkNTNWMUtwbHBQYUJSeHJraUduT21vY09Fa051cWJxcS9n?=
 =?utf-8?B?REpidlljMkg1NTJ6R3lIaDl3WFd5K1ZjeWlnOTYxVnY4VkNRdSt1MkQ3c2sr?=
 =?utf-8?B?dTBkZDJWK0daazdHcXdVYUVOWDNONmxSc04rT0FScUF3Vm1na3Mza3k3OE1N?=
 =?utf-8?B?Vmc3YmRZNXE3SFF3eXI1MDBLYU1uZm1icXJrOXpucmJ4N1hpZi83WEV5ZlBl?=
 =?utf-8?B?MlVNNFE1SG9tN0V2NWxEc1VwNno5bDBxSXE3b1dVczIrWVp1ZTRRdEVrOG4x?=
 =?utf-8?B?enFsbHZUVjlhbVovcm1NNjc2Ylg0WUhEcGdXSzJvM25EOVFUbjZtVWRIUjAz?=
 =?utf-8?Q?HlnzDpNbMr/BKWkVlO?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jpS4ocGprkMQLKEXfcSZ917oRIUM7Im9l+mTgZjnMCSeqCtlGcmd+ryr48637HiJ5Szai8nuDG2j0OqD5ZBAIj5Zn9A8AyYkrL+OXnJgFosozSPKBSF9I9TwDrys21yRaNyqyiJGl1VifdHsHQxqFe2rm5PXtqVgwzT/e49rwDeukeeGdijURy0fgw969rx9O98oCAKqIBCN94CpkgtJc8fRl1ezy4F+Lmi/OSPEZmS48OuWRH062bb5Fp9WbC5tDHB3jqcSsOMDrexHKcdKVIVndQVDLi52FqViZ8C4DT4NfL9vt9JGEnPygZM7Pzz9AXtclvYz16xdUkVVH4tsvg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d094f98a-9e5e-4c4b-f3e6-08def461d316
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:56:52.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvTCmHevplNo5d9rpcY6Sx3azVr4spYdV1KQ26nSMjMZWE4Pkj9l0KxK08/oSJiS3gSCjK5yEXKy0NElMNo9Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3207
X-OriginatorOrg: amazon.co.uk

--===============8007331155512735964==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-GksgtPDbgyUS0dX1FVRv"

--=-GksgtPDbgyUS0dX1FVRv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-06 at 11:11 -0700, Sean Christopherson wrote:
> On Thu, Aug 06, 2026, David Woodhouse wrote:
> > On Thu, 2026-08-06 at 09:53 -0700, Sean Christopherson wrote:
> > > On Wed, Aug 05, 2026, sashiko-bot@kernel.org=C2=A0wrote:
> > > > Replace the per-cache rwlock with RCU for the read side.
> > >=20
> > > I don't hate the idea, but I am very against using RCU.=C2=A0 Unless =
it's "impossible",
> > > e.g. because synchronize_srcu() allocates memory and breaks OOM kill,=
 I would
> > > strongly prefer to use SRCU, probably with a dedicated kvm->gpc_srcu,=
 so that
> > > synchronization doesn't need to wait on all CPUs in the system.=C2=A0=
 The tail latencies
> > > for synchronize_rcu() are horrendous, especially for many-CPU systems=
.=C2=A0 If it
> > > were only mmu_notifiers that got hit, it miiiight be acceptable, but =
since this
> > > will affect vCPU tasks in the refresh() path as well, normal RCU is p=
retty much
> > > a non-starter.
> >=20
> > Yeah, the refresh() path got pretty slow in my first attempt, before
> > optimising that *not* to have a grace period if the memslot generation
> > changed but the actual GPA=E2=86=92uHVA (and memslot) don't *change*.
> >=20
> > > Even SRCU could be problematic: if synchronize_srcu_expedited() is fo=
rced to wait,
> > > the wait time can easily get to 20+ milliseconds, which again is a no=
n-starter for
> > > things like steal-time updates and nVMX pages.
> >=20
> > But we don't have to synchronize from the read side. The code path
> > which will do so most often is gfn_to_pfn_cache_invalidate_start(). And
> > the refresh() path which is already the fallback slow path which can sl=
eep.
>=20
> It's probably a slow path for all current users, but it definitely won't =
be a slow
> path for nested virtualization, because a refresh() will be required any =
time the
> GPA changes, i.e. any time the vCPU runs a different vmc{b,c}12.=C2=A0 Th=
at's why I
> think we should treat GPCs that are strictly bound to a vCPU differently.

"treat GPCs that are strictly bound to a vCPU differently"....

Of course, at this point we have to make the observation that with a
na=C3=AFve and simple spinlock, we don't *need* any additional complexity t=
o
treat single-CPU users differently; they just *naturally* go faster
because they always own that cache line anyway, while the rarer case of
concurrent access is naturally correct too.

The thing that's held me back is the shared_info and vcpu_info cases
which are used for incoming interrupts; I'd really need to do some
serious scalability testing to compare with the rwlock we have at the
moment.

But honestly, the Xen 2-level event channel mechanism is *already* a
cache contention minefield. Even if the GPC is lockless, two concurrent
host interrupts attempting to deliver event channels to the guest are
*also* going to clash on atomic accesses to the shinfo->evtchn_pending
array, as nobody makes any attempt to ensure that event channels for
different vCPUs are placed on different cache lines in that bitmap.

We might even find that concurrent event channel delivery is *better*
when it's serialised by a spinlock, than using rwlocks. Either way, I
think we can *certainly* live with just flipping it to be a (raw)
spinlock in the RT case.

I'll play. In the meantime, the rest of the fixes are in my branch=C2=B9
before the RCU stuff, so I'll post those probably on Monday.

=C2=B9 https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=
=3Drefs/heads/xen-rcu-srcu

--=-GksgtPDbgyUS0dX1FVRv
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDC0w
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhUwggT9oAMCAQICEFQru/eJkU7BxeS7T6sWKmYwDQYJKoZIhvcN
AQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNV
BAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMjQxMjE1MDAw
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
NMaznG7AuPFmg2HT3ytLU0iKDJxvAAAAAAAA

--=-GksgtPDbgyUS0dX1FVRv--

--===============8007331155512735964==
Content-Type: multipart/alternative; boundary="===============5786926822030528521=="
MIME-Version: 1.0
Content-Disposition: inline

--===============5786926822030528521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Development Centre (London) Ltd. Registered in England and Wales wit=
h registration number 04543232 with its registered office at 1 Principal Pl=
ace, Worship Street, London EC2A 2FA, United Kingdom.



--===============5786926822030528521==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Development Centre (London) Ltd.Registered in England an=
d Wales with registration number 04543232 with its registered office at 1 P=
rincipal Place, Worship Street, London EC2A 2FA, United Kingdom.<br><br><br>

--===============5786926822030528521==--
--===============8007331155512735964==--
