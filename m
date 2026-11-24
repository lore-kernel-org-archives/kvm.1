Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795478540;
	b=k45ZMO9mUe3SaV705d/7+Su0cvMWrFKlB+kWemrmV5SBV4TzTE+GQ8Anx08VX8lS4wjB
	 fTbuREZhDYCoiW9wRdyVaG2u1sQixrroML0gZOoqNUWJECpKcCa5oReGC+NNQrSZcQ/lX
	 7g/jzL6pH7E8HYgIAZiaocRCh+Rnq/cXCokkPe6hNLuS7rliOJI/RYE8X3l8N9OqFj5la
	 xEUa4MUDnnLLQXnnQtqVO0iTORqACHwyujwx/XvKO1Cvrfea+JYzlpZR3ZhXKCcd4+0q1
	 n/xt9OKPiBHIS+oxvQqOlnDqDAD8Gxxe1g9fgpD/mPUJY6zYKbUj9iNiYKHbV1zcHDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478540;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=4fE9C7k5bttQZKYHV68a3Kuybdkf5hfuGUoqB91SVnU=;
	b=zTv8pEspB8l7Krvq51n/UpWVFqoOLiY7Ja9ngx7pLqyDnBmB3pH5uURQ0SYTSiZHUr9X
	 J62DuIm5jEVMdW7RceQ0zahkLqiHHvnxVawVeqeNn/WpNwcsTctAW/tEk/5uHRHq+OxWE
	 qbkUEPx30JPYHZLCzqriNqiFsM3WeqPh7KaXVtY/ULfFkP2tPzffJfAnCpIfCbQp0GcQN
	 DNTiBk14B45VqANzio92mGBbOWqOYnb0kz79FWEbyfWy3JQnWlOjRVlXLUqu7/SygNeVL
	 +aWF50Ke/fE+xkUZNP9bO5iHSaN4yKGvFR5JR5DRCSUS4RbOQ3muSKPPtbAc2ChZneQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jUyGUzpu;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bqV1cKb+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CE606A336;
	Tue, 24 Nov 2026 00:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 755CE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jUyGUzpu;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bqV1cKb+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795478540; x=1827014540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4fE9C7k5bttQZKYHV68a3Kuybdkf5hfuGUoqB91SVnU=;
  b=jUyGUzpu3f/v4892RF/2MuyvvGaRvYl5xHJPH1BWjgjs2b/F1/RUj0O8
   uzDrqnsURBQP2b2uCjeDjcAhKIIOIRuvHTGmdiTKWiYoZb/I5IZMUOWlh
   zWvExhZxaK7QWj1keRne9M2C+kEU/NAB34EVFfhblgxolPhKLE/RB3blZ
   LuoTNelrixkgc969bWaoFLhRrQxFnjguWR12g5ugfhLvg1fNk0y3qQbFX
   xge12qxNpX6il4Z84cnT7O0zyUEsxIQQQgBLQwpMOxvDANjjgBqnh2eoV
   xTLGih0Uxa4bx58o9C4Vr0vJ2Cpq9oeYwwthSrXgwcQoHjJdHBcZVCEaV
   A==;
X-CSE-ConnectionGUID: gTbaeGIZTY2y9Xth2nQ9Hg==
X-CSE-MsgGUID: DkXQaoYkSlWxZGyJKBdfTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4203044"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4203044"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 16:02:18 -0800
X-CSE-ConnectionGUID: 9Zr2nhj2TmWfYkY1zXL7lw==
X-CSE-MsgGUID: hiOOPQsqRoyt7Js1YZZW3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11757245"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 16:02:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 16:02:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 16:02:16 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 16:02:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmDp1N+j+12NHbJ1pyGB0LTh5CJBiCVpSWEeM9COqSeYgWPVqQtBJz+wQ+QW8qR5BEqOGmTUoich9JfF+Yit3RpPsaYrdDGKk936NRKKSYrmjxOR55zer3tpHX+Wxp/RBSbgPULR2uw3OMeO6pkj9so9MoptXSGv9Yr0+Y4fpphsYOK7kpvb9vetLme2IOTVBfWvBEgpE5lhFXGU3qukPy8XAPF0XbMbklPLAkoSiRp3UhwH9NbCWLz3nlVshJwMt0EdPGhN3lLXw7O5Bmcon+uTHMtbiN1rnaVj7rwBx91o8DL1yeKkl3kS8czmogp/HZb97LUpk/dQa9Og7m6B0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fE9C7k5bttQZKYHV68a3Kuybdkf5hfuGUoqB91SVnU=;
 b=igOCMOXrl+Xek5v/2fmvETDJfXL47vHAxhlsh+vcmeNWlCLTb8uqDVYYQMslaiBmWzTHfHWq0kXRwmgo953vwZOUWPYOwQYs4CDSTqqPs9pbwnuQ/wpcl0Chtl2KTgG03SdlPTBczfdfXJ7uGUDvXb0iO5OinxzaMkSds2EYhtxNcZwt6qwggcxJ2xeKwBjlvUgoPLVeiJCgFGpASdgoSI1mF/s5vZI3EJTsZSYgfew1Pow6Pthgtc9xAVHMJ8KbWLSfq6qknuSnCppBPc4f8eicLq27vCRQr3uHk1clsQzx5o/u1DL8CsudTbmeylqIF0dByLdWU3YGBbWXwMMiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fE9C7k5bttQZKYHV68a3Kuybdkf5hfuGUoqB91SVnU=;
 b=bqV1cKb+rLuUUtQjb/yktuhcT1tJmx6y6Q9v9nZk7yIjnCAEzyck0EBtUZukDraTzu/in/N4LwtbMj8vD2P0AAOYNsf0/7Wo2iognDMneC1N6Sx8SDYd2H35YCqX3gY6omFyciEEOUwU0qnvCM+8MJ2w1Rvzi2WrG7JFEMvV97w=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DM6PR11MB4707.namprd11.prod.outlook.com
 (2603:10b6:5:2a6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 00:02:08 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 00:02:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH 3/7] coco/tdx-host: Exchange SPDM messages through DOE
Thread-Topic: [RFC PATCH 3/7] coco/tdx-host: Exchange SPDM messages through
 DOE
Thread-Index: AQHddbsG4n2S6MqLX0m4Tb4pbEPdr7c8YqCA
Date: Tue, 24 Nov 2026 00:02:08 +0000
Message-ID: <4f832b3a73bfd4d9b74e5e68a08f0de5659e1b6a.camel@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
	 <20261116111037.3478844-4-chao.gao@intel.com>
In-Reply-To: <20261116111037.3478844-4-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DM6PR11MB4707:EE_
x-ms-office365-filtering-correlation-id: 4b308632-c01a-489a-d4da-08df49be2e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|4143699003|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: 0XSxyVOVcM3c2FC8EL9TBr8UyN+AyvA+h503zw5khk5all7ovcky0OSDIVouE0sPANWsX9rUgA4MgC7ppssgAD/H2Ru09feVcU0x/u2fPtpMQxTH23VQ0doBP5OKrq5Ac8uD1WBABgk95z7VQgcNcNDQz9vHZZkCB7pZVKhGFKNeaPnuECow3mfxvFhgN0om8d9OeSpl++RombwZX8PjofFn/d0JbLsJ/aCUdmjH+Bz8tXnsFxwhuAIS9lMM74OknaBUlEN9IU/AL31eu+H7phBU+eMg1ghJgE+aCQtffZ8+YCeoKPaGI6IgfY9ie4TcT9eRGswVZkMqTkIKfxYcGaANkXzHGe+9fEP7tBEKlt654inum02BswDjjIG0GaqjZUFILiOMvPR89zy/UocOemRU9MXc72vsUhwdEKdZGSKl0xlxX+WmBrOAkK5OaLKf25aG0twvlKh+6rvnKJObIHxPDV6Qez4X31pt6VSz4b2FjDjR59i023qJveTp5tcL4qw3ReCIZ7PSs3LxsG9ICKZSLV4XEPklexMv12B1xXzBDWLr0hNbHDP2u2sGRTbJHZQURdLfjWvHVNZe5yolGqIELAXlYAbwn8+4D93bjOo6+89Gu3qMbZYaEgYMxmxxIlN0wEG2cB28hOz/AmBvXaA6GxC8lfbDJl9vTgSW9U1MplHfh/gDHYIPo9f+kxePkZhppgKbMMfi2g4xCZLicV0H7ZkV5ZKx+E1l8xM+MQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVVVTFdZTjlzUFAzaDQ5NUJYQXQ4ZlNhSXJYTWxYdVBtSFBBWm1ldVlqeEls?=
 =?utf-8?B?UHB1Tlk5aUwrYzE1eGhXN0FVOU93azAwaU9ERmU4Z2toQStIQmU3a2xTb3Fr?=
 =?utf-8?B?aS9tNTZSUWxxWUxWQ2FhTWFJZWx3YkgrQUdFVnUwTnBWWXUvVU1TSkRNdy8y?=
 =?utf-8?B?b0VkMm1oSVd3MGtvb3ZKSGZCMkYyM2p3TUNhODBxcFd2RGk1QnRDNFpzUEY1?=
 =?utf-8?B?YzI2R0hnWnJpc2tSNmxKZFhodE9uT0Z1WTNkQ1lsdVdNMndZMGhwN2JiaHRX?=
 =?utf-8?B?b0gzM3kzdFRrTG5nS3kvR09IbEhaRWJvU3NuOGJ0UVBkR2dJck93aFhidjdi?=
 =?utf-8?B?bGtZOHNraGwxNnR3cU9aYlJwa0ljVFo5MDZ4V0E0bkdrZzBNQVc3SVpxUmY0?=
 =?utf-8?B?MzVYNWVZcXlIZFJ2RGh4ckQzV1gyQkljdWE5MmdSUzRKakJuVEIzNXZ4QnYz?=
 =?utf-8?B?a0pzdmhHSEhTNnlCZFNYN25aRHd5eU1PQkpIVjVmMlpDTlVsOEVyUHR4Q1NO?=
 =?utf-8?B?OVJNTG1JcktScHdLVVZQWDQvNlFITVIybm4vMERDRlhsV1RPaUdSNVNOWktH?=
 =?utf-8?B?NlpLSTRTWlA0YVB4ZVFwRW9LOGVteGplUnJBNGNsWllNVUs4K01TS3Z6M3Vi?=
 =?utf-8?B?eW1WbW1zKzJQSUdLK0lrN0lNdzFQa1EyN3NJb3kvSUduVWpVYkY2RXJyTFhj?=
 =?utf-8?B?TGJJaG9DUE9jZEEya2c5dFI4QVNmUFZmYkE5NXdJQWQ3alFiMEZzelZUNWlV?=
 =?utf-8?B?cVpaQ3BNWXpHU2I5RFYxWVYzY09RckdnVFdEZ09VZGpnZ3hua3RJY2RNRTRi?=
 =?utf-8?B?bVNrckVvaWtBay9wak5jUVRQM2Y5a0ZEb1dlcGxJMjRCcHdGYTlZTmdsMnpV?=
 =?utf-8?B?NE9ob2N0cDh0cys4UXB2VHJlUFVKOENkTE40VE9pL2hxY1E3ZXRaVTYvTjI2?=
 =?utf-8?B?bXJsVDhHV0h3Q1puS0g2VU1GUlBEdFFjVUo0RmVTdHlKY0lZR1VGZjdOUTFz?=
 =?utf-8?B?cCtobW96dEFpa1dSaFlHd21xRmRkbkUrc1pNMWg2ekRVMjFxUjczV1VMTlZw?=
 =?utf-8?B?NUdpbE9hTXp3cS9heE1BQWpGZS94UnVRMkhHVzRCNmJUQUh6M3NPYWViL0ly?=
 =?utf-8?B?SFo5RyswUExqQkNOUmp4WE9iQldRVCtzVTJOenZDRUlXT2oxWVlwZ0Y5Sngv?=
 =?utf-8?B?bjFXNXVzSTVoMUN5WThFWE1LTTkrTHBqenR4U28yMHFUSG1YcWJ2T2dtNnZF?=
 =?utf-8?B?R1BBZjFucThNVyt5em1XTUZIWGVOcGNUdWZRSm5xS3VQdldnUFF0U2xKTE5L?=
 =?utf-8?B?SE9FYjFQemhibkhZV1BXUklESDExT0JNZ0xCWFpzOUpINHpLdEp5eDUzZ3g2?=
 =?utf-8?B?cG52UXdGZWdzL2NQWWJvYXNkeHg5UkdSMjE2Z3VHUktIbEI0MDNBUGVoNkhD?=
 =?utf-8?B?S1BQcmlKOXM2OXhTMXJWcFgrNFBodTB3Nk5VZzc2Y1pBWjZRc1RxdUlZZVlK?=
 =?utf-8?B?RDVEVWY3b05Rdk05N2M4R1pkSGJKUGlBcXZLY21hb1ZBNjN1YkNqcnphNXE1?=
 =?utf-8?B?RUl6TnJTaFo4TFk5Ynl6bjdVNW5jZ3BjTVpHZ2FHcUVOM21aWXA3ZGVUWGZC?=
 =?utf-8?B?T1Q3ekEwazhVTFhjUjY0R09ES3Q5bFZpQytrYnY0S0NORy9kUHQvaFdBU0NE?=
 =?utf-8?B?SlZsdlBQY0huNGZjVmg0WDBEOTdwMjFpeEhqSDd6eU92RzlDRWk0bmFpaS9y?=
 =?utf-8?B?L1Zmc3hyM3N5OHYrdWRSSDdqTTNSZ0xmWGl2dEU5dFk4UG1VaXMycHc4K1Bt?=
 =?utf-8?B?aU43ZTVuVVVNQkE0V0ZUMUFLZC9SUllqSiszVC9VWlZJbm90V3E5NGU1MnFO?=
 =?utf-8?B?L09BNE1pTUwwM2V4UmhIM2xYZWhTTFJ6Q2owdm9rc3l2VE56WHA4MHpYTi9j?=
 =?utf-8?B?MFNrNnIyMnBObDZpSTlQWFhveXI5S2VFcHFCTkxiV2xPVHowbTdBaExSWGhC?=
 =?utf-8?B?aGdySGRPdmlsUXI3TUd6NUhMZ0loeEZrd2I0WkxYQnRxN3ZTRU55b3dGRjhs?=
 =?utf-8?B?RTBDZUk4VHBTcTRvS2lrdUVNOWpJVWRhY0o5K0FObUI5TXlXQ3NjbHA3RGpk?=
 =?utf-8?B?SHdFN3RmR1JPalJqcGIyZE5ES3NnczJXY0xTV1NxSXYvZUU0ZDR6V0MwTHFK?=
 =?utf-8?B?ZGd1aGVnOWYrUFlPdHFoUis4M2xPbUdmMG1YSFRKZ0VZUDFaTU5mcGV1WTRp?=
 =?utf-8?B?cnVycjgza3ZkOEZORkZlbTU2L0RnblNkREVobFdMSkNSUmxEdnIyOGl2QmtW?=
 =?utf-8?B?L0p2eWR6dlJhRzlSOEVnU25LYnAzUCtscVFIQ1Vhc1BoMS8zVzNtV1JHZjM1?=
 =?utf-8?Q?AUCJOkhqgTgn9tNY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A88F31A679426478B916526448577C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M7M8x7V6irU0Vi5Jx9aRBvjTBHCenQMsR/Sdb9VjurA6BNcBNRQ+HPKGhp6NEgM0WRGkbzNBTd8bk8OTWO6ZslEaRiEgJaL8r3eSR8AGjWBEhmw7zUsI2jfY0l5yJb6pQoi9fADI2fKX2zyE1PIKje4QEX6lLdBnMqrMGKnscOa3ZcOawuAw375KaqpKa9e9NXILlvYte7kWTSg/+3P26/+ANFK+W5pv09g8tNMepnrYDEcTXnjqU2TmlGiOOKXYOtNQLAdI6CuO4mSWfoOHBgD9PpP1zVVUiE4oS79cht1qIiPMn2XaUw2gDUqnQYEj30AkrrDeyaN6q+ySKTiK6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b308632-c01a-489a-d4da-08df49be2e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 00:02:08.1341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DR7l2PLHkAsDC/biYQe3cb9uDznfgQzY0uiJSQ2VaoRDA3r6Y0dKzz3+qUaC4XFgY/B1vM9h6UpD9Ksr/8vR6NBxAR2w/a18w4nTqvZKrI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTExLTE2IGF0IDAzOjEwIC0wODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gK3N0
cnVjdCBwY2lfZG9lX2hlYWRlciB7DQo+ICsJdTE2IHZlbmRvcjsNCj4gKwl1OCB0eXBlOw0KPiAr
CXU4IHJzdmQwOw0KPiArCXUzMiBsZW5ndGg6IDE4OyAvKiBpbiBEV09SRHMgKi8NCj4gKwl1MzIg
cnN2ZDE6IDE0Ow0KPiArfSBfX3BhY2tlZDsNCj4gKw0KPiArc3RydWN0IHBjaV9kb2VfbXNnIHsN
Cj4gKwlzdHJ1Y3QgcGNpX2RvZV9oZWFkZXIgaGVhZGVyOw0KPiArCXU4IHBheWxvYWRbXTsNCj4g
K30gX19wYWNrZWQ7DQoNCllvdSBtZW50aW9uZWQgRE9FIHJlYnVpbGRzIHRoZSBoZWFkZXIuIEl0
IGxvb2tzIGxpa2UgaXQgZG9lc24ndCBoYXZlIHN0cnVjdHMNCmxpa2UgdGhlc2UgYmVjYXVzZSBp
dCB1c2VzIEZJRUxEX1BSRVAgd2l0aCBtYXNrcy4gU28gdGhlbiB3ZSBqdXN0IGhhdmUgZHVwbGlj
YXRlDQpkZWZpbml0aW9ucyBvZiB0aGUgZm9ybWF0LiBVZ2guDQoNCj4gKw0KPiArLyoNCj4gKyAq
IFRoZSBURFggbW9kdWxlIHByb2R1Y2VzIGFuZCBjb25zdW1lcyBjb21wbGV0ZSBET0UgZGF0YSBv
YmplY3RzLCBidXQNCj4gKyAqIHBjaV9kb2UoKSB0YWtlcyBvbmx5IHRoZSBwYXlsb2FkIGFuZCBi
dWlsZHMgdGhlIGhlYWRlciBpdHNlbGYuIFN0cmlwDQo+ICsgKiB0aGUgaGVhZGVyIGZyb20gdGhl
IHJlcXVlc3QgYW5kIHJlYnVpbGQgaXQgZm9yIHRoZSByZXNwb25zZS4NCj4gKyAqLw0KPiDCoHN0
YXRpYyBpbnQgdGR4X3NwZG1fbXNnX2V4Y2hhbmdlKHN0cnVjdCB0ZHhfdHNtX2xpbmsgKnRsaW5r
KQ0KPiDCoHsNCj4gLQkvKiBUT0RPOiBpbXBsZW1lbnQgdGhlIFBDSSBET0UgdHJhbnNmZXIgKi8N
Cj4gKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRsaW5rLT5wY2kuYmFzZV90c20ucGRldjsNCj4g
KwlzdHJ1Y3QgcGNpX2RvZV9tc2cgKnJlccKgID0gcGFnZV9hZGRyZXNzKHRsaW5rLT5vdXRfbXNn
KTsNCj4gKwlzdHJ1Y3QgcGNpX2RvZV9tc2cgKnJlc3AgPSBwYWdlX2FkZHJlc3ModGxpbmstPmlu
X21zZyk7DQo+ICsNCj4gKwlzaXplX3QgcmVxX3N6CQk9IHJlcS0+aGVhZGVyLmxlbmd0aCAqIHNp
emVvZih1MzIpOw0KPiArCXNpemVfdCByZXNwX3N6CQk9IFBBR0VfU0laRTsNCj4gKw0KPiArCXNp
emVfdCByZXFfcGF5bG9hZF9zegk9IHJlcV9zesKgIC0gc2l6ZW9mKHN0cnVjdCBwY2lfZG9lX2hl
YWRlcik7DQo+ICsJc2l6ZV90IHJlc3BfcGF5bG9hZF9zegk9IHJlc3Bfc3ogLSBzaXplb2Yoc3Ry
dWN0IHBjaV9kb2VfaGVhZGVyKTsNCj4gKw0KPiArCXZvaWQgKnJlc3BfcGF5bG9hZF9hZGRyCT0g
cmVzcC0+cGF5bG9hZDsNCj4gKwl2b2lkICpyZXFfcGF5bG9hZF9hZGRyCT0gcmVxLT5wYXlsb2Fk
Ow0KPiArDQo+ICsJdTggdHlwZSA9IHJlcS0+aGVhZGVyLnR5cGU7DQo+ICsNCj4gKwlpbnQgcmV0
Ow0KDQpZZWEsIHRoaXMgaXMganVzdCByZWFsbHkgdW5mb3J0dW5hdGUgbGlrZSB5b3UgcG9pbnRl
ZCBpbiB0aGUgY292ZXJsZXR0ZXIuIFdlDQp1bndyYXAgdGhlIGhlYWRlciB1c2luZyBhbGwgb2Yg
dGhpcyBndW5rIHRvIHBhc3MgaXQgdGhyb3VnaCBhbmQgdGhlbiByZWJ1aWxkIHRoZQ0KaGVhZGVy
IG9uIHRoZSBvdGhlciBzaWRlLg0KDQpyZXNwX3BheWxvYWRfYWRkciwgYW5kIHJlcV9wYXlsb2Fk
X2FkZHIgc2VlbSB1bm5lY2Vzc2FyeS4gSXQncyBub3QgYW55IHNob3J0ZXINCmluIHRoZSBmdW5j
dGlvbiBvdmVyIGNhc2luZyB0byAodm9pZCAqKS4NCg0KPiArDQo+ICsJcmV0ID0gcGNpX3RzbV9k
b2VfdHJhbnNmZXIocGRldiwgdHlwZSwNCj4gKwkJCQnCoMKgIHJlcV9wYXlsb2FkX2FkZHIsIHJl
cV9wYXlsb2FkX3N6LA0KPiArCQkJCcKgwqAgcmVzcF9wYXlsb2FkX2FkZHIsIHJlc3BfcGF5bG9h
ZF9zeik7DQo+ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJcGNpX2VycihwZGV2LCAic3BkbSBtc2cg
ZXhjaGFuZ2UgZmFpbCAlZFxuIiwgcmV0KTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsN
Cj4gKwlyZXNwLT5oZWFkZXIudmVuZG9yID0gUENJX1ZFTkRPUl9JRF9QQ0lfU0lHOw0KPiArCXJl
c3AtPmhlYWRlci50eXBlID0gdHlwZTsNCj4gKwlyZXNwLT5oZWFkZXIubGVuZ3RoID0gKHJldCAr
IHNpemVvZihzdHJ1Y3QgcGNpX2RvZV9oZWFkZXIpKSAvIHNpemVvZih1MzIpOw0KPiArDQo+IMKg
CXJldHVybiAwOw0KPiDCoH0NCj4gwqANCg0K
