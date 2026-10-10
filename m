Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB21369D76;
	Sat, 10 Oct 2026 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627583; cv=fail; b=qxNziJeE8RI66/TBFe2R1RTVSCP67nlEdMiz9IgBduCjDYa2x9z3ZnxVZsXbbq6747YGcJmxIA+hi+CwlQLzaIFArMtoD+nXH9Eq5fuGR0kCNcXq+x3v+kxCbeyMibN+3gHykzOwSKTFfbBRvoBCyKIodGK0SDhslE+s54F/8JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627583; c=relaxed/simple;
	bh=hJEped4w3nxGBSC8lSD/7ygZDqhnvp4mWxBSLHyabFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H3hcgeKpW+jy0KjahmTgAGYzF55d/RQnJbx1iMD1XLhU2P+Y4SbEz+1Ko8wEMNiNlggO4LjFP1e6e/hAmwPCJq1bY105ejEdMDzXXXQjNvpVpwIBKQLpCtWzsXONpExHZ9iQodi6vnKhPYLSUyap3bspFmoBcr9o+LxRp1DBHH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STELEe8m; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STELEe8m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791627581; x=1823163581;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=hJEped4w3nxGBSC8lSD/7ygZDqhnvp4mWxBSLHyabFc=;
  b=STELEe8mBsmYZPLAdeem/dZwhN8Wwdx6kwHPL71PFLL8BMerp3CI7IkX
   3qzIiFeiO86FrDH7jcKH1FcylrEW5rpCkykRJvlr+4blP5JP61LtPrxhE
   +3ffnYWoZATowBpAbKsxQQm31wNHSuB0ByZCxVeQdkqF48v7f9HF7zjkx
   r873hxq2HsLkmINH3O6MiPG+oRFjVjmtfvqeusgKNYSQmpc0oWbnrSPgH
   8u+x1gMrH6zhhJgbcys/d+/ucS0HOIUKR/OYkP7mHeMFUN+U5gBOskO2k
   M3GYmXoKFtZovDV4lfy/GH0G53+lqVUglLN/AmYSVrwEMr05nid+Xvvd3
   Q==;
X-CSE-ConnectionGUID: 76QGbIHyRlKgu5Ve9VMDjQ==
X-CSE-MsgGUID: 6rplcQRsRX+sZ8QaADpAVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="422140"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="422140"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 03:19:41 -0700
X-CSE-ConnectionGUID: T2SOETLXRpi7SHKKnMy1Iw==
X-CSE-MsgGUID: bTljl1DDRu+5coUkB4VhyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="2304882"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 03:19:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 03:19:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 03:19:31 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 03:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyPPlrBRMu4y3yKSSVnvUjbokq+LBr5alqI/GILqnD+VQ6nmquioGyBoAVrmnojFfCH2GT3ksnKDjNEMsLt9y1BHpJdHtjBgb9jaq9rcDutGKmVSbeQT3h69VsQqF5AWfjQ7baXCbKnZfooD2qBDUjb/MtLInCOWKiLsJFPuCpRJEBlJ7rM3RARDCcZT6k9PzfO1L8XtCH1GUMow8pOb4P0+FE+VVYuXGL5WP2Tp/He23IIOmKl4U7LJ4japLch0B16ah1uvYbelnf+N9bnJ/Z2JxjvBbFjyUaB80VlO3J8gn1lyzZpiPKyVmw0jZ6w/mdRdmXhqvZJhZgraui25Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2Al5NFT4RbAkI83HIS6ut4FKdQxSIAHKGaZDFmK5EE=;
 b=gh+jBjm9qrzOTqy8jpNkfd27gZJGcwj5AnPvNf98HCRbpbvAvfhjx+E2nJD/DfIUOQEVy4QZWWsOr+Zuq8e2bDRULYqtAITAPFEyAs4Y6SqlMOO5Vozx75UdL/B5ecfaFVKxvBFtBDxKbH5r6FAMWdPW3+RoFWe2QB+kpshg1OoTpC1G9qxW18RLRj5Q+2mpYq0qSiil383RkxC38EtlYIWKxYFXpbNzLZOwqgShBuv/6mmLTJFH9Jdae5sW+MrUkVKlyB4FJCwSDdfDlphnv8v/WAZ59UPAlFtQnxUnhPPQvno3lLupP+kVWFDomHPYF8lR/RtEaDyVlE03Y/uTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sat, 10 Oct
 2026 10:19:26 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 10:19:26 +0000
Date: Sat, 10 Oct 2026 18:18:36 +0800
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
Subject: Re: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Message-ID: <asoQ/P7sghrEVDQs@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090808.15484-1-yan.y.zhao@intel.com>
 <e494996660b45273590860e961b36378c4099c03.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e494996660b45273590860e961b36378c4099c03.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::10) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DS0PR11MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f25e55-bdab-4cae-7975-08df26b7f61a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|5023799004|56012099006|6133799003|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: GYrGw8ZO7z9LrFetjzS9uLHEehI4IwhzZ4cIjbeTPenehI5VshPYMB/I80WjI3jZg9Qj8qB+ZtUlw8kj/b/MmSFD7xyGCoRen8xZzOLRyZfuG3NGJ1fSuKc0KTM/ZL22pUi79reOBZv411zDxMuza7dorW2g2tjSfDTk0dFLoIe8ypl1/BBDAroShQta7UXIQR1I8PKNRjuVFb19o7d+utwxxzu226oY4cow8xuxCFHSMpCnDpSFtLhRSCbsZQA1sjgzq5w1SfhBMJTvPX/hEgBxrczc21eEGN3QCWQ9dadmhWkLnpI9YVmra/SDMEYbVBuaRmvWgXkO1DJMMc2AS5SS1WESh3YAMGo/qn5Vrmb1JA7FxztZ0O7jBJ0lng66It+z7SKsHjpWTtWWL6302BCHDkGtV3wNg+fboMNlkAncO35kfU/tydmqqk9bRG1CD7pkR4waaE9hVZosRtLDp+bCX1XiEMN/QaZnRjbJb6R0blivJs88ccW4AnkHCQ2YkPXz6LK5MJMxhnEOwDfobehbY0VqhYTRF9pR/T0lWRv4e34hQNBo0atkg6V+M9/Qvp+h1o8f0bDJR6crV9XC86Qnu4Xq+Y7RUN0ZZpfDDJTSrtSC680JjfnsJ5JjJvDGQOktE4tRqdjsxLNdkuoLe4EEKTCek3xmwsmFhBe4zjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(5023799004)(56012099006)(6133799003)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LN/zOs/5z/4A6d+TZgFUZpc1vhg7N6as4kebKK60N3PpLmBNZjWBacQoU6GP?=
 =?us-ascii?Q?anPYBgXpSAfnJzEEI8cSvjI3wuvUBk7wwAeBGmBP7cMlTKI1CcL4fyRUzKwi?=
 =?us-ascii?Q?vb31BMx3j101Su3xZo5vQdzh2qR49jjDRLU5cg5QrHqBsjxq0iQXE4ycjeUC?=
 =?us-ascii?Q?Idqhng54AQP0odFW9AHF9aXWL9tJauhQEwq9HqPnwbTJEvTqZWvqVaVr2BZJ?=
 =?us-ascii?Q?DzdsIXUPz6p+YU7lJt7qrWx9pectbf8UaCPC49X7xmOs0a8a+KPQAtgMZLLp?=
 =?us-ascii?Q?CKjiyfTXUgwGtbwJkj7+wkdan/lFQoD+JAiopYVGcaobINs5T9U+9BGNQDeI?=
 =?us-ascii?Q?IV5krd6gjKeu6k+HKjBuFP6hw9gS8bo1Rc4e9QytX4YKeq8FYXXnLdWeQOJ6?=
 =?us-ascii?Q?VmHvlTxP6yaMjvBRCVS13OWvH7dKtgBG64NWB7f74/Gj0jwfUpCVzJAe4xyi?=
 =?us-ascii?Q?C8Rvt9rRR9Ax26YwK7m/sgZTRHlml0Y+MJDK+7D9BDr1SDv96uHN53ibSacP?=
 =?us-ascii?Q?Wb6wdH61if/sngqxzdz62S7JU7m1u96VjEUBYgNrKjWOTDGNWCXxlRZEiPz/?=
 =?us-ascii?Q?h29vqWr3IGFHTBK+kpHbEfL8XQMfU2MaktojKcKlgeTmMAXnarU3oUyP7T4U?=
 =?us-ascii?Q?HAoDFo0FzOIXwrkzFAoyJNDywnANZdW83hTxWhubkUsh7mnYsn6d0/DnCutO?=
 =?us-ascii?Q?ziiAgYjUOckylwXNyv1TXpcCCJ2bGHHnZvWajcNbKFqM05hj0Myg5PqpbmIs?=
 =?us-ascii?Q?OhG5apsuXLN8QHgXZL7+btfGb/u6WRoV3dyk3USCe0PzO5NTsWZIkp6MKCu7?=
 =?us-ascii?Q?ICGsLP197Zn6LFtng++p2Hk9K6tIAMMAG2MtqXVvXxwvxXzbtQ6J5HZjEQwu?=
 =?us-ascii?Q?AVelkx79uO7PfOwRKWiBKzcE7Wi+5e0pwCKTd0y3+nFW0SPLBwmxV7TmKWza?=
 =?us-ascii?Q?dnrAzOmjHOYM9vpDTZMegozJWRGqNIWmz6lW9tdeigtIgHoQ7D0lbdAojEAy?=
 =?us-ascii?Q?hO3/8r4Grsys3928Qey3J0blmmMw3OyO2NKGZVGNEiHOksrVLWRY0KQ6nl5Z?=
 =?us-ascii?Q?xgs/5vrvN68eK8Xok/ODRQpWsvQDV3hFm3nsuT2SbFw9HaMPtkUHfLNnj46F?=
 =?us-ascii?Q?nIGsMqYHG6lr1nwEmVMw2py0BLhT5xjz04Qid2us644t19KR/ndK/9yVcT5c?=
 =?us-ascii?Q?SgQ7eXQ7qVNStQwUnrb3raTY2TtJI9ALXge2KnkEEWft2WCWV9OjuD4kuUWz?=
 =?us-ascii?Q?xBhiAXqAx+4O1X0LfTJNo++j3fg5T6a7yKAj4YRBmEGDxfP1P1uM/GGLRLmU?=
 =?us-ascii?Q?2nvoKNuvPbBgIeCJikSqwPrROltOVCEWfXmXNolNijjg9K9ZZ2SnP0WNiBK5?=
 =?us-ascii?Q?uibz2jdhYsawGxJNcnLQgyJWLImtAzskpWoooWtvClHlLvjCv/Xg8k/hrf9W?=
 =?us-ascii?Q?jyDAIuMVWToqxBRd0W5KRE3vCLYT1HQ7+TOuS8HfnQQf2UupthhNV/+/4gEZ?=
 =?us-ascii?Q?dILyoY/slyB5oKNut12hSSKrRVWAZs6Ns8SK6izwytXozJIeCpcNfuzyM0Jj?=
 =?us-ascii?Q?aSEONc5pOGpd2yaLbAZHYGuLPHcfTLfXipPSIVYUevvqvxlYkPMi6wekFPWK?=
 =?us-ascii?Q?xZzotCG8SkzMxiML9bxepx9JIfj7YvAKk99mQvnQNOMQBSW7SC1MmZzmtl1E?=
 =?us-ascii?Q?zTRal0gBoY7K6XJ1SLRs+tmsnxqRH3FXoXfXMaqAklN/JM8OxnuIb1Bh9QZL?=
 =?us-ascii?Q?IKCumytXbg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Oyk6oqxPj6GQG0Bw+RmrC8jwhDQV6ayMnXvSG9WX208nXg+owbBIhYOiJMbpaGlBzT3hO9gevn8SLQoVxb7aMDyo+bQjLktg+gAfvioWIP5O/YPEQwrDytb2aOMV4l4RCnleHt6SUrT4O3sjTJkN/3NKhDNEisFG0ls7M6QiLz2Bk1NjE6tryomRy22LaQlTC5C7H+0jhpZmS1yQ7Gs2udAMAYa5bp/HjdYe2pUx4TMLNQOjZ0H2qEh92/u9TbwqJFe0NOGLp5BMR8vBRHcmgkw3AL1AkGMm1mSEILLw3gsTzmRAhELpzvu0J8ZLKIpQIckbiyylHSSqzSM7/DgjhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f25e55-bdab-4cae-7975-08df26b7f61a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 10:19:26.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRCeiur7B7j23EukwHzZIccFlpOtONg5Rbf0BkMn8oEaDgqja4k57TcyMiu6oDSEMWoT1b67iPshIbTAoroPow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com

On Fri, Oct 02, 2026 at 07:02:40AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 17:08 +0800, Yan Zhao wrote:
> > The TDX module uses PAMT to track metadata for every physical page (within
> > TDMR) across three levels: 1GB, 2MB, and 4KB. The VMM is responsible for
> > providing backing pages for the PAMT. Without Dynamic PAMT (DPAMT), all
> > PAMT backing pages are allocated statically at system boot time. With DPAMT
> > enabled, PAMT backing pages tracking physical pages at the 4KB level
> > (referred to as DPAMT pages) are dynamically installed and uninstalled at
> > runtime.
> > 
> > Currently, the VMM invokes tdx_pamt_get()/tdx_pamt_put() to install and
> > uninstall DPAMT pages under the assumption that all physical pages are
> > tracked at 4KB level.  However, when a guest page is mapped as a huge page
> > in the S-EPT, the TDX module tracks it directly at the huge page level,
> > meaning installation and uninstallation of DPAMT pages for huge pages is
> > neither needed nor applicable.
> > 
> > Add a "level" parameter to tdx_pamt_get()/tdx_pamt_put() so the helpers
> > can skip DPAMT page installation and uninstallation for huge pages.
> 
> I guess this means we need to make sure to get/put at the right level that the
> TDX module is using it as. For example in this implementation, if a huge page
> gets demoted, we can't call them like this:
> 1. tdx_pamt_get(huge_pfn, PG_LEVEL_2MB)
> 2. demote(huge_pfn)
> 3. tdx_pamt_put(huge_pfn, PG_LEVEL_2MB)
Actually, calling in this way is fine, since steps 1 & 3 are effectively no-ops.
However, we can't call them like below.

1. tdx_pamt_get(huge_pfn, PG_LEVEL_2MB)
2. demote(huge_pfn)
3. tdx_pamt_put(huge_pfn, PG_LEVEL_4KB)

That's why 1 & 3 are not required and DPAMT pages management for the private
guest page being demoted are handled in demote().

> So it is up to the caller to reason about what the mapping level is.
Yes.

> Which makes me wonder what is the point of passing level? The caller has to
> reason about what level the TDX module is using the memory at. The
> pamt_get/put() have to take their best guess at the ambiguity. For example line
> 3 above could actually free the PAMT, but it can't know to do that. Unless we
> added some internal tracking, but it seems too much.
>
> There are only three places where a non-4KB level is passed to get/put. We could
> alternatively drop this patch and have KVM decide whether to call get/put or
> not. Since it is actually the only thing that knows the right page size.
> What do you think?
Are you suggesting the implementation in v3 [1]?

In DPAMT combined v5, Sean moved the level checking from KVM to
tdx_pamt_{get/put}() [2].
However, Sean's version introduced __tdx_pamt_{get/put}() for invocations where
4KB size is enforced.

During our internal review, you said:
"Can you also justify why to have two functions instead of page LEVEL_4K in a
few places?"

So, compared to passing level to tdx_pamt_{get/put}() while introducing
__tdx_pamt_{get/put}() for the always-4KB invocations, I updated the patch to
drop __tdx_pamt_{get/put}(), having KVM pass 4KB directly in the always-4KB
invocations.

I'm actually ok with any of these approaches. It seems they all require the
caller to know about the right level size and whether to invoke PAMT get/put.

[1] https://lore.kernel.org/all/20260106102304.25211-1-yan.y.zhao@intel.com
[2] https://lore.kernel.org/all/20260129011517.3545883-30-seanjc@google.com
