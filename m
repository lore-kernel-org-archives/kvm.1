Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6A3AFD18;
	Fri,  7 Aug 2026 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786129487; cv=fail; b=S4jQqBaQTzrmXaLAjRa2bjBiF8sYQhiEul2K+nBaeRVWR3ewQJ79cHiwj+owYryUpmcPDjjUSoKqJ7nHm30vpOqfRZJtMhObHbxQjBEEJDUWb/VYlrTNJ+3e6I3flXUVN8AXeUyKbPsiuz+jvSzS1sQ45KNeVnYxAWlwb8sSiCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786129487; c=relaxed/simple;
	bh=IEmbG1N5WF6mmqmq+iXaGI/o5I61KGtDxbQ1j1aWeUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OIAWAyjW07XFB0XCxtyKMUnrCa5SXNIX8xyuAG2K1tjX6fYfCcoSsKBKOXgCj1Zls91KE+T3wlyrSjpvmULdmmBIj8U0+O/REZpy2EV4oJORTkbH5O8mFC35rwepHIwTRJwXAsYhk5+U40jA3ff3IKgPY83XHeHWPYrfTXL833w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zoc8D2XO; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zoc8D2XO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786129485; x=1817665485;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IEmbG1N5WF6mmqmq+iXaGI/o5I61KGtDxbQ1j1aWeUA=;
  b=Zoc8D2XOp1Z5n/yo90j78dKStwuOPZ1KFUrC0/PcK3EKKekGuxnSYhcd
   lKcZBvNq0KKrS6EYbgQWKJA70RdImrsTSDjtTlBioB8MNnzgQ/S74gxgp
   vfecyYmlLArZ3xg2WDnrVsCz5SjwMkteXCxJhzWqjmuhXlYupL2EysKdN
   SOom6lA1AcBJLD24qilG5rXrKRcE5cspfD/BdExbo3k7hF0mfTbNwWTG8
   YCmUZzfRXNdMHNugz89iVY+omqZPCWO613sFwEcu07A6MBX71uWP2rTlT
   jnbD/IDHDjH+nUf9JfpUaH2z4bO2Dc2/7sjgkyKXpEkN/xwMZxWtOqiYa
   g==;
X-CSE-ConnectionGUID: kinden6JQuOQ1eQes/vDXA==
X-CSE-MsgGUID: 75VUF7o6SlSf8+wMWKzblg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="112292102"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="112292102"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 12:04:43 -0700
X-CSE-ConnectionGUID: exmtn4GWRGeFKGyQ86IM+Q==
X-CSE-MsgGUID: p5C7lpuYQUC+6Ftn2UsDIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259856498"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 12:04:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 12:04:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 12:04:37 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 12:04:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGJS0Ru/6ROlRfaLFzdVIrq7+uzR2WkfDmU3mzed2kMAJIG1CY2VQJDzU1C8BCma9Uw/+pokyU6ARnX7QHfRXYkcE4qxo2sQtzLBcny0YV27LFxHB0lSKnqfeqSi9smt/UR07cybr1Nzv7cnhCKyMaHBS6pyGOJyhaYyw2/KkJ8PMRnt13ijkAHjHt6NLuw1GbXReISNPmGV/D6GVAEKeOXcUcnYU+2lgndf7Vz6r1MSqFZT4p4V0I01GrL+stJ13ZAX//Xd+oGrTdiCieqS/yVXZToEt2TSsQ7fCZHWA0z56YDfVg6NEfbBLnBjrLXXDTkpmqAkKTheok+hxgv0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEmbG1N5WF6mmqmq+iXaGI/o5I61KGtDxbQ1j1aWeUA=;
 b=bQk97EoCSfF1hBVhsNJqTjLGL7Y7iQYAYH5D5kDVYOTMtUiBNAadt/afJI8AjPyF9GCgXWOod8f0Bzn8MelB/cAZu688aoNV6tx4nxOygqEcfsPlEHqq6GkljcmrfMIZmbgRedm669Mq6ye80lAQn70xLVHwqhjLgaMcpsQVv+6QxPl4HpWde3VKGfhZrWiULFlSyB2l/sEoNX3tZ6tyZp4VFYss3GlJFkfaxumMdsxnrTflWMjgQak0PamYVUBkuC0VD8LR2OD7yso7Ii4NWvpHR/pabkK2iH9ucGnuKUPcCKhM0FGtEJgrppy9cW1S2P5DNWxCbVRj4g86CDHBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB622546.namprd11.prod.outlook.com (2603:10b6:610:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 19:04:35 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 19:04:34 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Huang, Kai" <kai.huang@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: Reload MMU on *every* page pre-fault
 attempt/iteration
Thread-Topic: [PATCH 1/4] KVM: x86/mmu: Reload MMU on *every* page pre-fault
 attempt/iteration
Thread-Index: AQHdJexLuHwb32+5k06ylviiPt9NTbaS808A
Date: Fri, 7 Aug 2026 19:04:34 +0000
Message-ID: <6d8ac2f9487e5a00745be5fadac3f83679cae99f.camel@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
	 <20260806214050.78058-2-seanjc@google.com>
In-Reply-To: <20260806214050.78058-2-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB622546:EE_
x-ms-office365-filtering-correlation-id: 885bb222-b970-4b31-ebe6-08def4b6b838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: tZFGvXglY+rgrPIUwe9CNl3CAPzQ6mbuFaXuuIRgP674U+CXTCqG36BhwBviNQMyhgXcACTzJOccEsBTZ/WYmDFcdDnXnKdK0YAuEDNtwAzUArHgzJiJy3VTMz2FLmNd6FNg29TjjoKcfMXcLnpRv1/hbq78ILdYb2eumcXeU9jpezmcyGIp4aM7rhdmVcORmejUWsS3b86ZWWVuHjHPMWBKJnh1Am1m6Z2sIdZ6B9Cg+eF/b35Tba7w7GaOBQBbhyrCzESV8JK7jJCbpCbfGNFUhomX+ZXda/O0P/N2CMUIpay8K7EF+3cBiO5Du4cMCmJzqcgE06f+EXCcCtDPm24tPOcTja+0mYPm4Ek0/eEomm5Z6C9cvYt4GORBv69oKgr9Tyv2NYHsXASIpdi+pVVRSSE0TKAiLfMNH8nejeGW3DyglSi5AUyWmozIyAe+WgBR29J981e2hS+vDWGDLmByRTIt+7gHU/+Smhf8ucCO/BRApm57c0q9xzennCJcPY+SOPvvIvkej0375rKFoj6izT7Fkslfsjmon73MyAsmihAasLm+mZyZ5DrOO73CUhdwPOeycJ2rW603XMh5YU8GrffFs1A3+L+za85XVjK9oKVTOenADt0hrqLIvV4UanwkgEtKx3MJGx4NmLjBaWZpAGiT7X4IWLaEbq+/SfYXzJwNTnuW6Tl8ptCTVP8aLqgO5QUvEGt+/+lqBNS9H4r6fxUusbC4pjHqFF5nkBA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVYza2xSVExySi9UR0JDL0VQN29YN1RGK0JOTm1DVTFrYTFIYWxMVnpCNkVD?=
 =?utf-8?B?VWdQL0JuYWJLQ2QrQ2FsaXZjOHRvdWxpT0wxTEJsZFRiVkNYZjlsc3RQV2tR?=
 =?utf-8?B?QW91QWlNTjk0emRDc1liTm9nU1oxeVc0NitEMlNCN1Z5dnd6aGR6OUZDZmZk?=
 =?utf-8?B?bjVDR2thTEdrNk1VcFlQMUV0NWl5d0VCTmNpR0dkc2NvczkyZ2ovL0lxYVlr?=
 =?utf-8?B?MitLMWhGSUNteTB0dkYyd3E3OSs4R3hwbGRBTk5vOHFsK251OHh6NnJBLzls?=
 =?utf-8?B?a2RNRFRPR1luSEVRRDlORlIyME1oWmdZNjI0Z0RsR0lMd1IxYWlGQXJyM0dt?=
 =?utf-8?B?YjNxazB6alZDeFYxMW9admwrZkNhNit1YXFPWDZqU0RLZDAvNnR2R1lwU2k4?=
 =?utf-8?B?OHBJczVkU2RvdkdNcm1KTU5Sa1R0NnNiOXZJekNQakZDYktwdDJ2WDRSY0VN?=
 =?utf-8?B?WVYxTmZKakVzWk9Xc0lwbWMwVTFGN0VyaURGODh1UndzbEloZm5MWE5mVVZ5?=
 =?utf-8?B?WEJuTTRnbzNYNG5YWm4rN3FsczRjbk0xRDNqR1dqdzEya0UrQ2F6U0wzQlkv?=
 =?utf-8?B?aEhSdzJoTjRrTUJQNnNXUExDZHJKTnN4NkU3TEgxRHJBS2VFVHV2NFprTHM5?=
 =?utf-8?B?eWc3MnpSMDZsUkRpUytwSmVBYVE5R1VUWW9KTHoyNk5zb0d6VWs2eU52TUt0?=
 =?utf-8?B?WFdDeFBJZ1E5NElIdkk1NWhFbFlVaTNBODd5TUoxcUdmZVo5c1NjTDE3NCtP?=
 =?utf-8?B?cW03MFB4WHcxMmpXWDFiejRGRmFOaGtRa1JQUlR5R1JwazI5c2hSV29lZTRX?=
 =?utf-8?B?TTBXY3ZkZ3hYQk9EZnZzN1EzNzl5ZTI2dFo2c2hoK2hyNHJUbHVXWlJIZGtF?=
 =?utf-8?B?TFpwalZVMUQwTldOZTV4WDErSUlRdjRxRGdiaUxLNnFITEhsWTJqNTNYb1J4?=
 =?utf-8?B?T3NqMGhqZ3JTd1FWczhCRjkydjlCZmNNclFkS3ozNlNMZTNKS2NMclYwenBs?=
 =?utf-8?B?aHEycGV1ZlNZY3FKZnE4bmwrV0dvN01jbW5MOEM4Rms5eTh2aTR6Q2RRbVhW?=
 =?utf-8?B?dWxKZGlKbk9naGw1SnQvVEdsM1FXUWtkeTFCQXdMc1NCTC9PdTNHb09PVjhI?=
 =?utf-8?B?SElpWllaNS9xUnR5bmdJaDR6aCs0MDNmVTB1TzZVTkl0dDZOT3ZuRlprYmtv?=
 =?utf-8?B?ZklmdEdCc1ByTTVDTkg1Mk5YdVkxNVFtdGlBWVVzNlEyVms0dU5ja2pGN1Fs?=
 =?utf-8?B?MUcvUldSdk9yUUlSMlJaNTcyUTZPWEVQeG5YZ2phN3l1VTZKeUxCMWxqaExy?=
 =?utf-8?B?Z3VWY281RzhhV2pkb2l4V2dlaGIrcGxZazlqY1QydUhob1l5THQ5SllvV0VM?=
 =?utf-8?B?ejBrMEtjQ2tVbTl2aW94NmlJcjdteDFqQ3RZdW9CTm96dGNCQ0phbjlXdUln?=
 =?utf-8?B?TEtFd3FTUTFCU0lXR25ZSWkxVUtzVUdORFQ5TDJVMFZkNGNhVzFWbkVzUEsz?=
 =?utf-8?B?WDQzcmNCYTRZWERaRHZKMjNUTkkvaXdpVGZNK0NDTk1mRk5BMzMvcW05aFZk?=
 =?utf-8?B?UjJnazk0Y0p6MWV1SCtucjdJS05yc2FNaGVxeXV4ZHBGNkxkUkJYbzc2S3dO?=
 =?utf-8?B?WFE3eFMrYkpzanpsNnMxREE2TUZwNlBDSnVnRndQTUNXM1BrRXA2TWcvN2Rh?=
 =?utf-8?B?Y3A3K1pxMG8wOFZXSDQxa2FsYW8xbWk5Ri9sOHNRbVNqendCcUlEM3BpQTV4?=
 =?utf-8?B?cUxERENTekd0dGxtM01JdURMajBaYmkzaHd4OUpkREpySjdScDdXOXQ0ZGNv?=
 =?utf-8?B?ODNjZUIvT0VDVjNWTGlVYWNmNUlzRFdjT2lmZGIzc3NSb3JkZjBEZUY3KzdZ?=
 =?utf-8?B?VXdldTZHU2tjcE5Gekd2QnFCcHc0ZHo5MFNrREk1Z1RqV3ZNbXpBNkRCdnBY?=
 =?utf-8?B?eVlKOUNsWnZFalhNcGxQaTIzSUhXYlNzOE40N2gySDlIR2dlbDBlVDJwSlYz?=
 =?utf-8?B?QjFaQk5JMWdvOW5nVmFkbHJ0eGpnOEowLzlRdGs2OVNkTWVyYjkxc0pIUjVu?=
 =?utf-8?B?WXdIVUxqaW9mQVA2Z2kwTlhpWmcxRHMrQlNicGIyMHVCaVlZcU1CTFJnREJ1?=
 =?utf-8?B?ZWxNbzF3ZE9vWGxXS1FKYkZyMGp2Wk15cEdGM2Urc1NSV2c1NnZ5TWFDd2pD?=
 =?utf-8?B?VURZQTBKdXFUUk1zTFh6OWluR0JQb3UvbWRWT091MjRZQ0tzOG9ta1VLMzJF?=
 =?utf-8?B?L09qbGFMOUJQVW5UM2ZldUxmbTVCVnl1QzE4TElVOHZFV2h3K25pYXUvQXZa?=
 =?utf-8?B?cTRNRFFOTURpQzRrK2Jna0tPaE5iQ1FWZlMrVUdwNE9IenBrSjhFUWVscnhD?=
 =?utf-8?Q?ALmo3MK5J4LHXcak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B324D95003D6E744A0ADB3FFC5E6765F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: goZQ5geI3baQlGTinV+ycMzhYQLE8P6QvKM5/Hla8e9tC3CCDYq203tbmqHyBhI4rl3UN/LxefD/DLLJolXyHLKpMt/coByD0kPTWibYRSfJOKLODVj5rrrrejW06rPhZBhBtmCXbmYe9g7d1XEgYOZpzrO7or1LtcCf4IUj0B3PIlOuUiUzxfdNjzbeQu1BlPnZ/O1nsPFZYCgfLOPqsmOVWoAjYQoI4v7Y6y25CsSDcDlUSp8nKb/R0WsxwJ8ZlLy/MVCA2wijFGDHdSqhSWklYO/6loGFfA7hokXMY2/hk/02Y7xczyI9UjZmSqKX1zA7BQPwUdZQvsj5N6IVAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885bb222-b970-4b31-ebe6-08def4b6b838
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 19:04:34.3810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EY7gbdaS7XRRK5xxUokJzJsNWt2wMbFCGd6Mdb6wjB7L2HejHU4kYBd2GzwaULEzZqwEYA7QlzdmCbSEj+UrjPwiIHCNXokKy8unlzPtWjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB622546
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTA2IGF0IDE0OjQwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZWxvYWQgdGhlIE1NVSAod2hpY2ggaXMgYSBub3AgaWYgdGhlIE1NVSBkb2Vzbid0
IG5lZWQgdG8gYmUgcmVsb2FkZWQpIG9uDQo+IGV2ZXJ5IGF0dGVtcHQgdG8gcHJlLWZhdWx0IGEg
Z3Vlc3QgcGFnZSwgaS5lLiB3aGVuIHRoZSBwYWdlIGZhdWx0IHBhdGgNCj4gc2lnbmFscyB0aGF0
IHRoZSBjYWxsZXIgc2hvdWxkIHJldHJ5LiAgSWYgdGhlIHN5bmNocm9uaXplX3NyY3VfZXhwZWRp
dGVkKCkNCj4gaW4ga3ZtX2ludmFsaWRhdGVfbWVtc2xvdCgpIGNvbXBsZXRlcyBiZWZvcmUga3Zt
X3ZjcHVfcHJlX2ZhdWx0X21lbW9yeSgpDQo+IGdyYWJzIFNSQ1UsIGJ1dCBrdm1fbW11X3JlbG9h
ZCgpIGluIHRoZSBwcmUtZmF1bHQgcGF0aCBjb21wbGV0ZXMgYmVmb3JlDQo+IGt2bV9pbnZhbGlk
YXRlX21lbXNsb3QoKSB0cmlnZ2VycyB4ODYncyAiZmFzdCB6YXAgYWxsIiwgdGhlbiB0aGUgcHJl
LWZhdWx0DQo+IHRhc2sgd2lsbCByZWFjaCBrdm1fdGRwX3BhZ2VfcHJlZmF1bHQoKSB3aXRoIGFu
IGludmFsaWQgcm9vdC4NCj4gDQo+IEF0dGVtcHRpbmcgdG8gZmF1bHQtaW4gbWVtb3J5IHdpdGgg
YW4gaW52YWxpZCByb290IHVsdGltYXRlbHkgcHV0cw0KPiBrdm1fdGRwX3BhZ2VfcHJlZmF1bHQo
KSBpbnRvIGFuIGluZmluaXRlIChicmVha2FibGUpIHJldHJ5IGxvb3AsIHdoaWNoDQo+IG1hbmlm
ZXN0cyBtb3N0IG9idmlvdXNseSBhcyBhIGhhbmcgaW4gdGhlIHByZV9mYXVsdF9tZW1vcnlfdGVz
dCBzZWxmdGVzdCwNCj4gYnV0IGFsc28gZXZlbnR1YWxseSBjYXVzZXMgUkNVIChTUkNVPykgdG8g
Y29tcGxhaW4uDQo+IA0KPiAgIElORk86IHJjdV90YXNrcyBkZXRlY3RlZCBzdGFsbHMgb24gdGFz
a3M6DQo+ICAgMDAwMDAwMDAwY2RhNDdiZDogLi4gbnZjc3c6IDYvNiBob2xkb3V0OiAxIGlkbGVf
Y3B1OiAtMS8yNQ0KPiAgIHRhc2s6cHJlX2ZhdWx0X21lbW9yIHN0YXRlOlIgIHJ1bm5pbmcgdGFz
ayAgICAgc3RhY2s6MTI2OTYNCj4gICBwaWQ6OTU1ODggdGdpZDo5NTU4OCBwcGlkOjk1NTg0ICB0
YXNrX2ZsYWdzOjB4NDAwMDAwIGZsYWdzOjB4MDAwODA4MDENCj4gICBDYWxsIFRyYWNlOg0KPiAg
ICA8VEFTSz4NCj4gICAgbG9ja19yZWxlYXNlKzB4NGUvMHgzMjANCj4gICAgX19nZXRfdXNlcl9w
YWdlcysweDU0Ni8weGNkMA0KPiAgICB1cF9yZWFkKzB4MWIvMHgzMA0KPiAgICBnZXRfdXNlcl9w
YWdlc191bmxvY2tlZCsweGVlLzB4MzUwDQo+ICAgIGh2YV90b19wZm4rMHhkMy8weDNkMCBba3Zt
XQ0KPiAgICBsb2NrX3JlbGVhc2UrMHg0ZS8weDMyMA0KPiAgICB4YV9sb2FkKzB4NWMvMHgxNzAN
Cj4gICAgeGFfbG9hZCsweDE0Yy8weDE3MA0KPiAgICBfX2t2bV9mYXVsdGluX3BmbisweGQ5LzB4
MTMwIFtrdm1dDQo+ICAgIGxvY2tfYWNxdWlyZSsweDY1LzB4MmIwDQo+ICAgIGxvY2tfcmVsZWFz
ZSsweDRlLzB4MzIwDQo+ICAgIGt2bV9tbXVfZmF1bHRpbl9wZm4rMHgxZTEvMHg2OTAgW2t2bV0N
Cj4gICAgZ3VwX2Zhc3RfZmFsbGJhY2srMHg2M2UvMHhkZjANCj4gICAga3ZtX3RkcF9wYWdlX2Zh
dWx0KzB4ZWIvMHgxNDAgW2t2bV0NCj4gICAga3ZtX21tdV9kb19wYWdlX2ZhdWx0KzB4MTJlLzB4
MjAwIFtrdm1dDQo+ICAgIGt2bV9hcmNoX3ZjcHVfcHJlX2ZhdWx0X21lbW9yeSsweDE2ZS8weDIw
MCBba3ZtXQ0KPiAgICBrdm1fdmNwdV9wcmVfZmF1bHRfbWVtb3J5KzB4YzEvMHgxZjAgW2t2bV0N
Cj4gICAga3ZtX3ZjcHVfcHJlX2ZhdWx0X21lbW9yeSsweDExNi8weDFmMCBba3ZtXQ0KPiAgICBr
dm1fdmNwdV9pb2N0bCsweDNhNC8weDZiMCBba3ZtXQ0KPiAgICBjbG9ja2V2ZW50c19wcm9ncmFt
X2V2ZW50KzB4NWQvMHgxNzANCj4gICAgX19zZV9zeXNfaW9jdGwrMHg2ZC8weGIwDQo+ICAgIGVu
dHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDRiLzB4NTMNCj4gICAgZG9fc3lzY2FsbF82
NCsweDEwYS8weDQ4MA0KPiAgICBfX2lycV9leGl0X3JjdSsweDhlLzB4MTQwDQo+ICAgIGVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDRiLzB4NTMNCj4gICAgPC9UQVNLPg0KPiANCj4g
Rml4ZXM6IDZlMDFiNzYwMWRmZSAoIktWTTogeDg2OiBJbXBsZW1lbnQga3ZtX2FyY2hfdmNwdV9w
cmVfZmF1bHRfbWVtb3J5KCkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29u
IDxzZWFuamNAZ29vZ2xlLmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJp
Y2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KDQpCdXQsIGRpZCB5b3UgaGl0IHRoaXMgc29tZWhv
dyB3aXRoIGFuIHVubW9kaWZpZWQgdGVzdCBhbmQga2VybmVsPyBUaGUgbG9nIG1ha2VzDQptZSB0
aGluayBpdCB3YXMgaGl0IGluIGEgbm9ybWFsIHRlc3QgcnVuLiAod2hpY2ggSSBmYWlsZWQgdG8g
cmVwcm9kdWNlKQ0KDQoNCg0K
