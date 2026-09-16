Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC144AA024
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599682; cv=fail; b=fIGH/9aJmfzrZdYLZ1xiO5QSCcl0SKyZiAbguBibR9BtOtAaXAPd1crWEFlCTh7vcLfsFsTZ2LeSjK7sF5ft5CiaKh97bd9JywP9+P6+3gcW2OX/ZqJhbvHlsIlUn6q3J/mNawoL3l/abGU1FvJAwem5eS9ToeHhNUkBbyrxyNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599682; c=relaxed/simple;
	bh=TxgNOcq5qs0mE3vg2IqWMqA1hq5HoToi3eR1UqAhAeE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EwV/W4+hxqZ2o8UihOGsXBBt1IM75FqoylpzvZEgvAthn+4+NeDIZIfJJBhImlaGNUPtjf/3ZnVBrev9xC44GX3ZiChLoLYEArEIIPylTwnSDL+OygYs5/mVabDfk3eI8Q5b/HKbcuUEBhNn5kwhAIIdNtB4ZtapDubEH9ZmXhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtkAuCTr; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtkAuCTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789599677; x=1821135677;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TxgNOcq5qs0mE3vg2IqWMqA1hq5HoToi3eR1UqAhAeE=;
  b=DtkAuCTrLcVsKbhlFRAROYaWnW3RmpIv86azqTWyF/k3yCi+C5EPOD/l
   aMcoD1x9K8oVGvraLVfa5HTZ1ls/Rup9NJnZgDumRUnL0jHSbwdlYaOXN
   q1Tta8Je3hDZ5DshimsybADcqwTtaP5LOvlqjVJrdPCiHde5zL1oeq368
   H0VTyR2HxzkG/r4uF3J8S6Q+mvzoyMrUVC3UFbI9zgP311FFxvmF6ziSf
   Un8/Zg4hXDOGIQJu1sLVr0m/S5XEkkDSvjigbVkbdQvvJ/JCGPYLkB4Hb
   JLk3Pk/+INFSK7pacEN26lnwf/DjIIwz4wirEkReJuh7U+iZCOv6Joq/m
   w==;
X-CSE-ConnectionGUID: 0ttzrtt6TlSLtggnvJpsCw==
X-CSE-MsgGUID: XZ9WAiO5Q76aAdKqjUpr7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93689419"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93689419"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 16:01:08 -0700
X-CSE-ConnectionGUID: 7EK+B90pSP6kD4nvqGxXfg==
X-CSE-MsgGUID: E4KMIPIAQdqjVmYnmjl2Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="298558963"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 16:01:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 16:00:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 16:00:58 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 16:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rzrbpb2LmvDmXQUYMwU1FY9M6SDFoH5fkGMkfoCjb/47gEMe63pY7GPTm53WXITZf4TwUj7KLFjKUHmGKRu9srqC5WJopcgQ+cjh8AlTlBmYIQai4/IbEEE7gjg2dM4yXicYcHSPDEbmOC5cPtdh/eLYGBoaMkpt2DnM5FeGG2fSgfjVzgmHkuIhunlWVQHO23EoMdXt3whxeCDA/vaACzjc6BrjQWjWy3c581lkcn0DrPSDw3bhuin6HBtj8bn9XNNEE/M2tEkeLX9DIvPA6RP8YmfQxyYWCXnbZTRhMbfleBTaDTeDzeknrVuWSkE4k6ik3OekbP25z5pFYTxVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbk2L4J3ukwUc6ICn6ZrFDgZcWGfChiWKaD+HRwdmuY=;
 b=FQG52RPnh+xu9mfpNd6aJIctM6T74hkUx1rSnOnGFG1RixzwGapNY1k8uHi9GOb6pKOVUPkOhlRRRd3m4BptStNBDKOZbBlazx8UcCXcfGDpwvzIrCEaUFGvvmkcgjG2dQfdVL0RKQ66Rlpd2DYuzxJhNV65k3PyfdTrxjg2d5Q0nzeoEN/2oG6vOP2hgCqFj3DmhDEXz/xEYpd4wBuE953+gKIxviji0exG/W1sV4z1NwHlpRNEBa/o4B/Xj+9p2hHEvvpz9h9Lw2GCA2FvkSQxlM6lIfh7ty4pL32H3WsTsvLZc+YHCcuu1AEIygagP9Z/qq11/0U1IyyHR4aAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB057924.namprd11.prod.outlook.com (2603:10b6:8:508::17)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 23:00:53 +0000
Received: from DS4PR11MB057924.namprd11.prod.outlook.com
 ([fe80::fbf2:d243:7bca:5080]) by DS4PR11MB057924.namprd11.prod.outlook.com
 ([fe80::fbf2:d243:7bca:5080%5]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 23:00:52 +0000
Date: Wed, 16 Sep 2026 16:00:48 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Message-ID: <aqsfoHzOip3n4zdU@intel.com>
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
 <aqrZUZtSZ-YItclT@google.com>
 <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
 <aqrtprn5YaMijVdZ@google.com>
 <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
X-ClientProxiedBy: SJ0PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:a03:338::18) To DS4PR11MB057924.namprd11.prod.outlook.com
 (2603:10b6:8:508::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB057924:EE_|PH0PR11MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e1a816-af88-404c-adde-08df14465b9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3GPBgDjIL0w8+U37SSwNqeDg2EuXAPH2PYMVJAYkRezjIxEwxPWW0infY9K9Hc5bdPGmloPswuNkDjm6a6P+aWx7C2tYq/ABpRpAweowhUNtNMLs7ZDqTd7Vce+HJE3ngTIkTLeEXwWlv4n9v8g+YMtJhkbQR2WbHbiGwNNNebyDweqp8l6AadizTkTOtyG8UtUzksHU6dgxyYxukYUF/LKpYMQ3+t+vfCEcLI2k/zcg2BZiUl++qvL5O+OxwCLRLVldsazBHUDyGY6WBM/+OU5Oj9fTdTUxOatZ3qOfdPgK64jF9Ivy9TxNqV10e4dnOq9ZnqGYmkN2BHl4jBIrCZ9LmuZhIJrNRQoCav4Hubdx+2ZP6ag+qdwoovpyVKdw3no5ENHyY4izP6Mp3PZaAQikNsbHl12GH4Tu1XEuOVDCoLAXvNUJQk5wBsnPc3Pr2PCxP4F0lfNw2v2AppzkdScmOxTTXGbVSsazfkpTkBRng2QzzpXVMB1RNYp92w6NnsxvSDioO1NO7r0tFdepYCTJifBdQTB3ex0rv16ZlcMLDIciFruBpBQAp2e78ViKk8UHnjzr0buAmocsmBoR2/ytmOo2SXv19MRD9LN7RNEq9+ojNTyBSDcry+yM/e5kwOJ64RXkgo1e+zHbKO2g621bhaEELnDolg5aXzy1t3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR11MB057924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHNpU1Q4Y25WeThGbEdtdU9mS0dmL3I0WS80OTFSbjAveEFLNENLQ3NIL0Fy?=
 =?utf-8?B?N2wzbmRzV1BJb1krVFVwdXMzTFJMelhjeVA0UWhXcXd3QzE3elpJZkxlUDFC?=
 =?utf-8?B?NDE4UlBpTy9GTXV6REFvVTZwaXFCYzI3cDhkOE5WUjdNSzUxbnY2UzVGZm9w?=
 =?utf-8?B?Nyt0Sks1TUNzc0Y0RS8rdUJNbG95NEJFaUl3eS9JK0xQUDZBdzRmdWRaK1cx?=
 =?utf-8?B?akFqMFdseUJvbjBhR2pGVzdlY21mYzA2RWJyWmZScXZkRWNnR3o1dnZTajky?=
 =?utf-8?B?U25FblpQaUd4ZjhFL0hmNW4rVW03Q3NZdU14UVNLcDhQbkJvOTYwemVRMnFy?=
 =?utf-8?B?WWNkQ3E5aFY4MG5ua0U2cnA5dUJscThGc0t3ZHEzeWY5azJ2YnVPUFl1dnlE?=
 =?utf-8?B?MWtWTHlDTUsvaUZmQzJGb1RLZWV3OFlBbzJhNlNZZDJOZGxZVEJTN2sxY3Fa?=
 =?utf-8?B?cXRQSXhHd1FmU3dLMWgyMHIyTXF1QTdqQ3Q3YmV1ejlFcTZzSC96TnJBekZS?=
 =?utf-8?B?RURWbUJCRVJwL2JLbDYrWklETFZweDJGeHBhdTFiWFkxMWZTNjlXdkppTU9Y?=
 =?utf-8?B?cjhQVW1DVUQ3V3J3ZUlUUGRiQldIL1E1eFJFWkZadDdlWWUzcmJaQTdFbWdu?=
 =?utf-8?B?RUh4dnhvMmQ3THpEYTVJZ1pLOUJnMjNFQUNXcStjSVVURlpvQVlhWE1UQXcw?=
 =?utf-8?B?SWdBeTliQmUvTEI5dWNpL3c2NjZPdnFYN3lNenRlem5vbDZxMWFvNGRzQmRw?=
 =?utf-8?B?V2xKaElKaHQ4YTA3RXVuZStjUUI2QS82QXBxT1FxL002ZXo0bmVPdjNjR3Rx?=
 =?utf-8?B?MThXZ2ZZdk80cTU1ZkdhdDBvNVhrcE0vc3R6ZTVpYndtZ09wMVJ5ZVQ3Yy9j?=
 =?utf-8?B?OXc2WXUybmt4V21JRHZIRnU5Vk5reS85SHdtTncxS2pPb1hPODRCTXJsOUQz?=
 =?utf-8?B?UHpqZzRJa1NoVG02TUdIajBodjY3cUhkSTNFNVJ5amtXTDJpOWFUWEtwQmkw?=
 =?utf-8?B?WU5Da05FdUVxRVp0U1liT05nNEZJT3RpOWJxS0VwQ1BWVXhiR2pGd0RzMU5x?=
 =?utf-8?B?KzE2WnNJbWNqMWZhd2ZLK1l5ZTZ0bEhjY0prYTlQZDFWNzk1bVpJLzgwSEhv?=
 =?utf-8?B?SnJ1NHgyRGNrcW8wbTFickFqM0dpYTlvZnhpK3JhMzRtWHNCOXVjMnJ3NDBQ?=
 =?utf-8?B?ckVhaWtJZThEN0M1eTl0TDVkM051RmxOQzR4dUM3UWgvOVUzdDBEV04vamYw?=
 =?utf-8?B?WEY1WHhaZ3I2VWNQZ0c2UEJWaFpmMzZHejZrdUVoTElTbUQzSUQvRG5QcGNV?=
 =?utf-8?B?eHFjMkh0ekRxWVlvUWFGVS9DQWpBN00vam9oZVhiRTB1b29YcDN3UnFuMGVi?=
 =?utf-8?B?ZXZpd3RnT1Vwdnc3bmhIa3YrNzhaZmgyN1d6RGdqVWRsUEZVdFVmQ0FMaHAv?=
 =?utf-8?B?V01tMmVRNStiNVNFdytCQzdVZ3F4djdWNDl4MDh6R0RrR3MvUzhPMVNkYXJu?=
 =?utf-8?B?bkZ6ZVJFdGdBcGtOU3AxNjduY3h0Umpmc1o4QWxpaWNQZG90ei85ZGo1SWZR?=
 =?utf-8?B?RC92emhwaG5qUUc3N0lKa1ZKdlNkWlo5SmNFbSs0RmIzdTRCcUY0aE95YTVa?=
 =?utf-8?B?c0I2azhueFF1Q1ZzSzdnaHJBZCtEQWhWUGcxVVQ3Tm1lODZFZng1ZnV1S1Rq?=
 =?utf-8?B?a3BPanlDQVAyY0V5ZjRLb043a3UzS0lFMFFBVzZ5Wis2WjBiTW95dGRiKzJh?=
 =?utf-8?B?SlJHQXFvMmhMSitsL0FYVTg1ZmJPQVI3aFpHb0xOUmROMUVkOE9nY1psNzhW?=
 =?utf-8?B?a3pxVXFKbW12ZWk0dVhiRks1WGUyRXRSWjUwYmdtK1Q0bHZIcTNNVkY0OXND?=
 =?utf-8?B?THNWNlgyNFBwdFUwdE9aTGlLUmlLUS9zVFQ5anp2VllZcnBIQ3h3S3hKM0Vo?=
 =?utf-8?B?TGZ6VFREdnNaT0RzUkdtejRWdkhRanMzMDFoZnVuSlFYYUZTcTRJKy9Lc2p1?=
 =?utf-8?B?bEg4cGphcnRReFl6eXNMcm5hNGp3VzZvdUpjVmtwdytpaFJGdjNRUXJPRUUx?=
 =?utf-8?B?N2FpemNvN0dMaEVxQTVvSkNadlRsS0tRS3prRGlsS3k5Q2oxdENQRy9SOCtF?=
 =?utf-8?B?MjNRRVRQOWxIa3ZzY1FJelpTaDk2YkFQT29jRGlLZnJyNkIwNDBuL1pkNDRP?=
 =?utf-8?B?UkJNczlIOUMxZmhpZ3ZJd2E3SitweXRRRDJ6S0c4VVM4UVVEZXVtQWVrMHRr?=
 =?utf-8?B?S2hrbzdTNnExbXlPVGF0YkZMVktHNUFjQVYzVXFIaWljdWhKVFR6ellDS2NC?=
 =?utf-8?B?RHNoM1RZNGx4cXlSZjIwRGZ4NytYYzJpZytsdzNlbUNRSncxNGRqQT09?=
X-Exchange-RoutingPolicyChecked: vSErwhhHYz1o2jndauGviPoLuwKBrgblT3U41wVzcWLe+UkAA0uV5Pt44ZbbzI71HDjDzjvrFwur+qU+Ho1Fqc4CwEK6LbuY+vvdmmw/Flpd7gHLBJSdXr+P9NsNks3A7ybKK6PmJRnZtK/9ZhGNadOVv/ZTc1RO0Ze/r/+3D+yLyHHrRzZ+WYp9SE4B8jR5FdK//RGSaFoxtwxRdFOlIpOo3mgmjNJ7BN3e7gNeHKQv6Ch+gWdgSZcVF3vfUKYapyh+5VZfNJZpN5Vo/tVElU5Mz7fY3GhVmozmOlKlTiykk/+BahlQ70q+ZxqFKMNGde/ToCTArfocErk/LBH5Ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e1a816-af88-404c-adde-08df14465b9b
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB057924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 23:00:52.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ75S8Xx8DoSlejXQNkumXDBEz4gqOqPg2NxGZWbH/s/iND9/B8yMSmL3BIhFGgLNV8X3u+uWAQBtP3T/iN7rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 03:31:50PM -0700, Edgecombe, Rick P wrote:
> On Wed, 2026-09-16 at 12:27 -0700, Sean Christopherson wrote:
> > > If you are thinking the implementation could punt on how to handle the guest
> > > interrupts for now, that seems reasonable. I'd think exiting to handle the
> > > host interrupts could not be skipped though.
> > 
> > I'm just trying to understand the scope of the problem we're trying to solve.
> > E.g. I don't think any design will save us if generating a quote requires a
> > CPU to be spinning for multiple milliseconds.
> 
> Elena, any updated estimates on CPU based quote generation and HW based?

The current estimate is 10s of milliseconds for HW based, and
milliseconds or less for CPU based.

> 
> > 
> > > > Does the TDX Module *need* to provide a save slot?  What would prevent TDX
> > > > from requiring the guest to provide storage for whatever in-flight data is
> > > > needed? That way there it doesn't matter if the guest never resumes the
> > > > call, it can only hurt itself.
> > > 
> > > I was thinking about this too, but thought it sounded a bit like the NAKed
> > > SNP secure AVIC pattern. At least the TDX module would need to handle
> > > getting asked to zap the guest page that was given to be a saved state slot.
> > 
> > But doesn't the TDX Module already need to do this?  It's writing guest
> > memory, no?  So it needs to prevent the page from being freed while it's
> > handling the quote.  Just put the onus on the guest to provide the same GPA
> > when restarting the TDG.
> 
> When you make a non-interruptible/non-restartable call, the TDX module doesn't
> rush out if there is an interrupt pending. It lets the call fully complete, if
> it is short. During that time, if it is operating on private memory it would
> take internal locks to prevent the page from getting zapped out or swapped.

Given that quoting could take 10s of milliseconds, I think this TDG
might need to be interruptible/restartable, at least during some types
of quoting. So when this TDCALL returns to the guest to handle an
interrupt, the host could take a lock, and then the next TDCALL fails
with a BUSY?

> 
