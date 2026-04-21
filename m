Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195E17B50A;
	Tue, 21 Apr 2026 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776730923; cv=fail; b=b/YjgRA3muNUSwgq5mqHBPAILyntmsShxoTnU5LwH+wHV6YfLX/NqJqoHtBfqlMQ88nIDVupqNSZ2KDSBX/nBH5zvu08ZNJGb7UCMKhSZqPAOeVXmWFp26SEZ6SuNkgYub5Rp8/UuNhXKKqhdEGPfBP86KmFv3mPdMEpUA6itWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776730923; c=relaxed/simple;
	bh=0L37Kp15vk3LiB8Vk4icAXKPCauxu695P07iWZAnWVc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lRjDxd/nmxqKD4+lAXZAwkxF8qG75ic5k2JU0ql/+IpcrCGRgo/P7San458gSHVryZqaRBC/bjAZtvMTN9Ve+YXJyTLSKmYyD9oMh/DcfVLV6FFw+J+Fpg+adk3QMman729pkaNeUUfe20xN5T7EsSA9zoJc4dCxe+gTEv1/qHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpKDDr8u; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpKDDr8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776730922; x=1808266922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0L37Kp15vk3LiB8Vk4icAXKPCauxu695P07iWZAnWVc=;
  b=DpKDDr8ukA4rHW4686aHgNo1foC0Q2PiOrm1ukTvsMmxNao0hiRdmqg6
   I3iXuSplCXgEzqyXtivMsdDbz/xSLQtBN+CBNl6cf8TJY0JRBuNHL7THx
   lSHO2a9wQNse/pjRPq7Xwi0cvfkkwqtA2Owm0QQqEvH/OWcTd+fZScQEf
   MFwAoAT1tmA8r+QLQylaSU6dtpQiSh4YjX//YgK8ZRkfUj/uqAtm+ObMd
   Xvyk1r+aPGRFp1vgsK5Df7NrT97MHAwPlgMB/7nIo59S23FoOG+VTWn5d
   0l0jRkEm1zhj9rOdAQdn/arw8562XRRbwhOuqA/3QkBJAFI8YVfL8/JVQ
   g==;
X-CSE-ConnectionGUID: uRQYokQDS+KbycBmxr8fZg==
X-CSE-MsgGUID: 6F6M1xApR2qoh+s7XvCp8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77839078"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77839078"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:22:02 -0700
X-CSE-ConnectionGUID: o/u/GSoAQCyVUI2UXVK4vA==
X-CSE-MsgGUID: jMhD7maQSt23zb7cdZ0F6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="236846817"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:22:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 17:22:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 17:22:00 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 17:22:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPxyZiS9wa+JUHN2pWUW21/4HrO3gv0hJX21ZLu5dJYWlRkhL4fm3lJWyCs9IW2fM738m4dMLZyrQBuaQdo5r2HWw2q1VnhxrCAJH/8YTTZZp8phtmths8ZmSoXh0ESATrLaQNSR1niSlTs7lboddljJd+Sbnou3DopDDokI5dxxKOxMJJjAj4T+84W80a06KKFlA/aRRfjnQApJimtZJMmecvr4PLOyUxsZ3tHVMCi2sA+StHyqukzMHXZ8U5oZqAvKEZJH5T2Ko32zaq9yIqu+ieTCtOVXrwWAXBQva3IgvLO7gMzyqJhmv17IKLGT1Xh/VwIL1f7PAr49sEvNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KglKSwgRQgnctHsXTGYQzqC8dLTgKGIhMzM/kGQmpns=;
 b=i1L7/cs9jOZ27ov2C6cNHjV+LE2BociahwslQa2ke0Q1StVMmsd4PorHK5+Adezi/m4eV2vVDABArxMPVPdVfbWNmFBriXUeilPLpC1ohNA8B0/flqNkcrpto2L+OTATViQIPvHuV2bZ32G56KJ41o83ttw5S6j4IOEf/fvN2qXFsxOcgv2+392y4arLcAcqQwXEfNXisv6caWb7bKGKYo49m7W7TKC3iPj7RzG2MXFVFuSP01Bqt+7/KkuG2qHuCBdO1TUABfSFSTi57nshpGIvy5SbT+RShCqOvYnHPrYFFVyhNlzU4959T1VJX195IUjXyepuXhvTHc9L74JVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL3PR11MB6481.namprd11.prod.outlook.com (2603:10b6:208:3bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 00:21:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 00:21:56 +0000
Message-ID: <58b8fe0c-80f6-4ba2-abbe-90d0ceee6daa@intel.com>
Date: Mon, 20 Apr 2026 17:21:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: "Luck, Tony" <tony.luck@intel.com>, "Moger, Babu" <bmoger@amd.com>
CC: Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"Dave.Martin@arm.com" <Dave.Martin@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "x86@kernel.org"
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
References: <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <aea-wdaZAWl2Al1h@agluck-desk3>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <aea-wdaZAWl2Al1h@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0308.namprd04.prod.outlook.com
 (2603:10b6:303:82::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL3PR11MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: c6323ddc-9383-4ab5-fc51-08de9f3bfe26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: cNLalT8j9PVngSnuVnOIWqXMdrZ9YlZ1OxaIa/3F1vQKf7wkW9JiUtf5CDckkXQY7EVm0NXtIFY0vqePmizNHx74GPfnHr2ypzNCnuCtWWDOfPaVpdN82WsBmVtlO7JqPUm8va/FCIZ257EIsw7WEojR4qAIcQ3vrKyiUAX9gqgmgpZJvwEkP2Y6mpnqnlXe8rkFzhtcQ84GZLlHuSApkvyPbzAk0FfCYkzjnx5Azd6Elrn5PDU7tAp1yYOIkMfIT+uUBRSEgjwBojOoAgKMA4raO/vJDOdTC8kc5fqwu1VqM6zD1Hn3ZzUVOJy68quXyn0OeZ/U/9AvvpKf46UNx5BjYdkzDZypdPvz8F74fGwxy22QHIx2Rog5awrZFPMw3ovmBkivngPwddAbqzSDjMhAW79x0ud5gpjv4AOYMSjjQmk4en3XvXDC4821j6ZYhGjErbwSQMJQApMX0rhm5KgKRTe8pAB0AuyxLjRR/Yw2qe0/hr4myu/XcO4Ei6x4lITJXFS0RU+yYin4tF73qVD2JSAJVQJ/nSU+0p5yg7en5sBqvqZNpqDwYJZGq3dOlM0SO4CCW4DBhkfgERbHmo5tiawkUq1lIqptIfU/xcRzXKQIsnWqNZ/daH8QwslegGVAwaeScyWRvuxWIfzJCvIMDCiJ31wCgqN0rERcTuw/GoxmstWB14r3F4abq1qX0pMyuxWHPngo4fq7qKNho+pzbnlbmdpImf8TM9prT74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZWc3dTRWdIS25rdDZENXVyYXZITEpOOWV6eDBXRS90MytabXhpMkhSdXo4?=
 =?utf-8?B?LzB0OXo1VXhNQmRNNDVScEdwSGxHQnI0QUNDajJ4UGlvWUUyc2lsWVg4M2NI?=
 =?utf-8?B?bjljMjZXUkNwSUwyNndnNTVvNjdORXVRVHMySTBkYzYrRTJMVDNQRG1yOG9G?=
 =?utf-8?B?UngvSzk3eFp5UkJja0VZU0dKUStmd29qOEszaEprY0hPZDUvZzJHS0FTQks5?=
 =?utf-8?B?bkxvRCtCK3JBakFWYjBRRnFUQ0d3M0pCMDcxdTh2SFNYYUpSRG1WTFJncE1Q?=
 =?utf-8?B?b2ZMdngySmQwdU1BaEFFRmVPRU9iZmFheitMWXJEMnRKOXgxMEd2a1FROGNH?=
 =?utf-8?B?MHVsWUIxa3k0QlhEUjgxbUtKTlR0OVFTN0MweU02SXlDa1JJL3hvNGNyeDRi?=
 =?utf-8?B?MERZRjJWN0RuZHV6ZEcvZWhpNzQvQXQycUNySXpzZDN4YVMyQVJCK0tjRUYw?=
 =?utf-8?B?bjg0UDJZaTBsMXl2UEYxT054RUZPcXhkZFB3MmJNMTdiV2pnV0pVNVR5cDFE?=
 =?utf-8?B?N01ORW9XdFZqQmxZR0pZcWlKa0JHUTNta21wT1RTSU9aTXJnTnZkWjltVEto?=
 =?utf-8?B?ZkIvb1duWitzcFlwWU9KdVo3c1hXM21nL3k0VlpmWVIwRzU5SDJPVllYZFVN?=
 =?utf-8?B?dE1OQWdQdVdJTzlOZW5qcGZXN2JSNnBNcnl6ZDZuQmVneitZRGM5QXlkRTE3?=
 =?utf-8?B?WGxiS2IwekJhdzJSYTBsYVlYSzllbCtVeDBSV0VxZFVZWlJ0SEdyMlptLytN?=
 =?utf-8?B?NmxyUGdzWGVQeGxzMTl3VFE5RTN3cE5SdG1VZ0JBNTJqZWRNQmRsZkhmUUlH?=
 =?utf-8?B?ODBmSkVDdis2eThCNmJGNGxsRUJpMVJiUEVIa3l1V1doUllwbjEzc20vZTFK?=
 =?utf-8?B?Mk1ZaW80VHZDYjVjd0RiaThnUFNXV2NtVGZMWjBodFNzaXAxQXFTZ2ZJMTBK?=
 =?utf-8?B?TzgvTUFlTVRRcTRFNlFIKzY1a205c2d5WllZamtDTG5YQmlWVmRuczhmanM0?=
 =?utf-8?B?ekZmRHVkWHN6VkVmcnFPYU5KZ3p2TGM0SWxRZ0ZTZ2FzT25jbThaWjVpY3kx?=
 =?utf-8?B?VGJYODRLNjl2WkNvdE5NQnpGUEdKN0N4UGpLWlJubEFmTGFXYk16bU1VdDNH?=
 =?utf-8?B?QzZUVWtnTVR0UExJd1VRS0hDRmFHQklPd3ZhZ2g5UW1SVlBHS09QVWU1bnM3?=
 =?utf-8?B?a2dMRVVjN2JwNi9ld0N0MnFYMnRIN0J1L0VycGd5N1VzZkF3NXlSZ2YvOUJT?=
 =?utf-8?B?bmdENG5kMjhHMGMvbGdsYnBwQm1NekZOeU5ncVV1SHJ4TnBMSHJBNUFpQXhy?=
 =?utf-8?B?Qkt5Q1U5UDlKQThDWEphVGNtK0pnZElWeUZ4K3hrNklTelk5VEFFMG5BamV3?=
 =?utf-8?B?Tk1jR2Y3MkV3eVVKVGdUZ1hFTFhoR3JFYjVKVzNGNCtxcnVVc3VpKzAzZzMz?=
 =?utf-8?B?b1hJeUh4SDA3L0IzZmtmME9hYlZ4YUFJOG4xUjV3TlpNVUpjOW0wUlE2ck5i?=
 =?utf-8?B?aTRnb1dWMkU5SU1NTlBYZzBKWUVGR1JxS3hLZUhQMERJMWJBNnU4Z09NeXBl?=
 =?utf-8?B?OHh1eEhFWGlyRHF2RnNLc3R0MDRGMm1xenFlVDA3K2VMRXFJU2Z6QzRLcFRZ?=
 =?utf-8?B?ZXpxZFIydmoyNmRqVWczcy8rcFlCdmRjaEZYcXlzMUg4MjFPaFVtYkRJQjBF?=
 =?utf-8?B?dW05NXl5OFlRamJaeXNGdmI2YXdHdldpRUd6dkRDaTlxODFzajlObkIvV1Zt?=
 =?utf-8?B?WnkxeFgxOG12U1FrQy96eWhTVTdqVGc4UzB3RVNCaWFNM0Z1U0tKbWd3eXBS?=
 =?utf-8?B?NXBOQVJkdUx5cXJVQTJDZGwwTHdLem9GMkdhYnVXd1RkNnllV05tZlJ2NGJx?=
 =?utf-8?B?RUNXTDRoeUhwaHZJemNaQ2IyU0JOTEZIQmpOTk5aRFd4RVRiV2ZGdUMxNXZJ?=
 =?utf-8?B?RG9PcHU4RFB5RVN0a2EwbGplaDU5SU9adjMvK3NncHpua0hlQ1RmdEhMejdM?=
 =?utf-8?B?YUdOeGI1aHRBc2w3MTloWGRIaWtmUW1hTWhEYW5YVGt5bTJTbmgvY1NodTgw?=
 =?utf-8?B?VThYdk1lODl3N3I2bmE0dHJiUy9qZllucy9qMURnSXBYOFB1SVJ1VWlzNEx5?=
 =?utf-8?B?WFJTaW9QUE9HT2NSM3NaUFNVdzB5MlJBVXVZelMxblFPWVRjRVpCV2ZORkZY?=
 =?utf-8?B?UWxCUDJmM2UwL2pCRFgyNEVSS0VnK29aNDd6M1g2SEFwSXc1RTh5L2Z4dnhG?=
 =?utf-8?B?aUVPSnFMVUdLdkVPK3hlYjVxakp6WWx6UjJkL2FFODI5Z052LzhnYTJDbEQy?=
 =?utf-8?B?d3IwbzhmN2dwcHV0TGhveGwvOXF4bzRLaVNIMWs4L3dYckhEZFdvRk1sSW5N?=
 =?utf-8?Q?MNzp/a+tP83MonC8=3D?=
X-Exchange-RoutingPolicyChecked: sXDco4eMtDYou6XYjdFk2z+iQ3dbAED2Hw9odv2rvO/TbuL/7HCEL107dMg70Vs43GVXt+TTh9ULhlyITvomvVUaYcnsKWA1B76lUIk0OLrWvvRl9hVhJ1ZEMwme0m91FWo2jTVF8TOUdKJPDSBEUcDQeCDNP0u0+fwkUZ8+kKKCwF8WNmIz4Ab7y9CY1KQy49WvrAGRlJtPn+IOi9IvmbjdQMBkezA/GnjOdyZsIPo4YSPfxxOOCEslrPsjLc2F8335jLqPiQj5vt1DDzF45OTvy8OUXcyho1g1dM8YPRN/hVf/g86GJbRr1sgxVB4kee2wfh7e+UPrLNJaesCfCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c6323ddc-9383-4ab5-fc51-08de9f3bfe26
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 00:21:55.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGFAYHCRYhO6nC371rGOfMIsbmG6Zmjl44OGYb8fHaAUD/EDeieO8JJm1bg2JYJ4/unRd8rjVx7rQgDv8HrgZgXQlgstp5PBiO6cFC4/mnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6481
X-OriginatorOrg: intel.com

Hi Tony,

On 4/20/26 5:03 PM, Luck, Tony wrote:
>> The system boots with these default settings:
>>
>> # cat info/kernel_mode
>> [inherit_ctrl_and_mon]
>> global_assign_ctrl_assign_mon_per_cpu
>> global_assign_ctrl_inherit_mon_per_cpu
>>
>>
>> At this point, the interface info/kernel_mode_assignment is not visible.
>>
>> Next, lets create a new control group:
>>
>> # mkdir ctrl1
> 
> This allocates a CLOSID and an RMID for this group.
> 
>> We want to designate this group as the new kernel-mode group.
>>
>> First operation: Change the mode:
>>
>> # echo "global_assign_ctrl_inherit_mon_per_cpu" > info/kernel_mode
> 
> This mode needs a CLOSID for PLZA, but doesn't need an RMID.
> 
>> At this stage, only the kernel mode is being changed. However, there is no
>> way to know which control group the user intends to assign to kernel mode.
>> All we know here is the selected mode.
>>
>> After this operation, the info/kernel_mode_assignment interface should
>> become visible. But the question is: what should it contain or point to at
>> this moment?
>>
>> # cat info/kernel_mode_assignment
>> ??
>>
>> Next operation: Assign the group
>>
>> # echo "ctrl1//" > info/kernel_mode_assignment
> 
> Now ring0 code is using the CLOSID from the ctrl1 group.

... and user space tasks also continue to use the CLOSID from the
ctrl1 group.
It is up to user space to decide if a group is dedicated to kernel
mode or not. resctrl does not enforce it.

> 
> But the RMID for this group isn't used.

RMID is still used by user mode that maintains existing behavior concerning
this group when considering its tasks/cpus/cpus_list files. RMID assigned to this
group is just not used for kernel mode.

> 
> Are we OK with "wasting" an RMID in this way?

How do you see this RMID as "wasted"?

> 
> Maybe it doesn't matter too much for AMD as you would just
> avoid assigning any counters to this group. But should Intel
> get around to doing PLZA-like functionality, that's a real
> loss of an RMID that might be useful elsewhere.

Reinette
