Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E52285068;
	Wed, 19 Aug 2026 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787180922; cv=fail; b=ZAN1I8xly959Hx+GUWBXJkqm0Ah/slaVo4vUoX1GR8YrncVnZMIr6nu5Rnm62qnJXj50WLCOKuoHJI6b5EZdqedsFHzV8gx6UCKHHQg8sbJOfDkHZjmj6Tq9XDpbRWm1iWYq4YiiquS31a3TejDqtBAStQ17WxfrhtXdsLipht8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787180922; c=relaxed/simple;
	bh=7V5u5hiJKykQeBVEFC6dhAYscWfzTETPvvzByU6+pqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UZFHDCJWoJ9+c6Z/dPC/uTCZcDA8HQzjR8h+JhH24M1vil7x5H+b7mJQ4bcOL7eKllB2JbWksdFXGsp64AuQxaxJ/BQp5IZVt8mUsV8QPBFMmPeFAG/GWjGLmMimRA2LheNhJQ/GdIa+pF/R35jGDS9sY/4aNPKZYJmfRWnhmj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtK9xJ4G; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtK9xJ4G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787180921; x=1818716921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7V5u5hiJKykQeBVEFC6dhAYscWfzTETPvvzByU6+pqc=;
  b=KtK9xJ4GrphRzInoaMg54lbsr6UdGmCUKcLuBZorg6GGTUT0XRbclEKn
   dUx7NazuB7un+XOQIWBHWJFj8lqJD11FuhfxyF7reqLan4nWNpksosjVj
   aX9CNrfgQwAkfxm5u9sn9SBY999AGGW3Y7DJebXx6dJvR/tt5Squ5Z0pw
   qhaZkLGurWY1Ns4wn/QqUQrIm1PDA8ML5rP/rSukFRhL3F0JnJUa6a6W8
   RfqUG7ordKHj9y12dbJSUqOlKQV5Fokx9MBpqumZNaa2ON9GewM/Q1ftn
   LSqIHe3glUhjE0LQT6ts135VK3tE9Cf5SzZcws7VZ1QvGE+3f0mx1ra+x
   Q==;
X-CSE-ConnectionGUID: xsv/sVFzREWtjkE6rJOuLw==
X-CSE-MsgGUID: YpTKbN68Rh2PXfd6PigNyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="110495095"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="110495095"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:08:40 -0700
X-CSE-ConnectionGUID: ZNX0eZtnSRm+JXqODCM2Bg==
X-CSE-MsgGUID: mLyX4n1hQBSHAKGN7iOTow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="269222556"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:08:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 16:08:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 16:08:39 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 16:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUvHu5464eRZBQxjKB0lBenUULfl/nGLs6AERTRzBfy4EpkiEACcbK6xNDHWzoO/qz0tN3+ZCH6zwF1hY24WpIrgqqQRX4bqeCdom1FxyglGLAlGO/+uD355UMcNXeK3qb4N34YHRiy30sJ2/bsxHZr52ws/tsT7UoAI3KzmekbbH1NSILGL4dD/PfYL+5KzZl4zZThcsf29k2X/3O4NarTKddUuCICFeTuQqkC7CtbWdUdkYBFqBqdHijKnnV7kiMUyi/4huoUYdfB/Z2SL/Poj2OT9/L8pnz9pXeNkDLBiIHEe8ZXNRssA7I5v3x+APP0/wUevpG3ZwzSDcBkx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V5u5hiJKykQeBVEFC6dhAYscWfzTETPvvzByU6+pqc=;
 b=Qs/TFVIf+VMWlF+Ro7RV1j4iJiFH40WHSVgrQiwgKG3pHFTVNdz8iW5RAT5NCRXXQ0arI5uWwbM3gGtq/keY7k7pt1Z1abHn2M7HoDU36sw+PlNxoP5pOaEevY9USWtHf6CqL3OMB3rTJlVjWV/DSVAvsd8VtYIs9buPNRv9VmtmhEIpyk/qO0P0e6DodYcWbhEaKMrCDnrTh8LdUDxtX+ezXIqVM2n3/Creeax2y2m5MQk7oyzEJimJaRTU3H+VV8tHksHEeZpPTETqcEMH43Gi2oaQReiegiWJ+9qKqWyWIUzceOVCJRB6jz/OJS1il1TFU6MgrBqcLVLY+2o4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB6881.namprd11.prod.outlook.com (2603:10b6:510:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 23:08:30 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 19 Aug 2026
 23:08:30 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kas@kernel.org"
	<kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v4 0/9] KVM: TDX: Enable VM-DoS Prevention Features for
 TDX
Thread-Topic: [PATCH v4 0/9] KVM: TDX: Enable VM-DoS Prevention Features for
 TDX
Thread-Index: AQHdL8C6QuXdUudLCEyObw22H+eGfLal/caAgAAAkoCAAAJqAA==
Date: Wed, 19 Aug 2026 23:08:30 +0000
Message-ID: <8f715ebf5cb0ef70803ca8c6ad462d9de7dfa8be.camel@intel.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
	 <5799b5d637f6b540c45874120aa37749a7dfb955.camel@intel.com>
	 <aoY2N1mpG-IQIUDm@google.com>
In-Reply-To: <aoY2N1mpG-IQIUDm@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB6881:EE_
x-ms-office365-filtering-correlation-id: 2f46e0c6-14aa-4fe1-81e6-08defe46c8ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: kWjsGv1LY0kEzqrHYJ6lGmdsBioVvIEStnZi7NDUj1zGEw0ysRfCBHfrb3FVINR3f3v4S0ughx4t+RMEe+x+pfQ02xq8SeBFeymRKrxe9g3qDQLnnDW/E3zL8/rYzlyUcomJ43WTUKOgiilV2u/IcD1fOrCqeOF6a7s66Y/d1WWsRYBZ1VJZdKPbOMhg3Nn3boxmIXR/SO1bbbWXaR54sDIvtKVpIDV4MOG9UtWtQcD4/xrDGJaaWYASLE/CXgizsMxs2z5ZTKR9n48T79NOSAUaOcZMphoN72AtFziJsYN7CyqVSV+L2ZOJc11dyXE60YZWsV79J+YVWP9wQrpaUdByZT891RVcq3bNHtfm0NjDRZ4CPNsfDpqC1lXMjJrVlEtGI/+1bf1J3BVI+1HhvInE2sHR1Tut3/7cfgH9YrFKH8lpowkFvOyJXPvF3dnQwKp1j00gQzcpLero9B+zUuy886BDU+P0aVMenHK3Vo0Jz52lMU6tyr82PmOfIOvNo/z27i9pme43GwLNevEfc/5UiibtVoVcSwiN+KMpBR9XczqgqfdYiTy5QbUVLLW3nQfg5AObb7rfZ9MP03ExD/AKvO88dbJkMwFNfhcZuZq7bpoaMNcFsCZ5ztVbK2guJ1dzkPsuWEndBstHfGRhcktZRZCvNh+8UOlXc3oe+UAdMmUsG1yVDpFsqBuSZneCKkkez7l+UHn4zGBvQVJDs7sFdbfiRAXHLPsnM9FU4/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWUyaDNwVm9PM1l2SWVEUWVJcFlmMjdBUmpjd3hFSUxHeVFEWjhkcm5xWDVP?=
 =?utf-8?B?c1gweGlpYUpsalovOE5ESkhmOFg5TnJsa1I4ajM5NEdZRGFuRXNQMFVIT2lJ?=
 =?utf-8?B?QmNUUlhHZ0NWWnprWnNGR25tMFpVdjl5MEZ3SllVY3ozWnhld2JSMDRyU3RR?=
 =?utf-8?B?QnZlN2JkOFNaQ2VqNFNXeGhYcEoxdGtGeXFxbEdpSHNoV2xGODBIR01EQkRU?=
 =?utf-8?B?UnhkS09ueDNZR2VnTjdtaDV1akFBRnZ6MEtaMUpxM2FKczhEZ1laMGs4MTh6?=
 =?utf-8?B?dnpXeXRnNW14TVIvS0xUZkhRUTRyVCtORDRPcVpLMUJPdFJhN3pXVmg1WVNL?=
 =?utf-8?B?WkxCVHdnYzgyb2tNck40Y0RIUWYvQUZSaWd2aVZZZjhrVGxKcktlWStWTGd1?=
 =?utf-8?B?UVlicHpPRTF3ejBsNWtuUkFFUGQzSjdyQUdseDRjMUFXUDRTay9tWHo5QWN4?=
 =?utf-8?B?V2JlRWdGc2VMMVRDd08xZDNRdjNqZ2hYdTYreGdoN0ltYzU1R2x3VFZBYVpt?=
 =?utf-8?B?aGJlZzh4RmZuN0dVNDUzbWxwVXVCT3lPbzRYSmQ0RnVQWEtUbUdhdy9jQUwv?=
 =?utf-8?B?WjU0NHNUSlUzbFFrWTNHOFQzN1RJaVVtd2pmYnQ0Mk9Zc290WXJueEFEd21B?=
 =?utf-8?B?c1BnSGQ2OC9wbWtLdU40MHlaNnc4WUxkQVd3NVVPVW84bVZTd1FramJlZjRn?=
 =?utf-8?B?SitERjd3Z0Z0TVc0YXlIYmQ5QzRON01VRmZDUjNnMlZEU0J0azRDSm1HRi9D?=
 =?utf-8?B?SzNtZ0dFU0hyaGZKRjNrV0FVdndQWTZMWDR4T1kxaTBmOFhTaEZwOHRvSW1Z?=
 =?utf-8?B?Y1BBdGFxNTVyQmdIbWVHa0FlczZPQTA4QWNidTBWU3hzanAzSmx6WDRHR2Zy?=
 =?utf-8?B?VHRiWDZtYzVnemFBclFZbE55a0hhNFBMc0xMYkZXZk10TkhUTHFKaHpMeUEv?=
 =?utf-8?B?WitoR25XSDZOUTNRbllOdVJJVGFzZURXNGsvY2JHMU1lR0lIaE9Da0FtbDE3?=
 =?utf-8?B?ejJtbzRyOFdiaVFraVFhbnJjd1RiNGpHaHFPKzAwUFdnZnptOUh0Q1loQms1?=
 =?utf-8?B?RFlSSExSaFAvQ3hKV1hoYzgycE8ydjg3M0F2aTVMZnI5cXFoWENjMDBwTDQ4?=
 =?utf-8?B?SjJsVndHOGZqQXZHRmMxb3BoQjEyeDhHdWdEYU94b0ROYW1KazFlczh2TXB4?=
 =?utf-8?B?elRLUXBNTGtvdUlLd0xPZ0dUbXY3NldqTElHQU5WcFcxWE5UbktJeWlLMVNQ?=
 =?utf-8?B?T2xzOGRZd0FDS0NjQ3V5dUE5WkRJS09CdTRJQ3pQSFZaM2lBUjBtT3UzK01C?=
 =?utf-8?B?aml3ZnJWeGJpR2FMUmY2b0hYZFRRaHJ0eFZJbCtmZW4wTnJVbmpoajB6MmlD?=
 =?utf-8?B?bmtzcy9GZzRLWkJ2WUxJQWJtbDBCdWl1aHN6eEc0a09wZW9LTllJejk4SVVY?=
 =?utf-8?B?ZWs4WXNoY2c2Nk1zL1pPSjZNMmdRbVczK0kzZm9FZ1ZFMi9SbVQ5NkJsdURC?=
 =?utf-8?B?ZytpR0h2bStuN3BSQ2d1aUdmK1dIWG5vTng2SFZ2clpMRm9ubElyb0xPNi9Z?=
 =?utf-8?B?ejAvMVA4eEVBemZZOUlibjl2YWozZEoySXZ0S0FrMDdMRmZlNFdBSFFwRmNp?=
 =?utf-8?B?MGU1ZWRVcUoyclIrcDRPbU1UQVRZcm9WY0RCRVZyc3Z1SUtCeDBkQ0xLRzVE?=
 =?utf-8?B?Y2JrcGdidDVadlhUSmRhenBxdHlDTXJVSTdkVkVCTVlZbDBpeW5UZDQvMUdI?=
 =?utf-8?B?ZkZLU1dWN0VLRkdVZ2NickNMdFNWd1dmd2k0VFVYUEVNWnM5T3VTL1VKOUR4?=
 =?utf-8?B?T0hKMjZ5Qy9aZ2FvNkdUTWt1YW1OSjkxRzk4cGJ2TU0rOHN2cDlxaXRDVlhZ?=
 =?utf-8?B?aUhBRlhQVTQ0QU04dmFMYWM2ekVYVlhZeHl0T3kybE0xS0E1dGlNM0o3RklN?=
 =?utf-8?B?cmo5U0ptbUd3V0lXRU5DL0x6eitQTVE2WUREYm1DRFhNTjFzdUQwdkwyeUZu?=
 =?utf-8?B?RG9IOWtWSFMvelFLSjdOVUZqTlZoTjR0cG84dU56TW1ENENNR2F3Y1FrOEJE?=
 =?utf-8?B?NXlJSEtCU0xQQWUxL21tR2drdVpjT1p2S2lZK1cxdXBwMGY4cEZvaURRSlVz?=
 =?utf-8?B?b0tLUVJ1NlZpbmZac2Vsb2haZy9OdkZQZzhROVpNMUpvNjM1YWYvQmQxNk1U?=
 =?utf-8?B?ZHdpTTZDeVB4VUdLeW9oL05oNHpkckJXYmQzRVQyMGQzS09sK0ZyUW81SUVx?=
 =?utf-8?B?R0dtZEtNbU11dnZRMkN3Wlp1d3UwRUZtRStjQnZ3QWxRdWl2TDFrcEMrMUxh?=
 =?utf-8?B?MkdJNVBjbkFaNGFpZWJCd3VEeWRZanpYVndDVFRFVlY5Vms3UVhKZExiUXRp?=
 =?utf-8?Q?80AkHQtFBqY9m1TU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <291FFA875B3844499BC96427F8C5A479@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oU4NqXu3KAJtJiz1WuQPIinqxVxsJaUfTm/TlVpDYDx1dIIpIesViYLAESKWhZ9UwG461q/bPtg5PtP5x7SsoXR4AWmpVX8jtYRMtddkUcaGKB1sQQoCheWUaT20oCobHc6a9WniI6bAalpjmcEzkwIIdGeTk9TE7AJYMPdP4Eq7Cos3IzsZfFBVtegFswSOG5IfINuECG912Ag1VzSh2NOZPYsJA+/cw40WQfE8HUrEHQAPGsDSnd/LXASAMbafC4dG1cb04gBhVRdKNKsQI+HiBgchvY39NS+5LmcOVVrsLEoxB9Zooj42Er8squj8uxqJVU/jvIxTwQ4i7xZpYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f46e0c6-14aa-4fe1-81e6-08defe46c8ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 23:08:30.0507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8v6ToT9k2PmUzsk3QZCVkkRynddqjDzoxndXRKEaSXmq38P3UP5ptyHYT6ruZ3f0JfMnucrZdsjPCyo4z1kI3RtUmno4E1LDf8mdecjllQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6881
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTE5IGF0IDE2OjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IFRvIG1lIHRoaXMgaXMgbm90IGEgdmFsaWQgcmVhc29uLiBTYXNoaWtvIGlzIGdy
ZWF0LCBidXQgd2UgY2FuJ3QgbGV0IGZhbHNlDQo+ID4gcG9zaXRpdmVzIGRyaXZlIHRoZSBwYXRj
aGVzLiBHaXZlbiB0aGF0IHRoZSBzZXJpZXMgaXMgc28gYmlnIG5vdywgSSdkIHRoaW5rDQo+ID4g
aXQgd291bGQgYmUgYmV0dGVyIHRvIGxlYXZlIDYgYW5kIDkgZm9yIGZvbGxvdyB1cCwgc28gd2Ug
Y2FuIGZvY3VzIG9uIHRoZQ0KPiA+IGNvcmUgdGhpbmcuDQo+IA0KPiBIbW0sIEkgZGlzYWdyZWUu
wqAgSWYgdGhlIGNvbnNvbGlkYXRpb24gd2VyZW4ndCBoZXJlLCBJJ2QgYWJzb2x1dGVseSBhc2sg
Zm9yDQo+IGl0LiBUaGlzIGlzIG5ldyBmZWF0dXJlIGVuYWJsaW5nLsKgIFllYWgsIGl0IGhhcHBl
bnMgdG8gYmUgdGFnZ2VkIGZvciBzdGFibGUsDQo+IGJ1dCBhdCB0aGUgZW5kIG9mIHRoZSBkYXks
IGl0J3MgbmV3IGZlYXR1cmUgZW5hYmxpbmcuwqAgQW5kIGl0J3Mgc3RhbmRhcmQNCj4gb3BlcmF0
aW9uIHByb2NlZHVyZSB0byBkbyBjbGVhbnVwcyBhbmQgZGVkdXAgY29kZSBhcyBwYXJ0IG9mIG5l
dyBmZWF0dXJlDQo+IGVuYWJsaW5nLg0KPiANCj4gSWYgYW55dGhpbmcgcGF0Y2ggNiBzaG91bGQg
YmUgcGF0Y2ggMSwgYnV0IHRoYXQncyBhIG1pbm9yIGRldGFpbCBJIGNhbiBzb3J0DQo+IG91dCB3
aGVuIGFwcGx5aW5nIChhc3N1bWluZyBhbm90aGVyIHZlcnNpb24gaXNuJ3QgcmVxdWlyZWQpLg0K
DQpPay4gQnV0IHlvdSBkaXNhZ3JlZSB3aXRoIGRyb3BwaW5nIHRoZSBwYXRjaD8gT3IgdGhhdCBh
dm9pZGluZyBzYXNoaWtvIHJlcG9ydHMNCm9mIGV4aXN0aW5nIGlzc3VlcyBpcyBhbiBpbnZhbGlk
IHJlYXNvbiB0byBjaGFuZ2UgdGhlIHNlcmllcz8NCg0KSSB0aGluayBpdCdzIGdvb2QgdG8gZGlz
Y3VzcyBhIGJpdCBob3cgdG8gaGFuZGxlIHNhc2hpa28gc2NlbmFyaW9zLg0K
