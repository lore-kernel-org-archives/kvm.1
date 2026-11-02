Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793635347;
	b=4fyOYKmEQrI3IDY2rC79QcLRfqxc4ALiivfgASbDMizWTgDRhYMsipoTTfkeqLdFdTWG
	 atTaBE1aevhQ3QR/cO2gbOdwtlxmNdbV/iXUrpwhT0O4HZv0KVV+DeTvj0nxn87D3OUBv
	 iQzzYQjcWZvj5+KSnMH1PDwI57YLzZRc43iSplRDhfwZRm+cRxXE/SddNk0V6lVifrQ5K
	 jcpi+8qOF6urPffr/jOTQ9NrfZINTZKVVQzurGls79oh6Z1kshoDsqV6rR5cCPiempm7d
	 DMo5DzYKFo2WNFnA9o0WcqTeU7Tq0tu8Az1SyzlSfHeNUXg4RZKbmbGSCcHUg7xTV2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635347;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=3VVczRZeQ6JB7QLg9bBdjtAs/PQwY/R+e1PXcPJavY4=;
	b=tLDRFROmYJHBbHvpHAByZOZYULKSL5As5fL+PQMCrF6Wm0JNp88hX3jDh8CSsGa1qDpC
	 7jEjW06gYGGWuWCipRhVYSCeJBsJBoFljINu4L0J22T2kVMAHsiSk+x46enUCNf/OR5ls
	 yuSjSUa/0lANFVp1ISVTKq0tz6edrgegHy3rg7TBTVc4e/nBkx5OKcUEiFR1VUioGPRsN
	 coZrIp4d1F1XmHGu78lfzGl73qP19CHaNAQxMhoajoMsQsF75E1WhkDJW6vH+K/hotYQM
	 BHigvQy9mj6AeD6cBJsDvLpLYLElT23KQAiSUUPD3NHlyJ1nJoWu4rMUrzuFrcqnuYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KhsETFcP;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD26606A598;
	Mon,  2 Nov 2026 16:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD26606A598
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KhsETFcP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793635347; x=1825171347;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Gy9CHPl2RUwBXQYTq6eCu41n9QoLMoJKtWBgUrfYt8=;
  b=KhsETFcPRvqnB0VT5TC0ETjPOeW4axBkgtXS0BPraEcTewrlDkeJkEkZ
   1i+IG99b3v5H5jC66IJNjcsfz4FGM9Da//yP36jtDWHel2k/grKNvHs0c
   2t9QS2hwYrrL5656bYjSS2tlkOOptZ0WGP8uXiDCKktcSbeS6EWiipCOc
   rNoAs2C0NNaCOjsMh8rHD7X923Z357v1F2PwvSKeebXtqhgMYBIDykjvH
   H1hKI8g3Ik25qYAGW/OJXptdWwaD945rIqfwv3DOeaICkoWwVtVVnQEqX
   6x37DSSDpgkEAmmZLcGvslCYz+DQ/qxy88hinz5XzYsnhZp+tYMq9qYap
   A==;
X-CSE-ConnectionGUID: HqnNnp5rQ2ye5PNVxVKqdA==
X-CSE-MsgGUID: z26DaSYZRqOPgc2BhyfBTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2233274"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2233274"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:01:58 -0800
X-CSE-ConnectionGUID: gBrdoj//TWuED7UrmwY8rg==
X-CSE-MsgGUID: zNfWMz7DS5O/cL0N5oXx9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7926489"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:01:57 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 08:01:57 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 08:01:57 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 08:01:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhq1D71u7S666rz6yzTCEnEN0mVlRdCHqxU+ALq1nxxecw1vM9+kpL8qWKJwddTJkHXd4R/2ud83cxJtJ0GjxqCHDUIccfnuY7x+1YTX0PPIyqW7FLI4DyPv7rTPBjwVSVofy40hnT5M0Pkapnpi0tBlHrUoI1hyRXywZn5oReykTl8QiKFqFVtIm6LHmgp5plgmbK4bR/+tbqBCIwDyu3OCsnLtdD263hY449Cs8rGv8WkWnB8xxNSAkFBpP0gtWo4+wgjHoQmdgMAZ7nGde8+Omr5w2nUmB04WTETpxiTtbUYRC0Xqx1nArm3kc8XVmIKi2f7xFe7+GdbcCRX8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VVczRZeQ6JB7QLg9bBdjtAs/PQwY/R+e1PXcPJavY4=;
 b=HCpPBuOW+PfGbNIAJ2wEmHpJEzSTap/qrm7tN6z7IorZTifyvvlTUvExKdGjh+Dg9NjwnKsIhehxJbCj1Jhy8/XTMNhk8osItvRCkmm7CnzaIW3/YXJgFXJwVP9rxqIfcLevoRrxhyc0KoqExCeOgSF1Fo2CDU6OXa1xTfiKEMvn/V4st9lGzo7GsWVncLDlOGM7S3M98Nd7SqZIKoeMa5tjoH/I6O0KxoiRZvPNQkn2ZUZ5ge8keSFBbd+1q92Au52avYAwvvNxcsjGiRL3TYhLbOwa5vwlbe1GkDVM3NhicII08MFhHe8utdgy0l8A2KPqX80gxMLvVzbq9a/Trg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Mon, 2 Nov
 2026 16:01:52 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:01:52 +0000
Message-ID: <0cca66a1-396f-44f6-b66f-c39085df4ffa@intel.com>
Date: Mon, 2 Nov 2026 08:01:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Borislav Petkov <bp@alien8.de>
CC: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <rdunlap@infradead.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1793392128.git.babu.moger@amd.com>
 <c1e5ef23e83ea663e9aa969e301fac20723a988a.1793392128.git.babu.moger@amd.com>
 <3ebc7028-c559-4add-800a-614b29d66ba3@intel.com>
 <20261031010744.GFauU_YJdX2eV6GoHV@fat_crate.local>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20261031010744.GFauU_YJdX2eV6GoHV@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::22) To SJ2PR11MB8370.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|SA1PR11MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: e489193c-2a52-420a-ed27-08df38fa9c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|18002099003|6133799003|261102123227099003|22082099003|261028144727099003|4143699003|11063799006|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: L++1by/6cjF2GeCwEFzEVczDoqGWT3G/F2Aq1vhSMeO7cT52mrFTt6OTnzxIBVfQ+HEbCCdUgASExNBG5QDGQYcug1yZxPAo0lSxZd61OoHSR55OHY8qh4IoZA8VbZctikF6J/dgo6YHGoLriFaAn/wEGDFIYwdTRWlzA1SL0ph87HQMpsrfyaKBVdvRvVDpbMn6fdEVnyiGwih2eUPBp9OAx3GqHNy9QgoX4G/Zqa0vgRIrr9pVSZvaejo3/xwFL0HtfufE9FOenRwj4mSTTeL2DS3aNthPrcz6dESKmxdK5KkKmQTMIKkinhqNv/ETkuVZfM4cSsVZpmjTwxFnMqhgwg70W0CSC6jjg0JXBR35jwUCfe/GBAW3gm7eVn2ihVIeF9bwKszo70HwCKeqL9u4Y2t2Kt0m8IzHmS+LdUxLs+qwK5sAlgXz7H/6JNkJQfNqWbECHxMEvvcaNcJbJZekJcxHUdGoMRzsfi20uJ3ORGQaGoRLJPyl/+Tak81eJjWNSAT1z1rbJ/fPLUtw9fM9cKozKADViOv/Q7QAAVEdm6FZSC/EDzBU0PfMMms1tLX+qIHTlOuTi14hNtcD4uFFK/1Iry9R1I4l7EENE8pawsi65b/nHl2HoME6OXmy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(18002099003)(6133799003)(261102123227099003)(22082099003)(261028144727099003)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3ZLOTBoU3BSV3ZuaWUrUVlEZFh2dXVueTJXMGpKRCtyVVBOdFZ6d2Z6M0FI?=
 =?utf-8?B?L3JFY05jUHBPdERDMkJWZGdESnBmeG9nUmE2RnE5WGxGZWJsY2VXZTZxR2lk?=
 =?utf-8?B?ZEMzcHRUYW9XY1F3NWJZRDhYeU5pZ201SlV0SDRyNUhRRU5aWDFoOTVRRGNn?=
 =?utf-8?B?R0xnVGFsbnRUMjgvalk4QUhLQTdlT3NZcGVrQk9CZnBtRzdkbDNDa216d0JG?=
 =?utf-8?B?aCtEdnhFbnp0NllLbTRnWGdOUzJwVWIxUlVhdjB1aVZRcXI5VkxKVERTWmZC?=
 =?utf-8?B?bFBqU2dmSFRFZVd2TVYzQ0huNi9iQ3RSYUh6dGFoK2NsZXBOR1dMN0JGRk1W?=
 =?utf-8?B?NDVHQ3B6M2ptWHExUGFEMlFzQ0pkUC8rRGRHY2d0eFd2dW4zWHUwMUlUeGJK?=
 =?utf-8?B?QXVuMlF2YnJ5R01Fc0djRzcwcTR0dHpsT09wcDU5ZEhqZHJ0d1VFeTAwRGw0?=
 =?utf-8?B?eXVZSnhseUZ2MktMc3hYRzhQY2tBbTJmN3NmVTZCRjJmY3g4bm5lcjVReUdY?=
 =?utf-8?B?VzBhL3owRHR0OUtHeTdHdnlkWUg3cVFIRTNRNXBFVkZOTE9YbjhPME5iOVdD?=
 =?utf-8?B?MDB3KzJudUNOMVZIY2d2UFlVdTI0SUdLT20vR2xyT2F5eFRXNlZrMkgyN0pB?=
 =?utf-8?B?c0Y4TmZzZGFpK0lqalBOK0ZtV3MyamtKUUM5QXB2OGVUWEt1aU5PbXc2UlVQ?=
 =?utf-8?B?cHRab2ludDBXcHN5Z09UQXgvMHYycmhHeGFlOUsrU1dFc2o2UlhmaCsrMnB1?=
 =?utf-8?B?M3M1ZFZmQ3l0OU1Uc3VZUWMyZ0g2SzJDOUpmbGlWYjdXcHlkb3FxTW14cGZ6?=
 =?utf-8?B?cFo2TGFhY1pRVDZ0bzlHeTZlNTZ4R2VZVGFmTXNjU25EcmRVTWVCMFphL3ly?=
 =?utf-8?B?dXc5SnFqeWx4V2Y1a3hQZjhId2pUbk5nWDVJU2t2WFZCZW8vNG5GdVVPR2Zk?=
 =?utf-8?B?a2haT01NQXN6UHBYMTU4b2g4Tmk2cmFGbEh5NVBIQVhPdnBJV2RVNzJqVml2?=
 =?utf-8?B?NDdNaWRGRDBMc0NIY2dDRW9pZENhVlFXQUd0MEVGdnpwM3pNdHlDcUpycTFa?=
 =?utf-8?B?OW1aTGxwc0lpbStpQ0RuRlVFVEJRYzltRktJamJ6L2FvVXJvWmptVDBVWENH?=
 =?utf-8?B?NGhzMGpqQmw3Tlk0OWxLdm1CTmhSYmlwQ0xXK21TSmRpSDBvTk1uT1g4TWRN?=
 =?utf-8?B?STQ0bWRDZnowNkc1OXMzQTJNTjR0ZkVzWTZGbEQzdGFxTGZ0d2tmQk13djVy?=
 =?utf-8?B?Uk16RXZicEs4MGk5eUxqTkswdTVhWEpWSWxwL1JYeVorby9LSkpNemdDbDNM?=
 =?utf-8?B?Ty9PdUxOWHhZL1c4WlVXamdST1c3aXc0Wmxsc0kwQkhLNjBaSkJhMjVYeURi?=
 =?utf-8?B?UGFMeDBwOFh3R1hRZ1ZUdVl4aUx4NkRIRmorc1RqOWdQczNwSjdGNnV2SHZ2?=
 =?utf-8?B?S21CY2pQeTlpMkVJSExlKytmbmRTcThreGR1Mm1XS2V6RzBPQzNGaUhZZ2tl?=
 =?utf-8?B?eVBZWUF4ZzVNRnUvY3doWERqNWJ1RFZiaWxvTHBFOFMwd2xuVCtEOWhtd3d4?=
 =?utf-8?B?UC9SVzl1UEtCckU0YU0wNm1IM0pnTDVXNitaS09sOFVMaTBUcWhUZ3I2QzI2?=
 =?utf-8?B?K3dmS3lDMnlmTEovSDZBYlpCT1NqR2hGcXpjSHNhaHNsVzJsZDRFQk1LSEsw?=
 =?utf-8?B?akhXaGNqRWpsdHNDbWhabmFZdytKU0Q0Ly9wcHo1T2toZHN2QUxGTHZ0R3lT?=
 =?utf-8?B?dUZGbk4xeHQxQ09ib045aTdhYlRUWDVZT0NvQjFyNnZBa3hkcGk1RC9UUW1i?=
 =?utf-8?B?MXpjbnNSNEhRSXY4ME1HWlVIMlJjWU16V3l0cm1FRmVzTVJRZURWdDBNWGEw?=
 =?utf-8?B?L2xHSjhPUjNmR1RFY0ZRdWZwQmdlS2hLTkpGMVlTKzd2SHViQmxUTU8zNDVR?=
 =?utf-8?B?Mk1vcGlTeHpTUytIZkY1Z3R4VjE5SmxaVU13MHZNdmFaMVRZeUM1SDZaTHRR?=
 =?utf-8?B?QzU4QkFMelVwMllzV1lLKzZxbGF1ZzBZWXNCUmV1OGNEdDZhQ1ZwaW9Ocmcr?=
 =?utf-8?B?U1IxUFBNb0ljZlN6S05ZUzhGLy9YVjgrckhlbmZ1RjdUdnN0a0tuQjhVVmpG?=
 =?utf-8?B?SXFxakJ3dTZFUTBGRURLemJaRE1mc0ZZWmd2OVozVFBXV1h1bzZlbklxQkV2?=
 =?utf-8?B?V1ZRNUVacUVrM0Z2RWFyNk1laFFMQWVMVEFuTGFlbUgyYVpIbEQ5V3BXQ0ZD?=
 =?utf-8?B?bTBIQTVVZHVzOHo5L3gydlFrNDlLdFdvN3JFSFA1Qm1WU3h5UGJFUEM2RFc5?=
 =?utf-8?B?aU5BMVkzNmxBL1JvYWd3V3dxd254NU5MT3JmRUZNWGgzUTNHTXNSRVdVSzE4?=
 =?utf-8?Q?x7h/pG8m3ZiNi2qo=3D?=
X-Exchange-RoutingPolicyChecked: NgJyQNr/3zXKI9W881BljcReo2/cfijjdl553dpIX0QvXqld99GaOtpPqJGsr8dSqHFFUlBhPRd6CMIgZdshbTgb3nvv3oA8IZYkH1M0qii1/tWK2LdnOyG1QKHzzDCGb91Fse6Tg3q9gjDHU+a67LSIRcDj2k7vZEeNKa2ltbcnBkNkQJChfo+JtvvkU/tJI2cvH8zIVgZU0//WneCP4CwA6lfg+zewBTKPxGxRfN7KCklH64LKCiEuP+M30EdsqM7DXV2iA/s2FNHmNxioHzRWF+JswlJpsUG0E2ARWTTofP4z4Aj5+LPRdBOOInafV2T6B6U+4XnBaya14hvltQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e489193c-2a52-420a-ed27-08df38fa9c56
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:01:52.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYo7EQNPaCmZ0rpk58aC8Htdmue25Gw0USWr8SpNM1u610M1PrDncBbWFFpPtN+ha2WWCQA5IeODZxuUuhBOjQneWfkr1YTz7hSuis8qslA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
X-OriginatorOrg: intel.com

Hi Boris,

On 10/30/26 6:07 PM, Borislav Petkov wrote:
> On Fri, Oct 30, 2026 at 03:08:09PM -0700, Reinette Chatre wrote:
>> To help future readers understand how we landed on this I think it may be useful
>> to add a link to the decision that resulted in this fix. For example: 
>>
>> 	...
>> 	Leave mbm_assign_mode in default mode during initialization as decided in [2].
>> 	...
>> 	Link: https://lore.kernel.org/20260804191608.GDanI6eK2Q07w6pNcb@fat_crate.local # [2]
> 
> I can fix that up when applying, yes.

Thank you very much.

> 
> Any other Links I should add? I don't have a problem with leaving enough
> breadcrumbs for the future...
I find [2] to be the most succinct. It also points to the thread with significant 
discussion if anybody would like more detail about how we landed here. Even so, 
I do find this final changelog accurately summarizes the trade-offs and caveats raised
during that thread.

Thanks again.

Reinette
