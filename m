Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792718524;
	b=pZToCMwHdEow/YtXCUeIFFLy3njunOMN+X1FMV+wx0XSRPrQ3whsaA+zlvSm0r4AUAUW
	 r+Deauaq8o9WADrw+dl4CE9zylmJv9x6QOclnopXuLNwtICAZA2TcXUpmdAXj/WtAZOBN
	 XVWRf+020vKkQXNGpyVQ7G80H1FAbqRGoaCp/jAPEGXWgaCO98XeFoXFUjDPitj95TVtm
	 I+TEDWqkQWswa7Uct6uydCUCGJdfCdCsFehXO8bSn0/lQt4lG9BwV5OUg0RoshgGc+N0b
	 h6x5BMh+o7dGeo/AzkZOAVLq2AYc3LUtLKrn3dQFtml2RJr7JqZorNO4jd+eErygBHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792718524;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:Subject:Message-ID:Reply-To:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=V0T1imMTJMX5MhWtX72KUjlwVQer/ULU08YYD0HNh5s=;
	b=VWzQwZpNy5Bo6OVmdlo6c7kg2Y9xvUunIwV4txTEC54KljADZLSurf70umJjyvv+55xS
	 +rCShfQjTTy/V+sjKPqO3x8L/u4eddACSM5KUt5c02v3Ez8A3L/ovRPI7ZJJ2qf11irRH
	 eZV5B2U+lbHAlYVms+7B32ycjp+1JBkcvtlaNaLToqqV9o5IahTjFdAEWChIkyqIMnYJ4
	 QAkvUONP41cLpMqTgaEG4T3JCW71ymTHinSsxnJQJYRSHZcjjYfiXTe1nx8Udfml/Stbe
	 b6V5R7UobHlUYzQKCZHzFCL4tXjFKoYTmRvEnVAEmFLk8vVv3SgFYWQK9NfeVRFKIug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=feCzdF4N;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD245606A31A;
	Fri, 23 Oct 2026 01:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD245606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=feCzdF4N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792718523; x=1824254523;
  h=date:from:to:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=otYqGTHaH3f6Fyl1Jn8CkXzvMb0mtujLYi3W7ir+wpo=;
  b=feCzdF4NPRtcBHjX0mCVYIcTySk+/45Pthwxx0nr49sTZ09Gp5DclQIf
   WM53j5SWMlc5W7R3RSjmJPzpj6YOzItXp2d/dYoo5LZLrAQ9wBUMfEuHg
   vo6F3YRIC4O1tMHvRc4xiaZeNQBJvWvliU4kxMl0nyCzOOgwL/R7n/IWd
   o72USwlFovxTM05v9OSR5OLir78rn2pj3kS/oXU+NP6B2C+3+avhrLdXR
   42nv2Z+5pTxN0HsAebnC/3B8UpZuWS0fKl9EGAjyNDnC0J+Rzpb7YL7JT
   At04DQ0F+5+t4f+A+bn0JxwZpVoOnumYfmlKZURLeLoOLTJYv7mFptauy
   A==;
X-CSE-ConnectionGUID: 0nHd+QVSQaO47yPjhyx9wQ==
X-CSE-MsgGUID: vAG/UnLJRCG0auNHcnWcgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1488382"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1488382"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 18:22:02 -0700
X-CSE-ConnectionGUID: b/s3ql3wQ4utDykH00geLQ==
X-CSE-MsgGUID: 2Tjbsf9rSxa39HPfHJ8tNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3895595"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 18:22:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 18:22:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 18:22:01 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 18:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3aj6pm/rFAczoS7X1nGDmui4NcYWgHauNn+8zINK1Ju8UliPNIPwn2r1L1OY3DOcsiobsa/Tx+8bc00yJvlZnQX7McZQyE9G3LiHsL7ZGOij8H5iiw+5xWx9K3Xl+LY/z7TlsRnCDh9twL1tDD6dj5OeNudef2MZMx/AHtOh4wjJTRg7cz2VlP34pPZEbvCrgFYjeQm8gdql21zZ0mCXArldHisOMGSxtFNA9u050HuQOX+hyYo7aoO4CtYB5ETHDi7LdpE2437kpWXZRhgqpR4a9xfTzk9S7GK4Wi8epnWvsBhSRBH831wmaFoZUTxT4RNnk/PD6updHI7Ctj62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjNu8wTi61Q7X+aqMp1MfJLwVgWlqD7apnA0TZge8N4=;
 b=d3Q2/9q6CdWQv5TBKmyvAzRy4OBXBYxjgYXpTknxrR5AKGctgtVoZYdx6Q3I75Q4YInOQ+F9Eqlh6ApS3bZs2jjIfoPNFNq33nIcccSZeTxRJUSX7DN9WJs2zqmVNCzQTTZJmXcP2LkZVERwjs/vJsl3YSySW7hcpvGWpGcOWimcQv2E762a74WjgRY4wQA1KvFddMnJo/erAe/9rrJmPnmIaz8+09gzqSg3YFbiSZ93e3dsTd3IMfxVimXlHZT8eFbFWSlTVTGcAdNRpG6c8+7M/aPTL8iiKLrH/7TpMD5BEbFpM8G4gq8dMYLyADDow72zLzMso5VQou08UkpilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by BL1PR11MB5272.namprd11.prod.outlook.com (2603:10b6:208:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 01:21:59 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 01:21:58 +0000
Date: Fri, 23 Oct 2026 09:20:59 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Du, Fan"
	<fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <atq2e+gt2+QlZSh+@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
 <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
 <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
 <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
 <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
 <atm6NBNrwYc+Y8yo@yzhao56-desk.sh.intel.com>
 <55ccf641218c6553b2f43f4394b92c23bd8b5d98.camel@intel.com>
 <atqjeaPTXmCfiQmo@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atqjeaPTXmCfiQmo@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SI3PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:295::19) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
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
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|BL1PR11MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3b547a-44da-4437-ac3c-08df30a407ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|261022105027099003|56012099006|921020|11063799006|4143699003|261009223027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Iru9ST0OQSaPHfmDRFJemp7s5m6Z1OLVb/KAjDoMpP6ZAq1EoOjzKcfKW/r1D/Kk/j/4q+Ic67Gw9wie/uNCW1+KDL4znByVlORHYtJv3o2nYg08Mz+05gMnQqxYwNO5lx+lS0ZpmPq9FFzpi651yPX6L1yj+08YlEfY0DpKjd+i+dbyCPiI6i+gHLIdsctU6BW7v5xlhNIQ51RSkzqJnOuAqWy4VKNfBlnNUXAmctsnYu06j4BVcQRlrdhU13R8gRX+a3io9oR970mVVaZSLt6wCJ2oIMOpu0nVwqGyBzPkmDMyTZJaLlsVHHVu0041VWKyWDcoRyncXaIq4yCGVCFS6Opmi6uVBj3U6dAIBMw9i1mMQv6hABH63/972VUSaPxwD6GWOIUWYrl3FJfkwkdzT1lehOMh0hzpFV8v08uaUn/ZBTo0XrcHF2LoDpJCUXoaQO7VDYsIvu/RIkJsdo7d/BaJaurzmK2jXnuuBvNdhD4q0WKn29B7SvDHDnVEQa46JnTj+xNp0sRa4kGJF4/guYuvNOSr6HVPhXPvDOwG/VYv0ZCf/XzXZgLaRrxd9KzsshZu2vr3SKEaSP03mb+sbYB/xeKOncV6tJzcEKurIK+k6f/qC7bz99KFzNq4nRvGtVRx6qOp58KLerDw+SkbLD6mcQrZm5weB9D/kRvBu1sMrnHWP9vzw9YB/EC5FJsW8+GbliPfIonAjFRiWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(56012099006)(921020)(11063799006)(4143699003)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9GNut/zPum0QK2WgHg4KZBBSX5X3czEQxoVX0TKwEjFwEYnoppe7eNLd9x?=
 =?iso-8859-1?Q?WDwC/DS/HyQ36VxBO1XVSFh/3UeiVU7sRHcb4MeBWqm9rZGBPt/X+2XnCk?=
 =?iso-8859-1?Q?GxkLcgHO+ayfNv68aM2n1liSd5b0y1s2z8xEQHvhQhq3s7zb2s7kBIkmiO?=
 =?iso-8859-1?Q?bSiAitLT5lUZdbaALVFfeF4RymoRnybe6wmokuArE7yBVUkItcNUxJivoT?=
 =?iso-8859-1?Q?PCaVNRAerkP85ies5XKP3ATCJ/RssmYBVITQiW+h4EiFdMtJtV5FUQ/mhw?=
 =?iso-8859-1?Q?X2+o6IPMNcUMNEH3MH09LPRkGcfdgLjDA+NESqL70gd4Tgjl3xQL6A39IJ?=
 =?iso-8859-1?Q?84q1hyKsv4Tdax5vMC+mIw9rLyYkaXKNeCh0wELnVVr84RU+ORYtfwEhPN?=
 =?iso-8859-1?Q?BvTlhNNPM9utD7SOBttnPhQj7M4Ebu7pkYIZdaWFflJ6DF03raJHKfdgS1?=
 =?iso-8859-1?Q?xrinFEZCUbdnLhuLJM9rnSghvJbf/27thD0ZcepGMezJ8PeukCQeJOIHwr?=
 =?iso-8859-1?Q?KtpO0+qRl+RQjteF77P6gU5epC2q1jAhaYesLGafgQQ4BcI6Tr0ArN2l+e?=
 =?iso-8859-1?Q?NSGXB7e0LPKIiZumR37r2ZnJMJwbazgwAUfl0lGcVnreFWaUVzrwcgN6I3?=
 =?iso-8859-1?Q?yaE3+Swfsd8X5aWr3NZUoAYyK3WjBytoT1GFB9MfYX4LfB0R9ucCNpUWgx?=
 =?iso-8859-1?Q?KIzFvxoOHMY0W0sQMxkbEkS17t/A324+Tc4lA5mbbGs3hKGeJIZFYhc0Pv?=
 =?iso-8859-1?Q?uV0FpqZR88UjCQrsrayHuFs73G/42HGMCTlzfoR2/AiSpQ7OCBq1SYP+u8?=
 =?iso-8859-1?Q?33XNSxEUbGNATTaoFO5KKNslWt4Rt1WfaihA2MyGOWMe8Eg86QNysmtftK?=
 =?iso-8859-1?Q?+N30LJ1t1iYAgbWjH4Bd0dTLDZxUVbDr044WgMkL085JfVt41gpYlrBDKS?=
 =?iso-8859-1?Q?1wNQAzteYyYbUP1AwthLWTxuc1d3wTD6y5MA/B3oGsn72tLF5h97IuOkoG?=
 =?iso-8859-1?Q?vDnfihxPHkqBl1FKn9o97e/0+nbdvsMXbioO16wBLTDYCgbqbrP3liMr7O?=
 =?iso-8859-1?Q?p3mPWqPziSRkycnJg0OCuiffPsNa9uktQQ6eg+k88z2cL7EgAhG/cuS1di?=
 =?iso-8859-1?Q?i9Ibze5JUtt2VkD+QComViL/M2MDRlymuv29zuYplRNjLdi7dr+R85nhGD?=
 =?iso-8859-1?Q?v4mmMqCTx1SqyMfBWbl7XPf3QXnMwN1pGkL/H/RVZjqZvhEkrD/MhpV/7o?=
 =?iso-8859-1?Q?07jAcypTkyV8ABW/77si2ZE2QX+CEwZ5+pZBMy0Yqyx6Lfe/zsXevmXgpV?=
 =?iso-8859-1?Q?QADEe56W69ekhMUi/7+PFunZA+dkEjfbLSDPKl8uqht7V5vmM9mTpQABFX?=
 =?iso-8859-1?Q?J5Nl7E1UY4UtK7QeWLjliTChUEHkANBRZLw8EGhb6fOxOKLN0Ffhu/4QhA?=
 =?iso-8859-1?Q?17cL8Xw0p0sgDrHqsiSp98/nfOcDcI/TALJLIrJHEItBpU2oKgPOEoXyeS?=
 =?iso-8859-1?Q?U+Wsk9VV2/t5NRcmKBFxr8vJB4bSaT/o6Fb4Og6TlUcf+dykuVOqnzjkfX?=
 =?iso-8859-1?Q?UK9gsPI5GZ1l9oItRYjI9rQAy0tOaGzKsGbfxFvc3h9hY/+4Usq6+b4JYj?=
 =?iso-8859-1?Q?lrJ8DrXDYoKzS4kQw4+1zmSyjcADZVCAim/oC5Lx4jH+HI13BxfE0BhZ4P?=
 =?iso-8859-1?Q?5hHoi19bzSE28y4XWEMbmfINIJtBzmiSu1rMExCYyQPT/t2zQMfNsLN/rm?=
 =?iso-8859-1?Q?we7wvv2dMV3CDXZLHaTY5Pk6I51Uzac/ax3PYGhM5ZzYkzLRUc9wDpv9np?=
 =?iso-8859-1?Q?e8CdRNT0zA=3D=3D?=
X-Exchange-RoutingPolicyChecked: k1/82Tfh3AVaz8mBnXvHrhS58l+tk3gjjzSXklroCEajTXXCTKV49MEVmrHvEw7DmkS0u9avLlFTIWIdFM50Y35bL/UUQU5eK5Jf1o34YymQvWWz6IXg/bvNc31XJq/qhcnz9FnJMXu6yGpVwOHWP6I6tfAz7YaNSwEu3kCunCrjU1Rfz0RuesaUABBF6KF6ksKRwzzqfnzdRC8nq+hn9JuT8mAtZoufPIqnefPafPxEnVOz0DnqBqZVU4QDNNlS0TQkFqSgoKn1oTlzzF7chvAx3Kflg6WszW06zQUDLbqAVLmzlEzi4f8G6LmzICh9awMOFcnLTknqOJ2PgP9kBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3b547a-44da-4437-ac3c-08df30a407ff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 01:21:58.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUtNVy9oWvrQ7uIvlylGyFibDRVh5Yh8COYpRJtZ6SqUKSHHh13t9EqvdLdnqzU907u/ndb0rnIAHz2v9QG8Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5272
X-OriginatorOrg: intel.com

On Fri, Oct 23, 2026 at 07:59:53AM +0800, Yan Zhao wrote:
> On Thu, Oct 22, 2026 at 11:56:47PM +0800, Edgecombe, Rick P wrote:
> > On Thu, 2026-10-22 at 15:24 +0800, Yan Zhao wrote:
> > > static int tdx_topup_external_pamt_cache(struct kvm *kvm, struct kvm_vcpu
> > > *vcpu,
> > >                                          bool with_root_spt, int min_nr_spts)
> > > {
> > >         struct tdx_pamt_cache *pamt_cache;
> > >         int dpamt_pairs = min_nr_spts;
> > > 
> > >         pamt_cache = tdx_get_pamt_cache(kvm, vcpu);
> > >         if (!pamt_cache)
	      if (KVM_BUG_ON(!pamt_cache, kvm))

If no objection, I'll add KVM_BUG_ON() here to avoid unnecessary repeated retries
of topup() after such an error occurs, as it would indicate a KVM bug.

> > >                 return -EIO;
> > > 
> > >         /* DPAMT page pair for the root SPT has already been installed */
> > >         if (with_root_spt)
> > >                 dpamt_pairs -= 1;
> > > 
> > >         /* +1 pair for 4KB guest private page */
> > >         dpamt_pairs += 1;
> > > 
> > >         return tdx_topup_pamt_cache(pamt_cache, dpamt_pairs);
> > > }
> > 
> > Yes this looks much clearer than even the upstream code. Do you have any better
> > ideas than "4KB guest private page" though? Because in the split case it is
> > actually for 512 guest private pages. We should put an artful comment to explain
> > both cases while not making it look like something that has a better solution.
> > Because I'm thinking there isn't one.
> 
> What about a comment like
> 	/*
>          * +1 pair to account for mapping a new 4KB guest page or splitting a
>          * 2MB guest page into 512 4KB pages.
>          */
> ?
> 
> > > In the fault path, mmu_topup_memory_caches() calls:
> > > r = kvm_x86_call(topup_external_cache)(vcpu->kvm, vcpu, true,
> > > PT64_ROOT_MAX_LEVEL);
> > > 
> > > In the split path, tdp_mmu_alloc_sp_for_split() calls:
> > > kvm_x86_call(topup_external_cache)(kvm, kvm_get_running_vcpu(), false, 1);
> > 
