Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C962F83B7;
	Wed, 25 Mar 2026 04:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774412914; cv=fail; b=rgHxhdFV7UF8mfzJ8oLXuZdFYOhvb/EGvNUDP4jPQsSOStGeXIF3Kil3LiyBAxv04sdgaIdtdcDWnSn8CPb1xpyopL3ga+drig64s02aM8i7RyTOw45uuvN/GH8KrZQqg6D84pPtISaJR7lrSF9cZ79U8q7MaeiBjYrgwLyCj+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774412914; c=relaxed/simple;
	bh=PnoxBQVW3TYoSo7g+g1t31XMOy2LtqL36/qd/zfUdao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=psLidsk+BYlLMJn6wP5XKGq+yAquIGCrhPc/rORMzPX5joS/3tgomvjS9+FEXK7+3aS7wp0sQtZnU7yNqlO8XcXvMUDX8qIFeUEIl148UiswHClWkTT9WOvBH9RoU9p9s56wyW2Isx+xH3mZsVCVY4FswM3Vcy7MLFX8+oLBh4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbwxTBT5; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbwxTBT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774412910; x=1805948910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PnoxBQVW3TYoSo7g+g1t31XMOy2LtqL36/qd/zfUdao=;
  b=PbwxTBT50lGGEjDmOka5iL7A8c0PZP3UIhYGoqu+qCmqKb4IEIxtqsis
   1AWQeUHXuDv0cgbA6voLUnCGYV6570GtswyZSuEEh+sPacon9/O4/++mW
   6dfejq+i2fPfpZ6BYc/C2V5jKgiUdj6bnFlN08OkAz/vyTk9BP1NKlLYM
   Z0FMZWq4RVdrLp6Lvo461xOv90btlQyuYx8x9RpPlMuQAuwKCEWRL1G9L
   ekH+pw2lnbRCSKt8bkcuQl8eWGpe6RuLx46xD4XAvYZJyjtXNKdblyTP6
   711KXw3+veRnbaSUqZwWZc4diuB31kvUXqKSK7J4q7DIrM0lYz4k2/N2T
   w==;
X-CSE-ConnectionGUID: dnsKYECNTxejtVZg8U0vWA==
X-CSE-MsgGUID: rcBHXeUiR9y8+gUf+bS5tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="78042688"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="78042688"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:28:29 -0700
X-CSE-ConnectionGUID: PKkcyPndQRK97rJ5/LZksQ==
X-CSE-MsgGUID: EKmKJLoQS1CX6ylS37+p9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="247595204"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:28:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:28:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 21:28:28 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:28:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrTtE34+MczFtHDV+7UjVrSSp0ycoIgMKJ9cUboYKAsj5+C1Fw1M5g1mqhiXgjw2gyuF25GfCVURPwD+n6gxHUGQwCV1+istIJxdUwNbEYolxFnkHgIfsoVSepG812vR1/cdjSz/jQXO/wYdjsnO3TGzqmW9dxQ85VxS/uvnZbgLlU+iC3wGoHSrswXCirYkwn9cq+E4/37ujUAM2bLI05qrgJIwGq/b5lI9uT/c7nBOp5QcHWFUbMrq60LBLSK9YSAmjtYjqZUs82bv/YRXbiQYR1lMDyqUv3gsA/DDZyZy70s2Dt09Cf/uDE+vkPOOmEq/LhO5OtTLRKdxqzJyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnoxBQVW3TYoSo7g+g1t31XMOy2LtqL36/qd/zfUdao=;
 b=OhIQarqve98T+/GCt6lme/htDOqmzqDvdroTF+K5/Kz5a7Vxwgv6s1ainnbH/HjONbNb1BpAbIiNY4AetqXhAMKPPB2cwSxW9r9UDW+UiJEBiDQ+K3SjB1K4YdE9rpPnC9llGOopLLTHRo4cKetApS+hWfLG0V95wEnReQQW8S4EjrOHwHjO1dMfFzm/ZgkLU1xTHWH2acbrcfItNPsZzxS50TbfF+dsi7YGhLFBmQUyfzYU5J2PkOiD0mtxui8hy/PD0g577h955E0hLnOF2QpsZX3CIo9YDyp/q/ENNB/kfLkAzSU4S5/UQ3aQtYS4po1TCjJZSr9YejWLzkPpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 04:28:20 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 04:28:20 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "amit.shah@amd.com" <amit.shah@amd.com>, "Kohler, Jon" <jon@nutanix.com>,
	"seanjc@google.com" <seanjc@google.com>, "mtosatti@redhat.com"
	<mtosatti@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>
Subject: Re: [PATCH 10/22] KVM: x86/mmu: split XS/XU bits for MBEC
Thread-Topic: [PATCH 10/22] KVM: x86/mmu: split XS/XU bits for MBEC
Thread-Index: AQHcuMdQpQeIubAK1EyaerhA+hcZ2bW9hRGAgAALAQCAAR36gA==
Date: Wed, 25 Mar 2026 04:28:20 +0000
Message-ID: <ac26eeac658af6d9bf87c93cd09c3d0dabbb41f1.camel@intel.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
	 <20260321000931.1947084-11-pbonzini@redhat.com>
	 <dd1fd2a2d5cb83d92d4064b44958e8315a86b68d.camel@intel.com>
	 <fb159f31-4cf2-4d6e-aee3-97ad68200824@redhat.com>
In-Reply-To: <fb159f31-4cf2-4d6e-aee3-97ad68200824@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB6498:EE_
x-ms-office365-filtering-correlation-id: efce1d59-d5b9-4b8b-893e-08de8a26f1b4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: PRASBDxNprO6CNWFZXCPD6o4orDC4rjAOGEuyOA+6DyovfZxR5vxEp2fesdRbTwG45aQsu76PA+4qwx+PUmXA9DVbcVd0lidqSz4hh6lw0Ujbh7f1tHGPRk+6rjmzWqW3M2tiYMoWFn3f7rAbjjyach6yrcJQZbqdw0FlpsS3Nc0y+udECuIogMNbORHsRyUp568NaytfSkiHtm7Ip7duZHF3tfOnIy5E0uiCfly/Ur4EODIIDvnirEERmi4b7EUSsbBXH126kQ8r5NGs+/Qza4sHgdwZpLeWVF7JcLnd3Cch7/ZDmrBDc3THvEZIUcyyoLJgCtyAJXsBS8x7y4lhLDCbFO9fJuZQjnvsUnSpn4lAgtKaJzSxIc31kikIkOfhw+424v+K/tUlzddyZTv0mFLx4ONPJjzMDFPTE/NsPKoxiM4HCJTZa+gW4/cJQ7D2bs2AJeeMiUVTKPCGEf5uXdxkit8awi/IEn1bGrRauIwR0OhEaFxgcr0CpAv5HR8Z/OhoS89sK9J481u7Fmedr0JFWVtt77wHHrh5dDsnnrxoMZr9TaqMcwq51CPhbZQVQFwBjUVif1BVj8W4FlAtL1+ZNDKDQOqmDpWNdcZcjuF+ztgKGl9gGTa3uY1KtP3o2ihWpSUF66riKjOYbomdG+5BxA/+gysDDECapFVQ5tpVOd+l+XP0wFjrRKhJ4tIotID3wn2tGgxOgfNd+kGtxE3wcMvNIAJYWxx5rWkxyZpXg/9MFPBmLTscWCfdP9xkXBZQQ9ZI53/WH6BkZaM3EisTWP3/AMguEAQo2W26XU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVQ1ZXhTT24wdWoxZjd3dGIxUWZSTGdUeEtGTzEySnhCaDBhNFZNUzUwYy9L?=
 =?utf-8?B?T290Z3c1dVNsOUhHZ3RKQkNPTjRzd1Z3K0dHcTg2bnQ4ZTFyVjJpMFZQUWtH?=
 =?utf-8?B?Rkg1aklaOWhYbUhKWkZOR2FUMlIwN0U5aFRRb0Y1aGZQUThoQWY3YVhLVlFX?=
 =?utf-8?B?Z2dOdlpOYXFTdHVPMlVRVjZaVytyTkFqMmY1NjVaVURGZ1JLd0paZGp0UGdU?=
 =?utf-8?B?QVRZd0MwelFidlhwb2ZKaUQvYjUxRUluS09UWjdpZEpyd2xZNndCS0dVenFt?=
 =?utf-8?B?SXNleHRqU0RsLy9WUlVJdUNSL2J5MzRLM1VXQ3J2K1J0ZjZRYUVHUEg2eFhG?=
 =?utf-8?B?NHI0OW5XTCtuTnIxNk1najJvY3FSdEVKeVgwUG81cVovNTIrcGNZMHJOay9V?=
 =?utf-8?B?b2dSWXlsSlF5MW9zUE1IaGYxNTlhYkt6bUdEZzNrL2pnaFNiTXZPazZYQjkx?=
 =?utf-8?B?bkNFd1p0VURPV09lUkc0V1RxVm0ybU5YNzQ1SCtpWXhJQm5zYVU5VGZZWjA5?=
 =?utf-8?B?ZlN4YWFyV0pDYzdvU0ZrOEpiRjBQanVWU3ZVZHRxdzJKRnpCVmhVM2p0Qkt5?=
 =?utf-8?B?MWZwY29BUDlBN3RhTmRvMWlxQ2pvdXNIUEpEanlZWWJ1YjRkYVV0MXN0UVkx?=
 =?utf-8?B?RkVHRVNTWTVCaEUreHdoTjlxSTl5S0dDMTR2MU5jVzlTV2VpY0dWZnpPeUEv?=
 =?utf-8?B?Q1pjbDhPNzd0Zlh0K1ArOGdzWEw3NDFmd3l2RzJacTFzSWk3MXhMVk1WUldp?=
 =?utf-8?B?TXpwWElGSWlzWWJnaEVJZGdTUTgxMXdFU1Eyb2xLQzJueTlYOGR3SUVNZ0w4?=
 =?utf-8?B?T3Nrd2dPb2ZSNXdLZmNTNFhLTTNEVnZjcmh5TXhacWIvVzFFMkZhYWVuMTZi?=
 =?utf-8?B?VG9aN0FoYlpBa0dobXRMTmlaRkVrQ2xqV0czYzFmNjNIWWFYOFlqU0NMdEQ3?=
 =?utf-8?B?bnBMdDRxS2FoSFZzSDZ4WDdjNlpZZE4rMkFYY0R4Rk5Pd0ptNWVubENjQ1pk?=
 =?utf-8?B?UDNrc1VhU3VuL1NzTUl2a29kSGdoVGluNGp4ZFBlRGpGc1BQc3c3enBFQzhI?=
 =?utf-8?B?L3BrU2VZTkM3R1B0N29EUFBnOW4xd1pSOGJ0N0NwS0ZoMFJ3ZGtjTU45bVNa?=
 =?utf-8?B?bk9sazRsYkk3Z1dmdVNMdGNUakVNQWpZOHQzUS9SK2lsbGRxSzlTd3NtUVhh?=
 =?utf-8?B?S0hRK1Vma25CYnEzMEFEcTdYelVkS0piSTMxNWJ6d2FNTkEzRHVqSzliK2p3?=
 =?utf-8?B?b3phWi9xMHpYN2RISk9RQWVMN21qVjJNLzg3UEwxd1N5eFZyNUxwTkMzdDBD?=
 =?utf-8?B?Z1E4bGwxS0hhU0k0Ky9ZYkdDa3ZvRlB1VUwyejNnSnAyVEc2U1M1K1dMM0VM?=
 =?utf-8?B?TGRJQTBuQzRLVG5VdHo0cm5KRlRMVyticllDOVdlU1A0bk1MaldJRGNvUHFv?=
 =?utf-8?B?S1dVM2RoUVRFYkN3dlR3cHFDUHF5WElrT3djSWNFY1VwZ3NxU1h2QzEvNnZD?=
 =?utf-8?B?T2M2NzdGaFVyWUlOUVczSnVIK2dkY1dMaXF6N3RVblhYa2pDUVVyUVV1K0c4?=
 =?utf-8?B?dUw1eVUvTmRDQ3JNV29yOEoySGdoWThtaTJEd00vUXpsOTl4SkhxeWNBNTk1?=
 =?utf-8?B?eGJSRGVUKy9TWnVqbzNLR1lPL1NseXlHVGdqcVpmTk43dVBtbGVFQWdxdFJr?=
 =?utf-8?B?WklSMHVTdEVvbWFSVTllM3V6aVJjamJPbitjNTZ1YkZyYTUwQXM2YkFia3o0?=
 =?utf-8?B?aEFXSldHVml4bXNTNGpRaHdsS3B5eVpyRU43SzBHRWpxNmZZYjRDSnRnZ1V3?=
 =?utf-8?B?TmZVOHIyeGZLVHBERWVSalRnbU13VnNtcjU2RGl2eU5Ia3ZHbzNaSGdVNFNz?=
 =?utf-8?B?UGNFbExxSVNnRkJvdFlmeFN1ditld2FKY29UNW9HcGtDdzZIUlMvNXoyOC9v?=
 =?utf-8?B?Y2hWWnRwSzVoL2JPeStpTm80RTBjbGM2N0RaOWlCcWdjV21zUHhqRFJXY1NR?=
 =?utf-8?B?K002cHRWa2wrcWxTd3AvYi9DR0dMMy9YM0xITTA0d3kycDlLL3FCb3dueG11?=
 =?utf-8?B?c3Biam1pWlRLcy96WEtBZ1l6dFhrMWlNMC9GUWoxWjdQUHNFeWowV1BYcC9C?=
 =?utf-8?B?SXI2ZkZYZkhzMEFkNVJsekI2OVlxcjdPZ0dTYWJWUDNmUUN0MjVrbDYrb3Rn?=
 =?utf-8?B?dThDd2VobUo2NTgzZisvSXcyb2R6OGJGL3kzU29LcXFXZGF3eWpKNFpSS2di?=
 =?utf-8?B?NkJObXdRL3pvT0tXdW1JeW14dlA5d3kwYU81Um90WWVSa09mK2NyZzNPck9p?=
 =?utf-8?B?ZUZzNExCOWxDVm1vMFUycjl2THlxa3RoSlVLOTNxUHpYbVc5aCt1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <740CBB62B9CECE48AA78999E9E4DD649@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AOWUGE4K03JmQTiUmNhxq6G1Vy/akU5o8Mnuj5UV4wp6xriqlFOEkG/L7ZyoSx7qUwVJ6gCtk/1u0+jwAFha5SvIU0v1G5Q0FTJPQh8EuBz6q3NCXOfEzeL4UxgNQKYXY3wLpuiNbI/9CWjS+ipy82/DIznIcrev7l5hB/woVpSKwMi7pIlUz/0ES/j97X5fcBTvu3Prigy1UQIaw5RXeH5RHqFgsy+JLvTOFErEv82zileDzFDkQ+sGnE2caktl+tTeS3GYjqkMfNUFVxyXrBF8Ad/uxfUqizQ5gTWoZRpK61QL6cfkdeGbkSwbT0wwMBDdWu4N7jEqUgN5nkKkbA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efce1d59-d5b9-4b8b-893e-08de8a26f1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 04:28:20.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Zq0le7GbVFhoP3VCf13yHJSTtr50mcw+086BjlY98Wjw0cFTs3Vld0TKex8zpHqrPvcxMqja4frElsmNcPOIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6498
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTI0IGF0IDEyOjI0ICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBPbiAzLzI0LzI2IDExOjQ1LCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIFNhdCwgMjAyNi0w
My0yMSBhdCAwMTowOSArMDEwMCwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gPiA+IFdoZW4gRVBU
IGlzIGluIHVzZSwgcmVwbGFjZSBBQ0NfVVNFUl9NQVNLIHdpdGggQUNDX1VTRVJfRVhFQ19NQVNL
LA0KPiA+ID4gc28gdGhhdCBzdXBlcnZpc29yIGFuZCB1c2VyLW1vZGUgZXhlY3V0aW9uIGNhbiBi
ZSBjb250cm9sbGVkDQo+ID4gPiBpbmRlcGVuZGVudGx5IChBQ0NfVVNFUl9NQVNLIHdvdWxkIG5v
dCBhbGxvdyBhIHNldHRpbmcgc2ltaWxhciB0bw0KPiA+ID4gWFU9MCBYUz0xIFc9MSBSPTEpLg0K
PiA+ID4gDQo+ID4gPiBSZXBsYWNlIHNoYWRvd194X21hc2sgd2l0aCBzaGFkb3dfeHNfbWFzay9z
aGFkb3dfeHVfbWFzaywgdG8gYWxsb3cNCj4gPiA+IHNldHRpbmcgWFMgYW5kIFhVIGJpdHMgc2Vw
YXJhdGVseSBpbiBFUFQgZW50cmllcy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUGFv
bG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBhcmNo
L3g4Ni9pbmNsdWRlL2FzbS92bXguaCAgICAgfCAgMSArDQo+ID4gPiAgIGFyY2gveDg2L2t2bS9t
bXUvbW11LmMgICAgICAgICB8IDE1ICsrKysrKysrLS0tDQo+ID4gPiAgIGFyY2gveDg2L2t2bS9t
bXUvbW11dHJhY2UuaCAgICB8ICA2ICsrLS0tDQo+ID4gPiAgIGFyY2gveDg2L2t2bS9tbXUvcGFn
aW5nX3RtcGwuaCB8ICA0ICsrKw0KPiA+ID4gICBhcmNoL3g4Ni9rdm0vbW11L3NwdGUuYyAgICAg
ICAgfCA0NyArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gPiAgIGFyY2gv
eDg2L2t2bS9tbXUvc3B0ZS5oICAgICAgICB8ICA4ICsrKy0tLQ0KPiA+ID4gICA2IGZpbGVzIGNo
YW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdm14LmggYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS92bXguaA0KPiA+ID4gaW5kZXggNGEwODA0Y2M3YzgyLi4wMDQxZjhhNzc0NDcgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92bXguaA0KPiA+ID4gKysrIGIvYXJj
aC94ODYvaW5jbHVkZS9hc20vdm14LmgNCj4gPiA+IEBAIC01MzgsNiArNTM4LDcgQEAgZW51bSB2
bWNzX2ZpZWxkIHsNCj4gPiA+ICAgI2RlZmluZSBWTVhfRVBUX0lQQVRfQklUICAgIAkJCSgxdWxs
IDw8IDYpDQo+ID4gPiAgICNkZWZpbmUgVk1YX0VQVF9BQ0NFU1NfQklUCQkJKDF1bGwgPDwgOCkN
Cj4gPiA+ICAgI2RlZmluZSBWTVhfRVBUX0RJUlRZX0JJVAkJCSgxdWxsIDw8IDkpDQo+ID4gPiAr
I2RlZmluZSBWTVhfRVBUX1VTRVJfRVhFQ1VUQUJMRV9NQVNLCQkoMXVsbCA8PCAxMCkNCj4gPiA+
ICAgI2RlZmluZSBWTVhfRVBUX1NVUFBSRVNTX1ZFX0JJVAkJCSgxdWxsIDw8IDYzKQ0KPiA+ID4g
ICAjZGVmaW5lIFZNWF9FUFRfUldYX01BU0sgICAgICAgICAgICAgICAgICAgICAgICAoVk1YX0VQ
VF9SRUFEQUJMRV9NQVNLIHwgICAgICAgXA0KPiA+ID4gICAJCQkJCQkgVk1YX0VQVF9XUklUQUJM
RV9NQVNLIHwgICAgICAgXA0KPiA+IA0KPiA+IFNob3VsZCB3ZSBpbmNsdWRlIFZNWF9FUFRfVVNF
Ul9FWEVDVVRBQkxFX01BU0sgdG8gVk1YX0VQVF9SV1hfTUFTSz8NCj4gDQo+IE5vLCBiZWNhdXNl
IGl0IGlzIHVzZWQgZm9yIG1hbnkgY2FzZXMgdG8gcmVmZXIgdG8gYml0cyAwLTIsIGZvciBleGFt
cGxlOg0KPiANCj4gICAjZGVmaW5lIEVQVF9WSU9MQVRJT05fUldYX1RPX1BST1QoX19lcHRlKQ0K
PiAgICAgICgoKF9fZXB0ZSkgJiBWTVhfRVBUX1JXWF9NQVNLKSA8PCAzKQ0KPiANCj4gQml0IDEw
IGlzIGhhbmRsZWQgc2VwYXJhdGVseSBiZWNhdXNlIGl0J3Mgbm90IGNvbnRpZ3VvdXMgYW5kIGhh
cyBhIA0KPiBkaWZmZXJlbnQgbWFwcGluZyB0byB0aGUgZXhpdCBxdWFsaWZpY2F0aW9uICh0byBi
aXQgNiBpbnN0ZWFkIG9mIGJpdCAxMykuDQoNCk9LLiAgSXQncyBhIGJpdCB1bmZvcnR1bmF0ZSBi
dXQgd2UgY2FuIGFsd2F5cyBleHBsaWNpdGx5IGdldA0KRVBUX1ZJT0xBVElPTl9QUk9UX1VTRVJf
RVhFQyBmcm9tIHRoZSBWTVhfRVBUX1VTRVJfRVhFQ1VUQUJMRV9NQVNLLg0KDQo+IA0KPiAoSG93
ZXZlciwgdGhlcmUgaXMgYSBidWcgbGF0ZXIgaW4gdGhlIHNlcmllcyB3aGVyZSBzaGFkb3dfYWNj
X3RyYWNrX21hc2sgDQo+IG5lZWRzIHRvIGhhdmUgVk1YX0VQVF9VU0VSX0VYRUNVVEFCTEVfTUFT
SyBpbiBpdCkuDQoNClJpZ2h0IHdlIG5lZWQgdG8gdHJhY2sgdGhlIFhVIGJpdCB0b28uDQoNCj4g
DQo+ID4gDQo+ID4gWy4uLl0NCj4gPiANCj4gPiA+IEBAIC00OTYsNyArNTA3LDggQEAgdm9pZCBr
dm1fbW11X3NldF9lcHRfbWFza3MoYm9vbCBoYXNfYWRfYml0cykNCj4gPiA+ICAgCXNoYWRvd19h
Y2Nlc3NlZF9tYXNrCT0gVk1YX0VQVF9BQ0NFU1NfQklUOw0KPiA+ID4gICAJc2hhZG93X2RpcnR5
X21hc2sJPSBWTVhfRVBUX0RJUlRZX0JJVDsNCj4gPiA+ICAgCXNoYWRvd19ueF9tYXNrCQk9IDB1
bGw7DQo+ID4gPiAtCXNoYWRvd194X21hc2sJCT0gVk1YX0VQVF9FWEVDVVRBQkxFX01BU0s7DQo+
ID4gPiArCXNoYWRvd194c19tYXNrCQk9IFZNWF9FUFRfRVhFQ1VUQUJMRV9NQVNLOw0KPiA+ID4g
KwlzaGFkb3dfeHVfbWFzawkJPSBWTVhfRVBUX0VYRUNVVEFCTEVfTUFTSzsNCj4gPiANCj4gPiBT
aG91bGRuJ3QgJ3NoYWRvd194dV9tYXNrJyBiZSBWTVhfRVBUX1VTRVJfRVhFQ1VUQUJMRV9NQVNL
Pw0KPiANCj4gTm90IHlldCwgYmVjYXVzZSBzaGFkb3dfeHVfbWFzayBpcyB1c2VkIHRvIHNldCBl
eGVjdXRhYmxlIHBlcm1pc3Npb25zIGFzIA0KPiB3ZWxsLiAgSSBzdXBwb3NlIHlvdSBjb3VsZCBt
YWtlIGl0IDAgd2hlbiBNQkVDIGlzIGRpc2FibGVkIGluc3RlYWQgb2YgDQo+IFZNWF9FUFRfRVhF
Q1VUQUJMRV9NQVNLLCBidXQgaXQgY2FuIG9ubHkgYmUgVk1YX0VQVF9VU0VSX0VYRUNVVEFCTEVf
TUFTSyANCj4gd2hlbiBNQkVDIGlzIGVuYWJsZWQuDQoNCkkgc2VlLiAgSXQncyBjaGFuZ2VkIHRv
IHRoZSByaWdodCB2YWx1ZSBpbiBhIGxhdGVyIHBhdGNoIHdoaWNoIGFjdHVhbGx5DQp0dXJucyBv
biBNQkVDLg0KDQo+IA0KPiA+IA0KPiA+IA0KPiA+IEJ0dywgd2l0aCBNQkVDIGl0J3MgYSBiaXQg
d2VpcmQgdG8gbWUgdGhhdCB3ZSBjb250aW51ZSB0byBqdXN0IHVzZQ0KPiA+IDExMCAoUj0wLFc9
MSxYPTEpIHRvIHRyaWdnZXIgRVBUIG1pc2NvbmZpZyBmb3IgTU1JTyBjYWNoaW5nOg0KPiA+IA0K
PiA+ICAgICAgLyoNCj4gPiAgICAgICAqIEVQVCBNaXNjb25maWd1cmF0aW9ucyBhcmUgZ2VuZXJh
dGVkIGlmIHRoZSB2YWx1ZSBvZiBiaXRzIDI6MA0KPiA+ICAgICAgICogb2YgYW4gRVBUIHBhZ2lu
Zy1zdHJ1Y3R1cmUgZW50cnkgaXMgMTEwYiAod3JpdGUvZXhlY3V0ZSkuDQo+ID4gICAgICAgKi8N
Cj4gPiAgICAgIGt2bV9tbXVfc2V0X21taW9fc3B0ZV9tYXNrKFZNWF9FUFRfTUlTQ09ORklHX1dY
X1ZBTFVFLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVk1YX0VQVF9SV1hf
TUFTSyB8IFZNWF9FUFRfU1VQUFJFU1NfVkVfQklULA0KPiA+IAkJCSAgICAgICAwKTsNCj4gPiAN
Cj4gPiBQZXIgU0RNLCBSPTAgYW5kIFc9MSBpcyBhbHdheXMgZ3VhcmFudGVlZCB0byB0cmlnZ2Vy
IEVQVCBtaXNjb25maWcgKHNlZQ0KPiA+ICDCoDMwLjMuMy4xIEVQVCBNaXNjb25maWd1cmF0aW9u
cykuICBNYXliZSB3ZSBjYW4ganVzdCB1c2UgdGhhdCBmb3IgTU1JTw0KPiA+IGNhY2hpbmc/DQo+
ID4gDQo+ID4gV2UgY2FuIHRoZW4gcmVtb3ZlIGJvdGggWCBhbmQgWFUgYml0IGZyb20gbW1pb19t
YXNrIHRvby4NCj4gDQo+IE1heWJlIGJ1dCBpcyBpdCB3b3J0aCBpdD8gIChCYXNlZCBvbiB0aGlz
IHdlIGNvdWxkIGtlZXAgYml0IDEwIGluIA0KPiBNTUlPX1NQVEVfR0VOX0xPV19FTkQsIGFmdGVy
IGFsbCwgYmVjYXVzZSBXPTEgUj0wIHdvdWxkIGdpdmUgYSANCj4gbWlzY29uZmlndXJhdGlvbiBp
bmRlcGVuZGVudCBvZiB0aGUgdmFsdWUgb2YgWFU7IGJ1dCBhZ2FpbiBJJ20gbm90IHN1cmUgDQo+
IGl0J3Mgd29ydGggaXQpLg0KDQpJdCBsb29rcyBwcm9taXNpbmcgdG8gbWUgc2luY2Ugd2UgY2Fu
IGhhdmUgYSBzbGlnaHRseSBjbGVhcmVyIGNvZGUgKElNSE8pDQphbmQgb25lIG1vcmUgYml0IGZv
ciBNTUlPIGdlbi4gIEJ1dCBubyBzdHJvbmcgb3BpbmlvbiA6LSkNCg==
