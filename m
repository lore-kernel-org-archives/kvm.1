Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED33A5E66
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213456; cv=fail; b=tZAxnSsrSJvj8WNoGaHI+3ORDCMVGnDwLupAfDVyIg+n9fd3Ls05wml9jLcqnOAu45qqGKCSq+AzaK/xNN5QlCkkWlIbRglvJIcfv8ST3I8hJI3a3u50tw+iT1HA7k1+xH3RnYkRyXZYgCFIDu86OO5dOy0RtPnXFDdB6RllN7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213456; c=relaxed/simple;
	bh=xkQZ1oqSCgKvUl2wXXpsgveDZ93FycbLEQ6gS2l4saQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tdY5AykqC2uIP9aaC5ZgNrvgEGH8hGeL1E3M+9BXUoh0W9vu4/8i/hwOaO94YrrIKdEC4EGbe/wuxFvXCbhG+WHXm9AIBhtigNSDStrn9rPGw7be4Z8BC8wMDwfc86po4qMbHlm+Gdf8QdFqyP+jLh1BdYMfcgTIWdG+Dgm7Xa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiZWT4FP; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiZWT4FP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773213450; x=1804749450;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xkQZ1oqSCgKvUl2wXXpsgveDZ93FycbLEQ6gS2l4saQ=;
  b=BiZWT4FPTk1sJt0NfKZ6cfBytjzGH3qnJIN6H/y6OZf6IGGhbUbNEGSk
   lfCiRqNaExJ24nR/MA7xFaPQeF/kQeNiZH3dqAJcmavZBYOvySxke5R+t
   3FlU62+5Ph2ZwZZ272jm5kloU3FZ4WUnQggYIfmURrQ4LkVWkkkWzXQ/k
   hr5pPIPpuOSU6bQqeWbuBKBCCXLnzZRczdm7se29eh0pJYeYGjT2Gus4H
   Q3/92xe2puvRm1EZAl9IwuE/LIVrglVkUYakIVkE4V64N/5bGzUlAJZgJ
   ridIbhItVkjUQBZd/1t0rim9rouEwaqzaoBFleQFaCQbpFClV8xfOM5hB
   Q==;
X-CSE-ConnectionGUID: mZR7xexYSJ+6AUj3FMjmbA==
X-CSE-MsgGUID: djVFZX9SSzeeuezpNsbzjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76883590"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="76883590"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 00:17:29 -0700
X-CSE-ConnectionGUID: hU55q6MgQMar63Ne5VGWHA==
X-CSE-MsgGUID: KOXPKPLYQGu1hnNxPK+YFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="218271474"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 00:17:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 00:17:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 00:17:29 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 00:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIrMI0HKi8YJkgvpqBs9jMDwnU2xlpmTku4nMovTcqiEHuL2cGrPGsdrLtp/2CN12KCe87HR+T2rj+Gw31H2F7LQmrfRQ5hzoFOo4k55A2k1OoYKYE2X/tpijsuQp7mxeKfTOBaGstDClz2//uG0SHTTg3oO6S96+mIK/J7n3GVGc4+Ubq2xQcGY/1dW2D/yfpWmrZg73vxfjaEMCBHz5vsmz64tPQDQdqTVZ35EVEHWZzXm9NGEIKmkk+1af+oIon40OcnHMsS/pnQtdwL6Pis8G7pwAGGiUExNwAFYB4CmQLW8DK7swwBT3ggWen+p3tBFmCFIe0DGVIzqmqLLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz+2Q7LR/wneWuFgBp2//DGq2ibqmwmbrYLgPBRrEtM=;
 b=YB+2o2X6ordgh+Do1tHqWSzJqmr7pVA7b3svrsyHUFZkdu6PqORZBA0W74E+bXxgL/gtq6Zt8l0qd9AnPdBzvQTZiXmvYInrC6lMdf8snpzrYfvkr8usWwXd0DpmXBPq3gAi7yftcJHSar9GLCjFv5OzFYwwL2jrZmCpfpDWxBhmRW7Bm59j1PwLtPXWmzJslmMLAtkoEDuCWbLdgngeJvKw5aSozaZt4IhI+gq7nZIDPVJovcYhzNyT+bJ4RfAEu+6gp4fgK0HvogfLgWYx6W5MyW0hnui3GHndn3IX1+STWqvx0svzvznsEociIVMrxL9y5+xsjwY4fzJUd0vPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 BL3PR11MB6316.namprd11.prod.outlook.com (2603:10b6:208:3b3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.13; Wed, 11 Mar 2026 07:17:27 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%4]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 07:17:20 +0000
Message-ID: <cf341392-bb32-4497-997e-a46902da56c5@intel.com>
Date: Wed, 11 Mar 2026 15:17:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Make RamDiscardManager work with multiple
 sources
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
CC: <qemu-devel@nongnu.org>, Ben Chaney <bchaney@akamai.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
	<clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson
	<alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>, David Hildenbrand
	<david@kernel.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
	<philmd@linaro.org>, Peter Xu <peterx@redhat.com>, <kvm@vger.kernel.org>,
	Mark Kanda <mark.kanda@oracle.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <ce681660-d47c-4ba6-9237-eef55a87493c@intel.com>
 <CAMxuvaycCnFjhqtv5Gvi93W-ndEDqFbdgTn-pmYbyMAOW-v7CQ@mail.gmail.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <CAMxuvaycCnFjhqtv5Gvi93W-ndEDqFbdgTn-pmYbyMAOW-v7CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0031.apcprd04.prod.outlook.com
 (2603:1096:820:e::18) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|BL3PR11MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6c57cc-047e-4f0f-308b-08de7f3e3bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: R8GaB3DQDVKD7GdtGSO0DodNZXSzstQJga8P8nUzp2VbWJ9Hah2ppNyYhMD5v7fnp+SVE6el10iGZTy2e4zzyzsOzSAPzjPTD3lhPO6Z2A20ttQ6usdd1u0M7As/obQ3eJla68AITaxeT94D29wp4Si+gQTCPToj33/yBluE/y2DW67vMLHPChu+CjgqHHJDX2SZugrvK9P7MxIoBOijR/7Uf0+TPnmefHtejRw15Xp54r+81BkV9nIDibCjInFuPy8QDvI8kD0Th3MXx6FdEJpsQbFKjj+p3Ld6JIhAc4478Hw4YZpQEL4SrepX6nmTjj63eGivGp2dXrEuzKcLkz0lv8+jBQCX7k7nDtRmgOS59mhmeRP08XkkGJp0OtNGysXUOozTF86vGdhTO9DWioy/ppWFw8A4PdIEBOKZCsNQDyIxZ6Sybpb8khTeYSq5DG89ARvMDejZgIudgp6bhGfN5m/4lw+hM8SRASV1NZEsuHqvysWLM+B7OPyvSrUyACEXIgDSiErCBHtZcOUgCphqbRni7izSmp7FH7POXiL2TrI7gDXKNRWMqe8Zjwt4bzHipDA87+m1tQFwI3idIp5myEi9zW44FstJRue1np//zMRzIYeK49ggb0EZSQQ2SDD9qamQo8HIzDifLBaMGotfxpoIO0eseqa+zQ0rLC1BzH/j1RBWK/81GhT9pZXz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytxNld4aEhHc2JQc0UvMHRLN1BjMk1VY1ZrcHJNSE1yUUQvUXNLZnovRVFB?=
 =?utf-8?B?d3RrVzNPemlmb3h3eHRLV2s2UzFQTTZLbXJTQTVlS3YzVmxNQytQbGVyelNx?=
 =?utf-8?B?aFRNRGtJWldwOGkrSUF5N3ZGdUFpWHNTR0NiUmVGUCtKWDJTY3g0ekxReDJD?=
 =?utf-8?B?Nittdkd2K0YveEpMZGt3c0gvdy9YMkt6ZERKSVp4RmkzRmc4QUJPYjd6SURM?=
 =?utf-8?B?VGsrSVcvekRpSjZEMkhDTENjQWpOK2N0K0VwdVVFcHVyVEdLVURFckM2S2lV?=
 =?utf-8?B?ZGtDcmdTTktnR1pqSEoxVTE3T2VpaVMvZXQ1NWFXNkc4WHdXWThVbGoxazRx?=
 =?utf-8?B?cjZyeHNxbjBYdG9TS253aXlaWmhIU2pmT0pjMHpuU3hEL1YvNWE3aDJvY3VH?=
 =?utf-8?B?TkJPUWZJWThTVlFwM3U2U29qYktjK25rYnlSTnczamJ1R2x6MHBFaVNBNHM2?=
 =?utf-8?B?elA4OW5NVUhOWkhSSWxWcmljSVVpTmR4U0ErM2tLZm9BL25NcW0vYWtPU3A1?=
 =?utf-8?B?emgxejlMcUpKRE56MU1kT2JZa3pRRGU4RHBKSnRJTWx0UGNDdHYzYzRNeTJD?=
 =?utf-8?B?ckNSbXlKNyt3elRJMTVBUHNyWnl5ZjNBSWJ4eFBjQ0ZJT293dXR6Z2FuWjZK?=
 =?utf-8?B?bkRzVVI4RzdVQ2Y1WmtkQlNRb2xianZ6ZEJWVUdDWFQwSmxjU2JzMFArSGpO?=
 =?utf-8?B?SHE3Z3dZRjlUdlFVS0pwZ1BsSy90eEwzQzZ0ejRyblNWNkhhYWFETEhJSjBu?=
 =?utf-8?B?VWFGZ2xpeHR4d2hZYVVmdGhYOE5LaTE1VzhxNWRrTUhUamdSYStwT0M3TEtO?=
 =?utf-8?B?ZkQ3NGF5WXg3M203enJobnVnbnJWdENMLysvdkRRaWJFdzM5Qm1mMDN4N05y?=
 =?utf-8?B?eUxCSjNCaUhEL2JVL0lyMlJIWUc3czc2WmZyMWg2ZFRiMDZPdjhnT3BLUGVx?=
 =?utf-8?B?SHpQcE1GeFFwWmhRRTdZMEQ0TDVER2dFMWgvWGUyVWhncVZoZHJzSmpmYUlK?=
 =?utf-8?B?RC91Sm9ORTBYQTRPekVCQnorMFZKQkFMVjRBdjVodlc1cENQTEJNYjRmMG04?=
 =?utf-8?B?T1BTUm1IYXJjVnhTY0ppZU9oYnRZZTRoajVua3ZRSTZZNEJyOUVzUE1ybHZK?=
 =?utf-8?B?QUh6ZmVRRjBFRUpQSXcwMFpoVnpFYWNPMW43QTlXVVIzZFcrYWhEbVJSTzBY?=
 =?utf-8?B?V2gwNk9xUWcvOHJYNkxiSWZaQ0c4cVNjNUl1em41T2ZOQmFGTFplNkVsSDR2?=
 =?utf-8?B?WnhzeHJSZ21JK1c3T0F3ZSsxb21tK2txaUdkYXVkU3pzcmptd29Db2g0RGFN?=
 =?utf-8?B?WDJiRHJXWWcyTEl1V3JvdFVSc0dJczJlamxBdWdnSk5KaUx4RzdldXJKMTFN?=
 =?utf-8?B?SmF3OXJSeW5JOHB4bEIwc1o3Z2NnS1RoaHZEVnlrclhhZG05SjdYeExDTEp2?=
 =?utf-8?B?dWdPcEpGSUZrUHdmc0R2ei9VcWhTQ2xCNDdOVG55WDJZTVU0L3d1Y2lHNThx?=
 =?utf-8?B?MVBWY09wTW9lTkh2RHB2UVIyZnBuYlR2L3pJbnZnV0FNQ2VyMmR1bDh0Ymto?=
 =?utf-8?B?Tlpaa0xNR2wrSWNpMUtNQ3NRbWJteWF4b3VOb3g4aDA0OWV1Vng2NWZLVlV5?=
 =?utf-8?B?bWp4K3c0SlkyWW5IMkdzY0ljNG54N0tia1ZTUHpFbmorSnJCaS80UjM0YSsx?=
 =?utf-8?B?cTlKdFJVSkNUVUJQZ1ZlN1o1VHZud0ZoTjRueU4wWHUzcFlNQzFYZDBpYjNl?=
 =?utf-8?B?a1RFMkU0eUVCRFVGNG02YWZUZXBIVDllYjBEOTgrUzg5TzBDQXJhQVo4QTZw?=
 =?utf-8?B?dERidHMrN1BZRndjMlFCL3VrVmlvTGlCbnQ4ZzFKcytaOGFhWVJQOHorUERp?=
 =?utf-8?B?dTFjQWFBRjRzK25lUklwVmxtSFcvMVZ3MURBL2xnZDhLeHFZWkl2MjNncXpU?=
 =?utf-8?B?WHVGNVY5K3psL0RlQ0xrSmVhaFArc1BCdVExYWFLN2toUnc5U2taWkdLdzRQ?=
 =?utf-8?B?YnBieVk1cnl0VHdKM25kUkxWckFpMXNvL0ZXeTE0T2hyQXdpNE1mWFNzY2Qv?=
 =?utf-8?B?TlpHQ3piSmZWYjRvWG5SeEV3NlpuOVZwMHA5NTJWUFBDK293dkZLZDc2MUxQ?=
 =?utf-8?B?WFU0TGVpNjlLLzB4ck9TZHhDVk93dVJNWUIwdk5TVm80Qyt2T1lHNnlWTTdB?=
 =?utf-8?B?V3ZvOUtBbFdLV0xlZ2h3MDVBamVuSHl0dC82N1YzS2ljRWhzY1pVNStEK3NW?=
 =?utf-8?B?a1VFSEFOSWhLd2RLQmN3Tk12eEdDS1FDM01ETUhObng0QTUvMFN6Q0lZREE0?=
 =?utf-8?B?dzM5R0h4UkY3TUNSMUo2anJER2NVUktPV0U1bnU3bGxtcmtqc0hvUT09?=
X-Exchange-RoutingPolicyChecked: Hr2uv8MyoEZKLXl7QQjSVDrb4HcV5icFlhGYoyp8U39TeAw71xVQ+bKNkcX4lRBJtwqsp76laOrOIlxYxpOz3z0HjGqxr0sU0cCdhjEBwB4Tyl4Z7ljkWagCgC3EryaQ66CG9BmECdEMX2RJFxd3RurZalYpxnVG8QQ6p7+nb0LlwWOpgV9b3hKN+SDy2aIVuCqOqK+Z22p1A3NYSMN4javT7vaIrxah92u9XbqQrxQTZUfAUgKu0/vuRarnlau8kNdInbCmDt5QmV9q9mWKTCqOfn1dbN1rhsOWnlRyKN9SvwlyXoOrydzuws7HoAm9Q15MPzanRjfUWGb2JFTOfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6c57cc-047e-4f0f-308b-08de7f3e3bf5
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 07:17:20.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Xwp6E0zFEAL9Op/ysAaBtP24rgbozd1x0wvF+I46BxIZOmRTK2mxSiYdTQ5rBX8S+TODkNaWRimC3Kf19df1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6316
X-OriginatorOrg: intel.com



On 3/11/2026 12:09 AM, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Mar 10, 2026 at 6:35 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
>>
>>
>>
>> On 2/26/2026 9:59 PM, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Hi,
>>>
>>> This is an attempt to fix the incompatibility of virtio-mem with confidential
>>> VMs. The solution implements what was discussed earlier with D. Hildenbrand:
>>> https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
>>>
>>> The first patches are misc cleanups. Then some code refactoring to have split a
>>> manager/source. And finally, the manager learns to deal with multiple sources.
>>>
>>> I haven't done thorough testing. I only launched a SEV guest with a virtio-mem
>>> device. It would be nice to have more tests for those scenarios with
>>> VFIO/virtio-mem/confvm.. In any case, review & testing needed!
>>
>> Is this series aimed to enable virtio-mem (memory hotplug) in a confidential VM?
>> I tested it within a TD guest using the qemu command:
>>
>> qemu-system-x86_64
>>         ...
>>         -m 2G,maxmem=10G \
>>         -smp sockets=1,cores=2 \
>>         -object memory-backend-ram,id=mem0,size=2G \
>>         -numa node,nodeid=0,cpus=0-1,memdev=mem0 \
>>         -object memory-backend-ram,id=vmem0,size=8G \
>>         -device virtio-mem-pci,id=vm0,memdev=vmem0,node=0,requested-size=300M \
>>         -object tdx-guest,id=tdx \
>>         -machine q35,kernel_irqchip=split,hpet=off,memory-encryption=tdx \
>>         ...
>>
>> The TD VM will exit with the error when the guest kernel loads the virtio-mem driver:
>>
>>     kvm_intel: Guest access before accepting 0x108008000 on vCPU 0
>>
>> I think it still lacks some support to accept the TD guest memory before using it.
>>
> 
> It becomes increasingly hard to provide easy to setup reproducibe
> environments.. but here is the libvirt qemu command I just tested
> succesfully against:
> 
> qemu-system-x86_64 -name guest=rhel10,debug-threads=on -S -object
> {"qom-type":"secret","id":"masterKey0","format":"raw","file":"/home/elmarco/.config/libvirt/qemu/lib/domain-3-rhel10/master-key.aes"}
> -machine pc-q35-10.1,usb=off,smm=off,dump-guest-core=off,confidential-guest-support=lsec0,hpet=off,acpi=on
> -accel kvm -cpu host,migratable=on -bios
> /usr/share/edk2/ovmf/OVMF.inteltdx.fd -m
> size=4096000k,slots=1,maxmem=8192000k -overcommit mem-lock=off -smp
> 2,sockets=2,cores=1,threads=1 -object
> {"qom-type":"memory-backend-ram","id":"ram-node0","size":4194304000}
> -numa node,nodeid=0,cpus=0-1,memdev=ram-node0 -uuid
> 0f3e6b74-80e3-45e7-a0e6-ae7dfc897606 -display none -no-user-config
> -nodefaults -chardev socket,id=charmonitor,fd=23,server=on,wait=off
> -mon chardev=charmonitor,id=monitor,mode=control -rtc
> base=utc,driftfix=slew -global kvm-pit.lost_tick_policy=delay
> -no-shutdown -global ICH9-LPC.disable_s3=1 -global
> ICH9-LPC.disable_s4=1 -boot strict=on -device
> {"driver":"pcie-root-port","port":8,"chassis":1,"id":"pci.1","bus":"pcie.0","multifunction":true,"addr":"0x1"}
> -device {"driver":"pcie-root-port","port":9,"chassis":2,"id":"pci.2","bus":"pcie.0","addr":"0x1.0x1"}
> -device {"driver":"pcie-root-port","port":10,"chassis":3,"id":"pci.3","bus":"pcie.0","addr":"0x1.0x2"}
> -device {"driver":"pcie-root-port","port":11,"chassis":4,"id":"pci.4","bus":"pcie.0","addr":"0x1.0x3"}
> -device {"driver":"pcie-root-port","port":12,"chassis":5,"id":"pci.5","bus":"pcie.0","addr":"0x1.0x4"}
> -device {"driver":"pcie-root-port","port":13,"chassis":6,"id":"pci.6","bus":"pcie.0","addr":"0x1.0x5"}
> -device {"driver":"pcie-root-port","port":14,"chassis":7,"id":"pci.7","bus":"pcie.0","addr":"0x1.0x6"}
> -device {"driver":"pcie-root-port","port":15,"chassis":8,"id":"pci.8","bus":"pcie.0","addr":"0x1.0x7"}
> -device {"driver":"pcie-root-port","port":16,"chassis":9,"id":"pci.9","bus":"pcie.0","multifunction":true,"addr":"0x2"}
> -device {"driver":"pcie-root-port","port":17,"chassis":10,"id":"pci.10","bus":"pcie.0","addr":"0x2.0x1"}
> -device {"driver":"pcie-root-port","port":18,"chassis":11,"id":"pci.11","bus":"pcie.0","addr":"0x2.0x2"}
> -device {"driver":"pcie-root-port","port":19,"chassis":12,"id":"pci.12","bus":"pcie.0","addr":"0x2.0x3"}
> -device {"driver":"pcie-root-port","port":20,"chassis":13,"id":"pci.13","bus":"pcie.0","addr":"0x2.0x4"}
> -device {"driver":"pcie-root-port","port":21,"chassis":14,"id":"pci.14","bus":"pcie.0","addr":"0x2.0x5"}
> -device {"driver":"qemu-xhci","p2":15,"p3":15,"id":"usb","bus":"pci.2","addr":"0x0"}
> -device {"driver":"virtio-serial-pci","id":"virtio-serial0","bus":"pci.3","addr":"0x0"}
> -object {"qom-type":"memory-backend-ram","id":"memvirtiomem0","reserve":false,"size":4194304000}
> -device {"driver":"virtio-mem-pci","node":0,"block-size":2097152,"memdev":"memvirtiomem0","id":"virtiomem0","bus":"pci.7","addr":"0x0"}
> -blockdev {"driver":"file","filename":"/home/elmarco/rhel-10.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}
> -blockdev {"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2","file":"libvirt-1-storage","backing":null}
> -device {"driver":"virtio-blk-pci","bus":"pci.4","addr":"0x0","drive":"libvirt-1-format","id":"virtio-disk0","bootindex":1}
> -netdev {"type":"user","id":"hostnet0"} -device
> {"driver":"virtio-net-pci","netdev":"hostnet0","id":"net0","mac":"52:54:00:82:08:40","bus":"pci.1","addr":"0x0"}
> -chardev pty,id=charserial0 -device
> {"driver":"isa-serial","chardev":"charserial0","id":"serial0","index":0}
> -chardev socket,id=charchannel0,fd=22,server=on,wait=off -device
> {"driver":"virtserialport","bus":"virtio-serial0.0","nr":1,"chardev":"charchannel0","id":"channel0","name":"org.qemu.guest_agent.0"}
> -chardev socket,id=chrtpm,path=/run/user/1006/libvirt/qemu/run/swtpm/3-rhel10-swtpm.sock
> -tpmdev emulator,id=tpm-tpm0,chardev=chrtpm -device
> {"driver":"tpm-crb","tpmdev":"tpm-tpm0","id":"tpm0"} -audiodev
> {"id":"audio1","driver":"none"} -global ICH9-LPC.noreboot=off
> -watchdog-action reset -device
> {"driver":"virtio-balloon-pci","id":"balloon0","bus":"pci.5","addr":"0x0"}
> -object {"qom-type":"rng-random","id":"objrng0","filename":"/dev/urandom"}
> -device {"driver":"virtio-rng-pci","rng":"objrng0","id":"rng0","bus":"pci.6","addr":"0x0"}
> -object {"qom-type":"tdx-guest","id":"lsec0","quote-generation-socket":{"type":"unix","path":"/var/run/tdx-qgs/qgs.socket"},"attributes":268435456}
> -sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny
> -msg timestamp=on
> 
> Then I hotplugged some mem:
> virsh --connect qemu:///session update-memory-device rhel10
> --requested-size 2GiB
> 
> [  166.228943] virtio_mem virtio5: plugged size: 0x0
> [  166.231784] virtio_mem virtio5: requested size: 0x80000000
> 
> 
> [root@rhel10-server ~]# lsmem
> RANGE                                 SIZE  STATE REMOVABLE BLOCK
> 0x0000000000000000-0x000000007fffffff   2G online       yes  0-15
> 0x0000000100000000-0x00000001ffffffff   4G online       yes 32-63
> 
> Memory block size:       128M
> Total online memory:       6G
> Total offline memory:      0B
> 
> The host kernel used is experimental; it's a patched version of
> 6.19.0-rc8 that I don't have the details)

It seems related to the memory size. Maybe you can have a try with "-m 2G,maxmem=4G".
I hit the problem when the size <= 2G and no range above 4g at the beginning.

