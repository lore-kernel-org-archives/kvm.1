Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022B48C3FA
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.197.217.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040614; cv=fail; b=O0JUPrqgLcD5TXXFY41HxGKbDKy6Swpc0SjQjSz2G5dnhN3X1p+hOM9MV+lt9fuwu2MtlMEp+DbcMXHe2HBpC0nFpEwH4ePhrnbdZA0kvqxL2bTOw/YfAXsbj1dfezx3WP54Jub+kPM3751SQGRqTsPlUTMAc9ZT1PfTpwfC7zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040614; c=relaxed/simple;
	bh=rlfFcH7Cgsh1Gw2ELXcmdZS2hvsJRvnLNeL5R+ghAwM=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:Date:Message-ID:
	 References:In-Reply-To:MIME-Version; b=E+s3tBVtgzyWBLZlLBALelA3Byabc2aEkYkU9ev+dbT/jTRANd3wNk4bUrrIIzwJ5KuPcpXMtvff8fJOREVW0WoP4/GTPQTcGbmcSUb5BHXBqIbknce07e7a3YNJxV+lsLJqq0fG5SZ9cGlH6vYgwfllJKvgdo93NLYpWFUcHYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=Ej8BRCU0; arc=fail smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="Ej8BRCU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1786040612; x=1817576612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to;
  bh=y/rIIMGlOBGbjRX+Hq0ujPngEyygOwALmZKyBl+sOXo=;
  b=Ej8BRCU0gEIuzoyjjSlRSW6ds3le2pTEXuhZFV/KgtyDg2CG+nRbHxhZ
   Eza0tr809IcnT9vXP3SPjeQ+elWgbInqvKD0By6eNLYDj+AJjpI7ENDFb
   aD2eFJcxcaW1UtyDCq4wAyDjcjyy1/NJZn22fNNz5u0a73O/+nbXxi3kX
   FaMdqXve01lKsk03IXurvv3CWJkrS+l70+c2ZJ1Cvr7ynWX2N0BXL9UQs
   iSM6VjqrMNPMfF5DqAf5aLeopEWSJIECUes/fBa94CbFWeG4nvVNWHxxu
   dQumHAPq6mQXv8wBVn3Aneu8IUZlrp8sl6hwuNdQ93a1BieiGwRVN7juY
   A==;
X-CSE-ConnectionGUID: r26CeXsxSBSgmrpQExat/A==
X-CSE-MsgGUID: q1785AMPQJemCHajH7lkeQ==
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="6.25,208,1779148800"; 
   d="p7s'346?scan'346,208,346";a="17497289"
Content-Type: multipart/mixed; boundary="===============6973239827117520350=="
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:23:28 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:31176]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.42.72:2525] with esmtp (Farcaster)
 id d3f26461-78a7-49ad-ab2a-35fff80b5571; Thu, 6 Aug 2026 18:23:27 +0000 (UTC)
X-Farcaster-Flow-ID: d3f26461-78a7-49ad-ab2a-35fff80b5571
Received: from EX19EXOEUC001.ant.amazon.com (10.252.51.133) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 6 Aug 2026 18:23:27 +0000
Received: from EX19EXOEUA001.ant.amazon.com (10.252.50.110) by
 EX19EXOEUC001.ant.amazon.com (10.252.51.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 6 Aug 2026 18:23:27 +0000
Received: from CWXP265CU010.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUA001.ant.amazon.com (10.252.50.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Thu, 6 Aug 2026 18:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgbM6Ll9dCeKeDg/C8NB/oipgE4rJ1aVpksVC7IuS59DFEK1hxLBggSWekK92BVUPeO9ulT09pZZNukdRDue+BBzl+JaBMPJ1mPo3ECaro6n19sZ05ktHp2dEgyaz9xg1GdqCnzsshD4z1rkXL7VaCvmp5MRDywRh1xrci6CfYpYIkx5tCZbodEiQ2i5nUv/dDArCPq5Bsl7S/L0vNYKqad7XyY3iSNhrvDswx4DdPKP1RpIXZnAM2m97lcs6RBjXjmlivl3ZcH/AyXcAcDHWfYH9hJvUdzj1NUy2Sp+o5vdDstbOqF7wxgUqJP/YlrfjjkiYovZuJ2f8dotwzCJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=5JS1eyfYUlSQmqeO+foDSgI+a4tUqZEl1cho4HaFdCI=;
 b=WTtFh1XMWjBwrgENeC3h9YxEtF6w9B0eED/F2QZd6b6xv9whjDoBtEwW0xcVmoypgB3BFBI053wEkPc5aRn3CDn3FJLMUJjjB3nDGdaGYtsx8tcEMeSG2seQCT4NgLMrhCcaHasivVE8uTl0oN+91ddK1z6tkgdqsgMhrmtUlCPzuhcuaUl57fnahttAnB57vsn8ogHVz1e6zRWTXbfJFJxejQ2+q9El4sL4BcJy65VTlzW0uHdlfOJTHhsIhHnGLkjW8LY0apdbVCP5yIDkGRiEhaHrd+VBStlv+gL3WbzT5D8+eV9lWuv2jDWckPuFUBLW7fF75+KGbA2R0o6bMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.co.uk; dmarc=pass action=none header.from=amazon.co.uk;
 dkim=pass header.d=amazon.co.uk; arc=none
Received: from LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4b4::12)
 by LNXP123MB3740.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:134::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 18:23:24 +0000
Received: from LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c7e3:476c:6170:8f6]) by LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c7e3:476c:6170:8f6%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 18:23:24 +0000
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: Sean Christopherson <seanjc@google.com>
CC: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Thread-Topic: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Thread-Index: AQHdJdCrg5jG6s4rOkiLbQUdqipaUg==
Date: Thu, 6 Aug 2026 18:23:24 +0000
Message-ID: <fcb509fdedad50b2c77752c97776baffe6465765.camel@amazon.co.uk>
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
x-ms-traffictypediagnostic: LOZP123MB8516:EE_|LNXP123MB3740:EE_
x-ms-office365-filtering-correlation-id: 059a94bd-231e-4579-9eca-08def3e7cd7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|6049299003|376014|366016|1800799024|38070700021|4053099003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: kpSk6LH2eWlqkMpJDJXnHd4xG6xaE+6Z3x7Bkz+oSuvlUF2VkV1FwkdC1mgsZb6Cmi820vQ6+JKAFuqTgWgaTNI3Ep+9hKtSiDk65WMVWNMTv1J/N3r6lgcJntTgMXtdQy2zhfq6t1etSNreKQRjE/n6Pv90+ahiM6P1IvISGf5sGGkSejnBpzFoEDP+dh1vx2E08U9fXHWsLYQtX/pE2FOq2ESsPJ28nOoiCnyYa5JylM8Pkq21b6hr0C1Y+iEjetJiwCExDvrHhea1c6tFWsZfy6qrUeszpj5Iz3fi2+TutGXW+7LZE155dTVB8lM8E8uRH74+ZPL82njJE6sI+azKbFE0Fkc2uOIRJjzOSBbJ/7gWcKMxVK39h9GmDkr1ejphhzMiGh5RIM4rpIcTd2BCmLOv3Nl7NiQ+ACf2hx0VeOFiITIIrW405Efus5r5VKATGuB615I3Emydfss+m9m8YiV6ijMoz80hHUniHhTCcGTzyevY7g3QVAcKO8aW0XLZrEmAo1i7ByUPH5raKWCXm5IvUDR9/mZWNEallqxenbz6PXS34qr//3rISbOonZ0LGC7Vf3Ct70cYe2unEUW9sssrEheYCVdfEGZ45ugVhYgkIT4OFJ3lIVQvjzssu270JkiN7RIP6TQ9q2QQkrZJb/mSMdATq1f7aRbnxoFsEI+ZQmsFGwLOIRzrdY5+tB8qDphviFFP5qidPDShDm8bSkuw/x6Zhn1VmtKNdWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(6049299003)(376014)(366016)(1800799024)(38070700021)(4053099003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXg4akRONTVicytHNlpoRzd0c08wQW1rKzlHaEkyck9wU2ZiZmd6dmdSaXBi?=
 =?utf-8?B?NE85ZzhzTUFLcmczTDB5RThsWXVodjVvdm9vSVR0SHQ4L2RndHg2MThyTCs2?=
 =?utf-8?B?MC9Kb3hRQ0hmOXQvaUV6T2pwQlVEdnVZU2tjTmJ2TkwrVG1wT2F5TUNkbjdQ?=
 =?utf-8?B?dE1LMitidVVtWG1hWElLUEtUM3hORk9sVlh4SVhhb2lPd0FvUkJmNS9pb294?=
 =?utf-8?B?RE1HNUhUblhlWUtCYzlmMGNwdFV6WmUySVpkY0NaaS9EbG9mR256QlByZDBG?=
 =?utf-8?B?R2JWZGQzS2JTZXZlN2hUbFVJaENHdGZ4dFFSR1NzVTJGOG1lZmtEdjF3c2NI?=
 =?utf-8?B?TTdXV0F0ck5rN1hDRlVNbUMxR04zUXZsTEFuNlJoUEZSZzI0OEZlbzQweXpt?=
 =?utf-8?B?MGVBVnNjUDBwWmZiNWZsbHc2ZlhRRjVPYWlnMGpPd3l6NWxsZHBydUNrT2ND?=
 =?utf-8?B?dkFLdUl4YjVSQTFKOTlZWGNUczFGQWMzcUx0UnhnbFdNazlMbkJJMnBvYzQv?=
 =?utf-8?B?MEp4WjNZUGtHNUx4OVNqS0NXVERDSmUydnkrdDArYWYwUXlvV2hHczNJMGVo?=
 =?utf-8?B?RFBUTUtwS2hIV0Fib0JObnliRUxneXRpZ0ttK1pUaldGN0ZNelFhWWJnaURH?=
 =?utf-8?B?TjYxTjlkT09OcW1xR2FoN0tLRWw3TnlaMGc2UTgzVm5oaEE2YWsxRklFQm9h?=
 =?utf-8?B?UUVBaWpxdEwwc0I5aEVMazdGYTB6Znd0YVFQUXRaUS9rdm9YUEhmd1VMM3Yx?=
 =?utf-8?B?MDBYWUdPY3JRblRqZVpVK2o1U21mNlFwbTFZMSthUXhwdnlvMDdrZHNMelpo?=
 =?utf-8?B?WnhaaklUZzJzMjBwZ1lmeVJFQzdxbE9Xd1BsUUpyNnZpWFVhSnZEOUFYaEpv?=
 =?utf-8?B?Y3p5Y2Z0STBvY0FaT1lFT1J2SGNNZko3a0IxeTNVS0RrNXZqTGlESUpUL0k1?=
 =?utf-8?B?Q2hDb0FOL3Mwb1ExSjFTQ0l3eVFqQmQ2UUxXQTMzOGFlMEt0RkxiL3FrZEdX?=
 =?utf-8?B?dnNZaXp6ZzVYV25UdVhWMVBxSFFkQUEwWVF3aC9rSEpQOGlXeFFSOEVRNHQv?=
 =?utf-8?B?M1kvd3I0QmUyMTcwZExoN1c1ZURORE4zc0lBMlNYTk83azNDMm1JN0RGN0U4?=
 =?utf-8?B?SzhSNEdoUTFRTnVsWXU2QWJHWnA0MUNuc21DL1loRUVCUFhIN1dBcVo0UHVB?=
 =?utf-8?B?S1o1aUhCUUhHN1BEVGkwZmY4VkFZRjNCR05vdENaVFB0NUlOdHlyalJXZ01E?=
 =?utf-8?B?c1lrYnd2QkE5Q0hXbTZEdDdEYm16NmhHVFlKaDBYaEhRTWJqdXN4THVBMW14?=
 =?utf-8?B?MlliN1RYeGR6N3FxbW9xNnJsY3lQaytZeGNJOFZLeSsyRDA2T1o5TXV5d2kz?=
 =?utf-8?B?UzFGbXA5KzErZm9FK1FqOEE3R2JPVldxNUhqeUlGNXkyMVB5Sk9CRG5FREFx?=
 =?utf-8?B?MWtzeHpjVGcySHAvK0lyb0w1MjBUWnJydEhNQnZSWmNlclV3bHZyY3ppbUhy?=
 =?utf-8?B?TlZKd1RGazVXaGZ4OTFLNXU4Q2I2WGErc2d2RFFSU1JlSjliOVRJSXlFZGwy?=
 =?utf-8?B?TERVR2NyWWFvOEJScU50dlkySTNpd1F0cGNZbXlmVkdTdEdoVjB4TGJldVNF?=
 =?utf-8?B?aTFYSnJXN3VnbUVuMlFEYnpUbTI3UjZsZXUvWWl4Q2hESmIvcEttSDQvZFNo?=
 =?utf-8?B?V2c1TGkxYTBGcnRiTFdlZ3lXYlZjY2NJZk1WckxaLzc0aDB0Wm1EenFTK2FE?=
 =?utf-8?B?Mm0xUnFvb05xRHJVQVhzZlFJYjdWM2JhSFV2T05MK2MvTS82MVhvN0QxQnJu?=
 =?utf-8?B?MmpSejZXTUh6a0F0WlBuV1VmSDg2cEdWVkRYLzBib3NGZmw2OUp1R2ozWFc4?=
 =?utf-8?B?cVdLZEFBWkNBYjNiOHVwVzBhV2pXYzZBQm5uNlVTV3R1NDdqNVlDa0JzZkhF?=
 =?utf-8?B?elpjTTdZeXFEb0wvYUpVdm9TWWhZaDR5S2NjZWhZSk5DOVNxdksvNndpS0VJ?=
 =?utf-8?B?akRPK01BWm4zMlNJUjhWOFVCZDBMTW0yK21zUERBY1Y5OW1pVlNLU2lvWndh?=
 =?utf-8?B?KzMyc3g5VklpRTZpUGpqeisrSzNKc081dzJ2LzVCRnQzWnlDcEowSkVxa2dR?=
 =?utf-8?B?V0pFT256RWlHSU8zdlNvVW9XY1BqY0NaNlVWUVY4OHFCbHBRL2F2R0tSR3hr?=
 =?utf-8?B?SGsxMXBOdU9XS28vVFBadjVITmNUQU92Z3NDYTRWVXpMdllHeFJvWWV6Rkpu?=
 =?utf-8?B?NVZWdzlhbUVJVi80dEo4NGVTY3o2UTh1ZDhvWDNCcXdIUDE3L1JVY01TbVhy?=
 =?utf-8?Q?NtJ3ujQZ8OuVKuvEZ6?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qEDXhP6sO3fDXJRXadt1WEfz2vfjkr33UEmPBhVTH1+mD3i9l07Hn+ZuLlWRxOx+zpxR85Y86lgL1Javtr+Ov08uGXLmsopx0WK+aP+H6eBFSoJEESmrIHGHOD6+CPViM8dGCbon4DwUVDdNepDNoFzwjrkCLg8gzyvjbCxuzMclczMwoZOWIAuijFP91GgSU9ry5ceS2a5wW/j7pdYnM+BU0zLkJXb+aUVZ4ZRyRgHyUQwvJnk57B42yO2t8UivlyIFK9uSXtiGbLKK+1YKDbqFUhW4zewaxZjJuD7ZFfHbOSdChaK33EA6k3A9Yiz7i0DQNAJCcZfsLBvV3WsvnQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 059a94bd-231e-4579-9eca-08def3e7cd7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 18:23:24.3542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYhT2GddF4hWqxCnboJLwLSRLbetgiLDdIKVcvzuFqlTyHjAK/gkpp8U4p4cKeyI48Jfmxnt4K5kHfATxrt2iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP123MB3740
X-OriginatorOrg: amazon.co.uk

--===============6973239827117520350==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-eXcyFMn8Iqnacmbv1R8q"

--=-eXcyFMn8Iqnacmbv1R8q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-06 at 11:11 -0700, Sean Christopherson wrote:
>=20
> It's probably a slow path for all current users, but it definitely won't =
be a slow
> path for nested virtualization, because a refresh() will be required any =
time the
> GPA changes, i.e. any time the vCPU runs a different vmc{b,c}12.=C2=A0=C2=
=A0

Those need caching anyway, FWIW. We need a pool of nested contexts
(including these GPCs), rather than throwing them away each some the L1
switches to a different L2.

> That's why I think we should treat GPCs that are strictly bound to a
> vCPU differently.

Yes. I wonder if it's reasonable to tie it to the GUEST_USES_PFN case;
they aren't *perfectly* correlated (maybe the steal one could be
considered to be in your category too)... but perhaps those are the
ones that *care*?=20

--=-eXcyFMn8Iqnacmbv1R8q
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
MDAwWhcNMjYxMjE1MjM1OTU5WjAiMSAwHgYJKoZIhvcNAQkBFhFkd213QGFtYXpvbi5jby51azCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANhjs6T4tJ0lcw4+6sawEn2FowmhunUBsnSV
ccB+aA7s3Zd9PZV46CU6phAlCWpKk1yFVcD1Rnc4ux17o4LbUgFXiKrORS0jiF/5Oa0rXG3FISG1
Xdjt8oPKIq+9Z1s2e7Ipi5WWj4AG/xlkH/YMMctL9O8CCRHSrhiChbE/gR57x9PAnt5aeZZ2YWza
GOOeceaZe+u6vHCHITRmknSAnAX/aNoNJNsQCGcfrE83y9iHmP8BFrSRZqajBKlKq8tyJd5FnSwP
H3kSUcQlHOwiIfCRFXP4rpXSZ7nKOEZr3SXH06ADY9gZtrSpwBbuzKWDPGWMRuRnz8ogj/Y6DeU4
2zB/ZAIi5b0BzWf4u0rBEQD5xtpOCxYHc2nXQaFSWu36kP1JaNqElE51OQ92EyVKfW3N6qZcKiBr
VijXY2EtR+/5W9ixRFnEs4nIeb94Sf92UMEeG9ew2yVvcYXXNPaicGnrkESNC19/a8YXxQEZfrmB
eAPT9viQJhn3O+sD4pP0Ss3SjVZc6EO7vfoP07bt2n9YE08XSPkxcyb1J/4t/+AskkKeYFBGdpjg
xd+iLFxjSwBytZuh3+7DuHUfg876WA44ieQDrhHSjuvuAZ1Wb8WUsrpzrcLoYjqFmb/bf6/yyoxl
t31mdgPC+FLc+Yu1BQwXC3JMbrvbFBVTtn5X2EKDAgMBAAGjggHQMIIBzDAfBgNVHSMEGDAWgBQJ
wPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUWvtA1XsSV8xjgfFQL/DUTNIbJu4wDgYDVR0P
AQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwEwYDVR0lBAwwCgYIKwYBBQUHAwQwUAYDVR0gBEkwRzA6
BgwrBgEEAbIxAQIBCgIwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly9zZWN0aWdvLmNvbS9TTUlNRUNQ
UzAJBgdngQwBBQEDMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2Vj
dGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUF
BwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xp
ZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDov
L29jc3Auc2VjdGlnby5jb20wHAYDVR0RBBUwE4ERZHdtd0BhbWF6b24uY28udWswDQYJKoZIhvcN
AQELBQADggEBAED6T+rfP2XPdLfHoCd5n1iGIcYauWfPHRdZN2Tw7a7NEXIkm2yZNizOSpp3NrMi
WOBN13XgqnYLsqdpxJhbjwKczKX50/qfhhkOHtrQ0GRkucybK447Aaul80cZT8T3WG9U9dhl3Ct/
MuyKBWQg3MYlbUT6u4kC9Pk8rd+cR14ttYRUWDKTS2BrL7e8jpNmtCoEakDkMY4MrpoMwM1f4ANV
qZ8cnDntwXq5ormZIksN2DqxsKLmrFyVAONhqSST72ImBfIVWhFRTCF9tTcI5wE/0Skl25FZmSsB
B2LUgecgK7MZyw9Do/b0sYS+8YmA/ujUCqNb0fPJBE/B9vBomhsxggNCMIIDPgIBATCBqzCBljEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQVCu794mRTsHF5LtPqxYqZjANBglg
hkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2
MDgwNjE4MjMzNVowLwYJKoZIhvcNAQkEMSIEIO80PyHaF8tR+jwfZjGOXyBU2nsT2/XcPqaD0MAv
Tq8NMA0GCSqGSIb3DQEBAQUABIICACCRe5S7wRlhiERVD7slkc3vF67WXKXgMsVViDCZKsl77HKh
8eWb3xqRYPLHjQgLZ1UDcuhDwk7Nxqu9GbwN3RuSVEpqEMr7v+wjmp6nIMiFxDJ+2419V+71Ot0Q
oPZaoWLCi7NIuVyzZkPY7Xk9EWHlzdnUhtTNgkbhOA03ZHsxTL81qN0U2P7Z/KPU5BZy/qGXTYhv
mVrLDrrhxPWy9cwNuh3iLIwjUnKvXaLShQjqByNjFyL5G+/1YyEgUAols88+DBMJNuhm1ZA8SLhG
Q4CqMn1IoelsvmRaFHQKB9LEdMsusj4NfCsoHAOnFkD40xxW0gcp1fgeJ6oUDTab+gHE4o4qNShM
uZSFzQO5jGF/mjzhvO/ehvCw7yeZz8yY3Yzh31EvrGmQFPQufhfMa5uWwX5llrNLig+dxeby3mU/
gkDAKcmf5zxXo5nMCofTrCBgUcyCM+hqMQLr7qj7QKP6xKcu+uOslNb0olRGw/uSEhuk5yYLNaah
hfZWPSJO//C72t9apD3N1cGojfJbZ/V1xhpg+XVcDZfghcPxc6voeAXc4t2Fo611zHO9ZcZ1Bqv0
x3PiR028MqZlc/CHd7ClNx6JAVcvGqK4uYGrvHOu9HG+xAIyHyNySvQJGV48XtE7lm570TRD3jZL
99J4TEh6QWsJz+//xv5mrBnoKlTPAAAAAAAA

--=-eXcyFMn8Iqnacmbv1R8q--

--===============6973239827117520350==
Content-Type: multipart/alternative; boundary="===============1394568919776358284=="
MIME-Version: 1.0
Content-Disposition: inline

--===============1394568919776358284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Development Centre (London) Ltd. Registered in England and Wales wit=
h registration number 04543232 with its registered office at 1 Principal Pl=
ace, Worship Street, London EC2A 2FA, United Kingdom.



--===============1394568919776358284==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Development Centre (London) Ltd.Registered in England an=
d Wales with registration number 04543232 with its registered office at 1 P=
rincipal Place, Worship Street, London EC2A 2FA, United Kingdom.<br><br><br>

--===============1394568919776358284==--
--===============6973239827117520350==--
