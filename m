Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB8485CD2
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=63.178.132.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039150; cv=fail; b=LWMuNTZMf+Pz11F1W7fQrsfFfQRq4vIAcIDAmv4xIeAe344057u6c1qB5DZrB+p+hPk7NH530gsvN4f9obE3AZYK4AjZvqea0VoQYuZb3wMWb4A6plp1Ojo81pZJYtKfLOjewxFZu9eKpJxISfe3XHZGy72EWnGpI6T5meX92Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039150; c=relaxed/simple;
	bh=ziw3bIsgnVvsBD5TYOzWGnV7a/e7pS1iabI7PUfWrw0=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:Date:Message-ID:
	 References:In-Reply-To:MIME-Version; b=DRDstngR6l1Rxt5B1CmeX+9BDiYxbR/CaxiOAG5QjtBKwOJjT4ocUdIf6HBUzGO+GhryICTN7GUP4oh5g59OF9qZdp3fr24V2h1juGz+aZtQdqfijCzR4RBI9LsHVjjbJAbadKN0U/CGLqoFaz+irAx7iZy2bycLNGXuYRlSNfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=PxSa5wne; arc=fail smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="PxSa5wne"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1786039148; x=1817575148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to;
  bh=yy6RBcDVv5OeG3I1sS0XwNcVhIgbwGmA38T8ieGh5Pk=;
  b=PxSa5wne07vY7buNdW8DlyqGGCMqiLiMSIA587of0Dr/N1A5XRJhcl7A
   oj0bPCxwoS5qPL1+XFyqN/5EOTOG+2AEWHvrnM7vpj031aAc4DlsZuIZ4
   fPS7Lv3yGYHVQ9j4d+Jfghg2D9OLZhH/q2ompq5grZ1giux9NV98Tborh
   b7jAEClNzq1TdTrGiVgiyu0/i7zihFvgbsY8Z3CJhUTIk2HA3EB6BCTwM
   9D5V5yq2ubxMVfk9WxxptjbmvR2k3HW3ydBVyYK1Xk5tAf189wYjeW0aV
   fRtwG1hi7R+d+94JcZSTK9HLXu88vA+9E5MRgWDgvMfp0nVoDh2ij11Te
   w==;
X-CSE-ConnectionGUID: LxltNpm7Qa+R7LFpKq9ekg==
X-CSE-MsgGUID: /KolGWvITxKAkU8OlV/zfA==
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="6.25,208,1779148800"; 
   d="p7s'346?scan'346,208,346";a="17393374"
Content-Type: multipart/mixed; boundary="===============7179968743903116551=="
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 17:59:04 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:4134]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.26.8:2525] with esmtp (Farcaster)
 id aa3dd791-d567-4eca-9132-1747e3654b6c; Thu, 6 Aug 2026 17:59:03 +0000 (UTC)
X-Farcaster-Flow-ID: aa3dd791-d567-4eca-9132-1747e3654b6c
Received: from EX19EXOEUC002.ant.amazon.com (10.252.51.145) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 6 Aug 2026 17:59:03 +0000
Received: from EX19EXOEUB002.ant.amazon.com (10.252.51.83) by
 EX19EXOEUC002.ant.amazon.com (10.252.51.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 6 Aug 2026 17:59:03 +0000
Received: from LO2P265CU024.outbound.protection.outlook.com (10.252.51.199) by
 EX19EXOEUB002.ant.amazon.com (10.252.51.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Thu, 6 Aug 2026 17:59:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMiwpmWHdjNw/1i+MAPauMJJwitBUAgTpeG1Qsl6vDBACIap4oZKrw2CorYHhE/rcBiUvVa7hgYyvZzDmgMMyY1GovllLZj3t5aHRo02VNxt9I9mnLEFB90uZ03uZGCV/0T+nqt6iYdbINUdIRxIFrHqeinAuvxyB/1GclHew5HbT+3UFSp1FBNHQoinDxyo4s5lY6veJFWyScqWvc99xbiFY4hseW0SEyxL86MvzPB9MOR7jddzZCTFD+2VoGPM3/H0/0V3rCEx1w8K1841x1KLyLo5GC0bSOeAKDrlIubKaal3g7wLny8//WSLQynsr+MFMC+9TdltzSDTtX977A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=3id8wdXL28Avvw4x7JZwhwV47/LvVfiq982Ao1M5q0k=;
 b=Vi2EJFcPdRAu6C4P1fIjHRTl/VGmzFFjvpX6gf369eE0HRhdcl1dLkU8ZU9u/wJpSg3MMfSPAoVwRdXeWq/PYuqFF88xvxRztAIoJfAKGgkIIXFVnI6cawY2NJiuV6uhexllNv24O9/UR/pRO0GwLSbddQ/jsnlUvm45eMm+pQpWAuhmppzvWrwNcqYwUcUc+TQJm14t6hD6hR/ajU66K0KqRk93a7wqClBRGtUd1JnBXZbMlguH3BIL8WEMqPB+JMgTWzMXRsl/eTgtdeOaaq5JWLz4R894ORVYvfWSF5DkoKLfUM7LTnm3J5guCttoIzCfQuh2CUnxMr+vpzkqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.co.uk; dmarc=pass action=none header.from=amazon.co.uk;
 dkim=pass header.d=amazon.co.uk; arc=none
Received: from LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4b4::12)
 by LOBP123MB8098.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 17:58:59 +0000
Received: from LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c7e3:476c:6170:8f6]) by LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c7e3:476c:6170:8f6%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 17:58:58 +0000
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: Sean Christopherson <seanjc@google.com>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Thread-Topic: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Thread-Index: AQHdJc1BO6/Owx/oUkKCeurdLj16Uw==
Date: Thu, 6 Aug 2026 17:58:58 +0000
Message-ID: <bbb2ad42d2ee3b2c20cfc31c3d58a9fecebb77e4.camel@amazon.co.uk>
References: <20260805195528.3853473-1-dwmw@amazon.co.uk>
	 <20260805195528.3853473-4-dwmw@amazon.co.uk>
	 <20260805203608.D3CA61F000E9@smtp.kernel.org> <anS8C4Cxqy6ehCo3@google.com>
In-Reply-To: <anS8C4Cxqy6ehCo3@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.co.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOZP123MB8516:EE_|LOBP123MB8098:EE_
x-ms-office365-filtering-correlation-id: 4c717553-3683-4984-ba12-08def3e463f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|376014|366016|1800799024|23010399003|4053099003|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: zPV7t9JdmjOwfMKxm/CndZhd9nravQrSlPXzE9cK9tGQr7TjCxyEZ8m8cDIl5YlGQkXzYEKJpyEUKDVF9Mh4rXRj8Wb5Lr9LKfVHTDAOu5WI0jb1H2fpRYR2N0WobwBSNuROgUaiM3Es5zi0hEQI5r5mtRrPIn7wdMVNPJmz2i9VuI3bm3EjChYFvEBpODTF9fjlqc9j1lmucMUM7EwmoHF1jr5n358qRwafqkPK8+Y1h0+woJJHWwnmwcZWBjcCq3CEPQooBvlr393oDA63t6gAep/lvHudt8u9BDPda0IwJd5QtjOVJwD0AUC3WYYjLh5c4bwaDM1c5DZ7Pux5G8m3bVP/AkAPVTybIsNx4Q8wtyxzLEDiPEktdowe00sWAoyR3gQnhvSpjSCTxV4Bryf5pQPyJ/WV40kLRdmJe3O0RVgSbBOn1I4z5QJTJNMQAsAMXT67RapjNrz3BYppOE32fDbAPA6suS4pqH4PvLW87w6Ae+yyK98esa4uQnB0/zEyKfdJFaFtqnxfDpNHdLXMKJbFfUNcCQiTohA8sKWGn+ebHUdQxCPs07+5YOV/y03WKjCHa2bXbW5+Tpqz3FMpQSmc/gBIAwg01BT2aGUp1aumGFw3kCTBgp8etgNszAMQHop47nY6zeMTqjrzu6g3SbmEYXItFjcWs+EilwewnDWocCRYg1cP0KieqehgjDQWa5fEJTGgVy4xN+Atf3dkQXKuzn07yKB7ckuAIMc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(376014)(366016)(1800799024)(23010399003)(4053099003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGdNWk9XRVJCZTgyZXBDWklHN3BHaFNkWmlZMXdSQkxldUlkV3ZHQzdHL21C?=
 =?utf-8?B?RGlkWWtFc2pvWjZ3R3hNMXYyQVBQMlVHckU2NkRzK0JTZzVtUXYrRVBzVHVD?=
 =?utf-8?B?d2tDbzMxNXhad09lbXRvMGlXL0p5MHNtWlo2VGFiWVpwTzN5ZjZGVTlHS1R6?=
 =?utf-8?B?UDRQRjl5QXBSYWdET2hiOCszaHQ4V005eDlLcVNYM0VqNkk0NGFhdkE5MVVR?=
 =?utf-8?B?VENSN1ZDVWJRdW94ZHROb2JoR1h2NWdnY1Zpd0NaWjR4MmNLcWFEWGtuVkMx?=
 =?utf-8?B?NUpQajhPOE11a2l0dlUvRkRBVnp3SUNRWHh2UkhqeW93Y0szK3RuNzdSSFBO?=
 =?utf-8?B?cFNibk5RL2VSLzZMbitUS2VMc2xUUjhteng0WnV6TE5RcnYyOVFielFXdXFy?=
 =?utf-8?B?Rnh6UFBRM3gwRVMycXhLVGQ2RUlkNEg1aEh3WnlQL1VMWllEck5DWjhvYkt2?=
 =?utf-8?B?WmhiZHdUdXE0ajdTdGk0OFJpa1JKK09oSzhuWHMxbWRwS1pJL0F3RDVvd2lF?=
 =?utf-8?B?aFVIRzJmOTFxQnZVZnJiSThnc1JsK3BwT2dram1vWWJhVmlDOEY4eDc1Mis2?=
 =?utf-8?B?NzBEVW51aEFmSHFuWlBVdmNhWktESjhKZk1FQytYbU96YjBJYlBrMFU0eWJ2?=
 =?utf-8?B?NUI1bEJYQUR6NS8xTFBiVmFNMVF1OXdNME9LaG5xWE1qU3lYVjdkaGZOOGx2?=
 =?utf-8?B?Q05rWEFCZUF4cjhYTGVBbXNpa3FoOXRSZFFDbjVoRjZZMzZGK1pBQUhieHYw?=
 =?utf-8?B?eVJrRTNNVFVyVVZYSFdFcUFyc3lNK3N1UEJSSjA1T29OWGtPd1FUQ3lxNkQ2?=
 =?utf-8?B?VjF5V3VpOC96V3JmcnIxZU01M0MxbHFTZkY1dG41NUhydFBBNC9DSzFveklz?=
 =?utf-8?B?bjhPcW85UXBycmRCNnJxc3ZkUDFycnBqQW5rR2dPOWRXYWZtT0s0ZDhSdTlT?=
 =?utf-8?B?V0xxR2RTazA5a3lUeXVmdGE2VU1RMnZvUTN5UmFXUG9DcHcxYU9LL01MQ2pn?=
 =?utf-8?B?K1hJRU9iVnIxL3llbVlpQ2psOENmZ0JYa0JPdk83dmFQRSsrOHFyL3MvbXpr?=
 =?utf-8?B?TEJJY0swTHJuU1JZMXBQOHRnYzNMTHBHaTlrbDltT0ZRaDQ0THdkQUlLU2Uz?=
 =?utf-8?B?UzF4UUdBNCsxaHVpd3RXN3JqbzNUSmJ4bWZ4bjh6c3REWlhpd05YUW1yYXhy?=
 =?utf-8?B?MTJpMHdJOFlYeGZxeXVyTk50T0lGQWJDYjBnSzFiYjBGSWowakw0aG9GMVVq?=
 =?utf-8?B?ZFMzMnk5aUhHcVludXVuVWRxdk8zWGVNWHZDL1JqMUJULzlIa2NoUUlEdHIr?=
 =?utf-8?B?UGVBNmJkS0ErWlI0Ym5TS0dTbWZySjd0cXplTUNoU2R4a2JxSUFzeFA2Q0JH?=
 =?utf-8?B?aDh1dzhMaGx6MGxNa0p3STZZYU5WVllTcDk5aTM2bGpoYnliOUZOY0dqZWhr?=
 =?utf-8?B?VlplRy8vcG1LN3lEalBMVDZQcW82R0F4UEY2RTIxKythNkpSaUdBRlk3cysr?=
 =?utf-8?B?aUF0Mys3eFljQWVVTnVwbUxoQ2tKTDJ4Z1lVS1lmRGU1MXNyY1JIZkMvWHd1?=
 =?utf-8?B?WGlocXpudjNSTWoyb1FDbTZlRGZ4NlpPLzhYWFV4QXFmWFFZWVRZRkoxVU02?=
 =?utf-8?B?U0xUaVAvRFgvQnNubmo1N0EzQ3ZFNklEWDl4U0wxWWQyKzgwVThsS1YyU04v?=
 =?utf-8?B?RlZjc3NDT1BJRUg0UFlHUS9IZzhPUkNMbHZDMkhRUUdkNXZOYldlaFd5eFNj?=
 =?utf-8?B?NmRSQ3UrcnJNQTZjMWo3TTNmRUpRdm1Ka0JhdTdzUUNrV2RvcHh5b0pkTGpT?=
 =?utf-8?B?eU5IbXZmdmRtZXdxY3V3ejlQSDY5cjdYcXRNNW0vdVVEMHBid24reUhUQlFZ?=
 =?utf-8?B?R3hMcm5IcE1pTm0vcTljK0lTNVppUWlLN2lIMTQyQnVQdjVORjBYUUlKbnl5?=
 =?utf-8?B?SnFzTVhBSDkrSmRPZVRpQ2pqM0E3b2M2ellQVUpJZEVrd1k2Um9pQTkwNHdn?=
 =?utf-8?B?TnNQbkRyV0l6ODFCZ0lTaHlEMjlFVmJxV0VLTjUzeTkyRHY3OGFzcWUzdnJk?=
 =?utf-8?B?SERua2xOS0FkQnBUNFRuY25EU3VmbFF1TDBCckIzbzNXeDNsWG5ya1lHVmZn?=
 =?utf-8?B?TmR3bmRCWjhGZC9mNXI4WWdhdWVJbGpvMDlLQVJvcEZVbVh0UUlJZENMY1NQ?=
 =?utf-8?B?TVRiL0JRd0VRd0d6ZS9DbUhzQmhmZHBvdlcvVUoxRUVHVndKc3dYOVdlcEd3?=
 =?utf-8?B?OXRMVE9tbEx1UnZCcU5VQmR6R09CbEd0QlIwWkR3b3oxVnNPTUFVUGY0ZWNr?=
 =?utf-8?Q?NoU/9C282hIJXMRYHl?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AB+JWw+Kp+mPl1XN9kgEWM+h5c1L0JYJBCgpZ79+0LZbNRcdyDZrV4Kdaabip/f3qSPSGUPamEfjcJnheXh3ZSz7HRv9686Bwhfa66vCEewC47vSe56cTIAQmWm4TM8xyUz84kQEWXTzSrF1dNkrC58McBmMrzRsBurKzFqbDRr9diYbKzlOGWYnISGqwOlFFuRBM/KIX8f0sxocmibrVVKkCz85SUCDT8dP1NJZ7iEiWlR5EiXkGODPVm8p4dVAsg8MV1XSaLMeaBVqO/OK1/qozIKFbPOltAxOD65UJjJ7+eAK/yivMxPBgqIiEkFgmKt5ovvEnEfTiw9jXr21xw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c717553-3683-4984-ba12-08def3e463f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 17:58:58.7598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpXvC9OmzUeA3jvKRLANCJSD5VyWXsNvEdPZmDNFiWcpsfhRyjGcbE1tbCcheaVXRJ1TRh5vxAHWDpeJcpfFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8098
X-OriginatorOrg: amazon.co.uk

--===============7179968743903116551==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-CrsqKOLrx1Mdwq2dc2TC"

--=-CrsqKOLrx1Mdwq2dc2TC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-06 at 09:53 -0700, Sean Christopherson wrote:
> On Wed, Aug 05, 2026, sashiko-bot@kernel.org=C2=A0wrote:
> > Replace the per-cache rwlock with RCU for the read side.
>=20
> I don't hate the idea, but I am very against using RCU.=C2=A0 Unless it's=
 "impossible",
> e.g. because synchronize_srcu() allocates memory and breaks OOM kill, I w=
ould
> strongly prefer to use SRCU, probably with a dedicated kvm->gpc_srcu, so =
that
> synchronization doesn't need to wait on all CPUs in the system.=C2=A0 The=
 tail latencies
> for synchronize_rcu() are horrendous, especially for many-CPU systems.=C2=
=A0 If it
> were only mmu_notifiers that got hit, it miiiight be acceptable, but sinc=
e this
> will affect vCPU tasks in the refresh() path as well, normal RCU is prett=
y much
> a non-starter.

Yeah, the refresh() path got pretty slow in my first attempt, before
optimising that *not* to have a grace period if the memslot generation
changed but the actual GPA=E2=86=92uHVA (and memslot) don't *change*.

> Even SRCU could be problematic: if synchronize_srcu_expedited() is forced=
 to wait,
> the wait time can easily get to 20+ milliseconds, which again is a non-st=
arter for
> things like steal-time updates and nVMX pages.

But we don't have to synchronize from the read side. The code path
which will do so most often is gfn_to_pfn_cache_invalidate_start(). And
the refresh() path which is already the fallback slow path which can
sleep. Although in my tree I've optimised that *not* to incur a grace
period when it's avoidable, as noted above.

I'm more concerned by the fact that srcu_gp_end() might have to
*allocate*, while the OOM reaper path waits for it. I'll see how we can
deal with that...

--=-CrsqKOLrx1Mdwq2dc2TC
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
GIWwm7TwAv8gfJMdBEyMQWtSnPQFAAAAAAAA

--=-CrsqKOLrx1Mdwq2dc2TC--

--===============7179968743903116551==
Content-Type: multipart/alternative; boundary="===============2336113832687118290=="
MIME-Version: 1.0
Content-Disposition: inline

--===============2336113832687118290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Development Centre (London) Ltd. Registered in England and Wales wit=
h registration number 04543232 with its registered office at 1 Principal Pl=
ace, Worship Street, London EC2A 2FA, United Kingdom.



--===============2336113832687118290==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Development Centre (London) Ltd.Registered in England an=
d Wales with registration number 04543232 with its registered office at 1 P=
rincipal Place, Worship Street, London EC2A 2FA, United Kingdom.<br><br><br>

--===============2336113832687118290==--
--===============7179968743903116551==--
