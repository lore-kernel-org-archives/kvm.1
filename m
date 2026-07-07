Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60E37996B;
	Tue,  7 Jul 2026 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400518; cv=fail; b=mtpmGyvrOm3cSTHque5H/FrI7gOa1I3bWJUubp+diu8uvRxSNYTu76mXGFtGKVrCRfzOx4EnZ1AQ1Bpn6pXvY3WEqlabdMAXBrCa307O6BWLVyiMfpisv8VjLx9qCUunasxypqL6MPI8MNHnCzoE17zT/0dRngpVBPtfWlsD4HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400518; c=relaxed/simple;
	bh=uac4YvcRXik1HAhmssZV8EXK2VVWpv5wqi0BKhn/1/k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g+Jq9RrBdAUtNUqMMSYR+u20gm7oZh113C62OPLnDzbF9l2TyJx9L1xCjY5KbJS0UY1zy9QIkZHjLoKW3epJqegs72K341tVtopj1ortP8PoXSGpiLcglXSpx7cPVYl7qvqb3IodjeSv0DGJpmI0zXiczz5Rx5EjnUvAzmheW2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLgVYSY0; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLgVYSY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783400515; x=1814936515;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uac4YvcRXik1HAhmssZV8EXK2VVWpv5wqi0BKhn/1/k=;
  b=aLgVYSY0Rb5pW2eR9GYxvffv3fo7w1hWsfTrMzNa9ClO3tgi6u8q2avA
   fT0qBmk2FdtfZWppMStGz4gIVwyp2r3wAqM3klThDSaxwEBoH89csUNAW
   uCHsfu7tuKrA9CU8vaERZeeh+Y7KpFXiRKGTzc60nyOkkskDmXYCe+YRz
   sUZEt4PMyeFqUAs6eAUfhClSeCwHNFETK5EGVFTNz3TPsGW6V0NVdmGKS
   O+ZItzhhnEqoAMZjUtiSB9gOlEkFlacTwggf0UP1iybo4Mlf0j9MQDPKv
   R6AckjMvUNEh8uNTNmfiaIuxFibkA9EU90IBlnmLfu13WxUpI7OzOay6X
   A==;
X-CSE-ConnectionGUID: HMbDpreaSc6osHrL0F6g1A==
X-CSE-MsgGUID: l8CaVbsQTFOnZJtVDCbYvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83148315"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83148315"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 22:01:54 -0700
X-CSE-ConnectionGUID: vCkM8u4QS5GEhIiS/icAFA==
X-CSE-MsgGUID: XbbC9MuIRw6Nm9hHI1/0Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="292065718"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 22:01:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 22:01:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 22:01:53 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 22:01:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMjJVMsQ23uy5FV9H9xNRRjdbpJE0r19eZ4+10QdIMbQPiX3Hft31HU25O822lJnzjiG9WVHgLOAWXC5mOyNMm64XYXLh3iswI0a1cm+bhekxc/eiIzLrW4Tx29lAv4dTLgghKUhsdLg4khw0rjt+1SPPsogsKQg4NU5jN0mVgUABsj6q2jOh/grR3isBd3jh4Pn5kfN+CYe40NyKpDRhsbCh9ViqtSSl4Zi8sWMU6V16ZQbmPFdHxKKAFZa+fJYwrn4SnBPJ+6ltY5XkmF/wt30EtFmcthp1MjX7Tvd5/l000ZVDo8FPU4BQ7qv3SwQ7Us9OwmRXLnYzQkmDzrNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nKEi1RDw8aCbeiJIS2p1Ip7XFZImu7/dUQMRa4Xu9c=;
 b=YHg1e2YuuOfrkeqGrSaYDrfAHYbit4+U4c+Nu88F5Z2UR1k8YIVO7oIAQEuSxsSZUqi1XMhPl/eKOT2lL/0Qr893YQ3hoC4jOkRixRPC3ewhWG4IwrMO5DZFjJ77n5p5kTXSQpSn3+DvyyQ4HWdPlvYquLa4lZw7FvPbBTun42K5eL8XgzmKSbUZuXQDPsz4N/o2yYGbmh5vfPCSAZ9WP4kn6/zzUQYJtGwZcmq8yJCRk1wA8dmilzW4c78/VbIB6iOfqglI7zknzBCvly1rpxufHi8RbA6HHXuhd+Po96KaUAmcs7cF4K+VjY/tqJ2QkGROpj6SHUOPDe+4xbsphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 05:01:50 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 05:01:50 +0000
Date: Mon, 6 Jul 2026 22:01:46 -0700
From: Peter Fang <peter.fang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 11/15] KVM: TDX: Factor out userspace return path
 from tdx_get_quote()
Message-ID: <20260707050146.GE2169894@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-12-yilun.xu@linux.intel.com>
 <480873c9-c25b-4666-9abf-2e5b6894eef5@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <480873c9-c25b-4666-9abf-2e5b6894eef5@suse.com>
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CH0PR11MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9307d5-fd41-4a8f-ada4-08dedbe4d967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: keKkfujhH/H5yM3993TZqjm186ndIjkRDdnxA984eupIAhWtthva3/UgA+NrtWhLlyVLlMenGzHdU9BlR/5qATQ0bKDJTRKup5LZ7lA86+Aka5TBzDRyoQFX117/5BihGtmVLjQWUo9WC8vQ9dfohNmFe37SlcRjy6TLS4EAFP8qakbMCAAUxv0Ji6mjt59sgvBCMItf7D3GH5QX1tY8cyD80v2mCLI5AKzSFf2egF37lwM0JwARPZSogMfJSAvxGL30DWHYazp1InmDtpc7y5PQQ/BcvskjWfQge3e3l10qJVLH+dvrsYvtrv+K592IS+dglZFqvpyxOFHXsBGAWXNFJA65Qcc67Uho5ldKnYuOJMorUXywh4fJoe2Imh4JgR4tj2p6bph3hiiFoXa/S6qp3CJtR0Z8+lB+1RvclDj+kucEnXG2iXJP5HB1Nw0RJtipIcbe7oaRsS0jyOChyMiciOgqsJ7rII5tb/6h3AmMnR0Y7XS+gHDkzY0Ms4ft3vlmHSDG5SMhGJzXgo5jZi0ryG5GswZwzCNg81NQyTY7TWpCBIf/MBiDQBQw0Q7GzUDZp1+vpWdRwFtqm2Y9SQsWpsft7cuRt9We3K+2+yYqzqA0eS0X41KzFRPo7HE+FV24oLwXVLErqXjUu/+8Oqf/2Qc75W9qq5+ZuG6D5EE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zfwU+SuvZdZiYf7i8AMhO1T9+xkqjnAxYXVA37Dg2PbjYqCpdT4HW/88FbxB?=
 =?us-ascii?Q?FQGrC7dxegheCOQ176FH9ofOijHseReuo+apVoQ9uOJXFrhWrVABEXiUDFrr?=
 =?us-ascii?Q?Sl3SHqwF9RaHGlFtqSOO+J30hoRR3Ald2aMiR/cHrG2epL7JG0HZ+CnLHE9A?=
 =?us-ascii?Q?r4uZfQiHojFtHzSUeaaUe2YQKxkJwtyjqtIon/4LyXr9coEZU9qX01JPVayh?=
 =?us-ascii?Q?VsZ3jo4ctscPvYsUNeB0vBpErHoEOE68gdNkCHTDov8+1W/13n1kShyZeolI?=
 =?us-ascii?Q?U+U2OBXM+7/fmeKQpk+l5za81du68bnVbN27KM+sUk96EZFLRrocB4Im966z?=
 =?us-ascii?Q?8NTZIZmGMVrhbfzqZ1azi9K5nR56VE85qXIJM+ELmzMo5jyeNxUEB11a0PKT?=
 =?us-ascii?Q?YUOx1GHB6IWfnU3QpX987mcmeOlft+rXbr+JJ5TUpOm/k6oxTM9vjP9JbrBG?=
 =?us-ascii?Q?KRSbVc99w6B92UyuHEcs5xNAvxUieGsRe5gb82kKK3BMe3dHSTOH5fM1eP0H?=
 =?us-ascii?Q?Hs0yaGEVhwGq5PsgznF/qwBiE4i+e3JdzqJ/JLLGPZ63goEaFg03E+7qRVqY?=
 =?us-ascii?Q?j1XU26NgjFSj70RfrtMsb2CGwhkmMiWjLYC2LNGCHcD07dWY4YsONVzVQfxI?=
 =?us-ascii?Q?2W/LpcroQshudILclHMagAdXT5Wk/Kn3kZrofGkGfnM2WTLUUxRepoYbxACh?=
 =?us-ascii?Q?bB+vYrSpobBgDrnRL4wo9jud6gn7nBWARD+Is6KG7AXoABKLAyQNOCyiMliP?=
 =?us-ascii?Q?+1PkbTqGdhU8C+B5qEwcj065E7VklICt3SpfZzmvU4zOh7ytN9mvel+cv1ZW?=
 =?us-ascii?Q?rV+cZ9U0j3vXW6wkIum9bngliOSByEKwC3ym9x3iyYw6sP4HU4w614Mp5QKq?=
 =?us-ascii?Q?jb0WQ10IQ2IMqFei6KoWZ9mHEP6MMxofYFoe0j0Ud6XN6NX4ljKEQTFBAnef?=
 =?us-ascii?Q?94MrVZeoET5Cq86WIWHZGyN+xYWYbKdCZVYgGQrVHDaHyZCbrpIpmyxKFX4q?=
 =?us-ascii?Q?3fNER2WHrFiYluWozbX660xC9Uz64cQgSnDwA1IaWJl9eWulnkQ+DqzDXE/G?=
 =?us-ascii?Q?BFpPAS4KNgiZLFKWNMXn7LsIOYhO2qvt/XL3zCamDwP1tY2rXmGOp0G5Kv9z?=
 =?us-ascii?Q?nq9cqtih6b2XZHtE/OzishPwffSar98wojbLdzOe9pcxP6Lg5/6DTF2U7LOG?=
 =?us-ascii?Q?tEqQUsscA2dDf9HYVjLpsUus5EqXuO8SX+Yrz6Xz6P16kAAN+cWWqr/oaPm/?=
 =?us-ascii?Q?q12X+fUtPbeWLDRdCbFax71lFQfgBDv8FlcQEd1wZt3olHro+9joqxSDKOZJ?=
 =?us-ascii?Q?fAmrRR+E79+yr6k31hQoMxLWGLhKGqk1cPUZ+3smX+smxOzxIcOWVlPBX9EW?=
 =?us-ascii?Q?b9X9aFZEEQx5tugu14/ef31QZaYKlaQwVOEttHj+dvbyTPfy67j1p71YTNRa?=
 =?us-ascii?Q?Q80YrGNGi7jawfOvly2ck6I/0RDRdTmAVDeW+1tdFIGTwF4qtDhZ/6MEkhf8?=
 =?us-ascii?Q?akL1XY6+8IiLhFx0GYLyauahhVxL3ydZwwqFwd0AiXRPt2fy4pqytWxGhmkZ?=
 =?us-ascii?Q?s/GXrvltWgW1mxYhvn8KMlQnXXR38aQwJJnFwbgRYoDJh+aq598S8TlkRfa3?=
 =?us-ascii?Q?8qd8nMHc7bEFha12K6elnXZPqJ1QOq6X2z1dRvKlKK4VGqnJm/yrVhQ+QBMl?=
 =?us-ascii?Q?FzPuLSs1SFla6ugAGR481rScEy751pmEtyGDZHdgQXSBNIyuMzkDEDwnbZze?=
 =?us-ascii?Q?7TcWB0jleg=3D=3D?=
X-Exchange-RoutingPolicyChecked: iRBK2NTfBN0z4QqCAvZm3kJm6nKjJX/0DwuNOtBVz14H4lp2+rnu8u0J/M6/wae0BeZtfYvIex+rlxG+UsChBh+gzvATpcX1eIKxRaP+brZ1wimI7O+mh4kgZOe9gRdFsGFgUrMBImiGHu9F4lPbQ3xcYKvKdfe66vvZ5fiSfFvOqL/GiPc+0MUNIowTMDwwQxwVd/rfsNcbeur+NrYv0Ccm7RJR0eDeVwUUzljRnOzVP7ghsOseqyYDes4whI7ZWrTgpxLWilGcFYZAR/EkwUxHXwnOMy3fNTcV+USXulGnXewmqWy7g5Q3uw7ukkavhrKsvtClVpWu9bGJu3rpvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9307d5-fd41-4a8f-ada4-08dedbe4d967
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:01:49.9776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qwo9Nhd0y3gocue3uKIq2YE2xqvCFzLj/i7SnEh+5EPCJSwj7FPfBc8rP3LDLFP0y2D3tZH4JhAf9l+hPF2L7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com

On Thu, Jul 02, 2026 at 01:08:57PM +0300, Nikolay Borisov wrote:
> 
> 
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index ed12805bbb44..9f7c39e0d4b5 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -1524,6 +1524,20 @@ static int tdx_complete_simple(struct kvm_vcpu *vcpu)
> >   	return 1;
> >   }
> > +static int tdx_get_quote_user(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
> > +{
> nit: Function name is misleading, imo appropriate name should have
> "fill"/"init" in the name as what it does is to fill the run->tdx structure.
> 
> 
> tdx_fill_quote_user/tdx_init_quote_user
> 

Oh I see that now. Patch 12 adds this pattern to tdx_get_quote():

        if (kvm_tdx->get_quote_in_kernel)
                ret = tdx_get_quote_kernel(vcpu, gpa, size);
        else
                ret = tdx_get_quote_user(vcpu, gpa, size);


The intent was to create some symmetry between the two functions. The
kernel path generates the quote in the kernel without needing to touch
run->tdx, so the two functions are slightly different and perhaps
symmetry doesn't make sense.

How about tdx_prepare_quote_user()? That seems to pair well with
tdx_get_quote_kernel()?

> 
> 
> <snip>
> 
