Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9238C2A5;
	Wed, 22 Jul 2026 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784686754; cv=fail; b=szZ4oOrmFIoK9sKCqdJkyw+ZgsghDLFUahBgUuh8UV7wixrfnf5EDJV1wCHA9hMUNrdRbdbMFBhOrwxAB8+7Mx26GPiBEGm77swHZtA87n2h6TgCnT+o78S/jc+1L6tSpx/2daccFxlqT8mqfHvPa2HCNWLVoDEx+It4QXTNGcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784686754; c=relaxed/simple;
	bh=NY/CITKxcVn3C9jDPxAW1JjQlDzhgUoDf50exK8646s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GmqKRb83GtcI6v6fQM9F9gIfc/G0GqgesVJP2UMQp9MODNPwMH1Qw9I4DiWWfuly3hcAUGCRty2mdOTnPhbf6UwSv3Ca2QcWSOsPU2nSfHCLuOUB5uKi4YyTb34MxYzd/ODU+6hGwQ1nAP3Brs5amFpDQTVNxYXecg2hkQPNyi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObF2toJ3; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObF2toJ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784686751; x=1816222751;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=NY/CITKxcVn3C9jDPxAW1JjQlDzhgUoDf50exK8646s=;
  b=ObF2toJ3Bcp6WX7j2P1FdXKnm/zd8LPaEifLu4g5RQx7S8V3XZi3LRhI
   4sKVL8yElGjmxEivII0ROgzWCup9PZa5Br/CccOaTfn4gPRjVe1xiEJc8
   Elvk4hw3QIBwGky5nIlP1Aeodp5/M8gnGmWHXh5qLbX5Pym4TSZsomFtt
   AsU8Aa4BSG2n+wBYKkfATDUl9Vxz5QELw3zuc5kTaib7Wj7t5DB8v8ywb
   ubUYckLGrXUWzJS6recpxtDKYlrw7XSvBUX2W3KDzc6LVnts/nHB0phI9
   HdCJl6UEwcepRqsav+XOufPZCdltHfumRowWzHUbk6Omk6xNWxS8ofwrN
   g==;
X-CSE-ConnectionGUID: YfTjlOG+RFCDy0/PXzpZvQ==
X-CSE-MsgGUID: u9KDlkKVQA6pW5EHd8dbHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="72847625"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="72847625"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 19:19:10 -0700
X-CSE-ConnectionGUID: f670skVpSRCmxZWS7XPkrw==
X-CSE-MsgGUID: da5Lm4poTqWX2YzdVxzLmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="258015562"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 19:19:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 19:19:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 19:19:09 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 19:19:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWc46XE+TELYYcCxK2QbKDIUb+J2ty2sTYsoEHRTvRoiR/9N1T7X6DIVWsdiW2BxOXSypCo2Oye1YNTHbwU7j1TGYHrH8TIkJRRwOdxUbTZMDhrrNVoF2QcgHhUuD1pGQFZ/mlpxR4YIXjliuftyZUjtZ2stJBZxrXQZhk4FikkFVQLfZSalTinDH+9Mv9zU+o6Zjawax3tBMsSJHAOE9xFgKAwqAMgjURLE1QYUDVf3gwal5eF1PJfZogCj+rvqVsO/hEZkboFYiOa3Z4KX688D2j/EquPk0lUMZn15Y7dKD+6TLkWu35bDfarm3mnX2CnFa6WnP4uWB7YbBVHhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/WqY9HEjaCbneMnK0HGCXja4xQJ+FTgeOI/myf7gMM=;
 b=bmz/xrJG4mbplrAuqUSS0/yGdhcsI77e/ENOF/soGKiDzppAFdJ0hHwBDduyky9zn8PE1nf2Cn5blmG/0XJTXCaQnPdaMf4GqNbtzqwxh4ZRLo8OmlG+CThlRCPrQ6NBtRO3F64TBjHkelQAvSp4//Y36rayljfeDFTXcCZg2TKV+JTe1mYGHPZJcCeXb8TqGQ23uAPmQNt/+lPrKAxFIMo2dM1R4Ho797Mxu/j4ZgnhukdPITN+DRQfnQDeDk8vH89Nvmf1EcZn2a+cfiNrBMAtdjfRnHSHCQjVuZJQVZOp7KGTZ6t5uAGfhtL+sSNvZAEuixuDYR12YIFX7wCz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SA1PR11MB9851.namprd11.prod.outlook.com (2603:10b6:806:4d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 02:19:01 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 02:19:01 +0000
Date: Wed, 22 Jul 2026 10:18:50 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Michael Roth <michael.roth@amd.com>, "Hyunwoo
 Kim" <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>, Fuad Tabba
	<tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine
 .gmem_prepare()+.gmem_invalidate() into .gmem_convert()
Message-ID: <amAoijqis2Gn/K2Z@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-19-seanjc@google.com>
 <alc8Vi9yNIFR/yGE@yzhao56-desk.sh.intel.com>
 <al_BAjCNRQUvuX2c@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <al_BAjCNRQUvuX2c@google.com>
X-ClientProxiedBy: SA0PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:806:d3::25) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SA1PR11MB9851:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2634f2-4eed-4bed-ef62-08dee7979824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|4143699003|5023799004|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3IPbYhNEizw6u/kzZj1QmhCjBnpD9AWrKpIED2/xKTurxkPMlXfNzOqlF0sRDjmFk1mnP49yGP0Zu7FwJeL+EKz5K8KCNNfuJvucuE2cfdMQ0fBr6pi9CwXEJXNjJiFq7TBb1/HhH7tipBdDVerHW73260DIR/U7dFn+L0ilApND61HQQBqwVKnxjVa49KPoDp2gASaEFuATzYULaE1MV8aAaerFue7VNLD+1jFNcwN7v005IbvvRmJQeA+siKFgTOWr7wAgej8K8iHTsN6wF1jYinqClcBd84hq6A/XgwUbf2FW0gQ7LLHAcsT6kc/ci99/EGcxtRBlaSlH1wf/LT0bxKPHFhs/ffnt02fG4J6S72167bwHPIbITjgYN0F/PNPYuKMx7EpjYVxwbmq3PyH7oeRI98mnfddMp389DO+s3D7HmcqTEbMNyUmVKrxm7uchIeaYrZ3eR9QrPa00Ujm0f4uPMEiMH5ZbhmBRK9fVwfbfTEhYQVc7xJPAx+FKFDkbcycjuzO90A3lWSqr9OYe3mDxlXXhoXI0kaZdJge5KXUj9Avg3JBWQDkYzKYSOBTI2C/gQMIFE9syFlWjtB1ySoZ9pZlqF3vhgpmTxP0+7vY3/UeL7cK8EByBtD48qiNZo6CsfL/+auD/kG81OA2uVveK2xYgEBWjmW+3PFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(4143699003)(5023799004)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XcKDuI5Hb04Oxkgg4TovdXFpdL7YfznEBOWK9kU2Ts4aLMJT7jeGg9B4XmoO?=
 =?us-ascii?Q?M3+PYsw2DCMhHimZcHi463qayNmGewd0ubQOb+k1e+Wqkbo+sXJzTTVfkiW1?=
 =?us-ascii?Q?7rrvrXFCX1JhGQ1R2ip5dLug9huYFfX96sqiwomitTRcKa2/YMALtspja5GJ?=
 =?us-ascii?Q?mKOmDyO9TlO95m9jBro03FnxTcz7s5Evgo7/t906BbQCydN/y7xw10z6eqAS?=
 =?us-ascii?Q?9f6u0ykTMahB03OXkdUI5DltN0uIUJbgrPSSxXFj1YPSu+23KLIL8QfGxsio?=
 =?us-ascii?Q?H0ubBjXESLsLw6QjdAbkA7qPZklJhcXAXQNlaRSj48AD+7TJlHzhn6IdbW8l?=
 =?us-ascii?Q?AUM4dGukISggp04QfF1qHKpMuB91zEgxMR3DDhRROYdKtMiiAl+TIbKpNQPA?=
 =?us-ascii?Q?NUV9eDCj4Dx+/t3yKsq0gE1U2gUl4aCk/Eg+MLjVDD0IROhYgLEHuJcZxCqD?=
 =?us-ascii?Q?5b32R9VFiUos/WCqsMUzzt72I2G2WNBdX06RSSsCr/SOdl13ku3iOcaTruZr?=
 =?us-ascii?Q?UxONJCuCgREMrr2eDS1o2/KdMPYy/4QwdtnJjSy1DbcTn/iQCy61Pg/QnCZe?=
 =?us-ascii?Q?pxbX7ngzGy/y+oGOyuScmx92xrGmaXWC5FNS+xmTQ/KI4+yfeZtRE7zUIHRl?=
 =?us-ascii?Q?a0sobMcB/wkYEs3U8rT4Zpok4ME9lB5pWpo2FKM796LOo/SxueQCRjHVUrLq?=
 =?us-ascii?Q?HoLXpkMRD/X4El1hJhkE2sbQBnGbDMxjoXxDQdpF0zTqZnJYPltzk9A+ikbG?=
 =?us-ascii?Q?n/Kq9ld/In1Q5AZGLegHcpzGJAxL2rKqjHf8E4mkDdQti+wZuNaK3VD1xbg+?=
 =?us-ascii?Q?SdMK0+x62zsESUP1wI69YyBrQzTY9GfVloOY+RKJKOzgHasQzllPrWn+Aml8?=
 =?us-ascii?Q?EiytWnEPFjXYzeqCA22W+KJhIcDWoI74iha+0KAX4mewmK93fc7u3KIi5pCT?=
 =?us-ascii?Q?hFIGiomcTMXuT/EMWOujvsZ/t0ipB3Rt8bZsjYVLdoBWksqOoKzoUFyv/cCy?=
 =?us-ascii?Q?D7yURh+xPf0nuS87582YHU+n1gLWwdMQf4UQxXtqsDqMv772Hjigfs/OW4TI?=
 =?us-ascii?Q?HPcpQmPYrWMdAWgNWrvSWdiMmEM6xibRBtY2onk9SVhlRlucNAuuA0ChlDpd?=
 =?us-ascii?Q?6CjWpJiijzScZddPmhXCHjWABM8MdhHnRjWc714jMl92sApet/3v0s6p7bKo?=
 =?us-ascii?Q?6ZM3E7/mqUuVCZV8PiH0f51VzGuXL4ZheJNhsJQM4jmS7qyflmNkpPjQRP9i?=
 =?us-ascii?Q?sAkzBdtycfixVAHTiIOWGT37Bfen1R3ruwWoy/4V6LHMsGfw4oaBt+/YYyFP?=
 =?us-ascii?Q?JxHZ+geZ6NZhUD5aCsGQx/DKfXsNUtO5i2YUF/W8sym5xKBDheKHm6xiU7sL?=
 =?us-ascii?Q?LHNsDCPm6i4BMC/ltZbLg2YStSQxlpeOtsfEUKqf+yw3gdDCY7ApEaB3d8LG?=
 =?us-ascii?Q?GnZVytGww9rI+2MojKKJ9PFiI/q20c2Lp+11W/GidCcmS67Re5q6JmY6Gtm2?=
 =?us-ascii?Q?NEtSFdaOrznuTNBypIeBdDu/s/gKSmRa8eaMtaMj2OWKlWIiUiBwBx3p8l3n?=
 =?us-ascii?Q?fuFyeO65lZwuxqa8hbtR3ldEtC7UQ2M/zey0U9mLmXZBZYtBuxb/V4pcRiWI?=
 =?us-ascii?Q?ahSpn3uBPMsXcSD+hUXnljm9S3MbInwVQsOfnQnzh3Y03U1/0umTCRWVeIj5?=
 =?us-ascii?Q?SYlHBY8mUFpjk7wvWX37ff2fDvS5lkRMrKX0zjIvGux8gLqYpDmdmU2YNsA9?=
 =?us-ascii?Q?hiG1/MXRvA=3D=3D?=
X-Exchange-RoutingPolicyChecked: p4gIfqLEeUg5roQe1gDCe/s+u4MFAaZrtJ9fgAgIJIwQR2o1GoEi6CKXqA8EH1OE021SbtB98ba+iSCgK1K0++vc8WORiNNT/2P5fKk3LNEWjgyDgV4t3klwlMMKH8ywc81RF+TA99cl0AiAYEU5oXO3B7JnPCa8LsGHvsxL038s5PqH1yHyDhyl2I86I5NLW+LR+QTrJN9E3lehS9JCILR2yN6fS3cCgNDdt9CDdImMMuuHZV58TRxO+L3cWuMxfWyBXHRTJKBkVT5Dj+e1OGWde0esUdKqivhFt+ZFsPln3wWXgdH9uFbX7nf0+1htA/ouVC0qLWrxR2NJr8sqIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2634f2-4eed-4bed-ef62-08dee7979824
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 02:19:01.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXAjHxT8yyHMI6uRk1GXa53tp7gl6Fm0DrIwQQEt54Ye/q1eJEe+ihRcLHGlkq1CUSSn1TSFYJcNXjwsdfUcjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9851
X-OriginatorOrg: intel.com

On Tue, Jul 21, 2026 at 11:57:06AM -0700, Sean Christopherson wrote:
> On Wed, Jul 15, 2026, Yan Zhao wrote:
> > > @@ -802,7 +801,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> > >  		folio_mark_uptodate(folio);
> > >  	}
> > >  
> > > -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> > > +	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> > What puzzles me is that kvm_gmem_get_pfn() can be invoked to fault in pages for
> > gmem-only slots in normal VMs, where kvm_arch_has_private_mem() == false.
> > 
> > Would it be odd to invoke .gmem_convert() with to_private being true in such
> > VMs? Or do you plan to add something similar to the following in the future?
> >         if (kvm_gmem_is_private_mem(inode, index))
> > 	     r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> > 	else
> > 	     r = kvm_gmem_make_shared(kvm, slot, gfn, folio);
> > 
> > Otherwise, would it look asymmetric with just:
> >         if (kvm_gmem_is_private_mem(inode, index))
> > 	     r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> > in kvm_gmem_get_pfn()?
> 
> Heh, I should have read this sooner.  With help from Xiaoyao and Ackerley, I
> eventually got to the same place.
> 
> https://lore.kernel.org/all/al-aDRTbDOPT1UbM@google.com
Thanks for the link.
Let me just reply here for easier follow-up of the concern regarding TDX huge
pages, which I think is not addressed by the code below.

> > Asking this also because there is a .gmem_convert() for TDX huge pages [1].
> > In [1], .gmem_convert() is invoked to emulate a to-shared conversion in
> > kvm_gmem_punch_hole(). However, the per-gmem memory attribute for the range to
> > convert may not be shared after the punch hole. Is it acceptable?
> > (To me, the .gmem_convert() in [1] behaves more like .gmem_prezap()).
> 
> Ya, these concerns got raised by others.  pKVM on arm64 in particular wants to
> hook reclaim but not conversion.  The plan is to keep the reclaim and end up with
> this implementation for x86:
> 
> 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> 	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> 				kvm_pfn_t nr_pages, int max_order)
> 	{
> 		return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages, max_order);
> 	}
> 	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
> 				bool to_private)
> 	{
> 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> 		return 0;
> 	}
For TDX huge pages, if we want to trigger private huge page splitting before
converting to shared, should we invoke the hooks like this?

__kvm_gmem_set_attributes(to shared)
	|->kvm_arch_gmem_make_shared
		|->kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);

But TDX needs kvm pointer, and splitting pages may fail.

> 	#endif
> 
> 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> 	void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> 	{
> 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> 	}
> 	#endif
Is this kvm_arch_gmem_reclaim() invoked by kvm_gmem_free_folio(), and should TDX
not define CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM?

As in [1], for TDX huge pages, you suggested pretending a to-shared conversion
in kvm_gmem_punch_hole(). In that case, should we provide a new CONFIG_xxx to
prevent it from being invoked by SNP?

@@ -253,13 +294,18 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)

 	kvm_gmem_invalidate_begin(inode, start, end);

-	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+	/*
+	 * For demonstration purposes, pretend this is a private=>shared conversion.
+	 */
+	r = kvm_gmem_convert(inode, start, end, false);
+	if (!r)
+		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);

 	kvm_gmem_invalidate_end(inode, start, end);

 	filemap_invalidate_unlock(inode->i_mapping);

-	return 0;
+	return r;
 }
[1] https://lore.kernel.org/all/20260129011517.3545883-44-seanjc@google.com/


Or would the following approach acceptable to you ? It renames .gmem_convert()
to .gmem_prezap() and invokes it before each kvm_gmem_zap(), so TDX can hook it
to perform page splitting before the actual zaps on private pages.
Per my understanding, this op servers a different purpose from
.gmem_make_private()/.gmem_make_shared() in this patch.

commit 96bf42273e12297fb2192d16add160b169d76157
Author: Sean Christopherson <seanjc@google.com>
Date:   Fri Jun 26 15:41:24 2026 +0800

    KVM: guest_memfd: Add pre-zap arch hook

    Add a gmem "pre-zap" hook to allow arch code to take action before a zap,
    e.g., for shared<=>private conversion, and just as importantly, to let arch
    code reject/fail a zap, e.g. if the conversion requires new page tables and
    KVM hits in OOM situation.

    The arch code will be used by TDX to split hugepages as necessary to avoid
    overzapping PTEs, which for all intents and purposes corrupts guest data
    for TDX VMs (memory is wiped when private PTEs are removed).

    Signed-off-by: Sean Christopherson <seanjc@google.com>
    [Yan: Renamed to prezap(), used attr_filter to specify root private info ]
    Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
    ---
    rebased to gmem in-place conversion v8

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 588563dfe88d..f3228419437f 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -149,6 +149,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
 KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
 KVM_X86_OP_OPTIONAL(gmem_invalidate)
+KVM_X86_OP_OPTIONAL_RET0(gmem_prezap)
 #endif

 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 382a1db48a3d..f762e51dcd31 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2010,6 +2010,8 @@ struct kvm_x86_ops {
        gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
        void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
        int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+       int (*gmem_prezap)(struct kvm *kvm, gfn_t start, gfn_t end,
+                          enum kvm_gfn_range_filter attr_filter);
        void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
        int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 };
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index a3c189d76515..331951e50eac 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -147,6 +147,7 @@ config KVM_INTEL_TDX
        default y
        depends on INTEL_TDX_HOST
        select HAVE_KVM_ARCH_GMEM_POPULATE
+       select HAVE_KVM_ARCH_GMEM_PREZAP
        help
          Provides support for launching Intel Trust Domain Extensions (TDX)
          confidential VMs on Intel processors.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 414b1a2b4317..d5bb7fe43328 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14176,6 +14176,13 @@ void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
        kvm_x86_call(gmem_invalidate)(start, end);
 }
 #endif
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP
+int kvm_arch_gmem_prezap(struct kvm *kvm, gfn_t start, gfn_t end,
+                        enum kvm_gfn_range_filter attr_filter)
+{
+       return kvm_x86_call(gmem_prezap)(kvm, start, end, attr_filter);
+}
+#endif
 #endif

 int kvm_spec_ctrl_test_value(u64 value)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9c1cf1a6559e..95350f6cec0b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2624,6 +2624,11 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
                       kvm_gmem_populate_cb post_populate, void *opaque);
 #endif

+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP
+int kvm_arch_gmem_prezap(struct kvm *kvm, gfn_t start, gfn_t end,
+                        enum kvm_gfn_range_filter attr_filter);
+#endif
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 #endif
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..4e4d40e13177 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -49,7 +49,7 @@ struct kvm_vcpu_init;
 struct kvm_memslots;

 enum kvm_mr_change;
-
+enum kvm_gfn_range_filter;
 /*
  * Address types:
  *
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index cfa2c78ba5fb..ea43bac4e51e 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -116,3 +116,7 @@ config HAVE_KVM_ARCH_GMEM_INVALIDATE
 config HAVE_KVM_ARCH_GMEM_POPULATE
        bool
        depends on KVM_GUEST_MEMFD
+
+config HAVE_KVM_ARCH_GMEM_PREZAP
+       bool
+       depends on KVM_GUEST_MEMFD
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index ef331500569b..d0a61a130bb1 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -247,6 +247,46 @@ static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(
        return filter;
 }

+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP
+static int __kvm_gmem_prezap(struct gmem_file *f, pgoff_t start, pgoff_t end,
+                            enum kvm_gfn_range_filter attr_filter)
+{
+       struct kvm_memory_slot *slot;
+       unsigned long index;
+       int r;
+
+       xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
+               r = kvm_arch_gmem_prezap(f->kvm,
+                                        kvm_gmem_get_start_gfn(slot, start),
+                                        kvm_gmem_get_end_gfn(slot, end),
+                                        attr_filter);
+               if (r)
+                       return r;
+       }
+       return 0;
+}
+
+static int kvm_gmem_prezap(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+       enum kvm_gfn_range_filter attr_filter;
+       struct gmem_file *f;
+       int r;
+
+       attr_filter = kvm_gmem_get_invalidate_filter(inode, start, end);
+       kvm_gmem_for_each_file(f, inode) {
+               r = __kvm_gmem_prezap(f, start, end, attr_filter);
+               if (r)
+                       return r;
+       }
+       return 0;
+}
+#else
+static int kvm_gmem_prezap(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+       return 0;
+}
+#endif
+
 static void __kvm_gmem_zap(struct gmem_file *f, pgoff_t start, pgoff_t end,
                           enum kvm_gfn_range_filter attr_filter)
 {
@@ -351,6 +391,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
        pgoff_t start = offset >> PAGE_SHIFT;
        pgoff_t end = (offset + len) >> PAGE_SHIFT;
        struct gmem_inode *gi = GMEM_I(inode);
+       int r;

        /*
         * gi->page_order is 0 by default and is set to PMD order only when the
@@ -368,14 +409,19 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)

        kvm_gmem_invalidate_start(inode, start, end);

+       r = kvm_gmem_prezap(inode, start, end);
+       if (!r)
+               goto out;
+
        kvm_gmem_zap(inode, start, end);
        truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);

+out:
        kvm_gmem_invalidate_end(inode, start, end);

        filemap_invalidate_unlock(inode->i_mapping);

-       return 0;
+       return r;
 }

 static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
@@ -802,6 +848,13 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,

        kvm_gmem_invalidate_start(inode, start, end);

+       r = kvm_gmem_prezap(inode, start, end);
+       if (r) {
+               mas_destroy(&mas);
+               kvm_gmem_invalidate_end(inode, start, end);
+               goto out;
+       }
+
        kvm_gmem_zap(inode, start, end);
        if (!to_private)
                kvm_gmem_invalidate(inode, start, end);




