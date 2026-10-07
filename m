Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331C94A21;
	Wed,  7 Oct 2026 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331605; cv=fail; b=VGcZdwGooQaY8fL/NbE6yIJEq8ADyCgWhUTvCZzQYf9Jap48MJh/zReJLWv17L4yAlngIYXKz8ancrgZebDmPIaibYaMyNa0cRRaeh/tbz8cDh4vfgmdDnOwZrPHJ+cE1MmWnI6rt1Gsse4NYtfcm+DwATcY9ovdOsEUMLGzFcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331605; c=relaxed/simple;
	bh=i0teK4auJGyZ9rs3Iv0kUZbws5FBsDu/u39Tqtbto/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Znkj3y6/i3GxJH88yHrhdp7OBOfzYPM3JmXn/34u2ZiQpZDe7xBTj0cR8VvqIqOUbzQS0ihrib2Z/IYQ+p6abGskxsuH0P/F3ofV5fod+614/cgoiFAgi3BGArSf9gMkB3UiXMz/aQzqbmPri/oux5b8Ku9Ki41W5VvQxQ/0PLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0VPV6WL; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0VPV6WL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791331604; x=1822867604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i0teK4auJGyZ9rs3Iv0kUZbws5FBsDu/u39Tqtbto/4=;
  b=A0VPV6WLbk6vVAjPjgoWt+qwN6dnEZLxsSVshVYellEkxqYnHufKQT2C
   HREKaIiRSJISDL7Osxfh8wFrEpfjI+aXwfVHImZpgkuiYFXF4tXIRAykR
   daFRNWwrvs3m+yFOMroEksthu5crhmE+mTCNdamSWDlgT6rIPmw2Ramqe
   NaFgKaM5XNVscw7j6EzgKHYb/1Pk6hXbRnC4DWpHONbPeUoBCQmH9tbu8
   /PgoH/OB8Q0t3pSu5pP/0FTiAzugjK0oUg6zNZpMHD5Lt8UAeqjrleCjY
   j1JRNOlApM9y6rmlYR1K26gwQLcwG6+M3te9Px7hVAcgDRuYHEDz0aw8T
   A==;
X-CSE-ConnectionGUID: G/oo1uTGShyXwsYWd6C5mw==
X-CSE-MsgGUID: 6F2EXDULQHiDJXNE+cwBkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="108411852"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="108411852"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 17:06:44 -0700
X-CSE-ConnectionGUID: Tsztu85ASM+GEKZP7lmtQg==
X-CSE-MsgGUID: ZDvq3q64RYytZCT8LGEMkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="277433073"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 17:06:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 17:06:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 17:06:42 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 17:06:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9BXO/BCdSCZxMzs7GI5TEaZQExz4HE6WXJWxbxlxiPmoyOaayUOPiowMq4BCnfVagimhexupEyjNrMbKq4qbVlc/Ysk9ip1dpBcVwFkBwmNJxvFfdqWz8lgXc0WPsVFcD3ImzUNKcrzW1WLbuavaI84Qr0UdPMihSKpMLAq9sy/3+i2bXL1Vr/zh85OSfj1Aa1IGPWVYcz7sgTHSnX6Ywr9+oKy6m+iKJ9ewC7Ql/fUqmzubzBAptkqR7sOk9J+X+ereJffQMw07FaEidz16Al3wFcEFjygtHCVxrnTuvDVrEwjRw9CItAnqy4E/fHNHzENyJ92c6G6dlFzoqXGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0teK4auJGyZ9rs3Iv0kUZbws5FBsDu/u39Tqtbto/4=;
 b=gtvALBQPkIFpuQ4WXenRbmRYpH8AqYBqYn1PGuWrEI6S2imtgTU8uTLPdoCw9Ia95NhIR5fr5kNVlzmN4otvJpn3AesgDW+mOG8enZ2FtynvgVAlCzdOKJ6jOuqTtLgsdXOumdVPjI9vrZWaQ3eirw42bH132staAf5rAL9w9aIoldOQftKA/lfx7Q1KqQVwa7DdBX6fWKYJrzo+J9T6TmCNKFz3tx/Z8Y7lF0zVZUFmy4FQetJIKQhp4C78SDLOcUO5vW4qsX2TLr6X2itCbW3GMhNBJ7hshaBY72eSJfOHkXRzjueZEDevGBozVgkY1xCHcj2Zxtrj+MRJNkXqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB8685.namprd11.prod.outlook.com (2603:10b6:8:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 00:06:33 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 00:06:29 +0000
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
Subject: Re: [PATCH v4 03/17] KVM: TDX: Reset private huge pages after S-EPT
 page removal
Thread-Topic: [PATCH v4 03/17] KVM: TDX: Reset private huge pages after S-EPT
 page removal
Thread-Index: AQHdTykoxjlKE4jackOgOzTXcAcEl7bxQRMA
Date: Wed, 7 Oct 2026 00:06:29 +0000
Message-ID: <b132f782d73a13b137b6892d1a3b80360f676776.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928090845.15518-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928090845.15518-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB8685:EE_
x-ms-office365-filtering-correlation-id: 99d44794-7c47-4d34-c4fc-08df2406d62b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|23010399003|366016|376014|38070700021|11063799006|56012099006|4143699003|22082099003|10067099003|18002099003;
x-microsoft-antispam-message-info: ehHGcFiTJec6shKLVYcaGF/cmXLzCyWRkIUZqb/1GW2Uri8pqP9DLHwE7ZoFcwLW6sVmtxS9atBEFKDzJW1a08Kp2BOHa0+5EJIl5BN2+ruuZmSX9mt3b7AQJEiAsFcNm2gSQ0weedhh4++q2q9JqMqsB/Zj4jHMbDMXM5+EtYsoMj7FCPwJAmvKn0QHiI4hIdOBaAd9nhbHzDdCxXvapvvqu4YFE5UgOEdvws6aekmbuSV+qSNKC8eYH4EEhPafubWPpeMKeKL67k9W34hWtGZ25ymyQZrUD4U9WyGMT4wENTHSSabBbTIXIq4Gent8gCpyYVrZdnM/9MNo/QnORojoVYQcvdH1lkxdIWELW/u5L1s2qZOt8AxwV17GLCf/YquTKBdf9VugxfsJYMEJBE9v14uxuLb2xuQ2w3TdG5iL24i5PUzlA5OR+cM1ug8AVDM8SAq/XPXWoCcgoI1tFWdKT+i5YoYFO9+2gN64L6ZLPT6JQa6AFEDtaQGSL/YDICE74eDyst0etaieMrSBXDAmEb9jYwViYkWBYW7fibbMloDLCNQqGpeaz/nQHzbNDsjtVTareckyR7UKFLXk1h2fq8Ht8ixRGmpgX9JXb4OcbM1YMn0M22t4UJpHGGjZKq1QBqg2j5RNY/Bk/2AFFm/MgEgO3TX4iEcRib4fZV3EBFNynm9lA4lCqzz+Rla3aDbqllPP8mlgPSsmm4RqgwRPJMljLkwYdUk7pUFZ+Ys=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(366016)(376014)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akw1VnZvbXlSOU40cGNLaVVWTmVaNDBSb2ZyNjM2a2NSRVRBcDVUanRKcHQz?=
 =?utf-8?B?WUtvR3drR1Axam5Ra1Z6Tm5JN0hHU3ViRkw1OWRyN0NXcUpBYXhITmMxYWpp?=
 =?utf-8?B?WFczNEhsS0NHRTQxT0xYLzlLY2RNVlovUkd5dTNMNjVPVUNYSVduc1VnVGo5?=
 =?utf-8?B?RDh5RGJ2b3BqN1VRSHNFR3MyeU5jSXJtYkt5WjFuMW4zZGNENUlOeWhVN2hq?=
 =?utf-8?B?aU1reWdMYk1rQ01DM2FLS3R2ejdCN3hjQ2ZtdmhES096ZGVldEdzS2wrMllY?=
 =?utf-8?B?T2N0b3J5YTZ0VlRsOEpBSWNjdkdCS3BTbGFiODRmVUowWjJzbFZITGpSOEc3?=
 =?utf-8?B?cmdtWEc3RElEbitlZCsrYkEzU3R1b0hCYkRxQlhOS0JrdVhSQnM5NjVxUmI3?=
 =?utf-8?B?UndoL2FvRE9vZXZVZ0tMbEUyMGlUdEQxTTlrWXFBa0crbW1vNXdPM1E3Vy8w?=
 =?utf-8?B?OGhNSTZpUndKR01vMnZJSGZpeTUrMFBpeHQvcmRDekhhRlVzdFNrUjM5Q3or?=
 =?utf-8?B?eGNWd1ZyeVl5M0xyUW55SVNFU1B6ZkYyMXAzVnN0NUt3RWtvdVNyL1NIOXBG?=
 =?utf-8?B?SWxwSWRJc1lGVGtSNGljRU1sNDhIeFFtTUk2NlNib1ZaWEZPejYveVhWQ201?=
 =?utf-8?B?TmtITlVsYXIwMzhCQVpRZVV1WjJMamQ2ZDF2Ri9xamJpMHNIQmRiQ3lScXBK?=
 =?utf-8?B?QWxTRzV0Mms2dzBUcE1ZQ21QV3QxSnpqMlJUaGttMWJ6THVTamhpT3RBMGdt?=
 =?utf-8?B?RDZ2UlRZdU5rNnBtV2hRelY2VXRpK2kvUFAwOTc4WGxxSTJhSk91cmlvT1o1?=
 =?utf-8?B?ZHR0WEM2Wkc4dmUvMFJYQWlnKzNNdmxSUXB0ekk2c1h2TzdFOUZsb1ByUmpI?=
 =?utf-8?B?R1RzSlBuMkZ2Z2R5YWMwTktGZTVhd25obXk0T3RzeVhxc29DOWtWMXA0d1dB?=
 =?utf-8?B?ZVFMZ1VvTVVOWlRKRElHN2ZuREVUalU1NHlFQVZnMHZKOC82OUNHQVEyVGh0?=
 =?utf-8?B?akgwREhadGc3U2d6RUhGMmVXeDZPMFNIamNQUWJTUFYrQysyc3BwZUtMajll?=
 =?utf-8?B?RXRQbGxKbEdJWjFCeVpSZ3lVYmt2R3dlS2JOdE5CR2tEbWxoSDV6MzZpczhp?=
 =?utf-8?B?MFY0ZUNuc1NTVEM4R1IzMU5sSDdBQ3I4OHhEUXhIWnlHUWdqSWQ5NjVjOERh?=
 =?utf-8?B?cnV6MEpSaHRldVE2bFh0UFFYT0JpTlF3SXBtZ2lzMmhOVXFycHpvZ1JmaGw2?=
 =?utf-8?B?SjRDUkxucHNkV3lKM3B5NmhpbVNJT0R5TEVRbmxSYkludW1UNVJoS0VzdG1S?=
 =?utf-8?B?bVE2UHZ1QmRkTDAyb1pXU1drenlSQnpyU0tpQnBjdVdJOTZuL2hwME1NcHZs?=
 =?utf-8?B?eTZuRHhVaXVlUHltYUhJL1VmRWhZSUNYM2JhNitob21ZRWxaZGN0TjQzOFNN?=
 =?utf-8?B?dFYwK1dCdkhRM2krbnZ4UjhuZVo1d0FGOUJTdFcxTWljYktia29WMWZDVlFy?=
 =?utf-8?B?c0NUUDVCNVpiYTljWFVwcnpGc25DTGt3N0xnWmdNdVNndU9oTUk1cVdMQmRP?=
 =?utf-8?B?OGlkNXFNTG5uTDdidzhhbVFtUktTMTl0Zy9LL1FqMUFzQmd6bXRteGpSRkxt?=
 =?utf-8?B?M016N3M1Rk5EUTREWmxFQlRkdUZOLzBpYzl1U2tvYzdRMG5JZ3cvZStGaCtB?=
 =?utf-8?B?ZXc4RHVzVGRVeXVYaVN1R1ZQNy9ONTFhblJSQ2IxbHNEdTI0bk5PRFN5dHEr?=
 =?utf-8?B?bDJ1bUxiSEtTWitiVm1CL1pxamZ4UzBwcWdUM1gydm0yTjRldjJFRWt4bTIz?=
 =?utf-8?B?cTJlK3JpMEFIbi9kQmVYdCtFaXpRUUpuYXU2Y2gvRWVwQXNDNVdDUEZLL28r?=
 =?utf-8?B?M3hyTytWY2ZiMyt0TExHZjRhRHBNK1VtVDU0OERRb0JEelQzalB5K2pENHdm?=
 =?utf-8?B?QUpnbVVsTWNVSGRQb3NkNVJDTklrK3hOcWhnaGVUMUNCNG1QMlVFSkZnbVhR?=
 =?utf-8?B?eGNOamhnbERCWnR0L0xwSkNiZEVBdmhFM3dTeVhtSUxnVEtyQXVhY3Zxb05C?=
 =?utf-8?B?NjV4SDRCR25tTm5mU1AxbHQvUTZsS09iZmNrcnM3TnNzNzhPUGt0N3B2em1T?=
 =?utf-8?B?TUFvblZSdkl0M0JqbEpYOFJTZ0l4TGhsb3ZHcW1aaVlFM1lyWnY4K2R2VjNw?=
 =?utf-8?B?ZndSdEVPSHJtTWdSYTBiNHIweE5ZaUtlWVVMbjhFZXRjb1pOYndNMlU0bG1N?=
 =?utf-8?B?MkdpY0RKa3l4TW9aTjZUc2doanRnaVZqUEMrS3luNXRXWU5LT2g2bmlSa1Jn?=
 =?utf-8?B?RUMrOTArWWRZVTVza0N4MkJadjZpOGE5K0N0TXdpWkhCVk9UMFJyT3FjZEtL?=
 =?utf-8?Q?0SIBCh0nXHeZ1Atw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DB2FFDB64E4914C96DAF20B0DDEF8E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M4lsszPkqCwFKMRyEj9qt46j3WSOVKcYG8plBjRi4WC5VaxhQo96yLjCWLgBGNBuelwoEgywJTkzZs2pvEPb2H2tLeNhiTS60K+g35Mb0BoH6NFFAerCjK9L1x9PMg0xdhgDHKx+KT5O4dP2yoWuIE60V7l2kNbo/gMspfroH49NiWyKNKuAQrIDhytmfqLdJPmT+i9oGi4BwqOiHZWAJw6V1TsDE0RhB4DzVpTr4+c8JL9jy4NSNXrc2QFEnZZLE2waIzbU7elL++fF+p08qQcvfYJJVCyppZd1xIv0qJDhgxMcD/dE9w1rzihk0d4ORgq1Soiny9mEFjfNpxDT5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d44794-7c47-4d34-c4fc-08df2406d62b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 00:06:29.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TARVLt6sTOmYsDMW8L0gcYmZXcVHxIJBa1kLs73D8bqlo3ofu+y8Y9tkeu5q1+QWn5gD8d0AR9et4amFuFg7NNnM/JBAoEw/MXDc3+2tfNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8685
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjA4ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gIlJl
c2V0dGluZyIgVERYIHBhZ2VzIGlzIGEgd29ya2Fyb3VuZCBmb3IgdGhlIFREWF9QV19NQ0UgZXJy
YXR1bS4gT25jZSBhDQo+IGxlYWYgU1BURSBjYW4gbWFwIHRvIGEgaHVnZSBwYWdlIGluIHRoZSBT
LUVQVCwgdGhlIGVudGlyZSBodWdlIHBoeXNpY2FsDQo+IHJhbmdlLCByYXRoZXIgdGhhbiBqdXN0
IHRoZSBmaXJzdCA0S0IsIG5lZWRzIHRvIGJlIHJlc2V0IGJlZm9yZSB0aGUgaG9zdA0KPiBjYW4g
cmV1c2UgaXQuDQoNCkNvZGUgbG9va3MgZ29vZCBhbmQgc2ltcGxlIGVub3VnaCwgYnV0IHRoZSBs
b2cgaXMgYSB0aW55IGJpdCByb3VnaC4gUHJvYmFibHkgYWRkDQphYm91dCBURFhfUFdfTUNFIG5l
ZWRpbmcgdG8gcmVzZXQgYW55IHByaXZhdGUgbWVtb3J5IGluIGEgc3BlY2lhbCB3YXksIGFuZCBt
YWtlDQppdCBjbGVhcmVyIHRoYXQgVERYIGh1Z2UgcGFnZXMgd2lsbCBiZSBlbmFibGVkIGluIHVw
Y29taW5nIGNoYW5nZXMuIEFuZCBpcyBub3QNCnN1cHBvcnRlZCB0b2RheSAoc28gdGhpcyBpcyBu
b3QgYSBidWcgZml4KS4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWFuIFpoYW8gPHlhbi55Lnpo
YW9AaW50ZWwuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2t2bS92bXgvdGR4LmMgfCAyICstDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jIGIvYXJjaC94ODYva3ZtL3ZteC90ZHgu
Yw0KPiBpbmRleCA0MTBjMTQ5YmY3NzYuLjExNzkyYTQ5MDMzMCAxMDA2NDQNCj4gLS0tIGEvYXJj
aC94ODYva3ZtL3ZteC90ZHguYw0KPiArKysgYi9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jDQo+IEBA
IC0xODY1LDcgKzE4NjUsNyBAQCBzdGF0aWMgaW50IHRkeF9zZXB0X3JlbW92ZV9sZWFmX3NwdGUo
c3RydWN0IGt2bSAqa3ZtLCBnZm5fdCBnZm4sDQo+ICAJaWYgKFREWF9CVUdfT05fMihlcnIsIFRE
SF9NRU1fUEFHRV9SRU1PVkUsIGVudHJ5LCBsZXZlbF9zdGF0ZSwga3ZtKSkNCj4gIAkJcmV0dXJu
IC1FSU87DQo+ICANCj4gLQl0ZHhfcXVpcmtfcmVzZXRfcGFkZHIoUEZOX1BIWVMocGZuKSwgUEFH
RV9TSVpFKTsNCj4gKwl0ZHhfcXVpcmtfcmVzZXRfcGFkZHIoUEZOX1BIWVMocGZuKSwgS1ZNX0hQ
QUdFX1NJWkUobGV2ZWwpKTsNCj4gIAl0ZHhfcGFtdF9wdXQocGZuLCBsZXZlbCk7DQo+ICAJcmV0
dXJuIDA7DQo+ICB9DQoNCg==
