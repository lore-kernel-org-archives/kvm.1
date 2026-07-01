Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35F1CAA65;
	Wed,  1 Jul 2026 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782868863; cv=fail; b=XrMLiZv/LfWU8B+tL05DfomWUuroWN5fCvinnYjOwgfvu2KYFvQMXAS+YZmT6S+8hWnkWQP5ctMI0XnIcJIwS5Uq50uyV4yX7Pe/xageZjpVGdE2LbUJrMcxegNYgkOzsKvighDjqTiwHwaGzjdFJJC0u5wdZETyCW8jLCWDsfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782868863; c=relaxed/simple;
	bh=Xe1EWZLcfKIySZO1S4MsDJf2bIKAa873accxiMyd7d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WlxPLUD27VCxFM42u/NuiUMNHXhcN7vwPeERwbCPrlGnmE3cFvLDcKEbDUGFMKoDE3VG9i44hV9/2nr2QKgSHuDFSoxg7QLQalW2TDLgvPfJGNGMZBHRKxEl3LBZxXZrtmS2kZ3z0gQq6EPWuRIWg5r9JKSAsFiZCeaFBPhd7KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/OwYhKP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/OwYhKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782868861; x=1814404861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Xe1EWZLcfKIySZO1S4MsDJf2bIKAa873accxiMyd7d0=;
  b=b/OwYhKP+UYfjzgH9jYlah1UIjoxE4IpoULSAmm8ctpVeeIlXdSVom5D
   JsQCkaB/f6pUEpqZ2D6OfRh8ELu87kOye5iVSdbMUiu3RI68OAPfrHLIq
   7vHg4LmtgrW1ZNHEcp+hIht28bkxr/dZPZBdOqcfri9Fr7y9wa+TW6MZB
   envSxYcYsZtmwYytP0d4IzUdGFUj1b+GogXo1M7a/FX0iRhQ1yM4ETTo1
   3pF1ajo/IWS0uywqhuxKzTXPZwLbFe5KdCRvp6zhkeijPyOE9mGJNco05
   /BnJS+hDSDahxcJ/ck9f7oIDZYEsbXakcn9W0YiGswwfjJ3qKOfMGequj
   g==;
X-CSE-ConnectionGUID: UmKQdbxVR2+N8p1dotjR4A==
X-CSE-MsgGUID: htrSwJFSRvqgnyZOmQW5Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82580876"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="82580876"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 18:21:00 -0700
X-CSE-ConnectionGUID: UPqgJvVeTJCLDDZS1OuXSg==
X-CSE-MsgGUID: egNTaVTPSGuJkY1VYIemqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="254344577"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 18:21:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 18:20:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 18:20:59 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 18:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXw2NsBgnOLiB83bJygX9f7HYRMkdP4go4QXqztHMsLmCqkGkJdX4opGmdfF23A3rxl1F7tAjb11ObRBYV3RfjMwgK/LdZ0kuAWTUm/MS3MVsQT+5tFEWDaFQ4RMUByfDmoUzoTZORZijbw3iriTVbP6ZHTwKtG/xVtLRUSdOCdwTFe3sNItFbRn30M7XUU4Fx4eJ2JxXiRaZLi5opjQSLwYUiCl9vLBP2AxGVv8CTIUSTxU2nbyVEogjfmox7M5k4qNr8Rg4lud10AMpQIOJZfUgG8d0wNxxWTIfSkGmJhJ5ZGEeGoi16MxPctMRXxDGUQ/QP1uiq2sz6cODAXNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe1EWZLcfKIySZO1S4MsDJf2bIKAa873accxiMyd7d0=;
 b=YRcEuoWa24TtHAeTpdY2aEpouo8tFxUmWBHGJ0FWSyF2q/+jWPQT/uIHRM6NY2GYuvmKrZTsYukjtfw2Ab7mDXb+Q393HzWNGlkEBb3eEVKRkXIiHc3WpLYDTMbiLXXps8t9jD91EztjCuvNRxK5JRnJneS6eOuV4gktxt+sNBlbBpkrwBFF8gTbrAPFBO2RvVTrEKQ0fb2SyIFhyB4h48x3ZJ1G4YoTqvHSUPzkHV8tCEQXpVtuoGcM72GN7R/ifSuXTly9Cx87TG7DnunGMy9UW2LA63Nxdrc/EXfqGAbDl+v9XDUOkdurEKv8CIgFPJGsre9v3On0YKS/DWOGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by PH3PPFA3FE8A23F.namprd11.prod.outlook.com (2603:10b6:518:1::d3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 1 Jul
 2026 01:20:55 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 01:20:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 10/11] x86/virt/tdx: Enable Dynamic PAMT
Thread-Topic: [PATCH v6 10/11] x86/virt/tdx: Enable Dynamic PAMT
Thread-Index: AQHc7LhTN6Vy5fBwVk+k2LlkQg5tWrYusbWAgADMaICAKJgqgA==
Date: Wed, 1 Jul 2026 01:20:55 +0000
Message-ID: <6d87002a7484cd44687c78d60319bea283a78562.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-11-rick.p.edgecombe@intel.com>
	 <aiGyIQvudD5ZF3lf@thinkstation> <aiJd4XTToKX20j/R@intel.com>
In-Reply-To: <aiJd4XTToKX20j/R@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|PH3PPFA3FE8A23F:EE_
x-ms-office365-filtering-correlation-id: 5e483dea-72cf-474b-5f45-08ded70effc0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|38070700021|22082099003|18002099003|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info: 0G59+nZQKw5MvMRHtccy9u32nrC8MrlqmZGjXN889vdH+Bmz94ILxs2Gzg50CwoVDxlsuAWlApmXspLWH4tfoSItyegpZshFY6rBrFo3hoNWdmqxkFRkICqTae36yKSJsaXCtb+dATPgrese9fdh+wiGV7k7BPIxUfVrR3wFc1PRQYT/WVvRf6Y01WKe7aYQiy72irDcudJTMtTKdhhDC5pfv5s3BNYuQisVLhukDy/KhJYQ8q7lrn2oUuT0u4TL9gipCyq6OY6XqbYSirMvKKIgnxZlAFQhSAkgMxlGfl8XQobZb9abbI7YvmvSm2xxhWZEnEjj85o/MmFBFQj7f3IgdkLzjzjhQZ64wTE3nS68KMdJdyasM/cjzWOWyA9p39I6QMj7Vq6ddFvG3aTqYtjM3mAJwwtulImuhGZxZ0K3/i+IXurjoYNkCZSUi2AhqjjEqvde5kCNEfY1fKEvEkHee+CXRx4zO079OGPYT2iwTixbHOv21oMtELW9O8aQFKBs0mIjTjjpfGEQh4emk226CUdW8ZfK2u0QAK3tnueN0fcIxIYngOF0vhHHq99LnN6hRGHOv0JXF0ZJbiEQnRvtdNnqkReSIdk5Vlgs4uo/TUgH5EcSJ+qUaaolhAUZrMM5xlSkIbDlN+ezuSxc6QQi6tSr7+78Oi+SskgqniGggIDgc2sNpWBTm0E+rSn05pk3KDCkDaFo52AhGPnCNGMNktSS4IwDz8xu5A1a+Ag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(38070700021)(22082099003)(18002099003)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUVndFc2dHl6SndmeU9zWjZMR3J2amtzbkd4L1NDNVdCTUFUclFBWlVEdUhG?=
 =?utf-8?B?MW9kbkNRTURoOC9OSFJYVDVwK0FCZkROb1hKN3FXeUtkZ25YYkZwUjYxd0NS?=
 =?utf-8?B?aldlNDByVTl4VTVwMmpwUlMrZXR5Q0lVYkZTK0t2MFJrN0h1RDRVenFyd0ZQ?=
 =?utf-8?B?TS8ybEpXbW80d1hiaERYc0ZSSk1NODYrM28xYUdYNDVTQjM5Rmd5anBDNG5J?=
 =?utf-8?B?LzYzaWZGVkplSkpLeDEwZHplWDFrU3R5VWF4cGJHdkU1VVVXVHNhcWV0c2Qr?=
 =?utf-8?B?RVQvaXFjbTFwcnRzVHZycDFYNHVnQjk1UFEwbHpBVTl5NDBLY3pFOGdqajEw?=
 =?utf-8?B?cjVmYjVLWmFTaWZndUtyVm9URWdiMjh5TFBnSTFIRUFEZGhZRWFqRC9Jb3Vz?=
 =?utf-8?B?V0xtY05ObWJoaktIRUxPaXhWcXkvOU02SWlDeWU4THgzNzVFOEV3WlBIZXVO?=
 =?utf-8?B?WUJOb3BrL09TRlNyalFlYmVrcDZrd0NyRlU4Q01ieGJtbm1OOTl6RUlUMDFI?=
 =?utf-8?B?VGU2OUZpRStvZzlqSDVHaHdWS1BJOGJZOGNtc1cyZzdHVWx2VXNxRE1LamlU?=
 =?utf-8?B?dzhyUmtxUGo5Q3FDZ0hTb292L1B2a1pacFMrdkRKNkg1dTk5dm9iNjFvWE95?=
 =?utf-8?B?bjAyTXZsdGZxMFFjczRkTkR0bmJyOXRoK2NGamVVMWxBTU50Mm03eW40bWp2?=
 =?utf-8?B?dkVYMmdJazJsK09IeVdQQXpzT3o2QnZza1hBS2pHbVllRHliOEdJdHBkSVE4?=
 =?utf-8?B?Y0FmdHpCd0htTm5QbG1nZ1g0QUtuY0JuVCtrODMxWENCQ1EzUm9MNFl5WkRr?=
 =?utf-8?B?N3AyeTFwWCtHT1JGZ2luZDhCQjNTTFVYRWlvbVBGTjk1KytUNDI0bHo3dlRC?=
 =?utf-8?B?Qi83ekRLOVF4WVhuNlpjU1EzMlFzU2FuUWlPUEpRN081LzNqdUJWUnRtdEFy?=
 =?utf-8?B?SEZoTnNHR0RUUkFvNUZMQWFFU3d6ZlhtcEVRZWd6SEFPd0FFL01YV1A3ZS9I?=
 =?utf-8?B?TE40OVgvcjhZUmlzU0E4Zy8zRFJaR2gybWpRLy9UM0RpSXZHalhqTm91NEcx?=
 =?utf-8?B?OGh3MDJUQ2wwQlMxeElzb092SDFIZjhVN3UxYlQwUC9KaFphb1FTMFhDb3Fj?=
 =?utf-8?B?SU1hd3I4WkNUaEgwWmx5Rmx3dkRiZ2cxSTBiMmJYWDQ2YnA2bDVqRXR3WEhT?=
 =?utf-8?B?bmhYRVQ0MHhDQ05qYUN3dzFxYmROaXRRSnl0NU9IWTRQMjkwalZJdE01VDVO?=
 =?utf-8?B?R1l6U1BnQmhwc3E4TS9jcEpXWnVlN3Q3ektxSC8rQjlmdEw2bEFXY3lheFlI?=
 =?utf-8?B?VDhzQ3BFNDdHMGZXWnUxQ25US1ByVUtxMm5Lem9TUjZRUVdEV1BqZ1RnU04z?=
 =?utf-8?B?L2YzRFpiUzIrYVBETFVnNzg4OGMrL09QUmJyOTFodnhLdk5TeThUWnJXZDM2?=
 =?utf-8?B?dzZkaHVjaVpoZkFQTERIdHB5OUM4TkcwK1hKOFFldGsxVmtjdDUzbGY3a296?=
 =?utf-8?B?N3lCSFd2RllLck1LOGk3NWJ2K1I4NEM3MmRFUlZkejUrMjNiRkJYTmMvRFJz?=
 =?utf-8?B?YjJ5T0o2YnE5WTJqS2Z1c3N5NnIxejZIUFBZN1k5QzVnM3V3cWR5UDVSNlNv?=
 =?utf-8?B?anRUOWQ2Ti9wM3M4Rytpak8wZ2NoQS9VMUo2WDlPZUNTQkMxN0JHZVRJdkd1?=
 =?utf-8?B?TldJeEhTSEdhSjgyZFZvM1hOUUZYdFlCR3h3VmhiVXgzd0U2VWRpVHFRejl5?=
 =?utf-8?B?TVhEZTY1aTBYTHJWbnJEYUZNSmlaTlVZOUw1L2lVaUROZVZXNW1VOUtUTis1?=
 =?utf-8?B?ZjAzVFFpelk4cU5hVGZyWkJEbFJUakRzQVRaVXZOdmRrU2ltbm55MnplTVli?=
 =?utf-8?B?MzgwMUY2eTFQcFpPR3JlQzNpbjJqUDJwY2pqKzl2QnlGbzlrSWVWbDVRQzU4?=
 =?utf-8?B?MksxYkVRdkxMR2sybk9MdHpYcTd0T0JWc0xkUUxQNTNTMkxCTWdiT2JKOHFC?=
 =?utf-8?B?NjIvWEY5WnkvN2dxVG9kUGxqL1ZqeUMwOWJLd0VGUXBRT1duTmxrVURyMERN?=
 =?utf-8?B?YWxVL2pjR3pmbmlJWHhRN0U5dFZNeWdNK2VGeEVFdmQ5TENHMFRXcFo2S2Jn?=
 =?utf-8?B?UnQzczBtSXVVVWpCUmFjWEkyVUt1MUQyRFoybDgvTXlOWkN5cnc3NTdKN3VY?=
 =?utf-8?B?U3dpc1RTdWJhRjVDNXE3MHpiV0JBVHcwRUsvOFhEU3dhajJqN2R1dE5qcXVF?=
 =?utf-8?B?NlhtWjZKUGUwRDFOVUVlVEVDL21XYldwTG5MWXA0czFHSFRhZ2RuNUZVVC9B?=
 =?utf-8?B?cTM2S0dscmdFMGQweXVCb1NqcXhoZ254VFNwZmRsNkVOazg3RFR3bVpoZW05?=
 =?utf-8?Q?eEPakYLnV/Y0gMes=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDE9C7F889309847B85B8A7996B4CEA8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oWPGHWZQF+HRQORpLjSjqChhj5IYZdh1NawxFREA8uSbbUbsTSnUvazamS4SIHleAZObzoL3gyUBzOvGIV+PFZWE8ZmgZ7E+kVt5xkIEup7+JyRrgXLtWPo8Fc6lQBpXGNOJLTOAq6eFG0aREO3+1kfumXMScir+p6bNBK/3aO//DnqsVU8UJCIK7NG9O1vxXPawcA36rK4i3h6aa3p/XpSI71cfoCkN1oz8izB0tAjrgYRz3sFe0Tzy95AuQNnAZqID2t//4NpbKv+oFMF4sUqA+fiH1tx+WrJP52cFeS2ndJwmFyV02ljSAMfn7HuJiU0VMJEWnbl2/is/mYAAIA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e483dea-72cf-474b-5f45-08ded70effc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 01:20:55.3339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lL7sGfO1l6Tkp73ny8lCS7dnjXhi0wDfDnsCKM1RRUTc4W/2rbIhik0Pc5IHI6hsBFz7ZbJHanYW2ztpRYclKRxdeIGSjH0pelJvAkECis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFA3FE8A23F
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDEzOjI1ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT24g
VGh1LCBKdW4gMDQsIDIwMjYgYXQgMDY6MTQ6MTdQTSArMDEwMCwgS2lyeWwgU2h1dHNlbWF1IHdy
b3RlOg0KPiA+IE9uIE1vbiwgTWF5IDI1LCAyMDI2IGF0IDA3OjM1OjE0UE0gLTA3MDAsIFJpY2sg
RWRnZWNvbWJlIHdyb3RlOg0KPiA+ID4gQEAgLTE1Miw3ICsxNTYsMTIgQEAgY29uc3Qgc3RydWN0
IHRkeF9zeXNfaW5mbyAqdGR4X2dldF9zeXNpbmZvKHZvaWQpOw0KPiA+ID4gwqAgDQo+ID4gPiDC
oCBzdGF0aWMgaW5saW5lIGJvb2wgdGR4X3N1cHBvcnRzX2R5bmFtaWNfcGFtdChjb25zdCBzdHJ1
Y3QgdGR4X3N5c19pbmZvICpzeXNpbmZvKQ0KPiA+ID4gwqAgew0KPiA+ID4gLQlyZXR1cm4gZmFs
c2U7IC8qIFRvIGJlIGVuYWJsZWQgd2hlbiBrZXJuZWwgaXMgcmVhZHkgKi8NCj4gPiA+ICsJLyoN
Cj4gPiA+ICsJICogVGhlIFREWCBNb2R1bGUncyBpbnRlcm5hbCBEeW5hbWljIFBBTVQgdHJlZSBz
dHJ1Y3R1cmUgY2FuJ3QNCj4gPiA+ICsJICogaGFuZGxlIHBoeXNpY2FsIGFkZHJlc3NlcyB3aXRo
IG1vcmUgdGhhbiA0OCBiaXRzLg0KPiA+ID4gKwkgKi8NCj4gPiA+ICsJcmV0dXJuIHN5c2luZm8t
PmZlYXR1cmVzLnRkeF9mZWF0dXJlczAgJiBURFhfRkVBVFVSRVMwX0RZTkFNSUNfUEFNVCAmJg0K
PiA+ID4gKwnCoMKgwqDCoMKgwqAgYm9vdF9jcHVfZGF0YS54ODZfcGh5c19iaXRzIDw9IDQ4Ow0K
PiA+IA0KPiA+IFNob3VsZCB3ZSB3YXJuIGZvciA+NDg/DQo+IA0KPiBNYXliZSB3ZSBzaG91bGQg
ZHJvcCB0aGlzIGNoZWNrLiBJZiB0aGUgVERYIG1vZHVsZSBjYW5ub3QgaGFuZGxlIHRoYXQgY2Fz
ZSwNCj4gYWR2ZXJ0aXNpbmcgVERYX0ZFQVRVUkVTMF9EWU5BTUlDX1BBTVQgaXMgYSBidWcgYW5k
IHNob3VsZCBiZSBmaXhlZCBieSB0aGUNCj4gbW9kdWxlLg0KDQpJIHRvdGFsbHkgYWdyZWUgdGhp
cyBpcyBhbiBhd2t3YXJkIHRoaW5nIHRvIG1ha2UgdGhlIFZNTSBjaGVjay4gQnV0IEkgdGhpbmsN
CnRkeF9mZWF0dXJlczAgaXMgbm9ybWFsbHkgYWJvdXQgd2hhdCB0aGUgKlREWCBNb2R1bGUqIHN1
cHBvcnRzPyBXaGVuIHRoaXMgaXMNCmtpbmQgb2YgYSB2YWxpZCBjb25maWd1cmF0aW9uIGNoZWNr
LiBUaGUgdXNlciBjYW4gY29uZmlndXJlIGVub3VnaCBrZXlpZHMgdG8NCm1ha2UgRHluYW1pYyBQ
QU1UIHdvcmthYmxlLg0KDQpMb29raW5nLi4uIEFjdHVhbGx5IHRoZXJlIGFyZSBzb21lIGR5bmFt
aWMgc3VwcG9ydGVkIG9uZXMuIE9rLCBJJ2xsIGFzay4NCg==
