Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4310345EA9
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615913; cv=fail; b=MUCQAjk/W9fzOP5WTYaXPmuhbQ9atDpzEHIFFm4m0bZ+ItU2VQddYbHIcR4TMVGpmA5twuQRR2HkajrsWqPoRb4KknC+oxnZriy1VnbeTynf/77pEEEXBYUNIZ2EmCYgI+CVRjU+Dv1wZU+4Y6c8Q71IT78YufDo7Py/E/3r6SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615913; c=relaxed/simple;
	bh=/iCiInEHmjuw6PqFFtV4Pbm+nl3N3gDvgoArUJeTtG4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QEK3slOPu/DgRAV4lpJ/F3M8YlBQuGuH3WKKn5AAQQxujGlMBcCUv7Kl2wTg4w7rqGGoMBcvcs1B6sV5J0G+p8piFD8+mL1Cbdy4O7+q3Vzhr61WXlS9bAm3VO5ddUy74i1VhOhH+S1rZrYYbjo3/ZXwi3DWq7TeXGlvh7rbtU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZaIMRPX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZaIMRPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789615905; x=1821151905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/iCiInEHmjuw6PqFFtV4Pbm+nl3N3gDvgoArUJeTtG4=;
  b=ZZaIMRPXj4nUPjMQO3oH4wy4/FcUDDHgm+U1CFgheHOHLTSfacebAb9k
   Z8x6qbQvn+7bTaYGnVO2ln7g8C/fVC1+z0Y9o4NjcBY5hpNlpI56towch
   aZaslw8UHn5RV6s5/09ukHlZzo3bkIwRv0AaaSDsD3WxCWifYaBHtij4a
   +CaUXDnrYDdC1YqfJbryQJFVEVH7zzo+1Blhvl4nOeCAGc5lhQpstqSMA
   3HNQGQ3FKQqdgNhp/YFq/gIEOJ+ZVBM0Xcen4bDobRLPqS268ny6sjWrm
   iYj1JtO/tINr7eugzVyb5Dtyub06PpEFF0YI9TFshsAGlmpld11t5dcFG
   g==;
X-CSE-ConnectionGUID: 2LW6No04TrG0GrMIH4aS/g==
X-CSE-MsgGUID: o6knqZ0fROuEm062PxO70A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93702135"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93702135"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 20:31:40 -0700
X-CSE-ConnectionGUID: bTWejeZQTDOMU4JRtEw5Ew==
X-CSE-MsgGUID: sK0l2BKnRAaav/9vIxaI/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273059218"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 20:31:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 20:31:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 20:31:40 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 20:31:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLaSJDlD7DRNiMKwnM1tXDjbYGAT7zxWluhBmkySUadES/KxH4lW5RrQc08UGK0dKaK3TWIOQcHvcQNZf2Rdh+Ts9NjSSx6BUvpvlX/esn/Q/6z9RlsgVQeO0Qaw5ZHCaC00QBSokFUDKIeHgj2+TnGuZ9SFtu2SxsYbJgSuJp5ee19aM8yKNTjgVNc5OsQvgpHq3mKzkSaIEBW4FOudKglUjgj4sR1hNeTAAB28Hte7v8+Q5kcZ3KWekQqjg0hL/wfc2Y3GBd+JQYLcQEAtjAkfLUAHmREyNMLaHE/63G1M5NQF8vyQ+OoQ2bpOaTWrV61GBiAKrL5vz6JcNUr7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjGTnrUczRpoi3eW2yGUhWPsHEf5m9Uw+5XOGELioS8=;
 b=h3u9rB9IFxnDrkrAAEefz9/3uXMDerpsMikZj8MpOPSK6E1xq0NHPaev9acxjiBPYrFvVGSnbXVkOR+PYFHsqP6f3VhG5didxblyywyyeIjC7JAUmoHGsPctSHA5LC/Y19qAB3In7VICOWfFh7ztcsxaXEm151fq5XHFSkDhrLUIiMwwvnthDHmqA8uNi+zUTSuDWXQT1oJqC3MIC6S7D2UsJxO9usNU82tRtx+su7wmot/5EUovNv5TbFc7uOW02z8pAiRCju+iX7teEF7GoHcNgOWq08lZIFkxTiS+EntHd/EN5h+aJv9FjY4cX8sVd1HIiyWyYgWF+MORi8mEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 SA3PR11MB7526.namprd11.prod.outlook.com (2603:10b6:806:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 03:31:36 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 03:31:36 +0000
Message-ID: <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
Date: Wed, 16 Sep 2026 20:31:32 -0700
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
References: <ap-SihGd0fk02QV8@tlindgre-MOBL1>
 <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
 <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
 <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
 <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
 <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
 <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
 <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
 <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::15) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|SA3PR11MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1c6b93-671e-478d-91a0-08df146c2d25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|3023799007|4143699003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GwI6eZmDVAfLQv8ISqiZ0ZGq6P2NGdxWT1dt7QEnt2+PuoGtCQcY/cRwlKwxLqMXobqmzZzBSulifbYoLsYhvHfEEBvc+wI5KuX+GlfTNxKJa3PhHz9ccv5YYE8AeJWSnY/CvDzrzoZ+SB8PZ9d6/gYByrcRK1+BCoDKaGVdVoF4RK1DLUeyKKnJ7w1wI1j/bZ/FRcXi0NMWnvJai8V3rFbpHpMXZq9YDfb1giHRYzz/LfoseVodrQitgdb58qcPQbKlfgA68D96XJUT8l/OIs7Ivwu3pSaZmR0xBzwU74Gs04j+0eYkZOGlHQWwGWsSL8hSJCtSDmZM2ymK/ykl923ZYgnJEKzGvegqa8x7STU1YTowviH+0lrzydx142T2uGxFeiXIfOYI2fW4Jpdivdmu5+FYBq2YVCPEAB2Pd6v0KGACuyCgeBlPCgNxx/W/jqLaovP3Dbvv5wJ7jJ++ln3ViftRpoiQ7ZWGnlhJ34pKhCVYABoAnAvaDRYnVeQ9TZeAjuqEnCbB4YuW2RNt/I8j9ubfTRpG/U2T8UnWPdwjObkUpI5t9TY+OdgZy0jASzH2uHKlyPAHNvY98eKoNpRr5JwYHPYXvUvqQ0G8e5/tJYzi5SNSgTaJzuR3EMzejmNGlC7u4wlRWWjJvLVgYUp0LnjTZ9KjEmShxZzJmK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(3023799007)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkF1UmdpVm03c01rL09IWnQ2Qm1BYTNZbDNsZlV1b0NNTzVtUkM3QzJMQ1BV?=
 =?utf-8?B?NWQrZmZkVVpxNGFGOEpYSFNSbnhGa2hTWTN6Y1Z5N01MWTJZU0lyRWh1SXEz?=
 =?utf-8?B?a3RPVFhlRWdrYStVQkpYQTVYdTJkd3VlUG1Zc3lycTdxVGd2WjBHMGRpSmp5?=
 =?utf-8?B?clNuN1ZQUXNSaWVwWnNXYTFnaVZkdmdlTWFQYjVKK1h4TUlLTTI5a1JyNUkw?=
 =?utf-8?B?Qnlwc2VSQXp2cGhtOHZhQjMzcDVzcHZwMkVKb0V1cGxCcGJuRW42blpVKzlh?=
 =?utf-8?B?VmdWVWhDWk8rTGRiYlIxaFVxelJCZU4yOS85T2l4VUxQL2RlbU94TDRHa0I5?=
 =?utf-8?B?bTNkSGgyQUdUM055NFFSMHJtYk1xRWdUbnA3ZTE1cGI0ZDk5L1NVUHNVK093?=
 =?utf-8?B?QjRuT2QxNnlJcS9EQTQzVE1jRHQrYWxUN21UNllkUk96cDV5N3pRM2FWdnZq?=
 =?utf-8?B?UGhUaUk1VitlMCtONnBJeXBPb0FjWGpkYjNDNUNtbEJIc2g4ZVF3bHQxSnhs?=
 =?utf-8?B?TjNQY2lyQmg5dHJlTDVZcm00ZW9lRjhhN3dGdys1ZkQ1eTFueW1HakhnMmhs?=
 =?utf-8?B?dHZIdEFmOW9LVlU3ck5FU1VJTlRQSmlhWUFiQjY3Y0YwSVJwWVBkZUl6MEUv?=
 =?utf-8?B?TGxWYjRDM05qQ3hFajBDRVN2MXVIdUF6bGp2Wis3MWFiaHBGTUJMaUlRbVBS?=
 =?utf-8?B?STl6UXJzTEo0dU12eDlrY1N2V1BvNjIwN0M0bTJFc2gzeTU3dml1ZjcwdkRT?=
 =?utf-8?B?dm1tVldnRFhLU0RJVUVGWWFzRnBWWGRJTTJQNEk5alhsbWJjVHhHYnk2S1pv?=
 =?utf-8?B?OCtiU3ZEZXhBalljYzZoQjUwRlFBZXlxa202SE9qYXJ5d1pPZW9ZaHNvVlNo?=
 =?utf-8?B?NUN4TlZRcXBNeGI5Y2lGYUQrQjBYTms1ODhCb3p0VEFCb3QwUHlXdlBLSmZq?=
 =?utf-8?B?ZU5LSGs4aTJseVFCZEc4eXpaYnhEenhxNnZ6QVI5R0dZbXg5cmJhL0xsOWVB?=
 =?utf-8?B?R09SS1JDZVR4ZjZYY1NKRlVtRE5GTVNwVys2OHlEQzRnQXd0bzMvNTVuWm5B?=
 =?utf-8?B?Znd3bU5SeStXR0ZPck1hc2oyQSt5TXlDTzh4RVRtQ21kZDc5U2V2WGVnWFpv?=
 =?utf-8?B?UGZDSk5DUDBJOVlxUmFpQW9GNG9kZXhYYzVnV2RWUHRLQmJ0UVl5Lzl6cUxS?=
 =?utf-8?B?QndDdjdrK3N2MENTYk4wMzJ2LzlRSnRQQjBTR0hnSHRXMnJ1ckd3TlQ3Uy9L?=
 =?utf-8?B?RjNib3lTUUlxU2hZdXpRU1VOblU0TWorbzJMR0JpWWZhS2tpQU16cmFNVEhV?=
 =?utf-8?B?a2JOZFVVWFpsQTVhamRQc3FTN3hLWDVxUHo3Ri9sNzl4VS8vQy81alYrSEtl?=
 =?utf-8?B?dlhWYzlsamFKdURMVG8xd1FYUi90ck9tVFJBdlVqWlRNREdlNjhrTnBSL3Zq?=
 =?utf-8?B?amNqVUIybUx1MFkrNmZkdXRIN0VmZ1NZdnFreFBRWVJOWVR6SndPSnROYXY3?=
 =?utf-8?B?OGNYYkNiY1lUNEdRWnorUXNDQkRPY1NlZk84ZTlsTkdhUi9lSXFTcUtOVm5h?=
 =?utf-8?B?dkgvMGMvTlg2Kys0ZnJmamUvdUZrUVBSbWJBTGVzNk9ZZmFNUkFuRWh2K24x?=
 =?utf-8?B?NGNWbm5kN09oSnU4QW1KMWkzRnB6cmVrSSsySk5kcStiMlFPTDgxbjlacGlC?=
 =?utf-8?B?TjlCdThCSkUya0xaWjVxNlEvM01HTW15c3lXZ3FUbVFyR0k4cE9wc05jclFF?=
 =?utf-8?B?aG0wRmllM1ZYYzdGT2Z4TFlGaFAxb3RnbVMzbEZsQ1ZTcVBjNlE1VXlYVUkr?=
 =?utf-8?B?SU9aMG4rVzQ4TGY4V1JpU0V1amtRbHhveFlhZU9EOFdmdGs0dFdSdEh4dkpZ?=
 =?utf-8?B?MktBZmVQNWx4alcxdkRnbW85SEwyenJFRWFMV1p4YXNvSzRtaUtENEVDcWpP?=
 =?utf-8?B?MFRTaVJXdU5zOXdGUUJIWE9ac05JRWRzbzFjWHNwbmtKa2hPeE5MclE3Nm9P?=
 =?utf-8?B?QkhSQUprQmNBUnpiNGFsYmpkZkxZcklPT29Jc0NlQVJRRTZTRU9TSm14eGhk?=
 =?utf-8?B?SEE4anh6d0xEeWdKckMvN052L2F4Y1lRNEF1b3poaWtaR0liWU0xVjM3OFFy?=
 =?utf-8?B?OHBMTk0xZWdZZlBkbGQ5SDZRM3Uyejhnc0hTL2tTK2pZNUJGYURVNVhHaUFK?=
 =?utf-8?B?TTBoc0tJeGo0K0tmUVUxbXlZckhDUC9GaDJSa1lsN056cnVmZ2lzeW43YjRi?=
 =?utf-8?B?eVdLWWtneGIxbzUrNmY0OTVJU3YxZEhRMEViUVhZeHpWZHM0cHUyenJmNVdi?=
 =?utf-8?B?cUFTdDc3UlRaSEsxTG91WWNENkF6Q0dxblZIdjJuenBhOWZrRG9CZz09?=
X-Exchange-RoutingPolicyChecked: ngMLFfUcfP3QQebd54ugwZat97t9x3I/LbxShwxWloHElj8h5oGAscqN9ktvqzR+4h2AWGgprIXkyAcRV/uq43mcfnkfNv2hkFG90M5dxGi3MmvDMOTCFJL3W/vx2TrLXQEeWeZW0/3/pq3zbGvbkpn7IAKp6fvO6PHVPNbSFyRaunHaquQD4UBxWWRHSpsGCuNDH/HXN/gu87yfBr4hXs3UTT0H2YKy3L1dNWdwF+416fsjDim9tTawE0eIRDxKR4bk6yM8SpFSgsJ/F3ioCrRLddcs6PPz6gTy3gUt69mUTU16kyQToSPvaoEUNzCBPBeJsclMkFIwB1DBlfH1gA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1c6b93-671e-478d-91a0-08df146c2d25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 03:31:36.0281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hjzyJ0aA3eF6ZRnAOizPW0Ruf5VSU6ptQog/auJlTUsh8mymxdNgK2OLcZv05GaTVo3iKd6YzY20qBA19HWaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7526
X-OriginatorOrg: intel.com

On 9/15/26 10:09 PM, Tony Lindgren wrote:
> On Tue, Sep 15, 2026 at 08:53:18AM -0700, Kishen Maloor wrote:
>> On 9/14/26 9:44 PM, Tony Lindgren wrote:
>>> On Mon, Sep 14, 2026 at 05:14:32PM -0700, Kishen Maloor wrote:
>>>> On 9/10/26 9:23 PM, Tony Lindgren wrote:
>>>>> On Thu, Sep 10, 2026 at 06:40:04PM -0700, Kishen Maloor wrote:
>>>>>> On 9/9/26 11:33 PM, Tony Lindgren wrote:
>>>>>>> On Wed, Sep 09, 2026 at 06:11:11PM -0700, Kishen Maloor wrote:
>>>>>>> ...
>>>>>>>>
>>>>>>>> As mentioned above, that is a destination launch time directive that we needn't
>>>>>>>> conflate with a migration/transfer session role.
>>>>>>>
>>>>>>> It's still the same role though. Yes we can set it on init, but would
>>>>>>> be nice to have some generic way to do it for qemu -incoming.
>>>>>>
>>>>>> I'd separate these.
>>>>>>
>>>>>> On the role: it seems we agree on recording roles per-session. My only point
>>>>>> then is that a VM created through the delayed_init flow doesn't additionally
>>>>>> need a destination role recorded for it if SETUP will assert one when the
>>>>>> migration is kicked off.
>>>>>>
>>>>>> On generic plumbing for -incoming: is this about KVM_TDX_INIT_VM_F_DELAY_INIT?
>>>>>> A generic mechanism would make sense to me if the flag were consumed by generic
>>>>>> KVM code, but that isn't the case here. Userspace has to make a
>>>>>> vendor-specific VM-init call like KVM_TDX_INIT_VM anyway, with the flag passed
>>>>>> on that call. So I'm not sure what a generic version would add, unless you have
>>>>>> something else in mind.
>>>>>
>>>>> So we could add a SETUP subcommand SET_ROLE or SET_INCOMING.
>>>> It might be better to pass the role as a parameter of the SETUP call
>>>> rather than a separate SET_ROLE call.
>>>> A separate SET_ROLE would bring its own ordering rules relative to the
>>>> other SETUP sub-commands. 
>>>
>>> OK a flag for SETUP sounds good to me. SETUP is needed anyways for each
>>> migration session.
>>
>> To be clear, I was suggesting a field in kvm_migrate_cmd and not a flag to pass
>> the role as an argument to SETUP. As I mentioned in my last comments (right 
>> below), 'flags' in the current proposal carry the vendor-defined sub-command values,
>> so a generic role argument wouldn't belong there.
> 
> I was thinking 8 bits for common flags and 8 bits for vendor flags but
> yeah that can be a bit tight. Sorry if the SETUP above caused extra
> confusion.
> 
> So trying to summarize the common flags for the role and separate vendor
> flags:
> 
> struct kvm_migrate_cmd {
> 	__u16 command;
> 	__u16 flags;
> 	__u16 vflags;
> 	__u16 reserved;
> 	__u32 reserved;
> 	struct kvm_transfer_buffer buf;
> };
> 
> Is the above along the lines what you were thinking?

No, I was suggesting a 'role' field carved out of the 'reserved' space,
like this:

struct kvm_migrate_cmd {
      __u16 command;
      __u16 flags;
      __u8  role;     /* 0 = unset, 1 = source, 2 = destination */
      __u8  reserved[3];
      struct kvm_transfer_buffer buf;
};

We haven't defined any generic flags. Thus far in this proposal 'flags'
contains only vendor-defined sub-command values.

>   
>>>> The specific role (src or dst) still needs someplace to go, and flags is
>>>> already the sub-command selector. An option is to carve out room in
>>>> the __u32 reserved field to carry a role argument, something
>>>> like 0=unset, 1=src, 2=dest so KVM can verify that a role was indeed set.
>>>
>>> To me it seems that 0=src can be the natural default starting point, I
>>> don't think we need 0=unset.
>>
>> With 0=src, the field would only carry information when it's a destination,
>> thereby making it an is_dest boolean rather than a role. It would also mean any 
>> VM that never established a session still reads as a source, so a 
>> KVM_TRANSFER_MEMORY aimed at the wrong VM by buggy or rogue userspace would get 
>> dispatched to the export path instead of rejected outright. The generic 
>> dispatcher shouldn't have to rely on the vendor layer to catch that. Reserving 0 
>> for 'unset' costs nothing and lets KVM reject a session that never stated a 
>> role.
> 
> Ah OK, yes that would also tell "the hardware has been initialized to a
> certain migration role". That seems like a usable common feature.

Not quite. It tells us that userspace asserted a role for this VM's migration
session. Whether a TD was created for import is a separate, vendor-level detail.
The generic layer only needs the role to reject a session that never stated one,
and to pick the export or import callback. That callback then knows which side
it's on and can reject an incorrect role (e.g., if SETUP asserted dst for a src TD).

>  
>>>> It could further be written into a generic KVM struct (kvm_arch or kvm) which
>>>> could be queried on KVM_TRANSFER_MEMORY, etc. to identify the relevant
>>>> callback.
>>>
>>> Yeah eventually some generic place for it would be nice. But that's easy
>>> to add later on too.
>>
>> Sure, we don't have to decide now as we're still discussing the UAPI.
>> But we'd want this detail also settled sometime before we call the UAPI
>> complete as it determines whether the dispatch is generic.
> 
> Yes a shared place for the role would make some generic sanity checks
> easier.

Agreed. The field above is just an argument to SETUP. Where that role gets stored
for KVM's top-level dispatcher to check is the detail we can settle later.
