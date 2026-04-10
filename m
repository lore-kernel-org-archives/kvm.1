Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790B175A69;
	Fri, 10 Apr 2026 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783118; cv=fail; b=s/xj+AJcG1eEdhdqQQgp2GM48jT265vobwev07ksmk1OqlcC4ysNv8D1vZQNpTuHyC/7in1lgrErUMlGU858M6tTibJQvBCor2ARmD/XpQLB+82TDrB0wNr3sUuuCe3QfAyaUQsxfiZpbUARaAQ32IpE2NEKowIebWmuAFjuC3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783118; c=relaxed/simple;
	bh=DEoTZpjmp4PFf9VleXdlnrpbbOPG5kSzYJ8hJO/Q8S0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=skfHl94yNbknbspsel6mql+4VcQd7/bazM4jhQQo6GrLjzYUcoi1EBJdj1Os4WJEMK/cbyovZ9ZVozOPYvtW24wT5E2As4FhlsvK/1fmRB2Fzo96I7WK84UfKJz9mkVNQ+Xh1wQiWHqwn6NkA65a2VrE8UNqbrJkkXmxD2/zlv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwyEfR1y; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwyEfR1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775783117; x=1807319117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DEoTZpjmp4PFf9VleXdlnrpbbOPG5kSzYJ8hJO/Q8S0=;
  b=iwyEfR1yUMOnTkTu2e2Er56Fx1dbsOgVUDc3fa1xw0qYcWgX9o82jTAE
   Cikqz4ayIz4UUl2ywNulN3O2iGK2l8/cZb32FKGKyp3mX5PrIsQtfx4tm
   qpmlpc/u9fVnuUrCTzGyMENNZYU0X0vMopR320bvgHgSFTNfRQB2lzQxH
   itLtdmxH0wEGyMmm9f+bU4idteucH7yNnq2V/ZktF5LY8tGbgNQIqq4dk
   6Y06tmdlRPtv4MEPOzaDzf1T2MXKQut9uIAplh5Hx2971XPalL5jIXTwg
   TZ8AUTtSVqbshU99LhQH4VrczegNfxb5mm4pYoB0zvcxjuqlpjRmuMWRW
   A==;
X-CSE-ConnectionGUID: RSEo2JATT+2sWxtK4oV3mw==
X-CSE-MsgGUID: WYFuvdgVQxWyGNOlXya6SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76984338"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76984338"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 18:05:16 -0700
X-CSE-ConnectionGUID: E09TivjJTLK2FdeBGfzQRA==
X-CSE-MsgGUID: i/QiCkmXTYqeXBspHRGJAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="224198740"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 18:05:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 18:05:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 18:05:14 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 18:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM6QQ3VRB/YCrD9VV+fYrn2Ez+ozOWSf593Zq7FRFXp9vx3pl3iy3z0jx4/0ZAyYyMjvnOb9AAaxnKgcWnlpElQfi5pWLG0rgcgGpkd8n7vYhmqJLuYMab6fLn6jWSvrKtcGYmRF1jNPi7kgzJb5/Cj8lxETTGDGTq0Dtx6VVq+kEmqL8zlWdxqNJafx9Fk2CzyqypbYiQPujehiH3LntSwkZmpL7kL54nL/5e8RSLfXbxaLIhymlbm7r3zIwHzZAys74sAu7WvUaSrwy77yw09xLpsEoR/iSAF0oXOqZ6SxKnE3lzdfv0AQ2+xHdzW4Gp3+N6n9GYmxYcEuzSdo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEoTZpjmp4PFf9VleXdlnrpbbOPG5kSzYJ8hJO/Q8S0=;
 b=hxxG02rZjp3ojG61U/8L6b5yzVUzbqeXCpuUr0A7qyIdOuitUV8yI2K+SZ4O68mDrE/n2MJrSvsPgW59X+pSphuWeKNpBvm1l423ojein08VJsCUNlGeJ1z69SN2j+gsy6NneoeAyPIX0bPuTVxfXRoBhi0CIXUOtXXoUf6tAH9lYWHNZdHrNvlDqkpkSFeaAI6f+tDR4+fpO8t/b1rFjzj8mXS3f9Y3kXJpnJ6udMQA4m4vFw1KltaplGzDI6YvNS3nN2bE65N5Fh5Yxa17b3aP435cQLzZww/htpqLt2SFHBYLr4JuEb8VqOWzKHTLh0w3ImbJqg1qSfJUClrQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.12; Fri, 10 Apr
 2026 01:05:12 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Fri, 10 Apr 2026
 01:05:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "David
 Hildenbrand" <david@kernel.org>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"prsampat@amd.com" <prsampat@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "Qiang, Chenyi" <chenyi.qiang@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: RE: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6ISxXKhFiWKBUuIm+vE1xtYKrW+PPMAgADQbgCAAHNtgIABo7qAgAAlqQCABe0qgIADLMUAgAEXRwCAAJP5gIABJR6AgACYAoCACDwA4IAA6LmAgACgALA=
Date: Fri, 10 Apr 2026 01:05:11 +0000
Message-ID: <IA3PR11MB9136BA4C593C5254EDD9D62092592@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
 <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
 <IA1PR11MB949557E04741169BA209A69EE751A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <9b1290bbc1283a2f35bdcd177d27ae7aea89151c.camel@intel.com>
 <IA1PR11MB94952B22F6EB648ED7C1AE3CE75EA@IA1PR11MB9495.namprd11.prod.outlook.com>
 <f4639348586233245343005708372230f2d4a2cc.camel@intel.com>
 <IA3PR11MB91365041D42CB7F53DA5A98092582@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CAMxuvawVL7-9+8U=Yf7_pJcsbCivgJqFStrXAtAaiBEqtZnc1A@mail.gmail.com>
In-Reply-To: <CAMxuvawVL7-9+8U=Yf7_pJcsbCivgJqFStrXAtAaiBEqtZnc1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB4845:EE_
x-ms-office365-filtering-correlation-id: 75f421a9-5d72-447c-e718-08de969d3786
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8ir5rleIA9W+vbI7ZTtDagJW+FzI04nHc908yJWuWnt7oi+36IkiCYR4S6NwEz+fpQxm3gwTWzBb8qkHj+roMpb9hcP0Ebsowvyc8s7imU8nIx/FJ0PDvx4JFxo6K7zrjK2q4y69HKmUWuSMcPI0dMP3P5gbrZBvXDhYNh9oCaUMFOayJB3aY/7DmGY+ZiwXl6sspxPc9jIB82iyXb2Ol/NwI3SDi4B4UNVtjit9hg5xaLATdKBenxhMQR5yz5HqSB6Ii4vI7V3q5EanhioazwuLgQRr3nohscq3hZO9eMTqpkz8R5/soMPwVj4YAGlXzAlR/r8IH8HlefKoVrJoPR+k3/pR0YgrbLzUgXBVadcg8skXBrjj5ulYj5xoLPqLUzp2MNz83sBcS5DgfICMKG4oVVqse0FGoSNIXJvmS6tBbbpVocNKwydk/88wZHUCrH3w1FRt6VZd1BvcwnRUHIDBXLbfOZfK9m5EUyRTEaS2SSnNb9CibcD+uQK3FJGOHOvWQTCHvf5Gg8I3hj6zV5rps3OLbPmgdhQaOYG1J3+WPBh+MjaiXzMKG+3cJqLXFCpCO0NnuB3B344qs0pRsH0g2q7igAAFD7jngDX0fOg96uDGKsFnmeZlrlhCZBq/PJY9g5vAPGQukStj+BftlTY0BPkDJyUCUWV95NV23SFRGkXUCbxT6i51ePfq+Wg4acD+I9p7txhM/jJQlllGGMtmVZSb6earL/GUFbKl8xJ4juOiibZYgOALFcv32D8dj36qyzDSn6hpFGb/hXx4ef2Zv92P1mDqYfCaetX1nO0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDJSN0x0SHY4YTArMElMWVMwR2NBQ0laRnNpdDNmamdtR3lTYWs0U2RJdWVN?=
 =?utf-8?B?czNrR0UzWVZIOTJXV3VNemhGVmgvK1pJaWlxYjhoajF6SVRGWVk4am13cWhM?=
 =?utf-8?B?NldUREowVTBGNTNXWkE2cHZSalNxS0lhcllVOUFOa3JxOGpxZGdkcm1GTnlD?=
 =?utf-8?B?aStoSGNiVWR4SVdONE1HZnIxOUJUdkwwRlYvdkRZTm50WTBKTVZ5ZWFjQktv?=
 =?utf-8?B?bFo0dDZXZHlSdFRCaUJtTmx4ZnJ5SmFLUUVSbVRYQWN1TnJhaHNFZWt1Zlov?=
 =?utf-8?B?QldoaHYzRUh0TENyVkxDQmo5QUN6VTZ4YUtKMmlQUnNzakRMUm1VdG9CZnRs?=
 =?utf-8?B?d1lVNktlNytlb2FaS0ZyRzNKUTI5UlF6cllSbWo4cHh5TnJFWUhRdVBGU2d4?=
 =?utf-8?B?SDJkV2I3SkE1Uk5BemROK3pBRUdiS2k3S0t4NCtyWjdhOUZkQlhYZXRHOWl6?=
 =?utf-8?B?ZUxOcnVvQ1hqWW9wUTJyRVNXK3FqTEVrTVczZk0yNFN1a3ZVOUx6ZHNuN1E3?=
 =?utf-8?B?WGMrVi9jYVZEWDVVWnpUVjJhSWlzUytGdytRTGhPRVBjMWxjWTQ5cUkxNmZK?=
 =?utf-8?B?QUtDRXV4ZWwrdFBCK3dheHFxOFpDTWkyVDArKzMyREphZTBMUDhTRHlDWHkz?=
 =?utf-8?B?bWJyc2NaQ1hpM0dmMUNsS1FNUnFuUFZyWEt2MlVpekRiZTg3YWhjMDNmS0hL?=
 =?utf-8?B?d0RZY3VMQi9BWDkwWXNKQy9QOGQzcUN5V25VU1lpQkJwaXFVQkNPNkh3ak5o?=
 =?utf-8?B?SGdLUkJZby9hZU1tVWZ0cW9ZZTIvZ0o0dFhLSmZ6TmJwY0NXemV0SVFQTks2?=
 =?utf-8?B?OTRsMGR4V1lQTXZuMytrSVlmYUR0TENZTlVnZW9CY1JEZ1J0MWQ1TXNqU2wz?=
 =?utf-8?B?ODhjY3gzbmZyWUdGSVlXZWIvUmxUMUd5WTh2eE1ReVZUS28rRXZ6d1M3UUlv?=
 =?utf-8?B?UnNXU1BpNXJiUitSZFpxUGJuaEpadm9pbXQ5VmVEclVOU3k3ZVZvZFd4b3hy?=
 =?utf-8?B?WStzNU9tT1VyYVRHbS9wdGcwTFhiTzlmVXNFcFNEVlVqeSt6NDhkMVpGVnpP?=
 =?utf-8?B?K2FRRGg5NGFvODU4RmNBVklyNGFJeWlIM2xLeHBWdkpSekdsWVhyM1dpeFN3?=
 =?utf-8?B?MG10ZWRMdTFUb2dkby8rM1FmU1l2a3MwczhRa09vU1NFNXNGWFdiMVdhbnlF?=
 =?utf-8?B?eHY5bmlCbm5pWEhFcDNWaVNBRTJJYUsvWWpQd0M3MGpUd2FyK3JRT211ODMw?=
 =?utf-8?B?M0p3bjNEMFlwaThMVkh4WDQreUJ1Sm91KzZOZ2dCb0ZmRSthRkpHc3Ric2ky?=
 =?utf-8?B?V01CcFllK3cyVWlIWnhQRFpsdjhqdVdybWhWQVNseUV6ZUhqVDJYVVZlMmZo?=
 =?utf-8?B?S0lQc0dSUTJnL2VKTFB3ZFVXTW5zeGk0aXRsNVpVMzErR3ZhK01XREpwUElt?=
 =?utf-8?B?SzRwV2hGTW1JOTRzcVYwdUJFYkVQMllTcEd4a3VRMW5XNW9XSlZxNFpFZ3Zp?=
 =?utf-8?B?NU53WTZBOFgxa0xqOHRIOUl1Y0dLSzE0Q1dPeHhhSEZ0aUVndTAvdWZkSVNn?=
 =?utf-8?B?dGFFbHdFTFFna3N1UDNFam5VMVZQZnE3VmFDOW9HK1E0dk1tQ1RJU0R0c0Ew?=
 =?utf-8?B?a2dENFc5YU1ZOUhyWkVjYWc1SlozUGF3Ni9LejVtdTFwRVkwV3QxaGFIZndr?=
 =?utf-8?B?bDNuVlcvdGNyS3JtMXBycnlGVEE4TjdDOHQ0aHlJTU03bnBBbXV1MjRxTWJt?=
 =?utf-8?B?Z1h5NlVyWEZkZVd4OXluNmtjSWJZTFJyN0dndHZHeS9WbmpVMU91YWUvQ1pj?=
 =?utf-8?B?Z2ZhRzZxUFlLZGNUeWZ0L2c5TmxyS2kvczRSSUJSalBmMCt4a0lSN0NZNjlu?=
 =?utf-8?B?ZUZJalNIeG1GSkE1ZDBmcWw2a1oyMWlnaGg0WjdGeC9hODhONzBRVmR5Y0JY?=
 =?utf-8?B?U3JkaFllQ1l6VTRLRzBvODJhaEVSWDBpSGF2bWpPamdEVnBOQlFiOXBNWUl0?=
 =?utf-8?B?OFBuWmVjRHVmRWsxYnRPOVpZSUxVejBXci9RYzVOUXJFeVBrYy9hbStpQmRP?=
 =?utf-8?B?c1AzUDlhVVJXSE5SR1BmSXFBVFBPNUtRVFJSRjRvZVFmbE5UL0I4VXk1ZnNQ?=
 =?utf-8?B?L044NzlRbk1VNTdlOG92a3lUVEdRd1NBUUx0RDJqNHV0TmdWRk5zeGxydXYw?=
 =?utf-8?B?RmpWSXF1Vk1vaGZSY1o3aU5TZjVKd0tMUkJKaGpTWjM0RTFvVlhRR1Ntemw5?=
 =?utf-8?B?dUtSNk5wN21pQXY4eGFubTMycTQxYUs1L3Y2S2FZMTNqZDFyU281ZFZGQWUz?=
 =?utf-8?B?UXAyYlFUUTR4UlB3ckFmMGFjcDhFcktYMkRXZHFOZGZkZnB3MU1SZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CzhVx658PfSFtFpEWR7nZoen69S8dx589XiCOrirKyok2dbKFKFGlHgpI4G5JwPrSgPklM2wDMaiZBJ7jPVf7o0HR85kIzrsEODJf3gISgHuRXJf6IyqTBWEMIM+m880O4ZydoEY/f3qy3VBt+ewROUQ5XCPMXIpcoqLeOB286dpfx0lwzWRnynq6ANWiZHbjZhVCkECEY0gQj6b56PNEf4mDeZQUeON4KXXR2zfEIdZ30nITmMW74hQl/nYSaDIbTh+jkR1nTii5dG7bcIuCT/RYBMkHzOTLy+w9he14dQg3vm8XD0pxEEMAWLF//mvGZ6pMEGnOc8wocidmXGZIw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f421a9-5d72-447c-e718-08de969d3786
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 01:05:11.8452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cojoWLKDF71I32xN0GuoA19p+QN8fuPm+aEGq0QYIFcvUZc+CqvaZxCAwg3TPbO9t2ogFL9ExLRQiSdpYdnCbTFqOPeUd0x4E8I4MIhY4cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4845
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hcmMtQW5kcsOpIEx1cmVh
dSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8y
XSB4ODYvdGR4OiBBY2NlcHQgaG90cGx1Z2dlZCBtZW1vcnkgYmVmb3JlIG9ubGluZQ0KPg0KPkhp
DQo+DQo+T24gVGh1LCBBcHIgOSwgMjAyNiBhdCA1OjM24oCvQU0gRHVhbiwgWmhlbnpob25nIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+d3JvdGU6DQo+Pg0KPj4NCj4+DQo+PiA+LS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID5Gcm9tOiBFZGdlY29tYmUsIFJpY2sgUCA8cmljay5w
LmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+PiA+U3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIHg4Ni90
ZHg6IEFjY2VwdCBob3RwbHVnZ2VkIG1lbW9yeSBiZWZvcmUgb25saW5lDQo+PiA+DQo+PiA+T24g
RnJpLCAyMDI2LTA0LTAzIGF0IDEwOjM3ICswMDAwLCBSZXNoZXRvdmEsIEVsZW5hIHdyb3RlOg0K
Pj4gPj4gPiA+ID4gU28gdGhlIHBhcnQgYWJvdXQgd2hldGhlciBhIHRyaWdnZXJlZCBhY2NlcHQg
c3VjY2VlZHMgb3IgcmV0dXJucyBhbg0KPj4gPj4gPiA+ID4gYWxyZWFkeSBhY2NlcHRlZCBlcnJv
ciBpcyBhbHJlYWR5IHVuZGVyIHRoZSBjb250cm9sIG9mIHRoZSBob3N0LiA+ID4NCj4+ID4+ID4g
PiA+IEkuZS4sIGlmIHdlIGRvbid0IGhhdmUgdGhlIHplcm9pbmcgYmVoYXZpb3IsIHRoZSBob3N0
IGNhbiBhbHJlYWR5ID4gPg0KPj4gPj4gPiA+ID4gY2F1c2UgdGhlIHBhZ2UgdG8gZ2V0IHplcm9l
ZC4gU28gSSBkb24ndCB0aGluayBhbnl0aGluZyBpcyA+ID4NCj4+ID4+ID4gPiA+IHJlZ3Jlc3Nl
ZC4gQm90aCBjb21lIGRvd24gdG8gaG93IGNhcmVmdWwgdGhlIGd1ZXN0IGlzIGFib3V0IHdoYXQg
aXQgPiA+DQo+PiA+PiA+ID4gPiBhY2NlcHRzLg0KPj4gPj4gPg0KPj4gPj4gPiBZZXMsIGFuZCBt
eSBwb2ludCBpcyB0aGF0IHdlIHNob3VsZCBub3QgYWxsb3cgZ3Vlc3QgdG8gZnJlZWx5IGRvdWJs
ZQ0KPj4gPj4gPiBhY2NlcHRpbmcgZXZlci4NCj4+ID4+ID4gRm9yIGFueSB1c2UgY2FzZSB0aGF0
IHJlcXVpcmVzIHJlbGVhc2luZyBtZW1vcnkgYW5kIGFjY2VwdGluZyBpdCA+IGJhY2ssIGl0DQo+
PiA+PiA+IHNob3VsZCBiZSBleHBsaWNpdCBhY3Rpb24gYnkgdGhlIGd1ZXN0IHRvIHRyYWNrIHRo
YXQgbWVtb3J5ID4gaGFzIGJlZW4NCj4+ID4+ID4gInJlbGVhc2VkIiAodW5kZXIgY29ycmVjdCBh
bmQgc2FmZSBjb25kaXRpb25zKSBhbmQgdGhlbiBpdCA+IGlzIG9rIHRvIGFjY2VwdA0KPj4gPj4g
PiBpdCBiYWNrIChldmVuIGlmIGl0IGRvZXNudCBtZWFuIHBoeXNpY2FsbHkgYWNjZXB0aW5nID4g
aXQpIGFuZCBpbiB0aGlzIGNhc2UNCj4+ID4+ID4gaXQgaXMgb2sgKGFuZCBldmVuIHN0cm9uZ2x5
IGRlc2lyZWQpIHRvIHplcm8gdGhlID4gcGFnZSB0byBzaW11bGF0ZSB0aGUNCj4+ID4+ID4gbm9y
bWFsIGFjY2VwdCBiZWhhdmlvdXIuDQo+PiA+DQo+PiA+SG1tLCBpdCBkb2Vzbid0IHNlZW0gbGlr
ZSB5b3UgZW5nYWdlZCB3aXRoIG15IHBvaW50LiBPciBhdCBsZWFzdCBJJ20gbm90DQo+PiA+Zm9s
bG93aW5nIHdoYXQgaXMgZXhwb3NlZD8NCj4+ID4NCj4+ID5TbyBJJ20gZ29pbmcgdG8gYXNzdW1l
IHlvdSBhZ3JlZSB0aGF0IHRoaXMgcHJvY2VkdXJlIHdvdWxkIG5vdCBvcGVuIHVwIGFueQ0KPj4g
PnNwZWNpZmljIG5ldyBjYXBhYmlsaXRpZXMgZm9yIHRoZSBob3N0IHRoYXQgZG9uJ3QgZXhpc3Qg
dG9kYXkuIEFuZCBpbnN0ZWFkIHlvdQ0KPj4gPmFyZSBqdXN0IHNheWluZyB0aGF0IHRoZSBndWVz
dCBzaG91bGQgaGF2ZSBpbmZyYXN0cnVjdHVyZSB0byBub3QgZG91YmxlIGFjY2VwdA0KPj4gPm1l
bW9yeSBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+PiA+DQo+PiA+QnV0IHRoZSBwcm9ibGVtIGhlcmUg
aXMgbm90IHRoYXQgdGhlIGd1ZXN0IGxvc2luZyB0cmFjayBvZiB0aGUgYWNjZXB0IHN0YXRlDQo+
PiA+YWN0dWFsbHkuIEl0IGlzIHRoYXQgdGhlIGd1ZXN0IHJlbGllcyBvbiB0aGUgaG9zdCB0byBh
Y3R1YWxseSB6YXAgdGhlIFMtRVBUDQo+PiA+YmVmb3JlIHJlLXBsdWdnaW5nIG1lbW9yeSBhdCB0
aGUgc2FtZSBwaHlzaWNhbCBhZGRyZXNzIHNwYWNlLiBTbyB0aGUgZ3Vlc3QgaXMNCj4+ID50cmFj
a2luZyB0aGF0IHRoZSBtZW1vcnkgaXMgcmVsZWFzZWQgY29ycmVjdGx5LiBCZXR0ZXIgdHJhY2tp
bmcgd2lsbCBub3QgaGVscC4NCj4+ID5JdCByZWxpZXMgb24gaG9zdCBiZWhhdmlvciB0byBub3Qg
aGl0IGEgZG91YmxlIGFjY2VwdC4NCj4+ID4NCj4+ID5URFggY29ubmVjdCB3aWxsIHVzZSB0aGlz
ICJ1bmFjY2VwdCIgc2VhbWNhbGwsIHNvIEkgYXNrZWQgWmhlbnpob25nIChDY2VkKQ0KPmhvdw0K
Pj4gPm11Y2ggb2Ygd2hhdCB3ZSBuZWVkIGZvciB0aGF0IHNvbHV0aW9uIHdpbGwganVzdCBnZXQg
YWRkZWQgZm9yIFREWCBjb25uZWN0DQo+PiA+YW55d2F5LiBJdCBzZWVtcyBsaWtlIHdlIHNob3Vs
ZCBtYWtlIHN1cmUgdGhlIHNhbWUgc29sdXRpb24gd2lsbCB3b3JrIGZvciBib3RoDQo+PiA+U05Q
IGFuZCBURFggYW5kIGtlZXAgdGhlIG9wdGlvbnMgb3BlbiBhdCB0aGlzIHN0YWdlLg0KPj4NCj4+
IEZvciB0aGF0IHNvbHV0aW9uLCBhbmFsb2cgdG8gaG90cGx1ZywgVERYIENvbm5lY3QgbmVlZHMg
YSBob3QtdW5wbHVnIGhhbmRsZXIgdG8NCj4+IHVzZSAicmVsZWFzZSIgc2VhbWNhbGwgdG8gdW5h
Y2NlcHQgcHJpdmF0ZSBtZW1vcnkgYmVmb3JlIHVucGx1ZywgdGhhdCdzIGl0LiBCdXQNCj4+IGlm
IHRoZSB6YXBwaW5nIFMtRVBUIHdpbGwgbm90IGhhcHBlbiBpbiBob3N0LCBJIHRoaW5rIHRoaXMg
InJlbGVhc2UiIHNlYW1jYWxsIGlzIGFsc28NCj4+IHVubmVjZXNzYXJ5IGZvciBURFggQ29ubmVj
dC4NCj4+DQo+PiBJIGFsc28gaGF2ZSBhIHNpbGx5IHF1ZXN0aW9uIHdoaWNoIEkgbG9va2VkIG92
ZXIgdGhpcyB0aHJlYWQgYW5kIGRpZG4ndCBmaW5kIGFuc3dlci4NCj4+IERvIHdlIGhhdmUgdG8g
c3VwcG9ydCBwcml2YXRlIG1lbW9yeSBob3RwbHVnLCB3aGF0IGJlbmVmaXQgd2UgZ2V0IHRvIHN1
cHBvcnQNCj5pdD8NCj4+IElmIHdlIG9ubHkgYWxsb3cgc2hhcmVkIG1lbW9yeSBwbHVnL3VucGx1
ZyB0byBURCwgdGhlbiB3ZSBkb24ndCBuZWVkIHRoaXMNCj5zZXJpZXMuDQo+PiBHdWVzdCBkZWNp
ZGVzIHRvIGNvbnZlcnQgc2hhcmVkIG1lbW9yeSB0byBwcml2YXRlIGFmdGVyIHBsdWcgYW5kIGRv
IHRoZQ0KPm9wcG9zaXRlIGJlZm9yZSB1bnBsdWcuDQo+PiBUaGlzIHdvcmtzIGZvciBib3RoIFRE
WCBjb25uZWN0IGFuZCBtZW1vcnkgdW5wbHVnIGFzIG1lbW9yeSByZWxlYXNlIGlzDQo+aW1wbGlj
aXRseSB0cmlnZ2VyZWQNCj4+IGluIG1lbW9yeSBjb252ZXJ0Lg0KPg0KPkkgZGlkIHNvbWUgc3Vj
Y2Vzc2Z1bCBleHBlcmltZW50cyB3aXRoIG1vZGlmaWVkIFFFTVUgJiBrZXJuZWwsIHRoaXMNCj5z
ZWVtcyB0byB3b3JrLg0KDQpHb29kIHRvIHNlZSwgdGhhbmtzIGZvciB2ZXJpZnlpbmcuDQoNCj4N
Cj5PbiB2aXJ0aW8tbWVtIHBsdWcsIHNldF9tZW1vcnlfZW5jcnlwdGVkKCkgbWFrZXMgdGhlIG1l
bW9yeSBwcml2YXRlICsNCj5hY2NlcHRlZC4gT24gdW5wbHVnLCBtYWtlIGl0IHJldHVybiB0byBz
aGFyZWQgd2l0aA0KPnNldF9tZW1vcnlfZGVjcnlwdGVkKCkuIFFFTVUgaGFuZGxlcyBSRVFfVU5Q
TFVHIGFuZCBjYW4gcHVuY2ggYm90aA0KPnNoYXJlZCAmIGd1ZXN0X21lbWZkIHBsYW5lcyAod2hp
Y2ggd2lsbCBUREguTUVNLlBBR0UuUkVNT1ZFKS4NCj5SZS1wbHVnZ2luZyBhbHNvIHdvcmtzIGZp
bmUuDQoNCklmIGd1ZXN0IGNhbGxlZCBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIG9uIHVucGx1Zywg
UUVNVSBwdW5jaGluZw0KZ3Vlc3RfbWVtZmQgaW4gUkVRX1VOUExVRyBpcyB1bm5lY2Vzc2FyeSBh
cyBpdCdzIGFscmVhZHkgdGFrZW4gZHVyaW5nDQptZW1vcnkgY29udmVydC4gU28ganVzdCB0byBj
b25maXJtLCB5b3Ugd2FudCBRRU1VIHRvIHRha2UgY292ZXIgdGhlIGNhc2UNCndoZW4gZ3Vlc3Qg
ZmFpbGVkIG9uIHNldF9tZW1vcnlfZGVjcnlwdGVkKCkgb3IgbmV2ZXIgY2FsbGVkIGl0Pw0KDQo+
DQo+VGhlIHZpcnRpbyBzcGVjIHNob3VsZCBwcm9iYWJseSBiZSB1cGRhdGVkIHRvIGV4cGxpY2l0
bHkgZGVmaW5lIHRoZQ0KPnNoYXJlZCBzdGF0ZSBvbiB1bnBsdWcgYW5kIHRoZSBwcml2YXRlIHN0
YXRlIG9uIHBsdWcsIGRyaXZlbiBieSB0aGUNCj5ndWVzdC9kcml2ZXIuIFRob3NlIGFyZSBLVk0g
bWVtb3J5IGF0dHJpYnV0ZXMsIEkgc3VwcG9zZSB0aGlzIGlzDQo+Z2VuZXJpYyBlbm91Z2guDQoN
Clllcy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==
