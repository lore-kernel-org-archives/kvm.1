Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88591E98EF;
	Thu,  2 Apr 2026 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172972; cv=fail; b=AK0C30HBTpNO7FrRx6ioWhxBNaFssoOIeFMTfHUch9a5LE3IWxd2qv2Ra2Tujf84KcyBfEtFBgMX7CNDOwyL2poP/D2tv0c4ZZ4197b/DXvXq0X2nvetsoJVGFH+cY1o/Pmji86uXtPdQyHeerMR447okHcnRYqoGDdxsZC8nEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172972; c=relaxed/simple;
	bh=OKH3wQTG7hRJULzBBQUQZ34wBuIKtFh6LQoCBQLLLao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=caCGJS46VuacRcYuRYIkjwAmCeJjx+e7EmTtWiDA7dFMzZoyF4GaohJUOd5vnh+t9ee2lSeBrm17xWpudn7Riw0VRbPgcwo9WWFTOj6COkiX6yfwBeIn9lpEDBbrCZn++5y+hMVC4LYCC9+sCmapO+gre4mlOniKDAVZLf+uJl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aliC4G5+; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aliC4G5+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775172971; x=1806708971;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OKH3wQTG7hRJULzBBQUQZ34wBuIKtFh6LQoCBQLLLao=;
  b=aliC4G5+xCILsy270oPhZVBwoYA5oyD2rAetn6XCoYn+ptMoYDqJlsvi
   UlNXWONklJbh23uGxtWjc13y7OLrYYnxCfeMNiFxnwYfsu2mutFwmC8Ps
   fq8haoq188e6Ns+F1yQq82rSMima7zxq3RXGILRo5NJLxm78QLl0SM7qG
   x00iOhtRQHD+5xOpBUQSUBl7HqvGX6UKX+4JfwSb6MjsptVmRR5XFHNnz
   kocQtipjXLOvPVFn5sG2z7y+C+48HaUMUHG9dUEbBKt/L0oN49RN8wSKK
   X8nyTqYqAU/uKGlqtLB0N+OJ2zcGxla8GZQ0Jl2lVX3dn0D6fC2gnZvDr
   g==;
X-CSE-ConnectionGUID: IuyfqBXVS1ikpjppj6QUCg==
X-CSE-MsgGUID: IuLTVH2XRnWcQ+2OsCvuDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75961285"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75961285"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:36:11 -0700
X-CSE-ConnectionGUID: taZ44qGLQLux2GojtFtbDg==
X-CSE-MsgGUID: 8s7r+MILSpWNufZHNFCNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="265041852"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:36:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 16:36:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 16:36:09 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 16:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBdeMwE4Q0hvo2ljNNjPfGqagVNwtEZzu4el8x47t66p/uV64k73YrxYJRoU74HeCYlYfzJEO2udpJa/toObgPMr7LxXy37Sz7gRcNC0WbCqUaBaZc0x4rl6gamN2ZYxHc8Eam59ePdgjUCie0tqlIiPZlcApMXjN1ZW0/sh0mnnumceOuBA7DRqgXHVCtuTU1BAkuBXO768Eg+ehmXno7GypaeXUvA2KZvI8nRDysUNo9Z/wZ9iCFDZOFDL1vD7zlc1Y9FgoRFewBT3Mwa46M9/pBKkV04uKLE+GHcA3r06v0mfxOo+RWKACyMkHYvLCL0bwQL7sN7AobtzBz2EHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKH3wQTG7hRJULzBBQUQZ34wBuIKtFh6LQoCBQLLLao=;
 b=R6EAF7ttDs3oPYpS4KL1h3211aeQKufO09QDjf9HHmH/TOk5Qo4dgMIxe49lfW73pzVscC8bGf53T1gIjdfSThlZecggneLad+L9U2GmRz1aAjPsxGHsP9KM/ZdhtPujmCmhOnFkf8TvJG8fPZCtyiMu7r2C5QQX9RgRIgC7t7PMkYDC4hxbC6erB8g70Y8/171GwvToHM5gBeFCw+4fHVigg8LxkJKPkh+gbPrJ0CAUGKx+DhBHUZCxviwF3z9vqvFRHsIUv/OERhfd5YqtTgfdGf4c/fefPXX9vrbqLHHrfQW/22lMP1cI0dnQigtCgo0P1dTw+84Yu0pr5jmJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 23:36:01 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 23:36:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "ackerleytng@google.com" <ackerleytng@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "sagis@google.com" <sagis@google.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Huang, Kai" <kai.huang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Topic: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Index: AQHct0DWySj+AXH+Kk26T1K2yM7v+LXMgOoAgAADgAA=
Date: Thu, 2 Apr 2026 23:36:00 +0000
Message-ID: <4f0a5d5f7b743e3872547e14d02b894cd9f60550.camel@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
	 <20260319005703.8983-1-yan.y.zhao@intel.com>
	 <CAEvNRgGknoP=QscA-efLB0LSS03XttsdN3v0KBVROAXTknAakw@mail.gmail.com>
In-Reply-To: <CAEvNRgGknoP=QscA-efLB0LSS03XttsdN3v0KBVROAXTknAakw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA0PR11MB4607:EE_
x-ms-office365-filtering-correlation-id: dcb2e3ed-704d-4b58-094f-08de91109939
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: kVm6xcJFqEnu8Fiksrd4+41bw9hk8n2TZDA5gD3wV+eL9kweBXiy6UP+HNamxW6rusOEHMVgDtESTFG6B6Da6BzvbzT2kNacQ9C9S2AFHI6Lp1lQ/uCaqq9PpfzNW3GbpVBbnMuGi9cJ+s4fhfHJg/lyhsNhWKLqTn6sMk3MZmvij7/iTrhAPFToU6Bpkz0v89RtcGUsjdUsgqguNUo45TOXKJuVxPnw/K7Dt+VepMXhbV0Unb3k3tN9+QZXu3/MQrXyZqma6zGQH047Of4MLAgBomBFZr01lDdCDNE+kmWBuOxpJdQYc8nCsm24Nm7862mPYQasZ8F4T9L3Xk5Zko2+XtGu23ZN4+GgcacJnfKFKEmjBzF7R0ktjm9bX1BT5gyNkwLsbRB8anblSku6HZU0+jeymMLD5LpAGgd+xkt0mvvTkGbJz2vA23Gz5BnmVFZ6+ctmcjj6zskjPbTmzayy7Bso2TJXuWn6m/lnhDfgiu0wTASM7jOG5RhfMX2cqzYPIfnXiLISFTfgqT1l3roFrE1WNjq0VZwtyK2A7ysMQfZKif8O+z3P/kSduqlPjWbV8qXIGrdeQhD/ReNp67y4utM8mu8yIqRJ7xPihQRux0u7wEf72w+dfeL1gYg3sV/AChgrG8CHiZsiNAhtRezvxnqg0wQWA/IH1jEEushxBaT7xwKeSOpboUgNm6lptxC8vGKrBHu2Ty146n6ogwxAZ++Zu02+EQMb7cjXhRHJQIkMLOm4XHfFv9yqBhxd0E5L7SDoc20nsFzxjezrZAalM8ubt8VnVDN2Aa6xhF4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFUxYi9BK3FFZ1B1K2FBaGdVSUw0VVU5WFA1a1FHcCtMbXV5OW1RbFdpZng5?=
 =?utf-8?B?cFkvdTFtNWc3ektRMmJTSGR5R3lOdWo5ODJkWElxRFptTHpZQm1SbEIzNFBX?=
 =?utf-8?B?QkRtM0ZiZlVSUW5sem9sOGl5cHJBTUg3TnZhODdiYWorWFQ4a1BEY2p4bnhW?=
 =?utf-8?B?ZEl2eEtUOTZJMmhZWWdjVWlkUGsxZThvSmVMTE82SEErN04zKzcxNE9XL2VO?=
 =?utf-8?B?ZVRyV2d1bktmUk5LbUtaa1VFelNZNGMwdDNzTVVrUWlSaVVrM3VSdXBRZlFI?=
 =?utf-8?B?NDNiY3RvSlM3MjBxVm9oRVJHYTRTRXNXZ3ZzcHltUmNlR2ZKdXNkMDl1dG4w?=
 =?utf-8?B?L0VGaDAxYzhNKzQyR3ZDRC92RXpCZi9jN01jano1N0thdmZyYXdZYlNFU1Ev?=
 =?utf-8?B?TWwvWHJ5OXBNandVNEFFZVdxQmpmMDVoRTdxbGtxNGwyWlBIR2t5ZUY2YlV3?=
 =?utf-8?B?bXdOY3dlaEVRRVVMNkQ3VGx6emd6R3grRFVLaUJPcmVqQ0sycXhESC90M0dG?=
 =?utf-8?B?UWtRMFpMcVJ1TllkZDJ3bXN4WHNqWWx5RTI0dlhaOWpzeThRZ0hFYlMva1ZI?=
 =?utf-8?B?OW1xNWRxbHlPSGs3bmdWd0I4Mm5ONjlvQm1lci9wVk5Qb010MlgrL1krRko1?=
 =?utf-8?B?VWRueERVVlRTQ0ZOQjA5MC9XMVhxTTlXZElhYWxFK0hHYkNNWGdiOVl3ODRM?=
 =?utf-8?B?WEVDTWVEUWZtQ0JIczI4MFBNSzBpb1U4N3ViR25oVWMxOHpRcnM0em54TFk5?=
 =?utf-8?B?TEYyd2VpeXlZcjA3THhmZUVlT3hBMWx0OURBaittT2JNb2lQNzY5YWdRR1BN?=
 =?utf-8?B?UXpDdDRVYVBvWWQ3dnByM2w4TnJVVXZUVjFLOER3cTFwN1FENWIrUzZNOGhm?=
 =?utf-8?B?dEpXaW1OS0wrcDVUOWhPU1VaUkEzcU9tSVVpMjJJZTNNditjL1AyMGd0UkJC?=
 =?utf-8?B?dDhjYm8zNHpRb1gwUXVYK0ovMmhZMDN6NnBKTktsVG9ESkJnUTB3WW8xZ0dY?=
 =?utf-8?B?dWpWcHhPdU1RS0JncldCbzB3OHZQTTZlcXJxUUlwWGJLWWN2R1Y0L3RMdm5R?=
 =?utf-8?B?OHhJZmxiOWtiOTNuVDM4Yk84RzdKN0N4elV3WnovKzZCcTJTR3BjZGFQZEwv?=
 =?utf-8?B?Y2FDL1RXMmRxUzljUU5yMDBNMEVRd245cjhVdjhOMnJSNmhIVlpUVjhFVkZ0?=
 =?utf-8?B?TFc3YXh3MzdEUDlwYnI2b0I3RW5adWpNVDJNb2lBeVdPTTBMdEV6cjloTVhF?=
 =?utf-8?B?b2NoMFltV3duQkdSZjZSRW9RSjlWaFBUaTdDOEt3MlNCSVlxNEJDd2dqL1k0?=
 =?utf-8?B?aE9EWlN6WFNYcUJqSzl5c3lIaktyMnV4QzdTc2Fic0ZtWitrbHdqKzF4NStw?=
 =?utf-8?B?WFlGNFJPNVZJOTVLL2FLZDd3bWs1RDdyODlqdUlHenc2Q2JYUng1TjZMNjMv?=
 =?utf-8?B?RWRKZEhFZ3k3QlpqOGdBLzU3UzdadHdCa2Rka0RwQXlZeDhsdktCMnpOQWMw?=
 =?utf-8?B?Z1E5RGF5YmE0TE8wWm04UXpCWXo5S2RpY2JJZEl0bVlUOEREbC91NjVMbTB0?=
 =?utf-8?B?S3FIOTJRclJoTVR2YzhiQVhOTmpNczZXUWxiV08ramxhSWdpWkdWYWxicDZx?=
 =?utf-8?B?dDAzVEpGQlB2ZDBtZGNOL3hQVlMzZGp4MnJrQ2ZoRHRxcDFxN1Fld29nQklm?=
 =?utf-8?B?TkpuMW5HdEIxME9ZNTB1dGNoYmNHQm5NVFlvUGE1WUJqcnBJZkpxZlE1TldO?=
 =?utf-8?B?YUtDNC9FMWFwaTZlTk9tTVhVNVpoZzdXNEVLaGUyWk5rY2RNUEo4N2tjc3FR?=
 =?utf-8?B?NEhCK3RQczBWSkp3TG8vekRycjB6VGZ3M0cvaHlEQk1qeTdDVmFxN3VZOVNi?=
 =?utf-8?B?c3RicFgwcjFGWk9zSG5LckFaVkJjUkdEOHVJMVRnRUs5czZ1TzJoZXB3MUlr?=
 =?utf-8?B?ZFk3NVZiYlQ2NEJtYTNvS3A1NndiTklMTUFtcHZybTBmNGdDbVJvbUZzQ01Y?=
 =?utf-8?B?NytSR2JXaHZnSnl1U1ZKU3RIdFlsQVl1OUREK3NoOUNVYlJkTFFuOStxOWIv?=
 =?utf-8?B?YnhVUWY1R0Z2Z21Pa3c2dzhXcURRNEFBZjhUbU96SytUVjRxMlpBV0RPRXJj?=
 =?utf-8?B?SStNUnlMV3pIdW1DcktwcSt1RW5kOHJQZlBmc0RQbU9IeTZzSFZVVExTRVRF?=
 =?utf-8?B?L2t0Y3RUaFlmUDk0V05SWmhydzh2SEFwTncxL1g3WERKcTM2dWVKRGIvQWJZ?=
 =?utf-8?B?aXJRakszdEluaGY4SWs5QkxNRlFBcEQ5VXhFNHAwbkZRNzA2THJiYXN6OTdi?=
 =?utf-8?B?NU5NTHV4Zkk0akdVUkxmSnowUk51ZDdaTFFySDRLQWJ1M2NBWjd6azl3Qy9H?=
 =?utf-8?Q?Fs8ZbyCWUEY7/4sI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0766DC8248EF144B1FF4460CD7074F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R8E5bpXGWFIl86CGOdCmT3RtPzK8v5W83vTfPznPrJ0CXdQSKBHAMltJr8YPy4v0bpo+87mPNcOK9wIb47VLl+4bGKOylLNCF+wVHJFl9noBWVW/EgRg8I2QXSG5IHZkd7jPy5lMnUz5KStQ5hNyc+Gqc6qDljVNg5D1gZSm7SYCUkZA8b+NGK4qJbKqdSXA1LLAYwfggozn/KB/TGEPI6rZk1MDCMX7UHPPd4wnnuKmrE0aUoSn3/zsCCtMeaCYDZ+C2CkQIeuJCz3ry9a7q8zuQaIh6hI/8YXj3wdWBGyZ/c7AJRlTaFG4lbif7hAqkTPp8ekFTxQJgXvcHg0FqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb2e3ed-704d-4b58-094f-08de91109939
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 23:36:00.8985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rC6m/V5Wz70GZvVG3GYsz9JUg0Y6ajoo9jP0/ozRyrOq9yRHYnfiL10HXC3bD1NUGgSSyxO5nevuE1Jrge6a95s/HfBZB38gNVabO7/5IPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDE2OjIzIC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
IFlhbiBaaGFvIDx5YW4ueS56aGFvQGludGVsLmNvbT4gd3JpdGVzOg0KPiANCj4gPiANCj4gPiBb
Li4uc25pcC4uLl0NCj4gPiANCj4gPiAtdTY0IHRkaF9tZW1fcGFnZV9hZGQoc3RydWN0IHRkeF90
ZCAqdGQsIHU2NCBncGEsIHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3QgcGFnZSAqc291cmNlLCB1
NjQgKmV4dF9lcnIxLCB1NjQgKmV4dF9lcnIyKQ0KPiA+ICt1NjQgdGRoX21lbV9wYWdlX2FkZChz
dHJ1Y3QgdGR4X3RkICp0ZCwgdTY0IGdwYSwga3ZtX3Bmbl90IHBmbiwgc3RydWN0IHBhZ2UgKnNv
dXJjZSwNCj4gPiArCQnCoMKgwqDCoCB1NjQgKmV4dF9lcnIxLCB1NjQgKmV4dF9lcnIyKQ0KPiA+
IMKgIHsNCj4gPiDCoMKgCXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHsNCj4gPiDCoMKg
CQkucmN4ID0gZ3BhLA0KPiA+IMKgwqAJCS5yZHggPSB0ZHhfdGRyX3BhKHRkKSwNCj4gPiAtCQku
cjggPSBwYWdlX3RvX3BoeXMocGFnZSksDQo+ID4gKwkJLnI4ID0gUEZOX1BIWVMocGZuKSwNCj4g
PiDCoMKgCQkucjkgPSBwYWdlX3RvX3BoeXMoc291cmNlKSwNCj4gDQo+IFBlcmhhcHMgaW4gc29t
ZSBmdXR1cmUgcGF0Y2gsIGFyZSB3ZSBjb25zaWRlcmluZyBhbHNvIHBhc3NpbmcgcGZuDQo+IGlu
c3RlYWQgb2Ygc3RydWN0IHBhZ2UgZm9yIHNvdXJjZT8gV291bGQgd2UgYWxzbyB1cGRhdGUNCj4g
a3ZtX3RkeC0+cGFnZV9hZGRfc3JjIHRvIGJlIGEga3ZtX3Bmbl90Pw0KDQpDYW4geW91IHJlbWlu
ZCBtZSwgd2l0aCB0aGUgbmV3IEFQSSB3ZSB3ZXJlIGdvaW5nIHRvIGRvIGFuIGluLXBsYWNlIGFk
ZCByaWdodD8NClRoZW4gSSdkIHdvbmRlciBpZiB3ZSBjb3VsZCBtYXliZSBjaGFuZ2UgdGRoX21l
bV9wYWdlX2FkZCgpIHRvIG9ubHkgaGF2ZSBhDQpzaW5nbGUgcGZuIGFyZy4gVGhlIHBhc3Npbmcg
b2YgLT5zcmNfcGFnZSBpcyBraW5kIG9mIGF3a3dhcmQgYWxyZWFkeS4NCg0KTGlrZSBJcmEgd2Fz
IHBsYXlpbmcgYXJvdW5kIHdpdGggaGVyZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8y
MDI1MTEwNS10ZHgtaW5pdC1pbi1wbGFjZS12MS0xLTExOTZiNjdkMDQyM0BpbnRlbC5jb20vDQo=
