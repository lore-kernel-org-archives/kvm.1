Received: from smarthost3.eviden.com (smarthost3.eviden.com [80.78.11.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA01363099
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 05:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960511; cv=fail; b=S4yepzKRHTfyMuy4KAaAhk0bcDGSZ2/c9D8D4dEWFqmxNmMpXF/3Vd8S2XZEdMP7w43dVGt0bu5WBA7rezSS/OOn8pkqE/UQn+FxJXaguti+7iPR18U6Orwg0GO4v1Us5ImjtP7mHFglzGPjIWhSfjolYK7aBR1Qu8gSZ81nHak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960511; c=relaxed/simple;
	bh=k1CsoqbSaG0S4HgUZOc0lDa0NDin46kMva2l+pQI7Os=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huY3HzM+TNHpPYDH37VwPZt0H0K1+zitXJTzmmnAd+MkynfoU9LX03tU3Dns+WAQybMeWp3FZ/gDHf5h20GzGZFABA8hjGlxyIbyj5pV5RJ2xND1l7NPCRKc/g0MymMmX1kwKG7kxRV96PQlpIIBDc3UGBDmbl3Kyd7DupGRK9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com; spf=pass smtp.mailfrom=bull.com; dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b=doFhlEo7; arc=fail smtp.client-ip=80.78.11.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bull.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b="doFhlEo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=bull.com; i=@bull.com; q=dns/txt; s=mail;
  t=1777960508; x=1809496508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k1CsoqbSaG0S4HgUZOc0lDa0NDin46kMva2l+pQI7Os=;
  b=doFhlEo75xRbpZc9GSbEI7eFVIBh6IdZIhVulGWJPqCS84RxoXD70kkG
   HS2BCAU9E6tfu+1gjY0yYmnmOGfvE9HCdFb74diVtvUYaWtGW+qj0hp6v
   BVVMMjP1uV2d7lU3HTFf9b7amrJXhdT7bt+sRR+gTK2k89LRwSuvrLfAy
   1JyKlFIsSYWOM89PXZY1CuKjwRAwrfx0Dq98FXfBNaNaTzKhnJODz3fml
   GWI246hUE0zFPY9MAqQh1b4Aav+itQJ1Z9hy5sWgRcSvrL6lzhNu3/zgl
   xj6k/xqvFSllZLxofzOIOPyoIuRh2gCdjZHJi0bH3nuFHqh1CeE2UDyrk
   A==;
X-CSE-ConnectionGUID: IhS0jmjSRCKNTr7WwAn7lA==
X-CSE-MsgGUID: Om2K9m6OQrS5N9IkBqsuVw==
IronPort-SDR: 69f98503_7c/OL5Lm092NkFYu59wLhQ64UpsJJ7KSJGt5wN+fla3RDA9
 T1jsvJVFPI4c1dJNDFNiHbzTBR8sXNeL7DC9AQw==
X-IronPort-AV: E=Sophos;i="6.23,217,1770591600"; 
   d="scan'208";a="47848334"
X-MGA-submission: =?us-ascii?q?MDEM/qmv/577P0ARtm7fWUCb8Sy8wlnFeNqg/R?=
 =?us-ascii?q?Tg9tFuAaz5pPgnZr8PIdZzzG0pLhp+hIxbF/fYtxVrggIfnUC/1hF+5U?=
 =?us-ascii?q?phUa+e8QBVvW0VUptgmE/7ZjdJ9MQUc8EkgHRjkL1xkXI1lc2QRDhKqP?=
 =?us-ascii?q?VpaseDxKe+Gw/YJdj5BQ192w=3D=3D?=
Received: from mail-northeuropeazon11012040.outbound.protection.outlook.com (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.40])
  by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 May 2026 07:49:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmLjSgU6kcZKcCgal83UYPcsMW5bYCqtXbxcdET8H/AZH//EAPSIbGPUnVVGZYJfPNqJH3TxjMZSCijxonUvd+0v/HOZkoP4xDMlEL9qR7iMXi14aAj6xWa2Ph6krwLvl6xjHzQ2TF+fFXl65zfuBdcDCzHJY+3FDZRMUSQO3bKegALXCbC1E54iv28rG1rd08qlIHC99LDzGsFcEZWV1pGcAf2fD9ZaKrny4R4jLakTzOaXaMUkBoiCzCpDgjnx703uI87z9jT4yuI2aM3HdYctu1no3ei9//3io6RbxtEsdF1eyhxoFYnk3lgeIZVlmsNr5wd8SPDPvsqPv88nHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1CsoqbSaG0S4HgUZOc0lDa0NDin46kMva2l+pQI7Os=;
 b=RJ3Ueu8cCpJGVy23O0XKeL3oIV6CnzrtjBOuoOj9F1j5rcrpmmpNq3G6D8ri/7YUAmWtW4Uye15EHYX4N6VEeDIicq8bUyTAG1X/u9VjoEAqZ3iibYkcWH91mv8p1YEhfSs/mIB9iVgY1KrYdyZ5G8EPWRzYzJopJeb+lqEmLaRtt+D/p8VzjVGj63sRti9f6/Yk9vrHTI8AqMv/CSyimRZTDKGFW1jWUuhQzPasZ5k8jNXjkv/k+7+Ai1lAq8DH2DfwBYDDc1TX4WZZpNmk/pX4ZViEOFHLvFDnThU+jIJyCi0ykcR0ySJlDkLvVK3YktQAedeT4l2w1/PGOG8luA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9840.eurprd07.prod.outlook.com (2603:10a6:20b:682::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 05:49:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 05:49:52 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
	<clement.mathieu--drif@bull.com>
To: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
Subject: Re: intel_iommu unit test is also failing (was: Re: [PATCH
 kvm-unit-tests] realmode: load above stack)
Thread-Topic: intel_iommu unit test is also failing (was: Re: [PATCH
 kvm-unit-tests] realmode: load above stack)
Thread-Index: AQHc290Y7pkUzSSxRUCgUdo/bv9aJbX+7g6A
Date: Tue, 5 May 2026 05:49:51 +0000
Message-ID: <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
References: <20240604143507.1041901-1-pbonzini@redhat.com>
	 <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
	 <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com>
	 <afi_HNJoObF10rwz@x1.local>
In-Reply-To: <afi_HNJoObF10rwz@x1.local>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9840:EE_
x-ms-office365-filtering-correlation-id: 5755ed53-1e46-4067-ab1b-08deaa6a206e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|13003099007|38070700021;
x-microsoft-antispam-message-info:
 SuL51XzMiS/JiKdlOU0YB8nE7TKjRVgb6UvjbNZ02cBz2hsGFCBCcaVIo+2vE2bnZtFfnJOGEx/bR3ZbipzjFiENYi73ad9G2EY6nI8KFmAGtZitIUwzGNtGXuXXvpeGCFNfNgjOy3x5io05oql55tytTh2CjGEXHQcCqM3RinHyF+KFeBRUaF2XovBREtRGJFyrbanmn8w9L74g9ERMdzF9dq6Nz62GmVe9/fKsZcmtXcxis+iw1uXixF82dmAORnFq6Q78h7/31Qtzpe6DMFA/xsvLVLxUjlTlYnFG1FMqSis7qGS9lX30oZF7LjLxZprWLWQ6oS1/H6CGdsY//dOrjFafHxRQSI14wmXeged8wGLuPD40wNfQSjl/T7Zu5BvSPz5Wt6zfC/tkY3J9XJPB+yFsyMPyUKhVvOBV9Ep6vd5j6bEMS+iWejuWre5qR7+ISy9x8H2DFLeSiGg5sStl15VnmeHmo+xg/G+JRl0MCp2HTzbl0WNWnmc64dtQ+1QaKBTFAIybpv/E3m6q4lNOqOb4UMweVP/XHPxGbtwXiEjHYq2OAcY62NS7Msuw9JmMNHJZAyi9O36T+c6DUI3wQsD2g8ebTLFFUyv1OkNX0aRHzK7Z88fk+6p88VhUgToVrra3vlyrdu2Osfs9zktbINytanfjeTq+jyweYoqEMfmF/nAB+wBS+Di+uuxw7xqFLWviCB0yuDe6W1kqkgFN/ftwci0XVHgntJOukWQXaUZdVHjpr4fBKg9CYPIF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB7602.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlNsVWk1Tk13VkMyTzc2ZmtFV054bHhWdUs4T0ZERG5HSkxkYzFRTjZxdWNG?=
 =?utf-8?B?UlZ3L3o3YjFxUU1QVEF1KzM3L3dZaVJncldmQ08vOHdJOGVXZDl3NXdnUjZE?=
 =?utf-8?B?b2NYakUwOWpLQkpSdFozdEhZRTV4dW5wL2lub1lFN0o3L2JtQWpuUm5ZenUv?=
 =?utf-8?B?T3RtdUNiMis5OTlMQTVRUDYzbXpCYTVlNUFRMS9jNzVVQldnQVFqa0drNjBE?=
 =?utf-8?B?dzF1Vnd6ZzlXbkkxYUR2TzQxWVdMOFhoamE1RnFTdC8xb1kwMnZDZWFkaURY?=
 =?utf-8?B?cXlneDZYOFMxYWZJYmIvdjVtQ2hpSWVqRWw2U0JYQmk4MHQycTBZRHc3enV1?=
 =?utf-8?B?ZU1ybUNDK0pXcXgrTVdXNUMwWEpJUDVpeWl4RVJ0VEZYVmlCd2VmMHh4ejBs?=
 =?utf-8?B?Zy9rdHlvVTBPcEtTL05xMTZmTWJIQnJjU29HQWZNZC9mWFJzNi9RbXZSYTBB?=
 =?utf-8?B?azQ0U200US8zbXlGWWkzb01JYU8zMU45OUllZ0hQSi9Wc3pBVi9Zek1WYXZP?=
 =?utf-8?B?TWJOZTRCTmw0UEhDVkZPVkR4VHMvbVFyQnRyT3JqcCtFbGF0UFhlTFhTVzRi?=
 =?utf-8?B?VmFBYjg1MVJUM0RVVW1QbStMeUZPanZjUzRmenN3Y0hoT0V5SzBsQ3d2dFlw?=
 =?utf-8?B?bENXV2paNjJlRjR3c2JoS1NlYUtNa1FBUXVSRkdheE5sS2xpcXlQb3N5YTdE?=
 =?utf-8?B?MjNRNFNUUHBrMHRzTnlFV1dtdVBsdUFxRStiNUI0ZGJIelU2QXZjaVlMRWVZ?=
 =?utf-8?B?dkdka1R2MHppc001YW0wbGR1STU5T2gwV0tMTitaM05wNE1UbXYzVVROSjJX?=
 =?utf-8?B?dVZONWFpcmhJaG9ua1NzaWowU1luOUE4OFhkeEV6WGpGbUZSRzBrb3JXK3Q4?=
 =?utf-8?B?MW5BYXJuSjBISmVDa2ZRbWc2QWk2Vi9TcUJ1bkIrMkRTclp6UU53ZmRJZzc3?=
 =?utf-8?B?OXZMbGt5VStBVFZ3U3E4ZGNzc0F0QmxLaFl6R3lrRjYxSS9sZkpEanFUVFFL?=
 =?utf-8?B?MXpJY3VTdnBsTGhYajJhQjhlSmtwaTZ4S1hpK1hCRDJOTEJ1M05jKzlwN2ti?=
 =?utf-8?B?c1VzODcvZHdibUIrQ3NZZ2F2ektBemFTWWx6cUNsNzluUVU5dDlsSGJrR0Nm?=
 =?utf-8?B?N1dlTHErd01Qdy82S3Nld1lISDN2Y0VSbHBrZHR0VE52bzFJMlpMOWRnS29C?=
 =?utf-8?B?dlBaMTdVRkI0cXdxL3UwQUN6dHRtU05GUlQzMkFXUHdTR0w3U05xNFR3K3N3?=
 =?utf-8?B?Y0lSYVNvbDVIMTZQUU1iOWI2M1ZvVzdQYkR6NnpUUmpVZnBINU5hUitHQmUw?=
 =?utf-8?B?YWFFM0l2OTlJWnpsQndob2gxeUtJSXZCSTY1T2xXUTNuL25wWDNSY1hZNTBK?=
 =?utf-8?B?ZnUvRVFBbzdveXh5SVVsZnovQjBTRXpOaWtzMURzRC92amFIVUpheDgwNGZF?=
 =?utf-8?B?aEQ2amI0MUMrblpDc2RYN1lsaGpJcngzNXl4TDlxVFFtTVY2Y3ZmdnE3RFZz?=
 =?utf-8?B?ZmlybmpKZWdUMWNJbjVOdE1qb05CNVloZUkxTFc0dkVzUHQyeldNR2VtV0hV?=
 =?utf-8?B?ZFZyamxyQnMzWHJNbEdFM0I2T2paZDVIZTR5bWxLMUtOK0VacVU3TnYxWmJS?=
 =?utf-8?B?MXFNN3B6dU9UeEZ1OWRnM2xPdUJGVUp0aWVsSyszRnZEcGlJTWVXbVVQTk05?=
 =?utf-8?B?MEhtcXlIUTk1ai80ZTBlNGNLUWRHYmxzWmk5Rm9zWGNpS1hGZk85TEFpNWhL?=
 =?utf-8?B?QjBvNkZvekdhYnd2cDdQUkNGa0thZlQzWnFUelJFMFBKMXlsRjAxYzhZUjMv?=
 =?utf-8?B?N1UzL2c1TDJ6L09nYW9sNWFlbkpidEJ2NDNzOVpYYkhMdHN1VU8wT3ZvS1JJ?=
 =?utf-8?B?MFlpN1hzU0YvaU5jNnlWNFRBWVVtQ1lBeFpqWUpUSzBPR1g3dXZLUGJyOWR0?=
 =?utf-8?B?Z0h3WURzVko0ZzRsdzJ1MWdsRnhLTnM2aW0rZUlpRnIvNnNnc091K0I5YjBn?=
 =?utf-8?B?UnZ1NFZkc0VMUUp1WmpkcmFacnVEOFIxclZLL2NUVXQyaGJFK3IrdkRCR1FP?=
 =?utf-8?B?bFdnc2xXeko5dWp3U29WSVNaTmYrbTI1VlM2dVhWVkVTT0c0cE5NSHF3SExJ?=
 =?utf-8?B?R09vYWRadzRKaENDRFhocVVseE16cm01SlRnQXVZclVaQWlEdWxmbEhRTWRz?=
 =?utf-8?B?ck5nQ2JKTTJOOEZjOEc3bW91c3FGVlRDK2ZQRVg2MEZ3UG1lZUtjdE16RHJi?=
 =?utf-8?B?emd2Rlh2MWttV1F4Z0FIc1A3ZzVxcFRUODQxeWdGUkJUTGtxdTBFWXhJUG1Z?=
 =?utf-8?B?MFNuT2RGemwvdDVWczUvUFJhRUVKTGlteERzMFZGalhEZEsvN21xenZrQml5?=
 =?utf-8?Q?5tjNMHFDiIU7PeSk55Hzg9WZ3E9MP9eKpOWFA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C89D8015439C54783FE9B5ECC3A84B2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SHpEFCphaiTokFjds20eXcnCkJPQAHYXUu5Xu+eYbTwN/xbk7627plmAwffeNnSBb0lImFyELK9GQO+9TVqTmtm42uZXtbaTmCYbOugYcOI0gF1ZDd5zPm3CZ/LPc2YfjRuGgzTBjpwOvfDYTA5ogO1AVyuGCHNN7ui45N+h9A+7Yo7HcEuTrxDaD3rb6W0M4WzgysntBu9to9MixIOWUP0TXjgNggTIsrKvk64/WAd0zkDZZlMZumdXuq44JuhWUKd4+QRwebR8UTTK48gLrV1RASQxKDLB37B8hXrPq3D4gYRGDiDOiRyEw3ggEBQ2YE0jn5MjnQnqbTpWqmahYQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5755ed53-1e46-4067-ab1b-08deaa6a206e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 05:49:51.9988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3tLw5uRLwtYhsj0nKgLxpYY21R2dAps4KiWlauE2RrtwUWUUSVXgtQKfAE8Yt7kpBTQDwbhgGMx6/RV+6Z5RReyCY5SSl9sRQsuV+Xc36w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9840

SGksDQoNCkluZGVlZCwgaXQgc2VlbXMgdG8gc3RhcnQgZmFpbGluZyB3aGVuIHN3aXRjaGluZyB0
byBnY2MgMTYuMS4NCg0KZ2NjIDE1LjIuMSAtIFFlbXUgMTEgPT4gcGFzcw0KZ2NjIDE2LjEgLSBR
ZW11IDExID0+IGZhaWwNCg0KT24gTW9uLCAyMDI2LTA1LTA0IGF0IDExOjQ1IC0wNDAwLCBQZXRl
ciBYdSB3cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFj
aG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25v
d24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBN
b24sIE1heSAwNCwgMjAyNiBhdCAxMDowNzoyNUFNICswMjAwLCBUaG9tYXMgSHV0aCB3cm90ZToN
Cj4NCj4gPiBPbiAwNC8wNS8yMDI2IDA5LjU4LCBUaG9tYXMgSHV0aCB3cm90ZToNCj4gPg0KPiA+
ID4gT24gMDQvMDYvMjAyNCAxNi4zNSwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gPiA+DQo+ID4g
PiA+IFRoZSBib3R0b20gMzJLIG9mIG1lbW9yeSBhcmUgZ2VuZXJhbGx5IHJlc2VydmVkIGZvciB1
c2UgYnkgdGhlIEJJT1M7DQo+ID4gPiA+IGZvciBleGFtcGxlLCB0cmFkaXRpb25hbGx5IHRoZSBi
b290IGxvYWRlciBpcyBwbGFjZWQgYXQgMHg3QzAwIGFuZA0KPiA+ID4gPiB0aGUgc3RhY2sgZ3Jv
d3MgYmVsb3cgdGhhdCBhZGRyZXNzLg0KPiA+ID4gPg0KPiA+ID4gPiBJdCB0dXJucyBvdXQgdGhh
dCB3aXRoIHNvbWUgdmVyc2lvbnMgb2YgY2xhbmcsIHJlYWxtb2RlLmZsYXQgaGFzDQo+ID4gPiA+
IGJlY29tZSBiaWcgZW5vdWdoIHRoYXQgaXQgb3ZlcmxhcHMgdGhlIHN0YWNrIHVzZWQgYnkgdGhl
IG11bHRpYm9vdA0KPiA+ID4gPiBvcHRpb24gUk9NIGxvYWRlci4gIFRoZSByZXN1bHQgaXMgdGhh
dCBhIGNvdXBsZSBpbnN0cnVjdGlvbnMgYXJlDQo+ID4gPiA+IG92ZXJ3cml0dGVuLiAgVHlwaWNh
bGx5IG9uZSBvciB0d28gdGVzdHMgZmFpbCBhbmQgdGhhdCdzIGl0Li4uDQo+ID4gPiA+DQo+ID4g
PiA+IE1vdmUgdGhlIGNvZGUgYWJvdmUgdGhlIGZvcmJpZGRlbiByZWdpb24sIGluIHJlYWwgOTBz
IHN0eWxlLg0KPiA+ID4gPg0KPiA+ID4gPiBSZXBvcnRlZC1ieTogVGhvbWFzIEh1dGggPFt0aHV0
aEByZWRoYXQuY29tXShtYWlsdG86dGh1dGhAcmVkaGF0LmNvbSk+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFBhb2xvIEJvbnppbmkgPFtwYm9uemluaUByZWRoYXQuY29tXShtYWlsdG86cGJvbnpp
bmlAcmVkaGF0LmNvbSk+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgIHg4Ni9yZWFsbW9kZS5sZHMg
fCAyICstDQo+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS94ODYvcmVhbG1vZGUubGRzIGIv
eDg2L3JlYWxtb2RlLmxkcw0KPiA+ID4gPiBpbmRleCAwZWQzMDYzYi4uZTQ3ODJhOTggMTAwNjQ0
DQo+ID4gPiA+IC0tLSBhL3g4Ni9yZWFsbW9kZS5sZHMNCj4gPiA+ID4gKysrIGIveDg2L3JlYWxt
b2RlLmxkcw0KPiA+ID4gPiBAQCAtMSw2ICsxLDYgQEANCj4gPiA+ID4gICBTRUNUSU9OUw0KPiA+
ID4gPiAgIHsNCj4gPiA+ID4gLSAgICAuID0gMTZLOw0KPiA+ID4gPiArICAgIC4gPSAzMks7DQo+
ID4gPiA+ICAgICAgIHN0ZXh0ID0gLjsNCj4gPiA+ID4gICAgICAgLnRleHQgOiB7ICooLmluaXQp
ICooLnRleHQpIH0NCj4gPiA+ID4gICAgICAgLiA9IEFMSUdOKDRLKTsNCj4gPiA+DQo+ID4gPg0K
PiA+ID4gICBIaSBQYW9sbyENCj4gPiA+DQo+ID4gPiBGWUksIHRoZSByZWFsbW9kZSBrdm0tdW5p
dC10ZXN0IG5vdyBhbHNvIGZhaWxzIHdpdGggdGhlIHJlY2VudCB2ZXJzaW9uDQo+ID4gPiBvZiBH
Q0MgMTYgZm9yIHRoZSBpMzg2IHRhcmdldDoNCj4gPiA+DQo+ID4gPiAgIFtodHRwczovL2dpdGxh
Yi5jb20va3ZtLXVuaXQtdGVzdHMva3ZtLXVuaXQtdGVzdHMvLS9qb2JzLzE0MTk1MTk1NzI3XSho
dHRwczovL2dpdGxhYi5jb20va3ZtLXVuaXQtdGVzdHMva3ZtLXVuaXQtdGVzdHMvLS9qb2JzLzE0
MTk1MTk1NzI3KQ0KPiA+ID4NCj4gPiA+IEl0IHdhcyB3b3JraW5nIGZpbmUgc29tZSB3ZWVrcyBh
Z28gd2l0aCBHQ0MgMTUuMToNCj4gPiA+DQo+ID4gPiAgIFtodHRwczovL2dpdGxhYi5jb20va3Zt
LXVuaXQtdGVzdHMva3ZtLXVuaXQtdGVzdHMvLS9qb2JzLzEzOTc3MjYwOTYxXShodHRwczovL2dp
dGxhYi5jb20va3ZtLXVuaXQtdGVzdHMva3ZtLXVuaXQtdGVzdHMvLS9qb2JzLzEzOTc3MjYwOTYx
KQ0KPiA+ID4NCj4gPiA+IFdoZW4gSSBhcHBseSB5b3VyIHBhdGNoLCB0aGUgcHJvYmxlbSBzZWVt
cyB0byBiZSBnb25lIGFnYWluIGluIHRoaXMNCj4gPiA+IGNhc2UsIGJ1dCBzaW5jZSB0aGVyZSB3
ZXJlIHNvbWUgb3RoZXIgaXNzdWVzIHdpdGggdGhpcyAod2l0aCBvbGRlcg0KPiA+ID4gdmVyc2lv
bnMgb2YgR0NDLCBJIHRoaW5rKToNCj4gPiA+DQo+ID4gPiBbaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcva3ZtLzQ5ZjhhYWRmLTZlM2YtNGQyYi1hMzJhLThiYTk0MWEzYTJhMUByZWRoYXQuY29tL10o
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtLzQ5ZjhhYWRmLTZlM2YtNGQyYi1hMzJhLThiYTk0
MWEzYTJhMUByZWRoYXQuY29tLykNCj4gPiA+DQo+ID4gPiAuLi4gdGhlcmUgbXVzdCBiZSBhIGJl
dHRlciB3YXkgdG8gZml4IGl0Pw0KPiA+ID4NCj4gPiA+IENvdWxkIHlvdSBwbGVhc2UgaGF2ZSBh
IGxvb2s/DQo+ID4NCj4gPg0KPiA+IEJ5IHRoZSB3YXksIHRoZSBpbnRlbF9pb21tdSB0ZXN0IG5v
dyBhbHNvIHN1ZGRlbmx5IHN0YXJ0ZWQgZmFpbGluZyAoZm9yIHRoZQ0KPiA+IHg4Nl82NCB0YXJn
ZXQpLCBlaXRoZXIgZHVlIHRvIHVwZGF0ZSBvZiBHQ0Mgb3IgZHVlIHRvIHRoZSB1cGRhdGUgZnJv
bSBRRU1VDQo+ID4gdjEwLjIgdG8gMTEuMCA6DQo+ID4NCj4gPiAgW2h0dHBzOi8vZ2l0bGFiLmNv
bS9rdm0tdW5pdC10ZXN0cy9rdm0tdW5pdC10ZXN0cy8tL2pvYnMvMTQxOTUxOTU3MjhdKGh0dHBz
Oi8vZ2l0bGFiLmNvbS9rdm0tdW5pdC10ZXN0cy9rdm0tdW5pdC10ZXN0cy8tL2pvYnMvMTQxOTUx
OTU3MjgpDQo+ID4NCj4gPiBUd28gd2Vla3MgYWdvLCBpdCB3YXMgc3RpbGwgd29ya2luZyBmaW5l
Og0KPiA+DQo+ID4gIFtodHRwczovL2dpdGxhYi5jb20va3ZtLXVuaXQtdGVzdHMva3ZtLXVuaXQt
dGVzdHMvLS9qb2JzLzEzOTc3MjYwOTYyXShodHRwczovL2dpdGxhYi5jb20va3ZtLXVuaXQtdGVz
dHMva3ZtLXVuaXQtdGVzdHMvLS9qb2JzLzEzOTc3MjYwOTYyKQ0KPg0KPg0KPiBMb29waW5nIGlu
IHRob3NlIHdobyB0YWtlIGNhcmUgb2YgcWVtdSdzIFZULUQgbm93IChZaSwgQ2zDqW1lbnQpLi4N
Cj4NCj4gLS0NCj4gUGV0ZXIgWHUNCj4NCg==
