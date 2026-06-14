Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67E224234;
	Sun, 14 Jun 2026 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438289; cv=fail; b=iRDw0j7/smTDMk37QdVyrzWa6rn2mcMW6wU6Kq6UWFeVAnJP58waITGEXbFHfZK/gVxu3QCn7WU+Z6ILJLkSdFxH85BYxsWStSLdhtxhYWbuVAnx2d7EESjWIWQvLHFGMmFgn5nzlSrJCE+CWfnMvnBjvczFVhy1rQC3AoCS9s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438289; c=relaxed/simple;
	bh=zjZtO8txE5ZSw39IPeQvFhjtN9cYxJFVbqNm8XtBDHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BDiJU5sunv4X+MY88khGO/1b34LPuJ3pVQO9LMIeArntZify98xkEklraoWWd7ImQjuUGkVg8ki0QEw3iqCAyGQNBkNZRIjvy7xbJWG1/Xeo0C9bPGgvmnLVWxM8wQMn1siNt2UPbm6+Oc7B+awfOhvULN5+w01v0kiWg5IswHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FiGPpyUL; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FiGPpyUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781438288; x=1812974288;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zjZtO8txE5ZSw39IPeQvFhjtN9cYxJFVbqNm8XtBDHY=;
  b=FiGPpyULJ1BHcw6zIE4ytUcvKNeahUcvYSM1ZcCnbrGIz8Z/2eldH7J/
   gp1n9Sz8N+kUDSViZ5psCOs4Copge+Qo9aaAQQPO6i7xYZ0Wq5Ck6IE4r
   na6iuh7zUuGtFys5HiipH7t6oRJ3U3FyFG6ZLByUcSfGurHTWb6a1a603
   kWtc95Fh7VFpK9aO2Y8Orzm3kox4cyTU9IkdnKctLb/lsInd2GRdzLAyn
   tlY6SYYTe1SNNALrw8mKocLQ5SWFLcluy/fzQ7D03vDhLP9LGeTaV716i
   GZO8OuW08ue04EtcVoAzzvtsGYXxpituKMMhClyvbEFofiaJyNZpYr5kj
   w==;
X-CSE-ConnectionGUID: k9XcDgpsT86ta2N/bA+9fA==
X-CSE-MsgGUID: C4fxh0fzS5mQ6JheXu5opA==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82105463"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="82105463"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 04:58:07 -0700
X-CSE-ConnectionGUID: 2JmBUurqQnifjQ3RSV13LA==
X-CSE-MsgGUID: +QQCgszySSuNkOlUUZVCqg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 04:58:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 04:58:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 04:58:06 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 04:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOTJ3irURXO3o+hb5TfJJDC6x8+1wZnnF7/aL2FQCyotbzVlCdVqTrmgOsZCklMmzJHU8lXg8w9YtGJAmVy3Xx5VDvkyy6zlwfkgWu+iaX5pIoE9h06wwGFeVENJS0CY3YG0JhjhlLSvhzDXjcygrHVFTOGV+WyyVuV+YidVkGu0aNUNJ+exI4nm7IFEyy63n9N2GBbDmIdhKyeNQK90pkm285CEfJWqLJBAz/4OYDyzI8VqfGeyT/2ztfn3BUZ+RBrOJ1BYuqhYF/eabLoc6uuT5ineO4KtQqxcdlP5mQC1fZv9q68VgNgRVP42DdvpmyUdKcP3ofNFBqxAUbS5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KRBD5uYEmNoI6kOawdA1orbFTl1KRdmhCLadjYaCsQ=;
 b=Z1TqzAnEz/wwIP+p5ch1Yp+8koIb7UEIhlvBpX8XSZ6EvRBNmZ6Jz0bVE8stCn2x1CINR79+H5eVhxi6EKOZwwOWNT5BSC26oSqNIAEkTZhhMxFrsEH7TB0rWL82l70HQzgYb2eanqFszTDp2OkELp/Unp8k/FnfxNMnsJ+3Wuoz/qkQthB9PgnFg1i6HuzTH+bttUt9E/6HwIz3d7OGECYWhbTIRmVQjEHAlr8ZLUKDyHV3Flc9uUKplw3t1LHZpFW6V9x0TREtUeku2cPhuKqJbml1zSlzuKpOEC4J85SJg/xtEdGk/DRTI9LgZcpmHgEOTF2BvwHIoVjeWvJMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH3PPFC852EF225.namprd11.prod.outlook.com (2603:10b6:518:1::d4c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 11:58:02 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 11:58:02 +0000
Date: Sun, 14 Jun 2026 04:57:56 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 12/15] KVM: TDX: Add in-kernel Quote generation
Message-ID: <20260614115756.GA3425618@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-13-yilun.xu@linux.intel.com>
 <6a2ca24f16277_9b85510070@djbw-dev.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6a2ca24f16277_9b85510070@djbw-dev.notmuch>
X-ClientProxiedBy: SJ0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::19) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH3PPFC852EF225:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed556d0-764c-4f8a-6927-08deca0c2fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: T8Cc8btYpiFoFMh1ALU9gwvqBOa3CPxSO4AsGqG6WxEIhsPesVEhvEmIKg+z9tUMhvQT3yfIQR9mTjrlR0ouXmiva4U23VM9oYaV/DRphlLP7W7+CbzHArq+mocx3G8rrNRpuJ3k3i7+8PVRKiZXWJezck4IV2zVBadtmPfZU2WSaw0n+/d2a44tuRD5JYZf8UFRjl53O9+BAubQQc+29qRKhFnXVSGfKV1e2LrRw9zuKitldY6BFP6B4o9Udb8JiD0ZnudRtKlSE5olkp8iI6wUSVMUaGLaE+ZexSWbuRy1ubUTgrZTxtqpKGt6wKuj4bC/R54ORuXWakBij/003i+wZwIziPSGGqYE8ZABAQqGfMqv6O5jWkxbp3JPOOHlDQh6HQ3hPPiDLGC9zXV6Vo78Xx4YoDc6WXqTsQIrs1z74MXktUDMqnkATeFaneXG7L1+uza3kPqHDfpsVplLQxMW4nrz55/7d9uFT+19gRt+7urTLooFF0LZZJUI/S3TpK4GHEF/Crk9KC9g02DbM+NeMjIHUasZZpVVocnqnxQBK1baWjwQMotpW7sWRfYs7elN1XAI4LxKAJeXIHRrIxRAK8zfUsRYh1+0pudwgqsphdWxRbMgjsYEyClhTpy3+mT7Vm0lc4ER/kd6zyTet87uY55M18p8Z2dzceYYp41ROKHKQfXgw0e38z5pAagw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MUX2296q3umzMWe3mhsoj8331xOV7rM6AvaKb+0RWk6lJMGq51WOxZWfhMrH?=
 =?us-ascii?Q?5e35xRnuEKiIzdHBMrSTWeQw9fSMX/MXv7KbSiVtA9VnZoUYCO64K5aUkLFo?=
 =?us-ascii?Q?25D3Q7ulXuaFvfuR1mnpbEUh6X6FuMcMxLhgUkJpWHxG/p/mY9KZC1Gw5pZH?=
 =?us-ascii?Q?F2kr3lnv8gFfaQBNqU5QLS4STpRVLMJJkgPaHOH+JICNqPTL8MQRF+1IkDVC?=
 =?us-ascii?Q?TVYueofPQYPrysLTNhEmNLjhM4XpLBeOPGtJotLBqGx8fiBRz8w5pVJhUTc6?=
 =?us-ascii?Q?eKHVzp+Te7/GXyr/0TlXfl/tlsOxhASfq0lI+KdVnMi5lfLTvSV/3PNx/Qjj?=
 =?us-ascii?Q?RH/HsP2HNFr5tHI1AMoH6dwWJlWEO0tbFumqPDZAbcwr8G2cGOUnxgjG0bEq?=
 =?us-ascii?Q?bPgD0HofLQAoiQoBW4/cvAS7BtDZGxjIelKHZ8Gc0tm7ym9NgdwTl9uAsQrI?=
 =?us-ascii?Q?goc6dRyTtAku8pDe6bgY3OGSRdholAx8sPbV/uFG/5/KZlOSknARHOgrp2RK?=
 =?us-ascii?Q?uuQ9Qq6nwozwJaOa2I8fSpbUujmbhc14WOUJF7TsF62OXuQwoDbO/31iOhwa?=
 =?us-ascii?Q?uZFIUKDeDtNkIBucGveqLJM7iDPPV6YhJJp3ZypVWvK9sausani0laG5pwFL?=
 =?us-ascii?Q?SPSlJRsUWuvfZI2+6sf56LOc1vXE3FhtPk/LZ7FGrDZzfim4phumXYFqXjk/?=
 =?us-ascii?Q?VzajlqBnMxn5AScqDGIpVLr5FezF49iDGq/zaJF8C0TrCpe12u6Boad/YHAF?=
 =?us-ascii?Q?c8nb5PrYyrthv4/NQVynVB/yn/ek44fute2V+1SP0RrIyTcqN4fOgwIC97d+?=
 =?us-ascii?Q?6eH5AAzG53ZSp33/qVBz+4fIkP4hR3fA70dNtJUTf9Ene8t/Sj29peeVYawO?=
 =?us-ascii?Q?PgwkJW0JvQiifo/3+uwyCUHqC0ejntyYQRjSCiB1eAXgfYbf6cjLP2MK0+br?=
 =?us-ascii?Q?I0nY1jPKuAJfQI8ar8xvDDxaiGnan35uz5K5/B0vzLuohn2ejH/yWre+eGkK?=
 =?us-ascii?Q?5n2YLPr5W+3hV/sM5p0Xy2KYSLWb2cQfrCimgQMeh2zeKW55nfavDVP7X6J2?=
 =?us-ascii?Q?ov7VbLdKDzetHpsWKeHi+P6EOYfNOAxqBLbYT8YUYmBFNrk5hJIwWTKTDmLC?=
 =?us-ascii?Q?NGPzsScVtTP0f7ha1RaRVHW7YM2KFdn+moQbA4q8VmgJIXjp+nZxDg+GIHen?=
 =?us-ascii?Q?xEXupz+6bcNgM5nM2qIryAr1zhtTCxxtg65ZBMhxAFd6ku41jBDWUOXtyFJU?=
 =?us-ascii?Q?96gN6bAfhe7PDT9fiqkbEKs+EwtDlTXKhIXsS+z1TaU+IGAjsl+DVLJciNgw?=
 =?us-ascii?Q?Z2rPykLeVB/fvX+A8ruaZTrZOIus3gOOr/zFrH7KY9HLQlkUfNZaVpuDsvzT?=
 =?us-ascii?Q?4W/WWX/OKbnVqlAYQv2UKG/I4GzIE4tzCqQ2IjFLuhMgT9jh12NpvS5zbgwV?=
 =?us-ascii?Q?lt3FibZeAgKcCO3xML0u5CuAUXeWpgg0+GX4+biJ5kZ2uK1WmN8hDK6B6HJO?=
 =?us-ascii?Q?45OhtUlbDJTWUzIOL21T2Z+QkbiMaXSzGEY5KbgAfaet5J475fiM2xruDbED?=
 =?us-ascii?Q?eMQClJQY6cTM9dl6I5keVxC98bksLPbf2i61yYthpYkF2ysvNbbR7qRugQjb?=
 =?us-ascii?Q?UcvjrGkTiNmPbr4NyOkW2w9tTkM7bvWv7xvOzHLihknYbyohDPFnaHCUICnb?=
 =?us-ascii?Q?MZ6AftfBiph1G3lC0ZNeUtg/8h5ZuAHaKOuuJQMFbBnl/trtEySz0AjVz+Fg?=
 =?us-ascii?Q?315KnLxDHA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Mv7wsQGFA7+f/PXn06Cgqw1mNPnePoH/Mnt10bXSpVImBWq3kEAphhCRz5OBNIF8gE0IYiFMLE28Jztktvg91vlqyuJOYrOwF7XMV3Ov/Vnd6x/Crqt2hfsdn8xQu8T01CrmJXfvWRs7xuszYmm9xkpGamAo7djL1CKyQZCR/Ok3Bbbnt7FS51nB9UUkOjrBVWiEGamh3AtynpSlsysEVf7myXRuijAT118vWJtJs8U6KKUmKGF7EZJs3jhaVvzIcSxfQn5dqyEI0OuDhBcPaaDu75ZgCs1iIggF20Rh+M/1Cfaw90PEQT0BeWm5BdaADVS3E4HFoDRstZBPXC/Ing==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed556d0-764c-4f8a-6927-08deca0c2fa2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 11:58:02.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE6Y7DBE0OKq/g2P+JQjXyQpUB8r33xcR2LgfLOZ5aWIXC7tRrRqvd0zvdESKMz0Om54kxKCxruDDEWGyWOYHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC852EF225
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 05:20:31PM -0700, Dan Williams (nvidia) wrote:
> [..]
> > +static u64 __get_quote_kernel(struct kvm_vcpu *vcpu, struct tdx_quote_req *req,
> > +			      size_t req_len, gpa_t req_gpa, size_t total_len)
> > +{
> > +	struct tdx_td *td = &to_kvm_tdx(vcpu->kvm)->td;
> > +
> > +	/* Only support version 1 as defined in the GHCI spec */
> > +	if (req->version != 1)
> > +		return TDX_QUOTE_STATUS_ERROR;
> > +
> > +	if ((size_t)req->in_len + TDX_QUOTE_REQ_HDR_SIZE > req_len)
> > +		return TDX_QUOTE_STATUS_ERROR;
> > +
> > +	/* The caller frees the quote data */
> 
> No, it is freed by cleanup as far as I can see

Ah makes sense. I'll fix it up.

> 
> > +	void *quote_data __free(kvfree) =
> 
> ...this shadows the global "quote_data". A global really should be
> properly namespaced.

Good point... I'll fix the naming. Thanks.
