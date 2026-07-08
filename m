Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84A3E44E6;
	Wed,  8 Jul 2026 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493212; cv=fail; b=U/XqdGjWGVyQERlGSS9QgvNh0lJXlFtN3GNAILcUxQsmrfTSuyXKcvFfpBR0h6U2mXFv31JP+Mzob+s4j+3aGsSZ3ZVZUJUXilcp38zI31IvjPyNa8Ab45Yk4m4CPbgMSljRY2Yt8Ykmm+SXXT4XRjQ5HyoBlgmacNxfbBgAWwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493212; c=relaxed/simple;
	bh=bIkwyTjkBBUapqFuPdKdsGcfV2URxMEv6xKPVK7KXvM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qiR4Q4ujXnQDGGCavwcBzvUXXcFs/OUa/6uscFSrUjawpjKe5ZN1d3LPLjClMpYoDIqpZpMJJusSgKX0ihyYNRxzG3/SJc4fulOkVMj2rE0shW0gA3F/GiEKRNkSZD2C+FfP0b93l9w6JwucBkO1YLU75fg2aOeukGwgygWuWN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeAXD6WV; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeAXD6WV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783493211; x=1815029211;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=bIkwyTjkBBUapqFuPdKdsGcfV2URxMEv6xKPVK7KXvM=;
  b=DeAXD6WVCDL7/8pUXGY7sOVm2IxC14oRnQIHQ8T8+DBWl9NmpTL9kRHH
   rxqPHYLIRLY6Qqaws+ESGLqWgTBY58wmmYtMlWBf7V5JhnTyrSJKqyM4W
   cXu7r8b/1VeEx0cVQ/lZU0siZgTat5Zococykr0aF9KOVAh3n9gzAudLY
   uczPkG8OV8T2Iky09O/AY3r4V45MEsEWmbPUdayUH554x7vtc5MHey+mW
   znIIVXo6xHCUgSe+7uCfPbG5tSDZ8/m4HbaGm/eCKEWUjdhZq68z3jjNH
   EsRc1AeJTJPUCTQ8kAOwadKDUQlTW1NxhGEwvZFobq9wW9OeBGyGbj+q3
   Q==;
X-CSE-ConnectionGUID: zK9tCLBNRA6zzCNbqtgx6w==
X-CSE-MsgGUID: xF520OwESQyIdkgC7wDFXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84120902"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84120902"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 23:46:50 -0700
X-CSE-ConnectionGUID: c6QPcHDlTOitYxD7Q0FR+Q==
X-CSE-MsgGUID: cxsBvFESTOSgjx3sNhaTcA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 23:46:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 23:46:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 23:46:48 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 23:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grSL4sVKBxmb9P+/CfLOOcIHsUWa8KwkfM602UeVg7fvvf2X2ddeCmJQnaDm+WxL+VFdsPoTuecTwUQDay/t83+3SWXTaADQf6lo/WHedCGcudiXsUKBuuKEiem67+XdM19pIpA1JM6jZOWsKL5I7vAfwl8YF6N0u/GcyJ5fbz4lFfPCBzX7f5MDkyUTe21NaGYM46ZIY/RZ39puZQaXHbEtx4WFt6wzo090UZXhv9cxoa/KaTrpjkImVNUsjKdUKaQRJ4bkFa3R+T43sbtlCqxfVDNSpJubmAWzuJI4lWpnncwC92jupuP8cZiRq3LEiWS8iLEV/zNEXvOxF9lSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfVhvjY0MNVVLbJjyItuZDhYjjAlzGcl96IJIzZlC/c=;
 b=Y+Rwq8vbXQlB/HtUPDFzFXXHtMowY+1u0Dat4Agsa1F8eORfwRWrdCr3HX9f1/wFCIlq2YGSLbswKKu6JHKGjzNFpPW4cBDdJR+DicQkMEKMRqQ1BZXQWD6vsy3B0/TZsru6ib+usZ/b+4Sh7SADM6+jmwozrn+KKXUxiuPpYMLYfLJBx66MesvnV0Bb9R4zT08/ehnFefsDqGrnIwHm/hA5dBQAj4J3kQH3JOfdlGxv/E/b0bbSR5uqjq6n2VDPWPM6RlG6eHWdbnsdOKC83W6CqNtwxrkuHqa6ejXDzR5JL0XYNMGVA9cFnuyHDkUAnPgh7fcwjaui+87vLw1ILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 06:46:40 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 06:46:40 +0000
Date: Wed, 8 Jul 2026 14:46:32 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Message-ID: <ak3ySL89u5+1oCZB@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-6-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-6-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: KL1PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:820:f::13) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|PH7PR11MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: c228ff6a-f9fb-4b15-592f-08dedcbcaa21
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: U+x5cETria+4GFRF8USVsY6Ijpop9sVrDe8Qe7L1kmPgEIhdv7MJYsyKpS22lu4RTTUjE45nh1HTSkDRDLSV7MumiUmj+/HVrIWnyHrLkF33nrBvbmr3kAKzx+QDLbvQfJ2jSMcDsTUChv9gUG4S1CNuce8H01vnZ9rdiMHml71n9PeARUOmp/Qteytq59tsAP+nEbIEBxgoqJf6yAuZsOq4pvpD4abOzdbda0qv8xvYJc3q7MsrIIU4kGUFM4NxiIhymSR2jgwR5T691WpXyOmI5+gMPnc5fj9i8xzHn32RcZzLG8IpNIP9pxfFuLQQ1CCR6Fux05vUvFC4wwVCDLAyPuSPvxIiCw+ydqqh58S79ehvxaX3Do9KmlJWag9GXAWcMb7AQWawvpXngAFqJNTxFRsetbEYhTFRp2d6bb7ysNsw8/Fc6eIfcDC4Kjb+kMstN/kz/lMtpgSkNft1Ma6rP/S5BENRipZF8yT4ux+EPws00mOe35wIsUPUnZZCxw1LCMGhj/hYGcazCZCkDgaotvvh9eUGXonqL/GvWAXTxFisqzmGUX43MWhbRqMtpwgtmigysKuHl5cjBXnBa1EtWyL3Cv8uHgKUYmvCtoB5fkpjQNM/uIjLB4/loMiTloK7EcMzjE9W9p3azCdLQmoLOasH1krbgMJX4PFNKzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1e241TIJyQP8IT8KyekFxwEZxpl3Zoe11widi9DEKhoUvusCBJlUKGQhytK?=
 =?us-ascii?Q?VcglMH497QAITPdORYbTY7EpnBaoHZ8CxIHHpD4Pb3CBwc7T448N8qE7Cis0?=
 =?us-ascii?Q?OL2mnyIbzu1u7ZFaaecHwnfq8l/B7LI/DDmNs4SdEeyyH0LsvPPbrfst0NID?=
 =?us-ascii?Q?sIyM47bT5ES3MiqK6vT3XZRC2/2o1w+9wDFDw7kE7Mi2LeI3ZtBsvxQdBUnn?=
 =?us-ascii?Q?XBLFai8ybGsoR2usBSey29EPjn9bmdMTuQvuXIqDVm96PR2pbfjHNvjCN1Xx?=
 =?us-ascii?Q?GIEesljJzl/hD9xAYQWE4Kl8KcnD5SMUI8On+juJewLhWtSzAxpc6gJcCVFA?=
 =?us-ascii?Q?8EKYV5jUwRpCq0BnruiXRuVbqvHkAvGtIy2YFTRXAftIIfwUGB8Bw5Q1mLkn?=
 =?us-ascii?Q?qxwkIuqwPBQZd5R67+stRYN9zlG7pflEy8clS5ENe4L8bAc55G6s/cK77CRi?=
 =?us-ascii?Q?uOVHnmIfuAN802DdXn75/TJJHv//bic5gDWz/pPkSN1tJAm6GYkszBpgomNT?=
 =?us-ascii?Q?Gz2tLPcEdq+g5tLCAydKYnU+HUEs21mKS9dtW6n4vr5yyg8+HyExN7AN8Yik?=
 =?us-ascii?Q?VDqsq0XC0grwAoBFbtIKnismsWK7ojTYsBMJPSOPqeC3gNbC/+xEjpGgol73?=
 =?us-ascii?Q?zL/+iqaM57ezBpYjVdrPIbyUd6fvOGDb177LdyTHYgGzeB/R/2X+FEWUbZHU?=
 =?us-ascii?Q?Fi2UQjCsicRm9vmhS2k8C45Y/A6tJ9KTIqw9H2p63oGFjyNvfoqcoosC4LrE?=
 =?us-ascii?Q?VJiGRl5RoFl/ntqhouL0Gv7J11/D3OXYEEYOBZAZkImPkzvAsYhWKHjG8f90?=
 =?us-ascii?Q?Py/Xrr2sPSqIKSctJEQxsLsqWzJC25zdH6kCj35WCyBc30U0YyrwhSkKJ6+E?=
 =?us-ascii?Q?/P3ng8zw2zW+cwiVYJuleuj40h4caYRIDQ3kyAdeRygnvLUqSl31bwg3f+87?=
 =?us-ascii?Q?yYKH7JkTMH3zjVE8ZpQlX1Ea4lRNJ37qZMmSUGLqKNJlvROHVYa/Ax366n6w?=
 =?us-ascii?Q?jZ99k7awzz+So6FyuDPgBfvYnWRQTb1WUIQ605g9prJAsKmq/Ac+EZ1Vay21?=
 =?us-ascii?Q?PuT6fshXfK1nO89EomkC+aMOUi4rN0Gr28ATH1Jbc2YnwQEATTrRr3sfkHiE?=
 =?us-ascii?Q?sQbfUAvnV+RgitGhTKLtolZshSwVmY6sYkPAxiyhx6jqFKuTs94w7jtliPgO?=
 =?us-ascii?Q?SaOTY4DbhmmydbZeFzBT/n3+8pNPuPGApPNXVEY7NO4B1405Nw0yLpx9LZG9?=
 =?us-ascii?Q?AqS3415COne+ApEEYQlFrw+X1z/Z6kLto+LY/FXcbEbLHCiKRseLdKqd14yz?=
 =?us-ascii?Q?Krb2vJ4CSMq7UsrHfkl4N5Vo3I5/NZ6+YI66zNW4lhLlhKdsloYkZd02RpVr?=
 =?us-ascii?Q?fDjfpUyjIKpMnL5oGr1GViAJuyzWj0jpsqV/XHIQn9MDOAOB7vRpGfWp89Ab?=
 =?us-ascii?Q?GiAjpqd93mOu1TjacYOIRJJU/HXDjzUeac7Di0iXqu2XMEPue0Zl1pMFOQq9?=
 =?us-ascii?Q?qsDOCWZvx1Iweb7VdIxiLVAs6Cm7JKbpmn4PvasplNa5RF5nkH4ow6LmnphO?=
 =?us-ascii?Q?Mkcp4KioZoqjWBZsmQugbL8e9iWUT8dV1RTaZcIWVVMB336jWXUbWkA0AEYU?=
 =?us-ascii?Q?5bPVT5/t2rN0EWmn7sRXcTUwKGHySrhX6Tjff3PjdMUPv/Ds/i1+QQK4FPKY?=
 =?us-ascii?Q?yoNGgeIux+Sgr8v2JcVKcOlbM2ACQMEPAY5DuOrXCNQFwkzQE+FRBVJhhGyn?=
 =?us-ascii?Q?BVhBAYOfwA=3D=3D?=
X-Exchange-RoutingPolicyChecked: NfRc+nRIfZuVKkZllKTeJf2K6vvBfpsHtffZn+9720KQTESBJxmmj/bT8BoTCqe1izcbjoUqoGT35UhWnmjaz4xtJWV1EIncCX4x4tgZJZN9JEeViB1huqUeVFPHOwKmAY3Y3Hi4fFw307ma0RRlZLnIaNcLKMckwrgitQnlBtlzCmD1R7dOVki+eFcQHzJws0lYNaEc5K2P4hPOHFASvyPhP7pEIJTF3ESAdRNdRRniRmYqohlk1ejzmb8fG8WnhC6YoaP9PcWLBM2K1EF0e24Hv8HvoMLXVa9Jar/0vWG83GtzprYBuZpIxaVd16noDdfEUyOCJQIkIqcgQ+m5Mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c228ff6a-f9fb-4b15-592f-08dedcbcaa21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:46:40.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aifXYGovSstmapZPT/9P6VXRca/5eih6oMXQfAjn2a3veaDOJRhGJxiMx/w8SuEDjMJGe+eIRSEIQlZVS8MOnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:09PM -0700, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> tdx_pamt_get()/tdx_pamt_put() unconditionally add or remove Dynamic PAMT
> backing for the 2MB region covering the passed pfn. However, multiple
> callers can concurrently operate on 4KB pages that fall within the same
> 2MB region. When this happens only one Dynamic PAMT page pair needs to be
What "this" stands for is not clear and a comma is missing after "happens".

> installed to cover the 2MB range. And when one page is freed, the Dynamic
> PAMT backing cannot be freed until all pages in the range are no longer in
> use. Make the helpers handle these races internally.
> 
> Use the per-2MB refcounts from previous changes to track how many 4KB
> pages are in use within each region. Gate the actual Dynamic PAMT add and
> remove on refcount transitions (0->1 and 1->0). Serialize the refcount
> check and SEAMCALL with a global spinlock so the read-decide-act sequence
> is atomic. This also avoids TDX module BUSY errors, as Dynamic PAMT add
> and remove SEAMCALLs take an internal TDX module locks at 2MB granularity,
"an internal TDX module locks" --> "internal TDX module locks"?

> so simultaneous attempts on the same region would conflict.
How about:
"This also avoids TDX module BUSY errors, as Dynamic PAMT add
and remove SEAMCALLs take internal TDX module locks for the 2MB ranges of
the specified PFN and the PAMT page pair PFNs, so simultaneous attempts on
the same 2MB ranges of the PFNs would conflict." ?


> The lock is global and heavyweight. Use simple conditional logic to keep
> correctness obvious. This will be optimized in a later change.
> 
> Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> v6:
>  - Split from "x86/virt/tdx: Add tdx_alloc/free_control_page() helpers"
>  - Return 0 instead of ret to be clearer (Binbin)
>  - Clarify log (Nikolay)
>  - Justify why the patch is not optimized in response to comments by
>    (Nikolay)
>  - Move tdx_find_pamt_refcount() to faciliate patch re-order
>  - Adjustments from dropping error helper patches
>  - Log tweaks
> ---
>  arch/x86/virt/vmx/tdx/tdx.c | 72 ++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 6658a6be6697c..50333eb96efa6 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -2043,10 +2043,14 @@ static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
>  	return 0;
>  }
>  
> -/* Allocate PAMT memory for the given page */
> +/* Serializes adding/removing PAMT memory */
> +static DEFINE_SPINLOCK(pamt_lock);
> +
> +/* Bump PAMT refcount for the given page and allocate PAMT memory if needed */
How about
"Bump the refcount of the PAMT page pair for the given PFN and add the PAMT
page pair on the first reference." ?

>  static int tdx_pamt_get(kvm_pfn_t pfn)
>  {
>  	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> +	atomic_t *pamt_refcount;
>  	u64 tdx_status;
>  	int ret;
>  
> @@ -2057,10 +2061,26 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
>  	if (ret)
>  		return ret;
>  
> -	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
> -	if (tdx_status != TDX_SUCCESS) {
> -		ret = -EIO;
> -		goto out_free;
> +	pamt_refcount = tdx_find_pamt_refcount(pfn);
> +
> +	scoped_guard(spinlock, &pamt_lock) {
> +		/*
> +		 * If the pamt page is already added (i.e. refcount >= 1),
> +		 * then just increment the refcount.
> +		 */
> +		if (atomic_read(pamt_refcount)) {
> +			atomic_inc(pamt_refcount);
> +			goto out_free;
> +		}
> +
> +		/* Try to add the pamt page and take the refcount 0->1. */
> +		tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
> +		if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
> +			ret = -EIO;
> +			goto out_free;
> +		}
> +
> +		atomic_set(pamt_refcount, 1);
>  	}
>  
>  	return 0;
> @@ -2069,26 +2089,46 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
>  	return ret;
>  }
>  
> -/* Free PAMT memory for the given page */
> +/*
> + * Drop PAMT refcount for the given page and free PAMT memory if it is no
> + * longer needed.
How about:
"Drop the refcount of the PAMT page pair for the given PFN, and remove the
PAMT page pair if it is no longer needed." ?

> + */
>  static void tdx_pamt_put(kvm_pfn_t pfn)
>  {
>  	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT] = {};
> +	atomic_t *pamt_refcount;
>  	u64 tdx_status;
>  
>  	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
>  		return;
>  
> -	tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
> +	pamt_refcount = tdx_find_pamt_refcount(pfn);
>  
> -	/*
> -	 * Don't free pamt_pages as it could hold garbage when
> -	 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
> -	 * there is no risk of data corruption, but do yell loudly as
> -	 * failure indicates a kernel bug, memory is being leaked, and
> -	 * the dangling PAMT entry may cause future operations to fail.
> -	 */
> -	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
> -		return;
> +	scoped_guard(spinlock, &pamt_lock) {
> +		/*
> +		 * If the there are more than 1 references on the pamt page,
s/If the/If
s/references/reference

> +		 * don't remove it yet. Just decrement the refcount.
> +		 */
> +		if (atomic_read(pamt_refcount) > 1) {
> +			atomic_dec(pamt_refcount);
> +			return;
> +		}
> +
> +		/* Try to remove the pamt page and take the refcount 1->0. */
> +		tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
> +
> +		/*
> +		 * Don't free pamt_pages as it could hold garbage when
> +		 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
> +		 * there is no risk of data corruption, but do yell loudly as
> +		 * failure indicates a kernel bug, memory is being leaked, and
> +		 * the dangling PAMT entry may cause future operations to fail.
> +		 */
> +		if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
> +			return;
> +
> +		atomic_set(pamt_refcount, 0);
> +	}
>  
>  	free_pamt_array(pamt_pages);
>  }

Another nit:
How about renaming the title from
"Handle concurrent callers in tdx_pamt_get/put()" to
"Handle concurrent calls to tdx_pamt_get/put()" ?


Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
