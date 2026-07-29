Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A748D87C;
	Wed, 29 Jul 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332946; cv=fail; b=aHJ/qmWXf6j0f19Zc95fWG1A/+w+qv8G8cwtxTjaSEjHgqq7N4PEt/sZPi4YebgBlV7/3sxvaIr0urrjcXuuaiml2epLyFKU3qUfMSm3Bu265rCe8YvkUSluqxRwtGJYPgw+JCxoherxsGJieM1QPG37I7TbLLXvakUuV9FT5ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332946; c=relaxed/simple;
	bh=8B+R4LRoA6t8fJRrop/jxXG2LJc1lMGw+B1B6m7ltYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iuYB+CWwwqfFa/RqHVWcmtXbm8jznguVl9A+AI33MzsuDT71nEV5+pbBzBgwPN/Tcs4kpGSpXGJ91DtOSPalpXHH/Fk4sNeQ5c+ahVsfE77m3t20maQL+tx2nfhO1Io40a77XDpY2xawvmKr5NjRi+b7XzYAHuJ088awhSB9//w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+rS3aeG; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+rS3aeG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785332940; x=1816868940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8B+R4LRoA6t8fJRrop/jxXG2LJc1lMGw+B1B6m7ltYc=;
  b=L+rS3aeGgWN8preS5LdczeyXJuWB9OsAXLxKu6dIc+eR+7IASbBTJ1eJ
   6J9pJFULJ8UCV5yLHYV0ZjKtFPRqXfo27IVzgnTLCn9C7Ub66dgQmqZvA
   gH2EE80MP+uHiYbKYQdht+jnS93kd1yLifNp9sBuQ/+t/LZRN9lxWfwN+
   WtkLIKGq9BiBBF/RNbpITtl5Bohbr5v0H6ZlT69jpjlZmh5McBmDVyBS+
   jNi9aYdgAv2mDOQFMSv1W2pcZH+gJSjeAHoz9L33nj0uvrfUPh98K8QwJ
   qXAkFyguJFPOaBP5Sbi7gkFwl2bZg/k1W2n03MEkOdjm2tcs3UmSFLN9L
   g==;
X-CSE-ConnectionGUID: EAJiT3HDTeeiK5Uw8u4abQ==
X-CSE-MsgGUID: CCBRv1CWQ2iPhL0RXPQonQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85976055"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="85976055"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 06:48:48 -0700
X-CSE-ConnectionGUID: s4ep0m4lRLa3u4PMvusvIg==
X-CSE-MsgGUID: 9lxZ73xTScqyXJgxqK/86Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="256680845"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 06:48:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 06:48:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 06:48:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 06:48:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyYjkOW08FpiazzoZQ8ajPCafeNYYTKlcK3+dJIjla+Cyw1o8VS4Fd1Zy/7kZor7dO8XxwqMQk9/ypcHGQQHpbr9azWx80WX68SdSKOrmmQr5crVLg8NSO9MahmZvATdH7miLU8wM6mFrFrLVmp22c2TZRtGp9m8kwvicbqppQmdbVeGtaMGIHPrHBRywtFx+OcPklKKypiLHm6sBMl2i7j96/ZJFNZtgHXITKQK8IOQijD4uK1R4RUBHxWElaPuMrIn263ZBv5YgHA71S7Zn6BN5o1RXfVcBApdLe3YUl7wqRDjIDodFmo9IUnCr6gm1/ltVZEeR6VfhgFZE1UrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B+R4LRoA6t8fJRrop/jxXG2LJc1lMGw+B1B6m7ltYc=;
 b=w2CnAsKwVmVWrZ4jRKl4xNtbA68w24qZhs/c0vALM+36XsQ8EoS/ur6w2VeWhb6EZmrJAZCpvL40534C4CjQpI+5BXqUFfscaBmQttKEOPTL/4d7gghxzhNzb2dZ+zk+h4qSsffDlLkX7jqZvmJWZNdiBtvOysocZLH2rP3zEYzuazxOreqNXTd7vuk6XKdpMsfzQ5dMuZEAwiYenP37o6aluRI1aCOH3m1O9Li3RoXQ30HyCiqlW1s5YlgIL4vl1DT682O2vIDgHGsrvNKc/pNnI0lVUh4AYKKk5xtqob7uuTyaiifbMgTYJuKXD72dhC36SWgdpOJtzW6YRZVKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB6926.namprd11.prod.outlook.com (2603:10b6:510:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 13:48:43 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 13:48:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Fang, Peter" <peter.fang@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "djbw@kernel.org" <djbw@kernel.org>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Topic: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Index: AQHc/v34tfo3elz6N0uAdpZoN5jBM7Z8ksGAgAT5AYCAAFmtAIACN0iAgACoJoA=
Date: Wed, 29 Jul 2026 13:48:43 +0000
Message-ID: <ce4c800ccce210e65aaf8432c0413a342f1765c9.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
	 <cfeee0fe-c61d-447c-86bc-8d8244090879@intel.com>
	 <amdRWaoKa0k324JM@yilunxu-OptiPlex-7050>
	 <7611fe250925614d64f05cac8d398f54ee386583.camel@intel.com>
	 <aml4cVnFkKvmJimj@yilunxu-OptiPlex-7050>
In-Reply-To: <aml4cVnFkKvmJimj@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB6926:EE_
x-ms-office365-filtering-correlation-id: ac7bf9ae-ac60-4fe8-73e1-08deed781ae2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|38070700021|3023799007|4143699003|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: bXzsRwJzTuupE3JPa+MFEiCPgBhbCRflxPvr+wgrB6suW5zX2Fw5oxkluyxlSuISwrXAddZpqW/n0SO32NqporJGm8vfmWKKdf0kUnajIXzsDQBAz2MGDW3XjWjZJsxznbKQoZxKKDxdnqQjZ5gEf2m8/4ExsIUL1I7581fBgJI+Fc26qMoGsX/FOW79KUlad6S3r36YBBB/KItuZgkbYK/UfzJU/elFcVg99bQ4EsDrFS2m8u19RekOkhFsuGibQMu6fAEGZheJljkNmUZyyFRlWC4VaNWr+EKVn3r3NQ72GFCEeKR5gpg0toQH0lrt7ikpBdDDGdb5VnKkjId17sfJPshcd7mPEFr3vlvPiHmKT+rlpicnkEe89KfCsTTfsFeyS42QE7eAKaUf8/Wx7LMbNdnobZmBTb5ReI5QLJzUvObUjVDzKrqdK+P+A74IoNGdtuESN4lIuBXNasYmGjUHboGW1iQglf/+dCcYEyOQyHpuwroN6RJbx6peBRgdAYXyhr9QMTAqwTCx6c68h5ywycBvZIwLz2wrLWArH4EObQXuf4iNdA4jepWlFeSlDq3EemI618URih4568Ng8R5nCMVDYYxfg4JjAtPo+PF7ZqDgtrwaFURe7IMN1AHvo4yBqNF5kG6vb01nkgG4r7wPX14wfHnjuQ69i40hPD5DXQSQHGbRUpcAy6a8yfRYI5xy+DkvFjlAEUw5aF4jaWLBOsfIBvYEgKFgkYk2ezw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(3023799007)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTNaYWo4a08rZjBoWXlCOG03bUxiaVNCRnZuR012Zmprdnl5Z3h3NDR6OHhI?=
 =?utf-8?B?aWVRNnh0MkpETkVxVEEreDkrMisyREljK1MrRTRIa2tmTUl2VGQyV05SUGNI?=
 =?utf-8?B?WklZOVZUeC90NTJIWUkwRUZ4a1pTU1AyQ2dsUG1Va3hLTUkxV2RFUngwVHV5?=
 =?utf-8?B?a29ySnJFSjRkdzhNOWxyVUcwYkRHREx2UkxseWprVWpGUmNRQWlTSFEzY0Ja?=
 =?utf-8?B?dVoyczZ1aFozWVdzT2dKaUdZZUdSTVIzWkFaSkRvbWJaZFZ6UDdiRWFUQ3BH?=
 =?utf-8?B?b0lCUFlGN2dVaURqSFJYdVJzTVIxM0UrUURIajRLVitSYTVGQ2RwNXVzS1Rw?=
 =?utf-8?B?MFpnNjYxK1kzWmhna3Y0ODVHdVZ3bDJ5dWhHb0ZtSi9RcVJJaS84T3VQeTNN?=
 =?utf-8?B?ZnVEMSswTHRjZk9OckpkZFhuOGlrSGg3b2Nmc1ZoaW1GZlYwRzZVdlhZc0hM?=
 =?utf-8?B?aWpqbFJidGtTNTB6YmJFUmdQQnJkbjRQYkFjempQYmNLZ08wK2UvWGtqVmlv?=
 =?utf-8?B?Qmh4NHVsTjhlY0RNbjc4R2ErSVhROTN2VkZvbC9VNlZWa043U3A1RC9vRWYx?=
 =?utf-8?B?YzdnUnVpeVFnTWYyWG1QWnlaelpKUnFWRlo4YnFodElNR2oyTXNrY1BUZkJI?=
 =?utf-8?B?NjExRVBVRzRHQUlDbk5ENndjLzVUeXIzc3d5MDdQN1Y2eWtkT2k5SlNJRGx2?=
 =?utf-8?B?NTZFdW5FWm02SEIvc2ErME14MTh3NWpjeVVsWm91dVVES0hWeXNCWWc1UFhY?=
 =?utf-8?B?MVg0YlBwM1VYcWJ4VTBzTS9KT0lhY0RIMU5uak0zbWhHWHd2djNhMkFxbGt0?=
 =?utf-8?B?aXQ4QlFhN3JQMGpWcTE3YVBxTjJSMThpQWNQNmdKUmxScldKUWU0QU1UUUdH?=
 =?utf-8?B?eUhFL09TbE9xWDdxbU5tWWM3ck9Cc21zejZCMlBlQktWUkg3dHU3OU1nbW9m?=
 =?utf-8?B?a2tFOWQ4bFdGbjA2UVN0YWVycGpmM0VoWGVhQlo1bi9UcW1zeUtXbmc1bVVR?=
 =?utf-8?B?L093eVZFWnljaUVUZ3RuODBWS0dtSXBLcjdGOUdtU1FIV3RKZGVNNWcyOWNE?=
 =?utf-8?B?eHNIQXQxejhSMTFJUkl5cndvZnAvN1ZtbEJ1WUsyV2JHeEx1QVRvaFlEMEhO?=
 =?utf-8?B?RjJ6ditCUkhoc1owOVN3RTVGL2hLOFFDeDVIejk2VTV1RUYzbG12eWMxY08z?=
 =?utf-8?B?SENFdHBHTDliYUJWRWx1NUZOSkI5VmlrOVlxUnduYmxpZWtFZDZkNHp1WHYx?=
 =?utf-8?B?ZkhPSTEzYU0wM3pIWnduTTJxL2k3TEE1eXhVZG1nS0o3OWFFQjFrN2dkbWY4?=
 =?utf-8?B?NGdyRENMYUZwcXErNXlwZHBCTTl5M0MreGRqTktrT3FJcmZsZmpRL2VXVEpy?=
 =?utf-8?B?MnRseG5veENMS1pBdXJEOEpNMC9SSWhyYUtYV1RVMko5cHVha3NENWFWZ2xp?=
 =?utf-8?B?b2Q2R2pvWTh5Q2o0SHc2MklqK3dLdXB1SjhaREg3cmJmdURxMFIzaFBObyty?=
 =?utf-8?B?YkxFVXhZL2RkRVM2eThPZENRY3RDbGxRNEt5SEc0MERIOC9RRmNNbFBnNmZ6?=
 =?utf-8?B?dEJSS1l0Z2VXdlBjQ1p5czQ5MThMQStOL2k5ZDVpZGpMNSt5V3I2L1hBZkJp?=
 =?utf-8?B?MUNiV1RpaTlQVXBRZGpWRjlpZm1yclAwdEpmcVBRN1dEeFBPZVR4YzlmWm85?=
 =?utf-8?B?a0t1UDQ5VUlhQ3NQM2RGdWtsYVFFVkZ0aHFvY1Jtd1E0WlVQQlB0QkFvWXJ5?=
 =?utf-8?B?VEVFYjJLeUdsNXhLUUtQM001WlU3blJ3YVJ0UWprZk9YZGoyaFk0QXlMMlla?=
 =?utf-8?B?a2pyNys1R1J6TXhxM0l6cXV2TDhkS3lwRTg2SktBdDlUZUJ4dnhRODk1alRl?=
 =?utf-8?B?TEZlVFdiSW1xRGYvNmhXS1cvRG8zODFtTUsySWZVMlA3Ulh1L3B5UFpLN05P?=
 =?utf-8?B?M1JyaWxTMmxDSEw1SU9nWGNsa1pVK3A3aVJYNzFKQ21IcmJHZ21XYWpTczY1?=
 =?utf-8?B?YnVkU05SWkxSbGYrd1E2MTk0S1VCU3kwM1FFRm1YR1VMT2JTM3o1elFTSFhV?=
 =?utf-8?B?Nkx1ZDJmQklNeXhsbk1hZjlyUUV3bVI5aGZXNllBMkZqMHl0RmdvM2Z1T2w5?=
 =?utf-8?B?dEJRV3hQelB1T3ppUUpoL1ZDVHkrSjREN0x6NklPaXZUOHRicmdCTXhGQ1VC?=
 =?utf-8?B?YTkzaStXVHcyTTE3T2F0WFg5N051QWFJbU8weFY3cVZub2IyejFHbk11WTJ2?=
 =?utf-8?B?dW1QUW9JTm1LcDhnYldSYTlGV3loczE1T0Q0YS9CR24yVkh3UDA2NmYxc3du?=
 =?utf-8?B?MlFVaDI1U2FxREZCQjY2Nnp6RmMwTmc3aExDUU5RZ01EdWpjVmh2b0hma3Mx?=
 =?utf-8?Q?09BuZK2aEKD1JMZw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05F6850BFBFC2643A504742668EE8A71@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U4xoK2SkhMW/5hFA3UF/1Tn3QnkplnXc0ia0RturS4HEV6z9AT+zoU6lymzxUnEhd3YnyNyh65XzqC1wTA6B6FuOmgzPuLGHwXMbYCo60vuu/jBW1ox4DhyDMtVhw2XZp50A3I+lN1XWQzYvouffyLrqNLd0320wWgQIBQM7yg9T1ffBXtFq+p11mKOrJT4+AJw8eJw0NbYqnLWGchUuSKX/rKo+h/VXTb4qmgLaNTrf8YkDCqK+4R/FKLaQi/YY48ZeL65DGS9kHBaGI1S20k9b88jrpHpvv34nxP+aaAD0+BmEVhIhPbr1jIwvgMh987lmAInn9H0YdXGcwnRgsg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7bf9ae-ac60-4fe8-73e1-08deed781ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 13:48:43.5967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6tRf+yro581YbgIOnsX4+abf7hhYe3nJj/wKCZg9TZI/kOafoNE3dHvGa3bCrijgI6SSHWdBOw4Me/NvFJNHEgsC2mHxfpxPeNilHuNkxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6926
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDExOjUwICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
TW9uLCBKdWwgMjcsIDIwMjYgYXQgMDU6NTY6MzFQTSArMDAwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gTW9uLCAyMDI2LTA3LTI3IGF0IDIwOjM4ICswODAwLCBYdSBZaWx1biB3
cm90ZToNCj4gPiA+ID4gVGhpcyBpcyBub3QgdHJ1ZS4gVGhlcmUgYXJlIHNvbWUgbm9ybWFsIChu
b24tZXh0ZW5zaW9uKSBTRUFNQ0FMTHMgYWxzbw0KPiA+ID4gPiBhcmUNCj4gPiA+ID4gcHJlZW1w
dGlibGUgYW5kIHJlc3VtYWJsZS4gRm9yIGV4YW1wbGUsDQo+ID4gPiA+IA0KPiA+ID4gPiAtIFRE
SC5QSFlNRU0uQ0FDSEUuV0INCj4gPiA+ID4gLSBUREguU1lTLkRJU0FCTEUNCj4gPiA+ID4gLSBU
REguTUVNLlNFUFQuQUREIHdpdGggdmVyc2lvbiAxDQo+ID4gPiANCj4gPiA+IE5vIHRoZXkgYXJl
IG5vdCBwcmVlbXB0aWJsZSBhbmQgcmVzdW1hYmxlLiBUaGV5IGp1c3QgaW50ZW50aW9uYWxseQ0K
PiA+ID4geWllbGQgYW5kIGRvbid0IGhhdmUgYSBnZW5lcmljIHdheSB0byBzYXZlL3Jlc3VtZSB0
aGVpciBjb250ZXh0LiBZb3UNCj4gPiA+IGNhbid0IHJlbHkgb24gdGhhdCB0byBpbXBsZW1lbnQg
Y29tcGxleCB0YXNrcyBpbiBURFggbW9kdWxlIGNvbnNpZGVyaW5nDQo+ID4gPiB0aGUgY29tcGxl
eGl0eS4gVGhhdCdzIHRoZSBtYWluIHJlYXNvbiB3aHkgVERYIG1vZHVsZSBleHRlbnNpb25zIGFy
ZQ0KPiA+ID4gbmVlZGVkLg0KPiA+IA0KPiA+IFdlIGhhdmUgUkVTVU1BQkxFIHNlYW1jYWxscyB0
b2RheS4gVGhleSBhcmUgZ3VhcmFudGVlZCB0byBzYXZlIHN0YXRlIGFuZA0KPiA+IG1ha2UNCj4g
PiBmb3J3YXJkIHByb2dyZXNzLiBYaWFveWFvIGlzIHJpZ2h0LCB0aGlzIGlzIG5vdCBhIG5ldyBj
b25jZXB0IGZyb20gdGhlIFZNTQ0KPiA+IHNpZGUuDQo+IA0KPiBPSy4gTGV0IG1lIGRlLWVtcGhh
c2l6ZSByZXN1bWFibGUuDQo+IA0KPiBBbmQgSSdtIHRoaW5raW5nIG9mIGhvdyB0byBzdG9wIGV4
cGxhaW5pbmcgbmV3IHRlcm1zIGFnYWluIGFuZCBhZ2FpbiwNCj4gZXh0ZW5zaW9uIFNFQU1DQUxM
IGlzIHRoZSBvbmUuIEknbSBub3Qgc3VyZSBpZiBjYWxsaW5nIGl0ICJwcmVlbXB0aWJsZQ0KPiBT
RUFNQ0FMTHMiIGhlbHBzLCBvciBpcyBpdCBzdGlsbCBhIG5ldyB0ZXJtPw0KPiANCj4gPiBCdXQg
YWxzbyB3aHkgaGlnaGxpZ2h0IHRoaXMgZm9yIHRoZSBwYXRjaCBoZXJlLiBBcmUgeW91IHRyeWlu
ZyB0byBleHBsYWluDQo+ID4gd2h5DQo+ID4gZXh0ZW5zaW9uIGluaXRpYWxpemF0aW9uIG5lZWRz
IHNvbWUgc3BlY2lhbCBzdGVwPw0KPiANCj4gSSB3YXMgZm9sbG93aW5nIHRoZSBzdWdnZXN0aW9u
IFsxXSBvZiBleHBsYWluaW5nIHRoZSBjb250ZXh0IGluIGdlbmVyYWwuDQo+IEJ1dCB5ZXMsIGEg
YnJpZWYgZXhwbGFpbmF0aW9uIG9mIHdoeSB3ZSBuZWVkIHNwZWNpYWwgaW5pdGlhbGl6YXRpb24g
aXMNCj4gZ29vZCB0byBtZTogQSBnbG9iYWwgc2VydmljZSBlbnZpcm9ubWVudCBzaG91bGQgYmUg
YnVpbHQgdG8gcHJvdmlkZQ0KPiBzb21lIGdlbmVyYWwgY29udGV4dCBzd2l0Y2hpbmcgbWVjaGFu
aXNtIGluc2lkZSBURFggbW9kdWxlLg0KDQpXYWl0IGFyZSBhbGwgZXh0ZW5zaW9uIHNlYW1jYWxs
cyByZXN1bWFibGU/IENvdWxkbid0IHRoZXJlIGJlIG9uZSBhc3NvY2lhdGVkDQp3aXRoIGFuIGV4
dGVuc2lvbiB0aGF0IGlzIG5vdD8gV2UgaGF2ZSBzbyBmYXIgZXhwbGFpbmVkIGV4dGVuc2lvbnMg
aW4gdGVybXMgb2YNCnRoZSBURFggbW9kdWxlIG5lZWRpbmcgbW9yZSBtZW1vcnkgZm9yIHRoZSBv
cHRpb25hbCBmZWF0dXJlcy4gU28gImV4dGVuc2lvbiINCnByb2JhYmx5IGJlIGludGVycHJldGVk
IGFzICJvcHRpb25hbCIsIG5vdCBhcyBlbmFibGluZyAicHJlZW1wdGlibGUiIHNlYW1jYWxscy4N
Cg0KPiANCj4gWzFdOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMTc4M2U3YmQtMzc1
OS00MWY3LTkzZTMtMmY5ZTIxMjY0YmQ0QGludGVsLmNvbS8NCj4gDQo+IFJlZmFjdG9yZWQgdGhl
IGZpcnN0IHBhcmFncmFwaDoNCj4gDQo+IC0tLS04PC0tLS0NCj4gDQo+IMKgIFREWCBhZGRzIGEg
bmV3IGNsYXNzIG9mIFNFQU1DQUxMcyB3aGljaCBhcmUgcHJlZW1wdGlibGUgYW5kIGNhbiBjb29w
ZXJhdGUNCj4gwqAgd2l0aCB0aGUgaG9zdCBzY2hlZHVsaW5nLsKgDQoNCkJ1dCB0aGVzZSBhcmUg
bm90IG5ldyBpcyB0aGUgcG9pbnQuIExvb2sgZm9yIFREWF9JTlRFUlJVUFRFRF9SRVNVTUFCTEUg
aW4gTGludXgNCmFuZCBURFggc291cmNlLg0KDQo+IFNvbWUgZmVhdHVyZXMgbGlrZSBURElTUCwg
RElDRS1iYXNlZCBxdW90aW5nDQo+IMKgIHJlbHkgb24gdGhlc2UgcHJlZW1wdGlibGUgU0VBTUNB
TExzIHRvIGltcGxlbWVudCBoaWdoZXIgb3JkZXIgc2VjdXJpdHkNCj4gwqAgcHJvdG9jb2xzIHdp
dGggc2ltcGxlIEFCSXMuIFRvIGVuYWJsZSBwcmVlbXB0aWJsZSBTRUFNQ0FMTHMsIGEgZ2xvYmFs
DQo+IMKgIHNlcnZpY2UgZW52aXJvbm1lbnQsIGNhbGxlZCBURFggbW9kdWxlIGV4dGVuc2lvbnMs
IG11c3QgZmlyc3QgYmUNCj4gwqAgaW5pdGlhbGl6ZWQuDQoNCldoeSBhcmUgd2UgZXZlbiB0YWxr
aW5nIGFib3V0IHRoaXMgaW4gYSBwYXRjaCB0aGF0IHJlYWRzIHRoZSBtZXRhZGF0YS4gSXMgaXQN
Cm5lY2Vzc2FyeT8NCg0KPiANCj4gwqAgLi4uDQoNCg==
