Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792426669;
	b=0mSUHdaMqN4lGNZqcopCKUhAqc52fyBeP/jwn5cryc+OCCa5mUY4+LDrVpRLXydQOft3
	 igHbQlGF0vnBYSqQmGy14UyQq7XlB5aHXOIe3wt+omgfQpVbL1F7n8mnocsuIxbDrIDb4
	 1HU+6zWnueeheb0mCQ/a9Q2HjsZBjCLIT0nq5ewGNt6SFS5lyF3mgjr1b/p+90gCMmRqa
	 pxdVk8jJVhRvq9oo4MmQ1efmuT+04VVV588x3Z4J7L3LkMny/XQLzgfLx4Wd4+iP6m431
	 aXJuAOZ20dU/NAvm53Z3WCHHh+xGrrzjPEBPNdHlFX9Ap04R1WEgc8UDLzm5VNiAhjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426669;
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
	bh=7d5sM8ErIU7iYfUgO08nfUQLnsZJvP6I5A8EoW3593A=;
	b=PX53m++wYP1vm2iOs7bXbpqbOwAsSqA5ESLXinBdrNAN6frSVbvxqkW0z5wsKpK00ME0
	 jjXAUxNb0sdWTBWXCbQK8C+sbaF261ORL+b0pXbVf4k7Gf6EXOoYFYEFz/I8K59yGMLdy
	 mKfalQyWjS9glLqXeEM+xP1t1TtRmtQ1GXWiRsiJlAj+HzxSEy/3rwL7Wa7uhxVZpmEmX
	 gX/CaU6STV37T4WQD0Aa8Zr5f7bTMxjKyyZLUFNwPfN+ygNAprBG2d395oCl+dSTpUPAp
	 nFnOLKoKjrY5ML9Y6iJEa6aS7L5AVAUj2RopPeEOuEJxIP9FE4BiEdZn3S2Ry7OXulw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c1Hc+c4G;
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F8606A32A;
	Mon, 19 Oct 2026 16:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D60F8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c1Hc+c4G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792426669; x=1823962669;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oIoeFHDfRhIPxaFJa+QQaZc4wNTHn3BjfbO81xcaPKo=;
  b=c1Hc+c4Gb5bEtoVxryd+yacV3QqY5EAQu2EG2Dhtvk/85GKg7sQsVOba
   AbfbWnmQW6p26kOB1sdy5MqdUVF1PB0zCKgu+fEr4zK/Dvm5PwFCOCti1
   fT/6x07mt+oB6lvdL5kz+eHUOAn4TIGm7QAfr069bucUEhK7HJJo0L3uo
   Tq/zAnaF3Qe+CKuFiVTIwUjaVQgL+MvEHZGsHsv+PZRWDqZMf4uxZP8JE
   N2wnC6TtSKrReWROpRHh1vF9ekeGZ2UsUJHnwnzrTeJyr3lzN5V9GmmeT
   sCoJtEG7clDC35e6XV2WChkg2/5Ok/dbJy2cV7/kuMS3AjFjsSyLLW1rM
   w==;
X-CSE-ConnectionGUID: Ehzl8+o1RsOKY/u9EP/sQg==
X-CSE-MsgGUID: kPHsOvKaSCu/+zWyy9T8Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="998420"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="998420"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:17:49 -0700
X-CSE-ConnectionGUID: Guxld4xnQQeH9cAX/49eTQ==
X-CSE-MsgGUID: mwF82SHgTI+AOp+elJsmXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2633600"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:17:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:17:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:17:47 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:17:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXBBYpdqQoMLAIuqeb2gWviR4L7Y0LPJlTEVc5NJpSFZU1TldGScdtUD+aDm5Tj0TFQiqiXqrzgIjO3lpL6EwysLqtavcaVAy0PUrAcHIbj81AeCfZuUdDukhO/BByxMvZAprQR9uOa3UHseorN7XzmKgUnIcxmXKYUfI+U3IG2S+PB+hxiGgD47n8a20ev92lfCX2AR716p/WivvSSTVxRBc7Bp/zfNKgycyUfdKxby1TaYAO9NJjRcPittCh5cvq19Zk1VFxaOlCrrlU3cMv5owF/Z3FvFrrIEv9riADX+SpzUvSyjjpsUKJMBgLE4rCVCJEhA2NOa0Gc4sH+zTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7d5sM8ErIU7iYfUgO08nfUQLnsZJvP6I5A8EoW3593A=;
 b=tvcDSCyOoVSh4LrnpnecMwDMzBGRNutyQvSHpKD5FtsHDrsjrH7Ba0IE1A0Kt0lxESOTDbHE3nLtlT3mU7eHJQ8FHfbduoV8nF1+/ROaMuUhSf1zMEVWf79uI4VAnSq0wfr4axS67dsSgFNUVW6rH5cQgCh9TcmeLT0VkyctdahX7yrz+07YHZEjQ9kMZ9Xz30L0/SfrnBkLMTyMTl0bW6vkb+/Hjzo46uBSdKOYHs+CF+bSrw7oHzPvnd5pm2N4HQJhJdh4QHZadg7pvN409jWbxYzN+O2nxl3KNFBebYMIR5cdEUS4lhkQV60mxNe9rdDGhEOpG8i/DO0JQLI6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by SA1PR11MB8349.namprd11.prod.outlook.com (2603:10b6:806:383::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:17:43 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:17:43 +0000
Message-ID: <14e8bcd9-4431-4dba-887b-c5b5e156dea3@intel.com>
Date: Mon, 19 Oct 2026 09:17:39 -0700
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
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a23f9f1a-3c5e-4166-8956-86c3063a9e64@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:303:84::12) To SJ2PR11MB8370.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|SA1PR11MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f78ffb-75a5-469d-7c80-08df2dfc811a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: W1xlvNQt0f5olzt2KdhoWVhFtNWu0xqjVYSi9BVlF4BpBsXTSN8tif+2XBZl0WxwCX6T6ZWjICbG5VyiAgn1sbDiqG3czsX49PnnwjZx9Mmoq+8QnXgEYNNiJ06XugtPP43Si52YM4Zit1cPlBIt0GVEQaxcyEEMhS3OkMV0FQ5CSFActgSkkmQBAsxxXVf56cyuS97gGy8Te1ST97lBzju5AAV+qAeTVHv0vVJuXiRKG+OItynvTTvd8xxCJuQzZMQSoa5rdgpIqqJieYkyl26jLSPerCLJxp38WyK19AqrErMwNL3L7P2zkyHtQnuTIzUWZBc9OQCBCtmLf/xrpMn1xH4KTKih+A3qJCV081nXzKBzvBUgPv2MlrX7S0QEnTE+d81jToFIu8qqMygj/L7iXWGUsVPkyj/HpJra7vDULMR8jqSIB7kkDhOKooFIPqBqVQk/75sd4tKcuV7XeZ61pEpXUuWc4jcC9lfRg02+PaB4Aq39Qp3ESTQNdc1mfxj3QIEHqu80dRKrExQ3FSINY9yegReOGa4AElW+rV1tgMzoLl37FOLGtqUljeqHCdeUUnfUvzri2VIX7hb4Zz+TxQQZtz8tcLwC4Gk8aR70eTss/yZ9AbasCc/ory1VBU6oRk5CDAwrxJHejbXj4cwhOAZS19EA8o/kiqTyMrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXczeWdEeWlhbkhBVzk2ZG5HV0V3ZjZJMW9ySTdYZW8xUUcwUXgwVkxCbXJk?=
 =?utf-8?B?LzMwNmYxdlN3eEJGbjVYR1o0citOS1IzcXpvOG5TMkJjbnIydisraTdncTVv?=
 =?utf-8?B?dnhMLzM4WnpRakZoVmZVZGpRT0MxWU1LdEF2ZXFWdU9HTENxTzQ2bjN4NW9V?=
 =?utf-8?B?QkhLWXhvYmFIQUVwUCs0OC85anhtM3B4Y28zWnZoSHg1YmdRMVo2Tk8vNERS?=
 =?utf-8?B?UWhldUczS2hzZGxrRjFnRmFXZHArTldDQmdBSTlUMHpiR0FvTklnK2FDV0Q0?=
 =?utf-8?B?Z2ZZWXp0U1Z6a2Z0OWdYRnQwU3hRMHN3WTRnMmNFZi9CN1ZnL0R6VmFLekY3?=
 =?utf-8?B?R3REYU81cWtjTklLcGM3MEs0OVJXYVA2YzFvQnR3emNBNU51c1ZTMlp6UE5R?=
 =?utf-8?B?b0tyMEdKakJxdE9ZS25PY2NZT2daWThWZENvWHB0bVJUL1BLSVdHZHNPakpZ?=
 =?utf-8?B?Nm4zUjFsYTdwU3BkMHhxNy9aSnhNbGNlRlQ1elpNcEhHd0FMRXVNUTBFbE8r?=
 =?utf-8?B?U0RUMEJzUWEzQTNIc3JCQWpVSUZKVlZoTVB4K1J3OU5OS0djVThlckFod2dl?=
 =?utf-8?B?NlUvSFI1M0F3RklyTGxDb0JPUUEwL3ZTL0dacXB6ZnNYT0xZZkgyeW5xN0FF?=
 =?utf-8?B?bjY1NUtQNVFqU3N5TlNFaDc4K3ZOb0R2L0VlWUhXYzJSSHJlWHc3ZzRhR2JJ?=
 =?utf-8?B?ci9QZzVIaE1HQndiamlYY3pzZzRQSmJOUkY5aXdjeXJ2M3FRcjIxb2cwQS82?=
 =?utf-8?B?ZjY5UEU1UUt4N0JzQUxTTTBiQ1dzeVpLL2dqMDVCYW1ubXJRZENCd3RMSDdp?=
 =?utf-8?B?aE5TRkpzSmtXNFJmUWkyNUtRZlNZejUzY1U4aU9RV21UeERJMWh5Mjg1QjFt?=
 =?utf-8?B?NEZYaUhMRmsxRnAvL2pzSzNuVlYvb3RBcUx0dU9QQ1VBRVg1a3RXamhiM2Zz?=
 =?utf-8?B?YkdsWkhNODBLaG1yelpCQWpUd1d0cVFKK2xCT2pueU83ay9hUVFZeHpUYmlG?=
 =?utf-8?B?K3VkUXJLanZCOUF0UHNyZ1E5Z0kvWGRObmVYbTd6cThkcnRFWlQzYWQySnow?=
 =?utf-8?B?cGhKUmxiUzJITVRxVEpRc0czaGJmS0JZL0hlcGdNRzBlYWFnOTdCc1hSRDNx?=
 =?utf-8?B?QzhXUktJeW1vSStDc21qOTY0UzE1NDE1d01TYXBycFlBYXgxdThndzZVQVM5?=
 =?utf-8?B?aVZNRittMVZJK2RCbnd3cEJEV1pDaGs5b1RMUXovYlQ3SWZwdkFVWis3RWM3?=
 =?utf-8?B?eE1EZ0k3TEF0NnVrbENBN21FZW9oM0JtMUlKSW16d0ZQRXRNbGVNV0dCWTlq?=
 =?utf-8?B?NUh4YUsvNi92NmtTSlVrMXFpM3NLRTFKbnBqckFRR0Yrd052aE5xZWh4bXdi?=
 =?utf-8?B?OFJzaGdtcVYrTHZnRklUWVVNeWM0ckhmdmdQcEc2em85OElVZkNJUmUxS0w4?=
 =?utf-8?B?b1ZWcmJmOWhMY2lxdEJERlFJQjhuclVmOTNkbFBzVDhhNCtTSno0dFhjT2JZ?=
 =?utf-8?B?d2k1QllyN2MzK00rSmx1ZjFLeG5TazFQdWRZVVdJUmQxbnMyTlVGUmtCaWg1?=
 =?utf-8?B?aVhLdDV1dTNpd011M3NtdlRvSXFWcUw2ckxHWWFBdE9tWDJYSk5JVTFVQ2tt?=
 =?utf-8?B?TmUwbm1rWVZWWU1nUWVuSy9uV0lEQTNEZnRnM1V1UDNnTTF0NndxaVpQcDFR?=
 =?utf-8?B?ejVsUFJuamJIOGNoUzFWVGJXWm53bUZSZE9kNUhiak1SM3k3YU5YVVpxUUs5?=
 =?utf-8?B?d25ucE9YUTl2MFdUMDRCRWZaWXp6RVJPVWhvNDBiMUpjenBsTUYvZXJDRG8x?=
 =?utf-8?B?VVQ0T3V2NVIzdEFTL1dqcmNwbjMxdDNSZWo5RU1veG5CWC9lUFlpUVlGNGpr?=
 =?utf-8?B?anJqbTdreVNvZ3FlaUFuYm1vVzRzajJmTlNQTFh0ekRhU0kvV3VkcHU2dVFq?=
 =?utf-8?B?L3JxZnRWbEcxUU5kRSt1NjJPZzlJbXNaeGp2OXBlQlpKN3ptNWE3RGgrcnNp?=
 =?utf-8?B?ai95VUhlTGZBWnlWVkYxNUpHZmlyUGxLUEplNUZWbGRjVjYxclBLbmhua0d1?=
 =?utf-8?B?dWZ2RFBTZndwY3hZeXN6WG5zZk5FTVlhdmhyaWNmSVRmVlJRZC9uakxRdXlI?=
 =?utf-8?B?ZFVuckJqN1JkYlJKeEhkM3paT0IxTmJHb3dFMkluWnorWjlnODFLUk9JT3Vp?=
 =?utf-8?B?dXI0VndHcTRRK1NuWTVXakh0UXBLTTl4bW1RNTZvMnRyRlhrYXpHZisvdUtx?=
 =?utf-8?B?Skw0R1k4a2IydkFLOWFkNTZlR0VJanlJcXdLYWU3Tk40LzdaWjRkdk5LN051?=
 =?utf-8?B?Ti9HZVJNREMxcmtEVk9ySTdMVUMyME1ESlZTTi9nSWNWS2dTZ0draFlUR1VW?=
 =?utf-8?Q?0v1ruhIa4te8j9Fs=3D?=
X-Exchange-RoutingPolicyChecked: iYabld9P5Vv+l7HV7OR8GLmFyBTdrKkpFIPCBlb/7eC8ZdnFbXIAzAJcdWQmBm0EFqJ2TBfKzEncnj424z4IKBLye+qrLtSHdh6huMhu+vWFZIu0Glb09qa28NbABmtVrsEM3N+TyxJrc61t8mpVYKISillDp/lS7sjIfJMj3niR0U2QYF2G54naK1E3hAqA+Fb7KvInhH2oFfboAzY3vcuU4aB7VPCnCIALNQx7AGBPvuDbg+WutopAt+MMBvvSZu1tUpLPO9t6rArM1JC+Hie3fCpVTJZ2pkx8knZJfbIoqxS9oSDyoYswui2EaS95aaiyBEL7YbWUiTdwDaYA+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f78ffb-75a5-469d-7c80-08df2dfc811a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:17:43.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ/0z1sT6tX2Z7+lkI/cgZyS0zgfBxoSD2MzZ2qSYChuU0P4ZwioFzwbVq0+hoP1WKpwFezU2P3We9c9gIHmv0FSHTVpog0jVKr+96zWolE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8349
X-OriginatorOrg: intel.com

Hi Babu,

On 10/15/26 4:09 PM, Babu Moger wrote:
> On 10/15/26 09:44, Reinette Chatre wrote:
>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>> Kernel mode work can use different allocation and monitoring associations
>>
>> Here I think "different allocation and monitoring associations" means
>> different CLOSID/RMID, while other places "different allocation and monitoring
>> associations" means different MSR_IA32_PQR_PLZA_ASSOC.closid_en and
>> MSR_IA32_PQR_PLZA_ASSOC.rmid_en?
> 
> That is correct. Hope text here is fine.
> 
I had to guess. This is the same topic as being discussed in patch #3. Could you
please add clear definitions to eliminate the need for guessing?

Reinette

