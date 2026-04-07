Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87E3B389F;
	Tue,  7 Apr 2026 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563370; cv=fail; b=oJlEFfqyNKeh+rPg/yqMEb+jMVhvfBHwctUKtEzeufa7wgtCc8vBXYKOWP0ZQqA2ObvOQND6gR8tk/1YsWamTn6SFQ95wa8xHmMhnhVTaKtvDNpM89BrDxvPD4suzgFUwr7D/mY5lZWK44tvQtqUVCb/Ppl0zXsf5qY19mbWrp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563370; c=relaxed/simple;
	bh=jxJpTj3qwad1RCd26Gd/HWEJ0gGzcKuvRjdtiAvECmE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=akaL98x+YwoZXw7k5DpQ7xkgWECCoUoIp9K6hwk8jRRYw+o7pfcPnxWW+oZYBbdYwjnzWqTEjaF2PUUFVhJxEqx4l7HyKUsmAyxZ2rZN4s8Tp0Lv1S4MEjXEfjuUGY734L38p36/prJjnBFmen3VyZrU5WtG5C6qQcjTTkIWZf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDWQ8PjN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDWQ8PjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775563367; x=1807099367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jxJpTj3qwad1RCd26Gd/HWEJ0gGzcKuvRjdtiAvECmE=;
  b=SDWQ8PjNxYFT1b8NVGC2p2W/FeMPmAP36P4VGbG0KGewfw2rO19mvvMn
   uXfDxqcQ8OprCxm4mN/tjl1QBRaaBPwX+kvEM197zaMUeiFNF9BVhprbH
   qGbmZCMELjwK0m1iTi6iBfCmzlRQMWZ4GAyIKj9aOWMd4IU4HBx6zhmM4
   0HLJtIQM1PUzIyqhvLpKidj9U1H3SlOFJ7yKzjCPrfvcinDWsd2UhMs38
   SRXE9uLkztvJcoys/NJxpz7jEtu2w/ghM3AXOmUaIstxzich+JS2Nirgf
   u0Qom6d1/KTVuQtAMz8b/UlnN45htzivQ8dB4Y/ezL7pPimtIKWYl4uEB
   Q==;
X-CSE-ConnectionGUID: qkpOptoJSDqEByQfqGZLBQ==
X-CSE-MsgGUID: eGxmWynkQVGfPzkl2S+XGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="99151279"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="99151279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:02:47 -0700
X-CSE-ConnectionGUID: RYLYjNWoQ5y8rpXOD1wtSA==
X-CSE-MsgGUID: n59QclScSxOd5ZZ6tawo4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="227153033"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:02:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 05:02:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 05:02:46 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 05:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aalfEDCFtGAWa6Ig56SOtsMW5l0D0Q9f+NyvY/cgmiLBw6a0VboQlh9OfX3FEQnlrJ+65BCbUm8DT5UHRdsGeS6LBM1gnr3vKMRYIWjun5IbJtlghcZEXnnxpNiOdn2/nCTsUPdHo5kZJBRp8CWkk4XAdJfnYpIJIkd/+QEZHaADUpiW4Gi4pCjT7P2v2S5tCdOTpSG7RsFRBhTLP3PO/SeY114C2MYO56F5eajBuUqcnlZSTZZS+mNbrzLaSQIkac4BgfxwdohXuhqBFBDvy3OJO5AhAlGNlOTWf+kqSs6tP8S1tjlTLY9g5f2um8dhv+Vy5ctR219op/QmgQ3Kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrMtG4V2y8CDxTUzvcOjHCMOQxWRj3kLwqlVbFzZfr8=;
 b=J/dtB63AWk6RtNSAZYvNTViiVun3xUBQ1jgbP6AGVVcvSLcM/llFVZ61aRD/vpBL/ySMWJJJhP97gcUmTJBr/oY/9CZvWwNjdqJvqBzjJYEwzoL6GZz4UHKxhAxXy6O3gpahnXLE11HtoMK3Qge8dQYIIlYf7f0Sa7+XaXKxFNdCwHnV1AspZBMq3RbsDxR5zEIOaS+HYZT3AfDinuQOcZxT5fvhNvKtvDZnmNvKXHS9Q5JaBVuvtLhu3t5e0ncRRwf4boWUFdVvCtXx4anCJbfWp3mKzfx7ylW6f0mjx7tc/jtBKaXgJja6FtzxLqfSfcDcmnOpGmZ2V9PPnnWgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CHXPR11MB9649.namprd11.prod.outlook.com (2603:10b6:610:2fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.38; Tue, 7 Apr
 2026 12:02:41 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 12:02:41 +0000
Date: Tue, 7 Apr 2026 20:02:29 +0800
From: Chao Gao <chao.gao@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
CC: <binbin.wu@linux.intel.com>, <dan.j.williams@intel.com>,
	<dave.hansen@linux.intel.com>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 12/22] x86/virt/tdx: Reset software states during TDX
 module shutdown
Message-ID: <adTyVT1D/qywq3xP@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-13-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260331124214.117808-13-chao.gao@intel.com>
X-ClientProxiedBy: TPYP295CA0021.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::11) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CHXPR11MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: c1794a76-8b34-4eed-733c-08de949d91bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 55YPALrs7EKpGnzMfISn2Xl0pPeurIFWElTotARY8UVLsHa9qvG0jHG/6iaaSChZByQ5mwkq42dH3cnMIq3VLICBvy5asJ0NcFpVXUW87kJnnFrSlHuJbTcBgdpgn1ge9PLTNvkg97608QkbFA4AfIqSfMT/U6QegoFlq1a/m3fAjWdwNpozcP+Dg3++RyHZN+QcYm4TNQVN0ayEHbF+QOjWuR/MUdyRc4omS1U63hlfVy3o5UrCoGeozt5YnkLGsBCK4idvf9u4zeAxWYxB6f5ouxrkJW58sXOEamWlJ/dNbI99BYqlOEGXYUAi+yhN5gUYqJazfFml7M1ljuUQ0E6afK2ATCJc3TIDxP10+bechx9LstfmmuW1gO5Z4WGOqCSA8Z23V5PzKNQImX2VHYoWs7pHKr6DhHN3lHj2aReuobzxsUjs3U0bWwDRDzA+YN1SYypZhEUiCqhIh013tub1lcHVrkIdtICPFf7j8rhV+76EZJiNuzKc4GxXQRazILCl7g0x4Vd1ZhlwgK23g9H5vy0wbDiRnqiy3jfob52eFzgWVfmjRhVQqBcxgs3cwfQY7qk/gJQgEHfjkTNBR43Km6vsoRhdvm3O+Ar0OSuD4dYMQDibcVcL+ghf7YTZzSxiteijoB9pBJWd42kuTgyW8P0+Q1kTW5O8TRMwn1bqz617OVDhrsb/Yv7BDMCV4mHChJihICchn39nBwmRy8zWlIPgQzQCThTAJrPr5a4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F2JQtMLVqCSWWBewua2tr/3Nz5DO2J+CH8es6DzMnPdyoDPTUANAJpGomTxb?=
 =?us-ascii?Q?SCP0OmBwHzpk9jt8IKsLrWBKyr+NqFeo7oVKPhEkkmrfOckkzVShXOwCagAZ?=
 =?us-ascii?Q?Q++tYRv2RoldNAyXkwP5Aq1kLTZzBnkFo69d3JYXRP3iiVDs2CouctBlp4kq?=
 =?us-ascii?Q?D9cRHcK3EiweIWd4cPKCf8GzCxtJwjjAibG/pvfVyTIA+lSPViRScKCuplYd?=
 =?us-ascii?Q?xXfpRHaFEhsQBAj6X/OpcZ8f9lITPy32C93xQS29L3xrHEkSPx4qSZH7z9vC?=
 =?us-ascii?Q?IChPlJolFMEDkyQYE870AjRZ2BEQt48FjrFujUbNDyEOCdG83bhLuzbLKDUC?=
 =?us-ascii?Q?u6BxwSlSwo8nNca9KTeAiLpzYO9B6yn5/1kxF1ejTs7G/PcI3yD57ZA8WI1s?=
 =?us-ascii?Q?td5x/zbqJMTmNL+f4QTyWNj57qF4ujkll3wgg1vFDHmr4A+ugzCIo2j35LRf?=
 =?us-ascii?Q?K9cMd4Cc4mce79jOIa2sBYhwoqfYOMUZQcg1NU5VklGugiBH7E+fxJrieLm6?=
 =?us-ascii?Q?Om55cEA4PDu02g2YHEMsQAfz7OGBP987m9N6PXR7BmrSr75cftybqsgGwNJI?=
 =?us-ascii?Q?wDGrlZPqlmmH5JlaMetK8xUiit5pP5sWBXBkx25+XT6nAlPf/0bkl7a0qeLM?=
 =?us-ascii?Q?TPOU+CntfDH5kNSKWapJ1BvI+r14KsnfR3DshQ8k9umKBGRQPYyV65u0onix?=
 =?us-ascii?Q?/wkH9XoTjIqEIU5UmbojUL+7gf0PwdIoYmV4n3zszoOrTWSlNIoSelxnIZqa?=
 =?us-ascii?Q?dPQJPKQ28Pt8/xBG+d+JbWxS1CnKLhRc1F6JNcMwxgtqhQuSduNGFse61+Z/?=
 =?us-ascii?Q?jeNzjoi2xJnI33jVbeigWVmyrigmal1Cv7KxiQQFZmM9dzxCNwEKhls5n2fa?=
 =?us-ascii?Q?2LvmvfEa+EbVXwkJOE/sMO++YAf0lQOxZCOUbDGk91eUJCf6X9wBKWgovmv4?=
 =?us-ascii?Q?sZ4+3BohxzQw48HsjS+0VP6HSJOLXWJ+uebyVWwHWq6zFHESdcqn6GCuUNQS?=
 =?us-ascii?Q?RN0yTL5lLtI3QuFSJodqtxubqgnD+HkPYnmLa1mSH13e81kDx0iN9LBfn+9i?=
 =?us-ascii?Q?DaG/8xCh2DpqePgzF7fkcIZ5BKWvgVHDoDIv7/9wEng1s1p0GrwBMUgElzD5?=
 =?us-ascii?Q?brkr1OS5NSuc0KNssP65uxPPrWu3SFzdLFmtd0CGs8OFmeS6mQCMGARu6l9j?=
 =?us-ascii?Q?5elTQn5IrjaJ/GXuUEbEaJPz0SeERCk81txA6B+Js1sDZsuzCk8dPcIt1T+7?=
 =?us-ascii?Q?k6qpgttTx9JNnhCXW1pYBQ2c1Xp2QfpXbKDigEzoPIwgCOdWA+Te8zD3DRn+?=
 =?us-ascii?Q?TEyaGLDXjQdZ/TRVynTDTAUJjC8Df+RsTEUCJMgEZ0p2p3XSrOr37Nv0vNq3?=
 =?us-ascii?Q?PWZzgdP0nrRB96Ar1n4n/txzTGy70UP7zqxZlBppJ7wwGeLOzaX94K/xuRvH?=
 =?us-ascii?Q?9OL8OzPdk7t6FHUNRBqJl3mD95ouy/ZKguWiwrd9p1ynj5qYOCbBnywf6jk4?=
 =?us-ascii?Q?3v4Ep3AUGK9ulJ/NYqNQfn5BF5J5TS7i5PP3bsemXCHGuKJMovO9Yuvc1HEm?=
 =?us-ascii?Q?EcIac4Pe78sg93e8Dd6mjVQDbqW3lzTWprHHDDr/fiwejJG0or0E46L45toi?=
 =?us-ascii?Q?l71vE5UNZkPmq4urRbTQJAc7hsjbMk8Q/nN0uilnL/2/eR9bkodNoBWWuUGo?=
 =?us-ascii?Q?y1naMTN5UT88wFxFEtPeYCxmWzrL5k6bJdhz4X4/VQQOuf/zZ3tPIwYQTUIF?=
 =?us-ascii?Q?bB9WIHg3kg=3D=3D?=
X-Exchange-RoutingPolicyChecked: GtV2RuYS9Q2QumD5Tw+Y/ufImhxRoK42634ZUSD7I4M7Poo+aPmxSDIJE+BUZ0oAzYsWkzFAf1+M+wB+qonDZzvIm3JAcUnqPJHxJGJjBuGfjuh9xWecfEhtHctjWcYW4gLoQ8Ig8X8/HuKWXIMTVatdZdHKYGyedk9cRYGwqJNC4x9jxg1P/bFUmhzcobuPVSLCS4Xow8vNY0m9w9/xqUPaS9EvdIE700gAkWaBNGJ80NRcv2GBr1707avOHqBgzkW3XAyp5teBk1lnDMs1pUpnGfIrY/wvExJqz2QUPTXRAf00+bzH8W6jxy0bHfVnIvR/R47qKajtNmzJ5nsT+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1794a76-8b34-4eed-733c-08de949d91bb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 12:02:41.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +422DG9HErZpp2tVBHE+0OoElOvGIZ8dSZlSJ5ZKBXIroHe8+o9jG5telP6D3IiEpngpnC0CR4adfrPXwd85Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9649
X-OriginatorOrg: intel.com

> int tdx_module_shutdown(void)
> {
> 	struct tdx_module_args args = {};
>+	int ret, cpu;
> 
> 	/*
> 	 * Shut down the TDX module and prepare handoff data for the next
>@@ -1188,7 +1189,31 @@ int tdx_module_shutdown(void)
> 	 * modules as new modules likely have higher handoff version.
> 	 */
> 	args.rcx = tdx_sysinfo.handoff.module_hv;
>-	return seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
>+	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
>+	if (ret)
>+		return ret;
>+
>+	/*
>+	 * Mark the module is unavailable (in ERROR status) to prevent
>+	 * re-initialization and tdx_sysinfo reporting. Note the status
>+	 * will be restored after a successful update.
>+	 *
>+	 * No need to acquire tdx_module_lock here since this runs in
>+	 * stop_machine() where no concurrent initialization can occur.
>+	 */
>+	tdx_module_status = TDX_MODULE_ERROR;
>+	sysinit_done = false;
>+	sysinit_ret = 0;
>+
>+	/*
>+	 * Since the TDX module is shut down and gone, mark all CPUs
>+	 * (including offlined ones) as uninitialized. This is called in
>+	 * stop_machine() (where CPU hotplug is disabled), preventing
>+	 * races with other tdx_lp_initialized accesses.
>+	 */
>+	for_each_possible_cpu(cpu)
>+		per_cpu(tdx_lp_initialized, cpu) = false;

I would like to merge the two comments and make them more concise:

	/*
	 * Clear global and per-CPU initialization flags so the new module
	 * can be fully re-initialized after a successful update. The ERROR
	 * status prevents re-init if the update ultimately fails.
	 *
	 * No locks needed as no concurrent accesses can occur here.
	 */
	tdx_module_status = TDX_MODULE_ERROR;
	sysinit_done = false;
	sysinit_ret = 0;
	for_each_possible_cpu(cpu)
		per_cpu(tdx_lp_initialized, cpu) = false;

>+	return 0;
> }
> 
> static bool is_pamt_page(unsigned long phys)
>-- 
>2.47.3
>
