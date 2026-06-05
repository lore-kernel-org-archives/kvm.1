Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D02EC0A7;
	Fri,  5 Jun 2026 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643634; cv=fail; b=U7GO7TYASebGhvsxXOwDK12TZH15nKoYk6COZbirWcBcpx068Pg4F1wEdn/oskGfuFI/Nelf7vtRvo7S0Aypl36joaM5WFjCJwqa4Cfi+A+N9zf1TBHYDbBUJC0K2kgRuO3oTCCGj1BgmrHGqIZnw39dSi4lkIC8N4hthGhB9Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643634; c=relaxed/simple;
	bh=JA5zQqhsjhDF5Xt3l63Puuea8BWBOZn2EzYWXT0EFTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o6uyu/Gl85GkrdZJ7mz51sfwci/UJG60uH3epib/7IwUTOu86w5OnbuLep0ImAcNJztR4B24CF8E/LVlnG21EJmYOGSrn7TnabO58j+D9kiu0pu/ltof6wFKRH+ScFXiqi9zzkVzivHnS6BGS12v/NEUu9MWBfQpL+CKlXw3nIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlKAt/hK; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlKAt/hK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780643633; x=1812179633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JA5zQqhsjhDF5Xt3l63Puuea8BWBOZn2EzYWXT0EFTg=;
  b=dlKAt/hKocxK0C8cE126hFz0y0dfZDz2gP1nj9A2rxsDYS0klxjn+ymL
   0Qe5JirKAO0Gohklme51WSY95pJNu//bTHxWbklGZDIDoOrFvS286yz6y
   oMvd3jXvwXB2TWNTjmQvvDCxrBSFWM3JzkKzSfegCeo/t1rKW6jx7kstz
   kY5T1thN6h5ZMFMm8MGsdgXtoFlEx9o7lDHYam5im/Q/4io6pgSz3o38p
   d2oLpVsk4ABDnVhHsbkm3+ipd1+orzzkftjsbk4Ofwp5qW/ixwN6LG36n
   YFUl9ou+He0f2xzLoXzvu7dnHe/gSrtvJraFF1qEDAKId31hMqMQWltXC
   A==;
X-CSE-ConnectionGUID: KGUy3NNeSyaMKGkrceQVqg==
X-CSE-MsgGUID: 2/2G6MpiSy6cbyR1lDWZrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81536627"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81536627"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:13:53 -0700
X-CSE-ConnectionGUID: sJ1djy5gRCamBxKXy9j36Q==
X-CSE-MsgGUID: 6r6B9GXvQI+TJVls9UoFOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="243940620"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:13:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:13:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 00:13:52 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:13:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLxggzGxnKTeMQ1mynS6Pwm+6m8SjyOmfC4SqZvzFMw5OPco1rDhckkBmDQzdW6wPHIRhvEATrIkXFeB6WP7IgGmeNExTuLurAV+YlEEqs2iD9SrxgVQcjfxroG3a0Tct8zSoFspFCMTVw1JgCF/0PYkHbJLai9y8omPvLbXKv/bx2xpO0dqh+j8Rzp/X8/uEy2hATjOfjvM2uZc90AgdRvmp5m/9/hl/+PzoIrSn/fdxlJfkIXXdY3e7PGW/HZVe4yE6sP6ec6cmeMT8RZ7At0ejHB6v4DeJGB7YenZf/5tN7k25k1i6PhWn7irhvYZgKMBR5OFxbMTF9qxElvlDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA5zQqhsjhDF5Xt3l63Puuea8BWBOZn2EzYWXT0EFTg=;
 b=Bt80mBuSe0BQGEvPJbsFF3LcMgtHquvTV6GkCjYye3lu5pRHJH29ERSVCK3NwRUbTQ4ery0SvOF8O/yrun5x5v8hlyuDm3FycMH6983GnWclKyhYjU3JZ+fc0qE5UDyQox0fI3JTgxGDGjCMHuRiQz0KFTa4G5xvLj+FynhY/JfGITZhHmami1dHZXLg6bzJkg142oipAI6/zFQVlZc2neczWb7nhnujwfKkuOVLcDoUd3321mGS24I7GRcS4/oJHuoMhEG5suxRr2JqMnchU5hg8Fh0twOE8SLNgJtIUE304bmQKYZPQuAWKZcxYRrCtFRGd3zR3h6Nrd1jyellHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH3PPFF2B8F6C64.namprd11.prod.outlook.com (2603:10b6:518:1::d60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:13:47 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 07:13:47 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 33/40] KVM: x86: Move kvm_cpu_get_apicid() from
 kvm_host.h => avic.c
Thread-Topic: [PATCH v3 33/40] KVM: x86: Move kvm_cpu_get_apicid() from
 kvm_host.h => avic.c
Thread-Index: AQHc77nLUCnjzNrjdEW7QxO/mSpMorYvljwA
Date: Fri, 5 Jun 2026 07:13:47 +0000
Message-ID: <652e8b73f2264316eaf72a604b89446df4874a2a.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-34-seanjc@google.com>
In-Reply-To: <20260529222223.870923-34-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH3PPFF2B8F6C64:EE_
x-ms-office365-filtering-correlation-id: bceab431-ded4-44a4-0373-08dec2d1fc6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: MDyMO2voDZwG5KYFL9kMKjZoERqs7+O4fgQBElr6LzZs8bd1ICL//CZk0DAltg5RlywYuqN/ZkBRLktKFAEv1oKZ/NauwhZuThQtJDCtJ+3VO98XbcIJsDeTavxuV1KsJkD2Ns4TdKXuSYjHardzSDa4pb9zvLq13U4f15TY+GTM5ZBpx8CV2ex2fI1drIhDzpoiokxmgwju0Pz7j8LHnn9zzAUsN2VaVuLPlxy48Gje2czDwQV/l3mlG4VI4Lyg2hisVHoGbH0E4hb5TpWcXEerE1N/sNRMnnG499d69p4tOReLXc0OffsonRWHisX/2L++a8IJ6imX/tcXPg5DsOXlctYFJWnriZBwuDbqbvNN14GySi2pQvNNOEWwK/NFo6Y5Qx/zHKMwnWG/PDTJd0q3pEwA1NjCp2dz/5VCBH/ssPXvzM7GQM2TXf93T5NTqtszjxoh+L9DHjpKnAHQf6u7zjKTu1kMv5m8Bnh1FUjxIN2J5P4wWjq0Kz5uhurMJt6SnzyTedmP64xWivXW8yGFDrTvRX4jwtF81eb04071YAvDC0+/5UPUjY/s0/nwsOljhjme9/IEhijeqc6hTqT3F2Og9bi+7BiavEZCRlHE9WLF8zb8Lm3903cvIMZllr7SZrsZWEaRm4RKh6mGuRJj3Cp7g8rb+UYYz42N93sCnIUFfZrD7Uf78domaJzzH0ZWZbovX5oOchj/rhLDWJcKV4Gy+fsC/DLu9pUQMkHFp0WuMP1NToxokoYkfMUc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWlnUkJudGlzVzZlcHVMN1FsMHRZdHRrVkhDUWhWcVNac25lWXViaXRjL2do?=
 =?utf-8?B?QWJpcm1CNWo2VWhuWWI3MmJZRXNHY0RUM1lLc3FHSzhZQUZkbktCVXRBc1pl?=
 =?utf-8?B?MkJCelNraWJjWUFYbXFlSzlRTy9TeW9yM2d2RWNIeEZYODNkY1dvSWtnenIy?=
 =?utf-8?B?RVVjYkF2ZUpjRU5VbkNpYnVUSExiNlFiOUs4N0NuOHFWVjlYZXRxL2Rqc0J3?=
 =?utf-8?B?SHV0aFp4T0kvTmRCazQrbmRSNStBVVdsNWdYQjdySlgyUjM3Z0FWcXhCWGQz?=
 =?utf-8?B?UXJ1c0hjUnF5R20rTkR0VisyUTdCZkczckFuVHd0MUNmWW9BK3h4WC9lalUv?=
 =?utf-8?B?bUtGRC9jSjdmS2NzM2E3M2RxQWxUWG9iTVNoWC90czlLQ3lJdWh2RnhocytG?=
 =?utf-8?B?S0J2QkI2b3hrbjNtMzExYzNqTHdzYjFDeUNxZlhJS1IxVGlpNXorQ2xrNTU0?=
 =?utf-8?B?RGdyR3lQN0lXRVlrOU1LVWs3cGdtMS9NcEJ2Q0h0UjNyd0Q5M0d0V29oUU5M?=
 =?utf-8?B?MGp2NHJrSmZLN1NSMGVRMDhRZmFYYXNvYlJRZ0ZKK1Q2TjI0UTZsQjZNcVY5?=
 =?utf-8?B?bmxQdmxSUk50YngvNm8yZ3ZlVUcxNmNSOTJvMnJnaUhIY3JkWGRSS3FPK0cy?=
 =?utf-8?B?d1EwTDZjdC8zNURyQ3hCQnJUeTUzU3BnRlVyWmVvckJ0b2xDRzZsNFhZK0pu?=
 =?utf-8?B?ZzNJeEUzY1pjNTQ1UVNtdlI5M1BGZDUzZVpUWmtYTzlselhmdkVNdlJ6OTM5?=
 =?utf-8?B?ak00QTZhbzhSVjZVeG5ZakdaVmJ3VXZPTmVidmtuWVVRd1NnL0xDbW8wWlpX?=
 =?utf-8?B?ZnRnbGYxaTJCdTh0NmoxRmIxdEEwZ0x6cXZmdkw3emFua1ZtcUdJN09qR21l?=
 =?utf-8?B?d2htVVpWR1VyWFpIL3NnbjN0M3VCZ2ZUR21mOElIbzg1aE0xUDd3K2FLRHI3?=
 =?utf-8?B?c2lwcER2OEw3UUlVeFlsMTRzd2ZBUG93a1BScUs5MXNzbUVEbnA4dmI5V1dw?=
 =?utf-8?B?OEFZYTlBWThkY2c0RHZNMHNXY09seHVWU2YvQWI4THVHWFE0enAzNHhCZ0Nn?=
 =?utf-8?B?ajAyZHpsc0RXN3dkb05QZE1HVmF3VWNtV0lKRFZiSDQya3R5NzlZclMrQXRR?=
 =?utf-8?B?cXZ2TzkxTEVGZmIwN3ZWUzFxWnF3RnVTckQrZjlHY1BNbmVwblRqQUtla0ZW?=
 =?utf-8?B?SjFUNmtJY2pvc1NITlgyN2lQMW5saDJ6Z3ZiSG1RbEcvV1c4bG8zMVliRFE3?=
 =?utf-8?B?d2tGRTMvTjloU1Z2MVlWNHJaN3BwOGtLS1VhRzc3WElKYlBGWHBCeTlIRXMy?=
 =?utf-8?B?ci9kU1IvK0F3ZVlqRjJ1V0VIaWJCTzZhLzZuejFrTExGNCsrVjNNcnp1NTRx?=
 =?utf-8?B?eFltZHFJQ3paZ1R6UWdUWVhMOC9SeVlxTTU2MmErZHZYNHc4VW56OUZsemtG?=
 =?utf-8?B?SytoWUJxODZHUDhZck91eklmOEV6R1kxUEhSZWxBc1ZrUllLSGtnQllEamhH?=
 =?utf-8?B?ZHFldjRNV21KUWRDdWNhT2lWT2dFMHBXQ3k2Y2ZzUTk0ZGgzOUVFRDdOQjVn?=
 =?utf-8?B?b1hzWWhvMTBHcEZ1MTVpYUgzVCtZdzNPTFVvVElaVWduOXZEQ2dCY2ZjS1Z0?=
 =?utf-8?B?Y21GZ3FhdWRWaVVpcGFlTVdUR3RPYlVVT0F2NSt3MFRHVU96MkZITzBwUmM2?=
 =?utf-8?B?ZDNSV09yZy8yaU9KVW05bWlVbjhvcUdzNFlCR0JIQVRHZkV0NmRYTHNhT1Nr?=
 =?utf-8?B?UTZFRlpFVS9jeG5GRmFBL1JkVEhkR0NVU2JBMGJmV05XVUJuWnBWd1JVNTFn?=
 =?utf-8?B?dVBaSWsrMFFyM1h4ODZEYmh4RHVzTi9rbFRNckp5c1FheERwL2xrOWljN1FG?=
 =?utf-8?B?eFVFMFV5QkFhbzZjRTd5V0dhd3NSZU1aVSt3aU41Q2lmbFhCV2pqTzBtbEkr?=
 =?utf-8?B?TkFQS0RUNnhtVlEwNks0WkZiUTNLQnZ6VFJIMG1nNU5pK1lzc0RrZ3ZyT2t0?=
 =?utf-8?B?RmFUZ3hMS3ZnMXBCZFZlZ2NZZEljMUYxRDFsbFgvOGFhQTNKTHBnekxaVVJa?=
 =?utf-8?B?QjJjYjBTck1SQ1Z3amVQbndoVzc5aEtYemNsSlA4NkNEL25oRzNrQWRmdkwr?=
 =?utf-8?B?M0x0d25uSVg5eE0yUDNQNWtJS2lQRGJwOHRiNGEwOHJFMmY0V0NaV2VTV05r?=
 =?utf-8?B?dmZKMFlvL2VMSG1YMUxERXJHcVpTRzdJMVV6Tzc2TklnaVRoL3pZaHVJemM2?=
 =?utf-8?B?Wit3VUJaQW0vNS9GREpOeFc2LzJDL0Y5dGxreEhlbUhVSmE1czY3NHRJUGZM?=
 =?utf-8?B?S1ZjOVV4RFZDaW1ua0xVNHA4WGZCTEs3QnJOS2lCaEs4WnMySjd5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3619830A767DA746B7301B606BCD66EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Cz2khRVlIYwxLrCHXMpblUpWncB4wh3VFX/uPxB8XAStsNTLQ83PmIAkFfhV65m5+XcxMESIrsq5prtf1b4wdeiZGEadetJEQa2YCj8JV73Y/2UM1nL2TPC7GiaNrPXeo1sxX2Q0R1Ib7xN+YZMkZEojYEigenC5e6zpA30K+dIVutf+V1/3/9k2hkXGcC37GaxVE7UwlNpjAYtiNQgjOVRHkUeozVD/Ien6e2ksXZ3LIhHZJBuWeWEcCYmPdzFru1COqfhcv21SXCkGZb+pPrDq1cIGA2sORop33yP9s/4QI+hUFUnMgFvW2toMiN948leLXNoX7xR22pnreojeoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bceab431-ded4-44a4-0373-08dec2d1fc6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 07:13:47.1557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ru/8n7nFS5LoeOIU/fq4ZEW6ndRGX4e+LQ10M5tSGBXe3NQb7Rn4f132giT8qepWP6dsjph4fyvqtxCzz2+YAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF2B8F6C64
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPcHBvcnR1bmlzdGljYWxseSBkcm9wIHRoZSBDT05GSUdfWDg2X0xPQ0FMX0FQSUM9
biBzdHViLCBhcyBLVk0gaGFyZA0KPiBkZXBlbmRzIG9uIENPTkZJR19YODZfTE9DQUxfQVBJQz15
ICh0aGUgc3R1YiB3YXMgdGhlcmUgcHVyZWx5IHRvIGRlYWwNCj4gd2l0aCBrdm1faG9zdC5oIGJl
aW5nIGluY2x1ZGVkIGJ5IG5vbi1LVk0gY29kZSkuDQoNClNlZW1zIHlvdSBmb3Jnb3QgdG8gbWVu
dGlvbiB0aGUgY29kZSBtb3ZlbWVudCBwYXJ0Pw0KDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5n
ZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNl
YW5qY0Bnb29nbGUuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0
LmggfCAxMCAtLS0tLS0tLS0tDQo+ICBhcmNoL3g4Ni9rdm0vc3ZtL2F2aWMuYyAgICAgICAgIHwg
IDUgKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5o
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KPiBpbmRleCAzZTA4ODRhODYyZDcu
Ljk4OTI5NGM3NTAxYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hv
c3QuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQo+IEBAIC0yNDI3
LDE2ICsyNDI3LDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGt2bV9hcmNoX3ZjcHVfdW5ibG9ja2lu
ZyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ICAJa3ZtX3g4Nl9jYWxsKHZjcHVfdW5ibG9ja2lu
ZykodmNwdSk7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbmxpbmUgaW50IGt2bV9jcHVfZ2V0X2Fw
aWNpZChpbnQgbXBzX2NwdSkNCj4gLXsNCj4gLSNpZmRlZiBDT05GSUdfWDg2X0xPQ0FMX0FQSUMN
Cj4gLQlyZXR1cm4gZGVmYXVsdF9jcHVfcHJlc2VudF90b19hcGljaWQobXBzX2NwdSk7DQo+IC0j
ZWxzZQ0KPiAtCVdBUk5fT05fT05DRSgxKTsNCj4gLQlyZXR1cm4gQkFEX0FQSUNJRDsNCj4gLSNl
bmRpZg0KPiAtfQ0KPiAtDQo+ICBpbnQgbWVtc2xvdF9ybWFwX2FsbG9jKHN0cnVjdCBrdm1fbWVt
b3J5X3Nsb3QgKnNsb3QsIHVuc2lnbmVkIGxvbmcgbnBhZ2VzKTsNCj4gIA0KPiAgI2RlZmluZSBL
Vk1fQ0xPQ0tfVkFMSURfRkxBR1MJCQkJCQlcDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0v
c3ZtL2F2aWMuYyBiL2FyY2gveDg2L2t2bS9zdm0vYXZpYy5jDQo+IGluZGV4IGI3MDgzY2Q2OTJh
ZC4uOTI2NGM4ZWYxZmExIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtL2F2aWMuYw0K
PiArKysgYi9hcmNoL3g4Ni9rdm0vc3ZtL2F2aWMuYw0KPiBAQCAtMTQ2LDYgKzE0NiwxMSBAQCBz
dGF0aWMgdm9pZCBhdmljX3NldF94MmFwaWNfbXNyX2ludGVyY2VwdGlvbihzdHJ1Y3QgdmNwdV9z
dm0gKnN2bSwNCj4gIAlzdm0tPngyYXZpY19tc3JzX2ludGVyY2VwdGVkID0gaW50ZXJjZXB0Ow0K
PiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW50IGt2bV9jcHVfZ2V0X2FwaWNpZChpbnQgbXBzX2NwdSkN
Cj4gK3sNCj4gKwlyZXR1cm4gZGVmYXVsdF9jcHVfcHJlc2VudF90b19hcGljaWQobXBzX2NwdSk7
DQo+ICt9DQo+ICsNCj4gDQoNCkxvb2tzIGl0IGlzIG9ubHkgdXNlZCBieSBBTUQgKHN2bS9hdmlj
LmMpLiAgSSBkb24ndCBrbm93IHdoeSwgYnV0IGl0IHdvdWxkIGJlDQpuaWNlIGlmIHlvdSBjYW4g
bWVudGlvbiB0aGlzIGluIGNoYW5nZWxvZywgc2luY2UgdGhpcyBmdW5jdGlvbiBzZWVtcyBwcmV0
dHkNCmNvbW1vbiB0byBib3RoIEludGVsIGFuZCBBTUQuDQoNClRoYXQgYmVpbmcgc2FpZCwgc2lu
Y2UgeW91IGFyZSBtb3ZpbmcgaXQgdG8gc3ZtL2F2aWMuYyAobm90IGxhcGljLmgpLCBhbmQgaXQn
cw0KanVzdCBhIHdyYXBwZXIgb2YgY2FsbGluZyBkZWZhdWx0X2NwdV9wcmVzZW50X3RvX2FwaWNp
ZCgpLiAgU2hvdWxkIHdlIGp1c3QNCnJlbW92ZSB0aGlzIGFuZCBtYWtlIGF2aWMuYyBjYWxsIGRl
ZmF1bHRfY3B1X3ByZXNlbnRfdG9fYXBpY2lkKCkgZGlyZWN0bHk/DQo=
