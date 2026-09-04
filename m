Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0813515F1;
	Fri,  4 Sep 2026 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485305; cv=fail; b=jTaGj1mLaU2ZxpOEFY/7RYQc0Vmk46y53Xe9fzgHbAZ0vpRTyveSIC2/ODH8Xw/FJf7gQ3nEwJDXCltBL4urT3VdUXhjxwjBcPI2gtsfHnamtBrsVTPTwIZZ+DR2gL3LbAjue3VA2z1vRo98CIIVyNvwaIV1+cP23Gwn26ArjgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485305; c=relaxed/simple;
	bh=tB1okM/93hnLyULgCfk+t6paotMr8auFnb9NUmCWOTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C1uvhJfozx61nHV3KC0Nv1l3Rt2dX0ewSjlEIPfMC0Fvk/51uCeHus+cvSWTnyBiWgNzzuykOxUJBwpwK0b52YY80GgZfy1Y8M8jZXONusS2nor7TPygVW0tnSd/SBjpLPpEc1blXczvAkB1FtO5rFu2rRW3Yd0SwFfrHuocutE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLg4G5IP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLg4G5IP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788485303; x=1820021303;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tB1okM/93hnLyULgCfk+t6paotMr8auFnb9NUmCWOTc=;
  b=iLg4G5IP3Dou2M6IvAHKZdINem/lP2E6RKsX+aIf1Ppe3GHtLGuyhM36
   qq03AhC2liNaT2JKlxpmv5QvWmA+o2e+FWZEoURRjNI5FZWN8AmdHpCVe
   WZWOF7fWk6noxu/8OIri6LRk8Hpfc373qaJTDn4sdv/t1iHQ69ZiHkeEf
   l/EZWL+wA3dBx39LewAmk52prqVSoab6WERfWQ94xcCxbteSMphvLt97z
   dklaCBpcigZu8I3tZdbYRf2DMt0wW/TSusGMb+pg8o48FqZ58OJHX2sfY
   S/yrD6dBjaRDmKE3TTkdv2+o9VOaxCdgE01Y2ZddZZ7hGz5QbLs6K4E3+
   w==;
X-CSE-ConnectionGUID: c+KEOMfwSRaf/bqEzk3hBg==
X-CSE-MsgGUID: zYFPTXJyQvOl0Xj6ihVgjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76537592"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="76537592"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 18:28:23 -0700
X-CSE-ConnectionGUID: EG3nyzuBQL+zbM8csfxf9A==
X-CSE-MsgGUID: 84RR4MCJT1ik+AOXtDz22A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="269362711"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 18:28:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 18:28:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 18:28:22 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 18:28:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDNYTswF0hzmyi06mPhklitgn9xdHv1gFWkEr9m5YorSoDED4RXl3uF1Pk1ExcdO6KTk+O3cUEBH6B2jvZIwRGKYIy+6N8RxtQyQ2h54X+mpcZ0QSVEWN5FSRL23RxvaoaBikr2bDmE7VxZ2mA2BjNJo0Zp0buzjd9Q9mI5Qj2vpgDkEWot7nMT0fjLsfBNaDj55IkZnIE/e3GV91OfdqocyzVEAXphGaA4kaSE1wZB+ylyX+ioIz65e2hq8yQCnBbIk/Vno39nUFCgR99fGODFQee1BjJDnSJSeEgvcCkha0pjW5zhThfzE9IcFmkXFr2QYLT2jMwjplDOd8Q4jCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rTuVhvLIyONFM9j6r2AzUz1XBVR2Hs54Ub9vlXIoRQ=;
 b=tI1aE0FDoeyV4qw9BN924ZYcMx9sXfSQuOOH76UfrDnRPFLlk6g2r55Yf3JwzPcc/zT+1QnjZydp1c2PAlgS84id3tcjjFzg2Ctl/tUpEZ3lqSy/ta7sPGarhKzfC14qhlI3gA3SUnYGXcs0Lo0U5MW9x6UnYyPx6+52V0GT+j3GhKvMNmTbzYY8DxS974aPPrEZVqSGDIRFtu1/bnlNSJj/Dnerz6tixef1FW3+CXonMfDMYxGIBp0k9JsbTHZUExL8u92Yz3V46lxytPr8XaNYz8fsyMf9klW2B2pPp4/L/MPn2eUxmsk5R9ohczxingtH3yCOlUSj8WDSsfUKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DM6PR11MB4690.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 01:28:19 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 01:28:19 +0000
Date: Thu, 3 Sep 2026 18:28:12 -0700
From: Peter Fang <peter.fang@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <apoerDLC_fpSupY5@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
 <af483218-5c87-4ce1-b4a3-06132dcc3c49@linux.intel.com>
 <apit+fXmapCA2qlc@intel.com>
 <e6121cf3-83eb-4cc8-919e-2557fbcab3c9@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e6121cf3-83eb-4cc8-919e-2557fbcab3c9@intel.com>
X-ClientProxiedBy: SJ0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::18) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DM6PR11MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fd4b83-8054-435a-e6aa-08df0a23cd37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: s/k1LJwtWHOI+6V8b4R/I3nndfUGOj/vm48BCm58RnoXDoBwpr8VjAjD4c1eMS8kuZEWb4tv+oSwnTTvGV7EoJoxVGdMyKRjx8NAVlMtR24VVsJS6CEEFpiKTmHj2G9WB4DdWI5CzxRampe1Kgx3MAi0iETSFm/CiyHMWKP75/qGTRCkgqc/8iMeGcXXRjz9HJH9ps7jBY36XvnWdfaAxC1fe7LEzbq45sry9PL2Cmsklqd0a3Rfh717W6+buaKfVGnJnL5rkEeGRkAzI2wr6OjNI7Wsgz1MlMNxAbB/GUWYIIpnX9wMU4Yd5NcaELjIKpC7MClqrdnt+97Q2B9NcGhbBJtZlfWvFMqfzKTNT6OyG0MN66KG57ytHOLNwrT837VUTE8G2+Xfy9grjyjtRh3Jq1OqoECnEL+m4nlQM8GZJb49Z7+yI7flt8v3W52cxhkpgGnayQ3Ws1+UPAlSPudiKKSC94dtvDshVVR2SArA0Nmd+ClAB9jfxQDiOEMP6FIs2Ly1hb2iVF3UEbeMCyEnTwn5qo1fnhBziAjV1H2B7dvg76fNDhvEcsXwNn9ifTJv6M+PDGyfKLctPX9VRcRr6bnznl6RgwdhJpFmXohX5GsQwJDH4Q8ZXDFJVDmR35pyodt+klN0iy4kDsVPC2toJJa72c5ee1vA1MqgAQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ApUEecXOMmX1e95rlCokY1Dqr9ada1toH+brI0Bp26PJkS08qJX+1wipKI2X?=
 =?us-ascii?Q?eONxuwZ8My4sGuv9K/n5T3LzxvW9QuzBGvKgS3TJirp51poejPYm2D33BCn4?=
 =?us-ascii?Q?rcucEy0eZkmviTGw+zXLTGyz0bEIwqJLGIc0I5fT9pHmY9UA14HR/mxZ5Opr?=
 =?us-ascii?Q?96/i9qcNqTAbl4wk1KumM3kFRFPUmMmzTUcXSM6nZ4WFmYigRTxM9Io5gLaD?=
 =?us-ascii?Q?a01WZrq4JQxvORJgLUnnAtJ00TTgWadEN01aZ5Od+7SFxNyZv3f+IOzTIkRv?=
 =?us-ascii?Q?eWdWw4gYonL9m0SlbBWf6ZxnhYlrnn8vayMxyyc8PQuFXge9N6+mABi2bDqu?=
 =?us-ascii?Q?w8gM1Z9B7bgQdeASkzSzrZel/qpPjjeOW/LHSW17Yr+b9TqUajJLYSTzqxpJ?=
 =?us-ascii?Q?6LkjkiJw6H/Xs50SrdG21+KOxEbNXGaTgoRGdUEc3qZ0t8Omvi2bmmvti8OJ?=
 =?us-ascii?Q?eyCPYrDU2UHM7gywbFk39ZuahCsV1jlf1EwXKI1CFVGkjM6cstcIvo0wiTpR?=
 =?us-ascii?Q?/Nyif1LsVIqzB18CQMZaUu2H9MNcWNJiGrfkB/fcrHJY4G3gPsDlsoZIDGTw?=
 =?us-ascii?Q?LE1H7d3Dz9ft8HV6jBtagdTWg1TFNDgMsIFoQGwl9wpd/TmOFiRQTo9x4JO7?=
 =?us-ascii?Q?kYBkUJLRtNuSiyDyNTK3KoiH0lEBudkKPuv7L2JMclcioKCDmbniT8fpBK0/?=
 =?us-ascii?Q?yzYOr942RPIde5BdzE6o5o+0de/yjVbRfJc1+XqSY1Nv72wv50i71xRLVrX/?=
 =?us-ascii?Q?miEARFnxVjggI1R+RPZIH0UOg/XjZQx3KRFng2/fQWS2p9FhkA478+4ta+5D?=
 =?us-ascii?Q?UGWMZO+htieT0vk6mn9nQjNtoNG+HcnjagkNu5sq7YRtfEUK2GAOnPlcQlmx?=
 =?us-ascii?Q?vUeASQ8srfxNQr2zqGaoRyOcgvUJy1kGdEh7d1YDQ5M6YNeexpSV6t0j5GLi?=
 =?us-ascii?Q?yc3DYP9SBvwbbMdjFKrAVtYcY3Y8E5Gz6irEQtfGsCNI/9eSUuJwdtgTUPdi?=
 =?us-ascii?Q?HbIZdLWGD13LkMaH08XEjBDvfnBbhjcdmtZ8TpN3p2fqR9ZSGbk8hY/J8dAa?=
 =?us-ascii?Q?Z8TQTE0VtmA0W/a7ch/IPQchj2Te4oa8Wq6pEtMAfq7IKTu1GdukodOEKr2d?=
 =?us-ascii?Q?eBoBZ3H2RViO2nfQNSNyfHIQ+rgtGSSSK9lE1eNYSsIja5cf00DRzItROtFu?=
 =?us-ascii?Q?luL/wgxQ/2tSCOv8Rr+CmCnFuCAb2ye5tF2fS4k+I83xbV46Pk4IrqiqcFs/?=
 =?us-ascii?Q?ffSd9nbELl1WGUab+/q/LxTdf8zEpvJZxt/NklOLrhY8d11MQbSSJmpTsEWC?=
 =?us-ascii?Q?ZMcg3+SJcNY6+S/VTGJlkcgY4eRoQ6A/h3oAZDs8/wcS1BpmZrneMgCNxQPy?=
 =?us-ascii?Q?wLgAHnNiYQ0jPS+9u8oYk4HHAJlTwb/WLMQugd8my0HR01CtfMZAThGsp6MP?=
 =?us-ascii?Q?Pudu7xnqhPnpswbpJpZlLHO3yYQsGGOO4kpU8FHLgq/Jyk+ww9X6cX4bVDYb?=
 =?us-ascii?Q?X5N6O2lc3Ie1IkJLDsuR2a743DF5xkSyGvDEtwKKma2ktMi8z9ZPSkcolMIz?=
 =?us-ascii?Q?x/WBfW/pduBk2qsdZgJuLwAYlHLLdo/na8GeS8Bq/r6JVn9A0g+j3ixKQYBL?=
 =?us-ascii?Q?WKpKG0aOO5NuZEwLha1dyM9wlzhFo1t3/Ry3GFufYJaTul7wYyZjy4t8Ujf9?=
 =?us-ascii?Q?uaIbGmSLSsUIQDAzxceABX6N3NNbYs652UB9f+RJEJIS6LGo8O5wN6ZgUss0?=
 =?us-ascii?Q?Mfh72VPbVA=3D=3D?=
X-Exchange-RoutingPolicyChecked: YalJSvWie58VvBVzVj7eWxP3lEQeek3Fg/8Xt2B8zKWL/qUFVjL9KxCWocNyvJMouBy+7zP0UARzu3yhIsmB5XuSRX3MFqBNwRPdYNTVDMYokG5Ki4ckpofNQxxMy1CkLxoLBuhKXayn4Fv9LjCftPhnsR2WA6CWstSI/CZVpGCfmlrryY5vCZjmDbIi60LWOWK/KzpGRAGgJz8UyaZMxvvGSCMnIbqiGXSbnZnQ3x0sb6kmWqwKzDxWhzHP37ztP5zZEdfpgQR4GaNWHSwtFium+adNQM1piX/hCb8sb1zq4cd2+vDzbSFrqIZFRdrj/DH2rNik56yJZ6LgAhEZkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fd4b83-8054-435a-e6aa-08df0a23cd37
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 01:28:19.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHHwEu61TIxW6RJRhH1nOr73D2aWgYvh+34RvG6Nhk6PM0AjrmPxRzCkeifmaF3lFcp/vIIZOhynDob0YPacaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4690
X-OriginatorOrg: intel.com

On Thu, Sep 03, 2026 at 01:59:25PM +0800, Xiaoyao Li wrote:
> On 9/3/2026 7:15 AM, Peter Fang wrote:
> > You are also dropping PAGE_ALIGN() in alloc and free calls. You can
> > mention it in commit log.
> 
> I think it's better to keep the PAGE_ALIGN() when assign quote_data_len,
> although GET_QUOTE_BUF_SIZE is aligned already. This makes it super clear
> we want to page size align the buffer.
> 
> And in next patch, we can make it
> 
>   quote_data_len = PAGE_ALIGN(get_quote_buf_size());

Hmm... Looking at this again actually makes me think it could be
reworked a bit. There's a discrepancy in alloc_quote_buf() if for
whatever reason @len is not page aligned. alloc_pages_exact() rounds it
up internally but set_memory_decrypted() rounds it *down*, so we'd end
up with a useless page at the end...

What if alloc_quote_buf() took a @npages instead? Then the expectations
would be pretty clear:


  -static void *alloc_quote_buf(void)
  +static unsigned int get_quote_buf_npages(void)
  +{
  +     u32 quote_size = tdx_get_max_quote_size();
  +     size_t len;
  +
  +     if (quote_size)
  +             len = TDX_QUOTE_BUF_LEN(quote_size);
  +     else
  +             len = GET_QUOTE_DEFAULT_BUF_SIZE;
  +
  +     return PFN_UP(len);
  +}
  +
  +static void *alloc_quote_buf(unsigned int npages)
   {
  -     size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
  -     unsigned int count = len >> PAGE_SHIFT;
        void *addr;

  -     addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
  +     addr = alloc_pages_exact(PAGE_SIZE * npages, GFP_KERNEL | __GFP_ZERO);
        if (!addr)
                return NULL;

  -     if (set_memory_decrypted((unsigned long)addr, count))
  +     if (set_memory_decrypted((unsigned long)addr, npages))
                return NULL;

        return addr;
   }

   static int __init tdx_guest_init(void)
   {
        ...
  -     quote_data = alloc_quote_buf();
  +     quote_data_npages = get_quote_buf_npages();
  +     quote_data = alloc_quote_buf(quote_data_npages);
        if (!quote_data) {
                ...
        }
   }


Does this look better to you?
