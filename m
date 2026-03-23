Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1137B032;
	Mon, 23 Mar 2026 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302900; cv=fail; b=VNahyaR1dkCTfe/7eakJNOcQEts8A0R8CBE72k8US+tOHVPRZJ2edTIaIxNUr8hfOupc6lwDOrOoEtjGzJDmsBrGosoOJtgH0fLANOM89Sun8E9jFqzBQEVxgsJhVaZI+c/w9uoGXe1ruYwtYLW32B6KkOCsOdXdUoYRJ9fLDQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302900; c=relaxed/simple;
	bh=46ooAuuiwDP9fN8keZf265pTmg3HFCM8MwezdY9iBA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sDxE3ldKaG3loQqkIm5WCRQjdrxHYLTJ/JmGQSECF/u4UCqxwXKrxNkcArzqnxca720bqGyM1hpNuTf+0i8IDD6jFVmR+THa7pWWZCyf51XEcLFS2PBzblRwlELcR1hlB0KhSx/hw7Os78f0N892ExwpoV0QQEQ/1R6WCNBuPG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3v3A0Fe; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3v3A0Fe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774302898; x=1805838898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=46ooAuuiwDP9fN8keZf265pTmg3HFCM8MwezdY9iBA8=;
  b=E3v3A0Fe6wLqG6PJDEGtXdzUpuh1Y8L+jBkUyxRRu755L1w5AU7q3WId
   4wmn9ftC4lDjUs0rceqNPfgryMUgv7bKX6qkLa/1BNJQ2V5QGtZ6hYxrl
   0yEpba++A0msOW0ZnDRJ6YGswRUBBty4egGXtKCF1545ah8In1Eqnz0UZ
   ++FPJF1Pdm6PqjX2zOW/+H6Pv4VNF8t44Op5h6jn5a7SHZmH6KBepOtIF
   lOO6IkvIcMDjtmfEXA4YJPxog/EHgoJ3DxzI+VJgyIoRYZZGUsV6qOze+
   yIxcd2QFhXNch61mXmo5VRBcMx7ERGhjdb2Hwg9L2WWQK1aR6OWUtH1D0
   Q==;
X-CSE-ConnectionGUID: UD8ijQFvRdWopZHesq8y1g==
X-CSE-MsgGUID: zpBD39vtRCmT8/t2DdaLgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86681768"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86681768"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:54:57 -0700
X-CSE-ConnectionGUID: 7B1ZrKP4Q4qtyBtrGK+J1g==
X-CSE-MsgGUID: vIXTzHsSTLi73ZO3bEwICg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224128298"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:54:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 14:54:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 14:54:56 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 14:54:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs5UhodRvus8ZKGUg7VXmNNkSC0s/6jFHMULAI+f0uqV67QDspJYjcrxaDCm3nOBKAe+SwSCqaZHvsIXaS8bl9n2T4uYTt2zCK66q3iAPCosy+UCj1pBLGHl5ORdsDiIyZd/nBE562KYaRmpoNtFKg38FFhCp7M+a8+yoXDVmW2KxRxK/jlHyqSW2yFqGndUVHHFXkRAwZYd6v9ySDCgtcO5X+s/21YSOtV7j6xXe6YTz4PuT4SU3TjqfJPBOitqTksWgu3FUxv9/qxYoohGWuE4BquE2pbd//Pj3M7nD13hoLaj/74k+N5U4xpLa6Yfy/iiPN386/NBCt/YdyAbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46ooAuuiwDP9fN8keZf265pTmg3HFCM8MwezdY9iBA8=;
 b=a+Jod8w9/sCuaipCi9WYseW/QD9Gbyzxkm7Y8wnlJKECjRVWdv5lJPnfLsjo933wTwR7tFz/DL2xCQadWye/Xm9ZqpIOPnI2kGZO69cTOjX4TKtTYMAX4MKd1GsDC23RUM38YgA816PWRG4Jmp3iO632cKBiZKhSW+8i5Pwew4K5C7diHuu1lg53XBcE7DEL5VPmLYbVMSi9caXFqHOWEN30EWD83fjXDGk0Qt99lveJ/ys0VC46BpcCtC0yZC/vvdadTK4TviSS9I3rWzN0zV07W/D55t0TR3FibHe994xaYlbltRFITsSoFLP+rJLLH5FL7E1q4w8oJ0D8N+ueiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SA1PR11MB7063.namprd11.prod.outlook.com (2603:10b6:806:2b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 21:54:52 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 21:54:52 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Topic: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Index: AQHcuwf01Errp9mqPUyCn3sEkXWS27W8qUgA
Date: Mon, 23 Mar 2026 21:54:52 +0000
Message-ID: <7f054b8fcf7747cb00482563cd00385d7e318c4a.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SA1PR11MB7063:EE_
x-ms-office365-filtering-correlation-id: 815bfe47-77a9-4787-9d09-08de8926cfce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: wmM9jOohx1GyGDe874y9knUSBOmqIK4JB9/z8xM/AaAEeCqud9GZaxZQdn/bXqB39RDtVP2r6wkZNorTiPR9o/koJZKjeNwLQy/b2KTIjZfPXrWP4jPagtEtMb5wMCxYmRyWj+IeRFPOY0+TtmtZui0ubRm8cKmJZDp2NZPE4svSzNGjvWuuyZPPDuBjdkQ9r3tSJ2zDPRVzA3g3GAr57adLGF243sZ1zOOXZQcEG5Z2rdg7PMu9E8ebLZA/Mrvq5Y0Q7slSh6OPaSAJEOSzgoMvua76I96S/ielln+EsYJn9tJ70QQsI5FojXHY60/SGAwlmSH5E/OUTIVJKeZkHuFcHao3WNVh8uocwnSsHPg7GxDDBaMopm9utMVs0rR/5jtuCUOelxOiPqxmK1dtwy5M60tta1KTqp7vHcEaaCylxvi6Ftjsp2rTJ5Tjxa0twuuNxr4I4iVPalfV8GcrPmmjEdY8LveHkhFim6R7YV4qkGLxY+cOvOvKdBzdZlDQufZ6UyQZkdN1dMr11oB+v02Iz2++cYgtFlmk1rYUiKdYw8azV/aQ8dNVgVxSAgUBux+VOxRRp5MY/tUvOEuU81mv2RMLnrawMBzONrEAtfVTtZnG7FsqxDZt4Ta71ZzxBZoxMUfPtrEa1I3RnTqZZeZMxJmVOS1RpEaee+X8fINN7RUL2zyvarBEE2sNOP6nIiKnJMV2fNe3iUv8iV2Id9SfbgNHHtNc0rfHhNvQnTuqUwLOjUTE7FsrI++XTk6UuGh/kTBU+WgJpkLPQeLDCl/ikSwKfWxQP76rzgv0K0q54Z5/tPopjRWBN873lqZB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXltK3pkaDQ1NW9CSWZIQm43TXJjME9CcDhoQ1hoVnVYOW5hL2xUaUJhWE1v?=
 =?utf-8?B?dTJEb0hqVUplcDBJNTZVZmtkTFNLYm52NXJDOW5QQzJ6YWhob3pTY0VVSndC?=
 =?utf-8?B?dWoxNzh6Y0V5ci9lMHNqWE0yWEttTXNsc1V1ZGdjU3h0MWRCTVZOSnpRckJk?=
 =?utf-8?B?bE5JOFEyNmVxeVk3SnFKRUs3dVFUZ1poY25tWEw1MnBOUEFSbkhHZHYwaGJW?=
 =?utf-8?B?eHU2bS9GZysrWERtcGQwdk5la01qRGtiNmJMY0xsekprS3hOUzJLNmZWNGhK?=
 =?utf-8?B?MWtiSkljbmVteHYxaHlzd29TUTdCUmM3RFVmYzI0UjlxcTI1Q0tPcnhYZm5Z?=
 =?utf-8?B?aG8wc2V4MEZhWjBNamJuRFNKK1hpUlJDSW5aSDdlOGFubGJqK0MxK0J2OSsw?=
 =?utf-8?B?NXViMDhpdk0zbEtZc1pXZmhQZGpyY2hGdVpXU09nREw3c2pHTmZJSjhFekZ3?=
 =?utf-8?B?Z1dnQ0kzNUVXcDQ2V1VNNExIL1Z3TERLRlBLdWVNd1dsSXR2VTFnSFhRc3ZB?=
 =?utf-8?B?aW96UGt5KytZWWg5M09MZWhIRSs0MFVUUzdHRi9VbjIzQ3hzbGVpS2VCQmFI?=
 =?utf-8?B?bkxPaUlXTTM4TUQrbmxKczVrSHFvV3NLRkw1MHhPdGdzMDVHUHFwS2hXaGJw?=
 =?utf-8?B?SklSUFhGZTV1Znd1U09OTU4vOVZ4a0piaCt5MjV1NitpMW92aG04Ri9sb2Na?=
 =?utf-8?B?MTFnY1lPQm1WcFdNYmlPL1FOejBqRzZ0RVc0aXZLVzZVWkN6MDFPSjVDQ3E5?=
 =?utf-8?B?Mkc2ZFIxSlFDY1dnL1NVWFlmdC9tb1hDWlJ4VGdpTm9xc3F4RkFGMmNGNEgx?=
 =?utf-8?B?REZuaDEzZmVGL1ZNL3pLcUFYZDhheXlFc0hKRDE0eWY3SFpNNklvbDcvTmVy?=
 =?utf-8?B?UTZld1VQSFlQZ0lpT1ZGVW02aGRqd0p5TTIrVzhUbnlhVUdFUWdlYW5kY1o3?=
 =?utf-8?B?VTRrdmlGblUzUVlsNjBYdmVYaDU0V3dlTVgyUUsycGtZRFFGOXhUYWpyNE9q?=
 =?utf-8?B?eFpHODEyeUZZMm1NVkFFV0RaM1Z2RGFFYlEvZ0lrV2NQaTl2UnNKczFsb3Iy?=
 =?utf-8?B?b0NleHczRHR4b1Z2Y2lWSU5xSkhPYWNubTAreXQ4cHJYTTlneXcrZ1VjRlBY?=
 =?utf-8?B?TGkzRng5Sm5QZDUwUWtzT1BkZ2JZcmdETERNeGlsbklaSnRCMXAwY3VhMVBQ?=
 =?utf-8?B?WjBGQTJpSEoxZnZpRVRCVlJqN3BPN2ZtazNMUUxVeWFqRG93aHptNFhoa3lP?=
 =?utf-8?B?b0JjWTlScEVyRWZMUXdaODkvOFI1UVFUZThmMzIvMk9lbzgxT0JnT3ZFZTJI?=
 =?utf-8?B?Tkd5ME9MKzR2MEVoSFVuQ1RhckJVMW84S2g4VGVxWmVXa2Z3eFJlUFcxUnRm?=
 =?utf-8?B?am8zbWRpU2dVeXh0eFB4SndBVWhIQ1J4NnRmWEtkZlF2RThOVW5ubDB0UHln?=
 =?utf-8?B?TDV5STZBM0hybC9ZMW13dWcyRTVSV2lNaGoxWndra2tqOXV4S2NPWHdkd3VB?=
 =?utf-8?B?QUZnazNncEpmTkdrSG5OKzBTNGpOU3BKOC9nOXRLWFpOcEJEa2F0ZWQzczdu?=
 =?utf-8?B?UWx2RE1hNUtCejZyTFhkVXNPakNpS0pzUkRwNENEOUVYbEl2ajFNOWw0QXJn?=
 =?utf-8?B?blN1ckQvalZWd0JXajNtb3kvT0JrT0h1ejN0YnpWNjNtdWxqbC9oSmxua1R4?=
 =?utf-8?B?YlBkMWROSnJHQk1MK1BoN2hWZ3FxOTdsWGkyZzBYc2F5Y2F6NGRWSjNOd0hs?=
 =?utf-8?B?VElQMlg3VVVjWFVMN2F3cDh4eEdlYktCS3d0UzZjeUUzeUdzemk2WG5sZEVT?=
 =?utf-8?B?RVdzQ3M1cmoxTXpSNFhsY0JSamc4ZS82aEZvMndSOXlnN2ZTTDh6a1hsWGpP?=
 =?utf-8?B?S1J3QzlPYk9qdEhmd05PcmZEcmpkOFpnT3JaMkhoY1VwWjZ2ZlMxemhpY2Vh?=
 =?utf-8?B?L3V0WkNwREZtdmphTTJNMyt2aXNJVFZtcitKZ2JWNm5zM3ErVmltdHlMT0ZS?=
 =?utf-8?B?ZG00dzIxa2twWDR3dVJocUVhdjE4MHdTNWtzRHFJSXdFOG04QzV3bGNtUm9D?=
 =?utf-8?B?NnBHRFdLYmJzZFJYODd4UjNTRTNIbjBsdWdMRGxLU0loRXBHdURLVVBLTnZl?=
 =?utf-8?B?SnhHTDc4UDZkZmpCWkdaRlhVUUIxWEl4Um1seHU2U1NxN0RJa2pTb0xDL1FF?=
 =?utf-8?B?b1ZzSWFpS0oyVHBFR2pSbFRRcVhKaVZiSDVMYzVIODdwWS9IdzZRdzRGQUln?=
 =?utf-8?B?OGZUNEkydjlYSWJQTk0zSHpUb2theHJaTE1MZXVuemR2cW4yRE80QzFha05n?=
 =?utf-8?B?emdiRzNVdjFVTlNwTVRwcE40Ynp5K1g5Tm1xYXlUZkZPdmUzTWdlanBGcmFK?=
 =?utf-8?Q?/T+Al3H9HklfD85A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAFC3611C8EAF448A7B35A905A15DE04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AvVWq3AILV7Ka+sNkSmKITS9CcILlCG/pKxOvgLXyQpJPC1mpw1DXoq/GM7Vx4diOKlgcuOl3cn1WaI4ptdLHeoroF5Rkww/pQG84VViVF96Mfg3sAklIWsHX7CxSZPsgSlFpKRWrVHUvlzW04zni+qM8IkZsQJOnG9y72SqHEJ9WfdEPJFjkDB86ECDUgLXDne9yXYRJjDD1VdOzauFL5BBT8kqHzLz4/8KtugCmpbx7RSJwHkqlXBH85B5VzuSbE8a/sqRfUX9jBOumQOZ3kZs5XSSUAeGCk3ybBNgb1yLfE6j6r7ZDN/Zb6peIrSuGSL8SK+69pCQmzJkFEpBrg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815bfe47-77a9-4787-9d09-08de8926cfce
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 21:54:52.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsH/bJmqE8yjyVbMmUHJtCSBjdEfuUbHw3xpH8TU+2mBSCudP50DgqRrTqxXoPJeAfr0NzwI3Z5nq8PyjtmEWxS4BdaMH9UGqX0z/NvJA5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7063
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTIzIGF0IDE0OjU5IC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IA0KWy4uXQ0KPiArdm9pZCB0ZHhfc3lzX2Rpc2FibGUodm9pZCkNCj4gK3sNCj4gKwlzdHJ1Y3Qg
dGR4X21vZHVsZV9hcmdzIGFyZ3MgPSB7fTsNCj4gKwl1NjQgcmV0Ow0KPiArDQo+ICsJLyoNCj4g
KwkgKiBEb24ndCBsb29wIGZvcmV2ZXIuDQo+ICsJICrCoCAtIFREWF9JTlRFUlJVUFRFRF9SRVNV
TUFCTEUgZ3VhcmFudGVlcyBmb3J3YXJkIHByb2dyZXNzIGJldHdlZW4NCj4gKwkgKsKgwqDCoCBj
YWxscy4NCj4gKwkgKsKgIC0gVERYX1NZU19CVVNZIGNvdWxkIHRyYW5zaWVudGx5IGNvbnRlbmQg
d2l0aCBUREguU1lTLiogU0VBTUNBTExzLA0KPiArCSAqwqDCoMKgIGJ1dCB3aWxsIGxvY2sgb3V0
IGZ1dHVyZSBvbmVzLg0KPiArCSAqDQo+ICsJICogVGhpcyBpcyBhICdkZXN0cnVjdGl2ZScgU0VB
TUNBTEwsIGluIHRoYXQgbm8gb3RoZXIgU0VBTUNBTEwgY2FuIGJlDQo+ICsJICogcnVuIGFmdGVy
IHRoaXMgdW50aWwgYSBmdWxsIHJlaW5pdGlhbGl6YXRpb24gaXMgZG9uZS4NCj4gKwkgKi8NCj4g
KwlkbyB7DQo+ICsJCXJldCA9IHNlYW1jYWxsKFRESF9TWVNfRElTQUJMRSwgJmFyZ3MpOw0KPiAr
CX0gd2hpbGUgKHJldCA9PSBURFhfSU5URVJSVVBURURfUkVTVU1BQkxFIHx8IHJldCA9PSBURFhf
U1lTX0JVU1kpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBQcmludCBTRUFNQ0FMTCBmYWlsdXJlcywg
YnV0IG5vdCBTVy1kZWZpbmVkIGVycm9yIGNvZGVzDQo+ICsJICogKFNFQU1DQUxMIGZhdWx0ZWQg
d2l0aCAjR1AvI1VELCBURFggbm90IHN1cHBvcnRlZCkuDQo+ICsJICovDQo+ICsJaWYgKHJldCAm
JiAocmV0ICYgVERYX1NXX0VSUk9SKSAhPSBURFhfU1dfRVJST1IpDQo+ICsJCXByX2VycigiVERI
LlNZUy5ESVNBQkxFIGZhaWxlZDogMHglMDE2bGx4XG4iLCByZXQpOw0KPiArfQ0KDQpOb3RlIC0g
b2xkIFREWCBtb2R1bGVzIHRoYXQgZG9uJ3QgaW1wbGVtZW50IHRoaXMgU0VBTUNBTEwgcHJvZHVj
ZSBhDQptZXNzYWdlIGxpa2U6DQoNCiAgdmlydC90ZHg6IFRESC5TWVMuRElTQUJMRSBmYWlsZWQ6
IDB4YzAwMDAxMDAwMDAwMDAwMA0KDQpXaGVyZSB0aGF0IGNvZGUgdHJhbnNsYXRlcyB0byBURFhf
T1BFUkFORF9JTlZBTElELg0KVGhpcyBhbHNvIHNlcnZlcyBhcyBhIG51ZGdlIHRoYXQgdGhlIG1v
ZHVsZSBzaG91bGQgYmUgdXBkYXRlZC4NCg0KSXQgbWlnaHQgYmUgd29ydGggaW5jbHVkaW5nIGEg
Ymx1cmIgYWJvdXQgdGhpcyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgLQ0Kc29tZXRoaW5nIGxpa2Ug
YmVsb3cuIFRoaXMgY291bGQgYmUgaW5jbHVkZWQgd2hlbiBhcHBseWluZywgb3IgSSBjYW4NCnNl
bmQgYW4gdXBkYXRlZCB2ZXJzaW9uIHdpdGggdGhpcyBpZiBpdCBpcyBhY2NlcHRhYmxlLg0KDQot
LS0NCg0KQW4gZXJyb3IgaXMgcHJpbnRlZCBpZiB0aGUgU0VBTUNBTEwgZmFpbHMgd2l0aCBhbnl0
aGluZyBvdGhlciB0aGFuIHRoZQ0KZXJyb3IgY29kZXMgdGhhdCBjYXVzZSByZXRyaWVzLCBvciAn
c3ludGhlc2l6ZWQnIGVycm9yIGNvZGVzIHByb2R1Y2VkDQpmb3IgI0dQIG9yICNVRC4gZS5nLiwg
YW4gb2xkIG1vZHVsZSB0aGF0IGhhcyBiZWVuIHByb3Blcmx5IGluaXRpYWxpemVkLA0KdGhhdCBk
b2Vzbid0IGltcGxlbWVudCBTWVNfRElTQUJMRSwgcmV0dXJucyBURFhfT1BFUkFORF9JTlZBTElE
LiBUaGlzDQpwcmludHM6DQoNCiAgdmlydC90ZHg6IFRESC5TWVMuRElTQUJMRSBmYWlsZWQ6IDB4
YzAwMDAxMDAwMDAwMDAwMA0KDQpCdXQgYSBzeXN0ZW0gdGhhdCBkb2Vzbid0IGhhdmUgYW55IFRE
WCBzdXBwb3J0IGF0IGFsbCBkb2Vzbid0IHByaW50DQphbnl0aGluZy4NCg0K
