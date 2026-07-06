Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4503E4C95;
	Mon,  6 Jul 2026 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382104; cv=fail; b=N32B5JhE56EX8PKfT4/jz/hWCOKZ/BwnS1sYXJdNMcaVMV3sEjir1wyoOaRLzzBuUtrojopYDmSWuUg7khzM9der2BBlPJwji4hD1+LfGqTZ2KFiWx+2G6sr63NZ0ASbsaooP8Makt0JOkWooFcN/gu2Jw5cT5zGsHPE0+K0K6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382104; c=relaxed/simple;
	bh=vKXuqWuawF7sxPcxtLKfO9JjXsxTCCG9SFnfZKeJwu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GkZXr4olyTPKlfbszP3CUKo4dNIitvJXmXY2oibM2T/HWF0yYhPHUXOYUOmnVurrhpvm96zolWUp5shi3AIz8U/AG25RFjmk1X1lwPaRJipsSBKBeOWBeVUCMQQZ13lPGjBdyvdXJIz/MaVnsbH+aAgMAh3n9VKgyWgmdOlx+3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4SXZ3kR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4SXZ3kR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783382102; x=1814918102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vKXuqWuawF7sxPcxtLKfO9JjXsxTCCG9SFnfZKeJwu0=;
  b=Y4SXZ3kRZjtYmcFW/nqfZBU4Xr+R16U0mgPphC5BD8MTNGhXv9y9SiOn
   oDYiOjhXuhqDmpTArgXuAx9DvLxnhOdQJvfSlk3em/RAii1/MoOFbdfaf
   27BbCPiS9HXl13sLFsBRS/MXE/jYwVNzm3/KFUou6PY3vG6qcGnFFlFBm
   yqQ4F67f7oFvuI5JN9bof4VMZA2qsf0Tuwok0cN/WHKMoxyqWAeurBJGB
   jIYj3TEcaCwYP8N9KGYRfJD+IpZG+sczhr3DTvH7XtgKwlAfhPBGc4++y
   WGXRkQfEAVlVcr0ru32MSvAyKazDocgSAFGsNJIYQACq437HW29sC2sTp
   A==;
X-CSE-ConnectionGUID: wNXpHCibT0KklIcYu9KieQ==
X-CSE-MsgGUID: lpRKg0RiScSZcMTFLY5pgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83132881"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83132881"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 16:55:01 -0700
X-CSE-ConnectionGUID: vKVlI6lIT6mTVWhqrRq/AQ==
X-CSE-MsgGUID: dCDhd3z2Tt6GhREnZ5L8jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="255779237"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 16:55:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 16:55:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 16:55:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 16:55:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU1heMrvItC4ZSksF2CqNkdmqxL6s/2Nwjaj83g6c2uX6g1KI8H9GK7rNCCWabXDT7unBSQrYOM/zSjLdFB3o5kL91w1PLSjFohdGWePEIZXXE7/YKni03j2Lp0HKxojgWd+We1dFgINAyBxlvs10fc1pPcyDeINg+ZCkpUIT3qqJ2xzb69OYdQp9lZcz8mnB2DFEXc5aai0OsxG8kYmAex+/mgnLIsJRDo6DqE9sXPqwYGoYsYpZI1iIyZUsLCeHf4+zXZyKBKX8b0heQn4XM1OcVFrwf2ewODsgNOQey4q2qRBkPOHAL1WZg79Av7N84ZAp9gTrmEqekFK39Nkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKXuqWuawF7sxPcxtLKfO9JjXsxTCCG9SFnfZKeJwu0=;
 b=R+TQPNdIjBVhmHK9i0hDp8Vxx2Loty50NDOw1oJMuivLSDWWiXM2MLCPy7EkPJE41qlwgyQWM148r8fyiQnS03XMiMnZKbEEl4zagXRtKiFjDzZSMGyHwoRQuGIWpVQz2m4U27Vv6LgQXlonBb8evwWoeKGe16JNdNkU8zRCQC2wLA9QktgLE0EQhZ64VyUCysFoaTjr7rzM9s2V/akrdI51Ptj0UofjUpqKYyn6JTZa/fTcLZ8KDjLt/xoRCIH0SszfSIsvLNFlhsawsn1r4Xtm132DlpVvXr/6G0guadgshLpEA4DaA5lOhCjhIvThgU7lS9u7uKIe88TEZy5mGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA3PR11MB8893.namprd11.prod.outlook.com (2603:10b6:208:577::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 23:54:52 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 23:54:52 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Thread-Topic: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Thread-Index: AQHc7LhTEcr7wAnIiUS2NeuNOJCIabZhagsAgAACL4A=
Date: Mon, 6 Jul 2026 23:54:52 +0000
Message-ID: <b9e2c377a21a53329cd70ac48309981957814686.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-8-rick.p.edgecombe@intel.com>
	 <akw-dgBE_dycts0o@google.com>
In-Reply-To: <akw-dgBE_dycts0o@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA3PR11MB8893:EE_
x-ms-office365-filtering-correlation-id: 99a9dd28-2019-416e-48a4-08dedbb9f907
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|38070700021|6133799003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: AaQ2TEMaH1EwPSBF4Mv3G2syxVQmKUAFtjTi3eFLYRmJyr1gWVSqNH+HbkWfVvukXCF7YqFmdGr+VY0kxtovn2Wf/YELEe4siAWabPZgo6AuNV32aaZKCxO44eM9w9XIC9d8jtxM4n3PNtE1Y8ywDk5sbw/jLH3j5kedmIFLwMXhVSbpGVq4ThOacmWR8Yep87Bosr9jMDB65j2NoRf7OHZIppugqcz+Wdta92sMscCl3De04HfomexH8/JnVEF7d3aDj4zdgZgHrNvpuc4bIL7G9xnuYJNg5GGmDBGNZj5IqOevn2AjOaaCAxukWL6YR2lPje/D0Lqw+4tnZLgvwcTfo+udtwN2ggSoLEbg/liC36S6W0sifRl2t6Kbi1k6NjOEOj/a7Bxsc1miEIhpH5e7ZQzAWzzwYtpPcO6cUiLjmMV2LNTv3ffmDDlGtcvbZmaF3tKPKKpFowHhd2W+HvmoWAzn4ydyICsHiR3T1vvUTy4hF7QECc6px2uFE0XEICkbK3GswydKB4oEE/xRoR+dt/TQpPdXGKqMvYmkVhePOo4x+7jF4wU6t0jHLiaGDe1rGcELl1TLXPtOUroAbzXwvhq7u1LmnM1J3E750vVb24vF3fCnVQDZ3Ca4D2nDjfQ066lGi/NYeHs/dyKuyJfYrrRiRZDTGnGvs+OxswP2Ni85o6seGHN4pc6vUJP8s2eI0+Cwz0bt27iHduXQ9vTE+Q4sbxlPsKjeAumDKag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(38070700021)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzBoaVBrYmtucy94MzJ1bWIwYUd0eHZoNUgzUFdUQXNiRjVwZE04RTR5ZC9W?=
 =?utf-8?B?OFBLN0RHTUNxOHdna0xpczgyM01Lc1RrK0ZUT1pVVlJncnAxTEpjdTkzL014?=
 =?utf-8?B?dHFXMFMwOHVxL0dzQ3E4YjNDZkVGalNnL3F2aVlxYnplOStTQitJbkhwRFEv?=
 =?utf-8?B?L2NMRmxnR1p2a2FDTWVHaWJ3aFBvOExuenRDMXpUUGY3ZmI1dk5xcWg3UlEv?=
 =?utf-8?B?Vm9VVTJsYzNXaGhvTi9MTFFTOVlZVk5YWnJIUVl0SzI0WTVvR0VLaVh2Y3lE?=
 =?utf-8?B?UXdJelVYc211RE5BWk5wNXRUNldoTE10R3ozc0RPeTdqU1pCRDJMUi8yREdM?=
 =?utf-8?B?RWJPRmtBQ1JUWUErT1VVbitCNzZGV3hRYXBqVStsa3dPTlltZ25TeHNYUExF?=
 =?utf-8?B?TWxseVNRbEtBYlBEdklPcnA4eEdwbmRXdnNRQ0hYV0pVZjdNVG9tOXl5c29u?=
 =?utf-8?B?RTM5S2RiaVorMlN2M2U3WXJHcHFIZ2htSGdsOGJ4cndqcmdEYUxSUVFhYzNX?=
 =?utf-8?B?elVNUXRtamY1eWhmQk9CZUVPbmgxSXNuaDdxSE9RMlBIYUF0SDJWOE1YUEhX?=
 =?utf-8?B?c2V5cHVVdzBFWjZ5YVJVbGZ0WC9VY1V4eE05cmFjWndhdnhzd0RCSGtGTWhq?=
 =?utf-8?B?blZIMUlOQnlPVzkvSWIyTFgrcmFvWTdRM2tKaU45Ynd0S0pqK3phb1YwN1hx?=
 =?utf-8?B?RWpBK0lveUNTMWF0cVd1OWNsWXZFR0dISmJFa21SN0dlRVNVWlhvVkZpTkJS?=
 =?utf-8?B?QjUxYnd6Y1lMKzU2SkU3Q1JBbHMxeHlCL0JuRjRncGFhT1NkdUdxL2svWnBu?=
 =?utf-8?B?V2U5RGJYZS9RRDg4LzY2TVgwV0hmdlk5VnVURlhoYzFtcXYxcTgwM2JiT1pm?=
 =?utf-8?B?R1JjSDJGeWZCRStNRWFYRmFXSURLMGYyVnFDbkN3c1JiTWpLZDZjWjVRNHJ5?=
 =?utf-8?B?dG5WTE1uR1dBSjdiVCtsYXVMTTk4SzNiSUg3cXVnYmpZenZqeEpVVHB4bW43?=
 =?utf-8?B?bFIranBRM2N3cGFiM3dGWnZONHdORW5ralhsN3FFcjhBWUxLUExqcHd5WXdR?=
 =?utf-8?B?UWk3eHBBNzZwREdTNUtYb3hrZ2xoMU9YYU11Y3R4aWpxbUo4N0RkTTVUbkQz?=
 =?utf-8?B?a0YwNVZwRGJmNmxnaVZRdzdUb0lOOHlXdHRkOVlkYStnczZXWVVPa25MQXNS?=
 =?utf-8?B?eHlyZ01penErQkZ4MDdQK2trR0k0MWJxMDVoaENaclFiZTk3VzJpWDdzeGpK?=
 =?utf-8?B?cXNrMEJQOXU1dlVrRldRaUdKLzF1R3V0cmtQU3Y5elhoa3F1TjlMK0k3ZFlQ?=
 =?utf-8?B?Vmdpdm5TSFdFR0htaTBKb3ZvV1p0a2o5MjhmYUljVTNETVBxYWU0eUI4N1BY?=
 =?utf-8?B?UkhHMVdDd29YUy8vVWhvSG5makQ2WUZJYitRL3FQL0tIeWpqQkNLUTd6T0hk?=
 =?utf-8?B?RjRqVXNCWGUxdzBsd283ZVdEWndTNXh5dWY4Q3VKZVYzakRTZ0d3L2JEY2lN?=
 =?utf-8?B?Y1hreVp4a0szYllRN0VOMkxnNHlPRENValRkWWlkWld3b3BMTmIreUQwaFRC?=
 =?utf-8?B?aE9VMEkxeEpZU0tvd0dNdE1mQTR3Ym5vRmNtemNBQmpKdERiRnhFMm9ZYmp1?=
 =?utf-8?B?UU1kc3o3RmVDUk5nN2w4OW5VWFNyR3FYK21hbEEraXlHeXJ3akVid0ZzV3FW?=
 =?utf-8?B?UlIvZ3c4bG53d2xGWUJtbkxnRlpaQ1pRQmRtOTZFK1NlZFRnM1lBSkI0aThU?=
 =?utf-8?B?M3c4ZWlBZUtUUWFjaTF3anI4UWl2TEZMTThzTWpWUXR6NEduOWczM1NJdjV3?=
 =?utf-8?B?Tk1MNGVLeHR4ZWNQNXRXcHcwZVRFTWpjOHdVbUZSODV6YWJuNVdjWk5wSjJH?=
 =?utf-8?B?Qjc0anl6U1ZlejcraFdOTTZxVWxnb2lmK3RMeENtamR6cTJSMmlyL1Y1cU9D?=
 =?utf-8?B?TzlyQUUvblA3VHNKaG4xeUx6ZmFkcVNnc1JjdVVqL0JLaXlJS0dBdENHeGNV?=
 =?utf-8?B?ejg2TzdTelZZUllndmFlZGIySHJJOG1sWkI2SnJ2RTFIU0hWeGJ6VUMwMmlx?=
 =?utf-8?B?Sm1idmxrd2NRZjk4bk1DSnJoalVnK05xalVTdlo2NGRJVlRlSDIzd3JqZm90?=
 =?utf-8?B?VjhWWFNzeVpGa1ljYnBIRGtHMmt0Tzl1ek9WQUEweGV2VGl0L1F2Um81VE0w?=
 =?utf-8?B?V2FmODZFSVh6eHQvWWJONlRoT3BubzRURWVFRVVrVzU2cFJyaXYvaHUzNHZM?=
 =?utf-8?B?NDU4bVRuOFAzcitNTFl4b0RYWldTamVLY2JyU2htc0JTdU5FZkxCWTFzR2Vx?=
 =?utf-8?B?c3gwRDczRXR1ODl0QmJyODhzd2dZRkRCWG1PZ1AxVzlNcFpIbFRIOElPenZI?=
 =?utf-8?Q?OkfzcedwPWbih9+U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7F2A0505DA4394084C7F8331FAC8D76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o8CWponoWq1MoDxTgLCaHsixjgcGv/RRjdHqLGQFABwjqUWH+oUFwldLK0cPfvSz5pUINwjl9McvclCmVCjDbNrI0y6uSAAft3GVmKo+/dXeERZoeU5mkTUUT1dtTCGS2P510h/uYeuBZqALdvG+UoNN+O1E32Ac9HqrFg08Ch0IE4ewSXRBdgGp7WZRz2RIqiT4WjQsssXvfXUAxq3FHfi9GgAJ9DbKi2Eo9rQxjkFKM26XVaBA8Kwa8jloiXjuS1RNfVbwHnlD6ho7OcUto0a/2KpH225mVLnvTnS1Dj0IxEa+RNMsafwjhX+eAuQ1vtiTL3DrqS6Qg5OssL5vCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a9dd28-2019-416e-48a4-08dedbb9f907
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 23:54:52.6394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8u2TP4gvCaW5bysK2N4cKssNSUIOC0oA3+YdbxOzTVrN7wfO5RA18pvStGUorgQrzZQJ5VSzb7wCB3OObYYRZUQq0R7GF6PAaZiVAf3JDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8893
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDE2OjQ3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIE1heSAyNSwgMjAyNiwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4g
RnJvbTogIktpcmlsbCBBLiBTaHV0ZW1vdiIgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5j
b20+DQo+ID4gDQo+ID4gVXNlIGNvbnRyb2wgcGFnZSBoZWxwZXJzIGZvciBhbGxvY2F0aW5nIGFu
ZCBmcmVlaW5nIFREIGNvbnRyb2wgc3RydWN0dXJlcywNCj4gPiBzdWNoIHRoZXNlIG9wZXJhdGlv
bnMgY2FuIHdvcmsgZm9yIER5bmFtaWMgUEFNVC4NCj4gPiANCj4gPiBUaGUgVERYIG1vZHVsZSB0
cmFja3Mgc29tZSBzdGF0ZSBmb3IgZWFjaCBwYWdlIG9mIHBoeXNpY2FsIG1lbW9yeSB0aGF0IGl0
DQo+ID4gbWlnaHQgdXNlLiBJdCBjYWxscyB0aGlzIHN0YXRlIHRoZSBQQU1ULiBJdCBpbmNsdWRl
cyBzZXBhcmF0ZSBzdGF0ZSBmb3INCj4gPiBlYWNoIHBhZ2Ugc2l6ZSBhIHBoeXNpY2FsIHBhZ2Ug
Y291bGQgYmUgdXRpbGl6ZWQgYXQgd2l0aGluIHRoZSBURFggbW9kdWxlDQo+ID4gKDFHQiwgMk1C
LCA0S0IpLiBJbiBEeW5hbWljIFBBTVQsIG9ubHkgdGhlIDRLQiBwYWdlIHNpemUgc3RhdGUgaXMN
Cj4gPiBhbGxvY2F0ZWQgZHluYW1pY2FsbHkuIFNvIHRoZSBrZXJuZWwgbXVzdCBpbnN0YWxsIFBB
TVQgYmFja2luZyBmb3IgZWFjaCA0S0INCj4gPiBwYWdlIGJlZm9yZSBnaWZ0aW5nIGl0IHRvIHRo
ZSBURFggbW9kdWxlLCBhbmQgdGVhciBpdCBkb3duIGFmdGVyIHRoZSBwYWdlDQo+ID4gaXMgcmVj
bGFpbWVkLg0KPiA+IA0KPiA+IFRELXNjb3BlZCBjb250cm9sIHBhZ2VzIChURFIsIFREQ1MpIGFu
ZCB2Q1BVLXNjb3BlZCBjb250cm9sIHBhZ2VzIChURFZQUiwNCj4gPiBURENYKSBhcmUgYWxsIGhh
bmRlZCB0byB0aGUgVERYIG1vZHVsZSBhdCA0S0IgcGFnZSBzaXplIGFuZCBhcmUgdGhlcmVmb3Jl
DQo+ID4gc3ViamVjdCB0byB0aGlzIHJlcXVpcmVtZW50LiBSZXBsYWNlIHRoZSByYXcgYWxsb2Nf
cGFnZSgpL19fZnJlZV9wYWdlKCkNCj4gPiBjYWxscyBmb3IgdGhlc2UgcGFnZXMgd2l0aCB0ZHhf
YWxsb2MvZnJlZV9jb250cm9sX3BhZ2UoKS4NCj4gPiANCj4gPiBTd2l0Y2hpbmcgYmV0d2VlbiBz
cGVjaWFsIER5bmFtaWMgUEFNVCBvcGVyYXRpb25zIG9yIG5vcm1hbCBwYWdlDQo+ID4gYWxsb2Mv
ZnJlZSBvcGVyYXRpb25zIGlzIGhhbmRsZWQgaW50ZXJuYWxseSBpbg0KPiA+IHRkeF9hbGxvYy9m
cmVlX2NvbnRyb2xfcGFnZSgpLiBTbyBkb24ndCBjaGVjayBmb3IgRHluYW1pYyBQQU1UIGFyb3Vu
ZCB0aGVzZQ0KPiA+IGNhbGxzLiBKdXN0IGNhbGwgdGhlbSB1bmNvbmRpdGlvbmFsbHkuIFNpbWls
YXJseSwgZHJvcCB0aGUgTlVMTCBjaGVja3MNCj4gPiBiZWZvcmUgZnJlZWluZywgYXMgdGR4X2Zy
ZWVfY29udHJvbF9wYWdlKCkgaGFuZGxlcyBOVUxMIGludGVybmFsbHkuDQo+ID4gDQo+ID4gTm8g
ZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQgd2hlbiBEeW5hbWljIFBBTVQgaXMgbm90IGluIHVz
ZS4NCj4gPiANCj4gPiBBc3Npc3RlZC1ieTogR2l0SHViIENvcGlsb3Q6Y2xhdWRlLW9wdXMtNC02
IENsYXVkZTpjbGF1ZGUtb3B1cy00LTcNCj4gDQo+IEV4YWN0bHkgd2hhdCBhc3Npc3RhbmNlIHdh
cyBnaXZlbiwgYW5kIHdoZW4/ICBJIGNlcnRhaW5seSBkaWRuJ3QgdXNlIGFueSBvZiB0aGVzZQ0K
PiB0b29scywgYW5kIGdpdmVuIHRoYXQgQ2xhdWRlIE9wdXMgNC42IHdhcyByZWxlYXNlZCBhZnRl
ciBJIHBvc3RlZCB0aGUgdjUgUkZDLCBJDQo+IGRvdWJ0IEtpcmlsbCBkaWQgZWl0aGVyLg0KDQpP
biB0aGlzIHBhdGNoIHNwZWNpZmljYWxseSwgbG90cyBvZiAicmV2aWV3IHRoaXMgcGF0Y2giIHR5
cGUgZXhwZXJpbWVudHMgSUlSQy4NClByb2JhYmx5IG1vc3RseSBhcm91bmQgdGhlIGxvZy4NCg0K
PiANCj4gQW5kIGluIG15IHN0cm9uZyBvcGluaW9uLCBldmVuIGlmIEFJIHRvb2xpbmcgd2FzIHVz
ZWQgdG8gcmViYXNlIHRoZSBwYXRjaGVzLCBJDQo+IGRvbid0IHRoaW5rIHRoYXQgbGV2ZWwgb2Yg
ImFzc2lzdGFuY2UiIHNob3VsZCBiZSBwcmVzZW50ZWQgdGhpcyB3YXkuICBFLmcuIEkgd291bGQN
Cj4gcmF0aGVyIGEgbW9yZSBpbmZvcm1hbDoNCj4gDQo+ICAgWyBSaWNrOiBlbmhhbmNlIGxvZywg
cmViYXNlIHdpdGggaGVscCBmcm9tIEFJIHRvb2xpbmddDQo+IA0KPiBCZWNhdXNlIHVubGVzcyBJ
J20gbWlzc2luZyBzb21ldGhpbmcsIGNsYWltaW5nIHRoYXQgQUkgd2FzIHVzZWQgdG8gd3JpdGUg
dGhlIHBhdGNoDQo+IGlzIG1pc2xlYWRpbmcgYW5kIGRpc2luZ2VudW91cy4NCg0KWWVhLCBJIHdh
cyBqdXN0IHRyeWluZyB0byBmb2xsb3cgdGhlIHBvbGljeS4gSXQgc2VlbXMgdGhpbmdzIGFyZSBz
d2luZ2luZyB0aGUNCm90aGVyIHdheSBub3cuIFRoaXMgd29ya3MuDQoNCj4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwu
Y29tPg0KPiA+IFtzZWFuOiBoYW5kbGUgYWxsb2MrZnJlZStyZWNsYWltIGluIG9uZSBwYXRjaF0N
Cj4gPiBDby1kZXZlbG9wZWQtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUu
Y29tPg0KPiANCj4gV2hlcmUgZGlkIHRoaXMgY29tZSBmcm9tPyAgSSBkb24ndCB0aGluayBtZSBz
cXVhc2hpbmcgdHdvIHBhdGNoZXMgdG9nZXRoZXINCj4gd2FycmFudHMgYSBDby1kZXZlbG9wZWQt
YnkuDQoNCkdvc2gsIEknbSBzb3JyeS4gSXQgbG9va3MgbGlrZSBJIGFkZGVkIGl0LiBXaWxsIHJl
bW92ZS4NCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFu
amNAZ29vZ2xlLmNvbT4NCj4gPiBbUmljazogZW5oYW5jZSBsb2ddDQo+ID4gU2lnbmVkLW9mZi1i
eTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KDQo=
