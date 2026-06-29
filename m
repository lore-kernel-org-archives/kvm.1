Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35508360ED4;
	Mon, 29 Jun 2026 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767244; cv=fail; b=VdETlij6voAEgb99iR9TvtbRajZxC/y57ryIVYXnOKD8cqkPCxKXu8m+5m0DP2ca0Oy3jGpG6ipPv/WfEsqoY5AaV0i7jRnEHs8pJmmqt6oXNiF2KzsLZILZd9qSyJvphHGb2mVgu8UofDQ02SwU2pIBKlv30s2xc6IUtyNnao4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767244; c=relaxed/simple;
	bh=t53nvq3fq5vrulQbFnradLjsbmmBXnTbH5iUPeols+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BSb9XVnwzbu5lroZil6JkhnzvCmd4n/WonWGwhOv6If6qM+Pz9RK1X2edXkfgDcf2DiHnHio2DVMbBg7fjMj6BjIEzIEDbRB/vdzTqHGSDaCjWtC4rGa19q+c73QdScCIiyBNL9wdLSBlftcpwhDR4haNzRXrsfXLu4lGrvKiqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzAn7TOJ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzAn7TOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782767244; x=1814303244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t53nvq3fq5vrulQbFnradLjsbmmBXnTbH5iUPeols+c=;
  b=MzAn7TOJSnf2D67ldDqV9fFCR0+h1Ax49Rq2eQMiVmkqFmi0xNLom0Xk
   vCO73ufeKFKF5MG6KdPLIFRJbSL8EFxY18aU/fIxubJkWqxSrctbA5Pme
   7hiR5UKNYwTOfaKpN1PeJump8N93IoYgBHGumv/XpsbkoLgbcA89P5+F0
   8NwFd+444HHf8rPVz8mEFQTz3/9grEW5YPgkTl8NIHYATI1ntiG5pmNiW
   5ttEBZ8/k3EisDnMQFwzj1EGqzNB3G7AoxbfN+7ubH0SO72u64oRZV0zT
   PF+uX1wLY3Z9L/zcd6ydOBCdvZezG3uf5ruvXlztkMCcbe9SC/cnvbtem
   A==;
X-CSE-ConnectionGUID: YF7h75x9QYiyhz2JpHasXA==
X-CSE-MsgGUID: 9bnngb3fRhW8aHrCcnqaKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="93828305"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="93828305"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 14:07:23 -0700
X-CSE-ConnectionGUID: LMAMSujpSviQfS5VsCK0pA==
X-CSE-MsgGUID: fPDJCatUTaOTms/zFEOtSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290191452"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 14:07:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 14:07:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 14:07:22 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 14:07:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZcocsJayK9IRi7JW3kTncxoko9Lq6g3nGZZ/yMak8kAYwP6rwj3WJLkIkHZINnMlH1r28pLqVaOBHwuf9C9lgSQMg453eaGfH4UImvTixwEUnQYyrcOGxfwpmq6OrNBsKkCSBRQF4l1RvLImnHGdQc+n4VzCAHA/8D90VIyEms/QhZXLrJBaYBFJY4V/l1q2zQiIx+6PrQsU6v1HfpnLRNLNxkUrzCP4ARI5mjrwqsJva6apRb8dPOTzQOvL5NG+h/xOqKo7+wE5qSdDAoFTwVwJrZ02W/diM7zxy2JXK2HzyO3kt3IER9LsEQNFfF17NbHcNRYU00s0M6u2DzS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t53nvq3fq5vrulQbFnradLjsbmmBXnTbH5iUPeols+c=;
 b=KZO13H6V34fQGhBCWBmjCoYY4/UB4yHod2HKEwXTVfhAZQeV8BkeNl8liUQ+HmuSRXFn+m6cThdsOom/yomDMgHM0iDwRMvuDoX/7KtVFuwL/s6oQHDlCDB9h0A2mQgQU1iMoUt9pxDU0ZPm/Lief8AQCQUtUEY2o97ZIPRHE8BSjjtyxUmiYefBLLiO7UOLdiapARMyBzpn8IiTrZCjJNP8q5cpflXiRahWswxNT7KHGsd4Oev/yypyXvdPdMUh9vDkr3zgGFtEjRkQ1FpQbLIt4emOy3QWVNRrvG+qE+hZn5+JfKpDR0BUSNGcnWNuHijzaFMETdjzEfxQnf2JAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 21:07:13 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 21:07:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>, "sagis@google.com"
	<sagis@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "Annapurve, Vishal" <vannapurve@google.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [RFC PATCH v5 30/45] x86/virt/tdx: Add API to demote a 2MB
 mapping to 512 4KB mappings
Thread-Topic: [RFC PATCH v5 30/45] x86/virt/tdx: Add API to demote a 2MB
 mapping to 512 4KB mappings
Thread-Index: AQHckLzz8Z2GKPhpy0S7O2pbUAy4grY525sAgB0ZbQA=
Date: Mon, 29 Jun 2026 21:07:13 +0000
Message-ID: <9c22a8bc7f326f81effdff27fd72c3c5339e5053.camel@intel.com>
References: <20260129011517.3545883-1-seanjc@google.com>
	 <20260129011517.3545883-31-seanjc@google.com>
	 <aip1eO7wvJDxKtBX@yzhao56-desk.sh.intel.com>
In-Reply-To: <aip1eO7wvJDxKtBX@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB6400:EE_
x-ms-office365-filtering-correlation-id: 83c08ca0-b0ba-43ac-f335-08ded622649c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|38070700021|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: JaoDAPD5Qx0sW2IF+3rFdfHLs4Lo6Edei9hXMrsN0S5Ds7V2rUjF2pcTwx15tWAZWZ+8xluzsPZgAUDnGPwmgyjIYBIeVFzObCSB+W1rFMqy8X98Q59bQby3fdhiqO/iL3ubiN5CiQVY2exb6cm4lZjykCFS7IgBlYE+jFdonWbajEtiJEG+a/w4OeYDtgWVxWZxvzLmjDjvdtQRX3t8fBy7bCGcYRqlmiG1zjWLlA4bvjiUSXG5XR3uiIV7A4yPSh9ecWJMpG8g0+HzdFKIuhkcpSgokHVAM/+rFJiZJo6atAYcTrBKG5cJc4Pl8q/3nUA73C5exrYX1C0u+bryViJM4rwzk/Nag3q0ysIeiPjxirxWW19Z4eQsCH1dauimuwV4ZMyV7WbAmM6iP8hCTN78AylxjdMnxlAkWoMO+YRS/Z4j2CM2KPKJZK+FLqj+SJcpJNhhmMxHPAN00ASWimZn2DkrukrEkQAzo5YRf8ihmySyYievWAR4dLtcq0x4TpUjQKW4r5N9IJdwbnU4l66e6zcTdgJIhzXNXCCxnjM5M9u8tRlGiow1qErimwyFW5pb/bdNUWFLwQEOOXWCdwHp8dbcnU1lqm2K3GG8rU+4pNdWKilawzNnLTbNtQj4fO3K5IUq0nkS1dXgK4rq/6PakerMGBvmH9ehiDez6CM8jJ3vMlqzE6V4tzPutgJN9as+wvTqnn/sOQhqle7b1b/iJkDuVrhmfMzoEuHr1T0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(38070700021)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkNNK0lFSWRockhMTVpuS1BTb2c5OUpIZi9qYmNNVEtLUms5UmxzVitBR2M2?=
 =?utf-8?B?bldZZVlpYUpLSjlXNzdXSGJUUFJkbUs2d2g2UkZHMEVGbCtERzZmOHlmNEZr?=
 =?utf-8?B?Y2xhKzBqOFlLczU2bDBwblBOemd3RmtrT0FTMkVQa2oxeDBsMWpuekJlYVlC?=
 =?utf-8?B?QXZFbkRQZGJSeVJKcEphbEtwSFN2cEdQRmdBZDJ2c3dVZjVxQ3dzaEFrMlJu?=
 =?utf-8?B?aDJPTzNvREpLZ09QYU40ZWRhY1RQelNuYmpCYzQ5WGtvTHJOaEk3aUY0YW0y?=
 =?utf-8?B?MkQwSjhZNTZRRHU5L3JObUVFbUVhUGJjVmRJNHhSdnJtQWlZaW9kNnJMWVZH?=
 =?utf-8?B?OEhwak5ma2J2Wmg0VXZZMGQrQUMrd3M2RVl1cDlrZkd1ZExKdVdWRGJ6Vi9H?=
 =?utf-8?B?dlRvT2M3d0RkMzEwK0NIMlFjWHdvL2thdG1SNkF0MmkwRE5PTHhSZTlFenF6?=
 =?utf-8?B?YUZ2enFlNC9EU0R4YTdKYjB1WkhhY2FEejZ6YUowWE9XazJTZmNPR1J4OFgy?=
 =?utf-8?B?Zm5BQWEvTWdFOXB0VlhKcmFaWG85M080UlZ2dnU3a3RHUHBpVFAxUUZxQ0NR?=
 =?utf-8?B?UkM0d2dCWThCL1NIdGJqYzBnKzQwZFdWS3I4LytnVWtZTi95Tk5xWVg3cGFl?=
 =?utf-8?B?MEdrQlk2NHl4MFFENzBlUVMyVGxLeXZVcmZCZ29VTFpub0ZFMHZIaWNGVVVW?=
 =?utf-8?B?a2hqK0R2U254eVJuRHV6VmpvTFFnTHlVY1BLTVBMcFdiZmhWd21GQ3FYc2Q1?=
 =?utf-8?B?bDZaMnNXa0lXTTR3YUNrY2NSRFdiZkZMYkdSS0xOUTJ2THdPVjhVVm5WWFN1?=
 =?utf-8?B?WW1hKzM2aWZUaWtUSnBlbzlCelJ6VDZhL1NKZHNBMFgzNU1VNDR5NWZ0eHl3?=
 =?utf-8?B?Um82cDYzQ2xyQmF2SmJrYWdmR0NncnFSRXR3RjN6SVgyTXlkMEVyQmNDdHc2?=
 =?utf-8?B?YnNOOERPbENQYWlIa2ZLTmI0bU9xUkt5aWFnVkxUeUtNa0daR01MVzRHQVR0?=
 =?utf-8?B?eEEwZHF4WGdmQkFRcUFvdGhodC9KNVFrVmxYUWpOUUkwcjlaUTE4WWFWbVdI?=
 =?utf-8?B?YWhLWm1aeEFBUnJLWm01anAvRXh1WjRWMmJFM1lERUYxblF0Mzg1cTFyRnBq?=
 =?utf-8?B?WkNFbzFKazVLOE9ESjc2Rk5SVDJxLzUwWVpYN0FqS1FpdVEwN2xyOGhzTmdT?=
 =?utf-8?B?OVZoUTJicjJoZWFsbjBGMmVXTDUxaGFjWHlKYmZxY2hLMUJlN3J3ZnNsb2FT?=
 =?utf-8?B?NDlBb0tFdEJMVEpRMmFJVmI5ZHBlK1ZrN0ZISHZWbldydmJvSkl6MGlESkhJ?=
 =?utf-8?B?TFJzUitJMUFQK3A4MEtMM1pyUHg1a3pwUjNPeUFkbXBOTWJlb1pUcFlldUdV?=
 =?utf-8?B?MVVOWDhZQ1E2bC9XWHo0aWJBTzZORWhGVW8vdnRuOUw0OXVLcVhOS3l1ZVJQ?=
 =?utf-8?B?L3JKNkx2ellPdEpYbGZrdDMrRWs1Q21oTzZpRlZ0UytiRDFncDRpZmc3bW1L?=
 =?utf-8?B?aHpKa3h4SWVwblJXa0RvRlRia3hEdjdBU3dzenhndTllNmUxZGdGZXlhejVk?=
 =?utf-8?B?MzR2Vmhxc3JJTGRjS25LbGVLc2gyUk5yZDRhUFFpZVFFdGkvTWpHRmxoSXZ1?=
 =?utf-8?B?ZCtjaTNWZXRRdGJxY016RkRwWDNwVC9ucll6MFRrWDFGRTdqT3dDRUpmWStn?=
 =?utf-8?B?S2xtR2U2NVk1a3pCc1J5endPYTc2Q3VoclFrRTFUNTlMUWJUTG05WkdyaFZ4?=
 =?utf-8?B?cTNTMWViMkExTGUxV3FWbWoyaW5Mc09VTGdFRkpPZ0dpWlllMEo4VFlibnlN?=
 =?utf-8?B?RklJT1B6MkJ5eitCSUJHdHk3V3dCak95WjN3VC9zeWo0OFhqL3d4cERveTVl?=
 =?utf-8?B?S0oyOUN3S25lNUdxOVQ3VDFIYVUvOS9PVmM3Wkl1RE5OR2FzVjJFVmMyZ21z?=
 =?utf-8?B?RVFadGpFWGI3bDBGMUZ0KzFiRHFoSmYveTl4b2pMajRQR1dHeVROVkdnNEQ2?=
 =?utf-8?B?d1BYMUk4V1BQcnhIZEN6SmVSVEQ2dWIyT3NLdUJmaTRmaFJxV1pSbmVjQlZT?=
 =?utf-8?B?WjdWMk1qa0VaUm9DQU5Cd280UTJscnBlOGE4dUFSMkR0UnRKeGxEVi9YRHNI?=
 =?utf-8?B?Y1UveFM5UlZ1L2lSYzR6K01xWUx6ekNqUDI3RFU2dHdyV21SKzRhSU9RSEpH?=
 =?utf-8?B?TXU4UFhJc3NvRE02MVkyM2V6ZXBwaHloRy9EWjdZZ2lBbFRqVjVXa1BRVVd2?=
 =?utf-8?B?SEFiSURPbERvV2x4amJoeU9wUG94TWVDdEhieHkwMUtwczg4Mno4WTFuMklz?=
 =?utf-8?B?T1huMUhxSUo1OHA2KzQ2SDJXbm4yZzdCOGhzV2JRaTc5R0FzMW51eFZXbERT?=
 =?utf-8?Q?CpUyrFIfCMRZf+HU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E89C9B4E3196A94FAA998E8FEB854226@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cgfH+NLCaMoLBeVMrU60K/ApJV8qeyFfqX1T1Q5oZ1tDWhL7eL9LFPZWtaAplpvYPYElzhjnaSIVSL+mL6lnw4WrgYg86/C6zuCiNBIARAq0VtSF5Zcpv9vewJmO2YAor7f9+lF4Agfre6LXrTw5l8StWeK3Z6epr6KY5StN0D2A0GIG3eyuu/rjD+BCXaXl/MWijspI5XNuOILWfc+vim6FmHwJDumOPi94osr6mkbc/tldU69aG1HjNap60Odl5qyGQbKXVBpXy6pwtGFeK/hW1dXXygEcVsLbkCMYPy0y/zjkABV2OTL0RIgQ80+7RIWz1Qtz2kGrel0qyWa8pw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c08ca0-b0ba-43ac-f335-08ded622649c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 21:07:13.8105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86Nq5EN8v+gKZ9Enxv5zTPh80JHvhoO7dnsr1w2VBF+0PJV5PG6tr8HH9nceWPugvLqJYG9iNGYodkSJy09OENHLmpwrrrdmoAtFirphxEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTExIGF0IDE2OjQ0ICswODAwLCBZYW4gWmhhbyB3cm90ZToKCk5pY2Ug
ZmluZC4KCj4gU2luY2UgdGhpcyBjb250ZW50aW9uIHNob3VsZCBvY2N1ciByYXJlbHkgKGUuZy4s
IHdoZW4gdGhlcmUncyBhIHNlY29uZCBURAo+IGludm9raW5nIFBBTVQuQUREIGNvbmN1cnJlbnRs
eSB3aGlsZSB0aGUgZmlyc3QgVEQgaXMgaW52b2tpbmcgREVNT1RFLCBhbmQgdGhlCj4gRFBBTVQg
cGFnZSBwYWlyIHRvIGFkZCBmb3IgREVNT1RFIG11c3QgcmVzaWRlIGluIHRoZSAyTUIgdGFyZ2V0
IHJhbmdlIGFzCj4gUEFNVC5BREQpLMKgIGEgcG9zc2libGUgb3B0aW1pemF0aW9uIGlzIHRvIGF2
b2lkIGhvbGRpbmcgdGhlIGdsb2JhbCBwYW10X2xvY2sgaW4KPiB0aGUgZmlyc3QgaW52b2NhdGlv
biBvZiB0ZGhfbWVtX3BhZ2VfZGVtb3RlKCkgKGUuZy4sIGJ5IGluZGljYXRpbmcgdHJ5IG9yIGZh
c3QKPiBtb2RlKTsgb25seSBhY3F1aXJlIHRoZSBnbG9iYWwgcGFtdF9sb2NrIGlmIHRoZSBmaXJz
dCB0cnkgcmV0dXJucyBidXN5LCBlbnN1cmluZwo+IHRoZSBzZWNvbmQgaW52b2NhdGlvbiBtdXN0
IHN1Y2NlZWQuCgpZZXMsIGxldCdzIG5vdCBkbyBpdCBmb3IgdGhlIGluaXRpYWwgaW1wbGVtZW50
YXRpb24uIAoKPiAKPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtL2FOWDZWNk9TSXds
eTFodTRAeXpoYW81Ni1kZXNrLnNoLmludGVsLmNvbQo+IFsyXSBUaGUgY29udGVudGlvbiBpcyB2
ZXJpZmllZCB3aXRoIGFuIGludGVybmFsIFBPQy4KPiDCoMKgwqAgRXJyb3IgbG9nczoKPiDCoMKg
wqAgYS4xKSBERU1PVEUgYWRkcyBQQU1UIHBhZ2VzIHBmbjE9MHgxOWMwYTAsIHBmbjI9MHgxYjU3
MmYgZm9yIGd1ZXN0IHBmbj0weDUxOTgwMAo+IMKgwqDCoMKgwqAgMikgX190ZHhfcGFtdF9nZXQo
KSBhZGRzIFBBTVQgcGFnZXMgZm9yIHBmbj0weDE5YzBhMS4KPiDCoMKgwqDCoMKgIDMpIERFTU9U
RSByZXR1cm5zIGVycm9yIDB4ODAwMDAyMDAwMDAwMDAwYy4KPiDCoMKgwqAgYi4xKSBERU1PVEUg
YWRkcyBQQU1UIHBhZ2VzIHBmbjE9MHgxYjA5MGMsIHBmbjI9MHgxMTliNGYgZm9yIGd1ZXN0IHBm
bj0weDUxMWEwMAo+IMKgwqDCoMKgwqAgMikgX190ZHhfcGFtdF9nZXQoKSBhZGRzIFBBTVQgcGFn
ZXMgZm9yIHBmbj0weDFiMDkwZAo+IMKgwqDCoMKgwqAgMykgUEFNVC5BREQgcmV0dXJucyBlcnJv
ciAweDgwMDAwMjAwMDAwMDAwMDEuCj4gCj4gWzNdIE5ldyBpbXBsZW1lbnRhdGlvbjoKPiB1NjQg
dGRoX21lbV9wYWdlX2RlbW90ZShzdHJ1Y3QgdGR4X3RkICp0ZCwgdTY0IGdwYSwgZW51bSBwZ19s
ZXZlbCBsZXZlbCwgdTY0IHBmbiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBwYWdlICpuZXdfc3AsIHN0cnVjdCB0ZHhfcGFtdF9jYWNoZSAq
cGFtdF9jYWNoZSzCoCAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHU2NCAqZXh0X2VycjEsIHU2NCAqZXh0X2VycjIpwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IHvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoMKgwqDCoMKgwqDCoCBib29sIGRwYW10ID0g
dGR4X3N1cHBvcnRzX2R5bmFtaWNfcGFtdCgmdGR4X3N5c2luZm8pICYmIGxldmVsID09IFBHX0xF
VkVMXzJNOwo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBwYWdlICpwYW10X3BhZ2VzW1REWF9EUEFN
VF9FTlRSWV9QQUdFX0NOVF07wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgCj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHRkeF9tb2R1bGVfYXJncyBhcmdzID0ge8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC5yY3ggPSBncGEgfCBwZ19sZXZlbF90b190ZHhfc2VwdF9sZXZlbChsZXZlbCkswqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLnJkeCA9IHRkeF90ZHJfcGEodGQpLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnI4ID0gcGFnZV90b19waHlzKG5ld19zcCks
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgCj4gwqDCoMKgwqDCoMKgwqAgfTvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAKPiDCoMKgwqDCoMKgwqDCoCBhdG9taWNfdCAqcGFtdF9yZWZjb3VudDvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqDCoMKgwqDCoMKgwqAgdTY0IHJl
dDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKgIGlmICghdGR4X3N1cHBvcnRzX2RlbW90ZV9ub2lu
dGVycnVwdCgmdGR4X3N5c2luZm8pKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFREWF9TV19F
UlJPUjvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqDCoMKgwqDCoMKgwqAgLyogRmx1c2gg
dGhlIG5ldyBTLUVQVCBwYWdlIHRvIGJlIGFkZGVkICovwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKgIHRk
eF9jbGZsdXNoX3BhZ2UobmV3X3NwKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4g
wqDCoMKgwqDCoMKgwqAgaWYgKGRwYW10KSB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IAoKQ2FuIHdlIGp1c3Qgbm90IGRvIGh1Z2Ug
cGFnZXMgaWYgd2UgZG9uJ3QgaGF2ZSBEUEFNVD8gQWN0dWFsbHksIHdlcmVuJ3Qgd2UKYWxyZWFk
eSBnb2luZyB0byBkbyBpdCBsaWtlIHRoYXQ/Cgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoYWxsb2NfcGFtdF9hcnJheShwYW10X3BhZ2VzLCBwYW10X2NhY2hl
KSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBURFhfU1dfRVJST1I7wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFyZ3MucjEyID0gcGFnZV90
b19waHlzKHBhbXRfcGFnZXNbMF0pO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmdzLnIx
MyA9IHBhZ2VfdG9fcGh5cyhwYW10X3BhZ2VzWzFdKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBCZWZvcmUgZGVt
b3Rpb24sIHRoZSAyTUIgZ3Vlc3QgbWVtb3J5IHJhbmdlIGlzIG5vdCBtYW5hZ2VkwqDCoMKgIAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYnkgRFBBTVQsIHNvIGl0cyBwYW10
X3JlZmNvdW50IHNob3VsZCBiZSAwLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFNldCBpdCB0byA1MTIgYWZ0
ZXIgZGVtb3Rpb24gc3VjY2VlZHMsIHNpbmNlIHJlbW92aW5nIG9mIGVhY2ggCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiA0S0IgbWFwcGluZyB3aWxsIHJlZHVjZSB0aGUgcmVm
Y291bnQgYnkgMS7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqL8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwYW10X3JlZmNvdW50ID0gdGR4X2ZpbmRfcGFtdF9yZWZjb3VudChw
Zm4pO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCgpJdCBmZWVscyBr
aW5kIG9mIGhhY2t5LiBUaGUgcmVmY291bnQgc3R1ZmYgaXMgYWxyZWFkeSBhIGJpdCBoYXJkIHRv
IGZvbGxvdy4KCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZwYW10X2xvY2sp
O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoMKgwqDCoMKgwqDCoCB9IAo+IAlyZXQg
PSBzZWFtY2FsbF9zYXZlZF9yZXQoVERIX01FTV9QQUdFX0RFTU9URSwgJmFyZ3MpOwo+IAo+IMKg
wqDCoMKgwqDCoMKgIGlmIChkcGFtdCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoIXJldCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFdBUk5fT05fT05DRShhdG9taWNfY21weGNoZ19yZWxlYXNlKHBhbXRfcmVmY291bnQsIDAs
IFBUUlNfUEVSX1BNRCkpOwo+IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGlu
X3VubG9jaygmcGFtdF9sb2NrKTsKPiAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKHJldCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGZyZWVfcGFtdF9hcnJheShwYW10X3BhZ2VzKTsKPiDCoMKgwqDCoMKgwqDCoCB9Cj4gCj4gwqDC
oMKgwqDCoMKgwqAgKmV4dF9lcnIxID0gYXJncy5yY3g7Cj4gwqDCoMKgwqDCoMKgwqAgKmV4dF9l
cnIyID0gYXJncy5yZHg7Cj4gCj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiB9Cgo=
