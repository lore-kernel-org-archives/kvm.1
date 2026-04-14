Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7B1A01BE;
	Tue, 14 Apr 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196749; cv=fail; b=hf8XCgFZnZcn0y3zEUUnMNq0PTQbQK6cV8vSEDBRk6hKXHpuI4Rb/Iq30s+Ntk0rTHmB+0dla2fhUnc8huqvqxVr6F3gRPtIIu4cSu1WUB+zmTIdFUCeXl3Ml56x1G4OtgegjjGJuPZEyF44hrDycXndIL6Y1Xi6WKR3ZO0STaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196749; c=relaxed/simple;
	bh=Md0zpqqPn26EOoxnib8JB2BlNTa+e6HKZR6WUBzdmW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVBwa41/j+OU14YuO6/1Lsvlmz3ducYmeQpK3R/GYUKXUD5UfmqJXrRUotE96jtELoZQ2nTr48MpujYlV549+Bk5+4575gwj0aieCvwqQrqwQ1jolFVrWTw96zlwLwXzUxhicLPOugn3xdrs4b67citnBvQce7duCBc34it+UMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4J4G1uV; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4J4G1uV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776196748; x=1807732748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Md0zpqqPn26EOoxnib8JB2BlNTa+e6HKZR6WUBzdmW0=;
  b=J4J4G1uVcrn1Y7uIiGzJ3075c+xLVlfDnfHEqdqP9O6gv7InO666bKPr
   jwTBSMyKhwrBrqpVG6NlA87JbAIFIXWiSeN5WuG0aP4b6CsPteN+LI1L/
   Nkaea5x+2JUUZ04X4bnQpkr3keZJT1PRx+7rwbv+7XOzg2s1ayGW0/52x
   Js9QjMwyRfut6gJOUL3kmnu7vlwThTqV4e1gj5gKZ42OSeoPUzpN23kCc
   xaQIZFQVcdKqKNu3/m1Mzg2JjuMQgqF+VyTZrinmz7/Vjc4UKo4zCZpES
   22RQT9Ge12/uA1yQuOsUtSJhxhPJRDm862oo6E14LPjZAULDUxUXJQ8Ms
   Q==;
X-CSE-ConnectionGUID: y502Y8iTRwK5IdCRTj9rZg==
X-CSE-MsgGUID: WyaSY2MLRE+pYyMsyKPJ0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88547630"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88547630"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 12:59:04 -0700
X-CSE-ConnectionGUID: JvtbaEdsS1+DLdxbn0hqbg==
X-CSE-MsgGUID: 8WrLVZvLTvGMYa/KamXsVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227014482"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 12:59:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 12:59:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 12:59:03 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 12:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Loul7+0xShTZovIcfCgbH/4In8vUewqXOibjyJSXoWEycXKZcvDEq1ZJ/lCpCWiEQJElVP1H0uX+exYzzFQ6nPyHcexGrp+zkDtWNNzPpj6n6fjBRCnXkM62NHTXov5u4yJufLnA1gBV+GMbGqiTne3dkstCTeLsVinpcGbQnvkoMZasoHQDuUa0zGKQphs8F1DTB38UnWBi6TG+TPKPlwR66XGkM8x6ppFqVyglsVqgoKamw4RucxsijX2S1XdYFKdK2zoHLflgiAir+xKeS2KnF0OQQeyhqcn0i7vawu7uUIiOlZmXBTlbP1YyVVKxGU2fDq2hrpO+dOioBuuzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md0zpqqPn26EOoxnib8JB2BlNTa+e6HKZR6WUBzdmW0=;
 b=Gyy1vuiflevAZ0KSQQ6XBF9Mcl1Jm777x/co8fa3GJKvlbZx+GK6W5Wbqhb789wTDWeKe4Lv4FM9ta4Ua6DM29Kgzq9D1Yg9MRlK8rjwNluHzXQT8+3h9j4tY7YGd42VE6iE91f3vshiDo/L601Ec3Rx1Gs40ARfAzUkzud+njSOtKdTUa3QLT9isHXkzB4qc2zE50TiMYkMhmXPIjTBBzDqlpb4nP1WrQAu4u1l1+CZVUw2p6P3XoOWbMuMMrqOBhDyeMXNzBEUt1Mg5snZeZPkOddBNlVY/eS2OKUDhNp584V+xwRtGvu7VbKZdqgi48H1c72GF9uGf3borv05dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:58:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 19:58:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Thread-Topic: [PATCH v7 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Thread-Index: AQHcwQwKfzyh37Ly8UCrIvEL2Q9aZLXfECgA
Date: Tue, 14 Apr 2026 19:58:57 +0000
Message-ID: <af7732a08fcce4a21ff14b2038acbb85200c6f34.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-18-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-18-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8313:EE_
x-ms-office365-filtering-correlation-id: bbcc4f72-8663-4246-a877-08de9a6043cd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: iUPgWgok14CQXaPpvsQFDZRFQh/YdTjIiw36FRYWmZ417r1hfpfZM9tJKTvFjlm+cxPhw5cWWD8hzc+xX0SRLcnlqtYsuLKXewNh0qAceEXeLLqZzCdBzmWmMhv65oAPQZkVNVtu66YZihGCvGlefjumAXmRwCDJyniMDv4o2sU1IyhGYrtiKm06igU0B8AT3Dpkrt2T3EOS4WUA4MsOvRbXUnc5vJkMEp2HUuR4Uvt0P9jPyYkLoSLB+tiHlvytMFm7QSVNqjtbNCwejdNAbiWiAA2/frC1OiMc/MN7f6I4B7/UQ7RyIZrwaODqQpF7jmjOcZ8y/SNShWRnVSgdUFHRxtE5lbSzzUa7P5/eh+vNCLtVfNZ28+Ffs3XJYO8eTS7IkkwqAaE8duEMn3BSmEdPUnpVTI/stF6Jl2MaI/7DEzWOfiZsCA0JMCqW4Um563wfcZ/Lec0AcEBkPA2KeDZcvEyDT6bJMTcX8efRUMkZRlDOAjb2nvbYF6M1OgrDHf1BVM7IA4ZGnSE2iUCKV4A+TuBJu5VrNQHfAgPpVWwS9DREZIcmBoMeskPJCSqPKVijKfXGHkQwDFWdisnsWeJmRNoVn0YYpfciXuqk8XwKncE/7UO21uJRXNyYlleSs1hm//XWrAtJfhh0vZDq1asOGwu/DY82EcBcptvYAzBbvnL72ftJM4Qy+rjlSqqFf93GjcrcMxp1qZmnrJqUcPVUmxAGt0Momc327TMj9J0WOgNF/LUdEgRmYm92cnnRk4zgpECfNaqkX2nngXemRWH2Uq9giNbnYuEtOO6vIzgJjz6jJI9GuBhcNI6qablv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmZrdEZ1b3BrS1JWTlZjWVp0THlzRXhKR0VGVjA4VUtqUjVnVDZJbW1Ba2Fv?=
 =?utf-8?B?ajlUSHIrMjhMSmNEblFOUTFjc2RmTVo1M2dLM2dEQkhSTnNtMjNENnhFRzJS?=
 =?utf-8?B?cms4RGJBME9PcFYxQ1NBOHZnd0E5dEVvOStpVXpMaURFRHVTcXhCS1lydHhJ?=
 =?utf-8?B?cWx1Z0NONWdYMXVKYy9OcVl0djhyd2NlL1Rwb1hHV0srTllPcjNkQ3hWK0Iz?=
 =?utf-8?B?R2dGRmJESzBMcDRSbnZLajdyM01oV2k3eTM4d01jaTFjU1lXeUhXRmlUOTl2?=
 =?utf-8?B?WmY5V1NlK3BnaW9tQXZuM2FpVllnOVZSQ1JkMnJRTzB2NHczZHZ0K2dYZFRv?=
 =?utf-8?B?SmRvcFdYS2ZpSVVuTFMwaTc3TnNWVDJaY1dhbE9scis0TzhLVm5KTXBWWVJ4?=
 =?utf-8?B?cnhNWjllbStUMHMyWDJ6ajUzWnhBQ1dsOWdxVHZSZnNSOExLVmtpYXNheWF0?=
 =?utf-8?B?VE5EeHFhRTN1MEhMMHJ1SGN0aFVKeVA4UjRmWVF1UldvS0pubzFSa0V0eUlu?=
 =?utf-8?B?TlNiSTJzV2I1UDFObUFDRzR2Ni83dlFxWUc4NXRiVXhVNm5tek9XTUVnRjhM?=
 =?utf-8?B?cUdUNmsrL1dBRGQzbkMvTjB0OHY5YkpJZi9CSG9aQjlrQlJBVDQ2V0JKam83?=
 =?utf-8?B?bFQ4WE5BT3hkb25saDloTVpOdGVuWm8xeWJ6MGIxSU93Snc2V1B4Y01ZMlRy?=
 =?utf-8?B?eWxEZjRlZkxQZVE0TkhSL2NUZ2VicFdFd3JaOXU3R0tsc1ZKMjVYb2cwdVB0?=
 =?utf-8?B?UkhnSk9pQnRZU2FVeTBWY2g5eU1HYkFpTE5DWUttS2p6bXpNMndNYW1VbGtn?=
 =?utf-8?B?S1VZZ0JrUDV5RVYxRUJmUGRMenNHNkdlQ3hua2M1SElOc0ZCblIvUHN2bDlM?=
 =?utf-8?B?ZGJhTDBjL2ZCcFVlRlBkN0I2YmdFdml4TEhHU092SzVwVkFKSUgxRjlTMVgr?=
 =?utf-8?B?U2IyUEpyOFJvb2EyUjB4VS9RSVBiMjFmOS80cGdOVmF3VHZhbTVjMEwwYmgz?=
 =?utf-8?B?Wk1Sa1Q0dFkwRFBQYlJpZW13V0k5T3FYY0l5QWV1T3BRbzQ0dkhiOFlaMVNF?=
 =?utf-8?B?VkErcUpsam9MQmpSNUlibWwxdHVVcGs0RTlPb256WC9xVkdVRWVHbjR3WGFK?=
 =?utf-8?B?MGFJWW43eEh1c21wVWZ0aTBNbjdFbjNKVk1yVnNwZG52OHIxVTYreFdaelBp?=
 =?utf-8?B?YlFOUnpYV05pa3lsd0dpblFzOHFpR3JuN01GTFZ6Q2FMZlhDQmJQY2NyMVYx?=
 =?utf-8?B?aERsbGxPNW14UVRVRVgrLzJFSm4vejhHMitzUFhwbTcwR21jcW80aWk0N1dz?=
 =?utf-8?B?Y0o1WTBadWh2M2JDb3Y2V1ZrMGdoMXErSzZMV21oY3BCcDFtNWVxRFlVUVE2?=
 =?utf-8?B?RmRvbElVNlBrL3FLdGNvakRhRHJObDczbFVITi83dGxGWUluWHZIMHhPdm5k?=
 =?utf-8?B?NDR4N1NRdHNMR1Jha3dzM1k4akdmNStUSFAyVG5BQVNqOW1LV3FMZWg5OGUr?=
 =?utf-8?B?RHN2YjZwNFd2M3M4MDNkTjR4NnhteWd1NUFLdkltSzR5T0FPR0djQ1ltdWVo?=
 =?utf-8?B?bkdrai9VU0hVUlNNUjJpejFEekxTRjBmcFNtc1kzZXA2RWNjS1JyNmx3WFVC?=
 =?utf-8?B?L0UrS2RoZWlVV214R09MU0JYQVE0Tm0zejM5MUlvRHRUcEtac0huNlNhTlN4?=
 =?utf-8?B?NC9qeDB5aFhPN3RSbjRBWkdvWE41aFk0WTRZKzROVkN6Z1JmN3pNNWxsaEw1?=
 =?utf-8?B?NGdKYVRqMmJQM2hmWDhOOXNPalNMQVBBRHRrL1dPTXpJdlBUWlJSL2ZVSldF?=
 =?utf-8?B?ZTB6ZHJIR1dGNndzOUlKQTBaSlBtVjgwQllNWVpSWm4xRDkwakdHSkhWQkg5?=
 =?utf-8?B?dUdTMzBGNU55dEp4VWFNRVlEMU1pdTIvUDE2UldSV2xLcjlHcUlsVERDaFhy?=
 =?utf-8?B?amtCS2VkcU5BZkFlK3ZYanJ5WmxpNjJESVRmS1VMK1FpTlo3bno0aWFaWnBx?=
 =?utf-8?B?S1RRUTJ0NE5nMlp4RkxTZ09yOWlYYVA0RmpUUXpPSHQrREFYdmVVN21ZbVVR?=
 =?utf-8?B?NWlxVWt0ZXczZXZ0THo4cWJiczlMN0tHUkFzT25Wa2dPaW5XTXlSck5KRmha?=
 =?utf-8?B?VW9FMnp4UE5OSVFrTjNKTkpnQUxKcFJsdk40NTEzbkY2dWpmTlR1dWFqWjJJ?=
 =?utf-8?B?RVF1NG9uRkdsaWkyKytxU21Cc2xFZmVFNi93a29TUkhST1RWWXBDSWk2dnZq?=
 =?utf-8?B?Si9wVlc3Q3hkT3VDSlQyWXhYODlqdmdTUXNGY05nSFQ5dFVNb3ppcXF0NTUr?=
 =?utf-8?B?cXhyeld5RVZINGM2YUQ0Um4rc1FaY1ArdWdNMWpHeGFVZStmVENyL000Z2VC?=
 =?utf-8?Q?1Ti1eNiZeHwkJK5I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30B6F2344348874E8E854313B31FE350@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PFrsMy5TORgTIumjUlesa5nf1wXoxTzDBIIdu2OhD87ZPT+L5A6/VX91RBI8fvoc5R3c24eYdH0MRkztbuoIcgcG1oOniZzPohtcNP0dSB1el1n/GCiWczg7KSHeOH6W549molfelevy5Q/5gj31pKMChcuEDIdFfU+PBDJ+S6WYHGiSU+aF/4lp+2bmOqoj6qX7ikfebc1IrPba59QDnWKbHc/r8JZa8fDyC3QM890xzEyZ4UA20W8jGV67jYIynpaOzbdYPvQbewg55wn12xJELevJP5A9pQ0bA0LUTKbl0OLNI2cR6pQuwuwYbF8ulfh4hpu1IMJfDbep/vu+CA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcc4f72-8663-4246-a877-08de9a6043cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 19:58:57.8160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TeZzu68rw6/f1ZDdFC8XQhidOBqypzNVOr4DozpSmL1D0Ut5UUGqam8AYK5izWV4ykueIL6RyhYXUDYyqBA7jG40WwrUqA/BOwru5jbhCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8313
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQSBy
dW50aW1lIFREWCBtb2R1bGUgdXBkYXRlIGNhbiBjb25mbGljdCB3aXRoIFREIGxpZmVjeWNsZSBv
cGVyYXRpb25zIHRoYXQNCj4gYXJlIHVwZGF0ZS1zZW5zaXRpdmUuDQo+IA0KPiBUb2RheSwgdXBk
YXRlLXNlbnNpdGl2ZSBvcGVyYXRpb25zIGluY2x1ZGU6DQo+IA0KPiAtIFREIGJ1aWxkOiBURCBt
ZWFzdXJlbWVudCBpcyBhY2N1bXVsYXRlZCBhY3Jvc3MgbXVsdGlwbGUNCj4gwqAgVERILk1FTS5Q
QUdFLkFERCwgVERILk1SLkVYVEVORCwgYW5kIFRESC5NUi5GSU5BTElaRSBjYWxscy4NCg0KSG93
IGV4YWN0bHkgZG9lcyB0aGlzIHdvcms/IFRoZXJlIGlzIGEgbmV3IGVycm9yIEkgc2VlOg0KVERY
X0lOQ09NUEFUSUJMRV9NUlREX0NPTlRFWFQuIEl0IGdldHMgcmV0dXJuZWQgYnkgdGhvc2Ugc2Vh
bWNhbGxzIHNvbWV0aW1lcy4NCg0KSSB0aGluayg/KS4uLiBURFhfSU5DT01QQVRJQkxFX01SVERf
Q09OVEVYVCBnZXRzIHJldHVybmVkIGJ5IHRob3NlIHNlYW1jYWxscyBpZg0KdGhlIHByb2JsZW1h
dGljIHR5cGUgb2YgdGR4IG1vZHVsZSB1cGRhdGUgaGFwcGVucyBiZXR3ZWVuIFRESC5NTkcuSU5J
VCBhbmQNClRESC5NUi5GSU5BTElaRS4gU28gaWYgdGhlIGNvbXBhdCBmbGFnIGlzIG5vdCBwYXNz
ZWQgaW50byBzaHV0ZG93bi4uLiB0aGVuIEtWTQ0KZ2V0cyBzb21lIG5ldyBzdXJwcmlzZSBlcnJv
ciBjb2RlcyB0byBoYW5kbGUgZGVlcCBpbiB0aGUgTU1VLg0KDQo+IA0KPiAtIFREIG1pZ3JhdGlv
bjogaW50ZXJtZWRpYXRlIGNyeXB0byBzdGF0ZSBpcyBzYXZlZC9yZXN0b3JlZCBhY3Jvc3MNCj4g
wqAgaW50ZXJydXB0ZWQvcmVzdW1lZCBUREguRVhQT1JULlNUQVRFLiogYW5kIFRESC5JTVBPUlQu
U1RBVEUuKiBmbG93cy4NCg0KV2UgZG9uJ3QgbmVlZCB0byBjb25zaWRlciBtaWdyYXRpb24gZm9y
IHRoaXMgY2hhbmdlLg0KDQo+IA0KPiBJZiBhbiB1cGRhdGUgcmFjZXMgVEQgYnVpbGQsIGZvciBl
eGFtcGxlLCBURCBtZWFzdXJlbWVudCBjYW4gYmVjb21lDQo+IGluY29ycmVjdCBhbmQgYXR0ZXN0
YXRpb24gY2FuIGZhaWwuDQo+IA0KPiBUaGUgVERYIGFyY2hpdGVjdHVyZSBleHBvc2VzIHR3byBh
cHByb2FjaGVzOg0KPiANCj4gMSkgQXZvaWQgdXBkYXRlcyBkdXJpbmcgdXBkYXRlLXNlbnNpdGl2
ZSBvcGVyYXRpb25zLg0KPiAyKSBEZXRlY3QgaW5jb21wYXRpYmlsaXR5IGFmdGVyIHVwZGF0ZSBh
bmQgcmVjb3Zlci4NCj4gDQo+IFBvc3QtdXBkYXRlIGRldGVjdGlvbiAob3B0aW9uICMyKSBpcyBu
b3QgYSBnb29kIGZpdDogYXMgZGlzY3Vzc2VkIGluIFsxXSwNCj4gZnV0dXJlIG1vZHVsZSBiZWhh
dmlvciBtYXkgZXhwYW5kIHVwZGF0ZS1zZW5zaXRpdmUgb3BlcmF0aW9ucyBpbiB3YXlzIHRoYXQN
Cj4gbWFrZSBLVk0gQUJJcyB1bnN0YWJsZSBhbmQgd2lsbCBicmVhayB1c2Vyc3BhY2UuDQo+IA0K
PiAiRG8gbm90aGluZyIgaXMgYWxzbyBub3QgcHJlZmVycmVkOiB3aGlsZSBpdCBrZWVwcyBrZXJu
ZWwgY29kZSBzaW1wbGUsIGl0DQo+IGxldHMgdGhlIGlzc3VlIGxlYWsgaW50byB0aGUgYnJvYWRl
ciBzdGFjaywgd2hlcmUgYm90aCBkZXRlY3Rpb24gYW5kDQo+IHJlY292ZXJ5IHJlcXVpcmUgc2ln
bmlmaWNhbnRseSBtb3JlIGVmZm9ydC4NCg0KVGhpcyBzdWJqZWN0IGhhcyBoYWQgYSBsb3Qgb2Yg
ZGViYXRlIChhcyBsaW5rZWQgYmVsb3cgaW4gdGhlIGxvZyksIGJ1dCB0aGUgd2F5DQp0aGlzIGlz
IHdyaXR0ZW4gbGVhdmVzIGEgbG90IG9mIHF1ZXN0aW9ucy4gImRvIG5vdGhpbmciIGlzIG5vdCBh
biBvcHRpb24gaXQNCnNheXMsIGJ1dCB0aGUgY29kZSBkb2VzIGp1c3QgdGhhdCB3aGVuIFVQREFU
RV9DT01QQVRfU0VOU0lUSVZFIGlzIG5vdCBzdXBwb3J0ZWQuDQoNCj4gDQo+IFNvLCB1c2Ugb3B0
aW9uICMxLiBTcGVjaWZpY2FsbHksIHJlcXVlc3QgImF2b2lkIHVwZGF0ZS1zZW5zaXRpdmUiIGJl
aGF2aW9yDQo+IGR1cmluZyBURFggbW9kdWxlIHNodXRkb3duIGFuZCBtYXAgdGhlIHJlc3VsdGlu
ZyBmYWlsdXJlIHRvIC1FQlVTWSBzbw0KPiB1c2Vyc3BhY2UgY2FuIGRpc3Rpbmd1aXNoIGFuIHVw
ZGF0ZSByYWNlIGZyb20gb3RoZXIgZmFpbHVyZXMuDQo+IA0KPiBXaGVuIHRoZSAiYXZvaWQgdXBk
YXRlLXNlbnNpdGl2ZSIgZmVhdHVyZSBpc24ndCBzdXBwb3J0ZWQsIHByb2NlZWQgd2l0aA0KPiB1
cGRhdGVzLiBJZiBhIHJhY2Ugb2NjdXJzIGJldHdlZW4gbW9kdWxlIHVwZGF0ZSBhbmQgdXBkYXRl
LXNlbnNpdGl2ZQ0KPiBvcGVyYXRpb25zLCBmYWlsdXJlcyBoYXBwZW4gYXQgYSBsYXRlciBzdGFn
ZSAoZS5nLiwgaW5jb3JyZWN0IFREDQo+IG1lYXN1cmVtZW50cyBpbiBhdHRlc3RhdGlvbiByZXBv
cnRzIGZvciBURCBidWlsZCkuIEVmZmVjdGl2ZWx5LCB0aGlzDQo+IG1lYW5zICJsZXQgdXNlcnNw
YWNlIHVwZGF0ZSBhdCB0aGVpciBvd24gcmlzayIuDQo+IA0KDQpBYm92ZSBpdCBzYXlzIHdlIGNh
bid0IGp1c3QgZG8gbm90aGluZywgd2UgbmVlZCB0aGUgZmxhZy4gQW5kIHRoZW4gdGhpcyBhcmd1
ZXMNCnRoYXQgd2UgY2FuIGRvIG5vdGhpbmcgYmVjYXVzZSB3ZSBjYW4gcmVseSBvbiB1c2Vyc3Bh
Y2UgdG8gZGVhbCB3aXRoIHRoZQ0KaXNzdWUuLi4gVGhpcyBsb2cgaXMgbWF5YmUganVzdCB0cnlp
bmcgdG8gcHV0IGEgYnJhdmUgZmFjZSBvbiBhbiBpbXBlcmZlY3QNCmNvbXByb21pc2U/DQoNClNv
LCB3aGlsZSBJIGRvbid0IHdhbnQgdG8gcmUtb3BlbiB0aGUgZGViYXRlLCBJJ20gbm90IHN1cmUg
dGhlIHBhdGNoDQpqdXN0aWZpY2F0aW9uIGlzIGdvaW5nIHRvIHBhc3Mgc2NydXRpbnkgYXMgaXMu
DQoNCkluIHRoZSBsaW5rIFsyXSwgRGFuIHNheXMgIkRvIG5vdCBtYWtlIExpbnV4IGNhcnJ5IHNo
b3J0IGxpdmVkIG9uZS1vZmYNCmNvbXBsZXhpdHkiLCBhbmQgYWxzbyAiRG8gbm90IGluY2x1ZGUg
bG9naWMgdG8gZGlzYWJsZSB1cGRhdGVzLCBkb2N1bWVudCB0aGUNCmV4cGVjdGF0aW9uIGluIHRo
ZSB0b29sLiINCg0KSXQgc2VlbXMgdGhpcyBkb2VzIG5vdCBleGNsdWRlIHRoZSBvcHRpb24gdG8g
anVzdCB0byBhbHdheXMgcGFzcyB0aGUgY29tcGF0DQpmbGFnLiBCYXNpY2FsbHkgYXNzdW1lIHRo
YXQgdGhlIFREWCBtb2R1bGUgd2lsbCBhbHdheXMgc3VwcG9ydA0KVVBEQVRFX0NPTVBBVF9TRU5T
SVRJVkUgaWYgaXQgc3VwcG9ydHMgVERYIG1vZHVsZSB1cGRhdGVzLiBXaGljaCBJIGd1ZXNzIHdl
DQpzaG91bGQgZXhwZWN0IHNob3VsZCBldmVudHVhbGx5IGJlIHRydWUuDQoNCkluIFsyXSBEYW4g
d2FzIGFsc28gYWdhaW5zdCBjaGVja2luZyB0aGUgVVBEQVRFX0NPTVBBVF9TRU5TSVRJVkUgZmVh
dHVyZTAgYml0IHRvDQpnYXRlIHRoZSBmZWF0dXJlLg0KDQoNCkZvciB0aGUgcmVjb3JkLCBJIGRv
bid0IGxpa2UgYWxsb3dpbmcgdGhlIHVwZGF0ZSB3aXRob3V0IHRoZSBjb21wYXQgYml0IHNldCwg
YW5kDQpteSBjb25jZXJuIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggdXNlcnNwYWNlIHJvbGVzIGFu
ZCByZXNwb25zaWJpbGl0aWVzLiBJbnN0ZWFkDQppdCdzIGJlY2F1c2Ugd2UgYXJlIG92ZXIgYnVk
Z2V0IG9uIGNvbXBsZXhpdHkgZm9yIGhhbmRsaW5nIFNFQU1DQUxMIGVycm9ycw0Kd2l0aGluIEtW
TSBhbmQgdGhpcyBtYWtlcyB0aGluZ3Mgd29yc2UgdG8ga2VlcCB0cmFjayBvZi4NCg0KdGRoX21l
bV9wYWdlX2FkZCgpIGRvZXMgYSBLVk1fQlVHX09OKCkgaWYgaXQgc2VlcyBhIG5vbi1idXN5IGVy
cm9yLiBJbWFnaW5lDQp3b3JraW5nIG9uIHRoaXMgY29kZSBhbmQgY29uc2lkZXJpbmcgaWYgaXQg
aXMgYSB2YWxpZCBLVk1fQlVHX09OKCk/IEFmdGVyIHRoaXMNCnBhdGNoLCB0aGUgYW5zd2VyIGlz
Li4ud2VsbCBzb21ldGltZXMuIEl0IGRlcGVuZHMgb24gdGhlIHByZXZpb3VzIG1vZHVsZXMNCnNw
ZWNpZmljIGZlYXR1cmUwIGJpdHMsIGFuIHVuZGVyc3RhbmRpbmcgb24gYWRtaW5zIGV4cGVjdGF0
aW9ucywgYW5kIHRoZQ0KYmVoYXZpb3Igb2Ygc29tZSBmYXIgYXdheSBjb2RlIGluIGFyY2gveDg2
LiBHYWguDQoNCkFjdHVhbGx5LCB0aGUgZGlmZiBEYW4gb2JqZWN0ZWQgdG8gd2FzIGNoZWNraW5n
IGFuZCBwcmludGluZyBhIHNwZWNpZmljIGhlbHBmdWwNCmVycm9yLiBNYXliZSBoZSBkb2VzIG5v
dCBtaW5kIG11Y2ggbW9yZSBzaW1wbHkgY2hlY2tpbmcgYW4gZXh0cmEgYml0IGluDQp0ZHhfc3Vw
cG9ydHNfcnVudGltZV91cGRhdGUoKT8gT3RoZXJ3aXNlLCBJJ2QgdGhpbmsgdG8ganVzdCB1bmNv
bmRpdGlvbmFsbHkgcGFzcw0KVVBEQVRFX0NPTVBBVF9TRU5TSVRJVkUgd2l0aG91dCBjaGVja2lu
ZyBmb3Igc3VwcG9ydC4gRXNzZW50aWFsbHkgbWFuZGF0ZSB0aGF0DQppdCBpcyBhbHdheXMgc3Vw
cG9ydGVkIGlmIFREWCBtb2R1bGUgdXBkYXRlIGlzIHN1cHBvcnRlZC4NCg0KPiAgVXNlcnNwYWNl
IGNhbiBjaGVjayBpZg0KPiB0aGUgZmVhdHVyZSBpcyBzdXBwb3J0ZWQgb3Igbm90LiBUaGUgYWx0
ZXJuYXRpdmUgb2YgYmxvY2tpbmcgdXBkYXRlcw0KPiBlbnRpcmVseSBpcyByZWplY3RlZCBbMl0g
YXMgaXQgaW50cm9kdWNlcyBwZXJtYW5lbnQga2VybmVsIGNvbXBsZXhpdHkgdG8NCj4gYWNjb21t
b2RhdGUgbGltaXRhdGlvbnMgaW4gZWFybHkgVERYIG1vZHVsZSByZWxlYXNlcyB0aGF0IHVzZXJz
cGFjZSBjYW4NCj4gaGFuZGxlLg0KPiANCj4gTm90ZTogdGhpcyBpbXBsZW1lbnRhdGlvbiBpcyBi
YXNlZCBvbiBhIHJlZmVyZW5jZSBwYXRjaCBieSBWaXNoYWwgWzNdLg0KPiBOb3RlMjogbW92aW5n
ICJOT19SQlBfTU9EIiBpcyBqdXN0IHRvIGNlbnRyYWxpemUgYml0IGRlZmluaXRpb25zLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNoYW8uZ2FvQGludGVsLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnkubGluZGdyZW5AbGludXguaW50ZWwuY29tPg0KPiBM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jb2NvL2FRSWJNNW0wOUcwRllUekVA
Z29vZ2xlLmNvbS/CoCMgWzFdDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS82
OTlmZTk3ZGMyMTJmXzJmNGExMDBiQGR3aWxsaWEyLW1vYmw0Lm5vdG11Y2gvwqAjIFsyXQ0KPiBM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jb2NvL0NBR3Rwckhfb1I0NFZ4OVow
Y2Z4dnE1LVFieUxteV8rR24zdFdtM3d6SFBtQzFuQzBlZ0BtYWlsLmdtYWlsLmNvbS/CoCMgWzNd
DQo+IC0tLQ0KDQoNCg==
