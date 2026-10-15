Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F403E9F8E;
	Thu, 15 Oct 2026 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035763; cv=fail; b=M9J5YQ8Z9/2UolGR7qiIwWsqHgZhBz0NQ8DORcWQQaOzeF6S9sRUZwKoYz131nxkIuWs9MPH+NlmdkAdM6Ow3WThNskyAIVMYRSYI3vaVfTxT6YeZW4XKXYweS+m9ByfgB9twgs0yrLsy9ipKRJ/m+MMvtbVKekRJ4EFOx/q2PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035763; c=relaxed/simple;
	bh=kikC+WccyY5yZUmpZTd6a1OlEg0ybVqkX2cWLWxvWqA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IrWANqADfrmGa/5P5DY/xjfgbrGCPteV8HnRB9Uz7NQT4fS33S8KYjtDvIkUeqsa5wJVz5I+HLx/4V3Klytx5TPyWoNMAFZ37t0NEpSkIaEUeVDyB0TdByHM9VEiAOi/X5BS2fnMSJV3+kvThjXJ7RS/MgqsBcXDJyLEIkDn+/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3IryTqj; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3IryTqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792035759; x=1823571759;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=kikC+WccyY5yZUmpZTd6a1OlEg0ybVqkX2cWLWxvWqA=;
  b=g3IryTqjH32JQsXi7OGsZHnVgxTgy4UufSm8/CDqdOnOqpF5sYke7OUK
   twJufgzg8fg4ZB0iA/izmaHl0gsuV/k48Twm+wOlnZTC0VBSRK6eMGCCd
   PjYYGmyhSrzqDXJRXLNr/eLw5uq9A0qqdmP5cu7CSEnQ9K/Dm1wqfwUN0
   NKEShyeEcJJKoOuvYGXgtPJYUpV+ydiICma0bDYnsS0Jqk1vDMOlEt8yb
   QmsRiUSX4auObT4t9SItnxOgNAZ7tN6TNYU8PlKbL1KMqMfjLrakjD5Gv
   9a+Xcl/sQCGMTF2vvV/T7/QE1vaORMCpyDNUA3lqBJwrHxiMmpQ7650yy
   Q==;
X-CSE-ConnectionGUID: MXH3WNvZTmaVrv4ficke7w==
X-CSE-MsgGUID: A7XePy83QUalxhx9zY9UAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="816301"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="816301"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 20:42:38 -0700
X-CSE-ConnectionGUID: yK3s+x0tSturV/vPY8s+oA==
X-CSE-MsgGUID: k00oitlpQqSR03dkapKemQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1927401"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 20:42:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 20:42:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 20:42:36 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 20:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tB0WgLA4u6JsiqGYw0/+vrXwQlSCUafAdwbZAhL8hjtSgBsPQH8VeOmjFFHtWJj2mUcKPfpOiaoZEfEwQeRTLNL1kF2HNoOj2w8RMo8qklPt3vhMLlavWbg1qPEU68W0/6aUHtRfsL19P+F8xaOUFj3F8H8BwShDKYwkRZevuVAAd5mzPb7ppAs+5vI/mBEpQsX1LqD0tzwSZcdZyDNHEKdLe5J58Qz0p7i/5w4GkHaPsVAyG+quzbEYeBOkTJk93gbV5HPv68vAm6V43TsGrv8WuXOZCxJE7N21V4akmxFEdERc5aoB1GI4OJHdawTmsntlwlZYwSB2u+doSlkHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5ztom7iikD1/UQZS4Uhz7E/bYWHDrYIwQnnRfmMJlQ=;
 b=t4bojHeFt8+pBWVQpeA3lWKOIndFEd8qmuR/xABzJuRz4XQ31rSq4a7ChXwDXb/8s2mgQLyonu0FfDJxD4Q8PgMjuiNTG4tSOy3xNMwfEMbIUv7GJMN9rY8+34D11PEt31U8hY1uP+9pje6D37HxbqoAwdhL3UvlaQF9SzHb6V9RUU+W3sk9tkvhf/3dlFdEVTf6q9VPqQjxSQA8QY1NwQCfR22Q6a71zavTgXwjLzM3779F6uxQMz85Ummj/wW+4uzb2e9Y83PmW8e1KnJVll3vBOIE9N2Qe48xTpLXJgZ1sgMEwm58hpztDicbaJO+UvHViXdibQihRXIuUnAX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DS4PPF8B2A2E830.namprd11.prod.outlook.com (2603:10b6:f:fc02::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:42:34 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:42:34 +0000
Date: Thu, 15 Oct 2026 11:41:40 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Message-ID: <atBLdGBCsPwMK7Sh@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090808.15484-1-yan.y.zhao@intel.com>
 <e494996660b45273590860e961b36378c4099c03.camel@intel.com>
 <asoQ/P7sghrEVDQs@yzhao56-desk.sh.intel.com>
 <ea3584fd5613223ee066fbd368272dc7070bceec.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea3584fd5613223ee066fbd368272dc7070bceec.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DS4PPF8B2A2E830:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d16ed2-10fe-4de4-debd-08df2a6e58ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|22082099003|10067099003|18002099003|5023799004|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Ze8mECEeEJlAIBSwa730Ls1+rqn6Ty4of5FvuivwIeszr7/+s6AVsePudpkKx3c9taktj6PhMpI+6Ivgx3SviogMSqB/S/SARddKVCOMSJM/LKEj9kIHLi48qvWGJxVJPh7cqi3uPLbEeYsE8aZxS1WLd3IjiTjO/U5B8yqwfVeeionEJ2ZrO3K1SufJvAgdYxnotG6nFz2zjSL4+INWaF71xpphthWqp4cjFPssP4ecsuRKGk0paNNBI1n4NPU+HESVf/sBgpAxIIZlpeDcd3uLRDQygDaYpGHDuQrGIOUbEnv/NcalaoOFYQ0DmbgqYHvOzZrab6lAC17ioLdiJvtDUstb/7tfIJAoqvjyR/9HTYsAXcXsPWFlWQfRWpyMK8sptMar4OISDCwF8AfrvmuPdwb0Zqh/AGJLRkINddf1xK5wLNkn1ZxAfmXjnThBiWEk/dJ/5kdfIQLkt/ZjJ1OO4d3hJk1yu3hNyQlbtGBm1rdVNmg6FvpTPz2E7jb4IHBpWq6jbCzvJb6zG2nwKdf4QNs6/yCpYccrft2HwnYg/1f88tdZPG0GsRzos8Teo4niJEEt9yvfofnGo+N1inQUlH5MuOR7lj5Hpmxd/6PViWSAubZEF+AQwShrNN8pCfnZtMACgoljIsIeLnSZsVkk7TVaP1FL3DwEkwbkcBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7wWOjyLJeKnVDfUupyttioYjtgl7j5mpI2z17lxKJPVLNzqKtgCMWljxumCr?=
 =?us-ascii?Q?Hww723JFhQCM4HDBZag5DhYFMHEDPHdHBrzNnf4SKconiP2U+cMHTStF+vy9?=
 =?us-ascii?Q?A9+Bh1QzRthRpnZdeAQ5IxJ1eQ7nATPZfiiNI2oPAGKdM7JYdOF2u6IqKxUX?=
 =?us-ascii?Q?Pch+8pWrgimGwkDRGjrjJ5SWJJb9A3sOIr3o2TYGeB+cBPLaqPbM+JlE4Hf/?=
 =?us-ascii?Q?75PyAHr/ShvXGFrbQLzK2bEVFu2Gns57sLDcH/XR4vMu4p5lhhcQSvs9H/el?=
 =?us-ascii?Q?OuhtmLZtb03VZYFakYxyyxAA+FKjSvJlSJ6aE4b1i51Zf6tTk/m+gUWQM7yu?=
 =?us-ascii?Q?I9MjcaxeeA6FBv2qG2IvscrMTAIZT3tpR3ObFf/kFHKG/bgc+nnB1qSc5byF?=
 =?us-ascii?Q?WrxUDyYIsNbtT3Gmc/LFFnI1xFT7svtELIPVAQYCKwc2KXdrl9BKK2pEsyi8?=
 =?us-ascii?Q?4I2ZjjM/xRsyre6FAxjqRggsRSV9ef8VOYSe9NJQfWZPkZmuHLzv5xnWDky4?=
 =?us-ascii?Q?8sgTh+bcLYGZYv3UkNTNB5t9DGZSv4L+84e+zNT4hLITNjp+QFrd2OttszOs?=
 =?us-ascii?Q?+bA+lfqHIoNAEt5OKgj2zjMEBNMWT1pf9dXsKm4w/nchiGF2gH2ZxPLmphog?=
 =?us-ascii?Q?IMu8TKymwggI61rVmecrbEBQBg42NBKFssZ2mMdASGLVZ1aJ8/P3k54I4SwA?=
 =?us-ascii?Q?RCTdSsaj8GRQm51GHyKUNhZ0xF02rxBRQnCe5FxYKPERJ/QC7/6uBg+Bece+?=
 =?us-ascii?Q?lbGiwdwMcqn8HMNennEEUOvA4r3w0G/sOPjlif6MDZ/jvWELEKWvZ8+Xj4fL?=
 =?us-ascii?Q?c7f9qRIIxIVP64CijEK5b8A0WX8lgNv5Zj49ycGPRGKHOWGgeRSL4KZRamI0?=
 =?us-ascii?Q?pTLHs+RDQ7CEBxdxhsnb5w2txdWGPrlsr8C1Xxy8qM1FFNywOQCxZo8pRCEJ?=
 =?us-ascii?Q?VYMBPJrCmoMv5Fl57bd47m+kEc6cgcxi1KZUIk5ufydLGCxDUkmFWtJLLpks?=
 =?us-ascii?Q?wamUtoqGRdrRa8zNU6VLQ+1pVlwHmLwRw7WukpdTWUCAYva4n1JSUgTPIz07?=
 =?us-ascii?Q?DYlmpWwY37/t2/OYV0mb/GyJIoeKA7LZXpXA5z0P42PBlE9MlZgkLsZUb69/?=
 =?us-ascii?Q?Wyht/AQ1IRNUeVIS6AcknfBk+a6ESZhAFOaXpTiDEXo4gppqQgiwn37D936r?=
 =?us-ascii?Q?YfcJqogNapH+2vCSC525jSGNj6mA03cwzZuZ2nhp6ZcHo0Kb07XiNfZDT04b?=
 =?us-ascii?Q?8ipkhfndz/ppvJkKt/HWjctDlAy5bnU6jdrsdgdw1PUiydsT9ld1CyDPNtc5?=
 =?us-ascii?Q?LxhrA5rUu/QYMUqXehfvtL5d8hNoXZhJfPoRh2sUV74+zGaA2GjymP5oWode?=
 =?us-ascii?Q?NbguWOmhMFz86wYCn0Xt8j9E/1WGw79WOTCGfz4M9uL6xewG4/U4BgU23a91?=
 =?us-ascii?Q?39mGgGiQkCDYVc1mc3XVz8vmuE9w8qRwhwWFVlYI9JtwLXKB+KwfDJZ8tbjF?=
 =?us-ascii?Q?pdbEkz57V2Bk/2TK6IyMpuHTfPda6pHMijdUKaKj8YM4dnjruXjbQpFzGGLe?=
 =?us-ascii?Q?JyyXXlt3X7dl9muOyViNViRFhyGRkAAbHvYLRxMrhgRqF3ZdrXecZj6HxRtr?=
 =?us-ascii?Q?wi+xJbBjA8AFyZdRPro9zvB5ZlaAOnUBYoNcheEYvq4IbYKCIt/k969M7q07?=
 =?us-ascii?Q?jtmXqBzK2VFAIsoc2awse22t1msaZmqvqBhhHykVR0Gf0ZfEuCBoaSLNdjG8?=
 =?us-ascii?Q?qlqvH+yhYA=3D=3D?=
X-Exchange-RoutingPolicyChecked: JY5imij3paXcHm6w5FHfdVi7SBc/53NjwPY9EC/+xvGTZvAB5jDOt3saNL2kxtwMrx9x6jrBX9YZL/1PCth9AvqQixfhX/SSG8kDM/hzLBIQktfpB/mu3CLoGzL7kXSici4TOv2rSZPThtajtT27iydg1s5osKjUcxMKwqVDsEt5YSQaLKr3wlt9RP7Kszaudifi6/1nA1vtY8KgaGEVoLN7wi6BqELvSGr7GX7a4lNyv2y+2Yf8HZpxjsAePf6iEM5pPbRV0qlR8gPxgHY7fdSkY/giU17plPBL3HNkF53VImOcBXf9+2NHO83GW0i75QVr5tCsj66Ej7vFTFuJaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d16ed2-10fe-4de4-debd-08df2a6e58ef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:42:34.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBDwcyXNisqYdErPALSThIqis+ZKLZwjR6zmUAf6qKQKHRlHSy0Lh5e/h3I5nHfvjhiAgpkyB0YTOY1D0lC98A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF8B2A2E830
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 07:18:15AM +0800, Edgecombe, Rick P wrote:
> On Sat, 2026-10-10 at 18:18 +0800, Yan Zhao wrote:
> > On Fri, Oct 02, 2026 at 07:02:40AM +0800, Edgecombe, Rick P wrote:
> > > On Mon, 2026-09-28 at 17:08 +0800, Yan Zhao wrote:
> > > > The TDX module uses PAMT to track metadata for every physical page (within
> > > > TDMR) across three levels: 1GB, 2MB, and 4KB. The VMM is responsible for
> > > > providing backing pages for the PAMT. Without Dynamic PAMT (DPAMT), all
> > > > PAMT backing pages are allocated statically at system boot time. With DPAMT
> > > > enabled, PAMT backing pages tracking physical pages at the 4KB level
> > > > (referred to as DPAMT pages) are dynamically installed and uninstalled at
> > > > runtime.
> > > > 
> > > > Currently, the VMM invokes tdx_pamt_get()/tdx_pamt_put() to install and
> > > > uninstall DPAMT pages under the assumption that all physical pages are
> > > > tracked at 4KB level.  However, when a guest page is mapped as a huge page
> > > > in the S-EPT, the TDX module tracks it directly at the huge page level,
> > > > meaning installation and uninstallation of DPAMT pages for huge pages is
> > > > neither needed nor applicable.
> > > > 
> > > > Add a "level" parameter to tdx_pamt_get()/tdx_pamt_put() so the helpers
> > > > can skip DPAMT page installation and uninstallation for huge pages.
> > > 
> > > I guess this means we need to make sure to get/put at the right level that the
> > > TDX module is using it as. For example in this implementation, if a huge page
> > > gets demoted, we can't call them like this:
> > > 1. tdx_pamt_get(huge_pfn, PG_LEVEL_2MB)
> > > 2. demote(huge_pfn)
> > > 3. tdx_pamt_put(huge_pfn, PG_LEVEL_2MB)
> > Actually, calling in this way is fine, since steps 1 & 3 are effectively no-ops.
> > However, we can't call them like below.
> 
> But step 2 incremented the refcounts. Then step 3 skips the decrement.
> So don't you need?
> 1. tdx_pamt_get(huge_pfn, PG_LEVEL_2MB)
> 2. demote(huge_pfn)
> 3. for (int i...) tdx_pamt_put(huge_pfn+i, PG_LEVEL_4KB);
Oh, what I mean is there's no need for tdx_sept_split_leaf_spte() to invoke
either 1 or 3. It only needs to invoke 2, though it doesn't break anything if
tdx_sept_split_leaf_spte() incorrectly invokes
tdx_pamt_{get/put}(huge_pfn, PG_LEVEL_2MB).

tdx_pamt_put(pfn, PG_LEVEL_4KB) for each 4K page is done in
tdx_sept_remove_leaf_spte().

See more in the below contract.

> > In DPAMT combined v5, Sean moved the level checking from KVM to
> > tdx_pamt_{get/put}() [2].
> > However, Sean's version introduced __tdx_pamt_{get/put}() for invocations where
> > 4KB size is enforced.
> > 
> > During our internal review, you said:
> > "Can you also justify why to have two functions instead of page LEVEL_4K in a
> > few places?"
> > 
> > So, compared to passing level to tdx_pamt_{get/put}() while introducing
> > __tdx_pamt_{get/put}() for the always-4KB invocations, I updated the patch to
> > drop __tdx_pamt_{get/put}(), having KVM pass 4KB directly in the always-4KB
> > invocations.
> > 
> > I'm actually ok with any of these approaches. It seems they all require the
> > caller to know about the right level size and whether to invoke PAMT get/put.
> 
> Yea. That is kind of the problem. The caller needs to understand the impact of
> the mapping level. The level arg isn't able wrap everything within the helpers.
> So how the get/put helpers handle it is internal details that caller needs to
> know. So there is abstraction leakage I think.
> 
> So probably the most important thing is that it is clear how to use it. Then
> whatever is the simplest code. It might be Kiryl's implementation. What do you
> think?
Hmm, I don't see checking level in KVM is better or simpler than passing the
mapping level to tdx_pamt_{get/put}(). KVM still needs to know
tdx_sept_split_leaf_spte() can't invoke tdx_pamt_get() for guest pages.

So, what about explaining the contract as a comment to tdx_pamt_{get/put}()?
That is:

(1) KVM needs to invoke tdx_pamt_get() before it maps a new page (guest page or
    page table page).

    So, KVM needs to invoke tdx_pamt_get() in tdx_sept_map_leaf_spte() for
    guest pages, and tdx_sept_map_nonleaf_spte() for page table pages, and
    tdx_sept_split_leaf_spte() needs to invoke tdx_pamt_get() for the page table
    page.
    However, tdx_sept_split_leaf_spte() doesn't need to invoke tdx_pamt_get()
    for the guest page since the page has already been mapped.

(2) KVM needs to invoke tdx_pamt_put() after it unmaps a page (guest page or page
    table page.

    So, KVM invokes tdx_pamt_put() in tdx_sept_remove_leaf_spte() and
    tdx_free_control_page() in tdx_sept_free_private_spt().
    It also needs to invoke tdx_pamt_put() when it fails to map a page.

With the contract, it seems to be simpler for KVM to pass the level to
tdx_pamt_{get/put}() ?
The dpamt refcount adjustment are invisible to KVM.

Do you think the contract is clear?

> Or, hmm. It would be easy to catch misuse on the put side by (dpamt_refcount !=
> 0 && level > PG_LEVEL_4K)? Then some comments to help user use the existing
> design correctly? Either of those seem ok. But my concern was that this part of
> the design wasn't clear. So most important is actually to explain the why of the
> design with an argument of the benefits.
If the above contract looks good to you, maybe I can explain the contract and
design of the API in both the code comment and the patch log.
