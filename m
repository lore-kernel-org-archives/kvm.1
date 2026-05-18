Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CAA40DFB9;
	Mon, 18 May 2026 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107777; cv=fail; b=Nkin6JfBI5jEK1h7mzusjyGJ2CHO40UL3Inm9KmjqACtdMEppA1jqkHQcyWlkBfQ2ARiDgUHKp3e6fTw9ESl1+u6L9B0DPC8Dn9dDWwtMIhH5ugN6uHw6rn9nlcyNayOnlg9vzGxAoYrdckqkTP8hWAgH+E4hEcn7iX3vx6gNt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107777; c=relaxed/simple;
	bh=KxCJp042mnyE3e/4QRYfNL4OYWXWe0PH2oydAiL01os=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oY0rlLKl5iI5eOE/4UEpAOOqOn5Dr9AUVGTAh+oANVZKNtQRTcpVy96Zt5H8jQ1/2pgbBx/KwFQieIwemE6BNwHT87a4pfy2rBJ2KfxxKkGOfL1E4rjUwDc5qtGc10Sdhd33IInq/L3joWngm0PPe9DpDaP+c2t0PxSf9qiNxI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRKS9Izh; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRKS9Izh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779107776; x=1810643776;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KxCJp042mnyE3e/4QRYfNL4OYWXWe0PH2oydAiL01os=;
  b=NRKS9Izh9RhJvQ4xBfNVzbLTD57/kqsT4MSBT3vQVLX0skftkpVlHYTm
   CjjI1DwX4pw5ZtCu+0jcDs1IwsoKLFUyYJ9W+vmq+9iNU75achvL/NhVK
   o3iRz9hGod0ihwPpdsbMYWckIywTGDKHabSghv+H6f/8Mk6YnNxRwyx6+
   YHjyiAci4Ntwis5nTSBJj5c3We5bLi4ySuk2hRSOptSPUqdzOUqCN1Ef1
   NvxLLWjNUcxFBgVqguK2YI3KdpxVr630D2bhXeALLgq0zjYRtXcHw+57l
   gLUReq0i9W2lpuS1BPdiCaMyc7/+4/S2Gh8N1Dkp/Lm1eGbcOohrRatMA
   A==;
X-CSE-ConnectionGUID: U0fzUezXQLCPBAaHNN0wKw==
X-CSE-MsgGUID: RWH+bLWiQKWoxhFqkG8gaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="102631073"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="102631073"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 05:36:16 -0700
X-CSE-ConnectionGUID: +vRC8in1Rz6iN+XRjJCzfw==
X-CSE-MsgGUID: zC7l96Z6R0GPpZoMec8LuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="235172634"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 05:36:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 05:36:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 05:36:14 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 05:36:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLcQFVSerCsh58nJbCJ9qhunyGWxiJPZEmBCPFg8dJKePmve/kI+HzFnZCEuJL/6vm8SZy27kRf2JClaAqUcK3TIgvuvMvl2Q4ot/gnS2N/6AFuVSp/w9B9AGKBpc7y/HNv//gYAn/dtsvPhWcV2Ojp0aGiQT0Mo9AGTB4UzImsggIbwYl8L4waDZKbyj6IddroNyqjHqRkEc8Aj5gcDHrxn2YmoR0YwTfjHENwv2ikT4YHVZbh3KijAcl4Wmr95tFb46SFISJSIzq4InJIoimcVbkl5y8fn2qpQS9emb/O5oSVZ9rEkYj+oVI12+xMmuItLXB9hRzgpQawexYT33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU0M9ylISg1vQbwPcfuewKpPpaYGPa++u6frUx9bwSg=;
 b=OGyGKze+dOJs/+vLRjUlm8iMlPy+c7nVqxRLHzvdL6f7mG+VMWZibjGH1seImdBtxvb11SLDo/h0aU46H0bVzQnO8vSuGEG4U1DJDgo4P7LolA6a4qJm9Nx3Jv0BCRcs4p3rkM/QTzje+zHGtQDdYwVQ5KkQHyn6f+V74XGB9Q5SN17bz+3CUWywMt0kve+jSzbdGGVQfnh0PSseNc2R/tJxRRhyE6en1xVP9XIE7mGiwQxn9LG6Ge3tt6+6lGGCbcPqO1JNv3lUrNqE7myBbsWpRBnKynX+IHpBaHS4tU3zNQzhCl/mt2twiice+fD54iK03u2arrQTtlE96lBpmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 12:36:01 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 12:35:59 +0000
Date: Mon, 18 May 2026 20:35:46 +0800
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
Subject: Re: [PATCH v9 08/23] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Message-ID: <agsHoshCAG0T3t/u@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-9-chao.gao@intel.com>
 <e2ec0efe-2248-4823-ab3f-5d87835db3c5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e2ec0efe-2248-4823-ab3f-5d87835db3c5@intel.com>
X-ClientProxiedBy: TPYP295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::18) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|DS0PR11MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: b5005398-7ef7-4d5c-7747-08deb4da03e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|11063799003|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1cLfCkZYDJSR6PC/l3SeejwweSWV6sOcssf0TUiZfNrbHkMR5GA+w3PAmUSadJr1ZLoC4peneOUZgRkG5LYku0s9xVU5BSjEBvOJdphuGmFX2sJ3gLB8aNT0ogNX157cysKAprrKleEG9897VxMIlRV6tylYhhW+Ip7maV2QJKpC4YBLmEi7eLqaBX5RFrapoD00YBgC+/tv2CqWyHs5tDW5kBWjJAwM2BWoS4Em8hbI/97T64Rcvsuf/UEF6vi7lih1PbDen+t5N9znkc2KbT2mX6VPlWxsiDIJFvt3DdkfZKLPEU4z246D/CYdVgmkXyFJ4jxzWVGf2JDJPRKaT6wcQuNjXNSBCCGbzelIPvDAhWDG5ytOdRFPYV4bUZ95q0JvhvHfM1PBnNK3nluq6fiD7G3DGWwFkq6yzth4u4ci0ka3UaUr9li/5Fyx6CKwT6WvvGU4+9elqhD+D7iP9EyLOa5dE74CsCoJBMW/3ejtc7p7rcR+JVQpMcqQ+4BlfV/VsArhR+Dyq4QFn0HuPFnziOvC0tf67Tc1L8EtARbQ8kq/vEvsKhpIiI14P7x24EX3RMr+4oITZfNa7iN5syJ5IKdoOVq0Qo03F+JgbK1RAESxsCT1lp2trdt6j0xuVOY3EKAOVTitxdAVBuESCv81SQlVyxhbRz+1kmM66J4VbAdk/9l/YmRjAZ4rcNJE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799003)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G6SMRM5+t7tALFvEEYRpMX+nyE9xjnEJgKj9O++son2CaKgIgGwj2Xrs5SdF?=
 =?us-ascii?Q?0M5IPQBvyVYawzPq9JCLCmP7oZ7X1duhT0g4SAZ72sebZZH3BDC2iQbVciQ9?=
 =?us-ascii?Q?Am5bWE3Q2SA6maPbgJIOaoW/v/7U+i1p4Ck/VbjpqvyhywEDKe5TtkQfjUYo?=
 =?us-ascii?Q?XUUQWD7ugz9fRijSC00k2cw6LRK3+0LO0+7026W6NA70s4AErjjx9aru7flY?=
 =?us-ascii?Q?TVlYpcbjh4aKe1ZYCbw2SiUw4XZw3EP4EvB7rCI5ZBfBPILnaza099Cw26PP?=
 =?us-ascii?Q?IJ4abA4T6L2p1UdY/YxFf0kvbKJJeaJyac9l55TLf2zK56y2Q5IYi6mRYelV?=
 =?us-ascii?Q?yEsEUQ3HlYNVpyY+KP54wA1RVcZdEiDnuuFUU0ldtEvlpOTfOS08v5z0zKMo?=
 =?us-ascii?Q?8a9BOsKM5BKEUkk9UHJcPoJ3Dti5Qa1i8ICWVOJxVDYxYFKjbStysktPqTmo?=
 =?us-ascii?Q?SqZcJN9AkEYkSrnRA7GpCvmnLgIOv8DNIp5u8a3mQI6wXyUAFxj/yBGo9E2l?=
 =?us-ascii?Q?vk2MwcWRBCJMiZdIAz8iJkhV5h+myJuF8kbHhooiG0hHohuXwxJbTy6waRBd?=
 =?us-ascii?Q?CaPyG3jzRuJOAGpzQNInwHJfc9EMuxVfrdmUd3Vqeu68sSAFi5lNtErRblQ5?=
 =?us-ascii?Q?4MTfWNdRHmMVrPujABDL3Mkw+m7A8DyJUfZHqFkvD7+Wmp/wEQW76vD3avoY?=
 =?us-ascii?Q?rCZiGiAGLfNCMK/x5sKz2RzjyKMMPrXlo1F3gEtFUxY4ZQxLoWfZbesh+oZu?=
 =?us-ascii?Q?LKcTFOcxv98Ws7DjOYGipduVFvi0AaOratIzXptQGVT59QmyXARTtQ6BgaoT?=
 =?us-ascii?Q?Y054EU0V/rB40Gzp2wzhthB/QS6FxXxW5EYRYx++d+O92xGjQVHwa/dXn5fK?=
 =?us-ascii?Q?tqZ8qSwxu0Dzd3w3qXyXzCCFlPLh+GutgI1VWzcF6oaKVqIhE4rzNby+ajAG?=
 =?us-ascii?Q?Rbmw3RxAJ8kjKaKEQu/ekE5tTxpks4vzJxB1ihpEV+cN7nxAJVc/46u174/e?=
 =?us-ascii?Q?QHCwE2jO6SFcUyi43PyODpWSWyEnrQ6FJAzeK7HpUf6pJ+2JrpatOW6YhAaZ?=
 =?us-ascii?Q?Wq4vfJ3BgEf0muc8QHOVkrBLvjmwnDhP4b7AzlqeWi2dQIEuGsE33mxOBD4h?=
 =?us-ascii?Q?U8LsBUehR5Wy4Upu4KIX/C3nTd/aifN9HHmW1g5Wrw2vRqDYrBdbPQC88Zcf?=
 =?us-ascii?Q?JqrZIASCDv9E78zxKugHj4COsfSBAsVkbp4VPGlEi9Igl7bid9MVw1Fcb8y2?=
 =?us-ascii?Q?d7Ti5BjCCNELZODha/np/mtQFopI/rGb6gmcUakVmwWo9C6ivdNejtftaGsz?=
 =?us-ascii?Q?v4pAT9aOF/t5+UtU8BZOUKdBbFn82LjS3baSRA5+wwQstMAeisayBkvk3JrA?=
 =?us-ascii?Q?4Hnc4BSMAVXxKDylZSkLOYkLL2JWwXbr+4+bpRGI98gSw/b+wCb5xGGRw8C6?=
 =?us-ascii?Q?OVgpJ04zHW+CAzbT5HIeWTTK83q9cjsEaGHnPdse0TgiFDHQOtBvW8BvCfoM?=
 =?us-ascii?Q?N16+rzsaAWZ3Lx6BF2eAIvkRHZhPTRtxDpvsPLc3oWHvi1MLFyxwE2Maz1I3?=
 =?us-ascii?Q?lEq/vaSk2RFSnD9yZCG/89uQEXPmShxiA+w1VU8u6qqNn++KoptW7x3RR2vs?=
 =?us-ascii?Q?BL75tFVv2Tuvn0zp8kBHKhCZ8rP4muh7orZwV/bqfXYWosfu4WDzumLDWwvo?=
 =?us-ascii?Q?YxochhdOSwNpcsUEJojLb4XwGPXR+z8PUoNvZnKs1yZ9UR/afqLllzB7fJ7u?=
 =?us-ascii?Q?Cbiq3r3Ijg=3D=3D?=
X-Exchange-RoutingPolicyChecked: kgVUUQxOcrm0v2eqkMP0iOPUXony2d/SyMH9qrwZmyqT5XD0HJWHQc0pJfOtykj5XAjrmBv3Ci7WyZ5d604ChI5eGAck4VmUr9UgWu34koqD6MDbRJypOwLsTmGBZVtWPVrTMcwhT6zjpzdfy2V5/xUwg2HEKkvaCfgH2pvZxFuWfhYqJTELERA6ukOip0oEXCSQdMWnid+Kq5bVoji2cl8wZqefxau3VncpS9c7GYJqGD+00ImNk7I2OSm3EHZ6G52ciFDA6s2tusLB/IRy8KuFFixeJFCDhpDGh6OoJetWsL/e7AGfFkthiso6rCRWvH5HhDbQHPbO+bo/rWMCVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5005398-7ef7-4d5c-7747-08deb4da03e8
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:35:59.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjk8Aalop+Ki/CTcpWIEjV2r16A0RgxuG70xasp0zO/tXVw75WhkmH9ErojuRR8D/Vh95irYSkqcsOUA4YFvew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com

>> +static umode_t seamldr_group_visible(struct kobject *kobj, struct attribute *attr, int idx)
>> +{
>> +	const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
>> +
>> +	if (!sysinfo)
>> +		return 0;
>> +
>> +	return tdx_supports_runtime_update(sysinfo) ? attr->mode : 0;
>> +}
>> +
>> +static const struct attribute_group seamldr_group = {
>> +	.attrs = seamldr_attrs,
>> +	.is_visible = seamldr_group_visible,
>> +};
>
>I feel like we need to mention *somewhere* that these are kinda nasty.
>tdx_get_sysinfo() is slow and single-threaded. These very much are and
>need to stay 0400 for good reason.
>
>Talk about the DEVICE_ATTR_ADMIN_RO() choice _somewhere_, please.

I will add a comment to make the DEVICE_ATTR_ADMIN_RO() choice
explicit.

+/*
+ * These attributes are intended for admins managing TDX module updates.
+ * Reading them issues a slow, serialized P-SEAMLDR query, so keep them
+ * admin-only.
+ */
 static DEVICE_ATTR_ADMIN_RO(seamldr_version);
 static DEVICE_ATTR_ADMIN_RO(num_remaining_updates);
