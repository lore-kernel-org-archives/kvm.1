Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154D168BD;
	Tue, 17 Mar 2026 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708233; cv=fail; b=p/J5qTZfhEPBd9bXFhbRRh0TXUQSyArTkDBfgihJSYkfswkXjl87rPeIFRWcd5GyYnQ52PIUQ1EqRDUD54GmrXVV6WrzmfUXRUq50L5+aa0QKN8qIkwCrZlDK1fE8fzRgOCP/m8RtEkbB+nKGQKvuOQIh7RGK1QT7pthTKjtYb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708233; c=relaxed/simple;
	bh=kZ2TGt071icDqqRJ0gjTo/LTuy3HLg4WrEhk/XfLKDQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IfEagUwg+t5g0RcK91zt83kh0wgcwmSzzLePF23kYouliPKYCsHyVnOFGXH0jKtAJIu/kkYD0bU5Kbo8RFUr6kdduISs7o0d4JnI1NgBCbpNx6Rr4f4gy0LGpiLiHQExo4qqONFnMoLK1L5d9N+bkEIrfSbY/Mksox/LB+NxuGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiDsL9se; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiDsL9se"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773708231; x=1805244231;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kZ2TGt071icDqqRJ0gjTo/LTuy3HLg4WrEhk/XfLKDQ=;
  b=RiDsL9seRyZ/B4q6QukJuSu+ov9aYiC4wgr1iBrMj5OjpYCUZ91FH/AN
   FFXv5+kRbbsV8aTZgynpnCmZeT+FvVqef4sj7IRKhvOqNTj1fyh4XUgOZ
   bxT8Mxjwt57jjNOOXOmAbXVpyq9zUIaWfN9FIZ1EsMjXEgH3SZ8IX46hD
   f7QOobV2Mp2iLXzQ9txkaQXP6Ssiql2pULbBWPuS89qSb5O4p4m/ne15w
   L9FT3JYG2KCgLu03hCCTzrgmkbLGHxPKn08AXw7uJ6soQF0YdYslpYdXQ
   w00xo8NKcG5lqyAADXVy3WqkOlvnU4RD54AOJGrMOBAEcydQMntq+h8lG
   A==;
X-CSE-ConnectionGUID: X8feCn+VTv6xB4J7E511jw==
X-CSE-MsgGUID: 5bqaHHHTTIeMx8Vwa5GhbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74650765"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74650765"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 17:43:51 -0700
X-CSE-ConnectionGUID: WdayeBnBQv22Lq74VJn3JQ==
X-CSE-MsgGUID: pcD/8WTuQ1Sw92elxZERCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221329925"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 17:43:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 17:43:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 17:43:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 17:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+/jyk7cfMhMyCR/bJ/DnpxnR49rauPYzEDquB/S5jwM9VDxAneNgm4Apbjpi7TLwmf/AIBzssXSzZ7XlfuytLIbs3kRqF98Nz9ABO3cMjAV3FeYQXuGF4ZnLybiNtGRmYADxfIWuG7d4cEgXJ9uZ4dbB2jtQuki2qM2j5Zp4iP/vOC5iBUBc2YInSGh+Og7gAs52tc07bX0iP5I6XljImctV6xCBfAy0zKIjQtfWZ9N0sS1me9M5khR+wZnQkSHMd347c5fS/u3yWWoxe/HvOWW5NRloyRfHly7Wje0Wu9EylRAMnLcQAarDf9SM9D/Ux/Wwn/4Tu/1tXXcXXKcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX4kiH5ppvMgppLiRn7qtnHy0RUNc1DN3ysz9DJMAPU=;
 b=bziN/nD8nIwQz1z4pjpmFNIWxlXC7053vlUkNxd6t2Heic0Uk/lZp6ON7k/TFXJ4Wx0D7t7b5VQermrzQzErvG2B1RdNh8mXcnZkNNwJmHHuFYxsA0vReZ+oOSS10G4Y4JBJVaQAzKtz8/GgMglfNtp+aatO4YGlh77GGDUuOjFQc1Wlih2OEYcHyRHOujUyuTy11lSyjBuKlGFHObunap+ZEhe8wi10aNgy4yq90ZMQ6MDEaJIs974HymdvOajbd4NXxyarGaMllw/1Q9GXo5ovA94XY9mO7KkSDv/bPph5OJBWuwIcb+lp642vi+hqyxdfkVD7nA2SaDgmKdN24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 IA4PR11MB9009.namprd11.prod.outlook.com (2603:10b6:208:56f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Tue, 17 Mar
 2026 00:43:45 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb%5]) with mapi id 15.20.9723.013; Tue, 17 Mar 2026
 00:43:45 +0000
Date: Tue, 17 Mar 2026 08:43:31 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>, Farrah Chen
	<farrah.chen@intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H.
 Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
Message-ID: <abijs4Ij97L4Rp9E@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-5-chao.gao@intel.com>
 <abf-3xRg7ouZw-F4@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abf-3xRg7ouZw-F4@thinkstation>
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|IA4PR11MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: c047ee63-fd7a-48be-72c2-08de83be3ecb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: H5+38QClBtKUkaSi+6+wh40nGuVT8/Zo6T8dAlDtabmgNXoJkjm8OUE/D43suA8MKkpFMeJBHr73hAGAgRLeeX2GSF4dbnCvj2I3COOdC3wroo6l1/UhPU90H1wrY4fE345ranVWXT7xCV+m52pNrrayQSZDcqeGOIMkPRoSLCy40IocEd5Zwy7gQV+ahvHgLb62cKaLD+1zXs54f5xokwlJsI5HJoqhkZLVzYXGx/7gyd3d6D2cIe7mULV6fRxpI+Y+rdSCZy46eQBNkDRImUvO2o5vUZ5XukPLmGTAANOtFSAyhuQB0zIi020s6LNyxvE8AX8bFqnT73DOuEPUb3NhRwz5Xj+fkYItf4ed86Ey99BigbOjBKUGO1uWIOoKOoMtO+lQL2Sx26lSL/zeSV9GDVoY545W6f/bD/NqSKV6afnDDGuQuVL6jeN1c1bdzqBv5tLwD9kjsUdB0OZK61ZC4Q4csgXH5b+GtUqFWFZ7LY2NzrZKgb4fTXuwOt0npEQExIVWqnao0IGCt4iOyiPqldQEFDOqa91GaMVpsPlEJiPFM6T3lWBNeiEXJEQkqrft3gPZGd9cdwH7PgFF3IFCcwn/b/W+u/hOg/cMuZzd9lRXFPWx+MlNtj9Xs1QgDlqy1SazC8NDht1bC3xlfwJBWsQH7I1DPJA0OwKjqWIvfO24pDf6onbmJ9UDpP0q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zSv6aPczKhTf/f7IgO63Fe/Z1zZiggx1CbcBANKY/xt8egVcvylthZTR31P9?=
 =?us-ascii?Q?WgOKcDDfpwbgB/Sk95uDO/zblK+FpHb8KDWLfHh3AFjEloUy7LOLrK0u3lbL?=
 =?us-ascii?Q?lyen7YISJTt6J+5A0eOrN8PrgeD00IXFKMadPX0BMUjQ4BrX/c4YOJwa+mjj?=
 =?us-ascii?Q?9ZHqevqBzRHIMadGZ4xkULLZRkUVR5WUNouGvisSQWPhShQ8afEvLM2b40Yp?=
 =?us-ascii?Q?uPrql9aEulCRoPANt+wRYeOnaDWgMuK/MS8ISSLF0/W8FMEnyWUU1hkFFeDm?=
 =?us-ascii?Q?XQnFLd5UX7IXewNuxosOVuItr6AJrKtIGYCVuSZnuXYAK5IG0XI9ZnVub8E/?=
 =?us-ascii?Q?g+jBDAXMNCH2VZTjbZU3IlVbwlRBc6yT0iYAwCuHfU7lfgNwhIAUIuyVHlrQ?=
 =?us-ascii?Q?nCTckv/f/A1v+LzRX6/pAbU6HSc4LAQcJtOepFEN894Fb13BiakMnWmBKER6?=
 =?us-ascii?Q?Vq7LUsg7mRpA6hwSlmFkF/HNu7s2lcLr/9F/MxeF7raf+oF4FJeEfwhRleSw?=
 =?us-ascii?Q?Is/Gdz5F2w69ogbOSVwA5+gRATynbDPTm2AGw5pDv3qk9jfZqon3FrOTNkkk?=
 =?us-ascii?Q?jbqn34ArjrjVowdnuK9QiDkbwHAzk6NqSvY1tjGO5yAAULgv7sbs4nbDXoCR?=
 =?us-ascii?Q?98E4ApYfc7ZHpKU14lYSrE/sGdV3t9hbGF5kray5UYUfbR+m83xe0Vnk0zH9?=
 =?us-ascii?Q?6XGfxWlXhn/s9w5w/bbpefHPG4TmozzAcFmRXiYGOzSw/SBX3tnMXR7MxqYS?=
 =?us-ascii?Q?vkILXZM0+8kEKzx7cqR1vq2Q3ADLrxsOzj4JrEc5Mbqb50higwjEH825g1eR?=
 =?us-ascii?Q?/lrDbe/ALWkWg06cX+EjOB/Eyl911GH8v49XyzAe4xPQ9aNgt/96goHeLRk1?=
 =?us-ascii?Q?uhNms2inqtmAPCyRYU3PKkawcS/zTSXoIiZDcM0gUeS30cQm5XVamyTJCxIh?=
 =?us-ascii?Q?LJtacWP4onQr+cfyq6AyiweZxOCHkgxpLIyvgpozzaV9cMl4ypXNTWzSUeop?=
 =?us-ascii?Q?GnGMwWQWulLWcGsuQWZFpeL4if9HRjrZxbtmJMG7oXX3C+/7suq+z51PBz3+?=
 =?us-ascii?Q?Sdd40wTcoUBiCpaxytHOLtIbj2tRHg3Dtng6G5/+CdtePrFg/Xu/5bG8h7f6?=
 =?us-ascii?Q?nP8QNafntB3SYfA8644JtgSZiKEU0gqkBf/LgcrINdLdcZWu8cY3BaCvEYgL?=
 =?us-ascii?Q?GPOrs3cSUhFLaoWlJCClKrxvlfj4npXZguFRAY3uHdFHwZz5GpY5OLD7urGa?=
 =?us-ascii?Q?/8aupQc9JfaNg1MtSRd3WFBQbGiM6uWyA/SQI8cL6303Omtz00Qq5s4iqfGm?=
 =?us-ascii?Q?HO9rPph7eLOwOD3F7/FtCjSMd0PPNKVFp7RceUJp9bFD6ltSghU1pnSk3FoL?=
 =?us-ascii?Q?jRaOT5HKzojHhtsAkjeBkvC/TSOZd8ESsczBaDTQ4sofaQHRY4c1koU88ugd?=
 =?us-ascii?Q?f4MmWqo1h6BseW3SOvbyZCYw8tRuCbCsE3/vG9f88FYVzDDyTxfPCbgLmHbE?=
 =?us-ascii?Q?mRZdhpNRDci1g4iLxNh9Mt+f/bmJMA276Ytg7AHi867SfgHBn4VzmjKCYzZV?=
 =?us-ascii?Q?kWtfLXHPxEKVr8ZGe/hUum/vH39CMG65CwsbagkOA3Y52XdVJsvlCFeH/WtF?=
 =?us-ascii?Q?fbRT2611YB2n751SDgVZ9SKuTUkBcgby1orbkraHIIwIP7yFnkv0dZR+28Ct?=
 =?us-ascii?Q?+ptdIeM7I889FAXlsoNJLPTDlukbDWw5QTqeSOAjcnrIbNUH0BiK2LoxnzVl?=
 =?us-ascii?Q?Z7X4OMt8Ow=3D=3D?=
X-Exchange-RoutingPolicyChecked: B0vMl8eUK/5S8KMUAhkrbjNoxF29wnQwxBzw7d8umPumZlUwzq0kja5Sq0qQ2Cj5TMt5RRZvm2XIt4rJJlMAAA1Bgx9Mpg+61NyF5T64PrMhrdWnADKCuNbhJR7F11aqF2SAEphbWgEZmufXSMG92aEGdphfBMuETnHojfFnyGwlMajH5HXgHy9QbuO9Xw43RDrKckkqb38aE1QcahSUya6YiOKEAo0Ftyul9GWCUwajSqwdWqo8mSrQppcrgcxJZKQ7RuS6x7GPw6YfEdhpudpbv4slqKpaomYNFkCBFc95Jt24dzjAYvZc1E/2VyvpkLcncF8CJB8eytmITxtolg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c047ee63-fd7a-48be-72c2-08de83be3ecb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 00:43:45.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6R636k3Fu2g8Bb6zRqMI88HvSl43bTBgURvTjJX4T3R7MsQMUhs3taRmc016AiWhB/ByhTw+rKX6o0azqQjQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9009
X-OriginatorOrg: intel.com

>> +/*
>> + * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
>> + * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
>> + * be made with interrupts disabled.
>
>Hm. I am not sure how it explains use of raw_spinlock. What's wrong with
>using plain spinlock with interrupts disabled?

We mustn't acquire sleeping lock with interrupts disabled. in RT kernel, a plain
spinlock becomes a sleeping lock.

The lock doc [*] states:
  On PREEMPT_RT kernels, these lock types are converted to sleeping locks:
  local_lock
  spinlock_t
  rwlock_t

*:https://docs.kernel.org/locking/locktypes.html

and also see the test I did:

  https://lore.kernel.org/kvm/abPEit+Ckeqmypv+@intel.com/

How about:

/*
 * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
 * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
 * be made with interrupts disabled, where plain spinlocks are prohibited in
 * PREEMPT_RT kernels as they become sleeping locks.
 */
