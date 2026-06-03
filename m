Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2581B4223;
	Wed,  3 Jun 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489392; cv=fail; b=qBzj8ahoo8wH220ANVzK0IlVCp7cKjlM8nn9o8D/MQVMqGnAuLPLt2evannig+AHi3NYchWFjQrQl+cQVznRj1l/w4eyTccJPhobN1UMF595DuB7+FccAB0jUSsfYacaVKHkI+J+QiH4v4kAl8IViLD2d96J6TWqp3szpdk+dqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489392; c=relaxed/simple;
	bh=9R2r8SugmiPNf40duvozZrw9aLWSg8EV0sXCu07zUX0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CzUoEPHl5ua1LWz2ro89BfFRvijx/ecG3A7DGjvGQXxb+fthZKVxZcB8lsJ6gXsfkGNXWKaZEpVeIDRquh3i2/ZUi3CzPKypqFri0IgL0aafvoec4TJJ4GzBGK9NYd87nWFzxu6t1CDjSZpwZD5eftEAnPbviSvl6T62nTHQ4pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQcOT9Yn; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQcOT9Yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780489391; x=1812025391;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=9R2r8SugmiPNf40duvozZrw9aLWSg8EV0sXCu07zUX0=;
  b=IQcOT9YnAAFsxxjk2k/k7SmucpvbO/gCT96bPqoJB57Iq2Ez1IBJLgCx
   ygWHt1C6YMwLabpUDrfVqvVa94OLOibHBZf6FGxlgVko5JM/Ocy+vRfFb
   xA7PCU314DrKhNIC//Pu3sy3dO1u+cD4XISOhUIeP3QnBP0vV/PwY13zf
   gnC6d5abXY0zM/ZmwqQ2gCWGCtZH9cgi6Bynd5Bnyn4hLOLfuTkSNCJKH
   kLeBE1HXz2GQEOBp9PKv3lciTRAKmdAESffYs7nGOu/KEt4UeuYyp/XfL
   HoJwM9Emnfup6DXgJNfoozfYeQzaxBuOg607ffU8PRS8v80aTp9G76rJ6
   Q==;
X-CSE-ConnectionGUID: afka84Z0R36KC5aAr2qzeQ==
X-CSE-MsgGUID: P0YyUerJT+2lstbuXV0/Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81478011"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81478011"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 05:23:07 -0700
X-CSE-ConnectionGUID: r4eD92U8QRqUeJ148fmfew==
X-CSE-MsgGUID: yHiwscyOToCaPEZESPeyNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="282333220"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 05:23:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 05:23:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 05:23:06 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 05:23:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/9Wa9pWCL+TdbtZ5sL9F6hCdhm8LcxMOeUBsvYGteIi7yNzM7nK+WqZWg5Ad8bzP7wjBhZojr54b1SQhBjsYVpLgHQIJHi/sIC1FKVV5ICW4puSGY9BKoT1imnLNYa50GcAY6d8JwCIXnduvdSZ/nXQ3yDdvCfdIkG9MfcLBsHnO/eTAieKfEvVbl/ME8xFOOm+78yVqZfkueYGFmgPjDrEquXD30Z5LwOAb7cdXUZhweDgQ/Fvgauz5N7qDDU2+dP7fRtTVSi29H+pFyzaOu6gHdjNl7stUXo34E89xQOtpI6EeGQh+i2nF6aHi1jFDWnb7mEOPo1CTnCzFdDdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty259ETjK0M1lYZ0z4+KemsApKECbLw096P1hStN0mw=;
 b=avMudgSOXDAb/WIJGeANibsyulPMNWlG6ltIuiKsxUMQaEkL/GGx9IUn7+ctqD/FgEtgua+MOP7G5967cnocwuaivb5tAxQhO0kUG9R6iFcqzgv8Ux2dL+it9/cPQtSfVaM5vtAupDqNtOLXgBw5amEjqade21gUwqeuVzMDoN/+1U4LP4Vzw+5G7E9pup3QaiyD/JNTOXlkFhxDyaK9OFlu3weDLWM3PArPIEVOhv1DIUD0BK20VT/h08c8UXb5RuGVJEwFsM3TmZ1IUcOB7jYrN2kFdceOGPAkCyJGxdaz83MgD7iQe197XmkcZegFRcHKCkds89FHBLT0bYf97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DS0PR11MB6421.namprd11.prod.outlook.com (2603:10b6:8:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 12:22:55 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0071.014; Wed, 3 Jun 2026
 12:22:55 +0000
Date: Wed, 3 Jun 2026 19:42:41 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vannapurve@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
Message-ID: <aiATMXdOtg1T8o4D@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com>
 <CAEvNRgH6YGzp4OHF7hMQEtVodAe1pVg1F9UZWwLiu19-KNgJVQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgH6YGzp4OHF7hMQEtVodAe1pVg1F9UZWwLiu19-KNgJVQ@mail.gmail.com>
X-ClientProxiedBy: SI3PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:4:297::6) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DS0PR11MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a26632-da3b-40e0-9d9e-08dec16ad6ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|4143699003|11063799006|6133799003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: +ga9t1xnP7p13R11HkvDpJWIBenpq4DPjzSx2o7gru+1JwNHOWyzWLajYgG33GIg8iYtHcpg9O/s9Y4C6mcRoT3IjfYwewwcmofycvnAk2rtGPlyz7m9BKv0MZ4qZEfBdiKlXN0S9lfPexBA12Sbckf7fXKonRHXc8NUEsWPZIrw2MwmBrsuJzBgFeTc98bCv2NC1czQsZFc8wlELs+Z781/t+syIlm+qqzBFudoJln97ovzv+187oRHiMJcvNnpOLqXCWd4kkHCNzHORXMqgAZw1DgIZXNXVcDzc8YmEz+UhNRtLYxzLHaxMCuk3785Qigz4uI8/AGAfMwl55SMT9SJTUImSa64AwHRaaOYpxxS838zeSi5fb9QNc+TXstq2pYlZD7h8qpCBRwMcJPDPmIGI/zPBtsMq+l1OU95Ul8EsrRSv4ltggr8aSz5kMCvQQ7K6KkQq/19jXFuUcohkO7bodr30764kp7UsOwOAPsYOXkmuuY7GA4sBuJsIy9fgemkwTgyi7/vmoX66wiv1qzzA5AktexbYN0ONE38bqT3N0QR8xAxqqvtBvoXT9xoffTttqRN5ZBTwr+1kpktAQNmwNtCk9aYmpRHypk8NQbdp50/d2R2q/rAkIaOdlbMk1JMw5J+jxl6svPnmxyPBwRUtEtyQCM9NojPSKZ6bhvl9eyAYpjqh1jyYODNIPl7gb8jdb+TfQ16aeZbK+c1yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jfyge18xJpXSmjiMMeXyJx5Jw6XptbtK54XiRuP23T+x/CBNz0jmSwjwCMtC?=
 =?us-ascii?Q?6S9PnduHQfPKhUqmjx50SOqT7G5TIJgPs01ogR/cBTgYmkxbpa/JSdz0CgT3?=
 =?us-ascii?Q?Obl1I0H39cRh4QNQRQUuf3xMhx0NJKnbWDlGID99ONXyzvL1gxJu7CZn8Cak?=
 =?us-ascii?Q?li8giF5BuiVzse0QDPAtoyfKj8HiG6I3BfR6g4X6QcaP5a1YIPMHXSVoruW2?=
 =?us-ascii?Q?yydxrrprhOi4xowLzH6lXIeyT/gDjSBsKKp0kaaKBZZ5XPMRQjVQNtlBX8b7?=
 =?us-ascii?Q?inz3V25dM1/1FOAV9jbmTRq8qQJoU7+n6zRs4pUil6ZpCCwGpIPOyTclAgLB?=
 =?us-ascii?Q?bUyyJzXywp//1LjrGaRO7e5UrnTuTUrSa031YBZgWi8kcgVyg9S8rbS9HjUs?=
 =?us-ascii?Q?LWp3Nf9ESo09zMteiG7HivIDVh7bNn3i6ombakQdO0/kw+X/Q2c/98B3OjI6?=
 =?us-ascii?Q?5Ws6yLlW4nEujrVlwWYPKuy2yglc9rkz4A5N4Q+uvrpUSnI3JbSn2X+UEK+/?=
 =?us-ascii?Q?4pa07BI9Iepcive0QYB8AIleQ0RcuX75FpJ1sFfSv1q+4Nn+mOVMof1lyoS7?=
 =?us-ascii?Q?XXv1bIf5qOVZJNv28A+qrUwRMUm0e3m1SkVKvg+EegGcavG/1/KeDlKcCngH?=
 =?us-ascii?Q?rbAk9XX1Y78ewbP70x3NQmREZjx7cemFLD44dL0cNDELIPE6Qqo0hFOghVpB?=
 =?us-ascii?Q?+Q0bwe4qwb0DSYYqVLo5hfpZ4hqcfWmz+aoGx10JHS0vzk9FLh8MUx12Hxs5?=
 =?us-ascii?Q?Cr67u2ZCUbsZelLqvgqaUu5wGCMce326iRduu0uM4ED3YJBnd9wMXuxrSiYE?=
 =?us-ascii?Q?fN3ENPvWLFzpUwns/ijOOO4XAcO5jZXcOafIadEI/RDqf7w4+T/AsaNM6uCQ?=
 =?us-ascii?Q?yRn2eqDposnUJchq7dgt8ktymutXGQCU8xldaL9ErxmmQzO7jnq9b0MDHCZw?=
 =?us-ascii?Q?QXm0sdF6aHJ708jETvfUtTqnEc4ETrbA76jtKfARp3JjM7vLEyU9rKyMk7nP?=
 =?us-ascii?Q?kpLYPMn6DNB9NDI2Z+YPq+ieoVZhzavYUCHLx2MXOYNp3lLuT1olODMHj2i9?=
 =?us-ascii?Q?Jb8TSS3PVSBAqUXW79koq66KcABSiNmA5h2vQo4eE4dsKJEHFSJSQk+f5zFM?=
 =?us-ascii?Q?dUDJnhKWpHXT02LAOKXjhMmZXoA7HamNYtI01BtCWR9fC7ydSUfJtUdfJlJF?=
 =?us-ascii?Q?dgoamwwVjvHk+7A6qqZ8bC3hmYVK0aMoIAH+RzweCR5FRnreFGhVaovqn1jv?=
 =?us-ascii?Q?UQchXRfUx6DGHQMKfpPLe6y9UnFMSGb4iIoltIvXZk95S+IBKCci9RqgABto?=
 =?us-ascii?Q?x7DcvzUTDTscLahx81JlmqbQJNF+Hrk19afZFYfMv0pzPZcerkyVR6R+kuGw?=
 =?us-ascii?Q?p7pk6vCq5gd8cXZtmmRxLJpmmNqQ0fB0dZuGa4dI36ExcPKCqYq5J9pmbr/Y?=
 =?us-ascii?Q?/8GNqUtZoTajUnKsuOdyyK6/lDFos/Ry5L5yR++H0evOYecaeHLdPgZd/Zu7?=
 =?us-ascii?Q?Hs1eotclFw6UrRvQXYwj22jaq9sET0AvEySEUAtWXdQWKpHnUPEj9YnjBxb4?=
 =?us-ascii?Q?hTjHD3nMwx5tgvxOveePeMaiCs7phqKrdk9eDHydhYCHQ6sWqtRQ5JG/Nnb3?=
 =?us-ascii?Q?rKonCGxDLwUcayROnsIYRxQoTO5oLSYeR66LBAy6XC0uSgdxwyQp9/EQPgeb?=
 =?us-ascii?Q?LxKcYW9I6Zo3+e/aF/RRwmQIVJWSSMCFs2cyDLEP7phaKCNZubcB0Dm1j+vV?=
 =?us-ascii?Q?tZTUV0mjIw=3D=3D?=
X-Exchange-RoutingPolicyChecked: CF+M7tsSwlIpkf6J5G3s/isjV4xeZ4ah2F9grxnNDYMw5RsfPQMB/nXMJq3mpleGeSoMC/j+DaqFw+/o6bgxqRrK6OTfKtpBKNbeYloqhW5/Ai33X8gDtgTRpwxCvdu82DklVOxBMQMrBKshisbw7Z0SmiZf4dy+UJAlfKZ2/jCnWbHcD207f7h+WtAS79Ewm83ZAeFplzHwG0yINfNLu3gV/vWGPDP+wXYsivfELYt/DOmKRp0xoec2YQjN5Rfw/9yaI37F/PpSNOl+uwDiTBiZMu8MRgp6cPySpwFRNVj9nV9rvnKtzg+2dE4zdTYyaQ4b6ZA7XblcOf99XE4Qmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a26632-da3b-40e0-9d9e-08dec16ad6ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 12:22:55.1328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3K6qMaABmAcFEM6vFOjpNF7WElPtP0C74gmbfjjpWDIaq/kqmOqZv2TWjCzGLNXOVxFWBfW4K2wrj2wd2OgqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com

On Tue, Jun 02, 2026 at 05:40:00PM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> Coming here from https://lore.kernel.org/all/ahn6qysOGfa74A2E@google.com/.
> 
> > On Thu, Nov 13, 2025 at 03:22:29PM -0800, Sean Christopherson wrote:
> >> Add more context and information to the comment in kvm_gmem_release() that
> >> explains why there's no synchronization on RCU _or_ kvm->srcu.  Point (b)
> >> from commit 67b43038ce14 ("KVM: guest_memfd: Remove RCU-protected attribute
> >> from slot->gmem.file")
> >>
> >>       b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
> >>          occur after the memslot is no longer visible to kvm_gmem_get_pfn().
> >>
> >> is especially difficult to fully grok, particularly in light of commit
> >> ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when
> >> gmem is dying"), which addressed a race between unbind() and release().
> > As mentioned in commit ae431059e75d ("KVM: guest_memfd: Remove bindings on
> > memslot deletion when gmem is dying"), unbind() and release() are mutually
> > exclusive, i.e., both protected by slots_lock, mentioning "race" here is
> > confusing. So, that commit addressed the mishandling in unbind() after
> > kvm_gmem_get_file() returning NULL?
> >
> 
> I agree that the use of the word "race" here is odd since both unbind
> and release() are mutually exclusive and protected by slots_lock.
> 
> Looking at ae431059e75d again, there are really 3 changes:
> 
> 1. Refactoring out __kvm_gmem_unbind(), which is mostly about setting
>    bindings in the xarray to NULL and setting slot->gmem.file to NULL,
> 2. Checking that if slot->gmem.file is NULL, skip unbinding
> 3. Checking that if kvm_gmem_get_file() returns NULL, just unbind
>    without taking filemap_invalidate_lock().
> 
> (2.) is explained in the comment
> 
> 	/*
> 	 * Nothing to do if the underlying file was _already_ closed, as
> 	 * kvm_gmem_release() invalidates and nullifies all bindings.
> 	 */
> 
> The real fix is in (3.), I think? Could you explain how
> kvm_gmem_get_file() works? Why would the file be dying with the
> slots_lock making the unbind and release mutually exclusive?
Below is my understanding:

kvm_gmem_unbind() is invoked under slots_lock.
kvm_gmem_release() holds slots_lock before it accesses any slot and sets
slot->gmem.file to NULL.

When kvm_gmem_get_file() returns NULL, it could be
1) kvm_gmem_release() is to be invoked soon.
2) kvm_gmem_release() is being invoked, before holding slots_lock.
3) kvm_gmem_release() is being invoked, holding slots_lock.
4) kvm_gmem_release() is being invoked, after releasing slots_lock.
5) kvm_gmem_release() has been invoked and completed.

So, when kvm_gmem_unbind() finds slot->gmem.file != NULL while
kvm_gmem_get_file() returns NULL, it could only be 1) or 2). And at that point,
the remaining user of the slot->gmem.file should only be kvm_gmem_release().

For both 1) and 2), kvm_gmem_unbind() and kvm_gmem_release() can't operate on
f->bindings simultaneously. kvm_gmem_unbind() needs to remove the slot from
slot->gmem.file's binding. Otherwise, after kvm_gmem_unbind() returns, the slot
will be deleted and kvm_gmem_release() will later hold slots_lock and cause
use-after-free.

