Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202824A3D34;
	Thu, 24 Sep 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276354; cv=fail; b=rawUDvUYGuFbRxDhO0QsLQk16fnJ7WdGzNNmYVVZzvqcJDxmwVVt6grakAzpUF/msrxoXEv+nZHPBRWtn6ih33WOdEkeCi717zC80UgDK39xi//jPNnC2YrNccnFVkeIOD0260gk+UwtGnfAJtj1upIKn+p27dwNUCAI/Hxb+sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276354; c=relaxed/simple;
	bh=JnflkcKeoyJpqb8QCzOTsR6gJ1pyG7TnlZK7JU5ViOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IvwSTwTgQKHwlL26y7NbEiZsfHegugA/CHCe35sjQCOymFGestu7pOiK/LoQr/croKrKmdkWtQoaNEraa+Tok2WeCnCsSfTEMBd7Cz/q80Fe2c+Nmz1skg0PSw3KsvlDF1iQjiH3LUPmith58KuifA/5xu18EcdJ6BxCTLWwcGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnjbaH3z; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnjbaH3z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790276349; x=1821812349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JnflkcKeoyJpqb8QCzOTsR6gJ1pyG7TnlZK7JU5ViOI=;
  b=DnjbaH3zM27oglXqiGDb+EQl4lCfRcu5J8BZZpVmZT6JpMsinZtuQkVJ
   SQ4v/0mjhE0/8sOkTFo99Q7tAtRh3cgRSF1fuYse2t0y8VtuyzJbLJdUa
   SD2MUvg5Jh1BUdRZM9xEwDNdWsD/YwoMdVjbB5H1rBu6g2yJWSNr7js7t
   R6W9dVhdOsL8ePu9nYYd/ljW/5PJ155K7xg5YtBBcAJNywaO7hQIDWdUo
   ZYjR3yE16pzwACzK8UXBg6qlKPxEZvsBeaZGcpXNOwTmA4sfigDQ5oyBw
   3v3tq0DTAycSmtD+ZCk6YSStTw8YCRfUcprTtT7bNI21C9QlDXg7bHUpT
   w==;
X-CSE-ConnectionGUID: WZhJoDsZR26oUTf53bX9vQ==
X-CSE-MsgGUID: dTSBNftzRBacgit0UDMNnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="100397231"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="100397231"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 11:59:03 -0700
X-CSE-ConnectionGUID: YvH9/dbvR3CkV7NUnAr6tQ==
X-CSE-MsgGUID: ps9Kj1oDRSW19MQunDtPvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="312029771"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 11:59:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 11:58:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 11:58:59 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 11:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbCw+/ty5cRigU95zGPetebK0L/zModBHFFti7GriTOKRpTMcWp7aEZpyrJAZDoFWmBlhzQxXtCPRbL3o2e8q9ln2MJMAYXM6Lwo8LZO9p/yLPWuZhdLsEQhBvPxDYcDcewcch3m0FNFl+xdPmjDT2mxPOoa6YaPm+AltwGisgIdTpJ+gYUZPBDSCsAGUwBDLvlcNhQ27nnMNu4F15GkxxqSGCNPJ4yif6m1IudUsQXOWp2IdroJjZO8bV44AE73ZixwHlN3xnbw0sg/1xG58MJN2Fx12MluhfW5JlHSzfG+R2w8hJsHibf5vRghq26u+Nr5XqTSjly0/Iws5wPMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnflkcKeoyJpqb8QCzOTsR6gJ1pyG7TnlZK7JU5ViOI=;
 b=m+sc7Mb8OyYIVAEuAhJ0K9r4V6Wg68yAluCT1QIMatmqHEpf/lF38gZm2qGpMzoelvQNHQaNRWIkYVSWcMy3DzOMpfnzdCuh3d0a5luLGBq4aPxnrpI9d541JGCPZR34DSV14mRMvVwjaPqkutHUfnJqv9/h6aolN6ag47qJ+YTeImE/ujtr4fTxjNoBbt/WZ9ZawNjf8XKtBzjIhfd5MfyNCLsuAP0SJ7DCOViu5R+cfCFI12eFUGD9Cck+okUbU/OwXlQ3+GOamVDuWTQaTSPqgJE50iwjfUAD79TPC3i/vYFU6PuBWHQHUiY9z3oKtWzIY0tUf7OxyBLHNyKrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SN4PR11MB9942.namprd11.prod.outlook.com (2603:10b6:806:4ff::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:58:56 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 18:58:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org"
	<kas@kernel.org>, "Wu, Binbin" <binbin.wu@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Thread-Topic: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Thread-Index: AQHdStRWGuydSOFmwk+y3PD7PUHSErbdc4qAgACkS4A=
Date: Thu, 24 Sep 2026 18:58:56 +0000
Message-ID: <066bce5f38f06bf92902c84a73b27989ce9554a4.camel@intel.com>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
	 <20260922205215.870563-3-rick.p.edgecombe@intel.com>
	 <arTpHVhVsVnNOK-T@intel.com>
In-Reply-To: <arTpHVhVsVnNOK-T@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SN4PR11MB9942:EE_
x-ms-office365-filtering-correlation-id: 23d9b034-3718-483e-c982-08df1a6de27e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|38070700021|4143699003|18002099003|22082099003|10067099003|10063799003;
x-microsoft-antispam-message-info: sYsJCMFLxNqcaL3pa3Ek55lJOyCNGJgVMYsVaypHOedqINMvXpImLVXIcCvdwLe8jyUMbSYFPJ3fwU1j4JXXvWys4XFQHgg1B8KAI770QJiWI4etYgndrKj5a/Udf1QunawdT4SNUxv6gPYTeM9jx5vDWvcAS9PkUC4IKjLiEkSgk+Lvso0r0WcQ+92nxukPDoYbqssNKbkQWO7DQgnbPL2NMwpscn0EKSlN5yOGPBTdzwrFZdk/nYI/kb8qNS8LyVWa/KFVzr5O2RpHMwTELz3yVxlqsIyft7c9YuChAY5y88G4M/Ym20+dSIs8D8gxPVGEwfX2O48QDOhHHqDz7TDK6m/7P/8BlqmaUrebfTD6gu+nruFYeUBhBj9HoAaTztdd1ydjwF4ie1GxfQyx/btprXO6NWYZYNhoyrsLeW6BaSNqZHW/GCd7mwyhPov6qrYRy0c3OORKT5Qn9LX4laujvEW9tRQcTJyDiiFZcKiwTJUl080CDLasCvlHJcFc+7Kf0C2yhyJuOuMRc3g1Keem+tNLqWWoc0WtPDnFF7VF6wSqBnA9XkJXXGFKA8EbIh3RyVQZjvRx2RDb3biDOaw+L31qIkp0AF89RSawYaMsJc7YDOzdyVHLLWYMmYG84y3nXyArfO+2F4cOg1rcUqxN2Tamr0OAFwRvJHu3/aCQlQcYcqfpgUa7Vh/XRpVup8zHh2dyqHFZDgEbnzTNxfg9T9AKbe9UWdLdewMgYMc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(38070700021)(4143699003)(18002099003)(22082099003)(10067099003)(10063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3pMNnNFSWJ6WXFybWZwUXNqWEwycjNuNnZPUkNNN3pJUDJVbzlvcFYzcS8r?=
 =?utf-8?B?Y2ljTGJMT0QwZWJ5d2N3WGJUeThFZ1VnbVJRN0hBS3k5Rlh4UGh3TGtCVksv?=
 =?utf-8?B?L04vd2t5NDNzRkQxaDNSa1RZQ29qSFFhMnpDamx5Mmd6QzhqU2RtSk9vejFl?=
 =?utf-8?B?VVJyTVc1QWFmK1V6MFkwMjErOUU0cTl5WHc3cGJ6aGk2Q2srUisxSXowTDlj?=
 =?utf-8?B?VWRBWUxIR1J1U0NGSHJDTGlPc2EvSGhIOGJWcE1uQTRlTWpSbWQ1dDU2T29L?=
 =?utf-8?B?ckdpVjMzdzV1bHcweGMxQ0lON1QyTUZUZ05pU3drcjh6VGNTT3FMNE0zNjN6?=
 =?utf-8?B?UUMxQlBUdWdIeHIzcEZUTUpBYlVlUHRYYXVDT0xOaTJmWW40TU9JZVBRR1Jj?=
 =?utf-8?B?czhFejU4akNaSE85WlhXMTkrdHRIT2F2eWd1ajdKSHFnOGkyQjFqTjJWblFJ?=
 =?utf-8?B?aXRBYU1jaW5MV0c4L2puUHFhRFJJd25sdnYyc0dvR2VGeEFmbmp0K2JaSFdH?=
 =?utf-8?B?QlRramhBQjllK0xqVmtOcDQ0Q1JQbnlmSGNZZWxSMHBBb0N3Q3N6REJyZHlZ?=
 =?utf-8?B?ZkJYcE1vU2p4YjlERUk3d08vT2tra2ZnbENZaEp1U3FrYmFTaWdIMHc4WjVz?=
 =?utf-8?B?aHRVU0dzUkdRbTE3T1BlK3Q0SlZVL2F6UmFydWxSdXZmaFNVbmxpd0xYbFE5?=
 =?utf-8?B?RFBWTFRlNGNPYW9PU1lzMVBpbjdqcm1GSXBORllDc2lNRC82V05nSS9iVzhp?=
 =?utf-8?B?dlpNc0h3cW85QkpDY1JyaTg5SUFyVUlRRC9JOE0zTlc4N3ZkRVd2MVRCdTFl?=
 =?utf-8?B?akR5bWo4V2ptaEZGVWE4RGlpVCtubElXUlQ2K2ZPU1VSY2kwU3RCNUxLWjJs?=
 =?utf-8?B?dmUzbmttU3BrOCtPRXErb1VqY0xUcWxHNit3ZW05ajU0a3VZeWtCQ0hMbExl?=
 =?utf-8?B?VlN4MnVYaEltZmovRDI0RE9GM0t4bHZSM3FObE5YZFNwSm1wd29NR1F6VUV1?=
 =?utf-8?B?STl1SUM5dVR1cWNqcUxhdnIrUW0ySEVzRlhyYWJDQWJON0d5aEFTVUFxRmxu?=
 =?utf-8?B?MVdYZ2t1YzdDNWtkemI3N1NhL0ZjdWFXcThWK2JTUmlaTHZJb3Q1bTduL3ZT?=
 =?utf-8?B?a1ZDRmNKMEh6OW9GbUE0YldrNkJSRW9DY3pHODVwSk9YR3UyWFJZemVWWHpL?=
 =?utf-8?B?enJrNEJnRVJrYUFSM3Q5OTd6Q04rSVROZi8zTlJhWHNzRjh6eThuL2Y2aGVq?=
 =?utf-8?B?em9HWFpFYjJrVzVxWjhkYjZ6bmlBakFIdzFLekNsK1VTS0RyVVpVcngxa2du?=
 =?utf-8?B?c253SWFUT1BvVlNaVFIvZ29ZSTRiVE5JOVFiK1Evd2t1MFY1ODhzN0xySnZY?=
 =?utf-8?B?U1hvSjQ3OEdRbDVJM3NuV0tnNU5wQzNDcC9DYjMxcUc3SFA2cll3cFdMVzRM?=
 =?utf-8?B?YXBVTno1b28xV0N3aWFnR2d2WDZndktoMUgyNnZPVkRkU3d5cU51VzlXeTF3?=
 =?utf-8?B?bFJRaWdtM3d1R3hNYTBpbllEa015bE5RL1htWWViZ2orL3VYZDgwRENhbFVD?=
 =?utf-8?B?S2ZNN1lYTXZKMi9qaFhwV1FkbHBQcTdxU1pSUFh6ODlxUm5lWUVZaTlpRUxl?=
 =?utf-8?B?UmZZTXk0OGd5YlRqVVU2RHdvMUpXRElOVHdJd3FSeXN1c2l3VVZmRkI4WFdw?=
 =?utf-8?B?MzFWUm5qYzNmWDV3MEVnU2N1WFd4SnJ4R25NcURzazVuSzUxOHVIZ2lTQnBF?=
 =?utf-8?B?MUxVeGR0NlRFclc2eGFvamZURDRBaitEcWlBTkxIcnl0azBqT0Z6YWI4QnJp?=
 =?utf-8?B?cThMMFZMR3hvTStHMzNJaGNnWENPSXRKaEN3QXRUdjh0bjE1VHphaTFpN1dE?=
 =?utf-8?B?a1AxVEJKWmdVUVhmOWUyQnUxSEdRVmJwS3EyV1NXTVRHZnc0T1ppZUJGTmhk?=
 =?utf-8?B?bWRCR3ducVdtV2lncmZlUzl3SVdwOWkwY25VSURlMDVvSTRDeU91a09RSzBY?=
 =?utf-8?B?ZGZxaWtJR2xpdWlhb1Rpb0JlbXh3dWFpa3k4aHVXZHVCOWZJRnQ3Qjc2aEJN?=
 =?utf-8?B?b3dYdXVEWjhONlhYTXBQYTVrVEVQSDZGeWhCb1JQdUhXUzRzek44MWxOekpw?=
 =?utf-8?B?amNOdHBtczB0SUc5Y0dmVUh2c1ozSWhTQVU3K3htcHY0cUMvbDJ1TURvdysv?=
 =?utf-8?B?blFsWjVabjFkODJQSUJqQVg4a3pFbTYwaGRVUlRoVk9EU2xVUDhTUURyVmVM?=
 =?utf-8?B?NUVxN3hBTnhXb094VnRyK0E1RE56Q2F4VW1Qc1FDQmFtNjlrK2FGWUd4QWZk?=
 =?utf-8?B?aDlmN0JmWnlQMEZXM0xjejNWeXRkNFVmR080MGNqL2hMTzZrNHQvb2svclNr?=
 =?utf-8?Q?7eLKK7s/SWyc3fF4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0517986B57EBD145BA762477C20C8E41@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Nig1Y0FRadJmJbU4tOYReeRaisa/0BHyPP5LTRr9bJeWl8Qo8RgXmdcNrNBtbUDGuzF58GPeBKoor9CL64KhU20ziIrYCU9bk/Y0dE6mf2DNjvcu9VUWr38UzVMEymJ4U1h5PWufvc+tnbP48EJpx4y8PCCJH6yr2XjRRKCO1ILquQyj+Mj+R38e72TUNFHoJtb1qDm1y1zzBwg2nMFBSQJUNxz0BKkHJydvl+gM+yP6su7Tts8pZUyeI+h21zw2xMdNTIs9cc8CosYT/qQikqiVgLZqC8u+KuQTfiLtgSCEiOfRuh5nmjgoPiSb9W8dVGIUHuECL/Xth8Gbdo5YYA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d9b034-3718-483e-c982-08df1a6de27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 18:58:56.3522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gx92w8nq7EgFQ1xaPyVUHxudNnnra6LZkR4aS3dPVMG96la1Drz41xX5skTvlho8effsvnzx2yxrk/BuHIFSQ62p6wtgd7kZKywouZAwm1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR11MB9942
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTI0IGF0IDE3OjEwICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT24g
VHVlLCBTZXAgMjIsIDIwMjYgYXQgMDE6NTI6MTVQTSAtMDcwMCwgUmljayBFZGdlY29tYmUgd3Jv
dGU6DQo+ID4gSW4gdGhlIGVhcmx5IGRheXMgb2YgVERYIGl0IHdhcyBleHBlY3RlZCB0aGF0IHBh
Z2VzIGJlaW5nIHJlY2xhaW1lZCBmcm9tIA0KPiA+IHRoZSBURFggbW9kdWxlIHdvdWxkIG5lZWQg
YW55IGNhY2hlbGluZSBmcm9tIHRoZWlyIHByaXZhdGUgS2V5SUQgYWxpYXMgDQo+ID4gZmx1c2hl
ZC4gVGhlIFREWCBkb2NzIGRlc2NyaWJlIGRvaW5nIHRoaXMgaW4gYSBjb3VwbGUgY2FzZXMsIGZv
ciBleGFtcGxlIA0KPiA+IHJlY2xhaW1pbmcgdGhlIFREUiBtZW1vcnk6DQo+ID4gwqAgRmx1c2gg
TU9ESUZJRUQgY2FjaGUgbGluZXM6IHRoaXMgaXMgcmVxdWlyZWQgdG8gYXZvaWQgY29ycnVwdGlv
biBkdWUgdG8NCj4gPiDCoCBjYWNoZSBsaW5lIGFsaWFzaW5nLiBOb3RlIHRoYXQgYWxsIGNhY2hl
IGxpbmVzIGZvciBhbGwgb3RoZXIgVEQgcGFnZXMNCj4gPiDCoCBtdXN0IGhhdmUgYmVlbiBmbHVz
aGVkIGJlZm9yZSB0aGUgVERSIHBhZ2Ugd2FzIHJlY2xhaW1lZC4NCj4gPiANCj4gPiBGb3IgYSBz
aW1pbGFyIHJlYXNvbnMgYXMgd2h5IHRoZSBDTEZMVVNIX0JFRk9SRV9BTExPQyBmZWF0dXJlczAg
Yml0IHdhcw0KPiA+IG5ldmVyIGFjdHVhbGx5IHNldCBpbiBhbnkgVERYIG1vZHVsZSwgdGhpcyBm
bHVzaCBvZiB0aGUgcHJpdmF0ZSBLZXlJRA0KPiA+IGNhY2hlbGluZXMgdHVybmVkIG91dCB0byBu
b3QgYmUgbmVlZGVkIGJ5IHRoZSBmaW5hbCBURFggc29sdXRpb24uDQo+IA0KPiBUaGUgcmVhc29u
IGlzbid0IGNsZWFyIHRvIG1lLiBJcyBpdCB0aGF0IHRoZSBoYXJkd2FyZSBkb2Vzbid0IGhhdmUg
dGhlDQo+IGFsaWFzaW5nIHByb2JsZW0sIG9yIHRoYXQgdGhlIFREWCBtb2R1bGUgZG9lcyB0aGUg
Zmx1c2ggaW50ZXJuYWxseT8NCg0KRm9yIGV4aXN0aW5nIHBsYXRmb3JtcywgaXQncyB0aGF0IHRo
ZSBIVyBkb2Vzbid0IGhhdmUgdGhlIHByb2JsZW0uIEZvciBhbnkNCmZ1dHVyZSBwbGF0Zm9ybSB0
aGF0IG1pZ2h0IG5lZWQgaXQsIHdoYXRldmVyIGlzIG5lZWRlZCBjb3VsZCBiZSBkb25lIGluc2lk
ZSB0aGUNClREWCBtb2R1bGUuDQoNClllYSB0aGF0IGlzIGltcG9ydGFudCB0byB1bmRlcnN0YW5k
IHdoZXRoZXIgbmV3IG1vZHVsZXMgYXJlIG5lZWRlZCBmb3IgdGhpcw0KY2hhbmdlIG9uIGV4aXN0
aW5nIHBsYXRmb3Jtcy4gVGhlIGFuc3dlciBpcyBuby4NCg0KPiANCj4gSSdtIGFza2luZyBiZWNh
dXNlIHRoZSBhbnN3ZXIgc2hvdWxkIGFsc28gdGVsbCB1cyB3aGV0aGVyIHRoZSBrZXJuZWwgc3Rp
bGwNCj4gbmVlZHMgdG8gc2V0IGNhY2hlX3N0YXRlX2luY29oZXJlbnQgb24gZXZlcnkgU0VBTUNB
TEwuIE5vdCBhc2tpbmcgdG8gY2xlYW4NCj4gdGhhdCB1cCBpbiB0aGlzIHNlcmllcywgdGhvdWdo
Lg0KDQpPaCB5ZWEsIHRoYXQncyBhIGdvb2QgcG9pbnQuIEhtbS4gSSB0aGluayBpdCBpcyBhIHNp
bWlsYXIgc2NlbmFyaW8gYXMgWWlsdW4NCnJhaXNlZC4gQmFzaWNhbGx5IHN5c3RlbSBsZXZlbCBz
Y29wZWQgbWVtb3J5IHJlY2xhaW0uIFRoZSBhc3NlcnRpb25zIEkgaGF2ZQ0KZG9uJ3QgY292ZXIg
aXQsIGFuZCBJJ20gdHJ5aW5nIHRvIGdldCB0aGUgYW5zd2VyLiBJIHRoaW5rIGl0IHdpbGwgZGVw
ZW5kIG9uDQpmdXR1cmUgcGxhdGZvcm0gbmVlZHMgYW5kIHdoYXQgY2FuIGJlIGhhbmRsZWQgYnkg
dGhlIFREWCBtb2R1bGUuDQoNCkJ1dCB5ZWEsIEkgdGhpbmsgd2UgY291bGQgZG8gdGhhdCBwYXJ0
IHNlcGFyYXRlbHkgdGhhbiB0aGVzZSB0d28gY2FzZXMuDQo=
