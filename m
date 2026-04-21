Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376B31282F;
	Tue, 21 Apr 2026 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811459; cv=fail; b=C/uKOij2pFd6ib7AHcwWvosfPxmXi/EO9M919J9gjFm/+06BXOBF6ZKrCp7RMvl+RmNaoGkEXxtrRhxz8P7jLPO07j+k3K814A+zthYs4u0lNSyXHa9kNejYo9AzRmAX0emLZRL1NPVhhWAiXcCSAWRE7ZtQPhoj17H6aIjseHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811459; c=relaxed/simple;
	bh=f7SiSerbKBh4RNSug8OxjTFFbC/1GTZrgLZ6ngiskHU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dlDZURgO+tRx+8x3MZEyofNtYNJMNsCf/4x8jsutvs1XUPIrrzlBWxcChgeolQOVcqABydAot7hXyKU+6M+p7aB+Me1UcPmRC1L0lN5XjUy2eobHRZqTDpwrhxjC4OkO4Kob6fPefD1C+3DMUlw9GofvqQPGLNIYclDvKRDfwXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayn+H0Ge; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayn+H0Ge"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776811458; x=1808347458;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f7SiSerbKBh4RNSug8OxjTFFbC/1GTZrgLZ6ngiskHU=;
  b=ayn+H0GewdDb9yQsZnMRMKua/a/w5dp/kyaUKZS2BH3vk2jv/eLJipKr
   StLh8246ibDdRRSmH00/+ozPjq4jm3G0+b5pfC7tCanZaUJWNWQLW3LNG
   2sCKy3qn2r2yEI9QPWZT7X4glTyaaUBXXV0OC5zij//r38Gr6/hGoqdVj
   NrS+cOpiVUzXVmUnCQ9WcNvi3wu4z+vJ+EFSVh9IYBQSRUgfCHvMqXWyS
   vqlmcXDPrpN+CL0zO0YFwamtJ6p1UJe+8uAnjy3R+zksgKQjL9MOnktaZ
   hDk/3CdjPxuoJdP9oQ2PosXkeGOGPyT6S/8/9FAnHq3SWEqd1Qj9roqZK
   g==;
X-CSE-ConnectionGUID: iqp+mwh+SNiwQhc9vtwI6g==
X-CSE-MsgGUID: Mw1bhUYHTl+3DedqYKr7Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="65295652"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="65295652"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 15:44:17 -0700
X-CSE-ConnectionGUID: IyvArmwJRjGH9nIimxKy9A==
X-CSE-MsgGUID: /+otu1WYSSKBqj2VKNkhLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="229497466"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 15:44:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 15:44:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 15:44:15 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 15:44:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKLi8mrASXGNWGkiUAV+HxmiAJPwXLMIZSVQhjZyTSH8hdwupog+Pb1YnpCqg67tLNK2LO8fxJfQKP3tB4lHOwSYo9Gkzz475A6bIz9JIyLeFrKnoiYoTofWGGq286+kjLu8rcDfxh8mPQNmTI6upbJfcYtrcYmOavyYanRpRIbDFmF5v/vfrS9sa8FwKauz2K/Pq4aRkVi+FmnOtyR0g2V9v9IlQAXNHz/jKkTEm1oHkuVhy8uuPnWf+aSps5seFngzwu9iXizjMFOfQbyVTRN0y9OGuy/mgSs3xyyaq9dlBaDflT++UVtbrYF61rG5nJQ7dNxlaTNAyU3oZMq/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4JGDBB0rQ+eAOr4hZCaDuhJyqTKafi2tTuQqvcbrwE=;
 b=A0jWGsuSRa5bwoZv0ECboH5AhYsT7r6/a7dwOssibdgJXGenPi4o0JTs0jVDNdXZQbxdBsISn6QmYSORZCcDPGKM8arLp2sBqipNgyOr74j2riyGzf7Fkq2aR+QPf1ud+Z6rtjZtkbIqGFkXHvMqmuZp5X4i3ggVojKquY3yJen0c0gSAkdbU6rxSyz1xV510bX3aqZm3HUIOKJaLhYmYKOKjdSQsUchEPw3Mo9Cki461xLpSEvPXyw9VxG2ZMTwXzbp78l4c9GXVqlqPuQknPQtPWh6DO0Qi6GhGCSEHGxQd5/mU6aQDkVD5TYo8ilH/1cM51pknqz0eKIG/K2FlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6759.namprd11.prod.outlook.com (2603:10b6:806:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 22:44:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 22:44:08 +0000
Message-ID: <de608041-bc45-4ca0-81fe-423a5167d7d0@intel.com>
Date: Tue, 21 Apr 2026 15:44:03 -0700
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
 <0334ba64-71b3-40bd-8cce-9f0f119e7dc9@intel.com>
 <d693f797-65f6-46ed-bd49-beaeee2da858@amd.com>
 <c9e10de7-f5b1-4a38-be1f-f75bc1ae7780@intel.com>
 <9d8a18da-14e4-4d90-a224-7d69d4daeb13@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9d8a18da-14e4-4d90-a224-7d69d4daeb13@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:303:b4::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 674f0f69-5ed9-4495-34d3-08de9ff77fd4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: PWoVrZOwmfPbaFrdOnS354bhe2E8oD9zwlbiI9wRLr/Ea37ykQI0F7UOkrjgjUF6wugL019N/pOkZwCoABjzsMHWv4wBHKfBh6g2J3t2sAAP+leOwu3t5d5CPeBxva4YgLszvWsodOuZ3gDkMtza2Magka7frxCT/aGiKu0Tj+ovp5z2gBpBAfl8OB8TM89jJzwHM9CWMPh+OWnVdbED2shK0OQ3Y+KTQvSoDJ0o0Ie1R09Fo7vD08XGgjszQQpyc1xIl9C4ZifYvhUYjDimXB/dc+rXyFOnvct78Yd/aQix8bhp3LBe7afhBRIjb4oWOaT9BLb5H2M8Gbn5RRCf4wWVZear/7xH9pBiMwqNR/DZqj2R6I+cW41n223D8V8mhzSmxam5spBGthM91INeeRluuc6fmfJ8bqsWgGuggWSbi8n+s+RwBvcr8cxiKnPlyJyQmaQbkXj0qYEuKsCW8YhGDkxsaa/Sc3lT7Fn1F1Qy47YZ963U2zZOE8dYSK6xp3x2o4aiMujGMO7HDCh9YQFn/o2ZkUA+GkJhHQgVGWO6Uy+vbCPABZ7IDiFyWMrzRobqAsuYQqgw3f4i2CXoO9yM2mwLsYR+JkPMh04fn2mlAMcBI97oc3kAh/IrR59urKg6pjhuW8EQkHVBk6qhhCZANtTZER4CNpjZddpbDummeqSPTNP5yQjhkACXJsnTW1oW1mq6celvHDAUriwjZCdL09AADTMTpgRRltgqQo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGc1Sk4xZElKdDhSU1dHQk1qTGRGcEFmSWwrS3U4UkNnNnYwMDYzTzMwZm9P?=
 =?utf-8?B?RGtQeDFsS0EzcGZJZ2FaY1BpTTF3U3BOZkwvSFRWRmpLcE9IaXFhVDZuWmlM?=
 =?utf-8?B?VjdkVmdTUDZUUS9rSW5WNmNLL3RadWdEaUFLcWtkVTBsR3VzSWw1cUFoMVd4?=
 =?utf-8?B?YXR2aTZBZDZzTURrS0FGUi8ycTdCV2JDZkdFRFplUCt5UjJhbkFTdmxtYjYr?=
 =?utf-8?B?RHZ4dVJ0TXlMQ1RydkQrMGtnQ21IWE5VQWJ6U3Y4Y1VxUk9YRm5nK0NoSi9Y?=
 =?utf-8?B?V0VHU25SdVpvTWxUOTJ4N2F5cWUxZEFaa3p6RkFBMGpiTmhFT1ZYMTljd0k2?=
 =?utf-8?B?SytCZ0Zma2I4eW1Oa3lZTkFVd3RIU3NuSTl1Ui92bVBHTFN4RXFFZTJIajg4?=
 =?utf-8?B?TmFvUUFKM3ByU0JDWGJtd2xMZkk2azREcWJORG43UzlPRHVrMmFlRUZ6dWhw?=
 =?utf-8?B?QkFYRXd6YXV0Rno3eXBJVGZTZVB5MEQxUEd1Z1FxT05VeGJpMnNjSUZ2YkxM?=
 =?utf-8?B?SGdoSzNMTEZDQW10RTA2QzZwV1c4WkRUbXF0RG1FcDFMQXRKQXZTMlU0aXF3?=
 =?utf-8?B?bTc2ZUtaM1M4OC9iYVNRYVhKZlNmekNqMGJPcS8rOVFqMnpTM3k0OVliUG1E?=
 =?utf-8?B?cUJXN1UybFZiZU9xbXNJaWxuVmNYekRwOVZQSzVySlR5NmVTREx0NjhDQ2lm?=
 =?utf-8?B?UHZuTWtQVWFwOXduYmdlZXVUUHdQLzJ6ZUthcVlqWVZnNVI0RTNPamMyRUFT?=
 =?utf-8?B?WmZMMm10eXVKREQyeWU1SkZZSFQ4Ti8zZm1UTzVpcFgwS2pBaTR5SXJpcmE5?=
 =?utf-8?B?L3ZmSGRzU09QNStraEFDRTZqUldkQ0JnQ0xDNHlhOXFvRmpmNWZmVE1hNGF2?=
 =?utf-8?B?bFp2OGY1WmVTZlFQY0lvK3lNVkNycUZUV1pOSGpCVUVudUpYanZtU1NtaDc2?=
 =?utf-8?B?Y2hyUFZlMk5CY2tlMkc4UEIyUmJhSGxzODlOUUdWejZ5U3BQWXJGZU9DOERy?=
 =?utf-8?B?T3B2M3RtM1FnQVBZMkk1cXBZNVhVWjgxM0N4eU02dDZLdmxOZDQ5YTJSRHlN?=
 =?utf-8?B?M2drVzlrK1FjK1BnZzZMOEg0WnVXTlBEa1lYR1ZaY1FBL1RiNmE5MnhOajFY?=
 =?utf-8?B?YnFQSFBrTWVsK1JJS1BQZFJZOHNQYktOZVlrQWpoWGFTNXVHMTV6Ty9sQlNX?=
 =?utf-8?B?eVJ4QmNxOGtHRXk3VEtTb3c2eC9DTmlrMmNOK1pyZ2NUK0o3cVJ4eHNLQXEw?=
 =?utf-8?B?USsySGhtWFB0cFBHWm5mMDRWZTg4YmMxOUVQRTFXSDVrV1hGcnMwdmVld3kr?=
 =?utf-8?B?K05VTU9xK2g5eGxCeURkeEdhOTAyaDhNeEsyZHRQK0NTanFkZHR4ZmpOMXcx?=
 =?utf-8?B?b3RLWmczTHpXU1FwQmlIU29DZnF2dHU5ZzMwY0ZIaU5FTi9GVC8wNUhtU0R1?=
 =?utf-8?B?Z2dZL0JMSG91c1FmWTlsT3cyYnhqTG5BRmhweGM2NmRnMlE5OTFUTU9WV3ZL?=
 =?utf-8?B?TnhJV0pDRTM4R1ZyY0NlQmxKdlJ1dWFvNzFoTUlkR281UXc5bUhDZ3psUE5Q?=
 =?utf-8?B?MU12eWdaTDZsU3Y0YnRwOWhOeHFHMFo1UU1WTXdRdXFYb3RaU2ZPcGc2dm1h?=
 =?utf-8?B?YU9rd2kwd2F6UVY3R09acTNIaDRWZnFucEpMZVZJUTZKZ3NGMjU5Ky9ick5B?=
 =?utf-8?B?UkFxeU1VQzVNc0lIS29vQ3ozR2R4UFROakgzR0NnRXBuL0FBM252aVdaeFdi?=
 =?utf-8?B?cjdsZExpQlVLcWJ1cWQrekpKREdRdU40THhZdndNTEdiTklkNmxHSnhVcVhq?=
 =?utf-8?B?WkxzaGdwaWhoWXptZUMxeFBtcWVRcGZXUHJVcGE0Qnl2T3dybnpaRGJVZ01E?=
 =?utf-8?B?Z1QvanhNMjYxY3VMRi9jd3JxLzhJQ1QvZmFxK2JWWXpielF4dkxkR2FXU2JF?=
 =?utf-8?B?TjFZM2hSdFVTa0ExeDAxQm9uQW8vWXk2dzAvVGxaU3RGSERaRStCVVJTTFRO?=
 =?utf-8?B?YUNDeDhSbXVHcjdxWUFMNzU0aWlOeFBrRWFBRk5BbUw3NlRTUHVCSldRa1Jl?=
 =?utf-8?B?WkNOdm5HVWdQbG9wbFNqaEJkT1BJN1RLY2kyRzBrWlhwTXZsN3czNEZWRTdS?=
 =?utf-8?B?UWhqR0FRYnpGbjBTdnJuS2c0blpxZGFqYWVWT0RXTzNJakVJRFZpSzlzenlq?=
 =?utf-8?B?VFpNSnhSVmo5aDY4VmNYNDhFSHVCZkwwZ2pYVlE4UUkzNHlEaStibVBwN0xF?=
 =?utf-8?B?Z252S3krUkN3YVZXQmRvOWhhTFN4YlhGT0Y5L2EzdGRLNEtqQm5BdHhDV3B3?=
 =?utf-8?B?bUNTTHYwZ05aclNWaVZmVnBGT2d6bVI2Q3BFODlXSlVnR2E4MDdWMDczZEdR?=
 =?utf-8?Q?n0ANkuF7QKt4OJ2Q=3D?=
X-Exchange-RoutingPolicyChecked: nvGNJnhR/MS2bPlBqX5PXKzhSPuS8QpDTeR5ZHQ9aK4vS2q17G0OWx9wuLBrzQqP3dkAeTbjSbtmFewshP2nAJ4PBRMcQZN1U+JvtCs12hCXih9H6fo1fb+gYo60T+8t+jWbG0LPv1QPVxdfd/DY/JMJQwPoNq3cc6wLc2Sb+kRoUShjoTmMXFnpwAU2R5ymDkbBAKj18414P+ybXQqWVjWgox8pk3S11OId4Y+UG+8m2/UVsxkLArrkB/VFPvbNAGul/OtEjHsYBNmU5FteG++Yn3hpgZgfzW4zhDIwFCLyxeLcY5krz1yajuLkhybf+8jsEAOUcz2fHbuVzKdJOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 674f0f69-5ed9-4495-34d3-08de9ff77fd4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 22:44:08.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8UP1Xjbg8uP2YYdcSzidj6IAoP8CkbdiI6yaGkI5nBawGp4InuJw/qmF3tVTMTiAHuCGO+xUfGokno9RONwru/psPnEAMIsQ+Qa151Glio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6759
X-OriginatorOrg: intel.com

Hi Babu,

On 4/21/26 3:04 PM, Moger, Babu wrote:
> My bad. My only motivation was to keep the mode listing display consistent.

The listing display is already inconsistent since the different modes have different
global properties, no? 

> 
> That said, I agree we need to support this. Without it, we won’t be able to move the group from PLZA to non-PLZA.
> 
> # cat info/kernel_mode
>     inherit_ctrl_and_mon:
>     global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>     [global_assign_ctrl_assign_mon_per_cpu]:group=ctrl1/mon1/

Like above where the listing is inconsistent. Is this what you mean?

sidenote: Should the last line be "[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]"?

> 
> # echo "inherit_ctrl_and_mon:group=ctrl1/mon1/" > info/kernel_mode

This does not look right. Why is a "group" property needed here? Can the mode not just
be set by itself? Specifically, why not just:

	# echo "inherit_ctrl_and_mon" > info/kernel_mode

This reminds me that there is still an open remaining from
https://lore.kernel.org/lkml/71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com/ 
Specifically this from that message:
	The named fields could be made optional, if group is omitted then it will become the
	default resource group, and if cpus/cpus_list is omitted then it will default to all CPUs.
	This may not be intuitive since a user may expect that not mentioning a field means
	that the field is left untouched. Have you considered this scenario in your proposal?

I think this needs some clear description of behavior wrt properties, for example:
- Is it required to provide all properties on each write? More specifically, can user expect there
  to be "default" values when a property is not provided or is user required to provide a value
  for each property? We need to be careful here because we do not want user scripts to fail when a new
  property is added in the future. What if resctrl specifies that if user space does not provide
  a property then resctrl will pick a default. For example, if user runs:
	# echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
  then resctrl will switch to "global_assign_ctrl_assign_mon_per_cpu" mode initialized to
  the default group.
  I am not sure if resctrl needs to support re-configuration of modes in the future where the
  mode stays the same but a property changes? Consider, for example,

	# cat info/kernel_mode
	[inherit_ctrl_and_mon:]
	global_assign_ctrl_assign_mon_per_cpu:group=uninitialized

	# echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
	/*
	 * resctrl switches to "global_assign_ctrl_assign_mon_per_cpu" mode and sets
	 * PLZA group to default group
	 */
	# cat info/kernel_mode
	inherit_ctrl_and_mon:
	[global_assign_ctrl_assign_mon_per_cpu:group=//]
	# echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > info/kernel_mode
	/*
	 * resctrl stays in "global_assign_ctrl_assign_mon_per_cpu" mode and sets
	 * PLZA group to default group
	 */
	# cat info/kernel_mode
	inherit_ctrl_and_mon:
	[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]
	# echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
	/*
	 * TBD: should resctrl switch back to default group or just keep
	 * group as ctrl1/mon1/ ?
	 */

  resctrl could thus specify different behavior for switching to a mode where all properties
  not specified obtains default values and re-configuring a mode where only specified
  properties are changed. That means, the "TBD" above would be that the group stays
  as ctrl1/mon1/. So,
	# cat info/kernel_mode
	inherit_ctrl_and_mon:
	[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]

  What do you think?

> # cat info/kernel_mode
>     inherit_ctrl_and_mon:
>     global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>     [global_assign_ctrl_assign_mon_per_cpu]:group=uninitialized
This does not look right. After switching the kernel_mode to inherit_ctrl_and_mon
I expect inherit_ctrl_and_mon to be the active mode?

Reinette
