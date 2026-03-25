Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4E3E023F
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457821; cv=fail; b=buFw3XMLq3mbq1MolvEyt9lJd7DS7XQV3iynDVf+4qaU229E4Ua2HE7//G8z3kwBswUR6NiVI3OTbiPdajYiKbLET6+3edemTfeACVnduNnIyt85cJWxRzVeG/zDRKp81gfVnuSS3FeuI1PcM85fy545pqYsDK7zKQ4QPTE+Kkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457821; c=relaxed/simple;
	bh=Z8GicqKKknnZ1SQ9IrodkwOV4hcblbdHyUg0omVTnjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J6cv8kGDV6eQmIow9haZQmnIbkyZIzk8jQswL9I5LXugPupKP40MZhbjqOWgC21zzHyga+syOcUZ2l+pxp4XEC+gHMjlLf1nqXKBkQxGLnxLTVJsy3AhN7hUl8MWGeEGbwnb6DxLUrCagUKNrPho1xy1xkIe9vHTMDwCGuLGmJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=qrkyFzOB; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ZlavptuZ; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="qrkyFzOB";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZlavptuZ"
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PG7Egi178757;
	Wed, 25 Mar 2026 09:56:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Z8GicqKKknnZ1SQ9IrodkwOV4hcblbdHyUg0omVTn
	jA=; b=qrkyFzOBQk8bycnfMkwPYUOf7LlY55s/annllzs0DJVz9OavEZEMJnDQu
	28eX9etwjjPFVJKGVztkYZMryDaxqgFHQPIWJBlwvJn9+XFi5hJ4OHwCi+qIi6+n
	VJLrK1YkgssT4REbtctgeAsNGKvaNL5UcsqR3AqNrnZPia87RfUuQZyz9KNeoz0e
	5Jdg9jFZb10pzj5BDDpfyMv1+dVsZvAJc2ETzA9ZxcAB6Xaxe3eZtr3wyFIP28aU
	LPSAKB+76Kt35Y/5XpFRgvFK8ANgFovOPwRvXySVpsR2zy0ED6wv6lEqI3flMJfa
	33O0LojKGUQ9ytNsgTDB7CCoRNi6A==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021095.outbound.protection.outlook.com [52.101.62.95])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4d4bgssc2r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 09:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET99ePe6o9uARYbBqT0Q/Raa4K3ymlukTSXPt6yaZcskRavQ+hnTyGc6uG5EBnfynfq1++kkDYWxLfkZw0n0naE29KWz36a0bKNfQcGQFn/tgzJNBmpwSdshqZPG5VZtxtWAD4Wskt9wrjfKLXdYciEX3gAiFBNv1FT5kbnqaowdUMFibqXIMJAsNYbY88eAL/oZC8k2auX6PxN3hUlZhfkQ6fxZl6kcTY4y9e9lKmBKvxRCm6RGTq3+otdJaM74J/UIQCeOkqhe9CFmpgBjY79SFEYf7tSbe0Nja0hqNXt/ymoyMQAzz5U5xAngLbMYn8lYbOk8tlCFGdRhhGm0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8GicqKKknnZ1SQ9IrodkwOV4hcblbdHyUg0omVTnjA=;
 b=QWhp8K/M1NIZPTZKwXNvgGTxUgVHW0CEcTbsxgfD2TGhjzp7RibDea44fcAHv+hAIqIFfYXQoaLsPDp3dI2t3t4TKtzKq2PYgLBscUUDtesOi+jlL/zDIJcYiQgnDeKZi59ljT04hqKiFnHaurYJZOw/5HSlmm/2Y/w0GpJYFlJHLAmFtJeM9k2psFA5Pt+nrriOmvQ/uKVKstM4XMBtuyBd2Yczs08KGhpAfSyURha1g43HN7EABf7W6RpAwYaclE1El9DzPNxQ7g1w8RPQbI5jGXhhajUmlHsME6+E4ISsw7LTP4uthzlrYZfY4bXYpWcVXOYFxNsltvebZreXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8GicqKKknnZ1SQ9IrodkwOV4hcblbdHyUg0omVTnjA=;
 b=ZlavptuZCvTUDCTmdYd0VZX00cSZ/aAM3r/cExosLdYKHymx5qS1pDNxhk0qV+VV73syiXIx2bD1eKzAtIeZaDlFMms/GQOVeb3pDcrNU8LBsfxFK41BjE7IrYkSHlrnfPdK9eNhokft+uVqRdQ5mrN2I5GPT8rt+agUVhSJ2OTXl/Ne8VtcXYSRmBXVLzjed7aPMEl0kiEvdB7doEGmunNZy3gWyQqYVzuTop2NYVYKjtLZoj87CbgdRznw33nK6/QJRJHPjgtwiWxYPBQEJ31kuRH++5eCFW+q5soJ3eoiFDv0Mstj2PuG7trZziyZbHa8U9qGAf/fX/n9OrLBqw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CH0PR02MB7947.namprd02.prod.outlook.com
 (2603:10b6:610:104::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 16:56:45 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 16:56:45 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "seanjc@google.com" <seanjc@google.com>,
        "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH 00/10] x86/vmx: unit tests for Intel MBEC
Thread-Topic: [kvm-unit-tests PATCH 00/10] x86/vmx: unit tests for Intel MBEC
Thread-Index: AQHcc8muxg5vhEKMIkuZ/6ofG7akyLW/6l6AgAAeu4A=
Date: Wed, 25 Mar 2026 16:56:45 +0000
Message-ID: <D227A612-8567-40CC-A933-A64D6F562576@nutanix.com>
References: <20251223054850.1611618-1-jon@nutanix.com>
 <ea5675c2-35e0-4c48-b69a-eb3db290a8bc@redhat.com>
In-Reply-To: <ea5675c2-35e0-4c48-b69a-eb3db290a8bc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|CH0PR02MB7947:EE_
x-ms-office365-filtering-correlation-id: 61160fea-5938-47a8-9ab0-08de8a8f7f8a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 tE7XEFXjGpZmONyEcAvivyfJlpn5N59AXmxEJ75Sx81yyMMOglQb1DiCjxFgEnM64AXduToCAIarBxyHCBYHfs24MuEEWdLr/WoJ7M2QKqRf8eyNcXgDdOZ24wQu6AT/MSFhwXCvPw+NifYkXUqmVttgBsY1EXgymXJl1c6xQLYBzN4pJMAeSYgNlK10bVQkviel9QQ/WBFH2BdgmxV5W7GzMbiF3XjHCF0zx6UKK9vHj2F0uDzJpsNc7WALJ7/JEwSvqhd3oe/0D3N+2uRq/fg/Xzk63eow5uhz4OqXcsSujxLK2YYXCXPQEUIvZQUqKUOJgltSh1ufVVQhJzUcyXbsryiKCXFqi35yGb8DSI4DcdTtIb7q/RnAft7tqMQIRAOZsPXckJrkiVmbz2HMvAPf3ac5JHR18vV5H4B1A368/m8/3DDrnmLDWdCq1W4PIH9Ybmb04Ak/53BKggdIDiuJrC8lrjDiYYgCqCHepenyCzKfUgAgVjHKcjB0z17/K+3g8l3OHDV9wZgtutE/Gf4w9EShzn2M6/eSAG2yEm+q0++Akl1twJAFOsQ8/K39gueZKW0d0j/ybkKk0Ick8/3s2CpEarhrXBkoH1EVWKYt3I9i942+5WL5Wj1pOFAqGpmoankQ0RftBq0HcDdkoRFbUKnUImiGWw8Y+Zw73BD9vLFoK2wcG3nUatBoDqF3cpCDMllLvA8icic1Z4W4YSjSBSGA/2nJNmik2Guw7CEj6dYnxsRk9zsfS172X0nWFr6+7H4kuMlJYpY+Mw5GCnE/4W1U735Ot0sk8IyGR1s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmZyOEpEVkF6cmlYSWFHTDIzb2lBbUsyUmFJNGZpd2RHYWNaUXg4aUlsa2pE?=
 =?utf-8?B?YTgvRGRyeGIwRzJDbTIySzdLMFNaelhjVUNIRUFJTHRjbS9Ddm8wUTNqMjVa?=
 =?utf-8?B?RDhISFdhMStuZWVJeDA0bEtIQWUzZlg5TFRxWndteFByMVh5VnF5SEdvTTZr?=
 =?utf-8?B?ZFhXN2VselpYdmJDUnY4Njk3UEdRLytEMDhiOWxuZjlXSXpJNDlxMkc3MjE1?=
 =?utf-8?B?ZStxS2V1cnFGbkR4S1JHSUFxeFgxRks0NHlyam5yVDFxZFdWTTFzRUVYMHEx?=
 =?utf-8?B?MzJSTjZ5K25yUmx0bmRRaUdJTVpSZEhtam9MZk5XLzlWT09LR0ZxUUFrQVVs?=
 =?utf-8?B?Q3VUQUExVVR6RzVMOGtFSlZvdUVDcjE2MVdzSzF2d1VFSW0ra2IvTlV4UE84?=
 =?utf-8?B?SDZGWFhycjdVbTFVTWxCS1BqUHBPbE5qWi81VWd6d3JDUjhoQS9MbENTZ3dR?=
 =?utf-8?B?OCswRXMvMGt1dEZVeXFWQjZsOE9aNWdrQkVOZlltS0p6Rk9ndzA3Ykp1aWdi?=
 =?utf-8?B?K3QxRWNYTTdMNzFIcDZDSElsVXpocnhtdjNDWEZ5U1U4UDJ2SWhwY3JnUUpl?=
 =?utf-8?B?NkJSalFYaC9jY0NWYm81dnY4RzhrS0VORmZqV09GVkI3TjNwTnpVa25mbDFt?=
 =?utf-8?B?UC85T2crU3JsNWswamtYZnZreHV6RXlEWXJ3d2FBS3ltZlkvY3pjSDJCSnVG?=
 =?utf-8?B?dzVvbks0eS82cEtpWlA4UmJpbVpZVU13MzNtOXRDcFRleG0vZVE3Q2I4QzZt?=
 =?utf-8?B?UU1tK0N0WW4vMzRLdVpRaGZsRmRkL0o2TVh0VThHNmV0V3JDWTZVUldRdlJB?=
 =?utf-8?B?N0VoWTFFNml0TEkvSlhud3d2YmhVdFlYUisrZWE0eUFiVGgzWEt2OGJpVGxk?=
 =?utf-8?B?ckhvaXUweHN2aHBVQ0E5dithWkQyOVlrVWJEUk9YWW4ybXdXcFl4SGx5RUxO?=
 =?utf-8?B?UEhURFhRampEbEZKUkVaTk03K0orU080VU92WC9Ya0loVlFmYnFkTHdSSmVn?=
 =?utf-8?B?N1NDSFBSUzZhZ1ZSdUk3eHlFY2FMUFhXcjJDVFR6eExmM1I1a2RjRHFOSVlT?=
 =?utf-8?B?VUJaVFZDVWwzaGNTYVhQSVkrbklKd0xRNC9scWZMZ2JLMW9MYTdSRWJrVmRr?=
 =?utf-8?B?RjRZRmpUZFA0NmFYQzZHVHRBVjFObEp1Qk5XUlp6SWhycWdxNE9SVkplRkdQ?=
 =?utf-8?B?ak1haUF1SjhndnIwUFlpeDhSNlcyRDlZZmQzQzNkUmxxeVNtbzdvTzN5Z1FO?=
 =?utf-8?B?Sk56YjFwWFNnMmt5bER4THNhMXFFZXczcDdZRXlYYy9oV0JxeWVyT2tmTFk1?=
 =?utf-8?B?ZHFmU2YxTWpJTWU2RFFkeEpBNU9ZZlk5by9zd1FoZVRQcTlRVmtFVWFPcEtk?=
 =?utf-8?B?ZnRBVFZnNlZBc1FzTG1BTmNKa3ZNRzVrSzM5M2dIRzF2Z3AxVThPeHdYSVdw?=
 =?utf-8?B?OHJEdkFBZE9HVnlzL1VpTUg0M0lVVU1BdzdaTUZ6RlIvNVFjOW9uaVY5R3B6?=
 =?utf-8?B?T1hCSG9vOGNJTXVrU3RvZ2xiUUtWVDFrN0lZWGlJbXk4Vm8vdHFBQTNTbWlN?=
 =?utf-8?B?aDA2RU83cVl5S0pSOGZGYmhnZi95WjRTSDE1aHpNZmI2Vm1OaEJ6WXhuV0tY?=
 =?utf-8?B?ekcxTjhJZkdlMzBCRFdwdUQ0MzVyWkRiamFvdGhzeHBuTzBoZ1lFU0hYbE80?=
 =?utf-8?B?ck9rM1U4WnJLOGs4SkJkVGYxaDNNMDRxQ2psTThvbVIxZGtsSnJtU21JdkJu?=
 =?utf-8?B?U0VzZ2hacGhKRis3T0Z5QnZSWUNZT3JBOFFpcEg1RWthTDV6djdzbm1WRms0?=
 =?utf-8?B?bHlleHJpVDN4K2QwRElXZ0c2QTZXTHZRTkE1SUJKRFBaWjdtNWVlTjZnZXJD?=
 =?utf-8?B?TWd5d1ZKQ1hBWE1qZWxYZytPdEkyeFFDdkJ0Zld5ejFmM001d2lFa3RrWnRY?=
 =?utf-8?B?ZWFtWjgxTStqbkY4cEZuWFRMckdrOTN3Q0NDL0ZyR0FMMnBJSVAwZHRuSk9p?=
 =?utf-8?B?Y3JCSmdFeHhFbU9nMmt0NHFCeWptc1NJc1ZBRzVId1RTTUVxdHB3Q1lzVkpN?=
 =?utf-8?B?cWRZaFNmVmcyMFlZMWZoRWkvV3V3b3NvNXB2ajBoamRpdU80VXZCL3dmVWR0?=
 =?utf-8?B?aTYyQlRBYnVNQVFXU1pidmptLzRYQnRTUTVPL1lzRWZBNXlLaXJicW5tTkpl?=
 =?utf-8?B?ZGxLNGF6K3pENnBjSmFvSWY1L1VlSUpuWTFWUjdsQ001akEveDZJVVZpR0Zm?=
 =?utf-8?B?ZDU3Y2NqdU41UVMzWk1zRU0wUS96QXJLejVValVpU0tKbFpqWC9pRGxhMTBL?=
 =?utf-8?B?cE12TXJxOG84MlBlRXNsR1orMFhWNXdnL29tUXk0WnBSbHJYUFZPVVZGVkZw?=
 =?utf-8?Q?umQwHsN3Iw8yHJ/y4Iq3pSxnw2Bvk1FpEQRUXcFtu5iiG?=
x-ms-exchange-antispam-messagedata-1: lJwXcBlTX0ZFx8qVS6NWYD0k35BfSHjjMcg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DECEF26EE9976E488AE982AF1AE209A2@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	bsQE20CbAND6N48pJuVNADem6/KACGB7GxB8FCYLawbTEHqpJbSnqWHRm9k2CCopU6+I+vrRqqvJU+jH1FOf0pK4HIzAWWQ3wr2yWh+IXgoxqVRLfVNb4L3ndb3jryN3CgyKQO9npfZP6Lma1ROj1vIGXTyCzQxsk0yyBJIMIDGK9Em1ubJNdeNXNOZRFgoKBKdgnYf/f0b7mTEwr3vMFd6yUHfd2picQLxQha6XTsa3Vif67LAyLIB3g0IVakw8+HLYSUnJ48ZQPn5ulbDbUacsa8exsvKD2Vx1ch+f6b7KI2afX2Pzw3UMzHAeWZmseDa7U4I8wloro0VFFb/5+A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61160fea-5938-47a8-9ab0-08de8a8f7f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 16:56:45.7551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4eS3Bo6eBzrEPguPfemAspTCqShUWalzgcG02qeg/dEvEQEsC8scNQF1Lc4EIWGgmy4KYxH1oQPQgeYW4a8RGFL4NX91q1fgqHg6VPqq+Oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7947
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMiBTYWx0ZWRfXxFpOiH+Ybe+X
 NQiIByXM1hAEyebrnIaCFxXRzkQjnPceYKsoEGmFLQ+EUDQ4GYwBonDW/jY8VaVnzyl6+k5+A9h
 Z2RDEFzH6WRLqFGxHhejjzQAYhZKf/6UYRR8/AbSe2mQ7tRYdJA73UA9CRvhLTwBOeuMSbMgABt
 Fr9r9IWxOPH6NAhfApRRsaNcBVO3QdTWOg+540pekGi+Y0k23ldeJjo9/08CPvb7k6Z4naP+4pe
 F48+1BPuV4Zf0wUNWwaQcDL4scF8sy5fyJHjFdWJERi8gxsHxDxWmBiq/c1zCus3CN3Fg4Yi527
 kjkt7NJnAValqLv6VbrDpeianQ8atOihrlzP4NOwnw5UcKovp8LJjJYUM2VthbXlMY//JgL3LGg
 ubHOSdup9JEat04QIYSzIjecQV2iBM0BP2VOSx4TgQvwKDG2B3IorAFDd5I3oKeupQ3zkj56liI
 bVxB6yhnbNB1wuQT8/Q==
X-Proofpoint-GUID: uKZFu69pj5sNDa1EODfdODCTI0yOUYSH
X-Authority-Analysis: v=2.4 cv=K5Mv3iWI c=1 sm=1 tr=0 ts=69c413d0 cx=c_pps
 a=XQ5R8ZYH27Ke1DXIRfoPQQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=20KFwNOVAAAA:8
 a=1Qhf0ppuABGXtOOMRZkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uKZFu69pj5sNDa1EODfdODCTI0yOUYSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWFyIDI1LCAyMDI2LCBhdCAxMTowNuKAr0FNLCBQYW9sbyBCb256aW5pIDxwYm9u
emluaUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDEyLzIzLzI1IDA2OjQ4LCBKb24gS29o
bGVyIHdyb3RlOg0KPj4gRXhwYW5kIGJvdGggVk1YIGFuZCBFUFQgdGVzdCBjYXNlcyBmb3IgSW50
ZWwgbW9kZS1iYXNlZCBleGVjdXRlIGNvbnRyb2wNCj4+IChha2EgTUJFQykuIEtub2NrIG9uIHdv
b2QsIHRoZXkgYXJlIG1vc3RseSBmdW5jdGlvbmFsIGFuZCBwcm92aWRlIGdvb2QNCj4+IGNvdmVy
YWdlOyBob3dldmVyLCBJIGNvdWxkIHVzZSBzb21lIGFzc2lzdGFuY2Ugd2l0aCB0aGUgbGFzdCBm
b3VyDQo+PiBwYXRjaGVzLiBJJ3ZlIGFkZGVkIGluLWxpbmUgY29kZSBjb21tZW50cyAoYXMgd2Vs
bCBhcyBjb21taXQgbG9nIG1zZ3MpDQo+PiBleHBsYWluaW5nIHRoZSBvYnNlcnZlZCBpc3N1ZXMu
IEkgc3VzcGVjdCB0aGUgcHJvYmxlbSBpcyBzb21ldGhpbmcgdG8NCj4+IGRvIHdpdGggaG93IEtV
VCBpcyBhbGxvY2F0aW5nIG1lbW9yeS4NCj4+IEtub2NrIG9uIHNvbWUgbW9yZSB3b29kLCBhbmVj
ZG90YWxseSwgV2luZG93cyBkZXNrdG9wIGFuZCBXaW5kb3dzIHNlcnZlcg0KPj4gd2l0aCBNQkVD
IHdvcmsgd2l0aG91dCBhbnkgaXNzdWVzLCBzbyB0aGUgY29yZSAiZG9lcyBpdCBib290IiBhbmQg
ImRvZXMNCj4+IGl0IHBlcmZvcm0gd2VsbCIgYXJlIGF0IGxlYXN0IHNhbmUgZnJvbSB0aGF0IHBl
cnNwZWN0aXZlLg0KPiANCj4gV2l0aCBteSBvd24gcGF0Y2hlcyBJIGdldCBubyBsb29wcyBldmVu
IGJ5IHVuY29tbWVudGluZyB5b3VyICJuZWVkIGhlbHAiIHRlc3RzLiBJIGRvIGdldCBhIGZldyBm
YWlsdXJlcyAoZXZlbiBpbiB0aGUgdGVzdHMgdGhhdCB3b3JrZWQgZm9yIHlvdSksIGJ1dCBzdGls
bOKApg0KPiANCj4gUGFvbG8NCg0KR3JlYXQhIFRoYXTigJlzIHByb2dyZXNzLCBJIHdhcyB0aGlu
a2luZyBpdCB3b3VsZCBoYXZlIGJlZW4gYSBtaXggb2YgdGVzdA0Kc2lkZSBpc3N1ZXMgYXMgd2Vs
bCBhcyB1bmRlcmx5aW5nIGltcGxlbWVudGF0aW9uIGlzc3VlcywgYnV0IEnigJltIGdsYWQNCnRo
ZSBjb21tZW50ZWQtb3V0IHRlc3RzIGhlbGQgdXAgd2l0aCB0aGlzIG5ldyBzZXJpZXMuDQoNClRo
YW5rcyBhZ2FpbiwNCkpvbg==
