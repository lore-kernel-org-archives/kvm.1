Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69F3BC691;
	Thu,  9 Apr 2026 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755586; cv=fail; b=eN4SEJ1Hbb/6nix9+oxUnEuXbLRsjOBwXf7TSM7dRHFrF6vfP+bxrULXhmce7O3k6WODeYXlqqqRPf+Yca91VR+DOBRDgTH7pKth2MMANmGw636Z6iOtBbsp8qFysMZyvQ5TIvwq8TJPaDZmhxNKZTINWMA5GWG5MoZtWBOZYqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755586; c=relaxed/simple;
	bh=cYj4yzeH3RMz/MiHmQBif59iDUsg16LmlEqRXAj1Xl0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sIrIuYVPnpxUcg5uQULsELqD99+MTpUwtflR9pEDBjmQtbaqcxtvfovGE6pSHXRxEfvb/nRNFa6cNhn8okogtbEu7udYA7tY6uIxcOTHhXJQL9Kf4qmu7kQpOr4FVqJTDYnKd14/mVbm/m6zLqEzOF8nt7QXVfQZdi4giDjiZBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm/Dy0on; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm/Dy0on"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775755583; x=1807291583;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cYj4yzeH3RMz/MiHmQBif59iDUsg16LmlEqRXAj1Xl0=;
  b=Lm/Dy0onKkZvSMgJHLmcV1pcCuPjfIVFIzRKZNOdeNDuNSmmsb8uCsWF
   uirBGOpeF4n9PWUUS3LKCeTAnpCUotoEzwGY2cIx7QekGvOX3A/EWWLS2
   95MnIgmR/DjWS3fqSz1Z86P9D/ifWERBuIKjHaHSgNAXTCZ2fSNXFwEbY
   6imUIY6gpi6kpZBEzsjte5RLdLTTbjp3qfmuiXy4vqCirBbzyRZ8eqcZz
   M4OEo7XAlJedgwUSHNWWc90KmOY9xSIk6kKbS9sfO+qfhajMJBz++9Lzd
   I3UFd6YeFLTUgYRibxQwq8YQOos/jlP+X+RZaErHT3q6be55om+3vdO9t
   Q==;
X-CSE-ConnectionGUID: XzAg93UHSICgL1aLF1nQKg==
X-CSE-MsgGUID: c5v8BRlZS2e8dbghnRvuaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="99397485"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="99397485"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 10:26:22 -0700
X-CSE-ConnectionGUID: ZmVkkvQKRXGk6xAteaQMwA==
X-CSE-MsgGUID: k8HN4/O4TTmpK6XESlNtiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="225665612"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 10:26:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 10:26:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 10:26:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 10:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGjpu8w1886aAV3C4SVah711tt5uuUxtb5QLEz2SeFSh8kpp+q2UtthxFBL/Cs8W4rhYaBeDmPajgZFPLbXidFGVJ0iWY8FLNuzq6RHuraBdP0wX6q8PiGEln1fjwzBc6aM71/uh5r/CwNvxC0kyW7/TZEJGd4VuVQmzvWMBuhr0aR5LKJVoAywSLyEJpgsp7KTL/gYo4YDuW3/gRtVB0XhBruzat7+GNLTl4gqFFyUEzBHKZc5C6S1T6yASOOC24k998u5c7UimyZ0tYM8ujlr0SZUJUPiGnPd3DzRYFtlntTWDIiYVlHCCCMmTjgpZqdGcRaIiSvK0bKysk/U4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoUmZnF51WWTYcs8hTgeprbWYdxHsusNoeLUAcUAUaA=;
 b=gXNx0gtMDKnfZPCwcRMplpaUFQH8oBRSm5rLFpvCLRAplPgw9oS6CYuO3rt8Zlij+E7j8jnJ6eI5LCsLKUxiFL6Xu3q4ZfCDEteEH73/oMAo2/4LWou5fRWAJhm4vXjT3L08Jjxg2bATGEbW0JyIcu9bxEWcC5JbIvaxzgfCO+YceLhU0eQU75u6yKHe3YcMbVQ2uvj/tOjXpJA3I1XKL48yNfRH+edrtVkjD3eTw96pjQUio8X2DWEq8BVT0i+BqkqSJOs+OwW47O/ucE9fvnPl9mxmsFf3fuakEM7s7FcnwB7rL/vFDZqiz6CcKxQREsBk5etyNMIt/+KbjzJnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 17:26:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 17:26:15 +0000
Message-ID: <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
Date: Thu, 9 Apr 2026 10:26:11 -0700
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
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0333.namprd04.prod.outlook.com
 (2603:10b6:303:8a::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa2aa9c-40c8-4ea3-f2ce-08de965d1aa3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: GrLYOd/KP8cHasneEzPOCNdRje6JdkpkcTXoBj7ff55EWS+w1x0bHPm5MirtwL+vTjQt7L8ZxzpQELBHw8MUc3sT59zqnWbH4nSN0kWTFjkAwlLWgWtDysDOiZK/qS0C2lPB73XLsYgYf4o+L8e7+waXE3qz/zpmCSvRnwMr+vZ1ZRaNS5/9845I2ZSblco5qmbrDvaBAlKHtwqAf0zRm8RrnubNp//i0EKPfs8rTgYXwR+PcFmDdaKcerccngnRPQvZ9Hr9VEbURPA+KWVjhLHLJif8DEP362uN7rBb8MGDKH08ztKk2MHE3JFs/sGvmPNNZqqo78hs+N6qJOD8Ujp2G0TPXrRS10qA1fgBy3d16I/H83er1k0v2M50U8HPYbTAfa1DybkM1w40R5j6YxIFPrTGXPGchlCQkaJyNh/QI+OMWRTI4hUM6sm6RdlqSKiPBCc+gUg8l40aFBVmLRjWZBfe0wkshOHzuBBrgVW/cqFYLPKwLnp/3HtQTPL4zuIMyngTCnVdB77pM0OnnrAnQ8LA6206sACYpW+2ftmjlZm/vAPuqMYeeLaJHOBwnjfrerducS7M22EfCdPePcyvURIXKO1bE2ZlXdUu9+HZBUGY1zk02CnyiYvb47fU386uBH8A0c1Eu89pu7Jxz7pHjJJE29BgaRxrWxUGUNVOZl907qVS/Fc+yYsrvu2JHjI3ObcTH4Q0AygIO6EBLDF4L/RGAKYpVCSqRPwTcdZxoxkJd74Q5D0kmKxD1D80/Kstg4jvnJiOuzgkSV22vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm1DTEo3N1paeXZUYmI4OGY2K0YrUWwzVnZHTlN2RGZ4ckVITnZrM2JRUGY3?=
 =?utf-8?B?bFpIZk44TmdzZHYzb3FsSzhiRTNLUmV1WThUWGxNS2lYYjFLRk9FV1grand1?=
 =?utf-8?B?NHpKejZqbjlLSGE4bk9kWXE1TjRHMWE1UEFNVzljazdaQ0FMREo4T3VZQmhi?=
 =?utf-8?B?REV6R01tWVF1VUsrdDA4SXVhM0RDOTh2T3RSVml5NzZoajVDOGc2T3MvbkJM?=
 =?utf-8?B?UXArT3M3aTFXZlB2MVJJSEszc3g3dS9kb3BlZHM1My9PTllkZFNMRitBdVpI?=
 =?utf-8?B?RkFuVEFvdzZpa1NBOVJRNDhZR3h3d0hDMld5VVA0N0NLQXd4ekVEVWVaWEJj?=
 =?utf-8?B?NUZvMHJMNk9TNjlOWkIyZWhQTFlJUUxVejVRVjV3SW4zM3dQZU84aFlNQlNN?=
 =?utf-8?B?UEdiUytMUDlESlRYVUtxQTM1REtVNHhsUlNiWDZkRzAxMjFnbVNKMjMzN25p?=
 =?utf-8?B?UyswdXUxTjNUY1pORVVhdW9pN1BxTUZMZUhWZDE5WFZ6TWJBQVliU2NEYzRw?=
 =?utf-8?B?T2tPREdLSldHTDlYY0YrU01CRGtnQ0lzOFJndTZ1TEtjdkJiRG9xT1ZNblNK?=
 =?utf-8?B?MklXa1RmVFEycWw3dHdEZjRleDV0RGF0c3J6R25rM1d0WHA2M1pCZUtzbkxt?=
 =?utf-8?B?Si9nZll4MjF4Z2dBVXQrR3o5ZXpHWjUvbmd4aW1wcnVTaWxYQktZbmJzdnhj?=
 =?utf-8?B?Q0JFVFlyeDYzUkNWYzRpK1lNL2pGOFdFNmJXZk0wamlTelBlbUVUT1lUVDNw?=
 =?utf-8?B?Q2FPV1FPYXk4YW1pM2Y3M2hGNFRlSC9iaStnUHdJc1RudTlUcTh4UjQyZDBQ?=
 =?utf-8?B?ZER3Y3JkbDdIK1NINDIxczlncjFEb0U2cVVjQjBEYStBdWY4eEJVMWt6VzN4?=
 =?utf-8?B?bEJjTDFReHpRLzRkRU1ZNUZjWHVxN2FPOU02SnQyQXc0YmZyb1J3TVNhNU43?=
 =?utf-8?B?YzZ2ZWhMM0NrQlEydTNiRVBMR1FqelhUNEdpblB5R3QySW1pRUxvNDMxWWRF?=
 =?utf-8?B?bzgxK1AzT2J1YWVhLzBGUHlSZnRRYTRLcm1HU1kzaW9JUUlrQmNsaTVib0JD?=
 =?utf-8?B?L3VWR2F0aHljR0gyb1JlUkFPUUxLeGR3YUJkcDB0VnNRYk1YRDd6Y255WS9r?=
 =?utf-8?B?eVNSbmVoL29WVzZOalFYRW9TUks4YjIxdnpQb24wandIcFZtM29tUVVpQjI5?=
 =?utf-8?B?Zmx5RWxabWo1UGlJOE1wQTI2ZFJIbGttaVYxSmdtbEE2bDNTR0craTNqQUxk?=
 =?utf-8?B?L3U1RFM0bGN1VjBRSml3Wm1EQlhuOC9KSHdZck8xckNqQmU1bFdEb3lhRWhi?=
 =?utf-8?B?NEpLUUROWG5VeFNVSnZGVnlmejJpbnVaMVNiVzFaK0lTU3R1S0lMdlM1WGpI?=
 =?utf-8?B?YmZESndDNHovdnl2VTlqVFljbTBsTGpHU0pNL0F0WnQwanE3aldpTEczWXBC?=
 =?utf-8?B?R2l2OEFKOHNhMkRMZzQrM05xS3I2eWNiNjI3MEVTUzRnOENqUjVJRGZzRjlL?=
 =?utf-8?B?cllOQUkyRVNCdUdRLytscFovNkQxTWlRQTZidDZTNTBwTG93WGJKR1JBeHBr?=
 =?utf-8?B?OG1hUkxhK0tUUUpXRnNpNGE3M3pKcXUzWGs3ZVp3M1RQZ3Q3WU90OWE5WkFK?=
 =?utf-8?B?VEtwSU04d0p1Qlo2QnNCaFVHdnlRSzF5WW9DWHFnT0xqaVZ4TllFUHhjelZB?=
 =?utf-8?B?ZTVFVHVIblcyYTE1SEFrWkljRFFKYnh0NFlQL3pCa0JJYU1nRmNUcDV1YVlG?=
 =?utf-8?B?RjNralB2dVNzZ1YyRVF4Mm5zMzhPZERld1dFN2ZxUjNURkJYZUZ0dk9ORGtV?=
 =?utf-8?B?eWFubm8raFBmK1NPeE9UVW4zak1INU92eDQzV2ZaMDVWdDcvM1U1SllETGtv?=
 =?utf-8?B?MHpEVFlTUWt0bjkrYmh6WFprZXlLbkM1VTZ1TEJPbnZ5cUwyMnhQQ0JNb0Ry?=
 =?utf-8?B?RE5jOEZHSlJhM3AzQmhOOHFDU3dMbnBra3NnY0dZQXREb2J5eGRtMHV5cjBN?=
 =?utf-8?B?VllaMVFLMzV4d001RUdQSWw1UHV6N29UeE95RXU2SWdYcUdGQkZ2WmVycUJK?=
 =?utf-8?B?K2tRdzM3ZW5hYWRJSGhGdExoNWJmUXhFYmticGs5Q1NOdkc5OHhRNUtvRVgz?=
 =?utf-8?B?cVNGWWxlUDlyNWk0WXpmOHROTzhRemkrckFMSUYvQkthUGNTQmZ1QWlPVDBZ?=
 =?utf-8?B?TnBoQkJ1VUIyS3RDcm1sQzU1Y2d0V0Z2VDBQQnB1MlZJT1d4dGdTRWVOWHZy?=
 =?utf-8?B?T3hrRVBsRXFoM0JlbFh0ckc4R0J4K0ZqQmlKb2YzbTNvc0gvTS9PMTdtUzRN?=
 =?utf-8?B?b0NiZm1pSFBNMGRFZ0ZGTHlQWjlpNkMxTXlDSVVxT0laaXZPZEVjd1laQkQx?=
 =?utf-8?Q?TX/iVEV+mFsXeurA=3D?=
X-Exchange-RoutingPolicyChecked: Df1os9dHAr2voUtRM2v1zp317T+6RcWE2Y4LQUz/YZ8mX6/VsftgbvNlgkvPHCaYzxVR33H+4HCgwrtfduNwUUpKJ9wYkYxGdSMngLWdh4EuanBw7OtwmHOI+WXRysIjltjovX3R2mPzMuqr26HShRKHvptmOysOgyAjZ6dBm3Aq69LH/v7Seo3nNAily+yO/Alwj561fCap92FKQIUBqmAt2cRpyQ4i49tOn+dbgmvUlL+2+ryy3pyw/j/jp42LTa5v+eWfz3Weqk1Va7EQahOhEluYc+vNBXSpubKYNLlAVQjID4b0N+eH9PVY+Ue7xVQEmFhSLduy3UMjYmM35w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa2aa9c-40c8-4ea3-f2ce-08de965d1aa3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:26:15.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OnpX/ly8X8uxBPVPzJKs/nTjKLl/W6BIDN6nOLbK4elv0LNlBe6K1TNPozQdkr4l9sn+XyeTykjsHlJR2MyZy4i+/ciukVPx6v6OnUHvIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6135
X-OriginatorOrg: intel.com


Hi Babu,

On 4/9/26 10:19 AM, Moger, Babu wrote:
> On 4/8/2026 6:41 PM, Reinette Chatre wrote:

>> When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
>> 'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
>> (or made visible to user space) and is expected to point to default group.
>> User can change the group using "info/kernel_mode_assignment" at this point.
>>
>> If the current scenario is below ...
>>     # cat info/kernel_mode
>>     [global_assign_ctrl_inherit_mon_per_cpu]
>>     inherit_ctrl_and_mon
>>     global_assign_ctrl_assign_mon_per_cpu
>>
>> ... then "info/kernel_mode_assignment" will exist but what it should contain if
>> user switches mode at this point may be up for discussion.
>>
>> option 1)
>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>> the resource group in "info/kernel_mode_assignment" is reset to the
>> default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
>> and kernel_mode_cpuslist files become visible in default resource group
>> and they contain "all online CPUs".
>>
>> option 2)
>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>> the resource group in "info/kernel_mode_assignment" is kept and all
>> CPUs PLZA state set to match it while also keeping the current
>> values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
>> files.
>>
>> I am leaning towards "option 1" to keep it consistent with a switch from
>> "inherit_ctrl_and_mon" and being deterministic about how a mode is started with
> 
> Yes. The "option 1" seems appropriate.
> 
>> a clean slate. What are your thoughts? What would be use case where a user would
>> want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
>> "global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?
> 
> 
> This is a bit tricky.
> 
> Currently, our requirement is to have a CTRL_MON group for
> global_assign_ctrl_inherit_mon_per_cpu. In this scenario, we use the
> group’s CLOSID for PLZA configuration, and RMID is not used (rmid_en
> = 0) when setting up PLZA.
> 
> Our requirement is also to have a CTRL_MON/MON group for
> global_assign_ctrl_assign_mon_per_cpu. In this case as well, the
> group’s CLOSID and RMID (rmid_en = 1)  both are used configure PLZA.

ah, right. Good catch.

> 
> Actually, we should not allow these changes from
> global_assign_ctrl_inherit_mon_per_cpu  to
> global_assign_ctrl_assign_mon_per_cpu or visa versa.

resctrl could allow it but as part of the switch it resets the "kernel mode group" to
be the default group every time? This would be the "option 1" above.

Reinette

