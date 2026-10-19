Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792426861;
	b=eJFwrerzOGTwKCfoVRyScp00ncgnQfjhlpOktl2QxPTWJNGHhhdeB2DLPIu4w2VHPjTy
	 neopNrN/Q/fa4VE8y8YwDL2uUHR2ZZ8hu/4/UqNcN+0qIjyDtuygwx22zY6QWr+za8LZi
	 ZYNVdPzPLhF0G/fd5H3fcPFPOC37MutudsN+TIXiq3AIaCOTHLVwpGRMhabp31jpRa9q4
	 pUWgGPimih2YmlDvupq18t8A25g48KZ7uomuHRCR6gdU6F0B6L4kC7Ejupz8vTvYV7OZa
	 NJknFrvuQ7QEhaLQg9AV7/IYk5KFuCT9k+6wU8bpjBw5U6ZMz8Xrxw0xvx4/Iz3DVsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426861;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=VBFuVB+i4R5dKwl6VAGQqUVlM0ry+T4GW2VqbEswul0=;
	b=JRsTOQNwTLdFz4npBFsGYiOYP7qJ3Vh/cBLqAyh6ZtAzvf408NEIx8nbe0ciaecpzPQq
	 LG9VFngGVUY6T6Ijs/9dXiQH6+O8+GYnC8ozUZraLNf24wGjT8u4iVEo/a7+HfEAWzcQP
	 JannrSNJuiXhKkUJq6KPzSCORxtd7mqodcsYW0ou9mmrwwRLtnxFekInEnVIYpKyimltI
	 duKlJt+jgraW3AxhbsL43qDu99QCeIOxwdfrO1JfbYd6c29GtZsyFHnX0DGSV98ULrYMl
	 qvuW+5/S5cdc9kD6586pFXnbUh5ipm5u/cyt7oB+rbdnhwxE77DTo92WV87oayW54bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="UHFAd/oL";
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94866606A322;
	Mon, 19 Oct 2026 16:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94866606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UHFAd/oL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792426861; x=1823962861;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GRafmRy8J2Jt1CDiiKswKa4U02L2wjmsFvOP3jVm2QA=;
  b=UHFAd/oLFeOVIzAq6xwhH2B0FmBwdOzJNF7E14NL1qjiq1D0ZX18h4XN
   2gggI5z8z6NfgyEChI4fqSp9SQmc5GdREkfZzvLehce5OVSnTY/EO9Q6h
   cXI982fejw9NmWKFfM8ehtbJGPehP6VsE3rcidgpJKUYvgkMJN/q+rjxM
   YHt6CSLhCZPCps7/Q+vum6xFPvuAGBbTZ7K7b4mvnFOkXVRTj/CB0wOe3
   gtnOsbqB0oS6IohUJeTFt3Gg3LlhZfsCsoTfxHkkcnzDZqa3QBWiyf9Vu
   yVRvoma+Is4Y47wxWiayOsK1iFn74jniDNAsxWtYn3JAauTvOydzzIrcD
   w==;
X-CSE-ConnectionGUID: NWLmD4uDS0yrOS1NYDSyBA==
X-CSE-MsgGUID: J/aOQfCXR+6gbfSibQp0iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="999024"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="999024"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:20:59 -0700
X-CSE-ConnectionGUID: GtVEg2t4RE+YxyvEV4b8DQ==
X-CSE-MsgGUID: uLLVEXg5T1WgOP+890e1jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2634136"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:20:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:20:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:20:57 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:20:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsoNQ77rB1rKKFWJ2V/sUSxwJf2K1lRo8nX+LP2JBU+Al3YFjweskVA3ZEzfeuaPisQsDgQ8tzfxfHjOLt2f88VEchKmb10/LUmYaOebdgBZ69fxc05kHmdSUvgde9p2NybbtrmAQnstMmX4d7J0dozygs90Z1t1/zknETqiXOWbQxlrEAgy8Kdi6rCohEHt01LVTQP2t37UHyVikRPMj7yjfhp2RNWM/HxdPPJBnnTpvB3syOldaPVO+8XglMrserauo1ohPpZYPTkEncpKy0e8+j+en4aIKQx3Yxs2W9sbugqPjlkzT/kgl/XPKNpkfRhEgf1927NCYnpD6QFUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBFuVB+i4R5dKwl6VAGQqUVlM0ry+T4GW2VqbEswul0=;
 b=iqUcq/Kwrnc82P7klwUJvm0OO15/aNt7B1K3ph1hqTmpL/sEu49hsL2AkElaELrcWYAkKePZwEpeyAOOG5u3jkzYhGVgz8+bpHJSt7Z4OkMIZB1odl8fl375wU+FZDBfq/Kg/TQ67GLR4kniveXRI6CLy5jQ3dt4Cc8kz2y4USBDTnj7mu4I7lRnMDjqDgy0ds63/ordE1gFSIiieEfdKvbD5NZQRaQUzaDunYY6WNXDH8jOon6G6qW+PAXvVoN8zqx24Se9WurEG/dfzmaVZ++l+uAyhW8WpRMvSCnfPV/0DRtZXJTMELSDnsD0Qnay7/3P3VGO1KV8j2vZdDPilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:20:52 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:20:52 +0000
Message-ID: <6c1b1e39-4cf9-46bc-94f0-500979986d20@intel.com>
Date: Mon, 19 Oct 2026 09:20:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/18] fs/resctrl: Add interface to display kernel mode
 status
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <ben.horgan@arm.com>
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
 <e044c381e0a8720649408bea47f9251a0dfa1693.1790867441.git.babu.moger@amd.com>
 <7d4770b8-779a-4c7a-b5cd-cd3739172a92@intel.com>
 <f0bb62e7-3044-4248-9f4d-c6a8f23de7b9@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f0bb62e7-3044-4248-9f4d-c6a8f23de7b9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:303:dc::30) To SJ2PR11MB8370.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|BY1PR11MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fae607d-8684-4cea-af82-08df2dfcf1ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|3023799007|18002099003|10067099003|22082099003|4143699003|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ljPNuY9mWvgP6qCg32Z9uqsVWlXnVS/YclA9F+heVLq0dwjPiXsf1i7e46PVeqJGLNGqDmuXlWZLhRV+j8I0rWe1IU+NJqp2RI+k9fKAPhGg73zzxqjTD7Qfnv5ZcUZB7yxGN167a6EKVYwa9Y4uiAThZ2+2fa4q364+cQUEapYkPJYV48U5v74ASeQfIxmifQ7FO++b+I2fh5HaNhwnzPUch2P2CIj+rqwcpo7/P943H1q28glrwMP6kPgsdBTJZnR0+6kupwuTRx/yv1jmnX33w7S23BWSUE9UAaG26F01Oa3WwQHcr7SmVWY56LcNv8Fn+RpOZHiGxU4Hz+EYVv3BxbP190G2jUPu0seGhKkIaaN5sfk/Xtw7w1+9R7mr3hDu902xz6Ghl+SirxAvwcQtu21A6zwOJI7wUXEm/7O5mFYxdH8k376GrzjQwxtvNo26DR+Ix2gviDemxgxlcNkgGfwlRK+XO0ivW3lv5OkomExQsltKQs3Bl1uHJ58wNrNRdvIESn7l4a99HvwjWlzUFcPU7WOREbi2+Zm0ctJpSMkf1cT4yS7HfgGW81N8a4OcM5d3FZPV8fdS/xOkuitOnrn7l7k4lYwyQ+qobyZx06nT3pwVZfabeDnuTiv2EHol0OM9pBFdo/ed6sduPxyO7oXM631RknCkoJ180G4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(3023799007)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjBRL0hkQS9aZFFiWVNsRDdpMnhZemNIZjAxZW9Lc3AvV2hHTUVuR2c4UGxk?=
 =?utf-8?B?eCt3dWl0RzF6ZmRPbk5NU1MrNFRCeG56VTRNdGZZUVFCZ253Syt6aXZJSm42?=
 =?utf-8?B?VFRYZEVlZ2xKeHYrZS9yODJBNzlzUW82cjJ4L1BFYUoxek1aTVd2QWhuVjRr?=
 =?utf-8?B?Nk1PVWpxakFWTnZaa1hPblpEYm1XMXZwSDR2TlhhVU1lK3dEL1VraWlPRjJt?=
 =?utf-8?B?TGJlSUMyKy9uWEMxWEcxN2dzMDNFRjZRbU8wL2FWUk9oTHB2K2lGWHd1R0Zq?=
 =?utf-8?B?YmFpOHA1YWE1VVlNbHRGaE54NmFlMWs1U2ZQTVNMRDRwcC9rRmN1L0gxYmd3?=
 =?utf-8?B?dHZpMUVVam1pNXdVNlRHL3BYRCtZV1pRWkpMckhOUno4ZTJwaWpCSGFZQS9Y?=
 =?utf-8?B?WGpGUEhJUloxSXlBWjNSQmkrSDZ3MHJDb0JqajMyQ2ExWjdnbjQ0TWdGUk1a?=
 =?utf-8?B?dGVkOVp1OXJOQVZ2ODBhUk80cFQ2NDRjSjVtTkd0bWlndlRDU1ZCZ0N1UnQr?=
 =?utf-8?B?d3FZWC8vaDBtL3VzUkN5ZExhc3k5SjdGbVRSdkdZZ0docUh3UDNCOSsyRWw3?=
 =?utf-8?B?RFpUdWdLK2NLSHVKMXBzUk10RU9sVkZlVEs1ODl6NHB1WURvbHVXTnJ2dFZF?=
 =?utf-8?B?aHhlYWxmTnQ2QnFvbWtocVI4cEdYajBMUmlmV0p4cnpVU2hyeVQrdUxFZHhn?=
 =?utf-8?B?ck9SUFBEdUs0NEExVFVoZXJqSlpuRGE4elRRMkNrWVlOeEg4K052YjVXTDd1?=
 =?utf-8?B?TUgxZXo2WTRRS2tFVm1tRnJ1ZTVBNzlIWG1qQ2RZSUo2UU5uWEdUd0Fma0hv?=
 =?utf-8?B?MHJUc3JDR2Zkd0hpZDU0UmVSL0FwdDlyWXg0SFRLMmFBbjQ3cm9OQzNuNkwv?=
 =?utf-8?B?SjFwUS8zQk03R090OGtmMTVadFF3Zy9yYkJ1WXVYM0NFVzJXZ0VmMngrY3JB?=
 =?utf-8?B?OVVrbzVsQjBzeWcveUZxTFJUZ0NrZDd0aHVkNldJM0ZxcTRlNUJqOTdjdDhj?=
 =?utf-8?B?eG82Qy9PRVd4bGpkaFdWTUdaMGxQUVBUclhhbjVSaTlEQ2tZcnMzYkZPb011?=
 =?utf-8?B?VFVSVkRhd1RlZk11a01UTldYV0VLb3dRT00rWFhQd2d3bnBMeVNuaUNLZloy?=
 =?utf-8?B?eFV1RzdqNXpKdEptNWdPT3lEQVBvYjVQMytGVXdRN3JpZ2ZZNlpISDZPd0kv?=
 =?utf-8?B?bmFJdHpxY3A5YWpTd3AwMnVCVWZ1Rm42cnMvaVdvc24vZnhnRk40bXBobjhq?=
 =?utf-8?B?RzFSLzRCdFZhclBTYitZOGp3SnV1UlIzV2dlYlBRSXFWOEZGTTB5UkZzcEVo?=
 =?utf-8?B?YXZHcW9JNGR2cHdwS212aUYrM2dGMXAyeGxRV0hadkg1MVZ6ZHROQ3c0THNB?=
 =?utf-8?B?TjJ3bTlIck5LSkZwWHBCN0I2eFczNnU5SURXc3lDK3RvVjFpS3lISWFoV1V3?=
 =?utf-8?B?RW5sU0lhTkhRc3J1TW85M210VE1hOXdWZHV3Q21tSUpNNDEyVEVUK3N3VTc1?=
 =?utf-8?B?OEpab0RMNHBkcyt0b3N3eGdqNTErYmQzZHFjRkNUeVRheGJ6VlVjYTNhUjRP?=
 =?utf-8?B?Z1Y1eWdVdnlQd1IyTXRVc2JiSnIwR3FpUWtJRE16TUZOYnp5M2xNRlpJSzNw?=
 =?utf-8?B?TXNqdU5rd25WSzdOSjhRdWJPMnRMYnAvVTZ4Sm9WQkZidys5QnNEWHFFVXNQ?=
 =?utf-8?B?V0hEby9mZTZxdndGcElQb1oyOVQ0Q2N2MFNQVmFtL0ZhaWtJbW40bDZPWjJi?=
 =?utf-8?B?c2h0cDJPQTRNSUUzZWJ6MWpFdTJYek01ZEQ2T0JSaXFGcmNMVXQxN3NJaWll?=
 =?utf-8?B?eStNR1UvRHFpMEtTaUsyVllFMmJ6T2libkc4ekNVbHo2SFVPUUhPb2t0YmVG?=
 =?utf-8?B?SEs0T3IxVjExQWEzMGhndm5xVmZmcDR4bkkyZm5ySzU4TUc5M3BKZ0NZTFVl?=
 =?utf-8?B?VHFQMHVWV2JQQ2xmVlU2Y3l3bGI0dnhuejFyT2gva1JVb1pZRUxUajJxRHBv?=
 =?utf-8?B?cmF3azJVWWc0Mm9PdHJIL2RVU0hjQXdaL0JOYTJOWW1nVUtqRjhGcndzdVlT?=
 =?utf-8?B?UW5TZkFEQmhDYXRSWXZhdnp3blcxMUpSRXhuMStlWlV5Z1Y1MmhZRUVkN3N5?=
 =?utf-8?B?YzBmM0dKcUowQUxhN0taOGRMc0dyRG1VVHpQK05oTm43cG9oTytSSEJzZ1ZF?=
 =?utf-8?B?ZEJCZDRzelhTS01ic3JMdFhIeGMyWWdzTVB2enpQRTU4OEk0cStQT1lvRXVI?=
 =?utf-8?B?VXVqeTNsZ3B4QzdFMVh6cUprYzBEdjlFME5HSkx5VUpSS1ZLTS95WXRIenNj?=
 =?utf-8?B?OFYvQUVUNUU5ZHVUaGZweTJjNExRQkRwaHROQmpiZzBpaWxpRWhudGhOTkVS?=
 =?utf-8?Q?3W2nPG15h0L2VPq4=3D?=
X-Exchange-RoutingPolicyChecked: PptK1usI9VRh2ijkhAYQgxwbVE0QtM+ygRMjGXbsyyheXqOvtJ4j437YTVMclGg0r9+LNVoIS2gcWXkQo+KdOp89UEDSCuAlP/T691wfdaBeTDLbQBDa4UXayQ1RE8iSvEFYU1m4jH6tQEPf39V3dPIkdMT+krvqkpaEaENADbrY1VIQY+jVcuBRHOAAH+9++8tEiH9SIJhtxdP8cvi2jmurL2mE8k3e3uHORcvPo4tm7xre0wXpgVftlZ26JMCziSBXLgNINb4N1fZk812T/R8NmQzLUeNycCLbNB9G+QjeyBystdmZvC2NVFNghBPpsVE8Bxbwn7Ni02fYYYCuMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fae607d-8684-4cea-af82-08df2dfcf1ff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:20:52.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZDGyI/7ZC/PRTqYQMFK3x5RXChw1NvzWyLsgM/oHpgJ4Ub97PbTHdpXnHDc7Q1PudqPj0oSPuRu/U+sXjBafkAxoVWatPk3IWclofrrfiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com

Hi Babu,

On 10/16/26 12:10 PM, Moger, Babu wrote:
> On 10/15/2026 10:16 AM, Reinette Chatre wrote:
>> On 10/1/26 8:10 AM, Babu Moger wrote:

>>
>>> +        and whichever of ctrl= and mon= the platform supports::
>>> +
>>> +          global_enable_per_cpu:ctrl=<assign|inherit>;mon=<assign|inherit>;group=<CTRL_MON>/<MON>/
>>> +
>>> +        "ctrl":
>>> +            "assign" if kernel mode work uses the allocation
>>> +            association of the resource group named by "group",
>>> +            "inherit" if it uses the allocation association of
>>> +            the user-space task. Present only on systems that
>>> +            support allocation.
>>
>> ok - this is already late in the series but this seems to make it clear that
>> "allocation association" means the portions of resources allocated to this group.
>> Thus the earlier " enum kmode_state - Control or monitoring association" is wrong?
> 
> I think, it should be " enum kmode_state - Allocation or monitoring association"

Please don't. This is exactly the problem that I keep coming back to. If you
change the name as you suggest then you solidify that you use the same term to mean
two different things. Specifically, what above change implies is that the reader is left
to decipher when:

"allocation and monitoring association" means
	MSR_IA32_PQR_PLZA_ASSOC.closid and MSR_IA32_PQR_PLZA_ASSOC.rmid

vs when

"allocation and monitoring association" means
	MSR_IA32_PQR_PLZA_ASSOC.closid_en and MSR_IA32_PQR_PLZA_ASSOC.rmid_en


>>> +        "mon":
>>> +            "assign" if kernel mode work uses the monitoring
>>> +            association of the resource group named by "group",
>>> +            "inherit" if it uses the monitoring association of
>>> +            the user-space task. Present only on systems that
>>> +            support monitoring.
>>> +        "group":
>>> +            Path of the resource group, relative to the resctrl
>>> +            mount point. A CTRL_MON group is shown as <CTRL_MON>//,
>>
>> Shouldn't it just be <CTRL_MON>/ ?
> 
> Or We can say "<CTRL_MON>/<MON>/" to be generic for both cases.
> 
> "The group is shown as  "<CTRL_MON>/<MON>/".

No, this depends on whether monitoring is enabled or not, or (if monitoring is
supported) whether mon=inherit.


...

>>> +
>>> +            sep = ':';
>>> +            if (resctrl_arch_alloc_capable()) {
>>> +                seq_printf(seq, "%cctrl=%s", sep,
>>> +                       resctrl_kmode_state_str(resctrl_kmode.ctrl));
>>> +                sep = ';';
>>> +            }
>>> +            if (resctrl_arch_mon_capable()) {
>>> +                seq_printf(seq, "%cmon=%s", sep,
>>> +                       resctrl_kmode_state_str(resctrl_kmode.mon));
>>> +                sep = ';';
>>> +            }
>>> +            seq_printf(seq, "%cgroup=%s/%s/", sep, ctrl_grp, mon_grp);
>>
>> Looks like this will print a monitoring group on a system that does not support
>> monitoring? I understand that the monitoring group will be the empty string in this
>> scenario but in resctrl that has meaning of "default monitoring group" so printing
>> this when monitoring is not supported is unexpected.
>>
> 
> Ok. If monitoring not supported it will be "CTRL_MON/" (Example group=ctrl1/") and then default group is "/".
> 
> Is that what you are suggesting?

Yes. This matches the proc output.

> 
> 
>> I also do not expect the monitoring group to be displayed if "mon=inherit" since
>> that presents a contradiction with stating that "monitoring group is inherited"
>> while printing a monitoring group.
> 
> Yes. We should not display "mon=inherit" when monitoring in not supported. Will check on this.
> 
This is needed yes, but what I was actually referring to was that if "mon=inherit"
then the group parameter should not include a monitoring group. For example, "group=ctrl/".
Including the name of a monitoring group when "mon=inherit" is confusing.

Reinette

