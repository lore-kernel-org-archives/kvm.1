Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF787418A48;
	Thu, 13 Aug 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786652068; cv=fail; b=ZWRd2Cw83DRmEUHZbwT28Lgv6mlmA5sJ1CaebiVcERrgxqw9bLMhutiGoPEb1gpXfyDbiN2N0JOZrwHAjoNlUHD3VIsJ22gWjg5KFLR9IyfpbSLIfGJnQUetPlUKtpe83+asGPA9sy1quJvygmKCMdUGZfJhCHuhHf3yI+DVQMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786652068; c=relaxed/simple;
	bh=PRYyter98PFWQOBKEwcEIDKUyyy+j81TXqC2uCXTRe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uCviRXXVqWWU2QaMWMFYXm2tbBzdoRWYNIXS6rtd4RchQbHjY5tZi675waBeUTtDVk/78fK4uo8RZ4P9UhIMInhM0D1AsHU023VwYkLUQ1qRHYCmNZNaV5X+1DtXMs7GMrbK2EaOiA16aHt1AI29y7bBFt2ut5sENmW4FtlTVzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ua0rbdVu; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ua0rbdVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786652067; x=1818188067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PRYyter98PFWQOBKEwcEIDKUyyy+j81TXqC2uCXTRe8=;
  b=Ua0rbdVubPs8cL3im18cYv5nDOOAXok1X241Bi3/k0wlONMW2sEnLbwd
   PesW3im2TuuIdxurmj8dsRrnh9aeie0i7bYJ1ldBMsq9jxIL1E282mPHG
   YiW6ENvUjFtxkdx2CfHJOTPkSNqBXCuHQe02X5aMFJPuyvwxUaH2rdhLY
   sdEbl4hmWtND9AIWE9fyJL16SlChFaEWN157bjV8JklTX4JmwgcOaIfvr
   r3RKIKqO/u4NzSBsbo/Xu8TkTOEgnh1Ul0uCXnVTlf6xI2t0QoYCHIl6f
   SU5ssurd1lYQHODy5jruT+Izj2NKT2936EknV4ylbeACmyVIsEoLOSU2I
   Q==;
X-CSE-ConnectionGUID: t4KNKjTjS3qDJjDaeWbNKw==
X-CSE-MsgGUID: CYwh6T81RDyBZLmbuMt2zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87364770"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87364770"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 13:14:25 -0700
X-CSE-ConnectionGUID: WB0QTT49QOuGq7/QcjOhdw==
X-CSE-MsgGUID: W3fgXyI0QJGKMvwkQ24wRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="257812929"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 13:14:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 13:14:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 13:14:23 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 13:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJbI1agKImMadSXhcVHVJCjSJJTjSan/X4WtC0n3iiKOVXiXuPnUnvUmboUq/tfwgU6Z2UxOIuMX9H/n/MkKAAt1sKc7VSAAVHiEgqw7hwPZFC322Cp/x5SXrfDDBYw+Om7wHGY79BNNEiMTylEQR55j0oyWXtdgjlieBQUNvr8pr+F/H6FJ7h5WZ7L6m1phzmSebOqZCyaUkGax0d2SWAcV+UQ6btpXeKCTIK4ZYpRtFauG7oTCF/l4h9S7VS6UmKMFJ5YARsPkOwujExBejqLct/WwZi0fy1cq8YtHXbW01nkaiFOeFoHvDzq2+HXQGnhHtr/QhsOV+W/CmOWwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRYyter98PFWQOBKEwcEIDKUyyy+j81TXqC2uCXTRe8=;
 b=fKYX0kr+pZqJvG6iQTb2naxtBiOwPgYu5fNq7wGrbFodyhOOOk0Jy0YQcCV19CliuwldzOG7X9vToua+qmsYaMtnqxuIqqNoK4qVLCxaVhwadFKNOlarrJ+nE4DHcu1lRKmvH+FfGqGjQn37S0nmbMzGLYqUoyhiQOfOZG1gQ1kXSXCmr3by6XnyQqcBIrqMzWhc1Juee5bxOdsM8h4Js0MTdCe7hDuwpx9Mwnn2AYihVkWqV6O7pGGAQaz7SulJeaGaMZi4A6DwpkTU7BR7XZ1iE5I8VCV9Oq5+RfiNhwP9NfMoO04d6WZA/QdPG1rWd7q6iiWYTmcd4Cctr3Ft2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 20:14:19 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 20:14:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dedekind1@gmail.com" <dedekind1@gmail.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Fang, Peter" <peter.fang@intel.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAAgBSEcgCAAQNDAIAAIM6AgAAKnQCAAAuxgIAAVwiAgAAC5QCAAAZ6gIAABW8AgAFP5gCAAAu6AA==
Date: Thu, 13 Aug 2026 20:14:19 +0000
Message-ID: <4ad451969522eecb445289ca74a88ee73d51336d.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
	 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
	 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
	 <anxvwV_Pz4UYaxxt@google.com>
	 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
	 <anyiwqi9i0NSv0QW@google.com>
	 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
	 <20260812223707.GD1013044@pedri>
	 <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
	 <anz9b6CDkhr5D5RG@google.com>
	 <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
	 <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
In-Reply-To: <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BL3PR11MB6411:EE_
x-ms-office365-filtering-correlation-id: 4d890c2f-5904-4417-6e11-08def9777523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|10067099003|4143699003|11063799006|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: qfa/PDAZSYOWP5A6UmREbqS815emP2gvJEk0YPa0Obp7HXJn7bH+B63W0hhzcjmA13vlkX+/khbzX4140cqYrkJUehP3g5f1XANolBJMO1mN59F2ojpCLIR7pPjJsuDTWSyxxEgqJafCStq1t3/wGREVyeLbZoZCmPRYyxRmriwFx+mw0RQ/G84V1Gtup+QUR9y9Wtfn7fDd6Er3tvOqYcim0Qm7khOJuFMGEqQJ1S7h1agT3a4DqxwLUifX95rYuBAbSTkDYin6MkRFlUDqxFsSys45++A7TBzMVgEw130V8rg4Gt2Qegvj6pEujLPRQ3TEDWqe/8v6K/Xg3OL2TXXZIKPlwa6qBcsw0Ok/aF3jKpprFJyjYozRkcUCamia64kGXC5v1x6aBBIVarYl4JOWYuPGxZiqiRND5YSaCH/kEhDbuoL5EvyTqxNft3Pt+YbIVDSGLAPnpWlVV92IWw9hQN+ewI6tNwQlzBh3rpnJg8KOYQ6JkkAcDdZOzoskLdrQiKqlXSMAoktBketw0zUB+Fr7pYkHtneKkl7MaSN7rqMdrBb21lTS6VyxttvBRJNzS++74L1OYLrgEw4sqf5FDImGqOBVr+00YApwEznFBx1RgJODLrkH52GN5ynNZ9b2vWyqeGNox15YEVCilaCLxuK2qlwatYEQ5KXYNLAaMCASv2r+b4xL9GwQTvIcEZ88GaKRSoKvkrDPQ+cB5fdWRdjkyTsllPlAHCpye9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDJlL1ZIYWRYRFJOWnJPUWJLemh4dDNDSXp5ZkJzV085aU5ic0phcXZsbUdz?=
 =?utf-8?B?azY4dWZqVU9kNkFmWURmbWZtUnNXNDljMHR6Z3FOUnhwUFpGbkZTYW9Sc0Ro?=
 =?utf-8?B?dWliSzExQytXTU9LTVJuMlJHU3l4NWE0UTUvNFJKbmFEM3c1d1NLenY5d1JX?=
 =?utf-8?B?QzBOOE0xRjZFK3RUcGVDZ1BoTy9mL0xXSkg2RmZUVVBSY1JBWFhDd0k3RFB3?=
 =?utf-8?B?bWcvUWJYeXBnT0svYmFJYVZNckRSZ3VzOEl3Vys1SUVuV0RoSEd2aUcrNXV2?=
 =?utf-8?B?amgzYTVkdFdISENiajd0ZXZmUDFSa2FDNEx2Nit2NDVUVjVWYWxMTy9pamNw?=
 =?utf-8?B?VFByUFB5Y2lCbW9qbnorbXBoRVdTT0JmelpJS05JcHU1YStleUxkbkRvd25Z?=
 =?utf-8?B?aHZUMUR3TmRFczR4Qjg0UXYzRnNFOXQraDhOWVB4UW1RUWhEVnlBM0VCSXdo?=
 =?utf-8?B?dFFTWENJZThWZzZBa1dMU0NSOGJvc3pYaGlJbThTd2ljbHQ3Y1JqUFkzVVI3?=
 =?utf-8?B?dXpYSjBDSFQ1cTErUnArVGx5QkFkM0VNNEVEK1Zqa0tJaWFidEh1WnBvZnlI?=
 =?utf-8?B?d3BWNGlnSVBBaHN5d2tGMmRQeEcvQllKQU42czh6Y3hmMjRWcENtYTgvTTda?=
 =?utf-8?B?Ykt3alZxTjFCTk41cnJ2UjY4TXIrUmpGVkszdUp6empOdUR0ckpDQnVHOC9M?=
 =?utf-8?B?b3lpTzBQdHR6RlhmRFdkWTVrcis4dWh1SWtJMHMxSk5wT0hUY2t1bGhldGkv?=
 =?utf-8?B?MGd5ZUZZWFJqMFhJdEk2MzlMWHE5UitoMmJsbENjQS9IUzVRNUZDcExxNjFF?=
 =?utf-8?B?alpsRlppeW4wRmtEQ1JHb0cxYVRaK2VEQ1htdlkrMGZDQkRXekVpWHRMMURo?=
 =?utf-8?B?T0VXbWpGZi9MRVYvY01kZEdNdnR6a2pSRmN4dFYxNXBrcTc3MVc0QXBVK2ZN?=
 =?utf-8?B?bGdabnpxVWo1MGVJRHJOUXlmcEhwTHdVSEMzOVMwZzZZbVlxaCs1VFBpKyti?=
 =?utf-8?B?N0V5M1dIWWRpaEc0eWpqSFprT2tRQzlNdHFNc3doUkRpMkg4WnZSVzNVUllS?=
 =?utf-8?B?RmN3U2U5ZEU5bmsxeXRudUt3Vit4MEhPbUhUbkVJRHNjamIwbEg3OGJGbG95?=
 =?utf-8?B?Rm5FN2VLWG90Q3hlMnhrMW9NNkYrQVhybW01cXhya3JCc2gzczE0d21ybGt0?=
 =?utf-8?B?ZEZCam5GMEFPN1llTGJjU1IyUHZNMGhqbm4zRmJqTnJOd09jY2dzWUFWVzVj?=
 =?utf-8?B?Vjh2ZUZONmlDK1FwMDduMkZZN0hmSHIvZ3ZrQStzRTlQTVI4TGJiWlFGbC85?=
 =?utf-8?B?NGFEYkRyK2Q4b1huMFE5UHBPaVlmNnJiZFRYVDN0UHB5M04wN1QvaW8yWGR4?=
 =?utf-8?B?Skk4UHJ4bnlXOVpRS2F5ZWFMNDFMQXU5Y0FHZWNyNGI1MWNYTFg5OEpoVnpJ?=
 =?utf-8?B?djNkcDZUait4enpUMFdGWi9wSzFkL0ZVc1Z3c2tlODVxTGs5dFgyTmN4RDVD?=
 =?utf-8?B?K3dSV0NDWGR3eVhqcDhUeGgrMitPTjBsVlgzeG9ubXQ3akpTNlZ3Y0NNMFkx?=
 =?utf-8?B?M3ZXRmFFazlpazdHcmNsbXRNaDVBTlhqbVd5QXdMZEppU21tMThUMlZTT2tC?=
 =?utf-8?B?VExPQjlLVDlhYjBvbE44eXNia1ZhUWIxN0JLaGxrRjN5c1dIMWNqYUNvNFNo?=
 =?utf-8?B?SkRzZzIzUkhONWFqNWJsN09vdjlPSFVLVkN6SHlCSUMzVGhpSEUya2xHQjZz?=
 =?utf-8?B?NkJzSVo1R1IwdDNQbmk5ditjZC8zQWJ0Zk9ub1JwZlhhcFQzSXVKNFBrRHNi?=
 =?utf-8?B?M3Q0am91ZDhrakhlWHhDV2VSNkZhRld6RTE0VUZpZFdkWTBhcHZQUVZBMExX?=
 =?utf-8?B?T0hEWEJaYzJ0Uk9saTlkaHR0bWlUblcvTElDV0Jyc2N4MjJkSno3MHc3WkJF?=
 =?utf-8?B?R3VSWlJtNW5MOGx2NURmVVJBTTFLbE9rKzdiQU94ejc1TmtoK1BnQnNFcGhR?=
 =?utf-8?B?YlBZNDU4RHlZMnkwY0JVTm5RZUs1Mnk0VlRIUk82bWc3NGlFSDBEV0ovemZu?=
 =?utf-8?B?RTM1bFdBZEc3dlRIM1RpaTBrdThEc0RCTEdsYmhBalNWenZ1YWVNODdkbnVM?=
 =?utf-8?B?M3JZRlBIUHZKeHdZTWowSEs5K0t4eVlKc3E4Q3lLdWRaYnJNMjFaQWFWZUFh?=
 =?utf-8?B?bkMvQ1VERVAwQ2xreTJSNEVOK2phYTh4OWd0amtOZVRra25YTlJjSEovbVl5?=
 =?utf-8?B?U1BKcHZZcHUwbUJvMlRuMTBJMnpCSEpOM3RIZFU5aGVnYmJrWmZGaUlhR3hL?=
 =?utf-8?B?dEFkenNvZm5RRUhpRXZsWXJId3p5VU5sbFBiODQxaVBOUFRPWS9wVmRtTWV0?=
 =?utf-8?Q?f1LuD/8wl9bV8zNM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <738680886AFE0148A099EE14DFD559E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dQkyjDczFtQnYCsjvtidF/Ohk9gIts+lFs6FTKr0ugpyBR27kg7EV7UckYAr6RZQzC+L8+maPKyhIoRrQUduDooTy6eJaB+tU1PbgSBzaCXjBNPcYfcgFTpIC6Uv+r6zORDBKCO6FINnSQIrOmm01tI1XKIVNvzaAgTUq4DxUrcM/FiRQ5X5q8IxZzM+HmheDmxb2X7GlEzo8EuvAJJuQ+eDiqlStwP08BJri+d+1QUdhcFWv3hK3GRwIPQTSsFFaYoaDl5Akmos88Vb8ac3NAw7IBon1R6YfOVNdLkJACNgehO7JvtW2GMKvuz8LcZYoKzv7oB7vTnBFjcEo6w4jQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d890c2f-5904-4417-6e11-08def9777523
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 20:14:19.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsjELlbLrO3DZirh5MZZB8BPHnGMbF/IGCtrCGHFlRGP22RuuqdBPCynVS2jgTktMxzBIsowjnc+7m+oeXouXgL3YNKiorlX6HhEahZ38ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTEzIGF0IDIyOjMyICswMzAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3Rl
Og0KPiBNZW50YWwgbW9kZWwNCj4gPT09PT09PT09PT09DQo+IA0KPiAxLiBTR1gtYmFzZWQgYXR0
ZXN0YXRpb24NCj4gDQo+IFRoZSBvcmlnaW5hbCBTR1gtc3R5bGUgZmxvdyBpcyB0d28gc3RlcHM6
DQo+IA0KPiAxLiBUaGUgVEQgZ2V0cyBURCByZXBvcnQuDQo+IDIuIEEgcXVvdGluZyBhZ2VudCBz
aWducyB0aGF0IHJlcG9ydCBhbmQgcHJvZHVjZXMgdGhlIHF1b3RlLg0KPiANCj4gV2hhdCBpcyBx
dW90aW5nIGFnZW50OiBhIHByb2Nlc3MgdXNpbmcgYSBzcGVjaWFsIFNHWCBlbmNsYXZlLg0KPiAN
Cj4gV2h5IDItc3RlcDogdGhlIGtleSBsaW1pdGF0aW9uIGlzIHRoYXQgdGhlIHF1b3RpbmcgYWdl
bnQgY2Fubm90IGZldGNoDQo+IFREIGV2aWRlbmNlIHN1Y2ggYXMgRlcgaGFzaCBvciBvdGhlciBw
ZXItVEQgZGF0YS4gU28gdGhlIHF1b3RlIGlzDQo+IGNvbmNlcHR1YWxseToNCj4gwqAgLSBURCBy
ZXBvcnQgYm9keQ0KPiDCoCAtIHNpZ25hdHVyZSBvdmVyIHRoZSByZXBvcnQgYm9keQ0KPiDCoCAt
IHRydXN0IG1hdGVyaWFsIHN1Y2ggYXMgdGhlIHB1YmxpYyBhdHRlc3RhdGlvbiBrZXkgYW5kIGNl
cnRpZmljYXRlDQo+IMKgwqDCoCBjaGFpbg0KPiANCj4gMi4gRElDRS1iYXNlZCBhdHRlc3RhdGlv
bg0KPiANCj4gVGhlIERJQ0UtYmFzZWQgbW9kZWwga2VlcHMgdGhlIHNhbWUgdHdvLXN0ZXAgZmxv
dyBmb3IgY29tcGF0aWJpbGl0eSwNCj4gYnV0IHRoZSBxdW90aW5nIHNlcnZpY2UgcnVucyBpbiB0
aGUgVERYIG1vZHVsZSBhbmQgY2FuIHJlYWQgVEQNCj4gZXZpZGVuY2UgZGlyZWN0bHkuIEFzIGEg
cmVzdWx0LCB0aGUgcXVvdGUgY2FuIGluY2x1ZGU6DQo+IMKgIC0gVEQgcmVwb3J0IGJvZHkNCj4g
wqAgLSBleHRyYSBwZXItVEQgZXZpZGVuY2UNCj4gwqAgLSBzaWduYXR1cmUgb3ZlciB0aGUgcmVw
b3J0IGJvZHkgYW5kIHRoZSBleHRyYSBldmlkZW5jZQ0KPiDCoCAtIHRydXN0IG1hdGVyaWFsDQo+
IA0KPiBJT1c6IGluIHRoZSBTR1gtYmFzZWQgZGVzaWduLCBpdCBpcyBpbXBvc3NpYmxlIHRvIGFk
ZCBURCBldmlkZW5jZSB0bw0KPiB0aGUgcXVvdGUuIEluIHRoZSBESUNFLWJhc2VkIGRlc2lnbiwg
aXQgaXMgcG9zc2libGUuDQo+IA0KPiBCdXQgdGhlIHF1ZXN0aW9uIGlzIC0gT0ssIGl0IGlzIHBv
c3NpYmxlLCBidXQgd2h5IHNob3VsZCBpdCBiZSBkb25lPw0KPiANCj4gMy4gV2h5IGZyZWV6aW5n
IFREIHJlcG9ydCBzaXplDQo+IA0KPiBMaW51eCBzdXBwb3J0cyAxMDI0LWJ5dGUgVEQgcmVwb3J0
cyB2aWEgdGhlIGBURFhfQ01EX0dFVF9SRVBPUlQwYA0KPiBpb2N0bC4gSXQgaXMgYWxyZWFkeSBm
dWxsLCBubyBtb3JlIFREIGV2aWRlbmNlIGZpdHMsIGFuZCBjaGFuZ2luZyBURA0KPiByZXBvcnQg
c2l6ZSB3b3VsZCByZXF1aXJlIGEgbmV3IGlvY3RsLg0KPiANCj4gQWxzbywgYXMgSSB1bmRlcnN0
YW5kIGl0LCBiYXNlZCBvbiBURFggZmVhdHVyZSByZXF1ZXN0cyBmcm9tIGN1c3RvbWVycywNCj4g
dGhlcmUgbWF5IGJlIGEgbmVlZCB0byBpbmNyZWFzZSBURCByZXBvcnQgc2l6ZSBtb3JlIG9mdGVu
IGFuZCBtb3JlDQo+IHNpZ25pZmljYW50bHkgdGhhbiBvbmUgd291bGQgZXhwZWN0Lg0KPiANCj4g
VGhlcmVmb3JlLCBmb3IgRElDRS1iYXNlZCBhdHRlc3RhdGlvbiB0aGUgVERYIG1vZHVsZSBhZGRz
IG5ldyBURA0KPiBldmlkZW5jZSBpbiB0aGUgcXVvdGUgaW5zdGVhZCBvZiBleHBhbmRpbmcgdGhl
IFREIHJlcG9ydC4NCj4gDQo+IElzIHRoaXMgdGhlIGNsZWFuZXN0IGFwcHJvYWNoPyBNYXliZSBu
b3QuwqANCj4gDQoNCkkgd2FzIHRoaW5raW5nIHRoZSBjbGVhbmVzdCwgdGltZS10cmF2ZWwgZmFj
aWxpdGF0ZWQsIGFwcHJvYWNoIHdvdWxkIGJlIHRvIGhhdmUNCnRoZSAicmVwb3J0IiByZWFsbHkg
anVzdCBiZSBhIHJlcGxheSBwcm90ZWN0aW9uIHRoaW5nIGFuZCBub3QgaW5jbHVkZSBhbnkgVEQN
CmRldGFpbHMuIFRoZW4gdGhlIHF1b3RlIGNvdWxkIGFkZCBldmVyeXRoaW5nIGl0IG5lZWRlZCBp
biB0aGUgZmluYWwgZm9ybWF0DQpsb2NhdGlvbi4gU28gbm8gcmUtdmVyaWZ5aW5nIGFuZCBzaHVm
ZmxpbmcgdGhpbmdzIGJldHdlZW4gZm9ybWF0cy4gQnV0IHNpbmNlDQp0aGF0IGRpZG4ndCB3b3Jr
IGZvciBTR1ggYmFzZWQgYXR0ZXN0YXRpb24sIHRoZSByZXBvcnQgaGFzIGV4dHJhIHN0dWZmIGR1
ZSB0bw0KbGVnYWN5LiBCdXQgZnJvbSBMaW51eCdzIFBPViwgZ29pbmcgZm9yd2FyZCB3ZSBjYW4g
Y29uc2lkZXIgdGhlIHJlcG9ydCBhcyByZWFsbHkNCmFuIG92ZXJzaXplZCByZXBsYXkgcHJvdGVj
dGlvbiBibG9iIGFuZCBmb3JnZXQgYWJvdXQgdGhlIFREIGRldGFpbHMgaW4gaXQuIElzbid0DQpp
dCBhIHByZXR0eSBjbGVhbiBzZXBhcmF0aW9uIG9mIGNvbmNlcm5zPyBBbmQgZm9yIExpbnV4IChn
dWVzdCksIHRoZSBiZW5lZml0DQpzaG93cyB1cCBpbiBub3QgaGF2aW5nIHRvIGluY3JlYXNlIFRE
IHJlcG9ydCBzaXplIHNpbmNlIGl0IGhhcyByZWFsbHkgb25seSBvbmUNCmpvYi4NCg0KPiBBIGNs
ZWFyIHNlcGFyYXRpb24gb2YNCj4gY29uY2Vybiwgd2l0aCBURCBldmlkZW5jZSBpbiB0aGUgcmVw
b3J0IGFuZCB0aGUgcXVvdGUgb25seSBhZGRpbmcNCj4gc2lnbmF0dXJlIGFuZCB0cnVzdCBtYXRl
cmlhbCwgZG9lcyBmZWVsIGNsZWFuZXIuDQo+IA0KPiBCdXQgb24gdGhlIG90aGVyIGhhbmQ6DQo+
IMKgLSBUaGUgcXVvdGUgaXRzZWxmIGlzIGFscmVhZHkgYSBwZXItVEQgZGF0YSBzdHJ1Y3R1cmUN
Cj4gwqAtIFRoZSBpdCBpcyBpbmhlcmVudGx5IHZhcmlhYmxlIHNpemUgYmVjYXVzZSBpdCBjb250
YWlucw0KPiDCoMKgIGNyeXB0b2dyYXBoaWPCoG1hdGVyaWFsIGFuZCB0cnVzdCBkYXRhDQo+IMKg
LSBBIGZpeGVkLXNpemUgVEQgcmVwb3J0IG1lYW5zIHRoYXQgYXQgbGVhc3Qgb25lIG9mIHRoZW0g
aXMgZml4ZWQNCj4gwqDCoCBzaXplLCBub3QgYm90aC4NCj4gDQo+IDQuIE1pZ3JhdGlvbi1zcGVj
aWZpYyBjYXNlDQo+IA0KPiBGb3IgdGhlIG5vcm1hbCB1c2VyIGF0dGVzdGF0aW9uIHBhdGgsIHRo
ZSBURCByZXBvcnQgaXMgVEQtc2NvcGVkLiBGb3INCj4gbWlncmF0aW9uLCB0aGUgcmVwb3J0IGlz
IGVmZmVjdGl2ZWx5IHBsYXRmb3JtLXNjb3BlZCwganVzdCBiZWNhdXNlIHRoZQ0KPiBtaWdyYXRp
b24gZmxvdyBkb2VzIG5vdCBuZWVkIFRELXNwZWNpZmljIGV2aWRlbmNlLg0KPiANCj4gSSB3b3Vs
ZCBzYXkgdGhhdCBjbGVhbiBkZXNpZ24gaXMgd2hlbiBMaW51eCBkb2VzIG5vdCBuZWVkIHRvIGtu
b3cgdGhpcw0KPiBhbmQgY2FyZSBhYm91dCB0aGlzIHNwZWNpZmljIGNhc2U6IGJlIGFibGUgdG8g
dHJlYXQgYWxsIFREIHJlcG9ydHMgYXMNCj4gcGVyLVRELg0KDQpJIHdhcyBob3BpbmcgeW91IGNv
dWxkIGNoaW1lIGluIGFib3V0IHRoZSB0aGluZyB5b3UgbWVudGlvbmVkIG9mZi1saXN0IHJlZ2Fy
ZGluZw0KKndoZW4qIHRoZSBxdW90ZSBvcGVyYXRpb24gaXMgbmVlZGVkIGZvciBtaWdyYXRpb24u
IEFzIGluLCB3aGF0IHN0YWdlIG9mIHRoZSBURA0KbGlmZWN5Y2xlIGFuZCBob3cgaXQgZml0cyBp
bnRvIGEgS1ZNIFZNIFREIHNjb3BlZCBpb2N0bC4NCg==
