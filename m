Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C53C5552;
	Mon, 20 Apr 2026 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722639; cv=fail; b=lO4mEc1zlD6nfZOaIW2u63F6JR+nJj6CLgrTOstOyuD/pnnUGXm/mIqB+/bEpMiQSqoFt3JGfoJOy7dJ03ZHrHS8yGdxSZrjw+0Edep4LCePwRRbHewwMxzD1+BfnsQnBtEtYfjeSb0x67aIk8WOt1aDDDUKJSNpLxac4geS3I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722639; c=relaxed/simple;
	bh=9kjeWgIy0YGKc9COPeleyFFuAYX7QeUScq47lxj/3Ws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ckt73VeGkPUQEFbLtBIt/DzzKnyySscH2w3Dih9euV8R03WFtqVkXcs4SjsIZANLF4wGILULA5qzaNL/8BSIncJyvmkzgfMszzYeFr2mNXeR9Yrbr9kvOg083OrFsfE6oFWRnBVwX8elyWkfWCNjChrN02+slJr0HwyQpE/kQbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOArAWoP; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOArAWoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776722638; x=1808258638;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9kjeWgIy0YGKc9COPeleyFFuAYX7QeUScq47lxj/3Ws=;
  b=fOArAWoPosPcBvMPedp/q0LLNqGTz9N0LkmLhU7kiHZEOaeWNzhJynTd
   sA0z553mPvc8PgKR5mD2uT5q0/OhtQ1VchL2qJqMYrJ2EEjwoCK8NwO1u
   vV58sXQr64eHHuwWf92ljX09vVJIbxQ4/jhkmbFhW8gRjUgSoyDjRl8Bw
   Wy8pb1goIph+j5nCvQ91k11NgqK+ElYx4oYzG5BMylgalLbextfIbXT1t
   LwAaDpUcTO5NXcRQ7n9CptrSh9A5lJMKcYUuMc28SKw26nveJembNvfIw
   5cYRbfanqr+8VhWndamKpQw2IcYjJOvHR4ij7AdT6mmZX6eMt64ltou6C
   A==;
X-CSE-ConnectionGUID: EN9suvT3SoespCvPycKjBw==
X-CSE-MsgGUID: ZA7tEfK1QYu8pY18KU1PbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77562581"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77562581"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:03:57 -0700
X-CSE-ConnectionGUID: IpF9MTJYQtK5vZx4MxuIrg==
X-CSE-MsgGUID: wYZbZl0dTf6nElGHLKEeTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="262234603"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:03:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 15:03:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 15:03:56 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 15:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvcdtZHCDLAx3yYD096upZRo/C897UXE5Og7tbFp1O8C8J7gD660AZaYz03/xG2Bh9uQ9fPjtXgg6sHooiJIC7HzjIPAswj7GDM5iBuBjCYs9wlDu6s+sDwXswMxdXgjBN7qsmdZGKpst+aLvOHTEaD19Z8d55D5hAjuamODGXoa8Tt6YJ+F5pZlSyJ6DkF5uTVV7aOptfKPiMW7hZbz9i9lQNWIE/t1D+vSe3hFG2OdBdQ7CWaY6r+GfH6wdRdm+NlSVxf1M8ELiLw+bs5OAr7x16a3g+abxGAO6KMPYmF3S3cF3+4qYB7eJbOGx4Atknlhi+YQMlNUHTRr1mGhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC8PQQWcd8Waqk28UAGI+m6GliXD0KcrwOVmHJQdxoY=;
 b=b5vOrLZyb8xB89cwwMyENN1N+3wrKV3pzCjzRxdmz90A8TDK60WYrIKxYoxbixfVXvz5aCpn1fUTJ1kFl+etpIeAKZ7/JtR3uelfPaCCNlWwrbn6cz73zUqoN0pDYTjWssAbOlF2ZEnP7nSAk7Jr+E0tCzOgyrmGwyQNFLoIn7PSGHJGDIQDI6z7O2STlS4n2pP3ExTz1y0/VNkEjJbsMHxwCPnNDZ+LCrFBqw8TNJF5cVs43AgzcG29RgVd4WedEYvur28Wt7qt6tl+boHBTz4VoOXty3uAmYUcvpIZpJMP2+wqzxV0k5rMitCjfu9reKuCkE1cKPs+GurErDjqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB9825.namprd11.prod.outlook.com (2603:10b6:806:4d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 22:03:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 22:03:49 +0000
Message-ID: <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
Date: Mon, 20 Apr 2026 15:03:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Babu Moger <babu.moger@amd.com>, "Moger, Babu" <bmoger@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pmladek@suse.com"
	<pmladek@suse.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "elver@google.com" <elver@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "lirongqing@baidu.com"
	<lirongqing@baidu.com>, "safinaskar@gmail.com" <safinaskar@gmail.com>,
	"fvdl@google.com" <fvdl@google.com>, "seanjc@google.com" <seanjc@google.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"chang.seok.bae@intel.com" <chang.seok.bae@intel.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"eranian@google.com" <eranian@google.com>, "peternewman@google.com"
	<peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
 <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
 <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
 <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
 <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
 <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
 <72297351-2954-4318-81b6-7de409e5552c@intel.com>
 <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 5077c7c0-fdb2-467a-6bd5-08de9f28b346
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ditCZbHXu8wO3tXn5oU+EqwhMY3e1H/cQ+eYsm/F9tN4dY1IbSKcV3HUpC1QRYhsjyKoT58meUV3YhAKdPlWvowiW0EMyroq/6jwK1selzdlm6wJ2tbkeb9/qD7DMQ4yThTHp4+yYw7BJR+VAbmIl5UmBBPLGk8vZm05Y9vZiPNmMRUi/RGjULgaHKdrbp9pbYoBijE6IFbhtW1OXf8JRDlZm/bbYO0perHw2e7PqRiAp3bU0HPEz6i6wxPn+zcCF6s/NIQd35xx4GagYO3kPrdyjHksb/Re6mdxKkj0OCrFc1eA6wb+zhaerVLvFJb/hwY9+PJHJ5UHYFf6Nq7svTzJVJ4kvcerFzYd/xvSjcC3/Cf+df9aKMCIB5XCY/KUsPaMk9sVqBgEZ10yEeVya16WEZyq34IUKgdDZNtZOUFCJdjbA9Fguo3FrsH5f/kaIPvb9vEDX+w+wUoEHOVuRyA0FKE35AAGOFtGczA5NOedRZuspvTElfjX/lnqknEQQyOo5v2sbZ9Xf1ukOGbkeu53UsVRrwdfO2641S+f/INCV64IQgAOPrZHq5pIdnN2+y0jsanB/4yqkZZjH++v0dVr+Ds/YrpPzAVnb2OPbW7bfP0VVOEGzvxDeaAtEf2ISIidQZ1XqDMNmaflqCMw1Uq1iRpztgiagQ2j7E0KcBMnWUj1MrUIp1oxrnOGTgUUQAnYj5LuQ9eeMlEDRd1s9/818qhwn4nogxlGWz2FJvzEtao6d8ltVcsvPIG7/8APwlOuSjxUHwR+xGE/2MiHfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVVENnBQUGlxTXdqTzRlbE5SRVBZdGtZbnc3V1VDU2dBa1JZbHJtN3gzYi9k?=
 =?utf-8?B?RlNPVHZEVGt5U1YraitFMXpidnNkbCtjcW1BcFJHRnhpLytlMTdQTTEwV0Fp?=
 =?utf-8?B?cTB5Z3lLcHEyQ2R4ci9SeGZGSEJiSzYxNnYyZ0hHL3lMRVowVThmL1BJZ3Va?=
 =?utf-8?B?SndwQ1dTZGxpZ3NzU0RUOE44L2xncjBtTktFVXlSd3c0cS9pZlRpM3ZYVG54?=
 =?utf-8?B?Um1XOG01Tm11ZWFSbW5BSXhQeE5YZUlySVh3ejFVV0p1SDY4L2NzUURhb3Ji?=
 =?utf-8?B?UlRxMTl5YnppeXBaYjRPQXA3b2xsRDE0UlNMcmpEcVBVODBoOU0rd3RidUFm?=
 =?utf-8?B?bmdwMVdHNGhYclIrM0I0YWFHWkU1aE5jYWZDRDhVMEdSVTNZRXlKZ2NQOFQv?=
 =?utf-8?B?eUE4QWZkV0JrOU5rZnovcEFEK2JJS1MrdE5XdW5KZko5cHdlVUVqanJuNUtF?=
 =?utf-8?B?eHlUc3lZOFNiemtnNHRoVVpUV3BXMjdyRHdIMGFOVHZ2NEV4N2JXV3ZCZmFk?=
 =?utf-8?B?K01zNWg1bzU2ek40eS9IbGtyNC9IRTg3UDdNUGtLcDdjN0dneXA4QzZMVVVo?=
 =?utf-8?B?SHBMRCtFb1p6TXQvZldkc0x4UzVpSU4rTW5XcGUvcmNCaDM3MXYwa1NKVzNB?=
 =?utf-8?B?U0trd25sV3B6bjlhWlYrVG9SSVlpZzJVYlZETHd1cjBLbzljZ3BsVTNEY1RV?=
 =?utf-8?B?cFhWem95TnBjUk5LS0pROFhOTGlrVXFkZ2V4NXdpYkk2Wnd1bEM2Y3dFb2ZK?=
 =?utf-8?B?NDl3OHZDdWMrL25BaXRwUnJTSzhPWVJwTFFwRTVrK2JWTUU0S1BPY3JjNXhp?=
 =?utf-8?B?SXUyYS9yMStTMFhQaU1obzBLeXhhcjhQMXZPUHRRWlF4MTRNZjk3WlNWbXVq?=
 =?utf-8?B?U3llcGtReTdzemZSQTQ2VllyenRqbWJtVHBHcm9LbFEva0Q4ZG4zdWt1M2tj?=
 =?utf-8?B?dlcvNUJYdUtKQ0RVN3pUbUJ3NjU0SmVrZnpHeEdhQStFclcxeEhUT2RsNFZH?=
 =?utf-8?B?WFl2THp6bitwRHBwbzFrc1UzRGFKU0hWV1V2Z1VCU29NSzB3TlNyK1JqQ1gw?=
 =?utf-8?B?RlREQWJwSVBFUldaZkEyOEVCN2kvUHdhTWFtcDE3b2VsYnhJYmtrbG1UNjJk?=
 =?utf-8?B?QnJYRjJiNlNVTGpKakJ2aXdjWGtBNDhsS3pCZ2tTQ3dUT0ozVWthUTZVeWg3?=
 =?utf-8?B?WlRUUnBSWkFkc2Q2MSt1Z0M4NEFDTmpSZXdnWXp5bWNWRnRsNHJMOXFXeUlG?=
 =?utf-8?B?ZnRTcGR3cHBCeVNYNlpMSTVzWjFFRnRpVDMzQlJoOFVIdFY1V0hTYkNNTW94?=
 =?utf-8?B?SGkvZW1zcHlSb0dUUmFzZEVjeFdyTUFhSjl1eHUyMmNFYmFlMnVxclVLODQw?=
 =?utf-8?B?NVMybHJqK3hNcXFPVmNmM3FOOFRXbjJtK2NSajd4V0pxZkZEUG40RUZIaUNq?=
 =?utf-8?B?cnRiNlBVYkMya3d1VDUya3J6czZuenJRSDYvN2JUZXNaNmh5cG40c2lBNWpG?=
 =?utf-8?B?RjBkODVsVGJVYzAzaWVyQUxuWVJBaXplWVJqTzZKQXkwUlV1cElML2ZFczJS?=
 =?utf-8?B?Ymd4eSt6Wmk2ZUZXeTF4UFQ2M2lKeVBPblVwcVNsUDd0dml1YlkwV2dLaXJ3?=
 =?utf-8?B?TFZMTU9qYm9ONzVNN2c5TEZXQndCVit2NW1heXZGS0Q5bzh0MjZNdUxJRjA2?=
 =?utf-8?B?OG9wU1ppS1gwMjRmUnFlSjJSaU1udEZlQ2pnWGV2ME1RcFFvbW1XaTVhWUZ4?=
 =?utf-8?B?aTVneVZvY2p4ZmpHZGZPeGdoL2ZlbGNCRnhoS2xjb3o5YlhmbDlVMnFHcG4x?=
 =?utf-8?B?T3pxMzhTckJDQ1M3OUlnK05Qa3J6NWx1a2U2TytvL1VFL3dLOGJHR2JuZTNq?=
 =?utf-8?B?WmNwTzdkUm41ci9na3hoalZXcFpHK3ZJVzdaNEF5Y2N5Z0hKSmQ4V0EvZHNz?=
 =?utf-8?B?NlV3UVZkdkEwYmFQWjViWlpXNjl4QStuM1didkZneEMxNWE0UEh2bFZkNndB?=
 =?utf-8?B?NjZBVkEraitidGJ1dWFhSnhlWFF1OUdjWFRQWmJLUG8vMjN3NHVHU0g0TGZx?=
 =?utf-8?B?ZitSYzFuUE9PbEQrYy9VTVBkUGN2R1M3bmxOUXhrOXozeDdJaUZXYVBLY1RQ?=
 =?utf-8?B?R1RkVExzbG1aeGMzdDNCTGZhVm1ZT1JNOHpFenFYY0hmRWhhN1ZZa1hSUXB2?=
 =?utf-8?B?T3pVVDhQeUtQVVBVVFJyRzVlNjMxZ0hsTHhPcSs2TmdnZFY0SXgrVzFOQ2dz?=
 =?utf-8?B?K2ZDVE5oTXNUWjFqL0syVUY3WElPVzVId3hUYjJvczBSVkxwcHBBQ1BDV1Na?=
 =?utf-8?B?WTIrQzRSUkUzMFpTWGVrREluUHdaamwyb2JGWDJFcnVBb2NkMFFTTTlKL1pq?=
 =?utf-8?Q?JFJerrFYDoBzehl8=3D?=
X-Exchange-RoutingPolicyChecked: wlxyJ+bJ8EGMHr33OT1bz2BpE6iFAfwEJTE69ccaKMd9dgFVo0F8zwoTW/FaOdlEgkucfacOybjzuRQnj8n42t9EALDsLLdQpdkuaN4i7QDa7bmZwCHY6SFgcPSJbSCFSqVfGBQDjS5jhz1mI5lMK2YjiODjBCTkH0qAK4dwaEqLZ6m1hcOH+hg+kKd8S07aKR4uKssCcFJ3iAWYb+Llys4D1dmWkdivrCpD7mpnsCPD3I6iMUX5jK7gfC4XSF8qGKmvdbSbdA2eF9NNk61H3pN7Q4d183a6isec+bERsQX4qtm3VldB7TAWoSGBTIRhwWP0rNvomms8D05Rvumyyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5077c7c0-fdb2-467a-6bd5-08de9f28b346
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 22:03:48.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIoAhGMTBOHlsrytK/hp0TToXoY0zayD76/LIbL8N7CWIOAvWt0KJjBx6J8I+TbYpiWs3+09cCG6ZkEUs3Rr7tTfd6EJ58o97g0UGs2hwkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9825
X-OriginatorOrg: intel.com

Hi Babu,

On 4/20/26 12:38 PM, Babu Moger wrote:
> On 4/9/26 22:41, Reinette Chatre wrote:
>> On 4/9/26 4:42 PM, Moger, Babu wrote:
>>> On 4/9/2026 3:50 PM, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 4/9/26 11:05 AM, Moger, Babu wrote:
>>>>> On 4/9/2026 12:26 PM, Reinette Chatre wrote:
>>>>>> On 4/9/26 10:19 AM, Moger, Babu wrote:
>>>>>>> On 4/8/2026 6:41 PM, Reinette Chatre wrote:
>>>>>>
>>>>>>>> When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
>>>>>>>> 'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
>>>>>>>> (or made visible to user space) and is expected to point to default group.
>>>>>>>> User can change the group using "info/kernel_mode_assignment" at this point.
>>>>>>>>
>>>>>>>> If the current scenario is below ...
>>>>>>>>        # cat info/kernel_mode
>>>>>>>>        [global_assign_ctrl_inherit_mon_per_cpu]
>>>>>>>>        inherit_ctrl_and_mon
>>>>>>>>        global_assign_ctrl_assign_mon_per_cpu
>>>>>>>>
>>>>>>>> ... then "info/kernel_mode_assignment" will exist but what it should contain if
>>>>>>>> user switches mode at this point may be up for discussion.
>>>>>>>>
>>>>>>>> option 1)
>>>>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>>>>> the resource group in "info/kernel_mode_assignment" is reset to the
>>>>>>>> default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
>>>>>>>> and kernel_mode_cpuslist files become visible in default resource group
>>>>>>>> and they contain "all online CPUs".
>>>>>>>>
>>>>>>>> option 2)
>>>>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>>>>> the resource group in "info/kernel_mode_assignment" is kept and all
>>>>>>>> CPUs PLZA state set to match it while also keeping the current
>>>>>>>> values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
>>>>>>>> files.
>>>>>>>>
>>>>>>>> I am leaning towards "option 1" to keep it consistent with a switch from
>>>>>>>> "inherit_ctrl_and_mon" and being deterministic about how a mode is started with
>>>>>>>
>>>>>>> Yes. The "option 1" seems appropriate.
>>>>>>>
>>>>>>>> a clean slate. What are your thoughts? What would be use case where a user would
>>>>>>>> want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
>>>>>>>> "global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?
>>>>>>>
>>>>>>>
>>>>>>> This is a bit tricky.
>>>>>>>
>>>>>>> Currently, our requirement is to have a CTRL_MON group for
>>>>>>> global_assign_ctrl_inherit_mon_per_cpu. In this scenario, we use the
>>>>>>> group’s CLOSID for PLZA configuration, and RMID is not used (rmid_en
>>>>>>> = 0) when setting up PLZA.
>>>>>>>
>>>>>>> Our requirement is also to have a CTRL_MON/MON group for
>>>>>>> global_assign_ctrl_assign_mon_per_cpu. In this case as well, the
>>>>>>> group’s CLOSID and RMID (rmid_en = 1)  both are used configure PLZA.
>>>>>>
>>>>>> ah, right. Good catch.
>>>>>>
>>>>>>>
>>>>>>> Actually, we should not allow these changes from
>>>>>>> global_assign_ctrl_inherit_mon_per_cpu  to
>>>>>>> global_assign_ctrl_assign_mon_per_cpu or visa versa.
>>>>>>
>>>>>> resctrl could allow it but as part of the switch it resets the "kernel mode group" to
>>>>>> be the default group every time? This would be the "option 1" above.
>>>>>
>>>>> Other options.
>>>>>
>>>>> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
>>>>>
>>>>> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
>>>>> to CTRL_MON/MON -> CTRL_MON.
>>>>>
>>>>
>>>> ok. Could you please return the courtesy of providing feedback on the
>>>> suggestion you are responding to and also include the motivation why your
>>>> suggestion is the better option?
>>>
>>> Yea. Sure.
>>>
>>> We need to allow the switch between the modes. Otherwise only way to reset is to remount the resctrl filesystem. That is not a good option.
>>>
>>> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
>>>
>>> This option is same as you suggested.
>>>
>>> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
>>> to CTRL_MON/MON -> CTRL_MON. This option basically disables monitor (rmid_en=0). It is less disruptive. Move is between child group to parent group.
>>
>> ok. I am concerned that this creates an inconsistent interface. Specifically, sometimes
>> when switching the mode the kernel group will reset and sometimes it won't. This inconsistency
>> may be more apparent when writing the user documentation as part of this work. If you are
>> able to clearly explain how this resctrl fs interface behaves (this cannot be about PLZA
>> internals as above) then this could work.
> Started working on these changes. May be it is better to discuss this before to avoid one more revision.
> 
> 
> The current mode change behavior is very restrictive.
> 
> For example:
> 
> # cat info/kernel_mode
>       inherit_ctrl_and_mon
>       [global_assign_ctrl_assign_mon_per_cpu]
>        global_assign_ctrl_inherit_mon_per_cpu
> 
> 
> # cat info/kernel_mode_assignment
>      ctrl1/mon1/
> 
> In this state, we cannot change kernel_mode to inherit_ctrl_and_mon. The expectation, however, is that inherit_ctrl_and_mon should always map to the RDTCTRL_GROUP.

Could you please provide details behind the "we cannot change kernel_mode to
inherit_ctrl_and_mon" statement? Why is this not possible?

I do not see "inherit_ctrl_and_mon" to map to *any* group though. Expectation is
that when user changes mode to "inherit_ctrl_and_mon" then 
info/kernel_mode_assignment would become invisible to user space.

> 
> 
> A similar issue exists when switching between
> global_assign_ctrl_inherit_mon_per_cpu and
> global_assign_ctrl_assign_mon_per_cpu (in either direction).

What similar issue? Could you please provide some detail to help me understand what the
issue is? Isn't this what we just discussed in thread you are replying to? That is, you were
looking at developing that interface that I viewed as "inconsistent"?

> 
> The same problem also occurs when modifying the kernel_mode_assignment group. If the current group is an RDTMON_GROUP, we can't assign another
> RDTCTRL_GROUP without changing both mode and group together.

Same problem? Still unclear what the problem is. So far three problems are mentioned but I am
not able to decipher what the problems are. Could you please elaborate?
When modifying the kernel_mode_assignment group I expect that the interface
will only accept a MON group when in "assign_mon" mode and a CTRL group when
in "inherit_mon" mode. 
I do not understand what you mean with *another* RDTCTRL_GROUP. Only one group
can be assigned at any time, no?

Reinette
