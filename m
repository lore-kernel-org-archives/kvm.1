Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365154705C
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886396; cv=fail; b=JL6wQ7ftkaDPu8f8+z8+IscAHMH4yv9vNIOD2MqRymeTmC6AQQS4dK9NGBYmNIKRMJkY0C5FFBkdi7nQKy7BDmj9rwD4T/X7tLNDWpyCuNhMexCG7QSkcIG8AoXPpE3LkP5U8e0eCqlTNsLv4vy9owiKNWMbEJmyFh5m769q9xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886396; c=relaxed/simple;
	bh=1bWKHNNWNeyKdOEjABFH6Q8sjV7MIdFt+4CGW4tS8FY=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EyD7aeMVec6dk1ZQe/IzaxjZkExDcCGfow0V2U1T4KcIXMEmRQuN23Np6JGR6utfpJH9jpN/AMX6AX9YJtYH4Y0R+3gDbNcO5w9nbX/opgg2IKJg16O+D0KpoouBYGnyqH/Mbs15x/c8Rha5qVd5kS9PiqFaQMqrq00FlVeqkwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yc77TsfD; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yc77TsfD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886393; x=1822422393;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1bWKHNNWNeyKdOEjABFH6Q8sjV7MIdFt+4CGW4tS8FY=;
  b=Yc77TsfDqy4UGYz9MFtA/5jbo98MfHR0rvtdELzcd4OFgiNim/C4si3W
   XNALkzVWkbQ4qqgzHxTs60W5SiZiRRA8RrMtHgvQ3+kue5HlN1kXcFpKB
   h6e0VqQCs0v43FimaLi1PgnEetzb+U831EH88vdg2+yhA9Wt6hDTzSs17
   csTsJfJ2tRJycPRo6qyoyE9LszeTzHg0wiNc7W7XO/pgeb33ZQtGOzuqw
   bI0Ds7fIeaYVNWF1R8KlpJk4L38oqpaYyBjkJVfLYWR3dPnWaOZGy//wI
   7yPCfN7LJRbMPAyVtFhcLOo5/mZvHtcExU7GW/8Yoti7AkhJjGoYXRh/7
   Q==;
X-CSE-ConnectionGUID: SUMnXockQleSzso+zlRx8Q==
X-CSE-MsgGUID: 8kQ0cFRJQSCPUv6FztsOAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102232096"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="102232096"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:26:33 -0700
X-CSE-ConnectionGUID: N4F2S3hNQ7WNEfqccg+1Og==
X-CSE-MsgGUID: /K0StoGfR4yUdH1V4GfFfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="280830750"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:26:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:26:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:26:32 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpfhJ+G3utgx2wqF2pJ6o7WMz00N/KX9U/7yciRymefG5M1R6WDzbh9a8D/YPJfModgqAJAEySKvgqniHZ8cMM2NMnX78zqRS3ylUI89Xb0tMeWTDYTsUs+TE4dCtyYSdvzlTd/LYgfgWauCDnptTOypuEANYQs43x7scoR49MisgNiGKACHk6OFgEnQYnkjFfHE9uU6mMXykDPimqcuy9tn8ITfigq346qaWgdW9Hr76xIqF+gycKUFQvhwEBagxeBOVOYlyCOv9yUWN/YywayNsIwGBUFiG6bG8RChYdHsJji7a72m8Ab6IEgChMinWpbYpwm68TH/7Y8sKRvrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF9ckeTgAsk/1hVAuIDyzT/g4wyYCEPd0kEs+smJbRc=;
 b=QHjHGNsPd96lHTWQXUQUBfv62s9XjpY0oUJlFuYzapTNVSfXPZLiXtrGFJkEDeeKBbEkOSUXKNspK9x9bKGqK6D7dQMKRZ5ow2IRfugCVFjVDcbB5CjHjaSzv2xrDK2qqbvH9H7r1p20DgIFYZqEpdhNCpJHwi42f0KZhVRDMf337qIL/ElpHJJgxXawW0aZX93kU6aoxAGsbTDCRcpZbh4rILjciv1p6P9lyNQbW8jHf3jIgooSU/GREwoIYP+m3brXMrk3E3kzJat5OuBHvZcS3NVKOsO0dUvrYxzlj3Dg/9XrUlpNFZQB8bgTT1AvQGrG+LI9neYoWuX7TCiFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Thu, 1 Oct 2026 20:26:28 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 20:26:26 +0000
Message-ID: <b2b947fc-d63f-48eb-bc8b-0bf2b3e8a496@intel.com>
Date: Thu, 1 Oct 2026 19:59:32 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 11/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-12-chang.seok.bae@intel.com>
 <20260930214736.1FC1E1F00899@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260930214736.1FC1E1F00899@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe700e1-9f0e-4da2-bee9-08df1ffa44cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|3023799007|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bdpdIhbBNedx7gqa11h6/96qrejJe1np/8XBnpJGH3aTGbyVpg5PZKX+qaBbzJWjZ2Q23L5WqWcKACCege9AY2mabW4+Lz0oU5j2S2HycK557tMqOqyg7N2geYpJ0N7XQpkeUzzcdLGMXIK4VONJKwreghT40wk3tNF96rQP2A6MJQ8WWs7XbgPpmc96tAKMSEr/hRw2kZp14pai90a9MBoMcqHls8trHs5O5YDPIotAF4VX9u+xj5csuBKrEGjnr5/AM6L2aJzGaZsjJhTIknKDdMzoAYfcMctMHB7H4adm0ZcaWPmABX6URBZuPzwRRmMfXTdeFN63gLBN1K0C0qBOHNpQenrVBP7qibk4KqtE5+zNqkzP+f/1ldnV9EPERq6f8AhY4HMJQizbJ1xluWT9Y9bACzYX5ZUOaPWhuqJTZF3iCcLNneBMfZP3POQRwr+UDeRs8gehYDW0AMraWljTOxFmGLHeTwwy5vkLQNWddSq8lj3s2cyXEvAciI59j17mlUCmNmIkwHKthyOXofDON5muWTMV3DO+z/JUgA1jecHeuLoZNLrq6uxOBnmWdl10MYIihc/C59qhXVn6qi0OArjNwX2v9EBk++16XpAFg/bFOpadOc3Kb5IHEE4khDwmBWFRdCsv7jR+oZn/lW0sQ3ySmIRoKcJYWqrJm3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3l3eFlrdHE3SFpramFvME9Za1U5cXNkazlNMWtJYVZnYlkvUkRabnQ1b1V2?=
 =?utf-8?B?S3BPNU9tMFM5RVlzTW5uWkFEVkExM3YrRFh3MWdkdCtwbENwdk9KVmJZVURM?=
 =?utf-8?B?Qjh6VUo3cnZCRVhjS0p5WkR1L1VLNWYxYVVqZ2lXQk51dFNJa1N1VHBId0l6?=
 =?utf-8?B?MXorb3VKaFFIanJheC8xcFpOK1dHSG0wQXY3dHdlUmR0ZkdURnVUdGhYZFBp?=
 =?utf-8?B?NnZ5aFNwVkVhK0p6RStaenpUcnFJYW9NRmtiZm1DcWdJSk0rVE5tNVBjalMv?=
 =?utf-8?B?SStlTjRzSjZ1VTMvZldMMEpXckFxM3QxZTRqeGdUUXo1OEphb3Y2aFJ4eEtj?=
 =?utf-8?B?SnNRWlR5M3ZYVVQvZ1JOSmF5eFZ0S3NPREpvLzNlS0grSEhVNUl5MFRMMDlq?=
 =?utf-8?B?SkdHVWtudlkvZk1QdFoxZjB1UVliS001WlpZYWYrNG5xNlMzcUQwWTdUdEVB?=
 =?utf-8?B?ODVjREl3a1U0MUpxRjR0ZTNBZzJFaHFONDMzWnVkSkw1b0VLTGRZYjRsVWJF?=
 =?utf-8?B?VXZackRhVVRRdE1YOUxyc1RPRVdOdGFYbW9DeU1HS2NJSDd6YllBQWVwanVK?=
 =?utf-8?B?L0lLU241VlRYM2J5bHNReFlhYXZYOWQ0eERuSG55ejZjQjVobjhRQmx1b2N0?=
 =?utf-8?B?bnBPL1YzRFJXanVveE1WZXMwczBFRVVVZkhWd3FjOGRtYWxUUng0cVl2ZUtE?=
 =?utf-8?B?THdBRzFheVB1U3VqaHZPUkJTemlVSnVaN0RqYTBVYUl0SkNCZTFjalFYZXhu?=
 =?utf-8?B?THhTQW4yNGlvVkZ1Z003QXEwTzdBaDhPRDZrRVBLbWxSNjYxdmZyeUFONlpt?=
 =?utf-8?B?NDk0NS9VZHcwQ25BRWNsR2o5VUE0Wm9TdTY0L3F1TjBrcVJrd2pUYlFrZm5p?=
 =?utf-8?B?Yk16c1lzN1YyenR1eHFvUGdVamRML1NnTTZGbWgwU28xL2p2Wkk2L0lSL01G?=
 =?utf-8?B?ajFzNEEyQk1tN05EeVdyL3pvcjlBWmlqR3hUNGQ1Y1p4ck9lekgwUG1DY0ZK?=
 =?utf-8?B?SlNBTm9GZVRuQXZSYzZPVzRBb0VIWGtQaURoWU9RYUIxOVp5SldGaHF0Rzho?=
 =?utf-8?B?cVBHOEx1NnNsTnN6U1FVTnVoYWZ2aUdVMElObkZMcDAyYk1Yd05nbyt1T0ZW?=
 =?utf-8?B?bDlNb3lUVW9WMnV6OWx0L3pCeFVXcDAzcTM3V0s5WFZzNzFxZmliTjlNWlFJ?=
 =?utf-8?B?Wkh3TU9SbWJyK212d3grcXlMVkRHaG4xY2F4ajBERk5SRzlHZ0lsZ01NMFZl?=
 =?utf-8?B?b1lHaUUwNjJXN3VaVjMwZDhGR1BiMmxKdXZDUW1BQWMra1lIV1N5UGo1MVdy?=
 =?utf-8?B?OXZiY1Y2cUFiYnlLNFhZaUJRNnUwU3BFN2J0UmNtdm5TblFsY1pCenhIMk9q?=
 =?utf-8?B?NVpYZXBHektsT09TcFdjM01IalJ1Q3VnSU9WMkFNaklnbGVzUml6NE1LYWN6?=
 =?utf-8?B?c0k1dnRkbFRxUzRmNWNIR2hvTHlLZFdUV1pMRE0rWlJiNzVhLy83ZlkrOU5t?=
 =?utf-8?B?RjVrQnVMUGF5ZjNZTnlQMW10UVA4czRmWWduODEwbUpZNVJlQ0ljVkpEcUQ4?=
 =?utf-8?B?VGp3MksvUWxSSjdnQkw1SnRqOVJGMFRCcmtLRlJabFVlbjE5dEVDUDNoT2dU?=
 =?utf-8?B?akcwQXFJNGNMVC95bjVoTGJnem5IRldIQm1Ia29CZVQrSDBNdUh4NlRoeFNp?=
 =?utf-8?B?b2ZaK3RJeURGeHVWeSs1SitCMFdWdE9QVGQzZnR4UGxaSGw1Sk5XOGIwSEk1?=
 =?utf-8?B?dlI0cDAwb1pMTjI0Qyt4MnhrTDRVaS9oMGJrcTBjdEM3ZFIyVFdFcWI3ZWVT?=
 =?utf-8?B?SE5LU3ViWWdZM1FlRytVVHJIVE41SnI4Ujhwck91MlZaMHU2Z2VQanJaaWJD?=
 =?utf-8?B?RTlVV1p6UklCRkl0dXYyYUp5ZWFKZDVPSjFuekRyYTBNN2hBa2NDcFhZT1hJ?=
 =?utf-8?B?SDBGVTA0MXdEQzVLYzIzVXFQQlY1U3ZuL0F5MUV0Tnl5Z204NWMwMDFsTHdX?=
 =?utf-8?B?Y283ZTFLanozaldEWS9TRlphUUtQSmhuMHNiWmJiUFo4VCtnK1VuUjVPTDNV?=
 =?utf-8?B?b1pFOGwvdWFCY2Z1TGd1YW5IeEF4SGE2MnhMSHpwNGdQeW94WC9CT1RpN2Yr?=
 =?utf-8?B?bFB6RFFJZEdjaDVOYTdTV042YlN5d1BBQVN0LzBmc2luV2EwdzFraHBlUHRn?=
 =?utf-8?B?Tjk4L1B3SlhDY0ltS2FiN2tZcGplNURaODNhWTdJTW90WjZmS1BEYnNjWG9P?=
 =?utf-8?B?WTJ0TmZDTmdwRC9XVXg5VTdOV0RKRjYzSHIyTS9Vc3JGSXE3K2dIbVpmREt5?=
 =?utf-8?B?dWFZcG1WWjZBSnJMblBpU0hPbHdQY0h6Q3c3U0piM2xQMW53K25IZz09?=
X-Exchange-RoutingPolicyChecked: c9O/Fmm7X/TZz+MgTsQPDmKapG5JP89ElNorpxHiAWJxcHuzil2TWz0l5Erbmjd88PyR1R7vStzbiA6r2E+X5il20i5+YjxgkgSpELSrbHN8UmxP9LNVjctuCLodhHcbcT0M34XcybAPbDwlzdIF5E32ZoIPx5nv90IuhpjOmzEypUhkv0gGK3lz9uly4Et665DW886a5IMgTQ4DXvQuOyDefCobj3T7hVO5Vo+p42hRfL/gAdd3dEyr0SHlTM2VGT7S1DLRwVAHQfbO8zfYGqXHU+8gOQqht90X4lsUMDL9d1DAXyArj+Aq7SDIhpX5oFVlZYdZQQ1wwLDyrUc/nA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe700e1-9f0e-4da2-bee9-08df1ffa44cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:26:26.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jG+3tz8reEATsaAr9YKi+J/Ng5Pp3r0dHmk44aW1kpi8X/Qk08qzH9Npr2Lv9XxlWmVEBWNvnMcc2Ix0To0aH2uPuuxzCoLWBU6yfMU2xdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

On 9/30/2026 2:47 PM, sashiko-bot@kernel.org wrote:
> 
> Should these string instructions (ins/outs) include the NoRex2 flag?
...
> Does pushf also need the NoRex2 flag ...
...
 > Since x87 FPU instructions do not support REX2 prefixes, should they
 > have the NoRex2 flag here to ensure they raise #UD?
...
 > Does hlt need the NoRex2 flag since it takes no operands?
...
>> @@ -5001,6 +5012,13 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
>>   		opcode = opcode_table[ctxt->b];
>>   	}
>>   
>> +	/*
>> +	 * Instructions marked with NoRex2 ignore a legacy REX prefix, but #UD
>> +	 * should be raised when prefixed with REX2.
>> +	 */
>> +	if (opcode.flags & NoRex2 && ctxt->rex_prefix == REX2_PREFIX)
>> +		opcode.flags = Undefined;
>> +
> 
> [Severity: High]
> Does evaluating opcode.flags & NoRex2 here occur too early?
> 
> Since this check precedes the while (ctxt->d & GroupMask) loop that
> expands opcode groups, will nested group instructions (like monitor,
> mwait, or vmcall) bypass this check and fail to raise #UD when given
> a REX2 prefix?

The byte following a REX2 prefix is interpreted as the opcode. The 
emulator then handles it as a legacy instruction, including raising #UD 
where required, rather than suppressing #UD merely because of being 
REX2-prefixed.

The flag intentionally marks the reserved opcode ranges defined by the 
specification:

   * Legacy map 0: rows 0x4*, 0x7*, 0xA*, 0xE*
   * Legacy map 1: rows 0x3*, 0x8*

This was also pointed out in the previouss discussion:
https://lore.kernel.org/kvm/6bdc1a64-0304-4845-a36c-5f309b0b40e0@intel.com/

Thanks,
Chang
