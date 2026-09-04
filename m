Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904341C2F2;
	Fri,  4 Sep 2026 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504559; cv=fail; b=gBvUnX5ZovHtbNjcEWYOSPGOPRCTeLmMqYeEfT7mrFLfa75KTimpU10La9G7d45MD5ZZ4bifXMgRuDxnna2NqlSsiw23XK7CaZmC14MQqOJsmo4VGanMrSFK30K/VVM7oUvCAyOH2MYbYqpBo/y5u04YKC7XGMcuiaS/F6O2a5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504559; c=relaxed/simple;
	bh=6czAudH36bLqVh7uA+lVNSUMJwyppKVMcPK28s92dqA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IeXCzZuJry5KA/Rw7JwOfvAw/1AyBUlgya28fshIPjcdXIjMnggr3zzi/fewmSYPxTxKOM5Y2pIkx/aSDaZArxa9XD2jkTVccRiArwCJqWXST/y1izKqZKDeFUVkc3dCY/i9JkWsROD1cyxMe4buSTUnjGLA0RUbGmZpP77TSK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVFBZ69i; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVFBZ69i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788504557; x=1820040557;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6czAudH36bLqVh7uA+lVNSUMJwyppKVMcPK28s92dqA=;
  b=RVFBZ69iTaLBx4Tgp1VHb0UOo9MaqThhCFTQjzleXMNx9RrIBVWEldVB
   TUi3jR81wKkqO+BVb5EbtPlUyL/klCVGcqRFZdFQ6sgx0R+lT2ErxD7o3
   BNGcb70DRePcKRHNvbBh7qEZd9CofaLJ0vgLhSi3EocZ5FDsFaNDNeEmI
   OBNMqrPHm6gIL5aGTjVfDYz9kgeYeEXTrV4J+Qw1ePlw+UEgpJz6VsFTy
   FSrTPqACvi+ViThJeOwDTeU1hXjPCQ6U2ndYurfPzdLTaDM5z6W+Bj6b1
   Sbb9L7w+ZdsJZwYgpqX6xQgAbrw8fuibhgZW42mK2u2Imx5/O9hIANaux
   Q==;
X-CSE-ConnectionGUID: LokbpNIjT4CAaeixN3py1w==
X-CSE-MsgGUID: GyBAxI0PTbCqXp8sYs+Drg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="99597450"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="99597450"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:49:10 -0700
X-CSE-ConnectionGUID: yswecPpuSNm2sWoboNiFgg==
X-CSE-MsgGUID: o20YMaHrSmy6EoEqQYPP3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="270488600"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:49:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 23:49:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 23:49:09 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 23:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdZq1ypJgHDf26Hd7VMwqi5sEiMfjIcXQU/pQXSEXjJ49J+azUK2hhYyQx1JjdH3sFlAfHSoqC/sY/iPvbR08R/w2gw1snjxurFLaG7vZhmW6qSMa7+Y4Riv5RxxLB9kJAWdFuA4pZL3U7Poj9K48lb1weQVB43hTi30Q7xmximqK2NuHfJHgjHukKj2fxTI8RSmK+l8m5uvtfgtjtdEmvysX+S1wDQFunGv1DSlQbU478A4fipEUkfLrIXnOeE+pFaau3GcCBMvuEAEYzAJu1V6y6lXEw3TEM5vApAJ2ox/iEnLG+1qnhAJIIKZA7I2Yd/q6gSy+puT03DYM4uxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjD37WdD+80GVv+yO4ei+Y1KbhbC1BKRPTiOoEkAFWs=;
 b=H7BGg3ndDsWcDyijyrc+rfluxabWHgQQ48pqCwwYsWn0YcQHG8z+tlmbqATE32x65CC76cpQh4m62WMVL8YqVl5rIDhsi0BDwjJDwiDHdQk94Q3SjrX5mNL/vZ/VL8Iy76BrBpl56c2KbrQPezhpHGSY1j/rO1hPQmRKyrEFfK/Fpk+Ysxo9E0VPhVfXvRwdZAEKRxS/hM11S9UcnFfCggtQWa4LFHlVHmbkSzEqo5skwoJXWcdXa7i//KVUTX/afHv+1B/NpakVD/7fw88Tfy6S2kdprpSXmE37yZp/h8p69R+thqz64++hKaOWd8ta4CNsgKOPVjJPZWnupBp/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by MW3PR11MB4681.namprd11.prod.outlook.com
 (2603:10b6:303:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 06:49:06 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 06:49:06 +0000
Date: Thu, 3 Sep 2026 23:49:03 -0700
From: Peter Fang <peter.fang@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <appp3yiDbYsekIzP@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
 <75441677-635e-4a2b-8e11-f5e70a1433a5@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <75441677-635e-4a2b-8e11-f5e70a1433a5@linux.intel.com>
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|MW3PR11MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec2be1e-a02c-4ec1-8f39-08df0a509d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ocNFv5I4Ouy+m95qg841I2wzLQ+O9hWFNl0qJmAE1iefAXeMtrg+TRKN0QxEf7CHf/wkJSbb2mrS+XqQ3RWQBFzcJYkP2waz2Jd9Gq+k4IEIM5a2tFHqAcHmUPTfzltsWrswWlJ54It5sDIVhsQd6iS3a6tqvoOgXwYdkYepB2FlttjZKGhqc9CwlufpQa92ASuTMoa3lr/zXlXQ/PbLh2PXFz6qSGqwgaeMR1WycRVqOdoAxUPnNebFqAT98Rj/+ytndw6Dq5VwrFC09hwmU8dm5zaKO4dPIQ8lNGqV5diQcMBRleTt8BUbbmurYkFCvtRHJ0XbQmbPg+PGSQkl8b6VtvdgCja14vhsdW26/PRxkmmxkJXHPJptWZziTGXHSgj4Ea/puCVE6J88b9oHCj0GORygKZQrJVBLmR0E1kwcHDiOjRztYGVUtZqmqrHt3IfC0QjYFvy6MVs4eztgypMZ6PVgmwA0FSia6N3/fAY2j9o/Cxfrk40SAO+uMuyJ1ytT+hul8lhzAFtUK6JKB0UwkFtS7GKJ+1kTR7Vpu9mfscoJ29/Zh4jqn5MtQgbzyo8j6CRogrSEJrcPs95Tjd3VIzMtW6bqC6995Q2RFVNdqyNKcRsg7xzGIZBG2D06CTIleMVsd4ruekUmRCvjmmPVRMUXyzmsnpeelDGfJd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EHs8LK2U5pODD6HFYdPbezbyTMWV7cZE0SHIsT9YL0cekl5TKgxkB2AoqJd0?=
 =?us-ascii?Q?CeTCJBB8bI+L32xE/RKCE9RxIGqoCV0iL81+WywFhn6I0DizqFumRy5oGH6W?=
 =?us-ascii?Q?sgzr/PeAGByephW+D/OFMzKYIxzgJ5Wo8f+Ih4vumcb0H3E638zcWxi38Htx?=
 =?us-ascii?Q?69MGwiFOsDPXcju8+ZyJK7b8fFhqL9GchewTOHGyfSpXVVLAMyyn3i8rSalc?=
 =?us-ascii?Q?SdiCHTKGbJAEZhEU7zKHj5DD4PsGBXhw2d8afxI2pzV/N/R4xR6e673xHutm?=
 =?us-ascii?Q?/abDUeQw+smuQGcI8iWJrvFMEpg1iziUutZ++8vNYCn/K44U950f1E7C+j3T?=
 =?us-ascii?Q?+d/ZrABf7aB+baMbjJNFDgFlgW1Hh7HjU3uScLK4zSwnKs25PZ8bfeGuDSwh?=
 =?us-ascii?Q?hbVPP3PcjwVIfJAN8iMw+NzhpXnwkmI/36Riw7TFNZtMBg2n40GTolKm2Upm?=
 =?us-ascii?Q?jzIP8vZV8wLIzvYC9enxh6eUYIgiQc1PNVWCZfL1ENOVqma8QHga9n6H0tIf?=
 =?us-ascii?Q?kcS0If0ccxLiJlKKErznoBrI7/j7u9po3ut8EPlP1HszGNRHvLthR0PUpxVF?=
 =?us-ascii?Q?TyPwThQfm4VDI6yfRgA3iYmMczzGpsAkUIRnk0RVstyIsXzpiog7u1tYofr2?=
 =?us-ascii?Q?4RsIsks9Ns9taKvMaAfGk420H+rJeuZ3cJVunbWJ1L3jMsyBd1e1jvk4jjXB?=
 =?us-ascii?Q?knMCMJ4NkCpUVyHovOMVxsNnaIRm9SA2tg7dHGUlu9eYB9jo3opJL+c/EZYY?=
 =?us-ascii?Q?6JgGS82SLFRmGltSFfGAz18oQIhCWSbXNr8y83jJSoxgD+otRBjWy8RK8Wd4?=
 =?us-ascii?Q?+dXdllpMAg/EdIkIa0sJ8W4GD+MKg3+q1AdJyJEOFus0ECg4rPLmP/c0XHV0?=
 =?us-ascii?Q?tO91y5jwyQEUl8h/fB8KwW1abvROrXwKH7/oC/2esx7R1bMB4RzlEJsjjYoc?=
 =?us-ascii?Q?/wRSU0Z9RoCfK3bsZeTnJ5WewoEy5vumxtzZRQIwXvT4tBARxtZxS63uSASn?=
 =?us-ascii?Q?MQ2GmYtPgnd73qiDHoHfE6Gw2c/PZ9UneokGeYKY3prvQ2ajD+0cGnNPEaa5?=
 =?us-ascii?Q?HQ7gyoEN7OBvOAWnqtPNw647vLSJrTaUyCPY6+0Af20xzL1VwykeT4xF7rZO?=
 =?us-ascii?Q?R2GogmVqxuf2veFeXRKSPrPLc+AEY5qLfWQn9z0ZPdIbtU0xxlyKfK/N7x88?=
 =?us-ascii?Q?dP54xsRu7vZQkY4ogZb+Ub6wgMdTW01/n2OKLbIpyy1jHqjTyW/pcLR7raex?=
 =?us-ascii?Q?7fbAWKYAGOweXaEiMxHz5aZkJBYMJNQ4xDX4ExirIx7ACBY3EwoPUtRqMgwq?=
 =?us-ascii?Q?71f4YMc1iy1evb1fqpkH09tRY0OgyWrnkK4cf8vA6o23f9FeBjSMuAZXMWVp?=
 =?us-ascii?Q?HUbw7SPd8oKs0IFVnOW9gaOq6EmgguJrVFb763x7mur49fjxSbQXU42NNnLT?=
 =?us-ascii?Q?3Ilc81qQbw67dVFigMxBGX6ab6OcL9Z5LuC1mp7/rKmrYh7r8x8KNKhyMMeV?=
 =?us-ascii?Q?ziILkILXTc74cdFygthymdwB4ngot0LnrO+vZ2SWWAXGxa8QdGAgu5a8kLHs?=
 =?us-ascii?Q?vkM5pVcZXnBoilH3PvRjqHVAdkz5CZ/N2xs0hiND11m43EfSKmubgMofqTVz?=
 =?us-ascii?Q?OpUkNsEYonQgJrijjl/89NKtouH/SUAWD6CmLEUExfd+S22bg0ZaIvl7E4my?=
 =?us-ascii?Q?bsWljJtnMfp9NQvLhsHP1ZoYUYHtj3sYFYfL7gR40KquTTlRQX1O3x/NRIwQ?=
 =?us-ascii?Q?JQYXSM0EYQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: HfwVSBYXcFIJZScSKeOnUDyyf6wznKE3E3KDV70a3QaJCaRGEfWZMNaLfgzu1277fkBfDPK7mfrzWWR/dJueE0qRLu4IyPfqga/AKkPVTe590GiFHofEMlX1c5f6eOU/h3uNn9Wd4ZoZ2+2eJt3BLnFNtsliBOPXbSwRIIJf+JBWn2Eu63h3YI3sK7SvZYgCIGEjuLyTYwIDb+yQIVElDTGSzfgXnoISW1v1pY4TVsTAX0wK+h8Mi65BwMO39D9HsNVM7L6/CnGes4fxQQGLW5ueT1b0lWHG9V/tqXtd7RkFxjRnuATSIdo5qH3EWvydBs/GWJrDjl9JmBipT8gdyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec2be1e-a02c-4ec1-8f39-08df0a509d59
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 06:49:06.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cieWAtenmHuPfuMmPpCahI4brey6VfqItPrfahP8qTBmRlspI0l+Oh8een8GP7O14pxh8WVzhDlObOw39Zipjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com

On Thu, Sep 03, 2026 at 05:17:02PM +0800, Binbin Wu wrote:
> On 7/29/2026 8:29 PM, Peter Fang wrote:
> > In preparation for dynamic Quote buffer sizes, replace the fixed size
> > constant with a variable.
> > 
> > The size is currently a constant sprinkled across several places. Store
> > it in a variable and have all the users read it from there.
> > 
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Thanks Binbin!

> 
> > @@ -191,8 +191,9 @@ struct tdx_quote_buf {
> >  	u8 data[];
> >  };
> >  
> > -/* Quote data buffer */
> > +/* Quote data buffer and length */
> >  static void *quote_data;
> > +static size_t quote_data_len;
> 
> Nit:
> The existing code is using "quote_data", it's natural to follow the style.
> I personally feel the var names are a bit ambiguous on whether it's the full
> quote buffer or just the data part.

Yeah I agree... How about I change it to:

  static struct tdx_quote_buf *quote_buf;

This way it's explicitly typed, and should work better with functions
like alloc_quote_buf() and free_quote_buf()?
