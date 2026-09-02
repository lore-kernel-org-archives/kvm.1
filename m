Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870345562E;
	Wed,  2 Sep 2026 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390924; cv=fail; b=BNosolXh04zGVdfhqWolBmc1qIZR8BkHk0h4qve8SlVEFOT9ffxEaKD7eAvV5pP3o6Nu2nvrBUzz9CaF+uSqpzgYojsBXB9z9Fpy2M3YTy+GLspNGBCQMui2M/LQ/Tz//m/6OGz5EsmUI43wJIpZMjMWK0BYi6+ss2y82XGn1lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390924; c=relaxed/simple;
	bh=pu3wMrckUfaDcK+N1zXWJNu4eqvX+v7oX9bFmv2I6b8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EFlvtKwfgimbogg/DzAyW8fuDa6UEav5yOpZGTM+IDLtjv6k9O0Bb0xCrmXhIVtJ5jL/DtnY8SYTdZD6+Oar95LE/GjvhS855kDdZrjl85mDxXE6pHR0xEeImAMtiKAoDYo41YMWexd4uAPvmvSy9ehPbGQIhYQiqH5W2bGWYfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c27HBQuB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c27HBQuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788390923; x=1819926923;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pu3wMrckUfaDcK+N1zXWJNu4eqvX+v7oX9bFmv2I6b8=;
  b=c27HBQuB55kqErLvwJweKGhwvuXdoYc96RLkrypuEl5p+U+KPV6XJjNZ
   FkHXFTh7FM9p+EFpLqKg0eOWpolOAi6WcV2sgpAs9SCzC9vUCIcbtK4Hz
   Npu5IZXdPRLXGAmOa6Qdcqo5jDXbly0EDJQX3GWD+9eH/Nfn3JbWyJnAa
   eSoFkW475txONLNd3DajmS+5OF+Q3Wxm1VCP971tcWrGP62lVedNkUBQa
   9fm669JeLGyBQXasLGdVrA+F2Oj6HP2NHd1e4cvKFfQI1ssT7cqZ7bZps
   ODl/qVh+RQ8jSh+D14W1n/c89CPsR3Oh6AEOu2/fTIc9plD1fdyuloqea
   g==;
X-CSE-ConnectionGUID: kLzxGQxiREiTrOHGdjcKxg==
X-CSE-MsgGUID: cqLMk3A/T3GCc5Nk/2/afA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100216340"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100216340"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 16:15:19 -0700
X-CSE-ConnectionGUID: vyEslrMqQ02POla5gXPkiw==
X-CSE-MsgGUID: HtTNWlQiRb6Vt8kcNio5Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="267796770"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 16:15:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 16:15:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 16:15:14 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 16:15:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfFhPKWRClt/OM5lgOBHkcH0c5+I94k7V+W5s5mUX5SG61NCRRp2uYOmVD/T89f7KBL42e6dLIzXDtzfHmi5XwvjvbhoXAc/ee0uAVcU3LeXvjUXHhnevFFF4+zDAlecvVE4gi0KES+ShsoOUrWNDyOxauf/R79rfw0GWVag0jJCArA+tDRJIHuB0YAt9FUzIVJefRt9SFNEol9iNkCJDO4CZ1Y29VtDO6oEvGpR6xLlMCPD5/TP3jHT+r/o0hUvnSm7KASLFa6gxjQaq5yUWUerNDwwZsz5C0WBGR/N4f24HKR2HDn/ORFM9Lhm4vPuL83ZLqBY9MVl3LtiFoFRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxQvUMB2MSH8Bm1cvP/IuInArYq/dD8opqblyDsnxzo=;
 b=QFSUGXYXQfJmv4Y+uN9XlbPeNvp9MLntPLndOiuGyPj0qbd1Zra2ZPSlvmm4f6n09HirSiUKlqyn4EEvswc50pYsVywkITN9v/BwbRG+/etdhIMcNDlxOYwrxypVlfuDGTJIjM6ZQVINVzh2Kh6oPzaEFuUfTJtWGTHgp62np0hy+Aghw/+mqaQJMJ0VfeP6S7vF1QIiFYI0Tv2KLJ7H/0GPKYhJ2b+6i79Loe7nryxhpw/ODRr5rdDqCAnIBRVfapQXAhJljtIZOtEjzm6qkVjEix8wROaKP3q26klJe/GYUEzgjzTUZc6VtcivVnbNdQCNot2aSzB5JDmyZeE6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 23:15:10 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 23:15:10 +0000
Date: Wed, 2 Sep 2026 16:15:05 -0700
From: Peter Fang <peter.fang@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <apit+fXmapCA2qlc@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
 <af483218-5c87-4ce1-b4a3-06132dcc3c49@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af483218-5c87-4ce1-b4a3-06132dcc3c49@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0183.namprd05.prod.outlook.com
 (2603:10b6:a03:330::8) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|MW3PR11MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e439422-5c94-4ff3-5ab0-08df09480920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|7416014|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: vShKR+zuZiMj+//1b+8NneJ0+n8j+e7km9Q6BBahLmRCX2lIfjm6OzPGAJvfN1go2mpdMxYgDynE+vZ3mLBy4IsvQ/yxHsK5PIbe36YJB2LggVmkKMW+yeo2K7LuNGgH6vsv7LjYXhlz1sEEXD13jVcyTdALMPLw20NsYLI4R+9hXia2GwMyQ6w53NSiWd67hkgjJK1zF1vx7DhnUEUmNxShFwXf3Sz9vjPZ//DTEOd+/oA7A8rWZRauYPcgtob7oaYgIByTqJYt4OWzItYe4e4T2JQpS5TAVWBRqxImKCZflQOQJDue9HeUZYSGWbhLhTYU++rFzYCGEm1tWHa8I1B58kWPaVBKqVSscJPNezQ+yvBcHicunbMgmvF/HU2MF1S+9vKJdd6CcGedsX3RIKlXIbprxPHSm4RVGcwHqQT4lkyVQM/6c6L1tWRYFCp/g8oSP69eRZAmtQxfM8J2vKXWkJxjPu7jQJO6zLqR1rhzWjs2l9XSJlc6OaZjiu6MwBaAwIJorQvxbQdz4XI5weoOmpTBDjjnQai5UmK71AhkHCFX+2aNeIRanKlLu7dXhr3c4mxO0MOnoQZyoviPLA9lo0NawhWq1zw3ENITCMQ1aEnwFIERbbQPwo0ECrGyLZ2LajkTils2UHPsaMAFSaaHnY2ShFscM4sIVBYaCfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(7416014)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0fU+WgkpeFv5kqNowrFQxaXQjcsC36oNE2bu9BcRDbSjNqeDlZmuPVR/ZpyS?=
 =?us-ascii?Q?IxkRJgKDOhJKGHo7MOv/wOlBf9RUkJh35GiQERd8fg7VdcH0mhbqhhixeQ9a?=
 =?us-ascii?Q?iBNnPkNlA0IDbmDJlQ+EKmB/BkSqunxEA9jBReOSQrcJISEaCZ0v4shwGWAu?=
 =?us-ascii?Q?D4iDnL1RucF2Y/IWv/TQFpPpmlxqowrtHwWkDxLySfiihHCg7Ct+y+otwaIN?=
 =?us-ascii?Q?pr1OXKf7JhZFoBY4uTeehSSAznl99zKM25VEpMi7B3K3KB+hsPljcf8dJGjI?=
 =?us-ascii?Q?/psBgE1OYmYkR35XLNDzD9hQWruOZ/OUz/Q2aJZb3UR+BSINIODZe0ZZs7PA?=
 =?us-ascii?Q?JauiD34vqOGipg7y21LWbmfa660Ya9zCxBRQ5qAvWoKs+9tOT4Dt5bvqR9nj?=
 =?us-ascii?Q?dBjZzMHYQ5i5cg3pH3MEg8sk0CShfQ6RrgmgwTDyyHhHs/aWxPAkR+FtztxH?=
 =?us-ascii?Q?D1N1DHkOmkwbV6dYr9K8IIa8sn/f3ZfZiATXtFS5ssB0mQGvloQPSBlUUufH?=
 =?us-ascii?Q?mJdS1O0GGBwt1wxCvlHdy9ofC/d5azreyima8MbwEXU65MFY8z3b7bEwYiSK?=
 =?us-ascii?Q?+Qn4c9Qd8FrZAEgE7Jg8mnQSSIZOi1oIBBsYal2ejVXzuaiPGdgwz/3odpqm?=
 =?us-ascii?Q?9pEJduMPzk4IYwSDw4sqcko3EsZxoQ05r5HhTu1KShqpYTlw0lkOHYkedvmB?=
 =?us-ascii?Q?5XoSUcRO5jF2j9HEB080Kx6uY0bL9mYbl3CY2y79sA/FplxGpLHTx28fha49?=
 =?us-ascii?Q?cvFUjpzPBHJXWAtb9sr4vfpgOgxLOhOPY7ih0HOLaMikwB+z8oQDUb74dYba?=
 =?us-ascii?Q?9BZoK+BB/fw2ylJbvXlpyPQxxXn42I9VvN3XoyexLGin4/+VpVvebEkVnrGp?=
 =?us-ascii?Q?3zRWhQe4TSZdJjZe1g2oFA0jfrMWZ/ooUO6Qa41Z769j6lPpKbchnPNfhv8/?=
 =?us-ascii?Q?HcmlQpbBMCfIt6SqaNIJ0CjtQ1mbcZzIkkj2163AiEuh4+RxgKgvILaHFIuW?=
 =?us-ascii?Q?LlATckMBZVYmo5GqCAQXbrGC0q8SR15oPfXvOZMPMM+FkGLH9fmGm6kmrMCY?=
 =?us-ascii?Q?sBec1ps0LXwXzt8oDrQ7aqjp7PDQ4u7+NKaL+S4kjvVPT7OgZsQlfDe9GrJ9?=
 =?us-ascii?Q?k3GalaQtpbMGStPagDnHMZtihRIvhUI7qoykcN0i4MtvFQgEeqowlNKMi8VU?=
 =?us-ascii?Q?hP6/PtHEX+PXInfJaJmCojbVoXC9einjAz9iAA1loW2Z/gbINGqZSop4CgKq?=
 =?us-ascii?Q?QZzNa2oPRw/6xaCKrZY8nyAnHTQwSBsY7zwrmQuzGT4n/IJ9GwcwYjkfEZwW?=
 =?us-ascii?Q?jmRfl47C/+FB8mh7KamvRrJFs3D3xF/BNCQeVj/2HMsLtf7Ea21V0e7qy1zW?=
 =?us-ascii?Q?qmAQZ1CzZ5fq8rA7DOzgImpI6yFaatIAdzbHyG/NkLWbbiQlDTRgqfheDBLn?=
 =?us-ascii?Q?WA2z3sm5gMyKezHcv6FUFUvpU7OU55S0ExKVchYbx4bK0IxHGvAajXFB3vzK?=
 =?us-ascii?Q?Ltg9hl3/OKyscC1vV4OCmRUvnLzOXGoMQzattFVa3xG3NuyjdVHqaZbl8NAC?=
 =?us-ascii?Q?f/EV1icfdWnNR8cBfddw3JKQrqHtpqoNl8tgYb20/tT4HuVuzbeh3l5OAIjo?=
 =?us-ascii?Q?SyXQeNc/HtQ3u+TnlCaI4C6n8jQ3CNlP/tqUNnx3Iqx89w047qvsG1fAUpSP?=
 =?us-ascii?Q?uKPUfXsEGLo1644R6ICo/XTzoMURmj4EDDUsH5fqTsckmB3DPBO6iqUT36NM?=
 =?us-ascii?Q?okJ+9TVPXQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: xkVgHMfgeuW3P0C3yJb7opOCG5uFPbKND0F+A23/seHZGHois1UUCWJ+XFGJctK1i23mN4RKyWv0g1lkg68jSjHh3AJ7IIDvfaHW7BxpR+hp0Ig15akK+b371KBZGkLb3ZnbbhVoG27jwIvb4Jz4ANqicbwTIj0SLnX9cgEcpIpCkEtytIDPBRYoH1lq8Db3P2d0+RmiT+JTQ5HVCrnhKipGp2xY+e48jrJ+krXqqJTqvLbVW3a+4+6xYFpaZwSg7QUiSSrtIKXRVUh0Tgf8D1fWblF5opANtK39nNRP8oRLgPqL2kxRBXQJC+cNFkmAKWJ54/T0x1uY+EDQv5aNdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e439422-5c94-4ff3-5ab0-08df09480920
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 23:15:10.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7bo06FhpdmovNvFBG43aeb0rHtVgXj0FSiy++dgzm8yfXlsTPdSM9TDdw4sJrojVm6JfCVksBWMEJqWw8s+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
X-OriginatorOrg: intel.com

On Wed, Jul 29, 2026 at 11:47:51AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 7/29/2026 5:29 AM, Peter Fang wrote:
> > In preparation for dynamic Quote buffer sizes, replace the fixed size
> 
> sizes -> size?

Ack.

> 
> > constant with a variable.
> > 
> > The size is currently a constant sprinkled across several places. Store
> > it in a variable and have all the users read it from there.
> 
> You are also dropping PAGE_ALIGN() in alloc and free calls. You can
> mention it in commit log.

Good catch. I will add this next time.

> 
> > 
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > ---
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks Sathya!

> 
> 
