Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB4A3B6379;
	Tue, 21 Jul 2026 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667571; cv=fail; b=rBrKkaWQY2kxjxByP1zEzABeHpB5ZStv/AAggOWrErZFSf1aw3t3zyjtERZgnHihigokPdxADGXWNbJ3N3wPak4ll96ccEevlx6/B/+1VAAyLVU1juBxb7ZxdssrhvMQpe61MTC1vmt+NheDUbrmypUXJweXsV9K/shsklcCVqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667571; c=relaxed/simple;
	bh=OqgSdR3ztMdFqfHMaNhqDqJPNb0cfYmGlHpuitCEAjg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ijV6OcvEb27CVdvgaBdg7KVymVSogf6QwgtXCz0ilG+C4yizYjSqDHQHJzTSg4mXMdp+QM7v69SB75yPmqSWBGvRkqdofAyjlzrJekX2CyuQmN+k4LuWlpwnakmAwy9DgDYoTzAP6EBtb+lig1dFdYN3Lw87cHj53lBVfjM3+a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyqVE8sO; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyqVE8sO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784667570; x=1816203570;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=OqgSdR3ztMdFqfHMaNhqDqJPNb0cfYmGlHpuitCEAjg=;
  b=EyqVE8sO5/EArVMWqVCQPFKYfuC42pn+0dS1R792a1MgmjOGsNwOWIp+
   1tEZpjpdVsPtacA6zzoPMGtTqEJG/F8T+Q3HUcuTm09u2xD1Y6VNf8TUc
   J2TTRP1XncpkN3jKfjo/5NTRVFQ9rVZLLfcbmuGXbDLP+DOwVg1nJJ/uh
   M7hh610HbRhxSrH/SSnNFpTaYLFDQQ0rOgQkvmmYN6FlvtCyMmw4JKaYD
   M9kz6U17FeudJyK5elvU/3p/2or+80Ov/WzwyKmXMJ8Pk5/XqNPnPtbUI
   TKOKaXSs+FLWm0WWbJsTMstN+ouyGzbqJRjNkTkQdMwXehUi9GyrXCTjR
   g==;
X-CSE-ConnectionGUID: AisTnDnxTw6hn60KRmP5BQ==
X-CSE-MsgGUID: B0MuJDkaR5OO2q+uCQx/qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85229898"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85229898"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:59:30 -0700
X-CSE-ConnectionGUID: GpjVAmszROKwC4l4yklnZg==
X-CSE-MsgGUID: uzrtZiqXQviH00T2Iovq+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261438385"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:59:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 13:59:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 13:59:29 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 13:59:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBBrB87SRezOjm0vGRc6VPzivaEe1pm5apeYMDyINIkLCAVWWXo78DM0yQZwuG8Tzllq20mrF2oewc1o9d8O3Vm0f7DwuyRrnz59zMpVgPzWna7SVvzqy4dc/PbUhh8IeJ62DoIjEODKDL/WGwdE4OcvE/7ziqvNkZ/aDIhGiuGIwf4t7qeaZdMBEciKrVWxyZZb7eHA+IdaFnHjVKkhmuI9kRITr53PeiANzbGhNVH3Huy7VooYrIJBoLqcSxJPRVtFaG1udVFcGdd5pGt1NyPULjXrNeETQ4PM9eGCvxWMLk+R7hFNCDwYswKxqpe2AiWkBVPuMSGZvWzfeEF0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjlJ+cM7DpVKwcGm6qz6NfOcrjx8820pPfU6DcTEWl8=;
 b=E/vh72s1RkJ80qPQ0YbtOhdYLR6/XHA1v+LC53emgjpsiSaJkRrkZRQ68j+FYDFrq8RDvzYqv47K/1xnsN9eSG+YWTGSkWBEkqhJGS3AYg58EZrk7Q1/gKwiLP24dAhqbgFylFLOoXdgBTNZ+16nKatCgWyQGRyOzSAN2IuKT+nnxVLOwSOJpzTqkPiiCm2v9pxC2GVPGWBDpZ0cDwDR1vUkIBlitxEObAq1LkPe2yEKPoO4uf5J96ssEwe+LOhU0VwIW7d90k6QDJNe4ivWwRIxI/WcZowkzS/AOebXTYvQrnOhAwElWVyFReHXCagLlIjYW813KP6/0hq3dwL3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 20:59:24 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 20:59:24 +0000
Message-ID: <aec5b1f4-ee7a-4453-a87a-ee975cb5afdc@intel.com>
Date: Tue, 21 Jul 2026 13:59:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] Dynamic PAMT
Content-Language: en-US
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, <bp@alien8.de>,
	<dave.hansen@intel.com>, <hpa@zytor.com>, <kas@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <yan.y.zhao@intel.com>,
	<kai.huang@intel.com>, <tony.lindgren@linux.intel.com>, <binbin.wu@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f18cb9-5c4c-4793-c4a2-08dee76af1c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|921020|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +M1d1VQvsC6VGcBlJgJCGdHcPA87BkeCNd1g9xq6JKXLSIpV0QR6PQvfOAtAWAlgnprsfjcbSuqycDtn+wIgzsGMpRJ3l4iN9Dd43EEvjo0VPfm8Jg4oqxfjcSiaG8rLIm0xiVkelQ9lSCBD2tqL0mxKx/vCKaXLJU9kOKGgaIREpaZ2NwgvkZMQvD1Eje/G5HaNbpRJR4SUYOECePNfRHCTI5I9EqTAph7GMYchlJhiKODqWJdF6gq7sO3wEKyqjljjpu1mg1jXY87tp8KDMKMhvYFWUlTtcEREXs7nX5MF3Shny/OJxz3sFNUvyAkzoHkoc8CK7x+YEat1Kqr3U1rT8MRjtxnhmHN+ZDmw9Eplu+sEBp/aFEhMUrX8nsRHu8V8H7c3dYbfSowSDtcSw7X58NWY89bILY3fOsZRlB/vP8i7mEY9PVKZvBD7vGM+Y/O6mgkOWIfmR937lwIY5KMKCo1HNmRc4o3yLmjE9vvWOA92LgwIJHEVympQTC4VBSvDfhik+/5V7dj6u2qGe4lLbq5SnNiPAwJrbXbDgpc68C55SH5UzukJuZgb9P+ob+8f3MMGLiIbsp/LpiRVRSkoyHfmt7hE1Lw7F/4GhZ3sKovNXTiVTQQd7l9RjxvEtGjrG92LK8vyyDdL+NTg763fbouMUv3N/749bBz/1TZ7o4ZTIDlJXbXQrr9Bi88WyTxPbxGAM2702ozwU53g+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZMRzltTE4vNDNNVXFYQStsN3I0aGdFQzRlUzIvUFVpUUpjSVJYVks1dE9r?=
 =?utf-8?B?N1Q2dk9MQjFwM1FxZy9BcXNnUzJGdTd4dVhzY21STm5Va05mRjRReXF2UjZK?=
 =?utf-8?B?WDcvbXY3VXp6enZaMXl1NTYwenZubzBQUVU5cUEvN1NJN29XN3JHbnU1eER6?=
 =?utf-8?B?d0VpQTBGNWJIZVBlYjZIb0RoNjZDcUJCQzVqbmtmb3RSQ1F5YWFyaWNYMEtU?=
 =?utf-8?B?SUpVcEFvV2g4SVk4ZjRQRTN1alFRV1NXTkVSUVJSY0p6SXltMzZ3K0N4cUxS?=
 =?utf-8?B?all3MnczOUZQdW12NGVLS3RWUitsUGxEUnRpZ0lRSHVMd0xBbWZkcU1KNFRJ?=
 =?utf-8?B?T3FTSDcvNG9VWkFKb0l5Y3pNTVdBY3JoSHRySFEzb0F1Y25neTVyRjJNWCs5?=
 =?utf-8?B?dithMFE3OVRWenlKclA1MXliU2k2YUpLWVNvc3BMekQ2L0pRNDR4aUJlUjg2?=
 =?utf-8?B?dUlRTTRnVWVrS0VMc1oxa3Rxd0gwaVlWbExFRS9UZ1ZHS0U0a1g3aXFFc3ds?=
 =?utf-8?B?VTVzaEFSR0pLVDJJaVovUEtKc09aOWhuaGxiTmJnVmtyUHg2SnNNRWxaMGQ5?=
 =?utf-8?B?MkVIc1NWQllialZUMTI2aENyRm1GY3VsR1FmSzU1aDNLcWJZSXJvYUl1OWg0?=
 =?utf-8?B?RzdWZTZiRExCWndMU3UzQlBKdEp0WG92L0xGTmlHUHZTQSswT1NQS0p1WGhV?=
 =?utf-8?B?NWN4ZDUwNWdDWGlnSThuVTVuQncrOGxtZEpQUU1aZ0gxdGZTcjNXUFpMMTc2?=
 =?utf-8?B?azFvQkp3K0x2eThyTkNFN1VPNnhDY2tPbWh2LytRbGtLR3lrd2w3NG1mckk5?=
 =?utf-8?B?VVJmY1ljVXVQS1hXSTdxcDg0dE85Mk5ZWkFrRUVRQno2TjRtNFVQbzV3RTho?=
 =?utf-8?B?Qk5UR001UXRXT09pKzViLzVwVVFDeE9aRDlVOXZ2bUEzalFvOG4yOHdHTEx2?=
 =?utf-8?B?YkNRSE5nYnlwMVpKcW1UV0RhN3VlbXFHbmY4c3J0Q2dBY0pSSjFUSGxEUmRi?=
 =?utf-8?B?dDdGcXJuZmFRaFRmNlcwYTE2RG1xSGNyQ0pZRnJQQVpMRVNUVlptM0l3d0xh?=
 =?utf-8?B?VVRKaDdoOXdYWkZGb0s1bVNCb3VQZCs1WW85d3N4Kzdvbk1oZzlqMVpMUFNY?=
 =?utf-8?B?MGNFcGN6SWFLMnIxc25scXJKNGx4S2RaNXlRU3hHckxSSzh1U3hKWXBvQ1hz?=
 =?utf-8?B?MkpOeWRQMUZIVUxJRGsvOVNvMjl2Q1hyM3hNSkRGejJqVnFJbitudVRGOGI3?=
 =?utf-8?B?aW80U3NlSUR5bW4ydTBTNnArYkg3U2tBRnNKNGY2QTRiZEQzQkV3aVM2YTFm?=
 =?utf-8?B?M3Bra1lURWExaExyYUxXOGtDUEc1OWphb3RET1RJYVc0aWVYcVlrWTRxb2Fj?=
 =?utf-8?B?UUx4L2ZtWEdBSUdLbXpLcGR5TFRVbTUwWmJqdXBZSDZMdHE1MWluR0tnekJo?=
 =?utf-8?B?YTNtN2hxR0lyYWhFNU9uS096TWVwS2JkM3lZQXlLOHVKVUl2NitYWWUxVjQ4?=
 =?utf-8?B?ZGt2V3dmOXZmODJSbkM5QWZjNHlZZzVMNWN2Q0djaUd2ZDE4Z3cxVi9DK1FT?=
 =?utf-8?B?Szg3MFFFTUNXY1pBMzNPNTdBOWs4MXpLc2RMTjd4ZUl4UGM3cXhGUWJaL3hl?=
 =?utf-8?B?MFlkWWlrbEZHTGRNWGR4MWJDMk02eFFHeW9FUnFmUFNHSWc5aEdnSFVJeDdm?=
 =?utf-8?B?dE5jRHlKSW9uLzZrdVRVU0VqWTlFL0JpWk1UL3g4V2FyMFpSRDNQVGNaOFZR?=
 =?utf-8?B?MjR1aHhpaFEyRnEwWEo4WDgvaEtvYWhHa1prcEpvOTJTcndLdGp4bDg0Z0Zz?=
 =?utf-8?B?SDBvcDIwc2d5d3p4TUczU0M5dVlJTmxUWTdTKzlCRnRXZlFKb0xMZHhiRmVX?=
 =?utf-8?B?anJFNEpXTmU1b3JJbUpwZUFRb0hzUE0zVS9IMHluSkVIam1XS2g0d1BFQXor?=
 =?utf-8?B?MmY3VEM2TEdMYmJ5eDZ4NVhLajJvR2ViSFlFZStndE1remhObkxLZ2hMOHEx?=
 =?utf-8?B?S2lhRVVJSm55Nk0rQ3JZWXdFQXNTOStaUTd3cHRybkxKQTB2TTRETVNXc0FL?=
 =?utf-8?B?TU0zMS9nWXo5cUFUcGREbGxSWWhsczhFR2I0dS8wRkxUdkVjcGZ4SVJRZkdv?=
 =?utf-8?B?SDdyKzk2TEgyMlVaZWxaM0p0dWVxMVMxRndTN0hkS0J2VzQ3Y2lkT3U1SVha?=
 =?utf-8?B?MDZsTnIxSmlCaGg2NFdKdzRXK2thdmJYMmVIdE8zL1pkMTl6SzM4M2ljSCtT?=
 =?utf-8?B?Nmk0NklWREJiSUlOdFFUUEh6QWtvSkt3NnVDcU0rQjBTOS8rZnRDU3p4d1d1?=
 =?utf-8?B?SU55NUVhTG12eUVEWDBaNjZLYlNjT2hUOHlySVZzSHV4L2QxTXNwZz09?=
X-Exchange-RoutingPolicyChecked: hqkJo6kysYR2rWXoYRw4nxdYlags2DYyNrVnB1BOZFw5PSjfudYqNbi5ijoK1oA0THNgIOGf2aZxG6nebRANXQ8QgNuzwFQHF7H0Ra3f1k/nQFRpi7ZRYlVvtccNjWYJq1m/+eM5ufAfULtZCBQcpf/oLybzTk1kRUX2NQE+IUsTeFTqbpsX9w4esE8H7WUoabKvrJIcDvcE0xZNCeoB1P/BZMK+TRyWr82RtVsHldBs/YspNDs0L/UmKvjU/JcifYGI+y2zbZw+eXZOx012H1KhxDOv2WZd0W7uXGMnQxO3N/iIychJLewpPfkaC2FZ36LlLdJCvfmFTX6x8gPLRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f18cb9-5c4c-4793-c4a2-08dee76af1c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 20:59:24.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJ9pypvwUoEB0lThxmT1hMlKTvrC8Zp6lBN6bVtYM+7bBbY8a1PvTvF5E9w4P7ntsKvYi7tNXUtXWcDvSUqacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com

On 7/17/2026 6:44 PM, Rick Edgecombe wrote:

> Kiryl Shutsemau (9):
>   x86/virt/tdx: Allocate page bitmap for Dynamic PAMT
>   x86/virt/tdx: Add tdx_alloc/free_control_page() helpers
>   x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory
>   x86/virt/tdx: Handle multiple callers in tdx_pamt_get/put()
>   KVM: TDX: Allocate PAMT memory for TD and vCPU control structures
>   KVM: TDX: Get/put PAMT pages when (un)mapping private memory
>   x86/virt/tdx: Enable Dynamic PAMT
>   Documentation/x86: Add documentation for TDX's Dynamic PAMT
>   x86/virt/tdx: Optimize tdx_pamt_get/put()
> 
> Rick Edgecombe (2):
>   x86/virt/tdx: Simplify PAMT layout calculation
>   x86/tdx: Add APIs to support Dynamic PAMT ops from KVM's fault path
> 
I primarily reviewed the commit logs and assessed the implementation.
The patches look good to me and are clean overall.

Acked-by: Sohil Mehta <sohil.mehta@intel.com>
