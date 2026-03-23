Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE57185B48;
	Mon, 23 Mar 2026 01:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229687; cv=fail; b=iz1/ZpsD9v8LnYEeFHPg1nwpafTJQa/wgvNbEwFE/crB6QbsW387XF+JhBWZBEI9HA03rPBjFkOBYuAAQ6lS5ENPlk2C66i7x0Wne31tUOnoWRdbZJZdDZSZLJNn2sWJ8MqNZCihWcjgqbndbLMb9SBCJZdt0chPDIZCk7V0DYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229687; c=relaxed/simple;
	bh=CaxNzrS1SkdYs0Ya1J4T3bdqjj2G4+rxTqyeoON1bjY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qplz99nNjYaAMptLegodiFGunXuZbbstAqwUNpB2gGRd9yB+vkRvzaRg8nVIkf9XEm51oMidxD2tN4cR3Os1F1IxsHQJ7aGSWkYV+9Fgls6/RW22AF5utKZ+VJwOJ4SqLFqJ/jtMRmLhL47sc6VM2/LhQJTLaADRXnOvYhNGPz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnQcO7DY; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnQcO7DY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774229686; x=1805765686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CaxNzrS1SkdYs0Ya1J4T3bdqjj2G4+rxTqyeoON1bjY=;
  b=JnQcO7DYmv2wsVmNz7M9dZlit3cuRE544VvRq21EtBxZX7xbANY17g5j
   KHOxSITXiYU6TXY1a3rxdOq7rNFRJOIZEhmIF5/ToD0mHa/o46TgX7l2U
   2+0XFoQzfuzr1wL0Jy7DtcCdqEcK1yWl10x7VgBWsegbZeNG58LQ2QQ+y
   rY7gWL1Fr2D8viKuXDf+1H1RdeC4zhk7dyygyBVAvBLiAYoFXbzr8Siqh
   t0SWaDEP/Q5LG7Gdi1a4AXPfO95uzIVV56URxL3sx1zolIYpmbE6mKx+R
   51SaeDBWjUAc/siVmfpxl17fNhIi10eY6SDvq4fTlDPI1BDxUiLBTRhso
   g==;
X-CSE-ConnectionGUID: yRMnc+heQBKJnzgg+pammQ==
X-CSE-MsgGUID: i59oqODaQWeqb2CAnTZ5Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75348415"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="75348415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 18:34:45 -0700
X-CSE-ConnectionGUID: QJ6NvgDKR7Wb29sTOGggzQ==
X-CSE-MsgGUID: 6m+ods7sRte5Em0IRmse4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="228595516"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 18:33:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 18:33:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 18:33:52 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 18:33:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmL+sAcVz9auxNmauDz3QEJlvfgwLl1gDHdrS2kAXPVDAwEtULdEWGnYGZ3NYDtvBs9R9t/gBPST9zFETMEFu3a6IUfAQlZpd2n0UBccDc+khmZQxKYbmjmhZ4sjB2kRSHCJ6YimPSqufi1N9Wq0pDYvCZeRt4k5c/kdg8KsXWbMPTRBt0f8v4hbPrU9b0Vsw/EgcolShTFzh2djzpOczTvQxL4oT2n6zfjhV+E1NCFbIZ2WuKCF72iD97y9VHJb+mjedW4iN76N24KkgegQSBwZ4iDIOuJVw+8qAtrYmGawQiN2WqZ1Va86pLWTWmjU4of9CbtdIXNYHkuivVJUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V27UU/Kk779goy9LJvVkLZ7Hj9ZP8+GKxR9Th2gYuag=;
 b=cGttyRH5EWJEbi5RiQ4kzsO1kSBiBsYY6X7FvQ6vxv602ewW3ftbJE+3Bb0vAQE8rYjvNexWaBTU8E97OUSO8EbNSVj8Xv6kSlJenAIR8zxdCuMxTNR2FFwDlUgjlqVfYltQzJgekVH7W26NXiWUeh2L+nT4xjQlvnGzPuslg0Wr+b4z2A/MpwZIPTFb7cFBYIwxGXBkJ6TU9YWPrvCUxUGTyFg66br+yAhWDE6zDDMIhIJt1URxr2MoemFTFG/aR/8X9LUoB0kh7FlFjckkPoaRRBqDG7ocM9dXTCcFrsw8QbQfP8RLeEdUTO28bB1acpdADNc9VvaHSYSIgz1zDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DM3PPFBADCE1465.namprd11.prod.outlook.com (2603:10b6:f:fc00::f48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Mon, 23 Mar
 2026 01:33:48 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 01:33:48 +0000
Date: Mon, 23 Mar 2026 09:33:34 +0800
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
Subject: Re: [PATCH v5 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Message-ID: <acCYbt/PymrqfALV@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-12-chao.gao@intel.com>
 <abv4OWfqDOOLR9XT@thinkstation>
 <ab0DpDNQ35/xD6hS@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ab0DpDNQ35/xD6hS@intel.com>
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DM3PPFBADCE1465:EE_
X-MS-Office365-Filtering-Correlation-Id: d219359e-9d6a-4eab-6379-08de887c3b2f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 90r5dkeCHjXYjAUim9VSUZoY0e7XAj0dhfvopHAYk6O03ATykOgkZJSDWv6iM0JP11ZtttyzjfY8WmPjUj7rzubDyhbkOj3J3h7QBwpTE3Av5GtbBT8Mu5uL8ZvMdIQs4PT1EcBUmzL6xrXc45tlknyvdgtrbLEocL6cBzqsftgKbSAHFYVnZlUHrY3UsCSMJ0hdTI91qR2JmKAwsnc0FUH6tet0vcJ4EZFOBDQ7621l6zBGFxp8rjqxa3FMlvenGXXIyCYSOFiS9RSSJBdpvgtOwVGbp5NW5lAH79v6BqpOTSuJZWi/2GjyF/LPz+29dRFnWRP6xlkL1Aiu5/L4e2p0lCqpK7K7CAcIEmjABvBq+lH5g8WYfzYZPnds0cXKECwyXxDvydDSWghc80qQCVYzSCKDkxY2DqVqTaxGhomDq9kAbzkiAzgeYQ5rHCF4zazdiVMEsLupx3DFs2nb9nNnCrAs+qGYfuaidOiXTUl8Mhg23xjFylGYrKo17InSvCyTndDfAHtxSOpRP2sq7V5R6rq0vxPIpH1hNIIY4x2vd58jkEbLcH1nd+MpuIW/cXu/rVakIx6fu6sUogFLXLzzEeW10VjZTEt5K2rVha0r1L6ZE3nUXLETmq++NmfW8wU0F7RT1xZnQF3me3qHf7PrDd/5CpErusqheZ5jW5CpMRzawnJLNnOmFmM2S+686+nBWF+aG2wf93QmrnP6zRs2WACwlbq7h4KOkUTswNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sr5oBxm4Cq4u/m3KUE+c0RKS5Fcv9VZzOQ2Nqoakqwt7qSC8mHOswfVddK9D?=
 =?us-ascii?Q?R/IZCfYRP0OQxEnD5B3iWRrBXwRHR4RNI6iE0l+i6lNFH4JbbDxnNocQ5N0Z?=
 =?us-ascii?Q?DpPiAGjZQSe60np+ZFH7f4+vIuQiwPCOTWK60UzZJzb8qsY2/nlWFBzhbrGo?=
 =?us-ascii?Q?94Xo92jaVutIpndukCUnbhwnRwzQjdtsi95GVoXZrBNHR4Bzq61w6StVoy3m?=
 =?us-ascii?Q?bI9iY7uZWO4PA05FhfZGLnEKZOA26gSiXvZKmZEsxz7CvaxG1Lp/lV8u13sw?=
 =?us-ascii?Q?QXkTIdEcMLt7yWcaM/Ygr6v1xxMkag0NdePgBiysCRI6WVyEKGNYJouU6ZyH?=
 =?us-ascii?Q?JaEnXrFv0zz1zgGl9y7kNDGimEL6mkf2wFW0tBY3fUXPax6oADCrIisN8DnS?=
 =?us-ascii?Q?ClQDPYTF2OCM/htM8Q6kz5zIZWi0L80Wo9uzQHySSVgiY7FWVzZd5LitmlQj?=
 =?us-ascii?Q?MpFK7KrOJz6hkrfAXEP69GVrwyZr+CgYJQ1CXYtHJCtbrQbje+fhVRMJ/6V+?=
 =?us-ascii?Q?lf9WlXxIbObeCsPfqFImWTiV2NktpCy5idxeA2JDHxXN3E7gPskiVcAjL0n/?=
 =?us-ascii?Q?HUwJSGLVUwZABbZgIELeyuMdqGCiDLeRzL2WOV+kTjpULc4BUpsWN0tz8VUO?=
 =?us-ascii?Q?P3PkCs/sgO24J08qIvAIR9wWk9ymX++7ZtBpTHKXAm3q2F1xFjBKNSNJmyxo?=
 =?us-ascii?Q?k+Jy6+A0HFHN64UYdipdRcvEYzG8CguTY2eKXPH8E1a8WkxspVlKHQBQQxwG?=
 =?us-ascii?Q?p6L2q0rJn1HwBY9omVhPXLHmqnjH61NcuyEBcgs+P+GHOR4CMZzXBBb59HdG?=
 =?us-ascii?Q?dbgdudKoRd0hVp5bQSFxdReVCB1ZMikknu/Zvbw45XKODrz2wlYjlrBnTK1q?=
 =?us-ascii?Q?gmfwiSR/Sopjk+mXkVYJXEC4u/dDSlpCClIqGHppCJTX4/HXanKRaow4HPkA?=
 =?us-ascii?Q?IsTpS/mpMFSWnV0fazrzTBzuKzccBe1+Z88jubWAx4PIXJ/rs+EMnRtQqvA+?=
 =?us-ascii?Q?sJxJIsBFFtmL/0beVzfBj6ynsyOXTh+auJdBpcZ8CDolixVelMIVglfPDkOa?=
 =?us-ascii?Q?46d0vSBVdLZjxtFao/1x8Yas/CD5MVC0dQcEeiE4rMJsC1GpZDjz7zXcnfqn?=
 =?us-ascii?Q?URsBKeMUMoOZZQaZjGZUiDmuSkVKyMm549Tu9t3ynd+jnHp+HeKFLB0lGjs4?=
 =?us-ascii?Q?qpwEhxf/CDu3YQetuNuaiZN/SYtfAg37cMMpeYdwlszi84FEcY3yBr2ti5nH?=
 =?us-ascii?Q?44gtUOfupfV5cm5p+E0foSJ6xns0w0MxN168imAQiZj440kzhvyqxvgO07eS?=
 =?us-ascii?Q?iKvctsw5bYcArEXM4aLXNB6JCvkwn8s2bFL+WCvo+1EM3ObY0rP/BBXruDOE?=
 =?us-ascii?Q?Rh45t4S7CHJsLM2tXs0GVzapo0+FVJ0xZn80bDFbPjV/A5TI/zY/LRWWxrK5?=
 =?us-ascii?Q?bHrGAt2To908m3RHehd0w8X9Sy6uSf9EgsVlVgbAE2AtGZKoXIfpYM1d1KUB?=
 =?us-ascii?Q?eE8TOPAEuNQzR4R/Ji6Oku+q/ToW2Ap4VZCoFylguY+A6CT3QKdVmKep5xQG?=
 =?us-ascii?Q?NMdp9HIdasAkIPBzsPZgOwYACcLQQztNDXKlSd6SlPxxlNai0gi67PAjw/uk?=
 =?us-ascii?Q?zKPhkULCrqPetnrcXdNtukfo9WsJqcMFdexuiTPEdpdY5QeS0Ji09zpuCiHd?=
 =?us-ascii?Q?b3ux5IXpb1AtVauTxDhk5hFjY4NkAxuHpPxlY9ggMFXBnYIxtjY7MU3FjnQg?=
 =?us-ascii?Q?CcGcOmDE3g=3D=3D?=
X-Exchange-RoutingPolicyChecked: wRfrQv9c9MKVOY61ooboXTUKvVF9GES45zEur2DDbunO4SVl2J/eP/yfRpfn/vyRlFdMrRL2SEXRk2NxS0Rd/dhe7vLnbssb/yQuij/V09/am82UpF34XOkzCVFx7fLh1sWklw7vpKB1CqRW0vBzCuRfp07DfE5GzQcAjIoOOXbhU1tCmjPXP0bjpJkn+CiQf6c0t2XRfNpT3mVmK1leIQGibTQmh8/5QNY3pWauX5AJWCVMqX+0JobEnTh4/VXpgnoeRl23QyMi0wj+8ucSxirpFnzIdi+iw5zqbRR+jUIVXzI3+fX1g2GyBAXb8oz4AoMbKY5rcC4+TDx1Nq/XAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d219359e-9d6a-4eab-6379-08de887c3b2f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:33:48.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr2RmgevKZWRj6SUrt8yDyP/Pwcywl2wlZ0t41WrU6Tqxf6VrIMfR9Z5ijvAkPcZQkBz3YCv6XcvQcBTNFfbFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFBADCE1465
X-OriginatorOrg: intel.com

On Fri, Mar 20, 2026 at 04:22:10PM +0800, Chao Gao wrote:
>>> +static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
>>> +{
>>> +	int ret = 0;
>>> +	u64 val;
>>> +
>>> +	if (!ret && !(ret = read_sys_metadata_field(0x8900000100000000, &val)))
>>
>>!ret check is redundant as well as the ret initialization above.
>
>Ok. Will remove them:
>
>static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
>{
>	int ret;
>	u64 val;
>
>	if (!(ret = read_sys_metadata_field(0x8900000100000000, &val)))
>		sysinfo_handoff->module_hv = val;
>	return ret;
>}

While making this change, I'll also fix the checkpatch.pl error:

	ERROR: do not use assignment in if condition
	#23: FILE: arch/x86/virt/vmx/tdx/tdx_global_metadata.c:108:
	+       if (!(ret = read_sys_metadata_field(0x8900000100000000, &val)))


Updated version:

static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
{
	int ret;
	u64 val;

	ret = read_sys_metadata_field(0x8900000100000000, &val);
	if (ret)
		return ret;

	sysinfo_handoff->module_hv = val;
	return 0;
}
