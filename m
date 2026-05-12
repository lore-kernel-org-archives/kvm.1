Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499E242D9D;
	Tue, 12 May 2026 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548368; cv=fail; b=UqA5Dm6+BXkNmX/KneTqq0vgsZjVFOO4t6IcqjDcq+ZyIPEJIMGwjCY5dAH6n0HHO41Gox+dtdbdTMivXr38AmWqKTBJT2snFAV7FWAflY3yDnQ/+nAcIeOAyndF2wNtlxXMniqfW7GX7WeVJDYEGs8w3pvdxaea37enU/UlQjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548368; c=relaxed/simple;
	bh=vpiodOcJZJ3w9rR5vB4ay2sb15AN1bWrJQogA46Y5og=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VHWjxZ9Ef6eGMeVcu1WWNvJBjBNdBxcH94DYvjwp850Z8LCQLrMXCK0Zl4j00574Aoe5egCzpMeGetFRlhuGkOXgLaJFb5+bO1/jSPX4pQXojaf/AD+BdLFT3xksJUhSKRuQgcogd2d/y35Y+AE13GwH3j4+J8dm6n7vqyO6KMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbwZHZol; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbwZHZol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778548366; x=1810084366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vpiodOcJZJ3w9rR5vB4ay2sb15AN1bWrJQogA46Y5og=;
  b=YbwZHZolalpt3Jo4+cbO38c1Yp07nRBE/dNFyslEccNkU7HfakaJRrV0
   Bh0gyCSyHJP7kpfB0Rs87eObcKJgvOdcAksNYit6dBK97N6PubUAJOr5J
   kvyKfzivvE1NwsuV1kCA/mkOokatecSvzPvPzLqEQUXPTxUy5TACBYQyO
   ik1T40HPwmc/rZIj2w3x+miMzxG4o7dNCgsNjNt7GPulRj6Zq17k7KLEr
   mRv7A1JcEwOrq8PlzldDe+3uN/6ZexR2RxhpVoMUgiATXmlyNiBiPH+Te
   wKGd4M4xdFdiZByRrYLn/3RTgncrFZlXGoQ7aE8iP8iamVgJolLNEuagQ
   A==;
X-CSE-ConnectionGUID: NpV7ONX2S02EOiHk973MuA==
X-CSE-MsgGUID: 71W5xyI1Szaapy9Y0BIkQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90913571"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90913571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:12:45 -0700
X-CSE-ConnectionGUID: 9/YEkMu9QwOn/5f25Wiwcg==
X-CSE-MsgGUID: jy+3JlirQJSkUQ3Lu86ZMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231217628"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:12:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 18:12:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 18:12:45 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 18:12:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8pYUj2MeL18MAhgtr/G4rk7Vkf1qNLrHVY0b0rXy+CNcgndcGj1oq/xTcCNmjunGe8AkCHnOIYp2jBc8+VOIfhW5SW7RwzvqxMzgWZxiZe70KES+l7CbuB0vRnVBN7HBghajPAImUcXKq6lw0I6KQ/U3x+CavouhArvIbKKkFUGd5DAsg405TSGIfRCcoZ9Rkl1pmoAgdki61mL1HUX2ZDNvaV8Hphbph2vkdz2YqZo0H0b06ui+WGZfmqF+T8XBJZxRGe6vqZh+GJTzVzwozXim7PYJk8mml4EaW5GkQIBxy0KImMMLyc9CQDQqXUGrSAEZj9Y8YyrdP6ikPSRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpiodOcJZJ3w9rR5vB4ay2sb15AN1bWrJQogA46Y5og=;
 b=ChGurxydeImYAxuHHVTzIk4azzw+wEdhcZlbmrOjgm64DCqFPM4ewOkCblIkoz9Z7geCG7DoMINHnGZxSJ82le1lCkyZ38SYuemezFf6jexsZW6oTspQbFt9L9wHMB8E3uFCp/OSKCLRHVqRBQS6fV3/OWka0ytN8bMO7b/UoicPt5Wy3Cy6IYWrJci43EdpzVGg3OYTxScHcKvd6fA+d9DcsCXmsAqJu+fjhen2PNiyhAR6MlOM/PWXniuHSJXIZmobvVJibWIJaecuZTr4/KjWUBBSbe18spJmsNCDocCxkA2HhkJCLSIMsbkNMbjzIzjZg6LElqGqVVddRN2MUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CO1PR11MB5074.namprd11.prod.outlook.com (2603:10b6:303:97::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 01:12:36 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 01:12:36 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Miao, Jun"
	<jun.miao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: Block TSC multiplier writes for protected guest
 TSC
Thread-Topic: [PATCH] KVM: x86: Block TSC multiplier writes for protected
 guest TSC
Thread-Index: AQHc4UrtmCYTXprmDE28IZ4Q2n7FdrYJljyA
Date: Tue, 12 May 2026 01:12:36 +0000
Message-ID: <33cc37f03fe011180b90c66787d5ee5e7456471a.camel@intel.com>
References: <20260512111830.1295437-1-jun.miao@intel.com>
In-Reply-To: <20260512111830.1295437-1-jun.miao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CO1PR11MB5074:EE_
x-ms-office365-filtering-correlation-id: 8a9fb081-1952-4c4e-6d84-08deafc38db0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|11063799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 9lV2rzQ3IswGUwyZiGKA6snlkvXL+K/S0uvHx+R8nigkYvSjuF0vWvk+sHTnCxHy/+k7R7A38hbM0DUMMLNkvKuU3Uyq5t0FLtD8hZ97oGZ9tFBiwTmJKzf5QLu/Jn0DV06cVUNUwHoNc/3+kr80YzFn0eP1yqthcaKjDadQDOOVzkeV6XRs1lkQ4KWbxKp9wQbtj61gLjVxvieT0loOqD0E8a/2yYzEngTETYopxF0Bv2D03JrE9oIj/ktitp+SFhZgdA5DUN8/ZguTe8fJVife9O+ang0I6vHswhb2viC02J9uOn2vxrHZA9njhpz51nsLMxdMo8E+o1Dh0SuiJO7oTN7EJnDguHivUiiQknqpZe1XJt211NsxHPo8+X6Oih8eBi/xc/W9QHds6IfTATzZf8Q9mPEgZJTDcXYMwP75fUljDBVTciQFxOle9vweKUN+BSFr1nz2sdH74blwLYFM6DeTjENhtYn4jDTVQcPrtDTQkhNZzTTlMQjP4Sj+mz5qkPBbHil8JdgtEjgBfJky8nwhXlVcrpsnbpEx3J1L3/cid+WMFWU7ORPksMkleaMJB+JyLCj+yu76BQGHd7R/b9n3OIsbRJ13yN3IebBT1jUyPFDE6/9N+63SJg7dHRYaY5JSB2SSS/WkHNKKNXKf017TJJybUX8hkSftYYyme3eBI1mq80CZYmG/ZdRBvH0u0eGIaQgtdfwZz9y0iOlNhv1ROHivtXFXom7uBFxzgsAHNtOpF9V/1M/phEYe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWUxbU1nM2M0d2ZzRFJzZEhBQmYyT2FUQXJVdjNHSlhaeEc3N05yV3pmOTc1?=
 =?utf-8?B?a3YvdlFCSGx6VUY3c0ErLzVYaXc5aHZsMVpyK2xCcXVraGZxVTlCMUJibXJQ?=
 =?utf-8?B?VFptUERia3Rpd1k2M0dlSmlZSVpFTlRjYnE3OTZFS3JqazgxdEZHTHIvZ1ZL?=
 =?utf-8?B?emZvYWc0N3p2R1JhTmpPRzgyc2JKcmlyQ0JaVktSMkgycDhWN2RtUU1KRHdN?=
 =?utf-8?B?OWdUMUhzK0N0NWJsVFQ0QXd6VFZ3a1NHcmFSeHMxUGNpMDFRQllETXF0eXg0?=
 =?utf-8?B?K2djV1d1Q1h1U3ZTTTdESlJSQ1hEZ1BSSWVJQldodXpXbFNSVEVqeWg3UW9a?=
 =?utf-8?B?S0pHMHkyTCsrMzZjc2FQVnQ5L1ZpaDlmTEF3M3loOWNLcW96Um5lb1ZaT3Fr?=
 =?utf-8?B?SVl6cTJZWjkyV2Q0N3ZTOWphVzJRdExGZ0xHY1RLaVZjZmZYeGh6Z3E3b01n?=
 =?utf-8?B?dUFhSk80a2UyRXJyZm5hbWZDRUFmcGdjdWk5REp1TDdsMVMyQVVUOThWemdT?=
 =?utf-8?B?MkhpUTJPeVVEbE1STG1MekZ2RGJCNnk3cTUyT2Z5YlRsblR2cG01aWVzeHFh?=
 =?utf-8?B?YjNYOUxXMXJJNlNXYlRVdEdoSTdPbkxRd2VvZ2dsTk0wMVVJOVpOSmRjMUZs?=
 =?utf-8?B?c3E1ZjJJL0UxVEJBcVplYWRidTZma05jeDAybFp1VE83aDRscC96WVRKc2E4?=
 =?utf-8?B?TnUyT01wVGdQaVlzNGY2dzNORW9NVFkyL2o5MTFtcTVJa2o0eXZGR1ZnbEV5?=
 =?utf-8?B?ZTVMV0FoeStnOUFpZmt1blVUdHo3NVU3ejBXY2pCNi9XK01CSWZqaXF5Y1BM?=
 =?utf-8?B?TU0xelVNeXRUT1pIV3BIYXVMN0g4L052bUlGVVh1UjBLYlF4cHBQZENvY216?=
 =?utf-8?B?OHpqczFrOU5pSmU3OWpLZHc3ZGJzK2t3MG1JTHZNZjkxcmxGbHpyaGZ3UlNR?=
 =?utf-8?B?YU1KZjJKZlJFZTAwZ3JLVExLQklxY0ZSWjA0bDI3dmdET3Z0ME5lKzJMdExI?=
 =?utf-8?B?a3VkbWJNTklEU1VuaFRiN0hzeFFjNkVjMkFnbTJFSHZyT1RYR1VqV2tESkJN?=
 =?utf-8?B?MWtxeFRlcmdRK3NOTUU5T3oxY3hzYS9ReFNkNjhoRzl2VVllSFhPc3RiZjNl?=
 =?utf-8?B?WWFNTUxKOUI0Q3ZXTXZJL3E1MFkyU3Q4QUZNeTlLK3J4ZTVhV0JBb1QvVlJr?=
 =?utf-8?B?SmxPUU9COHZIVWZjOVhhZm9tREtDVUlPc2RwUnpFMkVaMmxmaTZZellhRzJB?=
 =?utf-8?B?bnVyaXFqb3dsSnpvQy9nL3FwZ2xJdjZ3Z1NPSjBCWXNzU2dJb09hOGJrbk1t?=
 =?utf-8?B?RXlYQUFtOGNGSW8vVzZqUWpMblJ6cDRIZDVCUld6YmJkdEZVMGxJUnlJQmJK?=
 =?utf-8?B?eENwcjA1WDFnRHBZK3NhTklqVDBtNHpTTWgvWTlzSEY3cXBEVkNUZUhBSVVm?=
 =?utf-8?B?STJCOWJHSGVSMFMrQlExWDFsZTNBVlNqRGYwT3ZXYkV5RUFoeG54UkJ3dDJr?=
 =?utf-8?B?Q3JOY3VnMzhQTFNhOFhUYzJuaUtuODhja0dVL2JERHBzTks3Y0tCU2s2S2Yx?=
 =?utf-8?B?SXhWU2xPTTRNY2VwMXl3NFc4bHk1NDRWaDJRZE51S3FMcHRvSG4yZS9lVVNs?=
 =?utf-8?B?bGRTQ0JBLzRzY2dEMUlBcFUwbjhCcVl2cFpYeUxlYmJEOUtKaElKSEM2S0tJ?=
 =?utf-8?B?cXpJbFBRMTQrVjFPeXVpcFZRNHZQM2xzTFNoc2VPZGUrR1NUc0J0MkE3amlo?=
 =?utf-8?B?NThHV1pVbzUvNkNHT3VRRVFxTkRJRytwU0ZBSDUwN3BYNVBLMksreHpiVHZN?=
 =?utf-8?B?WHUzWTFvYUI1Q3lFVHJzdi9jVWdIMkI3cFUwYWlvU3o0S0lPaStJdkcyR25z?=
 =?utf-8?B?dG96OERkc1JndGhIekRmaXpHUnhNNW9ldmdWVXB1cmxHbTh4RzRFMlB1eXcr?=
 =?utf-8?B?Ly9Tc0xxS1ptc2hhVVBHazJuRDFQbUNScTU1NXEyUWlFTE91N3Z1bmczQ2hw?=
 =?utf-8?B?cWU4a05pV1oycTIyUldOZjJtOHJPT2hjSzlWOEJLLzdtb0NwV1ZVNy9wQmI5?=
 =?utf-8?B?VzJLYTQ3YkplQThkaEYyNDFZWmVmbUIvbFp4VEoxTnVrSWpQa2YrbTlpbUs0?=
 =?utf-8?B?NGhoZ3JKR2ZaN3k4UFpjZ0RQV3oyT29Hdm5Uc1dCV0JGWGFhNElsenJCTjdN?=
 =?utf-8?B?REdHNGd6V2VuM1VJSmpzRVVxWmNEV3NKa3MrUlNlektZNER6b2hWNzY1dmpI?=
 =?utf-8?B?TXlHQWFxNXE2TlRDbGoyaXNxanBieHl2bXdvTW5XTkdndFNUc29oTTZveElL?=
 =?utf-8?B?aHBBRHNsNVh0V3hrNHREZDFWdHNZM04wZ0JmUkwyZ1hheDFwNnhrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B02E57E0F768644A8E486A13442BCF97@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kACtpkAtTVYzYqZnZm84hpHzEtfcQWjLbrTnvclsH6L7vY+PhBsW69FaP4JNr8Ev+wuV5OjjshM/WgjCRnIba1nSXOi6BY5N/2pOuP5sPnTJBJdvvBGZQzIxWhOz8Vl+BDK0UIYFN9vVRkqpfE1S1XnPI20aMzFiAU9mauxope+GDSoDGVhTN9RHZUPxSafyM9uUgs0IWNQQaMYdXqOEieKlYLCvjOSxN3YxE/Dqm7dl4rvFHEzQonS32Kb9u84YxDfm0KQlfOyLPFm/iaZx8vpcnht8mD44ym9c4WwDYSg3cglrp1YIXsk0fyDxOWeHyXIxd5T7+KuzQYd3ru+YGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9fb081-1952-4c4e-6d84-08deafc38db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 01:12:36.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb/2D5yZYRD376KkdSTtMJvmG4NDy5/8GgLb5rXp6br6FwjU/1vEGI/1nlrnxgngTiiRZslXXGfAyliUZqafYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5074
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA1LTEyIGF0IDA3OjE4IC0wNDAwLCBKdW4gTWlhbyB3cm90ZToNCj4gQ29t
bWl0IGQ1YTRlNDA4ZTY5YiAoIktWTTogeDg2OiBBZGQgaW5mcmFzdHJ1Y3R1cmUgZm9yIHNlY3Vy
ZSBUU0MiKQ0KDQpUaGUgaGFzaCBpc24ndCBjb3JyZWN0LiAgSXQgc2hvdWxkIGJlIGFkYWZlYTEx
MDYwMCBBRkFJQ1QuDQoNCj4gYWRkZWQgdGhlIGd1ZXN0X3RzY19wcm90ZWN0ZWQgZmxhZyB0byBw
cmV2ZW50IEtWTSBmcm9tIGNoYW5naW5nIHRoZQ0KPiBUU0Mgb2Zmc2V0L211bHRpcGxpZXIgb2Yg
dkNQVXMgd2hvc2UgVFNDIGlzIG1hbmFnZWQgYnkgYSBjb25maWRlbnRpYWwNCj4gY29tcHV0aW5n
IG1vZHVsZSAoZS5nLiBURFgsIFNFVi1TTlAgU2VjdXJlIFRTQykuICBIb3dldmVyIG9ubHkgdGhl
IFRTQw0KPiBvZmZzZXQgd3JpdGUgcGF0aCB3YXMgZ3VhcmRlZDsga3ZtX3ZjcHVfd3JpdGVfdHNj
X211bHRpcGxpZXIoKSB3YXMNCj4gbGVmdCB1bnByb3RlY3RlZC4NCj4gDQo+IEFzIGEgcmVzdWx0
LCB1c2Vyc3BhY2UgY2FuIHN0aWxsIGNoYW5nZSB0aGUgVFNDIHNjYWxpbmcgcmF0aW8gb2YgYQ0K
PiBURFggdkNQVSB2aWEgdGhlIEtWTV9TRVRfVFNDX0tIWiBpb2N0bCBwYXRoOg0KPiANCj4gICBL
Vk1fU0VUX1RTQ19LSFoNCj4gICAgIC0+IGt2bV9hcmNoX3ZjcHVfaW9jdGwoKQ0KPiAgICAgLT4g
a3ZtX3NldF90c2Nfa2h6KCkNCj4gICAgIC0+IHNldF90c2Nfa2h6KCkNCj4gICAgIC0+IGt2bV92
Y3B1X3dyaXRlX3RzY19tdWx0aXBsaWVyKCkgICA8LS0gbm90IGd1YXJkZWQNCg0KQ29tbWl0IGIy
NGJiYjUzNGMyZCAoIktWTTogeDg2OiBSZWplY3QgS1ZNX1NFVF9UU0NfS0haIHZDUFUgaW9jdGwg
Zm9yIFRTQw0KcHJvdGVjdGVkIGd1ZXN0IikgYWxyZWFkeSBhZGRlZCBjb2RlIHRvIGJhaWwgb3V0
IGVhcmx5IGluIGt2bV9hcmNoX3ZjcHVfaW9jdGwoKQ0KZm9yIFRTQyBwcm90ZWN0ZWQgdkNQVS4N
Cg0KPiANCj4gYW5kIHNpbWlsYXJseSBkdXJpbmcga3ZtX2FyY2hfdmNwdV9jcmVhdGUoKSAtPiBr
dm1fc2V0X3RzY19raHooKQ0KPiB3aGljaCBjYW4gcmVzZXQgdGhlIG11bHRpcGxpZXIgdG8gZGVm
YXVsdF90c2Nfc2NhbGluZ19yYXRpby4NCg0KVGhpcyBpcyBtb3JlIGxpa2UgaW5pdGlhbGl6YXRp
b24gb2YgS1ZNJ3MgaW50ZXJuYWwgdkNQVSBkYXRhIHN0cnVjdHVyZSBiYXNlZCBvbg0KdGhlIGRl
ZmF1bHQgVFNDICh3aGljaCBpcyBjb25maWd1cmVkIHRvIHRoZSBURCBiZWZvcmUgY3JlYXRpbmcg
YW55IHZDUFUgWypdKSwgc28NCkkgdGhpbmsgaXQgaXMgT0sgZnJvbSBmdW5jdGlvbmFsaXR5IHBl
cnNwZWN0aXZlLiAgTm90ZSB2dF93cml0ZV90c2NfbXVsdGlwbGllcigpDQpzaW1wbHkgZG9lcyBu
b3RoaW5nIGZvciBURCBzbyBpdCdzIHNhZmUuICBCdXQgc2luY2UgaXQgaXMgY2FsbGVkIGFmdGVy
IHZjcHUtDQo+YXJjaC5ndWVzdF90c2NfcHJvdGVjdGVkIGlzIHNldCwgSSBhZ3JlZSBpdCdzIGtp
bmRhIG5vdCBuaWNlLg0KDQpbKl0gVERYJ3MgZmxvdyBpczogMSkgdXNlcnNwYWNlIHVzZXMgS1ZN
X1NFVF9UU0NfS0haIHZtLWlvY3RsIHRvIGNvbmZpZ3VyZSB0aGUNCmRlZmF1bHQgVFNDOyAyKSB1
c2Vyc3BhY2UgaW52b2tlcyBLVk1fVERYX0lOSVRfVk0sIHdoaWNoIGNvbmZpZ3VyZXMgdGhlIFRE
J3MgVFNDDQp1c2luZyB0aGUgZGVmYXVsdCBUU0M7IDMpIHVzZXJzcGFjZSBjcmVhdGVzIHZDUFVz
IGZvciB0aGUgVEQsIGluIHdoaWNoIHN0ZXAgdmNwdQ0KaXMgbWFya2VkIGFzIFRTQyBwcm90ZWN0
ZWQuDQoNCkFmdGVyIDMpLCBib3RoIEtWTV9TRVRfVFNDX0tIWiB2bS1pb2N0bCBhbmQgdmNwdS1p
b2N0bCB3aWxsIGZhaWwgdG8gY2hhbmdlIHRoZQ0KVFNDLg0KDQpUaGVvcmV0aWNhbGx5LCBBRkFJ
Q1QgdGhlcmUncyBhIGNoYW5jZSB0aGF0IGlmIDEpIGdldHMgY2FsbGVkIGFnYWluIHdpdGggYQ0K
ZGlmZmVyZW50IFRTQyAiYWZ0ZXIgMiksIGJ1dCBiZWZvcmUgMykiLCBLVk0gd2lsbCBoYXZlIGEg
d3JvbmcgZGVmYXVsdCBUU0MgZnJvbQ0Kd2hhdCBpcyBjb25maWd1cmVkIHRoZSB0aGUgVEQuICBC
dXQgbm8gc2FuZSB1c2Vyc3BhY2Ugc2hvdWxkIGV2ZXIgZG8gdGhhdC4NCg0KPiANCj4gTWFrZSBr
dm1fdmNwdV93cml0ZV90c2NfbXVsdGlwbGllcigpIHN5bW1ldHJpYyB3aXRoDQo+IGt2bV92Y3B1
X3dyaXRlX3RzY19vZmZzZXQoKSBieSBza2lwcGluZyB0aGUgdXBkYXRlIHdoZW4NCj4gZ3Vlc3Rf
dHNjX3Byb3RlY3RlZCBpcyBzZXQuICBUaGlzIHNpbmdsZSBjaG9rZXBvaW50IGNvdmVycyBhbGwN
Cj4gZXhpc3RpbmcgY2FsbGVycyAoc2V0X3RzY19raHooKSBpbiBib3RoIGlvY3RsIGFuZCB2Q1BV
IGNyZWF0ZSBwYXRocykuDQoNCkZpbmUgd2l0aCBtYWtpbmcga3ZtX3ZjcHVfd3JpdGVfdHNjX211
bHRpcGxpZXIoKSBzeW1tZXRyaWMgdG8gVFNDIG9mZnNldCwNCnRob3VnaC4NCg0KPiANCj4gRml4
ZXM6IGQ1YTRlNDA4ZTY5YiAoIktWTTogeDg2OiBBZGQgaW5mcmFzdHJ1Y3R1cmUgZm9yIHNlY3Vy
ZSBUU0MiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKdW4gTWlhbyA8anVuLm1pYW9AaW50ZWwuY29tPg0K
PiAtLS0NCj4gIGFyY2gveDg2L2t2bS94ODYuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5jIGIv
YXJjaC94ODYva3ZtL3g4Ni5jDQo+IGluZGV4IDBhMWI2M2M2M2QxYS4uZTkzNWZlMzNkOWMyIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL3g4
Ni5jDQo+IEBAIC0yNzM2LDYgKzI3MzYsOSBAQCBzdGF0aWMgdm9pZCBrdm1fdmNwdV93cml0ZV90
c2Nfb2Zmc2V0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTY0IGwxX29mZnNldCkNCj4gIA0KPiAg
c3RhdGljIHZvaWQga3ZtX3ZjcHVfd3JpdGVfdHNjX211bHRpcGxpZXIoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1LCB1NjQgbDFfbXVsdGlwbGllcikNCj4gIHsNCj4gKwlpZiAodmNwdS0+YXJjaC5ndWVz
dF90c2NfcHJvdGVjdGVkKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gIAl2Y3B1LT5hcmNoLmwxX3Rz
Y19zY2FsaW5nX3JhdGlvID0gbDFfbXVsdGlwbGllcjsNCj4gIA0KPiAgCS8qIFVzZXJzcGFjZSBp
cyBjaGFuZ2luZyB0aGUgbXVsdGlwbGllciB3aGlsZSBMMiBpcyBhY3RpdmUgKi8NCg==
