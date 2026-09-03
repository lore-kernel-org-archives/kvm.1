Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9550AC16;
	Thu,  3 Sep 2026 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467960; cv=fail; b=VkNWhXqz1Y31Cs8e9w+IzgtymUQ+ZPub+J0d0P3942X+/AR6vAHtj428kkI1HneMQmG49lHwgCAkEit+1ANxF/DIQz9lVVLdvL6yUWCXbXzoM1r7LPb9maCjyO+shjgr506ixb0Nlmx4utkqs+PF2hajwOveLBFup+Z5955cPA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467960; c=relaxed/simple;
	bh=xUjdeIqRf4SYdAZigEARwDYQr/dev7QzhCv11wjY+lA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aEep1YjHnNMP6htO+FWOvMHowoPggR5x22vvnmPRA+NAodhc1WPg1lwqLIf1aVo9OPW/eqLB5L8/jYY5IZ5dXvYtLIPzhve9oQHlyaOJwp+SednFWa3RmT6A8orblL9VijBpdAEq15rIlAt49Cdt616/d8tf8+vrC0AX+HpC4ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeT/RhBR; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeT/RhBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788467951; x=1820003951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xUjdeIqRf4SYdAZigEARwDYQr/dev7QzhCv11wjY+lA=;
  b=QeT/RhBRg8Q4Lr9TDpLeT0Z6reqWGibk5BTQg/y7aZiZfLLDGWqqHXVm
   PkabOkc98PUUnjo4ej6LA3msURhn3WxJkIT4QaiPz19mUcaWvyDg1nYJg
   P+vrpkVgrKTGii0jxg8eJ/KsLJiopC/er/a1wwMVkmadmtNgMNjxcK77r
   025i8Zhik5I6kdqxGgtdDprDN/mYWB0T8O9qYyjAto1wf9ICbJCIxpWMh
   48UdhkmaUcUeIKGpVLteAqADfDf0Or3OPj7gj3scg0bLpSf1PGuU0pidZ
   neGTCiSn2Wy1wHO9l65LTI4weSWgj1fOZHA1XWX7yJTXJhmjRVWScZZFA
   w==;
X-CSE-ConnectionGUID: r2aycXazTN6aXXn+QkT4Cw==
X-CSE-MsgGUID: ZBJ2Px/uSeSBKjrjo7ZB4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88887890"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88887890"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 13:39:03 -0700
X-CSE-ConnectionGUID: 6KwB5+b7Qe+HKX9JS2Q0/A==
X-CSE-MsgGUID: uy5rogfsSeeypU0asNhp2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="269825004"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 13:39:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 13:39:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 13:39:02 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 13:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDqPKlCEM/h19BRaqV8pvLxv1OiqHIiumOY/ZmEcKbNdbOHqHg8qozPEyZYKgT9poFWnSSMXnBylk3oXYdy90TkHYlkeTHQpLA+9qyMREFU9yQYV9TQjG7lyqE2z3ADVusRWGJUdQDdeM63ezvKH00K3ZvP7IJCVXMOV39TWrGWV/VB0EjCN4VhJUuIh4V8hlvZy9oe/gRbNmkGHZiiCQIsg2AmaHhSDla/00LLtBv1aIfve8/X/fA/dyaHJqlQ5fgITtXT5PrFeLIkqEURPrqIKK/3H0vzHaiJx8/PKt9sKl7Y0jNYZmjYbGhK8/M89gvYRUKPBwHbsFdomOjXpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUjdeIqRf4SYdAZigEARwDYQr/dev7QzhCv11wjY+lA=;
 b=smxmAx6MrOzosOGBIXvXMW8qUgM+0bNdp56P0tjozJ4ZtM0hqWoW/BdN1+5CQ845i+MgbAVPre5R4D/jhnu9Ps8dxfyzTc4BUGZnf7J6FYkzDxWf7OC6XKOaWIhEkgesTiShmyEUk0K5noZr2eOXoJpZrxowJ6iE3B7K8JnuR6kCwdigjKxApBmi88oFUs4NgMX0Ifl7u69+vsrkT6V15147ir5Syvbb+zAuzEfF8/Yli+meLkmnAtOxfj/+xD/ZVGJDUAQ6wIRMB2RyVbAs9YdVfS2Qx5Fw9scPPvaPrPBss7RD+EiHaUYC9pJq8SPOSZH0yg0aQ+KWCmhQ22EAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH9PR11MB840181.namprd11.prod.outlook.com (2603:10b6:510:41a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 20:39:00 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 20:39:00 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"hongyu.ning@linux.intel.com" <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH v10 10/11] Documentation/x86: Add documentation for TDX's
 Dynamic PAMT
Thread-Topic: [PATCH v10 10/11] Documentation/x86: Add documentation for TDX's
 Dynamic PAMT
Thread-Index: AQHdO0a+mQEM0chOC02TaniOPpT/Wra9AJUAgAA+fgCAAAFmAIAAEXeA
Date: Thu, 3 Sep 2026 20:39:00 +0000
Message-ID: <94ebff5d4a229608ad89aa40254f02709b16d184.camel@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
	 <20260903015113.93343-11-rick.p.edgecombe@intel.com>
	 <225572f8-5636-41fd-9315-ef5efb78f0a5@intel.com>
	 <7cd4a38ed0ab1618a90e1afc8d56b450d57a9374.camel@intel.com>
	 <ac7c383e-9da5-4456-97fe-532518d6c2a7@intel.com>
In-Reply-To: <ac7c383e-9da5-4456-97fe-532518d6c2a7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH9PR11MB840181:EE_
x-ms-office365-filtering-correlation-id: 42fbca20-5223-44a8-a850-08df09fb625c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info: 5nzYLqcIrEZbaYA4orNXCSGeDm8DqjvD+PI67XoClPfJcHzTEFfnKYE6LOOahZ23mXyG6UdiHz3TcFbwPZHfAFJRFCOmipMJDttxkYqNOR4GzSEKUizfsAaZEhZkftPOeFpDLJeNlzNfui3deNeAy7oPXu6WHvRC0H+eJ/Qq2yAxZbmHaU0hqrkD8uEq6IPz+wMCtFPaieiawjbjKOS1gnvAs10uoDkfnM5MnJ6iNfGNSMsHOIp2e/pUfpF89dxRRXoCekxQI80F/BRDBcUKiZMvu5+7KeUaZt3VMeSoyNyrO5wHPOvmlvUtf3BIlMaNd4AtEc09z9FANkqgX13ZFlxWcp6N6EI7sqM9nnCRP51WxFb/pvasfI3Gqx6SfzMkTCWewImv1sVdpYwdDUlg9hJBizHQAqK0jUnN22vdp2DzmBESvnCDHdHp+m4JR3TemGRH8O6SkTgYyyjco7Fzz2lFoRvgKlTM1HZeHbZwJKwMmqpzai6NoikQiq9ksBa4HShLsmsmNlOOM4hws5LCOsPfZjkINuKBuYaX2Ji60KhTZiN0Ytzy4y0BZNf6SrN5Rlos/K5i30OBE1OhqqfUqcZOJrR5kSsCsPZzmf/1TKEpbRZl7XHSQhap9Tj34zRKj6+GRC0XWwTpYM2b0ow8iCIoyrK+IcW0YVNsDMpKNuAqMMCRlb9e2zq05obieM0QuUBvSQkPZmPtwbPow8SSceMKd5csZpTLwLMD7CwTmAAMZ4uxaXHMbwwoeCeloBWA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEo2MjNTOSsvOGllRFFrdlNUUWRodTBhd3J4ODdqdElhck9PK1ZwUVcwZHBG?=
 =?utf-8?B?alVhaHg0dXdOcXRVRGVGdnBGSHRoNnVZVmpoaWdQbzE0SHJCRTdVWFlmNndu?=
 =?utf-8?B?QVhhcjZjZzJlYXR4TDNCNkpZYkxWSkNqdDdiR1FtR2pyQ1VPNWlUTnlTRXpv?=
 =?utf-8?B?NmFVMlZnOEtaQXBJYkdPbS9BTnBYdXdxQjhpMnE3UHE5SnFRc3BSUm5ab2F1?=
 =?utf-8?B?TU9EeHAvMWJSbmo3bkpjWC9ZNVRWTVhISFBmRmFaaFVJckF1UjVBVDBtNHB2?=
 =?utf-8?B?NWtxQWFlUUUxL3hublhwNGpvZytpUklGM0xrd0s1bVB1NTVVdS9mVWVuL2hZ?=
 =?utf-8?B?RXBFR0c0NGNRaTFqMk1UUTdXbTNRZGN3N1FRYmhCZWhqVy9CYm1scXpUdTZC?=
 =?utf-8?B?OUllVFRnZ2FFRWtOOWN1SkJMUkFWOGdzS0lSK0JqMlFoVGNUUHZTaG5lK0pQ?=
 =?utf-8?B?cDRxOXhBQ0xsaVZlS0tiK3h6R3VuQzZhK3ZJQS90cWtrZ0UyQWhpRjlmMjdn?=
 =?utf-8?B?Rlkrc3JFYXl0M2l3ejBpSTQ1cU9vVmQrZmtNbUcwbmRVMlNyS29EL2JWdTcw?=
 =?utf-8?B?QlkrSzFFSGVST3BVaEF2OWJyVFBRWG5Fd3IxQm5GMHUvcE9VSHVSNDVBR2VQ?=
 =?utf-8?B?UzFmQ01ERGx6andCOTNjeE9ZZWI5YkplUm5vVmJrZWlRRGkwMC9lZlhYeThh?=
 =?utf-8?B?YU9vS3pmZisvRk5kMnVMdTZxWVMxNWQrcU5iWDM1OHg2L0NGNzBHd2tyamVo?=
 =?utf-8?B?U0duUEtPU0VRQm5zY1grcGZFSjRicngxUEtvMG5iRFF6NmtPTis2akkvQ0hp?=
 =?utf-8?B?elRvbnNGUlpwRUxuQWxBaE5reVoyYiszS25Vd1FpWDYrS3BadjU3b0FQQnpD?=
 =?utf-8?B?TGxuNmhWbnNhZVJ1OGxJQ3dXN3FicUpiQnp1NUZrSnNNZi9LbSs5Zjd2S0pP?=
 =?utf-8?B?bFdQd1EyOGxaT2FyQmRpS0FVdkt4K0ZPVzgzOU1SQ3dvTjBmWnhpMzlER24y?=
 =?utf-8?B?bjdqb25LTHJTaDA5a1BueFhrV1Ayd2VRMG9RRi91NGhZN29uTk1HZXBQdjRN?=
 =?utf-8?B?bDdzbmJTM2RRcWJ2ZjkvWVJJTHFjRDVCalVobGN5ZHdjOVh5M2VmTWE1M2Nw?=
 =?utf-8?B?WWFDVU5lakxmaGNPV2NQQUJQOHVaTnB6VXRDVWMySTNDVVp4NEM5N1ZZTGNR?=
 =?utf-8?B?ZndFWGREeE05aWIzZlkvRVhsVXhNdFhzb1F3QUt0WTNzQ005R0RJN0R4MFFa?=
 =?utf-8?B?eTB6eC9pUzA1STd2RWJ5eC9iZVZZWExCc2FQOVlITmppT0trTGRvVy9uSnd2?=
 =?utf-8?B?eTcwM3dFSVQvV1IyMUVqTC85cmJKL1BadU1FbWV1YTVONWplSEx6Nm9Nc1Av?=
 =?utf-8?B?RXpwbU9HdmF2Nms2N1ZIUmRvS3l5ZGovZHdmN1VZc0J2elpUWVlmbmh1UFpq?=
 =?utf-8?B?S0xkRnhMSnI2M2pQWSt5WjVWQ1FFMzRMYUxaOHNZMUdyYU83dHRmZEVuVDYw?=
 =?utf-8?B?b3A3SWFRQUxxR0tHWFhaMThCeE1DbUVXZEN3eG1McUNDaWxqKytMY2VXSUw0?=
 =?utf-8?B?eHdYRmU2ZUxtcUVpUVJtVDZMVGFIM0x5aFRGZ2xvQUNWYXQrZ0NmKzN0RWJI?=
 =?utf-8?B?YUJ6WDFEbWJyVXZxQmpWb1NLY0ZoWGtseDAweHpzWHVWYUJqcmNubFJOUWVG?=
 =?utf-8?B?aFp2VW5YelJEQTVFV3l2MnJWYnE2YlhyZURIQW03N0tEU3BBYVA2Ympkci93?=
 =?utf-8?B?Z2tvTGVUL0R1bUZkNnE5ZFhQSVVNWTZTdXhLUk0zVXEvNEVsYjJsbXBPWUhz?=
 =?utf-8?B?eGlpRUkwd3p2NEo5SCsyQlVKN3FUZGFUUmVhK2lRUEdzQndVOUwzRzVHYlFV?=
 =?utf-8?B?U3hVN201cWhBc2RNOGRtOVVTSExkSUh3Qm52a3FTMTVRdEFETmd1MU5jaFNQ?=
 =?utf-8?B?MTE4UklwNjRYU0Y0TTZCTjJYZm5zYWdrMVYzcU9MQktDOFhCd1hZbkZxaGdo?=
 =?utf-8?B?R0RWS0laMVdOSkZHdm9IZDdpakFPSkwrdUJseHBaN01DYzBhanFjdlhFRUlt?=
 =?utf-8?B?ZmxzVk9nT0lkUVdOcHdtaWVKMnRLblZ6d3grZ0d4dmovMkh4K3NvNUMrTkZt?=
 =?utf-8?B?Z1UrNldVbkdmTDk0dGtSNUJZQjVyY3JuVkMyaUhIUXBjbWxYTlg2T0ppS2pZ?=
 =?utf-8?B?TndLSE5Nb3NRUUJWRkpORGR1OXVZR09tZHNuLzh0RHJLNFZEcWRxbitSblIr?=
 =?utf-8?B?NzdOVUdsWDFBc0RoUEduY3dNaXJiN1g5VDE2ZEc1Tzgzc0tlNDAxcnlkOFBC?=
 =?utf-8?B?NmhqN01oQmFhUnlHeW8vVEUvb2tLYjE5cWM1YTBUZnhOWit3MzhxWDJ4R1J3?=
 =?utf-8?Q?COjeUuP0qtv3i1WY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7AA1F1368056D4B8F12476A3631D846@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XNoeUS2raFBJQCCz//kdh+lLCbAHpU8Fvdj2NrNV+8GKOdSp0rlCJrXNDw6EH7QaldeZswBlcbLMP7olGgLpmftdbTq0+QNcz6HUmnyC4V8Z5I6hbo4KceK7SaJGYk7bVXkeLU3U1M7iJJiK9FiLe/tIS06eLL6Ci9wpzHlIjSXPc1W79pPwCJVZldfYjQqvi12IaxSG2eSVGzGAzSWHQxkKy/swIQdZp77UJloTnwLmyxDBGEEUxkmZJk5AdjAkNYo+U/LPaLKPeFoC2/ucKbB/NYAfccyB0TGHGzCSgw107YJcfvtCES/ZvmC4zYOqz29t3iwBovZHLoCjo0b+3w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fbca20-5223-44a8-a850-08df09fb625c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 20:39:00.0984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Xr9mKj1p0wu1rcRAjktE+mdLjzoXVtv7UZhYIqrOUBJXwLaE1ZMZdYXG9KCS7IK+5sDooZgCDJfUNWuEhDtB0SCA6MMjbvTwr77JcI2C+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB840181
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTAzIGF0IDEyOjM2IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8zLzI2IDEyOjMxLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gPiBTbyB3ZSBoYXZl
Og0KPiA+IDEuIElmIHlvdSBhcmUgaW5jbGluZWQgdG8gdGhpbmsgc3VwcG9ydCBiaXRzIHNob3Vs
ZCBhY3R1YWxseSByZXBvcnQgd2hldGhlcg0KPiA+IHNvbWV0aGluZyBpcyBzdXBwb3J0ZWQsIHRo
ZW4gdGhpcyBraW5kYSBpcyBhIFREWCBtb2R1bGUgYnVnIHRoYXQgd2UgYXJlIHdvcmtpbmcNCj4g
PiBhcm91bmQgYnkgbWFraW5nIERQQU1UIGFuIG9wdC1pbi4NCj4gPiAyLiBUaGUgYnVnIHdpbGwg
b25seSBiZSBoaXQgaWYgYW55b25lIGhhcyBjb25maWd1cmVkIGEgbG93IG51bWJlciBvZiBoa2lk
cy4NCj4gPiANCj4gPiBXZSBjb3VsZCBvcHRpbWlzdGljYWxseSB0aGluayB0aGUgVERYIG1vZHVs
ZSB3aXRoIHRoZSBmaXggd2lsbCBiZSBkaXN0cmlidXRlZA0KPiA+IGJlZm9yZSBhbnlvbmUgd2l0
aCB0aGlzIGNvbmZpZ3VyYXRpb24gaGl0cyBpdD8gQW5kIGlmIHRoYXQgaXMgd3JvbmcsIGFkZCB0
aGUNCj4gPiBrZXlpZCBjaGVja2luZyBvciBvcHQtaW4gYXMgYSBmaXguIFRoZW4gbWF5YmUgd2Ug
c2F2ZSBzb21lIGNvZGUgbG9uZyB0ZXJtLg0KPiANCj4gSG93IGFib3V0IHdlIGp1c3QgbWFrZSB0
aGUga2VybmVsIHRvbGVyYXRlIERQQU1UIGVuYWJsaW5nIGZhaWx1cmVzLiBJZiBhDQo+IHVzZXIg
bWFrZXMgdGhpcyB3ZWlyZCBoa2lkIGNvbmZpZywgdGhlbiB0aGV5J2xsIGdldCB0ZW1wb3Jhcmls
eSBoaWdoZXINCj4gbWVtb3J5IGNvbnN1bXB0aW9uIHVudGlsIHRoZXkgZml4IHRoZWlyIGNvbmZp
ZyBvciBnZXQgYSBuZXcgVERYIG1vZHVsZS4NCj4gDQo+IFRoYXQgc2VlbXMgd2F5IGJldHRlciB0
aGFuIHRyeWluZyB0byB3b3JrIGFyb3VuZCB0aGlzIHdpdGggb3B0LWlucyBvcg0KPiBwZXJtYW5l
bnQgZG9jdW1lbnRhdGlvbiBmb3IgYSB0ZW1wb3JhcnkgcHJvYmxlbS4NCg0KVG9sZXJhdGluZyBm
YWlsdXJlIHdvdWxkIGJlIGEgYml0IHVnbHkuIEl0IGlzIG5vdCBhIGRlZGljYXRlZCBvcGVyYXRp
b24gdG8NCmVuYWJsZSBEeW5hbWljIFBBTVQuIEl0IGhhcHBlbnMgYWxvbmcgd2l0aCBhIGJ1bmNo
IG9mIG90aGVyIHN0dWZmIGluDQpUREhfU1lTX0NPTkZJRy4gU28geW91IHdvdWxkIG5lZWQgdG8g
dHJ5IG9uY2UsIHRoZW4gbWFrZSBhbiBndWVzcyB0aGF0IG1heWJlIGl0DQpmYWlsZWQgYmVjYXVz
ZSBvZiBEeW5hbWljIFBBTVQsIGFuZCB0cnkgYWdhaW4gd2l0aG91dCBEeW5hbWljIFBBTVQuDQoN
ClRoaXMgdWdseSBoYWNrIG1pZ2h0IGJlIGEgYml0IGJldHRlciB0byBnZXQgdGhlIHNhbWUgYmVo
YXZpb3I/IEJhc2ljYWxseSBkbyB0aGUNCmNoZWNrIFREWCBtb2R1bGUgd2FudGVkIFZNTXMgdG8g
ZG8sIGJ1dCBpbiBhIG1vcmUgY29udmVuaWVudCB3YXkgZm9yDQp0aGXCoGtlcm5lbDpodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjYwNTI2MDIzNTE1LjI4ODgyOS0xMS1yaWNrLnAuZWRn
ZWNvbWJlQGludGVsLmNvbS8NCg0KTWF5YmUgYWRkIGE6DQovKg0KICogV29yayBhcm91bmQgYnVn
IGluIFREWCBtb2R1bGUgd2hlcmUgRHluYW1pYyBQQU1UIHN1cHBvcnQgaXMgcmVwb3J0ZWTCoA0K
ICogaW5jb3JyZWN0bHkuIFJlbW92ZSBzb21lZGF5IHdoZW4gdGhlIG1vZHVsZXMgYXJlIGZpeGVk
Lg0KICovDQoNCg==
