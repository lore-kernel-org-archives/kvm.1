Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEBA3A59A8;
	Tue, 15 Sep 2026 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442214; cv=fail; b=j0fz0kQlsSA/iTU4Rtq4ZP4kNHPKzFskoFSBA/63+30OLfLye/jruZ5Gw3ktuO3wg/YBVhZOkfP7Upr6pA5RxXmqBfLAVVtnowlL5Lg3KJIRtA6SutuUGEFDZxUrnZYpnI19Sf3k2MfuyVMWkIKy908Fuatb9CrCqX7SiJgdRDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442214; c=relaxed/simple;
	bh=d6JBfI7Skf+6DJY9vZ18DDZTcFvcAoTgWz6BqqiFKw4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ft+jr3EPwDj8FA7fCFdrsM76r2rYbOa50DuOX4j12zV/EugcObERavD0Ej57AfzXn1KLeHO616o4bo4bwWGlBLrNW6LAkueJGQr9tTaiger1hy/cIMpZ6BsqCzxqxlj+4PEsgT26M1S6fewKaH46QA7TV1SVZpUi93rpDFBysYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLpUgnny; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLpUgnny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789442213; x=1820978213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d6JBfI7Skf+6DJY9vZ18DDZTcFvcAoTgWz6BqqiFKw4=;
  b=NLpUgnnymm0XiIebXuwZSR6/OwVJLh1iwL7cbqwJw8HY4c9Xr6yTZxui
   Iae/CC7XR7kDlu3Z28jbeiabSRhr/dycgoQUfVAL1hHnJkkG48rzPUX9D
   RfU2EDj49ViOCWmIZ/7DZgq2es9cRutBABtXeGnJu0TY7VknXOM4WSN7r
   abq0IhQgIWis3AAEyf6RCrdn1Fv4zn/nDcYt+0ALVM0q2wddzj5F5SywD
   nM9ivypAyyKp9g/qBD8hnuIZeZRBpNKROy1IjIbS8mMKdzGgyzB5R+V4i
   UtczVwRZmXBN0m1qGAI0IRyjkq4b9S2Z8wUcyFZTOnbbV1xqITlzh/zmS
   g==;
X-CSE-ConnectionGUID: xXfzFzr4Tx6y+krZ0GiTSw==
X-CSE-MsgGUID: IyEn+lYdQGGsWxS+lHmTUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93497300"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93497300"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 20:16:53 -0700
X-CSE-ConnectionGUID: TzXIMW18S+SMFwvuGfIs+Q==
X-CSE-MsgGUID: V+xb5M3gQCWDeme2BgWMRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270188633"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 20:16:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 20:16:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 20:16:51 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.59)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 20:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tx0LjIknXrdNmpy+b+VSVcSU8R1B53zXUG3aaQuCjvJ876VHLGZx/E5TdhPZMKs2OuvxXhcQQLpLYSdd5WkhS9lOt0FxVopAZXfWtFmcKCtPwJt/5+FjB6bFzGCfhcK/b7lHjJ72bS2+yb1foMG5JVKAlz/gghVV3VEDpvQmJkpo7YFB9JGI/gDIuxeAEAt3vhXHbsHLgTgxPq+TK3JsIruEietSHUj1TuPRDn7SyF/3oJh+Mb/SiSPA8ELbjdguwUpuSOwaHisJqdU7WSkodvUD9g4/jTjGjBPQjO1lyEHMZefkXNpHaKn9ekMQWaCrd8nbJYpXA5ZttR+D+Xe5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47WLckmg0VNtxvd1q/qP2OKBAGk2rI1kSavX3xNF7eg=;
 b=w3N2HirG1ewaG22SBJ68VMyMradVi2YFwrUWsv24WleKVR1PdDT0fFNFynpDrL/IMxnP0HH70H5FCW5Z1tm41BXiz/5VxBptEcQ6jvmzwPotaXg5myxp8unQhekHx5B8pBBDJGAeTNsQwbMARkYRWPFiaxZymKDqDqX4u8nc3A4ebi8Jymtb0CcWQmAW53GyrZjager6dSXiHH1LqNfXuIg1GBqB7t6HodnWdEaeMovPR1jsmrQqVaaOs0C0Yy+RGSpmBaKvOR3tYg2vgmxiwwE1P5IjbCd/8s1+lNVA0sTgmhU3u0SKffQOhc+KT8qPYJQiiGm3+xaVge1DBjgfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5)
 by SJ2PR11MB7473.namprd11.prod.outlook.com (2603:10b6:a03:4d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:16:40 +0000
Received: from PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e]) by PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:16:39 +0000
Message-ID: <322574c3-8470-414b-a089-9d07f2c3a689@intel.com>
Date: Mon, 14 Sep 2026 20:16:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests/x86: Add a userspace test for LASS
 enforcement
Content-Language: en-US
To: "Chang S. Bae" <chang.seok.bae@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan
	<shuah@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Kai Huang <kai.huang@intel.com>, Fuad Tabba
	<fuad.tabba@linux.dev>, Chao Gao <chao.gao@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, David Matlack
	<dmatlack@google.com>, Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-8-sohil.mehta@intel.com>
 <2ae0a300-49eb-432f-8627-4c786c840755@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <2ae0a300-49eb-432f-8627-4c786c840755@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To PH7PR11MB6932.namprd11.prod.outlook.com
 (2603:10b6:510:207::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6932:EE_|SJ2PR11MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cbe476-0615-463c-e919-08df12d7c21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MyYiUw4wP4bBna2hCadseOYSLm15UHKumvxM5Nc1HbcqJ8GqIkavYo+zNntAWGW/Sf9sTM/GRr+YnBA4vpNOEhVfH5w6P3jwr2fZ98jNFQN1L1bmV+0fH0dDN6I4epd0XZBY4jLoa0wG4PGLl3V4NiQmR3qnLtcXiCg5J9Y4Fyso06tpoHBACsmHcdyNPnZCa3MZzBHzQEboz3CJwkYk4rwfjrIepTz3hHf+g6kHQB/gILuhtTaEZ/wwt++4X5LJ8uQrYqCxEalV0viuMK5J6zRn2bNVegShyZfqNVRkQHIchRA1TbkivlA0Thh46NB8c4J/PWPHW1EwSNpLPjK2IKTmkfhPqsC9wpeOIcQMCIeycjW0fMIWAykcwpsqfzMf8rCodpfHsJg3DFyCbCUqWVXQFrofI3uFDx0KKZW+Dz5Xgb2xrRHNsF5sJUnu0Iq97D8jbDt1Ece5bes+2gw31LnnfcZSogm7tYhJPBfNoyH/GXEVWvQaYX7rqz69XA3XiX9SdmzvcLK1kFyBDRZn+5ysy2Lv107AtriqEJPS7UbqoyexRRQHu7roweY+owp+sXy7t4WWwCeSN8XgeNVNt+BpwtsU90lWthJsnCBJyo3I3uhYI3kx+KDON3iM+MGXtXpgRkLA4zbwndMRPv6R/zOJ5rvuOqrHy30dRHHuqrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6932.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFFOWWxNb1I5MjZmNFdKOC8rVFBiU0Rla1lYTjhNZjJVaEt3L1hrZ1VudCs5?=
 =?utf-8?B?cGhIUUZTYWIycHpSaUVCK1VuSTVwVzdqckczdlFCZUFUdHA0UjZxenBUOVVw?=
 =?utf-8?B?S3RLNEN3T1NkU3dnZDdibVlEYUdVY1R4VUtYdWFic2NKMVZBeGVJU0R6eUhZ?=
 =?utf-8?B?aGtzQVcrTHhTSnRvNlMyUm40L0Q4MkJmNXo2Y1dkVlZabjN4T09BWjNkZ25N?=
 =?utf-8?B?N2YrMUI1Z2hSMVV6WHp1RnhvS3dkUFNYcHk0emhiaUZ1OFAydE4wZmVsZFRi?=
 =?utf-8?B?SGxid2dMbzl6WVBCVGpCSHJ3VklWbTBVODVGRmlJeVZndUxwMDNqRjVFSVBy?=
 =?utf-8?B?NXM0LzFoOTJtWWJ0d1REUWJDMnNERnk2ZE1YRXdOYTg1NUVyQUZtRzFxSzRy?=
 =?utf-8?B?ZTFnNndUZklmTG1ybEw0YjYza1FPbVlraDdMSkcvdHEzVlNSa3JGUTBYWk9u?=
 =?utf-8?B?cmwvTUo0WlZqM2gwS2MvTGwxWFpxekpQc0xqNFRTK1NRVnQyWlZ4TzBJMU80?=
 =?utf-8?B?aEk2SFZHSm93Y1MveEl5T3hHeCs0K3B3ek91Y0dDRzFLdXI4azh5Y0pReEg5?=
 =?utf-8?B?b254aWFkc1YyYlhaejJodTUrZWNoWXZjUzhEZWhjRnJyeGszZllMMGNsRmo3?=
 =?utf-8?B?MXhYOGJFaXByUFJEUk5oekJCdVlhZzA1akJHaytnTXZLS3VDV1ZibnVYSENz?=
 =?utf-8?B?dXptNXJyTFIrdmlaSVMxdDRlSWVyZ0sxVXVZTTBSUDZFQnZ0M3VIMGpZbWFN?=
 =?utf-8?B?L1lIQTVTZnJkcUNXWDlSN0pJZ0lrMGpJbDJpYWpGaTJJSk9QZ0J6VzF4TW8v?=
 =?utf-8?B?K0ZJZXVmc2hic1ZrVVRqV1MwaHRyd0JHTXpsNzVMNUpJdW5BRjB3blBGSXZm?=
 =?utf-8?B?Z0ZXd0FsOTJmSkdNUVNvRVJRM0s1UzlLbmxMajgwZWJxYnFOSFgveFpqT25E?=
 =?utf-8?B?YnRVNVJhNTlpSTFmK3RqL0t1Tk1LdVl1emQwck5LMFo0VjcyZmJqK1hQRWV4?=
 =?utf-8?B?SU04NCsrT0JlMGdLN3UxVjFvSUZub2cyWWdIc3A4bzBiaHA1bVdaZG1lanh0?=
 =?utf-8?B?dW9BM2RudHN4eWNxVzVMdUpsR0RYaHBENmxQZmtxMVVpRTZ5bzVtOTQzRFJa?=
 =?utf-8?B?VGU3d0wyTzFnNHVCbEFIWEJNcU1kWDJMZVd5cWY3djdpbDV1UzN5NVV6dHpW?=
 =?utf-8?B?eTYwbWtVejVKL1ZUQkJxNVNTdFc4cW03RVdoN3FpNW5LL1ZnT2dTYndxMEdm?=
 =?utf-8?B?RmdrQzdrajkwS0xHYXVlY082YnA4R1hUM2Zwb3dsbENPeWdFQktjR282ZmNK?=
 =?utf-8?B?N01yeUlRc2o1c1JpNHdQNE1mQTlYNzFEV01Ma0RFZUxkREwyclMzRHkvK0g0?=
 =?utf-8?B?cDg5SWNqYmxrQUwzODR6Y1J5SVpZSWgvZVVEN3kzUzF5ZDJZbGkwZGxRam9s?=
 =?utf-8?B?RGhTeTZqZ3JNemF2c1FSckdyTm53SVF6aVJvTUhCd25GZlpyZlY1SlRrRTdY?=
 =?utf-8?B?Y003cFcwUXd3Q2s1YzBtQmVITkZvQXVYcEhKUTBjcndmY1U3dUwwSmxycmsw?=
 =?utf-8?B?YjNGTUxrL1NMblVtS1Q1bG9nZENjNndSUFlZMDRMenM4Q1JtdThzT3J6QWtL?=
 =?utf-8?B?SStHTXFmWWFsd2RMWGFFTlR6OFdYd3lPTVM3SzBHeVVHQ3k4Nm5CeERkWk5Z?=
 =?utf-8?B?bHBkSEZCdmJMNUpOZkJaR0MzZDFxdzJ6dGZOTng3N0hHRmhyYm5sZVU1djEx?=
 =?utf-8?B?ajFVSkFlUmQwS1Y1RVBzb3h0dmdBQk01ZzZReFVHKzZWdUVTY3d6Y2tYemdl?=
 =?utf-8?B?bUpFblFXbDQrdTRteEZlbXhaaTNTeHJEU3ArZkJCWWVQTHFLUjZnWUZtNjh2?=
 =?utf-8?B?KzlQTnhseHNFK3FHK2JHMnVRSUVydDBiam5yQXNtbElyalZISU5kOFBFUFBt?=
 =?utf-8?B?azVNQktuUkFJNDF6dnNKRE9RcEJaZlhycWFKb2FDYUJLK2R2QlBzL01BMldN?=
 =?utf-8?B?QmQ4bS9KUzNkWEVibnpRa2tTM2VLMW1mai9YZ3lMWEp3dUU1a0lVVFNnT1Zx?=
 =?utf-8?B?UTZ4OVY5c3FZcGlMdFB5MlBGd3FFSHZSK2xLdHM5eFZvRU0zbnBlS1doUUhV?=
 =?utf-8?B?V29lTHpZV2E3ZVgyeDRrWWRKcGpCZ21qK29SZjdyamJNNVI1RTBIT0xSbGoz?=
 =?utf-8?B?Vk5HQWh2MnNJRlcvNmZSNXlweGlTeWtFUGZGMjFOLzFsdlVPMmlubHM2TW5r?=
 =?utf-8?B?dVNxd1QwbjZwdGFOU0JSRmpPK1R5aWF5SHJWM0Vrb2YrbnVTNGdPUGtzK1dQ?=
 =?utf-8?B?QlZoaVNYcjFQVnZZKzNYVmFERkVmNnc4MkpwNnljbTB0K1liSTdqZz09?=
X-Exchange-RoutingPolicyChecked: eL2/EBeOscdr5KaQk8R+BaJ0Hq8S6tuskbEbVNiBqFEfh2kJl/mY76SSPMtEaNL5LthWMVKPP5DgUfAeGqFJpBYpM8VZ/8pXKyuVZosAY27zQG8zBIpQDy0dhziF6JBSdKkPUsKWDMyuOi9HEzRYeMXbWA7cD3GxbJV/c52qUIIPYBSHOUZq+iMAfHbAAkMulA0NlCNz1+f7SuHeQL2w4KbwAzoyUci2RTm5guBLKjUpmdkgs1UAwztjvINfDDSHKRzQeoMMMZl678f3wsq/eIpIsXWYEgDCwi0MrOG8yEOuQcXy/KlAVVikFe9O7Cg1L37qe4kF15ii2GH1oYtW5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cbe476-0615-463c-e919-08df12d7c21f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6932.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:16:39.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2l5pWepHehP0ieVlvISK+iPDPUIVCNHQUcNMBAdcFyGFfOuWOo/BpGg6Spq8PklL+TXgCybbX7edbXvQzn1sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
X-OriginatorOrg: intel.com


> Hmm... Curious what's the expectation from the KVM maintainers for this 
> patch. Couldn't be directly sent out to the x86 maintainer?
> 

I developed the test during KVM development and mainly kept it here for
reference. As mentioned in the cover letter, patches 1-5 should only be
considered for inclusion for KVM support.

Yes, eventually planning to submit it directly to the x86 maintainers.


