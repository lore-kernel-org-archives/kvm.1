Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710263783C1;
	Fri,  2 Oct 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944122; cv=fail; b=HeLGEgvqJ/Ay0Wk4E3jrHBKvq3eLFpj3a2Sr+/XiQAxh43RJRPBEpzJPPTjEA2zMl2nISB1xsiQNb8skqw+tnZqvBRB5Bq2cA+cb5cKzXLROraIcsOL9T93QuXTsViRpw1rk2JGldztZ8QPdpoz6l5p4SQEGhG1mja+ejmaXxNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944122; c=relaxed/simple;
	bh=36oRAIcWE8GIah3UAGGH+GRs8GXG37eagTvSDQhiYTQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VFtmzoWyeDOAzet5RaVy83+XpBtSb/OEoN4IC74e7XMJFahrpPfAtKpzT/t6QjZZIkoCQinZKBHtwqrPAsC3EASPpROhyFm6J1ko5PkdbLClFYTnmt5vdnFGMcpuAmYmMob7HpEVsqKbafQK0dBSEE+Vypobo4qKX31AB7s6/Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJI5ys/M; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJI5ys/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790944121; x=1822480121;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=36oRAIcWE8GIah3UAGGH+GRs8GXG37eagTvSDQhiYTQ=;
  b=mJI5ys/MnGrSEJYJfzrmZpaiILpER1KKQbu0CoKIMhCXkTdybRPBpUcw
   taBd1OBLO4Zv+PBYKzVPDS4LG+87I3cV0IrTwyVHuf70W2Js38dZBb9s6
   FzgThMM69T7hOWlR2WtFjp7TcjefVaywzrXgPvZ3zl6gJeTAeFVmbtX8K
   PHC9YtTt1PBbF9MQLOf7/XMpH+biseZovQtSaVKVH5hz1/jH4Ge8q3qiQ
   CFntbJxlH3pQ2hbm4UUe3WqTsKGP/SIMiTp+AhFpPbeW9IFzII4EUuQKC
   cUH5oeLf/W7Y+YNDtEOaKdOcSTFv7fD10GIeYh26VK1uJVtN9soL/KWg8
   A==;
X-CSE-ConnectionGUID: tTXKiZRrQE+ZUJUfAYEbpA==
X-CSE-MsgGUID: H9339MGxQMaWKbeiYm6HTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90920452"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90920452"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 05:28:40 -0700
X-CSE-ConnectionGUID: C78exmo6RyK9+LQJXaR4iQ==
X-CSE-MsgGUID: mIbEHSAfR0e6g0u0aJx2ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275359171"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 05:28:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 05:28:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 05:28:39 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 05:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQxU4p0XkkvAbzYlKPNBPYQkIrX+bKGuPYcnlAbwI+B4KJUIWQmQH9IRiNaWFu/Axvqcky0A9TC5Lz6wv0LMqzdgQ6sa9ZJ4zwDaAnXzYrNql7L2NVnu0lg/aWrfB8GnoFr7fWHgwrSpXbMdodDNUfggfAdEhayPAVJ/obIz4vAHRZQdsYDksS1csCcSfZ9RPCpuLnoQFIJDYohUZtPjLr43Il5M4vcKcHQEISP+LjKhqFtliEqQyrMBvRbXIdCJW9oO0a+/ulVDBuTsNjAfrC+WSUKiWPjRd05r0nmxLja3PLr+tsdrIOTqhqqNAdYsyBOyLsd3WtxMZlONbrg99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRm3qMbCDhop7e6Q4X+Ap8k92yjz8/ICeIylhKPEQ3U=;
 b=kWSnHuBEsZ67riQZbb279FUmDXaboMpx+U0UEqm3r5jWEMLG4o3ArCVVUYb2OPH43ZNyQ4p9ndzUHa3zA0CN2Ot/Q0hfPOyVFmMcevb34v38VqPn7Q7elumpmLvsYrwKc22KMtt/3eQANTpnwlm+UpNeCnKT026XdezuW8/vEWxFuIJAOGEPSdrSaGtJj/NHjMyWZpi3WPehoY8hblyGJ8WFlxoMdPxYi/10ZxbF2Ab63Mqqsb0N+54KFVXNY3ZvNjZlK2kRvNBX7q7yQsB4dZ/VnsAUMe2Wt+vsMTM9Zhf2T9lnQhlGQ4WHVtfiuv5wR3nXVG73rP2L4/9TwNuzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 12:28:30 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.026; Fri, 2 Oct 2026
 12:28:30 +0000
Date: Fri, 2 Oct 2026 20:28:20 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 07/10] x86/virt/tdx: Convert the td_conf metadata
 reader
Message-ID: <ar-jZEtCnt1Xwi-G@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-8-chao.gao@intel.com>
 <763dcf982570e0ffcc69a6e1922fd2cc266539aa.camel@intel.com>
 <ca464aaf-1935-42ed-b486-4f4cb84ecd2a@suse.com>
 <48ed6f1bd588c6ccab398c5310fb1fc073c1e53d.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <48ed6f1bd588c6ccab398c5310fb1fc073c1e53d.camel@intel.com>
X-ClientProxiedBy: TY4P286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::16) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|CH3PR11MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: b8636e5a-cdac-48d2-c830-08df2080aae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: m4jz+N77hppgvWybR9L7aeV4CllM4dRaAF/GYZz4WEbmSDqLrjVelAPwjZrFHGaJqwMNv/NqyjjdF+WZ0zwjQH/eNz6567/mTbaJNFYMpFEnfISvK9QEU+J5Cp40s4IUCYcsRIh3BLTr7yr+lKiQHVamN4uP6WOrdCzgwTYvqYvorwvT5K7giF6SHTtFY6ummqT4D/lBO8RKbxUqm40+NBNbRO8YVq86l1yGEVaBkWD+dAkAR7+IOltN8xGDKIp4vjdxG/c3SBpTh1tEM96beOAY2i0JxiEAmpiU5jMsmnv/QaeVjECPLjXlJ3ZQQ8twBu2M+bCSA39yGXvrXfEZzFp3Ld4OyJrUZH1BYk7MgwXbvHxFZHNelglxN1qb6ozhGtU/lLHuGFMFfYeCyK0p5MVpSsNc9fJUSwhGsueUqEvxgUd8kfRoQuuTqRTRdZs4jtTuR8x3O08ZlO1qvEqPExtOejx17MAKv9ujYOsusp3tldJUcMtQxqwwVFJpkNw5zVXRmD17WCRb/6ut2gjX74lk1DmB/mqzdIPRhuovUjV4+cj3AAlxADT+pUbjP+cJWo5M2900Su8jnpX9xAE/SCSFwsRwfBHSNR5oLR+urvDf2H6HZGuHSKm14Ip9pcXD8ZBmhjZ8rcVroFKwXaawtETpOGlYalKLyGb1ZOK96Qo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EupDluxgte0uXFzImrtXlAWZQTFUSZF7fjvN0adj+271sRv9vtTmi56kOqAG?=
 =?us-ascii?Q?2GIP6j1ZQ7RGM5ph5JUeGv+La1WeAwjU360/truOTji1F8ZfpRwj3d5Ss/6k?=
 =?us-ascii?Q?8kaRPyX3oUJLlKx1HF8BjdQMgwqwZv6ARCoI8qsq1gjGL3LVMx3Lg1VR0oNs?=
 =?us-ascii?Q?762We5kfnSuP/4w3BC7Id/BGcuHsqGpJYDfE9tXHT5Q0lRTNTbBszPO+zWht?=
 =?us-ascii?Q?yvfXTLQDE0YW9Nc50qLk7i+4iYRNB79tfKxIDHXrY7QuwhP063E8X6+j9NEN?=
 =?us-ascii?Q?6BY9zbONRl/a8L9L+2zwRVEIO9/GcnL7Zq9/u+lQG62SFZdTqK6GKjUGg4wB?=
 =?us-ascii?Q?ntsOS2TLidFqe7uQ3EmAOdMQrI/yrXudm6XgoHk8228torbq+Gi2T/FmNiN3?=
 =?us-ascii?Q?yAK7lOmdjgSwuqCJLs6p0b2iTVXGgI393z1PaTCqyPNhGjV80dsuLA8PMSkJ?=
 =?us-ascii?Q?3SaZOJXjjbQnZ1OkDVCx80xPo2B50Y0LLzEOzNquk54ra8hnsQ/zMEW5ybba?=
 =?us-ascii?Q?LVmASxp68wRSs+l1n/uHw2VPa5HGGSFnB5Mwh6VGsG7AzA6bC5VN4BYyGx9O?=
 =?us-ascii?Q?AD7KJN4SOe4Ryk05IXQud7NkOV1/SnM/iKZSQuwCydH2maZ3YMj3nwKTsVQc?=
 =?us-ascii?Q?pNhaCAeCl6EGlwyBCllp8lO/dPGgge+RHALDqUty8HmRcBylRugph1Eh9/4M?=
 =?us-ascii?Q?eaTMMYZySeQXneReTwEVrHi7uBPtxJPF9oiYvqMg6L2xRW5Wvn5E18v2It6X?=
 =?us-ascii?Q?nTQWPniXjS2/3at+4Nkf6sO3SBPJuHbH9MFR/ktdrjE1yx3/mZORUa/sEs39?=
 =?us-ascii?Q?n0iAdCXsCdY6L77m5R9cTmOANzr4Q2HaNcgA8l2qDU/U/ZaiOdUBE+hBgVPj?=
 =?us-ascii?Q?EhzoiLm/37l7z25Q4Or8Jxy+fU4xBvjiLwnTEE18rLreoKrwV9XoIlzHan7J?=
 =?us-ascii?Q?DiDilPDTulehuHT5hk4nUmwqsd7y6/ShezOfptaLqPC6LQWqVlKdIugA1wR+?=
 =?us-ascii?Q?7Tl7LwpTDahvJjv0wjvi0QJB65Bphwu9A3/8y8XadD4rg4N7ezJ+B9hTGUBZ?=
 =?us-ascii?Q?F4NpVeEJRZJq0evmFrl9Q+7jxmUFA0EEfkyNnrymlSuGSvlpLoxCB/NuifQo?=
 =?us-ascii?Q?MfmHlo4PMvRb/pcchmWuAB+8UJU5Iubyp2pzxtpsF7sQtyK9S/zlttiyz0Cz?=
 =?us-ascii?Q?KmP0CWcm5spLgJyu31hXiNjaVej0CrnYUNEba12QRBDTHmVnyI9U7K5SOuOn?=
 =?us-ascii?Q?/Quc3GI6d1ngutywdDoJEyb9Hdz5DmI979PJqBmKO7RrXLKgMSXSDonDrgXk?=
 =?us-ascii?Q?ArB06SM2OMlO5hxyQ5zYbt1eoSuRz4uk8NwJvtWpg3Q8TjYHdOGktrfTmwWG?=
 =?us-ascii?Q?j7RjanSF/x0s7+75pxpX4ORQTGZVeqjNKl8MnW7NWVL+BEP5a/9ag0m05m6F?=
 =?us-ascii?Q?RooPx1Wx3w2FR1IAC3X873MZwxMKiqzcCjvJP8qu3TYxeNvkwq7TZCXX6F2m?=
 =?us-ascii?Q?N5QSwoCCnJMXvRC7h3Dp0bA9zAenQjtKfjANVtUi7soKzivuAJYDFBMd3cnm?=
 =?us-ascii?Q?iOgAsIjyOQgKn6dVDbBvmB6PWGUR2mPxYhXHZNNK4JfdU+VHxvOTcx7LqQa2?=
 =?us-ascii?Q?hx/u9g2MmiJ+g8ulJNAjLu14LHRLfPnDShyD1tO7yvSlnBHVFBu/eHOcGdJR?=
 =?us-ascii?Q?lX8+94JDEui69n4e2z3l0W/EF0CQ+G8ntGpp3JCTHKbOIClEU53Nz2lXhilI?=
 =?us-ascii?Q?dXN0C8Oveg=3D=3D?=
X-Exchange-RoutingPolicyChecked: mKbJNgB1xWbSb66UcQ1lPe7XNAvJjHBrH8JsY9rvzVEGsPKECQ8wEU5q8yrThYLRbLCz7x26XPXykS1IO+13kGzJebDlqOHyhUeAL45hBVkbQYAThf/ma+IJ+ZIV1f0W8e0jJfNotUVTOpB+P6zxKffB0QuQpDuwmcGFa7qGZPiAKHi+Qn4hK1Rm42kveuF0GK5j3f2Z7ySz4Cjw1aj3RkPZ9ARdoDn3IIZJ8A9CoZJdCvxZEuALxmgawVcAUzeHhCXsr08ylwATUUXXERw5Au91OKibzp7yymSfCHqCx3KuGOFfNyHwrzeoxJ4Y8Le1DH85u7sf7YSHP9AilddRWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b8636e5a-cdac-48d2-c830-08df2080aae4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 12:28:30.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSoSLTf3Mdq0kug9IFNuX6Ys98GMsej2vrdp0InrVMAVIcOyD8QCnPuvQXbhOG+F0PlsDXqGIaSEOP3rSR4snw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8775
X-OriginatorOrg: intel.com

On Fri, Oct 02, 2026 at 04:28:54AM +0800, Edgecombe, Rick P wrote:
>On Thu, 2026-10-01 at 19:34 +0300, Nikolay Borisov wrote:
>> > The comments are not strictly required, but probably fit into turning this
>> > thing
>> > into "hand coding". I think it's a nice addition. I wonder if we should make
>> > the
>> > "i * 2 + j" a bit clearer though?
>> > 
>> > I'm not against leaving it as is for now. It helps that it doesn't morph too
>> > much from the code getting moved. But I think the above falls a bit short of
>> > hand coded quality.
>> 
>> Perhaps this code warrants open coding? The code will end up looking 
>> like config_values[i][0] ... config_values[i][1] ....
>
>Yea that would be a good way to improve it.

Yes. With one less level of indentation, all three reads get the same
shape. I ended up with:

	/*
	 * cpuid_config_leaves[i] holds a CPUID leaf and sub-leaf number,
	 * and the two u64s of cpuid_config_values[i] mark which bits of
	 * that leaf's EAX/EBX/ECX/EDX the host can set to 0 or 1 for a TD.
	 *
	 * TDX_FIELD_CPUID_CONFIG_LEAVES and TDX_FIELD_CPUID_CONFIG_VALUES
	 * give the field ID of each array's first element, and the rest
	 * follow in order.
	 */
	for (i = 0; i < td_conf->num_cpuid_config; i++) {
		ret = read_sys_metadata_field(TDX_FIELD_CPUID_CONFIG_LEAVES + i,
					      &td_conf->cpuid_config_leaves[i]);
		if (ret)
			return ret;

		ret = read_sys_metadata_field(TDX_FIELD_CPUID_CONFIG_VALUES + i * 2,
					      &td_conf->cpuid_config_values[i][0]);
		if (ret)
			return ret;

		ret = read_sys_metadata_field(TDX_FIELD_CPUID_CONFIG_VALUES + i * 2 + 1,
					      &td_conf->cpuid_config_values[i][1]);
		if (ret)
			return ret;
	}
