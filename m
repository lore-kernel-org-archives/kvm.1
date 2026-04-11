Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B125173;
	Sat, 11 Apr 2026 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775870831; cv=fail; b=IqAaMbGM0X+xPQ11qmadB0N1TTriaUNf6z3wOrd+XCb5qAq0YSCiVzkYIbdfmJrPixY9LQwYo9S578niH1hBI9ZO7ManOtxAhdYQkwb0/69uLiiI2qtN54oz3UaB8U/OKhH2rl45tN/8DMWD4KuftTnyKXR9fNsMBhpeJGSkp4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775870831; c=relaxed/simple;
	bh=bwnnEBFZkX7tEGolGWAHUBbaBuQZ4rfgizzNx6wNxJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDfj/u+8/3UTFnr2YJA1lB7iwNzt/c5pot9FFSvchZyq+IRF03dezgf7UD70Wut94dUDFGnZtIsDIiHDSaxlucT7ma3z4DX5zU5halDb6fsxw65YQAgctNEapse7cgnwYpuZlxo7IQyON/aTkx+lNlrnHxane8jmP2cXjzdRrpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrtipF8G; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrtipF8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775870831; x=1807406831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bwnnEBFZkX7tEGolGWAHUBbaBuQZ4rfgizzNx6wNxJk=;
  b=TrtipF8GZrLy5yO03ns9ZDJlMjtZOpNVMV6R2P8w6wobGRUZXVBBYsJV
   FOAfrtKrMeSTJ3b7GCfUQcaepHKr+FrbV2AWGN3/u/SMA3K/7BRQUBkgH
   TQ3O4ts5aSufClKJc1gqX9dLWKvRJfmfHsriw8mRtdVKH96bmmXggAIFF
   dmWRuXjo7aNn2SZJQa722BMemBgl0XDjldYp1m2CSsihY9P/4c34+ifjr
   D67ErBBp3MmYQYfywzuiRagfLzzU/+iF27Fvo79hF4sUAUf2MAQUt3Kr5
   ibXE6kK2cly9TwYsi9oeZ0ScuBM7fzmQYVjlAMIEYRSwg/YJsKFRdLwIW
   A==;
X-CSE-ConnectionGUID: xh9H8+hVRE+ijDTn2FxGEw==
X-CSE-MsgGUID: oVDEYjn+SdqSIbEV7asPcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="88338245"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="88338245"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:27:10 -0700
X-CSE-ConnectionGUID: gR2pl6m3QGO6MFIw6W2A4g==
X-CSE-MsgGUID: qd4UbPEVR/+ucgkymzEE/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="267228666"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:27:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 18:27:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 18:27:08 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 18:27:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNLZNEvOy7nU60BE4CNggRAz9EVFfvGoQeUebe9R3DgShQ3yWaCOoZXOpF7HVdnTEoDgCoUz4oGrFdG/o/cGoSnGd/w9mBGTgEwDK4gQdrdnd00v6Mbrj8IkysTMAvJpq81Cyl3OV+rFfDC4EzCOk7AWoF9+b5UcJLTYyYXTIYZQ+migCGnpKT/Lk6fxfrlWVg3DABZfjDlWvka/rcPImw3YOfoP3NaEZBhx5xKDrP8aAoLpsJnZZ7ON4Z1W+GO0sYFPLJuFYZdr9rJhlmFfHdhUn6bAuHk+a8/Ku4UCZGtFRFFEIhIdGglfwVQP0A7wHAtVJQyCGCxRKGpxAIBnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwnnEBFZkX7tEGolGWAHUBbaBuQZ4rfgizzNx6wNxJk=;
 b=VTnw8rw2KlmcUp4r+MDcmHmDZSom0rnbW2htj1jRB3sgV/JzM2cu924/3W5UEbOS7910UIwSfQh8Ic4fY+cYLD19pxtZE5mxDYRFKHmJQ/iIdoDDrnwzjfnu9Ycz7QN9Fs+Pzxz8xEzhmkWV5bjfU6dsqO02LK2HJLlYYpu/uS4THX+7S+6NMjcMfbYKODo5Nu5YvX782jYcaTlewoG0ZfoAwzEC3IcM3z65IMILSjLQvHPl/dYDE+UCwiHgDrMICjio3MoG+uuiVx27biDVsZfi5TS4WqFYuB7ER6PbDGLo9KapgBRc0pTm6UvKxBwB/0arIuHEnvCdOcUtnbu29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Sat, 11 Apr
 2026 01:26:59 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 01:26:59 +0000
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
Subject: Re: [PATCH v7 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Thread-Topic: [PATCH v7 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Thread-Index: AQHcwQv/Ma1z1LjCBUm2ZgQgcKxBmrXZInqA
Date: Sat, 11 Apr 2026 01:26:58 +0000
Message-ID: <fb472138f6ba06efd90a3834a5748662d7b7ac44.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-11-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-11-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB6780:EE_
x-ms-office365-filtering-correlation-id: 45bdf226-b70a-4ce5-b645-08de97696d12
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: gE+VwWHelJnomrWhOJ5GZCoNxtfH/vGt4tMYsihIoQ6Fv0nD2MJq1TUo1XrORQv7atoqjZt+uAYkoiE11pmdHkWJeKSOatu2HWlL6VAKSdoo3hy1s9hlWttV0x/vs/SQ841j47ZhU2LT3f9+7+AxiMIp25shnCCNURtl6EYx1mnYKfBnc88VT8no6PDQnop7q1lMO6Bf+2beKPJh9xqAHrImBtq6IxGyOvQ+38E9E7K0Moq3tIYVV/vu2AAO+Gs2tXJkHe9KlT1FbbKlmTidsQx2AvuYaLeVbsNPc3zVXUmjIu3vYATi3EujF0i5c9rqYykB+kvtfqiktaoXeOlpRBDBOK7mmNcEQPgvkriRBAUorjr6KhsEOYnVhl3Xhseq4c/ckgA4vdAuAAIRFyt1WIaxmcqeBwbjLcZ569aLlstfKlhBpFxjdanxwyEJMqtqgSz7xLH0wSqxdMR8NvmTp91ikkOuOQxwdsyQsvPyul2Ce1hHW0YzeJ60aicjDac0gxvrwQUZAmJovfEyf5Y6AuvMikhutx7fL9S7VjyzNm8sJKVn/nAoFf0y06fivZpODatz9Ff9MSPGJF+XX1ZgSZn1ai7kCFVxBmxpMspqHQdE3zP10P2Rc13yOI8NHbA/0e3z0sPlkiP6kVZNMYopJD8SvBkFiboCyxjbiQ4rBTGfimM+hA2hVQcEGD2V6jSAc/AZX9+rnmRVaxIGYPDLCi8uXTcN18m+t1Qk74EPWwztttm7j/JnjLjvdDkcAPBl2KxELP7S7VIosNTU02YNwAkXSgdSQkkS9807dBZ21RA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUtYeldyQktoKzNVTmNTZys0a25TZDltTDBDWWdQOHNaWnlHUjBqLzNtZDNl?=
 =?utf-8?B?M1R0S1lsRVdoMUU0ekRpTjhFRUg0c2ttYi90SDZ1U3BiSFNuamE0bjBaWk1p?=
 =?utf-8?B?VTdENlZYS3dKeENEWXB0NlJETktudFl4TFlVdFBqNHpvWUdFR0lRV2x1Rzg1?=
 =?utf-8?B?cnpNbEJoZzEvaU4xUUFONkhqQVJ3cEd0aE1YREI0RUhFVUlnMEt2clZaUUVo?=
 =?utf-8?B?OGsvaVMycGc0bHU2SVJ6WEZiTHNDYitRdEpqSVN0enArWlEvaFlhQTRGNXRR?=
 =?utf-8?B?TktNeW15OUVBeUN6YnJJU1lhZzBWbGxwUnV1WXpqVXlVV2I3b3JKL1phY2xP?=
 =?utf-8?B?cGc0SS9pVm1EMDlYVDlhSHZMYXVZNHZiYk9VYW1mTTY1VzltZlFzMmpTTVNy?=
 =?utf-8?B?Y2NmRWdTWFZyRlhWeHprTXR4YUVmcldwZEV4eklXRFNuUHg4OEFFTm5KSjdX?=
 =?utf-8?B?Wjl6clQya2x3VytWRVFjdGNJTlUyL0d4R2xYTXhlcCtINHVtaFBPSm5zL2lW?=
 =?utf-8?B?b0lQUElBRVJzQTNiMnVrNW53bXpjeVQwQy94YUh2NEVrQllXaHhVMTNFU0V3?=
 =?utf-8?B?MURwNjAwcmV4ZjlqaFFYVndqNFZDZUJ5eThtVGZQQkxaekpzWElFOHM5OTJB?=
 =?utf-8?B?ZUVzSTNEOUY2enFTZEhSc01HdHQ0MHVVQ0RvcmdBMFNFTHF5RjBUZVBwWkF0?=
 =?utf-8?B?UGFudjUzaUtVWGNuZm0rNHQ1ZXRYakVPb0dtT2ZDWEhPQ2V1aDNyNHBHTGwv?=
 =?utf-8?B?Q2lvRzM4czV1cDZYZVhKVEh4NjlZaU5raXU3WUFSbFhMT2ZIWlZ4OHRielJv?=
 =?utf-8?B?b2V3anhOeStGdm9ORTZVU3Y5V29Kd3NDaHZ2WTFiRmxzZkk2K3BZd0VJSitL?=
 =?utf-8?B?cVQwRDdTMGM3eFBjcGI1bjAxeFhuMkgvU094MTR3Z0RneFd6VkpMK2cvU2Z6?=
 =?utf-8?B?Nm5aaCtqMk5vTURXQnlqdjVrTUJQMlArTVFaQ28rOWVjLzJmVzhrQlpZeXVL?=
 =?utf-8?B?bHZpOGNrajRldkRtdU5VNlZuZHo4QVd6Y3VHMUdqUVJuT2JFYUFYaFlPK1Bo?=
 =?utf-8?B?QnpPK0tSZU5GTVZUUDVPNzdLdUVtTnZGaDZPK3ZreVpDL2R5YzMralc3c3lD?=
 =?utf-8?B?Mmw0dXB3OVhPbXBIWEJVdTdrcnBtRkZvOFhIV29yMVA0VmNGQjNVUlBwTHlU?=
 =?utf-8?B?azI4VG56am5ieFpSZnMzaU5xRHNsaHdSVzNRV3dtRW8vcCtnUmVaeFpSQ3NV?=
 =?utf-8?B?dXUxcG5TSXZkRW5mUU40a3RrMzBSd0NMaGpMbHJhNkljR2lMZUNtOW1QQjlL?=
 =?utf-8?B?ZmxNSFhFTUZQR0Y1dnJ6MkNudVE5dUN5aGR1bWhRNm4rRTZ4amdpSUcvdjdn?=
 =?utf-8?B?d2JvYVNpZ3RxdW5qSkcwSXdsMmFyUkNrQWJuenF5d1BhbjNhMlk2YXc4Y0hF?=
 =?utf-8?B?aVlCODNncWdZNWUzTW53VGVqMVhnOGF0YWs4eGdjV3M2bVBsd1B2TTJQaGVZ?=
 =?utf-8?B?bHV3SnBLYXBxb0syL0k0OWVDMlVjOHBRZEJGUmZSaks0WVltL28rbEN3UDVK?=
 =?utf-8?B?YWNUd3A1Um51NTU0bjlUZzdmZnZjdDZja3FxYTBEa2ZBQ2ZYaVJqTDlIR2Jl?=
 =?utf-8?B?THNUMVpuREJudFIzeGdyUGVzaTU4RzZjaFowOVBjUVN4bU5aUEJBOWw5OEMx?=
 =?utf-8?B?eUtybVJuRFVESWg1ZmZkN0YvVXBxdUY0Uzh1VUl5ay9NWkx0UnFrT0VqNEZh?=
 =?utf-8?B?aXFBVEZHSUZZblJHSlJZRHhiWS9xNi9FUXdKTjZva3pGNTZ3VUxkOFM0aUE4?=
 =?utf-8?B?OGpqVFpMN3hnZEZFVEI2RWxoNUxWTHlZT3ZTclVVN3diZ25Vc1RkODRZeGNR?=
 =?utf-8?B?dS9GT1RuNncvM2FwZFBReS93K2IrMjBZUU9UZEZ4SjZzMzJMT2x6RG1uaC9l?=
 =?utf-8?B?U1NiOTFqa0hLN0NxWWVEdVQyTU9UeU5DOEdzdHAxdGNuTlZHWVhPdVcrOUJN?=
 =?utf-8?B?TEliREJ1Q25DOVA5LzZTeTNBT2ptcHJkYU5BTU80bUo2Q0Y2eURhc2dxVlc2?=
 =?utf-8?B?U0d5Zjd6SFJueUE0eXc4RTZCYStoUVAxZDBpUkg2V3p4Y3QrRmczRmM2Rjc3?=
 =?utf-8?B?R20zU0d6c0NNMDQyQWI1SzVrREZHaEIwV2oyNTZSWHl1K2hRVEQ4NS9Xcm1S?=
 =?utf-8?B?WEZmcFZhUDljQmFOMU5aUWp2aVZZc0l0ODl5ZDlSNnVVSVRrR051eXpQNk1F?=
 =?utf-8?B?SjZYYS9Rc3ZQTmk0ZjlmamtyOEVCQlkyRkVtUS90bVArUzNvWHpZUXhEVkNz?=
 =?utf-8?B?Y3lzS20xZ0hzVnBnbHJHWHpoT0ZwMytUSjVPWVNjMDVUMGtwWXhpWnh5RWVE?=
 =?utf-8?Q?D3QVRlLRQ67v2+zU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8BB5EF842BE204BA79081E6DC422CAD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lYtt2a4+R+U3h9ZoJc6uO1XUFnDoDaWNrbRrHmUnLEhXBhV7tZOXYOx1yd7lD68OsGjkyAduSVspfIeB3ULQ+PTG2ORflnHwcJ+TcpMdyNKH+cB6qBtf9c8BlvgA3deRPQHnHX6aEW3jryrHqIuq8UXGX/wHbrqVTANLJeEecKuWpsJlt+YwlZC5N8vkktiGzO4n3VMBupz/35BUFk8hyC9AsZJYWDoMUMEgpjR89an47BjliqbzuL2iFky0e4nEqGOLHJB40WyKehXvevzjVp4rLZpONdLqqMc6F3S6LRSi7AaMOzuBkUmWvqvxmJBYSlBBE4UN5ri5uRKKFETxtg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bdf226-b70a-4ce5-b645-08de97696d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 01:26:59.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTelnbThSOJ+SoQMCB/8Wr1kL7y/mwq5qxODSs2xG7jmZJTKtDvWCrJ6CGsIi4U5g6G3bpY5SVeLIgROmBSqvb6/6rUT08NGp18+fGXYlns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6780
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IFREWCBtb2R1bGUgdXBkYXRlIHByb2Nlc3MgaGFzIG11bHRpcGxlIHN0ZXBzLCBlYWNoIG9mIHdo
aWNoIG1heQ0KPiBlbmNvdW50ZXIgZmFpbHVyZXMuDQo+IA0KPiBUaGUgY3VycmVudCBzdGF0ZSBt
YWNoaW5lIG9mIHVwZGF0ZXMgcHJvY2VlZHMgdG8gdGhlIG5leHQgc3RlcCByZWdhcmRsZXNzDQo+
IG9mIGVycm9ycy4gQnV0IGNvbnRpbnVpbmcgdXBkYXRlcyB3aGVuIGVycm9ycyBvY2N1ciBtaWR3
YXkgaXMgcG9pbnRsZXNzLg0KDQpUaGlzIGtpbmQgb2YgYmVncyB0aGUgcXVlc3Rpb24gb2YgaG93
IG11Y2ggaXQgbWF0dGVycyBpZiBzb21lIHBvaW50bGVzcyB3b3JrDQpoYXBwZW5zIGluIGVycm9y
IGNvbmRpdGlvbiBkdXJpbmcgYSByYXJlIG9wZXJhdGlvbi4gSSdtIHRoaW5raW5nIGF0IHRoaXMg
cG9pbnQsDQphaGEhLCBkbyB3ZSBuZWVkIHRoaXM/DQoNCj4gDQo+IEFib3J0IHRoZSB1cGRhdGUg
Ynkgc2V0dGluZyBhIGZsYWcgdG8gaW5kaWNhdGUgdGhhdCBhIENQVSBoYXMgZW5jb3VudGVyZWQN
Cj4gYW4gZXJyb3IsIGZvcmNpbmcgYWxsIENQVXMgdG8gZXhpdCB0aGUgZXhlY3V0aW9uIGxvb3Au
IE5vdGUgdGhhdCBmYWlsaW5nDQo+IENQVXMgZG8gbm90IGFja25vd2xlZGdlIHRoZSBjdXJyZW50
IHN0ZXAuIFRoaXMga2VlcHMgYWxsIG90aGVyIENQVXMgd2FpdGluZw0KPiBpbiB0aGUgY3VycmVu
dCBzdGVwIChzaW5jZSBhZHZhbmNpbmcgdG8gdGhlIG5leHQgc3RlcCByZXF1aXJlcyBhbGwgQ1BV
cyB0bw0KPiBhY2tub3dsZWRnZSB0aGUgY3VycmVudCBzdGVwKSB1bnRpbCB0aGV5IGRldGVjdCB0
aGUgZmF1bHQgZmxhZyBhbmQgZXhpdCB0aGUNCj4gbG9vcC4NCg0KU28gaXMgdGhlIHBvaW50IG9m
IHRoZSBwYXRjaCB0byBwcmV2ZW50IHRoZSBvcGVyYXRpb24gZnJvbSBnZXR0aW5nIHN0dWNrPyBP
cg0Kc2F2aW5nIHRoZSB1c2VyIGV4cGVyaWVuY2luZyBhIGZhaWxlZCB1cGRhdGUgYSBsaXR0bGUg
dGltZT8NCg==
