Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792426755;
	b=cRMYa86ygCWL4ORmG9xXiafKLKEZoj4ZhEg6rO9x82f/SCZtGI0Bmzg40dZMN6nsCx+p
	 aK+e0h+xvbKQAnBK94wyrHMW9RnzClYSup+dA9PoVp7dc7gvQry3qu6Yji+ZYeilSX+AK
	 6NJU2niyMBc3/oSzoHnB5oe7bCZ0jXDhOle4RRHEpQM6auKNzZ3F0yA/d51kdHNiT8lP9
	 Y5V7yrNvEvLFBQcfI6mXplbmHy/bTvvBIdosEcRyr/PA3QeOOBDUCyPIBmDmEeRDpEBgA
	 2OrGNtKQ2cTOC+b/GTBncjFQNteR8/g3FSIo8YzVfZYlwH8XIiL/ADBOD5/zbjeHhAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426755;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=6k04JviBV6gL95y2dhAlxRcvrNJM2JuAiOhwCy0gPmY=;
	b=josHSSjmcohpQbBK5akcqXDw4qfXPQ6510ni5hNJ7L8csFMenoDgyrR/iovpBklIzv27
	 u1aK/Or5DOjTRkVaI/kecwGpHtGEsB5X5+pgoWguwDUzMwdouHTFUIKT6/eTX7HAHX+2W
	 2WZnjXR1tBZc+vTZ0rURcs+VEUq/nxlUfgzckqZyoH4C/DrL8BJjtA3fv5pRe9ka1I/Xd
	 IuttC4cmmromQCOTTth3t4W+nHyuul70/lFLSscfZ/CiKQxpRm0cCblPBoTgJd3RWZdJm
	 6MK5F9dlwHwnzATOmSeceCsa6G6PFg+i6h5f2Nmlr/6AtIRa3Jd3BnUwwTLn/Ebbp6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="fAz/+wiw";
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFC606A320;
	Mon, 19 Oct 2026 16:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08CFC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fAz/+wiw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792426754; x=1823962754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BxdO4D0mnNuAhKZi4/JHWHh6LlN8TrdAY2f+Yb808gM=;
  b=fAz/+wiwwJKIwDYIhQM8LlDdTeJs03xTxOqIMEHu6fO5TW5ShZFOFXni
   boI3ji28Ver1l58GUz8MTWgrQ9dkn78XvNvUfKkGJJLvYlFucdC2gypdC
   QGLIOj0PlVieNolZpCe/lCdpct/IbM3+co2O++vibj9MjU/r+7tFcg06r
   iqivV7Y4kxi2NQ+2XQ9AJEVqKgbrfzxSpHfkTaEnsG1XsOaLdT4T5dryJ
   WolJJnsxhiqdf9LJTVR/UsDj9gHSOM3TGrhArciClIBGerbgtujaP4e4E
   NvtUZnKrGJ6Ka8XjURBwVLOsA+6ljlyTbB77nbUzMNqQQvUgdSQ4y5HjU
   Q==;
X-CSE-ConnectionGUID: djpbJniLQFqEOEtxH40JIQ==
X-CSE-MsgGUID: h3tMEEJQTTaBUSWGPW3xww==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1127476"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1127476"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:19:14 -0700
X-CSE-ConnectionGUID: 5NF3tEpuRB+9GfW1LOXK/w==
X-CSE-MsgGUID: KyWE3HBFR42DrPlo9WOUSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2646645"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:19:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:19:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:19:12 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.23)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:19:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToibVk+/c+ckkurlcbU08mm/3+5XlYiuFWkH9ldLiX9tChEaRtYm++0J+0eHP8841DvtOyNHUzyfzKuqKErlRskZMlgEE/xW10ZIKTCUsMKXhT8bm+7hW0qZHu75Alse7MCuhxTvxfKezkg/yi5b8TXD4Lg1diLgoRCKeopRC2mkaIFpLY124ZiYBysZqjrHiZGe1yIv5umpxLIZmxK5H49BCBa/qos7bF4jE0ak01iclMVwFrxrJPCaTCbgRI2Jozr73FWtNX4hNv2LqA1W3h5d1mrz/dO29S69uLb5AxAamt13XRe8aO9yUUoYzYrrgr65icpdoR5e0bcR2ABFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6k04JviBV6gL95y2dhAlxRcvrNJM2JuAiOhwCy0gPmY=;
 b=oDyzMlImgCZgwQgVS7dW2UCly6fdvn+bNU72lWd4dNU9R1RlcpIO2tvjVSXYmY5mVNBAgU4K7YXY30hTZ0LJDPUrw1AF1NfFD8/QgCRfqCi65/V6Db1vj4lh8SAeg7EPbXmEjqjtrjKEyd+0AQmyxZ4v4iN/+qVQxOTR7XgftsiCSuUdiOCfx5kabDflKuuR6xSZTz+wfxMqvKoBVgkluUyXMTQqTjSHnNFFAew0hAlES06cPXzB1/w96aTRKsWD8Q4opbNH1bCat4AqauMTZX94u+RI3ooNJ3MtkW3gJqmMq/noovmP/MW+WPH7n1a7Cm8TEB/YesILzXpYVdJKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:19:10 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:19:09 +0000
Message-ID: <e9d9e870-18e8-4e6d-bf24-dd782837a11d@intel.com>
Date: Mon, 19 Oct 2026 09:19:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/18] fs/resctrl: Introduce
 resctrl_set_kmode_support() to register supported modes
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
 <50333925a56037a0ea82c49f25e76be6271d299a.1790867441.git.babu.moger@amd.com>
 <0b633c57-2938-42c9-a6ed-863d88d2be63@intel.com>
 <e2bff854-eda3-46c1-9ecc-c1aab1e7b33e@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e2bff854-eda3-46c1-9ecc-c1aab1e7b33e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:303:dc::28) To SJ2PR11MB8370.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|BY1PR11MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 116e58e2-50f3-4c97-a585-08df2dfcb4b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|6133799003|18002099003|10067099003|22082099003|4143699003|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: p/DjuSN136iZfBVXCkQktlqbRGzxLo8Os1KT4tPmKhFlMytapCcKo7/QBhp+YP2P/38O0IclbgMqMJ7vi5UsWrlVLCGX4nQwsWYWakyizDICPjOpAFfCwFAlz4VZbjhI0qs4F1vWRSpregeD3g6xKuTcNdUR+D9S+a7ia/ojw9nvf5qEo6cEgvWjexw11m6EAt3nIfH0F/UmiylzM4R8V4l0Q9c4rt7QrKEl/ggTBMhFYO9epsvxK0Z6a8hSXIXOYKBHj7J9loT8HNwJOTEt/CIvdspfPDDY4C0aW26yV54+rbAAZeX8S/pm8e55Hg+dL24GjfupVrOSD0xYGNkG+Aot6r8ZwNanoT8Hdz3z+SQs+rLzGIHYSKrzUFRh0kdKKzVI7EV+0zd8MG32aKnGiKtlSDcIIsLfOlTFHAxW6IvtwjAYxWD3o0VqIXzAIaxa5G7pM61f6hD6AGJUJ6luk0dEKvHSSbiNXBt0/GNl4srGj00cvwNP0HPiI/zgA6qhV+hLkakHgaKFEGiGq5qHcGg047zOtoNkNKXCv+YttuGXon79nS6rocIAmFNRMm+bIr60DeNUp/v9SYN0/TE/YBR3PoJAfCOEFgjYXgKsoszKI5eExl8hNvdLAVDqKNbNClw+LlF1HgpYpUIngU6wEbPJpjib0QqNBOAVpFSF4oM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXg1ZFcrZzJDaGl2R1ZjaWY2SE5xY2VXbFNJV2QxUXo2bUZ1SDArOGdOVFF5?=
 =?utf-8?B?UHlkZVQ3VHVhajhJUGJ4L2NHUW1KZlRHV2ZaYnRmSm9TeEczSUpLbmdCa0pF?=
 =?utf-8?B?R3FNUHZ2WExBbkNsOTBIbEI1RkE5ajk4akR5WUE5Z3dpYjhWQTJNdHd3NmVl?=
 =?utf-8?B?cGgzdmt2UWxodGlFVFZackszL2pYUGRXbGRSeEtHbmVPVk5USlFOeFUyeC9T?=
 =?utf-8?B?bFZBRGFZKzJZTW80MDU2QWxyb09LaWdJL3Qvd3J0ejV3TG5ZRWV0MmVJOGRl?=
 =?utf-8?B?Z3FqTkp4K29UekhtZ0FFYkZaMEZ5cVQzRUtNVTVUNjc3c1IzU2p0VDFLcktC?=
 =?utf-8?B?bWdtQmQrS1ZmNUtvL3lucjZGYjQ3UnJmR2ZUcjdiR0V2RGNUdlgrS1dNMHQ1?=
 =?utf-8?B?akNHZDQwWEV5MkE1MjNyMnVpZmJWeXU1WG9DSGYyY3Y4TW94MkRYL3JDZUhx?=
 =?utf-8?B?Q1l0WnJOUDNVZW1yZEtiTnJrTEtheXNFUnVDbmRjSE1sZnBXWjVUbHRUY1FF?=
 =?utf-8?B?Rk5qaTVHWnNndFFuQ2VRbWswWGdreVhCVFBlUlpRYXFVVFRBS3hZSHZxYmJH?=
 =?utf-8?B?MDJtL2s1cUgyT3ZpRkNsODA4cURoYUp6YVFvK2ZiNHhrY080SmViWlJCV1hQ?=
 =?utf-8?B?U2ZLOUk1UHZ1R0xWWFBrSUlhQnoyRWNnV3Fld0w2NlJXM0p0T3ZIRTVKVVhz?=
 =?utf-8?B?dWROSUwzZ2o1M0p0RjcxbnR4NnR1V3R1WFRvWmN1SUR2K25xaS9FNCt5Znk5?=
 =?utf-8?B?RnJaQyt5UjFNWnRZRy8ycGtQLzBoaHhTSDlnZkhFeEVTcmFUM1N6Mmp6MTdL?=
 =?utf-8?B?WEpOZ2pmMjF0dkhldmNyNGtadXFqSDZsODY3QVBWUzFqcDh4RitXaGtLL05I?=
 =?utf-8?B?YzBJa1IrTVVVSVBCdDlueitCcnNmejlnd1FzMVRtNmNSSi9QdGdkbjUxU2h4?=
 =?utf-8?B?dDcrTTFLMVBub0UxL25ydzBRbkRIWHVZQ09sajRZa2VCR3pMWkFERmJtOXhr?=
 =?utf-8?B?bURQcit1NThIMmNFR204UkRqaWpyKy9FK3Jaa0E4cWg3L3A3clhtTmVwa3ll?=
 =?utf-8?B?M2ZkSkNDUkZsc1JDZkFmYWV5TU0rYksvdjZHT0J0OWxNSlJpR3E2ckpBSDlE?=
 =?utf-8?B?VDE5RW1ZaVBuMktRUUpFckt5bHNRWjJEdkRqb1B4MUlZc2wzVkUvN25HVUoz?=
 =?utf-8?B?VXpmOE1RakR3L0pRQzRsNXdjRFVxMXN3ZnM2bHVIcFpEY1Z4b2YrcElQYlFG?=
 =?utf-8?B?WUJyckNjRVFpOENqTG1Gd1VYTlBKNWtyQk00NVhHWHArQXdSbmQwT0gzL2ov?=
 =?utf-8?B?eDd3VGZsd242M3IxVHh0cHp5SVJPbTgxeFFpeTljQVVTK1JkODdjZzVRMzhQ?=
 =?utf-8?B?bW5yMFVDT2cyWnlLQzdtK2ZPRk1EUHZFM3FVSDFtVjVvNW1BUFFTcHNhclk3?=
 =?utf-8?B?ekpEM21WL2RpRTQvZzd1QW5yUG9nakNCYmpodHpyTWs3N21vRnUrd1pzMWxx?=
 =?utf-8?B?SXJXbytYWjk2V0lPRVZaVFppQTZYYTdLSEcyYWlQWGI3TTM4amV1ZmRoUjZK?=
 =?utf-8?B?M20xbXlzWDlRVjJJV1BSRjlmUHlubzZ3ZFBSdHBzcnhuV0xYTG1wam9JOWhr?=
 =?utf-8?B?Z1pXTFNubkhGMVZ4bE1hemxsMEdUWTVBNDE0bmd5QXZtQmVJRDE4M0YwU0Nt?=
 =?utf-8?B?a3VBZGE4QnJVM3g1U0NrMExheEQ4cVg3Nlk5OFJiWXlnOTJ4R3hXcE1oS0NX?=
 =?utf-8?B?SWNhVmtzdmh6QWNzazdKQUYwZHpnYjNMWlhoZDBDR1hZTGJsNDZOelFjR2th?=
 =?utf-8?B?VW9ITnVoM2U5dnIzZUcwZk81RHRDQTgyYXJUbnhxSmJkN1FTYWpGR0FoMUZI?=
 =?utf-8?B?UVFiaW9kZXNmM1BlTXZWVnVDZ29uU1VYQ3NUWk5GRHBpTjZxK3FRU1Z2OFJY?=
 =?utf-8?B?OVVtc3JYUHkzb05WQjBxN3lDbE9kYjRtV3A1WG9sUGsvUTZLOVdkd3BMVmpr?=
 =?utf-8?B?SnE4ZDRaL2NRMWZ1V21qSnVxdk9zTGZPTXNXZWtXUkpwbmdRaGQ3YmJDajlS?=
 =?utf-8?B?WDNrT2s3RVY4dUFQbkFySG40d3poOTBOQzFhTFlPQlFKejFmR2t3Vy9SeFpY?=
 =?utf-8?B?OEpNcmYxbUFtVU5Oa3NpR1o5VmFsdU9lNUtHOGJJWXN0MjZHTUc5STJDL0RN?=
 =?utf-8?B?anJtVkN3RFJxUnFvcUdYbHZZQ2RSM2djR1NnY0Rla3gvTzYwQ2tWcS9RUit4?=
 =?utf-8?B?VllHSGx2WHROSjA5dnFMTVNEYktSTHIzK0dwbHhTYTNGbGJ4SGhsKzU0Zzky?=
 =?utf-8?B?YXJjU0hVdUhXTGNSZVAzNGJ0d0RWZEdWd1IzNU1ldVJZTitzellmME1MZita?=
 =?utf-8?Q?GdkI+yrwqAp3CsOI=3D?=
X-Exchange-RoutingPolicyChecked: SUZNFZHBfTABkM0/6fElk7LcWjKQsVt+i/cKdLJq3uH+TNsMNKc0jo844aW6GRHla98lkSDX6rMx7Z2kY/21NXBu8PMwxCvUTbvyWOhQXdMpfs5s3kJ14YLTooAYrWZ9EGatbyfTfM6BT3BfuETEhSe0OcSYgWZWQsnU8VuA+HroVdNHMvxpJw89EWVqvFrgv2aFVjiZg7YGxfgkxzwNOOKsTPdBEqgAwsE0tpQ090KdkHi7EK5hbumck/HIdL17Anfa32FD+lyPaQe14LOadrQmJ2DWJ/ufCZN3zJzrDZxd7ttbDap6ubslBJTPkQyahBJFny4MgjwbHqH5gB1sYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 116e58e2-50f3-4c97-a585-08df2dfcb4b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:19:09.8156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GZR6JwKSvSak+Zp1Xog4jv5pmwvK+N9CDg4vK8Th1ZiNP/4bYIxDNNW+9++5HBwDcbGSSHisbMts+qWk5nBhNVQaieF2UgRT3Jztz+RArU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com

Hi Babu,

On 10/16/26 8:27 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 10/15/2026 9:40 AM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>> The resctrl subsystem tracks kernel mode configuration. Architectures need
>>
>> resctrl tracks nothing at this point. This is preparatory work to enable resctrl
>> to do so.
> 
> Yes. That is correct. Hope this looks ok.
> 
> Architectures may support different kernel modes that need to be
> exposed to resctrl.

nit: "need to be exposed to user space via resctrl filesystem."?

> 
> Add resctrl_set_kmode_support() to allow an architecture to register
> its supported kernel modes. This is preparatory infrastructure for
> future kernel mode support in resctrl.
> 

Looks good, thank you.

Reinette

 

