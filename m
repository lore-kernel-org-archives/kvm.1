Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792447299;
	b=sHTBnT29ewF3wcNwPbVwiy45shhNzPLbGRpTZNvRKyFPNamUgigUWzhmqzQUZT9b+4mZ
	 ixGc3wlwzw2t850o9EIFmOQWYX9aZzwRQtYsY4PTw7KxPlOhmoS3N6h2fquHHXNCG1cug
	 AHKGzg5M1L+aAoX2usORppqp19GDRn8Ps78MaMIaPAYpUEmFvRa+bUsdpK9Fbh57T6Axc
	 klBv3PbnZUU/KTLJA0owP8Ku7MgCBkwgDP2w/mlZivPqtQncBJMaaBFdh5BXbghk/a02d
	 ouLUBVwOBMG+TTM9wf1M4bn3Ms6hFEJgygeu8GosbKFXmiTY9UnS5/3E+vprG45T3Mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447299;
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
	bh=Gc/5AYxvk93o1Hq5a5r3yz6a/GCN3fiRkLK/ShkpayM=;
	b=W1vJzZBmaOCMRTCE6Urlp64wxbLZmLxQUVsrahUjlrFQd7uq2SH8uHgcZoXBtVjoLgSU
	 Y93v2X3gllcuwKOB7xC+TnRC1fxOPgiJOh2i2NWNJu/97g0BVHzhm8kGXFgimQ/x5VUqu
	 9cRYYDa7eEMFJ5h/ROF8tOw/aTeURJcUBiDpV494xgCJamcxR2CYE5ln4ipi0uDk6cSEt
	 Xp5Wg0wxs84eS+8ANFzfPuLxkxt6S17+TgIks32q4fHY3OW7IPLpjfjhktegRCMrlDfoL
	 ad3uhNsgevSOx3FtI64SBj1Fm4+xeAZRB5bn9z1rAJA02rSNMyz0ZaMspKCE3Xw72QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZicPEksU;
	arc=fail smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BDD606A31A;
	Mon, 19 Oct 2026 22:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46BDD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZicPEksU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792447299; x=1823983299;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2lSWiP2R3DDA3oApsjmO6p3GYCSszD9ZKcPzeMG2kGo=;
  b=ZicPEksUAIf025d0SUwnf8/H3Wp8C1jsUnp/aqYzwly9Lh71sUrWYf/t
   Y2HUKi2eGMTkXUYB/xdcHHcm0IiWUQ1hOT8N96CpaFEx6KFahgxdt1XS1
   8wYHpcsD7cQ2tselai9dClwtv8QtZeSjVc+nXT9vPQGO9sEUAzQGvWt5e
   X97E6X9z+sDSvL7dWZCTtLlzIOkPLPyzHvqZx1RfnuZPI/N9Ud9dn0tXS
   uozVLa7ZUttuxXvz1XE47D69CO+BwhjY6TFSpYtqTXVl93NSs2ZGcOO09
   5jzLePQfE6i7cjz5h4XxP/iHHhjbmqZLCkjC2NMKqjJP3mTppTeZMOrQH
   g==;
X-CSE-ConnectionGUID: 5anP6PLZQtCqzBaqB/2npg==
X-CSE-MsgGUID: FEm3DALxTwihZsjZ4yrNhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1047660"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1047660"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 15:01:37 -0700
X-CSE-ConnectionGUID: 2czgYWrQQ4eYqlQz3vFi6g==
X-CSE-MsgGUID: P8A6pJ+0TaOtv1dMDDbbmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3020697"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 15:01:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 15:01:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 15:01:35 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 15:01:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGvtvd4bFI+txc9KGn9kLDC8ZEavqQUapJLjXrxzXyVOrGL/LytFdZVPWC/p+Sp0whOY75TKXrgUIaKlmd+DjhAntFzYk9DKJhyv97hFfcbVHs2p8aou9qHCvEr5+GX/KI3CHqBsDG/zkk6A+e8zACLL+1ncjKkYoPgsJleMm6Q8rF0sa7mTe6roQZ+mGmtxSb1prnM+VGNdHrs0eReYzMtdbqupejmfWDPUt/U7RZYD6+VLOECVD/ay/lKIRyItNF5jH4wU16Le7dgjp/X33VGskeTJ3e6ylj3zXOdsG/ne8u0f+SHe//TEz5BG65vGpMBnbfzpfPX5zrBOMOg1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc/5AYxvk93o1Hq5a5r3yz6a/GCN3fiRkLK/ShkpayM=;
 b=UZcdZAtFB9XrMIHD2WzM27TGAK8nsYzpfYJTa9s4BKqGoGY8q1/6uNFAmi55rKLFXnM+/dTDJZx3xRDg909nei4kPEfUm+n+GWJmQgklJLJj7tRaUnXE2ZKWMejz0dsK8UO4hKEi8FqcDq5ZYb6EJK93ds+TxgtsmEjxmn7ZM7BczhDcn2FEZaWqeS0/NCerGyd5Tb9DI3F8J4GE2rJRlUdLKspqrJDrd6LzXEn2M3wmUowW5w5cw1Z8Evqq3O0UXQeMzg5s7g+kwbFeYjhJPO/D+ZQZ+9d6UdrgCVCQxzwI6azZR4ezW7BpPuL+f/uiHs/IjGnS46y9biQ4nDcWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by SJ0PR11MB4941.namprd11.prod.outlook.com (2603:10b6:a03:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 22:01:29 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 22:01:29 +0000
Message-ID: <e65c5f31-266a-4411-b7d4-873086451065@intel.com>
Date: Mon, 19 Oct 2026 15:01:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/18] fs/resctrl: Reject mode changes for groups
 backing kernel mode
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
 <d0392cc08e4bf28998a4815943525a0461003801.1790867441.git.babu.moger@amd.com>
 <bf296951-e4bf-41f9-b12d-3c20930cbd21@intel.com>
 <592ae38c-3e73-4940-9720-d23f396f83a3@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <592ae38c-3e73-4940-9720-d23f396f83a3@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:303:6a::23) To SJ2PR11MB8370.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|SJ0PR11MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6c06f2-2c12-48e4-e607-08df2e2c8727
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|3023799007|260925021911599003|4143699003|260925021311599003|260925022911599003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /2v95RIVXTjcCJCQxl6uRs4GwsiCyjGU7JU/GPUxI1u4/nHcJDD5wxgynhtVld/cIxl6gvWpHUnfj+6eaaSCMqXtnAtfkHw8Wjr80nktHsoiBusWyIO97QU90x0QcEb14EJBytMLtX2QYX//C7LAVIbXBSekA+tL1aCZcXVpk7t+SF+C+pdMPyTrT/Aq3XguudviOviSW5AWaNQPpvXEpgDnqINyWaQrQ0CHmAgVahDt8Mv3ZbqWDB9xbvYn47NJeExFETToRHm/ALh0V9kkybDPk8CqC6ZTBCTBa+tar1QLOj9eoB5BA/4iqqaLvcIjs5zJ0yi1RvInidzjaXAUb7GIK7x02Q45QaxHAQv6Us57H7NrU9e2siWkL+NysZcEhCySk0hZtyIrXiLiUkHqswBsxDP0EmXiaNayO9b0hyh/T0sDNsTkt9W2Jsv+dFBKWVLL3bRlZb3YDclHFkyBxh+4bTLo13GkcIBH/oMTu5Ba8YDnjJEbe91QSBmOeh7KCbCnd5+/vwoOx06ScH/Y66smdGT4w7Ks5NORU6JbhBgnSPkfMjpUtLvJXhzgf6VDv9pU4XAzlcWZrMzv+fIZmutnSgkKG/a1ZtWSJT1bB5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(3023799007)(260925021911599003)(4143699003)(260925021311599003)(260925022911599003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXQ5eHdkaSs1SHBTa294NHFhZkRlUUdaUnJjNHg2ZHhJQmlLUjBFV1BJZms4?=
 =?utf-8?B?Y29NR0h5TWlQQU1Xek9Zb1F2TUEwUEpCaGhxdWtKTGN1aS9FeUZDbDJvZUY1?=
 =?utf-8?B?WXZtUmJIQ291Y1Zqc1NNRUVLSzRqYWxSVnlRR0VLYmNZOEJYeHl6TDBpSU1t?=
 =?utf-8?B?b1lOcVh6cDU0OG1ta2dKL3dKNzFMeDVqTkg0K25mMGNuVC95R2ZBMHdaVVkz?=
 =?utf-8?B?MEg0eXdML1hsTHEveER5ZHZjZ0VQWFNzdUFSeTc0V2dnandvZGNrYXVaMFM1?=
 =?utf-8?B?MjY0WkM5YWRNV0ZxN0hRN3JlcmlXa1VEenhDZnpGV1Bwd3Q1K0NhOHp5WENU?=
 =?utf-8?B?QVhaWitPYUJLL0NhVnJpNmcwNEoyRnNodXlXbjJ5N3ZUSHRZdTA0VmRFVFM4?=
 =?utf-8?B?UTFWeStqYmY4cW1WRHk3K2JabE1ibWt2dGJlTC8wZjdYVWZJNGg3bUJOMmVG?=
 =?utf-8?B?R25SMTVFM3A0Q2h6ZkUzMlFwS0xSYXdtR0p5c3FpYWYzdG4vRjhhTkgrS1cw?=
 =?utf-8?B?NEtlTHl1QVVzTzZXMkNHN0RvV2gva3FGVTNMNWxGRXJNR1ZHSllmSVRmUWxh?=
 =?utf-8?B?S25Hamg2a2hGeVZlRUxGVEJlSVRLUVAzZ2dZS2thdXgwd3QvMi9lWThzdldV?=
 =?utf-8?B?U05VTERTcnRnUzNMSXVyUi9Fa2xzcW1CcnVlUWYveWYwRTlJRWZDWjFHNlZF?=
 =?utf-8?B?RmxtOW96MG5BUW5teHZUcEhZSVpUZEE5ZW03alpCUmRJanRBd2lzVjF4WWpT?=
 =?utf-8?B?cjJ5UDNmb3FWUkRFRzFIaUZucU5ITWZoS2tpcy9xMWo5OFpXeUVMeTJ4MGJm?=
 =?utf-8?B?ekIxdCt3SXFsTVRCMzRoTk11NGhLY3BtQ21rd1ptL3dRbFhpR2dVN1NWK25T?=
 =?utf-8?B?V3dyUGxmcnJsZ21lVCtGald3c3ZSeGhXUTAwSkt3a0NMWnpwWXRZTjhXREN4?=
 =?utf-8?B?aUpFZ2ppdjhMZkt5ZmlwT1Q3ZkRLajFTcFgvS1RLMS85a29lNmQveEZGRmV3?=
 =?utf-8?B?U3dYVmdON3dvcWpaRk5LaWdRa3V2aHBybWFtZXk4SDJZYjEwV2hDMkE5UWVW?=
 =?utf-8?B?OGYvNkdXcjVKZGMxblpEK0JIZE11Rzl3dm5UY2xNc0N0SGVpNjJ4S3pRSjMx?=
 =?utf-8?B?NENEOVcxQ01OM0FNN1JxS0JPdDcwSWwzREhla0J4ZUdsMW81QnhmUFcyS0xq?=
 =?utf-8?B?YjBlMmt2RHd5d3FCclczd0FYRVhwWHgvSzV6b3R4THpEYS94QTJUbzkzY3p5?=
 =?utf-8?B?RFFSRnR6UmFyRFIrNW1HUDIzbkR4OGdOK0t3YzdNWlhrVjJtekZVaWJaZU0x?=
 =?utf-8?B?bGJhaHBNSTVwSHc1ZURFYkRqdVFJYStBK09KdmRmcUdYcUVYKzR0dnNrT0hG?=
 =?utf-8?B?VzFpQjdEcVdJc1NjU1lyQ3owQVBVdlozQ0lNNmhVbm9QelNsYWgyVVBWZ21w?=
 =?utf-8?B?cmV6cUFMZVNlbk5TZWFsVG9jNmFmcVZMUEFaZHBwNGx6UGl0ZGFNNEdIWmE0?=
 =?utf-8?B?eDBxVU5vTi9YN1FKZFZ1ZHlkNlk2dUw4WUY4dnAyQ2R3Ykdsd09zKzVEWno0?=
 =?utf-8?B?cTZubWpyeU1XQjRXRzhhV1JIQkJLSzZpWTU5WnJaWVQ3ZlJQN2ZOZmFLZXlE?=
 =?utf-8?B?U0JqaXk3UVVqcXFDbzdxeHhkWCtPRGJMRTVTNjdXY2JXR3lPM01zMktHTERY?=
 =?utf-8?B?dWxTV2RCVHQ2Ri9rVzFGcmpwbXNEaDN5L0hqRXlaUGx4Y0ZIU3BnTEpJY0JM?=
 =?utf-8?B?Y09aQm9IRmdpbWRVZnJTNld6OFFtMFFrTS9ocnZYUjFNMXV3WXRHQXkyUkdG?=
 =?utf-8?B?SldtQWxCeGhGMG8vbzFZcnErbHZnbWRxVENGSUM2N21RaENOYkZza3c1Sk03?=
 =?utf-8?B?SC83a0g5dXROVjRiTURrYnFzYWRpUXpPV0FLYWdLMktYTTVwSytYSmNJSnVE?=
 =?utf-8?B?QzdLZTFWRzQzSExhUmM0bHF1V2sydkhRTWxGMXNTK2Y3MHd2dFBKK1dmWEZD?=
 =?utf-8?B?MHhYTHZqSkJGcEtabkExQXFXS2pDTTFCWGtoSlNkWmUwN2ZRckwwd0ZjbDYr?=
 =?utf-8?B?NFV0cDRLZ2JRZTNaMExYSXMrNmxrVG1IWEZvY0xOVDJFMkh5aE5tVGUwWmlE?=
 =?utf-8?B?VWMxUGpoWWUyR3QvQXFOUHFkamJ4K1h3dFFvWi9kaEt4eTlOc0wvQU9vd2Rt?=
 =?utf-8?B?dEJYUFRtVEZDY2pWUnFCVElGWjJnb0xOMWo4L25wVERhVDZrSGwrNGRFQjAz?=
 =?utf-8?B?ZXZBdVJtUnhVbDk2RlJnNERYUDBudSt0aUp4UUlUUmg3MU9EaVV4ekdhd3c1?=
 =?utf-8?B?Wk1yQVdQRk5jWTloOWpjVXA3WXRXakp5azNqZG9Va2JYNWlUT3dyUFJaRlds?=
 =?utf-8?Q?BldQJqhudv91qV8k=3D?=
X-Exchange-RoutingPolicyChecked: oGMt1jZzh3N0SnXL/omepq5o0TJa8e3koug0hSyattOHBxnE7/7OfQfI77d5ham7ZXhefO7ue5sq0XclM0FwhjHiVbjR7okhzgS/7569Hc6q/llOJhvTxIH804SZ5uTODqQso5zkle20Blvxh9mftMPUmeC9kQhRRtXroDrPmswsPZyfmKBOgYHVwlSRwpc4PbknE4l36jArCci9mhEl3e2uNXj0eGuxT7FFj8w+5fnCYTUrSN1UPavuSVzJWjFOUv4005EOIFKE1PBF/L3g6hmsA37vBPTyifzmM6fQqc0cme8b4r4sUwt0oBBxv6zeqpf/xINlrS+StlCE2vndtg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6c06f2-2c12-48e4-e607-08df2e2c8727
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 22:01:29.2796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TVTylIY1cz2F6W3ewQlAjPgGo1wYY8c9WSPooVtHWhIqQtKIuo8c5DsWtdzTAOr3KClbZzeN5UsHcXtgDtKWuavt1fw9FjYFBulBEHyU/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4941
X-OriginatorOrg: intel.com

Hi Babu,

On 10/19/26 10:43 AM, Babu Moger wrote:
> On 10/15/26 10:49, Reinette Chatre wrote:
>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>> Prevent mode changes for a resource group that backs the active kernel
>>> mode. Also prevent mode changes to the parent control group of a backing
>>> monitor group, and prevent a backing monitor group from being moved to a
>>> different parent. These restrictions ensure that the active kernel-mode
>>> association remains valid and consistent.
>>
>> "These restrictions ensure that the active kernel-mode association remains
>> valid and consistent." could this be more specific?
>>
>> This patch does two things:
>> - prevent user from switching the mode of the resource group backing the
>>    global per-CPU kernel mode. Why? The reason for this is never given and
>>    there is only a hint in the *code* of the *next* patch that requires the
>>    resource group to be shareable. The next changelog does not mention
>>    this requirement either.
>>    This is important to highlight since a resource group backing the global
>>    kernel mode would have all its resource allocations shared by kernel work
>>    done on behalf of *all* tasks. This makes it a clear requirement for this
>>    group to be shareable and for its mode to never change.
>>    This highlights that there is an ordering issue with the patches since this
>>    series establishes the requirement after it enforces the requirement.
> 
> This check is only exercised when userspace attempts to activate the kernel mode, which is introduced in the next patch.  I can merge this change in the next patch.

The next patch is already quite large. I would instead suggest that the
changelog of next patch includes why a resource group backing the global
kernel mode is required to be shareable. This patch can then follow after
that to ensure that the mode of a resource group backing kernel mode cannot
change.

> 
>> - prevent a monitor group backing global kernel mode from being moved to
>>    another control group. Why should this be prevented? Could the global
>>    kernel mode not just be reconfigured, just like when user space
>>    provides it a new group? This is a design decision that is never motivated.
> 
> [1] There is no specific reason for preventing it. I just did not
> consider it a use case. Also, changing the parent of a backing
> monitor group affects both groups because the kernel resource
> allocation is moved from one group to another.
> 
> If there is a valid use case for supporting this, we could allow it
> and update the kernel mode association accordingly. What do you
> think?

Up to you, but please make these design decisions explicit. Do not hide them
behind hand waving like "These restrictions ensure that the active kernel-mode
association remains valid and consistent.". If you choose to delay this support
until your customers ask for it then please change the message to something
that highlights this. For example, "Cannot move a group that backs kernel mode"
can be something like "Moving the MON group that backs global_enable_per_cpu kernel
mode is not supported."

>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> v6: New patch to fix sashiko feedback.
>>>      https://sashiko.dev/#/patchset/cover.1787772750.git.babu.moger%40amd.com
>>> ---
>>>   fs/resctrl/internal.h |  2 ++
>>>   fs/resctrl/rdtgroup.c | 35 +++++++++++++++++++++++++++++++++++
>>>   2 files changed, 37 insertions(+)
>>>
>>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>>> index 6b8d14c4bd83..84238e9e8e15 100644
>>> --- a/fs/resctrl/internal.h
>>> +++ b/fs/resctrl/internal.h
>>> @@ -462,6 +462,8 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
>>>   void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
>>>                    bool show);
>>>   +bool rdtgroup_has_kmode_global(struct rdtgroup *rdtgrp);
>>
>> Does not look like this is needed, can this function just be static within fs/resctrl/rdtgroup.c?
> 
> 
> Yes. The only issue is the build dependency. Since the function is
> declared static, it needs a caller in the same patch. One option is
> to merge this change with the next patch, which is where the
> function is first used.

There is a caller in this patch, no?

 
>>
>>> +
>>>   int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
>>>     int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s,
>>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>>> index 98451b417fe3..dcf9f26540d6 100644
>>> --- a/fs/resctrl/rdtgroup.c
>>> +++ b/fs/resctrl/rdtgroup.c
>>> @@ -1738,6 +1738,27 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>>>       return true;
>>>   }
>>>   +/* True when @rdtgrp or one of its monitor groups backs the kernel mode. */
>>> +bool rdtgroup_has_kmode_global(struct rdtgroup *rdtgrp)
>>> +{
>>> +    struct rdtgroup *child;
>>> +
>>> +    if (!resctrl_kmode.rdtgrp)
>>> +        return false;
>>> +
>>> +    if (resctrl_kmode.rdtgrp == rdtgrp)
>>> +        return true;
>>> +
>>> +    if (rdtgrp->type != RDTCTRL_GROUP)
>>> +        return false;
>>> +
>>> +    list_for_each_entry(child, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list)
>>> +        if (child == resctrl_kmode.rdtgrp)
>>> +            return true;
>>> +
>>> +    return false;
>>> +}
>>> +
>>>   /*
>>>    * rdtgroup_mode_write - Modify the resource group's mode
>>>    */
>>> @@ -1778,6 +1799,12 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>>>           goto out;
>>>       }
>>>   +    if (rdtgroup_has_kmode_global(rdtgrp)) {

Above calls rdtgroup_has_kmode_global().

>>> +        rdt_last_cmd_puts("Cannot change mode for kernel-mode assigned group\n");
>>
>> The messages to user space also switch back and forth between kernel mode and kernel-mode.
> 
> Will change to  "kernel mode".
> 
>>
>>> +        ret = -EINVAL;
>>> +        goto out;
>>> +    }
>>> +
>>>       if (!strcmp(buf, "shareable")) {
>>>           if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>>>               ret = rdtgroup_locksetup_exit(rdtgrp);
>>> @@ -4697,6 +4724,14 @@ static int rdtgroup_rename(struct kernfs_node *kn,
>>>           goto out;
>>>       }
>>>   +    /* Reject moving to different parent if group backs kernel-mode */
>>
>> Comment states the obvious. Could it instead state *why* this is rejected?
> 
> Same reason as in [1].

ok ... but could the comment be changed to reflect this design choice instead
of stating what is obvious just by looking at the code?

Reinette
