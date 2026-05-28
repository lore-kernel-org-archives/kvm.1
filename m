Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA932D8767
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779932647; cv=fail; b=kf3/8DDmhl2mYTg4T3gsufHlXYCT4GDZHEIfrM6TDRYjUzXHA4pylnp1cmAISvr4eJy85js+n8dqW4ad0QQOn3OBIZ7TrR4xdI7GvOLj4ACp7J37/YgJ/4pY54IYeYUiyos9/WKFaONOr67x+7pQKYqS7JVm7YaFJ2HEeQzgqjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779932647; c=relaxed/simple;
	bh=W9Qkqff3xWONFmxCNH6iLHtpSlQbOMJqMT05OFPJqSg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OM2VY8qqIaeN3TmJeAmn44hvpBoJstpg25Q5R1JYIniYdPxbvG80aAfexD66OQaNO+vheAYg2MCfyIV18+zkOYPSEPdKVIOdhJGskU9sKjTL31hoAUX55e24UYOmgPZGy9RVkI6fVrWASUC249QLskbvVAKiICGeHgFvkQ0eib8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCEo8VSJ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCEo8VSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779932646; x=1811468646;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W9Qkqff3xWONFmxCNH6iLHtpSlQbOMJqMT05OFPJqSg=;
  b=KCEo8VSJeY8nKmx5ncYYBXN3qx3e6iECxwCZYlto4woEwLcCOg3CotVY
   OcfHWO3TDABR0HktkJj499Z8KVWBaiUaLF2fFhWFM7Jr8DU3SsDz6ARJl
   8LiwatDIeKpNBnVKOpSy5Z5uk5BEdUKqcCw6TP6CSmr/5IuCKXQLfXx2Y
   HVY/gyeixiSiJ3teG1Q39fcEZhflzUituljZbXtWM16EBp6QbzbzyYRBY
   cCTIr7tq/nWTifoP4T9RaFOgsAv9HCz87B8VzG/nyazVMrNG5tYyFpdOr
   HDBYvIMF9ND8JaWERjSfu5OVnOwKunto/IhbASRU9uS4Zcwy397gnAbjx
   Q==;
X-CSE-ConnectionGUID: gxyL9lRmRnqQ5BuW9/eyDg==
X-CSE-MsgGUID: eW2KzzKVTZq+LpecgxwjZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="79806583"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="79806583"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 18:44:05 -0700
X-CSE-ConnectionGUID: IMsdRU5qS+uLoWtJH4ph0g==
X-CSE-MsgGUID: imzc25ZKQ9W5UbvCCDRDcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247483049"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 18:44:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 18:43:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 18:43:58 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 18:43:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFAnviWNUMrQLrlMmYDODHrecEX3aTpaJWSMMnCeE+bEYBU6PuAA3rKHp/OXUPeBE0i00faFEBgsd8WxYGkNNQZO/lQw75udYx9955f79ikvkh4mCXfQp2j+Avgp/VL/NQPc87W45AoiB00oiGNyWcM1+u0hlp+Y658YGxBLaGGFSjBRdhoeh+TVCpbjWqffZ2lVRAfs5Mws/iwD05Pi51uqIvtAkuDe/VJ+c+p+7E3N9CL6GK76QpmXJ1gd1o43NP5ajEtim0JhIF/b+/W3wCUNQnaz2MgcTTVOdDFcw93vyb3L9e+6vBfB5o8Zb20wvFvhYr/Tl5DpwZtoP92NWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+fqBxNrYwObtq+HqX9WTKGwHfCgK3l09VqI1cG+KnQ=;
 b=NjP128+aLRDhfnhwGMoXNPuI5IDb0rR8s6A0ozwwRbwY2wbaE6H21Mcj0cnk/dbLeSem2WyeW6p7/8kcGZ1FGUXFVbnYAdT/+rsImpllstLNG74INqb5hchL8CsmgA6rPNOlMJiszu1TRwXTKGP0FOWydx350k25ItVAsC6qMdLe893crJT2ubPR4OwwgLqq8z/8EMT/lsfpAdxKsaI/FbIpZtjbtkbkCgpq2GuOzLu9Ohuezg5R+WX4dr4EoHnOoEEMUlUgf6FVGMV5uaGhu8lpYWi7l2H41iUpprq3lOBTHEZp5S2eCgogwPWzMWSbe9UadgJiYQuShl1wMnmuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 PH0PR11MB9750.namprd11.prod.outlook.com (2603:10b6:510:397::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Thu, 28 May 2026 01:43:54 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 01:43:54 +0000
Message-ID: <f85b5c7b-122b-4a0a-a4c6-60ba580d0753@intel.com>
Date: Thu, 28 May 2026 09:43:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 2/2] x86/vmx: (Re)Add a nVMX test to
 validate load/save of DEBUGCTL
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260527151232.4058615-1-seanjc@google.com>
 <20260527151232.4058615-3-seanjc@google.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20260527151232.4058615-3-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|PH0PR11MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 67059bed-d7e4-483c-addf-08debc5a93e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nNKO8hRTPuOtTYjSjxjJhXDv30B5K3GFogJ7TQyDP4A+lJ8I+KXAgcbDIJncCrSK/O6a1rTw4hl+FaEqaE8GLqbr9+H/d+sFOI6Ro3+oTOs9yWZalX/vW4llRrcpG4EwH1N3eJfuGYE6lBpj8fzqnMhwiik8LoV/hb+rNZL0bRmrKpGMkwUkFP0J/RTTkGNUAQO10kPKzrv7eYTsY8wh6hB//hcMPVRsIG0JjAEUnjYQcehyblUerZnQzaEvgXYsV+hWrpdQW7btSzkpoHaEyAhg8sMqNOY1eEBW4iLiNA0cO4Ai8m9d3z+3pNhpZRNRAgD3JQGTIBaeivut6rCVLpboW32yYoZm4vNDvuNM9y51G32nqiobniCGtFyqNGqj6pHz7p7l+qXq+KqfrNvlQHOM5OzXbL2T+htNA7RrkAzN50uVsYIn9VP95pmdpejIjeHO/s9l8aaO3SJyxFDs3g6u271N7KH7yAuAQRb7vuXwG+VEPsTHXLk+pO8oGgcSXwMN3GkstpiilwuvGliY75E6GwGJU5ZrzAIUovK2LcvVLfZ8w5y/sq9NVn+higMeu0Q8wx+UO3Yj0391oEY1rfv+ysNr2VeTRP5K+V0DC2WDj9UTTzY+VlUb6/jYTkNRqHJ2EZQT3WKKHtsFBZsW+q1adTxV7Zs3ICchVYtUVnHNOnEBCKyirpekefMPvh2x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnh0UGtJSEN3OEoySTNabUh0NDl0cGhnTVBORjVqV1NYVnBoRkhnRWo2ODNX?=
 =?utf-8?B?OEdZOEJ2dE4xQzd5dTIrcTNKZFJOb2FleUFGUjBkdUJqdVgyWDB5NnkrSG52?=
 =?utf-8?B?SDdCL3JhbVN5L2J0T3N0T3ZoQ0lsL1lvcFRacEZBckhZS1F0a3RDVi9raVpK?=
 =?utf-8?B?VkpUL0pjTmc0RWdxbGRqNSs4ZzJxNWZJY1JhWDROaWMvb3dmOFJWMStGajJS?=
 =?utf-8?B?KzFXdTdrRzRzR0RFNmk2SlZrL1pWVUhFY1JUbTRVeU5PVkJZZlBVVG56T3NW?=
 =?utf-8?B?U1llcmU0U2pGQjJNdWJ0cTFIU2NIS010dTZ4ZzBaOXo0TXljMithWUVoY0Nr?=
 =?utf-8?B?SkpJbUlXcW5VZzFxNTFSZVVubytpTWk1N0ZWV0hScHBybGMweWJFbFAySjQw?=
 =?utf-8?B?VUhydVdXZVhlUGlzaURBQmlvSzVIVThsMnFaRWZuYm9MTldRS2RSTFVLM1lp?=
 =?utf-8?B?MGJZSWluejN3ZnVQOUQwTVZhQlR3WmlVa0FWeTFqYlM4UkU0WXltYVN5ZnJN?=
 =?utf-8?B?cUhhRzV6eEtNcXN0NDBld25udUtOYXJaYy9KK0ZYTFBpMHRXY0U5aTQrRGV4?=
 =?utf-8?B?dXc3bmprUW1pZENxN0EzZGtEL1RyZmhHUWMzYzJ0VDJqcUNBbGpxd0ZSSTUw?=
 =?utf-8?B?d2NpdE5MRXdOQ2dOekV3SDg4NWVBUTVsSUlGUEZ1NkxlWlBpNnRJOWdHaEhh?=
 =?utf-8?B?b01yUjNQbDR1UHprbDhpUjJhM3A2QS9VcXlzYW4vdi84TUtDYXpoc2Q3KzBi?=
 =?utf-8?B?R1hOOW5TZ1AvQy9HQXF3M05KWWZmaTdrMWFIL2MvQnBnODVLdm1rL0Z4L2Qy?=
 =?utf-8?B?TzVxaGNSUGV6VFJsWlZmQjNIWDltcnNwc0VvL1dYUnMwRXVjaThsRVZyUDV3?=
 =?utf-8?B?T2NkV2dFbjFDU3NNWEJhY0w5ei81VzVhYjNxYzJHK1pTRGlsMzdjU282NE5Z?=
 =?utf-8?B?NWxKRWVsWmNUM1lOTWFGS2krMmpjdWdpR3Bybjd4WVJpc1d6OG44bFU0cCtv?=
 =?utf-8?B?VkN1QlhuajNvWTloVTFaS1A1YUhBTjlxQzhoVGpnM0VjWHVTeU5rNk8vUkJv?=
 =?utf-8?B?MEtVcTF1NXlzWWJoSFM3UnovOFdFS0RCKytkVnFUalAzazlpZHBVS0NPR1pQ?=
 =?utf-8?B?NFN1MjlyaE02OHJRdktCVlVqMG53S3JONHBwVk9SZ3lEU2ZUYjU3U1B2UitB?=
 =?utf-8?B?aVRCZHBDS0lwcVZDUjhqZjhydWNYRkMzMjRIK2FmWktJNFo2MWo0cWJhbGhN?=
 =?utf-8?B?Y0k4Vm1oNEFqdTdQcGZ5QVhlaFg3ZkdPM3JaSVZCWnpkRHltdVo4dGRKNXFl?=
 =?utf-8?B?YWhTcjM3cWxzWnZRSURleGtUYnRpNWErdkJYT3BNWDFyQmRFSUdXc2sxQkMv?=
 =?utf-8?B?d3pQOWZxSms3ZFpRU2YyNXpQSzlFNjMwUzVWcnpaV25DVndPZ0kzN3dyT1Ar?=
 =?utf-8?B?SklVd0VZcXpMK0JoWFQ3aU5uYnVEZVkvMytNMWUrSkhINkt3ZDJPTFJJODg4?=
 =?utf-8?B?ckxsNDVOV0sraXl2SU9LbE9GWlR5dkZleG0vQjdxSWhSZDNlQVVMVDZRQUtW?=
 =?utf-8?B?c2o5eERCMUtzU1czVWp4b2ZxMGxmRnh5WTNSZ0dlbDFLQWw3dGFkR0FoTlR0?=
 =?utf-8?B?WUtkWXhxTDNUelN1MnpOeUdzSDV4am9NU1NIYkdFaHdDWWF5SVRIb3BXL1dJ?=
 =?utf-8?B?b0FQdzV6SGpuS1hUNVdvWkM4MjdTeWNiRzg4R0dhQUZyRWZVTXNoQTZaTHRR?=
 =?utf-8?B?MldhTzJKUktGOVBjOWg5VUlTak4vZ1VmNW40dlQ4SzBtamlGQU1NaTNzT1lV?=
 =?utf-8?B?STk5WGtQdjlJaXB4KzJxNzR1RU9hNEZmTTduNkZSb2lma0ZVdXVWQWVkMzhW?=
 =?utf-8?B?UUVqTHhKWE9GQ0lNcHVLbFhKbnN4Q3BoNUNhZU9xMDVUck9nN2xPOXRzRkFR?=
 =?utf-8?B?cDBQUWFIcGxGTGg5dFhYOTBqNFNkdWNxM2d0OFo4QjcwNFhHMHJkYU9yWTdw?=
 =?utf-8?B?YmNGNXBxUjhKTW5JS0JreXRGdWlaTUx5OFZoMGYzSHhqd0FMZG5FYlBrNzc0?=
 =?utf-8?B?SGNvdGwyamcvbU9rWnhRUWlJZzVpL2h2dFRCTW9iVFdxNEkrSzY5NE5aNEdB?=
 =?utf-8?B?MUh2ZXBKMWtEMzNlU3RaWGZ3bENaOStBK3VpUkhrajFFOWw2emlHUEJkL2xQ?=
 =?utf-8?B?b3JwWm1UdWlZNVFDVENsdEJlTmtONTQ1SzUrbWVvWVdRNHlIZEwrTDFsL1FK?=
 =?utf-8?B?T3ljSW1qeHorR0FmQ0NnUVllT0dZNWpWcktibUxXVGZYMzdyVVhVMGovU3Vs?=
 =?utf-8?B?OExCc0lONDJPa1ZwSGlQM0o0L2p5eERudE9uMFZNbXlxT2FRbjNJdz09?=
X-Exchange-RoutingPolicyChecked: CmwPh2Ihy/rXTqi4aJr0HZOBzp2ACGt5koyB133FtqsZCk6x1YtjsPA5zdH3v4elD7WsGgReCAWGUjXAOsAGk6xiRcT+irgJYpkwAzd66KosB84h/G9cMIJkZL/m1iZMdE9hjy6LG/rQPlTm21DcxmEKqdtZp3rqyv+BnR/T9AHuI/tDvN0WU48//FhMm35uIbtMHDk/ZOOJ7EQqTkife2Xq8FFbX1hMfASsXE+KXV7Zuj4hRak2hnnKZFrtsDdbtNlHeZnGWBmr0TqLSSZLWprNjt53s+QGtDIvtCFYNj11BIcGNLWPYaOZHyz7BbQ7TetiwwWruin6YFlIbkI7GA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 67059bed-d7e4-483c-addf-08debc5a93e1
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:43:54.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrCJn4tkBUOzHds/b3B88maHDa4+43834RVkixIRExwgArtkldEacRD2o/0rR0wNn6FY7XVCrkxkjj2OIYc2oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9750
X-OriginatorOrg: intel.com



On 5/27/2026 11:12 PM, Sean Christopherson wrote:
> From: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> Add a nVMX test to verify that DEBUGCTL is/isn't loaded/saved on entry/exit
> as per vmcs12's controls.  Validate all combinations of legal values (only
> three bits are supported, i.e. there are only 8 unique combinations), for
> both the host and the guest, along with '0'.
> 
> Validate that:
> 
>  - DEBUGCTL is loaded from vmcs.GUEST_DEBUGCTL iff "Load debug controls"
>    is set, otherwise the guest should see the host's value.
>  - DEBUGCTL is saved to vmcs.GUEST_DEBUGCTL iff "Save debug controls" is
>    set, otherwise the VMCS should retain its previous value.
>  - DEBUGCTL is *always* zeroed on VM-Exit, irrespective of guest controls.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  lib/x86/msr.h   |   2 +
>  x86/vmx_tests.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 152 insertions(+)
> 
> diff --git a/lib/x86/msr.h b/lib/x86/msr.h
> index 7397809c..8b019f7e 100644
> --- a/lib/x86/msr.h
> +++ b/lib/x86/msr.h
> @@ -103,12 +103,14 @@
>  /* DEBUGCTLMSR bits (others vary by model): */
>  #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
>  #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
> +#define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)
>  #define DEBUGCTLMSR_TR			(1UL <<  6)
>  #define DEBUGCTLMSR_BTS			(1UL <<  7)
>  #define DEBUGCTLMSR_BTINT		(1UL <<  8)
>  #define DEBUGCTLMSR_BTS_OFF_OS		(1UL <<  9)
>  #define DEBUGCTLMSR_BTS_OFF_USR		(1UL << 10)
>  #define DEBUGCTLMSR_FREEZE_LBRS_ON_PMI	(1UL << 11)
> +#define DEBUGCTLMSR_RTM_DEBUG		(1UL << 15)
>  
>  #define MSR_LBR_NHM_FROM	0x00000680
>  #define MSR_LBR_NHM_TO		0x000006c0
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index e1f53fbe..f914924d 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -11774,6 +11774,155 @@ static void vmx_cet_test(void)
>  	test_set_guest_finished();
>  }
>  
> +static u64 vmx_debugctl_test_val;
> +
> +static void vmx_debugctl_test_guest(void)
> +{
> +	for (;;) {
> +		vmx_debugctl_test_val = rdmsr(MSR_IA32_DEBUGCTLMSR);
> +		vmcall();
> +
> +		wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_val);
> +		vmcall();
> +	}
> +}
> +
> +static void __run_vmx_debugctl_guest(void)
> +{
> +	u64 val;
> +
> +	enter_guest();
> +	skip_exit_vmcall();
> +
> +	/* Verify DEBUGCTL is unconditionally zeroed on VM-Exit. */
> +	val = rdmsr(MSR_IA32_DEBUGCTLMSR);
> +	if (val)
> +		report_fail("DEBUGCTL = 0x%lx (not zeroed on VM-Exit)", val);
> +}
> +
> +static u64 run_vmx_debugctl_guest(u64 msr_val, u64 vmcs_val, u64 write_val)
> +{
> +	u64 read_val;
> +
> +	wrmsr(MSR_IA32_DEBUGCTLMSR, msr_val);
> +	vmcs_write(GUEST_DEBUGCTL, vmcs_val);
> +
> +	__run_vmx_debugctl_guest();
> +	read_val = vmx_debugctl_test_val;
> +
> +	vmx_debugctl_test_val = write_val;
> +	__run_vmx_debugctl_guest();
> +
> +	return read_val;
> +}
> +
> +static void __vmx_debugctl_test(u64 host_val, u64 guest_val)
> +{
> +	u64 val, rand;
> +
> +	/* Validate VM-Entrywhen save/load debug controls are set */
> +	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
> +	vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
> +
> +	/* Verify guest DEBUGCTL is loaded/saved when the controls are set. */
> +	val = run_vmx_debugctl_guest(host_val, guest_val, 0);
> +	report(val == guest_val, "Load DEBUGCTL = 0x%lx, guest RDMSR = 0x%lx", guest_val, val);
> +	val = vmcs_read(GUEST_DEBUGCTL);
> +	report(!val, "Save DEBUGCTL = 0x0, guest WRMSR = 0x%lx", val);
> +
> +	/* Rerun the test with the guest values flipped. */
> +	val = run_vmx_debugctl_guest(host_val, 0, guest_val);
> +	report(!val, "Load DEBUGCTL = 0x0, guest RDMSR = 0x%lx", val);
> +	val = vmcs_read(GUEST_DEBUGCTL);
> +	report(val == guest_val, "Save DEBUGCTL = 0x0%lx, guest WRMSR = 0x%lx", val, guest_val);
                                                    ^
See an extra "0" here during my test :)

And as mentioned in another thread, it requires the "migratable=no" thing in "vmx" testcase to cover LBR bit on my Skylake test.

