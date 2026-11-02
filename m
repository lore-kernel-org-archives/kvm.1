Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=3.65.3.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793621175;
	b=r0XRGBH3VWWDh5fBnMUGKVhOR0yvXG6Khc5+7U2b+4T7/5IG3HBv86GHurIuGpWAKFQ6
	 xMRFxkc4xG15tGfq0zkib75oA1MLlTj9lThVN0LF6D6eYDNRc3fQGXJRTmzXVQMSF6dTa
	 8vtyNd56c8fGubiLy/eNX/DUaXErpMa9quDH0VBNVR0Hys6cWLmMabT4GG5ZKPRTuw+eB
	 DVxuwZgOLK+lcbtY0ulii8lo/AJ7ThFelhLXP3TtMmI7w0AVJ7igMUS+aCkVpDqzC6wCk
	 Mx4rVX8X19AcFrE6UeOU6bwK6apPTDxIcuE7zpon+A1R2EeTRQE4gDlhM4FBIiqVxNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621175;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Subject:Thread-Topic:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:Received:Received:From:To:CC:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=/Zl5Gt7d/bO90KpwAirLLT1yHC4y6iB9Lhyhpiuu4hA=;
	b=xv701hR+p5rnlBKxbK9Gaf1odcie9hzaPYDFa5zykX1+faawzrzIY70dwSxFa/WgO1MU
	 2fdDHSiX4YOtghbQNPjD3mUCMxsxsfqvIX+9uJ2xDb/lP8LiQtKp+hxzls3eplfQy1Lxl
	 DlW8PtjjHqLudQp9CCQgr3p20KwuWXNqcg+hmcCWtTMYAzg7If4NV4+PS/mdXoTCL76Xl
	 T4DJLPisIs+fESUJm2vmuP67cLQy3lUw1qFKDYydJXMga4NNWzl8Uu2O39ELaygXWr4nu
	 XCqmbJdM0HqHSFmRG8qxmXHAqnoXXQgDAOPIuE2hrJxPrfAZgLF1BZyezOXzSRIY9nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=VO8HGGAW;
	arc=fail smtp.remote-ip=3.65.3.180
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D2606A335;
	Mon,  2 Nov 2026 12:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E91D2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=VO8HGGAW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793621174; x=1825157174;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=/Zl5Gt7d/bO90KpwAirLLT1yHC4y6iB9Lhyhpiuu4hA=;
  b=VO8HGGAWfqh00wsX8SHieRgfJc8F0/yMHayiBcNY+ZZb9pOZO/9wKbC3
   plT+AhddC9c5z7KoK91jjzQXYyaLfSwvEu+vMsd1FwvGZYIa1lnGvJz/c
   hP2fNK9XkI7CiUAOL7U9Mb+zn6HPE9/Cb/cWIN4WWkSXNcOsQOf1FkSEM
   2TZ+0pwOP5tBuqMT7nFLadUx6f0ef2dD1zBdsNJ3JIJLtbSHb9LoJkj2C
   SvQSyancf0T3vtevx6jU9fVOnEgY3fzDDO36GRD/7HNHLUQwV0IFyHlKO
   UAgL7rpypuyx9Bz0Y6wpv3SFROruugYMdhvLB23i+a6zNmj4pfA2Ff+ZZ
   g==;
X-CSE-ConnectionGUID: H/MJHDNZRGmoK3Whfnfo7w==
X-CSE-MsgGUID: HQhQpeGQSKWQUD/Ruc79rg==
X-IronPort-AV: E=Sophos;i="6.27,191,1787011200"; 
   d="scan'208";a="22157955"
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Add automatic prefaulting/prefetching for TDP
 MMU faults
Thread-Topic: [PATCH 3/4] KVM: x86/mmu: Add automatic prefaulting/prefetching for TDP MMU
 faults
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:06:09 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:17680]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.178:2525] with esmtp (Farcaster)
 id b9af0f3e-a27d-458b-83c3-7b68ca350143; Mon, 2 Nov 2026 12:06:09 +0000 (UTC)
X-Farcaster-Flow-ID: b9af0f3e-a27d-458b-83c3-7b68ca350143
Received: from EX19EXOEUA001.ant.amazon.com (10.252.50.110) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 2 Nov 2026 12:06:08 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUA001.ant.amazon.com (10.252.50.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56
 via Frontend Transport; Mon, 2 Nov 2026 12:06:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYKGj9RegHU+JSEGvMxIzUpKim5b28CWLAzhSUi335Y71S9MWauxpu3qS3SzKHVkBKgWJ0tfAp7qI1kyT/qinmNVYIpWf7rGr9MXkl5R30UAgAQKO9Mx+pnCRJnBQlc2KTfdZUpldGp1KSiPX0/x5Yd7MPuZlxNenuoM+/Un45RTF+ryM2rWK0gLBqaqmBqeYKcQDHEr3Te2y2EDbYwGtIoEIx0RxpziXeKi6ei8c4TXrcqI4bD91wQ2kzb/7m60CaJbMbY3DOtAoRpi+IPtm2td2+CKWBhWQBgknNC0hYVzjtB3T9GQzG5LXNluXT54V9lS6QWNxBFje8vnSpNM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zl5Gt7d/bO90KpwAirLLT1yHC4y6iB9Lhyhpiuu4hA=;
 b=rVSkiY/RZZvB/T90IKVMGpi50aeGDbPtHbbQhKjzMRTW/D5B1A1lfyyvF3r3oPlCkTIrXgXsQ5B+2q7zKVDYWidFdMKj9ER+tSzmoQZJ6QWi0vxYyi0f7lj2AxX6k+5/pauvUixHUclX9uCyYaynI5LMJRMZ4onyL+2R5M+zWyyVKjDgw0Xx2zqfuzFUR6Ed0IRsyGL4L9YYt2Y4Kcx+a83WTEsbXQAzMtsr/ecC4xtSIPJB7DgxZbMF5BxxGPUIqNae8Vdw5wwV+WmOHRWE44ds+WvGjDALlwc45Pf+RDzN0GPljbTdG9fPKomVH62IoQK62NMrzxwcOd0RwMHKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from GV2PR06MB10711.eurprd06.prod.outlook.com
 (2603:10a6:150:2fa::20) by PAWPR06MB8858.eurprd06.prod.outlook.com
 (2603:10a6:102:386::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:06:07 +0000
Received: from GV2PR06MB10711.eurprd06.prod.outlook.com
 ([fe80::ef79:3e5a:90ef:ae71]) by GV2PR06MB10711.eurprd06.prod.outlook.com
 ([fe80::ef79:3e5a:90ef:ae71%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:06:06 +0000
From: "Marangoni, Marco" <mamarang@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "cc-open-source@amazon.com"
	<cc-open-source@amazon.com>, James Houghton <jthoughton@google.com>
Thread-Index: AQHdZxq2NIaSsqoYoE6jc7QaLU6KRLcTftSAgAFBcU6AAEUJgIAA7/ClgAB/D4CABEE4Dg==
Date: Mon, 2 Nov 2026 12:06:06 +0000
Message-ID: <GV2PR06MB1071106653A4E128AB904BF66B96A2@GV2PR06MB10711.eurprd06.prod.outlook.com>
References: <20261028202607.1844883-4-seanjc@google.com>
 <20261028215143.2913059-1-jthoughton@google.com>
 <GV2PR06MB10711171A7A8F225207FACD6BB96E2@GV2PR06MB10711.eurprd06.prod.outlook.com>
 <auO1_YE89Q0T0hfI@google.com>
 <MRWPR06MB107263BB1EF5464326E45DCD7B96D2@MRWPR06MB10726.eurprd06.prod.outlook.com>
 <auTp2Yp2qtqtiPkX@google.com>
In-Reply-To: <auTp2Yp2qtqtiPkX@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR06MB10711:EE_|PAWPR06MB8858:EE_
x-ms-office365-filtering-correlation-id: 7320df66-1963-450e-c8b7-08df38d9acd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|38070700021|261026121527099003|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: eXd5+hXuvYN9pgzAzOzqJB3oEzVDI83S7OIDQ5lsI6eXxQ8817s5vS0VwJvmcWK29TdUbSevgfUFy9zX6y+KvOe0SxLwqppjo2kCP5qMOIvRedd+aJbZ4OJetiY2nGa2P2iDq/bGc3PYicak0PYMW/rW0EGwH1VzbXrPTW/TKZKEB3TrbGVP27B9XLGXYjsuAvgUIciNNr2GCM47HE9vmO/0zy+vvB+dsmmPR5xCJUIVkiEcUG9UTYPygiVDhh0ZBwbEQbZLxSVuHolT1MGIblzP200FKNREH2MSSgxFI5gJGtGgfQIc15bg0N7J2tOIcVmNYyX8fYGSPFewsK9M4znvaAfODbswCMcHHU07n4FF9fpR9sdtPLSJjTy2Y6hk1iWzz580O4r++MxSiCIj1QceW91ogXVzwiBR3R02bFkig9C54C1od/KB1Mw0kIl4HhgLrFav0oxPV8KCElEYpnxWv8ECN44ywBnN9avWT1fVJwdV0jp3ionXP3+b5fQyJlVQYtVCPGRQhdXZuEBnzsM6eUr6McJ9iJgamq843s/tCtcUiKpKc65v6COIHOEEJrvL05x6MsGgyz6elVdSLBQxnDRbbIMP+J6py2d35O+cqQ91DcUft9RUD1gvaaZ8ut53nbCaYG0cKWyt11zq7vqGv3/d0wtNbLsXRakhs9l2fe9T/MSIqk9sCsJoykqra+JAGoFiVieC6jI24ggXwSpm9GzKUXuGyi8inLv8x7E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR06MB10711.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(38070700021)(261026121527099003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V7X3QbFanW1ruNpxllC/eRfe1pGjVdbvlhcN7SM6ecHz7Pcs1uKbMHRG5V?=
 =?iso-8859-1?Q?jRtKAhkDm/UJHE57NzjbSEJpWXNHvCGzGA07ektjydlnrsgp9MshMocKAu?=
 =?iso-8859-1?Q?Vl9LxH+l+FaYKH5CZptuzyJeFfh9HNWZl8pN/i2qWocUbhMzzLV+8y5M8a?=
 =?iso-8859-1?Q?y/MdVBo1DtBNR3wWoQhg+wI27HkeVRbEyr1R8i01O7Wo1AEH2PgPDxXuUK?=
 =?iso-8859-1?Q?SbeZyqqE9m4SP7HYZP10KHtEZfuSUd3AkCnW7zmp+QDuogXC4s2mRcHRZx?=
 =?iso-8859-1?Q?6/1eIO2fo+dk/4gpK9GqFo7ftFZeH/u8P7xVOh4wyt1idPXpeOPpAQjXjI?=
 =?iso-8859-1?Q?3xX9SLzPyw4MjVwKArFAHo9Dqb+4d/SUvpVHhxZpC1aK0AelTCiOv7lT5O?=
 =?iso-8859-1?Q?M6HLcLpNDvGwpBq5Z0ebrYyg/XHf/5eA3KLRnuLRxj0CsaDE5ygZaIJRE7?=
 =?iso-8859-1?Q?ekP2gNpYQ/xKfB1uTiSOk9055oX2P7gjH0xfqIUH29SAYTIor0mE3KaXxW?=
 =?iso-8859-1?Q?TQ516AX0GNWav4GZkwhPjJmBGHotTIix2i3Y3P1ZaAEVihYs4cV/ZpBM6z?=
 =?iso-8859-1?Q?jm9dEa998lwP72t8MXNev6dIzLQohSigkVrBz7ylYGM2LAVLGTNcUlmit0?=
 =?iso-8859-1?Q?Q+NNGy5a/2bYDzzWqL4SKeUpoDPuug+8avbBmmqvnQITpLqyKKFlR+jYCd?=
 =?iso-8859-1?Q?1JUlU3E8/rZH70tA+/utvfVWiPM+qJntBSgRWxq06GR6vxOuc16Q+lTBPk?=
 =?iso-8859-1?Q?YJmRzMHG7Nc3r29Clm4HWp827uR8sW00KAXqT1T2PUIX944mN3r2yJyh8y?=
 =?iso-8859-1?Q?lDS46Cb/fn33lwqPChv23/r+E/Dy7vRM2Qz4xk+XZzW/RqipDEsS+cEfJ5?=
 =?iso-8859-1?Q?FauJq0I+32cFCPRylcaDpABakP5FenQStRGX8ZMkLwXqqDgqDlRUf0awQa?=
 =?iso-8859-1?Q?hxkAJ2Z3hhr1yMS6mondY+si70MhNk9o8oJwh99Zfz22ebJSPXVpajBD6i?=
 =?iso-8859-1?Q?Yzkmg3LFbOeGgAH1XviTy1HCApXCRyH35spFrODItnHAZbFemqXbGcKu8h?=
 =?iso-8859-1?Q?HrmD3yYXB8/CYu9WKncQEH8zdcpjQRDNq7xoZB5epHDAxMkYgMgSqKB1xG?=
 =?iso-8859-1?Q?yYBQ7ZB5gp6v2i/ZiK3asXTv1TPkKcLh6L09lczsW+jeDOEY1T6J4NMurf?=
 =?iso-8859-1?Q?+tg0gaMZ+PsZVsf8eC9FR+sejGA4QOnwfMn851/WGZnROLjPXd9uB1bpiE?=
 =?iso-8859-1?Q?vLvCQfywqOtQ0Ccq5iOcDy+Ij7zJrBz4N2GudxwgfEPkSxcqvIoOwJcuzS?=
 =?iso-8859-1?Q?rECdHL/TKUyk/zfMiN9xH8hxOO5mKVS35+sw57dOogcroO3HV/tS3bW0WZ?=
 =?iso-8859-1?Q?NysiFzRi7rIyifH522OHqc2vQAabg68AI8gptfW49fmquImQ1JIL4k2hJb?=
 =?iso-8859-1?Q?joxwcoO3Y4I2Y2A5AoIEJlDAYi8RBI0DerDLFRkRdAMJmSjhm7arrl91a6?=
 =?iso-8859-1?Q?+V/tjRMHdFlgU1va7HGYU+JYkocQQw2EQ/4JIL8OI0ED1M9o3SHFN9LEfZ?=
 =?iso-8859-1?Q?Bii0moBW+o59pHJ1vU5RTaboXyi3pbdCizmaAXecx5inwXQ3t2m0YNGgmz?=
 =?iso-8859-1?Q?+AAmydCRBM/MOytrH6kaeCke8lSP5mQlnpvlrSOIS3lrWkxdtlsjv0Clrt?=
 =?iso-8859-1?Q?M5WS3LC6uPYuAnkw9htDPz+5L52vBPZK4vRGRwYs5445PATMo6KbTroJqb?=
 =?iso-8859-1?Q?tDwbSADJwm9SF/QvcFVrS6t1q5wtodffO0VFGmA0bBaibTE4VjaPWKqwA4?=
 =?iso-8859-1?Q?ddW6CV5f3Rvn5xCK/Icb6HKRFgT/AUUcnafBLx7zOoC9ONfhplni?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YfR2B7fiPFFj1keNWQBNx9d/lTWzlFGInE9YvLcfJ61S7FslpgMONCFviAsZnRch/vgiXrpJqExaeOk+fR7o+gecy/F5y/bYOkEqZwZtBokF5ymYZ3+Cda32QC3oqDc82EKTJnu2nUpqhA8JgRfkCSKS251EcFTM/xC2gg5H6G5g2E5UkUGfjLF6LByoBBGdkyBFpiAi3QRgQZXHxwyI4yUnzBiD5bfkakfwZL9zTFlyrO1b/BVGtBh7/DwdNZujtTYOKCDtaS76gBrEnTw9p6BC76wxfhYRX6zUgpYVmW3AMk2HqUSic2PFCX+RChPU3NcSTs65UoVP9wCkCF9mFA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR06MB10711.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7320df66-1963-450e-c8b7-08df38d9acd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 12:06:06.8203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25wro+BE13ilwhsVCoYco+ntDj2xStBWmkWZe8aso54/zjPgrUrBaucbRiqKq0JinqiQtAV8YSEksuld3MaiWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8858
X-OriginatorOrg: amazon.com

On Fri, Oct 30, 2026, Sean Christopherson wrote:=0A=
> Oh, that's easy enough to "fix", the only question is whether or not that=
 would=0A=
> be a net positive.=0A=
=0A=
The only patterns for UFFD we've seen in Firecracker (both internally and e=
xternally) is to use fixed chunks on `UFFD_COPY`. There's some variability =
in the chunk size, we've seen it range from 512kiB to 4MiB, however it's al=
ways fixed.=0A=
So I agree, in this scenario, the approach of stopping at the first miss wo=
rks and is not an issue when the prefault window is smaller or equal to the=
 UFFD chunk size.=0A=
