Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBD3E7152;
	Tue, 30 Jun 2026 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782801420; cv=fail; b=ZL/9rQJgWMu3NtAKudg7Vlaq96yksiJBaT/pl33z0UkOzB0rrBtG1KkzSwjXJUe4AbANV9XOFCPMvZ37VvGQiAWypy1BZxa0K5UQLx8x71K9hc46be0nEVQ3ZrJQTGCGVIS9HCdK3f+8XjJLhX344t6DBHSPQWT/0fMW2q98vQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782801420; c=relaxed/simple;
	bh=BE+QtUHxRMzUu+Ykx0v3v5j5j2VVN+NgSjwNPt8yUWI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QMs9VU/rnTH1KB4aecHG9W5JISKW8e7UNVKnIraf8bVygcBlNMezqICkXNy0rxIprnATSBL08V/KIaNd4UGw1qd1saBJ+22MSTwGre9MarCQzlhgd88OpkdMhXlVmjtxTizQcJD1gXm/DBs+d8/CV3DU3TGSfKJx5gqVaBzkuFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMz1EHOn; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMz1EHOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782801418; x=1814337418;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BE+QtUHxRMzUu+Ykx0v3v5j5j2VVN+NgSjwNPt8yUWI=;
  b=LMz1EHOnuH3bOmZZUWeAzqqB+sTow4W+6zbT4zn5GmVjrG8wdE2Nqhv6
   VfQTuJDDxXu6rNmN6izueLh+UQmln0CjsKjBU5L5YXDDYdKkF1AvlWU1m
   COslUZCps9jU5QPc34hqJo3bFxKfrNcAq/kQBaEY/r86udHe8kOmWOjU8
   T3r5yA+69a1vdQmamVMUvr2IxFLifNMV/qHwNJrnLfCa2vQ5dbiN4DSx/
   LuAtkRSKQYfilfV4v9UMsaILNlSosO1hciO4z+gUstIts2gy4EfnegQFK
   IFyFbwSa22H2JlnLquKiFKU5mEReYwTp+hx5RjMJhyzLFZpouHPPgkzO4
   A==;
X-CSE-ConnectionGUID: 5YEjnVE2TeWvlqBT8raCpw==
X-CSE-MsgGUID: n5S8QYqkRAiMK1EQnyqcZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83281606"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83281606"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 23:36:49 -0700
X-CSE-ConnectionGUID: Gu5ziVgXRsGefrh/2kEtfw==
X-CSE-MsgGUID: 9eKK47GBTNeuoCa9kmyfiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="282239084"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 23:36:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 23:36:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 23:36:48 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 23:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h75+4CQGCVsp2QqUrQ+Mi7ZsbgTAnUMJekxGxQopraxHFD11ym2QdriLJyp/X9lfcKn8nX6R4rxdK6FiEYqXkDJMNtKMi7fCWAMKgIpC143ILUvS6uyPID2sYCR08HodLzokvDSa/GHFWQmYveo5zb+a1XJAIJt0JHysGm/DOyupNtxgJwXE8OD339U63jWtA5DTqOJd5cclSxMd2tZKl5OpPktlcA4X1zz9FjLuWzeLosj4x5Ou5wi/paZe6cPZrDkW2r8j82A1LYEVAJr7HD9qPBx9bzGupE3E7R9d3iLiXCzfwRLGcfHZs/cK8dWugkvLnEVyEp6PRB9z6jNOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtJ6QdW5peXwoLZPbE6BOXXg/z8a2xAn91RcRJnd2+E=;
 b=kxQ8cGGxQr+WJTQmZoaC1U/mA1nJXTbcGUU+16M7UFYzFk7NO/a+d/W2JpimE5dwiFN4tKHzCXURwZmUNQ1QLgR3f9kZWIH7dCzfcECV4Y0pMgpmDo4mS6+JYPvBZtCYHbnxE6rjSLsTq5esta3lnymDhAFtcYhppSa1jV7sJE0m3pmK92+6ZEyl3TyG1HMKUQNNRhP+743AZWYUlB2lt0mOySCDZt0cS/JJoAd7T3vl95azAKNXfTOT7e9W59/OYsdEyT5bWl9MfYij/uC0S8NychL6zJ8zzvC6e4nFmJeLNOPKRLZLcOOXnZYx0GIguhORVFpkLawI/vtfT/GeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DS7PR11MB7783.namprd11.prod.outlook.com (2603:10b6:8:e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:36:40 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:36:39 +0000
Date: Mon, 29 Jun 2026 23:36:38 -0700
From: Peter Fang <peter.fang@intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <dave.hansen@intel.com>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 17/17] KVM: TDX: Support event-notify interrupts only
 with userspace Quoting
Message-ID: <20260630063638.GE1743876@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-18-yilun.xu@linux.intel.com>
 <ajzKl4Ov0jdXvH-o@tlindgre-MOBL1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajzKl4Ov0jdXvH-o@tlindgre-MOBL1>
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DS7PR11MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bfd9f9-f93c-495f-8259-08ded671f0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: cyEsOg0QUsy18B4S7+UiXnpb8resHiI0fzaKapplcX3NfS9edFc1wd1/+5LbYWJLnyiskPCBLprp89xBBbWzBPRr5uXarLSLSPKGV42y93FlOLCg0rH3V4eKVsHwRK24aWyimvWyzguD2SXCb0PBwpnrq4oLrprkUPBzUXsj9HJOg3uUjE6TgTuNegI9hHTFxjmqN1UND/HvN22JWDvnQOK/66gaWxOjh3tZMHRtnytVinmH9KdZ2DNirI310df1oql0yzyj5JE+SQutskY1YXL7CiWqqliKHuCZyfEymutGLI/JcxGfzjgYNcaGr90CjyWqowIjkcy1Pk6nP/VV9qdb/OKLfyTQrhHh5VDufXeRkmEAOYSw2Qc931FelgtmtDNhgoyUsW1eJ3Ues4gJ4mvy3RTknY//21X/FrWoBhxnF/CtYaTg7O0YGNCP5c+Nyp8F3wiJZ8hBJB1gG+6gxZfy9OTbh1/xaX8TfZosf2uAyvcYXl1EPaM1BSR4JmnaC8JJ8ot5Gj8FnlaSaXdOfhoFMsFyctJUBUaJ4jSKxyO5uxs2XlvuiYt8eqpvwVjQN+w9HnAJAB53fDOVDqup5OjP5JOyNVQnc061z9vsBE38WbEhHBljR7ml62XeRqJLJVb38wZHhMoLvk+3Xb7cd+ra7J8c0p4NsMHA7S54/So=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?US9qIU2dzoQJJmw5LvSghc/V9dv7HSoLzLbRCEPt6IYYwbJL8tYLBlnO5ITn?=
 =?us-ascii?Q?vosJKcVC/rZnQz5woklIxSRqPSGEF+azRhsG3fqfJEXRw+TqRAP+3YznYHE3?=
 =?us-ascii?Q?R6gOBDV+FdldDeOv8p0dt4uEJVvITDfQARq3wqXge0aMyLUF/+Ab2jzog+Tu?=
 =?us-ascii?Q?wxa35DgTlwd5dz46tB2gIahnBusX+mnYBteXwq6yIFza3hqFngFluz9XFQuY?=
 =?us-ascii?Q?yM5DnqG73BEj5Qy8eYOB+gwRCRUZ68dd87VVIZZ+Lr09xG/H/s6tUVy2+mDy?=
 =?us-ascii?Q?jbFaCskL4LVHzT864ZlaGiO/XVBePQ6lpdEygyCNK4bzOodCYhEZn5CgVse+?=
 =?us-ascii?Q?pJBfwYfE5hhN8qgSEyBJRSQD4I7iL4ekNFvpMbQSowM9PTHNDv9tVtbJWN80?=
 =?us-ascii?Q?kUTy2NWbiXOyxAo/3GeONuIdQ+vWEu93dfPf9I/fjGvybDkDu8ad5YkQW/3M?=
 =?us-ascii?Q?jOMQiSG1CC6wBTmDiRR23gO+B5GnjYm0bdB4j86bJUXGXSDKrDE+/mhPnMJv?=
 =?us-ascii?Q?hkdibM8DgX7ruQs6Z4RarviC7qjV16HfZoEvpYrlzUzcN82uRt5d8n4bC25c?=
 =?us-ascii?Q?53SOq7zFUCK7gN0UivArd8YLBB+9NckPxDdIu5zRjqap3Pkv8m/7mRyKjp90?=
 =?us-ascii?Q?c7ajHKYU3jeruxMpRTIz3g/oZ5+if5hqzHJpaWfDCbaa9FKmOfjHjLt/y2ZI?=
 =?us-ascii?Q?Xck7ql8Mes2QzljLUFiLxUqjQsPoARFdrpH0DRoxbPdzofZORfc34KHy+RZd?=
 =?us-ascii?Q?pDOXFGXZ2+sjZdEdoddPwF7r2HIUYP+/fjuTC4jkFHOsD+fPQMQSyXWCb9Pc?=
 =?us-ascii?Q?hooc3mHurXkhQNCHFffnaYCUqceRKvSzqb89jhMPrsLuTDd7bcA+dDkoh6HZ?=
 =?us-ascii?Q?ohqx0Fs4iLiM8jFbuhDLlRZndb07r7aLT4gZ5ljyb7qHbuBqDU06vFNdVer3?=
 =?us-ascii?Q?K7XRv35zOxe7NL6kv+ROD02Y4uWX6yTUVp7x7hX2bXJYPub8F/sBd8pRn+Y3?=
 =?us-ascii?Q?VY5eWg0GWZ/o17n7AqWQY6RAbKVumaWAO6EVe6cQBeODlXkJeiluUyBks10y?=
 =?us-ascii?Q?UrSeFGqyRMw5Uv90CcT2pOBfzaqF7YOkO76+LeUt3DjjASvavaj5fi8ShEGn?=
 =?us-ascii?Q?k7Pe7wPE91ULv1dDt3KehIFoB75VCYxn1XRlrSFimVERby0gT1QJm2wCg1hK?=
 =?us-ascii?Q?WGjzS6CXgk0p0pGq4VqGdV/LzQEVEaYfxC0lxJZ9tEOcK9OL36xskMusiSwP?=
 =?us-ascii?Q?SmVqkb4d7N7qn50crjzqbxtUaiLQKCOzLbrQrYMp58+Pemu9asa7whIuIQxn?=
 =?us-ascii?Q?3AcpGON11msmDoWf6+n0IrcivFaVt24xIeObHfbadaPtCW7YZDlnVexFCkZp?=
 =?us-ascii?Q?nn6BTytQcTCwJVgULE7kwhEIvVKK50em9Xbs2YDQDvEEi5zvYjjHEHkyKJFF?=
 =?us-ascii?Q?iHH/s7iIaR4vxSmG/ERPk4AXPVZBI0TYgKZ7/1pQjH10hFGucgBRvxc2YYXU?=
 =?us-ascii?Q?Ye/oy2v7NVTw9HCOFKD+2gUz6sOQ4jgdClyC10PA+KU+a3LlvU5NFgqfJIbR?=
 =?us-ascii?Q?CcT8t93ht+4QY2Vb1iRdv+ZgssL4rvGDkoVjHBImF6Lbv9Nes84Wimo5Ye9+?=
 =?us-ascii?Q?QfLYoIU1T1cIRj7mcGmUERit5XWHzgyNiNhgCy1i6Q7viE8zRQoxw//L0LBw?=
 =?us-ascii?Q?65YgAk5Y5qZzog5eK7zO/hlMy7fL4dH65qF6c5oliCAmIzgvur6HUG5iFp2W?=
 =?us-ascii?Q?UV1deQKxqw=3D=3D?=
X-Exchange-RoutingPolicyChecked: QoY902UOEB7IGdwosjv+CrA1C8sJRNNqJoo6dlWmPUbmp4HFMGUeJXDCIFXYeoO/UWLJm3AHT/EKNYmVGgrDh4eWRuRw6HZIN0YtXknDBbETkU5OanE62cj/VJZxo0gKfNHzlwJ5PtgxonItxBhoFR71V5q2TCPeaypFl/nCB3tHnIbl6UPkUFcNljNKGyXFhyRHwTMP+l5XQUiqpFSkizTYePAeOCI+GTz6YAQhXve1A2w4s+z1POK7kPQP3YHBbztg0wiP1yVcHiEx5Kk5fXF5rm4W++Q1L0oeg0I506SD8jqJ3UL0pDIC3ZeZVQrCzo5rXBfYeUMZL5a5e7Prdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bfd9f9-f93c-495f-8259-08ded671f0ed
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:36:39.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vYdqLScU2hl6TLZ94BfgGN8k68vjzlwUu63ARPp4b6u9hDXQB7u81sVnV+4IL2GXfzuj2ztCYYUE77LKuXxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7783
X-OriginatorOrg: intel.com

On Thu, Jun 25, 2026 at 09:28:39AM +0300, Tony Lindgren wrote:
> On Thu, Jun 18, 2026 at 04:13:55PM +0800, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -202,8 +202,15 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
> >  
> >  	caps->cpuid.nent = td_conf->num_cpuid_config;
> >  
> > -	caps->user_tdvmcallinfo_1_r11 =
> > -		TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT;
> > +	/*
> > +	 * Don't advertise userspace event-notify interrupt support if TDX
> > +	 * quoting service is enabled, as quote generation will be handled
> > +	 * entirely in the kernel. Support in the kernel can be added later.
> > +	 */
> > +	if (!tdx_quote_enabled()) {
> > +		caps->user_tdvmcallinfo_1_r11 |=
> > +			TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT;
> > +	}
> 
> Can you use kvm_tdx->get_quote_in_kernel also above? Or should it maybe
> be initialized here if not used earlier?

This is a bit tricky. init_kvm_tdx_caps() is designed to be independent
of a TDX VM instance (it reports the overall TDX capabilities), so there
is no struct kvm_tdx available.

>   
> > @@ -1684,9 +1691,16 @@ static int tdx_get_quote(struct kvm_vcpu *vcpu)
> >  
> >  static int tdx_setup_event_notify_interrupt(struct kvm_vcpu *vcpu)
> >  {
> > +	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
> >  	struct vcpu_tdx *tdx = to_tdx(vcpu);
> >  	u64 vector = tdx->vp_enter_args.r12;
> >  
> > +	/* See comment in init_kvm_tdx_caps() */
> > +	if (kvm_tdx->get_quote_in_kernel) {
> > +		tdvmcall_set_return_code(vcpu, TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED);
> > +		return 1;
> > +	}
> > +
> 
> Since you're using kvm_tdx->get_quote_in_kernel here.

This is in per-vCPU context, so struct kvm_tdx is available.
