Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E542049F;
	Thu,  6 Aug 2026 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053387; cv=fail; b=sspJvst910fcDWlr6e9m1z1ORgpIGok/iVfLoIueYTG5+zGIFLbBOiOcIucqGNEWpE6V/LiUMhPJ6OOwyS5nror06MKz0N1osNV5f3zP8PKWHnCNuSiZJhpNjsa4zF9TUoBIx8O6guxJ2YtKHj+fzrfwnEo5Eo0oB2FeSyRj6mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053387; c=relaxed/simple;
	bh=BbvWo0b5GCNhs8bAEMrLU/wTpoqoJ+OZ/LjrP4f6xzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JcCCeWo1zs1nZ6UogYplaRnzjmfLIkmMgagzbL87oUhD8n4lbe3ekxttSmkmVQkX+3H3rXFvScMs9sFNJStUGF9vMt1vThVtryA4y3Yr8qDu4gq2yrdZkMP3R+csxEHW0wbpZ1MfE4jUBf9O3mgKQULITiggOG5XER2IH3hj+08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkE8MiIn; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkE8MiIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786053386; x=1817589386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BbvWo0b5GCNhs8bAEMrLU/wTpoqoJ+OZ/LjrP4f6xzY=;
  b=YkE8MiInqCIRZAEe03i5EzIf1VLYkPVfOOaI/ujrD76ljrwaYhiVYTsz
   2/mfXqJxCz3QkJ+7hkSk4HfyjmohDSBo8RcLZgLPlpvMfi41PLBlvsizq
   f/86ofTW8/rY1s8fLgYVYriMCuljpUcb03AmKTg0W6dWZPHkVmU+bxxaH
   nyHE3FupdWQJwXg2eMH4IEY/CPsu76SrEBtH1K+nzLpmo6AFeVlvpH4SD
   3gFx91L237tb00w22dF/SqPE4VnjwW/sPhNQ4f6RRITSY1Mb4wpV9szeQ
   m2mfALEKrlX3dxSExFBGV9BFpmeZCb/P3JDnelqtKWEzJk+xmteUYgL5P
   g==;
X-CSE-ConnectionGUID: 6oPl1WTvQW+aAJaMZFq6JA==
X-CSE-MsgGUID: TAk0I97dRtOR4fV1gOHSuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74200594"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="74200594"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:56:25 -0700
X-CSE-ConnectionGUID: h7Eks8fjTCOk5YWeGa3j/A==
X-CSE-MsgGUID: be1Yz140RiymBlI+uH9QEw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:56:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 14:56:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 14:56:24 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 14:56:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZn0Wii5taw4PlEtV6348TMKpuZrz5BkGKjnsHoT5N1ELvGATaKN+eG1WEsd+bUJjlVlcVMjdPaABFq4HZtfHwGTXNsrZpUmOxLqIA6YUnINtq+a5SpjB3YP2SE5KrVKcbQ8hNqidIC/g1t3AIyVLgRcrH8Y/69RbUqcyp5dBzIVJ6YszwpsIAxosvgyHB+xlw83LVy4KD5pK+G2uuJnhZhlm2syVIrBgiAsDk4+yxMrV6AdQ1KJOWbevDi8qUeQkND+GyYS62KiGHVFtN7GHhYzVnRu6d5PF58M/rwmuJ0rmDLek/vx6iMQcqi3bYngOA/e3owtV9wJm1daOHnRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbvWo0b5GCNhs8bAEMrLU/wTpoqoJ+OZ/LjrP4f6xzY=;
 b=abtTZhh0yVwy7nQG1/ftkSTKtmfznQ/CAn/kx0+tzR8HdsqBZ+yn3imtmBzDIuGQHMZf6EDWJLSyTwOrDXcLHV+nl6b3zhdkoBBtzZ7GR8zsE0Nh3GNVVewgHFmBas5ZaVmMsmcIDfh0f/AF2+YgiaYdHj25neYPSwtnkDqb/cZjTWus33A3841uy60SdVQb484STro3S3etPZEURB2PmURolIrN5OnwznYWbsqH474KqxuwHM+syutE4g1ibfjD8AWftAP/BolIOinqbvbdCfXZiU6EBIbybAOz/Rg89dw4ffBrywBZca1oTS/n6DmCmkV6s3upIY+QB9+eiGj0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB9471.namprd11.prod.outlook.com (2603:10b6:208:5b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 21:56:21 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 21:56:21 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"hongyu.ning@linux.intel.com" <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH v9 04/11] x86/virt/tdx: Allocate refcounts for Dynamic
 PAMT memory
Thread-Topic: [PATCH v9 04/11] x86/virt/tdx: Allocate refcounts for Dynamic
 PAMT memory
Thread-Index: AQHdJUiSpW9IcQOPSkW3F2w8Am0TyLaRgaIAgAAQoAA=
Date: Thu, 6 Aug 2026 21:56:21 +0000
Message-ID: <df633fc4febec35a378fc2e32ecd5c78a421f686.camel@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
	 <20260806020850.1221381-5-rick.p.edgecombe@intel.com>
	 <73c0e29f-3164-4294-a18b-0e07bb958d17@intel.com>
In-Reply-To: <73c0e29f-3164-4294-a18b-0e07bb958d17@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB9471:EE_
x-ms-office365-filtering-correlation-id: f28f1777-ce90-4ecf-8c9e-08def4058d20
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|18002099003|22082099003|921020|10067099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: A/N6cpY8G124nB4lySmR30dtCjD8x1G9VqWcc/8U6qRnPXJ6pA+TkovBi9ta/yyG0ZPkLcog6ZFfnFfh4q8wkM9tQR7N66zS/VVHtZ71M0p+eQ594WDXMoCNhrajNj92E3kfG9J0YNZgOJSNjtd72RwQanhWsEExRqWnUL+J9FDLlv2vJahU9CFmbdcv0HaL5Vl0hFfcmKhl/YtYTZOK7OTFn8Ma3ARERsxiuDVbZmXjKk2AU7SnXeVI3VgH8jF16PaDrbE2BSK71od8akJa5sqmhidh6MWKisHfX3fgUiYw3CIk3YADH7TVS8BIvPYrp41aZs5rh2VM0EF03oZY8WS/zCUSR8XZmyGv+jYEabfzlh/YuMW8mFt0lwwh9nc73C1hNBokNFIh+wFBY+bUGt2yJdHOSVYF7JkZEE0DDJEZgw+2tTtPY2W4evjZtg1IMci9SPm9zjskJ94zDpsmBWKA5sOP/xAouZZgm1Helq3PDWPotUahWSpw08VD4bchUoyy5xZRvXJL7DWJva/6/nemhavCjCB7DEOqvVolSpZ/n24wiDKJRzBn2WJnb9MKrf0lNzlSdZN/10/cG/8ZX46Xk7n/f76OcLh0G9x+ralnX8VgUvpfw/271g/o1fqboKTYhefayTvi4Ez2FdvQXlw1R1KCWQK+20X8BT/6gCWoMjjZFgfdTY9A3cHaV+CQZjcCLAnAMtGsEDjGMgtO4Uwgi/SQwMj0jat4fA1fVg4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azB3VjF0QTdpLythT2RJUGZaeWRWN2F2aTFBbWhjRDRabkxxQ0F4NzkxellL?=
 =?utf-8?B?YmVzUVpkdEMzMTIyRUdQeWpwcVVWUmN4Z1J4dHE5MXd1QUN1Y1Q1NnZBRENz?=
 =?utf-8?B?bVRZY0c5TmxCY0lNWjhndFpXaTR5OXZ5OGp3OWxUdHViTmlya1VONWhoUHpy?=
 =?utf-8?B?L2Z4amNSQ2J5ZXEwR0wxdW9ERUlia29ibm1oNXpxdnlOZGd5dVcwZG9zMFR6?=
 =?utf-8?B?dkp2VXhBQmhzMlNUL1VmZWxzUVBiaDE1cVRTUE12amRSdG9mYkM5NU4vd1B3?=
 =?utf-8?B?WVprUysydEc1Q2RlMm9BYTM4S0NoM1pUMG1XU2FTWTRYM1NyZFFhdjBTcksv?=
 =?utf-8?B?cS9xc3E2SVpWOFFWL2xkQTd1OWVhNmFkWHFmSzdwby9Zb0ptTzJUVGxabG56?=
 =?utf-8?B?YXJWMVpsVXZoOFVWamdWa2svdGhpUy9zcnNnNDlUN3ZRVTJFVGtYWXBja2VY?=
 =?utf-8?B?a3RNZzFHbzNWL2wxVndtbnFhUHpEYWpTMDM0R2RFVERwWUhZL2FZNi9NcVFZ?=
 =?utf-8?B?RE85MVNkbEtzcDdoTmg5VjcxRHZkR2NxYlV5UTNWQngvUXUvUVRyYXhGRVJq?=
 =?utf-8?B?VGFnZkpENUhLWGRiZ04xdUV0R0RlM3MrVE4vWXJqZkh3MjYrVmRjOVNWemov?=
 =?utf-8?B?dTRKLzZlc3ZJQkovZ1U1eVdqa3FaNC9vUDJXc1h6S0RtSVJXczBubkx5WnBI?=
 =?utf-8?B?TmFtQkkrbXpFNXBicDVnNnNRWnN4VEJ1Vm5JMTVCODU0Y2UxMVgzei9TVmcr?=
 =?utf-8?B?bmxWdld5WG1CcE5tYS90a2xKSy9IY0pmRHhCNHNDWWVlTklTRWx0NlNURTlJ?=
 =?utf-8?B?dGRKYkF6MDNFb1cxUExBa1djS01rRXUyajlXUXBPV0xJeExVZHF4S1B6MUJJ?=
 =?utf-8?B?NHl1Wml4OEpDcDFQSmt0TUlrOWVCOVE5OEZCNDZqVkcwSGFhYUthMXppNFh2?=
 =?utf-8?B?SVJxNkJ5c0pPRUIweFBUTXN1V3JySmlON2pBRVIxcEtSY3NpcTZvSWZYMitE?=
 =?utf-8?B?VnpyM0ptZVl1dUJzeDk5a1RzZndUNDFJc2lvL3VaUzkxclhqMEdXZmxSVlQ4?=
 =?utf-8?B?enhndGo4K2lPUEhqZ3BqZDNic3lnbVk5L0FzeVhFbzduL0RUOWRIRHdLMXRR?=
 =?utf-8?B?Wm9LaHl6SDhvbUcxbktlMzlSRE5NMDVKMFptRmUzbGZ6ZW1qUE5sWTA0anF1?=
 =?utf-8?B?aVlCdVJ1d0JLK254QzhjbWU1b1h4THVyTG9ZUllCckRYbEd1N0lWN3NCMkxn?=
 =?utf-8?B?OWwyKzQwYnRuWDJzazA4TGs1eUI5OXFXOFBtZ2FnTFVVb2lESEVnMEdGWjZi?=
 =?utf-8?B?QjhpcW5kU1pYR05TWTBZZi9xUWt6cXhxTThzZjVPaW9NT2M0R1JVS1BrMmtI?=
 =?utf-8?B?L2hmMnRBRlVvTmw5aDU4UGtFSjdDV3NMWGFjU1V3czhmdS9OQ3pQa3lkSzNa?=
 =?utf-8?B?MDdpNEhDK0lFcTF5TGd2dTJTTCtSejFkRmdUQ3ZNcDlhZHV5WGRFLytubDEw?=
 =?utf-8?B?SGhiM2M3VkFtOW8wTTE2R3lCSXhXZkU3TFp3Qk5raE9URUVKcmtTQ1N6NkRB?=
 =?utf-8?B?RmJ4emtKREF3eGRQemVIQzhVNUE5T0xCd3ZGK0YxUXlwRUNiTnRvVjBTWFZC?=
 =?utf-8?B?WGc3RG5oZFRCVXhSNnhGcVVzL1NMRVdwUmU3L2ZUZ290WlhkbGYrRHNKeFcy?=
 =?utf-8?B?Zm1mS3ZRalJqUThVMWZWc2oxamgrRDZtYWJKU2Z2ME4yOUdZMUNFa2psM0pl?=
 =?utf-8?B?dVlVdURxem5JS1RxZnRYVlYvM0I2YkVQSjVIM1IzN0RJbUJWb0lON0hpajhM?=
 =?utf-8?B?U3UrY1g0WGtvY1BlSHV2Wnlic1VnYmNrU1o3QzU1aDRWT2JkeTNPNUwxS09h?=
 =?utf-8?B?TlE1WkVGUmhBU3JOcVJWSnp2SW5YYmY3N2xGZVJFMGUxMzJxeWJiT3Nad0dU?=
 =?utf-8?B?cWp1Z3VYbUJ4cGxxNFRDd1BvSEZIL0IyaytVS0JaNm5LMmdWWmRtMUNhSFdt?=
 =?utf-8?B?QloyK3NhZ0prQmF2cDVTc2FmZk9yMlk4bHF1SmF2TXZ4bENpSlp6Vjdtb3N1?=
 =?utf-8?B?ZEJ3RkNTei9TQzJXbFRRU0ZQTWJ2bGpkSlE4SElOWjZHREFKOWdHdWxkbjda?=
 =?utf-8?B?Nko0djlQMFV1S1BwUVdKK3lKNEtSR1BVN05uMTBQSXBSUkJyUHdFYi9aSlhI?=
 =?utf-8?B?SmlmZmxpbHVvVDErb3pGS1NzWkxZVzcyMVA2ZFRRZHI3WlFib2JJWkZicGwy?=
 =?utf-8?B?T2c1dTUzdVoyTHBmNGoyODFLQUVhaEpGZXUrekVRWXYvbDJMTmdaVlA2V1NW?=
 =?utf-8?B?ZGdxb0JmdjRwcS9ETTNwVGpiKzkveTJHK0VBZitHMkFseTA4T3NOU2RmQzF1?=
 =?utf-8?Q?1M1Dg0NewD0HlkoM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <367E610AA57AA349AEFCB0AE90DE83A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: avcPe9ZUI3t9MElcBLixzl7turZ0lKWwvsVt5qAomt/bGy+yiTfZ+QZ/AgRoS2SvRovjIf3F9LTAQd1EGO5QOAMpphpSc60DSc4Swqsod2xx6pgb4BhUX9kk9clmJs7xorKK9VzRQ/tif3lHo0Pidy65p8zIgLCeNeHch86Xwi36xaK6kEaf0+2tlI/nqFRzi2bspAAZxUjUzNAvVogvwVe14cSSYfuMZSN5OY4Mwl0GSQivpINsGEUYDZPjIevIjeHmKMOsBF7976ILvYdO1LisIWoujy3evnuSeU1cAUWKGoC8Z0QGn5/RfhCP11dnuuGbxgqtYnM+UArIiMNPlw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28f1777-ce90-4ecf-8c9e-08def4058d20
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 21:56:21.2776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwju92tZGx3OdyoVEiRBsXIgnTHWcw0sCXpObt7ETh/PA4+uKlQYvDuGX7Lwlzw8WFj0X5CjuJpALozCl4pqxnPCW4qkeIByhGT6E0GLa1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9471
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTA2IGF0IDEzOjU2IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOC81LzI2IDE5OjA4LCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiArICogQWxsb2NhdGUg
UEFNVCByZWZlcmVuY2UgY291bnRlcnMgZm9yIGFsbCBwaHlzaWNhbCBtZW1vcnkuDQo+IA0KPiBO
aXQgZm9yIGFsbCBvZiB0aGVzZTogVGhpcyBoYXMgKlpFUk8qIHRvIGRvIHdpdGggdGhlICJQQU1U
Iiwgd2hpY2ggaXMgYW4NCj4gYW5jaWVudCBURFggY29uY2VwdC4gVGhpcyBuZXcgZ3VuayBpcyAx
MDAlIGZvciAqZHluYW1pYyogUEFNVC4NCj4gDQo+IENvdWxkIHdlIHBsZWFzZSBiZSBjbGVhciBh
Ym91dCB0aGF0IHVuaXZlcnNhbGx5Pw0KPiANCj4gSSB0aGluayBqdXN0IHNheWluZyAiRFBBTVQi
IGluIG1vc3QgY2FzZXMgdGhpcyBzYXlzICJQQU1UIiB3aWxsIGhlbHAuDQoNCk9rLCBJJ2xsIHN0
YW5kYXJkaXplIG9uIERQQU1ULiBJIHdhcyBwcmV2aW91c2x5IHRyeWluZyB0byBzdGFuZGFyZGl6
ZSBvbg0KIkR5bmFtaWMgUEFNVCIgc3BlbGxlZCBvdXQgYW5kIG1pc3NlZCB0aGlzIG9uZSBiZWNh
dXNlIGl0IHdhcyBQQU1ULg0KDQpTbyBJJ2xsIGRvIHRoZSBmaXJzdCByZWZlcmVuY2UgaW4gdGhl
IGxvZ3MgYXMgIkR5bmFtaWMgUEFNVCAoRFBBTVQpIiBhbmQgaW4gdGhlDQpjb2RlIGp1c3QgRFBB
TVQuDQo=
