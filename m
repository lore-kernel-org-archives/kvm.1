Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555035B633;
	Mon, 13 Apr 2026 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110654; cv=fail; b=Kr40ikw9BGpdD0J6K7wVHCazho+OjrZirwfmsGcHE51eCteYaLtq+cBiteUUAwvU5OF5enPI3FDh28ULTTfW8LQbW1aP+yRjsNz4ETdAwWOZBdNh3p7vFUYwd4d2CMrc6e+KSKncWZP4p4HAK3Wnbu62YdYYAB5SRlGocXiGsHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110654; c=relaxed/simple;
	bh=QWR1eMXm1tze6mvQzw6+CtX0shyI6+3IUx3e4i09Jwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J5ioIGucxEy2LrsCBrRNWzdW61yZRahiQu0o33uyL3e+gPVEWhAY4rOXz7RTU5Q0uHdEKRSifgeyw/7ZYGgI639366yMW780cXMy0Tlfuxpy2sCMUqOx5fxx0fIgibL0BSbdEOD2/V9Oy/iDQ8qd7Zp5YHdwm7tiC0Eyhx3Hd+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQwC7iBs; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQwC7iBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776110652; x=1807646652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QWR1eMXm1tze6mvQzw6+CtX0shyI6+3IUx3e4i09Jwg=;
  b=SQwC7iBso+9nm/37iQiAen/rPb13UpLT3h+MWAtjVNxil885sKCuKwh8
   jC7F8VRj4ssSDmCq5b1geTdurzImSWMhPS6tjz8q+YVSTcuElmp57tjVb
   MjQMZJssuZNgYMeL7r1LAbGO4b0WaxNW5zXiFMxNu4ka/pjZi8GIoIuOn
   9rn87erjriF3av9AeIXRNlYGx9cmLWLy1iXIEg++pPy9EO0ZbjsbmOmm6
   HxF8bT4xZ56L+DhuvpqqzCdQdj0CrT2DNa/mAuz+bkRZbSxbhBktwDStH
   BVoPM1JZFsWhp/hrx9JpMV1r+IMGOf2g6wIKQnBngIpaozSa2UytsXysk
   Q==;
X-CSE-ConnectionGUID: mv6wdk4CQXy4+A20q38bNw==
X-CSE-MsgGUID: elXeABB9TlGJ8Hg7MOtchg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="94454426"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="94454426"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 13:04:11 -0700
X-CSE-ConnectionGUID: 4lau6HYSR52g0UT4q4Gfkw==
X-CSE-MsgGUID: iQPzuGGeQ+eomABevUmq3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="234286072"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 13:04:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 13:04:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 13:04:10 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 13:04:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzMGdR5rOzCTf89k+lJywg9DOznGAtrdLZPs/am3zeVf28nZ5ln5S4GWtF0ptiuBJYhrEK7BH5gN3driEl6iLr5Nu7eqnqekZK82tbg8IsmfuG49B6OJhgkA5IeXcLt7NnrBnqC5aE9y3eLIuDdF/D/OIcrWKcx/kTPDZnd+UESDSefDVG3gZUF//BNlzfbcPTUA7W73h+yyS6RkQLl1+mPbRj2JjHI/3C5oKwqMcTXbfLvw77iFTR88KQ0IkFL+0dWhb91TjIymhkdPXfdXak9x2P/fCYQceC8EUcRrHceBfb2K0WSn9KKYYpQRRCvzR2GsUjGFO2Ill889bXFp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWR1eMXm1tze6mvQzw6+CtX0shyI6+3IUx3e4i09Jwg=;
 b=RkWd30rLw+sXKMgF5X+zq0H49XeDW2o2YCkHO4P8loFHlX6o6k+p8UTWD5iB6F6IkZJf8FL8CAJQGJFICc7T3OwzQ8/JWrBJ7wcvnxKC9yk4P+LECpBzVaINVpAK+DTj6X9QIq/twefhLg61pgGuc83qAz1/8f8A6DTryZ6xPLf26jx3Auu1TGe/tW81o4OAN5EAncBOBjHnmk5t4TCYOGq0LbjK99EQBv2wdQktf+VhqOH/0uiOoz3bhEcjJf9gwGhD38DnRWXf8A+2aevv5F8+B8q4zX01jCYDsXhaCcS3sE3NyQ8djJWWd6hceHoYXAzxhyUtOu+OzSlcLNvAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA4PR11MB9130.namprd11.prod.outlook.com (2603:10b6:208:56c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Mon, 13 Apr
 2026 20:04:05 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 20:04:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 22/22] x86/virt/seamldr: Log TDX module update failures
Thread-Topic: [PATCH v7 22/22] x86/virt/seamldr: Log TDX module update
 failures
Thread-Index: AQHcwQwLJaw4VKJe1Uar8HVQfCmNn7Xdf0IA
Date: Mon, 13 Apr 2026 20:04:05 +0000
Message-ID: <e4cdab7d83bfc1c7fe3b5759a987c71b922585b7.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-23-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-23-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA4PR11MB9130:EE_
x-ms-office365-filtering-correlation-id: 3b64aeb9-04e6-4c5a-db27-08de9997d0e2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ccwJ7j7qNL9Qz6dSjLMNBHw4hz9giIdONyA01So36Kut8eFwZchXwlWDs6kwT4mDjryViwdoGIyH7byl5v63wf7G10aV9MiX/EhhILANZoFocrmUyKzCXk3A/i8J2P3uDt+HOBcfEvIS77KNvn4h00Ad79YCW35yOTKWISG2Iv94ugd1DvdFEx8gP2YHrlIWL+Ol4KGAszSNvvl7rJKdwIpZqwUI/K+uGjgUe/0BjlWk1rNmdMKukhOyMfwF4sIln36gXLFa1odpAV/baZzab+zHbV5lvmR273LJ4fASuBumEkrOOC1Sc8Zu2n5gr337sPmlxo25umqI2Fs7aJapM7D3Fh20wEj1n6VYSYknmuXykIIomtRN4+goPR/hnLLEJoY758YHftdzvMiZVdTbFJW1aRcYM6Y8NbMJ3o4cBru+QeFVEg9RhGE74yM3ovOon/qkQZZ/CXvl4LnGkkGE7YZB1RAJli/5jFFsdfjSpEXEfKKRk0I9QgUSIHlZIKBnjD+eVLrhZuWOwhfqpIjNxDyicjrhck1UYbST0r6eYcO6xpgjERuBIPAua8YEi8sEphehm8MakpOSdoEIcqp1D0P/gub18DAsAWstbhcQioiHk5MACdxVH3wq0nkn9PI2lC2rqPTGVXYyjAyBlebCvMYYxGhZx+DaPtyN3TWnocIUBpdEEpf/nvdxvIZLHipVDj1aEnsWR/OtdvGWAYhg/hEkzKgPFW1XNlibNUs1UQxPmxdb2of1f6oVhqtTM3GgDdKcZKG8dKnX0F+YVoxloCq9WEssW7utoHAO89hVp5k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2I5VmZ0VzRhQXgvRDBtNk83RkFIeXR3Y1YxTjdlVUliQ1V1ZGF5aGNuTm1B?=
 =?utf-8?B?b1BIT0hGRm1yUWhFaDBvenpsaEdpM0ZCZTRjWWpyYUJVZExORkhTaGd4VTZl?=
 =?utf-8?B?TjJPQnZ4Q0tHbERUb3MrZnBVNHJNUU1naDJwQXRRNXdlWGh6aXFZck9yRHJu?=
 =?utf-8?B?QXp5Z05XM1REbWl2MTQvZDVMSUZvQThVMkVLWTViaWNPMjZURVdqZFA4NnBt?=
 =?utf-8?B?TnJZTmprUVU3eDcxS1BqSWpWQlE5WGQzZ3hEOW44Ujg1UWhLL204ajFhUCty?=
 =?utf-8?B?RlFMVXhCZFJScDBtVmlFNDJJNWhkRTRTWFNGbkpCQnE5QTVyR1R6M3Jtd3lm?=
 =?utf-8?B?YmFzaWZqT3pETXZJcHd4aEo4dlUvMzl5cHFsNXl0eVNXS0xmWlhrTEZBb2dz?=
 =?utf-8?B?MG1kUStvaFprcWVXQlBHSGRoSS9uUjNsVHg5MGI0YUlJLzRKcFQyaWI5WWhQ?=
 =?utf-8?B?d0FEWUJ5Q0dFSk9CN0hFMCtIbTB0NkVaUlcyZ0VwV2pTalNhTnRUU0lSc2Ew?=
 =?utf-8?B?TWZBemVqZ0F3YWtMOTJoaGVxTjA3R2lCL0kvZytvNGYya0t0VFREcDZRWHph?=
 =?utf-8?B?V1djblNSdzBtV0JtUUw0SkZKbUlLd2RkYXhHVy8yTmplamNpSEJrZnFHM3c1?=
 =?utf-8?B?eEwxdHNsRjF3a2hXS3J6WlFGakRsUFJlTmxOUnpzK3VNMTJqZzJaR3N4KzVK?=
 =?utf-8?B?OUZEeDlXRk84YTBWbVBaNEVTMmphYU10K0NTOGZQMlRBdENTckNrRlRZc28x?=
 =?utf-8?B?SnFTdjlBSVhSRlJhRVkvUGMycnVoTEZvR0xsUXFtUXdNclNZSEJxVnZSZXJS?=
 =?utf-8?B?TkRGSktUWnJSZHpvRjl1YjFQbEJvOW5XWi91OERhZU5PVkFLZHBKcEhvcW5L?=
 =?utf-8?B?dVhERk13NlNtMFUzMjJNQ0ttOElhdGRyQVBOWE5HRWhBTzY0MlVDSFZyR0lS?=
 =?utf-8?B?Qm5ZMElDRmF6SE5XM09oVzVFVng5bzNtUmFWUWNiajNGUmlmbE5nbXdqRnZU?=
 =?utf-8?B?ZndzeFFnZHlxRWFOZ1dWNVMzWXlIVWJXYjFzS1VkNm9ILzFtNXd4eUc5d0hu?=
 =?utf-8?B?Ritrb2VyazBla2tFVGRPd1F6MERUQW1jczlPNUJzSWg2ZzFNMWVXOTFIbVR0?=
 =?utf-8?B?dkErZm83bFROaWlSNHZEVWI0aytlMFJKbE9lYk5mWWVBMUlDdWFDTHFmY1Bn?=
 =?utf-8?B?WlpWRTR0RDJqaDJGSS9FY1Y5SDZGcnduMEx2ZlRtZlpLcmZHUGVvcnhIWVVD?=
 =?utf-8?B?cDZIZitBYUtqMS9jd0wvTnNzNkYvUDdMYkdQUUxraDdJV21LOGFvdFo2TVdv?=
 =?utf-8?B?QWZBWWw5dVFEYUtjd3h2aFFNekxobTNNK0VySFJYU0xoUmdDK1BZcU9xLzRi?=
 =?utf-8?B?L3RaSjVNMmRjeHdBOThNeVNLZjcwSnMyWllBWEJ4dUMrak16Q09odHU0Uy9F?=
 =?utf-8?B?YnRUVEhaVSsyb2lhL21hNTBHckV1U0VaM3JnQnAyMHJONGk3bm9SeFRWWlQ2?=
 =?utf-8?B?RFhwaTUyVDRqeXFndXVubmgvVjdxNDVSWlZFNlFjRlMyTXE3TDQ3U0JJVzVk?=
 =?utf-8?B?b212T1l3dTgveUk4TzA2Wmp4dXdoOVU0TFNzckp6TUNvTzdIcEJrb0E1a25a?=
 =?utf-8?B?S1B3d1VSRHhSa1I0YzBnSFBCZFVLUGtuM3g5RC9TaiszMFcvNHd0MEU3UGh3?=
 =?utf-8?B?czVIaVBNWEtMVEZOK2ljKzdHWiszbG44VXVZT1lCVm04VzFrYkpCYVovNkhr?=
 =?utf-8?B?WDNoZmdPbEo0ZTNXQXhnSmhsVEloMVRWS0NPeXZta283SXNKMFgxWFBKNlky?=
 =?utf-8?B?aHBFWXhPNzhXeXQxZUpLdnAvcENUaVdaYTJpcWRlUkR0U1RpZkRZaFRpbFBI?=
 =?utf-8?B?eVd5dkRvenNWbWR1bFQ2TmJYMzlPMEZFeUhGOVZZRktVNXI2aWRpV2UwODdn?=
 =?utf-8?B?emFPdTJCeVVZcGIwVWs3QUdlazNJVlc5TDA3V0VqTGxNTHk5NzRuZ2VGdCta?=
 =?utf-8?B?VVVPNGVwNDIxVE40S2hZQ3V0Q2x5KzliTXR1N3pUU3ZuVXJ1WHpBMGFMN09I?=
 =?utf-8?B?OS83Rnk1TGgySlIrZTVqSDJQRi82N0ZjK1g0ZkhMK2JLb3FvMmZsclpGYVFk?=
 =?utf-8?B?ZzIzL1VkcHZSWEwya2lvSjRIdmFoNy9TYnBEWGVEemkwZ3R4SDdGc0Y4UU9Z?=
 =?utf-8?B?SnBSN1ErVDhBekJDb25nRUppQkF2UThiWUJwTTZBRFVMYmJzeFF3OFZOQ2hN?=
 =?utf-8?B?SzFhR0ZkYmRFOFdxQ05TQ0lqdmxrOUF2RUNhZTZCVC92ckVoVFpYem45WU5W?=
 =?utf-8?B?R3hVL0JtUWNNUDVORVN5UkwwYWQvR1U1UTRwR3lVNXJFSlhSWmk0REF4TnNx?=
 =?utf-8?Q?SlcfOFQ+L+LKEDUU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBA123BEEC58104E90705192D90D6F4E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jbncc4URVkTGvRVC5Du5MAmlAUTZjr8PTvoaeOxxBBB14P4k8KuMj70dGElDElOcHOd9XW3ceZiiI8hig//ZokMrlPl1fWXpj/4Ev8jutIolrAEklp3uZvDny89HgvuMOdb3FUk7eZ/pmLTh+evHIxR7fMkEFXhqKoKFGDpbAwR+4EI5axhIpMwO8BeHC2GAuwtrzr4m39avGMBiDhDBFiAbehjfws8xRyjBFPX5Hm4Zq5mcSBvkhGnLL4LNacX+LF3sCZ6l78cHD16Qe/TFEUVDe24RdT9uSipgYCEGlnFPD0OkFKgTRHQluyZrX/GJ+1DNlsGujPLXLsJHEz1ABQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b64aeb9-04e6-4c5a-db27-08de9997d0e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 20:04:05.6751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TgQZAhemdRPo/k8TKmZrnGooQSmKriqEgVv2ygokoikD0bnp6gbQ2ujgY8PwhvWEcdGF18kYcoZqvgG7UfAIl02Au94RFxCJsDhA6qNLDSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9130
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQ3Vy
cmVudGx5LCB0aGVyZSBpcyBubyB3YXkgdG8gcmVzdG9yZSBhIFREWCBtb2R1bGUgZnJvbSBzaHV0
ZG93biBzdGF0ZSB0bw0KPiBydW5uaW5nIHN0YXRlLiBUaGlzIG1lYW5zIGlmIGVycm9ycyBvY2N1
ciBhZnRlciBhIHN1Y2Nlc3NmdWwgbW9kdWxlDQo+IHNodXRkb3duLCB0aGV5IGFyZSB1bnJlY292
ZXJhYmxlIHNpbmNlIHRoZSBvbGQgbW9kdWxlIGlzIGdvbmUgYnV0IHRoZSBuZXcNCj4gbW9kdWxl
IGlzbid0IGluc3RhbGxlZC4gQWxsIHN1YnNlcXVlbnQgU0VBTUNBTExzIHRvIHRoZSBURFggbW9k
dWxlIHdpbGwNCj4gZmFpbCwgc28gVERzIHdpbGwgYmUga2lsbGVkIGR1ZSB0byBTRUFNQ0FMTCBm
YWlsdXJlcy4NCj4gDQo+IExvZyBhIG1lc3NhZ2UgdG8gY2xhcmlmeSB0aGF0IFNFQU1DQUxMIGVy
cm9ycyBhcmUgZXhwZWN0ZWQgaW4gdGhpcw0KPiBzY2VuYXJpby4gVGhpcyBlbnN1cmVzIHRoYXQg
YWZ0ZXIgdXBkYXRlIGZhaWx1cmVzLCB0aGUgZmlyc3QgbWVzc2FnZSBpbg0KPiBkbWVzZyBleHBs
YWlucyB0aGUgc2l0dWF0aW9uIHJhdGhlciB0aGFuIHNob3dpbmcgY29uZnVzaW5nIGNhbGwgdHJh
Y2VzIGZyb20NCj4gdmFyaW91cyBjb2RlIHBhdGhzLg0KDQpXaHkgaXMgdGhpcyBwYXRjaCBhdCB0
aGUgZW5kPyBJcyBpdCBub3QgdmFsaWQgaW5pdGlhbCBiZWhhdmlvcj8NCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ2hhbyBHYW8gPGNoYW8uZ2FvQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRv
bnkgTGluZGdyZW4gPHRvbnkubGluZGdyZW5AbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1i
eTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbT4NCj4gQWNrZWQtYnk6IEthaSBI
dWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gLS0tDQo+IHY0Og0KPiAgLSBVc2UgcHJfd2Fy
bl9vbmNlKCkgaW5zdGVhZCBvZiByZWludmVudGluZyBpdCBbWWlsdW5dDQo+IHYzOg0KPiAgLSBS
ZXBocmFzZSB0aGUgY2hhbmdlbG9nIHRvIGVsaW1pbmF0ZSB0aGUgY29uZnVzaW5nIHVzZXMgb2Yg
J2kuZS4nIGFuZCAnZS5nLicNCj4gICAgW0RhdmUvWWlsdW5dDQo+IC0tLQ0KPiAgYXJjaC94ODYv
dmlydC92bXgvdGR4L3NlYW1sZHIuYyB8IDEyICsrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC9z
ZWFtbGRyLmMNCj4gaW5kZXggYjNmM2I0MDYyN2MzLi5hOTcyZjliYTY4NzcgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtbGRyLmMNCj4gKysrIGIvYXJjaC94ODYvdmly
dC92bXgvdGR4L3NlYW1sZHIuYw0KPiBAQCAtMjUyLDYgKzI1MiwxMSBAQCBzdGF0aWMgdm9pZCBh
Y2tfc3RhdGUodm9pZCkNCj4gIAkJc2V0X3RhcmdldF9zdGF0ZSh1cGRhdGVfZGF0YS5zdGF0ZSAr
IDEpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBwcmludF91cGRhdGVfZmFpbHVyZV9tZXNz
YWdlKHZvaWQpDQo+ICt7DQo+ICsJcHJfZXJyX29uY2UoInVwZGF0ZSBmYWlsZWQsIFNFQU1DQUxM
cyB3aWxsIHJlcG9ydCBmYWlsdXJlIHVudGlsIFREcyBraWxsZWRcbiIpOw0KPiArfQ0KDQpFaGgs
IGl0IHNlZW1zIG9rLiBCdXQgaXMgdmVyeSBLVk0gc3BlY2lmaWMuIEkgZ3Vlc3MgVERYIGNvbm5l
Y3Qgd2lsbCBuZWVkIHRvDQp1cGRhdGUgdGhlIG1lc3NhZ2UuIFRoZSBzeXMgZGlzYWJsZSB3aWxs
IGZhaWwgdG9vLiBCdXQgaXQgZG9lcyBjb21tdW5pY2F0ZSB0aGUNCm1haW4gY3VycmVudCBhY3Rp
b25hYmxlIHN0ZXAgZm9yIHVzZXJzLg0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJp
Y2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KDQo+ICsNCj4gIC8qDQo+ICAgKiBTZWUgbXVsdGlf
Y3B1X3N0b3AoKSBmcm9tIHdoZXJlIHRoaXMgbXVsdGktY3B1IHN0YXRlLW1hY2hpbmUgd2FzDQo+
ICAgKiBhZG9wdGVkLCBhbmQgdGhlIHJhdGlvbmFsZSBmb3IgdG91Y2hfbm1pX3dhdGNoZG9nKCku
DQo+IEBAIC0yOTEsMTAgKzI5NiwxMyBAQCBzdGF0aWMgaW50IGRvX3NlYW1sZHJfaW5zdGFsbF9t
b2R1bGUodm9pZCAqc2VhbWxkcl9wYXJhbXMpDQo+ICAJCQkJYnJlYWs7DQo+ICAJCQl9DQo+ICAN
Cj4gLQkJCWlmIChyZXQpDQo+ICsJCQlpZiAocmV0KSB7DQo+ICAJCQkJV1JJVEVfT05DRSh1cGRh
dGVfZGF0YS5mYWlsZWQsIHRydWUpOw0KPiAtCQkJZWxzZQ0KPiArCQkJCWlmIChjdXJzdGF0ZSA+
IE1PRFVMRV9VUERBVEVfU0hVVERPV04pDQo+ICsJCQkJCXByaW50X3VwZGF0ZV9mYWlsdXJlX21l
c3NhZ2UoKTsNCj4gKwkJCX0gZWxzZSB7DQo+ICAJCQkJYWNrX3N0YXRlKCk7DQo+ICsJCQl9DQo+
ICAJCX0gZWxzZSB7DQo+ICAJCQl0b3VjaF9ubWlfd2F0Y2hkb2coKTsNCj4gIAkJCXJjdV9tb21l
bnRhcnlfZXFzKCk7DQoNCg==
