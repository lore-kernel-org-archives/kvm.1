Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41A3A4F5F;
	Fri, 29 May 2026 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035321; cv=fail; b=WTsbM/A+eAzZcMCGSraeMVnfk4yA/qXw0v4B/uL39LYoyx9RIJjXEUeN3RtbDVIfsr3usl+wGrSG5B3/O9EWrmHyBy5G03e5xGvfbtGzKgOAJX7N37VuPKBXhXm7DdvGlPoRLN6dR2VcOZYdPN0JigGWLYRXf0eVmWsjcRYcp50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035321; c=relaxed/simple;
	bh=bhVDttqYhzsKIt2nzXzOSSUbICaSWGPJEERCxgv3bP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Byd9MyW2miCpsiygjw1ZWopkuCg5czkETlnbdc5MC1kS5yRAe8P0XOnb+QnulJO6But3AzAISNIrBwwOiMxE/suKwvQF5imfMFo78cn2OiQgLY3wL330xsDZ/SLQnsuuO+ocG7696YVMeJj0eQMNUbU1mhFtwqqWhozRbBqtaBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FG2wyG9V; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FG2wyG9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780035318; x=1811571318;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=bhVDttqYhzsKIt2nzXzOSSUbICaSWGPJEERCxgv3bP8=;
  b=FG2wyG9V6gaU5znSgxz5cjAoAwwUD6BXGzPjmJDZzZuG8LpoJm70pEOD
   0lXSsxNXsG/MSxmt3C0zDguuNqmR7v5I3lm8pTMOns8IeuFEd/csCB3BJ
   IF1zPCl41c5a0numFZaqdPsr6X6uBUafhqT3GQslMJcPek2+xviH1YeJr
   lnNJQ7kAAvN4r12m6UyJOpDO8lu99jWyqNzlzbm6MSdehKZLo5Dkf0s6Z
   TUB+SgSFPMtKvuLNt1Tx9qHYl1RlnXNeaRizvkg0Ld3l/ot70sXyYteA7
   EX2nidu3LNFpbliAWfOINXxUZxcC7ulaGLcSjDc4/NJwzJ5A8Slu2s1ua
   Q==;
X-CSE-ConnectionGUID: GAf2UTCPSde9/qcicaA4IQ==
X-CSE-MsgGUID: scHM6el9RIyEO/3bpFB69w==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92359482"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="92359482"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:15:18 -0700
X-CSE-ConnectionGUID: Ln6P93OZSVG6khiEH4N0fQ==
X-CSE-MsgGUID: 3KN9dyiiRnqsE0SePYgzqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="241718612"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:15:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 23:15:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 23:15:17 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 23:15:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdxtH586xiPirXSdGcG49EMbtDlE0x2b9sBmcAeOigSLwzet0jmWU4cF08X80fDF/c5wIO+4CiiSL3+XPL2jrxd+To+o/lPjoa5UVuivUFWywfuDQWzv35XVmr9i1hrCdrS3PJTVQbU04CYG5aF5SMqGKZt7bK/Hu6vmO+LPenBau/vUVG+ewJWrBEZRh75K6g+XUhrKq4H+8lns2CBgRIJg21IZbsi38AZH4A5xtIUQ8gW5gIODiSS22JX5AScgwDd0eeoheWQmE5X4H9Ls3OGV2ntgm78xAGQGsEpyoxwhjaMdAob0bwYM9jLH9J30VC2y08oRWcvUy8569bv0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9M92h9P1TrcCAqAHK1JqUDJSxeqyQFkR/KPUJ1GsG4=;
 b=D3LlngoKcKl6exXHeM0BUbKm3oRseoBGO8T3HQGWu79L3RsjvQkUdnj6P+wYrPNN/1R1AJvjJSN/nwbDecbvX5Gv70DsWzVHEm9IUblgCmXPK6hQ7soFCw4Q+snIxo37XOulvK8HRLZ566MYAQZMXztBoeITj3J59d6kehMM+qgQYYKgH34bF5mcB8x1euAuDOAlGJCpZB5KTzdrlZU61S9HBJTCSYi7pZQ19UCEyEXNjKBPPI+8QDU6X1UwQotP4c4RPheCqHOLD3PzjctNHBAu2Xv6mOtRyyO7YWJQxSiRuS5szTfCAQORCMmRIJp8hgV04sAIPAuS3xfY03Z7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 29 May
 2026 06:15:09 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 06:15:08 +0000
Date: Fri, 29 May 2026 13:34:57 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <dave.hansen@intel.com>,
	<kai.huang@intel.com>, <binbin.wu@linux.intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 00/15] TDX MMU refactors
Message-ID: <ahklgQgadOIUf7I0@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260528080856.10141-1-yan.y.zhao@intel.com>
 <ahg9L2F4bA_8lXFI@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahg9L2F4bA_8lXFI@google.com>
X-ClientProxiedBy: SI3PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::12) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW3PR11MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: a4fd2663-a711-47bd-2ed4-08debd49a25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|5023799004|4143699003|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ozK3nMsUc7sA/N8pD75WBcy8DCMtSz/VTnL4Txp/a9U5u5wa8vbVysi0WJM74VlLxN3L1Ll4ZimfG1FVninyEwQG8r2EJFD7KccT7x7imBNpCFkq57WMQliHlZJyGBuwu/QwxAnId/ZNpoNfLPd9QciItfFfItIqUWnmKYCf4gAURxlyWJZW8xAytFChPqQ6UR8GZiQ29Yo5NAw7e/D1Y3oybjlZM3isQJduirHiazHThHl07vvA5E+XQ7iiOmkju05MlBKK9JfoR8x/QDIojRSNJBMGNenX2TnitiGwqWKlxLFq6IG5fsdfd6qrbRBCyibutzYoMFe+ueB6paXrD5uzoRg1dZTkuEyP9Jo2MXVZFGx2uxd9g6zUU7eIva5zRqk5vSRzSIkT6GgCpup4NCBqcC17f6bBfOjXy8A8jlN3bLynVJy9EWvg2UFYm8p5YQOkQRxw2vmMxPGFQXz3N8Zyn2F4A/FuavUD4Rw095ZV65O7GRGid8U8gRz7DlNFE1f6ostHN9q7v24YjmHTc0jpODD1uJ2pl93ME7WLAp1pqzxK60COFTRK1Y8RZke7WGiQRVegfqTgbphht+zLOmNlgMErk3UFEM3hqmFakNYeFDEuFVFfnnuVvMNvGeWu9fNPSKozd1mBiSCfue2SQvFluFsevHWsmtSIwGeBNjkdBwfHJpXCtUEGFfj+i9+vBtHBf/nFTUYaG8BNnbqLmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(5023799004)(4143699003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oePlM8VAtnxCmll+/j+GBHPayqM0ld70xa8Zj1gyPjalrsVSxjWuZQUy4G0I?=
 =?us-ascii?Q?wny3m3HiB+HKbSc4hsdmlYzu/MmPnEjFQBMQRTT31ii/HnTp7dS4jZxe1rky?=
 =?us-ascii?Q?HxWlV6Dye2HPrtiqZVEPj4Vxib3JxhHpnLfkUZcH4e+BX7xcBoC0zbWg99az?=
 =?us-ascii?Q?oum1aGdE0QjwtIpwM1S4b+XgbwWPPG0ywvXcXAh9PZ62mk18fBldneIV8Pmn?=
 =?us-ascii?Q?jxewLCSlvYrzYfm39dlRH6gQutfe8HioPqMNJrG02oDmq2uGL+Uq4xDVGrM2?=
 =?us-ascii?Q?PjDXdf/q0nkh2HC1/jYk+VyAtx1Ni0wjpsQh6VdAMHuZ/rkX6wvTieLd3lJW?=
 =?us-ascii?Q?Qk6KDjvVagg7P6Gnj7w5BmjFb10/BPpYbo04w9I+ZVy11s1i9rY52x4Yr4Ib?=
 =?us-ascii?Q?u7RYXwYw1eB3y0/gNW68bqVVuiEJCPKXjnyTmIWSW+qChVGdOZd29YUurl+H?=
 =?us-ascii?Q?PxphV+2g3+b+NTgLgyAapTIPHCVA/5+4SNH2fhVaPha5cu/YF4IdYPDu2nIL?=
 =?us-ascii?Q?992apWxHW7F34vrt09/IPnH9HolNT5fosAe0wLhNi1baPAAy3AlzqdcT1SVU?=
 =?us-ascii?Q?pWXTfgBpODc8HuNtsghzbUmaKyj85sqp0RiiMa0+Z5DFK5fPdNn13ch8CMux?=
 =?us-ascii?Q?D0ZyXCl/gpDVT1CkFrI2q2irBwJGQbxrFFOT9ZbBRq+fuW3DQIu7KBOP3tbr?=
 =?us-ascii?Q?c3bJ1zionmr57C8MbnMGdBM65szdTOVlBIEr3e+GrUHFKMVM3Jp5tn/Drvj7?=
 =?us-ascii?Q?VlYIao3dpy5pLUrMrHunayVxPCYu/nIvyIIpGweEHyx/E6+MBD/Bm05U5Yrg?=
 =?us-ascii?Q?qLZq0TukHNtuiv+JAEldBUEic/TVmcEJ4vJd3CRkgIaQB7w5OdPf38pUZrxd?=
 =?us-ascii?Q?yDtr2Sq5gYlNEqjb0doRk8uYTfOHTwXP0xW4fvlWs38FjYIXeKXSCFk3ehYL?=
 =?us-ascii?Q?EsMb3NFQrNIFucwWSPEQIpN9ODCnevI8eyCNwrPXBv00dhwhPIUChdL+IL5u?=
 =?us-ascii?Q?Opvcat6d8v5770rkWkLVj3o1fcM5Q5RnCtVAxxsJsgSV7f1iZjfb9hHeMROA?=
 =?us-ascii?Q?aTYal/yQmkhbd5kIeUTjCAoL4amgunU73zzgyGpqwqfY0NojO3r7gO+GHOan?=
 =?us-ascii?Q?lwFhjwvYWNw46wBm3/uSWX2lB5AVO1vONzOiMjHqO7DlVkJknynnL3auNBhQ?=
 =?us-ascii?Q?9wgdpjH/aYSGvQpxzcuwEo9NDODmPLEFBAlPjWyvpEUVfXAaBe1RsS3F79Xx?=
 =?us-ascii?Q?ixAcMq+Hx21ouDM57UVpmMYMr025yFRJxAHdg15Az2X8oq4zh9n6YuKgKcxt?=
 =?us-ascii?Q?Axm5fSTKMYujMKJgvsWTFhhnaWq0vPUl0ozJ3GF9ZbeLQJRA2Xcxya8mInzX?=
 =?us-ascii?Q?tXPMxiys8+WrwD8vXhYkwGzMKSZJsTt9oxxK4/+EjSofEEU5lIxhhjLApDx3?=
 =?us-ascii?Q?cB9Rhkwzq6coFeIrvNDBo/wCdKG0tRGiQrh+ySPBOnlvoPi14MrYAjQDRiyO?=
 =?us-ascii?Q?cC6j3Yt8jYDrQlmM9ocnsYsZd9wXhxExcbl8qYnnucEGbLUkRb4cloptYy+Y?=
 =?us-ascii?Q?8nBqaiZuczWBeaaOeyRDuR7FTn9r2e8C3K6McMGr3cxPlxvsVcxw1tY/tteM?=
 =?us-ascii?Q?TzLwtaJcMnROLO5YWqAC/YEa9GzhOUj7e3lsNiPTnR3wxwUVcszSGyV0XpLc?=
 =?us-ascii?Q?73kMOnFGX8twOVdUNTvhvkfnh2ZvZP3HZct+IT4L8+cfnXV/eMdxg+rCy3B9?=
 =?us-ascii?Q?Pf+a33Y2ig=3D=3D?=
X-Exchange-RoutingPolicyChecked: ORW4OJwyzp4wBbXavACAve1Dm9ltAPJMXWsXiDab+BafGry7ZOuFYIvixX/Oys43AZ7KtWQkmyU11hoK5E+RbBdjThwff88kTGqo3D2nVqj6OLZ21cRVoo61KuKZB12jbnekrRTV6hH4Ui+zHZ7iiuOcCAN4L7At0FajrGONYtGxriNAqcv4jbzCKiwsuOCH/BqQeS/tAAiH8wSq3d9C9zElWGOBYkwEb6sBuhwYEvlW+hMJwFR9SqA4IDVDr3wHBMFBqxQiTug1ds3pdL8QDTQtX/D4S0nfZ2A5xT8ui7rVFYdpdvDMjYMf3/V/BPWyLyHHaEQu+5zlpUksbFvccA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fd2663-a711-47bd-2ed4-08debd49a25e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:15:08.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZQVGr59MV/pfCz+1N6UAzSZaGFx9Mxxrn73hzm1BFjyTc/qPnCSrn9IR562beduYS/T+mSsoQS19iDi4X2dQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com

On Thu, May 28, 2026 at 06:03:43AM -0700, Sean Christopherson wrote:
> On Thu, May 28, 2026, Yan Zhao wrote:
> > This is v3 of the TDX MMU refactor series, a simple rebase of v2 [2] to
> > kvm-x86-next-2026.05.26 plus addressing a trace issue reported by Sashiko
> > [7].
> > 
> > The code is also available at [3]. (Note: due to the instability of
> > v7.1.0-rc2, I also applied series [4] and [5] in [3] to pass CI.)
> > 
> > As in v2, patches 9 and 15 still have the "Not-yet-Signed-off-by" tag.
> 
> Gah, sorry, I told Rick I couldn't get v2 applied and needed a v3, then realized
> it was largely a PEBKAC issue and got it all sorted out.  v2 is already in
No problem. By posting v3, we can trigger sashiko review successfully.

The issues sashiko reported for v3 are repetitive ones as in v1 [1] that were
regarded as benign/false positive.

BTW, in v3, I tweaked patch 9's commit msg slightly to explain the trace
ordering. Feel free to pick it up or ignore it :) 

> kvm-x86/mmu, assuming no one and nothing complains in the next few hours, I'll
> get "thanks" sent out later today.
Ok.

[1] https://lore.kernel.org/lkml/aczYjEVkva3zOpwz@yzhao56-desk.sh.intel.com/
