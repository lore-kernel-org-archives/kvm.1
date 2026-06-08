Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB6356A12;
	Mon,  8 Jun 2026 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917348; cv=fail; b=liTiM+pnm0idXtWTbPm9abQgY7AGakvCVI1Tb8lKCmjDfgij8GdOUx0PzgA9uFYFoMwKwKFpM7dEsN4qHCHAq4tozU8KzfiFNzcnveZB7pIu0IbZIo6o1Z/mdm1UkJPzPIWdUyccLn7TzR4fEjbpS03EXW4AZgcwMYDcPtlwy+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917348; c=relaxed/simple;
	bh=G3J0Gvfa8L6jDbWF/oREQmvwB3dxJpB7D7vUHKxu6lA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=teV91Cr8JbHA1AE+3gkyHSUjaMh3sokQRqaYJ0jTWWTeduCqIGfAVxlresTWjr9ezQx+MajM9OAF3R9zNL/Xud1AmpORCEl5gWdrutCnxjxSTW6oC6SgAl9JKR5ZgwddHt0WsWv37TMz5FwM/9mo8+Dfvp8cdnPTkGlZAgUen2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+TmsD+U; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+TmsD+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780917347; x=1812453347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G3J0Gvfa8L6jDbWF/oREQmvwB3dxJpB7D7vUHKxu6lA=;
  b=f+TmsD+UdpZq3QjnEXXgeSIg6U50GpKuYdNKowoQ4cv6xlRnexTiphu3
   LYHYoZ4O9Y7PtP+TxxOeouJK4HhEY9qIzqivr8lBQ+XDJnO3wTPL5q5hX
   Jks1SzhMuvhqAp8hg7l1SvkJLFb2S9kSH9a9olGnDzWNICylGxOx0pQTD
   wRmVc7FtppbRWv7GAgWUQCui+IhX6eyNEGPNDcfyT5vB9VKFPftFKlWVM
   GDQoi+oWWPnCBHwS2CJpt+uaBK0tBTuAVUGArfGMIRVKVJlCe0wHQuR+K
   4s0WYImwHqpx3B5XXR6FeCHX9gjXH5M1+bth/pSaGf17etQQtSh1oWYsk
   A==;
X-CSE-ConnectionGUID: eRn3f6kiRU+LlTfdIU6K6Q==
X-CSE-MsgGUID: adnHyxpLTha4lO334vdiaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85275289"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="85275289"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:15:46 -0700
X-CSE-ConnectionGUID: LCgQK+IoSd2A1/29eE+Rng==
X-CSE-MsgGUID: XPiP4OIpQfWWGrlm7f3V/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="269228875"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:15:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 04:15:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 04:15:34 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 04:15:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5QwmfSp9FEHV28TuM+oxUb62+48dYJ9vGUvlTJ1hE0BYgCiSLjk0Gk7cLj/b3ee+8XuxPytWQVYbUjl12s+AqoKYWIcDDocBD13oWzYO8XFr72fEnk3lUZvSm6C6+h7MAw+coaSP9PBmvQQHoxbj3A5RpDEs/LWlj6XBanldPnMeIktWMkjaqZsx+5nr/ryG2K414lA0Greuq8GiRWWNbLFFTdMwOKTPaayTbASOTMxEpxFZAd4w7dYEPOvFN0wLjqL1uk+4F5+g6/PG4bEx/dq+eci9PlghL64LVjkQom/Wv7ZYNOj9XRtPp98YWCwxKkppdhjHr0V2Udo+HVKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3J0Gvfa8L6jDbWF/oREQmvwB3dxJpB7D7vUHKxu6lA=;
 b=J5ifNkFbRII6emybyTJdc67sSykudeB6M2c+w4cxTLPUEuY2agRRU1TWulsQGbOuawahHvTrb3M0KJt15CG19RhykqO9xGFrqwSc1qTXMFSNcE9AgjQw5Bt6tvxE1hQ7zhOZKWempVKTKeV1Zivq28VVcQ2RVeR5EPAJRmXpJXOFJsTmrdnb6unP3pg7IBmsQmtIE5CSRAcmvUFSdQhcqDbQHJ1uRNWtqyuBxJRSb8vXItjeFaBB3Xkr8+TeRR3cGTX4Jv3y5BzOGLsR4IuVweiNO8yQ/63qVwAgApZHsCGbJeL3ulM3+fdTz5a1/VgDIAucJsOnu/R6ouBoJUxc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CY5PR11MB6138.namprd11.prod.outlook.com (2603:10b6:930:2a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.12; Mon, 8 Jun 2026 11:15:32 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 11:15:31 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"paul@xen.org" <paul@xen.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>
Subject: Re: [PATCH v3 31/40] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
Thread-Topic: [PATCH v3 31/40] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
Thread-Index: AQHc77nLxoh5kHwb2kaKk0hzQ9PktbYvoH0AgADM3wCAAA5/gIAEFOwA
Date: Mon, 8 Jun 2026 11:15:31 +0000
Message-ID: <fc3ca448b3f791c75d9037ff97a66259c1aa18c8.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-32-seanjc@google.com>
	 <e1c32d6ba008a443797d26dba21cb9ae59b39f93.camel@intel.com>
	 <aiMrnk8a5fsWfze9@google.com> <aiM3x2cMQo3O9O2s@google.com>
In-Reply-To: <aiM3x2cMQo3O9O2s@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CY5PR11MB6138:EE_
x-ms-office365-filtering-correlation-id: 6be342ed-4d7f-4854-069c-08dec54f4127
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: XKAMf5HdKQhyO5T1GbHAx2EAnNKfZvMVujZAlwUckaN8z9xtOvfwCbY452a2x2Jq/M74fneL1lIoPm0SPcsn/9FBY2jkEuUtIlxgBq8eV/xBI+uEE0P6RvIhiYOouH465X07vy2NQsq3iHpdGTEMfdrVN+hXK6UPJQ14GuUo/1xrS05loZpunUdjGm/Cbwxek27wVZ3ypAsH54VQRQdWjdQv1kucuxiItyBFB7veSy8wvvT/jAywJcnXy0R3+BJcZamZWM2Foohv+hDfFOkvXQ/ajn0qOQgOif88rWLvHwCCKkovoXVgGR+6/HoL+w2vmiPDgNyRJqZCKqQXjshPhkSiT6GQvLA7JnCLqIYXpKnpDEvkGj+PtgPDJnyssqmFx5k+UlzJZhSIy8Q30HE0cSjUKoycppOciP/L5WM0fM3yXfVHV9WX1MsiDVCg2xuDibfsJH9TawjGTCx7j0wUJ/O1Z8/xKi5uXSqY/agzF68a4f2DXkf87+v2S7DItqzykg8xh+fO0wcpHyoM9wcyryuvghQKuHXxzgqXJgpdStQRauVEb7vGsgnFnZlfUcSTbsYHn6kR/YTJ+5/+tBSsB67pfyCCfUUkHQgy2unUFQhRCUN/PZeIOEmUVaXZ3HVgpKqlZb2Dbv/GprUBnE6Hm8bZX5+0tizM7BxOvLmMRcGQtzYmcTpVMpypQO9aiZ3CjMx8W+1CzCTFmI5S9JR9QYYClgszf9wuW8Xp7wiHTesiVWqYWYry7j9lXynmga25
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjJZNUNjVW1jVG5IZjBvUld2aWdWcDhXaThxdUZDU0dYTTRvUDQ2UXl5TkJs?=
 =?utf-8?B?L0FCTDZsMzdsQWJrSFc4aXBwejJsdVFQN1ZVTlQ3a3dFU01VMm1ZOWdETVFZ?=
 =?utf-8?B?M1o3RVd4YUpqbUs5a0Q4Y05aSlpIZDUvVFE1WE1kZ0QwWGU0dG9GWHZlb1pl?=
 =?utf-8?B?KzJkaWs4TituS2xIOUl3M0Y2QkxreGlPRjhYY1hQT2YxYXFaMTRSOEo0S0ZV?=
 =?utf-8?B?Q0wyNkdtcm9vanFvdldRaXNXWXF5cjZQNklkakJkU0FyYnRuZGdpclJWb1U0?=
 =?utf-8?B?cmorUlIvbDdpdHJSUStoRE0rTkR3U3pQTTEwN1dwOXUxRStzdU4wbS9uUzh5?=
 =?utf-8?B?NWJYT0dhZlFwa25nMjg1WTRjcnhVMFpqVnJqU2xsSGVkbzA3eCtXQ3A2Vi96?=
 =?utf-8?B?SmhqK1VXbGt4R0NRRE9kZ1J4VWZmUk1MY1k4eUNaMXZmODhJcWZkWmRhOHhH?=
 =?utf-8?B?WTFKY2E1RmxFTmNqZ0dTZmRNc082Z09oT3pPRllCTnVzbEQ0TFU5d1BOVU9x?=
 =?utf-8?B?Q010ZlVUdHY1L2U2cm1GSXducjVHSVNUT2Zaa1Bjc3YxazlvQlJOaGhvZ25H?=
 =?utf-8?B?L0VXbmlWbFpjeDRDQTVnMGxEL1dZVGY1aHdCNXgxdk1Ma2ZQdDc5aGJiRWdk?=
 =?utf-8?B?dFlUUEI0Rk5Sem1pckllaTFFbGI3NDMyOWhsaXFjMkRncCtmSGlVT1hta21o?=
 =?utf-8?B?MlkvOWM1SWhGREhsUzRaRWlqSUZVSG92RzliaUJnR3FuNVlFdUUzbk9BazJn?=
 =?utf-8?B?aU5wWndyVXNHZDdPV2tPVzJjTGZJbUNrZkVIbzEyTjE1ZEdhSXpNWEVQRG5n?=
 =?utf-8?B?MkFOS2NBNUNTeFAycEZFeG5OWUZZWFV0bkhNQUN2cU03SG9VRnp6Ni9MNmJ4?=
 =?utf-8?B?elZoS1NRdGlMdDlGdDZzRDBCOWJHallLSENUSFgrUHA1c3RoVWo1QXFJVnFL?=
 =?utf-8?B?aWQvY3BHNHRkMEdMYWFLSG5mU3l0OERZOFgwN29vLy85YmhHTXBDL1U3aHpX?=
 =?utf-8?B?NXhoOVNGdXBtbUxFY0dyaG5BeTdLQXBtLzRBQ3cyZFNtM3Y0Ti9BeUpWWWli?=
 =?utf-8?B?bkxCT0xyUVV5a2tPVlBwbG5yYW9uZGtYd2NzYkhielFwZVdqVElSRWoxSmpS?=
 =?utf-8?B?TDY0VmZadlV4RC81RHVIZ3BxVWZxUFNESjZseEdmWjRHaVBDYURMeEhJdzJl?=
 =?utf-8?B?Ukphc0lzTkp2cVVIOG1XQ2lmWGR3SVA2ZjEyQWFDeW1HNHY0WkMraFpNMVl4?=
 =?utf-8?B?Mk1TUHBMUVpZVTRrc0N3Y1lDQUJkQXpoRFh4TFpiVHVENnRnL1pVcGhuOVh1?=
 =?utf-8?B?MCtlWjArcjNjanVQdHo1dmlmYlQ3Q3dUQlA1Z0h2Z1pqR2k0OVVKVG9UK1d1?=
 =?utf-8?B?cmdONnN5VURsdGRVVFhxT3NWdUgza004UXBQQ0Y2TGZuKzl2R0pUS2RVcUlp?=
 =?utf-8?B?UksySzdKeldyRUdWRjhaek1hZGdRZ3F6cTdTMm50b05yNS9qUHRobnJTUk45?=
 =?utf-8?B?SitNb0pXRXpxUTF6ajlFclFtcFVNVkhEc3RVbEwzL21idVE5U3hWYUcrbTZD?=
 =?utf-8?B?MHcyUUZoemorTXIvdWUwSWZ4d0dyQnF2UmpmSllCdEw0YkJ2a2JWVTllOG1L?=
 =?utf-8?B?MDZBWE9pVStZT0w4YVh2aDJhZzNrK1VZWGVTekJyTXN1ZzdTbmUwS3ZtMWJ2?=
 =?utf-8?B?bXQ2SUxqV1ZBZWlkdTJNbGpycWJKWGxFTXpXd3pCbXlFaFFpaVFVQVI4VzFz?=
 =?utf-8?B?Z3NSeS81cUR1SWVrc2xvRWxCUEZMUjZSUEFFSmhBRStXWG1GSHZFMW1GVEsz?=
 =?utf-8?B?OVo1bUNPQ0wxWGlRZEVvUzlNcEh0clUyN3l4aGpMWVI5akZ2Q3BvOWFNcjRu?=
 =?utf-8?B?NGFZSjJXSVZDVlMyTnJIYU43NENaMXpPbTc5ZGFGMUE1dVh5aGU2elNPK3RZ?=
 =?utf-8?B?Q0xzTEtFZm1TNFpkSWRubkVKL290WFMxQXpsNVR2STRMVW5UY0luZVdhNjhv?=
 =?utf-8?B?WDRiTE1POCs3dGFYdVM1bDh5amFLbWZzV0hzenlLcHVOSlVNL0R0akY5RXRU?=
 =?utf-8?B?dWdWWWpqN2psL0FLY1BjZjVXN2dVQUNURTdUTzJJVmdxZDM4TkVKTFhRZFY5?=
 =?utf-8?B?czMzbFpoVTFKU0RJQTgrd2RzNFlORVlqT3d0dVNnVEV6NlM2eGVsS2FyckFN?=
 =?utf-8?B?S2VwNXpyN2FnRVpLTHBBOEFPZDhmemRDVkQvV3pjVjBGR0RSR2hqak1KcjEr?=
 =?utf-8?B?LzhHNmdpRThIam9IZjZmdGgxZUpJRE9JZHQ2cE5Hd1dJTmtDQlUyeHBvMHlz?=
 =?utf-8?B?UjM0UTF6R0ViUEpUMjByeXozNzdXbzlTZTZuOUJqbXRDK3lPMkluUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CDADCBF88713246A03C013ED37AE439@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Scbacm3JT6G0cx15E2o6FljuYkYmZW1zHZu3ne0JVZFhTI+InmH5pUEaV3WN0XDFglVa0ZTWJCzGvWe6qNKp+9ZayrirfPyDQBt0mrtiP7A+tMfxy3qX+OHY2kvvj3f/HXdOaJh3ROQNnIIgI0lR3o8Ah0AByDcCD2b/VyyVCo5zKvWnW5M4lWnnCDiPUdDUeaDYJZG1fhSNCpqt3gk89i5Jm4Kh4PdSMG6cJj13gGtKv6TAVtRSWbk6iUie85q817QSAAbHORVn7oDkmHD9ZpY9p8xNNmqRIwIXZQ5wnUOaZxQAho8+5EhA9o5uD2bHjpbH36UQp+KUjAwm4QnF+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be342ed-4d7f-4854-069c-08dec54f4127
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 11:15:31.9308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVc9OwfppJTixm2sXzCFo3+qqT9B3ya71WmEqolQrhuLQQg26HPqXFv/Vo9EflzrnMYOp6NjEqyaOU4Bbov80A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6138
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDEzOjU1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBGcmksIEp1biAwNSwgMjAyNiwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiBPbiBGcmksIEp1biAwNSwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+ID4gI2RlZmlu
ZSBLVk1fSFBBR0VfR0ZOX1NISUZUKHgpICgoKHgpIC0gMSkgKiA5KQ0KPiA+ID4gI2RlZmluZSBL
Vk1fSFBBR0VfU0hJRlQoeCkgICAgIChQQUdFX1NISUZUICsgS1ZNX0hQQUdFX0dGTl9TSElGVCh4
KSkNCj4gPiA+ICNkZWZpbmUgS1ZNX0hQQUdFX1NJWkUoeCkgICAgICAoMVVMIDw8IEtWTV9IUEFH
RV9TSElGVCh4KSkNCj4gPiA+ICNkZWZpbmUgS1ZNX0hQQUdFX01BU0soeCkgICAgICAofihLVk1f
SFBBR0VfU0laRSh4KSAtIDEpKQ0KPiA+ID4gI2RlZmluZSBLVk1fUEFHRVNfUEVSX0hQQUdFKHgp
IChLVk1fSFBBR0VfU0laRSh4KSAvIFBBR0VfU0laRSkNCj4gPiANCj4gPiBIdWguICBPaCwgL2Zh
Y2VwYWxtLiAgSSBsb29rZWQgYXQgdGhlc2UsIGJ1dCBzYXcgdGhlcmUgd2VyZSByZWZlcmVuY2Vz
IGluIGt2bV9ob3N0LmgNCj4gPiBhbmQgbW92ZWQgb24uICBCdXQgdGhleSdyZSBhbGwgInNlbGYi
IHJlZmVyZW5jZXMuICBTbyB5ZWFoLCBJIGFncmVlIG1vdmluZyB0aGVzZQ0KPiA+IGFuZCBJTlZB
TElEX1BBR0UrVkFMSURfUEFHRSBtYWtlcyBzZW5zZS4NCj4gDQo+IE5ldmVyIG1pbmQsIEkgd2Fz
IHJpZ2h0IHRoZSBmaXJzdCB0aW1lLiAgS1ZNX05SX1BBR0VfU0laRVMgaXMgdXNlZCBpbiBzZXZl
cmFsDQo+IGxvY2F0aW9ucywgYW5kIEkgZG9uJ3Qgd2FudCB0byBpc29sYXRlIHRoYXQgb25lLg0K
DQpSaWdodC4gIFRoYXQncyB3aHkgSSB0aG91Z2h0IHlvdSBwcm9iYWJseSB3b3VsZG4ndCBsaWtl
IG1vdmluZyB0aGUgcmVzdCB0bw0KIm1tdS5oIi4NCg0KSSBmZWVsIEtWTV9NTVVfUk9PVF9JTkZP
X0lOVkFMSUQgYW5kIElOVkFMSURfUEFHRSBhcmUgbm90IHF1aXRlIHRpZWQgdG8NCktWTV9NTVVf
TlVNX1BSRVZfUk9PVFMgYW5kIEtWTV9NTVVfUk9PVF8qLCB0aG91Z2gsIGJ1dCB5ZWFoIGxldCdz
IGhhbmRsZSB0aGVtIGluDQp0aGUgZnV0dXJlLg0K
