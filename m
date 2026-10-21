Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792621702;
	b=5T28kCjAMgsu9C/X053gsQQ0YUpaaH2V028aY178z8A3fopNasIKoQ1e/2egO5PBBKQY
	 BszmclB4hIGNJ8KBVE1rmp2mM+COLgJPX2QQ8rJrAoJcCcXFNCZ1xZlITBQ8HZecf5je5
	 f1WBYHJ9x+eLLdmJu2IXV1KnIEPmf36LeoxNQt77ZtkilIa1dJ1FmnQPLiIEXmAc5SCSk
	 08diNFejLqhmcfSJkydcP/zJeaKwdUIyBNw6cpcksd7AeXA96k+4W797vxNQSjYWXec8e
	 0G3bEA4w4IZzOfC9/ITB26I7oR5zEek8UmrdP6VFTgchVuQR6xZlH72opgKmfpTxKEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621702;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Eo6jVEYfMO8cnWBe7ZEy2lH6HvUHbfogfFfa1fUw5xk=;
	b=K18G3Lm7beUcdk0Wvz3B3bHdblEiSzXc2fvrF41RyvdL4WADf8oSo9rRAXx1HJhPS6qn
	 2unYfNSmRI2P9h8e8fCU0QEs7A5AVJP2r0eBKLncGtO7dFU8MWqgQd0o395kpMI6YrElD
	 VeS9pgt1KZ4hvnxmPGbKrtfCAZ+qWPOfy9AiYf3OEbjsmjwSvdic4Cl/fx1mXwKJxerfk
	 38yjoEW+CddyMYyzehyutlrZqha12SrGgeaNTKcanmUb8t0uphMYwbsDlRXQej6m6JjPj
	 rKmtp6wDaEQYqn2GoFg81qZYosyCeRz8KCjpXXPLG4dsUeHXzFcQrME0uyWWGDRKFPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aI73AXkZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520C606A319;
	Wed, 21 Oct 2026 22:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9520C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aI73AXkZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792621702; x=1824157702;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Eo6jVEYfMO8cnWBe7ZEy2lH6HvUHbfogfFfa1fUw5xk=;
  b=aI73AXkZubZBL/8knDUimj1viRbR4EPdUiRfUt2Iy9qJGB7R2x88kvWu
   DiRdRQNh8TDNMANV+qIL75XZ8azsVsY48kb4Lt2KPviT0wMlQT+2B7YvJ
   6e8J7W+9JgR4NtwwgqUtBYw0edzInfYCvp5mKLXbMQDJ8qUY/MUM7Z1Jh
   RNi5HtQx37dEaTExtLn107DLx9p7VPRcNbmXW2MfXYddnMxJRg1bIvad4
   ZUETpeB+KxpZMGvED0/vdrfrn40vFCDQ/O5yS8TpkHfhe/A9pURYmss6g
   MYifZuiH0jQrnVlNHFLcC0AhMs6UlQUwKe5JP4ccGAjSXnc/zg2NsvrZK
   A==;
X-CSE-ConnectionGUID: 37Ot58O0Tjy1XT61EyCtyw==
X-CSE-MsgGUID: MvHu+igJQsG8OXjvRJYGKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1243229"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1243229"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:28:21 -0700
X-CSE-ConnectionGUID: z2tJ6w7jTyes6HkK7pivWg==
X-CSE-MsgGUID: k/i2XtUMSgubnUWDQ+O6tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3599217"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:28:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 15:28:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 15:28:19 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 15:28:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9ouAZiaar/SF0F128XK6QBObK072d4axLXOgXbVcf+h8qVck1Lt8DNPBUfZ2DPX7hqt3Xrld1hzVieOco/d/Gh5L4uMEZC18l2Tf2gbkjYM/JtJ5NDoQEOvy3/dT7O3xZdqT60E5n2fMqjOOy+n9uWZVpr8BO9iO7XRjVNrWTCbC6+Argfmr2m9Ae5pt6Xry8j7AbSvk3A2EUY+m9SqgA6eZ2vFimsLfrI1kdjypZXJNdgk8clVFw71WLS8fLB65OLwwe+8KvSSBH2hjuoaX9UJDc/BVIMMescSPaxUW9x2z67sNEKBwPgQ257K71Gjme1kiblcf+9Sh8CGvvb2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo6jVEYfMO8cnWBe7ZEy2lH6HvUHbfogfFfa1fUw5xk=;
 b=tUEe5bK3tIHpIWb7xH4VpGYfZ6e7gQlNu2XYro5XnmNWItQoK+szk9dQ/daCsj2BEasGBAch9jJri2HvJWWFvDZ9cj0trBLYwHuJbp88371igkegPNfV+WLvoAALjiEvtXksnPusZHBxsXdDTVJqpivpg8vqatXz7sva0eA4vofO5z9WOSVWVJJoLPSp75uNBkxWRy8v3ZmA40/+HWWDgpzZ9NaRW5TmMqrKZd3GpfI21JHtR9T6t5uO+olBwP84Qo9iEmaxf9wyI2eTqW186I3+F3TF5pOvZW65GiaqH48A690li3+Ycc80365zoNw6JYpm751h8ZbA0o4Wtf04Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DS0PR11MB7264.namprd11.prod.outlook.com
 (2603:10b6:8:13b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 22:28:17 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 22:28:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
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
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAApaACAAhZUAIAA2vcAgAB1o4CAA+N3gIACbDEAgADZdgCAAKsxgIAA0reAgAVHxQCABHwBAA==
Date: Wed, 21 Oct 2026 22:28:16 +0000
Message-ID: <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
References: <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
	 <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
	 <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
	 <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
	 <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
	 <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
	 <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
	 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
	 <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
	 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
	 <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
In-Reply-To: <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DS0PR11MB7264:EE_
x-ms-office365-filtering-correlation-id: 83c8c805-8693-4ada-2d34-08df2fc29a5d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|261021121427099003|6133799003|22082099003|18002099003|11063799006|38070700021|4143699003|261009223027099003|10067099003|56012099006;
x-microsoft-antispam-message-info: hmJ68nt7dTClcV1+ZVzYkgrbxDRzdV0pZXfyjsLiJlyk3ilA1bmuhFIXdRaiR/1arlunPe2c+oYuphWE47H47AlkA/A+CuA1jb++zSyOm/xL3yxKxAe7C+bsj92YYYDg2Vkhf49jclKzkjV4MEZohdtvFxY9T1P7pId+vZCdeXPUPM0ZMcqepzd2YB/NeBsdkhZvCDKc7/a12beGC54EtlctwT49f+adZbUugf3vJkhnDv4vF6SiZfMkBjZGLWKByMZcwrTFA47c+07kXEtYmzpF8BsS2pCyz0SojvzUhX/3ivedSzkba+1XLBqSG9dQvv17inPwHMCkbnUy2MxaDz4zX76L0g+BjTG84doB7pDhMnIzsjH8bWlGE/YaeaGYh+LPT1Bs6hvRaHpsLfi7aWW/Ov5Z0QD0YCdYuWuly1E2q8jyUW6Rt1FYx3+cnf0CaYqqo/TZ/og95TnPowImPu2WoDibdl3LXXBdARfi0UKLRB+Zk3bkEZGIMHDXBAV2SXk5m3xe/1LySFhygvFkwVUy3LBqPmZVvNKifRI7a7VzK00cPFMghPGZ99WF1ORx0i9uIhJoLzA25BjsJ+d72IqhSjpXD5hQAdOqxwKpHcbIMUsjzs342hhOGzAnIvh5hSWSiCinRPKwbfylj4crLJgzeXhDvxGbHxO7h7nh8Wk5rHz/pwkAv8kOSXaZMGwa4McxI00HjE+wqh4bpDa3yAaVD1fE/4q83JV/uygGE6Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(261021121427099003)(6133799003)(22082099003)(18002099003)(11063799006)(38070700021)(4143699003)(261009223027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVFBelZYSkRucmpleHJsK3FPN3BJckE0a3dzTHp0N0IzVmUzRENqQlRLamVq?=
 =?utf-8?B?cW53dzFYVWlXdjhneEJhbTJnaXpid3dJbkJ4eDh6bTRHRi9Ub3ljelFqREZ1?=
 =?utf-8?B?Z1BOSUYzRnNaVkZYTzFab0c1UWlhVzg1SVFPQS9XRkhqRHMrRVpZL0syaUJo?=
 =?utf-8?B?d2prQTBZU0dwTXY3WFhhaVFsZnlyREY5UC9reW1TSzNBdVR2cWhZc2wwNm9I?=
 =?utf-8?B?bkQ1Q2RDNS9EeFRSRkhDdlBHcTNkc0h4WVhhaEIrMmRMT2dNckNEVk1nbGov?=
 =?utf-8?B?SjB3UGljdEFwUUM0eHJwSDBLV1E1QkhVZjFLS1MxVkFpUHl4RDBWc0l4b293?=
 =?utf-8?B?SUZ5NlM4Z3MzclVaWXpZVHhFTnZFcjFoUnQwZm5oMmRHQzVxU3QzaHFDZUZj?=
 =?utf-8?B?anJEZUtoZnJSZTE4RFhEWUNNMzJSYjdBaXRDUktJd1ZhMTA5aHN2S1BHeUJw?=
 =?utf-8?B?eWJpVE52dkl6YmZ2Y0VqTzcxQ1JmZFJncWhlZnhxOVlwMjMrWnR3Q04wVU5H?=
 =?utf-8?B?YnptRzA2VGtqNk1iR0t0Ti8zQ3N6SmhCZmc4clJlQ0E3Ry9ISVFicGR1MVlK?=
 =?utf-8?B?VUE2L25WSHlOWlFhNy9GaUV6YktRcUhOelYvb3JsMUtSMmNIWEMwbW4rVUQr?=
 =?utf-8?B?T0lnbXhpMXRmRDRYNmpBVmFISFAzQzJkaDN3QVFkUkd6T2gveVFmOFV6VWVQ?=
 =?utf-8?B?czNjMDkvTEszS2E0WVB4SzdXdUJtZ3lVSTZoVGVIVDkrQlZrc2E1RmxvZi9u?=
 =?utf-8?B?MEs3SlR2dXVCSXBaTVUyTHhGaXpMa0g0c29hd3M5VmhsSzRJVHZEaXBwN0VP?=
 =?utf-8?B?akxTL2tqN0JhME8vZmFtT2pvdGU0c2ZLUWcxZmhRNW90TEFqYS8zd1h3cGhy?=
 =?utf-8?B?b3FpYlU1VHB3ZGE2S1U4Ukg4eHc3b2thbUhXNk1yVEZicHlZUmh2RDcvT1hZ?=
 =?utf-8?B?cTFRSGV5ZlpyZlFlRUViUXd2Njdoa3JOaVd0R1dtMVFNYjZwSDEyREc3NjV3?=
 =?utf-8?B?dkovQUM1Z3cyeDJRMThlUjJzM1NlNGVsb09MVklDQUpPb21QeDN5RDJ1TUt0?=
 =?utf-8?B?WTdWMDdoaFpMUnhxMjVFdUcveVdPdkNCNmdJVGJzWFhwb2ZvbkloNitJNDhQ?=
 =?utf-8?B?ZVVnS1R1ZW5FbnNJQkk2MENERVZHRDY4cmZUL29uOHlSeWVHai9tYjBQd3o1?=
 =?utf-8?B?TmVLQkp4WFMyV25xZ1QrbFhNZ0l5ZHhhZkhWeGQ3MFRWS2Yvdm5wT01NVU9L?=
 =?utf-8?B?d1JJTVZTWmFncklSbldwK1VCaHVGTGVnNmhpV0JLbXc5K0taU1hteFRKakM1?=
 =?utf-8?B?RGUyd0ZqU1dRdnlxN1JIVURtRUsxdnFlMFVMUWNsTEZjVkJHVmFuQjJaSFo4?=
 =?utf-8?B?eUx5STZQUkdFVDZKMlh5TFZLd3BNWnNjQ1hxZGNpTU8wcGQ5a3VBSUUrZzVt?=
 =?utf-8?B?aEdGRmQxbmtPdWNhZXVHdFdVUUZyWjhML21BaWtxUlVVSnBTZnkvQVd6dXNu?=
 =?utf-8?B?cER6NHFwRVE2UDhGWHUraEJDb2ZPaTFBa3pYc2RpM29ZWlNrZVdXMTlrV1ZY?=
 =?utf-8?B?Y2k1MmZmbGNTaUVOeXFZVXY2VndXWFhlWFpVRUQ1Z3hWcTFpVzQzb1JURC9a?=
 =?utf-8?B?dTFtMWF5MDg4ci9uZ2RybEJXMnZNOUxQM3M2QUJUS2NVYXpkaE1kR3lmM0hB?=
 =?utf-8?B?czVibURPdzMxYXBpTDNQTnNyOHM4YWV3MXpMOVhqdktvUnpDV2JVcVh2Y05D?=
 =?utf-8?B?VGZ0RGZtOTNiY0pUQTMyaFhnOUlQY2pndUUxVHppczdOd3QxanZKKzJBRnAv?=
 =?utf-8?B?R2M0OXFiNDlSZTZ0NDl6ZUFJQ3hMT2hPZnI2T3dnbnI0Y2hSKzI3TUN2VkVY?=
 =?utf-8?B?WWNpS1NlWWI5Y2NWQk10c1QxeGMwa3I1a2NQNm5sS1ZDZmtIQmJTc29MMGdj?=
 =?utf-8?B?cTF0TVNYSGRwKzdMRmlvRVE1T0I5WThhZVRRT0JVN0UwRk51UWh4VEd6Y2ZS?=
 =?utf-8?B?U2FiTVVWLzNBSzNvRHZ6UWNvcHpISm94V05WVDdPV20wa0Zob2psUmVNcFVz?=
 =?utf-8?B?WlU4anVpYWVRc0VJL0MwbmZFcG5MSktTQTVQWS9OaStXMXZQWFlaQi83Vlg1?=
 =?utf-8?B?akZCaFdlTERLUHM4dnNTTDh4ejZ2SVFScEVnRFhvZStMd3VsNTk2RDBOSzR6?=
 =?utf-8?B?eElmZndabnNxSUhYTTVFS2lUa2NzdFFWVVpxbUp1OWYzbUQ1SEE1dG41QWVw?=
 =?utf-8?B?c3pPTzNodHFQUGlHK1hybmMzbkxIYVdIMElnUnNTc0hPR3FYR2VpMHlDTWo0?=
 =?utf-8?B?NVB2YmlDdHNsOCsrVnF3VGdkbUV3bzVWSG1mNXhFeGZEaWYzb0VjWVhVaFdu?=
 =?utf-8?Q?cTBrhlQJajsM9CFk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5CA6C500E1F26408DCD99814137A752@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BKvQSWtAM0576NiTrtpctEeBBDkoAQep0HlzwfFJO3AULg8/s80+z2kC3K3uOoQ0pZQ7fOtSqBfd2c4Xx4mvpwPaPN87S3oOHRsCvwb0jxEbP5wQqWSEOH10HtblpuVv9HMVxVoOR7J8XjIzwHiCgVASsKaLdsYTzBJQBlqPeVC6H+s0SLbblJ9sHwtRY9aUy6erewft+TmOBDPSXm+tSxtFYCAPzg8a2SksIkiWmMXnIayVON0Aym+iCPAHDBZVlZFQYfl7UKa90cp93/8GyEmiGAmsoNJCWq8LkQAFrxZdzIb//Khyryrbd1MmWXAgmBBQxOLgm+sFy5PHF0/BVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c8c805-8693-4ada-2d34-08df2fc29a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 22:28:16.9286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRuQRAP/x+mnmvADZpZPIiyLuMQxmnh3gnWGQz3GsUJ8XTJDhlRYwUyA84cc6trq4+DSAWLscPjBTIp86WyxsEwYfd5oSJpCWGoNXK5nx8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTEwLTE5IGF0IDA5OjU5ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
RnJpLCBPY3QgMTYsIDIwMjYgYXQgMDE6MjE6MTRBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gVGh1LCAyMDI2LTEwLTE1IGF0IDEyOjQ3ICswODAwLCBZYW4gWmhhbyB3
cm90ZToNCj4gPiA+ID4gVGhlIHBvaW50IG9mIHNwZWxsaW5nIGl0IGFsbCBvdXQgd2FzIHRvIG1h
a2UgdGhlIGNvbnRhY3QgY2xlYXIgYW5kIHRoZQ0KPiA+ID4gPiBpbXBsZW1lbnRhdGlvbiBkb2Vz
bid0IGhhdmUgdG8gYXNzdW1lIGFueXRoaW5nIGFib3V0IHRoZSBjYWxsZXJzLg0KPiA+ID4gSG1t
LCBidXQgaXQncyBoYXJkIGZvciB0aGUgY2FsbGVyIHRvIGtub3cgaWYgcHJpdmF0ZV9wYWdlIGlz
IHRydWUuDQo+ID4gPiBXZSBzaG91bGQgYXZvaWQgbGVha2luZyBURFggc3BlY2lmaWMga25vd2xl
ZGdlIHRvIEtWTSBNTVUsIHJpZ2h0Pw0KPiA+IA0KPiA+IFdhaXQsIHdoeSB3b24ndCB0aGUgY2Fs
bGVyIHdvbid0IGtub3cgaWYgaXQgbWlnaHQgbWFwIGEgbmV3IHByaXZhdGUgcGFnZT8gVGhpcw0K
PiA+IGlzIGJhc2ljYWxseSB0byBjb3ZlciB0aGUgKzEgcGFydCBvZiB0aGUgIisgMSAtMSIgaW4g
dGhlIGNhbGN1bGF0aW9uLiBJIHdhcw0KPiA+IHRoaW5raW5nIHRvIHNldCBpdCB0byB0cnVlIGZv
ciBub3JtYWwgZXB0IHZpb2xhdGlvbiAobGlrZSBhbiBhY2NlcHQpIGFuZCBmYWxzZQ0KPiA+IGZv
ciBzcGxpdC4NCj4gSW4gVERYJ3MgLnRvcHVwX2V4dGVybmFsX2NhY2hlKCkgaG9vaywgdGR4X3Rv
cHVwX2V4dGVybmFsX3BhbXRfY2FjaGUoKSBhbHdheXMNCj4gbmVlZHMgdG8gYWxsb2NhdGUgRFBB
TVQgcGFnZXMgZm9yIGd1ZXN0IHByaXZhdGUgcGFnZXMsIGV2ZW4gZm9yIHRoZSBzcGxpdCBjYXNl
Lg0KPiANCj4gSG93ZXZlciwgZnJvbSBLVk0gTU1VJ3MgcGVyc3BlY3RpdmUsIGl0IGlzIHVubmF0
dXJhbCB0byBzcGVjaWZ5ICJwcml2YXRlX3BhZ2UiDQo+IGFzIHRydWUgd2hlbiB0ZHBfbW11X2Fs
bG9jX3NwX2Zvcl9zcGxpdCgpIGlzIHByZXBhcmluZyB0aGUgbWlkLWxldmVsIHBhZ2UgdGFibGUN
Cj4gcGFnZS4NCj4gDQo+IFNvLCBJIHRoaW5rIHdlIHNob3VsZCBrZWVwIHRoZSBjdXJyZW50IGNv
bnZlbnRpb24gb2YganVzdCBzcGVjaWZ5aW5nDQo+IG1pbl9ucl9zcHRzLCBhbmQgbGV0IHRoZSBU
RFgtc3BlY2lmaWMgdGR4X3RvcHVwX2V4dGVybmFsX3BhbXRfY2FjaGUoKSBhY2NvdW50DQo+IGZv
ciB0aGUgKzEgcGFydCBmb3IgZ3Vlc3QgcHJpdmF0ZSBwYWdlcywgd2hpY2ggaXMgaW52aXNpYmxl
IGFuZCBzaG91bGQgbm90IGJlDQo+IGV4cG9zZWQgdG8gS1ZNIE1NVS4NCj4gDQo+IFNvLCB3aGF0
IGFib3V0DQo+IA0KPiB0b3B1cChib29sIHdpdGhfcm9vdF9zcHQsIGludCBtaW5fbnJfc3B0cykg
Pw0KDQpIbW0sIG9rIEkgdGhpbmsgSSBzZWUgd2hhdCB5b3UgYXJlIHNheWluZy4gQmVjYXVzZSBl
YWNoIDRLQiBwYWdlIHdpbGwgYmUNCmNvbmZpbmVkIHRvIGEgMk1CIGFsaWduZWQgcmVnaW9uLCB3
ZSBuZWVkIGF0IG1vc3QgMSBleHRyYSBwYWdlIHBhaXIuIE5vdCA1MTIuDQpCdXQgdGhlIGNvcmUg
TU1VIHNob3VsZCBub3Qga25vdyB0aGlzIGF0IGFsbC4gSG1tbS4uLi4NCg0KWWVhIGxldCdzIGdv
IHdpdGggeW91ciBzdWdnZXN0aW9uLiBDYW4geW91IHNoYXJlIHRoZSBpbXBsZW1lbnRhdGlvbiBo
ZXJlIGZpcnN0DQp0aG91Z2ggc28gd2UgY2FuIGNsb3NlIGl0IHdpdGhvdXQgcmlzayBvZiBtb3Jl
IHJlc3BpbnM/DQo=
