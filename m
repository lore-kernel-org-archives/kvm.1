Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF964534AC;
	Tue, 31 Mar 2026 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992969; cv=fail; b=QPFgSeGh1zg3qkPNaattBy2yfBHfkmFr3zdSUoznhwlwCHg2oepCSQzVVjga96igIy1hhQ0qKxvvLNpclkGz3Cfp8w3TU/l+tee3OnFdhIDAHOjjniNXb5xJDmBdE2IH5lhvadEJ3hiZSukWPjumiGRRaCMHen5L1W8P7pKPj3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992969; c=relaxed/simple;
	bh=UyTbLaKljb7OE26TJNBPK+0idcZ8ctgvE+oVj/GUZ1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vx4T/AzQU+pV+hNoFCzXaZhI3+3oD+yo9KXwCpgb8BE+OaH9Gz7v5UW4As+VxqHrXrM/KgH5nsTZ2svics4qRCRfjIc4RDOojPSbVEMdmb/V+oLaR+GJa0Mz6ilU+D1k0pVm4c79OxMb+rkkX9NJ7KDhDuMHnr3bP0+GiPulXdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+IZGxfQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+IZGxfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774992968; x=1806528968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UyTbLaKljb7OE26TJNBPK+0idcZ8ctgvE+oVj/GUZ1c=;
  b=G+IZGxfQKD2J/OYgwUlA5r8cmsGb5Lf1HZ81NqopHlUwDHpMhhWh50RC
   u7/WVEJ9JMHFuUIwgjOG4MbJQ+26B1eB9aFfDjh9Qt9e7c75oEHre4WDI
   j6k1s0aLoEqOr4/YhXE9UyfuY6ahO9U7+XPBCfcfzxf4kE1Z0zWd+8Si1
   8+c2GXsU9jgiEZK5XovEcrZByMWtSf0P1CoEz9feZnVSM8nM969oCVn7t
   JRN7kkBtrVgRO/34ZE2Aib3COeG088TGpOQ4nKpkf+YIEqdqaW79KOD9D
   64dLVISS0gV7Aue/+xdx51itDnJeaL40lMe2Zi+mjPQlme65C6bO3I2lp
   A==;
X-CSE-ConnectionGUID: uTIazhvRQASCpIK10I4sLQ==
X-CSE-MsgGUID: herV/AWxRgGbQubDw/64Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76138180"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76138180"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:36:07 -0700
X-CSE-ConnectionGUID: 8jI3+5VpRH2jZ0VE4rCIPg==
X-CSE-MsgGUID: 9jLRlNX1RmOPO7mLdhwj3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="225663501"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:36:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 14:36:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 14:36:06 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 14:36:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZ+r312SV7Ij4Oshtjdn3AefJHIsJURmsNNJklCU/X2qZeS6d1C4KeiGyU9/rPGxamX+J+NYGrLtqjJgKdeFi+a8ur8F8CSl7sC7zpT4epksqibFxccRv8hCZ6tsDSTZ1D1SvXBiEkopFnjAQ4QW7qBskAwqPS/NyaiTwleZq3nzxaTbFdGnmqZ8YkByYXVZMqUFUPtE8bo5+8DdK5qkJxFdOmB74zMliSu7ry6fBJ90hqX60kr9LQn0newv3WLeLhPDyIwgGj/ijUAb0/axyF9/aAcFBOidK9+4pJ0lRkzxl9tY/2pAM09FK7ogfgE8h8S7a/fpu6sDK2k41AJCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyTbLaKljb7OE26TJNBPK+0idcZ8ctgvE+oVj/GUZ1c=;
 b=j+dhGYgHvr2KznaGx3iHEdZnEnQ4GT7dpEcZPGv6N55l25uPwzi5qo4ydMAZkgQE51kVU9easmLjL3EslcjfAmu0Pyfs9LbfyWdiD0XYK2Sqbr0ByF2x0gbOPMOO0AVge/3mUO9oxwmc3yMn02RtCwBWaXfX/PHN44OvOufR1c50lbqdOuJWx36FN1gROiWI5zf3o0ttcoHWNN0bw6gFnNLYEcbRXDqFztJ9oWSw6efyoZPZWrlytXTN5OdjPBbJj8J9OUUCufaaFXMYAHeHy4tFG7X9LQ+dKieYSYjQKs3jxq4ZbNDFTVLjmcYEL6FhU2scm9JhFvNIuuJZye50GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by MW4PR11MB7032.namprd11.prod.outlook.com (2603:10b6:303:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 21:36:03 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::893d:78de:7a85:7c8c]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::893d:78de:7a85:7c8c%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 21:36:03 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "kas@kernel.org"
	<kas@kernel.org>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Topic: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Index: AQHcuwf0xG4i7UD/nE2Ttuc0mPAERbXHAxsAgAB9PQCAARqMgIAAZZYAgAA2NAA=
Date: Tue, 31 Mar 2026 21:36:03 +0000
Message-ID: <944b3fe5fa8955319030a7dfc0ea164bb0266e68.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
	 <acpiGUKS-WRmLoxp@thinkstation>
	 <def1f4395865ad0d22be245647fbb75ab8698ab8.camel@intel.com>
	 <acu4raBTjdFcfVlS@thinkstation>
	 <b9aa84d76c131132b5268712a44200e804c31aeb.camel@intel.com>
In-Reply-To: <b9aa84d76c131132b5268712a44200e804c31aeb.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|MW4PR11MB7032:EE_
x-ms-office365-filtering-correlation-id: 37f6a9ac-5a97-481a-b7de-08de8f6d826f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: iNu3QakjsQpinWtixSl7gIFQ24hDy5flf3Z6LDUCLPzEAfLR29aq/GP2TfbKtiJ+2AB/FJV/RVqnHAgncbncMPqRnYl+g2jsRulgo3EIzby0PlZWOGfUE+v0g9qbWqc72e+rirRoHcbqoXYNqrrPaICJOWZqywRInUguTBHSEOjfT+xG0BUJsX7E2ukcGdDQ8cyPZtQYNBwLIDaRRReyHbo6BNvPU/ZFWw5YmjNUw970/PU2VO5wiaaLZeON8eU03ZqF+BodbgokD03AYZWfuMjxW+L+9TurrPFdyBzlPRpfPNw0BKPzQJTfBcrLqkSXGix92PBBj0FDsW8IvtXB81VWzIpsDBeuiCMg2lF5PF7d9vrHfiMahIMqsjp0CbkNkoR+LXX4WlO3kR1wzW6+aC4lXaMmp9UrMdkBj2SeNd54pXcGe4OwbBjMRGsXsi6BQn+53lH7in6YYv3IWX5UjVpKp/bJFohnxZPHqfOLvimxTx3jTrsRLmLD0Z6m2EUVU8P91lWwN4MuJ3akmilfevDjXZQx3YoDZ0R6mwWLIZ3lUnNhkEIzxedyaPgZRo0z5nNhbL7QX/SP7YcNM8bUTSoaC2jZ800ccxA+wiKFeoYj9hB2JXvpQ7/OVrzKz4eR7PQsUzxLqJR2sORXaB7qzYTPBPkQZGgmrzpU8Jov1r0HqiGRMr3Hp59qltPfUS1PtKiNLC+Ttdg8xH5G4mRCGD/hhD5ub9gtZMGLrPJo4yT9GlWLXF5KYgZi4h6JKrLbfyH/G1qdY9tnGqRrOPwHsXV0zGgS89YdeiIGZm6JWlM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlJQZFA2MEIwbzZPM0tHYXp4Z0F2T1l5UVRidWlPWnFOQ3VlOG1Za1dZa25F?=
 =?utf-8?B?QkxTeFdkbXdyUzZwU3NCWnJnaGtvaEVMZlVKMEMzZFFCdVo5SExEV056TjBy?=
 =?utf-8?B?QU1vZFAxdUtORlNZbm4vZzdwQVhsYUJSRkZtcHhPTEJnaWNES0JtN25iYngy?=
 =?utf-8?B?NUE3MFFVbEVGaE9odFMzeFptUmE1VWtBTlQ0VEtKZXNyVjMvUW9sUm9vQnJU?=
 =?utf-8?B?WkZJekFVTC96QVM3QitLR212OFdvWmdia3dwTUF6akJabG91NVAxVzhBSG5O?=
 =?utf-8?B?Q091RWN5RU10L25kbEIxZzBBdmxWWU9ZeFVWKzZyWFJ5MDc3UnYrdTVYNTdJ?=
 =?utf-8?B?Y081akozTjdxdU9CYlhDTlpZeGVvS0RZb0xGNUJnVDF6L3dJS2lHUGNqaUk3?=
 =?utf-8?B?emlBbnExWkN3aFJKd3NkRDRVSWpQeXZqbzhFNk13bVJ6SDhyeVdtcXZ4bHg2?=
 =?utf-8?B?dTF6bG84Sk5DZjFmME9VbkM5dFFick0zSVlxS2tZZWlERXgvdC9DVmJXWUwv?=
 =?utf-8?B?ZVo1MzVZOUZ1YnFGNXNuVmp3NngvcDNtb1hoQzMxV0wrbkhoRTRVNGRpODJu?=
 =?utf-8?B?MEZPcVRsOTdUejhzd1c4cHlUTzJ0SkRrc1N2anorUTFKN0tvQTcxS1ZtcmZv?=
 =?utf-8?B?dzV6ZnRqdTlldFNWWkU0ZWpjcXNFcklZdTViUHNsZ05zZGVyQlFLSHg5RFdU?=
 =?utf-8?B?SkRRSUFnUEwxZW13S05xQ0RQUEdHVFJyR203QTVDNDN6R1ZDWXRjWHZuWFdo?=
 =?utf-8?B?SkVVY3p3NkpJaDhuV3lHelZrUW5iTisvbXlmOEUrZ0ZCMVdtZW9EUkJlamFX?=
 =?utf-8?B?cGpMdnpEMlpRMCttUURuZ3laLytkaEJIVDFid1c5SkhHSGJ6QUFpRHdKTm1Y?=
 =?utf-8?B?TTQ3aFJ5YmpPWEVZdi9SaVFTbGdSaURZcjZ2WkowbmFPSEdZcmc1M1RqRE9Q?=
 =?utf-8?B?dWdRNHV4RlYzMG9na3p3SDFjVURleGJZRGRHTnJwdnJJdUFkNCtiU2Y0MVdC?=
 =?utf-8?B?TVEwVFJlenlRWTZTdnQ5QVVkd1l4enUzbmlVM1NIQVROdTF2RTVKQmwyQUNC?=
 =?utf-8?B?UytIOERqdVVFOVF2eGxWOGN2YzloazF1dXJPR0poZmp0RXpvemp0Qlp2NDI4?=
 =?utf-8?B?Wk53c1FSUUM2TFVWb1VRdEZCdHBHTm84RXRyME1zUVhENk1zWi95OTh5Wk1x?=
 =?utf-8?B?WWU1MzJZb1FFRi9IOU83RUxCcUR0U0p4bkVGTWd4dkM0V1ZjVmhGenNwSS80?=
 =?utf-8?B?d3ZSc25ldHluNDh4L0xpZXFmUFFMN012TDVOOGh1dWJXNFM0NkV0aGhVV3dW?=
 =?utf-8?B?NWZ5UGVtUFpXaXc4UjE3SGJHYmZsN2JMZHpKMzgzOEdwMjJwMjd5dzRZSkNx?=
 =?utf-8?B?aVZaTmJFeXhPZGFaY0UvbE94ZlZrbVhEUlM5SHdMMVg1WTB4QVU5ZUhSRWZ1?=
 =?utf-8?B?VXBJcGhURCtySDdmRWgvT01EczJrNW4wUlJIYzN6ZjNFcHVsL25kbWp5WGkv?=
 =?utf-8?B?cUlPYTBMbTQ5Q281VzBRNEVmKy91cDlzR2VnK0pTa0hBdi9mdzhhdDFGeTZQ?=
 =?utf-8?B?NUVDdGV4dzE5aldmVS9sTXNGaktiM2lzT3JheUtPdlFvbUdhMjhVMUhqY29X?=
 =?utf-8?B?UmxWYTVNREZoblNGSVp4aUJ2ZGZ0b0NZWVZaR2VXcWFlc2IxcDlXcnNoNjVB?=
 =?utf-8?B?cmRZRXZZdFpOREdaNU5QWEtuT1cyQW1yaGZEbFJtSmQxdHlFNXkzZzBxc2E3?=
 =?utf-8?B?VE01c2Iwb0VOQ1dmSHpkVE5QV1QxZW1sa0RPaVlDTHllNEVxWHJhV1Q4SHNk?=
 =?utf-8?B?dUtYQ2RaeStHaWQ5SjZkSnJvNFJqb0tleU9GSEZLRzhEdGZrRVdtWTIxZk5k?=
 =?utf-8?B?amdTQkErV2E0cEd1TUFWOUVjWGVueUlYQ3FrbjB5d01hUVU5Z3FpaWp4T3lE?=
 =?utf-8?B?NlBFWDJFQzAzZFlpNUV5azQybVhFNlpLYmNDR2pZaytaNHhQRGdORjNSVlU0?=
 =?utf-8?B?R0lQUFJQSVB3cGdHbzZiamNaQWo2K3lkSzRvaDV3Rkh2aEJrTkRyMWpjc2NH?=
 =?utf-8?B?T1NhSlNUcWgvK2tvQjd6bjVFQTBrWHdCdk9saUZCTG5LL1pNL1dkNUppM3hN?=
 =?utf-8?B?YW5jREpqUVhMMkY3R0lmNTZpNExyRm8wd1E1M0NDNUxqM0JJY2Y2VFBTY1Na?=
 =?utf-8?B?SU9BZWJSMTRHa0ZOOUNpbjJMbGEzcWlZd0I2TVdUMFh3NFpGYU90VWRrb3Rj?=
 =?utf-8?B?Z3FUUGpCZjBwUllaTllhYkoyRExtVS9KTHdjRVppM2hZSFlseFlxZE0vZFJj?=
 =?utf-8?B?Sk9janlRSjJOekszcDdFNlVLY2EycTdxTzEzRDhPRHhRRFlxOHBCVndXbTcw?=
 =?utf-8?Q?jSmepABRwbtsDflk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F089A11661B82945AE5801A0BC1EFD59@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uzm/+NH5Bi+lJSkz8arTqgzPgbESq5UTN9hZgbmYgKUHVsqdDVk/ad5gVpI592DyR/i/zWIrtct5PK4uwONOA6dId1tyKztDMHWsuI28vaxd76ysavluB/m27xIW8L/CPKzckq0auxVKG8e9JlDoZhBUWodGwRHQNbHiXkbuGRd6hL3L8qVEhY94pY+IpNAfjO0eqhuJVnCloMfmtHJVy4F8/ARThYgrlEfzxB2U8EaBRVsZxjQPMzE741bntVOvQC2AWplRpxd8URRLkhqMlwzVXDrQ4L/oWY0ilQFFsdM3oqE0cZRhbHE+W+AupBDntjmTdWGrkyTRUpZsHHyHUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f6a9ac-5a97-481a-b7de-08de8f6d826f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 21:36:03.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YylINSlr2lAl+3tfKRYUP9/WsUJ1c8KRyd/lbaWDnVAG+/yKSdWK/3xbMGXdwaVlH96cz1T71ntBuFTICiyoInTwlf37zKzWhMDRYiPz8TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDE4OjIyICswMDAwLCBWZXJtYSwgVmlzaGFsIEwgd3JvdGU6
DQo+ID4gDQo+ID4gSSBndWVzcyB0aGUgYWN0dWFsIGJlaGF2aW91ciBpcyBkZXBlbmRhbnQgb24g
dGhlIHJldHVybiBjb2RlLiBJdCBpcw0KPiA+IG9idmlvdXNseSBnb2luZyB0byBiZSB0aGUgY2Fz
ZSBmb3IgVERYX1NVQ0NFU1MuIEFuZCBmcm9tIHRoZSBkaXNjdXNzaW9uLA0KPiA+IEkgZ3Vlc3Mg
dGhhdCdzIHRydWUgZm9yIFREWF9TWVNfQlVTWSBhbmQgVERYX0lOVEVSUlVQVEVEX1JFU1VNQUJM
RS4NCj4gPiANCj4gPiBXaGF0IGFib3V0IG90aGVyIGNhc2VzPyBUaGUgc3BlYyBkcmFmdCBhbHNv
IGxpc3RzIFREWF9TWVNfTk9UX1JFQURZIGFuZA0KPiA+IFREWF9TWVNfU0hVVERPV04uDQo+IA0K
PiBJIHRoaW5rIHRoZXNlIGFyZSBzYWZlIHRvbyAtIFREWF9TWVNfU0hVVERPV04gbWVhbnMgdGhl
IG1vZHVsZSBoYXMNCj4gYWxyZWFkeSBiZWVuIHNodXRkb3duLCB3aGljaCB0aGlzIHNlYW1jYWxs
IHdvdWxkJ3ZlIGRvbmUsIHNvIHRoaW5ncw0KPiBzaG91bGQgYmUgaW4gdGhlIHNhbWUgc3RhdGUg
ZWl0aGVyIHdheS4NCj4gDQo+IFREWF9TWVNfTk9UX1JFQURZIG1lYW5zIHRoZSBtb2R1bGUgaGFz
bid0IGJlZW4gaW5pdGlhbGl6ZWQgeWV0LiBUaGlzDQo+IHNlYW1jYWxsIHNob3VsZCBqdXN0IGV4
aXQsIGFuZCB0aGUgbW9kdWxlIGlzIGFscmVhZHkgYmxvY2tpbmcgYW55DQo+IHNlYW1jYWxsIHRo
YXQgbmVlZCB0aGUgbW9kdWxlIHRvIGJlIGluaXRpYWxpemVkLiBUaGUgc2VhbWNhbGxzIHRvDQo+
IGluaXRpYWxpemUgdGhlIG1vZHVsZSB3aWxsIGJlIGFsbG93ZWQsIGFzIHRoZXkgYXJlIGFmdGVy
IGEgc3lzX2Rpc2FibGUNCj4gY2FsbCBhbnl3YXkuDQoNClNob3VsZCB0aGUgc2VhbWNhbGwgcmV0
dXJuIHN1Y2Nlc3MgaW4gdGhlIGNhc2Ugd2hlcmUgaXQgd291bGQgcmV0dXJuDQpURFhfU1lTX05P
VF9SRUFEWT8gSXQgaXMgaW4gYmFzaWNhbGx5IGEgcmVzZXQgc3RhdGUgcmlnaHQ/IFRoZSBlcnJv
cnMgd2UgY2FyZQ0KYWJvdXQgYXJlIGFjdHVhbCBlcnJvcnMgKFREWF9TV19FUlJPUiksIHNvIGl0
IG1ha2VzIG5vIGRpZmZlcmVuY2UgdG8gdGhlIGNvZGUgaW4NCnRoZSBwYXRjaC4gQnV0IGl0IG1p
Z2h0IGJlIGEgbmljZXIgQVBJIGZvciB0aGUgc2VhbWNhbGw/DQoNCj4gDQo+ID4gDQo+ID4gSSB3
b3VuZGVyIGlmIGl0IGNhbiBhZmZlY3QgdGhlIGtlcm5lbC4gQ29uc2lkZXIgdGhlIGNhc2Ugd2hl
biBrZXhlYw0KPiA+IChjcmFzaCBrZXJuZWwgc3RhcnQpIGhhcHBlbnMgZHVlIHRvIGNyYXNoIG9u
IFREWCBtb2R1bGUuDQo+ID4gDQo+ID4gV2lsbCB3ZSBiZSBhYmxlIHRvIHNodXRkb3duIFREWCBt
b2R1bGUgY2xlYW5seSBhbmQgbWFrZSBrZXhlYyBzYWZlPw0KPiANCj4gSG3CoCAtYXJlIHRoZSBz
ZW1hbnRpY3MgZm9yIHdoYXQgaGFwcGVucyBpZiB0aGVyZSBpcyBhIGNyYXNoIGluIHRoZQ0KPiBt
b2R1bGUgZGVmaW5lZD8gSSB0aGluayBMaW51eCBzaG91bGQgZXhwZWN0IHRoYXQgc3lzX2Rpc2Fi
bGUgc2hvdWxkDQo+IGVpdGhlciBzdGFydCBkb2luZyBpdHMgc2h1dGRvd24gd29yaywgb3IgZXhp
dCB3aXRoIG9uZSBvZiB0aGUgb3RoZXINCj4gZGVmaW5lZCBleGl0IHN0YXR1c2VzLiBBbnl0aGlu
ZyBlbHNlIHdvdWxkIGJlIGNvbnNpZGVyZWQgYSBtb2R1bGUgYnVnLg0KDQpXZSBvZnRlbiBoYXZl
IHRoZSBxdWVzdGlvbiBjb21lIHVwIGFib3V0IGhvdyBtdWNoIHdlIHNob3VsZCB0byBndWFyZCBh
Z2FpbnN0DQpidWdzIGluIHRoZSBURFggbW9kdWxlLiBJIHRlbmQgdG8gYWxzbyB0aGluayB3ZSBz
aG91bGQgbm90IGRvIGRlZmVuc2l2ZQ0KcHJvZ3JhbW1pbmcsIHNhbWUgYXMgd2UgZG8gZm9yIHRo
ZSBrZXJuZWwuIElmIGl0J3MgZWFzeSB0byBoYW5kbGUgc29tZXRoaW5nIG9yDQplbWl0IGEgd2Fy
bmluZyBpdCdzIG5pY2UsIGJ1dCBvdGhlcndpc2UgdGhlIHNvbHV0aW9uIGZvciBzdWNoIGNhc2Vz
IHNob3VsZCBiZSB0bw0KZml4IHRoZSBURFggbW9kdWxlIGJ1Zy4NCg0KQnV0IGZvciB0aGUga2R1
bXAgY2FzZSwgd2UgZG9uJ3QgYWN0dWFsbHkgbmVlZCBzeXMgZGlzYWJsZSB0byBzdWNjZWVkLiBU
aGUga2R1bXANCmtlcm5lbCB3aWxsIG5vdCBsb2FkIHRoZSBURFggbW9kdWxlLiBBbmQgYXMgZm9y
IHRoZSBlcnJhdGEsIHRoaXMgYWxyZWFkeSBuZWVkcyBhDQpzcGVjaWFsIHNpdHVhdGlvbiB0byBi
ZSBhIHByb2JsZW0uIEJ1dCBldmVuIGlmIGl0IGhhcHBlbnMsIEknZCB0aGluayBiZXR0ZXIgdG8N
CnRyeSB0byB0aGUga2R1bXAuIE5vdCBzdXJlIHdoYXQgdGhlIGZpeCB3b3VsZCBiZSBmb3IgdGhh
dCBzY2VuYXJpbywgZXZlbiBpZiB3ZQ0KYWxsb3dlZCBmb3IgYSBsYXJnZSBjb21wbGV4aXR5IGJ1
ZGdldC4gU28gYmVzdCBlZmZvcnQgc2VlbXMgZ29vZC4NCg0KRG9lcyBpdCBzZWVtIHJlYXNvbmFi
bGU/DQo=
