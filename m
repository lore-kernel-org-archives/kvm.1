Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8FD40D586;
	Sun, 14 Jun 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781441884; cv=fail; b=QlciAluKuZt6Yy16i0JB7Fh18j2PHyvZ0pAmLyRC+ZydMUVVreW5vNpjzR+3jqOqVIRHQh+FKE1/m6TlDE5hItY+U7HJO0j4Rm4LXVEuZwx3/nZosdMs+NU4u86nNYr9l1Wy9/9uVFCT07/iR/2OCHx1d2RRmBl5fzgjhnT3zO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781441884; c=relaxed/simple;
	bh=6MnFwFydxzARdRTh+6zU8fH2md6ozUgHwZLkr5EgCEU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bDSy0Pv9OyA1x+LmbAWmVNcDEQH8dGjUccrfXib2E9YxUhemOycmIA4zGh/EpM88deV+zAveTTeWCUDSWN/xovgdDYMrifjOZhtpPRIlaXYT0SQ2hLwRcj/rBdpLlra9Y1Y+4+ohQsVu8c/GVPT0S1UfXfxwXZUj6ptAEaiyJvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+YmT7S7; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+YmT7S7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781441882; x=1812977882;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6MnFwFydxzARdRTh+6zU8fH2md6ozUgHwZLkr5EgCEU=;
  b=k+YmT7S7y3A66HBUWUcHDkmaC+O6AuPjRgn7M22BN7PqemUjqobIVszx
   OXgHW9w9tphKZjcO159OdULbPAxJPgx4C45OqGn2MtozVPirfQ6rlPfLV
   HvnyAX1nw2lJG1ZmqPPWmXXt4ckjfVhClJKAy5m4av65n3OtRVzTCaOZt
   oisq1QG3zavB06gv9J1WdBz5iYDsCBiWE4ogOlCyysxM4yt2JYrxhdKMO
   8pROiX305W+5bq9ESnEJVzeKdpGiu13l/gcuyrous4T72XwF1oisZoKBi
   QN+4YiMYG7FaE91o3KANXU1A+ENhT9Ley4fQ5vRIg1Ojbys01MSQ2hqp6
   A==;
X-CSE-ConnectionGUID: SNBMFVuRRSqrJp5DDLueUA==
X-CSE-MsgGUID: AhpWSbIKRD6U3qWX0ZCz8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82107326"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="82107326"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 05:58:02 -0700
X-CSE-ConnectionGUID: d1mdFuxRQWmhXcx60QLFiA==
X-CSE-MsgGUID: rAFxsZPbQIC488yJ4UNPdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="251516716"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 05:58:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 05:58:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 05:58:01 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 05:58:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V81Ziq/3SqErzU0l1W4j6HTZLfbDCpDVLG90ye3BXEX/NUrkfQwh8u9LpfB7AOr+el54J6JnEF9W28MLyIlUJjvg4uJCg70XzBqeprROl9X97yx37ZsNZVbnxlRohuAO2JP3dTComkVO3whDoXIi5c6SjwE2SErfP5sEnGV1L56TaQUjgWEeocFkmOZY3h/Hs5ltwZroPRsMRQFdg6epNE+575qVMM6Gc4ry/tlIMuExytvok+F6nhqdAif0KbDISNB+tD0nvx0r9ay+CxOFcYj1F5e2vvm4qZzdfYETHURAOCwsmlMTwo5DDaS90lm5j1DCa3p2oONIznJ+wSApsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VuUlIJcm53au0s4sbsZrUdNry7zghX/EVmUNIK4bZI=;
 b=wvlWfUG064YwkH3S1KppuaDl3tC2SnYUTRCZEocSwngH+3XIzbs8FdO4ATtoEnalxQ5fNnclCxecIO7fE8pcZ9AgkO+gk8Sm8ELIAQaCfWnAqrcbLKEbQ32+MOna3uL6Blvf22SmUkr5SrvEz+7f393tIxrCfZVVOMhqHrmDqx8oOGvdkbUSMMUurjqK3wTN/u9CUmV3LlpEn1eiiukBnfwmCF+LSXTEuOm8kdnN8WYVxMtYZYMo2Qu/AvA+GP5tQw42/18FEjm3lQvyD3Qd67FpFixNWOhh1FKTP7fvhVSLb97Bu8URoBlolCpq/3lw0N6VF+HNUd+AVsK9i0mj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Sun, 14 Jun
 2026 12:57:52 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 12:57:51 +0000
Date: Sun, 14 Jun 2026 05:57:50 -0700
From: Peter Fang <peter.fang@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 13/15] KVM: TDX: Support event-notify interrupts only
 with userspace quoting
Message-ID: <20260614125750.GB3425618@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-14-yilun.xu@linux.intel.com>
 <7090f4af-3a6d-40fd-82ab-0ba6272534dd@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7090f4af-3a6d-40fd-82ab-0ba6272534dd@intel.com>
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ0PR11MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: fdeaade7-be80-481a-85f5-08deca148b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|3023799007|11063799006|56012099006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qoVT0iPu7Fbkv7D/gSp7KKG+o+PuQqarf6MvS2fyhrjLCFB0bF2S+jVSobMM4GCXpbLIpW64UG5+tfjJxrBmIpo7tMD2ojsFUDg5PyD5BjB0OIKnSim7Gy/56xmDAIHceO81PKJUPWe/3nPVCQoMfSrbXIo/ScKuClMx8ArFoZHQao/YmzvDA4pwx5oj9VEZGFpO8QvNuJJ6B8A6zW6OVBtO943xQYqeuV/GTz+z1nY67hTNnkaSZ//07ExutypdwBdnaKcUTDkrOMBfjgpmuuSmCsa8hBK9x7H6TbchmiAIl+lvWymTUj1pbqUKCiLsdEunwjfKUfjJ1FK2DwXKxI610cMmuohkfjTlN3gzSzlkZDyKP5E3yGdAmmTMiE1AHXNzi5hHp1NBjx9ueSTR9nZ8uXh/wys5v/+CUDreCZiYuirxtoAitVUcyVESnuytTagC5twH40f2YcCUI+Ypf9X2sqCoBnwuNrsbwNMJgwaZ47449iV2ajxMGjpYUkKJr5XRLC30RbUKsY0CXWu8vxDUO68yNn3NIlBudMVOBp/tWy5BeBO8AGCfgaEWgKHdNz29i/q8+XK9V8QY0a9F+cNeSBnye4qCRajJe4pRsXpgYPBGc3TOr5SZ+IBJbpXVkczpH56MTfAPO8eJwZBwipFt3WVtpwcYZpyZ5Cepniw7mh/w4zuzIo2tqyseWaqR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(3023799007)(11063799006)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pX8vhjymLlv1GrDL7D7IDXxZopo2K7HFvcvuhbJHR1wXrRb/azSVAfC5N2Yz?=
 =?us-ascii?Q?NPo27D67LWUIBmF7rD4mX8ELqTCUEPPrPsOUaMJwiNT2EZC553UEutLTg/aM?=
 =?us-ascii?Q?9PSsLLjtfWXxgCrpHvij4fE+DRTb43LYIJkWHXa5ByZA5jDSVziWytvthxTf?=
 =?us-ascii?Q?n0KfMdMiHThq6c2WzHMCT2HyCPhid+SWXys/sOm4x6/B14juupUx+Fl8B6GP?=
 =?us-ascii?Q?xoBLW+cpkCaFWnzeQWbf51nNT646tGHGe2G18Afw15UWzXaEF/ladJ8srVxN?=
 =?us-ascii?Q?Bv8e2s+JH0z2lCk5Hsn6lTu1hOTAtZf66FQ3Uf9Yjx/fL2HOgl6g+olgBa1v?=
 =?us-ascii?Q?wrRXgovGdUDqAfZYqEvgBTbRhS2UtiIM6XTrA32snl4YzLsgvxOzTmq9N2PH?=
 =?us-ascii?Q?4555YYbR485NhsDcdNZ7ErAPOJXv6mM6I/y+k+EcULSEL6MCTbNvL+xlMR1o?=
 =?us-ascii?Q?uK4MEPntccYTmSs4z4MVpfQLNCFzI/Km/SEwzJsZLCyIZaJZUHMH/PS2191M?=
 =?us-ascii?Q?jQY115STun2ocgJp9EqBRTa4XQHncuWDeFOwhtRapeUXK0L8Tcp3zMqEOWTi?=
 =?us-ascii?Q?WiBoLVKW3kEUvbvOy8eNXIb+RURjRqMLdSxxswFIMewEVbxkyRa9vVOCknFK?=
 =?us-ascii?Q?FLsSDjf6ir+rAeTxRYKCoOnezm7mDYKp+TpyjIqv6ShOwySuydUcqialBtWf?=
 =?us-ascii?Q?yeWlYmLCiq1mtSIRIy1/UJISsbO9yF2SmIGrPK+P3IwssQK2oEUUfgHEbhHR?=
 =?us-ascii?Q?w3fxdAiPdJihLycOm1HlqHtbaTow0Xw1IwjU7al36CUeM+X2plrIvHAfIzIV?=
 =?us-ascii?Q?/nccrONyYcIm2mKC449AFySsrvSz4XnTE0viuBNOue+q8AvwOhonI0LdONB/?=
 =?us-ascii?Q?UAgq6CdMupYsn6DtvL48feyvH4aYpFHBe/z8jhz7RDQvp6locJDBKwp7QTch?=
 =?us-ascii?Q?NAjau4XThHXu3DFkSXV12b2aFOF/g28X9JLHGiRj7ZS8deYxOHpnulCL+9+M?=
 =?us-ascii?Q?Z7w5TRWSlNWetaW0X4HaUX/yDJ8/JQBYc3rj3/EZter5Zg+kR6wun3bowH5M?=
 =?us-ascii?Q?2ihV3GKNMlAy2fb9ul4m2nkvhMRrekmTDOeMP2YUJlu14kbz489k7sOJOmS6?=
 =?us-ascii?Q?DeCgUzJl1m2XW1VUkP/Bzxp8b+t3dQ+GGj4RV7IeWGvmIptHMhX0qrLbX2lu?=
 =?us-ascii?Q?BMeZlNfTbmEOpm6B+uCnJlgqsrpGRrLR+LeKVGcKq/g1/KevJek4ktFYeDQM?=
 =?us-ascii?Q?kNI9qjrcztqGpiIPiRQggl3s8pxmaHP6aZIbcSsBpwMAJHjwkUwsWzoeg1NT?=
 =?us-ascii?Q?37e1tC1XOipxZRbASPiXTi5buUcnML9Uy5lJeFbOMArgXuq24siQ/TZn8SEc?=
 =?us-ascii?Q?63k92KKNWEa1Z8TboinS8+maXi8Iwfsds7omxsBmVPtxEMqM+iZ41rIX/dmR?=
 =?us-ascii?Q?Q26+Oyco8YdLQfXXFrOqpIqz+2QGYDa48ct7jDHzgZsP/UwaxbnvlC0/wjy9?=
 =?us-ascii?Q?ZQgBWOAQ/kj74mwPjXs41bQfiOsr4n+driFRBGNCLhpKHSM82KYWj4CWTCD1?=
 =?us-ascii?Q?CVQjE9Mmrr9rHcVUjpDWJ+xGaT9FjerMbdlWq1p7DkUkxUFvC41sUcLHmWzs?=
 =?us-ascii?Q?jeu5pLWTghy73QyHJyuQeaNQW5c/NCzwdVCuF+tS7PZnhAnrcDCYHMnDgAnn?=
 =?us-ascii?Q?kHUZAZvTzhJ867AxhYghIKtlYSQkbC+qsk2mnCa/8IwK+2gAedkqS3+jdo34?=
 =?us-ascii?Q?qTHfnm3Eaw=3D=3D?=
X-Exchange-RoutingPolicyChecked: ArBLkCe8hkEH5DewXXhsytf/aCvljzMXR0K9JZFXQqvsqrFCMOB4f+E30V3I+jFuZP7zlF+HX324Sh1/5kPKpNAYa4iRjwXrsGLibZ9R9iRTFALgkEfSdZV9wP6qb2VaT4e8H6Go4iyU9NMPcq9Go7yu43HorylMtM1gMXRKo4OqsiNZIydB0+AV0k9T7d9AUHgZRGpow4eoLQiV9r3LDBfvFqSuhrjUr1VzNu/yOvHIDl7oT2nZsDekqceLoGKx6erNspCzcTyLg/v4V6mnHSAePhZgoLYg8chiWyxTMM0KQ6KHXHhy4h3yNdCnLNuBZSDkY6KkMIq1b66QbYAddw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeaade7-be80-481a-85f5-08deca148b2a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 12:57:51.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLTvLzYViHiGMzzKUmh0k+RqZX+T1Sr05lKKfexdRbTPCtfS3LAfREnQeiw4XUo69q3xDsopk+TOLOO6BhlXrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
X-OriginatorOrg: intel.com

On Thu, Jun 11, 2026 at 10:36:52PM +0300, Adrian Hunter wrote:
> On 22/05/2026 06:41, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > Tie userspace SetupEventNotifyInterrupt support to userspace Quote
> > generation. Delivering event-notify interrupts via userspace breaks if
> > KVM never exits to userspace in the first place.
> 
> Breaks how exactly?
> 
> Seems like a TDX guest has no way to know whether the VMM will use
> the Event Notify Interrupt anyway, so it cannot rely upon it, so
> it should already handle the case when the interrupt does not fire.

Hm that's an interesting point. But isn't the whole point of
SetupEventNotifyInterrupt to set up a contract with the host VMM? The
GHCI spec is quite loose about this.

If we say "the host VMM is not required to honor this contract", then
maybe this doesn't truly break anything. But then this stance kind of
makes this whole feature moot, or at least not very useful?

Not adding this patch feels like making this problem worse, right?
Because now we will have platforms that won't ever fire these
interrupts, and the host still tells the guest SetupEventNotifyInterrupt
is supported.

> 
> > 
> > No known guest currently requires event-notify interrupt support, so
> > defer adding in-kernel support for now. Linux TDX guests use polling
> > only.
> 
> If no guest is using it, then why does it need special treatment?

Just to maintain status quo basically. Seems like previously there was
some interest in adding this support to the guest at some point. This
patch simply turns off this feature when quoting is not done in
userspace. But platforms that do quoting in userspace (e.g. don't
support DICE extension) can observe the same behavior as today, if/when
such a guest comes into existence.

> 
> > 
> > @@ -7335,6 +7335,9 @@ inputs and outputs of the TDVMCALL.  Currently the following values of
> >     queued successfully, the TDX guest can poll the status field in the
> >     shared-memory area to check whether the Quote generation is completed or
> >     not. When completed, the generated Quote is returned via the same buffer.
> > +   If the host kernel generates Quotes through the TDX Quoting service provided
> > +   by the TDX module, KVM processes the GetQuote request and it will not appear
> > +   in userspace.
> 
> There is an Attestation section in Documentation/virt/kvm/x86/intel-tdx.rst
> that could be updated too.

Can you please point me to it? I couldn't find that section in that
file.

> 
> > +                  KVM only supports version 1 of the GetQuote request.
> 
> Is that relevant here?

Documenting this came up during some internal discussions. But yeah it
looks a bit out of place. I can remove it.

> 
> >  
> >   * ``TDVMCALL_GET_TD_VM_CALL_INFO``: the guest has requested the support
> >     status of TDVMCALLs.  The output values for the given leaf should be
> > @@ -7342,7 +7345,10 @@ inputs and outputs of the TDVMCALL.  Currently the following values of
> >     field of the union.
> >  
> >   * ``TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT``: the guest has requested to
> > -   set up a notification interrupt for vector ``vector``.
> > +   set up a notification interrupt for vector ``vector``.  Since this TDVMCALL
> > +   is used to optimize ``TDVMCALL_GET_QUOTE``, KVM disables this support in
> > +   userspace VMM if ``TDVMCALL_GET_QUOTE`` is completely handled in the kernel.
> > +   KVM may add kernel support for this in the future.
> 
> Is that really necessary?

I think this is related to the discussion above about how hard host VMM
should try to honor the SetupEventNotifyInterrupt contract.

> 
