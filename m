Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82C18FDBE;
	Tue, 12 May 2026 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778547629; cv=fail; b=NlyL3vf871lSKdf7chjidwdLQIt18yqo3tT7qFWtwVy9U3XDQATZ4pL1yHv2om9acxy4dqxT//b1WUqYO20BrsD+BcdQ2TbdPMbTkZldR7AVkOcwHfe5r6rMK4/Q2aWjzmspKVgRnbp0kYEIoK8UK6A0HCU2XjNVpoT7uQQZBr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778547629; c=relaxed/simple;
	bh=nW6nYH/U8B2V6WaTWZob7Ng3cw5+B9LDnL0Fi56QF/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WfbXugQqH50SARlJeLbgLjLba7Xi5gxNZqRTmKiDleeWqmVIey61phMYh5DNnpRKOrmsOhq/2x3P3ZEMf6HmhkWKRAbiOBewO5nb0t0JdFXX9HPNPWuk8MAJqHqFhZJSDrjRfAOimf+170IWdvKjPEszj/5uQw+vkQL5UFAK0Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDNhCkTo; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDNhCkTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778547628; x=1810083628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nW6nYH/U8B2V6WaTWZob7Ng3cw5+B9LDnL0Fi56QF/8=;
  b=RDNhCkTohlfBhNnP/ifHj4/HpC24UL18B+7vT755jAAlCxFc5wKj14BQ
   zuWXLuQJU+Bo6FiXx1mBhz1eT93LVs6RrHGtumGVysd5fZP8yUpsd1hGI
   ThPRNw+NlI8HwyaXAYsCW5RAP2TTvLjWpe6j32lJ1A+1ZDYt9dnDbqZ7W
   AsnLpg1mqEHmj1/gBfCVt25bAqhb6OoAf03/DuH+WJpY/RIog3kWNZuqT
   usTcRl79QbmjCDAcSXx3XONVV6gaTNUcCBbxXH1GaPfZeG5fBwuKWn/L6
   5QtFuQyR6TzIoLbRpcbpC0tGX2dVbtM6tjRiXvXseEKyjdaxxue0W+2kv
   Q==;
X-CSE-ConnectionGUID: 3cis1IKUTz2+Lf9JMb0Pnw==
X-CSE-MsgGUID: XDsuslmDQfiD2nfHC0rTeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79344717"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79344717"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:00:24 -0700
X-CSE-ConnectionGUID: TdVJzRRdRHq8niAw7QXrPQ==
X-CSE-MsgGUID: m1MJ5olVTqOEkLnjZrZYzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="267967008"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:00:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 18:00:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 18:00:23 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.31)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 18:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBgy59aV3Aj/+3u68ovQqTzWvzgRZXsz1uQooEodgd7RQQCLdzkisGRdthj1dWDbaAFb1OCFox20EPiAZz/pg/c9X9DuyezYJvDwYM+blwIxQDuVNp5mvSi1SQVelhVxMQijXQO+Ra/4NX2DhZ3SBdGVDC2DlWZTZgReZQe53xFrExwNneeaFcBjWGW+2YqQlQx3Ooomslvk9Hm+b7neMX1Brrj6fPxMnZ5Z4OW2u+DXyRQU+urP3u/gYcM2VooLR4XKrxvTSLqK26AzkytvJQssXE9rqwmXn/ScltzXM/J5ysMiHh5HA9HOKQIC8fLavMQj9X1/6s32ENhanPYQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nW6nYH/U8B2V6WaTWZob7Ng3cw5+B9LDnL0Fi56QF/8=;
 b=ACkgqiIQLdKFKe/RnrvK4jxrAil0nWuzMoLTDh9iHhIB0A0e2rTRPppTobkWkEmifnEQIIVvmmJJaVeLO8xHCwCzUQQQqYl6dFFziuFaei22MuPE65SXWpF8tc3gvJXfsbEJ08rzQEDa1vuK7xwmVtt0nuEj760c1fzhDaH5MCa/GeL+FAq/U1Q3MVF1HFRtWFlljnyF949BsQXUucdRsKpJpoWq/blCZuMRc5pmFqtfDAzItciCVOINR5DwrpFh5b4xMsmAaYJmq6cUJP/rEDbY8ZfXvZ5xbnJgfO9sVV5lTm9icmQZBTO2yfAQjXs51SpvUfnVX1IhoA7W0KLwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CH3PR11MB8361.namprd11.prod.outlook.com (2603:10b6:610:172::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.22; Tue, 12 May 2026 01:00:18 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 01:00:18 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "devnexen@gmail.com"
	<devnexen@gmail.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [BUG] x86/virt/tdx: tdx_offline_cpu() violates
 tdx_cpu_flush_cache() preemption assert
Thread-Topic: [BUG] x86/virt/tdx: tdx_offline_cpu() violates
 tdx_cpu_flush_cache() preemption assert
Thread-Index: AQHc4Y3NTHiTAIyMN0SZgl/7bzl+HbYJkkgA
Date: Tue, 12 May 2026 01:00:18 +0000
Message-ID: <ba5e72a7d7247c783fcfe2de4e603d55f1f119c7.camel@intel.com>
References: <CA+XhMqzcFRY=ogMhiCQeKqh-zz3RpP0nsUWYhP0jNhF9Uy+41A@mail.gmail.com>
In-Reply-To: <CA+XhMqzcFRY=ogMhiCQeKqh-zz3RpP0nsUWYhP0jNhF9Uy+41A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CH3PR11MB8361:EE_
x-ms-office365-filtering-correlation-id: 9d13de93-9a0c-46b3-aab1-08deafc1d5e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003|11063799003|38070700021|10063799003;
x-microsoft-antispam-message-info: lKtRuGIsc7xl+yyGf/f6JMpXyB/rwGhTEiRPjsvpBzrPiz9ZDHh3dE6ywCV9nWalmDjqXdQRHGNZuOAC6jcPNLV8kLW0UIG9ghRe+FyAbb09QSuuHt/LZ7eeebn68QfYCjXw8bSXBYApQRlDE8ZtrJKP71jm5+5OWsvjxzJNCDixZsDSBJobEF3JRHDy559XXIk25mB04VlHP/aN/8AuTnBdvX8xcubbv6311Q0WBDsTySQJHnM8gT1FTREe2qmcgdps2Op85Bwxa10gMjq34Xq6Cs7OA0+Vx2jZa1J/7BQEtp1UPjrCaMPgTOFrQf3kG0EILsNtC3Z5x7SgNascXksyj6DvyTefbrC9Wq52hq6IBwMFd1OHHqnHQBtUlmovuABQoet7Yc3w8yfd2dL7htZmqnDqvPcNZVJZvc76vQNbRsNHa8ulSaAyyxtcRUcXoSNjc3PK5jYyoPteh27Iu7o9KERVOhtxtT8wPgCfRtvTRmWTw3ny6z5oAnHCSAwuk9I7QoeM3hlxsZnSkZSyS4BHL44KgK5QUIeBV2zVJk5iviSSGsNBblHtDrsZyBDm/cbC1FTSYC3eQu9UuJ6PTxppg3h/LrXRpcnpqldmu9v+okayhFl8OTv/Hwuc6pVHkF1ZEUk4kYY5j+CANRfGyfopvPmDAiZIYcRJwcOnZilFMYrFgUjhy0TlreO8VgcSoDSNUr8sywe80Bq9gHEy42Jq1gpvfnCvhHm8ZBvkQO/eDQwvH8DoNgGGTPe4V2EX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003)(38070700021)(10063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmxTNktpa0JMR1BiV3BHd3VrUzRMOUNNMjJXUTdlMkhWZ1NzWitwaU92WGw3?=
 =?utf-8?B?bk80QTM1ZitiZkZjWFBVSEJZYlJ0eXgweFRTc3dHYnVzcUtkQUlXZW9Ea2JH?=
 =?utf-8?B?WVdEZm1oWitlOXczRzg1cVI5aUhpRjJuaFF5UWpIakcrR0pMZkZ4OVIzYTlp?=
 =?utf-8?B?cmcxS1ZCYnVSelNuWFE4Ym93bDRpOGVOeVRqQVptYnhWVng1ZzJsQjlqMjRG?=
 =?utf-8?B?WXVXMnhwaGROTmdOU0V4ampqZEswZWU1SXQ4M1gzMDN0TC9aZmJuL2paalor?=
 =?utf-8?B?dUE4TUtyWGZudXZzanpyOEdveXY3VFRiVzlSNGJ4d3VUdXZLT21pUE9nT083?=
 =?utf-8?B?YVhwUlFpNjVYY3lXZndKdVUreFlKR2ZpWDZRNWNKWmcvYm4rNnhJditaSkND?=
 =?utf-8?B?Y1dJNHdhQy9yN2dVNXplb3BPaHNHdTVaMnVxYUU0VTFJZEFUNlhMem1tcDNk?=
 =?utf-8?B?ZGMrZHdpZTlnTjl3LzZBcGhqa3B6TWoxYWJUU281YXNpZVEwM3NTazNtZnNV?=
 =?utf-8?B?U0dQT1R0V0Y4aHNzM082Tlh6d0ZBaVVJTi9yN25OTVhEUFVvaXo1bC8ybVpi?=
 =?utf-8?B?NHYzQ1l0TktnYVAxR3djc3g4YURjcW1kVFBhYkNPanF6K1lEbGRERVlBZWVG?=
 =?utf-8?B?K24vbnpvaGZ2dzgzcW9nMmVNZWlNNzB0T2Rkb0xYMUh5WjBsd3BtZzh5UVJB?=
 =?utf-8?B?T1d2bUp4OGc2RXZsK21CaTBDb3R5KytOU2tlSGs2ZVN6M2VaUWJNaWQzZzJZ?=
 =?utf-8?B?REpzRFFpOVkvREI1LzJXSS9qSVlpVFc3VU1saVQvOEliVmxYY0g5NktXOW0v?=
 =?utf-8?B?bFBoS0RKRm5aOWl0UmZkUCtoOXhUMEVjRXZzcURJdC90Zmx1QlR4MWlHRHA4?=
 =?utf-8?B?b2YreUxBYXpYclcwVVBQa0E2MzhnTXpTMmZGK2cwTVVjKzFic2c5Z3Nqb1dO?=
 =?utf-8?B?WHBWMlJhdDdBdDVNWFUrVnc3Mzl5Y1dUbUFBMWJocGtyQjd4NjdBT0FZYnIz?=
 =?utf-8?B?cThCbS94ci83bk9UUjI3Sk5yMTArWldqRW01SjdSQmdNRTVsV1JQY2t4dW1Q?=
 =?utf-8?B?UjJGdGoweHFnMFhuRW15SHU4SnNVeG4vWXBVbG01eVNVazVXMk43S1U2TUZw?=
 =?utf-8?B?WGhNU3ErT2ZobFFYZjNrWlRFQ3haTTRsSXVPU2hhbFFTL012bEVjQUNabkRm?=
 =?utf-8?B?TVBGUE8wWVZYSGE4KzRSSmdKSUR2UFhaa3U0SWRwNkc2Zk0rNFNEanNGZnhp?=
 =?utf-8?B?RG1Yd0FoQXJYWGU0RWs3R3JzajUzSEdJVEVRL3dqNnlFRmJUY3JjR0xhYTBr?=
 =?utf-8?B?ZDRFdFBLbzFFcnU0M3pLUnBBbnpUam9SVllvZ3MzUEFqMXdZTXpoVHRabnVq?=
 =?utf-8?B?R2NoYUI1YUo1M2VPZ2ZkZDUzOURGaWtodk1wNEhVUW5iN0dnLzhMMTFPNnZY?=
 =?utf-8?B?bGRUVWkzTG5adXFrMjN1SUQxWWxZVjdWNDFPbWxrNStPRmFYbUNMbTkvM0Y3?=
 =?utf-8?B?TmwzS0tNZTNkQXp2SThWRXUrQzRKQzRWWG9oMlQxNkNObXVyL2VOZWFqOVJj?=
 =?utf-8?B?ZGVhaVVna1BXOUxDZ1ZIUDVrbTR4VXBlK25IRkFscWt5NGZrWlNFOGRGUHEv?=
 =?utf-8?B?UFpjVDA3TnVCVE9FRHhNNEx1bFNITEtkVmNnODZtNWRDRVNhWGtOSnVLSTlB?=
 =?utf-8?B?TGNjdTRFbGMwUFBEbXg1bXY1WC9zYnlmejJlNFhMaTdBbGNoVkZ1N082c2Ev?=
 =?utf-8?B?MngrWmpIL3RlZUllMnpoRGx4bVVjam1HSVJBY3JaWlMrMjh2ZzJzcnVlRzlV?=
 =?utf-8?B?bXZ3M2F5R0VSWHdUOWdqMk9OYng5SWZmd0ZnSVZ0Z00zTldGUFlML1Y3VFJx?=
 =?utf-8?B?cnhMYmd2UGdsSkZrQzNkNXJFbk5aR0pzcXNuZFV3bXlDbzRtUjNrem11M0M3?=
 =?utf-8?B?dmlPOTNjc3ZUeTZJa2h5cFJpTnpadHhaZllMREZVbWFZRGxzd2lFV0Q5NUtw?=
 =?utf-8?B?emN4QkM2c2pOb2sxblRqcTFueWNNWmtkZGhRY2Rud2NIeUdRbjJ6MTBsV0ZN?=
 =?utf-8?B?QStHdWFXc1B3cmtzNjBUc1I0L1BjUnN5QmVkMi9QckNqUHI3czlKNk9PckFZ?=
 =?utf-8?B?dnZCd3N4TGptTlRZOXYxd2tvNmlReEc3bjlLR2lEV0dUMlpMRmRJSEVYTkRV?=
 =?utf-8?B?dlVCWTNEZjQ5QnpKMWlSRVdNZ2w0Z3htL2tUd3diYjltZDgwc2xGdVh3OVBa?=
 =?utf-8?B?RHA0bzhvYjZidWFDZTlLUXhUU0pnc0RRdlZ2VDRBZnloRDNHcUxHbmdjWWtB?=
 =?utf-8?B?L3ZNZEZZTUpBMm9hOUxxNnRDZ2NDZUlqbEY3ZjVsTG9WSnA2WVQzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D0DA0C8A2E5854BA91F7D75B6B06D03@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EcpoJLzDKWxzc4hkgeMNL30PiXpvVheR2z9rhlDvlXNT0iO1IVguZtzKVP+7Ztc+Ygly7TVOn0vaG1pDKf5utFUnhkTUszcZGDKY3Fgb9URF2hswPEZ+wLHOVWReNCO2HYSfVve3zvxYq1Fs130Y3XyvCpzqlHH5gwObqddXRtlk/gjxfJ5Okye++mr+9a8pwWJhHUcVXvZD6VV6uWTesF/6P33HCDWxj/igx6skdG8bGUfyp/+ByjxYpAYwhyCk1gSA5P+c+p4dmxoZr8RxWOjpvp1ueqxPJFbcoh6nXO/mHRrAvS4IlC84k2nTWU+JWIxTW1IN/uQt81UpU+4EbA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d13de93-9a0c-46b3-aab1-08deafc1d5e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 01:00:18.4376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRuAt7X62Mf3xpEQUaZHPCkesYGE5J8bTrr7vW1py5iOxlbowY0KjU3kUb3vlPiXmYsJSs8yhLGw6dbrrxSWdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8361
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA1LTExIGF0IDIyOjMzICswMTAwLCBEYXZpZCBDQVJMSUVSIHdyb3RlOg0K
PiBIaSwNCj4gDQo+ICAgSW4gY29tbWl0IDU5N2JkZjZlMDY4ZSAoIng4Ni92aXJ0L3RkeDogUHVs
bCBrZXhlYyBjYWNoZSBmbHVzaCBsb2dpYyBpbnRvDQo+ICAgYXJjaC94ODYiKSwgdGR4X29mZmxp
bmVfY3B1KCkgZ2FpbmVkIGEgY2FsbCB0byB0ZHhfY3B1X2ZsdXNoX2NhY2hlKCksDQo+ICAgd2hp
Y2ggc3RhcnRzIHdpdGggbG9ja2RlcF9hc3NlcnRfcHJlZW1wdGlvbl9kaXNhYmxlZCgpLg0KPiAN
Cj4gICB0ZHhfb2ZmbGluZV9jcHUoKSBpcyByZWdpc3RlcmVkIGF0IENQVUhQX0FQX09OTElORV9E
WU4uIE9OTElORS1zZWN0aW9uDQo+ICAgdGVhcmRvd24gY2FsbGJhY2tzIHJ1biBmcm9tIHRoZSBw
aW5uZWQgcGVyLUNQVSBob3RwbHVnIHRocmVhZCB3aXRoDQo+ICAgcHJlZW1wdGlvbiBhbmQgaW50
ZXJydXB0cyBlbmFibGVkIChEb2N1bWVudGF0aW9uL2NvcmUtYXBpL2NwdV9ob3RwbHVnLnJzdCwN
Cj4gICBhbmQgY3B1aHBfdGhyZWFkX2Z1bigpIG9ubHkgZGlzYWJsZXMgSVJRcyBmb3IgYXRvbWlj
IHN0YXRlcykuDQo+IA0KPiAgIFRoZSBvdGhlciBjYWxsZXJzIOKAlCB0ZHhfc2h1dGRvd25fY3B1
KCkgdmlhIG9uX2VhY2hfY3B1KCksIGFuZCB0aGUNCj4gICBjcmFzaCBwYXRoIOKAlCBzYXRpc2Z5
IHRoZSBhc3NlcnRpb24uIE9ubHkgdGhlIG9mZmxpbmUgcGF0aCBkb2Vzbid0LCBhbmQNCj4gICB0
aGUgc3BsYXQgc2hvdWxkIGZpcmUgb24gZXZlcnkgb2ZmbGluZSBvbmNlIHRoZSBURFggbW9kdWxl
IGlzDQo+ICAgaW5pdGlhbGl6ZWQgYW5kIHRoZSBkb25lOiBwYXRoIGlzIHRha2VuLg0KPiANCj4g
ICBXcmFwcGluZyB0aGUgY2FsbCB3aXRoIHByZWVtcHRfZGlzYWJsZSgpIC8gcHJlZW1wdF9lbmFi
bGUoKSBhdCB0aGUNCj4gICBvZmZsaW5lIHNpdGUga2VlcHMgdGhlIGNvbnRyYWN0IGZvciB0aGUg
a2V4ZWMvc2h1dGRvd24gY2FsbGVycy4NCj4gDQo+ICAgTm90IHlldCByZXByb2R1Y2VkIG9uIGEg
ZGVidWcga2VybmVsOyByZXBvcnRpbmcgb24gaW5zcGVjdGlvbi4NCj4gDQo+ICAgRml4ZXM6IDU5
N2JkZjZlMDY4ZSAoIng4Ni92aXJ0L3RkeDogUHVsbCBrZXhlYyBjYWNoZSBmbHVzaCBsb2dpYw0K
PiBpbnRvIGFyY2gveDg2IikNCg0KDQpSaWdodCB0aGUgbG9ja2RlcF9hc3NlcnRfcHJlZW1wdGlv
bl9kaXNhYmxlZCgpIGlzIHdyb25nIHdoZW4NCnRkeF9jcHVfZmx1c2hfY2FjaGUoKSBpcyBjYWxs
ZWQgZnJvbSBDUFVIUCBjb250ZXh0ICh0aGVyZSdzIG5vIGZ1bmN0aW9uYWxpdHkNCmlzc3VlLCB0
aG91Z2gsIGl0J3MganVzdCB0aGUgbG9ja2RlcCBhc3NlcnRpb24gaXMgd3JvbmcpLg0KDQpJdCB3
YXMgaW50cm9kdWNlZCB3aGVuIHRoZSBURFggaG9zdCBrZXhlYyBzdXBwb3J0IHdhcyBhZGRlZCwg
c28gdGhlIGFib3ZlIGNvbW1pdA0KaXMgbm90IHRoZSByaWdodCBvbmUgdG8gYmxhbWUuICBQcmV2
aW91c2x5IHRoZSB0ZHhfY3B1X2ZsdXNoX2NhY2hlKCkgd2FzIGNhbGxlZA0KZnJvbSBLVk0ncyBt
b2R1bGUgdW5sb2FkIHBhdGgsIGFsc28gdmlhIHRoZSBDUFVIUCBjb250ZXh0LiAgVGhlIGNvbW1p
dCBhYm92ZQ0Kb25seSBtb3ZlZCBpdCB0byBURFggY29yZSdzIENQVSBvZmZsaW5lIHBhdGguDQoN
ClRoZSBsYXRlc3QgdmVyc2lvbiB0byBmaXggaXM6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvMjAyNjA0MDcyMzMzMzMuMTYwODgyMC0xLWthaS5odWFuZ0BpbnRlbC5jb20vDQoNCmJ1
dCBpdCBuZWVkcyByZWJhc2luZyBub3cuDQo=
