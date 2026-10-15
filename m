Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0739795B;
	Thu, 15 Oct 2026 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074160; cv=fail; b=RPnD55EkuQbsWtA2tZ/PvURHhORpdeQDtAvXjsxm7UZyIK/yUgsXycjvjgArDnxdbO6UU563knCgPerqkywS/A+IBaOKFjfyUhFlECmG7Z0Xqe7OdJOgS17sIJCNtKkNxdV7obai5qAaYodTxx6LTyKt69IFVbSxoQAQVH7yNIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074160; c=relaxed/simple;
	bh=9yD2KHbC4QjlX1FTJiKdUefpWyQSVte/xxSXhwJr85k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=amAqmat59DUpOxK9cUjigUKdOggPR4g5W4d2I4IKyy/WOCTX8PqSZUMybn2DQYLWak8lFXHUaQ2EGErK/l8d7hZT82ngRpuYuTzX9FLjZgdyXio216XRVBQZF39e7PQY2NJ0THn3Fi2QPhGW+QS4WTX1sRlQNd47kFS4x3Rzyqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0JzicRG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0JzicRG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792074159; x=1823610159;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9yD2KHbC4QjlX1FTJiKdUefpWyQSVte/xxSXhwJr85k=;
  b=e0JzicRGMRfmFVElcrgmm0o9d3FoGo8PdFbH3rtw+hsrrLdlJtorSnT8
   yeG7wZ+8pNIQT8itQ6knNRo3R3BRv5v0fUgednfZTBs1Uj/GYVSPkPSIA
   V7QUAwaV0/nZhQjvAdpUeKX92GrL+6FwlXip9VOj3jpEzTyZDjaAZVGUf
   YkSHsFWUoSfFx+2uKsMFIHJLuvAXC/Zjj8Vc4hOHYkkf0OHg1U7qyXGCq
   hiEOkRdL3gQQZMRe6OgjE2b3UqNdhERXoddwZhj0aEX6ksFmLJR6eXOo0
   iW7inocVwwm+M1TXAE9PO+MwaiOjl5BfC5F1kDFDGolL+9CEEb1QSt6Pt
   Q==;
X-CSE-ConnectionGUID: jTs5PCdMQS20g0CQCjmnOQ==
X-CSE-MsgGUID: GE48X1iJQ8CCydqqcaphww==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="731469"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="731469"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:22:39 -0700
X-CSE-ConnectionGUID: jGrsrfRLRp+6O1OC+iW5eA==
X-CSE-MsgGUID: H4ogncrwQU6MBuiVqXn9hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1725162"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:22:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:22:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:22:36 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruruAN6d3CcwYMLiw42J8yFrCULPfw7pf+x+WDbd0DX6QYYh0tYzuA8HUJ76+333RhmJNecRuaLJ4V+bz6Twyo6Jhi+MZCu02qihYqU0mxDj9PYyWA8MX1R7n+XtQY6dwNHkQFBYxcm3rkZKUzT9irB85kHNlToIklDmfyucHbBIbevNm12YCEU264M4JRPncjJOfMbBq8QmE8T5Ih7GMivIWUsydDHKPjGWKXa1b9jSWeSNybNNX/B7ph6bLLWvZLtfVzgwlC8vx74ZHR04wk300rLqTsisJM2THiPy0g4/ukGjgFTHBpAvEb758Dj6GswdNvbgu8NSXk90Ftwupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGzCne3Z8B+kB172Ww+PAKjpG9zA4kZNGWhhvJquUF8=;
 b=g++oygyO8wkknIBowcDkL+HGV7eK02CY6PSYOpolPKeBtna4gRoAcSoMvgMjz6m1HbfHK/HsSj/oA+pUPHZLADS5ZO3lkr7oZkTrxTltyoI4GE6a2g8DRAeHzPm7mUyrupiItOWgq1/W461R7hjMwek4VbiOph/sfDVdGNZcIa9v1m7p7Mp5kSsNvVdTpJ0Ee0zCPzRqb0CfS1ZkPRNEjc2CGoltckcvXSSWuXs4xliPkw0ebYNiqk0+fX6Xo67sSPjQ6rLmmneZbewV7OQ5NAs8Z6w+z2rAy+1nH0MFaOM6fq2x9wi/0fOJ49p30bxD4L7JN5dO7PyMf1PqHzZtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by MW4PR11MB7055.namprd11.prod.outlook.com (2603:10b6:303:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:22:33 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:22:33 +0000
Message-ID: <bf4bd727-eac2-48ba-ad85-539a818524d6@intel.com>
Date: Thu, 15 Oct 2026 07:22:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/18] x86/resctrl: Add PLZA configuration definitions
 and data structures
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
 <608876cedf5eece3f8b9297bcf21663a86a6380d.1790867441.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <608876cedf5eece3f8b9297bcf21663a86a6380d.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:303:2b::17) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|MW4PR11MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a768f4e-5848-4909-3fdf-08df2ac7c0eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|11063799006|261009223027099003|4143699003|22082099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: u/r+TlAiMzE//CYoxkDOzypkuxHONrqI3chwdkBi/N2yY8BmH7KpXk4W5m5TlYVW2lqG73spvRypgNMjm5c9uCYXFbmg/SpOBozbfUBuYbXVw0zVLJvcLiveQXfeKB+4Y++dInObbURJGzYl3CwtTmsWC6kK/Jw2zgWF41czznGZwirtbZqBj0z2TQ8tn4hiYWikuI4c8CSCb4h40yxRDrKLBEbrYB59v6xaLOyVb6Si5Ln0JNefS/4NrurgsYe5Cg1wcynLXl2RhelaPt8Pm9n2AKWkF3KEJ59b+ocDCZE/DtHI+z5yw01mrhqPgSW1U1HCFh9NfGUyyxkovlRikhXN4IhJHFJLWwXuhwTDVWr5jZPsWN2EDzqIZpZgRYbpwlSBaL5uC5WUj49GJiOvotxdcLmxi/lJIcPu7tBJVNKYO79hK5gPAWECHB1JORx/V13uUXbmiwBiE9iRNgCEdMtVU+95HzsPpUL9itoZeBbRQajL1C8LLh0ZMoqx/dqBueXUs4IrE+9a6oYwPZlw67jUnK3PuvhNF++YG+KsiFCWMPtC1+/8sgmCG9swgpJ7FoloZUfO/8g4aIByEuvy8X9pqqUGM04SNK1JOmlKGXe1WEU93INNrQlvc1vINU1B9eI5KXBHCNYx1TZYMW8yluMHboTjnIEkwpDgC4hl680=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(4143699003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xTWEhSMGVacG9velRQNjJhRm8zbHlTaTcwam5TUG9vclpMWDJpMG5LV3Zp?=
 =?utf-8?B?c2NDTWUwQmRPbG5hS0MrMk4zZnBQUFVTQy92cjFycEdyZXBoazlEM29iU3NZ?=
 =?utf-8?B?djViSkJZc21TRENIQVYyb1UxeGk2TjhxOGFiV2FRTHhGSlBvRDhIK2YwZ0Z5?=
 =?utf-8?B?Nnd5MWt2aEdSVnNhZ05jbEx4NTZycURkY0FlRG02S3QyWVM0dHBONlRGMmE0?=
 =?utf-8?B?d2d2cW9IY2ppT0hDRVkvRGk3UFNGbkhCYllZT0UrTU1wRkxDNktVQXV3Sjhx?=
 =?utf-8?B?SG0yajJQM2x4YzJyZXFDRjB5YnVUMHRjQTFRYjJpK0NVMDlTRFdpd2lEU0d3?=
 =?utf-8?B?SjJOSGc2cXU4UlFGN28vbjE4eVY5c2xETzc3b2V6dTJOV29PWXQ0SDFpZ2hD?=
 =?utf-8?B?UzBWQzBBNlF1MGd2cjBaRmlEWjlBcUlBV1R2dVZud0dhTm1hYzROSUFJTFlh?=
 =?utf-8?B?N1pEY05aS0IvVkc4QmZzWmZtSVVPZ21jalIweG1mVHBncTdXMmZEekhvQ2VF?=
 =?utf-8?B?U1YvTlBXeHF2TGhUY2RreVlmVmpsOVBJVUNpUEhwcG5SV09IYlZ5OGtiSnpR?=
 =?utf-8?B?ZTAwR2VFaHNwazVtTTYwcW1DcTVzS2xpUCs5dUhlbGJIbU1hYjdhcGhoRkZT?=
 =?utf-8?B?MjUxNjJBU0lHcFVHWFhaL1dWZHhXaVptN0JPeEJFTEJXWEFYS0NNUVVnN0k2?=
 =?utf-8?B?aXpBMjAxbXZFWW1UZTZzNHlhMGpSNUluV1E2clpqQTFTU01hc2pCQnV2cURG?=
 =?utf-8?B?THMzc0lrV3lnSlFpd1R2RmdBK21EKzRiU3JBZlpDTlQzVWIwbzNGaU9YYWsx?=
 =?utf-8?B?a3dTUkJBUEs3TkFLSlFEcE1WNk5YZTdrSm1jcUpvSVRQUHRSR0p2RFpENEVP?=
 =?utf-8?B?eFoyVDRqTThTbW5iK3R6TVJISkF6cU9obXkxdlRpTE1WdThmY1RNMzlZWTdt?=
 =?utf-8?B?RzdReFVxZTNHWUFVeXNRL093RFJpY1FNZHIwa3YyVjBxNnFjM3VGZHhWd2pi?=
 =?utf-8?B?bitJeEU4ME5mN1gzMEhqZ2xLeU4zcTAwSnFsaXI1RHNsQm1mQzBGUGlrV284?=
 =?utf-8?B?dEx5VzFMUHpleUtqREFnQkcrQ3dwemtVVmtLTEMrTDV5TkpLclN4RUR3YXZR?=
 =?utf-8?B?ckkxVWdoQ0YvT2RYeFJoVVcrTDZxbFc1UFNyL0J1QkdiZWMzUXRRUWwzenVO?=
 =?utf-8?B?Sjd6STlNUWh2RldLNVVSSWZTdWpiUE5EazRMcTRiSFpDKy9wTVpUL0ozT1Zs?=
 =?utf-8?B?RURlbGc3b0sxVHp2WmZUcGthQkk0VTJXR3EvcjUvWTM1UVVrMHh2MHAwdi9C?=
 =?utf-8?B?dHZxNEdYMnM1K2wwczNzYzNuaXpBUW5qK3FNbjhIenRmV2RocnpPRFJoQXpB?=
 =?utf-8?B?RGFqRkttbUVzN0JOb3kzaUoxMGpJUTdEZFhFdmZtbU92T2hvNTBaOEYrdXZO?=
 =?utf-8?B?OXV1dTBKay9EV0JwN1NOL2xtRVNGQzFxT0ovK2ZUdVpQL0FtUzl4MVhESFNN?=
 =?utf-8?B?ZW5KN045YXZvTTNlS1NaSWNqT01oSi9HUnFEdExaQ0N0ZVRmdmt5VGRmQkpX?=
 =?utf-8?B?aFg4eTVPaUlhbGlTeDhqMURITGVqU1pMZmE1VXZJUFBBSGtJallBUDArd3oy?=
 =?utf-8?B?MncxRGJqb29sVFJZK0tEQUR5WWNweUFOTnNVNWxEc1ZJK3VFSGJEZGlaNlNQ?=
 =?utf-8?B?VHY3K0pBK0tNSytmeFFuTVlHd1pKQzlEMTFFUEJabnBaelVKaytGNVVKbGMz?=
 =?utf-8?B?WlN3ZjZpaTc2aVNYSi9VUW5QUVhPM3RNWUE2VWo3TDVVbG9wcFhnZ3l6L3BU?=
 =?utf-8?B?SFBXSjJtejZ0UkJVWS92eC9kdXFlTDA1amVSZCswRGJ2bmM0Zy84a0RZZ1Ns?=
 =?utf-8?B?STlrMmFadWxvSTczWG1wNmpzUGJDblJEcDByakVLUGFsUmNvTjBqSEVrV1V6?=
 =?utf-8?B?UlZqcmRsVlNYMkZnSHpxQlYxTDJ3c1Z6REx1cXZOcU9iS0NDZ1ZiaUJ1aHZj?=
 =?utf-8?B?ZTRUQTlydlVXQThUMlpOcjRvRUZ1U3BXeXY2aFpsRnJlbDM4TUgwSlV3NUhl?=
 =?utf-8?B?NWZVTU9oYkVXUDkvT3dyaTJ2c1ozTnZ4SWREMlNILzRQR3M1bnRHMzF4R24v?=
 =?utf-8?B?R0J6UkFzaTNCc2pka3dPNW5BTVZJME1CYlRmVDg1WkRTNXlQZldmRTNXbWhR?=
 =?utf-8?B?eVRBNUVRQnE5NTFwNTk2L3VRVkRWVWRmTjdWR21rWmkwRGsxcE10ZmYyZHJw?=
 =?utf-8?B?b0QzZnkvdUZHNnoybHpkM2ozWWxCTnA1ajQyY0ZURTQ2dnMrVW5EVWRSSG5V?=
 =?utf-8?B?ak5BUGJlUTEybFJoT1VMdXV0bDB4cGd2bFJ0VXJKU0NSSklVWS9VTmdneUFa?=
 =?utf-8?Q?FckXqRgmo71R8ozw=3D?=
X-Exchange-RoutingPolicyChecked: oo3DH9LaCo5FcL6L3pnGwcyQe3FYzPalLa5ZnOBKkPAxBLP5WPnwnX9PdHgv6eZHIrU8XG7ySNGXnZYKK1PsV/MzxgZub07q2YPBbiSi3gJkYOL58LCiBqyYWTbfMqsWObSlEA/1eJqUnnqhRRAgwy8afBjMY0hJyY21xj4K5tozXM2WYa11idSGPlf5t5eq5AlkricknFBtxv8Kv4QEphsfqE6l1TETsIo21R0Z14wT9asPJN8xcAY4JOxRyDF56gBFHA9EVEkjAcRw1YnhUc06FvsXiqb9vLxxGOzvDFU3NnRaXfJDtbKvUhP2QJWYBSDfIRwDRqWZWx3GApNKEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a768f4e-5848-4909-3fdf-08df2ac7c0eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:22:33.4827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciCbyJjlrHA8HJ7Ptw5uBB7veZ/IBStge09hZxnGb9mHNnaORqZ1QG3IwBzF0SC832i72yQoCGnMfm+rGzVUkJMP9J33fkOXHoA6Sl+rizQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7055
X-OriginatorOrg: intel.com

Hi Babu,

nit: subject claims multiple "definitions" while only adding one #define.

On 10/1/26 8:10 AM, Babu Moger wrote:
> Privilege Level Zero Association (PLZA) enables the kernel to switch to
> a different CLOSID and/or RMID than those used in user mode when entering
> kernel mode. CLOSID and RMID selection are independent and can be
> configured separately.

That CLOSID and RMID are independent on x86 is clear to me. That they can be
configured separately is not clear to me in this context. What does this
"separate configuration" refer to? Looking at the later patches kernel
mode allocation and monitoring associations are always configured together
and written to same MSR at the same time?

> 
> PLZA associations are programmed on a per-CPU basis through
> MSR_IA32_PQR_PLZA_ASSOC (0xc00003fc), which contains the kernel RMID and
> CLOSID values along with their corresponding enable bits.
> 
> Make the register and its field layout available so kernel mode allocation
> and monitoring associations can be configured independently.

Could you please also elaborate what "configured independently" refers to?
At this point it specifically refers to kernel mode and from what I understand
kernel mode of allocation and monitoring are configured together.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  arch/x86/include/asm/msr-index.h       |  1 +
>  arch/x86/kernel/cpu/resctrl/internal.h | 49 ++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 82ca6356dc62..1331291f7a36 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1304,6 +1304,7 @@
>  /* - AMD: */
>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
> +#define MSR_IA32_PQR_PLZA_ASSOC		0xc00003fc
>  #define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
>  #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
>  #define MSR_IA32_EVT_CFG_BASE		0xc0000400
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index e3cfa0c10e92..44ecde20b1b4 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -222,6 +222,55 @@ union l3_qos_abmc_cfg {
>  	unsigned long full;
>  };
>  
> +/*
> + * Privilege Level Zero Association (PLZA) is configured via
> + * MSR_IA32_PQR_PLZA_ASSOC.
> + *
> + * @rmid		: RMID programmed for PLZA.
> + * @reserved1		: Reserved.
> + * @rmid_en		: Enable RMID for PLZA.
> + * @closid		: CLOSID programmed for PLZA.
> + * @reserved2		: Reserved.
> + * @closid_en		: Enable CLOSID for PLZA.
> + * @reserved3		: Reserved.
> + * @plza_en		: Enable PLZA. When enabled, PLZA applies to the
> + *			  given CPU.
> + *
> + * The MSR_IA32_PQR_PLZA_ASSOC must be programmed on every CPU in a QoS
> + * domain. Each domain supports a single PLZA CLOSID and/or RMID
> + * association, and all fields except @plza_en must be programmed
> + * identically across the domain to ensure consistent behavior.
> + *
> + * CLOSID and RMID selections are controlled independently. When PLZA is
> + * enabled (@plza_en = 1), CPL0 uses CLOSID and RMID values from
> + * MSR_IA32_PQR_PLZA_ASSOC depending on the corresponding enable bits. When
> + * PLZA is disabled (@plza_en = 0), the CLOSID and RMID are always taken
> + * from MSR_IA32_PQR_ASSOC regardless of privilege level.
> + *
> + * - @rmid_en = 1: use the RMID from MSR_IA32_PQR_PLZA_ASSOC if @plza_en = 1.
> + * - @rmid_en = 0: use the RMID from MSR_IA32_PQR_ASSOC.
> + * - @closid_en = 1: use the CLOSID from MSR_IA32_PQR_PLZA_ASSOC if @plza_en = 1.
> + * - @closid_en = 0: use the CLOSID from MSR_IA32_PQR_ASSOC.
> + *
> + * This allows PLZA to override only RMID, only CLOSID, or both. If both
> + * rmid_en and closid_en are clear, the effective behavior is the same as

nit: rmid_en -> @rmid_en, closid_en -> @closid_en

> + * when PLZA is disabled, with RMID and CLOSID used from MSR_IA32_PQR_ASSOC
> + * irrespective of privilege level.
> + */
> +union msr_pqr_plza_assoc {
> +	struct {
> +		u64	rmid		:12,
> +			reserved1	:19,
> +			rmid_en		: 1,
> +			closid		: 4,
> +			reserved2	:11,
> +			closid_en	: 1,
> +			reserved3	:15,
> +			plza_en		: 1;
> +	} split;
> +	u64	full;
> +};
> +
>  void rdt_ctrl_update(void *arg);
>  
>  int rdt_get_l3_mon_config(struct rdt_resource *r);

Reinette

