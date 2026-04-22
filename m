Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65A39B49F;
	Wed, 22 Apr 2026 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826710; cv=fail; b=BZKZ2cXBMATHsVGjCnriR19xnFbC8S98k5oNJnHugByF9pGKyMr+Mk09gk9Wchs6XDh03OKPh7TJTJpN8SDCrzDQJTM0mbP7LCLvCkL3DGtm8DoFvv3tqCBY0N6VpIIdUZsX3kyrBUI5n4ugPiZX7vz+SDk897+6ag6CdyeZrIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826710; c=relaxed/simple;
	bh=BQflrfnVYqBdojKZSXq5ui+BA9TrcPADkZRyrH+eCnk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VYlJGnceJceq3DL1YcVR+71oMtqZEn0Au1U/tUJ+ID1D1F80hERx2g5VsE+0lNeCzKgzVYw1SRxmIYbq15vAOzK5Wz8JnWypoBq5ZPN7aOrXbKTe8Y11New8rcx06EfW5pVp9J4OdhQ8Et/ijj7gKUJ1jL9lGzQLVJ4AHVf9Qm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3y09deh; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3y09deh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776826704; x=1808362704;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BQflrfnVYqBdojKZSXq5ui+BA9TrcPADkZRyrH+eCnk=;
  b=f3y09deh6mFPObEd6lCIZrQWziU7XAw9Voi3BynExGsFTX5Y3sT6hr/G
   Bok+BL4wM9aMrKEWG3ArsllbB3FlDLJPFl314K2d0BwARHbxK31poMgXy
   IZCkNdrwXPqeiTIpKJAEmQLrR6cUKxMk0txgVq4w7JzKCH9sXgu1r2Ygo
   USvXGHUi4RqfomWVBGCQPBPfyxNqiNMOWyc65vSkFpQA3J8AlhCULFOrJ
   2wmYZwEqTvuRzFPxl4FJehOa9ROwX+/LYWgDRWGPdD/1c33QqVxjmaG28
   hSaFFZzC0nY2NJA7gTjXyyfitQzc2HzExjL/PIvFBZhZU11YeviTt3D2c
   Q==;
X-CSE-ConnectionGUID: omSDhRzOTJ6RD9vVB1fYhQ==
X-CSE-MsgGUID: 2E/UyUHTRd6R8da2b8pgKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88075175"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88075175"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 19:57:08 -0700
X-CSE-ConnectionGUID: JUwinj+8RCWQlgyPpt2jyQ==
X-CSE-MsgGUID: OPqkhwinTgeMf1h8u7Vqfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="255705968"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 19:57:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 19:57:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 19:57:05 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 19:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMWkSdwim+TbElZU2Km0XJGr61b/Q+VXuiCwzjgGFgStaqnGWO/H7lWpo0IND+ygp8CQlYknGc/ts59rE43kVL7tr2kHMTYyactapBCoylhKIlXiWZvSbShK1ScotikiN1bZDwWbVJ0IVuES0gidiXPArZckJ81rS6bFpVd5i1M9D8FsY7pRFhPAE8pswFDmYkLb7RoXVqyThKTbZJuJP5HP1f8dWLoqhYGampcLUsfOuASxro8Qk18PoXDZqshL6DNkgbEwYe3UqG98aEgmlrJIAQs3Y5PPvUmf+vby3hKVvssjgwNaUh51RJE+VbUKi9T0/rm+bIyk1jEYFp1aCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/AGf4b+qjlByUJIf4hD6G0GZU1+NYiGNOQQpW8EwTI=;
 b=MOmpHdjOjNdnHr0QC4K5D2+Vu4ZUi4hIptiLAEzHaBFPvmv5Yor1cBp7X107o9U9UVScUTemIrTE9HCs4PtWygpYNTpnOUusonzfmtMjwIVt2hkfUnon0T3ZkZP1nKoFxqq/bRD/7uwcyS/LYTl/BtUpPURDsLrgwUBX2BX8Ohfy9lc06TbiS70IwxnLglDrSt3vqEAbK9Vz9Gv7LUxuOxAnbFshmGQkQchqpSTCFR6xK9IruSUlrnIHNjkJOWCzPjeW8wz1jqLk63pQ7BO/3u52SnL/PFriRSvUdAPCTV0FGHn8nRLy8U2MpNdu7XX+1kOdvq1TwndUDtk9XNPq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB7093.namprd11.prod.outlook.com (2603:10b6:510:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Wed, 22 Apr
 2026 02:56:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 02:56:27 +0000
Message-ID: <ed0d2463-edbf-42df-b345-b83da356e865@intel.com>
Date: Tue, 21 Apr 2026 19:56:23 -0700
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
 <0334ba64-71b3-40bd-8cce-9f0f119e7dc9@intel.com>
 <d693f797-65f6-46ed-bd49-beaeee2da858@amd.com>
 <c9e10de7-f5b1-4a38-be1f-f75bc1ae7780@intel.com>
 <9d8a18da-14e4-4d90-a224-7d69d4daeb13@amd.com>
 <de608041-bc45-4ca0-81fe-423a5167d7d0@intel.com>
 <39da36be-40a3-45cb-8e49-12dbb59aca74@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <39da36be-40a3-45cb-8e49-12dbb59aca74@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 1258454b-f1e6-4ebf-56f4-08dea01abf23
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: W9ER/TanK/5SjvmC7RX0Bkh+eQ8hZqpR3kvZp/SqA+JpoDfeTlcv7RadaKX6u+sjAxSfqKDwi/9ZHyNbaUnOSJWE5QY/IxMW4UMZF7GHGx8QomqHXjCJ3Gr5rDfEEZkVURhTKuHFQSdyw9B6KTLGJWsbU4E/V1Eq1hvYO1mJ/5ZnucvFnhP1JGxf9tctMBv9x7Rs1K1K1pdcq9XgbRcHquqcrMktWJU3VBN+bmMzCq7VcGJlGTZGehHCijz+YGChUh2srjYIBf6pOSBMyy2aaJvS6HFbUHugMfTFQm6mi235pj/wB4kNJsJnzU1Y28iEtWa7taox+3LKoDl1nziDl0p+8rulHfaaZZFQGAJcxhiF0niVwUxihHGSf/3ZmCHKgxnxj5DsVGPYYaz9HWzpyT4FhDxPjOqF2vSiqORBRIfLwPAVlAvAfn+TZZNoPUZHoilSrSP41qUpJxi2wJIXhqfCA72FOWXnHvv3fF1xv4Bwi9nzcphU/qwxC79yVJk5RrdvvvIwzvU6r0X7dl5wwp0yJLuK8GmAatM6w9GgVXev1lIxfpTvsTaO92yHM2H3+cv+inOI2VBOxF2kMhKOTP444G9E8axGTd/vfuSd7+d031vXtFNzgANh9jrr7jSyO6pV32hRIbCLgN/UT+rNxti1jHcSn7UgrnLMU5PTFRcQ1ituOZMqaMxjxU80BuxkrKzXuSEZ+I7zew7CEo7ZPmAOhkf2B6WtzFP7R0QQQv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R25WcTFzNUpHMVdUcVY2Y2NMU0oxQk9ZaC9rZmdQSUhVbnZQMzFNUVBxMHVq?=
 =?utf-8?B?dGFIUWRCNnI4OXhZMEtYS2JiSnltb3o2Tm0vSkhOa0d4SWVmeXpPTnZvNnla?=
 =?utf-8?B?L1V6bHFWSDJRSkVIZ2ZqdHp6M0FHWnB1UG12WWNub2VieXBBMHhXVDR2dmFv?=
 =?utf-8?B?Smc4b0dIRG96a1Z1ekRlTVdReWl1bTZNZkt6Rm5hQzJxZm5GcnE5SDFkVzc4?=
 =?utf-8?B?R3pVc0NZTGRkcER0cWZ3aUtkcVJYZ2xlN3ltMm9na3J4ZTF5ZEJoT0pPdFJN?=
 =?utf-8?B?T2wraE9TeGNaS0YvTGNUaWViTDF0S2V2TEFNV0U5YUdQSzE4MjV1ekNJVnF3?=
 =?utf-8?B?Y0x2aWFNN2xRd2JVUnI2MGJidXJubkJxUkVBYXUrYXg5aHRFak4yTjBSVHlT?=
 =?utf-8?B?SDFLNGhyVlFhTTdubVRuZ1RBOE9uNjVMcCsyWTR4V0RUVjRCc3ordDBmQzlY?=
 =?utf-8?B?RDQ5Nk8wUVRLZ2d2M3JJRW5tT05FNUJPZ0g3akFYV0tlNGFyb3lxaHN0b3Vr?=
 =?utf-8?B?RjI2K0lBbnY3UjlpM1pwVENTMU9mZENWdWRpN2FKa1Z0a3lHMmQ3bmw4SE9t?=
 =?utf-8?B?SDZ6eitxNHJFMjZWVWVQSCtvM1BEL3kvOWI4bkVHUlpvN2lmSkRlTWxhVlVI?=
 =?utf-8?B?Q293SVJPN25FYVBES09aWVhRSHcrMEVTV05tUUNJd1Uydmkzb0pwQTgvT0k5?=
 =?utf-8?B?VmpCOWxUWEwvVHpDcGlCdkdiRjNJVXA4SktxSlBINXJTa0p6U1l5RHk0MEpw?=
 =?utf-8?B?MVB4aUpDODJzc2s0UUxPOW5XVXYrcTQvY2xPZzBxNnVMWXpseHVBelNEeUk3?=
 =?utf-8?B?ZDlvWXg1bVpUU3FxTUY3L3Z2S2JrRVY5QmtkSUhoM1Bod2s0N0ticXY2SUZv?=
 =?utf-8?B?cWlVVERidkpGeXI1THJIZGFYOVJuT0pxUDRQblYyUkV5WHdtTkM5SjRVTlB3?=
 =?utf-8?B?eDZCVVRwNm9HaGdPcGIwMkxkSzlFellDTG0zS2dKWFRvS0NBQ1RIUlYzU0cw?=
 =?utf-8?B?NU1IK2o3Z3NEY29vdWJxRjdMbFhCUUhCNHVHbys0VUdVcTRoTUJmRXAycUhj?=
 =?utf-8?B?a2JVWW5KcWdzTU5saG9xbnYrY3Z3c1lIUVU2VVl5STR0YWpNZkR2UnpYZlZK?=
 =?utf-8?B?YVp1a25jeXN0YUhHSjFTZHNFaXgyQ0NhWVFFcUhteTl5bnIvQmxTajRvVWkx?=
 =?utf-8?B?d2RWQzhwUzlCcUVCc2tWRU9FNzc0Z1N6bDRXb0pJSEtoZkJuK2R6RllGOGRu?=
 =?utf-8?B?Q3BlM21OTWNINHZINXlNVHZBd2QzRitUZDB5TS9mZk5kVS9paWEzbkhyZ2FN?=
 =?utf-8?B?c1h4WjR0Tmd3eWdlbEhUL1dxT2JKQWtoc2QrUy9DVmJDRHQvUUp2bXFqZGYy?=
 =?utf-8?B?Rms0TU02WXFZazVSVTNrczhDTUpGYTFHV2F1YlRnZm5EZ2tYZi9LUXcxczZ2?=
 =?utf-8?B?TzBidGowRks0WjBjbTNGRmo4ZkxhUHJwZW5HN1JYMndjdGtHQkY1UFM0TDhF?=
 =?utf-8?B?M0txbDFYcUlzbnM5Y3RvL0FQcHp3MTdZM2FjVERtaG5jeTB2SVRVYklzOUkz?=
 =?utf-8?B?K0JXMUJHUUVXeGdmRHBKSXFVWDQyMGNFMDIyUVdxZkEvbzRNdU9tV2U0V2pn?=
 =?utf-8?B?Z1ZhWEhTNFpVamtBS1Q3dHZGVGtYYU1yb09lWkk5U2g1YXR6VkQwR1BKVjls?=
 =?utf-8?B?T1dCVEhXQXZOejlzaEpNZFZBQVNwendCNW1nNXJ6WHFGSmNpT1Jia1c3b0wr?=
 =?utf-8?B?V3VYR29oOXZscU5SUjNibSt6NjdKUzEyRURpRGtFaXpSdnJoMUNKSnRoNk1t?=
 =?utf-8?B?RyticFl5YmlSbUxPbnBDVi9jMUVWRSsvcDNkeHhVWC92SmVBZ3dxdzlKaFlv?=
 =?utf-8?B?UzU5Z1EvOS9DcXR1QU5qVEI2RlNoWS94T0o2ZkcrS2hIa2xrOURmcnhNZFBo?=
 =?utf-8?B?R21pRU5RVDI5S0VjN1lsY3NIcGMzT2N0azNkNCtpME1vV2lZOWNFMEMzVmY1?=
 =?utf-8?B?L2UxR0VjeFdCUmlxdW5tRHQ4SWMvN3l6U2ZwaXhKd0UzWjVGZENSMjNidExY?=
 =?utf-8?B?TDVVaUl5SHJUb2ZOeWxNVDBCSHN5VGJzcEpJSG04aDg1T0xaN083Tm9wcUJO?=
 =?utf-8?B?OEtFRnFpeThLbjM3MDJCdEU5WEh1bnFRVVB4MW8yRE13QTdRaFJoaFg0MGQ1?=
 =?utf-8?B?TU5yTTBrN2pqYTRkd2NmcVZXWWt1dURmMTVqVU40cVBKYWRiOTJreUtjaWVE?=
 =?utf-8?B?NzQwWXZaUVZOM2J2M2dGczFKbWFGWm9EVHVSakxpQkJzcnJwbHpwdE5zbDd2?=
 =?utf-8?B?N2ZtcTNBd1ZWOXMwWmZPWjNGZU11RjgwOXQ4Yk8rREZHZnNjUjloQm1BMDRi?=
 =?utf-8?Q?I+tFRJq/67/ERe0g=3D?=
X-Exchange-RoutingPolicyChecked: WR+AeeHNvUmTcIhZpPESRnHc5p7WJQpnWrSb2zO/mGcqXwwmfdDHGoocpLFsMh/4iQTMP7tIWpip1kRo6LvIrtS07YpeqyLdRD4RDxlthkjzuXIgJnaXZ11fInypjF8ecaLiCgJzJE0kcPOynj+DYR8DcHd6dVA7CT/HPzFn5d7a7nMTJAnSoYOfrPfsXQL1QbXz1L3YSJ+LliFmxT3mhs6FI76rSZuUy6dbgWA/5nuLPclqZccT2UIduMI2PsNGIZN7mtvyb0dnD4q3qq549EGtluN4kl1TpY8ZytBlY+5fPdAmGPcH6ccNmRWEzrsirZnvmYiQRBIdA2EFvsTlQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1258454b-f1e6-4ebf-56f4-08dea01abf23
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 02:56:27.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEO+RE2CagQ/ZZ14CO9YhldtK5MI8C+D8iZvETpm+om8UiAsNSUxoARevC0f/abOM4vq75NXTwYdpF3EUGdVBuzcozYpVaqlpJ+U9qhkSqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7093
X-OriginatorOrg: intel.com

Hi Babu,

On 4/21/26 5:17 PM, Moger, Babu wrote:
> On 4/21/2026 5:44 PM, Reinette Chatre wrote:
>> On 4/21/26 3:04 PM, Moger, Babu wrote:

>>> That said, I agree we need to support this. Without it, we won’t be able to move the group from PLZA to non-PLZA.
>>>
>>> # cat info/kernel_mode
>>>      inherit_ctrl_and_mon:
>>>      global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>>>      [global_assign_ctrl_assign_mon_per_cpu]:group=ctrl1/mon1/
>>
>> Like above where the listing is inconsistent. Is this what you mean?
> 
> I meant the listing of "inherit_ctrl_and_mon" does not have groups while other modes have it.

I think this is ok since it does not need a group or any other (for now?) property.
What issues do you foresee here?

>>
>> sidenote: Should the last line be "[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]"?
> 
> Yes.
> 
>>
>>>
>>> # echo "inherit_ctrl_and_mon:group=ctrl1/mon1/" > info/kernel_mode
>>
>> This does not look right. Why is a "group" property needed here? Can the mode not just
>> be set by itself? Specifically, why not just:
>>
>>     # echo "inherit_ctrl_and_mon" > info/kernel_mode
> 
> We can go with this based on your another comment below. While changing the mode use the defaults if properties are not provided.
> 
> 
>>
>> This reminds me that there is still an open remaining from
>> https://lore.kernel.org/lkml/71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com/
>> Specifically this from that message:
>>     The named fields could be made optional, if group is omitted then it will become the
>>     default resource group, and if cpus/cpus_list is omitted then it will default to all CPUs.
>>     This may not be intuitive since a user may expect that not mentioning a field means
>>     that the field is left untouched. Have you considered this scenario in your proposal?
>>
>> I think this needs some clear description of behavior wrt properties, for example:
>> - Is it required to provide all properties on each write? More specifically, can user expect there
>>    to be "default" values when a property is not provided or is user required to provide a value
>>    for each property? We need to be careful here because we do not want user scripts to fail when a new
>>    property is added in the future. What if resctrl specifies that if user space does not provide
>>    a property then resctrl will pick a default. For example, if user runs:
>>     # echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
>>    then resctrl will switch to "global_assign_ctrl_assign_mon_per_cpu" mode initialized to
>>    the default group.
>>    I am not sure if resctrl needs to support re-configuration of modes in the future where the
>>    mode stays the same but a property changes? Consider, for example,
>>
>>     # cat info/kernel_mode
>>     [inherit_ctrl_and_mon:]
>>     global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>>
>>     # echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
>>     /*
>>      * resctrl switches to "global_assign_ctrl_assign_mon_per_cpu" mode and sets
>>      * PLZA group to default group
>>      */
>>     # cat info/kernel_mode
>>     inherit_ctrl_and_mon:
>>     [global_assign_ctrl_assign_mon_per_cpu:group=//]
>>     # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > info/kernel_mode
>>     /*
>>      * resctrl stays in "global_assign_ctrl_assign_mon_per_cpu" mode and sets
>>      * PLZA group to default group
>>      */
> 
> I think you meant "PLZA group to ctrl1/mon1/" here.

Indeed, yes. Thank you.

> 
>>     # cat info/kernel_mode
>>     inherit_ctrl_and_mon:
>>     [global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]
>>     # echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
>>     /*
>>      * TBD: should resctrl switch back to default group or just keep
>>      * group as ctrl1/mon1/ ?
>>      */
>>
>>    resctrl could thus specify different behavior for switching to a mode where all properties
>>    not specified obtains default values and re-configuring a mode where only specified
>>    properties are changed. That means, the "TBD" above would be that the group stays
>>    as ctrl1/mon1/. So,
>>     # cat info/kernel_mode
>>     inherit_ctrl_and_mon:
>>     [global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]
>>
>>    What do you think?
> 
> Yes. Sure. We can do that. We only have 2 properties now (mode and group). We should be able to handle that.

Thank you for considering.

Reinette
