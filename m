Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792598355;
	b=p1y+hWnPo9xzyrWb1d9hw/8bcgKE35znBnGh7YeFRGK4qqPKTorsdcUwGXrG9qEdbEAA
	 S/Xtc26Y0oNE4Un1nrO9cDnN+2fUydbZysZZ8u2+UVFuzH8miGsoYFATZtWT5T6LaPR7U
	 niP4Ld9NON1W+by6bA6U00vf/8j2mDhhBIk5qdmllzR6ig8JZSeYeDr6XyQ+zk+MUt6w+
	 LrvUrfpGqhKcgBYEPu/mD1j4enyUlqFYi7WCtNbYwI6SBAOdfRFxczidJ33rjoEN/fX2Q
	 AflTgAveZSrs0uwo16UmWPW9ITRGfk7NAUE2snnucjaLiLlx04qw95DnOElo7YtNk9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598355;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=MgbkmyRY3dWQ+0q39TGlReSJ/nHDw4nZJBjNAY9+L6k=;
	b=Pc+MzNrnUFU5o4S+z+Vj9R93KCf4+v9tDg0V/9xmdJS/KTW60dN34noIkKPm24uwVJlZ
	 4YKuvuWQ1t1m37shvFYSSB55fnj7fNH2etOpiUEmGyHqPWYN5q+hdrjM45msaUyPcXcPN
	 At3y10F+lMKMXnrQAm1D7EWNrNlGslE/zmxRR3VsV0g7hPOrVBhsPvwosqcbo0QEdCs7n
	 0ttRiF0DtWGwRmEibABWya3XLRhcRQovg1eRyPJ4Yoq1M/TxvK9zRZyPbljqtlsQ2r60p
	 l6fsuk4DgX/WtsFO4K4uwkJqgs8F8HZ0ldNkjB8/Do7TFyAOHyJ/2wnNachaCaemSow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YpkV7Dud;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14C606A327;
	Wed, 21 Oct 2026 15:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF14C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YpkV7Dud
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792598355; x=1824134355;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uxAydxtpEwe7RkSH9CgBeuOpMuIqxWJqbYhQsY88R0s=;
  b=YpkV7DudrnUeTKCUndrNnJhA3azIBK2x5TKyfZEhNnhXQqBMM1zT3Rtn
   nem1CdkbXxe6Nx9zR5LOtkvxOkfOpGjtthBXxTZhvcLEr7254ZF0yDFjp
   Uvo64cAYnvxIRlUYNPKS8mx2wzoasaDbTbPHfn1wBggQ/0xwLz9bkPnM4
   KkyNjSp64rT3U/BxzRU6JYJeC+gXQ66lTX7TgngMX1lbyZASqAA8un4Wk
   8NW3IboT4KrGIE4T08+ME2/ZX8n8izTvP7lL062g9VIbrztt8tbvMUZ76
   hv46N20qj974AOeGuIf+9VF8YXPXV33o1VjpcXF2SFAchScqCeHAqbZph
   w==;
X-CSE-ConnectionGUID: vsFu+HHsQwGrpZvN2N6Q4Q==
X-CSE-MsgGUID: gvKf0GhaRz6tJ73fV+WaUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1361660"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1361660"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:59:14 -0700
X-CSE-ConnectionGUID: fUBVcnIXSMqvMOh1DHarmA==
X-CSE-MsgGUID: 5TcETsNpSImkPVn0fA65dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3441003"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:59:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 08:59:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 08:59:12 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 08:59:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxX7eTscOpyAOYuHSXnuFCOAfLqXvr382ksi5LfHW26MeTM81HpGMls76E5tmj3qstxAQtrmMyW7GLFxUn+9MvRgut1ZXrih0sRSK0BJLpsQ3mSIU0Kg3AnC27kkfOtNEf5IHIt/6+20JWgC7P+1Qt+o2R0mJ14nCpZLiqLMa9jMv3W6C+ElpOry35/Xi46gZfZkxJebbVwrFwAHCEiMVinX9/fJy4Fm27bGew1O/n6U/d9OCsGJIk5PDkuTeLdiFyhg1U4wq30R1s5UI4X1UdUtmz2NiLkAK5n4haL/KI+juh9HjsSXyMfxSSoEaodYUtvwd4SsZWm9e+Mq+hmk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgbkmyRY3dWQ+0q39TGlReSJ/nHDw4nZJBjNAY9+L6k=;
 b=OOPHflYQSbFzaLdT7b2+a1Lnbo/eoTvg6ermzh7tqkY8gvC+w2ayywe1SvYcg4dRt70ei8/hkX1JWHJqvmzYRqefu51gpyA64JdymP8EPfZu+R2VmUjm6L6QYF+AmdLkK3oCJP8C8Oy8qpaOxzMLw7jP4ObboVWipu6CTiA5+EA1oEELDs5z5C8+Njfvab1/OwuKOAbXVydNkM2ZIM1xQ5YKy14SOYVd+MhXy3vlgpx8Cz4JC/pAbvL9jYHlxvpMMDtUBwzKT8FrwLjqWG0Ri4WqToZIR6uRuaFL5SU4PPn6j43D2XYT5StbYpluGXMXla67VZDUjLZRTNFhh6kH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by EA8PPF65D11CA20.namprd11.prod.outlook.com (2603:10b6:30f:fff5::794) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 15:58:58 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 15:58:58 +0000
Message-ID: <69748525-438c-48be-8876-6e6cf1ba88fe@intel.com>
Date: Wed, 21 Oct 2026 08:58:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/18] fs/resctrl: Introduce kernel mode enum
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <66efcdc1bf71c1cb47c546b1d1299b58594bd30d.1790867441.git.babu.moger@amd.com>
 <6764525f-0245-4cd3-b35c-c2bbf4e65733@intel.com>
 <a23f9f1a-3c5e-4166-8956-86c3063a9e64@amd.com>
 <14e8bcd9-4431-4dba-887b-c5b5e156dea3@intel.com>
 <b8ec67ee-3a5e-4c36-a1c6-2b291d013369@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b8ec67ee-3a5e-4c36-a1c6-2b291d013369@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|EA8PPF65D11CA20:EE_
X-MS-Office365-Filtering-Correlation-Id: 91dbb199-e520-45a1-cc52-08df2f8c3757
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|18092099006|22082099003|10067099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: zG4BkV85wi27JXzY2dNB01yVgVjuBLoDLdPyIAxzu3uOtS5TJLk0tPuLRr1CuGMmH9bdrJOOYJLcVmaR+q+ODl2uVZNZJfDDhgbGAdyNy4KH8YjUluq3WkzvXuWHDgyh86qH28eG4cYVVZJ0hD7qLmIMLIulKe8D4jWUprq5QYdrmrg3j++im/edWrabDKGjwo8aaf9WqbfbZ9qVNOoecgw2vQGUUss9YmSdLaugi15sFWxuIdbdrtQQL3GsSEWsZZFQId/xQIc49RIa1MlvnZc9rTyRSRw5eyVXThNhhLBxy/Uk3iyDcbLZ9F7vrL5TJhIhbRjbtX0iCSuv90w2Ww2dgk5xalPb2XR0wc9wiWI3M3cJzNHWkn7rSNIH5hVBJ23N48WvnxEwcCJERQ2vXo2aXM6lcVxXVYyrba1/b0UueCp1UO608PYmpKSI6Eum5p/iA5RRIqFXcNKGqHEc4AEkOeJHaVY8Gg8s/ehB13MckjYmdWuJbV2Q/8ZTdBkEVhooBjD3AztQLfHXwa0JaF3khtUJyAqQZR7Ub8kIN8CEzUDJATkKQNGu0Y+kPoi+WgNTkqWxyKMO/YEfSlVIz6IiXBpqxAxYGV1ehQp2RGPbiI6OWuSN2lFpfh+sPl2RhcpG180oqL40IwOv7LWFuAlmEP7mPD3meUprkuqw4zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(18092099006)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFcvbzc3aXVTOGR2YU5oVjRPYWJyT1FFV0VySy9KTXM5NGRHUDh3Ym1CUERz?=
 =?utf-8?B?L1Y4ZGlWQW0rd0dIQVl2ajBJd0kwTDdQNTFlNEh4Vlc5VWgvaktwYmZIelN1?=
 =?utf-8?B?SlNiSHBTSGt4bzJIT3M0UjVIS0ZoUDRLQUR4LzlWQVNRWWNXQXZxeklGRGtD?=
 =?utf-8?B?eWVaL2dpTDJUU2E1NEN1bGpaQ1NpWmpZdlhJVGZjODBXMEhLbHZKeEpLcG1Z?=
 =?utf-8?B?cmg3MENOcHdvenEwS0VTQzRjUkV6Q3huOTZVQ0pQdzZPd1REMTllb1BOdCsx?=
 =?utf-8?B?b0dpR204LzlEcWFYU0NGaTNwQnprSEFSSVhobmFiRXZYekYvLytEM0xyY25i?=
 =?utf-8?B?d2pkK3J0YVRmeDFLZUVZMXNZT25MTVdSNnVzdG5YKzZRT3Z2SVM3TGtmTWNE?=
 =?utf-8?B?ZmFseEcyVmJUUTlaVGxKdGIwT1BtRTE4UjEyK1dwaEpqbVFIWHV0YlNvTmJh?=
 =?utf-8?B?dk44RXlqSlY2aVlkQUtpRFVPcXJTaVNaM3h2YXpQaXliTG9yUEJEbUFSTS9C?=
 =?utf-8?B?MVMwTHVWa2NlczZBR0YwUmNrazRER2w1U1FIK0VkR0VxR0FVM2wwOXBZMmgr?=
 =?utf-8?B?dXA1emRHb1RQYXcwTzFTbXlZSk15RWxpaERDUFl1bnhrdldSRFdncFEwWWRl?=
 =?utf-8?B?bUJkMGx2Z1Z6ZFNBVm5ERFAyRUgydzNad3ArWmVobkV0RGxQbVlpek1QMjNl?=
 =?utf-8?B?N3lMczQ2djlDQ1FNcUJ0TXZ2TVM1QU4rUVFJUWJQbHdoLzFkNVI3SkEwY1p2?=
 =?utf-8?B?QjJrZUVrZ3dGS20zY1ZvZWRKRkdnYTVaZ0FpN1VCcUkzSFVDTUZvNCtlSlhM?=
 =?utf-8?B?cFlZYkZDL0ZJUEd3Rk9XRm05OXFmTkcwMTJDR3RyKzVXZXk2ajNiSSsrV3Yw?=
 =?utf-8?B?bkVZTTJVYndJWlhYdGxvNUpmSG1vM2xpaFpxaFpsaEEyWWhHajlNdFY2TmND?=
 =?utf-8?B?RGNqcjA0cFFZcEt4ME9NRmtiU0RCdEJhS2hOTjVrYmcwamFyYU0rQmJyaDJ0?=
 =?utf-8?B?R3VvUHdCbFVyNUdXcER0eS9HRnRESHRYT0xvNkZmcnZhK1pUNUpjdVZkdHpL?=
 =?utf-8?B?RXNEOVo5aS9mKzVnRHdGVktWMmJDQnR6T3NIdHJJc1VFMnE5N0k0QzdQTmN0?=
 =?utf-8?B?STNhaHZVOTl6RUM3c3k1K1lxOC95T2ZZRThRcjFmWGlCUDhzR3MrUEY5SDg1?=
 =?utf-8?B?MVA5b2lnQmpWeWJRSFUvTjV3MXcvbFh2YlRhUXZ4Z3lUNkQrbm0vWU5QLzE0?=
 =?utf-8?B?SnZ1a2NpQlFpcjZ1dnlBNDVpeEFiNFdDci9SSzNWd08ydTBtSmM2NHk0MDFG?=
 =?utf-8?B?NFlwbnBWUm9yK1ZLNTFqSjlhOUd5Ykp0c1ZEZXhicGgxR1JiN3FVdmdUVmJa?=
 =?utf-8?B?YjdYNnNDb01nMnRTS0pScGNFalJ3ZWJabnUrS0o0NS9DU0pxelY3SEpYdElq?=
 =?utf-8?B?cnJJSDZ0MldMbUhBNUxHSWR1N25PakRiM0FReFRZaGhhZDBoTEhCSmRoN0pm?=
 =?utf-8?B?SUcxWkpNZzQ5blcvUWFpY1Nua2ZGbEtLdENuSHBVZGxGZkRRNkdCUkdVUVNm?=
 =?utf-8?B?VWVqMk9mTEFueU5uMXY1UHZnOUhuSTVVNUZ3bDdXaTRQUk1URGFJSU9YU25x?=
 =?utf-8?B?cEFaeTRiUE56QTNGeTFGd3dvRFVkMnJhLzRUMURFTEY2dVVnenlmanZvUG1Y?=
 =?utf-8?B?UjlZNjQwenlPT09BQmNSVkw4QUdLanZwNW1iMEF1NnFiNnRuTkVucktmUGla?=
 =?utf-8?B?SGtkMDdTYWJqWU5kVHJPU0ErVUU1QTdKQUYwMjBrZlFxNkVBSStGMytkVFRo?=
 =?utf-8?B?akthM2RQQmkxN0NvRHJBbnBoNWU2c3hQYTRVVFc1WlFaV2J0aExNeERCSU5k?=
 =?utf-8?B?UUV2amQ2ZW41ZnVQSVV5QXp0MlArU2NIbkpaamxZdVNEVm1YREdpWXJNQkIx?=
 =?utf-8?B?K01OT3E2bGlzTWRIM0w1VzJUL3VIQ25rKzNzdFpyNUNwcU8vVTZXbS9CanEv?=
 =?utf-8?B?enBhU1l0OVNlUVU4amdURko5Uk1vZ2NEQk93YlBqb2JOK3lnNjJib0UxYUE2?=
 =?utf-8?B?Q3UzNE1JdG9qMmVMdUwvbjNpSTBTZ1NRZWJIUWdmMHNQcUZ3Sk5HbFR2TG5m?=
 =?utf-8?B?TnU2VTgzSjFDSHNlYW9GbEdUNlhqYTU1R01ycmsra3pUK2NxVEJMZjJud1Z4?=
 =?utf-8?B?YkQxVVNyQkdFQTZJeHhWcmRKdThMaGdzcklKZU9oMGxCWHYrUXphMVNPSkNL?=
 =?utf-8?B?UEVFVWlNSjgrMlJ6UHdqNGdnYTN4bzlSRVhxTjExWmp4MWQvWUxZRG92anU1?=
 =?utf-8?B?aHNMelUyUFcvRWszTjN6ejB3UGdGK2tPZTE3K1lYbFVuVGNSbllvM3FGb3RF?=
 =?utf-8?Q?N1cu7fO5hW9IyuF4=3D?=
X-Exchange-RoutingPolicyChecked: yB9Za4vrqB1ai3FyLt80RzDIbtkByUnZrFMSXkeWpf8AejLQvp6Qs+d5aouaEnOVFbCkSoZh0V2LTQUgPIoo0ac6ay93mHr6roASBzqj1S3V/B54HliwakVvDFMo+Nl/FR8hsjCzflinsQCm+IbpyBIPBNx3YwotsJ2vQoikkOj2aP4aqywpm999K1yslmZ886Vlv9V/mXhyC/kl2OOKgXiXoAmIXpp/7IWIlnaARBNVztIhLv/W8AZLkXIGDi6wGdBs+W3zF5cnXzjTZsWiCaQZj+2q2EE49HSD+mggVM6+ubxIS1QL16VtDJq0OoSQIqV8A/w9IgJ4I99krYyqTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dbb199-e520-45a1-cc52-08df2f8c3757
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:58:58.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6djKmap4RXVjpLI4xcn7euI2RXwmPlqG4blm+g5WoOHrRMMcJ7mZS8j6CbxfllJlZ100DZbSgSsK2v6UZ3QZQ5rr/zSPy7wyL8+yHnSz1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF65D11CA20
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/26 6:58 AM, Babu Moger wrote:
> On 10/19/26 11:17, Reinette Chatre wrote:
>> On 10/15/26 4:09 PM, Babu Moger wrote:
>>> On 10/15/26 09:44, Reinette Chatre wrote:
>>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>>> Kernel mode work can use different allocation and monitoring associations
>>>>
>>>> Here I think "different allocation and monitoring associations" means
>>>> different CLOSID/RMID, while other places "different allocation and monitoring
>>>> associations" means different MSR_IA32_PQR_PLZA_ASSOC.closid_en and
>>>> MSR_IA32_PQR_PLZA_ASSOC.rmid_en?
>>>
>>> That is correct. Hope text here is fine.
>>>
>> I had to guess. This is the same topic as being discussed in patch #3. Could you
>> please add clear definitions to eliminate the need for guessing?
>>
>>
> Ack, rephrased the changelog to use CLOSID and RMID terminology to
> avoid the ambiguity around "allocation and monitoring associations".
> If you agree, we can use CLOSID and RMID consistently throughout the
> series.

I agree, with emphasis on consistently.

> 
> 
> "fs/resctrl: Introduce kernel mode enum
> 
> Kernel mode operation enables a CPU to use a different CLOSID and/or
> RMID when executing in kernel mode than those used in user mode.

Please take care to distinguish between the "kernel mode" that defines the
policy here and "kernel work" that is what the policy governs. At this time
this series even conflates the two in some places ("kernel mode work").

> 
> Architectures need a common set of kernel mode definitions so resctrl

It is resctrl filesystem that needs the common vocabulary.

> can report supported modes and indicate which mode is active.
> 
> Introduce enum resctrl_kernel_mode:
> 
>   - RESCTRL_INHERIT_USER: Kernel mode work inherits the CLOSID and/or
>     RMID of the user task.

This does not look right, it inherits CLOSID *and* RMID, unconditionally, no?

> 
>   - RESCTRL_GLOBAL_ENABLE_PER_CPU: Kernel mode work uses a single
>     global CLOSID and/or RMID association shared by all userspace
>     tasks. The mode can be enabled or disabled on a per-CPU basis.

"shared by all user space tasks" is not right? The CLOSID/RMID come from
the backing CTRL_MON or MON group, so they are shared only with the tasks
assigned to that group (possibly even none).

Below is a suggestion that aims to address the comments. Please do not just
copy&paste without verifying it for accuracy and that it matches the terms you decided
to stick with.


	Kernel work need not use the CLOSID and RMID of the user task on
	whose behalf it runs. On x86, Privilege Level Zero Association (PLZA)
	enables a CPU to use a different CLOSID and/or RMID while executing at
	privilege level zero.

	resctrl needs common definitions of how kernel work is managed so that
	architectures can advertise the kernel modes they support and user space
	can query them and select the one to use.

	Introduce enum resctrl_kernel_mode:

	  - RESCTRL_INHERIT_USER: Kernel work uses the CLOSID and RMID of the
	    user task.

	  - RESCTRL_GLOBAL_ENABLE_PER_CPU: All kernel work uses the CLOSID and/or
	    RMID of a single resource group, which may also have user tasks
	    assigned to it. The mode can be enabled or disabled per CPU; on a CPU
	    where it is disabled, kernel work inherits the user task's CLOSID and RMID.

Reinette

