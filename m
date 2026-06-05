Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE72829AB05;
	Fri,  5 Jun 2026 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642411; cv=fail; b=biAXd0h/6vw0jj6VzWi+Jd61gxhWGZD8FOp9YeN3bkslLJ+OQr5JrGvjCzlBKV4O6yW/GbZa2K2Eh+WmGR37PcijLoALqarQfZjPFiD7lzNxvIeA+MnycfbIhgjNYuOZecncQi8ZIDkk55vQozQ9hneb510L1rLaX1Xtft1tNVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642411; c=relaxed/simple;
	bh=ioru9ryiWYU5fBvfHijtFCcm04PX+n6JhPhJ0aCIF8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8Y8H8XKLS1NL8jvIVgEQxNMyJ2HiSssp7HzscjQn5lZKl44qnuJ40mN6r3opIqyHoAtqH5UFMjdf7Bp2rPniXr47tUTLY3/tPoNdA6KL+uMBtHHy9nvC0CysCiq2/5y2qQCbmsjWruJWbC89lQXQHlJGkcalDeDeptFPRGIHVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXxXEGou; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXxXEGou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780642409; x=1812178409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ioru9ryiWYU5fBvfHijtFCcm04PX+n6JhPhJ0aCIF8o=;
  b=mXxXEGou07KO8T4B3QCLcxwHjFHefmIf+D+Ys2tArvNm+lQg/UvroA2u
   2ARO468qW0Dm1T5cNyvcviJ8OPjeXk55SOSHBFQ1jAq0/O3mP4/URc+YR
   oRhLfo4WS5WphLXtIolLBx48GTmTqbKohGDRZnS72b+idlLdxBl7omZNv
   Ti16qfaPbsYTd5h7hHId0JX93EUvAlkU9Oe10ft5AwQlFxJ2jUpnUu6R5
   UDMka9MQJPh3aSaL/0LB4I7KiHHo8lBQ7Fzik13q1Np01aSJDL9cFheU0
   chHd4N7222VsXN9SQQZD5qCkF9NhQY5KdfHGUfHbeeRLDGU4L+JLogAZf
   g==;
X-CSE-ConnectionGUID: QplK3b9RQ+yqYJvbwuBxZQ==
X-CSE-MsgGUID: uvOYVul5Qk29T1b96YqUUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81219728"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81219728"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 23:53:29 -0700
X-CSE-ConnectionGUID: aV1z22WSSkOmihmOEQek6w==
X-CSE-MsgGUID: ZvhXd8XvTImjLU2bFRepvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="242278273"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 23:53:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 23:53:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 23:53:27 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 23:53:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKjFqXTdSncoKUoNVWiQ1qBlnxcgnoS5xRbNUtl+YHD7j32SJzL/G7VWDUMcApD7VMqB6+LdPUhJlLeHBN91UFJd25L3bf4Ip08cjV+1c+JOZwIrRceEi3EXs6/2LWs2zDPh+DUon1vgE7z0zxnxbk+eb3CS9M9S1UZ6HG3E/4jbr1nC8b0ihD4VmNEsQl1xDV9tWfNTrLmxV03PrTlhCOGxs7b3leEUkBRyOeHVyczNIeuYEN4kOfMrK3Slr9qVo6dLLdWNfduX3L7OSYNS/s2Jdpsio5JDfSbmz8b748l7mHHeWsBdms/NiagSKlaGJ3Rx7GUlnfYAtWAGDnBbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioru9ryiWYU5fBvfHijtFCcm04PX+n6JhPhJ0aCIF8o=;
 b=Dd/F5g3w8z43ACsTDF5N4KrmyFOGMD4JYY4LUXdtw4dZsZXGkVVC2cFONlvO1dUV+CWCFMc5jtUKw6jTVTVZVHcFH6yvMPZ7vJkrzklXzGZQG6a3dqSk5RqTPqZ/nXNyiHuplmEEgKU3tcebxVPuQimGukweCxuBoEdLL/FYmXREWdX/+y23Pr3dFsMOssAq8jX68hV47hKxvevPTTSLuwV2ydRiZfd689IXKjE1VHPf6L+vMDZF5VZAIaORCeGgVBTQWZc4/KjN3isR2/fglW4U6EeQxcyiSAuNyRuZP0kpam3UIircXkzPEk5o6KH8+lJZSoczyTbnUovm89+iPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 06:53:21 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 06:53:21 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 30/40] KVM: x86: Move MSR helper declarations from
 kvm_host.h => msrs.h
Thread-Topic: [PATCH v3 30/40] KVM: x86: Move MSR helper declarations from
 kvm_host.h => msrs.h
Thread-Index: AQHc77nH89g6z2fuoUCUpN0sqOVDZLYvkIiA
Date: Fri, 5 Jun 2026 06:53:21 +0000
Message-ID: <c5b560bba3e41c2109df39214a9b72d4a2ddc307.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-31-seanjc@google.com>
In-Reply-To: <20260529222223.870923-31-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CH3PR11MB8773:EE_
x-ms-office365-filtering-correlation-id: 0f74e6d1-2bfc-4751-a8cf-08dec2cf21df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: pbZt8g48tREIpD9RUC8tGoeXKZuJnovl4tPewDYDbcs/4riSZO0dzEkXTZNEf32t/64sF+BHXrI8YLxyTMET0QzBd2RmBOUxvGWuP/ZXd8cVkY6PWDbVXj5gw9C0vepM0I4L/rQJIoqQQwZRyG0EsoUd9tSYHpQRtRxypPRMSNlBQr76rPpal0m37CaJ4s2akc6nwvtLCGo5q8oAHjkthp6GM1GsgzeK83hJzym4d6hNiZys1d22bVbqIeDClOPMiaYN7JrImVydgZy/Z1W+cw+Wj3Hcbo3xTAmGd3rgDhSYgqvK3u2+r1YDAfdFTWv7+Ne73aWyE+AX3Lob62aIXIkMGZi8JE0Krn0pQ4+bP/vSztY8omMcU05ws5BECljvxTYBa0ee+5H2DJSKXJErH+Mgh/0Lbc/ky8kR83EngLQ2WPkXqTnbXUBydA7KBU7kQLuv2XjpqaM6jw3XsON9qMlBz+Tzb/AX8yJNgbQb+lz67AUuegF3uh0phJvGK4j34eFoaTji/d5WqasFV92OMsHFG3LaE7uQcqVYM5AzR/qno7CkC8Q3VglVglNYiJ4a2pes2CliGRwxzZl5TGQcjOMWgjuII8CMiZiRO1FQdHK1AzyeR13rr9lFbry6LnbQq8kwyZna8snB5XxUXSCGZdGaLpExu4x3Ey/Zt2/HiLxKRZPh7xAUuSjTbW3Dxe1cxc1a3DhuFffnfNBLc12iviAmCmlFzRXCHZ+8mDQ4pq6MhNK4GlzT1qdGPfYUUQU8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEFZZUxXK2xnWW4rdGZiVFNxbXZHdXhaUHFDdjhBQUVYd2xpMi9nTWh6d2d5?=
 =?utf-8?B?NFd4dTFUVVMxdDFDODNxbnBkVEh2Sms4cGdUVUZXVDhUd3FKaEIzUXlYZ2Vs?=
 =?utf-8?B?SFp1WWhxYjgwUTZlMGNKMy9sY2FHZ3E3eWYwWFgwOGhGNWN6aFRhcTF0Szh2?=
 =?utf-8?B?NUtTLzNWZmhEczVsUWZPYVVHWWxFV2p3REJjUFdLZkN2VUVGQS9ubXdFQVJV?=
 =?utf-8?B?VDN1RHRyUmlYSnVxODMvWmVUYnpmMjBlQWNvcG91ckt6WFl1K2tQSUdvdGVl?=
 =?utf-8?B?SjZMdFlRdGlwS2c2ZGV2ZzcyTGVjOHVkcS9zS0IrdHpyYkwrY1FqdkIvbTZD?=
 =?utf-8?B?eVpkZldGRXdPQnBuS2xhQ0Y5R0E4RTk0V3RRS3R1NmJMb0RlV2RjbGlDU1Jy?=
 =?utf-8?B?WnZGdXlMR0Q4NmJBVEY0Qmc0THU4d2lCZjFPaVRUd0VySUZDZXVBV3h3eWUr?=
 =?utf-8?B?Q01HQTBRd1VZUG5GSk9oMm1hMWwrNTZYMUxRT2Ntc3N1QVY4TWZmYk1CNmRZ?=
 =?utf-8?B?VFRnZHo1ZWRzTXVUVUk3d0RCY0drVmFYZzhYQ1BTamlBVjVOclJwMm9wRDdW?=
 =?utf-8?B?TjZNNG1DNmhvSHRLWkJMOVpKNWtjUnZRSjFiek9XcDBDUHgxUExYRmJsQ1ZB?=
 =?utf-8?B?YnhCb1RWNDJLN2VtdjRpOHE4ZC9udEI3dUNMOVExNk01L2RIdVR0WjBpZTlq?=
 =?utf-8?B?aHJwNlYxdWVZNml1R3lDMFdNT2JSSjZCYVl6bmt2UTVqVXhYOHozbXBUbEMr?=
 =?utf-8?B?SFcxRFVKOGFkcjZRMEVwWE1mQ1E2NWVBNmd2VFF1L1laME9NTkRudFRWWElt?=
 =?utf-8?B?aXdPSUN3TCsrTzRnRUpHN21PQzRIL2t5RmRXM25mNXk0NUtVUmdtR3FiZHV0?=
 =?utf-8?B?S0w1TGI2TDBEMUR0czlScllQV0Q0Y1J1R21hK1JFRFNMSE1NUGdKOEtETGdx?=
 =?utf-8?B?OWo2NXhmckRKdzdRUCtvb25pSFU1dlY5SlA1VUVYYVgzVVR2VDNpb1JaRXRL?=
 =?utf-8?B?OHMyL2hvOWk4aU11QWlVT01zZGVjOTg2a3ZWSWJaemdDelFmQ2pJZHpzL1lm?=
 =?utf-8?B?OWRyL1VoQ1EwUFFKUm1pR01GOXRtR1NXRTVlUUEwK3Z1NGNvNS80Q1J3UDll?=
 =?utf-8?B?dTlvamxHV09MVFREUmF4YTBmRWJKd25ZVGFmYysrRm9ZRzlGY2tIZzlYSno5?=
 =?utf-8?B?RnBHby9yWUk5S0VVSG9nTVl5aXZCdEhIajhwMXZqZWJCVmlXbDJXSjFNN2Zr?=
 =?utf-8?B?Y3c5bjkxcE9zZnNJSFpjMUxYMEJZaFVqTVVBT0UyNHdJeVFOY1JRNzN6eXBx?=
 =?utf-8?B?VFh4L0lyb3Y3QmhSZEJaRVEwWEJocHhoOXl4VE1ZSXVMZnVzeTRSQkIwOFNU?=
 =?utf-8?B?dUNrclVMcTcwbkNnaUxRT3ExSEc3MVFGTHc0QVhRb1ZCL1hzMDlRSkFEMzRz?=
 =?utf-8?B?VlEwcmQxQjdIUTVMVGlnVlZWcDF2VFVLbVRubGF4amgrbnJlSUlpVEdPd2Y0?=
 =?utf-8?B?YzRwTlE2bmlHdWxqZEd6ZnVFcmh4QVNxbmFEYkk3ckFRSHN4dmZlbHdoWGE2?=
 =?utf-8?B?bjBrTlUxTy8rVWhOeDBIRVYwMlV6NHlmbFVFYU9IL0JIeWgxamdUT1RXZy80?=
 =?utf-8?B?YytXQzFwMlQrc2Z5cVMzL0cvSkhmQjMrOUFjczBYWGh1TXM2SWZVbnRad2NC?=
 =?utf-8?B?dEhYQm9CR1RaeEdkOWN3cFcvWmNhN0hjYXhQR1hYMW9DdXlLVkNrZWwyVk1N?=
 =?utf-8?B?UFlWdW95dlBPTUprMU5zSlhvV252U0pJcmN5N0FUeEkwYTROaFNkNjNVemlz?=
 =?utf-8?B?ZlB6NDFrQVNyWXFZQXBYQVhRMndNZXV0dGp0YVdVNFdlYzJJZXBJQnk0a2RF?=
 =?utf-8?B?MWlTakhFSlNiS0ZaQldCYXl2am1IbEF5UXhpS2NJMkRiYVBXRFEwZmNTZXJJ?=
 =?utf-8?B?R0dlN3cyT3IzRVZTVGpPKytUaThhejZoU1l4TUNTRnNlNjMyLzdhY0VwdHUr?=
 =?utf-8?B?dEcvMmRTY25JbW5qVmdaSmp4MDdFbE5pWTlRcS9sQ1c5N2tUM2ZZamlCQmRa?=
 =?utf-8?B?dmtucjVBY3MrUWtnZjlzZG9zZWVvZWViaE1hemsvYzZQV0dHL0Z2KzJhYlNU?=
 =?utf-8?B?eElXM212b3VzTWdKditMK2J5eURYbTRmeUlxWG96MEhxYk9wNmwxSW9ZSkUr?=
 =?utf-8?B?ZFF4MkdIZXkzb0ZvWXJsWUtQK3VzWXRGZkVQSE0wSFdVSjNNRUxSV0J6UXFO?=
 =?utf-8?B?TjRWcEQxSDl5VGl1a0d1Nll0T0ZhWHNCTnhkZjhyZkJqbzZITUhOK0YzWllv?=
 =?utf-8?B?MzFJbTRHWnVRN3gyQW4zeHQ0V3FnTkVSMkZGb2hBemUxMVBWNi80Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E28DF5DABE2044DA1A5133E679D6694@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rGzfWJcLUuBizulfHOgkhZvvKQHUaRKHsC5zVYwXkPtbdXNWfDyYM+rfcDp4EICXWR+V5ZSL1xfxqQTWvM+RjOfKdwMxn9CHlBzAifvIVlmVyMeDS9EYm7yQioTgrrPyTtt6o+jngEwFYbx9aEPPJqGvw1m7rBDgm2+V84dgqjzJL73xC752ZEyyZ/4SfxdzC1q1oK8MBh6oGidCeHxrYWGxrSkhdWq3cBS2kEf/hefJZ4wTDZ8H2A7CG8FAHGcESsjOv2gbsqdL2DJowgplg9lZAfIfgRmOdzhqRCXgq4BJ6fioVLOoQU6r8tZ/u9CIww+ULYRsGYChmYZxVfV60w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f74e6d1-2bfc-4751-a8cf-08dec2cf21df
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 06:53:21.5050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dqhbyCD60bRv9I8NuYJZvebuubBDveNP3cYjtkHZuMyftyY8mEdHBfR723eXedjksad0qEAt70dUbOprIXfMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8773
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZWxvY2F0ZSBkZWNsYXJhdGlvbnMgb2YgTVNSIGhlbHBlcnMgKGFuZCBrdm1fbnJf
dXJldF9tc3JzKSBmcm9tIHg4NidzDQo+IHg4NidzIGt2bV9ob3N0LmggdG8gbXNycywgdG8gY29u
dGludWUgdHJpbW1pbmcgZG93biBrdm1faG9zdC5oLg0KDQpEb3VibGUgeDg2J3MNCg0KPiANCj4g
RGVsaWJlcmF0ZWx5IGxlYXZlIHRoZSBmdW5reSByZWFkX21zcigpIHdoZXJlIGl0IGlzLCBhcyBp
dCB3aWxsIGhvcGVmdWxseQ0KPiBiZSByZW1vdmVkIGVudGlyZWx5IGFzIHBhcnQgb2YgYSBicm9h
ZGVyIGtlcm5lbC1BUEkgY2xlYW51cC4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVu
ZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdv
b2dsZS5jb20+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+
DQoNCkJ0dywgbm90IHN1cmUgd2hldGhlciB5b3UgbGlrZToNCg0KV2UgY2FuIGFsc28gbW92ZSB0
aGUgYm9keSBvZiAnc3RydWN0IG1zcl9iaXRtYXBfcmFuZ2UnIGFuZCAnc3RydWN0DQprdm1feDg2
X21zcl9maWx0ZXInIHRvICJtc3JzLmgiIHRvbywgaWYgd2UgcHV0IG9uZSANCg0KICBzdHJ1Y3Qg
a3ZtX3g4Nl9tc3JfZmlsdGVyOw0KDQp0byA8YXNtL2t2bV9ob3N0Lmg+IGJlZm9yZSAnc3RydWN0
IGt2bV9hcmNoJy4NCg0KVGhlIGJlbG93IGRpZmYgcGFzc2VkIGJ1aWxkIGF0IG15IHNpZGU6DQoN
CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KaW5kZXggMTE0MzE0MDU5MmRmLi5mODdiODM5ZmQzYTQg
MTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQorKysgYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQpAQCAtMTI5MSwxMyArMTI5MSw2IEBAIHN0cnVj
dCBrdm1faHYgew0KIH07DQogI2VuZGlmDQogDQotc3RydWN0IG1zcl9iaXRtYXBfcmFuZ2Ugew0K
LSAgICAgICB1MzIgZmxhZ3M7DQotICAgICAgIHUzMiBubXNyczsNCi0gICAgICAgdTMyIGJhc2U7
DQotICAgICAgIHVuc2lnbmVkIGxvbmcgKmJpdG1hcDsNCi19Ow0KLQ0KICNpZmRlZiBDT05GSUdf
S1ZNX1hFTg0KIC8qIFhlbiBlbXVsYXRpb24gY29udGV4dCAqLw0KIHN0cnVjdCBrdm1feGVuIHsN
CkBAIC0xMzI4LDEyICsxMzIxLDYgQEAgZW51bSBrdm1fc3VwcHJlc3NfZW9pX2Jyb2FkY2FzdF9t
b2RlIHsNCiAgICAgICAgS1ZNX1NVUFBSRVNTX0VPSV9CUk9BRENBU1RfRElTQUJMRUQgLyogRGlz
YWJsZSBTdXBwcmVzcyBFT0kgYnJvYWRjYXN0ICovDQogfTsNCiANCi1zdHJ1Y3Qga3ZtX3g4Nl9t
c3JfZmlsdGVyIHsNCi0gICAgICAgdTggY291bnQ7DQotICAgICAgIGJvb2wgZGVmYXVsdF9hbGxv
dzoxOw0KLSAgICAgICBzdHJ1Y3QgbXNyX2JpdG1hcF9yYW5nZSByYW5nZXNbMTZdOw0KLX07DQot
DQogc3RydWN0IGt2bV94ODZfcG11X2V2ZW50X2ZpbHRlciB7DQogICAgICAgIF9fdTMyIGFjdGlv
bjsNCiAgICAgICAgX191MzIgbmV2ZW50czsNCkBAIC0xNDc4LDYgKzE0NjUsOCBAQCBlbnVtIGt2
bV9tbXVfdHlwZSB7DQogICAgICAgIEtWTV9OUl9NTVVfVFlQRVMsDQogfTsNCiANCitzdHJ1Y3Qg
a3ZtX3g4Nl9tc3JfZmlsdGVyOw0KKw0KIHN0cnVjdCBrdm1fYXJjaCB7DQogICAgICAgIHVuc2ln
bmVkIGxvbmcgbl91c2VkX21tdV9wYWdlczsNCiAgICAgICAgdW5zaWduZWQgbG9uZyBuX3JlcXVl
c3RlZF9tbXVfcGFnZXM7DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21zcnMuaCBiL2FyY2gv
eDg2L2t2bS9tc3JzLmgNCmluZGV4IDVjODM2MmE4ZmQ5Ny4uN2E2OTBhNTE1OTQ3IDEwMDY0NA0K
LS0tIGEvYXJjaC94ODYva3ZtL21zcnMuaA0KKysrIGIvYXJjaC94ODYva3ZtL21zcnMuaA0KQEAg
LTEzLDYgKzEzLDE5IEBAIGV4dGVybiBib29sIGlnbm9yZV9tc3JzOw0KIA0KIGV4dGVybiB1MzIg
X19yZWFkX21vc3RseSBrdm1fbnJfdXJldF9tc3JzOw0KIA0KK3N0cnVjdCBtc3JfYml0bWFwX3Jh
bmdlIHsNCisgICAgICAgdTMyIGZsYWdzOw0KKyAgICAgICB1MzIgbm1zcnM7DQorICAgICAgIHUz
MiBiYXNlOw0KKyAgICAgICB1bnNpZ25lZCBsb25nICpiaXRtYXA7DQorfTsNCisNCitzdHJ1Y3Qg
a3ZtX3g4Nl9tc3JfZmlsdGVyIHsNCisgICAgICAgdTggY291bnQ7DQorICAgICAgIGJvb2wgZGVm
YXVsdF9hbGxvdzoxOw0KKyAgICAgICBzdHJ1Y3QgbXNyX2JpdG1hcF9yYW5nZSByYW5nZXNbMTZd
Ow0KK307DQorDQogc3RhdGljIGlubGluZSB2b2lkIGt2bV9wcl91bmltcGxfd3Jtc3Ioc3RydWN0
IGt2bV92Y3B1ICp2Y3B1LCB1MzIgbXNyLCB1NjQNCmRhdGEpDQogew0KICAgICAgICBpZiAocmVw
b3J0X2lnbm9yZWRfbXNycykNCkBAIC0xNTMsNCArMTY2LDQgQEAgc3RhdGljIGlubGluZSBib29s
IGt2bV9pc192YWxpZF91X3NfY2V0KHN0cnVjdCBrdm1fdmNwdQ0KKnZjcHUsIHU2NCBkYXRhKQ0K
ICAgICAgICByZXR1cm4gdHJ1ZTsNCiB9DQogDQotI2VuZGlmDQpcIE5vIG5ld2xpbmUgYXQgZW5k
IG9mIGZpbGUNCisjZW5kaWYNCg==
