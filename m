Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC33043C8;
	Wed, 25 Mar 2026 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774413329; cv=fail; b=Zm4d8j+DvOsvY6HPkj1GJA2c4pK7xfnZWkXaHIeypDO06N7qBXwW/rHxEXTwkihzEE7i0cxXDGZCEehC+9G8d7vjIzHlGDhAfdKJHRKKH908vhnjVS8R1Ielm5vHSh9O6ytK61eEv/KMJwUcUBJYJlTbrBceAIhtEtw97W5zXDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774413329; c=relaxed/simple;
	bh=4Dl+2bZutSfDeQAMRDouHG4AIQQTV2/rmhovdYJPfkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gzBKx18gOHdhNeR37tOVgnA8NVeyCne+E1bSr/N28T4YeV9MQHmalLIgW7wO9tBdtLnnU0pjJAwnipeorHFmzAJYQNqk3CXfje+Vc5SGYGj9aZgJTXZ3mvL3h2WnZuSJWnV7o32vA8YfNrLKj30YbGc8iexWhOcswfR0bKlMmtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuJCy6mx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuJCy6mx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774413327; x=1805949327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4Dl+2bZutSfDeQAMRDouHG4AIQQTV2/rmhovdYJPfkE=;
  b=fuJCy6mxYExiSgx3jFCrZYhVha8MOQn52M9vl/qyKmuzKGUnV/42PIFA
   R1uGeCHy1bnDcTrKxYv9a4kOdP4sT6X+AzhhgHVq6AYYbNTWyaTx9WVXn
   AAUvVUfzBzekGzCMHEBjmcavmmc+vMw23YIY4p1asX0wsEELmsKKs3+0e
   gMnWacwsp1YuddhHxtKEfSLOosUWr4rvWfY7xwKKLUjQu2AOhDl+5vbTY
   /L+i7yhRPisSuQPVyozkQitfhYk1XnbG2ECZRnNBFny6rf2TZAbpiS6ca
   XWPlRSTjGfmxVLLxRuB36W4aCLeucQGjnSWUMqyxwd9SUYUxka9aqFHED
   w==;
X-CSE-ConnectionGUID: F0O63h87RyCH0pIeFnXW2A==
X-CSE-MsgGUID: qJ4udMmRRjazkVV6E/87DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="78043160"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="78043160"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:35:27 -0700
X-CSE-ConnectionGUID: Y7xzUMSjQGatr2E9SIoZ1g==
X-CSE-MsgGUID: QZSUaDB2Qna6+TtuB4w62A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="223625797"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:35:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:35:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 21:35:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:35:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENLEgoVnLYkx1Bnmq/aXGDqHQV1x8EeufHCdXDFjm2OrwOjlNZ/IYYNP0YUqHAj3l0uG5XyqU30Cf61KlITTRRhD/QBkZmHWSGTYua1QzO+7RSAPK361gSBQ4mIhfH9gRc0WUoDpgY5++4zJf8doTHzXZsdnIh9sty2UGfo+aJX1nl/ErI3L5QsIl2Ozp4x0EZofEkUBxkST/uHV1cG6Vus6BWoT/+QZeerovtKpvuwGXO4TNvULSIFLozhJnCQ0BxHgn0+7bIpsGAiw9is3FrlWM+7XEuAxUYEhDHFMS0Alw8/QD8Pq6t4PPPiN4ywYxhv/gsMak4d1eTohEJg9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Dl+2bZutSfDeQAMRDouHG4AIQQTV2/rmhovdYJPfkE=;
 b=Vez74NeHLkzed/BPu6p9/Bnv24iEt4YPrVtIwKjWwDUJnS6W3sY3LFPW/66r7vT/j0gRsJgc4XVW8b6YrZhnqiz1Z6iZQlrfqA9hNmnxV/8zeZnBfMxPvA9tJFX3uu2B7yZ9q/lZwAxHkbbZQuHorcWUx9vqX5LPBO+p+NN+a7nxN6ON5e6gNndwDSrdEsSv5cO46v0gPLpBuT/aBuw5QmOfFf3fBQQGek9NviXB7vBTddu2ideZLOsL1mYkGKwjrOehKtnBIXbMNiKZjt/i0MIx724IVIlwl334Z81JbfDWl64rmVqxt+ZvJKk8jK9kgBJmzfv9oTQIgp7kR4IPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 04:35:23 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 04:35:23 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "amit.shah@amd.com" <amit.shah@amd.com>, "Kohler, Jon" <jon@nutanix.com>,
	"seanjc@google.com" <seanjc@google.com>, "mtosatti@redhat.com"
	<mtosatti@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>
Subject: Re: [PATCH 04/22] KVM: x86/mmu: shuffle high bits of SPTEs in
 preparation for MBEC
Thread-Topic: [PATCH 04/22] KVM: x86/mmu: shuffle high bits of SPTEs in
 preparation for MBEC
Thread-Index: AQHcuMdIRONsl1B0uUixFQ6wYb/I17W+sAQA
Date: Wed, 25 Mar 2026 04:35:22 +0000
Message-ID: <59cb97dbac0527e0ba8153116af942f972e4aea5.camel@intel.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
	 <20260321000931.1947084-5-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-5-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB8208:EE_
x-ms-office365-filtering-correlation-id: 217584d9-5a15-4968-fe10-08de8a27edb7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 3nAG28ZbeKIfpzUkZhfpmgpwUG65boHm7EFv89D+wMhqI5OCaRwsBFALNDEKPUaqBKdVzMXNNmHPXwX81RHVvhM5h40TT3CgGC8NSM78FHd973AWo+vdD+DCXziVa7riEweOE+uzt5xIhEW6wUtNXC1/xyLxYXYlEa5i80Yn7IBqOpGiW/ld8n5IAq+zkTVM37PV0uykIYx5+lad9Y0F9HV1jwXplPM0NPWMhqaDSur9HpkthDoAnEEVzMGCBNaQXWsJ1OhSEDdXC4YoOXficPfW+XPQlCw2bUVXFA1/0ECbrkMxUIsKNGCuiydf+wjWcOKHyVIPVGBVSyrVdNAbyHcNUOcZp08cTtkgyqoBF2VA4eqrwPyiXgmsHz234DBPYJwOlrdYSWB/ridEuJ9oB7WUJLCrsj7buIQnizCxJYy/DgonbzlfNvblyJjb+qiBOZwVMMuwd9/GyZMKZzi5SqSoF0vmBPCxcKfuL1VFcqvgbkF++5jkIFSZdXGHi7mOS2SEU/hFM1xmX64VpX1rIQlcRp6NjGsOIpETXfvL4hmKrOgJYSuqCNnio69lWxIoIh+kQciO5pg5pa8jXDhp8ewPOWAIfBqviIf7F+R9LzRlrUGzBaJ/ar9TkL9/iw/hFHNI2CuM44sSvuKdqN+wvrBHyw3n7znFkZXANGyee+Y99yJyU9cLxCQ0apv4/FiH9S8TtX7AbimOC3fzuEtqxQxjHPQyb4sO41C81U78Ece9JOpm/HfBEj25G4CcLm4OOQI0STqHqqTq8g7DtYLFdzb+79MBrRygfpTsJmFeytc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVB5c3pvamtMN3JCMk9BOG9iZ3RVSWNmM0w4TXRja3lwMXF0SzFtODNSeEtT?=
 =?utf-8?B?WEN2MTdoQ0hKNEp3T0JWdzZjNmM4dklXeUlzdFphVnU5STkrWVlLajlzdHc2?=
 =?utf-8?B?ZFUwTnVDSTNQYkxhOGdrZW9SRWhnK0hVeFRZK0x5K0o0azlqUXkwNFovbFV0?=
 =?utf-8?B?dXRIVVkwM1RZUUt6S0hxbENTdnZBY2FZYVFNczE2SXFEdERqN1dKRHVxWTVr?=
 =?utf-8?B?MmVxbEdkcEE5dzU2YXFOSWtrNVEzNzJucFdZakZVMVZYak4rcVl0OTlLZURB?=
 =?utf-8?B?QnJIcERSQmw4Ty9yQ2llRStIUFhWZlU5dDl1aGo2VDh1THFRK1dIZ0NJMWpZ?=
 =?utf-8?B?VjFvc01BRU93VEUwVi8wcytNQTgxTnFvWHJ4V3E0b256Y2pmWDRUZzlTeE15?=
 =?utf-8?B?cURON0EvdGNWUkkydFFlaGI0TThFdUM2ZlhWaTJQNEhFeDlGMUJVRDZ3M0Ra?=
 =?utf-8?B?anRNaTFMb3ZzeGVsSTl0Z1BURDR1K1U5eFVjZXRjTEhVZnVMTE1ud3d4c053?=
 =?utf-8?B?R29tUDBUYlVLTjBvM1I1NWxmTSt1T0pMMWZxTlBGcElLc2JqYkdnZ3lPZHUy?=
 =?utf-8?B?MmVBUWgzSm1iWW5yRmVtN3kveE0wTktOcUczRzlhRVpuMkU0RkFpMFJOM0lp?=
 =?utf-8?B?ajRHQWh0Q2dGRXZiVjJzSzd3N3pNM1crcTdwTWtwUHNLOWZlNE5Jb05TZHRJ?=
 =?utf-8?B?SjByOWc5MkdxeXk4Z2tYT1pwZ09vSUN0RGgzazM2c0VJQjNoeHFiNlhNUzd5?=
 =?utf-8?B?STRrUmV2TnI0ZEIwam9UZ3BXWU4zS1JjbEh0WHZpUk85QzRpSjdKaWJ5VVQ0?=
 =?utf-8?B?S1V2R3BHUE8yZjMwc3RSRGd6Q1dobkJDK0pZWW03OXp5R3ppODJFY2Rwak9V?=
 =?utf-8?B?MTZOaGRBR05hdUk0K1RmVlRmdlVMRVdwZkI1YWlPY2d0bTBRYllYWURpOXcx?=
 =?utf-8?B?QmR2Visvc0ErV0JRTzY0Y2lLUENLTTZDdE9FNi80Y0d4eloxSVhZMnBxOGd3?=
 =?utf-8?B?UlFORFNDRUFMZDBmbVNwdUxtRTZMOUM2Z0pGL2hiVXN0aHl5VmFMQ3BmY3Zo?=
 =?utf-8?B?bitUZHlTOUZDMkJuYkx2TTVQRVp4aTZERkRPMGh4N0wzSm5KaVFFUGdYOUJG?=
 =?utf-8?B?YXFjTVg0K1g1bEhURFVBWjhZNFEwMjYzb2d2UlBWYjFoZ1dhN1o3RTFUaHM0?=
 =?utf-8?B?V05BYllkZE9EQXR4QlI4NmlUUHJ5bWZCWGRjK2RscVhMWkFRSitFVzFkWnZl?=
 =?utf-8?B?QjJXSGJIWlBTamVmdFFXNVd2QitqVXkrSTVqV2tERGd0RnpDREhxQ1FYbENu?=
 =?utf-8?B?VnZOdVhhOHNzQUlicWF0Q1hNa1VqTkpIVWN4MTFWQU9LYk5Bc010OXBacGdo?=
 =?utf-8?B?TllZN3grNkNJdzhHSzRSb0tZRGVYcWZJbjZhMzRlQjJxT3hHRVphMzM1Qkhm?=
 =?utf-8?B?UEVpcU1OcFNVd0g1WTJ3SWwxeWY2NjRlQUpNeHZvRk9DQTNsRGRvQXNWNDJF?=
 =?utf-8?B?K0g0MVRkSExVWDFaNHk3bVBIMjRZMjJqVmtBOXVabmx0R240enU2SWI2YTc3?=
 =?utf-8?B?aTdlSGthR0VVbFMxVmRJZ04vc0FnejFlVnV1dmVwZkd5WE5mMm1Ialh2dVl1?=
 =?utf-8?B?NER0SzVLQ2pUWVpjTHd0bkp5azEzakpSeXNEc1p2d2hnVmwxa0w0WU53dldW?=
 =?utf-8?B?Z0ZzSnJBZ3lNbEdTNDVQTDNJc3J4aXVnSjd5QmFhSDdTYkxFdkN3R0NTenNU?=
 =?utf-8?B?YmtSZWZwSGRiMDBqQ3g1emIyelJDMTVJeFNjLzI1KzdXV2QzZ1FuM2U3cG9H?=
 =?utf-8?B?YlE1OGhYYjdYMjhwMG4xUWdDQmlBV2dnTjdJTmZTNWVVdGRuWitOR3JGd3g3?=
 =?utf-8?B?YVZJRGJGbzlUcXJ3Vzl0Q052eFBvZ2dzVTdCWGQrTU9kR0JhV0N0eGJmNWFP?=
 =?utf-8?B?OStFaE4zQ1YwMjZkN1J6VWE3KzJNbk9XTDREUTlPSFJ4SS9nb3BjSU1Fc2lv?=
 =?utf-8?B?V01kT2Y2SDZOR0pSdE9ITkpUSk5rWnNXMVdFcEsxaE1ITHRMQVpmTE1OTnVB?=
 =?utf-8?B?UWF2VTNzcjR6bEtKT3gzVHZzaVZBencwTmxib2hDWnNKRnErQXpaL1JFYzhP?=
 =?utf-8?B?d1dCTzAwZUtoa2J5QVhIQUdrY0tSUFpMZjVPUW5BSDhDNEpmbWlLNUZzdjB1?=
 =?utf-8?B?dE54dWJPY2hJUUwrUnBDeit1NE5XL01WYVMzOTJiYXAvSnpxODE0Y1dxTHh5?=
 =?utf-8?B?S0Zmc3NvT09MZUNEb201MDl0TmVNS1V0clFiMjk0cHlubHJrb1VGK3lJMVJD?=
 =?utf-8?B?Um1DOFg2SjJqMHMxVHpETmsyWExpdDZNSEZIYUV6a0krRGY0Y1lWUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7E44C31410DB74BA8736BE579E9EC7F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: I/s3uGhPsp35xurylAt5FPM8Cf6sY29nocNTZnOGgenAnGtWo411+whyNDzGaic+pKpuCttRTXC6sVshi4jh1maQS0X74Yb8gYyW6WvzlvcqD4W4Br/6bGmTXFGlKkMg1V8tTG7EMAQf18nWR9NVRHfUtfpnZWnkd04Z0+BAxg/xJNkE6p+/JrMsg/oxcixkoVtjgpLlVW/3D2AgoHLDd6j3R8/L5tR6QNOEZJx1hCihUL8D8guoOHS3NLsoYRiXgIRY3VN1UTmvpzvAAnUSj/W+4P6yBLqBzX5oV9IOBJfui/ZO0KUrp3XYIytzlDR9FbFRhQQeRTE9/gRg8mKHDA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217584d9-5a15-4968-fe10-08de8a27edb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 04:35:22.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kswQKGRA4vLN2Aip/WFblOTH+UpzjKtOQDUYmSRsEZ7FVL4WoozIthfk6zXydid5noATaBGHMiqDyFF39UeGVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTIxIGF0IDAxOjA5ICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBBY2Nlc3MgdHJhY2tpbmcgd2lsbCBuZWVkIHRvIHNhdmUgYml0IDEwIHdoZW4gTUJFQyBpcyBl
bmFibGVkLg0KPiBSaWdodCBub3cgaXQgaXMgc2ltcGx5IHNoaWZ0aW5nIHRoZSBSIGFuZCBYIGJp
dHMgaW50byBiaXRzIDU0IGFuZCA1NiwNCj4gYnV0IGJpdCAxMCB3b3VsZCBub3QgZml0IHdpdGgg
dGhlIHNhbWUgc2NoZW1lLiAgUmVvcmdhbml6ZSB0aGUNCj4gaGlnaCBiaXRzIHNvIHRoYXQgYWNj
ZXNzIHRyYWNraW5nIHdpbGwgdXNlIGJpdHMgNTIsIDU0IGFuZCA2Mi4NCg0KU28gdGhhdCB3ZSBj
YW4gY29udGludWUgdG8gZG8gYSBzaW1wbGU6DQoNCiAgICAgIHNwdGUgfD0gKHNwdGUgJiBTSEFE
T1dfQUNDX1RSQUNLX1NBVkVEX0JJVFNfTUFTSykgPDwNCiAgICAgICAgICAgICAgICBTSEFET1df
QUNDX1RSQUNLX1NBVkVEX0JJVFNfU0hJRlQ7DQo/DQoNCj4gQXMgYSBzaWRlIGVmZmVjdCwgdGhl
IGZyZWUgYml0cyBhcmUgY29tcGFjdGVkIHNsaWdodGx5LCB3aXRoDQo+IDU2LTU5IHN0aWxsIHVu
dXNlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhh
dC5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYva3ZtL21tdS9zcHRlLmggfCAyMCArKysrKysrKysr
KysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21tdS9zcHRlLmggYi9hcmNo
L3g4Ni9rdm0vbW11L3NwdGUuaA0KPiBpbmRleCBiNjA2NjY3NzhmNjEuLjcyMjNhNjFiMTI2MCAx
MDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL21tdS9zcHRlLmgNCj4gKysrIGIvYXJjaC94ODYv
a3ZtL21tdS9zcHRlLmgNCj4gQEAgLTE3LDEwICsxNywyMCBAQA0KPiAgICovDQo+ICAjZGVmaW5l
IFNQVEVfTU1VX1BSRVNFTlRfTUFTSwkJQklUX1VMTCgxMSkNCj4gIA0KPiArLyoNCj4gKyAqIFRo
ZSBpZ25vcmVkIGhpZ2ggYml0cyBhcmUgYWxsb2NhdGVkIGFzIGZvbGxvd3M6DQo+ICsgKiAtIGJp
dHMgNTIsIDU0OiBzYXZlZCBYLVIgYml0cyBmb3IgYWNjZXNzIHRyYWNraW5nIHdoZW4gRVBUIGRv
ZXMgbm90IGhhdmUgQS9EDQo+ICsgKiAtIGJpdHMgNTMgKEVQVCBvbmx5KTogaG9zdCB3cml0YWJs
ZQ0KPiArICogLSBiaXRzIDU1IChFUFQgb25seSk6IE1NVS13cml0YWJsZQ0KPiArICogLSBiaXRz
IDU2LTU5OiB1bnVzZWQNCj4gKyAqIC0gYml0cyA2MC02MTogdHlwZSBvZiBBL0QgdHJhY2tpbmcN
Cj4gKyAqIC0gYml0cyA2MjogdW51c2VkDQo+ICsgKi8NCj4gKw0KPiAgLyoNCj4gICAqIFREUCBT
UFRFUyAobW9yZSBzcGVjaWZpY2FsbHksIEVQVCBTUFRFcykgbWF5IG5vdCBoYXZlIEEvRCBiaXRz
LCBhbmQgbWF5IGFsc28NCj4gICAqIGJlIHJlc3RyaWN0ZWQgdG8gdXNpbmcgd3JpdGUtcHJvdGVj
dGlvbiAoZm9yIEwyIHdoZW4gQ1BVIGRpcnR5IGxvZ2dpbmcsIGkuZS4NCj4gLSAqIFBNTCwgaXMg
ZW5hYmxlZCkuICBVc2UgYml0cyA1MiBhbmQgNTMgdG8gaG9sZCB0aGUgdHlwZSBvZiBBL0QgdHJh
Y2tpbmcgdGhhdA0KPiArICogUE1MLCBpcyBlbmFibGVkKS4gIFVzZSBiaXRzIDYwIGFuZCA2MSB0
byBob2xkIHRoZSB0eXBlIG9mIEEvRCB0cmFja2luZyB0aGF0DQo+ICAgKiBpcyBtdXN0IGJlIGVt
cGxveWVkIGZvciBhIGdpdmVuIFREUCBTUFRFLg0KPiAgICoNCj4gICAqIE5vdGUsIHRoZSAiZW5h
YmxlZCIgbWFzayBtdXN0IGJlICcwJywgYXMgYml0cyA2Mjo1MiBhcmUgX3Jlc2VydmVkXyBmb3Ig
UEFFDQo+IEBAIC0yOSw3ICszOSw3IEBADQo+ICAgKiBURFAgd2l0aCBDUFUgZGlydHkgbG9nZ2lu
ZyAoUE1MKS4gIElmIE5QVCBldmVyIGdhaW5zIFBNTC1saWtlIHN1cHBvcnQsIGl0DQo+ICAgKiBt
dXN0IGJlIHJlc3RyaWN0ZWQgdG8gNjQtYml0IEtWTS4NCj4gICAqLw0KPiAtI2RlZmluZSBTUFRF
X1REUF9BRF9TSElGVAkJNTINCj4gKyNkZWZpbmUgU1BURV9URFBfQURfU0hJRlQJCTYwDQo+ICAj
ZGVmaW5lIFNQVEVfVERQX0FEX01BU0sJCSgzVUxMIDw8IFNQVEVfVERQX0FEX1NISUZUKQ0KPiAg
I2RlZmluZSBTUFRFX1REUF9BRF9FTkFCTEVECQkoMFVMTCA8PCBTUFRFX1REUF9BRF9TSElGVCkN
Cj4gICNkZWZpbmUgU1BURV9URFBfQURfRElTQUJMRUQJCSgxVUxMIDw8IFNQVEVfVERQX0FEX1NI
SUZUKQ0KPiBAQCAtNjUsNyArNzUsNyBAQCBzdGF0aWNfYXNzZXJ0KFNQVEVfVERQX0FEX0VOQUJM
RUQgPT0gMCk7DQo+ICAgKi8NCj4gICNkZWZpbmUgU0hBRE9XX0FDQ19UUkFDS19TQVZFRF9CSVRT
X01BU0sgKFNQVEVfRVBUX1JFQURBQkxFX01BU0sgfCBcDQo+ICAJCQkJCSAgU1BURV9FUFRfRVhF
Q1VUQUJMRV9NQVNLKQ0KPiAtI2RlZmluZSBTSEFET1dfQUNDX1RSQUNLX1NBVkVEX0JJVFNfU0hJ
RlQgNTQNCj4gKyNkZWZpbmUgU0hBRE9XX0FDQ19UUkFDS19TQVZFRF9CSVRTX1NISUZUIDUyDQo+
ICAjZGVmaW5lIFNIQURPV19BQ0NfVFJBQ0tfU0FWRURfTUFTSwkoU0hBRE9XX0FDQ19UUkFDS19T
QVZFRF9CSVRTX01BU0sgPDwgXA0KPiAgCQkJCQkgU0hBRE9XX0FDQ19UUkFDS19TQVZFRF9CSVRT
X1NISUZUKQ0KPiAgc3RhdGljX2Fzc2VydCghKFNQVEVfVERQX0FEX01BU0sgJiBTSEFET1dfQUND
X1RSQUNLX1NBVkVEX01BU0spKTsNCj4gQEAgLTg0LDggKzk0LDggQEAgc3RhdGljX2Fzc2VydCgh
KFNQVEVfVERQX0FEX01BU0sgJiBTSEFET1dfQUNDX1RSQUNLX1NBVkVEX01BU0spKTsNCj4gICAq
IHRvIG5vdCBvdmVybGFwIHRoZSBBL0QgdHlwZSBtYXNrIG9yIHRoZSBzYXZlZCBhY2Nlc3MgYml0
cyBvZiBhY2Nlc3MtdHJhY2tlZA0KPiAgICogU1BURXMgd2hlbiBBL0QgYml0cyBhcmUgZGlzYWJs
ZWQuDQo+ICAgKi8NCj4gLSNkZWZpbmUgRVBUX1NQVEVfSE9TVF9XUklUQUJMRQkJQklUX1VMTCg1
NykNCj4gLSNkZWZpbmUgRVBUX1NQVEVfTU1VX1dSSVRBQkxFCQlCSVRfVUxMKDU4KQ0KPiArI2Rl
ZmluZSBFUFRfU1BURV9IT1NUX1dSSVRBQkxFCQlCSVRfVUxMKDUzKQ0KPiArI2RlZmluZSBFUFRf
U1BURV9NTVVfV1JJVEFCTEUJCUJJVF9VTEwoNTUpDQoNCkl0J3MgYSBiaXQgZGFuZ2Vyb3VzIHRv
IHB1dCBIT1NUX1dSSVRBQkxFIGJpdCBiZXR3ZWVuIHRoZSBSLVggYml0cywgYnV0IHdlDQpkb24n
dCBrZWVwIHRoZSBXIGJpdCBvZiB0aGUgdG8tYmUtdHJhY2tlZCBTUFRFIGFuZCB3ZSBhcmUgZ29p
bmcgdG8gZG8gYQ0Kc2ltcGxlIHNoaWZ0IHRvIHByZXNlcnZlIHRoZSBSLCBYIGFuZCBYVSBiaXRz
IGFueXdheSwgc28gc2hvdWxkIGJlIGZpbmUuDQoNCkFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+DQoNCg==
