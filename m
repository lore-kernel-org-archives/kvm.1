Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F82F691D;
	Wed,  6 May 2026 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048580; cv=fail; b=UbRln/LrpE2IRZ60zKBlk/zY9lC+UQpnozNioJMEDMC1Yg1H7pVd3WL1tok3eP/QP4I/CG/oUQjwt2neuvQCl8/Bt2gIB4EnQ4fp5ooWiiQfrRjv+aIqCY4kf3DRiXAtuSKTBqNQ+6tN+MLVyKcm55XfGFsUqJDEQeTm+7+s4nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048580; c=relaxed/simple;
	bh=hSy/I/NFusduc9WmPkWirszbpAKbtwrwsdCotV168nE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZlDCvSXfiJNdYi0SHcfKwxNzbI+DqBKzy1Tu7MjKQFYrI0DNONsybdOCnwVA8dEnvE+/ItDgKUq/3MW287LO+DxqkRVTell6e4GeA/sXgcyPmIzy1tPjKuxnpAez0OCIq9lk7t+fJfPO8/lc0vfiui1X0AqSgd22c276TrqLR3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTC8CNKC; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTC8CNKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778048578; x=1809584578;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hSy/I/NFusduc9WmPkWirszbpAKbtwrwsdCotV168nE=;
  b=UTC8CNKCjYvHlXkdNAiOIcfGZSuv7V2aAC1K92VdzzkfeKVeD/LHN59H
   Zmm9pZKqy3+HZwacnz0XrrkJOItMT0yY4EgPR1W3C7ky2bBJRWo8KcgAb
   SI5CiI87Wm+dWyZ/Qxqr9BRcwstId2h9iZcNeF8Y+/Vs9nNC5446oPKgY
   JVo+lH5Meq/dFMuycBGzJBYfKoMJCLKAcSmUF6DQXILIT8COW8Jw4qkDu
   IrtxmcZrfEPSSXpJuGYe4qibFQdovyCcDxwfjilJuo/FwMu/A/EHt+P+L
   U1HwUF327ZByeZUUULJoqEwqgUsZpre8jcPvSIZVHxhHm1RbAov2A6xni
   g==;
X-CSE-ConnectionGUID: 0tkxdB4+RgSKdFzpQrlrCQ==
X-CSE-MsgGUID: f3sOkHMoRiebo4AWY67Qvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82554371"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82554371"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:21:26 -0700
X-CSE-ConnectionGUID: oeBcOoNERCeZjq02YdXgrw==
X-CSE-MsgGUID: Ms7WRKZpSZGzOn7H3HUByQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259717956"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:21:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 23:21:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 23:21:25 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 23:21:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IN+tuxLwCltKSHOCu3G137fU6KeuWcqbr8+lxCkg1JLqODlph5I7zuuOYzjFvlWxsCpvVsREig71SDvvtMVtzpPe9udnz7KklnKY56htIzzCKe+RK3GiMbEPtoVpIaVbDSSvEFijE2Ky9Azpgi6BpTXZkSoBY9H8HLtDSp1LdESSKLD6znFB9ynL1W+cT0LBPatloej4jJ9YcxJpkqooiL2Jw8p4fxB7k+ghvM3C6dcB/TAKw6rtyffjEi1lznLbK8K7H1rMywaYN4T9n7SmtmjExRzb9KZ/zAK+hJUUlirv+ejD1rzea2ZueTPqH3vkEne/pYN0d0qfyrBdj9znDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrJHzFTUx7YL06sv7DSsMpiVBMv52+oEmai6AJh7URU=;
 b=lhwXc9YbRaiJpG613Yf5gpVjjJWxQHcM+9BuUt0r/b22sDYfIbwS1+vnd+XqVL1Js9YRAoCT5lej8aE3yrsq9u0QsYP2y7xHv3eb/MU+2XbITFllRRSTVgIakVHvnZPpegXXV34vGagbcEUdxkythFesD9+cKMTMRqyMi7E9QpZm46Fko3WsIQStGDP4bzp54gdATtedZaeHc8IsyKGgY6RuG5H3OxzoKeyv/c3g20ah3MD2QahvkymzgblOV1rx0XXeD2m6wzwNI5yKGMJyISPKx8g5qf197adVqgzTfyNS5WG27XgBHAe2oOLOyU0+rRwAMnVWCAM98alcn4GaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 06:21:18 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 06:21:18 +0000
Date: Wed, 6 May 2026 14:21:01 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<binbin.wu@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 11/21] x86/virt/tdx: Reset software states during TDX
 module shutdown
Message-ID: <afrdzXTMr+GLyZFT@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-12-chao.gao@intel.com>
 <20f2d821-bfa6-4db2-a968-b5455c7b5007@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20f2d821-bfa6-4db2-a968-b5455c7b5007@intel.com>
X-ClientProxiedBy: KL1PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::8) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH0PR11MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b1bb4c-6fc7-4316-5d3f-08deab37aef6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fpPanyYf2+yDC8svCWFYMU1nidLQyXUlBXFuMVHoFTm0ZaPJ8NJAq+D4Gvzze6XpPRrXol3yqytU8fwKjvWhCz3rX4VMpsJPDMgUBIfGp9EcIRNR6ou8+L7FSFKm391bEI3PaN0aahUW0qdrefliWE7JGvwiyeXtCBOKfz0pEUrZ+KxTQnqGrsHWt89e9GlTre8IwaCE3kcp74myiRBmUwj7n1h5nKf2I305roL1nolgbBf8tdoZDeJdTf7M8PSJCX3jktbY99gvqwjRcQvGiq28Zsvg74O39IvJ1L28Z8m4tejYoI8q7esIQaHOkCMiWUBodzbsUHi25Pz6LjAyEVz6jiEsr4xYYCQbP5GVOqnrXrwaPB0oCv+H3+VF5cHu0/+QoWiG/X1obO+3mae2fTgA+EoUnG/BCUAkic8wmKWxb3qVhdN2kb2gMVokk+1rG/RKkOukH8LqEv0zLsjxXFmJYNM9s34+L2Pkfap+a5/mVs965KX2oE+904IibjXeL7EsXgLAm1o6V70+afbGwx7/nrV930VgMf3982/A4c6TFJepvS1d3oOMAukd6swA95n+CDMxIKMjJHfBFuNSlPnMXj/EK7ijaqc/oVeZ/mnVO7T+ZfnJd4fvLXhOAmy3orFiP4pXld2kpQDaNH96pZ6crXok73c+5ivlC7ZLSXYaaEVZaHulssfXt3bPPgNK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XLRKfl8ThEOSudbVB1bZTIlHLfNrucAYac+vDYNVt7OrjWdYPfetV8DeVtB6?=
 =?us-ascii?Q?H0BqPcIsSRWL4q1cjntlEHSwz/9vnSRNi0BhXhw2t/X1pONjW4N48bMnlWUm?=
 =?us-ascii?Q?iOkv1KUAWyK/b53mSaHrHPx13d/BwANsOR604bnKXMgbiwsCzptr0yOwgIUI?=
 =?us-ascii?Q?w6GlLVa6xgGSHOgSUSZhBE6NUmWG62wbXIufES+vpBdhFXcwbeu0b8WJVYwR?=
 =?us-ascii?Q?JY/OrYBfSo8yQu/tNMAreBx8QZGGFDj+YTJtZLJS/6p+t4iPJtotk0ZajEwf?=
 =?us-ascii?Q?k9Gt60DUcHq7xDzfjVdhJIvGPdKX6K2IiG61elQH2f0NylPMU7v4PFW+T/5Y?=
 =?us-ascii?Q?cYmr6GX9V3fkMr6jMqikmRLVAPgD4xbLCY3SXSCKChBsg7RpdkntDdVLIShF?=
 =?us-ascii?Q?JnoKMaWj+uWj7SkBPEDE40v4Vs2IsZUmZdwDcIND8w4boHa5FEXAe4s1IIDR?=
 =?us-ascii?Q?4D1vvPFbm0MvGD+u6HUVuyDUSr3M8KjyIE7gnfQJxHmdMwVJd6yo9kObHke7?=
 =?us-ascii?Q?QV4GAD2Rt0dzW0WSihpLn3wa7NRV+rkD2a4mcxai9BFf6Kw65ul9os1g/oPR?=
 =?us-ascii?Q?6TEC23O/E2U4kM+OMwUw3wfHp6dtRwwwIw7otV+YYmVwruym82E2mqcJLKUJ?=
 =?us-ascii?Q?9zxOLNhRzh3QOOMe0gdZObSs2OGPjJbHpr8njvFJ2dTpBiyFEgj0SjNZhIK2?=
 =?us-ascii?Q?Jhe8NKZ6MdYGraji97g3jha6j8y96ImnE5B2vlap0GAXpk3m9SjyAKkqL5zJ?=
 =?us-ascii?Q?0oDCS7D3RTzovq8A4I80JG/fmOqCR8Ua4N8iYVflaqXkwfTsOZzQ52QZhBqc?=
 =?us-ascii?Q?2NZcPT2O6Sq/XDXFQ6OG0HfGmkNCYxG7DWAnkf7leOwRc/GAZx04czALyXKN?=
 =?us-ascii?Q?tFfGUtlToS1FTI3zLahGTqOo1D5CwnOKo8o8EQieaaEt5lw6xPy1HRyw7CY7?=
 =?us-ascii?Q?9XYB4RT4Xpywv5S1p6hynWdci6p2A8e5zJ8QrVHINx9lHIOmYRxor+2wsQFQ?=
 =?us-ascii?Q?vsVFIsY7uir634lAWP0eQ8T6G5dXmdhHGMHqknsJdwht2k4CLUQMYzztLMCH?=
 =?us-ascii?Q?XYnIJZziJkHyQeSvQLMvycXS8L11URP4twxWDFGp2bnFaJlxJ7L/6NHwUV0w?=
 =?us-ascii?Q?VBEc74r4SUssoZcSv6gbatoPXOtjF53cDql+XkVjmNdvbgVlSFmHCV4zdEWP?=
 =?us-ascii?Q?TuYp70Krxem9s6PyCm7pl2pCkISPcNMRewyBBfK9q+wDwJ7fuALtsXbPB/Dg?=
 =?us-ascii?Q?lpUc4of2olRgPTR0mm8l+HZqATo4g7G2wtUY1+8mZXCkfg+2gjHgc7vW7r4J?=
 =?us-ascii?Q?rgr52p6zRyLwauSifIVbdh8/wqmWHb0kGdYdN6BX5kcMDGB9nR1aPqelfZl5?=
 =?us-ascii?Q?d0OD4Cc6EzxllVGngYg3KISCnGavYUdtj4Zn2Ej2eLUFrFiPnK/OgvVjSzWG?=
 =?us-ascii?Q?eS/Bu3U8RHFxsFvyFKzGcg8VzYgpABLza6vGLviVbMkyrmBBvc/w1fVUpNyJ?=
 =?us-ascii?Q?Ad94GStd+Zaq8tcSM2eUUxX/P1ueePgkyEs/8mci6CPplOQSvUhyh0fx+MmE?=
 =?us-ascii?Q?1hJeaYWu+3gZfuZaRPhsvjbQau8ax4uk7cmc1kwXiGn6A4GtcoRVYqD/REOn?=
 =?us-ascii?Q?XyKdK5kn6/u5Vh5IfzZfaP6ce+J5X6+GHrzR0dmqh4mymINcs77OkULdIgP9?=
 =?us-ascii?Q?gtoUF07aft0lzMc6EyFjFXt+M4nExBnXAV0b5mJnCSaEaq+37zrl4rfsEP4s?=
 =?us-ascii?Q?VIaaI7D6WQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: G9j7GeFgevMoPqwa2QFEtv4zOXABBmg1GTPS/7jKb77RtFmfZq/V9jmMOTT8f3/fjsRqy2i5Lef4VHgVsoJaadLBG2A8Lb48vd5D9+DGPu/FBUL/Hl+my33BHdQloFqTkBJm5zNcEdt+WGvPjKqZqFOA9XqyQnCkPntiCAOSOe1QMCy/hqIyKeltfmbDla6MFrRHrd64eLBkl4wwiHm/yimk/Zh707/BCG8n1nHfODDKw1WhyNtgnyuqmJfNGpp02iQhcQ3e/Pytd8Fu51wt+wWtZoYRxP98fzwl8gPmaStLOYZlfbKIzbYn5txDyg9tdFYiqQA1uwDIVav32to2xA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b1bb4c-6fc7-4316-5d3f-08deab37aef6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 06:21:18.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTPwv2Wv56tN9JPv13gWW4wS5qqRgSnegVSCyXTxZKiDXeklsDFtWBTJSDZk/oOBdBZwf3LtZ1LLH7BbZDAo5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
X-OriginatorOrg: intel.com

On Thu, Apr 30, 2026 at 11:58:12AM -0700, Dave Hansen wrote:
>On 4/27/26 08:28, Chao Gao wrote:
>> +	/*
>> +	 * Clear global and per-CPU initialization flags so the new module
>> +	 * can be fully re-initialized after a successful update.
>> +	 *
>> +	 * No locks needed as no concurrent accesses can occur here.
>> +	 */
>> +	tdx_module_initialized = false;
>> +	sysinit_done = false;
>> +	sysinit_ret = 0;
>> +	for_each_possible_cpu(cpu)
>> +		per_cpu(tdx_lp_initialized, cpu) = false;
>
>This speaks to needing refactoring.
>
>If there's global TDX state, it needs to be in a global TDX state
>structure, not scattered across random global variables.
>
>Imagine the structure is:
>
>struct tdx_module_config foo;
>
>That's 0's at boot. You have to init the TDX module to bring it out of
>0's to valid state. It actually means something if you do:
>
>	memset(&foo, 0, sizeof(foo));
>
>Because it takes it right back to its bss state. That ^ is also handy
>because it naturally just works if new state gets added.
>
>Guess what will happen the next time someone adds:
>
>	int sysinit_new_fancy_thing;
>
>Someone will forget to add it to this code. Then the module gets updated
>and breaks things in fun ways.

Makes sense. I will slot in a patch like this:

From 1578bd211c732f7773475819cbf145fe9fedfcb5 Mon Sep 17 00:00:00 2001
From: Chao Gao <chao.gao@intel.com>
Date: Tue, 5 May 2026 22:46:39 -0700
Subject: [PATCH] x86/virt/tdx: Consolidate TDX global initialization state

The kernel uses several global flags to guard one-time TDX initialization
flows and prevent them from being repeated.

When the TDX module is updated, all of this state must be reset so that
the module can be initialized again. Today those flags are kept as separate
global variables, which makes the reset path awkward and easy to miss when
new state is added.

Group the flags into a single structure so they can be reset together, for
example with memset(), and so future state that needs the same handling is
easier to manage.

Drop the __ro_after_init annotation from tdx_module_initialized to make it
consistent with the other two flags.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c0c6281b08a5..0172b432f229 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -44,6 +44,13 @@
 #include <asm/virt.h>
 #include "tdx.h"
 
+struct tdx_module_state {
+	bool initialized;
+	bool sysinit_done;
+	int sysinit_ret;
+};
+
+static struct tdx_module_state tdx_module_state;
 static u32 tdx_global_keyid __ro_after_init;
 static u32 tdx_guest_keyid_start __ro_after_init;
 static u32 tdx_nr_guest_keyids __ro_after_init;
@@ -58,7 +65,6 @@ static struct tdmr_info_list tdx_tdmr_list;
 static LIST_HEAD(tdx_memlist);
 
 static struct tdx_sys_info tdx_sysinfo __ro_after_init;
-static bool tdx_module_initialized __ro_after_init;
 
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
@@ -113,30 +119,28 @@ static int try_init_module_global(void)
 {
	struct tdx_module_args args = {};
	static DEFINE_RAW_SPINLOCK(sysinit_lock);
-	static bool sysinit_done;
-	static int sysinit_ret;
 
	raw_spin_lock(&sysinit_lock);
 
-	if (sysinit_done)
+	if (tdx_module_state.sysinit_done)
		goto out;
 
	/* RCX is module attributes and all bits are reserved */
	args.rcx = 0;
-	sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
+	tdx_module_state.sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
 
	/*
	 * The first SEAMCALL also detects the TDX module, thus
	 * it can fail due to the TDX module is not loaded.
	 * Dump message to let the user know.
	 */
-	if (sysinit_ret == -ENODEV)
+	if (tdx_module_state.sysinit_ret == -ENODEV)
		pr_err("module not loaded\n");
 
-	sysinit_done = true;
+	tdx_module_state.sysinit_done = true;
 out:
	raw_spin_unlock(&sysinit_lock);
-	return sysinit_ret;
+	return tdx_module_state.sysinit_ret;
 }
 
 /**
@@ -1299,7 +1303,7 @@ static __init int tdx_enable(void)
 
	register_syscore(&tdx_syscore);
 
-	tdx_module_initialized = true;
+	tdx_module_state.initialized = true;
	pr_info("TDX-Module initialized\n");
	return 0;
 }
@@ -1554,7 +1558,7 @@ void __init tdx_init(void)
 
 const struct tdx_sys_info *tdx_get_sysinfo(void)
 {
-	if (!tdx_module_initialized)
+	if (!tdx_module_state.initialized)
		return NULL;
 
	return (const struct tdx_sys_info *)&tdx_sysinfo;
-- 
2.52.0


