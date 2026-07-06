Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34F480946;
	Mon,  6 Jul 2026 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374795; cv=fail; b=H7UgepeniXAhmM+qo4iUtCK0Jg67GY+cIRATWDjGOyQkVQw4b+BLpnmLtDYacicTThwsvuZZav2f4YP1uGrpq+YoQOCadm1vLKY+lPE/Soc100OAoArEAqaA3dQf2HvbT7s6At8MOz8eqjQ3nMDHbJNP0edG9akxUgSJF0Jm928=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374795; c=relaxed/simple;
	bh=PaRcrK98JpxoWF9SIkGH47VZ9EBlyOVk5oUaj/R+eEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rn2O6lyYquGv0wFCUVisFwsmh7B3eWE3+w6PHLMC6dd4NfwS+NMAEHVbwdns4z6UD7la3lqMRg8zd8Hk126L/TaJkrR29cDVBZYiAstSmoX1+WvYzF9SWbc6vxSNJGvrROvtjbMcztgrsuuCG4lhchi7O9/OzxDvu3lS9WS337E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6jnNCKg; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6jnNCKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783374793; x=1814910793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PaRcrK98JpxoWF9SIkGH47VZ9EBlyOVk5oUaj/R+eEQ=;
  b=J6jnNCKgi1/+Pu/tYE8SJXZaHxFYybvXmAmXlWRkxtF2FykDlj8CQ+kN
   +smgzENt7ktZbGx8XzJHWCo9qGi475mZFuGAB9Mte37+95iHS5o+mar0B
   tmRrDkyKxmzcVEhbyJbUx8wOcngqxpcs/7kfqDGpaFlhw9bvfpzykqdir
   gH3wwRd+X8/Zvu2RhrkXdI3l18lApIPgU7MAjUGAqywHfHMWbYcRIVLlC
   F/RSD4NfEosJrNTiNnfy7WGiTqa5fUEp8g18erzczxvkCmdoByy7Fj5bi
   WtjtrwfJEPQC1J19fttnXAm6jL2ObR3LW/GF5Qki3gj77x6A2vhyDoTLA
   A==;
X-CSE-ConnectionGUID: bpb8FTNDRkCuNgFM2KPzyA==
X-CSE-MsgGUID: Q3sWhUTtR8GZspiVeU2WAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="95172561"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="95172561"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 14:53:07 -0700
X-CSE-ConnectionGUID: IPTTh4yEQGCJn+q7qpKHWA==
X-CSE-MsgGUID: iJ06MtcSR3mSXeJOqa6SPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="255758485"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 14:53:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 14:53:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 14:53:05 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 14:53:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5W42Gd/gexRzWsWvR9v8TSuw3iacFantpHZaKGnFuQ+BCpsKmGVLtmIu9d/ZYVvas790gYNDoObIp0HrQsJuVzP3dVAN6BHjDOcPKEMnPPP+7PDX2NzRiacYiA/qx0emuTpP+w7PszjcvN0gvf4VUKSTMBR0adtiV40pRyN3kzQkjiSssQS6BAFsnqapGFyqh7OIQEXeuFyQ6E8teLbh9AOWQxzk3auhc9lc6T0HU0NeTMWTT8CGLJ7w3PxXjpJ0AQTyau34vw4sLIERxyzH59VglKFbIODFKFNWc29vJWhYs0IfzwszbwUno0uyA/QmVcZK9Qh/1UAj+WtDQFtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaRcrK98JpxoWF9SIkGH47VZ9EBlyOVk5oUaj/R+eEQ=;
 b=hywu+SmVndn7Nac7ttiX5gIHxaDXxCsYDQIw0QTzSxMHgO4RXDdR2xOm7zWw11UAqpmbNStXupigdCkxA1FmKNJFo9RuKluWM09WDk0I7d7gJ3p0cRwQxoybylNfZDgk9Jm1lle8mn4z8N9tX8ByQT9aL1A5u/GZ80e03aVjhr4inBUduot2G5aolo6OMqWmzulR9h/BT+biHZJ8tnyzzFTynLH/Ixe/oy3WkoVEg7udDjzdINQMo7R2dD/TFRNBVpwm4SXzRw+1xMZvxuyfO1g3KU4PHtAXUWOgvqRaiQNZAoTPKf+xiYrqURD1DJeZBnyM64UuYNQoUjgqdpc6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW4PR11MB8267.namprd11.prod.outlook.com (2603:10b6:303:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 21:52:56 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 21:52:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 09/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v6 09/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHc7LhX9RO+2pRq0U2tIIZKWA6Q3bZbWuoAgAXc6ICAAARVgIAADgKA
Date: Mon, 6 Jul 2026 21:52:56 +0000
Message-ID: <311600893ca91cea083ab4cf91587d0e033794e9.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-10-rick.p.edgecombe@intel.com>
	 <0c31fcdc-048c-4ff2-9e89-1ba112815c84@linux.intel.com>
	 <2bdcc07d98df66954b9508be537b6f6a7c9f88de.camel@intel.com>
	 <akwX9wUS_C-lc-I8@google.com>
In-Reply-To: <akwX9wUS_C-lc-I8@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW4PR11MB8267:EE_
x-ms-office365-filtering-correlation-id: 46bb4a7d-46fb-44a5-5d2f-08dedba8f045
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: EhVeQbY5v2kUp2J6PWLdTWBCS5pIIiPGiItSgeJcZqOVvYxJu4V6oVKy9TEVcL0DMhUHxjUTQ/Mx2P/C6ImE1j+iT0GpyLQgJw7mr8uod6QudnW/mxoDTifjkKlA0GXhOXHI0HejLJRsSN3ve71sJ6f10us0C/3NLCyFUEP24csmB/yWyRFe+7y3pinOKwSbBvuSmrE4IIe+19ZolHEbP2R3P2FnBNRF9ofT8RCCDwOQcF07ZPtwopNIcOMaGfw17anvHDIIRz0vMn/ArQK+l6LwjtkDLuO4qvmRAzljssIJ/T9lN1NSQbQi8DapGKn1WIVmOahMVRI3O7WMD2iwDzelwWUxa/TJTbk2vxrmd26r4Ijh4+3uluo8DZ0QWJ9XHmHUKoJdeWv2Xn+HLJJB7PJQlDlBjajEqyezPu/XbI5EY3yBWjYMHcLTFoqsFHwyDElW5jibRREVO72uyPc3orqrThK0bKlkQXvJRicNoP6EYXH76W7Nnwk1+FSwEQ0y0yK5jcmdcv41wm28DKvvKNgGdeqY1NnIw+Nwv64AZpTaxCZKWB1GAzGYZGnQzxugbgsoaMyPqwq0tkT2XvhcO6VT4tU29/BQ8yrgTC/xQKlhCbb3hK2Orz4YVW23CZggLgNsJCeOp2mXfKTHuAVlLBsESJf98+Km2IPb0SQ6uKd39+Zdn63nUTTcn/EUY6oCeMk6oCHa6EM8FoyTGVUecg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUNoVVNRUVZxa08xS3RyNWF1bnZXRy9sWHc3NTczT1drR1pON0VDbGxpcnNr?=
 =?utf-8?B?NUtFYjMvSkZwRTA3V28vNksrU3Rwc2JLT1o4Tjl0aEpIUi8vV2QxVGx5SlUv?=
 =?utf-8?B?N1NZcllidk01VnlLeXdqSDBVQ3pjZytlTEtSNWRlUnVWRnhrOHc3QjlYR3RD?=
 =?utf-8?B?THVKbC9vU1VEZjFhZE1DUDdTcTdZTGFOVFJaRWdEdW1Zdml2MUI3Sm03Qlg4?=
 =?utf-8?B?cFFVNHhFdGVEekRIRHFPTkFHMk9TTWNKMmRHNDliczJzTDF5NVVTUFNjcXgw?=
 =?utf-8?B?ZUFwZi9XdDJUSk5MRHdvOFVQSW1XZzdOVFI1REZBeVBMWXhJSnZYVnhxYjhi?=
 =?utf-8?B?Y0tSbnEvMWd6S2FRVWpVQVJRQnE4L1hiQXNGcDNJQysyV0pMbmRsKzdOc3Zt?=
 =?utf-8?B?MWo4bnA5d2hrZFJMejB5QURyc0xkam5lNlY1YTlNRVd4Yk95MmtTekh4Qksr?=
 =?utf-8?B?bUhnK1RJeklWVktpVTBRVFFwMGRudVJSY0p4amtsRllsd1cxb2V2bjZtZ1kz?=
 =?utf-8?B?OUhRd0F6VXU5MkRFanduNG5JT0srazNBaUxKOGQ3ZXdveXZwMERBY1BrNW54?=
 =?utf-8?B?WVkvSkhCREF3TTR1NG1KUjdUcWlMNThXZ3FyNW9yeGsrNlV2TFErR3IzSjJq?=
 =?utf-8?B?Y2dOSG5aSURpbWt2YVd6Ri9CWE9DNWtoN0xKb2o1MUZYMnVrU0lKVGZLN1NC?=
 =?utf-8?B?TXRPUFQ5cjdod0dzSGVxbTRSTHhjTk5hclVUbUxjWWtlQXlNU2dtNm43R2Ju?=
 =?utf-8?B?UnN6bS9aZVU1M3Q0T0NCamhWL1pJNjViVE05WlAyMHpaQVhNYWdCZHc5WnBz?=
 =?utf-8?B?eWtFSFZFK1hHM2dhNHlUbjZkU2FIbkpxNml6ck00YlZMTEYwYUxUK2ZEb05m?=
 =?utf-8?B?USswa0pWalIxWVdzWVVmWVVUUWkvUlk4VHB1YkhzRklaR3ZkQzVkV1FsS0dN?=
 =?utf-8?B?TitDN1cyQjVjUlNSdnBCSVI5ckpldE1BeXpleDF6bFJ0RVltclhrNnBvN05I?=
 =?utf-8?B?by9SWkZZSVE2bW9tY3MxcHJJMXJzM3oxd0h2RFM0SGFwQlRrdlZJY0I1R3pY?=
 =?utf-8?B?QTNFVGlqVjlFcWVQU29YblV4UlJJeGVyVzZkeFJjMTIzaG1ndjI0cHp2YVAz?=
 =?utf-8?B?ZEhhUTM3eFJqTDZPNHdnS1VnTmtDdlZQT3c1QWcyblQ0S1VvMzlndmxLSEg1?=
 =?utf-8?B?bDNOeHRUQUYzMDFJeE5zdDYxR3hBcUQ0WmE2dWtINnF6WEovQU15RzkrUk5B?=
 =?utf-8?B?TG5RSWo3K2JQQkRGcktzVlBZV05qTkpHUjloZnpyOXFieUNqaU9iSUt1VmtY?=
 =?utf-8?B?RXR6RlVTbmVCSmU4NTREcGNCNTdpUlp2Q3dMWU9DREZIc01hS3NMb1lFcUxK?=
 =?utf-8?B?REF2SUV4Qk51OEJQTE1HKzNQNVNCdXo0WTdxSENXUGpORSt1VktxYnQzTzBL?=
 =?utf-8?B?RW9GM094UUU1NjJEb2tXM25PK0s0NHVWdDNRYjRTOGJDSS85WEtwZWRFalo5?=
 =?utf-8?B?eGkxUVlkOUlKR1Bybjk0NmVmbUYvYjRYMzROcWh6T05pYXVIZUVCWmFwMFI1?=
 =?utf-8?B?WVpsZ2pPdTBCZWd4SzlMZ21TSi9HZ2lLL0xFM2hIYzhla0xPU0dKQk56bTFM?=
 =?utf-8?B?WUg2NGhwNjh3dWpobGoxbjhuRGFFOFdxQWRuRTdOWjVUKzRlUnk1bE5kTHJl?=
 =?utf-8?B?dC9Lc1lTWFJ4VzNUaVE2Yk1XSDVpZExvcmhZZDMyNE5Cc0YydzRzZFVOSjla?=
 =?utf-8?B?ZEp0TG1rR0pHMkJPQnJvZkF2alJkNThOQ0JwQ1AvY2Y0Mk5HVytqV09DL1FZ?=
 =?utf-8?B?bUk1WW12UDlJYWtZcW83Y1JNYTFRNEtLMGFyejBHWG91UnoxQmR0ekVMS0Ru?=
 =?utf-8?B?M3YySnFXRXMxQlpOUXJVbldJMjJtRXNNTk9QUEdTKzFtMmJGUWVtYVlDbzcr?=
 =?utf-8?B?bVdUbUh6N1lyRXVGQkpuNFlVU1I0RERzcTdTbTMvSVB2OE9JWUFpZlNLUFJO?=
 =?utf-8?B?a0V3YkVKY2FvekwrT1hSUFdLenBLNStPYUVJcjJjUFNTMTVqUGFyZVJCTEtZ?=
 =?utf-8?B?MjZXbkg4aVR2enFmdnZWK1Rrd1R5N1d3OERWY0ZLWG1lUUFnS3NORFZENC9N?=
 =?utf-8?B?TGRuazhQTzEyVzdHSHpGT3VEcDdETWdxNk5iZHR4WnVxeDdQdUt5OFdEc2ts?=
 =?utf-8?B?Zjgzdy9lWGJMVENrbUNhdmk5Sk43NXFvb2MwTCtDNDlPc01mUzdISUluQ0tz?=
 =?utf-8?B?Um1XTmExdmVhSWJpbUUvSFVMakVXWHVMVTNVM0JCdkMrU0xtbmR6L1hFR3Rl?=
 =?utf-8?B?SDBrdEZEMUxGMy9pTTNDZmkrdkVHQmJoYmlydWs3VEd2Z05YdjgrbTlGMklX?=
 =?utf-8?Q?WpfI9IrmTobiCB70=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8817F98874CAD4AB9932DC054366D80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: awpKOjxb+sOA5IGmpYJZGMrzD5fUveONAtVJRHxuRX2apjee7PTMCiVyDQqkLwYqkHuvVZehrtc13FMax+VfZNSE/ksRLULZ3df4gXnyJ6WsaZTLvufWH/oxsMUFTfGezYfNxhVqJUlI/QJEFTWkrTOCy9S9cGfBPniDdtUiYuvU4pY2Z8xWNcwkZvgk+Vnk/eeZcXQTyDG/+kFA0DvwLF3Kt6a5fXVOk0ynKu4xaxC9TqwD93PR7Dv8AcUybxttRSPT+s4wr+ejSNjS4GDx9ybDCWodV4j3ZEUSHnvAUz73iMIcQ7IN9yblDxKn2Mmo+9TfRbyjEe6YScmB720WCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bb4a7d-46fb-44a5-5d2f-08dedba8f045
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 21:52:56.5036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itIhyK6p+spBN2RH2Y7LYJcM4xXacz+FiUaQJhAtwCOIhEYnOqmGG/SdNzHkAFnAgKedDRSbsW5hF6XopxfVV/fz0wRidQoZG6CZ79R0GTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8267
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDE0OjAyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBIZWgsIGJlY2F1c2Ugb2YgY291cnNlIEknbSBvbW5pcG90ZW50IGFuZCBuZXZlciBt
YWtlIG1pc3Rha2VzLg0KDQpKdXN0IHVzaW5nIGZhaWxhYmxlIFNlYW4gYXMgYSB0aWUgYnJlYWtl
ci4NCg0KPiANCj4gSSBhZ3JlZSB3aXRoIHRoZSBuaXQgaW4gdGhlIHNlbnNlIHRoYXQgdGhpcyBp
c24ndCBhIGdyZWF0IHBhdHRlcm4gdG8gZW5jb3VyYWdlLA0KPiBidXQgSU1PIHRoZSByb290IG9m
IHRoZSB1Z2x5IHBhdHRlcm4gaXMgdGhlIHVzZSBvZiBrdm1fZ2V0X3J1bm5pbmdfdmNwdSgpICh3
aGljaA0KPiBpcyBzYWRseSB0aGUgbGVzc2VyIGV2aWwgaW4gdGhpcyBjYXNlKS7CoCBJLmUuIEkn
bSBub3QgdGVycmlibHkgY29uY2VybmVkIGFib3V0DQo+IHRoaXMgY29kZSBsZWFkaW5nIHRvIG1v
cmUgInByb2JsZW1zIiBpbiB0aGUgZnV0dXJlLsKgIEFuZCBJIGRvbid0IHJlYWxseSB3YW50IHRv
DQo+IGdyYWIgInRkeCIgbGF0ZXIgb24gYmVjYXVzZSB0aGF0IGRldmlhdGVzIGZyb20gdGhlIHN0
YW5kYXJkIHBhdHRlcm5zIGluIEtWTSBhbmQNCj4gaW5jb3JyZWN0bHkgc3VnZ2VzdHMgdGhlcmUg
X2lzXyBhIG5lZWQgdG8gcHJlLWNoZWNrIGZvciBhIG5vbi1OVUxMIHZDUFUuDQo+IA0KPiBBbGwg
dGhhdCBzYWlkLCB3ZSBjYW4gZ2V0IHRoZSBib3N0IG9mIGJvdGggd29yZHMgYnkgc2ltcGx5IG5v
dCBjYWNoaW5nICJ0ZHgiOw0KPiB0aGVyZSdzIG9ubHkgb25lIHVzZSBhbnl3YXlzLg0KDQpPaCB5
ZWEgZHVoLCB0aGF0J3MgYmV0dGVyLg0K
