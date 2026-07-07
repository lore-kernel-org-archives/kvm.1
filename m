Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421BA3DB623;
	Tue,  7 Jul 2026 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409179; cv=fail; b=ZZN8O0rvLNHJWUSEJ6iKl8rCm/0Y4Z/leJpODbFLo3WLHuLHuAOxJ4X2IiEmU/mEHwaxTttpVZ306NwqSW+Crn1TF8Jns6UakiP6Lf2XXQWlVR1TwcgSg03Skwby2oHGunV7vsOy/V1pnSWhui0IXQZtHa4pOt15hrc7+sjkbbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409179; c=relaxed/simple;
	bh=DPzqh8TVHdm689DpvEDYLUH80GCd7UUQ4DngNlVpAqo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QbF2NOFawrn0F8v84R88g5otXWAqJ7JcO4ydGiS6RfG9NBzqGBEzDKvyJiq15HxnaBUE1aJbI2RnPxewKnsJRMIMLlHWrZZk893KTc7jWWsLySZZSj0MTClXud78iYq6xSnvsU5BHNK2/8utAMkIIcidI2Fgn846WqMrUJFds1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVCuK9cJ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVCuK9cJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783409171; x=1814945171;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DPzqh8TVHdm689DpvEDYLUH80GCd7UUQ4DngNlVpAqo=;
  b=mVCuK9cJeahcYupUqr69VybEDzTVdl77xbyucZH/jGXA+QDpFFzFEGHk
   FCfIWGuOrP6PcTDdvNlq8mBXqZFjSR4DpXfjqrjAaPTTjB+MU90JURDT3
   Pnm1vJQZoRXgD+N9N4CHAMX+Fd4+HZcl5gpEd8Kb+S3IxVZoo2z/1bFPp
   BtyKPX2CdA7FcMHyxmqyOy386cobVNzCN/fE+JlLwGQmHuNOnfS8R/qno
   cJA2TNTR7a4fx2yUyOXKSlFIb1cSI/Zv8vY8hzBRdvQneSgSfRFxnvVM1
   zWkwCJ6/6kGNJbmnnE4lEd5BEFnfbd6DaEy/bRDQNA6IQn3vDjJmW39+x
   Q==;
X-CSE-ConnectionGUID: mkFgaCu6RCGsgOOEKoJk6A==
X-CSE-MsgGUID: KOif+EuGRvm+T7JpHy5eZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84026673"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84026673"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 00:26:08 -0700
X-CSE-ConnectionGUID: RqnIy58qTb66Y5QaxBP0iw==
X-CSE-MsgGUID: ZmyWInbhRjq0EaqwqX7+UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253455030"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 00:26:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 00:26:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 00:26:07 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 00:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Haqy11nyTc+nmzGf89uC8EAakgHJ3DwBKvK7srSpEe74N+/N/yl/unZpozcUohwtSWXr8cWB2BWUGwjynzYlbnMeC+T78dzZZ3myFmfvAOX32nc+SBvF+//juV1Q9s/m05QPHQaWbkIkr8AvqnBT+180r7hXqImQem2Hft0nru18BapkVBGhG2D3IGwJrzJBoiz/QUMVG2uVQNpua2TpP5SJEU96ruY+cIifBQJUMGprTGS91sLL5o2OWl0Kc+PYA0NEkQY4cAh5ViYgS7OV7yeS637EP1XFNo4SHZlKPMqoE/8k1FMgm2E3zK2n8FiUi2ZXuXaq7VYPajOXO3K1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9aqCI/xKjsavqEDGMCpL0dZMtyGz2VR/uzom/AtAqc=;
 b=f9X+IX1SL0OMhYaqBlubcp+8kDSDLLCYQHkVRyDYt+56PLcWRzSKPLjli2b01WYuryzaUFEcd1qpuvCzPbYpGQl92qgCdpNgyces/VPNgDF6PKI3Z+f0b9n27yBy9TPa6b79X9VLp92U3swcT+D2nvCGmc4qryT8dax8o8VEqYeWwAi3ppFvFwpgiM26p1O+gamB//5TWoABzptDf8jWIHwlmLXn9auLHdP37UFbk4Ql/UagyzBiptHTSHFPeZcAsRqCoqQWmLrhzvTxBJ1jIG7O5esWtqEWg7yaE8OeCmQ/udplw0jDgBYIEXb69XACwljToimWU0v0FentUmmMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 07:26:03 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:26:02 +0000
Date: Tue, 7 Jul 2026 15:25:51 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <yan.y.zhao@intel.com>, <kai.huang@intel.com>
Subject: Re: [PATCH v6 08/11] x86/tdx: Add APIs to support Dynamic PAMT ops
 from KVM's fault path
Message-ID: <akyp/1tT/tvSvcTI@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-9-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-9-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH7PR11MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 207351ea-221c-463d-680b-08dedbf8ffbd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zYJY2q5TdIvxlNKT2ALa9EgcI9d0MUgnAqL4ld0XhgUh2brA0nKOg7f90UM+yxU/R9ukm8ZzWJNNCWjoZGN0FYLvbiDewh2ckPeHUrfwHsIvUGridi0bSRiPvEwPOBEapEsOPTtD7SAYAupq0QjTwuO1x4y8nFePMNJOjhCkHUkn+cV+VxRU/UMx/wv0GhsDess0oEA22Cal76s5mKI8Ea7W8Mjn+TGU2Ei+tMJ0PVEQrqwL90tS1rICJhdckUQWgozXT7hc1Oa51c7bJefH2NVpl7A2VnYoZFoNs5an2UhAGDovlhMDt2m4kvkrVz57imxuT74bAcrcJcdgYa3y6T07zN3Ii4SO//NbDO247IaRC92SeYcIRvk4QsDkor8uh4Wjnch7uen9YNTywUh9HApgSE6AViLmSnAZMXWup8hx9QGjJEmZV9o6LhtkSncW/vibFew2uICSiM4AKrVhocGSzdygHm8sSXvwMmbfMAAiOTIbyHsvvpVrxh4GdTfwW1rr3J4eCXw5uGBU8SkYb74Sv3lRTl31+X/u6SXs8TIWQY5ZR+znKvY2qgryW6TlfcgzpWY45sPH53OXY0vli+GY7Z5GZaaMXmNPOwSCwYLdMl9egbS2uEH3aNBiUuvwB6mEtopC0Cd2LBfYoDe1m5uX8mGhz9ceGlvN9S8Xfzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SGR1akXb3W60R9wOzZ45Bvm1NmYDp5iaECdz8+FH1xB7ZUg960HVqgBv7DOT?=
 =?us-ascii?Q?SaJ3ZSUXKn9JdQvQ/N30Gp3LGXY2e24NyadyZt+gZgl9LpRGVulFR9e4MyTu?=
 =?us-ascii?Q?1mFnJxcvj1c0Sw3e8X0k912cRr5xUqPMTPbn3mt3LkegskqsGfOQ0Qe09VlE?=
 =?us-ascii?Q?3Dd8rOoc9MegHgzXpSOFT1tAvT+1EqjGerI4NLmVACVn7FWTSQIw3zOus60i?=
 =?us-ascii?Q?reTJbiaNzuIYAYZSUrD1+F+LnnmGFyHAKZpFwxND85BTa6jeYN4SuhV8VFck?=
 =?us-ascii?Q?XSQUU5nxguIzM92IPL6Vurq83c545r0sB3rv3MS8t4bjcTRi5DKm31ehQl11?=
 =?us-ascii?Q?k2ArrgKYo4IoR8NVJ2lkerr0Iu2NnLTSRutilGuSvMhaWK48eKwjLbki7Mnc?=
 =?us-ascii?Q?kbd5pTkcK+3wtb4FFfBpmyiMr0eIlUWxCo6YVpRzduGFe2Zn6fDzUyDgKi2l?=
 =?us-ascii?Q?PjU5kICVSnONVys+Wdr0PzrqIvanNaWl4kiuePcr+NLm/Xx7zdd4rNzYvhvk?=
 =?us-ascii?Q?N9kGmnsko23le6wRtlw7d1Z/xymmUFTzHSpg7zdRvnEWRLxk25hxv/auon7m?=
 =?us-ascii?Q?lRBU3oDm2N77/kExafNwrX/e/HNoCQWvvPm02luYWVQXsF9aQsyPvuYPZaBy?=
 =?us-ascii?Q?BBrIKT3fHG0AhgKZUmHcJ50m92of3WX/5GUpcHpFdIUWW7LJYM7P1zj9yTbC?=
 =?us-ascii?Q?f8tfWu8RXbeaOLkZDOf6omOi0001qcKT1lp7Lx0THN7B86g85DPdJTXFlhDf?=
 =?us-ascii?Q?YWlQUXqm0L+LRe8HZPGZerHdjuC7s4ZRjWHsLlXNddm7ea3jPwzBthTW45/v?=
 =?us-ascii?Q?DCx6cKUNrIerl/cMaS/HH/3pbtrLdKyyMwMz5oPaEcPh8Jn/SeahKndG0QAw?=
 =?us-ascii?Q?Mys2xcD03V1Y7kYkiS+xDqJPsBWHvx+ncqh8pAkj5GmKTbot7rw9EG9nHu5z?=
 =?us-ascii?Q?np6Bi6opNSqp+HxwwjF83sCSWD01Fhu4mQNS2qtpeXLi86fw+dsQ0kS2dV/s?=
 =?us-ascii?Q?S18Dh6w5uLuvBR7FvfzAaWiBWv3RpUW3t4snTlB8viDUmjitBDHCKa91hj25?=
 =?us-ascii?Q?vAGKLVBERoZ3ZLK9YttuIadufHkqNAuklDbGHvvfGO55lLQI1M/0IglRGjHI?=
 =?us-ascii?Q?gbF5YojWVUFaI5W5LkfvGy0zqFqJtypqN6dcz3iv5crIFxjtJS2n5py0m4F5?=
 =?us-ascii?Q?PBbsn3jNDY2J6SUzZZklKdNOSYs5cBDU+LvG3k1+FN4NDI4nrUJvuBDtBvN3?=
 =?us-ascii?Q?1FM8jGABT60+ZUZzs6vbuf1r0Z8kpJZd1Rpx1eywkdAraEgD7ztMX/Ei8EaH?=
 =?us-ascii?Q?WpPEHqbDNpKHtuG/T84Uxtny2xcbjm7L3Qb/MBAd903/yB/yl00v3LLqsdPC?=
 =?us-ascii?Q?xYT/Zh0YOSG3EZ49TQ3tslNHEXJyiJSeqd/oZPwAlGsR7Fx8jrB7NR9BRTZu?=
 =?us-ascii?Q?va8DcZQ74zFZ3hT+wGA552A8XCRdbMs05YNhMVIpFJedNCl2eQynMIVt+6LE?=
 =?us-ascii?Q?SMM9pvHatpk3dMXvRrGL8seoGi3xylVC+wcBxRvt+JWzQ0OTXdLkY0amnFVM?=
 =?us-ascii?Q?xTw1X4nHGWd2wrIXTEpYEKx3IHDM4/PASIZC5sY7TV4UCAvJ48NSGxwq07MQ?=
 =?us-ascii?Q?S9H9AbZGqo7Ck0GYd3OuLIC0dDWFZ4HaeTUbh3/p8x/sLq+KQTGm7lak9cOa?=
 =?us-ascii?Q?In/iQY/F1j1J/I9L4YXzutcQpq0Em2p/kXswHOChDwIbXYQpqiXchF2ydua/?=
 =?us-ascii?Q?ePnwobGfvg=3D=3D?=
X-Exchange-RoutingPolicyChecked: YopDXOycwMggIwabJb2cD9KxsFbBDZfOH+Ah/ivGRieMIfc55uN14Gsv0I88HdJJQu135PdqXAAkUcbDzDwlqg2eJaNITist7185v1LBcDVXBq4N3AxmeUATYfT377Jw45scsLIwMqGQHL40WcozFxtm4fR7yyh6bO5tBbCDa4iEVpKQae/e8Fvfih0C5THqFqKBFuafsVZDSkQWja25rvKOrTqgdl9tUwgmO11/Zto7LfJqDE4u2JlyQlNqlyRp6WQRYcUq7Pyf+ZlovvFTvLVT0R/f8nOW7X0C06Dt+a0dYVNa1wVObjs/Kpt3FgmIfspl5DjJ6DBB230EDFS1Uw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 207351ea-221c-463d-680b-08dedbf8ffbd
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:26:02.3258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwPFx0Wbs9yo5ttX2YhvFRij4/R3V+IAWPklm2k8yefCsfaUlAeSvd6PAaEpALoxRZgbYxBVJnMySXEZzIFsxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:12PM -0700, Rick Edgecombe wrote:
>When handling an EPT violation, KVM holds a spinlock while manipulating
>the EPT. Before entering the spinlock it doesn't know how many EPT page
>tables will need to be installed or whether a huge page will be used. For
>this reason it allocates a worst case number of page tables that it might
>need as part of servicing the EPT violation.
>
>Under Dynamic PAMT these pre-allocated pages will potentially need to have
>Dynamic PAMT backing pages installed for them. KVM already has helpers to
>manage topping up page caches before taking the MMU lock, but they cannot be
>passed from KVM to arch/x86 code.
>
>The problem of how and when to install the DPAMT backing pages for the
>pages given to the TDX module during the fault path has had a lot of
>design attempts.
> - Extracting KVM's MMU caches requires too much inlined code added to
>   headers.
> - A few varieties of installing Dynamic PAMT backing when allocating the
>   S-EPT page tables. [0][1]
> - Using mempool_t to transfer the pages between KVM and arch/x86 doesn't
>   work because it is the component is designed more around maintaining a
>   pool of pages, rather than topping up a continually drained cache.
>
>So don't do these as they all had various problems. Instead just create a
>small simple data structure to use for handing a pre-allocated list of
>pages between KVM and arch/x86 code. Model this on KVM's existing MMU
>memory caches.
>
>Add a tdx_pamt_cache arg to tdx_pamt_get() so it can draw pages from a
>cache when needed. Not all DPAMT page installations will happen under
>spinlock, for example control pages. So have tdx_pamt_get() maintain the
>existing behavior of allocating from the page allocator when NULL is
>passed for the struct tdx_pamt_cache arg. This prevents excess allocations
>for cases where it can be avoided.
>
>Export the new helpers for KVM.
>
>Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
>Co-developed-by: Sean Christopherson <seanjc@google.com>
>Signed-off-by: Sean Christopherson <seanjc@google.com>
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
