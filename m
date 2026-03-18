Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E06291C10;
	Wed, 18 Mar 2026 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869914; cv=fail; b=ph3cGoyng6VCY9lTarwaK48ZtjG0kzLsOfcYtMw1yrTmRd4VZwdJTSswVdUR3XKXO4oOrOX6X9GhjaCnjRH88QO5RM2kWQoiToLvuLny35TjEd2qLuU35V7LgKPUcPZZ0qrGFIb19saWPwBzFi2HDTl48PXMO7NKzDd7ryZZinc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869914; c=relaxed/simple;
	bh=v6QftoU9+yWBF63/KmxCN1KhTwVyl5Vk9VivGcgwkTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=psJjuZAQDGejrCLRrqt0fqY3gFUTn6n4UjtZnqwGMYu2OQbmNpNncFKbTX1hVugJmMxdL1XnGuMv12uKyxZL7y67vvJ9sB+qvzNuxmAgorjEXFU4EgxPylojdcaBQBQBDEjDPBnXxQcZicU5snuviyg2j3Vixg/vuGQnKjm2rXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JErHPBix; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JErHPBix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773869913; x=1805405913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v6QftoU9+yWBF63/KmxCN1KhTwVyl5Vk9VivGcgwkTU=;
  b=JErHPBixd9JYfVoKpkd79bCfc+01aa/ziNK6pK5A9XGJHkjFL7OyNR+I
   SepYTwNZKwhtDnMjkPkbpZkHhmbriE0WItbU1ISg1IdJyKLr09WoU/2th
   XtVt3NHPxhAwNdLlfH9X+HX0l1qbZ3F2bke8ZM+ts35BMKNuxm6whIeRg
   +EHk4OJ2UYjQ3ALqrRh131opF0NDEBcSIez6W3m+hcjuRHDCxfb7cQk1e
   iGW7pkog3/FtCdPBVY4X/EN3qe0jxZLS+IfONQ0sa2tWRZGPibYHOjvVM
   6PGKqVLPMuzGxUIUhrA9LzlhwCXdpxWzMU5vxgZv/SZhK1tKEQsqDmmsF
   Q==;
X-CSE-ConnectionGUID: wM46CYxwS6eVkYBjs948Cg==
X-CSE-MsgGUID: U0stze1OQRetQ1NYV8k6rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="100396003"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="100396003"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:38:32 -0700
X-CSE-ConnectionGUID: SU4J7BtSS4m6gNG41/SP0A==
X-CSE-MsgGUID: 9fnRzETXRZmmS3bTzA814A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="260654169"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:38:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 14:38:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 14:38:31 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 14:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYVtlAHrkfdTng6OH2n9WdI4oi4NNj2WTXN8/3udQDv2f70i1w3VDYcbwuOgZ0vuIB2I6rE5ximw7iKJDmmLDZil/wvNKEiSVhbxr3SN7Fh7W6dOwI1aiqdz7uGsWyNSUq8C7ensE4HHRZbqshO7JcpvJKry5Z9E6r86Ol7NbAhiauq3nmFQVsK+TkwuzMSjSLmwTaQGcKqAN0Y/vSNcsMzW+1gPQd4U9oOmiQe2Nrehssn8FZqOwr4ulJdM60XVv5tEBW1SK6WKWRa9Q7Ezn08x7kuTmnDVMuREHizXEXxm1k+NlmiwXSOOIfnGi+ZUNZQBBzWeIgsXVE2def/oWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6QftoU9+yWBF63/KmxCN1KhTwVyl5Vk9VivGcgwkTU=;
 b=gQ7D7PnkCGlCd2QwzGZ4fazPKiEfxknrdn6rXsshMa5iQR/sL+k9ABpmvB7fzyh+QE6OLX6jKBURaLC5+1587R10kib4p6S06LK1Xrqzh55/FTMTkn3tzE+w4DVO+1rN09bQFdRaUX41fWV2Nx90CQQIpMPnyC8g0m9Uhgmw3CkRW4oN3fU9x5SkfHZIDQdIAu6+FC10ViNUN1CI9JDWj3F5cTlFB7Zt8njhCHsywNyCy8UOv0IZeKnB4+OWF6FWiwrJXHVN35GHqkoITZr0XEa28aBD2R1W+eUp3nywl3lDj/YrkipWozNA8I4tzhAB3lkJ4ZM9CTVcSXDdmffz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DM4PR11MB8201.namprd11.prod.outlook.com (2603:10b6:8:18a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Wed, 18 Mar 2026 21:38:24 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 21:38:24 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v5 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
Thread-Topic: [PATCH v5 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
Thread-Index: AQHctIP7yEqEEF+ZRkaRCzUops4cbbW01gsA
Date: Wed, 18 Mar 2026 21:38:23 +0000
Message-ID: <1c1f3c66827b10e94cdfd75d2ba44c02cc74b6fd.camel@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
	 <20260315135920.354657-5-chao.gao@intel.com>
In-Reply-To: <20260315135920.354657-5-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DM4PR11MB8201:EE_
x-ms-office365-filtering-correlation-id: 1d5eddc2-9e29-4f65-8594-08de8536aecb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: XSY7lgB3wbT8Ki2QJRGdlsq5Xpzi4FgoB5x2w+XUIbozuOeHp2x+3y4+v7bPxcaz8NcJav4Dsgmfzdv2tLmQXpKuoxbslqmrn73PZFw+3agQDncTqGFAMump5o4njxjolXKaV+60iB+EwHew7QJ9puNFnCM5BMGGwQ3H2ogQuSze3LQT5IicaOZgY6Fng8rc23X9ekGwzr5Dfj/lKoYlStyFoJYWcK7MOrm0SAA7XE9qQYCX2EulAx7t8JlYf2A1sdS1vM+x5DSgjy69We0R0mc23wB2OrIv3bfGiSMVRWF9pnGzAMeHO4ZfH4V8hBkXXfz8FNqym1seTV0+KAOhcCFN5GYnNKObnWk7Zjai+CN8HhKRzPT8cLRfkCoLaSMyU5S6Q70eZyeCK3qfOHSfjr9dno7tUe6xhKI6is98Q98Sm6Y67iT0X0egPeq3h5RDaVYLc3vBSsuGqFbq8k++0LS674sE0GpJuYTwHl6WwN0uxAZXuEJupLpUjbISfuQ04nIga0J/VRyLvmoqesW0aGv4HKXkaHMcrqoQL2dRJzi6eqCNe1fOICpmALCfxP2XkHucZsRYWtELkERvjdxMDP6NNLgwTVg+hvsfxBYeJhJjZsPG8y/O4fRJqNsgf3MXfBYc8UpZvgWku/t/4r7g8AozvSwGLfohJBqDQ0zvArgUs6sOkoPJ8/Ms/n0Ay8hGQD9BMoz5N0AG0F3YCPYFbeUBwyUPMiQFyG3AT3o//QE4v6qS43LIMUMg75n3gcoA41OKRf7WcZ0AHFDzbFr/h9r1VN6vfdq576arK1Ain+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzVFLzZ5MnV5citxWVVobjVvVXl2T3pJSC9PMEg4YmIvTHhSckNpRjBKN0Jj?=
 =?utf-8?B?Zi9rTmMzSk1ZR2ZLSjVYUUhELzJla3YyejFYOWsrU3hEVStOTDVraEtlbGZD?=
 =?utf-8?B?QnBaQWJDL1JLRGxnaytyTVN3cVdmM0M2V1d1cXhHcll3aGFidzhtNE9mVGJr?=
 =?utf-8?B?OWttOXFPZ21KdXBNV2xWRjlGK2tRYXR0NnExOVdqWmxrS210UW1Jc1lvL1hI?=
 =?utf-8?B?M3FBM2xNekVxVEhsMUlPNTVQVGR2WDRRRURKS2R5TnUveVZ3aDBwL2pwTXJl?=
 =?utf-8?B?cGlQbzZudDcvSi9IbWRtRnE2bElCbHczU1V1TUt0ZFFVTGs4aGtubDhvTEx1?=
 =?utf-8?B?TkpiN2tFYmtiT0lieERqbHloOUhtSVdwMWl1bklyMm04amZoeUtEYzF1MjV5?=
 =?utf-8?B?eDhTOUFqMjUrbkpzTUp1UUJrcTNXS1h0ZXdqRW5icXhmeTN1ZjJBYk1CZEow?=
 =?utf-8?B?S0FRNFdYZ0I3bTh1MTVFaml1WmJqZWRhMFhFZWJMRllocWVhZjVaTnRqL0FN?=
 =?utf-8?B?Rkh3Nk9LazZYbnFmZ3FYbDdxMmllSC9sM0QrQkVoVTh4TkszNmpSeVIvWmha?=
 =?utf-8?B?cUo3S2M5TDQ1Z0NNTkhXN1hFVkdtclQ1NnVPbXBwOXJIRXo4Z0RtK0hndThF?=
 =?utf-8?B?RFlyWVBVUDgxTlUzNFdoL3NXRmMyNjN5dDQwZnVyQnZ1R2FBVW83RmY1ZVoy?=
 =?utf-8?B?WGJESkh4ajJmQ1J2QmcwVGpDNHlwUDBnOVhJMC8xNnc1L0dmN2JubE80ZnY1?=
 =?utf-8?B?VUZ0eFYxTGdsWnRXNHg3TEZKZDc5K3ZCUUJDeVUvOStKWFpxV1loTjg4WEJn?=
 =?utf-8?B?MFdmSHpOa3NYVG9PSGYvNElzbmw3NU1Zc2Q0cnBDVVlKL0F5cWpiR1M1TVlB?=
 =?utf-8?B?ZlBJT0ZDWjVVcytaeG9MNStTWkROeU1tY3RIb1pNU2ZQV1pQWUs3UHJoaVY3?=
 =?utf-8?B?ZHd4elhqQSsyTUhpQUgxOGxIWG8zNXc4anhadDdhbnk4c21Cb2hxN1R4TENz?=
 =?utf-8?B?bk9iYTZzYmhkZHgxMTRkeldMYlBONkRXUEpqRDdmVlk3NWVIZ0JRU3Q4a3NT?=
 =?utf-8?B?Z0NCZDFNRDRsZkY2TmMrR3p6elovSVBEeHluVjY5NUgxSDIrQmtNeGhxK0ZV?=
 =?utf-8?B?RUVpQXR4dzk3VUxNakNTanhDa0YvQ096RGFxUGU4Tnp1QXpkclVZR0RSdWVW?=
 =?utf-8?B?djdERGREajB4anhoWVBzN3A4YmM5UE9xMlVBVHRKY0tVR2NodEtVNWpRcFZ5?=
 =?utf-8?B?dXlEQVBtc1ZwYzBFTHM2VEpDNG9kVlhKUmpQczlReTdrelZuaVZtOGZ6ZzBi?=
 =?utf-8?B?TUkzc2M0R1Q0QnFEUWxWSHBTa3JwNURuNmJZWmZNWURHbzFEK1pjdnR0cTRC?=
 =?utf-8?B?WVdJaWNhSHVDMXFPTStOc2Vqc0MzaEduaE9VbTlEc2svWnhBTEZydDJCRDBC?=
 =?utf-8?B?MmZWNHNVZGhYR0lvMVNVNHNFL29pWEJrSVlPeCtHUnBpdDF1ZXVTZm5ORzVD?=
 =?utf-8?B?clcxNkNEOVN4OWJGSkhPM0Qza08zTXNLUmp0VFljNllvdnhyMXZFc01PTmNF?=
 =?utf-8?B?OWcrQTVPMlBtSTZsNlBUZWtuVGtGWXRFV2dvQm1sL2NhcnJUVFdxcGFsL0xm?=
 =?utf-8?B?NEpiWWE1YzBMa1RUMElURjNuMUJ1aHRIeklvOVptaWR6QUs4VktKMGEzTno5?=
 =?utf-8?B?TWlBNkFMbUNBeU1aS2hELy9hOExxUnhRRE9GTzJjSnUrZTgzc1p6dWIzZlVa?=
 =?utf-8?B?aGx6b3oxYXJ4dW1kdzlnaDZoZk9uWTQzSFA4ZlNqZDlKeWdXL2hrY1pLZUVG?=
 =?utf-8?B?WnNiajRaWXZLZTlQaUR4TjU1NEpxNUpTY2FNSVhjcFI5Tmx0Um9zWktOWkNS?=
 =?utf-8?B?bGFsc1hqK2luQUZkMHdxY1RaWDRMQjFGNitaajVYa3FZVTJmbXVWTFdJblNx?=
 =?utf-8?B?NGVoQzBSUjA1c3Q5TFZwbFZyZWpjQjBGY1NobGd1WVNneU8yOUFDOVRXakhP?=
 =?utf-8?B?bXUrMk83d1B3ZDl4S0hudGFqZHBzU0tMcHRwUVp3TWxpdTdwdVpwOWg4OEQ1?=
 =?utf-8?B?eUF3bStaLzVMZDAxeGIxR1kzdmhVeGNqVXI5VCtlT1BRYlRMY1NrRkNncmI5?=
 =?utf-8?B?OVBHRnlCeGMwaWhSdWdqRUdmVUdWQXlzZk85WE5QcGlUby9paTIyNUtzejVF?=
 =?utf-8?B?Z1NxeTZlaHYwajdGNndQY2V5S2RKYTBTTm5tNkp2M3U3Tk5hWkhKMngwS1hN?=
 =?utf-8?B?SEJSajVDUm8xVmpBcU1QOU9PakFuTS83RmZvQVBpc0hZUk5ZaW5rY1lvOFZ0?=
 =?utf-8?B?dlplSDZaeUhXRkhNWnBOeXo3bmxvQkZyZGZ3Y2NLa01KSEtWVUt2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1F7E48CA3B4C940BEC478B285890A21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nHDYnvoeRO+hjdjm5dTp2RwaNMXxkF8gTFlcVYm8YkrbYcQZV6oKmk93WSM5plwGhx3zBoVQzKHmcad0QVInQW1JZjTKTAJwAQRcaRnCPT6VRmBGq1x/sJIxv8cdJLcg/YxTZOrK6CpuzC+0Q2F/UuYTuXEs9B+zzb+mXiXnRawYjEO1Ni1OxInRhoR47rfleqV4FjEw8YhyRMxe/0m48b3LIA/RVPTqzhd/pp1likSkLsFrniFeg0byc0ruIzDmOQ3fFMfIKBLsBAPQ5O/M4vb7NtHKahpVQWExGHAnBlkNy/fHZd2Af5IHoIkAUPJF8CvvM/IY+0gS/43RlCx9GA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5eddc2-9e29-4f65-8594-08de8536aecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 21:38:24.0055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMuVSxw/UKKC9hLv8UW7c5en4NaPLKKzR0P9rgBDRYB2zNm7cSz66tcnJW+sABiB9bAbQO6z3yVq4xysmClJhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8201
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTAzLTE1IGF0IDA2OjU4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IFREWCBhcmNoaXRlY3R1cmUgdXNlcyB0aGUgIlNFQU1DQUxMIiBpbnN0cnVjdGlvbiB0byBjb21t
dW5pY2F0ZSB3aXRoDQo+IFNFQU0gbW9kZSBzb2Z0d2FyZS4gUmlnaHQgbm93LCB0aGUgb25seSBT
RUFNIG1vZGUgc29mdHdhcmUgdGhhdCB0aGUga2VybmVsDQo+IGNvbW11bmljYXRlcyB3aXRoIGlz
IHRoZSBURFggbW9kdWxlLiBCdXQsIHRoZXJlIGlzIGFjdHVhbGx5IGFub3RoZXINCj4gY29tcG9u
ZW50IHRoYXQgcnVucyBpbiBTRUFNIG1vZGUgYnV0IGl0IGlzIHNlcGFyYXRlIGZyb20gdGhlIFRE
WCBtb2R1bGU6DQo+IHRoZSBwZXJzaXN0ZW50IFNFQU0gbG9hZGVyIG9yICJQLVNFQU1MRFIiLiBS
aWdodCBub3csIHRoZSBvbmx5IGNvbXBvbmVudA0KPiB0aGF0IGNvbW11bmljYXRlcyB3aXRoIGl0
IGlzIHRoZSBCSU9TIHdoaWNoIGxvYWRzIHRoZSBURFggbW9kdWxlIGl0c2VsZiBhdA0KPiBib290
LiBCdXQsIHRvIHN1cHBvcnQgdXBkYXRpbmcgdGhlIFREWCBtb2R1bGUsIHRoZSBrZXJuZWwgbm93
IG5lZWRzIHRvIGJlDQo+IGFibGUgdG8gdGFsayB0byBpdC4NCj4gDQo+IFAtU0VBTUxEUiBTRUFN
Q0FMTHMgZGlmZmVyIGZyb20gVERYIG1vZHVsZSBTRUFNQ0FMTHMgaW4gYXJlYXMgc3VjaCBhcw0K
PiBjb25jdXJyZW5jeSByZXF1aXJlbWVudHMuIEFkZCBhIFAtU0VBTUxEUiB3cmFwcGVyIHRvIGhh
bmRsZSB0aGVzZQ0KPiBkaWZmZXJlbmNlcyBhbmQgcHJlcGFyZSBmb3IgaW1wbGVtZW50aW5nIGNv
bmNyZXRlIGZ1bmN0aW9ucy4NCj4gDQo+IE5vdGUgdGhhdCB1bmxpa2UgUC1TRUFNTERSLCB0aGVy
ZSBpcyBhbHNvIGEgbm9uLXBlcnNpc3RlbnQgU0VBTSBsb2FkZXINCj4gKCJOUC1TRUFNTERSIiku
IFRoaXMgaXMgYW4gYXV0aGVudGljYXRlZCBjb2RlIG1vZHVsZSAoQUNNKSB0aGF0IGlzIG5vdA0K
PiBjYWxsYWJsZSBhdCBydW50aW1lLiBPbmx5IEJJT1MgbGF1bmNoZXMgaXQgdG8gbG9hZCBQLVNF
QU1MRFIgYXQgYm9vdDsNCj4gdGhlIGtlcm5lbCBkb2VzIG5vdCBuZWVkIHRvIGludGVyYWN0IHdp
dGggaXQgZm9yIHJ1bnRpbWUgdXBkYXRlLg0KPiANCj4gRm9yIGRldGFpbHMgb2YgUC1TRUFNTERS
IFNFQU1DQUxMcywgc2VlIEludGVswq4gVHJ1c3QgRG9tYWluIENQVQ0KPiBBcmNoaXRlY3R1cmFs
IEV4dGVuc2lvbnMsIFJldmlzaW9uIDM0Mzc1NC0wMDIsIENoYXB0ZXIgMi4zICJJTlNUUlVDVElP
Tg0KPiBTRVQgUkVGRVJFTkNFIi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYW8gR2FvIDxjaGFv
Lmdhb0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBCaW5iaW4gV3UgPGJpbmJpbi53dUBsaW51
eC5pbnRlbC5jb20+DQo+IFRlc3RlZC1ieTogRmFycmFoIENoZW4gPGZhcnJhaC5jaGVuQGludGVs
LmNvbT4NCj4gTGluazogaHR0cHM6Ly9jZHJkdjIuaW50ZWwuY29tL3YxL2RsL2dldENvbnRlbnQv
NzMzNTgyICMgWzFdDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5j
b20+DQo=
