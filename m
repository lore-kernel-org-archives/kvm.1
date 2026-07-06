Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB463DFC7E;
	Mon,  6 Jul 2026 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369625; cv=fail; b=RfdOYuT3zMWZd+HV8QpEEarQoXBIANNm4ep7XMmp9XMiJUDd3W3F4MbXERJRYk6wrSKQmsprMOnd7na7eLKKYGQCBFMPt2tSuysd9p1hvOz+BQrPJ8oZRFg13rDmIpGYEUetUX6ZDwo66B4ODXZ9ZWWtJr9ZzHQ1wtku3fPBbss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369625; c=relaxed/simple;
	bh=QYJGvzfudRCqKvaxOoCI1kibzRIwCIG129Thy+KdT7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X7LPb8U2wRCz5obuVKN6wD4K9K1CwHCh3bSTPWeY3rE8DGmY8cEuq+FdJ643SZGH64lGK45VzWDmiawVuspCzoX9xEyzpLMsSlMI5OiWj06DMehlZS+L0GrTWXxWMRX4wNJFuE5IAcd7E2g0pfoL03ecfJ5tRLTmuAYWCD0ea1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ra7bNdgC; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ra7bNdgC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783369623; x=1814905623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QYJGvzfudRCqKvaxOoCI1kibzRIwCIG129Thy+KdT7g=;
  b=Ra7bNdgC14brsXtyqe1dx0eG71WXENF9aAO4PBVuyy3YjlbTXKC0vfIm
   oLhBx9ewAOhayybH8gOuNuk374C/D1mObsL/6xrRgIdEpafjNEfzK48MO
   +PGIqyCW/iYDZW5UdbfawQxwm8PNqrL3V/mQVrUwr/VS+WVOzs96q6xqW
   BFDDWvvjaXyNNMtdmWr2OyrA13mLNMhlmbpAl4ttiueF+iUjWtIBFwDnY
   axi0u9z0aBH8sM38NUyVklVWzfHEToyL9Zd5QMa6SZuTJuhiG303iGKJ+
   LZjTciKaorFcmUGfIsF5V+MhNaJHsx7JLUAyO7Md1nz/LSU/4iU01fgPI
   A==;
X-CSE-ConnectionGUID: 8X2PCBg7RdyuYx80qVpeeQ==
X-CSE-MsgGUID: PeNrvh4OR5ity9EBL7remg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="87691700"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="87691700"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:27:03 -0700
X-CSE-ConnectionGUID: 5a2Mul70TO2wyh6G0p9RLw==
X-CSE-MsgGUID: fqQ/QrMiTwqiCVUl2aHqNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="247423269"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:27:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:27:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 13:27:02 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:27:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjANDcBjA+XCJQvK7h5IwLYJ/GnilhG4yOFJACX1zRVO+XNot25HTgL6D1M6j8JX4ZD0eU1HSQ/qJ3w3U7/k/wkxAzDNNAZHRGx/2aTdMe64iV3q9vfjGMXS5IGG4i7mpDv1qqnhwJCh2HhinqvWhCVCDcoIfmSiA4okPEt6HEKU8bIotjWzdwf2tdRi1FTtirekxqdlU1y04Lygo02D1Hud9CdRFm+S8vMvpnBoqiynWrt4N9/NbH6outG7LqYNUsgAfUCWIDf951Wrv+RSxRvs3eKMMlM6/4gFvqGSHHyeqfVH5yVWhsCHgZ9NqiERsb3SdE5spBkl2myCKkjXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYJGvzfudRCqKvaxOoCI1kibzRIwCIG129Thy+KdT7g=;
 b=YdX/WikoB2/lG6iYbK5n8cZZhBQs8kwej9TMlQ2z+Ff1Q37ncxB4LfgO+/iH0Xe0yredVsvqJygUW7KJWPsC3zqAlcMT1zGlRsYCG5nY93rPZ11+pr0PzmKXxjFQgE6j1cjn7v/4JZRRWCt8CW4IkHcZpZggV2Ah+cAg+uUE4+/2HWrlwJABo1OT349b1HIPmJoKSk2FAG4fG98OakFM0/FYUHNKt6dqwFXkDxVV4KawQmrsnY/FgoxzzsJ+dWZ4atjwTC05PnFvY7/QshedUrXHYDpyMjZoHJkWMwgx1MYlnE2FwqFeFT0vJd8QuQg28ET6B8JdS5y47cwV54H4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 20:26:58 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 20:26:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Thread-Topic: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Thread-Index: AQHc7LhU1bCbzezxb02fxsgzvwPwJLZgu5sAgAB2iYA=
Date: Mon, 6 Jul 2026 20:26:58 +0000
Message-ID: <ee026df6bf32d1c6d9bb6f1c357562fa6f52e5f8.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-5-rick.p.edgecombe@intel.com>
	 <akusIp6UQW/pIDc3@intel.com>
In-Reply-To: <akusIp6UQW/pIDc3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB7947:EE_
x-ms-office365-filtering-correlation-id: dc5474a3-6e67-4564-a5f7-08dedb9cedc6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|38070700021|6133799003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: yI/30G7wc+oS29talDKGGahBOtRrQHf35paZJFIMewYRzxz/DS/fVwh8UIY/jjulr7zyuG7fbnYYIfyQ+49ef4YnWHp3sZqza2ydLok4bN8bAw9gnruMfvJDW7fKjzVKLIv9GMkFc8/P00Oxzukzcw3D/P7FxVKcqoP7KfVdy/Z9iO9XuefENC/d2bBeNus51nwKPmCvjc7M2/p9LE622CqHolmNNrjAzVt8t7/DQRXDZ4G8xfCWKfPz+sTF8/YsYrsXNGtvxY+u/C0R/eNcOCNnN/jCaeiKoY9Q7XU17Am0GXvmO3nB6yYjtjjLKq3cyn8fUsvfeJtY2rAb1AbbQgBwsByKTxgaYdHqsDNaD2p09N8a1QhFLfJ2l90xIJRrvuCrK3Z77diqc4cUdHO7+SioskK2GlGjKgF1wlOr4W0INlTX0P+e/W7NQGcAp67bZ3X9LiY/Mgah/EC21krwMcqfYL+trtZk+TfQZ72IKxU5+Sg7JTJGW1KSrYTQqxfSbzMJfCK7kDtHDxrOH5FE0gSGRbQdljjtlDWUoWd8sagixg55y8Vny4auzjZGUaDAbq96pXN1L7G3j3AteUp9LDtMr+eVG1RT4KQ+W/WnLpIMLHmaDSuDuVpKXcPqIykOJlFerwSm80yiyr6iPQjV/x5mrLkNVJzXhNjGmxDPQVhl/lgxwckaXGC0n+TT34BA3pX8pWlybA2/gEUSECzofxmnXBGaHIHYQhmxIGK0zik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(38070700021)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTNDVkxMNE5DeHJ1NlBiNHFCQWp2VXN5Kzl3OFdhZlBOU0JsaGxVS0pNdEx3?=
 =?utf-8?B?ZTlhQjN2Qi9wcHdOQmNEaDRxYkNsVUdsN1BrSlc3QjVVQlRSb2dEckRUL2VM?=
 =?utf-8?B?K1VWNDViV3UyWC82Z1huODZ6M1Z6UnZaNW1xL0lmMUF2ZVB1dy9iRHNpWFVB?=
 =?utf-8?B?MmhLTHFwVitidERRZXFMZU9relVqdkN4Y1dFRmFzaXJVYVJEU2dKSHlsbWh0?=
 =?utf-8?B?Y3lXOGpLbHZsSCtZQkUyTjdyOU5KU3E0OEdldU1KUC96QlFwR3FEcDRCMzRp?=
 =?utf-8?B?aXVOSjVWM2EyTXZmS0FyQU1tSUk5dmVkQVJta21sNXNYcGF0SjgySmF3MSto?=
 =?utf-8?B?b1g0b1ZSQWN2WUE0ZWhVMjI0clRlYTRyYXhMc1ZsUEo2UUFSVmJCR0ErOGxj?=
 =?utf-8?B?UzQ4SytGeG12U1puOWhuSmcrNS9oYVgxMXYyRWYwREJVa1NSbGFOZlhJWjJX?=
 =?utf-8?B?aHAxTVhMQ1BBTmtybnBiVlp0aGp6cGN2YWlaRFkwWGFHUjFQUHkrbThuS25m?=
 =?utf-8?B?S2JXaW1EcWM5TkEyVm9LZnlNbnBMSmpsVHZPU1JFY3k3aWppeGFtYXdzY0lZ?=
 =?utf-8?B?S0NLNW5ZT05yZjlNdE4wZnNOZWZ0ZkorTGFnbGVpTGNxQWpNTHFKY3Q4UjVM?=
 =?utf-8?B?eUYvNjd0U0hLUVVLaHNWOFAxMVJ5dzR4SGFJOTFtTjB5aUZqRm9XZkJQTGFN?=
 =?utf-8?B?TDZQQ2RHRlltTnJVa1FQclJVRkZTWUcxVVNaN0FNMmVobElZSWtraEJqdFln?=
 =?utf-8?B?SG1FM3ZzSUsxRzl6bDFkMFJnR1FtR2YyMkRzVHlOenk3eUoxaUluRmpuYW5w?=
 =?utf-8?B?UGFJNy81Z29BTHRQNytIQ3hlWUdFblVzRFhwSUdRYWZkdEw1OVk0L28zUlFV?=
 =?utf-8?B?dTBSd0VYVDVIalplZzNvUVJLMUM3WGFFdWFtaEV6SkoxSWN6Z0poTHNHVngx?=
 =?utf-8?B?dFhTeUEwbHRHN3lwWVh4bEg4QXR0dk5NYVhuc01vMlk3OE1zbitreHVrYlc2?=
 =?utf-8?B?Qkpua2JmMC9jRTh3ZGNYbUFURVFmaUNtZTRYekNvUFEyRWJoNFdiTGJLaDA1?=
 =?utf-8?B?K2ZyOVN3NFFGeTlGK3lpNDQxS2twUmRLS0tIcmNRTHNQNzV2OWtlSHlsYTN5?=
 =?utf-8?B?ZHQ0amo0bnk4aDhGaVQyKzViU0M2MGVSQ2NoWWxtQ0FLTHNPdUVlQzFEVkRv?=
 =?utf-8?B?RiszcHNwckU2S25wMlFBTHczSEo4dW4zVytWT0tpUnRTTG9aVkRFdUd2SUQ0?=
 =?utf-8?B?c0JxTEZkRHN1dXR1cUZWNS9Pa1BFaThMVUIwNUcvYzhJeWhreVREWWQzUjdw?=
 =?utf-8?B?UDdHczJRay9CTG9IcHJ2NW9BOVBLOWFEci9JdXA4eUY4UVlnS2ErUWIvZ0dy?=
 =?utf-8?B?VUpISXgzSHpBTGVzM1B0MXhwSnpjSm5xaHprSzZFSkJydHE1eS9vUDRFVXpo?=
 =?utf-8?B?ZlRXZEhyV3l0QUd2djFIc25Ub0dOdzF1VmNiNzFtT0UrOVJrY0QvaG51bWdp?=
 =?utf-8?B?WDdDVTA3VFlXZDhMaDFvZGJ3N0ZjK3Uxd205WXB0OFhidXQxZkR5WFg4M2JU?=
 =?utf-8?B?eHdiQTNyWXVtdy9qWjVhTkhhUTJnR0t1UTEycjVkNS9hYktMVkJNaWlWS2Fs?=
 =?utf-8?B?M001NVE5Um00OWJndWpQQmh1OU0vWW5EUmcyQWFEV2xuZXdNKzU5RzJlRVU0?=
 =?utf-8?B?aGN5dDFISUcybzFZUGd4L0x1VDRhRU1SNnRiVlVlcHU3YTZRVnp1NWVKYzZP?=
 =?utf-8?B?bHNRb3UrS3NSYm9RWnEzTUFvdXpmOU41SmFrWmNhRTMzeVQzVElhaEhBSXdz?=
 =?utf-8?B?TXlRUHkyS09wbzcwTllqdnEveWNoc3VSdS9FY3ZGZmVsaEcwR09kQWRzSWpm?=
 =?utf-8?B?M0pzMTlQQ3I3aUdJbXRJbS9ob2FhOTN5UUR3MmJmRlpFQjlCYmJhcnJaTWZo?=
 =?utf-8?B?d0MyNTVIaVFCTGU4ckFIRk0zSnNDdHpkai9vYzRQL0tISHJjQXo5UjQxQ0Qw?=
 =?utf-8?B?QXlxVkgycm1abndHQlM4OVVCdHcwM1pIYTZ1QW9nRWhlY2lJRzFUbE5pZTN5?=
 =?utf-8?B?YnBWeTJLYW1OVFVaN3JJcWtlWGFUVDdyZFdMaWZ3Y2hZVlRGNGJOSVZqT29l?=
 =?utf-8?B?K29sRUprODRqV1NvbVRTTkxDQ2MxK1YyUGJndDJwL1ArQ0MzZ1QrTVZiaHU3?=
 =?utf-8?B?d0c1cGdSZFdrWU0rSHRGZjl2SkRaN09KdGdacVlKc0xqOXpwc0w5M3UveEVw?=
 =?utf-8?B?SThLclNISStBcUZ1Qys4NXRtSnVGakxJcTN4ZThrZFM1NlozdWRYV1hPM2JR?=
 =?utf-8?B?WklxNCtEUUVnN1lMbU5qaEthV1N5R0drWEd0ejNNZGtXVmxiZ3Z3endDZUU3?=
 =?utf-8?Q?apkdu98/e3incwzI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDA01FBCE5E4664C9F168DEEE3A6065C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T6RcEpGhPZxJuQr/mTw+SrfVjWwIYkjhfxjIQMidxB01eTF6SRANLFthXUzadbpPmBT8tBeNn7lcpJvfWuB96K4IUofWT6yyxNX7c836NRGaO1fsRPMgc0aNmR0QX47WsHTa/thCB3vWMEhd9/jSafo6ME1sKnlkWcBfUXQ1lzyfLAiHXBjWS2XsZiVODCHtFH+M+wjOHOyGh7H4/ODaF//bhaYjkLUom3CmDos/OKWbbDUPeT6h2Za2YOZA4DThV7PBWa04qO+csf8RTvxLUzVxp6TmCBK6LR4DYZILXOVJyAiVPdynmgoyPvN9tKt2gSOeothQHiMTQJWVgsM/gw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5474a3-6e67-4564-a5f7-08dedb9cedc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 20:26:58.2941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHaOxWKNCuwX2DJJfu2gxAmhXGcbeOFiGgNAOJbCeNKuTucWTIdrBr7hDxY/qi7ZfgD1nvF5K1SHQIm2yjscvkRYOoKN+3+GvjOYofeyK9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDIxOjIyICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiAr
LyoNCj4gPiArICogQWxsb2NhdGUgUEFNVCByZWZlcmVuY2UgY291bnRlcnMgZm9yIGFsbCBwaHlz
aWNhbCBtZW1vcnkuDQo+ID4gKyAqDQo+ID4gKyAqIEl0IGNvbnN1bWVzIDJNaUIgZm9yIGV2ZXJ5
IDFUaUIgb2YgcGh5c2ljYWwgbWVtb3J5Lg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGludCBpbml0
X3BhbXRfcmVmY291bnRzKHZvaWQpDQo+ID4gK3sNCj4gPiArCXNpemVfdCBzaXplID0gRElWX1JP
VU5EX1VQKG1heF9wZm4sIFBUUlNfUEVSX1BURSkgKg0KPiA+IHNpemVvZigqcGFtdF9yZWZjb3Vu
dHMpOw0KPiA+ICsNCj4gPiArCWlmICghdGR4X3N1cHBvcnRzX2R5bmFtaWNfcGFtdCgmdGR4X3N5
c2luZm8pKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCXBhbXRfcmVmY291bnRzID0g
X192bWFsbG9jKHNpemUsIEdGUF9LRVJORUwgfCBfX0dGUF9aRVJPKTsNCj4gPiArCWlmICghcGFt
dF9yZWZjb3VudHMpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGZyZWVfcGFtdF9yZWZjb3VudHMo
dm9pZCkNCj4gPiArew0KPiA+ICsJaWYgKCF0ZHhfc3VwcG9ydHNfZHluYW1pY19wYW10KCZ0ZHhf
c3lzaW5mbykpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCXZmcmVlKHBhbXRfcmVmY291
bnRzKTsNCj4gPiArCXBhbXRfcmVmY291bnRzID0gTlVMTDsNCj4gPiArfQ0KPiANCj4gQm90aCBm
dW5jdGlvbnMgYXJlIG9ubHkgY2FsbGVkIGR1cmluZyBib290LiBUaGV5IGNhbiBiZSBhbm5vdGF0
ZWQgd2l0aCBfX2luaXQuDQoNClllcCwgdGhhbmtzLg0KPiANCj4gUmV2aWV3ZWQtYnk6IENoYW8g
R2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQoNCg==
