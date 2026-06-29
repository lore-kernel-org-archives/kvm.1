Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BFC34C124;
	Mon, 29 Jun 2026 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722025; cv=fail; b=VoEzBt13rwbgg5mjMkG+yx0+EAjxt7gsdOifBOXh5fZ0MvNCAU1uYkNrpMxKD54l2YSn95ZBTvRjD04/pvGRZNd21VMnuJySvl8D/oCm7UhYY9THywfLXBf8gO0ELG8LEt0pCfCg3KrXp9AgePkmC2cNPKzh5lVRXEip6H1Q42c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722025; c=relaxed/simple;
	bh=A8qQF2moEaX2qgRzLSNc3s4vdvtKHNXxDlgA6ObKIsE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bPCrhQ7OpjLN2qvz/dsa8ZJlAllTi+ZcYbNUsTdqF+zA0RvJllVy5TyQ4NWDfhpJUMEXqD97sn2sABb40U6VcGQ3QOHHEFwkTvariH/KNN+hAFo0+NGDy1Fs41ZmvQw/COiSyC860QT5DaKkyZPkqADVlfJfRmNzDb+eoMSqXEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5MGhECR; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5MGhECR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782722023; x=1814258023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A8qQF2moEaX2qgRzLSNc3s4vdvtKHNXxDlgA6ObKIsE=;
  b=R5MGhECRfnwflrLIScnnzlCdFs0rmCt2sH3bZablHSN62m+eYRFmnA+/
   HGrMFUoNecCDBciEYIGYdwel/YnOFzuS2oUwzXy9LLMJqkHvydL0mee+Y
   AcGJe5tdZzi0JL6bMHc6rqVFC33hPyRjzcnuVjPOyeU0OcEoVCcEBJiy/
   8D9n3y+TGf0VSarpYGXd4+VNe5ugWJ8Ak7oOnP+b092hyFzKKvTs09br4
   WVYCgt4flpA2s3EzkRt4612AafSBxeV6aLekPd8rmzuLUN7ceUUGuksdd
   OEjhalfcgbpHRHIVzQsY/eeN9pKZEpg4GTHqPb2EJEkqzQhrcRqWDYOZa
   Q==;
X-CSE-ConnectionGUID: NvV3Yf6jS3uX0LrqnEUNCQ==
X-CSE-MsgGUID: olpr67XlQB+fu78Vn2g7UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83174579"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="83174579"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 01:33:43 -0700
X-CSE-ConnectionGUID: LUXSL44bSgy7qzW2wFHTIA==
X-CSE-MsgGUID: WN+0jorgTBS2bPMjRAbMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="255494810"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 01:33:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 01:33:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 01:33:39 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 29 Jun 2026 01:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1VS+WKau8caHpVt6Q6M++0EU/HP/I8ofRb9BTgIvdkKHFYAr5UE0TxwSlaXApeeXURSb66AaRPn8UgWo04amaIJ2+1noZZaJ+ZUI8tqMIOh/UQfVccZ7T9pOG55H2+/Y63z3pmXEe5T8m8evTCiXofgiB1C/3mbxQDCfBaHTKnyw90jI0Bn3u3QwO1CRQDOBiRupNZL3fLQQjwC5vA66IF2FtTM6y5vlRMCET3X0MUFDP6grsu3DPjysbukMAgGRH9TwuDRBB+1IJGbygRhflIfRQsAKhQ4HJgDTHzsVKqSQT0UfmQo+Yp7IcsgsiPKUNe9iRroCZGCv0fvYBr4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD/ZP9LcGnomXDByjnnHr0ycT32CJgmemaBBuuWK6vs=;
 b=yf+nNZRlcFH2D9ghYX3Stn03ZoPuIZAlQysr3eVmv8BjRZOuky9xBaj93ilnPzPxvuoFQDRgkWOWnFpheGX9yKqs6P7GTacYG2W/SExUf/T/NuPwulgnhnW7lVbe2+vipFfyV3WzjK9BlHxJlMoHQ5VEvkhExJfZg9An9pemLFEQI/kmoXlPEMYb19R0cxXmlbjKcQhE0PURPYc5rWs2E1pi+L/vDBoKR3MirDxwZzO1wmn2aNIAtcaYP/W22DfZOOlXUMpTOV06N+tmF4uoQTnNAVhOr9x3kEiZBxL52zrab+NqvqHQIpMJHG5fa9TgYRz0KCNYQAFtnvzTyqOIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:33:36 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:33:36 +0000
Date: Mon, 29 Jun 2026 16:33:25 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <x86@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<peter.fang@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <dave.hansen@intel.com>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 07/17] x86/virt/tdx: Initialize Quoting extension
Message-ID: <akIt1b9jJl1crp1A@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-8-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-8-yilun.xu@linux.intel.com>
X-ClientProxiedBy: TPYP295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::11) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 466f17cb-5ad0-433b-7059-08ded5b91c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Hu7tT7jpCiM7+2Q21FCw8LXG9vyq+IM0TGdCkXZ4qYkeyLbTbhAW2MAHgqJUxKXCdAmOCsLoPs1pLofA8sNs6y8xc5NGf4B7btarteNcOToyM7ndQNfTR+oja8fVcMxlL/rBrFDXh/R2+kPX4vZnTS0nsDTz8XTwpgy8ib7gVHOiQ690jTGMYJDbXL4G0ReDdDNhKQqKU/Cq3pkF6U5Y0KsANBKD1TlhmEDeHotWRSQJ3InjmLwkM7mVMRupZhuTm6y4KOOyfGMy6j/wfd1/gfRxfvS4p488MWy3AGvq+aEQ4NWvQEBe5BNNop16CJFr8EDmSrn/ms09d+o+xy5qutasCINoowdxgS0zScOCUmXrMVSxkXIzJr2EflKkRg5GbGuZsA1F0NuetSXNyXDL2itFPdPIJNQJPZxj7Ej5LlGfPVQi/X9b7Gnef9fevgsIqF3b2HPBgKUnROmM0k51thbm5JPK9YEkNlcfLlikumRfceXHtkj0xTHBS0sybhdUK/FL8ZYI6B7AWoKmKiN+1DWprmqZgape6wN0YBsI23iuGoQTj4ZVwGrqYNlxv0M3BSlOR4Zi8smZLWWPHIV4OtoTgiR+wQvp9Hljcl90YkZi4Qi6wTwte3pjIuMa1l/Am0DTvCoI17PgW56KKv2JI6qBv7nyoH9gBBWl5r5wtEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R61eOr3DlhueFnNz+vdePywwsKr/uw3zQutLACV4ML+6bhCBSbJhd9fQovIB?=
 =?us-ascii?Q?vNDkkduxLRaX/4YduHPZsLYBE0gnTTR7tg8NgZVpKRm+qVghpvVie6OA0M52?=
 =?us-ascii?Q?db14qpMWAl3v6IQOPZ74hNyLytlE9m+IwvM27W6D9/fy8Swbl03JzeDfb8qb?=
 =?us-ascii?Q?lyIaHRjea58gEbnpw35lR+h7t6b5UL14UJa4YltZZVELI5gADNl7hEMEBurH?=
 =?us-ascii?Q?ry1IuCP3eUg5gG47nuZvADn3+ZYU7+BJ0406TXRXkJAzEGC7g2ZHe1rhRBcy?=
 =?us-ascii?Q?lki2Vag6pAJYLJ5L3X10xYHNwDbBTnDK+RE5ek4me5Bq7X0akuDKGHd0GJAY?=
 =?us-ascii?Q?jq+wS6a3SYssuFoDnLnQgx9urucTANyiUrBTnDS6fSVeM3JT10/EhpK2+w/M?=
 =?us-ascii?Q?RJalDFDvbByGGLNyq3SxQcG2hH8njv9z4EYZ6RXNqoKRGfqGBvlVo28ePzBB?=
 =?us-ascii?Q?7P2k3zlNXR648Vwo0ScEFErbGYSEaKJLSvEJJTVQdzbWOSTVi3rU8HDr9QQ8?=
 =?us-ascii?Q?kLYNfyL6C7t20RKMQ6aEPyAz/StsT0MZOs7BQH1B51mvYANY0twsO9kg9HBx?=
 =?us-ascii?Q?A//AGdyKh8aPfEF9aM3YSy63v2zGsIweCMtx3Hob15ZACAeOIBB8N56psfLq?=
 =?us-ascii?Q?u9hI9EF184AwnNMgY9PH+Te4inKyTQ8ZfK+0hUB58SKpakxMb4eN7fs1FNaS?=
 =?us-ascii?Q?cguxKjEXwG2ddFoWKgySi3/XMdHE7fSJOknIzIInbXR8SSav6TOdPt5PMq/H?=
 =?us-ascii?Q?1I8t1Zesbtj+RJM80Vm4DXN6QLuaVGIXu79LAAVaGsf/jCQrdRlRpZG3Sb0H?=
 =?us-ascii?Q?qT4/455R8iJ1q9MFLWglNq2lf7l2jA8iSSOC9bwhy+FsEOIL16RxExbvPkzS?=
 =?us-ascii?Q?HWDnZiHqDX68nXpcTkqKfxxk2lgdZLTmAd+6zQJdXOSyx873o16tlMjWdpQH?=
 =?us-ascii?Q?vgGe9npqUXZDI5qdoTt/VoUPQF+DQBURJ47tkAUsa/hwpEXVWEyUjEphEivm?=
 =?us-ascii?Q?lkCViCyEODII8bjT3/Re3G4JMNtHJx6L6kX93ps9LDsyazo232Toy3nVArwj?=
 =?us-ascii?Q?GZf1AzKnuISajKBkJ4FNQVGY+C6GG8OSv/KaOqJyB9UeQmDLBic5ckOaOww8?=
 =?us-ascii?Q?UA+GpvB8GyV602kVGuAp4yHiI4n7TfDa/XYFF4G3Kx0qyN/gw99IfL+ptUOH?=
 =?us-ascii?Q?23eYyPCZ8+GwCIVU8o8KjYTtP45LahTmUJssMMVq4g09UMzJLjhaqU5G70XL?=
 =?us-ascii?Q?NYNytRtXZJoiz6DDbhLShatCqPihAYh3pO6Zn+f/0pDdcmWEGwkp7inK70cb?=
 =?us-ascii?Q?C/Xn7TxdpBEZNI0m6RNks4tLQgYuj8y6QmARWBHetd5JwDB8PTc3SRHKUhYM?=
 =?us-ascii?Q?ddo5zl4nT1BW00ZU95wOPxsv9tV3pR3SegWK1Zc7aw4SiAazladJDUkP5QPV?=
 =?us-ascii?Q?zyHb136stZbf4sHLRUVt5aDWqV00YRUVPkAY+4tUglEtmRg5dWBtL7GmBjg6?=
 =?us-ascii?Q?NO8WmOFDz+Od45x5IwdbZSBZ8lUHIssYbu0wmRSTX/nY77sVELN7cebEkXGq?=
 =?us-ascii?Q?JN55cCCRWmZO90mCih1dtrcnfVy7xdVrfYuKnSvVI06srYKNE5sNB4IziRpD?=
 =?us-ascii?Q?8WLx3wySBfJDa/Hzekd6T6ZZY66j6IB0X1uxtvYDC0fv8c3ySojv4RGyJ5c/?=
 =?us-ascii?Q?zUSflufWL9PlnwF6MdAHP2lktVCZj4QLhk/SQscTIIXywju0E5Vh1S7HOAUE?=
 =?us-ascii?Q?c4wu4jBbQg=3D=3D?=
X-Exchange-RoutingPolicyChecked: b/w7P8//ZI3KYSFnJWDoTuDp6OFM6H6kO4zqztfcQzEdM6D+xPdUs8RcM72bpU4MvmmyP/KZEZ5kR66ow3nFSEh+AmVT24boohCSIqsvruDB+eC68Dw+Ygb9omABo8PB2R2o1dhYZlrb+enq9YQzvvXeBh6G+/01buUyfR1pa519W/6DkJwL4WM1QDo+/Xxmp80ekWX/dvMco4TRvkUlau25ktMVbfVQ0eKHZrIQMnFENMhxvnzuVNSOnjriI8eY6KCc1CsszfCNjdYu7NZJupf14egJ/9fr6hjCIakTPD+Wbcycs1wL7KbipC84caaclNehS+C+r7rg1OF3XkTf1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 466f17cb-5ad0-433b-7059-08ded5b91c96
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:33:36.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRfhwy8A4aJW1N10d/eCDMnWuJNhPNaRlhJ5BCGR/BUukbArEkDeFix8cJIPP6FDkNdlNcVNvGES6Kirs76KVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com

On Thu, Jun 18, 2026 at 04:13:45PM +0800, Xu Yilun wrote:
>From: Peter Fang <peter.fang@intel.com>
>
>Initialize the Quoting extension during TDX bringup, after enabling TDX
>module Extension.

This jumps into what the patch does without explaining what the Quoting
extension is. A brief background would help reviewers who aren't familiar
with it.

>
>Because Quoting is an optional TDX feature, do not let initialization
>failures cause TDX bringup to fail. In that case, TDX can fall back to
>the existing userspace flow via a KVM return code.
>
>Only lay the groundwork for TDX Quoting support. Leave the opt-in
>portion of the initialization to a follow-up patch after fully
>implementing the feature.
>
>Signed-off-by: Peter Fang <peter.fang@intel.com>
>Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>---
> arch/x86/include/asm/tdx.h  |  1 +
> arch/x86/virt/vmx/tdx/tdx.h |  1 +
> arch/x86/virt/vmx/tdx/tdx.c | 34 +++++++++++++++++++++++++++++++++-
> 3 files changed, 35 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>index 5fbf89d5317c..741fd97cc199 100644
>--- a/arch/x86/include/asm/tdx.h
>+++ b/arch/x86/include/asm/tdx.h
>@@ -36,6 +36,7 @@
> #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
> #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
> #define TDX_FEATURES0_EXT		BIT_ULL(39)
>+#define TDX_FEATURES0_QUOTE		BIT_ULL(50)
> 
> #ifndef __ASSEMBLER__
> 
>diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
>index 2deb0a5c902e..1afa0b10dfc9 100644
>--- a/arch/x86/virt/vmx/tdx/tdx.h
>+++ b/arch/x86/virt/vmx/tdx/tdx.h
>@@ -66,6 +66,7 @@
> #define TDH_EXT_INIT			60
> #define TDH_EXT_MEM_ADD			61
> #define TDH_SYS_DISABLE			69
>+#define TDH_QUOTE_INIT			100
> 
> /* TDX page types */
> #define	PT_NDA		0x0
>diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>index 4d2940f4538a..06c42b86b05e 100644
>--- a/arch/x86/virt/vmx/tdx/tdx.c
>+++ b/arch/x86/virt/vmx/tdx/tdx.c
>@@ -1167,6 +1167,32 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
> 	return 0;
> }
> 
>+/* Initialize quoting extension */

This comment isn't quite helpful.

>+static __init int tdx_quote_init(void)
>+{
>+	struct tdx_module_args args = {};
>+	u64 r;
>+
>+	do {
>+		r = seamcall(TDH_QUOTE_INIT, &args);
>+	} while (r == TDX_INTERRUPTED_RESUMABLE);
>+
>+	if (r != TDX_SUCCESS)
>+		return -EFAULT;
>+
>+	return 0;
>+}
>+
>+static __init void init_tdx_quoting_extension(void)
>+{
>+	int ret;
>+
>+	if (tdx_addon_feature0 & TDX_FEATURES0_QUOTE) {
>+		ret = tdx_quote_init();
>+		WARN_ON_ONCE(ret);
>+	}

nit: Reduce indentation of the main body. 

	if (!(tdx_addon_feature0 & TDX_FEATURES0_QUOTE))
		return;
	
	ret = tdx_quote_init();
	WARN_ON_ONCE(ret);


Also, why two functions? Can we inline tdx_quote_init() here, or push the
feature check into it.

>+}
>+
> /* Initialize TDX module extensions for extension SEAMCALLs */
> static int tdx_ext_init(void)
> {
>@@ -1305,7 +1331,13 @@ static __init int init_tdx_module_extensions(void)
> 	if (ret)
> 		return ret;
> 
>-	return tdx_ext_init();
>+	ret = tdx_ext_init();
>+	if (ret)
>+		return ret;
>+
>+	init_tdx_quoting_extension();
>+
>+	return 0;
> }
> 
> /*
>-- 
>2.25.1
>
