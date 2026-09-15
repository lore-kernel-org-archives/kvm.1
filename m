Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21535295C;
	Tue, 15 Sep 2026 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505125; cv=fail; b=SyqGSsnFfEud7N3XxPmZOCqT2Iwn+vUg8CGLKdvNW7YIfq78n7ytsToP2SK7jHBnJ0gsr0fjn+MkVH4xRVJD9N/km91u0tS+D8DxTsDb8T4XZR9i3+QEa8RMGWJuzO/cGK2nn7oYqjuTx1VyXjovNk2QLhMe1EFVIcncI1aaWsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505125; c=relaxed/simple;
	bh=RraYSYmmF9jIi3Rr0E+V+xzcmE1xy5VOs7xnT0h4EaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j6VCbposO2lySiX5A8Q541vw8qOOnd+UnAT1A1wxSPoK539wW/QpFKMBK96tvdoO0dNq1R8edZqZcM8wQ88F8MRxuJggmk+rf5Iy/rAzI+AQCukR+SGeqQgqxJ4bde3dLzZckcBfhQJGhRqmos4I2ECC9O3qvh6G4dbjibab1yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHw73vY4; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHw73vY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789505121; x=1821041121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RraYSYmmF9jIi3Rr0E+V+xzcmE1xy5VOs7xnT0h4EaY=;
  b=jHw73vY4KnrSkFurBVdpJGKO+pzMMa+7O58R/CMIen4Zo+3/Rf2wtTkE
   L2WN17BEa0fDUvktZuK4Mw5fMeYK5TdipO1AAVK58HM63lhZNIx2cD+b0
   8eVeDf+t5jeC0RqwfJEz81Q75UsYbifB8zJASkd/7NOfYR0uLUfEVPmL4
   OVebm/FPLV2/ph1p5ZoNCLoUnkfKRzhqlMo5D7hoPrVNl4zBwr6OxkDJ9
   eobLfUdsvBoIvzQneEFaj548qqW05ey+55b0MS1pJjUupzvXzBZce4CqE
   i5lSoXpzvZnLXQvWSYrJwCKP6nij8ErrCnyqXoMJn6A+SwGBnlMk3m907
   g==;
X-CSE-ConnectionGUID: dT0edgi1Rw6oBe1c6k7LEg==
X-CSE-MsgGUID: +zf/0fpoQb2pO7ymlP7vCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93706711"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93706711"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 13:45:18 -0700
X-CSE-ConnectionGUID: mfeDbprkQrmkdj34s1vJRA==
X-CSE-MsgGUID: T5T52XU6R76Kd/0OZ96cuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1356625"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 13:45:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 13:45:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 13:45:17 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 13:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGTFDbZ4WnSMXxKh7qv2PH2DX2ziN6RHyi6eCc5kafh2eg/+Ta05XpsnX0Q7xDGITxCXAn3qHS6QdwZFt5OJVEQj42C/de22ZVOxuOQDCOtOid7ODaCKpSsPafsiwoqtz5eZ6rmMTl/MOYEfQ0SJFDyiqu/BQne6nWLjayHdxp1ElRU/O01PVHIfvSVt15t5mS1AX8RHJXXEWOxdHM75XzOj+Ah83FdDynnkMkRFUW/TIkDIpZUtnH1aVjKA/WL9mR213wTmJjLX98tbAqKve0XdU0JNOnPRcWLx/R0pb0c2EXUEkS9UyV2hI4XmITQCAtphIW/GDZvlBZKZbzDovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RraYSYmmF9jIi3Rr0E+V+xzcmE1xy5VOs7xnT0h4EaY=;
 b=qwXya1FDIdM6JwnmjL99qDoPME4N/+HLaQeQY6MgFNxBjh1PhF3DvT99zD2RzyV6SGC3b5BazsGDRREjVdyS46JlMsFNU0eNvZiUBiaqQHEefYPhPE3AUHEssmfwDhAtHWY3O3Wj1CNoWoztPEi1SXfiKWIHiSSyCK+QpcGKSD24eQjt06/80t4aV0PtYoEXdDKfWduutxPTfy60ginyIh15T5TS/3xzepYMHKbmZmnXhnxEMUTwqot96j4aIGJC2SbbYw4TmysDPpJXTk57rsKk01uVP2EzBA1DcHtLCB52uiU8i/1SIjH1nWzbMpss2nqzOut82zUs5vRIN+MsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 20:45:12 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 20:45:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 1/5] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Thread-Topic: [PATCH v2 1/5] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Thread-Index: AQHdRPzKuS2C9geqHEyo5oyFtGf3z7bQHDEA
Date: Tue, 15 Sep 2026 20:45:04 +0000
Message-ID: <8b5b577cdad5e81c5166349e13541989f2facf53.camel@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
	 <20260915102658.713079-2-yilun.xu@linux.intel.com>
In-Reply-To: <20260915102658.713079-2-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB8081:EE_
x-ms-office365-filtering-correlation-id: f8e126f5-566e-49d7-6e6d-08df136a38c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|38070700021|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: qxLyLA11CibWuB9EXW+1CXcnOZA5NPP10nSdf1ci5DQLkR4p0PDIEzK2ST0eukzD6DUPjH3pS/XyBzzl8QcALL4WJXZK5PGLsAUurbuOBkW/43mlZ/gX3A3R4RMPym17ukvkA9sO4j6iEWy5eBWaSWjz+ieQcIbe0ni3OAgP4IoQthkiajWONhwv8zfs+Uvx3EwFus5NuRX/1cdeirCgl+rT7QXUBDsGEP40G9xYcsWk0AEmK650cZUTvHG9KhQfRz2BWsy9aOg4BFHuM53PbvB/tE+ieclAifjFg39ZZj9A7OJL+7u24Q1u3VKGRMxlziFcQLarwrl/C582p+f/HlYY/GxHxNym6lhcrhDOpGP1NG/CtdQH8ZST/5PpJrr9y6RA+m2gz1yGrabYda4Z3bQHIz16mZsEj1O1Ql1ZnzwtXRCQW8WlJcoZHHEXqfEIUDvVK9R0XXNO4AcB8y0o0Lc1yXR82Zvy5MSMffYMU7BP3H8VnSsiaXFeywQDXXcaXKVtcIT7uJX0BLuzq1ePrD4oPGy/GGqdFYhpRPhtDhLBDlQC3TeyjzWdA4yslusg4uGureMdzC5REW19L3fWUo4wcHygTZGsc1UD7FFL8/EHar15fRb8XJSbW4vdIAo99alN9zMCReneqHnwB32DAdjmUJCGRIQ9FyCNjtvIuISJbWGRhhTkCfpajDsiDMVXCX0rOB3YPmHLHFqRRhzdCnl45iVtoRYeG4YoKs0G7lI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFNqd1AzQjdXS3YzZk81enZCZmtDaWp0RzgxaVJJRnVuQlBnb1lmNm8rMDFT?=
 =?utf-8?B?T2xCWnYzNjlYUFpIRHBnTVdBWFF3TGZNK3AvUkNxamExRUNlN1p5UzFKQzNt?=
 =?utf-8?B?SXJPM2lYRjFWWkhTd0RzYVVUOURDbmxNZE1wdy9WWFQ2M2puT3pUcG9HLzZk?=
 =?utf-8?B?RlFnR2VpTWlIcVNndU4rZTN4WHlFMUV0RVVUdElVdHdDVnE3UWdoWEkraTBT?=
 =?utf-8?B?dFJNUWc1Qjd4MEI0NDA5eHdUcjBYWnRNa1RVN0w2MW9BOHlpL05YVG5QM2Ni?=
 =?utf-8?B?YUhwOGppN0V0WjFlcmFTRzg5em54aWxBanZhckVsVUpZN1ZMRmRNZU11eXhn?=
 =?utf-8?B?clcrQTZJNlg2emRqYU1jSUprSFBXWGRtdE5vUGc0UWRyM3FYcW1YYXVOTzk1?=
 =?utf-8?B?TWpjYS9oZHEwS083UzBad011MDBRMS9lUVFuZGxGeWJMRnFOb2VRaDJidVZo?=
 =?utf-8?B?RS9qZ3M2dk90R3c3M0dvZkJYZkRvQnhZZFNYRkF4S2NiTTFrZnNtNExQamdw?=
 =?utf-8?B?emZWRTZDanBpQ0dOTCtWMnNjeVpkVGwxc0diVzNReVNXSlZnNUtGdjk5S0hO?=
 =?utf-8?B?NnNEVUtnUHB1b2ZyR1h0ZzBuYVBUUTV2QlQ2Zkp0RUVZOHpRQ3lsaXUyTkNv?=
 =?utf-8?B?UGxZaktiek80M0FjTkJFQ0ZUcENvU3pxc0lNODhBKzlmYmhOVnhSSVVsMU9q?=
 =?utf-8?B?VnRkWlhEWkphV2xneElxVFQ1ek40VHk1NnhnVjhDQjNxdDJwWVhGZjJUdG1h?=
 =?utf-8?B?dkFXRXNHOVhDYmk3UFhSQUtPdFB1bkxQQm9mY3d4czhLdHdiUVlLV2Q5bW5p?=
 =?utf-8?B?bWJQWmJIdWx1MGpMWitFbDNWdzAyR3Z4RXprWnJtSm9xdmx3MUtnTXZzQ2xQ?=
 =?utf-8?B?b2w3TkZRZXYzUThXbWNYcGRCNTB5NEpndHd3UDZqNzhxOUFwQWgxY0dGN3R4?=
 =?utf-8?B?MHA0WGhxY2JGNjRlZGhKcDNud2xUV3I0eXlNQmQxRXJFdTh5cU5SdVVYNGpN?=
 =?utf-8?B?elRHUjRwbGZyVDBNejdud0lkdVRXcks2UHdnZjM1TWhoVXhFUy9KR2lDbTZ3?=
 =?utf-8?B?NU1YRDg5eWlDOTlVaHUzU1l0Vko5Mk4weElvQlB0cmJFbkd1L2NQVHRQMDJ3?=
 =?utf-8?B?cTF4QThiT3ZiZ1BYUHNPenpQK3k5czBDUklFdHpBMDYwSWlFRjU0Y011VitT?=
 =?utf-8?B?ZUs4VFhGS2RDRHF3VkRJTkRQMWRKMkxhQTdKVnl0VUVPc3RlTWVEWWRFN2I5?=
 =?utf-8?B?K2FIWXhRcDRhaGovL0NJUzRtd0RROFJhS1lqNWpock5YTmtPSkJlU2twQjV5?=
 =?utf-8?B?T2VTVUYyY21WcHM0T1Zibnc0dFg3bXdiUlNzOE5kanF1dWZsRzVyNGYzNTlT?=
 =?utf-8?B?dUNsWDdNRlZCRUN4Zm1Tbzd2U3lpWklHYzRhbTFXMHFFeEVWdk81ajFIR3R5?=
 =?utf-8?B?UEJqdExWSDZXeGxzZlNmWUpZWmVOSnRiRWRLSE5MSDRhNmZMVENhYThzOTJ2?=
 =?utf-8?B?Z1EzRGM1QjRPS1JITisxbzRxcW5EVHNNc3BSMlRVc01wRWpKQzJ5NmQ1RlVG?=
 =?utf-8?B?REdrSTdaMy9nc3JuSTlseS9LTitnaDhxTC96S2paR0VtamFzbWg2TTlIQXFM?=
 =?utf-8?B?cmVqSjNKcEpNeUNJclpsdjFOR1JXckdPZ2tXYWVBYzdUL3F2RGZLZUdrSlZ6?=
 =?utf-8?B?YWxrd0wxN1BtcmhmSHd6UDJMNTB0OFlNOUxWYm1qSFdyME4zL1JhcW9IdjlF?=
 =?utf-8?B?LzRLUFNldlJZcXhwVmFVZVUvRlNvN29nbkR4MmRRQjVXQlpJclk5dEI0ZnI5?=
 =?utf-8?B?RlA4dDVnS2swYWhlbFc3T2xZdU9NbThOU3NrSnJiaU55cTJpUVRGeEVSTzRH?=
 =?utf-8?B?a3RRZ2xOcTk2R0VmUkZPR1k0dVYzNEJhdWlIanIzcmtSM3BhcUhLWHBVYXlS?=
 =?utf-8?B?YThsUmJxa1lYVklsMkRrZzhaT3dYRGVRY3BHQTJCcHp1QVdaZXNIQ1NrbW5n?=
 =?utf-8?B?Tmt1MXJiMmlDNHVCeHJseW1FSm1sczF1UDd5MWRRMUdrMU5FWWN3dDBxNFpO?=
 =?utf-8?B?K3VDeHdFeVVPNHdNOW1IR2lmNVdzMi9CYjdvdndxR1NDd0RwZmtCMWp4ZmZC?=
 =?utf-8?B?MXcwRUlRYnRpR2tiN05mYXc0MEhqNGN4TldEa2xVaHYweTlkMTlhbDZiaVNs?=
 =?utf-8?B?OHNmSTl2SWg1Z1BveGFEM0hweGV3RjVjR1ZaMVZZT045UDJYK1lkWURTN25L?=
 =?utf-8?B?OEprOFlXMGF0c2hiK0FBd3BMMHJ2a0FCVFo3cm9UZ2dBbkFIakF5NW45UTBM?=
 =?utf-8?B?S09vWVA4VkRuSGxETElBWDZKbFY1Mkp1K0dLekNQbWFQaTRjWitKVzBsVVM3?=
 =?utf-8?Q?IzeHMLb+m0pWQQLc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF2359EB06BB934B90193AC4999772EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: y6uZNHzwcL1vvWh4RhZCe0ADlVXVVxpbOPxP6BugLSzUTFk7rdKKqYlhMvvRXW5bugf8wn2TrQeeCsriEacxlqDQDr98dNw3NxJHe6i5ccnVvaCHnsUz7LBnBbfemVKavHFvdviUiri5KV2Vd5PI6Md876y1qhwefTJ2qQqjIXNoO3ziepGZ1iV6P403b0lHA9wiFA7fs4f11E2JJFPDhythTHMbPgUXAvL11rBeGkUmdav+aQ+xgcHm63c5NjlJMSdG6m0b7/yoqZWZ0K6K7C80gwXFHbh/4JJZv2JYzJz5A2a5k6t8yUdsjM/0ajMcH53Rt0/38Mv2fc81CrLOmA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e126f5-566e-49d7-6e6d-08df136a38c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 20:45:04.9496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvUJleBCMBsU8JasJNxXObBSAWdrUZQXytQfsDQO/R+D6lN/LFE6MkQrf9b498YmfwGx8KlKDLpLRNZYQaimlBo0r0fgZBKGccB32uIxMYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDE4OjI2ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gSW4g
TGludXgsIFNFQU1DQUxMIHdyYXBwZXJzIGFyZSBpbnRyb2R1Y2VkIHRvIGF2b2lkIGJyb2FkIFNF
QU1DQUxMDQo+IGFjY2VzcyBieSBleHBvc2luZyBvbmx5IGEgc2VsZWN0aW9uIG9mIFNFQU1DQUxM
IGxlYWZzLCBidXQgYWxzbyB0bw0KPiBhYnN0cmFjdCB0aGUgU0VBTUNBTEwgcmVnaXN0ZXIgQUJJ
cy4NCj4gDQoNCg0KPiBUaGUgbGF0dGVyIGltcHJvdmVzIHJlYWRhYmlsaXR5IGFuZA0KPiByZXVz
ZSBmb3IgU0VBTUNBTEwgbGVhZnMgdGhhdCBhcmUgY2FsbGVkIG11bHRpcGxlIHRpbWVzLg0KDQpJ
J20gdHJ5aW5nIHRvIGFkanVzdCB0byBub3QgdXNpbmcgZm9ybWVyL2xhdHRlci4gVGhlIGZlZWRi
YWNrIEkndmUgc2VlbiBpcyB0aGF0DQppdCBpcyB0b28gbXVjaCB0byByZW1lbWJlciBhcyB5b3Ug
cmVhZCBhbG9uZy4gSG93IGFib3V0Og0KVGhlIGFic3RyYWN0aW9uIGltcHJvdmVzLi4uDQoNCj4g
DQo+IFNvbWUgU0VBTUNBTEwgbGVhZnMgYXJlIG5vdCBleHBsaWNpdGx5IHdyYXBwZWQgYmVjYXVz
ZSB0aGUgbGV2ZWwgb2YgVERYDQo+IEFCSSBkZXRhaWxzIG5lZWRlZCB0byBwZXJmb3JtIHRoZSBj
YWxsIGlzIGxvdyBlbm91Z2ggdG8gZmxvdyB3ZWxsIHdpdGgNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXmFyZQ0KPiB0aGUgY2FsbGluZyBjb2RlLg0KPiANCj4gRm9y
IHNvbWUgb2YgdGhlIGN1cnJlbnRseSB1bndyYXBwZWQgU0VBTUNBTEwgbGVhZnMsIFREWCBhcmNo
aXRlY3R1cmUNCj4gYWRqdXN0cyB0aGUgQUJJIGFuZCBhZGRzIFNFQU1DQUxMIHZlcnNpb24gc2Vs
ZWN0aW9uIGZvciBiYWNrd2FyZA0KPiBjb21wYXRpYmlsaXR5Lg0KPiANCg0KUmVhZHMgYSBsaXR0
bGUgd2VpcmQgdG8gbWUuIExpa2UgSSdtIG5vdCBzdXJlIHdoZW4gdGhpcyBhZGp1c3RpbmcgaXMg
aGFwcGVuaW5nLg0KSG93IGFib3V0Og0KDQouLi4sIHRoZSBURFggYXJjaGl0ZWN0dXJlIGhhcyBl
dm9sdmVkIHRoZSBBQkkgdG8gaW50cm9kdWNlIG5ldyB2ZXJzaW9ucyBvZg0KZXhpc3RpbmcgU0VB
TUNBTExzLiBWTU0gY29kZSBjYW4gc2VsZWN0IHRoZSB2ZXJzaW9uIHRvIGNhbGwgYmFzZWQgb24g
d2hhdCBpcw0Kc3VwcG9ydGVkIGJ5IHRoZSBsb2FkZWQgVERYIG1vZHVsZS4NCg0KPiAgRnV0dXJl
IGtlcm5lbCB3aWxsIG5lZWQgdG8gc3VwcG9ydCB0aGUgY2hhbmdlcy7CoA0KPiANCg0KPz8gSSBn
dWVzcyB5b3UgbWVhbiBzZWxlY3RpbmcgYmV0d2VlbiBTRUFNQ0FMTCB2ZXJzaW9ucz8NCg0KPiBU
aGlzIHdpbGwNCj4gbGVhayBtb3JlIEFCSSBkZXRhaWxzIGludG8gdGhlIHN1cnJvdW5kaW5nIGNh
bGxlciBjb2RlIGFuZCBkZWNyZWFzZQ0KPiByZWFkYWJpbGl0eSBvZiB0aGUgb3RoZXIgbG9naWMu
IFRvIGtlZXAgdGhlIEFCSSBkZXRhaWxzIGNvbnRhaW5lZCwgbW92ZQ0KPiB0aGUgU0VBTUNBTEwg
bGVhZnMgdGhhdCB3aWxsIG5lZWQgdmVyc2lvbiBzZWxlY3Rpb24gaW50byB3cmFwcGVycy4NCj4g
DQo+IFRoZSBjbGVhbmVzdCBzZXBhcmF0aW9uIHdvdWxkIGJlIHRvIGhhdmUga2VybmVsIGRhdGEg
dHlwZXMgZm9yIHRoZQ0KPiBTRUFNQ0FMTCB3cmFwcGVyIGFyZ3VtZW50cywNCj4gDQoNClRoaXMg
aXMgbm93IHRhbGtpbmcgYWJvdXQgZ2VuZXJhbCBzZWFtY2FsbCB3cmFwcGVyIGRlc2lnbi4gSXQg
Y291bGQgcmVhZCBsaWtlDQppdCdzIGluc3RlYWQgdGFsa2luZyBhYm91dCBjbGVhbiBzZXBhcmF0
aW9uIG9mIFNFQU1DQUxMIHZlcnNpb25zPw0KDQo+ICBhbmQgaGF2ZSB0aGVtIG1hcnNoYWxlZCBp
bnRvIFNFQU1DQUxMIGxlYWYNCj4gQUJJIHR5cGVzIChvZnRlbiB1NjRzKSBpbnNpZGUgdGhlIHdy
YXBwZXIuIFRoaXMgd29ya3MgZm9yIG1hbnkgU0VBTUNBTEwNCj4gbGVhZnMgYnV0IGJlY29tZXMg
Y3VtYmVyc29tZSB3aGVuIHRoZSByZWdpc3RlciBBQkkgdHlwZSBpcyBhIHBoeXNpY2FsDQo+IGFk
ZHJlc3Mgd2hpY2ggcG9pbnRzIHRvIGEgYnVmZmVyIGZvciBhbiBpbi1tZW1vcnkgQUJJLiBJZiB0
aGUgU0VBTUNBTEwNCj4gd3JhcHBlciBvbmx5IGFjY2VwdHMga2VybmVsIGRhdGEgdHlwZXMsIGl0
IG1heSBuZWVkIGR1cGxpY2F0ZSBidWZmZXINCj4gYWxsb2NhdGlvbiBhbmQgY29waWVzIHRvIG1h
dGNoIHRoZSBpbi1tZW1vcnkgQUJJLiBBbm90aGVyIHNvbHV0aW9uIGlzDQo+IHRvIGRlZmluZSBh
IG5hbWVkIGhlbHBlciBzdHJ1Y3R1cmUgdGhhdCBtaXJyb3JzIHRoZSBpbi1tZW1vcnkgQUJJLA0K
PiBwb3B1bGF0ZSBpdCBpbiBhIHNlcGFyYXRlIGZsb3csIHRoZW4gcGFzcyBpdCB0byB0aGUgU0VB
TUNBTEwgd3JhcHBlci4NCj4gc3RydWN0IHNlYW1sZHJfcGFyYW1zIGlzIGFuIGV4aXN0aW5nIGV4
YW1wbGUgb2YgdGhpcyBwYXR0ZXJuLg0KPiANCj4gVERILlNZUy5DT05GSUcgcmVxdWlyZXMgYSBs
aXN0IG9mIFRETVIgaW5mb3JtYXRpb24gaW4gdGhlIGZvcm0gb2YgYSBQQQ0KPiBhcnJheS4gVGhl
IFBBIGFycmF5IGlzIHRoZSBpbi1tZW1vcnkgQUJJLiBDcmVhdGUgYSBzdHJ1Y3R1cmUgZm9yIHRo
ZSBQQQ0KPiBhcnJheSwgdXNlIGl0IGFzIHRoZSBhcmd1bWVudCB3aGVuIGNyZWF0aW5nIHRoZSB3
cmFwcGVyIGZvcg0KPiBUREguU1lTLkNPTkZJRy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFh1IFlp
bHVuIDx5aWx1bi54dUBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBOaWtvbGF5IEJv
cmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiAtLS0NCj4gdjI6DQo+IMKgLSBSZW1vdmUg
VERILlNZUy5VUERBVEUgd3JhcHBlciAoRGF2ZSAmIFJpY2spDQo+IMKgLSBUYWxrIGFib3V0IHRo
ZSBoYW5kbGluZyBvZiBpbi1tZW1vcnkgQUJJcyBmb3IgU0VBTUNBTEwgd3JhcHBlcnMNCj4gwqDC
oCAoUmljaykNCj4gwqAtIFJlZmFjdG9yIHRoZSBlbnRpcmUgY2hhbmdlbG9nIGFjY29yZGluZyB0
byBSaWNrJ3Mgc3VnZ2VzdGlvbiAoUmljaykNCj4gwqAtIEFkZCBjb2RlIGNvbW1lbnQgZm9yIHN0
cnVjdCB0ZG1yX2luZm9fcGFfYXJyYXkgKEFJIG5pdHBpY2tlcikNCj4gwqAtIFVzZSBrZXJuZWwg
ZGF0YSB0eXBlIGZvciBucl90ZG1yX3BhIHBhcmFtZXRlciAoQUkgbml0cGlja2VyKQ0KPiANCj4g
djE6DQo+IMKgLSBUaGlzIHBhdGNoIGlzIHNwbGl0IG91dCBmcm9tIHRoZSBsYXN0IHNlcmllcyAo
UmljaykNCj4gLS0tDQo+IMKgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIHwgMzQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3Zp
cnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiBpbmRleCAx
NjY4Zjg2MTU2MDcuLmUwNjkzMmY4MDM5NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvdmlydC92
bXgvdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiBAQCAt
OTk4LDExICs5OTgsMzMgQEAgc3RhdGljIF9faW5pdCBpbnQgY29uc3RydWN0X3RkbXJzKHN0cnVj
dCBsaXN0X2hlYWQgKnRtYl9saXN0LA0KPiDCoAlyZXR1cm4gcmV0Ow0KPiDCoH0NCj4gwqANCj4g
Ky8qDQo+ICsgKiBUaGlzIGlzIGFuIGFycmF5IG9mIEhQQXMsIGVhY2ggcG9pbnRzIHRvIGEgVERN
Ul9JTkZPIGRhdGEgc3RydWN0dXJlIChzZWUNCj4gKyAqIHN0cnVjdCB0ZG1yX2luZm8pLg0KPiAr
ICoNCj4gKyAqIEl0IGlzIHRoZSBpbi1tZW1vcnkgQUJJIHRoYXQgdGhlIGtlcm5lbCBwYXNzZXMg
dG8gdGhlIFREWCBtb2R1bGUgdG8gc3BlY2lmeQ0KPiArICogdGhlIHJhbmdlcyBvZiBURCBNZW1v
cnkgUmVnaW9ucyAoVERNUnMpIGFuZCB0aGVpciBhc3NvY2lhdGVkIFBBTVQgbWVtb3J5Lg0KPiAr
ICovDQo+ICtzdHJ1Y3QgdGRtcl9pbmZvX3BhX2FycmF5IHsNCj4gKwlERUNMQVJFX0ZMRVhfQVJS
QVkodTY0LCBwaHlzKTsNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBfX2luaXQgaW50IHRkeF9zeXNf
Y29uZmlnKHN0cnVjdCB0ZG1yX2luZm9fcGFfYXJyYXkgKnRkbXJfcGFfYXJyYXksDQo+ICsJCQkJ
IHVuc2lnbmVkIGludCBucl90ZG1yX3BhLCB1NjQgZ2xvYmFsX2tleWlkKQ0KPiArew0KPiArCXN0
cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHsNCj4gKwkJLnJjeCA9IF9fcGEodGRtcl9wYV9h
cnJheSksDQo+ICsJCS5yZHggPSBucl90ZG1yX3BhLA0KPiArCQkucjggPSBnbG9iYWxfa2V5aWQs
DQo+ICsJfTsNCj4gKw0KPiArCXJldHVybiBzZWFtY2FsbF9wcmVycihUREhfU1lTX0NPTkZJRywg
JmFyZ3MpOw0KPiArfQ0KPiArDQo+IMKgc3RhdGljIF9faW5pdCBpbnQgY29uZmlnX3RkeF9tb2R1
bGUoc3RydWN0IHRkbXJfaW5mb19saXN0ICp0ZG1yX2xpc3QsDQo+IMKgCQkJCcKgwqDCoCB1NjQg
Z2xvYmFsX2tleWlkKQ0KPiDCoHsNCj4gLQlzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzIGFyZ3MgPSB7
fTsNCj4gLQl1NjQgKnRkbXJfcGFfYXJyYXk7DQo+ICsJc3RydWN0IHRkbXJfaW5mb19wYV9hcnJh
eSAqdGRtcl9wYV9hcnJheTsNCj4gwqAJc2l6ZV90IGFycmF5X3N6Ow0KPiDCoAlpbnQgaSwgcmV0
Ow0KPiDCoA0KPiBAQCAtMTAyMSwxMiArMTA0MywxMCBAQCBzdGF0aWMgX19pbml0IGludCBjb25m
aWdfdGR4X21vZHVsZShzdHJ1Y3QgdGRtcl9pbmZvX2xpc3QgKnRkbXJfbGlzdCwNCj4gwqAJCXJl
dHVybiAtRU5PTUVNOw0KDQoNCk91dHNpZGUgdGhlIGRpZmYgaXQgaGFzOg0KYXJyYXlfc3ogPSB0
ZG1yX2xpc3QtPm5yX2NvbnN1bWVkX3RkbXJzICogc2l6ZW9mKHU2NCk7DQoNCkNvdWxkIGJlIG5v
dyBjaGFuZ2VkIHRvOg0KYXJyYXlfc3ogPSB0ZG1yX2xpc3QtPm5yX2NvbnN1bWVkX3RkbXJzICog
c2l6ZW9mKCp0ZG1yX3BhX2FycmF5LT5waHlzKTsNCg0KQSBiaXQgb2YgZXhpc3RpbmcgY2xlYW51
cCwgYnV0IHRoZSB1NjQgaXMgZXNwZWNpYWxseSB0dWNrZWQgYXdheSBjb21wYXJlZCB0bw0KYmVm
b3JlLCBzbyBJJ2QgYXJndWUgaXRzIG1haW50YWluaW5nIHJlYWRhYmlsaXR5IG9mIHRoZSBleGlz
dGluZyBjb2RlLg0KDQo+IMKgDQo+IMKgCWZvciAoaSA9IDA7IGkgPCB0ZG1yX2xpc3QtPm5yX2Nv
bnN1bWVkX3RkbXJzOyBpKyspDQo+IC0JCXRkbXJfcGFfYXJyYXlbaV0gPSBfX3BhKHRkbXJfZW50
cnkodGRtcl9saXN0LCBpKSk7DQo+ICsJCXRkbXJfcGFfYXJyYXktPnBoeXNbaV0gPSBfX3BhKHRk
bXJfZW50cnkodGRtcl9saXN0LCBpKSk7DQo+IMKgDQo+IC0JYXJncy5yY3ggPSBfX3BhKHRkbXJf
cGFfYXJyYXkpOw0KPiAtCWFyZ3MucmR4ID0gdGRtcl9saXN0LT5ucl9jb25zdW1lZF90ZG1yczsN
Cj4gLQlhcmdzLnI4ID0gZ2xvYmFsX2tleWlkOw0KPiAtCXJldCA9IHNlYW1jYWxsX3ByZXJyKFRE
SF9TWVNfQ09ORklHLCAmYXJncyk7DQo+ICsJcmV0ID0gdGR4X3N5c19jb25maWcodGRtcl9wYV9h
cnJheSwgdGRtcl9saXN0LT5ucl9jb25zdW1lZF90ZG1ycywNCj4gKwkJCcKgwqDCoMKgIGdsb2Jh
bF9rZXlpZCk7DQo+IMKgDQo+IMKgCS8qIEZyZWUgdGhlIGFycmF5IGFzIGl0IGlzIG5vdCByZXF1
aXJlZCBhbnltb3JlLiAqLw0KPiDCoAlrZnJlZSh0ZG1yX3BhX2FycmF5KTsNCj4gLS0NCj4gMi4y
NS4xDQoNCg==
