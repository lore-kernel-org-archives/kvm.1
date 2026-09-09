Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA27423794;
	Wed,  9 Sep 2026 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788995889; cv=fail; b=ZC0MOWWGojLFYOTU2bjSBzi8Tp1ohW5u63/+hXhQ73Cpq8DIqWTSvN83iwIepmqyn57u+coVQkOepzDLTCJyrB8WgBs9EUturTxgZX8w6UYFSQ0Ixhjg4IM3kti1IXLgpgUXpIQ67KcQIGgQ1EopcjjEJ9/KaEknebLRqJGH/s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788995889; c=relaxed/simple;
	bh=A/HpcYWnyyK8aBGUmNUjKO7zH3KLUettg6zzSKVcP6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j4jaPxRn+zUdBeCFvKhfJMqzwwmUnBYBgtWSqxSDtz/nyoDlkNOPc7PUiDvQFpuAKqU5vUOaw6yyD/eGnWxPYpzWa69b44xctDYp/TTbgmiAAVydj630YGLg8cfb+Bo9ckfqQ0QKhEwF15AEP9oNfIzTEKdu4QQxSeekQnbf3SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uj89Wu+V; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uj89Wu+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788995886; x=1820531886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A/HpcYWnyyK8aBGUmNUjKO7zH3KLUettg6zzSKVcP6Y=;
  b=Uj89Wu+VYMl1Agh4P6ZSjRHqWJ/pjZOjicBFcbAR7saHAM8qE0LqLaxG
   Uf6oKazQCPm3PmiNe95l7CM3rmu/y4HpntaWKm3v6mTNfMH8Hsyua3Z7F
   0+cLjYEoizbAV4wwUhfjj93Xr3gRBFcUrlYZkdTgSAQyY+V/5P5PuTb8i
   QhCIJOfhbE0GwG31IcYmmtIbmb8t2B7HC5VKseJ4LXDooMjUEz58tYZy9
   pPBGijFEpgFjPXM/rxyCC9TFDYObKNivLws+XYzEROh3sN0v5rMefbUug
   McNouwvG9CJSUxr1wCPrUPF3VJlgnLVqTGvWMQx4VS5ykHujy/v1sOgr9
   w==;
X-CSE-ConnectionGUID: mGWAnpUNS1+Js/BRvq2BDg==
X-CSE-MsgGUID: a/hQlNgdRuShnYFfjPKEyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106951024"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="106951024"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 16:18:06 -0700
X-CSE-ConnectionGUID: hurSV0/lRhaiwXB87z6WYA==
X-CSE-MsgGUID: JjWad5RRQjy6jM7ghSogig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="301367770"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 16:18:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 16:18:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 16:18:04 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 16:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLAKVhinxt3tb+L1c9aWQYeSnk5CJT3f6ShQyfa3LxfBYEAgVRjOTrHFvfZ657hq4ocxA/0KiyqAOrSvSSgLDwUJhWzvtsu959Q3UUY2TwNtORENFfiMjBvMWQy+bbrW6WuZiBkDmOaqy2/cC8VMFQy0+Ld+nutOpWgIe6/16ObfKUSu8vb9ca5C10+i4nq/ZICsh1guY+aZ66XeP+LhNuf9pyj3y5kj1rK2dZlR9l/J4cS3OiCUxsK60Pl9EHCPZVpIFOKc/aClr9ztjwScei218mt8u6FBXFiYLjxURD/EwOb9PRRazWsj6x4D7c+HpvqIiGh7jDDWlul/k3rUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/HpcYWnyyK8aBGUmNUjKO7zH3KLUettg6zzSKVcP6Y=;
 b=p53B0CMRjjOyID8Q0fzouyin0nIcp3Nnkb/4uNIJwxh4ycRukjWTjUU9juCDBh+WdFd2nq8VUJ5HY+DQDSh6SCzOunPFNcSe882SoVN/Lxb56ZAqZ11+M5cvdM/YFBR3VmAVCMY7xC8pg9hcxAa7jgvw7ABIAfXgSukiprFv8cQoopcxMCloUjNUtFcbLvhaPTBoxyLvFnFh7te/CdDaie3HUfgg8OchM956/Zv1skShyZA02UAb1fhJOMiLPXZ64IaNR9svYDh7fcBOKAxIm2KQ8pS22M7TdW95V1JhjqjzIzeZ5rke07dyWdVQdf+SeB+4DqKVx1QBx9jdZEG/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH8PR11MB9507.namprd11.prod.outlook.com (2603:10b6:610:2bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 23:18:02 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 23:18:02 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdNdIg5EuCH7XFUE6a3Q+aSzpVqra50omAgACnLQCAAPSngIAAE6YAgAD+CICACMIfgIABRb2AgABhxwCAAA2YgA==
Date: Wed, 9 Sep 2026 23:18:02 +0000
Message-ID: <c967dc3eb6b128055e415bae45d1c14a52dc4acd.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
	 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
	 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
	 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
	 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
	 <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
	 <d8012e9acbe3c733b082c87fdbe9f229a8f7750c.camel@intel.com>
	 <9abeed40-bcdc-48d9-8cbb-cb87154bb9f6@intel.com>
	 <aqHdwkOFVR4XoS2M@google.com>
In-Reply-To: <aqHdwkOFVR4XoS2M@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH8PR11MB9507:EE_
x-ms-office365-filtering-correlation-id: 30073888-0c7d-456b-29a2-08df0ec898b9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 9xzLWsxAUW+saKdAN7kMXQRk9vEQxf8yWvliqftF4vB86Xv7ZF2SZN9hCNMIvmk3c/qUzza454bu43oBDAp6kY5y9IKoG2Wb+befi1NKZGFPNyzgVxVss0BX30O48b9JlYUqhJ3+wPvApjKlPNLEPkknqjO5CaBwxWI6ULWNycl96sdmADSlT9M9aCc7bTRKgDtK+x1tDegeS+xlkrV0GofpgdUWIy009LoaPSA1u8u6PmgPdAAL8HqWo1A3qEza3Vo+FgbnPbrx2+uyge8oxZ2MPhIjoWpM4WTED2qx4boYPN8a8CEJ/EpxuUnwtC0MhEZDQRLT3iqBTRi07qbqoB+zBk2GBLCRQ01q81M2iAXJXjYlZqg+OFN52sJ8VcU56CijjrD6CivvpzS9PS9Py7/ul+n+QMwM1EkgSsfk9V+kjNJ8/h4VdDduCdqqf0VuZ6LhVfwWX8klYAgQ6Eo6niTTlLB+Qbu1WLrehzb8YRxDcxbT/lCngKoVJ+oKH9smd2au0pgFMCZ/UkNoVSCF00BPNUM4ROCvC0fwtH7gq0KakgCTpJZumUdIAWcfy8mG0lwng4Z84zZzVfJOO5LM6jy+GCYCTQxloua/xKz1ZaSQaRSenXOBJ7+qB9lgUk5qZfrvPJjgAJ8DpMJmEld90J77dW5rclDTWbbmBqF4M06Si1M6j2aYuEat51nO6+I5JzwvAHSNW1zFNHOxCmvzCI9CwYCocA1fZq+UMg3QwV4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnBFanNicXBZczNRTkJUUk16MkxUNFNLY2hDM2c1Y3ZxSUpndExkbS9FZHh1?=
 =?utf-8?B?Q0ZNRkdVMUhyZ3hUc1RZMEt6UVh6UU9XQmlWeUJaaUJlV2tKRmh5UUZxZjgw?=
 =?utf-8?B?c3JlazhMUFBSNDd6YWNmeHFTYlRwUXBwT25uWHBxbmVxVHBCbC9LeGZyNGFY?=
 =?utf-8?B?OFRSNmh6K3B1S2JSNC83dkVzbVFJTmxiYUljUDVOUDh6UG02dWlCTnBIYUlp?=
 =?utf-8?B?MlJJOXd0b09zTXE1THpoOGtudFpYeGh1TldSWFNhcDZ6M0IvTk1Qb2k4eXZo?=
 =?utf-8?B?dUxFWkZVYTkrV3JNak9WYlJKa0pUWnZ3bTVtVVdCM25RWUtsVklvdGgvSElN?=
 =?utf-8?B?Yi83bXliWDJmY3p4UlZsclA4Z285ODMwUVRxOW9zeWlRckljeDNuVlFOeFlo?=
 =?utf-8?B?RUxaT1ZhSlpUTm9YRjB4SU5TcGhucUoydUNBNjc5T3VsWjNJanZCTHYycTdZ?=
 =?utf-8?B?MWYrV2ZhSHpkK1hydXl1T05PZzU4M0J4VDVNdGpRWFVHQW1zY1NzakcyejRU?=
 =?utf-8?B?c3RFTVlTVHF0Ky9CbFJ3NjlqQ0J3Zlk4eXRFSEozRmc4ZEpLOENDU1JoZXVV?=
 =?utf-8?B?d3A3VGV3SFArN2FsWFhBR29odlpDL1BJL3hCbDNDTFArTGNOeDI4NVgyQ21y?=
 =?utf-8?B?TWE0ZWx6YmF4STd3NkJ2Tmh2dzhzNzNSZFQ0bFF5VE9IVVFuSkxZUW1tZEFI?=
 =?utf-8?B?VmlxdzdFdWd6OFY4UVBWZUk1VVlzQ3ByY1NQRExUK2lFRUtpR2hWMXpJREF4?=
 =?utf-8?B?SlNWUFMrbjlhemwyNWw2TWluRjNmQUZjemgvb3FrWWpwNTU2aHdPRmh3SnQw?=
 =?utf-8?B?TGNKcTdFNGhKMmNoaUZaemlISXVXSzdpaXJKcWh1YnBpZWl1L3E2Y081RXJX?=
 =?utf-8?B?T1lnSnJ6RXdtdkRUbWhtR1Q5VmI0RVczeWExOHJ0R2lOdmJXWW5DdjJtdFpF?=
 =?utf-8?B?ZnE1RHRWdmNsTVh2SEU4NzFuc0FUV01KVGJqcGphUXgwVlhPb3QrUFlKQlJu?=
 =?utf-8?B?NE5KQ2N0RmdFd2sxak1vZHo0QXk3eVc1U1VLTWFmSisvWGpHaGVaUlVFNUdF?=
 =?utf-8?B?QkUxcmdDbUE4V3lBajcvb1NpN00wNWZYeW9YMklBckFseUVMU3R0VlBveEhE?=
 =?utf-8?B?bFBhVnlwZkxzRWo3UWVJc3BVNW8vcTdScjlZT3FDUjF1TTMvMXFXSXdRMlFF?=
 =?utf-8?B?MHNrTzhCWkcrMk1VaVIyS1FkUjdhUENZTHgvQ0V1eXh5SUd6ZU1ySlk0UTVq?=
 =?utf-8?B?dE5EMjFHR2pWZ25JZXg1enBVSWFZL2c0RkJ6b1p2MklCbGl6YnY5SWl2SEg0?=
 =?utf-8?B?TDh5d0JqUWE1bThOWDNwQTFKVTk4aE9WZzhtTExLQ0FkdVo4RGJVUFRWWmNP?=
 =?utf-8?B?YUFLVFdxNzZNOTYvaUNxaExkRDhBeFExVXdzVENCTlgrU3Iwb3VPL0FJTWhI?=
 =?utf-8?B?SjhkQlU4c3U0SzRZMmFiYi9oMnhaOGRNOEd1alZXUFVGaDZjNTBWdGtEa1Va?=
 =?utf-8?B?ZWtzRmhjUlRYZlFmM3l3SU9NNzNoTUJBcW51VjdjMGpKZ25xRnZrMFhSSFVy?=
 =?utf-8?B?b3BNWXlnQk1iWU0weEN1OW1uT2UzOHY4WXZHTC9kRTFaK2p2RUpNaC9qWUFE?=
 =?utf-8?B?Zkd4QmRwZkYydGJtWnYwdWVmMklQVWhIQWt4WVIrMTkyUFBtUkljRXN6alQz?=
 =?utf-8?B?TW9TbXljdS8xdXJBZDZRNXN4MFpHaFBRUDV6Zy9BelZLREgwNHNsQ2hwSk02?=
 =?utf-8?B?aGExYkE0NmExbjVBejA3VnZJMlpla010VFFxbHo4YXVFNnc3M1RGTVZkY1JL?=
 =?utf-8?B?UG1zdGU4Sng4T0NqNEJXMjBhQ3B1OUppOVNzbmN4UlhSWUI3TzQ3Q1lFRjhE?=
 =?utf-8?B?MXFNRVlVVWJZVVRxRTFRM3ZKemVxZnh4MDZiTGdlVWRPOFlETy9CNGJacXYz?=
 =?utf-8?B?YjZMRHFlVDBEeURieWJBK0s4TklObEIrNEh5a3lxZnhtY08wVUxYeEFneExv?=
 =?utf-8?B?cDRYLyt3WXRuZTZKdzhCcUJleEUycVZDZ0pDVDl3RFNSNWw5cktHSVU1eVFa?=
 =?utf-8?B?UEhDdGFKSkYyM3dlcHpJdXNLSXcxUXBuTzJkSTFGekYzZGNZTm9QN3grNDB3?=
 =?utf-8?B?UzFhR1YyeWJaaURDVnRXQXYrdTVhczM0dHk5QVorZm1ZNS9qZmN0Q002ekIv?=
 =?utf-8?B?cGVhWEE5bGRQUUxaRkJwY1NNRnc4bEgrd0ovdEU1bFU1b2hHeEtnTFFvd28v?=
 =?utf-8?B?YldKT0pDY1NUb2dwaGp2ZnUvYXhVcGhoQVUwV2huaGlNT241RnZlL0JvTklP?=
 =?utf-8?B?YWowZVFqZHI0d2FsZGgrakpxdk1OUk5ybzZZVHRyakRzZ3RaY2xXT1VkbzdW?=
 =?utf-8?Q?Bvug0ndjfUglG2Lc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78B9BD3391898B4CAB18E1B4D2C927F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZHAeUYAltyWMYQjqp7410/3LcYTN9hN+C2Zipa7QMUI0gQ3OKm94UeOHzQ1/fr1RZuXu1Qd00Cvdxjw6DRHVvbdKpKyzZ8uMiyhwzAVHE5OEKAA2seh4vR/KThtR1FwJl0XpvHiWpdB5l1QK/F0BaUkgY+tkjM6EqOWN77YrqMVpCIHdDgMz5030P5kUEqRZ01v5aEv4bSRqQmvALFpb1Jj5qVBOBvRNLQvegpfVnlyy3c1TwzLLPzrc8K9OHQYGj/eRlQaLV7xvpO4o6AfCy1uAvJ0x3DCGhfPW/xHqiU2hFKEkemcfF5onuZwtd5H3CEfqxxE5CCM2yTiCzizlcA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30073888-0c7d-456b-29a2-08df0ec898b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 23:18:02.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41H6sTh3E5dQzCmadloayOBo8JqStz3nCt78RnlZwFydfRxCMD9yfF+zkFIQVK5EkIpC9J9qJ7G/qOVABPFlG9VLQK/fQ4kqFObem5IXWJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9507
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTA5IGF0IDE1OjI5IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBFaCwgSSdtIHdpdGggWGlhb3lhby4NCg0KSSdtIG5vdCBzdXJlIHdoYXQgdGhlIGRp
c2FncmVlbWVudCBpcyBhY3R1YWxseS4gTm8gb25lIGlzIHNheWluZyAqbmV2ZXIqIFREDQpmaXJz
dCBJIHRoaW5rPyBFdmVyeW9uZSBhZ3JlZXMgaXQgaXMgaWRlYWwgdG8gc29sdmUgbm9ybWFsIFZN
cyBiZWZvcmUgc2V0dGxpbmcNCnRoZSBURFggYmVoYXZpb3IuDQoNCj4gwqAgWWVhaCwgKmlkZWFs
bHkqIHdlJ2QgbWFnaWNhbGx5IGVuYWJsZSBldmVyeXRoaW5nIGV2ZXJ5d2hlcmUgYWxsIGF0IG9u
Y2UuwqAgSW4NCj4gcmVhbGl0eSwgZGlmZmVyZW50IFZNIHR5cGVzIGFyZSBnb2luZyB0byBzdXBw
b3J0IGZlYXR1cmVzIGF0IGRpZmZlcmVudCB0aW1lcy7CoA0KPiBNb3JlIGltcG9ydGFudGx5LCBh
cyBYaWFveWFvIHBvaW50cyBvdXQgYmVsb3cgaW4gIzEsIHVubGVzcyB3ZSBlbmFibGUNCj4gZXZl
cnl0aW5nIGluIGEgc2luZ2xlIHBhdGNoLCB3aGljaCBpcyBwcm9iYWJseSBhIHRlcnJpYmxlIGlk
ZWEgaW4gbW9zdCBjYXNlcywNCj4gd2UnbGwgc3RpbGwgZW5kIHVwIHdpdGggc3RhZ2VkL3Byb2dy
ZXNzaXZlIGVuYWJsaW5nLCBpLmUuIHdlIHN0aWxsIG5lZWQgdG8NCj4gaGF2ZSBwYXRjaGVzIHRo
YXQgc2VsZWN0aXZlbHkgZW5hYmxlIGFuZCBhZHZlcnRpc2UgYSBmZWF0dXJlIG9ubHkgZm9yIHRo
ZSBWTQ0KPiB0eXBlcyB0aGF0IGFjdHVhbGx5IHN1cHBvcnQgdGhlIGZlYXR1cmUuDQo+IA0KPiBU
aGlzIGlzIGFsbCBxdWl0ZSBzaW1pbGFyIHRvIEludGVsIGFuZCBBTUQgZmVhdHVyZSBlbmFibGlu
ZyBiZWluZyBkb25lIGF0DQo+IGRpZmZlcmVudCB0aW1lcy7CoCBUaGUgYmlnZ2VzdCBkaWZmZXJl
bmNlIGlzIHRoYXQgSW50ZWwgYW5kIEFNRCBhcmUgbXV0dWFsbHkNCj4gZXhjbHVzaXZlIGFuZCBz
byBLVk1fR0VUX1NVUFBPUlRFRF9DUFVJRCBhbHdheXMgcmVwb3J0cyB0aGUgY29ycmVjdA0KPiBp
bmZvcm1hdGlvbiwgYnV0IFREWCBhbHJlYWR5IHByb3ZpZGVzIEtWTV9URFhfQ0FQQUJJTElUSUVT
LCBzbyBBRkFJQ1Qgd2Ugc3RpbGwNCj4gZ2V0IGFjY3VyYXRlIHJlcG9ydGluZyBmb3IgVERYLCBq
dXN0IGluIGEgc2xpZ2h0bHkgZGlmZmVyZW50IHdheS4NCg0KSSB0aGluayB0aGlzIGFjdHVhbGx5
IHN1cmZhY2VzIGFub3RoZXIgcHJvYmxlbSB3aXRoIFRELWZpcnN0IGVuYWJsaW5nLg0KS1ZNX1RE
WF9DQVBBQklMSVRJRVMgb25seSByZXR1cm5zIHRoZSBkaXJlY3RseSBjb25maWd1cmFibGUgYml0
cy4gVGhlbiByZWNhbGwsDQpLVk1fVERYX0dFVF9DUFVJRCByZXR1cm5zIHRoZSBhY3R1YWwgVERY
IG1vZHVsZSdzIHZpZXcgb2YgQ1BVSUQgYml0cyB0bw0KdXNlcnNwYWNlLiBUaGVuIHVzZXJzcGFj
ZSBjYWxscyBLVk1fU0VUX0NQVUlEIHRvIGFjdHVhbGx5IHB1dCB0aGVtIG9uIEtWTSdzIHZjcHUN
CnNvIHRoZXkgY2FuIG1hdGNoIGJldHdlZW4gUWVtdSwgS1ZNIGFuZCBURFgNCg0KU28gaWYgYSBi
aXQgaXMgZW5hYmxlZCBmb3IgS1ZNX1REWF9DQVBBQklMSVRJRVMsIGJ1dCBub3QgeWV0IGluDQpL
Vk1fR0VUX1NVUFBPUlRFRF9DUFVJRC4gSG93IHNob3VsZCB1c2Vyc3BhY2UgaW50ZXJwcmV0IEtW
TV9HRVRfU1VQUE9SVEVEX0NQVUlEPw0KSXQgY2FuIGlnbm9yZSBpdCBmb3IgVERYLCBidXQgdGhh
dCBpcyBob3cgaXQgY2FuIGZpbmQgdGhlIFBWIGJpdHMgdG9kYXkuDQoNCklmIHdlIGhhdmUgYSBU
RCBmaXJzdCBmZWF0dXJlLCBpdCBjb3VsZCBiZSBhIGRvY3VtZW50YXRpb24gdXBkYXRlIG9uIGhv
dyB0bw0KaW50ZXJwcmV0IGl0LiBPciB3ZSBjb3VsZCBzdHVmZiB0aGUgUFYgYml0cyBzb21ld2hl
cmUgZWxzZSBmb3IgVERYIGFuZCBzYXkgdG8NCmlnbm9yZSBLVk1fR0VUX1NVUFBPUlRFRF9DUFVJ
RCBmb3IgVERYLiBJIHRoaW5rIHdlIGRvbid0IG5lZWQgdG8gc29sdmUgaXQgYmVmb3JlDQp3ZSBi
ZWdpbiBmaWx0ZXJpbmcgbGlrZSB0aGlzIHNlcmllcyBoYXMuDQoNCj4gDQo+ID4gSSBkb24ndCB0
aGluayAic3BsaXQgbG9jayBkZXRlY3Rpb24iIGlzIGEgZ29vZCBleGFtcGxlLiBXZSBhcmUgZGlz
Y3Vzc2luZw0KPiA+IHZpcnR1YWxpemluZyBhIGZlYXR1cmUsIG9yIGFsbG93aW5nIGEgZmVhdHVy
ZSB0byBiZSBleHBvc2VkIHRvIG5vbi1URFggYW5kDQo+ID4gVERYIGd1ZXN0cy4gV2hpbGUgInNw
bGl0IGxvY2sgZGV0ZWN0aW9uIiBpcyBub3QgYSB2aXJ0dWFsaXphYmxlIGZlYXR1cmUgYW5kDQo+
ID4gaG93IEtWTSBoYW5kbGVzIGl0IGlzIGFsbCBhYm91dCBob3cgS1ZNIGZpeGVzIHRoZSBhcmNo
aXRlY3R1cmFsIGZsYXcgb2YgaXQuDQo+IA0KPiBZZXAuwqAgSWYgdGhlcmUgYXJlIGFjdHVhbCBk
ZWNpc2lvbnMgdG8gYmUgbWFkZSwgdmVyc3VzIHNpbXBseSBhZGhlcmluZyB0byB0aGUNCj4gYXJj
aGl0ZWN0dXJlLCB0aGVuIHdlJ2xsIG5lZWQgdG8gaW5jb3Jwb3JhdGUgdGhlIG5lZWRzL2FiaWxp
dGllcyBvZiBmbGF2b3JzIG9mDQo+IFZNcyBLVk0gc3VwcG9ydHMuwqAgQnV0IGZvciBmZWF0dXJl
IHZpcnR1YWxpemF0aW9uIHdoZXJlIHJpZ2h0IHZzLiB3cm9uZyBpcw0KPiBkaWN0YXRlZCBieSBo
YXJkd2FyZSBzcGVjcywgdGhlcmUgcmVhbGx5IGlzbid0IGFueXRoaW5nIHdlIGNhbiBkbyBpbiBL
Vk0gdG8NCj4gYWZmZWN0IHRoZSBndWVzdC12aXNpYmxlIGJlaGF2aW9yIChiZXlvbmQgdGhpbmdz
IGxpa2UgcGVyZm9ybWFuY2UNCj4gY2hhcmFjdGVyaXN0aWNzLCBidXQgdGhvc2UgYXJlbid0IEFC
SSBpbiBhbnkgY2FzZSkuDQoNCihDb3B5aW5nIGZyb20gbXkgbm93IGFib3J0ZWQgcmVzcG9uc2Up
Lg0KDQpJIHRoaW5rIGl0IGlzIG5vdCBqdXN0IHRoZSB0aGUgYmVoYXZpb3IgdG8gdGhlIGd1ZXN0
IHRoYXQgbWF0dGVycy4gSSBhZ3JlZSBndWVzdA0KYmVoYXZpb3Igc2hvdWxkIG5vcm1hbGx5IGJl
IHNldHRsZWQgYnkgdGhlIGJhcmUgbWV0YWwgYXJjaC4gQnV0IGl0IGlzIGFsc28gaG93DQp0aGUg
VERYIG1vZHVsZSBkZWNpZGVzIHRvIG1ha2UgdGhlIGhvc3Qgc2lkZSBiZWhhdmUuIEFuZCBob3cg
aXQgZW5kcyB1cCBmaXR0aW5nDQppbiB0byBLVk0gZm9yIG5vcm1hbCBWTXMuIEZvciAibm9ybWFs
IGJpdHMiIGl0IGRvZXNuJ3QgbWF0dGVyIHRvbyBtdWNoLiBCdXQgZm9yDQphbnl0aGluZyB3aXRo
IGV4dHJhIFREWCBhcmNoIGRlY2lzaW9ucyBvbiB0b3AsIGlkZWFsbHkgdGhlIFREWCBhcmNoIHdv
dWxkIG5vdCBiZQ0KZmluYWxpemVkIGJlZm9yZSB0aGUgbm9ybWFsIFZNIEtWTSBkZXNpZ24gZ290
IHRvIHNvbWUgbGV2ZWwgb2YgbWF0dXJpdHkuDQoNCkluIGFueSBjYXNlLCBJIGRvbid0IHNlZSBh
bnkgYmlnIGRpc2FncmVlbWVudCBiZXR3ZWVuIGFueW9uZSBhY3R1YWxseS4gSWYgYW55b25lDQpo
YXMgYW55IGJpZyB3b3JyeSBwbGVhc2UgbWFrZSBpdCBjbGVhci4NCg==
