Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C33ED5A7;
	Tue, 31 Mar 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950461; cv=fail; b=oUEmby9R7mMMB/fdqFtU5s0PH+RG0c9t//nWtQG8jSO+zVKdhcVt3f7HQ/XtBWSJ1VsZh45JOm+PfwLqRN3WKmwG8Vt+WZWgWv6JyWMTbDlth+oW3O/XXH/2LAB8uTAT6n0qI6R/gv3nfiA9wxskqu+/8mlUtDaNuuM9mQG1T10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950461; c=relaxed/simple;
	bh=Ta5oHgTDB7+FzbXp0+yQu94S09SUfuVZHscLTLt7AfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1i5YacjAdb/duqB2DIn7Hp7APLl8UYsyEhGT2SXWhCalRi5W5xwCwJsnJn/DCSLhlvVmmjIp0gDB7jjRHcpd89cBO9zwntYaC9gXtdNO47dAfKfvt1xEvbZIRelyAkwCEhpxeg20XAE69Hqp/+QFmcEPAxWNb1WJdioN72TXNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvwSTLUz; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvwSTLUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774950459; x=1806486459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ta5oHgTDB7+FzbXp0+yQu94S09SUfuVZHscLTLt7AfI=;
  b=TvwSTLUzj6OFz0w8wE3OitTAaoMco1zvJ6x/0nGffSsun4e1Xp3i+eNY
   8TWFySFJCA94pAbYiPTwieO5zRDBvkMJ9Jq276Jv5EoA2rxrPliF0Tesj
   Voc14jDQWE36m1F8LLiK3jTpcClMiPDbAV7MlRT2L35EPyTzSQz1mqBj2
   DDd8WwnLVBG5EGnRPDHb6J1LrbauLvUQr5g7Xsa6btzptiG4aPqPXAYfJ
   B+YLn+6/21p0EtN+qp4IU0UZUBoQ1gi4XoE/ZY5K7GKGQ1Z4vDhwGSJyU
   O7CjW9ZYqXF35ntjYKIG8WOnKOotdJxKnRjB8iehc/fMk7w54sP0xkWTy
   Q==;
X-CSE-ConnectionGUID: jf4ATtJQSROER57f80sJyA==
X-CSE-MsgGUID: ZjqYUcsFTq6b5uQVpq5VNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93344897"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="93344897"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:47:39 -0700
X-CSE-ConnectionGUID: bQ7z9jKKR7Svrfn/JbMTOA==
X-CSE-MsgGUID: vwN3HPOMR16T8a04QH4ifw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="231132740"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:47:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 02:47:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 02:47:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 02:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpgZcD7z7gDzJQs+hQb3lWC5TooiS+19neITJIgKV7wOY9wwTJtnff65h+HkNxf684TenDScARZrg5ogjcV61DQaidqNgprW8ziAzC0jJqqlA9No4yDGWatDbvWR4iTCSvGGL/kVJ7mZxO9ahRf5OdoGXHg/RyZ74eWQtIjJQqGB9HcGe6EhKYwuUL57N9xOXran6OadSByu5xwDQppMlMhppU0/t1f6vPYg7bFyuprUr1tyMvwdkFNSOc5pCKDnROs8mg5xHUBqD39AsOTiKOTl/iPncC/KX7baosXQjByW/hVbqO5DdVQpo/4DnQOAoIz8sfqVFBVbUyNvM+DTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta5oHgTDB7+FzbXp0+yQu94S09SUfuVZHscLTLt7AfI=;
 b=KybMqFnXHDa8YfnpNsZe9QPzo2LBwRv9grywHHxxD3j7HJ+Dhlz/Anwe09AaVDi95GiqwYy21pGez67rr0J+TCIgAKjOA7Uvb4wkV5hgN1va6r6FZLN9hKEld/aDCRU5YHonTZ9iAbgIskXxSgGDCMwoVJuDM0AvviwObnP8+P4YTPxeqfyswGkBz3K8Km5CIE0zQ3BODYiNEMGd8dvnYW5Lzl+M5sJro9yB0IMC/13nbGEX7VSN/1s1M2wao+HKumCbCOWPXnXQ5yFVYuEg/JBaucovOqIEHte1id23rGtH/DwrnmrL7UPnGpmO048agMkjjYX3CSQYuLHsMu5cfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CY8PR11MB7034.namprd11.prod.outlook.com (2603:10b6:930:52::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.6; Tue, 31 Mar 2026 09:47:29 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 09:47:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 02/17] KVM: x86/mmu: Update iter->old_spte if cmpxchg64 on
 mirror SPTE "fails"
Thread-Topic: [PATCH 02/17] KVM: x86/mmu: Update iter->old_spte if cmpxchg64
 on mirror SPTE "fails"
Thread-Index: AQHcviZZFnrZqGY3+0mCqCraMGJG57XIaneA
Date: Tue, 31 Mar 2026 09:47:29 +0000
Message-ID: <49cdf35c32e064ef5d6ca24bd4bb9d8b26bc2202.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-3-rick.p.edgecombe@intel.com>
In-Reply-To: <20260327201421.2824383-3-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CY8PR11MB7034:EE_
x-ms-office365-filtering-correlation-id: e033512b-52f3-437c-26d5-08de8f0a861e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: /0gEqOWRy28rXZg7VK1PEFcO4TLwZvBikka367/xffScZexHAPALqivcianEJrHEgctBl1hv51ZNPmWDgFLdsQV3qib1OfejZ8S0gWBemxJFtZQ6LPlXNBVu5jz/hGicLQPKdkmyiRMd2VwBesfVRPyotyCTFOMjDG1qfVxIfxLsvmXZlpa6N/VvgNLiAeKFUBmL6GDiPDy1801kFdnlBDLiArMrzuU2bKgn+FBu6zZpCzIi7wYWLdVLUwPJbCIt2yZEsGeN4Y9OVmV3pKix8LzLF9qSHobDuWjoPSzKehxm+ES6mP3P3Hjr7wh3gALEedko+XP85mRJ4XwKRHbLlQuQbFoFl89lHzXswUWlHBK/YfEmVk1O20l7ino0thUXxZ81cMcjR/CIzeKWqw4BfrON/bDjGgoqjJOEoCsQpo2IgHCvXg42QfQuP2zagNaeTsl/QJWklmxGCcIGKbU4EZchxZkKwmwZysy41fslnQd2Auv0brGZtFTiA8HoYJUAOYUd9fXpjZgp71mThe55NUNX51cr9OHO02qpHqDD5ON5EToVbbWLdDhXw8tZh5h2mkfeBXTaRLnpFtftOx4um1fnDJ3xH19JT9kt9SNA+LKjM8FCseE7lsXedKaaaoTBp9FkNVmGfhP0gRly+DKO1aYk4moTIWJVk+Je8Oag/qt/Wqvc49nDm9aFyhFQc0oVkKDCLWRPLDjbaHFMlzNBfpLjFpOicnHoI4HLlDd7HkEttVO3BcnlXYdqJfNQkHLxZ4OA5mM9dzD8ihhde2r5BfIscm0nmWy+/YjDpF4vNwg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm1CeC9XdTVwUnVMb1dTK2JLL2NYUERnejg3dUtoMkdhT2pmbWNMOEczV1My?=
 =?utf-8?B?MG9XNTNnQkZZaVIxSHgvNEdTdTlwSUV4citwWktIN3phdkZnQ1o5R3R0QklX?=
 =?utf-8?B?Sy85ZjlnTjUrM1ZCTWxJVWNOZkduSkFkSXVXSTh1NFAyQ0dkSGJhTm4ybjZM?=
 =?utf-8?B?azJvTEIzRzRSS3F0NlNodGtBcDMrOS8rbDJrL1A5ZmdvVkNCaW00bXRqekdS?=
 =?utf-8?B?Sk1NOFl5ajQrejhaODk3VG13ZENwc1QrSzZNOGtWVjZKOW5QMGdGVUNXdGcv?=
 =?utf-8?B?eGNXMzYzTW5weFp0RjBPLzVudkRjZE9OdmgxYlluc1JUTHpjdlR1NG9tTUdV?=
 =?utf-8?B?NUJuTFZtTEVDQUJqaUFCa3lWejl2UXVUTDc3ZmFSbHA2MWxnZ29WdGpIU05W?=
 =?utf-8?B?eUVmN2hBT0dUS3VNUVplQ2xRSFRWTXRBM0hsWlZ3VnBwQnhhS3BPNW1ET3JN?=
 =?utf-8?B?V3ljczMyaFRsSEgrVzltUzZCRmIrQzFxZVluV1lVZXA1WUFuMVQ2bExvNHVy?=
 =?utf-8?B?aFRFSyszYkJaNzc3elp0M1dMUTBhSk5vSmFKTWdXeFN2MitPNGtmOEw1dDRm?=
 =?utf-8?B?MDdmcmJZOUpOSy9BUlVkazB6S3NhaW02WmJmRm14Q0cwY3Uzdm8zK1FpOFVF?=
 =?utf-8?B?akY1U25tRjhUZ1hrbTVvVU00NkU0c0NialBOUkNxeFdCSUM3RFNHOE9pTUlr?=
 =?utf-8?B?cTUvNGhMNnhHdjk3YVdVNVhESHlqeFBxZUkzbUtiaitGN0cvSUczdnhjcFVh?=
 =?utf-8?B?a2VyYXdwSGk2NHEvWGJBR04vT21LbUdZWkprRzd1VWVWaWZWREhXeW9DUm96?=
 =?utf-8?B?ZHRDc0pvemJaZHRUaGJFQ2dPcDNJbzFPdFI3cklCQnptaEUwMkRrY1N5akYz?=
 =?utf-8?B?V0JzaU8vbnNVNklEL2xzS2J0cHkxN21ydlFOVmlLcTNvU0MxSVA2MjB3WU5t?=
 =?utf-8?B?K1ZMZDM0NVRmMVhuNEF0Q1FIZERuUjQxQlJ0VnlnNVVyaENzOTEzTU9DbWxl?=
 =?utf-8?B?eXJ6QlZKRS9rRWNFMHBEMU13SDJEUHphUkN6cmdNSHFFaUxxMDBYQkZxbjNz?=
 =?utf-8?B?Tll3WkFRcHdYclphTE44bC9iWERsZHpMUHYzT01wRkxiQXpnN1dua1dnWlJT?=
 =?utf-8?B?MHBNRmU0bVZNaXhDdU5HcUhlR1RZdmNoaWFOWmJWMTA0dmhHUU1JMkg3ZUlK?=
 =?utf-8?B?MkZmazY4RTJXU0NjczBhSlcvQW9NYklvSGJsRWdFVTVBSFUybkt6enhrVDRs?=
 =?utf-8?B?L1d3V3RaTzFEWmFNZjFjM3o2blFMNWFSenB1NzM5TWlJKzM4QUR2cW14d1B3?=
 =?utf-8?B?MGRrY3dBV0MzVnd5aHk3dUdEMzlzbjBxWlhOdlNta0NUUXVHYnZnbHRmb0xn?=
 =?utf-8?B?VkJKN2FsYXpwQlR6NEJnY2JuL2srb3YvaHFySHVqTmI0SUgrWTR0QzFtQzNP?=
 =?utf-8?B?Z3lna0E5Y3FwNnErZ1d1K000Rk5DZklCTzlWSFdLM2ZMN3IzTDVKaENkSHUy?=
 =?utf-8?B?M3J0bXBUSHdndzE1Szk5ampWNWdMclIzODZVVjkrYzQwK0M3RWQ5VCs2NElG?=
 =?utf-8?B?TFJseU9ST1Zha0hzTjJ6QkYwVWpxMGtBZWtFbG9ZUmRuUXRRNkhjU0ZmUjh2?=
 =?utf-8?B?U0wzc3U5NEtzNWhFSUg4ZDNzbUxvdzRhUmxDMW5FUmhyWTVwQTRWdjhrY3Nj?=
 =?utf-8?B?clpDZU5oQlc0blo1aWlxZ3lrdFk2aVFyR0xoVlozelFqWFVEUEZsTytwOERR?=
 =?utf-8?B?Q2hnK1pTV0NUb21DNFVsN2hDbkdhdnN0Nm1INEtub1RqeXN1UTN0YytiNzdh?=
 =?utf-8?B?RjFNT3RMYkhCc0J1UDQrSkp3NWRQRUwvY2tYV1VPSnVKTVZMSkNKQ3dRRDhz?=
 =?utf-8?B?Z1BrK2l4NGxTNm1Ec2NqR1VrUkk1aWJDRnA5ei9WZjJoR1ZKN2tpV2IvR1NO?=
 =?utf-8?B?MGdCNTFIWjNMbzRTeWQvYXhuVytYMjEwUlRxUTB1MnVRL2dmcGtXREpQb3Z3?=
 =?utf-8?B?QW81QnhHVzZwekk2YUhVWllmRmZFT3N1QTc5aGVvTTFRWWh0b0VTT2FaMktm?=
 =?utf-8?B?NUdYWmpXdERvTW5iT0Vra3FKMDdpUmkrSUFKVERPaG9jWkl5V21jQ3FNcEZE?=
 =?utf-8?B?ZVRsKzVMWjhxeGpBeDNPZGQrTGNhUW9ocFN3T3lxTnEvbVFxS2JkRnJOUW1m?=
 =?utf-8?B?b3F0WmNLK2RGaW8yRU1yNzBkT1FaTzN6L1NHRTNYTEZ1aC95bnU4SjR0dHJQ?=
 =?utf-8?B?cWpzdGJxb3FLZ2tiT0g5Nkh3SkY3R1BiOUJWU0JGR2tnRzIyOFNIWFpWbUYv?=
 =?utf-8?B?R2ZZN0JEWXZBcSt1dkRlbjFGejkzeUE1OURvSEhHemt2TWJVQnVFdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8EF106E8D4DBB4B8135FD06BC7F49EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mPmzzx7gpDzphKj2rXaqMk5HkuxC/F1rgZd5Sdr11JhG5Trrj/AAsEjIsvbd1y9+jexQ1+yhzxWjjBSne4CB2e8vJ6wNTmF1GjUk6/DaV7MK5L6/4631nYx6fT+m7TrKjCKT3hM2ap2sZsl7iVgqLvpTK0xYUP/760I1vi6a8H/nHPDLJJ8lmxPBaCL7OORfOyTQlr4jumgN6Y9+yuf4VMtbxaLQH3drYb6zjtkqsZmsRTW70wQvepVPGgB9P091iUvXkL9NXd8A7kgKbS9UvBFKBy4YqqkrqEmedsbOHsra5LTRT1hPuidSyqMeIa21V5u7yc2kTyuPY0lBgVAajw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e033512b-52f3-437c-26d5-08de8f0a861e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 09:47:29.5259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pw/fXAzA58RuLhTAgipvkXl0lH0ll3VLgA24DhWzgow8tXrd710EWBgBu7llY8tVPRV1gEZg0CfiCNdqnh+/SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7034
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDEzOjE0IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gRnJvbTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KPiBQ
YXNzIGEgcG9pbnRlciB0byBpdGVyLT5vbGRfc3B0ZSwgbm90IHNpbXBseSBpdHMgdmFsdWUsIHdo
ZW4gc2V0dGluZyBhbg0KPiBleHRlcm5hbCBTUFRFIGluIF9fdGRwX21tdV9zZXRfc3B0ZV9hdG9t
aWMoKSwgc28gdGhhdCB0aGUgaXRlcmF0b3IncyB2YWx1ZQ0KPiB3aWxsIGJlIHVwZGF0ZWQgaWYg
dGhlIGNtcHhjaGc2NCB0byBmcmVlemUgdGhlIG1pcnJvciBTUFRFIGZhaWxzLiAgVGhlIGJ1Zw0K
PiBpcyBjdXJyZW50bHkgYmVuaWduIGFzIFREWCBpcyBtdXR1YWx5IGV4Y2x1c2l2ZSB3aXRoIGFs
bCBwYXRocyB0aGF0IGRvDQo+ICJsb2NhbCIgcmV0cnkiLCBlLmcuIGNsZWFyX2RpcnR5X2dmbl9y
YW5nZSgpIGFuZCB3cnByb3RfZ2ZuX3JhbmdlKCkuDQo+IA0KPiBGaXhlczogNzdhYzcwNzllNjZk
ICgiS1ZNOiB4ODYvdGRwX21tdTogUHJvcGFnYXRlIGJ1aWxkaW5nIG1pcnJvciBwYWdlIHRhYmxl
cyIpDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBp
bnRlbC5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYva3ZtL21tdS90ZHBfbW11LmMgfCAxMCArKysr
Ky0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9tbXUvdGRwX21tdS5jIGIvYXJjaC94
ODYva3ZtL21tdS90ZHBfbW11LmMNCj4gaW5kZXggN2IxMTAyZDI2ZjljLi5kYmFlYjgwZjJiNjQg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2bS9tbXUvdGRwX21tdS5jDQo+ICsrKyBiL2FyY2gv
eDg2L2t2bS9tbXUvdGRwX21tdS5jDQo+IEBAIC01MDksMTAgKzUwOSwxMCBAQCBzdGF0aWMgdm9p
ZCAqZ2V0X2V4dGVybmFsX3NwdChnZm5fdCBnZm4sIHU2NCBuZXdfc3B0ZSwgaW50IGxldmVsKQ0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IF9fbXVzdF9jaGVjayBzZXRfZXh0ZXJuYWxfc3B0ZV9w
cmVzZW50KHN0cnVjdCBrdm0gKmt2bSwgdGRwX3B0ZXBfdCBzcHRlcCwNCj4gLQkJCQkJCSBnZm5f
dCBnZm4sIHU2NCBvbGRfc3B0ZSwNCj4gKwkJCQkJCSBnZm5fdCBnZm4sIHU2NCAqb2xkX3NwdGUs
DQo+ICAJCQkJCQkgdTY0IG5ld19zcHRlLCBpbnQgbGV2ZWwpDQo+ICB7DQo+IC0JYm9vbCB3YXNf
cHJlc2VudCA9IGlzX3NoYWRvd19wcmVzZW50X3B0ZShvbGRfc3B0ZSk7DQo+ICsJYm9vbCB3YXNf
cHJlc2VudCA9IGlzX3NoYWRvd19wcmVzZW50X3B0ZSgqb2xkX3NwdGUpOw0KPiAgCWJvb2wgaXNf
cHJlc2VudCA9IGlzX3NoYWRvd19wcmVzZW50X3B0ZShuZXdfc3B0ZSk7DQo+ICAJYm9vbCBpc19s
ZWFmID0gaXNfcHJlc2VudCAmJiBpc19sYXN0X3NwdGUobmV3X3NwdGUsIGxldmVsKTsNCj4gIAlp
bnQgcmV0ID0gMDsNCj4gQEAgLTUyNSw3ICs1MjUsNyBAQCBzdGF0aWMgaW50IF9fbXVzdF9jaGVj
ayBzZXRfZXh0ZXJuYWxfc3B0ZV9wcmVzZW50KHN0cnVjdCBrdm0gKmt2bSwgdGRwX3B0ZXBfdCBz
cA0KPiAgCSAqIHBhZ2UgdGFibGUgaGFzIGJlZW4gbW9kaWZpZWQuIFVzZSBGUk9aRU5fU1BURSBz
aW1pbGFyIHRvDQo+ICAJICogdGhlIHphcHBpbmcgY2FzZS4NCj4gIAkgKi8NCj4gLQlpZiAoIXRy
eV9jbXB4Y2hnNjQocmN1X2RlcmVmZXJlbmNlKHNwdGVwKSwgJm9sZF9zcHRlLCBGUk9aRU5fU1BU
RSkpDQo+ICsJaWYgKCF0cnlfY21weGNoZzY0KHJjdV9kZXJlZmVyZW5jZShzcHRlcCksIG9sZF9z
cHRlLCBGUk9aRU5fU1BURSkpDQo+ICAJCXJldHVybiAtRUJVU1k7DQo+ICANCj4gIAkvKg0KPiBA
QCAtNTQxLDcgKzU0MSw3IEBAIHN0YXRpYyBpbnQgX19tdXN0X2NoZWNrIHNldF9leHRlcm5hbF9z
cHRlX3ByZXNlbnQoc3RydWN0IGt2bSAqa3ZtLCB0ZHBfcHRlcF90IHNwDQo+ICAJCXJldCA9IGt2
bV94ODZfY2FsbChsaW5rX2V4dGVybmFsX3NwdCkoa3ZtLCBnZm4sIGxldmVsLCBleHRlcm5hbF9z
cHQpOw0KPiAgCX0NCj4gIAlpZiAocmV0KQ0KPiAtCQlfX2t2bV90ZHBfbW11X3dyaXRlX3NwdGUo
c3B0ZXAsIG9sZF9zcHRlKTsNCj4gKwkJX19rdm1fdGRwX21tdV93cml0ZV9zcHRlKHNwdGVwLCAq
b2xkX3NwdGUpOw0KPiAgCWVsc2UNCj4gIAkJX19rdm1fdGRwX21tdV93cml0ZV9zcHRlKHNwdGVw
LCBuZXdfc3B0ZSk7DQo+ICAJcmV0dXJuIHJldDsNCj4gQEAgLTY3MCw3ICs2NzAsNyBAQCBzdGF0
aWMgaW5saW5lIGludCBfX211c3RfY2hlY2sgX190ZHBfbW11X3NldF9zcHRlX2F0b21pYyhzdHJ1
Y3Qga3ZtICprdm0sDQo+ICAJCQlyZXR1cm4gLUVCVVNZOw0KPiAgDQo+ICAJCXJldCA9IHNldF9l
eHRlcm5hbF9zcHRlX3ByZXNlbnQoa3ZtLCBpdGVyLT5zcHRlcCwgaXRlci0+Z2ZuLA0KPiAtCQkJ
CQkJaXRlci0+b2xkX3NwdGUsIG5ld19zcHRlLCBpdGVyLT5sZXZlbCk7DQo+ICsJCQkJCQkmaXRl
ci0+b2xkX3NwdGUsIG5ld19zcHRlLCBpdGVyLT5sZXZlbCk7DQo+ICAJCWlmIChyZXQpDQo+ICAJ
CQlyZXR1cm4gcmV0Ow0KPiAgCX0gZWxzZSB7DQoNClRoZSBfX3RkcF9tbXVfc2V0X3NwdGVfYXRv
bWljKCkgaGFzIGEgV0FSTigpIGF0IHRoZSBiZWdpbm5pbmcgdG8gY2hlY2sgdGhlDQppdGVyLT5v
bGRfc3B0ZSBpc24ndCBhIGZyb3plbiBTUFRFOg0KDQogICAgICAgIFdBUk5fT05fT05DRShpdGVy
LT55aWVsZGVkIHx8IGlzX2Zyb3plbl9zcHRlKGl0ZXItPm9sZF9zcHRlKSk7DQoNClRoaW5raW5n
IG1vcmUsIEkgX3RoaW5rXyB0aGlzIHBhdGNoIGNvdWxkIHBvdGVudGlhbGx5IHRyaWdnZXIgdGhp
cyBXQVJOSU5HDQpkdWUgdG8gbm93IHNldF9leHRlcm5hbF9zcHRlX3ByZXNlbnQoKSB3aWxsIHNl
dCBpdGVyLT5vbGRfc3B0ZSB0bw0KRlJPWkVOX1NQVEUgd2hlbiB0cnlfY21weGNoZzY0KCkgZmFp
bHMuDQoNCkNvbnNpZGVyIHRoZXJlIGFyZSAzIHZDUFVzIHRyeWluZyB0byBhY2NlcHQgdGhlIHNh
bWUgR0ZOLCBhbmQgdGhleSBhbGwgcmVhY2gNCl9fdGRwX21tdV9zZXRfc3B0ZV9hdG9taWMoKSBz
aW11bHRhbmVvdXNseS4gIEFzc3VtaW5nIHZDUFUxIGRvZXMgdGhlwqANCg0KCWlmICghdHJ5X2Nt
cHhjaGc2NChyY3VfZGVyZWZlcmVuY2Uoc3B0ZXApLCBvbGRfc3B0ZSwgRlJPWkVOX1NQVEUpKQ0K
IAkJcmV0dXJuIC1FQlVTWTsNCg0KLi4gc3VjY2Vzc2Z1bGx5IGluIHNldF9leHRlcm5hbF9zcHRl
X3ByZXNlbnQoKSwgdGhlbiB2Q1BVMiB3aWxsIGZhaWwgb24gdGhlDQp0cnlfY21weGNoZzY0KCks
IGJ1dCB0aGlzIHdpbGwgY2F1c2UgaXRlci0+b2xkX3NwdGUgdG8gYmUgdXBkYXRlZCB0bw0KRlJP
WkVOX1NQVEUuDQoNClRoZW4gd2hlbiB2Q1BVMyBlbnRlcnMgX190ZHBfbW11X3NldF9zcHRlX2F0
b21pYygpLCBBRkFJQ1QgdGhlIFdBUk5JTkcgd2lsbA0KYmUgdHJpZ2dlcmVkIGR1ZSB0byBpc19m
cm96ZW5fc3B0ZShpdGVyLT5vbGRfc3B0ZSkgd2lsbCBub3cgcmV0dXJuIHRydWUuDQoNCk9yIGRp
ZCBJIG1pc3MgYW55dGhpbmc/DQoNCkFsc28sIEFGQUlDVCB0aGlzIGlzc3VlIGRvZXNuJ3QgZXhp
c3QgZm9yIG5vbi1URFggY2FzZSBiZWNhdXNlIHRoZXJlJ3Mgbm8NCmNhc2UgdGRwX21tdV9zZXRf
c3B0ZV9hdG9taWMoKSBpcyBjYWxsZWQgdG8gc2V0IG5ld19zcHRlIGFzIEZST1pFTl9TUFRFIGlu
DQpzdWNoIGNhc2UuDQo=
