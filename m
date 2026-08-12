Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F0331EBB;
	Wed, 12 Aug 2026 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577414; cv=fail; b=ftuhqpPf9KaTaSVMUDfFiIGBO0eH8//ncrwvC6WEis8iB7GeyL0QFb9GpkfthdC7L5GKTirmDVDnqaIWgNl1lQ1Nik8ED6WGbS3ZeTUjOk7Do6sHmggZK1TLmxZ81s8V+BQIwJSinAG3RYk6BwBmt3H3RzyrkP+o/C2P+W8PcrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577414; c=relaxed/simple;
	bh=7cUd35oLPWefDEDBEq1EC1KYiFLCpKycccAYxSPq8tM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oacMdYVlVxXt7JnhT1eJ/iW69xv559oyfpVztSzgonOzdh/0UODmGrpydoV3g9sOgAtUR8jAUc2UZi2wH3w4nU5++Mv1TO79f8U0DpWDQktzN6GtZFoPYNpjFFTSoQhvZXHI/HeyhTov1OyG4vOaTX6NLQvLpY33KrssFlt1Kg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gj0uLt2y; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gj0uLt2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786577412; x=1818113412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7cUd35oLPWefDEDBEq1EC1KYiFLCpKycccAYxSPq8tM=;
  b=Gj0uLt2y3lJLEfdpstpk0CdwnkmbuUa+6B0zaV7tFv8Cx9OA7imEd+bT
   ygv7+csEUk+/U552sbbfYCieRVQqd/Ue7rUMax1gzSaX3255Y7wWXulbC
   23bjOtCczTtf529/Fnp/CS465WkDcmvdD1k7fLjyhyFPw2A9De+eCZfIA
   Ub9GuVQ7/HFDrhUb5RgeeKL3sNT/fV/Ll9aHZdgi6MWWmW5596uORAqZM
   Qp3WSCAL/g6K8n2S5hxeaKYG/Oxa0GpGyLPq9juRxejscwIIcABcSEAy1
   BhO7Z1i9cSNDqyyYpUbCJTR2Oz8Wh4onpx6apiByEd4cYvtXKWlyNn0wT
   w==;
X-CSE-ConnectionGUID: aCpsvMGsQH2swXtZqLJ3Rg==
X-CSE-MsgGUID: 9BKjUmexQdqBzgagzGVNqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87163039"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87163039"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 16:30:11 -0700
X-CSE-ConnectionGUID: utnEpMaGTTGNhlJqlpPXCw==
X-CSE-MsgGUID: 5f41EpgESP2h/PemlwtOOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="293726762"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 16:30:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 16:30:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 16:30:10 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 16:30:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MttoFzrM9wvOKB8zJexPlCZpIWqIoW2YLLqWPEW4sz3UoVZvRCOAujMB1eKcmjaR6wTI0wuNKU8Z+zpS/GF++QbyOJPtDZ5YFy5N6JloO8orDn5R8DYuirqkPoIQWOKgDODw/1yNqBQuSeeL77jyHWvGLkLQCZm3priomLqebz/lwun4bVwuzNPpbcCKk3R5qeE0CVXrXqt3INCfHlJ3+d41bsDeB8FVsT5lGmc0WtKImJRTCtA34KTxX+YYeIQxtXxLgxos+VI7kUi9uDulGgDtCDgsDuIPgoLIsP46mSzkPC02z4ltUyzZEm7vjcReMtqpblTQrrV69TqAtJHgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cUd35oLPWefDEDBEq1EC1KYiFLCpKycccAYxSPq8tM=;
 b=eV9qSfndmRABjPkWuHRooyHbLlIS/o2lja9s/euLtprc+h6nru3Q80cMRiqALetmfbHiQ6PZUjVCLZxY7JsvHemxXYSBm63aa3lmKVTdYsqR9K57iuiDFVYSstY7NNxQf+0au9bm3i+USbK9xCYaX25gjgeKE7yG3uqy7tWq7x261bBA1znLpwFVKJvZaA+eetkj6IYSyUiaeei1LmUq7teeWjWI8BOBU8r0qF2mDkpw0ULUYMtP9RQXWOl3iR47YHmBqc2RJAwFKHMB34tUMHCWTzpDhRee3QFQt/Q6dfPSWkRfVsSdssc8EpDJHbSe8MzK+D4E9ncAZbNNd/DVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BL1PR11MB5318.namprd11.prod.outlook.com (2603:10b6:208:312::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 23:30:07 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 23:30:07 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "x86@kernel.org"
	<x86@kernel.org>, "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAAgBSEcgCAAQNDAIAAIM6AgAAKnQCAAAuxgIAAVwiAgAAC5QCAAAZ6gIAABW8A
Date: Wed, 12 Aug 2026 23:30:07 +0000
Message-ID: <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
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
In-Reply-To: <anz9b6CDkhr5D5RG@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BL1PR11MB5318:EE_
x-ms-office365-filtering-correlation-id: d967f0e9-5edf-4979-d6b1-08def8c9a518
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|38070700021|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: CqRHnx6ys2CwtRQREPg0Ucoe0Xc9FEROPheVJQOZGk1JU/65DNHez1ZHjyXVwdcRwjM4JZEZpwmqFVFWX/5FMGpCyUIw0GIngpo4phPrtpPxc27U6wLKFppIoRPFiECqbA8/XklSDxNHcpbcLGABMl6amKdSuv0w+qUJCT/IBWn8l9vKm0bUMYt+Q3yAR6bHlnkc6P7YizPUFB0Ip+TcncNdNn5ZOQCdESPOWQ87Buw8M8pfsa2uKYf6PL9cavWWrH2G0q8/Qw+C+Y4f/kTVKuPYYz5Np5XURZOsO9E1VB1ZW0U4+HfIDD31SbFhBv6vO7Q25YoiO9iN1VSgDM3vDfGlTNfI42ik2hZxPhxulUGpsCYy5N7xDq//n2h8h3j4URiJRVAme2iJ9ycqKaJZYFv+SZMWXz3tjOCL37N5le/EHHxnkJCbmyvE50Hpqb8JFV8i8gXYXdsWErupQUvb9SQhuaDv86PJjgOwHJKgujB56qovPk0ZqPwUBTpzBuBom+mzY1LxEl/CAx9c9yL2DLptey6lpAerK++JXXwZzb9K1/jRvVeqdztSs/xaH6Cv3/Ts+FTJcoDQfhKlxv1Gfzv4bAOM3a+VgDW4jlOMrVEzI45Wj9LA9CMiCPshsGwmz0a+ncFf3TUlFfjw2lmizGbMTohJY1w5TTBTmkE22LzciSkqsdd7GdrglhNDxt+gYvS4KX+USwaKgp6gCuZE6zMk2Y5iQQrLs+gkfwEt3M0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(38070700021)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzQ4MGNIc2JDRmZveS83SzFGaGswZjNlMEFmQlIyTFdGVndjMldwNDlGMmtm?=
 =?utf-8?B?VW91OGtidzlhbTFLdEYvNEVwdE12MXJNNG8vUS93YWo2bFppMTRZSFJQN1FD?=
 =?utf-8?B?VDNjdXNIK2Zva2JUK3VTT3hqRzkxS0E1YTBYUWdtODE1Z1JyNEFWdVBJTFR4?=
 =?utf-8?B?b2huSWlqZm52YXRTeVFQbzVVN2RySzdySnNWOUFodUlya2NEUEtnZEt2eURV?=
 =?utf-8?B?bzF4VUg3K1pma0JxV1pUQy9RUklLSmF2a0ozaDEvTG1PR003dnRCOTBQdmdl?=
 =?utf-8?B?MmN4VkEzcTZvb3ZjL3hKZ3QyRFJFK3h5L2hMK2ZQN1lWYTJ6T0NsMU9IQi9H?=
 =?utf-8?B?TnpHMytvRnZGeS83THpIVWtGRFB1QUg5a3ZmU05RMXowNmdPS2wvbksrMDFI?=
 =?utf-8?B?SjFHOWNPbXFZeFNSdUZrdUFEc0p0UklyY0FFcGw1ZWRzcHZrTCtidTk2VlBj?=
 =?utf-8?B?U3EyQmFxSDJkblFGbTFxM25vRWJZUkpFZFg3MkhJRU91SmtwQ1lLRkFTYnZ5?=
 =?utf-8?B?U0VWNU1BMUpvVEhzRi9xVWNyUGR4Vnp6V1JmTU55cGlKelZWTWMrS0NIdUpX?=
 =?utf-8?B?cHgwL0dldTRMV2cxMlBmS1U2TUp6SE90Tis1NnJ2U0k0dUQveHF2TEJNUmt5?=
 =?utf-8?B?Vm9lQ1NVTm15UEVUaFhwVGplcE1NTlZmYnFNMkFDQm8wbWx4clpIak55Ym83?=
 =?utf-8?B?dTVSSzhWd3l1VStmdWVINUNSTkNOSVpJOVdTYzljTU5FR3YyWDBjTDY0SFcr?=
 =?utf-8?B?ajkrRlFZRGU5ZkxxSERVYjZaMXd1c2FmK1ZWTTFiaWdEbzBiR2xyN1h6R3NU?=
 =?utf-8?B?eUptWi9oNUk1cmtLZ1RwdGcvaG9Pbk8zUjM0M3lHWWE3UHJlT0dBT1gyUHVw?=
 =?utf-8?B?UWI5Mk9paU5zV1ZDa1RHYkkvZ2hkcUFHSzhSY0Ryb0xoMk5TWlp1d0NPMUhv?=
 =?utf-8?B?OUtYYjRYWjBmL3dLcnZLbkwvRThKYUZRYlYwQVFWKzNES21FeFlWcWpzdTN3?=
 =?utf-8?B?aDgzN2ZNRUVabHd6aVpndHdZaHcrT2l2VzI1UUVHZkRlVWZXcVJGemRoNEpM?=
 =?utf-8?B?QXNUbTM2STBmT3l0d0xyN0ltNzlxRkhGSkQ2NXE0ZUx1V2RlNnlJWHZxOTJh?=
 =?utf-8?B?RUY5a0ZtRjIvRTdleXd5RWIzcXVCWmQ5ODRtTGhCRmpEMGZvWTlCUmN5UHhu?=
 =?utf-8?B?cUYycWUyanhuOFNWdXBPUU1XTUZWN0FVR2drWTBNMnMwQXM5VHhLdEhCRWFz?=
 =?utf-8?B?YVI0SVNKMnpia1pRNWc4TjBmYnBCL1ZCYk15RVVpVjJTNWIybmlha3RIWkNE?=
 =?utf-8?B?b1pycE8yVFoyNVlyR2NidG1OTzhyOUw3Qlk5R0JKc1BuelUyUVRuem45T3di?=
 =?utf-8?B?VXMzblRrWlNyeGVFUHVJUFNEMHM4dGZWU3lUbW1Ec3o3RjZjenhmczlQTVBR?=
 =?utf-8?B?WE5kdUhEYyt1MWt3NmVGZjZpUVVwK2xHZEV1OHFMUS9lT1Z0T2k0N2xuNm1r?=
 =?utf-8?B?VFkrNzB4NFBYdXFqa2VoOWZhTVRRU1J6SUYwSXQxMzZWN0xyWmV5YlduNTI0?=
 =?utf-8?B?djdULzJtUTl1dEkyZjRyUzk0RmNlVEV4RkxlT1NOU1ZhcDFlV2RkV200aTY2?=
 =?utf-8?B?bkVUMjJoRHVlaERVdXhkM0FMS2NCWHRlZ2tQYm9YWVI0NWh2UVBGNTRLVzEw?=
 =?utf-8?B?bDRQSmk2a3lJaHN4dW1BZTRtK2kyK05YV1ZSUmUrQ0oxNFlsc3E4bUtSUFJX?=
 =?utf-8?B?VXJKKzVzY1ZJWUNWRnNTa1pNekwvWXlXRkFRYlZaTmI5NUFtYm5mVlRqV2dr?=
 =?utf-8?B?SmFnM2FkZ3AvYlpHMVVBaXczUk9MaCtqOVUrekNRcjBNaG1UcWpuSjMxZVdi?=
 =?utf-8?B?VjlIWlRiQjFBVFNzTDFzei8ycUF6eFB1NFQ4bzBSRjNrVVdPSUFJNzlEbmcz?=
 =?utf-8?B?bDZjdXdNTTd2ZzhhcmJRbVNGYVFyU2JKN0pYMm9XZ1RicWlSSWZGVEQ5cW12?=
 =?utf-8?B?dUo4eDhTK1lQWElSS2Y0T1JwaFU3VTNIR0FuMFpNQnIrUHk4ZGpaVDU1eG1j?=
 =?utf-8?B?SENzVzJvNFVWZnE4Q2hzaS9YSTNUdVQrY2lONkRlTTd1OHR0NEJudTQ4SzZO?=
 =?utf-8?B?TTUxZ3N6aHlmZkV3MW9wdytNZERueEZ6RTVzWnBEVmtnME9UVytsazAzV3ZS?=
 =?utf-8?B?YXMwdzVYNHQ2SUtsTDIzN2Jnc0xEVUpzUFlBaTl2Nm4zdlJia3hGWTU5aisy?=
 =?utf-8?B?cXZLTFR5US9mOUlUN0RtMGdIVmlUUC9YVExPdGo3eGo1Z25NbCtRSnhuQlJL?=
 =?utf-8?B?dWw1dkdpZk5MTkhuVm8vSzdubldvNkhvZTM3Zm91TDZpMHVPQ25zcFZhNDQy?=
 =?utf-8?Q?v88vBGVrWiE9YNBs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20D3E464662282448AB1A8FCB29F3472@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TxQoEWbrHoZbKdyv1LgFWxewzeaKLndvzuTAMV9fy7t98nKlhgZMGUB4Xs+meDNURXfl+uG6/YwfG8MYQoDYVxFnXeTFsvs1V75cFe/zQnRSFmiNyagWrznPdQ38BdsqL2L7aASrSFAaHJqXN0oK/9AhSs06yRvuHKH8YCAY+hxtws1FdoQ29oJdBUsWkN9nXad9Zkc5BfXrVImiHSHW7s9nAU78CjTFoyOckVlvlV8n2IA54fITCFrJflPpxT/w0MrKF0Z95IQv3ZZFbsnvgsaCfgDC5Xs33EvDMD7kAOEFsmnAUKxGwur4fJiEypUZgW2ByXPBDZUzauGMf0YwdA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d967f0e9-5edf-4979-d6b1-08def8c9a518
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 23:30:07.4554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHWJ3671ku54/y+f1R9C7WEcBJwrtFRfDThIyqZy3NL1zOBoG63bRmqzS26M889TaPlCOqQZJVUjcad1MHa7w6mXaUW773wgrm9S8p4pDQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5318
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE2OjEwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IFllYSB0aGF0IHdhcyBteSBzdXNwaWNpb24uIEknbSBub3Qgc3VyZSBpZiBzZXBh
cmF0aW5nIHRoZW0gd2FzIHJlYWxseSBTZWFuJ3MNCj4gPiB1bmRlcnN0YW5kaW5nIG9yIG5vdC4g
DQo+IA0KPiBMT0wsIG1vc3QgZGVmaW5pdGVseSBub3QuwqAgVGhvdWdoIEkgaGF2ZSBhIG5haXZl
IHF1ZXN0aW9uIGF0IHRoaXMgcG9pbnQ6IHdoeQ0KPiBjYW4ndCB0aGUgVERYLU1vZHVsZSBleHRy
YWN0IHRoZSBiaXRzIGZyb20gdGhlIHJlcG9ydCBhbmQgcHV0IHRoZW0gaW4gdGhlDQo+IHJpZ2h0
IHBsYWNlcyB3aGVuIGdlbmVyYXRpbmcgdGhlIHF1b3RlPw0KDQpJdCB0b3RhbGx5IGNhbi4gSWYg
d2UgZG8gdGhlIHBsYXRmb3JtIHNjb3BlZCBxdW90ZSBvcGVyYXRpb24gb3B0aW9uLCB0aGVuIHdl
DQpncm93IHRoZSByZXBvcnQgdG8gaW5jbHVkZSBhbGwgdGhlIFREIGRldGFpbHMuIFRoZW4gdGhl
IHF1b3RlIG9wZXJhdGlvbiB3b3VsZA0KZXh0cmFjdCB0aGVtIGZyb20gdGhlIFREWCBzcGVjaWZp
YyByZXBvcnQgYW5kIHB1dCB0aGVtIGluIHRoZWlyIERJQ0UgcXVvdGUNCmxvY2F0aW9uLiBJdCBk
b2Vzbid0IG5lZWQgdG8gaGF2ZSBpdHMgb3duIGFjY2VzcyB0byB0aGUgVEQgZGV0YWlscy4gVGhl
eSBjb21lIGluDQp0aGUgcmVwb3J0Lg0KDQpUaGlzIGlzIHdoYXQgZHJpdmVzIHRoZSBmYWxsb3V0
IG9mIGdyb3dpbmcgdGhlIHJlcG9ydCBpbiB0aGF0IG9wdGlvbi4gQW5kIEkNCmd1ZXNzIGRlZmlu
aW5nIHNvbWUgbmV3IHJlcG9ydCBmb3JtYXRzIHRvIGhvbGQgdGhlIG5ldyBzdHVmZi4gQnV0IHRo
YXQgaXMgVERYJ3MNCmpvYiB0byBtYW5hZ2UuDQoNCj4gDQo+ID4gQnV0IHRoZSBvdGhlciBwYXJ0
IGlzIHRoYXTCoHRoZSB2ZXJpZmllcnMgYW5kIG90aGVyIFZNTSBpbmZyYXN0cnVjdHVyZXMgYXJl
DQo+ID4gYWxyZWFkeSBleHBlY3RpbmcgdGhpcyBzdGFuZGFyZCBmb3JtYXQuIEl0IHdvdWxkIGhh
dmUgYSBsb3Qgb2YgZG93bnNpZGVzLg0KPiA+IA0KPiA+IEJ1dCB0aGUgImdyb3cgdGhlIHJlcG9y
dCIgb3IgImdyb3cgdGhlIHJlcG9ydCBhbmQgcXVvdGUiIGFyZSBzdGlsbCBvcHRpb25zDQo+ID4g
dGhhdCBsZWF2ZSB0aGUgcXVvdGUgaW4gdGhlIGV4cGVjdGVkIERJQ0UgZm9ybWF0LCByaWdodD8g
U2VhbiBJJ2xsIGFzc3VtZQ0KPiA+IHlvdSBzdGlsbCBwcmVmZXIgdGhlICJncm93IGJvdGgiIG9w
dGlvbiBmb3IgdGhlIHNha2Ugb2Yga2lja2luZyB0aGUgcXVvdGluZw0KPiA+IHJlc3BvbnNpYmls
aXRpZXMgb3V0IG9mIEtWTS4NCj4gDQo+IE5vdCBuZWNlc3NhcmlseS7CoCBJZiBkb2luZyB0aGUg
cmlnaHQgdGhpbmcgZnJvbSBhICJ3aGF0J3MgaW50ZW5kZWQgYW5kIHNhbmUiDQo+IHBlcnNwZWN0
aXZlIGlzIHRvIHB1dCBzb21lIHF1b3RpbmcgcmVzcG9uc2liaWxpdGllcyBvbiBLVk0sIHRoZW4g
c28gYmUgaXQuwqANCg0KSSB0aGluayB0aGUgb25seSBwdXJlIGFuc3dlciBpcyBnbyBiYWNrIGlu
IHRpbWUgYW5kIGRlbGV0ZSB0aGUgU0dYIGJhc2VkDQphdHRlc3RhdGlvbi4gQmV0d2VlbiB0aGUg
dHdvIG9wdGlvbnMgaGVyZSBJIGdpdmUgIlREIHNjb3BlZCBxdW90ZSIgdGhlIG5hcnJvdw0Kd2lu
LiBJZiB5b3UgYWRkIGluIHRoYXQgd2UgKEludGVsIExpbnV4IFREWCBmb2xrcyBoZXJlKSBkb24n
dCBuZWVkIHRvIGdvIHB1c2gNCmZvciBjaGFuZ2VzIHRvIHRoZSBtb2R1bGUsIHRoZW4gaXQncyBh
IGNsZWFyIHdpbi4gQnV0IGV2ZW4gd2l0aG91dCB0aGF0LCBzdGlsbCBhDQpuYXJyb3cgd2luIEkg
dGhpbmsuDQoNCj4gQnV0IEkgd291bGQgbGlrZSB0byBoYXZlIGEgcGFzc2luZyB1bmRlcnN0YW5k
aW5nIG9mIHdoYXQgYWxsIGlzIGdvaW5nIG9uLCBpZg0KPiBvbmx5IHNvIHRoYXQgSSBjYW4ganVz
dGlmeSB3aHkgdGhlIG5ldyB1QVBJIGlzIGJlaW5nIGFkZGVkIHdoZW4gSSBzZW5kIFBhb2xvIGEN
Cj4gcHVsbCByZXF1ZXN0LsKgIEknbSBwdXNoaW5nIGJhY2sgcHVyZWx5IGJlY2F1c2UgSSBxdWl0
ZSBsaXRlcmFsbHkgZG9uJ3QNCj4gdW5kZXJzdGFuZCB3aHkgS1ZNIG5lZWRzIHRvIGJlIGludm9s
dmVkLg0KDQpUb3RhbGx5IG1ha2VzIHNlbnNlLiBBbmQgSSBvbmx5IGVudGVydGFpbmVkIHRoZSB3
aWxkICJzcGxpdCB0aGVtIiBpZGVhIGJlY2F1c2UgSQ0KZG9uJ3Qgc2VlIGFueSBoYXJtIGluIGVu
dW1lcmF0aW5nICphbGwqIHRoZSBvcHRpb25zLiBJIGhhdmUgZmFpdGggd2Ugd2lsbCBjb21lDQp0
byBzb21lIHJlYXNvbmFibGUgZGVjaXNpb24uDQoNCkhtbSwgbGV0IG1lIGZsYWcgQXJ0ZW0gdG8g
c2VlIGlmIGhlIGNhbiBhZGQgYW55bW9yZSB3ZWlnaHQgb25lIHdheSBvciB0aGUgb3RoZXINCmZy
b20gdGhlIG1pZ3JhdGlvbiBQT1YuDQo=
