Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD69386452;
	Wed,  8 Apr 2026 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775691701; cv=fail; b=h0uyBEoLLV/4pXrto0k7bXJPCmx17OOWGcKlIa9ccmBYhnckkd6WPqNfnaQbQxslDBdsOwiIDQSEO9VEG3xkEhrIIBJOGpXpjJxj2GKpoyNyPz5tuEOtJUMU8+fnndHcx6/OgApLJHa6J6aI3xcNEQ8IFEnt5sWOiRmlp137GWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775691701; c=relaxed/simple;
	bh=bTTbwayclp5asBmYaEEPgwvEOZJJI9UKV16sfwwQXw8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L8z60beOwSA+nM1Q6DGkFB478dbH4PfE+4He9HSXYdD8zw7WBdqTPLTwoVsFu6vJ51HIM5TTuejX7Dx31wLyFvU/PldO6MZJpVURaIGjnv2q22MqdQ/yUV4Bcv7ZNkkiLBDg1+upRjmcIYSoQnzeKrK5jUW8XzChDWrbqoLK9vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEqRGOQp; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEqRGOQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775691699; x=1807227699;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bTTbwayclp5asBmYaEEPgwvEOZJJI9UKV16sfwwQXw8=;
  b=CEqRGOQpGS1ugr/n5ebMXkXkPAGPGS+B1lNlxNoDN3AWvndQQVGBPqA4
   YFjLz0qFP1SI2RYVOiNkKSxrfCK88rOjHTl40V8MlQa48jNriMwTjk7s5
   JgZeAQf1U3USudCQkzdereKNXOE1/RIxepnulWuDqih39uXMUSmwUz5yn
   40DpX8HVep7P0jmhT1XJeWpXE/V7gozsDdU+q420u76mRhMLVHCt9H9kh
   tR1IA07+JIUIeOmOrCHufEBtyblikdgmIGudPJr9qwVlHJ0z4scyKfsiH
   vISAtZEmxUvUCHUa05cC0ztWp8MOYZ5I1xt6zZmNcFiJRClWatDLmL4rB
   A==;
X-CSE-ConnectionGUID: SpjKFF0aSWu7UtTasuE1bQ==
X-CSE-MsgGUID: WWmEsr8wQ0e3mFQKcGpp5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76404580"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76404580"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 16:41:39 -0700
X-CSE-ConnectionGUID: 957JeMflS8iKZAezojtPJg==
X-CSE-MsgGUID: njYDkMC6QMylvuIV1RfcfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="233491744"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 16:41:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 16:41:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 16:41:37 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.49)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 16:41:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieUFTy1rKSKBWSboMpD9N+6c/vMw/o8lIDgiWnciQfA9JE2mdCI0So3mUVCqUsmO1uUqId8G5Fzz+UU07g0xXPui3ekVyBN4SPXycrGyhVu67ff0vB9M8KFILHBSXQ3KlOqZrG/0/ZinW24nGUMeS+ZmUjvxs4jRQOno7OU8/gocFJxp9i2o6UhbC1lFxxCf17ZxKZ/yBl5+uxnqIy4mNuj2EbejTIr+H91EbNLPYb8BADOSFFOSp7j334leFUltR9bq1keSD6Sfv/TwAYA/4pOkio5pe7Zo2navdn/AVH72tYD+D3A/WVLM4J0QbNNM+vT7MMrtu0hAkzI5pa1DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnIHbRCW/6GDbXn9asPXcQxE14sf/TBNNX08POnc4RQ=;
 b=kerQZ3abDnN0L3eJ3FbREyyO5Up634nQ5SmYLXkOyMixMgO3I1+5H8/aixDbZoUleSLj23cBvSR2cd1m84ec7kRInS8wnx39g0Eqtgw8+PSk/lBnLlInFok4hKsXMMOcK49UKhT6VXgzhM7fpHlj5P2qeKyqLOLc6wSDrZh0sTvKVLPICET/3EZP0L1Vh+vG4t0lG9Cqx3KFfe+GfUENEOEELsQfbfpkEIGFj4xFLT4azLIn+7+ZmfI994KK+Znt+KN6Mq2mqMgU8A12zGrtkg6zDM0tMck5ezfg6aGftotQ/iD2Ks5gJEGI49VPHUkUODYU4/DR/Ll7jZXFkizJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8250.namprd11.prod.outlook.com (2603:10b6:510:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 23:41:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 23:41:32 +0000
Message-ID: <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
Date: Wed, 8 Apr 2026 16:41:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pmladek@suse.com"
	<pmladek@suse.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "elver@google.com" <elver@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "lirongqing@baidu.com"
	<lirongqing@baidu.com>, "safinaskar@gmail.com" <safinaskar@gmail.com>,
	"fvdl@google.com" <fvdl@google.com>, "seanjc@google.com" <seanjc@google.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"chang.seok.bae@intel.com" <chang.seok.bae@intel.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"eranian@google.com" <eranian@google.com>, "peternewman@google.com"
	<peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
 <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
 <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
 <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
 <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
 <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
 <72297351-2954-4318-81b6-7de409e5552c@intel.com>
 <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f14067-1976-4352-685b-08de95c85d6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8PwlGjJkMhzMor1VKonMm6g08QjvteNm0vBtpVQlglQ105VfZgagVYJqxKTo6fR4TnDF0xF5ZojpivTYKSECAecuRqGKmABINs43o9D35/xifmNeUiFiKZG1+YOBt5mqCn6baXD4KAOpuDcowFHTFQ5Ind5Z+40tQfRQXAvBe2449iuZ2REVnncSuKcJlcvjiDtWb/6NJtevZGwzhhoOHwj5q3oNZf9xFdpHRPtrPPSGe7WrRfredkLTITKWEbOeBTxtRvhK6DuioTFHnBKq5cnNgngiZBFCB7fASnCxM9Yns9ANH8ib8J87IVRbwCdEWkz9tKvpwq93NUP7aSTGOTFsX1GEz/BqX/bVb03L/i56wC6/uxQVrkg91xC2mOS0ZRjauX3x22U6Cbp1WKEmthY3O/ZeZYdFcEkwh8NSN46ViyCn78DSTUy+qOB9pc5EnCXwnB5nIDaEM9PInZiQJvsb5FjAoPbHtDNh+mjoDxGzAI0HXd5Vd7QnggZbppQv1lwcYGDXSKjy9+2oBxGYYy7Jp3sIXfCRCTL9awS1+MWameEGmmWvmzJZquj0IXT8BxAbygHxegjFFnZHBQSSW+4p4cSP6g97aoLFl1/7+mxdxM+4K16UDQNVxTnaOU0LswqWTM+EDtyrNX/OouSD131VGlcUOoqFv9X9m6Xodj2KdRoufah2V0M1dvuoIfIdjmzK9YHMDa4iAzfUo9sUPtcHw28RGNmi9TscZSLZOM5xW532DCYwqvvpRMqee1xYyEJNFPriYejfe9DZMBXONA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHJmNXpVbllpWEl5eFR4cUtTeU1ub1ZpYXZDc0k4Ymx6K3lhTnd5c0w2TFc4?=
 =?utf-8?B?R1FWM2o5bWIwYmx0Z0JSVy80bmhoUlZOcGxPdDVvN2JzUlJXRWE2bnNST1lk?=
 =?utf-8?B?ZnBsV3J3bG1oZHowRFlFaDF1UjhLSzhKcTFiZ0hVbWhRMlhBbW9WK0ZpMVdM?=
 =?utf-8?B?akhoNzYzd1hxaHBER0NIME9DZGJvTXk4YlVTR2FJZ1lFTTVpTEN6WTQyVlNE?=
 =?utf-8?B?b2NCSlJCSnFDV1F0SGtMVTRhTnFnVkxQeHI4VzY3N0dkZmdLZU5BZ3BRM2ZG?=
 =?utf-8?B?blN4dVdpLzVKaWtaV1k2N21KNzJHQkxoaHViSlorMjNhYy9ESnVrVldtRVhP?=
 =?utf-8?B?QVF4eVEvWHk0a2EreWpCb2E2Ky94TU1PQjlWZ1EzSktXK2tqZFl5aWlPOUl6?=
 =?utf-8?B?UWREL0IraUJGS1JQZnVqZnFueDhHNWdaWjR6a0I4R3hnNmFPenNzS1NBQXBx?=
 =?utf-8?B?TUdleTh2cHhFa05mWktYNHV2TXdpb0xGbzFUeDF4ZFNtQWx4aDY4S2hJT0l4?=
 =?utf-8?B?NHhRV1VpcWx3eHRMQkYrOHhGZmJ0L3FXcGo0VjNRVkl3ZmtjcnVaL0x6Mmsw?=
 =?utf-8?B?ZjhSRXluZ25kK0ZFU0hzTWJKK0tMTUdxUWJ2UWlqbG15TG10MEVMWVZtNzh1?=
 =?utf-8?B?ekUwMUhZeXZQSEpzR0tpY0NRSXdEQU5GVFA5SEx3aDFLdnVGTTZNODkzd2xS?=
 =?utf-8?B?elpCQ3dlVEVYZHp1cDk4enowSnBqUzlGKy9NcnRzUGVDUGNQOHJ3S0V3WUNr?=
 =?utf-8?B?UngveWZ2NTBIK0NlbEg1eHFzaXZCcVJJaUhUZFl1UDVXcHkrTFNaQjllZWEz?=
 =?utf-8?B?cW45OGlzcTJSY3o4aEtnc3hzTFppTE9ySUk1a0xZdHNqUm9rVnRLOWtkZTB2?=
 =?utf-8?B?WnFEZ1Jyem9URUtPZjk3a2Q5M1J4NGJ5S3R1QmdvVlcyZ0lrWDA4blRsSUFi?=
 =?utf-8?B?dHdQc0M1bU5qaHl5T3pFamJ5OTl1cEszRElXSzlmWk9HZ2dhanllaVVqZDRt?=
 =?utf-8?B?RmsvWFd3dEVMZ3BtZTNWWklOTDhpdTdpWXZvNmpWaHFXcnVuQ0s3dFI3TElZ?=
 =?utf-8?B?L1EwM3RXT1RrVWYxS2tTbzN6ajJ6RXpGOVFHUGNFc0pMYnlsRkQvbXZkNXVS?=
 =?utf-8?B?ZzRDRTRVaUgrSzdUZU9weUx4Q1hGQW0yT3VpZHBRL0lkMFZpYkprZ3dJZFh1?=
 =?utf-8?B?OTZWYW5nWXR3VGhPdS9mMmpNdk9sYVlyVFFkejVaL3lyelA5OHpkUm80ZUU4?=
 =?utf-8?B?K0doZTFvTWJ0UFNVdklzUnF2amVNRmV0UFJiK3NJd2haTGdFRStTdGJPYkds?=
 =?utf-8?B?RUR5VVZKcUozZ2xjSkNVd0hvLytENHJ3L3g5OTRzV3NCYXd3b3QwYkJxNi9a?=
 =?utf-8?B?MG9HcnQ0K3ZNeHdoRklYZ2l1bDJkWFdWaHJDTEtZTmY1K2Y3ZmhxaWhCY3Nh?=
 =?utf-8?B?bWxMUHFUMCt4N3BZcWhLcU9nMWUxRnBackp3SHVMWWd0YnlSbXJ3Y3BTNjlQ?=
 =?utf-8?B?UjZMNzh2elFXUncvbDdMT1VEL2VQYVorbFJqdkpQQnhRZnUyTE5RTEkwa0tY?=
 =?utf-8?B?cHZwZEFuU1AreGYza1psV3BDQkZJMlBZU2VBNUtoQTBPcXlmWTNQNTlmdmhi?=
 =?utf-8?B?WkgzeHdPdnhFdDFMeEd5V2ZOdVNRQ2lYc25Ha081ODdkNE5ETlN2cG1pSTZH?=
 =?utf-8?B?eUNIaDZtUXJHRVFrOG82L0Q0eFBkWThvR2dCaEdPY09sdk5NQUdsTmsrek5D?=
 =?utf-8?B?NlB3TjA3YzViMmpBZ0NoWFdQeWIwbE5rS1hsRnNhQ1kxUEtPTUFtZTRjK3hR?=
 =?utf-8?B?MEdyZ0ExRnh2TU91K0JlN3U4TjhLdEVCcjhQTG5UWW1lbzJOem9RUEZ6YnFX?=
 =?utf-8?B?N2Q4UXJXRlN0OEZPb2FlaWxIZW9WWkhDNzAzZS9VSHJ4UDFSUVFTVWtyYTV2?=
 =?utf-8?B?bjNIVUprY05DKzNKb2RQTE5FNG55WlNUNk1ZdXlnRXNvUDBDTlBoQ3p4Tmp3?=
 =?utf-8?B?aUNkek9lZktLRTlwSWJaRlF2a0haMGRUL3VEQmpRRTRUVWxKb0E0OU1wZHJZ?=
 =?utf-8?B?Ti9vd2paU3JoeXhVNFpDY3NEek1lSTJpVHNnMTQrMXE4WENVbWwvZ0xwcTRK?=
 =?utf-8?B?eG13WjNocVErRGVBMDF1eEVWczZZeXpWSUhNSFhIRnk3eXlTcWdjam9DdHBr?=
 =?utf-8?B?SmVLOEtYcFF4MUh4NVViV1E5dHFrWWJ0aktEbFd5dnZ5VnV4S0lBaExhWWw3?=
 =?utf-8?B?dVdseE9HaGdDQ1h6WEx2YjZHWW94bjU4SjdSaTRLQmhmUjFFeEhjRVdkbWtY?=
 =?utf-8?B?ZHhqZVlPWVVlZXA5V2ErdjVFb0N0M2FhTTdJYUVUbUFiNW9MRFZJM1JpbEp4?=
 =?utf-8?Q?XTWL8F2kzSyY4SqA=3D?=
X-Exchange-RoutingPolicyChecked: Fjcw9khASohEPiFOwVYNE7X5tkdMLsbuNZs0TkBWpFzXBNhSHiGx8bISJq+O9h+JixVYWW8VbYqkIAegFwCBQlfKIPUgUa8htu1jv4czyvEE3VKdvzSGRqYM7kCp4S15jUT1vvykvLHtQ8Cht9JROe1u+wty/FEe8olbrM3EpZZJWX/B1nbBCDEl2JhaQm12qYFrke33Xkwg9vr2hYksNTvP2PNWa+sXl6Pe4fQWzaPBmDyd1+YnC8E4QJFh5VCCltQqzHszI4UhzL2ZRnVAyAeAl2p3aAP27mxBwOc9BJ1+BzzdWHBMmkFtLGJ3qPMDRtwHX6wRYufqOsdEdvBtWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f14067-1976-4352-685b-08de95c85d6e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 23:41:32.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtxUyz3ObA/mh9qNzsc6oUkD5ytlxITNMkVGORgXVxX1dVI4iHs0Ua8/ZtXlJozH8d4SqCYAI9vRsPsu1nWU6SbXv2Zu+TeqzvKz7BBzPDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8250
X-OriginatorOrg: intel.com

Hi Babu,

On 4/8/26 4:07 PM, Moger, Babu wrote:
> On 4/8/2026 4:24 PM, Reinette Chatre wrote:
>> On 4/8/26 1:45 PM, Babu Moger wrote:
...

>>> The modes "global_assign_ctrl_inherit_mon_per_cpu" and "global_assign_ctrl_assign_mon_per_cpu" represent the actual PLZA modes.
>>>
>>> Both of these modes introduce new files kernel_mode_cpus/ and kernel_mode_cpus_list in the resctrl group.
>>
>> Right. To be specific when the user changes the mode to either "global_assign_ctrl_inherit_mon_per_cpu" or
>> "global_assign_ctrl_assign_mon_per_cpu" the new files will be created in the default resource group with
>> associated setting applied globally at that time.
> 
> If, at that point, "info/kernel_mode_assignment" points to // (the default group), is that correct?

I see "info/kernel_mode_assignment" pointing to default group as the only
option right after a mode switch away from "inherit_ctrl_and_mon".

To elaborate, the current idea is that the mode within info/kernel_mode determines
which, if any, control files are presented to user space.
Assuming that the system boots up with:
	# cat info/kernel_mode
	[inherit_ctrl_and_mon]
	global_assign_ctrl_inherit_mon_per_cpu
	global_assign_ctrl_assign_mon_per_cpu

In above scenario "info/kernel_mode_assignment" does not exist (is not visible to
user space).

When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
(or made visible to user space) and is expected to point to default group.
User can change the group using "info/kernel_mode_assignment" at this point.

If the current scenario is below ...
	# cat info/kernel_mode
	[global_assign_ctrl_inherit_mon_per_cpu]
	inherit_ctrl_and_mon
	global_assign_ctrl_assign_mon_per_cpu

... then "info/kernel_mode_assignment" will exist but what it should contain if
user switches mode at this point may be up for discussion.

option 1)
When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
the resource group in "info/kernel_mode_assignment" is reset to the
default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
and kernel_mode_cpuslist files become visible in default resource group
and they contain "all online CPUs".

option 2)
When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
the resource group in "info/kernel_mode_assignment" is kept and all
CPUs PLZA state set to match it while also keeping the current 
values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
files.

I am leaning towards "option 1" to keep it consistent with a switch from
"inherit_ctrl_and_mon" and being deterministic about how a mode is started with
a clean slate. What are your thoughts? What would be use case where a user would
want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
"global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?


> And if "info/kernel_mode_assignment" points to a different group
> (for example, test//), then the kernel_mode_cpus/ and
> kernel_mode_cpus_list files will be created only under the test//
> group. Is that correct?

I expect that if "info/kernel_mode_assignment" exists then the group
listed within contains kernel_mode_cpus and kernel_mode_cpuslist.
How the group ends up in "info/kernel_mode_assignment" could result
from mode change or from write by user space.

Reinette

