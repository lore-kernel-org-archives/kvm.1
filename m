Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FA53F076B;
	Thu,  2 Apr 2026 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088012; cv=fail; b=Z01AFb+2vhiRaCP4YqK6X5I4wJyJOwgOzPsNUqv9ngl67dyDpumXM4sJKnAYGBIZUOve5nPwnrtXVtGoeZ8QsGW6sLqK8oIKsOs9iZ/cdjLZkf9Lnjg8qEB+fk9NcnCjL/6mQ693zJgj8c2ftXDjQLCMeBQIIKW87T5EYDSr8vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088012; c=relaxed/simple;
	bh=ts8myt8kFRq5opGIot+X1YRAQ0CPB0JHwGa0m93+TeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pzjAlg15RW8xUCGRJRzpsnPHjTC9R2wv2W1ZZaVezFgfMXnXrB1kB6VgN4dgtXZJ6bJ5W2kBXe8JwGLv1c96KIFxIvXpZJUNNMTxhL5+VgQaAsXi0E1btdok+1YRXRcfvD35xsA4fkimk54t5Aqdu5FRq3nk/GhKBp5hSsGG6Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezSgXd0Z; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezSgXd0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775088011; x=1806624011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ts8myt8kFRq5opGIot+X1YRAQ0CPB0JHwGa0m93+TeQ=;
  b=ezSgXd0ZWRNGGySeb1O741HEPA79wo6IL23qRPyD4ds6jpk0JKqpRp0u
   rM4jKIueLjCCdNvoIOCuYWRg0nn/LtFHfovWO/cq1vQralVZU8T/LdGOG
   tdqVlsodDc6dBMSR8nArlln0IKzsNZvWrJO0Rv7hYhSDOQjycIMeHqQ+q
   1Uvapg4Mm5tr2kdkE7OSVsJ25EskrJqI86oj9QAucIJ/9qg/5dRaV9a0f
   j7Wjxz4z9wHdc+yRo2aLIeZ7iDN27Y611ubXpSsBLI4UYeSv2eBO4KtIC
   z9EXFm2oyd0DLeNWVWWRRBulHgzvRC11zfy+aLp+U0/wjdBneU90pkuFs
   Q==;
X-CSE-ConnectionGUID: HMl/QtilSIKVXif8GgHHUQ==
X-CSE-MsgGUID: p1VNwYp3Q8abfj78JZjdEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="79998057"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79998057"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:00:11 -0700
X-CSE-ConnectionGUID: AFVACU10R0+Y5RBDTB5FFg==
X-CSE-MsgGUID: UAQ3wJjpQOiMLWsnrMv8Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="257288917"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:00:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:00:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 17:00:06 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CG4kiaTgI0oe+1FlH/xZ7CrQG2kzAfV19c9Vu2qNIxmk3I+VK0R5X8669I+/01no2MGJ+9vch2kkgy0JnwBItkPP6FGknliuCfJehIHIaaTmf0e6LSSb7Wjhp94NZzE8zEJL/hC2zC+VKonqv/GZoT2qJykgb/R4uJh7Zg75mzGvTav9OoRgMsVEXh6u/wj0123523IutkLnEBz1KRVMX8rbzvzcoxSoRLSdyQK2scA4o5i70Biqr2QXdTBKoEfFf11JvlviHTVI8U+ogB5x/yUnu1mhzIMOvsXueCXxEVYbHP3Ifc5/5dWVped2nbH8UIQK18LkZ2hgCpU4AvHyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts8myt8kFRq5opGIot+X1YRAQ0CPB0JHwGa0m93+TeQ=;
 b=XHQGPoiZ/BuvV0e3TddGUyZKD2CG+r0xhdGHX5B9Gdh7DiwvOgqpPngFIXF04PgA5szcFgKWKGBZK1i3Q467Y+iEWxni44KVRlvyuMJoHMZhHeLvDsQ8ILWminfx5aCUP6OIDrMY91jd98LQJZMq/TzpRc/q0/wTWX9cyZkNdjj3E7y3Sjl6tuh+BZUA3uVzwI9el9eFLQHTE1NXWvrfKfpUV6+SrnjwTESLEWGhZDrbj9VMXurRYMV9PIDY7XmrJWdGveDlifmTHgBrX8SPrAnKlt0JORnTKKtYBGTf5E0cGCOYgNgM6UW/xFzxz0OTqH4WNz+JdXymxy1HZWg7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ5PPF7DCFBC32A.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::839) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 00:00:03 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 00:00:03 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 10/17] KVM: TDX: Move set_external_spte_present() assert
 into TDX code
Thread-Topic: [PATCH 10/17] KVM: TDX: Move set_external_spte_present() assert
 into TDX code
Thread-Index: AQHcviZa21ztskcQ1EK/IV8xwSsU87XIdqGAgAJ0YAA=
Date: Thu, 2 Apr 2026 00:00:03 +0000
Message-ID: <8a87747e1cef1e27b3126b95eaa592f001fb862a.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-11-rick.p.edgecombe@intel.com>
	 <8cd9eb14bde0817c60cd87b8a3baaa670ddcc47d.camel@intel.com>
In-Reply-To: <8cd9eb14bde0817c60cd87b8a3baaa670ddcc47d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ5PPF7DCFBC32A:EE_
x-ms-office365-filtering-correlation-id: 5b3c9ffe-f617-4dcf-b14d-08de904aca87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: cXVS2Ij22AtdirYud0Q1K3qCRGgbT3ureoHMl4ZEfhXXeTbctkCNqNZ6abkrA/Eet+lpPaXBIYunR0eSQtKzbIO92n8fP8j/1HkpyPvhQeg6wctfCsZatjVC865xf8nzn3DGbWD4anbQmyqr0f+VuPIcmk+WOXwhVsF8x0xzNiosqJAtqfmEUqPaXL6Tx/C/qVM771gFZq6NpLpTvlrOnWlwvpd5W7lVtD7d+4MEmkg6t5GXHtVuux3tuGcdXmylx5u8FwqtS7qo8SpOb2tbc0Au4kYyeEZTrj2JFNCxOq0gf6hE/qzF6ayrT68WdZU10AgIaEHgmMQbyxsPL7AdwElzUFxOTdP5yMKFE2rLdImAnCybfiO60r71PdvaX9+NvUh4dHQjViCkF7BJdckOeEG59Q9iFZaHh+R5IhgPUuRDkLCuqoXm03eRfHvCC5j3rHAzYMUhDRrkkBijUTtlRR6YSs/uEBFnADyzYFsWUD6kO+FH5b3rMi52QTKypZlmV6BIBxH6vaFN+D4WMdDckc4JaJxWyvHQolc+urdDZhtBi6fY9OXNdQlYtFA84ABMfGoOsBCHVFLay0AkUCmAQNs6XUykZ35GX/zqH9iw86+tKQvjfGV3xilf966AjNYI30smlGc9kK3Bpkerq15uRtK5cAT/1KwX/LV41USGabQK+tFTO83mBWPf91KlkKGRjaIHokjnkaaFYx4O/YxcOT+0IXesj1jwTAL5XIWmp5B0jVRa4mWY+GUxTTgCXtAz8K+onsRayOJxpg06J1ziRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0piSDlRL1A2b0tJWkpsTHBVRGd6WGJDTk1Oc0YvRDQzeVBHMXBBV3RlQW5a?=
 =?utf-8?B?S2VsWmx6a1Qzcm5DaFBhSUdpVTBmQnJwd3d5bkY4TWlnTkE3eklFUEVIL09H?=
 =?utf-8?B?S0R2UGtuVnRJY3grSWtlOHp6djZndjZCYmdlYVJ5QzhHWktGRDh5YW42M00y?=
 =?utf-8?B?dWUwbWZqK2dRZGRTM0RCTjh0VWtPWnpmenZIcGVSRGR0Y0lJblBXdEVKNysy?=
 =?utf-8?B?TjBTTWJ2ZkxVZm1BcmV1RER1YlRldzlwbzh2aEQ0Mkd4blNmd0FSaFArcnlN?=
 =?utf-8?B?dXZQWHh5bkhPRCsyN2tzdE43bStxZ3ErRG9ZNkxHTVhaVHFMdlpLMTVXVDdB?=
 =?utf-8?B?SEhDbm5OWVNWempNNWdYWjdCMTEzTFkvKzFaWWdmNGRoaUhveVZ1eXhuUUR0?=
 =?utf-8?B?cDAzcW8yb2luaCt2c0F4b2hDUGhHanEwSTFjS08xcTFjbE1zL0JzdDl0czJw?=
 =?utf-8?B?MUg0N2lRTU9UaU40YU5pNWxXYWc0Mld6c0EzWkhXalVoODVGWExmSWdzVHBY?=
 =?utf-8?B?aXpLclY1eVp0aDdaWjVzNElINUl1QXFNdnJaYTBOOE05eitDQmhIczhwV3dK?=
 =?utf-8?B?NHhqWUh4anNoek92bVBlRmx3TEpKRFlHVGJBY2FtdmJ2R2M5KzVDWk04VHZB?=
 =?utf-8?B?ckxnZ0t1QU1TVlJ3WEhWSEY2M0gxYVdtbjEzMGFrUEs2Nm80TUZFQUpSekZJ?=
 =?utf-8?B?NlF1cnpGSGVPMy9RQU1OVk5wOGlobmRLVGpIZTNWUnRCb3k5R28wWFEwWjA3?=
 =?utf-8?B?YUZzblplc0N6SmtWRjhlaHJzWkxjL2l1dTJQQjJ4dzQ1NEh2MmMweHFUb2tC?=
 =?utf-8?B?QUZEZGlFOVgyK0N2bW9TNVRXV1h2RUpKSkxaZy9TelR5b2NxVXNzQUVDaThI?=
 =?utf-8?B?c1E0bkFKRHZaVTlzK0dPUkNNTFVlSWhRU3UreWJ5N3JPNDdvOUdrNFFQV24r?=
 =?utf-8?B?dmhRVE5CcFl3ZFRteEpVYlNDL1pFaWR2UTR1TDJqaTBtTTArTThaYTdRNjU0?=
 =?utf-8?B?RXdqVmJZMU1Tb2xWaVFoODRXOUViUGpPRWx1NlcxTjlVYis1cERVd2ZYNVZu?=
 =?utf-8?B?eXdOQ3plRjZjeXBHV05tWHVOa2x6NlBtdEhyQkUvUGx3R0dBZUVzRjN3ZEV2?=
 =?utf-8?B?WWxMOGJYZmN0MVp2UTk0ampIc0Vyb01rNWZnTGdhdVVrMitWc1JxYXRuN1ZN?=
 =?utf-8?B?VGVuRW1kZ1hQU1ZPL2RPOTFCVk80bi8rNlVTNEVIMmwxd1FFcmY1cG5HTXB3?=
 =?utf-8?B?Q2tOL2hFaUlEUlNqY1ZXWDRJTktnWXRSalZ5bUlQS2s1ZW5VdHR5bi9uU0gw?=
 =?utf-8?B?TDVLeEM4K1NhUUwrazV5MTlHSUY2WXVibmhCWTc3aXpYNFNJS1FYSnVuOEdE?=
 =?utf-8?B?ZDltMTkrZ2VzRUtKWTVNUkZIVGtXNHBTSTdRSTNnbEtmVGVhU1hFM1JGOUEx?=
 =?utf-8?B?L3hBbjdFSzBMYnBQZEFrTUdTOHJPS05qTVJhM1h4Q0RnV0tFUjZBSFU4MjFH?=
 =?utf-8?B?K0oxb0Z2VjAxQURpVU5rbzdlZGtBcEtzK2daeUl2VUJBdnBiSkUxTlVXWnFu?=
 =?utf-8?B?Z0I5aXR2RWtZQzlQYmJac29WYjZBaWI4NTRrMEZZOWZPMXVuSVRMZUEzKzZS?=
 =?utf-8?B?V2V6Q0FSNldKMDE2NWYvaitjaFhmZlFIdjQvSzRGbC9ibVpONnBSTlpMV2xz?=
 =?utf-8?B?djBqWGdISkdYZGxIZEE3U1BDTE9OeVlqQkhDY2VrTnIwR0wrMjBYRU51WGFV?=
 =?utf-8?B?T0p2RTQvMUg2aCtRM2MzUDNzQWFoMmJLSDNFM0wwT0h2NzIxaEtPSXlYcFdS?=
 =?utf-8?B?RjRPLzBDdWFSTDF5V2lLakNlblJtYlhncjExMXpEOFgzamJYSkNqT2lwRWRS?=
 =?utf-8?B?NnY2aldoZjU3TUthbHZNMlF2VmdyZmUwODdHeGUvZHNzQ21DeGpUWUxqdkYx?=
 =?utf-8?B?Vmsreis3ejlqclBvem9SZUU2VU90MzQyalJyUENEcG52K1duMGJQaDY5ODN3?=
 =?utf-8?B?RUtiRnBhZGgrZW5tdzdqaHdTOXhqdWZnYmYwa3Y0cHlWMXNwckd2aWJNSEZy?=
 =?utf-8?B?MHFOWkFkd0FVcElaZlZtZHJaU3B6WkF5SWhDR21MRG5GSkhGK3pldWEyWldk?=
 =?utf-8?B?NFp0TExjV1ZvalBSZEtUakE2UUU1SFU0ViszbHFad3BXc21NUUpScWlFQjZo?=
 =?utf-8?B?QTcrUW9ocVVkb0dtenZrVzJpZnp1cENDQ0l3V1dKTlIveTNZV3IzYmFWZjlO?=
 =?utf-8?B?eTl6TjM5ZEZPSDM1ei96TE05RmM2WkhiUXg4dUJ3UmhyaWI0blp2NmNhNVZy?=
 =?utf-8?B?aFY5QTRLWC8wcG9hMEs4Z2h3OWZuT3l6bjdXYW9SMFUreE5HMlo3SVBGMmJy?=
 =?utf-8?Q?k/6k8jmcA/cACprw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB46AE402BF20C4CA718D884263BB2CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GvnDWTkAAoHJ87hnJ0tcgySk3dyGQRR8oU7J1UKFySCdR7gIKm8GFU+ZK+BIVLTppu6etwj00Mcne0uoy8dQtG65BUuwNShGcBn1xNCO2d/IBCZTKfURP0Qi4cZPWHj2kS09aLrGBvN5EaLfhMSgn2OB/XlZIFopj29k3Ony6ADBNxZtXjmiKToV0LhwTAG5ovadAe8PpRhT3ijw6n8yqlLMdUxB0e5Ns8hpHENz8InJAOgBRoyw4jlul6F5wWW3jibzdBJWC+mtwGfqsEdN8oEmENG50SiX5WOM1iY6pzW1rUSdlwlsHZatkLB71mcmw32J/WZ3Mn1e7N2mTd/xhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3c9ffe-f617-4dcf-b14d-08de904aca87
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 00:00:03.2508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wV54VkHyj/CPtuKTgfgo04aPuA6qht9/nouESS9kK//ZVHPSYmOHHoByyOouBYke3tAScjTtk1TKj2C5IK/JdJvLlAgcIM3oDTTRQ1FW4s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7DCFBC32A
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDEwOjMwICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBGcmksIDIwMjYtMDMtMjcgYXQgMTM6MTQgLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0K
PiA+IMKgc3RhdGljIGludCB0ZHhfc2VwdF9zZXRfcHJpdmF0ZV9zcHRlKHN0cnVjdCBrdm0gKmt2
bSwgZ2ZuX3QgZ2ZuLA0KPiA+IMKgCQkJCcKgwqDCoMKgIGVudW0gcGdfbGV2ZWwgbGV2ZWwsIHU2
NCBtaXJyb3Jfc3B0ZSkNCj4gPiDCoHsNCj4gPiAtDQo+ID4gwqAJaWYgKEtWTV9CVUdfT04oIWlz
X3NoYWRvd19wcmVzZW50X3B0ZShtaXJyb3Jfc3B0ZSksIGt2bSkpDQo+ID4gwqAJCXJldHVybiAt
RUlPOw0KPiANCj4gVGhpcyBsaW5lIGRlbGV0aW5nIGlzbid0IG5lZWRlZCBpZiBpdCB3YXNuJ3Qg
aW50cm9kdWNlZCBpbiB0aGUgcHJldmlvdXMNCj4gcGF0Y2guDQoNCg0KT29wcywgd2lsbCBmaXgu
DQo=
