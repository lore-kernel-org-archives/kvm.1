Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792427758;
	b=tGUFJRYcMF2H9Kz/1jkWDL5Vc+mUgbSQ8wNZafXa78xUdW+sGquVxm8wlLfObVvRT0Yd
	 ktvgi9pW9PfH0kgl7fPYry+5SX/4Ied2OvLPCKO6NtPajErbQ8xmJ4JxkjqvqDKI4Dcmk
	 Oa2amwyaRe/Pxk3Oj10UW7RdJDalM8jewQKcWWncBrbH6Hmmcjn5SNYAmx7IvyHKz4IQk
	 VMjWfhs2jFsbdcdEPt0dch9ULwIwlNC/APtj7oSZIhTtHm06jGy+Q1IIbfgSQJsgQ4bwW
	 TXPxG0F1OE1Sv6lShyWCT3Ogei+bNeOTIwt3cQ2OIGygAv8X3jHPkikhR1ktpFd3FzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427758;
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
	bh=lO1olqq2bMlY2dvYZIeFtgGqGdOaDRWQ+vGNazk6Rd0=;
	b=T/u8Km+s/jfpvzp1T8iA2Ych4GeqnBgohNWHnh78tvCW+BREYExPCbot09UbS6FM79U4
	 0w7jjnI/VMonwS/Je/E/kepbjPwwKWD11ph6bTHRjRnEjL7brGSjYoGWmIZoS5j6HuqoY
	 LStUvSu+Bv2FF+oHuJqe97/zB3wA6SN2em/M5lb7HVUgFsPVfJH8BSiE2LjPjD9VKtoEl
	 r5/8yWCUN83uZxyaoGwSriEB+GSRjXRP/2WnEJ8ndyai1xzlkHtfUp9AUtTAGeKMniTT6
	 WLhW7sEmNGpSwOv94limElbwpBNkJdVBpHSKv+TjNSOa+IOdOOi+/NIXWKWljCrq1YA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mnr3MMF+;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0AA606A321;
	Mon, 19 Oct 2026 16:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A0AA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mnr3MMF+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792427758; x=1823963758;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yIprwDKdWFlCp64gzZw8TszXi5gFBn8wnXoNPoTm9Gw=;
  b=Mnr3MMF+SKKnAb5Qfrx4KfinSkW10u9QgYzu89w63HNOhD+HZ87EZnst
   jvHB2SULGVprV9Ze8od/PchhblcQJ1JydY6hc4VRDBrTtlRClf8GXdghJ
   KkoL3wr3Q0tF1P54qsJ2UQSGszluojSvjkc+4YAW60Fks0RfqdYoVS/CO
   JlqYDudTnOwNTuM3Sxczsx+QoaWio0n7/eQ2UBC0v4itGYGFi6taqrGKR
   XSFN1yVtLmR6suT/eoRkbwco5ry13TlwtsHGqt1Ir1GT4TRAfA+ofYXuk
   ux6WMeqajTMQFT8fEwdoWUNNqeGZjlfhqE6gYPZBNJ0wxhXTohsBN6fcj
   w==;
X-CSE-ConnectionGUID: PeBEEH+fTmSNVY8Sr2M6tg==
X-CSE-MsgGUID: JSH4BmsTQCKZr7QAS6F85g==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1217178"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1217178"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:35:29 -0700
X-CSE-ConnectionGUID: esa9wX7dRTWx4yI1YtpMCw==
X-CSE-MsgGUID: 5k3/0cu2SvmYJpUN/euWSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2563131"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:35:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:35:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:35:28 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORUP4NJwbNu8V9OfNjmq6I0ib5hODqw3rh6OZQVR4rym2KP0s+VoU2BCmD65Hw+mUEjc34DZxggRJS+a9icCJrHfz2bn0hpFyrVW9vjC8CownTdJApwqkv/2rkde48fFmKr/vEw4aLvIiCmVynK7shO0KI0RMxsmQV/z3cGCW/PvamJKgyibn2G19pZDV0GUEY1t54iToRVsoXbEvbWbV+xmdYyMZko0M1xU6D5YYrKRoZXK+njA5wRyqMIvyrxajRGZEC1Xj/Icl7a7ALt2iO853DXSJsPW4CXCERmQADQ07VVEQCdcPkR6WioV7v7yq/ZHrG+8H2snPJVlZ4eN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO1olqq2bMlY2dvYZIeFtgGqGdOaDRWQ+vGNazk6Rd0=;
 b=UWGJ6OhJrLBjhp5QtC4Dd9Oy/gFQfEYKf6rmKtcOdDRlAi/mVP8NHrCttIOwbhX+MNiJLVSY4/E3lhd1esaR2oFWRexQRm7d/6MrOYBF6IGx/9qvlRMopd/KFDhmHwryxFSAgbkvgEmwbP/01fmzzZ7lIyI+bF9afVzBEle5C7VX3QAGG706c00ES909XDxt+vfglRjOlO/bp9v9I1csnXorl28Hki8tBPB5PKh1b8yp/m/EgzVzMRNp7rwFt9QlKK25p733IgsaYjICmPdTd/3T75GPslqPUELgbV3y0233i4ZqlmHG674MjsWt+pDza459KVrOcK0lPVuvEofNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by DSVPR11MB997375.namprd11.prod.outlook.com (2603:10b6:8:3eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:34:51 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:34:51 +0000
Message-ID: <5050b433-09ab-42d7-b837-033b192471a6@intel.com>
Date: Mon, 19 Oct 2026 09:34:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/18] fs/resctrl: Introduce kmode_cpus/kmode_cpus_list
 per rdtgroup
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
 <54b0c60041902accde067b48bc3178c6756294d6.1790867441.git.babu.moger@amd.com>
 <0096fb82-4104-429a-bd69-7f733624c664@intel.com>
 <d7ba6551-adfc-4078-abd7-0f016d7a5dfa@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d7ba6551-adfc-4078-abd7-0f016d7a5dfa@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:303:b9::22) To SJ2PR11MB8370.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|DSVPR11MB997375:EE_
X-MS-Office365-Filtering-Correlation-Id: a108f56b-b2e9-4b9e-00c3-08df2dfee5a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|22082099003|18002099003|11063799006|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: eUYGKKzxQCWdGKquNabW0Sfq5lTY3yR2F0/CfXDb2QEao8CKsPUi3QL5Is6HxCRcDzqbW+CSxPRXK/HWkS1Dwu8yNILYyrPj3s8KPO5G/mC/ZBhT/Ssjk7AxOLrQW5QZ13edjlW2MFOEbUCK12aaPr44EXmsGJz7f3UzDFUWwiR4OAhEWAXsOO1odrZSZl+OVqclGMvfOadWhi9XmXL8+649V8QSzGUjUrn9vx0lCTONqnKH5pNBRHlpgeMtyqQIo5sgGz6SVI249qXvYJy+Nurq7E3LVjcDZWfz28toT308/Vi118tJHh1vL8n/gaQwL8rL2W0kg5IozQNUib8SrTHo2a9dE/1NPQL7A/p/a5EwiY3/JszK19XwVWnH3st0a0W7a3kj0p/xbi7ZgyzLVT0wGJuPXNiBTCRqEToGnZIAuounHawrJspVluM7UtN+mDZC59mQlnfwcL9X0zrxmOoJUUnKPJ6DZyS6PSulHfOjUEypMYLh3h/ZpnP3Cd9FO94RUNnsCvTfc/hg2GgHw1xrLjQ7QzH1YqVFAHOFDp325N9Rxij2oAQsAYlK/P3KczJmnwSZSv06gk41wDvKM2X0DFU10i3yz5dP8tb66bc2/YHYk1zsjP3JoM3mOYJe1dk98iecv1byuvYURN9nbvvRItEg/14CtwmQI4Ez6ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3lIS29YWm1kampGdmpnZEVXS1BLQk9YWU9nckFMYTFDQWsrWFBwWjlmdTd0?=
 =?utf-8?B?Q0FuMTFxalBlTTFXUk9SN3Yxby9nSm5uWUFqNFZnZTVjZFN2ZEdqejQ3WUZk?=
 =?utf-8?B?M3FGejNzT2FNdFBIUU52US8zbnlqenlqY0pjbFIyMnB1RHpTb0JLSHdlcEJy?=
 =?utf-8?B?R1E0bTBzTHVJcTBxL28zVHRIS0orNjV6TldZL25MTXNWZDF2c2Q2ZStrUW55?=
 =?utf-8?B?VnhKS3M2ZkdaQ3ZJOTlEdTRGK1RpUHVERHp6L2EzMXhNYlNHS3d5Rkx6b0NI?=
 =?utf-8?B?MmR3Q01DYWNCZ1FXQU14Qmg2Ukg4MHFLVzdFSjZVT1EyVzM5eVhSUFNRc0Zs?=
 =?utf-8?B?U0taaEo0RmxxS1hBUnU1UzE0MVhlUkNNWDV5dG1Ralhid3VvME9OUGZtZWwx?=
 =?utf-8?B?WU15YnE3RWxTR21yZ2tEcEhBRXNuZjA2ZVdGZDEwN1FoalZVZUI0bjJiZzJD?=
 =?utf-8?B?cVFqMG4wOG0rQ3FWZFpTMU55WDB3akxXVTZkUXFyT3NiUVdsb0dUbDZ4aU51?=
 =?utf-8?B?YUFScWJGbjd5T0tWcDArcHFMaXVGbloyeGNaWUkvcS9hU3N1UXlLV0JycjdQ?=
 =?utf-8?B?ejdJczc3TjcveklPZmhyTnFzY1RPSisyWmhqZjNaNk5VVWEzb2U2QWs1cmY4?=
 =?utf-8?B?bUVPc1ZRSEx0Y3Y4VG5Za0pOQjd6bDNzS2FycHEvZlQ5UjVqRGlIQ0hrU3Y0?=
 =?utf-8?B?Q09BZG0wdzR4dG1Zam9OWWoyWHdsemZrY2ZsT0l4ZDdweVBTZkYvWDg2R3I0?=
 =?utf-8?B?V2lWc3ZqUk5CY0hUc1NzL0VPN1hmZWUzSjh0L2drOXgvYjNIZk9kZmkvcklL?=
 =?utf-8?B?V2FpOGFrdW1pMnU4TGxZRjdma2JlSU9CYVpkeG0vb0xwMmhPNG1FZTArd2tW?=
 =?utf-8?B?aTNocUpyRXRqUWJXY3pJV2F1anl2VHpNNWhLOE5lYkhqa251bktOWHRvTmRw?=
 =?utf-8?B?UVE5aGhCMlNOQm9leEFiNFIyUER6Vk0rYjhiNzRTVXJMZzVyQTNTVDczcDhy?=
 =?utf-8?B?MmVxcU8rVFhlbnExRytmRFpUeDNvWFRJYWZHMjdzRTNGczNrdkZYSkdwSWV6?=
 =?utf-8?B?dG93UTRudGF5Ny80UmFXcGN2SVhRMlVZNXpzQ0haeTZaSEczcTBkSHF4bE5R?=
 =?utf-8?B?T20xRFoySlVwdGRkekU5NjNXSVg0RHNqalhyQURtaVBoNlU5OGV6UmxqRjZS?=
 =?utf-8?B?QjhUNVRNNnhkVWdrc0VxZFdnSGNKdUVWVWR2aWd5VTFSZjJnKzNRa3pXa3F3?=
 =?utf-8?B?SmtjQWgrS1JFbzhRT1NvR3JKRExDeGk1VWFKZS9YWEJQZmNqOXhVTlJZOWNT?=
 =?utf-8?B?VEw4QUtTd1FzZ1F6K1oyOGpMV3lvOGZCVklFNDFsQ0oydGFSZTV4bzJRTE5j?=
 =?utf-8?B?TnpNTFRSSHM2a04vWVFnQ1Fhd3laelgvUVQ0ZmtDRU43ZjhJWExaLzhPbERF?=
 =?utf-8?B?ZXNmV0Y5Z0pWcytzOVVPbTgrK08vOUNQaWs1anFSZzZTVWlGZkFTOERnMC9s?=
 =?utf-8?B?SmFpTzYveXRWeEhEUEdyZ0NKUVFic05jSFBPMmN5cHFsVm5NcDZibEM0UG5F?=
 =?utf-8?B?dTlSQkJYQWUzcGdEM3J6QTVmYjZ4Ull4SzFDc0pZNWZQWm9GakcyYTEwK1VM?=
 =?utf-8?B?eFcxMlpIbzhiUkY0L0JKaXVBQlI3SEZDOGo4MmIyVDE1a3k0dDluQnZDemNI?=
 =?utf-8?B?NUU1aGRmR3VCK0szb3FVc1JyZG9jYmNkYmVhRXhPUG5rSkZqL3orbkFPeC91?=
 =?utf-8?B?S2JOeENQVjdwTUd3UDFFZTlEcEl5VURYTUFDZWJsN24vc3lDMS9UaTYrYXhX?=
 =?utf-8?B?WTRhczNzR1JyK1FBTENvUmIyU2JuWkpFc1ZYd0JoSVBCbko2NXVob1FVYzZG?=
 =?utf-8?B?VXkwOVRIV2R0YUlzenVKSDRKdEZOSmNrNTM0WkRIZDYzdm9NSnJwT291RmlZ?=
 =?utf-8?B?Y3E5a3gzamdQVXRDdnYySklCMEd0T05WSVZRMkdOQ2daNm11bjlhTVl6cmdZ?=
 =?utf-8?B?b1hpb0pGNWFPYkhaQ2tOdFRvRTFSdTlucUZRTmsvQnNwcHB4MVdPaG1jbWth?=
 =?utf-8?B?bDZ0bUtTZllFMEZYY1RadDh3SFdBR0lMY3ZPSlpnL1EvZ3NIb1FWUzBLQm1Z?=
 =?utf-8?B?WHV6QUlTMlhHdTJaNi9TSFVHejZsNzRNVTMxVXF3UExoYmREUmc2aHAzWnhN?=
 =?utf-8?B?dlRJc1pSUmdabUQya2JTbHpaNUNPbGZpamliWjBWaE5KdTdhbFA5MTlHaTNn?=
 =?utf-8?B?UnlrcFlhWGVTWXdRRWJGU09aQklaV2xZZGkrZlFyblprNklISGErM3ZydGtZ?=
 =?utf-8?B?Y3dEdUhQN1Vkbk5uYzVZZVdJcXUvRDFEZGIxSnBVeUtDWDJ0bER5dGxxc3ZH?=
 =?utf-8?Q?NpX4PSHPzAvzsWak=3D?=
X-Exchange-RoutingPolicyChecked: K/+BlHTr8wkEZ1kDeu4w+v5QsCYcDfQNQ7a5FGIKUZo9GHtIEu/rJwvOvLmJj8je8GoGnXnz6ZNhNvKnqSTDl0ZBrpCSEvFauOBlCqbFQ5EkFrX12k87Cr6fKO1yLMHbbr2WOEWIQDK4dA+op3xsuD7L9ZoqMVkLFNMf0ajf6mpoxbQDYuRiprWI8HpzRryGuyWwTFBkLcr+2U4AsWn1OpECaYh+U5bgUAT+AwDWpxZsaDKaHSVPb1YbNyFfbDT3AIY7CCa9ZpFo0ABnY4PQoNubfERKgcH9NY4W7SSbc7HdR0cAZCEorG9bQ3HDAZPCkfI5St+ha6nBluUbVCEjnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a108f56b-b2e9-4b9e-00c3-08df2dfee5a9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:34:50.9778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhKs/q/szYqNHgRCrDMUz3P8jFCGo+i8f25VSNTEbGrwwFII2BjZjkU3rmc6ZQmJ0KDUJg6Wuakh1CNeSAy/TLz/szTADlG8f2OxEiRRlu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB997375
X-OriginatorOrg: intel.com

Hi Babu,

On 10/16/26 2:33 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> 
> On 10/15/2026 10:31 AM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>> The RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode allows tasks to use different
>>> allocation and monitoring associations when transitioning from user mode to
>>
>> Could "different allocation and monitoring associations" just be "different
>> CLOSID and RMID" (in places where this is what it refers to)? Being specific
>> and consistent with terms would make this so much easier to understand.
> 
> I avoided using CLOSID and RMID terms in filesystem specific code. If you are ok with that then I will use these terms.

Why?

Internally resctrl filesystem has a CLOSID assigned to a control group, RMID
assigned to a monitor group. When a user assigns a resource group to the global
kernel mode the kernel mode is implicitly assigned a CLOSID and/or RMID. These are
all part of the resctrl filesystem design. What is the benefit to avoid these specific
terms when explaining the implementation details?

An important distinction is that in this feature the CLOSID and RMID values originate
from a CTRL_MON or MON group assigned by user space. Any architecture where there is a
dependency between CLOSID and RMID will already have accounted for that during the
creation of the resource group. This is something that should be clear from the context
when referring to CLOSID and RMID.

The resctrl fs code even uses CLOSID and RMID in the API used to interact with the
architecture:
	void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
						 u32 closid, bool assign_ctrl,
						 u32 rmid, bool assign_mon,
						 bool enable);

The only place where we should avoid using CLOSID and RMID is in anything
exposed to user space since CLOSID and RMID has different meanings on different
architectures.

Reinette
