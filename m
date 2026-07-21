Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D651CAA6D;
	Tue, 21 Jul 2026 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.197.217.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655135; cv=fail; b=cvMsvivObJkEFEpGWETvW8RAwH/d0oQExnlVzcuchzVQEK2odAeBy6NgHH/7gTDPOQj9cwd4tUolZVulxOjN7Y+4fUrn6Rr/Hg2vPCK+Plz2ksd6QOLPRl5qNTEM18bFL0GYMIDxKaVVMV2jHIL3QgtVoe5QJGfTK/7G9I51DF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655135; c=relaxed/simple;
	bh=I8owfJR4EmyokoEUehSo4QedGWWTq99lcgEQdqA8eXM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=juMCkeI+Pn7OaszD6meKB6vzZ4XJkz4Q0ZHT3ewjzFsnXUriKh2m3rwFMmVpaooHrUfUg42PZ3K+LUIS59lhhVsBcCOpTkmydJqGGFTofpSrfQx4kNc5+BCWgOMMmhvjWycas/m2ytVcKBA5ekMw9Q6/NbswmFKKuyxZL5FUFoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=qVLGKRrQ; arc=fail smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="qVLGKRrQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1784655134; x=1816191134;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=I8owfJR4EmyokoEUehSo4QedGWWTq99lcgEQdqA8eXM=;
  b=qVLGKRrQaSrV480Iek7zGUggEFMMJTKDgTDJwDmaZgosl018pvIwZwgC
   XNpY7YKcANITE8YNx8yNgu6Y5Yjzz2KI1O5ywIdUDy8CjMHMldsWR+eng
   a3Lj/bJgVmhiExzcg4+B38TthjXG/g3hX+9aSyW9O7c8zPufZBg9Fld3g
   2T2ZxYqsg0OisMxy25Us2vYTZPncxunvRJu75gqK2DFs/feubzVhaVaQC
   RCSsRLX7v+/ryns0OZ2E5QcJj7+Km600ov4AmqSdIZytF79lOxECY9wx+
   qimgfK3IE9X1UdMjEGu8pI8OxtZ8M4yIhiu4t+dB+FXt1veLbL6qqf3Ru
   w==;
X-CSE-ConnectionGUID: Ro6394oiRYuuRs9BKMLE1g==
X-CSE-MsgGUID: WDidiveVQVuVvbYulhWkoA==
X-IronPort-AV: E=Sophos;i="6.25,177,1779148800"; 
   d="scan'208";a="16752712"
Subject: Re: [RFC PATCH 0/2] KVM: x86/pmu: Let userspace disable SW accounting of
 emulated instructions
Thread-Topic: [RFC PATCH 0/2] KVM: x86/pmu: Let userspace disable SW accounting of
 emulated instructions
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 17:32:09 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:14517]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.27.190:2525] with esmtp (Farcaster)
 id 3b170ca0-c024-44fe-a06b-5120f71feb51; Tue, 21 Jul 2026 17:32:09 +0000 (UTC)
X-Farcaster-Flow-ID: 3b170ca0-c024-44fe-a06b-5120f71feb51
Received: from EX19EXOEUB001.ant.amazon.com (10.252.51.80) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 21 Jul 2026 17:32:09 +0000
Received: from FR4P281CU032.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUB001.ant.amazon.com (10.252.51.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Tue, 21 Jul 2026 17:32:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIrpOyynnS9Rg3aXWfZ198C6M2i4w9b6X6sh6Wu0qGpr+CjjGRRo4kdn1nWKO8X1W6H60OhK4+aR/d4Vsqn+X9DIDCo6q1Q4Y2Mlpxe+0brfh25R+9fEE0HNBS5lRUaoKtT/cJvaaaBTXGmCLnf9kvjROALDBSK1EUbGxMMtFqRUmkTogXfQSa9y8NDTfVl6XZ5Vam94K2amffN10DcUNYUI9At95NW+z4wlaH0nOvWZjuapRmt0yiupzK1anJL/hxuV7ckxZGIEri5r3B0OGX5YQd+Y3LEIjlHFzdSRE7t4h36gGviyVBm4bI96fo3qFr0WKGdhxeFFh1HVvYhP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8owfJR4EmyokoEUehSo4QedGWWTq99lcgEQdqA8eXM=;
 b=QMWXy2KNas+0gF7RhyVXUJkf/3QaKSPmDstDN21+3VWTIJzL/InsWt9c9Q+WU4FPyb7Xp3bMKQUKupWwa/JJE9HLuIrBh6UvSvgv42Tr3GonchU7ZkrekZ4UjzQy4dyu8+8wAk+QJG9jCad9rjNJ3RtrdKLFx1s25UNDOL+hEvKXisbPswABnzgUElqpwR/j08lgYZDaUob0LVwU90hboBOHhu52h+5XsKYJAkw1Wm6VOpfAlIhvpy4r/ryqtHKMfhA7YYuO/rCc4orFC7yiXMuPf8RQiz/h0b0vqLRyDqF9+3Vs985uFZKHZ2XWcPoc4NLIji0O4swBvg6azHy9CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1bf::23)
 by FR0P281MB3132.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 17:32:06 +0000
Received: from FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1c27:e30e:1c73:ccd8]) by FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1c27:e30e:1c73:ccd8%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 17:32:06 +0000
From: "Absandze, Luka" <absandze@amazon.de>
To: Sean Christopherson <seanjc@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Graf (AWS),
 Alexander" <graf@amazon.de>
Thread-Index: AQHdGH0hOX7GBZykUkKReYpgCMrjP7Z3lSgAgACbLQCAAAxjAA==
Date: Tue, 21 Jul 2026 17:32:06 +0000
Message-ID: <al-szwXKRbdGYv49@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
References: <20260720192221.72912-1-absandze@amazon.de>
 <f5552576fc749b4b453514f52921332cc104c6a6.camel@infradead.org>
 <al-isty0nYjQEwqH@google.com>
In-Reply-To: <al-isty0nYjQEwqH@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR6P281MB5787:EE_|FR0P281MB3132:EE_
x-ms-office365-filtering-correlation-id: ab737f6f-9b6d-438e-c8cb-08dee74dfc51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Y8AOgBWJLPYGagVZ1uxOgcYWfM67oAzzfqXhM0QLo5jBjquwUQyrYUVP9esgIbkbyR2xIKkk1tdaD5ydrpdzVOIR4w8MrDviB4PISL+dCNKgoy7o3nyqu/1fLhDPA5sESDlHyhe+SapWrYA6x+F6Xp/pB7cZsF6uE7LOE7+c3Pael7tmZaO8RPFJ5grTupwOnMM9BR3w0/82A8sIREXdaADDuBOFE0Zn1iRTCVWpdkVy8s9MJjXUuEqojh2QtIA1Ytb9OAdUyM7L1fDd2JneX3qd1gw4eBGaDtgHdGbHVGD7iO0xb3/ClqJSL8fYmHyuTyMLqYeya+zb+3wuD5oAeEEyxVNnv+QZ2kLbFs1cPXYr72W062S+J0MIUCbjj4dVpLdoQhkTZt42CU2GCnvMWlfLMhYao9S+FJyjTbv2enOTqqHGsKLIPMxiC3nrXM1e1Ss970oVXkUhRm/yvuC9SFOjK5VX/18Pr6cnWzmisXp6sRF7nJYVhhEaX9aOAo3Dq8zRACA/4dBWzNxOuSWfu1QegHJ5UcMSw3VyxFC17e+ZJS9UL87xPR9x8pP5rj+D5BHPLkcLxttO83Z6TFhG8Prom/rpfRhg7UM8iwQof2Kg1wYfaKKK8GTFBL0tF7KvzUJso+tNHvNABat+AMeruZ3YGOLI/nr8X4yxtSUim2otzvMHxNcYEMJfjTK1jFTsUPT64SC4C7FpstvaCM1WgZQPSvvqAfHPstR+78d4zKw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDZPVm9HejNzN1A4bjNDdUpLSWk2QUpHclhtZVRDSVU4Wkh5Sk5sVHdxNnpy?=
 =?utf-8?B?NTRNeTRLaFI3UHo0L0c5bnhyUFJhUzVyeHlpc2JrSENQTytnQlVDQXd4U3lZ?=
 =?utf-8?B?cndldldtbi9SNkpLcG53dTczMTZxMHBaQjlva3YrMFJ5aUh6WGMrL0pNL0Zo?=
 =?utf-8?B?MG1MRUlFS2tCRHppMEFGenc1cm8vTFNMNzQ2UGRhc21pR2tRU3RZcW9CSlZZ?=
 =?utf-8?B?SVI4bFBHcVhZT0VrczNOdXZUTDV2NUJ6ZTBGWXB0YUdoVlExOVlqejVyRC9U?=
 =?utf-8?B?U09Xd05NYVBUL0hmU3A5N0dkbUk0SWdBMi9UV3dHcGJZVnc2L0liZmc1SjRZ?=
 =?utf-8?B?R3BuaDE1bW5zZXR4OXNGbE9SZVNud3lwb2dhUTQzbFhwcXllTUlKU2Y0ODkz?=
 =?utf-8?B?Mm80OGFRbmJ5SGtpVTg0OGppMzBaS0JKd1hKV2E3N3U1a2kzRGdpbFNpQmN2?=
 =?utf-8?B?WXQ3d0xIY1dGN0tEZDN1WWZFbG5RdXFSRnhGTEMvRXY5c3crNWprazVPd2hr?=
 =?utf-8?B?YTN2Y2MrMktNa2VQZHVoYkVVbzNFT0JzN2txL0NNL3U1dlZjZXE4czlLRjVZ?=
 =?utf-8?B?dU1JUElHTlhHZG9mb1J4YVBlc2d2L1Rwd3F5L2lGaXFuR1pGU2MwcWNldHY4?=
 =?utf-8?B?bVZqZTA4Ui9Melh4U1Z1UWtDWHJLNzhIcXI3STZ2Z0RObXp6RG5KeXh4MVBM?=
 =?utf-8?B?S3VoRmU0WXJzSENPNU9CMGo3UzYrOG9sL045Qk9GUFQ1YmE0ekIxS3FSME5Y?=
 =?utf-8?B?STdXU2N4Vk94NE5SSmliY2VPeWJyNm1sNmtOVlRDZTlTbW9mRWJNZFRvUlFl?=
 =?utf-8?B?VmdpUkFYeWpoVzU3T2lsTFQ1OERsOVp0elhoS1Z2TktBTVRXZVpBaFBrMENt?=
 =?utf-8?B?QmRiOGZyQWxuQTJoMEVxdEJVL1lvWXpqNW05R09IcnVtVlNQdVI3SXdkNkQ3?=
 =?utf-8?B?L0ZqN09YaHFPcWhoT3VsSmI2c05QNmR4SjFZNWpsbEdXamtrOHY1ZWVsUUo5?=
 =?utf-8?B?U3NoYTVEWUxab2R3eSsyMjRNdmJJdnNEc2VFWDFjSllXc3BhVmpQSEZkT3Jr?=
 =?utf-8?B?cEt6cVR2a09qK0NwMGgzd0hBbjN0bCtqRHpjSUR1aG9SV0JvZlllN05uN2Vl?=
 =?utf-8?B?Y1lkMG8vZjFWK2hjZko3ajBFUnlacDVad3pTdDVabTRXZlMyVkdxOEVOc2ov?=
 =?utf-8?B?WnhqbW1BMVNJbjFsNGpXcmFBdmRvTS9PQjV3RFFyUTFla3R0VW9lQXhRKzFG?=
 =?utf-8?B?UnM0V1lhTS9SWVY1djNKc2lKdHhyOXJWQ1hYYWJDd2tneE9vZExkbVNMYTc3?=
 =?utf-8?B?dnl5ZW5QVU5KVEVrejRtK2dsOENramdlcjRtYy9DMy9ESng1bzVSZEIrK3BK?=
 =?utf-8?B?QjJjOGZBKy9xajVDNUloeDB5cjdjejZZbnIvY0hyWGlzY2sxanBFRGVhL2dP?=
 =?utf-8?B?NVN3UGsySWYwNENyaTI0bjNGc25lczJ1cHhKSDE3LzNKS0ZiVDVyRU1EWS9h?=
 =?utf-8?B?M1gyYjZtNk9sbWJPdkhxS05JVHdlZVlsWTVBcFlTN2xQdyt1RHZjVDB0WHV1?=
 =?utf-8?B?Q0o4TEYwRDZIRUowY09GVGVzOWRUcVVSRWoxZGVzSmhOYlRsRFhqZGJuZHdB?=
 =?utf-8?B?MUUxREpTUnZrZVpiT2VPOVdVdHFSRFE1SVUyV0JhMzlIbHBXN3VmOTNRYUs5?=
 =?utf-8?B?Wnl4cHAxSEtJbzVOY0FSTGQ0aHpyWTZ6bU5RTC85QmI4YU5EOTMwZVZuUEc4?=
 =?utf-8?B?am5iNkNycEpXakhNUmZGRUNtSDJ5eENTNm9zMXpnNU9LR240UnVWeVJ6M3o3?=
 =?utf-8?B?M3dCenNleHlJSElESWFscEwrbm5tVnRXVHpJNkY2WGwxMVdXTWdWdmYvM3pM?=
 =?utf-8?B?Z3ByZUlSay9yVElFblJsZkRzQzg1a25aaEJXeTBnd05xZ29CMmhYZCtGT1NU?=
 =?utf-8?B?QTRPU3k0WUtCaGdDbDRCNlBoNDMwbjd1WDFKVUpaSzJ0U2NPUnBENkQrSDVY?=
 =?utf-8?B?c09xcFhWZVB2UWMzc2RYc1VJaGpTNEtrb3JJQjRPeEtYMzU5WXU3bEI1ZWVx?=
 =?utf-8?B?REFCeC9IZmc5VUZMYUVQeWNyY0Qyb0lxYjFQU2JVeTdncGM3Q2pYS2hTYVdQ?=
 =?utf-8?B?MVBsMVpqc0N3b1VlZWJKcnVSS0NlZmV3bEpKdkptN1dTdUdPVEZZNHdyN1dP?=
 =?utf-8?B?TUVvRDNkZ3NERXFnNEliVS9IYXdJeG94RDBSYjFybU5KYkJuWWNYcFM4a1E2?=
 =?utf-8?B?ZjVjL3JKcVRmaUJ5MEI0RDBRK1A3aGIvblhlUC9Hc2xFMTl2bE9lbTc4REJW?=
 =?utf-8?Q?BW/iB2SiSQ8+s08oaS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61C2B739B2586A4693473B1FE830AE23@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S3JE259bnVALyNhkFkvRXpPLqM/K/5DmomeF4vN7jvZfXMTcTAswNJ/x6dmOZYc6LoaUVajMl7q4mDk6lSz6sZQGR8hlkeN72oDzufrJZ+HRC1HCpFJ81+IKVQQuejPVOkQYBOJFor9fINwpSCdGmrMCV9VsZbm4b1vjfheciuFOrQNFlOyVQF9cOmhfhB/bvQOTVw7hPLyuQ5+fmgssGcddh0/pjEtlL0Q6GMmpV/p8t7bu1X6DOgK8O/g3oG6J1JWd/YZM+dMFFPcZPGZ/DnihXZd0AiqSE9rtUWxmr723B+NZRK+5Pq1HLsXt7aFD7FZc/hRCpMg+K719jJ8hTw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ab737f6f-9b6d-438e-c8cb-08dee74dfc51
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 17:32:06.4760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQaybnFw+QbIdt/RaWLpWR4rUDsb5pcFq4FbIbRMWwMM3T0VQP5fg5CL8vOofJab4jl9O15w07fUYFWUOGse5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB3132
X-OriginatorOrg: amazon.de

T24gMjAyNi0wNy0yMSAwOTo0NywgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gSG1tLCB5
ZWFoLCB0aGF0J2QgYmUgYmV0dGVyIHRoYW4gaWdub3JpbmcgZW11bGF0ZWQgaW5zdHJ1Y3Rpb24g
ZW50aXJlbHksIGFuZA0KPiB3b3VsZCBnaXZlIHVzZXJzcGFjZSBmYXIgYmV0dGVyIGNvbnRyb2wg
b3ZlciBob3cgc2hvZGR5IEtWTSdzIGVtdWxhdGlvbiBpcy4gIE9mZg0KPiB0aGUgY3VmZiwgdGhl
IGNoYW5nZSB3b3VsZCBiZSBmYWlybHkgdHJpdmlhbCB0b28/ICBFLmcuDQo+IA0KPiBkaWZmIC0t
Z2l0IGFyY2gveDg2L2t2bS9wbXUuYyBhcmNoL3g4Ni9rdm0vcG11LmMNCj4gaW5kZXggN2Y3Nzcw
NDlkMzI4Li5jNWY0MzZjNmY4M2YgMTAwNjQ0DQo+IC0tLSBhcmNoL3g4Ni9rdm0vcG11LmMNCj4g
KysrIGFyY2gveDg2L2t2bS9wbXUuYw0KPiBAQCAtMTA4NCw3ICsxMDg0LDggQEAgc3RhdGljIHZv
aWQga3ZtX3BtdV9pbmNyX2NvdW50ZXIoc3RydWN0IGt2bV9wbWMgKnBtYykNCj4gICAgICAgICAg
Ki8NCj4gICAgICAgICBpZiAoIWt2bV92Y3B1X2hhc19tZWRpYXRlZF9wbXUodmNwdSkpIHsNCj4g
ICAgICAgICAgICAgICAgIHBtYy0+ZW11bGF0ZWRfY291bnRlcisrOw0KPiAtICAgICAgICAgICAg
ICAga3ZtX3BtdV9yZXF1ZXN0X2NvdW50ZXJfcmVwcm9ncmFtKHBtYyk7DQo+ICsgICAgICAgICAg
ICAgICBpZiAocG1jLT5lbXVsYXRlZF9jb3VudGVyID4gcG11X3NvbWV0aGluZ19zb21ldGhpbmdf
dG9sZXJhbmNlKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBrdm1fcG11X3JlcXVlc3RfY291
bnRlcl9yZXByb2dyYW0ocG1jKTsNCj4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4gICAgICAg
ICB9DQoNCkkgYmVsaWV2ZSB0aGlzIGlzIGZpbmUsIGJ1dCBwZXJoYXBzIHRoZSB0b2xlcmFuY2Ug
aXRzZWxmIGNvdWxkIGJlIGEga25vYg0Kd2l0aCA8MCBtZWFuaW5nIG5vIHJlcHJvZ3JhbT8gV2hp
bGUgdGhlIGNvbnRlbnRpb24gb24gdGhpcyBwYXRoIHdpbGwgYmUNCm11Y2ggbG93ZXIsIHdlIGFy
ZSBzdGlsbCBpbnRyb2R1Y2luZyBtb3JlIHN0ZWFsIHRpbWUsIGFuZCB0aGUgYWRkZWQNCmFjY3Vy
YWN5IGlzIHByb2JhYmx5IG5vdCB3b3J0aCBldmVuIHRoYXQgZm9yIGd1ZXN0cyB3aG8gcmVhbGx5
IG9ubHkgY2FyZQ0KZm9yIHRoZSByYXRlIG9mIGNoYW5nZSwgcmF0aGVyIHRoYW4gZXhhY3QgaW5z
dHJ1Y3Rpb24gY291bnRzLg0KDQo=
