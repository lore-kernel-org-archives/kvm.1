Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA87378811;
	Wed, 19 Aug 2026 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178975; cv=fail; b=WJsK7oauYG4No0UYH+NqXBTHObZmVFrgNtP8TZsluoN42rTf5bHjY1ZASyf6Lho4ZDRx+q7k8bfDtYp1QZvoNG6S8xE9y+mPui3Hk7E3WVWHW9mqz36inykY+kbLDTdZtezfzHNuEL1h2kYGBtONJBGgtOo0uC/pcGmkfCg8+Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178975; c=relaxed/simple;
	bh=BIa6AmIOJ5ztWnD/eharg5A03EnSks9211jA0zSPNko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SWTJg8fEDN/jQoRGLRmaV0PsIJkr1F5s9fAm0f/2+mbxdQrNpvJE2sW1pwgHUhI2yj02upFEECL/OiIhrIyWaLh8uuFayIX7ntGDgjKTkm8jAZ0x61WbW2TQcWS0e+W+Bl1DIWNgaO021Cdo7JC1/b+ap26ixFAyzhUNlvrVjGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMUem+iq; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMUem+iq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787178974; x=1818714974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BIa6AmIOJ5ztWnD/eharg5A03EnSks9211jA0zSPNko=;
  b=FMUem+iqDq5oJI7UhiLsbf8DjYeNVrEVSUeITNV2gx6gbnZ6gM5wiwtM
   /OhICkEJkwDg03W/13fdeXlPC3IC8C6OOKhD0hp4KBKtlWvTjJFLcSkXc
   qoPVVJnCP9dimPfNUPBzVeB8Lkd++FaDEydtqjD9UgAUp+7Pjcy6+3ew5
   Ql3F8a/ZOXACT5mk8lsbDCfBMXnkH94yo5hz1poSJcIUCpc1V93TROBUd
   mx8sudR+jK82mM4TRxd2YZabtqKiGISMWZK+cmsFX/H4FrysIOxNTrryc
   3wF3+aflDkO+YeFfJ08zbbQYxb7YwpJniGRSA5Cgs0siiJ/Z3Pr6io2Iw
   A==;
X-CSE-ConnectionGUID: R91NZy5hRjGpwtFVf4kfkw==
X-CSE-MsgGUID: BKvFxuW7TtW4MDlX+XWtFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87826930"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="87826930"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 15:36:13 -0700
X-CSE-ConnectionGUID: ft/lYJCbQ26P18rGqR7WSQ==
X-CSE-MsgGUID: F0iEW7jGSpiAS3gAnvvepw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="265706846"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 15:36:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 15:36:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 15:36:12 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 15:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLYluJzdKDFWxezxwGWsRigcpec9LQNNSa0yI3e2r0IPpwlzsW9SDi4PfySPEH2CwZmvTKpIvDAwpbrSxTkX50dkUa+Klln/F6UyuIwq6UJcKTKq82IFezgA53FSWvyf2oYOOAQhWMuEV5yOFpHd5jCC+Wf29XTAEVeO8BytR2ZeaCl3+ehZcyy8946i+RzG8/6gnrahe9WeJ9uHfoamqA1a/pTYITdi8aFLROgNSkhLfMX/3rvkoJ72OZtIL+QsaLzuLm+LocmebfOptKZOXBe6S0LKlMzwg/2A1EgE95ono41MNGiWEBHZReQBmpQakbdK2s1uZVPMVVnthsX6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIa6AmIOJ5ztWnD/eharg5A03EnSks9211jA0zSPNko=;
 b=y8s/TdO0fXOya/Eu9ohbNS48nndemMd+55Y2nsyzpgBDjX4TKg2wImWYf31d5xrYuiMYTeB3Oo36ZrCAoObmGsyLv9Xtkki927oKH44T+tM9Np9Ge1Hlxh5waNPjwoiLvL+rNHHH/Ip0lofBPkD6D3UydcYBGbXoH8u0fVROrqd7R9XTiWwUUt/E3ePXl7/iG31SDXlgdawjnlsIvyyCNoPe+V5SAl/AQ9YAA128Dg3w2xJaj0fNF+/PbesJgTZo3gqAWkajTJa5FynItBzJ+zGpUeh25orZWLJywB8lDvpmPECDCHo4RLwt5vn4ZsGOvt4IUD38X5mXuMiVp7o8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 22:36:08 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 19 Aug 2026
 22:36:07 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead of
 guessing it from CPUID
Thread-Topic: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead
 of guessing it from CPUID
Thread-Index: AQHdLD6aIiIDquy/9EahH8lhDbokubakkrIAgAAAwICAAOUSgIAAFZAAgAAcmYCAABKJgIAABDQAgAALhICAADHPgA==
Date: Wed, 19 Aug 2026 22:36:07 +0000
Message-ID: <78c2efd6749a3f07f0c381c53166b7b2b192019f.camel@intel.com>
References: <20260814224509.2342760-1-seanjc@google.com>
	 <3a622cdb03b553cc9f8ce55b6df3c0091b3b06b9.camel@intel.com>
	 <aoT_6cnARCAYTrYG@google.com>
	 <bd8f77eb6605f771fafbcef55a47211ecbb70e19.camel@intel.com>
	 <aoXSKH4QLTA5DTXe@google.com>
	 <4f8428e0784224c55a2026eb32d046a2051193ea.camel@intel.com>
	 <aoX5sbITQYeB7USY@google.com>
	 <e5979a0a4d7c24d88f57981aba0fda6d8a5e2f29.camel@intel.com>
	 <aoYG4XA6pXAXiHlP@google.com>
In-Reply-To: <aoYG4XA6pXAXiHlP@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB7498:EE_
x-ms-office365-filtering-correlation-id: 39c19e42-40b8-425a-259f-08defe42430b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: /bO5p90PQbNBmmLkcRWOV/CR7p2myUk72YNpzDryACt2bO/Nma9prp/8DpVib8H7yReu1ialddoaBp2C8bObVbZ3LoN7pJt9lQ5f1SQ9f37lN1x5tGDgEwQkKvRnKfvowfprbNlDdeg1JPqVyalfQx2tKgh2SJCdqe8c4utGXrDEpNFhq00mIJIhxF4WW6rTy5wjOBn30HTqLnkqbhgGBjFdNmQo0Zf+aXqf1l9VF6N9dTcN58kN+IkPF+QNTkFC8PjA5PuX7lK4ZXL16xJ2JV5X6U9qJ7W8ShX9xcE5ANXrtp8i2nn/+KZ/EFRQCzB4iHoJHSog4hlVl5nmRJS4bHoVEg4l4wm+VgAT9rodZL9+EtzbmwC6AiAz2eMChOMLksZArDlYexX4N3jcRySGfNZi1Ju0BCBs3AZImzDIU/j0dxXIxyXnvGWndrUP/caY6JNZeFllV0X5EYZ56Fve1J9vykHbrXs/xbfRQbdxJzofDE5Gh8dDrhN0ZKwWKK3dsOer8ZYL8N7vgSmbsGrbihO9JANUsnCvgvg2l0T22TKh8MZVFU6nHCur5d6aJJHH+re7IP0uG2OAfv9d/ofcNG3bPtzfgZtlthrsEcZRq/hq/71LMT61aNMuzbVzxPkRsyCbxEWzWF2pz0+cLlQOv+Yft2q5H7SGLYvTfD05NaGo2x2qSLvvOWDxWE+WjSjUBosLAPxH7DEaoqk4TQeTVfM0HgBVuQ9XD6cvU3yNzGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3dpV0dSckJRK3B5cmJieUJDUVJKRm1SbnNrS1RxeHRySmV2MmpzWFpiVkZ4?=
 =?utf-8?B?ZVpRL1lzV2QxMjRKZ3kvQ1RDV09SbktxMnJYdy9oTzZNWDVZenBNaEZvRTJK?=
 =?utf-8?B?Z1IrTDgyWWxPWDB3Wi9uS2VtOWMweE5JdjN3dXRDb284dFN3VDNrb3Zid1Z0?=
 =?utf-8?B?T3J3eE9GejJ0amhEYnFhSXJIZ2d6UU14TEZlcHJNM3NwUkFpNWR1YVNFcEdN?=
 =?utf-8?B?cTJqd3Y4eWNzRDF2NUN4UHlYMjk2RE44SVc1T3EvMkkxVi8veVZCVjJvL1pB?=
 =?utf-8?B?MlE2NXViYlZxM3FoZE15WTFlbnhBVGwwblJCU25LWFg1NTZhQUs1RkEyNS9G?=
 =?utf-8?B?SmVjMHBIejVJcHE5Q0lsRjRQTldDS0xzUDEwZU5mRzNyaDhTSTJtbUFzTWor?=
 =?utf-8?B?WFBVaHlMNWJ3REs1QUtiRUdZTDBkS0tNQTAxaGZtbFA0dGkwdGdxSFc3eCtL?=
 =?utf-8?B?MFQyU0V6NTFSbFZIeTR6Ty9acTVNNjVhV1BpWDZsQnY0WGZ3K1pOV2d0WHBl?=
 =?utf-8?B?MzFLejgvL0xCNDNYRDFxZFhkRzZ5SkRjQXU1TWFJVkU5aHVNZ3B3NXZwRDJJ?=
 =?utf-8?B?V3V5dzBNeHNTMFkxUU9kTE5zYUYvV05EMyttMTNLSkR4TnRaYWk4MGVoYU9V?=
 =?utf-8?B?OElrUHN1SDZpZU9CZ2NGTEJhYVJhOHoxc0RnOE8wMmZKUURISVZFMXZ0TnZv?=
 =?utf-8?B?YjR6eGVqdXMrRTdZcVN0RWlCcFEyWWtQdjRZQ0xrb0tMd2tmeGdDWkN2ZWVv?=
 =?utf-8?B?QjBwOWVSQ1ZVcUdsVUVXNmRPTUFlOUVBb0VmMDZ0OFlHaDVDU2NCVHV2Q2E0?=
 =?utf-8?B?ekJKUnJQb1JacWZFWk90ZGF0ZFBhcWJBUVpFNE9ISmxuK3hQRy9yYklJUGVv?=
 =?utf-8?B?TEp2bjZwMXNvK2NWbDNNYlcyZ252LytJejViSDdOWGR4SVJveE9OMG43aFJM?=
 =?utf-8?B?UEVRS2toVXY4dzMxNGJocnJqcVdmQ05Wa3o3aklISDZudTFCblJnQWpHaWFN?=
 =?utf-8?B?UGVXbnN1bnQ4L1hQc3ZOTVBDU2c4NXpvYnlVL3ZlTXc2dXFlOUpnRUEvZHJx?=
 =?utf-8?B?b0xiRStNVi9aNlFUWTVmcmdUM29XS3VETWJBbHdUM2Q5c3BLVFYrUkloZGRk?=
 =?utf-8?B?TmcvNFVJdC82OG9RUGI1NThFZjM0TkgrUWcxREM5OExpd0IrZXdlV0orYklR?=
 =?utf-8?B?OUF4bTBBcGlWaTFuMnNWRURhUHFHdHcwYUN3RThCRlR3K25lZmcrcnRPMkRh?=
 =?utf-8?B?UWFVQ01YdGxWeHpSZUJpTVpUYlJkSVBVU1dGazFJRUI1NFpoanVpZkNEcFNy?=
 =?utf-8?B?V21wMWFwRnJ3aFVFUkJWZ2RYSXBpbE8vRkx4Wmh4enVzditUWDExR1JTTWFt?=
 =?utf-8?B?ZG9TcjE2d1NYMDVydVBBV3pTb3Q2M3grRUJBc2pDbnhLWGF0c3VxNzg1aDJp?=
 =?utf-8?B?YzV6SWxEMkZwWDNsZHpOVjUyMGppS0ZIeHpEUStuN2lkdnNSOGxWY1ZTM3pp?=
 =?utf-8?B?a2tKZ2NaNjJiVTJRTHRmekFaR3BuWTV2a3VxTmVqR3hsYmw5U3dwM3RLNkhR?=
 =?utf-8?B?Mm5uUHE3YXloQXJkMzRwalUvSlVZbks0T1Nxb29sdk5qNjZQVEdSQmhYVjl6?=
 =?utf-8?B?U0tCalRkWTl1M2pCTytmVU1qOXRna2hYUDRVSTlQWnZKNG5UbzRKb0RCU005?=
 =?utf-8?B?MWVuT2UwSmEvN09VblN2dGFpamlDNlB6U0M2VWRBbHpWTzdJRUZJVDNGOGdD?=
 =?utf-8?B?dmdjTlM0RTViZ052eDlydXhsUWV3NGw2U21ob0FRS3ZnbmdaTnBHS2ZRYzUx?=
 =?utf-8?B?U1c0ZDNURW9LSjlSVGhrVE9iWVluN3p2S1hZN2ZwUmJMNVdMZkg1UXZJSWw5?=
 =?utf-8?B?SDRUd0txQ3FpYWVOZkVnMVlyTXA1UVM2SXlZU2FpNkV1YzRGVjMvbGJ4UmUx?=
 =?utf-8?B?Qzd0Uk5DY1hjQjI4Y1FxempMZ2FLMkZTTUJXOG96Y0hsait3Q0hiVjRKWERE?=
 =?utf-8?B?alMvZUJRb0xETS9PODZYeXJ6WWpVWnZvRjF1dXQzRTdnYXpkcWtjTXNEWVpa?=
 =?utf-8?B?RXRvK2dVKzJLZkIwNVZFLy9FY2JIbkxORktGZ0NrL1g4WDJkWndQay92aGFU?=
 =?utf-8?B?QW1xMi9NM3JibklVT3FmRWowRm53eHlmTVhwUWpxaDVWd2dUYUQ4ZUdNY2c5?=
 =?utf-8?B?RGt2RDhyWVNKM0w1c09ra2xYbU8wSTdISllJTzIzNStYMkkwQ0VveC9SNjM1?=
 =?utf-8?B?TmRKSkV2VUZpSlVlMlF5ZDJHY0xkcldjVXdCK1pnOFdTWENYRlpzRVpOQVRu?=
 =?utf-8?B?aWtWM09GeTFNTE9nREUwN2xsTm9MNkhROHlTbDZGeGtCOEpwMFFETmN1Ly8y?=
 =?utf-8?Q?KnaigQON0s+snm9Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B85F7CCA1C6F8C4E8D09BA66AC2F273B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AKxZIRcFqTMTc+O5vMSggnWouoO5xQ/NtUpCJicVIJMjKD30XFKMvvQZmWx8ppeaofEC72pawHQ+4wjLqVYOaBhha0qTUM6iEYSObf4pmFrYXt4uqq7C4lOZJ21RFR/1gnL/C1fuex5qpOqt47yoJFLbNfubq3LgtlELlUj5qmAqYYS2xhlXy6zFn1rHhDWNqvsOWr2bPsGcFEqqVluQkdSc8xg3xmAI+GdJUmbHHh2eHmMS4AklDBO27MiADAf4PlZ5ixPYrgMXR+3W+jGs4KNWv+LesWldjyP/VJK6ZsdAoEP4SRS7JktCxVCzNb6UFhV14mWCT1DQYbPZkN098A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c19e42-40b8-425a-259f-08defe42430b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 22:36:07.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOLIDTK2jkEjDYHQymRVX/3LoxUqKqDqwDitK+g6LVDBhjSIQB8YnfCzFfuq4PC/QAYi5tB9dwz/R7i78EGqhZNjc2jO0yOQK78/dr3Egtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTE5IGF0IDEyOjQxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBBIHRoZW1lIGNvbW1vbiB0byBzZXZlcmFsIChub3QgYWxsLCBidXQgc2V2ZXJhbCkg
b2YgdGhlIHJlY2VudCBndWVzdC0NCj4gZXhwbG9pdGFibGUgdnVsbmVyYWJpbGl0aWVzIGlzIHRo
YXQgS1ZNICpkaWQqIGhhdmUgcmVsZXZhbnQgc2FuaXR5IGNoZWNrcywgYnV0DQo+IEtWTSBkaWRu
J3QgYWN0dWFsbHkgZG8gYW55dGhpbmcgbWVhbmluZ2Z1bCB3aGVuIGEgY2hlY2sgZmFpbGVkIGFu
ZC9vciBhbg0KPiBhc3N1bXB0aW9uIGRpZG4ndCBob2xkIHRydWUuwqAgSXQncyBub3QgYWx3YXlz
IHBvc3NpYmxlL2Rlc2lyYWJsZSB0byB0YWtlDQo+IGV2YXNpdmUgYWN0aW9uIChzZWUgYmVsb3cp
LCBidXQgaW4gbW9zdCBjYXNlcyBpdCBpcy4NCg0KQWghIFRoaXMgaXMgdmVyeSB1c2VmdWwuIFRo
YW5rcw0KDQo=
