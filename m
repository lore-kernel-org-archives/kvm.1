Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385139E6FC
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574503; cv=fail; b=euOAjPXbYYRY35GjDdFyZyT2MxdcQ4UyBfrVlM+VMZdUdfyW43bouwUYiXGBwarVBpAJbdAD6HH3KqFly4ZZWLcAsUpyXDdzuoynK/sLCICqTiSk341wmkRV2bte+4tT0QZZd0telvTT+rlP/mbQPaB+6Ed1cnvd5joMa/TAvAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574503; c=relaxed/simple;
	bh=71N5MPz6nWwduzYpqN9fV8hB9xmy98N+VPIQClmsxHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t0YiH9wEhJxUzjp6EXNCWc9oitUmHnSGLVYHfWnf8rFDQuPog3hbV3QffkSzXBdF++RvQR/fwUzj29j+RRgz3lCWytrmI+eTTOAew0vF2ey1gKqzsL2a+pJZOkR4E1hsBoBchih0gReZ0fwcGRBM+KugEWBapR5miDNTyNxot0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adjPKWCG; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adjPKWCG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786574502; x=1818110502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=71N5MPz6nWwduzYpqN9fV8hB9xmy98N+VPIQClmsxHs=;
  b=adjPKWCGabW6/ALxts84BUSqWICKa0hAAVg3OCVcs3gFZY7zaJkKRE/s
   DdNaTv1C8zBHol+3RaQVI5/cJyyGz3VZtOvm/qEBvC4nLgOie4uXFDi1u
   hCxTiYD0vF7gDzj+6x2LvK41j1rrSh/IqPCTbK1o/QebatYFc0q5tSQHg
   9cI2WwS5uisE2PddgnyGx135/LuRxxjKogGlhhb+f/0pbSCo4lJaMpzAe
   TJVmy01l0wSseLqMfWn2cTalWBDQRZcD6k3KGOYvU8cToDOZlP3xxnbxT
   i+oQ2XmIuSRV1AFhbnPinFoN88AcNingKKcHbJInB4tyoGRzzn94YbnkU
   Q==;
X-CSE-ConnectionGUID: MMc4sbCLQbGPWkeVZmjbuw==
X-CSE-MsgGUID: ZcoRGCOaRXWOV+I6hUM5Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98658782"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="98658782"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:41:42 -0700
X-CSE-ConnectionGUID: GfP9Nkm/RHqkSIxBbpdAQQ==
X-CSE-MsgGUID: AURCaDAnTE6D6mfscAWNpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="262460452"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:41:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:41:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 15:41:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3PFy5aUJ9cNjUPgnA0a8z9tbXRjIKrNA94KEcan0lCsxOdSz7Z4hjhdcR9uGqNoRDjvjtrbblMLXDWASdVVeSmG0SRbBDC2r/fR5CeM+62hr+9JOmAdnnfVqN7I6GaAZvidHMKg9adOaSAsoLYTS4YoNFnQzWhc5+yiJq0OyXZbCCNkOVUMitfpOhiYv3dpWn69ym/2LagVz3S/RaE14F0gVEPIljVRdQsu1r0KEVggy3LJbQmjShSSuRJVdk8SLWVRM+e2VzwPIvOabqsLo6vwYxgYuZpMPYlN8UrNoEByTaRUwiMvGLEVoWVRrEogwQbh+u66sjlYemPaBnSBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71N5MPz6nWwduzYpqN9fV8hB9xmy98N+VPIQClmsxHs=;
 b=Dyls5fLzcn4Y8HDdxyoikcYMeuq8I/vohnw56a9zT6DVA/5s9r93Uem9WSg6J2X+Qln37bRlqdn0efkrCppq1Ngj9YBU0cZPeL0MpBPEOuJrZfsjDsxzrUpirVWAJNCuHymczcJ50WZxzOWv9cG7YPWVoTaTXrpY2ep14bwjBAsyoTX/YCGhpSrt5H+hLPrmPXs4kOlJyc6hdvDxkeiK/mfvCCMFnKQfmNTHUeRKfiO/ZjC27KaXvxvqqFBFgMzpcBeqvCG8uC2ZMawC2Z9qtD4iylO8x1qc4SI4oXzledUIibNh0nm3MK9qpr0xC/vBE7wVikghhzCMCBrP98SzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 22:41:34 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 22:41:33 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "hao_zhang_kdev@163.com"
	<hao_zhang_kdev@163.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH v5 5/6] KVM: x86: ioapic: Clear irr_delivered on
 level-triggered RTE
Thread-Topic: [PATCH v5 5/6] KVM: x86: ioapic: Clear irr_delivered on
 level-triggered RTE
Thread-Index: AQHdKjYcl6jUb4SKU0my2dP3TYcVtbabAwSA
Date: Wed, 12 Aug 2026 22:41:33 +0000
Message-ID: <786130c4f97b8a3d26d6104037758f2046f349e7.camel@intel.com>
References: <anwxK1aCSCGVygih@192.168.1.215>
In-Reply-To: <anwxK1aCSCGVygih@192.168.1.215>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|SA2PR11MB4955:EE_
x-ms-office365-filtering-correlation-id: 7bb98edf-3cc0-41de-b165-08def8c2dc68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: /HX+UTp2e0ZiARNpmCp6w+GLyJGQPOg87+46wKVNBe+wI4pi4C0dwGGUjaP/XcxidJed1D9WBKzgxNX9csELW1Sv3a+GGuhngbWFkq/FAbUgqbiiv54+PjJ79ya6PfYU342DTawXBPljrcf6jsdmfMRu1eR40/qUAovcbcgu5Q6RY8bajwW9MkukzS86Xvv45heBHr1tSHXTfsiqZCHRFme6IdnmNLGv0oteo1ngZhNO8bCps52qw165iG9iujjePK9sJ9z6gunEajizOuUUYL0yghcuhpAbk0R0fnarYFvtJDhYC1eyWOS1O2T/Bg2RWfX1GfOZ2IuVhtq4C5pmraYz8xZ5A9yPlEnYpw5G3JjRtZfnqIu85pJaGy9BSAYRUKejvKnnPV0ziZhl8u/F8qocf1Xh74iPnX1fiTGoPxYvBm0lCzEOGfeqfhH6pRjw5TQ2EvMqc4+TccWajMwukZDwv/74/nHKO7nxBCQ2BNM0zDiC4hiWESoAimcvs+wagWOca6Nsx7O4mJpSUex8JkQr2WCQpirACYG38LmIPAOEwbuCmPnK51d/sKm4a52RyIyKFZ8yidrP7g+jyUqIsWjCCdA5a3PfRbe2POy/vyzzfZVYR09iHTdnMBXWC0LV6Q5h7qBDAPzDeajINa5TA/toD1yTe2HK+JLSbIoRcc65EMlRo9S6FYoitdDy/LyT0xC9tlwu3lXXxs9W04qA393klkHPJ+77kGh6xNVWG24=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXUzb1YxcjBkSk1PY3FGdmx1eGFCREpMOWtBREwydFdRREsxY2ZpNFcwZFVQ?=
 =?utf-8?B?K3N2QjB3S1hDd3FGd1ZGdWY5eDRGcCttM251ZDRMTkVxM2IrWXp2OUhCU01B?=
 =?utf-8?B?aWZPYUFUcGRNRHBBeXdNVnVYdytYbzY1RWhIdmhoRDBaU1IzRVowWHJaQWdT?=
 =?utf-8?B?bTNOZ1dUQUJISnkxU2QvL0JoWXlUdFpldWhsZ3FBbXZiSnJ4SlZhTGU4dWFI?=
 =?utf-8?B?NGZMcFZiMHpoWm02MHVxNU8xTXNBQTA2cnBjb0dlYnlwSHpIOGxtTHp6NlUr?=
 =?utf-8?B?K1kyT0pHUmdEMjc3SVpMR2tOOXJLd3dCeFFlaFFSQTZ5OWpVbDVjdjUxNGNN?=
 =?utf-8?B?Z1pKdFRkSnBkYXJHaWxnUEFud0Z1ZCs5RHRSUVA4Y3FUTHMzWCtDZ0YvR3BR?=
 =?utf-8?B?TXRlRFNlWUlpNHVzQWdEMnp2em1RaWU0WUlseXVNY0RYMUVHRXFtREhmcXJx?=
 =?utf-8?B?NDhIK2pPWStvNmphZk5jYXhZRWwxaTM0UkhLZmpJd1hYSlp2Q0M5N2JJenFk?=
 =?utf-8?B?R2JxcE1TYkI1SFFzN0FuOVRTZFdiamYrSU1JZ0t1OC9lOUlSZUxYYWVpWnJJ?=
 =?utf-8?B?MGM2cFRRTkNLOU9aa0lSM1FmVTJkZVlHWCtBWTBMSjlZU2s4eU8zWmFhWFNw?=
 =?utf-8?B?R01kdjI3WGN6ZnBUaXN6SXlYcjZVai9CTmM3Mk4rSkxUcjgyeW45eHVMZVlK?=
 =?utf-8?B?akZBMTljUXdmSTdSdzVvTDh6Zng3cXJ5T0FKYUlOS2xLRm1XK1R0V2dFRlNn?=
 =?utf-8?B?SjYzaHBMV0dMWmRHYnVsbGt6MXdLVC9hT25KNTJEeWpkTWdNbi9obWlYMU16?=
 =?utf-8?B?N2YzbGliaHlCSGV4NGtFNTlDS3U2Wm9ScFUvNmRrbjBGQXRwdytGTC9sKzc1?=
 =?utf-8?B?NFB3SXNrY0hWQVlIZ3VKKzBqK09LSDJueFJsSXIydkprS0JtNktvS2c4SHFr?=
 =?utf-8?B?Mml2aTlCcUpOem15ZlplNzczVm14N3N4Tm9hZWVuVWZCZ0RhV3dNcFgyckc1?=
 =?utf-8?B?WHRxUjZGSnhDRkp0SlVyMjgrYlF5UHZRc1JuaFY2aXRhKzRZU0dyOWRUSllr?=
 =?utf-8?B?a2tBUUFXTmJYTU1QQkcwdEhlVFdzVnNZSythU1ZHbDRRVmR4bTVSNi9vRjZW?=
 =?utf-8?B?REs2U0l5WWJRV1N5SW5FenNIUjJpN3lLREZYMTd1Sm41VGxFVytHcUp5YitU?=
 =?utf-8?B?VURncWloTWZFamRyOXJYYjZsWFNCaXFLTUM4bno2alAvU1BFYUJTOTBXUXRQ?=
 =?utf-8?B?aWRLUmhmUkFqcytBaFRaM1VTdHlMU3UyQUZmV2ttMjZWL3F0TjlrN2drMDl1?=
 =?utf-8?B?TlF3eUxPL2NmUmlyZDlzNWZVRVVHWGF6Z3l4RVFnMU0zVlExcXNtQTI2UHEz?=
 =?utf-8?B?MlVRTmsyOWljS1FBaG9QTXJzQjJmUGl5L1Q1a2I1SkRERU9sdnlQTDAwUHhm?=
 =?utf-8?B?U1R0R2VyVEtuL2I4a3BNZFVqazhFd1h4L1hFcFhDWUxkaDA3KzJhbHhXSTJL?=
 =?utf-8?B?VnBkZndQbWxnUDlKKy92Y0x3ZlEwbmNGUExvMEo1S3JnVi9NbXplMThCUFVY?=
 =?utf-8?B?WWdtYXZZQjVoTFdxTXh4RjJqNVUvU0hNbFE0cUtpTG0vaXVvZmJucEgvNFhW?=
 =?utf-8?B?emdQbVVHbW9taUxRQ3ladFNuZ2QvbTFxYkFoOS9OaWJsbEVrejhtMHM0RWF5?=
 =?utf-8?B?M21zN1FZM0ZNVXM0d3ZpTk9GM3VuL3V2YVVSamZSZ2xuamhSaGtGVlU2M3N0?=
 =?utf-8?B?ajJLQ0YwWDJNdWtTVEZHZGtNbmlYT2x3VVJCMXZsaGtWa2tlNWdCalNRcnA5?=
 =?utf-8?B?WjZLZ21yOG9OaHNKc00yNlRHMWM5NE5oZkllcWdPM0tWc21vK0dmOVF2dnB0?=
 =?utf-8?B?Vkk3YlpQVDFETFV1ekdQZnFmc0NDdzFkdy9vbFlxNUxMOFlDaW5RV2IyRmFZ?=
 =?utf-8?B?cHhSbnBHQmNDSXhVT2p6VVFidldlU1JMSXY0L3V5YWwrb0MzcklFNXVVRkNT?=
 =?utf-8?B?WXhYZk1Md2RJSHhEbTM2cmhKZkt5WkN1QzlVRlY5WmxBQXJ0SFBwcUZnUEUy?=
 =?utf-8?B?emY4ZzZvWFVZVUVRaE9EME9PTEd4OFZGck9ZR1VlQUNTdG9yVFd1d2VjM1RK?=
 =?utf-8?B?VElyVW43SUFwY3JEeGgxU0czQzlBeVExL2d5dDh5YTJNdlRTMjlEajNtVWlX?=
 =?utf-8?B?dHVLQjd3OFI4Mld3TkNlMFhqWUtpK3ZLbDA4eXdUcDVmeDMyQVpxUUNySmZK?=
 =?utf-8?B?ZWN0VGVCSXh6cENQUDZLNmVHRllXSzh5Qmkybzd5T25CenlYLzlHdHlZVG1R?=
 =?utf-8?B?dlFmeE1yN3ZKcFdIcFdDVkViSG9KandxQk9KNW03WmxQVUdpNUE0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0380FE07756EF448BFF39857CAC3F30@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dh+705pPWiIg8HUL3UwfB3TUhpG1UjEH06nUywOF6jdXE3MVm0hZmoQjXuUFiR9ldbGx8Jg13r4WHUaD1bhm4d/UQY9UFezWlNjYPwG5E9idVkUNjBSTa8oNTWb0PjUPMAFjdIEVQJuh3OcpmBKIphC96C5UwGIWr9RgT9K6MEOEC2rhop9WwBcrnJnyzShTYqOUTNa95ZYuk9fnGijgSY/DYhr3wopZbw9uhCN7QLrcr+95al5AHJm8ocYhUCP1w3DchMBDw7ahNopgupWzcIgyoOmv+OFd6S+2Dlo8MVZyLv+kcTS9BdjuLLUj1xEhea6nccswLnpR35SWXVAjrw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb98edf-3cc0-41de-b165-08def8c2dc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 22:41:33.8222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTmzxLirQ58iapzT8pga3/igBNBTTfqHKDRfOdE1OWTGl7MrubR0wtmzYDDnvHUBMHE6Z/GbMEq6hzWYg7McrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE2OjM5ICswODAwLCBIYW8gWmhhbmcgd3JvdGU6DQo+IEZy
b206IEhhbyBaaGFuZyA8emhhbmdoYW8xQGt5bGlub3MuY24+DQo+IA0KPiBpcnJfZGVsaXZlcmVk
IGhpZGVzIGRlbGl2ZXJlZCBlZGdlIGludGVycnVwdHMgZnJvbSBLVk1fR0VUX0lSUUNISVAuDQo+
IFRoZSBpbnRlcnJ1cHQgcmVtYWlucyBpbiBJUlIgdW50aWwgdGhlIGd1ZXN0IGRlYXNzZXJ0cyB0
aGUgbGluZS4NCj4gDQo+IFRoZSBndWVzdCBjYW4gcmVwcm9ncmFtIGFuIElPQVBJQyBSVEUgZnJv
bSBlZGdlIHRvIGxldmVsIHZpYSBNTUlPLg0KPiBJZiBhbiBlZGdlIGludGVycnVwdCB3YXMgZGVs
aXZlcmVkIGJlZm9yZSB0aGUgdHJpZ2dlciBtb2RlIGNoYW5nZSwgYQ0KPiBzdGFsZSBpcnJfZGVs
aXZlcmVkIGJpdCBjYW4gaW5jb3JyZWN0bHkgbWFzayBhIHN1YnNlcXVlbnQgcGVuZGluZyBsZXZl
bA0KPiBpbnRlcnJ1cHQgZnJvbSBLVk1fR0VUX0lSUUNISVAuDQo+IA0KPiBUaGF0IGNhbiBjYXVz
ZSB1c2Vyc3BhY2UgdG8gbWlncmF0ZSB0aGUgVk0gd2l0aG91dCBhIHBlbmRpbmcgbGV2ZWwNCj4g
aW50ZXJydXB0IHRoYXQgaXMgc3RpbGwgcHJlc2VudCBpbiBLVk0ncyBpbi1rZXJuZWwgSU9BUElD
Lg0KPiANCj4gQ2xlYXIgaXJyX2RlbGl2ZXJlZCB3aGVuIHRoZSBSVEUgaXMgY29uZmlndXJlZCBm
b3IgbGV2ZWwtdHJpZ2dlcmVkDQo+IGludGVycnVwdHMuDQo+IA0KPiBGaXhlczogNWJkYTZlZWQy
ZTM2ICgiS1ZNOiBpb2FwaWM6IFJlY29yZCBlZGdlLXRyaWdnZXJlZCBpbnRlcnJ1cHRzIGRlbGl2
ZXJ5IHN0YXR1cyIpDQo+IFNpZ25lZC1vZmYtYnk6IEhhbyBaaGFuZyA8emhhbmdoYW8xQGt5bGlu
b3MuY24+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
