Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239949BD63;
	Tue, 13 Oct 2026 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933849; cv=fail; b=lVi97Ecgt9VqepXeh6jsODwaSQh/RcCuw9jmbTCanxo3QWUCY04Hv+MzElPOSxVWfsvxmJlc9mAsyQI0X1Kk/bZN2y/qIxOgBuDP3ZXweeGCMxBm9vFbHT0JvXxHFy8WFObiXI7X4KkHzv0hasmmnOzDHb8IiFeb5WZGTbtMaEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933849; c=relaxed/simple;
	bh=YJ4B0zRq8CS3dTgZ7iBhqlnzN71Tc/XohmTGB2Guvlw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fNfJJcx6CdDF8+TY7FbS1d41DJH0ItIRqzEnfDKjfCP3kT0kdGtCZ55Zn5OrLMIz7j9zD5rl23dIGaUs2d93HGqldjyMEqKlWa5c0e1L5CApovj8D0m21NwuNL1lMAyWqSQMvbzhEvB6QLyezVspGLkguvwl0vfoSg53ZxFyvXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoFPDS7K; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AoFPDS7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791933848; x=1823469848;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YJ4B0zRq8CS3dTgZ7iBhqlnzN71Tc/XohmTGB2Guvlw=;
  b=AoFPDS7Kfcgq9NG+Z80zvuto7GHykHnyJPmnbyro1VwcEkMWKjx917SV
   n1pAHkGTHnpdTfQrKMZsVrZwfIDgFbctBofZ/WTf1KZ9sHH2f16AlQdzf
   6kfzceMDJDuGLtHm36cqo1g17i9+CGoIA+JelQjFOHu16PAOGEWPmtO28
   wAA0EO8MbHqju46gcHLZtn2xxarQh2bIA00RiLcjd0BojjlygOX4yisFW
   c4582EUe4PBvQ/ftbYuXBgShM5gaQL+ItLluwguzhTPnEDJW0hYGjzabb
   Tm3WKJxbrSKJEgYPBjdPwInr/LLqFQF2GL7dyI/7woSGbpUTy/AjuD/Fw
   A==;
X-CSE-ConnectionGUID: fqQLgnvOTaqC9JGE5UNWMg==
X-CSE-MsgGUID: k7VXglDcQxmVxdVZfYqLCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="683209"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="683209"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 16:24:01 -0700
X-CSE-ConnectionGUID: il3Fj4yfQh2v0JSseT3trg==
X-CSE-MsgGUID: x3cBNaJpT4+YZB+bwy+q6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1202012"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 16:24:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 16:23:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 16:23:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 16:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdmAUg/45uumh2zpvXhLPCSV9o6WLIbx3TqchDn+5EqYBCRZjZuj+byuXo31mhQQ9kFobG6vG3UOET/XnYsi9eWzAEG3t8KFcIkUa8VJWBgLpKM2j6GIxpxDUkwUvK4fy77UCwkeMdJCL+a7MAKQLTfD4mdYz1LW8fVzLcTBm1ZDW8+BTmV1e1s9D4txNXNf6vDjNw69fmXMKqEFlXkPVBmeb7r+Rg1O1bLT2e5AZ5S4fnzbDlRRlS5gP6sJ7a5By0GzydMSVVaqvljDToz3tdojLNIqUND1XkBcPGtqv/1X+/xE4Mk5oNGvKa71cGeVu4annPThnbGtvgCrFjhhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NHNyQgnooTqSUlcUOb9AwO4oXg/9EnD7nflxL7R3Rk=;
 b=ThxRNF8IaqDHPrMO+I93Xt93luvgFWHqGAekhf9KNULOoBtfTN5IDvmLKQY04rv/WVAhjDVxt4Od+Pppevn8reM6W2yx/6lUwAYwtcVUlJYo7652cFt470e8EvQ4yT2UeHmZjwrX24QVEmfYC3ClMTs/jxK5IC9JFBbX5F6WmoebKLf4tL1mhk+N9vOvK0CCe3iuO/wrfkKT1dok2ZeqYqA+CPfkVaDVJKGC7zD66vZQpbXytgVfOFlqtp71bd0xHWLBjqfVZhoOBZRlmI8Smmh20roxvkHa3lCgUTQabdr4S+3HU8TxUry1qJdqow2AXhK41ve9FUcOlu4ZZ88XAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by SJ0PR11MB5037.namprd11.prod.outlook.com (2603:10b6:a03:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 23:23:40 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 23:23:40 +0000
Message-ID: <aff2576f-adbf-4775-9aa7-e9f20844da86@intel.com>
Date: Tue, 13 Oct 2026 16:23:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>, "Ben
 Horgan" <ben.horgan@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
 <f79c5f94-3c5e-4c64-9b6f-95f186e1bdd7@arm.com>
 <171f92a3-fa2e-44fb-b0d1-1250c72e31d1@amd.com>
 <4af177a1-7602-4b0a-a8ba-81575f1ec80f@intel.com>
 <655152e8-2076-4558-916c-d55f88f0f1ed@amd.com>
 <e91c9cc1-02cf-41ad-b636-8356e93b5dcc@intel.com>
 <9202bea3-7746-4a24-8070-3f472198d3cd@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9202bea3-7746-4a24-8070-3f472198d3cd@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|SJ0PR11MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c709e72-02e4-4331-a853-08df298103c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|56012099006|260925022911599003|260925021311599003|260925021911599003|4143699003|261009223027099003|11063799006|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: jxUZETOnWrpdUoISmF9/dNQ5IxkIUPiof5Xa71OduDZjDWz89jKMGeG9ourQP2K2+V0toNgNGAxAJ4xAXPOFcvFRY+xBtnFdMg1gWHZRcboaQX9E/RJWCNolwmwc1oPeGMCgawzfZePk3e/CXGNy/wlK0m+/SQJx26tFW2u3chdyGN65Z5/9rQp+CsxFuLpNHxRN5Oqi+Ip7rrYroiC6d6+/oAlDj9izAD6p9CsbC3bljwdURoovw6PAww2MclauLSq+6r9wzQ1bmosRPqSMWhj6MCxE9Z2gFb4VHab/owxovgAahla/TekHw54oC0cRT4T8QNTWLcNhcf+rTstnJHquwFS+a2TLZoiEsduN67iuXdBUH7dgqvvxCgoEnYLJkAa+NCA5p3A9lMOKLK+qTBjBEk2k3xSFhtutPCf2ncsbNc0yJkEIrHpnLm5NTanh9NPPsXSviVuMfnHVCLg4+NqCH7Kx16R20csAErvd+Z8ORxGPW5Hnf7zpfpTekkfvZ/k68kVlQF866CUgzMWA575lyJmlryisJV6Pn4nup0udaSl9VRyx0ynVSWWRLngXsNTUm/XSPrQud7jOOTpFB/XNwb6iWooYW5mz36JvXLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(4143699003)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0phOUczYWx0RWpydWdwWldUdDVFdmc0MXhoYW5yMTZVUU15MUs5cXZlNGV0?=
 =?utf-8?B?a0JtaXY5akY1UWFYbHBKRi8zK09hRS9PMm4vaVV0UGF2RjhzQzFWSGhFa3V5?=
 =?utf-8?B?UWwrYng4eDRNdUFGckVZZWlVeXpWaWhSTXNRUEhYU2piK2grOWk2MzRFUHV3?=
 =?utf-8?B?M3NCWTlqLzdya3M5RnZZN3Mra3NKajVUdTFaYW1OYkkrVzFFQW5DaDFXYjI0?=
 =?utf-8?B?RUJTVDdiQTlQaWd3NjVOQkdWS3Nhd0p2Rlk0N04wa2ZLaTZPb1cxMTVRVE5u?=
 =?utf-8?B?WVlGK2JtYi9ieEg3VkdIZXRHQnFTOXc4N0srSTg5THc3dFlwLzVndVluSmJP?=
 =?utf-8?B?MUFocGFqRk9KOGoyelpDZWZrL0dyRDA0K05QOFZUMzdmelRIYkJuVmtCekYr?=
 =?utf-8?B?aE0wb2U5RENETmFmY1orSkxuWlBsRnpPRlF6LzA1amZGWUxnRkhvUHBRYXRt?=
 =?utf-8?B?WmZ2NmZOVzFValBBZVlQaTIzVjlWOE51eHRSU1p0UWJyV2hWSmdWczQycW1z?=
 =?utf-8?B?ZDFCMVZNMFhmVHpnWG5xYS9jWDJ3UndSTU1iTm52cUgxWkpQR3BhQ3BNbnQx?=
 =?utf-8?B?VENSUXFzTFNmK3Z4cGE1TWw1YmZIK2QxT1Q2dzlMcUJJZUZiVFJOeUZyNHFO?=
 =?utf-8?B?anhGNmV6S2pUVnoyWUtkYWNZc0k5aTgxVWtvTWdoOTY2dWxMN2Q2blRSMWhT?=
 =?utf-8?B?ZmJMM2RNTGpJM2tRanNIa1RIWG5XMm9KakViS0xCK0VFYis5NE91ZHIyTEZT?=
 =?utf-8?B?bnNseS9qeWU4LzNUUFY0QzVYRCtNNmw2K2ZJdmVpTzROMDBJSUVYT1hVbmdZ?=
 =?utf-8?B?Ym1OcE53RUk0MDFuYVhKTGY2VnkxWmZvODF4Z0NOS3ZLK2pENk5adnJaVnhY?=
 =?utf-8?B?bWlkNE83SUluWUczVUVmL0VpZS9GKysxS1ExYm1LRk1yNDA5MW13bFJpcXIy?=
 =?utf-8?B?SCt2Tm8rSkxEd0JZOE84TEVXb2piNU0zNllBbWxScUtTb0NZcGJjMm5HVVlq?=
 =?utf-8?B?RndQM1VFOHhjREhjQXViYkorTFRCS2RkNkdDUHdKRmNwMkdtTUY5bWRXRG8y?=
 =?utf-8?B?eWVwTjVoYUJuUjdFNXBPWGpGOVdBbE5LamlVYmI1V2RTalJGQW1XRXFtVFdz?=
 =?utf-8?B?ZWhrOXRyK0xHL0svSWg2M1BvcG0xbzFuUmhRYkdwK2gzUG11Z3poNUsyaFR5?=
 =?utf-8?B?cExlY1A1NEhZVVFGYkt4YjY3dEFhV3htZFZQNVp3T1lzSmJ6MkJSak1oaVQ1?=
 =?utf-8?B?Mm45TkhwbjRNWFU5Mzk4RU83SWdEMldEYXRXakpTS0xXRzlTelY4eTFyY1R4?=
 =?utf-8?B?SU1uRzJYTE1YbU1FMnRHTDhYZWVjMnFiTlR6NFI0UWltV1YwTlZMWlN2dzZP?=
 =?utf-8?B?SVU4aUZyZDZocFdEZUlKZjVpM2p4MXBxY1NQVjM1cmsvL2tjTnZ4MUFHQzdJ?=
 =?utf-8?B?UVcrYWwrMDVxaHM4Nk5BZVNpRDRDU0JHcDdMbkFDa0JCUmZxb1IyUVpyWncw?=
 =?utf-8?B?Tnl0ZkV3cjgybUlrWVFKVzk2cWx3elhQby9vbFhhSHRlZHhVemtaOFBNV1dq?=
 =?utf-8?B?cG1aMEh0TXc0VnBUdDdBbHc1cnF4RXNKTjhocU5CS1VKd25lNjdYZVBLYS9o?=
 =?utf-8?B?ZXV1VlpnT0ZzSlhiUHZkSllMQ1NtZHZoTS9HaFd0YjZ4Z1FnRjAwSGEzbEVT?=
 =?utf-8?B?ZUxxNkttWEg1TTlhaUdMd3J2akNIaFEzdXgyRWtSZEZSYjNReERkVGpLbmVR?=
 =?utf-8?B?QXdkNFhENy8wTnJKWkZ4UGRuNjMxOElScVdPbUNOMkVzZENkcEUwUVVBZTUr?=
 =?utf-8?B?U3ZRelBjclJScTNhZVFGMGk4U3RtK3B4NjJXVTRvYVlrWVBaeHN5bDhiQmVm?=
 =?utf-8?B?QXpSSWk3VG5pVVl2OTNsWTd0N3FFcHNUc2xZS0ZKcjROY21VZ292NEM1WG9C?=
 =?utf-8?B?ZmZhWjd5aEdqUVd0czJXOHZ0ZkRMZzJPL0gxTE9tSzBJc3o3b3FUK1VUT1lX?=
 =?utf-8?B?eXJZVzVsQlJOK3BBajF0WG5INlVOK2Z0Y201WGJZZ0c4UWlWQXg4NStxZGl3?=
 =?utf-8?B?Ni8wN1R2TEJlK2l4VGl6dzBRT0tZMDFCYjk4UlBCMk1MNUFrVVQ0UTlSNTVu?=
 =?utf-8?B?ZU0zWVZ2Wks1UVR1VmUraVdTM1NrZnQ5TDV2bVJueFh0OXNzczFydUpSaVZE?=
 =?utf-8?B?clJjUFc5NlVTaDZUaUtjekpVbGo4OGxTYlYza0ZlZjgya1lJWWxOZlFMV2xq?=
 =?utf-8?B?Tm1odmpHdzJTMEFJbDc3MlBMZ3dtb2Z3MHAzTllSVXFEQ2JYTXlRVXRNUmFh?=
 =?utf-8?B?enZOaDVSS2doN3Z1dDhZeUpzdmI3d0lMWHlGb3hVNXBSd0VUMldldmdNS2NZ?=
 =?utf-8?Q?/TjoZ8SxmsIqR5CM=3D?=
X-Exchange-RoutingPolicyChecked: dhlpKgLL89hb2PmGeIvDB2XOemsuR3aYsRqbTJwYXswMYveqtUyIrHB4C3tN4tDa39ANWoz88woyGM0l0rVviFhGRgCmPR4EPpKRYDj5lmoQDvlR0gORbx9lutLG1d5HZWbOzpNc9MObtXLcXkMVbhyFBwDK0sAaWZoPlUW2wtmTgNcYFAAwrbY/tyRmZACUvXW0oSda4/CgNUUqYdFgaP7hxYOi6kJbxqnYdoVk3EQm2hgrlFn+jmBs8ZyRgcRTsNDVzNwDsVrNyMXdJeBSdhtQmykhqZz1R/L/iRK5WiU7pF/8FmiCotyhT1Q/8/ObawZbj0Db4USXNWYbPjLRWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c709e72-02e4-4331-a853-08df298103c9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 23:23:40.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Suau/ijo6WiHq3aCoGQ73+vuucb5jNCvEBVfnAn6DW085LL8mXFr4uxpbYHLJ5s9oaZfgGK6tuHjnmQVuJhZa461bxfeeqF3vWmxrKb6bIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5037
X-OriginatorOrg: intel.com

Hi Babu,

On 10/13/26 4:05 PM, Moger, Babu wrote:
> On 10/13/2026 3:25 PM, Reinette Chatre wrote:
>> On 10/13/26 11:52 AM, Babu Moger wrote:
>>> On 10/13/26 13:22, Reinette Chatre wrote:
>>>> On 10/13/26 9:51 AM, Babu Moger wrote:
>>>>> On 10/13/26 10:57, Ben Horgan wrote:
>>>>>> On 10/10/2026 00:44, Babu Moger wrote:
>>>>>>> When the user switches counter assignment mode by writing "mbm_event" to
>>>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
>>>>>>> counters, resets per-domain RMID state, and enables counter auto-assignment
>>>>>>> exposed to user space as mbm_assign_on_mkdir.
>>>>>>>
>>>>>>> Even though counter auto-assignment is enabled, groups that already exist
>>>>>>> at the time of the switch, including the default group created at mount,
>>>>>>> are not assigned a counter. All MBM events read "Unassigned" until the user
>>>>>>> assigns a counter by hand.
>>>>>>>
>>>>>>> Walk every existing CTRL_MON and its MON children after the reset and
>>>>>>> assign counters to their MBM events. Enabling "mbm_event" now leaves the
>>>>>>> same per-group state that auto-assignment would have produced. There may be
>>>>>>> fewer available counters than MBM events across the existing groups; in
>>>>>>> that case stop assignment when no counters remain. Events in the remaining
>>>>>>> groups read "Unassigned", matching the behavior of creating a group when no
>>>>>>> counters are available. Also revise the rdtgroup_assign_cntrs() function
>>>>>>> comments to account for the new callers.
>>>>>>>
>>>>>>> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
>>>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>>>> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> ---
>>>>>>> v4: Changelog update (Reinette's input).
>>>>>>>        Function comment update for rdtgroup_assign_cntrs().
>>>>>>>
>>>>>>> v3: Changelog update.
>>>>>>>        Code comment cleanup.
>>>>>>>        Added Cc to stable.
>>>>>>>        Added Reported-by and Closes tags.
>>>>>>>
>>>>>>> v2: New patch.
>>>>>>>        This patch addresses the Sashiko comment about documentation issue where
>>>>>>>        counters are not assigned automatically when mode is switched to mbm_event.
>>>>>>>        https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>>>>>        In fact, it exposed a real issue. When switching to mbm_event mode, existing
>>>>>>>        monitoring groups should be assigned counters whenever counters are available.
>>>>>>>        This provides a smooth transition between modes and aligns the behavior with
>>>>>>>        the existing auto-assignment mechanism.
>>>>>>
>>>>>>
>>>>>> Given the name of the option is 'mbm_assign_on_mkdir' I expected the auto assignment to only occur
>>>>>> on the creation of ctrl groups or monitor groups. That's not my concern though. As you are now
>>>>>> treating this as more of a general auto assignment should the assignment also be done when a resctrl
>>>>>> domain is brought back online.
>>>>>>
>>>>>> For illustration on an MPAM model I see:
>>>>>>
>>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>>> mbm_total_bytes:2=e;3=e
>>>>>>
>>>>>> # offline one domain
>>>>>> /sys/fs/resctrl# for i in $(seq 0 3); do echo 0 > /sys/devices/system/cpu/cpu$i/online; done
>>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>>> mbm_total_bytes:3=e
>>>>>>
>>>>>> # bring the domain back online
>>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>>> mbm_total_bytes:2=_;3=e # Would it be better, or worse, for auto-assignment to occur here?
>>>>>>
>>>>> Interesting.
>>>>>
>>>>> We don't know the previous state. What if it looked like this before the CPU was taken offline?
>>>>>
>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>> mbm_total_bytes:2=_;3=e
>>>>>
>>>>> In that case, forcing auto-assignment may not be the right thing to do.
>>>>> Since we don't know the previous state, we can only speculate.
>>>>>
>>>>> It may be best to leave this decision to the user.
>>>> I think this raises an important point. To get a better idea I looked back at the original
>>>> bug report referenced by the "Closes:" tag and I do not think this is a relevant fix for
>>>> that bug.
>>>>
>>>> Let me elaborate ...
>>>>
>>>> The bug reported by Sashiko was in response to the patch that added a step to
>>>> "Examples on working with mbm_assign_mode" to switch to mbm_event mode from default
>>>> mode. The rest of the example was not changed to accommodate the assign mode change
>>>> and the documentation thus reflected the state of a system that was in mbm_event mode when
>>>> the resource groups were created, not in the new default mode.
>>>>
>>>> In this new version of the series the documentation change looks different - it does
>>>> not imply that the system started out in default mode and thus does not imply any
>>>> mode under which those resource groups were created.
>>>>
>>>> I agree with your final statement "It may be best to leave this decision to the user.".
>>>> It is not possible for resctrl to know how user intends to assign counters. Why not just
>>>> leave them all unassigned when switching to mbm_event mode?
>>>>
>>>
>>> That is a good point. We can do that.
>>>
>>> Should we treat the default group as a special case and handle it differently?
>> I am missing why the default group is special here. As I understand user space
>> can allocate counters to the events belonging to the default group just the same
>> as any other group. Could you please elaborate what sets the default group apart here?
>>
> 
> As you know, the default group is the "catch-all" container for the
> system, and users may expect it to report valid bandwidth
> measurements. That said, I'm not sure those considerations alone
> justify giving it guaranteed counter assignment.

The current documentation states following about impact of switching to mbm_event mode:
- "Changing the mode may cause all counters on the resource to reset."
- "Moving to mbm_event counter assignment mode requires users to assign the counters
   to the events. Otherwise, the MBM event counters will return 'Unassigned' when read."

The second is clear about expected behavior and there is no "except default group" caveat.

At this point I do not see a motivation to change the existing behavior. 

My vote is for this patch to be dropped.

Reinette

