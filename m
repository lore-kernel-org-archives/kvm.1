Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEC4411FBE;
	Fri,  9 Oct 2026 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583212; cv=fail; b=dF9nnRbdo/PoJ1dcTirtCnegdLDJqqwzsTVLd8J7y1Phfh+9emjsidpJMh7gEB6GJng1Zrr22WrrHKkZCVtKIOtZ7FXGoisEX7WxoyTCxooEr+11Rvg3LQFno/5ALXJtLQAYvjG1grT8a5oxxZuQUMb7joSjTQpu2ga+H4+kZOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583212; c=relaxed/simple;
	bh=Iw07cnCGlJ1jT5AH/9erEFKfDKrzaJS7BE0deO03nS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BSVuovkbM09gpJpqFzpPPdk2Ru583iNqOAgB6fnY/Ih3/92mtkVnCHdaWR3E0u08jCxJIpLwvIEV9SldG0sQZBmnvtEdFcnwp6bNKtHTp4ulQVStHmt3OZJ0g3cs4QTemDID8i4UHVah1Pd0l1VK7z/cKoXs7rwzSUaXExabFX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnDbU3Sv; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnDbU3Sv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791583211; x=1823119211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Iw07cnCGlJ1jT5AH/9erEFKfDKrzaJS7BE0deO03nS4=;
  b=PnDbU3SvCN3AZG/sq1hBTy8TSaecYwedS8J6yrVdQIBZoNxyHgMiheTj
   AXB0gtcKqm/s496Ikd7nl5kyvRcMpES9KFMlhw2zlJoaHEapgFRDxVVDE
   suNGT2MwwhoNmoEhkSq3eKCi9dnA6nVyOrKRIwnDY5rVf8/GO/SHNGEBW
   Z2Z7WDvY4BQsp8KHJ61lX+UqrOOftot66hKq3VCffreipC20dMFf4NhKb
   yTn6HosSHnL48h3GLn1olOaAoAs7SUYMIt3ngNQVTMvXuwai/twIqNEgo
   WXtIbI9s8WWLiGC3M7HnIJorhvhYtjeWXy/H47WwNXZWw1nO0HlSsajjJ
   A==;
X-CSE-ConnectionGUID: CO+DNQZbRgyDxijW9+OZuQ==
X-CSE-MsgGUID: INxTWQA3SEucTJ0ePVMoPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="293517"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="293517"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:00:09 -0700
X-CSE-ConnectionGUID: IRlthzZdQcKAXZWrl8xd8w==
X-CSE-MsgGUID: vhggpFi5TFSSRV15IaKSCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2245846"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:00:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 15:00:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 15:00:08 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 15:00:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGUBpthou9TXzo3+R6Wo+itDIlMziDcRD1nvnEwWqXeWog6QSzX/1dkaRxdkDIh2ALuL737YdZTueNN48oIfEw0XI9DKZosuq7iwsjM0sEYfxjvpPLy6eTYrpK8AItBfL1W2s1lM832FGD803ZepVGVeMAEdCDEk8EuWA6wAvPA0pfk8m/gnvYNYoYu81K7KClT72x0oNFtl0+7WoCdADF0mM85SY2KMF9l+lJvWMONWwYxj3q2xVAiUC3KmvKrYxKAMHPxnNpWkC4ahOWQj4xukEAdmY+nRiZzESehsQ0sLgPYxkqe3wRY8JAFoy/id2QwurC81JLE2vlLKJEh2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw07cnCGlJ1jT5AH/9erEFKfDKrzaJS7BE0deO03nS4=;
 b=CYyCWRjDvxwD+awVYXWzG4FLd58LiMKh8yzZMNWFUd5An6CJcECg42gM+7Wu8z0GQ/s3BcS6a6on1bSjx3s4sjuRhWLaGM3S9E2tjGMXVO2ToxmkndXGYMPJXseQYK1T+mPkHj4N2XYprlJz5gA/CsEaHU6DI/xE+Zd/0nOTq35xbb+cTMy6pdsCEG+qWHiaE3W7RQUgYqy/NgWVr2pRxaF0dX6xQol6rghTOFFCbj/gb8PdGYLpjZvc9D/0t9bMMKLg4woQY20Ic+GBobqn5vElabgI7izJ73PkPO4C2s58j/I+bzN5yZ+1JdHYZ25FTs2gHHnFl9cchLX8KB45Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ5PPF1170C8165.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::810) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 22:00:01 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 22:00:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 11/17] KVM: TDX: Honor the guest's accept level
 contained in an EPT violation
Thread-Topic: [PATCH v4 11/17] KVM: TDX: Honor the guest's accept level
 contained in an EPT violation
Thread-Index: AQHdTyluQiKEcSUnPEebL5+yF0G7rrby4+eAgAIgOoCAANCbAA==
Date: Fri, 9 Oct 2026 22:00:01 +0000
Message-ID: <83419a720277e370a2bb96f283272d8ad0adc3f9.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091116.15647-1-yan.y.zhao@intel.com>
	 <68f139713ee0adcca0d7a3d30e48a9c6cbc1f4d4.camel@intel.com>
	 <asi04xo+LJWmkkTt@yzhao56-desk.sh.intel.com>
In-Reply-To: <asi04xo+LJWmkkTt@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ5PPF1170C8165:EE_
x-ms-office365-filtering-correlation-id: a79b16e6-c8dc-43ef-af22-08df2650aa91
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|6133799003|3023799007|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 16Vo2fz9g6ekKOGyc5X35q13fqH2NIv/62QuMyLMILDYzQYklnFy3QMKodHthrxN7URF6mL6aTs6hAAGuiGcLYzkhrxwwsBwtlz42CDYIC5LAizHOrSq6haFLX+phoB0QYUy6KIqm0Pr63UvNK+kZiqmlRiY66868rnvWOrAib6DS4dM5y0ru2nrFH9Kkg6yGiS8i6nintPtla3YfLldf++I+LSKswAs+9Fw2I8HKC+VyN0j6RJ+iToNJQj4dc1WxQFkptK1qbWXN0rdPtoFf7HwnXplTl/C39b0fFC8ys0Xl+RznlhsBPsdcAUuGGLvuCuTSuchHhBTxCHSowdqt9mza8B7D7ddA/xfBLxsG08r2ru5g/uGTYRmw96l9RZm0g/wJQYmBjiSWopBZDzh0AQhVfInB9DWPRl0t7nNo/0FfUtWy5h3CEQyoE4SvUJY4szD0lVlto1CT7uFv4uVSQTDL4OCIYq3iguUpZktWjZl0GNw594awnlhVpW9HZEOmlsrtLdAKh3BDO6tUOdBZymboqmSBzU+Sl1dSdLCWYIhnH+0NJO+CS7eCMz7XUaGC56e8Wo1GicsELJbrUt5h+MXiyn3NyXRNnRJCdxMAkunbYw0eoUJsqXDqrtjpFRoyA8Od13yNU4M9RVuTPb2hlmf8PtAThhInx708OedQ34N7QOehXQFjhFNuVpu/yZMgFKJJBdcnxtbL03DvA+UYqc3ot6j5toWxzYPtbNt6Y8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmF0UlJqMkNPRFY0NlZaWlpyaXhFWDBxQXpRcC9IVnJ1Z1VJcUg1L3NWQlVw?=
 =?utf-8?B?bTBPV1I0SGwvcVBsUG93ZUVjK0NvbERWVXZBWkZQTCtsWnZlajdheWR0SDJ1?=
 =?utf-8?B?SHN4WklBOXhMUU5kdytaOHkzVnhxYXord2E2MWJvTTIzVGZkUUdOT24xQ2dJ?=
 =?utf-8?B?bDBuVW84a0tNbVZ4NE1rNlR1UWVIM2xoMWxjNzhQMUhKMFFiKysyK2RhTEZj?=
 =?utf-8?B?ZXlLZmJNWVY2STJZeHZIZ0k1MFRuSXJ5UXFtWDUyOXF4c2d2eGhRdmI1S0pv?=
 =?utf-8?B?YngxRG1iK0xoVUJ4THFpa0I0TWI3SWF3VzRqYzNlSEJTcEFtSVNlOVBpU0dC?=
 =?utf-8?B?Sk5mR3dQdllHbmMvNkN2V2NMNkhUNUFSQWdObXJHQm1TK0VJV0dJTXU4WW9B?=
 =?utf-8?B?M3ZTQWh5M1FDa1FVQTRQeDczdk04ZElwdytrTk5Pc0FsWGM2NzlJdVVyUm5R?=
 =?utf-8?B?ZUU2V2VaNEhJNFpBUDZqMXpJZEtPSjBHek1DS1V0SFY0bzEyV25vWkE0TXdB?=
 =?utf-8?B?UStEOGRLc2YvSFlrQzZ6SzRVandKaURhR2FFaVdaUWl6eFRsSy9iazYxS1Vp?=
 =?utf-8?B?Y2NXNy9zOStkVUZ0aDhMVmxZS0lkdkwvM3R0K0N1SDFtNWQ5MGNjdTNyT1pi?=
 =?utf-8?B?RFJlVjRlWWdiVkNLamw5VXgzcXl0WWZRK21XSTNVTFRVWkkwbUsrZHdiVjRN?=
 =?utf-8?B?S1BhRFpnYVFLT1hUY1RFcnNtRGRISi9ydnRqbXZJaC9VbThvOWJvTkxjdnNL?=
 =?utf-8?B?V3dZVzBRckpQWnBvaW1NMUIrMTc5em02L0ZJS0pGcDdJMzh0bkNaMzMrdTdj?=
 =?utf-8?B?Mkx5Z2NuVXlaczlwQklrUldiOEZ3THRrMnZoU3djNXdtQXBNRlZZVThudjlP?=
 =?utf-8?B?bUoxUUZ6b2V2TzJDcE8xb2JQbU5yMWowVCtMdHp1NlE1QzB5RmNWQjBqN0J0?=
 =?utf-8?B?Tnl1dXVONFhiZGk0N0dnamplRjlTWWJIMlFvcm9XS0VoOVY1Qktvd2xaTHQ3?=
 =?utf-8?B?UlQ5Z1UvditpODR1SzRidWZuVWtRNFNhcW9ENkR1VWk0NGNiK0ZkS3VlakNY?=
 =?utf-8?B?blpxUTc3SWw1S2FhamVTR0tDUUJlT21yajhIMmlCSE9DK2Q5R3owbGREWHVw?=
 =?utf-8?B?bnQyaGVqWmtJN01VcFgrTGtmOXpSZG1EWVliVVlQYngzMEczb0UxUWt5aFhL?=
 =?utf-8?B?aHlmSzl4SGlrdGN5K2dGdGYxQktPZlFWVW9yUTBZV2I1R3l0Q0o0RU9PM2N6?=
 =?utf-8?B?dHR0ekZLVVdaQkVUMjgxRzVUNHBMOFdVbGtwYVppbXR5dHJFaWl5ZDZKQnBy?=
 =?utf-8?B?UUNZcmQwdmw2SjZIb0ZpdnBJMmtEZ0c1ZExSMzZuOXZLTnVmUTJPSDh1NXhq?=
 =?utf-8?B?Q1ZhWE82MG9haUM1a2c2Mmg4c1BVL2Z6QktUR3I3eU4yYjk4MkFJOHZxRzcy?=
 =?utf-8?B?NURqdWE3bGRDZERYc0NpNkZjWks4eFdabEhoMkYvS2p6NlRHamF2M0NsSytG?=
 =?utf-8?B?eldIZnpJaDRhQnRWOXdZL3hNZWVubmdnSGE2dU1FUDZPdWI4VFdJNHpZdGtp?=
 =?utf-8?B?SG5PcEh4QnlpQ0RHZ1RmMmlpUExyQWVDYVdkZ0E5R3U1cFdjeUtRNGV6SnB2?=
 =?utf-8?B?UWhkTHpYc25NSUxOZkhwTk1Nd3BoUWlvZTZNUWFYNGRiZ3cyQUtSWXRzek0r?=
 =?utf-8?B?c29NNlZia0ZtaHhqZzYvVUhieGt6Qkw0TFVvNHZMU1NBaXV3d0h2RzRUWG5I?=
 =?utf-8?B?Ky90MFR2ZVIzQjI4V2FuM1Z6TVNuams4eVUrSGVwcnJwWFVqMkEyOXh5TEVT?=
 =?utf-8?B?eDdFaWFQcEZzQ0tHeFVTZ1k4bEJkdTlEZTV1dEF4VkU2eW1weEZCTVJtSkpI?=
 =?utf-8?B?elAzSDVudkIycHlibXkySDNMY0lzaFgzUVBFL0VSTUJOOVcrR01xQzFwek5R?=
 =?utf-8?B?UGlRa2R0V1U1bEMvTFlhamhIOEs1UGphNGtYMWROS24vNUdwcG9na3ZqcUVR?=
 =?utf-8?B?QUpseTlHRFp0dXN5Y1liT2tMNklNTUpqRFBMempvL1ZORlFCTGpjOXdxVDZX?=
 =?utf-8?B?ZGZ6MFdmRXBaUUZDVjJTcWhWdEtlL2FPWEhVSDlzenArZi9UUnNleisxN0Fs?=
 =?utf-8?B?aFcwc2FZdUtBSkFmdjgwZ2hZL3hQQ05zYysyTS93QjI5Q2NNdk9xaHNJbk04?=
 =?utf-8?B?TWJpMXdpWi9uS0dLV1V4NVF1V0kvd2QrSk1HM05Lc1UzaGpWQ3pFdStYYW9n?=
 =?utf-8?B?Y24zUDBVZkM2Y1F1T2p5VTRyQ1pRRk0vNCtXVFpUSUROQzRTeVUvemFXMWVX?=
 =?utf-8?B?czVyaldJVlhTck03RCt4Zm1hZVplMzQ3NWUwRzFJeVVWR1dIaTJlKzcwQ0Fl?=
 =?utf-8?Q?Ov+zC/PxWVatOObQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5E1EF76FB9B8C4BAD466AF59D9F11D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c0U6lnlwPAxZui/BgVQxwTUzvIP/ZmfNEAehpD/Zo814H98zg3lH/zBBcfoR5vK2X7aazk/W8xxc01IsO8JJN+N+2ZSt2a9I96Zs0fjxlkUJQ4Jh1Lv0etEMAqsV78jjuvWpoDwzYS7RWEDDXm7c/yrv1Mcw3JRUT1cdWF3G+kWRp8+XOxFcYR7IZl/aJeW8BX6pTHVehC2vNbU4E52FCgi9foqiEzHCk/O4sIHfMBFS33kYNQpNH54NvAsKBiGYwXPwHuIenXpd5xZNOLMkIkUYrVTwNte0Hm4T+TNw7d/mJiXZY9+hCuIXZMKzqXeXX2tZh9YYPXKxhApQSgkIaw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79b16e6-c8dc-43ef-af22-08df2650aa91
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 22:00:01.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdvKsr3uWC9ZI/MsltMKTAgVMoyTDUDD2GyoAukXmHijSy+5HuszWRIB3SLOdEZbgxCQ0Qgd1RHxruYryDGYfXRBbtmFNIO/8LTMnyftquM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1170C8165
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTA5IGF0IDE3OjMzICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
VGh1LCBPY3QgMDgsIDIwMjYgYXQgMDk6MDU6MzJBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjExICswODAwLCBZYW4gWmhhbyB3
cm90ZToNCj4gPiANCj4gPiA+ICsNCj4gPiA+ICsJLyoNCj4gPiA+ICsJICogTm8gVExCIGZsdXNo
IGlzIHJlcXVpcmVkLCBhcyB0aGUgIkJMT0NLICsgVFJBQ0sgKyBraWNrIG9mZiB2Q1BVcyINCj4g
PiA+ICsJICogc2VxdWVuY2UgcmVxdWlyZWQgYnkgdGhlIFREWC1Nb2R1bGUgaW5jbHVkZXMgYSBU
TEIgZmx1c2guDQo+ID4gPiArCSAqLw0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIFRMQiBmbHVzaCBp
cyBhY3R1YWxseSBtb3JlIG9idmlvdXMgdGhhbiB0aGUgbGV2ZWwgKyAxLzIgYml0cyBiZWxvdy4N
Cj4gPiBJdCBpcyB3b3JyaWVkIGFib3V0IGluaGliaXRpbmcgMUdCIG1hcHBpbmdzLCB3aHk/DQo+
IEhtbSwgaW5jbHVkaW5nIGluaGliaXRpbmcgMUdCIG1hcHBpbmdzIGNhbiBtYWtlIHRoZSBsb2dp
YyBtb3JlIGdlbmVyaWMgYW5kIG1vcmUNCj4gY29ycmVjdCBpbiBjb25jZXB0LiBUaGF0IGlzLCB3
aGVuIHRoZSBndWVzdCBhY2NlcHQgbGV2ZWwgaXMgMk1CLCAxR0IgbWFwcGluZ3MNCj4gc2hvdWxk
IGJlIGluaGliaXRlZCBjb25jZXB0dWFsbHkuIFRoaXMgaGVscCByZW1vdmUgdGhlIGNvZGUgZGVw
ZW5kZW5jeSBvbiB0aGUNCj4gYXNzdW1wdGlvbiB0aGF0IDFHQiBtYXBwaW5ncyBhcmUgaW1wb3Nz
aWJsZSB3aXRoIHRoZSBpbml0aWFsIGltcGxlbWVudGF0aW9uLA0KPiBnaXZlbiB0aGF0IGluaGli
aXRpbmcgMUdCIG1hcHBpbmdzIGFzIHdlbGwgaXMgc2ltcGxlLg0KDQpJIHN0cm9uZ2x5IHRoaW5r
IHRoZSBjb2RlIG9yIGNvbW1lbnRzIHNob3VsZCBub3QgcHJlcCBmb3IgMUdCIFMtRVBUIHBhZ2Vz
IG9yDQpwcm9tb3Rpb24uIFdhcm5pbmcgaWYgMUdCIFMtRVBUIHBhZ2VzIGlzIHRyaWVkIGlzIGdv
b2QuIEJ1dCBJIGRvbid0IHNlZSBob3cNCnNpbGVudGx5IGhhbmRsaW5nIHRoaXMgcGFydGljdWxh
ciBjb3JuZXIgb2YgaHVnZSBwYWdlcyBoZWxwcyBhbnl0aGluZy4NCg0KSWYvd2hlbiB3ZSBnZXQg
dG8gMUdCIG1hcHBpbmdzIHRoZSBjb2RlIGNvdWxkIGhhdmUgZXZvbHZlZCBhdCB0aGF0IHBvaW50
LiBTbw0KaW50cm9kdWNpbmcgY29kZSBvciBjb21tZW50cyBub3cgd2lsbCBhZGQgY29uc3RyYWlu
dHMgb24gb3RoZXIgd29yayB0aGF0IGlzDQpkb25lLiBXZSBkb24ndCB3YW50IHRvIHRoaW5rIGFi
b3V0IGl0Lg0KDQo+IA0KPiA+ID4gKwlodWdlcGFnZV9zZXRfZ3Vlc3RfaW5oaWJpdChzbG90LCBn
Zm4sIGxldmVsICsgMSk7DQo+ID4gPiArCWlmIChsZXZlbCA9PSBQR19MRVZFTF80SykNCj4gPiA+
ICsJCWh1Z2VwYWdlX3NldF9ndWVzdF9pbmhpYml0KHNsb3QsIGdmbiwgbGV2ZWwgKyAyKTsNCj4g
PiA+ICsNCj4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiBJZiB5b3UgaGF2
ZSBhIHN0cm9uZyBvcGluaW9uIHRvIGRyb3AgaW5oaWJpdGluZyAxR0IgbWFwcGluZ3MgZm9yIG5v
dywgSSBjYW4gYWRkDQo+IHRoZSBmb2xsb3dpbmcgZGlmZjoNCj4gDQo+IEBAIC0yMTgzLDcgKzIx
NzIsMTMgQEAgc3RhdGljIGludCB0ZHhfaGFuZGxlX2d1ZXN0X2FjY2VwdF9lcHRfdmlvbGF0aW9u
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2YNCj4gICAgICAgICAgICAgICAgIHJldHVy
biAwOw0KPiANCj4gICAgICAgICBsZXZlbCA9IHRkeF9nZXRfZXB0X3Zpb2xhdGlvbl9sZXZlbCh2
Y3B1KTsNCj4gLSAgICAgICBpZiAobGV2ZWwgPiBQR19MRVZFTF8yTSkNCj4gKyAgICAgICBLVk1f
QlVHX09OKGxldmVsICE9IFBHX0xFVkVMXzJNICYmIGxldmVsICE9IFBHX0xFVkVMXzRLLCBrdm0p
Ow0KPiArDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBObyBuZWVkIHRvIGluaGliaXQgMUdC
IG1hcHBpbmdzIHNpbmNlIHRoZXkgYXJlIHVuc3VwcG9ydGVkIHdpdGgNCj4gKyAgICAgICAgKiB0
aGUgaW5pdGlhbCBodWdlIHBhZ2UgaW1wbGVtZW50YXRpb24uDQoNClRoaXMgYWxzbyBpbXBsaWVz
IDFHQiBpcyBjb21pbmcuLi4NCg0KPiArICAgICAgICAqLw0KPiArICAgICAgIGlmIChsZXZlbCA9
PSBQR19MRVZFTF8yTSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiANCj4gICAgICAg
ICBpZiAoaHVnZXBhZ2VfdGVzdF9ndWVzdF9pbmhpYml0KHNsb3QsIGdmbiwgbGV2ZWwgKyAxKSkN
Cj4gQEAgLTIyMDMsOCArMjE5OCw2IEBAIHN0YXRpYyBpbnQgdGR4X2hhbmRsZV9ndWVzdF9hY2Nl
cHRfZXB0X3Zpb2xhdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdmbl90IGdmDQo+ICAgICAg
ICAgICogc2VxdWVuY2UgcmVxdWlyZWQgYnkgdGhlIFREWC1Nb2R1bGUgaW5jbHVkZXMgYSBUTEIg
Zmx1c2guDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgaHVnZXBhZ2Vfc2V0X2d1ZXN0X2luaGli
aXQoc2xvdCwgZ2ZuLCBsZXZlbCArIDEpOw0KPiAtICAgICAgIGlmIChsZXZlbCA9PSBQR19MRVZF
TF80SykNCj4gLSAgICAgICAgICAgICAgIGh1Z2VwYWdlX3NldF9ndWVzdF9pbmhpYml0KHNsb3Qs
IGdmbiwgbGV2ZWwgKyAyKTsNCj4gDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+IA0KDQpU
aGVyZSBhcmUgYSBsb3Qgb2YgcG9zc2libGUgdGhpbmdzIHRoYXQgYXJlIG5vdCBoYW5kbGVkIGlm
IGEgMUdCIG1hcHBpbmcgc25lYWtzDQp0aHJvdWdoLg0KDQpXaHkgbm90IEtWTV9CVUdfT04oKSBp
ZiBzb21ldGhpbmcgdHJpZXMgdG8gbWFwIDFHQiBpbiB0aGUgYXBwcm9wcmlhdGUNCnRkeF9zZXB0
X3NldF9wcml2YXRlX3NwdGUoKSBzdWIgZnVuY3Rpb25zLiB0ZHhfc2VwdF9zcGxpdF9sZWFmX3Nw
dGUoKSBzaG91bGQgYmUNCmNvdmVyZWQgYWxyZWFkeSwgYnV0IG5vdCB0ZHhfc2VwdF9tYXBfbGVh
Zl9zcHRlKCkgbG9va3MgbGlrZS4NCg0KDQo=
