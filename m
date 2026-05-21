Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8C0366836;
	Thu, 21 May 2026 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347095; cv=fail; b=Q/V1yXtvOFaIGTUp1ggzVxR35wdQfyevpVn0BwIFmHYZCpDjG1ZWzPVRoA3/utFdvAER89jbYCzo0wDCnJEH3HugHCaR5Uqvz7nW6m3Y/oAffYO7qWKVopT39tu1i3SEQ40D9LvrOy1IBUtrb3ZsD2RPVvKROJSssUQckcEXMnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347095; c=relaxed/simple;
	bh=WFjKdmH8oc61IcOKXGlDv6+RhPurBpgk85WNXIO+L1g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKVy0pr2wqfcCC5Qqj4UExRPud3OaV0NHJ1jIPTg4gMRsR4YJDoDj8anZbJ0hi6h/Z2a8/7qEkQDG6fCSBYssEI7W+1Ro7ben+wAzT0c/74t6B1Z98FP+T4zKPa0SgW61Gwx25QJmkTM+wtjapZ1ti4g0wZiqnySL/hl8Eocm+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrenP7dp; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrenP7dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779347094; x=1810883094;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WFjKdmH8oc61IcOKXGlDv6+RhPurBpgk85WNXIO+L1g=;
  b=hrenP7dpsKrABlDGue1W3i4p4OTDn+pOhfNz97iMCr98LuOOXb1rfO6f
   gG6zstXZyO5ar9tCYBYwBfLd81RL/ffps6MPw+iXc1u/3p0VXVy2G/kDo
   MvuwpTQCcuWzF7mgBjyh7c7YZ37yq0okPYCH4jDEKDcX5z4PvqvZd2f4J
   Cp+o4+0ILq1DtcIHw3lPeTXOro7pDkFA9YB92+QkzIFxZRhBCzSSeosQX
   9RpETUpxdlNAAN4uyAOr5Kx1diK2D+TnUf02ppDLmRfugR+dipxfdma8c
   7NTF98pcg+iMxSIT8AkwRvOPxjr92YvV1n3jATJ2oovYEAClijKo21mmE
   Q==;
X-CSE-ConnectionGUID: BBgSZV+1S4ihz0lEYtEnaQ==
X-CSE-MsgGUID: QjGUBIYqQ6mppdEl71Hnuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80160575"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="80160575"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 00:04:53 -0700
X-CSE-ConnectionGUID: DCcA6bw0RGW1J92Y6J6X+w==
X-CSE-MsgGUID: Bm4QcRz1Sbaqhxqkl0zAZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="263966195"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 00:04:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 00:04:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 00:04:52 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 00:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chaDymyOPaVRRzjpkq8J88+gsMqkCnSZo6RcWUbMpOGvVVdoWJJIbN+RXVPvoc0FNZSDPCRz30BMoSOhDnKSBL5MiSNCkQ+FSSKQhZRcWCUQ4zLRPyo8H2o2BxSyMtoMLKRRiKbxAjXxAf7xMfKwzfCwDkHu/xP7un394+uNhPXOjvERnUtBgDV/r9cDC9uFjk58BuAXC0izdlGMcJRVJRt5ReYpf9Tkl8frUKg6g7lk5zP76IPXXWrjD/hCNNTEstA5nk+pL1mPCBpjP/wAXMErOYTvyd+/SWRbrFF3qnON1kgyuy4c/GEcsdAS7SNpi5LZERUdkQYno6UqMwUVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y30lp/woAE4fMH7rNVwE3Jgjxb4A4lM2CPm65JPC1MM=;
 b=JaUJ9bwjlv49Ozh6emV6yyrQN185x+T6CWvAyGbwyzsC5+DpbWiFht3HS0PXpGPzrFZzaixzsdZHdAH98ouUaYmhd4WlkBTX9cAqKpAXGnXVsvM8xlGAEm35dkh3gr4Z57ZvyV5H/qATrlCrNCHRuh26J6TLZLztmBJjJxCD3T4r1BNh+Yy9UYmCsPfCx2mQ8ngMckn4e2DwAR0uFMo6VZwKjTMGCo5aKXA9U9ITwTxBLCiexnqykyFCCIWsDqnhqOyW2a+FJpc6iP8QRh1DtyvekuYe21/ySv/UBXATsWuq1+0XryqQ2pWhXbbO1WqVDN3et7TeBLbDTM2Rx5KJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 07:04:44 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0025.020; Thu, 21 May 2026
 07:04:44 +0000
Date: Thu, 21 May 2026 15:04:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <kvm@vger.kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, Ashutosh Desai <ashutoshdesai993@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV
 {en,de}crypt
Message-ID: <202605210807.f147e0c4-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260501203537.2120074-3-seanjc@google.com>
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|IA1PR11MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e07046b-770e-4004-6d03-08deb7073c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 3KMHQE/RPRdsXWa1A9ly803krAeVaxp7G5jjyIxmOkLviCXxkCRq4tfCgdhfhj9+cnEoBG/dChtQrpdipxsJaJMpQt2Z8JtHJY+q6JJ1dKadP69H6NIOrsIWhvNoXd1+hy1iw3r1lel/vbyQfrYpb8PeF3I4m15XD4Qjn1gmtsbk6VlmCgbSxRtlNcx5PQ2Jp/vmoUbQlB2Fjydr8Lm6m83Pt/qSZI4y8mWYsNIlzXZ97c6pvlRB5tNt2YjXG3P2WoewKkZwF7TxL3Eja/wq4+Gys06KaBkYQJR4J+iJme2kRo0GLFh5GoN+cMU7oDaBZFkfJt0+tSL6Z+x0GlSHJz/O4vaCNxgDfc+iFs4LJixgSp7WhROBbN8amYrjq6HHMdkih+rfqr6Ro8EPXzfNGfWxdAlYyw00Jy9VBN3Qy8H9Ab0VIxvObaBydFzGC/vqrh/H3hEDOP88hDk0FuX/apqt5HcGy4KF1bUX2G19y1h1Wl9vTNsQF5NZ6st/EXKsfDUDlCIRzuqMgELgzFYVMhS+iHHK034eFp9jdacZlYBoMWiMUEDSDQvgCYHhVz+h0gfFugg/jg24xlV+LAR0GDhvRnJ8S4u698hGhJntK1unsBto4CDj4OnTLvTHho5bL5z+AiPg3ZKAnqFvytcBcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEtxeURHcUFxZHhsSEdHNnpKQVJlUm5jQXJCTTVPWW1Cd0dIYk04OTloYjZu?=
 =?utf-8?B?Nkc1TGZaY2gvT0lnbUo4dzVtVFEwYVV2S2IxM3RkemNxLzVobXJhNnREcC9a?=
 =?utf-8?B?bnBIKzNwdmVwLzRzSlNQc3gyWExsZzV3T0NMYW9QMUJnT1FHUDZ1YVdQVUoy?=
 =?utf-8?B?cUlSUkpXN0FzazVQQW5PdXhnSlpNeFBRVHlpT3VwdXdJU1QwY3N3by9KUnNW?=
 =?utf-8?B?NjNEWU5oZWhsMHBMSmR0dk56NFBIUGNTWTd0NVpmZ3NBRkFmeWorUnREZFhJ?=
 =?utf-8?B?c0xMTGNZVnIyYVN0OGJ0cDNjNkhJaTlFR0hFM2xiTk1oUmZrRGh4TWVxUW9P?=
 =?utf-8?B?bDB0UFhLUmh2RXQwU0dBaGtqUmFydWVabVhJSEg4R1NTci80YkJxQ3BncTdV?=
 =?utf-8?B?MjRMZ05HSUtkZ3d4YitzMVpieDU2SGxDWWc4QmR5SytlRkJ1am1odnpiYXdm?=
 =?utf-8?B?Nnl5TjczY0xxeTV3ZUxka044ajVUdE5HOUtTUWtFWUhvdXdUU0EyMkxQaWo5?=
 =?utf-8?B?b1NTbExydzdOa0dYTTlDeFUyWUtNOEdKODlickMzdlU2L0p0ZG03eVpRclNl?=
 =?utf-8?B?Y0ZaMTlOeWxad2tQUWhkNXZ6S0x1b2JVeXhiS3k3TFVLM1BQZXdIVG5wQXJv?=
 =?utf-8?B?TWc0ZzdvcmwzcFM2Szc4V1EyY1ROQ0NPdEZGdEdwcXpVNWNrUk1sd0FRTktG?=
 =?utf-8?B?NUkrdWV5dWhMbFQ1cjBtY0M1bVg5emVPVkNUNWFPTER1MkpLbGY1UmhvZGp1?=
 =?utf-8?B?czRicnJvRTBiRnRRUnZiZzgyY1BZL3hJbmJhMFl4K0IwTEQ0NmNPRnhCVi9O?=
 =?utf-8?B?bmp2RnYra0lGYWNEdllVeGloaWI3eXRLVXJ5cFdGSnZiOW5aK1VIN044MzNS?=
 =?utf-8?B?MTI2UXNvU010U3hleXpRc1BmYUc4ZjRRM3lGeFBCTEx4QjhTVW5SUE5yWHBi?=
 =?utf-8?B?dUxPWG5NSUVDVEdPdkdBZ2VDL1RTeS9SbkIvVkZQL0M4dWNjZWl6TjdVcllz?=
 =?utf-8?B?Zm1qQWlIMXFLWWJlL201VC9aTEFLaFJKQitjZjRCSkp2REN6QkpPSXlsN2NY?=
 =?utf-8?B?OFJSWTcwRzdiSEZ1ZlN0ZU0yNDNHNTJ2RmlZYmxtSHhvUGRLRnBjaS90ZTZt?=
 =?utf-8?B?NURncHFTUytlTG42RldrQ21qNk14V0JIVkNWdmlpTHA0SmJkZ2RtcUJIYXli?=
 =?utf-8?B?VS9NZk1weHNyVWRnMlAyT0tyeDJWSEQ3QUtUV0IzV3k3WEJYRUx1ZGd0dFpN?=
 =?utf-8?B?OGNIUkw3RldVSyt4RVB1RVNEQkJCdnlvUFlCV1hIdXdYdmdPZ21yV0d6MDRD?=
 =?utf-8?B?SWhrL0xycmlENnd5RHcxQURybm1zcWJvYUJDMERjYVI0by9SN0RCNVRHaWtq?=
 =?utf-8?B?ZXljRHY5Vy8rZ1JGbkp5S08yOFVVdVJKa0pIN2lmNnliMlgrMUhFc3JMRUt3?=
 =?utf-8?B?UWgrSW9XNHBZS3RmN1ozd29jUVNxM01lTHZvajUvdjE4c3AzRkNZbTl2WEtv?=
 =?utf-8?B?QUltc2RnRmxubURJNWpONnVxaVFCdVZmak9MSUxaZzl6aTczbTF2VHdyS3du?=
 =?utf-8?B?TkZYRVVCb3Z6VzNhNjVsNVNLQllEWU00bzlzQXpqSlZvc2tkTEFHNFAvVGZi?=
 =?utf-8?B?cEZOMnRWcWdYd3pUbUI0OUdIV0NqanhjNmxMNXFnVGozc0hzMEdWYko1UmIr?=
 =?utf-8?B?emZVQ0Fqb0dBbnZJbGRlck5EekZJZStVUmZpcEJFSlJNVkoxWnpkSWRPeGJN?=
 =?utf-8?B?VzJBVGtkbU1Kck95UDhSVW9YVVFoOFk2YXl0aThmUTk4QkNobDZVc1o1QVh2?=
 =?utf-8?B?TmhnbWtXQ3pqUmV2Uk1ZUXJRUzdoM01sbThYbkQ4SUN3ZkFWUE8rTHFQT1FO?=
 =?utf-8?B?TkEzWWxHRjl3R21sais3VkZiL2x1cW5BUWZlRHN3R3kwaXg1aVZaL2drbk8z?=
 =?utf-8?B?RGJXQ3lHWjIyc3lGUFBiVXQveXVIUkpjMkhhVVlDTndHNnNXS1dwajdJZUJK?=
 =?utf-8?B?ZzJlN0ZudWxXbm9ub1ZJOCtxVTN1REZHN2NHNlI1SFF6cmljQVo1M3RzaktW?=
 =?utf-8?B?TEd1dnNKT00vU1E1RmMycmNHWFZiQzJkVTJGamVaRk0vZUk5QUJRYzUwTGpv?=
 =?utf-8?B?VDZreWpaQlY0Y3VlbnZoL2VyNHRmeXVRMkZkZjhvTGpHMTAvb00xd3l1T2Mw?=
 =?utf-8?B?TTNhTGtIa1N2c0RKMFBNMmVXMkltSktOTkp6bU1QZ3l2cGlOTEpBUW1UQXpT?=
 =?utf-8?B?NEtiR3FldGFvLzhLc285UjV4Z2dXaks0S204Wkp5NjhIUEg5a0tac09QOTlh?=
 =?utf-8?B?aG44cHZuK25XYWJoMmNENENFbkM3QXYwZFo1Q3RaM2cxZDA0R3gwUT09?=
X-Exchange-RoutingPolicyChecked: PLe4dM8bsvY35sAudzqOO1HXlAtp31DudCeB27YOD3tUM+XptzYONfCUQG/6f9byWA2AVThArcRo9IrdzIs0jHLRXiozV1Q5WVMr4QgiYjUWivv6uTzxYf5XfDrMA3YnvE/ADvh3afDwb3g/fz/38bt5owlu+DaStRXi8oVXH9dgsK2B5tddlaXXziYoVX5jbNY+Zk/csDQA8l2t0dLcYY4RzC9iL+77rhvSH6/R02Doejx7lkFxOmb42dGk3/tm0dyD5wLxxTUpElJplwO5pm4cJAM39XCRnK+3t9aeYjygUxsZkcw59bG6j9n7MhtuP/SI72piAiC8gbsb0MNJgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e07046b-770e-4004-6d03-08deb7073c75
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:04:44.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtnzCLnqjlYqVAl09lKdSwbiQlhNejsAo+xcvuylY7lw/EnHZWU006lwnUanIvIK2Qo1MHxD/oK9n6WL7hBBvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.kvm.make.fail" on:

commit: f6ed3165a8ced57973a0919d0ead11eaff393477 ("[PATCH v2 2/6] KVM: self=
tests: Add a test to verify SEV {en,de}crypt")
url: https://github.com/intel-lab-lkp/linux/commits/Sean-Christopherson/KVM=
-SVM-Fix-page-overflow-in-sev_dbg_crypt-for-ENCRYPT-path/20260502-190513
patch link: https://lore.kernel.org/all/20260501203537.2120074-3-seanjc@goo=
gle.com/
patch subject: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV {en,=
de}crypt

in testcase: kernel-selftests
version: kernel-selftests-x86_64-917719c412c4-1_20260508
with following parameters:

	group: kvm


config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G=
 memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605210807.f147e0c4-lkp@intel.co=
m


gcc -D_GNU_SOURCE=3D -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-f=
6ed3165a8ced57973a0919d0ead11eaff393477/tools/testing/selftests/../../../to=
ols/testing/selftests  -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests=
-f6ed3165a8ced57973a0919d0ead11eaff393477/tools/testing/selftests/cgroup/li=
b/include -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wn=
o-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT -U_FORTIFY_SOUR=
CE -fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset -fno-builtin=
-strnlen -fno-stack-protector -fno-PIE -fno-strict-aliasing -I/usr/src/perf=
_selftests-x86_64-rhel-9.4-kselftests-f6ed3165a8ced57973a0919d0ead11eaff393=
477/tools/testing/selftests/../../../tools/include -I/usr/src/perf_selftest=
s-x86_64-rhel-9.4-kselftests-f6ed3165a8ced57973a0919d0ead11eaff393477/tools=
/testing/selftests/../../../tools/arch/x86/include -I/usr/src/perf_selftest=
s-x86_64-rhel-9.4-kselftests-f6ed3165a8ced57973a0919d0ead11eaff393477/tools=
/testing/selftests/../../../usr/include/ -Iinclude -I. -Iinclude/x86 -I ../=
rseq -I..  -isystem /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-f6ed=
3165a8ced57973a0919d0ead11eaff393477/usr/include -march=3Dx86-64-v2   -c di=
rty_log_perf_test.c -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-f=
6ed3165a8ced57973a0919d0ead11eaff393477/tools/testing/selftests/kvm/dirty_l=
og_perf_test.o
x86/sev_dbg_test.c: In function =E2=80=98test_sev_dbg=E2=80=99:
x86/sev_dbg_test.c:85:33: error: implicit declaration of function =E2=80=98=
vm_vaddr_alloc=E2=80=99 [-Wimplicit-function-declaration]
   85 |         data =3D addr_gva2hva(vm, vm_vaddr_alloc(vm, BUFFER_SIZE, K=
VM_UTIL_MIN_VADDR));
      |                                 ^~~~~~~~~~~~~~
At top level:
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
make[1]: *** [Makefile.kvm:329: /usr/src/perf_selftests-x86_64-rhel-9.4-kse=
lftests-f6ed3165a8ced57973a0919d0ead11eaff393477/tools/testing/selftests/kv=
m/x86/sev_dbg_test.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselfte=
sts-f6ed3165a8ced57973a0919d0ead11eaff393477/tools/testing/selftests/kvm'
make: *** [Makefile:217: all] Error 2



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260521/202605210807.f147e0c4-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

