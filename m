Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136594A8FDD;
	Mon, 12 Oct 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821412; cv=fail; b=BG5GQFfosp03HNWN8uv5PVMIKUZWqlLv1AsBZoCW0775VcrZ8wa5JruZWIS571s5EAPDGgTIFxRI4q8b8NFQYijNlVAUQ2WkLTwDbRrApnfSeHN3YvnGi1pmr8V6I2llRe+sO7496ItLoQY76e9h2hrIp02UiykakBdRQk6czu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821412; c=relaxed/simple;
	bh=tIkOyJOa1Ju9hAKcKQjV8274WBNoE9V8WkDfkQqwBuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LzJ2HebSyQMi/nTah4KFtPZ8UHPNYvPPVt2JpO8bG22ApzTaaL6sJrJ9+L6okU/dThQxQOk/IfEIfl7W5OKfEymZyVGa/k3qWeJtUVqnwBaO9rE8EN0UE5iy6vti5utT2RoF68kkGjVKJARgVJooQFmFPrwbwrDsgw0raIaLCMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EB+VyYLO; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EB+VyYLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791821412; x=1823357412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tIkOyJOa1Ju9hAKcKQjV8274WBNoE9V8WkDfkQqwBuI=;
  b=EB+VyYLODmhUsBje9NozmNFdLO6lsuGWy9LaNAuG4uGepQKKS8lsBYHD
   rOGSGEA3Bbm8VNBiYNqXfMIWvzkMpNIPx4LIJpp6PArrokKapSvpjR5dy
   w9DOLNv9vqpqK3KkyRHUTwJV+gffs932vf1vnd7b2kT76sbcremSlR6+A
   jWd7WPQY/toRw3/buGS/ELxVXNmzAj8ivcFdCxtgSeFH2IlIEp8n+YX2E
   26kbB4OIc0khlCSpd3qNTJ6U54POO8evId9CcwZhVhgQcn5XJ+mcihQoG
   PRFUDEdvZF9zHOTesj7LbOpgmFsYcxL46fiJLYKsFY2lSt6lMR7wP72fc
   g==;
X-CSE-ConnectionGUID: VchxdVThR0ibCgWnZwFnCw==
X-CSE-MsgGUID: Cr3LdYTQQy28NWPhkmuxAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="546860"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="546860"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:10:11 -0700
X-CSE-ConnectionGUID: 9E8Bfz0xQeKpI2hZMks1hg==
X-CSE-MsgGUID: tAEHyKArT3uflB5WmhDa8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="891875"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:10:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:10:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 09:10:09 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:10:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0QT1ijA8ffB+9LHnSaA3Z0ubt6BLzUP9zSoPId74lQ1FIMQjUMYU1cf3b7vHnrGgu8tZXgnPIT7Pi1pxyrPgP6boGpbfLhyaBL0y+N81KGlpu1rFr5si3s+BTzVzCN+ietNvenHGxzIlyEHr2CLq9d2k9riQ5nJLOx/wfKgoN+erKz/Q8TQXcAKpsCk52PJZQb5tyFI6lBzHrRmZPwZzxtZFnTEMW0m5jRd+5BEAobkWRHNZnCutOulVHcEHRESy8QGxnVurCSBwGeeGcyVjz6yxWiWEd4RKxXZMw8c9lw/V0/8C4ZccEJuuiO/gfcjoDf9yF9UKgxEUZwwMINCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIkOyJOa1Ju9hAKcKQjV8274WBNoE9V8WkDfkQqwBuI=;
 b=nDuIVHUXBrQB1uzjBQlAFzsC+YeZle1oDgp8xtj+VRa7inN0xok64j7RQpj0E2xvbHw9znLf1l1aSeM6mSXFM6B6EVTWlS/5q61V+pt8V7Su0rvjLcnzlWdLYKCMCFfCdg1n7eBjBBKtmJD4EltDLMjA5YoC2Yg1qLTYGMdQEQheSB4ndynepttMYBc3Fp//8uPG67blTGjUBq3YzVK9uhTLZCS8TsGXZRLY3GEanXVOpZzlY5ZHeLw97uwZYhwCe7mv17WFAeg1DoafMjwZgpq8ye7JUGjRaTXVp/7hIUVKKxbD8D5R6MUG5lm8JQc8iUXea/bgo50eCpmH/+T0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BN9PR11MB5291.namprd11.prod.outlook.com (2603:10b6:408:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 16:10:04 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 16:10:04 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Gao,
 Chao" <chao.gao@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 4/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Topic: [PATCH v3 4/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Index: AQHdVPFs70AHzD0N+E2vRzbscozWBbb1l8CAgAFu0wCAAxfUAA==
Date: Mon, 12 Oct 2026 16:10:04 +0000
Message-ID: <427a04b25fe2bc754a261c0b415f04d04bc04481.camel@intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
	 <20261006-tdx-module-ext-v3-4-db52cb05b918@linux.intel.com>
	 <1b142a6d4f4714796027876e765c0c27ae770eab.camel@intel.com>
	 <aspuIg3Oeaw1LWZ1@yilunxu-OptiPlex-7050>
In-Reply-To: <aspuIg3Oeaw1LWZ1@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BN9PR11MB5291:EE_
x-ms-office365-filtering-correlation-id: aa24ce33-b477-4f94-bf3f-08df287b46a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|38070700021|56012099006|4143699003|11063799006|18002099003|6133799003|22082099003|10067099003;
x-microsoft-antispam-message-info: 2op4rLjusiiy5bhYDqo1d5C7ve0O9Tw+7F75dBp3OfZCoceq3UDGqprsHnDwoPrqFJPmGxz3Xz/SvxjrFlUPT38K1LnuTENDjaXkNzmHXpT4M8OWVlr0i7rghGM6ZAcz0H1de974PMRRBZeIeY3yDENKejdO5T8gy19lxomUQw6DiUGr5Pha+/n23Tyc141WrjS/J7L8E8qD9sHo00LHh/A5IV/y2VVQEJt81cPD1YNb4fhLzbH45oycpO+8J8tTCcMMY13SmYTcOT4Ck8Evo5+PPeqoiWIpFzIqv8sZTr9Zlqpk6AyA3WzNms32TKeGPt4FlZcSXOxQWpK5xaSZh8h2QvGmQ2YjnSvTYKUilBWth096XOkLX0set0deGx9KBtPLUxFlHgNUcE0VmNCsq5NwmK65ESBT2b35Wcf0HdV27ASKSx8K6IxUZ+zu5yLR1VrSd3VerxlgVqhiq1uu43NkUC9FLX3mN53H/FetxbI2pIWgzqKzLa2pTFhwNe78tdar+WoaZnVDr0b3EZz98+OcPsRx/Ca9c5oOAg7mBpDVplbKJ/LOUhfseH+r0G1TH9Tjp2LIi3VcVkHyJmuVR7sHh7AA/zpInq98Ipu9XoFams86VvM4HrHQPmPIvRUR4zzIKZ/4SFbTXkHfX3eyw1xvzcUGMEPlbrfH/z573S4DPCNZDksMCPThk9/GzkJEEZ6PTqPHROIojGORmtRDcBrUdgCR3Pur8yxnBK4nsTA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(6133799003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDJDWHhYUnNyZG12cFBTSmJMTzl2T0lWeHZ0SHdDOGVDL1M2OUJaZ3pwWnNY?=
 =?utf-8?B?WXBiRFN0Rm0yc25IY2duRUtHYktJZTI1UDZuWTM3N0t3Njk2cDM2WGFpNHlk?=
 =?utf-8?B?THloRjNUdS9vK0JHMno4TFlhT3VwUmNNL2FaR1dLeEx0V1kvenh1VDJqTnZu?=
 =?utf-8?B?T09mS090YzZHTUJxNjNiTC9FUnJyYTFqcStjbWM1YXJnVEh5WU5rVm1WL0pp?=
 =?utf-8?B?OWpsaklPd3hadHZXMGFZNE5FZTRPcDJDbmJ4NTQwVHZpeUpGd2tLS1ZXM1hi?=
 =?utf-8?B?RlJtaVk5Z0M1Vlkyak1icXd4WjMyYWdVNm1JK0tmNnVaNTFzRkxRVDdiOHIz?=
 =?utf-8?B?U0dvTUlSNGR6M2QvZzlaMzhoallXajM3QkprSkNWM0dVYkQ0cGRXY3FHNlRD?=
 =?utf-8?B?T2NIR05SWGhCZjYxZUkybE5PdDFrdHhyNGd6VEtvcm1WeVBIZERxU1VUalcz?=
 =?utf-8?B?ditTSm80cEhVT21Nb2VJM0hHcnpEVWNTUUNSTFgxM091OEZ0WFJDaGVhbld0?=
 =?utf-8?B?VGVZL2laRXRESTFyZXNLNlJNV2RjQ1h4dHkwY3RIdjBoRWNLT04xTkNsekVp?=
 =?utf-8?B?cmQrTGNacmhCS1R0cHZTVWFwb1FXc1BSVUt2ZG1FZXg4bVpycFhuZzNIT0lv?=
 =?utf-8?B?NTI4TVo2Q0NxaDR4M004UDZGK0ZzVzhubTBBNE9TWkhreTk0WkVOVTFrOG14?=
 =?utf-8?B?cXpTa0wyY3NsaDJuUyt2Z2xLVkFudmRSMmt4ZXBkdXNZdVR0b1lNaVhjUzhq?=
 =?utf-8?B?Z2sxWTdTdlI1STNLQ0kzb2ZxVFF4bDhOZFUzbjdDMys3VHJkb29pMDZERFJL?=
 =?utf-8?B?QzltWTAzRG1NVDc0empVNnFhY3loTWc1R3JlWmRzMVJtSXUvMnpyZ3NLWXhu?=
 =?utf-8?B?N2M2c2xXSXM5UVhBUzVUaVJ0djUvd055MkFpZ2hrek1SYmE2YVBSY2xxVVJE?=
 =?utf-8?B?UjNVRU1GUFIwTXNhc25IRGdRaGZQWlVzYVFLZzZya2Y1THZGQTFVRWdLNGdK?=
 =?utf-8?B?QS9DVEhSRHIxM0duTmhKSHhkMDdodVF5ZGdybWxzbWtaZGhpU2dXL08yeE9Z?=
 =?utf-8?B?RVpjeExQWHo4djNkRTMxeUE3M2dURTNpMGhYdGJCV1B3d05nMDVSWDE0MmFH?=
 =?utf-8?B?UWxTUUlMMnZSUnc1dW5wLzNKeHlaU0RaSzdoWEtKajk2WGY3NHFoVHc3bEc1?=
 =?utf-8?B?OXBVdzdlMHVWUEwrRVdNVmJzUE1kN2VZWDJwT1AwTWt4YUpmcHNoU3ZNY2NG?=
 =?utf-8?B?SVlub3NTd0ZsU1RnNW8wRWRma3lBK3dCeXJvQ2Q5dDMwRjZGQVhJbFdxSGg2?=
 =?utf-8?B?U2dRV1IvWUNDeklCV0ZGTTRncVhnK0lCQzliR2wyaGJ2ejNYTStGU2FiU2VR?=
 =?utf-8?B?U1puYzRuaHkydGFFbFNnMnJQSnBVOStrUzBIZUZpZUo2a2FWL1FOQld3TTJB?=
 =?utf-8?B?Tnk5cnZwUWpPME1WYTNEYkZDVUgrWHR6OFZ6bFBGMGFvOHU0WDBiT0xoWTFK?=
 =?utf-8?B?eThCeHVoaTRxdmVFS3V5dUlkTXBOM3owYVNEbm5kM2pYWlFkTlZYbndaUThV?=
 =?utf-8?B?c1NYeTZnampQem90aEtqU3dJQkhEcjFyeTZHaW5QQmw4ai9EaDZLWXBpMU45?=
 =?utf-8?B?UWJza0JxNm5ITnJXUUdLdGhtOGV2N29OTXk3STEzbUluZjhzeFArbmwzdGoy?=
 =?utf-8?B?N2t6c0NGZUJGNGhCem9GWFB3VDJqMXJkNjY1VWZ1b0N6VU4zeDh5UjFybTZR?=
 =?utf-8?B?UGtuQzBNeWozZTBobG5FOXFiMlhjMjE1MDIzdEoxZE9sWGRRRVR3TEEvNm95?=
 =?utf-8?B?TDZYYTZZSEZjcVdiL2xCWURFRWZGUi9CWVV2SUVJbExac1dyaUdra0Vic1B1?=
 =?utf-8?B?eFRQWElRUFgxODNMRTNKWTJSU2dYTldOQmd5bjc0ZjQzaWtMdXRDcjYyd3Bq?=
 =?utf-8?B?bWM5U1UxWkJ2V0t4a2NzUzVGSndSYXljSkdJbTFSdVZsak05Ny9PVE1wTjRv?=
 =?utf-8?B?cUVXeU02YzhjSnJpNmc2dnlqMnRwSlBUQklVbnQ0TVZEYUNWNjRCTXJJeXdI?=
 =?utf-8?B?cmpadHFyTGR3OXc5Z08xOVQwbERpODE0c1I2WTE1c0dhQktZMFNFM0thdW41?=
 =?utf-8?B?RzljTGRWbGZ0SDkxc0pqbDlHc0k0ajk2MC9yYlVRcVlsdGI5UzlEZXFmbkQ1?=
 =?utf-8?B?MlN6T3d1MlJJOWUzQk41V1JrQmNQN1NHNC9yMllUM0ZNUWUyLytoajdJY3Vt?=
 =?utf-8?B?end4RFVBNjgrLzdLQ3FCL3dwNzBHTHFITDdqelZqSk1FNDd6ZlNRNklHVW9w?=
 =?utf-8?B?ZTh0aERBeHZ6SlYzRFYxa0x3SlhTamxCWmpxWVhLeWJjV0YzM3B1bmVtVkRF?=
 =?utf-8?Q?DhLiPlYb5NPh3glQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94C4F4B71884F44D8C32D5D1E4FF2D3A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dkmj2FzJDmWFcaev1NOJLTgtQcZOpSZxOG0d7WwHuW9bbNdxy19MRON8oaGARNC7t4zXNFIUQ1EoMom10j9KoZAkVaxy/9EU3wgWcktvKLHqoxFJmrA5ZEqrRjnid3ceYBpFU/kr0Ldx+1tFql1TTDft5D5HdjVab3GIXJ5YyICqtdZQcnNKyLycu0A8PMo3aK8WnPoU8hNhquuwC31MnwoJ7DNfRuF/WcFo92G5MG03i7TyF7Qcf+KD17I+92F0JFeNWmWebbeN9rA4iYrjLxxug37NpMQKJSY/NYJ+o5aVMBUWqOpuH+C887Q2vja5kSkTYV0hurXpmsd2UG9C/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa24ce33-b477-4f94-bf3f-08df287b46a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 16:10:04.1496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ug+I5LsODZJBd+5v1/FyqwKcjsE7NrPAIsI8dTH0ZvCgodgJtFasWEhzzJUZ9dVOLforogZUFK3QHQsgaQJxbs2ppSlf8VElygnN45VfgRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5291
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTEwLTExIGF0IDAwOjU2ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gR29v
ZCB0byBtZS4gSSByZS13cm90ZSBhIG5ldyB2ZXJzaW9uOg0KPiANCj4gwqDCoMKgIFREWCBtb2R1
bGUgZXh0ZW5zaW9ucyB1c2Uga2VybmVsLWdpZnRlZCBtZW1vcnkgZm9yIHRoZWlyIGV4ZWN1dGlv
bg0KPiDCoMKgwqAgZW52aXJvbm1lbnQgdG8gc2VydmUgU0VBTUNBTEwgbGVhZnMuIFNldmVyYWwg
YWRkLW9uIGZlYXR1cmVzIGRlcGVuZCBvbg0KPiDCoMKgwqAgdGhlIGV4dGVuc2lvbnMgdG8gZXhl
Y3V0ZSB0aGVpciBTRUFNQ0FMTCBsZWFmcy4NCj4gDQo+IMKgwqDCoCBBZnRlciBwcm92aWRpbmcg
YWxsIHJlcXVpcmVkIG1lbW9yeSB0byB0aGUgVERYIG1vZHVsZSwgaW5pdGlhbGl6ZSBURFgNCj4g
wqDCoMKgIG1vZHVsZSBleHRlbnNpb25zIHZpYSBUREguRVhULklOSVQuIFRoaXMgaXMgYSB0aW1l
LWNvbnN1bWluZyBwcm9jZXNzLA0KPiDCoMKgwqAgZHVyaW5nIHdoaWNoIHRoZSBURFggbW9kdWxl
IGxvYWRzIGl0cyBpbnRlcm5hbCBleHRlbnNpb24gaW1hZ2UgaW50byB0aGlzDQo+IMKgwqDCoCBt
ZW1vcnkgYW5kIGJ1aWxkcyB0aGUgZXhlY3V0aW9uIGVudmlyb25tZW50LiBPbmNlIGluaXRpYWxp
emVkLCB0aG9zZQ0KPiDCoMKgwqAgYWRkLW9uIGZlYXR1cmVzIGNhbiB1c2UgdGhlaXIgU0VBTUNB
TEwgbGVhZnMgbm9ybWFsbHkuDQoNCkxvb2tzIGdvb2QuIEJ1dCBJJ2Qgc3RpbGwgd29uZGVyIGhv
dyAidGltZSBjb25zdW1pbmciLiBTaG91bGQgd2Ugc2F5IG9uIHRoZQ0Kb3JkZXIgb2YgYm9vdGlu
ZyBhIHRpbnkgVk0/IE1heWJlIHdlIGRvbid0IGtub3cgYW5kIHRoYXReIGlzIHRoZSBiZXN0IHdl
IGNhbiBkby4NCg==
