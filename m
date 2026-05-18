Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1513C13F8;
	Mon, 18 May 2026 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090235; cv=fail; b=ih7v3prac1Luuhrp8CAVDjMtSr+hPdAWr9vxC6RRiVgsu3l6Euy1lYrkYL/AjHyp3MgHk4mZOkBdH95RecG/lbdp+MI+90nkXYesCJHEMKqu24+Y1e4hEw5pipX+JSb4gboGvirQmHGVhA8E3Vcs5O2fV/I+JUYQ1cBdv5L/c5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090235; c=relaxed/simple;
	bh=zJz7lEXf+kHL1Au8Qmwm8zWaYO/XjcXtXCX2xBjOhkk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZH5KF5rbJyTtkV99jrvVyGEQCHrns7C4fgUCw8BTJvc/zxmDXVtNGAgV0l+uEtuOPDOfdM6Kcvm+FViHTADN1blk8LYU+TXyTDy/kgO6TN5bcq9/dpJ9FhLpzxCYUtic1BO8/vkNDuIekZsQxX0UkiC31KH3baqVdsjhB8EKuOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Htqg4Xne; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Htqg4Xne"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779090234; x=1810626234;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zJz7lEXf+kHL1Au8Qmwm8zWaYO/XjcXtXCX2xBjOhkk=;
  b=Htqg4XneDZmwSojYTk0XsKVooimTjxSWr0K2tvmmYiRR0lDRqlcv5wjV
   RcHXSFOqd5pogzwru5ptsDBEfQRxduU8qBHtAmEAyeZinM2nBd7tDuodf
   DOCAcwVNX4RtV/dRHWOchTrQ3qlbUS5C07/KRAIo4EC1LeclkgcyVR1C3
   x1MTptDY3A1GtLLGitVRLeoPOkL0M7YamxzSz28vm45ukIj1xIHBAt0Sg
   l8ceIw8Y4FsCOrEJI9bD342eeTTYo9cADgfzRznLLolLgmM3QccSEJ5Wq
   m+9KJOYB4Z31Dze3WrRCqvzuonn9isN1jZapzjbG18uVy/+YrtPAvEQip
   A==;
X-CSE-ConnectionGUID: mbs1s2HLT1ew2xp+6SrZEA==
X-CSE-MsgGUID: Hv31H9y5SYKtrMHGY50fIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="82500046"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="82500046"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:43:51 -0700
X-CSE-ConnectionGUID: i0IBcenQQc2rDDf0iyIfvw==
X-CSE-MsgGUID: VlLX5If2Suu3IYXbUgGKkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="235115665"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:43:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 00:43:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 00:43:49 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 00:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5TAdeeT5k+Xkv8Sb5op0Lbq1oxK+Oidb4qhp772x8G09hoA0ynWahPuzHtxRFdRolsJ3Y5JMJWcEtA3OaFGtXaoHXT78da3IMpDa5ZdkP8EmEO23i1DnVSkKp7mFUq+1OYCWMbEn1eL8dGiwV/b4xXU3k9+cVP4RIxvvqlGgOcw3O/J1byRxW1+OoW6x5lGKrRO62C9isEmL7UQkYN25hbPjuCOASAH1b6mo6LuKCMkC0iz28y5g48/gGPY/zIDscCz5FZ5rxLZPY18AyhOHyeaP4M7sh+0FQ3v/kN3VAGIz81yctGdSgqOc0plR8i0G5rTkjcufPQhaRvW3zWDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcYVGc8Na85KzKceQX/07KZMeNWeT2YDzUvaDh7We/8=;
 b=Xe+AOwisKLo44OHZbpI7vG7fjvHfZrJ8Xev2qm3fZfnA+0ugFdizu3TFdEQJ/s9GJvs98KJQOCHEk6UrbH0Vp5Z31DOWhg1GlLqR/mVCFWwEAMEL9pLFMb+tT0+D9fOX3DoIfMZ4ipRE9J1WZldXyAV73e9lCHb3wggZe3b8rGvo3N1WykWPv0IijjjCI4ghgCwlBTGH8lugiN2H/dB2z2ja+McGO2QD4TNPL1szaidXrmUAK/uHujbbsHnueTiw9RVXgNIT+aRVQZwBatz3/CQWJqN6MzYTxsEfQ1jiNTsb9Ndz3SSFS6/L3NDS5cBUvC1E8hHmwuTwIMvMm7vbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by SJ2PR11MB7427.namprd11.prod.outlook.com (2603:10b6:a03:4c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 07:43:46 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 07:43:46 +0000
Date: Mon, 18 May 2026 15:43:29 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dave.hansen@linux.intel.com>, <djbw@kernel.org>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <kas@kernel.org>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v9 01/23] x86/virt/tdx: Consolidate TDX global
 initialization states
Message-ID: <agrDIa/foXa2PhCh@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-2-chao.gao@intel.com>
 <ab35e6e4-b57a-4d49-8521-ca69a9135d3c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ab35e6e4-b57a-4d49-8521-ca69a9135d3c@intel.com>
X-ClientProxiedBy: KUZPR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:d10:33::12) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|SJ2PR11MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: d383f2e5-9dcf-47fa-dbde-08deb4b1312f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|4143699003|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: hctytK/GZ6GeATaniwMei20HYaRzDeEQOP9B0BwLMYE21BpiMkFk4K6jmE5ARuQ95uY8iVGrYtX0I6KLcs6KXS8RemzWAr06kZzHRL685GTgQeaVRpI5vbnk7fS5SZxJB8jDKEoiaobZZf1eXj0rHow82phaHgUYi2pFgx8KTH2SU7ZDHDsdv6q4t2tbdhRX5SeVyLwytExrSxS9YGOVhmgEzkM7XDQA3v+8n27Prd8+DCpc0PMr995lDyDGcCzbxxrkjlaWZw5wZbnm2wAR2rr14DHdSribQ+1ghoWmgNmxtHhpvkGTxK42i1Wq93gWirZJ3EVAMXaG7CCCP+eIbl67gLXJITQBoQlg0GEdbT8X4MO87Lxv+dUVoHsyCPI+lh0O8PZxA/M51Pbi0WlkcaHNeEZaP+cIW8Zu9ncxZOohl2e7e13CcRN2aq5fIFbY2f7t1dh+Nc9kjSvc0/7MzoZ4yGqDjqbMDfsHiY1RtvFnQ/MmjehbohHaa7rTNzyGZ42yLPjr84embNRN59wphxrHuO/ceX7oSNxmbXC+vG16w0BkkcvJEjkijCT93mc90qAPr6Fysno3sZsQN1F9qprm18qVHVmKW9qWUJFEpDFErZEkZJ4YGxpi89DCzIkfxz7W83dsii4zG/3uT2FymsJ3pe4P/k32qxDsvIDnfBv41TxGia6zZRd4q9uaKiFN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDdnq7IVdemJ8gufhi+1/qU07VOwZ99ys9tUQlnyn2Y/xqRKaUpPPVoe8lL3?=
 =?us-ascii?Q?1JkS1NRVstgrejWDxW8/EtPNUJADd0yWnAekR7pEljZUZ5nsar/Vq+WhYwrZ?=
 =?us-ascii?Q?cULeQxbIZL5TkfjI9sePUVRMNrS8vozFqJ5Zqaa2yD2WSa4dym9QbnkBUVVK?=
 =?us-ascii?Q?u5pZ1Ffl+eZ8ZxQ4hf7oc2VeMxOwVFOwHVTv2CFgN88TWCXtQ7+Bntvp28EN?=
 =?us-ascii?Q?nKbmPoxwJu8GclbGFB1JKtSsikd8rd8UYbDHtqAdjp5QaoKmdAhyVfArrAt/?=
 =?us-ascii?Q?YWcOO6lV35J9/41Iz1ldZtxD6UX3haJvcflMTZKKi0cKT8lNslvlxo63V8n+?=
 =?us-ascii?Q?Ix6Qc+MTUxpCPvlg6RH58GkXlh2lodVkPTrEdqiByiDirxFYMxaSwX28/beV?=
 =?us-ascii?Q?2rqHPoT3XwvANr2cn740HEK85I6JxiAu0hG8htN5G/VotI4ERA/ebwfk032+?=
 =?us-ascii?Q?J4zb5HvXW9QZs3fHBxzQgDX+I72s24hRs9Yz9TTY9v64RX7wRIux1Go5/2yi?=
 =?us-ascii?Q?P7EXQjbAbBa3LCudSL88YXk+NBhhcT5+u5vZKXeW3oZwvgy8L1RG1+rzinVK?=
 =?us-ascii?Q?a7QhSKv/+zywPnbuZ4YOB1PvTb9h5hwysmfDLTRUD1Uj4n+SXsWJr9CSXlZE?=
 =?us-ascii?Q?j68MEfsVRN3hknksDt8+cu6kr4JqkqHzFZtB9FyWZsKo5ALA+HG8kA0RBBJw?=
 =?us-ascii?Q?wf/SzxGFtTg1oGh4HqqWyLCugerrGyUcIbimCC6NCE5kEMEPT/AAH0w83nLk?=
 =?us-ascii?Q?+W+gMokZq3QYzjbl5sFtCbytf00HbfKGjGaq6KMIuQQ5vRiTktJ4t2UePz84?=
 =?us-ascii?Q?LkDypuZNfn4B5+jXR+fsgLtv0xnSGBIDftILw7QhonODUqXrGAoelaPb4FxU?=
 =?us-ascii?Q?+hxkaAMZi3qiqYTCRtJoB7yH+aMvJRLAp3Gklp6W1YCA05S4UiavZR4mzoyF?=
 =?us-ascii?Q?nnCJ8drDV6t8aOscE3Xt8V0PSYiNaLrTXkckCEvZ8Lvhh6c6Rz/WJP2WssuE?=
 =?us-ascii?Q?rE5KTWSqmwwFu1RtD9zT6WanJ93mWTxdmaI3EyyLS/unDgXBr5zbrYTLKA6d?=
 =?us-ascii?Q?CMUujIXN+VCBVZszpMdAWTm+hR5evRvXOY9I2T3CC7YV89kg88wr1sWnN2oM?=
 =?us-ascii?Q?2ccBMsQ6erETyT6osyf+bDOg8aHTh3K4kQISNOh+kEAyV7TheM+RrF9SFwrn?=
 =?us-ascii?Q?Q5qYRXWye7dNq9QYkN6LZmul0IMtTSM4fO4Inr35VrAqmO8iuqYiELlPzvLH?=
 =?us-ascii?Q?lNyJt2dT7JBtZj+jX00prgKGxcyCaMEMSzhgVoWRu2QB3vF4trpsxriz+YcB?=
 =?us-ascii?Q?UYOzrX8/bjnWszMxkZk5hLJU766+JrGmFSMuAHa12odjgOi/W4hQwlAkWaVj?=
 =?us-ascii?Q?xPhR5+H0+1xrKyPpP6WgktyLzGwl2kzEhKRku+huFt/tPxxpNk+c4HkPT08X?=
 =?us-ascii?Q?hxwgHwFjgGaPQv9HuiYDGg3B50X7JDbzBVfOHP68YoyzNdRxmBYBsvmj8S/w?=
 =?us-ascii?Q?Xqikdw0UzqAkC5B0XstTELKMbOZBtyioXHI9GCtE866NEkh3jx73j/0nsq7O?=
 =?us-ascii?Q?xrA3K/97jjW3muuwLdz6durHMwUP8KaV+77+Mu1NMVxTchkxFY4depUvfnwD?=
 =?us-ascii?Q?6YC/09V0rbH6qFxv50sYGk9k+yYZt/hkTMw0jMv4J+j7lEs2if7q3DKTIGqH?=
 =?us-ascii?Q?s8JdgPAYywS6BhsHIusqCW6mc+2PgRH69P7zmIm5N1ANr8GFcvXuievw6I/n?=
 =?us-ascii?Q?EcLFISbxiA=3D=3D?=
X-Exchange-RoutingPolicyChecked: bNSJc7B5rTz8KOU6xZE/76sJwlDkGZMhVLkmMGX2B6O/JC+fKSElmoyiUzcjXGQcISEUnXBXFBgaYuO92xHyJn9MC/U9/D39MXKas+dZUGvpjiHrw/9ZV9j784p1eHr2RieHwq+XKPgarIGD1DRMiO9WAGAN4jTymWT0F/yFpW1zdqIkjtETe8wbbEcLdNcIIRDpsyyxaz981X1/1MqvQZpGNySi/H08mPUitGeL4uEOrHcjBDHmXzecKecPsS0wEJKLXGSXCLGEmihrEG0YdGni+XKcuvrgOTuV9GXkLupuFG5jp/XDmCGW4B5HSkQfzSObzLx0sqFzM98Hyl34hw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d383f2e5-9dcf-47fa-dbde-08deb4b1312f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:43:46.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZoULQbELpFT9nn4O9sbWrVcenwWkEuAbumMmgpPLiv2+ViO9pckarrTFugAyBZd6as43kBpMwA2su53I6gn4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7427
X-OriginatorOrg: intel.com

On Fri, May 15, 2026 at 09:14:02AM -0700, Dave Hansen wrote:
>On 5/13/26 08:09, Chao Gao wrote:
>...
>> Group the states into a single structure so they can be reset together, for
>> example with memset(), and so a newly added state won't be missed.
>...
>> +struct tdx_module_state {
>> +	bool initialized;
>> +	bool sysinit_done;
>> +	int sysinit_ret;
>> +};
>...
>> @@ -113,30 +119,28 @@ static int try_init_module_global(void)
>>  {
>>  	struct tdx_module_args args = {};
>>  	static DEFINE_RAW_SPINLOCK(sysinit_lock);
>> -	static bool sysinit_done;
>> -	static int sysinit_ret;
>
>This doesn't look right to me.
>
>>  	raw_spin_lock(&sysinit_lock);
>>  
>> -	if (sysinit_done)
>> +	if (tdx_module_state.sysinit_done)
>>  		goto out;
>>  
>>  	/* RCX is module attributes and all bits are reserved */
>>  	args.rcx = 0;
>> -	sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
>> +	tdx_module_state.sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
>>  
>>  	/*
>>  	 * The first SEAMCALL also detects the TDX module, thus
>>  	 * it can fail due to the TDX module is not loaded.
>>  	 * Dump message to let the user know.
>>  	 */
>> -	if (sysinit_ret == -ENODEV)
>> +	if (tdx_module_state.sysinit_ret == -ENODEV)
>>  		pr_err("module not loaded\n");
>>  
>> -	sysinit_done = true;
>> +	tdx_module_state.sysinit_done = true;
>>  out:
>>  	raw_spin_unlock(&sysinit_lock);
>> -	return sysinit_ret;
>> +	return tdx_module_state.sysinit_ret;
>>  }
>
>But I think it's because 'sysinit_ret' is really a funky thing. It's
>just here so that the module only _tries_ to be initialized once. That
>one-time init records its error code in sysinit_ret and then secondary
>callers pick it up.
>
>Here's how you do that in a non-confusing way (some context chopped out):
>
>static int try_init_module_global(void)
>{
>        struct tdx_module_args args = {};
>        static DEFINE_RAW_SPINLOCK(sysinit_lock);
>        int ret;
>
>        raw_spin_lock(&sysinit_lock);
>
>	/* Return the "cached" return code: */
>        if (tdx_module_state.sysinit_done) {
>		ret = tdx_module_state.sysinit_ret;
>                goto out;
>	}
>
>        ret = seamcall_prerr(TDH_SYS_INIT, &args);
>
>	/* Save the return code for later callers: */
>	tdx_module_state.sysinit_ret  = ret;
>        tdx_module_state.sysinit_done = true;
>out:
>        raw_spin_unlock(&sysinit_lock);
>        return ret;
>}
>
>See how it sets the module state in _one_ place? It also only touches
>the module state under the lock so it's more obvious that it is correct
>and there are no races or tearing or other nonsense.
>
>*That* is a proper refactoring.

Yes, that is a clear readability improvement.

To follow the "one change per patch" rule, I am inclined to do that as a
separate preparatory cleanup before moving all states into a structure.

commit 26bb389c5762fd6a496fbed1cc55e4978e99a5cb
Author: Chao Gao <chao.gao@intel.com>
Date:   Sun May 17 20:03:00 2026 -0700

    x86/virt/tdx: Clarify try_init_module_global() result caching
    
    TDX module global initialization is executed only once. The first call
    caches both the result and the "done" state, and later callers reuse the
    saved result. A lock protects that cached state.
    
    The current code is harder to read because sysinit_done is accessed under
    the lock, while sysinit_ret is not.
    
    To improve readability, move sysinit_ret accesses within the lock.
    
    Group sysinit_ret/sysinit_done updates right after initialization so
    Caching the result is separate from the initialization itself.
    
    Signed-off-by: Chao Gao <chao.gao@intel.com>

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c0c6281b08a5..ad56f142dd0b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -115,28 +115,34 @@ static int try_init_module_global(void)
	static DEFINE_RAW_SPINLOCK(sysinit_lock);
	static bool sysinit_done;
	static int sysinit_ret;
+	int ret;
 
	raw_spin_lock(&sysinit_lock);
 
-	if (sysinit_done)
+	/* Return the "cached" return code. */
+	if (sysinit_done) {
+		ret = sysinit_ret;
		goto out;
+	}
 
	/* RCX is module attributes and all bits are reserved */
	args.rcx = 0;
-	sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
+	ret = seamcall_prerr(TDH_SYS_INIT, &args);
 
	/*
	 * The first SEAMCALL also detects the TDX module, thus
	 * it can fail due to the TDX module is not loaded.
	 * Dump message to let the user know.
	 */
-	if (sysinit_ret == -ENODEV)
+	if (ret == -ENODEV)
		pr_err("module not loaded\n");
 
+	/* Save the return code for later callers. */
	sysinit_done = true;
+	sysinit_ret = ret;
 out:
	raw_spin_unlock(&sysinit_lock);
-	return sysinit_ret;
+	return ret;
 }
 
 /**
