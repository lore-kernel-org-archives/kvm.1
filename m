Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6A3D1705
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383108; cv=fail; b=ppgH9FxUVCPeloZvY0pvRXcDGWIJj1FOqgjgBdP6YT6/HGPjC/YC3FxDlSD26+Aw/JQIPrpAmlJbEimw9fFrYlt2rVoxWdYIY3Wo+wXcE5JC6fvin1K17hIlUtwzQQgPcIkBEtQeU5c+8uZWzk/B+LsEXHY6IdyD352gGGLw77o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383108; c=relaxed/simple;
	bh=c6kjhbi7m1N0XEIx2mc0qj13jd7ZrihfJ9+DZkjkOxE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j+cG5kIYguxjnRAgXEWVHIbSj+k/C0ZshLnwBQ0V86FuKkGcnA7whfb057XkTmOySxPvwYR2vlh5qQFL7R98neU5bAOUSMAKr2D4Q4rcYrA0GUMDDU03NPacjl8yEStxDSkIG1of37ZvFKzrxP/hf/RPIBk/umtiNWsuFQH3mBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FoxXEZzm; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FoxXEZzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782383107; x=1813919107;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=c6kjhbi7m1N0XEIx2mc0qj13jd7ZrihfJ9+DZkjkOxE=;
  b=FoxXEZzmHajvIohxx1KRhgqVRZklOMvP3zYy52F9d9j2cJVMy3n1lxO6
   YvHCc7exyihOaFUeC8dLh0duf0D3LHsIn2o6dqzxDHBHieS8dPYG/TfZz
   0bNzOcBmvYMEkAGDoRUuNTS0uvm3UFr4FZYBLEwRgWpwfYyPf35XSrqwP
   e/xa5xiUJsDzbH+ah0xk8DAZ5OiSZPEcb95Esfbb2yQulcf1RpzbHjtfn
   wiNeJj2OdUlE8JN9Wy0LsET9dZhooqErmgeF3koMfuTDN3/iAtnZeT3Vj
   m2Z3cwJW5zzhMOF+5lxbE/85b5nIKAzRjMEEEYCUpWVcxElUo3B0eQVCH
   A==;
X-CSE-ConnectionGUID: Fj98LXB7R7Kn4bKC6XH4+g==
X-CSE-MsgGUID: qPGOCp/aSwu0RBWHOaELOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83162216"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83162216"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:25:06 -0700
X-CSE-ConnectionGUID: npeFqrLUQ5e+O7dn9mh5XA==
X-CSE-MsgGUID: u1jGjX7wRUallUTqMl+4Hw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:25:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:25:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 03:25:05 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2R1KYMCE0FfAokQXs+UsRKpJZWUvhqgTnlqL90fK4O6xbjvb0kryWFWDQhvnBv7RIx4LrJEPJWyZPiWCBRs4bnkksDj9l5o+851hxwHowF2w8pBGs6LAo5+Pnc6CDZzgLz0m71a1Duu0vGrtVJ8g8uyxi+Uhvk+HGX2muC8eosXjbJzRqGDtLvY+vyYuPa/B4DiIh5GWIvLOXYV1DQrhDO9zEVP0mDVvWzGLnQAQyTGKTQFBcqklCdolMaBYq+dR62rysFUkI04LxohXluJ7IA6EiOpKttl3HDyDuvxXVc8VxVdHah14UFL0RcklyLoF8CyGamyVjo7vBAWkEH+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yd7L1ZueNkG9CC2KzJzwOrj47XxKtZ7nPX3vjo/zbmc=;
 b=q0DQeEBVFSnx0y7gK7w+GmsRfLoPGVzqjlX7RwMegRAk3JGWObh2K1njajcujqAxpAi8+oRs5x7tOr5mdzwOqOL2lgwybqd0p4Ta76QvUDDYGKBtx/2CBk7kH3PXh1XeFVZwaPdEmW02qae8y4DArJYrh82ZlB4dtInzrAk1NgEv00jHVtTnrzc0arvAMAJdOHYqq/3JLdcqYKWZTKwV3KpiXjMSyPRbFhDqyvg3kYJw9bDdSeF6n2tmFQ1NXZ5FNA5oBQc0layOXQ6ke0BRw7xuTLkVEmibkPb/oJtvURg6pXofgoJMv9jJy5HEJCwbK1anWjOn+BW71vmKFDXUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 10:24:55 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 10:24:54 +0000
Date: Thu, 25 Jun 2026 03:24:29 -0700
From: Peter Fang <peter.fang@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 07/17] x86/virt/tdx: Initialize Quoting extension
Message-ID: <20260625102429.GA1600180@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-8-yilun.xu@linux.intel.com>
 <20260618085017.0EE151F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618085017.0EE151F000E9@smtp.kernel.org>
X-ClientProxiedBy: BY1P220CA0046.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::8) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1f2d6c-bb92-4b34-dfd9-08ded2a3ffd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: q9j2ZJqb/1/pgmsYfxKi4AD81NgZhP8R20Ep2Ro9saWRduFqKzitlTqpWiJuO8x4xJTyEtYpkqqRiMLDS5osfdgaKGkOViyDYI6LHgaPfi6f16gg38IzaUDK6K76ViGFpjkKF52qwvXXOXxRFoeQj9Sueoz8ipIkOc9ei0zPT1Buf0cFLWObMY3epAUiiRokSFxxLpGTKk7tQxDWLEHaFH0mddeA5IkPtPUwWFtkFZR920rGrQ9MGAwavJrA1HBgc5xcAuhzBuoUQIwwtiN4mc+5RQofoNwGsCCuYYxENyqJcF6S4XucjKNFEXLjKac+GTWYbjX18rZEeUsBCIvuwL/5TIxSRLKVpB+m9fy5fJbGYGEkLLEB5DNLYcRI32OdPDsYkKUqaL8ISMRSHhZst75ADULKQ2Aks1JUt+JycN4iTAADf4f9Si5X2Tt7JhYYzuEgH5/spg4OintWGYtuzjP15++zx8h2uXtNhljauu4X7VdvL5xOdWtSgLv5SCPzt9Ir5iS5Adi5MTcKgxrv+3foZsC/0tY7CSfcpb/ky1Tc/9AImw/UtDWH1It0HFeztXEXhcKn4wOtdYGTyevi6DKBNl4B6f09csB97xPcSoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXNlY3hWVDJTaDhvcDFZaEc4cUdvdzFDdFd5eTY1cysyQW9uTWZwdkxUWW44?=
 =?utf-8?B?TUZPY3JWWit5TmtZZ0wrcDJacnNkM08wZFpLamZ5UVJRbW5mSXQwTCtFSCtz?=
 =?utf-8?B?emdwLzNub29Mby9yV2FsbWJzRVFOcnZydmlyaUxwbmdlMVNJaXlURVNqNk5T?=
 =?utf-8?B?bG02Q2NoWGJDZG5lcDJUUVN3OVp5TmM3U0k4b012TllpNkFpaVFEZXpQWGhU?=
 =?utf-8?B?T0NkYVk0Q3EzdWVvTlhwR1c3SmR0dnM1bHRML01CUnVyMzB4U1plRFhUSk90?=
 =?utf-8?B?TUpONFpYMDlmQ0Q5R0hkUlFTOVVEUFc0amJwVWJOUFhqTXVRVTdpVjMrSGV2?=
 =?utf-8?B?ZVVXTGN1Tk5PaTZURnNzRXlkNWlScUFYZGxoajgySWJFZ2lRK2lSNzVTdUQ0?=
 =?utf-8?B?WXJDVWs2S2Fsd1RLMVQ2c0FNekRBUlVrdFdUMjAzdGdONStWSlRibzkxNHBE?=
 =?utf-8?B?b2U0Y2hnVkEyeFhCNVVGdkpkeDBzMGVuYUxxdHRWd0xzUE5CZzhhNVQrYnZZ?=
 =?utf-8?B?ZThnRnpMOGZhZGFySmw3ekhqcVdMdllSTTNtZENmK3pjcC84UlV4NjU0Zi9k?=
 =?utf-8?B?QmE1WG5BYzNWWVpVUm9KLzFEelR4RG82Nkk0ZWo5dzJodTJKdTRRMHhHRmlI?=
 =?utf-8?B?ZFlYd1AzSjQwSmJkbTk0THVKcDV5REZpR3dKbUFIaHU4QnFLTjl3aFNob05L?=
 =?utf-8?B?MWV4YzlEOGxzOCsvams1dEh6ekQzYVN2YXY0cW9menBNN3JReUx4QlM2alVP?=
 =?utf-8?B?anBhYXNYczlhb0U2Qjc1UXB6WWpxT1pkc1FHM0NlSTlPampaaGs5M0RtZ09D?=
 =?utf-8?B?UDcrc2JMTjZKc25lcUwwN1hqdEtMOElGWDN0NUJVOHdyN2VPbmlUdzh5TlN4?=
 =?utf-8?B?TWlkbnlZazB0OFpXajdja2diTlExN255MGxaQjRGT2dFMjlmOVdwZjRjT0VL?=
 =?utf-8?B?WjRwcmtGaWV0UU9RV1ErS2RWZ2lDQXhuSjVzSXAyTmpWVlZUSTE4ZGZUdlB2?=
 =?utf-8?B?U25uRVc0NTBHNFlhc0VpN0pHVmZkVFJwY0YzcjJzK0ZFcFVYQjkwSzFia1VY?=
 =?utf-8?B?MzVRRGdrLzhDQWlKZCtNdGRaS0EraEE1WGxkQnFJOUI4R1Y5aXFvdTE0NUZk?=
 =?utf-8?B?K014Z3hYdnR3Q29Rd0Y1RFRTTXBPNjRZTG4zVHdIVnZqRlNPbjJDdW9TVzRI?=
 =?utf-8?B?aDkwUjVmZHY4aTVjSnRyeEZCcjR5WmN4WjljL3UxM3lHTTQ2ZXJSOTFYYmxM?=
 =?utf-8?B?bnhaKzd1K01kR2VWQjVJVmFZb085bE5ya0RROXBkM1BuVit0MHpZcFJtdm5U?=
 =?utf-8?B?S0VUUXNRQW9Db3NTQ2RUdndKSmRYczdPam9aTmZ1emxlQ01rVkdvMXZIelZm?=
 =?utf-8?B?czQwdDgxT1prZGJNa0ltRmtGMnpqTWg3dktrb0thaHNUMENXcHVlK2tCYS9Z?=
 =?utf-8?B?Rnd6MmIrR0I0VTlMd01ic0toUGUrNWg5VVpMckcxYmR2RFB5d2xjQjdjZW1T?=
 =?utf-8?B?NEc3M1dsdmdmRVFmQ2FqYUhUNWNORE8vdlBXek03enJyUlRRdjU0TmN0OVRi?=
 =?utf-8?B?MUMxbi9pOGpzNFBRODNmNWR1Uis1Z3Z1bDhiSjBXSTlKQzJ4RHZNSWZXRU11?=
 =?utf-8?B?Uk14WDUrL2hiVkJGem4yVGRaTWQvb0VYb3FMTHE0eWxHdFNqSkt5TDA1bTFU?=
 =?utf-8?B?TllMbTQvSDI3ajVwSmZYVCtHV01rRkR2SVBDUjVpYjJCem14TEtXM3RETldr?=
 =?utf-8?B?aUxvd0pWaVM3M2dXa3ozUFdReitkaWxkeHU2cWE2d2FTRXVNaGtqazlWZUVN?=
 =?utf-8?B?RHJKc3laVUdPbUNkTnNEN0dEWWh5RDFIeGFzNWJQaHR5bitXVUZ1TTFndGJX?=
 =?utf-8?B?RkJibm5MdG1TU2RCWVM0RnRsN0lpd3REdkZaMERrU3BqZEZ6b1NrNlNLV0Jm?=
 =?utf-8?B?S2t4QUpoZmlZbUFLcUhXWHEwOGwvb253VUNPWjdWWjlMakR5RmQ2MENrSGFH?=
 =?utf-8?B?R3FrWEM2eDVsVUprMFpBakpJc2xMdW1sd0RvdTloUzNxeU9qcGFJQ2ZreHhq?=
 =?utf-8?B?N0lmcEdRYitaUUt2U2FqVVJlZ0Y4QzhwTU9paENudW9XS3pJTC85a1hlSkph?=
 =?utf-8?B?RHljV3BjeEx5cUl1VlhVMDlrQTV0LzRsc3lTaUxFa2JvSXN1TkpEcU1wd01B?=
 =?utf-8?B?YkN6TlFYWU42YjR4U1BrOXZheVlwTWZHakliRW1wNUxYRVpYaVlMakgwK2dP?=
 =?utf-8?B?TUVUc2IyMmhYaldmOS80RHdhRmo5Zm9uQkNMMGZsUVJOOVNSRDFaano1MEY2?=
 =?utf-8?B?Wjh1djZGV05VZlUydDZJZVJlNDFFK3lhYnl5ZkNsNU94Z0JCVE56UT09?=
X-Exchange-RoutingPolicyChecked: WHVVEVAzQPPej+RnbQGo4VUFU6ev6FV2T84y780Ce3JXhcSleIC3oRVc1wv6YrKEz+i26VYWtCn1l2J+DJ9XbvbSkmpy6jd8H3s6iAWlxiuYyl66b7WU1rKCwDVk4DI3rdFRrhlcUJze3X1k6BPOIPARn2E86mfFoAy8A4YwByLvpci/ZI7ukCXgbHrRHU7bDTEGiYl1zRV3vkhYxgixvGG891QHViutRu+70hIFH4DDtefGUzs0wg8DHsrW69UqjlTkLjW+SGRa583Odf20mFGf+Z6LfQtvOtrj7S8JzFbVmChe5uUxwqogeS4vjS5nqrGHS7R5kiHV2gzNskBYPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1f2d6c-bb92-4b34-dfd9-08ded2a3ffd2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:24:54.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jQQ1hJja8KG1/vFgpKTvrY+ZKVYQmgsA13KAv1B4/DwzQBX7df2M9DMRfqmbK7J5dLUV0WeoQQtQpn1J1w5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com

On Thu, Jun 18, 2026 at 08:50:16AM +0000, sashiko-bot@kernel.org wrote:
> 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 4d2940f4538a2..06c42b86b05e8 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> [ ... ]
> > +/* Initialize quoting extension */
> > +static __init int tdx_quote_init(void)
> > +{
> > +	struct tdx_module_args args = {};
> > +	u64 r;
> > +
> > +	do {
> > +		r = seamcall(TDH_QUOTE_INIT, &args);
> > +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> > +
> > +	if (r != TDX_SUCCESS)
> > +		return -EFAULT;
> 
> [Severity: High]
> Does this discard the actual SEAMCALL error code? By returning -EFAULT
> here, the specific hardware error information from TDH_QUOTE_INIT is lost,
> which might make debugging initialization failures difficult.

Yilun did a pretty decent analysis of this in [1]. There really isn't
much the host can do if this fails, so it seems like a reasonable
tradeoff to just make sure there's a record of this in the kernel log.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static __init void init_tdx_quoting_extension(void)
> > +{
> > +	int ret;
> > +
> > +	if (tdx_addon_feature0 & TDX_FEATURES0_QUOTE) {
> > +		ret = tdx_quote_init();
> > +		WARN_ON_ONCE(ret);
> 
> [Severity: High]
> The commit message explicitly states that quoting is an optional feature
> and initialization failures shouldn't cause TDX bringup to fail.
> 
> Is WARN_ON_ONCE() too aggressive here? On systems configured with
> panic_on_warn=1 (which is common in many environments), this will
> trigger a kernel panic instead of gracefully falling back to the
> userspace flow.

Having a splat here is to draw the user's attention. Patch 13 sets the
TDX_FEATURES0_QUOTE bit only if the TDX module reports support for it.
Advertising such support but then failing to initialize it is very
likely a TDX module bug. Since attestation is pretty important to TDX
security, I think using WARN_ON_ONCE() here should be okay, and the
backtrace should be enough to describe the failure.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260618081355.3253581-1-yilun.xu@linux.intel.com?part=7
> 

[1] https://lore.kernel.org/kvm/ajq8RFjv2YFghvQp@yilunxu-OptiPlex-7050/
