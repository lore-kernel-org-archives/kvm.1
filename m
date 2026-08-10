Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEB27F728;
	Mon, 10 Aug 2026 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345689; cv=fail; b=Nhix2ogJIt6ngijFPLKWtGXE6mhCf7sXMlru0q0DVIkryOu+bWb3jwFugogSiIGsnbBkuWfaz0ACczrGS7Grtv/keZ6fiWpYwclmMJXK0lDf8xbAzyyCClWQr/9To2wP24vpX+G2kd9cUg06n39lVqFqeJ2rlOL5jbqUq7EyMgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345689; c=relaxed/simple;
	bh=XEGrGD/fOFSxe4Vp9TTS6lTtrRvq3luG34FcDkdf768=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m/Lzj4Fq9DIwwTNZBpxIjWcq1AVzRFOEdgl3wHQa0i2WNea3Ld/QFV6VUbuqRSEBD7UnNA3MMX9TfVtilF9cECGUUyygRpgTi5wvMjcY8ebBd/mc8z06ZDQ8AmcOiVrexmpsNO+Xa605nWbM020KGEqIX7Z7TH6d9GtsjnSlQRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+c6bVEc; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+c6bVEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786345687; x=1817881687;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=XEGrGD/fOFSxe4Vp9TTS6lTtrRvq3luG34FcDkdf768=;
  b=W+c6bVEcjOIV9Cri7U4aPBgShE5niNIXfL9upgLw46to0ITVES6Ww8JN
   y4Re7LhS086MCYlPWCem/mQaADoalXpkQ3G7rrO8O1GBygqhOPNqWPM/N
   oBajbQT0luvbsi9lfEBCB+CJ9uJeLQpyP/FHF2I9t+GW4VgW6CV9dnWvh
   SIsdrVH+3yoL+aT9fWrtwVaOzKLPsyzbTm/W6zwCpuOkFuQRRvlY2UPyQ
   /b6J4KIcfBfywhWX4b32cbSdTeyPK8mxoExcYmq5nlvj09PZF/gBfFzd/
   hSfXn/oqZDZMZVUNpKy7gJ+AHLERK4ujMMoEkiUavkuQ2wiuTOl4aLz8U
   A==;
X-CSE-ConnectionGUID: poRuv6ziRtCBNFs20sjICQ==
X-CSE-MsgGUID: txwc9KOXQ862jj0NW5Vwow==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97449357"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97449357"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 00:08:06 -0700
X-CSE-ConnectionGUID: n5cBg/04TO28o9mJnS1aHw==
X-CSE-MsgGUID: CJlvaYD0R5SGmn8fNh2kXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="266446285"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 00:08:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 00:08:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 00:08:05 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 00:08:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u73Tk01v3XEL9DL+OJuSqyr5jx8BfpWHB74nuoiEXGZwcpt11mEXg00cMqwm4bP+bviUXQyjEhmy5CoQkdiurIBqGdEAk46u5SEr33Zl210tg24gn6/tHQCBXJS+/ifAP/+OMXVYvVofh2XJgnIlO75lkAaA/lMu/bJWjmXm5Cd5MOIHNFQ/drmrQT0dIZgQWhyawO+3ph+MIEuvLXY8Au/byICyPsISkjxl/ict/1hR/dSEPiGBYJRlcDV9oLJAfNCTi/TamGcg76GenqRN9oeMTknTFm1WTaLKOpyhvp0LO9VrQ4DZyJcCaU+0YEamOtiTV5Nph3hPbQSJr9DS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVC2YVCOLMUmRIRTPDDpGa0Ti8CeWJCwQSXxA1Tfp/8=;
 b=bjMvVNsKKmnYivc3qPVATijHxsGqCGVomfS9Qq9wxR0x77Yi4YAs1LnvCFYXwf2JrYzXnpSLI4MfMHHW0SUqUGaB25cGn97b5rD1tO8+AYZUQDDrl1Y9Q2Hi+f8eHst3dlhKNLUc0CPP2735P3BN1plNa+wIjcygt3eYRDcnblZhTB3Fohu2kVuv8hJGhdmyG8RRi75hZZqkRNXtzlm7Y5bz2P4t+qv9U8CKfgwrDvhcKgxk+Ei9SS2QIWpv6IKp/zmtX8wR4YbE72buZaHu7R3ZLx4fHym00AV9MKa7oE1VLKOlrwxkTp5zQduaGSHm3y8nIc5mm4kHnmRzk1B9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by CH3PR11MB7322.namprd11.prod.outlook.com (2603:10b6:610:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:07:56 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:07:56 +0000
Date: Mon, 10 Aug 2026 14:27:08 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sashiko Bot <sashiko-bot@kernel.org>, "Binbin
 Wu" <binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>,
	Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: TDX: Reject INIT_MEM_REGION if number of
 bytes would overflow a u64
Message-ID: <anlvPJBjr1SaDf55@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260806170602.4112602-1-seanjc@google.com>
 <20260806170602.4112602-2-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806170602.4112602-2-seanjc@google.com>
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|CH3PR11MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b2c281-907d-497d-bb8c-08def6ae1a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +cYg48Ncijf6BWuR9yQZauIZ3yiOgtBYzQbkkGNFrHXGvQ9den5ZVtsTw8UnaUxLJsE/q3dub0v4KdpShKeJezTdfFydIoyzt/MBUM76MyMT8XL+ArshN1qAtvid6oD4yD96f2eV8PA6eigeSW+nhZfXOmGFQr+/K6D1fUm/7J/wJz35FJQ2DIrtxSNQhJstwbvb2hfRJCGQ73IZ0ZWwk/N/UkX9R49zU4n75Ayr3jwfxLRgST2f7sbPbFdsPMK8ySUhO1QFGki8igvtvIJ6sUy/pKf2kTXmjsU+1k+fulyIz22q/rppp0uAEC+h6sAFIvbkKzgm1n4AMpUGrEAQFrowW9hwmy2G1ULZdU8OeuTRymsDRMEKiCmUr3a96+JtL7DVhsyWVlppzYBTocF1HtHFq8BqmR84q1cEhwHeoIHKIMAsHoxP2yOY3gxUF6RWrW7n6Jy5HeBC1S6RqQUBU2hSDgk1VIrkKYto7GESBpz6AbCmOGkWvHLX+gyCSocFhhugI+6DxR/tzrD+F5DSjVGKMj7ZgebRwxdRUR9E6WpQHHpKYo/0SKS8roHU8gippgqYa0HKDPDJMKfaDbvCE4RDVr6UFpLkRxfZE6iBQvCtvy500bZCk0ZKX1T5z4ZffmdZMwjySKxOautR41rJ5NTiCOBrbVx2tN+mG+P8q9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AxG9VAk9vtRrPSYQ6h95HbhDt9kwLl0VG4CAT6QQVcDlCZ4QBwltj5gCpZVO?=
 =?us-ascii?Q?WFCu7YenpBySB1hN/NSgfjhF44IhOiP9h2EMgoeBfBWZLVA1dQyt1glLnULy?=
 =?us-ascii?Q?lIbVHmmMNuUjkgixeXtRsfu3RWyYovMfXWTSH7kkhQkyP1rE3Lpm3qjcxQLi?=
 =?us-ascii?Q?EEyroC3ZyyAjTRqprX6Dy/ft8hZ9CCWlyl4uRxsiuLOuwXGZsZtsru1jgife?=
 =?us-ascii?Q?hOxA+W8lcHAgeScWLk0BmCtfoVSVXbMpO3yWt5EZqzZu3kXuBUCHPpMM0zWv?=
 =?us-ascii?Q?Jp0jzRrRvRsw+bNHRCxRmxzba676JtbeFmZKVgi9yNfadH+JzEwF5p8r06Kw?=
 =?us-ascii?Q?JAoZzEuOD+dsjZZ1HrrWoqIcIR5zg/+QScayNak6Y0SrDAX3hn0rTjkBtSQv?=
 =?us-ascii?Q?OP/PH0IPdO+ii+yrvBxKS0ThOKfVNCim2894JleP9SyGfMHDu3KajP8blJaG?=
 =?us-ascii?Q?qOEvOpD+dQ1I+NS+QQ2481H2h1APZlOqQnRax88rraZZbVBwDeOlXrGy/0vL?=
 =?us-ascii?Q?booJVzN5anucXzfNmiN4tBLyIx2V/NeI9d+AZ9k2Bp/TggFu7t3OKpNwv+qE?=
 =?us-ascii?Q?Sqci9TdxRrBdFK8fB1hDTpkTxxn7XxTHQ6Q29AVdWLz/RizfT6Oh9MaQtnkC?=
 =?us-ascii?Q?po9O1weC/1dWbpEJZWQuhjS8jo9/HLj4Mn9sNxL+xdUw28abqKygV8fX/LfO?=
 =?us-ascii?Q?CT0eDHQGetFSS/2rJbV2F3zX5Kgkjwayre/YMQJ6rrWXSOIxnXqhz7IZqti8?=
 =?us-ascii?Q?iFWDDXHCO3a+e5AZQMabk362pmePPhsfg0iCViNZ/JHd0NB3e0NNzv8CPYQT?=
 =?us-ascii?Q?i1psKhNmcE7L9T4NsY3YlQpS9t11yRk7nwLuyP2GtK/btyab/u51KsOJrTSS?=
 =?us-ascii?Q?YpAcRqMNPqLxYrIc+10LvLkAY2E13UgFZK+9MRVkjPjwGQIq671Vu98/VAG+?=
 =?us-ascii?Q?cKPyjZymnwHArKYtRsBM7S5yfJXjzWdcRO0EvkYTje+iIODLRwOF9PgcVdKj?=
 =?us-ascii?Q?JuMsFqf2T/TemH2GKfsp28eu20xRLkzIgbaNou+N+DFs9hbxUJu6Chwp3GEo?=
 =?us-ascii?Q?VLw3dP1jG1yXxGyIhvAOqz6DvJ1w69R/1JqprONBCkxJnnaayQF/vFb2CgxM?=
 =?us-ascii?Q?zlpngop1xxMEZsMNvJh8Nf5q/yjbDgochFUpDkuR1Nka7i15AF3xXCqcgL/U?=
 =?us-ascii?Q?JGX7sukT86gyOz8c6AlleXXE7pWagFPOfNURp7ZS/jVBaOv4BNdBoF+NGhKU?=
 =?us-ascii?Q?lRVuaE3gyrQUQ0V3+VXyW9GdBya16Kw+R2yQDPNiC2s97yWlL7kzKgp2ZfOO?=
 =?us-ascii?Q?29Zg2v70mV3oEc3kRCm0GIjhMFfaBKCVx6YPnMalWzUe+S/6lOlzWK4ZJ/Vf?=
 =?us-ascii?Q?0Wwuy89jpGApkfT5XNC8k76pJ4fEgo7bXrUxJ8Up+It7b0Q0YhMOjCa3Vng8?=
 =?us-ascii?Q?rOXXZK5iX/Hosn1o1ow6cwwo+llK3sAIj/q2DmxfSde/Bjm+vjU635jFfDeP?=
 =?us-ascii?Q?+s7g9IRvL32eHjmX0Sw4K37PHRkrC7CaDjyFdVp5wZ4KqjfeDdboTq0SHnpg?=
 =?us-ascii?Q?0NpZ0OikZIVLHX9azNYFlRgwtxKO2PRFuW9YXi/MVSx/mJB9BArf4dga2q7D?=
 =?us-ascii?Q?7AEqkeIrr5YDElckUy0R7yrmVWtNYiTcul3gR6h6zlmfQQcsXyXcM/Z1cR+P?=
 =?us-ascii?Q?D4/+0GHJBrcEG7qB+4M48JhrakmhPxrEWJ3zUQnXu4CnIGyhe2rpHdpHUuQ/?=
 =?us-ascii?Q?c/YIpINV9Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: IFM9Z6cJh2fxkp7U8/rCMjLa9b/g8Vlc9yDl+2Val7mVWWsebA/V3/1zrIGxB/lokRBBI8ZzHnAKAW8vBG8vrytgRAKn8y0LCa52Ns95XRcdu2uGmLDvqLTAXD+PX7lswRv62RsEOcQwkNTV+PISAyuzKsj6hJvNm6U7+XMdipmFWFbzclRJ+XAlXAw6xcwxaSHNBGkjhDtkH5mEBblJsV0Yj1ypDMIworfp9mNcqJOXjTgbxBeB+FiFCl77df8D/ooVvtOo3bmElLWHM7S397+NMo9rAY8S7nMIb+dU4XamGp0/K/IZxezfBsdCihZVwBPGTAPFmrhazjMkGPy5Jw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b2c281-907d-497d-bb8c-08def6ae1a45
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 07:07:56.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPIBTeow+E+lyHIvN80qFle8WMIbZkhOBQzY0KXsbpfg1nBxdQ+6oFGcotyOQg8s//8HeaPplF7z2Ps8FlYXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7322
X-OriginatorOrg: intel.com

On Thu, Aug 06, 2026 at 10:06:01AM -0700, Sean Christopherson wrote:
> From: Haotian Jiang <jianghaotian.sunday@gmail.com>
> 
> The nr_pages field in struct kvm_tdx_init_mem_region is a u64 that comes
> directly from userspace via copy_from_user().  The current validation
> uses a manual overflow check:
> 
>   region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa
> 
> When nr_pages >= 2^52, the shift (nr_pages << PAGE_SHIFT) wraps around
> to a small value, bypassing the wrap check.  While downstream protections
> (gfn_to_memslot() returning NULL for GFNs outside any memslot, and
> kvm_slot_has_gmem() checking for NULL) prevent any actual out-of-bounds
> access, the overflow itself is a real bug that should be caught at the
> validation layer.
> 
> Replace the manual overflow check with check_shl_overflow() to correctly
> detect the wrap-around.
> 
> Note, the manual wrap-around check on the gpa+size technically has a benign
> off-by-one bug, and can also use check_add_overflow().  Those flaws will be
> addressed shortly.
> 
> Opportunistically separate the initial sanity checks from the more involved
> checks to try and make the code easier to read.
> 
> Fixes: c846b451d3c5 ("KVM: TDX: Add an ioctl to create initial guest memory")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260630214952.98C851F000E9@smtp.kernel.org
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> [sean: use gpa_t, isolate check_shl_overflow() change, tweak changelog]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>

>  arch/x86/kvm/vmx/tdx.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b272c20586a7..929115aeb9ec 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -3219,6 +3219,7 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
>  	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
>  	struct kvm_tdx_init_mem_region region;
>  	struct tdx_gmem_post_populate_arg arg;
> +	gpa_t nr_bytes;
>  	long gmem_ret;
>  	int ret;
>  
> @@ -3236,10 +3237,13 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
>  		return -EFAULT;
>  
>  	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
> -	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
> -	    region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
> +	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages)
> +		return -EINVAL;
> +
> +	if (check_shl_overflow(region.nr_pages, PAGE_SHIFT, &nr_bytes) ||
> +	    region.gpa + nr_bytes <= region.gpa ||
>  	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
> -	    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_SHIFT) - 1))
> +	    !vt_is_tdx_private_gpa(kvm, region.gpa + nr_bytes - 1))
>  		return -EINVAL;
>  
>  	ret = 0;
> -- 
> 2.55.0.679.g6767b8d81c-goog
> 
