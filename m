Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793663443;
	b=K/hlS93mWZniMpEUi/PlKF3LQ736XNjJFGlNFJFJGoRcle/bc99vfQ2mmXiTacmznVQj
	 czNkc6qabpCK8uuJPmUlKfXOAY2cjYxGO7mlJ8bEvQvyIC0/B6cpO1MPc7fl/qibE5XO2
	 HRSAvyOcIeb1X62ob5N5lC6XRwSmPS4KfJMK04X6xychTo+XBP/KBBbbqYzh5XPIcj+OQ
	 n7q2rdaXxfRmAqvzdKrqgTV5JCwKSG29rIoTRBBmnorOFyFzE9h/mf0dfk6L8tG6ARYej
	 gLagStHeahTUltT6CKjtKOy1zaaRIrfe5YscPyMUg49YhgW6gwgN3nrZ9bfY8Y3Gi8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663443;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
	bh=nw6mvW+IZt7NxxfzXsWiPnPNW/8b9DcOgP0ZxTt3ZAk=;
	b=Mnvl3KB6dyY+C15FyMTvmSSn6B0znIxMhWD4w9VF+PVrVgm6H2ZV73I3I6uRIpuSdLUx
	 hRFA50HWOYDQxDhStqSN5M1hXWH6FW4DMezpZ8OGxHVXpFIZ77VkoHEzhdxtM46oAiKgq
	 lJFG+7iOEoTmbi9HFQgX6V+nkoJTyEhcPjuB38ugrAYaisQLtF4fQ9DzdHN40a10XHO3B
	 mG7DzInHLWLQBIGQYhwgS1oAkERHwAAyzO5SAOgjl1uH4+eaObkqU9viZuYODry0YddGX
	 YitzC+nJjePwcQ3ST8MJhtcnQN8tqFTKqOgMZKri9MbjCgEBH1/AUy5WXPFYM7QRgKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lbcq4RKN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE863606A326;
	Mon,  2 Nov 2026 23:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE863606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lbcq4RKN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793663442; x=1825199442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nw6mvW+IZt7NxxfzXsWiPnPNW/8b9DcOgP0ZxTt3ZAk=;
  b=Lbcq4RKNqm3u52kbOatuj48GxH+IUXAqBa0fxqoLaymTyeRf+6KC6CtY
   HqpxFRS+2ZnXtx7UQH0AKODjqozHz4SXXgajVO/QxEZNLxremzkq0T0Tv
   TnxrghDXMJd8vdsDcwC3AZUWnmuIVt3/+40XxZ35JSxSc29fYw2w32ocn
   v1kqUE4Q/pixfBvKT8uT3G2gFP3Y9H2VgbNP4hvblLOsftHgFkI+egzVx
   inp4gxI/BIeI6PsAM8Id2xBp8TVk8WDZKbWS/YcjM8PzYFTbKqUE9B33T
   f51dKMwBW4z/3a/3N0r1pjVoewxCE2AokokcTbgMpzpJBQis3z3oM6glf
   g==;
X-CSE-ConnectionGUID: EjCJpCR6TsyEQYCznsNkNw==
X-CSE-MsgGUID: 5DrUBk7pRqG8x8xhuoHNdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2478427"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2478427"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 15:50:41 -0800
X-CSE-ConnectionGUID: +gNARjEFS7WsM62Lu+50uA==
X-CSE-MsgGUID: 4F7GASe4Rq+1oRNdZTNQsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="8042929"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 15:50:41 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 15:50:40 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 15:50:40 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 15:50:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0bvNsbSDjTyQIjoHG1ymmJlLKicpjQxSFnUFOT8CXU+YTQB2sV11zWgDrK9UEVR/EA85L0PxDuxBFTcg8tldzQ0WYwmEccdLGSvls0E+/ojPFDNL4Lr+qPyf+56le33aYeYW2tPleSxoX6q7omrzMXrt0SubwXkztpkXb8M1vyafe9reUFoyBGcMz98Exo3eF/zcZgMdQJMOhbsIHmY/c7TVWOo9ds2sjD7G/IVJd217wbwpYOCZQiA/eHkcGyjaF17qdA9WZamlftp9xo5QHIsRaxnqlwZgiRqHSHjA63adX1qlVNs7FKOCJslODwyZ1cGSMWfZAAyRAibNZ7IQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw6mvW+IZt7NxxfzXsWiPnPNW/8b9DcOgP0ZxTt3ZAk=;
 b=yj6d1H10wAkbaga0+zdT7MJcMdkMWKTY010CnqDL3VgbYAWO4lBNkQ+FIStoABeDkCHiCaU2Ok40SQk7u7NixXcLAJzYFAuXqUKXVrDGI7SjdSU/Lr6b/cwbk/vHlQjfbzTQKL55DEPPWJIOOEF9fEj+qA3eW8o2xJKeH96135jzHiBl2X8iOzlT9Bk/AH49FsWW3Eoe5RRD0eSYWQWAxrcDo7VMOrPJ3DkwnVQ25FaATzi0Ogw0gosUPetWHnawDLa+OOc8bpXiOx8f2qXZyphlDX3crQFGfHU7nSW821giOGuOGXeQ5FDVMYKwr5MI3F/fsPck3g5S9mK1RRQUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by PH0PR11MB4919.namprd11.prod.outlook.com
 (2603:10b6:510:34::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 23:50:36 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 23:50:36 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org"
	<kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v1 0/3] TDX: P-SEAMLDR: Support large TDX modules and
 sigstructs
Thread-Topic: [RFC PATCH v1 0/3] TDX: P-SEAMLDR: Support large TDX modules and
 sigstructs
Thread-Index: AQHdaEwq4W5hmf6FCEWzFoLavLm71bcbeU+A
Date: Mon, 2 Nov 2026 23:50:36 +0000
Message-ID: <82be61b9a3f2c12b8e4a804bfa6dc4a0fbe9bd44.camel@intel.com>
References: <20261030085304.3886520-1-chao.gao@intel.com>
In-Reply-To: <20261030085304.3886520-1-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|PH0PR11MB4919:EE_
x-ms-office365-filtering-correlation-id: cbbcfad0-8fe8-40b3-0dba-08df393c1784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|261102123227099003|10067099003|261009223027099003|261022115727099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|11063799006|38070700021|261028144727099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info: e5tRa20gL8PDfMaVP331gA9/zU6lSOWrTDs/DbP5T26AW27UywssUqCDslsDWoYrV59vqnNHpMocFoXbOoWBOVAMxiTp9xKs7gJfYCvT07iEwAlqCzkWBPYzEMHkTCxd38ML6yhXilTlrcqijthYOeHMnedDTMi7SfXo+3cCfyUPv+/UAXN9E+pn+X5RnVsGzkKMKesw2jjyGV9/nUzzoZM1Xe2Mw3aDWJc7yzwFbeKEr6cBZY8K6KNCrqpyA3P/WkBP2xFLQmd+TW1n3adcdPUIT2TLQT2t5pg/P//kVZ9R8cuqd8I5e24ZTnsO85cU4CsYNerhvTACPKCiAMqd7RJJ/pZneFjrmCHjsYCPTBnFZg4F/oULsYGMbLWWcMlNnWxWLsL8JY3QT31MdPWUD/V304CMVTDiLEWGyy/s7+Ju1W+2HifVBimUHix6x9IxLvdN/qWdeOralMKB6xHe18KlAKeQY2YboWA/QCjoZAVP4RcM9+RyD11NytdoSMZ9dxJ7I2EIqL5hbiWNH1M8rrFb/86IYbLIbO019z/o0kppI2y8LXmFKakwqlrlSuU2jN9owmCYqMBJ9oNhSOIBZv+5Us+BihkbTsZnNh19bqdF/kHvtFhhCuySR85ydpIi0tFlFzDiQAxuIvhH/HmOZ80S0WOsEOiQipzvpIVvgLh3tpfSnMvV8XMwPMYH4Ywt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(261102123227099003)(10067099003)(261009223027099003)(261022115727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(11063799006)(38070700021)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUEydzJWc3RiVkRzZmVWMURNSTVQZzlicGZ0TkErTEpGaDRtSEF5OWE5RTN1?=
 =?utf-8?B?QUZ2VkdZenhPeWFxQjN3eXN0YVpUU21IK1R0Nkw2UmJOd1VkdlRDdHR3ZGg5?=
 =?utf-8?B?TmNieXE5bzk3TmRTUjBFK1FJQjJXQUh1cGFNVTFjWHZMMURxNUdHZmJNaDFO?=
 =?utf-8?B?MjdobDI2dUE0eEt1WGcvdDJMRVhFVjI1RnVHdmdQcFFtOUhnWTZndHJMUit6?=
 =?utf-8?B?cWVLdzV4UXRtOFFvaUVBRUpMSnFWYzFIa256N014enhreVVLZE0xN3lkdVJ1?=
 =?utf-8?B?V2l5Yi8yeWs2UFpvUUNITGFvQ2V6WFBQbm1lQ3pUVHJ6N0V0bCtHNGxNakhD?=
 =?utf-8?B?ejc4LzJlQXhIYW5FWTVJVGNMU2tJeEN5VGNMT29sRVhFSGRvTVN2NURhUHhD?=
 =?utf-8?B?UlJNUGFQelp2cDV3WnNsOHU0dHJnUm13R1Q5anVKeTNjWXVabnY4b252elVW?=
 =?utf-8?B?VjFySkE1MGpSaUhZVk8rNmliOGFRRDFiNTlGZWVUTGRnTFAvMVhsL3BRTTZ4?=
 =?utf-8?B?WWg3eU9FeENUZEQxWG9zR0Y5VWIxaENrdzdjcnNrT0lpeXh2ZGJGUUI4WGlI?=
 =?utf-8?B?em4valJDQWg1M0ZjOG5sa3hxY255L05ZM1BWd29Xd01xYXZJRjAyM09SWjNv?=
 =?utf-8?B?bzY0M2E3WnBiR1ZKTTBXU25XOTViRFROck1IUGtWN0NabDRnUG1UYUh0cFhS?=
 =?utf-8?B?QWFEOFZGUVZUR2tRQWFqWjdraUU3cnlaYlNGQzNOZFRuV1FLclo2TVBsbnlL?=
 =?utf-8?B?UWRpZGxucUowVzhQMzNqdCsyUXRIdk15aEtMWjVxK0lBN2Racy85YTdQNGMr?=
 =?utf-8?B?RTZSUWZWNGR2YVNtQVZMZU9PaG5hNHpuUjdNSkJyOEE4bEwyYkxZL05Oa2My?=
 =?utf-8?B?QmVJemsrNzJ2Z2NpZVJhSG5iMkxaNkJ2eVYvaVpKKzVpbmoxc0FPS3hnUkdn?=
 =?utf-8?B?WjNOdGxKSXZqUDVqUk4xMGhLL3NTTnprR2pYeGxVK1FPaWUyVmZZU0NDTjdh?=
 =?utf-8?B?YytHbUFuR2NYby9uakJiTmp3c1BNR2xLWXBqbmRYRjBNd0xZYlN1cStRSW0r?=
 =?utf-8?B?KzBCY2xySFZNbGlHU3U4SkhmM0tBMElRT1YySDFadjVzZVRvdEpUdno2OXFp?=
 =?utf-8?B?M2J1cjZKeENjUHo3SkNETTBwK0FHUFV3WmtWL3FoVlEySEdpMWdnZHk3K0tL?=
 =?utf-8?B?ZjZSU0hEQnpnUlhDNjR1VWtlWEFqZ2Fib1FyT0pqTWVHeCtjYlhRbFVUNCtF?=
 =?utf-8?B?dDAreGkxM1pqaEN5Q0VpdEpONzIzZm9BajZBNmNJRlNoMnk4TE5uTDZFZ004?=
 =?utf-8?B?eFNwbU5IaUxaSk4vYmcrT0Y0eklDZmZRVUt1MGZsWEVzb1BjVXQ1Y2VvVEt2?=
 =?utf-8?B?SmErdWdjMkIxTHFjd2d5ZGJyQVZ2azRML1BSQllDc2FWd1B6QnlXTHFPMWF0?=
 =?utf-8?B?d1V4Tkx2cHl1bWJ6em1TdjBsNEV3QnlTbFNSQ2h3cDlCclJYREZMK3FMSFFh?=
 =?utf-8?B?ZTE4U0FBVjBkbTgzU09BVkJGTEEwM0dMYkRNeVRsejNtS0swbEovL3Ryalhv?=
 =?utf-8?B?cmprWGpWOWlFZWs3M0JVOE9hYVZtSkgrZVZiamRxRER0TXlaQ0wzM2MvS1lF?=
 =?utf-8?B?QTlqc2oySXhFNWovSnovc0dCRE44NUVlclFlc1cwbml3eVlIMjBvcTZtMWtq?=
 =?utf-8?B?a1hBV0hMWkhpd2dxV01jbVlnQXVLN2lmTThBeC9QVTBOQU1qcFQybm1RWmdh?=
 =?utf-8?B?NWVJTzhacEV2VDBWQUU4OHRqQ3J1bWtjUzNpeGVGTTUwSXZSNWlTaFdaNk1s?=
 =?utf-8?B?VE9FNUFzTFo0NmJZaXR0NTVzNnF2STYzZStVUCszNXN3aGcxM1FsaWZ2RTNE?=
 =?utf-8?B?TEl3QmZjNGFTVHVQZXB1WG9IL2JxNkVYaVdzQW0rUlhMTlJBYmZNU2JZVDRl?=
 =?utf-8?B?d3VXcGFxekVpMHovV1JKRXphY2Q1VDBja2dOUmNOMjRuVlNvcHNyMml2VEhB?=
 =?utf-8?B?RXJ6b0dscDBXV0dPNHoyS0wreXA0TTVud0VRK3VzK05SclB2TndwWllYSGpC?=
 =?utf-8?B?aEQ4MVhiRFdBVGV0ZEZRa05rTXh2WStnOGppQ1ZsbDlHc250d3pkSE94UFpB?=
 =?utf-8?B?ak50RHExeXNDblRsMUJWanZUUGtocjNMbi9MTHMvL2htTFNxcE1xaDB4L2xY?=
 =?utf-8?B?UW51VTllZFZJOE5YZ2tTbXY5a0Q5aDUxQ2hvQmtsWmtOZ1FHaUxCUzYySlZQ?=
 =?utf-8?B?UFlQQ2VwaFFGenEvdnBzKzB5dVFPdHJPNWE2QURuMVhhMURCYkZoa1JhZ3hC?=
 =?utf-8?B?dCtKa3RkRU0wejc2VnUrclVCSVFyaEY0aDh3TDNUanYzWUcyY084L2c5T3pu?=
 =?utf-8?Q?vq7washG7ERgi35c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03E8CD40E2CE494C848510D92899E66F@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: sztw9Upz4gWVu3xzJnFkdVdCdb+xSopxJ6p7D5UONUUrSiu4Dhn2QecW58dyY55yrD87uAFEpKYVXy6VocA5+tothnSUxx1nuZjcGD2jI6DCZFC5IOjRti0OUO0W6HxwX10WFextPXHaHZOkGY1w80IO3vXxCsfJgsXemiHn6WDx5C0j3ruA6rAKmOBh6gCK5On0+PV70B4G1uk+1MtHHZ6zBYZ9HQI2/5+/otjM7AZfsV25rKXhzlVRo1GKXK9ZlY7oAmf7EdqpPZVtWZpNYB1Ray3jWJLxhOYirUFcyL6yCQ7d+opdEi4Mc/Qh2NLguYAC3DjACKRt3PHVMCuR+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbcfad0-8fe8-40b3-0dba-08df393c1784
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 23:50:36.5025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RW43lKzcIC4XN98QnQLwk0sJam7UfRWBAytb9b5iL2ouple4tQp3E0aRGC2U9xzVui1ATncdJU+bAwvI9xOAQVUyLluD8M5p6yKZHeazARY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4919
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTMwIGF0IDAxOjUyIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhp
cyBzZXJpZXMgbGV0cyBURFggbW9kdWxlIHVwZGF0ZXMgaGFuZGxlIGxhcmdlIFREWCBtb2R1bGVz
IGFuZA0KPiBzaWdzdHJ1Y3RzLiBJdCBpcyBhbiBSRkMgZm9yIGVhcmx5IHJldmlldy4NCj4gDQo+
IERhdmUsIGZlZWwgZnJlZSB0byBpZ25vcmUgdGhpcyBSRkMgZm9yIG5vdy4gVERYIGRldmVsb3Bl
cnMsIHBsZWFzZSB0YWtlDQo+IGEgbG9vay4NCj4gDQo+IEkgd291bGQgZXNwZWNpYWxseSBsaWtl
IGZlZWRiYWNrIG9uIG9uZSBxdWVzdGlvbi4gRG9lcyB0aGUga2VybmVsIG5lZWQNCj4gdG8gdGVs
bCB1c2Vyc3BhY2UgdGhhdCBpdCBzdXBwb3J0cyBsYXJnZSBtb2R1bGVzIGFuZCBzaWdzdHJ1Y3Rz
PyBJIHdvdWxkDQo+IHJhdGhlciBub3QgYWRkIHN1Y2ggYW4gaW50ZXJmYWNlLg0KPiANCj4gVXNl
cnNwYWNlIGNhbiBzaW1wbHkgdHJ5IHN1Y2ggYW4gaW1hZ2UsIGJlY2F1c2UgYSBrZXJuZWwgd2l0
aG91dCB0aGlzDQo+IHNlcmllcyByZWplY3RzIGl0IHdpdGggLUVJTlZBTCBiZWZvcmUgY2FsbGlu
ZyBQLVNFQU1MRFIsIHNvIGEgZmFpbGVkIHRyeQ0KPiBoYXMgbm8gc2lkZSBlZmZlY3RzLiBJZiB1
c2Vyc3BhY2Ugc2hvdWxkIG5vdCBoYXZlIHRvIHRyeSBhbiB1cGRhdGUgdG8NCj4gZmluZCBvdXQs
IHRoZSBhbHRlcm5hdGl2ZSBpcyB0byBiYWNrcG9ydCB0aGlzIHNlcmllcyB0byBhbGwga2VybmVs
cyB0aGF0DQo+IHN1cHBvcnQgVERYIG1vZHVsZSB1cGRhdGVzLiBVc2Vyc3BhY2UgY291bGQgdGhl
biBhc3N1bWUgdGhhdCBhbnkga2VybmVsDQo+IHdpdGggVERYIG1vZHVsZSB1cGRhdGVzIGhhbmRs
ZXMgc3VjaCBpbWFnZXMuDQoNClNvdW5kcyBnb29kIHRvIG1lLg0KDQo+IA0KPiA9PT09DQo+IA0K
PiBUaGlzIHNlcmllcyBpcyBhIGZvbGxvdy11cCB0byB0aGUgVERYIG1vZHVsZSB1cGRhdGUgc2Vy
aWVzLiBBcyB0aGFua3MNCj4gZm9yIG1lcmdpbmcgdGhhdCBzZXJpZXMsIHdlIGFncmVlZCB0byB0
YWtlIG9uIHRoZSBURFggbWV0YWRhdGEgY2xlYW51cCBbMV0uDQo+IFdpdGggdGhlIGNsZWFudXAg
Y29udmVyZ2luZywgd2UgYXJlIHN0YXJ0aW5nIG9uIHRoaXMgd29yayBhbmQgZXhwZWN0IGl0DQo+
IHRvIGJlIG1lcmdlZCBhZnRlciB0aGUgY2xlYW51cC4NCj4gDQo+IFRvZGF5IGEgVERYIG1vZHVs
ZSBiaW5hcnkgY2FuIGJlIGF0IG1vc3QgNDk2IHBhZ2VzIGFuZCBpdHMgc2lnc3RydWN0IGF0DQo+
IG1vc3Qgb25lIHBhZ2UuIEJvdGggbGltaXRzIGNvbWUgZnJvbSB0aGUgUC1TRUFNTERSIEFCSS4N
Cj4gDQo+IFREWCBtb2R1bGVzIGFyZSBvdXRncm93aW5nIHRoZW0uIEEgcG9zdC1xdWFudHVtIHNp
Z25hdHVyZSBhbGdvcml0aG0NCj4gcHVzaGVzIHRoZSBzaWdzdHJ1Y3QgcGFzdCA0S0IsIGFuZCBu
ZXcgbW9kdWxlIGZlYXR1cmVzIHB1c2ggdGhlIGJpbmFyeQ0KPiBwYXN0IDQ5NiBwYWdlcy4gVGhl
IFAtU0VBTUxEUiBBQkkgd2FzIGV4dGVuZGVkIGZvciBib3RoLg0KPiANCj4gVGhlIGtlcm5lbCBy
ZWplY3RzIGFueSBpbWFnZSBvdmVyIHRoZXNlIGxpbWl0cy4gVERYIG1vZHVsZXMgZm9yIERpYW1v
bmQNCj4gUmFwaWRzIGV4Y2VlZCB0aGVtLCBzbyB3aXRob3V0IHRoaXMgc2VyaWVzLCBURFggbW9k
dWxlIHVwZGF0ZXMgZmFpbCBvbg0KPiBEaWFtb25kIFJhcGlkcy4gVGhpcyBzZXJpZXMgaXMgYWxs
IHRoYXQgaXMgbmVlZGVkIHRvIG1ha2UgdGhlbSB3b3JrLg0KPiANCj4gVGhlIGltYWdlIGZvcm1h
dCB0aGF0IHVzZXJzcGFjZSB1cGxvYWRzICgnc3RydWN0IHRkeF9pbWFnZScpIGlzIGdlbmVyaWMN
Cj4gZW5vdWdoIGFuZCBuZWVkcyBubyBjaGFuZ2UuDQo+IA0KPiA9PSBBSSBVc2FnZSA9PQ0KPiBB
SSB3YXMgdXNlZCB1bmRlciBzdXBlcnZpc2lvbiB0byByZXZpZXcgY29kZSBhbmQgd29ya3Nob3Ag
bG9ncy4gSXQNCj4gc3BvdHRlZCBhIHUzMiBvdmVyZmxvdyBhbmQgYW4gb3ZlcnNpemVkIGFsbG9j
YXRpb24gdGhhdCByZW1vdmluZyB0aGUgNDk2DQo+IHBhZ2UgY2FwIHdvdWxkIGNhdXNlIGluIHBh
dGNoIDIuIFRoZSBtb2R1bGUgc2l6ZSBsaW1pdCBpbiB0aGF0IHBhdGNoDQo+IHByZXZlbnRzIGJv
dGguIEl0IGFsc28gc3VnZ2VzdGVkIHJlbmFtaW5nIGluaXRfc2VhbWxkcl9wYXJhbXMoKSBpbg0K
PiBwYXRjaCAxIGFuZCB1cGRhdGluZyB0aGUgY29tbWVudHMgYXJvdW5kIGl0Lg0KPiANCj4gPT0g
VGVzdGluZyA9PQ0KPiBUZXN0ZWQgb24gYSBEaWFtb25kIFJhcGlkcyBzeXN0ZW0uIFVwZGF0ZXMg
d2l0aCBhIG1vZHVsZSBsYXJnZXIgdGhhbiAyTUINCj4gYW5kIGFuIDhLQiBzaWdzdHJ1Y3Qgd29y
aywgd2hpY2ggZXhlcmNpc2VzIGJvdGggdGhlIGNoYWluZWQgcGFnZSBsaXN0DQo+IGFuZCB2ZXJz
aW9uIDEgb2YgJ3N0cnVjdCBzZWFtbGRyX3BhcmFtcycuIFREcyBrZWVwIHJ1bm5pbmcgYWNyb3Nz
DQo+IHVwZGF0ZXMuDQo+IA0KPiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8yMDI2
MTAxMjA5NDc1NC4yNzcwMi0xLWNoYW8uZ2FvQGludGVsLmNvbS8NCj4gDQo+IENoYW8gR2FvICgz
KToNCj4gwqAgeDg2L3ZpcnQvc2VhbWxkcjogQWxsb2NhdGUgJ3N0cnVjdCBzZWFtbGRyX3BhcmFt
cycgYWZ0ZXIgaW1hZ2UNCj4gwqDCoMKgIHZhbGlkYXRpb24NCj4gwqAgeDg2L3ZpcnQvc2VhbWxk
cjogU3VwcG9ydCBsYXJnZSBURFggbW9kdWxlIGJpbmFyaWVzDQo+IMKgIHg4Ni92aXJ0L3NlYW1s
ZHI6IFN1cHBvcnQgbXVsdGlwbGUgc2lnc3RydWN0IHBhZ2VzDQo+IA0KPiDCoGFyY2gveDg2L3Zp
cnQvdm14L3RkeC9zZWFtbGRyLmMgfCAxNTQgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTI3IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygt
KQ0KDQpUaGlzIGlzIGEgbG90IGJpZ2dlciB0aGFuIEkgZXhwZWN0ZWQuIFRoZSBvbGQgU0VBTUxE
Ul9QQVJBTVNfVkVSU0lPTl8xIGNodW5rDQp0aGF0IGdvdCBkZWZlcnJlZCB3YXMgdGlueS4NCg0K
U28gSSBndWVzcyBETVIgc3VwcG9ydCB0YWtlcyBhIGJpdCBtb3JlLg0KDQo+IA0KPiANCj4gYmFz
ZS1jb21taXQ6IGE0OWUyZDI1NzU5NDkzMTc3MmFiOGYwMDI0NzA4YzMwNzZmM2FhMWQNCg0K
