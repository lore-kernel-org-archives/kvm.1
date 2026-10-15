Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440C522695;
	Thu, 15 Oct 2026 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084888; cv=fail; b=VW/TG7jB4HP1xHbuOqznrA8kvicFUpP5E0s2Ec7Sq5Svy7ppUBZNtptlIoRBScE1VJ9GcOUskl6Nhh9tFNCqXwPzfjI32HonEQzCwsnbeq48lMhNrtLcm2KAQQ7rvOt0UGmM4WJWEWGghgUxFF3uBOV2SgnkIr2vcbQOcn6tK6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084888; c=relaxed/simple;
	bh=DfPmQK5rnw7A+srwKcHInT5ZlnnaMG+TzBhhByOqyGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VDHjnw7Kci0ZIYvX+vZg6H0WnCXeOGezkJL2urXcJ2XuMk+SewjbZBpgjz1El4wQfyG0cl8/unLcdQ+eykLGXJUh5v/+h/QsSCSsCdZa7PUNU14bkL/NSwcE9nxBIvCURK7jS1wcJ64yLrvY2ULVhHMAJNq1mEUx8HeFHKZrUKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lx9lclCW; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lx9lclCW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792084880; x=1823620880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DfPmQK5rnw7A+srwKcHInT5ZlnnaMG+TzBhhByOqyGU=;
  b=lx9lclCWZDI5ToId385/km4VDNOhAKtFKyfx6lxdy3IOlKZceV69ZssC
   vBU7H+mgPL8+399XTE7VwJPLF5u3JMrTAKa14D9GSpSOqFggLb5Yp0fXm
   l720Oe5WlUW+6OMCcrRMaJhuyyOJBtupw8UDzfwjnMFrsVPZOs7Uxwaqe
   /t87x8ayBvRg/wylFY6IkKT/0zAP1kCDbDScORTytHnvEJB30JudfFH1Z
   rRkOUAtX16/yJHzOUl+QqFEb1JXSLDWxhkijzZVny+VN06DxCwFJt8hZf
   Js46HaET27uavJWO93BUqxtmxH1pSJFarjFa5YZLdQeveARx346bEHZJY
   A==;
X-CSE-ConnectionGUID: bJ3X6+ZrS4i/ardycX27yg==
X-CSE-MsgGUID: XYrNXRFBQ5Km25qCoGL2IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765619"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765619"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 10:21:19 -0700
X-CSE-ConnectionGUID: kbOFdYxXToKLLpPaNtqUMg==
X-CSE-MsgGUID: H5lSt6b1SnyXp/zPKWx7iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="3526410"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 10:21:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 10:21:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 10:21:18 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 10:21:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvZgC+mYL3F+vU8NADrQw3SZs6hHQsnL9KMXxWHGYni8xCdnQ2LyIetZb3c6AeSkt4oWigkkNAvTHpFm57XXw6BSKWLKoLhcw4SBzKIK+QCTm48gjSdyD8xXkgBxDnMxAGzTBs0AjJe6wkTFdhantle5VjK75ldeisJ02aq11Oa7u9EU6UJO/wO6PXGGHE+s1jplGZda1+HhTDbKd5QCCp4nrNPg581ozlb/4OW538bj10W6LKsFKUwWB8kky3BbR7Q4Xjf+Qjx9IMK0RUnCQLGkRkkDKjW87XH/ZMStkWp7E8sxOPxlmoWo/807+FXCUNvbMvsSOJ7XPEe0h1z/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfPmQK5rnw7A+srwKcHInT5ZlnnaMG+TzBhhByOqyGU=;
 b=SvFQFW2QlrLtKtvMjk3wDjV20/V/2y2IpVLMcuYhNUeyrfejOR0vpFiVLWGhPEkjB6Mey3R7ly0RWPbPeCuRE/P2IBmtPLXw+k6xkPWfq1y4aEUWAbqyPCn4/O8F/0ejMEJH2IW/ni1zHDegwX4KOQwjGdtL8nup6roKwE1dZrK8k1RDy9g8k/9LHA04T/Zm9eYPmRBYW7Pmb2kD0WK0dPMd8zkXtR4rJDeelnZmsBIcnfU3jz+XFWNAzjyxzNhnKd2jGy8SjOOqLssw+lC3UJoDj1mA4etsnUNdKQQBKvlNORctF4X8YTLr5C8sYdqIN5ma2bxa6a7Soo2ZCt1LuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS6PR11MB425752.namprd11.prod.outlook.com (2603:10b6:8:528::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 17:21:14 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 17:21:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"tabba@google.com" <tabba@google.com>, "david@kernel.org" <david@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Topic: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAApaACAAhZUAIAA2vcAgAB1o4CAA+N3gIACbDEAgADZdgCAAKsxgIAA0reA
Date: Thu, 15 Oct 2026 17:21:14 +0000
Message-ID: <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091035.15599-1-yan.y.zhao@intel.com>
	 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
	 <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
	 <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
	 <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
	 <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
	 <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
	 <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
	 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
	 <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
In-Reply-To: <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS6PR11MB425752:EE_
x-ms-office365-filtering-correlation-id: 685d5687-d0d4-4e22-5dd3-08df2ae0b707
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: FvTWuFSt/gu4qkIUYCjFVLgB+Xvnt9znwWHjnp4O96MLoP/p9eW54keIyeE5KJ9efVily/HO6rlLl+mYR0FGBK8Nvnvej5KvN24J5Pkek1qAfXljJNbV9jZ9ngsKAurNvHT6ljpQFOmWMl6Bc952dGncTmX8f5PwgB5JaatvhOBGO834ehVI2TdGAbPKWAKBj5cjX2g7H+vFSQsM8DTY1o92bYXn3k+l6dIdiXbknT0EdkmIhH0RaeiB2X0C8tiw/5qTc9w5u0M5YIQbt0arvCSgr+sqXBGeKDQqo6xywgbcDGGlwgoML1eU/F6sG1mMwl91EP0hey5PqJgcj4j6kfPrTbQ5y7NVhsCBnmzmH5bw3ygG12jXs1VT/OEk5lM8iHZvMvS6YyUoqVvYdZncmUdYNY/eHSxjCDJ//eYwKR7wx/5ENuKBR8ux5cvPelPSZWjO61wY7n6xVRh92K2GTJXYrzo7LUby6SxIjnHpEXyIbgVaJWm7ABLn19qIuKHUdvg1Umm1PE406JcSBeN7Jn3yE+hHz1LtPGolEOC1vY7YWp8enjgKR8AqnPU1dy2sl9I3H3fh8h08tcfMzt8Xs+CwVF6xi80qZIyUbLEjYid5uaFTJplIeomlLzVEFRsxeRK2MM32nU+evMu8T3oILlw8prmML8pbYCmpmaafzJtURWNgSeearCoRXNtUMqq8FC50KfMtKGKOMpptmdswlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1pFRVVqYWxWY2Vsc2htbVNKejNpTmorRE1WTXBKRm14UlRHOSs1WkZUVUkz?=
 =?utf-8?B?WGh6bWprRFlDY2NYNWlraU5McElNMk9lelpOcGs1YWY3Q2NPQVozK1ZQMHRO?=
 =?utf-8?B?VGJpa0V3VUM5V3RMQnpMellYV2NoTnplU2xOdzczV1U1VU1QNzY3Q1JVa3RC?=
 =?utf-8?B?cUNQbzVRTmVwNEQwMk9zUUFCYlRhdmlVeUtENytxSWhFSnNSWXN0SUF3T0E5?=
 =?utf-8?B?SVVsSEt5L3R4eFhvYVdNcG9KdStwb0VXRmdEUFRCL2ZTZ0JoaXQ1YXJCLzlV?=
 =?utf-8?B?QURGOXlabHptSHh0ZVJEUU50TjJCUW02R0tibEFvK0RONmx3YWFIYXB2eEt0?=
 =?utf-8?B?RDBnMVVJQzFTK0krOUx5OTE5bVYzUGVHU3JCRHhDN2l5UVZBN0l0L24raSt5?=
 =?utf-8?B?OHJTUjQ3Ynh6dDRxN25qa2RTeWxLMHBYRFpoNjlWTXNrYXhtODk0QkxuSStn?=
 =?utf-8?B?L29zR0RReXVZUFFFcG56ZktrcGh4R2lXazU5eGlQaDkrdTRYZ1ZkdmJUQnVQ?=
 =?utf-8?B?WWpaNWNXZmFCenVqTWNUTXAvVmxWV3R3RSt3VThHWG1IR0xHaTZZaDhpRFdE?=
 =?utf-8?B?YjBLTWl6Q2hVdUlldHV5UThhU1ppVTg0OFpCamhycVU3U2xGRW9SMytSMEhX?=
 =?utf-8?B?V20yQ2NieDUzNGZ3RXpKM2x6VHFhZ2VqNXZudEFVbFZWTDFMSEJpamE2SDhH?=
 =?utf-8?B?K3pSOGJiRmk3di9MUTIrVWgyN0w0QVZZNlBDWHcrUHRGaGhDcTF6UlM0MnNa?=
 =?utf-8?B?NkVEL2dHa2J5d0Q1UHA5dlZlSW96bnlYUko4NUNzV1dVRUZ3MCsyNVVXSGJv?=
 =?utf-8?B?bWRnWWhrTkRzNzJZQjl3K1UraGRKYzhLUmlSU2s3a1ZyMTFva0tsaVpyUi9x?=
 =?utf-8?B?bE5FNGFrR1MrUzVrTzNZWElOZzVPL2ZOTUtZazZ1REVvZmY0TGlUaWhHQVN5?=
 =?utf-8?B?clM2VmZEbVNrMi9xdCtCbkNYMHN4YkpuVno1SjNKcFIwYnNQNmprRUM3eWRT?=
 =?utf-8?B?ZnR5d25weHlZOWx1Zkc1Y2lJa0ZYWEJWL3dpNkM3cExLa0xpUzdvRWNzN29K?=
 =?utf-8?B?VEdWSmxiS2dkWHFSbk9HR0JqSHg0NmE2WnJMYjJLc3ZFSlV2RjRVZktaNDFh?=
 =?utf-8?B?YXZOZkd6R0dodHQxQVNHaVorY24zS0V2VTBEaFIrMEcxck9UYTQvcTVuMnc2?=
 =?utf-8?B?dGpxaEdHRGtQUnJ1cEo2R1hPcUVTWUIvbm1BWm9JM1F2QmhSQm4zbUR2d1lH?=
 =?utf-8?B?dTEwZXA4YlpPS05MYzdjY0lNRzdvYmVIcmxOK0hQelBwVlJMTmdaNTJMbjh2?=
 =?utf-8?B?YkROUmtiWkJhWmFSOUt3TTBaYVhwWFBxVCsweGZTYTkxSzBDWEw4b3MveXhy?=
 =?utf-8?B?UlVTeEZsY2J5Mnlad0xEc1g5QkUzYWIvN3ZRa1IzZkpRRzBYUjN0UiszbSto?=
 =?utf-8?B?aGNWRGdmOXl1K1FWMnNKTC9udjV4UXpPVFk1d3l0TjhCalBaZ1Y0blJqYldr?=
 =?utf-8?B?ODh4UTBlMXNQTWRKMUJjelV1TlBIV1lVKzh5bTZFNWlXbWV0Skt5a3ZpS1or?=
 =?utf-8?B?QjhaNklkR2ZEWmVtb1piOGhWbWNlbU1wcGtQcG1DRi8zUWhoRWR2ZGYwS09O?=
 =?utf-8?B?WlhUUTQxUXhxN3MwMGNUMFJFUGVFeHNRWGlkUHVOc1d1SUZLazhQcjY2TXRW?=
 =?utf-8?B?WHhsNTlOTm11L3VyRnFySk1qTk8vM3J0bWR2ejMrQlJOby9kNzgreTNZL1B4?=
 =?utf-8?B?bmQvUmRDNXpvLzAzRkg5MnRNdUV3ZkpuMGF5QWJiaVY3ZzJoNjdINzROdHFQ?=
 =?utf-8?B?UGVuUjdha25ZZW5QdnJoMU4vdWdtaDAwZ2NBdEtiZjNlV3pJTDBkNWlzb2Yr?=
 =?utf-8?B?WGpJZVBGZzFKdlZzMUVycDY5Y1dnZkhYY2NBWEpXcWVFaC9MeUszd3FtYm95?=
 =?utf-8?B?ZnliQVlzQ3pzY1J5VTQ5bTV0NjRKbGtIUEVkcGY4TjlTMlo0dlQ0ZlczanYy?=
 =?utf-8?B?QUF2Uk84VHkyNTlwL05Hb2RudXA0V3ZMcXp4Nk5aSy9OZDBpY0J5elhWZFhU?=
 =?utf-8?B?a1Zyc1lhNGwzUTJ5RE1PTFpHc1ZaTVhTbDZKdE8xZ2I1NmxidWdkcCtrQVFJ?=
 =?utf-8?B?QmRvWERlN2V3Q084SEc1cVZRcG1WdVBoVTlpRzNjM1NReFBMYSsrMEJCeXlu?=
 =?utf-8?B?dUdsbkI5cmxwRXF1WDBTSkZML0Y1djZkQWtvaVhkOEl4UzdvQUhUQ01yWHFE?=
 =?utf-8?B?V1FjM2RKZHptOHpBTzNROVphYVRiQnBVM3A0YTBLWUtZYmo4Nk9tYzg3Y0JP?=
 =?utf-8?B?ajFVZmk3UXFLYkxuR2tqa2lKQURtTVhybURjU3ZSRXl5eXFYRDRjYmJsL0Vs?=
 =?utf-8?Q?ZgNxAWD6VDaWpGO0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECE18CC9AC8E13478AA133883190B85C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uDnkL9yK5FrVUpdu/wp4j3//7sDmuLrTJoYPTBfZlpB3B7ksYd6o8uXYRTllu3WqH07xTzvkT4zGN7itYsVjkOyXlT4BQkZEWEiif49l3+KTa40tYdt5zrTM+eLYIfKJL/Iuj+G6Dyu9iQsFiQ4pltA/53p1f3VKC63tZAi7IqWlJiKSvox+fT0yVqvo34ZPU+w0gJ34kqk2fHPen2rPnL7epVSDhp235z58Zf4OAQLq8hCNGhCjgRwAK9uySC9sFRy+fbYfoA0UQqpB7HXOwNoZdg6i1e5WXwzRRLvV5CA2qE5vlttR32hSuI2Tb5KF8ELaSd91lJ6XCUSXBiYdBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685d5687-d0d4-4e22-5dd3-08df2ae0b707
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 17:21:14.1027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQxweGDCtBqvbXYsFoTN3xnw0l0CDX5BNejbeU9TU3HNrFvTVpORZhvMi1ROwDcc9Te16hINIA4IWfvMj3n0TGH/r0xnMDIVJbe23wPMbLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB425752
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDEyOjQ3ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBU
aGUgcG9pbnQgb2Ygc3BlbGxpbmcgaXQgYWxsIG91dCB3YXMgdG8gbWFrZSB0aGUgY29udGFjdCBj
bGVhciBhbmQgdGhlDQo+ID4gaW1wbGVtZW50YXRpb24gZG9lc24ndCBoYXZlIHRvIGFzc3VtZSBh
bnl0aGluZyBhYm91dCB0aGUgY2FsbGVycy4NCj4gSG1tLCBidXQgaXQncyBoYXJkIGZvciB0aGUg
Y2FsbGVyIHRvIGtub3cgaWYgcHJpdmF0ZV9wYWdlIGlzIHRydWUuDQo+IFdlIHNob3VsZCBhdm9p
ZCBsZWFraW5nIFREWCBzcGVjaWZpYyBrbm93bGVkZ2UgdG8gS1ZNIE1NVSwgcmlnaHQ/DQoNCldh
aXQsIHdoeSB3b24ndCB0aGUgY2FsbGVyIHdvbid0IGtub3cgaWYgaXQgbWlnaHQgbWFwIGEgbmV3
IHByaXZhdGUgcGFnZT8gVGhpcw0KaXMgYmFzaWNhbGx5IHRvIGNvdmVyIHRoZSArMSBwYXJ0IG9m
IHRoZSAiKyAxIC0xIiBpbiB0aGUgY2FsY3VsYXRpb24uIEkgd2FzDQp0aGlua2luZyB0byBzZXQg
aXQgdG8gdHJ1ZSBmb3Igbm9ybWFsIGVwdCB2aW9sYXRpb24gKGxpa2UgYW4gYWNjZXB0KSBhbmQg
ZmFsc2UNCmZvciBzcGxpdC4NCg==
