Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF203F507;
	Fri, 26 Jun 2026 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782432901; cv=fail; b=Xo6GpiP2DmGn9C7FaVFih2swrkNcMpTyTk2V2TIA4i7lDUK3/zDX8vZzM30NdgVapjU79ixt8Ahp6TkBjobgjIh2QJ8xlyzwN8k9NQ5MqqIvPPBWeMoraykQ92pAYLfH6xyUJLmJYE2jjuNKtzjFXNXOLNqmRCCXEFf/16Qj74s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782432901; c=relaxed/simple;
	bh=IRBE4qlKZOXVYxtOPCpgRB/8h7X4gL0Pr+sYflCoX9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V6yqF+h0DI4DoFrVB4nEEafLkqA8Au9lsv/Py0w1RHGRPSWIeOzLwBm5meWQiZpmI1f7o9JVPHa8omogXWQcZw9fPadL0t24wATlg0YkbDeC1Ic9SSJbyi2B68pU2etHK/bkFeLE74zUw5QqSlY6TP2OcwpRSI9vt5tHYBc3lxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELlWIDk6; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELlWIDk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782432900; x=1813968900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IRBE4qlKZOXVYxtOPCpgRB/8h7X4gL0Pr+sYflCoX9E=;
  b=ELlWIDk6L9X9hEUm/ZDbIcVzD5tx9NQ3Cp1Y3RlWqjtz7TTec7ZL7Ii+
   +FL7zqXm1Y4ts3QbcWc4mbmeRaPqppBGZOT66LBf+brcstbqKImU1/9bv
   y1uOBWi/OFipIcvBxvkGBl4SkBh3JX6vHPxKwxJsS4lN+U2QMYtYTKJGy
   5KEarbhi2JGJv4V+OTz7R0L/O7Qqz22LJ7l5LnAFfQvFPEyEpxKzZ71GY
   gu05Gqc5DV+LoyR0AE8y2YwNnvTmAcAf5w0Av1ao/qDc43etpIE/w4hot
   uW0wRGzgqOK3K20j7fN7j7sWssB2+qjUyNWTWlUz4LcfEfJl+eod+zOLq
   w==;
X-CSE-ConnectionGUID: Xj5FSjRVSK2Xdyn9bpITEg==
X-CSE-MsgGUID: xWQaOqHfSDGQ+WRzYIQNrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="86904418"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="86904418"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:15:00 -0700
X-CSE-ConnectionGUID: ngzVh0/kRcOIUnAj4DuhoQ==
X-CSE-MsgGUID: WxKl82Q2ThWHyqBv3e1+mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="248535458"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:15:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:14:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 17:14:59 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.15)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVNS7aJ6sgPLXTM8AJzQMqYF8zt/qw0ipYKbTrreiMwWdvy/QVPofn5gqQX5Ao+RJKe57pw9nF46A3t3GcvBHlK/WQ/hR9Xn16R+oHxwd2Oj+lGvFB1zQyEeKH/9v7criOOafFUHr1JK8TFKeFKKmtD9RxyDYqjuhmXulZPgGXxKCirrUMP1MJXZX2DQb85ilnlrvbkShoosoJSxjb/ydwf+HKCnJ+ZZiS2NY4GKYcI4vR5WAmrMEUmi2sAUIdAWcZT4shCXZztoDjIdFD8TxRUu68Lpg3ZQxOxPdFzO7HpKEjmezjc26LfbIZ+98Byq3CPBSqF0FCGm1uNGnLf96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRBE4qlKZOXVYxtOPCpgRB/8h7X4gL0Pr+sYflCoX9E=;
 b=HUYY590yfUgeIW5l8qm4phQuTADQhSkgtdqNJgF9e/r07+ND1VitBcBrQvPJsvJNg9BVlbR5RDVUXmftdrq4GCaJRVg7xU6YvZRLPTt1S2hHFcf5Mo6gGsXsolgGN/6DDCVG7O1kik22/jA8sEkBVeIGtoEEqxuSgNh/YYzCBWT7nWDSZdwz6mP7lt0Zkb0/ZeEt7fKvC9qTHotGiF5KuyIZqBpobiq08Q/ckD7bsGUTmBTcxKIjJUJ7XsxuH4pcbudVOdcYPG25kcjB1PwRvewatNGcI2Hy7K6WnS3sLFxM1F5EqkmZO7xFa0PyVyyI2MwgO3JkeFd/SSiScG/avA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Fri, 26 Jun 2026 00:14:58 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 00:14:57 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH 3/9] KVM: x86: Pluralize the macro guard name for msrs.h
Thread-Topic: [PATCH 3/9] KVM: x86: Pluralize the macro guard name for msrs.h
Thread-Index: AQHdBO6whuZnV8OITE+u+0oZByU+k7ZP98AA
Date: Fri, 26 Jun 2026 00:14:57 +0000
Message-ID: <23f1268b7d5984da987162b53098f461c2a6aafe.camel@intel.com>
References: <20260625220450.3354415-1-seanjc@google.com>
	 <20260625220450.3354415-4-seanjc@google.com>
In-Reply-To: <20260625220450.3354415-4-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA0PR11MB4752:EE_
x-ms-office365-filtering-correlation-id: d3ee0b82-8c98-4e15-6d82-08ded317f4e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: Rky8tfLLNy7DooGhRFr7fvOdavN+pLvjOHZfXaAOkaRfWNLmg0vu82PkCr18eleY2/ZlY4vvQdERPKZLFpWrLSjNAptL4lzO0PGegDnIlCNmPuzZb7gc1Zp6hk4n7zg9+59z1YZxciBj+n1UsyS6Jo0dHN86uZuitoWZz6Ln86IIPQvPzS/tddfvrFYRAWt7mk7s3wgNerz8rHfNdq7PDYKo6RLN5vyc2zvF0NzqHLBloIJ5pGTmNt/ZLf3uwsFnFZWHeNA+lJZ88eBJXvo7umkAoNAuY2+fm+znw7JIhUeCaG0HT+YIfpA3h6fLBnedVALuA8xYh0DnRtp/uwgMfHMaa17SDETJSoA7ddTDJ335TuoZbdO8FT3itn/JnPojCZqfsLbh1rKkYY2PEUCrjjneP3UIhJ03Mzl9XHdom2q4G8w6XPUXjfYMD0fo12u0LhyF+dmm5hZQoR1KZc7TM43RIYQezqgtjVPYAX8um1NsJSQiULw6kNbWQWayzOPcoWZEy2x6bkY1I5pR66njchWEVzT6pLqJ++v98awnOoeTlQcxrTxwQnJhgLB4oRVKJJHY8Sy7VaA4o6BIssNeFiUXSI+ds7wzN99Hz+p85pN5UIbMtPI1J4Fipi4/FdChOGTwhSCLGYplVqmCc+CxTnjXaHUoBmhLkjKUpJK3lYEZAEDj8RNsTQ26TU95LqFR414KV31LwW5Bk6zJPVZyxSY+fvVRWwBsSdH5jJru1GU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVNRblpJZ2JqYU1lQm83NWxsbStUYVFpa0hsbGozZE1oR205RjcyZkdIWUM5?=
 =?utf-8?B?WkEvU0hkazNwNnEwYXJLUXVST3V5NXF6Nm50VVhjQ2dZYTVCR08xT1ZzcWNT?=
 =?utf-8?B?U3lMZis4RGovVUg2UjFpeWFnZXJFNGZRUWlrY0NuK3Nqc1Q5QUpHZEVFVXdR?=
 =?utf-8?B?cVhkcEpVc3R0eVlRcFkxbG9lYkNzZGJYTlpxSTQyZ0h3TTZKdUdYaVZIMkRj?=
 =?utf-8?B?eVI0Y0pXdnBEcHM5aHo0ejBET2dkR0xIWThDRC9sZ3dsdkxjaXhEdUhhYjAv?=
 =?utf-8?B?U3ZoOWo2TzhiYzhJRFNoNS9FZnRaT3BUbURKSG5NMEowM3BNZzdCM3krWUZQ?=
 =?utf-8?B?MHNGK1ErVDlNS3pGa1N6Q0xvMUpqM2VlTVprZU1uaUxDTlZybWNrcXhzTzA2?=
 =?utf-8?B?SGFIUHB0dTY2RStZK0tqdml1L09RQzFYcEw4WlRjcE5pRDVQUHNrbndNSU9n?=
 =?utf-8?B?MmVTZW1kRElES2plYmdLZFZvUCt0bW9wQXhIMXFvdTk5T0k2OHljczdNY3RK?=
 =?utf-8?B?NnI1NlJyMTZMN0VMODJJQkN2YXBac1FPRlNJWmxqdFJRUFkrSmpIdE5iZmh5?=
 =?utf-8?B?OG81OTArdTR6enpXTFo5UjV2VlYvSjVmWGlpcWpNLzh3NThMZEhaUGg5TUJ3?=
 =?utf-8?B?UGl0S3poWjd5bENqdjVsQThteEdwVVRiTm9JM2lidWVhdXR0T2RnckxEbDg3?=
 =?utf-8?B?VmZJNzVEbkpWMDh6aHhDa0Zzak5lbEUzb2d0MzZpNnoySHRobXZOZXBDVmN6?=
 =?utf-8?B?OW5wSTdqVGNwZGVwTU12eFVhQjRPdlU0N210YkNPRURKc2o1QitHbnJISHov?=
 =?utf-8?B?SElnTWxLUmRkdnp6K0Q3Qmo3MC9yNDdCaDRYWElGdW9uRUkxZWw5TVBZVkk3?=
 =?utf-8?B?VUFSQlRPT2UrT0l1MG8xVnhGM2JUWTJ0S29POEQ4cXFsSlFhSnNkd0tMdUti?=
 =?utf-8?B?VzNDMzRqRGMzL2ZKYkFBMWZOaTE3anIwbWFxZ0t0eFFvOEkzWFJXQ1Mwdm9k?=
 =?utf-8?B?a2hFTDYza3NYWHJpNDJGMUxtZE1GVTZLNUZEK0tQb0x2NHB6TVd6UkJhVVZ5?=
 =?utf-8?B?TzhDekFReWd5WTl2RGJJL1VaZmVKQWZpMVhGOVpjMHFXTGkvYlk5NTlpL0xX?=
 =?utf-8?B?UnBMZjVpd3hRN0N3YWlUQkI4dS9nZGNhNlZsKzd2SHlmMVFTenZndUtya051?=
 =?utf-8?B?L0ZTRlAxaWJZaE4zTVI5R3B0eS9FbXVaZ3J6SkdQeEt2MGlpM29SajBPREpB?=
 =?utf-8?B?TVNPN1pQYWM5K2VnR2VFUHRGTDQ2L2czQkFaU1A1VTIwQ2hmbGc0QS9DbENQ?=
 =?utf-8?B?MXpoUFdvNEJmMXI3NVZhaTFEV0ZheE15Q3N6cFBJMmRzK2xHYUQrb0Y2WTBV?=
 =?utf-8?B?aFdyajJDRDRpR1J0VzdJckVYZUZ1TzdBUlBJSzVDYlJ2YzVwblZQelNYd0dz?=
 =?utf-8?B?NXAySEllOFMwK1ZrclNreEEvdmxsRzltQUwxTnhSeVdvc0hMSnhGU3dVSVRz?=
 =?utf-8?B?TThnTmhKa2h5TCsybVRpWE90M2ZQa3YyYVlndmdDMnI5NXI1ejlUaCtOVzZi?=
 =?utf-8?B?V1RQWmh6T2I4MHVZb0VjdHBCNTdOMC9hTytqODY1YzBmQVFYNzdXckNFb0dR?=
 =?utf-8?B?TG9PREtNY3g0bnVOYWhyUExyWlc4VUQwVmpyTWZZY3JHTnF6ck1oUmIwQWYz?=
 =?utf-8?B?SmdwQi9GN2JPUHRzSEJvcU5EQStkYlNMZmJweDVDWmZxRlBLRzhIdDZvMjZ3?=
 =?utf-8?B?azY1MmZVVlRvME82cnFIcUFsSWFKeTRMZ3FCRy8zSm5aK3NUQnZQa0YyT3lX?=
 =?utf-8?B?WkRHb3QvbXY3Qmg4M1JVY0pBeEN3djYwVXVPTlNCZFhXZVJRb0tuK25ySHBi?=
 =?utf-8?B?SStRM0NhRFdBYlFCVTJETmVEZWswdnlqZjBDdy9OOEhCUEE3czlKR3Z6QUFr?=
 =?utf-8?B?YWxDd1RuekRLU2RuUCtkODJWTUJwWWR0ZTlBemRhN1ZMQTNFV2M3ampSVUM3?=
 =?utf-8?B?VkEzbXhzMmpjVjJoMFBGTS83eVVwbHppcWdMd2RBaWlnL21EY24wUkM1VjNX?=
 =?utf-8?B?bjUxeEMwTTJPWDQrL0FKK3FTeGV6MFlZVDg2U2ZvS1lIZXI0T1V5S3NnYVdW?=
 =?utf-8?B?MzlLblNGanZtOWJpMGd0azRxT1dRS256T1JiYUV1ZEhJeFVXLytjSG5WZmFY?=
 =?utf-8?B?SkdKbnR2WnBUeGZsZllpTEZQOXg4M2UyZUpzTVlzVGZTTmpXOVJGd1ZBZ2pj?=
 =?utf-8?B?SzdsR0kwM2hkLy9KZWNLS1Q3MDBLdy9kTk9Ydk0zbXhYR0twRHpXc0JMaWs5?=
 =?utf-8?B?eHRKdWVocFZSRHN2R244RDdwMlhrMnJwWHM4bVBlc2tIU2JYUGJvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAB7388A6EA418499E489D47F5D6131F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qyucP66uwPT0TaBub4EgUQngLeiN6nWL5GuGBWGPKTq4Uqrrh4FesOaDWFdShyULr/Moit0xYanDW2/TYH7L7X2PB0sn3XzLxos8TcbNkZiI8IHlmQih03xnXNow4FKufNEQDgvOUn7zaj6v1RC2QEEl+1FQEV5RwD0lgrrM3tsa4aNUVMomLkr08mRaMmHmqP/VrYeTkDxEw57V7dW7rGaUjYig3YNwOfZwjrVpb/jvKL6uDcn9+OJZbBnUOCALqt200fKp+FUCfl8ESLgaWHurDgHE8NqHxm2c1BK1VZlhO1kmDBozevE6+vZXaXTwJTNduYTe9l7dCus+4b0NSQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ee0b82-8c98-4e15-6d82-08ded317f4e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 00:14:57.9146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88DSV1NqLqwQRAOE3mjYgQO/MqJFdJxeZBJOMZgDH3pt2msQxnjCFsKBxcju/DL4X5PE+RhmWA2GC5uo5Y75kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjA0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBBZGQgYW4gJ1MnIHRvIG1zcnMuaCdzIG1hY3JvIGd1YXJkIHNvIHRoYXQgYm90aCB0
aGUgZmlsZSBhbmQgZ3VhcmQgbmFtZXMNCj4gYXJlIHBsdXJhbC4NCj4gDQo+IE5vIGZ1bmN0aW9u
YWwgY2hhbmdlIGludGVuZGVkLg0KPiANCj4gRml4ZXM6IDdhMjY4MzA4MDE1OCAoIktWTTogeDg2
OiBNb3ZlIHRoZSBidWxrIG9mIE1TUiBzcGVjaWZpYyBjb2RlIGZyb20geDg2LmMgdG8gbXNycy57
YyxofSIpDQo+IFJlcG9ydGVkLWJ5OiBCaW5iaW4gV3UgPGJpbmJpbi53dUBsaW51eC5pbnRlbC5j
b20+DQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2VhZDdkN2ZkLWFhNGUt
NGMxOC1iMzk5LTkwZmI0NDhlMGFmNkBsaW51eC5pbnRlbC5jb20NCj4gU2lnbmVkLW9mZi1ieTog
U2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KDQpSZXZpZXdlZC1i
eTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
