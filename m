Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1241305674;
	Tue,  7 Jul 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463552; cv=fail; b=qh/oym4L8iucfvYNY7Faed9WFOyENLPRxgmP2hz0lSKUTqbEO+VBhLoBtXatFYp2t8aKoKMCoDJbMjx0Y/QeMSNiFXUlk5bvcgbPTMuUXiTiqsu/Htl5qwL3LzXdiiTWwu0N97qrGpj6Z7P532GKdKhwEJ8Sbv4nIlQptnUyOFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463552; c=relaxed/simple;
	bh=C/6T3ZfHZRZKFn1Wiu19URRjVDwx8u4ZVIX/4Zg9erM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=klvxAuMK7lilFiiq+Cho8u6lTSl8+BgE0HbD/frSYNyij4om65g5U4VZWaJ/BZt8YsETZOHunSStMHZVmyiEQ+wyTEg3z8q6WQ/f0ykbYzG1iCvsBZAsyX2L/spPl4ZsCgL1SuCFowhha0czqmnoZZAcmxemlRaR898fa1/z+1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlhiNbHC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlhiNbHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783463550; x=1814999550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C/6T3ZfHZRZKFn1Wiu19URRjVDwx8u4ZVIX/4Zg9erM=;
  b=PlhiNbHCj8AIRbP738h4oHO5mOIt5A9IZh9htH5Fvv5+UYFiZNCXY2kB
   KopsYbBmaXAryXRuXMxLokY2dstvgHgUGHlP/Vfn6I1KGDtkWv5O5NnV3
   Calqua+Q18VXS5JZK6+JG+Rg2XQStFcPr/qA4492AhGDcE26GiNCrLIjy
   NXvjEwHIKiUzLtlAu9uLt4ZfHrkID4cZLOHpQ02hegThFC6KXQ+udzmmc
   uOz8O/Bp17EH55zmCytPK8aO1a5qhoajpHitVWc1BM+ViUd41+5GvrguD
   ceMRpa5iSwOfvWFjzwAJdh3R9yOCaUKYvI0lj+kmIggCj4R8tSWGw1kl6
   w==;
X-CSE-ConnectionGUID: abakRTW+R8q1MzBRlvevmA==
X-CSE-MsgGUID: VSS1uYDdSJqXnq+XLDBuYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84178366"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84178366"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 15:32:29 -0700
X-CSE-ConnectionGUID: WsBrcLFdQUibJtg0zyItdw==
X-CSE-MsgGUID: oaSOAVzHRSyFRf0TrnaGxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="257999357"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 15:32:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 15:32:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 15:32:28 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 15:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYwyHAso5plrS4+bq9i1jOnm419OKexQEqLbwY6+wKXynVEpTK0zmj6BqZLKXFBDwJ5uHBVAvgzAcKCIzIcRhhFHgVoBX26UsFESQLQUZghriMd3PvSHDOhoer8oYNw9DGIjNq9TB3OTmd0vfGuH+Cb4tZzn52an+sAf5dWpivELfIBtRahY2JE5IfPwjaVkAVonyX95dz9qlKY/MTw4VcQZpK5M48aoxdmGQ25pd6Qq0RvqU39M71Y1bj5HVnMwj5vF5DWOWSEjQvHE9qxpNDHGLVcTWwjAHoi4o4LYVYxPAtbyRolyD+HCGCrjYm5OlTt1vckjGTjw2+RXBA5G1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/6T3ZfHZRZKFn1Wiu19URRjVDwx8u4ZVIX/4Zg9erM=;
 b=lFQ3QHb9Lsq/igLrfP/xVDutA+AR1OYYiEQ4DQgwWaGnaGJxUkcWPlYYosXGMq+zvr2i9V1qJruxBWR/flIcqIXR1xiYjUW4UtN/XGFRqyCig9pdu63KD3rmBPnopncbssIhEGHYuNk8i/xsoe8e+F7irPZQFnbZdNl2FI75CMjJ6vRXoT8dSSDi2dQkcP3nS4kcVaDKwCPqGEEWeyKsDyOxwIRY/lJKdO3hLz2+6cWU8znRK9TEu6TcnbwSAA1XwIhWGgNff3Gxh6wzyiNZ4lNzFM2AlejjNw/wyIJzMVsuIi7zR4dgO6vB2sdlHNUKOVWAxfaEVCV3585OwyIuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB8012.namprd11.prod.outlook.com (2603:10b6:510:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 22:32:23 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 22:32:23 +0000
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
Subject: Re: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Thread-Topic: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Thread-Index: AQHc7LhU1bCbzezxb02fxsgzvwPwJLZhv7cAgAEny4A=
Date: Tue, 7 Jul 2026 22:32:23 +0000
Message-ID: <331c2d328adfdac2511b500e04d3969d42433707.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-5-rick.p.edgecombe@intel.com>
	 <akyGVOzkHBkST4hK@yzhao56-desk.sh.intel.com>
In-Reply-To: <akyGVOzkHBkST4hK@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB8012:EE_
x-ms-office365-filtering-correlation-id: 9bbc98fd-5e03-4eed-2b5d-08dedc779d94
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: uKNtZSvs3X3lysCeGbQvCdGR2icnT+P893gj77F2o05ahyNYpZh75rTK5M1ySiwkXBP6bju1xfWttNe9bAnK3feLMtsTuaAxzbW9RXLZXsI5HJ8oC/sMHRfuS9DdCpETQHBgTkUoQUQEw2wZON0fM+NMDM+KrTMl0bKYJgtKpYAzgj+dtvz8nWG3im0PaSbTnM5St0u1yYcfNVEJBKnA33wH9kh5RZnAXjtUETng/UU9XThrt7pZRlegU71jGb8N4Lxs18E8cJsd9TGeFKCf4OsY53Y+Ajqj94yauDGCZJxoEAlBao1tyqlUI4YWg3kzv8E/PGdEJ3Uin1aQxPyX3I4ZZpC3W8t1Q+3xELR4JOBTa3MuJ3Yr6UQUxhVTBc08WlMsbsy5NrkYXuk1Q9/SOfqZneAsy/qc8bP7IXar3wOsF2J9fHd7vBGeHIH7fveF16hZL6vTkHWx98WHYvO8RdB9qniWEXZDLZgIH3deJQkMPnC79mnb3UXUA+onvbT8IWGszN91q6Gxf7YyENi6Yx1Ota2eNrhChAHmNZlGtaXEA6OQlSYNwmk3Hwj2Fnak3am9rZs+XiV5D5AFBvo0wbiuduSs/MY+LEmWNH+i8NBABotmm+JzVh+n0hYk4B9eshpf06Kj4CRsEAcLx4buVAulpylIpfu+AE7+tEZk+Zm0krMwqUR79kqU05E1Mk5mq15ZTDbWAe1zfK6KgR2jskj78D1JBFVgJJZ48SosiyM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDByamt0UllUcUNGQ0gxRmhXYllzSzhBTFJPZ0VNUElLbkhSdmpLZmdWMndu?=
 =?utf-8?B?bUI5TUl0Ni9MblZXVXovbTVWRVRVQjBRWFgxVnhLYUVPOWx4ODNXcTl5Kzdv?=
 =?utf-8?B?NEJlOXl0T0NUZkRhaGs1ZSthQThxZVpUdGtXQkt5bUFpVU9qcnZVRGVxUFRa?=
 =?utf-8?B?L01vNE5seS9NWlBEYm5OYVpuNllQUHNMVm9TMzgyRkUzb2VURGdMUjFiMEJI?=
 =?utf-8?B?eUgvT1lPMEpSNGFPRzdPZVB6MXhQL3FBTG8raDdXOStRWlJ1VUM5SVlNU2NE?=
 =?utf-8?B?NWg2alk2dElmOHZSUE9wZDAwcW82UklBMHlKSGVFVS9JdUMyeEJSMm8zSkNU?=
 =?utf-8?B?L1ZZZTJpcjIvdGZhUEg0WHZqU25SQ2ZDYXBqb1JUN09ZNTlnOTZQeDd6c0xv?=
 =?utf-8?B?eW1jZkhTZldkdjdrcXpNS2ZOYlJLL1BnWWRkVzQwMWZZanRJUDJPbVliMWg5?=
 =?utf-8?B?RTA5VVJENkcxS3Azc1RTcENZdFNtdExEOXlaSURpOEVlYytMYzRKalRrOEZ1?=
 =?utf-8?B?VnIreG5OSk1RNVZoaUQzRUowd0xVZDhsUHRZMTY3bXlSNjgzRGJDUW1JYmZ6?=
 =?utf-8?B?Vlk4VENTQWFoTXFxcUhCcGNrMnZrcnVwOFJaVEhaNGJHZ210aUMyOHJTQjVu?=
 =?utf-8?B?MlVaYWNyRjQwWVhJYTJGRHl3VDR0Undyc0lvSVBRQ0FtRHo1OURIMDlhODhI?=
 =?utf-8?B?Z3dLTllNVkNKa2g4dmZ0TDR5ajc4Y1NMdDVpRUxjSGhSUEVQSU5QQk5CR2R0?=
 =?utf-8?B?YXVRaDA3eWNhWDd1MmluTTk2Vkwwc0RodkdIRkVwT1p3cnN2ZjdwaTFSTzda?=
 =?utf-8?B?VWR2Y2JIM1NNMzRwNWpPTFlaOHV2VFd4WVBxYzRSQXZ6WEZpNUFJZFYwcmN6?=
 =?utf-8?B?bFFyMW14UXVTZ2pxMC9USVFuOVE3RjFpUGVHc21Wa2NlM3h5aUNlcXJLRWd0?=
 =?utf-8?B?QXlIZGZuVmRaaWNhQUtFMTh3QmFhWTBBVXRDaTdIMUo5MVE3V3k4UEh3ak1w?=
 =?utf-8?B?Z1RWSG9SUVdncjZIcUZFUG91UFR0dlAyc1JvbXdZcFRzbXNyTHE2ZldDWE51?=
 =?utf-8?B?cEQ2VDdzUmxySFh2bk85RjBlWGRwWUNxVDNvNWtSZ1JMUldkL29VWDhyV1No?=
 =?utf-8?B?M1BVYkROQ0I4NXVJMDFaK2hLdE1iZTBmMU85NHZDK1o1VE05QVZpYWVpVGc5?=
 =?utf-8?B?RUxESkNSS0lva3ZQVGtneksydlFGSGxRZW50QkhYc2J2ajJueFRpbDlYYzVV?=
 =?utf-8?B?YkdWanp4ZVVDU1h0a3hTdmxCZ1Q0ZDBkOFE2V1JUc3VNMDRLNWFyc2h2WDZG?=
 =?utf-8?B?c3B4dnBRNyt4UW41R3Mzcm92Tk5adm9oaFhFQnVhaVBnek03bnUyK2hkSTc5?=
 =?utf-8?B?NGhNL1RaaUdVSjdtRkVSYk9uTmxYeWpyWVZnZ29DaWp3bk9QZmxzUWdZeE9v?=
 =?utf-8?B?SmpLdXlJQjZobE9idjVvRXJXV2pzR3paRUdKS1JNZzNQSHc2aFRYbXJPRnd2?=
 =?utf-8?B?K0s1Z0Y4UEtSbk5iTjNTdUJnWm00R3BNUFpiTFVuYWE4eDYxTVltY3lhd1Vz?=
 =?utf-8?B?MlZ6cUhjcmVWN1UzbDcxRTgzVERDWURmVFZTUG8xbXZWS3JFQmMrNllibnJI?=
 =?utf-8?B?cWgrS3NQOUhFSDFlUWxTSVNRUXduOGl0NGVkREJlNytYblk0eERTUGlTcUY2?=
 =?utf-8?B?Rk9nWlJmTkkxZmdLVjJRZXk0UUxhQ3hjanRnT0dQbm9FVE8xaU93aDAvMEQ1?=
 =?utf-8?B?TEpGTmdlaHdKTURkdTNYRkdxdGhGWE1URy9HY0kwbkFXbHFEMGhtYVlwK2I0?=
 =?utf-8?B?NFR6Vm44STgzWnZVdWhES0l4SURjM1hxRzFWanlWRlB1M0ZJZGZ3YkNrU1o4?=
 =?utf-8?B?ODFzVTdiZTFHN2tFTkwyNDRkcHJmUHUwNS9PdHcrYVVBNUFVR2xjMEZYYklo?=
 =?utf-8?B?blVPRStFeG9sQlB5eGROcXpTd2RlcjdJdndacjlzQ2FoaVo4Zk5pSmpPY1dx?=
 =?utf-8?B?RFlObXBjaTNmUnh5bEdCc1JUeXd5LzBqTis0L01ZL3N2Vi9BK1hhck5Xcm1R?=
 =?utf-8?B?YW5Vb2J0ckRzQlhocXp3TnNDWE94NWR4bUhXRDREKzROQ3pXc0ZLT1MrOHdE?=
 =?utf-8?B?MDhQYVhEQTBxU2JpWUVPN0VJVDlWYnpMTEhlVEdNVU8xaXNPY0hrNjVnUGs4?=
 =?utf-8?B?VnJMWlZ0Rm9UMlE0U1FQUFBvL2ZKY2luM1lmTWt0cDN0Zm96UHdwUCt6MXE4?=
 =?utf-8?B?NUREbk1wYS9KSitWYkFYa1FBZzBzQ0ZTbTF0UVRFNnIyZVAvaVFkRzVwK2VY?=
 =?utf-8?B?eW52bExTU1JlSC9BR2VtVFNvSVU5RjhWV1RXaFBrMEg4eFdsSlZQZStPdURM?=
 =?utf-8?Q?rXK/4+zaf1R7/mdE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4274B3CC6E218E4F9D1961B9636260CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YZPblTfTWXs+jo5eiv/mHhfr7nhnogH8rDa8Tr3Y/nPZsjqt0Iz5/aGgAH32/S7fMmVVK1rdHPsh92HToNSkshxzpv/5X33D33d/m8F6VG1o77V8kF3+7bfK7OqIQek404ExCZPmhWDgd/v0LNYnG8z1rtUkWYa+qMkw03Onye2NdNyKf4Elp0CN4Zmxn6P8QxP2MJuXMv3/zkpxXr4bHvoIBD0Fuvkn74qs7GEHcOdBPyVue7km5fT3T6v+c0JUsVqAhRt52Y1gPWhDPKCevn5mmqTBzNTAUF9sjIcy+AjSpUckmklFVSPZTEEDe36W6uhRfsM2LpQ2Wm9n4+c+iA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbc98fd-5e03-4eed-2b5d-08dedc779d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 22:32:23.5469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CuZL/xsryGUzldrvZR0fbFIoyfvTVbi653MChNO1YdCRnab2YbdChLhd3OkeHqjdtQV3z4WZ5Y4aitKVPC7Qt70GdN4V3hnuOuPkAYjSRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8012
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDEyOjUzICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
TW9uLCBNYXkgMjUsIDIwMjYgYXQgMDc6MzU6MDhQTSAtMDcwMCwgUmljayBFZGdlY29tYmUgd3Jv
dGU6DQo+ID4gRnJvbTogIktpcmlsbCBBLiBTaHV0ZW1vdiIgPGtpcmlsbC5zaHV0ZW1vdkBsaW51
eC5pbnRlbC5jb20+DQo+ID4gDQo+ID4gVGhlIFBBTVQgbWVtb3J5IGhvbGRzIG1ldGFkYXRhIGZv
ciBhbGwgcG9zc2libGUgVERYIHByb3RlY3RlZCBtZW1vcnkuIEVhY2gNCj4gPiBwaHlzaWNhbCBh
ZGRyZXNzIHJhbmdlIGlzIGNvdmVyZWQgYnkgUEFNVCBlbnRyaWVzIGF0IHRocmVlIGxldmVscyAo
MUdCLA0KPiA+IDJNQiwgNEtCKS4gV2l0aCBEeW5hbWljIFBBTVQsIHRoZSA0S0IgcmFuZ2Ugb2Yg
UEFNVCBpcyBhbGxvY2F0ZWQgb24NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXmxldmVsID8N
Cj4gPiBkZW1hbmQuIFRoZSBrZXJuZWwgc3VwcGxpZXMgdGhlIFREWCBtb2R1bGUgd2l0aCBwYWdl
IHBhaXJzIHRvIHN0b3JlIHRoZQ0KPiA+IDRLQiBlbnRyaWVzLCB3aGljaCBjb3ZlciAyTUIgb2Yg
aG9zdCBwaHlzaWNhbCBtZW1vcnkuIFRoZSBrZXJuZWwgbXVzdA0KPiA0S0ItbGV2ZWwgZW50cmll
cyA/DQoNClN1cmUuDQoNCj4gDQo+ID4gcHJvdmlkZSB0aGlzIHBhZ2UgcGFpciBiZWZvcmUgdXNp
bmcgcGFnZXMgZnJvbSB0aGUgcmFuZ2UgZm9yIFREWC4gSWYgdGhpcw0KPiA+IGlzIG5vdCBkb25l
LCBTRUFNQ0FMTHMgdGhhdCBnaXZlIHRoZSBwYWdlcyB0byBiZSBwcm90ZWN0ZWQgYnkgdGhlIFRE
WCBtb2R1bGUNCj4gTml0OiA+IDc1IGNoYXJzIHBlciBsaW5lLg0KDQpPaCB5ZWEsIG11c3QgaGF2
ZSBiZWVuIGEgbGF0ZSBjaGFuZ2UuDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBZYW4gWmhhbyA8eWFu
Lnkuemhhb0BpbnRlbC5jb20+DQoNCg==
