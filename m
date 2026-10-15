Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A02D2394;
	Thu, 15 Oct 2026 04:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039684; cv=fail; b=a0CyvE3dWC2A2tUYIE4rHE3go1m7Vbwhn8zgyAS1fPT4cXy/Ujsl8sfKk5bJekqnrbH2MLIOysLAKw7iyxVfxAUP8RHKZCP7l1pGDGSPMC2Dvq3JoDDQMb6CBRgKopVQfgPJODcoynIfiKHcC7QoxILJEDLeTsxI7SxJ33tmaYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039684; c=relaxed/simple;
	bh=bm5Xd91C8vitf4mKau7RvmIKlmqWDYpDH3FKjvDkwog=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SZoCA3Gw3fFlFFf4j/iEw2trdI0wZJIo92Rm+/yD02rSsngJsOdZXE8rn4NDPK3WB1g/+sMwMVgFJYMiQIWlrP4icEAuC4GlGqz4H6fs2f4KNky6+JOU9hcJxG3x4CxJno6B2f5gqBAP7bUSDeo7FGIKEaon7e8e0nrW+NYJZrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ppd9Wk7P; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ppd9Wk7P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792039681; x=1823575681;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=bm5Xd91C8vitf4mKau7RvmIKlmqWDYpDH3FKjvDkwog=;
  b=Ppd9Wk7PUMLxuGUY5bP2gfZfVWqeWiQ69spsrTl5X6xI9q9GVMDRzRGs
   9dNx8qeGWMuekq9QO83jTYHMSEPco21nrqwnhDI8D3k61mb2OjiOsUtsb
   YGtIvx6SyMrdSdALRgrHx4SRQHcaeFZ0YQHF2DiptQreVjW2ZOrXif1Ts
   sPi7gdpMaSOn/VfyTafH8L+OBTsCXXrvsQxmqPLbEBhzUfMy4KXTmNjzz
   3J2dDb2J4A9i9jAiwlkuVb1uUdbvnWf1iZOQSgmCa0xysMRuoB39VDAxd
   i0eMAXxyM9Z97v8klBfeJ6LqorxdYqdAPhgHIbgpEhH8DZZRmbOU/nqkU
   Q==;
X-CSE-ConnectionGUID: fVN7nBspQmSsjRYMiCWYQQ==
X-CSE-MsgGUID: LeN56e1MRl6g6TyB9RdkQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="807531"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="807531"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 21:48:00 -0700
X-CSE-ConnectionGUID: s4qSRAzSSkOE2uBn3CBGXg==
X-CSE-MsgGUID: zCC0z9p9Qwm58FsF5iPvTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2062410"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 21:48:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 21:47:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 21:47:59 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 21:47:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbIReITkjt7esSSbT42iPZMYQqRYTMYT7xDVvyZnioOOqQsjsJe6clGSdjjUfNHorxTzaZGu/0tMa+Ol8qYb3nmLFvq3Qc+Qn8r+IuiCqEjk+Yd8o1sIUXnuxMHggjazNZcgsD2h81fgSQm0TrqUKetPFezT/Ns6Vmbiu/6YcHz2JqS2Zk5SUKIqC96pq36R42UK/E6I9mM18Y5wUiMm2XeHWtn3PKCfFEXV5aTPh7dOuO65qYSN4F3L5JbQ2ySXwJIwwvA2m/g6lKEeN/q74ycT/+ptJR2+Emxa2oNertpdRrAIAHUqiq+uLngYijnG3xGjV/xy8ky0vfo1r633TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7RC9Yqb1ktei1c3RfO4q+HFQYMqDk8nE4t2zV2U4fA=;
 b=MdskrfLZ8V/R3F2T5OdqMlGgjZqoTYE8S+ljqM6VTz5ZZ4Oq74r/CPUwi2RhaRhVfEyKFrYjSEcoXnDa6BsWvc8RrwWzSjjv1GpqTi56bVkyA+ZlRM1CfiD/bfDyZEGF2r047eRfrBYvpZfQv1HXhTJgJFs9TMaE/epG3TWS1v4CLQ5QlM2v+L1oeIMYR6L9oTrizpdOnDyLsZ9nvI9inOwSYKo5WanahV2YslEmsSNbW8U3/K3gIPQMZGKtZ59Ih2vrdlTTvcdU19agxpNrbwuJUCI9McZXl4PCsFruBDouta8n27FMiKl0k5ieFVdLVJ1fFGHhZeqM3FmHlaeTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by IA4PR11MB9419.namprd11.prod.outlook.com (2603:10b6:208:564::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 04:47:57 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 04:47:56 +0000
Date: Thu, 15 Oct 2026 12:47:03 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091035.15599-1-yan.y.zhao@intel.com>
 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
 <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
 <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
 <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
 <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
 <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
 <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|IA4PR11MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: e4da107f-6a1b-461f-1256-08df2a777b3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|18002099003|22082099003|10067099003|11063799006|4143699003|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0ko+nNQ02OIs+qzrpZDf3tJXjtKF+8x82IJRPpUK+sOASYrDr6xzPtkNkUXc+j/u3grQjplJP8wbLRLhKidnULdA92n5hcX4RUBXbGCUwBBnURLy0wnfKzDfldN350ZXtj9lT6G2+xV6Nw2iqYfLqmc3npuSgVgn3/BM4Vj1GMizQnhyvrt4BB0YuBLZzBSM687BqvZa2ZWuRmwZe9QojhwsQenOuX45Q7Hl1bK2nZFDRn+mQXpaskjUDUkKNQrxMjiRhSQBkskq3UeQw2icu5T1h/QykMaD2E3hY4CuOnzlwIjrhHot3xYgyYEFijwJucq1Zf7cBIEXVd8ri157KhaU+ksvvhVP0+SgCzQ/tt9elaEQzkNsR28crOH1vTJnY6CnrmRv9ttlpFbpGlFL/NV9TgvYsHbul+0WDTbVZkHtrf1CmjG4GLbBQHz2vdmmzvn1y+zi/Q1Dgc3tdqvkVnoy2NnFbVY14Yn0Buf/L8pt4KVfgIJGLPhGGsNgbkFnfo6JuxuFz16IqPBheUJQClubvBpC+Ixd3Qg8CKndbZ0uhYjF4XLnBZFqt1pzBunQa9Y3tRUU2ax+OQUlmobr7M2v5N7Nyfgs3a/n9y6Cd5qNBP1/eolouaEIRq9jP7/X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NiKPemwLgueWwcPy+wnxhfQXeVQA1Ep4aYbiOVyc2E/XjpDCMRLwBkDBQqqD?=
 =?us-ascii?Q?aaJ7dRe4a+80FIyv4zqGMXXgxAzx2oTTyynvNqQK5D+2Mq37yeMwqVEuoqGp?=
 =?us-ascii?Q?MSwwtJ/rDmPYsDGXcPF+tynCwAxmFmMTRrvsgjq6lLafgumaCRyTa/9rGb5B?=
 =?us-ascii?Q?EawrZhCvGM2wV6n9Js+/s8A7vyGWavTku8P70xL4XUx98TeGj68/2VOnBdlV?=
 =?us-ascii?Q?fsaC0AUyc8zKIG1j8fs+FTLyz9HtIhvhlJdArnTLQ8fy6csYGiparGSVlsf7?=
 =?us-ascii?Q?BpmmHJrg3Sii4jVxzdcOxI5P8GtXQCF3/NLOytBwcKSTTPdfc4HWC58ZLpKS?=
 =?us-ascii?Q?KnE9o+iEjOc5yUbyhiDCUVxRyeighRaQ+hITfYjEDgo5F8FPcri/jghdW4i/?=
 =?us-ascii?Q?igwNGbgkn5/Hh/HYL4b+lqdEouvNvAE2h7rRN5UD2D/JjskRK48RDrLKHE80?=
 =?us-ascii?Q?DEw8+plkizhFERmxcEkgq9oRfB5qSrMNCp7vlJV3aOMbDVCA2kpSsae9SNA7?=
 =?us-ascii?Q?KlD5MD/P5KNSE07RfxsWNrofiAr3kAMro75V23j30Z8ngejTbsgoog8zjG5m?=
 =?us-ascii?Q?GWjnfbMPCMjdf3ofhe3qhrnetGAGIq3gWgFPaLGhE7Puj3pryadPO4ft34xT?=
 =?us-ascii?Q?WrT7kbN0QT4EVuCpbC48PK9OsBu2r3AZWYMyR/u7tdnBAxnQdOwGYdPdxSR8?=
 =?us-ascii?Q?iE6jYQHsJTrWjGS6lSH6ufHQRqJ0h3ho1pVqURvrFkUa4bLe+2/vzeT+luo4?=
 =?us-ascii?Q?eeh+wCxORZYyvDITZmF3yFpdYxlzmM1LLKyuW4Vok5ox8Rsv8OiDPZBnYk2t?=
 =?us-ascii?Q?0LA+Ejls5em8DLmgxe1lyTMFn9O+u0Uj9CRLzUY30zfQimqD9MQW9oFn2h5T?=
 =?us-ascii?Q?wNj3m0s1BuOgoiHUQs4fleLyRCDsRtJFZ20PTl5FqGTD0XjUR0hckeE0TtW6?=
 =?us-ascii?Q?reFoM5Y8cilXGrv435wytbQJ1rUmrbGuKWGUxRQy1OidFbPdhzqcZK3kzwKR?=
 =?us-ascii?Q?3sq3hznWKy8/e3wcR54O/kDNXfIPPrsUL+b4Pa1AuPpVxPyYzvq/hnlj5R4C?=
 =?us-ascii?Q?8r9yS0ouBOciveEQ95AT7CTNTcijCpqwViz4Ue/lEDw1wY/WveYAKH9gYz1V?=
 =?us-ascii?Q?B+sfdidANWSJ4xSwy/LjmblBJre5+FNL+HONFoipIVJv6a50TH2KD+yzpZAT?=
 =?us-ascii?Q?4vy8ikqf4ihkQjP5qsMibWv4S71y+lRAdpBKxtVlWKrNC00TxBV0QoGGoA8e?=
 =?us-ascii?Q?QV2ftNMIrz5DSnvpYyihTfe7ChPfF0sD9r9zlgm9pKWakVaVEL5Lm2sGLWtQ?=
 =?us-ascii?Q?sgLUcpNqnbqrY6/Z28GybFe4lDezHg7N/fJliZf7/J8I6fklX3SlNvYUzlW7?=
 =?us-ascii?Q?yMNNLgY/Skeqtf/rVnPQzsdOTRTfwe9aSdvI0IUw5IEIk+KZW+/qd1ekDX5s?=
 =?us-ascii?Q?6r5f7GAbSzWcGTVpWIWy+owQ8EGK9zJMCcC2+DG9TFQdmBgS7V96stzo3O5J?=
 =?us-ascii?Q?hMNtFo3TigwVcjLZnwyPTgUWPgpkodjjG7G/OXitI6ly7WeXsfQLWlPT9Xgk?=
 =?us-ascii?Q?MhH2SteskBZIqRKEUl8lhMsdx1wrjvDhFQlIwVVWpb3rDU8SU5W5QJD/g9g6?=
 =?us-ascii?Q?NDjlsE9WfGgz0gWgXPMa71PLx7tRWM/zj4xjXYDCYTtRiw8fcZ8iG6aiReuB?=
 =?us-ascii?Q?pkZGBfTD2YhlvX/M6DsX4xB3ln20FDfiPKQrOAgcDSJju9gi4rTNQY17hQbv?=
 =?us-ascii?Q?ieZtSjc1qg=3D=3D?=
X-Exchange-RoutingPolicyChecked: nOGkIUICKmHjZI5ssEEOcOS9kexqYEAijTpTxKlHaEIZIZXPOnlfubQAznT4HuEVfpq1Hgf8rY3LKNmbKXkaeWcrSBZ6jlOZtx4fz1whre6puv1njHm6tnpfg+xQ4Bi5HMfnZ1KdYNvwXmQAXv8AKLUuLDKyDmP1lRQP2fNX5so6aShrliocSh9Yo+d0ihIYXXAqagFrLHlHiCimGLb/2WI233Ss17450UnBJCeaE4QPc1uLOna7VTKEQ8PKIAwmIYM7ce7dwmntuxz4G8IWxnqoxYPyJuBuuaHI2hUgWa+ZRTTo8KsiyWlv/yky7WlBLwWGpJwXCGOBz4DINIdwWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e4da107f-6a1b-461f-1256-08df2a777b3e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 04:47:56.8870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dwm094rKwPREqlIECGv/ygldXZCN/W1wI0CL01bzKUdw/KRvVtSdhGi3m1WXAcdjF9TpMhypI+k9O6ZjF/BS9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9419
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 02:34:21AM +0800, Edgecombe, Rick P wrote:
> On Wed, 2026-10-14 at 13:36 +0800, Yan Zhao wrote:
> > > The idea is to tell external infra what the fault handler might do. It might
> > > add
> > > a root, it might add a private leaf and it may need extra spts beyond the
> > > root.
> > > These are all concepts known to mirror EPT and also has all the info needed
> > > for
> > > the calculation on the TDX side, and also doesn't assume anything about TDX
> > > implementation from the mirror side. There is extra info passed, that is not
> > > needed. But the gain is that the code on both sides and calculation are self
> > > documenting.
> > It seems strange to me to have nr_extra_spts if root_spt is false, in which
> > case
> > nr_extra_spts are all the spts the caller wants to topup for, so why call them
> > extra?
> 
> Can you suggest a better name for "extra"?
I think non-root_spts is clearer.

> > Also, is there a case where "private_page" is false? I can't find one...
> > Specifically for the "split" case (patch 6,
> > https://lore.kernel.org/all/20260928091005.15567-1-yan.y.zhao@intel.com/)
> > where
> > .topup_external_cache() is invoked in tdp_mmu_alloc_sp_for_split(), how does
> > the
> > caller (tdp_mmu_alloc_sp_for_split()) know whether private_page should be true
> > or false without TDX's specific knowledge?
> 
> The point of spelling it all out was to make the contact clear and the
> implementation doesn't have to assume anything about the callers.
Hmm, but it's hard for the caller to know if private_page is true.
We should avoid leaking TDX specific knowledge to KVM MMU, right?

