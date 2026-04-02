Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C02DCF57;
	Thu,  2 Apr 2026 02:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097553; cv=fail; b=pbNGdGDf2Fs2ALjdg6RtWw3Ew0zNfGiqZtBg/PXjDPDmPOTi63HYo4Yz3qPTKOhetJ+nTNeN2Fyq1IS2m6H9darfQIBCtklIyAPzCCAs//akn6ssv8B2Ae0KQRRLWYDx317eEeXLxcYgetMI068QZxZyEWkX4s0Aj1xTZXZx2x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097553; c=relaxed/simple;
	bh=DeAruTgrxhSIzx1e3Qa9ExyKYVL626o31G/GJ4iDZBo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nj3ug6S/8DZDM0KZCnFhOr4SG/Z+yNX9moJUvGRjSVAONGaHAHk6GK13RlrZmTrrtvQ76a45Agn09xPGTgrb3w9Tgy5JK7/Z29xP1zwLKZnkZdRd43pPV7SNJ0Fo0EPK6jwjdrz0WQLkZd1xzXw99b1u/qT1ECChGx5lQsn0Wd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2pT2oXv; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2pT2oXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775097551; x=1806633551;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=DeAruTgrxhSIzx1e3Qa9ExyKYVL626o31G/GJ4iDZBo=;
  b=U2pT2oXv9hSpW60qgMWIONyHER5IpWE4Mgs8vaHohiSHQOWPXX6tzeDa
   cBKCJznUEiep0hbhRZTv7QV/aS5AXaocmETs/Ult/1iKTwmDJEy9Oft9+
   22n1VMbymov8d2B0khAoTGA2d34+WeZVXUa811CuY8p5uOotfiM9tlx25
   8qy3bTQY3OaTtOTFN1x+sh3cKOTIwWT+lJ0iAGjqz4u8k0sHm4dxERcZj
   tScv880pMLJ5eAvxOuBgbF/mzZfHI/KHbrHKISQB5z8mzFiPwm/YaR9tu
   C4ySgMSjfvZJpsihkLsCUAbTHmECHkoLsgNvkvIRen00H+LQx2pSiKOQB
   A==;
X-CSE-ConnectionGUID: UTdAFPuTRBWrm9neatS+jQ==
X-CSE-MsgGUID: WVWJntOQQIaUDKs+iW6dNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="86452809"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="86452809"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 19:39:11 -0700
X-CSE-ConnectionGUID: YnHnFhFXQzm0B90T41g3Yw==
X-CSE-MsgGUID: M/nWgm1SRkSLVMOwTx88og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="230918946"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 19:39:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 19:39:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 19:39:10 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 19:39:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vgu9W1EEilixfYnI8eGR803y382Ed0mHo+WqsyENvtqasjBozDk7vdWIKSp8roBjYqgzWcAiasPfecpyUKhsZdVLKpYkoA+ZHj3DbvQtLr8bqCj6yrP/dYIBPfBHc2/72rArS0xqQsE3ObaPG326f5L8Ufo0L25uLtgLlHDmWzKiBYwHC7t6G5StzRntj3/9e+iuLe7IOa6iSah19TaXr4PQ5AfGn8FMtC3iTSig1jmaYY0kABqmxZ0YOF/aEWeCp1OFFULLmKg8qLN9NQiiRJLIZmlm+Hin3F+M4lgc8j0LvnWMwCw7zKKTlPQZieykF1zRXrWzWJbzdpaItNYQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAC6gxMOU+gzI9Foml2VOFPGkJhkLU76lzk+M8gmblU=;
 b=FguZC4Glq0o8w+n2GerXTDa8DfFhRqTgjjqVvxDbIIbElPZS1jNbHyGRXhrkFcGnAxRRgqSspQ0p/rjrfEvFr2B0NIaL4IKFqg/CccNvQHWs/xKIWNuvric1PJEHZGjeL1Zbd0viR12IXIYFbiooeqDYCMg1UycYYCSdE/BlQ8dqg+n+kKTF8DiBA8D6DOAmKcIGe1u+Dqp0oERYMVg+am5qUS0urM/H1D3YwNzes3du+ZSeDZpyvR+li3PDqDLoI+S6ygrP1hMg1ewbqnJ+3KLEbbh7yDycN5jrqR3KyBDSGqs5cfcF4DE8Ua2MM3a0YRjRH3x/KtC3NAQMg5n+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DS7PR11MB6294.namprd11.prod.outlook.com (2603:10b6:8:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 02:39:03 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 02:39:03 +0000
Date: Thu, 2 Apr 2026 09:59:31 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Message-ID: <ac3Ng7IZpzJczZ2x@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
 <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
 <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DS7PR11MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 935c8786-1e57-4722-7901-08de906100e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bZgB2UstQHMz5qpjbn8oRA2z2wfEIw5uPsgc6mjc+YdqLZLu6GzVWPVp/+dvXu81zYU2ifc1cltN3AKZiGW4n3Xo4XohrAY3LMsklJpOi1yfL6+GrpuPMQVKnA4/KCTo8gCopa2XC1cy1VQTBl5+lhiGQocMuvK4+nz2fJ53+hhfzHXtXMdZeBAfJxehBbwlemaNnfflIDY60pBFSpbThGtqCWYL31KvMMutHORRpMdE0qiSDjXrz9O4lmxRf905arYo6NEw4WAdPBrHPde/OlihXLNqk01/zRyC8WxvTi0MI2xNcSWmcbVxCOu+fiJwEXKNV4HuyNvLq+yLoOkVoVVQIAXdryUi4QWf+EjdcF9c6Sj2dEKaN9DarydLmQ2bMSTS5Uw2yVmqCLMAXCqg5egxjCZ73J5Fr6N3fSrvHawhDNLoqBQumz/4F8ugnlj29n7VWicRNHqR6Gl3psJIidOXkNqGAKs1syFRzI6EJGk1RN/yRnVSS4SNlyWviCj1Y5acGvF+6o9AxjQwNMtfklJj9npp0NMOxf8AOQDvwPMz5opBZiYKB20rSlGc362O5lirz281A77CEHGwWroOPQwm3caNjfmqTwy11act+IMCT2FSsGqa/eefLI2s3z0tQkv8J1gTRs4HeuOhkUAT++tCUqyoJhKVjC5UPcx9o77m0NpMQhfJs4pSR2XS2TljvrSHcGtVk7tiVcwgF4yz2eUyT2RyorANF8+r3oEC+ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?25ZepQNpirMMhCXHh+N6MpdEedZ9/I4iXofOBLS2nVCkeqJ+nwoWoKYnFZ?=
 =?iso-8859-1?Q?Je8jONyruCpCuJTqimcQyOTztZrKFPk5xZEoNOeyFI1sDk4xTO/8g3/FyE?=
 =?iso-8859-1?Q?zu4xgz30TZ7dC1iEaddIJ8XW5ateuJJwjLvtREXJfUfD5gWele3MnMXo53?=
 =?iso-8859-1?Q?+jp9lE9iViPGUFAszFOJGqT4OmGj8qdQhBPOPDuJQHV31D6WDKIq+vqdaX?=
 =?iso-8859-1?Q?HX0iO5vCWMjdwxChEJx8zTE+f1ULBBuC2eSC3gb8MsXq/xBjNvF4OyF096?=
 =?iso-8859-1?Q?FEFd0l4xViWNwWCM260tTokJ9IguUrg1TXyPyun59WSygY24x6p/DA7Zro?=
 =?iso-8859-1?Q?samqbbcCZ465yZSfa1SnWy8KqF5QYK0VTLz76fMeZPcbbubir6RH4Po3nW?=
 =?iso-8859-1?Q?ZF8GPUxRLCBgvCQSJckJze/xu+gMTk/jMaSdLcJf0Rh2+ZNuzzxbubFVZj?=
 =?iso-8859-1?Q?kJmdQgHh2v3Pavi7M0/u1BM+Wu89brFPfW66/Q0UDhJ6AqYyZCNec/v+oU?=
 =?iso-8859-1?Q?zcFB83QIg6pIxdd0oI1bOeSuGAWYg0Ivq8my66ueHSkHutb1MaCOt5o7xe?=
 =?iso-8859-1?Q?ndtsF/LAeHjra0LMw6kQUHQgSzS0tgsXbdj4YMer65LKrdXV7iflinHb0G?=
 =?iso-8859-1?Q?XPj9igOaBi3fZ5RZFfeGd/dy3L6c2khII8K9n/wdbC3JrXU/dH99Y7a9WP?=
 =?iso-8859-1?Q?z0bjNW8XzKQfPqkuRtpv7j8aGr2f2wANo4rRq8LqBPj5Ottp6munPNCSj8?=
 =?iso-8859-1?Q?EeYRdM5WOeLwHPv6TAmUkY0aSqjpl/qcwvaFQl4XtB9uJ2CDTSx327ubog?=
 =?iso-8859-1?Q?pNHKCtbjF8+hX6ryikuQS9MWcViWgoTbNE/JXet3Iq998Dt+K19/eSxucB?=
 =?iso-8859-1?Q?hHLdQXXSueYaVKtsxQZ04ZAcEwWKdf1Ld7/g3YLEqVGRvNjhgtc6m07ViT?=
 =?iso-8859-1?Q?7Hxz/G5cCO4Fa8z7CR8Kf6t/diMqUpvHM4JsAA+UhfGSC1Ct8bC+XrF9vt?=
 =?iso-8859-1?Q?5YhMS/ov/s/uX7rbBiwUWSXEZHpPBYbyl6QkQ4osoqwNtdrrwlf0jJPVyf?=
 =?iso-8859-1?Q?fN+uLq/21AXwKyXSW/ilJB8frEwnOrgKtsvDNt9Gkt+lZ0wEyJ9uQI/EZZ?=
 =?iso-8859-1?Q?qnxekqYMN3qsmAWR7fEYSTdagkyAU9uuQIy+Qhx90kTZU9sOb2LHUkpMLt?=
 =?iso-8859-1?Q?rFq8uafsyadqcX9qysSYk3c7UOibBQYfnOnUFQskjWINgX0C56GKF9KFDM?=
 =?iso-8859-1?Q?GU6Cxu5kSbsVWp2H+UzB++8HiG/OM6OPFuYeRtbOhGAcFyE6Nj8dsS4K92?=
 =?iso-8859-1?Q?59H7bfmMuLrEa9zVlN/zhe7npTfociDStAIiZ+rXARX1pD5tCtkNBgc/I4?=
 =?iso-8859-1?Q?/H44QsH/cnFZmc7BKVMxqP4dgyND5+KgOU9IbXe5Pf8FY+KnplE75mC7Kz?=
 =?iso-8859-1?Q?KbWg6MklSa6rInrE8X3OAwOt9rvA2VtDKLlpWYHtOveCcBS4R9TgzSrCZG?=
 =?iso-8859-1?Q?6nfNn4zvpQEWp30nvYlVSXZ2FQBOzFOe4Vn1fvwmEaBrLAUzcahc/KMLsN?=
 =?iso-8859-1?Q?Veir2amA79gZkv0cqTxCX97CQ9R5v9E0GegOj1RYmlDdxK083Xk+nrlxyh?=
 =?iso-8859-1?Q?RKm0lxjv4Hv9J02FRF9v3rUt6X0OSRZfTEno5561MYHcIKwHrFv18+BSIs?=
 =?iso-8859-1?Q?5fd2ua+fEGxP56M0Dn7pv5/yhIFAGcaTPiaefXJL1X6oNrWTvuSAQew/EQ?=
 =?iso-8859-1?Q?kC9NSQHkm3xJsmJeVGU590jIwGddbdLoy0YagHcd7/UqFNolK1WdH+yMP0?=
 =?iso-8859-1?Q?Kh9a9Rfm4Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZlS4SI4qB345qv4Jyb/C/39oQEpUBtHAMpwPuFdJ0YtVgV2x05HKxa8WKrxKkhkQJAXLjU+4eJKXx/jKcdUBZly0iJkXw+ORCslHmDF3S/+ecVqrFneJuwUilgMOfJmCq/MSxTQP/MOh+fQVFPUUW2IfRp8zlimcNzH4Dft6tSLBtcks35oBISnpLvrc5jgRFOVitCMfYxOZPN0UEhkpmEyG6aCrvwOXwpD/SdIhLqC1DPnQuKK+KIIA6uXNkiEPIeo/6EAqwBvzZusitN2BgdaI9wCmEZd7ImpT7RyiKRQJdvsShZbrYWPxmcSV822cSZv5ckULvNVGBjlGVFwUVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 935c8786-1e57-4722-7901-08de906100e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 02:39:03.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAZyDRZLpBuwDPIArZ94cc5S/T9Hh5br8bXlYESmVk/nD5cGkz8mvY0mYwvJtDtaD99s1LedIPEP+77sSfDLRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6294
X-OriginatorOrg: intel.com

On Thu, Apr 02, 2026 at 07:45:54AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-03-30 at 14:14 +0800, Yan Zhao wrote:
> > > +	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
> > > +
> > > +	/*
> > > +	 * Temporarily freeze the SPTE until the external PTE operation has
> > > +	 * completed (unless the new SPTE itself will be frozen), e.g. so
> > > that
> > > +	 * concurrent faults don't attempt to install a child PTE in the
> > > +	 * external page table before the parent PTE has been written, or
> > > try
> > > +	 * to re-install a page table before the old one was removed.
> > > +	 */
> > > +	if (is_mirror_sptep(iter->sptep))
> > > +		ret = __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE);
> > > +	else
> > > +		ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
> > >   	if (ret)
> > >   		return ret;
> > >   
> > > -	handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
> > > -			    new_spte, iter->level, true);
> > > +	ret = __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
> > > +				    new_spte, iter->level, true);
> > 
> > What about adding a comment for the tricky part for the mirror page table:
> > while new_spte is set to FROZEN_SPTE in the above __tdp_mmu_set_spte_atomic()
> 
> You meant it sets iter->sptep I think.
> 
> > for freezing the mirror page table, the original new_spte from the caller of
> > tdp_mmu_set_spte_atomic() is passed to __handle_changed_spte() in order to
> > properly update statistics and propagate to the external page table.
> 
> new_spte was already passed in. What changed? You mean that
> __tdp_mmu_set_spte_atomic() sets iter->sptep and doesn't update new_spte? If so
> I'm not sure if it threshold TDP MMU.

For mirror page table, a successful path in tdp_mmu_set_spte_atomic() looks
like this:
tdp_mmu_set_spte_atomic() {
  __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE); ==>sets mirror to frozen
  __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
			new_spte, iter->level, true);==>sets S-EPT to new_spte
  __kvm_tdp_mmu_write_spte(iter->sptep, new_spte);   ==>sets mirror to new_spte
}

So, the tricky part is that S-EPT is updated to new_spte ahead of mirror EPT.


> > > -	return 0;
> > > +	/*
> > > +	 * Unfreeze the mirror SPTE.  If updating the external SPTE failed,
> > > +	 * restore the old SPTE so that the SPTE isn't frozen in
> > > perpetuity,
> > > +	 * otherwise set the mirror SPTE to the new desired value.
> > > +	 */
> > > +	if (is_mirror_sptep(iter->sptep)) {
> > > +		if (ret)
> > > +			__kvm_tdp_mmu_write_spte(iter->sptep, iter-
> > > >old_spte);
> > > +		else
> > > +			__kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
> > > +	} else {
> > > +		/*
> > > +		 * Bug the VM if handling the change failed, as failure is
> > > only
> > > +		 * allowed if KVM couldn't update the external SPTE.
> > > +		 */
> > > +		KVM_BUG_ON(ret, kvm);
> > > +	}
> > > +	return ret;
> > >   }
> > >   
> > >   /*
> > > @@ -738,6 +759,8 @@ static inline int __must_check
> > > tdp_mmu_set_spte_atomic(struct kvm *kvm,
> > >   static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
> > >   			    u64 old_spte, u64 new_spte, gfn_t gfn, int
> > > level)
> > >   {
> > > +	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(sptep));
> > > +
> > >   	lockdep_assert_held_write(&kvm->mmu_lock);
> > >   
> > >   	/*
> > > @@ -751,7 +774,7 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id,
> > > tdp_ptep_t sptep,
> > >   
> > >   	old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte,
> > > level);
> > >   
> > > -	handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level,
> > > false);
> > > +	handle_changed_spte(kvm, sp, gfn, old_spte, new_spte, level,
> > > false);
> > >   
> > >   	/*
> > >   	 * Users that do non-atomic setting of PTEs don't operate on mirror
> > > @@ -1373,6 +1396,9 @@ static void kvm_tdp_mmu_age_spte(struct kvm *kvm,
> > > struct tdp_iter *iter)
> > >   {
> > >   	u64 new_spte;
> > >   
> > > +	if (WARN_ON_ONCE(is_mirror_sptep(iter->sptep)))
> > > +		return;
> > > +
> > Add a comment for why mirror page table is not expected here?
> 
> Ehh, maybe. Thinking about what to put... The warning is kind of cheating a
> little bit on the idea of the patch: to forward all changes through limited ops
> in a central place, such that we don't have TDX specifics encoded in core MMU.
> Trying to forward this through properly would result in more burden to the TDP
> MMU, so that's not the right answer either.
> 
> "Mirror TDP doesn't support PTE aging" is a pretty obvious comment. I'm fine
> just leaving it without comment, but I can add something like that. Or do you
> have another suggestion?
What about "External TDP doesn't support clearing PTE A/D bit"?
I'm ok with leaving without comment if you think it's too obvious.

> > And do we need a similar WARN_ON_ONCE() in kvm_tdp_mmu_clear_dirty_pt_masked()
> > or clear_dirty_pt_masked()?
> 
> Nothing changes for those in this patch though? For the kvm_tdp_mmu_age_spte()
> case, warning coverage is removed in this patch.

In kvm_tdp_mmu_age_spte() and clear_dirty_pt_masked() SPTEs are updated via
__tdp_mmu_set_spte_atomic() or tdp_mmu_clear_spte_bits(), which don't propagate
changes to the external page table.
So, I think it's better to warn if a mirror root is accidentally passed in to
those functions.


 
