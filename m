Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F503B38B4;
	Wed, 23 Sep 2026 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206190; cv=fail; b=Q/B+5acqzHvZeTLXWIMQ+n2JZYWsGv+SY7iZNgeWJD6YMBlai/Q5OT/Io1LzwQXf/+tsZLO6r1W/CQIjVYG0yGvQs96UlulTl0Inou1ZNS9gkHlPbyE7s76homRxTfhgK6M6XeFYytwMd9k+mcQrcnI2MIiHcMpI1XI8whT4Ygs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206190; c=relaxed/simple;
	bh=wn9fXpePVieyFBoGoMQaiShB62oTp0Aw2F2zhV6gxs8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ppBtgQbWdDJAeIs5LwLDt5cDYF0eSyg4h0x6L1VYvoCzyc1KfEvGX+aqPHh02URZZC2sXhCKGzFwWIXGExYMr9Gq/DumlKkBfOnMMloXEzE061JrGRiP4FapzkKswztWDAbY110OT2Y02es6pNn2rXa/cQ7eHUAHk5nMZEWO6MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmWAlen8; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmWAlen8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790206189; x=1821742189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wn9fXpePVieyFBoGoMQaiShB62oTp0Aw2F2zhV6gxs8=;
  b=kmWAlen8JPv1P247gbgpHd05bg1ktzpElRtiWT6yFMjoM0PteD8wz6cJ
   0IbBy7c7mkAwVGEWmVAQHmdDKYmgSE93tAdkFOHkD5PJ34607pXGrbvC4
   c0n2I+44brmtuia4h5luW0k8ZD4zcM3GVGR6jeR6cNATFhsaUY45UHgS2
   WIOXBfOT5EiBbRHWwCuEuNoqSaF1idPZX3gcEdPWGy/o1Y6sd3MPAxvnb
   J2rw3zDPRXaXq1bojBu3Zmr2dYXM9kzeNft5n6AFEpBPzcnDlxHuqoBCJ
   LFX0tKCO9cj+Y9Pvnl5Pk8HqRHmJtY4OyXrrCPRqwA3qIQz7+7WcTI5D+
   Q==;
X-CSE-ConnectionGUID: R7uWbeEEQcm89wo1v4vnFw==
X-CSE-MsgGUID: TqwMCxTuSRGDJOHlVb+Zcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89865574"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="89865574"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 16:29:49 -0700
X-CSE-ConnectionGUID: omZcn6ZsTem+sp8LKzjckA==
X-CSE-MsgGUID: MRP80YcmSy2BEIb5taNjeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="278559880"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 16:29:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 16:29:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 16:29:47 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 16:29:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCu/HbacVoyqhF+w/cAchPaKzSdv6E218N5cC6rfztyTu02oiuzRVBwRJ2tVZBIgG4T5bGRq6m4rVT/+2r5KewWAxXvEzzP0cl8NUdf6tQRYjfPGfEBJEh9tua8kL7DxEbN4dEkSVxotbP20VWgAOatb7aEhTch+PPqaW5h0A2/8dNSrY6/rvz/UkdFhWN6r6KKeRV9DXdfS49OjTE970I7AlPpgnV4iRG8n2aGmx7pmPfM17TYC1GOCdWpuFbeURInx2UGyPSi347bEnKjLT1tWqpzJGBgiXE9iRLziD5ylpwP71RKTOhB2tjeTBA9dmgeR/NVB79qqMS0Y+1dD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wn9fXpePVieyFBoGoMQaiShB62oTp0Aw2F2zhV6gxs8=;
 b=YYmhFrQYsQxbwjT8PVKDXYLRZt+lwZqF/Wzs4KKn5zLvkF4mAbPz9twvi7oTFILD51y6vOmLWNb4c5tq9ApDXxh8at0tV81CIM70NnlUlXVh3aQ/1aSo0XIg+oTNoiJOYCSU+L3JjgykasyZ7QQ0rU3HrrP38ncoU1dlpnuxshoDbzyWesKBfMavenszXAhzqD5lNxYGzg6XQGICxWOEWxxnxMoTDgeOSKLddNedeFf7PhuRyIM1G7l90UMSCa9Dk0b/I26i3r5Kme3Kw9Pfyw9rxJx5oAE/xfDl+1e4BcFgvgYGIQBOo51VitDl4HzYovft94rhhc81AmBdk3aUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by MW4PR11MB5799.namprd11.prod.outlook.com (2603:10b6:303:181::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 23:29:43 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 23:29:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>
CC: "jthoughton@google.com" <jthoughton@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "Annapurve, Vishal" <vannapurve@google.com>
Subject: Re: [PATCH] KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO
 on unhandled EPT violation
Thread-Topic: [PATCH] KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO
 on unhandled EPT violation
Thread-Index: AQHdS3lOpZpjMUNuZ0SBG1w9Qe9I/7bcz94A
Date: Wed, 23 Sep 2026 23:29:43 +0000
Message-ID: <8c9922a47e3044683322a5a8755fccca1a1a129a.camel@intel.com>
References: <20260923163315.1580860-1-seanjc@google.com>
In-Reply-To: <20260923163315.1580860-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|MW4PR11MB5799:EE_
x-ms-office365-filtering-correlation-id: a9c4afc1-1269-4ef8-afe6-08df19ca8c04
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: qhy/Sqxi6d4NnjcF+F5j1KfAB6AaB/m8iJ2B5WeAct244g7mIX1ENwV0kPaARh2npR27tys7jzfxWc/bYQN4vvV04XEn0YD6cwEKc76s0pVB9lTOxoLL9onOI/dit84ymBQIFoXF2alpJXQb6v9wyP9K+wUcuz12ZQnXACYa8VeuHGnQ1QFKPkUW68ghilqbMMvltu6lJsLZfhHrYt3Xb+dkZNFfaIF6zbJLny9uavawt4mnzmaU5UkVo38qnixkjQ8Psh236xybERfoBlVYYTopbbP+KOp82lbwT94EcDc3+TevYjPcNa90eANkpN1Uk93Kv/z0znHAGitdvYWiFSkM0eQwsBiakDFhAZnqz7OTxjEOpLdWgUKEJNVpp7yrLJXx+NrK4KzXishObbbEkpHNcRv174Iv+prVPm4sDuAzsJNxNQjJ9V/5uBQcwuxQuIzEf891lHEfw1okzs+qQsiV9v9Mps7XQvqJbn4CQRzpm7UjI5NcswcS0LMLikLqAvgIcMGlsGbtYAVPR2YQ8XFtaUNWlc5yvzSj8oN0kkXjWKZPOmtedRo6Pu+kMWfIw+xsvptd5BG8fG46sgb5VfpcCKJe25UeGV6HMag/Bzyr0uoR6CzXll1R4hjsWVHTRdLknYhOBQuTpFb/N7wDzs3ZhXcFIlHc59Ne0YYTvFQfmcdAbOPMx6NK0aX6cDN5Y8hU92khFK85gWC2v0c6THf0r5/hrK/c62BPQ814dpE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzlEaFBkdWVBOE0yTVdXSzFxVVRKT0ZkL3cvMEdSZlVDYUZxWHU0ZzdmTzdv?=
 =?utf-8?B?MDVTUm1aMHo3cWloWHhCRGVIdmh6VkhZMFZZQWNRZWpVYWdmeDFURTlYMDZZ?=
 =?utf-8?B?dWV0MU9Vbm54U0k3b3FDQTFLTVJBckRKZ3RMaE5MTWVOdzlMblZjamNlMlhI?=
 =?utf-8?B?RGpHdXN0bS9UZ3VJSWwvRDZZUDYxaU1NQVAxOUpwaHUyeWJXbkY2QkpFcHBH?=
 =?utf-8?B?M1J1VDdzazFUR0x2cS9GOE1PSm4vR3hPdXo5blRTVFliVmpKMXZqNFl0V09E?=
 =?utf-8?B?TTZzOGZQY3phT2N0S2JVNXdMSFpWRUdyMVFIVFZXWjZPNkF5clVSakRWU1JW?=
 =?utf-8?B?NEgxYmNCbE9jMFZJSnBzQnl6VkFZWWZ1UTgyajhwZmI2QThmZzhjVUd3enhy?=
 =?utf-8?B?eldQdXdXMTExVkF0M2VPUHp0UTF2eURYV1B6K3kvZ3ZDVkFiUkUreHBid3NG?=
 =?utf-8?B?NmQ5Z1MwLy84MU54VDhnT3YvN1VIL0VMNVduVG1kZHJISmpzZjRWZVNLbXJ2?=
 =?utf-8?B?SnI5TFBYSVpZTStPdTR5MG1jM2JQWTVmTmVWN3ZVZzBzekVtVm1oSzFUeENl?=
 =?utf-8?B?N25pdDF2U0I4Sm9sQWUvYVRpVXo1SWgwaEdoVU5uQm1YMHp5NjJVVzhFUnJu?=
 =?utf-8?B?Y1Y2WmxVbGFQbi92eEFhemFZNzdYZVY3dzU2R2tXZmZtRkk4dGJiUm5heXlr?=
 =?utf-8?B?azV5eHpOcExkUFJqMWE1RVlSMmZSUkt6eUhUKzRscWtUaW4vakEwL0pPS0pU?=
 =?utf-8?B?Mk9SM096WXJyT1BJeFRmeFlKUngvSHV3RlZZNkhOcTVpaWIyTzgvZjBIemFs?=
 =?utf-8?B?K2NwR1JjM1Q0VnV0V3pISnlRNDRTU1N4bUJWclRDcGp4OVBoWGx4MWZQSUNp?=
 =?utf-8?B?S05pMDhiSFNBL29yTnpuQk43aUJOREw5d2pxOXNUeDgweW5lMEw3ZDhiMGQ3?=
 =?utf-8?B?QkF2THBMY01wNVNoUGFvWmZKTmt5VGxzR3c1QUtTc2k2UlhLRy9nQVE0SjF2?=
 =?utf-8?B?cmJadExmeXJUdFM4RjhoR09OTXJmb2dkVU9ucTN1U0JNMGV6R3RuaWJvWXVT?=
 =?utf-8?B?TlpBYTFpTWF3eFVRd3NGSkc3Um1XeW5NckJKYnlVbTlCd1dDdjJJVHBUdzBZ?=
 =?utf-8?B?UFlFY205MnlJOGYzeTR3WHoxdGZESVNvYzVZYTBtdFBYVE4zaC9lUjcybzBw?=
 =?utf-8?B?TkhJV3FTNnFGcHRhUkJmc0szbE90T1VEVWJML0M1V0E2eUt2UitpejBnYmhK?=
 =?utf-8?B?TWpuZWkvR0tKSEw3MHZEdmsxTXdzZFJEOHUzQ2ZyVkFZWWxtUTc1UDBGRjVm?=
 =?utf-8?B?YWlwWHF2QVJjNm53WXZyVWtJL3J2bkd6c0JaWTRtQzRXRkhTeW1wc0d0TjR5?=
 =?utf-8?B?TVNxY3VQaUs4MUpVMXlGOU04N1lEU0VtQ3NCZFBxeHdZZTk1amhETG4waEE4?=
 =?utf-8?B?Wngzd1VhQ1NnaHA0ODV2cDJsYjJObEo3MzZiZGRxejBUaEpMMWtLUVZxcmNy?=
 =?utf-8?B?S0ovOWpZNFd1Z0xWclRKejBXUjFYTTJ0ckltU1MzZWF2Q1U2S0FtVkNhRVpF?=
 =?utf-8?B?YzdXLzdPZFFjWGswc2ZvY013ZGx3TWNjbVRMQytUL0Exb0tOMXRCWnhiRktk?=
 =?utf-8?B?VGk1T0dXek91bU1Nazcram43OWQxUmMvU3NUN0VTd2NNL2J0Wk50K3NkYVdk?=
 =?utf-8?B?T05GSjBMdUlrbERJeVY4dnVDeStlNUMxWElzQ3drdW85dUF6YmpLcFQ5RWtV?=
 =?utf-8?B?TE1TSzdDbjM4bEJNK2lWRHhxL2ZBWU9iaDVJWjBGWmtubW5qdWxiL2dpSGw4?=
 =?utf-8?B?eTI4a1dPamZFZ3NZejdFUFVBTHA3ckkrNDVuRTNobzVLOHk2MnBPUlhTVjM5?=
 =?utf-8?B?Vmt0MDJBeVVCaFVyVlcyOUMvRS92OEMzaklXRnc5OHg1ekNEd2tNbmlhUWNs?=
 =?utf-8?B?TmJkWDhaSXlyaThMNWF4T3lGWkdQSWdQZlFqTmsvUnJiSlIvRVRwZWJmVHBP?=
 =?utf-8?B?b00yOTVTdndBRnFnS1VicitPeFFvVmg3UFRXRmhkVkRnS0ZqaktrN0ZyVThP?=
 =?utf-8?B?MXppZlFHWDUyWk5sTVp5RXYyV2liUTI5cHZxdWl6dWxsbHJza0JOZ2pzSE93?=
 =?utf-8?B?RGIwbjJ0akhXQ2JESkRnMmV6NmdLeFRwZVp2VzQ3dzJMOFpYRlkxSm1DdmQz?=
 =?utf-8?B?ZVVmVEdEVUlkR2xCdWcraDFwNGxmdk1yUTZ6b2RGQjZhZTlSSDZSRHFMTWxU?=
 =?utf-8?B?RUpWQnR5RHhUc3g4MWtVOXNHYkh4ekhzdnhpR25vT1RWME9XR3ZuMUdOdVBV?=
 =?utf-8?B?Qk9PY1VLRFRjdHNOTTdtY2FOdzlvaWpVQis0TzVUVGNUOXhQanByb0N5QW5z?=
 =?utf-8?Q?8gZD3MJ04Q7K7glQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F9CDE35A23E124A91A2E6898C628078@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AbrqvNpIK4LQXm+1yT9ZsG/+ErPiwJRDDaGlAcdb0yhR+hrDTOB/n6ix484teTGkM1Rp4K0NbVBtr+3ogt/5qZfpwDmEAacc9swdNK6Pu9ogSMA4+JX4gcPFUDbZQBrHUiWxCeztVs0tq2AFH1HTImKdZQk9McGXVa9VOfUvtKbvNKhHsB3F8ZKN+xix3qDfHnGWBxOW9G/WjQdyJ+rErwIGMM4Q5bZ6Ti9mTePyDrCI2OqoBtFCsYSOFsbJlZpf8SGkSbZ64kUpgPdK+xxOZSK1sTuaiz47rhVj7qNsOYirvjB5oFfpHtWOPp3FcnyiNleSa0tVFSdcGujYd0RA7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c4afc1-1269-4ef8-afe6-08df19ca8c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 23:29:43.3032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1c0QJ/vZ8OC9fM67AcNc1R+3tZLmAheOiKe4MpkWLw2zP2ZbBVW5xY0EtnYivAfebUz5rbD736oBcXlSLApS8WlZDPVm0Iocnj+eErt1Y/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5799
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDA5OjMzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBTeW50aGVzaXplIGEgdHJpcGxlIGZhdWx0LCBpLmUuIGV4aXQgdG8gdXNlcnNwYWNl
IHdpdGggS1ZNX0VYSVRfU0hVVERPV04sDQo+IGluc3RlYWQgb2YgcmV0dXJuaW5nIC1FSU8gZnJv
bSBLVk1fUlVOIGlmIEtWTSBlbmNvdW50ZXJzIGFuIEVQVCBWaW9sYXRpb24NCj4gZHVlIHRvIGEg
Z3Vlc3QgYWNjZXNzIHRvIGEgcGVuZGluZyBwYWdlLsKgIFJldHVybmluZyAtRUlPIGltcGxpZXMg
S1ZNIGlzDQo+IGJ1Z2d5LCBhbmQgbW9zdCBWTU1zIHdpbGwgcmVzcG9uZCBieSBjb21wbGV0ZWx5
IHRlcm1pbmF0aW5nIHRoZSBWTSwgdmVyc3VzDQo+IHJlYm9vdGluZyB0aGUgVk0gaW4gcmVzcG9u
c2UgdG8gS1ZNX0VYSVRfU0hVVERPV04uwqAgSS5lLiBnaXZlIHRoZSBWTU0gdGhlDQo+IG9wdGlv
biBvZiB0cnlpbmcgdG8ga2VlcCB0aGUgVk0gKGZyb20gdGhlIGVuZCB1c2VyJ3MgcGVyc3BlY3Rp
dmUpIGFsaXZlLg0KDQpXaHkgbm90IGp1c3QgcmV0dXJuIEtWTV9FWElUX1NIVVRET1dOIGRpcmVj
dGx5IHdoZW4gdGhlIHBlbmRpbmcgZXB0IHZpb2xhdGlvbiBpcw0KZGV0ZWN0ZWQ/IFRoZSBzeW50
aGV0aWMgdHJpcGxlIGZhdWx0IG1ha2VzIGl0IGhhcmRlciB0byB0cmFjZSB3aGF0IGlzIGhhcHBl
bmluZy4NCkkgZ3Vlc3MgdGhlcmUgaXMgc29tZSBjZW50cmFsaXphdGlvbiwgYnV0IGhhcmRlciB0
byB0cmFjZS4NCg0KPiANCj4gSWRlYWxseSwgS1ZNIHdvdWxkIHByb2JhYmx5IGV4aXQgd2l0aCBL
Vk1fRVhJVF9NRU1PUllfRkFVTFQsIGJ1dCBLVk0gd291bGQNCj4gbmVlZCB0byBleHRlbmQgcnVu
LT5tZW1vcnlfZmF1bHQgc28gdGhhdCB1c2Vyc3BhY2Uga25vd3MgdGhlIGZhdWx0IGNhbid0IGJl
DQo+IGhhbmRsZWQuwqAgVGhpcyBzY2VuYXJpbyBzcGVjaWZpY2FsbHkgb2NjdXJzIHdoZW4gdGhl
IGd1ZXN0IGhhcyBkZWxpYmVyYXRlbHkNCj4gZGlzYWJsZWQgI1ZFcyBvbiB1bmFjY2VwdGVkIG1l
bW9yeSBmb3Igc2VjdXJpdHkgcHVycG9zZXMsIGkuZS4gdGhlIGd1ZXN0DQo+IGxpdGVyYWxseSBk
aXNhYmxlZCB0aGUgbWVjaGFuaXNtIHRoYXQgdGVsbHMgaXQgaXQgc2NyZXdlZCB1cC7CoCBCdXQs
IGJlY2F1c2UNCj4gdGhpcyBpcyBmYXRhbCwgYW5kIHRoZSB3aG9sZSBwb2ludCBpcyB0byBOT1Qg
dHJ5IHRvIGZpeHVwIHRoZSBmYXVsdCwNCj4ganVtcGluZyB0aHJvdWdoIGhvb3BzIHRvIHJldHVy
biBNRU1PUllfRkFVTFQgaW5zdGVhZCBvZiBTSFVURE9XTiBkb2Vzbid0DQo+IG1ha2UgYSB3aG9s
ZSBsb3Qgb2Ygc2Vuc2UuDQo+IA0KPiBGaXhlczogZTZhODU3ODFmNzgzICgiS1ZNOiBURFg6IERl
dGVjdCB1bmV4cGVjdGVkIFNFUFQgdmlvbGF0aW9ucyBkdWUgdG8gcGVuZGluZyBTUFRFcyIpDQo+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBKYW1lcyBIb3VnaHRvbiA8anRob3Vn
aHRvbkBnb29nbGUuY29tPg0KPiBDYzogWGlhb3lhbyBMaSA8eGlhb3lhby5saUBpbnRlbC5jb20+
DQo+IENjOiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+IENj
OiBZYW4gWmhhbyA8eWFuLnkuemhhb0BpbnRlbC5jb20+DQo+IENjOiBCaW5iaW4gV3UgPGJpbmJp
bi53dUBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBBY2tlcmxleSBUbmcgPGFja2VybGV5dG5nQGdv
b2dsZS5jb20+DQo+IENjOiBWaXNoYWwgQW5uYXB1cnZlIDx2YW5uYXB1cnZlQGdvb2dsZS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29t
Pg0KPiAtLS0NCj4gDQo+IENvbXBpbGUgdGVzdGVkIG9ubHkuDQoNCllhbiwgSSB2YWd1ZWx5IHJl
Y2FsbCB5b3UgaGFkIGEgdGVzdCB0aGF0IGNvdWxkIHRyaWdnZXIgdGhpcyBjYXNlIGR1cmluZyB0
aGUNCmJhc2UgZW5hYmxpbmc/DQo=
