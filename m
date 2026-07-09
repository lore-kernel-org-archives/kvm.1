Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5326738B;
	Thu,  9 Jul 2026 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559558; cv=fail; b=cp8dj3I9ODBzg/hyc0033mZJr/Vy8bjmkCKi1QYIA1yQof8Opi68Z5o0k3Ohh0HfSoPDD2kzPcbpzFp+ADYLiBIOBrOMP724exJNkqiGtQt+XgQ62pieOsET7s57aNnvy9DfOs+P8hnvq/69N4gLvNopPq+iBqiwwAxrhCqixfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559558; c=relaxed/simple;
	bh=atmyHE5c1XrYRNZEkMIXhVEGRmPhERP0qZrg3OsvGjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KJlbUfbYenP/GCRh8DiEf3cUvVgrJBn1Gxn/gSh9CE4OObDjHrSiSEdTOCRSpz+nvJqHXGcFSnQ4Yf4Rlrem4fCntTDN7jfY4G0yFS5OiJbmzkapmBajeHRLBPMs985P1tJT6jQZ72jsBxwwNLje7/xNKXk+wU1Mxo7XhRi/NsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixpMsUvM; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixpMsUvM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783559556; x=1815095556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=atmyHE5c1XrYRNZEkMIXhVEGRmPhERP0qZrg3OsvGjs=;
  b=ixpMsUvMcOUjN4l7FAW/92vsMc4kCkF2vQWctRdl6Lp2tWXng5dKkf5x
   UZjo8rgKokm+oTmLqJfz6kEq+lEtlffr3221yeprJr0GoINqc3YFQfz7+
   qYsBcIS/y7u26xx4RR/YK4clc9eZkYkwV1y82an3OPC69PJGauFsuAdRD
   v5ZvcMKC3UAa1p+6NGjxDET/D0guPJ4SR7WL98YUy0Y7Rt7/7LMGkovXy
   attaN8oYECVr5PRWP2vSuLdFK322ulfUYelIROjMlUEY/3UbVnbhIOr0G
   /dCVixf59l3kUYOKN6l0WWyww2hKhGSUJ6UQD+ViRnfaUobYgKVj9MriX
   A==;
X-CSE-ConnectionGUID: bu7AvLClStWQD3PDNoofyA==
X-CSE-MsgGUID: 8qLZv0eiRq+OTLurGGL9yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84427008"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84427008"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 18:12:36 -0700
X-CSE-ConnectionGUID: DCjTDWdeRK6wzZdowU1tfg==
X-CSE-MsgGUID: njc9UodIQ0Gj94Nv+kOziQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="277670725"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 18:12:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 18:12:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 18:12:35 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 18:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWtWxH078KTHrZbHhLs165ZGOgqd5GLXzbzlXRlvJ9vnOISghJ9hCDeyA3tmMphV0zG/dr/Q5H0hXgP9tbiPJmClkBi8sy3NEynL1dGhfsUiQSE13mbtGOmubeB46oF8ntD7GC6GzpyRMeaBAeUtqD3DcAO79NVOM3ZQf7gddw6koEDGU8tkm2R1B55nubVnhC+JvFiyvU3ZL9OdFJmTCVCAsi/rSf+lQWHd1VuJCBmfm4A+ole28sj1tvYvbqEIwAAzF3ucqg+Dvyq2j2C/BboB3NNXRSVKGBtZzob80z0yjbZwOJcfjdFKfNZW/TO4jP6BVbICmKSEvLikRpfAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atmyHE5c1XrYRNZEkMIXhVEGRmPhERP0qZrg3OsvGjs=;
 b=K4zHCO3/8K8UAgpefqhlWAGneaLmQz8G68X4k15aOlRGNoBW7AlT7XJ5iEBhP0Fi1/22wy5E5oPGJzF0YiJmfHieTv9uLgBf21+J6sxcTew4v4pRbKYNvLa3Kw3+REizlgnM0X5rte4uB+7/V8taxJgI36A7VlrBlJ/BeGpbvUp9JjG/2gVYRQLO5aBBCbH0DS1Rwe/c2BVR3Z3L8Y/fGQsACZIJtVDAfCAlxMAG/weyNbDBGekLQ02l2DlNW7LmLr4X90lDOI0pw9aQX0FpWcZGdSvCUGhgVg8acNHtQz8TpcT7OGg0n/mO/AMLta1SHwkqWe0DiocOBoME9W4Tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SN7PR11MB6852.namprd11.prod.outlook.com (2603:10b6:806:2a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 01:12:31 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 01:12:31 +0000
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
Subject: Re: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Thread-Topic: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Thread-Index: AQHc7LhTEcr7wAnIiUS2NeuNOJCIabZjmrUAgAEL34A=
Date: Thu, 9 Jul 2026 01:12:31 +0000
Message-ID: <f686c26073761302b699c7374b668c933b0452e8.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-8-rick.p.edgecombe@intel.com>
	 <ak4UyN4fnIZasWM8@yzhao56-desk.sh.intel.com>
In-Reply-To: <ak4UyN4fnIZasWM8@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SN7PR11MB6852:EE_
x-ms-office365-filtering-correlation-id: d4c4cca2-257a-45d4-e31f-08dedd5726ba
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: /grX7TH98oLknXdEyXIssuxrtK1VNsoJNME8HJWpLb0/Bq7JtG6RXRMKH+KI4i9xahk4AOirmUW0iZ5qwyG9eIopHYk+pXK4ZWqvsjJ8GeHUb6Pew31Xo8/ye62b21ls99WITr2/NLrcLtxsgpqKvj3EoVz3cuL/DSh1e5s17BeuwXNJuoi+YEJEh3yhFVmezHL2KC0r+gNkaDj/sShfIKscGdPOh3WQRH8BzTGflNqp8q/RYaav4XFxTCtjQTuL+3+b+q7c2/p6XNTuG9f9VCCgNEDN3t3LSHboXnTdR7RF1+nARGGTgPUssZIakE2O+72WO46YXfex29XO1ENrCMU+vWQkqM+v2ohQKKx62ceEBoc1iZF228vbksvBRzzR2ykQjmH3kkw5kXx4gnxu0x7U5ZzmrvHGx2t2lTi5GMHzIer3OnjblHSMNCRAiyRlAhnpm++c0RUdBTCg+gWIpCCLomnWCWdaI8lnAuhqb6BephYmJI3uLQz1vhTM3qKdrRWDrHvwywmITJdWbqF/F+d1GFsOvNuomw9eOCe3UmVMFbRQsQGMFfT9kc6XMJh30saTIoRbtSsfpId0KKEKoTiG1yJIhb0EdDcDV7+ONsmx6nYdtlzdueO12D1GF42c0CUFxP6PTIMm1aO6V1jZXREqVRvjjCUlRVEK6Li0WEwRchmCnvChuWpdu+thHqzOUAuOj15Gcgxiz341onwMcRNnfdd+xuvlmxCGPh0rpJ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHRYQURaa3ZPZEVrN2w5N3EwalcwL0lBSlZEZXA4d3lnM05XWkJmcnZRdnpI?=
 =?utf-8?B?cE5ackJuSmErQWVQanhhdkZIYjJRZ1IvOFdaZlBxVVZaOWNwVmZldTNyVWhh?=
 =?utf-8?B?Q2ZNekJiRjh3Q2pLdnZWdlJoOW5yM29UdVRDOEtRZ28zVGpIbW1DRm5vYXN6?=
 =?utf-8?B?Wi9EcGFUb0trNzI5Z1Q3M2dENThsS3BOTG9KbTlEYzA3YldhaUovYXZ2UnZT?=
 =?utf-8?B?NitSa0piZ2pBZVNEMk9ZUmVMUzJnb3c3Y2VNMUlaZjJ3NU5IT1VaTXhCYXN3?=
 =?utf-8?B?VzJPM1RNZ3VaSmpUT0k1V1gwTWlPa0ZObGFOaWtac1Z5Z21oYnYycTRIUVBp?=
 =?utf-8?B?VUFEZkZITXNvQ1JaNENQOVlFY2M3QXdVdmxFbjRGOEFSMCtsVlNEVnpqdlYw?=
 =?utf-8?B?VnZzTnhGV2ZqMk5DMndocnN1UFN6Q0t0bVUrS0pjQW1vQTh0NHJZS1hSMXd5?=
 =?utf-8?B?SDFibmY0ZzhkalRFZnRCeEZPMnMrQ3V2K1VidVFOQXF0S0dnMXNZUWNVUmF4?=
 =?utf-8?B?VXNyYlQ1Y1pzbTN1QWlxcHZsK0ZFU3FrRjdyVCtKOS9yU0ZYNEJOL0RBaEgy?=
 =?utf-8?B?VnFTMmNwL2xISXBQSktGSTVwQ3J1M25CYllFQmJlSlhPNHNOWk5pK1VYcjhX?=
 =?utf-8?B?dnVFaUlhb1djVTdWYnpvRTRLM3RkdXlZcFQ0dnMvNm1ZYXQ1K0daMUhWakRn?=
 =?utf-8?B?aDZveEo4eWx6bHgvSmViNFNmamN4THVuWVd6cm12N1l5bEI2UjcrcHRKdXgy?=
 =?utf-8?B?K2pENVFmMDhkRWljVjhVUzRFTVRFWk4ydFFjMlpKSUpDWVNlaUZIa1hNWFd5?=
 =?utf-8?B?ZU1TVUJCNU44Zk5nSENiS0h2ZVR5WWpOYkxZcGdvNzJzekp3c3lrOURid00y?=
 =?utf-8?B?NmdicnNRSDVHOWI1S2JHY0h5S1cvdlR0QUlWYmd2amdwaFUzMHBNRldiVU1j?=
 =?utf-8?B?Vm9Dekg3aXBBOE0wT1FJSjdaSi9paXl4MFpWQ095Vkxjdk40TzQveHdnZitS?=
 =?utf-8?B?OHdDNUhJSHZrZWpreXZXR0w3T0pKYkpvdGFxODI4c2w2NWF0N3B5N0ZpalEv?=
 =?utf-8?B?Z3lNb08wL1lmYWs3dXJvRWgva0x4c1JFWlZ0ZDRhaWRIMDJwYi9xdWwxQUtJ?=
 =?utf-8?B?RS9IMzYxUFdqL0VmUEd6RE5CL04yYXhPTEhQT1cvQmxMV250TnNiU0RpbWJF?=
 =?utf-8?B?bm1FSHNYckxXWUVubmpPUVJNWituN2xTV0hxdHp4cTZEYU5xUFZocnMvSjIv?=
 =?utf-8?B?NUM4cGRqcUl1VDhWQkJNU3hoYnNFbDN1aFpBaDJkTWU0ZlhEam96L09hZWFR?=
 =?utf-8?B?RFlidkQ0Kzd5TE9udGpadE1ZRzZhYmN1VzMvUEsvTHJlWTRzOG1HUEltRWpH?=
 =?utf-8?B?TmlVUFpMYnJ1K0g5elBYUGNqUkpGNTM3WGpzRWxnUVY3MmdRTGtkNW9HMVpn?=
 =?utf-8?B?YlRzYVBuYm1SUVE4Zk5RNjU3VXo4Rkx5Z1YwWlpCVkMyaG9YNjlMNnIyVytp?=
 =?utf-8?B?RldFZC9tQnM5ZnBScHJmNlgwMGlFb0paM2pvYTdFTkpMWWFsWkdvUDFKSVpq?=
 =?utf-8?B?Qi9BL2dOKy95cDR6TjNOMDFjQ0tkd1J1b2IxakI5T3k3UGhNbWhZRjNkS1M5?=
 =?utf-8?B?WG45RHBNZTFwbUxpcWpFRG5hbEFVR04rcGxvQm1JaGJ3aHprTmdiVXQ5dGVW?=
 =?utf-8?B?ZHppZ083N29DTUl1Uk5VZGpRcG0wZXM5OEpoZHNFNjcyRTlEOFFtOU1hbEFo?=
 =?utf-8?B?NFJsZHlWUmNueSthK3VENDhlekdTcjgxbzFWL2ZmZVh4Q0VTUzRiZE85cHBj?=
 =?utf-8?B?UFpZMnowM1E2MnhjMENnVEhrZVg3SzFNUkVIb2NwRStrUStwd1QwNFFjZjNH?=
 =?utf-8?B?ME5iVWZaUVNVNVpmUmljMUp6bklRYUxqeXZHNXdFbUxad0FGSjlyWU1pTHlG?=
 =?utf-8?B?VGFYWUM2NUFvSUd2QmV1ZUZSREJjdGZzZHpUOVNWNHQwRG5pQzl3WGR4Y0to?=
 =?utf-8?B?WEVjU3AvQ0Y0UzZsQWtsTmZMYlZPeEtld1pHaDhzVmMyMzBzNE1pZFdpY3Fv?=
 =?utf-8?B?QWliemtSZHczZE5QaW1EbWx6UHYwTHppaGc2ZU1KazVHZEVmVFRtY0xQUFdR?=
 =?utf-8?B?YnF4ZVNTRXBGcENEd1p3b1VNakllZ0todWdHbGhzdHJmcE5BY1dzZ25xVzcz?=
 =?utf-8?B?TmFPQndLQWlrem45WlR3VHVVZnhIbUs0M2M3bWY3a09td29XMDFTMHVXMVdn?=
 =?utf-8?B?YlB5d0gvbFNwRTZhSU52NENtc0QwTVZjWGlBVmd1b1E2TUhrVjgzSEpqUnR5?=
 =?utf-8?B?YkJJaXBxSXV4MFNzVmIrMUxwcWtSeFQvRlhPMm5EVVB3Ym0yYVhueDQ5RlNr?=
 =?utf-8?Q?W2FkMOCMwOWCMJ5Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <811036D00D03D6448003436A2FFDB5C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dPiT9Pj4aMlU4ok78DdHDoi2QANrYAEZ+aw8ZDjhVIC5+/ZTDizm/xJTo0uaQ2JCEX/xv0IWHjNbQOx1qCfy7wz9pYtqomrGCzq3xSrgXqfjEPTPyhMeLTjwdw2CQqKcQJiIRE0iVcf4zIqJG04qcnucQedJX1EcQW5fLILxYKXC6efDRocgH9hWVrxCaJffmVuHNWpbrftzWqZtMN3gefFE9UokVbRhnDsP3xEV4Oih3HARI2UxBSYnzS3O3r5ExXbWt0n/iGNpiorHUETOho7jDPgRYKpsX8KodUgXBgNjaHnPTM4sdzozkWD3a7+324QLmEm2SxXJpi+na1u9OQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c4cca2-257a-45d4-e31f-08dedd5726ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 01:12:31.4376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1o/m6+Uo5/jZjsGFr11rMOSBbwxaMulxzFo0FaivAe/exMwBNPtrkeGSAnU2rAev2/tcmtodOgtLqw5K+v24FVL+UPSjmrSQJ2K3sgm3eps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTA4IGF0IDE3OjEzICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
TW9uLCBNYXkgMjUsIDIwMjYgYXQgMDc6MzU6MTFQTSAtMDcwMCwgUmljayBFZGdlY29tYmUgd3Jv
dGU6DQo+ID4gRnJvbTogIktpcmlsbCBBLiBTaHV0ZW1vdiIgPGtpcmlsbC5zaHV0ZW1vdkBsaW51
eC5pbnRlbC5jb20+DQo+ID4gDQo+ID4gVXNlIGNvbnRyb2wgcGFnZSBoZWxwZXJzIGZvciBhbGxv
Y2F0aW5nIGFuZCBmcmVlaW5nIFREIGNvbnRyb2wgc3RydWN0dXJlcywNCj4gPiBzdWNoIHRoZXNl
IG9wZXJhdGlvbnMgY2FuIHdvcmsgZm9yIER5bmFtaWMgUEFNVC4NCj4gPiANCj4gPiBUaGUgVERY
IG1vZHVsZSB0cmFja3Mgc29tZSBzdGF0ZSBmb3IgZWFjaCBwYWdlIG9mIHBoeXNpY2FsIG1lbW9y
eSB0aGF0IGl0DQo+ID4gbWlnaHQgdXNlLiBJdCBjYWxscyB0aGlzIHN0YXRlIHRoZSBQQU1ULiBJ
dCBpbmNsdWRlcyBzZXBhcmF0ZSBzdGF0ZSBmb3INCj4gTml0OiBJdCByZWNvcmRzIHRoaXMgc3Rh
dGUgaW4gdGhlIFBBTVQgPw0KDQpUaGUgdGV4dCBpcyB0cnlpbmcgdG8gZGVzY3JpYmUgd2hhdCBQ
QU1UIGlzLCBzbyBJJ20gbm90IHN1cmUgYWJvdXQgdGhpcyBvbmUuDQoNCj4gDQo+ID4gZWFjaCBw
YWdlIHNpemUgYSBwaHlzaWNhbCBwYWdlIGNvdWxkIGJlIHV0aWxpemVkIGF0IHdpdGhpbiB0aGUg
VERYIG1vZHVsZQ0KPiA+ICgxR0IsIDJNQiwgNEtCKS4gSW4gRHluYW1pYyBQQU1ULCBvbmx5IHRo
ZSA0S0IgcGFnZSBzaXplIHN0YXRlIGlzDQo+ID4gYWxsb2NhdGVkIGR5bmFtaWNhbGx5LiBTbyB0
aGUga2VybmVsIG11c3QgaW5zdGFsbCBQQU1UIGJhY2tpbmcgZm9yIGVhY2ggNEtCDQo+IEhvdyBh
Ym91dA0KPiAiLi4uLCBvbmx5IHRoZSBiYWNrZW5kIHRvIGhvbGQgdGhlIDRLQiBwYWdlIHNpemUg
c3RhdGUgaXMgYWxsb2NhdGVkDQo+IGR5bmFtaWNhbGx5IiA/DQoNCkhvdyBhYm91dDoNCkluIER5
bmFtaWMgUEFNVCwgb25seSB0aGUgNEtCIHBhZ2Ugc2l6ZSBiYWNraW5nIGlzIGFsbG9jYXRlZCBk
eW5hbWljYWxseS4NCg0KPiANCj4gPiBwYWdlIGJlZm9yZSBnaWZ0aW5nIGl0IHRvIHRoZSBURFgg
bW9kdWxlLCBhbmQgdGVhciBpdCBkb3duIGFmdGVyIHRoZSBwYWdlDQo+ID4gaXMgcmVjbGFpbWVk
Lg0KPiBIb3cgYWJvdXQNCj4gIlNvIHRoZSBrZXJuZWwgbXVzdCBjaGVjayB3aGV0aGVyIGl0IGlz
IG5lY2Vzc2FyeSB0byBpbnN0YWxsL3JlbW92ZSBQQU1UDQo+IGJhY2tpbmcgZm9yIGVhY2ggNEtC
IHBhZ2UsIGFuZCBkbyBzbyB3aGVuIG5lY2Vzc2FyeSBiZWZvcmUgZ2lmdGluZyB0aGUgcGFnZQ0K
PiB0byB0aGUgVERYIG1vZHVsZSBvciBhZnRlciBpdCBpcyByZWNsYWltZWQuIiA/DQoNClRoZSBj
aGVja2luZyBwYXJ0IGlzIHRydWUsIGJ1dCBpcyBpdCBuZWVkZWQgdG8gdW5kZXJzdGFuZCB0aGlz
IHBhdGNoPyBJIHRoaW5rIGl0DQpqdXN0IG5lZWRzIGEgYmFja2dyb3VuZCBvZiB3aGF0IGlzIGhh
cHBlbmluZy4gSG93IGFib3V0Og0KDQpTbyB0aGUga2VybmVsIG11c3QgaW5zdGFsbCBQQU1UIGJh
Y2tpbmcgZm9yIGFueSA0S0IgcGFnZSBiZWluZyBnaWZ0aW5nIHRvIHRoZQ0KVERYIG1vZHVsZSwg
YW5kIHRlYXIgZG93biB0aGUgYmFja2luZyB3aGVuIHRoZSBhc3NvY2lhdGVkIGdpZnRlZCBwYWdl
cyBhcmUNCnJlY2xhaW1lZC4NCg0KDQo+IA0KPiA+IFRELXNjb3BlZCBjb250cm9sIHBhZ2VzIChU
RFIsIFREQ1MpIGFuZCB2Q1BVLXNjb3BlZCBjb250cm9sIHBhZ2VzIChURFZQUiwNCj4gPiBURENY
KSBhcmUgYWxsIGhhbmRlZCB0byB0aGUgVERYIG1vZHVsZSBhdCA0S0IgcGFnZSBzaXplIGFuZCBh
cmUgdGhlcmVmb3JlDQo+ID4gc3ViamVjdCB0byB0aGlzIHJlcXVpcmVtZW50LiBSZXBsYWNlIHRo
ZSByYXcgYWxsb2NfcGFnZSgpL19fZnJlZV9wYWdlKCkNCj4gPiBjYWxscyBmb3IgdGhlc2UgcGFn
ZXMgd2l0aCB0ZHhfYWxsb2MvZnJlZV9jb250cm9sX3BhZ2UoKS4NCj4gPiANCj4gPiBTd2l0Y2hp
bmcgYmV0d2VlbiBzcGVjaWFsIER5bmFtaWMgUEFNVCBvcGVyYXRpb25zIG9yIG5vcm1hbCBwYWdl
DQo+ID4gYWxsb2MvZnJlZSBvcGVyYXRpb25zIGlzIGhhbmRsZWQgaW50ZXJuYWxseSBpbg0KPiA+
IHRkeF9hbGxvYy9mcmVlX2NvbnRyb2xfcGFnZSgpLiBTbyBkb24ndCBjaGVjayBmb3IgRHluYW1p
YyBQQU1UIGFyb3VuZCB0aGVzZQ0KPiA+IGNhbGxzLiBKdXN0IGNhbGwgdGhlbSB1bmNvbmRpdGlv
bmFsbHkuIFNpbWlsYXJseSwgZHJvcCB0aGUgTlVMTCBjaGVja3MNCj4gPiBiZWZvcmUgZnJlZWlu
ZywgYXMgdGR4X2ZyZWVfY29udHJvbF9wYWdlKCkgaGFuZGxlcyBOVUxMIGludGVybmFsbHkuDQo+
ID4gDQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQgd2hlbiBEeW5hbWljIFBBTVQg
aXMgbm90IGluIHVzZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBZYW4gWmhhbyA8eWFuLnkuemhhb0Bp
bnRlbC5jb20+DQo+ICANCg0K
