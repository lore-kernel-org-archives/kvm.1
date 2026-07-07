Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D443388384;
	Tue,  7 Jul 2026 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451345; cv=fail; b=Td7J1tSpImraET1mPrbNu1lemfekyAI90uuwXU/njwuJqdJKBBN9PQIXrZGwX+YAyV07W5XEVE9BusAjMCBaY+71I2zczeEEYTgMnmHuve0U99nqQvDgNSJAX5Aac8SJZLynVWx7xCcf+nIE8TWqjCNOUGgnsFJ2jmgXON8jw58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451345; c=relaxed/simple;
	bh=GN5khiPKLCHoiHNcEvohN3iFijTlI4jHbVsUy88frI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ijBWtUFtjWzIUZ/SA48IZhDYglXMFydTQvPAOACWM45Z7A1YuJDyiR2csP4TvGGoylUtzqsIqYaAh7spTG8mctbPZeVZm2SI1pekNopPhQbMLOFtSLmugNKbQIY6fDSWd4U12SfCGO0frFtJvmf3FJ0Ni2nt0ntgVgakAgy67Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RG+vHkMh; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RG+vHkMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783451343; x=1814987343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GN5khiPKLCHoiHNcEvohN3iFijTlI4jHbVsUy88frI0=;
  b=RG+vHkMhTJtq07Fqujz1u1XeHRZZ5tzlHhNgLXVApGzkESywip0TQq1S
   spPSOd0RL0YBQl3dsC2WkConfyqj7AMCCFS/CmWuzjpYTSPvFwEhDNwgo
   bdcF5zbQoOALkclFJ20FQH+gWrEwZtFsVsYLF6ReL0akgiiCNORaFA5yN
   iyo+k9mxiMkF2VOz7i95w5z6DHvbT5gktadnu03S8JxJ4WWMhb22TGIKE
   7Ks9u5EYjS7b1+wQ7qE6n4FbsZwKj7yvOjHqMlu/y8miOw1zUO43Nf0E5
   k+Cy1KItaI1DdXAjVOTIVXBh4oB2yRJIz7cVDcuKD9bWdO+Thu/Klek2h
   g==;
X-CSE-ConnectionGUID: H0aa+as1SkCdpR5ee+9mqQ==
X-CSE-MsgGUID: whl2wJOCTkigKFGdeavz1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83967948"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83967948"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 12:09:03 -0700
X-CSE-ConnectionGUID: 2ThDiqvTTw+gZw7qvgJyYQ==
X-CSE-MsgGUID: q1BElDwDTS6jk0lSBnH26w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="249636719"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 12:09:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 12:09:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 12:09:02 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 12:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YG3PNgCTyDF91U0AtFwOiK225VLCpwd/rndp9d9S8jvpkvxP2d9w3bxUP7JOUJpp4PmTyCeimxUNgHHEK8qYli3twqpwqXpbb0vLl0CWFNyzo0Gw5Es9V82bb9n3OKy/VrzbR2KOs0uz+IVAnmBzf8mvulOPpSRobog8ud+wRWOyEQwRuUL6XeNXArxr3U8OKbX9hxWvJhwBeakj/0sexOhcVSIJo5eLZnk8lNdFgqs9iaq4nSF2zIIRHkefhTeBbaKp1Hx06tmNVWBSkU+0dKeRkpQHWrsDdRuMSuZe3sCViIzecFhxkBY5QzHKUxA4JW3IRJzlNuVBheZtUOiAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN5khiPKLCHoiHNcEvohN3iFijTlI4jHbVsUy88frI0=;
 b=JTbeeRMKutElEyYejJ6tHxcSahs6P/jn10Ntd8IbMuxaD/ya+ZYbDuxuK7lpryyBPVZqgqby+2Lz3UsouF9MWOUmoIopoFuIUrAqZsTyZD2fLImDD60eM29igKLBNgSu4OMxf8Tp2jzDnErWW1sfC1lhSadi2il+YyDkZtWFBfQ7CZFYsoaERWiDQ61eN3tzzNGTSHm1oEisxEzCQPaNUnD4Dlvs/Wh3OJJqsCaI4KRKbVqjTTm/zKtwmj3bPWKWUGaitXkKKC0jOTMg/37WnXY1cHoi7rqYBgiC8rJ5S52UmmWJLDPQ6Z+QeqotRUKE/VheacFmlUWLdyM+uXjSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 19:08:53 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 19:08:53 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "Gao,
 Chao" <chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Thread-Topic: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Thread-Index: AQHc7LhTzhja0MT5tEOwuy4+BJvRdrZbhckAgAWp9wCAAHbzAIABB/UA
Date: Tue, 7 Jul 2026 19:08:53 +0000
Message-ID: <5a009e4b4a053f8c4675906ca8331662af49db20.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-2-rick.p.edgecombe@intel.com>
	 <akdNPjf3zt6jPX1m@intel.com>
	 <6605c80fc676c069bcbb097c77c07b17eb3eb97c.camel@intel.com>
	 <akxxWF5nMbFQWlD3@yzhao56-desk.sh.intel.com>
In-Reply-To: <akxxWF5nMbFQWlD3@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BL1PR11MB5955:EE_
x-ms-office365-filtering-correlation-id: d7b2e4fe-c32a-430e-3ff4-08dedc5b2ffa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|38070700021|18002099003|56012099006|11063799006|4143699003|22082099003;
x-microsoft-antispam-message-info: HRyXFPXe47vm67vc1ES/hp4fuCP92RitONxvWo1a0jW0o+QXIoMLab61UR/hvHd+/cBZ0gnFJCxHHzIcdfnaLbVdYePz10+r0H6XkY4LJcFWl9xFvcjJM9F4PaooQrvdUBaFuPrbkkZ38hvnPBrTYvwkaXWbiRrtt0HF8Pu5qZfEeKPtdKO+0bU6P7nmVea9jzXYMRK4u09fYkp4Ukg1z5N4SyCFH0u3F6vIFnn3NssPxdjn/gCtthT5WjvEjc0Vz3MfmCb7GPuZ87N8Osm2zpTvUlivg1wXWh4YBq01wXU83Wi1vDVlhb4HHAY+YZhXzYHZcT9cmVKJ5uSvXZdOcHe55ee3i0fPE9hJfNbrdBgQRs9xTX/yyg7AEjovAcRFcz4YlNMmgpd054zNqg3U6oCPg/0p+FbTUmNJIqTgdPcfJt6UK70auLRrHuZZUjQluAeozf8J3kezXBcC22x7o9w9bMFEl+7vMI5MQ3+OgHItE+a+TaG8yPckrZ4EdQdYL4wfaMN1VG9RRr+BuJTyBd1b96AO0EVnT+fIzNPRs2vSN+ePzrmA4fLDcKKIHg9dZH36EEajbhZ0TuFwacmU3FTACHcC0RHHEg7jCvuRWw5XdrtgJMV7xWcxAqkmXz/3ER1vxYShAVfesY8YIxzTm1WJ2Pls2kuOMLMuKH2Qq8363RTeCz6XmaJCFqlWsWGkXJu/gQE5eXSMpJTEDj47Qxh/1Rgk/sREpm0SnZSRnnY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(38070700021)(18002099003)(56012099006)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VktlQ0xVaXZIR2J0cDBBVkY1MkhvTmdmV0ZoM2pBM09ldE04cERiNzRrbFRE?=
 =?utf-8?B?ZWpuNE5NSzV0YW9nUjBkeEFjYnNDSG5QdGhvWUwrNnFYak5YOUk0L3RYeCtr?=
 =?utf-8?B?aWNxeFRGYUwyWHo3Mi9oS2lHRFR6WTQ0SHVubmtNSGdlODlwd2g1QS9pRStJ?=
 =?utf-8?B?cVRQL1ZXZ01Fa241RVhwY1JTSTkvWVBqVmpUQXhMWlhLYjhtSXlEMU5jZysx?=
 =?utf-8?B?bmhjVlZYd3JxM29pTEthTFpicTdibHpUZWxRUnFCckZJeUZGUHVVYXRISUtO?=
 =?utf-8?B?V0xWd1BwWHhGaWpjWFcvSXZwd2FrMU9ZVm5URmY3V0tRUlN5ODdlWTRSNVNa?=
 =?utf-8?B?dE1aVExnRm05YjB5eVdGeDJUVEtEMUQ5eU9pd0lzVmNYaTU3ZlV0L3dEREtj?=
 =?utf-8?B?THRwQ2VqRHFQbCsyTmFZOTdOazhWTEdkWHkvYUxERmJNL0RlbSt3ZjJKc1Qx?=
 =?utf-8?B?QWM3eTRmUEFsNjBlSzNvUmZmNmZubnFqcWRBQklxbHlRR1NpZEFjL2RVMlh6?=
 =?utf-8?B?bmpiT2swcWo3UHhnaFlGQis4RVZzSlhkT3M0YmRjTDRLZW45UjFHeVlqQW5q?=
 =?utf-8?B?QlhadXRCcHRGdElxdEJKQUJKanZ6eG9sNVd3R1NqOW15QXRrZ254L1FObmZ1?=
 =?utf-8?B?UTZ0cWplTkJJM2piSG1oYUxUczVEVW1DUXArMWFlczFYWThYdXVKQnhYbzRZ?=
 =?utf-8?B?UTRtbjhNRXdTMHZnbnBVU1g3d1lyamFqdEEvbXJXQURmS0xtR25tVU9Gak9K?=
 =?utf-8?B?WU9HYzJWTDJWYUNTeUFQSVB5b1p0M3B4SHJFVzlVTzFvcGJqYlF6R2Foc1dm?=
 =?utf-8?B?a1VrUGNEYXQ2MGd3YU1NQ3ZRb2FXb0NxaFJqZTRTWENvV3hIcFVsbHBDWWFI?=
 =?utf-8?B?STZVL3paeGhsdkc2emp3eEw0em1La3Q5L2dyQ0NPVisvMHhTWFRpQ1dDZDZl?=
 =?utf-8?B?N2kwMVRlenphUTUva2p2TG82Y1NtZHZtT1RtVGQ4QS9hNmFnRXUwYm5DNjQz?=
 =?utf-8?B?alg1N1VoY253QjdhczNqSzZYSVhWT2RHMERMY3d5WnJsdnZ3Zm90ZmtUa0Q4?=
 =?utf-8?B?eUlnc1VEa0FBZTFaQkErMFpkMXFqc08wRTJSNVgxUjlWLzJJVEFGbmc3bGdD?=
 =?utf-8?B?OUx2aGJaZGhsWnE2VkRiT05FUmJ0T1o5K2lmUDlFczZaNllGOG1vVlUreFRu?=
 =?utf-8?B?cUxUR3Y3TC9VaTQ3VDJjR2ZzY2xjTmx0R3BRdHFvcE9wWGhCMlZ5d2NKckdU?=
 =?utf-8?B?MUJDdmNGeWNBczRmSG4yWnFrMzI2Um0vOFZmLzFmRHhxa1g1aEJVZnVITGoz?=
 =?utf-8?B?MXl1YUJETDgyTjNRVkJqbjhIVzRPS1FmR1I4dk9Ub0wzTmliR0VCWlNpWWQv?=
 =?utf-8?B?U1U0WGFmb2JKMG9Va0RpVmlHMlQ3VktZcEw2bnMyWGFkbStKdWVRT1EwSGp4?=
 =?utf-8?B?SkduNG53OFRSMHNCYUVjaVZRdHFkWmp5bnlHQ29jMFVwVDZwVUxVQW40MlZ6?=
 =?utf-8?B?N1k4TklKamY0Yy9HbXZrSm9SdCtpZFpURk9rTFpVNWxMNFR3SGZJMWF6TkFt?=
 =?utf-8?B?OW5WZG1DZm84dk12QjhXUnJmTWVLNmtYZDFhVUx2RHZpVjR0SGRJV282VlZI?=
 =?utf-8?B?eW90djBFNHhXYlVWVzZMTEVoLytrM0xqQmY5SGxBaWRWZTFVc0dsYm0yNTMy?=
 =?utf-8?B?RVFvcC9lN29xSDZ4MUlTaXUrYXEra1RDZUZZalZZQy9BUU0vRTFNNUg0OXNo?=
 =?utf-8?B?WDQyY2JxN25MUE5VanhCSmUrNlF0VytlVjIxb3l4M2NIaytoL2NBR3ozaUt4?=
 =?utf-8?B?ZVNnVVdwMS85UmRidm91aVdKdjV3WDJMY1RiT1lOTDY0NTU2S0QzT01uVjdC?=
 =?utf-8?B?cnRtK3VwWnVLVWFjcmtYdU9QR3FGL0I4WmlCQkJNcVJiaFk4cUl2KzVpTGdR?=
 =?utf-8?B?Z0lYYWdaSlBpemNhMXo3Vm50aVpnNmFONmNvOHJTQ09IUGF6YmJLOEYxSjYv?=
 =?utf-8?B?dkhRTHJtSTJJckdpNG5qbmo5VXdHWjBLaStFbXZkNmFRbXpZRzBERTJWL2pJ?=
 =?utf-8?B?MDdzUFpOdFR6L2ExZlU4Z253SWUvY3FhYkFDdzZPOE5PSFJUNTFBanBWV1Js?=
 =?utf-8?B?Y2xndFFOSXRhWGVud0JFQTRLbTRDb1FGb3hYVy9mTUhiQSs4aVpnNlViV3RQ?=
 =?utf-8?B?L0ZyZEdJLzhtVGNmM0ljTnRXNFN6TE9jdWFSKzh6dGFTY2hDUkhsZEtRZTBU?=
 =?utf-8?B?Q05YUllJbnNFaGVIZzk4dStuQjhhQVRxUXhKeFA1eHZCVWs0RlR1MDFOZVhB?=
 =?utf-8?B?b1JXWmxzVW9ydENkdmxFelB3MTFHdzVDdjJoUnVXTFRyQ3Z4T09NZStyK3Jl?=
 =?utf-8?Q?Qk4dPepCaUAc4hv0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC4419453FC3AA4D87BF073096D22415@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iG324VDe46UwRUFPSvytiC5+8MKmo/0suDXkXql/4XqTUwCTbCkND/cwX9K8eE7yGjWPZjSoQp9KzhFUZCScvp+kXs7zFWkisYxSiQ5Y2Qs8XzYxA2ic8AV2vwyqfXY/z5eal23cxPc6CYlzpkYNbLIotQQ9n7t63rzkpQetf9D0IodThxl9XpweqgWF574wGd2nxqQndVKnlb9L1WNh3YT7gHviouV+l49ujT95PcOvHANujPDl3PTUxwDNzsy2RMC/4p00q6XnfwL8K/cIjwYF+hr2Dns7T4e/Uwx3Mc3EHS/SsJzbw/gRR1HjakuG7HNUV5Ik1pGW59lQrgvXTQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b2e4fe-c32a-430e-3ff4-08dedc5b2ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 19:08:53.7884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6oS0h01itPBwUefciJu8Zqurlddc1/uF4TYdKiHCwh591630Q9Hl49BQv5JhCqSaXMqGzCz4eBODZrhlgaYTZnMKZYXdBO4uExlTuqg7kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDExOjI0ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
VHVlLCBKdWwgMDcsIDIwMjYgYXQgMDQ6MTg6MjVBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gRnJpLCAyMDI2LTA3LTAzIGF0IDEzOjQ4ICswODAwLCBDaGFvIEdhbyB3
cm90ZToNCj4gPiA+IE9uIE1vbiwgTWF5IDI1LCAyMDI2IGF0IDA3OjM1OjA1UE0gLTA3MDAsIFJp
Y2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+ID4gPiBTaW5jZSB0aGUgbG9vcCB0aGF0IGl0ZXJhdGVz
IG92ZXIgaXQgaXMgZ29uZSwgZnVydGhlciBzaW1wbGlmeSB0aGUgY29kZSBieQ0KPiBOaXQ6DQo+
IFRoZSBwYXRjaCBpcyB0aXRsZWQgIlNpbXBsaWZ5IHRkbXJfZ2V0X3BhbXRfc3ooKSIgYnV0IHRo
ZSBsb2cgbWFpbmx5IHRhbGtzIGFib3V0DQo+IHJlbW92aW5nIHRoZSBsb29wIGluIHRkbXJfc2V0
X3VwX3BhbXQoKS4NCj4gU28sIGhvdyBhYm91dCByZW5hbWluZyB0aGUgcGF0Y2ggdG8gIlNpbXBs
aWZ5IHNldHRpbmcgdXAgcGFtdCBjYWxjdWxhdGlvbiBmb3INCj4gVERNUnMiPw0KDQpIbW0sIHll
YS4gSSdsbCBjaGFuZ2UgaXQgdG86DQoNCng4Ni92aXJ0L3RkeDogU2ltcGxpZnkgUEFNVCBsYXlv
dXQgY2FsY3VsYXRpb24NCg0KPiANCj4gPiA+ID4gZHJvcHBpbmcgdGhlIGFycmF5IG9mIGludGVy
bWVkaWF0ZSBzaXplIGFuZCBiYXNlIHN0b3JhZ2UuIEp1c3Qgc3RvcmUgdGhlDQo+ID4gPiA+IHZh
bHVlcyB0byB0aGVpciBmaW5hbCBsb2NhdGlvbnMuDQo+ID4gPiANCj4gPiA+ID4gQWNjZXB0IHRo
ZSBzbWFsbCBjb21wbGljYXRpb24gb2YgaGF2aW5nDQo+ID4gPiA+IHRvIGNsZWFyIHRkbXItPnBh
bXRfNGtfYmFzZSBpbiB0aGUgZXJyb3IgcGF0aCwgc28gdGhhdCB0ZG1yX2RvX3BhbXRfZnVuYygp
DQo+ID4gPiA+IHdpbGwgbm90IHRyeSB0byBvcGVyYXRlIG9uIHRoZSBURE1SIHN0cnVjdCB3aGVu
IGF0dGVtcHRpbmcgdG8gZnJlZSBpdC4NCj4gPiA+IA0KPiA+ID4gVGhlIGNsZWFyaW5nIG9mIHRk
bXItPnBhbXRfNGtfYmFzZSB3YXMgZHJvcHBlZCwgc28gdGhpcyBzZWN0aW9uIGlzIGEgYml0DQo+
ID4gPiBzdGFsZS4gQXBhcnQgZnJvbSB0aGlzIG5pdCwNCj4gPiANCj4gPiBPaCwgZ29vZCBwb2lu
dC4NCj4gDQo+IFdpdGggdGhvc2Ugbml0cyBmaXhlZCwNCj4gDQo+IFJldmlld2VkLWJ5OiBZYW4g
WmhhbyA8eWFuLnkuemhhb0BpbnRlbC5jb20+DQoNClRoYW5rcy4NCg==
