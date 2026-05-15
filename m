Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493B30567C
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859921; cv=fail; b=J5eLsWaGLdC8FATCbckhe4T4ZCVXuiNFIZypsKD3BmDnGuNz869Pso2rl2Uqj4/6xMmniXnLlt6qUPSLVeRk8L2JmhxhpFYKQ0lLsbI/v+sZ0Wb0Mw40VJYt7v7swgJmuUgPwgQqdu6xrdr8MWXOQ0D7D7WRWU6YwaLYWtovgS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859921; c=relaxed/simple;
	bh=H8pSkPxeI4ITfHUp/A5rA0sbE/GMNTYf5L6zHc6I3Tc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=itdBuKptV5zqXEgTBTTCNM4R37t/LKI0Z9nbsTWGwJyNrEGdR+alKN6hfn1mo4aNHVxVAQCIoJrF/H3qWItmfBVzYilIJzV1n9qJxxacjRqJk6d2qQf8AUf8Y1w1BVyHZ+rs7y5QUqERJugKUe2T290+WS9FoCVErMnHqjkr3Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oq230HFg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oq230HFg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778859920; x=1810395920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H8pSkPxeI4ITfHUp/A5rA0sbE/GMNTYf5L6zHc6I3Tc=;
  b=Oq230HFgbqhFUp7ng7Kf/+SRP5AHY5GyUqp/uYcKPs/zqPeQt8Ex7IsD
   B90r4jTV9TnTBCHUo17XIjl+0ev+4eGZw5G6QOoT+bUt6zweeyKuiPGm5
   6wfr/8JwnhDLjnlm4fMDsQHqIyOmh5FbUBySCNmZ0uzhI0I5rdvmoLU1Y
   VBaAOc1AjG6s2ZAkGSZUpRv13fMGlwiEhZ7s58duoDH84YxZYX8wOxYkk
   GQPe2FlSX09NErmuI5HXXuC1G8RYuZSD86jxYWZA4bFqRMpBaSXrZNeTr
   r5+t6WWtgR3yjQbSFllcAec5FqGHxpA46eAErhkQV0mLgyS5m1OLoqyXV
   g==;
X-CSE-ConnectionGUID: UZfESZzaS7OJMBKyNeUuxA==
X-CSE-MsgGUID: 4HCotQjfQZqz9EJJJh6pdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79936901"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79936901"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 08:45:20 -0700
X-CSE-ConnectionGUID: QQOeSiqOQGyH+BG57Tx8Fw==
X-CSE-MsgGUID: YUHlqCBdQDmnmE+rnXG2Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="237731628"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 08:45:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 08:45:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 15 May 2026 08:45:18 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 08:45:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ka/CUdn9LgVnl1KPSLy7FDG6yztBItIAzF4o4ys5jkrMpMtWD72VFyFdJmIF65xZEh1NZhU83v7UiHbnLKn3vNTp/eHsSZ56DxNtctQUGgl9JuRZ50rKnSgNfJLF8IGl3CzKHbYEVQ8z6deUHyeZnw4J+4Lu6KMvlzE0GKsMHkKEt3pYB/GchSXm5ZIC8p7aTg3L0uZcSjcYqVb9BhcQjiTy6c5yUzqKNHdmmoo+Vr8kSO7AnMGl5fXgiViQqsDHRT0d0EhJlsvzfDB0ALdqp+NKUi9Nz+TKEdvQ2EQ6jEbkwD+YuYLHJ1TfeSI1tJDepAROxhujo2YvKlZUqhca1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8pSkPxeI4ITfHUp/A5rA0sbE/GMNTYf5L6zHc6I3Tc=;
 b=mGjzS9y/hz59ZhRxarL1DKusMupR4aw+ClZppaq78GQc5FmOt8cOmhGDVmUbQjB8DXPHhXbJh890O1IKZntv29KOW+PeoZx+/yY1zO1ksS3de3tiHrJVYv2wZCeQnWtrEUu5F1sRaI+8xCt8QhraNtS3fR3xHUmS3aaGO9uaA0XWhEYEkaZn+jBOYdLcz9YHNBWiYEVZ6yBDoP4SkfC5gPAHbnU5y5Oc69w5GSEb8HMFm7qGLuFXseS9gC7k0vYxBrCWuGrqtGy7QJs8AAGKI/GxBlNAt4ZU9ATAwvyfFzaMUwSyiK6fuGMKtra5F2ZE58nF95vwu7wMEn1iTp979A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3018.namprd11.prod.outlook.com (2603:10b6:5:68::11) by
 DM3PPF5AD378C3B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 15:45:14 +0000
Received: from DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f]) by DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f%6]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 15:45:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>, "Huang, Kai"
	<kai.huang@intel.com>
Subject: Re: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID
 verification
Thread-Topic: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID
 verification
Thread-Index: AQHczjxZm3NIUz3Mfka520SfE1BvJ7YO55KAgACAQAA=
Date: Fri, 15 May 2026 15:45:12 +0000
Message-ID: <c168c7515a6e0e63afcbce681b4735d21b754bfe.camel@intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
	 <50ccbe42-4b74-4c2a-b530-a367f7285de6@intel.com>
In-Reply-To: <50ccbe42-4b74-4c2a-b530-a367f7285de6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3018:EE_|DM3PPF5AD378C3B:EE_
x-ms-office365-filtering-correlation-id: 42e28403-833a-444b-5374-08deb298f399
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|38070700021|3023799003|11063799003|4143699003|56012099003|22082099003;
x-microsoft-antispam-message-info: YHAGyMFKwqBw9Kh8C/SsVuRWGqdsfGGcei10gtmfiwK6rNbcSDajYa0iOw2uirX51zTvZiGHWdhG36BmBM3/BjTZp/0gwRLb8L8R10pZQS4ReRyIzptxOuVZoDN77966xgzpn5id1hqv6Gx1zmfS5FW/sycyLOFK0kjc2bduyGRnjCVl83NtmIzbAlF0knoIXlp4pnbKbkwwFYoz69hYg30IqGrCCItQBjh6K9zYiP/YhK7SPT2rOVpF140GtunZKTUNv0aeaWoMpJh2j5eQScEE3Ed/SRvmMjgbWyHJbuk14bGQggPUmv9HB6THdVFr6kOfG+ouwxPqy/wulhzUEZEjavQ/Uvtm/3dMwgD95n7dELHJ8qFlDr9Q6yJFbPwTsUklN9EuGxRLea2ZPHfgQURW1mfqmmlRCQ2hOkSEIkZBHfY8l5Hf9h1qi7Jo5XgWjH0VmND9uq8VFrIL7JnHXQf534J9KQ9FTE77WreC3xywtaQU6sUisF9jy8x/Ap6E824Ayfvh3BkDUBWJc/YyZFk5ThxH8HJ2qxxeXRV0Cn5EhhCC+5ApIMkbe9gliJW6a2hSBMXSbSxDjwkaO7HeGDcbv2kXJEdnDUS5LktAcTK3M9g4PCImyAHwV4V9aZBTRWrHpnXKrNSBK81QoKknldEIgfwIe7ef7HygW+eyLN13Rqdok6l/TIhX3yKqJuh+VY+c1+4BtlHhHXncYmZp1qXLKbDaYFIkO4+51TE7JNLpBhX4/3TXXcjsuMZZLCza
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(38070700021)(3023799003)(11063799003)(4143699003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmQvR0JSMG9VSDhkbmxxeSt2emlVSnVhYitveExmSGcyNDduSE96NUhoRER6?=
 =?utf-8?B?NXFKVEJLMEtmcDFlYW5zK2owcjQydmNpOWJlbHdTVkdUekhoNVV3aGEwMDI2?=
 =?utf-8?B?ME9oMjhjQjdJN0w5U0hoU3VSMjBGdmJiK2dpa3pRUXE2S1c2ajVtZG5EazY1?=
 =?utf-8?B?WStORXoyeVNoVTNaVGRIVTdVUGZRRFdvZWhQVEdXeEhGR0JLaCs2ZU1PTFNv?=
 =?utf-8?B?Sjc5ZSswMGlKWW9MR3JmWVBiTHk0VXlOUHc2VHZsZHJRV1FkV1JkSk84VW5V?=
 =?utf-8?B?WncxSUVtOXZESVVDNVBxbjdsMzM3ai85dm9YdUd6eVI4S002MGJGNTExWGhC?=
 =?utf-8?B?eE84Z2FRd01CNVFsOC9jbmt2VENzU2hNbnM5QVkveEZDWVhwSDM1N0NFTmR5?=
 =?utf-8?B?YlkzSWRsZXpzaTU2bkNxR1Q5UFZ3RVB2Mjd4am4wd01Fa1hpT3htanJJbDdR?=
 =?utf-8?B?cGRFaUdoUTZTZEtwVUFoVVB0S2V6UG5Ba1JzckR1U2xKNXBaOFFwUzJmbWxG?=
 =?utf-8?B?Y00xd3BFVXhpMnVOalZEWnZDY2R4MXNVYjFVWmZCR1VEeFFRYW5YYWxtdGR3?=
 =?utf-8?B?bEk5REQyVmFCdE9YMm1BRzFBQ0VMQnFndTQ4NEZPeHVERUxDUmdBY0d0M0R0?=
 =?utf-8?B?amduVmVwZCsxNjFyRHlmdjFUNVQySzYzbUlGUkhWM09udWZMYks4K3JMLzZH?=
 =?utf-8?B?ZUk3Q0RnaWE5MzV5ZFI5YXdqWEJXY21RbnBZc09HMTJBQjFMT0hZblBnVDFO?=
 =?utf-8?B?eFd0Qmo2bmVkaktpYU9HOWg3OU5WeVpPSFk1RHpzdS9PVlQ3TG0vcFpjeVNi?=
 =?utf-8?B?Skl3aFJ1WGNXTG5IRzRDUm9XdEZTTk1KM3Y4UWJ5R0tya2hvaGR3Snk0dlVW?=
 =?utf-8?B?bTZjdUF6WG5uVVZnNDlmTmFvV01EdHd2Z0R1KzFjQnh0a1pBY3Fab2tvNDl6?=
 =?utf-8?B?RmZNRlJXZks1S2JUZDFZRGhWQ2tZM2liWDlHWTJWdjdPRU1qOGtPUXdyZ1NO?=
 =?utf-8?B?Y3NsN1lsdnJEZUZHV1lESDI4RVk0YWFweUM5TGN3Vi94Z3dWdnRrSHJxWW9n?=
 =?utf-8?B?UExxTUYrZnNPNlVVY09wYkhJczhPdWp2NkR4T3RSMGdsbzVVc1JyZWdEWVhz?=
 =?utf-8?B?dnVaM0toNjA1cHoweHpwU291VXhoaU5PQlZDdURBQnlzNjRMQVdJTHZ0dXlV?=
 =?utf-8?B?Z05aTU1UUWs5TUdNTWFETThlb0RGSG53YXJyNk92SHpHeVptWkhuSjBzWVJN?=
 =?utf-8?B?Vi9Tc3BOYmtLVkMvRnJNdi9xbmdPTEhQUXJZZnlJUXRvUVc0OVp1RktHNE9o?=
 =?utf-8?B?TFVCRXlOQU1vQUhqek45aDdqVlJaRi8weW5pN2pRbzVNU0NUTmxzMHlucWpz?=
 =?utf-8?B?MHI5UWpYcEF0SlhreE12amVhdG1OK3ZsTGV3Qk1iYy9La2ZXc0RaNDZmRUpa?=
 =?utf-8?B?N0xFaXErUGhiK1dZRkliNFdWUnBSOUtVdW5uMWtad1E2Uk9HLzRRVkMyT1pu?=
 =?utf-8?B?a3BoUWdRYzNQL0twWHJ5OEs2NlBqcGZ2aVAxdlJtYWtaUE9DaUpxZ3g2ZVBO?=
 =?utf-8?B?clpLK2tRMUZaSWM0a0pQakE1Zlc3eW1pTUlaUVNpb3gvYit0c054c1ZkQTRV?=
 =?utf-8?B?NUUwMlZLbnU5Lzk4WHNQS0x4dFZnbldxYlFSQzNuUjEya2NHcWMxcWxQcVd0?=
 =?utf-8?B?N1JraGU3SGVqWkR6YlFpVGFkK2xnOWEwVDAxUzU4ZkErWHozWFlvMkZ4NzB3?=
 =?utf-8?B?cWltSDB2WE82WjF1bFkrc0VLN2paTURTM28xd3FiRzNKQTBWcGVWVElSQjVI?=
 =?utf-8?B?NFpVZWZMUTdNUkZZTjJSeW9vdllnbDVQL2MrWTJTejI0elliWU82clRqa2Y1?=
 =?utf-8?B?eFhLVXN4cWFzRktLM3c2QjM1a0FNdnBmc2VlTW1iSFVTZU81OWVybWRITG8z?=
 =?utf-8?B?eXNnK1hHcXQzcTVzMzZpTC9WSzBmWm54TGNkY05DalgybVNRS1V2UEp3Rm9G?=
 =?utf-8?B?dVdtR1VseFprK0wySy9TSG8rdiszVmZNYlphN3JpcTdrQzQ5bjhwZUttMHM1?=
 =?utf-8?B?M3dDSGk3RjRnQmgxU3hUYW9MaGh4YkRiRGtHaGsxZWdNaGtrYzlmKzNHcllX?=
 =?utf-8?B?M2VkZDk2emdmNG1sYVhWbzBiWjExcEErd25VRXFpc29meDRIRUdXaC8xcm1N?=
 =?utf-8?B?dmZKUlQ2VnlCSmxGeFdKNU5BZ2JrOTNnQkc1TmtQN3Q2YUNZUVJOSU9NZ1Mv?=
 =?utf-8?B?L2JsRnhXQ2pKOU0vQVRDTnlwSnVhMUQ4VzRURzF6d2htL3U0YU5DODhkN01h?=
 =?utf-8?B?RjF3TmZqSmkvdzd0U00wMDBuNmd5WXRiejdCV29haWpEY1VPazJQV2Z0czRr?=
 =?utf-8?Q?gapCrTbah5NiavtE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0E34AEC9CBED14193FB858CAC943CD8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DQxDp3YjeSLn/WJYMP2QKS+fSmJCZa1aQ/eVYoD4KAqwx1adKoEpDcA5UBXJ1T6MBrJbecsejdMYQ6LFDzDXsr1fxuspXKjqE6BEfAjmpehSJtMO2MEUH4wyl4MAQuzEJpiqcBksDGpS7mtpHPto0n9ytp8uCLue6KRp4jxAmJ/umEn79RGbqcRIvjgLE7QwfTBRWtLFkubI1HdyQ1ygQevlfzhtiPJ5WPRIaw61TJ5C0bjllPLqmD+wel6YsSg1HAPIDwrXb+W1bDAC8T2sal8T/6lize+HeFAL/WS34f89OSQpelP8QSujWlEL92Pwv1KbVg2lAkbPE5MVRC591w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e28403-833a-444b-5374-08deb298f399
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 15:45:12.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03WQhEOq3W8hcGSGM76hV3K3gXIQ8QFkMDyFI1XHspfgEPqEWmFvcCKOY6snmrQENQGB8KGkerMK9YGfeJptg7S0WOTxZxm50pqisB9NyZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5AD378C3B
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTE1IGF0IDE2OjA4ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBJ
ZiBubyBnb29kIGJlbmVmaXQsIEkgZG91YnQgYW55IHVzZXJzcGFjZSB3aWxsIG9wdCBpdCBpbi4g
RS5nLCBJIGNhbiBzZWUgDQo+IG9uZSBiZW5lZml0IHdpdGhvdXQgdGhlIHBhcmFub2lkIG1vZGU6
IFVzZXJzcGFjZSBjYW4gZXhwb3NlIHRoZSBuZXcgDQo+IHNpbXBsZSB4ODYgSW5zdHJ1Y3Rpb24g
dG8gZ3Vlc3QgYmVmb3JlIEtWTSBzdXBwb3J0cyBpdCBieSBhZGRpbmcgb25lIA0KPiBsaW5lIG9m
IEYoeHh4KSBpbiBrdm1faW5pdGlhbGl6ZV9jcHVfY2FwcygpDQoNClNlYW4gc2VlbWVkIHRvIHRo
aW5rIGl0IGNvdWxkIGhlbHAgcmVkdWNlIGJ1Z3MuIEhlIHdhbnRlZCB0byB1c2UgaXQgZm9yIG5v
cm1hbA0KVk1zLg0K
