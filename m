Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D136DA10;
	Mon, 15 Jun 2026 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520903; cv=fail; b=W5X892GZFLgxOZUgoZQNh+MU4NiNBvxHqg7jDPg08N3Gj9plUv4OqfSu6t66977UQCEt+AabJVxE4m2oIoKtYVVSDzEIqDu/Dh8/DPuAXWY5ykZxQuz25k2TD2lavMa3UT7ShsdXwDurUHt/uIJFRBNdMRucyYVG2C4gMrFK9Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520903; c=relaxed/simple;
	bh=OSbXTAL/M36PEOmN4NYzK/1ziaEyKK57/ucElwvD97g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q/RKcY1L913lSer0CX4tBLn0A0M1t+dpbqnVgHfRqkUsCw+ULL13UhyWxt3NMg++oM7LYiY3Uok3ys9xksz7GCq/bueZpiDVvQG3OePk9YTidcLae7atRPwhx9gn8jOYpOyuJaABI0ksTq+5N9VnBFl2tp/pk+oRCGlhZJ4ajJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTTKRGVs; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTTKRGVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781520901; x=1813056901;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OSbXTAL/M36PEOmN4NYzK/1ziaEyKK57/ucElwvD97g=;
  b=TTTKRGVs3uYVN9BPjT5WViMYBezEprzMSR342z3GNtgc2LC9HLxdMz5f
   6MaIENiuh1hS+ayZxHhgmZePiiJL0wzLkWe8QflQ+RsoSA9Wilw08/u+C
   EY6fCl0EKgqg4JixBXXSedVYLG7p4imDL8RsT4k0iO/JT4SMK6MkJZisu
   Ks4VX0kYyD2tu0IJTwQzM4Vem/gvj14a51tWEJMtkwMUagSqNrdwfjr3y
   7jx1/cfzSlvCzeadQDWsX4+w/xi+kVhRodjQ7qiNDWSvFYEbMwQqAmNgy
   qbXZ8HPVgWjCsV2Uxg0+YBWwGNniGm0v6c2pMzTSOvhyh8hVYCdCqc2Fv
   Q==;
X-CSE-ConnectionGUID: 41CiCsXgSd2lRPW8bRyHIw==
X-CSE-MsgGUID: Vtvake5bR9mt8dSXrH4K5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="86156687"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="86156687"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:55:01 -0700
X-CSE-ConnectionGUID: lloi7v56Sy+VBmJuBBuJfw==
X-CSE-MsgGUID: vabFPLXpR9qJBHLgNQisjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="246331533"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:55:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 03:54:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 03:54:59 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 03:54:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7kxMveCQp/sLLTRPfgK8Q5/fGtT0aJvjVmEaCd4xl7lV6NCyt2zfXkDgfE0kq0ZZ+F0ygNnavW7Pr08XDg+Tm8ow3ux0CDVH5Vaob1Xs5tw0f5e3U25xcqKw0zMcdERsbKOInyNQLHEW2Snlf/ljacfYVDQHR6m2NXPkxyh/VQfHQYJbX+MJWsJNiUsNMkEtbbVs4pMFuOlB3Brd2SffdRf3i+S7/suWp9kqzi8TRmIAaXXNIEAj0cF4qChyCQYGMJh8O9loua8A5odVzosG14tv2sF8WpaNj0qNOr+aMdtqGQnkba9WWTsiYys8TwQ8TViry1xLJdIiOO4cOHh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+ZjmvH1H8PP3sw3DXvEpqBXO3K6RaGtuT1nrhNcqfw=;
 b=yxz1tYYgEGNhBMO+a6z0bq6RYj37/91p0ACCS18g9KXdq5p/TKaQAQpwh5wbs/UDekOfHfwKomoWmG/1eIkVpRztyGJqarg0qwuj1xtmjNdbor3U9j/scHYPzSlSpz4p+2jPWDRIrrENrk7m1Lo6ZrAiXbznQrdLs13p817vVPJiT+aiZcKP1own/v6V9YrgPgjPYFLGhkqXfzpEXjCjUHxIlU306GO6R3cX3txRH7BCFjmcahAKz6d0/D1AI6i2onIe1ESbfjYqTHE+q9r3f6/Pc0f3d3ypnGbOxpWysz6JojAd2NuPIvRib7Ga7Ps8/Jr1GKM4CFpdiuXYDoduvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 10:54:55 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:54:55 +0000
Message-ID: <67f132c3-efd4-477d-9d10-83bf7366ce10@intel.com>
Date: Mon, 15 Jun 2026 18:54:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/22] KVM: selftests: Expose functions to get default
 sregs values
To: Binbin Wu <binbin.wu@linux.intel.com>, Lisa Wang <wyihan@google.com>
CC: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng
	<ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, Ira Weiny
	<ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, Ryan Afranji
	<afranji@google.com>, Sagi Shahar <sagis@google.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton
	<oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-9-6983ae4c3a4d@google.com>
 <434e7f9a-5f64-4488-bf9d-5be8c3f9eefe@linux.intel.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <434e7f9a-5f64-4488-bf9d-5be8c3f9eefe@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:295::6) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|DM4PR11MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5d019d-6e42-4b61-7d5d-08decacc8919
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kw+gGIT+LSQgqAD06vNLQVg99SSI87OTHPa5N1DIle75YwayTSncrxFBTgpF79PO1h4BznAzuFi9XtoZU3wOBN4XNpCB9Wgewg/VpkziqqABGHYzro12Le7FLlZUmzBgydAK7ea8SCzcthwvzJl7Fg61K6F6uE1v1bSlOPYdAvNUWo9FsT3ckFfcXA7R9+Fi0jJewn+bzmM72lrATnGx+OkfLxdnI+H4a6BmdrnkEsOvRGxhYsrhl36gkV3WnP+dOYrNvfK5WCUIFCsnklazpRwAJUBnVObDAU3keJIF/yKyqHy7ASnF6HYrWCvbD8Ggp6tuDCNe8oIfQmtLlY0hSv+StitHvV6DeddNJNRK9jkjKkxqld5kFVMPlyDCQS9FcH2a3F71dqYguUDXqtJscFldUIDGPSdLQboRuWeYK6Hv2QtpMZOkI1DtTNS/TPAX6dDe/M3NPq0wVbsYDkHifEvJ8F8UZeai1YMDzuBnIyxB142v3Y2TUZXyx5rLl/fBZe1MrphD/5mzj82HiDNDtTXAjMDJUsj5FH1o/6zZYaXPPZ19wVBU8eKipPnQ1b4BriXpou/XbS4Xtn0TcdHyRK4XvMcxToI5zxajFTUI1MRQlZgTZe/JU+iRfWHEUkDdDKPy7DwoIeA1TfmHGJwbULaEAAkFnZQZ0NTGlYhTeawV0uY7eEJa5ICbHUWlhwo7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFiZjMwY0Q3UTJLbmNKMjZIWlJCVW1hdHpZc2hhOWxCNHJpSVlGNm5QWDR2?=
 =?utf-8?B?OWNkZ21mUytQejNhbkRtd3ZkNTFPYXZ2K2JCLzhycUhJS2gwd2pTNjVUU3dy?=
 =?utf-8?B?L0c2MjdleEhlWW1iOFpaTlJubHg0YTR3aDZJdjlyVG55VlVQMUgxaC83QWIv?=
 =?utf-8?B?bzJ5UkVZNS9rTG5tUHpqZzRmelJyUUdZLzhUUG1sekhBTUpPMm00Yko5Vmho?=
 =?utf-8?B?bGs3Ui96cVcrVXZMdDF1cEVjK1lpbXllN2JWWDlxMlU5cmR5SytpaTFDbXVU?=
 =?utf-8?B?dklyZVJ0akJHTnJzUDc1TWxkZ3NIa1JtOUlmYWs5M3lHOCtoWU45MXZqMjlE?=
 =?utf-8?B?SzJtWGx3cXF1WFQ3dytSODV1Q2lpakU3amRZVUd2TEtLQ25Tb2JFY0JEeHlZ?=
 =?utf-8?B?c2Z5UDRGVXZKQlIxczhleGJxMUlDc0N6cVN3WWkzTmxHTWVIam5rVEwyc0lx?=
 =?utf-8?B?MEEzUStEZFZyWlF0ZHlnUllZV21oVlcwbDlkQlQ1MVkvOEhyNGFGYkJoWUg4?=
 =?utf-8?B?ZnFRM3ZSVG1MUlQrUURPaUZKL1laeGRZQWtkd2k5M083dnFYT1BVUDRVaHFL?=
 =?utf-8?B?cTkxOHgrVTFMZHpqYm91SDhJTkorQkRlc0NWYnVCQ3lLb1crUGZFbkpteEpp?=
 =?utf-8?B?cVBqZEUvM3RtdjhPQVJpNXRLUmlCZEVHdEZZVDlNQjFuZHlBdHYxSnlra1oz?=
 =?utf-8?B?ZkVESzRrL2Nib1BkejVVaTd6M3NhNDdlVlAxMTVIdnJKVVhSZ3pJcGJZWTE1?=
 =?utf-8?B?Q3o3N2JLc0I2Unl6ZERXQXFvWXdCNmdFaDdoZHdud3hVLzFMK2JySW1hcW5F?=
 =?utf-8?B?SGJJYUExcW1uN0haMnIyK1R5M0hpTG9aNmcwZ3F1Nmo2MWlQMGxiQkVJdmwz?=
 =?utf-8?B?R1JmMUpreGkvR3FXbkVpQUFjTWRsYVhycmZubzBtY3BlbHF2Ty94d1Fpa3VB?=
 =?utf-8?B?cDBKTmU3SlZFN3ZTUklkQlM1RFZwK1dnNGUvR2VzVEdrNVJaL1Q2SFp6a0Iw?=
 =?utf-8?B?eGR5NjlYYldVRTlybC9CRUt5YXhsTVdBQkd1QlFhbVhIUTR3ek1ERnZTTnY3?=
 =?utf-8?B?ZDY4N1FYMHZBbWM3VGRFcFZTa1pDNlJFejA2R2lLaENGZVRPR1NOVndDeDFT?=
 =?utf-8?B?TDJIYmtrb1BRc0Zpdjg0VldFdzl6YmQ4MThCdm9Ed24xdVJFNit4ekNhZUZ1?=
 =?utf-8?B?V0FKYkVPdGlKWk0wMjN5dlloUm4zMXQxWHdqdzJ3KzZQSmh5MkxEdFhSYXYw?=
 =?utf-8?B?Y3ZZN0Ird3I2cENPTDlnTklEdTdSVkVFRnFDZUorWjB0VUpvdk5MNmxLcjE5?=
 =?utf-8?B?UURZZ01mc3Z6eE5EclJzc1ROblo3STRqKzdwV0RPUlZjU2dYUjd6UEhOSEEw?=
 =?utf-8?B?b2UrTzdXdlFNT1lFeTd6WkkyQ2dZTVFZejd3R1FkMklQRnB3dVB0R1BQY0Iy?=
 =?utf-8?B?MXpxRkd0TVAyTjZ0Q3BqWUI2WStSR2FhUGpzUEoyd3oyTWpKUFZPdWZHaHpL?=
 =?utf-8?B?bURzOXgyR2lGMnp2ZG9sZGlTZmQ3aTF1clFNaHdnanZiR3pXRGVoTWhCVFVZ?=
 =?utf-8?B?RkdkWU5lMDY4UnVXd1dRYVRaRk92RytzczVlZnd2eW1GMFU2dnliRUpqbkFC?=
 =?utf-8?B?UG44aUNWNzhhREFpanF1SS9wSGJBV2JCYmpsUjdDQmRZQmxvNWJTTGVSQjBU?=
 =?utf-8?B?RkpHM0U2UUpJWFUvYXc3cUltN2tZbng3WVd3TUViUUJZdEp1dE5EVEJwYUxn?=
 =?utf-8?B?RmErc1hvZWR0cThEbE5MRWRXczdwRUpvT3k4b0dBNkRtaWJJbUtRSVk2amor?=
 =?utf-8?B?b3ZtYWNMdzYzY3oxNk1XU2IvUitlaWVJdHVTakVOY0FmNVJza0RlLzYrQUxY?=
 =?utf-8?B?U3BjUVBGNUJUYm9iTkZjVVcwM1VUaERBdGk3WExzVi9HVHo5NmxmTnpybXI5?=
 =?utf-8?B?MDRqTy9YeHAzWkdjY3dhWEtSeWRCMjl6WXMvSXBTakVDcUJJSG83V081WFgz?=
 =?utf-8?B?ditSSjFVbVFXTG9UajJ6TkVxYUdwS053SzJmSE04VWVHTm5YZ2x6cHB2WkF5?=
 =?utf-8?B?d0VDZWNlb2NVVGR6NGdsWnlMejlZR3RVaWFuOXBMT25vcUFYczg1aGhtWE91?=
 =?utf-8?B?NmlqL0ltMFdrT1hXQW5VbWVWM1BrRVlrSUQybzBoRDFEUFBYL1VVMnFmT1Rh?=
 =?utf-8?B?b2J5T2FodEExSm5ydk82MHBzZmZ0MmZ5bVVBK2lUcjBIYmNCM1VYcDJ0WUw2?=
 =?utf-8?B?SUdYVTRmZlMwQi84Y1FLd1dBdXpZQXk0TUZBckdGOUdScHlzcktJdmhtZHFk?=
 =?utf-8?B?NU50MGZlQUZhZEc0NGhJK2dHek0wM1JnZHBudkFENlRuUExMc282dz09?=
X-Exchange-RoutingPolicyChecked: ZUhPnbnlY7eOBlZffzrG/oLmnhfcWbQs4h30jX2Z7mzi/g7ho4hqJdNwUA1gLs6n7ymRWrEbWIu439dywpA/JTXtNkaX0m5f1idGt70O8oUe1SXFn2ETQhr9FrVi0CHniYPigGiprUHIiNMhFYLaJtig6bPYAvOGAmvwpe0gmfn0I7BimWYquUc9/egybVndP4B4ppbCjgt6kpMXSczBL/wgtSrgeivYevmgYy1sls6jl0h+zKEmm86mOGBlghRdFaYyzggtEXnlDNpMh5kuM4+La3wurM4ALg+jEnlkkWlAzbT74B2S2SRWVEvwMz8viSvgA+SrMOAIRsA68GsvkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5d019d-6e42-4b61-7d5d-08decacc8919
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:54:55.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGJutrGf9DmlABpJnzk7bfspGsBcwlYeO9VqULVM3Jo3G3j/ZE24l7uBIkJPE9mE8uhAUbbzVrZD9kWm70phLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6020
X-OriginatorOrg: intel.com



On 6/8/2026 2:39 PM, Binbin Wu wrote:
> On 5/22/2026 7:16 AM, Lisa Wang wrote:
> 
> [...]
> 
>> +
>> +static inline u64 kvm_get_default_cr4(void)
>> +{
>> +	u64 cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
>> +
>> +	if (kvm_cpu_has(X86_FEATURE_XSAVE))
>> +		cr4 |= X86_CR4_OSXSAVE;
>> +	return cr4;
>> +}
>> +
> 
> [...]
> 
>> @@ -647,16 +643,12 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>>  	vcpu_sregs_get(vcpu, &sregs);
>>  
>>  	sregs.idt.base = vm->arch.idt;
>> -	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
>> +	sregs.idt.limit = kvm_get_default_idt_limit();
>>  	sregs.gdt.base = vm->arch.gdt;
>> -	sregs.gdt.limit = getpagesize() - 1;
>> -
>> -	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
>> -	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
>> -	if (kvm_cpu_has(X86_FEATURE_XSAVE))
>> -		sregs.cr4 |= X86_CR4_OSXSAVE;
>> -	if (vm->mmu.pgtable_levels == 5)
>> -		sregs.cr4 |= X86_CR4_LA57;
> 
> I guess the 5-level paging thing is dropped unexpectedly during rebase?
> 
> 
>> +	sregs.gdt.limit = kvm_get_default_gdt_limit();
>>
>> +	sregs.cr0 = kvm_get_default_cr0();
>> +	sregs.cr4 |= kvm_get_default_cr4();
>>  	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);

Also, sregs.efer |= kvm_get_default_efer() is dropped unexpectedly during rebase.

>>  
>>  	kvm_seg_set_unusable(&sregs.ldt);
>>
> 

