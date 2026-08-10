Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94EA373BE8;
	Mon, 10 Aug 2026 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347537; cv=fail; b=Xd1s3ORioNJXO7PBY1qXhWYJMdt61AaEd5dmSR7exQ+bJNGL+CZrwyipCdj21DkLC+u8/L4nWOL6HAZ964S9kfK463H2oOu3zNMZJc7sm+UjrSIlAcCZYn1Ek1qO5wT3Af21COon9Gf9fPYtX8ckA5WBa2yDrBxy7pOLORS+/bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347537; c=relaxed/simple;
	bh=KkoGIpvDC3VC7TD6P5LZoW7dCrPJSHSdQx8NVcDCDJc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tb4S16u+4mVERQK7iMwTbB30VxW/mEgjHuecM7oe1ddAcHiQVp9iSQA1uqoNFLlCEPxg5De9+14Pn7En3s9MD5wvfe4GY959zK2jQrH9IC75C2irbbulsjC0ZujMApSse2PxEfp6d0GGoDoFZvI4A/JK9ro0iEouf9Ttm1IpiCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7fge2iE; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7fge2iE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786347536; x=1817883536;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=KkoGIpvDC3VC7TD6P5LZoW7dCrPJSHSdQx8NVcDCDJc=;
  b=c7fge2iE895QADl0n5W6w/ofjQmHs/vKNfLGHZMaOYo8KeJCvDUuPQyZ
   FPxYvlqxNLTRKFSXFJxeozZxxPVZgybDU/Ch7gtDcor3Y1Cymin3FTKaw
   nD/bhqj8bwdhoPiomwFP3Zp3L+wa4tZVInI6UQtH0+Etz63u00cgVy8Eg
   hLEAZyp2cYM3XNHVkzAXokDtzUbKIUqzNwAhTDIOTZxrbsnVYBL0lzwqA
   e22vKFRDtZC8yVZvwtw8eQTgp7D7LRPpFZu2Z1QEjyb2IUlU24uFXW4Ux
   Qk0gHDTGNXu9d7bY7Y4WCUmcnuX+zeCOlcabR0pyMAj6TsDNTPBLq+f5N
   g==;
X-CSE-ConnectionGUID: +KZPFbn9SXadGMZc/ScZqg==
X-CSE-MsgGUID: jRzVZaUZRs6kNrBTtp7rkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86793018"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86793018"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 00:38:55 -0700
X-CSE-ConnectionGUID: dU1JejN3QeCpv5xR87v08w==
X-CSE-MsgGUID: 7SkrqbbYQFaH/zSRbpMh1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="267215563"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 00:38:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 00:38:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 00:38:55 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 00:38:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNqP+zaL6wUoGWU3ZP3Vc7riWvLER8/tkwxf641QH3VKkpzcxi8IIfR77Mu8Jyra92Dv80zELnxlP+AuZ2T/3EW74X5tL3xOd1Ml1ifo5hOL7HoTh2ioNn0Q9MSTbVNDIk3lruPNl2DBexNe8dMgnDxxwgCKrluq8pfhqJmVM1wCJVnfuhTL7vCOTk4VhbkKdxMHhxWdE4o7PXEzbXkODEDKUkBHSEd/sDV8BKUl6Udt/AqTbX2xY20DmSSZvnwbJUJDIRvpjjB93AYFPfMLyLc6FpGIp/Rp1hB40E37dltW6Tu5xyWzDbGG5On1jCzJS8i00B5KjEUTA3tHc7Tang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHnw3zkoxY1BtaD+bVK/oJ/of1gSk6Blfsry93nP4Zc=;
 b=ak1JvQEdcUWNnPvzuH8DHH7Rrms+FI3A8DyRqz2zhsr+4twUtadKtaRgOi9olt1gHKGOaDZVvd2aKOHkCC5subqZa9Z9DwC3OUh49gcYK5hMVa4VeG/ipvb6h98GJ4a2X0ZwW6/yGh0XVrmiMqKxZwmEEC4FmYtTqQCtUZaxiEDxOAaSZMaCIH3qP0GaWSUrZYj1Ozbgcn+OE3UjHw9iC7KxsjhEelUpVn3WyqaAaAUpNCilpQnD53Jj/aBXFj432XbIwOcup1u47xHFwFa8Nh8NM9jqRi6dY0sqh7Ib+jY8wjOi7I1eD2gcQCeuSE+cMljICp8glnECZrI66dahWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by SJ0PR11MB5215.namprd11.prod.outlook.com (2603:10b6:a03:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:38:52 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:38:52 +0000
Date: Mon, 10 Aug 2026 14:58:02 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sashiko Bot <sashiko-bot@kernel.org>, "Binbin
 Wu" <binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>,
	Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: TDX: Fix a benign off-by-one bug on the end
 GPA for INIT_MEM_REGION
Message-ID: <anl2ep3EicOxckZw@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260806170602.4112602-1-seanjc@google.com>
 <20260806170602.4112602-3-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806170602.4112602-3-seanjc@google.com>
X-ClientProxiedBy: KL1PR0401CA0032.apcprd04.prod.outlook.com
 (2603:1096:820:e::19) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|SJ0PR11MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: c07227e8-6e05-4a43-8a99-08def6b26cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 7k+IuRZY1pRRsVe4ZDiMIFqgy6S0gSCy/9QVf7u4U2/wv4kMyK/GNa+aWdIj+fpZJ/2sPmz6I7F6ITHq4lbYjAsk1F09RJR2ToU+QjrOcODYQCGiKpqEenI7cJ+QA3PKPOdiU8KkhklCSShp4+amt59F7ZZpTmNmgBq8Dc04BbuRIDPrKiR6oTNsdVrjsPlIufQNZ9g0jnVlbkl9EpY4cgO0bFVgbGRjj68tiUgGMNRdpHvD2ZL/41NttJuXxCVP+oTF5omwGkWK4FXuEMFRKKrstzKouxD3GRdjRU1dKHEIr+U4dwhfEhYFUqaBUcXHYHrCUFV1PZlsyOlcw7pGb25sp0kKknTda09JBZ8FncCHr8mHnVkVWtqT5Pn33e85fIn7gRbeNPV/gJHoIb8ebN+X0HM0DIxz4bnViaI45W0btdHX5Qahcn1CkYO0d86EcxL/tImjJ7kqpYPhRIa0Us+pSk3EKUGJqIFDwgiMSBhReSh4dtkUEcuyaHKovbuAAIr3V2QI+VtlURxnXr5n3xH6cl+E8b61HJ1tvKpNJa8qATKeoGPVtMx8S38KTLWeiH/PEzMgW9AElQsS5WSvE6RuDtgzGgSXwp/jGGfOpm+y41IysyR++HDzyXuBGY2MSOIdhRFQ89RHeVInr2C0RBkO45jk/lGnCQ6vf5nbX7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRVTikxqa53KO6GrLh/n4SadLrHifQiefEXGNlRPlVSqSCk9kpoCxrEdqX6J?=
 =?us-ascii?Q?GOmvIjdSQlUj/0RahPxKCDwxqqd7Q3CztYVWgR3TplEMFo7A6mvyTWqA5IJw?=
 =?us-ascii?Q?dBrL7O76RFhFYOg/hqo+sRySRtiQpEfKDUYaee3Wzti3gMh7LUPHaHxxNNSC?=
 =?us-ascii?Q?wt7a4JCmgllaRPNbUQxXuuZ/+kTqhvHQxttmZI8JJBXiaZ0KCWhzBV4iQBsk?=
 =?us-ascii?Q?ADTUBZVzoR+7O1dMPowESS56B2bXK0sk8Lrh6xWB110al9UhT+dN9zuQQXXQ?=
 =?us-ascii?Q?TcOHEW621C/lMPejT8EIIGL9Mjhj/fOY+OgMKGw7cMp3VZng7Rmd1wi6++RT?=
 =?us-ascii?Q?bE20mKgrniegYXTyLXdkFX6u4WFh9ufqjuwoTUM9kSYm3xpdd7Kah7RBlMuX?=
 =?us-ascii?Q?fYFxJ0INSe+INrLZSjMfKRqg7BwCVq8+R8hn4wPzpc9FdOyBOo42UNA/aPp+?=
 =?us-ascii?Q?5j9Wc8qoUzS8b1rFXqaFGeIs+eT8YOyapl0J9iyT3nenc9yokpdZl4GF09hh?=
 =?us-ascii?Q?fLFvC+d6eQPMSTJzwVztcUanwX8mO69Gj3rdnvO0kEGzdhuMMqWraOAhpVAG?=
 =?us-ascii?Q?OWgJb5+s6Pv7vpIPVgRmEKXfHbgf7kBlWjajH2Q810SQ8b0S4vGrzB1NoD0D?=
 =?us-ascii?Q?YLenPJdGfUdw5lldm/9YvAE3KjjCYO10sVa40GMiIzecC0lReEMBlJrHhT5t?=
 =?us-ascii?Q?F1U/OSxszdxnQuYmT6x5uJTX79Jvpp7xQzZM4usDbxW96XCBAqDKpz33IUyL?=
 =?us-ascii?Q?IwaawLxSgQIvwsjCbbh4besPJMI5uH8v2yZalcSK0knhexBVfrkwGloo+UB2?=
 =?us-ascii?Q?tHUhPASUGKEVr8AROqdhBKnFGeIaqJXsF3v+jE5Nmw8sJLnF5XkjQwT5mndz?=
 =?us-ascii?Q?kQIxuLg2aVNrmeGiRL+VqPuvO3HmL7HgPIymYOhbSgrGcZ5YR29XMgHUPqI1?=
 =?us-ascii?Q?tPcXV5+QSaKxBR0hntEqgANbmbiN4MDXi9VptfBIKxLZdOUL0bVzjW8+ZFPP?=
 =?us-ascii?Q?jYh37ZnqHt85cDf9dFhpq1y0Ib+GDLMTlNXEH2OMbaQYryx+fHLhM+gsSdJT?=
 =?us-ascii?Q?qH5BhL1NCKMUOBbEshE/Jossoq2ub+SnfJUF0xcN64/1vMLUsiudtLqAENrB?=
 =?us-ascii?Q?hLsOWkrD+E2ZTDuTeTq+vPDA03LKxzpUSbts0bC6ntnnZnwaqho5Mp4TtAqN?=
 =?us-ascii?Q?cIwF6JM5Zr+h42Yat46sI2juEH7ShPk6xWH+GtEip1W4rg/oIkvroPkEf5bH?=
 =?us-ascii?Q?QkulawruPFiEMVnsqM4LYLIyvmh4mX9qM414b82XeLbtkgD8L3aXa6DI2bPI?=
 =?us-ascii?Q?PXRHWs9wukCB5QoAVUZQtJ3AZcplCabJgnKRVIzaP4FhS0c1ir7e3FdRUlf/?=
 =?us-ascii?Q?v075eHq7IpUBI1XE8ACnQbc77hTeZKCXxozscTCsEquy/0uDF2cnFI7ExKZT?=
 =?us-ascii?Q?gnO/5emdjtCsjFsQMZ7qXw5WbuygtGkBAqx/pJzsB40zzEAFIPzzeE3ws2ls?=
 =?us-ascii?Q?Srt22WUK+ud5B1HsBOxOJa3rPMMlZid8M5myYXBmZluuOKFt8P3AsYe9donK?=
 =?us-ascii?Q?oTQcQH53BDAbDkrSfqQyp3H+fhD72lo/jVeT9EZgXuAgXzQWmhrWIBhC+0xv?=
 =?us-ascii?Q?ESyEbwU93NbmG7E15qIDbeS6OGU957TVBkd3/6leSx0VfqDtNgp/HoA8hbqE?=
 =?us-ascii?Q?K3mhUd6yucJYBdQiHZV5NXMHoJW8gYUDbBZVf4ocIyR/QcO4QO9IqBkkU5Sy?=
 =?us-ascii?Q?W04QosS+rA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Pwtj/OkcZI+4ZuGew8KAevqp64UCTBLc42+vfz9stI8oa1mlnWV1sqZmSzHQwXRTutnRnTGgGvySg58HSoqhD2QiPlegDwGhCNmVDPhY2suY2uncCym2xrtT9rqzojmuJT7zlaLT5nKSijjgwpv7QlIYCTZNGXPkwEzq/Q/DmJ1HAv9ZZIEDDVpC+OTHpT+4sfJedqYFY/0hSkypSHc9v8XTvN1cJFt60WtvpRIeO4Uf4+rwJbmQpFaB1V9DDNDHD4+06WnJKQg7YNHrP0zVRYyRic9B/kwpBFnd9EZ0Wh0TNdcHZk1ZKTSP4Y+47HbSnLnIydc+xt3cSYAJ9umpoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c07227e8-6e05-4a43-8a99-08def6b26cdf
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 07:38:52.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzKPx59jl4froRAhvNS+CrXLLpqIPUIa8xjK224xGtVet2NI0X0PKeSfaUCwlkkdeBNDY25c2aSTpaZ7uukyqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
X-OriginatorOrg: intel.com

On Thu, Aug 06, 2026 at 10:06:02AM -0700, Sean Christopherson wrote:
> When verifying that the incoming GPA rage for INIT_MEM_REGION doesn't wrap,
> check the inclusive last GPA, not the exclusive last GPA.  Super duper
> technically, it's ok if the very last GPA is -1ull.  In practice, the flaw
> is benign as KVM x86 disallows memslots with GPAs that exceed MAXPHYADDR,
> i.e. INIT_MEM_REGION would fail with -EINVAL anyways due to the memslot
> check in kvm_gmem_populate().
> 
> Opportunistically use check_add_overflow() instead of manually checking for
> wrap, mostly so that the inclusive math doesn't need to be copy+pasted in
> the "is private" check.
> 
> Fixes: c846b451d3c5 ("KVM: TDX: Add an ioctl to create initial guest memory")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 929115aeb9ec..85699ea021fe 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -3219,7 +3219,7 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
>  	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
>  	struct kvm_tdx_init_mem_region region;
>  	struct tdx_gmem_post_populate_arg arg;
> -	gpa_t nr_bytes;
> +	gpa_t nr_bytes, end_gpa;
>  	long gmem_ret;
>  	int ret;
>  
> @@ -3241,9 +3241,9 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
>  		return -EINVAL;
>  
>  	if (check_shl_overflow(region.nr_pages, PAGE_SHIFT, &nr_bytes) ||
> -	    region.gpa + nr_bytes <= region.gpa ||
> +	    check_add_overflow(region.gpa, nr_bytes - 1, &end_gpa) ||
Nit: explain in patch log that check_add_overflow() does not catch the case
where "nr_bytes == 0", unlike the check in "region.gpa + nr_bytes <= region.gpa"?
However, this is already guarded by the preceding "!region.nr_pages" check.

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>

>  	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
> -	    !vt_is_tdx_private_gpa(kvm, region.gpa + nr_bytes - 1))
> +	    !vt_is_tdx_private_gpa(kvm, end_gpa))
>  		return -EINVAL;
>  
>  	ret = 0;
> -- 
> 2.55.0.679.g6767b8d81c-goog
> 
