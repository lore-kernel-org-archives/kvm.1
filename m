Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8341A571;
	Sat, 10 Oct 2026 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614295; cv=fail; b=ZP8Vis0MJm0nu4WiixrUXLSQEwcEalhDGtvIwQlfqwD7qADpBPIk3vYB62D8FQQ3MYV5TXyvAcIeJfzNemSWVWMnNf1dSHNdOFI8mth/SBLiR/uBoDJfXCdodhIDDB+T8u20L5gp10ZhR6WJixOyo+cIHDNE5hU9EOBYqiJdN3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614295; c=relaxed/simple;
	bh=4eFt5CH7Ck1P1GdH3JI5ulLzs6j58aaskfz2qNymhbg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QS3eOq+MN2P3TwdejGGSMXLKXuWCAX3zCa8DlAxTBCAyXCHYopUuj+BlYAUplJ1OSox4WGNCWzcBweTaVp4QBHPGmaLqFWwZeqi1aPz4IcQTghinEhxOCOT20egHtlSY/Hu37cBmH1374cgzszW1UYn1a+IXXiBpOg7wOt3YIT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHmtZ6DX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHmtZ6DX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791614293; x=1823150293;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=4eFt5CH7Ck1P1GdH3JI5ulLzs6j58aaskfz2qNymhbg=;
  b=VHmtZ6DXAr/jDebgi+qnSIUkEcEMzSG2s0eid36vr6b3we1B2cA7c3kf
   VYJYUwbSf+NNJJEgkG4en0d9UyIgvGJ5IH02PPkrSM6ZT3ubOu9yt8fh6
   VwahJfto9kFnwoNoCu+KIaP12JaVuz0p2zyX1l+cg5JGixNwtacs9QnE/
   Hxd2jXtj+DAU7sAH+wwOwoRU2zRaxTwXal3mAt3UfnSdNoZIJXTctMrjj
   4VBm1B6wqYMzOGsqs8xGDsLOQfFOz48NZ84Eg6kIPjzGABK8Q3hFoy8Xt
   uxzMupYbnXWpTtTvEwJthfhJjRFwJTYumOZRDMjpYadXkDzxxrUxLoN6L
   g==;
X-CSE-ConnectionGUID: 66uxfsVjSSaYiihLD72OUw==
X-CSE-MsgGUID: pC/zs4DmQ26PDczck5xLhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="284708"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="284708"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:38:12 -0700
X-CSE-ConnectionGUID: 8z1G5E9gQxaIjhhhs4sDPg==
X-CSE-MsgGUID: yISTDwOQTz+uOAKakOq9rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="659466"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:38:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 23:38:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 23:38:11 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 23:38:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIGGOUxVIvSEol+KG5admC/ukNW0/5ivlzBq9Hv7qqNJSfpW5apRCGXy299IdUhmX8K7sOvbdu47I7WQfYe7vMGgbWltPR6Pdxj1KWsxfc6u3YzMSiX64s5m6eeBRhJ37sBPPlW5eq+gjIDktkBMRNvEPBAAtC4kS/ZyskcfV3gl+ZWu9vH4e2d/tGm45mcwwyRG+04ish3oXAmI8+gIh17r675GlHSzkZmRSjrbj9zYR7+DPynkPUGY+CUOXfeZXlrLSPIYRhRHiXLTMevw4TtjfVZGzQzy+HaOBYRpK0RPUPY4fHV5SPO9XTITCQYdL8L20U6t++vdRGcRjWvjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTKEjfnZdfa2AgEco2EGOyCImMjSVBFynsD6/siI8Io=;
 b=U6frtGGdbCpARDpWEHMWTBzR4RSWCBtIYqJ0yyi10dqjHWDVAqEeJHHKyO3CdWMSVz/rNG0+hFQaP6qnWkK3mWMOeUfjI1/vcIvHenIYYxYxMEOrX8oRwAygePJThJsNPCD7m6SDOvK8L7b7oKT3AqHXHHTaSJe8oqxrSPuH5cPO4o1GWPQ6SUjOBXz6vAz7k7edAQoXodBntC+Gi8jFQwH80nJefCTzDl16kGQ5BeKv+GO+cfKBG6GdmCE6hYhAfie1y37K/VYp31EFMMSXrN7f6bPmFbufV6+rlREutrn8mmuyIS4scMOYgr2nE9RGdO/LxGTwg/0KFTT6jSqkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) by
 BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.18; Sat, 10 Oct 2026 06:38:07 +0000
Received: from DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1]) by DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 06:38:07 +0000
Date: Sat, 10 Oct 2026 14:37:17 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 06/17] KVM: x86/mmu: Allocate DPAMT pages for
 vCPU-induced page split
Message-ID: <asndHcWpIMAObuz4@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091005.15567-1-yan.y.zhao@intel.com>
 <76157e3dcff065d444d83a9c5e7a924967fecc87.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <76157e3dcff065d444d83a9c5e7a924967fecc87.camel@intel.com>
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DM6PR11MB3243.namprd11.prod.outlook.com
 (2603:10b6:5:e::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3243:EE_|BL3PR11MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8c2b0e-669d-4a50-27fd-08df26990b53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|261009223027099003|11063799006|5023799004|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: /9Z2CvI+Wsh8FFApPZyauiqxOmbmDAJ/Cpd0WHK8hA/KpVYKzvXHiz1uFgZaRgQGdXY70RTAE6OeGHAkDZtlQc+CE80vP5HHALSGo1eWD+hdITZWe9WATOUxqgc0EGNl9X6ly5LcsVEwjj2ShyBCmCRqnlhP6hronruiviZh+4c4PPqGZD3xBVCgOsy/ipI5fd2xHE5PveZDjmStE0j26VyX1foUKVXOSDdrbxPxNKz9EM3Bu3bLtUtZY2ibaer7QIxyuSFEba7XhrlqO5jrf8JaZ+0L+SovzWRFo26iWa9G+QfiRKrX12mz/6BH7oOnUlQI4XdEN57iMS8BAAL1k1aA5lwVzb1VMsXDvWRORk8a6cWwxn8T0zbnKHX+iIhmNS/hBQgVyeChRWC0sY6xEteg5FunltWNpT0Mfh7eGkDuzzPpyluUec0YDGPzwGfO/gElBrnh8Dglkcq73LL0i6M9bx8vFPJEU0ytWs6l5pVwbNh3Rt6pFYwoSVqHHOFfs+wltOPiusZFsrST2/efeOGk49HtgNCeQXgru9U5f6ezqZ4WtcbwU0RlKPE8blVyjIkTvxiko4p8OK4A/rpIukTcGR+LkvzVI+TM/bXxfuFaRnugt0vSR9816omX11ZP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(261009223027099003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERLJYCZHXqmOjhRjHuwFQqY5sA8J1kSuSSGMFYI82vPTjyCoB99CNkOy2WjQ?=
 =?us-ascii?Q?L6uYlRZqBMx0TXo01ukHuEuHvulmriES3bOSCkiwyePgXWTJZCLuL54plnxT?=
 =?us-ascii?Q?QBOPq20oIyWyRMEMedtaHmp8L3rjLlAr2Lrkpvi2Dr8dxwKyL5yP7kWxnX9n?=
 =?us-ascii?Q?UjKbx2MF+ecLJ2+AsuMbUAYRhQxv+H7Amob2jInbcXgKDkRjswYYHQoT98hs?=
 =?us-ascii?Q?+pwCZzCEDUze2/gWBvZTzhb/B2M6iGZj5IcwvH7Mc4ODjFk1Z0Ar524Fc+FY?=
 =?us-ascii?Q?p8LyV3mriuvUed9ROZhNGZaJVXEuOTWGtbWAlqWy2/q7anwmcDUpH6hzwJvu?=
 =?us-ascii?Q?qqqARLul4P9hxpAXEGRYX5JFYjcpp/+mJBm5DvEvAbBD6IuPEo3drfsEE1HQ?=
 =?us-ascii?Q?5kxsuZlCmHaG2YfXhveLfaIEGPUjxzt/fB2GxQ1kGZulPQGTGs2Q6nbOjgTy?=
 =?us-ascii?Q?p+x4JPUvR1G9j+KS3JGjVxzbuZMjVYlqqDXlCwrth7HROx+Kxgyx+2fOKCcN?=
 =?us-ascii?Q?vtLdlZTO6gQMRxUPIihWOYmjgAPmmNfOs4jBTXRpvQasJhYHDo1SQXkY0PpS?=
 =?us-ascii?Q?w0wC8yPv5AtDj0Q3bxRBEzAwSkqgRdWQhagHsj4GJAuPmVeJcQ4J4EIkAfG7?=
 =?us-ascii?Q?LbP3ioTKSud8YX8HSW8tgj/Brn4tovF0F/w60cKE+bwNx9aJWzMfMIQx8RdV?=
 =?us-ascii?Q?alLRP7iXuHnpbGzEFulsRsY8jl3W+aV4JyE7hnkyNJEYI/cYprP6FKkTgYtW?=
 =?us-ascii?Q?fscBhYl4biS/WOUgfs42/kksKuONS+OQz+YKq9EXxlcAVssvNFJXNz4PvXTG?=
 =?us-ascii?Q?d7Sl3XH7BuQDMrUGRdLtTf3HKBlTOGimya9+sxNAUYAtVgcHb3S2OcaVNAAJ?=
 =?us-ascii?Q?ydNdHrpf6FWJvnDhZeQS0xInTCr+66498Isnd+XS/rztt7KWruk58vJ0X0Pb?=
 =?us-ascii?Q?97Kr4I97TBsWAo8iq3TeQ/E0kAZC3hFdpyuaJFbQw1t+0BJ6Nh9hcyyU3Fbz?=
 =?us-ascii?Q?xMg8iJl6qn8AL9byuP6jbfq3WKVAJ3l6+1cdO+0sagm6sHauM/Xb6ZOokdva?=
 =?us-ascii?Q?9B6AdPsTaM3XYQRynNVFiZgTfA/bG67AuYLGldaz8wW83q6ZDqUKpcGUKpXq?=
 =?us-ascii?Q?JIdA1qEgxm+D3ZK1TWV9HY+qv3uhjQepg66UAYJ6k4yoAVA4Uryu6UGDELnD?=
 =?us-ascii?Q?VwGoQsAX2Truz80ZM+YGv8i5/LVLKbU6HKiAwUFz2fkNlWg8CqKFyKi2aFWp?=
 =?us-ascii?Q?taOaLDJ+HGynCuLZ6bdeFJjGqQvqF3oEEvExlvshjTgDcRlCrts037vFVsSE?=
 =?us-ascii?Q?R6yrlMYsi1JTM+mpd6IZzZcdAFx9REi2ZE+EgnJ8GG22LnUNWIz3Ys74AtQu?=
 =?us-ascii?Q?UsAfDfgULt5Cqfyz3SRS/kToj6yK94AaAr0xmMk0d2E0qwTn2drMf8vXFl5T?=
 =?us-ascii?Q?AOwKweu/51nsuCEPoEuV5fvVYs+xR9uIfF11Wokj/5YjCdESczvuhR7w8WOE?=
 =?us-ascii?Q?njhb8hvfAty5bXWE4EYMYnjEj33B/TQB5YWe/1mgn0T08cpqdR4gBORQ5kd7?=
 =?us-ascii?Q?pNzoKAOfCRcLaf189agWuRIfZulBT/0ZI1LHMNtu4OjRQpzIE2gyPIOSr6Eq?=
 =?us-ascii?Q?CufdBRYPxg1BCmUoQOExf8hKmEhr5Ut9bVXbc+xjsGEG1MnEzJ1N1A00G/7g?=
 =?us-ascii?Q?LHkyn1A3xblA50ZKgEBVI61La/QN5hv5dxD5pwSqcNRESewn2tKw10Cah4LO?=
 =?us-ascii?Q?xVuIcfyEgg=3D=3D?=
X-Exchange-RoutingPolicyChecked: gYfjHyXZUrnllrKJSsMqnS5WKJvhqzqb9sVKoygQxFrL6wuwOEsBgHcgCYg6NX9IbyXqTBPi40NOXeSsQ9nQWQdaXah6JxyP9IeUNpfDqTGw+l8J0+1awK0xQJqAvsn6vUvAbYLZyzQDWWbaC5KVhw75nCLr2ijBFcBJYzIHg8ZgV6dZOW/yCNMc7QRDNeX5d1oWWR7kk01bsbZEtY72DR4lkIOAYk2YV2vmzOzwxV2TKklqYGpMAL4iQf84uBRt1FhuT/Z5/BLV030xjaEG3iyTK7gieCJMDBqm5pM8QKhZcACC/+m0jX8eU4hLu4qNRVwDAuWPYtkGVcf7wOfDCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8c2b0e-669d-4a50-27fd-08df26990b53
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 06:38:07.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6Op1s5fN9UhQMCTIPCbq5vj4tK/73pd/9V9ujJfnUkhN7rPm+AhTGecOngXDI5HZYUnwGWLBgewKz8kg/0Iyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com

On Wed, Oct 07, 2026 at 11:45:48PM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 17:10 +0800, Yan Zhao wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Extend the TDP MMU to allocate Dynamic PAMT backing pages (DPAMT pages) for
> > vCPU-induced huge page splits in mirror roots when DPAMT is enabled.
> > 
> > Leverage the .topup_external_cache() interface to topup the DPAMT cache
> > when allocating a new child page table for splitting. The DPAMT cache is
> > currently a per-vCPU thread-local list. When a vCPU-induced page split
> > occurs, DPAMT pages can be drawn locklessly from the list.
> > 
> > Pass min_nr_spts as 1 to .topup_external_cache(), indicating there's one
> > new S-EPT page table page. So, tdx_topup_external_pamt_cache() will
> > allocate DPAMT page pairs for both the newly added S-EPT page table page
> > and the demoted guest private page.
> > 
> > tdp_mmu_alloc_sp_for_split() is currently not reachable from a non-vCPU
> > context for mirror roots, since dirty page tracking is not yet allowed on
> > mirror roots. So, simply add a WARN if tdx_topup_external_pamt_cache() is
> > invoked under a non-vCPU context.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> > v4: new patch.
> 
> New? It is essentially this with a new log, right?
> https://lore.kernel.org/kvm/20260129011517.3545883-39-seanjc@google.com/#t
Ha, "new patch" is relative to v3.
It's indeed introduced by Sean from the DPAMT combined v5.

> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> 
> 
