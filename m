Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792606734;
	b=A4jQOT5txNB05f/IgXdU/hIDlOU+/gc35tHXlUCDF6li9sOFt27hQ+b7um5CBmISgF+q
	 oer6JRQoekRHJPGh9PQa7moA7Dwd4FHUhk3JzxI0cg8Xrv9KW6pNPVW3HJ2MCpYd9sm0N
	 /Tl5O9xWs0lCQN8gj5lq3xuaOqXYirtQn8+bfPAkkmwG4w12qFsArdXztEIASu2TnvQ0u
	 H7tCV+Y441c4JoBQiIJXGH5N9K8641lc52nXIQCv3nl70U/swgFXBMO5Akg0BiV3jZBKo
	 bP/ikqfd6iTWHiw9QOVbHFra87UoGSxYVG83BGFxp8zxtd9DIDtwSuELTrmh+Pk+0eQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606734;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Q8IsY4QKhaRmHEivAWyPn5uOTNbmU8iHzsHxNPCISHg=;
	b=l8YIIoZU9RUcrS7boDe5p9ZnbJ8q9XVaA6VCNcloYN5ZIr+Vqa7b5ZUqM3qS/JPf0YbQ
	 6BtrOtBNlqJxUEVXoH0KaKOsqMPm4RhjFwZyh1zqU8koQmI2jy2RykKblGUv3tAC8jzA7
	 FSkxtqwjWfgCjGiPA7IpFLWkIb/ibkQmCoDxlzRhdFk+OGX1t+ysjD8xLl9Gyw4XSKyHt
	 pgwI4C/Qq0YITQrsAXNcKEA9sOevUFYT12FaVT1mQwXnffbuK/Wq8MZ07mzTXV7VZ+a4w
	 zwBYs6Nzu696+kGc0Me/FtKTQwb397priGb7qhv+6ImIFWhueZZXbQMS5gcZ1dl++Ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hdTXDKU+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.65
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952DF606A319;
	Wed, 21 Oct 2026 18:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 952DF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hdTXDKU+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/KbzzLRyQLE0d919rs2k9iratVbpVIUX/SRgCY3oACtC9RIenohHAxXI0r7JYh4dLXd6XA9M7d+dZs6l9T7U3jcTdXj86thEFj310i5WOacwSeMR8VlG1P4ZmdhZrF08/siCYrdei/3bRt0aNqeBydkYSiSC5RD1NGF81ja+cZISE/6ZwG5o6qFQ1++O3J++5CqQzLjYQ/qstj2IO+flKFExMZaXNgwUCL3Ot6rOf4SLeIwxOeZx3V7wzIMR3vWQZ3dCaheqM+vdn8koUeojW7+DnpvLeoNfI/tk1Cu5/zsL8FVJU/58ktxvBChvd2FaRUddHf4XXoQIm19eyOAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8IsY4QKhaRmHEivAWyPn5uOTNbmU8iHzsHxNPCISHg=;
 b=uylwv7bPx0jwvYyJqFkm6Rou/T8s3R7pDVqkgZZbg6cjSwxaTRXhQGXSlShIloq034KnOPlzMshKMnLtmxq6pg18SEm9uQ9h6xjtd4VTVpsqcmxhfsuOic9TQ/UJY5lnxBoJwnvA6wLDEehSsQwrt3/JSZPbAi2US86yFDl6AEG+5ItyOlwP/s9u5qfL1lpNml78vIK3QumKWGgeNaPKfnPmUy5q+e3YutuYSVwQYyEPrIv9QRXulANJviPbPqL71IseOqEK9+8gzc3hi/CsgT61mHqzrEDzQGq2DR8OoIjhGSvsE08jBnymizXkwB9SloVV/WdWEryD0EkzAO6wRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8IsY4QKhaRmHEivAWyPn5uOTNbmU8iHzsHxNPCISHg=;
 b=hdTXDKU+f875NO8/Vuwn9IiW48xO1Nvz0umPY2hiajE0uCdNE0Og9TMg9D71zUk5qDeRpYaSlK8cfgTezL45Xh5gyGlT/dDaUx1Gow0VROYnuZV7ipTpDmtNWyPcUHuvNqqbHr3PQAU20oATAEaPn+8gwwwRAy4Mz5J6Lxd5QFM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 18:18:48 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 18:18:48 +0000
Message-ID: <29da4bc5-5791-4067-b07d-dd63e43fe11f@amd.com>
Date: Wed, 21 Oct 2026 13:18:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/18] fs/resctrl: Control visibility of global per-CPU
 kernel mode group files
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, ben.horgan@arm.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 fenghuay@nvidia.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 akpm@linux-foundation.org, rppt@kernel.org, dapeng1.mi@linux.intel.com,
 elver@google.com, enelsonmoore@gmail.com, jlayton@kernel.org,
 kuba@kernel.org, ebiggers@kernel.org, seanjc@google.com,
 ewanhai-oc@zhaoxin.com, binbin.wu@linux.intel.com, peterz@infradead.org,
 ashish.kalra@amd.com, superm1@kernel.org, chang.seok.bae@intel.com,
 prathyushi.nangia@amd.com, kim.phillips@amd.com, ackerleytng@google.com,
 elena.reshetova@intel.com, naveen@kernel.org, darwi@linutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, eranian@google.com,
 peternewman@google.com
References: <cover.1790867441.git.babu.moger@amd.com>
 <28d7e4484c93d899ed86ddafa13faccce0dedca9.1790867441.git.babu.moger@amd.com>
 <c600a240-ed11-4e31-b3c3-779f01175f28@intel.com>
 <e1753b90-f22e-4708-8c2e-0e1d2e0f46dc@amd.com>
 <91e0e000-7e37-4e49-95cd-76062097fb79@intel.com>
 <345e3647-5bdf-4cd4-828d-bd28e0b66cac@amd.com>
 <cfeba010-4fde-4d5a-bb9b-d476cffd6ac0@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <cfeba010-4fde-4d5a-bb9b-d476cffd6ac0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:610:119::18) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f22a85-e161-48db-4e2b-08df2f9fc050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|22082099003|18002099003|261021123027099003|5023799004|11063799006|4143699003|261009223027099003|10067099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	RGpWM5ERuFpRVKwxzgCcu8BKP8WpSc9jdzMR7WSZ0a/BlFZFk1BflZj4/Jjc4vAcnQmIVzczMyVpWA//K5m259wwe/HoJnF3fk4Nm7TLOsFYD8WuV21MRT9axQdN+SUY+5Z4P4NT5CDDpHWQL21cyLLasfPOQRZsmRcM4dmVmlfASfVrebqMHvdhbrP9TfI64fMS4MVJHwngdp6S6iGf6EbiEJiScSREPp5fSQND9euF2wsFWrw1sva767S3NhxdekHvnPSq9wowP/o/4t9QFXG+G00kLSfVTTvCite0BWp8brHcYWOiULdnMqxx0TOoixlQcTAVac00YV7HfSPX4XbOAzJCze+A7iKR5BViN5iEE/G152Boa/8bC9Db+5IZA4UQ4TbGBl+FP/tRqt01/DcVVhGejuLonqryNXjcuAcdTggKon/FaZa5G+MjXX9NI0pF8ul0RUFgGDVPBpcIbzRmNM6TOgxgXM34MSok65dHL6/IiEJYYrhfrgnkLmI2mwueBKrDu/bXMXKuYoU3p1yUUxZE7tqvwTKCXLsyD42mvheWLpRVlIV7aTUDG3xa8Q99K/ocDcB82hzoVnpMo6QGskjI91McmagkoAinK8PDSjRvJYWhinLHbOMLVbuUo7PUQjFEP52If+ox3+W3OPWioiKZrIgBOx/ZCNokbYE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(261021123027099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmtBblkwbk1kWmk1SWV1Zi9XbE1BQTNCTG5wY1pUUFdpVVZYR3BRSWxlQ08v?=
 =?utf-8?B?SzhvNXNqQzA2eGlOTDYzVHkySTJIcWVXQmprTUZvbU5JQUVaR1Y3ZHZld1p1?=
 =?utf-8?B?REM1OXdaY2FPd2dJaW1DQ0dFdDJJWDN4TnJyVHc1V3VPSGg5N1JxODVUK1dO?=
 =?utf-8?B?VEJHQjRhYWcyNjZTQTE1aVNyUGRPMEVueHZ2bEZGZjZNQjNFZ2JOanZlOXJ0?=
 =?utf-8?B?ajA2b0VmT2xISjJVYnBXMm1sVWR2K0k3Qm9FcnJHejljdHo4NFNNbHY1ejRn?=
 =?utf-8?B?a3VEVStpNTc3bW55TjA3elZzZjFsUTZob1pqVkNFMVEwbWhVdk14ekFIRmd0?=
 =?utf-8?B?ZXVlQTJVM3RrZG5Xb21vSE9NWHdqYm9pc3h4bzZnQzYrSCtxeXQ5U2VxWHZC?=
 =?utf-8?B?aWg3aFhwQjV5TSt3NVBIRytJaGFTS0k2YUZwem8vc1BaQVVIQjVCRlJWaStF?=
 =?utf-8?B?SXQyUGNMODJCSzRyYU10c1N4ZzRQanQveGhMdE9ybVdFN1NPSkxPSFZKNkR6?=
 =?utf-8?B?NUZkWVNNYmN1UnRQRVRrZkIrblZrL3BveEpNR0x2THUvVllZVDlaQmxMK09B?=
 =?utf-8?B?R05xUG0wdzNPY2VYb1pDNHBaRkNXSUxSVE1rNkd0MmlvWm9ieHNaMnBuTlE3?=
 =?utf-8?B?eVAwY1FuK1VNaHduMW13WmFzKzFvTGVTNjFTMSt1RU8yRFJaVklhOUovR3Zj?=
 =?utf-8?B?QUVZeFdzQjFoY0R1MkgySFNyaUdxanVuaUlNaWVSM1hYbDlvNEFnQVRyTTZ3?=
 =?utf-8?B?SnpxNEFEZFNESkJUd1ZJL1ZBc0VNTXNieVowKzJ0eTlaOGt0bVNPOE5WQ2JP?=
 =?utf-8?B?elNVYmFNcFBQYkhuNVVSblZsL2RNbG10NmIySEllQmthUURGN0VNYlR2NU5E?=
 =?utf-8?B?VTUyU0RlOHIrNnlxekFtOWRKSEJLVmVxNzBmNFFULzJlTk1xbkdMZEl5MzNx?=
 =?utf-8?B?b0gzNXFQQ3U2Mm9OR0xzMU02bFI1SGZTZEE0T0VBZTl1S2ptMHJsZ3ZDNWIw?=
 =?utf-8?B?dmwxM0wrZTFLRjdnUmUrbVNHTUtHWElTUVVpc1ZkWWtEMlVpV3RhSU9vN1c0?=
 =?utf-8?B?TS9NQTM3UFpVNWNsMjd5QVBDMnRRUlVneFRiWVUySWRhcEc2MjJrN3ZZZUV2?=
 =?utf-8?B?TTRnczh6cjlnQVJjOUhCclhQbXlzcXU4eE9GOGZLSlQzSURLcks5MUl0M2Na?=
 =?utf-8?B?WUNnVXFwUElnUnI0ay8xQ09KTVNMdWZIZ3liNU1ua3dtK3RacWUwaFljZWU5?=
 =?utf-8?B?UmVYR29YVTk3dmNSMFFtbThmbzZUY3ozeGxHTVpoQzhPQ1ZSb21Wb0Z2QWxF?=
 =?utf-8?B?TU1KdjlvUG1tOXNhTmRoRHZ6Ym14UjQwTHVvdG9LbzJqK1AreGtFTU1VWFhh?=
 =?utf-8?B?VmUwWXlRUWdvdWVLcG1yb1FCb2pkVUxFWitCckdQOFlBZjZTRzhwSTVsck40?=
 =?utf-8?B?WTdzbmgrUml3dWVDU3BTYmwwempqcVdzTy9vVG0wVU1kT0pEdXdKM2ZWdCsr?=
 =?utf-8?B?WVhNTGNrZExhYldDWmVwQmVRRFMvUjczMlpwbUNlWm1jMnFOYjlFaVBOY0lq?=
 =?utf-8?B?a01PUDQ5N24yWnYwQURLM2pKanZmbXVvWnRhK3o4cHJrZUlLSTJOS1d3aDdO?=
 =?utf-8?B?aHlpZjRob1VYNllWdmxNUzc0WFBHaFU5Z1lLUis4aEJlUkROa1NGbXVSYStZ?=
 =?utf-8?B?QU1vdzB6WEtLZFhTaFBpYTVFTFVxT2JDeTZ5MkU0dzBiZS9NWHowaFJVTGw0?=
 =?utf-8?B?VUJBVUJ3RGhsYzA3b0E3dWl1RVBuNUZDSncwaXVuRkJVZUFENmh0Z085U3NY?=
 =?utf-8?B?L0x2OVdCZHZ2aHdPbTcxdmhMZUU4NDZPRlRrUlAzMlR1YU5UNmhWcmVpdE1O?=
 =?utf-8?B?Rnc4eVcrL2EvTDEySm94cHRhLyt1RHMxT0hiV0Jpc25RWklEa2p1akUzYWJi?=
 =?utf-8?B?Qm5SUU5OTDN1cExzL2xXOGFCZXI0Y1NsbDR5eWc2Wk5IYmtld3BmU1hPby84?=
 =?utf-8?B?bjJzMFEzRVB2NkM3Z1FGVm5JRGQ3VzgvMGF4TjU3QktVVzVDNTE4RzBrMVZB?=
 =?utf-8?B?MkEwNDhkVHY4cC82MGNvRGtVc1ZMOG9ieUVpUjhxT0hWMlhwV2hFVXMxeWpi?=
 =?utf-8?B?RVIwdTFlVGlQc3BzWFl3dDhCeUl1ZE9CRTBqSG1KcnpHQ0VZUjN3YU5JNzh0?=
 =?utf-8?B?WU5qUXlpbnBlVGlBNVZ6VFR4MnZWYmZsa3VtL0hzUEdYaHRMc2MwdEowZVcw?=
 =?utf-8?B?aEZzSERIQlBXc1ZrY1Q1TDBMT0l3QnZ4dDFZRVdPSllpUy81TnpvL3E2Z2lH?=
 =?utf-8?Q?MErMRrvdhrpk6aDU4u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f22a85-e161-48db-4e2b-08df2f9fc050
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 18:18:48.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aixq1uweWMl9tWSrSSAmFASyNnGdqF3EiyJqayHcVg6K1AbIx2YfZInNYyOaU8Rs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

Hi Reinetee,

On 10/21/26 12:32, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/21/26 9:59 AM, Babu Moger wrote:
>> On 10/19/26 17:00, Reinette Chatre wrote:
>>> On 10/19/26 9:31 AM, Babu Moger wrote:
>>>> On 10/15/26 10:46, Reinette Chatre wrote:
>>>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>>>> The kmode_cpus and kmode_cpus_list files are specific to the
>>>>>> RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode. These files are created in a
>>>>>> hidden state when an rdtgroup is created.
>>>>>>
>>>>>> Introduce resctrl_kmode_global_files_show() to manage the visibility of
>>>>>> these files based on whether the global per-CPU kernel mode is enabled or
>>>>>> disabled.
> 
> ...
> 
>>>> per-CPU kernel mode. Hide the files when the group is no longer
>>>> associated with the mode.
>>> Could the patches be organized so that this becomes a symmetrical change
>>> that highlights when files become visible and when they become invisible to support
>>> the description within this changelog?
>>
>> I didn't quite understand this comment. Could you please elaborate?
>>
> The subject claims that this patch "Control visibility of global per-CPU kernel mode
> group files". The changelog builds on this by stating that the visibility depends on
> "whether the global per-CPU kernel mode is enabled[sic] or disabled[sic]."
> 
> The patch delivers only one half of what the subject and changelog describes since it
> only contains the change that hides the files when the mode is deactivated, the patch does
> not contain the symmetrical change that shows the files when the mode is activated.
> Having the "show" and "hide" paths in the same patch would make the change symmetrical and
> easier to follow.
> 

Yes, Got it.  I may have re-arrange the patch to do that.

thanks
Babu
