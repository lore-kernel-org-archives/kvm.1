Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B2315D43
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088485; cv=fail; b=HeOud5jvl0OOWo5vX3shscHb+xSqZKOtji61cDfCqzAF1pdxnYIypKTmHcW3R5VQJ7anUf5isHDFXBOKJxFp/AJ3A58bYDoFOOupwzPkps+rlDhcqt7sggcndIWVp90zVoYXwp/cHfyxo+5mnrOyHdl+8IoBM1kieteTXQuBXrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088485; c=relaxed/simple;
	bh=FnXKURTf6pWOmdZ3QJvXOC18YXNeYAIaIKsl+0t36ro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ceendAzNSx56xDIjleYhJAoEOA0wMlYr6F9xf27NFSjmvKgtIw+c0mlpwWLZwqTdpUMtXQqXUpRyU14/6tAloassiowLGtO6COehuPxRyeX72i1mJxBXfN9KXbuuw6ZgzBmDjhR50T/jhrr7ErnNbCsPaMSNEbe8ztI8vGI4G1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUiE+Kia; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUiE+Kia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786088483; x=1817624483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FnXKURTf6pWOmdZ3QJvXOC18YXNeYAIaIKsl+0t36ro=;
  b=QUiE+KiagS+X6D01GN2P40L8d3gon43FVPIHzepeB4Z9LambjDZqkZYw
   2e+6PbgjvN2VS0vPDvEcGRfjaC/glhIjgatB20pnX9KbUWgKCLuAfDY1I
   s3G2wVeoE4jY+GfF9ySqxZ2eNZk/UHyFkdRdsh1Uya62fv0E6mQIlaggS
   0IESSnRVXqcjtU8l56dxvzh+dyHSBq4+1GydaU758qM7OJf60IHw47lc3
   gKvnR4kmp+rYw+1TyxNZ9C2B0NsXXqhnxoGStRH6rVAl1G5USRulKZoAh
   Itw7FTYG+heiNV2sLF5vRvBCi+kDrprYsEnPtThv0rcWWJsvKeb5p0w7U
   g==;
X-CSE-ConnectionGUID: Wi8RvJe3TcmeZWVZR9pmoA==
X-CSE-MsgGUID: pCJ2mxh2QWyA+ESMrifLrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98053532"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98053532"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 00:41:22 -0700
X-CSE-ConnectionGUID: UOkyPObkSueBLbf5haJDJw==
X-CSE-MsgGUID: 5PF0Ji0OTFeS+MaDf0FPNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="267479660"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 00:41:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 00:41:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 00:41:21 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.17)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 00:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tinqwJE/O4ovEgIhUgr8PNu4e+lviy3d1LPrX8K9DltHq89vkeos+CE8iM5KzgwVPKosCTUmAVz7blSzOn+K2HasrzN7HsCKkkHCaIy2y3LMpBLpZoEWQyVGYpZqt4WNAjtN84nx/rb8o4mwyf1F+FWhVoDwQkI/orBnn0t+ytPOdTghC4cNnzD8fIF6trI6Y9UjHB70p0VNQK3dWi6fpjfIR5auEeVuxh5u13jFXhs3NaYjA1ObBi2epGOz3LJp0MHkyXqRcfpvwBC7wwGP78aXmS4rsJiMXlXKJ9I2VoORPVhwOJ8iuih4txrqAfpzQ2Lo1wHyqWXeqJlOn5KF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnXKURTf6pWOmdZ3QJvXOC18YXNeYAIaIKsl+0t36ro=;
 b=mtF94VLUsEmdGZnNsAiGHW/BMijGV5sXLfh8VdTCDcQKn/DU84X32qfQR22pZw37xrh7l/TLCMTGu5u5qKKHWN3feWKL/TdN4cZ7GinVDrTNS3JjAXoVJsfvpZ6o1KHydAZLwWRdtMlz8sgnFZUy/03UP4+lyC3VKGGznThTahodOB+IEcAucpF0fmkjkKKZFleSIE9IVhLkzmVsLFcGgqMYBWyO7B3HZAex3F4WkGB42KzTgkoYUDUByz+E4ZY4JIIojkCKmAkKii9D1dDM3oHOQjK23esY5qd6vsB0BhKZ4urorvDuHsA/ZDE7/E4gvI6AFYJ/cWJ/6Oo42ic1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 CH3PR11MB8239.namprd11.prod.outlook.com (2603:10b6:610:156::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 07:41:13 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 07:41:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "hao_zhang_kdev@163.com"
	<hao_zhang_kdev@163.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: x86: ioapic: Set remote_irr only after
 successful delivery
Thread-Topic: [PATCH 1/2] KVM: x86: ioapic: Set remote_irr only after
 successful delivery
Thread-Index: AQHdJakSUYrHBSQYpU6sHMxio8YF87aSNOaA
Date: Fri, 7 Aug 2026 07:41:12 +0000
Message-ID: <51b48f462c1a3005f5f45895af9ea5b9f213b41e.camel@intel.com>
References: <anSOdijwS6LBbfYJ@192.168.1.215>
In-Reply-To: <anSOdijwS6LBbfYJ@192.168.1.215>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|CH3PR11MB8239:EE_
x-ms-office365-filtering-correlation-id: 42f8d57c-7d32-49dc-e1ac-08def4574164
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: WyNBHDqekrrYWOkDth1ktxiULIgoSMWShpSSxx0xRySrjEjmdW0X6AJwF9kCVFokVudmyoY+H+vDgBSXatmmxNLAHkWywmGRrqjLbscO4RN7wvtUSSSDQjUlz+1LNXztdXpaxGpmI3zuzVeI3H/V0uChr7C9ZIli7Mu9MjHBfOlKVU1m6eTr/GR5njDEJnIIXaV8O1Iy3dnEzy+Lo5qYn6wkmqvGdU1z78KnWXOIhNotZViQVRTDRfOYoZCrnQCMUt8ihK29a6NQPT+rctXjbYAd5aMK0M9kPowV88D1256/bY9YYO34M/wxpSPF77KJUlh5nTRzdA/CBhbGyllQqvzZuwuYQFwfiiUSzqAhM/lckRK3gZ/8hh/D1PdfPXAo14dom7NclcuaE7sgSk+VmtzlO0+iXUA9tvzG5WqFjjJmrF5Izckw1rgNgjB9pwvzrMp8QPkTAV4ekiAfc+rp3lJV5Fhf7IWAsCpkoHcHZA4x6OgR5wdwNiPgc4h8gzyx1FG0cV1CYTHvJYrRS4fp5ELZseSCELUsKzOTJTqTEQ8I2ieS0iGufMct19xB9oWg747Te2I/pmWwiaWhpEpMKl3E4UNooEuxprjnhxbf/76zI3DIhmfzzWEcSnRAkp4R7OSdftJ0P+RI6FgSHqOCNpQjhmw6VSEi5IL/Xlbufvlt3xeAhsGpcJKUXRcDMdGqRNoCvREs5nY6jfoZZtmY0AEdcHXidviKSd6f0R8eGhk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1Uycit2U2JFUVFoRTNtUjRzLzRhc3JIa29iOFdpY1pTK0dXZm4rQUFRSXlI?=
 =?utf-8?B?UmhOTlBzVlVFcCtzTFE3ZFk1ZWhLeTBETkJLWlo3b2JKcjNEdmdiMzJ6YmxJ?=
 =?utf-8?B?RytubnYzSTVYb3JBTUpvR2p0M2c3NGs4c1padnZyQkt6ZHNDSHR5OFdXUlhq?=
 =?utf-8?B?NkxGbTVUcGQrTzZlLzNEcnludnB6bmFmZ0poZjE4dXhtNTBRa0ZackhiWDJQ?=
 =?utf-8?B?YzBPWUlMa3JaYXZ3dkdJeE96VTRRaTJ6U0ltQWg5TUNmYmhRYTVvdmwrSzBr?=
 =?utf-8?B?MCtEV1A2cDNlUVAvaVJacVhqODZBdEpjekRjVzdSZlVhM09CZWE2cENlNldn?=
 =?utf-8?B?dzZYcHJxNXZFVTlDQjF2a1RlNHNOblBSUzFwQ1BVeEdZMmhEcFJlNUt3bG95?=
 =?utf-8?B?blVGZjVpVjhSQWV4TEIvcjVVTHBWOHZyM1V1VVh5bTNCYjRqRUk3RVJkeXJr?=
 =?utf-8?B?MDZVcGZPQVV3WlBJL21JTHRVMDFpdEdnOEZmTytudFF1Vk1QUWJOSit4d3Vw?=
 =?utf-8?B?d2UzanB4UUJmdUNkZzNSYmowL1ROWmVITEl4WktjbTJpTmprU2pEVXpBWk8v?=
 =?utf-8?B?UWE2TGIxV2p1cStGWTVRM0phSXdpVjNMYjBLcTNxdGQ4RVJsS0tINGZQV24w?=
 =?utf-8?B?Ykh1TjF6T0xBU1lkdW5TeUtrWFhnRW5lTkx4UE1JcHZUNStwTlI4NitlRnFw?=
 =?utf-8?B?MlhWMGtrRWlmVnFtNGNWNS9wbVlOcFJtajNjRnlQektBQXEwY043VEZwT2Zo?=
 =?utf-8?B?L3g3K2pobEx3TTlTWUNiZHRETzU0RXJlRkpqaEluTnJBM1Y3WjIzTzQ5Y1h5?=
 =?utf-8?B?R3J4RTF2YmU4MTR0L0dFdUlFRCtydkU4M1pTOEorbTZ3R0hvT3N5cWNybGxm?=
 =?utf-8?B?RUozZXlsWEpPL2NUejQ5Z3Q4ZW42M1RZZ24yZHFIdjRId1RTYTJMTUV3RWRk?=
 =?utf-8?B?M0VhQUJKVHZCZDJsVGNpbVhKbWhWZVpWS3czSFdQektZR1ViMUJHV2VPaHNs?=
 =?utf-8?B?QUhlTlpDN2JEYjIyb0lPNFZqajFPTzNvdTkwY0RwVFNMeXZJT1BRSTFnYktr?=
 =?utf-8?B?VUN2SUorRlgvOHdGbDIvYnRYYmdWRVNpdFhjSXh6V0U4enNxMi8wU1ZkNCsx?=
 =?utf-8?B?VmVoVzlRVWtZMFFIOU8xY0VyNE5aSlZIaE9oTThnT25CUzRmd24zTDR6bURC?=
 =?utf-8?B?b1hyQnQvdVNmVS9LTkxsNS92Y0F6aWtjWDRmTndOSjdNMjNKQlo3ekJvTzFX?=
 =?utf-8?B?cVBUNHJYa0tTeUY0Mmo5bU92VThSS1JmaXFMTXE2Zm84WExXdnNaajlxdlRp?=
 =?utf-8?B?YWNPekU0cHRESkcyOGdZMGszMWtCRDFoeWkyb0s3bnZzRTg4T3I3Qjlpellt?=
 =?utf-8?B?WlZCVE5TaFlYV3BhRWNBVFJPKzJEMGd6aTh5SDYySjZnekpOdFRmOUY0aVlq?=
 =?utf-8?B?VHhxWHU2U1dnWVNvOGx3VXFIeStEaFFXUGVxdUt3bVZhNkUza1FOYTVXZjFT?=
 =?utf-8?B?TURhSW4wTW9VNXpTZS9veGljWWVyZVZKRGJYM0ZzQlAwSkZRaDRxWFI5NkU1?=
 =?utf-8?B?c0tXZUNkai9pU29Jd1EwKzY2ZGJtbGgzc01RaHpHMzhEVitDYzFJSGR6ZHFW?=
 =?utf-8?B?cm1ZQUR1QXZ5TTdsYVlZVHV6WHhuVFZBS0NyeEhua0VsRnpTOVpFa3AxYlov?=
 =?utf-8?B?WCtPeXB0UVdnZDM1SmpuTERFSkR0WHZCNE4rME16Y25SNHFmakJsbEtyL1By?=
 =?utf-8?B?Q3o2RTMvS3VlVU9GVTljSEpGbElSVitHbUVDYW9UdFBBTlBHUElDeTF0K3Q2?=
 =?utf-8?B?b2ZVbkEwVVJUQWpsb0xTTWhLUjlDOEVTaWZtK3dZM3AxSGx2eklQZXBlZXAv?=
 =?utf-8?B?dlFFWWthL2VQckVJR0U5bk5Pb3pncnErc1doTjJvOGZ1K2RFL0lJckV2Y0tL?=
 =?utf-8?B?MkNTVnVZemEwQXFkbEdheldSUXUwaHV5WHRLL3hNL25MUG0ycmVnV05QdXVY?=
 =?utf-8?B?TjRzdkhIUG1wQXB2U2tyYWh5SkF3MlFUMmN5Q1dHdjVETUYxYzQ2ME1uNnU3?=
 =?utf-8?B?cEo1UVNpVWZGMWpDRXBwYXlBc0hyay9XMHdoc1NSQnpCSGg4R0pwTFBQOU5G?=
 =?utf-8?B?alE1aElIVzRKdlBVWXNBOVpESGl3U0tPQUl3ZVlDZXhVZFRxYURwOUh6aE9u?=
 =?utf-8?B?RUdEbGwwcitienA0ZHdINmd3Zk9SSnNGNzJqQ2VxbTB1d1pZT3JQSGh1ZVZ1?=
 =?utf-8?B?Zm0yN1ZBQ3FXbXM0bHFqNkhHQVczdlQrWmZidlF3SXNER0tyY21vUldqQ1RV?=
 =?utf-8?B?cVNkNittU05lYzh4T2RQQVFwSVR2ZnlwVkVOMFl3Nmk0NkwrcDlyQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC72345B0A85804F8CC8100D42990D31@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: axpR/WLMMYbE+tozlDFXG9zlaboiN/1g+tPEC0cqdD3XW+u3jPeIMFpIXpHEEzBOfeFx1/tzR586uf5oRqvQuHQdwG/zFxQSZUm9aWE+he/UBTzk9gME08pGq2NiXfp1aayhFiBj6L5CHLFXfMjN7d8HgISL+W0HGZBzVHIUpzwLjTkHOLRtEgBNOcDvH3CBmPnCy0HZdh5co5rylN2kjvrP4c/qcgrUEU2C/RWhonzDQeZmPtz6yrsMRFV6Twam01qwZayClgFuK00I4tmlBlhUxvE8bIM+3fU58VSu0tfwXvJFgiTs90gMuH8koctExPpygMndekO4q/c+UEtjtw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f8d57c-7d32-49dc-e1ac-08def4574164
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 07:41:12.9529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYlZZcj+9N2jzbB12l9JLC9HXHczmlNehekx+IE816YiYlVFbvpSJB74nNJ1PQvJjgfGxPf2w6q634/f1BxIDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8239
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTA2IGF0IDIxOjM5ICswODAwLCBIYW8gWmhhbmcgd3JvdGU6DQo+IEZy
b206IEhhbyBaaGFuZyA8emhhbmdoYW8xQGt5bGlub3MuY24+DQo+IA0KPiBUaGUgSS9PIEFQSUMg
c2V0cyByZW1vdGVfaXJyIGZvciBsZXZlbC10cmlnZ2VyZWQgaW50ZXJydXB0cyB0byB0cmFjayB0
aGF0DQo+IHRoZSBpbnRlcnJ1cHQgaGFzIGJlZW4gYWNjZXB0ZWQgYnkgYSBsb2NhbCBBUElDIGFu
ZCB0aGF0IHRoZSBJL08gQVBJQyBtdXN0DQo+IHdhaXQgZm9yIHRoZSBjb3JyZXNwb25kaW5nIEVP
SSBiZWZvcmUgZGVsaXZlcmluZyB0aGUgaW50ZXJydXB0IGFnYWluLg0KPiANCj4gQnV0IGlvYXBp
Y19zZXJ2aWNlKCkgY3VycmVudGx5IHNldHMgcmVtb3RlX2lyciBmb3IgYW55IG5vbi16ZXJvIHJl
dHVybg0KPiBmcm9tIGt2bV9pcnFfZGVsaXZlcnlfdG9fYXBpYygpLiBUaGUgZGVsaXZlcnkgaGVs
cGVyIGNhbiByZXR1cm4gLTEgd2hlbg0KPiBubyBkZXN0aW5hdGlvbiBpcyBmb3VuZC4gVHJlYXRp
bmcgLTEgYXMgc3VjY2VzcyBjYXVzZXMgS1ZNIHRvIHNldA0KPiByZW1vdGVfaXJyIGV2ZW4gdGhv
dWdoIG5vIGludGVycnVwdCB3YXMgZGVsaXZlcmVkIGFuZCBubyBFT0kgd2lsbCBldmVyDQo+IGJl
IGdlbmVyYXRlZCwgbGVhdmluZyB0aGUgcGluIGJsb2NrZWQuDQo+IA0KPiBTZXQgcmVtb3RlX2ly
ciBvbmx5IHdoZW4gdGhlIGRlbGl2ZXJ5IHJlc3VsdCBpcyBwb3NpdGl2ZSwgaS5lLiB3aGVuIGF0
DQo+IGxlYXN0IG9uZSBsb2NhbCBBUElDIGFjY2VwdGVkIHRoZSBpbnRlcnJ1cHQuDQo+IA0KPiBG
aXhlczogNDkyNTY2M2EwNzljICgiS1ZNOiBSZXBvcnQgSVJRIGluamVjdGlvbiBzdGF0dXMgdG8g
dXNlcnNwYWNlLiIpDQo+IFNpZ25lZC1vZmYtYnk6IEhhbyBaaGFuZyA8emhhbmdoYW8xQGt5bGlu
b3MuY24+DQo+IC0tLQ0KPiAgYXJjaC94ODYva3ZtL2lvYXBpYy5jIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva3ZtL2lvYXBpYy5jIGIvYXJjaC94ODYva3ZtL2lvYXBpYy5jDQo+IGluZGV4
IDc1NzY2N2ZiMmJmYS4uMjRhN2NjM2I4YjdlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0v
aW9hcGljLmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL2lvYXBpYy5jDQo+IEBAIC00OTEsNyArNDkx
LDcgQEAgc3RhdGljIGludCBpb2FwaWNfc2VydmljZShzdHJ1Y3Qga3ZtX2lvYXBpYyAqaW9hcGlj
LCBpbnQgaXJxLCBib29sIGxpbmVfc3RhdHVzKQ0KPiAgCX0gZWxzZQ0KPiAgCQlyZXQgPSBrdm1f
aXJxX2RlbGl2ZXJ5X3RvX2FwaWMoaW9hcGljLT5rdm0sIE5VTEwsICZpcnFlKTsNCj4gIA0KPiAt
CWlmIChyZXQgJiYgaXJxZS50cmlnX21vZGUgPT0gSU9BUElDX0xFVkVMX1RSSUcpDQo+ICsJaWYg
KHJldCA+IDAgJiYgaXJxZS50cmlnX21vZGUgPT0gSU9BUElDX0xFVkVMX1RSSUcpDQo+ICAJCWVu
dHJ5LT5maWVsZHMucmVtb3RlX2lyciA9IDE7DQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiANCj4g
YmFzZS1jb21taXQ6IGMyMWJiNDE5Mzg2OGE4ZGU3MWZjNDY5M2ZhNzQxZTE5NWZkZjVkODYNCg0K
VGhpcyBzZWVtcyByZWFzb25hYmxlIHRvIG1lLiAgSnVzdCB3b25kZXJpbmcgZGlkIHlvdSBtZWV0
IGFueSByZWFsIGJ1Zz8NCg0KQnR3LCBjdXJyZW50bHkgdGhlIElSUSBpcyBzZXQgdG8gaXJyX2Rl
bGl2ZXJlZCBmb3IgbGV2ZWwtdHJpZ2dlcmVkIElSUQ0KcmVnYXJkbGVzcyBvZiB0aGUgcmV0dXJu
IHZhbHVlIG9mIGt2bV9pcnFfZGVsaXZlcnlfdG9fYXBpYygpOg0KDQogICAgICAgIGlmIChpcnFl
LnRyaWdfbW9kZSA9PSBJT0FQSUNfRURHRV9UUklHKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgDQogICAgICAgICAgICAgICAgaW9hcGljLT5pcnJfZGVsaXZlcmVkIHw9IDEgPDwgaXJx
OyAgICAgICAgICAgDQoNCiAgICAgICAgaWYgKGlycSA9PSBSVENfR1NJICYmIGxpbmVfc3RhdHVz
KSB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCgkJLi4uICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCiAgICAgICAgfSBlbHNlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICByZXQgPSBrdm1f
aXJxX2RlbGl2ZXJ5X3RvX2FwaWMoaW9hcGljLT5rdm0sIE5VTEwsICZpcnFlKTsNCg0KCS4uLg0K
DQpTaW1pbGFybHksIHNob3VsZCB0aGlzIG9ubHkgYmUgZG9uZSB3aGVuIGt2bV9pcnFfZGVsaXZl
cnlfdG9fYXBpYygpIHJldHVybnMNCnBvc2l0aXZlPw0KDQpFLmcuLCBrdm1fZ2V0X2lvYXBpYygp
IGNsZWFycyB0aGUgYml0cyBpbiBpcnJfZGVsaXZlcmVkLCBzbyBpZiBvbmUgSVJRIGlzIHNldCBp
bg0KaXQgYnV0IGFjdHVhbGx5IG5vdCBhY2NlcHRlZCBieSBMQVBJQyB0aGVuIGt2bV9nZXRfaW9h
cGljKCkgd2lsbCBub3QgcmV0dXJuIHN1Y2gNCklSUSBpbiBpcnIsIHRoZXJlZm9yZSBpdCBjYW4g
cG90ZW50aWFsbHkgYmUgbG9zdD8NCg0KDQo=
