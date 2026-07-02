Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172B41C71;
	Thu,  2 Jul 2026 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951586; cv=fail; b=ncCpdXedysVDFSdu0GoAE1Z2hR+0u+IpDgbr19lbFwDzRfyEZ4hI1LXAXVlMBLPc0ckaBjGwTLPNBeV0r3vW4pQrW5Xs8ySWt7yV6lB0gnCc884ozMNEvzEMmriG0MmAt/BnMRPDv1t5dioFJwW0insCE7y5zDEMU93YhchMOMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951586; c=relaxed/simple;
	bh=FBmtbR22u5DK9J/T5TfcxcsMvv2bp4X+jWLp3nbP6YA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uw6tabkZKbDsqaEqbKEN06P9nfoScFLW7hHxp0kKbxwK+aW5FLGYfzGdJ7YRNPE+aRbIMDcahjtYoWOACt9DvwQZHEsixqG19dudT6t7uXcoJBpvhIb3R3uf+Sb/vyAXqfZnTIMHxMRrk0aeHrK7ER8kTS/1uYrwBn1KLpdIClM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nl5ntcnB; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nl5ntcnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782951583; x=1814487583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FBmtbR22u5DK9J/T5TfcxcsMvv2bp4X+jWLp3nbP6YA=;
  b=Nl5ntcnBQKt3qRn8O5wJjNALJ7/iDcseSP9r7z+8xislUsY4C0Xyj1rN
   xWJkPJOwgXszU6K5yJlMcnbJyhYcgZg/+FLErHd37awNuMh3yhUhUrqW1
   NJHJxwBPfZ8hMdGWg6lAYAE2r0u9PO3FbUQnbgCzGe4U1kJlPmriBWtiR
   LzTsn1OVK73zNhQulXlxgAioA5YiGqBsbll/opPFFjtrd33UsLxwGu5ro
   3yMq8//e8nIPe/ehuq3hLwujEtEMTn2r0rFXvEFHcTwngFJPdafpnte20
   aGd7dYO8iS2ZE2TCu4HGe+V1VnYmqVKzz81IbDEpE+H2eNwLUv+heO/ER
   Q==;
X-CSE-ConnectionGUID: zdbg3ZHHT0qriGJfqva6TA==
X-CSE-MsgGUID: B7rIluv0SjatLVtqwa7GGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82685705"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="82685705"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:19:42 -0700
X-CSE-ConnectionGUID: o+dIRm7TRmehPpc3Jrlgwg==
X-CSE-MsgGUID: uaBFQHNYRN+EbfEN4ghgSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="253366251"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:19:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 17:19:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 17:19:41 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 17:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq7toI9OF3OkUNiu7HpnAjtr78iafRAXMFtFzjPKRk/NDBxtwPilo+lcei5XwzzbzR1D2TrPfq/5pHzsY+maMcIdPmtEmf1FjXIXtzgtd1lmT+JfSIu57FTt6hhLIC2b/XgXPpjYeiMGne4AU+oJcMkNXRcyQ09giNO/rbNWZ/vplJK9xWXjDiOCROo8AfYGCSiUI3wSMBetheIVmvHXYfXHk8FCmxDAI0sABSe8xT/4oV5AMf8KrCffhFKUqLCIsIoOD4UgALZkOSYA4H02QriAzoFXaQOajrnMjut0Unh/9uSmfdx1mQPerXjj4fad/DoqS78A5kFx7aNw3Ib5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZBGytnJSkVU9E4icoHXkZKBoRzW0Xx31sRQGK3kuzQ=;
 b=s4nwhd+jofw0TDbPuovS2dIs4BsGMPh/dh8WlcqUAAmAJYgYSTUfjlKSIZit41eo0E+pZxJvBgJ5dYlif2yIax7MMwFUgdD2K7m3xCLd4jyUWfIBlHvWU9gt0S+nJHnec0qayiVIOXV4k53RFFpXKsgvWXjKrYZDfUNtXC4MOMkAB82C3PyWPgTigIMaCwAf2PvSPSbmw+zxKlUZOc10NtMuJoeat5qLn4ajdXwYDXU8YNztEtiJRS7uv7+LvQtxXsDwAgN4nAPlYleVegNuMcJCStF4MCVcCaMHOMLlwOjHJrfkTXD3QqEHsgdEQ5gm0FegyUv0QBlvE2lK22dfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 00:19:32 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 00:19:32 +0000
Date: Wed, 1 Jul 2026 17:19:30 -0700
From: Peter Fang <peter.fang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 08/15] x86/virt/tdx: Add interface to check Quoting
 availability
Message-ID: <20260702001930.GJ1743876@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-9-yilun.xu@linux.intel.com>
 <3cf04184-c34a-4d49-926f-5791f12cd74e@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cf04184-c34a-4d49-926f-5791f12cd74e@suse.com>
X-ClientProxiedBy: SJ0PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::31) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: d63f653c-ca6f-443d-35cb-08ded7cf96e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: seSagRQ9/RhOGzNGwE3TTYVGtgdiQff9pWAt4IAaJVEIG0jTTFJse270J77qK5kUOKAESFH4+Abz1XEG/P/t7ysv9IffCPGvLZ8mc8tCFni+EyMRr1ht5BPhHPoatMCM4JBtRsKKqDFtXDKZHfPn8jKU4206aMYDRm9Ith67N8vPbrkFNonoQZvjlPIAvnCSFkUB9kld+0bcad8Wr4IDr4PWC/EHrQf1uKZkqRiXyHVKEQaICXx1V/Smbe2bsX8OpSqnO42xWsg359ovXpg4rqqyyefvSMS4ttX3ZPyGS0D5r9qfdtlRoiT3sayblNexGd+6Pl+RHuZu/XG4LBcueFa10Z9DI2y352c6JO/BQEIcS2snAIw5fxpsO4HIrvSFdCzd/3GcX5zxzSWd0oV42K5PNn7Ww0Wc9hA2f4txnVH/A1kF3sFboJWoC8ZA7K9gc31tnhOi2E27l3hWi6C6J2mDnpb8tYVGU+9vBUljQcFgfy1gbLuG2DR8ZMfuHmyiZf/syacrKR0xQMZjYxtZVrh6cfk18cqWKdwlCwbUMG+B14Ji4VUAT4a9ZCR5RvDZvcM34L5tBurvRacnjRGeituFzPS5Xvlcuh4fTGyGsVHa3KxXTBzgX3DAhjYXVu/ktwvMJXnvKcOvtoarKhWYlntZOpNtgga/loXVuikvwVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wm2rtSxr5RHnWzJRAJIhWubqlF8P6lAis3oLEnsenyt4vR+YfGvZeL37LMLn?=
 =?us-ascii?Q?oIRCnYYvAa/eZLKdM1CF0qUfTKAKyYYYmuPbweL6AFG2lBcGu2iUnoweVdAz?=
 =?us-ascii?Q?VnXctYMLaOX8pXXbQl31zmIRcGWUVWJQImEgg3h6edCRre6B/oFXE1vH14nG?=
 =?us-ascii?Q?nz0IBwu2R0KxsGEbdiXL0wiWzMpcalxHN9pfBnJ3N2Tfk7Rn7zeCIFK49jjg?=
 =?us-ascii?Q?Z9QfqHK9gMQhCp9bJWQrTFmE9oQi1llvBNy892OwJ6nikxaW+KHz3s40vQo3?=
 =?us-ascii?Q?L0tT37I13DtdsHgfDSexE4VVFRi2OpPH6EYDWsGyN7ob8w7g+icbgno9y8sU?=
 =?us-ascii?Q?kFJ40xMxPU9JPrI4w1s+gvYqFW7vh4PLlx99h/e7OqmoRUTVqwA2wnNM/j8u?=
 =?us-ascii?Q?/iYYQZB1j2I7wot2aTtHbUnBzCaNs15pNWko1qV9zGcMxrayK5zFOOkbRQur?=
 =?us-ascii?Q?PvFeLvfdy/mwmWRZr3yvPOnd9tvcSqRNUCKLA9gVty+wlCtVeD0N23s+unPE?=
 =?us-ascii?Q?9us312ipFcEureN/1AQk5dYrO2NH8qPLWC5O9ACHqlCXYwudXDsIpRkyLgOV?=
 =?us-ascii?Q?GKsqpJkjTOU7/BI6h29k3Lk/FmeB/sYLt9Ctgt/wJNjTV+fgZt/fsH7kVjUW?=
 =?us-ascii?Q?e6WUbsRBH4Sojf/t4xk7m2P47ZXdr5Jm4w132cRuKbR9cRv1BVTBUvMMa9ay?=
 =?us-ascii?Q?wZz6SEKAEKgHep1ZEyNAvvgWFxtmlGjBDitKly5OgZtQvghfOjPbjBMTlrC7?=
 =?us-ascii?Q?y8EN4NWXkO040isVV3EVC+TYCOGkSg4HPeQCRFK9UrXaQxxqSsKRUaZoY3Dv?=
 =?us-ascii?Q?BhF9q8llcnL0C/K803DgMQz56vhMAspIxL73xgNWv8FH0dmHnz6bGhhNPk2W?=
 =?us-ascii?Q?NFyMxPXqn2MiJ2513PvFxaTLoSYoHGSWcz+hu8dbbfUD3NyQmlagOHzqn2BU?=
 =?us-ascii?Q?sGSVjO2bwZ6C4tASgO5fM4+rhiJFqBU5foE92e6HmiZZIo92hHoYw/ni2hrB?=
 =?us-ascii?Q?8rGU/Jqvve+4zjvdn7vtoso0ymZUkle16uD9XWEfy1RTaCBYm3ijACw8lKbM?=
 =?us-ascii?Q?Om5BVxvu2DmYvvYv+4l2OnWhZnjfs5Tn1uclJY6l+AeX9a5b7IxLgL+IAe92?=
 =?us-ascii?Q?Ly2gf1kUnPGoxwsBROe7ZbceWfRgCuMRivHADiJbmLDu1h+vxU6VdXQ2jHof?=
 =?us-ascii?Q?f4Ll/jrvPm9RUW3v4CHEPKcprTQmnQL4NH013qZAKM0T6737Pzqg4HZegTpR?=
 =?us-ascii?Q?RfgYyw3eUs30TSkY4F3kO6Gu7wIxjr+ZTEJOPqI/8mYMRTZUTQTMy7GiBKbD?=
 =?us-ascii?Q?vcSQV1cCruMTyt5c09sxT5mYUs4Nyw71HzYu8QRFm4ZiHrMg6irzVbuFzbvz?=
 =?us-ascii?Q?PCc3Kkw0PY//MWnchzbzDMUcZ5rdwQvWhnLlVoFwQ8jgSK5A0hlHja8BDXT5?=
 =?us-ascii?Q?UHfzej9U6Bv9TY2/q6PBnT4l3SLF+XKNy6G/b+UF24/KydtH5iEa1jiaGMC1?=
 =?us-ascii?Q?TQ7zkFW8ijZda3k5mq9nOTvpcGWaI5QiooUqwyh9cfzn8H2v+KwKmj9vSDrM?=
 =?us-ascii?Q?c5M2EamCHWHNRmmOnv/Xm6rS9PsCYF+qrJh4cXLOHnWgW8heHad0o7sKEi01?=
 =?us-ascii?Q?KmIfXrNDuaNBZBkqcLFKaRtyOUxb0wShlA45h0aKxbMvL4kzfTt9o2cYhAHN?=
 =?us-ascii?Q?YaRX5Q67/DLu4Ws9+XNbgD5U5tCbfn6HRSpQ/LvgAvu9G/YE8xSN5wQqPUDe?=
 =?us-ascii?Q?Dq2u4IkE7A=3D=3D?=
X-Exchange-RoutingPolicyChecked: he4gxkNOwkD7fuMPMl4Ln4GkftX6R7rI9rFCCzmyzSPZrF7bQ47skiC35JH9Jg5e4McqJgQpuxHcStlCECZb3tejznVPLJgFxyComBw8mX9c1+O3O45BuLNhB2u39ZyIEHKcnZV5sas/jnuCcj5C5ybqeAeh8TrSXdTGe/zxvk9fVaBQ8b0JyqjFVnv8xxS9Vp7XFBiFRgoyzE0p3ivKDff4h42nJOfi0IyObX9TzHDp7hKSvCXRmW+ZR9ti+tXxFDMJi83Ija/2jgkVjpGr1w1MuXxVOpEqW8CwMnBENNRIAJsjPwNNSnJMJXbsKTSs1VGQ/GL7t0K+dQzh4HKD5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d63f653c-ca6f-443d-35cb-08ded7cf96e7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 00:19:32.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6R/6+eZwtuX/4jURVHLDBSC1MeBgnxZ0cAlcGPr7BNwBQvC85sA3iW81C9sM+xM5ow0NEfcIgvO0Jm28Tv7kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com

On Wed, Jul 01, 2026 at 02:25:05PM +0300, Nikolay Borisov wrote:
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 9d04293394d7..b305fa5aab5c 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -1213,6 +1213,21 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
> >   	return page_to_phys(td->tdr_page);
> >   }
> > +/**
> > + * tdx_quote_enabled() - Check whether TDX Quoting extension is available
> > + *
> > + * Return: %true if the Quoting extension is available, otherwise %false.
> > + */
> > +bool tdx_quote_enabled(void)
> 
> nit: Probably rename the function to tdx_quoting_ext_enabled or
> tdx_quote_ext_enabled, so it's abundantly clear it's about an extension and
> not the quoting functionality in general.

Makes sense to me. I'll fix that. Thanks.

> 
> 
> > +{
> > +	/*
> > +	 * No need for locking here. The quote buffer is initialized as part of
> > +	 * core TDX bringup, which comes before KVM is ready for userspace.
> > +	 */
> > +	return !!quote_data.buf;
> 
> While this works it feels a bit like a hack, perhaps have a static boolean
> variable being set by the init code which is simply returned by this
> function.

I'll fix this as well.

> 
> > +}
> > +EXPORT_SYMBOL_FOR_KVM(tdx_quote_enabled);
> > +
> >   #define HPAS_PER_PAGE			(PAGE_SIZE / sizeof(u64))
> >   static int tdx_quote_create_buf(unsigned int nr_pages, struct quote_data *qdata)
> 
