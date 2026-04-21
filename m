Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12D3644A1
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787918; cv=fail; b=HgaILgYjQ6Dsb/zfH0es9eZGhyJcjft/NIA1XFgK10n2RcqUZ038/w8GqvNLwtKfWmDc3H4jyoWzaVMUvOKEtOzL9LmOsNViERCMnUB/IeVJmAUK7igVvr1jD1lqxsRe6NuQDwUBDB021eC4328nnHZaJlm+HV5SGgkXVjFakfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787918; c=relaxed/simple;
	bh=3AxaHnTTiXwhWJq6FwcHexu+7IxVrV24n1VYJwPSROc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gNreM7dDX+LIvrPpM6NFQULU+ZbAWbaMcVRvW6FAwS15x/mTxvGOJtcv2pmmW15fCtFXD9bAoDoD1YrLU/cVtPy8xe4jIsANUjXoKa7/Opn68PXmBFo4K7/Id9mVl6taLTHXRWH94fAVPkRlafyVjNiAETxe9J4Fnfuks4CvbWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPnTUw7g; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPnTUw7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776787915; x=1808323915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3AxaHnTTiXwhWJq6FwcHexu+7IxVrV24n1VYJwPSROc=;
  b=aPnTUw7gwRBFEpmwwMVszKQAfjfpgIVHKQ4bua5n60k3MmoV0hMrHLMK
   x5i+sBPgZHCCAWBaykc6+j8CFZvpKRlIhCItKmMUEg/8CSg89tG18comP
   aZYPFTAKGIHNeeKZ4Du/SRbQ/YnchJ67fwWCUX1NF5ojeVkXOzZWd1dx7
   4rfd+3EQG76MLbGp02LkWm1njujoXJ4h9IRIpuXJvMZNJYXYV9un31XvR
   QrpFMkGX0A4vmo82McmAOp5KfOY2EJhj4ElXIAJ6o9cMvlJL9C6NZror3
   OGuMiPH+NnQe/pGn3Ee3JtE4812qPAs3b1Ll9AIQRJ6vGxlGbYTMd5dhy
   w==;
X-CSE-ConnectionGUID: EGk+UhbPRbuaR0R5En5QXQ==
X-CSE-MsgGUID: vGL0YZXkTjazfxCHW09h9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77601711"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77601711"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 09:11:53 -0700
X-CSE-ConnectionGUID: 34Vt9EL/Q/iJOIOYYKN5cw==
X-CSE-MsgGUID: eedn2C7vQC6TTeelIhM+sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231039435"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 09:11:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 09:11:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 09:11:51 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 09:11:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeHKvkxPA6qQc6UP6PWa4l2v3BlpcfHWzwjegxsjzcDVqA2xBMYBsNqS7rzce+ViWi/y2BRCazTAyDvwG5AshMbsTOb9eXFpqX+AZmzJKEifmsShwxOY8sgINXe8JFL0rWZxFQ0GAXCHq71Q2Druu1i6e/e58nE8LMeHiPX09y5cq99eFu9KZVGXZCvprXWKaSUwfccnc38CMogx+qSKfDak6R775/1urn6y+UTKLYRPH6SfwiiZpRlsvhsxFYr2zJlHwD+Z7IRD4g9Q9jNEyYTyM1iC08dxGtVeUBKkrYGlWSvGIJ26yo/JDYQquHMUe+PGi7c1K7dKuSYnZjvfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AxaHnTTiXwhWJq6FwcHexu+7IxVrV24n1VYJwPSROc=;
 b=IcC/ygB8MRUNu9PoCsWnCP2KUaVce465DMxzdymxRzFB+gM4e6tAW0fhF5e2zO4QTbKCBnqhmbvOdcJGw3akQA/GbkEDwSL/tFwIzzn6EK4F7eQlxiXr0XJUGwLQEh5qVVzSJdGVxvvg/iUrQZ4lUPh3Bf/5KWgCa3tn5J4GKmGrSDekYghVm1Jtj4mTyT9GR5Vdo4dxuVjIin+tHLmSD1jopS0pa2zQ5O0oLotjyu9MCPuCjb5DZCFT12Th9nsinnn7irLZCeqwKQE8he86kpB2oMmiHNK5CMk5X4tfgkOftjWK06VxzGWuITc4C51M9+hducQX76bANsovl78OzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 16:11:43 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%5]) with mapi id 15.20.9846.011; Tue, 21 Apr 2026
 16:11:42 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Topic: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Index: AQHczeKk+wS46Li00UqCaHMewgV8CLXoEP2AgADoVICAAC7QAIAAjy2A
Date: Tue, 21 Apr 2026 16:11:42 +0000
Message-ID: <46c70f5f00375cd7a83c13a03a9cd8d33e33cf73.camel@intel.com>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
	 <87mryxekxy.ffs@tglx>
	 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
	 <87eck8daot.ffs@tglx>
In-Reply-To: <87eck8daot.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|IA1PR11MB7176:EE_
x-ms-office365-filtering-correlation-id: 8651a959-23b9-47ee-c9af-08de9fc0ada9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|18096099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 7nRjp2z9CZjqtO6riTphQYQHzbtbYYH5Kna6MysyB6EluiffRuqemhTtcW0uKZ+4N0pyjoA9u19ZAZvaybPBePMNl93qf457imKCIkWHcRyh5oOZc7w0qISSzK5mipxDSezFoYEZB9eBHjxBSaVyb4HeHvfLfLn4pLwtKdbd8011PgxW0R+JoBKONOI1j239KQSZgkcf/OvzFsDlhgVlVjyz+IGGK+3LrT4kIcvCmszar42+zRKVnRdWpMsRS0U5tWH4HuKuf55AmGrfCTBpQxcwnIGt2KUCPWRjtuWrIH0YTh29EGeHsMvYoRWpHJt5aEd/+mO3ZSI2qFsfGEDZGC3khEZE/VDrSN+5aTxpTJ9tRM4kHloRygVqLR5mZDZgnVdYO7Ho5JcvoJuTCmefCPYcQM8SMazT3n8Q5yZd0rKoVfoVQ3X0+7DTFoPrK4XYcGTWlXQmVft0zq4wLHM90yPva8Lw2h/vTedvaWsyfws3RheMXHRB1kZxKrlkhl7+8NH6q92q0KdI734GCZwPFtcwkWguJgavmbrqe+eIk8GiKkmAOxmWVhKUXeTOsk/ptufJWfMFiToRPGGX5UpdW2YfojLTt7gkuJFKYyVY9x7BEmWVTNio+dIzJQ4tFWe5Lpdmphw/pmXPGb1BZgaRbdoKOkYR/VQd4tyhZtuRec/YzZMrxg5xLJiq3l3Z7QyJEK5A+2NWsgMhZkVmSapmGC9qDz20D3cBFg3V5ilxZWRh3QnuKfvKyv907e0ObRKU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(18096099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEFLMUN2YTlRa2R5WG9Wa05wMVo5UmJqVXlSRkRkanIyWk9Ic2FycmNRNzhB?=
 =?utf-8?B?THpIbGhyVE5OOTJtck5ZS0FmUS9NQWgwRUF4UzNJZi8rOElvcTRnRjJ5L3Z0?=
 =?utf-8?B?VWswTFhuYnB2T0FSV3ZNYW15cHVGNmJabzU5NnRFSy9wMkFGTTk4ZGZGVnBr?=
 =?utf-8?B?QkJXYWYvczR6UGlNSG1McWlkOVF0TmZoVTVhajA2RUpwSWJIRkZUZHVSWTl4?=
 =?utf-8?B?eVZrR0ltbWtGZUptUUw5Qkp3WmZ2Zm4zeThnZ2JWamJOTkZYQ1BLeEZDRVh0?=
 =?utf-8?B?U1VGam1mWnZHcVE2c01pUXJFcFNPcXpES0dlcGxqWkNVUG5PZmJIa3VXNVNP?=
 =?utf-8?B?MTMveEF1OWZSdTJGY0FsYUlwckpmRWJTNTFJa1ZTeWcvUWhWMXFSM2JOMWdz?=
 =?utf-8?B?YkloYStSQ0lIVFZLcjZEVFljU0l1UGo1MGRUN1lzb0pwTlN2b0NRazRpdWFC?=
 =?utf-8?B?RG4wUVFUWXFYckpaa1hUV001UXd0VXFMbmQveE9LZlpBTTZQR0VlbzFQTXdG?=
 =?utf-8?B?V1ROY3EwRGtGRzlhUXFBTnRSMFJPQS9NQi9iMU1mYmNiekdnY0FsSW01aWFT?=
 =?utf-8?B?RGhzMTNNYzNVbGlEZ1BBUGxpZHBxRklOSmJ6WVBTYUtFOTMrZCt6cm1kSlF1?=
 =?utf-8?B?cnNacGdaNDhNWjhVZVJSYzdCYmx6ejZDcWhqaEJzWHZja00wdWtEZVBETmN5?=
 =?utf-8?B?Wk0vdDZYanlXNkcrektXeWUxNytTWFByZENKRDRaYmdrL2d2TGhvOFBoa1dk?=
 =?utf-8?B?KzdCdWllZVZDeHhCWEtlS2poSUg2dVpyb3NMVkVnVUQ0ZEwrOVNia0pwdWZs?=
 =?utf-8?B?MXhHV1grbG5YbDVERWVOYUpYYVZ0Ny9hNHRYNmxBanlsa1JuZ3htdHR6MjhI?=
 =?utf-8?B?UkpxdzRNWExHL2wxZFQ3bnJZemFuVm5YVFBvUnltRjVYRmJyNHdOd1BjTEFJ?=
 =?utf-8?B?cVRHV0loLys2bXdaZ0g0TkNJWW1EN3hMVUEzTmozcW9KVVZadEg0OG1LTWJG?=
 =?utf-8?B?dzFaUnQ1SFRvc24rVHAvWGl0cGszUkd1bnlReHplellDbFdHSXNnb051TWVG?=
 =?utf-8?B?Nys4eDZkbnFtWkd3blB6b1pWWVVwbTdPZlE4T3E0T1h0ajNWb3NkRWk4cWM3?=
 =?utf-8?B?bTMvc01KaEtDUWs5R0ZmcWRMSUZHNkNNcFB5YWhlQ01Icy9hdFovVmpmY1Av?=
 =?utf-8?B?aHlpOWM1VWJrdThxcUpQWXJlRlZpRkNyYjRBQzFOVWJwSjFmSzRwNUJiWGZX?=
 =?utf-8?B?MEp4L3NqWnE3bUlwdDlTNmtrZytoV2kwVS9zZHpHYzY4eCtqMFpVTmJ5Rll0?=
 =?utf-8?B?Unl5K0V5UmZPWWloam1POTg1cDBnYmdwVUxybmlabkhCWllwVlRDTHk1Wjhp?=
 =?utf-8?B?TGVvTFpzQlJGYmRnMHpQbnQ4OFZ5SHNQTy9VbjUrblM5ZmRUbFlLRmRYR2lz?=
 =?utf-8?B?WUNyU2htYzYzSHpxS3NFVHo2bGg2cXdUWEYrT21yYUdSMUNuWU9DMk1sTzYy?=
 =?utf-8?B?SFdRVHNUY293WTM5SXQ1bGx0SnhPNW1CRjZwZE1odXZVVmc1VDZEdHY0a0c1?=
 =?utf-8?B?MDBSRFk5Um9tUjlyMGdXb2FCVlMwVzBiNFc2ZWo2NjU2L1BuVWFXYm8wdTlS?=
 =?utf-8?B?eE9XZEdjeHBBZ2kyUkVuOGllYTVyNXhSbFdIdEdWSThValEzS244RHZ3ZEs0?=
 =?utf-8?B?OXVPRmVkbEJ6TmJaOGlPOXc0QTJUVjNGZmRpZVRTekczWEVNYjNGQW1VaVcy?=
 =?utf-8?B?V0t2bzFZbmQ4SmZyZXY4THIzQSt3Z1phMVRLMW5xUm5UM0oyNit5ekw1aW1C?=
 =?utf-8?B?ZC9WaENTU3Rpdk56bllIbGRqUU9kbXQ0cUxwMEZqdWNueHFDQXpYTGRDcGpS?=
 =?utf-8?B?Uy9yaW5tYXZQV2tiUlpoNWFjY0xReTNvQkVOYmJXajVTVVpIRG5MdWJiTG1N?=
 =?utf-8?B?SU0vRVNzVzlnWG9leTYrT25QTkpBZnB4SUpDUXE1Y0QvZ3Q1bStidXlMdWZI?=
 =?utf-8?B?Sm9iMWhZRGQ5RHRONXV0bVI1Z0VHaytMTDU4S2RBT2c3d2hwcUFDZ29IQ2tp?=
 =?utf-8?B?bS95ejFTUUljMzI1NU9BSHBucDB3QVUrc1EwL01XakNFMlNiVW5XWW03UlNz?=
 =?utf-8?B?KzdHZmdjWGZpYlF1NXZDam1zMHQ5SkZzUVJIMWpOUDJOdTAxbFBKNC96Vmtq?=
 =?utf-8?B?ZytvWTRoSnU4MjArWGhMZStjWmJGeUhqVGc4bDV3TXpXRXRSNXJncS8xenQr?=
 =?utf-8?B?cGtHdnBJVjlIb3liSm85Y3JFWGRJMzNjTWlFVzlHMGZ0UllvQ1JLNFc3T3V1?=
 =?utf-8?B?RWIraWhxOW5sNkdjeGdkNEVDS1ozOEdzZW5JdU01T0s2OFpXY3pPbkNhY0xC?=
 =?utf-8?Q?JyHBcHDBXcCBtjg0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8E53326EBF93C449D8A317D3C3190D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yqv0QBoMKPSX0FZn6IXVTuT6CM3v2UPGZdjNk++eEe8FFGkWmAvhLZm+rN4RIN/hbnHbAh6eDHQ6ELUmg/fKio8J5UQI9AlTD/nucS4KJBrfXMvp5MKT1g2rw17GtfGjCehyASM+LKqYkkg/lJ5QvLgO687qFyALljGZi0KS7BXjH9wrT9bPK5s/ogxnkjeGZpBT4mAhFn2cl7QDKjjnMUOtTf7gyqGLGqPMJLmlkAf0xWOuyirIHem0GTh137qgCBp5mqlx/U8GAg5DpH7RZTIa2dw3SdJjso1ZeG1afEMPcvV9l/M/R+6xG6hldirp+OdwL9o7ZSkV4iq35ktE1w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8651a959-23b9-47ee-c9af-08de9fc0ada9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 16:11:42.8791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oO/PEGY//3S6cEHzsbYZ9rkJUiEs6DCv4kDrwIoUY/62Z3zADHGyGoI3XIsjSiOTvawv3PUOcylsBCme/hSiZ4yugrEMM1614WeLGMLmiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDA5OjM5ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiBTdWJqZWN0OiBlbnRyeTogRW5mb3JjZSBocnRpbWVyIHJlYXJtaW5nIGluIHRoZSBp
cnFlbnRyeV9leGl0IHBhdGgNCj4gRnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGtlcm5lbC5v
cmc+DQo+IERhdGU6IFR1ZSwgMjEgQXByIDIwMjYgMDk6MDA6NTIgKzAyMDANCj4gDQo+IGlycWVu
dHJ5X2V4aXRfdG9fa2VybmVsX21vZGVfYWZ0ZXJfcHJlZW1wdCgpIGludm9rZXMNCj4gaHJ0aW1l
cl9yZWFybV9kZWZlcnJlZCgpIG9ubHkgd2hlbiB0aGUgaW50ZXJydXB0ZWQgY29udGV4dCBoYWQg
aW50ZXJydXB0cw0KPiBlbmFibGVkLiBUaGF0J3MgYSBjb3JyZWN0IGRlY2lzaW9uIGJlY2F1c2Ug
dGhlIHRpbWVyIGludGVycnVwdCBjYW4gb25seSBiZQ0KPiBkZWxpdmVyZWQgaW4gaW50ZXJydXB0
IGVuYWJsZWQgY29udGV4dHMuIFRoZSBpbnRlcnJ1cHQgZGlzYWJsZWQgcGF0aCBpcw0KPiB1c2Vk
IGJ5IGV4Y2VwdGlvbnMgYW5kIHRyYXBzIHdoaWNoIG5ldmVyIHRvdWNoIHRoZSBocnRpbWVyIG1l
Y2hhbmljcy4NCj4gDQo+IFNvIG11Y2ggZm9yIHRoZSB0aGVvcnksIGJ1dCB0aGVuIHRoZXJlIGlz
IFZJUlQgd2hpY2ggcnVpbnMgZXZlcnl0aGluZy4NCj4gDQo+IEtWTSBpbnZva2VzIHJlZ3VsYXIg
aW50ZXJydXB0cyB3aXRoIHB0X3JlZ3Mgd2hpY2ggaGF2ZSBpbnRlcnJ1cHRzDQo+IGRpc2FibGVk
LiBUaGF0J3MgY29ycmVjdCBmcm9tIHRoZSBLVk0gcG9pbnQgb2YgdmlldywgYnV0IGNvbXBsZXRl
bHkNCj4gdmlvbGF0ZXMgdGhlIG9idmlvdXNseSBjb3JyZWN0IGV4cGVjdGF0aW9ucyBvZiB0aGUg
aW50ZXJydXB0IGVudHJ5L2V4aXQNCj4gY29kZS4NCj4gDQo+IEN1cmUgdGhpcyBieSBhZGRpbmcg
YSBocnRpbWVyX3JlYXJtX2RlZmVycmVkKCkgaW52b2NhdGlvbiBpbnRvIHRoZQ0KPiBpbnRlcnJ1
cHRlZCBjb250ZXh0IGhhcyBpbnRlcnJ1cHQgZGlzYWJsZWQgcGF0aCBvZg0KPiBpcnFlbnRyeV9l
eGl0X3RvX2tlcm5lbF9tb2RlX2FmdGVyX3ByZWVtcHQoKS4NCj4gDQo+IFRoYXQncyB1bmZvcnR1
bmF0ZSB3aGVuIHRoZXJlIGlzIGFuIGFjdHVhbCByZXNjaGVkdWxlIHBlbmRpbmcsIGJ1dCBpdCBj
YW4ndA0KPiBiZSBhdm9pZGVkIGJlY2F1c2UgS1ZNIGludm9rZXMgYSBsb3Qgb2YgY29kZSBhbmQg
YWxzbyByZWVuYWJsZXMgaW50ZXJydXB0cw0KPiBfYmVmb3JlXyByZWFjaGluZyB0aGUgcG9pbnQg
d2hlcmUgdGhlIHJlc2NoZWR1bGUgY29uZGl0aW9uIGlzIGhhbmRsZWQuIFRoYXQNCj4gY2FuIGRl
bGF5IHRoZSByZWFybWluZyBzaWduaWZpY2FudGx5LCB3aGljaCBpbiB0dXJuIGNhbiBjYXVzZSBh
cnRpZmljaWFsDQo+IGxhdGVuY2llcy4NCj4gDQo+IEZpeGVzOiAwZTk4ZWIxNDgxNGUgKCJlbnRy
eTogUHJlcGFyZSBmb3IgZGVmZXJyZWQgaHJ0aW1lciByZWFybWluZyIpDQo+IFJlcG9ydGVkLWJ5
OiAiVmVybWEsIFZpc2hhbCBMIiA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAa2VybmVsLm9yZz4NCj4gQ2xvc2VzOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy83MGNkM2U5N2ZiYjc5NmUyZWIyZmY4Y2Q0Yjc2MTRhZGEwNWE1
ZjI0LmNhbWVsQGludGVsLmNvbQ0KDQpIaSBUaG9tYXMsIEkgdGVzdGVkIHRoaXMgYW5kIHZlcmlm
aWVkIGl0IHNvbHZlcyBib3RoIHRoZSB0ZXN0cywgbm8gbW9yZQ0KbG9ja3Vwcy4gSWYgdGhpcyBp
cyB0aGUgZmluYWwgZml4LCB5b3UgY2FuIGFkZDoNCg0KVGVzdGVkLWJ5OiBWaXNoYWwgVmVybWEg
PHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg0KKEknbSBxdWV1ZWluZyB1cCBQZXRlcidzIHBh
dGNoIG9uIHRoZSBDSSBub3cgdG9vKQ0KDQo+IC0tLQ0KPiDCoGluY2x1ZGUvbGludXgvaXJxLWVu
dHJ5LWNvbW1vbi5oIHzCoMKgwqAgOCArKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKykNCj4gDQo+IC0tLSBhL2luY2x1ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5o
DQo+ICsrKyBiL2luY2x1ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5oDQo+IEBAIC01MTYsNiAr
NTE2LDE0IEBAIGlycWVudHJ5X2V4aXRfdG9fa2VybmVsX21vZGVfYWZ0ZXJfcHJlZW0NCj4gwqAJ
CWluc3RydW1lbnRhdGlvbl9lbmQoKTsNCj4gwqAJfSBlbHNlIHsNCj4gwqAJCS8qDQo+ICsJCSAq
IFRoaXMgaXMgc2FkbHkgcmVxdWlyZWQgZHVlIHRvIEtWTSwgd2hpY2ggaW52b2tlcyByZWd1bGFy
DQo+ICsJCSAqIGludGVycnVwdCBoYW5kbGVycyB3aXRoIGludGVycnVwdCBkaXNhYmxlZCBzdGF0
ZSBpbiBAcmVncy4NCj4gKwkJICovDQo+ICsJCWluc3RydW1lbnRhdGlvbl9iZWdpbigpOw0KPiAr
CQlocnRpbWVyX3JlYXJtX2RlZmVycmVkKCk7DQo+ICsJCWluc3RydW1lbnRhdGlvbl9lbmQoKTsN
Cj4gKw0KPiArCQkvKg0KPiDCoAkJICogSVJRIGZsYWdzIHN0YXRlIGlzIGNvcnJlY3QgYWxyZWFk
eS4gSnVzdCB0ZWxsIFJDVSBpZiBpdA0KPiDCoAkJICogd2FzIG5vdCB3YXRjaGluZyBvbiBlbnRy
eS4NCj4gwqAJCSAqLw0K
