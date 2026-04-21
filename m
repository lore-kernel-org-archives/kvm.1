Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B043DDDC6;
	Tue, 21 Apr 2026 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805072; cv=fail; b=l/bu/S/GTKZoLIoowmpki993lFuFlpaQk+WfeJEDBBr+JD/fATnx/ujpoD4QBr/rvA261O8pMRBFZzU8EgbR9S6yJDg47GE4vcjMGCvDZBoHM3p8/G/Jri0hWmh+bx4q8Mw9GaTC8jl8xRi7td93VnQ9Ik+mBCG140e0X9/1qDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805072; c=relaxed/simple;
	bh=dROoR6GiqzptkWA0xQ82nd5K0YwaeT3EeB4BAZyxgOo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e/+WxUeAS5OtHrxLxahEcZdGWoZDJNDpR9YVwmm/pXBZCZH+eZCLHBs0p5kA3nFF6NhDcGux5Ix0hSDi/o0a+yrwhlCxthRo1s53uLpHBhgnkqPZAo2fUkvNvdzjWbzYLeyjv1a1QukoCAwh5C3UB7KBcS94VDGH6NW83yaStbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FD5PlS3M; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FD5PlS3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776805071; x=1808341071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dROoR6GiqzptkWA0xQ82nd5K0YwaeT3EeB4BAZyxgOo=;
  b=FD5PlS3MrtkZFB+NeoyQ6A2cS9T7lRg6scQM5ZXoehyLYXXYQh5TOsT2
   aeun+bZMCrYxI23RMqDf9WX9WrLmK1fb2KJe1DO9x/O9AGHLEzp+LLvQr
   unJLyqh0elsEC4I/9oCEeN5lwJ1z0ShZ8rJDpEsqKuXhpC0d03XwxBHQ6
   tL89nO7y8UjK/3ESCTIy+pPPgsbZ8kHKeMzhAjeP670j8K+KviSJdefgG
   lcdcZ9HdzCDtIwrcHZOghM+WDjg5PDYA3LiOd3rSJqpNkhY0frmcmCXk4
   WYh/bJJDrnh8lrFJwpkyIjkTWvxJIZnvuhVnXN/S9BfmAiChoAwbil1XA
   A==;
X-CSE-ConnectionGUID: ibjgLgDLTlCu8huFkIrEWA==
X-CSE-MsgGUID: 6N7EhD7MQqCTOlfU/FSXKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77933293"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77933293"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 13:57:50 -0700
X-CSE-ConnectionGUID: wGIjMQseQiSGZq1SbTjNSQ==
X-CSE-MsgGUID: It4NvCSaRgGFNNiH4nl82A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232064814"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 13:57:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 13:57:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 13:57:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 13:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mnm19U5amKOphW/oL2H892hQhq3nksCQB9h5vJrQbUfCT4wji9FIJyNnmf5E+1CY+sAwe95vy6rJmJmc4xoPGpWGkAGYWJYmVZr8u/A70DIYH2tEhtxNr2VeGHlNfuWLPxj+OzseMwVpYlB+yPTMe63cbkzOvfxU8PvBRQbQefZ/8QXLytyL5ApWzVNZoLvA2nax1Gj1S1Q8QHfcYnz8xK6vKwiBRDUiRoT7jWdzg6wy5XUF43pUr6t768TYWHWxMasnvOqCnYKj/BM+gE5gZM/v5D4KjnzRKD7kERcVjpslhe2pAzK2Cjs51yq0b9XaXN3Q+Lrsvva7fcjCYbJesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JLmzOIytqrC4WoZfqa4yCPd6R/caIYOeZSmlXljak4=;
 b=eYMbOiBdk5dp0VTsoVtUp3Kaqdwx0p9LNQgamWoUocoUMs+niJipYuUZcD5op1I6/neGYG5a4d+e3BD2IPAdebI7kAqt5HB/NWCR8eHew0KY0bg/y6Yw1CchQpFMoflYGdFwV2p8eZsTruAPxhE5RmBJQpUsrWXEdy0QzqTcwuVnaynMqcD/mAyE3bZ/BLHshEXLMbrCXogbTPxn5Engvb/v3tCLdW9TcjmmKScGnHibeJux7srtVKlLYQDkBE4tqTdcBQmyxiZVcy5SvjNXCxxI2QgqrhCXeK0jEsGqjV+AJZJjTDWaHZEIT+fLWCMaSi/EzAejlmtWiFJvL7ybnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6571.namprd11.prod.outlook.com (2603:10b6:303:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 20:57:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 20:57:34 +0000
Message-ID: <c9e10de7-f5b1-4a38-be1f-f75bc1ae7780@intel.com>
Date: Tue, 21 Apr 2026 13:57:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Babu Moger <babu.moger@amd.com>, "Moger, Babu" <bmoger@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pmladek@suse.com"
	<pmladek@suse.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "elver@google.com" <elver@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "lirongqing@baidu.com"
	<lirongqing@baidu.com>, "safinaskar@gmail.com" <safinaskar@gmail.com>,
	"fvdl@google.com" <fvdl@google.com>, "seanjc@google.com" <seanjc@google.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"chang.seok.bae@intel.com" <chang.seok.bae@intel.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"eranian@google.com" <eranian@google.com>, "peternewman@google.com"
	<peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
 <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
 <71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com>
 <e624f652-f0a6-4926-a0ab-c4486d41eb6d@amd.com>
 <8d969f11-4a7f-4e36-b85a-c3ed714fc603@intel.com>
 <a46f4f2d-e3f1-454f-b94b-c54e14e45a69@amd.com>
 <0334ba64-71b3-40bd-8cce-9f0f119e7dc9@intel.com>
 <d693f797-65f6-46ed-bd49-beaeee2da858@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d693f797-65f6-46ed-bd49-beaeee2da858@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:303:16d::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: a7216ece-db64-4df6-e125-08de9fe89ca7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gVvhZPaJQ1vNJg7zGqWf1TUYf8zsq3mSfPF4iLE3OY0VbYIbCKmxY7DUyU+Cgwr7/gptd+Kp+Vb08pDUAOIFfNqlq6vRY1+3+1mq9yZuyGLRyaO+HWuUbim5cbqhnWxMSibOjg75IUcJjFB5DM1JGlqtGb4VpUs32aIjbZJo087VMsTC0cSLMQ3XftnM2vvL3exWk1u+1H8YNEVJKJSpLXImEK27si9VB0F/EGxgkJTfkKBozFBpIEM9OzVLfRA40I6xtnkZjb3s+lh8JEaTqFKlFf4NN67d5YczT0FdCndEn/DUbzXU6BsxasWN2+HL+TaWkoj2TErRxdYaYWjj5FNeOzJIo86YtJjFK1NYusCTDHdoQNNNqkscspcdsftfJygN+e13o5Tpewfr5hqfXh3ePbAG7HLACkm7huSEbDV5h1AwSIXvN2hNrcQciGvq5yzFDqbuk6d/YXvve+HINLRA2lEWRYKjcxxRqOU2MmyuDsQzPSFSKNdjZ40zazQuoCRu5VOJRQT+h0FKT04mAWDe4MIi4VDkPNv7j/9JuZv4SK0UkL2WWypstqkjmZnTvkyfNpbvRBqgj3tUb0D7pAuOUx8N7cSbLIu00ikzFaEgtz6yWMwmTx2S+IW34Z6xGRQBvjW6LwomnshiCSe21VsvVqJrfChDnzlbC+GdefZkrgfMzwBVlTJbHkVanHtuHh1jr00NURd8Ydc5OZllSeQcQaS6+wP9s7WlSFF9QYZQiBIDxq1/AXiyRmj3HeOWtIiJELKVsGJXoCDboqioDOC6WTyNkjkln9qEKZQ1YZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXNYTXo5WTJGSUxiSVY1MkZuK2tVRWdFN0ZsSTduQVRYSnpCMXpQZGIxTzBY?=
 =?utf-8?B?V1VsUTgvb3p2Y2lYSm1rZUxBSk4vL2Rrc2gzR3J0bm5YbVdxWVZjM2hJVlpl?=
 =?utf-8?B?UU1oM2l4NUdZOUVVQ28wak9UNktpTzBZRnVWWmdvTnlDbC95MHZIa01oSjdF?=
 =?utf-8?B?cytJanF1NHpqcG5Leml0TUdqMjQ0bTFWdTdTTVZSaWhuNWQ1dzFuNXpaTkNL?=
 =?utf-8?B?YXV3NjF4WHBqMm1UNUVLYUtndllENWhZN09VNXEveEx4eXVkcStLOGJML2tM?=
 =?utf-8?B?dDN1MmNPeHdUVkh2dFUxUEsyN21TRHJFK1NCWHJxSlFLUTRZaDZFVW4rendt?=
 =?utf-8?B?TlRjTDZwU2N0TE9yUWtrckpLREtITnJvZTJQYW1kRVZEQm1HSWtlMGFOUnlZ?=
 =?utf-8?B?bSsvM3lRb0Vhd2g4TzkwNkU4eWMyR25XOVZPYWtLaTI1YU0xVEFpR2xLeWlH?=
 =?utf-8?B?KzE1V3d2MGlqZUxrdTJlSHRuMkZNVmNHSDQvOGU4MENpOW1ZWVFTRnpBSVFL?=
 =?utf-8?B?SFR3akEvaXczRDV2aUlraE5IcmlWWWVqLzlFb0V0eFdHTFFnOTFtM0hZZnJJ?=
 =?utf-8?B?MVNKc0Z1d0pTYVpocWVadkgrcXlrcXVGN052ODdSUWExcUVXZ2xpekRnWEtr?=
 =?utf-8?B?RG9uZVdRTzdTRlFOVGtybGxkeWt0UmtaR2M3YWh2NzVNbzhOQ0tYZ3pDVkNN?=
 =?utf-8?B?b1pBRlVCWmJQdDhSZzFEUWV2VEZ2ajc2azhacWZZNFZhRXNCMEp4NU1yRG0x?=
 =?utf-8?B?c0Q5U05Jd0RFNndvck1FdXBUVGpQaEZ3c2ZLVE13YjFmeWVmcW5XUlNWaW9u?=
 =?utf-8?B?S0pyZlI0RVFYajdLVHozSnRITkU0SUlVNGhBRGIyOFNyRlFqUGVORGZ5djFS?=
 =?utf-8?B?TDg2QmFHcm5TYk5rUXBoZkpvYi9oUEFQYnFYRnZRR3NieHNFc1RHbjk2MDJY?=
 =?utf-8?B?QU1WcTB1WWN5ZmZRdUh6VFgxWVFpYzM4cmZodlVudlhlYzJxQWh3QjhLbUZV?=
 =?utf-8?B?WkYwUy8vQjNWUFZwK1BKVUlEVUdkR3pKcWxxMUlHWGlRQ0YycE9lbXZNL1VW?=
 =?utf-8?B?N0tOK1VoVkl0NUJOMGNNRVF0RGM0VmZielFyM0RSbmR0UTZ4N2FYNm5SS0FC?=
 =?utf-8?B?N1dXZjFTS2hpNkZSaUVvd3hMVjJwT2ZLN090bkxQQjZVdjZDdjN6ZytXRFBm?=
 =?utf-8?B?Si8ySzhoWVk3blVzZXJub0dpQjdIcXUrM2pRTjQ5UHk0OTJqTTJoQVlUbEZ1?=
 =?utf-8?B?bW12QktaZm5uSXNXbE5qdTNvMXcrczBVK1NKYjZwWXJTQ2JoT2tIMHZwVXRK?=
 =?utf-8?B?V244L3lLSmU1RnBMWjRRRkF4NWN3WHkyZkhiQjVlWCtNYVVUOWx0R005THo1?=
 =?utf-8?B?VEZ3Zi9ZaTc5U3RDSkE4R1lnVDQ5RU56N1VLeWs3NGk0dnJtb1BVN2paaVds?=
 =?utf-8?B?NVJzSUljc1A1cEVaUkc5Z2QrQ2lOU1VjSG1LNGkwQTUxbmpLS2NDK2dSd2RB?=
 =?utf-8?B?WHhJdkNRcTdZSUZDczJDc0M4UEd3UXM3VDEvVXM2aGVVbXV4VzV0b2FobThP?=
 =?utf-8?B?MmVmd1F3WWxjYzBLNGtCZlBpS3NHN2wxTkZPSmsxcWltRXZDL2ZHMFJvUjkr?=
 =?utf-8?B?VTBYV0ovelQySnpvQTQvN2hPZDJzZCt3aUJvbEQxNnNQbGZsKzlRVldWVzlU?=
 =?utf-8?B?NFVpSmdEbTVQQTVRWWliTkhiampZSEFrZUtjQWFEQUlRWXgvc0tiQXJnMlpr?=
 =?utf-8?B?ejVjSThCR2tMSnMyL0prbmlFRElYUTVmKzJMMUQzWS9ndnZQbURiS1pMNHpi?=
 =?utf-8?B?K1MrK09OTWt6NUpSd1BLRlorUnM2Q3A0aUtOMmhaa3VtRGRCWGdmU05zcTZx?=
 =?utf-8?B?R0JUTjYwZk1xb2JpMmpxYVo1NVFiOFV6d3loMU9vS0dNWHNqektNQ1huYUZE?=
 =?utf-8?B?WkN4YUdyZytuUFV0UFlLV3dHNmV3OTJqMS9CWXh4SUdEUmNuZlk3Z0k3a3lD?=
 =?utf-8?B?bitMWTZkR1FnQWFqalNtUmJpR3F1YWFxNmVJNnRzcXArYlBtdEkrc0FOdjBK?=
 =?utf-8?B?MXZmc0tUQ1djZzRjOXFrTHZCckc5M2cwMXppL2JQbENINi9iYXBXeENtQmNx?=
 =?utf-8?B?YWlpUkJqY21na3c0V1lCWHIxdlcyYTg3NWg3UkkwT3p3WHlrc1cxalN4UnFW?=
 =?utf-8?B?aWZ5THREZjdGejRSOUVkbENjY0ZHMHhTdTZzNUkzaGFOZmxnT1pkTEh6VURi?=
 =?utf-8?B?bFBlejRZcVRJZUcvaDhCMVgrMUVYeEJTT3JXNXJ0Z3Y3blNxWSthVHA4ZlJk?=
 =?utf-8?B?L25DQXRNV0wzdVh6dkZUc2Q1MlN4NExmV3YyRXJhamNzMFNFTTdZM3ZndVN4?=
 =?utf-8?Q?UuA5TI02JoNjAs6M=3D?=
X-Exchange-RoutingPolicyChecked: t9nat/NMibsmGxXjMI8VSXFziKBCR4KncgSVKG+dIz789EXhCcvULXvEDpcbjiQmQ8+/iqSCDWIRFIMzHiDpjeaWnmqe4UXKegJzzpRoKp8plTHwn4dz0eyZaw+2TXMy+sr/RCu70bGlcvoTQf8Zcn5px5eMRH/zaeVch728qxXk2uo078nQ0UwGAa9wapxmiQ/XBLRWxxEqhK6QLkPLINnyknBzyr589HvXg5AbMtdDGyNc/ep0jaLCy1AjH/wWi892kNKrRbaWuL0IBoEhjLLXhP3Gb8WRFd11fyaTCjeZN9pjwN+v7XgRjPAOc6bmQzd4w6FOeU014rDZPEaWOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7216ece-db64-4df6-e125-08de9fe89ca7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 20:57:34.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyqV4sL1j8v+Z1R2edDpNdRO9AntE0R8o1RwfX5xCut9nzdvWYQcQc2DshKSbLoulbU4/DLd5dTrlVRbIgak3mnaW7vazLkham4PqQlMoTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6571
X-OriginatorOrg: intel.com

Hi Babu,

On 4/21/26 11:19 AM, Babu Moger wrote:
> On 4/21/26 12:35, Reinette Chatre wrote:
>> On 4/21/26 9:46 AM, Babu Moger wrote:
>>> On 4/21/26 11:15, Reinette Chatre wrote:
>>>> On 4/21/26 8:08 AM, Babu Moger wrote:


>>>>>
>>>>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
>>>>>
>>>>> Why do we still need to keep the "inherit_ctrl_and_mon"?  By default all the groups in the system falls in this category it is not plza enabled group.

Here you question why "inherit_ctrl_and_mon" is needed ...

>>>>>
>>>>>
>>>>> System boots up with following options if PLZA is supported.
>>>>>
>>>>> # cat info/kernel_mode
>>>>>         global_assign_ctrl_assign_mon_per_cpu
>>>>>         global_assign_ctrl_inherit_mon_per_cpu
>>>>>
>>>>> No groups are associated with kernel mode at this point.
>>>>
>>>> To me it seems useful to be clear to user space on what the current mode is. If I understand correctly
>>>> above default scenario essentially means "inherit_ctrl_and_mon" but instead of adding it to this file
>>>> we will need to add documentation that describes to user space how this file should be interpreted.
>>>> It seems easier to me to just be clear via info/kernel_mode itself on what the current active mode is?
>>>>
>>>> I think something like below will be more intuitive and not need much additional
>>>> documentation to understand (I am just adding the "uninitialized" as an example to match text
>>>> printed in schemata file during pseudo-locking ... even if there is a group named "uninitialized"
>>>> the lack of "/" could be used to make it clear what this means?):
>>>>
>>>>      # cat info/kernel_mode
>>>>      [inherit_ctrl_and_mon]
>>>>      global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>>>>      global_assign_ctrl_inherit_mon_per_cpu:group=uninitialized
>>>>

Above I share considerations when thinking whether to keep "inherit_ctrl_and_mon" or not ...

>>>
>>> Sounds ok to me.

... to which you seem to agree ...

>>>
>>>
>>>> I also think an interface like this would be simpler for user space to use as it (user space) switches
>>>> between PLZA capable and non-PLZA capable systems since user space need not associate existence of
>>>> the file with some kernel mode state in addition to actual content of the file when it does exist.


... more considerations from me when thinking whether to keep "inherit_ctrl_and_mon" or not ...

>>>>
>>>> I assumed that info/kernel_mode can just always be made visible and not depend on PLZA
>>>> capable hardware. This means that on Intel and Arm this file can show:
>>>>
>>>>      # cat info/kernel_mode
>>>>      [inherit_ctrl_and_mon]
>>>>
>>>
>>> Yes. Sure.

... to which you seem to agree ...

>>>
>>>
>>>> For Intel this is accurate and also for Arm if I interpret the Arm implementation correctly
>>>> (see mpam_thread_switch()) in  https://lore.kernel.org/lkml/20260313144617.3420416-7-ben.horgan@arm.com/

... and even more considerations from me when thinking whether to keep "inherit_ctrl_and_mon" or not.

...

>>> There is one problem here. The mode "inherit_ctrl_and_mon" listing not consistent with others.
>>
>> It is difficult to predict what resctrl will be asked to support next. One possibility here is
>> to make it part of the original design that the first field is the "mode" and the following field
>> contains that mode's global properties of which there could be more than one. Above shows that
>> the two "global" modes have a single global property but we could just try to be safe with some
>> documentation that states there could be more.
>>
>> Consider for example some hypothetical future where the file looks like:
>>
>>     # cat info/kernel_mode
>>     inherit_ctrl_and_mon:some_unique_capability=true
>>     global_assign_ctrl_assign_mon_per_cpu:group=uninitialized;other_property=val
>>     [global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]
>>
>> To leave room for growth the file could start out by, for example, appending ":"
>> to "inherit_ctrl_and_mon" to indicate that there are no known properties yet?  Something like
>> below. Would this be more consistent with the others?
> 
> To me, it might be clearer to simply document what the default mode is when kernel mode is not enabled, and omit "inherit_ctrl_and_mon" from the display.

... and now you question again why "inherit_ctrl_and_mon" should be included in display without
a motivation why and without addressing any of the previous considerations motivating its
inclusion. How can I respond when you clearly ignore my response to the previous time you asked
this question?

My previous comments are still valid. You mention that "it might be clearer to simply document what
the default mode is when kernel mode is not enabled". To me there is not really a "disabled" kernel mode
since kernel work done on behalf of a task needs to be done with *some* allocation - kernel mode is not
"disabled". Why should resctrl not make it clear what this behavior is? Adding another consideration to
the list ... what if resctrl needs to support some other "default" mode in the future? How can a user
know that not having an active mode means one or the other "default" mode?

If you feel that "inherit_ctrl_and_mon" should be omitted then please motivate why and also address why
the considerations I mentioned are not valid.

Reinette
