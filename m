Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07C376BC2;
	Thu, 15 Oct 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074683; cv=fail; b=MeAYNK8TwVdiNpw3O0yYgP8X66BGj0aDnjhZGQxVOoTiY81fn1s0VVUu++2dU823EAcS6omLbHK/+9O6eE76gL1Y5xS2UIvMyA4ogQBCD4hW+wxwwlcADMBd/1BTvZ1NrVv0/t6P9NicYHDcw/ZDzv559AjtHjtuuWOQrjGCxdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074683; c=relaxed/simple;
	bh=LU038AzOa/8ceJ/dBJQc3iu9xMRljLzDNKgWrh7G220=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvO2pq/CJEsNZ/SC9A8jWp2vBOcwRi6P4Ue50lM7ZIYM8VWT512SHLzsmVhZVNYx/OWatbyTgUV2yKpIOdhL/hZeF1C/L13PmROTripSGyBfsplAyOVkh0FNNwQ6GM8+220nIMvOACBq38wCd1By7KFTtsNRGEPgedHwZ+62PDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7WRLcjv; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7WRLcjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792074674; x=1823610674;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LU038AzOa/8ceJ/dBJQc3iu9xMRljLzDNKgWrh7G220=;
  b=k7WRLcjvEQINXTuz9mQ75PI81DbVb1Zfwd2Ek51Bxg79We9Ax1aDhajf
   b1uWyc+fyzQYW+SF4VijkUVJMcv0YZsDWjcK0mbmGXAfKAF0ba1K3CiMy
   WqUNtP06OCmd91rpuTK/8BYqbN6+mpbKXmQ6cWGDJo4pHuuk8NO95LPop
   KGR/F/47VmPDCKPz0FsVS4in2rwtp0e6/lUR5J5k+X/EVQnQU/R0UqQcm
   mAc3sFT2Ar/LbIcmKCbqCbRus4juaB4jkr9x3jHWUJqQ4QapSbw+DF/kZ
   UEGYchJfXieRzxbETyFuMV30KLpi5mIYFTPyKgmmQ0n10bXkH5yubiOAI
   Q==;
X-CSE-ConnectionGUID: ++RNV/OUQ9SEs+PATugRbg==
X-CSE-MsgGUID: M6GPJwB0RYa6T7ZUK1Yk1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="877573"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="877573"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:30:54 -0700
X-CSE-ConnectionGUID: K7MUIV5vSnSPN/Hi0RMG6A==
X-CSE-MsgGUID: 0K+x/tt3THy20Q4l87oYTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1617932"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:30:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:30:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:30:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:30:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpGPUeU9fo+senIbtdbFI7+1xeY6MpVqGxlcDPY1WiZ6+WSdjDHd4FSASHNPrewUDyov5GcZ+6HNn2ftbGijL3i1Ur3TPaZiqNSDI4RQqjfmgL49hQMWOUALY/0O8CPgxg/+Vz60Bpe0INYlO6b8ZLiGJB1y/QO+m57m3DjpoZrQJGzjv110xyRPPq/6i4VSosk2ezfB/v+yaWdXnc6exoZRZGmXODZrMbZuPERj61G57twWzO88LQTedpKkQI2B7IOIZ2xOhnQYJC0um/qmR2hsva0WHLMK4lMnUX+p0PMNAVe325TJgTdJSSzQa7C0w21VMGOeE9Ew/1VLVvOGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYZxNsgiSwvUwMWdznDktwdzqXvzIKyeFgci7NO3KaU=;
 b=yzaT/czKgtQo5dzEbtPt4brB+OyD3JIYBbXtDl94dz6q4SO3Wvd7oOM0KPFkhDXeH1JPfp7g/yOJ62BWiqcZOfub0StOK1MXnrg7iAF8DxjEum6Uk0TQJ2eM9uNS8Mh43TcE0nPxEfkxMRk3e1u9FA5s0/LRBU00bnX7ApQj6D92nPRmz8q6qIeNuSQIJUdqEHPA081ObQWza008jHVsBikUiqYxOmaz+JiTJQW+pVaQGnyOPJV5lDgownM1cwB2RGjX3GbSYYRb15fp/CriNtSEb7CQENv6Qi1CfxYtgesjgQk/nsrbKJq/wpyCvIdoubqHsboCeyzmx40f8OQZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by IA1PR11MB8222.namprd11.prod.outlook.com (2603:10b6:208:44e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:30:44 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:30:44 +0000
Message-ID: <b0a15b3a-06ac-4320-8198-78f8dcc5c74e@intel.com>
Date: Thu, 15 Oct 2026 07:30:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/18] x86,arm,fs/resctrl: Introduce architecture hook
 to program global kernel mode
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
 <12063d85972c5a41a95fbded4a01858e5bb04e6e.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <12063d85972c5a41a95fbded4a01858e5bb04e6e.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:303:b7::28) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|IA1PR11MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 674562f2-4f71-43fa-1923-08df2ac8e587
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|11063799006|261009223027099003|4143699003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: vKRMos+UD5gnkzeN9gnDxd2uLv1Buc8yNJ6+hT2xyW52wAqxG4Zts6QP6HUbntxRNzUtNK5+IM8vl6SNifuGLtP2q/w2fLpj7L3dYPe/hypMvQABWNu+t4a2d8EYcBfejwitXsv4Eis5NXHZKbqWWwvl7dhdE3ksRR1atOQ7fhmygIV0jRsjjZWy+Jpw97Q4A6LEuFdhE7sK6rsmIsYaTtZRHJJ1TGp1cw8mk2fyLsHVLlMLZb7jFa/M+//BX2Su5cp3M57aN3dqTXN7l8g5iUHWjL5AbnlArIZv58YRG7xovPG/kZDwW9GawFzZGZMRK6ikPUF3GFNHd3LXKemFh+aRuH7790oxBr6OtD7CYSRXpZyDEopYOi+6+s2skfURCTSGz+ReR5ACcB6gt5SYFt+LIYQMkiOVpyqtjGMWoUhbf9JaFpUtprq0S+xQEzWg5y2HkHt6+8q8PI/i6Cv6pHVAplW+dOvJHszHp0s9O7To4g3KbkEO77Iqw7ZY+pOlWcfPJ7IsE2+Z5+Idkb+OE1bS1ImWy2RUAFDDbtj454PU3m6uHH619WW+h59rAitPKCuJIPJx0RSZTzIGkjDxpz5x8vPAf1ZNx0aQ8qpz4Z9Hu4bGk8gpa0bCpBv7Tl8RTedeaonp/ZGP3FNJ4NDacDD9tRQGH55OLjMPOnMVSM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(4143699003)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tnk3bk16bnMrVDhtUWR4VXdLdHg4eThpS284emZqTWgwNDJtVkFOdDk5WnM1?=
 =?utf-8?B?OGdUWTRhalRBZzk5bkhRY2NBOVZ3b3pDWFpSNHpCNXNlcGVzTCtGQ3RsZ3ZG?=
 =?utf-8?B?SWtoMnV2V3RIdVVVRmZ3d2FJaUNQU08vM0N5dDg3Ylp3bHF4c0h5V2pCNkZ6?=
 =?utf-8?B?VllBUnlFS1VLWDJWVCtqZlhkem5JS05NQlNLUlJQT0Z6Y3l5a1RGbVZwMHJm?=
 =?utf-8?B?YzByb2lVTjVUTnNCa3FCK0ErR2luTjFHOHo2RUdrZ1V2S2IzTW9xSWhWSTc3?=
 =?utf-8?B?eE9XN3B2cjJkWEZsVWM5SVZYZXZXemRId2NOS2xDaW5sVTBlS0ZuWVdBVGw0?=
 =?utf-8?B?dXVJYmIxc0JkQXpqUDFKaVBueTYvZkY3KzdvMGsvNHEreWdtaFpPNDNhMkt3?=
 =?utf-8?B?cmhRc2lDckx6d2prYnhKSUh5akZtTzBTUFBZOStxWTJZNG9MTXBpWGRkRFVr?=
 =?utf-8?B?RkQ3TGI2K09LWUppYXZhbldFTkJKMjNUdkE1VzNXMUpPZ3U2UUxSQ1hUK3BN?=
 =?utf-8?B?anlnWXIvZ2JKZVFYRTVvd0NnaDM5MVFDQUFHMUd5R3NOWTV0WWtlSCtnODBH?=
 =?utf-8?B?Nm9rVXIwWjBQRkdqUUFTTUJIaEJBUnJkbmxobHlTYmQrN2k1YTlMWFplZFJV?=
 =?utf-8?B?WG81OTN4U3IyeEppKy95di9ZY0lZZzcrdHJZVFR6WkoyK243L2NJSjhab0hX?=
 =?utf-8?B?eVhtREZIWTFYSGR6UFA5bllGemZNbjIxd0hmZGZneXJmbE1kdy9DOWN5WGFv?=
 =?utf-8?B?NmJnb3lTK1JtY0wzNjdFbkl3Qm0xV2poaGQ1UStxdnhsMHBLUWF5VmZ1cnpP?=
 =?utf-8?B?eTk0RlFCODlSRlliTnhzejcrL1dXajA5bHBTbVdvMkdkTkhrNnRIS1RJb2pN?=
 =?utf-8?B?SUh5U01FUFBJbWlyWndtaFdkdVgwMWZ1UEVWV2JidURERWxtRXdYTDRjNitZ?=
 =?utf-8?B?L3VDcjlBR3RrMmxMQ0owRkRNbEtMbGxPQ0k3VGRLQlFBODJiVGxoVFZ5TnZV?=
 =?utf-8?B?Q0g2MEdwR0NrL0dQeHAwbXZuaHo0cVNMZStHZkFVUy9PVDI3bjdUK2xRVnE2?=
 =?utf-8?B?TFVXQWl0eHdBcklXQWI1NWZEcER6Z1pjU2hrWU5WWW5TTEZxZThoeFRvSVha?=
 =?utf-8?B?NWF0VUlObHlrQVRVQ3ZoMk5CQ1cvbVBEL2tmUEV0dzdwYkdpNUlsTG5kcFZX?=
 =?utf-8?B?MC9ON2l1ZDFLOE1xOHUveElQeHUxeEt2dU5VbXNyU0FKdkJycm9pQmtPZ0RY?=
 =?utf-8?B?MXZncWc1em5mVnFJaGZCUGdVNFlQUHRlYUdOb2lEdDhHUEtmRk9PenJ0aXFx?=
 =?utf-8?B?RXlmUksrcVFPdHkxNjNYSE9leTdSaW1MMG5qK0hNVTVweG1ha0VaSW5VbFZH?=
 =?utf-8?B?TXBKaTFrNVp5eGIwQkpjNWhZeW9EV1R0VEJHaDJuT1BRWW9CSS9pVk1DNFc1?=
 =?utf-8?B?c0NkeGVkZ1FmOG5OWWdaU1p4ZGMvaHVuOVgzYzdzWC9oaDhabjBmMkNLK1pO?=
 =?utf-8?B?V1QwclJ4QjhaVkJsRzA0RnNmV0NPL0cwL3Q2VFB2UXRjcERYdUVXQTNvOUZE?=
 =?utf-8?B?bUpoeVlkRVBhWDNOZWd1dEMrKytiY2gxVjZlMnlsRTNWWFJQT1pXekpUVEVH?=
 =?utf-8?B?b3lBaWZ6Y3U3UkdFcU9zMzlmU250aFA0WW51Z0VVaVJUekxsdDZvY3NYTTNt?=
 =?utf-8?B?VmV4Q0VrZnV1cFJXclZhODNrelBNdzN0RXE1LzQzWVN3VFFVVmY1a3BzZ0dI?=
 =?utf-8?B?ZFZXeFRZL1JaY1EzMCtpY1BmRnBhODZNNWRLWmYwK3d3TzI0VGZoZmF3K05r?=
 =?utf-8?B?Zkx0OEUyUy9NS0Q4WDI0bGZIQjh4UlI5RmNlSVpsYXlCTkQwVW9Yc3piWHJX?=
 =?utf-8?B?MGRDYSsxMThEZm5ZSVU0WE1UNFdtSThOWkoxc01mcmQwdDRqd3ZNcVpwS25x?=
 =?utf-8?B?b3NxUnZhWkI0RGZJVXQydjZPMzQ0b1ovWFNtUWExbmZaT2lGdUEzQWx0b0Fu?=
 =?utf-8?B?MnVORVJrbWNDMnNaQWZ5cWtob0dQTVZqUXNqd1cySCsrYnVmYWZvcWl4WXp5?=
 =?utf-8?B?RXlhdmhXTTVzV3U3TkRkc3Uwcm5laHlCckZ2L1U0azBMUWQ0azNaRXRvVmJa?=
 =?utf-8?B?L0lkTDZIdXUvQmQ3RUdyMU03RXA3dmx1T09jM2l4LzcyMlB2M2U3eW9qcWd6?=
 =?utf-8?B?Zm5YdEFaeDhISWk0eTBCaXJ1YnJaN0szL2hnU2FsdnZuekxUYWVTNnRmVUpi?=
 =?utf-8?B?MXJVZWlMQUNMeDhwYVF1ZTh4OUUvSFVaY3RBdzdLREVTSFFWMjRXNi9HTXIr?=
 =?utf-8?B?RkV0QXBYWGQ2Vm5qUVhySjMvUTd2RE1EaDFpZ0xTN2JDUFA5N09TcUdHaGF2?=
 =?utf-8?Q?UJLBm7gWe9nQ0UuY=3D?=
X-Exchange-RoutingPolicyChecked: HCFKnMY1FPZ18NurK2hL4MM1sJcEfBC05elCIhQupHu8uR4ztRH19FiE+iBUmN8cIah/jxZ4m0DILgGXOP8YkvCWbMyk9dRgNZqaE6w1rSUI1a99jxsXR+n+ll56vLwGmMY6E4B0xX9ubk//wZSfkq1+igrUpfbQ8LxNtx5CuK3k7FMvuhe5TcGZ4GH4Z3ZXlVpot7LvjrToY47qQgSo/6L0oYpuAbzKaOSiJdtVOSvOPLFHOvyilLWU5lB0otIDQ7zikkcyWas6mqYepyOus2FWSFjfjTsxs6DwVxLkMrzwwcsOqbQH8RRj8fbHYOdqGtSgdmHjb/FRLJRb6QTOMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 674562f2-4f71-43fa-1923-08df2ac8e587
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:30:44.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+CPgsbToMkhjuhEBGxp5jLBVIAJjRlz8DbWmul8ySQD7Vzr9VDEioRc2uZsa9qKAArqYm+uey3kiXIQe7ixE6+2Ll1GV6XhAd/n5nn1S0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8222
X-OriginatorOrg: intel.com

Hi Babu,

There is no reference in upstream resctrl but during discussions around
the "multiple controls" support we settled on a new subject prefix of
"arm,x86,fs/resctrl" for patches that touch all these parts.

On 10/1/26 8:10 AM, Babu Moger wrote:
> RESCTRL_GLOBAL_ENABLE_PER_CPU mode enables kernel work to use different
> allocation and monitoring associations than the originating user task.
> 
> The mode is enabled independently on each CPU, so the filesystem must
> program hardware when the mode is activated, when CPUs are added or
> removed, and when it is deactivated. Allocation and monitoring associations
> can be done independently, so the architecture callback takes separate
> control and monitoring options.

Going back and forth through this series a couple of times all these
usages of "allocation and monitoring associations" in different contexts
become a blur and at this point I do not know what it means at all.

> 
> Add resctrl_arch_configure_kmode_global() with an x86 PLZA implementation
> and an empty MPAM stub for ARM systems that do not support this mode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 38 +++++++++++++++++++++++
>  drivers/resctrl/mpam_resctrl.c            |  7 +++++
>  include/linux/resctrl.h                   | 37 ++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 62044489b052..a343dc0c71c5 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -137,3 +137,41 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
>  
>  	return 0;
>  }
> +
> +static void resctrl_kmode_set_one_amd(void *arg)
> +{
> +	union msr_pqr_plza_assoc *plza = arg;
> +
> +	wrmsrq(MSR_IA32_PQR_PLZA_ASSOC, plza->full);
> +}
> +
> +/*
> + * resctrl_arch_configure_kmode_global - Program Privilege Level Zero
> + *					 Association (PLZA).
> + * @cpu_mask:	CPUs whose PLZA MSR should be updated.
> + * @closid:	CLOSID programmed into MSR_IA32_PQR_PLZA_ASSOC. Always
> + *		written; required even when @assign_ctrl is false.
> + * @assign_ctrl: Whether PLZA should program the kernel-mode CLOSID.

At this point the series seems to switch terms from the "kernel mode" in
previous patches to "kernel-mode" here. Could this all be consistently 
"kernel mode"? 

On a similar note, the series switches between "global kernel mode" (like
in this subject) and "global per-CPU kernel mode" (like in patch #14
subject). 

> + * @rmid:	RMID programmed into MSR_IA32_PQR_PLZA_ASSOC. Always
> + *		written; required even when @assign_mon is false.
> + * @assign_mon:	Whether PLZA should program the kernel-mode RMID.
> + * @enable:	Whether PLZA should program the kernel-mode association.
> + *
> + * Program PLZA on @cpu_mask for %RESCTRL_GLOBAL_ENABLE_PER_CPU. See
> + * union msr_pqr_plza_assoc for the hardware field meanings.
> + */
> +void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
> +					 u32 closid, bool assign_ctrl,
> +					 u32 rmid, bool assign_mon,
> +					 bool enable)
> +{
> +	union msr_pqr_plza_assoc plza = { 0 };
> +
> +	plza.split.rmid = rmid;
> +	plza.split.rmid_en = assign_mon;
> +	plza.split.closid = closid;
> +	plza.split.closid_en = assign_ctrl;
> +	plza.split.plza_en = enable;
> +
> +	on_each_cpu_mask(cpu_mask, resctrl_kmode_set_one_amd, &plza, 1);
> +}
> diff --git a/drivers/resctrl/mpam_resctrl.c b/drivers/resctrl/mpam_resctrl.c
> index f2c651e9f6ea..0c8594e98526 100644
> --- a/drivers/resctrl/mpam_resctrl.c
> +++ b/drivers/resctrl/mpam_resctrl.c
> @@ -139,6 +139,13 @@ bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r)
>  	return false;
>  }
>  
> +void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
> +					 u32 closid, bool assign_ctrl,
> +					 u32 rmid, bool assign_mon,
> +					 bool enable)
> +{
> +}
> +
>  void resctrl_arch_pre_mount(void)
>  {
>  }
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index f6adff7f4e1f..dcb0beb847b6 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -752,6 +752,43 @@ enum resctrl_kernel_mode {
>  
>  #define RESCTRL_NUM_KERNEL_MODES (RESCTRL_KMODE_LAST + 1)
>  
> +/**
> + * resctrl_arch_configure_kmode_global() - Program RESCTRL_GLOBAL_ENABLE_PER_CPU
> + *
> + * @cpu_mask:	CPUs whose kernel-mode association should be updated.

This could be made more specific about being online CPUs. For example,
	@cpu_mask: Online CPUs on which to update the association.

> + * @closid:	CLOSID that matches the RMID to program kernel mode. Depending
> + *		on the architecture, the counter may match traffic of both
> + *		@closid and @rmid, or @rmid only. Always provided; a valid
> + *		CLOSID is required even when @assign_ctrl is false.

Above description seems to be a concatenation of different texts. The "counter" text
seems to be copied from resctrl_arch_rmid_read() and does not seem relevant here.
The "CLOSID is required" is copied from the x86 arch helper where it is indeed
required - but this does not apply to resctrl fs?

How about something like:
	@closid: CLOSID of the resource group backing %RESCTRL_GLOBAL_ENABLE_PER_CPU mode.
		 Always provided, even when @assign_ctrl is false.


> + * @assign_ctrl: true to assign @closid for kernel mode; false to inherit
> + *		association from the user-space task.
> + * @rmid:	RMID to program the kernel mode. Some architectures may use
> + *		CLOSID/RMID separately, others will consider them together.
> + *		Always provided; a valid RMID is required even when
> + *		@assign_mon is false.

(similar comment as for @closid)

> + * @assign_mon:	true to assign @rmid for kernel mode; false to inherit
> + *		monitoring association from the user-space task.
> + * @enable:	true to enable kernel mode association on CPUs in @cpu_mask;
> + *		false to disable kernel mode.

"false to disable kernel mode" does not seem to capture all that is required
from architecture. When considering resctrl_kmode_switch(), @enable being false
is only thing resctrl fs does to put CPUs into RESCTRL_INHERIT_USER mode? So when
@enable is false the architecture should disable %RESCTRL_GLOBAL_ENABLE_PER_CPU
*and* enable %RESCTRL_INHERIT_USER?

> + *
> + * This callback programs %RESCTRL_GLOBAL_ENABLE_PER_CPU. It is called in
> + * the following scenarios:
> + * - If the mode is active when user space changes the configuration, it is
> + *   first called to deactivate the mode on all CPUs where it is active.
> + * - When user space activates the mode, it is called with cpu_online_mask.
> + * - When user space adds a CPU to the active mode.
> + * - When user space removes a CPU from the active mode.

This attempt at listing all callsites is proving problematic since it is
already out of date by the end of the series. I would thus suggest to drop
listing the individual call sites and instead focus on writing a clear
contract. Consider, for example, something like (but please verify, especially
for accuracy and correct terms, do not just copy&paste):

	An association starts when %RESCTRL_GLOBAL_ENABLE_PER_CPU is activated
	and ends when the mode is deactivated or user space changes the backing
	resource group, @assign_ctrl or @assign_mon. Every call for one
	association provides the same @closid, @assign_ctrl, @rmid and
	@assign_mon; only @cpu_mask and @enable differ between calls. Before an
	association ends, it is disabled on every CPU where it is enabled.

> + *
> + * Contract between fs and arch: resctrl fs always provides the same
> + * closid, assign_ctrl, rmid, and assign_mon when activating
> + * %RESCTRL_GLOBAL_ENABLE_PER_CPU, during CPU add/remove while the mode is
> + * active, and when deactivating the mode.
> + */
> +void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
> +					 u32 closid, bool assign_ctrl,
> +					 u32 rmid, bool assign_mon,
> +					 bool enable);
> +
>  extern unsigned int resctrl_rmid_realloc_threshold;
>  extern unsigned int resctrl_rmid_realloc_limit;
>  

Reinette
