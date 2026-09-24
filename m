Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818E374E7A
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 04:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224090; cv=fail; b=fNuqNQWMoWRzM3lpLAAlY5gWwvd/HwBLg3bNlsQkeE0J8IEm4r3G4RLmVzORX7MB8Ot7YT2iJIjfXiWcRh5bLjeeDFDRZxfPASMDYxL8k2y5Esp2wabmRWtA0gLvFZNuqee16JK1qeMjmFqdd6zREr9dlfkCrWhIH+QYovuTvRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224090; c=relaxed/simple;
	bh=mk/kUW1H6tSVHMtrMXYGxksSYK59bA3y0GkRjH3rkns=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pl4hS10HXTNwPQtCa5SAOiV4N+hQvfXPIaKKYIOjK7YP/WlNi+X2hZG0C7doNRvwkeeH9iY6Ym0A4zE0oLQVu9TfKOBR1NtWPesZGmQezbl06Z3LlVS7/KmfVsxEDB2DbtzGJn3c0mzjReZxgloyx4ydfCu911bt1WZ81C9kpp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma332bej; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma332bej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790224087; x=1821760087;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mk/kUW1H6tSVHMtrMXYGxksSYK59bA3y0GkRjH3rkns=;
  b=Ma332bejFq91WDx0FJH08GAuyt9um53svjWTbeO4vYQxzbGZcusHs0Vz
   nTINStVJQuVOWx8WFD6RYgK62jaVICP7Hln5sgpHEE9/M9wkRexyD6wYT
   b7y0lWjcW9d2amhTMJkhuEi+u5HAcnDLwAIV4MZ5UjSYijaFo0LSdiyC5
   CS1mwdLH9j/0HawAZi1+u2SFhjbPusqlzhu10OEKiD2tO10dGQw6mRKVp
   zPBAs6JF5O1BQtEayMWEeg03W1j2mBrpYynK8ea86jrP6fMmmzOt+IHmr
   CySymJOxV9BSnb5WvXvNM6HcDFQznUgRQFckGbe27Fn8GOc8Vag49B+96
   g==;
X-CSE-ConnectionGUID: DZub9YucRpqW7dw1MS6Z3w==
X-CSE-MsgGUID: Jn9m1rvUQ2OBSAqG3q6MzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="1497281"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="1497281"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 21:28:06 -0700
X-CSE-ConnectionGUID: xkkHGtKMRuCa6FiqGLzIGQ==
X-CSE-MsgGUID: LwGMjPSxSH6DkIdUx/ZO/w==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 21:28:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 21:28:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 21:28:05 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 21:28:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+yl4ByHz46OtHPaqTdBO8V7LHqn+JF45dJM5J0ASgN/3R5q5zJkyVzje+2faas2QuvZ0koHNWRNgAJkyqVqLNwtNGhPj0CcewWVsOk/ZBdtGvWZS5Ryaxa/veRuv+U/ntPDD+f2KKAol3PHmuXqC4rlKKXDmXW2XOueTjTLnRGN00geGTND8AgOy0ROpQup4m+azmp0VhYQBcw7prGiFfKwR7fzmPvT8SsLWVCKmqQ5Q6wfZQ+MPqTHSZIWkVJyfEI8mKbNQeJfv3ycnqnjxojfvpVbAEr2Y/Gc58I01eklIWtLbcj57kBqVofY/yoR9A7dbsdr6AC9+2ZOL3owoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqbF5ikWO+usbiN2yVKwqVMXv8aI4zmhlQhdUPF4Duo=;
 b=kBtdbGmhEar8GEF4/Hqia101EE1P3MdeNMQwGQvrkHKvnw/SDx/H43OnXyQ6h+P+DkgZNK6ulN62UJg6QBxvZ1pGGZjWgjx6YpwzwUkr/CKnynX0A4nPKIkcQ7a824pPe+9XVNbM4RjMbOOdUsiq22S/2LVW1MJWXdIslMsK1BhddqA+0rvEh5Ka+q4LmyLbMMZXKGNVyiHzfvu0l2SHuWn57RB4iLYAAE6Fhpxe6JMP7FU5+6krXx9fG3BDolED1FOExg1mgc/MCci7QfQ4J/Eeh+/2YQTlNzE3oq4An6NqGtLU8sJB7rHHNBjCiuuRTzYleScuOcBrKJNGGhXQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 04:27:56 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 04:27:56 +0000
Message-ID: <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>
Date: Wed, 23 Sep 2026 21:27:52 -0700
User-Agent: Mozilla Thunderbird
From: Kishen Maloor <kishen.maloor@intel.com>
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
To: Peter Xu <peterx@redhat.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, Tony Lindgren
	<tony.lindgren@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Fabiano Rosas <farosas@suse.de>, "Jon
 Grimm" <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
 <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
In-Reply-To: <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0196.namprd05.prod.outlook.com
 (2603:10b6:a03:330::21) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|IA1PR11MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ee3a5f-05ca-4e62-c8ca-08df19f434c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|4143699003|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 9RBSE7Bgt7ABiNcMu9NVX3U9c1kBPl925cJaqo3cDrZ2t8m5y16ry4HOTOpULq2zzb1hjnMknJvOVpkqNL8glJbHSRcfMneDQYlSX4xMjfFa04PqP3V/AZzDvlUP5B+Ahz2f9i9j/+s4MQW9EFx/I86ACoaL7NwoCKxZr0sV3Vv5o9T5t5mZpsCKeIsS2PKw8qnQCDWi0kfNF6E/TwvfXU3XbRA1DenZ/38cpEF2YuKQCMfdnecnYeeheYMNKrnI4DSPEEL6Mw6Q6r/Jfx7jwmDqhp6lf3BqdKf9w5x96Cf2ol46DmHB9+qaKAg8GFvpZ5mB6+f/1Yci6ncNoxAMuoHYmcj5IVVhOYgJuMy+IUfgma0VPqY39mSrwBBXobj+vepO4DzaaA3j5i1byOcnn33PkSFl0xTmV5Ws6ZvO4vME77EZZYbF3xEohV1dJqt2s9qUQjatttB0M2dXuUtTzHxFgkvDpdm1flFoPsEE61JS7128qCaPZ/vZLgAQBcYsHk48P9Te5NUC15e9LcxPb2Csh8NhsBFtyC4pxvEBMQxL11r/EXDMSNh5E/tY4hcJG7dDUo9n6ObwZsGhYiebM0UW4eyiSF/wbdmAUQtSUsXdsyi5DWR/K8fNMC1cD8ax+qcf796Z29h60EBZ5i4I3Rm9quuAQMfDAnYqkFoty7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXN3aVVjUEVJdGgrZEc2SXlWY0hrSXU3ZVVyRndTWm1uaUZ4WEQ5MTB1USt2?=
 =?utf-8?B?YVJlTW0wK2pqVTkyT0pqY0d2L1h2dkY2bUR0ODdiSVN2QVRtc2l0MllrSlBO?=
 =?utf-8?B?M0w2dUdubGl6ak1qWXNxVkFQMUNLR3REVUlnRWJaRS9RTHlOSEZRejlBL1Nz?=
 =?utf-8?B?YTVJK2N6NDJtTThxV0JUa0ExWTBPTDF5clIxU1dwMlVtMEtCYjljeW04QTZx?=
 =?utf-8?B?TXljVVFBanhYMmpNMkc5bFd5MXMzMU5OZmE2YTZkTG5uMDI3RUVlVG5Zdys0?=
 =?utf-8?B?U2MydzVBRi9WeGdZMG5YQUpRcm5udWhwZ3N3VGZVblJ5L2hDYnR0eTB0R1o5?=
 =?utf-8?B?MjU2K0swbUYwejZJMVM2V2JxWldwRDNTRkpUYm1LZlJ0UnBCRnA1NzVNYjZy?=
 =?utf-8?B?Yk5HUEFzcWEvVm1qOU1OWUxYT3cweWl5TjI5cGtpeUpQaTM2NHlLSzQ1NEdC?=
 =?utf-8?B?Z2cxWVp5ODdnZXJ5ZHRHV1E2WjNFZkVJamFsakpLZVVIQ2VxMURHS3l5TjM5?=
 =?utf-8?B?dmlhRlVseUdCblZjQUw2eENjMEJBaG5DL0YyVWRxeGVqNmh5Q0NrRHB6Ly85?=
 =?utf-8?B?MjVyaWxxQXdaU3pjWE1qQWNpNmxYaGdTeHRjOWFoRFhtNXlzdVhGNDJUZklT?=
 =?utf-8?B?WTlGaHljQjJqQVRadXljYk44MnQ1RTRjMnRSZmZkYUZHbUFocTJKVzZuNkJs?=
 =?utf-8?B?RE9tSDNPTEg3YTBUd3k3RG9IencxSkN1QTlKTGlkQXlIajB0TU9SZ0p0dklu?=
 =?utf-8?B?YVM0UmplVmNPZWZ1aWplUUF4Zk1ENy8rRC9yUjFrd1Ixc2s1dk53WmxxQU83?=
 =?utf-8?B?NEFvRkY3M05Rb1crVWVjeG9jMW9MTFNHd3JncjE0bE14NzVKYjcrRHVyR2Mv?=
 =?utf-8?B?R0U4NUw4cWozYUdtMmFIekk5dGRHQnNkZy9TNmZNYVA3em1GRlZhbkdjS0Q4?=
 =?utf-8?B?ejBnQ3V1bFJYd25QTUE1OEdKV0FoMTA5UTlNYU9VbkhxUTJNUEhnQ1ZyK0Vl?=
 =?utf-8?B?bmhvNHRmRVJBSjRIdEtMTEI0ZmtYT29oOFlEanBEdUtsbG8yRkNzWGxzdnU2?=
 =?utf-8?B?ME56Q1VwNXNmSXdaV00ySWlmSm5Yb1lYZUV5ajU5SkhqdlNGT1lzUjgvWEpJ?=
 =?utf-8?B?WWlqWXgzdmZPMW9FWFFpOVNLQlhYQW1GWk9XaTJjd2d1V00weTFERWRkazFX?=
 =?utf-8?B?ekdpVUdsOHQvdHB2aUliVW5MWmdrTERHTW1HeFpnV0FFdlVDUitISmdOSHVH?=
 =?utf-8?B?WjQ2UFZBR2NsYXBvOFRGeTZ3SlVLYXM0ZEJvcEhkbXlvZENSWm9ERnVQYmpL?=
 =?utf-8?B?RVZRL1Q5ZlF3WERTbXZwMFBxNlB4T2J0T1JvRkVSZ01wUmJBdU05K2pDeG51?=
 =?utf-8?B?ZmZUajc5QXRGeUFZZTJYd3V4LzhuREZ0Y2QzbUVra3d2cGIzbFIwSzU0RmVl?=
 =?utf-8?B?UDRML1RHb2d6andUNyt3cTZvZFRUWG5ibUhiQm4wQzlaUndzTnVTR2JiV1FU?=
 =?utf-8?B?QXFTVGtGNC9UTFVtNmhqODVscEptTXdyOFMvUE1ITGRVcnViQWtiTElJWnJO?=
 =?utf-8?B?UHRUQmNEMUJzVU1ORVNyNTdWdFU3VXUrV2Nyb1l5bzhYTHdidjZObEFDMmhW?=
 =?utf-8?B?VmloZEhET3BzcjBHK3JQbFFSZ1pJRyt0VTEvQUhDTEQrQUpkVGErUVJqWDN2?=
 =?utf-8?B?WFpEM1BVYXBkZlkvMzVTalJTcGN4eUpkK0ZzMGNvZFN6ZzhUVUdvbU9mTDBq?=
 =?utf-8?B?bEdLaHNqM3g3WXFDR3A3ZzZMZm1QYy9uaGdyZW5Ic3c1VE90VHB0NitCZm1Y?=
 =?utf-8?B?aVBHS1NIa2t4dG1haUN6QlhISm9DZlRqWUkrSHV6eUNQelNPOHNUS1kyTExQ?=
 =?utf-8?B?YWVEN3dIMUZyQk1OdThGY2RNL3hxZk9OL2JacHZ2WDFEVkxxTStEUXI3dlgz?=
 =?utf-8?B?emtrY0s1TW02U3d5TWEvdnR3cDZCSVErSm9BUk92K0tCNmhMSnlTeUlXT0lN?=
 =?utf-8?B?WEozd2NiU1ZOK2dWQW9VbUhXNnNtMyt4bjNaUlB4eFVTaUdmVGcvZWU1d0li?=
 =?utf-8?B?ak1od3hkUERKc3RCOXA3bUdPZGh0SnFjVnNNYktZbGxIWjNza1IwalkyaEdO?=
 =?utf-8?B?S3crV2lZSHpTWU9Ucmtmd0JKa3JWelUwRkNLc3l2VVYxa3A0UVhtL1J2QmtD?=
 =?utf-8?B?Y2FHc0FybDZlSHlSbk15T050K2ZXc21ZM3J5NzdiWm1EbkE2RFgyUFp4ZXZs?=
 =?utf-8?B?aWZYeWMzcUR5RzBBTktEWHRkaENoazU3YktQd2pYYTRLUG1YZ1Y4REhITi9a?=
 =?utf-8?B?S0hNU2Q4NXhRdUQvYjdmUThVVlAwdk5WTExuY21MSVIrcmRnNExYQT09?=
X-Exchange-RoutingPolicyChecked: a8whPloQZw8qhyU3Xj6eKyJUbxf9/iukLqFmUr+srzrVAHHQ4yf3Ix40MtJ0xOfD7mBae2Y/6abr6IMad9V1Gq29JWYWLh4xFDzAK/vIzOwPA8X9vUMvwz+bDsFmmLC7VVMZxDLNZCeXpU+0IOB4JuiVu9voap3BkkS1vjqyfDRjg8DGyWb7wQymhcRu+4N2bN9kiuTsybLNmfDoh0UaxmGWaNikRZrIfloBaq7mGbhe0bZhWmvJw0YwSuC2ifJF8g8t/8BeEOXBlAyYASc9bOo7Ooo2eJsjnYwlckz9fHp1g7KYZxT3bVGIk0WHJR4xMBfrgSFjCcOKRw/WPStG8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ee3a5f-05ca-4e62-c8ca-08df19f434c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 04:27:55.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twp1eRHmm+Xv1vL91IDIazu7Nu4TD3afjrrm5JB/N0wEG8CalKDCskCiLyPM9BdggtYlKhZlFwZjnJxMpfwiDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6396
X-OriginatorOrg: intel.com

Hi Peter,

Thanks! It really helps to go over details.

On 9/23/26 2:36 PM, Peter Xu wrote:
> ...
> 
> I see this one slightly differently, and I have a major question on the
> choice of GPA for KVM's memory access API.
> 
> If reusing GET_DIRTY_LOG, it means slot_id works for CoCo like before
> because that's the old interface there.

It works because we map backwards from GPAs in TDX's dirty scan results to
a KVM memslot on the source, and a bit in its dirty bitmap, in keeping with
the GET_DIRTY_LOG contract.

> But the new KVM_EXPORT_MEM (vice versa) used GPA arrays.  Could I ask why
> the change?

The migration ABI (at least in TDX, possibly others) is GPA shaped. Also,
everything downstream like SEPT entries key off GPAs. The EXPORT and IMPORT
ABIs take GPAs alongside the encrypted blob, so both the source and the
destination need it at the call site that implements the UAPI. Passing GFNs
in the UAPI is merely a convenience in that respect. If we passed in
slot+offset instead, it would just be an indirection that needs to resolve
back to the GPA anyway to issue the vendor migration call. But this is not
the blocking issue for the PAM case, as I'll explain below.

> IIUC this is the fundamental reason why you hit that PAM issue: at a
> specific GPA, QEMU/KVM can map different things, hence GPA is not yet an
> unified identifier for a physical page that guest uses.  However, (slot_id,
> slot_offset) will be.
> 
> If the migration memory access API will be using that instead of GPA, I
> think problems will be gone because then the PAM regions (likely, pc.ram
> underneath) will be migrated in form of KVM memslots, destination apply
> that to the PAM's (slot_id, slot_offset), then when switchover, that PAM
> memory region will be enabled by QEMU and it will be visible to destination
> QEMU when VM starts on destination.

I think using slot+offset won't make the problem vanish, because the PAM window
in the underlying pc.ram region is not addressable by KVM on the destination at
that time. KVM's memslots come from QEMU's FlatView at any moment and QEMU
reconfigures them on the fly. In the destination's boot-time setup, it seems
like pc.ram's memslot is split around that window, and what covers the
range instead is a separate, read-only memslot for the overlay, which is an
allocation with its own backing, not the pc.ram bytes underneath.
And since only the flattened view is ever registered, there's no slot+offset
that refers to those bytes either. Only when the source's PAM configuration
lands at the destination, which happens after memory migration concludes, do
those pc.ram bytes become visible to KVM.

In the TDX case, QEMU does not create that overlay at the start, so the
destination has a memslot corresponding to the pc.ram region that stays put.
KVM is able to do a GFN->PFN translation to hand to TDX's IMPORT ABI.

So, it appears that a UAPI change will not address this corner case.

> I'm actually not sure if such (e.g. PAM) will ever be supported at all in
> CoCo context, but it seems to me using (slot_id, slot_offset) (for each
> entry; it can also be an array) is more flexible than GPA arrays in that it
> allows GPA mapping to change on the fly if needed even during migration.
> 
> I'm not sure if that's explicitly forbidden for CoCo, though.

A TD private page lives at a fixed GPA in the SEPT, and I believe the
EXPORT/IMPORT bundle binds the GPA into the page's integrity check, so a page
has to be imported at the GPA it was exported from.

>>> Could you elaborate this ITERATION operation?  Is that something the
>>> userapp must do after full scan of a round of guest memory?
>>
>> Essentially, yes. TDX migration architecture delimits such pre-copy rounds as
>> "migration epochs" and emits an epoch token at each round boundary that needs to be
>> consumed on the destination. It allows the TDX module to verify that everything from
>> the prior round has been received at the destination and that two versions of the
>> same GPA aren't sent in the same epoch. It is userspace that decides where a round
>> ends, but any deviation from this model and migration would fail.
> 
> I'm a bit surprised that TDX will also monitor how many times the same GPA
> is updated per iteration.  What if below happens:

Yes, and maybe that is because it won't know the ordering if the same
GPA were caught at different times in the same epoch and fed to different
migration streams (which one is newer?)
On regular VMs, I believe QEMU doesn't migrate the same GPA twice in one round.
As I understand it, a migrated GPA is revisited only in the next round.
I suppose TDX just makes that behavior architectural.

>   ...
>   ITERATION sync n
>   GET_DIRTY_LOG, see page P dirty
>   migrate page P
>   GET_DIRTY_LOG, see page P dirty again
>   migrate page P again   <--------------------- [a]

QEMU shouldn't transfer P again in the same round, right?

>   ITERATION sync n+1
>   ...
> 
> Would above crash on destination TDX at step [a] applying P 2nd time?  Or

If P were migrated again, then I believe it would fail to import on the
destination, and also abort the import session, so migration would fail.
TDX records the current epoch against a GPA on every import, and I think
that's how it catches a 2nd import attempt.

> does it mean GET_DIRTY_LOG can only be invoked once per iteration?

We don't touch QEMU's stock dirty logging/transfer flows so however it
handles it currently stays.
