Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283CE12CD8B;
	Mon, 15 Jun 2026 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781489787; cv=fail; b=gtX4Xjb3/hbYcxgc92+Eph/KYRWSTuKFyCJyo4rmVR+zQCSaEir2mBKlb5+v3GNbjtv7YP9v6kR4GgvBvVWFIPe+BTpvqB2iD9QqqkRurSfdh8CHqOS/HB3h49lRbABoGqOyaN1MNdWxB2XlxxVefMpjVFYFRuCwNSWLQ0S1hKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781489787; c=relaxed/simple;
	bh=hvihm4B00+emdm1NK1/W8iJHWWj9wqQPLzqqy6S64v0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9jcJ/Oip3cjFo4Wiezw+RjnuSKOde1KkO35aaKA+yLLW1Snv/tIqrTaMzy4gSvQBZ2WuIK8k89Hie0V30KbkqUVbUEGehZNAPrtdzeHd2aKWeZ/ngyWMZVWRASlZdqQZpRH0bBfnW3z5GXsaI5ZxbYvqXmA0z8DkiGGS6OjS8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAIjBpy1; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAIjBpy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781489785; x=1813025785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hvihm4B00+emdm1NK1/W8iJHWWj9wqQPLzqqy6S64v0=;
  b=iAIjBpy1EYFsDV8aiJRdEh2Vv/HbCavKiM7qSHVLVDbxelKWvgSpC/qb
   hm7rV3sidMrx54qLlA6hp45iaC2DFL3U8OPuSWPSJg4rDi7XPugRRs70T
   xeQ7bkQR8+FYf4MJckKVy33ZaAnYuC7Z59hFjFXX8zaSCc5grMCF0MJob
   m6yQPfFs/8kIkgjwtAGKHAQ7tCBNlFqF6A0tZIJCJu6YAKFpC5v75ch9T
   Dd89CO1cDmXsk1luO9Inx7AJ0hKdPaRLEHKODEyF4gRSHCjo8orq47Zbb
   vjI5ImD2p3iOH4Gcs3KjVYyN98ggMkpTMY2/OIx7Unw+EXFRNng+N0a2b
   g==;
X-CSE-ConnectionGUID: PWZHw23IRh+k8f8To8nYBA==
X-CSE-MsgGUID: il7PvUnbRsyUJPNhzyU5rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82208703"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="82208703"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:16:24 -0700
X-CSE-ConnectionGUID: keorQukJRAaZqZpgvl20bQ==
X-CSE-MsgGUID: RR2m1q+fRHeO8+0+uAaRag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="246242538"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:16:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:16:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 19:16:24 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:16:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBVF+QpSfIxp3fEpAZPkQbwkOjwhC9aKKgcbqEhbak4dW2rzYOM6+gAgkOoWYyknd/yxGBADMuRgmzowkZdtH8U7+kGNJUbzAPU7smxiz/iZYgIMLdLwlXxmcB1zHfJzKR+CdKCcOYrXAI8KdnJCIC7ITGXl95l8aKVJX6Gt8/5hitD/XnK3hOzrBa9V2yr3JLeg7WdyfZr8X4o2f2EkXcFxWTcynlOQXmH5TPuhGeLcxCgwqg4HdS1fEmoencAakDlKF9bJ5l2teFNmjaS8KEWbDjtg38xB0tegvg3CXnx/m3hfhZwiiki2tQBUvGKt9DFR7wutwwWzOpk1l4ZYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvihm4B00+emdm1NK1/W8iJHWWj9wqQPLzqqy6S64v0=;
 b=sAMBLVYlCIEBw0LUGVf+qfB20lV5v/hCnRbm2+6DMXoIwwMmPpqzylJlDI7qJ/sXlNbhteWHT0lvKxq249xSabFPHwdLw9JVrmM83sNXubXIXOHvMlCSO6eKjGAaW9CKcfDd+F72Q7kmztD/CmiWaBQpGq3uTuFtcx5PRN/MPuhH2EW0G0t2MZl7jSEPprRb57T5HpNtQm8O3GM1gIyllsI5kV9MoQjnsVr/jxXnoxcHOMHr9j+ilE/aEsq02nuyzAZCS61VszaIqPpxoIs1pZjPNRPqMRQfoB1Mva9K4aZSi5iEzswC9b2T3XMivrRLzTn6n+t+PCXT1gi7AKMm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 MW3PR11MB4617.namprd11.prod.outlook.com (2603:10b6:303:59::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 02:16:21 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 02:16:20 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH v4 01/30] KVM: x86: Extract REGS and SREGS runtime sync
 code to helpers
Thread-Topic: [PATCH v4 01/30] KVM: x86: Extract REGS and SREGS runtime sync
 code to helpers
Thread-Index: AQHc+sgZY4cKaKdDdEWP6wml4yKU4LY+5FYA
Date: Mon, 15 Jun 2026 02:16:20 +0000
Message-ID: <603fcb4e3250e9450468df640462afbea8fd8e5c.camel@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
	 <20260613000329.732085-2-seanjc@google.com>
In-Reply-To: <20260613000329.732085-2-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|MW3PR11MB4617:EE_
x-ms-office365-filtering-correlation-id: 62fbae39-6e00-49bd-4a66-08deca8416d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: dJTLMQb6n2Bn7V88RFYosMQ0ZG8VUMkEyn2cjkG0ngCFXqayJRk6QDPz0skxh4RdklB/dMpqisI/Sx2s0O1zrYjdFZQ0RBuTbpvZ6scrvOWwJcttq1WaUgkyKaY/uo9p1wHGy3rxL2jgqE/E8xS0rr72BgfDlftIfcGH/wmU8MHbIWuKj35WTW5RmG+wDzUl9LiWufHuWMhOIkWDSl26X/ji10KWcHrDvgmHSsLtZAAOOQ+a0AHmyfe0yrDLCqdu+HTaaAonW0TpQfnfgQQBpDD+fk/zwelIgU0XQpy0gp5M2QEywISt4xLrieA/Llh0RtWBlFv9duMRUbrEoXGEFggHt/efInxqb9ErRZFSETO+Hq9JdALPOMoYjcwHHMxVh8H9XW3WO7YnudkdYm+oWMactDiADLuDJkxqd2GkMWVsJYKWhIvTD5ppXI8G9tXCQ+uxhbi6e4sWDwjYOpGH6pH6dnAZ1y2vGQk+71+A5at+lgOuCE5JnaazJ+y+bnHTdgpdg5nhceyEnZnqTpjX6r4rVNJiJwr09gIcncmc9Kei6rWO1U08HFt2ou3hgBHMFXbBxwIbWTvlgnSX1JfDvWj+V69SHYyOzcO1wKcllpU8+0RurJ+0jeiTih4AFIeAG5VtPyTxOZ21O0+INrdwkZjinC0lZZpijzutI9rxZic201WPD6d0NtaCz41gFVK5umWepBOIxvkhAZ6Jkl+vpLNMjeeGTUCSSbFnojNNua04+EiHSRykQeq5P6xS/P/B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVNURUloRW1EQjVFMGtGVzJEUWRJRTVqdm5zV251aHNYZ05KSDNhWU52MGpn?=
 =?utf-8?B?L1U4azFVQUttUTZxKytpMytSaHF1NDc0VnpEQ3F5dTVHcjd1S2FzQWM4NEl1?=
 =?utf-8?B?MGs4cDVpV2hiU2lqeGNwczNFMzJkRXV3aUVHb0xQMmxlblp5dHhrM0hiU09F?=
 =?utf-8?B?YXRtTkd0MEJyQXl5b1VNN25BYnlJSXhqaUpvU085ZXFQRU9GbExyaDFBTTBz?=
 =?utf-8?B?Ymk4YlA3T1ZOTUdFd3dBTTVLa0ZjUTV1MVJpclJscmRpbWdCUDNDR1MwZ1hz?=
 =?utf-8?B?OHBKZGhhTHdSQ1kxVDJoRE5vZVJ0b2V1Qk0yVU9FaDBUTEVPU0pCL01PYTMv?=
 =?utf-8?B?aUhrcCtPZGtYZ3FHV0tCTGxTR0k0WDdjNkw4QUlKTDFyeXUxTy9uQzdlUERo?=
 =?utf-8?B?ZDNIaVptY1dIWUs3UHFXaFpqWlFaZ0p4aFRPTDU1dkVkTWV1UXpCcHp3SzQz?=
 =?utf-8?B?QWxpcHZLWUVzR2luWHBQNjhBcUtzVkg3TVY4cEliaVZkb3FtaU9vWGlyYzQ4?=
 =?utf-8?B?U0xwTzFnNXdBQ1BkTTVjVTQwSUpPbkpwMEpMc2NxdkhGb1VlTWoza3dCTmJk?=
 =?utf-8?B?VEplRzMyeUtQazFVTHViYktISWlsMllMVU4wMDg1NXVyUmxrVmRrY1c5bHdW?=
 =?utf-8?B?bDVBeTRjbTEvN0JGN1JwUURtbnVnS2srQzdJWGRPZzlnakpBRFM1Z2dic0E2?=
 =?utf-8?B?K3U5TmdlYUtQUk80b3JSODVUVWd3aUpaTjh1bnI5Ly9PbDcyZlVXRzFxSHZJ?=
 =?utf-8?B?UFNIVXQwTVhITnZhTTVhOGs1eGsrbWdBdC9nWnl2bXFTRE5UVDZ6VCtIRysw?=
 =?utf-8?B?dDFjUm9wZTc0cWNoaUh3K1JTU1hWVzhGWk9LbXN6eGgvSmQxblI0U3R6WnpI?=
 =?utf-8?B?T2hrdlRkSjFzWTgyWVV0Y3N0Uk9QR1NpbXQvU1JxOHI4RFhJbWFEQTJlbXBv?=
 =?utf-8?B?aVhjSUM3UzNKakhBZmlPT003eDhMVWFOZmF1NFB5MEdPUEszMEdqNGQ0cm5h?=
 =?utf-8?B?TGEwZ3c0RjFsY0UweG1uZ1V5WW03MmhheUJadmdOYTdxbVdSUGlxMFZIVDI5?=
 =?utf-8?B?OS9Fa3cveVE5UmtRM01oOUNnK1NIbUJ1V0syRXpGWEpuRWVwNEJFSFNSaUkx?=
 =?utf-8?B?czZ2STk1aFhsbkxmdVJENnVDcTFiNGRDNEorNCtxV3BJL1N2VllaTXdiTGdT?=
 =?utf-8?B?TDRUc3E3N3BXNGc1TlVEOFVhM2RDd0F5RUdOZWJzR2pSTUM3WkFPT2wrQnFz?=
 =?utf-8?B?NEZmTVNrUk5RKy8ycy9kdTVWM1FoT3NtRkFqT21Id2h2S0hVQmRFbEthNG9Z?=
 =?utf-8?B?ZElZMk1lbS93S3grbHgzMGhvZXB3alFLYTFDYitHRmhZM0Jzd2hXOVphZi85?=
 =?utf-8?B?QVJEUDVkVnVCdUtkQzBuMDBuTkk2NjFyRXdFcjdpOXUvRlZjM1ZIYThHLzh5?=
 =?utf-8?B?dXNVdzVLQ1FrOEpKbldSTFFsVituL3ArcElxWGwxN2ZIclpMZG9ZQ2crdTZ0?=
 =?utf-8?B?UmNUK1FWWStTQVo4cUhuazhSQjkzUDR4eHRYV2h4cDdrTFZNZjF2WXNTdW9o?=
 =?utf-8?B?Z09oRUFSQlVqb0NRMlNJRE1ZOHp2QVptRkRISVJvcEcvQS9qeEhyaHhNZDNN?=
 =?utf-8?B?bnFiOWQ4NHB1T2ZqWUNmNWR4clFQWnRFK1NzSUNiUGtTakx3MjdYM2FJY1hU?=
 =?utf-8?B?a1dORlY3ckFqd3hab0lUVnUzNm5yMm1qRmgycTRKdTY4UHo5Q0dJZENiTWVH?=
 =?utf-8?B?MWlOeTRhVzFaS2FWNFdaYTV1bTJyaWdvSDIvNEl1dFNqWG9xYXpZOHRJRE5K?=
 =?utf-8?B?YkFqL0NCTnBJWGlaL3YxQ1ovQUpjVEowbXNZN2dxb0RXZXRwYThuTHFVemZV?=
 =?utf-8?B?bjljcko0VSs1MXdETFA1N3R4dFMxOWxkZzJhS1FZRm81T2tVUFgySW9HMGdT?=
 =?utf-8?B?QUpPbHIzb2NmOWVXUW1icWROVXBqN2NlMDBKZ3drVzVUcSs2REhSdGFDNFAx?=
 =?utf-8?B?ZUxTaEcxTksvSEVybXpscVhtQ3crYzZWQWdEMVorK1NHSW50MkxIQjBQVkRZ?=
 =?utf-8?B?b2FnMmFwN2RyeGkrRHZNRFlPQjhCb3hUcUozSVI4R2RNSnh0MkRqUlJSbGhV?=
 =?utf-8?B?ajlHY0h3dFBWbnNuQ1U3UzJQTWxSRHdnTWN4SDZvWko0S0hPTVlQU1B4WC9Q?=
 =?utf-8?B?WUJnVjFRckJlQjdoVHBySENhNXVJSWg1T0hKUkNqUE5CTFQzUGhwTUV2eDh4?=
 =?utf-8?B?MCtXK0RuQWh4VldUNWg2Q0J4aUZ6d2RlTlg5UXRHb3VrSWllVzBRbEtwVWNU?=
 =?utf-8?B?dUtPYkxTWUNPZGRSRWFyR0hIZVFUbU1nNDlrdE1NM1B0Qm9hNElmZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAF8FB2AA5A5094EA7742B604EB17C05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l8jnGr+2DgQEG891SxtzZGMpf5TjAHmGRrlibHYZpVz6sdHYiDIcGRIJ+jsDqlkYlHldZJbj4vDfW0zhAWCC8p79NWJMvEZuFCH978Tid7HfqztE5pAKlf4LCCxy2chI0IfHEKf+DavGHVcpQiEK9z+ay1Yf4weF1Kwb0PuY88jxTrgAVT4ZFxCsp56Fct4v4ck/Ibl8LJ0W3OynssmcqADMEwx/xr+daN70bW0KiImbxVV6acvmuNrZUbUOa/I167BYgyASQ+x9qOpeTyexAT4cWS5TbeeMWkqUf8gKCmOj4e76MX9jcpkJW7BsGV8ox8sltXR1t7R7fpWon8mrOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fbae39-6e00-49bd-4a66-08deca8416d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 02:16:20.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5GTpjpvl78p02Tbc/flWIISUmAcTmhj+5dxpX1Ci6HZeTWnaccnu6Ka9Qpkios2vgTziQjHJAZS+VTjobEwjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4617
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTEyIGF0IDE3OjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBFeHRyYWN0IHRoZSBSRUdTIGFuZCBTUkVHUyBwb3J0aW9ucyBvZiB7c3RvcmUsc3lu
Y31fcmVncygpIGludG8gc2VwYXJhdGUNCj4gaGVscGVycyBpbiBhbnRpY2lwYXRpb24gb2YgbW92
aW5nIHRoZSByZWdpc3RlciBzcGVjaWZpYyBjb2RlIG91dCBvZiB4ODYuYw0KPiBhbmQgaW50byBy
ZWdzLmMuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IENjOiBZ
b3NyeSBBaG1lZCA8eW9zcnlAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJp
c3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcg
PGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
