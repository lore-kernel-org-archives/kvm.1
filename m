Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71935443C0F;
	Thu,  8 Oct 2026 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494180; cv=fail; b=BF9cJbFlFdiG6gtxWOvdfdQ5Bfr6G8/TRIN7bpfYdPotpZpicFJZovoKdrk0oWzHahqjgKSfI5uwB1g6n8RCHP6iskIFk3nI/JYdYqgqEu43QVyGA9nINrgvZdkwrjrQbmFO4urBFKdQAN6ex1EX72DzBbKmrpupvM0woEQqRKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494180; c=relaxed/simple;
	bh=UuqUbXfk5v/PcBkVxlVZJCqRnEg7paBdKfeDMwMFBhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=geEHmJopNSckRyMyIWKebYZnvMVzGIYizNiWgU1qf/rdSv9yRZcS1pv24jQ/7TV2+4zR7Q24EGbrrBXI+TEDlr1xwZN+jGEoG5TLhZuLS3lbRFmWv/dom1RJ+9lpAesNSNu+cEAujHg9mMPWJrIA1Oy2W/VSxSU38HBXXkA1Oi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKVFz3Uh; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKVFz3Uh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791494176; x=1823030176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UuqUbXfk5v/PcBkVxlVZJCqRnEg7paBdKfeDMwMFBhE=;
  b=YKVFz3Uh18FRFjXcDbt5mx00QajThU7JxdMDXjcpNUD1Suum/iQAE0v7
   kI09WBAmIA9k0UHkAnKx1ny2/cZasvh5x+/OK+UeneGnblBdOm0m/6nsB
   G7Zdcmk+Ku9juoxpB/5C1oWwn0mzb52lXUNCmnwj6nObo3+z1dez7Oq5y
   E9sPcw53yl8ZuirE8Kck7S0yPTmWJFvTHEvBfD7VZQXb2ERrFhlY7PO6V
   UEUBpsqlFCMLhzi5+njmhU0dB2UEK6mUXnN5K4xkVyGV1qAy+4aXnn+Nk
   dWKpCc+hSppmEshWZ1DtFFNBmYOwezuR5njRa9lNw/ycs4dzK7ZygfqPx
   w==;
X-CSE-ConnectionGUID: xR+f73h9R6Se9yC7Mfxj8A==
X-CSE-MsgGUID: AD49W2q7RhioXa+UkQZeiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="173940"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="173940"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:16:15 -0700
X-CSE-ConnectionGUID: 5d9KIXcWQvGaweTjADL9Sw==
X-CSE-MsgGUID: FgKK7D/+RrCNnxGnPoVhXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="593822"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:16:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:16:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:16:14 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:16:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Akjb6kFjUAkcKTGMK0Ev5Ywg8Q1z4zHSsu8IC5MKs7xzfdvELOtbbozjde1ZaSZ+JCsrOTXZY6mnXHx/bYJGR2ugqXNKZEBBLggj3ymyi/Jl2/zQWF3hXyWrACkamHKW/+cITag/6drmE28pHvaIvDbM913U5L1wcbwk/abMHiDcSawq5/ktDAbtwa+jXFXwiHPYMDpBkSz9UU9Fqc3HYAvqnL3SygfqqTaqlUR+dP/TCXA9+6D9DaO9EX0VffVuhfJ+wek/022HRYmCCSZ/xMJCvIiXirjUDtQg75dZYZGOMxYBubJseOey8vwBS31Z+Pq26DBJ8IT01EmNuR7pMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuqUbXfk5v/PcBkVxlVZJCqRnEg7paBdKfeDMwMFBhE=;
 b=hxOjAHMIKbrJD2VU0qmaF6SUKhdXzMSNVKB/ZmtmA4jmCiEd5owenRGTZBqY4Nhw3w1i4DkujryMARpr2VeB0HeCXtG/wqaZTdZnng0NCHmcX4kJQ9CdAhDR9dbg/a9alvbv6ChL4XFEYv4k1qXCw6VgDIj7AXZdFy3ACw1LUDRmwpXJBdtTsvQyHd8bxFN0E6kth7WQMiXAX2yFmaHtSyo5mPWRR5s9s2guOjIV6SplHyx2j0m1Wf3wgQvBjSO7cO3QEtxjLkMYMrYFZ9a9Ad6esxRl/HBppk9pgIS8N4JvnGmMI0AAm3S7xgcATS8lgBT62XqJyGXMGxPH3U7emA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:16:10 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 21:16:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>,
	"oupton@kernel.org" <oupton@kernel.org>, "wyihan@google.com"
	<wyihan@google.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"sagis@google.com" <sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Wang,
 Roger" <runanwang@google.com>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "chenyi.qiang@intel.com" <chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 00/22] TDX KVM selftests
Thread-Topic: [PATCH v14 00/22] TDX KVM selftests
Thread-Index: AQHdGi/fD3HeSKoX5UGSIW2nqtNBd7actxyAgAAE64CABQ68gIAA5NqAgFHwfIA=
Date: Thu, 8 Oct 2026 21:16:09 +0000
Message-ID: <b2a03539707ee8155f277a7c9f3e505de8978c0b.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
	 <5a44a6925715e1edbd379ac0ea5526ec990eb819.camel@intel.com>
	 <4828f8e29801adb29a4d48b8980d3b3a0a813e06.camel@intel.com>
	 <CAEvNRgELDhXvPFKaoz+w-yywoJn0WMWvA-Y2jfdnwJVSbCSWyw@mail.gmail.com>
	 <0782a971b1e6aa64c12ba76f9a4e68c8fe72bd2c.camel@intel.com>
In-Reply-To: <0782a971b1e6aa64c12ba76f9a4e68c8fe72bd2c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB8448:EE_
x-ms-office365-filtering-correlation-id: a4586a32-ce75-4313-fc92-08df25815fe0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|38070700021|921020|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: xk7T19Ntw+vJLodr8E7SH9b14DI/vd4XbetTjZpGxYZdKY4N8xbFH8noUwjNjtgBcJHCKwKuSJ5F13cEGneagRh4z+zPwQG0SBndzM0eawV0XljcFE0Hhc1uBDh4H6B33XPJAfvEPO+AO0QWE7INjL1UVqXsMEXXwk0PoPiWsVuVzJH66j3Kyg+tERzvrnBMCZKe0Lo7dihhmW6Ld8ffZgxzmMK8oCMTzpLSPRlg7iNfAMNrbZh7zAA4HbFRQlaUNEC0qQZGzm0je/j1esVE2id/BraDFbNZekrevmGMNEZONXgKfEufFi+cBXmY9+zjxBFy2rVhU1Sz+/tTmoyT4UHJ+7a28TCCGoxsBmy06uEjkEbaxZqaUlL+GECflgYzT4bR7fmIFmSx2YvzwgsZDdSYMiwJKbL1u1qtTUJLVGy0qa9JtsIq5AEaf71x8BWjQr6+GwylCZ5Mn6cvG078ffuHsZRBsmSAzJnH9roRcq6YQs38g9mBYEAeiWThvwF47VGVq5/FNWcwTePBE33KChSW/x2AzHYDk4kZvN4gIhf8ois5fRNq8xwC84j3GgNBtdOrqtyk2I9i+50BCIm7hLV1SWnEDL/uWOidK2IGPXrGmFp65ySRkaAV+wMtJpaXD1EO+fM/6s8x3d8UUYU0SiVe9/7+/SH5uIt4kUhtpH88TisfbYvEQK5HRiz/UMcsRimtICMnmaGai1S+hvQK1Dev4LJwk/oMm150Otu0I84ncBp/HfNf8/KfaEiipWhh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(38070700021)(921020)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3hYUG9TOWpKODBJMTFBaENjeSt0TjljVUEvcFhnVUhaUFlvejVwTXpSR1k2?=
 =?utf-8?B?d2VVVGVtZWxJN0wzWFd3VGExNUJUcUtuWi9Od21zeVJmdXNpZDdENzMxbEdV?=
 =?utf-8?B?TktadVBucUpnaFQzb0U2UzZkWWFvaVlFTXVUclNORnd5Mk9hOTdlVUFTRjQ5?=
 =?utf-8?B?YnpKelFnZnJ6cGZXZDNCUVBWV0I0VE9tbTNjK296ajlpYjVRZUdpQkVHRVQr?=
 =?utf-8?B?WGs0K3BRNVZQdGFxcUhYQ2lLWXdQRnNoZS9ycEZtQVRueGwxUjF6ck1jUzFx?=
 =?utf-8?B?TWRPYTdNMVV0WHM1UEFiZHJMSXcxVHduREY0c3FYY3RmZ3BQekhCdXVrcHNy?=
 =?utf-8?B?OWp2eCtueGhldlU4L1IwNXpmaUl0NzZxMU85OUVpeG83blpPckhnZ2Q5UlVl?=
 =?utf-8?B?a0VxcEs3MzlWaWJWT0pGZmFaRElRM2FnRWxEcFZDdzRLb2tOUno4RGR3dXJ0?=
 =?utf-8?B?SnpudEJwTXJLTHhrM3cxTHFyY3A2WTVlMjFjcitLUllUZlJINjh3S3VtVVJo?=
 =?utf-8?B?aGRNOTN0bDJndGVJaUxJT3FSUUY4QU9uSWNVRFQ4UGtHTkQzRjFGdytlQTA3?=
 =?utf-8?B?MEd1UXVjYzZ2c0cwd3lORlFKekhWcHFsenlUaWFZN0V1S2hzWUpFNmRJYUti?=
 =?utf-8?B?RVZvWEx0NzIxZUxvYzBjTUk3NUtFSVpvc01ZL0lGR0NXNko4N25sRkErNWNx?=
 =?utf-8?B?aTQ2NnlHUCtITGh2MEloNzYxbVpkUWt0VGFpdkVydkMwZkhDcU9mKzJXSHBp?=
 =?utf-8?B?R0NSUFJRTWZtbjJlUURjcWRXTDcwV0R0bWh0MSs0UjZKQ2gxMGEra3R5Z3JN?=
 =?utf-8?B?WWlXMjdNVE9tUzRYN1ZIcEh4Smw2YzJYRGl2aXE2UTBtNU8xY2RFK0NUWThy?=
 =?utf-8?B?Q0ttRlpsRVVhZXBtRVgzWWlLZlUxdjhzR2gyM2RydXZVSXFSUWxYS2t0QmZi?=
 =?utf-8?B?cU1oRVZwUW90NWRQejdSRVVjK2lZemU5NnZyK1V1Z3JLeVlEY2M5VDYvWWxI?=
 =?utf-8?B?ZWJ6NVdtMHlPTVpKLzNBaXBiZEt6ajZkczBPYW8xM29uZTJ4UGY0MkxTQUVa?=
 =?utf-8?B?U1hDcVd1bWFGMWFWanRQTXdxOEp5SGtsRU1XOExiV0xQMzBFb3dZRzF3SThy?=
 =?utf-8?B?RkRYd25rMExOR2Z3MkFDKzVybERRam9lNllxL2RDcFlYekRka3JEb1VRSzRv?=
 =?utf-8?B?VDNXR1FGaC8vVEtxYThkRHNwRmlMVHd4elk5WndwREs3MjYzREZ0elc5bnpB?=
 =?utf-8?B?KzdiQkZXUzd6c2JHallIQnh0ZFVkTU41QmYxRE1xUGwxc080cXpZYlhiam8z?=
 =?utf-8?B?Z1krOEdEemdGMUJxL3pKVTltSVFBdStUaXlnVlI4RURxNkkxVnBrcm1ZYU5M?=
 =?utf-8?B?ZC9YRWc0Rytkd0dQYWZUbUJWYU1wZWdpdkhZcGR5cERPSEs4cXBZYVM5TVpP?=
 =?utf-8?B?akFxNHhWTHdhTzB2NC9NY3d4enVwaGN1TmlEUjlsRmNsVXBUTDFjdG9FVlZT?=
 =?utf-8?B?SzZ3ZlFtWXg1WklFeHlVK3lHT0ZpeTRPUFQvYWR2L3gvZ2lpSDMrUnhGcG80?=
 =?utf-8?B?QjMxNmFiMnVIdThnSFFTYjNPTnlRWk44WUxPQUZ6bU9sRWVFMUdwQXIwTHdr?=
 =?utf-8?B?aW8zcFdwcnBIaGdYVk9HNVhrWlZ3SzBvZTM5QlVwZ1pTTmRsRlByT1U4eG9U?=
 =?utf-8?B?eUJRL0Nod3NEc0VFRDU4ZE5wYXYyWHdNVy9oc3NuN0lrYVUzMm1adXhtcC9o?=
 =?utf-8?B?a2VHeWxnZUFyQW95UjFvYjJhL2VIeENlWjBZeTlicUovZ1hWZ0s1cE5DdXRW?=
 =?utf-8?B?L2ErMEtKOTBvejJBVWtWNWF0NUt4WWtydVhNMFk2Z1NzckQrWTl5YTJvd1hs?=
 =?utf-8?B?YkRDRkhZV1FKbWZzMmxLWm1MK1IyZzhIMyt3YlJjc3BmY005c0RRWkJsUTJC?=
 =?utf-8?B?aitjZkc0a2ZaRkNSZDg2L2hIZTA5anZnbXVIdnZNaFNiYldqOW9mL0EwTkdY?=
 =?utf-8?B?QjFXVGMvWUZBSmtqV0xCNUNUck9JT1B6OVZ1bnkxdVdMMjdOUWpuWUQwcnlP?=
 =?utf-8?B?dk5ZNEpISG9vQTRZbXhnZnZHZjZJMEUxbVJRanpreXA2bzkwNVFURmJLMXZa?=
 =?utf-8?B?YlRma1ZHVlFIajBRWEJUVVpHdGtVcUZJMS9QNlFlM2V3UmZQN0ZIL2JVenFh?=
 =?utf-8?B?RUx2dVdvbU8zMTRWUVdlTWc3Y2VWdldZUHhKeE9hRDlROWxva2FONkhHeW5M?=
 =?utf-8?B?K3FvRVFlZldaaklvRll1U0ppTnZLNWsybE9XSjJSTmhxTUtoOU4vNEFtdmVy?=
 =?utf-8?B?QWQyQlJpRG44T1VZejZyQ01XQ1RIRnMzQUtVTGNlL2JOemtYSEFMRDdmOFBM?=
 =?utf-8?Q?XquoqE1KcYjaDRQs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E08605ADF515E345A5E2EAB3D5430AAE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iX4jaI1ZmSpw+iQkG6UnVqPRb0AmTXi56Vul7nYzUGUiEWChWal7hvrqxE6Am1NHOpHu9sstgxuAyxvEYKDlbM5uuJTuM0lVbiwvk0dWLhwZ/T/s6+TU/jPFSufDqcJX6pjZhYfplPu+DzMOwSCVqcE34XejvyFgCPmPkxxlQpgGT70S27VIY5UHBF7YOr27mL40qs6ZbhlG/1s4OfqHcpyetzcvncq+oS4ycTcgqeegxzKq4G158jPoS3W/TxBz7qD0CUNjWx929agEw1s315gE6J/xFVkabNUXM218Y3zLAJBIkzka+1UdCfP/9yfsj7t5/BWgni/XjQasJ9wpCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4586a32-ce75-4313-fc92-08df25815fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:16:09.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sakI8BnWWITSMootKw/H0LVbdPFgy/6zMOFuQTRSfvwLpEQEKEUIqFTUwt8iq0fPFTxkxlh5zWpqA3JoXU9AKS/EkQfPKLG+408gUKNSFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA4LTE3IGF0IDEwOjU4IC0wNzAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gPiA+IEFjdHVhbGx5IHdoeSBpcyB0aGlzIG9uIHRvcCBvZiBpbi1wbGFjZSBjb252ZXJz
aW9uPyBJIHRob3VnaHQgdGhlIGlkZWEgd2FzDQo+ID4gPiB0byBicmVhayB0aGUgc2VyaWVzIGFw
YXJ0IHRvIGdldCBzb21ldGhpbmcgYmFzaWMgdXBzdHJlYW06DQo+ID4gPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvYUotNkpwSEQ2eGhBdlpQeUBnb29nbGUuY29tLw0KPiA+ID4gDQo+ID4g
PiBBZGRpbmcgaW4tcGxhY2UgY29udmVyc2lvbiB0ZXN0cyBzZWVtcyB0byBiZSBnb2luZyBpbiB0
aGUgb3Bwb3NpdGUNCj4gPiA+IGRpcmVjdGlvbi4NCj4gPiA+IA0KPiA+IA0KPiA+IFdlIHdhbnRl
ZCB0byBoYXZlIHRoaXMgc2VyaWVzIGJhc2VkIG9uIGluLXBsYWNlIGNvbnZlcnNpb24gc2luY2UN
Cj4gPiBub24taW4tcGxhY2UgY29udmVyc2lvbiBpcyBvbiBhIGRlcHJlY2F0aW9uIHBhdGguDQo+
IA0KPiBIbW0sIHdoYXQga2luZCBvZiB0aW1lbGluZSBkbyB5b3Ugc2VlIGZvciB0aGUgb2xkIGlu
dGVyZmFjZSBhY3R1YWxseSBnZXR0aW5nDQo+IHlhbmtlZCBvdXQgb2YgdGhlIGtlcm5lbD8gSSB3
YXMgaW1hZ2luaW5nIGl0IHdvdWxkIGJlIHRoZXJlIGZvciBtYW55IHllYXJzIGF0DQo+IG1pbmlt
dW0sIGluIHdoaWNoIGNhc2UgaXQgd291bGQgbmVlZCB0ZXN0cyB0b28uDQo+IA0KPiBUaGUgbGV2
ZWwgb2YgZGVwZW5kZW5jaWVzIHdlIGhhdmUgb24gY29jbyBzdHVmZiBpcyBwcmV0dHkgdW5mb3J0
dW5hdGUgSSB0aGluay4NCj4gQ29uc2lkZXJpbmcgdGhlc2UgdGVzdHMgc2hvdWxkIGhhdmUgaWRl
YWxseSBxdWlja2x5IGZvbGxvd2VkIHRoZSBURFggYmFzZQ0KPiB1cHN0cmVhbWluZywgaXQgd291
bGQgYmUgbmljZSBpZiB3ZSBjb3VsZCBhdm9pZCBpdCBoZXJlLg0KDQpJIHNhdyB0aGUgbmV3IHZl
cnNpb24gaXMgYWxzbyBiYXNlZCBvbiBpbi1wbGFjZSBjb252ZXJzaW9uICh3aGljaCBpcyBub3cg
aGVhZGVkDQp1cHN0cmVhbSwgY29uZ3JhdHMhKS4gQnV0IGNhbiB3ZSB0YWxrIGFib3V0IHRoZSBs
ZWdhY3kgZGVwcmVjYXRpb24/IElzIHRoZXJlIGENCnBsYW4gdG8gYWN0dWFsbHkgZGVwcmVjYXRl
IGFuZCByZW1vdmUgaXQsIG9yIGV2ZW4gbW92ZSBxZW11IG9mZiBvZiB0aGUgb2xkDQppbnRlcmZh
Y2U/DQoNCk90aGVyd2lzZSwgSSBkaXNhZ3JlZSB3aXRoIHRoZSBwbGFuIHRvIGRyb3AgdGhlIHRl
c3RzIGZvciB0aGUgb2xkIGludGVyZmFjZS4NClRoYXQgc2FpZCBJJ2Qgd291bGQgYmUgdGhyaWxs
ZWQgdG8gaGF2ZSBhbnl0aGluZyB1cHN0cmVhbSwgc28gaWYgdGhlIHNldCBjYW4gYmUNCnNtYWxs
ZXIgb3IgZmFzdGVyIHRoYXQgd2F5LCB0aGVuIEkgYWdyZWUgd2l0aCB0aGUgY2hhbmdlLg0KDQpC
dXQgaW4gZ2VuZXJhbCwgSSdkIGxpa2UgdG8ga25vdyB0aGUgcGxhbiBmb3IgdGhlIG9sZCBpbnRl
cmZhY2UuDQo=
