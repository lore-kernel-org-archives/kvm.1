Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C57443E4A;
	Wed, 29 Jul 2026 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323265; cv=fail; b=oiYLvr0M2CzW0DUyM4g7uVl/tOqd5UacjIeptAle/kdaDMZWAtu6+frEqeZIPJS3r9QRt0InjB8mArnRPXFW5dQVNNaG7yJG1HSs2ZW5nfhBXcrMYwigREwjgv1vR/6ek3nJ88Hv7S/CypGVnBXAR1Tu97PBUxbd1LwKOSmyLq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323265; c=relaxed/simple;
	bh=KHFZEfv9R8B5QdmmvwiQZdnEudQ26CEl0loF49a7WOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TARRl+5kg7aOfD+AKO3E5v3DiGhC9dQSBzsFnuFOkvtWBBQwOKPdGGbMKUm+Ey980y72ArXJ/pfUwMNQW2cYBwybVCzZrlld0L+rnBYsWTMHv29IDzh322qT36nY63Ee+q9WA4fmg0DLpG4PESfhjDuLW3NSUlRxkvapfgmUez8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQpUE7KW; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQpUE7KW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785323265; x=1816859265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KHFZEfv9R8B5QdmmvwiQZdnEudQ26CEl0loF49a7WOA=;
  b=PQpUE7KWWS3Lv+aelfljj78wTdy1WQn5kyFzhOzC0v3SqmMsyIP5mHHU
   +ZQlm/Gys/0jrtN3bJ3GT0JJQWrDyWIZjkD2NBBt8O/sDqcvaveIsdcw6
   YX9ZUocpeQSYuJMyOOGHQBkZP5HvqAhsqmPV/BJypZokMj+toYScACYVD
   rkVh0lZCpDVs2YgpqOR0syrlYCai2JFX8RBOMccWkkQNhaB8b9b0qS28c
   camQJ1VB5652oC25wfcFNUZg3QOn4XGjmAwCk+SanPusN4aTHB76OewdN
   cMQKpYr50ddM+tHpow6pvVFVSXQeE0JJS0OhRQexLKT2728mQErGPPfeq
   Q==;
X-CSE-ConnectionGUID: hahRmzn+RMqAmShq3lIciw==
X-CSE-MsgGUID: jj33XlvPTICgubTmAtpJ7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96283781"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="96283781"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 04:07:45 -0700
X-CSE-ConnectionGUID: ZSL/li1CT4qfg3oHcE2d3Q==
X-CSE-MsgGUID: eHuBzcAvT2SUhAdOYxp9OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258741421"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 04:07:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 04:07:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 04:07:43 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.70)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 04:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD2IWySCfEknYUi+Zr0mk8lVEW5JKb9iaKOSzEbX6Dacja+qD/AfRtyoom+gv37oDz0tmBMTWjQMQjeorYj9G373WN5qLzcoFfEdAVFuOTtgR94FBxOFdQd8skcp81Q5KGlyxREe3i0rgrpSet+VpTUqsuTyDrKBz3oWGWeNjE7QG6DWOLirUCRI5usjaFVsfKV6c1Q4uPW346X8mAcgkn1SzDHXTuKR6l2le6tLoqkxImKC9AuEVe3QAS7ak29igsvlgsVpE853hBQiSsGhtyqGttsGPANOldIPGvpFk8TGCtk0wjJUaArnTUHCXxs+uKLWSTXJIJmQ35E0eQsgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHFZEfv9R8B5QdmmvwiQZdnEudQ26CEl0loF49a7WOA=;
 b=jmRTz2Wxiz0skmyxcVYwuUq0WiCGwemLF9zV6SXD/KsuQTuvHcYkJYB/CcrD7lIXjDO4S8rDCJQRI2p90cJRIKQIHZInFBo08vJbGpdP2ffBpLmnK0cKOzlo+cODfA2iGL5lpzvk5Yd7gPHwgSGaHSEj1n02/yy/JuapuQm265B2zhm7Z3BP+UUo7+Ks8cHkmCgpSE5eGAYx0lUBOUhNWqPwZoff7VJiKeXHGnBKbfypfk2qUz5wtKZs3z++dvqzzUvNd6ojnuwZNNoOIWBsWSxWyBhlugd69NJ5HyQ0+a1bWBfOPxbmOGpuHcYMJuqS6KBUroErV9HIP+v842jh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Wed, 29 Jul 2026 11:07:33 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 11:07:33 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jthoughton@google.com"
	<jthoughton@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit
 in TDP MMU
Thread-Topic: [PATCH 1/2] KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit
 in TDP MMU
Thread-Index: AQHdHieVDMPOlO/MoUOSfLGcIaeNDLaEWJUA
Date: Wed, 29 Jul 2026 11:07:33 +0000
Message-ID: <7722f65f2f60b411fbdafe53406461a1e6d8fc7d.camel@intel.com>
References: <20260728002236.869865-1-seanjc@google.com>
	 <20260728002236.869865-2-seanjc@google.com>
In-Reply-To: <20260728002236.869865-2-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|CH0PR11MB5219:EE_
x-ms-office365-filtering-correlation-id: 78608fcb-d620-4bbb-e2d6-08deed61970a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: i5d13vbJD25MVF747NBkJOQzFt+EanSCxwuhnNwnQWL00nomdm8rTnZNbuOPtpOIZufipFDVMxY21fv5AjYX1IXNKRz0yTaub+v2E05ANocSK8vFKTQCaer2A2+29YqgNOyf0q4GL74Y7hW4n97loIJQ4WIWdCAKDx12//RvL7hoRfBRSEvnOl0lupn53euf2wcV2Mlv+3WHsR5u1TwHGKl9qeNRJHrk99LB4C/7jmXBU2VcbqE7gSPIIho/c5B/Uj0LVKmFS4FyyoWVvWx9igOTxWyigwm7Rod+NV1sHq7kSxSQzhI8xxT6TRD/OHX1n9hs7IHmWkSNBGmjLD1UW+BFfTGScgwKpeGl0TVfLk0u5BwU1kVJjkE91IosZ5wqdCs01VKyt5ySQMGdRhY+9DQacTCjNGFW22ayhoz0GrK2VSlBAfG8MXAEOt9b8YWWURte6oCMJVleLyZgS5tBtpXsyEiKeNdL8C9g6SlrDeyAH+Rvf0fgCPmW7U8TVmFFwr6uiH7/bzS/bFGTb35cip06/dcmiQuXBiSK9ZRbuyBDBHKEWUghMBP60+JWblf48D0M7/8D2EU2fg52PBiHkTRBmh8GBCM3PFJ1ZoaMnTyIXOQgkcht4s9Pbtrghk+idz9ajqP85Comp1nzv9uBxPoDa+f28nI09j3rKuEa1rh488Dofm16fEekV1W9VBbSWn2P62q3S6/2T3aVR+eyntjDRw9uzJWmF99/MbrOSvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHJGUy9XTUdVTlUwdEJmM21adWIzRWNEWU9jZkM2eXBjTHBZYm9ibURrQlM3?=
 =?utf-8?B?RHVUUzl0VldFaGoyMEYxakFYN245TThjVi95RlBxdWNRaUpYY3gxakw0QXBy?=
 =?utf-8?B?MGxIOG03VS9aTDU3RThuRldvcXJ1M3dKUG8wdHovTWhQTXhRYVQwYjdVWFRG?=
 =?utf-8?B?UHRJLzhqaXVlSnVnRFdvYno1WlUvYmk3YUc5blU2VnlUK1htb0hiQU5nazNk?=
 =?utf-8?B?ZUROWjhoaGs1YkVuVjR4TEw3ZWxrWUhKSkE3V0dCeFU4S2ZQSG5mWUNIOFMz?=
 =?utf-8?B?b1hiRWZXdDMwSTB6K2d2NUpUR1BmSEU2TG9GalBtRnU5YjFyS1N3MVdSTnhY?=
 =?utf-8?B?Mk1xcTRPcTJRdWxXemZOb1ZYbk1wQnp5WUtWQmNhNUtVSDA1c3pPc0gzd2pV?=
 =?utf-8?B?ZGRHMzhEZHB0eDNlamhRVnd4Z1drSzVNYUE5dEtYcDk0OUN4ZzhocVZyYmpU?=
 =?utf-8?B?Tk8vbzIwd0hMbkN5dEY3a0tFSVMvbjk4bEJjMFg0Y3hteGYxNXkwSWFlQzNy?=
 =?utf-8?B?MGRzSStZZ1F5ZnFpQWp6K2VweFdRL0d3V0tBWnBwTGhTTkNRTWxvR1pUL1Vi?=
 =?utf-8?B?ODN0RW12SHZBMkI0ZStDYkU4SVcvRnZXd21PMkMzd0dSendWTkNLTGxMYkxH?=
 =?utf-8?B?cmZJeFcreThXUWtNS1ZHT1JYOUgvZHNaMXV2N3NidjJRenhIbUVvNWN2WkVl?=
 =?utf-8?B?Tk1ZaTFrZGFjeE9IYjVnQUE2UEs4SDFJd3Zwd0ZZRm9mTlV6MFJOcXltTzZB?=
 =?utf-8?B?eW00RDRaQXBUWEJoUWh0N2swQlZGWkdySVNaayt1WjhTbU1UVGJZSVVNYlVW?=
 =?utf-8?B?N05maHhOdGUvYisydUxUVXlNaDRIVSszNk1ZMTFjLzF5Z3gyZTZoWjVIT2hV?=
 =?utf-8?B?cmRTTFdLRW91aTk5bEc0TTRXM2xPeVh4aXJkcnJpc3l3V3pyTVh4SzBIZUJD?=
 =?utf-8?B?UFJvc2FjYTdsY0pCcmczcmsyd0dJUFlUMXVCQmlxeXBVdXhTbTRlaWRjSWs1?=
 =?utf-8?B?alNOWnJkMFFoSUlzemFWd1QxKzExUlR5bUl3THFoVXIrY2FscE8rdXd5bFNE?=
 =?utf-8?B?WXYwTlhocVZ3M3BaMDZWSE9kYWxMZ1cvZExwWWhmcCtESng3ZGpQcVhxSDRL?=
 =?utf-8?B?L2ozb1pmVDlnSThnd1RDVnJ5OFdlWFczalllOFNyaSs2bmZBUEw5cmcxcUdP?=
 =?utf-8?B?RFVabVEyTXRmRmUxT3FNdTcwaWZRZjk0b1JkaFpVKytxS29VUGI4UTIyTjc3?=
 =?utf-8?B?TXhqS1hCV1QyTklZQTlQOWNCQ3ltZkdWem1ndWFuS0pRUEIxaUEvNStNMHBj?=
 =?utf-8?B?Sk4wUzBKMmVlSFc1L3NGK0JjK2U0OCsxWG0yWW5xNkZJTUJDc2V5d0ZPM2Jp?=
 =?utf-8?B?M0VnbGNvbllreTZkcVZIRVBxaDlQaFA5V2tmUUs5S0dtcWRxdlBHckVsbGlp?=
 =?utf-8?B?cVJIVlpibVJQU2wvRXVESi94Tko4NmlZY3NuR282ZitEVkpBV0RBNEluY3Rn?=
 =?utf-8?B?d3dURnkrMFU3RjZEM05RdWtzbEhXbDNqa2N0ZG5TVTJLNzh6WXV1VnlVWEQ3?=
 =?utf-8?B?YWtIRVVXRTNRUmNQVmdOYjdUK2lUblpxUDduQ2xZY1gwQjl1c0JKVHF6WEla?=
 =?utf-8?B?dEMxV0ovNklSRGg3REs0dWxNQmNGSktjTXV4aWlpTUgvaCtlbzExVDllVkFD?=
 =?utf-8?B?cHUyazZieWRqVjVOaXg5ZG1qeHJKWFAwdnNZYXJ0OGpOcEhmTkp4ZGJDWE55?=
 =?utf-8?B?a0FOYUJTd0RXSU5HbmZETzRZVlJBUGlSZjA4Wlc2dEEyRGZabnhrNTlGZFZU?=
 =?utf-8?B?U1BXRE5pR0J3eVhkcEEyL2hkVE51ZExkOUFCMSt1TTQxMGxQaGZXcVhhSXIw?=
 =?utf-8?B?OGZuQUxWb1ZORWcxYzRYSVV5Yis3WE5YeERhcFByeVMzRVlYRThrTThEMGtz?=
 =?utf-8?B?LzlLeTREQWZpcmJ3ZjZmQkhHV3ZQY2FodVlzSHF1OXRxVTEzY2FIdSszZTBX?=
 =?utf-8?B?SXlmdTdaSUZFM0hsNDhEQ0RCVVhNd3lFRVIvekJaNFlTbktiV1l4M0d3aWRn?=
 =?utf-8?B?eW1YWDBsUDlqZmdMUktvbXZBVCsraHRzY2d2c1g1cFczdERES1lVb1QwdHhK?=
 =?utf-8?B?bytaVEFscnVNVkorYnVDSWU5YzRVSHBxMCtCT2luR25Kb0wvQVV4T2lteU5L?=
 =?utf-8?B?OCtMc0tCdDFWemdVZXpXNUpuWDZoZmdmcE9TNERDQU1VVExvMVNIc0pqdWt3?=
 =?utf-8?B?LzdDcTdMZ0pXUGNhbGN3SWRSNHI4MW9FS2dzMVhjZkwxOGVaenNJV2lWTDBx?=
 =?utf-8?B?cWVhNGdoSXlraGM0QUpiV2RQa3RmektNRStjckFLYTNwV3ZjWkN6QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3AE705D0E61C14AA42849C81B86013A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jw4C9RxLNvXCbymny55gtmQyzmU7we+REaDnqbA5n2nmxBFiveVwHL6MZ7WWXaM5gE2jov7zkT1zyjRHO5WMWqpV+8QIgUC0K/NXsvWmdvawba08Rj5H+yKYX8bKqH/nes5hggw2BxEptDwXnZCaZQfDYgCCIPeB0d4NwDOHjBLoptQDcQEqh2F6pisDLWK0tZ5XJ0U4rPS1ZHtgGNt6Q+KhyE2y8C7jP/RYYUORbzuHkw6TUuGiAsgGJDOa1Fnsz2Z3AX2LDxiC1ySlJj7VG86FFfOfblOKoL5p8AE8Cqyi+iJbeXduZTjBioyu0Ze5K6q/D68PkGHNXavbiXG6WQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78608fcb-d620-4bbb-e2d6-08deed61970a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 11:07:33.4839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sFDP8B7/Salk9iGhKWje68+OIELYPbaQrTmyh1UUU3jwYb8j5e4F8ZtSLPdxIO2x8p/ju2iTeBnBmxN+hV7OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTI3IGF0IDE3OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBVc2UgTE9DSyBDTVBYQ0hHIGluc3RlYWQgb2YgTE9DSyBBTkQgdG8gY2xlYXIgdGhl
IEFjY2Vzc2VkIGJpdCB3aGVuIGFnaW5nDQo+IFNQVEVzIGluIHRoZSBURFAgTU1VLCBhcyBkb2lu
ZyBhIExPQ0sgQU5EIGNhbiBjb3JydXB0IGEgRlJPWkVOIFNQVEUgYW5kDQo+IGFsbG93IGEgdGhp
cmQgQ1BVIHRvIGVmZmVjdGl2ZWx5IG92ZXJ3cml0ZSB0aGUgRlJPWkVOIFNQVEUuICBBcyBwb2lu
dGVkDQo+IG91dCBieSBBSSBvZiBzb21lIGtpbmQsIGJlY2F1c2UgdGhlIG1hZ2ljIEZST1pFTl9T
UFRFIHZhbHVlIGlzIGEgImZ1bGwiDQo+IFNQVEUsIG5vdCBhIHNpbmdsZSBiaXQsIGFuZCBpbmNs
dWRlcyB0aGUgQWNjZXNzZWQgYml0LCBjbGVhcmluZyB0aGUNCj4gQWNjZXNzZWQgYml0IGluIGEg
RlJPWkVOIFNQVEUgd2lsbCByZXN1bHQgaW4gaXNfZnJvemVuX3NwdGUoKSBnZXR0aW5nIGENCj4g
ZmFsc2UgbmVnYXRpdmUuDQo+IA0KPiBFLmcuIGlmIENQVTAgZnJlZXplcyBhbiBTUFRFLCBhbmQg
Q1BVMSBjbGVhcnMgdGhlIEFjY2Vzc2VkIGJpdGluIHRoZSBmcm96ZW4NCgkJCQkJCQkgICAgIF4N
CgkJCQkJCQkgICAgIGJpdCBpbg0KDQo+IFNQVEUsIHRoZW4gQ1BVMiBjb3VsZCBjb21lIGFsb25n
IGFuZCBvdmVyd3JpdGUgdGhlIGZyb3plbiBTUFRFIHdpdGggYQ0KPiBzaGFkb3ctcHJlc2VudCBT
UFRFLg0KPiANCj4gVGhhbmtmdWxseSwgdGhlIGZhbHNlIG5lZ2F0aXZlIGlzIGxhcmdlbHkgYmVu
aWduLCBiZWNhdXNlIG91dHNpZGUgb2YgVERYLA0KPiB3aGljaCBkb2Vzbid0IHN1cHBvcnQgYWdp
bmcsIEtWTSBvbmx5IGZyZWV6ZXMgbGVhZiBTUFRFcyB3aGVuIHJlbW92aW5nIGFuDQo+IHVwcGVy
IGxldmVsIHNoYWRvdyBwYWdlLiAgU28gd2hpbGUgS1ZNIGNvdWxkIGNsb2JiZXIgYSBmcm96ZW4g
U1BURSBiYWNrIHRvDQo+IGEgc2hhZG93LXByZXNlbnQgU1BURSwgYW5kIGNvdWxkIGV2ZW4gdXNl
IHRoZSBuZXcgU1BURSwgdGhlIHN1YnNlcXVlbnQgVExCDQo+IGZsdXNoIHdpbGwgbWFrZSB0aGUg
b3JwaGFuZWQsIHNoYWRvdy1wcmVzZW50IFNQVEUgdW5yZWFjaGFibGUuICBGYWlsdXJlIHRvDQo+
IGV2ZXIgemFwIHRoZSBvcnBoYW5lZCBsZWFmIFNQVEUgd291bGQgc2hvdyB1cCBpbiBLVk0ncyBz
dGF0cywgYnV0IG90aGVyd2lzZQ0KPiBpcyBiZW5pZ24gKGJlY2F1c2UgS1ZNIG5vIGxvbmdlciBr
ZWVwcyBhbiBlbGV2YXRlZCByZWZjb3VudCBmb3IgbGVhZiBTUFRFcykuDQo+IA0KPiBPcHBvcnR1
bmlzdGljYWxseSBhZGQgYSBjb21tZW50IHRvIHdhcm4gZnV0dXJlIGRldmVsb3BlcnMgYXdheSBm
cm9tIHVzaW5nDQo+IGt2bV90ZHBfbW11X3dyaXRlX3NwdGVfYXRvbWljKCkgYW5kIHRkcF9tbXVf
Y2xlYXJfc3B0ZV9iaXRzX2F0b21pYygpLCBhcw0KPiB0aGV5IGFyZSBnZW5lcmFsbHkgdW5zYWZl
LiAgS2VlcCB0aGUgaGVscGVycywgZS5nLiBpbnN0ZWFkIG9mIG9wZW4tY29kaW5nDQo+IHRoZSBh
dG9taWM2NF9mZXRjaF9hbmQoKSBpbiB0ZHBfbW11X2NsZWFyX3NwdGVfYml0cygpLCBhcyBzY2Fy
eSB3YXJuaW5ncw0KPiB1c3VhbGx5IGFyZSBtb3JlIGVmZmVjdGl2ZSBkZXRlcnJlbnQgYWdhaW5z
dCByZWNpZGl2aXNtIHRoYW4gcmVtb3ZhbCBvZiB0aGUNCj4gZGFuZ2Vyb3VzIGNvZGUuDQo+IA0K
PiBBbHRlcm5hdGl2ZWx5LCBLVk0gY291bGQgdXNlIGRpZmZlcmVudCBiaXRzIGZvciB0aGUgbWFn
aWMgRlJPWkVOX1NQVEUgdmFsdWUsDQo+IGUuZy4gc2V0dGluZyB0aGUgRGlydHkgYml0cyAod2l0
aCBlZmZlY3RpdmUgSVBBVCBhbmQgR2xvYmFsIGFsaWFzZXMpIHdvdWxkDQo+IGxpa2VseSBiZSAi
b2siLCBhcyBJUEFUL0dsb2JhbCBhcmUgZXh0cmVtZWx5IHVubGlrZWx5IHRvIGJlIGNsZWFyZWQg
d2l0aG91dA0KPiBkb2luZyBhIGZ1bGwgU1BURSB3cml0ZSwgYW5kIEtWTSdzIGNsZWFyaW5nIG9m
IERpcnR5IGJpdHMgc2hhcmVzIGxvZ2ljIHdpdGgNCj4gV3JpdGUtUHJvdGVjdGlvbiwgd2hpY2gg
bXVzdCBkbyBhIGZ1bGwgU1BURSB3cml0ZSAodmlhIGNtcHhjaGc2NCgpIGluIHRoZQ0KPiBURFAg
TU1VKSB0byBlbnN1cmUgS1ZNIGlzbid0IGNsb2JiZXJpbmcgc3RhdGUuICBCdXQgdGhlcmUgaXMg
emVybyByZWFzb24gdG8NCj4gY2FycnkgdGhhdCByaXNrIChiZXlvbmQgc3R1YmJvcm5uZXNzIGlu
IHdhbnRpbmcgdG8gcHJlc2VydmUgYSAiY3V0ZSIgaWRlYSksDQo+IGFzIHRoZSBjb3N0IG9mIExP
Q0sgQ01QWENIRyBhbmQgTE9DSyBBTkQgYXJlIHdpdGhpbiAxLTIgdW9wcyBvZiBlYWNoIG90aGVy
DQo+IG9uIG1vZGVybiBoYXJkd2FyZS4NCj4gDQo+IEZpeGVzOiBiMTQ2YTliMzRhZWQgKCJLVk06
IHg4Ni9tbXU6IEFnZSBURFAgTU1VIFNQVEVzIHdpdGhvdXQgaG9sZGluZyBtbXVfbG9jayIpDQo+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0
b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFu
ZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
