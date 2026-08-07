Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E543F4C2;
	Fri,  7 Aug 2026 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134400; cv=fail; b=e1pClH70kLVMNbNK4JAFM22XqNl/tBIetJnpwpBRMTRTZRsgfv3HIvJS4SPB1/r80b6K8eoQo5+9CkPsFNU2Ei4d1IhuUARt3v4TAEnyPc+qyxMfkJRa8cIE2WvwEG0Jp549CTgj3xZw1D+DDl0+B0NGeB///3yqx/m4TodZXxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134400; c=relaxed/simple;
	bh=2M4C+T8yGW4o6lWYw53poLg6raiYXwv0yVTfXuR4OFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+XMRhTNK94t8zGC0XTDsDlADZU4HdSsa/GSHrbiXKfwPgfyaHdLu47W/bDo/yow6YuPTiH7bCV8LwBAHUl//b8qf9dofmPwFdQ34SgV7F1JS2vwx1ZZJ91J5TNYcwTMBtS4ze+4CKDH6K9m+bz3vHijWJd5ie5Uafx7ZMw+FAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhIU94xR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhIU94xR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786134399; x=1817670399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2M4C+T8yGW4o6lWYw53poLg6raiYXwv0yVTfXuR4OFg=;
  b=NhIU94xREJEqAhGJiLHUyHz0d+VWQ4R51m7OPC1f+m2mZoMOI+CT651Q
   APsfxtj9d/xeDlhP5lTGlgaPs3PTXrwRUY4UKzQEHS/I7docJAyk6j4Kl
   tEv3EIrT4Dfjynsi5ZTWgufE+arD1daRkkTL4Ccm4hzWIPlwF7WHzNRtK
   iF0L8k/t81iiemWomsgqwfUaTxuHTXNJHuJQjzHMVtszGvqJ2hzN9awJZ
   JRV0pa2HPeIfkj3fMOYOx04q3m5AHr9T7D6oeRfloEsDWoD3oat6oeKA7
   YgBhjoTKIAeCZx5a1GDiGWXlcNvnkcgVX060RSb4dOcMg0/2uoWh/OykE
   Q==;
X-CSE-ConnectionGUID: QQUBkiWNSXWdb3cJb6B6tQ==
X-CSE-MsgGUID: dZdcp+oKQVejpYZIHXaQSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="97102584"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="97102584"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 13:26:38 -0700
X-CSE-ConnectionGUID: ZyZCkmwwTVuaKemy/D1Stw==
X-CSE-MsgGUID: QoUkeWvOQLqjqdvuB/eFpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="262529080"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 13:26:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 13:26:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 13:26:38 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 13:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCcF/yz9bCxLvop5AFmwHkLnE5TNjMNqXn9cCg65UaIwcYcEAiMYS6OFZnbk+ejEHqRtjccl896RAC3Gbmy2JDTROr030i3u5uyVD0/XAm2rA6G9Hs1UBHM5oOzMBlvMkvI1lsWYXjxEjF5TAup9xefz75sxK0vqxy/vZptSKEe0e9E6L/olgqtoLUnmSXt7+2hLcpcpCoZ+VVHPTHxYqKcaATBVWUggmQ4c+OfUaBFlQMc+VNgk2GLKc1M6NQehr8LmHcKhxU1mD0hwJF+aFETjQFCOFdIcZXjxfTmb4UDpqDnscu6+G4BK6YN/W72Aogug4/jTI24hRGDmM50cog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M4C+T8yGW4o6lWYw53poLg6raiYXwv0yVTfXuR4OFg=;
 b=HAoO5HQnL969bJKNhzOwEH3D1VDarPuxkEa58reCKzKX17Oln4WrOOUn77jWLOz9Zch1DywkgNAS+Nfq0Fue6wdzS8k4/BgXJmdepPRDfN1gCuy77HNIWwUNjkUoePjqImgDH+xcCiIQQr8y4dqXVs0qFbpLliCedwi9Q2ABhaa2Y+2wHcF7HqVQrVl/u8C4xaEdE83GnZbVetqEZQhCF0pLRDj1R/dXsUIaTesj5tUcN/rcHg0fDJKS5lbSNVGEbGQ9WHM7xQUR9ZeNMmc9aonaric3LdLv5vPTWBCdh5PHxFIUXHsaUJK0aRN4QJYirOkPNKlFi+72ofuJjMymSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB8719.namprd11.prod.outlook.com (2603:10b6:8:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 20:26:35 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 20:26:35 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Huang, Kai" <kai.huang@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
Thread-Topic: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
Thread-Index: AQHdJexJ+xgPRKIpBE2rBNksi9KIMbaTCjqA
Date: Fri, 7 Aug 2026 20:26:35 +0000
Message-ID: <a05089fa3c5aa0ec9cdbd88d8aefc7b9ffa77e0d.camel@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
	 <20260806214050.78058-3-seanjc@google.com>
In-Reply-To: <20260806214050.78058-3-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB8719:EE_
x-ms-office365-filtering-correlation-id: c1cdddad-3725-4752-5b68-08def4c22d47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: dfM+FdZlGdx/VsCuACmPcDKAMIz3hBZgcpWi6r5qb8VvGSLdFKKbvocoEUMKD3YAyNi1tN1XMbteqmZY2Wyzbd8HUdvCdGtkYHqhVAv6v2Jsr6EMAtK0fho+R3d/OlKnBH8vg/aOcpEFwry7mvMzX95bTCaJk9nVba3o/P02dSqDvG0AEtNv94cXBwF2Y4p7qHI7CsUeaHMWUqplP4hx6B8GSDxOIEvPEYNAOcbZlArHI297rtkXNlTpAYkPXKeCuyLsuJ6DgAwwHd907Ptjc8fWTn5TasEai2aFrHvNXRC4X0L0RO3pNcbA34iJZxbOfbVGKuHNOl4TO/gKYCZzSkmviBKDKM8LvQ1WrFmhVuwduNnMmx2sAFyPcUJWSyahLwxgRX0Z+b+VEUFL6oIB44lGdk66s4/IsR8eN3CSZyC0nRDhkUVq/Wt/l09mPPzmvnvlqHl3YE0JaPv44JoLP0B9OprYkRS5ghLl+J8+5F2yBg002fhT0sShu30Wx3L+tmMe8bZn5uB2jK7Y1sHzNppVKGw8uKK5epfr3xJHiDMgC9N2QxEwlAqoIGQ5Kr18vBJCgc00bYthUvEPzCpw0QQg9kMT0GBZqehKHn16SXkZ5s5ajU97NDCKSHewC9fnyn+l7fAmK3Hww8eK5M5o+KYXZJGi85F7nnWE017DQ259iWA3NM4X+6XDaYRyOyKhsFRlslZ9lnF+l3dZlSmBiQUG2iezv0UlAtAX29qrxtI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm1KZGlnelpReEpmVW0xYWkrdVRydmtuNjZ0TGpaUVZRc2dJc3JNLzliaTVk?=
 =?utf-8?B?VGlIdTJpUGl3VEp2eUNFU3hwdVQ2TlQ0MEV1Uyt3UEhuWXBmb1JzdnRWaEhO?=
 =?utf-8?B?TEVQSzBIRWoyVkU5ekF3WVlScnpqeFpzV3VmRTVGWloxSGh0QXJnelM3bitR?=
 =?utf-8?B?K2dNVmZjZW1WbUxuU051WTludGdGZ0xqemRrT2J0VXN5Y0MwcmFLQ05jMDVY?=
 =?utf-8?B?ZjlkZE8zOVNYMTgrcVhMaDVnejQ0bHFhWFM2ZnFZYmRWZ0NLNVVyRnNKVGtL?=
 =?utf-8?B?Z2g0OEV0TlBxakRORTMzdkhJZVJuaXdKa2t6OXJEcHZCaWZDTFBOWnI5Ylpz?=
 =?utf-8?B?dHdMUGRuZHY5MEM5MEEvdTFOQ3RLbitlaE9JMVRmY0VEZjB4dFExY0h6SkRx?=
 =?utf-8?B?dDFGY1pwWHlmeloxMzNSZXd0S0I0SjJ4YWRsekp5bnIyNzBqakg0MTFpMUg5?=
 =?utf-8?B?SzNZMkljTzBkVktGYnpmRktqVlJsWlhiT2c0VSt5azFiNEtoUVBManJzRm53?=
 =?utf-8?B?MWk2MmdWUmhSWlRSR21HN0NVa0c4eGJ6MHM4RmlBMW4vcW5KenhoRTNMeXNm?=
 =?utf-8?B?WlBqK2xlQ3FkK1hzREFPOGI4allMZjh1bjNwMTF4bzNOc3FlL2EyNmQxb0hJ?=
 =?utf-8?B?eHpWSkZGeUxGblRYekluVzhrZDNUQlNDSlI1Wjh2UVhoUjlLc1FjYlREa1V2?=
 =?utf-8?B?U0YycUs5QXppM2g1UHpwYzF0clRYcDBkdDFERkpQZUpyNWJWNis4RW5XaCtS?=
 =?utf-8?B?MHl5ek16c2xIanJzZUxyUDE5NC9pbEY3NGhoNVNvM1VreWZOMzZaUVVOUnpv?=
 =?utf-8?B?RWtkZ0xQbUc0TFdCWS9YQ2k2ZlQyOFlRaE5RZXpTTVFTcWJjRXBPajYzaE9y?=
 =?utf-8?B?cDU3S2xESTMrOWxUcVhRQjJrNHQzaVNFQ1ozcEs3dC83aWt0dUM1dS96cGVR?=
 =?utf-8?B?c1JvQnVwbi84VkVkbWJNS0FFVzdzMW81M05PTDBOV3JpSk1SSWc0anZ6ZXNQ?=
 =?utf-8?B?am5WMFkwZmtsMkF6d3hsVUttUzJUZ2pCY3dPVC90SDNNVGl3aC9xcXBvejla?=
 =?utf-8?B?M1JZUWJMVFlGdStMVmllQXRWdjRBSjYreDdYQW8wbTg0MVl4eXdNUnhHOUhX?=
 =?utf-8?B?dUwzUzR5bU5LdFEyQml6RXRjczU5TkdGbWlWL25hcFd0MVByS01yWFI2M2to?=
 =?utf-8?B?NlRaRXBPazhmQnVIY0FhL3IwN0Nha1VBVnp1cjVVQzJ0bVVZckdsK0c1OFFF?=
 =?utf-8?B?Tk1oeWptTEsxT21YaDM1aWo2ZXRNTWRGZ010Z0YzYkVLV2FyVlMxbFkycjJL?=
 =?utf-8?B?ZHR5UkJyaW9DV2RNaFFCbWx0S3hEMHZYTTFWWGNROFg4QWVuTCtxeWVwb2hh?=
 =?utf-8?B?TnJkeWFSKzNOQlBTUWJId1RMYlJlVUliNlU3K3ZlY3VwbDdFTGsxQlF2aGM0?=
 =?utf-8?B?RE5jNlJrbEV6RUdnK1JhN1ZYWlllZ0NSRHc4VXFxanN0VnhQbG9jaW5ZdzVa?=
 =?utf-8?B?bnpQdUtGT3ZMUldreU1ZSHhHb1JyZ3paUHprbXQ5S0N5MmdzVkpjWVgzWXI1?=
 =?utf-8?B?VkRMMXVvUmpSK1NlcWhTUzhuM056Ni9WT1dGUjdjaW1oR01OVFRiYzRDdE1x?=
 =?utf-8?B?enMzYWtEMEFkTUJIRWpYeTZmVzZza2V6UmpvMVUvSzExbkhNa09iRlJEcTV3?=
 =?utf-8?B?SXp3citEVVFiTTM3S1NZaGJJNmM4TkFaMXRoeE5nL2JQcUhZanFkZWp2Tkps?=
 =?utf-8?B?OXBHZDJkc2xKRXc2WXo3eHFjUEJ6eGJFOUhUOWNhR0pkU1VNR0lhaEtqL0p5?=
 =?utf-8?B?c1BIeVNqaHdJdVlnNGJ3OFJsdzdHYms5bGoyRzEzUk54ejltSi8zaXN4NHl3?=
 =?utf-8?B?Qk0xWWlZQ0tyVTd4eE05a1N1TkNWR04wVUVRRWxVQ1BiWW54ckpJb09RRDgx?=
 =?utf-8?B?dFlsVmtUWVIyRXFGd29PT3lXWGJDaXRyaTgzZ2FmUEpmZGcwd05ocngyeTlW?=
 =?utf-8?B?UVp1RnFWYnkwN3pEa01TY21HakdCTDQ5TnowMmd4eEhybGJKSVRxcUMrT1F2?=
 =?utf-8?B?ZWFkMnUwd3JiWHFBTTJ6SXY2TEY2VU1yWGt2YnJTUlpWd2VGWFA1Tk9PLy9X?=
 =?utf-8?B?RU81a0x1UzluYUJvWVJDMVljSXY0am81bjdLWlZ2WWhkSy9JZ21oNWc4cVNy?=
 =?utf-8?B?Sm4yVTdnaXZSNnUxaDdXbndYMWVMRkVadDRKWHY1eVRhUTRHV2ZEMXVyTG8x?=
 =?utf-8?B?bGE1a0JrZGVzZWZmNmpUb3dQaW8vcmZIVmQwMWsxcXFXRDBKdzZqUmJycHhy?=
 =?utf-8?B?NmdicWtHTE5OOUdyL0pFd3lpR3BybDlEakU2UEtDNUpUdjZ0SW04SVQ1WG5V?=
 =?utf-8?Q?jxbBYxQw2q4ZPrrs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBFE00C415F4A24484B5AF8F1211196A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CViRZplKTD5/DtU8LCKHucz85SDWXh1Fe3uIr4EdLVZadzl7wJYSutoSUldUgLggSpHoXue+RMy9qDUmcMdbxcdUJaeNyqtGY42bWMsN6IFGHCozl8M/l35sFmm5C4rw1+WD5kVSb5QUXjTl5kcwdHIbkTQXJZ3IsBHailqZYzNhg5ypFtmoFp5bF+302UIibK/e7BI83c/a0AnR++Tpkx6xeal74rHMhq0tDu3tVLooaRfcbtZdVxEKYl9s3t7PsXbhf2fyOIoeuN6Hmg6QNTq2s3de0p9b3AjkSDv6iQLjdYyyeXfIlI4PtthtF4k8ch8Qbw+oCW7W0EMsJHN3pg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cdddad-3725-4752-5b68-08def4c22d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 20:26:35.3301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPOvmE/YKhNZ9xqqgjdmxbK2D8zjJnN1pj6kRxKtjzgzqrUb9z53N+B9PxLrVvEGHmoITjZwCRqcmoZTKnjPZX9YavvVJM79h6sUvCzFvN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8719
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTA2IGF0IDE0OjQwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBAQCAtNTE5OSwxMCArNTE5NSwyMSBAQCBpbnQga3ZtX3RkcF9tbXVfbWFwX3ByaXZh
dGVfcGZuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuLCBrdm1fcGZuX3QgcGZuKQ0K
PiDCoAkJaWYgKGt2bV90ZXN0X3JlcXVlc3QoS1ZNX1JFUV9WTV9ERUFELCB2Y3B1KSkNCj4gwqAJ
CQlyZXR1cm4gLUVJTzsNCj4gwqANCj4gKwkJciA9IGt2bV9tbXVfcmVsb2FkKHZjcHUpOw0KPiAr
CQlpZiAocikNCj4gKwkJCXJldHVybiByOw0KPiArDQo+IMKgCQljb25kX3Jlc2NoZWQoKTsNCj4g
wqANCj4gwqAJCWd1YXJkKHJlYWRfbG9jaykoJmt2bS0+bW11X2xvY2spOw0KPiDCoA0KPiArCQkv
Kg0KPiArCQkgKiBCZWNhdXNlIHNsb3RzX2xvY2sgaXMgaGVsZCwgaXQgc2hvdWxkIGJlIGltcG9z
c2libGUgZm9yIHJvb3RzDQo+ICsJCSAqIHRvIGJlIGludmFsaWRhdGVkIGFmdGVyIHRoZSBpbml0
aWFsIE1NVSByZWxvYWQuwqAgV0FSTiwgYnV0DQo+ICsJCSAqIGNvbnRpbnVlIGFuZCByZS1yZWxv
YWQgdGhlIE1NVSB0byB0cnkgYW5kIGtlZXAgdGhlIFZNIGFsaXZlLg0KPiArCQkgKi8NCg0KSXQg
bWlnaHQgYmUgYSBsaXR0bGUgY29uZnVzaW5nIHdoZW4gbm8gTU1VIHJlbG9hZCBmb2xsb3dzIHRo
ZSBjb21tZW50LiBNYXliZQ0KbWVudGlvbiB0aGF0IHRoZSBNTVUgcmVsb2FkIGlzIGFib3ZlPyBF
aXRoZXIgd2F5IG9rIHRvIG1lLg0KDQo+ICsJCVdBUk5fT05fT05DRShrdm1fdGVzdF9yZXF1ZXN0
KEtWTV9SRVFfTU1VX0ZSRUVfT0JTT0xFVEVfUk9PVFMsIHZjcHUpKTsNCj4gKw0KPiDCoAkJciA9
IGt2bV90ZHBfbW11X21hcCh2Y3B1LCAmZmF1bHQpOw0KDQo=
