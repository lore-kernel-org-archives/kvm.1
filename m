Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702CE374E66;
	Mon, 27 Apr 2026 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334355; cv=fail; b=XDuQlnlQkdu3dcIcGA8hQrNHBKZKyTceg3ty4oYkRUI80gvI4UxDBuoUtYdsOBGb20W64LYhYBHr8ge9/3xWpecLBAotcxbKo3TcPucRGNtIeYhvYzh+bfegfHTZgufvmYrPrGcryZttxjnnVXxLBa6TzT7e2yG8xFqXnerwHyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334355; c=relaxed/simple;
	bh=LxHhPWFtpxTMHQ8mNrAKHFBd3hFTdbOTb7TavyrjHlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nwRu0rDZY3GxYlx/pwmy9xc5runbC5GydaAVr5H0yCZY6n52lLtNl5an+cag70fP4zgrl/BuTSkoEna/GJLtmRzYwd4DW+bXMEOXprwI5yuuYjZj84t5FozGa2BCbkt6j6McfNQwiiw/ZVL7UKQ5wceohVvLPM9/qdkvcJg75iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WP6c9I2M; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WP6c9I2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777334355; x=1808870355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LxHhPWFtpxTMHQ8mNrAKHFBd3hFTdbOTb7TavyrjHlo=;
  b=WP6c9I2MShu5E88onASWuLzfQ/mJMIUUzTMDCVQ3/kzAAo+baVOgrsl1
   6BV1rvrw1Zjy7t8fnNek9wUGS3cbuqgqu5c7GsPFgiXiOVKupWGRXq8cz
   JbLVdcAt8um6HlNYEBrgIxMqMKNQwIUou+PN530Ah+6ijIqDTaDvS+0hG
   YuMJcl09ahnR+Khi4+ZxCverywaSgA3srIcwEz+mWN1coolM67RhvW3wS
   DMNLtnQjaqoHdXzircKNyHBsb2vk2UF0Z/mX6fHMsUlXIkKVFQGV6fqNl
   niEymzmFDeVMPrkHVEbBy3HdL6oIE8Zq7CXSOW6C6oLt73U65lLlcaW8l
   g==;
X-CSE-ConnectionGUID: ICidaR1nRhG9YQYc0skxSw==
X-CSE-MsgGUID: jfCXJU8SSeiy74AVg8BI5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88546594"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="88546594"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 16:59:14 -0700
X-CSE-ConnectionGUID: vN08Up0hTvWb5kEGNJCV1Q==
X-CSE-MsgGUID: Bvm06RmZRmOu6WYTRKspeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="257319332"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 16:59:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 16:59:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 16:59:13 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 16:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI6Dp4PkZogU0MFEkL61zipDBoKCTKXgSO0cUO6YqPFzyiINXnVQauGYn7noj3sMOnBsZQ7AAFwC9h2MMBCp8kGmTxZ2spHvSXtsaeE0WPP2Uwwd0oPvcYwcoucT6cbHrCb6zulGbDcMwzu27z+4OIS8vVUWXvjw5LgeGPWaSE49rm9UE6GKX+jyrzKTrz+FomkG5nHNtUCfKoIav8cWqStXlVBaHh6HNzoJFQ7ktqbEOOFE70BRmxRHWGQsiqqLoNbdXk9SJUrZvQYiOExLBx3xPS22b8ffVLgT8EQ1g7eMnYAWEhuEDGlpPYvGRFiSAx51vJZhGpOkgDYZrOV9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxHhPWFtpxTMHQ8mNrAKHFBd3hFTdbOTb7TavyrjHlo=;
 b=J6JQ4HFz+Oqkbl0gqtT3pxnwopR4PlMA9zwpI2K4yo4o7xzkGWRkWaBvJVKomwaWa9cjf8mGReAm1jEyB94i5YKcTvmYzmKfix9ocrFvB+WlNHXGrsaSlPKt/xVQPw4ot2BbY3DRv8bcsvKin3A5MJCmiDq/a+aqI2cg/wa5BX+X0iWjTcluOWTfyqcbFEcwuE9daDfrAaXCkNH//TDQbjsIZSNteoWR2r03Dm7qafrMXnO+kgkNKh6xPYCgQbk//h8ysMMB67KIlOCm9sYePWGmb4z9mBowMoc7wv5egJ/E5JpqL7GT+gjLvP2tR1wvP7vLiWxn2DMhMP6+TDkAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB5075.namprd11.prod.outlook.com (2603:10b6:303:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Mon, 27 Apr
 2026 23:59:02 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 23:59:02 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Tng, Ackerley" <ackerleytng@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: selftests: Include linux version of mman.h
Thread-Topic: [PATCH] KVM: selftests: Include linux version of mman.h
Thread-Index: AQHc1oaILpjwTk/yw0+jOup648haVbXzkTuAgAACqoCAAAJCAIAAAG+A
Date: Mon, 27 Apr 2026 23:59:02 +0000
Message-ID: <d0aadd18a98177e999b14d8124844eec02cde533.camel@intel.com>
References: <20260427204313.50741-1-rick.p.edgecombe@intel.com>
	 <ae_zx9cRf8HQwvpX@google.com>
	 <34e88a990e667ee402238a13a63b224dea1bcfa0.camel@intel.com>
	 <ae_36Po7n6JDrkxU@google.com>
In-Reply-To: <ae_36Po7n6JDrkxU@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB5075:EE_
x-ms-office365-filtering-correlation-id: d09d3ddc-1536-4a57-e18e-08dea4b8f509
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 3CVbyxv3zdyynSOQCQTeEIR0oAavMECyOdAOX7CK0Gae7ugdQu4Ypeyi2aWIkFFIR2fgFZ91igybqB5NoIN/X1n8Y2Ry1jLucA0TulkE2BA+EMp415OUpzzoTwJlud6QhgKmQybl8gvXFb/hCylKY/fHVfI+RLxZaegjrNibQwV8zRJtFjQU26P3H3PhF6wD8m3n+pMNjvpWophI2syE156ZY/UL/uf0ips75p4cFhjLylfBpmG8fUN09aUKwcpJqpxKSp84LtJX7lZLg2oV4Hf14ODiyd+q8Ldk1O2bYLx35ml76NWDXzSs4f6mvTfqwDGWiK4MStwcLJry1Ywxx+ideSaH/ZyJCtfFsPBtpZ6vKF7AAHlruCdrZtIvZGfKFNwXk/2sFZjd8nvvaB4ofmVu176RmgXy5U+QS+5jrXl1+Uo4fJ+IIvBV20/aQz1t0mqhZ0BuTplZKhP6cTE2ZgNmJyrkZiAdW6YLk3Sk/BOGc0L/qP6G+cTFVMsXO3NLaX0B/kM86cjJDOcWQGOXTgahFnAQGii/6g9Yrw9BIAR2RKbWOPYQ1nSnmun6hDGJteoAukDFR5F9ykDa30q1AN6TWxNnkrVfzMEWgrrs1oCWBo+B3R0sla16dNhKdPuxISHUO6+hxdIfNwWAiqUvbCCtVJNA/LTwDBqgfbMPlSmJKMDWz0qHnkEDbVMv7VzLvzRbDp9a/DDp8c1PaFP902yCoiORwuisRI9p6VKWGOP1kQ9Sqz8m2fjphpYW2gaF/Yf66jX4XwKw6d3WqTmyyYc8ZbiRTM4PA2WLwX6e/4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTZJamhvVUdtRGJJK2dzNGpCWldvRUN6cjk0cWxzd25VdmVKZWJrMkI2RVFr?=
 =?utf-8?B?THZPZW1rUnBlcVVXVUUwUXFkcGp4dXpIdHQzL1IzbTBVVlZYaEEwWDFYb2Va?=
 =?utf-8?B?MkZEK1hvN3kyV3NpdXp2RFBGMzdmQ3RiMzJZRWpwYlZHSWpSSDFWU2czaWZH?=
 =?utf-8?B?RWhRejduTVlsY3FBdUk4S0pLK0JaTHVoN0ZYaC80eHBuRFBoN24yUVRhbkg4?=
 =?utf-8?B?cEpybTR0dVowRC9wbGhOMjFYU05GWVVXRytkUC91K2ZXRXAva1ZxSTlFRHRU?=
 =?utf-8?B?ZFpjbzRGb2w1cEl5cWNZUTBwemxUUjdubE0zOGhhMFFKb2ptdzZmclg3Zm5v?=
 =?utf-8?B?OHpuUlpaUlBuTVBvQlZXNzgvQ1RDbDI3NmlSQ0xhdWJWTlVYMFFqQmcrWTJn?=
 =?utf-8?B?S0dMVGgzUVpPcVlUaFpOS1l5NWVxS2VyMzZRUExRNmVkcW5Xc2N0bnR1Vit5?=
 =?utf-8?B?eENPMnA4am1uT2d5akJSc3BnUU9VbmJSM203MC92WERBZnB4YVUyS1dVdDhG?=
 =?utf-8?B?MC9lK3ViUkdIQnFXYlluM1BxeGxScml1cjRzZ2hpcEpGME1jK3laSlF1WW9y?=
 =?utf-8?B?L255bitxU2pYSTlYSTFTTnptOUltREd2d3lESld4b29nYXM4SkdHRnlnTFhu?=
 =?utf-8?B?NGl1S2pGNEo3NUZ6RHZKVzVBSTAyZ0FuVEpxdUZMK3EwYkg1T055bDJTajJP?=
 =?utf-8?B?OUJ1Uk41NGNBMFpwdnpKdmd6NkNNVUIzUlp2eVZQN2FRK2pXZkwwalVaWmZp?=
 =?utf-8?B?MEk3cVdkaFhyUFA4TkFUTWlvUjJWSnM2M3hkTGZ0YW04ckx0OHdvelZlRG1n?=
 =?utf-8?B?OE1pUWtvcFBYOERTcmRNYmhRZEV2R2lXQWNiaXNyRkFxOWN2SzBRa2daY3NY?=
 =?utf-8?B?MERTUkJyY2FaQU02WlNnbUNLY01YWTljR1Q5aXMrUHdSOXBPNkZTVU16V2RC?=
 =?utf-8?B?NDFoM1dJTmVPT3F2TFlUR3VkZEoyU0xob3d6em4wenBuVGQ1Szh3SEhSa2Jo?=
 =?utf-8?B?ZnhoODNPZk85R2hXTDZFUDdvZG1neFI2OGVhL0hsK3I1QmtVNWZORHJBUzcy?=
 =?utf-8?B?cGM5RmxGL1BRRmhsczZiZmx6VVo0L0xnNis3MThuSWNwRisvcldwSSt1WXFQ?=
 =?utf-8?B?VkFuZXJpbUVYQ0RHVDk3NWo0dVVVaWRXS1UrSzR0WG9SNWpQL1NOMUdaVEFN?=
 =?utf-8?B?ZndZbFNiWUdpNjB6eVk0RXYzZ0ZRcmZDZlo5MVplbjBrK0FVWTRFUUlzNmlB?=
 =?utf-8?B?ZUpmYk13ZlNnODcvQkNVSHZIcnQ1NXNiaDZwa29tK3NQNDZJb1A1Y3BUbllS?=
 =?utf-8?B?TnQwMnpSUWUyTUxKVTZabDNHK05jdUx1TGE0LzZ0SUtTcGkzWVd0NmdSdFZZ?=
 =?utf-8?B?a0VoWEFJeXZUZGV6YnFDZS8yWlpBOC8wS3pPazlDQ2kxbGtuZG85Vm04d0JW?=
 =?utf-8?B?SHlMbEg0ajdtRzZxRHB0VHptRnB3VS9ROXV5cG9yRkFZcE9UaWk3akk2Qmky?=
 =?utf-8?B?dXJYSk1HY1VLbVp1ZEoxRE9vT1dHc1ljWEFQQzRRbUJGZWxobE53MmtoMThD?=
 =?utf-8?B?RUJKYkJRUHJQZENiazc5UU12QXUxdjlpc1ZyNzdOSTVjUEJUNVZhbDFEcHE0?=
 =?utf-8?B?b1c0QzVxc2pMRnpPMkZCWDhmTjJzUG5IRCtXTFZxUC9heWpCVlZhUnpORkZ5?=
 =?utf-8?B?TUtzVHc5Q0lFd3BNZUtOUlJROGZZcXZQVXQzcklDK01nZkNpRnV0STNxL2pt?=
 =?utf-8?B?clFKbGZxMjhmbGJSRUo3RGVma0ZQcEI0T0xFM1pVaWlLQVdRQTZHSFRodXRq?=
 =?utf-8?B?RlYyZkFqdldoU1dXVUdNWklmcmM1c09KUFNLcSs5VklFdmk2eE82VHJ0ZjBh?=
 =?utf-8?B?MmVVTmVKMHdjRHZvd1JGVEJqd0tDdUJ3STJPNXZCUVJPTTVQUys4cThtVnl4?=
 =?utf-8?B?cEo3Wjc3SWNRY2o4SWJZMVZPMXZpY1RjdDN4ZzZyNXRadjZDYmtuQnMvbm1v?=
 =?utf-8?B?RmFmempWMVBIUFN1OTdERHltOHVITklyOEt4TVdsYVVWb2dBNmNBVGFJWnFL?=
 =?utf-8?B?d29scmhyQzlBTU5WS3hpclZoNjg3cG1mN0Vmem9uZVpNWEpQWGtKSFpZMzJL?=
 =?utf-8?B?aEo1ckI5VzNVcHFvK3ZIcldsTy9FTUpXT21XRmZCUjVwa0NmaU1scUtOZU5B?=
 =?utf-8?B?NFlZRW5FWXFsOC9Yb2tsV1FpOS9DVUlucldYMTR0S0NkdnFjVXRUMU9YYzZ2?=
 =?utf-8?B?cHFmZlRvZ1NUdGtkNXRsRmlYZlpDMFp3c1g1VEJFMHlvbXVFUzRybWRoNUo5?=
 =?utf-8?B?V3djYXM3enFJbkRPdWNTdU8wK2xNUlhpZXhKWGIwODd1bGplcXM0YnJwdzlv?=
 =?utf-8?Q?Fsy4gV6JgLORYmp4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C64782839B09244EAC22695332C621F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sg+m0NZYcJfDfAbnkFJLJrrTorZHEC71V/s/cue/dkPMvzjPUdCdXrscbibhWnqi88NUw0hNgW5zdPZDZayOWOqbJ/FBKxNKntb1p8ej7Z8VodPdttmWtayL6k1gcvLbnpJ9/9qWpV/1HKcEme+HPkXB2QFQUAO6VW7RjnirLPbz4vpYQzkS6/ynTTgPa6TBJ0iJ20W9E2bUm35kwl//pEYThBKisGmIhHZ/VWSClxI71ameWTPDNE3N/9Pn/4PCF7jG73HQaMTZqN5wuRf+NUVOpKI0w4qYwlQ4E6VrPv2q8/k84N1kJzGWEFsQocRhZRiclqi7ab3zfFJJdCgAOw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09d3ddc-1536-4a57-e18e-08dea4b8f509
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 23:59:02.5173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSOE4Jt1C0eYQYCiSlG/Cx+iXsURcCIHdsol2eXF/4+HLGZpPRO9lY3jECazBF0zUDQlFlt0HRGJloG1+HRdNFNL7QKV70uu22lUOKl0d/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5075
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA0LTI3IGF0IDE2OjU3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IERvIHlvdSB3YW50IG1lIHRvIHR1cm4gaXQgaW50byBhIHBhdGNoPw0KPiANCj4g
SSBjYW4ganVzdCBzZW5kIGl0IGFzIGEgcGF0Y2g/wqAgSXQnbGwgcHJvYmFibHkgYmUgbW9yZSB3
b3JrIGZvciB5b3UgZ2V0IGl0DQo+IGFwcGxpZWQuDQoNCldvcmtzIGZvciBtZSENCg==
