Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794456359;
	b=WBBfMV0X+NZKyzMiQH/vSqzGhNtFNshCR+XLN5B9Mhxk2G1ZlvQvDGorEnZcKdFfzC3K
	 0LntVXIWmXySfD9HCbvlkxdWCpqWBJW4BlVultj5RiFfJj01iQ6n97VUsdMLl0yewPLme
	 VBH1RD25I7VCeq00kr7IFTlsKE9DPWjxVd9xtyhqO9mfIZgYeGTDXuQLOoJ1C/lxdUWZG
	 hT4Zpr49XRw7iRe7O28Xr7lCRDISHaAsbjUAe+J+yAcuDJ6cQchuNS9kzevkb2D8PG8q/
	 3r3nXEfw3+uyEIrTAxN3llsYu4z/y6gfySEbO+mKd623MuTaC2G1OjmBUJQvMjEWg8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456359;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Dk4f7yqyCsI2cCGcSHNmkOtz9qqm5qPQTgUdsT+CWzs=;
	b=HJzZZTL42Xu7egYMuz4mkJcvlVnQGpk+iPloVufdNQmWXUzk4t1iD9zt2K2OCp2ORf00
	 AXKU/DUkPYsMkFyTF+51ur9wP1fEr/x0jbVNl5NhYpp2/3K1ryz3n8LTc0tpCxMcKBp4r
	 52htQWYUSM/pCbvWjcz8AnoVOvsSJPeS23fmBw5VDUMf0lc+d9gaF9mMDHgnsKrgSQi5E
	 1fRNphrlElYdh7N2h/1DxmkrTsVl/yIgzjKXteJVA00v+yvTSMbvI5Ug9fpQA0pm/D6Jm
	 Vo9ocJNzItoDwL4KIUN5Qmj7Sv4d12mnDcCpryvlOYOLrTWJUIwK6SlKAJSmK5cCCVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=biXfsrzC;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B59606A32A;
	Thu, 12 Nov 2026 04:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B59606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=biXfsrzC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794456359; x=1825992359;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yC2KF9A+9hoU6BoFmXo9IBx7KDWfc71LsCmph8Gl61A=;
  b=biXfsrzCklx443euOXP6lKDUpRn7HKl/U8uR6n4TL/rPQ4An59YdQSvc
   zurUzvWtMExOKK1BgGnZXXHZsWQsrMa+g1FCXNL5gKuB0iPZPumtN6WOi
   neQmAq+RMMhj2WvBH0oWGnV8cp8toe4RqJJJstc9IjrpeMilgUZhMfE73
   tMhVl8sLNAy5cSxDMKLK6RgWooNnPdb+Fv5tBZE2b0111RxJDJa2U80mm
   JGUIg9jLQpNYPRSEm+LeIGYGnJo/kTh3QQN4hZ7de52pLVzYtLve5HrhR
   AqT8jWj/SP5o320W46Oot/mnJf/vGGSjfA8xK/TiSyYFJv9JhTLL36grs
   A==;
X-CSE-ConnectionGUID: wDoDyevkTOyCILhJa+B7pA==
X-CSE-MsgGUID: CJFHXwLTTuCt/aJkntMVAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3327660"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3327660"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:05:59 -0800
X-CSE-ConnectionGUID: k6VU/dh2Rrenvv6wnPB5Kw==
X-CSE-MsgGUID: mYmWzRsSTmSA2bTFflbhMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8891837"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:05:58 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 20:05:57 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 20:05:57 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 20:05:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWnJq0NWFtcVylsG1EJ2pOAIorQ6173pAPnX7rfD3WYKuTXRkxtNAWObywUEsfgVYl7mEpYF3DEsBAxQp5fiPeIWNUToAf+2tE22i6L5RxIcUjcrj7Gm8NQMAlQW9/FXeMi5wBWhxEhhiiQf9ox/we4pVmLTw4og3a8Ti/ew109ZLm4DbFmu/b8VK2BvWv8Qfb9jYJPvTT21LfuRFQcCxNmM3Y6RokFib7bnkicJEhzIt1hL0loagqgFjaQsZypIq1NcF2lUEib6brExugMpObKwoNkok1h+ofRoIK5se2UA4C97NXe3lMKGEyhrvkD2Y7UMT8whZxaAANP3F6zKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk4f7yqyCsI2cCGcSHNmkOtz9qqm5qPQTgUdsT+CWzs=;
 b=anLHnKP6FEXN2bkXWIEsHuFM2LFir8y2ZMBDxbp7GVTEQGBWOn5DvUxNDtwRfY4aDho8u6+wL+4+1QOjbh22d+ZrdjY2bA5ZpVM8ObVLqWXVlEozyp1/PuG4rbj6rgOI8Ef3oRpCcwTgNmErY72vm61iOUIomzEHIo+Z3DItQEfqol1FALzYT7SCplhiWxXFf+7ERlBOMFmnXIS39mX48iBCZpJV/1w5BEdgjMVvopucnRSZK0+RNpSOrxr5sHzMNMtGM+fgB2yCYd2K1LE03g4NU5h2sS2Ag556rACYDLTBf5IT5SB91abMAS7nHqJowjbp59FPy2dKaSTOpGB8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by CH3PR11MB343702.namprd11.prod.outlook.com (2603:10b6:610:366::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 04:05:49 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 04:05:49 +0000
Date: Thu, 12 Nov 2026 12:05:35 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <yilun.xu@intel.com>, <arjan.van.de.ven@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [RFC PATCH v2 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Message-ID: <avU7Dz3IFylm7Tae@intel.com>
References: <20261106132159.1551365-1-chao.gao@intel.com>
 <20261106132159.1551365-2-chao.gao@intel.com>
 <avShYPmuMItx/tsJ@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <avShYPmuMItx/tsJ@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|CH3PR11MB343702:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2b6d8a-8f19-48ab-4c98-08df40723c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|22082099003|18002099003|261009223027099003|4143699003|11063799006|56012099006|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: HDoaYJM3546i9esjlSEHI0lvO9ZJr4QZkoXQz+Ewv9UKCGWKoNBbE75MxR8WWUuT6BkwSc9fp1lKE+jNmVuLEQi6/t9j7oLcSPved1mxF0qmDdkR1i3DtrSJ070rcQzuWrOY2uIpBI8+N1bb1vxx8DYLGEqSzBdknFKuaB0CxT3PPO1pskqByW0yOD7Ec3GdJNErmJrsTGpkSY3kooeXUipxkj+1nJVEikQCGY18IsRVs0cY4dRgvJVLKHfnoC0bXXpjfYiek8Gi8PjxKb5I226JFWarIQU+Sv6+qHWWY8ygpOVd3Wkiy/j/LiW/awoH8ETQNy44egPnEWimPdzOl8oioSUfEMtuyfEHo9QxEVSNo3exgQsTQmuiu35zOhyVZuzJFYElfy8H/MRbpDmqVki2OY8zx7nDk3XDMsZyWtxflOWQWkGDS6Sr+lPwzQW5Vp7+j5vRu3gNmpu2YyRL3mm63ryOAfHhMRvXhmJdBDDv83OOzK8RL7vjMiAq3ynI0ChwthfNVIRO9QqCSoto88jJHakvBGGAIRfbSg2w2Nyvbno2e+3QsYgBAR7yN84frw6fZ7fS0fktAcjfCNVfrcBabvwexWa382EGFBphPCcTITCO6V9xMGyBwdnzxiZ+F+jetWmGS806wpkXyKTA0rjoc4ZZlIIWi//YkiDGyCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?roA4XuCIbb//8rfZE4mDgb+9LYVWccYQCET2ysw6GcbLAsN7ud7nXirjQbe3?=
 =?us-ascii?Q?H7NboAP6q7yPzfTE2aa3Os9ivn+G1MuLiQSx0nknaK6sxQrhkGai9VTnqfmc?=
 =?us-ascii?Q?BlH3mP6xhDuxNyHoqiej+l1FP+X7xYivYgWrGSk8mGAdo81N1L2RLgCAR1ZT?=
 =?us-ascii?Q?3kd6tYAy63qwm5jdj+mFrE4zs1bf0h04AJZ6wc2ZXANdVj2KHlFTA/E8tGeE?=
 =?us-ascii?Q?Klf78zPBDQQVHkloZjekYs24jlBohamyTwvNvLILFcM3K9Q4jnjXhUMf4AlU?=
 =?us-ascii?Q?62h9PN2j0UvRrhc9ofQddDGuEkjrjGsT/veUaA5cgX2CQejM5zA3Hty74Qvs?=
 =?us-ascii?Q?S8c5tIkuPrQjq1J1N6qXfrgeGOormjYWF0dGg6ELwXuyIqhD7MTuvMWYAGsO?=
 =?us-ascii?Q?3QBH3SrhH0rn1jsQndrjuwE0QQCQjaTsfbzIhhik5PlpczeTWM85jjDF20qV?=
 =?us-ascii?Q?Ddau+VEEIXVbm38GfqNYkoPlwyWsq14aKXtdR3Afv37gvDFHr4txxSeNrQX2?=
 =?us-ascii?Q?cduT/oBIR7ZoOu4Nixnhds+/pwWadGOr+cvuhmfIr4yX01J5OpISF2FyQdGu?=
 =?us-ascii?Q?lOW+yRSrlxmNtVmlYSJouw4QQuKMpJO2rfytSPfmWmc0njGrqGT8PMfhULkp?=
 =?us-ascii?Q?J+0MXHH3vaa4zNHZyMlL41BggxpsPDDP7QTLmJkXmOhDzeDAHnIQqptjHkRp?=
 =?us-ascii?Q?ly93c6slL9vyHvYT2Q4UlqtcwgCfu3x2Fu+xIJbBvzh8D7+sh05VcwIXzLZJ?=
 =?us-ascii?Q?1QT54P/qqjZAblCnnikQ3tfYJmB02q4t8pUmkjXrf+iuSeTjbtUfbcvXMxGh?=
 =?us-ascii?Q?qjr4p/H8Zh9rGHwefF5IGplsPtRnSgpv7huADBAFFKvK9kOzC/QYbx8t5qWQ?=
 =?us-ascii?Q?vlJ42xzmZnJEtERiCpjdA8U2bwd4zTGBEtB6HVd4CswiyMMqTCYwCY3zRGPM?=
 =?us-ascii?Q?SD5QXqZLI5G9IYbtIDsuUtlClT889En2l76wC8sTSCEuTMBbF3CTOmpXLAzD?=
 =?us-ascii?Q?3XMq1m7zp2uErgjjTDeOdI+0piXlNIOricso7eNCJhXI1ENNiwNZR8aKQzwz?=
 =?us-ascii?Q?x/TrY+0mAYee8vaiWifc/GO9mx77p0vlWAkT8Sl8o8zeIV1gMGrJcctOdmsI?=
 =?us-ascii?Q?Jr2mVJXkCDj8uMC1K3tRSSudWlMLGNgIrARguk3/sgq36OWSQgzBUVWIarQC?=
 =?us-ascii?Q?iDyxwjDIr1pT3Uyv/eFgUe28AiXA6/UFKgAX14XKmicq/u/oGdlc2b22DlTO?=
 =?us-ascii?Q?9nkfqvthckUnUctaSQQmf39+LmKQEk9dCVKUeONAy8gyAcF5ilZlINAHcNah?=
 =?us-ascii?Q?TnFjE5AszKyvWFURP7Tf406V9r9WqMQ9iwK8P5E3N9MMSWV1Ooh3WiFMNOy/?=
 =?us-ascii?Q?gi99OwCDrKyorLv9vym7bPppT+oLtYDdfh1nG9PDDT48fMSiwsrGQoqnBuqK?=
 =?us-ascii?Q?vEEDwKv8Zr3bG/7iTN2ZU8gv8yB6XijSIGUekkF3XKC2P+ImmrgocxWUEfy9?=
 =?us-ascii?Q?kfUxme6l1W47Clp+0WKskHhqol2fv22No5Fl27MqwjkYKokQlicZr1JY0K50?=
 =?us-ascii?Q?BNl8zAQCFkSVBfD0Z02kFJUcF8OESLNO57J0tEfsYM96oTyYVq5MhnsTJQJZ?=
 =?us-ascii?Q?sCxlWx+olnxJwpCcPh2KfKH57l1hK2347bg5v7ya/mOzzcLpaQLwHnUQq7dN?=
 =?us-ascii?Q?urgO2sbIABf3PTueHnyFwIdYOdGx5ajKD8pLpDNoSgWpmjZ+rUWJCKwus8+S?=
 =?us-ascii?Q?mjmrg/zfcQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: CxQOve/QDoBAZZbSSfR2xaEGnBninLbMvM+fky3hAE0rqCpgE7nb8WG0R9su8VX/7amkOkXFd8BbPd2A4Jou7boVn7cYmE7ZOijgtnLq1SXq4df8aYlvZ621c9Pqtkvy2sspYs7AfBa4Rqd+OUOkn252L9R5DsojUXKAM60piFjyOLOQMsQhR7ZFFIwZAsgLMsl17HLMf2/4jGf2xEV8xUHxB3FKQHm1YdsGHpL7p9eyIlqFacADWkU2mIOQlNe66w+q064UD7rPAvafZIaMCOV6C/jIIPZ5ylHYnBbl8QdTvTFHHEnHFTl9u3oztzcULHR6zmLaToBDwiQjp0UYmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2b6d8a-8f19-48ab-4c98-08df40723c4d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 04:05:49.5566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV2+p2rMc9jltxSuX0PooqaaoFWTQjBBWIkSrHiJEvttUTE2cQ9dj+juSANfX1k/3bFYU+01oiyp5A1BUKiZiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB343702
X-OriginatorOrg: intel.com

On Thu, Nov 12, 2026 at 01:09:52AM +0800, Xu Yilun wrote:
>On Fri, Nov 06, 2026 at 05:21:55AM -0800, Chao Gao wrote:
>> The module binary is handed to P-SEAMLDR as a list of page physical
>> addresses in 'struct seamldr_params'. The list has 496 entries, which
>
>Is it better we specify why 496 entries?
>
>  The struct seamldr_params is contained in a 4KB page, the first 128
>  bytes of the page are the metadata, the rests are the list of page
>  phsical addresses for the module binary.

...

>
>
>> caps a module at 496 pages.
>> 
>> TDX modules are gaining features and are about to outgrow that limit.
>> 
>> The P-SEAMLDR ABI was extended to chain the list across 4KB pages. For
>
>With the knowledge of the first 4KB page, it is nature to say the ABI
>extends the list to more 4KB pages.
>
>> a module over 495 pages, the last of the 496 entries points to another
>> page of entries instead of to a module page. The last entry of that
>
>Maybe we don't have to emphasize the 495/496? The last entry of each
>page points to the next page.

I would rather drop 496 and 495 from these paragraphs. Readers do not
need the exact limit here, since the code has the numbers. How about:


The module binary is handed to P-SEAMLDR as a list of page physical
addresses in 'struct seamldr_params'. The list must fit in a single 4KB
page along with a few other fields, which caps a module at just under
2MB.

TDX modules are gaining features and are about to outgrow that limit.

The P-SEAMLDR ABI was extended to continue the list on more chained 4KB
pages. The last u64 of each page holds the physical address of the next
page in the chain.

>
>> page can point to yet another page, and so on, until every module page
>> is listed.
>> 
>
>[...]
>
>> -#define SEAMLDR_MAX_NR_MODULE_PAGES	496
>> +/*
>> + * module_pages_pa_list[] spans multiple pages. The last entry of each
>> + * page points to the next page and does not hold a module page, so the
>> + * maximum number of module pages is the array size minus one entry per
>> + * page.
>> + *
>> + * SEAMLDR_PARAMS_NR_PAGES is somewhat arbitrary. It allows modules of
>> + * up to about 32MB. Increase it if modules outgrow that.
>> + */
>> +#define SEAMLDR_PARAMS_NR_PAGES		16
>> +#define SEAMLDR_NR_MODULE_PA_ENTRIES	(496 + 512 * (SEAMLDR_PARAMS_NR_PAGES - 1))
>
>The number 496 is not meaningful when the seamldr_params is no longer
>one page size. We need comments to explain how it is derivee. But instead
>of text explanation, is it better:
>
>#define SEAMLDR_NR_MODULE_PA_ENTRIES	(SEAMLDR_PARAMS_NR_PAGES * 512 - 16)

The 16 here would still need explaining. It would also be confusing,
because the macro right below subtracts a different 16
(SEAMLDR_PARAMS_NR_PAGES) to get SEAMLDR_MAX_NR_MODULE_PAGES.

>
>Or:
>
>#define SEAMLDR_NR_MODULE_PA_ENTRIES	\
>	((SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE -	\
>	  offsetof(struct seamldr_params, module_pages_pa_list)) / \
>	 sizeof(u64))

offsetof() does not work here. The macro sizes module_pages_pa_list[]
inside 'struct seamldr_params', where the struct is still incomplete. The
compiler reports:

	error: invalid use of undefined type 'struct seamldr_params

How about:

/*
 * module_pages_pa_list[] fills the rest of 'struct seamldr_params' after
 * its first 128 bytes. The last entry of each page is reserved to point
 * to the next page and cannot hold a module address. The last entry of
 * the final page is never used.
 */
#define SEAMLDR_NR_MODULE_PA_ENTRIES	(((SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE - 128)) / sizeof(u64))
#define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)

>
>> +#define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)
>>  #define SEAMLDR_MAX_NR_SIG_PAGES	1
>>  
>>  /*
>> @@ -48,10 +59,10 @@ struct seamldr_params {
>>  	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
>>  	u8	reserved[104];
>>  	u64	module_nr_pages;
>> -	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
>> +	u64	module_pages_pa_list[SEAMLDR_NR_MODULE_PA_ENTRIES];
>>  } __packed;
>>  
>> -static_assert(sizeof(struct seamldr_params) == 4096);
>> +static_assert(sizeof(struct seamldr_params) == SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE);
