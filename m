Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642263783C3;
	Mon, 17 Aug 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989303; cv=fail; b=umP4QRkp+L8lux94mkoybH/gBUF2HP6CTrBdWkrK0cZsJGSDwz/4EQ5/x0nJUqzHgAFmvN3bEKC/B/vEB1jgPHI6f9TdG9DI/pxmHld2Z2VltnnIJCmnKUPWwScKHs3iYrheB6j+yfsD6CfxTYl3j5Nd+tfWlPRCCD3JR9eoEz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989303; c=relaxed/simple;
	bh=ngarJWFVTw20ShHFfm5i+G0/dUrpU82wW0mVaX7zFzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgbShtCDVmgQ8N58OiF5hmgIAH+jRNHgs9BHCyLeKFRxLnD9DIU2PKav6H0BPbSsAggbKCt/tUDE4ZpRALPBlnm0B9sUl5Y32GhuqudPqdFv2Dc08UyQt/fT8vcu9knGnunh5YHRVfila/JqHNUnt+YrRAgxVwwZRRyNHFRlQbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYPKS97u; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYPKS97u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786989300; x=1818525300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ngarJWFVTw20ShHFfm5i+G0/dUrpU82wW0mVaX7zFzU=;
  b=WYPKS97uu1DEno1g6AGAKNirChyVtMkmNqyXR5Vl7q9CNVioQ4DOvG5n
   8LGF3muBjnM/aGfCM9jN9afAr5kR1zMNrRF/BLl1qPmqhfftHiFjzB0oC
   Y1KELr5kH3gxbdNRG4aan0a2oaIDSCV2PctOXO+vpplg/gjXvIJ6lA3hb
   N6h7LFDVsKdn//rJkDy2ZPXfB/Y6Jg2AVMDCMOILIEOmEcePLo7Z3hzgw
   I98Zz0Y0W/eL7S2p839TdmBi/EyyIXKHCvl1Kt5TAKfOCMWNm+L+uob74
   7FVUfY4ljEvODwhOmD8fQ8i+2tmfGV8gqmjtNF74lutBhM/0o6J8GUYBC
   w==;
X-CSE-ConnectionGUID: XJtF3F9FR0u9wdmk77I2Qw==
X-CSE-MsgGUID: KDKvFwGrRCCOCwrbgwdWmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87326361"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="87326361"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 10:54:59 -0700
X-CSE-ConnectionGUID: CQcMcR1URcKJuHPcFyt9tA==
X-CSE-MsgGUID: EqUG6DDMTX68iPnw9gvd7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="268471690"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 10:54:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 10:54:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 10:54:58 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 10:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZ141p7PB+w06TxRu0ZBVTJInByk5eBKqw760lMzf3q6DK2GXcgsjgslLzdyvEwm4S0BB1GnFaLOZ1Kkk6i2iCkTqtjVl4mEumB6bov0+8yE2Lp6KSmZImuxyBIyzsjxQ5f6HpdBQKtaE1JBOo1q/5S7fT8gdtTMcdfI6C9lhpjTSIPgYQ8wkTEQeua9AWkNLr1GROwmsopD2TaopkdktOI9u+gZwtvxTAzZNzbNFwxAAIlQUw6kQNkuAIBKrWJMwIHOJUlR4mP9WRBuylY1/g/NXP7hYkHLREnt+LEPy45S0dyYDTGwtMm99tdFaqobAfszJ3pGpy7myu1EnS1oZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngarJWFVTw20ShHFfm5i+G0/dUrpU82wW0mVaX7zFzU=;
 b=Hl9gvcDLCKA7CWfX0ZWEWMSPC27R6fBkjvkOh/2HU4+tCsr96BSadh5X21dyqNxAf2TGGqI7HbSxYFFjQX4khbbh8UWtDp0DLJDOqsx3CjOThZRS0wQgHHM6J534O9XLbJs7//IqbRHXVY6G+h0E3iursiZf3jThwHRZ7dAjZxlhwoGuIKj9Le/mKjRLkNtiErtfakNr+x85cwwvbNnmVRuXOO4FNrweo5/LQtBRj5RxbAXgfUHltV2U30QUznXApcDKMyIiw7N6rthOlrqA2PVb91obfNU4v/tSW883amjXEBNH6S8ZMIn4Eah1WB7Mzj1JlPlUZ8v5N4ezShjJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB7728.namprd11.prod.outlook.com (2603:10b6:208:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 17:54:54 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 17:54:53 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>,
	"oupton@kernel.org" <oupton@kernel.org>, "wyihan@google.com"
	<wyihan@google.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"sagis@google.com" <sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Wang,
 Roger" <runanwang@google.com>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 00/22] TDX KVM selftests
Thread-Topic: [PATCH v14 00/22] TDX KVM selftests
Thread-Index: AQHdGi/fD3HeSKoX5UGSIW2nqtNBd7actxyAgAAE64CABQ68gIAA5NqA
Date: Mon, 17 Aug 2026 17:54:53 +0000
Message-ID: <0782a971b1e6aa64c12ba76f9a4e68c8fe72bd2c.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
	 <5a44a6925715e1edbd379ac0ea5526ec990eb819.camel@intel.com>
	 <4828f8e29801adb29a4d48b8980d3b3a0a813e06.camel@intel.com>
	 <CAEvNRgELDhXvPFKaoz+w-yywoJn0WMWvA-Y2jfdnwJVSbCSWyw@mail.gmail.com>
In-Reply-To: <CAEvNRgELDhXvPFKaoz+w-yywoJn0WMWvA-Y2jfdnwJVSbCSWyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB7728:EE_
x-ms-office365-filtering-correlation-id: 06c5b1a8-4484-491d-d5ce-08defc88a47d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|921020|6133799003|38070700021|18002099003|22082099003|3023799007|56012099006|10067099003|4143699003|11063799006|5023799004;
x-microsoft-antispam-message-info: /T6TM7nie5jmfw/MpeLHIiuoyZK39cAkuA980lkl3kuNJSPS9CZdLSszyiJYo9RziNlOU6izFuYlAuZWnNFatQ13iWA2ZDNBcuihhRQ5jshHo9ErPjiXOsmpRpGinvctTYFfA471iPNklJSpgfTcRTVSdPRrs0Hbe/oapzU9cl6cIia3RiZr6xc47P6BpsBbp6jA4U1xAZ5xvs+NpA8fEAqv4iQqZ3vzlpeqjW1Ezov0jdA89dZzMCLv/3dKTeaa3bbLEBugK918A1EGIC42urCRrLH5QnVmbQUdWkvFC0Bn3b+UvdGShoYUqus4wSsTrgpTkqNy9OoVBrUwHHuo02F1pBSgfK1Nv0f79WbT50yGoaUi8mHb6l7rAPQpGYrGDoGjBZOUIi2K1ShNr8K+Sf+a3BdNf4HkPZssUJkKpUlkl3jq0OsF3WpJbxWSY06/CV6UGWkAQb51SCoWcj6fDzphBaZGFn6x7JjdsxK7s3AqYwKgMH8iizSgGJJVw5ZGUtHZdJMi3PHJeOfq9d+aooDYfH7HQoBOc5L02KPC+rYC5uGo8pP7juWK9ar25HhczPUwXwMZJV1PQZWJxnf60o6b3RsnT2OwDVOl3+IGtOB+efxTVgWh4HwhrWG55Y+8yZkhUIW9bDrxifoZOtDUiKeMbKh/Ucx66XJCORBAh2sfP9mrWPXvshVofUA5wsCF5a4g8yEXg9Bh5l0EUn2E6qTlK8A2l6C1PyxNSv8So8bvmj1n+sYgYRIr4d7E10+8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(921020)(6133799003)(38070700021)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkhuY2tHMmhETWhPTE42WkJpaTNHZDhYaDVsQVRSamd2L2pEbTFuSjdDa0h2?=
 =?utf-8?B?L2JLNmlzemRYUkJIbHRIbkZuTjg5R3hJMVV3ZkhrYS9XRFJxSGlrMy9PeWl2?=
 =?utf-8?B?ZForeEswcHBKSkNDZTVsZnMvSXhPYnRBdFBuamFnRzVUL212TVdTa0c5MFpD?=
 =?utf-8?B?eVFJb0ZTb3U1RTBQSUphUFBmVVdwMjc1TW1ZRjVpYUd0Qjl2c29PVzNjWS8v?=
 =?utf-8?B?T1B1ODBwSFl6TWlrQkFjNXc5Q044NisxZm1pT0J3QzFJSU9VcXMzN0toWjZG?=
 =?utf-8?B?MlY0elJNUTdML3dtTHVxYThhRmN2RWJqR21PK3VKT0VyRE5OUExtUnVzVXNM?=
 =?utf-8?B?enFnY2ttYmZ3NUZXSnRHL2xQMHkrVmU4bWF6Mkt0R0tUQzNYZEZkK0kxRkVx?=
 =?utf-8?B?RDE4UE5vMTZFZXpvOFBreFZUT2xiRWJnaGU4em1iVFNOeElzV0lUTnVGL0FP?=
 =?utf-8?B?bDR0RTVxZXdpNXNSYmVVU2tvY0s2YUVFZXdaMjhDWWlEUFJKWjBHaXB5Zm5p?=
 =?utf-8?B?eHhnTVdvSWNNVGs4OGxSUU5nUnZmV3EzWEF6SDVEenl5SjhKR0VuejNadXRy?=
 =?utf-8?B?emlwTmNZM05mMTk4dVVGQmxQV29GOHRybk1zZkNlMU9LazRsa2s0M3ArYzg2?=
 =?utf-8?B?Q3JSbEFOdm1hdHpCSUpQaWcyTS9ROG1QN2xPMURVYW5YNzFvV2haT21VYmVM?=
 =?utf-8?B?a1pqSnFTNGJRbS9tRUFjNjd6RHhvcXZQYmxWVFRQZy8rcnpsVWdMd00rRjlO?=
 =?utf-8?B?aUhFOGdBTWh4cUVKcHIwYzBWRzNkQVlCNFYxcFQrL2dKa3pQam5KZjlHb0tt?=
 =?utf-8?B?OVMvYkxHQkdOL1l2dkNaUmRnaXpKdXN4bEY0MEdmS1Z4dENtRkJDU09JaFhw?=
 =?utf-8?B?Nms0WEJxYlloNGVhcjViZDQ3Mjl4MStVRkFXVVNiN3FuRGtBTjRKblRySjJz?=
 =?utf-8?B?MThDVjJNQk1saTcxQi8vMU0rYUEyM3ppelRSOUgvYmtIREdkRURkYi9ER1Zm?=
 =?utf-8?B?WklwUnJzZkpxOXBNUHFUQW9WaGhqMEZxaDNrN3JobThFamlieGZIRjBhSUlU?=
 =?utf-8?B?SGx6U3BWRkZrb3hBR2xzUG9IeCtVNFRMZWNBekNSQ0lHRG8zaldSV2pCK1Nu?=
 =?utf-8?B?OWlZT29VbUNERkFETGg3aVVNbk5uRGhqUVVDNi9aMVN3OWxocXhFQi82QUNX?=
 =?utf-8?B?cDAwY1p5MGFOT3dzWEJyZFc3S0I3cnNNcEg5d215bW55cHhKZDJKK0JQSXZt?=
 =?utf-8?B?YzZyemdTNm5GWjhTTXJNZkhKWTFXcVVqSndFU1ZXcDFiamRBVU9KNTUya0hT?=
 =?utf-8?B?M0xCMnRTd1lJZzZ3Z2ZoUktDd2czMVdrN0FPU0kwelR4d1hEekZRMVV0UlBs?=
 =?utf-8?B?SUVDZFgrYlBlVk1LUVNVcWtnb2hScWNYNTFjeXErLzVFbEdidGNmOWZhVlJw?=
 =?utf-8?B?MUxWbjMzSW8xeFlhTHBSUER6ZzI0K3V6dm5DWHFFa0VXZkd2MERBNm03NzQ1?=
 =?utf-8?B?bUE5cWtUMTVZWlVGVDJ3ejFjSHV3UmtDbVZZZzV6eVNQenQ2Z2ZYbWpUVWw3?=
 =?utf-8?B?VEV1UEg3cVYzR0lVUlZBRlowRUM5TE03T1A1S2FObnJxWGd1N0pMaFg1emZT?=
 =?utf-8?B?Z0N6K01FY001M1Nma1FTam5id2h1ZW1YQjE0eDU3cHNJWUFoN3Y2YllqajZ1?=
 =?utf-8?B?bnQreG40NFBER0dPazRQQmFqZW9OZjhGMlRjblhRL3ZObXBZbTlrbGIxbzF2?=
 =?utf-8?B?M3J5RDlEa3V6N09OSTM2KzRWRUs5bXhiRE51ckNIMUZoTkZXTG85b2VDUjZF?=
 =?utf-8?B?cHBYaVRPUmNlRmJEME9GVDVyZitCYzM0M3hZenRNZFE5MDEwekJDV0NPZGhO?=
 =?utf-8?B?SHd4eEpweno3Smo4SXJhUkw4ZmJjWEZDNWFaaVo3UmtEdVMyUEMwbDNCY3lQ?=
 =?utf-8?B?K2tkMXpqTnhmMFkrYXpLNm4zZnBYOURXTWQ2R0ZZa0pkWm5hZTBpcURYbGFF?=
 =?utf-8?B?azJkWGp0eU9EOFo3ZWJyWHpYd3dLTTFoZDZhb0I3N2xQalF1S1lQRWYvdXpa?=
 =?utf-8?B?ZGVzUWE2UVdjcExleGFTZGpIUUNneTBpL0hYTE5jbTF6UGFibnZocXBWU0dk?=
 =?utf-8?B?bDFUZjc0ZmhvWHVHU0djbVlsYzlVN3AxbGpUY3JVd2JtUUJxcXVnQllkZit2?=
 =?utf-8?B?VVBwVXpRdzRnNW5TeGtwTVVKM1k0UlB2bzBSSE1Bb01DVlFDN2gvbUNXbG5h?=
 =?utf-8?B?TmRVU2RPeGZPY0F4K2F1c0xCTGNyTG5OTU1GSkFxb0wzUHlMdnlUMDFrVys2?=
 =?utf-8?B?Z25hTW9VbjdOQ3BEeWdLL0wwTXBjK1JOeW1QdnYyWU5ZWlJtV0NZTi83YlBO?=
 =?utf-8?Q?Xx1dn35d3EdLVIUk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0F7B280F4ED624EA0CFD8352FEA9D3B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YyhouXl7ViRvOFeYDFpiapBKbGZfiBIZWUbLkPDLwcv8dwqyDhY6/GtJ1cx1U+dRrikK3ktKon3g20t+7R37RXeD3x+wM3XSscVvUffETanlaTRzABRk/kSH0tSq03NsXxsIWQvaI/OsRhiKXgbg5B+CudHdBPaZheTOA6mOFS4gXOPAPSWOisR81iLAcNV1p4P3IOckRwZGCGPzqaQQ09mNWYZtJNqvaVemIgl5dsi7fa1ZmyQGg9GOmKb7Cha7LN1bGXzZ7n6AlnMEInSb9y7zbzf7ukKUFPgKKZV6DPP9bLJ8dDmDwKDnpyhqhht4v8SKkDToFE8+hP0GZiAXmw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c5b1a8-4484-491d-d5ce-08defc88a47d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 17:54:53.8239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bB7cZFLXO3cw37aqIMe0mHuiehHSBXQygb89p99L3Xk/nEpXSmTHJMn3y9ZO2C1PaDJy7wCLRR6uPjo3GfjkiAUnjc+vCom6IEdJAEBmUR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7728
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTA4LTE2IGF0IDIxOjE5IC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
ICJFZGdlY29tYmUsIFJpY2sgUCIgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cml0ZXM6
DQo+IA0KPiA+IE9uIFRodSwgMjAyNi0wOC0xMyBhdCAxNTo0NyAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDIwMjYtMDctMjIgYXQgMjM6MTMgKzAwMDAsIExpc2Eg
V2FuZyB3cm90ZToNCj4gPiA+ID4gdjE0IHJldmlzaW9uIGZvciBURFggS1ZNIHNlbGZ0ZXN0cyBi
YXNlZCBvbiBrdm0vbmV4dCBhbmQgZ3Vlc3RfbWVtZmQ6DQo+ID4gPiA+IEluLXBsYWNlIGNvbnZl
cnNpb24gc3VwcG9ydFsxXS4gVGhpcyBzZXJpZXMgbmVlZHMgc29tZSBjaGFuZ2VzIGZyb20NCj4g
PiA+ID4gaW4tcGxhY2UgY29udmVyc2lvbiB2OS4gRm9yIGVhc2Ugb2YgdGVzdGluZywgYW4gZXh0
cmEgaGFjayBjb21taXQgaGFzDQo+ID4gPiA+IGJlZW4gYWRkZWQuIFRoZSBjb21wbGV0ZSBjb2Rl
IGlzIGF2YWlsYWJsZSBhdDoNCj4gPiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL2dvb2dsZXByb2Rr
ZXJuZWwvbGludXgtY2MvY29tbWl0cy90ZHgtc2VsZnRlc3RzLXYxNA0KPiA+ID4gDQo+ID4gPiBB
cmUgeW91IGFibGUgdG8gZ2V0IHNhc2hpa28gcmV2aWV3IG9uIHRoaXM/IE9yIGRpZCB5b3UgaW50
ZXJuYWxseSBzb21laG93Pw0KPiA+ID4gSXQgc2VlbXMgdGhlIHB1YmxpYyBzYXNoaWtvIGNhbm5v
dCBmaWd1cmUgb3V0IHRoaXMgc3RhY2suDQo+ID4gDQo+ID4gQWN0dWFsbHkgd2h5IGlzIHRoaXMg
b24gdG9wIG9mIGluLXBsYWNlIGNvbnZlcnNpb24/IEkgdGhvdWdodCB0aGUgaWRlYSB3YXMNCj4g
PiB0byBicmVhayB0aGUgc2VyaWVzIGFwYXJ0IHRvIGdldCBzb21ldGhpbmcgYmFzaWMgdXBzdHJl
YW06DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2FKLTZKcEhENnhoQXZaUHlAZ29v
Z2xlLmNvbS8NCj4gPiANCj4gPiBBZGRpbmcgaW4tcGxhY2UgY29udmVyc2lvbiB0ZXN0cyBzZWVt
cyB0byBiZSBnb2luZyBpbiB0aGUgb3Bwb3NpdGUNCj4gPiBkaXJlY3Rpb24uDQo+ID4gDQo+IA0K
PiBXZSB3YW50ZWQgdG8gaGF2ZSB0aGlzIHNlcmllcyBiYXNlZCBvbiBpbi1wbGFjZSBjb252ZXJz
aW9uIHNpbmNlDQo+IG5vbi1pbi1wbGFjZSBjb252ZXJzaW9uIGlzIG9uIGEgZGVwcmVjYXRpb24g
cGF0aC4NCg0KSG1tLCB3aGF0IGtpbmQgb2YgdGltZWxpbmUgZG8geW91IHNlZSBmb3IgdGhlIG9s
ZCBpbnRlcmZhY2UgYWN0dWFsbHkgZ2V0dGluZw0KeWFua2VkIG91dCBvZiB0aGUga2VybmVsPyBJ
IHdhcyBpbWFnaW5pbmcgaXQgd291bGQgYmUgdGhlcmUgZm9yIG1hbnkgeWVhcnMgYXQNCm1pbmlt
dW0sIGluIHdoaWNoIGNhc2UgaXQgd291bGQgbmVlZCB0ZXN0cyB0b28uDQoNClRoZSBsZXZlbCBv
ZiBkZXBlbmRlbmNpZXMgd2UgaGF2ZSBvbiBjb2NvIHN0dWZmIGlzIHByZXR0eSB1bmZvcnR1bmF0
ZSBJIHRoaW5rLg0KQ29uc2lkZXJpbmcgdGhlc2UgdGVzdHMgc2hvdWxkIGhhdmUgaWRlYWxseSBx
dWlja2x5IGZvbGxvd2VkIHRoZSBURFggYmFzZQ0KdXBzdHJlYW1pbmcsIGl0IHdvdWxkIGJlIG5p
Y2UgaWYgd2UgY291bGQgYXZvaWQgaXQgaGVyZS4NCg0KPiAgQWxzbywgaXQgbWFrZXMgdGhlIHNl
dCB1cCBlYXNpZXIgOikNCg0KSG1tLCB5ZWEgbWF5YmUuIEknbSBqdXN0IHdpc2hpbmcgdG8gdW5i
bG9jayB0aGlzIGZpbmFsbHkuIEFuZCBzbyBpdCBzZWVtcyBsaWtlDQphZGRpbmcgbmV3IHJvYWRi
bG9ja3MuDQoNCj4gDQo+IEF0IHRoaXMgcG9pbnQgSSBkb24ndCB0aGluayB0aGlzIHNlcmllcyBp
cyBnb2luZyB0byBtYWtlIGl0IGZvciA3LjMsIHNvDQo+IGF0IGJlc3QgaXQgbWFrZXMgaXQgZm9y
IDcuNCAodG9nZXRoZXIgd2l0aCBpbi1wbGFjZSBjb252ZXJzaW9uKSwgd2hpY2ggSQ0KPiB0aGlu
ayB3b3JrcyBvdXQ/DQo+IA0KPiBTZWFuLCBsZXQgdXMga25vdyB3aGF0IHlvdSB0aGluayBhYm91
dCBzY2hlZHVsaW5nLiBXZSBjYW4gcmViYXNlIHdpdGhvdXQNCj4gaW4tcGxhY2UgY29udmVyc2lv
biBpZiBuZWNlc3NhcnkuDQo+IA0KPiA+IA0KPiA+IEFsc28sIHRoZSBicmFuY2ggZG9lcyBub3Qg
YnVpbGQgZm9yIG1lOg0KPiA+IC91c3IvYmluL2xkOiAuLi4vbGludXgvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMva3ZtL2xpYi94ODYvdGR4L3RkX2Jvb3QuUzoyNjoNCj4gPiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIGBURF9CT09UX1BBUkFNRVRFUlNfUEVSX1ZDUFUnDQo+ID4gL3Vzci9iaW4vbGQ6
IC4uLi9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9v
dC5TOjMwOg0KPiA+IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYFREX1BFUl9WQ1BVX1BBUkFNRVRF
UlNfRVNQX0dWQScNCj4gPiAvdXNyL2Jpbi9sZDogLi4uL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290LlM6MzM6DQo+ID4gdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgVERfQk9PVF9QQVJBTUVURVJTX0dEVCcNCj4gPiAvdXNyL2Jpbi9sZDogLi4uL2xp
bnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290LlM6Mzc6
DQo+ID4gdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgVERfQk9PVF9QQVJBTUVURVJTX0lEVCcNCj4g
PiAvdXNyL2Jpbi9sZDogLi4uL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIv
eDg2L3RkeC90ZF9ib290LlM6NDQ6DQo+ID4gdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgVERfQk9P
VF9QQVJBTUVURVJTX0NSNCcNCj4gPiAvdXNyL2Jpbi9sZDogLi4uL2xpbnV4L3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290LlM6NDY6DQo+ID4gdW5kZWZpbmVk
IHJlZmVyZW5jZSB0byBgVERfQk9PVF9QQVJBTUVURVJTX0NSMycNCj4gPiAvdXNyL2Jpbi9sZDog
Li4uL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290
LlM6NDg6DQo+ID4gdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgVERfQk9PVF9QQVJBTUVURVJTX0NS
MCcNCj4gPiAvdXNyL2Jpbi9sZDogLi4uL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2
bS9saWIveDg2L3RkeC90ZF9ib290LlM6NTQ6DQo+ID4gdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBg
VERfUEVSX1ZDUFVfUEFSQU1FVEVSU19HVUVTVF9DT0RFJw0KPiA+IGNvbGxlY3QyOiBlcnJvcjog
bGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cw0KPiA+IG1ha2U6ICoqKiBbTWFrZWZpbGUua3ZtOjM1
MToNCj4gPiAuLi4vbGludXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2RlbWFuZF9wYWdp
bmdfdGVzdF0gRXJyb3IgMQ0KPiA+IG1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uDQo+ID4gL3Vzci9iaW4vbGQ6IC4uLi9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9vdC5vOiBpbg0KPiA+IGZ1bmN0aW9uIGB0ZF9ib290JzoN
Cj4gPiAuLi4vbGludXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2xpYi94ODYvdGR4L3Rk
X2Jvb3QuUzoyNDogdW5kZWZpbmVkDQo+ID4gcmVmZXJlbmNlIHRvIGBTSVpFT0ZfVERfUEVSX1ZD
UFVfUEFSQU1FVEVSUycNCj4gPiAvdXNyL2Jpbi9sZDogLi4uL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290LlM6MjY6DQo+ID4gdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgVERfQk9PVF9QQVJBTUVURVJTX1BFUl9WQ1BVJw0KPiA+IC91c3IvYmluL2xk
OiAuLi4vbGludXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2xpYi94ODYvdGR4L3RkX2Jv
b3QuUzozMDoNCj4gPiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBURF9QRVJfVkNQVV9QQVJBTUVU
RVJTX0VTUF9HVkEnDQo+ID4gL3Vzci9iaW4vbGQ6IC4uLi9saW51eC90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9vdC5TOjMzOg0KPiA+IHVuZGVmaW5lZCByZWZl
cmVuY2UgdG8gYFREX0JPT1RfUEFSQU1FVEVSU19HRFQnDQo+ID4gL3Vzci9iaW4vbGQ6IC4uLi9s
aW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9vdC5TOjM3
Og0KPiA+IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYFREX0JPT1RfUEFSQU1FVEVSU19JRFQnDQo+
ID4gL3Vzci9iaW4vbGQ6IC4uLi9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGli
L3g4Ni90ZHgvdGRfYm9vdC5TOjQ0Og0KPiA+IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYFREX0JP
T1RfUEFSQU1FVEVSU19DUjQnDQo+ID4gL3Vzci9iaW4vbGQ6IC4uLi9saW51eC90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9vdC5TOjQ2Og0KPiA+IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYFREX0JPT1RfUEFSQU1FVEVSU19DUjMnDQo+ID4gL3Vzci9iaW4vbGQ6
IC4uLi9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9v
dC5TOjQ4Og0KPiA+IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYFREX0JPT1RfUEFSQU1FVEVSU19D
UjAnDQo+ID4gL3Vzci9iaW4vbGQ6IC4uLi9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9r
dm0vbGliL3g4Ni90ZHgvdGRfYm9vdC5TOjU0Og0KPiA+IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YFREX1BFUl9WQ1BVX1BBUkFNRVRFUlNfR1VFU1RfQ09ERScNCj4gPiBjb2xsZWN0MjogZXJyb3I6
IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMNCj4gPiBtYWtlOiAqKiogW01ha2VmaWxlLmt2bToz
NTE6DQo+ID4gLi4uL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9kaXJ0eV9sb2df
dGVzdF0gRXJyb3IgMQ0KPiA+IA0KPiA+IElmIEkgYXBwbHkgdGhlc2UgcGF0Y2hlcyBvbiA4Y2Yz
OTY5YTBiN2Q0IGZyb20gdGhlIGJyYW5jaCwgaXQgYnVpbGRzIHRob3VnaC4NCj4gPiBJdCBsb29r
cyBsaWtlIGEgZmV3IGNoYW5nZXMgYXJlIG1pc3NpbmcgZnJvbSB0aGUgYnJhbmNoOg0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vZ3Vlc3RfbWVtZmRf
dGVzdC5jDQo+ID4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vZ3Vlc3RfbWVtZmRfdGVz
dC5jDQo+ID4gaW5kZXggZDY1MjhjNmY1ZTAzMS4uYjA5OWIwOWNiYWUzZCAxMDA2NDQNCj4gPiAt
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vZ3Vlc3RfbWVtZmRfdGVzdC5jDQo+ID4g
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2d1ZXN0X21lbWZkX3Rlc3QuYw0KPiA+
IEBAIC0xNCw3ICsxNCw3IEBADQo+ID4gwqAjaW5jbHVkZSA8bGludXgvYml0bWFwLmg+DQo+ID4g
wqAjaW5jbHVkZSA8bGludXgvZmFsbG9jLmg+DQo+ID4gwqAjaW5jbHVkZSA8bGludXgvc2l6ZXMu
aD4NCj4gPiAtI2luY2x1ZGUgPHN5cy9tbWFuLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tbWFu
Lmg+DQo+IA0KPiBJIHJlY2FsbCBhIHNpbWlsYXIgZml4IFsxXSB5b3UgcG9zdGVkLCBJIHRoaW5r
IGJvdGggTGlzYSBhbmQgSSBhcmUNCj4gcmVseWluZyBvbiBzb21lIExTUCBhdXRvLWluY2x1ZGlu
Zywgd2UnbGwgYWRvcHQgPGxpbnV4L21tYW4uaD4uIExldCBtZQ0KPiBrbm93IHlvdSBrbm93IGEg
Z29vZCB3YXkgdG8gY29uZmlndXJlIHRoZSBhdXRvLWluY2x1ZGVzLg0KPiANCj4gWzFdDQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDQyNzIwNDMxMy41MDc0MS0xLXJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tLw0KPiANCj4gV2hhdCBjb21waWxlci92ZXJzaW9uIGFyZSB5b3Ug
dXNpbmc/IFdlJ2QgbGlrZSB0byByZXByb2R1Y2UuDQoNCkkgZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8g
dGhhdCBjb21wdXRlciB0b2RheS4gSSdsbCByZXBvcnQgYmFjayB3aGVuIEkgZG8uIEJ1dCBpdA0K
c2VlbXMgdGhlIGlzc3VlIHdhcyBjYXVnaHQgYW5kIGZpeGVkIGluIHRoZXNlIHBvc3RlZCBwYXRj
aGVzLiBKdXN0IG5vdCBpbiB0aGUNCmxpbmtlZCBicmFuY2guIFNvIHNvbWVob3cgaXQgd2FzIG5v
dGljZWQ/DQoNCj4gDQo+ID4gwqAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQo+ID4gwqAjaW5jbHVk
ZSA8c3lzL3N0YXQuaD4NCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMva3ZtL2xpYi94ODYvdGR4L3RkX2Jvb3Rfb2Zmc2V0cy5jDQo+ID4gYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9vdF9vZmZzZXRzLmMNCj4gPiBpbmRl
eCBiODFjZDE2MTk4ZWNmLi43Zjc2YTM1ODViOTlhIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290X29mZnNldHMuYw0KPiA+ICsr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290X29mZnNl
dHMuYw0KPiA+IEBAIC01LDcgKzUsNyBAQA0KPiA+IA0KPiA+IMKgI2luY2x1ZGUgInRkeC90ZF9i
b290LmgiDQo+ID4gDQo+ID4gLXN0YXRpYyB2b2lkIF9fdXNlZCBjb21tb24odm9pZCkNCj4gPiAr
c3RhdGljIHZvaWQgX19hdHRyaWJ1dGVfXygodXNlZCkpIGNvbW1vbih2b2lkKQ0KPiANCj4gTm90
IHN1cmUgYWJvdXQgdGhpcywgSSdsbCBsZXQgTGlzYSBsb29rIGF0IHRoaXMgaW4gbW9yZSBkZXRh
aWwuIEkgd29uZGVyDQo+IGlmIGRlY2xhcmluZyBfX3VzZWQgaXMgbmVjZXNzYXJ5IGF0IGFsbC4N
Cj4gDQo+ID4gwqB7DQo+ID4gwqDCoMKgwqDCoMKgwqAgT0ZGU0VUKFREX0JPT1RfUEFSQU1FVEVS
U19DUjAsIHRkX2Jvb3RfcGFyYW1ldGVycywgY3IwKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCBPRkZT
RVQoVERfQk9PVF9QQVJBTUVURVJTX0NSMywgdGRfYm9vdF9wYXJhbWV0ZXJzLCBjcjMpOw0KDQo=
