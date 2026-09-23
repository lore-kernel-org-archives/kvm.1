Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5C5803B3;
	Wed, 23 Sep 2026 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202028; cv=fail; b=hR6F28b3xFmngOCr1SBXALPkMZjkY+czijG8ZDL/Peae+EGMrFOTuaxxqrVyRzrJMd/ABLCxIBW+3+qEreguyUQYZiL9AGtFr6JCe9/mocV1qhRbz6Qe8d2vcWkyv+6+b0SPL+iZsJRQ8RvH3xECv8BAaJOeK04YhS6gp/ZD3Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202028; c=relaxed/simple;
	bh=ToaJZ40blOQiy2AHtCIAFuT+7oGDTH1HjG83vWPUkk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B4b5XObYILj2VvR0S79GfXunqb0mTgMYgkrn8H5mfAAniPYML9XXT2C44zPLgNBFJdndTMvLw85xXxXRI5dpAuP85cHbkd7GwJXiTAbE6WhZKtIE9H5vWFI0jRzNpxi/E/BoScBHJzvg0t2OywAOUGy6rj51LMpfHMGbH9oJG84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alfedlGO; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alfedlGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790202014; x=1821738014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ToaJZ40blOQiy2AHtCIAFuT+7oGDTH1HjG83vWPUkk8=;
  b=alfedlGOgMvNB6EkQLK5GY4DMeJRs6P4oF7surnTKtrWe0+tGwOOj5jp
   JHcoIuEmmXsTpt8wzm8qC55CFm6rwK7X3JPS8bPJtbOzY5Y3PVoeR/BMu
   VahKzc1A/zT/D4lK4GXlYW4CNux5uYSUXZLfqcngGM0ZbkM2TM9lZ63lu
   6dr+tUGcfKSfcG6C5W8/7aO6hx1yWGMv5QFvvBElEbbrBDoNuYi3G75Er
   t94lDJvwEElA2ZgII3NZJ6TZpW+pW886YyW9JokE1fsYqwUUEmVsiplx0
   VGYjy3SNN2kqCphDpYdTU6Q17wKCu9yhYYdJ3Q0+9tWYBk2e3bwrCzZUX
   g==;
X-CSE-ConnectionGUID: /PxYwZ6KR8ijZE00++fHqg==
X-CSE-MsgGUID: G/JjN05cRN22MnbViuqXQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101528036"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="101528036"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:20:13 -0700
X-CSE-ConnectionGUID: i5GHGpyHTKiZIYU5geawyg==
X-CSE-MsgGUID: JhyFn78GTU+KRJnLtcIO6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="273981555"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:20:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:20:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 15:20:13 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:20:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbEqG0RWvxA91xGP0F3DfvDJNsUeXtoHz4w4Xztap5jbU0+hVlM924DNk4BqbcuTRoMGLzmrr9pOxmPDOKTHeP+URvIi4ILUdaplnVezNP1wkKcym5No6rx0QoKyD+NSG11BL7mmq+S0tQU0gyRkC7KH/RBfYJKPJx+diCaZTg0g6XKgXcHTJncFqN+TJlkpcNilSy3yQ09E3hUMgXONaTNPTU+QXoqPYWLcZgAGw0vZ8Xzm42H74wn+9PPEvAO16YlGq1h71Sa7i8DjWJXUIZscCEknlsFIQas+/gZMjE5tefVJUr9yLztIfDLZTTkGHVqYIvAHU0VE9vPN+gjeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToaJZ40blOQiy2AHtCIAFuT+7oGDTH1HjG83vWPUkk8=;
 b=V50XR3izJfoCri8JwPeZr6Mzth/vyZbZE8Ifsk7+VpBx7ruAqCFlRUd2L23Uxd+IqWIk3KBXt26ts1hoJAQvsJHusC0/vtmAoe23NiyL/Y8H6dL466m6HNHJfaejMqTfAxgmblFkiPmS8W/OCxKtZJepWuVjpF27vfVgX/76Tzod2ENmanTixHkzqhtlmsVLUFR7tDFEKw3qAJVZXGklyvwTtvoSZioY950RfE1yNIP9RQhzkSoGApNJRlyDnercZFFmtyqIqqP6ckrUQ8XGhPNCtjMl70ylZJOVeSIhfRKlkluzccYzkgR+XUa0FnLVN7kIQSzdkEBUCLbOk2e0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by SA3PR11MB7462.namprd11.prod.outlook.com (2603:10b6:806:31d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 22:20:09 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 22:20:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 01/10] x86/virt/tdx: Add a helper to read a table
 of metadata fields
Thread-Topic: [RFC PATCH v2 01/10] x86/virt/tdx: Add a helper to read a table
 of metadata fields
Thread-Index: AQHdR3IPtpvKuvDyLEaWPjcQlR1L8rbcxH6A
Date: Wed, 23 Sep 2026 22:20:09 +0000
Message-ID: <073407d07707e1fd083f238674560c5b7eb1c4c6.camel@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
	 <20260918132946.76533-2-chao.gao@intel.com>
In-Reply-To: <20260918132946.76533-2-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|SA3PR11MB7462:EE_
x-ms-office365-filtering-correlation-id: df001381-a11b-447c-6d62-08df19c0d451
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|7416014|38070700021|4143699003|10067099003|11063799006|56012099006|9063799003|22082099003|18002099003;
x-microsoft-antispam-message-info: MecSzqRi/yuBNVOi97GOLI5dWg6zeQCZc3Npv71rKZXF2VGmiIThYGdnfx/tdmguxx/xtRm4/mepQS9TdU1+1NJgMxJN+Vb7ESeOpfR+kEy0zJr0SnY4Uhlkf2wPcck4S9zRUls9OpIZgBNZ5PM0a8paZeczAPifNpwp9ILYoF6sLUR+pg7FEgzBsHqDxQQXgoqN5ohuhFZj37dcIJmGGx1M7sO7YgllwxTMZ6X8TbYLBnjY1JRqcZhGZBOaI6qKuAAT/iWuaRU6VBKC7ONQ+RVUS9aRq3fucZ53HCMKvLy8vryuzuPnqokegU/+8FixlO42LbcVPTvB1LR6BL75SxKj6RifvSHJVR0zueMmU+eHbqowgzJtTn39lC15616Ei6HY3xQmHAM1RTkHwVBBhIBlHlj6FJBZkp/3ozq1Ahd+azm3j24+dFvwl/mnN0GB0HBVoQeWi2J3Uj24x8Tt/MQ3Idri+ZEW2eObiaSHSS8hRQvMCbLqq7tPrFVhkdVM84Trk3K26+PS62Vm34WtU1WwQdyMTSG7uqZbTc25pjlLIEY8ssYUPCV6i/UpzZqRwaYKcGMom3L6WB6kyghWM2flspXaPcEQwdZx6QH490UYAf7hcfWGGl2p8IOcLmSfyrPqhR/4q5+OjHG/o9c4tWhNoB75bcwZirGCepqpsNw+aRe6vN4oN/f2ZIAFCe/JYOi+VjfF9DNRWK8Nf3jcDEVBrhFIbJPad6yASY10DHA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(7416014)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006)(9063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDJ1a1pxTW5IcUhrUHRCTFlLM0lkYXRLK0s2a0ZFZmp1MDhHcS9NRDhOdmhm?=
 =?utf-8?B?dnpQaCs1a3J2a1NEVHluQlpFMFhLcWJucHo2R3NxTHRzSTk3YVdLWmxhSFpv?=
 =?utf-8?B?SHRobUdhbUl1NHJsSm11Wm4yME5DNWU4QWd2aEU5QkVmSTc3My9yNEFoMUJt?=
 =?utf-8?B?bm14bzFBSGplVC9rYVdqMXpja3I3eGtweGZUclVTWU5QWTZDQTBnMWpHNlls?=
 =?utf-8?B?WUQvN1BUMnBPdW1IYTF1eURVR09rUmRiMkhSd2xXa0xOWU44S05yUm9yTzZD?=
 =?utf-8?B?MTZYMytoT2tLYlhMTnUxbVRpVVJRVGgyOUI1YjVTTkh6L0syaFpacVhvWGkw?=
 =?utf-8?B?cjdjMldQRVJHT1VxbFRvQ2FMQ0Z4dTNPVWRybWE4Sm14NysyeHE1cDVPR3pS?=
 =?utf-8?B?RFBSUmh4VVplZ29aK2tnVXZZdE4yUE1mNDBuMkoxSEdNeFNTeFZBVWFkWGwr?=
 =?utf-8?B?c0svaHJVOU1GdHJlSDdaR1I1bTUrMmlVajY5WE1VWitvVUVCTjNPT0VmaDJW?=
 =?utf-8?B?WUp2ZExlSHFaSG9vYm9OOEpOcWMzOGJrV1JpaXFEOUNVWEZ2RnlvS05DYmxS?=
 =?utf-8?B?NUNPdW5YQzZhZGN2SW5WVmlGc0lDd29sU2t1ZWlDRDcwblhROUlmT1FxcnlS?=
 =?utf-8?B?V2dxYTZBM2wwdVY1Tk1LUmM2Q0xvSVNYNjk4MDBlcExvSmJXdVZNVjgySkV6?=
 =?utf-8?B?ay8yNFk4K2tHS0wvMUZKdVpBRS9yd3B3MmFmV3BmYnlXR0pIb0VoVkloa20y?=
 =?utf-8?B?Z3Ara014M28yMkxzMUo4NXorWlFEOC96dlBsRjB5SGs3Q0cwZG9xbVFBelAw?=
 =?utf-8?B?QUtHcU1hdlR2ZExyMzkwbmVySHJDeVNVTzJHWlRzSFF4bFk5WDduMlF1a0RE?=
 =?utf-8?B?Y3RlRHJkUGFHaFlqRDNoUzFvVHdvOS8reXowMlN5bHM0SjUrN3IreDdrTFBz?=
 =?utf-8?B?SUV5V0JQdEpiZWgyVmlRRGlLZFMrTmFtZHVDcjZmWndUQU9lSjdST25iejdp?=
 =?utf-8?B?Z3VTdk1iaUpIcEhJVms2UXRWZHNQNVkzUEhxaDJPM3JOR29HTnNkSjdjaElH?=
 =?utf-8?B?cEFqK0NjRVN0aTUvdjZOZDhlSGsyYjYvaTAxRkl5eXdYdld6VFRWWU9jdkRT?=
 =?utf-8?B?aTFKTGRRbTZFNVV6Y3AwMWVTU0pSdVFBTWRwdC9HTDJpbUpuTCtDdVVUNVZl?=
 =?utf-8?B?VzYrM0lKK3B6bXlYU0VJcDJRK1QvMVhMMTA1MUZ1QTRWcVVxQ01TeUFKdHlU?=
 =?utf-8?B?dnkyZ3NiWXFQRk5TRkNEZi9vanpKOVVMWm5wT0VxTG94WTJpWFB1YktuUStY?=
 =?utf-8?B?bS9vbHYxcFNVdG1KOVA0c3FnNUxENllKZy9uRXBtcDVXYUZZR283YmRKK0sz?=
 =?utf-8?B?VzRkUThicWJSWlV1a05PTElWOWtoRkxLZ1FsQkZ0aWFqQTFUalF5NDd5cVBv?=
 =?utf-8?B?cWRLY2I3QmgrN1hIUkZ2WENIU1VaWHBDbisweDhQemVXSVJ3NWUvNG90Rmto?=
 =?utf-8?B?b3RhbGxxSGhqeVVLeFo1N1RkSHN4OTkvbDVWZnd5T0tuK05NM1F1cGhVbEJW?=
 =?utf-8?B?S1lBWlhKNW9CbFljOXlibDFlc21mb2l1cUFhQUxYZXhBSWJveDBBVVIyQnNt?=
 =?utf-8?B?TEd4NXpBODRNajdiZDBTZlh1THdINFQzNmplN1lRZDEzYlRvend3d0RmQ3ll?=
 =?utf-8?B?NXFnang1bnBzcEk0WTdiN2FKeFZFaFpLdm1yZEtXUEpDMXZLL3h3V3QwTlpC?=
 =?utf-8?B?TTJOZjlJK0VFbnEwL1YrNG1nYnZRVmRJOFBGMnhmMzZHQldib2RDVkJNWGJv?=
 =?utf-8?B?VE5zRitURjJHcHRjUkZuOHgvTGVaRytRaW9tL0N5aU5vT3VpOVhPdGt4UXV1?=
 =?utf-8?B?ZEpGVm5ZM1NmbndBL3NzWmN1M2lzU3VDZ0tnbjZvM2U1dDhIcmtnb2JmTDdY?=
 =?utf-8?B?RFByM3ZJMEFvR2wySW1NaXVndXRUSHo2bWtwZlEwSkJHUGE5VFI4T2Uyb2d6?=
 =?utf-8?B?QXZ4VTJRKzJZRWt6a3kxTVFtODhMcmZHV1dyQ2RoYkN3TjJwSG8rK01odW5Y?=
 =?utf-8?B?YjhqWGpPL283cytjTE83T3VnaEI4bXFTMDNBeVF0V0pleWdhNThKV05TdDQ4?=
 =?utf-8?B?N0M4TERmbWJrYXVpeFYzTW8ySlpxMHVwYzFzVzN6UXVHc1FXT1VGVlVMZDFq?=
 =?utf-8?B?Z2orR1h3MmtxUU5HZ1IvRWVVNVo0S2FMQW8xVTNlSlVOWk1wdlAvT042OE1r?=
 =?utf-8?B?MURyWGFBQmJOQjFoYmlmN3JPZGhoa1h0VFhPeEVDaGk3ejFTT1JFd1d1YWwv?=
 =?utf-8?B?RFhCTk5SWE9idXo2eHJjY2MwMGVXdkNyMnA0dzN1WEhGMWs2RzRvckRpWjlq?=
 =?utf-8?Q?dopD1uj7eI4IUJ14=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6FF4EBE386FAE45AF5CC550F61F75BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V3dwIW6bb2v4OUxMNP0vUdqxMRZNn42SwgZtmZE53pB/huYGOBn3Ca/85Ts3Ub1od02Z4oqXuk4qjFdKdKbuTkXM016G089CjPbYrWZ4M3KSXlDHNMXeiDc1imuI0iDm+dM73+yjUz+ubwcYUOqn+TbBzcW9ig+PqXn9xcaZ9VUpYIHEYb+cgsws5rEhQahMQnhjkUTw21DapQfqztgd/W5iFMy+hyMo5MEq/LM/FG3Id47gOEDVVUdCh7vBEI7uQJyP8ywqPyIhAxcRq9wBFvZzCX0cShQEOxBqJ9GS9dRBVDpDpR5U3meRYU1l8v28xsP1Bv1Ejw+P3rUXcwHndw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df001381-a11b-447c-6d62-08df19c0d451
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 22:20:09.6209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4VYS9fBcYjI8eFcwWWPFYEaUxhtgsXJlwFa2xopf5iGgdEKu1qkTc+NFgHPU/SibFut5B8dkPz20aLxCRlfnKneoz2S2e7E0n4XbRu6X/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7462
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTE4IGF0IDA2OjI5IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IG1ldGFkYXRhIGZpZWxkIHJlYWRlcnMgZ2V0X3RkeF9zeXNfaW5mb188Y2xhc3M+KCkgaW4NCj4g
dGR4X2dsb2JhbF9tZXRhZGF0YS5jIHdlcmUgZ2VuZXJhdGVkIGJ5IGFuIG91dC1vZi10cmVlIHNj
cmlwdC4gVGhhdCBoYXMNCj4gbm90IHdvcmtlZCBvdXQ6IHRoZSBKU09OIGZpbGUgdGhleSB3ZXJl
IGdlbmVyYXRlZCBmcm9tIGlzIG5laXRoZXIgc3RhYmxlDQo+IG5vciBhdXRob3JpdGF0aXZlIGVu
b3VnaCBbMV0uICBUaGUgZ29hbCBub3cgaXMgdG8gbWFpbnRhaW4gdGhlIHJlYWRlcnMgYnkNCj4g
aGFuZCBhbmQgdG8gZXN0YWJsaXNoIG9uZSBzdGFuZGFyZCB3YXkgb2YgYWRkaW5nIGEgbWV0YWRh
dGEgZmllbGQuDQo+IA0KPiBUYWtlIGdldF90ZHhfc3lzX2luZm9fdmVyc2lvbigpIGFzIGFuIGV4
YW1wbGU6DQo+IA0KPiAgICAgICBpZiAoIXJldCAmJiAhKHJldCA9IHJlYWRfc3lzX21ldGFkYXRh
X2ZpZWxkKDB4MDgwMDAwMDEwMDAwMDAwMywgJnZhbCkpKQ0KPiAgICAgICAgICAgICAgIHN5c2lu
Zm9fdmVyc2lvbi0+bWlub3JfdmVyc2lvbiA9IHZhbDsNCj4gICAgICAgaWYgKCFyZXQgJiYgIShy
ZXQgPSByZWFkX3N5c19tZXRhZGF0YV9maWVsZCgweDA4MDAwMDAxMDAwMDAwMDQsICZ2YWwpKSkN
Cj4gICAgICAgICAgICAgICBzeXNpbmZvX3ZlcnNpb24tPm1ham9yX3ZlcnNpb24gPSB2YWw7DQo+
ICAgICAgIGlmICghcmV0ICYmICEocmV0ID0gcmVhZF9zeXNfbWV0YWRhdGFfZmllbGQoMHgwODAw
MDAwMTAwMDAwMDA1LCAmdmFsKSkpDQo+ICAgICAgICAgICAgICAgc3lzaW5mb192ZXJzaW9uLT51
cGRhdGVfdmVyc2lvbiA9IHZhbDsNCj4gDQo+IFR3byBwYXR0ZXJucyBzdGFuZCBvdXQ6IHRoZSBy
ZWFkLWNoZWNrLXN0b3JlIHNlcXVlbmNlIHJlcGVhdHMgb25jZSBwZXINCj4gZmllbGQsIGFuZCB0
aGUgZXJyb3Igb2YgZWFjaCByZWFkIGlzIGNoYWluZWQgaW50byB0aGUgcmVhZHMgdGhhdCBmb2xs
b3cuDQo+IE5laXRoZXIgaXMgY29tbW9uIGluIGhhbmQtd3JpdHRlbiBjb2RlLg0KPiANCj4gRWxp
bWluYXRlIGJvdGggd2l0aCBhIGxvb3AgdGhhdCByZWFkcyBlYWNoIGZpZWxkLCBzdG9yZXMgdGhl
IHZhbHVlIGludG8NCj4gaXRzIHN0cnVjdHVyZSBtZW1iZXIsIGFuZCByZXR1cm5zIG9uIHRoZSBm
aXJzdCBlcnJvci4NCg0KIlByZXBhcmUgdG8gZWxpbWluYXRlIGJvdGguLi4iPw0KDQo+IA0KPiBB
ZGQgJ3N0cnVjdCBmaWVsZF9tYXBwaW5nJyB0byBkZXNjcmliZSBvbmUgZmllbGQgYXMgaXRzIElE
IHBsdXMgdGhlDQo+IG9mZnNldCBhbmQgc2l6ZSBvZiB0aGUgbWVtYmVyIHRoYXQgcmVjZWl2ZXMg
aXRzIHZhbHVlLiAgQWRkDQo+IFREWF9TWVNJTkZPX01BUCgpIHRvIGJ1aWxkIHN1Y2ggYW4gZW50
cnkgZnJvbSBhIGZpZWxkIElEIG5hbWUsIGENCj4gc3RydWN0dXJlIHR5cGUgYW5kIGEgbWVtYmVy
IG5hbWUuICBBZGQgX19yZWFkX3N5c19tZXRhZGF0YV90YWJsZSgpIHRvDQo+IHJlYWQgZXZlcnkg
ZmllbGQgaW4gYSB0YWJsZS4gQW5ub3RhdGUgdGhlIGhlbHBlciBfX21heWJlX3VudXNlZCBhcyB0
aGVyZQ0KPiBpcyBubyBjYWxsZXIgcmlnaHQgbm93Lg0KPiANCj4gRm9sbG93aW5nIGNoYW5nZXMg
d2lsbCBjb252ZXJ0IHRoZSBleGlzdGluZyByZWFkZXJzIHRvIHVzZSB0aGUgbmV3IGhlbHBlci4N
Cj4gDQo+IEFJIHdhcyB1c2VkIHVuZGVyIHN1cGVydmlzaW9uIHRvIHJldmlldyBjb2RlIGFuZCB3
b3Jrc2hvcCBsb2dzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNoYW8uZ2FvQGlu
dGVsLmNvbT4NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtLzFlN2JjYmFkLWVi
MjYtNDRiNy05N2NhLTg4YWI1MzQ2NzIxMkBpbnRlbC5jb20vICMgWzFdDQo+IC0tLQ0KPiAgYXJj
aC94ODYvdmlydC92bXgvdGR4L3RkeC5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQvdm14
L3RkeC90ZHguYw0KPiBpbmRleCAwNjM1NzRlZDg2MjUuLjVjZDljNmViOThjMiAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC90ZHguYw0KPiBAQCAtMzk1LDYgKzM5NSw0MiBAQCBzdGF0aWMgaW50IHJlYWRfc3lz
X21ldGFkYXRhX2ZpZWxkKHU2NCBmaWVsZF9pZCwgdTY0ICpkYXRhKQ0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KPiAgDQo+ICsvKg0KPiArICogTWFwIGEgVERYIGdsb2JhbCBtZXRhZGF0YSBmaWVsZCB0
byBhIHN0cnVjdHVyZSBtZW1iZXIuDQo+ICsgKiBAZmllbGRfaWQ6IFRoZSBURFggZ2xvYmFsIG1l
dGFkYXRhIGZpZWxkIElELg0KPiArICogQHNpemU6IFRoZSBzaXplIG9mIHRoZSBzdHJ1Y3R1cmUg
bWVtYmVyLg0KPiArICogQG9mZnNldDogVGhlIG1lbWJlcidzIG9mZnNldCB3aXRoaW4gaXRzIGNv
bnRhaW5pbmcgc3RydWN0dXJlLg0KPiArICovDQo+ICtzdHJ1Y3QgZmllbGRfbWFwcGluZyB7DQo+
ICsJdTY0IGZpZWxkX2lkOw0KPiArCXNpemVfdCBzaXplOw0KPiArCWludCBvZmZzZXQ7DQo+ICt9
Ow0KPiArDQo+ICsvKiBSZWFkIGVhY2ggbWV0YWRhdGEgZmllbGQgbGlzdGVkIGluIEBtYXBwaW5n
c1tdIGludG8gQGRhdGEuICovDQo+ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIF9fcmVhZF9z
eXNfbWV0YWRhdGFfdGFibGUoY29uc3Qgc3RydWN0IGZpZWxkX21hcHBpbmcgKm1hcHBpbmdzLA0K
PiArCQkJCQkJICAgIGludCBudW1fbWFwcGluZ3MsIHZvaWQgKmRhdGEpDQo+ICt7DQo+ICsJaW50
IGksIHJldDsNCj4gKwl1NjQgdmFsOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IG51bV9tYXBw
aW5nczsgaSsrKSB7DQo+ICsJCXJldCA9IHJlYWRfc3lzX21ldGFkYXRhX2ZpZWxkKG1hcHBpbmdz
W2ldLmZpZWxkX2lkLCAmdmFsKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJldHVybiByZXQ7DQo+
ICsJCW1lbWNweSgoY2hhciAqKWRhdGEgKyBtYXBwaW5nc1tpXS5vZmZzZXQsICZ2YWwsIG1hcHBp
bmdzW2ldLnNpemUpOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICsj
ZGVmaW5lIFREWF9TWVNJTkZPX01BUChfZmllbGQsIF90eXBlLCBfbWVtYmVyKQkJCVwNCj4gK3sJ
CQkJCQkJCVwNCj4gKwkuZmllbGRfaWQJPSBURFhfTURfRklFTERfSURfIyNfZmllbGQsCQlcDQoN
CkkgZmluZCBpdCBhIGJpdCBoYXJkIHRvIHNlYXJjaCB0aGUgY29kZSB3aGVuIGl0IGNvbnN0cnVj
dHMgdGhlDQoiVERYX01EX0ZJRUxEX0lEXyIgcGFydCBvZiB0aGUgZGVmaW5lIGluc2lkZSB0aGUg
bWFjcm8uIEFuZCBzaW5jZSB0aGV5IGFyZSBhbGwNCm5hbWVkICJURFhfTURfRklFTERfSURfRk9P
IiBpdCBzZWVtcyBhIGJpdCB2ZXJib3NlIGFuZCByZXBldGl0aXZlLiBDYW4gd2UgaGF2ZSBhDQpz
bWFsbGVyIHBhdHRlcm4gc3VjaCB0aGF0IHdlIGNhbiB1c2UgdGhlIGV4YWN0IG1hY3JvIG5hbWUg
aW4gVERYX1NZU0lORk9fTUFQKCk/DQpNYXliZSBsaWtlIHRoaXM6DQoNCiNkZWZpbmUgVERYX0ZJ
RUxEX01PRFVMRV9IViAweDg5MDAwMDAxMDAwMDAwMDBVTEwNCg0Kc3RhdGljIGNvbnN0IHN0cnVj
dCBmaWVsZF9tYXBwaW5nIGhhbmRvZmZfbWFwcGluZ3NbXSA9IHsNCglURFhfU1lTSU5GT19NQVBf
SEFORE9GRihURFhfRklFTERfTU9EVUxFX0hWLCBtb2R1bGVfaHYpLA0KfTsNCg0KPiArCS5vZmZz
ZXQJCT0gb2Zmc2V0b2YoX3R5cGUsIF9tZW1iZXIpLAkJXA0KPiArCS5zaXplCQk9IHNpemVvZl9m
aWVsZChfdHlwZSwgX21lbWJlciksCQlcDQo+ICt9DQo+ICsNCj4gICNpbmNsdWRlICJ0ZHhfZ2xv
YmFsX21ldGFkYXRhLmMiDQo+ICANCj4gIHN0YXRpYyBfX2luaXQgaW50IGNoZWNrX2ZlYXR1cmVz
KHN0cnVjdCB0ZHhfc3lzX2luZm8gKnN5c2luZm8pDQoNCg==
