Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4484C3563D4;
	Mon,  8 Jun 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943525; cv=fail; b=bLLgHlRM89fzlKTZJTcXmF/9bY+WdDBzfD4cgVG5ZZgSF3B3YAVaCHaKtUx5MofQae2uHsBqGaH7fugwJRWe8TwWaFeC9h3NZYvJVB1k0z/oPLLn34jR1SpHLXLjo382p257aoTMtIbJq1ECXHrJb6Nvge4OU0aLPmcBPlEnx2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943525; c=relaxed/simple;
	bh=DXakx+GpjvOzqFHZP6ajowfh0GEpQywed7mokrp2xio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jHbM7RKAde1CML6y24RgcQuwKeRxceOo4QrMlaiww+AuUlHWrgtJZGbLsaURxKC/h4W42cxGOyfq4xs+vvLgJgWRqd2J79V7kcqwkadWJTUVaMxOs0H0vNJAVLJFBr2wwjZi+5zRNU+ge3D726xMN65aG5iJU3TooqTgU5IBeeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c39uKZxN; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c39uKZxN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780943523; x=1812479523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DXakx+GpjvOzqFHZP6ajowfh0GEpQywed7mokrp2xio=;
  b=c39uKZxNuzEkqO124XdFnuLX5/LCKUNBNsvpSbbUCjptEB9X6HqW3/sp
   E9VGh/UeXPwqdHbCTsj26u8tr8P+1FTPWEbVVuyy3/K4Ya4QowHi2EIq/
   TT18eP8itp6Kceqcxi0NnG0lt6831B03mhOxAvDRsz8R4o+nHgzxVQiv4
   TqSS4vDIDDA/DcO+fEK/8CqH1UMR8HNPoWcrEpzr7Z7P9NFmpycOZNjMH
   F1RLXIdsirFT6x5sKNcX2VFDatnyFrFCdv9yxHYHmPUc8GdjRMh9fzioM
   /kAiZckHEBgTl0eMTGuZP6N07eBJdTyvNolcSEQlw6a8aqIpJ6xna7dTG
   A==;
X-CSE-ConnectionGUID: +qBtrkW+QW63BzR2cYQ9UA==
X-CSE-MsgGUID: v6aJ94a5RwqagG6+erBF9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81668180"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81668180"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 11:32:03 -0700
X-CSE-ConnectionGUID: F6yiHyJ0SoiArawHXPQg2A==
X-CSE-MsgGUID: 4MruYHC+SOOU+BMabw3luA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="241188781"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 11:32:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 11:32:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 11:32:02 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 11:32:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfQqkqKDN+nKseoAHvFZUJM85r5pBVi0k6TWr5rZr8AhtYx0d87k6GOjx/n7BuCAuj+99lzNIf4WD7er9/C2l495lnseZtZIrv8YyvCedJZZWNCQbBSIc+uE/nwM7Fqv1IpqHg4SX5UC91x+cFy51TK/bdl+Z8qWZYTQoX0EZpqhuEUbP8OvGSgKY26jRwVANSXbvxNACPW0afndomclKbfuhcCHShI+oUq3OJn3yiE38Hvw3sfiCARu+J4r92WePoDE2w4QuBLJEParZBCJKBTFpKdEYrrqaVSSK9R+aHuRDO3HvgugNNFxZ9Dzbm8XM/SoNYg8XysL+7tCZ4lz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of2RqnWBKz8FPakJJhZj/8yrS/jiwC4KDkslUtrYmYY=;
 b=Qvl3vExHqvpu12y+awbiCu3YmESgjEX9ZeZ32wdJHMbIDA5k2KZTCfqzJ4HbNB9sajfamc7ZuxBuie4DJtCEubD8E6pwhh8+BYR9/ddGdmJRI72MU8QQmvQSIKeJ4HwmXeiaerEq9e/4Ud1fc2o8nT5Mq5H7ehPQynKIlFN8LyWULPNZLLyf8kLk52B7LTyR0VqT68qevDdgUWJ+CcQ5JjZ107hqO7wbHJQ2z2T2XOYJEC2GaGdxN0Uv/2xenFh382N4xx79SumxzOyAs3WA93rf74mP6su7WJqN7KbKy5PtIRenUpiNscQ0eCyxvXV6f1/Do4FdLjKPg9u4Df+zYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA3PR11MB7462.namprd11.prod.outlook.com (2603:10b6:806:31d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 8 Jun 2026
 18:31:58 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 18:31:52 +0000
Message-ID: <af2063d5-3d00-4d1a-83b5-de709825759d@intel.com>
Date: Mon, 8 Jun 2026 21:31:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0298.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::33) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA3PR11MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 5441ef6f-2322-4a11-88f7-08dec58c3603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 5zLVVg4uo7GpBrpTgcOOSAjbUiw+qwpYuO1rdfPYwXw63m+oxHXay1Oye3JcnRnuHsgWeyS35ILtlS/XEFi1D1I99eHAficF5oCYrItLyDSs/XBE/Xe62so3QfQ1WGq66HdiKkoD03xCLo6cFAR0Pyia3nK/J04GG1uaiacYSOIqe6pywnP6yvJxbZJRRAuMHtMHrDVE4IieRACrMOIAvqw7oVZ8OtUqFUyMpXHUOWAqggeyCj7rL4F/i06glQJUDV0Uu7tQZHvuMcQRrKDPV/lwXfXUsEPShkqHB1NuZp60hTZkUVtsaeKMAYCOLyxHXjWnUAuqnRz2kaCJ9nfi/9Mq+iH8EQ0eXPsfreBo9JEkv9lBLtbDqPjizrC4rFw+s9BtKDCulGQK+ucteH2bJu2qdtjDeiyp5n1ljCqj4E8nQIsBFUWbT3I/VCwFP/g6NAUV7ZZxhVP4/eeC7JgH5iM5AkbnX+9JV1QxvetHkyNQWJ3ramboisTgMxoDAflPUvKeneD5osSvPvR5vNpktF4u4hRAYVzFMnlvL79+ejXEYQxbeodlNBAl52x8D3bNYkdTZKtmLj2eq5izWdKRdik5H0XLaWYFKljR3HwmKuRmKZXy6+QSdpBnAFqqFtz4FI1vlv9DlGJ47evWT8o6cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxMeUhabnl1cVZzZU5JS3FqR1l3SU9VZVgyUWJheXdjdGREdnlJZStTYXdm?=
 =?utf-8?B?MTM2VkdZOVFOMjhXSXpnSXhEKzQvZXFFY1JrbGgyYjNadC9XVkxvU2ZPQmVy?=
 =?utf-8?B?dUVNb2Y1QzNiMkxRd0gzTXpTNmc0Q09rSnVHUG9LdjhTYnUycFg2TFd3bEVN?=
 =?utf-8?B?a0g1YW95M0dqaXNKSU1mNXF5THpDWkk2Q0djRXlyUitzMFFpMnE2bzNiNnBV?=
 =?utf-8?B?Vm51ckNkb0s0MWk5TWJwTHB2VnhXM2NxVHVvT1NZemo5UVZmanR4TWNqT1E2?=
 =?utf-8?B?aCs5ZHBZUEJJREphaHZnallWTU1vZEh4R3p3bVR0N3RZWGlZaEFQNzNxZEVR?=
 =?utf-8?B?V3FDQVJHT1ViL1VzallKV1NJeEk3K3VjbXg0M21sRU9JMTVLRHg5VVlJc0p4?=
 =?utf-8?B?T1FpcFlEUml0MHU0TW5Nc1VubXR2aDY3T3NvdDNEZmNYLzd0OW9XR09BS2Y5?=
 =?utf-8?B?Z3llaXhKUkVGQkFyaHdXeG1IcFZsR3RDbkJJbjNQVVU3SjMwNTdPdkxRVkdO?=
 =?utf-8?B?UitxTm9JS2hSYTA0WnM3WVdLcm1RYUlTdmFVL2hjdGluRXJubVhocmlEZ1px?=
 =?utf-8?B?WE0wWE4zS0E2YTNmNUV5MVZ2YjcxSGo5VDJtUmFyVDRCRFF3OXRnTEZTU1Ez?=
 =?utf-8?B?bGQ4MlkrYko2TmxTeCsyVm5TYTh3UHp5U1dSRDh2b2dsM2RBTEpOYmUyajZY?=
 =?utf-8?B?RXYySzFSalFHU1hRRFdnNGFyaFMrVHdEdFpVaTlzQ254UE05WHpmNmJyWDA4?=
 =?utf-8?B?ZStPVXA1Y1ZxUDZZejQ0TWtnSUpyMVkwYjIrOGRvV2pRREFhYlA3dCtTeTAy?=
 =?utf-8?B?Umo5aGJhR2JhdmxYMkNxNUR2dDF5QWk5bmdzVnhvOXZ5OW8yNGg2YTRLNnJo?=
 =?utf-8?B?K2w2cTdyVlZsc3J5VUNWaVZId0xoNnNXYjM2S0hmRTFuM2hEeU5oZWdRajFW?=
 =?utf-8?B?RHJjcFZnamhmOFIyRk02UEpUTm1DLzVJb3NYU3dwazh2ZklNODFCdWxmTXE4?=
 =?utf-8?B?N3ZsZWFneUw2U0Zka0NQT2FqVUJ1RlBUZms5dGsxcXdtcGlTNmlaaVhnM1NI?=
 =?utf-8?B?K3NnOHBpL1p1VjJKL0k2TlVJamNOZ2tZZ2ZHTHRJcnU4ZTVWOW1PWUhvKy9H?=
 =?utf-8?B?elNnVzRNU2lTQ29lcEpMZFhQSUx2SzFrUnNlWjJrL0FQL3ovdmw0Z1VpdVJ1?=
 =?utf-8?B?cElxbklpTGF4cmVtaVVxQ0sxVkNiRGcyQW9JNk40TDNlYVJtdFRsZ29NVkJt?=
 =?utf-8?B?N2tyU0xtWk9DeW9uNmd2S2c2bkRiaXFiQWtybzVQSko1b1ZkbUxCTG1ERGNv?=
 =?utf-8?B?K0ZmTEkxSWJZdER2SUtSdDYvVVpKQzZQSzR1OUFleXUrL1lMQ28xY01SU01h?=
 =?utf-8?B?M1RSNm8wcnIzeEpKUStOQm9wTThYVlJYTkkySk5YZmJlWW1pZkoyMS91RS9D?=
 =?utf-8?B?S0QzejQyMGt4Ty9IUC81bTVMUk1TUlZLblc0VzNZUE9xL0dXZk56a0RWL3p2?=
 =?utf-8?B?TGwwZVVKR2xqZWFtOE1UMXhYMjZzRS82dFVGQlFsNmJJekxWVlZveEpXU0RK?=
 =?utf-8?B?QkdxUEx2MWd2LzJ6UTVxUXRBNHVSVXBlNUx0UlBwQ3BzVjFOS0U3VittMGRC?=
 =?utf-8?B?Kzd5cVA3WmV1S3JQcHRZYjBFRVNSLzVwNmxFYnR4YkRZbjBlL28yNlE1OXlu?=
 =?utf-8?B?SjI0cGVsLzYxY3pONHQyVjEycHFHU3FoKzRqODFDeHJOL2JYRGJtNXNuaWwx?=
 =?utf-8?B?R2FvNExjdS9VSnVaVWRjSDVmSEZhd2F2ZHNMUGVwSDFndlFOc2dPa3E3Njk0?=
 =?utf-8?B?bnI5LzM2NTJFZkZOOWVRdEE1SUpQMnBxSG12UE1oWUpueXZ6UTgwK01YRC9Y?=
 =?utf-8?B?RmgxUjdBQ3JiVXJVMzU5NmVmbkV1dmlXYnRoWVZuRkpidlhvNnI3dlVsR2Z1?=
 =?utf-8?B?ekw5Sk13RDI3NWZ6dUdzc012Yy9CVmtFOE0vOU1jejZpREwwVU14ZmdENVZG?=
 =?utf-8?B?di9QdlErSm5zekNLSTlHdFpXV2k0YmR6M3N5czZSVEtkcjBwYklGbmRsdXdu?=
 =?utf-8?B?dmxrYlFiY3FnNU9aU3NLUy9jQUlvMDBIRFF3Y0RVcHlFV0pON0RYUU82V0cy?=
 =?utf-8?B?L3JKZFYzSytCdzZWQlVvNmtVd2liaGNXRHJLOU1HOS8vU3RNKzFpSFk2NGJs?=
 =?utf-8?B?S1BPWDN5NzNaemdGa0pwSEFNcjVFWXZwdmlZY3VWT3dwUmpYOVdhejQ4a1ZE?=
 =?utf-8?B?TzJvS2kvSmdGMFYycFV0cTgrQlI1S0VaeU95UDRtRE9xOXFQT3pwdTNvRG9J?=
 =?utf-8?B?OUZaVENyQlBtcDMzUElER1IySmhyY05DT3JjWEMzdHQzTTNFWUU2N1Z6T0o4?=
 =?utf-8?Q?25aJsZ2EBV4C/x8M=3D?=
X-Exchange-RoutingPolicyChecked: guVUDbTQ4Mt+1FAYStkqV9x/S3RI94kmlpaSPSieaJboCiAbzXaf8aSGSKVDvp1mOnWygu4CMC/M29W+eXBROahaH/wkD/inXzSqfWrVytUAGPBvzGVeqs2a7XRkeHw0Ual9i4nU0wJXuW5QymAW/bnEVzI0IaZx9UUh64bBGGJzjO2GKbn4X7Ustb7SM0uYOAFABriSllEZ7OQK0wonZLrY1qP2GN5lkaBs2C0lyg9WPRZghHQOyaodyd1BxSxtG5YfGnhbyqsaj/52FZrfzHpxlAmnHrqIQ8KR74giXlgZFRi9eix8UJB+hgCNZrMQQDnU2cE4bjt/hAxe0umCcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5441ef6f-2322-4a11-88f7-08dec58c3603
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:31:52.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ROwurSXpVNzZT1csjX9sekZwZsJRFCwzzmoXB8xVF0IUtk+Wzd/MyTIrpVc6spnCeIYqkh3SxFpoOHrbBMgvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7462
X-OriginatorOrg: intel.com

On 22/05/2026 06:41, Xu Yilun wrote:
> This posting is just to collect initial review.
> 
> Sean, Paolo, Dave please feel free to ignore for now. Sean, especially
> the x86 KVM stuff is only here as an example for the init code, and not
> ready for review.
> 
> Kiryl and Dan, we are trying to get acks for the first 4 patches of the
> series so they can be serve as a settled base for all the other work
> that uses Extensions. Please review the first 4 patches and treat the
> later ones as an example for the Extensions initialization.
> 
> == Why it's being posted ==
> 
> The TDX Module is introducing a new concept called "TDX Module
> Extensions", and several upcoming features depend on them. The
> Extensions need some extra setup at TDX module init time, and the code
> to do this is expected to be somewhat generic.
> 
> We want to get the basics of this TDX module extensions piece sorted so
> that all of the extension-based work can build on it. This series
> includes those basics, and an example usage called DICE-based TDX
> Quoting. Only the first 4 patches are about initializing the TDX module
> Extensions. I'd like some review on them. The later DICE patches are
> just included to serve as a usage example for the TDX module extension
> code.
> 
> The first 4 patches will eventually need an ack by an x86 maintainer, so
> please review with that in mind.
> 
> == Overview ==
> 
> TDX Module introduces the "TDX Module Extensions" to support long
> running / hard-irq preemptible flows inside. This makes TDX Module
> capable of handling complex tasks through "Extension SEAMCALLs".

For me it would be easier to understand by starting higher level,
like:

"TDX Module Extensions enables optional but important TDX features
 - such as DICE-based attestation quoting, TDX Connect, and live
migration - that require substantially more processing time than
core TDX operations, and also additional memory."

Also I would find it helpful to clarify how "TDX Module Extensions"
enhances interruptibility for Extension SEAMCALLs compared with
regular SEAMCALLs, since "hard-irq preemptible flows" had me
initially thinking along the wrong lines.

> 
> TDX Module allows some add-on features to use the Extension. The first
> feature to use Extensions is DICE-based TDX Quoting [1]. DICE is an
> industry-standard, certificate-backed attestation framework that layers
> evidence through a chain of certificates.
> 
> This series adds infrastructure to enable the Extensions and then
> implement DICE-based TDX Quoting.
> 
> The Extensions consumes relatively large amount of memory (~50MB). So it
> is designed to be off by default. It must be enabled after basic TDX
> Module initialization and when add-on features require it. To enable
> the Extensions, host first adds extra memory to TDX Module via a
> SEAMCALL (TDH.EXT.MEM.ADD), then uses another SEAMCALL (TDH.EXT.INIT) to
> initialize Extensions, and then some add-on features, e.g. DICE, could
> use Extension SEAMCALLs for work. Note that host can never get the added
> memory back.
> 
> Theoretically, the Extensions doesn't need to be enabled right after
> basic TDX initialization. It could be enabled right before the first
> Extension SEAMCALL is issued. That would save or postpone memory usage.
> But it isn't worth the complexity, the needs for the Extensions are vast
> but the savings are little for a typical TDX capable system (about
> 0.001% of memory). So the Linux decision is to just enable it along with
> the basic TDX.
> 
> This series has 2 distinct parts:
> 
>   Patches  1-4:  TDX Module Extensions enabling
>   Patches  5-15: DICE-based TDX Quoting, primarily Peter's work.
> 
> == Some history ==
> 
> The TDX Module Extensions part was first posted along with TDX
> Connect [2]. Now this part is remarkably smaller because we've removed
> the generic tdx_page_array abstraction for HPA_LIST_INFO. TDX Module
> Extensions is the first user of HPA_LIST_INFO, and doesn't use it in a
> typical way (HPA_LIST_INFO can only hold at most 2MB memory). There
> isn't enough justification to make the abstraction in this series. A
> possible plan is to rebuild tdx_page_array iteratively when more use
> cases arise.
> 
> == Misc ==
> 
> This series is based on tip/x86/tdx [3], because we need a small
> being-merged patch [4] before our work.
> 
> 
> Link: https://cdrdv2.intel.com/v1/dl/getContent/874303 # [1]
> Link: https://lore.kernel.org/all/20260327160132.2946114-1-yilun.xu@linux.intel.com/ # [2]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/tdx # [3]
> Link: https://patch.msgid.link/20260402-fuller_tdx_kexec_support-v3-1-34438d7094bf@intel.com # [4]
> 
> 
> Peter Fang (10):
>   x86/virt/tdx: Move tdx_tdr_pa() up in the file
>   x86/virt/tdx: Initialize Quoting extension during bringup
>   x86/virt/tdx: Prepare Quote buffer during extension bringup
>   x86/virt/tdx: Add interface to check Quoting availability
>   x86/virt/tdx: Add interface to generate a Quote
>   x86/tdx: Move and rename Quote request structure
>   KVM: TDX: Factor out userspace return path from tdx_get_quote()
>   KVM: TDX: Add in-kernel Quote generation
>   KVM: TDX: Support event-notify interrupts only with userspace quoting
>   x86/virt/tdx: Enable TDX Quoting extension
> 
> Xu Yilun (5):
>   x86/virt/tdx: Read global metadata for TDX Module Extensions
>   x86/virt/tdx: Add extra memory to TDX Module for Extensions
>   x86/virt/tdx: Make TDX Module initialize Extensions
>   x86/virt/tdx: Enable the Extensions right after basic TDX Module init
>   x86/virt/tdx: Embed version info in SEAMCALL leaf function definitions
> 
>  Documentation/virt/kvm/api.rst              |   8 +-
>  arch/x86/include/asm/tdx.h                  |  34 ++
>  arch/x86/include/asm/tdx_global_metadata.h  |  11 +
>  arch/x86/kvm/vmx/tdx.h                      |   6 +
>  arch/x86/virt/vmx/tdx/tdx.h                 |  32 +-
>  arch/x86/kvm/vmx/tdx.c                      | 176 ++++++++-
>  arch/x86/virt/vmx/tdx/tdx.c                 | 387 +++++++++++++++++++-
>  arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  27 ++
>  drivers/virt/coco/tdx-guest/tdx-guest.c     |  25 +-
>  virt/kvm/kvm_main.c                         |   1 +
>  10 files changed, 655 insertions(+), 52 deletions(-)
> 
> 
> base-commit: 5209e5bfe5cab593476c3e7754e42c5e47ce36de

