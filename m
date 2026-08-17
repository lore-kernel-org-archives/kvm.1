Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307B425899;
	Mon, 17 Aug 2026 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987574; cv=fail; b=jThpSKLZ7lBGP1jpM+CjX6pDzpoUvBiArb3n3DIUHbVEd9nQvzR7P3aTRuXtrhHpBNhuEOxUMPN563526zhLaKgg0/+XXasGczNuKRmGn/Zlx0061Ehks9p+l5beQXZ9mPHXKOCvpNNWHjl/E0kuOP3qdly68yokrHGbqFnXYME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987574; c=relaxed/simple;
	bh=mar1QJbeH4l4kEf0mfWv6rGPSlInLXLnuMqbPw6Ag64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ot0sPQ3XgOOWbwH+uJHnqiIjSbdfOQ5GtRzpEtY3COS5J7d/uzOmBs+IqKkDMIGZTykBPmm+OTPhWEqzbnUmB+YhJV/H4Fgsf5YcIQ/GkvOO2jmhn8vlxYW5aPqrhf0fg6S1yrjK2ULC6eD34QZXK2HaDNutkQ8OlaUQwirVAi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOBF18bB; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOBF18bB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786987571; x=1818523571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mar1QJbeH4l4kEf0mfWv6rGPSlInLXLnuMqbPw6Ag64=;
  b=nOBF18bB0NbPxktbc4eDX+vVWucYw9ojlowlw/GUYQUbBIqCqf79HEev
   Ild1zyw8kysZYpTr9xkmY2wECbnhYsueztKdqApmf5UtpzpMuJsxY8JbL
   HMojZMLwULdimsn/GKrEntayHFsofsni/18SE18qmtl7HCiD/T6EyfER1
   JKSM0cGd9AgFk7PzkXbOq0xZ+97q48qDUmWGaEX5EGHuywwT4Flf7A7h3
   hm45M+d1abNYFIge12nw2j+Hwem1zwveOVd4Dmdnww0VoW3kQi71eKXnf
   RSpiu8aEj/gL0/0RmlEc4a5cmNlWHW2iOpuQ7QDXzWjyXfqz2Wd4+atAF
   A==;
X-CSE-ConnectionGUID: H2zb74fmT66FCrMoXOlEVw==
X-CSE-MsgGUID: QaNYHoPyTCed0b0svJfIBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87535590"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="87535590"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 10:26:09 -0700
X-CSE-ConnectionGUID: 8sNxB66HSRagwdEAdRkLrw==
X-CSE-MsgGUID: xDJXEN9UQMCSEneNMPIJhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="303207493"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 10:26:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 10:26:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 10:26:09 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 10:26:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLtEXHH7SvSZVzMXSu05MwzhEuUMaW3Th3M7oKyca7poz9gU+e+DtjChP5onxS6BJoiN9ZD9+8bbxOcRX4DyjYFft+jJpP5PM/S2z5yAQN+yHu6NtE0h6X/kaZSOfQuyirhUY8VdO+nl5zh9k3xM0/7Ah3J1ShSvyOy2lu+xzs2s78IaH3FVn1N+UyOjdwMUMCKSaeAkKIRKXmNSgnC0R+biWKMmRgHxfUmuXEqWatBsWWZtZLTUfOtG/TSoIVvCtCo+Bbc+M7HcYo7PN/f5X2K17RBdswjbvnk4VV+wYJca6BM/11LRP3rfP5rvKG2lQHMT4Bm32Zsq0hNCxwd/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mar1QJbeH4l4kEf0mfWv6rGPSlInLXLnuMqbPw6Ag64=;
 b=SIVkH3TGA5zpRfbRBmGd88E66SlcV9bwedT3gDjOaDr9LXPb2Xk2uERapedCCl41Efp9hfZy+BS1MrKGKcnapJ6/24sDwm1oNkApWonOQ/1snTpwzrFYu8/oMGIUUJvPGEvG5R2tvVEmpRD+uVokQTxpy5evNVSt+R+8vj0WtJQkhP7I43XRaVFlcKTgh9Yuj4c25UlZdSvznKMSRGpxpa2w53e72AQH+dE/vwZUIesT/IFj9ee5xqyx9ZeYNIBFYRK0aV4IMEkgvZf7dvbekpciB4uzZaw2OSDM0rPPW3ECreGjGwtknM3DXyDVzql8p0l3A1MCR6D01BkR6LJJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB7064.namprd11.prod.outlook.com (2603:10b6:806:2b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 17:26:05 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 17:26:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dedekind1@gmail.com" <dedekind1@gmail.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "mingo@redhat.com" <mingo@redhat.com>, "Fang,
 Peter" <peter.fang@intel.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAAgBSEcgCAAQNDAIAAIM6AgAAKnQCAAAuxgIAAVwiAgAAC5QCAAAZ6gIAABW8AgAFP5gCAAAu6AIAAn7WAgACrT4CAAUnjAIADhmYA
Date: Mon, 17 Aug 2026 17:26:05 +0000
Message-ID: <0b5a26492f367f793aab38e4a0d9d6f398340f51.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
	 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
	 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
	 <anxvwV_Pz4UYaxxt@google.com>
	 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
	 <anyiwqi9i0NSv0QW@google.com>
	 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
	 <20260812223707.GD1013044@pedri>
	 <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
	 <anz9b6CDkhr5D5RG@google.com>
	 <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
	 <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
	 <4ad451969522eecb445289ca74a88ee73d51336d.camel@intel.com>
	 <8b432c8731167e97432b2e917d0b1c855fedf47c.camel@gmail.com>
	 <21ffbb7b80c0c654c23a97cda55f43c73e49ba25.camel@intel.com>
	 <498af8d6a5de3ee05e0216ea075c0eebf88c7072.camel@gmail.com>
In-Reply-To: <498af8d6a5de3ee05e0216ea075c0eebf88c7072.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB7064:EE_
x-ms-office365-filtering-correlation-id: 86d39515-4868-4d9c-eb2c-08defc849e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|38070700021|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: MHsHVI6BVriUX9DC5LVY/f9Ng99l4hutkEQm8H9YTJhU/wQIe3Ejo7qMVzaXjHf3nsKSevfph69lf5Xm9SApos2bmh4PyA4CEHEUt6PloUV+dD8Vn/EAd2Z9v+b0+2YoNp8Qm3dOGDjAFiIldXElAGVxQhSmBcA1HOgrbcadQSsobFji5FZxVVutrPm5Ij1UfZK4/jHWNWzXOeo7JOxwj//ATtSrnf7XBHsmf/ClCkOQGZJ2hHCz2PdXe31US3+daQ+FAaslI1xnR08KlhvqftYrvR54tbZ/RwPiUEL5PMLxYp6sMkz0ZzlPpBakJq0BixljcjDELLgoSbaVdJP0Z+dMhxfz0gc/iGYSPkGeXMZs9MRORB4bzaaZ7wWkVmkfaVaISZl9UaEMt5+ugorv+uv4B0f3DVrS6ClFmZdgOqyXNGaTI3p4T3hFxjT4zzA/xY01aTE5IjCTFGFOwLjjeeg5/r3gtumH7NUT75TB9gqwcsLnZ2fK36ILD00OIpeSeIrKN+/3N5DSySjIwnjC4tItjHd0OcZbKjm6rdTZX+4NlOnNcvZ5q4y8/0RtTIp9UA2FPF/pK53xRo2pozD6EWb1ab4lMRyUAJwviyT74tW+KMjSoYAvRbkuxfXGr/ZMvFcfwm3OEi8DueQyCbrhrulbKdPH4LD9wzqMYFIIQK39ykVFtX7VtC4DTBXIbpK0w7H8MWuUFkdCX+lOPaLhrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3ZqSGtmN1M3ZFF5ck9WM3ZSWTY4dktic3Z0QVowOXBNRnFhbmFiOTcwcHhV?=
 =?utf-8?B?Kzc3S05RZjB0U0ZFSElLcXkrS1REM1dYMU0yUXNOcTB4LzhSdVVmZ2RFQjdF?=
 =?utf-8?B?WkpZN0tYT2xXaFowdTJUNjJoYlZzbFhsdC9ZUmh2VWRRMFBuTzNsdzJYdXJn?=
 =?utf-8?B?SUVLUjdWaXhLa2F4alFpMGdlVEVUYm9zdVdTcE0vMFN3cy9zemNsTDBYcUhS?=
 =?utf-8?B?enlLNS96cVV1b2Jta2lDZk94NHVuZ1VDRG56VUhncXZlSmNJb1ppZHRJY2pU?=
 =?utf-8?B?WjlLZ0s0M0lXOENNdkswNkhzV0VlcG1iUUNxWWQyM21iK3M3VytyTHBTa2RC?=
 =?utf-8?B?WlJVcVFSQTZnVStqakVpLzdXSFkyUzRjMkRmYUVhaWV3dFlIRytLMzBFL3Iw?=
 =?utf-8?B?dVZFajYraFgvR3RTMzViWXZEM1FIQnFXWGZPc3BNWXlDcVR6d1hXdnpBMFZv?=
 =?utf-8?B?L3BCVlJHcnpxSVBkZ0NORlJ5UGt0ZmROSVk3R0VWT09hU2J5dXAremlkRGxl?=
 =?utf-8?B?R3l0dEFSVEd1bUxQSHZqZkJnNGEwY0c2VGlMRExuV2xhRzVwK2U5dlY1UnVW?=
 =?utf-8?B?VFMxaWxoL1o0RmFHdUhxckJ2bExpMkFwOUhMSmRqS2J4eXcwd1AyYWhHellh?=
 =?utf-8?B?TFVDNStUNGhGbng3SlBINVl5dUJGMlhUczhQZkpTdnpFQjREUUJqNXB4ZDZp?=
 =?utf-8?B?MUloRkFNaU1tSEpEU1RaeDEvQUFvTU56cnJlNW4xUlFRSkFJT01LTkZMRklq?=
 =?utf-8?B?Zmk2Y1liVWJ2T3BEbG9rVVBUQndvMmY4Zkd1eHlVeDhTaFBjV2VRa1Y4M2l3?=
 =?utf-8?B?K3B3eFV6Z2ZaTDM5R1BVKzl5eUNjaS9iUDBXWko5ZzArdkhzS3ZaTGRhTllm?=
 =?utf-8?B?U04wRFZTdEtDNWFIeXdxeEYyZWJOVHNwSXhNWUhTeG9qTjg5Z3hpdTRxdXBj?=
 =?utf-8?B?d1g1U0FyM0JTWEZDVVAzV3o2TFJXUFBnS0xjcEU3Q2tvUzYyUXdLaEZiUGU5?=
 =?utf-8?B?cXVrelpvVGlOS1F0dXRDdGt4RkFaTXphRWJuY0oxc3I1a3JqQnZCb3NiS3Ru?=
 =?utf-8?B?QnhXOG56YzZRVkJHdFRzUXI3V2xuVXVaUFZuY0pOdzBTUllTbjBVeFY4aGJv?=
 =?utf-8?B?cWZiVE0zWTBuVHRHZVZOLzgwZThFZjlYUHI3bjRQL2lPMklCZkVlcWo3WEdv?=
 =?utf-8?B?ZnRNVlJOQnlpSFI0LzRGRTNDWEpyTC9BVFEveGRJUDM2SDdCSGhxcStHMkRY?=
 =?utf-8?B?THJ5ZzFPZVBZajUxVzRYb1dTNGxVVGRiVkk5ZFhPZFB4TFNNd1RWZ2hncTVK?=
 =?utf-8?B?NGtXQ3h3YmRHUjVIZzUwNHBRejhoRENuNjZaOHlMU1NTY3RHamtWNkcwY0Z5?=
 =?utf-8?B?VTFIdWRwMXlobTU1eEFRRnBBQWRzUksweE1TeVpDbk5KMzVSdlFleFhUTERT?=
 =?utf-8?B?Nzd6blpzL3ZJUTROLy92ZHM3akg2cUhSMTZEU05xTTRyMUhWaUN5NjF6dlh3?=
 =?utf-8?B?eXBYUFhZYWY2MVlWNDhCdmZOZDliV1gwQmtsanE4ZDFoRk1RVE45dXU1Tndh?=
 =?utf-8?B?NTRtTjRYbXJmaUVhYlAyU2xacVZ1SDQ5eHlLRnpJcHFHaWhscXZwUk84RUlu?=
 =?utf-8?B?TWw0em00RnM1ZjI5S1FrMEQvZkg3RzhXZFRMdS9TWFVaQjE2L0p4cGcvUW5M?=
 =?utf-8?B?UUJyelpFUTJCRksrNitybEZDNllDYkRuZm1uQUZqTlhrK3k1SDYvUUl0Ui8v?=
 =?utf-8?B?Mlo4TGJTcTlNSGlwT0RJb2ViM2FGNExKRGRMa1luaVp6M3hPNWVFRlFtS0xK?=
 =?utf-8?B?RWY4QWw4SUhxaFBUMGNGdVFvZXlpdUhJNWRIb3ZjVTBHTTFMT1VSdVRPNlFU?=
 =?utf-8?B?MjlPdHp0WHRXVEJFRTRLOFhncjJ3NmVIM2VXZ0tzaTMreWNlUVdoUEtpSU5t?=
 =?utf-8?B?Z2JsamttaVlabWZKSTVXVU5TaUVONmlXSGhqVThuTTMxZDl2cWVidllmVjFQ?=
 =?utf-8?B?SXNTMU9tOHFaQk9renZnQXF4ZGU0QWhzemdHQ2NiMG4yS0NUbDhiTTFrUUNN?=
 =?utf-8?B?NkU1VjRVNjVJRFpPUE5LYjJxT2ZDcWJnY2tCWXp0TmU4M1Q0b3dhMEFZT0hQ?=
 =?utf-8?B?MmZWdTdVd1laVUQ4NjhKZEo5Mkk4djlneE5NL0ZpQzdOOHNkTHR2L2lITmFD?=
 =?utf-8?B?VlpsYnhIV0J2N2FuMitRRUdJd2puTzVSSDcrTURpbk15OFVCQXg3dGxGT0U5?=
 =?utf-8?B?WXB2MXNBVy91Vk9FaHFpdG9zVzYzeVNCanZVeEI0dndTVHJhTFJZVDMrZVl4?=
 =?utf-8?B?RU1yWmYxSSsxcHBsTW5OU1NWdG1jU3ZmRDNscEcrVWNvNG9qVmdLMzBNZW1Z?=
 =?utf-8?Q?1R85LrH66snqSr6w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8775B8AF4668BE42B3E8CFD8B2928BED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KLby8hglTmTxzpzhL4+B40ctJhwvY/2ne9C6CsIBOL+IWoZRQGsozyqgi4OH03NgfBVBPHCsXF9rtjNy8EMZU1gsWGVtcD+EtsKj+1tGRuC8y3xBVpsUO1rOfPmO8GrgB/HurQ+E5WtRDpxPOv6frz6/zeEZYl1hbA4qkhHP0VUplb/SEV1fZUUhAAH/kpxlHr5CWcJw+MA7958ikNphOIDBVJs66+mCauDfhjLMw3u28ohDoZh3R/WOWve1NDBDXS01Zu9vqvC93PfHisChvvP6XVes9rqmz8p9kTsU0YuS7FiG/SYX5LFGcx7cprfIhP/6Z6bykPXr0L9FPAklOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d39515-4868-4d9c-eb2c-08defc849e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 17:26:05.5716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8ZziBy3OdWWUEIxTHE9zyKwEddYEZq341KhUP8bBVwX5EmV4oRd6jm4YgcHEuW1QMG9QVr+nPucLFVgm6C1ZU9n5ceQ57RnNh94tsr4OCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7064
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTA4LTE1IGF0IDE0OjM5ICswMzAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3Rl
Og0KPiBPbiBGcmksIDIwMjYtMDgtMTQgYXQgMTU6NTUgKzAwMDAsIEVkZ2Vjb21iZSwgUmljayBQ
IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyNi0wOC0xNCBhdCAwODo0NSArMDMwMCwgQXJ0ZW0gQml0
eXV0c2tpeSB3cm90ZToNCj4gPiA+IEJ1dCB3aHkgRElDRS1iYXNlZCBhdHRlc3RhdGlvbiB1c2Vz
IDItZmxvdyBkZXNpZ24/IENvdWxkIFREIHJ1biBhDQo+ID4gPiBURENBTExbVERHLkdFVC5RVU9U
RTJdIG9yIHNvbWV0aGluZyBkaXJlY3RseS4gTm8gY29uY2VwdCBvZiBURCByZXBvcnQNCj4gPiA+
IHdvdWxkIGJlIG5lZWRlZC4gVGhhdCB3b3VsZCBiZSBteSBjdXJyZW50IHZpc2lvbiBvZiAiY2xl
YW5lc3QiLg0KPiA+IA0KPiA+IFdlIGRpc2N1c3NlZCB0aGlzIGFwcHJvYWNoIGludGVybmFsbHkg
YW5kIGluIFBVQ0suIFRoZSBwcm9ibGVtIGlzIHRoZXJlIGlzIGENCj4gPiBzaGFyZWQgcmVzb3Vy
Y2UsIGFuZCBzbyBzb21ldGhpbmcgbmVlZHMgdG8gaGFuZGxlIGxvY2tpbmcgYW5kIGZhaXJuZXNz
DQo+ID4gYmV0d2Vlbg0KPiA+IHRoZSBndWVzdHMuIEdvaW5nIHRvIHRoZSBob3N0IGtlZXBzIGFs
bCB0aGUgc2NoZWR1bGluZyB0eXBlIHN0dWZmIGluIHRoYXQNCj4gPiBkb21haW4uDQo+IA0KPiBH
b29kIHBvaW50LiBJIGRpZCBub3QgdGhpbmsgYWJvdXQgdGhpcyBhc3BlY3QuDQo+IA0KPiBJIGFt
IGN1cmlvdXMgaWYgdG9kYXkgdGhpcyBpcyBhbiBhdHRlc3RhdGlvbi1vbmx5IHByb2JsZW0gb3Ig
YSBwYXR0ZXJuLg0KPiBJIG1lYW4gdGhpcyAibWFueSBURHMgY29tcGV0ZSBmb3IgYSBzaGFyZWQg
VERYIGNhcGFiaWxpdHksIFZNTSBuZWVkcyB0bw0KPiBiZSBpbnZvbHZlZCB0byBoYW5kbGUgZmFp
cm5lc3MiLg0KPiANCg0KWWVhLCBJIHRoaW5rIGl0IGlzIGEgcmVhbGx5IGdvb2QgcXVlc3Rpb24u
IFRoaXMgaXMgZ2V0dGluZyBvZmYgdG9waWMgbm93LCBidXQuLi4NCg0KVGhlcmUgaXMgYW4gZXhp
c3RpbmcgaXNzdWUgd2UgaGF2ZSB3aXRoIHRoZSAiaG9zdCBwcmlvcml0eSIgKEhQKSBiaXQuIFRo
aXMgaXMgYQ0KcGFydCBvZiB0aGUgVERYIGFyY2ggdGhhdCBpcyBkZXNpZ25lZCB0byBoZWxwIHdp
dGggZ3Vlc3QgaG9zdCBjb250ZW50aW9uLiBGb3INCmV4YW1wbGUgYSBUREcgY2FsbCBsaWtlIEFD
Q0VQVCBjYW4gdGFrZSBhbiBTLUVQVCBsb2NrIHRoYXQgdGhlIGhvc3Qgd2FudHMgdG8NCmFsc28g
dGFrZSB3aXRoIGEgVERIIGNhbGwuIEl0IGlzIHNvcnQgb2YgaW1wb3J0YW50IHRvIGhhdmUgdGhl
IGhvc3QgYmUgaW4NCnVsdGltYXRlIGNvbnRyb2wuIFNvIHRoZSB3YXkgdGhlIEhQIGJpdCB3b3Jr
cyBpcywgaWYgdGhlIGhvc3QgbWVldHMgY29udGVudGlvbiwNCml0IHNldHMgdGhlIEhQIGJpdC4g
VGhlIGJpdCBtZWFucyBpZiB0aGUgZ3Vlc3QgdHJpZXMgdG8gdGFrZSB0aGUgbG9jayBhZ2Fpbiwg
aXQNCmlzIGJsb2NrZWQgd2l0aG91dCBsZXR0aW5nIHRoZSBsb2NrIGdldCB0YWtlbi4gVGhpcyBn
aXZlcyB0aGUgaG9zdCBhIGNoYW5jZSB0bw0KcmV0cnkgYW5kIHN1Y2NlZWQuIEFmdGVyIHRoZSBo
b3N0IHN1Y2NlZWRzIGluIHRha2luZyB0aGUgbG9jaywgdGhlIEhQIGJpdCBpcw0KY2xlYXJlZC4g
VGhpcyBpcyBsaWtlIGEgY3J1ZGUgZmFpcm5lc3MgdGhpbmcuDQoNCkJ1dCBpdCBhbGwgZGVwZW5k
cyBvbiB0aGUgaG9zdCByZXRyeWluZy4gSWYgdGhlIGhvc3QgbmV2ZXIgcmV0cmllcyBiZWNhdXNl
DQp1c2Vyc3BhY2UgaW50ZXJ2ZW5lcywgdGhlbiB0aGUgZ3Vlc3Qgc3RheXMgbG9ja2VkIG91dC4g
V2UgYWN0dWFsbHkgaGl0IHRoaXMNCmNvbmRpdGlvbiBpbiB0aGUgdGR4IG1tdSBzdHJlc3Mgc2Vs
ZnRlc3QuIFNvIGl0IGlzIG9uIHRoZSB0by1kbyBsaXN0IHRvIGZpeCBpbg0KVERYIGFyY2guDQoN
Ck5vdyBob3cgdGhpcyBjb25uZWN0cyB0byB0aGUgMS1mbG93IHZzIDItZmxvdyBkZXNpZ24uLi4g
QXMgd2UgaGF2ZSBiZWVuDQpkaXNjdXNzaW5nIHRoaXMgcXVvdGUvcmVwb3J0IHN0dWZmLCBJIHdv
bmRlcmVkIGlmIHdlIGNvdWxkbid0IHNvbHZlIHRoZSBIUCBiaXQNCnByb2JsZW1zIHdpdGggYSBz
aW1pbGFyIDItZmxvdyB0aGluZy4gRm9yIGV4YW1wbGUgYSBUREcuQUNDRVBUIGNhbGwgY291bGQg
ZXhpdA0KdG8gdGhlIGhvc3Qgd2l0aG91dCB0YWtpbmcgYW55IGxvY2tzIGFuZCBwcm92aWRpbmcg
c29tZSBraW5kIG9mIHRva2VuLCB0aGF0IGENCnBhaXJlZCBUREggY2FsbCBjb3VsZCBiZSB1c2Vk
IHRvIGNvbXBsZXRlIHRoZSBhY2NlcHQgKGFuZCB0YWtlIHRoZSBsb2NrcykuIFRESA0KY2FsbHMg
c2hvdWxkIG5vdCBiZSBhYmxlIHRvIGFjY2VwdCBndWVzdCBtZW1vcnkgYXJiaXRyYXJpbHksIHNv
IHRoZXJlIG5lZWRzIHRvDQpiZSBzb21lIGtpbmQgb2Ygc2VjdXJpdHkgdmFsaWRhdGlvbiBvbiB0
aGUgVERIIGNhbGwuIEJ1dCB0aGVuIHRoZSBob3N0IGNvdWxkDQpjb250cm9sIGFsbCB0aGUgc2No
ZWR1bGluZy9wcmlvcml0eSBzdHVmZi4gVGhlIG92ZXJhbGwgc29sdXRpb24gd291bGQgYmUgYmV0
dGVyDQpmb3IgaGF2aW5nIHRoaXMgbG9ja2luZyBiYWxhbmNpbmcgc3R1ZmYgZG9uZSBpbiBhIHNp
bmdsZSBwbGFjZSB3aGVyZSB0aGVyZSBhcmUNCm5vIG9kZCBvdmVybGFwcy4gQnV0IGl0IG1lYW5z
IHdlIGFsc28gaGF2ZSBleHRyYSBob3N0IGNvZGUgZm9yIGV2ZXJ5IFRERyBjYWxsDQp0aGF0IHRh
a2VzIGEgcHJvYmxlbWF0aWMgbG9jay4gUHJvYmFibHkgbW9yZSBURFggbW9kdWxlIGNvbXBsZXhp
dHkgdG9vLg0KDQpTbyB5ZWEsIEkgd29uZGVyIHRvbyBpZiB3ZSBjb3VsZCBtYWtlIHRoaXMgYSBn
ZW5lcmFsIHBhdHRlcm4uDQoNCg==
