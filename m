Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1A40DFA7;
	Thu,  2 Apr 2026 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089044; cv=fail; b=lJA2tGDJPpYO7w0oD2PMm2dLG5sLZAXQ9JWk+SB2e4O2FBJZ3epLIRjEALyZ+ERtV3hXE071TgP2SJ1bS+SOlL4PWnubuXSMHuOwSfnKRwhZJcoyxtEe9M1KKKcvz4ulYSrawB291AQtLLfGERM2uof8TZUliicGY7wPKDi6deI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089044; c=relaxed/simple;
	bh=3VrWYNy1K0utHUBl+7PWGAsgJkYpCDNok1NR3WxgZrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MmtWJnbSBnBg4q6FIs+wO4FMDM1iUF9hjttYv3ad0WwPxEKzAmxOoaH+FQuyLjeZeCv/mX8icL83y6whDkvXxupQejUgUASOUzsjnaIoMFA1ZYLnuTOXI024U9YkyzLPjB6vJvXdKdQLoaY1DqdRh0QqNa7pqiVt9zjIAKAtHl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjmGayXu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjmGayXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775089043; x=1806625043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3VrWYNy1K0utHUBl+7PWGAsgJkYpCDNok1NR3WxgZrs=;
  b=RjmGayXupX8rqLNqayzPd6TeXyIlahF2eXrjYe7lfO95fBTmt5hPcSxW
   Ak3ImuMFdsUn7P4ZoUZWpxxvqHzkL7jyNaoUkbaIYFdiUNjNc0N97PwuU
   /3gCCtAH0yYGelBwYLaFoSy3t6jdlYAjPxe5ILzBQ2EMw2KCXbtXwFMqB
   JnG92nrT6qGX26k/NEcM1GJY1JPhIju2q0/OSfYD5bz6bb5h17Dio9iBf
   CE5jYFsJPNbHfZ/ny4EY70d8RaCcKXq6+pEBJY6ssw/wXuj6BAohzjZzp
   vFw91SKKmWvu/c9ftsgrZ80LxOVW0xxtPmIoBat2y8TXDYB17+Frlcy4m
   g==;
X-CSE-ConnectionGUID: EVeTG+TSRq2FzUWfE2AuTw==
X-CSE-MsgGUID: +y/cbcNFTHWbJQ5plFsSOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="78736965"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="78736965"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:17:23 -0700
X-CSE-ConnectionGUID: x12+vN/fSZaEbC7dx2UdNQ==
X-CSE-MsgGUID: BgODYzV1RWSoLJTnWKP6Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="249876602"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:17:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:17:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 17:17:22 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:17:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxxjkC1fnzJjE/mNya+ZUU7KGhedTtG6CyZFpWDd2ZJE74HcwcRzBfvkP3PBkvZ2GUAMZQrMcAvs2txF991cSiiHpncmMrZQNjzELZrlaWSHpkPio7ljUWSGiqy4bfy7cAWzjmaje9qocVSCrWIXgpv6yJDL14xX0zfnD+GP9XN9zKuTW8xWqdjMncNlyHp9xjy9xemyuCPaPRX2pRWGCJckQsLVZDrfqO6ARtLd3xdlDbAyi/Z7aLG9U2E95LQtpSdZvaZiTcWi6qHStkyTFA4wzdZJmZIAUpnWWEvDCIPQDwQFymdZyolehEoO8CWia+XoTJtMojVnM7qlQj2ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VrWYNy1K0utHUBl+7PWGAsgJkYpCDNok1NR3WxgZrs=;
 b=hqe1mQ2TmtlR5LCPlgXSjuK+PSGON7c/qcoqlqOAjPl5eQecg5c3USjVb9hmwR0ODEsvDncURH9DXGN1jys9R2CYWUIrgxt/vHsDOtSAMghvEZXIuxiI5tm7+85X0Ff4xcxvlPvkPQH8V0wcLAc8yKQolu/xsmbu8NMfcbrauPDJF0tujdEY+2ObhUDBLhUWseW+HijrVs/mDBXNuFoiJvawPycu5eL6iVEF3295u2X3eCp/SYGRumCTsh0zTvi73kruz1ORNHZZgtLlxKaNf6aTMgxDr5uYCSckqUP4BlYQKWGUuNk7nEGXIxbq/7QlLDRLVgyrTuP3jJWyzNnWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ5PPF0F15BC42D.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 00:17:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 00:17:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 17/17] KVM: TDX: Move external page table freeing to TDX
 code
Thread-Topic: [PATCH 17/17] KVM: TDX: Move external page table freeing to TDX
 code
Thread-Index: AQHcviZZXWFR9sU/5Ue1i8pdLHNvEbXGtxeAgAQ4vQA=
Date: Thu, 2 Apr 2026 00:17:19 +0000
Message-ID: <1e4e63094021e0fc8419bbbe5450abed7f88f06f.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-18-rick.p.edgecombe@intel.com>
	 <acoq94R7F7k/9AV/@yzhao56-desk.sh.intel.com>
In-Reply-To: <acoq94R7F7k/9AV/@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ5PPF0F15BC42D:EE_
x-ms-office365-filtering-correlation-id: 41a3b560-447e-4e1d-51e9-08de904d3432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: cDME+Zl1FImdImOStNKKu+XVzgTUHfW/0ekiSRFhcAz9iGrQlHY4DPji9+/83gw8sThreiVK/z21alyqqh6vgmysL9MwiOXNIoDOfY5yU3v1B6zmGB8ZUjQ3bOxFQLOgtu7a+VvpSfauQZFgR8iejn3OwVdAIhAj8hhXJlEZIpE+zDpk5ZfbMndUdfSQtN0+hGzoYEiVkb7xOJ6AGcpyDvdt21k/myYRdHs1ORs/teuSNk/YsjvCIm0oqnQlGoobssAPkb4J+aW1zZQWK4NQoM7ReLxUXZbflPK6r2feyYK+B8hCgogZvksYNbkoGSkBYJ7a/6eGNRSrah0e4yTx50Enlbdv+e/m0V+zjHLXD4uQxjKMQFeTp7B9iyX1aFQtykGKMFLTUZI3Jg0URpOSV8dWvmf4LF0Gkee2maq7eQsqdh0QPIeHgUqsqKvddWAkTw5Klvo7SOOpoDv/2bY63PM/Cww1AZMd5SJSK6aSx6/cu7KVbstbTj18t3sUcopbYLjO5YmsQXxQEdvLovGP96J0yIMQOVXQIfN+BVhNEvt1aByM77XelrZtkinNGbZxn0+mpQ2kleQlMhgehqnj4IziMtzAtlLVBmY+Km4Z9qmtIYMwi8Lqzxaz87ilTd1kCd104w/IgEPN5O9zz1Gzw4gK4KLcURkXq0axSpcDoXTdZud9fPjTWOCNX8RTxfUETCRKBvIJHuHX+rzB0JdLHEX6xxA0kfnDrW/ME2P0x7mFiXst2G8/PsOqVHg3PwaDpwtGdnfzo2yjuZmMRjB9pJLhWvGVLa2Rx1HQXrfL4Vs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXFIZUxQbEh5Rkpkd1VPVjFsYml1bGRQdTA5a2JLVE9oMWFkN1A5d1NBSWEx?=
 =?utf-8?B?eEp2Z3VvK284VUJoT2Z1OUE0b0p2Rjl3VTN0T1hWTFZma3FtNWd5U0M0d2Y5?=
 =?utf-8?B?dlNYeFEyeVBNVkQ3K3JHVHVyNHBVNUxJOWhaVGJyMEFBQWhCSUVOU2VjV0t2?=
 =?utf-8?B?NExKNXNaZS9PVjVsdXpaanZLZWZJR0VnUWM1TFMzcmZXelE4N3QxRVZrSWdW?=
 =?utf-8?B?dlQ1cWIzL3hKZ0JZRktKWmFzeUhSc25FV1FUVkRkRXlwRGM2YmJOWS9UanpD?=
 =?utf-8?B?RmtDTnFJYkhPWU8vallIQ3duYkMyUGlXeTU4Q1pXY25DZ25QaFhUZGF4Q2pS?=
 =?utf-8?B?RENxNTQ1Vmg0N3hJSmEzQkk5MmhCOTZpb2h2WDFUcVFod2VJTXUrWitxTVVG?=
 =?utf-8?B?MWRmRS80cFpZMkl4SFM4TDlUYU52ZkNaN1BQbFBXZS9Mb3NraHNLazFNUHZE?=
 =?utf-8?B?Z0s1MEVTYXdHTmk1RjZYYkU2NTFkeUJsRGRCS0Q1bUFHTUpidUpVYkYxVDE3?=
 =?utf-8?B?aHNpU2QyVTNQVFgxekduTlZKaG41d1JsajBYLzFVeEtUUUttWTBBbkNYMGFF?=
 =?utf-8?B?V2F1ZE9tWVpXb203NFd1ZUZmdFE4M21KckRpL3UvZzBaMElaNncvRkJuS3BM?=
 =?utf-8?B?UUVrM2ZTT3NLVkJsd25pM2taTHB4eW1ZUmhlRXRTNFhueXdhZHN4c0NzYUhm?=
 =?utf-8?B?NC9GS3dwZCszK0hKbXM1a0JzNlRPOWpidXI2Y0pKckZnSEV4aExidEwzWjZ4?=
 =?utf-8?B?TnBpOFd1NzNteVVvTUtoYUVFejJZVUFhWEs3emFENmx4VmxYYjB0UWVvRGVD?=
 =?utf-8?B?VDdvQmdoRGsrOUpuaGVWSEVwM3NyUWIwcU15amhWQXNmc3BRbWREWFpKeFYx?=
 =?utf-8?B?cDhLeTdnTEN3U2RDd0pXcU94YVhwdzVxNm1MU1NWdVlRVUhmYWVkVDNROUk5?=
 =?utf-8?B?cW9NdGFBTnRXd0R0dkFscWJwSkE4OHpvOHI1RUNWRTJBODUyR2VQMmFKOVM0?=
 =?utf-8?B?ZW9pYTc4Q1BzZkpYSStFTDIvQUdWSkI4TlR1dWdkbW42UXNydjNXTXo3M1ZU?=
 =?utf-8?B?U0djOGpFYWZxM2ZsVWxBS1B5SVMvR3EzaGJkdXRaelFXNktzVTBzYVJTbTVx?=
 =?utf-8?B?M2UwZmlRYmVaR2VsL1d3RXRSVUtQbHJSUkhqN1dBcFdvNGJidElKemRuT0xa?=
 =?utf-8?B?eXlmK1RHNVJ4cGVsTjYvczZGWHB5WkNvbysycHI0RUdMUEJnaU9DSzZsTHg4?=
 =?utf-8?B?c3JBR1FIV0x6QldpZDh2WDQ5dExxbHFER1BaR012dGg4ZFNkYmFVTEczL2ps?=
 =?utf-8?B?SmlvOTlCZmxzeG5OaC8rU05nUU9kOWRiK0h1QXBHWEFOOUhpWkNZOU9CWkRP?=
 =?utf-8?B?cFJnaWp6dDhxNlUwNDRteVMvVFl0UDBzTkZaQTFtYVZpU1AwOXROZng4Tmd3?=
 =?utf-8?B?QStjTXlVNEJ5S1FGYnBTeVFLS0FRU2RMSVFtLy83K3FZR2JuK3JVamtsdzMz?=
 =?utf-8?B?OWpjTFNtQXo1RlZZM1lObmJtdFZSaHJkTHBwV0lGeTZjSWZsT2pkcDlnWG9X?=
 =?utf-8?B?bUlGNEFkRElYajQyaEV4T2JSYjJlMlhPRjI3aEVXZ0djTTZmOWU2M00vN0wx?=
 =?utf-8?B?MnNpbEM4bUZqZnhIeURDQkkyZGxwRnlNWVR5Ym9ML0lYOXRSQVBNU2JqblZO?=
 =?utf-8?B?RS9TRFo2anExL1N3NHgwUEYwd3lDaXdZQXd1d0FZY0F5SlZINlZIWlY3SGFu?=
 =?utf-8?B?L1VHT3JPSjRNa09DclpDZzNhUTE1R0hCZEdjVTYxeGZQcThHbVM4NFI2VUpY?=
 =?utf-8?B?clB3WkJYNHJtM3ZQdUwrVXIyNTA1QmdCZ3o3bzVtcVN3U0FNOXZSc0RKdGhR?=
 =?utf-8?B?TDdibVdiOGloV3BhQWppanRydVplalBaQktMM0FubEd4YjVyc2V5bm1xL0ZM?=
 =?utf-8?B?S1pSTUhrckVRZUVmV1RhNnI4L0VEOXBWMjVhK1p4d1djMmFlRkpnR250cFFF?=
 =?utf-8?B?Ty90NUliWGtMNFNieGtnN1pBQk41MG9PaTh6WTB1a0VTK0VMbUpKMWNPazVx?=
 =?utf-8?B?SmVPU2lycGFZZVI0bjEvZ1VpYytMNVN2WUpieTgrRCt2bGRFVmhSdUlRQzda?=
 =?utf-8?B?OGZ4Y1pHU05aWDlkdU9ZOE9IVXZyY2tRZnB6TXFzMGNYM0ovc2IybEVrOTZO?=
 =?utf-8?B?MGoybmpzTno1M3l5eUp3eFFFT2JxRnJUbFluWmp6QTgrN2lXa3Ewb3RFZ0cv?=
 =?utf-8?B?Z01UbzhBQ2NWL1krc05EZFJaQW1rTG5FeFl1SnNBb3p1ZDZzYTNsZlBNN1R1?=
 =?utf-8?B?Vi93SGVlWlFWTG9OVFFFaTBhZi9OTjkrRFBFdkExUXVkYWFoSjN4cDhwOGxY?=
 =?utf-8?Q?MWdUzNKLObvvjkTc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11B68D0ECA6BF542A0FD804CAEE5706C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nnahsZmoOEhwAJu8yIUgsORbW3jq32b/I6nWZm1UK3Evpkd2TS1/yVltrTKnH+mnDANeUnKSMJ6C9bAaJ3qnsW7pPDLd0p8bM8QrZGCaGg67fN0zlSV92b/L9JnYtNGm1O+Q1w7Lh61IVyAqlcFmXFQjEEOb9ntr3FSfqc9hP56jhhNfOEhIpi5qZwLWV3MU364Q7b5XEWkBhUC/cKF8MMeU+19p2yaFgDSHXH38TxKrhU+uOcnguYP76ttTExg4ZrA+226iAhnEAluec2LyG+FcjQ5Yhsgl5A0IiwyNcahfbpa0XYtXuLLW2i+UcpM7Se0DVanJJNzus06HgaZDUA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a3b560-447e-4e1d-51e9-08de904d3432
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 00:17:19.5333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUGAKklLSB/5zh2x0TOK5qIqhr2ZZqhRPlR36R+MQayEfweiKBDmRddmkBt/h9OjohFxuOE3uZIebLSnwqYqM+Fn7XK7jth/Z1a46jiPmB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0F15BC42D
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE1OjQ5ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC90ZHguYyBiL2FyY2gveDg2L2t2bS92bXgvdGR4
LmMNCj4gPiBpbmRleCBkMDY0YjQwYTZiMzEuLjEzNDZlODkxY2E5NCAxMDA2NDQNCj4gPiAtLS0g
YS9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jDQo+ID4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC90ZHgu
Yw0KPiA+IEBAIC0xNzgyLDcgKzE3ODIsMTYgQEAgc3RhdGljIHZvaWQgdGR4X3NlcHRfZnJlZV9w
cml2YXRlX3NwdChzdHJ1Y3Qga3ZtDQo+ID4gKmt2bSwgZ2ZuX3QgZ2ZuLA0KPiA+IMKgwqAJICov
DQo+ID4gwqDCoAlpZiAoS1ZNX0JVR19PTihpc19oa2lkX2Fzc2lnbmVkKHRvX2t2bV90ZHgoa3Zt
KSksIGt2bSkgfHwNCj4gPiDCoMKgCcKgwqDCoCB0ZHhfcmVjbGFpbV9wYWdlKHZpcnRfdG9fcGFn
ZShzcC0+ZXh0ZXJuYWxfc3B0KSkpDQo+ID4gLQkJc3AtPmV4dGVybmFsX3NwdCA9IE5VTEw7DQo+
ID4gKwkJZ290byBvdXQ7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIEltbWVkaWF0ZWx5IGZy
ZWUgdGhlIFMtRVBUIHBhZ2UgYXMgdGhlIFREWCBzdWJzeXN0ZW0gZG9lc24ndA0KPiA+IHN1cHBv
cnQNCj4gPiArCSAqIGZyZWVpbmcgcGFnZXMgZnJvbSBSQ1UgY2FsbGJhY2tzLCBhbmQgbW9yZSBp
bXBvcnRhbnRseSBiZWNhdXNlDQo+ID4gKwkgKiBUREguUEhZTUVNLlBBR0UuUkVDTEFJTSBlbnN1
cmVzIHRoZXJlIGFyZSBubyBvdXRzdGFuZGluZw0KPiA+IHJlYWRlcnMuDQo+ID4gKwkgKi8NCj4g
PiArCWZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylzcC0+ZXh0ZXJuYWxfc3B0KTsNCj4gU2luY2Ug
c3AtPmV4dGVybmFsX3NwdCBpcyBhbGxvY2F0ZWQgaW4ga3ZtX21tdV9hbGxvY19leHRlcm5hbF9z
cHQoKSBpbiBhDQo+IHNpbWlsYXINCj4gd2F5IGFzIHNwLT5zcHQgaW4gdGRwX21tdV9hbGxvY19z
cCgpLCB3aHkgYm90aGVyIG1ha2luZyBmcmVlaW5nIG9mDQo+IHNwLT5leHRlcm5hbF9zcHQgc3Bl
Y2lhbD8gaS5lLiwgd2hhdCdzIHRoZSBkb3duc2lkZSBvZiBmcmVlaW5nIGl0IHRvZ2V0aGVyDQo+
IHdpdGgNCj4gc3AtPnNwdCBpbiB0ZHBfbW11X2ZyZWVfc3AoKSA/DQoNCkkgYWdyZWUgaXQncyBx
dWVzdGlvbmFibGUgYXMgYSBjbGVhbnVwLiBUaGUgY2hhbmdlIG9yaWdpbmFsbHkgY2FtZSBmcm9t
IHlvdXINCmNvbW1lbnQgaGVyZSBhY3R1YWxseToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2
bS9hWVc1Q2JVdlpyTG9nc1dGQHl6aGFvNTYtZGVzay5zaC5pbnRlbC5jb20vDQoNClNvIGZvciBh
IG1vcmUgY29uY3JldGUgRFBBTVQgcmVhc29uLiBUaGF0IHNhaWQgSSBhZ3JlZSB0aGUgcmVhc29u
aW5nIGFzIGEgc3RhbmQNCmFsb25lIGNsZWFudXAgaXMgcHJldHR5IHdlYWsuIEkgdHJpZWQgdG8g
cHV0IGEgYnJhdmUgZmFjZSBvbiBpdC4NCg0KV2UgaGF2ZSB0byB0aGluayBpZiB3ZSBzaG91bGQg
dHJ5IHRvIGluY2x1ZGUgaXQgaW4gdGhlIGluaXRpYWwgc2V0IG9yIGluY2x1ZGUgaXQNCndpdGgg
dGhlIGxhdGVyIERQQU1UIHBhcnRzLiBJIHRob3VnaHQgdG8gdHJ5IGF0IGxlYXN0IHRvIGRvIGl0
IGVhcmxpZXIgYW5kIGxlYXZlDQppdCBhdCB0aGUgZW5kLiBJdCBhbHNvIGtpbmQgb2YgaGVscHMg
dG8gc2VlIG1vcmUgb2YgdGhlIG92ZXJoYXVsIHRvZ2V0aGVyLg0KVGhvdWdodHM/DQo=
