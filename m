Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3B334C39;
	Tue, 11 Aug 2026 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432905; cv=fail; b=Ie5ooiv7SG5NUKPVDAipaOMro/eqjwG68Up7CAyGH0u/D+/vIywI1ZNuzGo0KX2/H4mID8bZbFvmJZ28KZsQOuEEPHIepCoDO01CaUnw02zRpm21+z2GpDHQI1BbMIxPatWmaUdcSCveXD962j+6YWQJZnns5rPAP7K0/tZ4IH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432905; c=relaxed/simple;
	bh=JqvUJbpKtZQ+RHgD+3eg2t/e+TfXU1rWTmqdnV1LHIE=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hEtWlFsiRDLllrNbWTDCRvOujZbsZWeyvAKarRGdUn036rTBijN/CPKkQ98TkNisjPkm+h6bVh8FqrYg3IGAJG+WPWce0uX5GS87I374ZNgbsZFFYD2Tp9oMy47dEovxLicf93qJHrBd2X+X8vLvRuWPqPX5V98NqrhnjLRZTjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUu4QjfS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUu4QjfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786432904; x=1817968904;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=JqvUJbpKtZQ+RHgD+3eg2t/e+TfXU1rWTmqdnV1LHIE=;
  b=CUu4QjfSIzFcdwRdzjfF8z3Ran1trCQm2v4Te96YCoZbzz5DDakTDODA
   lGVT3407tjTo7BLsdPZzwvO9Sx1h18hFcYIsjIserRCIN/Hvt+Q8kqTsj
   pfmJiiGMqRlzTHeh+aXOQ8L8rm0ZJoOKpeHCbTCJeH/nDvelqPFogp9eu
   8eK8hiF436aAwEl2uVakPVZByHbysnhAZliBeGWBG5ma8lUTdYKJVVsy6
   W7wN8VaxTg175xjKlN5U+vdjtSMmCf2HVyvg6fIl+6trBJCgt2AYoEbWD
   0V8/nOXJRc7+YHfvD8r2UGERZZgqM2fiVJRRs8IZCcuExEmRxFD10UviP
   w==;
X-CSE-ConnectionGUID: IsXbgtGwTF6H+CtwsQzJjg==
X-CSE-MsgGUID: 5QzVsCHoToOjk2EDp+67Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="112502298"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="112502298"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:21:43 -0700
X-CSE-ConnectionGUID: dRqDHg8DRJmuUWM6tH2DIA==
X-CSE-MsgGUID: 8F7LVpu0QnOS0wb34gEwcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="261503881"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:21:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 00:21:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 00:21:43 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 00:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOHBXzCIXOKu6P2vajZ+umw11UcMXxFUBzl6sVhkJVnuzuM0ApecNJlyk20ibi6USiw1jVuaR/XLJH9zhLOcBUjmBhuxNv0Lcqsksxe0zgo3stnmInaQBmA/Sz6csTEiPuDkfuXhOxtk3WzqgT6RCGB+6t3AT5xY009fSFY1cAmH6YzuE/dqsB8dL/f5jzCTa2LC3YmFZsHm2NR+BjA6S5wWr28zLxxMkNQVQcDksQpajNJ4kDIa3siWjRPKmRTzRxqumEM/+6eD8zhhT5Bdo/WJ2QVem30uwf1xgSHwkXxkRCCvIK1gZD2IfB8wIxFBUB3nvwELVni5OLTnmpzL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0qu29MUjym6t7f6ws+VtigMfjiiMipFXPKPbcK2KAo=;
 b=AjFwBtmhENXA5GvxgPMm7GNuPOVLBmqJmyAU6P/MoewIL2xk/PNE8XsR2tBBKf2I8hjEufBUie42hO/eIGahYlSeIik6GgK9I6azu0D0AFPRjhD0JTEIcB6XJXoBM+w29iYiKY49Od5TjeDnTGQRniAff9GoX+fBnqJb9KSEuteTWBLlQLLU3OBmaHxjRGgIO0SypSvY5zKDjT9aMPltBuAI9kWPc2sH8i5+qA/UGqfaR2uOsXRE2dr7gg08OMusBE9eRClWQBzfIrt54kS/b0dHDSbcpV1cEVo6BZ0AWAOzD6A3sksnOrgiW5ro8CHHWVZOqvfKScXlk+zNiWWCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 07:21:40 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 07:21:40 +0000
Date: Tue, 11 Aug 2026 14:40:50 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH 4/4] KVM: x86/mmu: Add sanity check to detect stale page
 faults in "map private PFN"
Message-ID: <anrD8nI8RfYoNvbf@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
 <20260806214050.78058-5-seanjc@google.com>
 <anpr/H5Hxw1EMkTj@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <anpr/H5Hxw1EMkTj@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|MN6PR11MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 810fb378-6044-4e5c-e8ed-08def7792fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SFP6KVgBVW5o39O1a8lyQNX0uAeGcQqEpdXmrdOGfCAxnV1WJMxrYZvG9ccgRU1QHU4reMY9kiQFzO2RclmR2C728ItdBSvNhsz1CBgSDnJhuar/V/yDNrgPRbBXx/m87MqP/vefs/DSN7EktQRDJcy1zgR1rgWDiBdctGDaY9VaGlw4MfC9bAJhYqk7ryEirrdx6IH3oCgwfNFTJA/udiz8joL5CgGJiqewuDXLslSt9lg9XUeXGkZPEcoyyMmckUMcdSIzaAbXgt0TRFjevUYyfutZ/Pz9tnypnC+9f7blRGXOVSwLalqj13HRL4fio0S/7ezDbNOM3G4Bsg4yl5H6IqamM2gKvelpjmWomT4sWXlBpTxcbWJrD1NhYPVgeuCy2euU2VztrAXoeMs+YY/dYok3L9MVaPm8IyRannq1FvGtsRPWjbYims4awhJNJWUtMVuuV3mSJ+k+kwnNq7oXk6dOv3rkOwnr77+LtgVUmajCUBt+yAFPeak2EKEknE+KrcwL7N3EgQloGLXQ5VNEfZk8M6NcGGRcgqwgWSjt5NnApBoG8k4hh7GhBMW02QW5dhEfo3NSCEL25eogeGFX5E6r+RedAuCVN2Hglh2wT+nmE71zZZhSw51NvRrEQHLXQDVD6YEQm9ru8/Mk+beLT+S6WMPSLGcPEPkx/EA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gv4635ivI5qKLvkqnMGtiF1/35ilCPnlack5fB3qv1lk3jkI6/AMz6bQ6d2B?=
 =?us-ascii?Q?xCJxj8XbdxwSFoRU5/c6f7vNXRl7pTrC7ZrLbYFjJY/qKvT9boucfRKomnVM?=
 =?us-ascii?Q?+I8nt52CKnv1Y7PPKAHTyHoLGOShkFtd8aGe93fiXILU9vSW5eqaCywoagye?=
 =?us-ascii?Q?J3Pi9I+0ZI4GakjQJJNCy8cb9ncc1ylofkLeqrBXwGJ9iIz2DcLg1GaBQF0a?=
 =?us-ascii?Q?CU4RFi75YlkjU12H4YHWCoXMkCF9YtZfRgIECH7d26WhJMLF4pgeC6eIyxyt?=
 =?us-ascii?Q?ZrhsvsHPw6OMI8L4h3stiBHVWhiKoa5JmXRpl5aQLiBxhq5cZq6xnfqu4DnD?=
 =?us-ascii?Q?licUv98R0gO/VsEcmfc6w2vpGBhzpf2DgCymQ0ptyrpDz9eu1fX+4cMRPoBC?=
 =?us-ascii?Q?DyXfumpcrWytDBg1gWtLCRbk9yqb/U19EzM9/78/zfD8b6aSSj3em4/yMwLV?=
 =?us-ascii?Q?ZWpUnm1iKYD9S2k7NBw7aC6UF+oWMHEDvCPuO0sn/HHm6vG37qDdvQ52JR9H?=
 =?us-ascii?Q?st5/V9r3uPvBxprCzI7NdouFO8qFeZJr9ruV6lhYnGZVhiF0lXBn0UOyuqQH?=
 =?us-ascii?Q?n2Wd9bvcIPROtUN1vAvDU6x1XJHDgbIxQX4LK07UI/yR4XfeFkBNRNbrvz/r?=
 =?us-ascii?Q?ySu5/6JQpAfEijuugf1e14j3+bzMOJSgxkl2xVh4F0R30HS847AGpq44TjFe?=
 =?us-ascii?Q?BtvAzjNbsqnLFC9RR9mnxXZTNrBQqk9po6ggNVOMpKl5ndht1WEpO49I92JW?=
 =?us-ascii?Q?azTq6gCi4PG9JmKBbahWcmHzWzd55IhGnI32VZWGBKqWs73D3B7w3XC9bcAE?=
 =?us-ascii?Q?79+EaLPqpw+9QJE4yuhEWsKPuS2K4Q62LGnoWAIKfRHBE2Q8SLrpEYnXEm0p?=
 =?us-ascii?Q?tKxONPHG4jwElu9AcfpMEhEoYlIi+rP0gg4K6C7dtgWbECZN2f84sOSf5Q8Y?=
 =?us-ascii?Q?OJkTAtmRTRqjV+LktVWt2dLzsz/3vBglsiKfuV9JJ/+yMr0damqqIC57WBKk?=
 =?us-ascii?Q?zTOPhIvVlGaChSQ4V4UWa+YjqQuTbm6fArA9Dg7NB90KaO3e+iYGOVPD1Zvk?=
 =?us-ascii?Q?GIJilAlD7nECfuSEpNhSt7/Lk+xTjOaLKJvY8MN7EMTJatG0JGQtZLoMffOy?=
 =?us-ascii?Q?Jid8SsY/cTaOz2epJrqhLx0GTXG//bhref2YhggwcJMswJrrFlni5Spr8XJ+?=
 =?us-ascii?Q?/PnB+qK0NbFcC/DW1beuUX6obptmKkj/a41rw2hAnjKGvWPMXwxff/fNhuBH?=
 =?us-ascii?Q?sUQc8R5W4rEPwZ/Au/BuuDKjGrsr1yDW8oVBXnpBwSKuAiBe2fdwvHsvjdtY?=
 =?us-ascii?Q?1VKiSJWtsPkRbN9+60c2XevqE0l7ybX0nV0awnXz7VidVxBfMhgaHfqf1BlM?=
 =?us-ascii?Q?CV3/1ZLp/zly9bqloowvcD9Kwr/QSP+qw+48851qnzTgeKmQDJhkE1WGcJ/P?=
 =?us-ascii?Q?r1x/bC2yaJ7LnNIvpQuPt7TFrywcaxyUIaVL3cyZPmkFDe68TcfKdAe0JN2R?=
 =?us-ascii?Q?tkvq/WWizVcsyRropwdYhwB22tYA1yoH5S8jpo4FiggTOh5zDSwBZNjCL97C?=
 =?us-ascii?Q?PBaqMYHFpn2O2WhS5D3aNOxyXJPRKVCu/N/rNI06wjRmwWDZ6edg88ijOGA5?=
 =?us-ascii?Q?KOUXomV0fIOZMZaEsYrGyQomi0LsWKV68qty4fK4HR+I2aAe8QmlR7Tb3+rn?=
 =?us-ascii?Q?utS4lJJCGVcijaLU/QpTpvricbdqcIhJrk6jTNAvhGXWVDvepPRJZ/IH5Bez?=
 =?us-ascii?Q?Cq8h/cnYbg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Fyu7SgJFR2yF93tau6UT8qqhQcgZPkhxkcdvyZQYM2Jzgr/bBO0+Nrvnu2HEZ9nteMNvF3aOv7eC8aLYWLqGcjsxCmykTqwsBCnWArUPuTtiPLj7Ix2bHETArS1TCRWLmIB8hUimYjE5uoYktyJurVINSHwl174s9flaqYFwguc76xX2f3YozMsuidV3xaqZxcCsiUe18IfFpw996hr+4DdvnaZLuwOvieuh8M8Ikt7u2ucvZ9UhR8ayYC/SZuewVWJ0YeHqXvv+qWFOTkUnCBHRurq0WnGbypN3NtDY5EwE3QROQiDJaAsBCZCSS+0rHFLT5apeF/4WQsCh0zO7Cg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 810fb378-6044-4e5c-e8ed-08def7792fd0
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 07:21:39.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJZfAxaaWEp6wrXoODHBjf+wwoAmj0syJ3KJhaVgOimo34M2QhigFd9G+IzjbfisqxPrMQW7Yh1zWqDqHRgSMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
X-OriginatorOrg: intel.com

On Tue, Aug 11, 2026 at 08:25:32AM +0800, Yan Zhao wrote:
> On Thu, Aug 06, 2026 at 02:40:50PM -0700, Sean Christopherson wrote:
> > Harden the "map private PFN" flow against potentially-fatal bugs or future
> > KVM changes by checking for a stale "fault" prior to actually mapping the
> > PFN into the guest.  While it should be impossible for the "page fault" to
> > become stale, the sanity check is cheap, whereas a broken assumption would
> > have a high probability of leading to a guest-expoitable use-after-free.
> > 
> > Snapshot the invalidation sequence after acquiring mmu_lock to avoid false
> > positives, even though doing so completely voids anys and all protection
> > against unexpected invalidations.  Pretty much the entire point of
> > kvm_tdp_mmu_map_private_pfn() is that it allows mapping a PFN that was
> > gifted by the caller, i.e. the caller would have to mess up its one and
> > only responsibility.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 379f570ef04f..76e3cd717324 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -5210,6 +5210,16 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  		 */
> >  		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> >  
> > +		/*
> > +		 * Snapshot the invalidation sequence counter after acquiring
> > +		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> > +		 * i.e. any concurrent invalidations are guaranteed to be
> > +		 * irrelevant.
> > +		 */
> > +		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> Could you explain more about the conditions under which a fault is stale while
> guest_memfd guarantees the validity of the pfn?
> 
> Given that kvm_tdp_mmu_map_private_pfn() already asserts holding slots_lock and
> invalidate_lock, I can't think of one. If we add the sanity check because it's
> cheap, why don't we save fault.mmu_seq before getting the pfn to guard against
> stale pfn as well?
> 
> > +		if (is_page_fault_stale(vcpu, &fault))
is_page_fault_stale() gets sp from vcpu->arch.mmu->root.hpa:
"struct kvm_mmu_page *sp = root_to_sp(vcpu->arch.mmu->root.hpa);".

For TDX, sp should be from vcpu->arch.mmu->mirror_root_hpa?

> > +			continue;
> > +
> >  		r = kvm_tdp_mmu_map(vcpu, &fault);
> >  	} while (r == RET_PF_RETRY);
> >
