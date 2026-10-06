Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8037269C;
	Tue,  6 Oct 2026 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308876; cv=fail; b=h9x3HEr/Bx9XRFQ8k5/MvI0Qlp8K14N+opJ4KuxTFLdmTRGlJTTyVulv0VOeJCjF7Vm6ALuzuWSxWBDBauvR9Jm8KqW0m6Q/ud5FSLSvgULhYfmM1W7Wf50+BCXZSgibH+7ZN612tqlOaA4UQkWKE+nzOE2mPgLl3R5FoE4oC60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308876; c=relaxed/simple;
	bh=TrE5YxL36yA9qjXFDvr6ge7u94jiqJK0J13k+wUpVwg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EMvyLQqDh+vibtfh0dfn/UHWN5gjeETRsElt0Oo6lFr47K7lHq8GRrLRLZ2OZhQfZeUWYLb7gTgHh+VlE8vtABubqQ3UcFa3OV21Gg9RGvpGRuBQMk96TInNryVERZOEJKYkEqfUq3A0fgOuzKRQIW3TMoIXVjo2hpFqkceiMBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9B3zSEh; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9B3zSEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791308872; x=1822844872;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TrE5YxL36yA9qjXFDvr6ge7u94jiqJK0J13k+wUpVwg=;
  b=P9B3zSEhW9LNPdWWqvsRAfgiyyByIjjUZx835oEcHAxDE6P76fLDPrKC
   3Ywp5pRSBUarUOB+DBgQl7xt+0O38C9yi5x6B1LgI6C4vU7lB7U8bBgJf
   W+TiO1MLQAYpLcLJrtqmKzEFR5dmskwm6Dc5pBPOJNjbCYJkcE0Yr1JDE
   EgR5bZS3l0X0hNQNpteGaIoM4CEJMkPkgURRAUb2tFwCCw1BKsdel6PYk
   TPJ+2Ha4IidnOWj6UEE0WL7L1LQPTFtjcHHksnYpYWzOTnAz14GKqixkf
   MnHZbtOctoFIaW97nod0l+RBDsavlngjcK75rshtiFM96Nf8aUUOSOz1z
   Q==;
X-CSE-ConnectionGUID: Bswu4OyOSQmiEUu6XM/fsA==
X-CSE-MsgGUID: QAsp+DzqQb+rsYKXhEanHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="102171229"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="102171229"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:47:50 -0700
X-CSE-ConnectionGUID: dkP7RP3HQcWWzn1K7Ih2Pg==
X-CSE-MsgGUID: AQ/CN+VMTt25XWPS2BTXtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="282006802"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:47:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:47:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 10:47:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICjbMxPI68BxyT8aGCvj7wUPjb8SWGMj4cBwLuVs4EqLuXPAHndlwLbNotCkdbNbQ7BkCWQcHnkHYQBtTNli5GTByzSdEqmcqk2nBFwbkFCWxKLuJcsNeiEvlQqTDCV4gBIUZRKCECLa5x/G7CYHkRS5dZnhH1bPMGdhQXm5HA6U+++YAz9ojKDXu33iqDqJJhiVhGsXTQJUHB/EiO8Cj1cRYergQd32svBs3U/LaJkf9uV0yWdlW7rIFdgtrgw+kw5c0iNHUMBsHdIePtEe2pHJEeFCNAABxqMyLGZhCntHGyE7m0KLPKh2IQUWgO8LoRjDqlFl9gNyDntxnKiS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n62hRN7zu6iYDrMx/itdm5A0K2vSZJAT/39D7s8BKI=;
 b=qib0VNfygg7Tmk7evlIY4glmtzmQ3EARmMNcHtOc5sJxDWllyvQV5DJryxLQbswaCYUrZR5LwLYfq9K8T0hYbxaH6t6N1AdYO+YrddAjHRLSd/Ktg2CqH7y1sns67gCZ74Rwao37WoVYscaigBtVPfwvETa8W9wfcQRAL7kDEcF68QFS87TOmnS78H7BlUZ9eqHPVzQQjz4zaAMpUvbHY+aNewJZwzoJ4vTj64u+jqGATDvwGNWpxRqHsizfOWAujkydtjH8AFP8AAaKRC4w73ieTcpGpklYowO4TD5+5zpW8aOMB+lEjhZBUIr/n1go90gIWMwHAYGLDJ42bMoU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20)
 by SA3PR11MB808482.namprd11.prod.outlook.com (2603:10b6:806:531::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 17:47:39 +0000
Received: from IA0PR11MB8379.namprd11.prod.outlook.com
 ([fe80::549f:e4b3:e10d:aaa6]) by IA0PR11MB8379.namprd11.prod.outlook.com
 ([fe80::549f:e4b3:e10d:aaa6%6]) with mapi id 15.21.0451.024; Tue, 6 Oct 2026
 17:47:39 +0000
Message-ID: <f4a82716-5107-4f39-8c9f-94374f188857@intel.com>
Date: Tue, 6 Oct 2026 10:47:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/resctrl: Fix ABMC counter programming
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1790976400.git.babu.moger@amd.com>
 <95bbc2e322ac18e2566c4963b7e6d13ac8485e20.1790976400.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <95bbc2e322ac18e2566c4963b7e6d13ac8485e20.1790976400.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0298.namprd04.prod.outlook.com
 (2603:10b6:303:89::33) To IA0PR11MB8379.namprd11.prod.outlook.com
 (2603:10b6:208:488::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8379:EE_|SA3PR11MB808482:EE_
X-MS-Office365-Filtering-Correlation-Id: 14639330-c5a9-4e89-248b-08df23d1e9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|22082099003|18002099003|4143699003|56012099006|6133799003|3023799007|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: xq1rvrFArymfu5nGdiY0HCgDCAJG22KmjZHgfsy3Xo8Qr7C4gtpoiB1sLTg0R19/dyFHksZZyHYQQ8ZhbXrEqPON5E9GTDNWX1fR96xScN80+dp0i+zUsivhebAJsUis0TmTPtjMEFYOc3r3eooYJ5D4is2sKyGQjMd1RMoQEJRVdkTx7Pjd3vR4kxctSl+SePoBaz6jyThFYY7ItSH3iFdci57Tl+fk+RPz+qvAIwHJfcXy61eNb+l5oVQ1FkOYBY55EzrHBsa21JcdEjUZN8yG4tMHsU1F/nki9O8CPQPO8IHPpEyfYFFrFZKh3M+NvILgzZIYXguh01B+VkZ25leXDFcTEAvZ1tQcDNdRPBcAzOe1O0xG+TGfe8bPhH74fmHggbbqHOSQKAdPtdloEXLreH5ZgrNmDOvZz5+WXO6/R6y2A0MTyeVXJJ0POGwknzASPOIC6UKImWLcdq42BDMgzGFl6rtrFzXt0qeM3ijDzXC5tPbhlbkpK9Ocxuse956oz7mNrU2e1PWKcM32+S+KqOeeyso17PHG+5gi4JNOPp/tqqW5vQP9T1aYraUbhK6gIVrCfpuLRigl73YUAsa9Okri6RwljziR390VxfdbsV6u17KsqYlNY+geUbxpRowg/Ri7q/9IfFY0+SmS1CsxoyoZgwrDtxSAURaucUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8379.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003)(3023799007)(10067099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZxMlhaMDF6YllTVlRpZW1rUEc2Sm5pZjM5V1JZdUNzOXpFUEpZNi9VdW9B?=
 =?utf-8?B?QkFHUjRBMWtudFJHb3ZLekVaTWQxam0reGl6V0FjM3VPVzR0WEh0dHV2dmZV?=
 =?utf-8?B?U0lwRmd0Wk1IVFg1d0N0TldZeHhyWUFHTitrUkd2eVZZc2R1SWJjcnhyUzd4?=
 =?utf-8?B?a3p5eHFzTGJNNUpGWC92R3RxNUsxRXN2Y0Rnck9LR1VWSzBFSTdZc0pQeFpt?=
 =?utf-8?B?VUNCV2I5cFVOdTFKU2pvZVdGeFhpR1k4VjNURWQ3WU1sQU1wcStNOUVjbTE3?=
 =?utf-8?B?UjQ3SnU1Ym1HaTlreERMSFlxTlprTm5lWXBsSC82V1RyOVZJU3dleExWSnFO?=
 =?utf-8?B?SVZvU0lGMnRVMnoya2JEYTBmZmFLdkwyQmdJUjRia1A2L1kvY0NibXd4dlJV?=
 =?utf-8?B?RUU1cjBERE5mM3ovL2tZZVV0eUNOSlJxc1c4SEpKN3dUVVZ4a2ZGYXBkME1B?=
 =?utf-8?B?K05sY3hXZ0toUkZhMUNleDlJbTBXa1RnQmc4Y3BlZ3RDYUh3b1ljNnBFS3Z6?=
 =?utf-8?B?TW92OUlJRlYzUFJ6dEYrVytJRmdrK2xuV1J0NGhRcmtMbUwwU05QSlkxalBU?=
 =?utf-8?B?OGlxcUJuWmRGYmREOFFrT2VSSzVBOTRGdjhDY0Q1cmxtTForaEp1RWlQeHdQ?=
 =?utf-8?B?eXZmNVRpNnYyUWZwNWcxRWdrQnl2eWVNc0JIMkVwN1lSR05qWW5FaEI5NUll?=
 =?utf-8?B?bkxoL3VFK0ZXYmJrcHY3RW56ZUlOU2ZZZXgzT3pqYkFNQlBuRlVOV2Ftbm55?=
 =?utf-8?B?TnpvS0ErQk5meHlXYll4cnVqcmNzdzRrbytrYkE0U3h4NnZQWHRrUjIrZEcv?=
 =?utf-8?B?WXRyV0Jrbnl3cDl3bjNUWHc5WVllRnYzTlVQa1ZmaG9QUktxTVZobXpHb05Q?=
 =?utf-8?B?NmVtek9WZXFDdHN5S2MzRVpHdkFCbmZnRHdyL1g5Zjc3WVl4TnJRbDhMTktV?=
 =?utf-8?B?UFRQdVdFRlVUMTZIL3kxWnQ0Ync0SXIrYXNhM3M5WUtDNXg1UFFWbFdNcmpK?=
 =?utf-8?B?bG90NjYvUThHb2xFd01aSXlvVXNhNHFuSERRWGFBVG43M01xSUtvMHpTMm50?=
 =?utf-8?B?Q3RwOFltL0Y4TUFCdjVHVy91Z3lIWUx4UklzN2djTm9la0htcy9xUzV2NkRo?=
 =?utf-8?B?eHRZOWxGbGc5QzNsZDJ2c3dsdlAzZGNhWmtJOHhvTWsraXhvUytYbVBNYm9C?=
 =?utf-8?B?RDNONlZSa0c4SjBtYTkvdmFoZUI4ck91K01qSnZJbFVmNUhnMUhKN013Nk1r?=
 =?utf-8?B?V2VBYlMwK2tVT2VEa1Z3UExRazdPVU5VZXkxSUVDemhVMmJxVXAwNTFyMkky?=
 =?utf-8?B?RG0wZ0s4TmxzZzVTbUpQNVZ4VWVzcm5COGJJbVlhNmp0NGNRSjk3MGp4TVAx?=
 =?utf-8?B?cTR1RWpqZ0xid1crWXZ3MGZGdTA3RlRtaEszN0l0WWl5eXRscGc4ZlZZeUdi?=
 =?utf-8?B?ckE4Q1BlVjZhUDkxZ0VGUG9HTHNGN1d3SWtsWTdrQm9ZYnJBLzRldnFxZWF6?=
 =?utf-8?B?MTA3bXBNNG9UNFE5QjNROFBpbjFHb1BSNVdNQUxKcXBoWVBlczBBc3dpblRk?=
 =?utf-8?B?cnErY2hCRUl2ZVV0K0VMV09KcjFQL0Q3T1ZsM3RLMkEzdCs0amNMQmcxbUdC?=
 =?utf-8?B?ak9UQlVESGNjRDNpZTBITWhiSThOU2hoR0lnT2EydkJxbXZyOENTR0dOZVRq?=
 =?utf-8?B?UjlVUzVhSE1STzhqdGxzSXZ0akVZS2toczFiVU44MzhDS1JWNXFPNXZ5WG9N?=
 =?utf-8?B?U2Q1ckx1eHJGaUlNK3hLWlVsYlVzTExEK3dvL2U5MnRFUGJIa2pYaEFwUENM?=
 =?utf-8?B?Y2szckhzNXoxMXIzU0xFSWJhMDRBQS8vaTFveWZ4WmZCeUZyUGpkVGJsWThU?=
 =?utf-8?B?VWZ5NXlvbW9Tdk5JR1FQcGo4WVB1RzBwZWNRb0lScGZ2cGsvYnlWcW5LejFp?=
 =?utf-8?B?bDhsVERoaU8rbVcrak4ybHAyRlFRZW5qck5xc0doN29Rb0d6VjZmeDVsdHBm?=
 =?utf-8?B?NzhibFFuWnF4eWNkYzl4MDVuVnZnWm4wMzN3TjhhWHVGOFR3b3lJT1lxN29I?=
 =?utf-8?B?NW9qOE5rL2Z0K21QdVk0TzhTOERiY2oyd3VUQlJoWlhidStKNTJEMEdCZ2tS?=
 =?utf-8?B?TnZVOW5IcWtqZVI0RG00Z0U5SHdqVFlqTGNXQWxGSzRDak83R1NCU3VzZkcv?=
 =?utf-8?B?MG0wVVNHMmR5UlZzWWd4U0F5cjFLeFdsYWpmQWl0LzVXb01EaXM1a0xYRWFW?=
 =?utf-8?B?ZGdVTjNhZGtrOE1yWERqRzBqT1VyVGdKQUNFYnBSVG9ybysrUkxMS3F6QVZG?=
 =?utf-8?B?QjFIblN0RnQzWFFiWCthTXpxeW1sV2FtTHJFK1RXTDM4UWtXWThRTGxpcVdx?=
 =?utf-8?Q?DX4U9HbssccFkR3g=3D?=
X-Exchange-RoutingPolicyChecked: e+cNgRDIPv1cK28e0NOZ8XO2DHUGJHcQuA5/ox6q7B4Vnzo83vtgALJ+WHV4HWWPOUjqWiCyg+Vr9c8qY8m/jj4N/LcQzs5HAqSwJglEkajBX2AINcJsTdYACkufwDRmIyQtHlXSFwzKFctrMj7QBsbsfPEgU7098Fk5C6NOZ/N1vCvPy6jJOWVux6BvScyqjuTbYndVTwiefOQFlHpsTUVjgyURMUMf3/pI6NcCCIlwdtB3F7eo61KtIUGzPhDVk5EpZYvpC0YhbAAkI+Gki/zcmcUU9o6Zkc+paHixfxJQHtthwlDOLuEkVZ25hupnd9SCcfEMv13qWuqO++Vl7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14639330-c5a9-4e89-248b-08df23d1e9d4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8379.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 17:47:39.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEYmOEKjHyhBEZ0Am9TnVbyfGWP2mEyauNtH/KgwlnIsbpTn6nvr+/CpZ/1bXFyrVK8tY38UyDsugoBZ+S8iuaKsegUeaJaCTy/jx5q1LMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB808482
X-OriginatorOrg: intel.com

Hi Babu,

On 10/2/26 2:26 PM, Babu Moger wrote:
> AMD's Assignable Bandwidth Monitoring Counters (ABMC) are configured via
> MSR_IA32_L3_QOS_ABMC_CFG. The architecture [1] received an update that
> expands the counter ID field (l3_qos_abmc_cfg.split.cntr_id) from 5 to 12

This describes an architecture change as a code change (l3_qos_abmc_cfg)?

The subject also claims a "fix" but above establishes this just as an update because
of architecture change without making clear what the problem needing fixing is.
using the tip guidance when writing changelog will ensure that problem description
is always clear.

> bits.
> 

> Use the updated field width. The number of supported counters is enumerated

The second sentence of above paragraph seems out of place as it seems to add
in a bit of additional context as part of the rest of the paragraph that describes
the fix.

> separately. Mark this as a fix to the original ABMC support to avoid

Tag can speak for itself, just focus on describing the problem being fixed.

The problem and fix are fused together making it difficult to see what is being
fixed here. Placing problem in its own paragraph helps to make this clear.

> misconfigurations caused by truncating counter IDs on hardware that
> supports a large number of counters.
> 
> Also limit the number of supported counters to the maximum value that can
> be represented by the 12-bit cntr_id field if hardware reports more than
> 12 bits.

This is the actual fix though but is added as an afterthought?

> 
> The AMD64 Architecture Programmer's Manual [1], available at [2], will be
> updated in a future revision to document the expanded cntr_id field.


Consider an example changelog like below that aims to follow the x86 changelog
guidelines:

AMD's Assignable Bandwidth Monitoring Counters (ABMC) are configured via
MSR_IA32_L3_QOS_ABMC_CFG; MSR_IA32_L3_QOS_ABMC_CFG.cntr_id selects which counter
the configuration applies to. The number of counters a platform supports (the
number of possible values written to MSR_IA32_L3_QOS_ABMC_CFG.cntr_id) is
enumerated separately via CPUID.

On a platform that enumerates more than 32 counters, writing a counter ID
through the current 5-bit encoding truncates the ID and misprograms ABMC.

The AMD64 Architecture Programmer's Manual [1], available from [2], has been
updated to widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id from 5 bits to 12 bits (the
published revision 3.41 does not yet reflect this; a future revision will). The
CPUID enumeration reports the maximum counter ID in a 16-bit field and can
still report more counters than a 12-bit MSR_IA32_L3_QOS_ABMC_CFG.cntr_id
can address.

Widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id to 12 bits to match the architecture. Cap
the enumerated counter count at BIT(12) so every counter ID resctrl uses can be
written to MSR_IA32_L3_QOS_ABMC_CFG.cntr_id without truncation.


> 
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
>     Publication #24593, Revision 3.41, Section 19.3.3.3 "Assignable
>     Bandwidth Monitoring (ABMC)"
> 
> Fixes: 84ecefb76674 ("x86/resctrl: Add data structures and definitions for ABMC assignment")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Cc: stable@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
> ---
Patch looks good to me.

Reinette

