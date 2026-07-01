Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D61CAA7D;
	Wed,  1 Jul 2026 00:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864966; cv=fail; b=EaMS3R9ilwTApqXKUbE9YPzXfqW864rkkP84I0xy/0TX7pyDV/72s85dE7Qt1/NAcMQ8vo/fDXbW4WUdRmMOK7DXLxwpjDYrjDTmuhWiiFjysXLWzDcaAc0hv8GLr6Xfxul1uiV4qg4SsESVteSSMIoiwONkMlQLSZL93HzCAgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864966; c=relaxed/simple;
	bh=TZzwp6VcakO259YwUueb5eYUnFKciwM2hjPeYg/uFQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nwmfNXIOqf45rr/cIlZinwVcXTmKsGNSZcLZeG3seCUk8/xny5gRYn1wE48uVEonjNhOsdBsYjpkgPpjLptl990210ry1DXTs8xq/DeGuFU2kI6uB91D+cJSNwrHKYErd6eYhyMIAxlyq6gFPBGAf5RtKrUWm8CkVpXUYdBm6XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhsNsk49; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhsNsk49"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782864965; x=1814400965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TZzwp6VcakO259YwUueb5eYUnFKciwM2hjPeYg/uFQo=;
  b=DhsNsk49PD6X7DAix5KFuE7sxAQF4rV1lP5Ka1OlN1D9AOnho6eV2ws+
   QRczDpa3HqKyDB0S9eRYC+R0dVe72joRbm7AO8MkDggWW6YpCAyDvTl1x
   WZ72gIJQ/Om044YQox/reimYEmPQgqwSmc7F/D6CSMuXDcX/kVVNbcaQJ
   gEWdcHrBJznly5yrWxx3TTGUwUcx1zz+9qtw+LyPiyoyZrov8sePArAg7
   nmLfsKMLldghUM108OqNSzmJyCMpZnyOkrkMiki5Zwan9HYIS6lMB1KUl
   zmFanssSjY1KpLtEAchXqKOuh7qmqG81GBIt3aerdw3CCQLSFh959iuJV
   g==;
X-CSE-ConnectionGUID: 1wZJWLijQKeCMs1Yha4C5A==
X-CSE-MsgGUID: Xpn1YZVfTpi1QsJhfg5ShQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83365782"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83365782"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:16:03 -0700
X-CSE-ConnectionGUID: Ljqlil05S16tfZQrhBRXLg==
X-CSE-MsgGUID: HX/2NRZaQ5K24kJ34cXxoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="253056063"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:16:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:16:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 17:16:02 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.23)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwJKyPj3paLaaRRJPspEIiftvEwJrubt1djjzCkElaKVOlsLVShf63qTa7CScprpahlULnWNzgIYj9OdQcZxXRnShrVlCHkuDyxE3wXoejjzQgWE0uihZ9VJdH/uldmW2Jzn/quuZobj3zUL4dahqdznL00pEFNpoqNgq5g0wWIMUY12HShEp9o8OPuC2aMdMXgFrRAEFRbtuIuYBocclWpOJQ4ruqn4YkQfIMdxW/sP/tU03n0EjydtFaHcjLOmeATl0EpHczXrAhA7GdcBeeEO1vlr1ozkxiYXCNuKWrqe89gF2rAhcEw4TYtpQJ1Q63fzuTZHKVsPqcbe+SR1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZzwp6VcakO259YwUueb5eYUnFKciwM2hjPeYg/uFQo=;
 b=FVx8i960R79+ugwVad6sGJpKal2FDRxBjWW+XnIwGux9HgDGXv3sNyS5M3z6ua/Tuja1lNCEio/PLIVGlZaOG+xrbg7qSkvc4kLKCd9YRt2xoj7w2Qbwda3d4hsgu2NLh6GE/cCBb+buVOXzVL7gQWqatlDogxZCh01NRcAvjhu7jFJDIshJ4cGAslTCPUht73twgvYJjiP7IrSkmBmYgOMfaqmsE0eAa/xP/Chvu/pKHn61zkZiVvRQ28YsTqOCVJr6InLYI4gWyXZmGGADXIQpFwby6cVuCVBFjuu6moDSb5Y/LPtru/IMZlAzjZKygaY4g5igxMaBq3M2qGuf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 00:15:57 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 00:15:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Topic: [PATCH v6 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Index: AQHc7LhWCooE6IHqmkuIiSt8p5dGSLYz/u0AgAAB9ICAJAM/gA==
Date: Wed, 1 Jul 2026 00:15:56 +0000
Message-ID: <d6bc1f548b2208616ef17ea078312fd694d123c9.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-4-rick.p.edgecombe@intel.com>
	 <50566572-6379-4100-8845-404f695e59cd@linux.intel.com>
	 <aiYmkfHBDHlqQI/d@yzhao56-desk.sh.intel.com>
In-Reply-To: <aiYmkfHBDHlqQI/d@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|CH3PR11MB8752:EE_
x-ms-office365-filtering-correlation-id: 2d5d1ac4-57ac-44d7-0946-08ded705ec2f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|38070700021|22082099003|4143699003|56012099006|6133799003|11063799006|5023799004|18002099003;
x-microsoft-antispam-message-info: ZrUF0O3bJvZpW3SRLUmtRWM58MxXZ3wCthmcAVBLgNNWyFYr3dMXmK7IrbEwEl1toxaFuaYVdKu5YJzERbY50iLOVh8bJOwPJiXSVX16ZExhEXAmkYz8RmMhdpxjw5DsR1ynI9B3VG0n+HxxhBBF9jc2hmyrI0yN8fcY1QpCv3niZL4ukdpf2ofVV5ky2SvvvqI6yIBx2oayUvPy5yqWxhBx19oASrhXxXUxJiy9m3NrewXpNrw/foXBP2fMKxRawlR4wiIwnFhmrPhN5/3IufWoOc7zETPFNP5GQM4aKjWes7I7bl0/8Xosn5BdEEtjp4rxXj6+dXM9lTw42rx6ztuNehS2MNQ2DVQ+JI2IsredhbDVu23U8sFuN8EnFvZxXhGkRu1Uw4BS2SOdMO2OSZ0KR/VblMzV/ohkQYHYWzyMQYdVFP8BXkngeg93j+3IsWf96Qz/R9q0ukKnq+74T+dLva6Svk0dJRJKcdX3Hq0l5hQ0SmEj42DNGuy63kumkTVcHvvj/DZ7j/+N1C1IYUkWBEShdzhGoX1Q3uBvNL4oy6isgphFXmQfZcbFis9hDOuUeZFAwMuxTAPdFebqKoq1kjBXs7k2vDdzdS7qZK7TWqxDYGO8GDpvwpefSWzgYZGQY3j0Q+/ODGaNagm16cKFQvqCuN4GLEKl9fMDqmPyk24ITyuqS8moz7VtIPDfEWPhFl/HhkG9K6WDJUF8QMNFsDnZOfyeYQIXQAiiptY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(4143699003)(56012099006)(6133799003)(11063799006)(5023799004)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NksxWmFVemNXN3pyOGhIRjVMTFNHeTY2QU0xRyt3bFU4ZDFsMktZWmtraUR0?=
 =?utf-8?B?QXJ2Y0JPdU12empsSVVPakhVTlRoT3VOOG13R3FlUGo4ZVZsN1R3ME1vL1Fs?=
 =?utf-8?B?cVZDNEVRN2hlUVp0NlhoKzhSYkZNUERZWHJBVTlHVjF0ZHhuMU90NEF3QmpT?=
 =?utf-8?B?VVVNblY1SWc5STZPVnJYN0N1dDdhZDNKbmRVcDRSakwyMURZVTZySGdVM3lI?=
 =?utf-8?B?NzdsTHRIbERTYXBQalIrNldGRmJIZ1lVU2w3eUt6UEt1QjZvSzF4bDMxZEgx?=
 =?utf-8?B?VE02eFRZZEdvOFUxZFRnZXpYSUt2czBDamxiV1ppYjEyZStROUgrL3R3N0l6?=
 =?utf-8?B?KzFibExucXpFaVF1NmRPdGZBMVo5Zk9PeS8yM2RoeHZMaWNJYzVlenhHdEw4?=
 =?utf-8?B?ZEIrOFMvRkhSK0xmV0RkTjJyY0tPM3lPSGlzNUs1b3pxeVlRU2x0UmVnNVg3?=
 =?utf-8?B?aVgxY2NPaWFFWmp4emp3em5DSnUzWWorKzdMdTM0cFEya3BHMGhuc3BDSDdX?=
 =?utf-8?B?SHMybnlxbW9RWXNhdVJSR2QwU2tmZEFmakIzZ1RUblpGWTNqN25QRG9qMlNl?=
 =?utf-8?B?UXdtUXdURDBzOEhLMitSeEVnMXM3cWJoTkI0MDFxeGVGdVppNExaOCtOTDdG?=
 =?utf-8?B?N2EweVhpcEx6RnJRbll3VkJvMzlpd2FCZTNKaHRqS0xsblBSQzBMWjlITUlr?=
 =?utf-8?B?UUJrTVR0OG5HRlhsUEFlSThROUtVRUcrYmo0QUJFeVhDdy9wZWFpOHFsNXQr?=
 =?utf-8?B?SURvQk1pbzJNSnpBK1VtL2hQTHFOc0VKcjN5SGFKbEJvYThaeEtPQjdsVmYr?=
 =?utf-8?B?TzRoK21iM3YxOXdSWGRSWFZod0FCanErMmNWWFpPVFUvNk1iNVMvMWVUTkcr?=
 =?utf-8?B?WFRmMmkzdkdtMEI3U1Bhb2owaXgvVFJSckxhbmxoeDBRYzR4S0thanM0c2hj?=
 =?utf-8?B?SElWNVZZV0p1UE9TZGhrbTdRZFgrcHgydW1nTmxrMWljZlZYUzJzSG5pWFB3?=
 =?utf-8?B?VnlFTkVPSFZ4OVZmTm9kTnp4SUdIZWhDV3JZTkRBbW8xVFpidUFsSWJ2amJq?=
 =?utf-8?B?VUMzNHhzZUxraWJ0NjdCR0Z0MkZBQTBvR0FJbi9SdGJrd2ZFY2JpbU9EMVRR?=
 =?utf-8?B?aWN3bE5NTCtXQmlybWxUblAxc3RORlZDRFo1c0RZVmZqWEs1eE1TVmg3OEF3?=
 =?utf-8?B?b3ZDUjlaQjZ3bitGbUNvdXE0TGNOZlZMZDRMemVqUDNzeTl6ZXFHWkE3Vmpv?=
 =?utf-8?B?bHNnb1ZOODJUZjZGdE9FWkM5SElHMWZrV3l1V000eWdCYlEvYnlBY3UwY1kw?=
 =?utf-8?B?eHBvSm80V0Q1aE83TFN6dkhlL0pPWTdldGpERy9CMHJzWFlvMFpYd2c5UlNk?=
 =?utf-8?B?Rzd5dEM0SDB6OVNmL1U0Rm41ZjNyQTlLSzZTcndwS2lIUU1WTEg3eGdvazRs?=
 =?utf-8?B?NytOV0ZWVTZGSkFLd280SjFRVHZWdU5QSCtaOUxYWDI1dDRFS1dQY29EdUU5?=
 =?utf-8?B?MFBFeEdkUW1MUDdBVW0zMUpXS1BNcGJiRTYwZFpFQWxFOU5XUU1HWWlRNmkr?=
 =?utf-8?B?ZE1DRHdrVlliaHpWMzF2S0lERStQd1ExVXdqMVVOam9OL0c5SWRIVkN5Mzhs?=
 =?utf-8?B?QWlmTHdnOXp6eVVWWWNNakw1cmI3aGNHVDhQcEROV3liZHYvT05yVkNBTlhY?=
 =?utf-8?B?dnhqSjZvWGRKNUhlRDJ6c3A2Z1lpOHFPK1AxL3hXOGw1Y09zNDZSejZmVW03?=
 =?utf-8?B?MFM4UjN3TzBObWVOcFNZNU9hSmc5azlRNlYveHE4UGw5RFJxODlsa3dRQStX?=
 =?utf-8?B?RVp5RFZsQ3pIQVJTYlF0UUtBcmlLMG5WdUIreFZCUGNGeXlyWGxaV1dmUXR6?=
 =?utf-8?B?L3NzbnRtRGRjbkpvSnRvUTJ5alN2Wk9WcCtUb1pQNE12YlVRZlVpUFU3TFZJ?=
 =?utf-8?B?L3pGZ1oxck5tVnVYd3RBVllrUFBuaUo3cjhMOFZDem5Rd3VwdUhWY21NTllC?=
 =?utf-8?B?ZG9mMFUxTldqNzladWpzMENKYnJqbmZKS1BDaVgvOVV0S0x2RjJEMkw4N2Fp?=
 =?utf-8?B?S2lDRWhIdmVDS0xkdC8vd2NEVWxGS3hYSVVKVVJGY1FlREt6Vnh1Q1dhNVcw?=
 =?utf-8?B?bGxOK1F4UlU3U0hMZXlpYlRvM09NRnNHL0F3RGxjNXpkUmhqdVlpQUsvUXVY?=
 =?utf-8?B?NHJidWVzcXV0WTNBTmlVTkxteVBjSnNjZnc2SHRKbXZtTHBVNXNONThDS0tL?=
 =?utf-8?B?b1kvc2tHckdmMXNUdzVsMzIzWUVJUWNzaGYrSi91TzdjMEY2MVgyMnZJbUVP?=
 =?utf-8?B?dzJ0eTlxWUVuZlBrdnF4QXd3a05POEk1bUU4RXM3cExQR0dpUXp2VkI5cnph?=
 =?utf-8?Q?OQdYByhY3oYqigeE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F33E6489B04C04CA96937F10E94A34B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AOAQ/ZFlGTVziAU49oTAyGFWGghQ+Am0KGkSRSq4bIY0bk7lFxgTUJsaZduxT1aCdKv3GLwPKluMQdZQ90vAf/Xod2QSIE1GcfgRZMj4f9xuyhVIbGfjGrNUpkJzwDG2dtqH+on8OaVHek1rsTv5Ldug9QsTy13xaDqFs6pvLXyPUvqmR0THkfXtmViHQp5z4IwXLCgb/DTnx734S85q9/YMUGZiV2o01YPurxKT+aNMwnIaweRhY+VX5tgja5TM9iAPh1dlwOeFA7+LJdNkNTEieg8F4ejk5y+SeN46O+qonVz5zHsnzH6qiottxiUze8bdSFkf2pptRJx+Yf1vfw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5d1ac4-57ac-44d7-0946-08ded705ec2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 00:15:56.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /eXPOA7Ei+FuK7ur0Zh76V/sczI3QrPMwmtTD8m+YBWI/k/fPz0+Yj6BEfnrBTsw755P/Qx9kKldswFy1rVftoE6FLuFhA86F4cEArb/24k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA2LTA4IGF0IDEwOjE4ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
TW9uLCBKdW4gMDgsIDIwMjYgYXQgMTA6MTE6NThBTSArMDgwMCwgQmluYmluIFd1IHdyb3RlOg0K
PiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20vdGR4LmgNCj4gPiA+IGluZGV4IDgyZGMyN2FlY2YyOTcuLjc0ZTc1ZGI1NzI4
YzcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaA0KPiA+ID4g
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4gPiA+IEBAIC0zNyw2ICszNyw3IEBA
DQo+ID4gPiDCoCANCj4gPiA+IMKgICNpbmNsdWRlIDx1YXBpL2FzbS9tY2UuaD4NCj4gPiA+IMKg
ICNpbmNsdWRlIDxhc20vdGR4X2dsb2JhbF9tZXRhZGF0YS5oPg0KPiA+ID4gKyNpbmNsdWRlIDxs
aW51eC9tbS5oPg0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIGhlYWRlciBpcyBub3QgbmVlZGVkIGhl
cmUuDQo+IFJpZ2h0LiBUaGlzIHZlcnNpb24gZG9lcyBub3QgaW52b2tlIHBhZ2VfYWRkcmVzcygp
IGluIHRkeC5oIGZvcg0KPiB0ZHhfYWxsb2NfY29udHJvbF9wYWdlKCkgYW55IG1vcmUuDQo+IA0K
PiBBbHNvIG5vIG5lZWQgdG8gaW5jbHVkZSBtbS5oIGZvciB0ZHguYyAod2hpY2ggaGFzIGludm9r
ZWQgcGFnZV9hZGRyZXNzKCkgYmVmb3JlDQo+IHRoaXMgcGF0Y2gpLCBzaW5jZSB0ZHguYyBpbmNs
dWRlcyBtZW1ibG9jay5oIHdoaWNoIGZ1cnRoZXIgaW5jbHVkZXMgbW0uaC4NCg0KVGhhbmtzIGZv
ciB0aGUgYW5hbHlzaXMuIFdpbGwgcmVtb3ZlIGJvdGguDQo=
