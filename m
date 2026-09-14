Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAB47D92F;
	Mon, 14 Sep 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402478; cv=fail; b=GwpcKPZNRWwJTRbZ4lp9EC1IGYqq8EuMyHPidXvu2rcQrlzOfGfelNeyfF1cxftStP4Z/RVLAYXx9EBAvOnL8SPz7GSmbJyPBtEbLgFZVNFSsD7Ad+vpewy5vrOJOmNWVfAF7eJc6cW+UnErHSZoZSgaOlratxyBjI9vR+iWk3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402478; c=relaxed/simple;
	bh=HfutccX3vf7CNhLzmGwf7eHHhwZjOXtNa5ptv+3YOY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f6DC5+txzDhF553suNEtzaEkBtEDI/0cIzM2mEvBKZMEtK/un+n6NYo07gTvQ8ZIYI5bjDXPm6zYWPP0rjTQQeZ3sLu5VXv9stMG7yHTCsG7A9Wn8JcatRNORLYt2+lsOVKL/fAwqLxVhxc3iGofwLpQ+ZGkMtCd3NZhYVAjsSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRFaLyGR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRFaLyGR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789402477; x=1820938477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HfutccX3vf7CNhLzmGwf7eHHhwZjOXtNa5ptv+3YOY4=;
  b=CRFaLyGRXCafssSxtQ5IeIRWngNzcbaWUQ6nkuQxwS9//YjhYSBZEQMS
   r29Wb2HCdZ9Uw2OWciy0jr73sZkgi0foxV8rf14Ms8VRW2SdoIORs/QGV
   P4jdyDrAEvq0l4wjFyQtlG0ut64yxa0uCx2pRaHPAJ6ihBolHOh9aY0HN
   F1y+9CYqc8YunoBI5yw7sq/19PoFzf1ftGw38OIWbb9+W0FjbRRS03ar2
   yHUwUxxTGOuwivPoaxnkJcO6YxFgI8O3V+V4LpzHVWvxQDb1nS6cyM7uz
   PYeUJZbXoyLcvI38prHKeXtYDv8xCLQIF6O1ebS5g/u4gc9mSJ2W8UTqS
   g==;
X-CSE-ConnectionGUID: Z52Ropc8T6uiaNkECCB9vw==
X-CSE-MsgGUID: QPv6JIkrTrWLe8Rvm6K6HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93624001"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93624001"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 09:14:37 -0700
X-CSE-ConnectionGUID: SiCeOfAQQfaseg9S9anwRQ==
X-CSE-MsgGUID: 5tG980YEQ/24PIsjEfDhYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270873832"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 09:14:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 09:14:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 09:14:35 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 09:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIzOBrPNovPpuIRF/gy+nxeBluUoIu7IgmWahAN6xz4Qhu3W7y6AmrYqsyF8WaXQqAaa8013I3sVYZBCXQHvLRsxvxIToNnIOCNiBXL1Bqn5yob0oS6EZ8wUaZqSBGonBirAhjqK2FTb3iJ9qctSMers2eoRrWrKta8xOLxCtY3pYXygXXYclM+B07Dyqwc3wgj0KDaeKho2JVuxCBJuRollANUnFLeHb0qZKwGck+8MVi1ItnwCCO7L2fpWoeRP0STiAS5K01T+VdpMuFsGdm8at2wQgL5rfeGK/Og8rAr+CgYM/V97wIwCPOMdoyZuEVkJwHwlWvIl0xKiNAX1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfutccX3vf7CNhLzmGwf7eHHhwZjOXtNa5ptv+3YOY4=;
 b=fYZQP/9hAnjZ9UkFdPlWTd/DbYXYiKsbmqraCTQPMjZsb77XJGBfHY7NYdJquh4HUs12BTV9zNd5Rgvqk1C3MKckJ6UrINcDtIMeSGO8aNhqQz8/rUOWhByVGs61OOYY7zCJ0qK2Pl138YxUv9MD76kiC1dESpMdOy68D46DOdgZnQvylYiulnZ+7r9bgVJIW7pP9eaYSZVLxS19XPNaUhYjuFi1ZnYKMYChoFLQsNeXhbE320gSXSH4bAtLcXsCcDDMMAD/WHfD8vnrxW9GdWIpeO0gQz2Bl5pdokikk5wHhJBxgMqDznbTR5tAQ9XEveahcUs1O6eyh8VmMro0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 16:14:31 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 16:14:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "luto@kernel.org" <luto@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "dmatlack@google.com"
	<dmatlack@google.com>, "seanjc@google.com" <seanjc@google.com>,
	"xin@zytor.com" <xin@zytor.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "shivansh.dhiman@amd.com"
	<shivansh.dhiman@amd.com>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "nikunj@amd.com" <nikunj@amd.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "Liu, Zhao1" <zhao1.liu@intel.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH v10 09/28] KVM: VMX: Save/restore guest FRED RSP0
Thread-Topic: [PATCH v10 09/28] KVM: VMX: Save/restore guest FRED RSP0
Thread-Index: AQHdRBdMvciq6A6yYUK6uaMMPzyuvrbOQBCA
Date: Mon, 14 Sep 2026 16:14:30 +0000
Message-ID: <22c2c3f67198185a8e3a6bda43e4f12b78305cbf.camel@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
	 <20260911213659.2025974-10-sohil.mehta@intel.com>
	 <dd7b17e4-8d84-426a-9962-3ae693dcf401@linux.intel.com>
In-Reply-To: <dd7b17e4-8d84-426a-9962-3ae693dcf401@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW3PR11MB4748:EE_
x-ms-office365-filtering-correlation-id: 2218c41c-0709-4e45-17d8-08df127b4232
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Jxk4DosoPZs65cgFLDrgHO8GjAZKfzE5p36YhVGjs7hVSiN4OOUii0OiJYZrU5VcWNvxW+PZvPe38cJ4QqmQKMxLGU4bMkCNUZsnv+CXF3bzn/lq5oD3FTJ2sbf6HPSNQ/69PZUxjKkxUK9FpubCxiDvkByRglJAfU8prvl2CSDua5phuHIiRM9Yy3a5IvdxD+/BHygKV0DlgLzOD4eKpIGEyRo7nkfjhI0iprqowurZUopGW1nVUIkekK1nX5ud9/alCDb9BsiVILesXvbNSxv63uAtGlPZK0pKcHcH/3b6ll9TFcOtsFVbv2huTi6VHWQ7fx2j5DaqJKccWMY3hZSicbOD2Zd9ZE2KMwyqYF6AnKqzmbsK5+S640sv6RbqbemDO9NXTOy33kobYnsMRBXd9T1rFs6h6Nnuu54E7zlxRrZzfPQjfiVrGNepY9N+hPZyPVsCs9P3zLwdgPnWNiAkhQri3w9mjZrZh6/D7ZeI7r7C/6Uuy94gY8jK8p0WrBpv6lnoFcbBvWodGx9wyq3rcQXkV3v6GVIqEd/CtP0GG9HE4IYsiFESlf0PE9jAHgc3SF/qyvdy8cBdF9b2DsjbysJD5NydwNEjzrhzQpwk0ZrFQHjEHHELluxwHcSICpQ+BwI6o/TXx50qAlTzgejDlMawSa1tlEbIbKO+D2kJ3ouUho4xGJj0nxtREIhHtZSbEnV4/DSX3VO9abqQf/YizDDf9Cgh53zTdHpr0Ag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnFFb2FlQTNZMWtHaGx2K1BsMzdzMWp2Wm82SXpXeTdpenlZakcwSmJUU3cz?=
 =?utf-8?B?ejZ6bTlwanFUY2JIWkdBaEJ0TVBia1RvMkNzVE93MjJRNFMrOCtOUGxlRFNG?=
 =?utf-8?B?VEk0VElaZGVxbmVvVEZyY0kzU09XVUFEOHlmeFFnaFJrdlViVUQ1LzZPbGNs?=
 =?utf-8?B?cXpjQnNpVklBUTMyT3MyOXF1NWlhSnN0SU8xekNnRURSeDczUVI4bnF3Vzk1?=
 =?utf-8?B?cnpvUGVNT0VONXNGbUh3WHpTc00yQUVmZlFGTWliZDFlcGk1U3N2Rm5PNVBm?=
 =?utf-8?B?MmtpWnkvbGV4U28xdHVEK3RYNDJxbEp5VmlTTlVqTEZrdXJYM0FlQzdZMzV6?=
 =?utf-8?B?YWZaZ2ljZnd3U1BIOTV5aUhmM04yQkE4WTduaHkyVml5V1pZNHFzcXRNUVpm?=
 =?utf-8?B?R29MaUM1ZXkzOFVPNks0eERubHZsN3hoL2FWSEJDVmdWZjFNUDZPeXQxdFd1?=
 =?utf-8?B?S3VsU2xsOWM2aklrQy84RnptN00xMTlOcDJ4Qi90QXdMWG8wZnpTZFpQbC9U?=
 =?utf-8?B?UzFSQTlKT1BVeFBQY1ZPY3pqVmlMeGVHdG5zZlNWVmtVZVdjYkdmUFAvb1N0?=
 =?utf-8?B?Zkt1OHVvS3A4N3lndWltVk1wbndZR20rTVJiVzBMMDJ5ZkIxSWQwNzZ1UGlD?=
 =?utf-8?B?WDhlRkl1Z3h6L2hzb2JsVGpMK3R2cTRBUlBWb2JmQkRyWHpZK1pZU241NFh5?=
 =?utf-8?B?eEF1UytkUEdDQkc0dUVqc2toZGhLR0xMOEtiY3ZXNFo4YzFGdGRNZnlOOGNY?=
 =?utf-8?B?NDI5cVA0NVZOZk43alhhaHJrMHlmb2NzS3NiSW5qb1RYcUxDc09FQmx3QUZz?=
 =?utf-8?B?bkxlSWVJQnIwcUdGeDVYLzZBZGl0ekl6MEdVVkdrUDgvaEY5ZTNKZjlwQnNm?=
 =?utf-8?B?OGNLOHFLSjlMQm5sNTg4MHVKdTVxTmRzdEFsUnNLb0h3d0ZURjJNVEV0Z2M5?=
 =?utf-8?B?YzBDT3pnYUIwRGJiQ1NIU25JWTdMY1crSkEzcm1aanM0NWZ0RGU3RnFQaTJ3?=
 =?utf-8?B?MEFFTXNKUVQvcHorbVdNaS8waWpBcTVsL1VuRXRYUFcrWnJRaHhmb056VHlV?=
 =?utf-8?B?QnZKZU1RUTBpa1c0RXZCTnBwQS9ZT0VXYkl3dndrYk9lTzA4M3ExQVBxVjcr?=
 =?utf-8?B?d3FxcHNIUmZvN21MOUwxb1ljQTBpbTJqNWZjN2hsTGs0NFRMUm53VmJhRW81?=
 =?utf-8?B?bFljSGs3SUFVTXY2QzJnbDhNNlQwSC81NW5UVUNRdmtiNGxvc1AwOXE2VGpz?=
 =?utf-8?B?NUlUUmphOU5qZTlkQXNrQ2Nya2ZkYndQc2xvdFlYdk1aaml6aW9CaUJuVUxl?=
 =?utf-8?B?M1N3OVRYVnBxRFNzM00rNUREOHhTYjkrK3U1ejl4SEJ5Nkg1SnRXSXhKSnh0?=
 =?utf-8?B?dE1iTEZUWk51T3A4SXd0eWJXY3J0UDl2NmpPYXVpZ0dSKzBpWjMzcXI1UmNh?=
 =?utf-8?B?ZTR2SUMyTHgwNW1qU2JXZ3dUSXBJc0Z1Vy9nWEt6SFlsbzE2UEZnMzVuUkF4?=
 =?utf-8?B?QTRwZ0lXWll3Wmtyc2hwYmtleEQzTU9xQko5REF3Q0cvSFhoS0Q0ay9VakZ3?=
 =?utf-8?B?Um51VExRMDFGaExqeFZKWXFJc1dCc1JFdHFIMEtYdjh1NkRBd1JqUDVrcW83?=
 =?utf-8?B?TFdKWk5uc0ZDTDgyRXdnRlg2WkhjL09uMDRWKzVGRVdHcldwcjltbXlmMEV1?=
 =?utf-8?B?NnFmcHlobVA1RVdWbElRemxRNnJLakZ1UWRHODYyU0laeGJqQys1Z1lTUUM1?=
 =?utf-8?B?OExYVEhRdnFWQUlQaEtld28wUUdWSHVTaGc4R1pXeGJBaTJ6NUxCS3dUT0NO?=
 =?utf-8?B?YWYxQk1DVWVaTjZjUzV2QkNyTUNrcFlqVEgweHd1aHMyM0JRME1iM0l1UGNT?=
 =?utf-8?B?bjRXR1hPYjZpMnU5WEoxQSs0dTBRV1AwREF1bFN6UG1tRkxmRlR2OUNYTUs4?=
 =?utf-8?B?U0tCWDdZV0NSUFAwQmlZZkUzalU1b0twY3FDajlUVnlWeG1hSlpQNHZjQnRi?=
 =?utf-8?B?RmdWblhQSnpDWmNYK2poZ3ZzNjFLVmlDZzdzQitnL044ODROYnZhN0xodk1a?=
 =?utf-8?B?MjdWUitEQUZMdkxaMThBME9Qb1VXeURldURaVmJXQzZWd0V0WExZRmVQSVJ4?=
 =?utf-8?B?eUMxOGdnZkNqbUNoR1dWT3JYMHJHR3VYc2RoMUNCbjFnMkRMWjNGbmJNT1p3?=
 =?utf-8?B?Zm85YzlTMWFCSGVNc09aN0JFbWhqQTgwY00yMEVUMTZaSDUwT1BobnlJWlQv?=
 =?utf-8?B?aFBDZUFHeXUvZ2p3MnV1UFdCQUtKblBvSWdnQldZVm9hQm5XNUIxM090RVNG?=
 =?utf-8?B?OUpqQnUvYWZaUHJDalVSTmJzNkJnRTUvbXdpazZTWE5DRkgvbm8rd05PTU9m?=
 =?utf-8?Q?h+1CbiDI95FB39Fo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8949C819AA55BC47B0C072A4348E4231@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oCb9obx9XOgk0Y7gnMG6q42ndrqkhw0PEqVGZDNk8MFuXDaLEBBldPAej+Vi/CYpjfNll1B0gE/JOHCHTYOJFQzo0spJejHOPrzmSQt6ecxNT7nLBa/vTGAfOV/y66PbczrObu6dcFuP/o0WqyjitMiUtCBCOqHTsorezisuM1j5rzPmWO2X11Z4KM8TUrL9cId/SxsApuXRF3c03svrJZ95sVMDPkW8R4y5tX7gXA0LsbJXRGCToTbS5rSF8PQ2A+AJkVW4rbypzFbgaqocnbz5oWRgKYBT7uclVamLRxDov8JYZTJyBB50p3LiDjO1W1CJ3TK/pZgF56aDbp/xow==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2218c41c-0709-4e45-17d8-08df127b4232
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 16:14:31.0501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKdEduN7L4YnOsRs1CRaw1E37/TGkKm3T/7BUwyW1mC6kPf6DcnG3Ynk90GCDPVCfQ3JUVTmkptBJSUVsi24RZz35W0FpXWesG6xqUBBWL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTE0IGF0IDE1OjA0ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
Tm90ZSwgYW4gZXF1aXZhbGVudCBURFggc2lkZSBpbXBsZW1lbnRhdGlvbiBpcyBtaXNzaW5nLiBO
byBURFggbW9kdWxlDQo+ID4gd2l0aCBGUkVEIHN1cHBvcnQgZXhpc3RzIHlldCBzbyB0aGlzIHdv
dWxkIGJlIGFuIGlzc3VlIGZvciBmdXR1cmUNCj4gPiBwbGF0Zm9ybXMuIEEgZ2VuZXJpYyBkaXNj
dXNzaW9uIHJlZ2FyZGluZyB0aGlzIGlzIG9uZ29pbmcgYXQ6DQo+ID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcva3ZtLzIwMjYwODI3MDMxODM3LjI4NjM2MDktMS1iaW5iaW4ud3VAbGludXguaW50
ZWwuY29tLw0KPiANCj4gRm9yIG9sZCBLVk0gdmVyc2lvbnMsIHdlIHdhbnQgdG8gZGVmZXIgdGhl
IG9wdC1pbiBkZXNpZ24gb3IgYmFja3BvcnQgZGVjaXNpb24uDQo+ICgNCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcva3ZtL2M2YjI0MGJkLTNjNDUtNGFiZS1iMTdjLTcyYTFhN2RhNTgyZkBsaW51
eC5pbnRlbC5jbw0KPiBtLykNCj4gDQo+IFdlIG1heSBmaW5hbGx5IGNob29zZSB0byBiYWNrcG9y
dCB0aGUgVERYIENQVUlEIGZpbHRlcmluZyBwYXRjaCBzZXJpZXMgdG8NCj4gc3RhYmxlIGtlcm5l
bHMuIElmIHRoaXMgcGF0Y2ggc2VyaWVzIGxhbmRzIGZpcnN0LCBzaG91bGQgd2UgYWRkIEZSRUQg
aW4gdGhlDQo+IGRlbnkgbGlzdCBmb3IgVERYIGFzIGEgdGVtcG9yYXJ5IHNvbHV0aW9uIHRvIGF2
b2lkIGhhdmluZyBzb21lIHZlcnNpb24ocykgdGhhdA0KPiBhbGxvdyBGUkVEIGZvciBURFggd2l0
aG91dCBGUkVEIHN1cHBvcnQgaW4gS1ZNPw0KDQpUaGUgc3BlY2lmaWMgRlJFRCBwcm9ibGVtIHN0
YXJ0cyB3aXRoIEZSRUQgaG9zdCB1c2FnZSArIFREWCwgc28gSSBkb24ndCB0aGluaw0KdGhlcmUg
aXMgYSByZWFzb24gdG8gdGllIGFuZCB0ZW1wb3JhcnkgZml4dXBzIHRvIFZNWCBGUkVEIHN1cHBv
cnQsIGluIGFueSBjYXNlLg0KT3Igd2VyZSB5b3UgdGhpbmtpbmcgdG8gYmxhbWUgdXNlcnNwYWNl
IGZvciBub3QgcmVzcGVjdGluZw0KS1ZNX0dFVF9TVVBQT1JURURfQ1BVSUQsIHdoaWNoIHdvdWxk
IGNoYW5nZSBhZnRlciB0aGlzIHNlcmllcz8gDQoNClNpbmNlIHRoZXJlIGFyZSBwbGVudHkgb2Yg
cmVsZWFzZWQga2VybmVscyB3aXRoIEZSRUQgaG9zdCBzdXBwb3J0IGFscmVhZHksIEknZA0KdGhp
bmsgdG8gd2FpdCB1bnRpbCB3ZSBzZXR0bGUgdGhlIG9wdC1pbiBxdWVzdGlvbi4gV2hpY2ggZG9l
c24ndCBzZWVtIGxpa2UgaXQNCnNob3VsZCBiZSB0b28gbXVjaCBsb25nZXIuIEl0IHdpbGwgYmUg
bGVzcyB0aHJhc2guDQo=
