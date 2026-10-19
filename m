Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792426985;
	b=wOPt3HUnlc8XhMcJyCfKjs32223Vx3HwCnRcVn+G/8QE0cVaAWqS0pgXW78ebMTSnZQ1
	 6R7/18a59yhXCrQEC5A8QxhRViQAIGpB+l/pdydKOwupoZ/TXHrlP4GIt9x8lBjEZ3WI1
	 lPJLzvm9zzwsamoQwtS2TOwwbghUWjvK6LqrtcnW4II09nsayhU85jcbE62AlFELeBKFa
	 8+VVwl/faM7U+1dq/gveUGGWX8YjxlyzUrIpTPt1h4Fm6r4MyBIyVfdBNMRohVuIvwfDc
	 CfkaHPX0gUy6CmObkpeciWK5xESRCf0TJDKWTDTHT1CtA9X+WdSanujIakWU8xucZsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426985;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=4P2UBPz1xUi/BU/Rq8Lc0NxCzKE5FaqvwKXJWjUoNhg=;
	b=TfI6DNjMM1VUcXnb3tLKtOMvSnZdLs1yj2WjqS7A7JRY0B62YqTmlwQGb3wrBt/itQ3i
	 slrK7+YEqq+1xaVpwOCdaadn9tqNBk2r2vnvuksWotP4phAzqzyTVvgJ/D+T6bSqZVzi7
	 jtCu1Mm0X6h+iv6YjRvXvJo0RfxfHnZ4CU1pNuyONBs7xFjnymk8Qwf5mTb8udXm6exLy
	 2rHNLLmaL/FNtKEmIA/x9ijeYWTPgtg6xRzIWGCnB8JyrzA84CGaoHaciagkqtpTOTVuc
	 Al9C/INgSaIUjTrJlDYRVOQ0by6eIl9sOBgGdlD0wOOkU5+WfA8BHqvqjcoQUEtI3/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EwdFzVAZ;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C2606A31B;
	Mon, 19 Oct 2026 16:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C9C2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EwdFzVAZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792426984; x=1823962984;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IRGff+fAvtZDpvD+23YETTeqRtzxGFTnRu17s0pUi2Q=;
  b=EwdFzVAZo2GTQOsdYxu26iXVqIV4S7s3v+BZaIXxBvLj4a71BejkdZy1
   yGuBYMfFwrPSLl00fdGI/g9zEVvR0LK0br/qCHeNjmXrOSuq8Tu8J6zDv
   yYcZE5ucI+8Nu2ARssAg5tuh4x5Ph3AzF2xOswYMGCPeWhiIEf96DvUEh
   WePWU90vS7XN5Bv9vxDv6UopUj/jiRkyOdF9UeJ8py7iPTpjr0o0D6ugm
   w9IqUaVbQ5JZnUcZyct4QUZK1KlQx0nG6BUgSmCKb7wC3YuNWpFQ7a2oU
   rBolbY4oEPQoSHlfIPrsJFsDBSGysuR1C00qRLtomfviCL8uL0j0/6bHw
   A==;
X-CSE-ConnectionGUID: Uzso+M2aSc+oty36zZSqHg==
X-CSE-MsgGUID: rve3PzVYT8W96xvybbFngQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1131270"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1131270"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:23:03 -0700
X-CSE-ConnectionGUID: PtKkLLluTJuwlVZA4newCg==
X-CSE-MsgGUID: B5aMIfVORFiXZiRgBxEh/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2979738"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:23:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:23:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:23:03 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMRvjytf4Yb/Af5p5yVTVyZKpXNz60rjJ8s85PBtH4/8wwft5yqjVWWpsRD9bST5poWsDg21JcjDmOF6uOHn2ZxPyXpearixKALi4EfbHeboy7FcDspYXXFI86axVLzZ+Z1t3ojF5PYmHX5BqjoaMnTKEk6zBe8CNJmhU8I6wTuQjJSkVrWWZIrjeS+8fT754AkG1ughSAT+aEmrvznEq6sh1Nl72fFUDeMrBlOX0Dwz9jXL8KKGN+Yn+QwkALcTOauc2befFZcOxCl+PBX/bNxULJdSQYNII7TynEbnKY879iiu2Rb+PCuxDUTFAB2D6c2X1RR8rrg4a1a8vo6FnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4P2UBPz1xUi/BU/Rq8Lc0NxCzKE5FaqvwKXJWjUoNhg=;
 b=AqMF8rLkuIMjOQ1C6AIbaQwLXCZG3xI5SmNnqy7HNfaPuMYPY4lO3YyOpGQvV4At6YEJWQFTttQDaspsfUXV6IrqIXTYGuHApLULVUJPAVrOqLXjF4uHZ4NITREEeyAWOQbmLcHZC4hkeT477v/UnYU68vjqYWaibNRnhaXdHgvCgdY/6RVFpxafcamH6QnR7sOVy3N5005qweiQ8/ogihmRhO+mQ2tPT8EPklKrcxCop0jwChtKRMQ7qeyAmigUKWXEUxdTWuqgav2ZtkYn69KB5e30T7xZRkFKdXCph0Ry6tXVxyMnbIGtU7U0t+xp4QDK4TJlSafm1NpIn/2yyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:22:55 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:22:55 +0000
Message-ID: <8b10c05f-eb3c-4ce3-8580-1cb034ad4e18@intel.com>
Date: Mon, 19 Oct 2026 09:22:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/18] fs/resctrl: Add support for hidden resource
 group files
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <9e770ba6dff365f823e702430ec3872709bc92d4.1790867441.git.babu.moger@amd.com>
 <0ad861e2-1dce-4179-986c-872a33eff38a@intel.com>
 <89715865-895d-4771-a700-f1a8aaa385cc@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <89715865-895d-4771-a700-f1a8aaa385cc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:303:6b::24) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|DS0PR11MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cb02f8-9967-4364-1722-08df2dfd3b62
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|4143699003|5023799004|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: +ghoJLgW/Z+qylz/YvlIgVeh090j+FLIBWYD7aEYUvuD400D/uBnfZhoEG36yBmgAZSrspBN4r2NCxu/XTFydx+0D1rflS03vVoIGHpQ9PPNErXl3U8JsorkWIjEsCBS801qipOmOyDZcPXlVhG0aVSArzx91AR4reHxV3MjaHmoPf3DW6CBKugt7BQ1iYzvZAzAV0SwLKhbv6XVoXsYcTVKV/dfkr67iKdxg2ObTTEY0VhlvgJ0K1t78pY4rYYUdNkYLH4H44DYVVvYObqYvoDnpr9rBEybUPleYf8o+DwpPIInTjgXvyZUVNH3i3T7ZD+6JPQPzGEqct4+2TOz4STiW0Z677ki03OQsbLaP1A9VWdIGzCzYXJQgAP24RPKTbiRKmS9vnCccbmdCStAZspJeWmFam3juRDb36xhec8IgGf8Z+mY5AgSGapVRzKoY3bdiou5+n9+HZG55zuhXSU0KScanDwJjqP4vxRUUlOdu3+7/2lxSWlHoVlSP5dl3TI9E0u3sxJfSzBMg+fLEqrzwNVF+on1VXGYErN7VpIwD8L5YsHXwg/o3lMtVHri1bDgHYH0QtA0HzC37anIIcMZ0MEkifgQAoHJK+XCj8FQSX4/038tXLgIXneykQOxS4njAYF6kCsFocjN+SHNmYxF5R0EhNE6PTzDmAJ37aE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1E1ZWVnZS8wSnFnZWRqMW1SU3BZaVJXRXlMcXpjeVN0a2pkR1o5d1hsZ0tp?=
 =?utf-8?B?T01QaEFScDc3MERhNHphVGVtWTJRYnFmaTFpaTBCaDBHK2V2RXVHYi95TlUr?=
 =?utf-8?B?cWs1alJsNlo2SDFvaU5sdi9YbWlRc3k2RUhyS2J0THFFSDIwZzlzTWF3SnNv?=
 =?utf-8?B?VWlub1I0elh5dU1YMm9TWjB5Zi93cjRrUkZSamJQVzhwWVhWa0JXSUpoSnor?=
 =?utf-8?B?STcwNVNXWVpjZmdqdEdRNk1XYWV6YjNwa2c0NGNwb1JiNDV3MHFJM25HRjNK?=
 =?utf-8?B?anRpMW1qaXYvb2Y2cGtWSTU4b3hRb2NkRVpyNEVYUWgrc2ZseHJPd1Myd2NO?=
 =?utf-8?B?UkJYWnVzRjllYUN6VkVLcFpVcDRWMWtONVFKT0sybjgyL0VQdEk0di9sdkkw?=
 =?utf-8?B?VUxid0JKMmdZeU5FeGZZQm5tSnNZSGpnOUQySklFSzg2TmZ0dGVIUk5uY1Zx?=
 =?utf-8?B?MFh5c284UVNIQlQ1ZUJEL2h6TDNwWFVoQ0N5VE9KVndxZzQxMTNVSmlaWU1r?=
 =?utf-8?B?SDhWU3dibnF0RHdab1dDY2lEdHBSeDdyM2ZLV05MekpRQXEvSjgzSkVtVGdG?=
 =?utf-8?B?NmFaWDdxQWpEYkpMVzI4eXlzbWk0RDRVc0VraGxxVWNiLytMaGJWQW5QV2Jn?=
 =?utf-8?B?Zldkd05mTXJ3NjA2RlNDYWRKMWFtREpkcmNYQnlzeVNYdGhYWEZTc1hnWWJr?=
 =?utf-8?B?eER4YzV2dHRneldzcXB1azZ1d0wxVVdqaEtYSmZVMUxhaEo3b25CQkMrTlB1?=
 =?utf-8?B?VHN5MXpBRXE2dHpLa0QvbzFZSXVxVEF3d1ZQYXRmMWRHMHlMMkxRSUV6c1dq?=
 =?utf-8?B?NGEwZUMvU3dtVHcvZFdpTC9nQm1INWI1UHV4K09FeGxOYm9ST3pyTnhJaEM0?=
 =?utf-8?B?aFpxUEt1UDF1OWp2UXF4VWxmSjZJTm0wRGV2WHVmTVR0OUw2U2R1YWpjcjly?=
 =?utf-8?B?dUpjMTZEcTE2NHg0SjhoOTYyWENXT2dBaXlOSVNHTU9WU1BLOE1DN3ljMVVz?=
 =?utf-8?B?eldmcEdtdnhFZG9iWDRGUHE3dkgzbGVWNEFqSFFDYVpZLzRaUnNkZ29hdlpi?=
 =?utf-8?B?ZHZKY2MraEt0Q2kvUVJRUWVkcXgwR0NZWHZibG0xTDNYbFY4ZTJGclF0YnM4?=
 =?utf-8?B?Mk9JRHFGenRzSERTTXVabUxCZzZoSUNkTHZxbXd5eG93NkYwbkJqWEhMblRo?=
 =?utf-8?B?Q1ExTnl5Y2JGSkhLQ2trNmltdjVKWUx3dmliVTRZTm1TbWVib0R1b3hYcEl2?=
 =?utf-8?B?VTBTUFIvRUJwWFd5ckJtMjNmNTYwMkI0Zys1YnJTc1Q1c0t4VE1nb3h3dDNV?=
 =?utf-8?B?YzloRHJ1WE1xbk52bUNrTnVNQzJJTFJnWWZmejZQWXdVcXVpT1g0NXYra1F2?=
 =?utf-8?B?dXFMbXBwa21rR2s5blhVSlVVYlZWajFPTXJGVys4bmFST2NLenFtVEM2K3cy?=
 =?utf-8?B?aXBHN0p4NDNXRzVlbERva2NzRzB1WFNPdnU4RHd4QmVLazFFYmpoWkl1RzJH?=
 =?utf-8?B?S215bTFvc0hXbHdMcG5YU2NBS0VURG94R0xqTmVpNTJEbC9IS0NScEpsaTdQ?=
 =?utf-8?B?S00yWHZlUVExbC9NTSsyUHhuOGtGbFEvajNGcStrY1V4RVZVK0NHRkd2dy9o?=
 =?utf-8?B?MllyM0tHRWZFblZoOTQ3UHRXSDl3WFY2WVdSQjZZYkFNSnNhc3l6SmtEZWpT?=
 =?utf-8?B?UllIWHlTcXdHcUZNM1lKWmZjMC9nQk5Vc2xyeWpRdVRxbnFpZERHbHJIL3pK?=
 =?utf-8?B?L2Q1ZGJSckhrdDE2cTVCNDlQcTJoSkxOQkV1SE9LcERHaWsrbUN4WGE4c05I?=
 =?utf-8?B?dXp6Ukl4dWtKLzZXOFUwNC96VEkxQmF6SEgvOU5MdjBsT1RzNnF6eDlpUTUv?=
 =?utf-8?B?MDVQdGNuQk5mUEpSdlNFSGhFQkl0djVTLzczWU5HMDF3bGVuMjhhOGxaZEVK?=
 =?utf-8?B?WGpHVzliTnEyclI5eEVLNzUweU1rM0JzRFlMSzJ2TndyRTNtR1pkYWI4WWdE?=
 =?utf-8?B?Z0gvVEJHaFlDOEpnMzdZSVQ4QkZqTU5YWE1hVVVhSnZyeUxMV3VvQW83MDdK?=
 =?utf-8?B?bXdDK3VLUVJQbEFvRkd6RSt4ZzgrbFVURVhjR2hmOXRYaWxkZG9QZ1JySWpI?=
 =?utf-8?B?T2ZxTEl5L2hvQmxIYWFJcDFDSjIwcjVNMGFERjcyNitZRFh6dXo2ZGwyVUlk?=
 =?utf-8?B?Q0NML0FLcmNSc0V1V2szQktSWklpUjAzU1Z3a3BLa2Z1b1hNTjVBdzQzeHZD?=
 =?utf-8?B?YVlQbXBMR29CeUJqRythSmNUbFZDRGNjVUhJK1Nia0ZQVXNUZVNrQ2hENDEw?=
 =?utf-8?B?bCs1dldyWFc3dWpxbGxFcnNtMEpBWkkyckZoOHV1TVlacTFJM3VDOG9US2NZ?=
 =?utf-8?Q?ONDDmea2phH2S//w=3D?=
X-Exchange-RoutingPolicyChecked: KAJm/QLQ6II0KAXBFFwgdEp/fBkfZgoc+WfKGFKI3xCUt/1iyDoMmgzIls/1xHcw2AK0Pheo2Xvuw+ge2mj6g08IdEbq/6ZUISJzB6MJlRJfzo5fGRzFgWFOh7iDqZY6regrjX9L+83Yzm/l7MUKJLL/4tzLa50WoxM5c0lFcDB+V9+iGVeHcYSCZXUWNXr7+rB6e69QmdoObSa3PZLlO7QjW7I9m8mbE4c4177UKzan0gzfeeaXPA6C7fVlBkgJShhZR4/7vx8+z9ngx2EsMc4h0GoolUGnsk5mbLaKr4B9nQXQ4oS5Jdj69vzUcyf9pTE5XNOb/BC1ijLiLoLD6g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cb02f8-9967-4364-1722-08df2dfd3b62
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:22:55.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /B31MmrUyA0uu1GNyqmWvGd6TEmsd7zCT/5gzW80e/tlo6Up8CSPbbFbahN6vQKEm/rndMNpjbKF59x3rXnwUiEcmPYsto5UO8lPGHCFJHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7624
X-OriginatorOrg: intel.com

Hi Babu,

On 10/16/26 1:53 PM, Moger, Babu wrote:
> On 10/15/2026 10:27 AM, Reinette Chatre wrote:
>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>> Some per-group resctrl files are only meaningful once a resource group
>>> has an active kernel mode association.
>>
>> Could this elaborate more about how the files depend on the kernel mode
>> and why they may not always be meaningful?
>>
>>>
>>> Creating them only at activation would complicate group setup and
>>
>> Why would it complicate group setup and teardown? I think it would
>> rather complicate mode activation and de-activation but since there is
>> no detail about how this will complicate group setup it is difficult to
>> compare. It is difficult to reason about a patch when the motivation is
>> vague.
>>
>>> teardown, while exposing them on every group would show empty files
>>
>> "show empty files" - technically these files, as they are implemented,
>> will not be empty but return errors
>>
>>> with no clear purpose.
>>>
>>> Add a hidden property to struct rftype to hide files at creation.
>>
>> Missing a "why".
>> This can append to describe how this adds the foundational support in
>> preparation for features to restore visibility when the feature's files
>> need to be exposed to user space.
>>
> 
> Will rephrase the whole changelog:
> 
> "Some per-group resctrl files are only applicable to resource groups
> with an active kernel mode association. Accessing these files before a
> kernel mode association is established would result in errors and does
> not provide useful information.

What does "and does not provide useful information" refer to? Does this
mean that the errors are not useful?

> 
> Creating and removing these files when a kernel mode is activated or
> deactivated would add complexity to the mode management path. Add a
> hidden property to struct rftype so files can be created with the
> resource group and exposed only when they become applicable.

Please separate the problem and solution descriptions.

> 
> This provides the infrastructure needed to control file visibility for
> future kernel-mode-specific resctrl interfaces."
Reinette


