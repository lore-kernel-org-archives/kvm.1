Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52F40B103;
	Wed,  5 Aug 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924369; cv=fail; b=Xncoh0ArP6H4KFl9dY19izgAHhKiPyEQTH0bMrCcmewptqZyJbcxfaSZq/mQEm6kfn1E7ck4eE9P/Pwf2R4eK148DfMnEFoKkaVf2YvudIXeNFB2D4ZYRNdaeqhI/0IZNC12dxbd8FEzsxeigDFd+t62Kwv45XDmV2ivrd+v+Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924369; c=relaxed/simple;
	bh=ftD7rz8n4B8+dVWq1UFJ3OYxUgCkdcDwitOJYlk+378=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QvhKcp/pHdm71qoVKeuXagVujiqw+CQPgIdavmbBXTH3jSUU21CpIaF4IhH01aZPOtZpHGFg4W1kL1fSdFLFMusS7e2TDNnzr7YsHZGCcV8TbZtYdy0TUbmUamdATcCC1fcXq+cIeqx+5ZHl/A23blSG1mE4l/yfcd4qXRD4Ads=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgoPl3r5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgoPl3r5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785924368; x=1817460368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ftD7rz8n4B8+dVWq1UFJ3OYxUgCkdcDwitOJYlk+378=;
  b=FgoPl3r5N1noiL6xZru2/kYF9pCsXTo2EOUi4kFTDbDUWGHHsVJ+tJmW
   843YA9VdSsFycy/1QOIZMpVaW1NbBSrfdRvhcsisvbwcb8usuRY+C+am+
   dEwMqXUaA7V4sEr0/iNb3mQ1S26LVkyHZOJ57ICciJmUQ0ybm4Ak0Qlso
   Px1deyy4Q6+ONGFWokSWR4qjgaN12gFgAH0HtK0OAKFQIkurkXgsZUdxw
   KiPVHGZ6igCr8+tNZFNwMyd6ECqf0QOyQTInLSiUdTKMHYc6Fs+uyZWfK
   Km+Ip1wFC1J3pBTlXK58iy952KapY4LxKxd4RDcQc3mZJgulfsjCDGbDB
   A==;
X-CSE-ConnectionGUID: 7hhAypj5TRGV9Dq2+XdqEg==
X-CSE-MsgGUID: DT/6+EnVQrKcuSTXMbpW8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86523357"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86523357"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:06:04 -0700
X-CSE-ConnectionGUID: kXt1Y08RQKGhIPZzQzH2yQ==
X-CSE-MsgGUID: gK1DdNpKQSeWBzpX579FiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="257456234"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:34:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 02:34:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 02:34:41 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 02:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aO+tywx85eeaQ+I0lel3xfuoICxn4Tp/cmdxAg1HXOA7L0EnB544I/+19J3tUwZbpDLocxiFgL1d6ogEBIPVlozfIG77GGQy2Zs2fvjA1LTBfqPvTvL+Nrj56VszV36lPbm13UZ7hIK3SWeXO7F9PGZ9HY6oAxteAck702VrRtdiL4HbEQrUoiYeGlnm/X7WpfscTW/yKl2IwX4Fn46H6w+RGhsPaVXKMKjSfUgI+KpfANoKKczRsXW0ZZrpDcn78GX1uzUWHIneONXE6XfpI2DDaYCTonELuYB+tN2/LogEzMKZ+jgE3xyIP5MCiT2GuRS6NkUUAh4WPy5SRuTvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftD7rz8n4B8+dVWq1UFJ3OYxUgCkdcDwitOJYlk+378=;
 b=rgrxwSBUMVwKaaqPmB4KAFuQ2hK3GdTPhdFDXI3mWMkyLCe+HrjAPsjBsjdWkHaNyNisPFxlgBDeEFlmMzOSxbRq9qO5dgSI3Pjc8jirW+pbWfFbjXTbWkVGCjxkq3Ozh7IOyKuw4OTzRSqaDgbulFE4k9nYiMRwjlzpGeQESftIk0mYzWtYKSNVn6lCgm24fe2s5R+2c+ARye5yGPOwMi55cT0NGqAH1+vZNlhOy7Gg30sXVz324GjLXbQ0PF0whvVWRZYDzwh/t3/TBPEjWq/LAlPxdafQK9aHTXdIeBqR9RYw5Nj/Z+9TcpcwFpHJRGmv4I1+p6/G1XHgfx5rJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 09:34:32 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 09:34:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Samiullah Khawaja <skhawaja@google.com>, Alex Williamson
	<alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: Leon Romanovsky <leon@kernel.org>, "dmatlack@google.com"
	<dmatlack@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Thread-Topic: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Thread-Index: AQHdJHIqLrZtspdgLkq+Xyv4uF95S7aPMFHg
Date: Wed, 5 Aug 2026 09:34:32 +0000
Message-ID: <CO1PR11MB483582006360CC4F32F97F838CD32@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260805003355.728299-1-skhawaja@google.com>
 <20260805003355.728299-2-skhawaja@google.com>
In-Reply-To: <20260805003355.728299-2-skhawaja@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DM4PR11MB6237:EE_
x-ms-office365-filtering-correlation-id: 592b6e44-41f3-4efc-e248-08def2d4c16d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: RUr3svnXNWdtcVTxXhBlOVWjsAMG+QONZraxF4nnDnSS4fVf+chrB4mdMJDuAaeSpWn08FLwrxhYa/VDe7SfZbkkRX8A32rTLX1HsRsksPp/S+nyiFQOaWIklFHxXPLjqM6BHaH7v9jOKsCGtbffSNHsEG8bo91uOWWyFS+02TJ9Wf2d1mk/XCMqUNcPHgAdvVBRSh+rQZc47eCnmu5AMxXRfu2kvCoE6BHE3+bJ0LLbYQU6yorEeFM2Nfh+dN9RxV7L8KnQXH4+qmZGRE1HEo28YGwougnCD49N7LPDMZNsFd/emy2ijE39j5FolKlvnO7DE755V0zShgt8jX3xWfSVTqhubgrJYwTpxjh/hrS/Mtf3DpjMW0archkzZMQV895AfOMFzq4f3vHaiG+XQwJlzsD++s+onJ9bhiyP/u8PyVYXmQSMP7bg0gXRqAR77MIvOZ6Fv2UF3yJSGLka4blDNm0dchJkhzqc4TGOiyltjc4QmRi6dTa7muQ70a+OVJCM0iAv9Wr+VvDHBAoYKN1/yyrmZ0Cq9GUIEMfy1vIsO0tyBybYwlnhrnkybRyQRa6ENmeEf/ymLvUZMxrsH0Y94t8tsjKThU76b/dGLcJIPCC4IxARw5I+Skl/MgIVaCl1UUC3cWPGK3SjaFfFoOtxbNWRiiXhkSxuWSlw7Y4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWRKRy9jVTlmQjJvc1BZd1d4eFVKSHlxMU1OMHlQUnJESlU1L3poZXoraHVr?=
 =?utf-8?B?dFdBaHpQdnZ5QWplSVpiTlBha1JMZ0R1VmJyOUtGSHNYQW1CdVlIQ2Y0NzdI?=
 =?utf-8?B?ejFHYXZ4dHVjVy9KYjJLdHk5Z1lVeWtBb1NlTE9TellvNjNxN0VxUkFKaCtB?=
 =?utf-8?B?ZnVJRjA2TWh2WlFMTU5CZ1JoTnh5MWNSVlllVWI4aG5FTUJPWjJMSFNUQmJz?=
 =?utf-8?B?dm9oNDROTE9tczBjM2xzWVNoTkx2b0R5dnlmTW9USlU2TWdManV5cUJSSEpV?=
 =?utf-8?B?M0lYNTdIT3NkbGlKOEdJWHFQa2w3cHZSK1IxeU1tNnozenpCYjYzWWJESFFs?=
 =?utf-8?B?bUlISjA0ak1aY3hsNHdNdmZ6QW5tV3gyS0RIbmQ3cm9Hc2JDZ0Z6K2lqMmMw?=
 =?utf-8?B?VldVbml4UDk1WWJVdlJHUFhEOW5BOVVvalllVkJ2RVRia0h3SW1yZHJsQStP?=
 =?utf-8?B?aXF6QTRYYkNYNVR0M3FLZ2lwL21TM2hWWnJWVHlTY1ZiLzVTTGMwbCtmTG1m?=
 =?utf-8?B?aW9Fd0EzSEpLek41b01KOEJ1MkU0U0NDUVU5K05Wek1UVDkyWFRhTUhKcnp1?=
 =?utf-8?B?V1FHOHdRL00wY0JHY3p2OFFkY0llLy9RMnhhN3AxSDBuMFh4Mk1VbW5ZOExF?=
 =?utf-8?B?aWczQTVuWGYwYjhNSWttcFNyUVErc05uMG9uYTlSaThmVmhGU3R2WU43c0pR?=
 =?utf-8?B?a1gwZWdrUWhnOFU3Yzl2ZC9UWmhjK1ZOa0x4SHhBZFB6Zk0rSTcyNVBRcWpX?=
 =?utf-8?B?U3l1SDJab0JjbTFWUHBjM0FRSWFhb1Yyck9SSDFhTFU5MUVtaUhVTGZSVEZx?=
 =?utf-8?B?K3VUUGRqTFUycC9QaGxIR3lFOFhoTkFFTGwwY1VBODVpSGhzR2dHaDZxa25o?=
 =?utf-8?B?UVhqYnFua0tjVEJlczdlbEY0R01KdHhETlJhU2dPR3UwbFFrTEdaSlJKVDN3?=
 =?utf-8?B?RTRBaEEvRGtJRkJEVndHa055UURnckY4Z1hHWm9rKzdmRFExTU9kYi9Kam5t?=
 =?utf-8?B?RmRsMVp4YTdiajhSakVJMnIwcENybTFIOHZnam0vTjZFTFQxeDI5QjVBOVVQ?=
 =?utf-8?B?R2pEWVhOUXN4R0oranQ5cDNQdndPMnFYNSthY2tSN1gwQTYvTlhpMm9ETWZn?=
 =?utf-8?B?MS8xYjRXZEFvQmVFWGU1c28rK0pyMmRjTWl4eldRRTFoV1o2N1NEZzIrZXE5?=
 =?utf-8?B?REJmMlR0eDUxOVNaaXNTaGk1cWNybVczc05BaTFwbjVHZTVJQW5vK2kzSUwx?=
 =?utf-8?B?eFY1NU1tM1JyblpWeUh1c3VZdjh0UWN5Wld3ZW5OWEJUUmpYWVBOdG9ISWtC?=
 =?utf-8?B?SGxtWjlvbHZmcUt6ZmlPblBmL1ZQeHBXc25mdnVGNVVuNWxKL3Vib0RlcmRm?=
 =?utf-8?B?RTRad2dTZ2hhRmlWWmMvTm5sZzBFejduQ3lCRWdYQy9SUEF5dXV0d3dVNVNu?=
 =?utf-8?B?Mi9ZTjFONmVTNHJNSDJXcFVvNC9jMnBERHk2MFpvd0dFeWxVMUpUSVZ3T3Zj?=
 =?utf-8?B?VmFJdlBFZ2lWTFRQV2l1MjNoekpJd0YyWU5HVGpJS1g4MVdxMXRPZGZyeDhv?=
 =?utf-8?B?QldvNFRRZVhNZHdXM3B4UVNwVHVTcW9ZUHkzTFlYMk83cGpBZlp0eVRybW10?=
 =?utf-8?B?aytIdEJSY3pXeXRJNTljNjg5MVd5R3lWcDJxVVJWMWxOVklSUGtLUTVwVjU3?=
 =?utf-8?B?dUJIS3A5S0ZiQkNqM0pRRTVRdmVEVjdKOC80U21uYTM3K0sreVlHN0RwWXNJ?=
 =?utf-8?B?azJkWTZPUlhBdnRmUTlQck1SZUNUMzE5MUV2RVZzYXJuN3B3a3M2akw4N3c0?=
 =?utf-8?B?ZU01clZxSDVuaFBPMW9sRVlxVGJlL2REZ2xzS2xmYWxPcEFWc1pPdllzU3g2?=
 =?utf-8?B?L3pRRDUxcmVpNlpvZW5WUWFGckMzdG45UWQ2NXpvYWd4NG9wa0JrOWd2Z1pn?=
 =?utf-8?B?Q2gzS2FrSUxHa0sxQnQ5WHVvQ2hJdUxsb1UyNGZVODc5NTZOVlU0eWdKZGlL?=
 =?utf-8?B?REFmTUN6dTFmeGdiMmN2YUt1RXE5WFBIbGw3Sjk2dGRheHdVc2ttTjZ2OVBQ?=
 =?utf-8?B?bUEzNnc2ZHdqQ2xKN2VPR3dmQVoyNS95MGZDZ0QyM3NzRTdaOStVZWFaK3Nn?=
 =?utf-8?B?K3RGQldCSENpbGw1Z0dlUFBZRnV5YlJrUEFrMURFNVVrb0UvcUNPdzFuTG9H?=
 =?utf-8?B?aTVsMGZqMzJFelJBaGIrYnFHQ1c2WDV2UnNpM3R4ektHUFBQRW9HVVV1b2dG?=
 =?utf-8?B?b2FQUjNWb041MEl6K1dPOGlkMmw5OEhMUkdWeDkvUi9uTjRrUHVTcU5pVzQx?=
 =?utf-8?B?YWVoNkk0b05wWnlKMWRyeGZHN1NYVGdxQTlJOGIxbWh3WlVvcG83Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aaDbGCYD0cBiT4rzc5lClnCvnaRMIwAodJkZBGC4PvgInZG5Hltw3F/lFaiQr/e1iDxvGoIrpggFhs1elXQLvNTjyqDwrv4tKeetnA8n0GBUXwWJ5AR8Jpu+oCykmo1IOlxMzx7MJjaorOtTkls/+szRHCWqL36unikiAUCjdCokhMrNwlXVdp/ysal/rcV5oHAECmoSYnwnFNbQRSth5jkmYJ2yr0t2XHT4kTAfbue/nwCl2TZ2dX2xPOBlu38Bp/QRKYHVhWX3S1UdeR/oKbcUhTbO+4FFHIA72M/YDqU7pQTZpoOapVAP7e+yuiwYOTTHeDWEdAgRTfCHLNduMQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592b6e44-41f3-4efc-e248-08def2d4c16d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 09:34:32.5360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWGvI60eWYG1+pJXh3reziozubT13inoiLgHZ41vBGm+EzKB7Jk6YNu4ShKwIcJYQ+koMWGvhoqTPM1CKVh3PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-OriginatorOrg: intel.com

PiBGcm9tOiBTYW1pdWxsYWggS2hhd2FqYSA8c2toYXdhamFAZ29vZ2xlLmNvbT4NCj4gU2VudDog
V2VkbmVzZGF5LCBBdWd1c3QgNSwgMjAyNiA4OjM0IEFNDQo+IA0KPiBXaGVuIHVzZXJzcGFjZSBj
bG9zZXMgYSBWRklPIGRldmljZSBmaWxlIGRlc2NyaXB0b3IsIHRoZSB2ZmlvIGRyaXZlcg0KPiBw
ZXJmb3JtcyBhIGhhcmR3YXJlIHJlc2V0IG9uIHRoZSBQQ0llIGRldmljZSB0byBlbnN1cmUgaXQg
aXMgcmV0dXJuZWQgdG8NCj4gYSBjbGVhbiBzdGF0ZS4gSG93ZXZlciwgaWYgdGhlIGNsb3NlZCBk
ZXZpY2UgaXMgYW4gU1ItSU9WIFBoeXNpY2FsDQo+IEZ1bmN0aW9uIChQRiksIGl0IG1heSBoYXZl
IGluc3RhbnRpYXRlZCBWaXJ0dWFsIEZ1bmN0aW9ucyAoVkZzKSB0aGF0IGFyZQ0KPiBhY3RpdmVs
eSBib3VuZCB0byBob3N0IGtlcm5lbCBkcml2ZXJzIChvciBvdGhlciB2ZmlvIGluc3RhbmNlcyku
DQo+IA0KPiBXaGVuIHRoZSBQRiBpcyBoYXJkd2FyZS1yZXNldCB2aWEgVkZJTywgaXQgaW1wbGlj
aXRseSBkaXNydXB0cyBTUi1JT1YNCj4gb3BlcmF0aW9ucyBhdCB0aGUgZGV2aWNlIGxldmVsLiBC
ZWNhdXNlIHRoaXMgcmVzZXQgaGFwcGVucyB3aXRob3V0IG5vdGlmeWluZw0KPiB0aGUgY29yZSBQ
Q0kgZHJpdmVyIG1vZGVsLCB0aGUga2VybmVsIGRyaXZlcnMgYm91bmQgdG8gdGhlIFZGcyByZW1h
aW4gbG9hZGVkDQo+IGFuZCBvcGVyYXRlIHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIFZG
IGhhcmR3YXJlIGlzIHN0aWxsIGZ1bmN0aW9uYWwuDQo+IA0KPiBUaGlzIGNyZWF0ZXMgYSBzdGF0
ZSBtaXNtYXRjaCBiZXR3ZWVuIHRoZSBrZXJuZWwncyB2aWV3IG9mIHRoZSBoYXJkd2FyZQ0KPiBh
bmQgdGhlIGFjdHVhbCBkZXZpY2Ugc3RhdGUuIFN1YnNlcXVlbnQgYXR0ZW1wdHMgYnkgdGhlIGhv
c3QgT1Mgb3IgYm91bmQNCj4gZHJpdmVycyB0byBpbnRlcmFjdCB3aXRoIHRoZSBWRnMgd2lsbCBm
YWlsLCBsZWFkaW5nIHRvIHVuZXhwZWN0ZWQNCj4gZXJyb3JzLg0KPiANCj4gRGlzYWJsZSBTUi1J
T1Ygb24gdGhlIGRldmljZSBwcmlvciB0byBpc3N1aW5nIHRoZSBQRiByZXNldCBzbyB0aGF0IHRo
ZQ0KPiBWRnMgY2FuIHRlYXJkb3duIGFuZCByZW1vdmUgYXQgdGhlIHNvZnR3YXJlIGxldmVsIGFs
c28uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTYW1pdWxsYWggS2hhd2FqYSA8c2toYXdhamFAZ29v
Z2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3ZmaW8vcGNpL3ZmaW9fcGNpX2NvcmUuYyB8IDcg
KysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmZpby9wY2kvdmZpb19wY2lfY29yZS5jIGIvZHJpdmVycy92ZmlvL3Bj
aS92ZmlvX3BjaV9jb3JlLmMNCj4gaW5kZXggYTExM2M1NTg0NWUxLi5iMzZjNzdlYjNjNDAgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmZpby9wY2kvdmZpb19wY2lfY29yZS5jDQo+ICsrKyBiL2Ry
aXZlcnMvdmZpby9wY2kvdmZpb19wY2lfY29yZS5jDQo+IEBAIC04MjYsNiArODI2LDEzIEBAIHZv
aWQgdmZpb19wY2lfY29yZV9jbG9zZV9kZXZpY2Uoc3RydWN0IHZmaW9fZGV2aWNlDQo+ICpjb3Jl
X3ZkZXYpDQo+ICAjaWYgSVNfRU5BQkxFRChDT05GSUdfRUVIKQ0KPiAgCWVlaF9kZXZfcmVsZWFz
ZSh2ZGV2LT5wZGV2KTsNCj4gICNlbmRpZg0KPiArDQo+ICsJaWYgKHBjaV9udW1fdmYodmRldi0+
cGRldikpIHsNCj4gKwkJZGV2aWNlX2xvY2soJnZkZXYtPnBkZXYtPmRldik7DQo+ICsJCXZmaW9f
cGNpX2NvcmVfc3Jpb3ZfY29uZmlndXJlKHZkZXYsIDApOw0KPiArCQlkZXZpY2VfdW5sb2NrKCZ2
ZGV2LT5wZGV2LT5kZXYpOw0KPiArCX0NCj4gKw0KDQpTYXNoaWtvIHJlcG9ydGVkIHNldmVyYWwg
bG9ja2luZyBpc3N1ZXMgd2l0aCB0aGlzIGNoYW5nZToNCg0KaHR0cHM6Ly9zYXNoaWtvLmRldi8j
L3BhdGNoc2V0LzIwMjYwODA1MDAzMzU1LjcyODI5OS0yLXNraGF3YWphJTQwZ29vZ2xlLmNvbQ0K
DQpBY3R1YWxseSBpdCBpcyBhIGRpc2NvdXJhZ2VkIHVzYWdlIGFsbG93aW5nIGtlcm5lbCBkcml2
ZXJzIGJvdW5kIHRvIFZGcw0Kd2hpY2ggYmVsb25ncyB0byBhIFBGIG93bmVkIGJ5IHZmaW8gdXNl
cnNwYWNlLiANCg0KdmZpb19wY2lfYnVzX25vdGlmaWVyIHByaW50cyBhIHdhcm5pbmcgbWVzc2Fn
ZSB1cG9uIA0KQlVTX05PVElGWV9CT1VORF9EUklWRVI6DQoNCgkiVkYgJXMgYm91bmQgdG8gZHJp
dmVyICVzIHdoaWxlIFBGIGJvdW5kIHRvIGRyaXZlciAlc1xuIg0KDQpGaXhpbmcgdGhpcyBhbG9u
ZSBpcyBpbnN1ZmZpY2llbnQgdG8gcmVtb3ZlIHRoYXQgd2FybmluZy4uLg0K
