Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF6179A3;
	Sat, 22 Aug 2026 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356885; cv=fail; b=ZT6UqrOxnwPWtzbvlniOtLyQZjVm8pIWaon8DnVRPE+Ke+LTSU5ew5jNZbtBvIf7zAqVBwGaWkYAwjAxbJo0R9B5m/DsKaeFp9t9uhWWp7YM0mtQpRNxx5d5DWyJqfkHm5oCtQKZP212fNGDAaOF2HUnzkqJQ8xIcXAtC0T9FTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356885; c=relaxed/simple;
	bh=LTmsTyCtiy55DnX/oiybm/6KQoKLJuVGdfW8FJyW9bw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+X3VV8/CLNKGdZC3r+hzPxFQREo7ASw8Fm+tEYzzpUhe0cYLOYFy0uOPfJR32K1ClY5iQa2IE8J5JoysvWFV4/p12EHu3NmXDoOVdfXV86NUl580K7iJEHigsgKs3194XK2Ia6yx5Qd5agKo+/UTECzqIOdn5O/x50cM9xhitE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iO1fn3oI; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iO1fn3oI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787356883; x=1818892883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LTmsTyCtiy55DnX/oiybm/6KQoKLJuVGdfW8FJyW9bw=;
  b=iO1fn3oIiJxSm9RdL31T/morwfjwZF/N1W74OaA49L4sZO3gusWecWxB
   TDcOSFuuZ1DahnfooCsK0CB3UWdGhJ+pjr+f+8YhvfQp5hozIiE7lProa
   nZn7hW2VEeuQQ74LiEcCjXmYPBrOEGNddhCPAqwIB8zAgbjlCQKIYttj7
   WT2tQMe6H6LDlPs+MkwJRZyN9bUgwBg9J0ST/mT31p2hdcqtAX1w1B4zj
   ftHWWGZ4bPTtL2AsPek97hjGs5Gy31245OxjW2spWkKtcloHxmw+Rc9Up
   GDiGrE3ifD5DwRoUlEKTT1LvOQDvK+j04hft4YurnNhP2s/pmBlmAUos0
   w==;
X-CSE-ConnectionGUID: pVXBPZPnS/uFOIDVQD5C5w==
X-CSE-MsgGUID: wzp7fYmeSniF2TWy8z/+Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91583972"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91583972"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:01:23 -0700
X-CSE-ConnectionGUID: l4IqpCDMQjGOPf5om+b9YA==
X-CSE-MsgGUID: LUb+NRJOS5Kl9o7EzoaFyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="263832121"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:01:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 17:01:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 17:01:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 17:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpKm/g+dlrQKsuX2MCehVUC5MCgt/FPgGW8flJE3FOv8Hlk9z9PJXj1hqfe2ArMOBLnDcCJ7uu+f/ucQpsiijsWxhrZhMbH9MDTuIcXuveRVbY0rcc9tqUWkf/cnOtXj5YlrPh2fIEcNKdc2w+ru+CRfq2/AEFpSMj5pgOtTvoYNnkJSQYE6nDeOccR/WI+INI5igmhTH1cHAAQYbU++AWB6YkF6alAnehNEjQ9vd5pb+ZxzdXkHCqjrJ2g+UahwtWmti5qSPqE8Frepyh52oVAdrsN6fbOYkK211GQoqtVWHEh3JnAqfhPWF47uhPUg053kDZWKGLFRP3rL0nl2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTmsTyCtiy55DnX/oiybm/6KQoKLJuVGdfW8FJyW9bw=;
 b=BhDIz/BR9W3NXK0DyA5dpBurbx4ueLVd4YavjnDvkK7AdPmOHsmhxb/jB4s+XyUGQTiwNyPhbrFEG2ssqkKFEo7I58HJELOGbJAPy3gqGqXDkw3Na1RLZcVNrYlCG9XQPnqJWEDi/IzixI3yuEEErY5Jwon7LOQCbz1BlcJreNehqZPfY9uh6PXFRk6bPmathFCue+BPVtk3tRZ4ch5EVe19uOjx2DTh/k05Uyh9GGtlzSQiEaZVcjbpKyDDke/Z9vsuMyKZxohnH6GgS3G9RXs1IkwxeOTMYMVnKnA2kL5twdqQfFZAtoST817+Yup2WU4L5NjtpUyunyv0kW7qIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 00:01:09 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.008; Sat, 22 Aug 2026
 00:01:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 6/6] x86/virt/tdx: Re-initialize the extensions on runtime
 TDX module update
Thread-Topic: [PATCH 6/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Index: AQHdMR1az2oJt2dWrUC5JTwYmW+NErapMG0A
Date: Sat, 22 Aug 2026 00:01:08 +0000
Message-ID: <2d1d8e9a5fd342583998625ca38776058764d8ac.camel@intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
	 <20260821032920.256225-7-yilun.xu@linux.intel.com>
In-Reply-To: <20260821032920.256225-7-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA2PR11MB4873:EE_
x-ms-office365-filtering-correlation-id: 62920da1-449e-44ee-6f56-08deffe0783d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 00nrWNYYQMaLVlQ2ahHr49ZJZleAnBcChizbnbseAGHVrIGT64cF5+SyJxP0AZfMrm/EsMXYEy1VaZ9Ices3rMFfIrj8mIowhPmCehWNPh32aHMHabMxqrkbrojwlsQAzDxxFMH+CyCDM3yS1rXYjnc4Wk1/qLmsfPQryr6Y7hfIJigIilI6TJobFuBbsNsExi0Pmn29iSe1qpSrVv66/ZlyVmjogD4NiH0/hQ9ZFzvSnDlI3PQTcA3VTy+/UQeGZYp1cWNbb1hlel4FqFtpUFE7ygxdUzayVYhD7yHXhVx74Fbp2rb9mZiVBIMKz5OMLpvWWIhMyDRdwCQ1yx9DjmQ0WmU+BD8Q9qOX2ex5e/YCnsKgbin0eppcVLOeGtx0M6sl3nBxHus8omC//3Pc4XDiuujP7LuFRDqIDKj4rL5w6X0H//wmMbIyWwbJehP1EIxb6X8m80RTskxL3mYRtnoChdSNIeJ1VkdqT7gx9YhQJhtMqnLSz/0p8oGvgLvXf/y2+HxyniUVB1baOHOz+63nMQhhD8WDENTH44lHi6BJcNPGt6PJJ1u/RnkLGh228tzmbhqA0hyxWcO5vqVW4PVOHBUFFI9Pf5MtWY/pwzYx8wqPGBMr65yrC+aIwm3/aFmqIfyezmr9JgkjTxXPBVZRF1VkLxA65hzlsZSNHq/2+OMXz8qym5Opavax+Y2kAB1cKU3MaLhL7FfAIbOWWt8ZxzgCOv5DGjzcE1axiyM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVFUUUo1RytmcTBGNFo3UlhUbzdYMnA4cmNMYkg4TlNyQTI4c1VZK1h0eW84?=
 =?utf-8?B?Tjh5aUdvT3FiQ00zKzNWbFdFV01IZG5uUDllaVZ5QjJLdTh5QjNaS0xhakpx?=
 =?utf-8?B?alplM2w4OVBoQjFQWERnS2IwM2tNRFA3cUh0TVMzWkdocEkvUThYcnQwcWJJ?=
 =?utf-8?B?K0ZVTXViWHd0cUF2VjdUcGpYOGVQdEovTWJuQmdUUy9tekFCb1p5TVZuS2hu?=
 =?utf-8?B?bkpFbU55bzZHb1JkS0FGdi83bWJyWVV0ZUVnT3Znd2dTbFdkMkZuR3N4dkF1?=
 =?utf-8?B?SWovdXlLWWI2SXdDb09vQnE0K1kwOWpMRWdNd2JNTEV5eVUydnczZitRSEc4?=
 =?utf-8?B?akM3RzIwd1JKSTZXbTRtZFM0cGtKU2pGaTJyMjJzM0U2SEhMZUxCN1ZpTFpH?=
 =?utf-8?B?TGlUR2phK2NHS1dLeDRKM0p0OFZMVkVvN0dvWDJCUC9LY3JTRk1Ja0FUMGU5?=
 =?utf-8?B?UXpDSVRqZUdWVjRQbkRuR3hTQW9CZVcyUW4vY2VOeXZVVnN6cEtZdjVwTUtF?=
 =?utf-8?B?eUhPcUdZcVZnNmRjUlRpWXlLYldtZUE2VzdnajVlU3hXa2xyVGNOL1gyVGxy?=
 =?utf-8?B?VFpvUDZyVk9nMC8zOXBsZVEvR01rL2VPN2lMdHcwSVJOa29UY0dkMXlLNGxK?=
 =?utf-8?B?OU5UdHJQRkw0SThzVlJIcW1qQzZMWW4vY3UvcjNnUkxjYTZJZCttQjRjeFBO?=
 =?utf-8?B?RHVTSUlOUkVBWWNGSG1XbFdheUR1MmQyRS9KaHZpMjNsMDk1Q3Z6NHh6NkJp?=
 =?utf-8?B?U2twajFCR2ZhZEFrbzg5ZzcrdkdBTi9nRmxPUkVhTk55V3FUY2Z3b2pTdXUx?=
 =?utf-8?B?dlp3blN0N0VmTVV0YjB6ZnBEVkVISUo2WjZCcEZlNmtHZERKcEdWQ0p0dEJI?=
 =?utf-8?B?R2dyR1FZaXBnWFRyaGJ2OUhxUUpyQytncXd0L084aEtZbDZYSm00S0RCb1VF?=
 =?utf-8?B?dmtkWlU2S01Ca3FWYlB2OFYySzlyRExCb2MzaU9LWUljMDUvTlN0eVplUzcx?=
 =?utf-8?B?L09GdXpBUkRJTDZ5UWlLSCsvNDQ3M3NSdXMzWGw5NlhXQWN4TjEzR3VoQkxZ?=
 =?utf-8?B?L2JKQUVoZDRpKzBMSE1kRTdzaWpOMEFLcEpueHhqWEZRaDUyZEc2ZmQxNlBu?=
 =?utf-8?B?Y1FCOThud09mRGNxbHo2aE5tUG9IZ3dFMU5pYWRHM2xRTUVMTjdFWmZhd29S?=
 =?utf-8?B?czRsTDJjbVpoek9QQSt2MWhHYVFCNUd6S3dxNnQ5WXUrdnUySzl1RTRNR2cr?=
 =?utf-8?B?QUpBRGhrSzROdGZMTmhQOVJCc3FSeWwzYjJsMlZxeEs3cjFRNzRZSHlxT1lq?=
 =?utf-8?B?dmFxUzlkbUJkbnVDWkJiZFJOWmZLZVJ6bnI3Rk1RdlFBWTZMQXI4QmhKSThW?=
 =?utf-8?B?Z3ZNa28wYnVzZUVUZWI4eGw1QmpmcWVpZ0FHbWpjUXVjcUliMEwxRGVKaTVE?=
 =?utf-8?B?Zkt1MWc4U2s5WkhYdEFvTVlpT2lnY0YvUmp1Vkk4b3c5WVRVeTgzL0Z4Q0Vp?=
 =?utf-8?B?Q2FaNU5iSHpRVzVNQ0ZNeEpFNUdKdm9SWU45YkRjZU96am0zZnFnSjMrS1N0?=
 =?utf-8?B?RHJ6dXNESWhuMGhLWDZuZnZSYW5UYTkrM1huV3ZCOEdQeHRmVUs0MDROUFY3?=
 =?utf-8?B?elRLWUllZHlmam05ZGpzb1o1bDIrZkZ0Rkd4eHQwOWFoTm95YW0wTkZwS2Js?=
 =?utf-8?B?Y2FFQWFBanR3K0Q2WHVESFpTdTFRN2E3WVdXQWl1T2dIR2tkc1NidFRsUWkx?=
 =?utf-8?B?djV4N0RHb200VWpBTzBGbG8rYVRMOUVqRFR2NFVVTjFnLzRHTjIxd0JuMTA1?=
 =?utf-8?B?NGxHWkpKUmlIdjExWlY3MUNRZTFadHhQVk4wT1NvL1BFSkU5SERNVUVkV2JX?=
 =?utf-8?B?RGordVI5eiswT3YwZG5wZTk3cTdPeUNrMWZZSHA1NkV1TkJ1dFZpZTJITjRE?=
 =?utf-8?B?U0VxOXhWN2RzNVkrSDM2cEFkbjRyWStJZTRXaEdENDBSMXZmbFE1cERQelk3?=
 =?utf-8?B?L1I3MXhaR2x1Rm5zSm1kVFJtU1U3SHlWV0Zub29zNlJNSWFJK0Q3SUhjTDJY?=
 =?utf-8?B?QjEwYk1aVWpqejYySnlua0VoQkQxVnc0N0kzWTVOYVJTYVNHSm9CRVN2R3lY?=
 =?utf-8?B?MnVLMnJjcFU1bHk3ZnBEWldmcHVZL09tbXQzL01Jb2hlN3JrWWVKeWgyRXZr?=
 =?utf-8?B?emlUM3JtZndnYkRzZkV0engyWnJETnZjSWx1eGJ1RDBJbG9saXhMSVNjbnFW?=
 =?utf-8?B?YklUdW1aaGlJMTBXTCttSU9YQlRBSmhNNEFNcy9LRlpncm1wOTM1djlRRk81?=
 =?utf-8?B?MjVUb1lLN2drVVRxbEw4MlZDVXFzTmd6OVJtRkRvSVZoZWZybTNjWGIyZ0ZQ?=
 =?utf-8?Q?iVtW0sZvmw8JEIlw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E103C2578808954B8A534491B223F4F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rngWPpZyjd8tzzf/M2q4pa5Hb+ucWAjSPzjTiLhUUDxdEJ01vCUnCvltB3ZVKPaQrge8gl2IshZN/t0Rq+edd9hPLmzsCJI7VaEl+J9CknxsF1TfnKSrJMWAFuDNLo6NN2A5PLNfMoUTdNZ+Uer5LY8wFco0v04sOiPP9lzoKM4I/o5zFUvYzhfp0Av80gNYNF/ZR87WyISLEkpklEDX+/5VaOKc9iSODSAR5HwoZng1Czv5EfnrgfAGdF5wzcUDnGCfSzcPy76W5hbLn49HNQ/7WpzAdzd9zHsYL8DLElhRCqY0MGWFGCuECZBzuzlx8NC9TwuzsHEBY/GjQp93ig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62920da1-449e-44ee-6f56-08deffe0783d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 00:01:08.7595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWHIoWjeJIiqXbnBsyrd0uDlFfEbLWQhU6DOAqVYsWCj4jEODG4cOmF6dl9YTHHhDOBEvPi36UiBvv0zye7E1oFVYT78RVFfq8+NL7NxuAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTIxIGF0IDExOjI5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gUnVu
dGltZSBURFggbW9kdWxlIHVwZGF0ZSBpbnRyb2R1Y2VzIGEgbWVjaGFuaXNtIHRvIHVwZGF0ZSB0
aGUgbW9kdWxlDQo+IGZpcm13YXJlIHdoaWxlIHByZXNlcnZpbmcgYW5kIHJlc3RvcmluZyBURFgg
b3BlcmF0aW9ucy4gQXMgcGFydCBvZiB0aGUNCj4gcmVzdG9yYXRpb24gcHJvY2VzcywgdGhlIGhv
c3QgbXVzdCByZS1pbml0aWFsaXplIHRoZSBleHRlbnNpb25zIHRvDQo+IHJlc3RvcmUgdGhlaXIg
ZnVuY3Rpb25hbGl0eS4NCj4gDQo+IExpbnV4IHJ1bnMgdGhlIHVwZGF0ZXMgaW4gc3RvcF9tYWNo
aW5lKCkgY29udGV4dCwgd2hpY2ggcHJldmVudHMgbWVtb3J5DQo+IGFsbG9jYXRpb24uIFRoaXMg
aW50cm9kdWNlcyBhIGhhcmQgcmVzdHJpY3Rpb24gdGhhdCB0aGUgdXBkYXRlZCBURFgNCj4gZW52
aXJvbm1lbnQgbXVzdCBub3QgY29uc3VtZSBtb3JlIG1lbW9yeSBmb3IgdGhlIGV4dGVuc2lvbnMu
DQo+IA0KPiBUaGUgaW1wYWN0IG9mIHRoZSBtZW1vcnkgYWxsb2NhdGlvbiByZXN0cmljdGlvbiBj
YW4gYmUgbWl0aWdhdGVkIGJ5DQo+IGFub3RoZXIgcmVxdWlyZW1lbnQuIFJ1bnRpbWUgdXBkYXRl
cyBzaG91bGQga2VlcCB0aGUgYWRkLW9uIGZlYXR1cmVzDQo+IHVuY2hhbmdlZCBhY3Jvc3MgdXBk
YXRlcywgc28gdGhhdCBleGlzdGluZyBURFggdXNlcnMgY2FuIGNvbnRpbnVlIHRvDQo+IG9wZXJh
dGUgd2l0aG91dCBkaXNydXB0aW9uLiBUaGlzIHJlcXVpcmVtZW50IG1pbmltaXplcyB0aGUgY2hh
bmNlIG9mDQo+IGluY3JlYXNlZCBtZW1vcnkgZGVtYW5kLg0KPiANCg0KQWJvdmUgaXQgc2F5cyBp
dCdzIGEgImhhcmQgcmVzdHJpY3Rpb24gdGhhdCB0aGUgdXBkYXRlZCBURFggZW52aXJvbm1lbnQg
bXVzdCBub3QNCmNvbnN1bWUgbW9yZSBtZW1vcnkiLCBidXQgaGVyZSBpdCBzYXlzIGlmIGV2ZXJ5
dGhpbmcgaXMgbGVmdCB0aGUgc2FtZSwgaXQgb25seQ0KbWluaW1pemVzIHRoZSBjaGFuY2VzLiBD
YW4gaXQgYmUgY29uc2lzdGVudD8NCg0KPiAgQXMgYSByZXN1bHQsIHRoZSByZXN0cmljdGlvbiBv
bmx5IGFmZmVjdHMgdGhlDQo+IGNvbXBhdGliaWxpdHkgcnVsZSBmb3IgY2hvb3NpbmcgdGhlIHVw
ZGF0ZSBpbWFnZS4NCj4gDQo+IFRvIGFkaGVyZSB0byB0aGVzZSByZXF1aXJlbWVudHMsIHRoZSBw
b3N0LXVwZGF0ZSBpbml0aWFsaXphdGlvbiBmb3IgdGhlDQo+IGV4dGVuc2lvbnMgY2FuIGJlIHNp
bXBsaWZpZWQgYXM6DQo+IA0KPiAgIC0gQ2hlY2sgaWYgdGhlIGV4dGVuc2lvbnMgd2VyZSBvcmln
aW5hbGx5IGluaXRpYWxpemVkIGR1cmluZyBib290IHVwLg0KPiAgICAgSWYgbm90LCBza2lwIHRo
ZSByZS1pbml0aWFsaXphdGlvbi4NCj4gICAtIEFzc3VtZSBubyBtb3JlIG1lbW9yeSBuZWVkZWQs
IHNraXAgdGhlIG1lbW9yeSBhZGRpbmcgc3RlcC4NCj4gICAtIFJlLWluaXRpYWxpemUgdGhlIGV4
dGVuc2lvbnMgdmlhIFRESC5FWFQuSU5JVC4gVGhlIFNFQU1DQUxMIGxlYWYNCj4gICAgIHdpbGwg
ZmFpbCBpZiB0aGUgdXBkYXRlZCBtb2R1bGUgcmVxdWlyZXMgbW9yZSBtZW1vcnksIG9yIGlmIGl0
IGRyb3BzDQo+ICAgICB0aGUgZXh0ZW5zaW9ucyBpbml0aWFsaXphdGlvbiBlbnRpcmVseSwgd2hp
Y2ggaW5kaWNhdGVzIHRoZSB1cGRhdGUNCj4gICAgIGltYWdlIGlzIG5vdCBjb21wYXRpYmxlLg0K
DQpXaHkgZG8gd2UgbmVlZCB0byByZWluaXRpYWxpemUgdGhlIGV4dGVuc2lvbnMgaWYgd2UgZG9u
J3QgY2hhbmdlIGFueXRoaW5nPyBJJ20NCm5vdCBleGFjdGx5IHN1cmUgd2hhdCBUREguRVhULklO
SVQgaXMgZG9pbmcsIGJ1dCBpZiB3ZSBkb24ndCBjaGFuZ2UgYW55IGFkZC1vbg0KZmVhdHVyZXMs
IGFyZSB3ZSBzdXJlIGFueSB3b3JrIG5lZWRzIHRvIGJlIGRvbmU/IEp1c3Qgd29uZGVyaW5nIGlm
IG1heWJlIHNvbWUNCmRvY3MgdGFsa2VkIGFib3V0IGRvaW5nIHRoaXMgYmVjYXVzZSBvdGhlciBW
TU1zIG1pZ2h0IGhhdmUgYmVlbiB3YW50aW5nIHRvIHR1cm4NCm9uIG5ldyBleHRlbnNpb25zIG9y
IHNvbWV0aGluZyBsaWtlIHRoYXQuIFdoaWNoIHdvdWxkIG5lZWQgaW5pdGlhbCBzZXR1cC4gQnV0
DQpub3QgTGludXguIFNvIHdoYXQgZXhhY3RseSBpcyBuZWVkZWQgdGhhdCBkb2Vzbid0IGhhcHBl
biBpbiBUREguU1lTLlVQREFURT8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlp
bHVuLnh1QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+IHYxOg0KPiAgLSBEb24ndCB1cGRhdGUg
dGhlIGV4dGVuc2lvbnMgbWV0YWRhdGEgYW55IG1vcmUsIG9ubHkgY2hlY2sgdGhlDQo+ICAgIG1l
dGFkYXRhIG9yaWdpbmF0ZWQgYXQgYm9vdCB0aW1lLg0KPiAgLSBSZW1vdmUgbWVtb3J5X3Bvb2xf
cmVxdWlyZWRfcGFnZXMgY2hlY2ssIGxldCBUREguRVhULklOSVQgZmFpbCBpZg0KPiAgICBtb3Jl
IG1lbW9yeSByZXF1aXJlZC4NCj4gIC0gQ2hhbmdlbG9nICYgY29kZSBjb21tZW50cw0KPiAtLS0N
Cj4gIGFyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyB8IDE5ICsrKysrKysrKysrKysrKysrKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIGIvYXJjaC94ODYvdmly
dC92bXgvdGR4L3RkeC5jDQo+IGluZGV4IDg3M2I4MzkzZjMyZi4uMWNhMzk5NmYzMmRjIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gKysrIGIvYXJjaC94ODYv
dmlydC92bXgvdGR4L3RkeC5jDQo+IEBAIC0xMjg5LDcgKzEyODksNyBAQCBzdGF0aWMgX19pbml0
IGludCB0ZHhfZXh0X21lbV9zZXR1cCh2b2lkKQ0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICAN
Cj4gLXN0YXRpYyBfX2luaXQgaW50IHRkeF9leHRfaW5pdCh2b2lkKQ0KPiArc3RhdGljIGludCB0
ZHhfZXh0X2luaXQodm9pZCkNCj4gIHsNCj4gIAlzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzIGFyZ3Mg
PSB7fTsNCj4gIAl1NjQgcmV0Ow0KPiBAQCAtMTMzMiw2ICsxMzMyLDE5IEBAIHN0YXRpYyBfX2lu
aXQgaW50IGluaXRfdGR4X21vZHVsZV9leHRlbnNpb25zKHZvaWQpDQo+ICAJcmV0dXJuIHRkeF9l
eHRfaW5pdCgpOw0KPiAgfQ0KPiAgDQo+ICsvKg0KPiArICogRG9uJ3QgdXBkYXRlIHRoZSBleHRl
bnNpb25zIG1ldGFkYXRhLCBqdXN0IGZvbGxvdyB0aGUgcmVxdWlyZW1lbnQgb3JpZ2luYXRlZA0K
PiArICogZHVyaW5nIFREWCBtb2R1bGUgaW5pdGlhbGl6YXRpb24uIExldCB0aGUgZXh0ZW5zaW9u
cyByZS1pbml0aWFsaXphdGlvbiBmYWlsDQo+ICsgKiBpZiBtb3JlIG1lbW9yeSBpcyBuZWVkZWQs
IG9yIGlmIGV4dF9yZXF1aXJlZCBpcyBkcm9wcGVkIGFmdGVyIHVwZGF0ZXMuDQo+ICsgKi8NCj4g
K3N0YXRpYyBpbnQgdXBkYXRlX3RkeF9tb2R1bGVfZXh0ZW5zaW9ucyh2b2lkKQ0KPiArew0KPiAr
CWlmICghdGR4X3N5c2luZm8uZXh0LmV4dF9yZXF1aXJlZCkNCj4gKwkJcmV0dXJuIDA7DQo+ICsN
Cj4gKwlyZXR1cm4gdGR4X2V4dF9pbml0KCk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBfX2luaXQg
aW50IGluaXRfdGR4X21vZHVsZSh2b2lkKQ0KPiAgew0KPiAgCWludCByZXQ7DQo+IEBAIC0xNTMy
LDYgKzE1NDUsMTAgQEAgaW50IHRkeF9tb2R1bGVfcnVuX3VwZGF0ZSh2b2lkKQ0KPiAgCSAqLw0K
PiAgCVdBUk5fT05fT05DRShyZXQpOw0KPiAgDQo+ICsJcmV0ID0gdXBkYXRlX3RkeF9tb2R1bGVf
ZXh0ZW5zaW9ucygpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCg0KQWJv
dmUgaXQgaGFzOg0KCS8qDQoJICogT25seSBmYWlscyBpZiB0aGVyZSBpcyBzb21ldGhpbmcgdW5l
eHBlY3RlZA0KCSAqIGFuZCBzZXZlcmVseSB3cm9uZyB3aXRoIHRoZSBtb2R1bGUuDQoJICovDQoJ
V0FSTl9PTl9PTkNFKHJldCk7DQoNCklzIHRoZSB0ZHhfZXh0X2luaXQoKSBwb3NzaWJsZSB0byBm
YWlsIGhlcmU/IE90aGVyd2lzZSBpdCBzZWVtcyB1bmNsZWFyIHdoeSB0bw0Kb25seSBub3QgaGFu
ZGxlIGdldF90ZHhfc3lzX2luZm9fdmVyc2lvbigpIGZhaWx1cmUuIE1heWJlIGF0IGxlYXN0IGdy
b3VwIGl0IHdpdGgNCnRoZSBvdGhlciBvbmVzIHRoYXQgYXJlIGFsbG93ZWQgdG8gZmFpbC4NCg0K
PiAgCXRkeF9tb2R1bGVfc3RhdGUuaW5pdGlhbGl6ZWQgPSB0cnVlOw0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KDQo=
