Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB093515DC;
	Thu, 13 Aug 2026 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645149; cv=fail; b=fx8oGHutvk4wHLROEiemklXa/gQoKY3L1R26k9wycvkx4Cv+vzDtVPfPYaDxmH2IKK1zFDJEsVz7fwC32UrYpBwHIYFPXUIPW4mSN7SlmzSeEIuoBNWpow2ISD6/rsWCfX/bX66w2Jl8uB4ftUm2iCg+kimwd4LySxYaPziFCCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645149; c=relaxed/simple;
	bh=6/dyL/Gki7Sk/qvsIxEtKdNpP8DjkcEaFeR88FhtqWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qHZ/XU9/LyDGhPP821w+jgFL2R2OdNCTV3u8yj99299bwGYhnguteoKQ8OCoL9EmfOT97T+HrALSCzaLSYn0gbahmlTOABBXwZpjm3+XatpukgHLjj3OAYGWc5SK7vYAQmuAEhSDe6+2SYcGokahizLW/6lCdPTws37q1vzVnpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PArXDt0h; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PArXDt0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786645147; x=1818181147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6/dyL/Gki7Sk/qvsIxEtKdNpP8DjkcEaFeR88FhtqWg=;
  b=PArXDt0hQJ57hC3z8bjGay5lgVunEa4QI4GyNUIpnmjZT/nMPKA9mjje
   84uUClc/a53VIuC7ZRxvW4PRZfofDgvDykRWwaCBmzxMwGHAOg6JB2MSY
   MDH4dkUQKtE3nDTYznKYp41GWP2BlCr24xsrIE273HCsbgXv/hLxxoJhu
   SQL6aOt/bTcBYqKELBYP0JzMurLtUoV1i0e2VZAIDwfz38gToRTZcEEsx
   byDcWUku0PdKI4gzoB+l6DXDybauKPqqYHEiGGr4qjSMh0DUI6Rrgkud3
   1N9whuBi4NWLPqs7FnNRYBKDRcl0OxUDj7HRR/ISBNVA7iUPere6MpLRV
   A==;
X-CSE-ConnectionGUID: F8oj7LAMSGusshowwQysKA==
X-CSE-MsgGUID: SSs3ReyVTSGFeHHmZkWE1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87151679"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87151679"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 11:19:07 -0700
X-CSE-ConnectionGUID: A4rojLwCRc6dfGu0Hb9A6A==
X-CSE-MsgGUID: FEBLVegnTgSHpPu5ZAwmWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="260202998"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 11:19:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 11:19:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 11:19:06 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 11:19:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNb1/JyDXFt9AJf4k657DdNuG1pgIyCM/fvFmHLEipiMl8xQlNDx2RT6YvecO7d0IpK7nVb08HOb0Z3zQWTv15pMROYB87vXR19pH4byA3jUJ0o2gUZYM3UMbdDonM82rpY9nJPd53Ew0AQ3A0OLiiaXJXH0FXcedKHRsVtbuSgGcQOqh4tRToyLuP8uYofv/OEmfm/kenxkpH/mOczUDjoDfRSRpRztdkQO1Kiy7z2Ke8xOcWQV/uQ2+wLWzRPm9ZjmkrMyIjvaPSy/j06lfMctIKEXhrM60hrVzrAX7rEOQUMZyQh9HTWq2p9N0YimnJYFllINQRFi4+DzwvRn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/dyL/Gki7Sk/qvsIxEtKdNpP8DjkcEaFeR88FhtqWg=;
 b=u9gUKf1Y8+ZkMDlbZHZh/657paH4oyaEFhmhDyDNzv/1u/+JQQhdR2XMAeFCH8rqnrBiqNC3HP4rccTVPAdwO5IhQi7zxW3lKw2Fuk2MME34T6m3QgxgWhI/yVpiEuXyEu5g9gFbgfjAVFGWVLMQSuOrhKA1LQPNCgPOlNGhO2zrmOMKym3b1LvBmNVA+h3lvLG2Fkgnr4jZdSsXkXr0C5NIvqgwXO4pgaAWPGmpqzAJe9sRMzqb5L/6bV9HH1g9PsXJ8GuyD55V4bAp+6aEfeOjsuAvjYCob7PH5uYOa/ddDvlQXOkt+mA8+r48wxSIb53NnGAVAsAduVqJcFG6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY5PR11MB6162.namprd11.prod.outlook.com (2603:10b6:930:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 18:19:01 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 18:19:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
Thread-Topic: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
Thread-Index: AQHdKLszJKJ95KF+vUOi4YjlC1BNl7aYAh4AgAAO8ACAAw+UAIABLlOA
Date: Thu, 13 Aug 2026 18:19:01 +0000
Message-ID: <c2093dc50d2603c90fd40c7544561eb95d017898.camel@intel.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
	 <20260810112200.2326727-3-xiaoyao.li@intel.com>
	 <5dfed336a46329ba39922dcb3a8723116dae9ae4.camel@intel.com>
	 <6bb1328d-e995-4ad7-9744-3ab01d2ae591@intel.com>
	 <an0M-LwrKxLrNC9H@google.com>
In-Reply-To: <an0M-LwrKxLrNC9H@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY5PR11MB6162:EE_
x-ms-office365-filtering-correlation-id: 03b89d9c-4aa1-44af-20e0-08def967599c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|38070700021|10067099003|4143699003;
x-microsoft-antispam-message-info: baWP9WzO2i0WVIbM83RMochqY4rPdF3DeGJFCKxw7KHZloSdpWOs3SE3FrISx+v0n1JD5VIjXAaki73b5XDgyKVBXqnLoWWi9wEtUeDPioy/XkcAApUFFUtxV+ZBLhs7Xq+eORuu0nTtc8F42HJo+kR9ct9PzHtdMrZssOJ8adYGDKOwVW+a64ujG9btftKxGZ3ZEK+RQ1xFAGTvDoqL+RRMvBpwZUR8dtAXfBCK/y0x6auv51vg2fAgtmf1mMO8D9oNAuSgQlpQWd1L+J1H+HKKueDC5CEKS6L2MoFUOaL1rzSmjOpuB86v9lHNAH2fb2S9tBgV/05D5uHDcJnPCv5G26cyK41uU0UP6k52zu4DRIb8pENQ5Ru7V7JfY8ycTo1116t4t+UyQcQL/a9+sbcinpzei+CVaMRnj/6zwGqsAONRkjTJbD5AL6zKbAg2V5w9RNvYPpvr9BL4SA4oHeTIwdHmOWa9PckMC6rHsp5rMKTRAI6bPCOVss83ZNvnSrGg6AP1fRxmLSYIRWbbd4L/Da67+ZuHiuF0y0Dxtve1SeJcjGAOHGZATA1xDHKd1B5BvLdYzHYqTf8/eOiAZ7lPY30DD+0g/scrYhx4C+jv2bo7kRpraFTvz8KmcGFqpCje+XT7G5dzNNynPcQN0BYTsYPvhGBP8jKPwJbvyDdVwpLM50A9TJ+l78U5psSCW1+AF9TAFXDpdDuCM28nZMPo8S8kD/8yBEEwWTeMNtU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjZyejJHNHVQSXJuOFY2RHlWTnhadUg4eTRmek1RRE1EZ2phSTlEM0twWHNX?=
 =?utf-8?B?RlBCT1BYUENjWHI1UWoyR1BETkpRV0grTXZhU3MxR3Q2WFJ0NnFuakdmWWhN?=
 =?utf-8?B?YkxJcVBNTzdIb0J0bVBKVUE0QTBJVkxadU40UzZFQW5zSlZ6THN1OXF6VUQz?=
 =?utf-8?B?b1UyVGtFSUp4UjcyWHNDYWg0YTNPUnVTZThXRWp1ZU1hRVhTeUgzMHpVQ1FH?=
 =?utf-8?B?ZGlxQnFwY1hYY1AzS0FjamZlMGlVNWdNTE1vNUh1aHR5Q1V3M2kydFZDaHB3?=
 =?utf-8?B?citwN2RHWDV5TjU2c092M0JLcUxYZzk1Z2djSTM3T3VGcEFxZjdoNjlmRHRq?=
 =?utf-8?B?QUtVUjNQWk9CditrLy9SN29xMjZONlNVd1ZMVEhhOHVKVzJsOGt5elVxQ0FO?=
 =?utf-8?B?RGdaN2lnWFRwRjVOSTgvcnhsUGw0WWNRSUxFZHVSbjNWZm5rVXUyMGUzdnVV?=
 =?utf-8?B?SzQ1UG9BWVhzRWttdlVEdCttNmVoZzNKYWdxVjJ0Vlc1a0V2aTRzRFNYUGVD?=
 =?utf-8?B?ei9mODI4VFdVanJhSzFwY3BHL0dyekRYZjBKbEtLMWtWT0RTd3ZsSGxQODZz?=
 =?utf-8?B?cHJxMnk3M2VFeHEvbitKTmRKWTBjYXlLMkk5ZWhRU2pmbWFYdmJSZ3BSbytG?=
 =?utf-8?B?OHY0dENjRkRGYXJlN0lxOC9MV2R4a1FqTDE2U3RrZ2hXd1JTSStUcVp6L1B1?=
 =?utf-8?B?VEtjblBJMU5zbjU2M3pkaG1lVHRKR096bm1qNUQwajNRY3dKYVVUZGRSRFhp?=
 =?utf-8?B?VXg4eHczMU4wbXppTXZxWXFQa2JVMExuQUhqS0lDbk9TaWJoY1B1SVdnMSt1?=
 =?utf-8?B?T2hBSGhONUJwVE9wcGx0M2ZyaEVjQTJzaldORWdma2c3U1VrYkZWMzh0VE0v?=
 =?utf-8?B?WDVxNTJXT2t1aTEyd0w0L0YwTmYyYkQ5clptWUMxL3B0ekJMdkordVZKNzls?=
 =?utf-8?B?ZHRadnFQWWl4SFlJdFpTVlVzek8zUm1xSkZFZjBQQkpvQjF6SWQ0eFFENU9O?=
 =?utf-8?B?WHhab1FEZTZoV1hSY1hFSEZzY3RibmlJMURnbGpUTDZJMllZZm1QcFFveEtT?=
 =?utf-8?B?M1YxdlR2UDdKalcrTzhzYzlMbG5zTGZRZVc3akFjelpSVW5VSjE2ZVozdE9N?=
 =?utf-8?B?Z0pBc2pzZjFXdUZVU25jQjMzSVdNeDBGLzM0U0N5ejZVeS9wREJOcVBoVzVC?=
 =?utf-8?B?b0w3YUVVTmpxL2pyNHExaDF0Z2JsVEJrUkZUZFlmd1hyVmgzblBJK0FzTktY?=
 =?utf-8?B?cmgvNFo4VS9LOVpHeFRlWjdSd0tBU0x2QXZESTZqeFA2c256ZEllbUVkNUJQ?=
 =?utf-8?B?cUNiNGIrdVlpb0JuY25wWjZkY2plTVE2ZzhmcElITGw5UWlHbW01azhLVVda?=
 =?utf-8?B?eUhlQWhRM3oxL0dWNEpTN1g1M2RaWDFhcTBYQmdHVUtQUnFyNGRZRkZzemdS?=
 =?utf-8?B?QysvNGxORG5wbStQdGlrSFdNYmp0TFQwVU9LZ3ZQcitnZkZlbFRhNjV4T1Q3?=
 =?utf-8?B?UzVQUWlIRHVIS3h4aXZlUXp1VDRHbUo2SWltcjVxTUdWd0JsM2tENHFvdk9U?=
 =?utf-8?B?WW9JQlkrVkNsdjQ5NzNqZ0ZzU2lGNlVLbHVZV2oxMnRJZkExZzg2am5mOG93?=
 =?utf-8?B?ZUx6ZzFaODg3NGhwdlBBV09MMU5yUVFRTHQyamF0THdGSFQ0bU9KMXlIZVg4?=
 =?utf-8?B?SnZDalRvZTR5TTJNM01CdnVjYTNMci9hTWVCOEtOYzc1TTlvMHFNYmJuelRW?=
 =?utf-8?B?N1MrSWZJb3RZcnpDRnhCYUpObVFDTm1QTUh3OXJwRm13ZFhSUmFGS1F4SUhq?=
 =?utf-8?B?QUlOQ3JPeWZSQ1Nad05Xa1NFU0VmRDVrbzlZOWhsTFpENEU3OFE3MmVBZFlt?=
 =?utf-8?B?empMRTdyZFpsTWdONUtLc1VoMlRBSmRUYkhRZjlGMHZNNUVTWkJVbzV0ckVl?=
 =?utf-8?B?bEwvOG8yTTRBMzd1YjVqRFFQN21vN3RLS000QUxxdEd5L3ZBZWxRci9zTE9j?=
 =?utf-8?B?am1jTlN6OEZ1YTJyNkZuTjNJQzNlTFdaVmYwOVpKSk9NMXVsbDV3Tm5PTWZH?=
 =?utf-8?B?VVJBVE5MRlhQRFhYOVRLbkROMTBnbXF3VmwzcmhYd05EVVByMmNHWHRwRkdW?=
 =?utf-8?B?T1AvaDdHUjBvTjZIaUxhRVl6bGhDb0ZhVHdoZERmYjNTUXBGVTFGWWVOVnAr?=
 =?utf-8?B?T0pOcUNoaHFQdVhZZWRzai9BQnpQNnA1VjhOdDlHUE5Ga1RXVlZxWU81aStQ?=
 =?utf-8?B?Mk12UWZ1Zno0bGR0SE1uYk1EclY2QkZyNjd4NnVCRWQybUJGQ0pUMnBmN05P?=
 =?utf-8?B?Y1JFeS9ZWFlHUkcwMDR4ai8yOGtyUi9vdGYrN044NmRGTlY1bE9FTUlyUUZI?=
 =?utf-8?Q?KDEREI/AT4shNANc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EC195BAF9286C43B8118CFFF1F730CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TO39tVEwkhOwpcTE5dxO9PfR8o3pnGD9DTXFfDBg0lRXGwvYZqCpepYHc4GimZceF6aQcjf9hseYWbIpeJvumUy3RgTmvVfRrMY0JqNTEfx7DpWWyIuqEIil+lxy5Ye5PL7XlsDwDoduAEdWN9MdUeKwcZoNh21pWTWYRopmhURYoR3iQS7nY0G1JJOYAyBB7Pu38iXGox4xp7+LjlBbyihBxFKaSN0a9TqTgZcLX4PwdSgVDUFXa+XvF/33bb6vOJDDi/CnHjtCIdQgAQ0Bk8T8GnX89wSpO0x6XlCXN4JCdnAQLVj2nbpjctHDGnb1M3M4NITtWjbuBVxVaYp+oA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b89d9c-4aa1-44af-20e0-08def967599c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 18:19:01.3379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4zKrT63hBfq7cMVOWtINnrRO77C+qXFuEfb94jntlpdB0p8H8xiA2wqhPdjleV9V4FxXa+9y4zvn52tOoJX10lPnRJJccncOXhCSGGhXs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6162
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE3OjE2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+ID4gSSB0aGluayB0aGlzIGJsdXJiIGNhbWUgZnJvbSBTZWFuLCBidXQgY2FuIHdl
IHN0YW5kYXJkaXplIG9uICJURFggbW9kdWxlIj8NCj4gPiA+IFRoZQ0KPiA+ID4gY29kZSBjdXJy
ZW50bHkgdXNlcyAiVERYIG1vZHVsZSIgYW5kICJURFgtbW9kdWxlIiBhbmQgIlREWC1tb2R1bGUi
IHVzZWQNCj4gPiA+IG11Y2gNCj4gPiA+IGxlc3MuIEkgYWxzbyBkb24ndCBzZWUgd2h5IGl0IG5l
ZWRzIHRoZSAiLSIuDQo+IA0KPiBGV0lXLCBJIGxpa2UgVERYLU1vZHVsZSB0byBjbGVhcmx5IGlk
ZW50aWZ5IGl0IGFzIF90aGVfIFREWC1Nb2R1bGUsIHZlcnN1cyBhDQo+IHBvdGVudGlhbCBURFgg
bW9kdWxlIHByb3ZpZGVkIHRoZSBrZXJuZWwsIGkuZS4gYSB0ZHgua28gbW9kdWxlLg0KDQpIbW0s
IEkgc2VlIHlvdXIgcG9pbnQuIEknbSBvbiBib2FyZCB3aXRoIHRha2luZyB0aGF0IGFzIHRoZSBu
ZXcgdGFyZ2V0LiBJIHNheSB3ZQ0KanVzdCBwaWNrIHNvbWV0aGluZyB0byBnbyBmb3J3YXJkIHdp
dGggZm9yIGZ1dHVyZSBjaGFuZ2VzLCBhbmQgYmUgY29uc2lzdGVudC4gV2UNCmNhbiBwdXQgZml4
aW5nIHVwIHRoZSBvbGQgbm9uLWNvbmZvcm1pbmcgb25lcyBhcyBhIHZlcnkgbG93IHByaW9yaXR5
IGNsZWFudXAgZm9yDQp0aGUgZnV0dXJlLg0K
