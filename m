Received: from smarthost4.eviden.com (smarthost4.eviden.com [80.78.11.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931A31B114
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055660; cv=fail; b=hxnaLge4cS2hBADQAMKnveWWOWt2cIiOEJNPK0KqiKtT1MF2wm4ZLo/vqAl+eMDk4ufszvIabAyJ/iM/Y1/CYGN9KZ0B2SIrqdq9tKql13WnDTX3KRgLEpuC9m63WXydxl4m4qejTTnfTsAzarObZA/cOqIE9XYq/yxgGpg5BuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055660; c=relaxed/simple;
	bh=5VXl5M+Uz+hIaki84Imi/04LwIvaxbImtvjRtN9vfNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e2wgOtQ9/w/jv/+DKqr7fOo1a/iLNySi4OzJD9D+5PH7GJ4bUAj0U64aYJGhoszo0+BvBfC2Kib/DUOUffYimFnemwwOT50kEDBj5EngGJSq2hRNmOcSbZWt7txUCnuuB6TX1Ikx86kPpGttzo+3V327/mbNjSy4MwmK2T22FVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com; spf=pass smtp.mailfrom=bull.com; dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b=ChlXnyI7; arc=fail smtp.client-ip=80.78.11.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bull.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b="ChlXnyI7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=bull.com; i=@bull.com; q=dns/txt; s=mail;
  t=1792055656; x=1823591656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5VXl5M+Uz+hIaki84Imi/04LwIvaxbImtvjRtN9vfNo=;
  b=ChlXnyI70stf+c1WjSN3+S+ZhADq9Cdr0FLcCSoTVl5iginSmB+KxhqF
   KhlSzzAlkD+jjy/vcNFEC9HWQx0zXGMK3HGQO4mw4rA8dqrcI+dK7I9f0
   k6RQyVqKInyNP0EbIJOQZuzAV8su+rp5Twimpgfpf4lDRT6iT5LAjFIqH
   u3p3gvtb3ARilEMpawe6swZ/TPx+y3/0pL5fT5Lqz3YyEq0r8XO58nZp9
   TIGvZDq8GuBltvzNu2kX/MCca6I5e7OoQD6Fe7WYKaCaBKA1H0lYfq2Vb
   iY2T+J8tPNjZKKjbbAw9lSQ/mfT6fF3vy0DWpbheqpE4Vn9q1F68cYwuj
   g==;
X-CSE-ConnectionGUID: epq+h8SuRAuDD3Q3xSLIRA==
X-CSE-MsgGUID: 2AA9JDn7TXq5q7zZO0ln2w==
IronPort-SDR: 6ad09831_zvm1qeM5xMk1JNBozeSSYApcD2PgWme/v3Eac3881ZtZ4bQ
 devTtzqUUyke4Za56EHnZSVTlO9UX+plPGldMWg==
X-IronPort-AV: E=Sophos;i="6.27,159,1787004000"; 
   d="scan'208";a="51060010"
X-MGA-submission: =?us-ascii?q?MDFKh5skxCmEXHh5jnvqBwucFQyHYXsmlCLSV4?=
 =?us-ascii?q?sOfS3Q2WuSEMJ7DieOMtxqZL1aIOx+45MQ2oWQ6CU+6YCJjYvFcpoymR?=
 =?us-ascii?q?Ndp4xd6mukcF9DuiDZS8Rc/CnGstGGpcWk9q46qqID7py4wt6pHnVFGZ?=
 =?us-ascii?q?6blL/EmIfZW2tyKi4rArxX4Q=3D=3D?=
Received: from mail-norwayeastazon11013041.outbound.protection.outlook.com (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.107.159.41])
  by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Oct 2026 11:09:04 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj+QCjGNqY2IwHA2u+fqWKg5vVXn8fH+C8IbePopDnellNKb2aSizip+S7dRNk/3zPVzS/7mxhfvak69Xpgj01DRBmxnH0/4Kifg/koIFvp8b9g5gk6MfXftsMChM0l9ipYbOzU0Fye7p7VntgnHb14O9KrKKZTudLrBSrlTQjLr3ngytM+r9xxgU9XRUZ+rXOeqlMRTrWrfPhJ303SfZoVZeFzWhqJx6vO/n0vF2O1sdEwzLeLXtN57Q3InF1vhbFHmsEj3MvaEE/jPxRZdKZfsT1FNuP1Gmt8DsA0QZX7K02+LPtfAXQ5qoVRe7j2LzqhKcqRdsEkk4a5TBT866g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VXl5M+Uz+hIaki84Imi/04LwIvaxbImtvjRtN9vfNo=;
 b=cSKuHErh9tuYZX+TPbOafRBh539cu8m/iJH++VLP19+NzhRE39LrHlvzKeijSS4Mzb0RgUJbmU5GG8NbCNinxIXVugeLx0YPvGkRyOy447cExm10ynkG4uZpxcacZdc0pzVFiG7bz6xOChtvEGvacM1ocxwbii1QDf4uPNKjSaAXe/RsRqKzcvPRq20H++PvbH0iaSK1v76eaePfQpVXYf3lm3TKvUL3RIbtyoVpY9EZaV40e27hKmHIFDf87DddO0l1g0RY2GWoDiGwJ7/7n4XSt4pLN+P9RnfV+lXXEfxkzH3s/ZUsIaHVEHHi0KAAwmbzkM8iMYosnJD2J/YhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB11937.eurprd07.prod.outlook.com (2603:10a6:800:33f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:08:59 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:08:59 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
	<clement.mathieu--drif@bull.com>
To: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Ani Sinha
	<anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang
	<jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Yi
 Liu <yi.l.liu@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 2/8] x86-iommu: Introduce x86_iommu_device_get() for
 x86-iommu retrieval
Thread-Topic: [PATCH 2/8] x86-iommu: Introduce x86_iommu_device_get() for
 x86-iommu retrieval
Thread-Index: AQHdW53iI3vdEc759UCybmQrqSLgvbb+UmMA
Date: Thu, 15 Oct 2026 09:08:59 +0000
Message-ID: <e9162ee926e190d1fe7962d07a7c6e0b401456db.camel@bull.com>
References: <20261014053433.24564-1-sarunkod@amd.com>
	 <20261014053433.24564-3-sarunkod@amd.com>
In-Reply-To: <20261014053433.24564-3-sarunkod@amd.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI0PR07MB11937:EE_
x-ms-office365-filtering-correlation-id: 656cb41f-415a-4147-cb85-08df2a9bf305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|10067099003|20046099003|5123799003|21026099003|18002099003|921020|11063799006|4143699003|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 MZ7x5BSQAONDDcMeo9SWQORQObXo/zO7NjSieONNUPjD1IwOaPSq30+aoz1gl265EctsXo+mexJSRxEr5Gdrc9B1cuFh7z3QHvs4FuEPpGpbJJx/2ONYxw7KC+YpstRkhDZL2JGJtjnAPJmnYtSsh8+rZtm20P+r8bMljyINI8UpkiulkyOvF51gp1Pm21zzmD/MNjRpWaHOOwhoBQ0aRRxjdS1m0H5lmpM0U16njSSboVWKrBVd54FRxPXno+RWv2Yn0iuoYEiiBjJQ9OLZ0TG1RIaFN52YwbgrmTk3O2RE+9cHW0lQZAtpFC3ujmqSgnPOVHGDRIICkJiBLy5LzibhWqRTibwdYcsICD+y6blI8g8ndlJmgpp+vf+4JqPcQdB0qESabqleLRF+YuzNI5TQ5iFIDV4knVXEu0ln6xHpcIRGLyE6OFGLRFBXORxYv2iHBlV9YLNH3klkbmzeTi6GIRgvsrd0JCA1Ldg7EYc77xNKY+OptCJPVjW26u0/2JHZ9w2DIuFilePaXQ+wa3OJ9Zh1KX/x+q04277LAu+JDES6onpvS4dTgniSr+9CHaryQFYFzi2leRxown8wBEt2MOm7c0wfFn0qzW8ouIqSc6AcesuiKObDA+cmH5Nq+rG8RWqxjX3xKxnmRFAfhs/UhU4LWrYA5G02Z6YrB2mW3NIVFoDBx6VLkAXj/q5x2atkyY8fapBAX9/mvvQWjaVCx+46IYu/QyB9bAPVKMnwRx+SPB0GQSdyD8Vw3Zj8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB7602.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(10067099003)(20046099003)(5123799003)(21026099003)(18002099003)(921020)(11063799006)(4143699003)(261009223027099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkJvd05MdnZhWVg4Z1Z1ampuTDZiZ00vQXVlSjRnYWc3L2JKZUs1S1ZzMno2?=
 =?utf-8?B?MXQycXZWUDZNWTFrczk0citMZ0Qxbmx6cHlzUkdLSDhzcDVrVFpaZ3hheFVj?=
 =?utf-8?B?MXc2TlA4SUUyM3lMZ09LTHFOVU1naXdvY1RVLzBWY2RsNThZdkZJMXNrSTRN?=
 =?utf-8?B?UDlxM1lhR2NnMWxXZUlMcmFSVFlxVmhMblJ2SGQ0Y2ZNQkRLdzdmNGovTWIx?=
 =?utf-8?B?SzVuVjI4QWREZkk1bnBFdnE0aFZTZ1Q5MndaeDRMeCtOc0ltcjY3b3BDTkd6?=
 =?utf-8?B?S0hIWlgvSFhwaGZYNDVLKzNDNnhWdVRIWElBOGxYQ1Rna1Vwcm43d1dTZU85?=
 =?utf-8?B?eWxXbkNhQkNtcGN4N0l1MjB1R3hkRm85Q0ZYdG9BSGF6WmJaaEtvMG10bW9S?=
 =?utf-8?B?RU5qUFpUMlExYWJ6bVJyc3R4elJTWXpreXErRktwaG44bXgrbEdSenZoYW41?=
 =?utf-8?B?U1lBdXpsNGRpRzRlbE04R1NSTXI2dHBHbG8zQ2NFMHBIYlpVaGpOYnZVVVFV?=
 =?utf-8?B?bmNJQXZ3M3hsd1BKaWdBNTZ0TEQvamd5ZHdJVHI5NVArT2FCSWpwa0VDS25j?=
 =?utf-8?B?dGV0aHdQTUt4OVBNY05idVU0aldGTHROdTdBa2t5ZTBBVENWM3NTYUZIaEZj?=
 =?utf-8?B?eEZNR0ViV3JJSjdKMFVFRTBpMU96amc1SkVBV3pkRXRDRTNsNjhLeXlHbzk2?=
 =?utf-8?B?aEg3eTNEZXBXM284WXMxOTR3dVZ6R01OQTdSVnlqQUs2TTFLYXVnbHppQm9V?=
 =?utf-8?B?dWhKbU9Uang0U1dqNHZ6UFVJWkpVSW54MG1wV0lnbVZFUjVOMnNRc0FiL3Ur?=
 =?utf-8?B?c3IxcjlKTFdZcTdEbmdWU0RGYTY4MzVkODNadmJDV3Y2QzIzcUpMSzlTbEV6?=
 =?utf-8?B?Vk5LQUZlWjVyUngvanhFTld1NlZUTWRkVnp5TDdGc0FWRWQvSCtzY1U4elo4?=
 =?utf-8?B?eHpQUVhEY3NkSnZpTEFoVTV5WEdLT3hWa20zSzhQZE1RcnA3b2V6MGppRnI0?=
 =?utf-8?B?NXBRVmh5SmprTEVTMmlmNlp4T0Q3WTNjaFBRQUhxdGZlZ0JBc0JJUEpBVE05?=
 =?utf-8?B?RmU4NnB1d25LcmhFcnUxdHpxOWR6eE50aDJwaCtJL1FPTVJ0eTNVRXdHSlcw?=
 =?utf-8?B?U05LMGVzZ2ZsZS9ORlJQVGFRcVdIVmtRdmgxNlVFSkxyRGNhYVZaYmpkTzUy?=
 =?utf-8?B?TEpIT1hHbXpkUlF0OUxtdFNvZzZMenRDTkVpZnBjdkRodXJNQVJITVE1NERq?=
 =?utf-8?B?dElWTjJIN2xZUmRVUWNYb0xiRTVUMWJhcGhEN1NtRHByUk1zNW1TaUhKaUhY?=
 =?utf-8?B?MEM3UHBoN2doaW92Y3l0VmlYYXFTeG1YQXV4UzRZNENBdVFLMEd2b3BvOTd3?=
 =?utf-8?B?NWt0Ym1CdFoxRURIdEIrc3VzN3Q3VXF3ZTRDZXB1aHFRR09WUTBCeUNPdlR2?=
 =?utf-8?B?M2lWS1VpeDRRdE9mWE5EY3JvMFZxTjhGRG1CUkwwK28wQlN2aWhMMzRiYkpU?=
 =?utf-8?B?YmJmdmxza01adkxCSGordmhNUStST3Z2ck92UFh2VFREU1BIamgvdkp4QnhV?=
 =?utf-8?B?QkttdG1tYWhDbHFPb1lBd1VoM24vd21jVjAzY25ScjI2TjRMbDAyUW8zOFF1?=
 =?utf-8?B?SjcwVVU0SjlIc3N2QS82WkhobDY0QWt1RVRRL3J2VmtXVGd0QlJwWUhNbXI4?=
 =?utf-8?B?L0VQK0FSSFh6ZEVTazBqcXVGOVJoRlRtRmFPS21xbk0xYS9wS2NQM2dFM3M1?=
 =?utf-8?B?Y1owRFVtM0tTc04xWm4ycDJKelcrb1BXNHBSc0J4d2NSc1AyVnVZN3lwa01V?=
 =?utf-8?B?UVdCK0hDNTIvNTVLbUc0Q0RrTlpiQndBWjVGRFdMOU5qb09oQUtCUTRWeTF0?=
 =?utf-8?B?WGp6WDUzRmJlYXNZWExPTmtUMDZqL0pZTDh0NjNDeHkrWlozUURSQ0FLSE83?=
 =?utf-8?B?ZTlMbk44ZjNNaCt1V1ZBZWgyNUlZdG91RUNsdE9aNVd4ZGpZR1AwZ1BtdEN3?=
 =?utf-8?B?NDVCWlQvM0xEZ3FzeEpuZHRvSDZFYVBNKzgxd2k5eWRXazVuZDlWUzhuYzVr?=
 =?utf-8?B?TFVtTUdSSE1ZTzBpQ0ZJa28vTUlXQnJNS3ovRVIwcjZpSFFNRnlwUyt1aW5T?=
 =?utf-8?B?UWRYdVhpK3dYNW9KU1paQ3Y1MDAyeVowYzN4VkNvdUFhNHhyOUc5VGltNnBt?=
 =?utf-8?B?OWFOUFNya0xMR0xzUkFQcGlVL1IrdWlxOGhaZXgwaDdmVHkrUCt0QXg4b0dD?=
 =?utf-8?B?Um0yUGxGLzRYSEpkalV3YStFZDhmTkFReXNsc010K2hmWFBKbldhOWZpQ0N3?=
 =?utf-8?B?ZzkyRFg2OTJxTSt6U3ltSTlSbzA5UDFFSDlOMUZaRVpQZ3hSclZsdWRmMXJ5?=
 =?utf-8?Q?Yn4bIb5jhHz4XcT/gV7Mc6E6IAeycm6N8ixYO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8A594C11AC6B843931A68BA4D5550D9@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	OfBg5wCV2BXei41ECu3V+l1V0DNifewvevO4h7LmBayf8ASfDpWf3jR4ro3V5fKZn5I1fFSDfNY+lEeAxcziJ+8ajam6o6b1g4PKa6AHSbSBX89fNWfOK9wizNae3kjKVWp5WLnfH/Rr5BaJWN+qAZGs4h7GIB0FXONMy+PjyJR38rX5h5dLxAVFLEZyOSedElGF7IYbkcWDnyh0y+UkRylRq2iXYfo14UuZikZwPTX+QRes1VR62FT/qPfAkPe+NdDTTBYwxfcy+q8VUHZIme8UH7BIUdg3YygU5lsuKzbh10/vGvstBShXrtFlG1+yd7r/XPTeA0J0rtl2vpk+SQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656cb41f-415a-4147-cb85-08df2a9bf305
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:08:59.5015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2EGUIBvz6swVGRAL0yMMLpVb99+MaCBdPFF6kac3/rhfWQPJB0qv5PC0sQ8VC6yZMDb9UqQax5jEpnPAZgt9wHmBtS36YML6ZiM8ZjsMGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11937

DQpPbiBXZWQsIDIwMjYtMTAtMTQgYXQgMTE6MDQgKzA1MzAsIFNhaXJhaiBLb2RpbGthciB3cm90
ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9y
IGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IGt2bV9hcmNoX2Zp
eHVwX21zaV9yb3V0ZSgpIGFuZCBrdm1fYXJjaF9hZGRfbXNpX3JvdXRlX3Bvc3QoKSB1c2UgIA0K
PiB4ODZfaW9tbXVfZ2V0X2RlZmF1bHQoKSB3aGVuZXZlciBhbiBJT01NVSBpcyBwcmVzZW50LiBU
aGlzIHNlbGVjdHMgdGhlICANCj4gY29ycmVjdCB1bml0IG9ubHkgd2hlbiBhIHNpbmdsZSBJT01N
VSBpcyBhdHRhY2hlZCB0byB0aGUgc3lzdGVtIGJ1cy4NCj4gDQo+IFRoZSBmb2xsb3dpbmcgcGF0
Y2hlcyBhbGxvdyBhbiBJT01NVSB0byBhdHRhY2ggdG8gYSBkaWZmZXJlbnQgYnVzIGFuZCAgDQo+
IGlzb2xhdGUgdGhlIHN1YnNldCBvZiBkZXZpY2VzIGJlbG93IGl0LiBFYWNoIElPTU1VIHRoZW4g
c2VydmVzIG9ubHkgcGFydCAgDQo+IG9mIHRoZSBQQ0kgdG9wb2xvZ3ksIHNvIGludGVycnVwdCBy
ZW1hcHBpbmcgbXVzdCBkZXRlcm1pbmUgdGhlIElPTU1VIHRoYXQgIA0KPiBhY3R1YWxseSBzZXJ2
ZXMgYSBnaXZlbiBkZXZpY2UuDQo+IA0KPiBBZGQgeDg2X2lvbW11X2RldmljZV9nZXQoKSB0byBs
b2NhdGUgdGhlIElPTU1VIGJ1cyBmb3IgYSBQQ0kgZGV2aWNlIGFuZCAgDQo+IHJldHJpZXZlIGl0
cyBYODZJT01NVVN0YXRlIHRocm91Z2ggYSBuZXcgZ2V0X3g4Nl9pb21tdSBjYWxsYmFjay4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFNhaXJhaiBLb2RpbGthciA8W3NhcnVua29kQGFtZC5jb21dKG1h
aWx0bzpzYXJ1bmtvZEBhbWQuY29tKT4gIA0KPiAtLS0gIA0KPiDCoGh3L2kzODYveDg2LWlvbW11
LXN0dWIuY8KgwqDCoCB8wqAgNSArKysrKyAgDQo+IMKgaHcvaTM4Ni94ODYtaW9tbXUuY8KgwqDC
oMKgwqDCoMKgwqAgfCAxNiArKysrKysrKysrKysrKysrICANCj4gwqBpbmNsdWRlL2h3L2kzODYv
eDg2LWlvbW11LmggfMKgIDYgKysrKysrICANCj4gwqBpbmNsdWRlL2h3L3BjaS9wY2kuaMKgwqDC
oMKgwqDCoMKgIHwgMTIgKysrKysrKysrKysrICANCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDM5IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L3g4Ni1pb21tdS1zdHViLmMg
Yi9ody9pMzg2L3g4Ni1pb21tdS1zdHViLmMgIA0KPiBpbmRleCA3ODFiNWZmOTIyMjcuLmIwMzgz
ZDIyOTBiMSAxMDA2NDQgIA0KPiAtLS0gYS9ody9pMzg2L3g4Ni1pb21tdS1zdHViLmMgIA0KPiAr
KysgYi9ody9pMzg2L3g4Ni1pb21tdS1zdHViLmMgIA0KPiBAQCAtMzIsNiArMzIsMTEgQEAgWDg2
SU9NTVVTdGF0ZSAqeDg2X2lvbW11X2dldF9kZWZhdWx0KHZvaWQpICANCj4gwqDCoMKgwqAgcmV0
dXJuIE5VTEw7ICANCj4gwqB9DQo+IA0KPiArWDg2SU9NTVVTdGF0ZSAqeDg2X2lvbW11X2Rldmlj
ZV9nZXQoUENJRGV2aWNlICpkZXYpICANCj4gK3sgIA0KPiArwqDCoMKgIHJldHVybiBOVUxMOyAg
DQo+ICt9ICANCj4gKyAgDQo+IMKgYm9vbCB4ODZfaW9tbXVfaXJfc3VwcG9ydGVkKFg4NklPTU1V
U3RhdGUgKnMpICANCj4gwqB7ICANCj4gwqDCoMKgwqAgcmV0dXJuIGZhbHNlOyAgDQo+IGRpZmYg
LS1naXQgYS9ody9pMzg2L3g4Ni1pb21tdS5jIGIvaHcvaTM4Ni94ODYtaW9tbXUuYyAgDQo+IGlu
ZGV4IGE1NzQ0NTQwNGVmOC4uNjAxZGI1Y2ZlYTA5IDEwMDY0NCAgDQo+IC0tLSBhL2h3L2kzODYv
eDg2LWlvbW11LmMgIA0KPiArKysgYi9ody9pMzg2L3g4Ni1pb21tdS5jICANCj4gQEAgLTI2LDYg
KzI2LDcgQEAgIA0KPiDCoCNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIiAgDQo+IMKgI2lu
Y2x1ZGUgInRyYWNlLmgiICANCj4gwqAjaW5jbHVkZSAic3lzdGVtL2t2bS5oIiAgDQo+ICsjaW5j
bHVkZSAiaHcvcGNpL3BjaV9idXMuaCINCj4gDQo+IMKgdm9pZCB4ODZfaW9tbXVfaWVjX3JlZ2lz
dGVyX25vdGlmaWVyKFg4NklPTU1VU3RhdGUgKmlvbW11LCAgDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGllY19ub3RpZnlfZm4gZm4sIHZvaWQgKmRhdGEpICANCj4gQEAgLTkwLDYgKzkxLDIxIEBAIFg4
NklPTU1VU3RhdGUgKng4Nl9pb21tdV9nZXRfZGVmYXVsdCh2b2lkKSAgDQo+IMKgwqDCoMKgIHJl
dHVybiBOVUxMOyAgDQo+IMKgfQ0KPiANCj4gK1g4NklPTU1VU3RhdGUgKng4Nl9pb21tdV9kZXZp
Y2VfZ2V0KFBDSURldmljZSAqZGV2KSAgDQo+ICt7ICANCj4gK8KgwqDCoCBQQ0lCdXMgKmlvbW11
X2J1czsgIA0KPiArwqDCoMKgIFg4NklPTU1VU3RhdGUgKmlvbW11ID0gTlVMTDsgIA0KPiArICAN
Cj4gK8KgwqDCoCBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmaW9tbXVfYnVz
LCBOVUxMLCBOVUxMKTsgIA0KPiArICANCj4gK8KgwqDCoCBpZiAoaW9tbXVfYnVzICYmIGlvbW11
X2J1cy0+aW9tbXVfb3BzLT5nZXRfeDg2X2lvbW11KSB7ICANCj4gK8KgwqDCoMKgwqDCoMKgIGlv
bW11X2J1cy0+aW9tbXVfb3BzLT5nZXRfeDg2X2lvbW11KGlvbW11X2J1cy0+aW9tbXVfb3BhcXVl
LCAgDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAodm9pZCAqKikmaW9tbXUpOyAg
DQo+ICvCoMKgwqAgfSAgDQo+ICsgIA0KPiArwqDCoMKgIHJldHVybiBpb21tdTsgIA0KPiArfSAg
DQo+ICsgIA0KPiDCoHN0YXRpYyB2b2lkIHg4Nl9pb21tdV9yZWFsaXplKERldmljZVN0YXRlICpk
ZXYsIEVycm9yICoqZXJycCkgIA0KPiDCoHsgIA0KPiDCoMKgwqDCoCBYODZJT01NVVN0YXRlICp4
ODZfaW9tbXUgPSBYODZfSU9NTVVfREVWSUNFKGRldik7ICANCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaHcvaTM4Ni94ODYtaW9tbXUuaCBiL2luY2x1ZGUvaHcvaTM4Ni94ODYtaW9tbXUuaCAgDQo+
IGluZGV4IDBhMWUxYmE3MjU3MS4uZWI1NzUyNzFlOWQ3IDEwMDY0NCAgDQo+IC0tLSBhL2luY2x1
ZGUvaHcvaTM4Ni94ODYtaW9tbXUuaCAgDQo+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni94ODYtaW9t
bXUuaCAgDQo+IEBAIC0xMzQsNiArMTM0LDEyIEBAIHN0cnVjdCBYODZJT01NVV9NU0lNZXNzYWdl
IHsgIA0KPiDCoCAqLyAgDQo+IMKgWDg2SU9NTVVTdGF0ZSAqeDg2X2lvbW11X2dldF9kZWZhdWx0
KHZvaWQpOw0KPiANCj4gKy8qKiAgDQo+ICsgKiB4ODZfaW9tbXVfZGV2aWNlX2dldCAtIGdldCBJ
T01NVSBkZXZpY2UgZm9yIGdpdmVuIFBDSSBkZXZpY2UgIA0KPiArICogQHJldHVybjogcG9pbnRl
ciB0byBkZWZhdWx0IElPTU1VIGRldmljZSAgDQo+ICsgKi8gIA0KPiArWDg2SU9NTVVTdGF0ZSAq
eDg2X2lvbW11X2RldmljZV9nZXQoUENJRGV2aWNlICpkZXYpOyAgDQo+ICsgIA0KPiDCoC8qKiAg
DQo+IMKgICogeDg2X2lvbW11X2llY19yZWdpc3Rlcl9ub3RpZmllciAtIHJlZ2lzdGVyIElFQyAo
SW50ZXJydXB0IEVudHJ5ICANCj4gwqAgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIENhY2hlKSBub3RpZmllcnMgIA0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kvcGNpLmggYi9pbmNsdWRlL2h3L3BjaS9wY2ku
aCAgDQo+IGluZGV4IGYyNDQ4ZTk0MWEwYi4uZjNjNGMzYTRkYjU2IDEwMDY0NCAgDQo+IC0tLSBh
L2luY2x1ZGUvaHcvcGNpL3BjaS5oICANCj4gKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpLmggIA0K
PiBAQCAtNjk4LDYgKzY5OCwxOCBAQCB0eXBlZGVmIHN0cnVjdCBQQ0lJT01NVU9wcyB7ICANCj4g
wqDCoMKgwqDCoCAqIFJldHVybnM6IHRoZSBndWVzdCBwaHlzaWNhbCBhZGRyZXNzIG9mIHRoZSBN
U0kgZG9vcmJlbGwuICANCj4gwqDCoMKgwqDCoCAqLyAgDQo+IMKgwqDCoMKgIHVpbnQ2NF90ICgq
Z2V0X21zaV9kaXJlY3RfZ3BhKShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4p
OyAgDQo+ICsgIA0KPiArwqDCoMKgIC8qKiAgDQo+ICvCoMKgwqDCoCAqIEBnZXRfeDg2X2lvbW11
OiBnZXQgcGFyZW50IHg4Ni1pb21tdSBmb3IgZ2l2ZW4gaGFyZHdhcmUgKEFNRC9JbnRlbCkgIA0K
PiArwqDCoMKgwqAgKiAgDQo+ICvCoMKgwqDCoCAqIENhbGxiYWNrIGlzIHJlcXVpcmVkIGlmIElP
TU1VIGRlZmluZXMgeDg2LT5pbnRfcmVtYXAoKSAgDQo+ICvCoMKgwqDCoCAqICANCj4gK8KgwqDC
oMKgICogQG9wYXF1ZTogdGhlIGRhdGEgcGFzc2VkIHRvIHBjaV9zZXR1cF9pb21tdSgpICANCj4g
K8KgwqDCoMKgICogIA0KPiArwqDCoMKgwqAgKiBAeDg2X2lvbW11OiBBIHBvaW50ZXIgdG8gc3Rv
cmUgdGhlIHg4Ni1pb21tdSBvYmplY3QgIA0KPiArwqDCoMKgwqAgKi8gIA0KPiArwqDCoMKgIGlu
dCAoKmdldF94ODZfaW9tbXUpKHZvaWQgKm9wYXF1ZSwgdm9pZCAqKng4Nl9pb21tdSk7ICANCg0K
QXJlIHlvdSB1c2luZyB2b2lkICoqIGJlY2F1c2UgdGhlIFg4NiB0eXBlIGlzIG5vdCBkZWZpbmVk
IHdoZW4gYnVpbGRpbmcgZm9yIGFub3RoZXIgdGFyZ2V0PyAgDQpJJ20gbm90IHN1cmUgaWYgdGhl
IFFlbXUgcnVsZXMgYXJlIHN0cmljdCBhYm91dCBhcmNoaXRlY3R1cmUgaXNvbGF0aW9uLiAgDQoN
CkRvIHlvdSBoYXZlIGFueSBpZGVhIGFib3V0IGhvdyBhY2NlcHRhYmxlIHRoaXMgaXM/DQoNCklz
IHRoZXJlIGEgcmVhc29uIHdoeSB3ZSBjb3VsZCBub3QgZXhwb3NlIHRoZSBBUEkgaW4gdGhlIHNh
bWUgZmlsZXMgYXMgeDg2X2lvbW11X2dldF9kZWZhdWx0Pw0KDQo+ICsgIA0KPiDCoH0gUENJSU9N
TVVPcHM7DQo+IA0KPiDCoGJvb2wgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKFBDSURl
dmljZSAqZGV2LCBQQ0lCdXMgKipwaW9tbXVfYnVzLCAgDQo+IC0tICANCj4gMi4zNC4xDQo+IA==
