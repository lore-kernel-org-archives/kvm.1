Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F219067C;
	Tue, 21 Jul 2026 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616556; cv=fail; b=VETy/PX4jzlamspsXCKxKFQPHmWARZXZA62A/EmFWMddPs7/lv4kDIjzTnVLRi5EEws2nbM7xtBYHNOy7lhQdzNqvGPNpDHcGJmhj9eH+L4YT+ZjxkIKLB+9OT2S69vHtOzrlQ9TqxopqY4CP26Ps4IYMhYt49qxN3lRuP//nOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616556; c=relaxed/simple;
	bh=p2ZfysDj4tyuoWzmDoSaeyJ7I9ETm2pLsAhmncNAtY8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i9ALN+3WadUi5OkhBGmKw+hjyJntFbjkA/StP4YF4xUHIQHPgVyhGFQ9BTZgTWDie8mLJelnU3opblG9kZdMONi7ELYWl8CJvg7HUJzxp8bRNeayHkFu5YAso4DL+vYRjCgWormaIyGDOhTPQ6Ac4vijpGMDBBZQhx7ssqBqCA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxX3UbwI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxX3UbwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784616554; x=1816152554;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p2ZfysDj4tyuoWzmDoSaeyJ7I9ETm2pLsAhmncNAtY8=;
  b=nxX3UbwIWrbi4oFkkPLvTkjAtgAPxKvhxTLar7UEJP3Mer1AgJfbppKd
   KUx98cHTBYDFa9eZwLTXDt9JfH76CFKksCQRrNg/orCPnPeJCdN+7sdHH
   gx3UIZuR5f2eBB8cjzjOOMK61zayBBeG1jumyPo7vhfS1+yAA6gueRUAU
   Z4vOWPUKExd+HoFLb2QbExhpSRgc6riztjXwuoDhxF53sxOep6kaysnsn
   E8PDTef8MIa/298X3HIV9We2pmC6laeVID+5uQZEADefOyz/FiJK4c5KE
   2Rkd1hmc7ymiVfc4Jg+3uxPiIi4PuurAmRRdDn3rTDIv/xAEZgKRBT086
   A==;
X-CSE-ConnectionGUID: YYeyAmuHTMa9/zoCAOdz5g==
X-CSE-MsgGUID: 6PfKYNv2TXmOL1sIdgcNnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85082730"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85082730"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:49:13 -0700
X-CSE-ConnectionGUID: 7krwV/g7S2qIcXwHgEkf2w==
X-CSE-MsgGUID: wMoRoB4KTUCUf5Zv1NZygg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="261226583"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:49:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 23:49:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 23:49:12 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 23:49:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igqa5hi+bxqZyqLyGHpD8QBJ+WjYt1OFwRRLtdGNaoojF22/e6neYr43zVbVLc+D6kmF/0lsS5RfqRR2VJ5vsT7sdmtgV2I0AqCjg/cmTlnleW4SvOGXOpSgPKc/bkkykLDq0Erqs3lbDrw/dBKG1AKOh9cy3UfKddh2yFGoOeBH6iQ3ivl+XWDsLi0WSIWOjqbtr5ZbhQDmYI6wVRCyTIAyXZsqJB3LTN1lPt2P5eu9ArhXhp8ZYUZDboBlVDnqXzWbmxe49T1qXuN0nWotD0O3HMllF2Y08LQF4Cvf2Tp6aMnuT7sEJVqoHzc8o26aueWesKJbBNFL64m76NkIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JElUtLu+PY4qDMfdZL/RYeG6g4EiBodnm7yeaCqa24=;
 b=UXLzDiiIcukJo02Cm3vjzjZ8lhJyfY5mUhBl5hnVbwe/FksYUV9qsep9OyU474xzUz3IC9eN7ZtZE82eLxVS73Ymaz4sJ5vXm9cPOb5pz4cqxBqJREPbzR8Eh2OK3cZerzkX33IAUdOsOtf/5V7NdmWeeGRDZ/NKSVDZarzOUBj5PZPS4j3M6LOxM5heVdcHD8Srs9YRYL4+0e7W4zWZkT72BR1HIxo1vW47n+BMAxzP9csS5231bfKDm2MG1V9JAXNyzYDzG2FmiLuU9m/rLypMK8sWSfiIFu4r3gGDQ/HP2Ghvlc/CGL5gTDY6pvZUCJsee4/Qw0kGIxSpwY9C9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ0PR11MB6814.namprd11.prod.outlook.com (2603:10b6:a03:483::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:49:09 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:49:09 +0000
Date: Mon, 20 Jul 2026 23:49:07 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <20260721064907.GG3178326@pedri>
References: <20260717214349.4075994-1-peter.fang@intel.com>
 <20260717214349.4075994-3-peter.fang@intel.com>
 <51059852-9a10-4735-a81d-003b4b1963a6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51059852-9a10-4735-a81d-003b4b1963a6@intel.com>
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ0PR11MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 63373d07-1462-41b7-fef4-08dee6f429f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|4143699003|3023799007|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 7WbCCBkmaTWgFHos1GQj2mMIcBRDobTtKveGlKnYTvFl6cVz8XTKMLwnA/8NJKqtrSa+6dcC2zL6MBpQGkxxZzrCxxMo2w2r85Ak0WDd0kNsHUqW6+JCUveu5ZasKp1PraJf7OyBBSV8AMNi0IYx9p6LUIfUDix7EQC5WwEq23gKXt8HIN/LRW1eWckTtGjzjOlLDXS3AYwTFZFMrLOygk4BmXGmj5vkNkTA9QnAAnSga/aMUs2nZsd5M2A0qOonZPYYlXfhhWniarjQexWeEhAU1dYX+dGJZwA51/nOnEfn68+ajm2wtGhd/oPhpX3khERcKq+QDZD3K+u52UZHKLWjAopbe+KY+/+YvtJxiLdEzDbw78N3U2Io+6+drILVrc63FTzh7VMQK4k/9Ilgos1yoMB/pw9h+eb3MFXXJDFkxhgSLJhP9nWjfcCVgHdJZv12jodVgJMykG4qCVXhLhe6rRfCLN6F96RZDUwVxPG/LpMnqmk9O4/MaqfSDggyxsp+KJWR4zaP01ktNSQz7zxD/xYajgXRb+hOt2PejXrNG4dCFF7+yi4O8nfJ9nLstxTGiR+szwgqs9e4KU3y+DpJi70p7L0+4MHzTVuIO4g/TQslbCQOXvrX5vJdz07rEvVNmLGeTv5wWT3VU5hD/wJIKEIdpqSx6yP0G8aUCx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(4143699003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3XxQlxFdtkZqLWmcbq4t2yGCaeGoT4S5DhkkMTLRXKR0MRodbtUcWdN6pg2o?=
 =?us-ascii?Q?6ipU+0nfzXxoh5fLPVVaahs9eQLC0f7j9hCTCxWyY56SdUYwainNahRGI/jP?=
 =?us-ascii?Q?JWmZlls2n/NLO46vn2PMeuxtWzx1IOYbzXoBS0b2Ir+OzprjZseUpvQUNVTA?=
 =?us-ascii?Q?P5j+w+gnde1qz1JAHToUt8clcI5eZXjs0SugrB4QmACxVa0eGAo2GkRgjnPX?=
 =?us-ascii?Q?NqY5QLkyL0l+BRrYBUa2Gm2qS0aiGsdfhnYzrxdT0yuPL7YPtP54DvGCGPQA?=
 =?us-ascii?Q?QrUJWIAAR4/VjxUrq75zBzVpAKqS2yMCoh5jHGCWOTSPiTNKhjVTZkat+cXF?=
 =?us-ascii?Q?lwR/vZSRiv7ByMcW1qwc6bH8iuGGetQOOGkU+dwszqdq+bT01X3qvx5KHwna?=
 =?us-ascii?Q?eTRtmAgWsmc9l1vl2FfBWHmLg5Qf41Ezz70lKg9JwpJMpm6lSTxRWRhcbu1n?=
 =?us-ascii?Q?1Xv9TfgGOM7FwG4P03gGMtZgXL91aiQySnJWRJnIm2cTSzpQHfuN85aHU30p?=
 =?us-ascii?Q?icFvm6AdaPtnHsc+5Oo4+FVJ4pUOsJ7Y71r9XLqXDLeHVPjPPY3C43ugoEle?=
 =?us-ascii?Q?dNT/DZbkPhKy1EaPk7cT/AtoOWsgoq9t9XrsaXwI1XvuP/F7zoj/Vx+l+WFa?=
 =?us-ascii?Q?h76WR2xpNWRrLeEXYBFKaiJtmAoJ5G3+4vsVpfWzsrDXGiTxpknUZDY9jgnX?=
 =?us-ascii?Q?6EoPhPIqd6OxfIHfGSuv8yHL6L+38sn55AK1Q2EL0QuY8x9IFRGhQ5XQjNrQ?=
 =?us-ascii?Q?pgBG1f4wdGGgjmX7PKb827u6OD/LLkwuk/srbqnFrIuoSiVv2SHRI76r0iYB?=
 =?us-ascii?Q?7TXZX8JaLd2CEEwrjKn51pPwzYhz8hVLlWq375piUy9x3TeeeLvpTsHVF2b4?=
 =?us-ascii?Q?ghdMirLLsgbJoPHe+fZEKoPbbI26eLw2gS55yb28BiIu/w3ftLG6+zzi8Ai+?=
 =?us-ascii?Q?nPFpEBoIBsXBz5U1JpoRY+iqobku+soLScx2gTWH1Z55bxl9w+1KFdK97fMy?=
 =?us-ascii?Q?XCMvvdLL0WegEYiWSu9DmQrDl5GRlODbi/PnNqedbAAw3pQ4I5PcSjBVHg/S?=
 =?us-ascii?Q?SQZvN7pXYCqXaTcdd0KqU5F0atnSySuncWozSSbDViX8vzg6BS+sRHRlWFXF?=
 =?us-ascii?Q?oLlhoG14wFbHnkh29vlxvnuWoMFmiDALgGge9KVSSFcYpTfpmkWRAVtGJgZQ?=
 =?us-ascii?Q?X4pxqT5ZR+OL4L9LIGbXySRp5Q/UqbY5a0SROn13X1B6HJoGArIHRPIw4g+x?=
 =?us-ascii?Q?DfjGF4h/AbOP0sjWs4uOwlT0pIOrHDRtuxwsXWdL6InQkUCVmfIVl4Zs1XDx?=
 =?us-ascii?Q?6UbMU7LaW8o2xaSYN73iDnt650oyng+JdmPXLkBYyicfp0AyqWh5IOAc9oNE?=
 =?us-ascii?Q?TkCb92NuDS39BcrH1rxQJPpe0XyBszO6o863VbFWLc7Van9rHuFRpC29+C3T?=
 =?us-ascii?Q?5AGOXUOd5PPIIYvXtp/PpWtMSquhNyI4dmYcw2iKSwxNHwRJDQQxF6ZHewPv?=
 =?us-ascii?Q?aqVvlKTdTpX6/05FUDlBa+k29F9qkT7hrIdOGmNQhK9iXw6KRj2R8bYFwci+?=
 =?us-ascii?Q?i2s14c+gonbBMV/eY3dH+b4S1k7gw9jeAtQKMFRmDxibmAkqaXtrdMov98m3?=
 =?us-ascii?Q?yEBhY3CUdQavJvRnsSnirn6fBDwzjC82h7UefkgDIZfSHTbtgFXMUp0HdrcY?=
 =?us-ascii?Q?ojYq/gzFD418u7EjTTZZdOGx8SHOg+hEbYdECt8nOA/egGZ+6AJ6ZGybpPRf?=
 =?us-ascii?Q?DWVkhM5eVA=3D=3D?=
X-Exchange-RoutingPolicyChecked: k9gaQ7p2PMQQJVXNREKolvjkmVSVY0e/h+5r7VOhxQC5q8UNUy0cmdFbfm3RhHIxMWsLe7I1a5njsg2xgEkomxpXtSY5hDJqLyqShrxaUF33XSUZkXWMndn0n9t87DNfLO8kgxjEZK67AIWTUW55FLm0Ud4/TZ+uCR60SOp9bAXn4qeHE8n9RX+6mwl4zA1jcIVSKUnmd1K3WGNAjLbZ1dSwFIi6OsqUT7C8ysaA02E+ldIBjgWDe5dapTCLTTep9qQwnt8WfZDstxPUaUJkt+TLJ0ZeFSE0eFtHNT15Swi6CCH9XXU0+2g5JFmyUdCbf8+oAlgNb2YUdgGEHKmh1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 63373d07-1462-41b7-fef4-08dee6f429f7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:49:09.3371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yEULEtxSfIgKCp51zpjdkZJZEC7A+tu13wNAGODkoLyAzWdRKn+YWl0IJm1O60fF0e2cczmQ8gcI5rd5uDSCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6814
X-OriginatorOrg: intel.com

On Mon, Jul 20, 2026 at 06:35:29AM -0700, Dave Hansen wrote:
> On 7/17/26 14:43, Peter Fang wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > The TDX attestation driver currently uses a fixed 128 KB Quote buffer
> > shared with the host VMM. This may be too small for Quotes using schemes
> > such as post-quantum cryptography (PQC), where larger certificate chains
> > can increase the Quote size significantly.
> > 
> > Allocate the Quote buffer based on the size reported by the TDX module
> > instead of always reserving a fixed-size buffer. This avoids wasting
> > memory on platforms that do not require larger Quotes. Older platforms
> > fall back to the default 128 KB buffer.
> > 
> > Because the Quote buffer must be physically contiguous, its size is
> > bound by the buddy allocator's maximum page order (4 MB), which should
> > be sufficient for current attestation needs.
> 
> This is all talking about post-quantum-crypto and all that fancy stuff.
> 
> Isn't the important part here that the old TDX module ABI had static
> quote sizes and now they're dynamic? Now, the reason it changed is all
> the fancy stuff.
> 
> But the ABI changed. Right?

Ah yes... I should call out that the size of
/sys/kernel/config/tsm/report/$name/outblob will no longer be fixed.
I'll update this. Thanks.

> 
> > -static void *alloc_quote_buf(void)
> > +static size_t get_quote_buf_size(void)
> >  {
> > -	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> > -	unsigned int count = len >> PAGE_SHIFT;
> > +	size_t buf_size = GET_QUOTE_DEFAULT_BUF_SIZE;
> > +	u32 quote_size;
> > +
> > +	quote_size = tdx_get_max_quote_size();
> > +
> > +	if (quote_size)
> > +		/* Reported size does not include GetQuote header */
> > +		buf_size = TDX_QUOTE_BUF_LEN(quote_size);
> > +
> > +	return PAGE_ALIGN(buf_size);
> > +}
> 
> This code is almost nonsensical on the surface.
> 
> It _really_ needs some commenting. Things like:
> 
> 	/* Start with the default quote buffer size: */
> 
> ...
> 
> 	/* Override the default when ... */
> 
> 
> You could even comment the function to say what it is trying to do overall.

Got it. I'll improve this pattern and add more comments.

> 
> > +static void *alloc_quote_buf(size_t *buflen)
> > +{
> > +	unsigned int count;
> > +	size_t len;
> >  	void *addr;
> >  
> > -	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
> > +	len = get_quote_buf_size();
> > +
> > +	/*
> > +	 * This fails if the requested size exceeds the buddy allocator's
> > +	 * maximum order. Use __GFP_NOWARN since the size comes from the host
> > +	 * and should fail quietly rather than warn.
> > +	 */
> > +	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN);
> 
> Bad Sashiko. Bad.
> 
> The host may be untrusted, but it's also a critical part of the system.
> Are we sure we want to be completely quiet?
> 
> I used to see little dmesg warnings about TCP window shenanigans from
> random systems on the Internet. Maybe that's not how we do things today,
> but if a random dude on the Internet can spew one line to dmesg, is it
> that crazy that a bad VMM be able to spew a warning?

That makes sense... I actually argued with AI about this but it kept
saying this is kind of like DoSing the guest. But thinking about it
more, tainting the guest is probably the right thing to do... At least
the guest sees a big splat about why attestation is failing. I'll remove
the __GFP_NOWARN. Thanks.

> 
> >  	if (!addr)
> >  		return NULL;
> >  
> > +	count = len >> PAGE_SHIFT;
> > +
> >  	if (set_memory_decrypted((unsigned long)addr, count))
> >  		return NULL;
> >  
> > +	*buflen = len;
> > +
> >  	return addr;
> >  }
> 
> This feels weird to me.
> 
> If the upper-layer function needs to know the size, why not have it just
> call get_quote_buf_size()? Then there's no pass-by-address.

Got it. I'll fix this.

> 

[ ... ]

> 
> So, yeah, this patch isn't gigantic. But it's also fundamentally not
> doing a _nice_ refactoring the way we expect them to be done.
> 
> 1. Refactor old code to make it nice for adding features
> 2. Add the feature
> 
> If this was doing it the nice way, we would *actually* have something
> that's really close to s/GET_QUOTE_BUF_SIZE/quote_data_len/. But,
> instead, this chose to cram the mechanical changes and the new feature
> together.
> 
> Can we do it the right way, please? If for nothing else, for practice.

Yes I'll separate out the refactoring so that the dynamic buffer thing
is on its own. Thanks for the feedback.

