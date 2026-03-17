Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D4396589;
	Tue, 17 Mar 2026 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736053; cv=fail; b=jlvlwENH3LnMvKd0piraAmcjVpUkmVHqBHRLzvyTjuOGzjVTOlngKiioteimm2mtaHU5RWtaMGl3LYpjqpz1rf3RrPo3QWrfTUifztBUB4VrJPUc+IB/wmmMufYF8tW5usfj99fT4/5PQZ1Zr7es74KtBXQxBevc29gDNU8029A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736053; c=relaxed/simple;
	bh=Cazx21QFtX6hpKvDTjv9ZGDVhPkPqvd7mOTWJCYzgA8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qulAFzq6FMd6UZwPwE/Cfjc+glk7QkzJHn6pnHZLaj2hLcbqnXizpfQSL/CaUGlf/UcLbZa11Ff19D0Li4QWG4mUeWFO+ZELw0Dp9ENBcw2+f4hzQqUBPAwZA3IoHbKng6n0mtFsZ1AEPR9CpxVc8uYB4xwghpNtu5Fz0a3gUd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQxWMhGt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQxWMhGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773736050; x=1805272050;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cazx21QFtX6hpKvDTjv9ZGDVhPkPqvd7mOTWJCYzgA8=;
  b=JQxWMhGteojbCceUTIcG5EqnEUq7CavzhCVXTvtXJavye3tIXSpI6RM/
   0gyqgIyoo7jY3hjFbaaXG6E9vEujYn0BqHV2cHal1wxEugW4p63S7vwME
   yG4kS1hocwTJncie/b8g9Gi1MY3kTF1SiiA6Hw0inWssi1gmOGVk99OmP
   xcykOsWuF7Z9ryPDCpbCX98OOKv+DY6uw8UT7zGgkuIPy+XNozCc20QB2
   GGC/VPVAZoFVtwKZO6DmTjXNzKQB2GkbUkrojYWBohmoIYv7Ni1YjEINA
   bR2U4CKsYG+P6mIt4wQ1lrcnFlUwuByTX3xw1We4BoUk8t6Nm9Euy3ghD
   g==;
X-CSE-ConnectionGUID: AT1N3e43TLSWqkxINbzeUQ==
X-CSE-MsgGUID: VyH3FAZTRsW/DmevWNmCSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74840771"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74840771"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 01:27:30 -0700
X-CSE-ConnectionGUID: PvCUqNh1SH2AM73FYwyNPA==
X-CSE-MsgGUID: uPUr7tJBQXO2lZvtZPD99A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="260100494"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 01:27:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 01:27:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 01:27:28 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 01:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct9saHFt9E2qBCWz23v/uYIYkPekm8mJxEITx41gDUIcV7+9NOWnOQpqHrWDcndhzJSH09/9iOiabbqU/9LEq9/bETCFGBphc/+1e3ZUz+3KOk2g/BuhmT4GL3/BC1lqQceZBODkPNQfvR+iyqQek2jhXfsC6Gm59e/SVCUNqr6HdpGwr8Ndys/HZYlrcJ2hqwaOC9wW4GO3xe0d3ZB6JLJYvvWaP4RWj4MbRS6hzp+kZGTLati8OxyOwKPYG8aTE20FiGkRG2VTDRNc9wUuqVCQItumgflVxJWG9T5W34vEI96eBD/H2utFC31cdkud/SzvyZ2WVo9ydJYhbwi4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8VDKZaspW6WVObrAqIG7D1ytUKzbpI6XmuOYXLdNJ0=;
 b=BJIzOKwDykrhN2+NwUAoQ3QWXSFJKRetplApdZnHls3qcKMDETM0gJrUrEQPdMbH1sJQC/3oE5vuabIRqkC2vtHpI2o9xj5bDJ3xdA8ZLpZAo/FKtQCe7lrOhnQb2205b8STmH7fE9qbFKZeUrzZZxBNs8+EIhq5AgBP1wQAZKR/kHI1i5TzBzZpTpqbEOueJaxWQsnOk6NDw0Dt1orLqGveB47wuIVGu9cYsww9OkzpWVbsow38hJigOJisOtuYm8JJfp8OZRV88uzRsOlMUJtQclbQ4/UG0X8BOuvHA62vSI+y1j6HTIxOGBj7j38VvFfuKSHYXEV5HLFjluTvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Tue, 17 Mar
 2026 08:27:19 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 08:27:18 +0000
Date: Tue, 17 Mar 2026 16:27:06 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v5 12/22] x86/virt/tdx: Reset software states during TDX
 module shutdown
Message-ID: <abkQWsqR7BURMZxc@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-13-chao.gao@intel.com>
 <996e42a31101bb90575e7b2b6f33b3bd607b5e6e.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <996e42a31101bb90575e7b2b6f33b3bd607b5e6e.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::10) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 841a2758-1cb5-4d1a-b55c-08de83ff0079
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: PmsivU4Mcat8wz3/Lbk6cr7/lulv9eqn1iyLCqlN4bXHLf/b6gTbtHYteDoUmDPeP2VSMxVQbpsJKeSikskUW4ydSKZ89nZlKq1YhBMRQ3c4OO4Uk5m1VOgL6RjEwEGDdwk1BRz4Kc1rP2O5OLzRTjecxHDpNnCXQaQ4jNxabjaWssZ0Vj+Ds5tiR3D1jCV6nFB38xQ2K1LDzSdlanWjSZmZ4o8jdXwGUlvoqYzmc+mKfZ58wuVT/T3vNyowpBcZ8xrgbRKyGjaNsGuqP5cY4wi8nGCnaGErsl+f2qYPPTEbbnSPrdAfTWAwFEt9kAAHuW39pBRjlCMtgNCAyyboB8bN8fSV+vrd6ttqtH9cMyZKjN4nlrjdlkzXam5cxYwDylIG6NVyYN2RFF9eGMU6pjyl9eGuKG87prqCeuNeF2wzi3uGXPeALey2klQ9uOS/xyqtiOLh+7VNF/w68g23eq/TWQyZLO0bhfAEQ/wXnTLrcBPQR4lKiaKP0Zia89RLrVNenK1kchYyK1lMQX3Q+YME8eHdoN6243ZnM27oNEdSnOW9mPvYrpiNzto9ougLjMWhIoWyH7rvYmg3ODQcJK59eUChVwJR7OMOvUC0b1q9Wfggcv2WN6aJ6hXTAO5P7tHX9JmZzyb54/j89uwwiE5GIOJKKl84qjiCWNgxvwWOwXOYjdJCBq36l0g9ZpjWlC+rqKOT9YMj7TTABrEfiFioBncKrzIfGRHkjf8B32E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PB0JiSQhy1oe8k4C0/gcRfxUAJuC0PpfLfq7mD3MDu/TjY00/XBxJa57kn1r?=
 =?us-ascii?Q?X4eAB4rTNI3LkSqJz/1Q6qfBjQCufxUCJG2/UtyP+sFt5jZY3ahOwQzNzdsx?=
 =?us-ascii?Q?GIdAW5aGwb32ba08owE/6yLiwX80QK8w3GraYxSIXr8aN5VePoEy1YlVHeNx?=
 =?us-ascii?Q?VIHyuc0v1njUQbWRhnEBWSmuac3m4LOUIsnA1CzczEsHTWjXyxOJOw6JaBh5?=
 =?us-ascii?Q?QoXDun+/BEHP0LFOyIAFfBPmE5hrenkiBe1bjDiSdDG0/M6ajHGpz+YYse6h?=
 =?us-ascii?Q?gVwKOG5FmhsY2Ac1ZZwoQN9gAlXEH8XndJIe1b6gwN8up5BUDn9feWs6Fc86?=
 =?us-ascii?Q?XOJxfH2qb0vQSMDWYo2lfKoqUPlg2gfoPrbc+CfgNEpxApRKlURaESITEIFX?=
 =?us-ascii?Q?nLlgQ26i7+DCyidoFmD+aMA/YNJ/NNtuiVvaVA8f+D4KgJCdU+Be48QfS5tF?=
 =?us-ascii?Q?aruNLD+yhks9NMJTkl0RFLJi5WN0iSeIpLXK01xeJErzS9c0E+KbN6gY6Quv?=
 =?us-ascii?Q?CcxYn1tXaKxcV7XVHJU/U3tydQF6yHEPDSb7CY0C1Eqy9bZWL++Se06F84EA?=
 =?us-ascii?Q?bZwj8e11frbrjPF0ebRiSQ+VxBY1jiN8PntZr107cfq7R68a12xckhvn/pAY?=
 =?us-ascii?Q?Xkvouqz5RsEK7u0ig8rPINYXV8lPZ/9mtN8rS9PlVdgAKjWgv6Y0MZzVq9dW?=
 =?us-ascii?Q?ohgnGMk7i8sMEIjqjb09sLHlB3A7ZCVJwlHfRbI7KmA2lzzBFVilOIkNHsuN?=
 =?us-ascii?Q?4BLSK456c0q6QgnqnvFghbNSb/++i8hhR2g+pSoKC75B7A/8CKC1hMUI4jL/?=
 =?us-ascii?Q?2TlOrzMElx13Xu3iKxPZDJlv0Ce3dWIF2XrNOoVfxjCH4nsm8J/WgZFkb7X5?=
 =?us-ascii?Q?abBOKbChULcmzKY+hn66NCO6GMfXT/nax5utoVNnjUj1ahUzu3oox/GkWx+L?=
 =?us-ascii?Q?SftP7UpcXTV4BIkP3CwuHTvnwQT7WbII1KxKLHJPBxf8CiXEtyZiImcpxCah?=
 =?us-ascii?Q?QEgzTbKnSdx6zvEqIvyYxuVIPMgh1770+y4/FsyrXhan3RBOmHq1/NZp0CTe?=
 =?us-ascii?Q?LzJvRy4Hcay62Dpf46Wcjk59NxJAo9o/49V9gSLnTmaBSQiVg5eDf/opZymc?=
 =?us-ascii?Q?L+0i1l7B+YKj06i3SVMpJH0UhE5s+ZsOtFAkHpy3CnV0ZA20XeMzTy26LNVh?=
 =?us-ascii?Q?/UD7KZPRMiOOOcB2L/9jPWZwaklkxD3HZCdvk1rILHpyXTsHm62EtR44HX1h?=
 =?us-ascii?Q?Z3aP/rrjWDSCeS/XinfGHATqrZyPJAXyoI+6QKG0eqPjv9xAq3kUzJM54i/M?=
 =?us-ascii?Q?tPynWW/yBdo56MyD1rvbgLH4JbrfNB0NAJmtp/WSjX5xynnqf06krtJSw0NY?=
 =?us-ascii?Q?PkMmE7wx+U89QGumXIoERAHGGJrNvzwupNhPkskbRrLkv6UTcbhSqGOVgb9r?=
 =?us-ascii?Q?2DA5q38L+qcHksuKIuCH7r2GvNeyzxi0nXKaovrvbnWqvonUclaldHUChmfs?=
 =?us-ascii?Q?m/qh9v4tHbpLLKQnjed8VTn8rkt5KGx8extgmAVHq+PI2Ju5TjtgIyYDIdPk?=
 =?us-ascii?Q?EztcBxFPyMiY+nfq9wHfNpKwqAaklzADfp+Yh953Izc/nzkYNgG8OB/ZvbsR?=
 =?us-ascii?Q?NpgVsYw+nvdBWnAGSsw83J6/AyiZT2Hhfz59y8JgF4Bi3Rj6X8Eyw30K0/26?=
 =?us-ascii?Q?uRtS3xPZm1Hmh6qLiFa4/oRbV4AWtfQYpaJ33rblnBtjpzzwz0Y2dikFMGxR?=
 =?us-ascii?Q?dEVDi4liew=3D=3D?=
X-Exchange-RoutingPolicyChecked: gmkBsefcjNDHhx7N88J/ilPw4nm/dcFw3lGuvrDlBmRgM4WqhKsIZQlpheNnSKvaRx6RLTPdChynSrLm8HTuEB0ne2lBJY3bhgYpwTUSPAxE1azELagHrqaGnFI9QbFuoaWYoeBTYm4CLvBN1T+am1c+uhCiG8yNIl0jApkzDy/KxyCZzOlxD8F04KVWM4gwOitEtCyjCsV/0zmV/AOl17haPtFYshGOHYayCkSpH2wvhP8WCiIemQ2DkJBQlOIwYkSYi5gYm1PE8XLjZS64kuSttPb6/7IcBprDhQxO99C1DzhdGGzGVmAHf12O34FIX4iaiqMxx5n0y+kd7gXptA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 841a2758-1cb5-4d1a-b55c-08de83ff0079
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:27:18.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMKPB4ySphn7xArYEWYAGaiWChqoe4efrwQj/XoXMV1Pgi4UJ7v5GMyKzeVX4f+HPHnRtJZgmhM4bwGMG6ECmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com

On Mon, Mar 16, 2026 at 05:06:49PM +0800, Huang, Kai wrote:
>
>> @@ -1179,6 +1179,7 @@ EXPORT_SYMBOL_FOR_KVM(tdx_enable);
>>  int tdx_module_shutdown(void)
>>  {
>>  	struct tdx_module_args args = {};
>> +	int ret, cpu;
>>  
>>  	/*
>>  	 * Shut down the TDX module and prepare handoff data for the next
>> @@ -1188,7 +1189,22 @@ int tdx_module_shutdown(void)
>>  	 * modules as new modules likely have higher handoff version.
>>  	 */
>>  	args.rcx = tdx_sysinfo.handoff.module_hv;
>> -	return seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
>> +	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
>> +	if (ret)
>> +		return ret;
>> +
>> +	tdx_module_status = TDX_MODULE_UNINITIALIZED;
>> +	sysinit_done = false;
>> +	sysinit_ret = 0;
>> +
>> +	/*
>> +	 * By reaching here CPUHP is disabled and all present CPUs
>> +	 * are online. It's safe to just loop all online CPUs and
>> +	 * reset the per-cpu flag.
>> +	 */
>> +	for_each_online_cpu(cpu)
>> +		per_cpu(tdx_lp_initialized, cpu) = false;
>
>Since you have removed the requirement that P-SEAMLDR.INSTALL must be done
>on all CPUs, and removed the relevant patch, the "all present CPUs are
>online" part isn't correct anymore.
>
>And using for_each_online_cpu() isn't enough since this doesn't reset the
>tdx_lp_initialized for offline CPUs.
>
>One way is to just use for_each_possible_cpu() here so tdx_lp_initialized
>for all CPUs are reset.  Since the "CPUHP is disabled" part is still correct
>AFAICT (since stop_machine() disables CPUHP internally during the
>operation), resetting tdx_lp_initialized for offline CPUs won't race with
>CPUHP.
>
>And assuming this series will be applied after Sean's VMXON series, we will

Yes.

>have a TDX-specific CPUHP callback tdx_online_cpu() in TDX x86 core to do
>tdx_cpu_enable(), which will then enable TDX again on the new-online CPU.

Good point.

Clearing tdx_lp_initialized for offlined CPUs makes sense, but I'd rather not
justify this through "enabling TDX on new-online CPUs" since many details
remain unclear. For example, there will be a SEAMCALL to disable TDX per-CPU.
It should be called when CPUs go offline so that those CPUs can be exempting
from doing SEAMLDR.INSTALL during module updates. tdx_lp_initialized should
have been cleared along with that "disable TDX per-CPU" SEAMCALL for offlined
CPUs.

I'm not arguing against for_each_present_cpu(). I just think discussing how
to support TDX module update with offlined CPUs in the comment would be a bit
premature. How about keeping it simple:

/*
 * Since the TDX module is shut down and gone, mark all CPUs (including
 * offlined ones) as uninitialied. This is called in stop_machine() (where
 * CPU hotplug is disabled), preventing races with other tdx_lp_initialized
 * accesses.
 */

>
>Btw, w/o Sean's VMXON series, currently only KVM provides the TDX-specific
>CPUHP callback.  So it seems if module update is done when KVM is not
>loaded,

w/o VMXON series, module update isn't possible if KVM isn't loaded.

>there will be no TDX-specific CPUHP callback to re-enable TDX for
>the new-online CPU.  This means any SEAMCALL on that CPU will fail before
>KVM module is loaded again (which will then re-register the TDX-specific
>CPUHP and run tdx_cpu_enable() for all online CPUs). 
>
>But I don't think we should consider this case.
>
>
Agreed.
