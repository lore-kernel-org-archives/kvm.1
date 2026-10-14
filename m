Received: from smarthost2.eviden.com (smarthost2.eviden.com [80.78.11.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1B4E4C29
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972192; cv=fail; b=uY5zKKbFbuSkKlIfgn4Uf4MTKxhbsenLoMadlqLSJXIM0zWHDO+efoehCXLXrKS+bhCfbe6w6PVRpVaUFkdIpwzUQFtBzqo3XlZiDQM/ek7uAZ6TSiYN/m3XrVlnWBtWYG3WEusbAFM3lZzBRM4lzaGu2mRSJxvT9uIQJGBiLMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972192; c=relaxed/simple;
	bh=l/nCR+JmuLPCSsLJZmBH4sFv4BP1QB6FKhQs9pWdMvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dnkylDtXqJATImNn/sKja1oLHlVYCOeCOY3V+wWJy0hOSSqoj/RfEWP6njcdYmdKHfDXldH/QxMz1FOvRObTmxiuqOJD9p0oZPOSb6iDRk+ezFF726bV0nk/2zlMqfA4+DGmKVhUvoWZ8FQ1qSIKXGxbzda1zROQzgUowKsb0Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com; spf=pass smtp.mailfrom=bull.com; dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b=JvS/QZ6J; arc=fail smtp.client-ip=80.78.11.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bull.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b="JvS/QZ6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=bull.com; i=@bull.com; q=dns/txt; s=mail;
  t=1791972189; x=1823508189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l/nCR+JmuLPCSsLJZmBH4sFv4BP1QB6FKhQs9pWdMvQ=;
  b=JvS/QZ6JCU3v2AIAzE2wDEijEwOUPVvyEy/p3M1aV4CA5opimttuFevC
   aGLQfWkxFU/sFDCeD2ucsyXOLmGi/qJLqWzhHc2u/oOiUlyfp1buy92iU
   VBk3PJ2z/3cSKJ5G5W33Jr/0isSMREJ2Jfslafn/1dvPS/nPhX2VwbK0C
   2RhmZbnRPtWM7EmdSSg+UV2RD+GAS63NihCUb7/dRds0fHRKETbeHqTYK
   owl5ymatp5KwnDEkb72Qvt+wgoTLI55MbmTF62k1qHyrNyT0fdnR62pb0
   AtGdvzW0UH53y33htH4xvMTuU9se2J7yV9w/XCHGdp23Fu3aW2ClrJ5CE
   g==;
X-CSE-ConnectionGUID: tVDZVhdnRh6xomu84+vCXQ==
X-CSE-MsgGUID: Qu3V77fsTMuqsCy4jRTTMA==
IronPort-SDR: 6acf5225_MGbKPeccn5WE6xhsY4Xp4fGe28qj42mB9cSD8VgH8/OF/Pp
 zE4eK2eD1UQsVZfG3OyVMtQbyb57bom8fXb70AA==
X-IronPort-AV: E=Sophos;i="6.27,157,1787004000"; 
   d="scan'208";a="48943556"
X-MGA-submission: =?us-ascii?q?MDGqbM0om6c/0inkcGtNMX0sbhYuKdli7XcgfN?=
 =?us-ascii?q?Vs/JEzZUVoIsO3HIWd8aFv/2VqrxvWNm+hjgv0XrnU4ZoboKrGo+Y65d?=
 =?us-ascii?q?w1XGMp2m4NLxztttuM79CiT4nSUi6Ce3UlYiNaD/EazxxXCefTXXyQkv?=
 =?us-ascii?q?bL/8xAGXmuk+RJajf0kFdziA=3D=3D?=
Received: from mail-francesouthazon11011065.outbound.protection.outlook.com (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.65])
  by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Oct 2026 11:57:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoGcdL1Qcqab/FI/N/y5XqP+us10abbJ8TeZKhV8M/6DbN4c6Gw38g8v4fF2PeM8SlSs22ayBTUej4Ga5iAihQ4MjZJ0uOaxco+yCuU4jUPtZYcR0pwm1F4faIo2gSLf7rc2R7P7cjoUb7t6hEsyTQNkvWfNSrnWLV0VyK5iL7t1uHjJiqoTbsd13+rZfpCDO5wE9psD04hpDAm5U2NEZgAxd/kzKNMZ1SNSE+h6dJG5ofOZe20XUDdewJl/dRxMdirkuTgAIS/AHo4037bbkXEzbMPAl3iSJ7ghWcIhI6dwC9V0LGIMu3HYXu2hSlbCmrhdTJYWr4agMOAlJylVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/nCR+JmuLPCSsLJZmBH4sFv4BP1QB6FKhQs9pWdMvQ=;
 b=CL6iZ9MyB/liBlN2JkuiQS+Uv9RARa2iHdsGiWXepXW7AWItSjBG+EvvbsD6qXme6RVb7J+bfK8yb73Y24IMEvbAM4yb1aA/OfmiOPRg2loBfn2yVIP9MOwmvjq1cT5EQT1kMaNtsEpJ5voYDOYBQPI9sqDyINivkYs5ahjbCmO5PbqlavJ9YQZuQqwAIFvgQigtsyQNE9C+DRqbdqSt+p1Fel5u8sdYWFAy7Ls1dGjza6OOhWRgA/ZWzBiBtVlCTyx2jFoO4nBKs9QdlMV7Yva0zhUl0vBIA/NRGiZcT9T5JPISYATwLDli0BSrkzFON5fvCLLEA3z505zTwMJ/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by MI3PR07MB12338.eurprd07.prod.outlook.com (2603:10a6:290:74::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 09:57:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:57:52 +0000
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
Subject: Re: [PATCH 4/8] intel_iommu: Add support for get_x86_iommu callback
Thread-Topic: [PATCH 4/8] intel_iommu: Add support for get_x86_iommu callback
Thread-Index: AQHdW537XmqxxG+EYECvgeFQ/NG/37b8zbaA
Date: Wed, 14 Oct 2026 09:57:52 +0000
Message-ID: <ebe3f5d372113258b8e2b2eb6f9016611fa67a1e.camel@bull.com>
References: <20261014053433.24564-1-sarunkod@amd.com>
	 <20261014053433.24564-5-sarunkod@amd.com>
In-Reply-To: <20261014053433.24564-5-sarunkod@amd.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|MI3PR07MB12338:EE_
x-ms-office365-filtering-correlation-id: 7e2cf08f-b9f7-4c41-8e34-08df29d99c9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|38070700021|56012099006|921020|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 dFxP1fVAXKAhNoTtVu8bEZBCadUGu7v6COYbnDxpElvUrRrC5AfR6rORIWtgnziKcDB0AhSROTClz10sq8V2gf6J9I6QfsmOBE7iTcTakRxuJmQj9WTyv+Cu670Fa5XSYrQgMHPQ44KWqAWEY1roq7KdbgET+/kxdvl0iCFzCCUSna1VzXO2XBNg4LJytDlXcmOBEAzVll7MY0UPd69Knu+4uIIyWLNzvLRBuTU0TNivCiHpzrTx72nlBJybOXkM/3Edo/M9lgCEsfz0/u0KK3j8gxbnXBeX0rfp6v6epS6Z4SRkOdGkhTYiH9i/9BHwf8LsRpgFq+zftqg2ZP6gpqolfmw+IJNiDBk7QBcOTEIRPOoNLG/Yilgm92++MlXAucqehMaGxSolBgOFQzVjfyuomwgfO9Q291IPWCBxP/yrusMeLBwcVFMwmTccPk56RRqWPn64pPtWoEE8DdHDINa25DkutWb0yJW3BcasFVjjgiWwM/7s33hZ2vAQePxFPssWG0JFBPgd3vsX0lnukL2cnBaRYNb/tcn3/FanWPQxC/sJU3susRUMuV8HW9EKyns10bKYLje68jPr8yKdlePBTSFLLGcPHsygDt968pIm2ZiKMfsJ1cWKnQFtVetFCZL2l0aQHw1v32y55yCXhIEwtSZ9Ar3k9hj/A/Z2YN1nrZ6GNDvu+pCUk36u0weoYmqxc02bxBCc51FEcFDc9zMbeU6TCJVDOzHyvgudCJKISeXQ0TJdj0C7SsvouDTH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB7602.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(38070700021)(56012099006)(921020)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bi83ZzlGeFFKbXMwMnVkK0x2ZTlnTTg2aERUcExrcUFIL1JVUEk0VmV2S0pV?=
 =?utf-8?B?amZiZ0drZ2UrcXJQV3Z5bHdmWHBocjVZdDd1RGtHbEh6OVA3UlZLc1gvcERU?=
 =?utf-8?B?aEJuREpnR1o5MDBHcVp4YythVzRyNnVsaXNFNjMvMUtwWUpXNlpIUlZaRWxM?=
 =?utf-8?B?UUhMQzYvenhhMGdlak56a0tnU0VVWnFYT0xqcm03ellPeTk5OC9uTnp2aWlY?=
 =?utf-8?B?WnJDSFI4L2R4bGVURExJL3VBQ1Rlc3dPSjFsZ0xDc1FTRTkyOXlxWnRSc00z?=
 =?utf-8?B?Vy9lR2FIMEVkMEFra2gyMTltckRNQ2ZkRWRzTG1RTnRWRjU1S2ZHM2NvT0dC?=
 =?utf-8?B?UHVkZHlSRkRyMHE4NUxLb04rdFgvcFk0QWF3K2JnSWZoYkJZV0RLSmxFbUVk?=
 =?utf-8?B?aVRxUlhMUDUzeFovWlN0dnlETk5RZitPRmp1cExEUnB1NEhMcm9TQnJua3Nv?=
 =?utf-8?B?VHV0TDNSam5jZldkdStMb2xUVHh2SXB1TzExbXhNY2VQM2N6RUVoSTQxcmsr?=
 =?utf-8?B?NkhDVXczNGx2VURYMUl1NERITmU2QS82QXBGOHRDTDJnVlFsekI5Wk81bDJu?=
 =?utf-8?B?Vjhua0VkU0QrWmhsS2hIb2hwUXE5d2hBNEx5d3AyOWhwa0h3RVpUWktqUkR6?=
 =?utf-8?B?ajFBMGZES0hUZFdJREpsaHFmRjlOeXkwZHpHeGtZSFNZNXBEa1NPK29RV2RZ?=
 =?utf-8?B?WktrSSt4c0hNMXhnMXEwUVFPY21uUjdNaHYrWWRtTjZ3a21UY3pIQ0tKakNC?=
 =?utf-8?B?VnJoNW1MTkQ2OWZrZ3BhNkg0OWllN0hETjRrNGNYVUwvcW9EdndXMHRLOWs5?=
 =?utf-8?B?VUxKOVdlTGxuT1lIQzRiNmtwTmUzbXFIN3UxeCtYSlBDbmd5Q2dzK3ozYUs1?=
 =?utf-8?B?MFhJYTdrUkxaQldSUFNiMjVaczRodGY1ZGZiN1RHTDlyd1RVZHFmSDdQK0xG?=
 =?utf-8?B?czJ6MmQzaEdZZzErQUk4M3NKajlLZHFjTFNpTERTdEVtbm8zcmV0dEdVZSt1?=
 =?utf-8?B?cC91dXlkNjlib2dmY0ZXYUlkRHhlaGtrT3MyV2ZmdXo1TUpqWDVnY2VQL1U0?=
 =?utf-8?B?UGZMKytaVm9LTzZ0NXNyRHkvOWFkZkNUbzd0Q1JxSGhjVm5PZE85TmxqdlNR?=
 =?utf-8?B?UmxRbzlRdFJINlBubXl2NitQc25DcE9GRlU4N1NaNE53V1ZDV2ZYcmJzTndN?=
 =?utf-8?B?ZGY3QmRLVUJFOXBBbm44NEw5VnluNEFhY1J4VUN3Q1dnUjBkZE5hMGlhYzYw?=
 =?utf-8?B?am9QZU9DMGFtWkduNzQ5TUFWdzdpVWxwdXJjQXlJL3hGNEJuWFlKOWVXbE0x?=
 =?utf-8?B?TnFrTzN2L1VuT0RTMVhzSzY0UWs1OFRGSjNvRkVBaVZ6THBRclE0dlM1RGtG?=
 =?utf-8?B?SFM1cHd1R0pUZVNacTRqOFV4b3RQKzdzMGlBbUtZdElDQnpleldsZERNT0dZ?=
 =?utf-8?B?NUpYS1Y5NXRubVJvYmNNYlNjY2JjUENxUWZPODZSWDl5OHUzSFdxYzJ4OHBx?=
 =?utf-8?B?VnYyUUxVdnl2c3BDVkhiOVNYSXBkZW9uOHdJSmVEMEM5cDliZGZXRkcvT1Y2?=
 =?utf-8?B?RU9WUFpHQ2hTNTE5ZkZLUlhUTTlneVlreHZ2STFPQVk0aGcrN3piQlhEbW9K?=
 =?utf-8?B?MEY4aUNjQXFCalgrZG03N0J3MTBDc1lRVWZud0lneTVBbTdnS2IxNzlJZlpL?=
 =?utf-8?B?TTU1TGJmVFYyL1pDRkJMZ0xYUEpYYVJiWmRJYTNpbVpPUG0zbUJHbkxIOG4z?=
 =?utf-8?B?SURIUFFNTFNyS25FTmVkYVMxTU01K3BYdDFXTWxmTE9ucFZRV0luOVAyd0lF?=
 =?utf-8?B?and4UXhLeWxKNmxDUDdJMmY5WTUvaUpNRmlDaUlOUXMvZmhQWWd3QXp6VkhS?=
 =?utf-8?B?OFlnUkFOTmllR0tvVmRCZG9JVXZsV2VQaDZwa0tDWlUvYjRxcHJ5RTRRS0Zq?=
 =?utf-8?B?Zy9wQjhUYU5EdC9JQjNrNHJBamNBWXpjZUZrcWJLM0ZPY3pFVGtUbFEwUXRT?=
 =?utf-8?B?OVhlMHplSEhDK05PNFhqZ3ZUV1o0cmtIZ1NNRXpxSG0vRXlQZzcwOVI4RUsy?=
 =?utf-8?B?Z2VZTkk4dDBZUlhmWnFQQktja3dQRHAwUnFvWWFrblkwYWkvMFI4OVNFT3Ur?=
 =?utf-8?B?TUdwVzZnU1JFSHZ6YzZJMG8zT0hIbnhiNnhQeGtnd0w5Wi9XUVl0a2orTHRP?=
 =?utf-8?B?TnZtWGtKOGRSeEhQOHlQK09EelBMZG9rVWVvZlJXSmg0Y1oyK2xnYm13ZWV5?=
 =?utf-8?B?TklCY0xyRFEyTDc0d05PdkxiK3dWaTM0MitsOHlYT1BiTHh2Qyt3K3dxekl1?=
 =?utf-8?B?V3J2bDBta2hFY041c3I3Wmc1ZWlscyt3NklZb3p1T2gzdVRGblMwekNROWdP?=
 =?utf-8?Q?MI3j8U/209/YcHkAhucqJ9F9HwEdT7I4HiCtX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <211589D60484B644A927C60CC4AD0791@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GBni0JK17aiCoXpqMai3tfAJv0bNf2M125j2OPawvcJW7mkTbJsZ0vcYTmQJslOY3SM5XbWKZdhBii0ys8EL9mjFsJCvDpFvEKS8swEV9p81nZy/6FpzpptsL+tJGwO+oiDSS6SY8i2L6W0PtJAOKxMIROrfvqD/auSHaFW8Y7DOebobYicTMqnJW9YjBlwoeMvSfhB7tXU0RTT0L3h8qSuqrxPzV3ZfDGX2gIrYy0zQznsTHZt9RsaUblpEmxg5UIKXLzrRwbeiNoOtMamxYG3+8AsJUywYikjuY5eq6t5zXDMMH8meMBYyo/GA6laF2Jq56KBxrzxOGZwMrhXqPQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2cf08f-b9f7-4c41-8e34-08df29d99c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 09:57:52.1732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+F8GCzGbsNnMaU580141odFJkGdZtqgVldM8mdFbLhbcg8hUv4IQ3pVizE0Q39cBetOp1+lIZ1EUSq6aanZDWto/Bg36MrSgVpophHntfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR07MB12338

SGksDQoNClJldmlld2VkLWJ5OiBDbGVtZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGll
dS0tZHJpZkBidWxsLmNvbT4NCg0KT24gV2VkLCAyMDI2LTEwLTE0IGF0IDExOjA0ICswNTMwLCBT
YWlyYWogS29kaWxrYXIgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qg
b3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMg
ZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4g
DQo+IA0KPiBSZXR1cm4gWDg2SU9NTVVTdGF0ZSBkdXJpbmcgZ2V0X3g4Nl9pb21tdSBjYWxsYmFj
ay4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhaXJhaiBLb2RpbGthciA8W3NhcnVua29kQGFtZC5j
b21dKG1haWx0bzpzYXJ1bmtvZEBhbWQuY29tKT4gIA0KPiAtLS0gIA0KPiDCoGh3L2kzODYvaW50
ZWxfaW9tbXUuYyB8IDggKysrKysrKysgIA0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMgIA0KPiBpbmRleCA4MmMzYzNiMmMzNWYuLjkyYTJkNmVlYmI2MSAxMDA2
NDQgIA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMgIA0KPiArKysgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMgIA0KPiBAQCAtNTQ2MSw2ICs1NDYxLDEzIEBAIHN0YXRpYyBpbnQgdnRkX3By
aV9yZXF1ZXN0X3BhZ2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuLCAgDQo+
IMKgwqDCoMKgIHJldHVybiAwOyAgDQo+IMKgfQ0KPiANCj4gK3N0YXRpYyBpbnQgdnRkX2dldF94
ODZfaW9tbXUodm9pZCAqb3BhcXVlLCB2b2lkICoqeDg2X2lvbW11KSAgDQo+ICt7ICANCj4gK8Kg
wqDCoCBJbnRlbElPTU1VU3RhdGUgKnMgPSBvcGFxdWU7ICANCj4gK8KgwqDCoCAqeDg2X2lvbW11
ID0gWDg2X0lPTU1VX0RFVklDRShzKTsgIA0KPiArwqDCoMKgIHJldHVybiAwOyAgDQo+ICt9ICAN
Cj4gKyAgDQo+IMKgc3RhdGljIHZvaWQgdnRkX2luaXRfaW90bGJfbm90aWZpZXIoUENJQnVzICpi
dXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuLCAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJT01NVU5v
dGlmaWVyICpuLCBJT01NVU5vdGlmeSBmbiwgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqdXNl
cl9vcGFxdWUpICANCj4gQEAgLTU1MzUsNiArNTU0Miw3IEBAIHN0YXRpYyBQQ0lJT01NVU9wcyB2
dGRfaW9tbXVfb3BzID0geyAgDQo+IMKgwqDCoMKgIC5wcmlfdW5yZWdpc3Rlcl9ub3RpZmllciA9
IHZ0ZF9wcmlfdW5yZWdpc3Rlcl9ub3RpZmllciwgIA0KPiDCoMKgwqDCoCAucHJpX3JlcXVlc3Rf
cGFnZSA9IHZ0ZF9wcmlfcmVxdWVzdF9wYWdlLCAgDQo+IMKgwqDCoMKgIC5nZXRfdmlvbW11X2Zs
YWdzID0gdnRkX2dldF92aW9tbXVfZmxhZ3MsICANCj4gK8KgwqDCoCAuZ2V0X3g4Nl9pb21tdSA9
IHZ0ZF9nZXRfeDg2X2lvbW11LCAgDQo+IMKgfTsNCj4gDQo+IMKgc3RhdGljIGJvb2wgdnRkX2Rl
Y2lkZV9jb25maWcoSW50ZWxJT01NVVN0YXRlICpzLCBFcnJvciAqKmVycnApICANCj4gLS0gIA0K
PiAyLjM0LjENCj4g
