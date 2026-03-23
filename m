Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE6223DCE;
	Mon, 23 Mar 2026 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774232104; cv=fail; b=CYbIVVPvwMdozR193DF2R2wIPx39w3u2xcdwjyoSKJGKwmZ9db2AA6ObUTsWmo6Wef8hbU5JASF9FGwVs28JbwKhDJPFElXX5EIjO6VJ7o1+fMEMPo5XG2dTzbMKuHwS954KhkHNUFVf7Y2ydMvlm6yDD3hKB4bb2NmJgCpYJdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774232104; c=relaxed/simple;
	bh=idSI3NDXqoU9sMneh5RJBR4gOmgHFhF5PbRbvPNZsAY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ko2nk9hW04Y43MO5bD3HLZODQJ/8MFNi5CunmbEas0Co+IkuMjGIb6A1dDIjkxmRAuCvWr47H7LcVhwOGxYNJF4iwrRJU8IaQMn1UUOVPhRKiBADF2QfqBBHfiUKbFR4Zdft6Wp5g6A5lEUbUSIdmBPHQOVLyE1tD6Wnf7HhATk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Do0tn+bB; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Do0tn+bB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774232102; x=1805768102;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=idSI3NDXqoU9sMneh5RJBR4gOmgHFhF5PbRbvPNZsAY=;
  b=Do0tn+bBCDiBfxWnFwi6dQkmDiTPZduge36ZcyaLGzw/gyVC6WdYuk8o
   mAhXDWGP9KMJeNM3AyO/Se9UuqmuGT7TVXOQqUmmLI6Aho8oUEaGCUUdT
   0fCjFeT09Tvjujh0D2mUNlgpewvJTqDOquZF084+mHLTnIOpz9VJkFrGH
   n9gF+nksDSSK4qhHDJHm0jQXuk2nmCDMTW3ilNASxyRxp+u4y1igPRjuT
   9l5CEEy3fUMFzQk9wHkxVm1g13Vo1dzVb663jBnjgjuRxTtrdtxMcT1r/
   N26N6ZJ2zxpFdc27K3QDI1Wd2y72/PPLZs7d+jk0Oq2yMsgxzxnVlIifQ
   g==;
X-CSE-ConnectionGUID: f/5j7BGQT1ecgbn6aEcz4A==
X-CSE-MsgGUID: W5ugYWr0SRupfCg7Ls20iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="86300015"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="86300015"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 19:15:02 -0700
X-CSE-ConnectionGUID: Htb2jnwnR/SHJBY4A7Jwfw==
X-CSE-MsgGUID: /YzJJMESQX2RftgqdO5S8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="219104940"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 19:15:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 19:15:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 19:15:01 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 19:15:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTJhUwX4IsbRMIESiTft9fO4t9QS/ztZIILuSIwK0Wbc1eloWL2gw+stLUCpmu5Am1evN2PQcnr1cb4DagWgxYZzkLpgTupWijlruynXb5whg+uLI09eLzPAAlfFawvSoYd/CMw1oDCYlyajMPDUJ270Mur/gXQpyUgvi5fdK9GmMn2jNRNcT3HZlc+10ns1h2mYWWu4vmDMjXRNBRA1kTT4YeHk42sUccp1GwPKyL7sj1BTFVIYTG6QboBcG0cbvQrjBSsatSPHKpmElKo6uODg0uDsTNWYkgcP7K8naKqlzP9p+FuL0mrwRL6yx3JaAQTqgZqJr1GE46O4jYe/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2L4CueYAXocYvUYVqBSIzAQSZdFWcnL5QR/dD1VfeM=;
 b=kCdK3rivNWh69Z+w7tE3LN1WdQgv9XQAf7gW5j9KJr+Rz7qJObesHI4JdTYACXJ7UuT6iiflz1nFoDqTHHnXDpajIHb7CnYxa0TPGY5/bKwpAvJBKLZyAY/M9ZMIiXUAEpaQ0kY4vrFPP/5VipVWvzLCxLfbrSQj0v6ecC5Qoare40yHkA5p3CzQ8ddwsrOIFoGml9njpU3c6kFwhlWlmbMS3Vn/EbwK4L9kJ/vGcX9eHtd8Oj0QqaGfdN/1pRPP+EZh7pcFq6M1jA0A4RM5PohyXZHCg/EMwAr5WJ/61kcjCKRviWSM13zh//Prrrq99nmE2bllVUGB1mSHLZc20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CH3PR11MB7940.namprd11.prod.outlook.com (2603:10b6:610:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 02:14:52 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 02:14:52 +0000
Date: Mon, 23 Mar 2026 10:14:39 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 13/22] x86/virt/seamldr: Install a new TDX module
Message-ID: <acCiD6illR2qRidT@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-14-chao.gao@intel.com>
 <abv6fT8Rvk01DGah@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abv6fT8Rvk01DGah@thinkstation>
X-ClientProxiedBy: KU0P306CA0062.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:23::9) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CH3PR11MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb1a5a8-2898-4346-048b-08de8881f7bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6US7kKJf1peC9jTmKGx8uaXPUEPcQuwX4SinLPcF2OIwvlwz4HYLSKRmcRt/Bde462TQxCHSZVo883fDBXpPO+V9zB7vEaD5eSSggIfzSW17qCL1RSluXjf5bRBLhG/6NsffCFyZGbEtgQtRmSQhHg8mLvxvtx2kw6jUIrJNlKWihO2dVZdqkBSjXMPVkiVhpA1M7woAueSu/fyaruSe0LCPbeGlL1MOp9QqtWIqnl8cqXo+S6Li+DaxcbnzRGJ2UOndCWmy+x/1R01oQxcr0m9AMgHigg8uBzdCGOPlJ5wWoCoNvFuAv2HkoCB8qM1YKhK8MsVA/UNz1YPnnkbkz8oyIJsuI4Z1I8gjygb44Oek6KDv1efsvY0vcRt7mFvHX5o/hqyWRLILsYOstCiPGdlX45N3RSFzVCo7b+sMTX5YlIQ+UKNpbM6WeS5sDuLHPTQtmCyywt3exMdJz25tjUuG+eKonfrGD40EMlaFmqopOOdO0tsvkS7UbFc5PlImlYrA21NJwULtpVkgDO7ybq1peMSJHRHnNGOmqhtXtCjOjgZn3n5CE6QXSInyeJNTQ9UssQZDOQcLSuNyPvSGIsjMmb16LdOolE183IbJlRnlFMXLhxwTH9qODsZnOZ4jWaUANTVzBDEy1tqE1i7c57vyp34qapvRPKVZRoQSrqkrWaB5MaSFBOnN7pltH0aAF1IFgvyOOLkHUv4GvYbsuKL7MrfvMcbQgcok9XmxW3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWwaIHVSgB58x+LJWWIj+jfrSpCMCZtzNZHt2IxnBuvMcFTwhCDUp9ffDOjD?=
 =?us-ascii?Q?cVyyO7lELx7lG9wX42QDmzEcnI2CCi4GPydXdidxvLlwxMRFGwP5BoafFnYj?=
 =?us-ascii?Q?7jsGZO5NiIsYAVw5wrkJzTB41lXUo/vZqsc4n/WpIQwtTFOwwLtczbC53ZdI?=
 =?us-ascii?Q?SY4dXu5TgyMPPZDN1F+QCG4A0aMy6XtiUpcerDEaxP6s8kIdZzfURE4k7EKn?=
 =?us-ascii?Q?VZ/2WWdpZrN6ormKQTOyyoZneCgN377PA1qhBcwVE8W1iBtMJOU2PN8pqEYm?=
 =?us-ascii?Q?WgZaIbqUWly2ac9+h+0SFz/sCPF7k+IK8POyXo4nIJhykKfmnwit5RIbrYE2?=
 =?us-ascii?Q?G1dSE0DVrAvOG8jET3jmDPa47b/TfCGniqPkvUphejGWXcLrLHdN4H4NoKHl?=
 =?us-ascii?Q?iKBdKFfOeAWx7sVspYokFMhUAqlAQT6yaAySNLEvPoE1eri4Ck2LgPZDI4Xa?=
 =?us-ascii?Q?uQABaGzQwgCQ/IVuIqy9udxEGJ37dhLWqNGM2vXXEApcqrgNtwy+qb6dJeLL?=
 =?us-ascii?Q?ZxIHvxPiZ+mvUEzxn6haeI0wkeeLi0CZ8HFpua8b+/g17gQAILSm5KtroV1P?=
 =?us-ascii?Q?JJoV+TARJ6EUUHs+YELaC4biaayAIJ0w2yK1/YgIG5QVVC5W6R1A5WwCPmhX?=
 =?us-ascii?Q?vTewXLozqzeJs0MJmXn2v3jIpmD+OSCBnFB8pn6IU2ZSInCa07dMN5eBzhd2?=
 =?us-ascii?Q?TP3jMI6RK9446Uu1djG5PZn4kphzIAdm8xzo3N4OmcFA40JbPfu0PBzhdjhj?=
 =?us-ascii?Q?Cj0D+iAF0FxtTNhlVCxBkAKzn9jVCNYTB0f49954G5yG+Y5KeuXZJmUFELug?=
 =?us-ascii?Q?DskYoNFjCiXgFFoB53bJmcM1XDr1Sm5QXNijrz+wE8e98QkFvD/LZGa9NcfU?=
 =?us-ascii?Q?cz22x7tNzmlllpkYyGmxQ31rNzm61HnitWNDfIFhOVN5OF/wMkEk2qDgR7FN?=
 =?us-ascii?Q?+0LKLYMmbwQxsIr3K3M91vTJNS5qbd96cnFSPwbofCtkGiAms1ne8M/jUSEz?=
 =?us-ascii?Q?vJBBhlmu2yy7oCyHlqoNFMEnnBOLgZRPpjFHI5FBZ5R5TwwsdJEnEZ/hOSrs?=
 =?us-ascii?Q?fT5YmNUQuAEZvmYCqI6cEavn/ewfq7Dqh3DEmyq22o9tLbjniBi9o2r//O9A?=
 =?us-ascii?Q?aeJ0IxMrch9eawhfXNRddk3n25HMRQrWP2MN4NhLb3ncTUjqrrwQ90yjwFk9?=
 =?us-ascii?Q?DF7PuX9ZVbOL1t16IBEUIb2lXxg3clC6hZZ9rf+OvDmokVypdbHSD7lTcQFk?=
 =?us-ascii?Q?pO+1Ho2ORUUnHRLLS4scB/inGnfNtv+/vZnHk1j2Y8b8By/77ySO2L1ymRzg?=
 =?us-ascii?Q?XYof0fAaj2oeZzfHbQd5UNGNaa8EfF1ReRCxFFBv+NrbLTQFdzLB3TED62xd?=
 =?us-ascii?Q?rzKdLQyQkxDbpds6O06nFAb4r3VxbIHXkez5qASUUNbuM3qQOzzcAVNeGbnv?=
 =?us-ascii?Q?SJ+ntxDK06dJEzzMEs+lpqPVNa0Qspl6/8FsoM4jaPodHXAWe/VNxaG8/YTZ?=
 =?us-ascii?Q?m5Aod2R+Dq8emR/CpKEVedYgQS47RVJ9WEHcYhCj4Fsmy5DvwOPX4SMxj/Zu?=
 =?us-ascii?Q?gzW+SNfgENtp5Y2SsLBVVI51Ss2Nvoyoc2NziMFjLwbAeWQjDrtZsTnkZm/c?=
 =?us-ascii?Q?H6G/yZoMq4ePv0SflJcQ8sOljNPKZBdIgjQUFGF8HY+inX9gbjzGIh8EFuZc?=
 =?us-ascii?Q?WUhbId4L+5GdkwqRreda0UTn2PB+QHZA3cvNDPo+Tak8f1iIXnLqsSKcB8P/?=
 =?us-ascii?Q?DcXuuEujpg=3D=3D?=
X-Exchange-RoutingPolicyChecked: FV2P1OLmxws/u6bV+DEa4HjGBpbgPkOSTEp9t+M6/yU8wcnlYIabLEOGNXt8POMkA594+eNGX8OCU/XxzgOOO6O+fhWgusaoBSbk+OOHeAmwtztmI8bnFTc1zIup8qFjSRuqgV2lC8codKbik30JmUxy6Pau5RxRQn0t3TnJkwfPtPolTARGgprDy2VI1Ysf1C9a6sSbVIW73tGH8xZz1V+TTaE0Jr7va8j1nW7ZnDTJjV+8WerZ67V2qbjK86W4EJ91jJBVG0KOx4s+FKl75s5mdw2IA/v0v8KpFIxj6vdMXyIL4XChW1wy5vqv0IF/7YPHKZwoY3zmXKOTfOZCqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb1a5a8-2898-4346-048b-08de8881f7bf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:14:52.3434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4Qe209hz494nhXfdX9z3SNWLJvrsF7SIZIck4ZQr1l03B9cTxHr+AzOlxtAE3GB/FWl4c9WjiKKpumvmaqLvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7940
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 01:32:07PM +0000, Kiryl Shutsemau wrote:
>On Sun, Mar 15, 2026 at 06:58:33AM -0700, Chao Gao wrote:
>> @@ -225,6 +227,7 @@ static void ack_state(void)
>>  static int do_seamldr_install_module(void *seamldr_params)
>>  {
>>  	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
>> +	struct tdx_module_args args = {};
>>  	int cpu = smp_processor_id();
>>  	bool primary;
>>  	int ret = 0;
>> @@ -243,6 +246,10 @@ static int do_seamldr_install_module(void *seamldr_params)
>>  				if (primary)
>>  					ret = tdx_module_shutdown();
>>  				break;
>> +			case MODULE_UPDATE_CPU_INSTALL:
>> +				args.rcx = __pa(seamldr_params);
>> +				ret = seamldr_call(P_SEAMLDR_INSTALL, &args);
>
>I think it should be in a helper alongside with the tdx_module_args.

Will do. Here is the updated version:

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index bb4aa6327eee..cd2aa2eabb65 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -19,6 +19,7 @@
 
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
+#define P_SEAMLDR_INSTALL		0x8000000000000001
 
 #define SEAMLDR_MAX_NR_MODULE_4KB_PAGES	496
 #define SEAMLDR_MAX_NR_SIG_4KB_PAGES	4
@@ -72,6 +73,13 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
+static int seamldr_install(const struct seamldr_params *params)
+{
+	struct tdx_module_args args = { .rcx = __pa(params) };
+
+	return seamldr_call(P_SEAMLDR_INSTALL, &args);
+}
+
 static void free_seamldr_params(struct seamldr_params *params)
 {
	free_page((unsigned long)params);
@@ -186,6 +194,7 @@ static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
 enum module_update_state {
	MODULE_UPDATE_START,
	MODULE_UPDATE_SHUTDOWN,
+	MODULE_UPDATE_CPU_INSTALL,
	MODULE_UPDATE_DONE,
 };
 
@@ -243,6 +252,9 @@ static int do_seamldr_install_module(void *seamldr_params)
				if (primary)
					ret = tdx_module_shutdown();
				break;
+			case MODULE_UPDATE_CPU_INSTALL:
+				ret = seamldr_install(seamldr_params);
+				break;
			default:
				break;
			}

