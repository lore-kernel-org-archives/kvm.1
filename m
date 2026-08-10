Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465E2EB5A6;
	Mon, 10 Aug 2026 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394266; cv=fail; b=r2WFPTx8z2g2+Qu7r5XTV535Y3aFZj2NxOAV4eW8B+qiGNGBFwL+YPMt+S7mgRPj5HJh3u5py2Ww/FLPxD9zbjBLTf6LJfClj6DQVLx7w4xaKCJdeGE1Uq1nLgs3fc7jgQ1tTwtxwtrz3UdHhbO+CI6QmHfG8F18xUKL2IRYQno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394266; c=relaxed/simple;
	bh=08DjMKeubRaOqY5e/TYqapGzb1gY+rg5ZLm5II+JVjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qsFA1DlOGXveUZlr9nsp4o2uqyhy+/QSBpZeBYhL2yESoTxmGOTBsTSvybDgQNUe2KEMWlsLHZDRCsWZWxAKiBg4nFCZ7BgfS2yQK8AqN1QvG80NgN3RHe148g4ICDbTFCEeO8gRCTsjKpRyG050SuRZ8H376olutQxjnz5QjVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfD47mGG; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfD47mGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786394264; x=1817930264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=08DjMKeubRaOqY5e/TYqapGzb1gY+rg5ZLm5II+JVjg=;
  b=kfD47mGG7oITrtrT7z8TSdAKcbwWondrwcTTeRbOcLJEOtCWpqa1Vp+I
   GL6lPnE/Pjdar40AInXwsoh1VLtaS80Oai46rGpP31HZI4vXl/Njgtq0U
   dWWXG/SGLynW2lUI2kIPFp6PlLrqE+FLKeb1buGrjKlH/6x37hjdSm30F
   a0KcvNTr/SyXuW+qkyLZDB2BOs1qRMWd29EcFJBeYdFY/KsBLLSUfjp9q
   QGkNaNYwlFG7Pr8Lf8rXMkEP/8+9vrqw6zluJ8FSZMoy5Txhyc1m2itP9
   mLIGaT4aIATWgroPOeorNCkLrzTPBsxddhJynGiOWzxxp37ScFxUMv4Jg
   A==;
X-CSE-ConnectionGUID: UzwK9VB4Qeq9mPlUdVE+Aw==
X-CSE-MsgGUID: 5kNECfDtQOSYH9iqmNfhjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="89446442"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="89446442"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 13:37:43 -0700
X-CSE-ConnectionGUID: 4QpfH0vjTDWX2KmuzGVTjA==
X-CSE-MsgGUID: XZUJq80NSXKxCghRidkInA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="268300748"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 13:37:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 13:37:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 13:37:39 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 13:37:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy0bVGGiYuSy0kr+x1VTRG7E/mfAOOtSUmW4ciKaCwj4P9pmaAd9KOWFZSw4+I/wc3xdaRZ8WCup2IYKXv6GmAKxLCY9BWOc2dQnweU5p3HFcdBWvlVgCdMoROZh7lKzLLP0gxb4kAIFrf2UZ04Mavz9xfDI2mN52l5iL8pLjsP2RbloIqvOyg2c742JB3C45bly8b6ARtNoTBHjhnx5Ms2ETQnOmObJMb8gt1y16zSz84oJrKB1WgkQtmIc4xWoOgf8H+wbqBEJnJdPmGtF9xpVqo2yeKR6y8hQ7lueGrRNZzWUdk6jeQQSPwCv5bU7/NFV3BS6C5+7duOVL/k/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08DjMKeubRaOqY5e/TYqapGzb1gY+rg5ZLm5II+JVjg=;
 b=FwFuSN4HpczaR3lADqGBjwxTa7kqzr/bfnsfFWshG8imGnXVQ1RRKsZMLu0nIqtsiFa2oTa8Zy7T6p3H0sgLMX3fw4iWfcEmJ0/GPs3UmZBlQCr64QJPMnzNSnFxaZw+lFxMr9DOv5zuLvfi/6o7w+8wSXIiqkDWQhy2yUsBcUSWn0vVla5KXNI/xu/Cl/WgeoFJLw3PatelUcsVBQQy4H2SxC/rMrEna38NoDosNHP3ZbogSBPE39OUsWB+5ROSRx/x4q/du9pynPYxQB8yHxQ6MrOj8y8C7fVrYhi2H1SMl+Akv3oXmojfiXkMhvYolDASH/q19ArQEH2JQuF5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW4PR11MB7005.namprd11.prod.outlook.com (2603:10b6:303:22e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 20:37:28 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 20:37:28 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Zhao, Yan Y" <yan.y.zhao@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Top-up memory caches when retrying "map
 private PFN"
Thread-Topic: [PATCH 3/4] KVM: x86/mmu: Top-up memory caches when retrying
 "map private PFN"
Thread-Index: AQHdJexOBXYG+xaP8k+TlGwBevb9sLaTDZuAgAAaf4CABJwqgA==
Date: Mon, 10 Aug 2026 20:37:28 +0000
Message-ID: <1fc757de50acfdfac5f734a3ad1eaed4123cfbf8.camel@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
	 <20260806214050.78058-4-seanjc@google.com>
	 <7867c759880de0ea4628deccfaa077a5d1c5fce9.camel@intel.com>
	 <anZYib2bADjRmxvE@google.com>
In-Reply-To: <anZYib2bADjRmxvE@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW4PR11MB7005:EE_
x-ms-office365-filtering-correlation-id: 0a684af0-60c9-4f84-3a12-08def71f31be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|11063799006|5023799004|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: TSPxrZpwNdWUCU/135YAgd4RDxPDLq5iIkRY9H3t545vC7SCKO6fvPX1TyRpkgYHUkG8oxw0aqf6XMkHpQXatI50fMoC9+kfYm3whaEKGSGpGBHnPGpm3iSHqOp8gM+YOiaOk6NjZ05pPXlhg75+W+oQFMNNaAEoELK7hPxb1czkbjbLLhS6y3UMWJxcD6BDeSUu/Gri5sRzI6AZuUMsJwfBuQwQIGtB3II306RkTBXVxsOaczqoV0cwN8/ahuOYEt/cxPHbJ5ONq+vHTV75VC0BQYneltPMXIRkruWoGI5HIjzF9uumbWw401cm3J5lFpC2EacThTTbTXQZIgQILXbHzi/iPYh3HrrLpZedIeKad3JmevM4/fU810CHZQNSBLCw03RxBtg9bMTxrLpErMHtPGRGHgbQW88EEU5OKfyVtQWCgRTVUEfEntd0ZfIm4zlu/kB+QHnTsuzrsTOS59SK4939pbu6mAQqkeaHbSjw3Rr2l2EeDwyz5l0Or3C/S5mcnXeztzr8S+GtxDbqSguh/64d2qkbJpKlvv9O5NdNGbVOT2XdWtbQN2qByhGALWTgR9kRisswLhUYFRpHnTazH2T8kaBvL2/hDQccZEVpnDjBcGWHOBULdgsiR+7PxmCwpRrNwT6N1nhUR4pOTUD3PrhQwUtaxXde8aNiUZDixgGv6arb+6gwGGaJFRKVHwwtNlPdqd3IwLjCzxQPZgmu5Jh9gOTgGTCxAoqXZ3M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(11063799006)(5023799004)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWd5Q0E1L25ySFZwSHBtK2hVYURFTXQwR0pzVm9qZk5mUmFYZnByYStyWndq?=
 =?utf-8?B?YS84TXFNTUV2YzFGR1RsYmMxWjN6WkU0TUlCVTVROWxveTY1d3R6ZEZtRUJi?=
 =?utf-8?B?aDk2SXBsclNFdTZhT2ZJZEZvNDlqVzAwdGNqcTBXQS85ZTVZQ0J3L1dVRWN2?=
 =?utf-8?B?M282Zk5TRXplZURsR1ZwNEVSN3l1d1FQUHpCS1BoWjdzSjdVa2NhUWFmbUxs?=
 =?utf-8?B?Y1pxY3pRK1BwbUlqS3pXTEdJeU13bFIvY2RKbk0vNFpYTTBWY3VjcCtZN09T?=
 =?utf-8?B?UXR2Zk15RnZYbmZaNWk0d2F3ck5OMWtNK3p3NndyaCtScWovV0RqK2paRUZ3?=
 =?utf-8?B?cGJ3Sm5HVHVoN1IySjc4bVFFVktUcHZwdlhGdjFWa0RJbFBQTzBWaUZjSzNN?=
 =?utf-8?B?S0svUGRCVFh0VmgyOXVYWC9aUml6cUR6WG1VcjErYlM2QXhkWEkydi9VNkwv?=
 =?utf-8?B?L3ZBSS9Sc1huUzRrQ0EyY1pBOFZPVWlNTVlCR3Z4UGpFUFRGRGVKcG9RNXlP?=
 =?utf-8?B?Qys2QWx4UlFUMStEcFl3NTd5dUVxdjBIZ1A0TWwyYUxCT0VKL2d1YUNOWWN5?=
 =?utf-8?B?dVhYdXlPTGxlMVpxR3NsTWgycWl1Q0IzZEhtdHU3SU5DZVVGTzk5WUlaK2x3?=
 =?utf-8?B?eVZ3ZnFmeENGa1BLY0g2c2lERFUvN0lDdjlXMmhDMkNHV0JrQ1QzRmFuL1gy?=
 =?utf-8?B?d1lTQzJJWHY0TkZUK0wySCtabGc0VG9CWE82MitzN0FrRDFOcTNaRGd4U1hr?=
 =?utf-8?B?eEdWdjM4M1JTYVVybWxzWXJtVG9na05mTGxJZm5xQzZRSHdxSDIvQnZmbVpi?=
 =?utf-8?B?TlMvSGo1NUNBUk1VSldYdXoxSXJwZUF4dk5HWWZFMHY0anhldHlWTklFbUEx?=
 =?utf-8?B?UWpMa09rSjliN2pOdWJNWk42cnpYelpaSEFhOXI4ZlFXS2ZiOGVVZmk4WUti?=
 =?utf-8?B?N1Y0OWhjT2N1ZmYvZ3ppS0lLbHY1N0N6YnhPd3FVNk5HZko2bHQ5OFlzaGJm?=
 =?utf-8?B?cTdwdFY3MHBTeUtna01ENzFNTDhjZ2NEMnlkRmZhQ0VaSjg4ZkRaTzBjYkdj?=
 =?utf-8?B?RG41MmNWa2E1bWxzY0dFT2JXVm0xeHhUaklSK0NYeGxLTUdGdmRha2xJellr?=
 =?utf-8?B?YTZUbGJoNlN5ak50bFNxa2ZjTkQ0N2VFejZTVW5sK2dWVTRhY3h1dVEzdVQ1?=
 =?utf-8?B?WDQ5SWJzMXBDSjFSU2RsZHlYWFdIU0J4RFNsWjRLdGVZY3pjRGxSeG5Kc3d6?=
 =?utf-8?B?THROdE5IS1hDdUFpN3ZndmJGOWxNbTdCZHJjbzBCRGZvcTNUOUUxdDVOOXBq?=
 =?utf-8?B?QXBJVGhvcUpEMGZEZy9EeSs1SEM0MStHKythS3FwWnZvUVJ5dHlKS05WSFk1?=
 =?utf-8?B?UWZPd1RSNGZ4UFV0U0JkeTVPbm1yTTQ4YWtKaWdENU05OXlBNWV3Z3FCQWE1?=
 =?utf-8?B?OFZ5RVV4K1VFVUFqbytlTWRybHV5V3ZhYTFBRk50SkdDRHhIeENsc0ZuT0Yw?=
 =?utf-8?B?YW9ubE8yYVhyanlVSmM4QTd4NUFiVS9aOWc5NjUzZ1VHTEZhZkh6ZHFjTU5v?=
 =?utf-8?B?WnAwaVFqOTBKSjRhcnJsbnpZRFJiUHhsZEc2a2F0dnBRU2VJZ1VJWHNqZ0xT?=
 =?utf-8?B?U3RuNllDWW1QcStqMnA0a1BNd0J4dEpLbHUwc2YrZDZUZytpNDZkcmd1aDVL?=
 =?utf-8?B?NWdWek51KzhvVWs1amNicm91eWxpNEpJNkxsQUNrZUNzMmJzeGVqRjcwbjcr?=
 =?utf-8?B?N1JOdHhCODB1WGtDclE3TU16ZllEZ1pjaTluQk5idy9YaXRzakZBeW9paThV?=
 =?utf-8?B?eXpleWduSFVTcU1VUlBLT015Z3FyRko2cHgyaXJOazlaOVhnMERQSlhHTDR4?=
 =?utf-8?B?UlVvQkZhMmdnTFBKbEV5b0ZoNzE0c0U5bTZEaFdVWXh5M213eU45S2tlRGtP?=
 =?utf-8?B?YllsSThXZzhFeExhMzQ3amxwckM2cEtHYlFWSk12em1MUjN2R1kzaEhkMHBq?=
 =?utf-8?B?RUQvRzQxRGVXbWhXSmNRYzJDWWVZZmFpdXN2ZXlLckxkUnVzUnpDbFNFZlBz?=
 =?utf-8?B?QmJDSnFnQUJ0Um5udXJYUDc1cDVRNjlZMnNLVGRBeHdOZWFPVFpxbWtCR3NV?=
 =?utf-8?B?QnNJcm90OHU0RTVCWU5paG12MGlyNnVwZzUvSlJweStUZlU5U0VQODBkck1q?=
 =?utf-8?B?cGF1aFBoV3NkclZ1TkJkc0F1bDl4YjErcmRaQUV5WHJQYXVmRXFOT3poUGxl?=
 =?utf-8?B?T2F1M3lwMkNLQ01vL0Z4MUlpR1VYSHBXVUtpMjdGSlhtYWtERlBReWYrY3Zr?=
 =?utf-8?B?T2hxWlFwdUUwM1d3NEc3eXQyNmNlNHFBSlRWbkhIR3lOSlVQTkk1bHZueSt3?=
 =?utf-8?Q?WOv6KhOkqMejzOUs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <086FE6978539BA47B71967031239C360@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BzpjpO2xxULEKWYI1cOHlojLaJ/SohbbgbF4SbLrN4/UcaHPuc+Phkf06ugytLCZh3NSTpNisfC9b1pOwngowFw5Xy4n/KLu2g/Ffhq7LhN2HnQlyc/7BiQ5nod1PDttCpqt9vcS5xfQw3ggTPaX5YAC+Z0nCBG+C2q2+cyZEu8K5jydOCIfDt9t+qlLuoIy+wKTbmCqatb+NgtPFNHqpClSGW92e4DaZKD1PAvPPaonb/HBzvC+GA9ScF4vbLpVBSDSzZbIiy5/M+GfPMBdpMax+5fTpUQywTSFvcxGwqclzidy4DINeaGTT1Im6sQqO8QIwYBpwhGlLnc8FDwPUg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a684af0-60c9-4f84-3a12-08def71f31be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 20:37:28.3403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGkd3O6ojTbQB+GOMT1vEycpHysr5MbehVcD2/uKc1wlHhPpIyrvm/x2KeUhw9IHYpKXDuJoEyklCdBg5Fhjvg8BCX+0LEavND6gXqapRMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7005
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTA3IGF0IDE1OjEzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IEkgdGhpbmsgaXQgaXMgdGhlIHNhbWUgZm9yIHRoZSBvdGhlciBjYWNoZXMgY29u
c3VtZWQgYnkgdGhlIGZhdWx0LiBJIGd1ZXNzDQo+ID4gImUuZy4iIGNvdmVycyBpdC4gQnV0IGl0
J3Mgbm90IG5ldyBhZnRlciBEUEFNVC4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgc28/wqAgRXNwZWNp
YWxseSBzaW5jZSBhcyB5b3UgcG9pbnQgb3V0IGJlbG93LCBub3RoaW5nIGVsc2UgY2FuDQo+IG11
Y2sgd2l0aCB0aGUgU1BURXMuwqAgVGhlIFREUCBNTVUgb25seSBjb25zdW1lcyBhbiBjYWNoZSBl
bnRyeSBpZiBpdA0KPiBzdWNjZXNzZnVsbHkgY3JlYXRlcyBhIFNQVEUsIGFuZCBzaW5jZSBub3Ro
aW5nIGNhbiBtdWNrIHdpdGggU1BURXMsIGFueXRoaW5nDQo+IGNyZWF0ZWQgb24gdGhlIGZpcnN0
IGF0dGVtcHQgd2lsbCBzdGlsbCBiZSB0aGVyZSBvbiBzdWJzZXF1ZW50IGF0dGVtcHRzLsKgIEku
ZS4NCj4gdGhlIFREUCBNTVUgbWlnaHQgY3JlYXRlIFNQVEVzIHRoYXQgYXJlIHVsdGltYXRlbHkg
dW51c2VkLCBidXQgSSBkb24ndCB0aGluaw0KPiBpdCBjYW4gZXhoYXVzdCBhIGNhY2hlLg0KDQpG
dW5jdGlvbmFsbHkgd2Ugd29uJ3Qgc2VlIG11bHRpcGxlIGt2bV90ZHBfbW11X21hcCgpIGNhbGxz
IGR1cmluZw0Ka3ZtX3RkcF9tbXVfbWFwX3ByaXZhdGVfcGZuKCkgYmVjYXVzZSBvZiB0aGUgbG9j
a3MgYXMgd2UgZGlzY3Vzc2VkLiBCdXQuLi4gaWYgd2UNCmRpZCwgdGhlbiBJIHRoaW5rIHdlIHdv
dWxkIGhhdmUgdGhlIHNhbWUgcGF0dGVybiBvZiBmcmVlaW5nIGJ1dCBub3QgdG9wcGluZyB1cA0K
YmVmb3JlIHJldHJ5aW5nOg0KDQprdm1fdGRwX21tdV9tYXAoKToNCi4uLg0KCS8qDQoJICogVGhl
IFNQVEUgaXMgZWl0aGVyIG5vbi1wcmVzZW50IG9yIHBvaW50cyB0byBhIGh1Z2UgcGFnZSB0aGF0
DQoJICogbmVlZHMgdG8gYmUgc3BsaXQuDQoJICovDQoJc3AgPSB0ZHBfbW11X2FsbG9jX3NwKHZj
cHUpOw0KCXRkcF9tbXVfaW5pdF9jaGlsZF9zcChzcCwgJml0ZXIpOyA8LSBzaHJpbmsgbWlycm9y
DQoJaWYgKGlzX21pcnJvcl9zcChzcCkpDQoJCWt2bV9tbXVfYWxsb2NfZXh0ZXJuYWxfc3B0KHZj
cHUsIHNwKTsgPC0gc2hyaW5rIGV4dGVybmFsDQoNCglzcC0+bnhfaHVnZV9wYWdlX2Rpc2FsbG93
ZWQgPSBmYXVsdC0+aHVnZV9wYWdlX2Rpc2FsbG93ZWQ7DQoNCglpZiAoaXNfc2hhZG93X3ByZXNl
bnRfcHRlKGl0ZXIub2xkX3NwdGUpKSB7DQoJCS8qIERvbid0IHN1cHBvcnQgbGFyZ2UgcGFnZSBm
b3IgbWlycm9yZWQgcm9vdHMgKFREWCkgKi8NCgkJS1ZNX0JVR19PTihpc19taXJyb3Jfc3B0ZXAo
aXRlci5zcHRlcCksIHZjcHUtPmt2bSk7DQoJCXIgPSB0ZHBfbW11X3NwbGl0X2h1Z2VfcGFnZShr
dm0sICZpdGVyLCBzcCwgdHJ1ZSk7DQoJfSBlbHNlIHsNCgkJciA9IHRkcF9tbXVfbGlua19zcChr
dm0sICZpdGVyLCBzcCwgdHJ1ZSk7PC0gVERYDQplcnJvcihCVVNZLGV0YykNCgl9DQoNCgkvKg0K
CSAqIEZvcmNlIHRoZSBndWVzdCB0byByZXRyeSBpZiBpbnN0YWxsaW5nIGFuIHVwcGVyIGxldmVs
IFNQVEUNCgkgKiBmYWlsZWQsIGUuZy4gYmVjYXVzZSBhIGRpZmZlcmVudCB0YXNrIG1vZGlmaWVk
IHRoZSBTUFRFLg0KCSAqLw0KCWlmIChyKSB7DQoJCXRkcF9tbXVfZnJlZV91bnVzZWRfc3Aoc3Ap
OyA8LSBmcmVlX3BhZ2UoKSBleHRlcm5hbCBhbmQgbWlycm9yDQoJCWdvdG8gcmV0cnk7IDwtIHJl
dHVybiB0byBrdm1fdGRwX21tdV9tYXBfcHJpdmF0ZV9wZm4oKQ0KCX0NCi4uLg0KDQpXaXRob3V0
IHRoZSBhZGRpdGlvbmFsIHRvcCB1cCBpbiBrdm1fdGRwX21tdV9tYXBfcHJpdmF0ZV9wZm4oKSwg
dGhlIHJldHJ5DQp3b3VsZG4ndCBoYXZlIGVub3VnaCwgcmlnaHQ/IFRoZSAnc3AnIGdvZXMgYmFj
ayB0byB0aGUgY2FjaGUsIGJ1dCB0aGUNCmV4dGVybmFsX3B0IGRvZXNuJ3QuIEFjdHVhbGx5LCBo
bW0uLi4NCg0KQnV0IHRoYXQgaXMgd2h5IEkgdGhvdWdodDogTm8gZnVuY3Rpb25hbCBpc3N1ZSB3
aXRoIG9yIHdpdGhvdXQgRFBBTVQuIEFuZCB0aGUNCmJyaXR0bGVuZXNzIGlzIGV4aXN0aW5nLg0K
