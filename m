Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07D395273;
	Tue, 22 Sep 2026 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048798; cv=fail; b=LmdBG5IGMDBQV448yWPMBIEwKjyuBGgBrr9/ZU0Tg50wm/v5d3L+K549SGwnW9rt9pFzGctg9K1jzqTEpmI/zxP5dQDYUBvMxZsakzXvCSSGCA9DAzX0+TaIMnDwpVo/GJosOI68z+f8EKtPNEN95j0LIY9Ihok/x23wIXoaDiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048798; c=relaxed/simple;
	bh=c5EcD79fmobbmlqt3X01OANN9pDaMZU6nWGtaz0WxQk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ruiNQfblaiJYdPrhSgEne0fHdb6HHU4adcUXK9Yepft8gP8uMyuAPPorr2vdd6eRvqNFetc5uIrjZ1ybnsYKvJfCsIfGJm0HD6YY4TpnZrFGhry8u28ODt1jyYDyury2uBbeWd70nfnGwtU/EejGByoeiwYSVUDj2t+naVgeogw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWTv0PNx; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWTv0PNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790048795; x=1821584795;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=c5EcD79fmobbmlqt3X01OANN9pDaMZU6nWGtaz0WxQk=;
  b=UWTv0PNxqFcuBRb3mR+GPH/0Us5Kw6gxUJCdMB8TzeUZaDgqAksBiXmg
   Une+hUgQa3SnF+WjckU33qrT8FGPmJgbAA6vLQqcEQtOMN2M8l6fOAYYY
   /VJlYcnZ+trc2jaRF/tybmsEAhK3R/5P0BzKv7p6Wk2S3OnL2S42mnXyr
   g/0ItG1TF6wbnmY2RvKTq/rrB6+uOgtdJV3wA7MGVeKkr3jFHcnsbyikz
   jIDq2HS39P2tXxxX1mSCWmoUB1WMARohpiua0wd+7BLBcgl8pybzRJV+W
   Nf1leFwefUU2NeoPFcLcN44mx8ytq4IblIkGtNMxWxyM3MtO6mXsF9nKM
   Q==;
X-CSE-ConnectionGUID: IKOHk5iUTAeQziBjRyIcEA==
X-CSE-MsgGUID: k644tbTnSImAJCtD7BFsPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90481996"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90481996"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 20:46:34 -0700
X-CSE-ConnectionGUID: 80IQ6xjOQaaf1DhG7J3KmQ==
X-CSE-MsgGUID: nCfshoUQQ3OgrUMnF/+jGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="4042913"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 20:46:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 20:46:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 20:46:34 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 20:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ctsfo0x3pFSfU4rDtZymMYlQYOiQ/5IEhfcDiOtbL37E0RqJp1DQK1dtQKLYXRUo1pqDkkBrO5zcJHqTtwjLLbdtzQHu6eQ2aYCAVNQoi2ie2eGB6w+WH7N8wkh+YXhrJtBoF0la+I0aISv3aah40PBxDqZOsLRjo5Fxauu57Id2Ney0w8scj4+es5NTwRF57OdJ7Ei37zc+D/grIo3nvNXrguU84HL/bjmsCq+lx7RPLnz6VMYTLFf0My7/BXregfEL5HMQNZnkQX4U+Cp/njI9be4GKkS7v6qdKEFfnvj7+4IRknyOcSB+1A0MIgkdnHxk8iWzj39uOeYeYpq+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U6DplNNDbQ07b0vlyEMo+n9VfAONWJCauEcl+SHrbA=;
 b=CWD227lPCsG/IO8+HEC+94K0ul24CjKEYNlkgEF7I4kiu1lRGrs25qfbemT7VHtqKVPD13NeTYGL7q6krr5iDqqH6t1lCBi8VjNmD9AL84pwqA4xIkUEH2CSkN0njzcQiq82UUqO+z2ig/d/ROzOb4aSazrWChr6rBNm3gPVYWxEq4mxoRJNhPnRGM3gH+0Kc4lCy4dljf1kl9zMPjqifVQnT3r5WFkyGBdJ9vFduVlTG/efJPet03F0SP0l63Dr9GWB9ch8WB7oJXaPtGYrPGyy8pAYR0ucUxz/G+mQyr2P1522KxcFdl5uWh1NwFNebh7KkoVZf8wynzEE61E3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by DS7PR11MB8782.namprd11.prod.outlook.com (2603:10b6:8:253::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 03:46:29 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 03:46:28 +0000
Date: Tue, 22 Sep 2026 11:45:55 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Annapurve
	<vannapurve@google.com>
Subject: Re: [PATCH v2] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
Message-ID: <arH581gvxmSMPSKA@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260826165647.769231-1-seanjc@google.com>
 <aq/XwK71uNfLvUux@yzhao56-desk.sh.intel.com>
 <arEzv8b2IMHYcHsZ@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arEzv8b2IMHYcHsZ@google.com>
X-ClientProxiedBy: TP0P295CA0007.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::7)
 To DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|DS7PR11MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: ab07fef4-32d1-4929-3c8a-08df185c1569
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: VJaC+/ObkRWuMMYKXHv6qs9P0TJINyGawGCmcURhpF/omz2KLfnEsrtSPasuJVWn1/wC6W7YZmmlpJSnHeTThp4sVjf5lRdTymapsTDNcmALCcgwCngtmrUQRhqKWLb9eAJfhbxmAhaFSl1Zh209xIBpM330W0kiFK5icR10NiJAdnPIk5LaF3Vd7aXlRBYirdGhX3TCk7/Ryc5p+kEX6HZN3aCq6ZpBAlS9RlGoIpPnMGfCUKx8aS89bHI8m+MTn4WD5LReQly3s/AY/nD81a5NRzPYpCFHMq7cl/UOwdmItv05RuAya43V3mU0WTt5F3wGLrd4gZ7PA2+FyS2nRymt/fe3JcSyMeBUIM4u/QBz1IvVXoji83OKlBnMEFy0e3t8IvCNqHNHICObQQSWmjwGGo+KPlCB7fUS+oeDnX+KWRPQJPScbix/zS0078sRz5Gl8IEPCya0HBsPflbyTPlObJ8gTJaj0W1uRIlQO5xQDAKv5m+0wJvR/XK41RtnYj+kSxutxwqsr4qqnwzqlnz4d8wLVeXTuPhWclJHLSxLZq8Wt7svquND/EhS4/BhvvHlnE32C0FijhcTGgbJ21JJkycWhfEU5z7AOciX0d0ZGGpSW3eKk9+T9yy0XrVFhn7gVbylgE5hYX9TWbKTPA+W02OOCyFyXhS2vOIYduE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JL2/epHUIe0mvCTFypTpq+4XKW3AIMR/WLYUrSaSlWTWUuogEXRxhRRqbuYl?=
 =?us-ascii?Q?+PbjoKWD7WDvlJXtNa9cjZRBzns2ddrGw92FzA1gUSZPuMlyLYoZgSn0bK00?=
 =?us-ascii?Q?/idH9JHMAgunj2lS10p4JHahifYip/UoNgjp1l0ZWh8r+qqPQnOHJPn+JsR9?=
 =?us-ascii?Q?ni1BVbCevEycyF3iTDxXwgmc6vXecLMSNgrjEtX/Uek6wTKHXYzP1ngLURvN?=
 =?us-ascii?Q?vCt4AxBN6aZVtqx6g/oG8qf7ccmnErESwHeemgLmSMhxOWGEXaB5Wpf/79JW?=
 =?us-ascii?Q?1veCVPYHaO2m9ipWt3teMisTF5LQO1xTH65yATWATBcVDxmMx1JmunQ0clt5?=
 =?us-ascii?Q?g/AyvC0jMHRgklwN3sDvq80iZCCB9qUkdCQTZ3cmqRg1Kipf6kODN5mrTjMS?=
 =?us-ascii?Q?nueDNLKYbevlU1wSfJCBDDwIkXhwuuV/ahw48UZE44GIlT42l2e51/NH3Q+F?=
 =?us-ascii?Q?zdXwT1gEKYaG3U2kiu+t7Qb+PHZkRCKHLcBGzHMU7xpu037nCycpPL07RIXy?=
 =?us-ascii?Q?5IFS81R8NNiu4K5nJ575xZ5ydoz59c5ikWVIZU7Rq050In+m8cEr71xBeUT5?=
 =?us-ascii?Q?DKLwGj1ceGyJj9rqAH7EHKps48BPr0aeavNZZhDgg7pAXUlUVZlh85pXUGQ2?=
 =?us-ascii?Q?JxvGwJnBIrZDjfX4rfXjL5PekJbS2QoBnAm91lChDDAu8rZyEHPwDqGmEmTk?=
 =?us-ascii?Q?Eqe4Qped2C38Z64p9am8gC8VmIpbakca09IABpLrUg/QbO/ZR1XwN5001SdR?=
 =?us-ascii?Q?umapz5Qwyv/xDwoiMuj4peZ/3XL1A/oueCMQaj3jxlNQ0dwUEzykz874Bwg/?=
 =?us-ascii?Q?ujiVYa+f5ZLJ8sTqQdsdqLDtWa0HGjCT6RPNFNUn3PHvaYwSqFh2ZM2DdJx+?=
 =?us-ascii?Q?1q5+heP/zDxIOQhUXqOTvIllvcPAEclzUFFWUHX19qmYFHg+lS/1VRxLGdKy?=
 =?us-ascii?Q?x2/uWVwuFbJOKJ6hVZS1XmIWar6MbykPQ7fKInekeKpVVswiagA6noNDpcGZ?=
 =?us-ascii?Q?KdP+sP9sztccK7ghHRm47HPIzXAX2MmwDneOE+c8LZFd7a4bPxW2EahGRrI1?=
 =?us-ascii?Q?G+8L9zk+gfWwpA5dC6tzFDyUl+bN8Cwywca+rV1pREOHkkkZ4FEh2FxJgy+K?=
 =?us-ascii?Q?MoLFYwNsC/zSHYmIuKijTH3jLJRI4OMi6s1U1SYCz1URs3OFSq6StvninyKe?=
 =?us-ascii?Q?CdjkdOMYGWzyOxkcYz5EBK5BqtTSMw7m5Gv6ETebv0ig8Gd6I24vfjIeJwmV?=
 =?us-ascii?Q?2CW8I+BioFj6FdDHU9Nc8ATtnZDwi+fM2LpiZtfo04J7Hg4XXu50VQdHuww/?=
 =?us-ascii?Q?/DfO7jetNxPhxj03QJCXG9AJbu2d108LGi9OSD+meEqMDNZXSgu49qnlqcbO?=
 =?us-ascii?Q?Xmn+VL7G6KvwvyIZsJLQa9kGMhFmq271cocbodHfY3mGFUbCvrfB67ohTS9B?=
 =?us-ascii?Q?uHru2kluzpyWCKozELS7x4Kp6XjeF5Cspyl9KDPVRndOeGzgosqHbT0bcfwF?=
 =?us-ascii?Q?wZq25SHIrmUg1SHnJMmiHSq2gcvITX44fWPhYflcpVfQCk8Ze8JKR/Gu4Yvx?=
 =?us-ascii?Q?8AVh8HbChx5yStCXIcgdaNqs47wa9TKqiBESkPPwt2lzoZPC9QvCTfeX03ZJ?=
 =?us-ascii?Q?TQlPJ9Nl/ffDc+EWjBUnRXXbDD31/3T8PnHCzPxG/bH69V+biLDuPXr86P16?=
 =?us-ascii?Q?R5UrupeHnrj+V1dJj0kbnenWA4zjSeDB0qCISu3R7B0oco4UWeMTPFn14J49?=
 =?us-ascii?Q?SFu6JYH5nA=3D=3D?=
X-Exchange-RoutingPolicyChecked: LYWCLh9bBiQpWNzi2fE1qYpCR4drB+mxDx+4YsDH51jdXIXQ4Zc8E5H+WjC3DDCIuWyndZhCBEh8w952wkYTmI8Y4W0DfqRjU8v7O+LQonmgXw0P6OZ7fjJayI0xbHMIXqbVTI79TyLrlzwoTcrSmIlYsovnrZLemZ8p/1NkzQXMsPIwYOogZhjqyZZZDszGCrUw4m6TqUQ5X4rxFdLJLbuMC/2XW3S21WLqDgoRmCpXKVsfKdCkaSt0tm1b+GFONTpixq6S/sK2MlfuE6X82OeCVFnqqncSamlncIKkCrUK4SVxwfAX52lWaQSNE8ay0gMg/X4I4x8fvwEN3JoQdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab07fef4-32d1-4929-3c8a-08df185c1569
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:46:28.7201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5pNX14hoZ2HvyAZqGl6u5wrQK12r7y29op0qbiHSLTzsd0CqZ7fxoSuB/X1aa3qJLy1S8KkKQp1ZLaIKPCxYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8782
X-OriginatorOrg: intel.com

On Mon, Sep 21, 2026 at 06:40:15AM -0700, Sean Christopherson wrote:
> > > +	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
> > > +	 * bindings as slot->gmem.file cannot be set back to a non-null value
> > > +	 * without the memslot first being deleted.  I.e. this relies on the
> > > +	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() to ensure
> > > +	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
> > > +	 * grab a reference to slot->gmem.file even if the struct file object
> > > +	 * is reallocated.
Does "reallocated" here refer to the case (*) below?

> > > +	 * file_ref_put() provides a full barrier, and __get_file_rcu() the
> > > +	 * matching acquire barrier, to ensure that kvm_gmem_get_file() (via
> > > +	 * __get_file_rcu()) sees refcount==0 or fails the "file reloaded"
> > > +	 * check (file != NULL due to nullifying the file pointer here).
> > > +	 *
> > > +	 * Unlike most other users of get_file_rcu(), where callers don't care
> > > +	 * if they race with a write, only that they have a reference to _a_
> > > +	 * live file, kvm_gmem_get_pfn() needs to get the exact file that is
> > > +	 * associated with the memslot.  Without the aforementioned SRCU
> > > +	 * synchronization, the following could happen:
> > > +	 *
> > > +	 *  CPU0				CPU1
> > > +	 *  kvm_gmem_get_pfn()
> > > +	 *    f = X (from slot->gmem.file)
> > > +	 *					kvm_gmem_release())
> > > +	 *					  slot->gmem.file = NULL
> > > +	 *
> > > +	 *					kvm_set_memory_region()
> > > +	 *					  slot deleted
> > > +	 *
> > > +	 *					kvm_set_memory_region()
> > > +	 *					  slot created
> > > +	 *					  slot->gmem.file = f (alloc the same object)
Case (*):

I thought "reallocated" refers to this case, which get_file_active() cannot
guarantee against.

> > > +	 *
> > > +	 *  get_file_active()
> > > +	 *    file = f
> > > +	 *    file_reloaded = f
> > > +	 *
> > > +	 * <KVM does weird things with an old memslot+file>
> > > +	 *
> > > +	 * Obviously KVM would be broken in many places if the synchronization
> > > +	 * were omitted, but it's important to note that get_file_active() does
> > > +	 * NOT guarantee a reference to the correct file was obtained, only
> > > +	 * that the file doesn't point at a reallocated object.
> > reallocated -> reloaded?
> 
> No, "reallocated" is correct.  From the comment for SLAB_TYPESAFE_BY_RCU:
> 
>   * This delays freeing the SLAB page by a grace period, it does _NOT_
>   * delay object freeing. This means that if you do kmem_cache_free()
>   * that memory location is free to be reused at any time. Thus it may
>   * be possible to see another object there in the same RCU grace period.
>   *
>   * This feature only ensures the memory location backing the object
>   * stays valid, the trick to using this is relying on an independent
>   * object validation pass. Something like:
>   *
>   * ::
>   *
>   *  begin:
>   *   rcu_read_lock();
>   *   obj = lockless_lookup(key);
>   *   if (obj) {
>   *     if (!try_get_ref(obj)) // might fail for free objects
>   *       rcu_read_unlock();
>   *       goto begin;
>   *
>   *     if (obj->key != key) { // not the object we expected
>   *       put_ref(obj);
>   *       rcu_read_unlock();
>   *       goto begin;
>   *     }
>   *   }
>   *  rcu_read_unlock();
> 
> The above pseudocode is what get_file_active() is doing; it verifies the found
> file ("obj" above) is the correct file.  Specifically, from __get_file_rcu():
> 
> 	 * If the pointers don't match the file has been reallocated by
> 	 * SLAB_TYPESAFE_BY_RCU.
Yeah, I understand this is what you mean by "reallocated" :)
However, I think case (*) above could also be considered a form of "reallocated".
Would it make sense to rename "reallocated" to "reassigned" in case (*)?
