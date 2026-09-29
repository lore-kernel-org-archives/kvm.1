Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C85187CF;
	Tue, 29 Sep 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677959; cv=fail; b=dgjuX4nX63Wk9Ob5JHiK85M0rK9IIpJGOB+AGQFp3gN04/nexo4ksKMknfgTrPMoHBZ3+0VET2xfVhm29EFYohN6HI648S5MYD1vVGRDUwFkOdEWcQC2POk0jNbjrffAMVnNhiIwSTrwK9GYHzBciQfbwZdbWEzKor9tBMvavag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677959; c=relaxed/simple;
	bh=m/7P9UQL/YMv4l8qkjCUN8fPI35bhSPSMFhaXhlrSak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uke4BU6rLxVEeKMYouPNlWfzWlPByXWfjEYm6cgKtUsamg9NLl917E7UxGFCPMxofTkqq6K2DWQ4r6tgcFnKfbQn5t3m/KKVMKdJTqmWG0MRPB+WkxCiyYZMySnKLh7+ELEmFKob2AgL1eOtvzwtN8ofT9VEFLdWmE8xloaVSio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+RddLJu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+RddLJu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790677955; x=1822213955;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m/7P9UQL/YMv4l8qkjCUN8fPI35bhSPSMFhaXhlrSak=;
  b=C+RddLJuukg4SaOVrF8GahSES+4s4XCcg3fYXCqX61lqLcPK+1fYbXXC
   LTUyhRoFpVrJyWtTf0P2S0dlWj7FCF4NUdMvOc5NdlrRbnb+7tt7xJhlt
   NQkVjNOmtEowW0GHkFsznO0S7kuUj4EuRNeKwCs6xY0++y+62gjCE8Qbu
   J2Vt1GWXTezJUKAzNqSpSEGwzuiSS2AztUzGsPa8AwJBCwv5W/l6hVNZl
   TaEu2AP5FZCvTD7usgRtLmjry527ZnSITtjyc8NHoYt7wCQAKmIrydMof
   e9WVTmNqE+UucfMEGcRiPQuAYgPACxO1XznrowLMOHrF5excHWv/L1IfT
   A==;
X-CSE-ConnectionGUID: befIuGoDSGiZ6glZUGUnnQ==
X-CSE-MsgGUID: kYv4Lox8Tj6tOgHj16PwVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="93882537"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="93882537"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 03:32:33 -0700
X-CSE-ConnectionGUID: xbl3vh4rTBKzv7QEsmjDFA==
X-CSE-MsgGUID: oihLdyBrRLmMnTvCL5lrcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="280063457"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 03:32:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 03:32:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 03:32:32 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 03:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cchWlk/B79lbnqJMRgGTJ7TQBGam9/EkkHm6Ilmxbn+iYKrpjiHrNYyNtcsuZ6DJLDuFIbFVn0sPYPxatouEeheR3OhUu3unn9/nk6segyBeKGBkmLeQJu22zRobpWOdA68D40Vd0wm4Bej6O6iPB+7LcKjbc+2LRO8cgCeSlMzl6Y3rkLX8I4hd/7Efy6ibi4AxH+kVwT5peGpXaH6emcZ7TrfNIahYK5XbKEN/jR7UtwTfCyTYcdHPf16e/K8n1+vRlkct08aLWtoKFKf2NtVSh3j01SiFg/YFLHWZWrtz0dXF97mPdAEcqCy2wwGU9Ne/OX6XJBnbqKPS3e2cQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2AS1BtRc+CccEcTuAtka4vp6VtCnP3xc6jKAgf50uw=;
 b=UbzOAHsLoU09xklx/Nme07ZSThee2RkotcZ10DgUAWKEl474F6Zj+MI7W4KdnhoQcvHYxqkJNEJRFSdpoGOdjcVLU9M6e2J6QdrtB6aQ+DQzYc9TAtChx8zdUDLIfCLtaVHzZF48g+57/tM7egIRP5fyWjODBo7zEZH8QTyX3UYRkdC227q0F5R2AkGlXJ/J/hGfGxFYI3ceACZmHnagNJV+RD4ulvxb9/ow1dHhCo8ozjttMKMMmHFr3ZjJegKHGr3W5PZ0x6huZyfHPNW/Gub6T5dPdvTO1pe3Ynq4JAXaa5ZtzWH2PZ3PmZh+Q1+yIbt2K0WejgMhYVsSYmwr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by IA1PR11MB8199.namprd11.prod.outlook.com
 (2603:10b6:208:455::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 10:32:25 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 10:32:25 +0000
Date: Tue, 29 Sep 2026 03:32:23 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote
 buffer size
Message-ID: <aruTt9Y-AexP4NsI@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-5-peter.fang@intel.com>
 <0c6bc71f-53fb-4240-83a3-c52d090044d3@intel.com>
 <42975a72efc3a0f96200c065cb86970e8f452625.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <42975a72efc3a0f96200c065cb86970e8f452625.camel@intel.com>
X-ClientProxiedBy: SJ0PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:a03:333::10) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|IA1PR11MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcad5ed-ddef-47e3-d266-08df1e14f433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WSCZHSTUTkl91LWNxKgU4TVl39eXUCVYoGEsQccojaGYU6orvTxdO/65YgALXiqMqupv3SSiwa2Qp6zrPi6oXfTRrIMeknxtM7JlAx+nyWyaZjzRX4PKEXTRie6eW8ePR4VPZiAwshNJbAJrP13BTHn3ysbI3cNBvpXeIQCFIaHwXayROnMn1cjd6VMP7dIRp3jnl66q7pzhM6DqxckwoNIMcohJgJNqghQ//5a34R3DjGL7XVKIpXXp1gtJ7/21JTkyayhfnDqHT28olV+NDBGBDP+u/Ylm95EG8WgB6PZ2y90mX89aIzxK7gGwi6nTI5Tey1Ia9CsaGFdcXkMq/4CpPOf3hi0mWWy2SeJRQkLSCugW11Db1f0xS4HeO93NjAClD7gryzQggeV06INqTzF0k5IEw9PjbbwMLZhODtNHHn6gKyR3cW+gdEOJYQxGGSejetHNvVlASxWyBl1ZUiNVv4nOSw1SMxGQ2HVTXUPmjmrfH99U157cbW1ws89d9aJjIBinVJ8akfrojnjJHErQt08q6xQzKzFfBul7s7Es8ytYJMwC1a367AjOYecM1Vz5AQuEvpYjeFSN97XEIgwLU3rGgp4BGmNtnJWFnA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MItwOOqHFo5lGD7Xux2u6R4DjSl+SXsjtFXORNW0ZBZxV2zuVRQwQC23y7Lw?=
 =?us-ascii?Q?mBfF1UTlxAuYS44jMH+/CrDMjL+9cT49o8IL2jXZKu4qEF718Y/u6Whh8Mfn?=
 =?us-ascii?Q?jj6Axd9pe8HLfFOpYaIGB2MZaET1zN+KXsNNDpaqYe26bwHemEhBEbjh0npo?=
 =?us-ascii?Q?WH9/+BWvsmztLrOUrlPOR99v7Ydi0SRlOs2zUIFhLGXW3i+sV3fZgFROZKUs?=
 =?us-ascii?Q?msR5vocjcEhoCdEtNVeq+pbZq1aS8kGCBfkUnUGbqAe+q2ljdPevhQi30V9Y?=
 =?us-ascii?Q?SBmyzkQB/P3H4xLYxPh0kQJwmLUniDM9JgbF6j834uICNOcqsGaJCbhiz56+?=
 =?us-ascii?Q?CNRCg64fa0jjKbslufpfjbiQgPG94WYZ81K3TfUAX2jnbqhWxl6nZ3Hqouzl?=
 =?us-ascii?Q?DUH56sUkezHVP27AAXUdUh21/LL8pugXayituqzGmRuiEdlkDYq6UfM8VqHL?=
 =?us-ascii?Q?29W5VVIz6d7zch+EwpyRQo0x2O0+DhZ27vDJtCN3IfmAvrOi3vIap/rjhvbD?=
 =?us-ascii?Q?ZQu8r6myPxF5ccUktLWBMXSd9ql9MDANP24g4Dv0CVdJ0r9Is11IM2cb9OFi?=
 =?us-ascii?Q?Ua38c1k74BWdhoQO6BOqzaeMqMTq0jTOIbXZInELX5t2kN3mNMTf22p7s3bh?=
 =?us-ascii?Q?3Myg2pONYpmnN0yWMqEoT/RMBvuHzJUBFvXRghiS3mswc+MvH7WsE+OGVz5M?=
 =?us-ascii?Q?6ATUrsc1hjTm25foE1vQiYY4Z6ZKM08lP9nvYQhRvnFveysWd9cx5NH1CpKU?=
 =?us-ascii?Q?DJLKYdzej5xXdDMTvSVymKSpG7ZxDYATpHicb2N+40y5nvjO6wLnAjN7kwiW?=
 =?us-ascii?Q?P5FF9XSH9NycGaEV9p4n/JhT9L5PCdKhbd0I2bOnqS98MWaWZMHxKuE0qLkc?=
 =?us-ascii?Q?It7DrD5ycVUvqZZIWXv2+DNu7R6fxFJW9lAmC5MqG0+KM8TKutUlHqTb0GX8?=
 =?us-ascii?Q?qmFO49FK7a2FP5/wyxzbnBx/li/l3ogsL1KCgZZbYjGYFyxcoR3xZ3mz+f47?=
 =?us-ascii?Q?Y65v/QX2/2lXy7PGiGRiny06cMSlvDhv1ZhOAvC7/a9SsX23ZQwJr6LjEXGX?=
 =?us-ascii?Q?BD0fUowORsG+J6T+PFdGVzUmgvume/mcM9nzuI1t1nmQ98JKHgbSukD6CSkY?=
 =?us-ascii?Q?UuvhirTfBs6qylkQw3JgnX+oI2zTJBTz+vy0Ojg8urHAbwZJpG7sWnMcOfh1?=
 =?us-ascii?Q?YhCx4UBwhWvnaqx2EgGZJtpo2mhLaDST0/kJv9DhCX+TQRY2AYA6xjTTGeQ9?=
 =?us-ascii?Q?ZfH/Mcgh7KtMyjDv6jwQY16DOGUtKzeVXw8J8MOrP6V3M2mKv0j6kx5Eqml1?=
 =?us-ascii?Q?ja13vIakBMs1i3DY/BgdbtqH5fe3Ks2SUfhZ0ugdqePscn7aVzVFaPtrbgnB?=
 =?us-ascii?Q?lqnKCbkwIwhj5uPeTfgLTOGY+AxlPSh6HClRMg/30j8sjbFQHJG8YCd7XJ+A?=
 =?us-ascii?Q?icSeGil2ng7OJzusM8W/HEg1WBE5FWHjGrWZQeHjjpPo7Jbg5vbjWdmvFYwQ?=
 =?us-ascii?Q?AhxSsYXN+JzeZDRyOhSemoSfIkUfLSUYrlITA1FSgorKziumWtbsa2TQeDFf?=
 =?us-ascii?Q?s+kd6Kgm4Vz6RGSEXjrppA5QrwrQN0IrENDxHgCNOeIuFkHaqvFUuzpFWDD2?=
 =?us-ascii?Q?beP5g/8J9CtFz8xK29+lm+xSiY+QYcbfqPWXXzDoUfemv4JeUCCcWdjfpGb9?=
 =?us-ascii?Q?fWDzvsPY6xIqqrcJr1vQ5iQRB3kvvL3OE/xxfeMH9jAs2VGCdS5y49Y9DOhg?=
 =?us-ascii?Q?DfMSdNy5NA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Z0lMn9LBmf8euqS3Xhi/G9tGGXxLdWvbKORBEK5vW81vJURu30a/Eb3uQ7Lai5UfivJtSiKsDBqkkCyuVoIOAXCxT8M+mVimcmYQgqaqXVoLZPBG553hSJtA0KKzqK7Clsyz6B6XbG0p/NA5FS1JOfbiTCBKLjzVANfxH9VwTm7w/NGF/kjpElfUJr5H4tr3R7YLMdi/hy5x/sIW3kyxM4+AoQmDpKwybnI2zckM4XnuGzydTmN7xVyztFI4N2CGolkZ8CIN4LpxaBMLsfxHPLsfqhnwrND2FtSaw80JlSnrHQZCLwGHP/8ykEU5gv1rOU7dpPx5eZSv2zInHQlZlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcad5ed-ddef-47e3-d266-08df1e14f433
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:32:25.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZfUds4cpgaLAOyza9wDaSpsa28iMxLK/scFrBLKoXEPzWnzrFL1t2FO0kbu4UPFBqn+XUebhNCjIpqx7SRBgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 12:13:12PM -0700, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 09:13 -0700, Dave Hansen wrote:
> > Please explain the goal of this function. Why is it doing what it is
> > doing? This should also explain why it is page-aligning and caching things.
> 
> I'm not sure it actually needs to be. It shortens the math in the places where
> it needs to calculate the pages. And then in tdx_report_new_locked() it skips
> zeroing the whole buffer (not sure why to zero the buffer actually. Seems it

I talked to the TDX security folks and this seems to be a hygiene thing.
Skipping the zeroing shouldn't pose a security risk.

> could just zero the struct members, or maybe skip it).
> 
> But actually, this series has a little bit of a change there? Because after this
> helper is used, the whole page aligned buffer is zeroed regardless of the quote
> size being aligned. Today the compile time constant buffer size happens to be
> page aligned already though, so actually there is no change.

That's a good point. I took Xiaoyao's suggestion to just always align
[1], but maybe that was packing too much into one function.

[1] https://lore.kernel.org/all/e6121cf3-83eb-4cc8-919e-2557fbcab3c9@intel.com/

> 
> But still, a more limited change would have get_quote_buf_size() return the un-
> aligned size, like how the define is treated. Then leave the align logic alone
> in the callers. Another patch (not in this series) could change that and maybe
> make the memset() length in tdx_report_new_locked() make more sense. How about
> it?

Sounds good to me.

> 
> I guess it just seems like this patch preps for the dynamic changes, while only
> halfway addressing the align mysteries.
