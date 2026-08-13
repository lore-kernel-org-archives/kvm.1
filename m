Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AA3B4EB5
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615835; cv=fail; b=F52ldRRGoMIKg71C9L0JgGY5SkAkc0umg0ZZwh1x2RljbQtzM41hhVvvIBHbgTDuiMZOG4AjVmAhXQnogie887Socqoo5uHMj0Rx7NBYgGeUyWQkgE8p60pE9Vsi0KB/HOK+R/KoDSNwAU/SngLvtcKfNZpjceSO2B87mcb4dQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615835; c=relaxed/simple;
	bh=a4OO/XKmb468k7nbDRPM0M3laoVHwhe+PXuex3AZxQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M15lKp4kxyu+dDfDjhP0LupOG6Fy1QS14M4U4MNuM71FjStAdtObGmhzKVgJuMjQcws6/sbyaO8Hc2asVGOCtolms7teiZdH6HQ65+KmXfwZGku+ZuWeRtEhIDHpGx3wMIKQVzIZVu4UxAycujgfi2pfijUn8f9edRR7kkFNnbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0vUVrAa; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0vUVrAa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786615831; x=1818151831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a4OO/XKmb468k7nbDRPM0M3laoVHwhe+PXuex3AZxQU=;
  b=V0vUVrAaPU85iUg72HRpu23+4tEJgSNNVq8OrjUfMnHcVcl35nXFugK4
   9uPCVXj9vh+LeEsN/PHGSuZrozBWnW86wO4cOr1qrR+yQ2DuS0Z8LLfyV
   9eqFdtNhOVf/nwJOXK9PIShDf0IdkPR/KVAJko1D+SmK48yeqK/UCKKsY
   VP7G6zeORlt1LIo6n8ihSwam3Um7SctEjWiAXMmsj1UhfgkfZJs8zvQLj
   OSsX7EEmrBUzcH9/E0dtyrJhDdjR4XZNbPDKj4NrEQWnmB7tRChPxIJNF
   GIj029lddsChbMQ4o3syOXkqDdKo2fKqNgtnsaYAV5HGn9B9epVuceUIe
   A==;
X-CSE-ConnectionGUID: KI99FcHyTTuT/PK7tgd3NQ==
X-CSE-MsgGUID: 3nK8lQjuSw2KIO+sXbumkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97849824"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="97849824"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 03:10:30 -0700
X-CSE-ConnectionGUID: WcHIeuQJRN2yz0aC5f6cNQ==
X-CSE-MsgGUID: cSeO4s89TSecBMzGPW4uiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="263926654"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 03:10:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 03:10:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 03:10:31 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 03:10:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjklOoFdaDJ2RDWFHzO8cJsctqcP3gsP2YzHn+QyJU2b8C5CbDQKY/GuvGXQmEWez82/PY9UHzFmMCGZ9C/N2206RMKr4bS6HO614LgKl05nAB3YGI2Th3bL9VM4g02kFaXZAOgoCGyTU/O1rNlZF3JuIRzz/x4Dgcdngfe6D0OVnlFd5PYdzcH07UnkqnyEaY68z/IOXJIKKOKRVQqNx8VlVLTsBX025+qTW8GOt1Axa9GBWa0z6jHcioRqnDkj+qwGystPi1Bivv6H9RSEHi9PD01xtNam8arOVJtxkJ9WWBFE46WfvKugR2l8qxyYA+hv5u03+0BW6uZI1BQ0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4OO/XKmb468k7nbDRPM0M3laoVHwhe+PXuex3AZxQU=;
 b=uxkQCAOA4yxlvR4pT6BPVk278atV+c9lzboMueRxGLaU6X2tEovQUEFI9mBeW9i2ygL2Z9KCDdmxZqzReMj3Kv6iKkdnoXW4CfC48+A5O+yY+Hg0X6ZE9QzczGd5g0Iko0B2X1uUjdrf1J6IyrWqptzTSN2ttJvhTh4QVMEyoZ4wUBMdR62nGKObES+kXi/AJYfCDtV4p346VXjykyEWhMzHk2JYxlNzw+r+p2lPvwMU00ITDgZzykH0LBqWlACiStUv1Fs+w/4EnaJHFyG0v7nob3DJ8BbBmF24q1HX+VF9/AG1L6bTwAf7o0JmlTjld/9ZbMq7OjJiNiWtVuwmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by MW6PR11MB8339.namprd11.prod.outlook.com (2603:10b6:303:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:10:28 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:10:28 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"hao_zhang_kdev@163.com" <hao_zhang_kdev@163.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v5 3/6] KVM: x86: ioapic: Preserve irr_delivered for
 duplicate edge interrupts
Thread-Topic: [PATCH v5 3/6] KVM: x86: ioapic: Preserve irr_delivered for
 duplicate edge interrupts
Thread-Index: AQHdKjWZb71funw6X0OwTIiULWDJv7aaG2MAgAGBhICAACaYgA==
Date: Thu, 13 Aug 2026 10:10:28 +0000
Message-ID: <77bb6e42bdbae0bb1ca6584ec87e688db8b7ef9c.camel@intel.com>
References: <anwwV80QWHxemrWS@192.168.1.215>
	 <20260812085229.4EA541F000E9@smtp.kernel.org>
	 <an13sYh4gCyGbMZc@192.168.1.215>
In-Reply-To: <an13sYh4gCyGbMZc@192.168.1.215>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|MW6PR11MB8339:EE_
x-ms-office365-filtering-correlation-id: 2b193e7d-77f8-4682-9457-08def92319b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|18002099003|22082099003|38070700021|10067099003|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info: UZlQP5SKfqq+ac/TGUfJGRHNzDclrwA/tsmZ7/8Ix1ZaIJqfW3Jm2Tzqvg3q6OJ7h153mebumpajvUyjX59L76k4BcRqv5EuWBssXYXhnGcuZaK0R38fsmi/h00DD+6jlKhYvqTUWCLdgdBLEAlEPKFxefN1SN9HUzLBCvRn9GfjEkl2H4xabH0Vx18C9keESHUB6fbvec8dsi/54B/H6Z3O+07wydjTSniyy/WR9NAjcWLMssRNineFCFa42gjyz0x1Ujyq6ME9Mb8xgkaIx0csh9QAI/zPjfjjiFO0ldd/oknEqJ6INWULPEm9Rr+Jf4025pryWvL0B2A4L3CXMjwconsJZpa03sMV8xUDjhygjP3s0vg/R2ZC76OExW9U5oxrIxCWMtfVfJCMTzlBcA6w43bWgmj4YPbnXClt5zCsLovTB5lhUSo0cQ9537kAko2Rcb6yDVe2FghToOYA4Ddgp2UqetsydGlLd93yNipjoDNVF1FkebWo0EgEOJtdvNOgDyz0anJ7CYFWEPjP0VJdZrgq/xRP1m2oLI561WG2JZ3oNNkLAHrlHEt4c/Sp5xuycmwt9+UJFGID68eToLGNvd4Wy7M+WhxcdTTZ+0Z2Gdc0uKNwUzL7Qg7DJ2fcpxHm5Lp2fJiqLduMydSDNYNAvZPQJMo9K69DB9/LXCw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(18002099003)(22082099003)(38070700021)(10067099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uzd5cGxhU1JjSHZBWkxIWDRoYnRMZXM5Z2g4b0syTUVVeTFEM0ptcHR6enRv?=
 =?utf-8?B?dVppZC9yWUQ2S2cvZDFaOVplVUphSHZaN0pwck9MNjJmcDl1YlZkaDFtSGtY?=
 =?utf-8?B?djhwbktNS1ZpNXJvdXplSGpWQmZ2cjlYSjF0WEFHMnBWcXY0akhVOGFscGY0?=
 =?utf-8?B?UE9UaXdlZ2E0UFVOVGIvWTdPSUdTcldiQzBmK1FLdlg2Y3p1S3ZNV25XN2Z4?=
 =?utf-8?B?NU96T1gzMEZPTDZpbTVDYkxjTnJQaTIzY1lwMlVsM3VjRTZyeFNvTk82K2hM?=
 =?utf-8?B?TWFqZGRGTnk2OVZIR2RMM3Yzb0pzRXo3eVJveU1EOHFYdUMvR2NQS3A0NzFq?=
 =?utf-8?B?UUdjS2JVcFdYM0lDSVNpdHM1MDZ0UFpwYkZOOWdZRjB6NlBTazVNZ0VvdUZt?=
 =?utf-8?B?dkticnRzMVBKSE1BckNZQkdmNU8zR3dtR2tlYnl5cFExbUgxUmVEK2Q1Zmwz?=
 =?utf-8?B?L2kzYnp2VzJSNE0zSk53N3ZJYkxqQVg1YkxaelRiNy9EdGp0czhhVU9kWEsv?=
 =?utf-8?B?Mmg3WHdEaE5vWVlYbTJ2d1JIV3NZaUVCZHh1SlFmbE5HRjRMRGg5RUl0QUNN?=
 =?utf-8?B?b3JCS3hXKy9hQWkwNE5VYW1zcXRDanRTUU1wR1NwZEFkWUM5NFcwcFNDM0tF?=
 =?utf-8?B?cUphMWxiRm9ET01hWXRWalhpdHMrOUdBNy9OcjFMUFlJdVZ6WmZUekRnQjMr?=
 =?utf-8?B?SVBhdmhPSUdhcUtwUEdsMTEweVZSM0pDcFQ0RHVNZ01wc3VWK1I1elJjVUdq?=
 =?utf-8?B?a0N3SndkZWltT1BZeGlqKzhVbzkvaFdUQnRxTHN6cnkyeTY0dnEyRGxPNHB1?=
 =?utf-8?B?eFhtYk5XVFlhVXduVVQweUxmT0ZKbVFOa2hNUU9KT1BjVStuT3FBRVBheEVm?=
 =?utf-8?B?MTJuWFVYRE5uZkZIMGI4NnNFYWhLdzlxV3BYbHN5eWhCc2F6U2MvRVZKZFdj?=
 =?utf-8?B?T0prb01QSEIxNXVadm5nTkZxWUE3UEk5b1JSUlMzTDB0VnhaWlI0bmJRWmNO?=
 =?utf-8?B?NE1KYnNkNUZoanRrK2U1SENlbHhmY1FNNkRFNFpoK2JFbDVyaE5NdDRVdkgv?=
 =?utf-8?B?V0dHMDBFNGx0eEZXWGQ3RUhrV2VpaEtaQmpvbzk4MkdySVQ4NENaVWhwZGd5?=
 =?utf-8?B?TW4zYzRXN2Iyc2tyMW9rdHRnOFVBd1lBMDBMWFRSMnFGem9WUlRFY1diN2ZX?=
 =?utf-8?B?QXlJQ0dRenZYUmNnbS9LYmdJTXpVemJBMjZQS1hibmJFdFYzcTl1RUg4eVYy?=
 =?utf-8?B?ZXZqbkhwQVlJL1ROdzRxS2RJUHNWS2dURW9sMjd5L1pIRmkxY1RxdGlOUjNG?=
 =?utf-8?B?MVlLRFB6cVh1YUJPb3lQS05YcytONWtaRkY1M2Y2NzNybjNTSCtGTitoMk53?=
 =?utf-8?B?TXAreGJJRmlJUmpoN0lQcVBEZ2M2U1lhYUxqTTJxcVNZeHk5VWowcXZFTXEx?=
 =?utf-8?B?K29qQUdvNEZRaVBlNkxlN3ZRWldQbTN4blJpaDVQa1g4dEcvakdKa0tBMENm?=
 =?utf-8?B?WHkzWm84R2pVSzl3d2FOZTVHK3B5ZC9SdWFVd2dlU3dkV0Q1TDQrNWw5OVQ1?=
 =?utf-8?B?WGhrZlp4MkNwQmFoQ2tYT2libjFEL2wzOFF3WUFPVG91WEpoYTh5V0c1Ykh2?=
 =?utf-8?B?R1Rmb2lPY1FmVXpaWUhmbTloWVJkQUdDcWlCaHJ5a3VQQVJmZnI1MzgwNGJH?=
 =?utf-8?B?TDVlOVdFUnJDcDRYa3FYUVdXR2dmWG9xb0hDeXkxcW9rcmc5VzBGbnJqblc2?=
 =?utf-8?B?V2pmMDI2b3BrMzlQdlhtTjZ3SExCYW9MeGcwVlo1RWNpZnd3ZmQxb1pBc0JH?=
 =?utf-8?B?TDJ2S0doUFV0TGpwcC9mdERZYU93ZDZNMFZNZFFGbmVuT2VNd1ZVUEp0aHhp?=
 =?utf-8?B?RXV5N1AxSC9oUGpVemc4SHNPMlJKZHkzQUZ2WkcxSUtabXFQV2FxNllJQWE1?=
 =?utf-8?B?WlpOTVNPYWNPNFIxTGY1bExRUWsvSVRGN3RZcWVXSmlWeUVnbERMMlE3OEtR?=
 =?utf-8?B?YmhSUHQ0RTJLaEFldGR2Z1JLV01TcGJKMnBIdnhjaUhwSE1KcUhROTA0Nmph?=
 =?utf-8?B?RnNMcVJnUk5SZ0pEeG5BUWNtUmM5MEg2YzJsRXRRTnhqZVc2elNuY2pweGlO?=
 =?utf-8?B?UFcwak95MmV3WnR3TGtOK1ZJbk42VDAvbFhsS0duWDlqWi9nRzBMWGNzbVZu?=
 =?utf-8?B?dTZ5YnBaYUxnWUJONmU1eUN3VThtcnVpMHlpcDVkTlJXN1JzT2JORmxXRVBT?=
 =?utf-8?B?RHdMTnd5QTl4T0c3dHcrSXFRL0JYd2dCZFVEQ3BnSXFON0puTVpkQjNjRTdJ?=
 =?utf-8?B?VWhhYmV5MlNaSGo1TlJiaEE0dVZpNzBVWlZMT0FoZHBNT1lPeUlYdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1DB04C901338C47B9E688185D1014AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fBtoR1csu/bwKn/iYhWJ3qmeR94Igu3UjzFNKSM2OmKSWIzQnQvyp/6e+8CUcOMvREFVFZn8bI/bhOGv9sdjjap2rfvdr7P6JCf0kamqYKfpID9SQbdbRPiP6mj3bNwslPR9g/hKKxXbZ0W6spiVnkX6teh1GQXg2naG85eSnJYKWbosbv8Dg64hONC1mMK+T6d21wCk4TLaupyb4XTfAWTVh9fAGoCu1aOcwitZ/An7tgRg7gdA7iJNATrJrbjuu4i4zYpba/nlN9CVeBJRWcV2QIAwqVTY40HZCIebOQv8mQ2gLue1nhg0jw8h+q1MWtluwZFix829f7bH+dSCBw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b193e7d-77f8-4682-9457-08def92319b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 10:10:28.3734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2mRZutNDAOU5NsrwH64QbqcGyH+3uuJ6REmxvQr4oqgrS/qMS8ZM3SjYgbSDBVsHqOSOrc3kWcfAlTRB77HSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8339
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTEzIGF0IDE1OjUyICswODAwLCBIYW8gWmhhbmcgd3JvdGU6DQo+ID4g
Q291bGQgdGhpcyBzZXF1ZW5jZSBjYXVzZSBsYXRjaGVkIGVkZ2UtdHJpZ2dlcmVkIGludGVycnVw
dHMgdG8gYmUgc2lsZW50bHkNCj4gPiBpZ25vcmVkIGFuZCBsb3N0IGlmIGEgZ3Vlc3QgdGVtcG9y
YXJpbHkgbWFza3MgSU9BUElDIHBpbnMgZHVyaW5nIGludGVycnVwdA0KPiA+IGhhbmRsaW5nPw0K
PiA+IA0KPiANCj4gU2FzaGlrbyBzZWVtcyB0byBhc3N1bWUgdGhhdCBhbiBlZGdlLXRyaWdnZXJl
ZCBpbnRlcnJ1cHQgd2hpY2ggaXMgc2lnbmFsZWQNCj4gd2hpbGUgdGhlIElPQVBJQyBSVEUgaXMg
bWFza2VkIG11c3QgcmVtYWluIGxhdGNoZWQgYW5kIHRoZW4gYmUgZGVsaXZlcmVkIHdoZW4NCj4g
dGhlIFJURSBpcyB1bm1hc2tlZC4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBJbnRlbCA4MjA5M0FBIEkv
TyBBZHZhbmNlZCBQcm9ncmFtbWFibGUgSW50ZXJydXB0IENvbnRyb2xsZXIgZGF0YXNoZWV0DQo+
IChodHRwczovL3Bkb3MuY3NhaWwubWl0LmVkdS82LjgyOC8yMDE4L3JlYWRpbmdzL2lhMzIvaW9h
cGljLnBkZikgc3RhdGVzIHRoYXQgDQo+IGVkZ2Utc2Vuc2l0aXZlIGludGVycnVwdHMgc2lnbmFs
ZWQgb24gYSBtYXNrZWQgaW50ZXJydXB0IHBpbiBhcmUgaWdub3JlZCwgDQo+IGkuZS4gdGhleSBh
cmUgbm90IGRlbGl2ZXJlZCBvciBoZWxkIHBlbmRpbmcuDQo+IA0KPiBLVk0ncyB1c2Vyc3BhY2Ug
QUJJIChodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y2LjEyL3ZpcnQva3ZtL2FwaS5o
dG1sI2t2bS1pcnEtbGluZSkgDQo+IGFsc28gcmVwcmVzZW50cyBhbiBlZGdlIGludGVycnVwdCBh
cyBhIHB1bHNlLCBieSBhc3NlcnRpbmcgdGhlIGxpbmUgYW5kIHRoZW4gZGVhc3NlcnRpbmcgDQo+
IGl0LiBJZiB0aGF0IGNvbXBsZXRlIHB1bHNlIG9jY3VycyB3aGlsZSB0aGUgUlRFIGlzIG1hc2tl
ZCwgdGhlcmUgaXMgbm8gcGVuZGluZyBlZGdlIHRoYXQgDQo+IG5lZWRzIHRvIGJlIGRlbGl2ZXJl
ZCBvbiB1bm1hc2suDQoNCisxLg0K
