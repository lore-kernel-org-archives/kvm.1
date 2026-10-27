Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=3.74.81.189
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793140339;
	b=xTqe7lLDo/DGB0AJC9kuWBHt01LmRchhQIegRvUBiPiEegVLsrDR7xeTDPtANucfAuOR
	 /2qe35a+irYYe6cQZ0BjFYYg7oq8GeyGeZz2bLsoOSU5h2BCq31wACctYdC2XEvaFWoJQ
	 Ogs3GBx+nSwMQF6ekrr88xErHfSKHKUhb+ONG2cWk1aa7IWetsX/PvoDwC00lt4cadgR9
	 VcwYPu3gH+b2FrthFfzr7vXcSeNCHsrKxdhfpc997uGnWXf61YfEhCGwsS1O5svnAmLJY
	 w3Kvlis4nXgwfIr8ji2jlSbfBEYWUTzIoXc6gLC8n53Lo92g7woAoYG5b87fRx90TMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140339;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ncj4joIiKbPl16HQlEIKHQhWwv8Vu9xouoGMLLvA1/0=;
	b=q6YJlIODr3B6c4/7FQkBHKxC0U2bFFHcHRBf8X3TIjUMmdw8qLr0HeRC28LLQaQYRXu8
	 E856jy1DtjicaR8LXm0ZRynsYLww18wjJeDLhFC79MmBcoZPMkey8x0Tekez1GGE/UkCe
	 55QT5j8V8gNJdeyMRBTDkiQDdeKqpri9IupINS/vFuQmSC+clDRjfXT6m3fzWmAewfYqU
	 IHocR+qUeeInlUmiUC1bJjOCV4t9d8ZBuhPZVZJRZeRPbzoMhhH3NSG/K8f+6mGHvNgl8
	 bz9lLZ6ciLJbvFLE16lufhRcg+8hgzW5c1gz3CTF/ZAqWROb/xjoCWheuqeoGsGSjGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=rUZEzfn3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=3.74.81.189
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1438606A339
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1438606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=rUZEzfn3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793140339; x=1824676339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ncj4joIiKbPl16HQlEIKHQhWwv8Vu9xouoGMLLvA1/0=;
  b=rUZEzfn3stCriHjA46uHvp7OyHaJ2cbcPFGRyBJR/ST7lMeqMx9ud2iQ
   mnrQZUn1IPQU6JTjjw+kRiUp77k7MiD5Zx5mdH/MHwSED6/z93xR5DR+7
   +8hGGAaH+oNvEaxsd7baKecbd3dCdVUwWtUhvYBQR5vioum5hVqRWHO1Z
   QpTyeSs7UYgmrjiVxz/FX1DdFaDGuSU5zIZ9NJRxyWSautNZSCrubJ4iE
   PIrFaz2TDEIsj27n6c/PNLwDI/dj1WHoTQatUPRKcuaDZ+MUXdfhWtWYU
   aVdGYB9LE8+igD8UluzyU2PteYgIUL+hshfw4KSfnyOPCZPkZzbcBccxZ
   A==;
X-CSE-ConnectionGUID: AeYYbsXURJyT4H/h4cm74Q==
X-CSE-MsgGUID: EIQnOeM8R/C2JfIx6rkh5w==
X-IronPort-AV: E=Sophos;i="6.27,181,1787011200"; 
   d="scan'208";a="21851393"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 22:32:14 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:16086]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.14.248:2525] with esmtp (Farcaster)
 id 34426368-de01-46a2-80a4-9e7ac2f0abda; Tue, 27 Oct 2026 22:32:14 +0000 (UTC)
X-Farcaster-Flow-ID: 34426368-de01-46a2-80a4-9e7ac2f0abda
Received: from EX19EXOEUA002.ant.amazon.com (10.252.50.139) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 27 Oct 2026 22:32:13 +0000
Received: from BEUP281CU002.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUA002.ant.amazon.com (10.252.50.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56
 via Frontend Transport; Tue, 27 Oct 2026 22:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtZQW0xIXsfjR6x5jax8X9Ag3k15rHtmt7dueOe7wCX7QyNemIKl3fNDj0oN1RiOYPsn79G59DIeUZShDIOSMtpaYfYH0/cIv7xGUTCL1OQy/7hYFFpFOrkkpr1OZqTgQTNR5+mX2FcL+NyQ9rNOKIGOLBUR7Z1cXqNzohPL/p9GyCHhejrAfyavzI0yO1iAofRCmvOfb2ysH3S7dEX+5Kkv0A3kCdWiMv6S2X/9iWQ5iQx3hvl2IaiEN985zEwLayVBjVltJfyUTAbKE9xQJi5y4rnjc3w6LyW6/Sd/wy0hqf4YGpdgAf0crSBkNHI7VBJe0vEoDI6m8dY4CrTmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncj4joIiKbPl16HQlEIKHQhWwv8Vu9xouoGMLLvA1/0=;
 b=ODuYXKFun2vom1228BH2sKny64I15JBPEjrU/QwwNZEOGFUtDQBE5bna/uQM9697IGYd9x8o3hHvr+qrHPcFOZFW5zobrIdN/BFWsS8Z7YS46/L7MNuSljgUpJCaSd5Sw015gsyLFN7S015NLsiD6TYuXJkr5/CoYtR4kxNqAEeFdI5lkN1wLgu4HYuyuxGLYh42KU6M7QJ/o6L04ymf8lO0GOOtrjtEmvGVSYlP4yVVlCWxXsnWwQk1mhOyCIHDMadZbCqfSUXtbxN427vo1tW/bovm/nOpEryg7/GV8JRK3MLy6R8c+EyTKu3bII86H9H6IveUjoO0SCO6pBj+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:20d::13) by BE3P281MB6226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:104::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 22:32:08 +0000
Received: from FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7b1c:7a5d:c405:6c4d]) by FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7b1c:7a5d:c405:6c4d%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 22:32:08 +0000
From: "Graf (AWS), Alexander" <graf@amazon.de>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Hildenbrand <david@kernel.org>, Anthony PERARD
	<anthony@xenproject.org>, Peter Maydell <peter.maydell@linaro.org>,
	"qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
	<liwei1518@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>, "Edgar E. Iglesias"
	<edgar.iglesias@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Chao Liu
	<chao.liu@processmission.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Daniel Henrique Barboza
	<daniel.barboza@oss.qualcomm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Sergio
 Lopez" <slp@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Bibo Mao <maobibo@loongson.cn>,
	Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
	Xianglai Li <lixianglai@loongson.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
	"qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, Song Gao <17746591750@163.com>, Eric Farman
	<farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>
Subject: Re: [PATCH 11/11] accel/nitro: mark 'nitro' accelerator as secure
Thread-Topic: [PATCH 11/11] accel/nitro: mark 'nitro' accelerator as secure
Thread-Index: AQHdZmMAlMw9PSV1v0eV1IWyw8llqw==
Date: Tue, 27 Oct 2026 22:32:08 +0000
Message-ID: <a4f0b1f0-dbea-486e-b744-899b242e8ebe@amazon.com>
References: <20261027181400.1752951-1-berrange@redhat.com>
 <20261027181400.1752951-12-berrange@redhat.com>
In-Reply-To: <20261027181400.1752951-12-berrange@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRVP281MB744463:EE_|BE3P281MB6226:EE_
x-ms-office365-filtering-correlation-id: 41515744-e6f2-4e5a-2257-08df347a229d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: V3naHdaXcDPRPFZcaE/ps35mVFaYglsS1RDsqeXggSjOlm51x/PJmLU4aZ3WW2V0PJenPrkwvW2GSYaV4ZAlQd8RG9rnBrLjiT6Qs2DJXiyh3peDkAZ1Ay1uo1NeKM1f/E256KpBzD2tKs4/mGXD4xC+cHG4zTOOsF2ixW6nYqz2AsnkUcKpGXAJz5W+iuGYno8iRpJTGV/W0oCv+GRKNpxnZ+NvGuoLjx9oQHQmmewZCTqT68SRx/SE83+UuJKM1xk0vrsyYctBKxgGH08kBizjnu9UI6KK7lrQmlM02AxLsCYWFLOI2E0H/wiuDXcGaQLv3INumgsLOOnnddrxDDZr3l12D3fbGM1qUj6U6zCjrNHLOuTs2jdQoX/2iW9Hmy7P12OfawR6ayn70YzbKmlrhyljhapFNyu0Xhub4fXLFd/8ild5CSCQG/PmY2Irz7i1EQW0J1W7xWY+ZM322o1Ghv7wWQdaEdFxo53PorjFLYmvk/9BBAY+KaRP7hJxnEoDgjkfMRLHc3I7OO+oSJZdqRabDAB7S5bxe8sTH8Gb0hocS65AThFn+kma7nApCoKEGEND+bkD9g1/KbefWVovbKVdf3PLyKUfeflrFdHvQ997Y4PHt2gEg9sConppGD4egsUCYSPRO4H7TrdoF2hKifckVlku8sPi0FDmb00GhmRm3yMxb2Y3qoTceE4y0PBX9+2SGeZ+ep8d07eDkqkqwVnkQVVNCPnBn8UH6KQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlhSZlFqaXd0aitmb3NhV244Z21QNkdvRHBjWko2Q0sxUlNrQUJkNndHQmhC?=
 =?utf-8?B?aTFjSFZwSjc1L20zMExZVW9VY0xVMFo3YVgrdkZNSnl1Q3NlRzAyV1YwYzRG?=
 =?utf-8?B?K3UrcWU5VUQ1SDhPS2k1amsvUmRwSHNwcVR3dXFRYUJwMjNyUG9waW1oL1Vm?=
 =?utf-8?B?d0VMcEo5c3pNc1N5WHdQWU5DU25EdjhxY1BSUlJsdUk1U2xpVUhsTkpnOVRI?=
 =?utf-8?B?ZzJNZHRpRFpjbktMM0dIWXUzMG5yQ3FhdEIzZi9rMnc1eGo3U3psZ3gvQ00w?=
 =?utf-8?B?cUVGaE5lODdHRXdjVkYrTzRJN0ErbFprdkNNTXZQditMb0R1Y3RkdzJ2cFVY?=
 =?utf-8?B?Y2Q5OUZ1NC85cjBnZGJhUlJNNWw0TVhvaVZSOElFT1NuL24wYmJzeXdGZEhH?=
 =?utf-8?B?MjJCbVREWW1TSDBWUUlZUEZOMmluK1Ryd3NOM2tNOFdYWVpvZDZCcnFmWVNJ?=
 =?utf-8?B?VDBRTzB2Q3hZRFRrbmVpdTh5R0YwK1dkcmVEYituc0lQcWtYVElUZFhhUkJ0?=
 =?utf-8?B?b2svcUtkN3R3U3g5TDV4N25YUEc4TDhEd1dlbzFGYzJVRXBnM1VTMDI4d0JY?=
 =?utf-8?B?TGhMdWpycFlBRmFrdFQ3ZjFEOE9uQTFGUllaUUtFR3hRZk93NGhYTzJmZDQz?=
 =?utf-8?B?dmo5dU5OQ3pHeU01a1kvWTJrTW4vL01VWll2REhoNWtNcnVFN2M5ZFBKdjNt?=
 =?utf-8?B?RWdmdUVmS3BRRjVkb1I0VGtUZDRpcHdFd0hqb2o2OHpqWFVTNElaejhGODN6?=
 =?utf-8?B?WFJxRklvTzBKcU5GUm9FdC96S1loT3JBZmE2OGsvQ0FxeU4rNkxGOTYxdURE?=
 =?utf-8?B?NEsvUGV2T0pzTXo1U0pJdkl2Q0hOUWh5ZXZ5YkV4dk92RmEwS0g3ZUZzbmVJ?=
 =?utf-8?B?L2ZKV3VjOTJIR3JZby9qS0pobklFaUhVWFlmMkVSZXkrOEhIZy9XS1EzSWdN?=
 =?utf-8?B?U1BBSWFYeVh1QmpJMUcxekVZaHIwby9pSW1LdHNxZlYxNlJpa3QwTytQOU1i?=
 =?utf-8?B?NTVjNFhObndOVWpTdmgzTmtWTVA0WnFjcjV3eUZHNWQzenpXajZYTGRLS2Nu?=
 =?utf-8?B?ZlhXTVM0SmRNRzh4RlFpc3hqYVV4Snp4cUd5MExqdVdlWEg0QXFRU3o1NjJX?=
 =?utf-8?B?ODhERjJ5dGZxckIyM3RkcW1EaWo5eURjRGlMcUpCc2lTTjNmYnlzb2o1YnRl?=
 =?utf-8?B?N1NrRThpb2dXeTNyUmZTYWh6cjZJYU9nS2FrWWczbklzb1VUTWY0RGRNWEpt?=
 =?utf-8?B?MkZEd2pQeUc3S3pkYWJmRWZuaU01NXJMTXR3Yks3d0VtY1lTODVqMmw3Mk5v?=
 =?utf-8?B?UGFCbGlJK21NL0MzSGM2UEtUcUIxeFdveFhpZ1JVWTI1bW5MNjBUa2NzaCtU?=
 =?utf-8?B?RWg0L0swcUlUeEpOdjRqOHFMWGczc3lyV0t2bzdjbGRkamxnc0lhOGx4OCtX?=
 =?utf-8?B?KytlZkUwSmdWckZtWnE1eG9xVm02bWpkaXZaTnpaMlJUaVZjeGFsYmtJUGtY?=
 =?utf-8?B?ZFcvcU5RNmUxdmpWSVZUT2JpdjREWjY0ZEFxdXNLQVl3VUVGWXhsWExUT1Ur?=
 =?utf-8?B?czY3bHZDc1lBbFA1ckU1bGV4ZEpacnV2aHhVVVFoNmY1cEpMQURzSEVTdmRv?=
 =?utf-8?B?Vy9EV2pHaUkzMzFNQTljRm9yem5vZFpLYWVoNkR0aDU3OFRHSksyQ1haRzdo?=
 =?utf-8?B?Uy92SERaRnNSK2djSU9XekNhc2wxaThtTitXNEU3TFNJdFJFMWhUc0RzZ2ZY?=
 =?utf-8?B?MHdsazA0WXJIMHhuMTBac0pGczNPVzlLWVhqMDVkWlBUdmVGR2t4NUVwMDR2?=
 =?utf-8?B?QmZ6YnJJVDVaS3BoUHh1RXBRYUR3K01iWURGQ1hoYWk5WVBzdWQyZThYQWpX?=
 =?utf-8?B?MTVxY1kyY3hLdUczMUI0WE8xYkZ3VVhxMU9RWTRpY2ltdllHK0w2aHZjbDBi?=
 =?utf-8?B?Q0JPMm9TQjRHa1ltLzZDTmhEWS84YlkrVXgzSTdVdTk3bmJRQ3BSQysrUWJx?=
 =?utf-8?B?ejNnVVZZZnlpaEVheGdlVlBEQ1cyNG8zVzB2MDBTSi80eHorajhiaDR5WFpa?=
 =?utf-8?B?dDlZQjVpNFVNcEY0ZHZraGFhMlc5Z2VkQ3Vzcy8vL0lJdlc3TFh1RG11Nmpt?=
 =?utf-8?B?dnZJK3o1ZWdwQ0hZZGN1bEtVZkpFUGZyVHJIQ0cyQXY2R0ZnR1ZLMHcvU1FR?=
 =?utf-8?B?cVRVSGZBeFRmak4waHJVTXFLcG1SelZZN3lFc21yZEpPbit4VE9tbzI3WWRG?=
 =?utf-8?B?eDMrWDdPeHhSYzZOTUFzeDcvNnBvVkNOU01jcHJJSjUyd1dQWTduQkNCbWZI?=
 =?utf-8?Q?sgbTg/dYUez4UECoGY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71E8D876F7E6D54AADF6F7659FF02972@DEUP281.PROD.OUTLOOK.COM>
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
X-Exchange-RoutingPolicyChecked: ehEdWFHIf7fR1UukeOg7VdK87LLx24FTy6+QD2n+hBRqZTreXslNguE1G3xzNAHPB4UqeqtFU9mbRxfajtXds60RmzjYeCbGnNOzm7ithNr3UTxOkQfzzzfgPdy1JEa02sziO2lb9VzmrkdCbAi8fETgR5T2UkeDmwJY2gadnoafMyCm+Xmwy+qLnlaTcs7nSjrafbKr/4fDNWJSyi+gddp4KZ5upuymfN/3H+q2bXEeeEh5grLHJSQFyFAOaDDvhee9KuRjjqVjzN7zCl9lpLlswPAtUKu2n7G+vbpZdWFSJrUd/kwAH1eDhytpr2nGLOSylFORFoA30KJU/kyNxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 41515744-e6f2-4e5a-2257-08df347a229d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 22:32:08.0955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+lk4TlVv8tIGeSR1RaAVShJTDin17A4/uJHD9WAZsUWhnRpaRpbyt71G3AZH9jD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE3P281MB6226
X-OriginatorOrg: amazon.de

DQpPbiAyNy4xMC4yNiAxOToxNCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gVGhlICdu
aXRybycgYWNjZWxlcmF0b3IgaXMgdXNlZCB3aXRoIGEgcmVhbCBBV1MgZGVwbG95bWVudCBhbmQN
Cj4gdGh1cyBpcyBjb25zaWRlcmVkIHRvIGJlIHNlY3VyZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
RGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1i
eTogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4NCg0KDQpBbGV4DQo=
