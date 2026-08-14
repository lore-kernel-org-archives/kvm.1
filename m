Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347E3537FD;
	Fri, 14 Aug 2026 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722943; cv=fail; b=cZKv2kRR/MNlaNFvtqJWLdODhSQY6ySCYM84n7t1rgraVZWJRNqJfb51blSkKm1C4/De+QkgXYHPAGfIMs+0VVZE3jSZp89qLfzubVRblo7J8OfGxrA1532YDJhdzr+w7Ejf+wJeI5DuH3augmE+lgAhRmPzWw5pvY94fPcoiXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722943; c=relaxed/simple;
	bh=4dBOcVXbEoRXreuCRHz1VUyxOkVsNy+q+Kv5xI+pzco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZaYkJ+VKqTFwkvI5feQGF3+VYWyC4fTf+okQbjneqkRmg3mmUvvRr5tW5FKMmI747WehvTJChOXdMsyhyD1103w/YkpxREyktJX64CYC/OkJ1LSRhaq2l7j7yc4tbSf9qOxntU7ZNQube6Hm2zshT8Y3X5i9wn44di6l450Mto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWgJ4J1U; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWgJ4J1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786722942; x=1818258942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4dBOcVXbEoRXreuCRHz1VUyxOkVsNy+q+Kv5xI+pzco=;
  b=ZWgJ4J1UCnBZ+RohU8yn/WoGKR6jf1qRi0NxCGre1ww0e3kII9zPqTv1
   K2uJIVX7q8KHIrPKR0MqDRNhzD5YnX7rS3TR7WE2+54QhOt7PvqmxBZvj
   AAqgaP7XmCUTFFE/q8wILPIC6h+MCbebmgktyFdDNAwEDKxEbC1xQeUu3
   KiBw3vZh9JdBAJ7TSWCwSbft0Bp5hWCBhyLweLIugyonT/UNuy0uFi8Hc
   1vXxZTkd0KGjiGOJqJ6/PKWeiDmiuyfvLSqYhxSYtAD8kh6O0dnJdMB63
   8b97VLENkViVV+AXX+rROJmD+GC+Dfbx7etP+fAzYeH0zhnCEmXDwUg9u
   w==;
X-CSE-ConnectionGUID: eb+ay5+hTXSoswNEcKfTKA==
X-CSE-MsgGUID: WsKWLnzXRJ+QmNv2CFBZDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="98660842"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="98660842"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 08:55:41 -0700
X-CSE-ConnectionGUID: lXMOVFvcSvWyw6sZXeJWLQ==
X-CSE-MsgGUID: Kf+pv46YRUq+qBGgLDo3Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267744713"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 08:55:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 08:55:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 08:55:40 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 08:55:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlIoukvCWEwceeXFWYsjs1fL3mZgqirmtuGjdJjYKIQLWIriHkWlXaOH3q3lLPCLDwIHQAHMCalLgZL9mhbiQNTpkAWlH0Yr5+lRIUOHoDvKbTbhWBdVO4GPupz9dvIeB4AL6jMBhRgUOp1ZchxiOfdAAKK45oJcVDicce/L8jmHyY8adS/fUI1ADUO2MKwM4JqWRYapqf3pPbVyQR9EyoSC24HUKX0qD9uFZolgyJTbdJc924WMf4d6AvnDHL1TdmeEiA0PGDUpfge8wZnF+lzzHRA6vHOJ2K9QlHaKbP6RxH77MWM6dBooukET3Cr+y6gD/acLFms0OJ3gqst7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dBOcVXbEoRXreuCRHz1VUyxOkVsNy+q+Kv5xI+pzco=;
 b=yErM2xUnCgFWCKr9BDPltuK5PRg+VRQmnOjZQqNgl6cn0QJyGc9y+MmoKxRNb2VyOujbM1ixRD8hv46lbi4YRvRQqkxeMyZhz/PnOYqoX7RUkuThf1hezOPwrWXful1IxFVzNG9cgou5wMOuGynAqgtdNMRBJPjcwgHHFpMGa0+QzmMpf4xTBcgwI7qc/krcrzz4aDIdS9yhw3Gwk4Cwiz+7UAoJdxhkzEeg4HuBiZR/1S9Jl38NLEQWBtOaNQ5b8DThQ+eEC+cqrkBvWcKkFv+T/TpABw4cgZ/C93JKDIJsz2XPHGUjVuSslpWv259E7FCRtR7u57rE+HCo6KvWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA0PR11MB7838.namprd11.prod.outlook.com (2603:10b6:208:402::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 15:55:35 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 15:55:35 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dedekind1@gmail.com" <dedekind1@gmail.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org"
	<kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "hpa@zytor.com"
	<hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, "Fang, Peter"
	<peter.fang@intel.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAAgBSEcgCAAQNDAIAAIM6AgAAKnQCAAAuxgIAAVwiAgAAC5QCAAAZ6gIAABW8AgAFP5gCAAAu6AIAAn7WAgACrT4A=
Date: Fri, 14 Aug 2026 15:55:35 +0000
Message-ID: <21ffbb7b80c0c654c23a97cda55f43c73e49ba25.camel@intel.com>
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
In-Reply-To: <8b432c8731167e97432b2e917d0b1c855fedf47c.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA0PR11MB7838:EE_
x-ms-office365-filtering-correlation-id: c929dcd4-0e21-4a92-1460-08defa1c7a9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|56012099006|38070700021|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: UM/e44iUBEGEPSjCGQmSEcum9fAnBG5O9fQdTtPcObuQsxKuhRwLqCe4pRGNKVBGyjl1o0sT83bDU33Q1w8v7TFCqbJYJUEYY7cRF+oBMVcypqa5JmZPqNGHmy2AApxFqau/mPKdldGT3HfIyAr/KBDkxiGF1SwK4oGAwQHwTBq/o55BnkZtAD9FYeD14fKqSG8+SA7WG90KUfGofknkdS9DS0OMHaGlTHZ9XuF2lWdlqKLg52HNY9sysBuyYNPQiiddWGHCJZSbwiZxtwtW7RIX6esATd+V29mZhG0xL6ANMzBRReiPrfBu6RWrPC7jTvgJJo5z6OuUG3DDBEgoIcQHY7JnK2FD1pDVoRn83MABjxskFm8W9OhJLGf1S5eNFqjaNTUQ1cNa0PJaRaiftQGYAMNra8Ghv3FXOASNWkT+QDqILMG1OHO+q36TZ2piMezejd7PL+HI6mm8if8w8iSOZRUFoOY7y4VOxTkdi/oMtC2LmnqUpiZ7oOYixE9HvSWJ+9WbcXYsHPFdImDbOhBehWPG5/sxdU0TXkbnf9lPHnVG7QiXeF93rIxd0RI2JRLRkDABuqwuP4Bu9aoJiZQdDNQBmyDb1iPFy0oydsZCalZxmB9MdkATpzOXgOwGkE1PbAMi/NrFcoIHRBVX2aWYxrAhZEgtBDilsc4Fxj+sjDqRB8Y96Dzefs7BcM7gR+BpopoptyLwXkH0UJl3+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(56012099006)(38070700021)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTN5cTlmcUE5bHhhaDNoRm14VkFqMFVzQTZ0eWhpSS8vNW42U2cwUnQyMUkz?=
 =?utf-8?B?eVJmSlN0Z1ZlaGxyZEREYVVGcmhDUkN4SW1OUGFkUzVJdEdZTUdWcENMSWtK?=
 =?utf-8?B?dHJXZ3BKaDUwOXdZdENsejNuQzVGeW0zWlBvV000aWd6bExuQjIxbHlvQk9x?=
 =?utf-8?B?R2J6R2szSG1MWFRPcWlRTXlQU3c5Ym5kL2RlYVZieVBqM3g2Qk8ybXdCcDVE?=
 =?utf-8?B?aDRxZ2pjcWtmeHhRcWdlZU9iVTJ5WDhMMGt3bkh2ZUxvaFZpOWJ3cS9MYzNz?=
 =?utf-8?B?WExjVHk3aG9DQ2xrWHZ4TnN4R2VTcFVFODF0YWNFMEg5MzhHSnYxd3FqYm5B?=
 =?utf-8?B?bGpJbU9TRk1XckxaVkpqOFJRdzc0eDZiQW1CK3BJVkhpN00xcTBIdURiR2xr?=
 =?utf-8?B?L3ZGU3VvYTRqb2wvNmdPaGsvR2tadHFKV3VGalpWd1lNSUcwbHNmayt1Rzda?=
 =?utf-8?B?V1VFMzRHSm5odjRKU2VIVTNJTW5CQkN3Q3Vhb1poQWRiR0w5WENhQmdQTUxp?=
 =?utf-8?B?cTI2bGs1MmowbC9RazFUMFFUOGFtQWdjN1FiOG14S2psSDdCVUdSbUUxayt2?=
 =?utf-8?B?d0JSTUxaUnFiRHRNdXNtQ0VqaEM2U1I3bW1lbU5iTnF3cEtFMFpyWW9kaVpw?=
 =?utf-8?B?WFppWm9TaERCTmFYL0xpZ3RKOVgrOVI4VHNyaHhDc0ZoK1FVOEJFRWNETlFW?=
 =?utf-8?B?ZFNoU2lqV0dMQ21seER5TC9raWhocXkwbC8xdE9BL21GbWZCT3g5TU1vM2h5?=
 =?utf-8?B?M2l6akV4dHVjSVJCazVVMlZkUGVvOHV3OEIyVGFnVU5hSHE3QnZ1cU9pRy9H?=
 =?utf-8?B?ME8yV0gvcDRpTWVYc2UvSjN4NVdaeHZ3ZDFsVTVCUE5wNmFGSWtZa2xNK2dZ?=
 =?utf-8?B?eXgzYTQ5SVR1WHAxUVMrYmZIRDU5R2c4b1AvdzkvUnJ4OVIwMy8zb0QydUs5?=
 =?utf-8?B?eHFReEtEUm91cWRnaUNmNG1MNS9vNzgvUDBGLzMvRTYxS1RhSVFEajZSMXdp?=
 =?utf-8?B?NEZ5bzg1WTRkTkRNdS9ybElkYlVOTXROYU9DM1l1aXpEZmdSSGsyZG9RcEk5?=
 =?utf-8?B?ei9PZDVvY3pUMFlWL0hiZy9najl1YkxNR2tQS1NTQkt5Zmd4STZzbXpjRW5J?=
 =?utf-8?B?OVYvMGgzNTdBQ2YwajhIVGNFaGlWNTg2eUpGenl5L1dWdjFheTNVYmxwdzE4?=
 =?utf-8?B?dktaU2NFZjM0TnVTbS9KRVZldDk3T3ZTaEYwNHBuOXZrQUhNZkdOZDk4SnJI?=
 =?utf-8?B?alJLUmMwV24zaml5YmhVYkJScTZjZVpaeUhaYWRtS0JQOTZmOWQ4eWV3QlNH?=
 =?utf-8?B?RmdCWHBoSzhHR3NSYWYrUWVZakVobzM2TXhkZ1N1b1VOcVBYajJUaWZaR0lm?=
 =?utf-8?B?bjBORE41cDEwYmhwQlliWHpTODN5dnpWWTVDYnBwdzdlMlNlRUdzeUgzZkNJ?=
 =?utf-8?B?aWlsRHRQVjVaeGxQelpudTVTWTFQOVZzQml5WXNBdlJ6YlZ0c3hucVJEN1JO?=
 =?utf-8?B?RVh0SlMzSnV5VUhtMVpzZHYyWCtqWEF5WFpncWJad3UwR1FLY3pjdUJrZnJO?=
 =?utf-8?B?dDUxR1NFYUYwb2lyM0FaaUJua25oSllLQ3c1MXc1M3M3SVBvL2xZQmtjSXFy?=
 =?utf-8?B?dThLZy9BMUVXUEk3OHBXc1A1ZlIxMzBDRmdEK0hIK1Ntdm1UVmN4YVdxNGxk?=
 =?utf-8?B?U1dGZmNSL0RjMUYrZnRYeHBNd1E0VWVEZ3ovYUlKWWpoZFhhNUJYYXJsdmZv?=
 =?utf-8?B?Y0VCZWxITkozcStrRThCWXhoTHJrRnVnTXVsQ2hCWk1hSnF5VG5jNmVzcjBV?=
 =?utf-8?B?ek1sZGF5eTc0REc1ODhJN1d2anN3T1FhUDNKTkNlMHYrdUt4RW1ZaHIrc09o?=
 =?utf-8?B?Q21XYXFvenB5NHlOc1lHTmpCS2hoa2xpRWdOd00rSzgzV08yZ2RiSG1pckI0?=
 =?utf-8?B?d1B5R2h3UlQ2V1BKdG9ZK1daT3VFNGllYmFUTkxrWEZtTUtKeWhwaEdHZ1JY?=
 =?utf-8?B?NGVFSHBiRHg5azEzbkhPV2UzMW5QV0tJYittRGpaa2trbVRJeFcrM0xnTmZn?=
 =?utf-8?B?dDJ0aVJoaHhKemNmYkhhVVBiMHJHYWdDeWtSeitsa1I1QU1rb1NXdEVTTElB?=
 =?utf-8?B?M1NHMldHK1c3dkc5dWhnczFuMFUzRUVnemUzbERKR1J2UXNxQVdWVHdrVVp4?=
 =?utf-8?B?b1hRZmZNV0IzY096NCtJVVhUVnE4U0VVbE02Nys2Y2s0OCtaU3lFYUhSM1FD?=
 =?utf-8?B?QjBHYTZtNlBpTEIycGcxdzk1TzYyeDhsMlF6dTZHZWdYd2Z1c2x1S1pqUHht?=
 =?utf-8?B?enYrYmxmbit3ZS92ZGRZTmdJSm1zMFV3dmZ5dHhEWDBua29UMm53c1lreFFk?=
 =?utf-8?Q?hv/kJ4+uXT3/0VhE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F129DD14ADAA942B216EC93C6208A05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ta+X3uoMXlRAgqV31lZza0mZB0CAKw1UHOeLOm+xGdcAMGr86ijlw/DhrqppmQFoCdO4f9YIZ6RdymG1lQvbsYMg5muGEJnW49HGy8W/ZLLiJI5LtAhOoZt4sK6jq0P3XIIh6Xn6wyR8RM1t+cL+yDFZnAJdINEJrRSdIFcJyOig1j80xw8BruLfRDPvvjna5T73Akeib2aCkjpbMdJuewKwMCJ5JEbw0H/2WnUIp72nczq8zx1o90XFm+G0RgcqwkPQLVFRCpW5o6qTbudMjN+lvAFZkbr1QzCoR/DBXZaQpXk17Zak+LUVN3kZbsLRKa8tCkCDFyQHyubJrEdH2A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c929dcd4-0e21-4a92-1460-08defa1c7a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 15:55:35.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdG9emkLATfyw7x5KNcsxYl3I7COahk9OZvNS0bxAMVTWzRo3lQPJqUc8hY5Ok8xoAy9cXltQR3Rt6Tmt6HUIMH+voula3zYkv/wMRxu+MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7838
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTE0IGF0IDA4OjQ1ICswMzAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3Rl
Og0KPiBCdXQgd2h5IERJQ0UtYmFzZWQgYXR0ZXN0YXRpb24gdXNlcyAyLWZsb3cgZGVzaWduPyBD
b3VsZCBURCBydW4gYQ0KPiBURENBTExbVERHLkdFVC5RVU9URTJdIG9yIHNvbWV0aGluZyBkaXJl
Y3RseS4gTm8gY29uY2VwdCBvZiBURCByZXBvcnQNCj4gd291bGQgYmUgbmVlZGVkLiBUaGF0IHdv
dWxkIGJlIG15IGN1cnJlbnQgdmlzaW9uIG9mICJjbGVhbmVzdCIuDQoNCldlIGRpc2N1c3NlZCB0
aGlzIGFwcHJvYWNoIGludGVybmFsbHkgYW5kIGluIFBVQ0suIFRoZSBwcm9ibGVtIGlzIHRoZXJl
IGlzIGENCnNoYXJlZCByZXNvdXJjZSwgYW5kIHNvIHNvbWV0aGluZyBuZWVkcyB0byBoYW5kbGUg
bG9ja2luZyBhbmQgZmFpcm5lc3MgYmV0d2Vlbg0KdGhlIGd1ZXN0cy4gR29pbmcgdG8gdGhlIGhv
c3Qga2VlcHMgYWxsIHRoZSBzY2hlZHVsaW5nIHR5cGUgc3R1ZmYgaW4gdGhhdA0KZG9tYWluLg0K
DQo+IA0K
