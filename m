Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F73A960A
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845681; cv=fail; b=KCWi79M2srxOIbK6OU+3Cx7Y4nD6oOpqEs+2CDExAxdKwDYF38SVlDcpG9pq/KF9CITcGI3F8eVX959hJZAprsDyUClbjCf6MfPtEaCFsNvGZTMFaXxwYPUdViucDqLWB8FvNY1lO/2D8udtQasrkevaEiE2o6z8MRCctiJ8rw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845681; c=relaxed/simple;
	bh=kByob2pLT4orcTn+eydzc4b/mYleIokWowKdEC5+QJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NF2OAfT6vhhc0XGYIIyszwgQrtIm1Izn21nntn0Zz2TxggoTxQigSpurmAfXwr35dd3u7bzRERnXgTrV+jc6jTMB0lXWd/AJGyZofJzjwbZ1F7OCCyW9g1q+AjSIAJPp/BkGMnxSgqU4l/tlnBGyKt2zUQ3982jo++OJqSpcsV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAvYqIj2; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAvYqIj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776845678; x=1808381678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kByob2pLT4orcTn+eydzc4b/mYleIokWowKdEC5+QJ4=;
  b=EAvYqIj2g+Bw9g2PUkmRG6sOYwC8VfNLDojlbtbiPrx3GHdl25OJyppX
   3oiFBQ1GAD7tcfrfiGyPssk/WdWupr2bqYsF3GV/op+Yo+HmkCDnrcRUf
   ncBKhy0cH4KdgGt+3mS3Z30myeF1KVPY3Jxc5rqVqFfQkkybCa7j8VqVD
   krs37EtJ1rdy1F3AqdETlpsik9s7QF349K+npkINq+6IlD4bKGN+aLWjH
   F1nGD2ci8Z/U1DsX7xkEHy4Kzno6VU3w7dUoBCGWefhyYp8ILnMtF96y5
   hHfMNzcwjoaASgvxDkR2RlnjxLzFVHYL+ORxudAAiBSu02hTmIknG4IOs
   w==;
X-CSE-ConnectionGUID: xa+/JaVASTKtvPiS2fL0mA==
X-CSE-MsgGUID: xt1r7cKRRnyY1rGgFULPRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77706743"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77706743"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:14:37 -0700
X-CSE-ConnectionGUID: NotduThpTU2+M+Dy+ZYIWA==
X-CSE-MsgGUID: +P6FNB7NT5eJNzB84iHJTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="234075473"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:14:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 01:14:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 01:14:35 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 01:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkIUY9BUncF6vtYQTOpPfePWyG32hYJz+Zz3Cqp4ABow6PktD6V9TR0NYoVoYtwmW2IGlJ0JpsoeZip9U22vOOF1vs1Pjen/KKRHWYwdc0XFQUQIKk219oES5EKiPa+VdHmIgEh4Imz74/STWEL8q7lVmX4XPP/0AMY0S/ZokZc28AYYXuSyNr5E3WJTyNebQqKGmjKIHAI6/q5nwyUxkN514XyBWTAYer09yQFSMj+Zox+fZ+HqK9CdyszS3ixKt1PJYhLFnU8uJcJi4oL/aaHC6jeM3ywnxFWPITLDu6shwFDvevZszION92A0mcfwN9HseCAKw9Xe/CbjtbG0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kByob2pLT4orcTn+eydzc4b/mYleIokWowKdEC5+QJ4=;
 b=F2E9ub5ZyPT1NBZUUMBWyGgn4CC8sIZaGbdyAwAlwXzH07LYIu1Ol8nvUdfsLq4N9ynetjf4/Bua32rf+m45reB9qTHUPCYMKWD1G62QKkcSAAPWoOUHNbRR/gOzfFfUWIXn1hPffAhRbw9uGky1ZWsuRkKTyWoEwybpyCsM02BVbpWHQN/NkS6H+8w0ieO8XHWrkP6c2Q8oPHuCi7IUtZn3yIMATMcOUVy95efLRVBwfxDhKSGKsEix9qUJEeLf+aE3n2azJSK8UPMoWCL9Yd87CCcLtGfQ8y7i2WyX3oLbEnvJLKmiEWuFHVMIBz4IlK4tZ9yovNzgyWpVNaCeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.19; Wed, 22 Apr 2026 08:14:31 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 08:14:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "nikunj@amd.com" <nikunj@amd.com>
CC: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Thread-Topic: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Thread-Index: AQHcxliL7ApYp79orUu4JhjyJLC0JLXnk/4AgAIguwCAAJHqgIAACw0AgAAURYCAAEe7gIAAJbGA
Date: Wed, 22 Apr 2026 08:14:29 +0000
Message-ID: <1060a161d24121362ae7d7c4b278798296255909.camel@intel.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
	 <20260407063245.2755579-8-nikunj@amd.com>
	 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com>
	 <aeeS7LDPJ6NCy3Uw@google.com>
	 <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
	 <aegWmKk8uK5r10dM@google.com>
	 <977e805339a29ab789650aa18cd320dd1e9e0c25.camel@intel.com>
	 <889e2e42-38b5-40c2-8ed7-f13346901fef@amd.com>
In-Reply-To: <889e2e42-38b5-40c2-8ed7-f13346901fef@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA1PR11MB7853:EE_
x-ms-office365-filtering-correlation-id: 98cca407-37a9-4ea5-c64a-08dea0472d53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: BDRZWCBmO8SwHKWbQSPpB9mIeuT62Fcy4rTLrhdRogIrWAZWxg7Lax2tNmZbC4u34JUZJz3cFDRBm1xn3miFPZOGN/ywXqa1w0vu1uoY070J3aFF2jlLqa9NKR54gAkf4J2Bh+xM4/MgVgkmtSP1+zSB05JT8GbHiJ96i9GrVkZn/i5Mtw2rHhg8gh/239ga7nBPzXMA0VahoEiKsFpB/dlvQveU4QH1IaJ3MnnqfZXBIWPzeUZhYKIBtPx6Qt8jNIGf8ayuqmJmc9vChGEpxSMpJeEUVb6amMe4Cfh4PJnKsDfGE0UEdYrGAxSPlg560K7mSFEmZsOLRKjQrpSM0ASRNtjZi1emAwero5URFEmwFZf4Ib4Y/OHDGo/tMGDHa9962sqlDrKKh6E5cKK51HVf3rYyc6HV4xOShJYGyMb32Qsmir1I0R7FXUq6NJBoXIEwsyFlIrqpDy4IAaBq2J1A4bRSi/IWVelpbfDTRkpHpFoswCbXn6Wuhz9dLwDKmjC7EUx8LIvj63bdTB6ZzhvYxtnVz0QCdCZSsxfEANISDRYIW/FINE5ewb3bZI6uvjxbFo4Fe5xl13fSogwPhDjHv6PR8+NPczH/C+bJXhZHjqyaSWQ7zC0lg2GJeg4yXvGMgpLUKB9f6gnUdt40BMzb/CPmGex2Q8aG9yTWWomN1byhQNCv70iRxM96SC7KWV+uvP3UDt8OwEM+nR5zXkz5t21e3G3Qw0rGRH9KF3Fv4olQVI3QUyBmpKNTd9F3gK5ONZJN13CuztZmCnbMxiv6PlIG2G1fu4Po6heqqmM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG1mdzNXQXg1S0R6UEY5ZnNYaUpEZXpPeW01OHZrS2crYmJuVDFYL3B6MFVp?=
 =?utf-8?B?YmR4Sk5UMTg1Uks3TFg0aEhLZXQrZ2tyZndHT3hWSGlBQXFpeHBiTkhHVWlp?=
 =?utf-8?B?WkQzMENkNVo0aXhmbUF0WnRQbEl4VVZab0RkTi9Nekp1RzFhYlpiTVNtMFR4?=
 =?utf-8?B?aFYrZlVHM1pqcGFTOFN4ZEtxaFgrZVp0MmMwWlFHZ1BGNTRja2orejRxdlQz?=
 =?utf-8?B?RmpjWjd6YXRYVTIxMklFVldLNkt2bVVLK0lyQzNZZzNCYmZjQURKdWpJVFBJ?=
 =?utf-8?B?WmlxVHV3ZnN2SUw4NEl0cDV0dmVTTTJ4S1ZrV1RUbWszeEtLMWVUNUszYzdI?=
 =?utf-8?B?a3RKREt0OEpNZFFmenhGcEJMeXlnOGlMNHBpZlk2R0dYc01pRGJ5Q0RlQnpx?=
 =?utf-8?B?OGZOR1IxQVVhL3pQZVdZNFNweGJPR1N3MnVXS2s5NTFYbEVSUlA1dUV6N3Zr?=
 =?utf-8?B?UU1VNlZtSk8wWTBWTkFZc05mdFdrYzhSc2I4KzE5UGJsZU0rYU1odEw2STZX?=
 =?utf-8?B?dzhQWDh3TUdlcjhVMHhSVnhCTGY3UEg5TTlJSDQ4QytXcnloazF1SHJYREds?=
 =?utf-8?B?TjdGV2FzSlpoRUFCWVpES3o2b3IrWkJQeCtJWXdUa2VVZkIvN3VTMGFEM205?=
 =?utf-8?B?Mk0zaXhUSDJwejcxb0dmMGdFOFVEQ2E4ZkxXZUsxUDNGNlBoNnEvY2tGL2Nl?=
 =?utf-8?B?UklkbGFRcG5ZQ3o4REhwMkord1M5U2FnSW1wWlI0cEM3YXpIVW4rcUhJKzNi?=
 =?utf-8?B?R2FsNnNsZEEzN2JnZmEvV29mZXVxVXdmWWo5QmNCWnpKR2k2N3NNT3ZrMWh5?=
 =?utf-8?B?VHJJRnNSa3U2T2pWNnIvRW1vZnhaQ0JZdmkzRVd4Z1MrMVNUY3lrNGZCMVZY?=
 =?utf-8?B?algwSFRDNVJvbXVwUnloTFN4cDlRci9UTk1lT0ZzM0FUZ3l6U1pCbS9qUm53?=
 =?utf-8?B?R1kzMmFqSGtRRG1iNkR1eFdHT0twZW1sK2l5bE1xZWVNVmdIeGlXQmNKella?=
 =?utf-8?B?c0t5SXlrZkdUeThXUGNORE80Nk96b01vVXFMYmFiR1A1akRHQzkrNS9uWXJz?=
 =?utf-8?B?a0FRTTMwbHFkRjRDWjhhQXVQNG5HWDFhaTBjc2ZlOUF2UjlEQVFJbEkvSmZy?=
 =?utf-8?B?MkNDVVg5Q0lNaXR5VlNsOVJoNUordHpHellZRkVwN0QrSFc5RUliYlBBZWtT?=
 =?utf-8?B?L0NUVDFhT1FvaTAyd01xUkhyV1l5UWpDS09nS1VQekxlb0dycGI4SDBYZHFv?=
 =?utf-8?B?ZWZRd3dRalNXQm5GT3JNK2psdlpRM0lRVmRseEhaRFJCWUptUDlzdVpuR3Rq?=
 =?utf-8?B?YUhwUlQvTTluRHJzejN1dTFwYUZpVldwWklVMGJpMUxzTnVJdVFTeFZFSjUy?=
 =?utf-8?B?dG1DMWJvRlUrT3NwUzdaU0FUNStLOU9EU1ZzSzVLZ3d6eUt4QUpVZkVwcU5O?=
 =?utf-8?B?QVNDbE1RdFFSRXgzVDFWSGxwRmVaZzNKVFJQcHFSUWRURzdCdW45RCtScGc5?=
 =?utf-8?B?OUJ1b3VmYnFYRnlBMnl5R0VJWFF2UTlNdXA4NVVCMmZzVzJ1UVJQUGJoMTl4?=
 =?utf-8?B?Zk9GKzkwNk80OGkvMldjcWszUmk4c2Y2cFZ1N0FDeWNjMTVWSXJJQ2t5YllM?=
 =?utf-8?B?R29HYzdpVVlMckdGdzQrZFpnUXFrL280enl6RjB2T0JjblcrL0pGSzI3czJz?=
 =?utf-8?B?aEU4d3FZdTZNcEd6SWRnVDFOUSt3anE4VVdUQU5qOU1YWGhmekdLYVVhSVpp?=
 =?utf-8?B?cjhZUjFXTUhjNVhCbWJBbitJRFBRamFpam1yeFh5cm8yZ1pvNlREZVE2M1Yz?=
 =?utf-8?B?WGhCS2lWVE85Ri9hUmgyenBDSWlpczRhZFRGT3BpdlNKVXBFb3A5L3FkUG1x?=
 =?utf-8?B?bktBaTBaSkZqeXNQT0RDWi9meTRaV2I0SGpscnlId1AwZDVqendWNENhMEg2?=
 =?utf-8?B?QmxUaHNyQ0hPZWhvVU1Md0RKN245RTQ3Zkx2MVBabGI2NnE2TCtTRXpNN3Ri?=
 =?utf-8?B?TUZjNHN6NCs2WkdyV1pQclc4TW4wVk5BWTJoMDljazJnTFZSWVN4YkprUmZ6?=
 =?utf-8?B?UHIwckdqUjVJRkdEZElQenJneEdYNFpzQm1JT1lNMGhCZko3WWw1bmoyb3dO?=
 =?utf-8?B?Y0RzSi9hSFBsaHZPUVRJWWVFNGt3VnNJL3dZK2JRYWFoV3lOeCtQT1p4NWt1?=
 =?utf-8?B?K3NqWXIxLzZobVo3UGtyTlZLb3ZnZ05FVW5maTFEdVE1VnJTRUdmdzY5bzhv?=
 =?utf-8?B?OHVpcHpWRkFRRmxZNDl6aysrV1hHZGxlWnhxYko5OEkwNUR1TVVMdlJ2WFNK?=
 =?utf-8?B?RG1hQUtyUmc5dlVaRlBOTXZPaERoRHFvQ00wb2g1NkhXYWgyWnlHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2057E01E27A10C439A83E44E7B4677EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d+C9XFdYyAnpdSpp+g+ZwXUHw2940VuwAX7Jd6iIYtOCr6LkOx/EDimAWVfBtcMEPQI+KM+0E56s9g++DejTyj1x6jSOEWo2fIslcPxVYoWrwLNp1JsdsTnPiLTc/TDlXYWZb45ZbkXKp4K2dJMC4HvsZpFBMP/9DDK/2SrKr4VVhnv29j/ggNjxmbcce/zPw6xKwdJTsNQsen1aLt7pOr2fnthESH9AYLC2f8rha3zWcgMwqS7A/HdQYpshwqWWNi9YAsVwmzRgzt+P8HFGDkZg9asYJDQbcw5r74OAd6p2mWRywiTRqC+G5TCXsUWEDHrzZxDx3hvq8F45dw+L3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cca407-37a9-4ea5-c64a-08dea0472d53
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 08:14:29.6242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smIsc+zhmmCmfNV14LC29A1+7Na+jJSVy5NRBAfOngSM+5C7NbHZAVjqJMwAWcg9V3klQKdOkSrBOzCRM9OGhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7853
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTIyIGF0IDExOjI5ICswNTMwLCBOaWt1bmogQS4gRGFkaGFuaWEgd3Jv
dGU6DQo+IA0KPiBPbiA0LzIyLzIwMjYgNzoxMiBBTSwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiBP
biBUdWUsIDIwMjYtMDQtMjEgYXQgMTc6MzAgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3Jv
dGU6DQo+ID4gPiBPbiBUdWUsIEFwciAyMSwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+ID4g
PiBPbiBUdWUsIDIwMjYtMDQtMjEgYXQgMDg6MDggLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24g
d3JvdGU6DQo+ID4gPiA+ID4gPiDCoMKgIHZDUFUgUmVzZXQ6DQo+ID4gPiA+ID4gPiDCoMKgwqDC
oCB2Y3B1X2VudGVyX2d1ZXN0KCkNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoCDilJzilIA+IGt2
bV9jaGVja19yZXF1ZXN0KEtWTV9SRVFfRVZFTlQpDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqAg
4pSc4pSAPiBrdm1fYXBpY19hY2NlcHRfZXZlbnRzKCkNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oCDilILCoMKgwqDCoCDilJTilIA+IGt2bV92Y3B1X3Jlc2V0KC4uLiwgdHJ1ZSkNCj4gPiA+ID4g
PiA+IMKgwqDCoMKgwqDCoCDilILCoMKgwqDCoMKgwqDCoMKgwqDCoCDilJTilIA+IGluaXRfdm1j
YiguLi4sIHRydWUpDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqAg4pSCwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAg4pSU4pSAPiBjb250cm9sLT5wbWxfaW5kZXggPSBQTUxfSEVBRF9J
TkRFWCAtLSBQTUwgYnVmZmVyIHdhcyBhbHJlYWR5IGZsdXNoZWQNCj4gPiA+ID4gPiA+IMKgwqDC
oMKgwqDCoCDilJTilIA+IGt2bV94ODZfY2FsbCgpOiBOZXh0IFZNUlVODQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gQ291bGQgdGhpcyByZXN1bHQgaW4gdGhlIGh5cGVydmlzb3IgbG9zaW5n
IHRyYWNrIG9mIGRpcnR5IG1lbW9yeSBkdXJpbmcgbGl2ZQ0KPiA+ID4gPiA+ID4gPiBtaWdyYXRp
b24sIGxlYWRpbmcgdG8gbWVtb3J5IGNvcnJ1cHRpb24gb24gdGhlIGRlc3RpbmF0aW9uIGhvc3Qs
IHNpbmNlDQo+ID4gPiA+ID4gPiA+IHN2bV9mbHVzaF9wbWxfYnVmZmVyKCkgaXNuJ3QgY2FsbGVk
IGJlZm9yZSByZXNldHRpbmcgdGhlIGluZGV4Pw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBB
RkFJVSwgbm8uIFRoZSBQTUwgYnVmZmVyIGlzIGFsd2F5cyBmbHVzaGVkIG9wcG9ydHVuaXN0aWNh
bGx5IGF0IGV2ZXJ5IFZNIGV4aXQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSHVoLsKgIFRoZXJl
J3MgYSBwcmUtZXhpc3RpbmcgYnVnIGhlcmUuwqAgQ29tbWl0IGY3ZjM5YzUwZWRiOSAoIktWTTog
eDg2OiBFeGl0IHRvDQo+ID4gPiA+ID4gdXNlcnNwYWNlIGlmIGZhc3RwYXRoIHRyaWdnZXJzIG9u
ZSBvbiBpbnN0cnVjdGlvbiBza2lwIikgYWRkZWQgYSBwYXRoIHRoYXQgc2tpcHMNCj4gPiA+ID4g
PiBrdm1feDg2X29wcy5oYW5kbGVfZXhpdCgpLCBhbmQgc3BlY2lmaWNhbGx5IGNhbiBnaXZlIHVz
ZXJzcGFjZSBjb250cm9sIHdpdGhvdXQNCj4gPiA+ID4gPiBnb2luZyB0aHJvdWdoIHZteF9mbHVz
aF9wbWxfYnVmZmVyKCk6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gCWlmICh1bmxpa2VseShleGl0
X2Zhc3RwYXRoID09IEVYSVRfRkFTVFBBVEhfRVhJVF9VU0VSU1BBQ0UpKQ0KPiA+ID4gPiA+IAkJ
cmV0dXJuIDA7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gCXIgPSBrdm1feDg2X2NhbGwoaGFuZGxl
X2V4aXQpKHZjcHUsIGV4aXRfZmFzdHBhdGgpOw0KPiANCj4gQWggcmlnaHQuDQo+IA0KPiA+ID4g
PiA+IEdpdmVuIHRoYXQgU1ZNIHN1cHBvcnQgZm9yIFBNTCBpcyAob2J2aW91c2x5KSBvbiBpdHMg
d2F5LCBpdCdzIG1pbGRseSB0ZW1wdGluZw0KPiA+ID4gPiA+IHRvIGFkZCBhIGRlZGljYXRlZCBr
dm1feDg2X29wcyBob29rIHRvIGZsdXNoIHRoZSBidWZmZXIgb24gYSBmYXN0cGF0aCB1c2Vyc3Bh
Y2UNCj4gPiA+ID4gPiBleGl0LsKgIEJ1dCwgSSBkaXNsaWtlIG9uZS1vZmYga3ZtX3g4Nl9vcHMg
aG9va3MsIGFuZCB0aGF0IG9ubHkgd29ya3MgaWYgdGhlcmUncw0KPiA+ID4gPiA+IG5vIG90aGVy
IHZlbmRvciBhY3Rpb24gcmVxdWlyZWQuwqAgRS5nLiB2ZXJ5IHRoZW9yZXRpY2FsbHksIGEgZmFz
dHBhdGggdXNlcnNwYWNlDQo+ID4gPiA+ID4gZXhpdCBjb3VsZCBhbHNvIGJlIGNvaW5jaWRlbnQg
d2l0aCBidXNfbG9ja19kZXRlY3RlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFNlZW1zIHZteF92Y3B1
X3Jlc2V0KCkgZG9lc24ndCByZXNldCBQTUwgaW5kZXggdXBvbiBJTklUIGV2ZW50LCB3aGljaCBz
ZWVtcw0KPiA+ID4gPiB0byBiZSBmaW5lIHNpbmNlIHdlIGFyZSBub3QgbG9zaW5nIGFueSBkaXJ0
eSBHUEEgdHJhY2tpbmcgQUZBSUNUIChvdGhlcndpc2UNCj4gPiA+ID4gd2UgYWxyZWFkeSBoYXZl
IGEgYnVnIGZvciBWTVggaGVyZSk/DQo+ID4gPiA+IA0KPiA+ID4gPiBIb3cgYWJvdXQgZG9pbmcg
dGhlIHNhbWUgZm9yIFNWTT8NCj4gPiA+IA0KPiA+ID4gV2UgZG9uJ3QgcmVhbGx5IGhhdmUgdGhh
dCBsdXh1cnkuICBPbiBTSFVURE9XTiAoZXZlbiBpbnRlcmNlcHRlZCBTSFVURE9XTiksIHRoZQ0K
PiA+ID4gc3RhdGUgb2YgdGhlIFZNQ0IgaXMgdGVjaG5pY2FsbHkgdW5kZWZpbmVkLiAgSS5lLiBL
Vk0gbmVlZHMgdG8gd3JpdGUgX3NvbWV0aGluZ18uDQo+ID4gDQo+ID4gWW91IG1lYW4gS1ZNIG5l
ZWRzIHRvIHJlc2V0IFZNQ0IgdG8gcmVmbGVjdCB0aGUgYXJjaGl0ZWN0dXJhbGx5IGRlZmluZWQg
SU5JVA0KPiA+IHN0YXRlIGZvciBhIHZDUFU/ICBPciB0aGUgaGFyZHdhcmUgaXRzZWxmIG1heSBy
ZXNldCBWTUNCIHRodXMgbWF5IHJlc2V0IFBNTA0KPiA+IGluZGV4Pw0KPiA+IA0KPiA+ID4gDQo+
ID4gPiBIbW0sIGFjdHVhbGx5LCBob3cgaXMgdGhhdCBnb2luZyB0byB3b3JrPyAgRHJvcHBpbmcg
UE1MIGVudHJpZXMganVzdCBiZWNhdXNlIGENCj4gPiA+IHZDUFUgaGl0IFNIVVRET1dOIGlzbid0
IGdvaW5nIHRvIGZseS4gwqANCj4gPiA+IA0KPiA+IA0KPiA+IE5vdCBkcm9wcGluZywgYnV0IGp1
c3QgbGVhdmUgUE1MIGluZGV4IHVuY2hhbmdlZC4gIFRoZSBQTUwgYnVmZmVyIGl0c2VsZiBpcw0K
PiA+IHN0aWxsIHRoZXJlIHVuY2hhbmdlZCwgYW5kIFBNTCBpcyBzdGlsbCB3b3JraW5nIGluIGhh
cmR3YXJlIHRodXMgdGhlIGJ1ZmZlcg0KPiA+IHdpbGwgZXZlbnR1YWxseSBnZXQgZmx1c2hlZC4N
Cj4gPiANCj4gPiBUaGlzIGlzIHRoZSBjYXNlIGZvciBWTVggQUZBSUNULCB0aHVzIEkgd29uZGVy
IHdoZXRoZXIgdGhpcyBhbHNvIHdvcmtzIGZvcg0KPiA+IFNWTS4NCj4gDQo+IFRoZW9yZXRpY2Fs
bHksIHdoaWxlIHRoZSBtaWdyYXRpb24gaXMgYWN0aXZlIGFuZCB3ZSBkaWQgYSBmYXN0IHBhdGgg
dXNlciBzcGFjZQ0KPiBleGl0IGFuZCBuZXZlciByZXR1cm5lZCwgdGhlIGVudHJpZXMgcmVtYWlu
IGluIFBNTCBidWZmZXIuIElmIHdlIGZsdXNoIGV2ZXJ5IHRpbWUNCj4gb24gVk0gZXhpdCwgYXMg
cGVyIFNlYW4ncyBzdWdnZXN0aW9uLCBQTUwgYnVmZmVyIGlzIGFsd2F5cyBmbHVzaGVkIGJlZm9y
ZSByZXR1cm5pbmcNCj4gdG8gdXNlciBzcGFjZS4NCg0KT2ggaW5kZWVkIEkgbWlzc2VkIHNvbWV0
aGluZyBoZXJlLiAgSSBhc3N1bWVkIHRoZSBsYXN0IEdFVF9ESVJUWV9MT0cgaW9jdGwgDQpjYW4g
YWx3YXlzIGZsdXNoIHRoZSBQTUwgYnVmZmVyLiAgQnV0IEkgZm9yZ290IEtWTSBmbHVzaGVzIHRo
ZSBidWZmZXIgYnkNCmtpY2tpbmcgYWxsIHZjcHVzLg0KDQpTbyB5ZWFoIHdlIGhhdmUgYSBsb29w
aG9sZSBvbiB0aGUgRVhJVF9GQVNUUEFUSF9FWElUX1VTRVJTUEFDRSwgd2hpY2ggc2VlbXMNCmNh
biBiZSBjb250cm9sbGVkIGJ5IHVzZXJzcGFjZSAoZS5nLiwgc2luZ2xlIHN0ZXAgZGVidWdnaW5n
PykuDQoNClNvIHdoYXQgU2VhbiBwb3N0ZWQgbWFrZXMgc2Vuc2UuICBTb3JyeSBmb3IgdGhlIG5v
aXNlLg0KDQpPciBtYXliZSB3ZSBjb3VsZCBzaW1wbHkgZmx1c2ggUE1MIGJ1ZmZlciBpbiB7dm14
fHN2bX1fdmNwdV9lbnRlcl9leGl0KCk/DQo=
