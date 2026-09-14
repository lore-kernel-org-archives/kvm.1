Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895A1414439;
	Mon, 14 Sep 2026 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376756; cv=fail; b=uD5Kf6WfHlWadMaxpqQyuXrs92TLyQLmg3wvQvomanpF4Oon7PEfPUN4WKK7Ak7XQ18Um0OmwLiXWltkm0GZTtMgHk4bZnkrIyB2kKAwoLs/uTmGUuSPt3x2q/LWzv66zr2dwGKJWif5DNfe1TsOMHoL+mxLM3ZOBpGpeqPgop4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376756; c=relaxed/simple;
	bh=hxw9/opEd3W0CeCyrEfIbIjhFENJErrLR1CjE4XUKFk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tWIPixEwMX6uAwJDZw42a1Y3aZjNJ6gNWKaYQ75LVbnehWyopAMR+UYjKsFly9X20lPX5gUxQ0fMZbSZqLoRBA+2+vz/PHULWcLHaedFot4aoDUWnMlHJi6umAKgELMPaRUygwWDmr7TJ6DWV0stMcikfne54BqomnAYiD9f2d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifXR98Pt; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifXR98Pt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789376756; x=1820912756;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=hxw9/opEd3W0CeCyrEfIbIjhFENJErrLR1CjE4XUKFk=;
  b=ifXR98Pte1+MOukPpMzCH7K4k+7WtaV/tAfmFggR3jlqTLLvzl4lgYK5
   D7+Fna/1GQLHi/RzDQUCzQZrX5xtHfp6nsslkSJXqb0zwTxLC0KzGPkNe
   xlV2x7XBnjyHDWRNpqVDUoBAze2AZzzHEVSiU217WY6IBJWm34cZ12n/e
   msaU0EReKpMfJ7apHWvETaQ5lCm4jgy/Z9mnDIjWdun5LoZQy7i1ibKb4
   uyzYUntVLgbQSkG+98nJHVPPmthnWvXGuutLwxrNxk5q06N8FPAbds6Q3
   N0cTY+xVQJNme7mUHQp8J0XKGZ2RokQWFSqGv3IoQt0W7ED/Y7imIk3TX
   A==;
X-CSE-ConnectionGUID: au+hynLOTMauzopW5ZOaZQ==
X-CSE-MsgGUID: 23Y2LVMQSN6pcP0EI2iUsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="112496342"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="112496342"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 02:05:55 -0700
X-CSE-ConnectionGUID: bCBhXBrQQHWcC0g1SpMJzQ==
X-CSE-MsgGUID: WQQ2xpz8SoOWjLPQb3kA7w==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 02:05:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:05:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 02:05:54 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vV5SIN8h5q2LY91Reot8lwfIH6xIM23/N+9iwSe+EHOMVVDwfdtUJugDswRR01hxWxF2mWps5yHgBzbvcnYtDTsC9ykZRrkkqz2XsuqKegwa7m6OJhKNxVrB/2AxWT/rDQuWlMppPLDrnHT+Ij5kEFHwi0pGPSyCFLtw83q3S9UNbekitzOGTsvS7FFc5+9vCt22k1Y7RqDhE3ap7dXJnaArRb0zcXYQpNYTXRCWYwbKQCGDQjXbrA/ti45+RhYuI5L0oKC2LXLoPkuuPY9zogqgs56RVqvPtAOhKuWAm69wuyg27UcgNZBX7yEn3YUvLgJZPZ/w2h6FzAiYtG+bEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oujvwDPQm4qBw67Agrd6QP9C/HyhRsXxBoOIM63I/Rk=;
 b=IckWPeJVLqOKvQCI3SIj9xub2ymYCsP3ZjLTzdZl94qvx8d1e3p1HyyrGa5gHvTec+0KdGOMYLnTY/Evt9qJF8jwh83BphO2Ixk0S+WnQ569b0F9uMBuHGHbHQrQZbvRxa68vb3MMNc2YOrlg/6wOSiQJ9JMJeF3mFPiW8URGPrizTuSJbw0+vCxSc54HqoL+FAfTmaT1zCdrqmYzxhEYFjR5mbjBVpda2+Cwlja82xa8a1u65DH/uF2kOP7GCFgSiM13JxBlYIs2d4ZHtB2o+Jz6w+a5iXtYOMDyd4vWXyt4EA1rsQHDqgH3pu7pVIatGfdHD7pE/igw/x09IGkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by BL1PR11MB6050.namprd11.prod.outlook.com (2603:10b6:208:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:05:49 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:05:48 +0000
Date: Mon, 14 Sep 2026 17:05:18 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 3/3] KVM: VMX: Drop TDX_SHARED_BIT_PWL_{4,5} and dedup
 related code
Message-ID: <aqe4zk9Z7qugecTL@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260902230932.2760127-1-seanjc@google.com>
 <20260902230932.2760127-4-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902230932.2760127-4-seanjc@google.com>
X-ClientProxiedBy: KUZPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:d10:24::17) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|BL1PR11MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5e5122-5f65-4121-751e-08df123f5e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|11063799006|4143699003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 1cWO+YKtxnwdatDq/kfCYiSAI/pS+PAQqu00yqKyjt5FTsXziEwbXU42S15dOrl9tfnZG+lEhehpWxqMcB8CwhQIul1Q3zKkxWmeLkUQs3rh+611bOSRWUNqEsPco2ZM+UpyeuvylQIIrFlUWfjrn9ZgMct29w7J0GZXNmsWN7kZCg6gIgH1R5J/7y+j5D6J7t2xhjNv7egFE3JGmWd9JU4Hrnh8c6DYLBl4J6LcYfbN8asvfaNqmFzzwsHfxhjf3WLlMzb6svzMj3VemuHK34es7egoX3V4mWjBqiyjcLwRIRta3DYtbK8/8QHyWm8NJwZ0MdrCgW2dC+0lUXAAeOrElbSNr6NqKDJ6B/+TjEXQXijfjLWjVFowP1nyS8yI8owwQtz7HXsi+6KXzko3NPllBpjVx9dA89W7x+r278NW+xcsliIiN0tYF67otdCjYjMcUnznh2KjoUtX1rKzRZIpGj5wzXDHl2xh0OG0Bw2JJADsJvFH3ZZMS2o0EP1+4wf3VwFpLEStiTLU7c4AkudcVQ69z8GdwARed8dqNQiCNDHcH1XAeQMDf2+Xu5mMwu2VzEYyRi6U97Ts9MU3m/9M3z3bWsh7TemWZ+YJ7SavX3/PzYYn5am89w/yawcBfs12wnfOpac05pdxqPfxMtnrQCt3gSW/eUTp4790c8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YximPBB1dQgFEsQSudFsL5UzqtFuJkdHM9DEOTdnlLgLdu3oyRHDqpHCG3xN?=
 =?us-ascii?Q?pfGo17JLscgnahFwEoV7YWPw4BKBJjfn0QyXJLhVqJ1KVjX6YXy31LlFZpse?=
 =?us-ascii?Q?JNP3dcJGoqYOsL0v2xS2x1fqjGOQ0xwP1P0lR4Wx3MSN7JmU5ITSK+STzm9A?=
 =?us-ascii?Q?ydqD54d0VNgS73UNfAR4zKPceFbQhJ1uVSViA3RkjR5vIkTXiVW8zjRAYNCu?=
 =?us-ascii?Q?3evDCox8+ZQKmMCefNfMBNJOeZb/tkVYeOuA7utAy3imD9YhfmMTstcz2x4A?=
 =?us-ascii?Q?DKMky0F/LSfxi0VrSw/MukNibf6yzKt5pvD4K84CI5aeTCbOfTY4VBQpiI/d?=
 =?us-ascii?Q?MHfBb1zBDO6F3b7BR9Mf4Rlvpc7Ln94XurpPF/Y89xomuKIU1sC+YAKsohaQ?=
 =?us-ascii?Q?xVfSmUcEoIKpxX0e5DoukjhQCnp8oMo/nTNO4+UMnSWc9dVBwzEK+WdMr4lc?=
 =?us-ascii?Q?iP7LWdFNqhZL8SXI+SqQkkRqpieAeBzy0nBjVox9L2wJazFTdmAVoTrnTga/?=
 =?us-ascii?Q?zpEAagtDs2XEtJNp8qwTbXxpGaT+m9s7CGnk4SZyhHCLQ47VltpU4t/+Im2k?=
 =?us-ascii?Q?f5nHOG1fxQSRqfiUnLKQg0NnOXsBZ945q45d2qHM5WQea7t629Lxyfj53ztx?=
 =?us-ascii?Q?HeN4ySFNKoREc3Sh3XbcoOpZiHZSsOYJrkUrl2+HyOvCkhGmkxuvmnVpGkPJ?=
 =?us-ascii?Q?U0M144v/BxFQN0DDEOfD+lAghzzAMPjVkjvCVlIa/uX8gbUBt0o27Hb5M25f?=
 =?us-ascii?Q?q+izfBQ/N8ke5FAvjuAeI9ZAx6ydphVC1udcOS5y4ku2PEr73CXmTjrfvHmu?=
 =?us-ascii?Q?80kHBkypP8xEpy4X/kz9kscI29HgQqDQW+ImZXhknibqm5E8qrOoLXWguOhA?=
 =?us-ascii?Q?TMKSM8P758v0DM1eBrFinTvcfddW2fgWdl8NGBMUaR2dwYBO1oCloy1omt/t?=
 =?us-ascii?Q?S9dgMPAXKHIWQp2zbNNM+1KbV+f4u60AYwBDZ/YV1PKy4MMJRgBWuQtisfCS?=
 =?us-ascii?Q?KfePG3GmkePpAE7i7y8D/6dxhdaBk0m6j/0CF8Cr37f1TiEuHusRHppXHkSN?=
 =?us-ascii?Q?3K67yrghEI8FC3QhxD5I3Qr7uStRU5xXOXJj17CK9N7lgxYgbSjV/flrO1fv?=
 =?us-ascii?Q?vUxqmv3Wl2ZxytV4HKjy4Kf8uEdxtPiup38s6+rGnjFSzbG9AQSmcnxkxV2e?=
 =?us-ascii?Q?GmTSktmVFNLvwoP+807j34w5ntvj4ytOrc0re0DfJ/TSRn+0DLolTg1Tf93A?=
 =?us-ascii?Q?Y/bgMdoFfdLdN4CZZ8ZTcq2TH8VlOcux+L1TqujwybETNg3MvEDiqAW92fy6?=
 =?us-ascii?Q?fS7lS4hYqO8m6Gap4OrH6eEMCjXpAzwX2MPXn4si9cQpvyeVifCp0dTHZCIw?=
 =?us-ascii?Q?jli1MJyuUU4T/g5l1XebHcONWcAP3UYkGLB3LsFSLStdLxd6v+ja+LBauJsB?=
 =?us-ascii?Q?guyPps+wLPgm7gycNo/Vq5oWbLtm4cNB9baK+qMuPGdqgaAFMF5dJ6JlqADu?=
 =?us-ascii?Q?3xAtWN8NLP/aYMh+tZCAxG6rggXVpbgvhyDHlAfnDQAyl4iESfeE8AZ2+ZfD?=
 =?us-ascii?Q?mnLl3k4qGRwamY8nKShk34msAnVZPmL9ZcY0hUXSJduXMASzmQi0Oh5ImF0w?=
 =?us-ascii?Q?2XvnSRbWDLA0QmcvEyFYL3/apnLE7SmFUB0nZUJOO6lddQnWmwTXObd6rq8J?=
 =?us-ascii?Q?iYK8iAoZmOKBQT9ztjjBwRYZSKB5C+jTBqo1Er0NOjBPwKcfg8Fi1LXWcu9d?=
 =?us-ascii?Q?iGpfgGsyRQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: E4z9NAkWn4IQDhhPqa78Sy2C0U1hLnf+RuHdl4aftpRqROB7lSA4D9fxfyLnt+wZqyyEi0p3lCB6bg+ynpcBj2iLr+lF8L0yS0DdWGpbdcVoNZajuJy3OajPlXcDXkTpR3sFeh653EXlV92EaK7KYIYYrIeZx7sLYrjCR/+yPjqV1EtsbYNLie3U1qCspmmYiBK5vqwxdTwYmJdv9nVaseaPwjN5Xio9AZ354P6AnHvNYXol6NkMUkxOUyjQcM/zisAuOgfNZm/Rs1FiO70M7l+BAmET8vGUWQmC67pNYiKwGxR296ZC9jPdd+UtyIhYPpYDqgGpCE0zvOiunQzETw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5e5122-5f65-4121-751e-08df123f5e67
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:05:48.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1TuSBRQLD5hNrQtDhE95wRxh8KppvqAaEemcS1JYKmS4r65UPcZiaKVds19d6McQKxbesy+K3hqhSxJpH8gTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6050
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 04:09:32PM -0700, Sean Christopherson wrote:
> Fold the GPA => GFN conversion and bitshift logic for identifying the S-bit
> given the EPT root level into tdx_set_mirror_root_level() to dedup the math
> and drop TDX_SHARED_BIT_PWL_{4,5} in the process.  In addition to deduping
> a small amount of code, using the level to compute the S-bit position more
> or less eliminates the risk of the mirror_root_level and gfn_direct_bits
> getting out of sync.
> 
> Opportunistically switch the sanity check in tdx_load_mmu_pgd() to check
> the mirror root level, not the S-Bit location, now that it's all but
> impossible for the two things to get out of sync.
> 
> For all intents and purposes, no functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>
