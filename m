Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810533C5859;
	Thu, 21 May 2026 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365100; cv=fail; b=KV11LHj81F9QPwqn2hUmzuT8MnT0gmVMS5MFd77vo6R2gRYju7WpuvYuuUKsA5+QnyaR+roRmcVioebRw9nY3YoU3h45fvclLzaLpwa5IH+xtn3PrcaYMJ8+pOdR2vXs9+9yWz1IM41j/MWFIivXJ9pL/9SOYK30hF+NGYhAYVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365100; c=relaxed/simple;
	bh=stG+83zJkdoaTdUsBMzX2d80qWhkDBGF3FrxyQyhuIw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XoigogFiPiRPUYe658wRgy81iZcsIfWpXC1Cf6MVyBaLGVytXNmA0Y1ZZiEb82ekEQPSBOi9nR9T8/GbgeYaz4A0QdQm/2fsImB42vCezPmVzgyMUH9T+ddKxI1CB71W/1URK34NbJxECmJYMnnLZv3HJCUU/ID+KUCqmVdhKco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4ZYSsve; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4ZYSsve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779365100; x=1810901100;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=stG+83zJkdoaTdUsBMzX2d80qWhkDBGF3FrxyQyhuIw=;
  b=X4ZYSsvehhA1Q3z9O81ZAVh/yR+KcNVZadmBov7S7CEGMOLksL68X/R1
   mIsARiI4fvOgsSQUIqg3pKvJamXbXjcRZhsERuBWiTkJX7wkiMKaIIMAc
   6Q5Sk0MaltVN5zTVDVmmgSz4OsPAsKVCJciUtc5yPP0/exWzRcZ8v2qSo
   Er5PfaSmAnFaC9tIb3/H0y+DCadz2u1VPWtT6Nnj9x972p7a803u1mFxM
   RzBRWxUdGyDXD24HX2oQMikvbHF8N/H243CextjT0bgTsCVK3tzT7CeV1
   zl0yGjoXlj+JVxzpiG9RSgFA6MMQpaVefs771pfvRfvBmHX13AsdG3VGH
   Q==;
X-CSE-ConnectionGUID: prqPQElHThm2bkMbD0Ms/A==
X-CSE-MsgGUID: b/ip1qeLTe+AqMn04rzhxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79308111"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="79308111"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:04:59 -0700
X-CSE-ConnectionGUID: TdlsPI3jRXmk11rSa7r1KA==
X-CSE-MsgGUID: gQ41iHKiRm22QRBQVUOelw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="237909915"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:04:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:04:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 05:04:58 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:04:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqCI7CvFb7ij4gKIg0nlUwyLGsROmKDCt/JNaEipJFtgp9A9O6PpAVHhh1o76N5B/q4KpQK+27kHmsWIXjgpS84eP5A8e+x1eFJMBM/yiYl3Q35QNUIwh18Twx3/+pXigKTJsN2GmR3THAxtMltjUHSnd/LqlMs14V1+jORyZcdXP+cN8E5dq6gieMN1sr8ob4kU6AO06wEB4SnHVbETkAHfSX+SD3oh+kFDaErx4SMqM9Z10cj9cKjLuAqIEhos11srSBq5050KSp+wSBAh8Y7xOF08I7aQwgyOme+GZkmHgS4EDSg4ysmlStKuz5/kKlZDl35uNfKexkjXvbbCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EeznYG4pUhFDTU+Mh98xnKypnH07SpcPyZIIIWJwbo=;
 b=SBIOvXV7sBPWE2JfBxQVrJcytg9UL6xogV5ixEVxl8rtP7YiwR+GTZ0sPi3Fs5y83nKhBlnFwR8VFJvo/dsUeLs/aJwrvT6zRbvH9j4rOWl7DGysFCUZDDTGm+R9uFsbi6RdI0UYGrLY3zloegr2hIVBX1B7wgANRkWKjrIYEKcxR3xUhQD1EuyEfHG1EXZZz1vdA4PRAUccVmzqIlPeNZYkw1ieS/UrGz+4/UamYomsA79+TGDQneExry9scPENmz7o07gCoFsxcEA7Advh2EdSiRKSGoZGtGBofSyIRTJCsfPqU6BtA8NqBTZ6TT+bju79Lvk5O6p3ux4IHPSOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 12:04:49 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 12:04:49 +0000
Date: Thu, 21 May 2026 20:04:33 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dave.hansen@linux.intel.com>, <djbw@kernel.org>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <kas@kernel.org>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v10 22/25] x86/virt/tdx: Reject updates during
 compatibility-sensitive operations
Message-ID: <ag700coFiAXvfK0u@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-23-chao.gao@intel.com>
 <fc5f0061-8402-4f78-ab65-a7c8acc7e82e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fc5f0061-8402-4f78-ab65-a7c8acc7e82e@intel.com>
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|IA0PR11MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 133f31ab-fabe-41f8-577b-08deb7312885
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|11063799006|56012099003|18002099003|22082099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: crjcGyBa3Q0UaKQ3vYhL4EqhB+8V1IJB1PN0kC6Mhs19ECPqRkoCbRGblN1nhB571ZXwiFLgBc2FLKTcnGE8Uygx28igLGuGOt356cOXoBWIzktZFfm43Fe6FMCFgu2TeWglQRt7YLlod3vB2Sibnk8PvxrY9Pe5yRwL4Fbk5zSWSWqnJ85FpvUQ1IqNXa1kmkFyMXJnJY64dRXTuu7VRYJJ8zQwBE6xJmHCO6gu/ZCb467O2xnpDuvOPgizJzc4jIvvCNr5/6y4DE1GmUxdS06V03yYcQgVKRygihUA0FT+3P/TrDz/F89FWS5uupQv34LMK5vOOMGPKlCLA4VIjEDVOJIzGxsRxsvkdEh4iu4+3rBYyhzD616eRSDykP1ORp66wRSqLFG64N7k0Y3eP3lb0ZI5YASHtNXKTGXS+AUrGpfeGrA7tUebuwrpodvpdb1Fklb6e9qMmwkvVxOARRxcgXywySZ5HwSQwLtr5dLC28bIlsLMwk+HUzzSBZe6mBPZERJRIS901++lOTfDW9L0N9CDGIqlrTPhY+2+21WjJ2NlgV/U26qPq573LkGIEnbNyt1+7mZs5GayudvkIkZ22VRQEqbkO/I51EQT85TgOVCwIumreXf1pFClDmEXca7qLZ8aomwE0yq8QOrykcmTnjQqSr2YyLvXXcz/4UvDiEKl+33T3je4EW+RAhGLWqTmw4EwxYU5KCTHd8CudA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(11063799006)(56012099003)(18002099003)(22082099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ifdBcTyNFc6rgLhWYV93xagvkOOwoh6Mgjto9qNmlfDPq4ONqFS6ada/rpAx?=
 =?us-ascii?Q?hzX9NtqU0kRmYBVCfRw6g4PQ+YT2wgjbiuZ2inEY7HrFaXFbTFloSU/e8ETn?=
 =?us-ascii?Q?z3x6DBg8Klpv9Q8W8EjLx27umCu2qKkNNje88Crx5lzJvd+Uo4FhnETHDm80?=
 =?us-ascii?Q?R/Ba05kcd6MRIQwsBVCeDXq5J8SJbBm7R8CIae5qFzNGGfb8MGXpAF1Whf8k?=
 =?us-ascii?Q?tSwoXqxKc15pJeoay1ZbNETgTlvFy66+mTfeUzQKguJK0TWkt2r7DTsD/ptT?=
 =?us-ascii?Q?sQaKLrSDRq20wCMF+lx7pn1KSmNpeX4qbaliTsnmTxC1TqVSNbV7kti6U2jf?=
 =?us-ascii?Q?g8L1uEEcKMc6gdJOC0qxZZybVqCkc2wtlSG2AAL0BxGSMXX4K7nUKScr0Ei4?=
 =?us-ascii?Q?OgWZBSVw3awfazhsI12PDSuGkwocES+Ol5r43QgGnjc44YxlPYAiMEhjTorV?=
 =?us-ascii?Q?Tyh9G2ChvKLN7GviiMJLfYSD3GjTvC1EQdBX/AB1bTmJsKjcFtFTxQtcME/w?=
 =?us-ascii?Q?d81zyVGOmoGlrg5G/wzcPicUoJCEAb0+dALCMta07ysZqfZe/AiG76dPB8VQ?=
 =?us-ascii?Q?JmfGDzgwYfuY3EHikMsyQgbq64SjIPAmmyXJ4X3RGKcP0q4kuu8xevaFuofx?=
 =?us-ascii?Q?uLB4L5TkJqZWw0iQeKeZYrsirW0XcMBecBRGgGarMtK0H3zugdNVef9vx27K?=
 =?us-ascii?Q?/roUKLpNVdy+oLUGhrCdigPhXEXN7A1PklEtnrYO6mJR8gNv0lSS/SLglxo1?=
 =?us-ascii?Q?vAkpyKdlE0v9ZGZgvHEPRDy2Yox0Z5IxWv3mpuLiXgbOQmS6xEfYOCd/XC6f?=
 =?us-ascii?Q?w0BHAKjUpRHNIZSCpPG1buKYpmzPaGLAKtq42b3xi/vtiH4X8xg9aB3RadPE?=
 =?us-ascii?Q?fmgZ9HKLiqYYlIl3Kb+qqEhXJpylZc3ytN7pWzPHTY2XfmQVXqIVVWVOicrx?=
 =?us-ascii?Q?gFTOqERR0uRS8VKvnY4WoxVu2CgmYz0G7sK6zCmrhA5DXTkw5t4bujfXhbCQ?=
 =?us-ascii?Q?Y53EbYVwzn3taXkNdrACqxXlaopyBMifGfiF1AZJggUoomGjQ9vE6S8qkiZx?=
 =?us-ascii?Q?cv1y85tNvKeDN8HZdrL1U1J6JCUiDu+JXqls9CkOy78Z/dy+2MRm8IwMqIgv?=
 =?us-ascii?Q?6jZzDpVYtcTEiHgFvJbRuWGEh3NoMc4FithzGTb1jdanT6KuicTXP0tM4pYJ?=
 =?us-ascii?Q?pEkXM52AXlPuRFLC5ZkSVlJ+1P+g3v8xLpv/4u29zJA1Jnzso+7TwvbxeuVF?=
 =?us-ascii?Q?SRQQptLAVdUamiixvgWoyIjjGB2sZcuU/iwnFIvL9DOiY19KBDMNX/ZfZ9Eg?=
 =?us-ascii?Q?PER9kTbYEsiEDiGcfZabnmf+67hF4ZR3JmLvl8X4ULVnxHHdK2qOonBG7Xar?=
 =?us-ascii?Q?R7YuYHsXTSOXyPqT3BkxkSTLodMBrYOoS1j085g8aT8wWFS5vXAomN08YLwc?=
 =?us-ascii?Q?lslu9cDLWLCwzirKLcawexXqjjXTqi+XOOE5DI5LtATVhtYqANwYCio9yazk?=
 =?us-ascii?Q?12RhQhmB0GSEwnDjCN4huFhG8i4iyefeU2A2bRtMLhknnZCDUDyHQULbJF6n?=
 =?us-ascii?Q?g2AQ79PGxc/RakAfKPjdNDD7Qi95+Nkn/zb1c3Dd310auSAR1PE5LL2/tpL+?=
 =?us-ascii?Q?XsX+P0MrxuYAsl7hiEKVTdkWaIwq7CpMSkfg7gG9jbYVHkE8FvgRX069a18K?=
 =?us-ascii?Q?VMMQ7s3mxwXfllLQDegzBwQLRjHLwfKDTQsvijwqdeYQ/x9alFernFuwQWwx?=
 =?us-ascii?Q?ULVbwIyzyQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: d0QXmtNjldzbDGrOlaDb0DhToTP/1bAGVo/7J09vp5Ydo4RjK78ZBheLcEJSDNTQvas/ESFAvmvUKPkZ7j3OItDu2KtZAgPE82f3HAbR2v42q1QLu1mw/VGAZKzxYH1Wx3LEDNZAeuqMwe0Wem6ICqqxvvZPUQFwWfVCTxx9bGafWk8JxRC2ivCdgZDOyZM6u97b8nR1X4PD0eGrnfFN331kZBEeNy6OwDlskny14YhrifTYuLzEvL5zvq7uTTF7j4Gw6vUgOL0Jf7IQ1HKzwYXgHczoDkrqhWUgLNtY1LbtegxJ26moX6XXXey2cI3+BdyJt3KPhosF+l37aiTVYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 133f31ab-fabe-41f8-577b-08deb7312885
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:04:49.6022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rIdwi0IxxoJ7ObCMW9lb1kMZLbmxVXN3ahvkVhvF2UR38kQGicHSh2Auc6Fx08Yu5/zHQCaHq+b88lBQ9E7uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
X-OriginatorOrg: intel.com

>This function is pretty tidy. More or less:
>
> 	ret = get_tdx_sys_info_handoff(&handoff);
>	if (ret)
>		return
>
>	args.foo = handoff.bar;
>	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
>	if (ret)
>		return
>
>	memset(&tdx_module_state, 0, sizeof(tdx_module_state));
>	for_each_possible_cpu(cpu)
>		per_cpu(tdx_lp_initialized, cpu) = false;
>
>The logic's not bad, right? Get the handoff data, hand it off to
>something, then go set some fields.
>
>Then what does this patch do? It goes and globs a just huge blob of
>TDH_SYS_SHUTDOWN errata handling and implementation details right smack
>in the middle. Our tidy little function is no more.
>
>I really with this would trigger folks' gag reflexes. It's *SO* easy to
>fix. It's *so* easy to keep the code tidy and hide the dead bodies so
>that the logic can still be followed.

Apologies.

FWIW, we can add a tdh_sys_shutdown() helper and hide those details there.

From 987b7107d79e94d1d35be93bfc48cbeb9ce6741b Mon Sep 17 00:00:00 2001
From: Chao Gao <chao.gao@intel.com>
Date: Tue, 31 Mar 2026 05:41:30 -0700
Subject: [PATCH] x86/virt/tdx: Reject updates during compatibility-sensitive
 operations

A TDX module erratum can cause TD state corruption if a module update races
with a compatibility-sensitive operation. For example, if an update races
with TD build, the TD measurement hash may be corrupted, which can later
cause attestation failure.

Handle this by requesting the TDX module to detect such races during
TDH.SYS.SHUTDOWN and reject the update when one is found. Report the
failure to userspace as -EBUSY so the update can be retried.

The downside is that module updates can be blocked indefinitely if
compatibility-sensitive operations do not quiesce. In that case,
userspace must resolve the conflict and retry the update.

Do not pre-check whether the TDX module supports this race-detection
capability. If it does not, rely on the TDX module to reject module
shutdown.

== Alternatives ==

Two alternatives were considered and rejected [1]:

  a. Fail TD build when the race occurs. This would complicate KVM error
     handling and risk KVM uABI instability.

  b. Allow the issue to leak through. This would make the problem harder to
     detect and recover from.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/linux-coco/aQIbM5m09G0FYTzE@google.com/ # [1]
---
v10:
 - Don't add a "dead" TDX_FEATURE0 bit [Sashiko]
 - s/BIT/BIT_ULL
---
 arch/x86/include/asm/tdx.h            |  5 ++--
 arch/x86/virt/vmx/tdx/tdx.c           | 34 ++++++++++++++++++++++++++-
 drivers/virt/coco/tdx-host/tdx-host.c |  2 ++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e5a9cf656c07..c848483d815f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -29,8 +29,9 @@
 /*
  * TDX module SEAMCALL leaf function error codes
  */
-#define TDX_SUCCESS		0ULL
-#define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
+#define TDX_SUCCESS			0ULL
+#define TDX_RND_NO_ENTROPY		0x8000020300000000ULL
+#define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index ce548400f7f5..ed974106ecfa 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1274,6 +1274,38 @@ static __init int tdx_enable(void)
 }
 subsys_initcall(tdx_enable);
 
+#define TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE BIT_ULL(16)
+
+static int tdh_sys_shutdown(struct tdx_module_args *args)
+{
+	u64 err;
+
+	/*
+	 * This flag tells the TDX module to reject shutdown if it races
+	 * with a "sensitive" ongoing operation. That eliminates exposure
+	 * to a TDX erratum which can corrupt TDX guest states.
+	 *
+	 * This flag is not supported by all TDX modules and may cause
+	 * the shutdown (and subsequent update procedure) to fail.
+	 */
+	args->rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
+
+	err = seamcall(TDH_SYS_SHUTDOWN, args);
+	/*
+	 * The shutdown ran into a "sensitive" ongoing operation. Signal
+	 * to userspace that it can retry.
+	 */
+	if ((err & TDX_SEAMCALL_STATUS_MASK) == TDX_UPDATE_COMPAT_SENSITIVE)
+		return -EBUSY;
+
+	if (err) {
+		seamcall_err(TDH_SYS_SHUTDOWN, err, args);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 int tdx_module_shutdown(void)
 {
	struct tdx_sys_info_handoff handoff = {};
@@ -1295,7 +1327,7 @@ int tdx_module_shutdown(void)
	 */
	args.rcx = handoff.module_hv;
 
-	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+	ret = tdh_sys_shutdown(&args);
	if (ret)
		return ret;
 
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index f8075efff11f..9f68a8aa5380 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -137,6 +137,8 @@ static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
	case 0:
		*written = data_len;
		return FW_UPLOAD_ERR_NONE;
+	case -EBUSY:
+		return FW_UPLOAD_ERR_BUSY;
	default:
		return FW_UPLOAD_ERR_FW_INVALID;
	}
-- 
2.52.0


