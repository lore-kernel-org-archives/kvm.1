Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D6425899;
	Mon, 27 Jul 2026 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174717; cv=fail; b=tumVp9NzbnDNwpM+DExJW0ZvWKo94w2TXYQmOiXhh6sh+1dAhZmhgBDQsNf9aEsySSEBvwOVOb8J9kh3719MaOP3X3PbCbif93CdWSz8yVJLmxpaC32ualAw5BPTeXrx1f6YGy5uGWm3vPV+T7guBxhnp980f3xC3WHYCJzUQ5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174717; c=relaxed/simple;
	bh=2mJQ9/94eb23fdpsh7SgJDxx+MHdKR4zm5xvTOJn+mw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nAUR+fbHzJ0HARm200IJyeC/usC96EeM0fbrOTjvULsVfIYzZvgykYIG2y5J1BEnMUyON7XcJErV8BHjBnX7Xgj3dmQEtlT6ndd4Jsy1/2hng5nUur+dewjbZDEsMzArIetnTMlspMmfVvUOl6eImkfskRFSfVul0KX1O1ljmUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHt+hmg/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHt+hmg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785174713; x=1816710713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2mJQ9/94eb23fdpsh7SgJDxx+MHdKR4zm5xvTOJn+mw=;
  b=IHt+hmg/5AtoC9GU9kjRDXSobMrEXfepYx1uM9KMPCh9c7O1D5yVzXdm
   1Sl0Jk5mhc/ScChPoFZzQ6Ho9F+5pjgSMRfd+9mStxGFS+EKPbDRxckdR
   B9lmWX2JZcCHMuoUXscIANOUj+9cMCwaszs/M3HRaKGtptTr1A4a1jOJG
   f2o/+3Hbtmsk2EffLB95WC6H28MM8GcJUULi6k0k1tgWUjDA0+R8vlG4l
   bdCmHWJhsT6iBa1Gd+ZCi8O5J4OXeZLc8PxH0XrcCYBBhd5p5KKX2dodv
   w0T4HrQDP//oYACHbA1VGXzmhCZ7BvdkMKbFOCRe8LWCHIAADpSuRwxm4
   g==;
X-CSE-ConnectionGUID: NdJJi02mRx6tdK78UYA7bA==
X-CSE-MsgGUID: 6NkUYdq+TuWDOk3vJ5CRPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="111293720"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="111293720"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:51:51 -0700
X-CSE-ConnectionGUID: YeybVqIDS5G9NNUy2qP8pQ==
X-CSE-MsgGUID: LNwctKDMSPedEJWQQ7gjhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="256115947"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:51:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 10:51:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 10:51:50 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 10:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+Ip9IsWDpBNRfLxyP8ZK6ERYmiqA+Ggv706YCRQvrdxwIxUGonG1HHYAX4fhAJxFsw0vjrbooCt5TX1wId28PPB6PtPpHqssf+3Va65wdhei5xA2SrMFCgfaxLZuOyLuNAwNFbuXrE90pfV7eGY084UkEY1wrpiMtmvKRtmJPhirq1A6kDJpjYL1q8sN6fdVFZWxn4u6877iOloHXYQKPePKCNRoQY2s4XnyRQ/6rU3ZITxKXHqplTGABrFAIJZ6h0st5ZF8BP/A675WWq7EhyBMpeVtCzLaO0X39qjkpcgI5IMIiXKklpyrhySL4LSR+t6UkG7eLf8LfYg50mG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mJQ9/94eb23fdpsh7SgJDxx+MHdKR4zm5xvTOJn+mw=;
 b=yDStAGkHy2GkYIQhe1zcY7t5OFrRgoXC7QKlWUmcc7UcUq0aAcXvZraq5jEuFocNpr8jAzGQB3EeXSvKKUFBuAvaarsWkBaj2lB+p722ylL+S9TN+E5McvQMJHGpliY0uxeXTMpwRNWI374iv0rW1mZm0jbLcLsDFWoJzkKnXq3fEa8grlzhytX1nlbrdenu3ANtXP6XNcBVJ3cjEe40cNOoq6CCRQWZBLcMyvEirPUYYsyj7yDh0hGbZ6pBYeZCKkT6kFkuMQzd9r9O9qPjSlU88woBy0XcJSVXrym5XXyHTGT+3VyShG4kmyXZUOalbZe9+I31+KKI4LgajVukvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB6939.namprd11.prod.outlook.com (2603:10b6:930:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:51:42 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 17:51:41 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "djbw@kernel.org" <djbw@kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Topic: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Index: AQHc/v34tfo3elz6N0uAdpZoN5jBM7ZOxlkAgDMdvAA=
Date: Mon, 27 Jul 2026 17:51:41 +0000
Message-ID: <5623b5a70245d0d2ac98bd4a2eb795e62cf7dfcd.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
	 <ajy6VMlPK08K7kIT@tlindgre-MOBL1>
In-Reply-To: <ajy6VMlPK08K7kIT@tlindgre-MOBL1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB6939:EE_
x-ms-office365-filtering-correlation-id: 1bd33a3f-2e02-4bb1-44d6-08deec07b6fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|3023799007|38070700021;
x-microsoft-antispam-message-info: yv6XA/NoadcpgQezJugcPwIEzoJ0O/BSqpfoMC+ObJT24d99ZlZ55Z6zel5PVWEX+Udlwg0GTbs5LCq8TW5AAQ3fZK+vNQujAdFQVUr/pyM2+Q277sk5vOyDYh5FQDbvrVFnZxsVThADqQ3818XAmtuKxAFGKKeXW5DS6B2R16hb+ST3zB8BTCvgGXT6MYvEFPvdXGbhfL+ly80yTGv6R4ldr8IP6jqoioPcHlFCwuLxDtKoin66f5jd0c0QdcwHvfAeZLRyIIDWLaNO/dhLUaEWRnTpkFbvFed6TdINUYYoQy57PwGNFppcqrWLk1S12qaKbul+ezmXGmFm7tCJ+LRT4uUsziIjEkJipCw+iAHKY7YqiKndnuyQM2UfBKM11fMyMof6LKbvR8+ydGnGGTNmXcY3fZHCKh/+QUVM8OuZx5e9cDitpLTdCf+5Es7ugppxqE3S5l7ak7SF32XRLH++qRXw61HRmESkQCbksOZdVB+FodTknNYSOKcKXkFJ/SEGOclpfayo4uPPxShCdM35Bg7mmGCk4/LIgltrbQpAs72G+KgfeUUM2FLz/vah3r3MPUkycq7hEQgese5DQFv3I1padEhUC3wtlwr3DgvGQ53Crila05HMSf5VPHP5d4gZLC6wjONMM0izic4PL5hezMbPlrTj2L2hPDrpMkzXNox8VcfiEN3UUGcJgdEZGoWYKcaKuFddJuZTSPL2ASXMeAdZ+ARcVOlTu0pUJ8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjlyeFNqbUFUNUVFSkY1OXM1ODNIeXphZHdaNkxqemZBbGRNZ2hSRFIyb3Vu?=
 =?utf-8?B?bVI0eXZjbUs0cmpSV3M0blIyd05jQThPUWlaY2xsN3o0RTRWdzdMaWVJSmdZ?=
 =?utf-8?B?VitKNUh4OVNjL0YrK1FvRTNGcXJXL2wvU2hwMzNXSG5Va2toVDlIaGJNUTc2?=
 =?utf-8?B?Y2E0Vk1DSWFxd3FMUFk4TzAyMzNzMS9oM0s0VlcvVG1YWVZQOUdCaG1sOUE1?=
 =?utf-8?B?djRaQUdlYXdKa09QdXpVSFFVenFYejZtdk8yU05Ta3pwbERZWnF1dVpPNUlH?=
 =?utf-8?B?N1ZkZFBTY2FsTFhYcGs5UkZ6WVkzUzViTllDU1FsZ1FabWgyNm1QODNQaGhs?=
 =?utf-8?B?LzFjSkFNaDI4QWY4bVhadVlYWlVMRFZsVkNkekVPNGFub0FLRGx3UDg1SnNy?=
 =?utf-8?B?YVpvL0YzL1E5dElIVWVkUTVUTXhjTlVvR1lvKzl1MDJTUHZTR1BqSzZ3NzZK?=
 =?utf-8?B?NUt5TkQ0NmhRYUhIQzlQUVFCWmd6VDhFbndNSG5WM0FYSFBhUjFQRTM0bzhX?=
 =?utf-8?B?MG9KSTZHNEordDVRaGExV1ErQ2lBUDYxV0M4bndkbENUN1prZUR3dEVkOEJB?=
 =?utf-8?B?VzlVU3JSRjVqdlVMdDhtbFJZOE16NHkrTEc0cTlTakd1SW1yU3dhRDhUbzJ4?=
 =?utf-8?B?OFZzOWpQQ3dzK05mWG1tZVJHMnRqYUpPelUxdDBUbSs4MDk0NEFXQU9tRUhT?=
 =?utf-8?B?aW5IZURlNlc2cTZxczA2UlB5UTFobnpDejJ5Wlh0Vm5UUSs4UzRBaXg5Mk50?=
 =?utf-8?B?WnNyMnVQNnVta0xmcENBMXVJdnRVdnZXSm05QzdxN3NqdlhZeFptdUdtdzJV?=
 =?utf-8?B?b1lNR1YwYjRqL1dJblpqeWNac2NRZUdUUlo2Tk5TUnVlbTdwTEgrVm56UXdn?=
 =?utf-8?B?eUxxNHMzQ25lOTh4cHpXVmNQby96S29QMWNlenAwMERZZFdFU3BIWlF0WkNC?=
 =?utf-8?B?MkNUSk9oNFlXY2ZiZ0d6SWE5blhwZG9NMnNURkdWcnNCdTc5ckxaWHZGanFZ?=
 =?utf-8?B?UWpnR3FoYXhFM3dWNStmS3ZoSUR0YndsUzYwNlZrd0Y0djJmYmRTamkrKzBP?=
 =?utf-8?B?dklTS2VraENGbVUrek41Wk1ZVlNRdmVjWm5DYlMwS0FvM3BTRmQxUXA5SGdH?=
 =?utf-8?B?clptRllvcnIvSzdicmFLZS9JSW02SXRJZkxMaFBxa0ZjU0paK2c5UG5KV1RI?=
 =?utf-8?B?YXhPWVJBUnExVVk2K1RDVFZGUHRDbkQ4SjAxblU5d0ZGeVV0MTVDRGtzMHBo?=
 =?utf-8?B?cVZEWjZBSUp2TVVtWkdyS0ZWTkk3K1NXODBzaFE5UUlFVHRtemhxQTF2cnl2?=
 =?utf-8?B?Vzd1NWlJUmpTWDV2L0JPd0MwbHZzV0Z2ZzNDblhFWTRLaFhLRXRwakw1Rk5m?=
 =?utf-8?B?T2paRGhCV3luTEVGVSt6YytvYTdCRHFDKzd1dGY5Mk82VjJPNGpCWWFZSFdT?=
 =?utf-8?B?aTN1dENNSVdabjVmeGlNelZpOFdNR052dk8zMmJkRHo2QUtDaytOeVBJdzJh?=
 =?utf-8?B?bmUvVUF0VFlSRHhRVUhGNEhHam1xejZuelFoVGtxRkM1VUhiTjdXRUU2cWNR?=
 =?utf-8?B?aEk5SmVMQ3NxNWdyL01XU1l4ZnZsd2t1cHMxUkNCR2ZqYkJMaTVNRXhJendY?=
 =?utf-8?B?UGhkMzRKZTR1MkQ3aXpFZ2FncXlQYXNHSjlyMjhCSzFibDcwT0hUemlKRUJV?=
 =?utf-8?B?UmwrUXhUaXRxenFwWTBQcXphV1E5NUw5bXpsUEFtcmt6YWViVGpZRzJuYXNj?=
 =?utf-8?B?UUxkODN5dnQzZTU0anhOd1NmZUxOK3ZYMCt2c1VWRGIycm5EdzlOZ000NjhB?=
 =?utf-8?B?YXkwNmpkMTd2SVNLd3JsaldyNC9NUy9FaU8zWmVBNkk1QWpYTG1VZngzUHo0?=
 =?utf-8?B?bFFRQWlRdEdEbXdHbkIxYXdrVWk2bVBiOFArRzdwQkxEeDdWUG5PajFmanZI?=
 =?utf-8?B?WWJuTjNMQ3pRRmU2YUVUZGZxaiszMWpyQjlXcVM3a3VwZG0ycUNMcndnaHlX?=
 =?utf-8?B?R0VjdWN5dWRwc1ZxbE94ajVkbFJ4c282dnVvUDJzVit3NnBDRUU3TG1xRnBj?=
 =?utf-8?B?SEZRK2R0YVFpeVhPeW1xM1hQQWlHcXR4RUpZeVk2dHNTZUNUa3VFNlFYRDB4?=
 =?utf-8?B?NHZRYk0yZWdxbytEc1BtOEp2eWlJaHVpYlQyNUV2dFUxQVdBTEU3RVVobVZV?=
 =?utf-8?B?Z0RPcTBsbHNDRGxCMEFPZU9waVZRQTdBTndqL1JURVRWK29HTHNwMmQ3aGpU?=
 =?utf-8?B?MnNrYTRkMnNhRlNLRWZyRGtOeTFkOEJjdWc2cGJsUHRGMVYzQmhGcWUzYUY5?=
 =?utf-8?B?UzdjOVptYWVFUzJRRStGZHZJQWZjZWs5NzZkMVVOY1NtZVVpT29Tdzl5R0dz?=
 =?utf-8?Q?IfnCui6dBvknHSkY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D9FC9E5AD82014E882B0C648A6D96AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E9q8VKQ7zs9PfAGnZBg53OksFoywZbmdD9oasq3AoLX4xSw6qM7yr2jToCOV9LQ8Q4SNextElza9gtBGOGg/fZicNItn4iZ5KoE9UA5X1hPyDsX+6a5XhFlQDwvo6YoROoRucVGBrtuAQMhjEczMfnOplsgtoncFlRp/OhUJgzuC5U+oRx6EUKpNYELIUbiieBvbnyutgv3FNi+mbTpwOTK3NfYHwntcMgGY+z2lxG9ynjS+vEd4ouUEY9+5omNy1hoQRlRznF3BGTDQWVF+TedPtPLIOIsmaJ2PRomPEOG/cSXXNrT06h/xjvnPSFkMaZBMQHAGefrQlHYfqscrRw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd33a3f-2e02-4bb1-44d6-08deec07b6fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 17:51:41.1840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBulr6iQbcsyknCBN+CAII+S7w/6hQdkXLA9sXV6nV7kDPUIkb2zi8ym5qsruQ1wwBTqDt08Bwqq+IvmX72TjdYQTWx1oquTZHduHaiksr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6939
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDA4OjE5ICswMzAwLCBUb255IExpbmRncmVuIHdyb3RlOg0K
PiBPbiBUaHUsIEp1biAxOCwgMjAyNiBhdCAwNDoxMzo0MVBNICswODAwLCBYdSBZaWx1biB3cm90
ZToNCj4gPiBURFggbW9kdWxlIGV4dGVuc2lvbnMgc3VwcG9ydCBleHRlbnNpb24gU0VBTUNBTExz
IHRoYXQgYXJlIHByZWVtcHRpYmxlDQo+ID4gYW5kIHJlc3VtYWJsZSwgdW5saWtlIG5vcm1hbCBT
RUFNQ0FMTHMgdGhhdCBydW4gdG8gY29tcGxldGlvbiB3aGlsZQ0KPiA+IG1vbm9wb2xpemluZyB0
aGUgQ1BVLiBUaGlzIGFsbG93cyBmb3IgaGlnaGVyLWxldmVsIEFQSSBjb25zdHJ1Y3Rpb25zLA0K
PiA+IHNvIGJldHRlciBzdXBwb3J0cyBzb21lIGFkZC1vbiBmZWF0dXJlcyB0aGF0IGltcGxlbWVu
dCBoaWdoZXIgb3JkZXINCj4gPiBzZWN1cml0eSBwcm90b2NvbHMuDQo+IA0KPiBIb3cgYWJvdXQg
IlREWCBtb2R1bGUgZXh0ZW5zaW9uIFNFQU1DQUxMcyBhcmUgcHJlZW1wdGlibGUgYW5kIHJlc3Vt
YWJsZS4uLiINCj4gYWJvdmUgdG8gbWFrZSBpdCBlYXNpZXIgdG8gcmVhZD8NCg0KQWdyZWVkLCBp
dCBpcyBoYXJkIHRvIHJlYWQuIEFsc28gdGhlIGZpcnN0IHF1ZXN0aW9uIHdpbGwgYmUsIHdoYXQg
aXMgYSAiVERYDQptb2R1bGUgZXh0ZW5zaW9uIFNFQU1DQUxMIg0K
