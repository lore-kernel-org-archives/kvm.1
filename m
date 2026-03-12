Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AA328243;
	Thu, 12 Mar 2026 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326214; cv=fail; b=hhx9k+iQDZ+zFPfO3IaceXVKCOlwLxt6SDS2EJgUatK8oXJ9iwinzhMjsp2w24bB/vPbZFaJbz3zG9HbWXBMtOzVYYIDFTEboAWbLYtgV7LjahHEdkdWNxn3D8Q5fwRBWxGJE5y0S3lz60cYjQqHMpb+uv+Sl/gh3U45z8bV0cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326214; c=relaxed/simple;
	bh=craSkuMLKCtrdD/WIW8AF1D+7BEHOdF5tCjyRwG3+Ng=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oJN+b+ZXvkrxE4hzi+wpfM1faSW0XV3JpowyzXwQJjD6G/PKMrakSZo58t2bihQcd7kX3XBE/wVxU78E94DogNuE83yFuKKIRm9DNKAQGb54pNazO9yfX2odcL9lE0Wf9r1dmxW8Z9GuHMy/9Dgj9jaZnojfxnsZRdRRiSo8rLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnMGvQBY; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnMGvQBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773326212; x=1804862212;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=craSkuMLKCtrdD/WIW8AF1D+7BEHOdF5tCjyRwG3+Ng=;
  b=SnMGvQBYZO7pqUeTCW2z4stRaLGcCK684r9fizLPo9onXnnDjh+dh4YM
   Uo6nMINlFLHzC7NLeMUPMaAKD5agEISOkKXOavahDWQQLaXIeUbj/WZhh
   USSxgfbK59kCLEydkZd/xVcxXYL2sIKM95RC8IDHEmkWQku9MxOPOEFCb
   8FfPqk91p8dHW9dDqCBBnsK0sFV6YJ8SgMAZp5uxqZR3fHMrKOpmrtblw
   Q5UfHmdyP3UT8KpBBgW/wMBOcc2O2TbODgV9Kx4Bk7JvKdo42Vf2Enbxn
   9VJ7GtEbWi4SlPnbK9iUUA3C046mNsTcmZjoBvbznkysIP7i+JJcIE+CV
   A==;
X-CSE-ConnectionGUID: cX3ZDwjBRyuYvFxefI8NKw==
X-CSE-MsgGUID: IQtPa7r+TmOHiKqbb8YngQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74532279"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74532279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:36:48 -0700
X-CSE-ConnectionGUID: G1Eh1iCISSicXkTFWaZ1Nw==
X-CSE-MsgGUID: ar9b84yoSW60bKDzPHoP3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="219936082"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:36:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 07:36:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 07:36:47 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 07:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9IDwu8G6q8eudSqTh2/X+cxd6/qQFZ0w5eLqy5TGaF9UwjJEg4GuX6xZrjdUQOQPqjn2UkBB76N5GP/veV8nRRVhhb7Eq9sFVlXlERXrnXtN2jCHbURE+PHYm7qJgIGKGYJaffLmez7ctQ+vUv6kG6MqE92g8eKxh8NbB2hf6KZ27wGvfs1UVhfOXfNyED4g6Xh5Ty2vhPs8/jpzGuNWU99PX0O7OI0Ub55Vw37BrN3P4SGP9Lbh00gi4KwRUyv6UgrYGVId0VKnOCSENS3CSmRdoFMONYCKEloRmibmiuIDoh66yu58tq3SgtKt20w9+yNPAXJkk/fjE2n0dO+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjqrEL+G+NtoL1gb/bTlQEuWSRNbF5jv/9iUqGgQPws=;
 b=K08SM2FG4soHrN9VYLilWlyhKmAvobcpqbZcDrtmE+8qP7fLnrRAFOHdsmySE/JAU4RQGP+vqhI06dAsmtlfxKejzi/fJAJeqmp27q8OS+iCnEVdUa83PmGDyhC+5VjZROb6456kiH7vNrjVuKNM84PK4D7WanrRNP9yRKjpXhzdpEhn38Fet6Dvscc9k0pYBNODItV2yGfVuEQKzi04htqXBpvCB0JnrmBYLcrMAgfMcJz+hxBvGVyltvqlyd910aM1jKlujVheP9J95qpP/6TLzNhaF9IHB538rBlWFpDBzUyOTsY6lfkvax6kkf2/ya9DCX/km70Cbf6+41JsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 14:36:38 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 14:36:38 +0000
Date: Thu, 12 Mar 2026 22:36:26 +0800
From: Chao Gao <chao.gao@intel.com>
To: Yan Zhao <yan.y.zhao@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <reinette.chatre@intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>, <zhenzhong.duan@intel.com>,
	<seanjc@google.com>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 10/24] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <abLPaonGMoEm2GFg@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-11-chao.gao@intel.com>
 <abIlr/gnH/Emc/9X@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abIlr/gnH/Emc/9X@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee104ef-bb3a-4561-a1b7-08de8044c4d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: FvTjoYqW0OxtLyWmkWUhmN1c4WPQF2SX0/W2VXpY8zG9lugMXx0AP+nGE4IKBFn+p3qaSuyBaQqdng7nfoeHPHOYrDow7Qhi+qK0VQMQ6bgRmfR4hwtNFhzJrpcmm1/IvxrnDkrI4FxGE9a1V8yVGwfVocgIxdhkszkFSMFYAl2XHaw7MUCNUqDUBS27IOZl/MPqDsSHxRKeKp7meTiCC9l6lf0uC2M9gbgKrZNfGgAtbY9NlwPJBefzyfEh5hfWWSz+/2WXvAoGH9AbbhtruSUuQxd1y7Q1vPhjwCWDownan4Jrp5crPwNKgkvijDB/fBn/zmfH/+n7XWmnNAIcmeKERdo0U/XZqqzQYjolsDIrPkWgoh5duOuB0t8evCiyenZDgXXYGqrYA59H+SxlZSfGelfnv3BtfmZ3f+jtqB2ei9c6XPToDUU8cyBMN4WciKOWs1PBpxzXQ3qt8zzWtNWikcESluwHptYraGTtlL7Z+jqZuxAAdwZU6gonrwDjuBXyeHkg7CssRO4p30DYP2tNyqM+8Q7g9qzeT3xNgrJiJrJSIWrgHB+BwEYOSgD5gic09bzJxiZRTIFueQyJKUKzB0D2TBjSfxMfRNx2gUn1wcFWs1/qciipvQ77F/FDipWHZYr3S3Fn5nPKGjnpHJRsJP+v+A74esCNuSbCJ0MPOeW0wM5bAANRtm5TRtG/F67GTaBRTf3GAdn+Ra9iO405xkyJc9FQI4yWcu7X03k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7QJSs2wdHrZIVw3DbZjxGkijCA7Jguc2MLmiOFwGAhFX/5WAJrcJPNJQ7ZIc?=
 =?us-ascii?Q?Ak2GVIQGdUUoYoZcDGoU0l5ieZxzHR6VxyCB7yAyvBpPNzY3iPSkodug9fAB?=
 =?us-ascii?Q?M+FwgUE10DbnK5olilyXRMrdPTSC9WNva/KveGj8m0RSr6YnzpPqpOhCAISA?=
 =?us-ascii?Q?g0gLEd0rjJfiYxR2mEYwr7ES34mQS3qSx4yO/XB5BqBSd2PKzKuEmovOnOuc?=
 =?us-ascii?Q?LKlMgpYaFr9zsG+WGpC0BfJ/oj7Cq8EhrIilksg/ELRZKpKOBMoungKKONRu?=
 =?us-ascii?Q?tOri3nVm8DfPMbGbgu0YLZB7pLS+oQdtAvhckl4N7YrAqKFmi4YQqdFgK6Ot?=
 =?us-ascii?Q?u8ejl11yoxCWMjY5lU0YpXgl4uKFMaNcBqO6TWnnUCgwB98jqYAtPiNLYVbw?=
 =?us-ascii?Q?5NiMUmyjGz9KDjIwcqiHN7cSYdIbrgJnN1nEh2MQRmO9DkBOx+pEJrBdI8y5?=
 =?us-ascii?Q?y1kv70sX5PTx6bByJ+TqLBUw5bQllm58eLzVvhmeC7jiLF4MV078nYZAbBM1?=
 =?us-ascii?Q?8By1pVXktnrHWC5gzPZZ4rE80SfuIjjouB5/wUpDuTPy2zWjowrCRp3L4ROx?=
 =?us-ascii?Q?DKdF0u5HDfVEgYqi5MqGN++Fd06dKrM6szFNAXN/fvYy0Iw8u7VXlTlEAYaf?=
 =?us-ascii?Q?rw1WIAZBzRP8lb0bFJRPSdnhMU9HhOJNVNdLFh30vL6YFuulVPjAqYJwqpzS?=
 =?us-ascii?Q?VuTuOub6P9+7L7oss0UXZ79zjmnRgCB75CTN0TkAWfRHrHaBLan9oBEN7yen?=
 =?us-ascii?Q?7F0r0tUydKH6aHvlk8RdsJ8wvl5md+DNBIVCpMHCHmvKyTdA11SrcQzjPhbE?=
 =?us-ascii?Q?7i7UQZM6lGBnRkeSLw+wDnmZOBLo/GQwYaKLnM8yyRQXLvdkz+utz+FmzC5B?=
 =?us-ascii?Q?WDbzaiJRTKtCTGYZO0If9Sdqr3dQp6OwNtMty30L1N/dOQOqxojBy7lT8I7/?=
 =?us-ascii?Q?6UW3mxKgAfNl9Q9xtJnkPepU0xcr9ru+sbPPgd8QoaYsCKrBHte0kIIKuOXW?=
 =?us-ascii?Q?dBNOz7+avEA0lkiaY6Zj9VXg8TMeVzrpS09LGHMB/bdBZCdQwue30cZiITab?=
 =?us-ascii?Q?8wbc98BNN7qObO5SwP1gNU+LvoeYtDUqYONkpNB6Bcz3vd19w9QwBmLmwb83?=
 =?us-ascii?Q?93XIOO9qd2TkusIRHHX9EDqMwL/eZ+I1/VFDl0TvjYwb6lQk4kVtTIxZq3GB?=
 =?us-ascii?Q?moUfKQJ6jrzyYMwnqIfXUgswASZ/nM5mOojWauDExCywYSN7X7DMWrVkoI8V?=
 =?us-ascii?Q?bFwHp2Ua9/tbQUJKE4LlXAHiTccVgw3n/Gvz4umfCFpZhFtrKxIzESI/4EYh?=
 =?us-ascii?Q?qKyxBcGGWrdMflB8R61/a+7CrReXk/QFWzwt+8HRSl4wB4GSfLyqolXBXJNm?=
 =?us-ascii?Q?HcL8AkQxGPSyAwLSywZgMpIxOhm+M9HZ6hDPRtEfZkMea813APVWngpZSwce?=
 =?us-ascii?Q?W3mgWebptIejZHqziz+AQf02g/BoFXVMqfQH0YutoafBHSIZN62zRR0oZa+Z?=
 =?us-ascii?Q?u1hFwS/+5k+Qs43Rrd01Su4RF+Q1JVfcjLJDlQYie1vJ1PcY/Cz/v4hj/3Cs?=
 =?us-ascii?Q?BKP89q3VcD7QMhYh116Vpg1ndJF42DTK8C2RamrhwJ1FcwhZw5RFFrD5D8Z5?=
 =?us-ascii?Q?L3zsigy32+kE9yCIi2RMZUY49AIet61jbsW1rIWUAiG/nlQV56BJVa0vuDpO?=
 =?us-ascii?Q?mPvWlnv9oBGUpqT7/Q4o97s3Vuh+lIkuiMs+HC83ZGgJDkn4qnNhr8vm2PL0?=
 =?us-ascii?Q?7xt9vTvihQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Qi1VbeNb3rdJCCKU9SeLqv1evdDERUg1n5UlHljDTdg2LHJxuFgR7Nup+Zkj6n/mLC8njzfAbXUVMOWGKTWCCpYVjbJEdufXPFyxBRnmg5PxQ0RmENrNIEaGlOFlJvcdBer2dYpyXOrMfjVQsnu7tUmlYRLfc7ywGwi5K4fTD5s8/m6gF0MI5H0HBuPLqmBz8RpQ6p9kAy0wvlN8KmMUFeke3ZTxPs8i57drc82ygC6eXfmYgX16g5ufQRGKlgnGKjPs2kW6awLdMxHY6CnPTyNRZCU8hqZ2QtqEorU8qgXez924NBrIVlSl7Wp3VCHNeHnpkPVSMFR/zy3SHgKwow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee104ef-bb3a-4561-a1b7-08de8044c4d4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:36:38.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywgN0itBER1Wf1kYQJp+JLH0oPFewlQiQwlTwiPagcvkWT5opGA9YJaYDyQ/k27BxFyW/RH2R3MRgY/qp/sjdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com

>> +static struct seamldr_params *alloc_seamldr_params(const void *module, unsigned int module_size,
>> +						   const void *sig, unsigned int sig_size)
>> +{
>> +	struct seamldr_params *params;
>> +	const u8 *ptr;
>> +	int i;
>> +
>> +	if (WARN_ON_ONCE(!is_vmalloc_addr(module) || !is_vmalloc_addr(sig)))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (module_size > SEAMLDR_MAX_NR_MODULE_4KB_PAGES * SZ_4K)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (sig_size > SEAMLDR_MAX_NR_SIG_4KB_PAGES * SZ_4K)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/*
>> +	 * Check that input buffers satisfy P-SEAMLDR's size and alignment
>> +	 * constraints so they can be passed directly to P-SEAMLDR without
>> +	 * relocation or copy.
>> +	 */
>> +	if (!IS_ALIGNED(module_size, SZ_4K) || !IS_ALIGNED(sig_size, SZ_4K) ||
>> +	    !IS_ALIGNED((unsigned long)module, SZ_4K) ||
>> +	    !IS_ALIGNED((unsigned long)sig, SZ_4K))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	params = (struct seamldr_params *)get_zeroed_page(GFP_KERNEL);
>> +	if (!params)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	params->scenario = SEAMLDR_SCENARIO_UPDATE;
>
>Add a comment for why params->version isn't initialized explicitly?

Because the page is zero-allocated, the version is implicitly 0.

But I just found that 16KB sigstructs require version 1, so I'll make the
version explicit:

	/* Only version 1 supports >4KB sigstruct */
	if (sig_size > SZ_4K)
		params->version = 1;
	else
		params->version = 0;

Note that we can't always use version 1 since existing P-SEAMLDR versions don't
support it.

<snip>

>> +static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
>> +{
>> +	const struct tdx_blob *blob = (const void *)data;
>> +	int module_size, sig_size;
>> +	const void *sig, *module;
>> +
>> +	if (size < sizeof(struct tdx_blob) || blob->offset_of_module >= size)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (blob->version != 0x100) {
>Do we need a macro for this 0x100?

Maybe not, as this is a one-off check (i.e., the version/macro won't be used
anywhere else). If someone has a strong opinion on this, I can add one.
