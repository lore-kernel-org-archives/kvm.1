Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E686313E38;
	Thu,  1 Oct 2026 00:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814741; cv=fail; b=bIxKUZQCMUQrszFF2zMd0BnRkLqGmwCHWOGKuSmIYn1NXIJBd8pGe4MDH6ISQensYKv9al+VjEFacex3lM8NS+pyPduOCtmSqYb7xAbascsavDwmZKUskJmiG63+20qWwmHKRi1yVWCb1YYgurhDU1HFosji9mz2UsrH/WbZxSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814741; c=relaxed/simple;
	bh=Q+pRmEFKAGFNqYK7wbvoDpMQMgnvUTa7akte0DvKAvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xff3qMk/FSPGHDGKxh3coJ8vIQpUR7OMyAxIz26KvPNKKZoqBgLEAj5Gu+NQR4iTzW/ntLc9cqajTVOfq71tkUrvP+uOz4o6vJlBQlQDZ8z6FjPkiaJJKJXxJ8b55PMG20gcyGBJQHc9kphx+3qyCOv6+AFqSWWcaX8X9kmAvgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzPltKif; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzPltKif"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790814735; x=1822350735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q+pRmEFKAGFNqYK7wbvoDpMQMgnvUTa7akte0DvKAvY=;
  b=AzPltKif6bYldprexp+KkLAE7FnhiaAykzp4bOfrV6p66aBzKebz5JFB
   h8jBR7uEJO3NHROioSFalENl8mCcMgsGg2hyAZ/FZQaxst7j+G90m5Eef
   b5ohGpm65C65dtKqceHokTsohXVIyE6agKGxkkv+dTbh15aoq+G0Xe2ip
   xAHlLeiol7kfir9d1Th6ExABWMXsMuwHqg4SEmaCNr8cprxnmJGwZ7ZCx
   SjEoLtWjOvlLPIgcFeve+r7mlrqqgoAiVgArenLU/E9q1FHYhqM8KDUJm
   u4m5LW1h4mvPrO63/Vqz10BW2R+R6feRiZnu8kM2nIjDFLq5EGfOVdYMV
   g==;
X-CSE-ConnectionGUID: i90Y0RreRn+ikQ8WcuU/ZA==
X-CSE-MsgGUID: ndGusJBQT8+N7YKL+j+3xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94279711"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94279711"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:10 -0700
X-CSE-ConnectionGUID: e3Z8fOQOSXev50LZaYy4bw==
X-CSE-MsgGUID: SbAS2nCFRwWMlXhnNusCNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="279142712"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 17:32:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 17:32:09 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 17:32:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD4Udr+o88hF1HR6Ve+cFX9oO3q7iLvMlyPoyNq7JRvUET1KMbTGXhtGv45fGyWyRvZ0e24aaxR0xPazy5rCVae0TlZcy52p8tBNmGvU9VSRW6kYkdwrWuuIyMpOKAplPSYWO08u5wPb1bm//Q+4gRi+AlwRbTgCADTi2KYmuupJ32Y6lI6NnN+4HtqouykHsKWJnLJmhog+xXY4Z0Ahp0zrQWjNxtgtyAmODKMfOFSknm7NjOM3QXVVPQ7LEB8BoaHQp+m9VOgi8ovJiPIxZk9R2UJjJpELZoNNsQA/R3Y+R4lubLG3at0Iv/T3QYifuBC2f5Dh3liVrbvioYiMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+pRmEFKAGFNqYK7wbvoDpMQMgnvUTa7akte0DvKAvY=;
 b=eNvQUfBzg0Pq9EjxZqTfVIYmFT0mxffcXnfzUgFG0DyRKCi7S0uB6a8AP90gVyW0Avsc5NV/BYlwDXYmbTAE7ucWEI/JPrY9A/bMc3dEw6KyjUWFl2F/1aDiOSvbmDQ6C8Qm4pdgtaDpok/g3zzx5xV6KiZuOVxhHkIltk5QYjtnMDtmciiy1w23DkHSxGA7nMi8Nrxluvr3oECTM+nwPhNsW03FpdVacKU6lVfWsAw0i406+o03jOL1YzOZ4JQx0sUaEeUi85SjJly288DEgdji9iJeJtpYzgit5qO3SH+QKsZ6whGzeG5RgeJvrJ/pr/TrsUclz6kLOK68hA/Kxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 00:31:34 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 00:31:34 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 06/10] x86/virt/tdx: Convert the handoff metadata
 reader
Thread-Topic: [PATCH v3 06/10] x86/virt/tdx: Convert the handoff metadata
 reader
Thread-Index: AQHdUJ5PwEDe+ArCe0qvDWAP0yuUbLbn1y6A
Date: Thu, 1 Oct 2026 00:31:34 +0000
Message-ID: <7b4eec441ce289516888b32c0fd3a9407f87eece.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-7-chao.gao@intel.com>
In-Reply-To: <20260930053901.22528-7-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: e00dd7ca-7022-4ec7-dae2-08df1f5358dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: +MsM6GvvUCD1R2sYSwWo5amWKjtDgcSchvM7KRrjH0g2PLdcuAyFIfYI4hzP+FDAqo8BxUW/DITlSVq+HPdbJWPQsd1V5xs9Amhy2lEr69KoTmCxTWBeencIjCre9kPjL+PWY5KH53J6kR8JdVreQRLWWWusL/F/dI9CgXmllO7YLS5fMN660P4uoP2qkhiBZFnnyrshxOHiEEx3+1Ta8sFo8DQ5YoozTOQ32OSm66J8/Om/E++OoTP7db5nfwUTY0+cIHHT0N5V0u0XH6nKAQvoiR95YBlCOZe4rkxtL73mYgERdIgbS8474XI2It3kSW/m2h06F6LGhSEclV5N49mlIwOtRQY1cqdf0sv2jDY7hJ1FSpfL65C/tmBjkabGVxHg5t+LvFLNfVejdFJWSSonUQ8q+85zKCF3dyzl02VqLL3X0UNfJgBk+lZPM/56BVV2VKhHl/m3Wyn51aS1SaZ3g2UN2Kq0qh08NqduhFkWfoTy+Sx48/7GiLpxM9cQhfhIMHIpd9XgABUk+GLmfz4yPvbYDx8mLxs4DirmUdTZE6ONKR9uuJ7fNdmU26HABdFVd3RwfHX2P/jZKJBdte2LogZGl4/6XekwgDnse0Y74ljFaLkLyNAxfaIlj1Rp24ocw0fhS8fmTiqxKM0kuQtmFaMiU/2yGY7HWgCfT5WSWW7ZfwySZKFqVsLYlyw+sxOSiTiNt5y9ehc8biCL7XDjy5U8+32LrVAvThUusqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L21PS1ZmbmlJbmtLS3k0Y1NSTG9aTHEwbERablJFdVBtZ2Frc2kxdkpObW9C?=
 =?utf-8?B?OUUvUkNCdU5FU0pGWktKakwrdWNTKytzajJUYWJrL3VBWFFiYWdpbnlNNzht?=
 =?utf-8?B?cm02UlV1a1BYQkR2VDdrR1BNR3NhTGNhbTBFaGFBU3FsZHQ4RTFWWmd0dEoz?=
 =?utf-8?B?cExlZUdmbU9OblZaMFJEU20xY0hNd1U4d1ZxTWo2SUc2MXBTV3JHUWJVVi9s?=
 =?utf-8?B?aXpiUU1LaXF6Z2ZqQmd3ZVVidWZiVk5xMzJsbCticURpV3IybVZDbHFqYzR6?=
 =?utf-8?B?b1BMU1VVM2k4QUEyTXV3UFBwN3V5ZVcrMDBzS1VDVGtvTnhRUXZqbTl3S2l2?=
 =?utf-8?B?aERmSjV4ZEZ6Q282bWtzeXRndHdXMWRvNG04dEhya0V2ZzlZN0JRTXVrd1pm?=
 =?utf-8?B?L3VjK3l1Nk8yZXNHU1lhdGNUdGx4b1llSTBYN3oxVFNWWWRVaE03Sjd3eHpv?=
 =?utf-8?B?OG9vL2U0VXd4M2xJcVpzYWgwVmRtWk9WQk5sM2g3Vi9Fbk9LMFhFTFkwY1Bp?=
 =?utf-8?B?c1p2Q3Z3R1dhcDJoOE5Ra0c4Mk5md3JlNlltOUQxWDJDZXV2WlE4RmQ0WURo?=
 =?utf-8?B?TG8rbEJxZ20vK2pqODc1MUFjOWJ2dXYwRFo3TVpHc0ZHdkFvb0I1SGdnUDBV?=
 =?utf-8?B?V3VQK2VPTlNSOG91akFCRlRKcXVsNkZsOEkxR01zdlBjVWJtTVoybG1MTTl2?=
 =?utf-8?B?TjBLenhEYjVhV1N2Z0pnNnBSNmR1ZGlYNTZVc0FZRFBPbEpXY2Q2dTA0bDlD?=
 =?utf-8?B?WE9sdkZlQnhYL2F6WHliMjhkc291Vm5VQUM2aUJBZ29OQjdQbXVzNFFxQ1JT?=
 =?utf-8?B?OU9qbVJ5a0hOV3hYVW8zV1g1Ry9QTjZjZTdObndyV2hLUVJuRGNna3QreUhO?=
 =?utf-8?B?QXM5SUhwbW12UnR1cjZXalp6UFljWmdSTlBGaFdaZDRLeUVuVTFPZUt6UmxO?=
 =?utf-8?B?UFUvbEZUZ0lKSHV2MjR5cmFoZFExVmZ4N3RxTXpScitNdmVINVBNOHREUkVP?=
 =?utf-8?B?ZFdRYVArS2VBRGNLZE5TMytDem9wWW8yK2tJU1JLWENXUHpwUE1jR25rRnA5?=
 =?utf-8?B?YnhPQnVCa2FsZ1pjRzVUaWlGMmxwV2tDTFdFU2hZU0t3OFNEWjFhdys3SCsw?=
 =?utf-8?B?MHIzTmtmNXkvL05MMktZSTR5SU1Oc3FnN1lOaEVSREdpM1dwdEN4SW9BNHRY?=
 =?utf-8?B?RkRlbERHV3ZrOURVQkhDQlI3bWpvL082Z2FaWVhiRjhPSmxhd0tVMnRoQnd1?=
 =?utf-8?B?K3NEekQ1TzZ0OHl4RTRDdzVHVVB6V3MxSGZWVStkV0MvcEhRalV6andNbFZo?=
 =?utf-8?B?V1pXMHpxQ25SVFppb3FXMVhaK3ZPNTlPUHI3d29XaisvRkozWFlkTUpiUUVO?=
 =?utf-8?B?RStxcENtSGZoOERUUHRCUGo0SXkwNS9JKy91RUhVWFBDd2haK0luWktaMHF5?=
 =?utf-8?B?OG9SWWdXb3B6Wk9mQ3hDWlVhL1NvRGVPMGJBbldkSmRYWUVhajZVREJ4NXRl?=
 =?utf-8?B?MVJhbElJRnQ1Y2ZUbnNuQ2srK2hlcUZKSGsxU2JaaVVaNEJlUmpPME1FWHY3?=
 =?utf-8?B?VDB5bDducjg4Ky9zbmJzczBPYXdxYWxGN2YyVEFlOFhQSUI1Nms2OFlCalpm?=
 =?utf-8?B?b3F6UDBjZ1cxN1Z1UEYrdmZpS09SaFJEcUhuRjA5RE03ekMrWGJwTTVialhk?=
 =?utf-8?B?dGhGVWVaZWNDMWVWbXNtTTB4Si9pMmlEWGpSWHo4Ly9zZ0x4TVpGeUU4QzBH?=
 =?utf-8?B?b2VQNmlkakJOY1QvUHZ2cVkyMzEvNlp2VUJRbC9pbFJPR1ZnV2R1bHNWYldp?=
 =?utf-8?B?Z05GS2RPSnpNdWsycitOMk5TWXNvVXJzdnJrMXI2NUQ0bU9RKytxcXpkQkpP?=
 =?utf-8?B?TkpWT0VHaVR1ZmMxemRNTFI0MVY4cVpnZ01CSTNTYW1WM3F2UkdtM05YdTFP?=
 =?utf-8?B?cmRDTHM1d0xmMnQrMnRXMWwzVjZrbGwrT0doN2NpdHcyWWxWMmpuZzdncW9R?=
 =?utf-8?B?L1NxWDI3aVpreXUwRWhtNUpSbUtiTmZyMEdORVdiUXlwbnp6YUtieGZZSTNQ?=
 =?utf-8?B?Z3hVRGxTaHZTR0hoMzFhWk0vc3M1MjFyOXl1SmFDMEtGMzhPbWlNTmdtUEtv?=
 =?utf-8?B?UERTUUdzaDJabXYrdml4aFFUME5ES0xtWm9ocm02cjEwTWR0RnhvcmR6b1Vs?=
 =?utf-8?B?Z3FrWXViL2JLMEZtbDFiODBld2FsdUFleXkyMWRjOGV2eEE3VStxVnZ0V1pV?=
 =?utf-8?B?UFU1cTdXbHlxQTFydEhpbDVXMWVUaE9oa2dBcUwwMW45bGhZdmpCRllVTlQ4?=
 =?utf-8?B?UGdhRjJMamtYNEdIOHVqckY2OVJtQ1ZISm52QStMYnJZVjhFSmdzYlllZGZN?=
 =?utf-8?Q?VTFml77EPaSZBHDM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF8E9B27C4885D4997FBE4C27A6D3D66@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1lwUtWaOCgGgEC2mgsIR2sgtThPNaClzY+M3h94TBFVnjKEeBOB70ZPAJXMKL7RK9xuMiCSlXI5uoWEtaWDl21G8BEwIZKo6j0S8Gr+kuktK81rOK6uARt0pKLyUpuuB6zMnLymYPbnGgmL3gmyLIL6NIb3tKQ07ocWhD9wyYkpQ6p/X8P6KtoZCjHRK7izmriYFPAXC0czIhz1VKI75EKpyNptom09ei5Nr/bOIdF728dIIGsK1kHUDBr5ialk/HeVwa/eOfONwHVObNZ12VMdk6FyK5S5EKiDGzYDy6k6uWCeEZ0Ii6jcF3IAvuhJepc7EZew9QfgEGkmSyraZGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00dd7ca-7022-4ec7-dae2-08df1f5358dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 00:31:34.2899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5qD1qBc4aHKOiQwkZH7WoVV2nuNjHsmpZ8HoDpwwip6g1rnCWyMfe73l8DP1ZO2My/HPR8+vNLy4fA6Xz0WUseMxYux/OUomGX25P5oYJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDIyOjM4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQ29u
dGludWUgY29udmVydGluZyB0aGUgbWV0YWRhdGEgcmVhZGVycyB0byB0aGUgdGFibGUtZHJpdmVu
IGhlbHBlci4NCj4gDQo+IEFkZCBhIHRhYmxlIHRoYXQgcGFpcnMgZWFjaCBmaWVsZCBJRCB3aXRo
IHRoZSAnc3RydWN0DQo+IHRkeF9zeXNfaW5mb19oYW5kb2ZmJyBtZW1iZXIgdGhhdCBob2xkcyBp
dHMgdmFsdWUsIGFuZCByZWFkIGFsbCBmaWVsZHMgYnkNCj4gd2Fsa2luZyB0aGF0IHRhYmxlLg0K
PiANCj4gQUkgd2FzIHVzZWQgdW5kZXIgc3VwZXJ2aXNpb24gdG8gcmV2aWV3IGNvZGUgYW5kIHdv
cmtzaG9wIGxvZ3MNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYW8gR2FvIDxjaGFvLmdhb0BpbnRl
bC5jb20+DQo+IC0tLQ0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNv
bWJlQGludGVsLmNvbT4NCg==
