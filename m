Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7A296BC8;
	Thu,  8 Oct 2026 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791501421; cv=fail; b=MSHcwqpIga2EiXlY3jECKtWpyWAlChRR7KTkMWDdX4pYWaKpANLd4Qn9oCq1e/rbj6VJy7ZLMIsOOSw3mwv1DOx644LfEjqqPsuL907VQdVgaVxDp9qyH4NLRAAykctW6L/p+o1wt6K0uibVjp1Wv3hKU/MqJiFSS099v8Rv0o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791501421; c=relaxed/simple;
	bh=KFMAiKpKKnGSUDhT0HDAulA97rwTV9pMWLkLrNLhsA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUbTWtkQKspavzAxhD0ZpQAfqDPI0zx4OJsVUKzuwVX9WFvzOygkwia4Q1zkmfPoYr6oEAZCFT/36i7VXRgnj3accyU8BkGQweeMcDL99T09pPqzhxzQDXTlR9d7VNwj/sF3QLylYYM8YLc5yOPcTgLjazzNDJEl0DgKxD0jzP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSpjTVtr; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSpjTVtr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791501419; x=1823037419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KFMAiKpKKnGSUDhT0HDAulA97rwTV9pMWLkLrNLhsA0=;
  b=gSpjTVtrwg+C6tazZ6pfzI+wGrwom9bAQL2b+JkwR/VZqcZMeIhTgIX3
   GhmA9zikOw7NF+WNOc0GbQT9xsae5Sz+1CwL1ys+sK47q2hJ7vzWy5F8K
   U6TGr0eLBjj95CuAqSm8M1Bp2GhHTmMNCvX/0AebnGk8ODYULRg98gtkE
   cRcjYe8XaBVUvkE00/bj1jfEBk6H4EF4vQPQPE6Umb8muYVQyCMG8qC6v
   imGsxgeQzeFHQzV9lNELCcQ0kbDTXtWlkJWWc0ERM0S1onKAcNjbXCrti
   +rBq41oBmRMgGkrWmiSZXXz+UWTF/d1gDPwf+VEP41h5iZXZx5DHu62nh
   A==;
X-CSE-ConnectionGUID: 87ldTdpPSiasmHdv2vU8jA==
X-CSE-MsgGUID: ilKorMIZQ1GU2zvwFEeATQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="302091"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="302091"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 16:16:58 -0700
X-CSE-ConnectionGUID: 63PlPOSDTVSd3zhUIoER+g==
X-CSE-MsgGUID: qJT+LfIFRa6WzGZa0Ykiag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="619905"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 16:16:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:16:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 16:16:57 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.37)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1vjE1GU//YOvxw4XE/WI333KglSHLHpPk4h1eOeeb2vyGj0JnSf4oNvviDp3k2wd+w7idILgqBU+rU0Ba/HagzzCYfejv9dGmC03zwCc1TJ+PQCGHOfm3XGTlw9a9Jxh+qbxThHX0Drk9VbiWCbJiHm5AOQtkGhjYI/eTbnAekeb3zHfqHIHdEy8AGDHpQhWulajX1xcVyCR/qM/7/RcmzMroyBSCEsUuaeV6NLROoZUBrE/Q7TBE0++MyWRet+HdpH/LiZBDv819mhlDQPy206MiGWlYFHQ5ybfcshdtHUhRCZpMZfZvQRyY/pBwFETd65z8fjSiDs0wlVCVRDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFMAiKpKKnGSUDhT0HDAulA97rwTV9pMWLkLrNLhsA0=;
 b=vrPwoMOIgW6kgyqBu1M2443SBrJ09Wb9i9dNXVDACUff5U0oFQh0/VMNjgbbLNo1N3q9mjgJwHryqleA6S/5vkxlqLA0cq5Dyr5e9UlVa/EkAO1HBRlqOyxND2Xf5Gaj9OTyQgyrfdMIryihxLhh1Mby51UGFbWcRU5KCIeYLhyJcsZGn9r5u0F5Z+MLD/HX+lZpmRgwDL9PwzikVgQAd3FQWEQK8GCyb52Vq+9ELf51AMf7s0I7GQZQBQKU2Wt2HQmCYDqEa8lYgKnS2qexsv1JiRRytGstt+SI3Sv3eSLlDjB1mzNf6YidmvIAAip4+xpkqqxYWkWgybSlrdl3yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA4PR11MB9277.namprd11.prod.outlook.com (2603:10b6:208:55d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 23:16:52 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 23:16:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 13/17] [GMEM-DEPENDENT] KVM: guest_memfd: Add helpers
 to get start/end gfns give gmem+slot+pgoff
Thread-Topic: [PATCH v4 13/17] [GMEM-DEPENDENT] KVM: guest_memfd: Add helpers
 to get start/end gfns give gmem+slot+pgoff
Thread-Index: AQHdTyl+xg5dkObMqUKl8ebDXvbQ17b0V94A
Date: Thu, 8 Oct 2026 23:16:50 +0000
Message-ID: <b718b69987a2eba353b8b160ca845f6ce7bc7b18.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091144.15679-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928091144.15679-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA4PR11MB9277:EE_
x-ms-office365-filtering-correlation-id: 6f8cdbc3-bcce-4ff3-5a49-08df25923bd3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|38070700021|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: EKIqbJNp7GSqOgiDvJ35Js/mR/Ad/SWbaWBUY5o1FfPB680XX5QInd2IVaVgI5Nad6pCE0C2XofehathFkNuHxy1mNv29y+TYCTfhbhlpsrz0Vt11ntD/w+QZOWFJ+ixyZInY0kr5a/45/lQEKmUHmIgEVqpvoSv3GScsQaJopMEM4bUXwj2cBap5rtAnv1Qgw0IJLtrGe1tGu3/LutjjoUeJpxX8haEGKMMmU/BxE64a48QVN03qSDaRdgLyNWMtAF3Hec4T670mgvkhXiHnYq/FQ8/Jcut+f9ck1uKQ0uanEOPkw+gCfZcy0IBnrJYNGB1S9iMWzHdOEYVGbIaeXJKR2LK73Qp60n0MNZeAXnBYkdiAso6XLNFuYSjVv424E8Y7nw+8FriEuBoGOm20Pna4dfjL4e/YjxX9rniJg5cQl8A826fOwT5xIk0Uk+AyFaSsvWB/kKun80gO+dElp0qnupREoJY/Vk8eUwpv/KwulJsvnjZpVb876W04B1suQQiPnrPnW4/u6IanrVAlZ8XtvbrEbqkt/MepuqpOVnIpFjNqbjlUJfy481mzn+bhZtHudLP/yzWftBBvEQcfTNCeFpJwgiokeF1SPQLuGSMnR5ITOB4fEoKXFKtX3xPaaz0q4kugT1S2VRzepxWsX2YeaoxyDarnoBicfTyOlCGBzmEhaDwxDENYMpGzhDNQDWY4Fj/wpircx2sEnNRGjCuqp8VmnIeF2pfFqzCyvc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(38070700021)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjNOVllPa3VuVW9KQk1RYjRnZ2l3T0Z2dkZkNWc4Rk1qbXlzcVlDYk01Y1p4?=
 =?utf-8?B?MElNUDBKeFZVWmlDajd4bjRpbEppZFhQRXVGRnlobE5GOGFPK21LZEtxZklt?=
 =?utf-8?B?Uy9jNUxuM3ZLMHhGSTAyVnQyRDRxMjk2WWI4WjM5VlhDeFVkZS96b1RKM1I5?=
 =?utf-8?B?SjVTempCWXFEQVBvN29IemIwTzJLSVFKVFR6c2ZTU0tYWUJMWlJqWERTMVY4?=
 =?utf-8?B?NGM1SXhxRUdTSTRITWdFOEVkR1hLeGNQMkFENkhEY2xSSlQ5QzdwdTRCcm9n?=
 =?utf-8?B?MVRQVEdlOUlON0k4eGtFcEdQR1M1SzZhekJZc1RtYXpoNGdlZ1N6TXF4cFov?=
 =?utf-8?B?NWtoM2ZrbVVYdkQ5cnI0alVRMlo0OWF3VUt3L0dKSysvNlYvNUtRY3JoWWtD?=
 =?utf-8?B?WGdtMDZHbGJ4RGNYMTRldzduVXdmV0lNN2ZxSkoyamwwaHhEekgxRGlObTkv?=
 =?utf-8?B?ayt3SXQ1ZmpvVWMwNiszMjV1c1QvV2lvTDB6dW8wdWs4cmQvY08xcWNoK3Z4?=
 =?utf-8?B?VzU3V1pCSHlYR09SQ2dZTjIyYzB6Y0NzYURKeEpXeHlseDlWb0xOd0JCa0tw?=
 =?utf-8?B?QjdDTFdNYklGOUp6SDByYktTQ0RacFpOa3dyMURmWUpZRk1BMU9DKytZZG5q?=
 =?utf-8?B?anRGUFNQYU1JNytxbmFYUnhrMmdPa1dZRmhRdk5SQU9hamcydHU5cHpEVkJo?=
 =?utf-8?B?Lyt4SXdYcjNTRXpNazIrRUtXckpxa2xLSTRRVzhYR3VjeTNNYTk3WVRXQVJ6?=
 =?utf-8?B?bloybXREL0VOcW55V25SWU90d0RIVlZlRzBrWmhYOGJxWHgvZzFkOTVNcTB4?=
 =?utf-8?B?QUJKOUw2LzErVGFTZWQzRzNLY2xpbi9jNnlvL01tS04wYnovdHpLZU5DeWpC?=
 =?utf-8?B?Nk5QbDhtbjE4QmE4cGdkelYzc01xeXNFQ0E5SDUrdCtBVnkxQWZGSXdOZ2tL?=
 =?utf-8?B?ZGhGYVdJY3FQdGVVTFVPUVF1UnhobW5UNmpkNXdFV0JZYWR0TVBFbHNMbWNi?=
 =?utf-8?B?N3NRUnVRVEtuQ2lmQWFVZFYzUUl4bmxwZWJxcFhIdEgzRTRxRVE1b2lWblo2?=
 =?utf-8?B?SDR5VmlHSGdQbzIwVzZ4cnpFakliS0grWHRocG52YVowUmtNeklOTTBzOWNQ?=
 =?utf-8?B?TmZTVWFnaXUxdExsS0Y2QXJDbFRIaUZwaGtweThvMEdhSjdQd1Vtbk1yWGts?=
 =?utf-8?B?TGtIc0RqNURmRHhvaTVLcE1lT1hYR2pQWXpXaUNabjM1RjdWeGM0MVcwNTcz?=
 =?utf-8?B?clFiTFdlbURPZmk2aTNGTUJ3ZC80ZHZtUVVGQ3poM3BxSWNuNjFOY1dMaXNl?=
 =?utf-8?B?OU1WRGVkRlVRcklUWDI4Z2FmcEhFVUp0dzdBWU8wK3FiSGE4cDhaK2d0Zk55?=
 =?utf-8?B?c1N4ZGxwcGhSVWY5VTRIRFA2T1RFS2dZcDlORFlLY0dIelBzNk1rRzV2Y2Rt?=
 =?utf-8?B?Y0VjNXA3S3o4bDgzcm12SlpYMFp0M0VjeE52TzdGYU1NZkNFUEtsQlNWNElt?=
 =?utf-8?B?aDFjVDNLQnBTQVlDMkFSOVJXZlNMV05RYWNhSFN5eS9rcXdndVNEeENETjlL?=
 =?utf-8?B?VS9lcHFBb0FLRk9wRU5iNzZDbldybnhIRzV4UG5ZNFY4Q1ZQcnRTZzNpQ1RV?=
 =?utf-8?B?Y0JGK1k1WFFxUnNIaGl5RWJUNW1wQjVROWNtWk9JUHpadDdFM1N0NkE0STdN?=
 =?utf-8?B?MVplLzRwSVRSQ2t1TUlCRHRPL1doUGowam9WcU9uc0RQWXBQaGNXRmRNQ2I1?=
 =?utf-8?B?dVJIYldFZWNqVERBeGJOSks5YXMxYXZ0dHc2MXNUaDJOQW4xaE1PZXE3M3k3?=
 =?utf-8?B?bkkvN1FxQXhLUVNiT1RUaVh0Ymw4Snc0Yy9LZDRmN29OaXVvZjl5OHdIUXI5?=
 =?utf-8?B?a1FUaVRIbTBlbnR6NmFnREhDSmszem1FNHFkSzNOZmQxbkZyOGFTTE9SWXV1?=
 =?utf-8?B?Yy91YVROWDhKdUtmUmZQL2l1amVQa0NyNXRnWHMvNmtqZVlETWJ1UHRhVyt6?=
 =?utf-8?B?YXdSQVFjM0lYMmd2N0lKdnNOTlkweG5ZY01ZVnlKeGUyVWFPYXlQeEVvQURI?=
 =?utf-8?B?R2J3bGVWeWN4bWNRMFUxdnAwdThOeWo0dGR5YVh3ZlFMd2lPSVJSOXU4SFQr?=
 =?utf-8?B?V1dsTjZjSzU2ZHVpYnhrcFRCakhkaERnN3hBMHk3bEw4dFg5MEZxVGdlM3RV?=
 =?utf-8?B?MEtsVHVZZUNnZTh3M2QycTZGb3BJN1lBK0xUbG5QeWg5b09GajFHT3NtL1lh?=
 =?utf-8?B?Z290SXpwN01Ea3laOXp0Ni9CeTJraCt0WkF4L2Z3dldhY1prRzNXR0tjQWEr?=
 =?utf-8?B?aFl0ZTNKQTI4dlg4Y2FLd3VzK2NXVHNxQ29YRVlJRjVLdUNPb2tGYmkrcTgy?=
 =?utf-8?Q?JWjBPR6C8kUkSdGc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34521CF28E09024A9BC3CCD061A7FFF6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PtVNmgXgCXqGyrFMosyGF25bSo1gxTTgbj6x3Gbys3oPuFZFoSr2fl8gg4ui8G9FNYs5Odzy+ZXid69UmZeqLQMbY4T4KmiscNfR2OoFHo6tWDlUpxeoS+jQe4+XDvNxSVakCLys8TauTnx8Nhtanx+RESqK4+uhASo9zhBqUOZ7j53R/HYS43XoE+H8sEhuU8JkB82avc4ezabJjQpb9hvQ27A2K/7GsM3Ul/2ySduBQC0fUpD9eHxOIcVQBSEjayXnNcSD6+uxZsA2yb/QnmT5g9fmhOJRCd2LCR2Ea7FVvag2KyVk/odWdoWUhEs7JnuIZpik3mEqvq4pbb0smw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8cdbc3-bcce-4ff3-5a49-08df25923bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 23:16:50.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gaYyfUL2U5xg/goPDHVOKc9VR+JFV9VoOy0P1BnfbvwqZ0JVw4iydneg/oNNZlGHmX1e7xkQV9ndaBgdG6gSwUAGUqRbytKucp+Lo+VyFMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9277
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjExICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gRnJv
bTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KPiBBZGQgaGVs
cGVycyBmb3IgZ2V0dGluZyBhIGdmbiBnaXZlbiBhIGdtZW0gc2xvdCtwZ29mZiwgYW5kIGZvciBn
ZXR0aW5nIGENCj4gZ2ZuIGdpdmVuIGEgc3RhcnRpbmcgb3IgZW5kaW5nIHBnb2ZmLCBpLmUuIGFu
IG9mZnNldCB0aGF0IG1heSBiZSBiZXlvbmQNCj4gdGhlIHJhbmdlIG9mIHRoZSBtZW1zbG90IGJp
bmRpbmcuwqAgUHJvdmlkaW5nIGhlbHBlcnMgd2lsbCBhdm9pZCBkdXBsaWNhdGUNCj4gYm9pbGVy
cGxhdGUgY29kZSAiaWYiIGZ1dHVyZSBjb2RlIGFsc28gbmVlZHMgdG8gaXRlcmF0ZSBvdmVyIGdm
biByYW5nZXMuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBZYW4gWmhhbyA8eWFuLnkuemhhb0BpbnRlbC5jb20+DQoNClJldmlld2Vk
LWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=
