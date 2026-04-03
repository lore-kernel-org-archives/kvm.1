Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373F285CA8;
	Fri,  3 Apr 2026 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775186866; cv=fail; b=HUKfqCPcUSxtHtWrHzil6jAwzVlxxb2GYInQdjwFdBcL549hAMymg2Mor2+VMfGLyLEFWkm2mbnSLWCzq9M/7257CD+fmrQhk3zb0+NP8rD4c7BaGjKu6Ar5qPEXDaUBou4cHQ697pmB3phQ/n9vf7MWa5/0kmtw7zIZYa9kjqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775186866; c=relaxed/simple;
	bh=47dA6KnmNLpXAle57aYifUxRTuTDF/Ltx/9CSHQ8kCg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZ0OAeL0sXiE111LrUiOiuygQD9VOTKdOYojLBTP9G3aR5f6ky5NvsHduo+pnHIO4fEN2RL9XTXAv35MNbhMQlbr+3qiATjK3TBWnMfRPBeGGw4NDqhw5lf4tPfczOPa5LUwxQ3JL6AyIBKjAw1jv6+GoF7Czp37fIuthwj4bRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBzow39V; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBzow39V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775186865; x=1806722865;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=47dA6KnmNLpXAle57aYifUxRTuTDF/Ltx/9CSHQ8kCg=;
  b=LBzow39V+rCy0oYWqRVpbkYEsYnl9UryQcArmkgI409Znnypxuo6SMyU
   /k9Pq552ZGDNvHUCa/AE6zJmKgRxAAkiesP3gs+tfBzYjHCVEJO7u5Ks7
   sC9dD1Iw3SE5pvFa6Fl+B3W1oLK6GqbjRyCdoA83Zr79xKbkGJk+NnmeA
   VevtbUN0S3eVO1myWAPHWIRxY8LdoFSqnfE+4QvIkMbDYjBKW2ztUuFwa
   /G3br9EPx3BzikOMp9J/UDMV4nB92LJTJ4gLWGTNf3NE2ttYx4DZ5Dr4J
   YD2JT8sXYrmUWyG5P5R8sA7QraGyGtBIoasYjqCW8itrh62ByH7IN+BDi
   Q==;
X-CSE-ConnectionGUID: s7j7hAgBRyqQheWcq8envg==
X-CSE-MsgGUID: z7WZUdceS1SAUsPVILUy6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76222541"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="76222541"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 20:27:44 -0700
X-CSE-ConnectionGUID: dOdwwKP0SXGl13qoyh1AfQ==
X-CSE-MsgGUID: buTP8YXwQTy2sDj9KEfelA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="257620779"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 20:27:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 20:27:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 20:27:43 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 20:27:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOmRePWMwIIcF+CknXNkxYUjB4MYGFOaSP7BN8yijtdNZrc1rdU5v83bL85rMboUpbQ8O/kg1evTD8VXun2NtS2k0JbCAf1enVCKKruNNQTJpShFDXv1uL8XZOThO6EaRSOQCFDS1BzCtZl5OpBYJSmJ3b+FaD9fG6hB0tqxuJe+sacg1HyKUcKcDTcYQ7lrowBPmHXO47najNvvr/vfk/TDdetW0IpCxOBFQZi6Oe/0RnjGDgTYk12RCmlu1Q4aXZYaQ4AqfZxekf7jggUyXq6YylUp854m9t2Sx7cGU3F+aIGt4aGgid5jxAJ3XjjB6yoRAF6Me7GebuREYPefXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lmpq95YbFq+MtBmx7vXA9SO11J2riDJBJroYWhc3z94=;
 b=VJxxZCqHNrZkU7XJVqsOkHPjjtubHKYWObTYASnVLQyWsf0EiPb8Os4ZdmGCh15TXw19b0AiqtVu/tuLE3BHI7etO2pQ/D5s+cc2ukZzGooXhU3qY+FATba9n5dfXX+ID4YLnF338H0bI8rrfDiNZ0Ev4vg5kA0HGEFdiqw+d6ukw7NCpGermbG9LgcEvo1WBdegw4DUCf+2pvKumM24QnR8vwtdGfifrrsbQhPtRu1pxM6QbFVKqPPGi3aHYHZzWu3Z82gaBk91VR/3rAZESD7ICfKxUF/geu4ssanjY0WHI59vuKPBYB+8voh/dgfMCuQTJi6tEIKeZ3NUpCp/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DS7PR11MB7857.namprd11.prod.outlook.com (2603:10b6:8:da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 3 Apr
 2026 03:27:31 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 03:27:30 +0000
Date: Fri, 3 Apr 2026 10:47:55 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen
	<dave.hansen@intel.com>, Kai Huang <kai.huang@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 06/17] KVM: x86/tdp_mmu: Morph the !is_frozen_spte()
 check into a KVM_MMU_WARN_ON()
Message-ID: <ac8qW6qMoAZXS8g9@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-7-rick.p.edgecombe@intel.com>
 <acoDhjbA0xIycCJH@yzhao56-desk.sh.intel.com>
 <3a046909b0e295d810ab9a7bf6a35980a9c708ab.camel@intel.com>
 <ac3BFyNs78NFBd00@yzhao56-desk.sh.intel.com>
 <ac7BqcqSp8VBmGAi@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac7BqcqSp8VBmGAi@google.com>
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DS7PR11MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf51893-0ac9-401e-ea80-08de9130f00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: F101IQlWI7LuHu3t8zFWBHVW07Dv7i11TSzmBKsMy4ArgDLY4S6PffBYrEkCEBlxs/glRYZH/PnqT5026GpYRxb6MDFdQEJ4o2fujart5AMkVoUt/llj5fUjphHRF1svHUw0FkbNr0f3EbDc2IGBlg0KUVQjKm9kEqyBKUm9K9KmmKSpiKWv40x1p0xDXbRp4Ub28ZFPy3wAWLZZIVuVsva3129R2bGOBlxzfKn6a0qN7XW6afeDJyHRBPcyYCYfbx3RVgRdb7ev+Jv5AdN+NyD23LKDdndf9moKtvJhhc/Hft2Y2wpuUWq8iwm605FL/Q/ti3YX1k93ZscRbYmMcamvYgB6w0Qy2ZeWcYnrr6EebD0zUfkGIwWIKDW0EEQdD9LrrcHyiqVced7VkjuCrH+Jb8302Ehmf/SjxSzDWABk79IoHwAFvDb1IGbrivMlSm2O307KvsbidkrkxdSFiU+dGE7r2/k+hqRPyRarTF+3tYSTfs/3Q/Puet4pdmsB7GGOasQwigd6VHAlAfxOFAJB+RGpsaPfViUd2ROggyFMvl702v7xszJsQ0zTmjo5HdlLeUC1MJcUA6guA8Vrk7T5djrL+rjq1mJE1uCj+PLLUbqX/uk+tuYHc/E39SWdpUaBa77H5za5Sws53605CTPSTsFjNOUTTfiPP+r6givQPDExlhu4VhZMXN/mAXt9VT+psQ1FMNlaZRodIoo16PO0ngClKOxlX8HoQ8Y7WUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?B/vevK26E4QzeIKMciLpYnIrFdjAltBuzXDpgpFewPNse8vPNX1QlyWtL+?=
 =?iso-8859-1?Q?4/xuXDUSdKFlsVDJ1h1VpZjB+NXX4AIveh3Um8ykVQ4DBNfEZkCeDERRyL?=
 =?iso-8859-1?Q?x8Q3F1WggWW/ScV5ctT8jdXRq0x71Z43Sf72xUh3/ncWs+jg6/f5XyxSXe?=
 =?iso-8859-1?Q?G3uKMpeCPw7F7FGpMtzhmnQIL2KMJ6ClUdvENpPdDbpSYfI4d5Cc4RG7ZO?=
 =?iso-8859-1?Q?nhshEbvfNWiVrW58LP40Hf624zCZuIIHa4QQNCRsHPcNkgtE4PT6Ue2xhc?=
 =?iso-8859-1?Q?DdRgHwY3KkP9qPF52LMn2907G4O08b9FEd6fDXri5rLFWbJ8SU8RCYn3V3?=
 =?iso-8859-1?Q?txc+1pshdiJKteR6MgT/kVHZYE8yiplQ/LDUsua3WxTytQX9rbqpjhwVUc?=
 =?iso-8859-1?Q?7paBHzXfmKzoIpNAIKyXBtjbTAo4oKI2ma0oyL9H2hMrMCVCWfWS//Gwok?=
 =?iso-8859-1?Q?KwiJ672FICGWDxRKhPVGAkteB3SlYR3wt16+coYV6b1iK8tJF1YYHwHudg?=
 =?iso-8859-1?Q?TvAnQhxOwn8ieTmEXtOEK3X0z6z66A+aVJP84GDXAkKgUWDyotgWqMwoRu?=
 =?iso-8859-1?Q?geOQa6cy3Za1R1XRc2e2I7AFoR9CgK9KWdGH8LvYwZPYuAsCRzgGFsMBdn?=
 =?iso-8859-1?Q?Alrbe5WmHE/4rQNv2USNYK+c0DnOkfXS99ijPZfHO6KP+Qe3+sapK2BOM8?=
 =?iso-8859-1?Q?CHmvqIgAimMgvjVESAMmiaxVwTPbU8Do7tGo3RtKSxAbSTv4yOT4CgVI5N?=
 =?iso-8859-1?Q?wpjPhEMYr9b3qSdAM4j5IBFDEEtnsiw9sfl1gGnoVthZEOvviTAj5S4edz?=
 =?iso-8859-1?Q?cLS5ibeOfUUuNwRrZxfZMKQUVGWsEMPBd336NAruj1UpU1yQmViEs2eqzE?=
 =?iso-8859-1?Q?3/MAjNZLyUW0TyEQZczurBjM85y1EJLVv05D2p+6fOPCrapEooQyEfsnN5?=
 =?iso-8859-1?Q?IjWngzbC0wDqaLBUNvfrPnTon0wd1Z9k8Z15Mx9EBf+fRALDgOWBi4lzsU?=
 =?iso-8859-1?Q?c/Wphn9hFIK0M+mgjtKA94L1W9ty3xXx9iIpYeePpCUNG3n/f6+4sjVB+B?=
 =?iso-8859-1?Q?KCVsjDMURpqgeKhUthEpwz+dsh5f48kSGr9wTU+a3zIwbIQH0Af6AwjRu2?=
 =?iso-8859-1?Q?CAwomOlLKwRlENAKo3IDy5Pc5u8p/A4Mawi2ykFu2BXYavOetskUAuTYx5?=
 =?iso-8859-1?Q?VGdn39zPfjEDdwh5zMsWEMOlS0u6SXJXBBDj6vEI6+hWggfrkQyjxA45ny?=
 =?iso-8859-1?Q?DqDk4soPMa/BJfHfdQ4LRxMVRjxyOCdZ8m3Dso+UjocRZwz/ld7jCqPfkT?=
 =?iso-8859-1?Q?RHQ8ZO9VClnGCrPkWNgjIPd+vbXLeq5iUBRe4d5klybunONtHNp/yKDZN9?=
 =?iso-8859-1?Q?nilIr/FPNHjfaluOQ5kHktoVVA5yiU5Ahok2HAe4RyXRhYhn3mKeMN5ujn?=
 =?iso-8859-1?Q?u8X7aS/M4jdMGMo2BScDdI7w0I80xjr58EJy+J6jkktr7/0/dm47ATouxD?=
 =?iso-8859-1?Q?OGErDYOE73Y+Mf0lRxQWkrbK2yzqIPwfJsdzyG0Y4DQnRPW1g2H0nSIGYT?=
 =?iso-8859-1?Q?szTCEA+lCzlkhO31D+kg+pwdHEMTO2/YQfDnvPPfFleeHYfnZIjp06p0y1?=
 =?iso-8859-1?Q?jon3RF0dbB5rptdro8jUZK1eyTwYLl9BIdAQiVaTd9iTpL4CjcMhM2c4Et?=
 =?iso-8859-1?Q?jxaRMV1mQ6hZgJyGNLoadQotnAxm3B7J7A35JS5yCQ/F0bGXIvP5QjGhhZ?=
 =?iso-8859-1?Q?nOTSmuua5UUrkzF9eQ586XkvHjppv7RVwI0HJ+LQDLUcvBpjjFMvvba7Sq?=
 =?iso-8859-1?Q?OrpjppRRGw=3D=3D?=
X-Exchange-RoutingPolicyChecked: gS/CG+ndhsA1Y+Jtb6PO1wkGs3AXZwrwlepTC8zrV3O8hp0phBw1r3wEoR8CHWL49sUxhdvkxqYZ103TIzEdcC8yywO+WmLHS9SpA42vPym/+aZR0uNLErfVPPd2E5Rnc7ZSy2CNOm+9lZibm1nvcDwzUUioZa/2ol3fYCIfkTNhFZwf93g91+6JSPZ533TRCskloIYl21dVupvBgdPkDoOTVccUklJN1PpEeHb/TyFyy8ZBQ65sVzptKmQuXaMKDto2NwnbynY7Yvvf/Pq+uYCa0tJJsqU8+4WI9AiktUbbxfFmrOTlzLRh5wNl4q4mkLfqEImA+fWYBZBnf5ED0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf51893-0ac9-401e-ea80-08de9130f00d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 03:27:30.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvUrnmCcy6hf6HixzZpD1dU+XiwLaqxEOoLmI148M0a98Cb32hCJt6/aX+Hgfc5rXWKIMCo88JdyJW+uKkePtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7857
X-OriginatorOrg: intel.com

On Thu, Apr 02, 2026 at 12:21:13PM -0700, Sean Christopherson wrote:
> On Thu, Apr 02, 2026, Yan Zhao wrote:
> > On Wed, Apr 01, 2026 at 12:37:51AM +0800, Edgecombe, Rick P wrote:
> > > On Mon, 2026-03-30 at 13:00 +0800, Yan Zhao wrote:
> > > 
> > > Yep on the typos. 
> > > 
> > > > > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > > > > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > > > > @@ -656,7 +656,13 @@ static inline int __must_check
> > > > > __tdp_mmu_set_spte_atomic(struct kvm *kvm,
> > > > >   	 */
> > > > >   	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter-
> > > > > >old_spte));
> > > > >   
> > > > > -	if (is_mirror_sptep(iter->sptep) &&
> > > > > !is_frozen_spte(new_spte)) {
> > > > > +	/*
> > > > > +	 * FROZEN_SPTE is a temporary state and should never be
> > > > > set via higher
> > > > > +	 * level helpers.
> > > > > +	 */
> > > > > +	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
> > > > Why is KVM_MMU_WARN_ON() used here for new_spte while WARN_ON_ONCE()
> > > > is used
> > > > above for old_spte?
> > > 
> > > For the KVM_MMU_WARN_ON() it was Sean's suggestion.
> > > 
> > > https://lore.kernel.org/lkml/aYYn0nf2cayYu8e7@google.com/
> > > 
> > > It allows for compiling it out, so probably a better choice. So I see
> > > the options are leave them different or opportunistically convert the
> > > other one to KVM_MMU_WARN_ON(). Thoughts?
> > I see there are mixed WARN_ON_ONCE() and KVM_MMU_WARN_ON() calls in mmu.c and
> > tdp_mmu.c. I'm not sure if there's a rule for which one to use.
> 
> KVM_MMU_WARN_ON() is intended to be used only when having a WARN_ON_ONCE() enabled
> in production environments isn't worth the cost of the code.  E.g. if the code in
> question is a low level helper that used "everywhere" and in super hot paths, or
> in extremely paranoid sanity checks where the platform is beyond hosed if the
> sanity check fails.
> 
> The other thing with KVM_MMU_WARN_ON() is that it doesn't evaluate the expression
> when CONFIG_KVM_PROVE_MMU=n, i.e. can't be used in if-statements (the only case
> where it's used in an if-statement is wrapped with a CONFIG_KVM_PROVE_MMU #ifdef).
Ah, I missed this one.

> For infrequently used and/or slow paths, and for cases where KVM needs to take
> action no matter what, WARN_ON_ONCE() is preferred because if something goes
> sideways, we'll get a helpful splat even in production.
Got it. Thanks for the detailed explanation!

> > Is it necessary to evaluate them all and have a separate patch to convert
> > WARN_ON_ONCE() to KVM_MMU_WARN_ON()?
> 
> Nope.  We could probably convert a few select ones if there's good reason to do
> so, but we definitely don't want to do a bulk conversion.
Makes sense.
