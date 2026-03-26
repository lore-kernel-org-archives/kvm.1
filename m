Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04CC264628;
	Thu, 26 Mar 2026 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530223; cv=fail; b=hrMtKqKpqT2xS7jdT9hQBJPpbjlSJHick/OrQbGSum5enWiRjW7FgxNqhHFr/IMIVEEM2nZNpjvd1PI3EflCtJUvEig+/x4PjtYzPj9aOYdWIaEWKCLV0RJu3YNZSt/KdJSxza7MX1wVNLA1PbrCzEfJkrlQZiceg5oeGNUag9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530223; c=relaxed/simple;
	bh=tCgkHS+GKAioeTycHwXMU2nI87Y0UdcmQH80/IYXueg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SGzuiOlnM8085mPtR/Pc7u2E0d9SJO9pABMq5D398z81zKjOm1QMhSDNgMECerSqCF8rUp2R4vdtP1P41gsHU7M6iHcGBFhB6PCU9KbVHwl9+3kP3RkydjkglfaTF1qNZKNGxh7W87oFuud9ECePaHuHzIwh7F+hJRWC3C65aAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaBCRZmj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaBCRZmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774530221; x=1806066221;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tCgkHS+GKAioeTycHwXMU2nI87Y0UdcmQH80/IYXueg=;
  b=NaBCRZmjL4FszS07i4QNb4IolxT/1digDZOzIxpYCl8xo90kXe0KnNJp
   pGz45s3wDWr+ZCsofRHdpfKwHkNKWZ3BkouafLv/43RGhj1MgT0Iambsq
   DZ22PuDDXFhQWdkj9EMJXuebjr2HM2dL8WlzvXeFzPoCcDbAZq59HZSCd
   MrajPEHJt7bH1Y7sJI5T93OVmMn6Mx68XHCjB4jJC1f0NVDWpgCd5pJtA
   E+eY8ebO3ggO3cv7VQcrS1poaeGJiNkBuP71UVjDq+Czchaqd6meDsZA/
   ddjZVqP/KFF/SsaHzztIxtNQdLdrWQENwREFG6455E+jIGRfsgtSRTzi7
   A==;
X-CSE-ConnectionGUID: KKCZhzQIS5W3IWJ0z1h9Ew==
X-CSE-MsgGUID: 6U3ok0qKRqCIu+KC23pK3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="92969310"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="92969310"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 06:03:40 -0700
X-CSE-ConnectionGUID: TlSr0Y9+Sp6sOqOQQc7ngg==
X-CSE-MsgGUID: Ry1uY6jTSDGfcU1CG5dgSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="226635735"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 06:03:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 06:03:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 06:03:39 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 06:03:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY3IsjRQCI4wlmSDXEysMu9schGgc44uzcr7gNVlmI9Q8MvPEW9lgIcQSz4wM3KR0mdRgk1YwzZO7yqFwztJ9jB0JQeM9CopMiDWAiR8kJxoA3DQdprqiJiLHTw7ir5dANwDkbGUnqZ9I3R4pLE47CukdyNG/qEJZzjR/CMLjrzkyqJnIvulj2EPKaRVGrepBLnnLYXcsEBuTFWpMvukXqPDTDc/chBDS4oiVe/DtsZN8cAfEJq6s0i49gp/NjUCy5IVPgUPtV5ezucQVXolos/3JR+rcTbK2LLojPNEMdduGE69EXjiZuevUg+thmo5wysoFESo8cfwUI3l+IzWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONAmzuFTJ8MBIkZyC/+mldj1gtzl7xltultE4c5LfXI=;
 b=R5nq7eyHQvNqdtTo41ydELCRtXXOHq/Jr88gGK25yaUyPtZHOgdsHUXsLK7UwIfhuqRO2YPnUcnNC0A/a9uiK8/UI+Pnqre2EB26vrVF1IkOWNIpO5AdFGom4I87tx+3ce4jn46QAj7ZMBGx33Y2Xd+cbNvhoUVxtTw1jTiDBIu2GHCn7/kqgHCd3NUQTG3J+gotiLQEHClWVNlYz9/h+QOzf+tanEyMJv0VonFf2tQuJhT6pplit13S/2X6/0L0Lbg78WHcGGjPcH1dWm5uTqPBVax7Jq8OPFpOv/WG6WeXxtNC8bzBjqjSEWjitcrpCkigVghMTHE5Do3QsDvDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH7PR11MB8526.namprd11.prod.outlook.com (2603:10b6:510:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:03:34 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 13:03:34 +0000
Date: Thu, 26 Mar 2026 21:03:18 +0800
From: Chao Gao <chao.gao@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
CC: <binbin.wu@linux.intel.com>, <dan.j.williams@intel.com>,
	<dave.hansen@linux.intel.com>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 16/22] x86/virt/tdx: Update tdx_sysinfo and check
 features post-update
Message-ID: <acUulqgwq/2tgOJg@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-17-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326084448.29947-17-chao.gao@intel.com>
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH7PR11MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: b6756e86-f006-460b-98ac-08de8b381604
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: S+UOynDaMXYEtYbdRn5qmGfbWGDfm5MHbUWTFTiqdtaAvjeR2nRHFQa2SQcgvi7b0JjG7uOI+jD+g59yxFhMXwlEEB9SO3e1qeiBUpU4zMgh2ie9aqkuYuMrlPCBQ1UM9WOxoXmBq1VIbcc4bY6gmV76R5+FT3Jx1rUsU8mCQKehpdY8Fn/6LU3NejuI7d1P0TLMWil/lqZQtJYxvuhiX3YPGBJziNRRKo66oUDy6QdxPF5gIFm2/4CiA29KtrdnQiVvU2K2S1Ce+mkXUnGGQVNbsF+8dbEN/WUtsFetGmB1ZIfJNRqpdMSuJtd2QFM8JK803iYTKlx0cmZqZhbKzzLQre1m3bE17SyzUkMf4riIpvhrCX1/xrUPfyBnYBGwLPx/hMF7BntP7nqVy9v28V2FZ0PbTvwCTla22JM0qw0NejO+8oXQrllzXwpWlR9eaIaJ6rcKiGMOV326r6ORIQhsVCB1iV5bJPHCxdsZ4g2WWHhxWXPdalJvihe5j8XrCbcta3rXA0TmQXF/iAQ5fbV2kWlXrMwG6VoVbkeo8xgtvlhI4gTzUx+JchwQsQnj1X3SVFV2BDeBkYucbQdpnygZSLVTaFvsjlXBUqbrpedZKDfcxtfLjwT7l6Wc4p6oQmfJ+oVJzDi1ZCO9uReRqpaaXZrzqTnNtUOGwLVNNOpWNVtCRyqOZCtWotE6kSKXP7Xrlb8gUqggLFDQQo5eRGdnnzz0LhjXHrNJsh0o6LQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x6EdI/Y7xyTtYnTHDnifh7XU6co/9zN15Bhts5XI5plqlCOBadjI5QS88zML?=
 =?us-ascii?Q?kWZkNF/gHTHJ3rZuLHeBmplZmfeLOnHjiDuPOqlhroj5R5T2lwhDNafdH0RC?=
 =?us-ascii?Q?FF6LGP3hgBVAM8xqIjnY1jKKc4Tl4jOzqU1jDdJuQnmnoNrsGOZsZlhHhlJm?=
 =?us-ascii?Q?0hj9tKZoNJo/BPPL6cephGAsLIKxP3Z3zMQAEjPR8PH7IZJz8eGiLitbxXGt?=
 =?us-ascii?Q?g5fIejxf7CZZ26zwcSmRkJKwove/r0j0ZADgMqVxKzn48pO3qUdwBKrlgG2h?=
 =?us-ascii?Q?Fz/fQ1I36KdpeTRdXKlkiqkRHGwXAzyjL8qDSyvV5lEqfbpXlOYyCdP7Xjcp?=
 =?us-ascii?Q?ENlmo55OXp4MkK5LFOIDdAIiQQDqqvp0/td7cXbFhVKK0VXhNyj46F7/ylrg?=
 =?us-ascii?Q?tAvNOVzJYsNIm55LhVmM+KfLQChfJ/O1Wh8NpdEuwWSmexg9gGvbAe6jvltl?=
 =?us-ascii?Q?JaUPhxAzOGvDnwhigVL4lBioHeeG58OW6gCX/LPoI6UscEg1YY1LGfiNBPzj?=
 =?us-ascii?Q?O979YVXc9bahjXH8TJU55yHfdIQy0Vr2PyLbhqu+tZCEVVTcxO/N/vt7Kuh9?=
 =?us-ascii?Q?Rlk/yvAa6WkrZpgyVO+ZYB/TQGoFQwYMZ6wdjrUAEU2rpD89bC0zSfDtWile?=
 =?us-ascii?Q?GK7Br5utaYLS2nrfu3LqWHOlkY8ZOjSRu57d4u+UV9ERfXgYB06aHm7wIx4i?=
 =?us-ascii?Q?bAFRXYse6X25nfAlMxGEkKLkLoHwvtm+MAmEOASjheDt2B4nLxc5r/4VIisL?=
 =?us-ascii?Q?ZrCGX+gSL6qnZzILbVALFMV1g9d9Gm8M7CD4MES1QBUSnoVBuiYAC9so+2Bi?=
 =?us-ascii?Q?kEVFAO9sICyQq0mfKwx0quw9wr7WMY4lHMw4f66gBvEjuUHtZw61oieqlEne?=
 =?us-ascii?Q?Sap/U9rvCSvFBcSxzsKbQt+Im0FUY0oOGXn0nS5+ySVojjSBWek7M6iEtDSJ?=
 =?us-ascii?Q?Vxlc/YuqP9Py/QCWkteJ47nJT9dTBKZ05S5jl0Tb1NmN89SFdXrtiZ+M3RWb?=
 =?us-ascii?Q?qz95uIuUJxy8JjC6E8ku9QxziHgJkTqITZXWW4q5PLBDqRwAqxk6LIxU0GaD?=
 =?us-ascii?Q?Nk/G+QZPGtoefvjCylWOAfbzW61AEZwTQ22JaAzsiCSTaA4x0bOfzg2m9+Es?=
 =?us-ascii?Q?O6ZJyHpEeOoAOPly+/eClPYb81ZWL5ZS7VwGJeNi9e4lYcJT0IYMaca05372?=
 =?us-ascii?Q?et2/eFhXWHNhH1AmNVhy0cGiRYGvislAcIi+T6bac+ILHdmKMW9io6DDhSsf?=
 =?us-ascii?Q?kB+Bk3wMiUMs+gcGgbF0jjV67umLDh8bN/tdqmLUlAILsKriGr26/a3w7Qjz?=
 =?us-ascii?Q?0waYkzfpaEQy3j6+oUNPCJJ3Pq/xXWAQlJz1HbC8yD01xeM+kjAQ3sVK3Sr9?=
 =?us-ascii?Q?IYL7HBgOT8cXoX9DWPVZMz3NR6cKF0Ek1qAakbtDQOj51iFLmDD2YoGPcxh0?=
 =?us-ascii?Q?C5N9PShrDMUf7Yjlq5Z8JtabwR9LiBCWqUGyr8djv8l816YrffRm3L11E81V?=
 =?us-ascii?Q?5NtZeLT0r9FNdDGYgClfhpRWZ2Z7gMkkzY59p+eKnReU8NSHitPRwXB4+Edk?=
 =?us-ascii?Q?m16MtTCswciFh69Cawp0+V6bIXEml3eZLkAMPD0JslSyR3qyeP/PzfCu+B/q?=
 =?us-ascii?Q?D+J88jDLL7AnDb0QXYcxupfG0x0bsKIPjcd2oGtJvcUo0/637BovOw6oi+Ya?=
 =?us-ascii?Q?2t+0fQI9N+d6P1/gGeQl3IXKEMxrEJBvAHI5xOSyrPvxsGdnkEDcXu7+uAjO?=
 =?us-ascii?Q?gCisaTrAtg=3D=3D?=
X-Exchange-RoutingPolicyChecked: pqs9a3KVuzmEj4DTA8fGdWVXZxoYxY/5v8hwR+0CJclQhOYu8DCr08ohSvHwIKpZV8MPnOHWtOCz9smu/PGU1WaTI+uidUpcw/ZC3LPmYnPXhD/lJ0EgEaNOkDis2Yb10F7354G1dDg9/elM9UTkp1QHtNBw6eMxk3AptqG+5QfQ2l+bbMm7eUpn0jWcQ0Aq1AfTtRYDxCWrYUhbsyFIgzl3O+WbRfWDd7+562KScFnxM/OAlhFf0BQIhZm6MjwCYZMCcpcCmaUNSzelqD+kO2j1d7i0NnemsOs6vYBVmHOmgdtqpKl92sN1+EeqngVDRLMJmroWKcM94Lizdb8CnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6756e86-f006-460b-98ac-08de8b381604
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:03:33.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nv+1toiRpIxMdRdFSMnO+/cznPBmVPKDgJv/pGCSC9vQFab4Gt/fXa6wG0sDGwfxAdeaqzqP0z+GjeI806mUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8526
X-OriginatorOrg: intel.com

>+int tdx_module_post_update(struct tdx_sys_info *info)
>+{
>+	struct tdx_sys_info_version *old, *new;
>+	int ret;
>+
>+	/* Shouldn't fail as the update has succeeded. */
>+	ret = get_tdx_sys_info(info);
>+	if (WARN_ONCE(ret, "version retrieval failed after update, replace the TDX module\n"))
>+		return ret;
>+
>+	old = &tdx_sysinfo.version;
>+	new = &info->version;
>+	pr_info("version %u.%u.%02u -> %u.%u.%02u\n", old->major_version,
>+						      old->minor_version,
>+						      old->update_version,
>+						      new->major_version,
>+						      new->minor_version,
>+						      new->update_version);
>+
>+	/*
>+	 * Blindly refreshing the entire tdx_sysinfo could disrupt running
>+	 * software, as it may subtly rely on the previous state unless
>+	 * proven otherwise.
>+	 *
>+	 * Only refresh version information (including handoff version)
>+	 * that does not affect functionality, and ignore all other
>+	 * changes.
>+	 */
>+	tdx_sysinfo.version	= info->version;
>+	tdx_sysinfo.handoff	= info->handoff;

Sashiko commented:
"""
Because stop_machine() has already completed in seamldr_install_module(),
other CPUs will have resumed execution by the time this is called.
Since tdx_sysinfo.version and tdx_sysinfo.handoff are multi-byte structures
and are updated here without holding a lock, could concurrent readers observe
torn reads if they access these fields simultaneously?
"""

This is valid. tdx_sysinfo.handoff has no concurrent readers. so, no fix is
needed.

tdx_sysinfo.version may be read by userspace via sysfs. However, major/minor
versions don't change across updates, so only update_version needs
READ/WRITE_ONCE() to prevent torn reads. I will apply this fix:

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 432d80b21ef0..0e7668bf20a1 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1276,7 +1276,7 @@ int tdx_module_post_update(struct tdx_sys_info *info)
         * that does not affect functionality, and ignore all other
         * changes.
         */
-       tdx_sysinfo.version     = info->version;
+       WRITE_ONCE(tdx_sysinfo.version.update_version, info->version.update_version);
        tdx_sysinfo.handoff     = info->handoff;
 
        if (!memcmp(&tdx_sysinfo, info, sizeof(*info)))
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index d4a552853021..43a55666145c 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -40,7 +40,7 @@ static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 
        return sysfs_emit(buf, TDX_VERSION_FMT"\n", ver->major_version,
                                                    ver->minor_version,
-                                                   ver->update_version);
+                                                   READ_ONCE(ver->update_version));
 }
 static DEVICE_ATTR_RO(version);

>+
>+	if (!memcmp(&tdx_sysinfo, info, sizeof(*info)))
>+		return 0;
>+
>+	pr_info("TDX module features have changed after updates, but might not take effect.\n");
>+	pr_info("Please consider updating your BIOS to install the TDX module.\n");
>+	return 0;
>+}
>+
> static bool is_pamt_page(unsigned long phys)
> {
> 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
>diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
>index c62874b87d7a..f8686247c660 100644
>--- a/arch/x86/virt/vmx/tdx/tdx.h
>+++ b/arch/x86/virt/vmx/tdx/tdx.h
>@@ -4,6 +4,8 @@
> 
> #include <linux/bits.h>
> 
>+#include <asm/tdx_global_metadata.h>
>+
> /*
>  * This file contains both macros and data structures defined by the TDX
>  * architecture and Linux defined software data structures and functions.
>@@ -122,5 +124,6 @@ struct tdmr_info_list {
> 
> int tdx_module_shutdown(void);
> int tdx_module_run_update(void);
>+int tdx_module_post_update(struct tdx_sys_info *info);
> 
> #endif
>-- 
>2.47.3
>
