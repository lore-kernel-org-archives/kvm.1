Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89430FC1B;
	Wed,  3 Jun 2026 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485517; cv=fail; b=C7EO98CyO7s/nGZLyGgO4IIhzh+aV2adSIIB89pdV1u2pKs03pv8v5oqRmiY9gzgoc5kn9zmOrrGU3F8buNCJe3nCNFyWOszhPc0M4R5HzEM7UvwqURquZXs8laUvvZS6YNe8Kc986vYNfSNuy7HQb94CsB4eCdwsbYzXE+Rwwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485517; c=relaxed/simple;
	bh=A3sHoGx/3w59y7YxVOknk4nGfT78fPr592iXuAlvSBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pShAKb6oL1u9xDXAnUMQHjkYMlbIAIAB3zPBJGnk9vLrUVr9Expa6K53DeQ8sAGuYCYQcHNg5O8BCdIvwvAjj3n+jVCvXuTSc2kRs/Wx8yhMs9KA00VT/XWU7RAXLFsqbGpFaSEkyxeVti1UuZXXj8cwSC9LA3zc3ZDbpiYM+xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEDJ5JhD; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEDJ5JhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780485515; x=1812021515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A3sHoGx/3w59y7YxVOknk4nGfT78fPr592iXuAlvSBo=;
  b=EEDJ5JhD+MB2E2CdS6I+MWIV1TISMDnkIBcF+CbdqNjdH8o9mleUnB3U
   gDyMWvT6RXcn74AhRVLM1NA1zT07HMVOJ/nUh4J653ISS5vnZjlIwmTiT
   04OKkeAb+dYNtiI44We/hLRPXC+XweGqlOnDdW8sFq4G6V6+LCzHWPkY5
   8ChGZhwnNPnanxFQ7NVDWf03MQo/BH5Mt/JFbtfrAQoD6YdLFZQfy5/Uo
   G2aPE/JNaGCwFvqQ0t1e0ols3la89VNV3vAfgHkY3bbPNa0cs0GnNS3pZ
   HDZpsOY36AEV2sxqZRQA04VhZ2Zf9NZFIKIMTpu2wxhBFuRZLv930KGnf
   w==;
X-CSE-ConnectionGUID: HQSjrCFYT4uSqtVPFCynZQ==
X-CSE-MsgGUID: dQi8eaB6QoGg7qgMn4W6Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="103950594"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="103950594"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:18:34 -0700
X-CSE-ConnectionGUID: EZKKIfmyS6SP0PknLEOVTw==
X-CSE-MsgGUID: xlaleQ7iRzS44dkR9Bj28g==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:18:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:18:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 04:18:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOUzyjFDAPi/vucN5RsEKgneI1kKMIYj7L2xpsPUgQRge/pxeAP3r7sqOYiOrFkDt53HO63kHqpREodPBGS3wQNhRPC6SGfkY5sco8XvriBetnW9fwyh8WLbEMBKZ4tDQL8tGEgDMQWlz5gfiiWOfOued61lxWqpqoD6vjB0Cwp/M7QPlBwzbmgVT8V9OHP1vh/aBjO/3BviSG4hpepNy3ZrHjiFLdJCeMKzTm/LoGyOM0lfAVHa+KErQCk34q/2xoS6EyERXGXJeir2NIbniTqR4fyO2Mpm2ZMmfNc+p6sYgCf2aBTZY+mPH9hFfU05XNTPXXK1PEpbyg1b6ty2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3sHoGx/3w59y7YxVOknk4nGfT78fPr592iXuAlvSBo=;
 b=cVUD7dQJFhZIEe/oYgomRgX13PlRCX0PyK0SrNObaP+AbTH32Qxj08W3FI1viDfvGJ9UgNLO5jbdLmxttLcKXWs3OMkObw2ySoDFdKsPnxZLqgRHKROa7FF/2e3SJqxMejeXkmGdGyFUs3vpcfe+HyNSEksSsQ6BLVUDaoQeE1oW9Dk49rEf6Uzvt4VkIu53NVRE0J74vJgqkqpzfc/PDVjRf9WM3C5unwYIe3e5y1e6kalmZmVOPeVWEp5+3/mGTKmMHTp00kvlKxRfQWyGAsg9nv3Ei2zEeFJQYKSta9ybS6xT6fu25NoZRpWF5W9qiem3qg6DbcJskL5+c/OHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:18:30 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:18:30 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 14/40] KVM: x86: Move async #PF helpers to x86.h (as
 inlines)
Thread-Topic: [PATCH v3 14/40] KVM: x86: Move async #PF helpers to x86.h (as
 inlines)
Thread-Index: AQHc77m+P4SQE+koO0CyJDQIAO4c5rYstfMA
Date: Wed, 3 Jun 2026 11:18:30 +0000
Message-ID: <5d9ae50e396ffcab7629079514052d794cb334b2.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-15-seanjc@google.com>
In-Reply-To: <20260529222223.870923-15-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB6722:EE_
x-ms-office365-filtering-correlation-id: 4deaa69f-4994-4176-0941-08dec161d79d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|18002099003|11063799006|4143699003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 9kVE//UFs0R1/OZOYbz4oG4gtrQN4HiNZ8nkDKPbFyWJMamLPszxfRTWBT1Ck1i2Fg7Lqww8uU83NVfFnlCBkzqPbEMec0cDTdfCnuH42IiyXuM7Ty35J8F5dOcSaxMOtLwrkHi4+fcptQrd24RouUcnObqJwz56GG4dWwizNe86DG36aclknto27f8BDLQXsnA0wRRg8z+Iaa2u+RwWSzmYOzbegJTgYl/75EEvZnLOajmQNizJIWKNTp91nz8JO3qmoeCmAlgQ+bjI3/s8lTvJ0Vaa6/oMFRMTXt3V862yZAwt3LCEhfQ9JYIEURdJVHcltBaNqYIhiqGbB1GuUlqX69NhhSGqZiwyeag+UhJT7zEGrCk38HoArRjudxKr1oFs1etqI3uyBKpBdHSdstoRP33I/RY9YL5DO6/UyKC7ugAiKKdCfuICqSmWNTKS1+cOblpX8QOt+mh8zMwtpd+No5O7obG3EZEK0mDcQrxF6ODMDqZ9BThCa4AqHLxKU4PWFsekNPzBftozK2uovvKwLREMh3k/UtrGbE/eihHPG3QT2Pye7MeWnod0egLang2dCKDcrq/GI0CltPLTBCuP5T6t1VI66nIoLrrPOv7EyfbkW2QM+tXVAYNGJYRMeEniRKBkKx+As9CSMWhZnMmzaJ2T/G6+uzqWg5v314hGHauCqeIOXkfai7tNAffwWy5+sFf9Jpp0zild8mTgysF0emT8wHbtLpVZjM5F4vcPx4r4e4LA3l14kAcKFASc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(18002099003)(11063799006)(4143699003)(22082099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVl5OEVmZDUwL1VnUXU2WVRBaGNsRkNnNTdPUFM0Y3JBcTVGYUNRM1N1N2Vy?=
 =?utf-8?B?SG1pN3Y1dHFpaFRUTUZzZ21ZSlowSkRjSlgvSTJxZjJUOFlxdkxoREx3S1Fr?=
 =?utf-8?B?WVJ0MzVWVzVHZi8yUEFsRjdWelNleTU4WlBMcUZTaVlXWTFEeGJ3LzhjRzhL?=
 =?utf-8?B?YUtYamRRczdnaXhUZzM0U2pudDloYXA2OW1YV3RxQ2oyZFU3YzFCdEl0V1pk?=
 =?utf-8?B?ZnU5NkZ6ajE3ZW5UYkI1VnJUVEtwUXZ1WW43aEREMnNuQzc0UFJQUzRsVjQx?=
 =?utf-8?B?RCtNbVJnWDFZODkyVUN5YzB5L2x4K29hMVNic3ZvK05QTDhsTDV6TTJwcGIz?=
 =?utf-8?B?dHBlVElEZ2RqQWVqcU8xbkdvQjFqdFhjZEwzNnZYejRINHBtODNuZ1MrMW1C?=
 =?utf-8?B?TTRYR3dmZHhVaEpVcHgrYTdZdGRQOVNndFdtWDNrcXFLUks1VXRNK3hnZW9H?=
 =?utf-8?B?S3Awbm16U25pbk12OTdlcFFKM0FXdUhZLzE3eTJrUU5sd2VkUlpLTk5peGRu?=
 =?utf-8?B?QjY4cHkzd2dUeXFvamQ2VjBQekRhMkxFZ2U5OHBhTm1aUlF5SUdHbXp4MFA5?=
 =?utf-8?B?em1vVndZb0pSS05rY29nY29PdkpKOVpWNVNDVWVrbHl4NCtNODgrL3ArY2dz?=
 =?utf-8?B?RjN5bGk1TzBXM0JhLythMEN3NWtteXh0VktZVU01QzdnVmRmcEVKL05zN1JO?=
 =?utf-8?B?L01LcUtCOG1KMFVEU0lEWjB3T2N0aDBGdFFYemdHL3JCcWF0M3M2YTdzVmo0?=
 =?utf-8?B?UlNiN3dHSEpOaFJjcTQ1dnROTUEzR2FvVitYekQ4SWNEZnVGMnlDU1pWNkFh?=
 =?utf-8?B?RksrL3EvNkpVUGZyWk5sbmhNdDRlcHFHOEpLcDYzeE8rUm9HeXVyeS9Rclpk?=
 =?utf-8?B?bEZZcFNOWWlpVkE2MmlCc2pUNm9ON2djaTRwREdjQmw5NGtSNTJzdG11U1JW?=
 =?utf-8?B?dE5OQjN2SFVtN3NnODRwU1hCY2pnbkV2VGZyeEZYQUszZGxyY2JTbWlYYW1V?=
 =?utf-8?B?UlpxYWVjL296SXRLdWFXTXhYeHlCYVNzWnVpcXV1ZS80dzBLWFZsMDB2WElt?=
 =?utf-8?B?WHVod09wMWpiWUF6MlFKSUgwUEF5OW9VWWliZStDdVk1YTZublVJMGNkRzVn?=
 =?utf-8?B?b01jTjVvV2p0djAvK3R2YUdEbFVZNUlVT0F0VU9ZKzB0Uk9pZ2RYSTZndXk2?=
 =?utf-8?B?Y2M1YmdFaGgzTkZnZWlaeXUzVEc0OXZ4bUlvZFUwZmJpQ05UZTVRMWdJMGJV?=
 =?utf-8?B?ZmwzVUxCRjFzdi9JSG1wcFZJeFNRcjREdHpzS0hUM3g0c0ZRWTR6Ym1ONWFI?=
 =?utf-8?B?SUhQR3FxWjd1Uk9ybHpaKzIyRWNXOHlBdEU3anhzRVlVYVFlcm5QdmZLb3lr?=
 =?utf-8?B?SmN0dXY1QVVsWVdabEtybGl3dlFya2VOeTROeWtBZU03UHA1S05UZVRSWjhH?=
 =?utf-8?B?aE0vOUJEMGRYS2RycE51MGNSeEpYREdCUk5ZRGhmaGdTZVBnUHFUY0NRVDZ5?=
 =?utf-8?B?U21YWW52c0VMZnNCNHlsRHNCRWRyM2tIaHVySXhKMFJZUjJ5K1ZGR3B6OHkz?=
 =?utf-8?B?TG1odWozdWd0RnRrd2t5c243VXFaRGxPKzZDSDFYVVc1KzgzVEV2aWMwOTFu?=
 =?utf-8?B?ZHcrWmdqN0ZuWnZ3ZklTbUpKZ3NUN05nTzVIMVZhMGhrcHU3UTkveWRxNWVV?=
 =?utf-8?B?SS9uQ1gxVDlubFVUWkxNbmFPdXVwbC9MTzFVaGloOUZCT0MveXc0U1VYTm5u?=
 =?utf-8?B?Z3RZUjNDZHVZRm9BeThYYzN4b1hjTFYxaDBvTWlZWnRkQUN3UGVRNEwxaGhL?=
 =?utf-8?B?K1hZNndUSTgxNzN5S0hpRklEZTNtZkpTL00zZElORTdjTE1ZSUl2czlNckNF?=
 =?utf-8?B?bTdCNGtMeU1Na2dWZ2dmS0FicW5iZXBqVW91cDZzbUxLY3JtcGUwUEsrRzdu?=
 =?utf-8?B?dldIOGdmMlZTNjVyek9rMm9IL1Rwalk5SVR4UVJkM3BCZVNPQm8rWnhKbjlJ?=
 =?utf-8?B?TGk4eVhsdVFPMS84R01KaDA2RGZtRkRSUWhLanB4WmZMYjhGYjBEdGRsSkk5?=
 =?utf-8?B?eDlibHhwY3RPbFpjRFRtVXBnb1NpMG50NVFnMThVamV5K2FoVUg3NW1qM2dj?=
 =?utf-8?B?KzhIZzJCaUliSDE5SFNtWnA1bE9hcjlreEdNTUJySy85VkMxdU5ST2xrSmZC?=
 =?utf-8?B?TzYwY2tJYjQ4QjJFenJOMTdQZEZpcUtnSGlnbkt4WVN1aGxVZnRhYk5uZk83?=
 =?utf-8?B?MTlLdnNFT3UwMVZORTVWV2dHQjFuUkEzdTMxa3dNaDRaWDJQVEdmdjV4Zm05?=
 =?utf-8?B?alN5Tkl4UHpKWDR2bVZkNkU4WmlEM1NpNFNRNXE2T0hYUy9WRWRyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCB4A5983DE20046B423573FCF85F2F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MDiT0S/Orj1z0q7V688jkI/sknl+/+P9Q6cMohssZ5XwGU2iObzezeuCs2ghHN8Ehx1kkQGOfr/m+HNkcw7N8hdRAFr6NHa2vz6OO5v1ztXRLnFWauBgxBw4AX7jfo232yrUrtu1vFJL3VwgkvlbA/0NYjAlz+XxvIjW9P3F4BXPPznNRnELgbZ3lFFcmpiwjWCxulUqe7GvGNH/c8HDE/s89YAkfnXAgOMBCxVEhL4jy7cmwMmdIjSQQWfg5IlFG8MkIaFkaDRrGICysYh5e2an1Bryey++rU0UDJNKUtgvsQiWrb+S9/b2kqZ3Bm1aBEEj5DOlXIBos1rx+AD/vA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deaa69f-4994-4176-0941-08dec161d79d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 11:18:30.6092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpGsT2I/zHWvtXbAVDkGfincUo5PILZ7yI0DmL8PAdG+obBzvp7AHVlUTGCXCoLpA2wk65m7EDf+1crc6n/ejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6722
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIGt2bV9wdl9hc3luY19wZl9lbmFibGVkKCkgYW5kIGt2bV9hc3luY19wZl9o
YXNoX3Jlc2V0KCkgdG8geDg2LmggaW4NCj4gYW50aWNpcGF0aW9uIG9mIGV4dHJhY3RpbmcgdGhl
IG1ham9yaXR5IG9mIHJlZ2lzdGVyIGFuZCBNU1Igc3BlY2lmaWMgY29kZQ0KPiBvdXQgb2YgeDg2
LmMuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0KUmV2
aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
