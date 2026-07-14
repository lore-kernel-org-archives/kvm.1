Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C02275B1A;
	Tue, 14 Jul 2026 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010309; cv=fail; b=WcVC6ulW1aHk48OoeDjmO3HJHoJEq+YIgXohEpGUa2jn3DB3rMXGWcvYurW2Yb1d7wDlI7BBMrkV6/7c+8IP92oimvPTrO4BpD8+Iq/Ui8W0xh6DdN6TlYXhBMH3C6ibaEwUVrfE5Tp+4TGJi13aknb7aaHrgU+GsWrU38jIzmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010309; c=relaxed/simple;
	bh=JVQoJOK4t5AftQ0eBDzE0UhIbn6lSJuiiDzBmKy7x90=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TCVP5xjyEzpa3UMcE3acK8TJVWY5JW3O1GbJDChIbIu4FO5jHXl9paQmcu9SHR358fHF8mr5nJHWwCC3Ang8kf1FRs3A1Wom0kIKjwvYIbARFaS+7Tu7caLpZbGw9PAmbZw9BhDrjtD5U96eAWQce23Q4jMbgMcujYGpQrJRMVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFwGhCIr; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFwGhCIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784010307; x=1815546307;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JVQoJOK4t5AftQ0eBDzE0UhIbn6lSJuiiDzBmKy7x90=;
  b=aFwGhCIrTfE+Im7FAl6cPDLowRqXSTrL3QRrEF6+pKnlUylhZz+TpCwv
   D3rZ51VDP/MmB02Wv9fx08jyaw8/svYa1+daP1J3hkj56BGP3diNJi95u
   MLbItERtx+QU1UMdTUrGl+GdcAl7QZZKwG/WOw5b+hUqvym5huwQcFm+8
   raCe5m+tZu2LjJQ3HKB9FxqLybxRILTsBBd4Mxog0ZzD8eXqv5mGIWHpi
   KalaJUCGm1pDV2M5FVDNxBQKs41BwLmX2zi+EEQU1CH0HKhNFN2M7k0ek
   dsI7Qdwpmm91X4TEdJud1QBlEQfpBTtXPe4co2gwZWK38KIeHMJuTk6GJ
   Q==;
X-CSE-ConnectionGUID: rs9ywoYkSpmENSK453CbPw==
X-CSE-MsgGUID: 3DxNH7VrQ9WJPvwhRrUbUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84720319"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84720319"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 23:25:07 -0700
X-CSE-ConnectionGUID: 5dBgq9bZTvCcjgOPG/r7fg==
X-CSE-MsgGUID: QC5ZT+t+S+GqsJPjNf25RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255817240"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 23:25:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 23:25:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 23:25:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 23:25:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZR47oeHHiBCkbcoHjvlDAC/vrozk7Ib/EedpQpL8D2U8V0RSSHfKrZvoXSL/OUFg3ojVhsy2CG0iOyawCN9ERUgoDT+ec58hPlSNgdCsm8t62hsLVGzzrsJGsulUriHExoaThlNAoXmOYTp37tZxJol26jMacWJhMpc2tetxXHD0cTVtmrZLzFVLxh+HuiR8BrgkaoTjSYZnt/KcfQ17lNy982M82Z85JRM7k/czS6Q3yD4hWRCVYqtelNuFdbMFw1UV+EZUCdOCm/o46VvfpXwGs8ezbMgwCamBQaeo/2xztl0oDPl6VOAtpEUflAkudoh9eoXpSFZBFx4Pt+Puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM3apoxsGw1/J3VRllYQf3mpu3wgxRYlHeOTW+ydW8c=;
 b=URpLfOWLLpt9w1bR/pJpU6ZfkSZ58IJTPG/D7Hyr/TAkQSrMFEvxmkNqd8Lddse8SuTlpmZKLY2naxXdU+1U62drymK7uhWgFk/e+lOpWfQ1DWMmGsbqi91ohYzQm50OjZycyHHmOlNzfsoqaWsGQPX8ZYQJgLmAjPK0roaTux7WX50VqTH1S8t3dv0gX//OkJay4l0OUhejaibc1C4QR/vEHGjJkPmiMXYWXRX0XYrP1APKDPcMUJPMGs4c/4ibQUcsvkYR6wRVDa/uccAcD6JpRQJ+rAK0EzGFRGmldDzPJlBAmsA/tsatAp1+7qQn1XJ764u7WFRhAlFewhVnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DS7PR11MB7783.namprd11.prod.outlook.com (2603:10b6:8:e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 06:25:03 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 06:25:03 +0000
Date: Mon, 13 Jul 2026 23:25:02 -0700
From: Peter Fang <peter.fang@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <20260714062502.GE3178326@pedri>
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-3-peter.fang@intel.com>
 <283d7cc7-e87e-4d4e-b1d9-ae19725e1606@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <283d7cc7-e87e-4d4e-b1d9-ae19725e1606@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::29) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DS7PR11MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3458cd-08ae-4a9a-27bc-08dee170a3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qDAfe00MVQjHCztE5pvtZikARiY0ns7bYxYvPb0SlFE+jxB3OJAtGrfxrpjzSMWr3pahoxfpBiM+7rMlAJlPlmvA5EQy9qBFnngABwXo09X3rdJ3TngDK8kUvEgpTBfzaf6/DczTv5CJ/8Mm96+gcujY0CBKqQB7eDL7ZwHe/HkYRVI1Li33tfd1TpODMC23ZcbS4QtH0sdYXe33EM/GA2gRxCKApJIuyw8LjuRdA2HhSTsq2Lfwd3uUqVNpDCBHwFDTyF6khqGhRUSGF3LZiO6xdFeXtBBgVWcw/s7eQhe0sd6VAAi38xf/LiE9HHeIKzitMaObzNz34Kxu4tMa/UwvAVGBBpltWI3Az5tGZNP/GQGvCR7GoXozJIxwRwidZIBy2whwtKNem5ftik8jzw9UpwzfrYhSh6gj1380/BPL69NjUM1NML8AOPnRiqQltOxjnAA+TbTil22iNjy9pGoQ6iC4Z2XH+/dnq3s1PX2T5wRG2moJia1uIaXjoCkPcZ0tUVywLvqKQhrYUy26EFDIGiX/Cwbjfa5Y5Pbexz0dys73Z+GT9i3OOHwgqhWBDndLNCPpt3oLGylTEjjv9JfnzhgTMcJGnW9O62qU1nxFYWwVo/8VlIqfJ3gZ/QRUUeUFEDw9WCijtva6NrCYymb4tTpEdnxzl0fFrC8wHII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7bEihazMvaOqBrQ0ACY2QqpozKURv9DELaD6K53GkMG7g374g2IR6wtqeCP?=
 =?us-ascii?Q?iTMelmkgzYHyqqwN249Exoy7CsyirG04qq+nJYOqc2PVOxi87XB0TTj/1Yz4?=
 =?us-ascii?Q?1WlparF1sVX0B9eryaLtLsqufj6rTLsBK7qjW8JeBOqmUzekTC5bDZ7csF1H?=
 =?us-ascii?Q?5hwovTsjkIjm+KVfeLnAPGm4A4FaGNAXW9Rc11WxcVj6mkeoOK7VmYxsKSUE?=
 =?us-ascii?Q?MivkHVZ8lhdrTCEn5ihv8aYUfWN7kGGvNMWqr4dNfB4I9Wk18Cov4WaZUs7N?=
 =?us-ascii?Q?7cBEeUCd2sVL8L9CTtWx/lyQBXnDtfQKDOEWDh7ljfrbMIYwvqCJHyYAsAcl?=
 =?us-ascii?Q?tEF3C/xpngAhkguRbXoxRc/jQ06gIwDQ7/ZE3vrdsCnB0lqdxbhbJNtWIRQL?=
 =?us-ascii?Q?m/+E4EmonUJU8XLN4yr94btZ+tayE2+VW7BrJxTc3pmBUOgniRR6X1PXuyvL?=
 =?us-ascii?Q?trATmx4fqxBCI/Ecj+4AXYPOVuGEvBcdTFvopEbo6rEKP3JsOusot9IAg/rs?=
 =?us-ascii?Q?tm2dhxYt4iN0AuaJSWqyGnEUT3FjzQVNIihlP0rrHG2XKm07fpBEGSVkZuET?=
 =?us-ascii?Q?jLVfYlszxmNE2W90V6UayT8r7+C0AGVx9/2Oin+RcDeKq25eMLXN46bAT0mW?=
 =?us-ascii?Q?oqHVG+hnL+Fz7aC/OoGk01ETv6K4RKAZn6QPdYC7R+nyMHp6iFK1cAFU9gCz?=
 =?us-ascii?Q?a+Cvt9V2PGtV4wKSNf3CnbbMiN6FLA7G9FCkT7NujLaaAZ3p9E9POouD78KV?=
 =?us-ascii?Q?WrmCBAoYD7C1n1IBfarEqhqJR9hxtRAKgUjPThbcbC15OIebKOt5WK9w4nLz?=
 =?us-ascii?Q?EBolA/dDtN8Tchg6fqIeiGVy8LUrPkcO3CEt+dcIDWCkh9V0gQ9OVJo6Ce2E?=
 =?us-ascii?Q?BmPyar7Fq4sF8bWRAftV4swgcmFW4edARhqDGrbasepU/tfu3UbuzmXLoyEo?=
 =?us-ascii?Q?wv6KJrxPGqaGX9SGVR1tx4lcgm+htjfb5hbH74w98zeqeDIGMosQtdM3445p?=
 =?us-ascii?Q?6RSVWJPowbXCRt4PGDbQojw5G2EJVJKC8DKZ0wskaobVxeRWb2mpCFPDv39l?=
 =?us-ascii?Q?fBotQ0dGXcSIqbK/pvBuY4j3jylRLc0KKYEdU6k9F+5qh+YucMKIjdBL12RG?=
 =?us-ascii?Q?9iTmvYrUTOHbNBsT1mdR7YrJef/Gtrh+OQrOCg0b07lRp1+25kpGqM/DiXCF?=
 =?us-ascii?Q?/o4jQpqmYvUrCzaJPneVfpPrz82+9csOIGFKmuSZeVZ1vzMXL9s2DvjBOJPE?=
 =?us-ascii?Q?YcX22esrKAePopihTFWfqRyblps4KbtHWshI0m2M/cpYHt3UUUjnBwubzri5?=
 =?us-ascii?Q?RF8rDaWfHPAB/TNd6T575rlcZP5DoSvL6a6vOndjIdYRYZYvkzxTORJK+Ve+?=
 =?us-ascii?Q?RyJT3tqPUMeRcJCbeqjJBi2N9lhIvmeqOA5YLpykN/SAnJmEi7Oy0myD37Xn?=
 =?us-ascii?Q?WXKAlIE8B5ysMlEBu1XoUQ3CPnEP8GT4QK+PpZH98J7+ArE0SZqOpm2gYxL7?=
 =?us-ascii?Q?OiuUPbd9hr8lB9uj+dUrob24HhP8FOwTm/+G5x15u+OIdjQKek+TBceHqTo7?=
 =?us-ascii?Q?oTPkNgPj6hc/giMyYEDsGmfnV/paDZKPRepA3sh8NeyeMwZgJXGlfHk537V9?=
 =?us-ascii?Q?VCyFyyHjAm4X03iG+++qNsTraYGd/xNkPtWosuIjNOMmgIqdN2FkPZif22Du?=
 =?us-ascii?Q?L7SJdrXqyDRywAPVxxMlpryUhvUfWcD+Qh6nWBCPYVXRnHxw0T/K4IAjkQIp?=
 =?us-ascii?Q?t4xYbhUmOQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: EHT4IeMApunYJkBEzoyyho6a4xWpP5bYHnJwM2fdSTEYuhyfrtWzH89H3CeT9CSUyipjL0Eq2h2yeVFA5ssKua3QFrnkMRuqRIRMcgGjpF/ixWXU1jrwHBgHFWcTcgoPRwJrUpRjcjNXyIctH0xX0JRiveAxWlRNqVBtMpzSxhqum10m22ChIGpDzqs/89YaQMWyMT9M/OJt77mSRbjfmCoymI1p0dLDpuPvCMXf9dqSzhz/VOHfeyWqqO+LvXtYsQMMBfvntNo7SmOoxaObte8ZwJtS+7d0FaN55gXT3KFtx9CJlzlwgQKPQfL5L4rliCn4IW/StJoCLurqdHHYDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3458cd-08ae-4a9a-27bc-08dee170a3cf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:25:03.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tV9lpRL8vryHMY75F147/cRRbC2crRHYqf3q+9+8c3+8EzZm2QWoG+3XO2DtMC5qea9NWMyOjwsp3DnkB9Q5Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7783
X-OriginatorOrg: intel.com

On Mon, Jul 13, 2026 at 10:27:46AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Peter,
> 
> On 6/12/2026 4:08 AM, Peter Fang wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > The TDX attestation driver currently uses a fixed 128 KB Quote buffer
> > shared with the host VMM. This may be too small for Quotes using schemes
> > such as post-quantum cryptography (PQC), where certificate chains can
> > increase the Quote size to several megabytes.
> > 
> > Allocate the Quote buffer based on the size reported by the TDX module
> > instead of always reserving a fixed-size buffer. This avoids wasting
> > memory on platforms that do not require larger Quotes. Older platforms
> > fall back to the default 128 KB buffer.
> > 
> > Because the Quote buffer must be physically contiguous, its size is
> > bound by the buddy allocator's maximum page order (4 MB), which should
> > be sufficient for current attestation needs.
> > 
> > struct tdx_quote_buf has a trailing flexible array, so use offsetof()
> > instead of sizeof() to calculate the header size.
> > 
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Assisted-by: Claude:claude-opus-4-7
> > Assisted-by: GitHub Copilot:gpt-5.4
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > ---
> 
> Looks good to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks Sathya!

> 
> 
> >  drivers/virt/coco/tdx-guest/tdx-guest.c | 52 ++++++++++++++++++-------
> >  1 file changed, 38 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> > index a9ecc46df187..162fb47f3fae 100644
> > --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> > +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> > @@ -163,7 +163,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
> >   * DICE-based attestation uses layered evidence that requires
> >   * larger Quote size (~100K).
> >   */
> > -#define GET_QUOTE_BUF_SIZE		SZ_128K
> > +#define GET_QUOTE_DEFAULT_BUF_SIZE	SZ_128K
> >  
> >  #define GET_QUOTE_CMD_VER		1
> >  
> > @@ -171,7 +171,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
> >  #define GET_QUOTE_SUCCESS		0
> >  #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
> >  
> > -#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
> > +#define TDX_QUOTE_BUF_LEN(n)		(offsetof(struct tdx_quote_buf, data) + (n))
> >  
> >  /* struct tdx_quote_buf: Format of Quote request buffer.
> >   * @version: Quote format version, filled by TD.
> > @@ -192,8 +192,9 @@ struct tdx_quote_buf {
> >  	u8 data[];
> >  };
> >  
> > -/* Quote data buffer */
> > +/* Quote data buffer and size */
> >  static void *quote_data;
> > +static size_t quote_data_size;
> >  

[ ... ]

> >  
> > @@ -286,7 +310,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
> >  	if (desc->inblob_len != TDX_REPORTDATA_LEN)
> >  		return -EINVAL;
> >  
> > -	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
> > +	memset(quote_data, 0, quote_data_size);
> >  
> >  	/* Update Quote buffer header */
> >  	quote_buf->version = GET_QUOTE_CMD_VER;
> > @@ -297,7 +321,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
> >  	if (ret)
> >  		return ret;
> >  
> > -	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
> > +	err = tdx_hcall_get_quote(quote_data, quote_data_size);
> >  	if (err) {
> >  		pr_err("GetQuote hypercall failed, status:%llx\n", err);
> >  		return -EIO;
> > @@ -316,7 +340,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
> >  
> >  	out_len = READ_ONCE(quote_buf->out_len);
> >  
> > -	if (out_len > TDX_QUOTE_MAX_LEN)
> > +	if (TDX_QUOTE_BUF_LEN(out_len) > quote_data_size)
> >  		return -EFBIG;
> 
> Nit: I think this check will be more readable if you can rename
> quote_data_size to quote_buf_size (since it holds total buffer
> size).

Hm. This pairs with the original "static void *quote_data". Or perhaps
"quote_data_len"?

> 
