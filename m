Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC55181334;
	Mon, 13 Apr 2026 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121448; cv=fail; b=SvXKB/HeIbOc1oEmnYqT4d1H0Iy5PzHv5ANtyVYzMFPILD7Han21+1kqqbRRlrxBesFlSN+0eCFx8ujabHgun3rl35YrLiK9xuzH1iWFxr0i5ncZam6n6CT4y0ryUmWbf//RbfYoovZblcWGIQ4ZZliHRCerTLe23DyIOYDk7IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121448; c=relaxed/simple;
	bh=UC0pycXsgK0mKzlYYSL4Q5STe9rkgeMdprUgoRNEQYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDV/YDfdm7uctuYp/lt4rkiv2A5pe6XW5KMMXtsjSNPaDgxDDiN38qb42WN1CIpxTdHifP1IhpCZYc2d5fSVaCQpeJGehT8T9uuyhbQ/ctjpL/RTRRa8AjOkzIqf1kB4yzLI3PDOzsyhckL3memkLDgBGyWOCYjrK0IPuUmtgKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8AAsZe1; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8AAsZe1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776121447; x=1807657447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UC0pycXsgK0mKzlYYSL4Q5STe9rkgeMdprUgoRNEQYg=;
  b=K8AAsZe1U8PTnHZJOaNoOqJqgHMrOqwhnDu6tmIWdjJyOwKq8bK+/2UK
   1bQjVmSee2dp2IUx4ROXDNd1Svd7CkYq26f0yivZFNkLEaHDJJ9bC5B2J
   pu1uq2wCosT3gldl5SE9EqGdXAziy6P5BC8PGkCTMDqhy6oKE+CjamXC6
   GjVi2EFeoHOJZwjEOrOamB0kSbe09P/57rJdT8RLFqztwyEbFCZxYMeH6
   mA64fFZGffKTNPUsgxVrDJGi+rXPsV6wUhqdKggJN9Db99nWG344/aBkr
   tYUuKy2t0OT1xgQrofRNfYUgE7ZTQDSNZ15W1FOZv18bHsHVV0u1MNIQq
   A==;
X-CSE-ConnectionGUID: 1mCZOBzAQSmMKbPpj+nhOg==
X-CSE-MsgGUID: Bsn1kWPzTIOzOz/N8z+HHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80930844"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="80930844"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 16:04:07 -0700
X-CSE-ConnectionGUID: CDtubrN3QJ6xrXHGlPGNHQ==
X-CSE-MsgGUID: eFWMc5fXTbeLdztb7JW22w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="253131180"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 16:04:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 16:04:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 16:04:05 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.37)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 16:04:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCEf4TlWUunLYk7r5JR9wUHa9rew0n9wVVJwegFAuJQRrct50o2n01xDFsfUwaPWXvK77MvuOk01h0p8h/1aYTUFOS3zWv++2/J9/T/gz2qszZL9u9al1HwwqPiBV+HpKGHqEdfK3g3amj5znX1wtMgR+Ve7z1TLIuZtd5EOdfTTpc5VRvPWuOiwqQ+rPiGjfnT6cH9ntaG0hZ7uSqTekhF+tPB/uGnM/SgZK+pXWtjwuTkM/FhDBVH9qsGap79CpKiQu38bVTP1H3THHDOJ8k9Tn+Md9h+9CNaUoDctHBKh6/vw9srqQ2WkQZM+D4SVYJXwDKE7TZkA1es0LRwc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC0pycXsgK0mKzlYYSL4Q5STe9rkgeMdprUgoRNEQYg=;
 b=MekBn0cUadXst8LffeT33SG/wV70cgn4+rzPWCZLVvEI398Cjre2K9k2UdpidxzyENliCdzEnuGbzVpdvUk47IeRVLNzrK0Tjjo1P8Q/fKrAqZ2Qt+o+VJMeoWT7TFnr9NiyYwb8PsuQOAXuvIPkT9hJhbicxDv7im3AkjGGT4I5y5Er3Xk3IEO+2/tTXxn5FlSyB3z81+5nz3Yj1YvVPvl0xm7MiEsMeSxDTU5vcQYwAXvxo+TIKHKUg/8q6OnK3REjeMNd9mR8xC4Pv4C3xfntlTORjV67ju8ygEQvwLgIPQeYprJ6C7NExWaeOcQ2U8RKBpIjvjU2YdFPSAaLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 23:03:59 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 23:03:59 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Bae, Chang Seok" <chang.seok.bae@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
Thread-Topic: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
Thread-Index: AQHcyHKA2qiN335YikKlMB8aHxcOdbXc4G2AgAA5kgCAAIi5gA==
Date: Mon, 13 Apr 2026 23:03:59 +0000
Message-ID: <d6f05e5fa781ccb465d27a4fb1c7c1ac1e9e95ff.camel@intel.com>
References: <20260409224236.2021562-1-seanjc@google.com>
	 <20260409224236.2021562-6-seanjc@google.com>
	 <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
	 <ad0DrDUsUKTMfrDW@google.com>
In-Reply-To: <ad0DrDUsUKTMfrDW@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ1PR11MB6201:EE_
x-ms-office365-filtering-correlation-id: 0c91afa3-0478-4365-792c-08de99b0f27c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: RXPA5j4uSst1G3nyRs/918hMk5BVa3kNCiMr+oynqXtq7K0Ateaiq0pDw+5TKkqrVyZFU8Sr069ntglVAqollEYkJG3DkZ9MOrItyHlUU40FE99zoXui7ybY094bV+Dh5btncBdxANBl2Vo1Y+wtKTpmqnkN+kPYoOP+OWnEsUK9iY/5FtiKsiQp4yXCSoyJLSk+f8gvELpL4+45P2jWfPUHYJ4z+kOX5eoKsKX5xOUU4+AKg6WUcZxBfOEVjveSz0LWXIZfDVXiNIhyN699YOSwDaEzO4du6sFusJH9/uxxmbzWf2iWS/huC1XsthP256K/C1QYrnytFUT/5QdropyobWqbWCMgAId3DybMiEIXQHn/qP3wONs/N1Rh9RfIZx0w9YUWBz/oaBjzZUJOP5nq8S8izNcGSLp0Xg+ioF25oZei3dnavHuEBKS4bUANmLyk0T8KKty31xKMHox+HTxrMgbmrlqcLHSNJoUEaXk6aUMNb6/d0SO555rILNFRn//zur9EuHP2zN/ea/50NGnr1kw197vawmY5mHj+gQNCigJSdPINq9SWP7UGetGKWvnRz/0HBQ3H3lJU59Ia5oB0qSucUTANKr/mV4lnXdDpTb+EIwkUC/tJfxSHGsajUgQaMCg47DFo99fu0jt/JV6knogy4OltL0AVgq9NLzPMkQz/LURuaa7pHpdymQ4lIKaaC2uccgIhJEg7wViWXwF5vNCX4fScoMLvsKZrBimZ2zLDCEt97kxcby5VCB8BVYYRxdmT0EgL5Silrf2pjQivZzGCZWynp9GYZ5NoZwU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1l4a2FJRFZ4bGFGUWZYZC96VHRvdmxxMFFqMjZBZW82STRXYkQ2Q2E4MUJG?=
 =?utf-8?B?cForRmdpbVRjQUpjVVRMd2ZQSmdrNDY1QnNHYjVQMnQxY2NGdTFmUHdkN0s3?=
 =?utf-8?B?M2RKUk5pai9qcjZnMkxlUlJoTnYvczIwSGFwbUc0Tnlib0N5YmE2YmdwbUND?=
 =?utf-8?B?WDd2OWlnb3BiRi9GdThINStScDNqaGN0dmk0bFNpYVJFUFllTXQzeUZIbGdz?=
 =?utf-8?B?YmtFNVEzVENqeWhlZUJ3dWJqazF4c2J5azR4V1hqOTR0RjhlVmZ3L3JSak1v?=
 =?utf-8?B?V0UrZFFReEpXc3dxbmhaMlZjZlpRaTk5QSsrM0kvMDhQNzNoQU8xMDlwRXhp?=
 =?utf-8?B?TUZOdGg3SS9RdGxCeDRuMjdBK0VJcjNrRjdPQlJHeDZBNmVjdEs4QXpuWHBU?=
 =?utf-8?B?OThTVDY3cTByN0ZYcHdobHVDLy82bjEwV2g1Rm02NmZYR1FacXgyVUh2WGti?=
 =?utf-8?B?aTNjNzdHUlBTcVpUenZURzM5VEtWM2dqQ1lTaXBUTmxQOUszRGhhdTcwWkI3?=
 =?utf-8?B?blNyVkJvek5ZOHFUUjRpUXRTallXYTFmQ1BOMGRuZmFub1pzaUpnU0lxeDFQ?=
 =?utf-8?B?MWJGOStzNGlab1lmMW9oRStEb2JTTjNrUlJaTXQzd3dzM1gydG5sWmp6d3E4?=
 =?utf-8?B?NWxmQjRuQUgrYkQ2V01oS1RWcDFQU1Y3ODRLME9zUndycGFWVzJ6WklrZlQ3?=
 =?utf-8?B?R0hyNlNhd0FFMWluZ0x2OFgxZFpMS3Q2b3lFNmIreUcxZW53S3VBVm5GeVJN?=
 =?utf-8?B?RkFubHVHcnFDWlFjVVN4dDQ5cnc5czFndmM0NW5FUmZ2N0thUGdDOXBTQkNr?=
 =?utf-8?B?NDlWcHJJdDdBMzdZTTh3U0pQNUd6a2RvdkIzUXdubWJCMjU1YjNZQVVEemZW?=
 =?utf-8?B?bUFUTFhSV2pWY1c3bU5DbGVmL2pRNWhHaW5FTnY1UUV6QTZZTjk0ZnBOVnNp?=
 =?utf-8?B?NnRiUHg3dCtERjEvTDNvamFUMWhkbjBPaWFWRUpsbXhjZ2pVVEl2cEhlZXJ5?=
 =?utf-8?B?cXRLdDhnZWc3RzVvOUhhMXZTcXFYWnkrVjA0UlQxV1VIdjFVMkMzOGpJbGNN?=
 =?utf-8?B?OEJmRFpFUVFobWtSNzkyY2YxZVFvckdET3pId2c0bXBDOHVoTW1NTUt3dDFn?=
 =?utf-8?B?YlV2YjZ3bnFRTnVwbjE4ME8xeFhGdnU2ODhsVjdGa0JrKzRTNzM4Z2dKWTh5?=
 =?utf-8?B?S2NSeVZiK3B4TkZzNVRQQU1xS04vek5vWG9lMzNQTXJtaUhwKzBSRWprVVV1?=
 =?utf-8?B?eDIyNTNCbGd6WWZUSVRxcUp4bGVueUFOQmhlNWFsdW9paEdiNW81WE1RdytC?=
 =?utf-8?B?SFRuVGUwdVpMWTJ0RjNzcW1BUUI2ZFBRQVpwU2FWR0ZyK2t0YUkvN0VJS1VV?=
 =?utf-8?B?MlRLbzNDOUN5MHZoajk4dW41aHNCaFNxNE0waUZITEVIUG5laVJ1SFlzY1cz?=
 =?utf-8?B?QnJTREFhT3hzRmlwNFBEVDRMdGNUeFB0Z3Jhb05JR1VZdzNhdG0xSmhORzN6?=
 =?utf-8?B?TGZpMzgrRkQzM0F1bjU1bEhxdUszSmFNeHh4ZGhJcWhXY3VqYmc4Z3hYUnpl?=
 =?utf-8?B?TzZJM3lrazArMDUrcnplNko5bUdFTGd2Q1dnUXJsOEd6ajJrNnZPV2RTWjNT?=
 =?utf-8?B?NUx0NDRLMjdDVHFSeG5TdnQxLzRpUVVQWkRMLzM2SEUyTnFqdFB4dGRoKzBE?=
 =?utf-8?B?cUI2SUw0ekRzV2FGOGFpVllNbXBidERQTVVYOTZLd0NYMitmQ3lMTGs1ZTRU?=
 =?utf-8?B?WThMM0liQVdaUlNWaWFadUw0RSt5dnd0aXg1ZTdjYm4xNmswa2lFSHlOZzRu?=
 =?utf-8?B?dGxZeWcvRTExZXdkOFZXZStDcm42QzVSWWJIUmdJZUs5SW5NYWlONjZnbkFt?=
 =?utf-8?B?MENtWjBlWlRROFRmZThzNkwzWENVOEpJNmJPWmJadGFEMkFqOWdTVEVqUE1T?=
 =?utf-8?B?UDVNQS83T3E0QXprTEJ0bkh1eGZVSjhmd1FaSXFpeTRCYmFsNFdhc3NLbmpG?=
 =?utf-8?B?VnJONnVTK1V1bGVKQTUxMHBsUXBOVllqM2dxaGhzaW5tUDltSDdseUdPY2hk?=
 =?utf-8?B?QS9Ca3Z2aXZwZE5GS1NiSGhVR3pmUHkvNHJPSGdWdXdEVldPZXdmcjRxQjBB?=
 =?utf-8?B?UVJ0clR3WWZqUEVvMUljUWpzZlVwUC9mWVR2MEMwZkZ2MFB3ZnlaM3Iwbm9t?=
 =?utf-8?B?V1NrRmQybHhENXZuc3Nic0c0Y0dvd0J3M1hZNW1rM1dRMFNLQjZJODRYdS9M?=
 =?utf-8?B?STJwV0lyOU1lVXRuck9VdktKbEhQMGczZjNGSytXNkNRK0U2YkRodjVoMjVM?=
 =?utf-8?B?cUtQc2M5UnJ6VGpFRWtDVFIxQklDdVFCTmhNMFozaXoxRFJvV09Fdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6684B679715E764EB5547B48C7F0CE28@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fhOdkPeDM1H+7NwIRbBwCwL8wrlEOdDguPaPKDkuuHyjY0dIrIipsUAiOY9Vcr9xxyHm8PTLTN68xpYVqrMSvcKV42MyICrvlBaXqYBMqzJby2z8H4Rsby3FAzhY1MsuNTtHdJc4y4wFJm9MpOB8URDqCStRNLN0IAXcDrCpwnCvxugcVMCR2rQVmMfbBcLsc2/bCSyDvvmJAc6x9bcYVbwAWuXDyxYhf/fDQ8HxqfEVo8UMRGxVXy3DSLbzZ7p2adGSiXFm5gvi/uZxqDo55wsr2CgTXY3M4FgSQ2IkQX2Q8VelkdHBG5f0R7DROgme9hBPMqdUq+k9gxNb4XyImg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c91afa3-0478-4365-792c-08de99b0f27c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 23:03:59.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3H45JeDx9B+X5Rrsdxlzu3tj8/yWuIOIBheu6EGz+x5rR3DQOjpv76Rj6u3nUuSxzo4LrUgYHK4Ml6q2jf8TKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6201
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA0LTEzIGF0IDA3OjU0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIEFwciAxMywgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFRo
dSwgMjAyNi0wNC0wOSBhdCAxNTo0MiAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IC0jZGVmaW5lIFREWF9SRUdTX0FWQUlMX1NFVAkoQklUX1VMTChWQ1BVX1JFR19FWElU
X0lORk9fMSkgfCBcDQo+ID4gPiAtCQkJCSBCSVRfVUxMKFZDUFVfUkVHX0VYSVRfSU5GT18yKSB8
IFwNCj4gPiA+IC0JCQkJIEJJVF9VTEwoVkNQVV9SRUdTX1JBWCkgfCBcDQo+ID4gPiAtCQkJCSBC
SVRfVUxMKFZDUFVfUkVHU19SQlgpIHwgXA0KPiA+ID4gLQkJCQkgQklUX1VMTChWQ1BVX1JFR1Nf
UkNYKSB8IFwNCj4gPiA+IC0JCQkJIEJJVF9VTEwoVkNQVV9SRUdTX1JEWCkgfCBcDQo+ID4gPiAt
CQkJCSBCSVRfVUxMKFZDUFVfUkVHU19SQlApIHwgXA0KPiA+ID4gLQkJCQkgQklUX1VMTChWQ1BV
X1JFR1NfUlNJKSB8IFwNCj4gPiA+IC0JCQkJIEJJVF9VTEwoVkNQVV9SRUdTX1JESSkgfCBcDQo+
ID4gPiAtCQkJCSBCSVRfVUxMKFZDUFVfUkVHU19SOCkgfCBcDQo+ID4gPiAtCQkJCSBCSVRfVUxM
KFZDUFVfUkVHU19SOSkgfCBcDQo+ID4gPiAtCQkJCSBCSVRfVUxMKFZDUFVfUkVHU19SMTApIHwg
XA0KPiA+ID4gLQkJCQkgQklUX1VMTChWQ1BVX1JFR1NfUjExKSB8IFwNCj4gPiA+IC0JCQkJIEJJ
VF9VTEwoVkNQVV9SRUdTX1IxMikgfCBcDQo+ID4gPiAtCQkJCSBCSVRfVUxMKFZDUFVfUkVHU19S
MTMpIHwgXA0KPiA+ID4gLQkJCQkgQklUX1VMTChWQ1BVX1JFR1NfUjE0KSB8IFwNCj4gPiA+IC0J
CQkJIEJJVF9VTEwoVkNQVV9SRUdTX1IxNSkpDQo+ID4gPiArI2RlZmluZSBURFhfUkVHU19BVkFJ
TF9TRVQJKEJJVChWQ1BVX1JFR19FWElUX0lORk9fMSkgfCBcDQo+ID4gPiArCQkJCSBCSVQoVkNQ
VV9SRUdfRVhJVF9JTkZPXzIpIHwgXA0KPiA+ID4gKwkJCQkgQklUKFZDUFVfUkVHU19SQVgpIHwg
XA0KPiA+ID4gKwkJCQkgQklUKFZDUFVfUkVHU19SQlgpIHwgXA0KPiA+ID4gKwkJCQkgQklUKFZD
UFVfUkVHU19SQ1gpIHwgXA0KPiA+ID4gKwkJCQkgQklUKFZDUFVfUkVHU19SRFgpIHwgXA0KPiA+
ID4gKwkJCQkgQklUKFZDUFVfUkVHU19SQlApIHwgXA0KPiA+ID4gKwkJCQkgQklUKFZDUFVfUkVH
U19SU0kpIHwgXA0KPiA+ID4gKwkJCQkgQklUKFZDUFVfUkVHU19SREkpIHwgXA0KPiA+ID4gKwkJ
CQkgQklUKFZDUFVfUkVHU19SOCkgfCBcDQo+ID4gPiArCQkJCSBCSVQoVkNQVV9SRUdTX1I5KSB8
IFwNCj4gPiA+ICsJCQkJIEJJVChWQ1BVX1JFR1NfUjEwKSB8IFwNCj4gPiA+ICsJCQkJIEJJVChW
Q1BVX1JFR1NfUjExKSB8IFwNCj4gPiA+ICsJCQkJIEJJVChWQ1BVX1JFR1NfUjEyKSB8IFwNCj4g
PiA+ICsJCQkJIEJJVChWQ1BVX1JFR1NfUjEzKSB8IFwNCj4gPiA+ICsJCQkJIEJJVChWQ1BVX1JF
R1NfUjE0KSB8IFwNCj4gPiA+ICsJCQkJIEJJVChWQ1BVX1JFR1NfUjE1KSkNCj4gPiA+IMKgDQo+
ID4gDQo+ID4gTm90IHJlbGF0ZWQgdG8gdGhpcyBzZXJpZXMsIGJ1dCB0aGlzIG1hZGUgbWUgbG9v
ayBpbnRvIHdoZXRoZXIgdGhlc2UNCj4gPiByZWdpc3RlcnMgYXJlIHRydWx5IG5lZWRlZCB0byBi
ZSBzZXQgYXMgYXZhaWxhYmxlIGZvciBURFguDQo+ID4gDQo+ID4gRmlyc3RseSwgYWxsIHRoZSBs
aXN0ZWQgcmVnaXN0ZXJzIGFyZSBtYXJrZWQgYXMgYXZhaWxhYmxlIGltbWVkaWF0ZWx5IGFmdGVy
DQo+ID4gZXhpdGluZyBmcm9tIHRkaF92cF9lbnRlcigpLCBidXQgZXhjZXB0IFZDUFVfUkVHX0VY
SVRfSU5GT18xIGFuZA0KPiA+IFZDUFVfUkVHX0VYSVRfSU5GT18yIGFyZSBpbW1lZGlhdGVseSBz
YXZlZCB0byB0aGUgY29tbW9uICdzdHJ1Y3QgdmNwdV92dCcsDQo+ID4gYWxsIG90aGVyIEdQUnMg
YXJlIG5vdCBzYXZlZCB0byB2Y3B1LT5hcmNoLnJlZ3NbXSwgd2hpY2ggbWVhbnMgbWFya2luZyBH
UFJzDQo+ID4gYXZhaWxhYmxlIGltbWVkaWF0ZWx5IGRvZXNuJ3QgcXVpdGUgbWFrZSBzZW5zZS4N
Cj4gPiANCj4gPiBJbiBmYWN0LCBJSVVDIG90aGVyIHRoYW4gd2hlbiB0aGUgVEQgZXhpdHMgd2l0
aCBURFZNQ0FMTCBvbiB3aGljaCBURCBzaGFyZXMNCj4gPiBjb3VwbGUgb2YgR1BScyB3aXRoIEtW
TSwgS1ZNIGhhcyBubyB3YXkgdG8gZ2V0IFREJ3MgR1BScy4gIFNvIHBlcmhhcHMgaXQNCj4gPiBt
YWtlcyBtb3JlIHNlbnNlIGlzIHRvIG1hcmsgdGhlIHNoYXJlZCBHUFJzIGF2YWlsYWJsZSB1cG9u
IFREVk1DQUxMLg0KPiA+IA0KPiA+IEJ1dCBldmVuIHRoYXQgZG9lcyBub3QgbWFrZSBzZW5zZSBm
cm9tIEtWTSdzICJHUFIgYXZhaWxhYmxlIiBwZXJzcGVjdGl2ZSwNCj4gPiBiZWNhdXNlIFREVk1D
QUxMIGhhcyBhIGRpZmZlcmVudCBBQkkgZnJvbSBLVk0ncyBleGlzdGluZyBpbmZyYXN0cnVjdHVy
ZSBmb3INCj4gPiBlLmcuLCBDUFVJRC9NU1IgZW11bGF0aW9uLiAgRS5nLiwgIEtWTSB1c2VzIFJD
WC9SQVgvUkRYIGZvciBNU1IgZW11bGF0aW9uLA0KPiA+IGJ1dCBURFZNQ0FMTDxNU1IuV1JJVEU+
IHVzZXMgUjEyIGFuZCBSMTMgdG8gY29udmV5IE1TUiBpbmRleC92YWx1ZToNCj4gPiANCj4gPiAg
ICAgICAgIGNhc2UgRVhJVF9SRUFTT05fTVNSX1dSSVRFOiAgICAgICAgICAgICAgICAgDQo+ID4g
ICAgICAgICAgICAgICAgIGt2bV9yY3hfd3JpdGUodmNwdSwgdGR4LT52cF9lbnRlcl9hcmdzLnIx
Mik7ICAgICAgICAgDQo+ID4gICAgICAgICAgICAgICAgIGt2bV9yYXhfd3JpdGUodmNwdSwgdGR4
LT52cF9lbnRlcl9hcmdzLnIxMyAmIC0xdSk7ICAgDQo+ID4gICAgICAgICAgICAgICAgIGt2bV9y
ZHhfd3JpdGUodmNwdSwgdGR4LT52cF9lbnRlcl9hcmdzLnIxMyA+PiAzMik7DQo+ID4gDQo+ID4g
U28gSSB0aGluayB0aGUgbW9zdCBhY2N1cmF0ZSB3YXkgaXMgdG8gZXhwbGljaXRseSBtYXJrIHRo
ZSByZWxldmFudCBHUFJzDQo+ID4gYXZhaWxhYmxlIGZvciBlYWNoIHR5cGUgb2YgVERWTUNBTEwu
IEkgYW0gbm90IHN1cmUgd2hldGhlciBpdCdzIHdvcnRoIHRvIGRvDQo+ID4gdGhvdWdoLCBiZWNh
dXNlIEFGQUlDVCB0aGVyZSdzIG5vIHJlYWwgYnVnIGluIHRoZSBleGlzdGluZyBjb2RlLCBvdGhl
ciB0aGFuDQo+ID4gIm1hcmtpbmcgR1BScyBub3QgaW4gdmNwdS0+YXJjaC5yZWdzW10gYXMgYXZh
aWxhYmxlIGxvb2tzIHdyb25nIi4NCj4gPiANCj4gPiBBIGxlc3MgaW52YXNpdmUgd2F5IGlzIHRv
IG1hcmsgYWxsIHBvc3NpYmxlIEdQUnMgdGhhdCBjYW4gYmUgdXNlZCBpbg0KPiA+IFREVk1DQUxM
IGVtdWxhdGlvbiBhdmFpbGFibGUgb25jZSBhZnRlciBURCBleGl0cy4gIEFGQUlDVCB0aGUgS1ZN
IGh5cGVyY2FsbA0KPiA+IHVzZXMgbW9zdCBHUFJzIChSQVgvUkJYL1JDWC9SRFgvUlNJKSBhbmQg
YWxsIG90aGVyIFREVk1DQUxMcyBvbmx5IHVzZSBhDQo+ID4gc3Vic2V0LCBzbyBtYXliZSB3ZSBj
YW4gcmVtb3ZlIG90aGVyIEdQUnMgZnJvbSB0aGUgYXZhaWxhYmxlIGxpc3QgKHRoZSBkaWZmDQo+
ID4gaW4gWypdIHBhc3NlZCBteSB0ZXN0IG9mIGJvb3RpbmcvZGVzdHJveWluZyBURCkuDQo+ID4g
DQo+ID4gQnVnIGFnYWluLCBub3Qgc3VyZSB3aGV0aGVyIGl0J3Mgd29ydGggZG9pbmcuDQo+IA0K
PiBOb3Qgd29ydGggZG9pbmcuIMKgDQo+IA0KDQpGaW5lIHRvIG1lLiA6LSkNCg0KPiBCZWNhdXNl
IFZNWCBhbmQgU1ZNIG1ha2UgYWxsIEdSUHMgYXZhaWxhYmxlIGltbWVkaWF0ZWx5LCBleGNlcHQN
Cj4gZm9yIFJTUCwgS1ZNIGlnbm9yZXMgYXZhaWwvZGlydHkgZm9yIEdQUnMuICBJLmUuICJmaXhp
bmciIFREWCB3aWxsIGp1c3Qgc2hpZnQgdGhlDQo+ICJidWdzIiBlbHNld2hlcmUuDQoNCkp1c3Qg
d2FudCB0byB1bmRlcnN0YW5kOg0KDQpJIHRob3VnaHQgdGhlIGZpeCBjb3VsZCBiZSB3ZSBzaW1w
bHkgcmVtb3ZlIHRoZSB3cm9uZyBHUFJzIGZyb20gdGhlIGxpc3QuIA0KTm90IHN1cmUgaG93IGZp
eGluZyBURFggd2lsbCBzaGlmdCBidWdzIGVsc2V3aGVyZT8NCg0KPiANCj4gTW9yZSBpbXBvcnRh
bnRseSwgYmVjYXVzZSB0aGUgVERYLU1vZHVsZSAqcmVxdWlyZXMqIFJDWCAodGhlIEdQUiB0aGF0
IGhvbGRzIHRoZQ0KPiBtYXNrIG9mIHJlZ2lzdGVycyB0byBleHBvc2UgdG8gdGhlIFZNTSkgdG8g
YmUgaGlkZGVuIG9uIFREVk1DQUxMLCBLVk0gKmNhbid0Kg0KPiBkbyBhbnkga2luZCBvZiBtZWFu
aW5nZnVsICJhdmFpbGFibGUiIHRyYWNraW5nLiDCoA0KPiANCg0KSG1tIEkgdGhpbmsgUkNYIGNv
bnZleXMgdGhlIHNoYXJlZCBHUFJzIGFuZCBWTU0gY2FuIHJlYWQuICBQZXIgIlRhYmxlIDUuMzIz
Og0KVERILlZQLkVOVEVSIE91dHB1dCBPcGVyYW5kcyBGb3JtYXQgIzUgRGVmaW5pdGlvbjogT24g
VERDQUxMKFRERy5WUC5WTUNBTEwpDQpGb2xsb3dpbmcgYSBURCBFbnRyeSI6DQoNCiAgUkNYICAg
Li4uDQoJQml0KHMpIE5hbWUgICAgICAgICBEZXNjcmlwdGlvbg0KDQoJMzE6MCAgIFBBUkFNU19N
QVNLICBWYWx1ZSBhcyBwYXNzZWQgaW50byBURENBTEwoVERHLlZQLlZNQ0FMTCkgYnkNCgkJCSAg
ICB0aGUgZ3Vlc3QgVEQ6IGluZGljYXRlcyB3aGljaCBwYXJ0IG9mIHRoZSBndWVzdA0KCQkJICAg
IFREIEdQUiBhbmQgWE1NIHN0YXRlIGlzIHBhc3NlZCBhcy1pcyB0byB0aGUNClZNTcKgDQoJCQkg
ICAgYW5kIGJhY2suIEZvciBkZXRhaWxzLCBzZWUgdGhlIGRlc2NyaXB0aW9uIG9mDQoJCQkgICAg
VERHLlZQLlZNQ0FMTCBpbiA1LjUuMjYuDQoNCkkgdGhpbmsgdGhlIHByb2JsZW0gaXMsIGFzIHNh
aWQgcHJldmlvdXNseSwgY3VycmVudGx5IEtWTSBURFggY29kZSB1c2VzDQpLVk0ncyBleGlzdGlu
ZyBpbmZyYXN0cnVjdHVyZSB0byBlbXVsYXRlIE1TUiwgS1ZNIGh5cGVyY2FsbCBldGMsICBidXQN
ClREVk1DQUxMIGhhcyBhIGRpZmZlcmVudCBBQkksIHRodXMgdGhlcmUncyBhIG1pc21hdGNoIGhl
cmUuDQo=
