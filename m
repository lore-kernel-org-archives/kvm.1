Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD53803FC;
	Tue, 31 Mar 2026 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995866; cv=fail; b=KTGGkGxufWuUq4L0elkt6+gtsuoMol233o9PqHxV4A53ol8C+LXY0NrRPk8S6KOg6WBXjip3m6XsrnTtfeZopZQCpWKM48vOCRyVGNNUW2DlFSYI/Oz3ufnhR8L1cutvFvcikrY/k/pgVIOnMQPxz0bKBy+KDxWk92FEpaq+Y6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995866; c=relaxed/simple;
	bh=jhaLhymXFxw4sDctccEtSTusr55/qvSV4aqcn7O+qE4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aS4TwiOzEszwnuWncbLcYFTHhz+kIdGT6uiqLSGL+l7kQMNZzZQauQ0AqdOpDBez82r7c77S7sLaxNizwEX2qiN2beJB2kmxHVGh5Z8C5EmslR6LFNk/lsj2qqh1N4pJFOKRAk52VAps4ONTBcpeliOyAPs/DZ7SM5wWvaQz4S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXQguL+M; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXQguL+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774995866; x=1806531866;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jhaLhymXFxw4sDctccEtSTusr55/qvSV4aqcn7O+qE4=;
  b=XXQguL+MwWJLyYGmNKeSLkm4W4n9HcFAKz3FQ9C6sGlkY+DFK0cIPaLM
   Hz5IBGwx6KB3swYzrw1oxICRnlqFLM7DoQrhVWKZ6fBlsJr0SBKqsRrbC
   qtFdpNo9sk002FiWUcfhodM/YBQTsg6FVLx4VxPHymCKyonL21Dhd713x
   gLu/erGX/Lwn5sf4Dr2Qag0pQQMdGcZwR58OWaM7sV13N/IrER810wzbu
   W6ip4+mjGB53Rd+3u+z1I+BSG+cC6eV3VX3RtwEGCAB5Lf9j746T+YKRi
   n4Ng/gxr2PAt5td3hNu2PY3yvlSBRlkMG/br6Z36qSJqAXOIHeaMPRkSX
   g==;
X-CSE-ConnectionGUID: LafBocPeTqC4uWpZVAcAGQ==
X-CSE-MsgGUID: 1iQHcsiZRgme01oOLkrgug==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76038099"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76038099"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:24:25 -0700
X-CSE-ConnectionGUID: 6xsRG5zXQTKv4CaEP2lmxQ==
X-CSE-MsgGUID: UhAA/tHUSUiDJxRwMBxA7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="223185091"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:24:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 15:24:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 15:24:22 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 15:24:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0xS7YZMWcpAu5HJXecRBOdNgTTpHuyNuV3WTbQFCkRrF/iboZ9O+6Z2pG7DOmRyyr0qHtAXOiWO2+e9DF4rDAYuKDh5IJLHHTrE1Ld6ZE6byNqOxT9/cxs8WivIvTJgoRaDrKIgfMC4vXViK8lQganDP5Hp1h6/WrWk8dsi/MEvuUhJdkkceinPBSQB4EQHjaJ/Y38YPxssno17LS1n1m/kHJK7TJgyLn/YG+QrGaNCgWNhbSdcElJFTxkE2gAxJEGMuJgPgGfpKTd/guVi511y9+zSyytKjowcb3xN97SSVzXYTZZysWvqczXa5x4RyzIkD1vCZ8jZUXUU3p8cbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oibbKHf+tMySlabwCD3zRpINihJnq2vjekUP+uOL9s=;
 b=LgUxeI68jv6r/TBptQM9u/GZ1wby6qghTaTBe6xLGsR2wEaTN8YB7dVFqlObmwEDdya3m3py83T992aacNxw79s3qVprxUO2wn4rBtlob46HOqwis4Ug34OFePV8kOGDYDKo7PNW8UbAHOWHzXlbn/eVHHlWi8t2uyWdrYnCGVRRhVJHAC12UK9jIeCQedxaR8HEY9r6sE0nWQi4LlHEp57+kIN2JCJcBlieh/eDQk+v6IDnrBWdLLYr24KpNZDEp+szW8IEJvbZP4Y7feZPAIFadWxEuNEyx4F74BWrrNmWj9OIKoTtOPD60UGF+wbQdTUQ8OvPIYMgU/VJGM05bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 22:24:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 22:24:15 +0000
Message-ID: <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
Date: Tue, 31 Mar 2026 15:24:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <skhan@linuxfoundation.org>, <x86@kernel.org>, <hpa@zytor.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<akpm@linux-foundation.org>, <pmladek@suse.com>, <rdunlap@infradead.org>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <safinaskar@gmail.com>,
	<fvdl@google.com>, <seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>,
	<xin@zytor.com>, <tiala@microsoft.com>, <Neeraj.Upadhyay@amd.com>,
	<chang.seok.bae@intel.com>, <thomas.lendacky@amd.com>,
	<elena.reshetova@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0257.namprd04.prod.outlook.com
 (2603:10b6:303:88::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d797d22-d8ae-488d-8824-08de8f743e4d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Y9XMSKyabq+Q2mYXWD1bP1ZJrZY5q76sntSyrBw1DpQKbcEZghTaxAStVkdmKbFD+so8WLQKvY7RZUucD2f9aoysGrw1HCx849PbJ6ExukRNUHSWzdGEJu8JHQZcIXWmPwbXVXKTixKT+RPUL9q3quDHTD/SBaytC+SUHzOAIf8W0qdijKee8FaT8T7yjIMYqH49hFNG/HGBnx3Qkw9cLhZMNTT3IbHsj068oN0pFhYs0QhKvfpvOSZ8FvHFy9hzXsKXQN5rOqElDdMWehMeN/V9DWI7Qy16ICsiTZ3xSAKSF5of19DbY+AidKgyjLC4uXSXGLoQpaWZgLd+T0rGLV92K7nIFay6ER0lxJF5A8vuML2/qlUMi5GyWRt1pbQ4g+2bIt9Xc1HRJyVF8jTdmHzSkbSoCanGF589xA3LiAK6Lijw2tbOU+YjuxmNLqyPtxPLKMV62Y9mEmD+GCCJRzH6wjWE/W1CS+unj78JxEH6fZlIcB9Hvnk56HB0zvwP5gupu4BTgosW9MFI4WEFEXG0oww6+UD00/nUl3HmXJjMD9tp9aGKhUIfeOdSos2+iKP2SfmTrmmTZNUt1p2FvCiDIUaWOZFUbKf+7h14Ej8KwLlywuUhFKWBKiKw8ti19wXrzdKmU1EWYO9NBL2OZDC+PeedO8VNhYNaOyjQl7Sk/pniNAID/587zYrE290yaDHfCp7dz9QkepBTS80++A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhPTEZienpEZGdOYWxxUTZHWUFzc3ZCQmlGbjlsSGovcDNaRlpQVEIyK1V6?=
 =?utf-8?B?alFLaVprUGtmQkE0L0RVOFQ4cFJrOFFxMkphM1JpUTRkV1VOTkJxTVJEWGJK?=
 =?utf-8?B?M1k0NWdDcjIzeFV6MTUvRkdmSFh4VmNKODBTMVNlZ25mVms4NzNpUXNQK1o5?=
 =?utf-8?B?UldnaHZMeDlNak5pbEhRbmdFZFM3QVVMOTQzRlJCTFd2cG43T2ovYmt6UnZP?=
 =?utf-8?B?YnlOdGlxYytFNVlzbEI3S0tOdjY4enk0Rmlma084eW9jOFArUk1oclh2WSs1?=
 =?utf-8?B?R3pRNWlGVXZFZUlPb3R3a0F4cWU1SmhGSFIrYXExb2g0cWIzUVd2NUNkdWpC?=
 =?utf-8?B?MCs3V1pnay9PTmg2T2NzTk5MOVJoT3NqYlh2c0cvY29YMGx0eWNVQURYK2Fl?=
 =?utf-8?B?RE9ZV0grSGFOQ05yekV4NjRwWUJsYWQxUmM5V0RaSUJVU2JFZHhRVzUyRERo?=
 =?utf-8?B?VGUyNDRDcHVYb1hQVzlTaFdYenVCSHRHemx0Q25HWHMxNkVwNVBPUEZUakNM?=
 =?utf-8?B?ZUVMVEUvdzhReHZRUjBvRWxLMGJBV1h3VU81Zkc4SkpOaU94NExUby9zeFZ6?=
 =?utf-8?B?MnhaV29Td1NONGtrN3lkbFgzclFrYjdkNjFzV01rTExaSUpZMVRxbHlYdEdI?=
 =?utf-8?B?NEp2bEsxdWZQS3hYK2d2dkNybHFxbFpYN2pmM05SOW00azlpMi9FRmhQQ05v?=
 =?utf-8?B?dGZXVlhTdmJqQU1WYzI0UjN3cW0ydFpycHlwcGRuNzJUVURqd3FvbG5nRm5C?=
 =?utf-8?B?VDFlN0ZkekUvcGNDNEVPYmkzOEpwUmxrYnpoUzlMNWFFSXZmZ2lhNXEwNWJu?=
 =?utf-8?B?VVdxaXZZSmRPZ2FXZVZnMCtJUjlTOXdRUmVPSUdZTlVoaFZBTGFGRDhWY0ZS?=
 =?utf-8?B?SFJHSVc3RXVhbkQ4Q1YyYnVVS0tzMVNyMzVSd0h2REtrL2FCVitibDJrQzkz?=
 =?utf-8?B?ZHdpN2dKSXVyR1pBMmloUTZ5c1JBSVVUMjhXanEvWDNUWDR2TnJ6cDFpSUFr?=
 =?utf-8?B?eHZaRGVNMlJITXM2TDZPV2YzcUZDTHhnYzlRK3hhWE5SZWVHcW9BVHhJOVVK?=
 =?utf-8?B?dVVNTkd6QnU0ZTdMa0pydE9ROHlqV1FsbFZGcjVoNEg3RFBuMldzZjlQQXlG?=
 =?utf-8?B?bHQ4N3poN3NiZGh5VE1iVkpYcFpWbVUzMVJFNUp2RVhnSi9uaHFCWlpsL2tj?=
 =?utf-8?B?NEdRK0pvU3BRRDNLS0dFQTlCNDhmL21hcUMxUWNUV3lSYjdNRFJFNnRBbjVP?=
 =?utf-8?B?NGdxd2p3VXZidi95bHBPWksxWHJDY0doMG5aRHN0UzBYT3hQTXpvSTVkNVNl?=
 =?utf-8?B?RlpCbkxzRWRkcmNLTWNucVFWQXlBNUdrbXVHbmNBZ2dhdWw1QVVabHRGSFZj?=
 =?utf-8?B?YkloTVE5Nng4dzJyRzRDd3hRb005YjB5RDRhVmJmZjlvRzNyVWptN0NBZmRE?=
 =?utf-8?B?YmlpSmJXTzd0Z1UwdHd2WDZKR1BtUnZSMTNieVpscElCbzhRcWVlc0I3c3BK?=
 =?utf-8?B?RS9FKzk2a1FscDFweEZVWW9FUUliRCtMWjlIRmtGanlHeGlLcnFCNEhHSk9q?=
 =?utf-8?B?ekNnaUxoTWlJR3AwV21ZeC9aNVMxTEErdytsMGVTT3dGVjJkZDRERDYwR1lx?=
 =?utf-8?B?NHNTOUJNNHpzR3IwY0dpSkhYUHAyNDlTd1h1UWtvRGdvQ0FjcmpVdnVFMnBJ?=
 =?utf-8?B?TEhJY0liWmwxUVRFNTZORW5CeFVjaVAwT1daOXFnclp3VDlIY01LbXoxeTIw?=
 =?utf-8?B?YWkyWlI1TEExRG1WWVY0OHRIR2l5ZW9aZVdVL2EyOG9aSEZQU2srS1BVamQz?=
 =?utf-8?B?ZkE0SU5VZHorZ0orWXVveU8ybzQxN2ZyQVFYUDRWL1BHOWwxT2FPemx2Tnph?=
 =?utf-8?B?Q3hWb1FHZGVPcElETWVHSmgrMWtTQlFrZnpoWlNBaW5SYUdIaTl3UTh6RHlj?=
 =?utf-8?B?NE5TWEpVUFFBME8ranA4TmtmdTBVdnFPY3ZzeHRRb1MrK1k3RnJiUVdiME9R?=
 =?utf-8?B?YU5vc0NsT1NmSC9QbWR2cVJPUWt4NXBQRml0Qy9ablVEdVIwU3BkQXc5cEE5?=
 =?utf-8?B?a3ZVZlIwVS9RaXRXVEpxL2dUdmRuMmJmZjVpaE1WTWZkaHI3dkNQZjdJSDhs?=
 =?utf-8?B?ZzFwUnRFM0xxaTJwN1dnNVRTQ1FWdlU5d0lQcWlPWkNOSkIxa2VxMFZkR3p0?=
 =?utf-8?B?TDJYcVRyWDhjaDZDbmVxS29LU2R1M2o4VEZqMFpMNzU5N3lOQXBGbS9KT3Fs?=
 =?utf-8?B?S2oyZXVHTWIvN3lWQzlIb0swZVV4SE4xRWxDbTJoV3FiaDI1S2M3cUsxeERw?=
 =?utf-8?B?Zmx3WEE4cTIxdHFQNU11WjM4Y3BGRGhzZEFsY1ZXSGR3MlYySjR6eVNkY0Q3?=
 =?utf-8?Q?V+9GD0mjV4C/4MZk=3D?=
X-Exchange-RoutingPolicyChecked: hmDUhNHIfqwgrvui4WD8m172/lSHGamoqDGN7+Yc4KDlPC+7nYCWJUYla1XTG2Qjor2h7lOJnmYD9kqBTp6Js3yzeDQE3xnqw3ecPNa+BR6nn0YRrZxOk0jV6rqB3vNrie7hSLEQaVFL+f18MnzFKXdLnp6TfmoJoazQNRi6+PRYWuBOSDGe8YwIzj3q9sYFpSjPWvHF50xizOGbv/fXsYzVHUeYOYA5TpqKjp+PExLWLxfeJaW4WBWJ+f/svtw+czePyKfxhi/GHrtC+omaclkZOLfgwMQUSGZUU+7JdxXeJIviJwo03XQq8t2dC77VWMJvZu5Vr2VGwR/Mzs7cbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d797d22-d8ae-488d-8824-08de8f743e4d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 22:24:15.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3Pubo1AGH/NMAOSdsdUwZuIMFKvk30BXicryDy9iJDe7S7SS9BRxTC683Zo0zYDv3UYDh80AQMJdjFuyqTnVYh3t3cYHg2WKWXvw0hBZ9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-OriginatorOrg: intel.com

Hi Babu,

On 3/30/26 11:46 AM, Babu Moger wrote:
> On 3/27/26 17:11, Reinette Chatre wrote:
>> On 3/26/26 10:12 AM, Babu Moger wrote:
>>> On 3/24/26 17:51, Reinette Chatre wrote:
>>>> On 3/12/26 1:36 PM, Babu Moger wrote:

>>>>>        Tony suggested using global variables to store the kernel mode
>>>>>        CLOSID and RMID. However, the kernel mode CLOSID and RMID are
>>>>>        coming from rdtgroup structure with the new interface. Accessing
>>>>>        them requires holding the associated lock, which would make the
>>>>>        context switch path unnecessarily expensive. So, dropped the idea.
>>>>>        https://lore.kernel.org/lkml/aXuxVSbk1GR2ttzF@agluck-desk3/
>>>>>        Let me know if there are other ways to optimize this.
>>>> I do not see why the context switch path needs to be touched at all with this
>>>> implementation. Since PLZA only supports global assignment does it not mean that resctrl
>>>> only needs to update PQR_PLZA_ASSOC when user writes to info/kernel_mode and
>>>> info/kernel_mode_assignment?
>>> Each thread has an MSR to configure whether to associate privilege level zero execution with a separate COS and/or RMID, and the value of the COS and/or RMID.  PLZA may be enabled or disabled on a per-thread basis. However, the COS and RMID association and configuration must be the same for all threads in the QOS Domain.
>> Based on previous comment in https://lore.kernel.org/lkml/abb049fa-3a3d-4601-9ae3-61eeb7fd8fcf@amd.com/
>> and this implementation all fields of PQR_PLZA_ASSOC except PQR_PLZA_ASSOC.plza_en must be the
>> same for all CPUs on the system, not just per QoS domain. Could you please confirm?
> 
> Sorry for the confusion. It is "per QoS domain".
> 
> All the fields of PQR_PLZA_ASSOC except PQR_PLZA_ASSOC.plza_enmust be set to the same value for all HW threads in the QOS domain for consistent operation (Per-QosDomain).

Thank you for clarifying. To build on this, what would be best way for resctrl to interpret this?
As I see it all values in PQR_PLZA_ASSOC apply to *all* resources yet (theoretically?) every resource
can have domains that span different CPUs. There thus seem to be a built in assumption of what a "domain"
means for PQR_PLZA_ASSOC so it sounds to me as though, instead of saying that "PQR_PLZA_ASSOC needs
to be the same in QoS domain" it may be more accurate to, for example, say that "PQR_PLZA_ASSOC has L3 scope"?

This seems to be what this implementation does since it hardcodes PQR_PLZA_ASSOC scope to the L3
resource but that creates dependency to the L3 resource that would make PLZA unusable if, for example,
the user boots with "rdt=!l3cat" while wanting to use PLZA to manage MBA allocations when in kernel?

...

> Yes, I agree with your concerns. The goal here is to make the interface less disruptive while still addressing the different use cases.

I consider changing resctrl behavior when values are written to existing resctrl files
to be disruptive. This is something we explicitly discussed during v1 as something to
be avoided so this implementation that overloads the tasks file again is unexpected.

>      Background: Customers have identified an issue with the QoS
>      Bandwidth Control feature: when a CLOS is aggressively throttled
>      and execution transitions into kernel mode, kernel operations are
>      also subject to the same aggressive throttling.
>
> > Privilege-Level Zero Association (PLZA) allows a user to specify a
> COS and/or RMID to be used during execution at Privilege Level Zero.
> When PLZA is enabled on a hardware thread, any execution that enters
> Privilege Level Zero will have its transactions associated with the
> PLZA COS and/or RMID. Otherwise, the thread continues to use the COS
> and RMID specified by |PQR_ASSOC|. In other words, the hardware
> provides a dedicated COS and/or RMID specifically for kernel-mode
> execution.
ack.

> 
> There are multiple ways this feature can be applied. For simplicity, the discussion below focuses only on CLOSID.
> 
> 
>      1. Global PLZA enablement
> 
> PLZA can be configured as a global feature by setting |PQR_PLZA_ASSOC.closid = CLOSID| and |PQR_PLZA_ASSOC.plza_en = 1| on all threads in the system. A dedicated CLOSID is reserved for this purpose,

Also discussed during v1 is that there is no need to dedicate a CLOSID for this purpose.
There could be an "unthrottled" CLOSID to which all high priority user space tasks as
well as all kernel work of all tasks are assigned.
If user space chooses to dedicate a CLOSID for kernel work then that should supported and
interface can allow that, but there is no need for resctrl to enforce this.

> and all CPU threads use its allocations whenever they enter Privilege Level Zero. This CLOSID does not need to be associated with any resctrl group.

The CLOSID has to be associated with a resource group to be able to manage its
resource allocations, no?

> The user can explicitly enable or disable this feature.
ack.

> There is no context switch overhead but there is no flexibility with this approach.

Flexibility is subjective. As I understand this supports the only use case we learned about so far:
https://lore.kernel.org/lkml/CABPqkBSq=cgn-am4qorA_VN0vsbpbfDePSi7gubicpROB1=djw@mail.gmail.com/

>      2. Group based PLZA allocation :  PLZA is managed via dedicated
>      restctrl group. A separate resctrl group can be created
>      specifically for PLZA, with a dedicated CLOSID used exclusively
>      for kernel mode execution. This approach can be further divided
>      into two association models:

So far this sounds like global allocation since both need a dedicated resource group.
Whether this group is dedicated to kernel work or shared between kernel and user space work
is up to the user. There is no motivation why CLOSID should ever be enforced to be
exclusive for kernel mode execution.

> 
> i) CPU based association
> CPUs are assigned to the PLZA group, and PLZA is enabled only on
> those CPUs. This effectively creates a dedicated PLZA group. MSRs (|
> PQR_PLZA_ASSOC)| are programmed only when the user changes CPU
> assignments. This approach requires no changes to the context switch
> code and introduces no additional context switch overhead.
> 
> ii) Task based association
> Tasks are explicitly assigned by the user to the PLZA group. Tasks
> need to be updated when user adds a new task. Also, this requires
> updates during task scheduling so that the MSRs (|PQR_PLZA_ASSOC)|
> are programmed on each context switch, which introduces additional
> context switch overhead.

As discussed during v1 any changes needed to support per task assignment would
need to be done with new files dedicated to this purpose. Do not overload the
existing resctrl tasks/cpus/cpus_list files.
 
> I tried to fit these requirements into  the interface files in /sys/
> fs/resctrl/info/.  I may have missed few things while trying to
> achieve it.  As usual, I am open for the discussion and
> recommendations.

Many of these items were already discussed as part of v1 so I think we may be
talking past each other here. I tried to highlight the relevant points raised
during v1 discussion that I thought there already was agreement on. 

The one new aspect is that I assumed this implementation will only be for
global configuration and assignment. It looks like you want to support both
global configuration and per-task assignment. In the original I did not consider
configuration and assignment to occur at different scope so we may need to come up
with new modes to distinguish. Consider the addition of two modes as below:

	# cat info/kernel_mode
	[inherit_ctrl_and_mon]
	global_assign_ctrl_inherit_mon_set_all
	global_assign_ctrl_assign_mon_set_all
	global_assign_ctrl_inherit_mon_set_individual
	global_assign_ctrl_assign_mon_set_individual

Above introduces a "set_all" and "set_individual" suffix to the original two
modes.

global_assign_ctrl_inherit_mon_set_all
global_assign_ctrl_assign_mon_set_all:

	Above are the original two modes but makes it clear that when this mode is
	activated _all_ tasks run with the assignment.

global_assign_ctrl_inherit_mon_set_individual
global_assign_ctrl_assign_mon_set_individual:

	Above are two new modes. In this mode user space also assigns a resource
	group globally but then needs to follow that up by activating every task
	separately to run with this assignment.
	One way in which this can be accomplished could be to have "kernel_mode_tasks",
	"kernel_mode_cpus", and "kernel_mode_cpus_list"	files become visible (or be
	created) in the resource group found in	info/kernel_mode_assignment. User
	space interacts with the new files to set which tasks and/or CPUs run with
	PLZA enabled.
	
Even so, as I understand global_assign_ctrl_inherit_mon_set_all and 
global_assign_ctrl_assign_mon_set_all addresses the only known use case. Do you know 
if there are use cases for global_assign_ctrl_inherit_mon_set_individual and
global_assign_ctrl_assign_mon_set_individual? The latter two adds significant
complexity to resctrl while I have not heard about any use case for it.

Reinette
