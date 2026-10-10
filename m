Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73FCB640;
	Sat, 10 Oct 2026 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609586; cv=fail; b=Kw/8STmF/QR9EETafA93FdRKZEf34ikdOjxses5GQslYHq/DZCBSqRmwlD27C6aIzGqIzOjx3I0+UpYQDb07GZm0AGH0/i+IKg677vo7X1Wgamw6cK2ljPGlVHA8xsr7BxapGHasIsvpR6+WXxHIycdtDd1zAfLNGSqajfAfIDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609586; c=relaxed/simple;
	bh=B3jgfj/ug6RDjTkhBIRKgmqVmpQmah7ZnwCTGWeIy0k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aQ6m7uxZYrkAOJHcKkijnC2iRqsSPN1KvSOlLAN7eVvTt1IggBC+v1V/qN4zb19m7oIPfAO3BLPKZm//sE2DjnjaC+7p7LglOR27mBPuxig6+LMYtpEM+/a+C5cQveeYw33+cyZzQYT3+8nqOdnTKCx33T4KR5ZA5X9dKMPyP6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSgrklaE; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSgrklaE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791609585; x=1823145585;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=B3jgfj/ug6RDjTkhBIRKgmqVmpQmah7ZnwCTGWeIy0k=;
  b=JSgrklaEVqfFvdxDoc/FFNyYsqwENdENB/jvox+mLzQTJeCBF9wnVvnx
   YTyEr2TKDcpw+9XIg54wmngTCSzqgxijXrB7V61WBdNPnUo7RPdVq82LR
   qTPIC/ZAAE2FTSEApzUmv0runECkv/X29hyjAn9EfS4L7q+IIeo13aeZK
   oDy482HQxritM0UYZZjX37yndqw0Z+/5Evx633wDSc3eY2SedH3oOlZAk
   He/HXAcmGbS7SsBGMTb0CtiBbdVVxOp7F4nvpdDSFWdaKdAuV28H+Tpoy
   Zuf5NY+/1Ss04WN6FFoO9zlauI2xuNxXja73FAmnIp8JFVqoEj9a285AK
   w==;
X-CSE-ConnectionGUID: unp92k7tRiSGIIacyHM55w==
X-CSE-MsgGUID: UD2JSPOCQle1lsWPx8q4WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="301627"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="301627"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 22:19:45 -0700
X-CSE-ConnectionGUID: Kuu9s6asQSq1TL7oYQ1i3w==
X-CSE-MsgGUID: iYiU10yxQsWDNT67rmttDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="829849"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 22:19:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 22:19:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 22:19:43 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 22:19:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe7eLjlnKqs3goYVXfV4SjQmvmR4p0S9Y8+bv3HGt+jtzcQ7nh5niE4EgJ5iv7xaynwHKcaYLXf1RXvxVMZCp5fX4myYXjVs0SMh73oVuw3lM67H4RFIBehwXmuTCiVnjdatLyBHWEtnFQ3jQNja3Oj9ITv1/aAz6CQHLIUTmgux9zeM4GymJZucWwgZnorNT+Qx9gRjuf0KrBDEaiTXlVPCu2ilkppoqQowlGkBbng96bkx5++79msFyOfahXN8/qSPtYLmfkJ7sasmVUXWsYxYLAR2PSspwSyCVwDSj9vIpVt2bhluzZnS+xCeyj7uWSbLcDj3uzMMkprTO6hbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD8IZyHG7wB2LK1K2QhGRzeYI8FBglRbNyZ3M5TzQIs=;
 b=KsKb7hGjaV8eCxzJSLG2Y1j3N98dyRbUN8vwilP1ANvzCKANHqewqY+EAtIAvrRfqnKZqtwfogdINf3tPOTvydh4JFkTO1dz5UCT4Zde03Gp45HSnqgBUefQRy3XGWfgHytUJl1rian4gkFX/kNeNRvmwVx0Ff69NXTQB5EWjawlkErT8Ca1nwLwjUBf6Eksp1Lu3aT1VPfK8eAwB9NStBAiR33oSshklEShoyfrFVgZVBDZqe/vI1wWao7S5qljheDJX58Pgp9CXuPBMyJSZNRYuOGkrfKUT1P9RAuyeaedw0x6sqLIdHiHSPps6EtB3e5fcuN44x2Ecm9Q8Qz4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) by
 MW4PR11MB7032.namprd11.prod.outlook.com (2603:10b6:303:227::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.18; Sat, 10 Oct 2026 05:19:40 +0000
Received: from DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1]) by DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 05:19:40 +0000
Date: Sat, 10 Oct 2026 13:18:50 +0800
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
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <asnKuojbVfg/D8Eb@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091035.15599-1-yan.y.zhao@intel.com>
 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
 <asioX9gKIZBe0NF6@yzhao56-desk.sh.intel.com>
 <eb07ed0a79db904ced29539b3831a780dd94c799.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eb07ed0a79db904ced29539b3831a780dd94c799.camel@intel.com>
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DM6PR11MB3243.namprd11.prod.outlook.com
 (2603:10b6:5:e::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3243:EE_|MW4PR11MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3fd59e-6de6-44c2-8148-08df268e1589
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|22082099003|18002099003|261009223027099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: aHttI6oxfIiFIS6IchiDG7W2oAEqy//na9ImQMbWQTiD8/cz3VjLETchXehWQtOsY5a2Glgdbs0sdFBcym9ZpjWeTTAfCzeG046KwSJC5zSLSFkIGPcoAWhHFKZzT1dDQhBQ5bhiKKz78wiEBh2G9S1ayDrtE+UwjklYKavLvcNiBgSvuWOS2XVY8c1frNS/ra53baf4Zl+4CvQRC6S1bPz2FJwTtersdf0X9X9l4eHTvmbSunSU56YZAvDnAZuw9ko9DsmfSSwf29I75lrhDNbpbjXN5kauj9ZsoZ4OjbGe8Z2/OQwJuszr3dr1q3j0tmywmZBjl03NCfmS88r7jpvgWIrHWJcTpIDLlB3/aNyp3qz6/aEDmrBh1hX5kL7zc8j17YcUknVSIc3P2bDop6BrMz+2/Yvl0QmVGqCHmqYNsaBYm1gu3vCJdXbEsEUe/6ILPb57jBcKRlZOB8RRPx8oBKzwF+Py91EuuyRL6cGwhDBAHK0w+fYel1FjnDoTMPKmfCqqQ+X7+hOmRVkiEo9BGfy3UJIZB10eLIIuIFNtUOFOht3OsWtCJRc0rru0D9uEbE/cDftIo9OKxi51k0RSYm9w/34W5A5rku3MOTjSs0InEJL2+6QCo63HFHj48GchF9UpAQhf9Yz2JI4TUi0THn0jUlmiAMbR2V08qFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hid4/gCwEuTB2cs3mkd1UYubqrkrt61k2NLfgzT+ac1BWy/BCdxhs5gseI0T?=
 =?us-ascii?Q?Sf5gdMKLCnfG8dLoMdJMtk/66HcfY+YWdZoRJcEwyvBEsBWei5ObCF/qE+mM?=
 =?us-ascii?Q?gpx9Vw4AkUkyJxZiLVeXfausGtjCgJ4ScXN8jBb5Xa8uF4awKLfQp4qqTsbX?=
 =?us-ascii?Q?PVUJ30UqR9hGRYxJ46qEkuIQyWbYB1YILJixRYMetWBX++x5ui+IAs8PXaOe?=
 =?us-ascii?Q?uIw3nlhnt8BfP/0B6n9uaM13NEx5pJytEsufRV6a389VXshJMEWWS9xDnmPH?=
 =?us-ascii?Q?UABBkvSy9SXcKo9TOcP9KIhVG4o8lhhx3Z88xtEslffHPv0c7/UkrcjCBhwe?=
 =?us-ascii?Q?k78D5ekOr+S7ZvymvQ+w1R4AiXBiW7VVZwJZGRjpH1OxMf+UJ9lAOh++MpUw?=
 =?us-ascii?Q?4+/rAuvYhhj0rw2i8poxim3LiHZq3l55C3LvxyQVUqo+M7qjOz31P7K04sEr?=
 =?us-ascii?Q?NeypWPs2hTFn3cFTVFSv8CjAfAZLkEzE09zYdLPV92MACgN+g65GxW57J2a1?=
 =?us-ascii?Q?3zdp+j7pvCh7iQpYB9weiKeCfQs4GISbFi2sc/rrCJiq9kIvFh7fI0FEwIdd?=
 =?us-ascii?Q?5WNRoye4KPOM49fu1fOqW8ZxYUrrzHomUBVby7bfliStaaB8fGynYHFUtu1B?=
 =?us-ascii?Q?xGp3x+vDNamI2mTVDFa6WbT04zDFY1yD2vQJ6Tt4R47/nQNt3jspACxCe5Bl?=
 =?us-ascii?Q?rK6kyGBml0HfJQhigQ6v1pL3JKsOdOMSbq4V0CKOKQmpUzBySKHYrEGmBgqQ?=
 =?us-ascii?Q?KSUDhWxXtNR/NKRF6ZoaF48PWgjpefqSXTqB/+o/zsbZePvdwThf/NZm0pTw?=
 =?us-ascii?Q?UulqjgS4vVFh4A47+tcX05kjJuWRNAeb92+RHCN6zUB8c2GN7wEpLFZvmzEx?=
 =?us-ascii?Q?2QBD6jqMBGucJ2bSVcW16A0FFDNVsbTRYNV+T5nPoLMrR2G1SHJOqsQUagkc?=
 =?us-ascii?Q?qENXswRL3+hTz+wLk1/1wv8fIa2dDov5NAlCbXU230bBlWbBQDngx+RZ8RRp?=
 =?us-ascii?Q?9LZvCtF1AJXsbZUw/WuQdves2FhSMO6Ny6KrhTwWMThfh0Qs+K598dz5FUXl?=
 =?us-ascii?Q?NU3B74DBj8VJfmWwihxW0y16PtanSrDBK3Htmy1KfdB+qvNneunF4toRIEtg?=
 =?us-ascii?Q?aX9ZHmWJ+BA0A4gugYpEN9lQvgIucrffikhSuk1ls0Bl0sOSNqulPH15pUlK?=
 =?us-ascii?Q?0GGJySaPZzXv34dDxGVvdmChf0nP2HhMj8a4z2JgcItyA2LiMPaxmDZZPoHf?=
 =?us-ascii?Q?knmb/Ve4emGoGBv1ONJNp5RQYC6NJZRDeNaR9E6Ipmfhbd6MlNg/EkE+PqGp?=
 =?us-ascii?Q?6sMbaxO7VBRtY8ICtqSg0ovz0+j/b/PRT22LW1agtml2Xsmqi9ESLYto3zcL?=
 =?us-ascii?Q?xY0vkHXRXnYiAtlSxE/OTb4a3zNlaGlUQPFlv83FsTaBnPUJC+H43mGv4AYa?=
 =?us-ascii?Q?TR3sBH9P/yxKiim2DJiQLqCUBNWzBEm375HoUcJDCQfRTDPL3ZdwDf3IvyPg?=
 =?us-ascii?Q?kgDCNL1780CvJkgBQPMnqcgzeAxOPcGA/UYYNIkMMzlyctVt5R6E4qryyi+x?=
 =?us-ascii?Q?4JStEU+jdrkHS0pnEijY8Z0jv+119xH5/uEvq4cirnqoxH/MchPQK1kMpbIX?=
 =?us-ascii?Q?o2wZusWzl2qm2lJXsebnA/NnYeG8YKu2KH8wDCqEeb42GcTKfA9V0KkOrv54?=
 =?us-ascii?Q?jbZiaUTOv3vKaro+VjSnvAAQmutIrv970RteXBd85HCUZ5Ya5yLdUZu6c0m9?=
 =?us-ascii?Q?M0DNGWE5sw=3D=3D?=
X-Exchange-RoutingPolicyChecked: W/Gc5et8s2BgaEoT9ET1ZVsXIKQwFA/PEzM8IAJCUV8F6QcFJL4QRUew1lwv7JNfRGaykyLHRdSrefbi0fEYN2I8QTtm6PVfXvsgjFurAgpxPwowCOLFovScZXQqMvegNf2b5znp8XIPVcytXcvSPO/+lNmOxZUj2xf2MwXJpBqHDJw7oidJHBfQMH/by7kF/9Xy/uaWr/dzTdAOzE+NyYV7NYa0FJ6NPmvNBCSSFT6TkSLXmXoxuykCHb6k6hEkLthW35xdDW0vuY+LLeduOqoeaMoBfGzwsPw/CwbS+BHBUfq/Lhf2duxhYMrWtf3pU9w2FT4bEs1VYmfBCec63g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3fd59e-6de6-44c2-8148-08df268e1589
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 05:19:40.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asAyA0jhCervWzgpLwhibrZXevilRMoOKiiYJxtuOAKPjMVWsRMGZNGDjx35lOVYOEpL+Y5Mf5pW2Ldq/9d6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-OriginatorOrg: intel.com

On Sat, Oct 10, 2026 at 06:11:15AM +0800, Edgecombe, Rick P wrote:
> On Fri, 2026-10-09 at 16:39 +0800, Yan Zhao wrote:
> > On Thu, Oct 08, 2026 at 06:48:00AM +0800, Edgecombe, Rick P wrote:
> > > On Mon, 2026-09-28 at 17:10 +0800, Yan Zhao wrote:
> > > > KVM needs to allocate enough DPAMT page pairs in the pamt_cache for
> > > > consumption by both page table pages and guest pages. Since the DPAMT page
> > > > pair for the S-EPT root page is already allocated during TD initialization,
> > > > there is no need to allocate the DPAMT page pair for the S-EPT root page.
> > > > Therefore, previously the DPAMT page pairs required equals
> > > > "min_nr_spts - 1 + 1".
> > > > 
> > > > When splitting S-EPT, min_nr_spts does not include the root SPT. So, limit
> > > > the -1 calculation to when min_nr_spts equals root_level, though this will
> > > > cause one pair over-allocation in the normal page fault path because
> > > > PT64_ROOT_MAX_LEVEL is always passed even when launching a 4-level TD.
> > > > 
> > > > Additionally, KVM may need to retry tdh_mem_page_demote() a second time,
> > > > causing the DPAMT page pair for the guest private pages to be drawn from
> > > > the pamt_cache twice in the worst case. Therefore, add an extra +1 to cover
> > > > this worst-case scenario.
> > > > 
> > > > The slight over-allocation is acceptable since KVM already pre-allocates
> > > > more pages than needed (e.g., when mapping huge pages) in case of the
> > > > worst-case scenario.
> > > 
> > > This is assumes way too much about the callers and way too convoluted. The
> > > existing code already did but, now this is just too far. We need another
> > > solution.
> > > 
> > > Questions below on what that might be.
> > Thanks for the review!
> > 
> > 
> > > > 
> > > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > > > ---
> > > >  arch/x86/kvm/vmx/tdx.c | 26 ++++++++++++++++++++++----
> > > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > > > index 3186c4808cae..397a308b834c 100644
> > > > --- a/arch/x86/kvm/vmx/tdx.c
> > > > +++ b/arch/x86/kvm/vmx/tdx.c
> > > > @@ -1630,16 +1630,34 @@ void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
> > > >  
> > > >  static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int min_nr_spts)
> > > >  {
> > > > +	int dpamt_pairs;
> > > > +
> > > >  	if (WARN_ON_ONCE(!vcpu))
> > > >  		return -EIO;
> > > >  
> > > > +	/* Exclude the root SPT, as its DPAMT page pair is already installed */
> > > > +	if (min_nr_spts == vcpu->kvm->arch.mirror_root_level)
> > > > +		min_nr_spts -= 1;
> > > 
> > > Over allocating a bit is not the end of the world...
> > Before this patch, dpamt_pairs = min_nr_spts - 1 + 1.
> > However, when min_nr_spts is 1, the correct dpamt_pairs should be 2 instead of 1
> > (in the case when DEMOTE does not fail).
> > i.e., without this change, we would allocate 1 less page, which is a bug.
> 
> I wasn't suggesting to not change the function. I was suggesting to consider a
> solution that assumes less about the callers, at the cost of over allocating.
Ok :)

> > > > +
> > > > +	/*
> > > > +	 * Each S-EPT page table page + 4KB guest private page needs a pair of
> > > > +	 * DPAMT pages.
> > > > +	 */
> > > > +	dpamt_pairs = min_nr_spts + 1;
> > > > +
> > > >  	/*
> > > > -	 * Minus one page to exclude the root SPT, but plus one page for a
> > > > -	 * possible 4KB private mapping.
> > > > +	 * After each topup, KVM may invoke DEMOTE at most twice.
> > > > 
> > > 
> > > Why twice? You mean the BUSY retry attempt, right? If you do, couldn't we fix
> > > this problem within tdh_mem_page_demote()?
> > In tdh_mem_page_demote(), dpamt_pages are allocated from pamt_cache before
> > invoking the SEAMCALL, and freed after the SEAMCALL fails.
> > So, if KVM retries on the BUSY error for at most twice, an extra pair of
> > dpamt_pages are allocated from the pamt_cache.
> > 
> > If we want to fix this problem within tdh_mem_page_demote(), one possible
> > solution is to re-insert the dpamt_pages back to the pamt_cache list.
> 
> Yea that is what I was suggesting.
Glad you also like it!

> > e.g., add the following diff to patch 2.
> > 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 964739c5687b..e945885d5898 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -87,6 +87,7 @@ static DEFINE_RAW_SPINLOCK(sysinit_lock);
> > 
> >  static int alloc_pamt_array(struct page **pamt_pages, struct tdx_pamt_cache *cache);
> >  static void free_pamt_array(struct page **pamt_pages);
> > +static void reinsert_pamt_array(struct tdx_pamt_cache *cache, struct page **pamt_pages);
> > 
> >  /*
> >   * Do the module global initialization once and return its result.
> > @@ -1904,7 +1905,7 @@ u64 tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level, kvm_pfn
> > 
> >  out_free:
> >         spin_unlock(&dpamt_lock);
> > -       free_pamt_array(dpamt_pages);
> > +       reinsert_pamt_array(pamt_cache, dpamt_pages);
> >         return ret;
> >  }
> >  EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote);
> > @@ -2146,6 +2147,24 @@ static void free_pamt_array(struct page **pamt_pages)
> >         }
> >  }
> > 
> > +static void reinsert_pamt_array(struct tdx_pamt_cache *cache, struct page **pamt_pages)
> > +{
> > +       int i;
> > +
> > +       if (!cache)
> > +               return;
> > +
> > +       for (i = 0; i < TDX_DPAMT_ENTRY_PAGE_CNT; i++) {
> > +               /*
> > +                * Reset pages unconditionally to cover cases
> > +                * where they were passed to the TDX module.
> > +                */
> > +               tdx_quirk_reset_paddr(page_to_phys(pamt_pages[i]), PAGE_SIZE);
> > +
> > +               list_add(&pamt_pages[i]->lru, &cache->page_list);
> > +               cache->cnt++;
> > +       }
> > +}
> >  /* Helper for building DPAMT seamcall() arguments. */
> >  static u64 pamt_2mb_arg(kvm_pfn_t pfn)
> >  {
> > 
> > Reinsertion should be locklessly safe since the pamt_cache is either per-vCPU or
> > protected by the caller when it's per-VM.
> > 
> > > >  The first
> > > > +	 * DEMOTE invocation draws two pairs of pages from the cache: one for
> > > > +	 * the S-EPT page table page and one for the guest private memory.
> > > > +	 * Since these pages are not returned to the cache, the second DEMOTE
> > > > +	 * invocation still needs to consume one additional pair for the guest
> > > > +	 * private memory (the pair for the S-EPT page table page is reused for
> > > > +	 * the 2nd invocation).
> > > > 
> > > > 
> > > > 
> > > 
> > > Another idea, change the op to be:
> > > int topup_external_cache(struct kvm_vcpu *vcpu, bool root, bool private_page,
> > > int min_nr_spts);
> > > 
> > > Normal topup can set:
> > > root=true
> > > private_page=true
> > > min_nr_spts = PT64_ROOT_MAX_LEVEL - 1
> > > 
> > > Then we can calculate exactly what we need. And even better, the existing code
> > > won't nee a comment to explain the weirdness.
> > The existing code looks like this:
> > static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int min_nr_spts)
> > {
> >         /*
> >          * Minus one page to exclude the root SPT, but plus one page for a
> >          * possible 4KB private mapping.
> >          */
> >         min_nr_spts += -1 + 1;
> > 
> >         return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, min_nr_spts);
> > }
> > 
> > If we agree on the reinserting solution for DEMOTE, then
> > tdx_topup_external_pamt_cache() could look like this:
> > 
> > static int tdx_topup_external_pamt_cache(struct kvm *kvm, struct kvm_vcpu *vcpu,
> >                                          int min_nr_spts)
> > {
> >         struct tdx_pamt_cache *pamt_cache;
> >         int dpamt_pairs;
> > 
> >         pamt_cache = tdx_get_pamt_cache(kvm, vcpu);
> >         if (!pamt_cache)
> >                 return -EIO;
> > 
> >         /* Exclude the root SPT, as its DPAMT page pair is already installed */
> >         if (min_nr_spts == kvm->arch.mirror_root_level)
> >                 min_nr_spts -= 1;
> 
> This is assuming too much about the caller.
Please check if the proposal in [*] (the one based on your suggestion) looks
good to you.

[*] https://lore.kernel.org/kvm/asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com

> > 
> >         /*
> >          * Each S-EPT page table page + 4KB guest private page needs a pair of
> >          * DPAMT pages.
> >          */
> >         dpamt_pairs = min_nr_spts + 1;
> > 
> >         return tdx_topup_pamt_cache(pamt_cache, dpamt_pairs);
> > }
> > 
> > IMHO, it's clearer than having the caller indicate whether it's root or not.
> > 
> > > >  Increase the topup count to account for this
> > > > +	 * worst-case scenario.
> > > >  	 */
> > > > -	min_nr_spts += -1 + 1;
> > > > +	dpamt_pairs += 1;
> > > >  
> > > > -	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, min_nr_spts);
> > > > +	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, dpamt_pairs);
> > > >  }
> > > >  
> > > >  static int tdx_mem_page_add(struct kvm *kvm, gfn_t gfn, enum pg_level level,
> > > 
> 
