Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82727FD5B;
	Fri,  3 Apr 2026 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775241644; cv=fail; b=tsXMHf0fkQorpBjTXkUDvQf5RSfWdFFuNiZT8zYkzXOKf3FFLEBhxIPY0T14oSOnRP0aUSFk5oYXAtnWWbxPgb5aepLXQjI7MSsklNxxdZn3VliV+gq+UHhRkEmEZncoyhHOIUlHhwJ72tUcCbrXn/9S9KNK+VFThoGpZUVvGUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775241644; c=relaxed/simple;
	bh=GKL2r5SRA2JbL5OWsqxo5iGMLgmzPlyGzK1h1HFvZxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DH2wVUNqCOEQdj532Q1F9nYvLo81VVCW1AjaDoduzUkK9NA1I/OhvUG32ZRS0L0UpNX5Vkpxul68bWajn2CimaEuZJWNrUH0Do4GkOeLNkEwapTF3kX/qPV89EB+o/06oNBH8P8OySfl+9SMovBOQoiVKzoQt8IOT3bOtPhS9IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTC67wPj; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTC67wPj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775241642; x=1806777642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GKL2r5SRA2JbL5OWsqxo5iGMLgmzPlyGzK1h1HFvZxg=;
  b=mTC67wPjoao+9+1HLJ+xqqOXmu03M0hJ1bm0yskjoMl4QSfS3H5Ce6hD
   UyAqHX5eN45p/QWZzNj1itP2pqxd9YO+4d/GTs5LG15TfT1mNeFSWBP5I
   dKd+4t2mpyfZyB7L7VKgbikeasChWKFDwjR6xjTiKAzBvlFhxjFrA8kRH
   8KJy5algkAlgzsF1RQ8YYbS2kCHEs4VoohAy1ViS+KQDUVr7Dtz5t1Ju6
   ETpvm2G2o18slQ0d+GhgME3szsJQ9UdS+qQp8zSLpPsUHjK9fXqzxH6Ij
   nljBKucqI+yz6wlD789kiGj68PO32Ylq2R3PTECusd3Mdqifnm6DJaJpE
   w==;
X-CSE-ConnectionGUID: OCakhU+SSLKLV8HHgNyixg==
X-CSE-MsgGUID: TB4OoH7bQP2WLmJYaFtc1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="86606825"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="86606825"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 11:40:42 -0700
X-CSE-ConnectionGUID: g5GwvwLWR8yRnoGUhvUo6w==
X-CSE-MsgGUID: kPMXIV6JRP6Y+agmQk5QVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="232252363"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 11:40:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 11:40:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 11:40:41 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 11:40:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fu7ycqegWHSOAUImzbQgiFUMVv04x/XXmBWszD2NdQPfRf1wR8o+eUi+iPNgkH4/gi7NE/PJsa3OXwROPcFuMAase93c0kPsSRZZirZjAcbG1WGbctP7J3OOUoz9cbAUX1kjATjr0PJsMEn1Ow81wHV/qY30/DzvVaw4r1Swa715Tf9c2/6uWKZbfqPme/JsGXPRmU+GdbaSS/HKPx+wWJ9THrCrvAvvImTkF0HCCVkaJRBvt8gYk+oDYxJoGyeM37j/bCX2R6vH2pp2lHVI+U5ItQY0QwWGHbnSZkt+cSc1m9h8kJyj7HDa8rGv40UE3BOgDG+smpQJqO+4z2Lykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKL2r5SRA2JbL5OWsqxo5iGMLgmzPlyGzK1h1HFvZxg=;
 b=Hupi+fHLMDrdfAOe0jDq+toIzwuNsZ126G633uPdYIWUZC6ybmSVwCl6s99DTK2Bv/IYzlRmjAOuXwmFZ5PeXpgxbXfk07TjAzO7D85/NmRNhAVeMBjQEMbepyNB9dqXre8NKpIacWpHYidia1l/B1jSO/e36Esgs4HrpNbJQPT92xyQ9HgPFnEO3E5fofIcRPjXdLPLzLVfXkfJKPi0Vgfc9vpHJ2uUlzpuiNe3/WJtADVZX9gTrptLPCZR+ci2gLzjomXqfUJD0zvzJ6KW7gChq1bh41KZxjG/yOyqioLUm6exhu/wwe4navHM0v5AHRJyFqYfEoK7cnoTG+asgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 18:40:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 18:40:37 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "tglx@kernel.org" <tglx@kernel.org>, "Hansen, Dave"
	<dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "dmaluka@chromium.org" <dmaluka@chromium.org>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org"
	<kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
Thread-Topic: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
Thread-Index: AQHctwnFo9ayO2gQokudL8i/bTewfbW0sMWAgABcswCAAAmDAIAAYmaAgADG/ICAF2AAgIAAJEgA
Date: Fri, 3 Apr 2026 18:40:37 +0000
Message-ID: <401db97a254b356ad8539a5d637d68ee826179a5.camel@intel.com>
References: <20260318190111.1041924-1-dmaluka@chromium.org>
	 <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com>
	 <cb99e44c-8bc9-4bab-b485-9f63a4d0b262@linux.intel.com>
	 <93358559-5ed1-4574-8951-24d7ea9354e4@intel.com>
	 <ee8d7ea3-0ece-43cf-ab07-6954df4c01ad@linux.intel.com>
	 <f67179d7050ae28ac261bb6227b1c045c10579c9.camel@intel.com>
	 <ac_rNT69TdocrMYc@google.com>
In-Reply-To: <ac_rNT69TdocrMYc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8657:EE_
x-ms-office365-filtering-correlation-id: 5ad80ce8-5e20-4494-8992-08de91b07fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: OTec/WBh6bHT/zL56v5Oec/dEj+ehE5bLFUSPGZ+6JcYGMhDxYZb9yyUqlizVTA4Z3umzfUbTr/0OvJwQ5C0EnTOyasR2Sil4fyI7TETJ+HV5AC4BtCWbBPl/KjIu83SeUnpPqZu528Qn/JfGH6vAne+4HODYuX0GewsiUfcJOsxsEb3UsYBx0zDBBW00AMiuqiHWWsw+a1llC9nBgc5Ff5cucH6HdxU99cjaIwmoNrIiIJXaLfjoiYrZlULVTtIMmgmTcY9ClJ4Ay6MvysnADhmDwUO5EW/1tQ+HkFkpaXSkVNz0xHYdMhmpcJfYPlQGyGCUzWz8Gl7h0QuxLE30iOM4JggG/+aEybW44J9cYSgKX/shhdDMCB0ef0HgBG5be4AtdcnOCOs6yg9jdDz102NdT6yorll6YUS/KF7TCJwoG1ZrWDN/KOwxbYcQeyKCMmwYT2EP4jDuIzFR8gVb1Rv8Hzm0s9VxiwgK5KUbADyLKiZyJKtHEvsYYInRA4IT3b4wPRZoyNB0/FpAcvd45GZcCCxWlV7SIE4qAKSbVr5uUkuZZ7YEt4cAKdMWmtzSQZOZLaftqFeKh5O5WfhUdstvXfME9X+Cxnkz7RoYItlEw1UM2R8dprJPiG7Q9GEgRrWbqgmAGUJ42vS9LY3moudug42CLotvubK+DbW+nIsgkDMrPtRBpbkwOxNUfG86FgCu7ET4JDCclqcJQqZRiEgzq6mQdmutt1r3ZWJmZfcXaA0MJmNUkqR4BX5cmDQthxeB3pwmU2ZFJiBRssKBnFnlcUZYDRvS/J8c0rbOkg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkpQV0pyQTRNZ05FNTFyVk1YU0RjV0JxeDkyUjBrSzVRdE9GZXZWN3NTNDZr?=
 =?utf-8?B?czNpVERPb1dyUG9MM2x2U0x5WndNNTROTGNsKzJxV2hLQUFPaGhRMjROYlBZ?=
 =?utf-8?B?WlNsd1psZjhXY1NKOWFxOFRhV3F1L05Fa1NEYTh1VW9DSzZvQnZZT2t3WDRI?=
 =?utf-8?B?OUVvWWpIaEFYNTcxTmxUdnl0akFvNlg3NC9FK0JISkRNdTBMT211R2dOT0ow?=
 =?utf-8?B?ZEJobXhybmtDbjJ4Z2F6Z3BqMGZnQWdrMUp1QkwxbWMvZmg5YWgyNi9LY1NV?=
 =?utf-8?B?SDllMFRBOUZEelhhTUhldG4yWGtlNXV0Z3R5UXZCbzVSSGl1Q1lvSHlWZlRP?=
 =?utf-8?B?TEtYeWh4bG5sYmZUdXMwUHdHTi9KTDNyL0NQM3BYVVJTenRVSno1MzFiaWJQ?=
 =?utf-8?B?Z0xGVnJubjQwV3VHdFUvZVdoWHV6YnhBdVI4NTlGRURQanczUjljcWNIdFln?=
 =?utf-8?B?S3lJNmI0N1hIR09iTHU5ZmNJTmpZYmxreUZnRlhFWjJTdVV6bEI0Q2h1ZnFU?=
 =?utf-8?B?UFBKRzlHUmVGYjBWdnFUaytzSTRKclQ3OUlwQXQ0WmM2MHlQZXIyaEJ0Yzd5?=
 =?utf-8?B?ZmNSV3dvUVRISGhVeUpCMzZlYlpxNHF5dlQxd2ZhVHZlNUprc1o5L1l6dHpw?=
 =?utf-8?B?SXhaZTFTWjNGNC9NS3Q2KzIxeWR5QVhNY2crM25PNDdzcGVHRzhQVXpuMktJ?=
 =?utf-8?B?dnVzQjJQSXJTOWFYeVROdEZ0V0ZJOHNZL3Q1dlBTdC9rWWVSTi9pVTlHZVlp?=
 =?utf-8?B?dmg0M1puRFZZdDZyQy9KOFBXMlJyTU5sZEUySk5WS3ZiSDhiZDVwYWpHR2Zv?=
 =?utf-8?B?NUFKYksybnkrcEZrMENWZy9lTkxPd0NyTHhHL256NVBBM1U1NVFPZzVnTDJO?=
 =?utf-8?B?UFNsTC9uSnQxWGtHVWpFbTBMZWI0d1pxQTR2Ti9SMy9JSEgvT0xtMDd3Z1Z2?=
 =?utf-8?B?djBhbTFudDN0U0ExVWFRTmhlQkVacUs0OTlVMGYwQXl2cEx0RzVJNm1CU3dX?=
 =?utf-8?B?WS9SdVNPellzcEs5MEVaT0hnT29yaXY4bU5PRmFFWnhDN3dLaVJMSWVueU9y?=
 =?utf-8?B?RG1JMXNSckRBOGxleVk5c0N6VE02OEprejMrWVhLTlpQR3JLNDBLV3JLbEEx?=
 =?utf-8?B?VVBNaWE0NnZLaDREQlY4cTkrVWczcU5sTzdrYmtzQ1YrRWNObVVlN2g3S0xl?=
 =?utf-8?B?RmRUeHNnTGpoMUpVVkZnUkdISm1DYTRvUVYxTG9ZbEFyY1lNSDVJcFBFWmRU?=
 =?utf-8?B?Um5PTWVqcFRrVjhUSFptVU5qVE1CbXBmNytOVVVXK2d2SC9yY0hkemlYOTE5?=
 =?utf-8?B?QW03RFpBRUZudmRackZHdkZDWWpHK2VrVGtzd0lENk5xVXR1QWFSRER2V2Qy?=
 =?utf-8?B?cjExZER1UFc5Z2hIbWVMTlJsRktsR1BKcVdKdWlwTXA2dlk1M3VSbURvcHFT?=
 =?utf-8?B?VDg2anVXcys1VlFGRGlSTzFPZ0tlQzAwYW9YRmpZV0ZlMUxUOVY4bk9sTStH?=
 =?utf-8?B?c1ZuZWxYbzU0WVE1YTRWWUZtRFpLVi8wTnQxNkU2bzhVOXFTdnBJRG5oMzUv?=
 =?utf-8?B?eWI3VHBOclVIRXNvM0hSQWFoSGplbUxpZVBQKzhxMUJ2TFRTT2VOeU9WVnRh?=
 =?utf-8?B?VTNjR2NPN3FEUFJjSlBxczJpVUljamFoM3lVSjg5K3RTdmc3TEpkYVV2UWRm?=
 =?utf-8?B?ZTMvOVlINmVFdFExVnhpM1NqWkJTSjRiTHNJWW52dFZIb2hkc3VSQVcrN0h1?=
 =?utf-8?B?N3FEWitJd3Ryekx3cmoxcEIyaEQzUWlHdWpGaXpqV2lLTENMeGVrdkdWMk5M?=
 =?utf-8?B?dlEzUDI2cExjZWkvS2wwV1BGNkFjVEVWRVlwNk9HSzd2QmlkeFFKeE9OZmN4?=
 =?utf-8?B?UTJBbHZXclVPdktOU2FJN1h5WnFSKzl5TmN4ZTY5Z3BjeS9EK0hzTldnU3NP?=
 =?utf-8?B?WkFpdW9mNkNEejZtc2RLSXA1TThIamhFZ01RTjlXYTBZWEVZTlZ4L21oWGFI?=
 =?utf-8?B?T25qck41eEJjRVlxNnErc3dNYkNqalJza2pmYzdBMHdUbmJNOGJxVm5KNjh3?=
 =?utf-8?B?MmtHTkFLQ0p6TVlOcnBnQlh2WjV0YmFFQitiZ0xPTnJtcEJDUTk5aG5sZVBL?=
 =?utf-8?B?UVZ0bXpER01GMVFsdUJ2YnorQnVzNFJobkhvWW1oY0NkcDZzMGdoQ2ttaHJl?=
 =?utf-8?B?TlFBaVcwc3VueXNSNmZiRXFvS0l0SlFoZ3h3amZlbkJuZHJTLyswazRnbG9G?=
 =?utf-8?B?UThzbjFtRVI0Umdrd1RDQmMwNHgveXQ0cE9HdDlidEFhaXk5SlNEd3RYcWZi?=
 =?utf-8?B?clREOXM3eTNQTmtvSEVzU2tCSjJyLzBKa2JvYnlEc01GVjkrd3NFYnV5WFc4?=
 =?utf-8?Q?P2Dn0Yjc/RH833SM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6449CB88A1EDDE4FA205423C4115F425@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gRIJzjB+BL21Q5UvUBENynEkooLYKwVPd7sbdC6/6EW+pjzFVVU6N2+uFgnQKaSZCKquXetZhhXbKQlecM0SzmacIzA2OtWx3NoAPpST9zmwcZzRdhje8FmAHYZ10eI/wuQN3mU7jL+hipfS5CDWrtZ7P6BAmS0p5vQ80b6oJcyQCN0SfllomChTPZanrj588XTZMvjJRVaSnsj1k6YMSm9VFbppb9vfQEqp1kHA82fsUrgeMucshZUHTTIT3Q1OXguFNgfPjOlzQP9q5m9VTVtwmpYXmBKzwGgp6kSt7njCalIIyFdvsE46XzIcZfTD65jjnLJo//ZgB/ynDR17Eg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad80ce8-5e20-4494-8992-08de91b07fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 18:40:37.8248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aB7lSPRHolNbrSxi9BI1+H/ED71hQbxKTkDeP6YgI8+3VFqtH8Ver0BVxaToOGZ0OLp2C9kNlr/sX71nsm7o61Tmt4qL19C4XLV/PqdcOlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA0LTAzIGF0IDA5OjMwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUaHUsIE1hciAxOSwgMjAyNiwgUmljayBQIEVkZ2Vjb21iZSB3cm90ZToNCj4g
PiBPbiBUaHUsIDIwMjYtMDMtMTkgYXQgMTU6NDAgKzA4MDAsIEJpbmJpbiBXdSB3cm90ZToNCj4g
PiA+IHRkeF9oYXNfZW11bGF0ZWRfbXNyKCkgaXMgdXNlZCBieSBLVk0gdG8gZGVjaWRlIHdoZXRo
ZXIgdG8gZW11bGF0ZSBhIE1TUiBhY2Nlc3MgZnJvbSB0aGUNCj4gPiA+IFREVk1DQUxMIG9yIGp1
c3QgcmV0dXJuIHRoZSBlcnJvciBjb2RlLg0KPiA+ID4gDQo+ID4gPiBEdXJpbmcgYW4gb2ZmLWxp
c3QgZGlzY3Vzc2lvbiwgUmljayBub3RlZCB0aGF0ICNWRSByZWR1Y3Rpb24gY291bGQgY2hhbmdl
IHRoZSBiZWhhdmlvciBvZg0KPiA+ID4gYWNjZXNzaW5nIGFuIE1TUiAoZS5nLiwgZnJvbSAjVkUg
dG8gI0dQIG9yIHRvIGJlIHZpcnR1YWxpemVkIGJ5IHRoZSBURFggbW9kdWxlKSB3aXRob3V0DQo+
ID4gPiBLVk0ga25vd2luZy5CZWNhdXNlIEtWTSBsYWNrcyB0aGUgZnVsbCBjb250ZXh0IHRvIHBl
cmZlY3RseSBkZWNpZGUgaWYgYW4gTVNSIHNob3VsZCBiZQ0KPiA+ID4gZW11bGF0ZWQsIHRoZSBx
dWVzdGlvbiB3YXMgcmFpc2VkOiBDYW4gd2UganVzdCBkZWxldGUgdGR4X2hhc19lbXVsYXRlZF9t
c3IoKSBlbnRpcmVseT8NCj4gPiA+IA0KPiA+ID4gSG93ZXZlciwgdGhlc2UgbmF0aXZlIHR5cGUg
eDJhcGljIE1TUnMgYXJlIGEgc3BlY2lhbCBjYXNlLiBTaW5jZSB0aGUgVERYIG1vZHVsZSBvd25z
IHRoZQ0KPiA+ID4gQVBJQ3YgcGFnZSwgS1ZNIGNhbm5vdCBlbXVsYXRlIHRoZXNlIE1TUnMuIElm
IHdlIHJlbW92ZSB0ZHhfaGFzX2VtdWxhdGVkX21zcigpLCBhIGd1ZXN0DQo+ID4gPiBkaXJlY3Rs
eSBpc3N1aW5nIFREVk1DQUxMcyBmb3IgdGhlc2UgbmF0aXZlIHR5cGUgeDJhcGljIE1TUnMgd2ls
bCB0cmlnZ2VyIGEgc2lsZW50IGZhaWx1cmUsDQo+ID4gPiBldmVuIHRob3VnaCB0aGlzIGlzIHRo
ZSBndWVzdCdzIGZhdWx0Lg0KPiA+ID4gDQo+ID4gPiBJdCBjb21lcyBkb3duIHRvIGEgdHJhZGVv
ZmYuIFNob3VsZCB3ZSBwcmlvcml0aXplIGNvZGUgc2ltcGxpY2l0eSBieSBkcm9wcGluZyB0aGUg
ZnVuY3Rpb24sDQo+ID4gPiBvciBrZWVwIGl0IHRvIGV4cGxpY2l0bHkgY2F0Y2ggdGhpcyBtaXNi
ZWhhdmluZyBndWVzdCBjb3JuZXIgY2FzZT8NCj4gPiANCj4gPiBJIHRoaW5rIGZyb20gS1ZNJ3Mg
cGVyc3BlY3RpdmUgaXQgZG9lc24ndCB3YW50IHRvIGhlbHAgdGhlIGd1ZXN0IGJlaGF2ZQ0KPiA+
IGNvcnJlY3RseS4NCj4gDQo+IFVoLCB5ZXMgS1ZNIGRvZXMgZG9lcy4gIEtWTSBpcyByZXNwb25z
aWJsZSBmb3IgZW11bGF0aW5nIHRoZSBBUElDIHRpbWVyLCBpc24ndCBpdD8NCg0KWWVhIHRvdGFs
bHkuIFdlIG5lZWQgdG8gZW11bGF0ZSB0aGUgaW50ZXJmYWNlIGFjY3VyYXRlbHkuIEJ1dCB3ZSBh
cmUga2luZCBvZg0KbWFraW5nIHVwIHRoZSBjb250cmFjdCBhZnRlciB0aGUgZmFjdC4gSWYgdGhl
IGd1ZXN0IHBlcmZvcm1zIHRoZSB3cm9uZyB0eXBlIG9mDQpNU1Igd3JpdGUsIHNob3VsZCB3ZSBt
YWtlIHRoZSBjb250cmFjdCB0aGF0IHRoZSBWTU0gc2hvdWxkIGhlbHAgaXQgY2F0Y2ggaXQncw0K
bWlzdGFrZT8NCg0KPiANCj4gPiBTbyB3ZSBjYW4gaWdub3JlIHRoYXQgSSB0aGluay4gQnV0IGl0
IGRvZXMgcmVhbGx5IGNhcmUgdG8gbm90IGRlZmluZQ0KPiA+IGFueSBzcGVjaWZpYyBndWVzdCBB
QkkgdGhhdCBpdCBoYXMgdG8gbWFpbnRhaW4uIFNvIHRkeF9oYXNfZW11bGF0ZWRfbXNyKCkgaGFz
DQo+ID4gc29tZSB2YWx1ZSB0aGVyZS7CoEFuZCBldmVuIG1vcmUsIGl0IHdhbnRzIHRvIG5vdCBh
bGxvdyB0aGUgZ3Vlc3QgdG8gaHVydCB0aGUNCj4gPiBob3N0Lg0KPiA+IA0KPiA+IE9uIHRoZSBs
YXR0ZXIgcG9pbnQsIGFub3RoZXIgcHJvYmxlbSB3aXRoIGRlbGV0aW5nIHRkeF9oYXNfZW11bGF0
ZWRfbXNyKCkgaXMgdGhlDQo+ID4gY3VycmVudCBjb2RlIHBhdGggc2tpcHMgdGhlIGNoZWNrcyBk
b25lIGluIHRoZSBvdGhlciBNU1IgcGF0aHMuIFNvIHdlIHdvdWxkIG5lZWQNCj4gPiB0byBjYWxs
IHNvbWUgYXBwcm9wcmlhdGUgaGlnaGVyIHVwIE1TUiBoZWxwZXIgdG8gcHJvdGVjdCB0aGUgaG9z
dD8gQW5kIHRoYXQNCj4gPiB3YWRlcyBpbnRvIHRoZSBDUFVJRCBiaXQgY29uc2lzdGVuY3kgaXNz
dWVzLg0KPiA+IA0KPiA+IFNvIG1heWJlLi4uIGNvdWxkIHdlIGRvIGEgbW9yZSBsaW1pdGVkIHZl
cnNpb24gb2YgdGhlIGRlbGV0aW9uIHdoZXJlIHdlIGFsbG93DQo+ID4gYWxsIHRoZSBBUElDIE1T
UnMgdGhyb3VnaD8gV2UnZCBoYXZlIHRvIGNoZWNrIHRoYXQgaXQgd29uJ3QgY2F1c2UgcHJvYmxl
bXMuDQo+IA0KPiBXaGF0PyAgTm8uICBLVk0gY2FuJ3QgZ2V0IGFjdHVhbGx5IHJlYWQvd3JpdGUg
bW9zdCAoYWxsPykgTVNScywgYWxsb3dpbmcgYWNjZXNzDQo+IGlzIGZhciB3b3JzZSB0aGFuIHJl
dHVybmluZyBhbiBlcnJvciwgYXMgZm9yIGFsbCBpbnRlbnRzIGFuZCBwdXJwb3NlcyBLVk0gd2ls
bA0KPiBzaWxlbnRseSBkcm9wIHdyaXRlcywgYW5kIHJldHVybiBnYXJiYWdlIG9uIHJlYWRzLg0K
PiANCj4gPiBGYWlsaW5nIHRoYXQsIHdlIHNob3VsZCBtYXliZSBqdXN0IGV4cGxpY2l0bHkgbGlz
dCB0aGUgb25lcyBURFggc3VwcG9ydHMgcmF0aGVyDQo+ID4gdGhhbiB0aGUgY3VycmVudCB3YXkg
d2UgZGVmaW5lIHRoZSBBUElDIG9uZXMuIEFzIHlvdSBtZW50aW9uIGJlbG93LCBpdCdzIG5vdA0K
PiA+IGNvcnJlY3QgaW4gb3RoZXIgd2F5cyB0b28gc28gaXQgY291bGQgYmUgbW9yZSByb2J1c3Qu
DQo+IA0KPiBObz8gIERvbid0IHdlIGp1c3Qgd2FudCB0byBhbGxvdyBhY2Nlc3MgdG8gTVNScyB0
aGF0IGFyZW4ndCBhY2NlbGVyYXRlZD8gIFdoYXQNCj4gdGhlIFREWC1Nb2R1bGUgc3VwcG9ydHMg
aXMgbGFyZ2VseSBpcnJlbGV2YW50LCBJIHRoaW5rLg0KDQpOb3Qgc3VyZSBpZiBJIG1pZ2h0IGJl
IG1pc3NpbmcgdGhlIHBvaW50IGhlcmUuIEFzIGFib3ZlLCB3ZSBkb24ndCBoYXZlIGVub3VnaA0K
aW5mbyB0b8Kga25vdyB3aGljaCBNU1JzIGFyZSBhY2NlbGVyYXRlZC4gSWYgdGhlIGd1ZXN0IGVu
YWJsZWQgI1ZFIHJlZHVjdGlvbiwgaXQNCmNoYW5nZXMgd2hpY2ggb25lcyBhcmUgYWNjZWxlcmF0
ZWQgYW5kIHRoZSBWTU0gaXMgbm90IG5vdGlmaWVkLiBJIHRoaW5rIHRoZQ0KYmVsb3cgaXMgYSBz
YW5lIGxpbWl0YXRpb24sIGJ1dCBkb2Vzbid0IGxldHMgS1ZNIHBlcmZlY3RseSBub3RpZnkgdGhl
IGd1ZXN0IHdoZW4NCml0IHNjcmV3cyB1cC4NCg0KU28gdGhlIGxpbmUgd291bGQgYmUgdG8gYmxv
Y2sgTVNScyB0aGF0IGNhbiBuZXZlciBiZSBlbXVsYXRlZC4NCg0KQlRXLCBJJ3ZlIGJlZW4gdHJl
YXRpbmcgdGhpcyBzZWNyZXQgY29udHJhY3QgY2hhbmdlIGFzIGFuIGFyY2ggbWlzdGFrZSB0byBh
dA0KbGVhc3Qgbm90IGJ1aWxkIG9uLiBJdCdzIGEgd2hvbGUgc3ViamVjdCB0aG91Z2guLi4gTGV0
IG1lIGtub3cgaWYgeW91IGFyZQ0KaW50ZXJlc3RlZCBpbiB0aGUgZGV0YWlscy4NCg0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdGR4LmMgYi9hcmNoL3g4Ni9rdm0vdm14L3Rk
eC5jDQo+IGluZGV4IDFlNDdjMTk0YWY1My4uMjhlODc2MzA4NzBiIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3g4Ni9rdm0vdm14L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L2t2bS92bXgvdGR4LmMNCj4g
QEAgLTIxMTYsMjMgKzIxMTYsMjYgQEAgYm9vbCB0ZHhfaGFzX2VtdWxhdGVkX21zcih1MzIgaW5k
ZXgpDQo+ICAgICAgICAgY2FzZSBNU1JfSUEzMl9NQzBfQ1RMMiAuLi4gTVNSX0lBMzJfTUN4X0NU
TDIoS1ZNX01BWF9NQ0VfQkFOS1MpIC0gMToNCj4gICAgICAgICAgICAgICAgIC8qIE1TUl9JQTMy
X01DeF97Q1RMLCBTVEFUVVMsIEFERFIsIE1JU0MsIENUTDJ9ICovDQo+ICAgICAgICAgY2FzZSBN
U1JfS1ZNX1BPTExfQ09OVFJPTDoNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIHgyQVBJQyBy
ZWdpc3RlcnMgdGhhdCBhcmUgdmlydHVhbGl6ZWQgYnkgdGhlIENQVSBjYW4ndCBiZQ0KPiArICAg
ICAgICAqIGVtdWxhdGVkLCBLVk0gZG9lc24ndCBoYXZlIGFjY2VzcyB0byB0aGUgdmlydHVhbCBB
UElDIHBhZ2UuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgY2FzZSBYMkFQSUNfTVNSKEFQSUNf
SUQpOg0KPiArICAgICAgIGNhc2UgWDJBUElDX01TUihBUElDX0xWUik6DQo+ICsgICAgICAgY2Fz
ZSBYMkFQSUNfTVNSKEFQSUNfTERSKToNCj4gKyAgICAgICBjYXNlIFgyQVBJQ19NU1IoQVBJQ19T
UElWKToNCj4gKyAgICAgICBjYXNlIFgyQVBJQ19NU1IoQVBJQ19FU1IpOg0KPiArICAgICAgIGNh
c2UgWDJBUElDX01TUihBUElDX0lDUik6DQo+ICsgICAgICAgY2FzZSBYMkFQSUNfTVNSKEFQSUNf
TFZUVCk6DQo+ICsgICAgICAgY2FzZSBYMkFQSUNfTVNSKEFQSUNfTFZUVEhNUik6DQo+ICsgICAg
ICAgY2FzZSBYMkFQSUNfTVNSKEFQSUNfTFZUUEMpOg0KPiArICAgICAgIGNhc2UgWDJBUElDX01T
UihBUElDX0xWVDApOg0KPiArICAgICAgIGNhc2UgWDJBUElDX01TUihBUElDX0xWVDEpOg0KPiAr
ICAgICAgIGNhc2UgWDJBUElDX01TUihBUElDX0xWVEVSUik6DQo+ICsgICAgICAgY2FzZSBYMkFQ
SUNfTVNSKEFQSUNfVE1JQ1QpOg0KPiArICAgICAgIGNhc2UgWDJBUElDX01TUihBUElDX1RNQ0NU
KToNCj4gKyAgICAgICBjYXNlIFgyQVBJQ19NU1IoQVBJQ19URENSKToNCj4gICAgICAgICAgICAg
ICAgIHJldHVybiB0cnVlOw0KPiAtICAgICAgIGNhc2UgQVBJQ19CQVNFX01TUiAuLi4gQVBJQ19C
QVNFX01TUiArIDB4ZmY6DQo+IC0gICAgICAgICAgICAgICAvKg0KPiAtICAgICAgICAgICAgICAg
ICogeDJBUElDIHJlZ2lzdGVycyB0aGF0IGFyZSB2aXJ0dWFsaXplZCBieSB0aGUgQ1BVIGNhbid0
IGJlDQo+IC0gICAgICAgICAgICAgICAgKiBlbXVsYXRlZCwgS1ZNIGRvZXNuJ3QgaGF2ZSBhY2Nl
c3MgdG8gdGhlIHZpcnR1YWwgQVBJQyBwYWdlLg0KPiAtICAgICAgICAgICAgICAgICovDQo+IC0g
ICAgICAgICAgICAgICBzd2l0Y2ggKGluZGV4KSB7DQo+IC0gICAgICAgICAgICAgICBjYXNlIFgy
QVBJQ19NU1IoQVBJQ19UQVNLUFJJKToNCj4gLSAgICAgICAgICAgICAgIGNhc2UgWDJBUElDX01T
UihBUElDX1BST0NQUkkpOg0KPiAtICAgICAgICAgICAgICAgY2FzZSBYMkFQSUNfTVNSKEFQSUNf
RU9JKToNCj4gLSAgICAgICAgICAgICAgIGNhc2UgWDJBUElDX01TUihBUElDX0lTUikgLi4uIFgy
QVBJQ19NU1IoQVBJQ19JU1IgKyBBUElDX0lTUl9OUik6DQo+IC0gICAgICAgICAgICAgICBjYXNl
IFgyQVBJQ19NU1IoQVBJQ19UTVIpIC4uLiBYMkFQSUNfTVNSKEFQSUNfVE1SICsgQVBJQ19JU1Jf
TlIpOg0KPiAtICAgICAgICAgICAgICAgY2FzZSBYMkFQSUNfTVNSKEFQSUNfSVJSKSAuLi4gWDJB
UElDX01TUihBUElDX0lSUiArIEFQSUNfSVNSX05SKToNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiAtICAgICAgICAgICAgICAgZGVmYXVsdDoNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+IC0gICAgICAgICAgICAgICB9DQo+ICAgICAg
ICAgZGVmYXVsdDoNCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICAgICB9
DQoNCg==
