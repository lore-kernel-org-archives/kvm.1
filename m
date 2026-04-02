Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720881A0712;
	Thu,  2 Apr 2026 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098641; cv=fail; b=p/R//E8byXZVE2GLalcFcZMQrinA+EatbOFtKn3u6cBKNlVjlCDuwRL1hwEo9uoPE31yYj3IQXl9L3g0oWt6r9EfkfEBjnL2PNsobcLxyvK4mavvsIcQHRFxUZ3tYWpsq7oCR9hrpUbEZbqbCEsZIbFVR92EVegtH6wZWc6SVjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098641; c=relaxed/simple;
	bh=p6G8BsdYYsTK/FBWlvhZroCS/9WvRglt3fYR83FhCzc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q/NX5YpRFZJsKTnZI4eoFP6BvLmQa1Ua9sZR8ZFg5GYBZuO4KtTgAWm5YBGd6DEYdl23Lz6yfh9yfi9mgCpjlxpTozAtmrnzmE/z/QRQilcN9iUEt+IELOwFLNr42oZ8qCmZupKAKMo8KVLWcCBA+96QxvGFmFROXMmxSGn1xSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOItWvCL; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOItWvCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775098639; x=1806634639;
  h=date:from:to:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=p6G8BsdYYsTK/FBWlvhZroCS/9WvRglt3fYR83FhCzc=;
  b=YOItWvCLcpR2K663NL30IY8QHgvCQcdLYgfihNR20gB3gJET8K+0PCgc
   Ig6hc8x8rMrAlRU0b3gdJU8+FuoDW04insLhBUDPZzsZGeLdhKfVCRbGZ
   raI9JZ189pCLo7tVWdMYcpPmeEfARJuPnZsAIf37XbbrO6XpU1Y3g5a6+
   dfgvxk5UQGJTa9r08quicV0jX49kdd9GLJfWY7TEl2H0XxDB59rz5zXXX
   y1say3nMOkw/lNvHoOO7BrtdP2JjBCVIDrHTB2Np5rjQ3ECSIpwZklxeG
   /v40vq6NXQ3Hup5jOodua09sFWETRHSbm5I47/+h3JugHShOEcPXUEPyl
   Q==;
X-CSE-ConnectionGUID: d11g23d+SU+pvyYFljzP0g==
X-CSE-MsgGUID: aQ0anX8mRcGk+L48GLIJEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="98764729"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="98764729"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 19:57:19 -0700
X-CSE-ConnectionGUID: DeKVLGmkSz6gkzhD2OFBPw==
X-CSE-MsgGUID: xdkqYSJPQL2tVnMbv5ExSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="227108745"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 19:57:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 19:57:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 19:57:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 19:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKX3qy8U6Svt56hK1GJTChsD88MB4MlGF9qI+G8ahbGxELz7w+bPW3Vt/1Qr/d+LzDjyb+asPg5QIQ29kOC4+M+euVJtqcr789bVxanDspxyZLrwCbU0WrYtzTyUGyBFAbtwA3jT3YxX7/kw/EIJDTg0e4zokw6FYxEtynZVda8W5mkDTG+TzUZKcSe55hGvcwDr/uXjCHuspmzPSSZicA9rYh5p4tTVRL7LgrW5THZOLXA1C1xDLzwvKAVM5B3B91yfIdf3hEPEU32NfhTA7wZzxet1Nci5P26wzID7vtvZZg7e2U91tacrwcte0OmDtofzzylyiIYlit58mGXPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDHBOOgwKNTbF4zNhh8lKvJBxUCkDNmH7SZRKsFwrRs=;
 b=lEg3i6YGgzeFMBiXAykW5TkeT1ldF2qpYPPWX9GaFVZfc4/CVPrRGiox2PKaj3wnAwMDmhOmkW5CUTnEeXc//Kxegj0/I/5tkYRdUSC2mhwuBhEMrPPCXmnUfkRw43HOQ4PxqS44LESdCPrKZRpEc5REG+DjwpwrgOmDtrd+2cIzUcijIrLYm2puU5UP3KFRze3CGqigiFAEsgkyzo8ALdMBejniauan9/l3/Ri/OPnjZAdWkH/rpF+pLSoK7tDK5lue8j+NIbIXNxFSwvZ+XNp9Q2pzjyawPHL4vMukDjknQqaXOzFtGiwyOXD7AqAmT2rTll3HaIonV/NR45av5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MN6PR11MB8242.namprd11.prod.outlook.com (2603:10b6:208:474::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 02:57:15 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 02:57:15 +0000
Date: Thu, 2 Apr 2026 10:17:40 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Huang,
 Kai" <kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 17/17] KVM: TDX: Move external page table freeing to TDX
 code
Message-ID: <ac3RxN3bSyGcH0JK@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-18-rick.p.edgecombe@intel.com>
 <acoq94R7F7k/9AV/@yzhao56-desk.sh.intel.com>
 <1e4e63094021e0fc8419bbbe5450abed7f88f06f.camel@intel.com>
 <ac3RZ+Q2KxfbN3Rn@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac3RZ+Q2KxfbN3Rn@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MN6PR11MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: e37921e2-976c-448d-8f6f-08de90638b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 96elCUGE8WNS47cIfBuJvUi0dhzasv0Tj3y7EUf0ELopd9Afuc0ISzrSFPui8n7+Vcp41WCSAiXUV5b2V+cKlZ4/joS5PMPVEALWbNAkYfvKo9H/XuyAQpwXiNa+KUflROso9LVme39dNGm8cpFeQgsfbDH4Jf0ps/+2BI4o8B2EWsOKiEYLXJDsHHstUCOIRXAtM+bVcvjF7W0MFaTZkIYB3lSsDQOiIwh5aHYozygYRw8ggb2CnsOU3Jt2lRI7npfKZekRd7A52VSRSfiqqxjuQtq/drrWAsRMAU9tY5KmvKjSzmEiSwa2OaD9zHEM/vh48Rilza6z1h94q75C7KQfXL9A1JmCtwlPLBVpfK0dWgSsYFaw+zuCiv/jAnFWoBOk1mjaNdsakU7alN8oOWPJ/01FnE2h6MsiFq8UVTGmyS42e/t5pLiX+ZH+vB3iHm2+qhT7Pqp9SD+4JwxTM9/nJJvO41TOfJlRZPLvblW4/3GxhfK7zea5e9yl8btMhpeb+PtM5xhanGryOOXYgeQThZN/3RQtMfjJn5zYlrpWc+sX7nbuMd+3wpQJFarCmwhB9cHArBQV2Fhm/dOX8vHXiLKbXXgRnzX4u66sfKqg9BM0lKg527vZ41ybt7t5ZqU1a9y8/wS4+y6wEWkvFLL2FfxvdV+oVQekv/K5iqoKBCjV/xxfw0bgHPOMG3o8BIOF+lHMh45HT14J5xAu8yyaxj8mE8k5iDEsHUT+pW7L+9cghqAC+yJJbkcrwfnml/W7yhqUuDXG0vl1kYmvMPxpap1VO/TnyjIcbfUd68c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3MFuc+jvSmK3cvVqxJk9A1Jjp9A157DumD3KKCUX63OZ7edvIaFTa0lofl?=
 =?iso-8859-1?Q?JZ03AMCTljkMWVZInK13mbmrwxk7ewEzE4sUt8F0pQkeo3zZ1rZVqG0550?=
 =?iso-8859-1?Q?QxlVkBtrSBwdRIqcATCMoMhfVduVTSFemHeHBdZhoYOgtsRc6bQ1cP1E+s?=
 =?iso-8859-1?Q?LpZBCUBLvGwhf1u+stoUXGrnN8sauhGrGduUTA5dd9ChD+efkJEGsAHBly?=
 =?iso-8859-1?Q?binxmXnK0FPkYU2VxhqmZjZjPZkWed0/QqMS6bSAO17aGF6DGSdChlo9fe?=
 =?iso-8859-1?Q?Zec/VPMu0m8gTBGl8tfHVbW5jCFMm0o78O2AaqA0okFixLAcSEAFNriww3?=
 =?iso-8859-1?Q?dB94rPDqhWpdxk75VTHFDom3RVfu8/Jti3bFLRaxWKJUDFq+cC6eaTwL1E?=
 =?iso-8859-1?Q?HZzNDjQ3yZJSFbtrmztvIRzAZxVbiJ3Uw9ipp2ld9EHLEkVsyugYdNLs/6?=
 =?iso-8859-1?Q?Cb5gyYpK+yoHj19i1wpsypJgR1DiJqJhqEukzSjkix2swPSqCdOMTcND3O?=
 =?iso-8859-1?Q?HYakR2Wi4iADjajgaXCDX0oXMQ4gqn2ZhDvOlnndN3zLywM17s7lBh7Hfn?=
 =?iso-8859-1?Q?MU7S0AeSNS3hEWy86yoyASBib0bDMPXQ0G7Xh0/KeLcRVw47sei3edYH3d?=
 =?iso-8859-1?Q?2vDtutaobIq/U0BIsKLS/dxZ8QcyA6afPp1obJJ3px1+FT7j1o7vomjlSk?=
 =?iso-8859-1?Q?yf3X8RPBtSRMEjBuYwWMAPnE2fP/RR+NVkPddHhtdsgCbT76/EJno+fEyj?=
 =?iso-8859-1?Q?HW/y+s251Z8B1+zUTEy+T75fAJGpHGzQj733vp3z2iEv2atBTSP5nsjdT6?=
 =?iso-8859-1?Q?S8U3rfFnphIQ5Lpqj9BSPN4ttqNu48WswOqI2wK4wm5VTKCRRLawb0E3G8?=
 =?iso-8859-1?Q?a48T9X4ruWVMt0CwlLXC3gG4JqSVh29+rr+l3b5+JjWK+fbejQe9CBy4l1?=
 =?iso-8859-1?Q?41kZmdIF6x+ugMDTIiFABMRb5NycuBturndE8nJvat+VZK5XyjvlrC9eB9?=
 =?iso-8859-1?Q?f5UaBfNCAizBIp2nc59KI0Ib8FJ81tbjl+PKMpzOX+4eIQPpN1W58RkNdA?=
 =?iso-8859-1?Q?+pTh9YNUjdHoOZV3wqH6lOSLET354jo2s0WvPox+LJsGDvIJsuHHGtC+Ky?=
 =?iso-8859-1?Q?1lZVFS+BewKuCdzXstubb1RqvavwLWAuulCrFHVMjwWkNymykH0+J0ylwJ?=
 =?iso-8859-1?Q?2A/DHuvl0WAizC4WyD9OIVxJcVSin6JM4Oug1hOYL8lrRT//bgLduXx4rP?=
 =?iso-8859-1?Q?pwTd0AhBrqtJmxFJdIsm97hEUCH+9a0BsplmQOxRtRd50TppuK/Jv7NoVi?=
 =?iso-8859-1?Q?RBO6nfHJ58NuauovTgwSBR1Xq77LFVIX+KecZ7vg+fkCUMgXYYqx7LGG+K?=
 =?iso-8859-1?Q?Qqoy8yR0QeobD7cjplPkHS1ttt0R1+1g82UVNW31n9MadSCF+LPJvfbyQb?=
 =?iso-8859-1?Q?phOPYRyl+TN8lA0W9abyALPfX+6ImmjoxuBLDcK9r2ZuxcnBpwJz+TvcZa?=
 =?iso-8859-1?Q?l/QdaEvdE0T71ddd5HoLLc1L/ryA6WCW8wgfBYrbhlbQL+RVezdehe5fKq?=
 =?iso-8859-1?Q?0Q8mEPuVU2OcCdNK8Oy/c4Cg+k/8SnKMhiRvOqwWeQfjNxYdqMK+uaKruq?=
 =?iso-8859-1?Q?JOf/n6tdNyDIa/tPrqnYWE4Qx0Ou45aeTiupE3JWbmA5U6N+C29tGOQ3KN?=
 =?iso-8859-1?Q?awjw6vhxBBqeh3jvrTzAl2f1vwrfMxllDdYnJads3geYp9LrF0z+HVjGyZ?=
 =?iso-8859-1?Q?SI8Hb9znnhYRrirEZlWnmA55EVCTSfUlvkFMbAW234fm5CYXBT8lZDqYMZ?=
 =?iso-8859-1?Q?0TxkmFddSQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: C2yZliCk6jI18xO9ZWE8SMK4h1664vIlDlG+7qcJYpSW3MLJBFOgbzPu5FNGuhtsEAzAMmjreeYmw/Sju/tbBfdU2hADK4Wl5LzQuPrVLWfLGTxAwlxn5JWuWOGld6DmLPqieGXX9yiQW20FXfdHUXbYG5w+yvjcw66SBTPSSpa4PyU3CKNHMtzxnm+XBexOwAY2deM2pO/0Yh8O2onQnoBmk865V7BNocfr4+Ag6xfDabBv58v4mzxanMflpnlGFTO49JkaWjZCAz1w8KkhPWHJQlqaxTMnmbQay1tzi/YBY9LrfjrsU7gDWR5EE/x1O+CP9XJEbYDmNgYrSqpU+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: e37921e2-976c-448d-8f6f-08de90638b82
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 02:57:15.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KAccrYYquely62iQ3S+fw5/7A1pNaxID8xZcwCVOg3Y8a85Dz0OdFI+isZucSNE89f6yu/rSf8J/JETAIGx0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8242
X-OriginatorOrg: intel.com

On Thu, Apr 02, 2026 at 10:16:07AM +0800, Yan Zhao wrote:
> On Thu, Apr 02, 2026 at 08:17:19AM +0800, Edgecombe, Rick P wrote:
> > On Mon, 2026-03-30 at 15:49 +0800, Yan Zhao wrote:
> > > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > > > index d064b40a6b31..1346e891ca94 100644
> > > > --- a/arch/x86/kvm/vmx/tdx.c
> > > > +++ b/arch/x86/kvm/vmx/tdx.c
> > > > @@ -1782,7 +1782,16 @@ static void tdx_sept_free_private_spt(struct kvm
> > > > *kvm, gfn_t gfn,
> > > >   	 */
> > > >   	if (KVM_BUG_ON(is_hkid_assigned(to_kvm_tdx(kvm)), kvm) ||
> > > >   	    tdx_reclaim_page(virt_to_page(sp->external_spt)))
> > > > -		sp->external_spt = NULL;
> > > > +		goto out;
> > > > +
> > > > +	/*
> > > > +	 * Immediately free the S-EPT page as the TDX subsystem doesn't
> > > > support
> > > > +	 * freeing pages from RCU callbacks, and more importantly because
> > > > +	 * TDH.PHYMEM.PAGE.RECLAIM ensures there are no outstanding
> > > > readers.
> > > > +	 */
> > > > +	free_page((unsigned long)sp->external_spt);
> > > Since sp->external_spt is allocated in kvm_mmu_alloc_external_spt() in a
> > > similar
> > > way as sp->spt in tdp_mmu_alloc_sp(), why bother making freeing of
> > > sp->external_spt special? i.e., what's the downside of freeing it together
> > > with
> > > sp->spt in tdp_mmu_free_sp() ?
> > 
> > I agree it's questionable as a cleanup. The change originally came from your
> > comment here actually:
> > https://lore.kernel.org/kvm/aYW5CbUvZrLogsWF@yzhao56-desk.sh.intel.com/
> > 
> > So for a more concrete DPAMT reason. That said I agree the reasoning as a stand
> > alone cleanup is pretty weak. I tried to put a brave face on it.
> > 
> > We have to think if we should try to include it in the initial set or include it
> > with the later DPAMT parts. I thought to try at least to do it earlier and leave
> > it at the end. It also kind of helps to see more of the overhaul together.
> > Thoughts?
> However, even with DPAMT, sp->external_sp is also allocated via
> kvm_mmu_alloc_external_spt().
> 
> static inline void kvm_mmu_alloc_external_spt(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
> {
>         /*
>          * external_spt is allocated for TDX module to hold private EPT mappings,
>          * TDX module will initialize the page by itself.
>          * Therefore, KVM does not need to initialize or access external_spt.
>          * KVM only interacts with sp->spt for private EPT operations.
>          */
>         sp->external_spt = kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_external_spt_cache);
> }
> 
> i.e., sp->external_spt is allocated with no difference from sp->spt.
> So, I'm not sure why we have to free it differently.
> What's the benefit of keeping the memory for a little longer than freeing it
Typo: what's the downside

> immediately after TDX RECLAIM?
> 
> Or are you planning to allocate sp->external_spt via a TDX hook?
> 
