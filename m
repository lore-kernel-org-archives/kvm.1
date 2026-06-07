Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0484282F26;
	Sun,  7 Jun 2026 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780807127; cv=fail; b=u+lxrldQXomnBIN2ueEGghPsr84mO5CW9n0bUsGE6D51Upnhbdgd2+sptnX3g9Kwc/v2cJaCclb+BLaJ59m0+8fkRi8SmiCjBF4+MAyBl9KSgGEzx6AvnNQZVRBDEJtKF5JR62xTC3/zeJSGD980Me5OxPQkXyxriehx5mvL4RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780807127; c=relaxed/simple;
	bh=RmZyOUkOxOQgtUuqIp3Md5rof3PfNaKPvm3HxkDIMqA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GSxINFVsceyPELVI+fp4/ikPGWw04n/7PIcR8GtDGYi5s1f6j4P8CubLG8NvCHlmZBKIiZ4921wbzt21j9OccSGx68yd2wmyyrYAJGiJj2tQgYMMvi4pvS1JV5HfHr4iXQ4VZ+WMz7f/W6wG0fSw6zfmhYiUXFMtjNOKdt9zivo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W17m0rAu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W17m0rAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780807125; x=1812343125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RmZyOUkOxOQgtUuqIp3Md5rof3PfNaKPvm3HxkDIMqA=;
  b=W17m0rAugnHPuVPshrugdXk6nu95T+j683mh8EiO/FOOAKUjBX3AVwH+
   1fBlqLDLPrXLW5KNbpABLrd6lljhFMXhkOdjyMOT+cHjJzPODJQksq1Jf
   YacLB/GF2AvoA4Fm1AVybLGjcXczqgrEQh8GJ9NiJfwz8Yxgg0DYvfRTJ
   3ap2RhpeBUaLhZe77+rhr1E6WDeJnqW8y+ndYg0b1dPBHwK5Eb/RZu7O6
   Av3qk0NB1iCjHczkH/kUapabOoeUoG0pVXvqYOD3mlg5fOVxR7Ee7LRqM
   CYbUUweMjouo8H14ubuOW4+W+3FFc+mueJJSrqaX5xj6l/xgM2ITuxnf/
   g==;
X-CSE-ConnectionGUID: HjajI8VwSWysSUkQ22R2kw==
X-CSE-MsgGUID: TF5WdmT2STaMXM8l7XVGDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="92689261"
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="92689261"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 21:38:44 -0700
X-CSE-ConnectionGUID: +TvVXP31S0eJZwz8yhw3vg==
X-CSE-MsgGUID: oveko+5TQQCqBNvQ9IlTfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="244110695"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 21:38:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 6 Jun 2026 21:38:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 6 Jun 2026 21:38:43 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 6 Jun 2026 21:38:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y455nSfMmgWXxH4RGufuCqHoI+J8bGUWhbQu8Ox+JLBXKnc893rYcEnR3IjvoDqgQ3zE7+65lc4htPc82BJtY1ZoDwfweTGgAFyTZcB7tCWFtyITY5wNqKwBAGnIFDP4PxJANAZEA5wXJk4gfDwFvm0kLp1BICSbLewz0aUntU3Dd69sG5mQW5AM7Py0MYZlX/BZhdcGPyBhA5lvXiuqWbYYvCh0NAX6ZEnKzyMptHefPLfOyNNi3vCFiv9Bpyb4YvqtY0MHZ982UFGpxrmu7kpF5g1Oab+NoSYPr9VSVGZgUGyJiTJKIV0+yKNL9Yv9vUWMSCoZIhZKILS097mOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcuchCoQD3a+HQn9nvBPTSoG5HKGeANSrejvx0WvZrI=;
 b=q6+ri0TB3Wdf0AqkReTxfh/2m7yrFibD+aE9HLdDqVIwbfSzUKTzbvJc40PTcmmBES8D3SlAD30TU3T6x+WBRF9to6GuTJmKw4T9HEd/Nv15oFDdF/jLJgGv/VuG9/+Fi5Ew1Npc0qATLTo1Z3/XcDxn7T90i/ChRrxpBFjb0z6MaEZNIQQTUCqbG0LYWgudxr5HkG0W7hwi56lBzsOuoncgejnHmuqLkR7mEvCS0tZb9wzipyUY1jv+W1gLtj67R0HBZ8m0R4toJpzV8GLxgAtBBRtRIdDntt3SlM5SZ+YDg3Tq/PwpUVnrUXNZ2dNEze7dc4UdAj+d39ZWF+0U9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.11; Sun, 7 Jun 2026 04:38:35 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0092.007; Sun, 7 Jun 2026
 04:38:35 +0000
Message-ID: <f8b7aea2-228c-4e51-b79e-094da656f4c9@intel.com>
Date: Sat, 6 Jun 2026 21:38:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after
 basic TDX Module init
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-5-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20260522034128.3144354-5-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0241.namprd04.prod.outlook.com
 (2603:10b6:303:88::6) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 635e85b9-11fd-4a02-d3d0-08dec44ea323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|11063799006|5023799004|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: mvUFN9YQME+L0JYsz3BdQnXnrKeN2j5af4ThcPn0Mx7x3rcR6iINC85k2NCk+CTy9QlO/tKu80oaOnTDczYxr9zY67htjYdvmTNTBe7W2x8G6G1LkeB/sM0tUj5r2zxa6Rt7i27jBclyz3LXpd6y3zQWSnqacdPK9gca5+kmttIEBVkdYa+U6zpS0KG5K79gtvo/gwnSbQv8EPhSmMHHgOuEHu8U++aYnwE58/5o0fXAKKYWKt1OGA/z7IzfTgD3JJhmxneP5dJMWuDanL9qLHG3Z0N/LXX9g8XFSZ9BXsoXhzBWe0paapmYpo/LvfdTOlIRCdJAtvtPjiOVmxB9KzQbeAJVw8CAby9G8huVsNH0uafPxJgEqWVXu7v+r5ElIiwkY/zlJi6Kfl6qEI8yyJ78K1zNMBEc7XyBQBB3W56wlLeRXqPpiLkC0CJlVf70XSi1NVZ51Hd7RZZ8HN5rnKwf43aGmkfo8QARd0iz7ZqKr7sbw4RGOlqhgOvgs7VDUs8jsfdLzXdR5bHb6vhlaWp9ImsH6z86MoXIRa3Jk0EQ7HSKp6fCb2KP4ypxYy/FUo97dofYPrnQNmvDljbaka0JmUbRb/pJWPUxSb4ULIOoJoG/c0CCNViJHOWJoYFIr3WhIVAIasTWn1BkAFk0QYsJt+KV4C/5SAoObafZlFjssXy7+YQykNgg5oaVB0dZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(5023799004)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejk4T0x6TW5rV2RMaWFMd2l5WHN6a2hrQUJlRWwxc00yL0pTRU0vankveUtr?=
 =?utf-8?B?S3Q1RElMYWUzbyt5ZW9IUFd0L3ZlSkhiVnVDRUkybkJWSXpNQkEybURPT3Vi?=
 =?utf-8?B?UDhqVk9BdGVQY0xCVFUxbkl5YXBtRFdKQ3gya3poVzIreVNHOERkclkwOGF3?=
 =?utf-8?B?RHUrbXZOY3hkWXZiNVh1NXpJVHA4RC9zMERyZXVLanB5TFZsejRYdkZiTG1V?=
 =?utf-8?B?ZEcyOG5CdURlNlVaSG5pcWRlSVNpTXJucXVHWFc5RGNxN0VzaWJQU2lYclZh?=
 =?utf-8?B?Zi93UkV1SGhYOTFpQVZKOFJNWmhUTHo2bk5qTTFiQmVzdEZmMS95V0lWa0RE?=
 =?utf-8?B?TXdoVFViVDdpeld2OFRQcnl1eXJTSnlZd3hSMTBlU3IwMVFWdG1kaVZTSkZq?=
 =?utf-8?B?cGtSMDExL2VmTEpGM2M1Sk5UQmRXVlhXVk5QNllsR0RGVXpGMFRxUitXdnJw?=
 =?utf-8?B?c0cwY2VkUmFMR3E1cDZZNElLcTJlUUxCS2xYaVVSWVdqMG5ZRWprcmFIc2ZT?=
 =?utf-8?B?MkM1QU90K0JWQk9kZkpGQnpuTm9yVnBWck03dGs2VGNucmdRVy85MmVDUyt0?=
 =?utf-8?B?MDZ4b1c2OTlrL2dQTnZ6ZUZ1RzhRc0M2ZzdWUVpFaEVteEZTcHF3ZWZHNHJL?=
 =?utf-8?B?UmEzQnlrbUw1bVlFZ1Z5MkZPVHdhSTZDRmM3ODlTRkplUjQ0K3AwZjRzTU5E?=
 =?utf-8?B?TjBRYi83Rm8xaTJuY0pNb2VWeGgrVW9CTDFJbHZqL1NuS1I0QmwrcndqZW1X?=
 =?utf-8?B?cW9wYjExNmlzL2RwR1FXaUp0aUpZSEFubW9mKzFMbmF6dFIxbHIwNy9MTURh?=
 =?utf-8?B?L2R0RFFuRlUvcjZuL1lwVnBxa09JZjBZUEpjZHp4RzF3UHhjYWw2WVlESVR2?=
 =?utf-8?B?a2RuNTFPZkVBK1M4OGRTMGw5UWVsL2c3dVVxSWI0T25NTWxhMDhleVdVTXdr?=
 =?utf-8?B?YjJEM2I5SWVyQWhPQUdtNzN4eC95cU11SDlETUZNa2FqMkJwZmRKR0tpZ096?=
 =?utf-8?B?R0lmM0I4SVBiSUtMSDBuWEU2bGs3cGkrTFRPaVRJVzhtc2JaWEYwNi9yUDZJ?=
 =?utf-8?B?OFM3UEFoUXQ4cWc3ZGIzQ2M3Nzk1ZHFGTzlSbTFmSGtaN2ZqWkRGTVZxRkFJ?=
 =?utf-8?B?c3pVS2ZOazh4U3pTTS9Za2VLalhOc05UblRCUkQwRTVXRU1sUW9hYXlXa2lB?=
 =?utf-8?B?M1F0Tk1nU2xBOHFOYXFZak5VNTd4anBvTUxHNEZpS0l3VDRucG9RampnMXp0?=
 =?utf-8?B?cGxRbzV1OSs1aHRNQ0RCeE5Gc3VhY0tFTGJjVGM2dmdTYVJZKytHVkxGRjJK?=
 =?utf-8?B?aDllWmh6V1hwSVh4S3NvTlZWcG5TNXlWSEFnYnJNbVpabjNDYzRnVE1sMnJN?=
 =?utf-8?B?YkdWTmtHWlZKZlVjNExUbU1xVFFjaGs3YmhYdThxTGlpL0hSdkNHRVdRUEgy?=
 =?utf-8?B?bW4xeDZyU1RQMWlSbHVaMDVQOTN4WVFCUm56eDl1NVNBTHppQmZEaE1zQzRX?=
 =?utf-8?B?TXlTa09UYmFOd2F5ZU13SVZETkNwWFErK3pERnlhMUxzMnM1akhRM0xadk83?=
 =?utf-8?B?b09UTHNUM3JwR2xqT3YvZCtxdVhtalJzNndNTloyUlJUNWp6QjB2ZjF6K3Bx?=
 =?utf-8?B?MlVZZkRXaGtUa3p4VytRdjJkbWtUTC91TUxEa093Qk1KaHc5dVVzNW9LS01n?=
 =?utf-8?B?UjJpdkszTUpjbFNZOGRCS29hbmRVZWdQTC9ZZU1CMUV4aWFzQmhZMjNPcHhF?=
 =?utf-8?B?UXRnWHhYWnZSZnNlTnl1aDRnck1EYk9DNE85Ykt6MHZoemgwWW94SGpOU3pr?=
 =?utf-8?B?akV0ZUlsMHArclNHWmJLRmdwVElOVm82Mng1MndKVlJ2TnM4TmtrUjFXS043?=
 =?utf-8?B?am5tZTVEbDZoS3dQd0RRZlRRL1ZlVkJKT21EUm9BbWRHMVZjQlR3UFljRjk4?=
 =?utf-8?B?bWJtUDNJay93V1Nyb0lxQjFKQkgxaHA0OWN1NndrYVJuNkhKbjgra1cxN1ZJ?=
 =?utf-8?B?K0lEWjFWU0dxR3lQQjNtb2hSQlNEQllMaHBEVG1GbU8yWVdtc1J1aytGeEVw?=
 =?utf-8?B?cTkwWElUanlyMXNhYzkyQ0VmT25JZDNPOG03bFdvQWcyWW1mRXFaeGhWanVK?=
 =?utf-8?B?KzFwaEtNYmZvRktOSnZ4eGRGZmRvOFRXTjFlQlBjOWxpeDBOdXcvS2wrMUxt?=
 =?utf-8?B?SGh6d01sTHg1U3pPaFh2bGZQVDNGbWIxYWR6R2hxK0Q2RXdvNHJTKytMY0Zh?=
 =?utf-8?B?UFdIcnplZzZCeUphNmN1VlJSNlFuOGhOT0J3MzJPdWxwQVJGRkNXUzJvQzJy?=
 =?utf-8?B?MjYzWWhKQXJGWFpxdGZCUlJuZ1lhUG5WcnVWQVB5SWdNQWhXdGlHQT09?=
X-Exchange-RoutingPolicyChecked: jiMBHFBvVV08LEUNyHLS7URWKMqGIktrKNQkSEGWswt2LBznOmTpZ349EgUPDBjvlW0MH9QJZJ4ouCrResxIxm2aeNPbn9imjpvvPb+svWks3Ap5hQbBls+nlAvt4xSnmeTlq6kz9+vHepALPo/s+DE5OjRP/bAn2QhPzIwqH5Bisrqb/UnZHbQvanLzInYOlEjh23gVH6SpfkaytXWjsjTZ49bSaeJX9xQMelWhaza7aCHgS//Lo6f3JsRTTzpVsz6SgxuwRNxO7YaJMSo4W2tEcI8TPu8LyHgeOC9lQaxg3XGDva9cYXePrd480drX0YjzUGeqoWgKE3ElP3eAGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 635e85b9-11fd-4a02-d3d0-08dec44ea323
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 04:38:35.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dR2FcPYeblHSnmZh/K8GkMdPN94y9JbgF1b/K5/r3iz+sYbGbB/RLCKLZPfxerXzoVUqhdaGxDnP9X4frPrYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com

On 5/21/26 8:41 PM, Xu Yilun wrote:
> The detailed initialization flow for TDX Module Extensions has been
> fully implemented. Enable the flow after basic TDX Module
> initialization.
> 
> Theoretically, the Extensions doesn't need to be enabled right after
> basic TDX initialization. It could be enabled right before the first
> Extension SEAMCALL is issued. That would save or postpone memory usage.
> But it isn't worth the complexity, the needs for the Extensions are vast
> but the savings are little for a typical TDX capable system (about
> 0.001% of memory). So the Linux decision is to just enable it along with
> the basic TDX.
> 
> Note that the Extensions initialization flow will still not start if no
> add-on features require Extensions. The enabling of add-on features will
> be in later patches. Until then, the system hasn't consumed extra memory.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/virt/vmx/tdx/tdx.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index ff2b96c20d2b..dad5ec642723 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1180,7 +1180,7 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
>   	return 0;
>   }
>   
> -static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
> +static __init void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
>   {
>   	u64 *entries = page_to_virt(root);
>   	int i;
> @@ -1193,7 +1193,7 @@ static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
>   #define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
>   #define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
>   
> -static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
> +static __init u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
>   {
>   	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
>   	       FIELD_PREP(HPA_LIST_INFO_PFN, page_to_pfn(root)) |
> @@ -1201,7 +1201,7 @@ static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
>   }
>   
>   /* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
> -static int tdx_ext_init(void)
> +static __init int tdx_ext_init(void)
>   {
>   	struct tdx_module_args args = {};
>   	u64 r;
> @@ -1216,7 +1216,7 @@ static int tdx_ext_init(void)
>   	return 0;
>   }
>   
> -static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
> +static __init int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
>   {
>   	struct tdx_module_args args = {
>   		.rcx = to_hpa_list_info(root, nr_pages),
> @@ -1240,7 +1240,7 @@ static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
>   	return 0;
>   }
>   
> -static int tdx_ext_mem_setup(void)
> +static __init int tdx_ext_mem_setup(void)
>   {
>   	unsigned int nr_pages;
>   	struct page *page;
> @@ -1301,7 +1301,7 @@ static int tdx_ext_mem_setup(void)
>   	return ret;
>   }
>   
> -static int __maybe_unused init_tdx_ext(void)
> +static __init int init_tdx_ext(void)
>   {
>   	int ret;
>   
> @@ -1373,6 +1373,10 @@ static __init int init_tdx_module(void)
>   	if (ret)
>   		goto err_reset_pamts;
>   
> +	ret = init_tdx_ext();
> +	if (ret)
> +		goto err_reset_pamts;

Is it a reasonable policy to fail TDX bringup entirely upon failing
initialization of extensions (which are "add-on features")?

The handling of tdx_quote_init() in Patch 6 suggests a more
best-effort approach.

> +
>   	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
>   
>   out_put_tdxmem:

