Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A653ED14;
	Thu, 15 Oct 2026 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078060; cv=fail; b=RALKh3RgHUSlFikWu0apCmpcEceJstTaA6GSP/D9FHn7P2J8breRyOnTAMxJey1Eq6Y0cyKwsrhBKglFJvezrp7lupOJA2jskCfSGhMyUEhmOozjGiVajhN4HnRwabNFOF5oY3oDOleOYqK5N4qKc/Nu6yGbbEQBDKBO0pUJ8Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078060; c=relaxed/simple;
	bh=IZ3ShbazpMl1CsJl2BoNHt8XPDXPBSeOwyTipLwLMLg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cypqQ2fjRlgKzAh/JsqR5tI2/a3p9wHg2oVsH7gBb8WHssgVOdP3EfcoaslTEWrzSLRBU0mA/2EQsYrITJbxTnJFkABlFRiMYYyd/tLVrGmwgD4wx2e9jg/p9l3Wib2RBfqluy9yukLdpXWuUhEuIprNTYcBUplpfeNv12eMtNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSyNcM94; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSyNcM94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792078056; x=1823614056;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IZ3ShbazpMl1CsJl2BoNHt8XPDXPBSeOwyTipLwLMLg=;
  b=WSyNcM94kS6vO2WCYgS/K+UVDLcz85e7wQkFIf6aAmUhj2V7r3EvtYbe
   5Jr/OKBiG5yz7kf15a7Htr4uO8X9mbBiioMaXN615vH3nceW8eP515OPF
   KxFG/1vhE+BwELvR1p4bPLwwvnXQUyw6KlkJ+4uzzssMFO+Ae7/1xRDC7
   HmPsl0W91xQSZRDbV/GwpM7ZVXY+xHeBbu1LqWRSsbrmyLfkSI+KcoAa6
   NnWcOoeJHXcNDLU3BGerJxTlr6SbF3tcbrAtS8CttDh1S1JOBriUyMrWo
   LbcCDrUVFIXIKMjAF9+3pjGt9iK933vK5u89v+rH8S514h4+6HjxmUk1u
   Q==;
X-CSE-ConnectionGUID: GjdN61vzRH2HkSVXi+QuNA==
X-CSE-MsgGUID: jPCBVHM4TiCf2+/h2nob+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="955991"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="955991"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:27:34 -0700
X-CSE-ConnectionGUID: 4SHa51TWQeqE7D17SfLOJQ==
X-CSE-MsgGUID: YklQMamiRpGh3qTR0MQlSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1735557"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:27:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:27:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:27:33 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:27:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qe7g02dQ0/0+kYDQ7QTH9aj0IyN00uoXKdI4fGqby6mzaHKYmXtsEF/9GHaXbh2thMrdSdetTcukM0CQe1Jg12ahjmN5/ZvBMzgWVNwGag9dnBUJNEs+PwQtsK6kgdjtNDEQc/6neW0wehFsFuY0go9yA+TExGV5SeJxz3aEr8FBYxeEvghPom/V2RfDNHMQy0kTEaZb4OUl3KS6I9t9ZO00lTJ1qKbklaHdmA/kVcMHZClsQE6Bk60047TgODfwTk5hLFsOuUgtbgu7SXYQkY53iqx9Vz6qHB6IoaoiHXiqwJLmuJauQNc8WWcwrqUfNRcSm3LoXtCLKd8owOSCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhHmksMpr/leTeDXwVlqW8jch2ilWvkf9W6O2OGXyk4=;
 b=Pn4M+845Bg6wrSslIsXuavnY3w23mpDSAVVZ9z4mgujFEP+3QD47P+0Dl+BshFArmS8BoDDEKX9qDF2IYRv5A7FAJccGxCKMJSxbZOUWpthJAAEvruKKVcA3EgBBU8zc5KSEyar4QJar2XQuRQEVwERmi/TZAI3OBf/Gq4I1J09Pt3grN4miTa4Eu0+K9W0jT3L4twh9s994uYNBSklKfdEO6wAp1Zfo6sleJe+0JdNTqjGqfk6+08Fn5rVauTPJ1iE33K0vQKkLB9hjTLyv53uVWxLme24NDVRAkL3wNXLJGEn8wA3bYD9WU8apTu4hSGeQDnpY92vdhHEO+vUpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 15 Oct
 2026 15:27:28 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 15:27:28 +0000
Message-ID: <0ad861e2-1dce-4179-986c-872a33eff38a@intel.com>
Date: Thu, 15 Oct 2026 08:27:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/18] fs/resctrl: Add support for hidden resource
 group files
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <9e770ba6dff365f823e702430ec3872709bc92d4.1790867441.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9e770ba6dff365f823e702430ec3872709bc92d4.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:303:2b::18) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|IA1PR11MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 365fa954-0042-41fe-74bb-08df2ad0d219
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|5023799004|56012099006|6133799003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UCXS1bM4e0yTsrmpqJYsp6SXWmQpyBfPBnEz3m8J5eXj8DLQhmzoXl+lHRUIFPY3tGBMBd59kUhSQB74Qx5+aCFD35cmaZeNIk/ArUULLrOKKhflZfkndX5uC8/H5Ui3sCLTYfskGdalX81g+ExGE1VFnVkyaKvX+vuNX7Z4rXnCWgf69uXXrXQlpScl5XSjT+4JsECiE/6VeXhN9vaB58842lHCW9CBiEcqwRNzAnNBVg7bGP0L0S4eWtVKG8/w/1RYum4FYU0Huf11m47XGJhaUfSJg8B0MuGsqk/02h+Mw8kaAE9SC/94Gel0crbcNj3HitY2hjaPJoerYvhN7Hlf5r0wV0cfxJhJV/SpE5dj84Id2TfZpyy2THYd1rSzYzbbKpbeuHpMBa79VdpcDyxvxzJImpuLfJCIGlGjnFEf6iFcPsgner4BgsCYl5LFItUyGFxlmBYdO/HuBl7bIkHC2Cl4wPW0MbXREU1uGVUgdBaIp9VOh4nE0sJF3qkDpnLyz4fwrG5mGyI5n0K58GLEEAhkJHhlyZUd8MH9Tordod5vDU1+Ct9oYLqCi+ZcqK7phI3xexT/GBv+UnjHKpoii5CbX5F319OqWJpjIXf9CWUYhGo84nkaKlIY3Ht9wO6ggH7cI3i6sSHT8OrgI8l4CbI6zEyWbDziFrdrXVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(5023799004)(56012099006)(6133799003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWovbWJyTXUyVS82cDlSVCs3RjZXLzh6ZmFwMnZCd0cxSmFyK25mSGorcTZ5?=
 =?utf-8?B?bnQvd2MxZXhUWTh3bU5hdGdmMHJpMmozZk5WbG54WU1xR3grVk55d1Buc0Ew?=
 =?utf-8?B?VUR4Q0M4OGJaQ2hWeE0wbjB5WXNjTFJyMExZWVMxVEQ2RDU0ZGRGSWZ1Z3R4?=
 =?utf-8?B?cmdCQ2VtMkplTkZwdFVSbnVaYjdvcnhYSlU2LzNUL2NFZGR2Yzh5UFFjUy96?=
 =?utf-8?B?WHg5aDJGM2xIN0FmZGxUbnNZK05IYXlsK2x0MGhxcm1OWDBFejZmNkpHTU1H?=
 =?utf-8?B?Si9FMDk5Y3JXay9ZSmRZUlhHdTZXbmIvQmxRN1pPNGlXb0dka3pOemVXYkMv?=
 =?utf-8?B?SGJxajh0Q2FwMUpVMUVNbzlIbWtST0NSQmRCeFhpOFFXeU05YUNhTDVFS0VB?=
 =?utf-8?B?U1RRQWZEUWNwMkRVWTFQcXphbEw4bFZqZnhyRnIrUG00ekRiN0gybkVRQjkx?=
 =?utf-8?B?Szllem5rc3BEQmtXQmpxZmpRN1RMY2VkU2YvWDQ4T2xmNm9sOHloWW14cUVZ?=
 =?utf-8?B?RWVDNFN3d3J4R2lIYjVTVnVmVXJRQ0xnWGxsTUZsR0h2Y1Q4RGV5dnBMMGwy?=
 =?utf-8?B?WGZXNkVSK21lR0trNC9PSjFVcm1IUG5NRDRpUnFtVGQ0TFZxSUorcG8wOVNP?=
 =?utf-8?B?eUhWWDU2MEF2UG1SR3BjZkdWMytrVVdYeE80bGRHblpFMHFISmZMeVN3d3Bs?=
 =?utf-8?B?YTZrUW14K3phZlAvVnZjU0h0TDBIVGxhSXpYbGgzN2Evejhaa1B1Qm93ZFBj?=
 =?utf-8?B?bkkvNTBjQS9BUUN5WUUwbHh3WHRwN3dEVXVhSDZpUGY3QTFJNWp3bk1DQmxZ?=
 =?utf-8?B?Y29LS3N0dWF3S1VlU3d5VGN4ZWhiajlzeVBmdkV2UjBET3dXa2RxTWZTWEoz?=
 =?utf-8?B?ZTlZakdCYkNGUXVrRUF6M2ovWWFlMGREYWZ5aTV1aG43SXNsUHdVM3NxcjIv?=
 =?utf-8?B?bWkwQkFMN2tkeFJpT2RidjFMN0NEYnhuSURxcFJNV3NOaVBwNFVxaHJpeWN1?=
 =?utf-8?B?blA4T05kNUtFZmZMdCtTTVc3NVd2Uy8wR0hLUGViKzhxYXpOeEFiNVZtZnRZ?=
 =?utf-8?B?aDhMTC9hQTNTcGhDQjdid2N3SHJkNkNvMlNscnBRUjNBcWwrZUlnbWozakg2?=
 =?utf-8?B?c2x0cmNDbmxvK0VsclUvR2liZ3Zka2d1ZElXN1VybWtUN1FheWkvTUlIalVU?=
 =?utf-8?B?RGtlVElQUVVpY1lNNkR2Rmp0Sitsb0lSendHMHR6SnJCa0w3cWZzZkJSMzgx?=
 =?utf-8?B?TlV4RHBEWUhiczRUN0JpcU1DTnVNcTk0ZytBUTVsZGgwYnI0WGZSQjRGYzhO?=
 =?utf-8?B?VTRtSEZZcVRCNUpWdk1ZT3JHRVZUN3NvZER0SlBRVkZLZDJTOXVmM09xQUJV?=
 =?utf-8?B?TDBEVk93YW5RZnd0TGk5QXBIaCtkQkZVMjNiNzlUME9kVkxyOXhacEhaSnRw?=
 =?utf-8?B?ZVEySXBSWnU4cGo2cWxMYXJxa3I2bmJOcDRTcEFHWWV4SDgvM3hpd3JESkFm?=
 =?utf-8?B?aU9UeXNmVmpua09mKy9Zc09tRjBOc0licFZuUHZmZ1VQL0wwbDBuUEM4cER4?=
 =?utf-8?B?OEpTa21vc0lHOFhxT0pMV2hGaEF4bnB6VVhaZjRNTFpzdUhCWllNODhiUVpC?=
 =?utf-8?B?WXloc1FoRGxTL3JhdVhCWHZZYzYrYUwxWnUyWEY1SEZ0dStwVDg5dFJGL09D?=
 =?utf-8?B?Ly82K2tEbGtrR0U3MHY2MWtWQWh5MzA1QSs3c0RVTXFxVjI0WVVYTW9qSlZL?=
 =?utf-8?B?b2NJaC9CbHBka05VZWhOQWUvL3VYSjU1QUF3anBiZEw0b0lUUDd5NDVPaVlK?=
 =?utf-8?B?NElkVzJnTVBPOVZtUVVURmU3dVd1cytVbnlHZUpEZ0plakxWWGtnSk1hZ1pB?=
 =?utf-8?B?dXZLTGlRNnYyQUlpTStHOStUTUJ2Nm53MDFXK2ZNM2VDajJhWlowcm1aMURE?=
 =?utf-8?B?a2M3K3VwSlIwdzB6UlQvSHMwSUUyQXpWS3JwU3FwdG5FQ2lEUENVV3VDNUpJ?=
 =?utf-8?B?QVhrU3FYZEFRc2hYdUJZQ3ZPelFyekhzNWZGaFF1QmxhN1hLQVo0aGd5dGt2?=
 =?utf-8?B?R2pDS050LzgyVVNGTFB1d3ZjaHBJNjhtbUsrSytEU0ZSLzNqVVZQTzV0Uzg2?=
 =?utf-8?B?Y1VGUy9BM1BjcWxocm9PSFdNcHU5enRxMUdlV0RpVGczVTduY3dib3JnZWdF?=
 =?utf-8?B?TStYdUV3NHREdHZEdncxS3VoMGp0Y3BrMkZUQ0ZvWTRiWExCTVp6SmtIYStz?=
 =?utf-8?B?cHVETlIzSXE2TFpDdzlXUHRsYTNIUzJBd0VRQ0NRZmR6c1JaMjNoMlIxVkpu?=
 =?utf-8?B?emRjQ2YvU2tyWCtQSVdDMnQzU1daWjRNcFdZdjZZckpZUXNLUHBSWEtkSk5G?=
 =?utf-8?Q?8cpjkVP5A36sqq+I=3D?=
X-Exchange-RoutingPolicyChecked: gRzduZS8MNcsZDAh6XPqIRzvIJl0bmS5lUHL2kBtEiXJZJ3UBmmHub5CKWL0Ku9hltG3u16KO7CCCRMKve0YI+eOJwx4+QpeN12xSU+m3ksF+YEk38nBtXZLOxCMa+qKh8KFULV4RyHyXcxDR5at8mfsI6lhqIAqN79GI5cRdHNSnZOMDYUUqf2CKxnjaVhXekkXElOAr8wxxSUAzThP9AUL1bho/4GKbr32DkcHw0FM5ow1hmHo43Hac6/wtnTNsw2O5ZD0FBHrSHLKRiXYv/ulc+h6FVdh9d1qfN9o9+/ATT90STpZ6eVDuuzgezBPFLLzK2tUTaQ9NNhXa5RWWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 365fa954-0042-41fe-74bb-08df2ad0d219
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:27:27.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EM0oVlLalWUtqk4PlgKs9okH/+pk71aQyRT86i7NBrB+Ah4e7XMFMSmMCdO4r1nCVoSKy4qB+bhINWuF5sjaSZYZ/LX8QWv3iBQGqE3SJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> Some per-group resctrl files are only meaningful once a resource group
> has an active kernel mode association.

Could this elaborate more about how the files depend on the kernel mode
and why they may not always be meaningful?

> 
> Creating them only at activation would complicate group setup and

Why would it complicate group setup and teardown? I think it would
rather complicate mode activation and de-activation but since there is
no detail about how this will complicate group setup it is difficult to
compare. It is difficult to reason about a patch when the motivation is
vague.

> teardown, while exposing them on every group would show empty files

"show empty files" - technically these files, as they are implemented,
will not be empty but return errors

> with no clear purpose.
> 
> Add a hidden property to struct rftype to hide files at creation.

Missing a "why".
This can append to describe how this adds the foundational support in
preparation for features to restore visibility when the feature's files
need to be exposed to user space.

> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
Reinette
