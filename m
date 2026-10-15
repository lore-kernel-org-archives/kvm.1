Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07524ED18A;
	Thu, 15 Oct 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079046; cv=fail; b=INEXn+9chXwj6SX3MW95/lN93JaVXB78s/qesG5S9ePDrrYLCCo/QAsxdkHWYn8vaeVFLEOutJpPB9rFEZ+Pbkgh3NBnQHLJia3U1hCR5n6VqOLa6xDEmIWIsrfgv91WCs4ckl37hgWvU8rlmJajvpyu2Hv9z1KkZ9MPBJJ1h3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079046; c=relaxed/simple;
	bh=o4w0ruqToEepV1V/UnVVaJEgD1YpDFe1/GbmroL9bSA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOIFHcx+DSs0B6ZvdWxa1nl56SanWa+ikJD4/zLic6HsUKOIy2DpkHn0NKHgVgL+mmCj//D51Cbn+E3+x9II1Jm+ZnUcmHFjPYSEZZAaPXC1R/kUEqy+0FCbgM6FamKAsVEU8SVXyVlfYwl5aJIkr2Lw2UTNy9DCUV07u1eph+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmX/pFp0; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmX/pFp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792079032; x=1823615032;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o4w0ruqToEepV1V/UnVVaJEgD1YpDFe1/GbmroL9bSA=;
  b=jmX/pFp0MuX7CUHd+Xroq6pjeXtwC5lCNBGEhEsRtNVb6KC+lJkoI/rg
   Y8qOWvo9JjyKyonA5LxC6J2dwrxt1GRjFfH82Ic7ANXIdtMSk4PdwN3LK
   NMlNCjjriGbfAXLj4MU/vqJoeC/5GbMcJyqcIgbHWHCBb5Q2BZDguLl5Q
   irPxR09dDozH4s3dS4qK3bycSKM3w8E5ivjH4qoQvcI6zO2x4Ji7MbZ8l
   121w/R5BDH47kgmectxhBZFAMVKvYwWKTkuLO3l6HVV7l9VYQ9Fgy+8vh
   MuRwdE27Q5vF1ABK0sIbTB3opkWhIB6vomuDerpD4mwK1jWlLYCszLL2c
   A==;
X-CSE-ConnectionGUID: cSf4Q2jiS8WGxifI0UCTQQ==
X-CSE-MsgGUID: nuJhiRnXTtCJ8b+5wGFtWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="843931"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="843931"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:43:50 -0700
X-CSE-ConnectionGUID: 5/XxSRyFRfunX5kRPjxsSA==
X-CSE-MsgGUID: d+zvZbO6SPWtcer0RMo5CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1636219"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:43:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:43:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:43:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:43:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/ZlEWC9yv2pG5BqrId+5Zs/1QKYs5uKhXy75WLKtVKe/8XJLRsXCrk0GBwt+5rFpj4xWCkcyy7YawG8++sZufailrl9BMrQ3NERnnwAO9o72agVl/xgYfqSKTBpY9LOfnJJiVIebBb77uxV+v02KuY6PZQgQoLpoAvVr38tDCk2iyhqQrPsSMnskIPySV5823GRgjuj9NtwqBySHg/pCRbKkIA48LlLNvYcdzUrQ+eS9VaguRiZlmW5JDlaxGzgPf0vFK2G1wVtgEA37f9beuBW8GXbZNwacg4izRn1GKMj2dxKelXAshoa54ftoddA7DciWZUH2TbjFZIze6ieLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFiJwY1+4aTrsdQuK/3KCL/iA8SaY6pPMxTRkNPtzI8=;
 b=B3Fx2HYp3ldxHrikyyeLBoQP37PVuowvdb4258QqFbTzyfnVEAF7+uQef2qSY0qGODQT1ByK9Z07tLIbZYOlnzxeY3fqDKahdFljF2O2iknUkA3GQgX8kNG+VDxDPAbBlyaSweFoyTDIibQERCR0sNR1/F9EIZqGibIH+E2XjTrh30nTfDDQypt5ZVTcqd8LCZn6cR3T4GfaPB5eswQ3y7cl4Hh4ewwIjwIi9Bqlgo4yAuJGJaqmUeJopEevaGXZz4UZa85rveuuzfoZXAo+pqAIRBdab+ie/gfhhEB7Dn87y149xF1erRKLcivHKXie+r+7gyHj0Z4BtOUIx7re9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by PH7PR11MB6884.namprd11.prod.outlook.com (2603:10b6:510:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 15:43:46 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 15:43:46 +0000
Message-ID: <08e1de88-cab0-4caa-87f2-94db0f698ba7@intel.com>
Date: Thu, 15 Oct 2026 08:43:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/18] fs/resctrl: Deactivate kernel mode associations
 when a group is removed
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
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
 <e9a2b05b2322acf51e16571d07bc7ee297613b3c.1790867441.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e9a2b05b2322acf51e16571d07bc7ee297613b3c.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|PH7PR11MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e248364-ac15-4485-9ba3-08df2ad3194a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SsALWOLw7Jn0+x31kIgRbh0DnS5MPlebZ7ytKJOx5GXjWE7axUBfhZa/E7Kf1NA8VbCutET+p1MI3sfJ/xe30xBDiutGltxKwUQtIyo4731c4OAZ4AOh8PDcvZbg4TacGAwoshis/a3AB/MVVM8/tcDRLOuvOOMK3OjznkgXVE4Sk0PRl1F1td3VdxwOsBesrtH1uOxVq9NkY4htGsicVy5n0jpWjlv8MJm0DPHNgridfGhJSqptBXQ7z9cHVxRs9kAhExyh5wbhmDspgj8SGYnqwpn1VNhF1umRg/jR2oFGkJd4HQVT8Nzr8ufEes29TRSfyAurMCZPMSu1eSUzS+APeSXYny7H+J/pFuTZQMVhbT2haZpVieH7nvpRL6ChcSZ0nNy9TOIHzVXKBz5wvWqLbPMLNLs/S79z5pe9snEzNACu8rJ2TToP/q3YpanX6GTNe2Sz1lkP4e3FZPdZkgyUQTni4Iv68Cd/AYQmFIVheohd+w23C31YIH41q+roj5m1PRZXeF8bw0J7rxbSvk4rKFZoAyBsMuEOeyaxltpjiEiZfaQ3/mWJpToNo84GeRF+yxjsbIRDpVlUD3A4S2P9ed8sQiM+T7+qjlFOXOMJ4bL/LAL5Wth/qewUwqUtp6/2a9DImyir91Zp/kurlboTblTaadi0DTYdGB15IAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3dWRlNZNkZpNUhhNVRuY2lZRXFjMEdXN0g3SFFJamhtdnFqeHhRVHVrb3RQ?=
 =?utf-8?B?K09aR05vdjVrTnRIQWJ5UDg0eHI1Mnc4bFpMU1MrajBwazR2dmhHRGI5SHpP?=
 =?utf-8?B?WFJ2VjROR0lsS2p6R0tSdzF3YlRPK0JSeVhBTVJjRmE4YjhYdzNPMGJ2akta?=
 =?utf-8?B?dG5RNmNZYWpUNGc2T2ZEWlpKaDVaMTI3Q3ZHNlpGYkYvbGRjVEdYeVZ6UVc3?=
 =?utf-8?B?ZkpGdGwyQUlXTHJQVjhaS2ZRcDVzeEIyalBySytHckFvbys2TE5zblByOHNI?=
 =?utf-8?B?NTErUGI5aFZOanBObE5SUHRlbGdXVVJTeEJkbDdvdTIvZU0rVWZsQ1pLSFJz?=
 =?utf-8?B?eVdISk5WcHJiVmxOYWtXQ0JjekxQL0NaNDRONGtIeWtXQjNwNmIwWWNncE5V?=
 =?utf-8?B?SHhjRTd5OElKbWttbG13ak50MDlQWGZMUFlXTEZhenZFcGtUeko2YVFNREdC?=
 =?utf-8?B?Y2ZhK0JwNEpPWHVIRzFmLzZLbVpKVzdzOUFXQ2JJRVlnWjZVaElOU1hPNmxw?=
 =?utf-8?B?NUNEMUVFdHB3SUs1a3A4R3hMQjdpdG9pVHpwOFMyVjhoQzJkWWVibjVpd3I2?=
 =?utf-8?B?aDNWVjNRdkdGOHdOd2JpOUUrU3JhQUVBdmNKWnhrWFkyVUNNWWhSbjltNURZ?=
 =?utf-8?B?L1RnVzlKVEJzRHp0UzJidHFCWmJycjdzSHlna1c0aDZySzNsYWtGS1VmaW9M?=
 =?utf-8?B?TFhjSFJDZEEvRXkrNEM0Q0hTTlhyNlNtWFM4OTR1d2p4WFhrMExQc3RtZmlm?=
 =?utf-8?B?VlZaa0lvTGhabi9DYU9FU2JFeEZYaUZ6YVJtSjFuVUo4S1VrbG9LNUdLVm9N?=
 =?utf-8?B?bzIvb2FKZGo4UHB3N2hnL1pGdk1mbUQ2dzc2RGw0dXZkY21admtUcFdma3FY?=
 =?utf-8?B?RUNMZVg2UzlLVGNnTjFZR09jQXJJbStnT3U2VkRPNTlubk1Gd013QS9ZbVM5?=
 =?utf-8?B?ODF2d3QyYUpZQVpiQ2lYQTJ2WUxyaDZCcFg5MW9Md0k5SFdmYzN3RkNOb0Vi?=
 =?utf-8?B?bUxpbkxJZWRpS0xKR2M2ZXFLZ3l1ZitsZzhFK3RHYXZIM1BVRDc0NllhM25m?=
 =?utf-8?B?N1F1REFEVDhvbnRxNWdqR1JSdjBMTkZ0YlRwRGswR2dBdlZTWTFaZW5FNDRw?=
 =?utf-8?B?dkNPbHN0ZDhGNUl3WjRLS1VmMXBYMWZLUGJPSEUwZUhUWjdpeGdxS2NqaEVu?=
 =?utf-8?B?aXNGUTlscHMvY3F6eVUxaWJPZlZsdkp3TUVYbnBDOStqTGFocnpXZENHUGZE?=
 =?utf-8?B?OEJYYmVVZ1ZHVWFuMnFyN2o3TUtGN2c2ZUpJSjhXL1pRU0ZpQ2E0eDNOM1Vj?=
 =?utf-8?B?RzQzWTkwNzJkL25XUk5VUVV0a1N5QXFzdkIxYVJKMks5VDlGcDlEbEQ1NmR3?=
 =?utf-8?B?dzFtQk8rS1MvZG9KK3BUWHllMnNNeDVLV21TT0E5ZkY5TVZmY2JoalJINjJs?=
 =?utf-8?B?M09vOGcvTjBqMjF2ZS9jRmRNN1RlclRIbDJzWk9zRWZtWVZ3a1Rid3dmYzhO?=
 =?utf-8?B?QUNCVUYvb3N6dkpnK3AvK1BTL2FDbmxDSnhXWUFQTDF0TjlXWFVtaExWVmND?=
 =?utf-8?B?VThDQi9JbHRKNHArL2I0aXBVcW5hZG9tWlBBcjZub3ZlM1RLQmFsSG9sNVhT?=
 =?utf-8?B?c3hOVFhmeFZlUnBRRG9WeWNlelhCdFFiSVh3QzJnUzFBMG1YOUMwM0lPMzli?=
 =?utf-8?B?YS93K01aTTg3LytwMjF5VVlWS1NOaWlBUm8xVndBOVVOQ1YxVW4xczBuZDJv?=
 =?utf-8?B?MUt2eTV2SVV4UGI1UEo1Y2NiUGNtVklLWHEwckhycTBGSmVXa1kvZDRLb0c1?=
 =?utf-8?B?b25waW9IaStzakY0aExzMUczNExEaTJ1WmxKalNFT1JLQWpmZE5JWUVqcHhV?=
 =?utf-8?B?ckRIMkVYVDE1RFBkcXo4R2lHdHJIWkdMMG1meXdKR0l2TWlQNUNQSUtQZGx4?=
 =?utf-8?B?YlNJY0xCMlhOK1JvdGJkTExNMXU1bzVtSlVleFdXTXdKZlFYdXZoa1JSMnJH?=
 =?utf-8?B?OGZSNnoxYkN3RkNnSk8zWE5oSCtJY3FEcExXeG9ZMk5GVnBEU3ZZWlp6ZmtS?=
 =?utf-8?B?YklHL25FTWs5RHJRUmV4bm1FYmdUY0VFVjVlRlphTDI4bTRJenc5L2dTVndO?=
 =?utf-8?B?Q202eTFOOGxuYVRWMWZmWGRKUXB3RGVMaUExSHpVL1U5S0ZQMk1rM1N6UGZY?=
 =?utf-8?B?N1QvTUJuRFlMMjQwb2JVU0RkLzFPeXpSLzZrMzBSeG83V1pTVjlmeW1HeUlC?=
 =?utf-8?B?N202V1lJNEw0bm11RE5LbVJuWmxGREJHazBmRnFobmhFQk9tZ2M1aGpFYjlu?=
 =?utf-8?B?d0NaZE0xWHB5N2FIM0JCZHdRQ0VnWlpMWXlRaUVzWmR5U3RKR0JPVlFSalRB?=
 =?utf-8?Q?RBKJ1CiEzuXaiOY0=3D?=
X-Exchange-RoutingPolicyChecked: MeXwI5jlYphWlqA63t0ZqAG5zQTha57gldJXf3tZsfL6Oi4rlAyRtZpYBHF3JD6xH3KkpeMG2SPztn+m/fsQWzonNkRxK9fkLA6pS9jFJRuybalDrR5HhSq+kQt8kkZZT33giYBPeIeGN3iuSQKozvukllxP8DGbtLkQ671ItM828lo3J8Sbs5DAEUzTJ74A7P0jO13uATFbjNrcpG/TRyAS1IvSIRBpU3IwU9r8EDq9yt53hAg9SAqGVKFx2qr7HHHqHO7M1JIFsXIhYKiUjTtZb5gx+QH1vu3UZxuRmOoZbwDCFnvEs8z5ZTRhbWCFpubqDy+oMC/RiWeRdcY0hw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e248364-ac15-4485-9ba3-08df2ad3194a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:43:46.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoFRJrOMDdCifMTMpqXFBbTDs3LVyD/qppNHTZRGQq6d7tgwHJFkzeZjP+PlzLMyVeyfesrWjkUpXTkNQ7s8Y3WNSf095WOv4xqC2ocINPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6884
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> The active kernel mode association is backed by either a CTRL_MON or
> MON group.

This context does not reflect the code at this point in series but what
behavior will be after entire series is applied. It is also written as
general but specific to the global per-CPU kernel mode.

> When the backing group is removed, or when resctrl is unmounted, clear
> the programmed association and restore the default settings.

Please provide more context to user and help reader to understand what the
patch does without needing to decipher the patch.

For example, "restore the default settings" is a very vague way to
describe that removing the group backing the global per-CPU kernel mode
automatically switches the kernel mode to "inherit user". Please explain
at high level what the code does and why. As a hypothetical, why not
keep the kernel mode as "global per-CPU kernel mode" but switch the assigned
group to the default group? This would match most other similar resctrl behaviors,
no?

This is also user visible behavior that should be documented in resctrl.rst.

> ---
>  fs/resctrl/rdtgroup.c | 44 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index f5c7790f7970..0cdc868a55b1 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1167,6 +1167,36 @@ static void resctrl_kmode_global_offline_cpu(unsigned int cpu)
>  	resctrl_configure_kmode_global(cpumask_of(cpu), rdtgrp, false);
>  }
>  
> +/*
> + * Disable the association on @rdtgrp's kmode_cpu_mask, clear the mask, and
> + * hide the group's kmode_cpus files.

"hide the group's kmode_cpus files"? Does not match the code below.
Even so, the comments just narrate the function.

> + */
> +static void rdtgroup_kmode_global_deactivate(struct rdtgroup *rdtgrp)
> +{
> +	resctrl_configure_kmode_global(&rdtgrp->kmode_cpu_mask, rdtgrp, false);
> +	cpumask_clear(&rdtgrp->kmode_cpu_mask);
> +}
> +
> +/*
> + * rdtgroup_kmode_global_detach() - Detach @rdtgrp from the global per-CPU mode
> + * @rdtgrp: Resctrl group being removed or torn down.
> + *
> + * If @rdtgrp backs the active association, disable it, clear kernel mode
> + * state, and restore RESCTRL_INHERIT_USER.
> + */
> +static void rdtgroup_kmode_global_detach(struct rdtgroup *rdtgrp)
> +{
> +	if (resctrl_kmode.rdtgrp != rdtgrp)

Please do not use tests on resctrl_kmode.rdtgrp as synonym for
resctrl_kmode.active == RESCTRL_GLOBAL_ENABLE_PER_CPU.

> +		return;
> +
> +	rdtgroup_kmode_global_deactivate(rdtgrp);
> +
> +	resctrl_kmode.rdtgrp = NULL;
> +	resctrl_kmode.kmode_cur = RESCTRL_INHERIT_USER;
> +	resctrl_kmode.ctrl = KMODE_ASSIGN;
> +	resctrl_kmode.mon = KMODE_ASSIGN;
> +}

There seems to be some duplication between rdtgroup_kmode_global_detach() and
resctrl_kmode_switch(). Since the contract is already established that
disabling RESCTRL_GLOBAL_ENABLE_PER_CPU enables RESCTRL_INHERIT_USER, could this
reset to RESCTRL_INHERIT_USER not just be done in rdtgroup_kmode_global_deactivate()
without duplicating it in rdtgroup_kmode_global_detach() and resctrl_kmode_switch()?

With that done, it looks like rdtgroup_kmode_global_detach() could just be
dropped if rdtgroup_kmode_global_deactivate() gets the check to ensure the
group needs removing?


> +
>  void *rdt_kn_parent_priv(struct kernfs_node *kn)
>  {
>  	/*
> @@ -3228,6 +3258,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>  
>  	head = &rdtgrp->mon.crdtgrp_list;
>  	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
> +		rdtgroup_kmode_global_detach(sentry);
>  		rdtgroup_unassign_cntrs(sentry);
>  		free_rmid(sentry->closid, sentry->mon.rmid);
>  		list_del(&sentry->mon.crdtgrp_list);
> @@ -3265,6 +3296,7 @@ static void rmdir_all_sub(void)
>  		cpumask_or(&rdtgroup_default.cpu_mask,
>  			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>  
> +		rdtgroup_kmode_global_detach(rdtgrp);
>  		rdtgroup_unassign_cntrs(rdtgrp);
>  
>  		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
> @@ -3360,6 +3392,7 @@ static void resctrl_fs_teardown(void)
>  		return;
>  
>  	rmdir_all_sub();
> +	rdtgroup_kmode_global_detach(&rdtgroup_default);
>  	rdtgroup_unassign_cntrs(&rdtgroup_default);
>  	mon_put_kn_priv();
>  	rdt_pseudo_lock_release();
> @@ -4395,6 +4428,8 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  	u32 closid, rmid;
>  	int cpu;
>  
> +	rdtgroup_kmode_global_detach(rdtgrp);
> +
>  	/* Give any tasks back to the parent group */
>  	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
>  
> @@ -4442,9 +4477,18 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
>  
>  static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  {
> +	struct rdtgroup *sentry;
>  	u32 closid, rmid;
>  	int cpu;
>  
> +	/*
> +	 * A monitor group uses its parent's CLOSID. Detach a child that
> +	 * backs the association before that CLOSID is freed.

Why does this have to be done before the CLOSID is freed? The monitor groups
are cleared later from free_all_child_rdtgrp() that will call
rdtgroup_kmode_global_detach() for every monitor again.

> +	 */
> +	list_for_each_entry(sentry, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list)
> +		rdtgroup_kmode_global_detach(sentry);
> +	rdtgroup_kmode_global_detach(rdtgrp);
> +
>  	/* Give any tasks back to the default group */
>  	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
>  

Reinette
