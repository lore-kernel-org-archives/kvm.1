Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B4126C03
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776815458; cv=fail; b=pV6Lt9t9AAMR8ePeq5XdUU96D2TK59h/XHtc5RD+ZcJutF1wGABCgVhmKRNLP7a3VJGb3Krlhdd9MllKT1oMpyysgZUGSddzaU7rXLox8YCgl4l7QerHPFq+JZ362JVSGRhh2kFONZi9UkltvWZxoSUQdj3QhghEpKhgS6NjpJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776815458; c=relaxed/simple;
	bh=GB7rzUKHSbOogA6ZzR3VmMp7MM4iujyIBabds+CS8sY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IUMG3F6MAww6aXEaAAXLASdPB3jmcN0GZVnt5r6rECq/4OgG524rbCit89UCNAAoScxyGMnXly1w1WLM5PA94iw2C1FUgozhGIY2yW7lPTfO5eiMHE3zhbzMjdp1+mt9AdOsmteM2a1zBefJqrxBj7J+Sg1eYMujtNk8H36KZdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEvtv3XH; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEvtv3XH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776815456; x=1808351456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GB7rzUKHSbOogA6ZzR3VmMp7MM4iujyIBabds+CS8sY=;
  b=UEvtv3XHZ1YEpEbfirargndFbyWTdVMH3YUl244uZ3pibKLOoKyHsqh3
   bigBw79+pabcDoJdXDtb5cO38a/ZGzAuGTZgzTYetTkaInnuiBmNSPx/U
   dcW7Ojvt/qHm0ZAhKHyIzoqUyP9QlCkPp2iJzfawQGDmeVk5xR17l3yOt
   GL+G39tmz2YOy+UjMpGkXJHw1ca2+vXXD0KAzEbpb3mOqHwIT+dqDcmWY
   Xx2a4MF9cVOfJCF0dnLkpdyPcKEFO4L4Z7pu3JEFcxrvdWL+GFoWXezTJ
   fWFC+doeZX0zpVjh1zlJSL+R620FwO4yHRpUTY3URQ9K/Pqw4eM442OOE
   w==;
X-CSE-ConnectionGUID: B1qm8OP+TU2Y3P/Anq1zAw==
X-CSE-MsgGUID: QCzK9PStQvuUKJPaJ60geA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="76924373"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="76924373"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 16:50:56 -0700
X-CSE-ConnectionGUID: YMQJD9moSdqV4nSbV4zl8w==
X-CSE-MsgGUID: Av9NmNExRpyAyxLJgbX6rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236195677"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 16:50:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 16:50:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 16:50:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 16:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byHia/fk6WDDnH+N5s3ZlXt8Q2zsbs5hiut9GywIOcXZGDd83Zyf7//yd+3pJlglweWmnJ/HUM10xtlt1nkp+iQV1xTecvu0WX+MUp5SjSsqdFJS/2qPSELODH0HRwuxlKh3X+wzo9rirQ04WiYhWz+lBKoIWS/POEg9AAzy6RJgmCZmoCKXSASdndF0/r1sU1Rhk2FnSPzJDPQDwRAph4MnF1UiwgkcUx2ilvECsVf6kBNLo2wqkvtNLRl/oeMWa29q8gLZ6KsZlfIf3I1tRT57UYY3Ke3PBS9tbszXwhfQ7YCRa3YThk0oBWckHGT5Ljfi6R7baTgHQ3L/hlJryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GB7rzUKHSbOogA6ZzR3VmMp7MM4iujyIBabds+CS8sY=;
 b=bzJ4MFt/Xt4UKJ6aCcotnOaAyhfWjFFx/oyqwCK4A2pK+1/WhBOuaPZnkVMhG5shg5NdeFjGfs8xx0CCp/qaCm4jIeQ1sRjMHCg9Ibe2IenpToGlOW7R9/H5NGf7JlhfDVuD7R0dTYQXUDvHimu5OU/7bhDtK1BPygcwYuPmEJSHujxYj0PX5pmNqInFF55tus4LJgS8ogrl56y4yVjrcGFb88oImdMozqKJlSdNcEEYXT+iC/85/Dz2hT2YsSUEmmN4+pePOfoV82K2YJdpzBiIU1qjBpb7k+UumND3jyYugabk/78Kx5pkPsGa/OhzC7vcnFILeIzFchLDLrclBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB8527.namprd11.prod.outlook.com (2603:10b6:510:2ff::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.16; Tue, 21 Apr 2026 23:50:46 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 23:50:46 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "nikunj@amd.com" <nikunj@amd.com>
CC: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Thread-Topic: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Thread-Index: AQHcxliL7ApYp79orUu4JhjyJLC0JLXnk/4AgAIguwCAAJHqgA==
Date: Tue, 21 Apr 2026 23:50:45 +0000
Message-ID: <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
	 <20260407063245.2755579-8-nikunj@amd.com>
	 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com>
	 <aeeS7LDPJ6NCy3Uw@google.com>
In-Reply-To: <aeeS7LDPJ6NCy3Uw@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB8527:EE_
x-ms-office365-filtering-correlation-id: e03d8c73-81ea-4e2a-7ada-08dea000cea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: lLZhK6kD+AaEyixRIX7isxUJPcFWAVtD5q3JlVQTCjv1jmHc5MrVZjZLzkm13rpm4rzxYswpGBhN78kkCUVgtKlqeyCk9KcpjmHtHe3OL5P0YZeCrOr6nXMPtD+vBfff/Dooe7aM735peETXBioP/rZJxYbhnD+bC8eG+tSZACmNJFlsRTJt2z7PFR7RQmzGpBwX2ydbB5ZnjDe9crFnPCArRALJ9IxGkce19hKqe7mOobnFhm0kPMBCAv/3+tJKFJkViZto+5F9yDmM3+FeZ753yxb1169ayXRc7zkOBWXCFAqBNbV0XoeBIsDXqFANiSPETB2att/jzPRxBChPHRdzNqsP0+oGha5UnwiImW67p4Mvo+EyZw5v5cybNAsg/aVXKRRBqekLK8mZ8mnYkka6/Ypy5BPkwlUdiH+qgntLxn7KO7AikuemlGqcxyERqgCrc/WOUwjdWj2gT9RLtqLEtsbm61x0e/baRuiB0rOEaJE3VfmKEovm/SPN+C8bMr1P+dRBpCZQdBaPliv83zAmr5+BuBbNlGwELB01AQ2nOyELXABVI+GX4dy2PqCE+MMdRUl059ztdxX40Ou6qBpQDm+o+p5rRtpWQW7+kS7DC7AgDzfABnBhVEi8T+ckKynnXuYxdUWrRhrP5L7UdthCmPAvE8SJotaASCU9LJeZG6Rw1gTM5Q4M/dpt5meryEkpFMKsQNufGapDO21lMI2OvIFmoHHK0hT2/jcb8J0sPc00gGi5g2mL6bI07IJJmHA3lYExcFV3OJBrJZJ/JTbAKL9epj1vAkJTjK0WDB8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWprYWo5QXRLZFFtRHVXb08zdzg2WlZmV3l3WkxPZEx4RTRYSlpEM00rWlJW?=
 =?utf-8?B?YklXckxUQkFWRmpERFhxcDk1MFU1SWF2YXM1bjNYaFRsd0ZrcjNEUmRYYkFB?=
 =?utf-8?B?dS9IUmdYS1E0aHJlRHgzUXlIbi9lTGRhR04xa2NHSGdwd0tPallMS1U3Szd1?=
 =?utf-8?B?U2crYzZnVjJoMUVpTW9RM3M2dUhmZXVGRXlEMlE4K1NRMWFnOElHNVZoVDZq?=
 =?utf-8?B?V2g2dDVkaXJMdU5md1IxSHRvTllYak4vZm4xOGRiZUhsMkJTK0dqdUxRQ091?=
 =?utf-8?B?dEtvems4QUExOWVwM0VhaVJMVjhnbVpTUGhPamRxK2ttNVg2aVpHMjJiQVQ1?=
 =?utf-8?B?dVFYbHBPMEJGOHYxdXJjRndXTGtHSkE4ZC93eTR3MGVVbS9Ud2d1UkhGSzAx?=
 =?utf-8?B?Sms3S0pmN2tsV2h4QiswMUFNN0RIVjg3cDA2WEFCblptaTRhNEJCZ1JabFFS?=
 =?utf-8?B?V2luNGZ1WnpxaDJGZktzQ0lWZVl2dFR1Z1RCUEpqejFVYWgrMzhVY0NZbG4y?=
 =?utf-8?B?OXRTTU45OTVFZ3FNODgxN1BGOFkwUlorYW50NlFJc2kxelBkYTBOZElTYTda?=
 =?utf-8?B?c0c3VDhQN3JQYUpBZ1Z3YW5YUXNQL0xYYTBGdjJPRHdZWWRoVlRrb0x6RFA3?=
 =?utf-8?B?ZFBGUTNVM01RT0dyc1dNN0lrOUllWTVxTlc4M1pCNGVYRDhNOTBvang1eEFo?=
 =?utf-8?B?cFQxWnBmeFkwYm9Ba2FyYmdEN1AySExuMnVvSUdId2s3R2Rpa3ZLUDJubTVO?=
 =?utf-8?B?eXZnWjRaeHdvbW5rcXBzV3hCbllUTWJqUzFKbm1HWDJFSnZlNGlXWXpmL21H?=
 =?utf-8?B?MitDcXIrY2wvZkdwRGFaWkZqc1YzUkNmSU9JeUw0RURFMTU1dFNTS0c0Zjk1?=
 =?utf-8?B?ZjZFdlFYNXpHRDk3MXpPSE4xOWpGSWo0Y1lLUEU4akh4Z3h1ZHpsYXJkMVpu?=
 =?utf-8?B?aGlWQ21tNytpL1EwU3kyTk1pOFlrc0gzQjNHc3NmRm9VRVFzMGFsYVRmSjBX?=
 =?utf-8?B?TU5vM0ozVUQ0STFZcjh1TFRaSzYzN0ZldTJDNlR2V3laMmhnOGc2RWc4aWE5?=
 =?utf-8?B?cHRaa0NRMEI4UmE5ZmZBOVFiSXNPb0JrYVFQK1NBR0tOWHRrcTFzOVovZUxW?=
 =?utf-8?B?UmkwZy8xbUREcG5UNEpZcm94T29jdzAwMnFmN1l1QkZ3NkxaTXhKREFaNEhS?=
 =?utf-8?B?Y3lUaiswNGxhZlBLOEpJc1dkVDFXQ1Q3Q0Q1L25HNFd2bmIwZjkwYUlLZ2dK?=
 =?utf-8?B?Rko0NFBzSnpmZzJINkxyUy9UZlNnM0RGSXZaTHQ0SDQwSDd0ejRXdGh2TTFT?=
 =?utf-8?B?U1hBWDIzbHZPWllob0Q0amI3T0UyL2crWHFISXZ0bWFzUWdSdmVHaHVVNm5F?=
 =?utf-8?B?MmtaeEdlUGZZUVEyWi9iZFVYeDVXSjF0Sng2Q2RjbVo5WFhJNG9ESXViM1JL?=
 =?utf-8?B?SUZaMHl4TCtaZ2VHdWJNcWRFdkRvcldMZlgvQWxzZ0szZXl5YSs0cUFSeTl4?=
 =?utf-8?B?UURvSk43Yy9tTDNNQ0g3T2lOWGFHK2RNdXYvSTRxcWE0b3RmTjV2ZE5JYVF1?=
 =?utf-8?B?Z3hEWGdqQ3R2bThqeWU3Z0tneG9BZWY4ajhhQk9vR1A3YnlaT1JTN0diSllG?=
 =?utf-8?B?dlVwZHZIblpDL21zMlZVekI2SktFTmFubldPRCtmd2drRFFvb3FLZzE3MzhO?=
 =?utf-8?B?ZXMvbTdndHFvRUpQeThYdjZmS3VQQzFJUFF1K2RvWnd1dGI2eVhaZkV3ZjEy?=
 =?utf-8?B?WWtQVDdzL05ZT3JtUVlBMVZCd1lmb3lYRnlKNFEvYUJXalJ5dVpTUC9EeXg3?=
 =?utf-8?B?d1JZRmVHaFU1Z1crTGwzS3Z5NzZDVGJCVkR0MDROVmZuelNmQnBRNGg2Nmlj?=
 =?utf-8?B?enY1SEhVZWJGSFlDb2tVZzR0d1Ryd29Wa1lhbm1teWdGbC9qOVVaZWZ0QTNt?=
 =?utf-8?B?d2VaaWROdzFLa1htQzAxR0ZmVllYYmVSRUNhRGF1QlNSdFJTMkIvcWFjTlh5?=
 =?utf-8?B?alJQalN2NzNxNzFya1ZtYTZ2OWpENFhEOWpmaVR2QVQ2R0FQVXpZY0R2bU1X?=
 =?utf-8?B?ZlFUdXdSaDR3RkxPelJ5K0dIb3R4UjVzWTZ0Y08vMmdrOU1LVm9uYjY0eStY?=
 =?utf-8?B?Q0tVdXYyOFZZbHpUa0hPTnJyTDYzQmE5ODZzN0RVZjkrQjgrQVJlaDZqcUtl?=
 =?utf-8?B?MHVVZzRQV1J0MDk1ZlNjZmUvejhUV3lUbThDMFMrZkgyNWEzdlJwT2VVcVRO?=
 =?utf-8?B?QkgvYkkxWllGWXNGRWRDbWtlcFhlMlZiS3JpbWtlOSsvREFaeDlrQ0lzVXBx?=
 =?utf-8?B?bWU2dGdNT1M5WnE5NTBwaGFteUI1N21HSVJUVTZvL2tFem1iaE1rQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD788D8EED27C04EBFA3CDF1D9C404BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dG9iPvFvEOGwXgHLBB5hwD27hcM/PeDc/ORiidD071Ow7sRF5gJSUTZ4QmFDXl9VJzJD6DWd9pBdtdw8VZB+zBkLiNeJ9yaPv/wi1jOzVen7I6Y4I5z8ISs4+cINLNIkJqSoN5RiVtLWnZhOMvy8F1TgVpibwsqtSFkP71yI9NYQf94O+gPDq/+zLy5TW8zBrsp024bhMFSpIy3XVGiAXXCITdEcq9OSB/dq9lVRXgEJS6/1rSW4CE5CTBL9DsZK2OdQtU7ydmrpsSpm2cnwzuPrUBvztq4+2z52iYRmaFSNoU/8vassi3RHkl2FssxMQefT6tXQCuYIXZjYeh6elQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03d8c73-81ea-4e2a-7ada-08dea000cea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 23:50:46.0455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMUR/6Lf/yT605oAT7ImgMbAlX0/CMS+lISkHPVrt28O/DLV2h2JNrGIb3KiwylcaS+HfkeqkAAUvp3ytSmy1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8527
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDA4OjA4IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IMKgwqAgdkNQVSBSZXNldDoNCj4gPiDCoMKgwqDCoCB2Y3B1X2VudGVyX2d1ZXN0
KCkNCj4gPiDCoMKgwqDCoMKgwqAg4pSc4pSAPiBrdm1fY2hlY2tfcmVxdWVzdChLVk1fUkVRX0VW
RU5UKQ0KPiA+IMKgwqDCoMKgwqDCoCDilJzilIA+IGt2bV9hcGljX2FjY2VwdF9ldmVudHMoKQ0K
PiA+IMKgwqDCoMKgwqDCoCDilILCoMKgwqDCoCDilJTilIA+IGt2bV92Y3B1X3Jlc2V0KC4uLiwg
dHJ1ZSkNCj4gPiDCoMKgwqDCoMKgwqAg4pSCwqDCoMKgwqDCoMKgwqDCoMKgwqAg4pSU4pSAPiBp
bml0X3ZtY2IoLi4uLCB0cnVlKQ0KPiA+IMKgwqDCoMKgwqDCoCDilILCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCDilJTilIA+IGNvbnRyb2wtPnBtbF9pbmRleCA9IFBNTF9IRUFEX0lO
REVYIC0tIFBNTCBidWZmZXIgd2FzIGFscmVhZHkgZmx1c2hlZA0KPiA+IMKgwqDCoMKgwqDCoCDi
lJTilIA+IGt2bV94ODZfY2FsbCgpOiBOZXh0IFZNUlVODQo+ID4gDQo+ID4gPiBDb3VsZCB0aGlz
IHJlc3VsdCBpbiB0aGUgaHlwZXJ2aXNvciBsb3NpbmcgdHJhY2sgb2YgZGlydHkgbWVtb3J5IGR1
cmluZyBsaXZlDQo+ID4gPiBtaWdyYXRpb24sIGxlYWRpbmcgdG8gbWVtb3J5IGNvcnJ1cHRpb24g
b24gdGhlIGRlc3RpbmF0aW9uIGhvc3QsIHNpbmNlDQo+ID4gPiBzdm1fZmx1c2hfcG1sX2J1ZmZl
cigpIGlzbid0IGNhbGxlZCBiZWZvcmUgcmVzZXR0aW5nIHRoZSBpbmRleD8NCj4gPiANCj4gPiBB
RkFJVSwgbm8uIFRoZSBQTUwgYnVmZmVyIGlzIGFsd2F5cyBmbHVzaGVkIG9wcG9ydHVuaXN0aWNh
bGx5IGF0IGV2ZXJ5IFZNIGV4aXQuDQo+IA0KPiBIdWguwqAgVGhlcmUncyBhIHByZS1leGlzdGlu
ZyBidWcgaGVyZS7CoCBDb21taXQgZjdmMzljNTBlZGI5ICgiS1ZNOiB4ODY6IEV4aXQgdG8NCj4g
dXNlcnNwYWNlIGlmIGZhc3RwYXRoIHRyaWdnZXJzIG9uZSBvbiBpbnN0cnVjdGlvbiBza2lwIikg
YWRkZWQgYSBwYXRoIHRoYXQgc2tpcHMNCj4ga3ZtX3g4Nl9vcHMuaGFuZGxlX2V4aXQoKSwgYW5k
IHNwZWNpZmljYWxseSBjYW4gZ2l2ZSB1c2Vyc3BhY2UgY29udHJvbCB3aXRob3V0DQo+IGdvaW5n
IHRocm91Z2ggdm14X2ZsdXNoX3BtbF9idWZmZXIoKToNCj4gDQo+IAlpZiAodW5saWtlbHkoZXhp
dF9mYXN0cGF0aCA9PSBFWElUX0ZBU1RQQVRIX0VYSVRfVVNFUlNQQUNFKSkNCj4gCQlyZXR1cm4g
MDsNCj4gDQo+IAlyID0ga3ZtX3g4Nl9jYWxsKGhhbmRsZV9leGl0KSh2Y3B1LCBleGl0X2Zhc3Rw
YXRoKTsNCj4gDQo+IEdpdmVuIHRoYXQgU1ZNIHN1cHBvcnQgZm9yIFBNTCBpcyAob2J2aW91c2x5
KSBvbiBpdHMgd2F5LCBpdCdzIG1pbGRseSB0ZW1wdGluZw0KPiB0byBhZGQgYSBkZWRpY2F0ZWQg
a3ZtX3g4Nl9vcHMgaG9vayB0byBmbHVzaCB0aGUgYnVmZmVyIG9uIGEgZmFzdHBhdGggdXNlcnNw
YWNlDQo+IGV4aXQuwqAgQnV0LCBJIGRpc2xpa2Ugb25lLW9mZiBrdm1feDg2X29wcyBob29rcywg
YW5kIHRoYXQgb25seSB3b3JrcyBpZiB0aGVyZSdzDQo+IG5vIG90aGVyIHZlbmRvciBhY3Rpb24g
cmVxdWlyZWQuwqAgRS5nLiB2ZXJ5IHRoZW9yZXRpY2FsbHksIGEgZmFzdHBhdGggdXNlcnNwYWNl
DQo+IGV4aXQgY291bGQgYWxzbyBiZSBjb2luY2lkZW50IHdpdGggYnVzX2xvY2tfZGV0ZWN0ZWQu
DQoNClNlZW1zIHZteF92Y3B1X3Jlc2V0KCkgZG9lc24ndCByZXNldCBQTUwgaW5kZXggdXBvbiBJ
TklUIGV2ZW50LCB3aGljaCBzZWVtcw0KdG8gYmUgZmluZSBzaW5jZSB3ZSBhcmUgbm90IGxvc2lu
ZyBhbnkgZGlydHkgR1BBIHRyYWNraW5nIEFGQUlDVCAob3RoZXJ3aXNlDQp3ZSBhbHJlYWR5IGhh
dmUgYSBidWcgZm9yIFZNWCBoZXJlKT8NCg0KSG93IGFib3V0IGRvaW5nIHRoZSBzYW1lIGZvciBT
Vk0/DQoNCkFsdGVybmF0aXZlbHksIHdlIGNhbiBhbHdheXMgbWFudWFsbHkgZmx1c2ggUE1MIGJ1
ZmZlciB1cG9uIElOSVQgYmVmb3JlDQpyZXNldHRpbmcgUE1MIGluZGV4LiAgVGhpcyBzdGlsbCBh
bGxvd3MgdG8gZG8gdGhlDQpFWElUX0ZBU1RQQVRIX0VYSVRfVVNFUlNQQUNFIGNoZWNrIGluIHRo
ZSBjb21tb24gY29kZS4NCg0KTm90IHN1cmUgd2hpY2ggd2F5IGlzIGJldHRlciwgdGhvdWdoLg0K
