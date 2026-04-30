Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F22C0299;
	Thu, 30 Apr 2026 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777585730; cv=fail; b=Tqzqs/s2ghEcofJoiBeSEYx1PvyeG3Gb2VBJURLGYjYMZVi/74yFdFTgbr5gZr5/ghBO3t7i4SJ7mZzzwlROSAotbISyWekStyl5Vwiwd2eusxUMmN9u/Vr9a9PRbbYpeJE+/5Y/8Y1xRwwkbZoBBcpIOGcx4HjzQf/RpdMzzPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777585730; c=relaxed/simple;
	bh=OCJfe4b/tMwE0C/kMtzKJKNWx4OUYg98tCfNX6ZnVEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CmDmC4iXdihNI31OHaY8l/8c4Gmv7yEh3a1XjhXaNkMSA6wV2fmvtk1YPqzXJcpeZkDTFTQ+KDeCirf4fqjvMUVYcVd6NQRVQmU6G3pE2crE+PHGS3mJHxUd0Lq3scW+RwtcpHFn1YQgxTPZEDkr9wUIuEA4dsbU2aUwKPBYL6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Skn1Jb4T; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Skn1Jb4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777585729; x=1809121729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OCJfe4b/tMwE0C/kMtzKJKNWx4OUYg98tCfNX6ZnVEo=;
  b=Skn1Jb4TamR9XtbRQa5Vv39NStyHLDtS44gs3xGjrWCMM70lojVavX76
   s5XmQoMTZiTsDB+vKIs9GtpIxdi6K+OJFcRxGuC3vP6NRe6nbPgsu2iaM
   8S5JVy41EdS9F4cpKewutexYNC0F/ymqBUmrq2XbcQ9BSbUIxjS7YLnX3
   Cjj1fE7gH5chOSv91wDs6ZArOJi8f5y8cGRLinERiQYH8lrLQ8Dv4R4WD
   bdNr55e2vwHW2mBvSk2Tcqr2wp/ldBQ2RpD59p2yLibfd3Rw9Kqsuf2NI
   L8fx5HHb7oVkMHIAZGO13hlEleWS/bnNCYYstpgoqLnjZWgS0INyMzbt7
   w==;
X-CSE-ConnectionGUID: acE5KSXKQci5nWB5LogLqQ==
X-CSE-MsgGUID: +1Ba+vY9RbifnFAjvhc1ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="101219314"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="101219314"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 14:48:49 -0700
X-CSE-ConnectionGUID: UAVOMdt1S/KKXe2srfd34g==
X-CSE-MsgGUID: 2mxATtokTeuT9JZXtJfvcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="228205961"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 14:48:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 14:48:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 14:48:48 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 14:48:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g429dOXGVKC6qb4fH8V9+WLY0WXc/u/vJ2N064Pt9mEOwFekZ03NncDs7YOreFt7nYOhysWgQwSgCEBQGb1X4tx8/1kHSmD6JreK59SsLJG+3mcH7Kle51g86cFcH7GNDfOPljomMtaJhB3amWEvkyOprmYUh8a8UoCJ9MjryK3ZWSmrqVAbc1X5/QtM23FSDvG9l13/bFcPe/YeDKnpQ+I3GPEhbSfIxI4f6EjQy+YHqyilAfYtuw1dKI99JsoBTnSS5dZgL0lXm7X5BrAB4LGBhjzp1YnuQa24rRBYUWxpBR5zk5V6g21PD7qEdKWzVf4YC0HX/tKmbnn2FSCclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCJfe4b/tMwE0C/kMtzKJKNWx4OUYg98tCfNX6ZnVEo=;
 b=dDGD65hHLSherndCVZ1sIoXPyRGEJY3dHO5nyrQ/yOGfuDrfPQqvtIBw/FuXo09SiZCl+VZUdTQK9hCjkDhhh6f+euA7BZ0gD5hpArhH5ZA8cOpGdXunWcUvUeNCzxtfQIduSx3hQeYEHeJpvwOFtVaJ+F9Rg49dxDpJgAD1Tp2yb5WTGDhPXEvlvIbesWbn2Eoub68fW25SivzbMcZQIJS4ZmaSqZTDNaC1stFfxHagWWw29urJcEYzI6t3QTqif9Eks4Gne08azfNU1eneFgWBplmSbqYQ3REj24qeKE0dWhcHIB2F/WM6HMnFeyKRshFF3ep5PSqK7hofysgUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 21:48:44 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 21:48:44 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Hansen, Dave" <dave.hansen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "Shahar, Sagi" <sagis@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v8 12/21] x86/virt/seamldr: Install a new TDX module
Thread-Topic: [PATCH v8 12/21] x86/virt/seamldr: Install a new TDX module
Thread-Index: AQHc1lrAVWaou73ilU6tcza7anlxbLX3+mAAgAAvJIA=
Date: Thu, 30 Apr 2026 21:48:44 +0000
Message-ID: <ab11b3c922c93db045c4c0dfa8f191eb6fdb0b9f.camel@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
	 <20260427152854.101171-13-chao.gao@intel.com>
	 <f92d114c-c0f1-4eaa-a828-a4d9ac4054d4@intel.com>
In-Reply-To: <f92d114c-c0f1-4eaa-a828-a4d9ac4054d4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7558:EE_
x-ms-office365-filtering-correlation-id: e71a2b2c-43f5-4b7f-9da0-08dea7024024
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: plcQCIHWKDoLe7J0E6OMq6CXN1kHlQ03bBlLEDFWjgelPGCrkpXE9XawifZ5KygLnAOdPLKw0H7sKoxncJ779JFcyeVcaLQZImLgGA3QeWATLgUfc6PCusw4lse/YMcCCd2j0rVeuNX4drrteNtLcTneMA9bWNhi9GFqqMdET/YSnC7Tu53bJDUIAPyJ1sbYvcTB1nDNC4Nkh6VdEsOvBUaYxi4GlPSG75+KXk1OfCHwmLRrLhOTJROQSycewPLMKTuW8u4HKvr0xXmBQg0VoWzgtX/AZ0hFeczKa7ci0OC9LoRv5oNQ04dkUjsZ1DncGv9dyn6Ui+8TG1oSMNBEMZ5JlkOSi97XkPXRMuL4sJFOeGjfH2iqT3r+BBIjvOGXzOYvWsnhvNsb4JNsbkCUhKZ09NKdvseqW3gX5H9FM2CMLV1idDglsufN5AuDGCBJ7af7OlJ8euGvhE8W/fj9AIbS1tyfJTW3Tcqwr6i7wHPEnk4h1uHiRPv4wS86LQHmx2NvkWjkxHci27LK6qUisXFLpo+OOKUXuBqbBSJHWVPNA1HfRFIa+z9mOAYW5T+BAHS2grdWWlpRgesPp+wVdu2L2WyUPH81/pzE0EtATHJcU0id6LQOO8hduIjX1wnyRvMobh/MwqOmxYH5cgW7IZEF5aela6REMmRm5pTulGLQ1k7OMtR7CfgEsaftlB5hgkdfMshJSHYlJOys1MLvDI7m1ucfdt3OS0iSmKCvKs4QDrn8BhKvWpFVebJHyEBD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFzTUxGZjhwci8vYVFzVEdLdkZtTjAwQmoxbWVqS0p2ekt0M1FyT0RRZlJy?=
 =?utf-8?B?Z09EaUp4MDFiSTdPWTlKdWQwcDRHQmNZVzdGYTRNbHNHMEpkc2pDeXRoaXJy?=
 =?utf-8?B?T2dVUGttNG1EUWdST2M4TTVRbkFvdXR4RUgrSDBvZStxRVFYcWE1elRGcE9y?=
 =?utf-8?B?VDRmaDZ5N29YZXF3RllsaXZ5NDMxUW5LSUxRVnY3bGVPZGFkUDBGbFZzRjRt?=
 =?utf-8?B?Q0svSGY2Rzg0cXdTcVlzL1YvT3N1Q1NNTVZDODZJdEwwd3Z0dlZZQU80eDhx?=
 =?utf-8?B?bGNZeHVZTTRYUFQ1Vmp0M3c4RGxLSWZpK3hPbHNYYUNDWnN6NGg5ZXVFbHNw?=
 =?utf-8?B?NXFURlFuWklEQzR3Zk96YU0wZGNJOUJwZFRtSEFGdlNJOTFiM2xHMU1pMnRK?=
 =?utf-8?B?b3lETEx0MmdTekdvaUI3VnZDampOWCsyN3pXNGNaRUlWbXVERzZkeG4zZFV6?=
 =?utf-8?B?aTN5UUxZRkVnRnp5NVJpeFhzeUZQSkNLUHdUUW1zT2M4NVNTQ1NjUWx5ZVEz?=
 =?utf-8?B?VTlDd0tPZzVsTTNaaEpPamxZQ00vRXZRc3FDTEY3Y3JWcFdMTC8xZ1RIbFQx?=
 =?utf-8?B?QzVQQTFPOVk0RUtmUzN6cCs2ekVLS29nZXRjUG5PWWZLb0xlNHNWMnpSQndi?=
 =?utf-8?B?UUJqKzc0ZG5JYjhxajR2cTk1YUVwMzduZTJRTC9udm5zdEhxZ2YreDZVZDhu?=
 =?utf-8?B?Q0VaUndtdkE5SmxpUDU4KzRqeWpIOGVMOEJuVGo3QTUzbXUwWmdBaFJrM3pD?=
 =?utf-8?B?RE1mZEhVck5tMHBHUm1TeTM2Nm1XQk9lYjlIc2RQSUFDeVE3d2Y0cGpFYUYx?=
 =?utf-8?B?b3p1Y0laTTdJa0tNYzJoVGowQjBFcTRjVzcyVllsRkhFOTRQNGhEYTRoeUJF?=
 =?utf-8?B?TDBqSU9FZ0xsTVRtUThkSW9qdHA3YURwOG9tY2EybDkyMXZEL1RnWjRRZHNK?=
 =?utf-8?B?M2ZpMWdRa0t3QS9YM1pRMkUyRjc0SzlERUtiM2hTUElhcUhzWEdaby9obWRx?=
 =?utf-8?B?a09JL211S1RYY0pmMk1rTDNyWk5EcjNIN1c1T2ZpbmN5VU1KSjNmZkVhZERl?=
 =?utf-8?B?dHhya1prSnduditRQmUyMXJtYzlmQ0ozQkhuY09aOXE5QXN6ekdRT0taREJ6?=
 =?utf-8?B?U3h6aXFuOWZWVEt5MlV3c3d6SkphVFQxcXhpSlNTOU9UV0RhNytBc09lVjJE?=
 =?utf-8?B?UDBKNWp5YkNqVE5BRUp5Q05UYTdaM2ZLVkFoT29SNys3Ujc5SlBORHhWVlQx?=
 =?utf-8?B?TXVGNnBFSldocW1CUlU0aUlDTGpvUDViYWVsdlNqbGljcVppeEs4clR4UnVx?=
 =?utf-8?B?WVlibm9oR2V5OHlIYUhnWS9QZnRpRzNIaWQ4QXM1djE5eExpdGhwU2R1aGF4?=
 =?utf-8?B?eVhuMGJYSFdOcWgyK1FoaUZTVnBxOVFFdktKSVpteHFoUlFrTGlGVTNRODAz?=
 =?utf-8?B?RytENlR6RDZWRHZEZE1XY2tKRnUraGdtbFFCUGREQ2ZVdGRtYzZNNnJPRUxr?=
 =?utf-8?B?anh5aHNzOUF0WEl2ckRpU2MwUThTd1YyZGN0OWJHOTg2YkxsZzFRSW90ZEhP?=
 =?utf-8?B?VkRRNXdDa3V3U2FCNlFrRHIwL0prMFI4dkE3VlF1cGpWcm92RThjNGxiZk55?=
 =?utf-8?B?dGJBRU4vTERQRUpKbWVDQ3cyQnNpNkx1Ym54bUVaemM5WHdNT2dLM0JKY24r?=
 =?utf-8?B?Nmp1STNxaysyUHMxRHhzYVMzOVpyWVJxUGhLOGlDS2k4OW1wNCt0TW14aUJu?=
 =?utf-8?B?cWZqZ0RLb29zOU1kUFgvMkJJMnBqWkc2b2xNaW1adjV2ZlNkdnZPeWhxQzJX?=
 =?utf-8?B?MEhtMkQ2Nk1tRlNvK0tDbFFXVVU2UklrMWdtdno0RDNYbVJLcjlLZ1pqRHZt?=
 =?utf-8?B?SGF1cVJxUkhVZGJIUkNleEpCRjkyNVRrelZaUW1TdisrWUxIc0JwdWtURzlH?=
 =?utf-8?B?L1BuUGRpZ3NWSGVXeFRBdFZDWXlYQXd0K1pkMUdWQW00NnpjcFVPZUh6Q20w?=
 =?utf-8?B?ZUMwaW9Pb05XSkNOQ0dveGtXaGptUjVWU1V5R01jSTBNdm1OcWJkdlY4bGNv?=
 =?utf-8?B?a0lHVHpsQVRwQnVJTkh5ek5wWURGTDhOamxseURzNi9vN0V0eDlONmdvS2hh?=
 =?utf-8?B?QzlRalFCMVNHOCsrUHFMWGtPeisyd2RvdVc0TDFZKzFPL2NLd3NFeDZhOXpn?=
 =?utf-8?B?dkNhNVQvZkdxc0wxbjkxVUo5ZGRoUkZxM25vVUE3STR0dVVrNGN6ZVZDcjVY?=
 =?utf-8?B?SllaNXM4QXQ3cVhBQ2wrUW5JbVFIVGVWemw5cFNnZDZOWndMM1pYdVRXVXB6?=
 =?utf-8?B?akxYTFdOMW9DUFBYa09ISW81OEYyenZaRUlZclR1Ykt5Ym1nUjg4UlF2Zm9n?=
 =?utf-8?Q?jFxuGHJ6tpoVWwMc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BBBDD7B196A9545A7B81159EA4B4644@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DnFm2HGjsreyRgRufrQ4THw/vp/lFw3GMKPNWShp14rlEzS24mNSn99bO8KOIU8D0cTAvqJ7xoKXys8rBlAGrfkjD6rvFu+m861j32AeFnPMHRMteLoPT3MFu6kCW/nJ5/d7rgchXWY2vTEKLCw7B/lJxsNCi82pyWZWp/IokVdKBwt8MZcDKNrSW82thM1pMvuO+tjCBcuhL5mWYDirVnQeti7XAw30+mCvnBjwd3dKNir44/wM9EsY3syIgeh5mbBBw2RugjKPfshg3GAe2pp9hy7ezId3C77m9x9KbPAvXzac1bMmVhbv6x89ewnRjJpvDppMwUf5Vbc1OBvLyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71a2b2c-43f5-4b7f-9da0-08dea7024024
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 21:48:44.0991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dViqN/ErhQmr1UYMHVeh0ckqByjYCzA2aP3hbh6xPo/iCOqW0dytqNoRVAWZrxY9OwEQiWJalZgxg/wj7HXNLwS9bNLIiweSGOrFRULUmBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7558
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTMwIGF0IDEyOjAwIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gNC8yNy8yNiAwODoyOCwgQ2hhbyBHYW8gd3JvdGU6DQo+ID4gKwkJCWNhc2UgTU9EVUxFX1VQ
REFURV9DUFVfSU5TVEFMTDoNCj4gPiArCQkJCXJldCA9IHNlYW1sZHJfaW5zdGFsbChzZWFtbGRy
X3BhcmFtcyk7DQo+ID4gKwkJCQlicmVhazsNCj4gDQo+IEkgcmVhbGx5IGRlc3Bpc2UgdGhpcyBu
YW1pbmcuIENvdWxkIHlvdSBwbGVhc2UgY2xhcmlmeSB3aXRoIGNvbW1lbnRzPw0KPiANCj4gVGhp
cyByZWFkcyBsaWtlIGl0IGlzIGluc3RhbGxpbmcgYSBzZWFtbGRyLCBub3QgdGVsbGluZyBhIHNl
YW1sZHIgdG8NCj4gcGVyZm9ybSBhbiBpbnN0YWxsLg0KDQpZZWEgaXQgZG9lcyByZWFkIHRoYXQg
d2F5LiBXZSBraW5kIG9mIGhhdmUgYSBjb252ZW50aW9uIGFyb3VuZCB0aGUgc2VhbWNhbGwNCndy
YXBwZXJzIG1hdGNoaW5nIHRoZSB0ZHggZG9jcyBuYW1lLiB0ZGhfZm9vX2JhcigpIGlzIHByZXR0
eSBjbGVhci4NClVuZm9ydHVuYXRlbHkgdGhlIHNlYW1sZHIgY2FsbHMgYXJlIGRlZmluZWQgbGlr
ZSBTRUFNTERSLklOU1RBTEwuDQoNCldlIGRvbid0IG5lZWQgdG8gbWFrZSBtYXRjaGluZyB0aGUg
d3JhcHBlcnMgbmFtZSBtYXRjaCB0aGUgdGR4IGRvY3MgYmUgYSBydWxlLiBJDQpqdXN0IGNvbnNp
ZGVyZWQgdHJ5aW5nIHRvIG1ha2UgYSBzZWFtbGRyIG5hbWUgc2NoZW1hIHRvIG1ha2UgaXQgY2xl
YXIgdGhhdCB0aGVzZQ0KYXJlIHNlYW1sZHIgY2FsbCBuYW1lcy4gQnV0IGl0IGlzIHByb2JhYmx5
IGJldHRlciB0byBqdXN0IHNwZWNpYWwgY2FzZSB0aGlzIG9uZQ0Kd2l0aCBhIGNsZWFyZXIgbmFt
ZSB3ZSBnaXZlIGl0LCBsaWtlIHNlYW1sZHJfdGR4X21vZHVsZV9pbnN0YWxsKCkuIFdoaWNoIGlz
DQpzbGlnaHRseSBsb25nLCBidXQgYm90aCBjbGVhciBvbiB0aGUgcHVycG9zZSBhbmQgdGhhdCBp
dCBpcyBpbiB0aGUgZmFtaWx5IG9mDQpzZWFtbGRyXygpIGZ1bmN0aW9ucy4NCg==
