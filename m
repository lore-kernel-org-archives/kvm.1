Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18A29430;
	Thu,  9 Jul 2026 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783557889; cv=fail; b=BJSwtDdSwDshT/3koDiZGXKVtW+bkesRzcSoJFxkzMy6FUBr7j4zMbInJkhmgWFtDR1MhxYSWT+dr2dh4Tl2hHveldadsMCIeJBWoF5R6qij1s9xoodOFZCBmMHAuhjP/r4/87HwWQFopdPfkCiSdwTPhFTho92JbWvao3BRQHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783557889; c=relaxed/simple;
	bh=2NCmLbdfKBYIW6q4GIkvW21xnNL/EKg5/I5eam/AM8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NioWnG1fSvC9w/7K1CwRDjKA7fFSDhjxRnmrjXHpu4S6hJ3/nH64sLgtRoPOnyR0zkr0rru1YbamUHPqCLlhHzWG7/PhvLITMtQZVR1+XkowHTiJIYH50fXzPeWwOeUxniuP/XVx+h63kw4eQxh11oVpuOfuU7mxlxvh6+1Fg34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRXy9v6F; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRXy9v6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783557889; x=1815093889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2NCmLbdfKBYIW6q4GIkvW21xnNL/EKg5/I5eam/AM8A=;
  b=JRXy9v6F/6Lp4aJHeicACtuCu70y9PPjh9F8jfBspzUK4x2P8R/lot6L
   GFTNZZMh+LlWGH2YMWyLUCNidwjsKv1ICDumw3GXN1oD/jJw0I5fQcGyZ
   XAOrvkkaqe3r7NAlKf9F1F2HL1fZegKf/MKPZZxEL1OPSa8cRhcOkV8AV
   S/lYkECFKp6NaSZDUsnzUstPWntUHpgxAVwyl6jBdTOpPu9tNfLVtjDML
   sS+w+QMG9TBWgTxHC3clmO4omfjtMpitqJJsKSm5oCSnAfABHaGSLhAqJ
   uEO8mb4XrDqWc3LbWZ9wQzMHBYJpqmtdN2tLpFH1rf2rzjLRv7oYMywe3
   w==;
X-CSE-ConnectionGUID: m9Tk2W73TDmrdMqCtmkzRA==
X-CSE-MsgGUID: jkxC4OBHSCGT/bv5+mCnNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84287090"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84287090"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 17:44:48 -0700
X-CSE-ConnectionGUID: gfcEB36cR/yHVBEbeWWqFg==
X-CSE-MsgGUID: s+aS9yXkRf6zUjDN50bS/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251783665"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 17:44:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 17:44:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 17:44:47 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.22)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 17:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mp5mPTnh0fUI3cf0GQmLhqq6UpyHN0/ZdFkCiR5NAtKLu4QY8ncU01Z3rKcFdvljNugJhj50Xpz4XPcioeIQgEUmOFVU4PgCqrWy5kp9rVWYyUClAMc89R8gTac45jRKgAMkyI6lxEuC3NyEPQp5sDTM7Bt81oFtgUE+5BgE+uy9Ld2yXOR+k7P1AQHhrbcxoLC9Ed8KOj+dZYHqGfERUMcAY0m1MREgpk9COWkIlwUINrvrzhyGd1ij2uAcgDB1CsjN/E72PbJz53RuSarKwYPVcbFQgd+tAeG+4QPCObOhcaHuAPdw0DKDUsjNr+/sg8mFgq3afgw9WW/BR6IVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NCmLbdfKBYIW6q4GIkvW21xnNL/EKg5/I5eam/AM8A=;
 b=ebAfsFDG24xGb6YphWVgwjVU1d11czuxQGJng+ZBMyoYlT2+KHTzjxhkKbrTwcZifgOs2m1m0G/tjDJaHpyYpRTH5WQiAWVN3AopiCDiJmcSbjWw2dVi8go/JoE6X+Jqn7ix8lhgKo1et3D3uYLZuzaAHec52wVgEe4kha/jaiDtu2aqLK6eaOe0D4EGNELFJE0eJvDzvLBh8Et/AQdW26s9kO1XyMaSdwtaUBgeVX7FvzwpfbouTHihhCFGq8D/Ez0lg4p1+63rQqwdeTjD8/SiqrOdJ+IwcRf/yPxGLwuxoIJZELKX53ri8qUVxevddp37j+dXwfQMgyZcOCVcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB7793.namprd11.prod.outlook.com (2603:10b6:610:129::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 00:44:38 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 00:44:38 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
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
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Thread-Topic: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Thread-Index: AQHc7LhTkBJCRmynDUGCQ1lB6jZxi7Zjkv8AgAELywA=
Date: Thu, 9 Jul 2026 00:44:38 +0000
Message-ID: <9e7ab58e30e86f823f0e73226793e09308c7b65c.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
	 <ak4OUC9fg6CJ/06Y@yzhao56-desk.sh.intel.com>
In-Reply-To: <ak4OUC9fg6CJ/06Y@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB7793:EE_
x-ms-office365-filtering-correlation-id: 9c3701b2-aaa1-4c28-77ef-08dedd5341ac
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 16jGJKFq+d9pkWSlwycuQ26BGrs9IhcAFNFaSo84SYhdIPA1CDFxaqm/s9RH6fcAzC8zSh8pqQEKHsa77d5ghgkyCbXRsLWrNl60L+CmcJrSJysJPQaYik5PBszhWjDYR7Sw1uhQnDfT+rErm28KNf0MkG4T+t/FwkWpvual8MJm66YiMBPP+XpBRsJJzuoDyVO6UlN+rsxFxRPJwLwaydeqzicMD0pSq3LSmuZNTt9ehVzIdIPHDmOmC9f3jUzKZV38K2FUIVNvTmQB/G/SbiI+8iJx98X0MHv5ywsUJmw3jnHO3lc3TL2o4kS3Tzn225Cl9GyCReoBg66ZjYyfs1pSBmM4XQd/a9GqAXZXgbOnINNPjSICYglAQlN7U6blGJrWDb+FyMSB0xG4PBgJIN/3Iq5Esy56yOWZ3aSpPJXpd5ZNXjm3JbYaZbZ3tfVObc9TbB0SBL6iWtdsJHcKPNBlIkMG4iHggYVcsO6/4hGdqOCqIGktUrVEU2sWJDyPszAlBDxzZ8a8YQz9o3q7zBAwxNW0YxcBSjW2Pw2/sPTaIoqAane+YupHB9DBJiUl3VOEOdrHb4+njymHwsObL21BZlEKyaeZeY+xLx6EvXdTI5KFIqtrc3pq+DAq92T4hZadtsGDFCg55QP6kCbOKlwiW0lg2iSUgUGGqzeXk/3z47yWdlcszdHvXDJZYEtj9anjIfGzY1XqCmeOEMjvnFLP5Lfr61B5ZujeKKWTC4A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUdCL1hUOXNqTDVleEhyQkp2dGFFcW8zek51NThyelhxVkZwbEwrN1ZPcHlT?=
 =?utf-8?B?WFhLdndFbXEvYlNtS3FMK2gwb3VpVDZ1Zm1qNEFtbVZZNG1YVjNHZ1pES2xu?=
 =?utf-8?B?ZDdLNXAyQTYzQUVNY1Bzc0FEK3B5UGpHUU15WkM5dGJUZk1UcjVaU1VuRzNM?=
 =?utf-8?B?RHJuajBGdXYrSVJnamVvWHlOeDdMSzdPV0lSNVhDQnZwS2tlaXNZWStwREl3?=
 =?utf-8?B?YkZMR1kzZDRVRlJiN3pRTG5KelhJN3ZYS2RRRUU3K1hPUzh3S1kvSFpGWFdE?=
 =?utf-8?B?UUpkVlFucUh1RXlMalQ3MXRjSkpUYlRORmRZZzkyMmNoQ0thQ1pOZzU0Z3Z2?=
 =?utf-8?B?MVJlK1U5bjNJbWtmV0tRSVB2TDZJaWRvSUJsQlVIMGxFR1MzRkdEZmtRZjVT?=
 =?utf-8?B?WXo2RkFLZjJ3SFNDb2pBMnBpWjJsc1RETm9IT0VEdThUSzBYcEY2Sktkak5a?=
 =?utf-8?B?cWYvWEd1SUI0cUxsaEp2cklTRW1aYmFhS2hLbnFhSDRUWWtZbWk0SkxwVlYx?=
 =?utf-8?B?RDRRaUk0UElibDJLc3BZNmdaVHFDQmhPdTFQT3oxbFpYRVBaQjcrcDhPRW54?=
 =?utf-8?B?QjhYcjNXeHFOenl3WmY1S3FNNVBVdG0yYzU4aCs1OUlPU0NFcEJnaTgvelZB?=
 =?utf-8?B?MEpZWXl0YXZPSGxPZVMrZnJPRHVrNnRMMTU1TXkxWE9lTVhJQ1EwOVh3elhj?=
 =?utf-8?B?NE5iZE54Z2gvTVlxK3RkaHMyb0M1ald0VGVrMnhzM1hWT0ZHajhzZUh2TFdx?=
 =?utf-8?B?M3BsRVlNNURnRmZENmg0Q3dBY2wrUEUxYUdKS244dHJ6RUV1S1hCc01URzln?=
 =?utf-8?B?cnJxUFlGMWF6eWdqc3VQV3I1Y3dCTUFUTG1wZnUvcy9MUTFBZ2dZVFhkaWNW?=
 =?utf-8?B?cFg0V3g0TlFiT0ZpbTBZZ3crR1Z3dlJ4RUEyUm9FK3VaY2l0MDZpNTFpeWts?=
 =?utf-8?B?NzFRTU05MjJ4V1pGMFd3b0hrS05ETG8xTWc3VVhuNXJyNzhzN0ZrM2VVWFhS?=
 =?utf-8?B?K1ArdXVKLzJET1lDd2hWVnFReFNjREU1a25udDFDUVluQXVtR0NKZEdkSjVq?=
 =?utf-8?B?ZmdoM2g1TUh2T21pNDNidmIzOTFuV0toUWNMY0E4L1QxTHIrOGdzdmxkVFky?=
 =?utf-8?B?Uk10QlNWclh6ZCtaSHhJOUVqUDhFVXZ6c3NYcGMwdUc0elFkbU44UzN4M0Mz?=
 =?utf-8?B?TkZnVTRBUStpZ2JRQ01LQkxqcjZqVktvVWhJNkN2NUhKbkdZY25CcTMwK3hE?=
 =?utf-8?B?YW9QYmV1WXFrZnl0RkYyczJOZ2tQSWlvbTRZRHErVWVFTXlDdm1MYzJhRWwr?=
 =?utf-8?B?RUI1OGhmR1l1clJFUHF1dmQvYmIvTFhCZWlKbGJLZEtJNWRKRlAxSXZpNTlj?=
 =?utf-8?B?K3Z5TjZZTzFibk1ObDJCRFA4SDcyaWxoTTZaMlBBTkpHWUxUZG1wSFBQVWVl?=
 =?utf-8?B?NGZNVUhuVklQUUJOMHIvUFhGZ3YyYjJQOU9Ha3M2UjM5T1N3SWJRUjBwQjd2?=
 =?utf-8?B?ZkpDWFZ0Z1NDeXVaWEFlZEJsTWlLckVNTXpSMFdmdnZ1aUh2c0JtQ1MxbXp1?=
 =?utf-8?B?bHFPaStuN1lOY0FxWHpyOGZlNEN4Z2hvamJXazB5MkRmR3UvN2FJanp3WnNJ?=
 =?utf-8?B?M0dtcG9VdTF0aWNyT21tbDlsRUJhdGZBbVd3WWZBU2swdWU0eFBEejJYWnVX?=
 =?utf-8?B?T1RKMUtOZnBXUU9FYVZoYTQ3ZjF0QzNINjNQaENmQXQ4dS9pbk1KZEQzUTBK?=
 =?utf-8?B?eGdOODJGOXkvQmN4M0RTUy9MSG45bnBmdXRTcVM1RjNNaThCdDJPTlRob3JL?=
 =?utf-8?B?RzF2TmVvU0NCMzdXSFFJNGFuVW51azZEME1EZlEwaFZoa0ZQZDBPMXJEWXd1?=
 =?utf-8?B?Vk4yS21HVW1lZng3SUc0OHhCdElPaitQcStTU09kQ0dVajl3OFBVZzBlTkQ5?=
 =?utf-8?B?RkVvQmdObDhFRDdOdWwyRjZYY04zWUxsaktKbXJEcGxUbDhKWXExN245Nm80?=
 =?utf-8?B?QzBrVVpUSWFabjhuZGVNZ1V2RU1RTU9JQkxnbW9uTEpMU3lxNkhvSVVLRU1P?=
 =?utf-8?B?Mng0cjNaVTdncG9iK2RrYlhhb00zQ1V0MUdyVFpjWVkyNUV5NmZxS05zQ1pw?=
 =?utf-8?B?VGh0N21UanZOUG9vRUIrSjUwYittbitESVIyQWloVjlYV09UcHRCdHJ5N2hW?=
 =?utf-8?B?RmNnMVJ3aWdhYnVTQU9hUVJ0d05DVEZqRXpXNXMvcmVwamtrZUhkTmloYTVx?=
 =?utf-8?B?c24vd2JUNFo3dWIyWDZpMXVwWXQxZEgvaFhnTFI5QlpicXF2WnAzL3ZQK25n?=
 =?utf-8?B?SXFaQXhtYkRzV0ZDZTV0SHNFcjVQQVA5anhtZGZoczZJWEdGRkxnWE5oejNn?=
 =?utf-8?Q?9mJNmgIKkCfFQVts=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FCDCB5EDC7F4E4A966C658162E71AAD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nze2BQTZEek1JCr4XYwNecwz00Fy5fRp8F0RNn33as8qIiAWRx8IuI0/tZJAVAuCXmmGPiu7WiDMxocfbYQ4hlcDOTxNcSKu8lPDVm2Lgk3mlYNAbRe/e7R5Cd8D0Uzxiid1JHIhdaL6465fafBdaDkIz804UERTW8Myuc+rVqxDThATZYBMiGShA57y5abuPyAybt/jHzmfxae/ilwbO4aLUIK+dlIz4pWg+vj3lWki6fjYCEnsfrZKbGd5oUYvLDvxATfAjXDfXUm0jZdEfI3FGxZJOgu8XWPcVeLx+tlwxANzbw29At8/3874ijlFVvLwyylyJDoAPbubTbX26A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3701b2-aaa1-4c28-77ef-08dedd5341ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 00:44:38.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvFXUmGOMrhHStVVMo0U5iTg2zhBuS9eJxue/uvUSejnnigFqw7lDyNmSMHqwUt+UURXndANHy2U3Sr45DRny9aDj+2zu/4hDEfuHcoSkqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7793
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTA4IGF0IDE2OjQ2ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gVGhl
IG9wdGltaXphdGlvbiBMR1RNLg0KDQpUaGFua3MgZm9yIGNoZWNraW5nIGl0Lg0K
