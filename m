Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C33DB319;
	Tue, 29 Sep 2026 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696325; cv=fail; b=DWtFu62KZRqwR1GvHQB5WiKlsK6OujzHtdKJJpqUQPXxh6Y1dCyFyEVcEfan8fmifAwcZCqknSg/HIXgraakJy1EvuSOmuL85rkLIogRuswTm7ucKjPI411gE9txQpWqnvYeWQnpPI0ljtkivpRrFqq1F0SsvcxtiMF/ViQPpqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696325; c=relaxed/simple;
	bh=SmLL1RLSclzFrHGF0iTbRVhClUKfyu13bBZH4hdg+08=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z8UdWJOnnsRLXXMFcxgvbHZbobiFIaEge443m22gX19T6r+nSTh9YX7PBlLMHGLXmMo0mjO3HKN7WKIwfe9s0gTVQlUtk7DKhqG3r2ohwyb1qHUZSeKAuOYmK1qdmKPgn+iM7cJaT5maYeVOdUFUOd7bJIvQyvJiymHdRhN9uhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2G6CgzL; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2G6CgzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790696324; x=1822232324;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SmLL1RLSclzFrHGF0iTbRVhClUKfyu13bBZH4hdg+08=;
  b=d2G6CgzLc0vL4s0jwVhGtcyEEMbMBMHnJC+6DqXrGYLk7Um7GqfKQrt3
   9Hfce+Kk84B2418HUxsFA/t4YEjIHNqEnY76ePRFdd/dWqp3rogDg36be
   uXkzSruJtKo0k+jEAxrI2curZf2oBYKMt3/KJxsG8FXKRMi5vnkx95rsG
   BMdqY+XkQrxT/iyOZ3jVQoPnA/vO7qNfXLesgZ+qJfjhB43x3UixINAzf
   svJAl0NOv9+tPFPNXbo1SHr0B5wM1fGihzYq56Ps212YAaTzlbCSZZ1Iw
   9+koAZg/W8ruP3t1GgNAIHjOQZbg1effmu3+ysrYB07zZYsmg+sZqohDr
   w==;
X-CSE-ConnectionGUID: GbQS6NvIS9eLaopAwOlSXQ==
X-CSE-MsgGUID: 7qkjTnjFT06P9F5kNOW+ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="107805008"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="107805008"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 08:38:43 -0700
X-CSE-ConnectionGUID: Kta3bTVETPKb4zyuGxeuSw==
X-CSE-MsgGUID: Frl7W2TwT52eAPqqVdU39w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="275539537"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 08:38:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 08:38:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 08:38:42 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 08:38:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6pX/Qd4sordWbcbvU/CZTMyreV0TT80JxuoTjIWhIS+l8DLy8tECyZoaCcTvbd9qs8WOWF+whNUcTLRs1A4tr0QFdf14M8/KwkkCxyRk6rouI4Vd54bshEpGrT0tPZ2TUPKNRkyasKPK49YtLZaSwldKZPRsYubdwONYPXRPTgonVVCf+2tdh3EadgCX1KLskZVrn1buqllCSI0W5Jome7LjjK+r1qHUmIcdDrTAYSYkNZ0bEqskJ0sSpFR4SPekLUQP4Qy/ZBh7ectpQvjeoKYMb/1j3K8TYUIRfY9IjDZQw4yKsJZBlRe6ZNe6gHMDSsE/nGRu61o/k14opDtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9ESJcCOoVy8zEP2RoNBW/IFwl9Rz5o07HlnOMtpg20=;
 b=hYn83lMbLiWqQXo0LURzFx6mx6bc4T8xy63aZeG1u/CHbfJX/P1DKCJHD8JCU+U41ug880m8V2Nu3mFf6AiVBuRbahZTEkWPdGrTMpIleo0VFVtdbYnCGnXtdyaBT63qugeFeatftvkM5BfGH7VYxnIKJL1RlaRA7I2jeExQ2JADkAL4CUYE03DzF0IpPSYtQLDQ3PyHCx+nNxm3QC79AR/0cgr5gu5zb6IJhg8ahgA6Tz8N1BIe+eD5y4kwAg4LDpkzNW4WovLn661BROPlZ7XuDR72vqMs9MDK1YIBANYgPLLEacjbMsSJYqjRBzUOJfJliBH041EAa0QtsqvhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS4PPFC77662F02.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::4c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 15:38:32 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 15:38:32 +0000
Date: Tue, 29 Sep 2026 08:38:29 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Tony Lindgren <tony.lindgren@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>, Artem Bityutskiy
	<artem.bityutskiy@intel.com>
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Message-ID: <arvbdYRLAbRmwb6l@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-6-peter.fang@intel.com>
 <61a63fcb-c40c-4259-b314-9ec63b0bc847@linux.intel.com>
 <aruCUJObHUV-xt6q@intel.com>
 <d71b319c-5a72-4e2a-b46d-c22a5817a854@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d71b319c-5a72-4e2a-b46d-c22a5817a854@intel.com>
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DS4PPFC77662F02:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d45c45-17eb-48b0-9a12-08df1e3fb767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: Og/Nak2LhFDIVjK+l9dlTId95QUPS0k3lY0/H2crVcDgqRZa1HhqjZULknGCOfCQwCb44mR/CZ9QHPTueomDiEl2IOWilWPEBfAev61Qu58zM1pa9+jAJz8/DPNpFKbuUuCVKzX56KQGCujuDQGFwuQuTmXUqAtC5IsxN+ij89Ii7XDxEvGQXzFOyUZHhEWxhNFxnct4CJcfCS85nQHyByU7JqSdXw/qewJSj3H1mkRyhV2srPNtUGhn8lzjphHFY9AMrO+yopO3+oZFAoE4Dip/L6wzMzzzzyKVaJrTybAjUi4UuUwmG4W/72ZjMhF9vN0sd5hAujJ59g7yKxyNMbd5J+FMXjiws5/kzUglVlj6M0RgnplQ8pDTx5ZbzA3ylrL6Bya86+uNxRW4XTuQgK2iXIUsuYW57Qjea46HrjxKfw6qhC+ycURZbPT1tgipeky7Cfx4LNKxjIzUwZZRYZSAjeZvICLzwZCR46HzRO5q7qMw693jzSLmVv9Mq0QBKkkKDAWbCLJhweKx5pO6krNDVKJJ1dMiSNx5GB9zKYRdicdeVURtiJCcpCXEMTfYbyUjqo/hUM2NEvDrIBy0qGxYs/F951jdPUHf8Jo9x3/3S88uDI6bdlZIIxWY9Ba8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UWt8RGHFirSAMD593YjbWWiSwZWOQMCO2pJGl86Tp0qiofmwT4DXnjfWQ46d?=
 =?us-ascii?Q?xOfeHebPl9U4gQrqwT2yBtTBCooDENgZKvvnyEJAqxR2ZmBd+LVKSdZFu+iA?=
 =?us-ascii?Q?OktqUolGT/D/J9EKFRxnHW0F2UuCuCK0gPcR3nNHPDm/iEa2uGe3Xo4JagRn?=
 =?us-ascii?Q?OJPlPRoExmOb8SiRxGwR9/aLBBBdjmkWA+IErfv0vnlTd4piNbUl1q9YUTTn?=
 =?us-ascii?Q?aZ0zZEonIrHfvgjvl5qaI+lqHqEAN8rRK3D51K3agxuhbGoCAbIoXGJdbINz?=
 =?us-ascii?Q?GBqBjBrUZVejIvBTFcX6Mbborjx3nEclnUDWgxYBJDAyfsIzo84P3UvCS22N?=
 =?us-ascii?Q?cDoUUY41reQf3BAXXwxugVcE1eRTrHrtRuL5szalNZZbWGVzbfk9a9LmAmBW?=
 =?us-ascii?Q?XTmZC/lIgt1WlFlLIRzGXPnmWjw/94BIG9eGgaeeTGdRg2GEnac48H9IOUR9?=
 =?us-ascii?Q?mxtcbFrE4oVDyLuHUhMJWdhkJd+NvztBlVuIRSPIlcmxuVqo/lXPg1rYsOzM?=
 =?us-ascii?Q?lGImJXXAxM8geGhBLZfVICbr+F4iFn0EY7xgDpRo4k4EI3+6GYGHXvgmkSCC?=
 =?us-ascii?Q?3hzHMSG2bNCVsoKnpyJ/zP93nKQm/8QwTQOnRsF6hV+J28bEOKbm/ZDcu0Nd?=
 =?us-ascii?Q?M26pbM4vpimpWhhAgEZpw0wGCze+UGL0IoTnnaWefBcCpthPVB2uzAKky85I?=
 =?us-ascii?Q?IusX22ZeWWd5cPKQ4f/N19tMrDWF+QQvCe4Q2pUpiPPm++afdmWfhF5fwNBK?=
 =?us-ascii?Q?UrgVmCcxsNwzvAHujvSlYUQlP/WNMmXtgB1WB/ep7AreahluJvSdf4S1KGWU?=
 =?us-ascii?Q?Qzrl67xNpQ5fT8NpwOY+Xcdwj1eogzmSaXMGhTkBXroUhaLgOzbUiithe/gb?=
 =?us-ascii?Q?xczYy7ewul/sXSk6vgvR8w+jd1MjWDDFzv8ZOsCWeA52dHSnaR7w+aZU28VZ?=
 =?us-ascii?Q?oMwDqKuH33EjINuHCIXS8g/2NnoXkoFYb+Afef/CqCOmjI7HIVEsynYvQnCR?=
 =?us-ascii?Q?xDSk//NJYPfXWktXBrgkxeDpIhMMj1e21cPjhMU2bjbkg/O0Fg+dlxmxVbPZ?=
 =?us-ascii?Q?a5mh1f4Nc9QThGWU+CwIKkxj20WwNPOuf95hQYPLOFwHyHx5n2gAiLuTxZHd?=
 =?us-ascii?Q?51XCkg6ML1tT6UWT61L1f81i0AlzIfjf7vBmcb8OKGdRNWWHILJ4uhwY4E+y?=
 =?us-ascii?Q?5siG9IQAIeGpjvb0kGq1xsLC7qnmPL64qrKqT9yuqxNmmFS3jHpQG9sEQiGm?=
 =?us-ascii?Q?/TZBRVPiK15gv1PVQ/bmqIMcr+PtjVREM49qqDeUl9g5VVqqREdUm7HY/Q3u?=
 =?us-ascii?Q?03r/dPlWCMhbGG31r4oVQkT6LFcd2AB+VDxZAyDM+39we3EXW/TLOI0mBns6?=
 =?us-ascii?Q?FRfuYXDfVuSqUcz0ZWpwUVU+24JJ6vjHmz/rqQ07XbxwutTnvky188vVnp9j?=
 =?us-ascii?Q?u1Rs0FgU2C5RAB8MsM3DXPV6cUR2eFksZP3D5caHHGhusp1JmLic1GKlaGLs?=
 =?us-ascii?Q?QsaCQNQEc/FjouK7wrWJpRc3E8lVxu+JbKWGu6c2q9mqn8qqyjMFxSV0j/1J?=
 =?us-ascii?Q?9le0Ur7qk0dXIrIhpXftA6PwUDWJNMXbvdpArU80S9O/QxX1PLxh3i1iiVGS?=
 =?us-ascii?Q?YS0hZolbwlR9cHSotEYSwCt/U1rvXw4l3V9NeabBPHWZOK2CcpUA3f92/+fC?=
 =?us-ascii?Q?IaLriQEQ7a/SKYB4HLVtv1VTlPTS04SSmU3S4d+GB0J44JZfFgpbakhaB4jY?=
 =?us-ascii?Q?hsb12s0jmw=3D=3D?=
X-Exchange-RoutingPolicyChecked: CsTurXxUSJlOd0YspT6aEA9CbGIx1v3ECT41RUbLKMXOAeQuDV+8SpjF9VS78Bg+gRe071gr8olatqxE/SIoo3lU2aHoe8bLBKLjYObY/GppJcjGCQ5y4izJwiZFq2Nr+r5p4vUP9V1bo1seYLlY3TibcNX1e1ZRZZ+Q3HYRI9I/TXQg54DJ84Rel8tBaQkVvGHvqSKEer1WgPE7U3916uq31tu00veJrOjwlA0A0Gi0HJWhsq1TaO4IS/GozpoXE4shAVDrbnrbc5DHisGtdD/2GNbJXbgTPaBcSBl+dxPyaG8jxCRIs7Z7JlimHEGRrzNVV1LQaF0by/B31qGVpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d45c45-17eb-48b0-9a12-08df1e3fb767
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 15:38:31.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRf+J/kt6kqB+3kXDxdxZmGWvhlBm6R6cUYN5zbJfg/jzlrCcUxgamDhQmXuQDWZ45tmEjbmfX9x3uIVmUEIjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC77662F02
X-OriginatorOrg: intel.com

On Tue, Sep 29, 2026 at 07:18:33AM -0700, Dave Hansen wrote:
> >>
> >> If the patch is suggested by Xu Uilun you can use Suggested-by:
> > 
> > I think tip's preference is to use some prose rather than a tag for
> > these things [1]. So I'll probably keep the prose unless you have
> > objections?
> > 
> > [1] https://lore.kernel.org/all/c1c9bddf-1c00-4625-a915-d545acd67fd0@intel.com/
> 
> Actually, I'm not a huge fan of the prose in this case either.
> "Suggesting this" is not specific. What's the point of even mentioning it?
> 
> Responding to a minor review comment does not need to get documented,
> either in prose or in a tag. What part of the suggestion was so
> important that it needs to be remembered for all time as coming from Xu
> Yilun in the commit log?
> 
> It doesn't seem that important because I don't even see Xu Yilun on cc. ;)

Yeah, I guess I've just been keeping that line every version. It was
basically documenting an early review comment about tdg_vm_rd() being
able to read random fields. I can drop it.

> >>
> >> I think -ENODEV or -EOPNOTSUPP is more appropriate return value
> >> for unsupported case.
> > 
> > Hmm, I don't see either one being a common pattern for guest-side TDX
> > code. -ENODEV is usually used for some basic operation failure.
> > -EOPNOTSUPP is not used in the guest. But between the two I think
> > -EOPNOTSUPP probably fits better. Thanks.
> 
> Just leave it alone. All that matters is that it is non-zero. If it were
> going out to userspace, we could argue all day about it, but it's not.

I'll leave it as is. Thanks.
