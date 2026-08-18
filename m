Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2825B0BB;
	Tue, 18 Aug 2026 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035103; cv=fail; b=MAWUqccFLAt+v4zoEEuWQT8u33/guVBE/Y0b8V0PE6RqpLouhA1M9/IYX73Dnh09E10LObFa5lGLnEcQqjWqYZzXjDADKRN3TkqiHJRVsilo82TAUOqCTkDeQMzFpN0PbTXlsGjXa+0IUPULgQUEolEvPtukPtigsIaVtUXCXTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035103; c=relaxed/simple;
	bh=X5uegwGOhP3cQGgxUickEI52FG9/mCyRuPKRhURglKc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HU9N9cWFLEaFmYiUv+MwDSTD+9N91Wdxi9Fh1MGq9pkRrSqwTu/zyq3Irb/WdUotASYWhQ3spfrWRcDYIHerkniviXHHU7Q1ivtbQRdoce6/XS3c6qgD7135FCjyGiz8pqZ16S9ubz17bxU4LtaJyRgHqYXZ6jONi4OlXprhnmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGoef7EB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGoef7EB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787035102; x=1818571102;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=X5uegwGOhP3cQGgxUickEI52FG9/mCyRuPKRhURglKc=;
  b=hGoef7EB3ToJKnrR8JJqLNcY8NMoP75RmL4rdX8DY+p0/tYr9Ouj4JTk
   ytF2LLlzqVl+2kpylT4kOEvw2TqeoHDabKDnFZH+EI4FTQHJS+uqsa5if
   f62MbHHXq+kdNK4FqvDH5p6v5Bos8Jfy8wF3cZqfEltEcc9wY0Jn717fo
   ubk191O7O+bSVg433/spyBsyJDuUkJQBs1QkaLJtm2KEN1gx+y0b9XQe4
   20wDaq/2Hkq+7bXQFbJMIX4hJ2piOTpFnSZ1xPBi2QnJR9WSrt1S2hg2R
   W2NHjZiR5sxqO+8hEm5MSC8+aSLUhJeR425qJdRjb+0ZcJPmK9Eg+i5bQ
   g==;
X-CSE-ConnectionGUID: Rt+ptavwTjWBHNQ5msE69g==
X-CSE-MsgGUID: rlXPuwCzQj2L+CIT47eKrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87280720"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87280720"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:37:13 -0700
X-CSE-ConnectionGUID: AoR3peWRQ3eWWcVRkeT2AQ==
X-CSE-MsgGUID: eCu0Ut8pSgGxUv/FqfCEaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261387852"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:37:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 23:37:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 23:37:11 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 23:37:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNNvewiwghIX6u0wc+ZJx2MGxbdFq1eC50fFPjj61izxeXt/s0rbs0P+UvRb51vMGLueWKsmyn3J1j/u4+IMCstSf6x0otVXMI5bjiSb3PVyDurM2ZLb3CHbY6qKhXyTDb1o3R4cMeZOus5XD5D7wl4RJ/jR8yjUYVnvmhH5s03PjEyq+C/+fzKAauxbQQ8nq79N+HoQKorE/v9fWecI4yCQ2/2pov3EcJGmjgoXLNoZGrRMI65LZNgCnzkGUMtuH14GGORs4GqBOhQ8PoLfHUcxyPl+T/ggd3nL7754yFIbcdNKoOY4onJCRktDeskU8vOufO5TWd9tANilXdecVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt1AQ/uohyeIHVeyp/clb6AW1L1MrlS3giI7FNNpb3Q=;
 b=Ra2Yk8XO5H04FB8WDZLNagetZVDj3usIbZZfmTRtK/I2E9+vTfI6DA9taa4ujRCouT+TOyCFMBlLqDLC31CeKhLvmztqLXUrbo1rDk3rT/b/majVGqESsljqKoO+pINJnL221e4nZGTEJD0s9uS7itC0hINmuoJrmU8XCx4NtwTMJ/ynorV5hU8Y8z7/Ji7xbCyaMMufpjrxuPfzsAHgoB0y3GPcf+2Zbh0DfG7/6bxYXdz1FLZwYaHL4bS0Seg6F6YFn0NvHlW0XecFYOw9Z67hrHNNpUuKfHcTCUwp0TUCM8RMvqpQHL6jsf4iCYjIVLBZXZKH71R2sXV1ujW7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 06:37:04 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 06:37:03 +0000
Date: Tue, 18 Aug 2026 13:56:09 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
Message-ID: <aoPz+es2fahM7ZNS@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
 <20260806214050.78058-3-seanjc@google.com>
 <anrI0WZ3rA0q6X+Z@yzhao56-desk.sh.intel.com>
 <antW3aKeEabMCsyV@google.com>
 <aoK4szIBYjaJ6RS7@yzhao56-desk.sh.intel.com>
 <aoMOo--zGYqmgwtT@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoMOo--zGYqmgwtT@google.com>
X-ClientProxiedBy: KU2P306CA0054.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::8) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|DM3PR11MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: c71b558e-cb56-4fc9-644c-08defcf31d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uBV3G3uQoEPtXE3Dve2wJ+DmL2Swy9cC0YidspaQHW3Xz56bOf2oK2Bx6JDXXqGi0+jz6X22S7dLgdjRGjmnt9ohYJZ1OrntrgVQLcz531NXhBJULYysXPR0Az8o7uODuZHheWAObQmDGyjM8i9F0OaPDomiJi6D/HA3qFSaQsGdD+hI/93lKXwYtTLrl9W3e3cj78q6gFIZjqeK+6ihJ2JD2j/EX7V2goAOwPl9Vlo46hyp/+G3O/jCc/9ceCXAlPetACwSYNlM8By587tJxYlOJlYw+DOK45BphOMi7NpSw4+TrkqJOgerIy5EpMAEFMK9M9q4wrEC1HXfteznWOkid/jaYfhcHtM9ZjRyYX2MJiSVRDspyU6hEvTcD9J3dQYVka/1EqTRa4LM6c2FJV4RjYJE2i/l9E7YpL2EpoVIJz64pQstHh5oKKcv2LycpxGkvb7wn5qd8OQt9XemM7v34aHEf7UHcFmC+bC2zO2zdEtI3kHwaw472f7J1BUD0dHM1abOOVLzgKHD6QSTrs8/aGfhqM9aYwERQg6Gt9zCyhIlHDCpQlMUUk6vic4iTI9OmvNfDd8rDfCRkAczCwRCzrIZp6kkl4TZ9jl8pw6iWkpfiiKEyFyKYhRBskQUUpzMxiegLeDAxGi7a5zlq7+TLMNe+SuepjK6UNGs0Dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DIhOhIKibvW9kxmwSGtOSYVbvN1QQcrMmuUuWy29BHbHOUY9SDzbGDVWbRoj?=
 =?us-ascii?Q?qt5qA27ZWTQAr9tMOujE5IYgJe2uY9xurRJ7993UPVvpscLHLXzpDkHzTuJB?=
 =?us-ascii?Q?Yibo1QuP/u9vbJ1imy1do3RAaYsY8vW0vcJSJZXLUrwXsMsvpA5JH+dC6d+Z?=
 =?us-ascii?Q?3bPVqae8jfVVqDu1V8ylBkIXapxGoH8/Sw5hxrgCw6wdBydqG4aqUvIUzItj?=
 =?us-ascii?Q?4zeaD0WXA26fZ258J4ZCX7RyiWBy4DwWXQSwCaOAByHlImo8IPxIEUDZYEo9?=
 =?us-ascii?Q?ZtoUbmelSYMuOmIkSxH3MbH1qAgxWg5P4c9UlyldxRg+BeYL2f7VvLgBqxaR?=
 =?us-ascii?Q?aZjP8wr9LDHeDhcdDZGi2HUC0zHeSbzfG3fza7Z9QIC5N9sJD/JEVkxfHd6r?=
 =?us-ascii?Q?BOyUEMPpwvkXNStqez8lvL9GmfnKPBnfsy9tvMuKj3872ntXWPf2BoHE5wrL?=
 =?us-ascii?Q?1OBOjxWTAiePjF1VQSoD/mclmizY3AFhyekOOS/EDHTWQ24uClZvtUYFuAMm?=
 =?us-ascii?Q?cg48MIhBF5KO5LsOifFzNV41T71bNP7jCiInnF8nt3qFENU/jv1Iu4Q4T0vI?=
 =?us-ascii?Q?ZDmTMfIShExMsxJ3m//PfM2rH/plmhwjEyjjpZSs9oF+dmyU0ZUtKGNIAFHh?=
 =?us-ascii?Q?3hJOpYlG9OYG9KzMnTBQTviMjwEghlNq9Xi55seDBUJcZR1QFA1RXSBC6IWv?=
 =?us-ascii?Q?UDyjeWP1ai6gfccm4ikKt3bieh0/0/NwRxIG1MqYswAd12tlz+dHKYHzncVM?=
 =?us-ascii?Q?GsTIjIYUeWpmYkLaNAdv/Fbl+vsq4JPgvV641G77Ys55+SCq9bs7nQ5NBMvO?=
 =?us-ascii?Q?DRroVumEVl9qdmaCAsBKFL7SQRkdy8xhhobKK10Y/nk20hD/ZycC9geggmRa?=
 =?us-ascii?Q?T5zSiehiLQVHluaKgKAPD1Xc8OcTsEOktJGSsxzvsGQ5uXG6Vy96a8VuO/AO?=
 =?us-ascii?Q?WT53t6KRSMXJ04u3Ccxfm/t8gCOKSlf86MvZi6o+b0ZyAcCNtyw4NLeVdJMf?=
 =?us-ascii?Q?7J2S9Idx0qiZSxyf+htjphA7I6GA2jdf1DeK8Pv/fAlRKWLHHZyk0TCTPGwc?=
 =?us-ascii?Q?z4hdyHUwrLnb3qwpfuRSukvDfYPsamnunTyYN2ED3jXl/lQhBmDETGD5vZmy?=
 =?us-ascii?Q?Ewh/Ow2pHFOY0HBk/hMgg5/vpPcDg9HvOyrxWBmx1bk+9tZ4sNXCXjBP16J/?=
 =?us-ascii?Q?76rqEGHLLsmUPJoRL1zROmSc80KBBf1J28gYMCttuFvNKoUQiQg268H9Y6e/?=
 =?us-ascii?Q?+r9AweRRkVbgZifUC/l12b05JDP3cUdpTTr6N3HpbFxXwPyrDeFQVFBeAcgS?=
 =?us-ascii?Q?DuU++he58o8pCshBWUbrM7h8lkoz5/n01bNcmRXDqFeiPlpDuwwSVhthD5XG?=
 =?us-ascii?Q?eTlX6Dm0FggmFMtoPg3edBUjsD9Z3jPkRshJqvT/A4HNghvQ5SWjai8hFTQA?=
 =?us-ascii?Q?ZNEqyyIQ1CjgHtEutyJLcd6G4EJQbGLK/oZeh8ZThXilXPdwKtZNunwCEDav?=
 =?us-ascii?Q?t2RUoFf981aOHGYaOITPeVpcW50WJIPSlKEQMgD3asYm+mrapKPC2xhAnjeM?=
 =?us-ascii?Q?Uik1UOihj9OloswrCVpWNB4wEgsPFJ6abfgYarCUf+jXhVzUcLgj0UCptchU?=
 =?us-ascii?Q?RLkg260GVmXzKSO0xU20duGbFGhIpPfi4ylelDz2wnUJBGolhombjk8c/okM?=
 =?us-ascii?Q?havA1oGeCWfuWJ0PCcZD1CvQI0tmykgXAQaTuQ555jq+l9uHHAXM+m+A+IMO?=
 =?us-ascii?Q?UHd58+fPbw=3D=3D?=
X-Exchange-RoutingPolicyChecked: QvPf7RVAGg2dXnMGWMubKTlVlDigFQlZrngxeNnCFl12ZgxLPYflznjkPYSmtBayG/OayXnZ/9FZVBzeXeDUWnR4priQi9Lwj+py1JPMXrauB6Gnr271z8m8dEM1gA0Vtd8dU8HhEgmEFQa+P1J61rnRpAmHRa0vxJ/lba1x8E4vFCfZXtE0FD8gnB7boIcWFJGgQc+78ub0GPaDUrn5dodzsf8tGyCzIf/cxFNAHtl5EBAvZfWi63QguI87GvndzGjo3yLtZC2UT+2i9N03hqkIMlbmX0O4m7E2TAKCw/fiWA1LAiSaNzll9ADo1apbMy5Y4IJNSrry1DhaeL1kpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c71b558e-cb56-4fc9-644c-08defcf31d8c
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:37:03.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0bX91k7lcfI5e89yLR923yzgxpsCXpTMFb0Fgs351O0MjgaMpZ1GU8vJEkg+UCIJ5h3JUlnehF7/Yr0H3/edg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-OriginatorOrg: intel.com

On Mon, Aug 17, 2026 at 06:37:39AM -0700, Sean Christopherson wrote:
> On Mon, Aug 17, 2026, Yan Zhao wrote:
> > On Tue, Aug 11, 2026 at 10:07:41AM -0700, Sean Christopherson wrote:
> > > On Tue, Aug 11, 2026, Yan Zhao wrote:
> > > > On Thu, Aug 06, 2026 at 02:40:48PM -0700, Sean Christopherson wrote:
> > > > > Move kvm_tdp_mmu_map_private_pfn()'s reload of the MMU into its tight loop
> > > > > so that an unexpected root invalidation has a better chance of being
> > > > > handled gracefully, even though it should be impossible for the vCPU's root
> > > > > to be invalidated after the initial reload.  As is, encountering an invalid
> > > > > root is *guaranteed* to put the task into an infinite loop (albeit a
> > > > > breakable loop that honors NEED_RESCHED).
> > > > Note: without the newly added is_page_fault_stale() check in patch 4, an invalid
> > > > root would not put the task into an infinite loop :) 
> > > > 
> > > > BTW: As noted in [1], is_page_fault_stale() only checks !mirror roots, and
> > > > kvm_mmu_reload() reloads mirror roots only when !mirror roots are also invalid,
> > > > since an invalid mirror root was considered impossible. (up to now, no?)
> > > > 
> > > > [1] https://lore.kernel.org/all/anrD8nI8RfYoNvbf@yzhao56-desk.sh.intel.com
> > > 
> > > > > Add a WARN to try and detect bugs that break KVM's expectations, along with
> > > > > a comment to explain why it should be impossible for the root to be
> > > > > invalidated.
> > > > And there's already a warning in kvm_tdp_mmu_map():
> > > > "KVM_MMU_WARN_ON(!root || root->role.invalid);".
> > > > So the warning also seems redundant.
> > > 
> > > No, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS can be pending even if the current root is
> > > valid.  And once the is_page_fault_stale() check comes along, the WARN in
> > > kvm_tdp_mmu_map() is effectively unreachable.  The patch ordering is weird, but
> > > there wasn't a great solution because adding is_page_fault_stale() first would
> > > create an obvious infinite loop.
> > Ok. When KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is pending, it is only for direct roots.
> 
> No?  KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is also used by the shadow MMU, in
> __kvm_mmu_prepare_zap_page() and in FNAME(fetch).  Or did I misunderstand the
> question?
Oh, I forgot about the shadow MMU. By "direct roots", I was referring to
"!mirror roots".
kvm_tdp_mmu_map_private_pfn() is currently solely called by TDX. So, even when a
vCPU has KVM_REQ_MMU_FREE_OBSOLETE_ROOTS pending, it should only be caused by
invalidating !mirror roots.
Therefore, I didn't understand why kvm_tdp_mmu_map_private_pfn() cares about
invalidating a !mirror root, which cannot be the same root to be mapped in
kvm_tdp_mmu_map().

> > This patch still holds that assumption true, right?
> > 
> > If so, since mirror roots cannot be invalid after the first reload, any
> > subsequent kvm_mmu_reload() calls triggered later in the loop would only reload
> > direct roots.
> > 
> > Is this necessary for kvm_tdp_mmu_map_private_pfn(), which only maps private pfn?
> > Or is the purpose of this patch simply to avoid the potential infinite loop
> > after patch 4?
> 
> Yes, though I would still want this change even without patch 4, as there are no
> guarantees that KVM won't gain an equivalent check in kvm_tdp_mmu_map() in the
> future, e.g. as hardening.
Ok.
