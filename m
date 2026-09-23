Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC46374731;
	Wed, 23 Sep 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181112; cv=fail; b=A+N6Lg6Pw3GG9ZhXtk+LSwxDs8AP+4fE6MyeONcKN7OE/dQfWWkZC3UHioppDwviRAnv9P2ydzM3VWMkrmGlS5/ArRiJ7vO8mZ0EQn+M+0ljSIznOnqX7+tlEhQPhMWPMhmoszWp5HxpsggGf2ZGMFV3jbwPEjQRf7nkNguKPF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181112; c=relaxed/simple;
	bh=+1tIxP1gJkxjGLPMdBXEPTTWRe+PKMSzWP1GLYNLbW0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KJzTHctTEtD5LbdBzW3G44U7AQ/dlqJV7p4sqftlShmZyQxdlFVas7rD8oYiJUK5VA7Qh0D43RKryx2H3BMeB5Pqqr7rmxTN2hoLnO5I9dAgimDU7T6lwivdHIvjYkB/GeooA6q/wqCAbM1ARdhmzs/wcrt8WL/hQh7GkfEUx2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxzE2xk2; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxzE2xk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790181111; x=1821717111;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=+1tIxP1gJkxjGLPMdBXEPTTWRe+PKMSzWP1GLYNLbW0=;
  b=UxzE2xk25H0gyRNtTYSnIsSQzISdKTIykML3E2p3ge/SADbGjeQGSDuB
   JRHEmiNGrTip+CV48R0yz+iF2sIBRrAEZoLADwxYWwwrAqkfwSiC3Cq3O
   eIKWJIBVRF30pBQUjfQgGDRcOmvJ/oIgj3vgeCF3CFhxLX3sXsbSRoPvf
   I3D9tdxBOrgxVVaQjd+YbwopSbFW3/QqMPJr18kOO5SIB4qU83ojMBVqB
   5O6X5gBIlLuWna8wBqgVUX1xiNHQVkMbQKKTI+wMlBBuieLuQhK9F0fZj
   34Q+f6YsiaSYq2cpbnmnk2lTP8EkE3H+Unmle98mUllslprjIM+q00P0R
   g==;
X-CSE-ConnectionGUID: c3q8L1iTR6OXdYyi+aRCAw==
X-CSE-MsgGUID: ZvxZn01YTnWcfD25j1BqSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101483521"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="101483521"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:31:50 -0700
X-CSE-ConnectionGUID: Wi1I9E04TuGYD3ME3XM3xA==
X-CSE-MsgGUID: nULeLvXsQj6cAi76DYkUJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="281746197"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:31:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:31:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 09:31:50 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:31:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnfPkjUd2zIQ4s3N9zkIOmp7qikdhsNWNqjTvD6cxuZocT3SNsJOjZX3PtyP4yFCChSPNP+arDgVBFQ9JwjxUbFS1ruJ6Ri9Tae7OoPXS+GPZuCnC+nZ6Jro7G8p89dbE0vrgXstYlcN7h9yKnvq09OdqWoW+XBpPT4I2PzM9ggSxCyOYPJuJeA4EjP68xBL5+GC4tRjbzn+g+2X5NAa6DjyxIAscwcN71RJB5JiQh4grK8LPJsLtYt+kMuIe3CrNnFaA1KKCuJY3RwAHvO65S1KpYLWAsOJ13iwEWJzVhA6tZy7Hd6P6xIqsEaeiBYRrzb9/bL6FwfbX3tP7YWU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1tIxP1gJkxjGLPMdBXEPTTWRe+PKMSzWP1GLYNLbW0=;
 b=Zt4EUt5U0NasQnHOuTiGfmNZQ1NjWYYCBn83UN8l9aEI0EEcvq8N+iMboXvp2xf3x2dPUMAiij6aoOv/GVeivqWh1W0MDnGORBdYodUYFT0gyML3eoiqlMyaXj/cC9K7sVUz7IyjdCXFGCmX64mWwCvVvm7Ex3g4hgEZ5UdqQ/zfXSthaqt2bnu3wep7Zq6GMBl2flCqpY1EOumM3ZYnA6yGASMzSNuROBKg/TdAfnn8MM6whH7RCcfb7lcSwZmMz2Tl/0gD90hkyOzcTXEsYeMTP+xJ0Ql2H93ZVQIBzvr9Fwx4ppwSpIE0zGfr8HvVICfXKKDc3uNxoWE4M8AtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS4PR11MB856555.namprd11.prod.outlook.com (2603:10b6:8:4bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 16:31:47 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:31:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "Wu, Binbin" <binbin.wu@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Thread-Topic: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Thread-Index: AQHdStRWGuydSOFmwk+y3PD7PUHSErbbbgQAgADuV4A=
Date: Wed, 23 Sep 2026 16:31:46 +0000
Message-ID: <72e0478c33976f56c79dc6ca9c9823373a868583.camel@intel.com>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
	 <20260922205215.870563-3-rick.p.edgecombe@intel.com>
	 <3c6e968e-f625-4ea7-b815-1c9be7d2bef3@intel.com>
In-Reply-To: <3c6e968e-f625-4ea7-b815-1c9be7d2bef3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS4PR11MB856555:EE_
x-ms-office365-filtering-correlation-id: 4b4d4ae5-781f-46a3-a2ed-08df19902912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|921020|11063799006|56012099006|10067099003|38070700021|4143699003;
x-microsoft-antispam-message-info: MjVYm4jm35qesvfMB8ZxhMLwzC8IyzfJvQDpXNEYS/7JE1kycpsj78Z5BlB4XEihn47eVZngQ+Nr4rKDLSkH/9e729AFJuQkrnnz2aNvsCvcXV6slxmfGF++koGWUj1B/wOjYpY/XPXXfnkEQOnpm35f4oZKw8f2cSqn1atcIF/vHRt600p45EE1iqsJRDu2AQUJWwlhxQF2AVn7R0cXyDWcpHVOu0s7HGsD6ppUfVjuBpTZWbH2S+NYhqiEjOwfbXKTWpYc0asKRagPeoNhh85svkWKlz0latoMIooWE1XtbP/ThLID6sYPqIEi7MvIjsPiVJrfSfN4QrM5AVHLuPbhlKiH6cFk6TzoXWhdS92mGSOvJf9gp7q4nvdh1FktW4YLDWPtIed8Tx4VJJxtJKkhPN4yUw/gWkF+ET0qZpCuIZaBmTppsIkunB9nYHKk0CGz/ke4NzrhEfrUdjPmgoqBbx9kVrRxCWVljDO9OcX/hNlskaIt5MlOHhggUvXuy0kcKoIoVukR78GanyYAIKtG5iPgVAZtby0SaOoffXt70/5Em7zhwhirGS1/mUzozEWwBc07HO4YG7BwHgBKSkuSH/JdjcoASiLVP8j1PklBreO7pFLNBLQ4bOxJhtnBbsf4u1PVH/tSaPjlfck/YtoOXG2BN687MFPZbvH+Gntig08mPxM32LokjgsfmN1sB/hrP7UCYzLGz8QcgFbrsI/B8KOTA7PIuj/2jOCFposwX5hUwJZmnDJnTSzfYMLd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(10067099003)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHpuV1NvcU5BaUpIR0NsTkFnUm5kMGdGdkh3OUVXWDdDZnpZTGRIK1JOOTVp?=
 =?utf-8?B?NXVLMXczb3pxSStraHF4cm14dGtDQ2FoS0FXTU5ocXA3NUpSa0NYOU9Nem5I?=
 =?utf-8?B?VGRaSks2ZGQ5ZkhrRTYxWFV3R0NkWGJoRnB3eEIybzlyRkF6T2hDVzllelk5?=
 =?utf-8?B?amRadWk2bE9NVUN6SHduZlkvWU4rdmV1VmVSYlhzRkFyaDFLM1Zwd00vVU9K?=
 =?utf-8?B?T0ZiTXdKRlhHYWxndDRIM1Juc090anpEaVFzUm1pUUV3ODUzRjFSeWRoanhq?=
 =?utf-8?B?Tm9QTWJuNERGYjkxSTg2ZHVRVGQxUFlTZ29PQUlZWVJRUzVEUm5rZnB0WEhj?=
 =?utf-8?B?QWJXSHhzWWJNODRBSHJPNW05dy9BZWQ3eVFScDJCblQ0dFU2T1V5ak92MERP?=
 =?utf-8?B?ZmE2KzdvOElxQ3dubjE0RHVwQ0hFNE5nZmJiV3M0UVdLYTJhK012L0ZUUTdE?=
 =?utf-8?B?eG5wOFhldWtDejNIcW92Wm52SElNWTFueGQzcDdMbHVBZzhldEorZHZHTHl6?=
 =?utf-8?B?U2g5aHVxSFA3a2hLOXRrYncrWEUrZWdkNWpQT3pzcFBidGd3K1pud2NyTW5J?=
 =?utf-8?B?R0I1MTNuNWxOMHZ0eTBEWXlCbGpYWmpPSnEyeEVJNjhISm1oaFV6SitQZFI4?=
 =?utf-8?B?Q3lyTXBHV2VEUnZHdGZ6dXI4Q1V0UGM1SDc4TEpVb3BMdmFINERSbEVJdnZF?=
 =?utf-8?B?WDA1dkw5ejlIWVBxYUJvVWEwLzVDeDJrL2E0cFpXWFhoS2c0Q1B5cnJGTUhN?=
 =?utf-8?B?OVdJSmVoTVVrQ2pTZmNZM2N6STE4SlBJUnRVMUp6bGpDY1BJdnNPN3ZrVjFH?=
 =?utf-8?B?WUxsNjk5WXk3QlRWUm5vMFVSbUd3dWFHbXFQMWRDTDg1dFV3WmdhWXpGb1Mz?=
 =?utf-8?B?eHE5c1lDdE5aZWhuVktvc2I1c3djeTFqL0Z4c0hHVnpEdndBM1ZlZ25YSHhy?=
 =?utf-8?B?ZDJrb25sQ1RVT3lzN3JaVTMwUHpBNmxsUmI5RnNOaGpiOFpNK0Q0OENSV0ls?=
 =?utf-8?B?WVhDaHNPaTJyMGZGTzc2bStkaEZHejlXcmtmcGhDMURWZ0ppZmN0ZFVWN1Fu?=
 =?utf-8?B?SXlibUtNdStacFEzOEIvNitkWU9JQnA2RDJzVUNrcmZGT2p1dXR1T3hZcWRZ?=
 =?utf-8?B?elc4TXdscVdVK0UvczdoNlNsYUlERXVIbi94ZDNQSUt6OHBVZ01oMkVaSnpZ?=
 =?utf-8?B?ajArcmp1VjM4d2JVbUhXclhtd0NzSEc4aGVsWFNWY3luSVJyYkJsY2t5dkNB?=
 =?utf-8?B?ejFIdFk5MWdFNEU4cmVxUklGOWhGY0RLSDQ4NlBTemxkRndSZU1DaTRIWVVY?=
 =?utf-8?B?WlpNc280cTJldXVtRzZxbmlEQi9Fbmgrd1NwQ09HU1NZa0xCaEJnbGtLWjYw?=
 =?utf-8?B?TG1Zd2tab0k1bEQxa0tzb0d1ekxKcWhnb01vUGhkMSt5eHdKRXdXWE9ZeHFo?=
 =?utf-8?B?c3B1cVA2ZklQQjN6V015RUZOK3JpdTlVV01DUDJ5Snh4Z3Z3aXhHelJidGJh?=
 =?utf-8?B?TkZ5bkFyc1lWbTNZano5TVozWHZIVTlJWGFBYzhHd1BreFQvcksrWmNZT08v?=
 =?utf-8?B?eVRvaUZwd2VOR2pCVEtuTC9FMlo1cEJFekU4bjV3bUNBTXh5eXlBTy9BZnha?=
 =?utf-8?B?SmtGaHZZb0tkRktGa0NTQXFkZmZEdUJMRkZNVzd2ZkRlZy9zSXpaNDRMOXNS?=
 =?utf-8?B?YmFKdEpHVndxajgrSUp0cjlpa0ltdkQxNzdHVTVBWGwxa2IyZ3hHVWt1Y0E3?=
 =?utf-8?B?RjJuSW5QblZpSHBNcTF0OUx2dE9naGQrMWNpOEtkZDhoVlRscFFHbTFaZWty?=
 =?utf-8?B?djQyUkszczFBSjRZbkRUa1lycU4xNm9wdjRxU2NMZjd2K1pLN1hteFdMRGJB?=
 =?utf-8?B?U3pWRkZ0V3hkdkR0RHhmTmV1UmJKZFhqcHdWRjJqbHUremRnN3FGVEFsQVEw?=
 =?utf-8?B?SXRNU3lvMXpvZGhWdUJpVUFtLzVlS1FsWHBhZWpPMEtwOUVUbnp5KzJXZ01J?=
 =?utf-8?B?WUwvdjcvVWJTa0RHTWtpTWhxSzVrTGNxK2FHOFgydzhoa1dWS2NaZ1c1MVdD?=
 =?utf-8?B?TFFaUEJZdlUrbS9Xb0Nvb1A0OGNGa2NrRHhpVHdhN0lDNFlKekFCSndtcm5U?=
 =?utf-8?B?ZFNQYWRvYlgyTEFJaGlBT3p2WVFFZ2ZEK3ZaVzI0cjZPMHFnZjVsOEpJcytE?=
 =?utf-8?B?RFo0RmdwSmIwbTkxSnl2ZzRFdStYdkxGOXNJNXhwVFdpNDVzSFlXTk9ubEJn?=
 =?utf-8?B?d1lYTmVjZmMxdklPcVM4ZHNGMUZmYkEzVWo3bHNyMm10Rk1oajV3WkdiWCtQ?=
 =?utf-8?B?ZmtrY3RDTlVpTnoySGN0c0ZhczVmNEFpSVRPVzB6eC9MK0RjVUVIR3Iya2Zn?=
 =?utf-8?Q?iU8ZIG1+gOuFeeEE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3F6855A293ABF40906BA94ACBCB4E69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Cg18/viGSImmJlO2sWfs46MXWS2IJgFyWFXVeqMx2y7oYmV4XN9pMuU2Xawx8W+ZIfrIsNcY/JyRnVIjX3yVsx4ci5BgKUJBJeXeU1Jog74rNLopVrpzYrdvmXAUI4hK7364awe4sPLaXrSTKPrKeFBrkgBepuAeAIPEpJcDKY278tMt3JQ4BGgvkZyiIa6+kiiOCQ7p6g0RelsnzU4TYwA52a41dOZj7tGpY2DwuQUW5hTy9HmXwejqHgjRbxEfd3/GqyaltpdKQQ5JVT1GJf4+CKIPG8IhBt/UbwZVWCGE+0n1Q2D34aicUmTD98N3sYGxR7SECUQiEy/FCJnNFQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4d4ae5-781f-46a3-a2ed-08df19902912
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 16:31:46.4903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3ZH3SK53iVT8Ykt4DvDFr3dMHVzcPHfNRtbTYrRDtuEbvuuALCiAK+hUCaiC+6heDeCNggz1LfXnpZ9o7rS50Q92HBZ1/gVER7BzYAkxFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB856555
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDEwOjE4ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBX
aGF0IGFib3V0IFRESC5QSFlNRU0uQ0FDSEUuV0I/IENhbiBpdCBiZSBkcm9wcGVkIGFzIHdlbGw/
DQoNCkFwcGFyZW50bHkgbm90LiBJJ20gbm90IHN1cmUgd2UgY2FuJ3QgcHVzaCBoYXJkZXIgb24g
aXQgdG8gZHJvcCB0aGF0IHRoYXQgdG9vLA0KYnV0IGl0IGhhZCBhIHNsaWdodGx5IGRpZmZlcmVu
dCByZWFzb24gZm9yIGV4aXN0aW5nIGFwcGFyZW50bHkuIFRoZXJlIGlzIGENCmRpZmZlcmVudCBm
bGFnIGZvciBpdCAiU0tJUF9QSFlNRU1fQ0FDSEVfV0IiIHdoaWNoIHdlIGRvbid0IGNoZWNrLg0K
DQpTaW5jZSBpdCBpc24ndCBuZWVkZWQgZm9yIGh1Z2UgcGFnZSBjb2RlIHJlZHVjdGlvbiwgSSB0
aGluayBpdCdzIG5vdCBhDQpwcmlvcml0eS7CoA0KDQpEbyB5b3UgdGhpbmsgaXQgaXMgd29ydGgg
bWVudGlvbmluZyBoZXJlPyBTaW5jZSBpdCBoYXMgYSBzZXBhcmF0ZSBlbnVtZXJhdGlvbiwgSQ0K
dGhvdWdodCBpdCB3YXMgc2VwYXJhdGUgZW5vdWdoIHRvIGtlZXAgdGhlIGxvZyBzaW1wbGVyLiBL
ZWVwaW5nIGl0IGRvd24gdG8gd2hhdA0KaXMgbmVlZCB0byB1bmRlcnN0YW5kIGFuZCBub3QgbW9y
ZS4NCg==
