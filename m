Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD33E3D92;
	Thu,  3 Sep 2026 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462571; cv=fail; b=mz+kMnurx9P9tnVyjusxQ3UUMsPg6juGUuMMUkqidntXjeVtwkVLXVVYXn/8dITH+uO3D23PPi5B96TX4fihlsr2o3wtzR+fCUezczhtm7j1QJxZacvTlB5YRu4hZhBEp3U/eqV4SyOt6kv99cPG7We1KLvL+gvQG+stkzLN4Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462571; c=relaxed/simple;
	bh=beQuc6e3BcQ0a3KdqBisLTfPQm7bPD8xQQAKJ2LW0lc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kwKitxNpQlIUDaKvQESdZW/wFpDjv9FZXs3CrtsyHuXscabMs25cz+iAbcEf5olIv5eokKhHhGxCFlamxCN513tNWKEyIOVQ68dsiTydvCuxNW5eexLuuvS1uN1kMw4YbCmIyZQ2wdr+L+3woq6BOS/fT/z4yuhAb6PZDithNww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eq5Uo0CI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eq5Uo0CI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788462560; x=1819998560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=beQuc6e3BcQ0a3KdqBisLTfPQm7bPD8xQQAKJ2LW0lc=;
  b=Eq5Uo0CIqqPAmGu71ilibKTx37v5mTPFS4iSgJGOe9IQqR2NVaqAUrTo
   2p5Q3un38zL0uVatAIl3w/dqoxE9v7rnXVlnV0qRHXIIaXtp+fzP77osx
   NuEuIobkRYHLxv1gZEizYE8u8ksOa9cGWckoKxJlN9H9DjI+QahlehP9d
   k5NcEuQFwqBPxROgz1d0qs7hBjxDb1HpX/h52RYwpTOzkLkR5vkHANrrX
   c1dP2hKSKHOmN0Nkls4Vg76KUw2/Ul6CEEyzJom/qnbpnNUkzbP+F6Zv7
   9FxlTbSrtF9DaoFEJEq1hAXFzkNzVXLh25doAE6P5sTvmsJBwh+Ck2lzv
   g==;
X-CSE-ConnectionGUID: 3WPdEVe4R9KWwuMc3/JHcA==
X-CSE-MsgGUID: L6MyPQPIQiGS2EwEUpWOaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76509341"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="76509341"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 12:09:12 -0700
X-CSE-ConnectionGUID: kGD35HmGS2O4ji1BSn0QHw==
X-CSE-MsgGUID: 5zjNlRg0TWeeZhaLDNrl1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="299673321"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 12:09:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 12:09:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 12:09:12 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 12:09:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pj/qpezucdqrjXybifqv0pttBGZlYcGxNbiubdlsJjONdn/j1zEMQHO7r/EfDEIgWz5nDpuSoFPqOUEs4bSTEd3xXFyYUrkoRx3JNVk5UK7cvW86PGLeEobZlvhH3Wi0dktbThfzzWzU6D6X1sLYgLfUGHRoFnJ6YgN/mauZcTRj9flx9C5ocB3diyWkbYS+OMXkZhP7ifidPZVVYJuKITQpGFVZQfAM0trS3RdRHQO7cpNZI0ytVcfXoeeLtEdlK8le+qqXXBik0Eu+FwNf9pzHcs85b9km0bYncfY0T6fkSZlTUAZozFB6blNsmSefi7DGriXolgj0hQPXCof1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14SynFb4ZNInwC/bsvlQg2W8iHOBJfVAjho14NHl/Ck=;
 b=O4vpqYJtsRqG+QK29nL3GK5fd26WUnyfanIXuPSg8cFXqcyik1AeD405WB4pEQxZITzrLzLfOTGmEoFJVHjXW2MTDoA2AXDn/sZMP4UKiHaKoGayUQ5ZXyiCP9rV2UQCUa+J+dFFbD2s2dYkyIrue0YSsu3f9qruzD5Ir3nne42tuaftvBF+rYXYkHMHfJvx6Zs9ZJgVWFkm51w5ipAc/G8hblE2nXPs/OvHvIl8M6o9jNXfHtrwxXjJsryCyrDxQ7STo6hdBRxsdFjjE7Oyq8IBmvchDwS2r12u4c0IySSXyd8xTYlcjLZ7Ky2kEzOSlo2TTYd8py2ZBvwmRW/wXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS0PR11MB7787.namprd11.prod.outlook.com (2603:10b6:8:de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 19:09:08 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 19:09:08 +0000
Message-ID: <963e526f-0abf-4f8e-ad17-aa03809ea558@intel.com>
Date: Thu, 3 Sep 2026 12:09:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/26] KVM: nVMX: Enable support for secondary VM exit
 controls
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
CC: Emily Ehlert <ehemily@amazon.de>, <xin@zytor.com>,
	<andrew.cooper3@citrix.com>, <bp@alien8.de>, <chao.gao@intel.com>,
	<corbet@lwn.net>, <dave.hansen@linux.intel.com>, <hch@infradead.org>,
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luto@kernel.org>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<x86@kernel.org>, <nh-open-source@amazon.com>
References: <20251026201911.505204-19-xin@zytor.com>
 <20260902142336.9955-1-ehemily@amazon.de>
 <649c7d7a-f042-4fe2-a3e8-eb15e4d76a46@intel.com>
 <apiL1WmN3j4ceDHI@google.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <apiL1WmN3j4ceDHI@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::23) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS0PR11MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b0fe60-425f-4dca-452f-08df09eed452
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: noCCi72N/tiMgjThmnYjmwO8nvRw1gUZB4ZGfTcPIUh1CeEM/O/DdqMiIHQZCxUmnUbSeQwVnkCgQ7ukGO7c1a0/Kmf/7GEA0DmxnMwKp7ATmWaXkPbUggMOqvj3XO5Z6HCUDMEbpiNVULbi4bi+/1PzDSk32F1Zv8EAX3sQbOl5hiUoYqQFaYBYrb+EtLBanYV1Wf651SLE/WkXjEhAGiE+RO+D3LpPr+uODtjdwI2ajezNgpflEo+HRqYUuZjNM9UiS9tyTW40IOM7d0Vo59g2fk0e4Z/qbYhXzJjuV1L2ydL33nKKD6d0TiUinoynkgON03nzO3sG4TGuNaciOtZNnrvbZhs5LLUk2LLga6nxbPDxhRnKi8K5z4hXhTdz6JCArzvDrbXgWvn/eOzHgxJQ/dPnWltisaG/d/dPX/uly/XyG5MTPxhK4mb9+nldmfkW4pjc3wnjguj+sEOn/4qzCXH8ILqQ4uXgpjIDCNthTJZL0f97YLA266HaFUnrNzOxK1EdaaOd3PydYWvEMiuH1MUVRJ6gADaBex7/Bfdct3W/YneOp1Rs1/El1nRNnUlPyi1rmMAJc1xG9vru3Ul531Y5Rhc50V7OTJspXbGODTj7GgV/1P9yYZ1NMOhBadxdyPmna9K7g7QTthpS+E2Q0q3U5fNpPzrIlsalU8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBpRnRZejU5U1hndTZHRVJVSlB4K2JDTmV5SlFVRVMzNXdWYWhYTGFYVnZk?=
 =?utf-8?B?WnNjdWtOTms1OGhMTlQ0ODVFVmI1M011ZU5RdmhPYXBBemhCQ01oM0Jseitx?=
 =?utf-8?B?MExzQUp4aVloSGE0bGdpZlRUcFY3NHg4aCtYSEhtRFI4MHoxaUs1NzhndVk2?=
 =?utf-8?B?aXNqUWl0Sm9aajJtRGJ2dnk1UmVKVmNZQ0xpbHArbWh0Yy9sZ1BYTW9yMitn?=
 =?utf-8?B?YklKK3RoKzhtT2NFM3VuNW9lSzBVZ1pmUWRqc2UzSm1ENkp1STloS3E3VmtL?=
 =?utf-8?B?VE42VDZnYzVrbHBlTzFwTVBpSzdEOHgyblBjbEFNQU5lb2ppSUNsYzJYUnJr?=
 =?utf-8?B?YVQrQUpmOEtXZjZOWmw0cHEvVXN5RmtzS2ZSTE9xTzNYa3cySFk3MjVKTmNL?=
 =?utf-8?B?WWdCdVpxbFBPeCtKdGxCQkgxZkdIWUVxL1UzaUowK0o3YlNWRUc1aE9UN05P?=
 =?utf-8?B?OEh4RW1aUjZNRWhNWlB5SVE0ZFJIYzhXS0JOdVJVRXhvZlB6RTJicFVhMnRn?=
 =?utf-8?B?YUQzWFpXa2FJb0lpUkEwajRDaTVzenE0emptdzJEMkZMRVF5OVJ1Nmg1ZXVI?=
 =?utf-8?B?T0ZORENrbTNsTW9yNTBaUU5aaW4yeWlMbXFod3YrNUkzcmR1MER5T0xYdTV5?=
 =?utf-8?B?bG9FWmh2TVhwK2dPd05qUkhlWGlWaER4K3NGa1hOenh0R2c4cFRXMTExTlFK?=
 =?utf-8?B?S3puTlBKK1drYjg2M1JrU2grUjZ5MXJGdnQrdHM2UExhQXNyd05nd3hhamUw?=
 =?utf-8?B?N2xvVHp6elQ0bDR2V0paeENvbVk1eFlnNXE3d3pucWtSdXpnb3V1Y3RCZ0RS?=
 =?utf-8?B?MG1DcVpqYkJpcHpQMVZ6cDRqb00rVHpYdXIreEtydUtQTkZucFAxellpcjA3?=
 =?utf-8?B?Ymw1eXg2azcrbjZ2MitBK2Z5K0FVV2pNc2RGWkMrcmM0MHlTWlNoTVJPZmE1?=
 =?utf-8?B?cWpjZWVEbWk3R1BrSUo2bEMraFRPQTl0Tnh6T09DUUVwejFLeG1XQWpCRGZp?=
 =?utf-8?B?QzV1bXdmVTMrZFgyWnVhZ1IwRFFJaXlJbUp4OXFEZHU2V1I5MnZLSDhEYXZ3?=
 =?utf-8?B?Z3lTWlRjdm5xYkQwTFFTU0tkdXNsaW9YQUpKdUc5TTRFNmFzcWpUVHlFa0RF?=
 =?utf-8?B?YVJURnBoUVZvSWZzMEppQjVXRFBiQnZPc2ZoQlBXaHlHTG5uV0tsTlROTWow?=
 =?utf-8?B?L2NDd3NZQmU3ckVCQ3ArdUxlZU5BT3E0aHJ3QlJEOTY0SkNGMlFqUEo2OU9Z?=
 =?utf-8?B?NHJpK1ZYVjZLa1RpN2JFRHJOcHRINDZlS0xScUIyM2treWdjR0VRSWJHc3Bo?=
 =?utf-8?B?SHdKaXZFc3IvaE9FNmZwTTFHcUc3Y1g5TFBjb3RrVld2WGJ5Qm9CaXh6VzV6?=
 =?utf-8?B?ZWpRenZtTFhHcEIvNTQ1NXdheDE3eUx3NVZTZXorSXhraTNTZTU5S3VkU3JY?=
 =?utf-8?B?TXA4K0F1NUpCR3Y4QzNBNjM3WWhSMHZBVXlnT2RxY2huWlN0Yk96WFcvTGor?=
 =?utf-8?B?b0ZUNngwMW1PTCt2ZkRnY1dld0xLL2pkdlpwdUJVeFFoMnJDb2dMNzRBSHZR?=
 =?utf-8?B?OXgxSk02allwV0ZZdnhERWZqWVBLU1hpZG9iZzZGeHdTeDk2VS9YSEh6Y2dN?=
 =?utf-8?B?L2x2K2VEZWh1aDRqQk15YkNyMFo0eE45QVhMNlBXbUdsajIxQXJ1d2lUa2I1?=
 =?utf-8?B?VmY2blpoTFJLU0MrZ3FDcytPTnk4b2h1aGorSTlyYWh5THdjOXdnVitsSFpM?=
 =?utf-8?B?bmhpUTl4NHFBWmtYdVZ4T3JoOGpJMjNTWFNjYXorTGdDaWluNDh6UVhmQ0ZG?=
 =?utf-8?B?aXZPVjFxQmxuKy9iYjUySFp1UXplY01TVjU1MFNxbVEzbS8wenlyT2l5eWsx?=
 =?utf-8?B?Tyszc2JDMFZhaXZ3bTM2UFNrSDhUaG5BSnVlek05MGZpeU1TcS9ENExwcTZD?=
 =?utf-8?B?Q0M2U01OUGdHTFRSYVpMSWsvRUczSU1sLzY5YWJGVTFPckxkMVNMaTlrYXNi?=
 =?utf-8?B?M2ZvY1lrUGdJQ3FKc2tpZTdMVnJ4N21LbWNpSndNN3V4bCtxV2Y0TGFjZUlB?=
 =?utf-8?B?RlZUVXFJRHVZZk1zeVYzOWtzZGZRSkJ4OFF6SVVHOUJHV0gyTUtpUFoySDNW?=
 =?utf-8?B?RDI1dy9rcUdxNHMrYUdncStxZDkrcmxzeHFRby9SOWg5ZnhoTE5OSThjTWZM?=
 =?utf-8?B?T1ZsUXVoeXRidDc2UGFCQlVZK01JYUpVTUt4UG1xTUxXcmRFczVucklLRXB1?=
 =?utf-8?B?QStsNUZxWVIyeDNlQ1lvbWlXb21UZ3pjWjFQa3ZNdTQ1YmJ2cncvSm1XSmVk?=
 =?utf-8?B?T0NTQjJjSlN6Qy9SS0RzZjBsVWFCVi9jdzZOeWVTbCsxVXpjUTBMdz09?=
X-Exchange-RoutingPolicyChecked: iXTPtXTz8KEqivVXxTYT9gIM8MrwWbI5PZnY+STEVEVfoofpgKFleABNvj5VmRuvJfdvXgb2w6vMfK3ABac5J4zYpKtZdVofsd+HzawVjrPBx4m2ovWm5ZkxfS+93X+cEVuWUx9f87q2XmcBltDCqpKvCagPxNggSof6o3U+5Ko0/Hfvj+MobWAP9wuiirx4Q5SDcXSjH2+QUVH7gbaLYlWpggq+5gPiw3Z1GeeL0GYpVWVcvZzDqEyWwbERU6kxESvFnEqz7BB18GNxPmDS71jm/iGhM7NIMl6MyC4vZ5jFEGggA94hKG4k2tIhe6nbyBNdo4FLwnqSi+OOQsbPow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b0fe60-425f-4dca-452f-08df09eed452
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 19:09:08.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0MO4CojwihAfDu6natQWhVFw/w91hnavoWGyCGHyeHkgYRomZ7g/WtkJyl1PAIysDJb57PEdIP6P0yhLDRHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7787
X-OriginatorOrg: intel.com

On 9/2/2026 1:49 PM, Sean Christopherson wrote:

> Normally I want MSR accesses to have the same fault semantics for userspace and
> guest accesses, but for the VMX MSRs, I think we should let userspace read at all
> times since they're feature MSRs.  E.g. I don't want to end up in a state where
> userspace can't read an MSR because it restored/set MSRs in the "wrong" order.
> 

Thanks Sean for the clarification.

> We could plumb in @host_initiated to vmx_get_vmx_msr(), but I think I would rather
> add the check in vmx_get_msr().  E.g. shoot for something like:
> 

Happy to not be the bottleneck here since this is FRED independent.
Emily, do you want to pursue this given that you reported the original
issue?

If not, I can probably take a look after I send the FRED patches out. I
am sure Sashiko will report other such pre-existing stuff based on the
FRED patchset :)

> diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
> index 504630f0eb40..a99cebfe50e0 100644
> --- arch/x86/kvm/vmx/vmx.c
> +++ arch/x86/kvm/vmx/vmx.c
> @@ -2200,6 +2200,10 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>         case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
>                 if (!guest_cpu_cap_has(vcpu, X86_FEATURE_VMX))
>                         return 1;
> +               if (!msr_info->host_initiated &&
> +                   !guest_cpu_has_vmx_msr(msr_info->index))
> +                       return 1;
> +
>                 if (vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
>                                     &msr_info->data))
>                         return 1;
> 
> 
> That'll require yet another switch(), but reading these MSRs should never be a
> hot path.
> 
