Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FA1E7C12;
	Tue, 23 Jun 2026 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191519; cv=fail; b=I6YiKe//df4J9EZ31i588+6o656j5/Uk2uR1d6leYmxU8/UT8/s57GmYWpCKBNvpDRx/q4/IiBe05CyGTboeBLG3VNHtLJ//oBaXLy6DJSBEmahLMsnNn+Y8thMWoLDBSK3C1gZ6OOeZh6mP6gcslI6lnsP3lGVYLffLrLal1f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191519; c=relaxed/simple;
	bh=b6c/5IxR+x40Miis8i+jJU/IcoYr8h9rrWGMp2HteTk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AQXIceXBENQcWg3hl2q+IioYcvH2hhCPSLRW3vLbc022cy7ycA67bQa13Zxlow/AObz8nUhlHcBwmCFPTSKEx+9hkCFVvlTMyMVHuJIp5ihQb/ddM3AR2qhyD1sOUk6E+IGZ3PSDxVvJj6SUZNirGlpJmYhfb+yD3Nz794YYGac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0IqP5Vw; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0IqP5Vw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782191518; x=1813727518;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b6c/5IxR+x40Miis8i+jJU/IcoYr8h9rrWGMp2HteTk=;
  b=g0IqP5VwOoFxwBQKNbxvV5oA9qbB2HKrPCtgpr1Flp/H4jMB9wsxXxyO
   CN4hfmzUl//s7KuZnSOaXFhAIrXF4vUB62x9tlZj1IcT4O7tCBD2oLLFc
   Hnu1HYO0QVfLHNjqoQ/zIb9NhkY9yoavMUl0WTKkWvKyYaFXmW47sYkQv
   IKKuwOQ1j+z8lopCDMVVS+rIxA5BITg/yCDMqRQ+m6hpwe9dmBRrh1iAB
   XncjIACJDG75PRjdhKDewJ442ZZQlPg3t7Rv3QwJavuxSBXuNBCTN9aqj
   XZTu/yHHomaq1dSl1kUGCTkZNDfKBYf8pIbE8jjSO4fSclw2ZdfP9I5LQ
   A==;
X-CSE-ConnectionGUID: s+WcJPe7SJWWFCJ8PTkqzg==
X-CSE-MsgGUID: /qKfzsYOQkOI+IwQFhCGcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93583684"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="93583684"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 22:11:57 -0700
X-CSE-ConnectionGUID: 1ZkSjED0SFeUyHD+7sVLWg==
X-CSE-MsgGUID: eDjlB2AFQgae4XVcqgoAJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="246502568"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 22:11:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 22:11:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 22:11:57 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 22:11:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBhS8T8s+K59XcmjsjLQfTEg232gP0aWWJJmYAUrozHo9fKib+2f6Q9/u0I2YNkpzmwcDgxdMBxN9i0wUH867HjvYjya8kdxIsz2s3WUWF+ALA6TAMKaG/JVoahT4vg0O+LatiIr9H16GR6RV7XF2hlFqpZ6pn1Plr/NIIKdrR/IDHnK982kZV25UCnwubC3Rxl1V+pQXDCPaIeqQ1w/+Na3NmcBNG5Y+foWEs4oY2O6MlG81uUgbj/LkitHwKgU4Br6GHhboqScQZ9qtUqig1xwnzh/ip/PAeBX9/saYBWB7+Lyx9KdUi7VbSZMmTNDay5JJ1rmSvUacTXZblxbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xbqG85Kg9vVxhhSj3hxhjJtYexmgJaOX4UjoUKKOUQ=;
 b=rwmPNZtKsrlkCm2maMZJaYygFR8PaHFKNo8ztT8fhj0xk7Cu8HDFZtQTA6Zr4rxZmQSXOaZNqZD+vjmnVyrsVu0C+G0sgLEFmP8PYpudb9zk2xNduyZlIt9OxLvacMuBWGTXD+dLrLbEmpcag/kKh3yixxWENeYBmp4YAWWXiRFvBGOTGFP+jk65KZ3INRZljw0jerNA1aPdhryYbcMtdzzJ2Ch7Fmt4uVhaQqwN3JWOMh0YTV+CqXVmcfyG1rgpxhvCCe9Pejfv43ZH8bo8rNvkqWcWxnGlPfBUUPLuU+pgzk6V1EnSBxbNAXhObB6eJEixO1/96VjegW/oMXzYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by MN2PR11MB4742.namprd11.prod.outlook.com (2603:10b6:208:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 05:11:55 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 05:11:54 +0000
Date: Mon, 22 Jun 2026 22:11:52 -0700
From: Peter Fang <peter.fang@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <20260623051152.GC923079@pedri>
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-3-peter.fang@intel.com>
 <aiv7bInvJdltX71S@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiv7bInvJdltX71S@thinkstation>
X-ClientProxiedBy: SJ2P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::18) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|MN2PR11MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: e6294a16-72da-4cc0-5359-08ded0e5f0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: YN3xLXB6/nUwj+SDMLbV4ygl0v31rCs0JaydoThTZ5bF5wOozxIKH7KOHXBkmuVxg282mIBvT6rY8SLIXn2Efj+3fQ2JL8lTVr5LhCNA8tAY5lh1WFCxb5PXO8N4PJO0tGbk8Rrtovv+9Oi7/MHuYuvJ/1F23ldrgPPXZ/PYUA1FJLWD6HoOFgs7syOq6phLdgS7ON+O/qb3iJkIGM3oypZSB//R1uq4j++ZKgS2qyLRyUIQK42Ko2zV7cPibr2SNxsgmdfNVl8mm6iIeJcVAO+fnGev4xc5cypvMHAHORZnKToqBSl6CixdUrI6FqrRXjBOFfRQr4rzbVbIzzC+AhHyj7J4qyPeFs/xxaXLBc3EbupLNjV0qPocU4NNg/GF5WBRBxFUpGL3k4fnvCnnO86GBGoNbq3FmajYSPJ5DYLJVpOGiBoliBcwGKDHx24vxFhGX3/ihEIrCs6h5f8pR+DbmORVXtPUOgPA0g/ZOgrlTrcphxf+g60eQtSZPNTV7nDqs2iN84to3oei+klfhv1/ntarwHMB2b44hzluMxg9RfcilOZnNtbIPBLaW+Psx60KM4XyGJwzD1jkRntJYKbuVP5KziA9cLsTdviI01Qv0pS+FUONB7sR5xYcpJ2sC6X4ZHBQhtRPlF9kSTSCwkibEjABC14bw80G0FjNeDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Qzur6cewPDc2diiYhnOvuJ8HV1yCSWo7R7AGDlo36rA2X8fgsVovaMQQPnR?=
 =?us-ascii?Q?KK9ddg+agFzM/nbsZJvYd79NDiDiXErXeObuXx1Xo/Hvbd4+1Fvf9Q8JkT9q?=
 =?us-ascii?Q?EMNutunOKT+vdw+eZYVxAPxMivFsptOLsCT0bXgf36I45dqT7ESYItAzrbrc?=
 =?us-ascii?Q?ZrfDNgZctk9ZP+gsV5TcfSxqsx7cEfgUIwVeTQD+HiuBZJD9eKkopcxPe9ua?=
 =?us-ascii?Q?kMz7wEDWaK82bZJDJDUAzLdXCmNk9JxTgyjnUrMjfzPPwuP/bxcZi7qKXasQ?=
 =?us-ascii?Q?jDuSXfHsaxfOQS6bltQQPgZg2MUL1y2q0VQRoc1BBjHDqhPiHV0+QFWeg50i?=
 =?us-ascii?Q?n8nvHsQK4esbJ6i8Pa/9b2PlIYlikim4gspIhu3spWFl1HAXT73T12TbTqzf?=
 =?us-ascii?Q?VPl3CjbTDP2gi1bAEOIu9kuuEGmkjbc6kcjzZooWzzYShQRwax7FAlsxd+lG?=
 =?us-ascii?Q?t0LfytyY5tTYADr/UsHk5vN0pEa5OUMfbx7jWsp0tm0B0/DZElbGQ/q9d27N?=
 =?us-ascii?Q?rhTixYGhOJkKJp5ZTJNJ7Ffqk3DTH9D3/KD0/XN0xWRZMq6u9Wx9uByDpbgs?=
 =?us-ascii?Q?or8pdSURyhIaasOMzR8UHDEQx/pSfuPDsBfGaRmaHsOH4+k/ovBKQpzElwqQ?=
 =?us-ascii?Q?+vjXH7B+djET0unUgm2qFQzbS67REeOg3Z414sDQidGZU0U9Swu8EH5I8mFT?=
 =?us-ascii?Q?w3sTmLf5w9zjoHQyPoSyibc4/cxpbyj0xURCtEI4bZ5V1TN7qhwbmLlKqsv1?=
 =?us-ascii?Q?D5RQeGSWxbwmakjQlM0cMiCN9T2K3pV5TQERlqLOLOrBINVNOcIrCEeXTOFO?=
 =?us-ascii?Q?HgVjTMO/T6XD4ffP2Y527ujd+hmROX86DrsmfWpuf0Rb+groEcmHOVX7GnoF?=
 =?us-ascii?Q?cGNm6OjY2UK0osbZzUhhyCJC8tUOMW5cH063yRyXx9A8/wb30dbVIl8H7Bc1?=
 =?us-ascii?Q?njEXJjL9x3VFua4tJaRDiZ3cNF6Z8HTzifXMvC1KHw2BU3o+LRGP2hBVckCJ?=
 =?us-ascii?Q?O6Xp6ufOI98fmyKKDTft+n/zPvY6xWCkaEolsXXncTqhaihIFC6cV0AQIAJy?=
 =?us-ascii?Q?1/gmZy1RXVer5U1TasT8fhZVWawJUmt8n/+m5rkRVVHeGhEm9IfKgwGCeii/?=
 =?us-ascii?Q?YzOfL0g0fQUba8Oe8U87lzFnq03uyncM/9nM+alxnWz9ReOEED/LRkK4DccP?=
 =?us-ascii?Q?2ZSXnzROizJWokeFwdDq62/QnjaGOkO7sohbifCxlJCGwzSlSyQ0wIF+ZBqj?=
 =?us-ascii?Q?OeqSPcn+bLw08XmKbDCz0g5uxTkbJAK8ZP/SyjR9TPXjGpLeeWhvaSj/1MyJ?=
 =?us-ascii?Q?7v7H+VJUYOkm38LMqGFeh9k3RfGE5iKo7/tbrxBSiQ5rGkUt2xjxayZcy6wj?=
 =?us-ascii?Q?DK3vdQ89O00pl2lQbvTgEikH6bddpIllsPu6Lybacg9DoNdGv1Jk7qew5yXw?=
 =?us-ascii?Q?cQhVw5L1A3iLliggqYoqifU7o6WiPDZIaU3khw0Du4xY3z8ToF+kkAPkZxkJ?=
 =?us-ascii?Q?rUbZG7qqMuteM4oRj/YN05RcWAtxXZdPr8TuRKx+Pshw2p2FBtChmdOJc/WI?=
 =?us-ascii?Q?YJvRnOG9tzKMPGFkwOXU9hfGTiPuGCensLCU33hj8pge7qXJ6jTca2vVG1k2?=
 =?us-ascii?Q?WoLa65JNu98vQDKl4mV6NiNU+12K9T57t0b46XcmH7mrHvmg74DwidOIE9qm?=
 =?us-ascii?Q?yy9YjPL6nP8CbTlwL1+W4oqj7mjxNQooqOotHlAPIBgoNnflyd8UUlYIvSLj?=
 =?us-ascii?Q?py0O94DKlw=3D=3D?=
X-Exchange-RoutingPolicyChecked: UrHotkuDh1uXn4rBNgXaogN32iSPE9K615lICR0tI3XFUIrXlx+6SnIniMfBfnzqreVx2JmEhwdF2/rhkbXjfnTq4vG2QSfg+BcylfmA+jbaSKogGW88yXIqx+L0msnYXHLgKwpTPsbcKFCBFaMqj+ApFKAEvV7JsO7szxlk/4ysJ1N5FC25+vKZMtXVEE+tj/7hMJVqvk6hU2PoY9GuVXwHBAB6j6JP4fuBEw7MwyUewknTLynM7iDpB3eqyNdDHUGkRcIIiqDqz2tnCNteyYs7JRX1ObJdgPhXc69H2K9lVp7ZDYkD7zOLecwkxt1NgvUCwKVF/ZiuaZnYE3SVSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6294a16-72da-4cc0-5359-08ded0e5f0be
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 05:11:53.9820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uJbKjP6b8B2iPs4xyTw8ryRqGbC7ob1w78c31SLV0M6tTdG+G4W/kRWRoNAShlcdfAuwkXY3oCrlRbpSzgbrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4742
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 01:37:38PM +0100, Kiryl Shutsemau wrote:
> On Fri, Jun 12, 2026 at 04:08:49AM -0700, Peter Fang wrote:
> > @@ -171,7 +171,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
> >  #define GET_QUOTE_SUCCESS		0
> >  #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
> >  
> > -#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
> > +#define TDX_QUOTE_BUF_LEN(n)		(offsetof(struct tdx_quote_buf, data) + (n))
> 
> I've got confused by this offsetof(). It is valid, but why not plain
> sizeof()?

I recently noticed that using sizeof() on a struct with a trailing
flexible array may not be the cleanest coding style [1], so I took the
chance and improved it. Looking at it again, I see that I can just use
struct_size_t() and not reinvent the wheel... I'll improve this in the
next revision.

> 
> Otherwise looks okay to me:
> 
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Thanks Kiryl!

> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

[1] https://lore.kernel.org/linux-coco/a52c4701-c99d-48d5-9b63-8eb1c0e589f0@intel.com/
