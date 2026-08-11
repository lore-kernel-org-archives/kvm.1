Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212C2F83A2;
	Tue, 11 Aug 2026 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786422599; cv=fail; b=YMluk8yNiGcwA9G+iZ+wnthTcphzxfXTiuXUeEcnGd3lp0c9ZtxViaHW5D5SlHBmUpdgy6RnaubBLHyIyj3fmyln1rdOeiEPypwt9KFv+fJC7UVzCCn3bYzDFxVHQ8cR6zTmemMnvjtquJGYOFVstNX8JIqAXSYycEsdT8FE54k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786422599; c=relaxed/simple;
	bh=ca3TN6DwYbQbNNbR+FBgy/AifIhdW9ha4odCBZhgzyQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jvnquynGKXw7yc4HwnUecsyZ4OS2HAZdAMQ0WRRdY91/vKvC4uFYkN1ehXar5+pCpBvacXMWt+DBaohZ9fa8whgV537kAmyqDh2apMeiXnoCEumkSJJxF91VPjpC84hGonpJT5yGyQybJNpNvgvzerpNwbUF/laWNIqWAlC4ZXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8bRZxU+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8bRZxU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786422598; x=1817958598;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ca3TN6DwYbQbNNbR+FBgy/AifIhdW9ha4odCBZhgzyQ=;
  b=h8bRZxU+2jlwSKjXBa494awk9Iq0HSLFCIvKnpMbN0LXQU9BxyERpcXV
   FXndjO/Id5+Q3eA4O/RJaas7GMWKunczr81b8wvq0C2A28WrOdY/9hhCP
   KYGiB4UhYc58CZA8k1Nw7Yd1NcbkdZPRkv4OJTPO0XGJgzFpwopASTXZs
   u6PHvXeKTWSB0oMi1FDPdZ+k+GQb5/WodfAawqIdxfJ1sO/5aFCOuG/JX
   aETrkmuNPh+w0eR2UB9Va+qRZbe4bhYV053c7R0oBbbn6XIC9otnSI5Dm
   Owzb+lQ5PqASjGkYdJGnCuq0rS61BpJMxJFHGiTqdt2uQKSb/dhC+IKux
   g==;
X-CSE-ConnectionGUID: lzLv8hMmTtyv3/89azXSXA==
X-CSE-MsgGUID: /plZH+CkSl2zpVdrM1FLVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86956497"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86956497"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 21:29:57 -0700
X-CSE-ConnectionGUID: 0XZyWctSQnSamDxZvfOEGQ==
X-CSE-MsgGUID: n9Tiz+W8RAmflhQTa8NyaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="293171891"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 21:29:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 21:29:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 21:29:56 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 21:29:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFS629H4fssL4pTdnEbbLqjLMfFH4c1Cy1IYB+ofGElHJLieMOh0CWn3L0QbFqltRKhtA53nL0ubMk5XXlQsEo0RwWW9XmSwS7mLiCOr2/FbnAcPUmmyMbR3L4MWdQDCGG2BOErAVvAhUZ3g5iPi6QTvOGgWIICKcrcAajikAoL1+w6brXkzeUcFR6g/RSnNCw6I/8/ToDYNQByyuJHp9YKxqYy9eeT7iNq45HAKkxDH5pxj2hQ2nBaDqoTwnKx69vUGLBwjUSBtbUKVZ6T6UDv68jVXKDwcRniflwozjnEISIggzWE3BEzKtz1Z1azTFAAjYZrCEuhTIxz5ei9egQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpLkAj6lHwfIspOj9QATTn3UBdK6ZlGWAPy7jy1/xu0=;
 b=n3eSRCY+9yPR4LlIGPTJTl8r0frum1LMn1G6rh08JqHzKZQKKjOJb5y9z4Rkla6RAeLWN3pCnSfa37Dr2WAE9OHMV/4PXKeekTV9M09GMrMWY2sl+1yFyL8ohQeIS1LlKUv4/TRHzsQlOOe0G2BZdUe+ZV1rXfyUqLSaAg/3nO8YJ5p+aMWlf1VsjXwqbi8MRtZ14+NEStDyhF/hFEAXJgQoJWrfq7c+pdw2Ze/VY6l2jAZGTTPmPysA9UMY+R6/uUpsy5wjyfzbr+4WZr38qxnjowS/sstY+WfQU7YhLZc2jyRBICPoY2Q1EknZKEyhjeuAs/PcUprvJ3twXWUO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 04:29:54 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 04:29:54 +0000
Date: Mon, 10 Aug 2026 21:29:20 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v2 12/17] x86/virt/tdx: Reinitialize the Quoting
 extension after TDX module update
Message-ID: <20260811042920.GA1013044@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-13-yilun.xu@linux.intel.com>
 <f565cf8120c92f71968ac97f7535ada1a00d8410.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f565cf8120c92f71968ac97f7535ada1a00d8410.camel@intel.com>
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CYXPR11MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 181aac46-60d1-466e-13f0-08def76130c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: eWBFRm+cF0j32Ja4Ab3kt6cCNnPG1AmLlTV59UZEOq+uCCHjr9Vt+wmhzt5qG3sti8GqD0P7BzoLMAUcVzySIICcXlD3d3ZG3krxSsF/fXCfQAqImRZEVK5ZeRfneqCKTrmpIarMkMABqffDyxCCNbxZ6BGmJ6hlfFJBuSNVNyxeDyTY5NpDnmCkCBrTG0tAZ+w9vmZ+3krBV15CqVUnGDAyKmLA3qEauitQxGmg2PUfPE0gyjSSP/jgyFUmTEbmnroKvYjRyeL/2nvD5R1DjH4l4G1IESp06XpM/4DRTk2cjaXy+ygOWxKma8UPojjFDWvEkXps6Kp8r22dR2S2zpFqCjbNwCSUGnPMeRH2udLZhftTlvVn+i6EXq7T3gdbcG46IX0fmzhpNSq+hynxzakiUQcrPez4PNpL37rdvR/HCxAOISphu3WE0hPiNh6dASqhDNlRdHacx4Ap/Okcg97S2oaI2MIgeT3rBQ7DNnuBPDx1wbbFrzSdQ0guD6mmsziEY0gmxv46W0UTqMfy6HugX8G4IPeLVhCyxf5f/4fwEfUndq5Py6rFJCojLFrqv5qqBrzGUI2MtkZbGdtLYbC67W1yzowAs/IKSSuZ4LOvoLhhBVXB4AoV1VWymkxE9AeXp1c7b26ZNRaZiE1jwrJ7HLuMl53yhtYj1ahkWvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnQ4UjM5anM5M1pWYk85M01SYi9sdlpzTkJDalMxS1ZVbStOTFk3ckR3Vjh5?=
 =?utf-8?B?YUs3aEl2VUpsTmJxS3FJazVHSDVFQWNqRVV6OG9yWTRLYWNTbVlmLzRNK3BC?=
 =?utf-8?B?YktuYTc2WHE2TGVtNkRyeW4vTGpJNWFnUncvejY2azZkWmlLRFpoTjByb25I?=
 =?utf-8?B?YnRXcGljaGtYT3ZqRENEUDFKTFVQdmo3eUwva0xFWExwdFgrb3ZrNFZmb2Vv?=
 =?utf-8?B?MEVDTjZwZTNEMmt6N01QSmRPNThNYVVIUW14c2h5WnRIOS9xdmZHZVdWMExx?=
 =?utf-8?B?K3lNTmdsdStHd3pqVHprMFJWZkYrdHJKUDRGVjI1MWdoWjJYS0xrK3lmekhH?=
 =?utf-8?B?UlZCZjZZUGpxSlhuWWI2Wm01U0YrMUh4dEw5Q1BzblpjYnR5bzd5SkoranEr?=
 =?utf-8?B?Nk5pQ3ZsZUtLcUVLcEtGVVY2Ym5NUFFsUGtNVkt6WlhnMGprRm5wR095MUw0?=
 =?utf-8?B?VkM1NEZrUFNmWkFVS0dkeGNpTk9GTlFIOEd0M29TYm92ZXpKVU0wWkdkVW8z?=
 =?utf-8?B?NFphZ0hQVGFvR2RsdXc0ZTNRcEN3L3VUWWZrZnExTDluNnVmZW1vb2pjUThS?=
 =?utf-8?B?RUdpTzNrV1NFUjB1U0pZSEdWc05NdXNYbkZtYktIem9jQTBzUE9yQWVyZmJY?=
 =?utf-8?B?MGpzZkFiOU9BbDZUMWN6N2R3L0FLWmNwaTRlbTBEaXRscFQzOVpjZm9lMktR?=
 =?utf-8?B?Z2NGY2VURVJaT2R1TThCbnhJa3JFMzN3MEt4SEwxR3lFQmNQbjJ1ZnQ4MDZo?=
 =?utf-8?B?Z09mMVR3NndkZE10V1Nwalg1VGc2R09iTWthYkxaY253bTZRUGdhUmNuc2hp?=
 =?utf-8?B?aklORmhudG9vdldVVUs5Nm4zTFB4R1RQemhINlFIM0RoREptTWxaT2dha1VO?=
 =?utf-8?B?OU5xODBOMllINzQ0YXo1TmFSbFdGOGJVS1pmeVEzNGVKdFNmN0NmcWpoNlRF?=
 =?utf-8?B?Ny9PSjI5QjZDdnlwSWp3b0lhYjNRc1VzUi9nV3RqZmxEY2RWaXNCNFlHc09C?=
 =?utf-8?B?ejR2em8wS0hiY0IzK3B3VW91NXZleWM5U2x3enNyVVkyekVWV1FYdzN2cDNs?=
 =?utf-8?B?b0Mwd0p6Mlo5WUFhNnJqaDNScEFWWlNuT1drMTJhL1JYaFpOdU5BSnpYck56?=
 =?utf-8?B?cVljdUczZmdlaGNpbHFqcDE4bWg0Q2g3S1lTRXo3eVVLZ1Z6QmtFSnlHOG85?=
 =?utf-8?B?MkJQMCtiMFRtWCtabk5GR3IxTU05N0RmcTQ4QlJCOTlrMFJXdTJTZ09CTXpS?=
 =?utf-8?B?VDVrSFZCeW5kcHNjbFVGbWY1L3Q4U0xRNGxGcEVubDFGTHlLT2xWaWx5L3Nl?=
 =?utf-8?B?VThvTXpxMElKN2U4R1NXZGJwQW9jWk9VNW95Z0xoY2NOOExUdjl1elRVRXV6?=
 =?utf-8?B?akkvWUtnekZqWjVvV29hNE9seisyVTBxY1kzbUlqeGYwY3RBY0NFVmlhSVlp?=
 =?utf-8?B?Q0ZKNk5XdTZKZUNNZ2t3a3NSdDVZY2hIOXMrWm50U2V0bmdCbkNNeHhOUFh5?=
 =?utf-8?B?bExibk40NHE1YTFzMXFweXB2Q1pTQ1JxMzF2OWhjamJVaDlxbzkrYS8vTUlJ?=
 =?utf-8?B?eE9BMG5RcEQrTmptcVI0Sjh6ZmdQWjhRL2MwMHg3L0pSOGwwNkR1VEtxMG90?=
 =?utf-8?B?bVRiYzRxU05MSXNtc0VreG05OUlXVzZ6YnYwd1hkdVNvK1ZDWlQwK21KMnRW?=
 =?utf-8?B?SXR6ZUl1d0lLNzdoN0tocXVsTmdNcE5JQkFKSGIrWkZ1WmlPYkRqeHIrS0Z1?=
 =?utf-8?B?c0w4TFZEZllSVnVzMk1TSnEzMEVyellPMGNCMFFsZEMwcWNLY1k3Q3pQM0R1?=
 =?utf-8?B?MEdydDE4Q01sMGMrNXlGOVlZYklGRHF6UGpYT3pBeW9DbThOZlJSNDhWd2dL?=
 =?utf-8?B?SDFpdUlFbGQ3RzBjRjkxTkNBVmpwcEppM1hlbCsremJoNHZxZGR5QnEyY2E2?=
 =?utf-8?B?bU80NlBKTGs5L0xXc3h5eVdGT0h6ZjJLeTcyV3M5L2VGOXV1UlVkVUlzamRI?=
 =?utf-8?B?ZzdkRFZBdG9iUDR4M3JEWUNqTy9WOWVLY0p3NTlCZmoxWWNjRnZCYVdyQWx0?=
 =?utf-8?B?WlA4MWd0Wm1WbkR1Ri9NdXQ2aitzcXJ5K1dibEVYSmthSUpIUWZDVGZ5OGFT?=
 =?utf-8?B?Mm1zQmFuTDV6M3NlT0FiODM2L2ExVTVyakdNL0JiYzhvYXNhUG0xcVdDUU1U?=
 =?utf-8?B?b24rdC8waTI3eUdQUWJaVTBKcnZiWkhTZlgxNkwvTkUxRTRiQ3AwdzlmNlhR?=
 =?utf-8?B?b1NOYnZqQXA2MERkU052aG90R0NDemdGMmRqK3NYR1hBL255S3c2U2tKWkYz?=
 =?utf-8?B?T1k0alZobk14U2dpdDlRWEE0SmRsSHRVN3N5Z3VzSFZtcS9XcEp6Zz09?=
X-Exchange-RoutingPolicyChecked: ZFj9taESJ93FRflAAVJLSIiEQow474n7cjNE0kXL2caKba/P6x/AKH4tAkAa8v4pu5mA7VsDjPy7CkTEG5d8eXRAd8E4hABBis7hEFW7FHDgnnxBdmF1cR4k2nGh45sVnmMkehR+/ugbrYc/b6gSCTcKWkO0Np0kuNH17h+qG991P77eaAwlmaxe9CCRX4k0RTWhV3ZLUajoyHN/AzYs2KNpCmpT4bdGv+Jz+De30L591H9uE8ojqZNEYJy76d0axSYjliHyZV9s/oj9q8/ItOLw6zKbNpImExexXaFtVjyn1wS4NGXj74MNUbmZBeQboZ9ijnqvKjIVKEXtyY6fGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 181aac46-60d1-466e-13f0-08def76130c4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 04:29:53.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zyS+C5Pvc7aaqfpKBPsigYhQ558McxmFHCvrLNB40hyQkQXz/1xT0SACHuQ15m0R+Ppy3LTBdzRJCkkFJrrGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
X-OriginatorOrg: intel.com

On Mon, Jul 27, 2026 at 11:33:42AM -0700, Edgecombe, Rick P wrote:
> On Thu, 2026-06-18 at 16:13 +0800, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 

[ ... ]

> >  
> > +static void update_tdx_quoting_extension(void)
> > +{
> > +	int ret;
> > +
> > +	if (tdx_addon_feature0 & TDX_FEATURES0_QUOTE) {
> > +		/*
> > +		 * The TDH.QUOTE.INIT call renews the quoting keys.
> > +		 *
> > +		 * A module update must not increase the quote buffer size,
> > or
> > +		 * quote generation may fail and break attestation.
> > +		 */
> 
> It makes sense to explain why to call this again, but I'm not sure how this
> comment helps.

OK, I can improve the "why" of this, and not just say what it does.

BTW the "must not increase the quote buffer size" comment will probably
be irrelevant in the next version, since I plan to remove the static
global quote buffer altogether.

> 
> > +		ret = tdx_quote_init();
> > +		WARN_ON(ret);
> > +	}
> 
> Since the caller of this function has an return code. Please justify why not to
> return an error. 

The original thought was to warn since there is no proper handling for
this kind of error, and at the same time try to keep other parts of TDX
going. But I think it's probably better to just fail TDX as a whole if
this goes wrong. If this returns an error then maybe something more
serious is wrong here.

> 
