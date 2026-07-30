Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E793939B9;
	Thu, 30 Jul 2026 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436928; cv=fail; b=AWpTwcfqG1wjM6AdA5UAgV2GRlJ9Yj+bYyj9fQRKJL/1EW9X/npJWVYpC15SDQC60qf1YTf8+La/ohDmZRFJlQmWVkJL5drhszrCNFzCHUp+z7NPHpzv1kiQm+aeO6RiA6mijLjFPRQ7CmWRKP3KwW/EQV3pPcclkICt4wjqPNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436928; c=relaxed/simple;
	bh=KrR3rmzPF3cWsiFKGnm5RBhc5fu30vfuiizPEaH4F6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OreMT8y+w76hfRa3hXARpYVSXvXOguabYgnTTDr6fKkcwBcMF1aPvTzQaIu8wqHIh6r6Zs8u4DCROliNWkhkJGZSRSVnLouPdp2jffCeTvpTAGALADRsJ6PiLKT6EnIV8D+J2/rEUd16h8HL1uBp83L/hEoJbQt0BmgONbaMAcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nwa8Oi+2; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nwa8Oi+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785436924; x=1816972924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KrR3rmzPF3cWsiFKGnm5RBhc5fu30vfuiizPEaH4F6Q=;
  b=Nwa8Oi+2cE4ich8WCkU+FUzAxbr2ieKhEGVgZ/t9nvAEodzZs9xaCWFv
   A7LvTjvvuMNVX/SPmqVdzv0OY/L/UhA5yrwrf/c/+RpN/yf9r/iDB64VE
   TIoAEvEj+sZ+YWqAT85VPOXkorA50nsI2Q5eHIzt0x5bs70HSx7J4b+IF
   dOIkO8HFzG4fq9mO7v/TAIJJME5rG8N0ioLqoY/9lQbxdCpBdc8uPyWc6
   JkY914B603bMCfX8+N7QIkpFr6QZEaN8WECWfNEmNHZJqCeevQnDac0jN
   nlBPClzhf2VpaP9BjJN3J5wiLYC7vDN/rToVjAikg2D6by6HxH5V9HIFw
   w==;
X-CSE-ConnectionGUID: 9DgC4eSIS9OXfMpJ3CXTCw==
X-CSE-MsgGUID: 9pRGRVBgSEauhODDkAAiSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89745142"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89745142"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 11:42:00 -0700
X-CSE-ConnectionGUID: csTnTzKVRqic3BwF6e5QtA==
X-CSE-MsgGUID: j8azCrnoTfWuRwvzT58ssA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="284971346"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 11:42:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 11:41:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 11:41:59 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 11:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHY7kisn6Rt5jh0WU67JW8AxCteDxxhddlbhci3PPr8Ne2KzooDA7C/hi5DbC6p08tsIgzg7v9ixg/ejso/sYsKOdCevLv7mf9NO0MBzqwUoIpduCw2N0TdpcMKgybZkzpmrailcYsqHF2zm02iSLGWDxHqckEn3QIbt4/Vtu/La9Viqhp6lf8lYksobd8l6QpxF6BDXz3jrUHKOl6kE/dpWxoD431ojwmwxz2bJBOIMscH4hEpTcGIT90+WRko8irIiPflrtR/XuBLhZjXgg+Zon4cuX6cVPMfybZ6Ba0hynORRb/B7/i9SoyzazJKmPsDsZGWp656OXuQeZ/d5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrR3rmzPF3cWsiFKGnm5RBhc5fu30vfuiizPEaH4F6Q=;
 b=WhShtUVER98CMj31K2UEfV8jru6RhFwgS9Vs7kiyeHPFxy/cD3kUwPrBAm6aVAassRnJ8Pn/Waelaw97NDuwAsCPYTTxgpRLsBwUwURM0NyJB3RIl3U4eGhuTC6ikI+BajMPWQ6HdOH7ksmytExVwplASo9CD/BDleyZ/LHECSJs0jaur6JTRU1gV6hAommz5TXe3uP3wmFE+xVzTqeWZibokhXzLB+V0u40g/O2HGEvRAr2hDWArkvz/qUEAELzkTPRaAzRZqhPHUAqj0c3pUKx8tlYR3KUlusOckq6eFtSHdth945ZwS1mQ0QJwPeqosB00XJDbzyufDiDi9Y6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LVUPR11MB9591.namprd11.prod.outlook.com (2603:10b6:408:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:41:56 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 18:41:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Gao,
 Chao" <chao.gao@intel.com>, "djbw@kernel.org" <djbw@kernel.org>, "Maloor,
 Kishen" <kishen.maloor@intel.com>, "Fang, Peter" <peter.fang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Topic: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Index: AQHc/v3/H6yI1AvBKUSJMqGdHr9fi7ZVQB8AgCywzgCABDkGAIAAUVAAgAAs6wA=
Date: Thu, 30 Jul 2026 18:41:55 +0000
Message-ID: <1f99ce03929f3272319d0f81aecaa93e86022aae.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-7-yilun.xu@linux.intel.com>
	 <akIo+E5hfQL7C30E@intel.com>
	 <603e7857a2036b0fef86dcf8ad0ab97e0232188c.camel@intel.com>
	 <amsxCvZUpNwxeDK4@yilunxu-OptiPlex-7050>
	 <amt1QNCBQas95XYB@yilunxu-OptiPlex-7050>
In-Reply-To: <amt1QNCBQas95XYB@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LVUPR11MB9591:EE_
x-ms-office365-filtering-correlation-id: 2b87f6b4-f05a-4f66-b6fe-08deee6a3b01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|4143699003|5023799004|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 9xm4iw++Y1QbYaGhE6ciyQ7xIFtD/4EPvfB4gKCa18tToRJeh5BGOYXI8+2Y10ZFn5g41fuoN3HaA7lucKf8ixp4R3x7o3bwhjPKRulalN7wJ3OdC4JIUtTBQn3aZEliehnGBmSAjs4aYLDMuaxVo9UZ+7j2d9TKJAllA+jsRrlv+ZTVm3apYmmi6+LBFuSzf59pP4p0yx3MICGqAbpGykoalooyO7Kg6v32PyyrwDwB598htuplRgE+dNCy6Q9MiactbZu3fPflKHNr5x9eYplvSISMm98nnrloLfZe6s9O/yqpt1ie7RcrfGRAF1FGV64K/OOW5L4ZgbLn0egeCDOcNszH3zGt7bYDe3xgwoEz1CShV4w9zoPoH916xkRahMhVtFGPdU150Iwj7zMA5eLV/WCMWvRJIsebSiHy4E0s/MlZ2qP5YQbxbxjf4CrXwkHpJA7HPyk1tk/SKuEGKwbKhnX9RV0pLsB7sDdghf+MAcjuYJ04ejGp1WgU3CHOwtCCrtzbMoRn6tq/DIihcwSEiWiQShO5f4o/9YeVLgrCRCDZD9XPS79nF49L+kWLnTva+vyYeOVeVUux6vkQUcJvtPIWfopeQC92gDtVOsergL3vxQnYFrEuXu8W8Imoo0qfdinjBxjI2peCOFlLuyp+PrjoAI8fv0kIjQt5VWbhAnD+NvSzDGtaGyrNTVN418a/6g01Ale7FSXGpTZuUEz4w/SNtTQw3ICjAtE5CXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vzk0bzk5WDRudXV1alRWTUsvMm1YTm9nc1hWYjNKa1U5TGZ1VlBVVHg0VWdz?=
 =?utf-8?B?ZW5YRUwwL294SUFSSnpsWWMveC9zVmJUUGY5bmQvY3FLMDc4STNYSDlHUEdr?=
 =?utf-8?B?a3hJRUxZNE81cGVMcEZGaWhoeUl4OGJkQjQwcXVSVUZkYXVSTmpDaUEraHoy?=
 =?utf-8?B?VERkdHhyWkdhSjA1eER1RjAxblhvR2lHL2NZTWwvU2dzbjEvREc5RldhNGQy?=
 =?utf-8?B?MmliclVEWWV2aVg1cjFjNlFKSnVwbC9qZzM5RW9heElJbDlUT2VYak5Nang2?=
 =?utf-8?B?cE9PMGdvUWp0Tm4rdkw5Z1FCZnVER1FIclAzdW1kMEhnbnk2emZIZGcxRGZ2?=
 =?utf-8?B?c0prRVp0eDgzdUFLWGV1eFlJWnI0d0cxdmVRTWlGQ1hXUGZCaiszODM4TSs4?=
 =?utf-8?B?MTdMM0c3aWcxZWVJQi9LamU1RHFoUFlHQ3Vrd3ViR3c1djZwakhwTVJKZEJQ?=
 =?utf-8?B?ZHZJU0VQZjdnbnhkem52U1BWR0llcFBlK1pPM05VWFY2N3k1dlZ3YktUZyta?=
 =?utf-8?B?ZU82d3pFemJzcU8wbXJybmdTQTI2N1ovOUM3VzJIcW1lUi9Lb3ptb3JZU2tp?=
 =?utf-8?B?Yjl5dFVpd016ZHBsZTBDcXo3ZWhxUkpJMHpXSXNsdWRNZFZOcUhSbzBHdjNx?=
 =?utf-8?B?UmIzWVJ2OGRuY3lwSWNNOVRiWDc5NVdxRUVBSUpPYzlsUFN2S21SZlhYTWtx?=
 =?utf-8?B?a0FCdGtDM21UY1k5bjVMTUpYWGVUWEpPK3lFVFI0eEVWWmt4bXpJM1ZwUlg2?=
 =?utf-8?B?VjM1aTdQby9YbjhubVdhcDZENnpkbHRlS0R6OFArOVN3TW83VjJRNXRzQ1I5?=
 =?utf-8?B?NUNUVzJVTXFodlVNSi8vdlFHVGw1WCtHY29wcmhyRWJsL1RFL1JtekVLUDIx?=
 =?utf-8?B?OHRuSnNORUxPTTVETzhMbENlYmUvQTJiVllDRS9ENEVEZ0MrTERSdVAySzVH?=
 =?utf-8?B?aHJxeEVXVjRUNVdQZkVIWFZsNllnSGN2d3l5bldrVW15TVpDeWVWclRIVWlr?=
 =?utf-8?B?N2NTMy9PUkswb1czU2ZrWmF3N3I1TUlJdDhra2l5dXFRQWRxbGtrUjRtMHNo?=
 =?utf-8?B?NlNsRjBheVc5aWliQ3FUU1VlTzhIZzNUTTJEVGNQWHdMQW5xZCtXYW9rSW85?=
 =?utf-8?B?WGFNOG81Vmt4bElwNHJLbHZFWlNpZXFkK2hVeWxmL2g1QmFKYnJLYTN6cFQ5?=
 =?utf-8?B?NzVGdFdyYWJWYlF0Smx1b0t2K1c0V2RkdDRVQkZUandzekR6NGlRd0VjVU01?=
 =?utf-8?B?akNkUmE5MFc2dmNTVFlZM0g2c3locHJZQyt0a2F1L05ESC9nbFhKWEdPcUl1?=
 =?utf-8?B?U3VpblIxR0w0Vll2Q3BpWTZQdkcraVdRMEIxMmwrQjhvYytLTnpwUzJFZVhp?=
 =?utf-8?B?SDJvZ3ZTbC8wbHdITVp5N1UrVGpKUUxlSXVRQ09ueVlnN2FsUnRMalE0aXZ0?=
 =?utf-8?B?VVZUSTc5Qko1Y0ZldC9hNWpGR2tLL09oUFlsNTFqWjZrTlJuT0RUMTd4V2Na?=
 =?utf-8?B?R1VwamxjMVRzOXVrMHFHdm9KMktIVDZqSkF1dTUvYXRXMEk2eEJ0ZEhTTDJZ?=
 =?utf-8?B?VE1pZTJ4WGJOTG5qWHdTTWxVa2twSVliWklUcDkrcWhEQlUydTYvOFg5T0R4?=
 =?utf-8?B?a3JrSWliQnZXR3NMM21UY0xOVnVvOWRCejArYmJnMGQ4OXJqKzRPcDlpWFM4?=
 =?utf-8?B?Y3NkVHVuMDNhRmt1cXVHZmdjY1pzN0hqeFgrZEw3U3FpNnV0TXhTZ0NscW5Y?=
 =?utf-8?B?bHNabmdwdWk2cW5lcGJMY1cwSmxHaFVvQmdZOHhjSFZpWHlQVE1KVUF4UGVu?=
 =?utf-8?B?STd4ak1FdUNCN3MxZWdueWhVSFA4VzV6b2tIbDk1TW1aTEsrZjcrckhOOHVi?=
 =?utf-8?B?MmdiSFFFOWRHQ24xcndYSkhkVE9BaHRoQS9Dbnh0OVJoYnVXT283bDFxQmlG?=
 =?utf-8?B?Nm9KOWhiSDY2Qi9JMFUvQ0JFWEF1dG5HS09uci9mN2l5VVFFWWZyb0JySEF3?=
 =?utf-8?B?eHVSSXFLQ2hlZ08rQ0VXTkJxYjRWZnR3R0dPaEdSL3BZUDFYUGxCeXpueGp6?=
 =?utf-8?B?cVl4OXNKMVBkSjFtSDViRFc1U0JydUR5VzZMd2ZDV2FvcXFHZE4wSVhFbVhZ?=
 =?utf-8?B?UlZUaUl3K2t2VDlQZzh2TFAwS3Z2aWdlQTdOTEF0WGIrUm9uRFBaVUNERjNw?=
 =?utf-8?B?QW9QR3UrSW5CaDU5QzVrR1BEVVJyc0Nkc3pMNkx4Ny9KR2Mybk5TQ3M1S3VX?=
 =?utf-8?B?SGxuNTkvemhXeGp4Z1FyT1JubEtuM1FHVWYvOS9lVllOeFVKTTZXL2hXdE9L?=
 =?utf-8?B?Yk9UeTZvdXRwYTFadEMwR1ArSjFEdFA3RXc3NGQyS01uazlRRWZWWGlwTExC?=
 =?utf-8?Q?0h011ilLPinq3ulA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <730CE314A612CC4FB6CA8FB103609A84@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: I6p9qvFvtN4/D9AoHQu2cwTFbayA9ApHyRRdb4Nz9uVyqP/t+1MFajMIdez68kNRE/e8q0t0O8IgIWhlmo9EKVCzk2BjIDeHpUjSy81i3i5y/AGnH/NBwtwCpihb9dFJL8n8a4WQsm835A8GKrcj+lYAX/nxD1yKl3SzCjv3wpP4MceTVRQl6u16vwy0y7ArL6TQADKuv0GODbzv86BgpIooLJtKAfDdn/s2Xshhr+IUy2km50J8graOFaFfZBTniDDc9+jO4uj1MHyigPxZChJ5rM933nA3wZT7Y8x7o83DY+c/PnkU/88QOIgpqo8Vvr1UJD7PlAt6beJ/HORmew==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b87f6b4-f05a-4f66-b6fe-08deee6a3b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 18:41:55.5983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQ1KHvq5Sdk2DtvLDskXAvuzHalauah5r3XswAf37UyQmkB9w4PdPPATY3i+aet7CwBMBrdsziJ4rbmluck2nghFkN2SVI5xaPdGVWnFnuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9591
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA3LTMxIGF0IDAwOjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiBJ
J3ZlIGZvdW5kIGlzc3VlIGluIG15IGltcGxlbWVudGF0aW9uLiBJZiBleHRlbnNpb25zIGFyZSBy
ZXF1aXJlZCBhdA0KPiA+IGJvb3QgdXAgdGltZSBidXQgc29tZWhvdyBub3QgcmVxdWlyZWQgYWZ0
ZXIgdXBkYXRlLCB0aGUgY29kZSBqdXN0IHNraXANCj4gPiB0ZHhfZXh0X2luaXQoKSBhbmQgdGhl
IHVwZGF0ZSBzdWNjZWVkLCBidXQgYWZ0ZXIgdGhhdCB0aGUgZXh0ZW5zaW9uDQo+ID4gZmVhdHVy
ZXMgd2lsbCBicmVhay4NCj4gPiANCj4gPiBJT1csIHdlIHNob3VsZCBub3QgdXBkYXRlIHRoZSBt
ZXRhZGF0YSwgd2Ugc2hvdWxkIGZvbGxvdyB0aGUgYm9vdCB1cA0KPiA+IHRpbWUgbWV0YWRhdGEg
dG8gZW5zdXJlIG5vIGZlYXR1cmUgY2hhbmdlcy4NCj4gDQo+IFNvcnJ5LCBJIGNoYW5nZWQgbXkg
bWluZC4gSSByZW1lbWJlciBURFggbW9kdWxlIGFyY2hpdGVjdG9yIHNhaWQgInRoZQ0KPiBob3N0
IHNob3VsZCBub3QgYXNzdW1lIGFueSBmZWF0dXJlL1NFQU1DQUxMIG11c3QgYmUgYXNzb2NpYXRl
ZCB3aXRoIGFueQ0KPiBleHRlbnNpb24sIGl0IGlzIGhpZGRlbiBmcm9tIHRoZSBob3N0LiBUb2Rh
eSBhIFNFQU1DQUxMIGlzIGJhY2tlZCBieSBhbg0KPiBleHRlbnNpb24sIHRvbW9ycm93IGl0IG1h
eSBub3QiLg0KPiANCj4gU28gaW4gdGhpcyBjYXNlLCBleHRfcmVxdWlyZWQgbWF5IGZsaXAgYWNy
b3NzIHVwZGF0ZXMgYW5kIHdlIHNob3VsZA0KPiBob25vciB0aGUgcnVudGltZSBtZXRhZGF0YS4N
Cg0KVGhlbiB0aGlzIGlzIGFuIGluY29tcGF0aWJsZSB1cGRhdGUsIG5vPyBMaW51eCBkb2Vzbid0
IHN1cHBvcnQgaW5jb21wYXRpYmxlDQp1cGRhdGVzLiBXZSBjYW4ga2VlcCBpdCBzaW1wbGVyLg0K
DQo+IA0KPiBJIG1hZGUgYW5vdGhlciBlZmZvcnQgdG8gY29tYmluZSBjb21tb24gcm91dGluZXMg
Zm9yIGV4dCBpbml0IGFuZA0KPiB1cGRhdGUsIGJ1dCBkb24ndCBsaWtlIGhvdyBpdCB0dXJucyBv
dXQuIElmIG5vIG9uZSB3YW50cyBpdCB0aGF0IG11Y2gsDQo+IEknZCByYXRoZXIgc3RheSB1bmNo
YW5nZWQ6DQoNCg==
