Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A3282F00;
	Tue, 21 Apr 2026 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792949; cv=fail; b=W3HVu0k3qnwmu58E2F/tIUaoDaTgPyvkPJHPFNOuNqPCpIqQ3Qw1GEnfARGugd8P114AAJpsVwxg5cwyEWFzpz+HcC9Fheanc332EkcCc6roHI8p3aFlxoYGlequcTPudUa5OTujBq6T0RUwpvo6CYahSngsvYWk98pUtiSQpzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792949; c=relaxed/simple;
	bh=dnITd010sGGaAx2fmLAHouIRwszeHZV1qHcJJheVgCA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q4iBYaXK6fqeywglUv1y86yawVyFCCpDu5NB0ONGSqM9YdDEhFdvDYCQ5VwB9OcgjrDZCHY2bq0fGUXcVEI8FWNEr1tTMO2RGhPiB3iKKB1bxFuKRsV+x9h4wpSTToZEFW/HjDRWYmHpvD6MYBqheZoCmrTXk/Bxbobb14c6o5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ezqpv1+B; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ezqpv1+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776792947; x=1808328947;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dnITd010sGGaAx2fmLAHouIRwszeHZV1qHcJJheVgCA=;
  b=Ezqpv1+Bm/9CAAabJqQ9Y+tDQmBV17BMQzcghMYgwn3I/xGJJBr6M/Z7
   7CJBzJ2Rf9O/wjviDhRdtWyged2rG9YLmzKQnUGMWUt3HrMPcsEZf3jBX
   yCg1U8/7wL5tBW0ShU/Sb/EfcErGOAwf2ChFcWY39jMA00/3+TCExJxx9
   FdJEb177gyh25brJB1QUvrXt+T4xKLG33Q2kdyIj42Pn9BjC4oXhuXbec
   XbRqW+DFzIEcagYWMGjmdX2Pdfw7hkE5ML7QallCnpzGUwZjilAimqu2l
   UN8sarfmWpouWQh97kuKUa/M/6MV2dJ73CfuQ85cJFo8byw0GTkDzwI0o
   w==;
X-CSE-ConnectionGUID: Gf9RBN6rS/GYdUvHrUeWEA==
X-CSE-MsgGUID: 5uMMW7eoSqam6HutgW03vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89205599"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="89205599"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 10:35:46 -0700
X-CSE-ConnectionGUID: 7I66CZS9SSaAvVoAm4M4jA==
X-CSE-MsgGUID: 8msWbmF5SHOTLxD1bQNHyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="255565526"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 10:35:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 10:35:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 10:35:44 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 10:35:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgZaRW5xJaZiUEPnasHB6QqDvHw8pxNrs86o6WlEE3g4CismbqPteyWI8B5UH1hjBHWgku/67DDMfOfa7zPFNjQQ8BffkxYue27lAAmVM9qmroruvNbqXVN8pGcYFkabPeuz6q+d0o4Yy+q1qJEIJ65RQjDo9eMOE2U2RPWGwN7biQtsi3cUO1+v6pM6+S7umavxqyo1HFp9CkL6AA8lhERK7+4kYVQ7KgVxf1x84f/+xElEmVgu/ZF6CGKH8r5tTcr6gUlk6r8cpO9q0d4JPQggvYD5DkYa97nIKlWy1pmbxVy2R/mb14TuxcEAYKaJJlEgk0M0UVh83mstulFKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRnFG2LLSJa0sUhYel5gMkntXNWTCUY0uKKmBsotSFA=;
 b=LnpqJJzZvMi9Oy25V5XEAiYiyFspr9jccXTEfug49/I3mTOL68IfccxOuf4npxCWf78W+4FQDi+1rEPASNQ/upoe+l+hwO+Y2zrcNJWO7ujAHsS1WioYNeYmJNeoq97ZQjhIP5l2nwwu7fZlJmg7g0M9l1YVxBulJmxgMPlQX9yZ9bpAMiqByQ+6JwrgcG+i1VZECiUN1fPlcyiWzx4F0X9uw3HpayeRBRrPGy+xKtvu8Fnf9gc/lgkfDzMOkhaarMKBsm8aQtv3FmmdVa53HKHEKw5DKo8UYpO1SHAif3DAQjL/qqOZ6ayWVq5ZzJEqH//BmX3oKoZfF0yF9v6BsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB9806.namprd11.prod.outlook.com (2603:10b6:510:3c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:35:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 17:35:36 +0000
Message-ID: <0334ba64-71b3-40bd-8cce-9f0f119e7dc9@intel.com>
Date: Tue, 21 Apr 2026 10:35:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Babu Moger <babu.moger@amd.com>, "Moger, Babu" <bmoger@amd.com>,
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
 <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
 <72297351-2954-4318-81b6-7de409e5552c@intel.com>
 <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
 <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
 <71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com>
 <e624f652-f0a6-4926-a0ab-c4486d41eb6d@amd.com>
 <8d969f11-4a7f-4e36-b85a-c3ed714fc603@intel.com>
 <a46f4f2d-e3f1-454f-b94b-c54e14e45a69@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a46f4f2d-e3f1-454f-b94b-c54e14e45a69@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c999d0-e36f-409f-9f27-08de9fcc65da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8uVeVJ+CEBoMeYrqRK4kxbq7SAVMZRT2qOuxTzX6lMhJzZtsn/drPwkhUgVVGQGYq3/i4mabMy+9icZdD2Rpk1z9OaYUVvOZMdl+xbhgDVXEI31wdgOdH8XsKK1eN9yzcZv01FvG6H5O75beiEE0JZceJYo6RLuZ7inKelaGu+Clqg+9ThSkIurh0oxuq/8+OgIrrX1lvrfOhhOOt2QdaLv7TOiL3kB6RJsQoHZgVy7bG27lNsDyXtEZyAuEUgQ5lf2pk5Kks/DwIHNoFmnNw/LeZHuNiRqIpFuxrL2vn5QKWbLw/8axzh5LSvACMf4R7ml87gorMqoh9dC1rU7dJKGaQEln6oiYKw7EBN4NqxM1VSoKB+mIwjxv/Ctt3xCp/Txd9NvuzOXAZpI+d9U8YYZFvnft1RHk/7R+W6VotQp3Y3fBtVEBTgPpEXeIhaYo0qF31sJGIzjHMMzu7h+Mk4MIandScpCTm9iKsBve4IpkDxgqxRZJmu+6fQIMd8O9MZHLMm5e2YEcE9B6O8MSWWZE50oFAli2CCs9lanncgl4reDSPNqH/pQ34bjpaNQwyRbaxo2bv2Crw88DrZqe1ok9Fvuo3XxQyuEQfhAWrFW/vacHOP+nuGT3PCM5KnSiFBF/rOlpHjYD5wvs0r9iKCm3lOg9iewRsly7gMQIJ8yGzirUJmm7hBprtL+dYM+JSviOlG3umGfpPRo1WoNIr9b+yU6mxSGAGUcGbSOo+X+hjidid074gYvHAnW1TDtm/ElQugF5Pjc2K6Knf5FnYx4K27RC+tmCNEORmnrBgQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0VuUm1zUnVTR2hwY3JIZ0hlMm5iR0VYVTE1WlBQNGlaTWZ6b2N2N0EyZ2NK?=
 =?utf-8?B?WVJmNHltTkQvOWdhdE9XSGc3UXQ3MlVnRitBY2xvRXgvOHdpYjFrTXhINGZw?=
 =?utf-8?B?aURnelRTdXlmM3hOVkVXemk2dWFqdHhxNDFld2hTVlFlbHZjMm0vdWpOYTRK?=
 =?utf-8?B?NkROWE12ODF6K2lyZ2ZSTUN1WFk5Ym9UMEJvRThnOW11RWpReERIZWl5VGZR?=
 =?utf-8?B?cTZEVFBObzdUbDZYUTFIUFZJSmlSdGVUbmZ2SXhETEF2TWRjdVhCZTZmOUJo?=
 =?utf-8?B?UmV6bjRxdS9Ld0xZbmQyNWRTZnRDWTNFTWY1TTJta3VndUF6K1FPeHVkUmlO?=
 =?utf-8?B?d0JJTDR2a3ArUFFqQmswOGh0UkxJdGpyYlhHVVJuK2tlV0c4NFJIWDNYdklL?=
 =?utf-8?B?YlpTS1NHTm1obWV5NGZZOVpyYUJsRC85OHRncklOckp4SFVKbDlEblFBdStj?=
 =?utf-8?B?MDZCaXc0MjJqVFhZbzdIUzZUbkpiZUliakZtKzNGcWlMOVc0K0V6QjdGdmV6?=
 =?utf-8?B?aXVTaHYxNnRoSms0UTh2TFlGOXFTRng0OENrSXh3Ny9qYUk2bTZYZXZsYUFk?=
 =?utf-8?B?SXZlRlpueHVXUHBRUDhibmtDMjRYQkJSb2R1VTlOSkNvNEdGc091NmNXL3hK?=
 =?utf-8?B?VmZrZmJ6cWhsZlRIMFJ5bWZHWlZHaEhPek1XbXhzZDA1ajVVTExqQ0dJY2lB?=
 =?utf-8?B?Yi9aZW1aRGJKOTNpMStGZSs3SlR2dU5rMHB4bHFSLyt1UzdYR3lnRWo5SmZo?=
 =?utf-8?B?WjNRM3lyditiTnk3TGxZN01QdlE3QVdUVlNtdjlYOVF6OUdIMm44SVYrVzI1?=
 =?utf-8?B?Nko5b3BMSmt4b0xzUWdJVlExZk5iQW5RaXlGRm5qMWROWkxqQUN2WWJpM3A0?=
 =?utf-8?B?Mno0N01FMiszRnFEQzNSRnVNcm12cnBKcTVyL1BOVlhMS21veGdPQ1QxNEY5?=
 =?utf-8?B?WUlCc1Z2ZjdUT3pqRU5TbWJpaTFTbmNldlZ3RlJPZUpmN0tPMXlSVFVYSkpS?=
 =?utf-8?B?RlNIcmZaeW9EUjhzWFd0WStnczJBeVY0QUZpcHRobUxZS0JmWXNyODZab1Vo?=
 =?utf-8?B?MjhqQUJGZ3FlSVpGSFUzZkgwRWR3Qk9IWXVpT3RMYTF5elpCR3VBeUNuSkVG?=
 =?utf-8?B?a2VWams0SDRyVTVWSko5dGFSMzZMTmEyQXlBZnNCbHJ3QjNhWnVxUnJCWXBo?=
 =?utf-8?B?d3p4Z2l2ckR2L05ESFVsakl2aDVSYVFPay96MytralAyRjVjZytuT0tjZExD?=
 =?utf-8?B?dUlBeTZ0aXNhQVVBc00raW9hUlBqN2ZXanJWTmVZTGhybkRUYk5XZHBzTDdQ?=
 =?utf-8?B?WENrQkRMaG1RRERreU5qdy9ZYWtVTFVFSEdYMkpiM0tqQkgwdUZJbm9rYmxv?=
 =?utf-8?B?Wk40Y3h4SEczUUFDTUR4RGJzWXVTQ2t4ME5tL3FDOU9oT0pzN2FxM2JpVHZE?=
 =?utf-8?B?aElZWnNkVm1BRSt5YStWZUF1emJ2MjJHSDdkcmpIYXptcjVRWFZwN1VCSmNx?=
 =?utf-8?B?L0ZKVFV6QzJobm93SVhScURxbFB6SEhXdmRKRUwvSGJEZWZQRVloOEIvZTFl?=
 =?utf-8?B?d1N1MUdacndHQzJ3NDk3ZStLS2RJNFZmUTkrZkZOVjRITGhvdkRXeFlrc0pj?=
 =?utf-8?B?VEsvbmlBMjl2V3p4cU12aEI2YnU1NFpSQ3F4VjVEWENYbWNpbFk4QVRwZmkz?=
 =?utf-8?B?UDRtRDVzR3lXUzZwZTg0TCtKd1lvQnk0Sm5iazlRTEoxQnJXazBOalNOTFY3?=
 =?utf-8?B?KzhQazB6NndSenF0SUJEVEswVFhPKzAvN1RQb3VtbXBHUms3YjdqbWJzQ2Rh?=
 =?utf-8?B?V2JCaTJqN2Y2NnpSWVNlOEt1cTAzenN4RjBzdGRXWjFoSklPQmxPUTlQOWkr?=
 =?utf-8?B?bExoQjlwLzlsME8yZHJCNWVQRUxNdjlpS091bFA2OGlTMGUzbmhQOXJlYW1S?=
 =?utf-8?B?Mml6Q2ZNRUxHaGtWSG42c2laLzM5SzlJRXVGSkZ3akJZUzYyOFJha2dNZk9q?=
 =?utf-8?B?L1BTemlLMHBqZlhXL1JPRWVyVG0yaHVHYkxtMEloZ1E2WlloNVpRVWR4UEh0?=
 =?utf-8?B?VUxnY2ZqRkZPd2dyU25wV09KRVl6aHZldHU0UHhGN1dmT1RHcFNPUUUwYWJw?=
 =?utf-8?B?ZUNacjBaWkhJMUh4OGthRitzdDdEVGozL1dUVkpkempOTm5NVVkyN1poYlZl?=
 =?utf-8?B?eWx3VEJXSUtNTlFrWXVtUXZ0RWtxOHNBdE83Y1UzWjZRM0JQeDZkTHk2LzZL?=
 =?utf-8?B?MFFsbVBMa09LTkp0czJzWjUwQVl5aWdrYStuL0RQY2lNT2w0MCt3TjdXSmNs?=
 =?utf-8?B?dGNwaUFlKzdpSU96YnlxdHllSUFuOXJVdlU2UUhScS9QZW5TMzZtdU00eFg2?=
 =?utf-8?Q?nFukSfkUdy041HIY=3D?=
X-Exchange-RoutingPolicyChecked: ULRy7JGaZmt86JT+SyOS7CztUJu1AqG0w5U6o7GmGoZndIVt7i2VY3unoNqLbjaILDMxvK7aC+6/6cZXmy7SInFeiL3FHrOsB6OEaOYR+OIgIvf8TcSNBzv9IgTYqzKdQAmSqzxUFG4rUhrL8ighm7/WR9nmzToSTusfbp7FJnVHOjjDAMiClOjQ+wsFNFkmLTNDzjxK4DnbBIL5UsbJTXP7zcgbhrXRnjV/GBumQmC0HkiH/ftw0IDZZVoLhvRXiP4/YNJiGIEtLF2naYxSlsxT+jicsM0ymcWcA5WDCG8QAAVXtuSysvFuoNm9Rd72zQRvx4ThHjUv3XvP2P9/Vw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c999d0-e36f-409f-9f27-08de9fcc65da
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:35:36.7151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2Q0zxnEDi3lAB/FlLGGCv+OVz8bHb4aq+11fBmfkZc3d7hX2OJcGHSVGt+xswZ4MX5JA60nopEukYs/3ix9pcxwJg5rsi69SjiDjePHNq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9806
X-OriginatorOrg: intel.com

Hi Babu,

On 4/21/26 9:46 AM, Babu Moger wrote:
> On 4/21/26 11:15, Reinette Chatre wrote:
>> On 4/21/26 8:08 AM, Babu Moger wrote:

>> It sounds like we are saying the same thing?
>> When considering all the sharp corners I agree that keeping kernel_mode_cpus/kernel_mode_cpuslist
>> seems most user friendly. When doing so there is no need to include CPU assignment in the global
>> files.
> 
> Actually, I was talking about removing _per_cpu extension also as the per-CPU requirement is handled inside the group using kernel_mode_cpus/kernel_mode_cpuslist. It can be documented.
> 
> global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_assign_mon
> global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_inherit_mon

I see. The goal with this name choice was to distinguish a global mode that 
additionally supports per-CPU assignment from a "true/pure" global mode that
does not support per-CPU assignment.

If resctrl ever needs to support such "true/pure" global mode that does
not support per-CPU assignment then resctrl will need to either come up with
a new mode that does not expose kernel_mode_cpus/kernel_mode_cpuslist or
make kernel_mode_cpus/kernel_mode_cpuslist read-only. The latter adds the
complication that user space can always change the mode of a file so resctrl
would need to add corner cases for that.

To me the "per_cpu" distinction is useful since it make it clear to user space
that even though this is a "global" configuration it additionally supports
per-CPU assignment for which user space can expect kernel_mode_cpus/kernel_mode_cpuslist
to exist and be writable. To me this makes the interface clear and intuitive.

>>>
>>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
>>>
>>> Why do we still need to keep the "inherit_ctrl_and_mon"?  By default all the groups in the system falls in this category it is not plza enabled group.
>>>
>>>
>>> System boots up with following options if PLZA is supported.
>>>
>>> # cat info/kernel_mode
>>>        global_assign_ctrl_assign_mon_per_cpu
>>>        global_assign_ctrl_inherit_mon_per_cpu
>>>
>>> No groups are associated with kernel mode at this point.
>>
>> To me it seems useful to be clear to user space on what the current mode is. If I understand correctly
>> above default scenario essentially means "inherit_ctrl_and_mon" but instead of adding it to this file
>> we will need to add documentation that describes to user space how this file should be interpreted.
>> It seems easier to me to just be clear via info/kernel_mode itself on what the current active mode is?
>>
>> I think something like below will be more intuitive and not need much additional
>> documentation to understand (I am just adding the "uninitialized" as an example to match text
>> printed in schemata file during pseudo-locking ... even if there is a group named "uninitialized"
>> the lack of "/" could be used to make it clear what this means?):
>>
>>     # cat info/kernel_mode
>>     [inherit_ctrl_and_mon]
>>     global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>>     global_assign_ctrl_inherit_mon_per_cpu:group=uninitialized
>>
> 
> Sounds ok to me.
> 
> 
>> I also think an interface like this would be simpler for user space to use as it (user space) switches
>> between PLZA capable and non-PLZA capable systems since user space need not associate existence of
>> the file with some kernel mode state in addition to actual content of the file when it does exist.
>>
>> I assumed that info/kernel_mode can just always be made visible and not depend on PLZA
>> capable hardware. This means that on Intel and Arm this file can show:
>>
>>     # cat info/kernel_mode
>>     [inherit_ctrl_and_mon]
>>
> 
> Yes. Sure.
> 
> 
>> For Intel this is accurate and also for Arm if I interpret the Arm implementation correctly
>> (see mpam_thread_switch()) in  https://lore.kernel.org/lkml/20260313144617.3420416-7-ben.horgan@arm.com/
>>
>>>
>>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > info/kernel_mode
>>>
>>> # cat info/kernel_mode
>>>    global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
>>>    global_assign_ctrl_inherit_mon_per_cpu
>>>
>>>
>>> # echo "global_assign_ctrl_inherit_mon_per_cpu:group=//" > info/kernel_mode
>>>
>>>
>>> # cat info/kernel_mode
>>>    global_assign_ctrl_assign_mon_per_cpu
>>>    global_assign_ctrl_inherit_mon_per_cpu:group=//
>>>
>>>
>>> How does this look?
>>
>> In addition to above I think it will be helpful to add a clear indication to user
>> space on what the current active mode is, for example, via the [] characters.
> 
> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > info/kernel_mode
> 
> # cat info/kernel_mode
>    inherit_ctrl_and_mon
>    global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>    [global_assign_ctrl_assign_mon_per_cpu]:group=ctrl1/mon1/
> 
> Something like this?

How about making it clear that the whole line/configuration is active, like below:

	# cat info/kernel_mode
	inherit_ctrl_and_mon
	global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
	[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]


> 
> There is one problem here. The mode "inherit_ctrl_and_mon" listing not consistent with others.

It is difficult to predict what resctrl will be asked to support next. One possibility here is
to make it part of the original design that the first field is the "mode" and the following field
contains that mode's global properties of which there could be more than one. Above shows that
the two "global" modes have a single global property but we could just try to be safe with some
documentation that states there could be more.

Consider for example some hypothetical future where the file looks like:

	# cat info/kernel_mode
	inherit_ctrl_and_mon:some_unique_capability=true
	global_assign_ctrl_assign_mon_per_cpu:group=uninitialized;other_property=val
	[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]

To leave room for growth the file could start out by, for example, appending ":"
to "inherit_ctrl_and_mon" to indicate that there are no known properties yet?  Something like
below. Would this be more consistent with the others?

	# cat info/kernel_mode
	inherit_ctrl_and_mon:
	global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
	[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]

Reinette
