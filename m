Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54902282F0C;
	Thu,  2 Apr 2026 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775094452; cv=fail; b=k9Fku3GlKrqoqSc44ypo+9HcSKfCU+OaGheLShwe+X/9sQ0hiOoFehxlxeTbQsnv7CfjeOHNtR0sOBbKhtXo1LgbCzVZ7VSPyYNX34AvbW5HGhVaLWvfBBEhuEF9pi7AlLYXO7NbLJB/YQ/obnuNRCRxapgcZU+Arm2STvjtMV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775094452; c=relaxed/simple;
	bh=HMFiIJeh5kHx9FyRRCt+Uj4fGzlkHlH1FKJAYp1CyI4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j7XDkWUP/9FbGjo9VgKg/TpvaEgMEBRDk6QocgWh2HT7CJCbrbah6745txnQccWDepxcyvh1DmeCSPUKVUjJ6BeCvd5EjHX05SAlSnfGWaHRKwyLMNMxuY1j/GKWIkzCR7w4+5nKgS21RmBjcO3TG/DJQW0F+kewZDO/ilCjSX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpdN7U0t; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpdN7U0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775094450; x=1806630450;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HMFiIJeh5kHx9FyRRCt+Uj4fGzlkHlH1FKJAYp1CyI4=;
  b=KpdN7U0tTvHJMvWYgpLnmHqy3/9S6toiyqVxrWYEv6RL24weKQ8Eotls
   v1U0fbkgn0aXyJ9iPCsUEPA4/edHGCDOsTPT2FNNrTogXOKVSsMUvNlee
   nmP3K4cePrz5JnwqRoyrl0egKaP2Ghp9T81cAVGoD+yafe2vPDymiJGah
   X0dp564QuHqSZUdygD1W/dmJD7rI0A15smSM7VQGx6hE/HUbRV4Zl8Esy
   P4T1lO37M7/TTjWzdmDxKwEJ6k+6HZTBx23hn9iioP35ANV62+01ahdpY
   Y7Q0SjrpurGfBzh6QQ57mI2xJSK0i4hfo3Q1gx353nKGur4ajr7sn1Nte
   Q==;
X-CSE-ConnectionGUID: OFKHxFv6RJqRvvlcSw+Ufg==
X-CSE-MsgGUID: 40d7FaQnRI2yFQd4Uom4QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="86846775"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="86846775"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 18:46:10 -0700
X-CSE-ConnectionGUID: I41NF1IDQLSGyZ9DIP0RMg==
X-CSE-MsgGUID: DNYmVzEPQTajw7enP5Juow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="225829173"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 18:46:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 18:46:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 18:46:09 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 18:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJnsekzaOCiM9PLfQSpYqY/yny70dUDozKzQMXJ8CLp6SElxLkKw6Ut49cFJq3bzkk5w1NOqryzAKtQE2PuIGK9eRAmNRRjpUAkpSfWvPDteuf03rNJV2u/s/c9rauTbf2yRnEToFx9+u471wZ7Rv/ZHVVwq15uxOn3el5Fpw+Ubx4rZvaOiu2f+MAot42ebjU8lZD15g5FwrXcSo3MAIpfnEqzqRgW7GBA5RS6+E6i4M5QWDsBBJSDWuEai5zf3IvCZKCqiTkDwcHQ01NrDT9OP2AhCaksBDnOd1iwMt9Gqxj2NnjQzU9kpfvuWnigXGkNSCGdAFgP3Ia3e0WILoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74Y5F1zchhzAuN6dhqBQN2eIeDDiLT8qO5YIwfoRTjQ=;
 b=lOhzHu+/H66J/N6HkgzgcNXfn5Aovo4u1/rkPaaOj15g9nKoVbN6+4bR03r+TosrVnmnGatfrTSkMiIfQDSl7/w/3MU7nYsh0DWct+mBX1oGI08Fh3/+tYGjwOrB6CLctZjXU4hz+uGuHnCP3ZHibEAkGeNVraXBlVbtg4Uxa/JjFCMITAtCPJYy1pBJMFWMhi3BR1AKWbJZzoY5v+q/i63z8IFOxj9basYTNkZs9Hub6CYx6cWEpZZu40EEZ6/12Nl981eF6xzNl4zxG7utncaPQ8xJ36mQW1bksZIT+QhmMkszPrmz3h2QrLb9pKTT5XTjUcEvQMPg9z+Vfa8Uyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 2 Apr
 2026 01:46:04 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 01:46:04 +0000
Date: Thu, 2 Apr 2026 09:06:31 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 06/17] KVM: x86/tdp_mmu: Morph the !is_frozen_spte()
 check into a KVM_MMU_WARN_ON()
Message-ID: <ac3BFyNs78NFBd00@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-7-rick.p.edgecombe@intel.com>
 <acoDhjbA0xIycCJH@yzhao56-desk.sh.intel.com>
 <3a046909b0e295d810ab9a7bf6a35980a9c708ab.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a046909b0e295d810ab9a7bf6a35980a9c708ab.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::15) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|IA3PR11MB9301:EE_
X-MS-Office365-Filtering-Correlation-Id: 2400f2e5-69e6-41d0-d9e1-08de9059999a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: U0cb/Uvmv+4ivOIfZa1u3pDrA/ABhOqry6ls6v0OHTpzhz9zMNh7Q/RGb/j83RDoMypLBrrfUjxv9t814rLFrg6timz7FFQr72/S/i5g040n+n2YYCxSYNlHFpQzGDBr06ftHNUGZBCXFDXxV44T68HBk2lKLqtCCyvY5105V0t/VsHSHciHN+FMmd+fCl/nEVMREOaLsotsMs3Cz2TM6r4NQ0vNXbwv+jJwY0shFmlcMaq/Zd3+3wp0jT+xrVHc4B+zdoxx0r3FFPXXN0uQLTGXNmi4mMXWyIiXeEGr3afq+RY9K2Mc00XwDupNOaLH981G3BKWVTGeWIPhKA2RtnOP2MWaWXsJZnCNpn392HcVZDULGQlXa+0j4RvPunzzH+FgRdcAwh+1IOnFhqeBANoTt+kyGLfMkHH6MzdL80bg/zRUZvxY6irFeZKn1g18LeoWhqv3/wCTZdq7qDih+SLEejoiVcF7ykSioRSnEc3HVUdyWfnD/ehtEAPczUKqL3RZ93EAbw5909Uy7ChwUcNehswIImuVVSfv5n1dCphPvk9sPEddPPBrnX5+pH+cO+hdqbRsoHM0KCMCvBPA2e78mx0M+dLKErXPbxYwIHwrW2RgWpKSnZWF4C/m0QGdE0RkEEok5BTC4bWMLX/DpTqHK3XqerRELTSSxMHfaJc/ijDxtkcGKJdAFtLdrXNv7lPjdTkbK0qJICdW652vtQ5PSbbPYQNZ72RQSMOmdMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?htKThUoWC1QHPEeodE/pXLedpKz874sp9WPPlJsbBcWj0NYdoW+FiHOPR/?=
 =?iso-8859-1?Q?9Kuo7bjKQoqRqNly1b6yiDvP2Rv5ohp/tq2fp859yn2jl44AHCdn1LmdLI?=
 =?iso-8859-1?Q?k4njPN/qDn8coigN7/rSrJHk4ueomoQoE3U2cwSdkiebenNEkIHwKcmy1i?=
 =?iso-8859-1?Q?0Hzm+kGSRBnthgBvgq41kg5d4dWahnWK8znpYuN39lFs4Kia9ecyjhm635?=
 =?iso-8859-1?Q?SUBQmIKvwczvpdhKfcs2Uyg8xcjsBcQtI54crim+Mr381ijBn6gjR+kXOb?=
 =?iso-8859-1?Q?zOOsqCg/uu4o7/Hh7KRCq9nBkIkm2m5VKfQFMEcJXT3diVxe59/+kgarcp?=
 =?iso-8859-1?Q?SCUOrcKO8nQtUBe1M3w8mNA/2XFum88ObteSlj01FgMXbw573GcoVwTpxu?=
 =?iso-8859-1?Q?KzPLzovV9bi+ajbZf1InHy7wgL4oEVKpZfavm72G3RFdRyN5VxWcSndESQ?=
 =?iso-8859-1?Q?YhNZVf/uojUAJEw2lH3CCv26FekHBp8wqqMxQT66SGvwse0AkpDjnxHcT/?=
 =?iso-8859-1?Q?pG13JQeM0x+VGbBE5xQCXvMzlcw2TvqoQWa/C2885ozwo4TnVTvAkbNmzi?=
 =?iso-8859-1?Q?LcoQz3VN8+P3aWmJt4DfJMWlPxnwRTPixpiJKqVdsEwdznCY8KvM14jgkD?=
 =?iso-8859-1?Q?oG7zV6CydvdhEZG4/p1zKRP3Mf2gSQq+KLOrAndk/yCq1nVW5XGLYFD/O6?=
 =?iso-8859-1?Q?j4J5BUVGO0MSl4ZDvrUFj1/+p+e5lH0pEBRVsyEfSOClnNdCBxEq5FaRc/?=
 =?iso-8859-1?Q?dVw/+1ulwYH+sR479JNjhzRp7xI6NNcQusy+cXYtdYwIyPpc0OM3Dn6ZuF?=
 =?iso-8859-1?Q?n5/TuEAZ3IGsIsCrjSt3ILpE0P1hF/vApu07LsNmvfVWJ1P7UXgWVCOCps?=
 =?iso-8859-1?Q?AycqLTeggxPleMJN0LirENva134WAHK3t0WOBSTeT3VSnqeq5OyCvQFRYC?=
 =?iso-8859-1?Q?zzNT9w9Hr877qwWXQ7RiBei/y6ROm+ieL1FuKwovZq6uIwZ3soFCkq7h13?=
 =?iso-8859-1?Q?RHDZZNsf1k8XUsj1DW+TFcaSezsQxHS9MQcaCCUmR0euOWb119W560MiZU?=
 =?iso-8859-1?Q?NgllCsfJwcDFGo4QdHnc98Sp6eHY8aHGlh9m9C+3spvALfshZjA+UNIzGi?=
 =?iso-8859-1?Q?jZPsLQGp0xwotsFBaOPcLNYWjgLzTr4TLzWc9yKOoJCd3ihH59rU+adxvD?=
 =?iso-8859-1?Q?omEhV/nOyM9Ipm8ka8UyawwLYiIxcDQPjmYoEwMwiq80SUkJJyHZGNFMK3?=
 =?iso-8859-1?Q?kBOc5wFcb0iJoeiEUH/DhAIfgImfhwFyjnLlDgNXpCA42ij6LCpxN8+L9j?=
 =?iso-8859-1?Q?V9mLadf0FH2uOQnl+RjRQyWjAEJUl5UAQgN38gvyImXMm1N/wwa51phEvv?=
 =?iso-8859-1?Q?5Hfw2XO556ap0tTY1XHd8UR0e8/uP5X0L7LwbE9tCJc7oGPEvsQpHKTzJ5?=
 =?iso-8859-1?Q?iKSyYEGd9DX9HpgR6IjAL0s+KHHN9wnOcFmPLxeA5EC2s4D5vqYQKpUXZl?=
 =?iso-8859-1?Q?m28YLBHyttS++gJDsEFWp9rq26i3sROM7NQX5LdAvo7nKAtEFNXRAW3naX?=
 =?iso-8859-1?Q?d80KLH2O08oppJSK1AA+1j5+cwfKtbRiWkgCJH/pljMYk5fUX9UFInLWX5?=
 =?iso-8859-1?Q?MRk2RyWmA/MBZBmeDzCM320qgu1AquIbjAsaZAgaFf5hy4kh1ZQG8Scz6o?=
 =?iso-8859-1?Q?7brJ8skh6mtiu8BexRZgOW730mab055g77JL669nXqWeHqDZPHyKDlEsuP?=
 =?iso-8859-1?Q?f+QWwswTLhnQhJ1c/9hktQ/WWirGO2vfCDKs0deBz11dmUhL87+DdACpCk?=
 =?iso-8859-1?Q?/6zoiytrkA=3D=3D?=
X-Exchange-RoutingPolicyChecked: M5rAyJgzAl2uRQ+hzVsP6gygXn/y9RcWOv7si105RJCSdKeNJrhDBzRiskD29wd3x/aE3bQj+7yFZJ/ycbOHmmfGH8Ou+VkQ4o7lv7/yvehB+6odlRTGsCgBg8mOzeNP9MA/VUub3PwDB6lTp4N2Vq0/oeY9pQDsE8ZMs5+3DzNcgOVR1FjYu2J4EaQAx351mFqhy6+Q74sf011DpSwO0EKRxa65UnCiry8fqs1kVYSsStF9tFylj9pXKU9fx53IQ0gX2Bu7o+5ItQc+notJLl+OQRfdqzB+1yOtB+Eb+3gzPT6eXad3wAQgS9v1ZABdCtqqtpQPvjwz1h3mN/PJWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2400f2e5-69e6-41d0-d9e1-08de9059999a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 01:46:04.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkhFhgFPNruq1o5qnto5pUY2vswgx3YKKsJstaFTterqZGVCZD0aoSvPTs2OJSgps1ID7/C27SlH9P6LEKqluA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9301
X-OriginatorOrg: intel.com

On Wed, Apr 01, 2026 at 12:37:51AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-03-30 at 13:00 +0800, Yan Zhao wrote:
> 
> Yep on the typos. 
> 
> > > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > > @@ -656,7 +656,13 @@ static inline int __must_check
> > > __tdp_mmu_set_spte_atomic(struct kvm *kvm,
> > >   	 */
> > >   	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter-
> > > >old_spte));
> > >   
> > > -	if (is_mirror_sptep(iter->sptep) &&
> > > !is_frozen_spte(new_spte)) {
> > > +	/*
> > > +	 * FROZEN_SPTE is a temporary state and should never be
> > > set via higher
> > > +	 * level helpers.
> > > +	 */
> > > +	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
> > Why is KVM_MMU_WARN_ON() used here for new_spte while WARN_ON_ONCE()
> > is used
> > above for old_spte?
> 
> For the KVM_MMU_WARN_ON() it was Sean's suggestion.
> 
> https://lore.kernel.org/lkml/aYYn0nf2cayYu8e7@google.com/
> 
> It allows for compiling it out, so probably a better choice. So I see
> the options are leave them different or opportunistically convert the
> other one to KVM_MMU_WARN_ON(). Thoughts?
I see there are mixed WARN_ON_ONCE() and KVM_MMU_WARN_ON() calls in mmu.c and
tdp_mmu.c. I'm not sure if there's a rule for which one to use.
Is it necessary to evaluate them all and have a separate patch to convert
WARN_ON_ONCE() to KVM_MMU_WARN_ON()?
