Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1E1DE4EF;
	Thu,  2 Apr 2026 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098554; cv=fail; b=B9B91CyuBcTTr88XY1CQYO1NKFJtrZCaIhsI2nNhwq9qyEzHaGu+i4rBMizhN7QBLAZSD+Uha6xMP82T0oZUOwYQbvgdlwLrT9ZCWwnatz+paLfpbMZncd1Jvw0zORK9kLXo3q/SqUG8hYgq1izjnQ1Z/tgqLks44NGyM/l9on8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098554; c=relaxed/simple;
	bh=J2HAcGgAyf1+lt8bnoE56YQAG/2EbFuXhZKvOSfvebs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LpI00exsthH/9P52z5O5fitBe2CabzCvr3cnZjCtsyrwx2HOhewhFTRIPRVumIy0EA3YAblULfdZYTARkuUk0lQfhJk08Qt8Hcak1Zrd8Bm0sAf++Qb6wDgAfz9nTC3sPtAbjly3HRR9whYVeXxDI8aDeyEZSYN1cJGUCZbybxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzsoRC62; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzsoRC62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775098553; x=1806634553;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=J2HAcGgAyf1+lt8bnoE56YQAG/2EbFuXhZKvOSfvebs=;
  b=gzsoRC622/k8jpKfz/zd1+pwtP0qShjyl/iGBiAf8jIK2v6UaxLdKVnb
   jWJlq1kxsxjGJy2ut5b2wbBqQ13fPNAWFK5JER1LJIfIASdBqZDTlWpMG
   iIfP2mUfBjTbuYBW0khmC9GWW6YBT0C0uiXRckr+Unkn2fSJG1BkP+IkH
   euuU+g10Gexm7SyDY5j0jOoRatcui6XSxrJIPIOk2dXaAZo82Kdjycpf5
   GY4EWnh/5llcALxyQYU6jzL6CeaYel7B7Beb6OQHzvyig15+96Ym0Uk5m
   OnYNOAoUbhx4FfqNeC2VW99ojZEiQzK7ctlklSCTA3uaMlxMXAEehs0vy
   A==;
X-CSE-ConnectionGUID: KcQSnZZDQF+niAGMGKI8qQ==
X-CSE-MsgGUID: de41BtipS0qkULFOTtfTdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="79760525"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79760525"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 19:55:52 -0700
X-CSE-ConnectionGUID: TL1/y73KTrOZeGEQzW2tyw==
X-CSE-MsgGUID: /CgQT3pTTeu5PpUIlz2DEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223979730"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 19:55:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 19:55:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 19:55:51 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 19:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhjUjSZ5lpy5tVYGi0JvpuqO8HXKet2dPNBWiRExZiwO0D5XC+stMG5HOOMsa4vZBvlyWKWs9iAkTBvxpxicCuKz7VrGj5U9VVMWjcjE/xWp444TDQYgcdInto6fkZaqSk8xcMbauv3f8TlhMHkVh3enfF9/dMP7/uUIqoTr1oYIelW2UboZxXe0mOgwNdwx9JfGI+Ape5HT2J5Dpvkb4ciFy0SAxx6bSzccDpS6HQPLZaAuc5zSnVK/dBYzm5HF6zdjjrMe21GE0KyFJXxEjw/XsMG/0P1QOGSnsjTElcRtVwIHeIfxamUwjfYc0ka2dJzl1BffTQyulYvVr9bD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVAqxRHve5NxpJ228WcY7U9B5XSX3zHkW2nOhfH16zU=;
 b=PeInW+zVc3o7FwheI+a5PGim+QpC+rBPz70nJ2i7BLzuclXQBLtqG0AeSkxDBkiwIA+33ozlAxNhwjUeTkzYPf6++pNOTGBEzjKalLu9hIt5zSEzCXhQ1tSLGy8wX6aTeIw9N9kXt5pJX/45GCyICPo6dszMsLMjUTl1sDyLyIfX+e2Y8CNTn9OkGA06eYxefzrunoArPK59MqSDofgLz1vDJx6PZ4icYMtvIYFCofX5d2F7Qiqt2LzyuNIZAP90qfMzOcBuf08Q8fHQTW/NgjcjfkdMBmAbdD54EeU+k6clYpVhBFxGv8WizMWxjnPYRNjvszv0oWTA4dAVW8SlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MN6PR11MB8242.namprd11.prod.outlook.com (2603:10b6:208:474::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 02:55:44 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 02:55:43 +0000
Date: Thu, 2 Apr 2026 10:16:07 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 17/17] KVM: TDX: Move external page table freeing to TDX
 code
Message-ID: <ac3RZ+Q2KxfbN3Rn@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-18-rick.p.edgecombe@intel.com>
 <acoq94R7F7k/9AV/@yzhao56-desk.sh.intel.com>
 <1e4e63094021e0fc8419bbbe5450abed7f88f06f.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e4e63094021e0fc8419bbbe5450abed7f88f06f.camel@intel.com>
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MN6PR11MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7c51a3-90e1-4c8b-db16-08de906354e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ovur7AB9MTpG6fgQriBYYHH1vSuYAvbHYGYIo3/2+9Y9AYyIf4fypjUqQm3uERo2tT9cL3cyCj4LBDYlhZtrby/88S2rE1AWErF/+g4uQuCr39GoN4PFiXufmQgZV5QREIcrT7Kn4qIjGo6XOgItAqKWpu2kYjWf7zqJ6LzJkGrUWGUajcirNiFpfc4FrEHy5WPC4oCopyZZYfBJDz7JtdQlPIvfnBkxbaIUtDZsXSL2Mvbkn7hWEOF7y4kYhU7Pz+VwpRoXHH3gFf/1u1ascHhhbDuBUayODSxOfSyeR9v2VuTy0U+fDlKT7YvhSFbGnpxieyzCpmeUDSMBv03SoWaxcP9Iwd6EKsir4qZ1XA1n9VIZ6nXSSuCKbsHOBTaZv3JNvMVKw8LsYIuX4RVRMJlUjH/KB2RWOoIddKGreK++GovoqaieXYoGT0VQ4rUIwGzh5SY/2XJ0mwmDqqOXJtck08xvyhyq1BdQgkHsUDRLgEn4BHquuoNHvKDi0hwrzvrmDtowYIAIYS+jWkherOMZUGSxO34AyrwRE6qoc4NW/PmlDavEE7LLA8rmz3MgTLkuDGt28xxrrl+Hw6AEQ4WAB//HbGHUwovJg4NcuWq6HxAWnu/ztJkDiSqPkPaQzgjIvY/kODU1G5sOVeObNpGbfYsEUVPxIm8/YeLeYsd8HdPaKzOmYIUinfWzICvh4I1zq/7r60UdUz5hs9etyKiZ31827ONiSZhji6XCTjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xF3Qpwcy/rjyROtVdfGaQzCvhpqNzbDkl4IQZdO1A45W93aiXFdDJKS9Ho?=
 =?iso-8859-1?Q?h2eVOiy2j0GIeMBLNpMrCdygCSRMywvkEnzGKRD5KLDAiGicXoK5qQsJ57?=
 =?iso-8859-1?Q?ICj5lxAmi0tajJyjSXFugyx33jktUdbEmFogIqaDk2YjPNUh6YQZAZM+je?=
 =?iso-8859-1?Q?carhgIDINdwKXxrJ0fBJw7rbeG66jVYC2EKZQJzkjdcU4X7BlYUYtBQM13?=
 =?iso-8859-1?Q?Sl96L6Yut3VIJIJVctk260pRIbE4noO/qJmy8G02aYOIl9j1nnHf0+vw6h?=
 =?iso-8859-1?Q?cYWZc5lIq/awS3EmX8MqMLDdaMwP/ov1CbAY7VFCWGu3I7Hrcsvrum/Gdd?=
 =?iso-8859-1?Q?RNhTTKH4yB/aWLuQIRKq+eIEcGFqs6U6XP9P0WswIaEJcQeKw5inMIKMyw?=
 =?iso-8859-1?Q?PRdYtyDx7s26whKB4fASdCkw5BHMG3qoxOSqxi5eM9flhMYspUBJBKykxp?=
 =?iso-8859-1?Q?4R35bmfq3PJMHA8rVyTmlfesQdXOEpIfOmPCeWI9UNrcTnFV9LWW+evNGy?=
 =?iso-8859-1?Q?Q/YMj7fLHvGFmNk+dGlAmByMYXaespVxeoHnmY1ylNvM/UzQtw3287qqKv?=
 =?iso-8859-1?Q?sxWgHTme+3Z4vKRYf5DDUJkVqWiCscdiiRfwjuhWEn9pQLdg6fh+1hJB8j?=
 =?iso-8859-1?Q?dh4VvNCyln79CgeI8n3W0tLVzsHjFIdt3ur7T0cgVhjrYvsxF7q/oUvvRY?=
 =?iso-8859-1?Q?uwwIpvbGEwZ5B1YeXk1B5p1/VvxX9ZaZcjsvv2UZoNEPzr59J7uLe6SgYN?=
 =?iso-8859-1?Q?lQHsYnEnWzSgXw9Ldj+9E6wDwlPb1spH48mpF2rDpI046EwUKW9Xv3+gko?=
 =?iso-8859-1?Q?7gQNyJLgZSf8zfWjThf2qC3V1XsskXtSY14z18Inis8AvaWs/CLLC20O1S?=
 =?iso-8859-1?Q?nhMld1UEGUFV8MURgjQEgVnTUo5C+I6yLkfdM389eaGSwf7CWtnqkbcDlt?=
 =?iso-8859-1?Q?krnUQ4u8MU8uCJ4iD8ic558vZheBOls+AvrlWfOAcHGUYkt+0hgJMHJ0iJ?=
 =?iso-8859-1?Q?BNfbqJTzBtlvDxhdCih6mdmg9Qv4tT16pLTgsnVJS2a/Xt4YGd+lWK2zZq?=
 =?iso-8859-1?Q?kmVLi2IlEUw8vD0S5/onHwa5Mmc/ACKhGLCOPII+JroDZv1Smmg5VbQb1x?=
 =?iso-8859-1?Q?UY8B65HjPjCeyZQr5oNAOxs5n37J04b6SB1X+NQ7ZA8sphw584JgmPdIVq?=
 =?iso-8859-1?Q?sjXIm1UU5DCwc4q8FOaJowuieLOCWSlMmiADPsMgNKCOjFAd8GkK9RraSk?=
 =?iso-8859-1?Q?iO+SUPJFZl8o3cztZXQTdeeudgK+LLIzNUqbuoXe3IBQJhif7taVlzzwLW?=
 =?iso-8859-1?Q?ENpeHWqr5bfIMQdp5SXA8nMD1OYKo/kg5VthmabwwuOw6E2dkiktcHdAQf?=
 =?iso-8859-1?Q?cCupMKP/jy5kYSmfyqNGE70+9n67R/G7ckyA8xDE2cFn95hmRmnU22etF4?=
 =?iso-8859-1?Q?Q3UwQzYcw0hKUcRGGShbl1AR/lYd3dpWFywXYSCBdp/dOFyVJkZAhlL9Ua?=
 =?iso-8859-1?Q?oTJqU5mwTsG79VZEDafE6Jcw4bjO5cLxJoGrZZpnbHPVOyHcf9r02pyHBy?=
 =?iso-8859-1?Q?NW21kIoz7w5gfSsBNrW1uJjh6WSAehZc/2HocEI6o8cNJHXoCmst0NDEws?=
 =?iso-8859-1?Q?9tA0CUZI6xrtmU+m/lRLOMz3eQNRWMs12OPmfbEQVqQv9kLXlhnUVY9yE3?=
 =?iso-8859-1?Q?Y3PzZklyK3tGema5nq7g1XU8nrgwmwNuIkmwSiIhx7xKytr1FvPNlbExcm?=
 =?iso-8859-1?Q?OoXG3oBdOXuBzJdGSoYYFRan04Gj34O/7kKH7J1tMW2jxCtFEu0fOo0xW2?=
 =?iso-8859-1?Q?RfwhVKHrtw=3D=3D?=
X-Exchange-RoutingPolicyChecked: oXrPC62n/hjnFPsD8gSGQ8TqHCPgIwVXNrExIJ+VHxGI+MdUPq9mpdV+W0OeC7bgZyzQitKGi8Qoen/WMAb8THodI98x52XNQKfKm8Jr1Bi+TGlnsNCaeCICv9iQm+LdbnB3YkS2zvjx+XJd65FH/YE/Dyqooc7oMB6y7EJdAQxsLk5FAzKZTLfre7x0bIdUTjRo/b5QqRuUnMm2xEoaJGramU0mA/TQ9GR1VV7p4u653psMcZRBEFDRcrQq7F0xhM5DXoUS7UoJ4YlRqUoKBdEvdQc6UoTOeBlj3nEno39JkPvk6a6MeFRoJUzTrv9/WcIw+1mDqHO9Y/XewuhG9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7c51a3-90e1-4c8b-db16-08de906354e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 02:55:43.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIG4xkGjfO4ZuZbJAW74v/QRLUWs8j7GkRabqxgbIVJfBz7AFLkPVogX/janOBUhfu0/2kcqGR8rAJlib6bK3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8242
X-OriginatorOrg: intel.com

On Thu, Apr 02, 2026 at 08:17:19AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-03-30 at 15:49 +0800, Yan Zhao wrote:
> > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > > index d064b40a6b31..1346e891ca94 100644
> > > --- a/arch/x86/kvm/vmx/tdx.c
> > > +++ b/arch/x86/kvm/vmx/tdx.c
> > > @@ -1782,7 +1782,16 @@ static void tdx_sept_free_private_spt(struct kvm
> > > *kvm, gfn_t gfn,
> > >   	 */
> > >   	if (KVM_BUG_ON(is_hkid_assigned(to_kvm_tdx(kvm)), kvm) ||
> > >   	    tdx_reclaim_page(virt_to_page(sp->external_spt)))
> > > -		sp->external_spt = NULL;
> > > +		goto out;
> > > +
> > > +	/*
> > > +	 * Immediately free the S-EPT page as the TDX subsystem doesn't
> > > support
> > > +	 * freeing pages from RCU callbacks, and more importantly because
> > > +	 * TDH.PHYMEM.PAGE.RECLAIM ensures there are no outstanding
> > > readers.
> > > +	 */
> > > +	free_page((unsigned long)sp->external_spt);
> > Since sp->external_spt is allocated in kvm_mmu_alloc_external_spt() in a
> > similar
> > way as sp->spt in tdp_mmu_alloc_sp(), why bother making freeing of
> > sp->external_spt special? i.e., what's the downside of freeing it together
> > with
> > sp->spt in tdp_mmu_free_sp() ?
> 
> I agree it's questionable as a cleanup. The change originally came from your
> comment here actually:
> https://lore.kernel.org/kvm/aYW5CbUvZrLogsWF@yzhao56-desk.sh.intel.com/
> 
> So for a more concrete DPAMT reason. That said I agree the reasoning as a stand
> alone cleanup is pretty weak. I tried to put a brave face on it.
> 
> We have to think if we should try to include it in the initial set or include it
> with the later DPAMT parts. I thought to try at least to do it earlier and leave
> it at the end. It also kind of helps to see more of the overhaul together.
> Thoughts?
However, even with DPAMT, sp->external_sp is also allocated via
kvm_mmu_alloc_external_spt().

static inline void kvm_mmu_alloc_external_spt(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
{
        /*
         * external_spt is allocated for TDX module to hold private EPT mappings,
         * TDX module will initialize the page by itself.
         * Therefore, KVM does not need to initialize or access external_spt.
         * KVM only interacts with sp->spt for private EPT operations.
         */
        sp->external_spt = kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_external_spt_cache);
}

i.e., sp->external_spt is allocated with no difference from sp->spt.
So, I'm not sure why we have to free it differently.
What's the benefit of keeping the memory for a little longer than freeing it
immediately after TDX RECLAIM?

Or are you planning to allocate sp->external_spt via a TDX hook?

