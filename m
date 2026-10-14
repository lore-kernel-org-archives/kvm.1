Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18540801E;
	Wed, 14 Oct 2026 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002886; cv=fail; b=T+S75yY464EB89ECmVMROEM1ncHpjcBUWB0Bak+ZzqqhRONGFPA+t/x9W5EYyzML5AVZtuW1S314p5IELyBSvNKFunPV+RWM1LEQgxyAcnrJ19MbdBOAwI3M9EXf1wRIqqK/PBF3mLjS0LhGr4Opyzxf5it5P472N2HZBC26RHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002886; c=relaxed/simple;
	bh=yHmKrkzQuoH6td2lNJv4xrS1Qbfi/ypMQk3HXTjaKec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K0/W/PzgGgEd5wwPB/NWkfjD0xsPY0gnx1/ZkmrS4mxjYMdgicX+jNrmB7iMj+Sp0TKBa6xAqafvtyufRHXpe8dVslsA2ahR8cbBNYc2zcRAmxyoZARKcnvm/YcTqoTEWqygeRTy2BOitSmuvNzt9YBbc4YynhLS6n7U13CMI4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQsTmpPH; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQsTmpPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792002885; x=1823538885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yHmKrkzQuoH6td2lNJv4xrS1Qbfi/ypMQk3HXTjaKec=;
  b=GQsTmpPHkTYVD2ms5jIeuTYv0Sa/s18jjYqleRGBhmuux69AQvbR0eMa
   h55g90Cs9zgBDPngLtiqhiZvqg5L1yc39h/G0BClBeYpgVLTd5TEkUdty
   8/TU6h+gV6R8kMq51lC8G2N7heIkHHw1I0LCaSruUU8zBZZar3p4u3wjc
   AcVoDDhUhbhaebzMvS0TA13v2qKwvMpTB5HpN1MvGYijCAhZg00/lGTBD
   Y/9QjzCar20BQYN+AUkSeZNEEPJU4rvMWTfVwpyE8XBfbACzx0y+kzRn0
   7Hf2Jr0naYtHOgWwJo3Oiyef2zXfajWs+JKaa+SvVSvV0nQJSTXysoas0
   g==;
X-CSE-ConnectionGUID: ScKYHF9CQ0mDM2nl3vN4LA==
X-CSE-MsgGUID: mGaAe607T9uVljhq8K9/zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="638573"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="638573"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:34:44 -0700
X-CSE-ConnectionGUID: Fs6DI+T2SL6FIoYKZzmLKQ==
X-CSE-MsgGUID: M3P2ezbxSD2Hq5+7Zaw40Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1507587"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:34:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 11:34:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 11:34:44 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 11:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixs/J4Wyl8p4U20SV0heBKwhTKrw63R2YJZe8vy64KSUY1mc0717VcRxOVwqeEaUm0Y3zvishZ479/k6msIb1dq/gGFJqDcQ75uXB5Wgq5nxvieE9VNTcGbnNsJHp4NI0hIBiAjM7+N/FLbdTwCpTPPLLouf5LefvKnOgMb+84XL/kSe+fj7zONMamTaHd7Eyj/gGWg5tv0Z90NjgvOaUETPKnW1G/HZup1GwlMjS9NQzpZGOhcI4wDpMDp6CD3RJM/c1Zaunf6AgIgue6kf+MHhATdGwUAMiYDfAXFIWzZRsejAD+NBFLHtH+/z8Epy69blOKqklkvZpiLCneFYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHmKrkzQuoH6td2lNJv4xrS1Qbfi/ypMQk3HXTjaKec=;
 b=XlJiEYyLDKLu/mSQiiIolZZufiSNWvjqRIC3XcqKehu8bjPPJAreUDhfDRe4DRjyWoa9KX7Wuq1WHDCBcwwj1HzFWtuDCkZr6fTSUa4ruC/d/bGCqXugP9SydRzEfpRT3cOdFxh1/jOCU5GXIRDZ3e58XATTU20ChM4Vanue7v6+balyqZ0SwzicvwSAibRoUr+Icvga+rnK8CfUVb5VdJgEAWXH6HKWsscYRt4xcIrQleFBwiWgShMS3Pfl1IzbbVSuL/3beM6fnkD/SwmbvjUbAxF5+RZReT8Beg9t2mdpgFg+fkJDSzQ4WhbhD502mtzVrZW411j01ETx2duumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 18:34:21 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 18:34:21 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "nik.borisov@suse.com"
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
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAApaACAAhZUAIAA2vcAgAB1o4CAA+N3gIACbDEAgADZdgA=
Date: Wed, 14 Oct 2026 18:34:21 +0000
Message-ID: <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091035.15599-1-yan.y.zhao@intel.com>
	 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
	 <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
	 <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
	 <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
	 <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
	 <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
	 <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
In-Reply-To: <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6781:EE_
x-ms-office365-filtering-correlation-id: 21749b16-b88f-478e-28cf-08df2a21c380
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|6133799003|18002099003|10067099003|22082099003|5023799004|11063799006|4143699003|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info: ChdUyDUrwuMN3RFpYqA/Mog11yzfBvHKo+0V+qDfLTQQtrTXUIU7jHMGPHwO+BmpVwXK2eMCL2CzrBNogWsi5tP5+A457+iAuFT1Uroj7UTx0EPmqTmE4g7rA6RqXlukWT0trw00OW3gnTzqvdWFolEZzU7Z/slvPcCNwM0YaqRVTt9Qd2eTSlrkhg5TBvh5AEFcC0+rXZt2q3IqoKAEleEOvN+uut4KKKvKebYZmTiIRtfEwXMwFKqnFmaB9OUduTzsc9uSvnNO2QuwJRdgd0jMXlABQPUswmy6irgdk441OupOG5NjxcPuMdJqCwAHXzzcOk0S3BmmU8HL+WjBS4Zut2UBCyXL6MEZHexjXp6IWnwL8y7flmKtQdEtrNUiOECJ/XKzSgxtAF9e9ukeRiDgCq7VMkl0qduY0b9i920jqn8TCDMXOjGCmEYFlCWuLKvFn5FocVK5qhDun8/LUq5J3fml/F6y/9SxlSvBj5xK3eH/Bjq76Js9Xi4yamiFq69WXPdhw6YyOfueSzf0mKfYGzZok4GeOCKbMA2wM21pNhPXOYPHYBChy2sKSMjpKfZ383GCRvWF1eUt2Htj1GejQ3rQwie6RGINPnllKa63PMMJamYO4nL92jCRQNu/uyEBLF5V59UDYGS7Nl8AvhbvOcfo4ZfZaqoqSbCFxVc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmZXWlVPSUlnQWZoYkJrWG5JNXlOQUlNT09HZWdGTDZIclNjTVVqTnkxcEVk?=
 =?utf-8?B?aDcyalhBSk13TlFqU3RkQnE0aDExZWNjWnZvK1FOdzBLSm03QW45L2twM21C?=
 =?utf-8?B?Tk5DRGRTVnBiazJxU1NHYm0zcS9wTzdTeXZMVUJZYklmcTZOWGtSdy9KakdZ?=
 =?utf-8?B?WGRTS3Q4dzFGNWVqMHVTcWFLQy9kelVtell0ZjBkM1dnbGQyZWJKZmg4MVN0?=
 =?utf-8?B?aFFneE9rWkIvMVVGK29uT2I2anpnTGNNZWV1TUVlTTE1NHlKb0dOdDRNWnU3?=
 =?utf-8?B?ZWgwR25OYUFnZWtaRE1SWmJhbnR0amY0SDVVMmoyZWxKN0RZYTlCcmk2WG8y?=
 =?utf-8?B?TnhmSlBOejlrMXl5N2xFWVI4RnBFamVFNzlWVGQ5QXdHRnFqWkcrME8wMUZN?=
 =?utf-8?B?bVQvMUduMG9PaDRPUGZNc2ZTWjFCWDJLSTBHTjhmWWw4SVhxRzlxSUc4eGxt?=
 =?utf-8?B?S3gvT2Z5VlphaTE3WjdYTDFWdlhRdXZlM056aE43WUlNNFRBd1E4VzJQcjRk?=
 =?utf-8?B?M2svNC9NOHVJaTFJMEJkM3hRQjJWZHZRZmt4b1k2K3VlNXBsUW5SZTdZRDFS?=
 =?utf-8?B?ajJEZmF3SVFFRnBFekxzYnRnODZlcnZ4a2xVWUFhQW1nTDlLcHpMMEZ6VVgw?=
 =?utf-8?B?SkxSWHZaRnNpUm00NExPQjd4Z2Q3QTFOWldNRUo4S3hEK0NEL0p3N1ZGNm5k?=
 =?utf-8?B?Q0E2cVlEYVVCYUF0MEJ5am9jTXZwSDFWa1R2S0pqUVBDT08ycjVtb0pBQ2lo?=
 =?utf-8?B?NU9MdVlvZnBaOXAyVGw2UXJFa0J4WUZFM2pwTFMzWUZUNkZwYjQrSmRDVGdY?=
 =?utf-8?B?M1FrV0V5Rmc1MTlBejNydTNROHNKMnFScEdzYWFtVEU4akQzSmRBZWdZSkZL?=
 =?utf-8?B?NlArMkZGUEFMKzd1a2pzSmFrVCtLNUNPMFRtTXNMSnl3RHBtN2lOdjdETWxS?=
 =?utf-8?B?L0h2WlE2SmhnYWcrYmlUWEhzekQxeTdqMVJmRkJOdU9US3dGWjJIcS9Neita?=
 =?utf-8?B?aFhKb3lwekF2YS9WaXV2enJOdDlCTGdrU085T2ZmM01CbmlIRWd0ZWc0YmZJ?=
 =?utf-8?B?S3RGUTZoUDIzV1lKTG5GOVZET3FGMkhEZFNWUklQYXIyYXhNUEEvRWtQOCtD?=
 =?utf-8?B?VjZ6aGY5WkswS08vN0lqSFE4b2ZFd240WTA1NGtKSGVpSDFmOVJjSUx0anZG?=
 =?utf-8?B?RVQ5cW9GbEdsM1NDZzJtM1ZQMzcydmgydEE2RUhWcU5UVEdyWVQ4OGdNaFdV?=
 =?utf-8?B?ZHFZVGx5YXRNS21oK0tudFJlb1ZiQVJ4dUtMNDlDejhDYlczK3ZndSttb0Ur?=
 =?utf-8?B?eURZd2NFM1JpR1RwaHF4NVJSaXdrZjZ4ZllsNU9MR3gwTGRXZ2F6Zk1zdUMv?=
 =?utf-8?B?c1NFSnZoYWYybjV4SFdzcHowOTVDSmtPUG9QTk5JT3krT1dLd0FtYVhoQUor?=
 =?utf-8?B?Ti9RZmV6SUc5cE1mazRlTzJIR1JZNlAyZThlZEMrekdjS3pPckREVVZieWc5?=
 =?utf-8?B?dExwOW9ZUFp6eVVRRXU2SjRTRld3UWE4SXlSQ3k2Z3piWjhkTU43N3g2T1RK?=
 =?utf-8?B?WjF0Y29GUlgxaXNGajdaTW1ha1RURTNKTWE4WWZqZ3BoZVBvRHRaTStTbDBr?=
 =?utf-8?B?Uy83NGp6aUFYWnlVcVdoUHE5ZGhVTXFzU0RWOXJUSlBmWDBQM2Myd2FkNElx?=
 =?utf-8?B?OEdORjBaOHFuY1FuMnRBU2Vrc0Y2ZEF5cytCeGF3Ykt1WFhKd01XenZiUzhB?=
 =?utf-8?B?YXROMktYR2dZakJjQzlaSEw0UWw1OFFmQ2ZBT1pPVWtoOXFGTWx6T1ZyZEdM?=
 =?utf-8?B?WC9PdWFoejczR3h1dzVyaWJqU0RZS1pHNEdKWldFd0k1TE1BdHlzWGZNOWVB?=
 =?utf-8?B?N0x5TlcxakZrNEowbVJFbDBrVHBOUGkzT0c5Wm9uNFptNlZpckIrQ3BYdXVy?=
 =?utf-8?B?WUhDcDhLQUx2U2tQL3hMVk9lTzZFd2NvbWRmN3NLNVp0TVJ0eDVPZ2E2SWxZ?=
 =?utf-8?B?SEk2bHgrRElKYVRTSzBIMTh5LzhZUm1MRzdBS0REOEVCYnNaQzBRMlVEbnZQ?=
 =?utf-8?B?Z3Q5bStDRHYybUV1MFJEQjJnb3Z1K0dnanV5WXdnbnZ2VHhCYlYwRzR1d0tO?=
 =?utf-8?B?dUIvSUpmdThkUjBYRHErV0JsdU4rRkNxZ3NKVjF4T2lSckZ0VEJYVEhYQnJo?=
 =?utf-8?B?UVFqYkRXb1g0T2ZnelpEd3ludWRvOHBMUFlvWjNPVmd0ZGhENjlhdENqRTIv?=
 =?utf-8?B?OWFWbkhrR0RnWGtyMXBzSW9iRnB0L2VjM3gwTjVRczhscDd4d00zZEJoSm95?=
 =?utf-8?B?NFlEZmFSRUM5VGJLczJTWnFRN09jb2tBSnhmSkNiKzgrbEduMDJoQUVqS21x?=
 =?utf-8?Q?49gd82DUzwvf+EXY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <263ECC087DB3B34E97C9067D2012B924@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wq400A3fkNshn9uKF6nC6KpyIeEEezAkqvEzZRRCy6A4YxG/u1ohdhrDtIGLAz3vjU+r2+3akn/0C1iwt78n1uMP/HvOYHQN63l3BYFKzd+RMXDrKzF+/umLMJxCJmSMn7yNi3HgHK0QO0UIcw94Dr7l7o74UtLZC4/S55Os5FZAhrg5DDSW8CgSV7KhLqU5YusXcBku7ShARMeZQG9260CdM0F12UdDRwLCeW455f6sSNS5PHDHZZTN/jzt6bMpcgWYw8VATGrryqkPKzUfuF9UwPG1QtVAKeP02d7gqU4ycC384h1u3hAyN9XrOog058oSEsB4X97vojhNTlEUaw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21749b16-b88f-478e-28cf-08df2a21c380
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 18:34:21.1764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nOT7T+IR4fzB+JE+4Sj3nvXwHmWe8l1I/+VHXD2aPOlmqS26L1QhrFnefYe4lcxY1I38VwrEZTSikhqsE6lljV0+5dhdcduJOQg1ZEzAHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTEwLTE0IGF0IDEzOjM2ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBU
aGUgaWRlYSBpcyB0byB0ZWxsIGV4dGVybmFsIGluZnJhIHdoYXQgdGhlIGZhdWx0IGhhbmRsZXIg
bWlnaHQgZG8uIEl0IG1pZ2h0DQo+ID4gYWRkDQo+ID4gYSByb290LCBpdCBtaWdodCBhZGQgYSBw
cml2YXRlIGxlYWYgYW5kIGl0IG1heSBuZWVkIGV4dHJhIHNwdHMgYmV5b25kIHRoZQ0KPiA+IHJv
b3QuDQo+ID4gVGhlc2UgYXJlIGFsbCBjb25jZXB0cyBrbm93biB0byBtaXJyb3IgRVBUIGFuZCBh
bHNvIGhhcyBhbGwgdGhlIGluZm8gbmVlZGVkDQo+ID4gZm9yDQo+ID4gdGhlIGNhbGN1bGF0aW9u
IG9uIHRoZSBURFggc2lkZSwgYW5kIGFsc28gZG9lc24ndCBhc3N1bWUgYW55dGhpbmcgYWJvdXQg
VERYDQo+ID4gaW1wbGVtZW50YXRpb24gZnJvbSB0aGUgbWlycm9yIHNpZGUuIFRoZXJlIGlzIGV4
dHJhIGluZm8gcGFzc2VkLCB0aGF0IGlzIG5vdA0KPiA+IG5lZWRlZC4gQnV0IHRoZSBnYWluIGlz
IHRoYXQgdGhlIGNvZGUgb24gYm90aCBzaWRlcyBhbmQgY2FsY3VsYXRpb24gYXJlIHNlbGYNCj4g
PiBkb2N1bWVudGluZy4NCj4gSXQgc2VlbXMgc3RyYW5nZSB0byBtZSB0byBoYXZlIG5yX2V4dHJh
X3NwdHMgaWYgcm9vdF9zcHQgaXMgZmFsc2UsIGluIHdoaWNoDQo+IGNhc2UNCj4gbnJfZXh0cmFf
c3B0cyBhcmUgYWxsIHRoZSBzcHRzIHRoZSBjYWxsZXIgd2FudHMgdG8gdG9wdXAgZm9yLCBzbyB3
aHkgY2FsbCB0aGVtDQo+IGV4dHJhPw0KDQpDYW4geW91IHN1Z2dlc3QgYSBiZXR0ZXIgbmFtZSBm
b3IgImV4dHJhIj8NCg0KPiANCj4gQWxzbywgaXMgdGhlcmUgYSBjYXNlIHdoZXJlICJwcml2YXRl
X3BhZ2UiIGlzIGZhbHNlPyBJIGNhbid0IGZpbmQgb25lLi4uDQo+IFNwZWNpZmljYWxseSBmb3Ig
dGhlICJzcGxpdCIgY2FzZSAocGF0Y2ggNiwNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjYwOTI4MDkxMDA1LjE1NTY3LTEteWFuLnkuemhhb0BpbnRlbC5jb20vKQ0KPiB3aGVyZQ0K
PiAudG9wdXBfZXh0ZXJuYWxfY2FjaGUoKSBpcyBpbnZva2VkIGluIHRkcF9tbXVfYWxsb2Nfc3Bf
Zm9yX3NwbGl0KCksIGhvdyBkb2VzDQo+IHRoZQ0KPiBjYWxsZXIgKHRkcF9tbXVfYWxsb2Nfc3Bf
Zm9yX3NwbGl0KCkpIGtub3cgd2hldGhlciBwcml2YXRlX3BhZ2Ugc2hvdWxkIGJlIHRydWUNCj4g
b3IgZmFsc2Ugd2l0aG91dCBURFgncyBzcGVjaWZpYyBrbm93bGVkZ2U/DQoNClRoZSBwb2ludCBv
ZiBzcGVsbGluZyBpdCBhbGwgb3V0IHdhcyB0byBtYWtlIHRoZSBjb250YWN0IGNsZWFyIGFuZCB0
aGUNCmltcGxlbWVudGF0aW9uIGRvZXNuJ3QgaGF2ZSB0byBhc3N1bWUgYW55dGhpbmcgYWJvdXQg
dGhlIGNhbGxlcnMuDQo=
