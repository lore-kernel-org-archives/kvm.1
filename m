Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E273921DC;
	Fri, 10 Apr 2026 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865491; cv=fail; b=JDlX5SlXI2SzQ0J7A7rqHxW0vMwfvE9jSYQKMElEHgZ+IkweV0WWr3/LIozKKOm9XtzlIgmYnEQ1OKJjF2lcmJmj2pooSYz7ebETnpkbcyNiWm22iJG0hqMqmlQkb/B0KgM2jY5rxpXdkvbbCEITriZXYLK64Yh62ntTBNaZpCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865491; c=relaxed/simple;
	bh=Ro4AYqET+XTtStpRY+7tF9O07IUtiih1NdeRDKF9Neo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D2Nmwn70M3dnrvk026568eTkskKjVX3MSEdZvIJ18DOiZLD6JieFO5ibC6c7u2W0EjQSBGsyEoxKF7AXJlJjQfgBQsGy4ftQAOFRWIdNa3jmX9laaWNgUpUMD4x6/d2R2sP4rrpK3LnGDgrDk1SnewDFbbp96o526jHy1XhGrPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oK6gzFmX; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oK6gzFmX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775865490; x=1807401490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ro4AYqET+XTtStpRY+7tF9O07IUtiih1NdeRDKF9Neo=;
  b=oK6gzFmX2j4tUrS2VEw92Wz0IUJtZxXTh+9VHZHgaEeVYPM3Z/0SjcGG
   +fD9J8/tFSShKZjqRp4IjQBpgOEox1SceUS6rEr11wynN4NQPdSM0kbkO
   mh/Z4085pat8HkhtRVjl3rUtka/76GQD3XYMJjLaaCH5eHwXW78loe/6F
   iWES6Qvx7vy+n/W/49AT/17NnKdabwkCPNdDV6JpOrVvQVDESJdJU4p26
   WU8uHTZNyucSjXIjtZRAAlpP0LDhSiewy6qPf3li110sBEkZL0jaTPB3E
   +D4UIk1EKC0d8ZKUI/XWIJmOPtkQ2MDgRADj6WBYRDfwJx9SIAXlAuBl8
   w==;
X-CSE-ConnectionGUID: 1Ep2Z5VaSgeUjaBvZntZKw==
X-CSE-MsgGUID: qR4mtfSDQyieTeFb8yCu5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="87182842"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="87182842"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 16:58:09 -0700
X-CSE-ConnectionGUID: O9VgjByfQBOzbe63COrLaw==
X-CSE-MsgGUID: bFMUffS/QqS59pRmOaJtvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="228385023"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 16:58:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 16:58:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 16:58:09 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 16:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV7UJaAt2azXnFNmZC6pbbB3eisfZH49i/+oVANq49WdAp4Yy08pCrAoZQ1ucXn4esO9vrovY6wNzC/QMKhvGrtOuR2elVXfjQa7QGqpDNS70rp/WAlKhnhTUn6JvW3qwUMNX/70pwTtssHOtmyoaYntYPRTZke5Tk/PY2RYeSaeHfSTeH5XpQ60jVmoVmHCUbZ8JydxErIchq6TYXju1Df052gZ/zB/YDG7xuHZqsBgSw667oWvUqrhM8HlTDVpNC/SFuNN9D5lZ2te4il87tOWQar4T+HfVMoK7cBfEmD/MtrA/Xj6YZnIIY6Let1Rn2K1tLN1lfcSHV4Mde9YaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ro4AYqET+XTtStpRY+7tF9O07IUtiih1NdeRDKF9Neo=;
 b=oYiurJg9C9MVQL0xnp546hoqvM3/Sk4VofX4h+/8eTDveT0ZsfoW+3oV11RpiIWhlZbkxCtSDjc6ZMALa+AS2jyT2V4Tj4EhAZgfeBjZHWPJJa/xLoUx0SyfdiiJE8pPRe0kWgmfcLPpURYn24BWCb2QkvsOyuYr9fbe/UOElajxKaFV/7H1zinahESWwvnR3ynOVOFhSVLuTNuUYNSxhgNcHJKY7DXhU8D8GeKPoEVqu/9ofb4UK2wtzZPUbNumhoVl6ewhbjdfVsTxdIFfKCZ2Rlnq2OmX4PmpslpKlzsGrR3kDSemOld0zK3eUjLsQKQPJvFmQArdWam9tfuw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 23:58:02 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Fri, 10 Apr 2026
 23:58:02 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
CC: "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"clrkwllms@kernel.org" <clrkwllms@kernel.org>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
Thread-Topic: [PATCH v7 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
Thread-Index: AQHcwQv7he4MAKeojU+4cC0H3IpBcrXZCaGA
Date: Fri, 10 Apr 2026 23:58:02 +0000
Message-ID: <5d7add69eb3103e3e45460e5b38d5423703d443b.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-5-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-5-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB5200:EE_
x-ms-office365-filtering-correlation-id: cd69dd9e-a6bd-4f4a-79d9-08de975d0043
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: Qs8QwKPw/bGqTszSIe3m3lCHCk7t84Rrqw4MimWqM9bEyZwQpkouxA0m5+LhILeQWN8Shfs0tKamRGAde1DhaQeOiFh9X7IGKmoXXa8vGi/bfIaqanuHuo4s26xQjgskqISMAS4L/DSR2GRjVTvENWKM4DvW2fxPJ16wa7UBAZhE9zXQT/N06he/Rkmw3rfbuPUo2zktrTd/PkVWKPAQ0dgm9AUVqeJ6OcAPpftbyWmt36M8qRhKGC738d4ey8SiJXnwT1dUaZVD9NFkA1xralEi1tFy9BgpeTdutjVaMmD8lWKQcinaFLi5Tg9OTud7w8rGiMqo9FaZPFcNTiOlNC0NfQGGRlzrVErJv6eqFyefQd3KxQy1Q3BEUEtwKp4vOMyrDDeUnxoSIv35UDOF0NiyTnzb0QNO5vL7XXfvKh7gztdWyOLn5sOVEJfA8osblGWi7f3/9rdgHQhi6akGmVwghz7krI50vxTsXLGabRFGMa16PJevzaqsm0F4DMbLod07uD/eQ+ko6SEIWXpDKQfeUONWOa/s7OpWtfdDOhGLxFnRjEmJOiFokc+JvCAVvu/1oAzPUIrulmK/ViKQMJfo/URfl6QxprvNXFfILOn6487YJHoLmW1Cx9oTsOwHWLsXGBaRomJtaO1tp3M7HuZQktEssphOXDygo2sxwpxYrV2zXgTJc6qUae3tDhkfbPu0devo/VBo2j2XvYH0TCXOc+oUNfvdyl1+6p8p1WEngLOGLgvevW/LGymI2Gk1OXUSGU7RexOQvLAv/Xl9OSq6j/hjA/jH4SLuSJi006o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2NrRmtLTktTakZnYzM1TWlwVEFROERncXZGQWJnVWFBZmZKN0RmQit2cjFv?=
 =?utf-8?B?ODlBd3lQQ2VydXBMK1l0TEFNTTliWmp1dzhoa2NWUXo3VjBJZ0ZmVGdVYlVy?=
 =?utf-8?B?eXQ1T1I0TU53alZ6dm4vR2dQYkNvRmI2TmNyTDhFRDlITFRkdGhxUWdXbDdx?=
 =?utf-8?B?cG8xOHhhY2ovN1IwMVl5SjBkMjk1bW1xejRRRTR1c2xEZWdnQ3UwTnhCQ1hi?=
 =?utf-8?B?SmZSbWJnL0srVC9BUk1sOXoxaWVkMWdZK3Rzd3Fra0wxRmFTNFo1WjYwM2NW?=
 =?utf-8?B?M0hzanRtdk5jQ0xkcGhEUVFTMXZ1T2o3bHRiVkJNcjNGZTkxK1RPQngrZW1k?=
 =?utf-8?B?L2dUTW5STmRlWGtWSnZzNVNsSWJkMDdiOG9aaFVFbitodi85Z2RXL29wMHdm?=
 =?utf-8?B?SUNqNWwxQjlnY0t6Yy9XTUg4L2d1RDFIaEZzVUFYVFpVWlQxSlhweE5ONlBu?=
 =?utf-8?B?b0ZqTGtsSThkSldzY2NHRDBJcUhUSnFGdXZJUEhSRHlFZWFkdEZjdjR1M0Jo?=
 =?utf-8?B?NnVjN1dzUUlGd3dUTU5GV0JkaDBONWVCSHFHR1hqUjVDbEFXOUx4Sk4veWRJ?=
 =?utf-8?B?bG5MVEFETEE5cHBJUXlPUUZIVTEzU1d1Ly9wbjk2UEJTaUJNUi8rekNVUUtP?=
 =?utf-8?B?azNvVWZTVFJKTzRIVTZENDYrZ3lQdHRrV1drZVlwd0dLc3FoNjlWY1dONzhK?=
 =?utf-8?B?VUttbkJaNFdITHJ0YnZDRnZuUnc4aXhTdEw4dGdyVGJNQzE1OWVyeFB5QXUz?=
 =?utf-8?B?Y3Z3QXpJQ1FuVUhrL0QrWGo3UjZiRnZXYkYxYkh1NmhXbzdpRXU5MEFvanNa?=
 =?utf-8?B?OHYzWHQ2cG5WdkFuT1hVRGpTRGhCQjdoZWYzVTZNTVdqa3pYOE9UWWZhRDJG?=
 =?utf-8?B?NFdTcXlqZURRZlhUL3N2dWM1TkhLUngrSE1MelhIejJ6bms5T25FY0lKMHZI?=
 =?utf-8?B?NkhYNG9IVTFOb0E5N3lLR1pVNFBIK0xGN21kb0pFRlBxNU1jb1dvUVA0V29U?=
 =?utf-8?B?RmE3akJLTTVGaXJ0NElCNWlzVnRvcmdSMnFJaHBLV1hFMXN2ZDhsd3JUbU5G?=
 =?utf-8?B?alR3RTBqeElXblFKbUhFOGE2ak9mTU9PZlY1dWV5cTdyRWFGQ09BWkROS2F2?=
 =?utf-8?B?dWJEbHBlVTJrMTlGdkxRc3lQdzdZYmJZTHNQOGg3RW9xOU9oempGdVNsUjFo?=
 =?utf-8?B?eElzUi9QTU1FM25JQXM2dG9UbllsaTBJdnJPOElsM1ZPdG1qYkxhdTZLTmVk?=
 =?utf-8?B?RHZ0VkJPQklvSDloVjlBcC9iM3J5Sy9QNjFHQmFReHdpTGsvcm1MdVV2R3du?=
 =?utf-8?B?QzdpaGJPZ2Q2bjF0bzVHeWJZN3lPOWZXbk9TQXlVRkdlcDVkRlQvRnBGNFdR?=
 =?utf-8?B?b2xlU2tqUEIrUmpQTytVT2N3bFh4SDZGWEJlLytyYjE3TVoxUGJlOXoxcndG?=
 =?utf-8?B?WVFwVi9maXlabklENks1dUIrU20vQVVZQkk5a0ZUbVgrd04xc2lHcmNjcEdw?=
 =?utf-8?B?Si9WOFd6QzBoOGlFNCtTQ3ZmYkxnV28rZ3JhU0VmRVVyT2lKbEtyU2x4SFNJ?=
 =?utf-8?B?eXVNSTVsbUhvMTBpMTQ3c3pJY1RESkhsY0c3REhIM1dITXNTd2drTHlGMG5S?=
 =?utf-8?B?Mjd5OHhnalduVWtUYVdlVnBGWnhnMWhXdW9KOEF0NWJ0aHZLSG9KdXNwWmJ3?=
 =?utf-8?B?aVphVWxkbkZyT050WkVGVkszT0F5UXlvTU5UOTdBLzVqMHJ5aVEvMXFQVkFp?=
 =?utf-8?B?L3c2bXRuYitzdXhJK2hWa0FranBrZjJkWkFqQUU2K09vNTY4aW1QMHNXaEln?=
 =?utf-8?B?bXIyMVVaR2RVYmtlL1B5MDdvczZkMmRFWVY5V1JESDJwR1RHWmlSS3ZZTE12?=
 =?utf-8?B?N25wNmVGRjNEUFRyWDlJd2YwMTdqNnVXNzZ0OVEzOHhNZU0yMUNUNHd3eFl5?=
 =?utf-8?B?NER0M0lOUFZEeFpJUWJkOGtYeWdoK3BaOW16ZXA1VXlLdU82WGx0ZC9CS3Fo?=
 =?utf-8?B?cllzbncvRFBpaWZyZjVzTVVxUEtmaFVDZGEybDNpUUZZZ0tzc1dHUUhUYlh6?=
 =?utf-8?B?NWVCVmNqUXRvWTVtdVp5L1FBQk03T2dLTnQ3Mk9PZkRCZnY3SGYrZjRVeHVT?=
 =?utf-8?B?d2VKVHE1OWJuRXFYN2g4NEJxRXlGV2s5akhpa21EdFdNQUNRbmVubWp2OUhU?=
 =?utf-8?B?Z1o1UlAvaGNHTzFlTjJwRHBralZJVVkwRnAzTjdaOG9pamdHVU0waUlzSkh0?=
 =?utf-8?B?VVQ4cGFDRFhVRVR5NUZqdGliaHpQZFZ5QzZKWFphSVVSbCszZXFTQWljdjhP?=
 =?utf-8?B?amd3cVArNjdtSDJHbHZLR2ZoVUtUYUJNWGoyV3pJaDQ2cGVMVHA4OW1hODIr?=
 =?utf-8?Q?h9NgJDBiqfXhdplo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB77DB4EDCD51543AEBF235A0C32F8DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r5+MY+D2/cp027/Gc9ZkQX8xREuMMNJb/ihHtSIZ6oD/2jCcZzHXb8tjOjC2O02PaVGXKPJw3Jw7GMotlM219cYEMxgIGAi0XqpgYG81MBe1tYocrXJVXre2aEUbd0zPkZPnNn4VJ+V6zNRRrhUv9gSwQCcsoy+6tzmp4zk/9NWmtkQ5LLSJescUNedbt3sdN2JOXRKHosytNdc/5dIsO8GOhuSOxejnHdP9xWMd2biHsNaTFboQ9gZqkoKlp98ypiz8LHLiQOV4BRVuo2RjjiucCpBmTVWhmWERSaTjRTGsoOVCplDv5h+D8w5JJsGizTzLVeW1AHTbPZAfurtROg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd69dd9e-a6bd-4f4a-79d9-08de975d0043
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 23:58:02.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBcyjTIg64IimBL7gTZ3D5TUUD2FMMy89A0C2CDP0xmkobqez3YVkY9SI8YkkwyHVldbOK6h1NRF/2Nw2ZHRk2HkIOEW0DG05mCCbHc1mJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IFREWCBhcmNoaXRlY3R1cmUgdXNlcyB0aGUgIlNFQU1DQUxMIiBpbnN0cnVjdGlvbiB0byBjb21t
dW5pY2F0ZSB3aXRoDQo+IFNFQU0gbW9kZSBzb2Z0d2FyZS4gUmlnaHQgbm93LCB0aGUgb25seSBT
RUFNIG1vZGUgc29mdHdhcmUgdGhhdCB0aGUga2VybmVsDQo+IGNvbW11bmljYXRlcyB3aXRoIGlz
IHRoZSBURFggbW9kdWxlLiBCdXQsIHRoZXJlIGlzIGFjdHVhbGx5IGFub3RoZXINCj4gY29tcG9u
ZW50IHRoYXQgcnVucyBpbiBTRUFNIG1vZGUgYnV0IGl0IGlzIHNlcGFyYXRlIGZyb20gdGhlIFRE
WCBtb2R1bGU6DQo+IHRoZSBwZXJzaXN0ZW50IFNFQU0gbG9hZGVyIG9yICJQLVNFQU1MRFIiLiBS
aWdodCBub3csIHRoZSBvbmx5IGNvbXBvbmVudA0KPiB0aGF0IGNvbW11bmljYXRlcyB3aXRoIGl0
IGlzIHRoZSBCSU9TIHdoaWNoIGxvYWRzIHRoZSBURFggbW9kdWxlIGl0c2VsZiBhdA0KPiBib290
LiBCdXQsIHRvIHN1cHBvcnQgdXBkYXRpbmcgdGhlIFREWCBtb2R1bGUsIHRoZSBrZXJuZWwgbm93
IG5lZWRzIHRvIGJlDQo+IGFibGUgdG8gdGFsayB0byBpdC4NCj4gDQo+IFAtU0VBTUxEUiBTRUFN
Q0FMTHMgZGlmZmVyIGZyb20gVERYIG1vZHVsZSBTRUFNQ0FMTHMgaW4gYXJlYXMgc3VjaCBhcw0K
PiBjb25jdXJyZW5jeSByZXF1aXJlbWVudHMuIEFkZCBhIFAtU0VBTUxEUiB3cmFwcGVyIHRvIGhh
bmRsZSB0aGVzZQ0KPiBkaWZmZXJlbmNlcyBhbmQgcHJlcGFyZSBmb3IgaW1wbGVtZW50aW5nIGNv
bmNyZXRlIGZ1bmN0aW9ucy4NCj4gDQo+IFVzZSBzZWFtY2FsbF9wcmVycigpIChub3QgJ19yZXQn
KSBiZWNhdXNlIGN1cnJlbnQgUC1TRUFNTERSIGNhbGxzIGRvIG5vdA0KPiB1c2UgYW55IG91dHB1
dCByZWdpc3RlcnMgb3RoZXIgdGhhbiBSQVguDQo+IA0KPiBOb3RlIHRoYXQgdW5saWtlIFAtU0VB
TUxEUiwgdGhlcmUgaXMgYWxzbyBhIG5vbi1wZXJzaXN0ZW50IFNFQU0gbG9hZGVyDQo+ICgiTlAt
U0VBTUxEUiIpLiBUaGlzIGlzIGFuIGF1dGhlbnRpY2F0ZWQgY29kZSBtb2R1bGUgKEFDTSkgdGhh
dCBpcyBub3QNCj4gY2FsbGFibGUgYXQgcnVudGltZS4gT25seSBCSU9TIGxhdW5jaGVzIGl0IHRv
IGxvYWQgUC1TRUFNTERSIGF0IGJvb3Q7DQo+IHRoZSBrZXJuZWwgZG9lcyBub3QgbmVlZCB0byBp
bnRlcmFjdCB3aXRoIGl0IGZvciBydW50aW1lIHVwZGF0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IENoYW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBCaW5iaW4gV3Ug
PGJpbmJpbi53dUBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGth
aS5odWFuZ0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBLaXJ5bCBTaHV0c2VtYXUgKE1ldGEp
IDxrYXNAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IFhpYW95YW8gTGkgPHhpYW95YW8ubGlA
aW50ZWwuY29tPg0KPiBMaW5rOiBodHRwczovL2NkcmR2Mi5pbnRlbC5jb20vdjEvZGwvZ2V0Q29u
dGVudC83MzM1ODLCoCMgWzFdDQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5w
LmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=
