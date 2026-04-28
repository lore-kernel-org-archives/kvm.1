Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123C33D4EC;
	Tue, 28 Apr 2026 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398363; cv=fail; b=FqB7Yu0+MDmSREfAaq3lUOwfkznKQnOMYbYuABzFO6H+nAhCys/QJld5x8eO+QwdmFctc7TUTl0jpcm+HJDEL4vxEkMpDdwoUqR7hgIM6U4mAwLvbB32CkpRIkHvNlBWe2qxjYejHFgyKe8Clwilfv4wNkcN5PpOUPTwH8h4EQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398363; c=relaxed/simple;
	bh=8NWv/fU3qaEzH6KPXhuvgqDJ8EgpdLzr0qZ+oUoSBo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tINDnxQs++G9XrDk6mOiScgknd95Eo4XC+2UAVJXg6VJH6HBleDIt7V+0HFZa6L0GiKTepdQ45wCjV8BUKF28OhO6yVRIaCfK2OJG51rIGp6VG7Fu0p1Z5QcPkHoiDgqo/tifa1KZWgi/h4IJoNPIVIZYsF4nY8XPwOb3Itl/Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4+24JCs; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4+24JCs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777398362; x=1808934362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8NWv/fU3qaEzH6KPXhuvgqDJ8EgpdLzr0qZ+oUoSBo0=;
  b=E4+24JCs571A/gOAMCCbBJ21X61m/G4dqvHMpurqLFL2EHDb196W+CQe
   3uTxp+QvgOpaVEOn32cdGaZVnLDRBKKZbSAdYwP97Wwb37wb+eE5ilxBD
   05OWqa6mP9KVHVBI/r6R2E9NmkFjBiLnr1lOfN75B12Flv8l/dSEA7nqn
   K+uQvgWUhR9pfG7loM2FzSwfA3qgXcTIz6hecCvsCpp+RKvs3hLeB1OJ6
   SxZtyNKgftdr4b0zIpNUVkVh0niLNOGYNYh0BhGymJnbpfcKB6fePg2gD
   eVseM2htldDFs2dadxW5uF3Vg4ydq02d1PvcfGIArxsAzn8l/EbVK6d5f
   Q==;
X-CSE-ConnectionGUID: 5jHFvc9ETTOd7/9lngqXRg==
X-CSE-MsgGUID: UjV55R1mSHOin4e7CE5ttA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78377640"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78377640"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 10:46:01 -0700
X-CSE-ConnectionGUID: PCjL8ID3Tx2P+9rbnMu/TA==
X-CSE-MsgGUID: qvmxvyqFS4+8RzUG4M9MMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="238352509"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 10:46:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 10:46:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 10:46:00 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 10:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8lZ0Km8g9beSbb55+39FjF9j+XmRc/KyUQbYjwa1vzy1PA9n/byOkUQm/KXSQ8/r/DQA8BC62mU5GVJ14eevYmrR9II12i0RL4zDAP3nIEH4k/ck1nhv/U+o34sHRhaODkAEQ67KvilvprU43BNYBuSLr3hmHqSSeNaBoLrHk4r8BaRa8LH9NvAfkm02Rp79yFPAL9Oeu6r3HVxDPWpgIVvMOGUIuBOxOy9wQqw5+abnLdDICOkfqW11kkb5hQG8nkr2mlL1rnybHLC/nNzW4EfYPzhxLXlLa/Bn7J4MPkSihdsb7pCKjKUOsqzx6NAFDs2PsUkiWq/w4fh2TVkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NWv/fU3qaEzH6KPXhuvgqDJ8EgpdLzr0qZ+oUoSBo0=;
 b=DPjT7d+pN8njBFYXsqEbfaQv3eEFHCtAhjKBHQmjomRyzCOLK2kPf9lqnJBj97tynQbBWnFOCTS7ymRM4F2XLIe0wvkLW+6pFy5nzKCSzp49W+x3ETUTKzCO4hTOncV1bO1mV/il7TvtWeIziH6hvE+sSI3B2lxL3BbGQFNOycmH/mcdK5Ha5QGK1948+g+GPP7YdeClmI0YTBv5Il6hr49cW4GNkato1wg8hOEIpqnF0ZAf2SN49FQEuXntH8+VQedD+3GjxnEbFD1i0hOdKQwMsJi9koUE8Tv8KKRZ0RkxX+5HPAYSLz6l5a+FB6XOuQM4omMvSlG/rH66rl/9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 17:45:57 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 17:45:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
	"imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: selftests: Include sys/mman.h *and* linux/mman.h,
 via kvm_syscalls.h
Thread-Topic: [PATCH] KVM: selftests: Include sys/mman.h *and* linux/mman.h,
 via kvm_syscalls.h
Thread-Index: AQHc1q3mv3zQxC8QA0aRjpOiTZdTT7X0wF8A
Date: Tue, 28 Apr 2026 17:45:56 +0000
Message-ID: <92f2f83d938017f68589574d6eda5f8c0e0cb94f.camel@intel.com>
References: <20260428012503.1213654-1-seanjc@google.com>
In-Reply-To: <20260428012503.1213654-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB5823:EE_
x-ms-office365-filtering-correlation-id: 674d7bb5-cc01-419e-9f8e-08dea54e00a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: iickR9po6wCxH+inFHl0ZHLmhqjGYmc0iDQW+6IuPfD9OGBH/viu2I8aZbNyOv7FFmKIEExVZo4NcmYDpBTj3Zvv8fc9Y9jB3OELEFgBxILltlgqHaQWNDM57NdtamU+vzWf+NDeRe5w5F6r9Z+JYD4GTldbkCr25/vOgALJii0LcrV8/kl3FzM7d8/o4vys9W0TuEav9hRSH5efo9VZfbqBWBq2LX6RbFGkTXJs6/2rNeRNovc5yU4KBuusSRy9YBIbGcKJDfk2RtES3fkpr8q4pnt9z4Hb7vzr5UHMVWfbBsmVZjeMDHnLDkpMqHMmyHwuTHlMnj5oTc2gltvgoq3oqA60A0mWwbyAvxIdpwk9NpfQA904hfXOxV9DaUiNMB+FQ+5El7310q9c4hNTmg+cFof6zcs6dFD0BvKIh3J8zDpOGxXH+dUWGBU79ukC64Ununcql4bBc8ITuCeRMGg39xIvq2WMocqELNfLAySRRY6oakCSSI34xqgfuQbrspuwEKTS9CWkd8Ww4OzZoHA0ypO/gRNRyRmAHcVvEnXW9NIMq9/xqXkoIzjq8pu1gjuMT8fwei672hzGCEsfzogeQjy5ICLQgPIT6ZrV3RpefftfoaIEVNUDG3dm/LkWek8m+nAfe1y0G8N/Mq8GdY8ZxQG8vvTeA8bkZCHUXnAiq6bShtdCQet3TZLP7VkKw2nHuVTUgn9/RuQ+m835fHY63o/D+kI40c+bb3mGSaNZB1hxNXPp64ikxi87tO3/mUi9IwMTV+pxo6cWJqKPhrZ9gJ2FfhWekq0pJI7+giA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkNOUmpISWpiY3MzQ2grZU85UXE2dlJCdXNCdk5VL2JaV0VCR0loYldTR2xS?=
 =?utf-8?B?ZEtlb3R0ZHZlaVlkbVVKSnJXK1k2dHpSOHhLNStad3c1a0h4VjlwTDg1azVC?=
 =?utf-8?B?Rnp3OThkWTUvZnpmeVg2bW1xdkU0V3dvQVhpUXZLbEsydmlKWGFoRnBtUzdX?=
 =?utf-8?B?UUFiMUFkamhDaFgvRTdpejkrbHF3eWJUc25DaFJzNWRJUEpvcmxITjFOeU1w?=
 =?utf-8?B?eGs3alFpRTJkSjFObTZ5UHBNYlhyby9LVlhROUE4UkRWMkVlaHBxUWh2UWFl?=
 =?utf-8?B?QTJQSG9HdXdBRFFXdHhtV2lXZmFLRmpoWFZQbEZsWXRUWjUyb244RFcyekpS?=
 =?utf-8?B?V3hORVVsc2p3cEhoV3ZVMEp1OXkzc2oweFZubG9CalQ1cUlseDE4aXJTWmRO?=
 =?utf-8?B?eFFrSk0rSXpWMzJENG8zV2tRWlM4SnMxejhMK1VQTkg4RDB4NEhLSXpJU3Bw?=
 =?utf-8?B?THNNcHVPWXh6eHNBZUN2c2pYRWZRUDVqbEVQUzRVbUNaU1lCRCttcVc1OXJ6?=
 =?utf-8?B?TXdEN3gvZTFINWZlcWRDM3dWSkg2WmhPSFJGVFloZURrcEwzUGhTQ1NnSDA1?=
 =?utf-8?B?OHo4MWY1ZDN5MDZ6aU02YjF2RHZ3aFlRUStkQWFMYXplTzVuK2xHdnRIS05t?=
 =?utf-8?B?WUluU2pVelZ4QlRTWUxqa1RiMUovUmsyQWI4Vk5DMktXQTNBdW9iR2RXOUZT?=
 =?utf-8?B?KzZDK1BMTTlna1RCWWhZYkVVK1hraVp3a2U4bmRsSVF6UjBhUkQweDk3RHZk?=
 =?utf-8?B?MnkwVE16OGJSN1cyYURXMXM0OURWaTZmWEpIUEQvWkNsUi90b2luKzJSbnJr?=
 =?utf-8?B?RFUvK0dTbmI2aU9PSGFzUE9neC9rU0Ewc0tjRHFXZjRJd0tQOFVRWkhqNXZZ?=
 =?utf-8?B?VVovdFRhNEZzZk5XaXd2SUJYWktGWSswYTB4cDQ0ZjZmMTRZZzZic1NseUov?=
 =?utf-8?B?cWxLYVJMREZwMTM4RTZUV2cwR3JuZGJvbTlnWDdkNmVCdEZabmRKMHFrWnhO?=
 =?utf-8?B?eEk1cDJJZno2K1BJelhBaGpDOVlEUStxVlc1WHJ4U3NuTVBvblo3YWx2bDNl?=
 =?utf-8?B?RGZSMkYvSi9IT1lmYzM2ZnV0ZUtkdDh4dEVXU0prS09LeFlUZDdOckJQdGFU?=
 =?utf-8?B?ZTdjL3ZjdjNManlBQ2VPZVc3VzdOYkU3cms0VDZUYjVSOWxnL1MzKzZxNGNX?=
 =?utf-8?B?VUhBWFBJUUdJNmx2KzZqR3dWUWptb0wrNW81UCtoOG54YmhzMmFkZjlESkd6?=
 =?utf-8?B?Um1JTElFTDd5UW1VWWE3ZHpLRUEzbkQ0VmpYZTJIUk9wRzlIbnRJNTVWVTJS?=
 =?utf-8?B?REhMMG9NU3JnaTlYYTJJcUkrckFudXB5VzZLQ0ZyMnRJVFN6b0Z3bU1JbGtR?=
 =?utf-8?B?cGdHUHhYdkxEckFLWmpYbE5Nb1dxd3IzZ1hXQ0pQY3lqQ25pYnNDZkpORzQ1?=
 =?utf-8?B?dkFRWWRGS0V2M0tWOWNiT3JXc1M1OWRURTBrUnJjRUp4RzRQQkg3MlJyS2JM?=
 =?utf-8?B?ZXhTQWd5Zmp0TTRHbXNySStPNjZPODlyTWJXUlVJTXJTT3NOYWh3bE9xeXhO?=
 =?utf-8?B?OFBtZVJDZXEzY3FkREloaFRBTU1xaDBGK2Q1c3BiM1owaVgvV29ETGs2V1hU?=
 =?utf-8?B?L0UvZ3lVQUlhaW9jcHRxVWZNUEFQZU1ITEw2cHRMait2ZllNK1NEOHgzZTZW?=
 =?utf-8?B?L1dEWGV1ZzdBTmNpbEpuQjhOOGl3aXV6ZTFteW1XMGpiQjlNUXRvcW43cE8x?=
 =?utf-8?B?Wmdrbk4rdWZoWUliS25ROFc3VWtWOW5leTFWZzJ0R2VYUXhwbFpJM0E0Tng0?=
 =?utf-8?B?VGpKT0h0WXNSK016aHhyb1hDd1lMbXdlS05TQWV6RDVhNks5S0t4aHNOdVkr?=
 =?utf-8?B?Vk02MXdWcWtYQ3l1UnkvcWg5YVRyKytkMXhjRGpGNW93Q1k4ZWdrdnIvSnlI?=
 =?utf-8?B?bTBNb2NZZEpBckJROUtSOFVNbFZGbCsyUmhXR05uR3NteEJvTU9Ibk9pT3NY?=
 =?utf-8?B?QTMzM3BzLzRTdHdydExiYTR2bzYwR3FzVGozYlo3ekhtK3hEZCtRakxYTXFB?=
 =?utf-8?B?STJORlhzUmZvZUZMSkhUVDRJcTlOUlBXR3psTGQ1d010Qk5yUmRCWm1HaEEw?=
 =?utf-8?B?Q2FxQVFWSzVmdG9ueGNYWlNpbmkvTHFONEZ5aVJ0YW91TW1lRWhnTHByMjIw?=
 =?utf-8?B?NWZQWW5KUzdEbWh2QWdZNllZR2ZISW03aWJ3Q3FTZEo3OWpMVmwyTzlGdHVv?=
 =?utf-8?B?NWxwdTNtTVNiQXZyVHEwUFN6Z01lemZHckw3bHZOREZ3TUVtNFVhdjJuNjRo?=
 =?utf-8?B?NWpzKzRRTUJLYk9vVkRiNlBpVjYrVmpla01mUlFaM1lmR1ZxbzJaQjhCSmpY?=
 =?utf-8?Q?svLaGEgIV9fbZHtE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6FD7A7449FDDB41BDB2BCD074D6465C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UsVL2mapzSvTHnKq7eId6P9+uHLhUmGD1qSoNSTwjfIaD0+aoAn7RYXgisDd+W5Fxr3NkqpikIh4Alzs+TzKGQlbl6eDp4HzRn5C5qYk0xAoByPpXgCt909sYXJoHavz8Eza0p7HauhJxlV699JEpMCWsnYB23i9cEHqk6wxKHdHMuLxYTY6LSKouE9JtBRFZTlrFcwd1UXLf6TXUPsJlzuWl8RmN9ARN91fdcE9PLn2K/gHwkNWNAcwNcjSESe+xM+ddbyCI7X9RFYPjMSlWL490W2mrMmX4txENi9jD6BMTkzH2jaK0M5urbziOLSHN3P09Ti9PasjHgWvsp4KNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674d7bb5-cc01-419e-9f8e-08dea54e00a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 17:45:56.9798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yoZAjmJWd72YOqjQYfWujDc1iay77wb8A4h3H+HWiyo7XAIHOJ6NCTSB4cvQ0oXLYIBH9M4DwSO0gkgHl7nltrMo+DVk51tN5YMT0HRx94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5823
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA0LTI3IGF0IDE4OjI1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBGaXhlczogOTgzMDIwOWI0YWU4ICgiS1ZNOiBzZWxmdGVzdHM6IFRlc3QgTUFEVl9D
T0xMQVBTRSBvbiBndWVzdF9tZW1mZCIpDQo+IFJlcG9ydGVkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8
cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjYwNDI3MjA0MzEzLjUwNzQxLTEtcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5j
b20NCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5j
b20+DQoNCkZpeGVzIG15IGJ1aWxkLCB0aGFua3MuDQo=
