Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809731DD97
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228066; cv=fail; b=evnQNz2LLgDboDLMjDpx5nRGu1Cf49iQSjE1xifo77ixaqjJz4yMCGcZFy8wiH6Gs9mUrvZDu08G1aTgjHx6KaUI+WEtvs0h5rTwUS3VJPFcmVYU/w5/CosUEd3KIsl0Umx/vjIqU9nx3+yb+TD2cCbqp7R1uWM4LsGZplHb/Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228066; c=relaxed/simple;
	bh=tigcRsZVDkY8J277o/eAqPPa+7J59JML4b6UUb7KiyA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oVt4vpk41rJ7TUFljMy3391c8938tIA2t03wP+A9GAQp7C9cyIeE2Q4gz1cFqPOv0AMd0RuUDZDxFExyLamo6Ia8e/gtOH0VxzW7Eyam/fW5DPC7DYLhCPZIIWiHMsFu0vSvCKoMFDFLKhYVKoj7aSEEGXpwciPdA7MxVhc96UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkQJ4tEt; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkQJ4tEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790228064; x=1821764064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tigcRsZVDkY8J277o/eAqPPa+7J59JML4b6UUb7KiyA=;
  b=MkQJ4tEtffBcqhOh/ZkxHM+Era/nDwxfxv/Ss5d/ZO8tuKBxa8b8HV3e
   4z8KVTe3MM1EpkY/1HGa57e5jDtc06VeoxkwW+MQpC9rLFtdwhXj1VzY0
   qfG2HcXlYGRO+UO5MkTDT+9cyo4Fre5UCl7PhruMdN8V1gt76CSt0USg/
   pVnKrSkypetYKIpQqGfh5UWodyNIxIMEx1AJYUsLnWiqjT+dE0m/s4X25
   RY7RcWuPxXv4j1K26a8Jfu44jc4AG9EXCK68IyTyQlMYCd6cbWs5qATKD
   0KJsgh0PlqLh+SE9f7qnL9UFZs0Rvls+Yyb/zHcOSAxGyWq9/PjyZk40a
   Q==;
X-CSE-ConnectionGUID: W76iT4xFT8masJIgj2g3NQ==
X-CSE-MsgGUID: OZmfcUzcSy2M6pFVuCK8GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="94807073"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="94807073"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 22:34:23 -0700
X-CSE-ConnectionGUID: BCPH0M9fRWeRori+fmmyVw==
X-CSE-MsgGUID: FD6tCkKOS8+22EM/HiNTAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="274095440"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 22:34:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 22:34:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 22:34:22 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 22:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbYy/z7wUlOHOEzcpiV1F5f+jbhs89ZyqPLoXjmStQR+0XeQPDiyvCZRwHgShgG0Q11sSCOBBkGlDVzjP1u3Y0XP+6dLFc3LOVqNNE6EO2T/2sDJz/wwvrBlh0pBXz28qbx/jKFngALPKKFv1ycSye8IsWLOYYxnfb8NoojnCUAbsn/C6QwZug5Vz15zoVouUfGOk7Xgo8CiAkOyFzmVPUSXP6MQGNKVkI9DB/nVrhOmp5oqorWoCDGDos7IybXPG88wJLjyriTWh4oBTP8hOHeLEd0TSLDP24CCq1uEu03NKoIe5XdzPiFvQnTjl8G7JsFRu++xJpZy03FSrlr13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWK5dYbm16B/jyxyzz0wfOHQLIN+CUG6wpnJCGzgF8o=;
 b=NpqNVQNhOJUbmJa9JX4hWbnrgbpZWHYwN7L/LJM3tDe+vNc86IHPGS8A5tyYjcy3KMzpXn2cP5LPcnC2bcDg5jRRtFn0UCUyyhTnUd5B5ZE77zlCn1IE9o1TWjkfxw49aC9h1Y6nWljSwGu9fHSpAzPpkaUoS1q09AHPCUhXLTkEmlwgBcoMrKAaegU1AvKk6LUIi7znQc7zCHVAmqV0Yw4AQJKYk+VRi8ulJlhmdWVscqFH1r4W/pcdtFGnPoG2lSGCaIfWTWDhrRAqZlzlL0zkKCr8y3bIOBMxxPk5UzFYfDv456drnyKZals5M5Q3vQP4k6G7L8P39lUq9YWmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 05:34:18 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 05:34:18 +0000
Message-ID: <b6afcf8b-5cde-4c70-93fc-86127d1884e1@intel.com>
Date: Wed, 23 Sep 2026 22:34:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>, Fabiano Rosas <farosas@suse.de>, "Jon
 Grimm" <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>
 <arDHbjcwaRFcHb08@tlindgre-MOBL1> <arDVIEobkRr3E7yS@tlindgre-MOBL1>
 <ae22e1df-c09c-4f8a-8010-41e542e4c663@intel.com>
 <arIfu_A1e6KEokWI@tlindgre-MOBL1>
 <288de298-2773-4fa5-8020-21b61bbcad67@intel.com>
 <arN20-sGytS6BlZc@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <arN20-sGytS6BlZc@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|SJ2PR11MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc70d3a-da5b-4985-f4a0-08df19fd7a82
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|4143699003|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hveTR8Y44hb3a4GHV19IbT5YybWX3D5T4nVyB+Kgx1d3QA9OO1lLK5mvlBW4HrncVJqQG6KwD2rs4x01/mdHAXczfPuQBlCNiEFf5QQ+oHS1Kd1/7ufX3LRffILqrhTkvx0mSXv/tcPXTZ4bqUChapv2iXDBl78VDRWaYUSAEqCI8Ewrq7gFoGkLfDz0wFRS7OdowYAGOC49RoXGTPsDRd3MfF0Lym5fMCgjI/cF9+jZVD2WrWAUgJa8lkyqyHxBNGBfegDmxnJFN4OWWhsUp0yyZcemfhCd8zfIa4u7V4rbkx0LJicMi1faNZf415CubN0ecpCMfWu2bpHkSGwhVI66Vt/7CCKVSGiPEfznamkZSDv66dRORcNCOUO41mKO+TVWDEVNEVq3Fv3MFrnFGrsu7enqGAAtGBoYNeP5Avgff3tLFmcR/2mKiXoG9cQXSTQuXTBEdlvrr7tDAHQMYn08osJOGLWCQ60jwBAChb4jWk7BMxTTU+cs0DKbAv9M3Pjy28L18FSllTLwhxGR7BM/rHuhjPar0JiBH4pd9BbwzBXH+VExhHm6uCSxFxpPQV0mGzYFWxuaSJWvaZf06+IC7cGIUk19jHcaSfCHoWWt0vCXi29eH3lHe9r9kmmOCAObdpeEbR60YjpJESp46DReptT9g/6W/G3PQDc4f1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzRlRnRLekpGNVRsaHRFZjNKQ2x5YlZMWitIY1ZUeUVUcG94THdPdHhFUmZ5?=
 =?utf-8?B?dkhYZFdqQ1dCaUhCTjFac0ViSWh3SExjcWx2Q1Y5S211Y1A1WHRxWUhjT3dn?=
 =?utf-8?B?dVN3VjQ5WWxMc3hmNkJZRmFtanNFSU9xSkIxemMwOFh4L2pXK0RWVEl1SS9O?=
 =?utf-8?B?QkkyQ3Y1TVJLMWRKS1NKSmk3aVd6UFozQnMvRTh4QmNSN0tGdTVIZTI2d1B6?=
 =?utf-8?B?UnJqNzFtVjcya2k2SG9LWW9iRWt1d3l1emRCT2x0blhDcG4rcFB1VzlMZnpR?=
 =?utf-8?B?bitob0dWb2lvT2Y4RXpOdXpTMmZpV1ZsbFVtK3U1Tzg3aUFKV3VNRll4QUFE?=
 =?utf-8?B?SndqRDBCdDJtN2YvcVV0ZCt3akJCRDUxZUpJaWZGNktUdFlGb053ZWt3MjQz?=
 =?utf-8?B?eHFWUkdyRDd5Vno1UVZCbTdzazFFUVRmQUdtRzk2L2JmUE9CTTVJK3k3SVAy?=
 =?utf-8?B?N3NDTUZkQTdJb24xdXQ4WFBIZWVjODF3OEhKMDFVYnltd1VqTnMvNkp5dXMv?=
 =?utf-8?B?MzFmVy9ySFBpb2owY2VvWWxlTFR0UWZtOHloNVBZUlZPSTZISFZnVW1rUkta?=
 =?utf-8?B?THZnV3pFZkZWU0ttWHBJMHhPRCtyazZVSlZPcldKbXhUdUVGNlBES2JQY0NZ?=
 =?utf-8?B?K08wWGc0RlpTVWpZT0VWQmlHRFFBNE41emQ0czI0dzd0ZlNOYkxHaElTNWpu?=
 =?utf-8?B?cmUyWGhmSVNVYS85clo0VWlVWWdXYU5UWW1IOFFUdWNSN3c2RGhJVGgxRkc0?=
 =?utf-8?B?WStlSlBMdUpLTFovVU5NdlZSVGowUW80Szc3RXgyUmYyTHkxYzBGOWJpRFJS?=
 =?utf-8?B?aUZBNWt6V3dpS2I3RHFzeVp1bzNtVGNBTmNMNG1RdWJ0KzdkYWVKNHgzOEZF?=
 =?utf-8?B?Y2VLd2djQmtWcFJTMHR4S0NNbzU5QVZ5Ykl3c2xPbHBSMHF0enpackxyMk13?=
 =?utf-8?B?cXIwU1lVVWdkYVhKRDRFYnVkYUdtcDV3eWtMSUJ6SDFCM3phc09yeWV0RVlN?=
 =?utf-8?B?UjRRZmw5emtKTkpodUVTa2o0ZVE3WHZxZUFjWG9FWmtsUGg3QVUyaE9YeUxN?=
 =?utf-8?B?TkpsaU1Td0kyLzhzdnFndFJONElNSnRpbzBaZUNkTUhFYWRqaENZQmp2K0Jv?=
 =?utf-8?B?L0pBMHRvUS9LNjRnVXdnVUh0bnhubWJaK2tONjBmOEhHbzh2eGRTWFBhbzZ2?=
 =?utf-8?B?a3FXZGR3aHJob0EwdXNGQ2F0cWlDenB1WWt6UWZhZGI4NXRqTlRrWDdHQzI5?=
 =?utf-8?B?bHVDS3A1blNZOFdlaGd4ZWo3b0lZZ3hqV2t1bVJWeDFuRzVsLzZYNHBTM0xP?=
 =?utf-8?B?Z2hySWg0QzJXN0hXMXNrUFYzYnd6emQyZmpaUlBPNVlWWUY3RnBDRVRrVTd3?=
 =?utf-8?B?TDljNHJ3a1VvODkyT2RmVzZYVWNaNUNJTlJwMU9peXYrUlZLTmxzZk92NGJ1?=
 =?utf-8?B?WGhxRGJwSjdteENNNmNOcTJXb1FNbi9xV2RONXR3d0ZpWVdkLzJnSmhsNHl2?=
 =?utf-8?B?am9iT0VLWlpabjlINytvQ2kyNWlsTHYzNWczdmZPT2w2VHJvT256L21ZQ3Bv?=
 =?utf-8?B?Rk84UmNlRFNiay9RWlNaRnlKc0FWQ29YdUtXUlV2L2tZUU85YnhsM1lhV2lV?=
 =?utf-8?B?dnh0YWZmTEx5bDRzMEtEZnpvN1h2WHFnM1RHeTIvYUsvMlJaaitvU0NNc3dw?=
 =?utf-8?B?YkluN0svVHNtdnJlRmV6Q3RtbUtJR05wem5EU3ZudWRNUnArUUpYa3hEOGRQ?=
 =?utf-8?B?dksvc3c1elB3cnhma29HUjhZckhGQ0JjNXZKQjhQdEFOSzlLdlk2ZUE0YVc0?=
 =?utf-8?B?RGJGclhRUjBqRUtzN2krRFJoQ1lQTmhZWjJNMGVuZ1BFMzliT0lXcTlHbDEx?=
 =?utf-8?B?M013K0R0aTUxV0wrQXEraENudzJzK0JmRDBNdkdPYThaaEJjTHVteXlnejJX?=
 =?utf-8?B?U29UTUNnVEJBai9tUGdPVm5ISVJHK01EOFJvc1pjYUxjaDF4K3pmeUROTGNT?=
 =?utf-8?B?MjQ0VGMrY3JEdEY5SWJtMGNkMnpGZ2lDWC9BMEFPQ2dmUklNNXduMjk0RWxh?=
 =?utf-8?B?TGR4eFljaUhMekdHN3ZuelNCeTZxd1BVSTV0cVdSY05SMm1yVzZkYkxkZ3JI?=
 =?utf-8?B?Q1owdW1LbW1EcGwxbjZaTDN0TDVHMExDV3J3bm0rSmcwKzRNbXdPdFpLazRB?=
 =?utf-8?B?eEJyUkJtTVJwd0ExNU1qbVdJdm01d1VkTmR2TXdDRUVOams4ZHdyQ1VUL1ZN?=
 =?utf-8?B?a2hrOUM3eE5HWGdDZjZSbUU1MGcxbkpVU1RUVVBVT2tRZk9kcEZHQm15VHBk?=
 =?utf-8?B?dzc5MFVmYlR3bEJqODRGbUxFZGUrZzIxUVdBdzVoTkxqQjk4cEVRQT09?=
X-Exchange-RoutingPolicyChecked: CuthNXYAobIRhHOG2v9VBw3c/GXK7NDdw5Ud/8FL3O1VxyYNuhQj0JfPaB4Jc3Z9LE7LFpRELSRDfpoaP2bwckBc/shFMp8YHgLAVvdh7YtI8J4ptVVrqn3qbnSptSy3AbRjyea/1dDZfdbEPd1dfnkGLpqIhP2iaNyuKbxJo4oaNtdwSmjGOo5Q9A8XFhuLjVRqkt0K5eNJ+GHaHl0dd37pQI8NK84F3+Ld7vB+ioGbkVwYNk8kIn1mgR7LQTWOLldaTeXK0DwdKuFugg4PAEKf0hBe+aPFTdFvcpVFBUPFdBLqYzK6VX1NL5LS1JTpeNx0HoQTLTHlOj8qHNlA5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc70d3a-da5b-4985-f4a0-08df19fd7a82
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:34:18.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A8VNNuvLMeoaR8D/SJrrnbkqH/NO41NBCRP3qxEvKLzjbs7ScoNIP2QvZLfBci0hDLQGjzQttYCLeDsZLUAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8450
X-OriginatorOrg: intel.com

On 9/22/26 11:50 PM, Tony Lindgren wrote:
> On Tue, Sep 22, 2026 at 05:37:33PM -0700, Kishen Maloor wrote:
>> On 9/21/26 11:27 PM, Tony Lindgren wrote:
>>> Oh right thanks. I think this is really the maximum transfer buffer size
>>> Peter asked, not just a hint to userspace :)
>>
>> It is a strict upper bound. Maybe it's semantics, but I called 
>> it a "hint" because allocating for that entire size could be optional.
>> If a userspace driver for say TDX wants to send smaller batches (say 128) then 
>> it can refer to the spec, do the math, and allocate 131 pages and the kernel 
>> should permit that; it's not wrong. If userspace ever allocates less room than 
>> a call requires, it would fail. A different userspace driver could simply 
>> allocate that max size and be done; no need to refer to the spec or do the math. 
>> It is for this second case where I thought returning the upper bound would be 
>> useful. Hence the earlier suggestion.
> 
> OK 
>  
>>>>>>>> +struct kvm_transfer_buffer {
>>>>>>>> +	__u64 address;
>>>>>>>> +	__u32 size;
>>>>>>>> +	__u32 reserved;
>>>>>>>> +};
>>>>>>>
>>>>>>> Should this struct include a 'capacity' field (u32) that is set on each command?
>>>>>>> It would be the number of bytes writable at address.
>>>>>>> size would be the input length on entry (0 if the command passes none), and the
>>>>>>> number of bytes produced on return (0 if none).
>>>>>>
>>>>>> Hmm so the transfer command return value can return how many bytes were
>>>>>> written of the input. But yeah we don't know how many bytes were written
>>>>>> back to the transfer buffer as result of the transfer command.
>>>>
>>>> The transfer command return value could return how many bytes were written into the buffer.
>>>> But in an input-output call, the kernel handler wouldn't know how many bytes it could write,
>>>> or for that matter even how many pages to pin up front in case it needs to return an output
>>>> because 'size' couldn't simultaneously convey the input length and buffer capacity. That was
>>>> the gap that I thought a read-only 'capacity' field could bridge. Of course, this
>>>> assumes that the output is written in-place.
>>>
>>> Hmm yeah this inplace capacity vs transferred issue remains still. So I
>>> agree we need to specify the capacity in struct kvm_transfer_buffer like
>>> you suggested.
>>
>> To be clear, I think the in/out split for the buffers along with the convention 
>> I laid out closes that gap I saw without needing a 'capacity' field.
>> Because out/size could now unambiguously convey capacity on entry and output
>> length on return.
> 
> But for an inplace buffer use with some input data smaller than the output
> data, would it work? To me it seems you need both buffer size and data
> size for that.

Yes, with two kvm_transfer_buffers in the transfer struct, it would work, whether
the call uses a single userspace buffer or two.

>  
>>> To me size is already the size of the buffer though. So instead of changing
>>> size to capacity, how about something like datasize or len for the input
>>> and output transfer length?
>>
>> But I understand that (and please correct me if I'm wrong):
>> a) You'd still prefer to not have 'size' serve that double duty.
>> b) 'size' in your mental model already means buffer capacity.
> 
> Heh yes correct for the above.
>  
>> In that case, we could add a 'datasize' field to convey the length
>> of valid data in the buffer, like this:
>>
>> struct kvm_transfer_buffer {
>>     __u64 address;
>>     __u32 size;
>>     __u32 datasize;
>>     __u64 reserved;
>> };
> 
> Maybe bufsize and datasize? Then the difference would be obvious while
> reading the code.

Sure.

> 
>> The convention then becomes:
>> - A non-zero 'datasize' on 'in' at call entry conveys that there is input.
>> - A non-zero 'datasize' on 'out' at call exit conveys that there is output.
>> - out/datasize on call entry is ignored.
>> - in/size and out/size are seeded with the buffer capacity.
>>
>>>
>>>>>> How about if we add the bytes returned to the transfer struct? Then the
>>>>>> kvm_transfer_buffer can stay as just a buffer. 
>>>>>
>>>>> Actually, for the possible cases with input+output, we could reserve space
>>>>> in the transfer struct for another struct kvm_transfer_buffer for the
>>>>> results?
>>>>
>>>> Yes, say an 'in' and 'out' kvm_transfer_buffer inside struct kvm_migrate_cmd should
>>>> close this out and shouldn't require a 'capacity' field. Maybe we then establish this
>>>> convention:
>>>> - A non-zero 'size' on 'in' at call entry would signal that there is input.
>>>> - A non-zero 'size' on 'out' at call entry would convey the buffer capacity.
>>>> - A non-zero 'size' on 'out' at call exit would convey that there is output.
>>>> - A zeroed 'size' on 'out' at call exit would convey that there is no output.
>>>
>>> Looks doable to me but with the inplace issue as above.. Sounds like we just
>>> need to reserve space for a case with a separate output buffer though.
>>
>> To be clear, this is what I thought we were talking about :)
> 
> Heh yeah we're talking two things with the inplace use vs two buffers :)
> 
>> To add a 2nd kvm_transfer_buffer to kvm_migrate_cmd, like this:
>>
>> struct kvm_migrate_cmd {
>>      __u16 command;
>>      __u16 flags;
>>      __u32 reserved;
>>      struct kvm_transfer_buffer in;
>>      struct kvm_transfer_buffer out;
>> };
>>
>> If there is agreement on this model, then yeah, we'd want to define
>> these fields now, since the struct can't grow later without a new ioctl
>> number.
> 
> Based on what we've discussed, my preference is the following:
> 
> Keep the current buf naming. For the EXPORT/IMPORT type functions the use
> should be obvious from the transfer type. 
> 
> Reserve enough space for a separate output buffer or results buffer or
> whatever it might get called if such a use case ever pops up.

Reserved space can be named later without changing sizeof, so either way
works. I'd mildly prefer to declare the second kvm_transfer_buffer just
because declaring both would settle the second buffer's semantics now. Not
something I'd push hard on though if you prefer reserving.

> Add the datasize to struct kvm_transfer_buffer like you suggested and
> rename size to bufsize.
