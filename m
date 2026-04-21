Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F3363082;
	Tue, 21 Apr 2026 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788168; cv=fail; b=sNGAMeFIqYW7HjIHDcsuH6uqZ/ijRDezcafSS9nFW/65hmmGY8sBH15WCUjSkgtRfn/hmHGKTM06qtscOz20bk6Azz74gycIzekYE76N5zAnTbc4WRU7cLIasi9RKaNuiJOGieqwRoCq8uudT6zj2Ift7vgrwKQELxm2LMzsRvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788168; c=relaxed/simple;
	bh=HawPvB3u32ylKkJ3RjjwP2nMh/0skIicwCGSDEn1r/4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sTeR5u7pxrS/VI9i1M0ITOWWtM6AmFR0sUT3sQnEntUk8J0S4HGIbkkCZ6xhSNWGSDaUEXAve/QMg3vIxXvWaCAxU1UOgg4pF7OfZLMBcR6zy41B0LrwvIykGGsYb+a/94K+Nrv9gYpl4sMTN2slcFVGs+nMlWj521ygC0W9sC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRpAGsS0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRpAGsS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776788167; x=1808324167;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HawPvB3u32ylKkJ3RjjwP2nMh/0skIicwCGSDEn1r/4=;
  b=gRpAGsS0BgPb5byucE40TjOvsqY7siTDiXdAvRBbH3Six7zCmbNLIVxl
   Tgc7dRKf7PM/qc+qQ1qsGy1wocnOlE/jhkYqPgtWSopOZL7k5QfRkrOQh
   Y3jaGChvQsW08EB5aqI2glBug7MV734mkqF88eTNAPvggjmGK98kNch5r
   XenYAA5cs/rutIqy7zZnR+wDgrc98vqVartqJtWQ4f4kHj+39Pm+IyVY2
   oHuLli+gkVzPLfLYady9yRfh82E1DZr3pUihV48Tvvbj3Vu+HaPt1vu0C
   U4q2wiWOCZ6UCeO1WnL1uJdQLp977fnfNEC59J23hZqJEPZLLT60nzmRs
   A==;
X-CSE-ConnectionGUID: YpP2L7SgSnGNogp/VMqhRQ==
X-CSE-MsgGUID: dJnvUINbRQKlLGd3gl5Djg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89198280"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="89198280"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 09:16:06 -0700
X-CSE-ConnectionGUID: gO2PYuu6RKKig1qiZmIsSA==
X-CSE-MsgGUID: 4hvB1dlpQLO3H8J676fjVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231991610"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 09:16:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 09:16:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 09:16:05 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 09:16:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWM/E/A1csGFmMwonPBR+ZR0zvWBbJUeWhFLZWNV3OYskq+7ERy+a2uNCX1wVhN2N5eCJozAzasibvEZ5OurkzOWcSsAbKjiC325BXqbgLMEEnsv9FxROVRTc8FLzpQJB8iLsyEEX0VQHh2yZboo63OE/Hvt1a/TIPH5X4lr4o+x84q9gnJk6diqLumjHynxfnSgI3b6OuWIymbbdWeGVgFxyJ+mHFMYud2UdCmbWl9wRTqJxVBK54JNI2tZ6Rn0JJBmFwb0BwQnAnrGER4z8py/MopiHXTjpoDc30zNagZGQWKqhjVRuPFDArn0a/xhAyNtGjlkCSRcAkMHc+H9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2j4fbHwASKIRlMrL2XvqpKh2XInkI+bIsr5Z108dO8=;
 b=Xcyq7ENSLzalRNt3EIN5ryC8hGWkkFbrNwG3f0AhUMHbVFPJfKgqjQzQZPrrHYGeQLqaPssosDo1pmCWk/G4BwlIW3PA9fuJ0QXupN87Iecu2CsMDs09gxpygYaZMdThxAOlajZfT2WDyHlXClTAf7sGUPlTJMnrQwpDfHP2BzvO24aVuzCsxY4rBum4td03MpNzJlBYrKvBpLKTUDtR5Tf80HgNdUG7wx04x5mRfBVIK6N7D+Zk4obJiBeN5JqHpkWnbkuZCxScAoEWOCODx8BwubBbwc4c9wYbml4fPoSDcfOq+dnOKBiwcjZSJg6oNlClBO3Z+LGpRtbCXNwn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5815.namprd11.prod.outlook.com (2603:10b6:a03:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 16:15:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 16:15:58 +0000
Message-ID: <8d969f11-4a7f-4e36-b85a-c3ed714fc603@intel.com>
Date: Tue, 21 Apr 2026 09:15:54 -0700
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
 <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
 <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
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
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e624f652-f0a6-4926-a0ab-c4486d41eb6d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: e57ffa07-ec0d-4577-664e-08de9fc145a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y0tJq06hy7c63qwFPzzPqOU0KmJ4nYUDQ6kDjyZcRMnrtzsfvIP35tLEhLr4FvNYLv+dsagHFYtbWK3Xwy1PUhG3robqCtAOA9gH022iuUR8R/KLrEII/zamLm3VzBF9JwEaG+UNRB7hGqMAhunZpybJjaojDkKCFTwh+ZVdhMPC3SplujZ4DW4kQ23muWd5aHKURXpmtdUJytPyH+M8xl11hot3/ASCYctMEEyCnU7U8dC8y6JdNpG1pVPz8vvSUmQc8GKikWhaytyRnFufTtO3NwSTZc8wwkA0ZH/AuK/5yHj9YV/lnDE/HCRKCo1vBVdqOkJZBmGEllH8IVPncSpHo7NgimBO0DGroP4VWxOPpqo/wUsDiD4h5sTzMrvuG+xruFDKoCCuvFOp2OoUd+WqDVEkTp76rxbgUiKqdkiS6NmGfWj4pe17eB/1ibDLnP2bkTLeVBEyc8htUjMEQcYKQS6irSbpbwV2sfdoK/F9Iij8GX5E043DiAp+VSN9U/Kiumy0yresBoZWb9o4u12uG6HB6UI0Mx+u00tkglzgVrIGlIZ3OIz+fFQ6m86bWii2Uzv2RPXgAvcEXxzFUcgQui4DXWa57LfC+N2EDmBNo9KUPnk0TvL44G67OfQgmZxzbA48BkQuFna+UtRfD2vCJEKILdt/QLNkewaofu1X23PMBY87pQfBYbO6E43skyXjbN60d4bj/hCSvuCg/OMNp6UZ6CDUuHWUmRBPonf+7OD+TKlmHb6pg3PUvYXM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0REbUlzV2hQWnZFU0RHR2E0TzljQmpmWVVSNVZsWW95TmVzNkNqMEhSaFdQ?=
 =?utf-8?B?RUV6cXFMOTgxcnpObHNDdC9BVldFbytCK3hRRDY0UUdabHc4b1hDZis2dG9U?=
 =?utf-8?B?dklXUmFWVG4yQjZyQlk5aEE4dEpoem5heTlsK2FkTlZ5RE9MOXpMdlFKZHpm?=
 =?utf-8?B?c2tMQnk5YzNTSmJkeWhXRGRnVEtQQlJhNDdoK0VObko2WXVpeElKVE1WRTB1?=
 =?utf-8?B?ejF3Rmt3TmVkak5tUXd6VElpV0pQeS9hVDZvK1hsYU13MUZhTC96R2tFanEr?=
 =?utf-8?B?QjNuWll0ZnhBVUJmZ0prTVNpUk03eGJobzRZamtWSE1kTEFtdEJGcElXMWpQ?=
 =?utf-8?B?M3BQcFA5aDgvWXUzelJOdWJnME5MN0NNQjI4dWVQWWQ1SWk1czE0S0UrSEtC?=
 =?utf-8?B?dGdkOFFGUWZQVG5tSWg0VWV2enNoaFA5N2VmK2crNnd6c2U1bWoyKzBBN01p?=
 =?utf-8?B?dHM5bnNWNU9PMWFtYitEOWJSOUg1VzhGMmpaRDVjNHMyN2ZES0JSY3g2MDhI?=
 =?utf-8?B?K2h5M2pRQ1BZVkFndGxBeTU5dWNRTFA3dFN5cmJCcU9NZ0I1NE1qc05taW42?=
 =?utf-8?B?OHZUVHNQUjVERXZ5cVZISktGbDl2eXp3RWlRUm1tTlRRWVNCajZzcjlLalIx?=
 =?utf-8?B?ZWdvTXdTVFozRlQ4ZldPZnNXV1J1cTdGRWN2bDlCamtJclg0NVNUd1U1MlBR?=
 =?utf-8?B?YlZTaUZPME9PMFNNU3pEek1HdHBUOERwQkg0STE4WVkzSCtiY09MWk1GY1Br?=
 =?utf-8?B?OXM2VnRKNTVvckpveHRTaU9XYysxRXNBUDMxc21CcWc0ek1zZjJYSVRhNjR6?=
 =?utf-8?B?bEhFZmFEbE5lZkkyLzF2WDhBWmJJSjUxaTF4ZW5GWmdtZENBaG8wczNUc0lY?=
 =?utf-8?B?a1Y3SVQ0aEMwTWgrYUJ6aFVvTkc3MWQyblRwQXppKzAzVUZncCtmTlJjWVlm?=
 =?utf-8?B?RlI3UDNuTGRXZlgyeHh6OGJPVTIwTlc4TkpIdzl5UHNTcjFrYXlVaW5KVjFU?=
 =?utf-8?B?TTZoOVpVem5EVUVjTXloblY1RTVieTVWc1NtZlZFaUhlQmpDdGtETkVKTmUw?=
 =?utf-8?B?NnVWMlI2eW1sMWsvUTlEQURzVTcydlMzcStzbXNhNlN5ZFo1NjhsQ2xPMWRX?=
 =?utf-8?B?UHRlaXF1MjhLbkE4cVhKa1Y3dEIrakRhR0k5NnU1R29vbjJ5bXJXQjBWNlp1?=
 =?utf-8?B?RkxMeDJGcEJFUGNVdVREVlpEUzdUd2s0cms0MlFpMjExL1hJYjdLMmJhZ1RZ?=
 =?utf-8?B?ejREMWFLd3J4NDNkMnVVcm9sNFR3UkZkWERMbzFwUDlDQjRUQk9FN2dWYnls?=
 =?utf-8?B?YVNWNlNLVGNDSml2N3dkekp4dVFQWWdrd0x0bThJWlNCRlBmMUprVjEwR1RW?=
 =?utf-8?B?b3UrV0dHZGNxT1Ywanp5K09MbmFCcEZ2bGcwTkxQM3A3OW5BbytmUk5sek9D?=
 =?utf-8?B?dVZsYi9LZmFmdVdEcm4xYkV0OG42SzhlKy94bk5zNWV3UUduZDZFbHdFcWhq?=
 =?utf-8?B?V3pMNm9LZ09FbVJWenpVS0xoa1NmZHhub3V6VUc4dEpFRitndWZSbDB5M1d2?=
 =?utf-8?B?ZVFmR09uM2ZROG9rdzJGUGowOTZKVG80MU1qQ2FvMzFleDVZY0ZGVEFQVm9R?=
 =?utf-8?B?V2xyMXkxUGtwMVRCN0pEMEFORkU3MlZGaWtJMzc5V3F5K0dQOXNHeDladWFY?=
 =?utf-8?B?dENRb3pwbm1YRE96MHJ4blNYMEV5MWtGMk5keGwrZzRLVXBxenpFSVRqeVY1?=
 =?utf-8?B?Y25haENORERnMmx4eTRrbTJvakNndnU1SjNrZHVPanpkKzFlanhLUUtBa3R6?=
 =?utf-8?B?QUFkcmMxY1Q5K09PekpNWjJWV2k4WGEyL0NNTDA4d0NPR2tjNTFDVlJxSHhm?=
 =?utf-8?B?WFRwbmZnallZalMyVTdkYWpUc1BYY1JBVEFuR0g4ajdXUXhwMVhqNTVOTUp2?=
 =?utf-8?B?RGY2Wnc3N3pNKzlBYXM3eUZoWS9mTUJUNFhHR3AzSzQxUHljaS9HeWdEOUtr?=
 =?utf-8?B?VDhVVjd0TE1QVEFUZW5UakZNc01JZ0FCYXQ4VWowSDBxbzRMWm50Q1k2aVhu?=
 =?utf-8?B?bkdHZGxWMkcrYzNLVCtnUnMzUWUvVDlZMUdUeVhZc3NMdnpFYlNnRzFBaU9F?=
 =?utf-8?B?b0dlRlk5b08zMnZMc2ljczhlRndzejBDQkI4S1VZY0JvTVJwOE5neUdUY0xZ?=
 =?utf-8?B?SHJMUGJCOXlsVENud0ppd2hKVmJyVFlvRDg3WU1rTzk0OHlEaUk5SDdybjV3?=
 =?utf-8?B?QlNBOEFnSzJSbm1OSGlzREg1S2E2TzNvandYUCtNWkVyQ1hJUnFTRGEwWjMr?=
 =?utf-8?B?L2dRODZHTUpEcEhSV1F5USttb1dpTXVDemY5QSszTE42Q2FuRDVUMldsVjZF?=
 =?utf-8?Q?ax6SMGfkmp1ij5no=3D?=
X-Exchange-RoutingPolicyChecked: BFBAxWr06wN3QAjc4Uyh0jbU32nA3vY8VXQmilQCUD+YaQG/HV6ABNa2H4OQibv83HAH6fasXVcFgXBdtUYDleTG2CfdqW1fOF/KJFaTGAlY6d/chBlkxpXKMxdppES0Ww/o/Awicp3ybfbxsrhFyP07WQMfq6Dm8nQ+0JzeD5k0Yw9NWWyKhgNwZP3w/zO2QIv5t04iMzemG727a4x1p327Cv2q3vTwS5YKPdLHlSoX0nsB+snhmj8iezyh92erq351/22GQwi0vosJ+XUtHkhAYtgYkxUAS+GQDHPR/80c3gxj2f44l+4B+fqzLsxSo3kwv9ZlKZSh8bgqGCumIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e57ffa07-ec0d-4577-664e-08de9fc145a3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 16:15:58.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxLU0oOfOC9A9eekPjej7LI4wh6mY+NFFQOn7mdWH3zdLaUbtG6HgHG1S5OEwI+K/wao82t/N0ZgGXG4y/lGDE9Njfc7YMGfBdc/pjPgJo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5815
X-OriginatorOrg: intel.com

Hi Babu,

On 4/21/26 8:08 AM, Babu Moger wrote:
> Hi Reinette,
> 
> On 4/20/26 22:17, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 4/20/26 5:40 PM, Moger, Babu wrote:
>>>
>>> We already discussed moving back to the default group on every mode
>>> switch. Doing so here would once again cause extra MSR writes on
>>> each mode transition, which is undesirable.
>>>
>>
>> Needing to avoid extra MSR writes in resctrl is not so absolute. Consider, for
>> example, how resctrl initializes default allocations when a new resource group is
>> created. resctrl aims to initialize with sane defaults and the user is expected to
>> follow with desired allocations.
>>
>> I am not against optimizing, I just want to be careful with such general statements.
>>
>> Considering your proposal in https://lore.kernel.org/lkml/39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com/:
>>
>> I do not think we should make info/kernel_mode read-only. If I understand correctly
>> doing so would accommodate AMD PLZA but it ignores the discussions on how resctrl could
>> support MPAM ... or do you perhaps have proposal on how MPAM can be supported when considering
>> your proposal? Even if you do not want to consider MPAM - what if the PLZA_PQR register's
>> scope becomes per-CPU in the next version of AMD PLZA?
>>
>> The idea behind info/kernel_mode is that the active mode it identifies indicates which
>> configuration files exist to configure the active mode. Since the mode may not always
>> depend on global configuration, for which info/kernel_mode_assignment was created, but instead
>> rely on per-resource group files, I do not see how resctrl can build on a read-only
>> info/kernel_mode backed by a mode and group change via info/kernel_mode_assignment.
>> Specifically, MPAM support may not use info/kernel_mode_assignment at all.
>> Instead, MPAM may use something like described in https://lore.kernel.org/lkml/aYyxAPdTFejzsE42@e134344.arm.com/
>>
>> Could we perhaps consider dropping info/kernel_mode_assignment entirely for
>> AMD PLZA's global allocations? Similar to what you suggest, the mode and
>> group assignment could be done via the info/kernel_mode file instead?
>>
>> Thinking about this more since the CPUs allocation is global, these could *theoretically*
>> be included also (but see later).
>> This could mean that "kernel_mode_cpus" and "kernel_mode_cpus_list" could be dropped?
>> Although, this may complicate the interface since user space may want a convenient way
>> to modify just CPUs independently from needing to repeat the mode and group every time.
>>
>> Consider, for example:
>>
>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/;cpus_list=5-8" > info/kernel_mode
> 
> This looks reasonable.
> 
>>
>> Having named fields (a) makes this extensible, (b) output does not need to be split among files,
>> and (c) "inherit_ctrl_and_mon" can continue to be supported.
>>
>> The named fields could be made optional, if group is omitted then it will become the
>> default resource group, and if cpus/cpus_list is omitted then it will default to all CPUs.
>> This may not be intuitive since a user may expect that not mentioning a field means
>> that the field is left untouched. Have you considered this scenario in your proposal?
>>
>> As an alternative the group could be made a required field and "kernel_mode_cpus"/"kernel_mode_cpuslist"
>> can stay? This may be the simplest approach.
> 
> How about keeping a single option to update the CPUs using
> kernel_mode_cpus / kernel_mode_cpuslist within the group?
> 
> Should we consider removing the per‑CPU extension altogether? By
> default, the mode already applies to all online CPUs, and any
> per‑CPU requirements can be handled within the group using
> kernel_mode_cpus / kernel_mode_cpuslist.

It sounds like we are saying the same thing? 
When considering all the sharp corners I agree that keeping kernel_mode_cpus/kernel_mode_cpuslist
seems most user friendly. When doing so there is no need to include CPU assignment in the global
files.
 
> 
> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
> 
> Why do we still need to keep the "inherit_ctrl_and_mon"?  By default all the groups in the system falls in this category it is not plza enabled group.
> 
> 
> System boots up with following options if PLZA is supported.
> 
> # cat info/kernel_mode
>       global_assign_ctrl_assign_mon_per_cpu
>       global_assign_ctrl_inherit_mon_per_cpu
> 
> No groups are associated with kernel mode at this point.

To me it seems useful to be clear to user space on what the current mode is. If I understand correctly
above default scenario essentially means "inherit_ctrl_and_mon" but instead of adding it to this file
we will need to add documentation that describes to user space how this file should be interpreted.
It seems easier to me to just be clear via info/kernel_mode itself on what the current active mode is?

I think something like below will be more intuitive and not need much additional 
documentation to understand (I am just adding the "uninitialized" as an example to match text
printed in schemata file during pseudo-locking ... even if there is a group named "uninitialized"
the lack of "/" could be used to make it clear what this means?):

	# cat info/kernel_mode
	[inherit_ctrl_and_mon]
	global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
	global_assign_ctrl_inherit_mon_per_cpu:group=uninitialized

I also think an interface like this would be simpler for user space to use as it (user space) switches
between PLZA capable and non-PLZA capable systems since user space need not associate existence of
the file with some kernel mode state in addition to actual content of the file when it does exist.

I assumed that info/kernel_mode can just always be made visible and not depend on PLZA
capable hardware. This means that on Intel and Arm this file can show:

	# cat info/kernel_mode
	[inherit_ctrl_and_mon]

For Intel this is accurate and also for Arm if I interpret the Arm implementation correctly
(see mpam_thread_switch()) in  https://lore.kernel.org/lkml/20260313144617.3420416-7-ben.horgan@arm.com/

> 
> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > info/kernel_mode
> 
> # cat info/kernel_mode
>   global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
>   global_assign_ctrl_inherit_mon_per_cpu
> 
> 
> # echo "global_assign_ctrl_inherit_mon_per_cpu:group=//" > info/kernel_mode
> 
> 
> # cat info/kernel_mode
>   global_assign_ctrl_assign_mon_per_cpu
>   global_assign_ctrl_inherit_mon_per_cpu:group=//
> 
> 
> How does this look?

In addition to above I think it will be helpful to add a clear indication to user
space on what the current active mode is, for example, via the [] characters.

Reinette

