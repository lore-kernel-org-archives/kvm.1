Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74918027;
	Thu, 12 Mar 2026 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309594; cv=fail; b=P8hpY3AEPuebxKB0FEqhF6ZQAAqPW3iWSV5LUZt+i9IPGBTzGrV7OwSmLLbcFmebjIRWmDkC3bEa1wsgC9nLd12v2B3vuPigi24w6Dhc9Z4o2N+ZJ+5+cDI5MiEc4dNtCcTMjL9FGG3jKzEm1jqMwLXLHGJFbq5PW5dV/l0dKc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309594; c=relaxed/simple;
	bh=d69KzSVHps13WzW0B2jCsV1DaZ1zRnZ3BtS/MdrItQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m7ADMSV3Lm4l46tZI14wL4VVv5QFhzlAXYvR/IV+LJcPLEES7ZSLdyno5Ai5GeOfsRTs3tPLIMke+ZgKfS+MGwUnECAgAdjSNB6/N4+1UcwcaMpx969dlfC4OVE+mcLe9XngZ0CUDKt42J/0AxRib8THQoD775EAKNV+QhxdGKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiGXEdQJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiGXEdQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773309593; x=1804845593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d69KzSVHps13WzW0B2jCsV1DaZ1zRnZ3BtS/MdrItQM=;
  b=hiGXEdQJkn5srfZRMCFNiG+fH/FTAYgqCd6uMCJKNSNFNZcww9mfR5UQ
   xcQkCt9tpaoRwPooGzV16DrBwOsKYtSK3rDmevMdgkwetomzVAoQ1qMH0
   CGLDMw/vZvPJ00hc2WcSk65fezhRlcor65o3UzxTc/EBijxj6XQAzNci1
   O1K5jxLXBdblrLZmjoBc9cbGvdvNl59P6pJFJ2nPf6qS8V+biY/ZZVulM
   G4hICzohY8R16iqdqZriPqOqBgNnGzDmOQOMWApd4H5Fj6txXsHYLIO0r
   JKV+p3+/sKoltjUHMaAYIyY3b98gwclG3nvD/If5PLaJMowyiPhpB9Gge
   g==;
X-CSE-ConnectionGUID: Eg1114K1RdqAW3n9Prdl+w==
X-CSE-MsgGUID: Dpk+uXviTLy8HzS3fOn+LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74275004"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74275004"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:59:53 -0700
X-CSE-ConnectionGUID: DQqo62rURx6Yox1CVCR+8Q==
X-CSE-MsgGUID: 67In+EQQTYieAXRlXkg6Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="216909988"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:59:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 02:59:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 02:59:51 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 02:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtLNhT2bBSebxcJFTVjm249sfqzrdVmfkfFrB+E/G0wmEaLVznYsKMiawd3loH93njRxrwRT8Qzao+DQBAJis22floCMu3B9nPAvWo2+DBV8KhBtCHU8CuO0LNwjgIT9n+JtruKKGr2XcAHTXIxdlUGotwNkJU9S2hhMUIeYy+Pe8Gu9v3une+I1xexBi89BWczKXi56KOYKsHd7xVUBMO34WbyM5yNOoQPuetWBXrkgeCGHQTOgJ/K+cGdydFcu69er84rkgsM7Y3lLukn2oOADOB40aAphsrhobaUHIhJ9mxpABbTZnMG/B3hO1ekm3ulPkAdkGCpZ/6HZvOvNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d69KzSVHps13WzW0B2jCsV1DaZ1zRnZ3BtS/MdrItQM=;
 b=BMIaBcrsxfstBpvQpZmDboFu+iYskc3L7sHV2h6P+wV1DX5NiE58myPEEL8+a6umzM2cs0D58UWB5Uql8Khhn3jERSqs+MdGPHEeLOmqo0ucguN1Rxm4+UqzmCcWRCJCzCJnSIBJbnWQvyvaKn+CCQD4COAXg2raW9OWTC8Uf8U9frX6xMyUDlVDV00qk150CE0NnstmxVvjhf0j0YF/1Kk529RSnXDt08hfyHdKnvTS482NUMOi+UmXHK/txV85wFxSRo9BcyU6VjzP4jZbmgtTYfN2AYtqsbcORZAwr6w6j13p3+eX/WuPrO5rD3elCwUOBY1CQ8HfhOLwzbtw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB8477.namprd11.prod.outlook.com (2603:10b6:510:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Thu, 12 Mar
 2026 09:59:46 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 09:59:46 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"kas@kernel.org" <kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Verma,
 Vishal L" <vishal.l.verma@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 24/24] [NOT-FOR-REVIEW] x86/virt/seamldr: Save and
 restore current VMCS
Thread-Topic: [PATCH v4 24/24] [NOT-FOR-REVIEW] x86/virt/seamldr: Save and
 restore current VMCS
Thread-Index: AQHcnC0D6N826aOF4kysQId97d9HJ7WpcuAAgACbWYCAALNcAIAAE/gA
Date: Thu, 12 Mar 2026 09:59:46 +0000
Message-ID: <a1d0a71f19610dcb5e29db86d8e0aed2a29e1367.camel@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
	 <20260212143606.534586-25-chao.gao@intel.com> <abFlCkNd7tqaUyAP@intel.com>
	 <d664ac9445b1c7cc864dead103086341c374b094.camel@intel.com>
	 <abJ90EMUnEAy763n@intel.com>
In-Reply-To: <abJ90EMUnEAy763n@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB8477:EE_
x-ms-office365-filtering-correlation-id: 8172713e-24ec-4067-c9b5-08de801e17ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 9+rD40igBCMGJtYmon4cqRnDunCTalrqoHoB4FmnLzFO2o+GIwIOshHIcP16xbd2g3QBGvlA0DfT8fTJp9TejNj8kFlZJKL+BbwcMNKpmxPQY26EVru4EEj6YdH8LZVGiNFEqmnIvs3gLNRG843d+rO3acuTRaBoo6HL6wcZ8Cg5FdF3uuOtG7fK+Yx+woFqs3POVzqYJU3BZlM/wAIYhZRRoQIkE9ldLs2xbkeH96AKKZK/SRjeZjhkeG+SVsy5nnNY/CNR+AxqAQODf5o7K0WQph5D5bAsLk0/rBBNgg523by0/S9wYuJ9cqq5CkXCJ0T9nrdTeWiJNXNxdVGI952NpKfFr+s8cYM+lnjH407kyb1+TVyRHHRoErHvjIU+VIrRxl6lnBWscjjmtmMeHekKjPp3kE1BqneA4vj2XSXrq95va9yq69pDvUQ3bMT+7TmZdVgTln2/Li/mNLpVpwIEDQVycSUEDobMEyJUeCx9IK7xz8y3rkJ3TtziPc7sfZpb7TcIEMLWJWxf7Gu/GNwu1yitpi6JT7su2PZstXvFxZSIHXcs0opLHhHzYcNblGAQM/Q6jmocb8rokyn2IC+H9x5bTufKvM9le7pkW52Fn1UWmnFJDyOpe6Vb+L++iZhVaf2MBxEo6NdgI8dZQ4k7S3Z1ZeHEfSTdm7ulx+XcZwapVkVH5hNx2jRS95odclLAoZ8CDC2M5+Z1YrC0p5kocm1kSz+UHO4/CTD8aRkmuQRgnJa2OXSYOEgcGZT08PE+0+BFkT1D481k/X/I88/58pt0jr3SBSxek+uDiNsP1lj4y32dYtnTGjnofzPm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2RnOWxLZ3NJNGJpUU9jTXFSNXp1dG9RYkU2ejNLWWRDRHJFVXBNNEhXOUVO?=
 =?utf-8?B?dzYza2JKdUpDSm9Na1daWnQzenhuRUFWS29XckpRTjZ1K2d1UW5jTlpDSlIr?=
 =?utf-8?B?NDRDay9wSGpyTkhsVEVBeFFPSlR5VXR6NGRUTUJVeU1IWUhyM2kybkNsQlM1?=
 =?utf-8?B?bXR3OGdzM2xxcFhnNWFRK1VhdHpqaVVBUkVIdG9SWHdLdEx4dUdQYlZkc3JZ?=
 =?utf-8?B?a3JuZlkvVE1CQ2N3QzBaNFM3TS90UTVJNjQ2Yk5JWlNtc1BzMTQ0dTY3cUc2?=
 =?utf-8?B?QzBaZXFFWGRkazAzamswaXl0Qm5sTjl2dFM3cXNmWjh5bnZ5Sjc4SnVHZGw1?=
 =?utf-8?B?TVZKeFhsKzFrSUlodmRmZ2VxSFRid2s4ek1wQWVEd0ZXOGQ0TVRsd0hhZHhJ?=
 =?utf-8?B?bFJxaTJLWXltanhsc2V2US9XQUhLdVJiUDExaTRad3NBSi9ZQStna0hPZG8w?=
 =?utf-8?B?dlovTmV5eVlEMFJrRFhJbm1paTJNVDRjSzVoWDFXc3J4YjJYVm80dUlBVFAr?=
 =?utf-8?B?aGFUTW9EZmRIYm4xR3VkVnl0ZVNhVnVVS3F6ckhWME81V3BFQUcrTTlQWk1O?=
 =?utf-8?B?MXFUajZiMXp1RlFjcjdycThwYWk1NEZHeC9reDRqQ3NlRFpBTTh5azU3aWYx?=
 =?utf-8?B?czEzVVBUdXNsbGZWTGczT044VEx2c0ZKYlZOTzE2SnVvc2orcmNaM1ZacnhT?=
 =?utf-8?B?TUtTcTI1dEZVMkNmRTg4Mjc0b0lFRko5bWp6VG9GQVVyMHVOWkZHL2d2MExM?=
 =?utf-8?B?bjlqUGh2L2Zxanl0b0VjY1R6Ky93d3VsL3NnejYzOXB1RTlxVmlHWDFBUk44?=
 =?utf-8?B?S2krUkhXVkZFa1h6NjBCVHJWa05RRWdDeXlneGlwR29BbDZRYkx5ZGJtYm1H?=
 =?utf-8?B?YnhZV0paRHc0QWNwSTdCaUk2b1NDc010TlFDTjh4b3Q1ejhIT3N2bWZWeXRz?=
 =?utf-8?B?T0psSy9iZFo1ZUlvQWJmem9ucE4vbGdZMzhMNElQQ0ZMM2VtaDhEbHF0Wndh?=
 =?utf-8?B?dWNPNkxPWnRPSk5DMWRjVkcwVGxEcW5aUDcyc0dGQ3JaY21ROU53WEJiRkha?=
 =?utf-8?B?d3JvN3l5aXRjcktYUFdzYlBibFBWejBBMXZHSmZaakJqNVRHVUg2dHBOemVJ?=
 =?utf-8?B?MlAxdnRqM0NpaEtMenlYSk1ocWtXeUR0OFJhL2k3ZVRLNW9kTzd0eDI0Sk1G?=
 =?utf-8?B?NFp4MitaaldZbytKZzk1SThzUnQwQlFjUlR6ZlVvQWtiV1FWcUtTTmc3bVQy?=
 =?utf-8?B?bFJUdFl4aVloMDhMWEY5MUViYlFtMHIyZDMzZnFDaEo0ekp5aVcwMGJEK0Zs?=
 =?utf-8?B?SVVBRnRSMSs3WGpPdnBZcTJGaHFPWkdreCtWWVcxNCs2TVpNYXNod0U3Lyt3?=
 =?utf-8?B?cWZ5Rm8xZ1RFQ3FLendRY3lLV0VBNmJjdWNHSFFacXNqVmFvQWNiQjJ1S0FQ?=
 =?utf-8?B?RjgyUjRIUzhoaFFleTlhWHRja1Q1VDV1c1BnbDgrbnhXN245NzBaWERudmxN?=
 =?utf-8?B?RFNrenUwTFRsSlRUVElWazIvSE54QmszZzM1dGdjbjJmSlQrcnloRlM2WndI?=
 =?utf-8?B?R29sd1lRbnN1SHQyNDQxMFVLQTNOamtkczJQOGFjTk5kVVVHTFR4UWhoc2du?=
 =?utf-8?B?NFYwaFB3S0YxRmNMTjZodEJlL3RjNGhDKzBMNHpCSDl2NEVoODlSQ3A5WFZG?=
 =?utf-8?B?NEF2SFMrRVRVZ3ROSGllbHNNKzNSUmVzMGcyYkMvYk84T2lTQUpzUTZYNC81?=
 =?utf-8?B?VVpKVXlXWFJ2UE5lUlc3Y0E3ZzMxeE81dVc1UHRBVUNiWW1ZaGNqbXo2N3JR?=
 =?utf-8?B?K0Q1R1ZZMUhjeVFoYjZxV0tFWFUvRjUwOEV5K0R5cG5PdUVVamFrR0lZako4?=
 =?utf-8?B?bFQzdlZCVmZkZ2dySnV0eUJJM3l6VTZyWnlObUFKN3IvTzZDUDlJcVplZnBu?=
 =?utf-8?B?NHlxak9aOEdRcFpyUFBmWThpdXJURTNkcmthUXNUWHBlSGZlWlcvZjMyQldw?=
 =?utf-8?B?anlrNFFkeVp0TTNabDcxSmlpY2ZrVFp4aXduVXh3YXlORTNnSjJNVDZJd3FH?=
 =?utf-8?B?RWFMWDMvYUhSWFRyK2hITVJNcXFtZmliVFhOY0xZdzYyTS8xcnNUQUpuU0or?=
 =?utf-8?B?Sm53eVBkQ0x1aGtGMG50ZGNHRkluazNSZGdmK3RpTFVrRkFreFNERjhwY0k1?=
 =?utf-8?B?dVM3TWIzaEs2VTl4b21nZ1E2ZHpYeG0zWm13MnRsbC8vaCt2RzdmNGxDb0ZX?=
 =?utf-8?B?VitrVUNqdGhXWk5sbW42WjErUW9qVnZWbmdlZXpxMU1rNzluV1BiRmtVSnVF?=
 =?utf-8?B?d0RtM2xRY09nbXNibTA3cWU3SzdhZmd3djRsb0dGcG1vTmE3YnkzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5B6F2500BD86A409BEB0C8E29520A43@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q0wzNNiZfcNlAs5rGFvC7Xn7DufFTQ1yj8t9C2d817xEbzp9HshHmS5+y/K/nw/5eFYOFtqwKkp/a8IG2laf0FqdyO2Uz5jrD8ukW8Z4vdflaDRqMRvLY3Gvic+ZMyXPWN6pHhc9KYqRu4MrCQbQByrPqNKe/nyrediAlXQCot0/E0Rfbe44C1RNo4UZ1HOM9gPdX1/jXzy09I0+h8UBa04iojoCxUEH0z371odbaybZVVRe3OwhMXO+ysYN4GB+AzKxQyBByEkGsMR7fYEQnNQyfLk2yxihYNi/1eFZh3VY9b4kpeYqaHjUNsf7SAHfxbjNxxbaXGoKjYNNwXyqJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8172713e-24ec-4067-c9b5-08de801e17ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 09:59:46.7598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBA5GEcJaxOIVLEOXrDYX/x4WoLn8Gfa+YUuKEGV9N0BqsH5StYNSz9BMUogyQ1qiWW4vUSox/ZOnjKXlC/vIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8477
X-OriginatorOrg: intel.com

PiANCj4gQnV0IEkgYWdyZWUgdGhhdCBmb2xsb3dpbmcgdGhlIFg4Nl9CVUdfVERYX1BXX01DRSBp
cyBiZXR0ZXIgaW4gY29uc2lzdGVuY3kNCj4gYW5kIGV4dGVuc2liaWxpdHkuIFNvLCBoZXJlIGlz
IHRoZSByZWZpbmVkIHBhdGNoOg0KPiANCj4gDQo+IEZyb20gNDZlODlhNTA4MDNkNjU2OGViNjBi
ZDhlYzg2NmFjM2ZkOWY2ZTZkYSBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogQ2hh
byBHYW8gPGNoYW8uZ2FvQGludGVsLmNvbT4NCj4gRGF0ZTogVHVlLCAxMCBNYXIgMjAyNiAxODo0
OTo0MSAtMDcwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIGNvY28vdGR4LWhvc3Q6IERvbid0IGV4cG9z
ZSBQLVNFQU1MRFIgZmVhdHVyZXMgb24gQ1BVcyB3aXRoDQo+ICBlcnJhdHVtDQo+IE1JTUUtVmVy
c2lvbjogMS4wDQo+IENvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOA0KPiBD
b250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0DQo+IA0KPiBTb21lIFREWC1jYXBhYmxlIENQ
VXMgaGF2ZSBhbiBlcnJhdHVtLCBhcyBkb2N1bWVudGVkIGluIEludGVswq4gVHJ1c3QNCj4gRG9t
YWluIENQVSBBcmNoaXRlY3R1cmFsIEV4dGVuc2lvbnMgKE1heSAyMDIxIGVkaXRpb24pIENoYXB0
ZXIgMi4zOg0KPiANCj4gICBTRUFNUkVUIGZyb20gdGhlIFAtU0VBTUxEUiBjbGVhcnMgdGhlIGN1
cnJlbnQgVk1DUyBzdHJ1Y3R1cmUgcG9pbnRlZA0KPiAgIHRvIGJ5IHRoZSBjdXJyZW50LVZNQ1Mg
cG9pbnRlci4gQSBWTU0gdGhhdCBpbnZva2VzIHRoZSBQLVNFQU1MRFIgdXNpbmcNCj4gICBTRUFN
Q0FMTCBtdXN0IHJlbG9hZCB0aGUgY3VycmVudC1WTUNTLCBpZiByZXF1aXJlZCwgdXNpbmcgdGhl
IFZNUFRSTEQNCj4gICBpbnN0cnVjdGlvbi4NCj4gDQo+IENsZWFyaW5nIHRoZSBjdXJyZW50IFZN
Q1MgYmVoaW5kIEtWTSdzIGJhY2sgd2lsbCBicmVhayBLVk0uDQo+IA0KPiBUaGlzIGVycmF0dW0g
aXMgbm90IHByZXNlbnQgd2hlbiBJQTMyX1ZNWF9CQVNJQ1s2MF0gaXMgc2V0LiBBZGQgYSBDUFUN
Cj4gYnVnIGJpdCBmb3IgdGhpcyBlcnJhdHVtIGFuZCByZWZ1c2UgdG8gZXhwb3NlIFAtU0VBTUxE
UiBmZWF0dXJlcyAoZS5nLiwNCj4gVERYIG1vZHVsZSB1cGRhdGVzKSBvbiBhZmZlY3RlZCBDUFVz
LiBBbHNvLCBlbWl0IGEgbWVzc2FnZSB0byBjbGFyaWZ5DQo+IHdoeSBQLVNFQU1MRFIgZmVhdHVy
ZXMgYXJlIGRpc2FibGVkIGZvciBhZmZlY3RlZCBDUFVzLg0KDQpUaGUgdXNlciBjYW4gYWN0dWFs
bHkgc2VlIHRoaXMgbmV3IGJ1ZyBmbGFnIGluIC9wcm9jL2NwdWluZm8sIHNvIHRoZSBlcnJvcg0K
bWVzc2FnZSBtYXkgbm90IGJlIG1hbmRhdG9yeS4gIEl0J3MgZmluZSB0byBtZSBhbnl3YXksIHNv
IHdpbGwgbGVhdmUgdG8NCm90aGVycy4NCg0KPiANCj4gPT0gQWx0ZXJuYXRpdmVzID09DQo+IFR3
byB3b3JrYXJvdW5kcyB3ZXJlIGNvbnNpZGVyZWQgYnV0IGJvdGggd2VyZSByZWplY3RlZDoNCj4g
DQo+IDEuIFNhdmUvcmVzdG9yZSB0aGUgY3VycmVudCBWTUNTIGFyb3VuZCBQLVNFQU1MRFIgY2Fs
bHMuIFRoaXMgcHJvZHVjZXMgdWdseQ0KPiAgICBhc3NlbWJseSBjb2RlIFsxXSBhbmQgZG9lc24n
dCBwbGF5IHdlbGwgd2l0aCAjTUNFIG9yICNOTUkgaWYgdGhleQ0KPiAgICBuZWVkIHRvIHVzZSB0
aGUgY3VycmVudCBWTUNTLg0KPiANCj4gMi4gTW92ZSBLVk0ncyBWTUNTIHRyYWNraW5nIGxvZ2lj
IHRvIHRoZSBURFggY29yZSBjb2RlLCB3aGljaCB3b3VsZCBicmVhaw0KPiAgICB0aGUgYm91bmRh
cnkgYmV0d2VlbiBLVk0gYW5kIHRoZSBURFggY29yZSBjb2RlIFsyXS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IENoYW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQo+IExpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2t2bS9mZWRiMzE5Mi1lNjhjLTQyM2MtOTNiMi1hNGRjMmY5NjQxNDhAaW50
ZWwuY29tLyAjIFsxXQ0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vYVlJWEZt
VC02NzZvTjZqMEBnb29nbGUuY29tLyAjIFsyXQ0KDQpMR1RNOg0KDQpSZXZpZXdlZC1ieTogS2Fp
IEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQpPbmUgbml0IGJlbG93Og0KDQoNClsuLi5d
DQoNCj4gKyNkZWZpbmUgWDg2X0JVR19TRUFNUkVUX0lOVkRfVk1DUwlYODZfQlVHKCAxKjMyKzEx
KSAvKiAic2VhbXJldF9pbnZkX3ZtY3MiIFNFQU1SRVQgbWF5IGNsZWFyIHRoZSBjdXJyZW50IFZN
Q1MgKi8NCg0KIm1heSBjbGVhciIgLT4gImNsZWFycyIgPw0K
