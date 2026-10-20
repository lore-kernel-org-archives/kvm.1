Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792533623;
	b=Uo+vZuVej4KKIDTcTgVPB5zlAQI7EnrQSQ3dHEXsUU+ZR+00h3x+1OhOKZa/wOSl40hq
	 1OKPBEj0DSveUMoVxlhzWrZbl9eHNM0TxTIlJEEqlpBDGtEdxA0c5Xli4ZJ9iw/AyKyTR
	 WKBLvHVkXy6HysCX78gq6cR/EAl+ppbeygqDGqPQBHHQ3fdiAEmbmOl8C8/MuaiMZecr4
	 f2+OvYqdyoFOo+rR0fKVISb9zzYLerYZhe9+S9TEt4s+ScFS9QXGxNaMsNcs3qruSW9+n
	 sDoZBd4mIfCwxmUmKWJfBBrHI9Ey5eKEbxJHloRWqXlw+1H3Xiy3tBbYbyQX+6f6Wgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533623;
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
	bh=Of4KDDGZQwzpAjpTjihD9VVxVGe5PGvM3fRqHxVTMaI=;
	b=EnZuwoPlrx78nlH1xtDOFHO7ZBIesxaGkSdFIPFYmVLG3m66BrI4S8PPtHtmgv+BY+wB
	 wjPoNu15zUGa0OX9h6AhLBvTQB44rNvlIsxbVocbmPYdKv0e96e2YUDQHt8IAZfPf1tIv
	 MYTSb7B9qHjDf42Dio7XLEnhDW8DjeT+XbjSDzis2iaD1XRWaC0NT5kzWr+kuibCYtjuI
	 2WqY8SQ8Nx0gd94D2mKRv2JMaRb95qUuI4NbZvucg1ssmgKI5HCFiwsiwvqFteaUst55/
	 /hwJtalfXBjFmaootIgfkpE+Y7D/VssdVR/Vi874qc+M5oQO15k4jeJ4SboGZKjzxyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ICU+ckiT;
	arc=fail smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7767606A31D;
	Tue, 20 Oct 2026 22:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7767606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ICU+ckiT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792533622; x=1824069622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FTzXItDKLxTntyvUMGThxpEuGMmOq2WnghYl6hgPV0E=;
  b=ICU+ckiTeFJe9VMbBB5WD4L01M20PvaFaS+AneQ54cetWfcJ2evEdEWp
   FoLHXMPJTuiDJKZI8YtoTPHGp/G+z3+dFNiNvRln6RBHJmETutb6vaeOn
   gr02slPG3WVZySn2cR38UXFRtd1WQhkBCWp6bOjL2NBPOVrhO8AdnyvUX
   9U2xnt6RCcluChz8Sx25QlBKUMyC2Zv3Wyr9MOcltDuGQaemkTmS7UgOU
   Pp1uNz0HffdCoSYXzT1DSRie7aUb1vh/lMzq2tzy2IUqAojeTYSOu8Ni1
   b1XMaD0DG3URco+N2dpxVNvmh9vaJZCZ1hviprAATia7ZCvzGEhFscBIu
   A==;
X-CSE-ConnectionGUID: bbnjx8tuShyj0lstuGXt8A==
X-CSE-MsgGUID: qxRZ20usRi2hTmnIlsOFEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1137119"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1137119"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:00:21 -0700
X-CSE-ConnectionGUID: wZdhaWQYSZqgk1dhxDBT6A==
X-CSE-MsgGUID: i/0TMTCqS9a6drolZ77CBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2810973"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:00:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 15:00:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 15:00:19 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.32)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 15:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu+zPT2WJ0L41PkEk9FmmLqhGHew/UQC9HKxMRnyMTSE8YPfQs1OkbdkAN2u22SNi32yQVAsOARvzebHGWBIQ6I/cosoFdc8qdfjX4VlynN7Xh7HE0nZ721nCoFBvSFgs2lmVa/fBBONo5lq7TxX4ubXyA4h7vrureSDLbOJblNf8irVKFcZFWu7TN/eZyBikzouGLs54I/UVprcZ/9L7cVZrCPCp8SAm1SJHeRcUUcsoAqu9K7XP9VB246BLwr76vQzEdqUQsqqQb7lK0vQCaNK0DVh8+Cf4yHBTDzE0Ah8BtPjYAMWHmP6tXuFz/x80o2rlj63B991eVq9OOehXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of4KDDGZQwzpAjpTjihD9VVxVGe5PGvM3fRqHxVTMaI=;
 b=V7ztYIi7ThoEbrnSG5mu0br3ic5Bh2MO/f0J1yef1qrOoFlMQ5Pzqzar92vOLStzQ6hIIwJ1xvUvM+/37M9VuRLNlat0ITDrodzzJ1oj4GyZkj3sSq2b5lrt+cCwlEgbr+XKvegKByvgUhLYnKeGB9K6w0i2eBWZo5GX/v6E1yLcBuUSYcSuBVEKApqZZ9VeK7GAUlMUbbVKksxfPpZo6A8kvPxpF6PmZ9/PvtNCGJ4v22RoH9Tyv5xtnt2JaAark8dKpmgqJxzbRYOZR3PSKiLB/Qt7gJ59b9Jc+tbleOGExtWT6P1lAY3YIU03bDjkrGomFpXUW7upW1xp8+qrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 20 Oct
 2026 22:00:16 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 22:00:15 +0000
Message-ID: <61310642-1721-4b61-b9eb-cee60e6f35b9@intel.com>
Date: Tue, 20 Oct 2026 15:00:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/18] fs/resctrl: Add support for hidden resource
 group files
To: Babu Moger <babu.moger@amd.com>, "Moger, Babu" <bmoger@amd.com>,
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
 <9e770ba6dff365f823e702430ec3872709bc92d4.1790867441.git.babu.moger@amd.com>
 <0ad861e2-1dce-4179-986c-872a33eff38a@intel.com>
 <89715865-895d-4771-a700-f1a8aaa385cc@amd.com>
 <8b10c05f-eb3c-4ce3-8580-1cb034ad4e18@intel.com>
 <c100cb3c-7d48-4bb3-b25b-0fce88de0561@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c100cb3c-7d48-4bb3-b25b-0fce88de0561@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::29) To SJ2PR11MB8370.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|CH3PR11MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: f2048101-2c70-4b70-c182-08df2ef585b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|56012099006|6133799003|10067099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: wquO/fdCrmFfjEFfsNMs4ZEFbZdFzpzr/t89ANHpSdvpIPmDPJP/EO0s2877xuS3kHMbCuGrQd3Qa1iJvknY+9xXgfZRZT8s9hUrmi+kNoLt+oBgtJTyG9DUqm1umG1iLOFw3JxfzRvQzPjzT9M9GDRScwpZvu4KWbBadr1kN3Jh61yKxXc0MRBMIva1pkQaItWw+KGdoXhD4RpzI5YxG1wmPy8mLRdf6VFFy4hHV7bPxaRbN72y7lNbByLTwXRp7an6+bIoXOtPdgVXuT7+wEY+42RMPHVa80VzTwtbypsgZvZEGwVnDUkbcwb8dWczm0zKec4ejtTUYFTHdojE4GJUGE7Yf63GMBkGQrfybX9QCMtzwadA8N7DHoxOmOl5yJGkVWiGqanX5Bw9aiotgMyItSn1KEqKewbODRvDCWiLLPQOXBOCgpdHJ8F77J97A425oiLHLiUxyHm4LvmefYfd8MZrgAUla/G5kwDIIiOnfslxgAy5e31bSBuJ71kPcZsyXechSoxKqcUQP86WZ7AcNXB8yLdghGkwbJxxBHuCafpNtPNwrhhHxHjsrYbooMa+9Ux7l338mat182oAZ8TwiPF8dDINncIRz9f/FW46w2w+F5KyVnhPzolWg7iiAHNBoPRvyBfO2FyQyGGADnK08QTbwtnlNi9gP1Bf5kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0NVUnU5Z0JTYU93eVlUUW9tZ2RWQTRDbVFURkt0MjVJSjZhSDhGaUF1Tk9a?=
 =?utf-8?B?ZG1EUlByUGIvTHJYNFJZL0FZdEVDTlA5M0tPYVBxTDF4aXQrQUpmQTBjaFZo?=
 =?utf-8?B?LzArR01LZ2g1UUxZUjFMQytmN09wbEJRMTRZSjgraE5ja1hIK2tiOHpGQXBM?=
 =?utf-8?B?eDZtbm4zVkJvSTVSWHY3MkZCTlFNVWpqYWhnQ3NpbkcxdS9EOEVmRXUrQWF3?=
 =?utf-8?B?a25nTWtQcXhQcUc5L3h6U1hpYWFIYlVjaFZ3S055UEZqbmZYMTB4MHp0Q2dQ?=
 =?utf-8?B?YXJVRzFTZVZGK3JMODMycHVIb1AzNVFDMyt6OVlUUEhIS2M4cFNwQ2RUQzlo?=
 =?utf-8?B?RVdwMjdsallVK3l6TSs2VXFmajNTWk1tWXhaa216WnMwb3A4bjhKVGRYTnh1?=
 =?utf-8?B?VzltdnpHbjBuMEdUOTJXVnhxQndiYm5NUmxsZm42a2U3Z3lScFhuMFg1MDZU?=
 =?utf-8?B?MDN3cjVSN0xRK0V6Wm1yNkxBbFJNUSt2S3czQXBLTFg5L1E4TWpkRnJQOU1V?=
 =?utf-8?B?b3hjdDQwRGMreGZhYzhiZmlLTExGcWdFWEFjMGlaSkZ5aFBPUitPREZzVExs?=
 =?utf-8?B?QW9OK2RFSVRwS0ZjQlNYdWhuTFc1bDlLYWNsanR4YWVUUEdqRkVYeG5QZW52?=
 =?utf-8?B?RWNhc1QyYkJZeXhzeG1zQUpZMHhhWWlyYUVLZ0taeHFmTVFKeXE0QkRPUGd0?=
 =?utf-8?B?ZkFMQUZXWENoeG1nOXd5NnlXNjlWbTlOWWFHdWhCelVCVWxsRDVaNmpxcEJ4?=
 =?utf-8?B?KzBaOGZqTWR6QlJrY1dyWlZVVFZHYlBXOVlMV3ZOTklBU0ZhNEFWRFNzdjVl?=
 =?utf-8?B?cEZzL2VCTTA3MDF4UWhJQm5kdlhXUHRTYXpkME8xOHBoWmluLzRlZE5XeUhs?=
 =?utf-8?B?Ynl1UU5sQlpoWWxocEFPUjc3dXhGVXQyM1NvVkNRUHV4NU5kUytETCtPVUFv?=
 =?utf-8?B?YWIyMW1tMXpYRDdvaG50a1IxU0I5T1c4aEg0cHNlalAwbzZXYmowVjVKUC9K?=
 =?utf-8?B?ckYzUWNrSFBndEIvRVo4cGZ1SDRXaDlJU2hpUTlPanVYbkVlRUxJUytqZnNm?=
 =?utf-8?B?N3VuZzNncktqK0dYa2JpTkpQNkxiWE91V1I2UnNzQ0UzdXhmdjRBcTRVRWx6?=
 =?utf-8?B?eHNwV3ljYWNFMDROOUttaG9wS2MrcWticUFEenVvdUFYT1RaZStOWWpmTTZF?=
 =?utf-8?B?SDVkcnNMZGs1bW9uNWxaZE11WkVBWFVTUFNUUlJXcTF5TTVuSDhmek03RFBo?=
 =?utf-8?B?cjFOb2Y5bDI0bnN1U1l2ZnFQejRFRUpwQ0poRWxhYUNDMTYrdmwrckFnYjF0?=
 =?utf-8?B?MzFtdFg1Wkx2c01uY241cVZjTTlYODFKbG1tdjU3L1BnUXA3VWl4ZHJaRkxK?=
 =?utf-8?B?RXoveW03NGkyUkxBNFVFTko1K0IzOHE3RVZKNWxSN1pScnU2Wk00ZEM4a3F1?=
 =?utf-8?B?aUx0R2RFSkx3SWtxWmI0RzBoZDBMSGJmTUdmQyt6V3NkTjl6NFNBU0diR3l2?=
 =?utf-8?B?NkJldHZ2YWh2WXRiMjRLRFZtV3VSNkp6NUpxbnJmT3BiYWVhMjRjV0pSZThX?=
 =?utf-8?B?R1hNbnk1ZmhEYzFYRzR1Wml6OEh5NmtPM1VzeHNWUFdPa1ZYc1J3dW9ZbG53?=
 =?utf-8?B?S1A3NHpTUGRONGx1bmRFeHV2SFBENkZhM1hUeGQyS1ZSdmd6TUxnYk1rcW9q?=
 =?utf-8?B?dGZzNDJIdnA1VlM4ZEdXcmtXOEhYK3F4azBoSW9Rb3UxV3QwdTYveVFHMjQx?=
 =?utf-8?B?NTNHY1hhbGt4aCtkaFpuM2hyTEYyVEt3aHR1a0xuQjAzMnN2RllUTGpManA3?=
 =?utf-8?B?a3Q0U1U2RVJhMCtOem9ZcWFBV1dBK0RFZVFlRm5HbjNCcWlSWmN4M3dFYkxT?=
 =?utf-8?B?TDdOelNHd2RBdWMzY0IrenBaaFd3ZGZ0QzB3TFBvdlh6SmNzUkd2dWxaMlY5?=
 =?utf-8?B?eHJJaTZIUkNGU1htck9HQzNSZU41Zzhhc2RzR2R0SGdaVjVtZUdYMlIvNkdD?=
 =?utf-8?B?USs4MGZ5OTFaTUlIcUt4WXJiZGFBeGFtaVF0aDBPbS9xd2k4a2czaGZaRFZs?=
 =?utf-8?B?NFlLY3JMRStwdE5HWE5xLzlhK25wSFdya1FqZmFWSjduTkhSRjZvZ3FMZ3RW?=
 =?utf-8?B?LzFPQnR2NGNIVDB2MklENUFRMWFsWWl4aUNJY3hVVkhiTU1pZkRBZjd2NXlr?=
 =?utf-8?B?Ri9kMDd6MjlQYzF0RGMrRkV1d1JIa1BZVVdDUjlWdy9uMzVoaG5FMTJJYzI3?=
 =?utf-8?B?dExkMHc3bmtPWDNkVUdPbFgrRTR4WUpTMEZjR1JFblNYSlFveDQ0Q3hmZlJT?=
 =?utf-8?B?WWlDeVNKV3UvQmdvVEVyVXVuY1M1OHl1Q3RoZWdlR1VBajIrZk4ybkZlTm1J?=
 =?utf-8?Q?yD73nWtMnMDa9qE4=3D?=
X-Exchange-RoutingPolicyChecked: ohN3wMHK1TISofC2OuxjNw7qPQSs7DyqURHbgtj9y0qDRBFbfgSXd4gONmkNry373/hORfeKZJWeErxmygsLIaMVZ7Cq0D4ETAZNamxkxeALpQDyroaAvmzQss6kIFx1W+ybGlGkrn8AJDgIOSQQqG1p4CFpKIFcd7304E0uwwa/Gavu/t9wGUWhFX4V1D1uJ1+QjmVQAhmYdAFsG2a9lv1ZdWHdIPwVBHxrVlIt/99zogtAVn300ts8NqHY2SuEBxUZ0+OjZEtkyDGDvjoXZmLfu/HU10gW1LWNGSXd3q+1Vv8lEpxFyf9/YvIXnS11dpPI7jfhkchKNhWzTIGUdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2048101-2c70-4b70-c182-08df2ef585b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 22:00:15.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N51TeM1oQyAyUpqlp5qJkDV/9ZQzjoHuTaSCe0PIx3L5JulkYADvBbUyI/Q6u8BXsv4Pgp8b/Ki9Lj9/d5rO1IFnlcbcfgsp4VTk6VYPumE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-OriginatorOrg: intel.com

Hi Babu,

On 10/20/26 12:10 PM, Babu Moger wrote:
> On 10/19/26 11:22, Reinette Chatre wrote:
>> On 10/16/26 1:53 PM, Moger, Babu wrote:
>>> On 10/15/2026 10:27 AM, Reinette Chatre wrote:
>>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>>> Some per-group resctrl files are only meaningful once a resource group
>>>>> has an active kernel mode association.
>>>>
>>>> Could this elaborate more about how the files depend on the kernel mode
>>>> and why they may not always be meaningful?
>>>>
>>>>>
>>>>> Creating them only at activation would complicate group setup and
>>>>
>>>> Why would it complicate group setup and teardown? I think it would
>>>> rather complicate mode activation and de-activation but since there is
>>>> no detail about how this will complicate group setup it is difficult to
>>>> compare. It is difficult to reason about a patch when the motivation is
>>>> vague.
>>>>
>>>>> teardown, while exposing them on every group would show empty files
>>>>
>>>> "show empty files" - technically these files, as they are implemented,
>>>> will not be empty but return errors
>>>>
>>>>> with no clear purpose.
>>>>>
>>>>> Add a hidden property to struct rftype to hide files at creation.
>>>>
>>>> Missing a "why".
>>>> This can append to describe how this adds the foundational support in
>>>> preparation for features to restore visibility when the feature's files
>>>> need to be exposed to user space.
>>>>
>>>
>>> Will rephrase the whole changelog:
>>>
>>> "Some per-group resctrl files are only applicable to resource groups
>>> with an active kernel mode association. Accessing these files before a
>>> kernel mode association is established would result in errors and does
>>> not provide useful information.
>>
>> What does "and does not provide useful information" refer to? Does this
>> mean that the errors are not useful?
> 
> Hmm..  One more attempt:
> 
> "Some per-group resctrl files are only applicable when a resource group has an active kernel mode association. Exposing these files before the mode is activated is not useful because they have no meaningful information to provide, while reporting errors on access offers little value. Dynamically creating and removing the files as associations are activated and deactivated would add complexity to the mode management path.
> 
> Add a hidden property to struct rftype so the files can be created with the resource group and exposed only when applicable.
> 
> This provides the infrastructure needed to control file visibility for future kernel-mode-specific resctrl interfaces."
> 
I still find this motivation vague as it seems to aim to be generic when it requires to
be specific since it is needed by the global per-CPU kernel mode support. Consider,
for example, in comparison a changelog below that is specific to the problem that needs to
be solved and why. Again this is an example that does not take into account the consistent
terms that you aim to use in next version:

  fs/resctrl: Add support for hidden resource group files

  A resctrl file is visible to user space as soon as its resource group
  directory is activated. A file can only be hidden after it has been created,
  as is done for the info directory's BMEC event configuration files.

  In the global_enable_per_cpu kernel mode, kernel work running on CPUs where
  the mode is active is allocated resources and/or monitored as part of a single
  backing resource group. The files needed to display and modify the CPUs on
  which this kernel mode is active are only meaningful in that group. Visible in
  every resource group, the files would return errors when accessed in any group
  other than the one backing the active kernel mode. Creating the files when the
  kernel mode is activated, and removing them when it is deactivated, would add
  failure paths to kernel mode activation that showing and hiding existing files
  does not have.

  Allow a resource group file to be marked as hidden so that it is hidden when
  created, before its directory is activated, and is never visible to user space
  until resctrl restores its visibility. This provides the foundation in
  preparation for kernel mode support that shows the kmode_cpus and
  kmode_cpus_list files only in the resource group backing the active kernel
  mode.

Reinette


