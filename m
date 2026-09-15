Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97834ADD80
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487615; cv=fail; b=Y0oNPvOra3TXqoh1kAFJaDmJAdt/wGpC21gnPu9srH+64/dwYQb2FpOONF5Z1LrURZ6OPWJn6Ep1k1yuRPwa4V8prnIl5GFQVadTbCg9zKPL0JawNRr9VuGXQXUxTDLTwz1RCmfxV1om69S5OTbLsQmjxoLdfaqbMr7HNrNSqqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487615; c=relaxed/simple;
	bh=gKA+DQL91uo2HX5ktkAuHud0FPCYOCZNHKUn3PoPReQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HRcS1gjwO/EO4cLBi7VzRQY1wJBPIrRxVjEgRCe87Dd7Dko0og68E2yZlTALY3aYk01QO2b6dV83LTUxwS31seDUCJzfRhPnjAloHOtx2Po2aie6xgIfojTaDCnzNwqTZZQovzqpWGjwmjPWrrDusn46yklKkSBTn3m15VF6UXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goKj1mO+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goKj1mO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789487613; x=1821023613;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gKA+DQL91uo2HX5ktkAuHud0FPCYOCZNHKUn3PoPReQ=;
  b=goKj1mO+hVQNznt3plznTxFN8xRyab1uT6Yk6YPAWRswC/XKudSkuMXC
   sG1HWp2C6CBnlbowFm2TbM4AZyp56QUu4lGMhQeMkDlRzhraCbCwsG6Bq
   +1uQ+ixmykYBlS085vy+uuGHlkI2BnaFAep4p9Is8Kgazg01LnHiXEI6t
   aVCMcOR0BwDiJlmoaFXyQCSCK39Wp59gneFMRz2sNO0A7kv1Z8Uvqs+Ab
   8MnKaZ+D08iexgKOrpjjYQpNDYjyifk0xBoRjsGtiUjZHCHBOgEfCCb10
   9o5Th7iS7jhEnqbkMIj2s4NI1VKu20Lu8vsAXTHd4u93tEx+zf4XQ1ELB
   w==;
X-CSE-ConnectionGUID: wRX9VfNuS+6qrAQnctnMog==
X-CSE-MsgGUID: PlTbr1EWSNmXki9uK2TW4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89988469"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89988469"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 08:53:31 -0700
X-CSE-ConnectionGUID: OE02NhdWS0GbWZglDGepAQ==
X-CSE-MsgGUID: SHqGEZdBRbWlFxREvI22hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277167258"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 08:53:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 08:53:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 08:53:31 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 08:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I69Mx2tfThqdJtrbfpvhKJZ+P99fXbmtfxDoBrSOsNShxcm9G65ct5kGssVdfuH7UpyAUVhiwdfZjPVeABTwdDzr0EEiZdvdH9RAuiQa20QZx1wZGQlSdvlEnJxZ0xa0YmTFWT8Ah8zEpahkoORHhR2daAhEW2caLm6igMDOf7bYAuZ0bYzqFABThxtnVvvThtMCFh8wrpv17nerPvjNUDa2yqBWz03ffEZt4CEPlj8ugQ3mTZAhEHuraJfHXyhmpmpdcEl6I5ZgFwERRfKaIhCPn7OKdQYDdaOzUhjYtFLlCMk3d5htKCYY/lVPndXlc2xYSaGF9BTWDNitYLWvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=migTJ6BA8keEEXPaBdP7lhJXzhi3YWcg50eeVpuHDWE=;
 b=DBlkj+rEzm9UmIOnGAzn2SuVNIIODoUOwnqeywOeAUHySIa7QFbPdPQg4sQYgHgxbl4oMm8WF5vedyEQiDynFlypEXOQyXTakpiHABOheVce5g2eLLM35KPmgV58E1JcsTrjGsbJEpOilshd8DkYCzbLcqhzvylIY1cc6gW44F9q0R4Pn+/tjs6Wb8sk5J2W9qckOAJCKhyaqnoOtQRs2FR0Yti+xNZn6Hfw4laW6+3TyJaIV+3xJ6hKfn9amUL0KNCBGnmGR650lKEC+t4tk9kmgA/udkptEWZYTfJf8pxMDXOOuQO3MsxQbwyZah13h0+kedHROHJzS4ntihj5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 SA3PR11MB526947.namprd11.prod.outlook.com (2603:10b6:806:595::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 15:53:21 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 15:53:21 +0000
Message-ID: <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
Date: Tue, 15 Sep 2026 08:53:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
	<joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
	<farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta
	<pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Steven Price
	<steven.price@arm.com>, Anup Patel <anup@brainfault.org>, Samuel Ortiz
	<sameo@rivosinc.com>, =?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?=
	<jakub.ruzicka@matfyz.cz>, Vishal Annapurve <vannapurve@google.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>,
	"Mika Westerberg" <mika.westerberg@linux.intel.com>, Peter Fang
	<peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Xiaoyao
 Li" <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<kvm@vger.kernel.org>
References: <ap64dFXpiDb_Hqxl@8bytes.org>
 <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
 <ap-SihGd0fk02QV8@tlindgre-MOBL1>
 <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
 <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
 <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
 <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
 <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
 <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
 <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
 <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:303:dc::19) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|SA3PR11MB526947:EE_
X-MS-Office365-Filtering-Correlation-Id: 5965a95e-8be7-4276-8a90-08df134177b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|11063799006|5023799004|56012099006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: y0vR0liR61LUERcFgtHaGfKwD9lRt20e3izBAM9ymYcE6R7iVnJBvMRc0q2flnKiXueLv4xyGH91Sb1dVTMY+ihkKhKpd3ynE2ItXQlm7olDTAc+HzrWuQKOeAwdYxBQDiFBIeyKxxp9pMXOiomPagmh9l3qml4D6rynw0anUJsNLPEHcqk1t0ahs/7a5mTA4vII5wMOc+sjrRVGAT7aLcjkonNUbjC1FkMyO/ItWp79903C6KtwNZciYIcNSVzdqtoKsLPsyKFqP3DUzrKfB/MKnGKJ2ZVK6gaNTKe/noW1Lv4y4m+tn9O0cUpuM4sJnePTszM/iydbner21+M9P8DGOcDDsUyDGvHeOfBkw/Zc1J1vcFW3x+tCn4tVtGQjq0QFPk9EjW9TBAjYafcW7yOiprmUr21HnyPM1fVMPyKL3d+W5XZcjsCJFPufA3ZubE1uaMZbVTaRTdf1WY0aeZs40mD9znmaNU15PjXSvQbpWbRaMxM9tHYHKYbr156ZHzfgWJkO7xfJXoHGF4HIiNJJ/r6iuCMwRNSz3ct4zPV5GI3m0ZU8hKub5BCjaEdg6nyzislNPyo8WCcooG/RPXBdhV19FHAr1rItjdrXfmfjoDEu+YSr/qUlAj7brOgBJFsL0/1Rqe+wK3jIe38n1zFdQcqRYmVeWtf1MXze+b4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmROWHRJMWlDdWErdTd1V1FzTGljY2swWmNGeHZjRTJpOUNZTlZiVE04SW1W?=
 =?utf-8?B?d2w5RGZ6QUFkakk4L1U5bjZTYUs4MXh0aFA5QnI0YThtV2l2T3Zoc3N2bUFs?=
 =?utf-8?B?bjE5dnpHZ2hnNk9xMVRDbzc0T2NETTJkSUVJODNzcVhZdnljS0lRWkcycnJC?=
 =?utf-8?B?bGFndUE2eDZXTkJxTVZKaktFVjhHaVBabXh3OHNqcjNBSmt5cUdtc1lnR1BU?=
 =?utf-8?B?b1pHMFNrU3NmYmN2R0JkOXJ5QnNPeHFyQ0tRa2FSYUdYS016amJ5Q1ExaHMy?=
 =?utf-8?B?QURHZjR5WkhDSE01R0ZodGVtUEloTzZJTGZnS3lmbTNaVUpLSGROOVZDbVJB?=
 =?utf-8?B?aEozMnhCK0UvMStFUXVZUlpnNUNRMEpBem9oS0I2QmU3UlVINXZPbUtJOGlZ?=
 =?utf-8?B?VEtwS2hqMmFmRFlIOXgrRUFJOC9YSFFZdVpWaWUrUXhoWmdEV1NSMWxheE02?=
 =?utf-8?B?bW05KzhmMnRXeGVraUtuOWRxN2llcVlNQXhFNTdrTDRSS3E1dVJlcG8reU1Q?=
 =?utf-8?B?Vkg2SndKVzd6dzlXdWZ2UlJTNzkwVFFoQWFTY21CQmk4Wjl0a2hrWnFXSXlV?=
 =?utf-8?B?RTREVzY4SEV4S25UbStnTlptcFRCSWpHRTVBTFZhS2pzY1hOSWNHeldiSFJr?=
 =?utf-8?B?NWwwNVY2WE1RT1U4T1Q2TXFIMGVkWVd4SEZybmtlTmdoc3h5T2dVZGVsTnNt?=
 =?utf-8?B?OVFFVjJ3dEtyWXJleGJqOTRoYlF6QmcwQlk0SHBxc2l1eFRSL2tJQzc1b2hH?=
 =?utf-8?B?cG9PSlRSQUt1eTlzSUdkSjZkc1lxTjlTWnp4QWw4dDhCWlg5Umk2VHRWRjhq?=
 =?utf-8?B?TWJXeGlLZ3B3WHREUElJMTVUVTRPdmN2RzlCbjEvVVk0RDRrSGtMd1ZaYkRr?=
 =?utf-8?B?QTVnNUVDYkVvcmhUbHlRemVCTGlBdFQ5L0hZZGxvaHp3MWNsaGdiRU1wdUN2?=
 =?utf-8?B?TDNTNlRNSnJVcnRPdXc2andEZ0RRTkZ0UkRGMFFQZmVFWVM3dUxiUmpLYlhG?=
 =?utf-8?B?YTNJSmpycDhLSzhvOEpMSk9TMkFrd3JQSnJoWEl5ZndTMnpiZW5JUWpoL0g5?=
 =?utf-8?B?RCs4WjZ4eUc0NURIR0U3NVcwVWNPMDFpb0x2WTVETVlma1k4TG01ZVVTZTlC?=
 =?utf-8?B?ZmVtdkFhYWwwQmlMZ2pBVXNydlFQS1BEZWJBUVovQ2hxMjQyVVNFekNBckxB?=
 =?utf-8?B?WHJJVGY2clRDRFZrWWNFV3NXTzhzK1JZazFYMVdnT2wwa0JENzZPTXRzUURE?=
 =?utf-8?B?Zlpjcmo2em55VTJvZ2xodWw2WkNjU3FFVXg2bjBXMUZyM2VuRzBjMUZZT2s2?=
 =?utf-8?B?WkU0Q0VVcTI2VVQ5RUR0OG4rSU9XR0pUSTR2ejZic0ZqTU1yK09OeEh4TGdY?=
 =?utf-8?B?VHcwS3hpZ3grU2owL0JSSEw0UzNabm9aLzl5SFZaYU5uWWpJa1BHZWRDeTBN?=
 =?utf-8?B?YTZSU2dUL2JZMEZFc0JSUVE5bVB0SHBvSklOcWk4TlRWUXhmVGxlS3RpT3gw?=
 =?utf-8?B?OTNRT2VwVEJqRHkrQ0ozSlVWYmxXU0VYSUQ1ZWVESnFBZXB2ZjE4SmptdGtI?=
 =?utf-8?B?NzVSTDUrbk5qY1NhZmVvN09CT0dtdzhMVzlsa0tobU02SUdrNncvSUUwOE43?=
 =?utf-8?B?UGtBbmtGbjAwU1RnbCt6MzcydmJqR2N1bytZOTF1cFFaS2ZyM2p1SW1pNzU4?=
 =?utf-8?B?bnFOb0dsT0NuSmJZT3RGQXltR1RNQzZqZFB1R0N3VFBoc04wdE1LWHFXTHdt?=
 =?utf-8?B?TGJhcnRUK05tQy9hS29oeFdjVTBmOUpGaFJTaElkN0NBcGpVSFdUQmJEVHBs?=
 =?utf-8?B?WDEzZU9TMHllT21rQXpZMWwrcXlPbVY1YjVRQkk0L3JVOVIzTTUxUlBKYW1Q?=
 =?utf-8?B?V1J1WUtJMmF6cmJjb3diWTFSN09QeERHT0tNZ2pyZzI1a251bTI0S0UxWDV3?=
 =?utf-8?B?TDFzZ1RENHhxYjZvTGtnVGxsKzlsUm1SNWZqSEw1YnVlRWV1YkpnQnpjWFlo?=
 =?utf-8?B?ei9JemQxc0FXMzR0UWY3VUxjRUEwWG5IUTNpMG1NcHRvSXhqcTIvV0lpUlU1?=
 =?utf-8?B?WVBuRjk4WURWbi9QM29Bc3BwUXpnZCt3YUhkcmQrWUpaSXExRGhzVVd1Mk1N?=
 =?utf-8?B?cHBZZnBOdTNJQm9BRDNLWHd6dmVyMTB3M1JLbTB3U1p1L0hTb3NiVWFMSmc4?=
 =?utf-8?B?aE01V3RZTmF2dHpYMHJaMFd0bnZzVWs0VldORUpWTmp3MlNWV254akkrbk82?=
 =?utf-8?B?Tk9WbWJMZk9yeXoyTHdlZ0F5YUJVWUltOENqMlQ2YVJKbnMva1g4QlNraGRj?=
 =?utf-8?B?Z0FUZ2YwT1RVV0VJUVhaUWZWZERIMXF4ck5yL3hHelVpUGovZ0NOUT09?=
X-Exchange-RoutingPolicyChecked: 5G8hfw/4QdisaSXmk9t60CBM8YObtCkX2rOg34LZd1q5OS7uo4FNXuIZqGRrebehvKYSm5ETDW/m/Sv7JlOxL9IR4XOwMUvE7P4hxpdN4yk+XwsAtkCsV3k+78YZP2ZCv0omrda9ab1HlmmIfufBwrGdt7RE4kp+NLrevivxPbO11u2HyB9BK4EWdRdmGQeZFd/7x+2SPkTTMv1ze2Cxf4vIx19qWBvvnrvCIwfUrHHPku6KaV7V+MQKeRyIKc9fCLic64TvLqFIkzV4RyA+ATE/AndXamrgmnzXm4JQk5ARZpwkV21Ot2KPLsfbF+MSrCHZABp9gGheYnyQzoQanw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5965a95e-8be7-4276-8a90-08df134177b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:53:21.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL0uL3s1dzBhbMKuSr7jtKutHh90Wz9ZwSZFPzQoyQh2/iOT2l8ZmR7jRfH4+d+o2Ebb1g/YZimteErUjDRT9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB526947
X-OriginatorOrg: intel.com

On 9/14/26 9:44 PM, Tony Lindgren wrote:
> On Mon, Sep 14, 2026 at 05:14:32PM -0700, Kishen Maloor wrote:
>> On 9/10/26 9:23 PM, Tony Lindgren wrote:
>>> On Thu, Sep 10, 2026 at 06:40:04PM -0700, Kishen Maloor wrote:
>>>> On 9/9/26 11:33 PM, Tony Lindgren wrote:
>>>>> On Wed, Sep 09, 2026 at 06:11:11PM -0700, Kishen Maloor wrote:
>>>>> ...
>>>>>>
>>>>>> As mentioned above, that is a destination launch time directive that we needn't
>>>>>> conflate with a migration/transfer session role.
>>>>>
>>>>> It's still the same role though. Yes we can set it on init, but would
>>>>> be nice to have some generic way to do it for qemu -incoming.
>>>>
>>>> I'd separate these.
>>>>
>>>> On the role: it seems we agree on recording roles per-session. My only point
>>>> then is that a VM created through the delayed_init flow doesn't additionally
>>>> need a destination role recorded for it if SETUP will assert one when the
>>>> migration is kicked off.
>>>>
>>>> On generic plumbing for -incoming: is this about KVM_TDX_INIT_VM_F_DELAY_INIT?
>>>> A generic mechanism would make sense to me if the flag were consumed by generic
>>>> KVM code, but that isn't the case here. Userspace has to make a
>>>> vendor-specific VM-init call like KVM_TDX_INIT_VM anyway, with the flag passed
>>>> on that call. So I'm not sure what a generic version would add, unless you have
>>>> something else in mind.
>>>
>>> So we could add a SETUP subcommand SET_ROLE or SET_INCOMING.
>> It might be better to pass the role as a parameter of the SETUP call
>> rather than a separate SET_ROLE call.
>> A separate SET_ROLE would bring its own ordering rules relative to the
>> other SETUP sub-commands. 
> 
> OK a flag for SETUP sounds good to me. SETUP is needed anyways for each
> migration session.

To be clear, I was suggesting a field in kvm_migrate_cmd and not a flag to pass
the role as an argument to SETUP. As I mentioned in my last comments (right 
below), 'flags' in the current proposal carry the vendor-defined sub-command values,
so a generic role argument wouldn't belong there.

>  
>> The specific role (src or dst) still needs someplace to go, and flags is
>> already the sub-command selector. An option is to carve out room in
>> the __u32 reserved field to carry a role argument, something
>> like 0=unset, 1=src, 2=dest so KVM can verify that a role was indeed set.
> 
> To me it seems that 0=src can be the natural default starting point, I
> don't think we need 0=unset.

With 0=src, the field would only carry information when it's a destination,
thereby making it an is_dest boolean rather than a role. It would also mean any 
VM that never established a session still reads as a source, so a 
KVM_TRANSFER_MEMORY aimed at the wrong VM by buggy or rogue userspace would get 
dispatched to the export path instead of rejected outright. The generic 
dispatcher shouldn't have to rely on the vendor layer to catch that. Reserving 0 
for 'unset' costs nothing and lets KVM reject a session that never stated a 
role.

> 
>> It could further be written into a generic KVM struct (kvm_arch or kvm) which
>> could be queried on KVM_TRANSFER_MEMORY, etc. to identify the relevant
>> callback.
> 
> Yeah eventually some generic place for it would be nice. But that's easy
> to add later on too.

Sure, we don't have to decide now as we're still discussing the UAPI.
But we'd want this detail also settled sometime before we call the UAPI
complete as it determines whether the dispatch is generic.
