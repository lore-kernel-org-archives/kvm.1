Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.155.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795673352;
	b=EDJ/c36cVcbt/H0Q1hgSg/Ac0dvJD00uqa31ymujlAsf11U3pN7Jao3NBsa6r8EmTJeB
	 Mg1BcFC7BhtZH4fjeuieY/Y8xGhWVclA0/jgguavWE7W+x2olufWoidPmUXaBLs1nxJKf
	 VpvAcwkjA+cEg88GVfNKAb3GMM0oGOMzJeGk9SOUb2htCiPUvzpl0+FvOg6M3SOFFVkLW
	 Z6PrGNIBO9QNO7XCbBZhGpMGjOKLpQiz8W/nJfItO2neAirs5oY3RdxsFrHgV6GL+Zeb7
	 G5wJ7Ss7fjvOoaz6ydsJ7zcgtaJ/gf2siE31L0OnKNuihit4Ad3vx2JrUSGPfq6bKEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673352;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-proofpoint-crosstenant:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Reason;
	bh=u10kdz6wSATpBlS3woF0OoqAlptv/MXfZwQM7u4EjJY=;
	b=G5p3r5+sUjkNrI9dVp/NLwugxg7K4xGlazWdubbhXzN0V4myZMs9mF5DyJ2a9jD2MVaF
	 HGZiB4CnsNWaqywX9F2kuFVdCgJ4o0LnJAdMJ/pTcQUjLyZIW/SYCEO/Ftw0teZYwtRmD
	 e9YjfTSk+wTWKGl9dFwM0wWW19hWe8eZTkoL8BX4hwUGtyED55YRsQnd6wGcE6pX7H0EU
	 W93u/sZ5AkoiQbRIenjCp9FILopX73BCYshl2bKHFVt8/hIcuivC1/BJkXOTCdJC98sQG
	 DLjfTxGFduQKdWjkWFO4CpXHqHurX4fXA1aQh/iFc3nmdAWZw+OgKLQhdeth9HWmQIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nutanix.com;
	spf=pass smtp.mailfrom=nutanix.com;
	dkim=pass header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=PqbhnUBd;
	dkim=pass header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=gTUkhNuB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.155.12
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794D606A321
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 06:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8794D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=PqbhnUBd;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=gTUkhNuB
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ3987B1947363;
	Wed, 25 Nov 2026 22:08:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=u10kdz6wSATpBlS3woF0OoqAlptv/MXfZwQM7u4Ej
	JY=; b=PqbhnUBdIwdru0ySP2IlDXQ02/Vd5IFDuWCoUQn4mUPQJSNtZzP9wJNcF
	Dw/8jx78+ygxZ8iD4jad4/5o56z3cokO1g/p6eSLdb3UfXu2QwMO3UcG4BOS+FZN
	Q4ujDrdE7DIYqv9rXUx5T6Wi6A6k91R9F0U0rS7hObQEynah9DD0wAfA8k/mj7a3
	Gv5KREyQTLNtQsj6xIShOnpjj0UIO9oHUhQ2IwMfQFdEkgEgseGJfTNYoz7Hq8yX
	a9hurZ+axyzelSu2QmhIstiZM4d47I6fs+DcJecuuOuRGbV9G1LUbSM3vmxtS9tp
	nL7WK3fJjRom9EfvtYtCt6FqS0Pbw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020091.outbound.protection.outlook.com [52.101.56.91])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4j6cm1rbk9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 22:08:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoZ1//EcoHvMy75R+qdoPSZNfFMpwbREtgKYN2Vz8D2Y2qTmachxS1bI60COHtkwi+Zv8zc9cDrAKIdygZmpRvTJav8XglgT+faVZuMiUJbwR5l+HxOuJvd5hSAqeK/cC/DDAlMKQkE64+maMELm0kATpLmdUHdRb6jOt/o7cdqyv4ut5qkDu4an8VaG0eUqNi+FToVWid00UVkD5BpXGlAxOf4vSFU76ee/dcX5Sn+iR5YMBV1gI8pdbfWPqX1TI+1mmyLm+E4oqU+XPcurQMCweFgb6qHpb7T/0gH10+9oU478wT0lsH93H+lwBw6KS3+xTUbop9wR2RBnP9qVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u10kdz6wSATpBlS3woF0OoqAlptv/MXfZwQM7u4EjJY=;
 b=sQVmNywv+lDA3g2Ffw6dmq5BZC81MgPHYVTymrDyRRXrucOuwHSE5UV4H3ALNzV+i4vDOZPH6IQLdtj50sMOfbrPsV9wbiAzTDBdV9EM9nrUjNSDhYc4k32eMdf29IfktPcosje2E5jDOgcjMuZky1gB195KGplOn/DxuYhTx1KdC6XMpg4H9/UKRZvRDfSi18xJ7rUqaXJeh0/a+JGabeXghlA1RdBNUYYFOFLkrajb0avB5YkuWtXuSRwYhvF/rm5qcClZdQdqrUnMd3kY784dCrkTAx8wEJTZ0ojM0xbsJFIBd+8GxejoF4Xb+2m/iax39slaiUjzsn4+Voi7xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u10kdz6wSATpBlS3woF0OoqAlptv/MXfZwQM7u4EjJY=;
 b=gTUkhNuB/4fpAPZhf9Swkldp2UwwXcdaK9iREgPU109W5hqd5CsjzuDqzbT16D1NJKfrQMmFMoS5KobFOCK6Kn35GMIbrpakq27K80StwKhIJmzSckKxaqW/BN9gt2dJ3RMSqPSAWwqTC9ZET+du8raLae5Eh25zj4Z009fI2jQCFzTFw37K0/t+yTzmAiXfEwz3QPLxqzSw0msHEK8XS1VvGFWThMqXiJRIHp6sLkIdzBlirpv7Tz7hudFHmw6bXfh3uxOUZhfYP3LZqYLyUvwEQvSLd7sJ9cfwkYx7Tecwk9n9rFuwINiJgZXLps5060/tIeJlDu/Rhdw3CUXVeg==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by SA6PR02MB10574.namprd02.prod.outlook.com (2603:10b6:806:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 06:08:21 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 06:08:21 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: Haseeb Ashraf <haseebashraf091@gmail.com>
CC: Peter Maydell <peter.maydell@linaro.org>,
        "qemu-arm@nongnu.org"
	<qemu-arm@nongnu.org>,
        Haseeb Ashraf <haseeb.ashraf@siemens.com>,
        Eric Auger
	<eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni
	<mohamed@unpredictable.fr>,
        Pierrick Bouvier
	<pierrick.bouvier@oss.qualcomm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v3 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
Thread-Topic: [RFC PATCH v3 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
Thread-Index: AQHdfWbjLXt/LMS2WU+9ZEdbgJfR7bc/3jgA
Date: Thu, 26 Nov 2026 06:08:21 +0000
Message-ID: <8A57A0C8-9E85-4BAC-803A-DAFC6DBD6612@nutanix.com>
References: <20261121204601.741616-1-haseebashraf091@gmail.com>
 <20261126052741.90607-1-haseebashraf091@gmail.com>
In-Reply-To: <20261126052741.90607-1-haseebashraf091@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7564:EE_|SA6PR02MB10574:EE_
x-ms-office365-filtering-correlation-id: a07e49fb-9bf4-4b8f-4666-08df4b83ac2a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|6133799003|22082099003|18002099003|4133799003|4143699003|56012099006|261026135527099003|261026121527099003|261028144727099003|261026130827099003|261022075727099003|261021133027099003|261021123027099003|261009220027099003|261009223027099003|261009223327099003|261021130227099003|261021121427099003|261009221227099003|261022115727099003|261009221727099003|261022113327099003|261021135927099003|261022105027099003|261102123227099003|261026140227099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 tdtG12gWtgsU9QdYobX6K8XujSWx+1xyzAvH8bJ4NVoD4RcRKJOznJYpe7hfqGwTYpLSrpAKx6IRJpm07cDW2gzTVAMocrFx9feP9UeSZYFV2I5Oi5mD7CmaM58bGfQ5ZVp8MWL82vFj7aHfhg44qDii4odMUdnT9ufdfkKtOaw+/HOkgfF2V6Ta0WC8wwKp+B9KOpcU7PO+R16XBgeOGGpybCGeG3MBR/bOs3BA124OEpTQkZMpiku+qIocpb1FYpv4k8hHZXZbXkS5734f+DxY1NQTiBtLsEQig1dqGUCwOTAC+ABZN+aSOqqWPzPVGk7EYSFPtbPQB6YEsbdp5WVA2DkRyvYmDc0wHvSxTH1t/DNxMiqeBE4uV7tOM2jFXIjLQn6D36wrKwzxrSA8yJ0IU8vs5RQfiKzgypfUtW2A+au4vIiCl2uptvZWtss2QJGjECLfQkhtOiO2e1c+VnMFf6gVH/c/pLxyVnljhdc88uRwISquxk8EM3FvmS+2eKP+05RHy07DHCq/CwDD/KpRzJz+Y3QgBCByPrp3SiPuH3cclo5ohF22EFTJFJDe2vp5o38XgFlFlhdEAEbi5bJHb4nzaW7w6ucQuhuW4Tk1h/zHp7mp0UbNO4QZH1J6BAyxlHEBafAWp/c0zP2EhwEWVBqyRZxIcHsyWZCoEkU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR02MB7564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(6133799003)(22082099003)(18002099003)(4133799003)(4143699003)(56012099006)(261026135527099003)(261026121527099003)(261028144727099003)(261026130827099003)(261022075727099003)(261021133027099003)(261021123027099003)(261009220027099003)(261009223027099003)(261009223327099003)(261021130227099003)(261021121427099003)(261009221227099003)(261022115727099003)(261009221727099003)(261022113327099003)(261021135927099003)(261022105027099003)(261102123227099003)(261026140227099003)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0FMVVBrMlhQR0pjaXQ5UnI2ejBaMTFVeFpibGZyc2UwWFo3N2tWQkNlNXlL?=
 =?utf-8?B?UElhWGEyd3VUcXhxaHN2M2hJdk5RWjFwN3NjYkxBaFNUQk9pMkNYV1lMWm9M?=
 =?utf-8?B?YS9DOGowbG9yRWJ4NHJ1WFh6bWpBU0pxMHNqd0ZUbmYwbnpCL2x6RTlyWVp3?=
 =?utf-8?B?Yks1d3dHczZ5RzBDd1MzYmRwQWdXOEN2RC9HNmtndTN6NkZyL1cyNU1LZ2NH?=
 =?utf-8?B?Qi9hL0FlSzZTRDNzR0x6d1FhS094VS8zUEtJL3FpZC8wYlk5L1BrakVHbG1h?=
 =?utf-8?B?QWQ2QWJodVIvcGYvT1FyN2wyR0RqUUJSdG1VenNUZFhFbFFTR3ZBdDlRWmdC?=
 =?utf-8?B?MnZzR0NCd05lM3pnaWxJaVNHOGhZNXliOW80elNJWmkwalhyM1ZhUGFwZWdu?=
 =?utf-8?B?alRsTG5uYmozV0JTQ3RYN2gvTlg3ZTBjdlVGU0oyU044Vy9tdDFZbEw4c3h1?=
 =?utf-8?B?YUZneDAvUlNCRE5zYjZta3Naa0JDWW5kRXJ5WnQ2SGRUTXhrSUZWVlVsQ0wx?=
 =?utf-8?B?M3ZJMW55VXZ4Q1hzVjQ0N08zYkpXdkZ3NnhUVXlZR0xMUHQxbFAvclFQUU5p?=
 =?utf-8?B?REFWZXBLdTFjcysxR3dCYUsyQm4welhXT2xEZms2bHE2RHhSZTFrTjN4bzJZ?=
 =?utf-8?B?U3V0ZjBuSXgvVTQ5ME1taDhHMmJQQUszb0dycVVDMDhhZ3ZBeDlidkxtaXk4?=
 =?utf-8?B?NS9wNlBpVG5pK0lMN0Y2SWwzeXBHZk9ERGEvMXk4Z3RheDE5RGdoVEozR1JS?=
 =?utf-8?B?UlI2THhxbFlRanIrUHBnUFJDZnlKSEZrNlNjK1o4WDZSdFJZeUkvTExnamZl?=
 =?utf-8?B?MWpabk95YW55d1JBMlE5ZEdhN1dCNFJ4eDcxMXl0L21aRmhRdzlOOTdtVUI0?=
 =?utf-8?B?R2c1U3V3eEEzbUdQVzFEN2hMeUI3SjFXb3lQb0RpK1FNamJ4Wm5nQ24vU0xs?=
 =?utf-8?B?OUhkMWFtWGNwL05JYUhNVzREaS9mWTd4RDNRSTNjZXdSMDRlZW00VXovT2Rs?=
 =?utf-8?B?TTFkb3c2TDlwVE1hWkdURGVZSlo0VDlzUmhVVFQrTnhjUkpYTDEwTHF6bzNV?=
 =?utf-8?B?V0lKdUFtMnRtRWo4ZzF3TjVZREN0SEhXTUtDMy9TUXk4SjF6MFF3ay9YNm5k?=
 =?utf-8?B?NmxNM0w4bkwvOGZGQU1EZTJLZkM1TUJlQy9RSkUzTUhRQXJBa1JNa1pPQWhv?=
 =?utf-8?B?L1I1U0gwdWtoRmwvb0NxaWREQ1VTZmMwNGZTWjdnemttU0dSR3BRajNhTTcz?=
 =?utf-8?B?Y1NBL0hwRVlHeWp6RXdTZVhMbXE3YTBiUTZjbnZLQzVZbk9STVlPUUo4QktZ?=
 =?utf-8?B?c0RoZm1DcXRXQ1lmclpnQi90K0VEd3B4WXpTN3ZGZTE3blo4dXU3Y01Xc3lp?=
 =?utf-8?B?Q0Z6djJZd1ZyR2hhNHVBaXBiUzdOdlR2MVdhTDZoRmR6RmduemowME9Md0Jx?=
 =?utf-8?B?S2MzZEFnTE9yUC8zbXZCckJUbEVaTW9VUDFkMzNKZVlpSGlzYldkcE1HTnUw?=
 =?utf-8?B?SUU0blhWSXJIdXU1dW9seTRmWUdqS2RxY3lBdlUwZ3VXWDh2MEV5VWYxS2dC?=
 =?utf-8?B?d1REV1BqUjZjc0FyeTUrRHBOQ1hIdjVDSUFCak9lY0ZiQ2xxdkkxQWk1N2FV?=
 =?utf-8?B?OXIxYnliOGJja1p2Ujh3bDVYVStaNm12STI3RkJIR24yNERGWVViWWpCMjJO?=
 =?utf-8?B?NXZmdnFLRzRvM3RYN3VWRnR3MFdnSmJrKy9JdDZDMzIvalVtN0Fjejh5Wkx1?=
 =?utf-8?B?WG5vbXAwb2JXVEh6ajNlMjlRVFFBcVIvV2pXQUlkNitScTZ1VWtuR1dJcEhJ?=
 =?utf-8?B?MnIwRDgzTThsbHdINStEK3FjTkR5VSsyVWZmR2pGVm9heS9qLzVDRTRzRjYr?=
 =?utf-8?B?SHI1WDAvZjJoNTczSVp6WlQ3R1Vwb01pSlNRSUVIRWw4ZWMxM1hmTVB5aURu?=
 =?utf-8?B?QWxiY3hQcXNCSDlzN1F1ejAzWDAwSVp1RlJtZjdtdmdsay9PRUlxT2d6TWxy?=
 =?utf-8?B?cFQ0a0VkZFdXeHhzc1lHdC82allYYW1uOHNtTWlzZmJ1ZXh3U1FOa2QxejRl?=
 =?utf-8?B?bHQ3S0xLNThkV1E3bTAxcGUrbWw3NXFEL1ZOUnFrVnpGTkNOLzF6aWFGSVFw?=
 =?utf-8?B?amVJYnEzTEdackJkeW1OM3B6cVozUDZ0eGRsblJGRnQ1Wk54S1R1MERLblZK?=
 =?utf-8?B?b0lBNkJueXdtb3l0VXA1TzBhN0JVdDA2b01rWTRPQ3Q2MmRNOUpQcUNUdjhX?=
 =?utf-8?B?WVBIRHlMaVVSYVAvNDhVeXdDTGNaSVg4UldmRUpXMzhRdGl2SUsvTUJQZjl3?=
 =?utf-8?B?YTdoVlBBdm5iVkFZWUs0WllodXVpbVRJcVdvd0pDMzdBY0FGeHdtTytDRkZF?=
 =?utf-8?Q?mmKpL6N201iQuk+Up9Jft4wpjc4bP7bmJiwCkHQI6yOqN?=
x-ms-exchange-antispam-messagedata-1: 5rVH5TKxj0oL6GteKPb8wf4Lsyg7lRGS5vw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C47608D216069140A0E568806010751E@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kkQik63Wi8xTakpd/hTCCKJs1ykJYV79wK99Y2lgIMTza8Q+rFpt28tUgsFYYIEy0cblsPEDvHLxVmz5mQuIKuQNQhwJ7SfcjMz0gM3thIW2M2wGn6il5WLNdiBOuNGllREmJdfNzXavAiIs8/tAUxIbo0BO0FfvY/LLKfrNTv+nDEehwuQTxxI0aZ6YPUXNsVgnlpv3cS6pg0ySHy5c9j3Z2qgPcpvJ1dBjiBvYLUqZeKmaDqYeR6J3eY4LkD672TIeOAv+47pSJYvTtPwKvfNfNoKnMwmJL0wNIAdqo7yHc5rvZsTTROVhfDVem+AT1/6gGvSOeVSluq5UmwMfbw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07e49fb-9bf4-4b8f-4666-08df4b83ac2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 06:08:21.0835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oATP7TqRyrTIGU8JL5EbdgcxRPvlQGaEjFJao6OKEJHCsEfbVfATtqGubgryyXSmQN9LhBhxnlTuvwJAxGvaWtSywJbSgwSxRXraQ1emEIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10574
X-Proofpoint-ORIG-GUID: uBJkoMpZNJuNISbtEN5vJxBZwFdF9uLv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX3Rj9vqzk0LQP
 QsbYtQyHKoIs0SA9lOd8QcPh79VzgLvzKmG2Yejl8Hkxgz+n78TXje6zjPthUvqsZ8T61t1birX
 SePSJ8CoWlgxBwXxCvDRamTWavrH66o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX6obfBRZxbOBH
 I/YJZfgdrM7lLd9lpKQOd10xF1qau0pSFvgf3Gd+fr7V/Hm7lpB8jaMOSMMdZvBSCnV82NpE6+z
 g8ixfIGPpV8EcJQ7ptj07i7tERNdMfeRfhtOZaGxGXVnTDCCdIMx/O3kyravqTKk7qR17Dv/Uii
 B66Dmv5qdQGPqqO6b35a4TDJdjSQqljIiSoFg85sDP91VegsoBmpic08W7/FxtrBOLJM5D/gRk4
 mZmL7EzK8/NrAwgtDyjjdtzer10ViZTVZGEZ1FZ6c0kOwh/QDL3AB4LO64+dxykrYR9vgFdbpnh
 Pkpau4Ke1/i5fwh2wLnevuL94yBZRgReFFclCYrlhS3ph1HqCEExFN4+7p2VSFXhTty0f7hOnXF
 N/8i4hyZpWKQpTMEWpVWNDgOcfj0IfjDLRO5RvSIIjJau88yMSxh34jtcvO+w82EQBhyqo8iIGK
 I2iGcZ2GfEWgGrmXPEw==
X-Authority-Analysis: v=2.4 cv=Nb5zRGD4 c=1 sm=1 tr=0 ts=6b07ccd6 cx=c_pps
 a=DCeSEX+nBJmE/I7rcEuDsA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=GaQpPoNlAAAA:8
 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=a_U1oVfrAAAA:8
 a=CkyVd3wY5r-tJo1kIe4A:9 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: uBJkoMpZNJuNISbtEN5vJxBZwFdF9uLv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gMjYgTm92IDIwMjYsIGF0IDEwOjU34oCvQU0sIEhhc2VlYiBBc2hyYWYgPGhhc2Vl
YmFzaHJhZjA5MUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+ICBDQVVU
SU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBGcm9tOiBIYXNl
ZWIgQXNocmFmIDxoYXNlZWIuYXNocmFmQHNpZW1lbnMuY29tPg0KPiANCj4gSGksDQo+IA0KPiBL
Vk0gcHJlc2VudHMgYSBWSEUtb25seSBFTDIgKEhDUl9FTDIuRTJIIFJFUzEpIHRvIGEgbmVzdGVk
IGd1ZXN0IHVubGVzcw0KPiBLVk1fQVJNX1ZDUFVfSEFTX0VMMl9FMkgwIGlzIHJlcXVlc3RlZCBh
dCB2Q1BVIGluaXRpYWxpemF0aW9uLiBUaGlzIFJGQw0KPiBsZXRzIGFuIG5WSEUtb25seSBndWVz
dCBoeXBlcnZpc29yIHJlcXVlc3QgdGhhdCBtb2RlIHRocm91Z2g6DQo+IA0KPiAgLU0gdmlydCx2
aXJ0dWFsaXphdGlvbj1vbiAtYWNjZWwga3ZtIFwNCj4gICAgICAtY3B1IGhvc3QsU1lTUkVHX0lE
X0FBNjRNTUZSMV9FTDFfVkg9MA0KPiANCj4gVGhlIHNlcmllcyBidWlsZHMgb24gRXJpYyBBdWdl
cidzIHJlbWFpbmluZyB2MTEgU1lTUkVHIGZyYW1ld29yay4gSXQgaXMNCj4gYmFzZWQgb24gdGhl
IHJlYmFzZWQgcHJlcmVxdWlzaXRlIGNvbW1pdCBjb3JyZXNwb25kaW5nIHRvIEVyaWMncw0KPiBh
cm0tY3B1LW1vZGVsLXYxMS1yYyB0aXAgZTMyODkzZGRjYmU2NDNkNDc5MTlmNTVhZTMzZmY3MWJl
MjYwOWE3Ny4NCj4gVGhpcyBkZXBlbmRlbmN5IGlzIGludGVudGlvbmFsOiBhIHZlcnNpb24gd2hp
Y2ggd29ya3Mgd2l0aG91dCB0aGF0DQo+IGZyYW1ld29yayB3b3VsZCBoYXZlIHRvIGludHJvZHVj
ZSBhIHNlcGFyYXRlIG1hY2hpbmUgb3IgQ1BVIHByb3BlcnR5LA0KPiB3aGljaCB3YXMgdGhlIGFw
cHJvYWNoIHJlamVjdGVkIGJ5IE1hcmMgaW4gdjEuDQo+IA0KPiBSZWZlcmVuY2VzOg0KPiANCj4g
IC0gRXJpYydzIHYxMSBzZXJpZXM6DQo+ICAgIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50
LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fcGF0Y2hldy5vcmdfUUVNVV8yMDI2MTAzMDEzMTQwNi40
NjE1OTktMkQxLTJEZXJpYy5hdWdlci00MHJlZGhhdC5jb21fJmQ9RHdJREFnJmM9czg4M0dwVUNP
Q2hLT0hpb2NZdEdjZyZyPVBHV015aWduQTBOaURtVGx5UDd2T1RIb3pCd3NfVk44NnlyVm1TTWtC
cDAmbT14NDVyTzlrdGxMX05fRHFydXdaQ3FkeElLSk1xWlZiYV83N2doS0lsS29HazAyLVg4SE8t
ckdfQ25DRjVXRTUyJnM9NVBkdFNyU3FnMkJGa19JdUdJSzlDcmt2eWo5OG9DZ1JUbVRCOVFwdzVC
byZlPSANCj4gIC0gRXJpYydzIHYxMS1yYyBicmFuY2g6DQo+ICAgIGh0dHBzOi8vdXJsZGVmZW5z
ZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0aHViLmNvbV9lYXVnZXJfcWVt
dV9jb21taXRzX2FybS0yRGNwdS0yRG1vZGVsLTJEdjExLTJEcmMmZD1Ed0lEQWcmYz1zODgzR3BV
Q09DaEtPSGlvY1l0R2NnJnI9UEdXTXlpZ25BME5pRG1UbHlQN3ZPVEhvekJ3c19WTjg2eXJWbVNN
a0JwMCZtPXg0NXJPOWt0bExfTl9EcXJ1d1pDcWR4SUtKTXFaVmJhXzc3Z2hLSWxLb0drMDItWDhI
Ty1yR19DbkNGNVdFNTImcz14czlBRUNJMWcySjZsRjBhakkzTVdyc2VXSXhKaWsybmJOZzYxU3Nl
cjRJJmU9IA0KPiAgLSBNeSB2MToNCj4gICAgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQu
Y29tL3YyL3VybD91PWh0dHBzLTNBX19wYXRjaGV3Lm9yZ19RRU1VXzIwMjYxMTIxMDk1NjM2LjI4
OTgxNC0yRDEtMkRoYXNlZWJhc2hyYWYwOTEtNDBnbWFpbC5jb21fJmQ9RHdJREFnJmM9czg4M0dw
VUNPQ2hLT0hpb2NZdEdjZyZyPVBHV015aWduQTBOaURtVGx5UDd2T1RIb3pCd3NfVk44NnlyVm1T
TWtCcDAmbT14NDVyTzlrdGxMX05fRHFydXdaQ3FkeElLSk1xWlZiYV83N2doS0lsS29HazAyLVg4
SE8tckdfQ25DRjVXRTUyJnM9Y3hudlZFbjd0V3lHTzFRbm5sSXdlM1lLSXFmeFN3dDZJZXM2ZUNU
SkV6TSZlPSANCj4gDQo+IENoYW5nZXMgc2luY2UgdjI6DQo+IA0KPiAgLSBBcHBseSBpbml0LWRy
aXZlbiBTWVNSRUcgcHJvcGVydGllcyBiZWZvcmUgY3JlYXRpbmcgdGhlIHNjcmF0Y2gNCj4gICAg
dkNQVSwgc28gZnVsbCBDUFUtbW9kZWwgZXhwYW5zaW9uIHJlZmxlY3RzIHRoZSByZXF1ZXN0ZWQg
aW5pdCBtb2RlLg0KPiAgLSBSZWZyZXNoIElEX0FBNjRNTUZSMV9FTDEgYW5kIElEX0FBNjRNTUZS
NF9FTDEgZnJvbSBLVk0gYWZ0ZXIgdkNQVQ0KPiAgICBpbml0aWFsaXphdGlvbiwga2VlcGluZyBR
RU1VJ3MgY2FjaGVkIG1vZGVsIGFuZCBRTVAgZXhwYW5zaW9uIGluDQo+ICAgIHN5bmMgd2l0aCB0
aGUgZ3Vlc3QtdmlzaWJsZSByZWdpc3RlcnMuDQo+IA0KPiBFcmljIGNvcnJlY3RseSBwb2ludGVk
IG91dCB0aGF0IEtWTSBhbHJlYWR5IHVwZGF0ZXMgdGhlIGd1ZXN0LXZpc2libGUNCj4gZGVyaXZl
ZCBJRCByZWdpc3RlcnMuIFRoZSB2MiBnYXAgd2FzIGxpbWl0ZWQgdG8gUUVNVSdzIGNhY2hlL21v
ZGVsDQo+IGV4cGFuc2lvbiB2aWV3OyB2MyBmaXhlcyB0aGF0IHdpdGhvdXQgY2hhbmdpbmcgdGhl
IGd1ZXN0LXZpc2libGUNCj4gYmVoYXZpb3IuICBXaXRoIFZIPTAsIHF1ZXJ5LWNwdS1tb2RlbC1l
eHBhbnNpb24gbm93IHJlcG9ydHMNCj4gSURfQUE2NE1NRlI0X0VMMS5OVl9mcmFjPTA7IHdpdGgg
Vkg9MSBpdCByZXBvcnRzIDEuDQo+IA0KPiBGb3IgdGhlIGluaXQtZHJpdmVuIHByb3BlcnR5IHF1
ZXN0aW9uLCB0aGlzIHNlcmllcyBrZWVwcyBWSCBhcyBhbg0KPiBleHBsaWNpdCBleGNlcHRpb24g
YmVjYXVzZSBLVk1fQ0FQX0FSTV9FTDJfRTJIMCBjdXJyZW50bHkgZXhwb3NlcyBubw0KPiB3cml0
YWJsZS1JRC1yZWdpc3RlciBlcXVpdmFsZW50LiAgQSBnZW5lcmljIGZyYW1ld29yayB0YWJsZSBj
YW4gYmUNCj4gY29uc2lkZXJlZCBpZiBtb3JlIHN1Y2ggZmllbGRzIGFyaXNlOyB0aGVyZSBpcyBu
byBuZWVkIHRvIGFkZCBhIGJyb2FkZXINCj4gYWJzdHJhY3Rpb24gZm9yIHRoaXMgc2luZ2xlIGNh
c2UuDQpUaGVyZSBhcmUgbWFueSBzdWNoIGZpZWxkcyBsaWtlIFBBdXRoIChBUEEsIEdQQSwg4oCm
KSBhbmQgU1ZFLiBUaGV5IGFyZSBub3QNCnBhcnQgb2YgdGhlIFNZU1JFR18gZnJhbWV3b3JrIGFz
IHRoZXJlIGFscmVhZHkgZXhpc3RzIGJvb2xlYW4gcHJvcGVydGllcw0KZm9yIHRoZW0uDQooQW5v
dGhlciB3YXkgdG8gZG8gdGhpcyBpcyBoYXZpbmcgLWNwdSDigKYsdmhlPW9uL29mZiBwcm9wZXJ0
eSkNCg0KPiANCj4gVGhpcyBSRkMgdGhlcmVmb3JlIGFsc28gYXNrcyBtYWludGFpbmVycyB0byBj
b25maXJtIHRoYXQgdXNpbmcgYQ0KPiBTWVNSRUdfPFJFRz5fPEZJRUxEPiBwcm9wZXJ0eSBmb3Ig
YSB2YWx1ZSBzZWxlY3RlZCBhdCB2Q1BVIGluaXQgaXMgYW4NCj4gYWNjZXB0YWJsZSBleHRlbnNp
b24gb2YgRXJpYydzIGZyYW1ld29yay4gSWYgdGhhdCBtb2RlbCBpcyBub3QNCj4gYWNjZXB0ZWQs
IHRoaXMgblZIRSBmdW5jdGlvbmFsaXR5IHNob3VsZCB3YWl0IGZvciB0aGUgZnJhbWV3b3JrDQo+
IGRpcmVjdGlvbiB0byBzZXR0bGUuIFRoZSBzdGFuZGFsb25lLXByb3BlcnR5IGltcGxlbWVudGF0
aW9uIGZyb20gdjEgaXMNCj4gYXZhaWxhYmxlIGFzIGEgZmFsbGJhY2sgZm9yIHRoZSBpbXBsZW1l
bnRhdGlvbiBkaXNjdXNzaW9uLCBidXQgSSB3b3VsZA0KPiBwcmVmZXIgbm90IHRvIG1ha2UgdGhh
dCB1cHN0cmVhbSBkaXJlY3Rpb24gdGhlIGRlZmF1bHQgYWdhaW4uDQo+IA0KPiBUQ0cgYW5kIEhW
RiBhcmUgdW5jaGFuZ2VkIGJ5IGRlc2lnbi4NCj4gDQo+IFRlc3Rpbmcgb24gYW4gQW1wZXJlT25l
IEExOTItMzJYIHdpdGggaG9zdCBrZXJuZWwgNi4xOC4yOS1hcm02NDoNCj4gDQo+ICAtIFRDRy1v
bmx5IGFuZCBLVk0tb25seSBidWlsZHMgc3VjY2VlZGVkLg0KPiAgLSBUQ0cgcmVqZWN0cyBTWVNS
RUdfSURfQUE2NE1NRlIxX0VMMV9WSC4NCj4gIC0gYXJtLWNwdS1mZWF0dXJlcyBwYXNzZWQuDQo+
ICAtIEFsbCB0aHJlZSBBQXJjaDY0IEtWTSBmdW5jdGlvbmFsIHNlbGZ0ZXN0cyBwYXNzZWQuDQo+
ICAtIFFNUCBmdWxsIGV4cGFuc2lvbiByZXBvcnRzIHRoZSBLVk0tZGVyaXZlZCBNTUZSNCBzdGF0
ZSBmb3IgYm90aA0KPiAgICBWSD0wIGFuZCBWSD0xLg0KPiAgLSBMaW51eCA2LjEyLjY3IGluaXRp
YWxpemVkIEtWTSBpbiBuVkhFIG1vZGUgd2l0aCBWSD0wIGFuZCBWSEUgbW9kZQ0KPiAgICB3aXRo
IFZIPTE7IFFOWCBIeXBlcnZpc29yIDguMC41IHJlYWNoZWQgbG9naW4gd2l0aCBib3RoIHZhbHVl
cy4NCj4gIC0gWGVuIGRvbTAgcmVhY2hlZCBsb2dpbiB3aXRoIFZIPTAgYW5kIGRpZCBub3QgYm9v
dCB3aXRoIFZIPTEuDQo+IA0KPiBUaGFua3MsDQo+IEhhc2VlYg0KPiANCj4gSGFzZWViIEFzaHJh
ZiAoMyk6DQo+ICB0YXJnZXQvYXJtL2t2bTogQWRkIGt2bV9hcm1fZWwyX2UyaDBfc3VwcG9ydGVk
KCkNCj4gIHRhcmdldC9hcm0va3ZtOiBMZXQgU1lTUkVHX0lEX0FBNjRNTUZSMV9FTDFfVkggc2Vs
ZWN0IGFuIG5WSEUgRUwyDQo+ICB0ZXN0cy9mdW5jdGlvbmFsOiBBZGQgYSBLVk0gc2VsZnRlc3Qg
Zm9yIGFuIG5WSEUtb25seSBFTDINCj4gDQo+IGRvY3Mvc3lzdGVtL2FybS9jcHUtZmVhdHVyZXMu
cnN0ICAgICB8IDIyICsrKysrKysrKysNCj4gdGFyZ2V0L2FybS9hcm0tcW1wLWNtZHMuYyAgICAg
ICAgICAgIHwgMzggKysrKysrKysrKysrKysrKysNCj4gdGFyZ2V0L2FybS9jcHUtaWRyZWdzLmgg
ICAgICAgICAgICAgIHwgMzEgKysrKysrKysrKysrKysNCj4gdGFyZ2V0L2FybS9jcHU2NC5jICAg
ICAgICAgICAgICAgICAgIHwgNTEgKysrKysrKysrKysrKysrKystLS0tLQ0KPiB0YXJnZXQvYXJt
L2t2bS1zdHViLmMgICAgICAgICAgICAgICAgfCAxMCArKysrKw0KPiB0YXJnZXQvYXJtL2t2bS5j
ICAgICAgICAgICAgICAgICAgICAgfCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+
IHRhcmdldC9hcm0va3ZtX2FybS5oICAgICAgICAgICAgICAgICB8IDIxICsrKysrKysrKysNCj4g
dGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3Rfa3ZtLnB5IHwgMjIgKysrKysrKysrLQ0KPiA4
IGZpbGVzIGNoYW5nZWQsIDI0MiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gLS0g
DQo+IDIuMzQuMQ0KPiANCg0K
