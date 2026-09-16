Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E472E7387;
	Wed, 16 Sep 2026 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519830; cv=fail; b=SHyqGbBQWtxE3BaU/krMVEBg1dinA2TR27EoUTxNR0Asli/enblcrzpR5DTa+vUHhRicINGzRJ65a3mkSft5DVmfk3ULNZ37/W6eo0iGqCzIFTiBnRgjC2tH3O7B+G0DCwqZUCDgagSuwGlaMNPH+FAf2V7g20HAlCPiNaN3SRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519830; c=relaxed/simple;
	bh=B4Sd4ojHxaqcV5LHNxbfYHV13pEky18W+6eKqxhOSqQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZRXRH5JzFPURuIhESm23uwpxevwOJYgeAKYsGLUaJ83Geu+OTESxqtK+SoELJcdqaofHT7vpak42jdmsG3axhbi6VEThHLAQMq1mfwCPTYsTLP8kbUdO2GToD4f7Do9c4vvNBnewVqJoPDb7XsejzQcclT0wq1UbfGUIsWZnMpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjucRHwt; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjucRHwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789519825; x=1821055825;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B4Sd4ojHxaqcV5LHNxbfYHV13pEky18W+6eKqxhOSqQ=;
  b=SjucRHwtTNR+CJLuKPiNF709U67Ml4nM4vm3XsEcFKQCdfLAXCm0MKam
   sLzRchhN6K2hzs0ytdu+54OfHmKLOpGMkxBHQWHRyv2tYzq/G2SwZxUgg
   7W7EaX9q2OCxVMSzS3vAz8sYEl1UF7wG4MG2tcotj4nIKAKAiV9md5ZV/
   gqpo/0htg8ZVe3lgoC0sWAjRMWJDe+6Y9PPo85f2olpP6n9ZhzCOojMBN
   wrkdH3ylC+gZAVAkh3uOp/qBjQcYJaijpZUfkGY0r6FD194ODi5fvE/S/
   JrVpMcm+84WLnfgz9VTNeWf/7zscj0dAhLQhnNxcvvkuWXeu53DRZt2Ny
   w==;
X-CSE-ConnectionGUID: GgphvsJFTPWll8b5nvXSFg==
X-CSE-MsgGUID: rliXPj2IRaSKE0ZCSRxr8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101047122"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101047122"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:50:22 -0700
X-CSE-ConnectionGUID: 0NTaINzoRTiKCG/UFzpqMQ==
X-CSE-MsgGUID: fpxkTHdHSc64KSaHkerL5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273717098"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:50:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:50:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 17:50:21 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:50:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjsMEMXVT+XL855dylHPg+70oLyEA69jZX9zK+AeLaOj1GO9Ys7Et30GDECf02EgLhHYEp4GZcb+NHdQeUtvm0sY1fzcA2WdiJBmaVC1XZeKxfixhWjxYA2jTCmeXXsw9MRxiJDA+oM50sp4us811cucIIS4mjMxZRunJgS85JAzJGkpEzLmGou8pfdYyKy+3zSUzY6B98Vl17o8f98xtj+Z85uVnPolWZvRUWNWgjG+7Ucc6yxNb/T1839IQsi50OBxwn9w24n5ZL06Qcb/ObI579eim/zRDBIVk9I+AeQFxJXysqQ3rRxVsmv0WEP7GlA3xXkxWWKIYPXmtzmTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtFZznxs/tsUeqFQTKaYwbaZsX+K3HWg+YrNGCSrHXk=;
 b=tZ7K+UCrkCzQRaioBHuENFnItjajcOPSM50XuBGGLoFdc9mvJ1domswEQKTnPjkGr1zGTUnAw4ab329uLVtrDHQ8MHRSs12Kk7hsPN05hPf3R2OH+mCC5qxDZyc2oKyqFIS8v4abzR40sW+Gjge3BW2/m6z1vdR6P7+DN40sprNny0KPcXboj5Iah2UqzdeC8z3mni16rqepWcgZsqz9qofZZ3jyzqFuRCky1/aX283XT9zsjdbeWtpCIgs67uUpENmsOrbqmKbXAHOg3yEWWVMNrOUyo2OnChz7NlJRKsplkGObQYwbfQ48+19VxXjwrx6ljlBpMCvLk/tihKiSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CH3PR11MB7675.namprd11.prod.outlook.com
 (2603:10b6:610:122::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 00:50:18 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 00:50:18 +0000
Date: Tue, 15 Sep 2026 17:50:15 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Message-ID: <aqnnx3aNjeDzobaq@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <aqlRETiO58SWjFLF@google.com>
 <96c33d465635c1858b943960f09ebd3bf82d31f1.camel@intel.com>
 <aqnO6spgsfN1UsMU@intel.com>
 <d071ce6cbb86cffba21ab7b078c3bd0c18fafd84.camel@intel.com>
 <aqnkHUg3o890LYFM@intel.com>
 <b32cd186709b93a02495a1efcb347f8f9533b510.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b32cd186709b93a02495a1efcb347f8f9533b510.camel@intel.com>
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CH3PR11MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: c9314376-8b21-4849-fe02-08df138c7a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IbSmQk6Wnz5r2x/cl8bDZr0ah3NByAbUj4I4yaQeb2Qm047snmnavEGXZlRXXLsBpmNrlxw3UYmYipe1vbTF9Zj+RZhCmLYRa3KkG2zT32kCH11Z4QH/HyvkBndI8gTL30VDFkdL5WtgS9kXi0RkF/+KymDCE4N1EX2JATpagllA2KGzsYRkgpnRgFOyPVCAWmfsN2I8cTLJeMRrTnH8fgfnxpe8NKvq2+hG9hFJd2zcNJ8KXTR6VurWtMU+stU4xh/HWfjLnzo8+23BpFZogBfUBlsOrTiYjuYY77gZuv6JFKT6aMpIW6p6qZ4z+Ds/QyW7ZShX1SGoKi19ApWliB7WB7ZsNwA7qzjiTeFR7KCEk8SncUQ7RU/EjTPalTxnk7yuzdmSuzYc3w6p9TX0NQ46wrvv1hSoTIk+0CRPiVoqO2698IUnx7USzpB/U4RPIgBDZLJfe8UPazIVFVLuiWkPEfosm1/Gvvf1LupTTSuM2mv/Pz8iXVwPec1StnUQqzXw8lbKO5Xfo/fe97ypwPdBYLQ5pynp5CwGjHsvgM9LmBUheHm8wglPccVH8+qIgrtDsVTS2MAUy296GhEDraWcN/psLU7Y+DYl1nDTuj/B+2h0xVq2MS8EW1u8cFbs3AuPLTiOeu2DmdRt2l00k+7tzsCPhrVEyu+jIspcwdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMab6ap2pubJXttkVi6WxWwSIE4InYq7ao4uX/pjJ2t7qOqmVH6kBLbqXGYm?=
 =?us-ascii?Q?v+iq+8/QcDLTakijz3vrXEfl5TYQFD9f5jgyqCxCYrd1i4IV3+MqRfzpvQyV?=
 =?us-ascii?Q?Bqn4DMmaTkisJEuKkMvD6b/O9E4jiVpqeYVk71pX+FuxFPDO76vqh5xws3Jj?=
 =?us-ascii?Q?iWnfugUrRbLCtDL9vJuwmVXUm2M3y3b2pJyt+Z9uWJtvgusc8EYHgcoIze29?=
 =?us-ascii?Q?TV+hL5zEyQqduVo2AHV/8hbtz/Ajv8zq44tG59NzReGvNiA6dd3Y7cGaSQlL?=
 =?us-ascii?Q?1xQiEqFJr14tWTRssazQPpYQ85DujeirHIR2YgCn//0Bd5zQmtNM9p5K5dXZ?=
 =?us-ascii?Q?N5OQyM+WdNNLDLXr9zeONNUBgr6MuiVrCZlEAn3LvuezgBB2SxITUD0jSaoY?=
 =?us-ascii?Q?g6rhwuPS/CTtK2UnHcZZslb/Vws+jCo8YhOifI0gXF74Df+cp8tCbWgHi+RB?=
 =?us-ascii?Q?uxNPTmQ+hLmDQjLOLK/RQE/d8oznhRcPnuB0UEu/z4kmjGxiWiJ7+Bcc1rw6?=
 =?us-ascii?Q?icgvk0IHqw8UYwRxF1LdLSmQQio1c7EpXC4GEHLalc1BHyyOuin/GflR5y+d?=
 =?us-ascii?Q?AvfBv9XC+6L5fCBCoSeBZqkgE5zQ91r+Hp6BH1k4WTw1zZ0qHRyZaJ5AJb0C?=
 =?us-ascii?Q?TaMaEGrwoM12FYLWjZwomEVHJRrOsU+Uc/Olk2ba5NBTnfxwGgul5yMVpjmy?=
 =?us-ascii?Q?BJpRzwqbhnHBH/9AcyZuU4EKbF6mr3n7ixHfOr/HXhLmu8T1nzYdpMF+Vggb?=
 =?us-ascii?Q?r/9P6xKqhDmTH1cQ0eeZ4/VRpj7cFmToVNZPlN1Ztl46uJRDAhNz/v16wKuP?=
 =?us-ascii?Q?wp+nArIaNkLO+BdwblljbxX+HvyAWfZgo7Xs4K4hSRXWvQgXUsi/anKV5cTw?=
 =?us-ascii?Q?q3z3dmh/yxtcFbmWWnbOS2Oeuh+pUoTFUYI8qr8rRioG+OMGB7ZgTbmuZUHo?=
 =?us-ascii?Q?dV45zDFfFRD4hMkBqD7e/Vd2M0b0Bw0+Xwd1mn30tHRwgbvjd1CUgyeMNlu9?=
 =?us-ascii?Q?rIIWvlSKztYlmEd1bbWkkjhNCe+2W1/h0KpqZTnbv5M7wPOzzXnwbJOeXeNf?=
 =?us-ascii?Q?C+e4tsACnLlIJZcee46wAthHciXxUSk1X0pmupZb749cMm/NNaZ0JF044kyL?=
 =?us-ascii?Q?K8VEsCTjR8nmLDe1ZwbQajfWjjS5i2NAr5Tu2XXGK6NraSBQ5wlXT/Oac817?=
 =?us-ascii?Q?Fs97rxualeTqwNfH6t/a3hDA8bUsF1CyL1/2yBODF1KKhKFlZwVmP18syCJB?=
 =?us-ascii?Q?vTAEziDtCjIVZASR64iExvU7A14zRys8VERxx8BRzCaUUorFDpkTjxreJp1H?=
 =?us-ascii?Q?YYn1uJ4RVSaYX72b/+92V4g912oEfKM5V6QZnjaTvHVcOmeh5TTVDJKP/P5P?=
 =?us-ascii?Q?Mpv/hp61mOEuT3fbpesvcye+9h2+x1a5zzdX36i4+vKo3lEuYHyCVcT9Nsad?=
 =?us-ascii?Q?eajUpU2sMtC67K45Go/wsBvBulOoC4h8fT1Tb32wiPXpb9N4yqWWcADoJlXK?=
 =?us-ascii?Q?Fw0e6B81HJ5ZC4DbR9jja+BcD0c4Er1GgMzK9NcvER4iSGsFCCBBGwkkWmC3?=
 =?us-ascii?Q?MxBzJ1JqKv96lU2/ZmNfrAXDa1xOYDjJWVZ0wHNThiMOxuylVQVkfDbBhfSD?=
 =?us-ascii?Q?3msTsZ6M81/r20TlQ6z9zQkHp0wuFE+EiH18yGlw2Dy+kIg/8H/P0tZjydO/?=
 =?us-ascii?Q?maItX++4nQ2S+WaxwebQQNZb9+JzMbziXBsQf3D4wMEpQSEm+Og2+b0xTZcS?=
 =?us-ascii?Q?CyEgymmyuQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: wuUSy18QJuNckICIg+O8Yxc+XB0JWbWYnBhgcx5i8ONvmCTCJ2LggfG8/UdnNWGs5MKqnuYM0CAtX5ySBHrY5KSIoSfXEJ95cdXn8OBSxw187X4Pwas8Dw5LBSL2KlrDlNmhsDAQGD+2cJZGGy8v/AZLez8RahecWqQTgflcBB0yr4aMrjdRRb9iQNUGW5ajRJ1Oi9bThf2iOvOvTw8INhhog3LMeXva0+r9ms33USx+eRodrl9DrckMGMphAu8WZAFxAWIvQlelKmxPpCXcL9/6vXo4hY/PVYCWn953vhjb1u7uRvAZLSn9CjJA8B0CV8athrm0o2wW5uCvpq4FrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9314376-8b21-4849-fe02-08df138c7a5a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 00:50:17.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCmk6ct3CvReE9a02oMjjALKG/YzEGxh/eqgHU6QKb84c1maOlrbebpclcICi8aAbRaS+qi4TW5JHmnWp3v0eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675
X-OriginatorOrg: intel.com

On Tue, Sep 15, 2026 at 05:36:49PM -0700, Edgecombe, Rick P wrote:
> On Tue, 2026-09-15 at 17:34 -0700, Peter Fang wrote:
> > > Is it all correct?
> > 
> > Yes. If a new TDX module decides to report this field on a non-DICE
> > platform, this code still works [1].
> 
> So the real scenario is TDX on a DICE platform, while using legacy SGX based
> attestation?

Yes that is the real scenario and this series supports it. Reporting
this field on a non-DICE platform is just a theory at this point.

This is probably pretty obvious... This series still only uses the
GetQuote GHCI for quoting, so there is no other future DICE enabling in
it.

> 
> >  And quotes in the DICE world will
> > continue to get larger. This metadata reporting is useful regardless of
> > how DICE is implemented in the end. I wanted to be upfront about what
> > the potential impact may be if the guest did DICE differently. The guest
> > would still need this reported size from the TDX module.
> > 
> > [1] https://lore.kernel.org/kvm/apsxN4jYe3G3meNz@intel.com/
> 
