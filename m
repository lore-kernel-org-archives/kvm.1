Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A463524B1A;
	Fri,  4 Sep 2026 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555587; cv=fail; b=r6bJk2a5VOEcYSmLgz4qEhSUIxtQaC/dXA4PRairq/HkFOw/51Bg4SDfEQ2/svA8bwU+meOG0YvBjDxBp2FvOJb38WvAskNYYuy8hZmAmbegEggXF1bBFha0Dy4XrOvuD8umb0gJfQd4hvH6MxdpbmUPq7i0AA3jruJU3HLw1aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555587; c=relaxed/simple;
	bh=vj8cGj36+G9LOLgug70pCYnFvW/PlIxWzZ1S5FEBoO4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pt0h+vvU5vY/Zo6250Zr0aKI5I9tXxcSxKwWwSo7zzPVMn4TsxIBf5xcY9cg8ZAGxvc/c4FrcKqzWZzDG++YzA7dfbWUUDPC0HDwBeuIUd8yzc0F/SlnxAUkmuCGqj/KO7b/5h0P0Q3in7uSVtGsazZmo2GGvqpv9DeXzpX+5dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0WD5XDo; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0WD5XDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788555584; x=1820091584;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vj8cGj36+G9LOLgug70pCYnFvW/PlIxWzZ1S5FEBoO4=;
  b=K0WD5XDoybWihzJfR8ETF6JzQE34jDNDnGJPdNorwEcbFh2S9HgirfxX
   uadr+ABbVj6h3SQoL5URJu/sVaA6HXyoSWrfSXSiGfdW6zk+/DsxrXZTG
   an5/TzhJZrP0QKS1f2yu7TdR/8gKuPUNNU+EFVr6NglHZ7vENQky1G8ll
   KhMu7fpff761yXoXEckzaUILYoEYuvusqPDfJfDLwltkNAA63pnHIP8D5
   JD4VFhP0iGu+r/mcNL9f3RhSdJFnbkez1xw+Y27vqFAmMC8uxqB43ZCPC
   v8R+4B+C2OxA6C3NSS7PaywyG28/pMYaHx/1RDoBbJEJKZMSnsSVjYy5A
   g==;
X-CSE-ConnectionGUID: P1NAk347RL2pWt4uoLKAhg==
X-CSE-MsgGUID: dUcl0dO1QKKr5tTkJdiBWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="88940883"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="88940883"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 13:59:41 -0700
X-CSE-ConnectionGUID: aArl6nXLSpWLyVgz0AclKg==
X-CSE-MsgGUID: 2hEGRdq7QUiNV3/w/mtURQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="300012202"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 13:59:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 13:59:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 13:59:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 13:59:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hw/94N0buyxQv8FQR4oTBs3rCAx2p84LgEOA6xd7OV4698oTvfjOua0eXDMi6YygxxnLlQx3sehWpe9KVbjAOcmXs5htzAik243W0LDuYVNTwS+0BNLFysjLn4o0Bn7HWsPdfhAhm73sfXYayJU+PJBECf82PAs+IF+U70iPNKAXPjYDukpHPaILQ+adGghOy3HcXfwYJhbvism5XQZaIDlB2nRem8J3GrkI6hBDuj3m/9lfMUYOwhRsbAHSQ/tnFrH2l5xto60yqXYzzjXKc5jV605M/UuYl/suzUmnkHKOG0a2WaTPfII2pacWW/ctrgTystHunRpNCJtuc2YxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIyt/mJ9Tv1VVKSGXIKRM/12BbjEoc0nrpkefPrmg7I=;
 b=jITlpdnMGHFQlXaxB6qV1V0KgcjBLW2Rnpqbrt0D/MlhboRfJxD/dknbrHMGfrJRWwdOI9Ia0e/ctF5emQNh9IxzWdCTAy4cX9z7NO48cZSKzf7t3fb7U9IeQ0D2XsapipdjVVVQw0tYYhtubIEm9IJ+tw8pWuSqPXSdq7LhF2URkFsdBqIVav/+LZPvMpfo7jxM2d/IcbNw8u9AP2HFxaxOCdx0gI3cJ2ujJqy7xHZQ/pWMkPjDxO4JGMwHBydUuKeBaMbI3C6KaeJcMS6UBfJmMyUf8wwibWiAcMKyH5qJsn0npGPOQIr3v5q4K8E4HpjUyd3/4nzepvjJUksPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by MN2PR11MB4694.namprd11.prod.outlook.com
 (2603:10b6:208:266::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 20:59:37 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 20:59:37 +0000
Date: Fri, 4 Sep 2026 13:59:35 -0700
From: Peter Fang <peter.fang@intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <apsxN4jYe3G3meNz@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-5-peter.fang@intel.com>
 <bf51e3d3-cf28-4155-9915-683bf6c848a4@intel.com>
 <apkUrXh4FJJua4mN@tlindgre-MOBL1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <apkUrXh4FJJua4mN@tlindgre-MOBL1>
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|MN2PR11MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbf3e59-0876-4d95-fe34-08df0ac76e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AVXWIKxfmw47IrN63n6KkWEbyedIOjHiqh1EdvKku5qd+VzDxH5UAOk6hRou1qBNPDjecHLLyeicO1G7A3QIeJHz7sCLpkz2WRFi9GVeC54z0SBbHalxfQixaC3fw4w2qNND04BBp+ZHMK4ey1ljj74LHYVe4FNmxtKDG45KbgsbX61XwwgMSALm8+8DJvEvrpRtVpMVch6GXntxTBPP2zsuckdCqpmSVbdDQ3i/BrOXV+H/PCbsz548KfOapt/nyWEYU+PGRHWnVT7Gh1DEwzf0cngbpTtSVCEndZfnLHXT2WphMmd919pFOwwHQeSAcru6K/yOJRAAu5ukDylkVG3R9yzdij97/A3n+eyIei75WfMr1lFKc5bXoEZLf/6WV1OA/54SvHkK5dP6nB0v8faSQsad4wbjVGpIf7w1iXuHnOw1yADYF1DIjsQYR9bwl4cQl2S4tUJQpIoJ4Nme7Yd9jlEsItIqWPDOYcAAmkBY2vSSEeZgRACHdUs43Va5MITHAxzQewkErEHATgeCyTBylcvUzKSS3HmWxJpJYm9Q/cvBE/EdCbJCgfg/fD3C5EkXv4dblQT1k4rHqz+yQ30+HKQKUT085px2e+ap8jPHUqnlLvq2GaYCW6+L3oqK7Lr7dqBF6tKBPTVGP+jKidJOBV9WZmNET6Dyl8VSn3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SK4mV/iqRgQYK7UAGzwR6khhLO/I0xzY6d4FtfJTlW+mk1Eh4FIx7tuMPN1Q?=
 =?us-ascii?Q?GTApXOs9coVEqzZjTTUD6PBRvT+i5h7KesrUAWHMaQ3XaExHxAHfU8sXePYE?=
 =?us-ascii?Q?0CbIqu7fAhjnbS1HGp/iNdj0OSVDNhH4a6HWag2EAzaRk7nLWAxPTjsZ/N5u?=
 =?us-ascii?Q?E0wycmO58LnNWvQUwHuENYX68b85w05Zc7cI6Fy5t3mWxC5fKiQIDrbT0Iki?=
 =?us-ascii?Q?EyNQswtBtBtsEP5JDTfrE5sgdkQcLjEO69buZdcaowebrA+TcKbpzrbwzj28?=
 =?us-ascii?Q?m3sRLzsB2GRde1HxfzyfhUnjHwsJXUsww62rTJxp4CSMpC8Vc68EOj1uxdIJ?=
 =?us-ascii?Q?IysJnopNv/0Y7dENspe44/EjU3alYXOUtTMLJcEXOlSd3u4XrxJlDZa33D+d?=
 =?us-ascii?Q?YEtKmMOoEGqBSgkZQJd+HZiHs9DR/r4Fzfn+gv/ysQiiA0fTa9zu637EyTdo?=
 =?us-ascii?Q?9HNmrwz1sWsaY9GQDYQ5x7EjD5+BYPXYK+Ua6I1LpHIdiWWshHt05kRZeh4o?=
 =?us-ascii?Q?LTn2QGCVghQ43L1NvyMwbxaOardt0cSroN2AMpQ0NX8havk6gMm/giS7ZfXc?=
 =?us-ascii?Q?ttIyoK8IfIaximZz72ijEBjHfeiZ4HyjGE+O8A58VbDsjRNwWKnEjI6eUoB+?=
 =?us-ascii?Q?FQOGUG/IFdqz3u2rEzstn+WQnDCKYW+iZCodItnXimuQlSz9Q1Ie42raHoWL?=
 =?us-ascii?Q?HNphbzC2uO5en1G9zC8tf5VUYf69ICmJzDyLoEzYPbHrWt/CpFkA70XGN+Tq?=
 =?us-ascii?Q?9sGRfZD41X4OfGnIrAfnyJf+KBRxq//CR3AJqhGijYezxsO/EpIf5yECMzYf?=
 =?us-ascii?Q?JtoV+emXSROQ06MrRRjqNuOpTPMABad/MvrVM7Tr20XPuoXR9u8v+epprt0V?=
 =?us-ascii?Q?gRj1NdyR6bPrv/YsIM+ZSBTcNbKQ0WSyYLlrfFXiNo3rVAOrs5MHTlU5W1Vo?=
 =?us-ascii?Q?qvEk/wia2yNEFomed2VjqpIAfs+FypEYZ1mzANY0HCsgLH4NNzxZpAs/5m5L?=
 =?us-ascii?Q?s4sjzs5/UMgED7/ICjhB8IOY1paObRnsfxifMmEL++Xg2XNiqtdK+aIev9YR?=
 =?us-ascii?Q?RRBZ829Iq/wHbNc39EXS1gj7UEp17vStyAFor4af7XQhGzGEWO5HvgjXUWDl?=
 =?us-ascii?Q?XLhjaj7Dvu09Ye/hhpcYHOSwhQIXvgEnbtxNKia3CIoLLOq4hBTIN6F41Ztl?=
 =?us-ascii?Q?SjOsKmoKmGHC6TlJzWNzL2UTVYHN3r7QSWgHN7xGN9OAc/XYL0Jt6VCDdfmD?=
 =?us-ascii?Q?ALDiRDkoWp4/KuYfYTdy6jUxk4eV1QgwUyIzNvV/vrtCx1tYS4ISYOPaRgQQ?=
 =?us-ascii?Q?dhB5xt9qlGpdKV8+/2/lvksPhBDAy/38V9Vr/iYNbQqbHuj9G2Pn5vvgYqr9?=
 =?us-ascii?Q?eCD2pBoRmuMRTZY+B4aEpdjoyl6afneNz+mjMQvOZsSth2eZmaf68Eg02svk?=
 =?us-ascii?Q?XiZq4LumR+Nx0tyRt65lTeRW/ps0v+z7Gy+Tq0PCDa4WhNiB0TJQoUgP4TAj?=
 =?us-ascii?Q?strhmLDr6YapSf5lkadbSdT6eLjjMcNfiHoGT0uR05L3BntNIIRB5kfT4YSI?=
 =?us-ascii?Q?M8sU6ge5mzVdHrSAlugWksLnKwhiv7cGYKym4lbHY1H4Lx/pXFvs3W0KWcGt?=
 =?us-ascii?Q?Cv7e/LM3DfrdcFwSHy+cVvrbdlJEQyXmaoNWiQdsCv+IR5lgybfkNRW/Mptw?=
 =?us-ascii?Q?4dpFrGZJQ3p1vLnZUo0kCNBugpmKreNC8MZofHavPmN0NCQ+AEKKVO9re/Mj?=
 =?us-ascii?Q?ljuCNB82/w=3D=3D?=
X-Exchange-RoutingPolicyChecked: cxMDTR6IlozPpk7DQ+WTUyWH9aXD68r/9anwvG4R1RrwHdNyP4O3osd9YUkPmcyOGbuaozoiHbyi0ZgVaxV3o5Fk6VWzuV4TOVkArpkxy79jbC9CgOSlyk0CBUh4g206wkET6uwmJQj2++r2L2bPCF7Rz/ZJH+DFQC26r0e3sPODI1ZZAx7EEKIW+ZDLROSx2nxMr/ET8AIUK7tVMe1ZSGGpx5TD8OYxYqqfCmacYcekSrUDeGRB96CaEr8PXcl1vAZ+6g2aSxTRAl11dWlXzv+M+GPVwPCU7ZEhxgBKZ2Sz0YobPFPXcfbWnsbNN7hlCkgyOCoo4XAzdmmvh6Ba3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbf3e59-0876-4d95-fe34-08df0ac76e36
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 20:59:37.4657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4R11Ne6QnBow8vHT8k+kESAV+JME8/oydcMva1BKf6vEKwEnNpuMtUvdYJkeJMhdbCiliv1UzGJ36JXooJXmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4694
X-OriginatorOrg: intel.com

On Thu, Sep 03, 2026 at 09:33:17AM +0300, Tony Lindgren wrote:
> On Thu, Sep 03, 2026 at 02:21:35PM +0800, Xiaoyao Li wrote:
> > On 7/29/2026 8:29 PM, Peter Fang wrote:
> > > A new TDX module ABI reports the TD Quote size limit in a metadata
> > > field. This size used to be fixed at 128 KB.
> > > 
> > > The guest driver's Quote buffer is shared with the host VMM. The current
> > > fixed size may be too small for Quotes using schemes such as
> > > post-quantum cryptography (PQC), where larger certificate chains can
> > > increase the Quote size significantly.
> > > 
> > > Allocate the Quote buffer based on the reported limit. This avoids
> > > wasting memory on platforms that do not require larger Quotes. Older
> > > platforms fall back to the default 128 KB buffer.
> > 
> > I think we need to justify why using the value reported by TDX module
> > (i.e., QUOTE_MAX_SIZE) is safe.
> > 
> > From "Intel TDX Module Extension for Quoting" spec,
> > 
> >   QUOTE_MAX_SIZE that specifies the maximum size of the buffer that must be
> >   allocated to contain the Intel TDX Quote received from Intel TDX Module.
> > 
> > So, TDX module only guarantees that QUOTE_MAX_SIZE is big enough to hold
> > the quote that is generated by the TDX module. But for the current tdx
> > guest driver, it doesn't know how host will generate the quote. Host can
> > generate the SGX-based quote and we need to justify the QUOTE_MAX_SIZE will
> > be enough for such case.

Thanks for pointing this out. I confirmed with the TDX security folks.
The reported QUOTE_MAX_SIZE covers all possible quote types on the
platform. If GetQuote gets routed to SGX and QUOTE_MAX_SIZE is too small
for that, it's a TDX module bug.

I'll add a comment and update the changelog.

> 
> And can we assume the TDX module provided size does not change after init
> with a TDX module update?

Yep, it's safe to assume that.
