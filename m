Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C683AC0C7;
	Mon, 30 Mar 2026 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859342; cv=fail; b=uhLgJ4eXe45sLGlwKzoKzOOZiaw/sBDEjy8qNYRB8GNN83oCBrKvN2NppAzREbkJ7mFBM9DNMgKpJ6Zx+s508aWHwp3opYk1zqL+ygfNBd8GHBAQsIG/vaYhuUOLmPXUnT71lm/dOA8I2mfLTjpfQ4xhFkJm4ttOKS+fW9vcUd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859342; c=relaxed/simple;
	bh=ZDB7pyKto2l2TgQrILefyVtdOa/snIBl4b4kk7dMHQ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FXZwhqZhN6ea+wZ8HywOWyIsZNUTb6kd2xWDRIF/YOdUuzbYOGUvUfijG+u2cFcvvPSWDmUNgc+drTKbiJiVggSQi0j58SE5STS0/kEOtsEQ0MOE0ouSxeeMQu7DARBASamUwX+hW2i4wpQyt9qWyB/RLXMXuC+i9VkJ5OrQMNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B38TBwgb; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B38TBwgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774859341; x=1806395341;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZDB7pyKto2l2TgQrILefyVtdOa/snIBl4b4kk7dMHQ4=;
  b=B38TBwgbGzld7MRHi6dUsp7Qx/EHG/uXGdzGv9LIpGjGzv/1QC6z2xbN
   qW6TD7DemooHg677Ak3ts5y4ifBjfCy/E/qEz+5H65Gs2qPJQWbM9iBUx
   XH3e3L8rvLyauf0miHgLlF+Daj0nlREtcfq7F+LEhvEWNEae1flBd9umj
   EqWB+FYXbmHrE4aBU7NND5la9SRAfVjDwjgyZEcReG/4uSS/5+e1P8pmu
   +xRnug88fcbfhbj/A2d71pamqlq1iHRgIs0WJIJ1X90OBW/IzYOpAK+oJ
   +oLBZKaWjDURcrZBUioX4vcnfrgEVP8vMIR3y+8i0U8KeYhzAko9dX2rB
   w==;
X-CSE-ConnectionGUID: Do47WQtURlKW5/dTo5zJPQ==
X-CSE-MsgGUID: iA+IXFTaT6S1oDDUBsQDMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86918533"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="86918533"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 01:28:56 -0700
X-CSE-ConnectionGUID: PY7ZdDh/Q+mKgRqOMbOh8w==
X-CSE-MsgGUID: 66rNx3WiTYu4juqCpu3p0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="230454429"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 01:28:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 01:28:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 01:28:51 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 01:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjRLQOrLGiYbjovC28dJuMPbqGwufNZl6Qne0YhcMZRKybYfCz0J2aa94OvQEth0m4fqmuQkBPywjYNKb4qThnCCI3kI19MFIL1J/eiBfvBgKrty8/OOfQZ+W6LXph8nzVRFF6Wsq3njrVOuXWNvsmmtYWtC7E/Q4aj4A+EL3uvIkP1uRwO4ynvYqeA/viz5y52gW7nLM7XtQ+OYspzRYnwOthRrQAXjbZMw5Ih6V1ZDuVQorSQZa6gMgQMJvVMNWKDjnRQs/v+Zmx425APqFDZw8WqMOuIEmuMBG/T2rfgiXxlE8wXIFPxYWmsnjN/CKdCr+1hZ/DYjUKjfFZpy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5PgvnebLm+J0WIliCRdNnnqHxD5kdvJD4/DnpreP7w=;
 b=HEfp8V/FCJhj63LW8G46JGKFhylZ3J7ZAm7l7BJKuPIuxaElLuq1OcHIXPvbsJPsIbZr5E4tCPula4xeHb4GZ/Jb0b11NnLeL522xy6DTGDLFYa6inwDP67XxW/MChDICgEd+PwMoxNO6epKY1BlCqoj8HXLa3GtewQM3/xt0/BvLekRX5LOkhB9t0BxE08UmkCPf3Qy5ukc8WU0HFfYuhie0+vmX5FpqZDJuCxNjwksWElrHZFblVzXojkqX/XIHddAMQ1cXj3+7Mb7/lH/65xZdj0coVNV3WUT/h7ty5B3DaxZo921+3mvBmFw9ErSidFKWeaP6MWtLkihkWaVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW4PR11MB7008.namprd11.prod.outlook.com (2603:10b6:303:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:28:46 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 08:28:46 +0000
Date: Mon, 30 Mar 2026 15:49:11 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kai.huang@intel.com>,
	<kvm@vger.kernel.org>, <kas@kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <dave.hansen@intel.com>
Subject: Re: [PATCH 17/17] KVM: TDX: Move external page table freeing to TDX
 code
Message-ID: <acoq94R7F7k/9AV/@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-18-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327201421.2824383-18-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: KUZPR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::15) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW4PR11MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b3e892-0cf7-44e5-3f17-08de8e365c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: u6eschkpa3g2TnnPMDC0ijKlWofa9W4p0fYWdvwMsAfNKX/FgItZqps2V8PqcWB3KIVxnvbDgc8Zkqkg7E0FVv6V1gWJzI9UAv3iQTUcoIEjGbY7InNNNwJXkG+dJH+YXiqrvpfNxjtBhHDbiPzFxYtIWkvTGU0s1/ZHqaJMSKld/fUuFKgqI/pnvQcLrEPmM3raTObJaAHfePNUM6qlQCXgFQw3MGQz6WDMMoCXw5gjTzGWmaRnoqs6doVgDWOz3BdBMaJdFcfqiGv/Lqb8aqy3wjDBnigPHYL79X2ZlrdI8ZvmvuRUvzeqelqsJ0iqjMvDQB1s3yziI4S5wvZn35Mc5V+hfmw4k+sizW946M4NVJbSPrrbDpOzhvypdN5Y2PF2tP18+sL7ZQAAxRaNPN+KVYoMC4pBO8CQb8keqKm0PNSF3LbOfplc1aa0rsEZRVRbgxnsdGYw+dFkyp42B43QEbTDUhnC1t83yA37aVRIcH3qxMnbUTpOToZNuqIuSV+8tBTwvXI6ZvycL2tw7f0/ThP2gSM0XE57y8qU2Z28FDJnssRwsE37BScx+HxM7fzsQ1zejajz8vkoYrK2k7UjcQAdQ9gCs2tplFEIIvLGOY5LUl4pJz8P8rhsmrUH7WsG/KJdWTklDGLcJVqvpTOBjPv+GvffFfJywwee54zLZ4FinrdqvURNnpojeaayTcwcf35AuVEfDmHZyKN/G/Xbc38/kYsIbNhOhrRITuXGunM+MvQhq06Cgmc1v7to
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUtIRGVDWmI5SEp1UUZ1M0lvLzdyckNaeW84c2FQRGFyYXZ1OXRVNnJSSXNw?=
 =?utf-8?B?ZU1BU05lbGN2a1lpcC9NZWlMbmg5VTZ5aWxQdGk0ajd2ZjRVZ2hVYmY5Qzlj?=
 =?utf-8?B?YWdmOWkyU2JtZ0I2eTdySjFENENkZkR0dVZSZXlDV3E4dUV1Qmg3clJONHQz?=
 =?utf-8?B?V3FlN3pVdGt1ZEYwVjVBQlBxa1MwVngwem9xK2tYYUJucDR0UGxQY0hKUlM2?=
 =?utf-8?B?TXRBRld4RjlzQzcxZmRrQTl4anZEZHYzZ1VEekpyTi9iZys2UEdzUWkrcUFm?=
 =?utf-8?B?MDdNZ0lHd0MwQWVHUlJJckZ1aUF6dEE2SlFlSktidVlvdzhXbmhuS2xhb1Jt?=
 =?utf-8?B?Vi9QckVWRWcybTQ1R3ErL3UvRTNiV2p2bVFTNUVwSXIxL2x5Qm4yd21YelBj?=
 =?utf-8?B?ZHVYUEdWL3BSRWxjcjNPdUNOZm5pbVE0RXJqTjl2RHI1QVhRblA3OWVNdUZa?=
 =?utf-8?B?LzVjeFBSZGV0VXdRbEw2THdRUDFYYlNaNkNIWnhlaHFiQUphakNKdWNyNXhX?=
 =?utf-8?B?cmoxVnB0QzBrTjRwa3ZuUU9wcFd4dGZraGFHU0hZTXBxWFA2TWtyb2s0UHVB?=
 =?utf-8?B?STlDQTJNdkVhU2drWFYwcEw1dlJsd1BIRVJ6WWFhT0xOUERkN0EyWWd3S01P?=
 =?utf-8?B?TVZHMDhHTlpCMU5odFR6MUo1cnF5dVpxUGZrbllhWk5WUnhEZGVITGlmQlpu?=
 =?utf-8?B?d3lmYWltQlBpWE5lSU90Qy9STzNhMHZOcWpqMnNBTDVQVHpNWlArcVZBMDQ1?=
 =?utf-8?B?STR1QWhWRTBJNURLNWo4bFoxUXlVU2NzcHFVampCd2xmT2ZHREZXTlRlL0dz?=
 =?utf-8?B?ZndwT3BJQXZseWV4VVN5SCtObHYyUXc3VnJTUWt0QnppWFlORXo4TWpRZGN3?=
 =?utf-8?B?eE9XRzVvVzExWGtTYkxTQS8xM1VHVVJXbGI4QjBZM0EzbXJGTllHSFJlWGly?=
 =?utf-8?B?cWZ3R1lnc082TTVyU3YrSnhvNUZlbW9qVEVwL0RFdEdiMVhuVi9CZyszc0Y4?=
 =?utf-8?B?Y2NJYnZBbFNPU0dqNVczTVhuYmozWVFFZ0FVdDFGVFd1Wmd2dzhHck5Hb2NY?=
 =?utf-8?B?YjlxZlRka1czYXZCMzN0QjFVT1JETmFmRHdyK2RzR0lidkszLzVlMVNCVVpR?=
 =?utf-8?B?RHlzTVhwTnVacEN6dmpKd1g1b0JSazdOcU1vV2dtK2FkZ2pSWmpLd1RQanUv?=
 =?utf-8?B?czR6ZWEvY2dnS0ZSc0taTHk1RWZZcFl4NEJ2U1JoemE1NEdVS1N0WFhieTRG?=
 =?utf-8?B?NDdtOHpWbUFucHMxMDlINlh5VU1YWFNiQk85UkhOUHZuNXJqWEJlZmd5c29k?=
 =?utf-8?B?RDdNTjhNT3llYzhkeE05RTIwNGRoL0JJNHhrSldObGIweGp1d1dvVnh5SU1X?=
 =?utf-8?B?Y1dWQWRJTjhGT0ZGNTFTOG9WTHJldFBLcUFXL2VOZHIvSmxVU1BaU2U3WGhy?=
 =?utf-8?B?b2RDMlFBV0JDeVc3TTBoT3pOeWRUSHErNW5uUDRWblN5OUU0cmxlZmtMdFZp?=
 =?utf-8?B?bHh5ZFlEMFJJeURKMFNlaEhtT1h6WUt3R2NEQTJVQWNpbmxnaEd1T2NoL1N3?=
 =?utf-8?B?ajdOWWhZN0lFZm5mVzU0OUpiSUlrbTAxOXhrWVJTOFl4WWkyUU5yU3RreEp6?=
 =?utf-8?B?cHk5U3p6SkpKUTZCWUV1QU1Ia0NNanFrTWRYRkt0OHk5UUhQaGlzakhnWDBF?=
 =?utf-8?B?Q3g3Z1FkaDIwNXd2Z0diV0lwdHNwWHU3cFNXY25hdmI2ZGo4WnM1VGxLd0Fv?=
 =?utf-8?B?VGNOZlRRUktqSisyUVkyalFLT0RYWUtvU3MwdGs2S3o0MjhKZlc4VzhPSzlQ?=
 =?utf-8?B?QzBMZW5mNFg1Zm43VnN1ZlRNSmtWWEFReFpWL2xoVGg4YnU4TDUyelNUWm5W?=
 =?utf-8?B?bjYzSi96ZmlnTGhXN2Z1QWtPc1Z1LzJ5dkNyT2J4K2lOTEo2cHNKVDU2bEV6?=
 =?utf-8?B?clZRZ21NREExd1FsK1BGT1RlaXFFNHI2Ukp6UTB0MFRoLzNwWTFXcTBSaDRp?=
 =?utf-8?B?SHZseEkwY0Y2UDhEbjVYbnN2V3hubFp0U2lsMTJxSHEybFlWcmMzK0k4TzZt?=
 =?utf-8?B?OHJiVkFpcTF0d3dtVkNhZ21oTDdKMmZqWjZiZjRzcjJxSnlqL1J4aUFxdzd0?=
 =?utf-8?B?VU5xUm5UQWh2T2FSYTFiWDM0L000d2JIdUNsbk84NFRUUjE0OUtjVVNKT3Rz?=
 =?utf-8?B?YUE5blhFWGlEd1hZOWZCNHBZQkVFeHVvRy9SOG50czVyT1hmWERCb09qd2Fx?=
 =?utf-8?B?UkZGWGxvWlhUVFJLMWFJSXU0S21oTW4rQmhYejVsQ291Y1dUMkpqU3RxY0xW?=
 =?utf-8?B?VnFTaWV2S0FEQXhxWDdKcVVXd0M4NzRnR2ErUFc0QUxPNG10Q0ZBZz09?=
X-Exchange-RoutingPolicyChecked: RVV31yQJLm9Xz8EAXos2rdQjjzFxbsjsNHLZ+aOpfbTR131AnDhEQGx43wkrlBhLWnOYspDw2Yw0e3oLt8y4VcVhdHLzieQbvhlFUVmIqQwecxWkM6wREoDJxhpvD2xO+CFcM6yH+iPsQU8nO9TeasM1ST2wjFc7i0XXyYMIm6CsJAOh1eRghO3T5kn8CMgepMaEekYKdszNgfC+9xEXF3jfd2VDAyrbeGY4E/5kq5SPNJrY2PYG250RzvJX0l0Z7glAh9x8NoEXVvMJvuUXAqBk8oghi7Zf+ugDoroBePPco73TwUSn+octk0VCc9RD1/OYY+Cp5C39VVRPIQ+BIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b3e892-0cf7-44e5-3f17-08de8e365c48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:28:46.2103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUIOwCXmEvtqdQpm3l9+xPXw9t1cjDXUQ0xgmIcKFvV7E+COzRoCL0wWi/qx0GbGQ4g10vaAOqmkKmS5REne+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7008
X-OriginatorOrg: intel.com

On Fri, Mar 27, 2026 at 01:14:21PM -0700, Rick Edgecombe wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Move the freeing of external page tables into the reclaim operation that
> lives in TDX code.
> 
> The TDP MMU supports traversing the TDP without holding locks. Page
> tables needs to be freed via RCU to prevent walking one that gets
> freed.
> 
> While none of these lockless walk operations actually happen for the
> mirror EPT, the TDP MMU none-the-less frees the mirror EPT page tables in
> the same way, and because it’s a handy place to plug it in, the external
> page tables as well.
> 
> However, the external page tables definitely can’t be walked once they are
> reclaimed from the TDX module. The TDX module releases the page for the
> host VMM to use, so this RCU-time free is unnecessary for external page
> tables.
> 
> So move the free_page() call to TDX code. Create an
> tdp_mmu_free_unused_sp() to allow for freeing external page tables that
> have never left the TDP MMU code (i.e. don’t need freed in a special way.
> 
> Link: https://lore.kernel.org/kvm/aYpjNrtGmogNzqwT@google.com/
> Not-yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
> [Based on a diff by Sean, added log]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 16 +++++++++++-----
>  arch/x86/kvm/vmx/tdx.c     | 11 ++++++++++-
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 575033cc7fe4..18e11c1c7631 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -53,13 +53,18 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
>  	rcu_barrier();
>  }
>  
> -static void tdp_mmu_free_sp(struct kvm_mmu_page *sp)
> +static void __tdp_mmu_free_sp(struct kvm_mmu_page *sp)
>  {
> -	free_page((unsigned long)sp->external_spt);
>  	free_page((unsigned long)sp->spt);
>  	kmem_cache_free(mmu_page_header_cache, sp);
>  }
>  
> +static void tdp_mmu_free_unused_sp(struct kvm_mmu_page *sp)
> +{
> +	free_page((unsigned long)sp->external_spt);
> +	__tdp_mmu_free_sp(sp);
> +}
> +
>  /*
>   * This is called through call_rcu in order to free TDP page table memory
>   * safely with respect to other kernel threads that may be operating on
> @@ -73,7 +78,8 @@ static void tdp_mmu_free_sp_rcu_callback(struct rcu_head *head)
>  	struct kvm_mmu_page *sp = container_of(head, struct kvm_mmu_page,
>  					       rcu_head);
>  
> -	tdp_mmu_free_sp(sp);
> +	WARN_ON_ONCE(sp->external_spt);
> +	__tdp_mmu_free_sp(sp);
>  }
>  
>  void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
> @@ -1261,7 +1267,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  		 * failed, e.g. because a different task modified the SPTE.
>  		 */
>  		if (r) {
> -			tdp_mmu_free_sp(sp);
> +			tdp_mmu_free_unused_sp(sp);
>  			goto retry;
>  		}
>  
> @@ -1571,7 +1577,7 @@ static int tdp_mmu_split_huge_pages_root(struct kvm *kvm,
>  	 * installs its own sp in place of the last sp we tried to split.
>  	 */
>  	if (sp)
> -		tdp_mmu_free_sp(sp);
> +		tdp_mmu_free_unused_sp(sp);
>  
>  	return 0;
>  }
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index d064b40a6b31..1346e891ca94 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1782,7 +1782,16 @@ static void tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
>  	 */
>  	if (KVM_BUG_ON(is_hkid_assigned(to_kvm_tdx(kvm)), kvm) ||
>  	    tdx_reclaim_page(virt_to_page(sp->external_spt)))
> -		sp->external_spt = NULL;
> +		goto out;
> +
> +	/*
> +	 * Immediately free the S-EPT page as the TDX subsystem doesn't support
> +	 * freeing pages from RCU callbacks, and more importantly because
> +	 * TDH.PHYMEM.PAGE.RECLAIM ensures there are no outstanding readers.
> +	 */
> +	free_page((unsigned long)sp->external_spt);
Since sp->external_spt is allocated in kvm_mmu_alloc_external_spt() in a similar
way as sp->spt in tdp_mmu_alloc_sp(), why bother making freeing of
sp->external_spt special? i.e., what's the downside of freeing it together with
sp->spt in tdp_mmu_free_sp() ?

> +out:
> +	sp->external_spt = NULL;
>  }
>  
>  static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
> -- 
> 2.53.0
> 
