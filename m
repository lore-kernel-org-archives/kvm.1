Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C08D2DFF04;
	Tue, 21 Apr 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788046; cv=fail; b=CQaICkH7KJj8NZLvzzjx67tbleWMkd48SGvyQINBO9ockut5Sit+tdIwAvRsWviU3ujeiAOC7eRiqyUUNRIABWKVfUzm+ptD5PQuY6dcFgd45f5FF1YeCV3e4bV44nD63ulBcResX7ahm+biHWJlzLSw5LeU9FNPmuMnmYy4c8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788046; c=relaxed/simple;
	bh=BlM+gge2D/cUg9DmDUKalDa/q+oMtbAAx5Ty+HHDaxk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WUZvbMroPTppqK8eOm/bul5Qv4i/7hgZps/6zKLmT3XyIkdNDrsXQKYgAn9CGiAQ3ZP9qo5V0SVnG7MHm67W7wOxOlvF4cUmpSDDKO3WY9XRmTTW1FeYN6wxzvBObvqGoNJUE6sobU1u4TubqxZuedN3hzjmBNbgDXDBDHDRQ4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=af76JHxQ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="af76JHxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776788044; x=1808324044;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BlM+gge2D/cUg9DmDUKalDa/q+oMtbAAx5Ty+HHDaxk=;
  b=af76JHxQ+MBY8i7lf7peOPyezbHslygD2N6Rl8SmuICe7Grtw5MxgmLj
   lDCBS8fjG3koK+7C+Fa2AG+7aXcLgJmRSCGsnIt/LiLJIqvZ7LIIYw9Jz
   J2izEUh3lf2/igZN3pb7rl9X6pzB2CWrA5XR22JJM9j47v0M0cJbG3+/L
   pS+FOausxHOALmBSEl397VbErSRjo+hOKMJcfaDTxKpDFFm2XuaeP0cFD
   NQWrLxUIrWJMnTH6r3GgQ1y/Ez9MZFPE7HYr47EWjVKtkPlXp6O6VT66j
   fof1iiAT6+hoptr48tDclg+7IL6isSr+cx9Cc8FRnrQDWqUE2Qn5WWKAn
   A==;
X-CSE-ConnectionGUID: C6rGx430RDmY2T+33b+WDA==
X-CSE-MsgGUID: V0sbbo0KQ+egTa1dhnOFCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="95286426"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="95286426"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 09:12:18 -0700
X-CSE-ConnectionGUID: srMFZgnGTMyxW8kBWU9LXg==
X-CSE-MsgGUID: 9dqOCz/RRZ62OdE6Qt7JJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="229398461"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 09:12:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 09:12:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 09:12:14 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 09:12:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSR0HevJy9b9nFYB/3uDuZnGLkD2pACX5K+eHEEuOxmiCqG45venBo4Txu+pWa+vvx3tVvjQPgNONqu8Do2ue0ozzTMKOKxRqvq6zdcMwfA5V7D0lvmko06FSK0RUIFDmarkoIcU1zu+dfvnuyQogWtHLVKB1S9WtH1swZKRr3OzlttBl1/BDwxvavr2LXg0S24BS4IknSKDc4YCMdME4xwyX8vn18AR3VH+ECc/4M+dq24bJovPYNjsWp6EaB8nahnmujb6Q4CRbPJnEopUQV5cyyRtjhXfpivjAacPIP95Ds6OI2y2tLkK4VQpuCEURTEHybiNTfyCgDBBcyWNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpiFPIb7Zh3mRvFR72gKsXBR9a2sNEPb+K6hoThGG0A=;
 b=MILx/dgE5zVjKnniSFRKblbtsKLVlZia9YaSa3kPXzOYGTbT4rRg4GgY8DYjT+++HO4QmDovHKHXPVIYFoW+g4Ii7dhPgiaaIy5Har1TMFaPPQbXVdWppjmyLkl3SG9uMXnw14nR0x/vlotWKKIXvge294AKdKKdNyzWUvfaIJ+ImAICgG2E1bK1AvsnTkM8QDfPqqETXtKxS8jnyzx6hA81H47HMc3MkyzQ4YCW0p8MU7j8tLy5B5DWHC26XvgQaD8VjHy++oUNxpZ9gABX7Hqxt3cy2Mqky619nR7U5f4cGFyFyUuk14iW0QYxUpxOfvvIdsI9mlI8jm/rLNfE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5263.namprd11.prod.outlook.com (2603:10b6:5:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 16:12:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 16:12:11 +0000
Message-ID: <4fa916b5-1bd0-418e-8d6e-cd1f9a1c8c22@intel.com>
Date: Tue, 21 Apr 2026 09:12:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: "Luck, Tony" <tony.luck@intel.com>
CC: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "Dave.Martin@arm.com"
	<Dave.Martin@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
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
References: <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <aea-wdaZAWl2Al1h@agluck-desk3>
 <58b8fe0c-80f6-4ba2-abbe-90d0ceee6daa@intel.com>
 <aeeTnL3aisKgPJG-@agluck-desk3>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <aeeTnL3aisKgPJG-@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4aa088-e5e0-413b-63e7-08de9fc0be7b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: qdjKEYs7/W8gIQbZzeI3CV+wYf2pA/pTBK0jVN8LlMc/FK29AlyvlIFbddcawUtkX1NqZv5dK8q5b6dTWXjVxzOnPKeZBs6YGGt63X6snNIANVJUBe6r+eFKHZWl7DyRJLsgUL/PK68w5SqK0pPuk4JVULTx0IusRPpOcERAJs/QpfIuqDdz95/g4fnc1JWwXLjSW5x7f+m6lJ3vx0L2hpty48Loop+OlBhHU6h7XAXksi0WqUukpcHvJxU43JvAs0aftG6iiY2RnaicFSzNWCWuTJbsC5BL0mXq+Zu3hZHhAbJ4/Rltu6bYnC6tqiH7sGX4c/afA39+3xyF97NF9BfwXhxe6bL27dC+/NsHztEkEPa8/1Oj5+oOYkpzGAFigkVVHZK7jWGV7zRr6E9kANezkJZzTnJRamOygtVbAoG05NIfjSB7bTIgFAZJHJYYTXovsaam7TVVpkCgLEljSUXsh5WBOeFymhCb5kPq+DUMhAtFl5R1gKzqWYxT+IksfZ+2q3VwugkY4yTdOc3dXZAjFjEC5PLtan9hrRDZK4m3rPiUa3zpP/uKczVryFhDMU4MztG5HXSoUGWij8z/TEBQmwOHo8kBVjQ0SJhfTulJxOnMSYtQ7fkIajROzXaF7CxJZ+Ixl6GUlC+SYeFIIjGsPryFNxl25CQDlXjonlkOdr4dMx673C/z3be87WQYBJdm1LPasYLqg7T2QiQRTBh1+d4WtPH+rxUsCtrN27Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ZFWHBLVGZDTmpDOE9UUklnbVFoZHBwZlFoU2JSdGdJaHpjSVh4SlNMNGZD?=
 =?utf-8?B?Q3p4RjB0cVN1MXN4N1drOHZDbmwwNDNOREUvWjNOeHhGdDBzNjdIY2ppV0Rr?=
 =?utf-8?B?Rmg4N3UrR1lnR2RQSDZpaDJUanNkK05XQWY0ejFxaEpTdFVtT1VkM1l1eHdN?=
 =?utf-8?B?cDZMblFUT0xIK2Z4YVZYSTlWb3hLaENpVmlKZHErZVBieTFST250TlExeVNX?=
 =?utf-8?B?VkFVUU1US3Jub2oxMldXK2s0Y09VcjdwY2p4N09jZWpvQko0UmdHK20zVDU1?=
 =?utf-8?B?U1h0QjkzMjJSV3JMV1NadG9RWmVNcHVKNnVGb1FCMnhHcDMxQXJWc0xxMGRk?=
 =?utf-8?B?Y2lOUENOVGduR0drMklwVWYwRmxlK1pvbFJNU2lxUjhqTlUxaEE3TGpadTNq?=
 =?utf-8?B?dHN2bEZjZEdkYVRCS2g1UWFBS2pMRHRtSFpjY004b0tIOVdML1lTV0wyVUNC?=
 =?utf-8?B?KzdqY3l1M1N5bXM3Vk5OZitrRFFYOFB0czYyVUxzU0UwTVFZeDFYRzBVVFJN?=
 =?utf-8?B?Q3RDbUZ6STBWM0plc1JKRDgrTGwybHVoRmphT1hTU0pzd2k5cWkxL1hqTy9F?=
 =?utf-8?B?TjFKQVlPR2crNVRBdTlnRWxvdFU4eTF6YWVtWnkyVURaV3BZblNjNmJsbnVz?=
 =?utf-8?B?WlYvaUpjejRGU0xCZXFkZngydkVISTUwMzVQS1pwSElIVjZZcVY3SDhhbWZl?=
 =?utf-8?B?MWd1cnZYQ0o0eThqWUFXV3lQdCtoT01OaXZkOE14c0Z6cTdCbVR0MGNpZ2JQ?=
 =?utf-8?B?NjUxc3NoL0pydzhRQjdnckpCRmhNa3dqMllYU0JVSjJiRWRQaElXcW9Oc3pU?=
 =?utf-8?B?OFBDbjN6TXM1VGZ5cGVFd1lYM05Qd0pFVFoySHFBZlNOUFh4MzRFdUIzWDNX?=
 =?utf-8?B?T2lLaFJ6N1hteUxyZG1lRUczbFk0aFhCYlVXNHFKcXY2Smw4WHkzNlBleURK?=
 =?utf-8?B?NVpJS0lESEtONVFzcUd3MnRTNTEwNWtrcXUrRW9XVWFuZU1TVktBbzR5SW5l?=
 =?utf-8?B?cmgwZDA2NFNWZjVndHJmLzN2ZjYrSjNlWUVGZytMc1gyT09BdlMrRVdtcGJH?=
 =?utf-8?B?SmkrSjFhYXFIeVozMWg1UlpRc2M4YXhYaHNWQ1FVMW5qWW5DditlOGt2aEJw?=
 =?utf-8?B?d0RRU2oxNExHZy9ZMlBUWmtSeFRXTktUYzNoT3UyTjRSN01LUEQ5cEhKMEMw?=
 =?utf-8?B?K0RWayticEhSQkRVaGwwc2Z1Rjk2aDBIZDJDbmozS0U1NVJSQk8wWGMrcjJp?=
 =?utf-8?B?UGxJSVZFMVBDczVMbE8rdmMyUG1YRGpvWUlBUU9ERWZiempyTy91VjF5TG9a?=
 =?utf-8?B?MzcweTFaTkw4bnEwb3VHKzhPakxucUNwRER0YTBCazQ1YkhZOVBiY0ZYN2VS?=
 =?utf-8?B?UmFsRGtPRk93Z2NzT2FhNmN6VmdaYWoxeFRMRWNkNkl3cGI4OEZFSU1PWllG?=
 =?utf-8?B?bFZLdnJlRGtvbHlCa3RIZDk4TFc1UFVsR3dYRmhRYjNEbjB5K2hwWDVEd1k0?=
 =?utf-8?B?dDdzTlZGZXVPaXd2ZGhxc0dNWnhiZ3Mxemh3WHBQdXM3NXN6R3J0c3R3NXpX?=
 =?utf-8?B?MHNyWk03UXgyRWo1K2FzK3ZwcHR2aFZBYXpVb3N4WG9lTTk0NUQyR1UzNm9V?=
 =?utf-8?B?RzFLM1luYkxjRDl0bGZhMitCUjY1eGlqZEhxK0hOczZ6Z21hM1ZIbUpYWk9L?=
 =?utf-8?B?MUJ3N2ZhcFVUQ0hGM2wvc3RDR2tNY3hWSWVIRjNGaVZVVnNlNGxCb2gyNjFj?=
 =?utf-8?B?WG9jMG1HY0RIMkRXVWFjYlU3ZjlBWlYwOTkyWHJ1Zm1wWEhSRHR3UTNhNUZN?=
 =?utf-8?B?enZPY3hGNE0zQTVjZ0JvNTl4VFpMRHZjWUNvOThEN2lvMTIrRTF2cy9DdVlP?=
 =?utf-8?B?emJ4UHpkR3JxQVUvY01KZUptdEhpU1BrbzhBOGhFeFpSRWV5Q2pzdklGUFY1?=
 =?utf-8?B?OWFFN29IWEFYVDdoQVI1TzdsMmpGMDlET0JTRHdLaU1TZ2wvVkVydGlaSkJm?=
 =?utf-8?B?R2ZSdTIrTUJUM1c2Y29kdHhYQ0wvUHYzMkt2Yzd0Z1VVd281cEFxK25ZOTlH?=
 =?utf-8?B?T1U0UHVXVDJXZjgzNEZVbGNxNjBLL0R5eis1VHlvZjZ5RktJREUxajZoODly?=
 =?utf-8?B?L0J3M0F4SVArTGtBa0NDZEwwWUxyT2RtYTFBM3Bnc0FENHhRbWFaQ1pFWFlG?=
 =?utf-8?B?WlhadEQrMHdCK05wLzB0OElmNXZRYXRIdmVVSFdpeTZZanI5SkJ6ZmlETlR3?=
 =?utf-8?B?c0NwNExKTExKbjZmZ3c5dVJLTTJkK1JKaTFjZUpHMXkxL21zU1l1L0Y3Rm0y?=
 =?utf-8?B?THM1a0pqcnMvenJneW11bHl5OWtBQTVwZ1RvQnJjdEdQb2hWckZ0Tkk2YlA3?=
 =?utf-8?Q?uqhQqg//q9yY5hC4=3D?=
X-Exchange-RoutingPolicyChecked: dFALqFdZwTF60NW81D1Ana/3vSgrTSsmENBRnd4OGCulkz6u9WO/5LugtBcE10/IvWAAw26DB1k4y3Lwlr/gggHfJbi7yLq65uSGh3TmebMRNhlhd1eCoziaf7+DwJ/7rZUoLSOdO43pmK87J6QzX7uO7MDK+sFe71Vc+72IhPTvnZcostvCr2vZleeKT5bN7cyKExuLF1N/cjje59HryzxNHA8bJtyed6wHzEE0+cixycoEWJX1p/m+bzetyP2rJnJtrPHdhVepbBNwpPPC/08WzI93yEmQPhuQN/ZA2dIVz0Wea6xWBMi6x+KXmKX00cI0nGT8dHwqeK/9izsyoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4aa088-e5e0-413b-63e7-08de9fc0be7b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 16:12:11.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tp1BKXGUYBnpqZ7r/nAZqhq/m/ovaumYjlJ3rUizmxFEcPRX20s+9obpE0O91rYjdUchEPUtTyn5xVxYQzw3d2vtK78Iq8XYtWeMsYtWXxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5263
X-OriginatorOrg: intel.com

Hi Tony,

On 4/21/26 8:11 AM, Luck, Tony wrote:
> On Mon, Apr 20, 2026 at 05:21:50PM -0700, Reinette Chatre wrote:
>> On 4/20/26 5:03 PM, Luck, Tony wrote:
...

>>>> # echo "global_assign_ctrl_inherit_mon_per_cpu" > info/kernel_mode
>>>
>>> This mode needs a CLOSID for PLZA, but doesn't need an RMID.
>>>
>>>> At this stage, only the kernel mode is being changed. However, there is no
>>>> way to know which control group the user intends to assign to kernel mode.
>>>> All we know here is the selected mode.
>>>>
>>>> After this operation, the info/kernel_mode_assignment interface should
>>>> become visible. But the question is: what should it contain or point to at
>>>> this moment?
>>>>
>>>> # cat info/kernel_mode_assignment
>>>> ??
>>>>
>>>> Next operation: Assign the group
>>>>
>>>> # echo "ctrl1//" > info/kernel_mode_assignment
>>>
>>> Now ring0 code is using the CLOSID from the ctrl1 group.
>>
>> ... and user space tasks also continue to use the CLOSID from the
>> ctrl1 group.
>> It is up to user space to decide if a group is dedicated to kernel
>> mode or not. resctrl does not enforce it.
>>
>>>
>>> But the RMID for this group isn't used.
>>
>> RMID is still used by user mode that maintains existing behavior concerning
>> this group when considering its tasks/cpus/cpus_list files. RMID assigned to this
>> group is just not used for kernel mode.
> 
> True, that the RMID is used if the user makes assignments using tasks/cpus/cpus_list
> for the ctrl1 group. But they might not do that.
> 
>>
>>>
>>> Are we OK with "wasting" an RMID in this way?
>>
>> How do you see this RMID as "wasted"?
> 
> Suppose the user doesn't assign tasks to the ctrl1 group?
> 
> Perhaps the resources they want to make available to the kernel do
> not exactly match with resources that they want to provide to any
> tasks. In this case the RMID is wasted.

Under these circumstances, yes, the RMID will not be used. 

A related scenario (when considering  what may happen if user does not assign tasks to
the ctrl1 group) is when user space disables PLZA on all CPUs in a domain then the CLOSID
(as well as RMID since this is irrespective of rmid_en mode) associated with kernel_mode
will be unused in that domain.

Reinette
