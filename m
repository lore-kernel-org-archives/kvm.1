Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6B339B41;
	Fri,  9 Oct 2026 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583945; cv=fail; b=Qbrnz8RTvLo8lu1D357on8XpKh52Vd96WUJ7o85T86CSa1tdzn6ryeeIZSkFRwroqnYjiyaXAn+kK9w9xFhyYySTYzsRJELGuON0ggK8Tf1yH7AAnZgXWvAkGRjvwEkMwRvAgwFsl0HBo2DTlt/Ug4rtCKill7a70csma+A0pRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583945; c=relaxed/simple;
	bh=KsZABrrqDhlTgI/oi980gT0Y4dLWrpaD3w8YrfsYeII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CeiKOSGhpAY+qybm+ScyPAWuae+M87uzDC5wL9DNjwMP9Zio4GxgcpFLv550bn5pYZYRh1uR5+VBCWcsoFJgn5pCyarPa4yk65P8HI7fF3qCPwkjhpoztFW0fIuYlHVk7LCyMsw2JNXo4ZJi9wH/U8bBIJhycqxCq8lBA/6Jhi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXk4Hmh7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXk4Hmh7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791583944; x=1823119944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KsZABrrqDhlTgI/oi980gT0Y4dLWrpaD3w8YrfsYeII=;
  b=KXk4Hmh7D8rGuBFRL/NRFJv0ex/ai5Jkl7oMck3ltCRNKfyJsynvMqpt
   p+JypHDJ9ZeVrjWq4Qn0xP5K1r+fz9VIbCH69U6tmbLPjDmk8YFwSOd3s
   LShSpKDkgO0+ZY2gOZ5vGuHPcWMR5zVpAs/3o2jqQQeii1cZKo5aHsmYU
   PGcRhu14q4Qrgrn7KhpuIxHx5iFKW9Hw09Tbg7bL7blxziWFPxt72dTNV
   Z4FH9v4f104c3oeOBIZxBbam96R4fQt6uldBDnk27JT753tbMzvha8jfO
   +TjgME6I5ErizMupI6vajURO7m+KQWiFWOdM1XbZr7+0OCJpkiIcf34zi
   Q==;
X-CSE-ConnectionGUID: Agc+TgHNS/2e25t++Yhhbw==
X-CSE-MsgGUID: u5vwX27uTgmfC/MRIkhGOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="395435"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="395435"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:12:23 -0700
X-CSE-ConnectionGUID: stB7IdQbTIq+TNlY3p7sjA==
X-CSE-MsgGUID: uj+giXfzTHef/1N+8Rohow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="758388"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:12:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 15:12:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 15:12:21 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 15:12:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkYyDYhxkwk5dK4glpHfvnMPxAZpJmek3QGxDdl6y4PbLUWJtOlrH4DjoCgE8Cvksle4JdPAAE/kFwpMOMot3Y0Dni80y0HZTCPUlsQznnflTAEyNIRikq6TMuval+YBjQJGlmjnW0+97VMfNPiVAgYczqcRf9LjCafMF1IzGyfeXq2U9aWhNhIvWCKhmmQhlMy/sgoTIH4UWL/n+YuAUjN4gaelUCoZVVqH2eN3pcyNwz01li3I8xlUnrbrL6bOrHllINAuZh3U7PDvnRfBrEnd1mIZqzBRFG3juvJV0YD4saa0alvNxZ/5e4bZqZuCK1fRuBJNM3Xi3oAkqEf/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsZABrrqDhlTgI/oi980gT0Y4dLWrpaD3w8YrfsYeII=;
 b=D0Kp2ZuOU56AfMxOXpRJ6skcVC5VQu9aq0/gEK3NZ0/PRmU84F7z2QoRkrhZ6ctE976dWu96hmTQloVJfKxj9wzANMN9M8cvQQowvt+dllah/cPX7SySVAY81jXTl2OD6IDR6gg8R1z055+f8wM2OKhGm4xkHIRPmsuW6xz4z0nDMyMfLqie7HOr9JQHOIDCiTlqy41CMjX1UIpXYIlsYbwFntIMn8HkaoNDa4fOzvlVp+UlQ11cBIGWIMCXjMJOY9UrCwXR/WHg4W7kTCwgfnfHO15hoq8NsUt5qK6ISsr1hC2zUQDpS8c+WpJa5I447tGq2hMaipogEJ6ThN8N8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA3PR11MB629882.namprd11.prod.outlook.com (2603:10b6:806:58b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 22:12:19 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 22:12:19 +0000
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
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Topic: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAApaACAAhZUAIAA2vcA
Date: Fri, 9 Oct 2026 22:12:19 +0000
Message-ID: <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091035.15599-1-yan.y.zhao@intel.com>
	 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
	 <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
	 <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
In-Reply-To: <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA3PR11MB629882:EE_
x-ms-office365-filtering-correlation-id: 1fac00ea-9214-46f5-1ee2-08df2652628f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|11063799006|10067099003|4143699003|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: i1T887IUqwyIdsc2E6mtyiv5oBG/PkvjGCTOO/Z265EvMz1bw0tC9cqikItwSod0QRQ+LAhzLJn7TDDuKWhp6hoFWPRLJY5c8tsTx37BWCBkCipMz8pQ14ahhHbn27a9Wfg/GnhCOxstzx9tygtkU9wRP5HjsN9YnI6rV4pUANEA2/cv6qBPXre8JxxwIT746moisoj8il1OcA2S7yIKB0Xk+KSCas8WOY9j0LycgBovKMxVaQczpvhGageM1fpr4W/kw9XwYoJ7LLT2WBPUEFUvU95w/K50aAM74bF1TU9hcTy+92ayAXcn+EeJwKMzIOF5onVaWRlRcIfuwUlSGxLTwdMSUtjsBt6iWYgNYvMaHabYUnOnlbW49bN9b1omUitl7rQssKtDH4TK8H+XrUaPE9gfhYcJA+JrxudyS2sJQI2pbrnkDhmzjGl3qdKrz/kiPGnzae314Vtyi9KRyM3kD9z0p0dHeMEosnJENmAuylreuYbxivaDO9EH31bRXXDcbenOJs7lvy8IotYFurXrysxjsg8F1g5MHoQU4nvRVCbb0h0DP+UpTH1NbPLjOlisgVrFNSw0z0whsaX3fQ0c134+orEswI0pgJRgk0DY+xroqzL8/ELGzem3JIOLQAtxG0gLoTlcZFMP3ztuH76dE1g6d1TiEa1fD/lung+1DYEgxjdWXDNn4cNBa0FWP8TmeJfAn2wJpaO5M5dum9dora6C+YsCDFrXbgG/3MM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(11063799006)(10067099003)(4143699003)(56012099006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0JoTGE4ZUJrdndYRm0vbmFtVDRJS0JpNlJ2VDg3d0V3Y2RNSkJUT3B4TWpM?=
 =?utf-8?B?TnRWeWN2Z0ExY1lCWEdUUmp5QWxaZjMzRjBlNDN2R2V4WjVOc1J4V1FHVXZw?=
 =?utf-8?B?enV5dlppamFuaVhEYy9xbHNCaHJUaUFaOEZWcFhOWnhlZm5MeGZTNyt1RWla?=
 =?utf-8?B?UEJJVVFZNFV5OFFuZUk5QkpXQml3OTRyZWJFZWxLbWw2Z0c3anVMQ2RERzJQ?=
 =?utf-8?B?VFVIYkhaK3ArdUhFbnpnNDJaRUdNcnBhYzdhTkZPOGdON3BQam5ETEtyQlBQ?=
 =?utf-8?B?TmtEYWFEY1dOWktZODJNVUovOEphdWw5S0dtMTBPSXFFWmVma3NYejcwcExq?=
 =?utf-8?B?aWo0aXBWa1VsU1Nha3RUT0phNnpZM3IrNk1ZYmNVbjdDKzQrU2xVQmJwbFVo?=
 =?utf-8?B?ZUtDOVAzamVGeXhya0Myc050SUhGMldBSEZxcEtyM3o4aXh2Sm5SUzlmTkVV?=
 =?utf-8?B?a0xJRi90SDRBWFUwYVVKdCtDaVJObW05RWFCaTRvZnZwbmVmMEZIVU40M2FU?=
 =?utf-8?B?T0QxakJ5K3Q1TW9nN1RYNWpXYWcveG5iSWFCV1VyUHlyWFh3M2hCM0JpL2oz?=
 =?utf-8?B?Z0ZoaHdqQVBOcHlYaTVFaXUrdzg5UU8zQXdKSStGbE1OQzFyY2VtYUpJVlNv?=
 =?utf-8?B?dVh3c0FxbTEvWldxMnBST3F2cnhMV01MUGZXbWFlOW9HbUl0TUNiNVVkaGRH?=
 =?utf-8?B?U004eXc2NWtQK2NCZTBQZWc1dS8yTEhMOHIwemNqaXFGUm9VZEZocldadEs2?=
 =?utf-8?B?SjlDdStkbThnZVpPUDZQTGxCK0RQMUpFMHF4N1ZyTTZnRHFnMlBJSGZXSElp?=
 =?utf-8?B?NHdvaDgzVW00bnQxSy9USS8vdkNOYml0OUFubHE1K1paVkJjUGlEV0VNU2xD?=
 =?utf-8?B?R28ybzZxQ2JQeDkwWGladGQ3dzl6T1JTOEoyUC9lWmNkWmFreTRvSU41dEVh?=
 =?utf-8?B?Qm5LN2lhVnFLRVd2dkVoY3dFSW5XeHdxWG1SSkxnQWpsSGg2akpJVUZwTHlE?=
 =?utf-8?B?OXViaXpERUxLRVBGRU9JZFpyaG9EbVVtSWt0bzRLRis3bXpLZUdlc1ExemtW?=
 =?utf-8?B?Y3pNVVpwYUFDWjZibmNXQ0xQQ0RxOFR2MFp5Mjdncmd1ZXJwUVRjZENRTXB5?=
 =?utf-8?B?U0RNYm5obElKRTRMdS83cFRyYjZndUY1bTlvK2g0QlZrT0RIUmdyUVRmd08w?=
 =?utf-8?B?MHBMMzliaXE0eDRKYWhPOXZ0THJQU2pxUjNjR1crN2Z4VFQ0T0hKbUtOdDZG?=
 =?utf-8?B?azBmNHljZUtjbFJBdzFOMEErVWZnNXN3L1NOZEdndFArZkQ3ekVCNnFpWXZV?=
 =?utf-8?B?cWUvOGFoL3JwbmZJOFdpWVNnVGJ2K2ZHdmtBR0lyMTBWdVVUUTkyZGI4Um1C?=
 =?utf-8?B?TkcwVFJsb3JtZGo5R3dEcnc0Y1hWWXJjSlhQR29pUUR5ckp3R2twV1VNVGlz?=
 =?utf-8?B?cVdzYjl4djlQdElVSVRoZkcwU3lsaUFuUmlHcTRCWkIwdnBtWHlvZlVDTVk5?=
 =?utf-8?B?WS9MZWlpTkJqQTdaaktPcTA3QUxpdU9EQlFDV2VEU0tzYXZyT2tNa2FnOWtx?=
 =?utf-8?B?dWovQ3FJZmp6UWwyb3d4TVBkbnhzZ1pXWE1yZzNXVHhXQ0lWd3NLSkxCck9l?=
 =?utf-8?B?aUJxbEFvYXBhWitZS09LTjNMOXJsOUFJOWtWYVVMTmFoZjBZSFRyMGQvUjJG?=
 =?utf-8?B?bm5EanpacWNTWXZ0K1FlMjNIa1BObTQ5TXN1dVNSaitYTmZNMVRRTjRxU3FH?=
 =?utf-8?B?SzZnRGMwKzVoWjF4TThCNWhEKzYrdDR2a1JZNGFPOW0vbUdmSkRCRVR3b2Ju?=
 =?utf-8?B?cjBiNmNvZFN3RUdKbUdkWXIxWVJlaTMwdmtkYXhLUUxQUkd0M3hHUGJrckpl?=
 =?utf-8?B?WGxMcUJ2dzJSVUlxdTE5UHk3WUlzdU5NRjBCWHFNQTVxY2YxTkx0VGVHQlNL?=
 =?utf-8?B?ZE5GS1dxZEJKTEQ5ZmJQUStnR1hKNlJ6NHJjOWtGMDhtWm1kTmN3TFo1MWRh?=
 =?utf-8?B?TlV3RUdUcWNVRlhZKzRzenlFWDMreUZvREJMemN5VzVDQ1h6N0JEMzFDcWMw?=
 =?utf-8?B?cUljYmpvS3ZWS1U5UWxmazBUODVMZEw3a3F3RnFrYUQra3dsYkpPM0hkK1Jr?=
 =?utf-8?B?VngwdVNvbno0SUwrQW1UWVJ1QmRNdFJnUVJ4Skk5aWlrNDdibWErV0owY0hI?=
 =?utf-8?B?a2Q0RkJFQTl4aUlqTi9Eclg4Z1cvUzZsQ3Rvd1RJOVZWTHBtS3B3TE5rc1FC?=
 =?utf-8?B?TkQ3TTFJSi9EdkRLZU9NcDVpS3piaWQ3SHBZSmprRzRjci8wWGFVZWRjVHZs?=
 =?utf-8?B?d1JEcFloZ1hER2poNWlSWE45R0VheGphZHdhOEFMeEhWUWJBb2VQeTVnODlr?=
 =?utf-8?Q?NePDjqg2pPsZcXH8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <642DE5C9EAB593419D526D554F39BA99@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yF9bA6cjFDe4CMT33xPTQFZgo7zgJ6I1jqMdHoDhJ83Mjs5KUBwlgeTsNNsmgruw7olSz4BxHCK4GOu/INfM2ujfGS2aMDbHCptQF221pQo8iGOv5p1DdqphxcCj3HwRP/x494diPLeSOwdFf3i6mkwWft4YERQopCGWJNaqOtDaWFYw8YBsiCIoWFRaZpyD6XCtUUGZ3zECZ/HfT9K+RVq/rE9LByKohpExtahdnJhHAIXE6FhyQNfIBt0S6zI2fs5BYyrl/KIs6v2XF/Xpnz8LzI24p9ekvxC9MiPSq/B91HsUKHdQ1BvziH7VN7XJ4bT2WIYJOBFyP4jJoM1BlQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fac00ea-9214-46f5-1ee2-08df2652628f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 22:12:19.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xr4MOYNVNw+6R46SJlWS7JQwQ4cQi1ScMYiNvfSOq//9n/PjhC3m/rvxsuyF1INSnEx6sVny2QuCX4jKVoH+wgcgszfC32khGKBfbZUZ7Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB629882
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTA5IGF0IDE3OjA4ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
VGh1LCBPY3QgMDgsIDIwMjYgYXQgMDk6MTY6MTJBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gV2VkLCAyMDI2LTEwLTA3IGF0IDE1OjQ3IC0wNzAwLCBSaWNrIEVkZ2Vj
b21iZSB3cm90ZToNCj4gPiA+IEFub3RoZXIgaWRlYSwgY2hhbmdlIHRoZSBvcCB0byBiZToNCj4g
PiA+IGludCB0b3B1cF9leHRlcm5hbF9jYWNoZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGJvb2wg
cm9vdCwgYm9vbCBwcml2YXRlX3BhZ2UsDQo+ID4gPiBpbnQgbWluX25yX3NwdHMpOw0KPiA+ID4g
DQo+ID4gPiBOb3JtYWwgdG9wdXAgY2FuIHNldDoNCj4gPiA+IHJvb3Q9dHJ1ZQ0KPiA+ID4gcHJp
dmF0ZV9wYWdlPXRydWUNCj4gPiA+IG1pbl9ucl9zcHRzID0gUFQ2NF9ST09UX01BWF9MRVZFTCAt
IDENCj4gPiA+IA0KPiA+ID4gVGhlbiB3ZSBjYW4gY2FsY3VsYXRlIGV4YWN0bHkgd2hhdCB3ZSBu
ZWVkLiBBbmQgZXZlbiBiZXR0ZXIsIHRoZSBleGlzdGluZyBjb2RlDQo+ID4gPiB3b24ndCBuZWUg
YSBjb21tZW50IHRvIGV4cGxhaW4gdGhlIHdlaXJkbmVzcy4NCj4gPiANCj4gPiBBY3R1YWxseSBz
aW5jZSB0aGlzIGdldHMgYSBzdHJ1Y3Qga3ZtIGFyZyBsYXRlciBpbiB0aGUgc2VyaWVzLCBtYXli
ZSB3ZSBjb3VsZA0KPiA+IGp1c3QgaGF2ZSB0d28gb3BzLiBPbmUgZm9yIHRvcHBpbmcgdXAgZnJv
bSBhIGZhdWx0IGFuZCBhbm90aGVyIGZvciBhIHNwbGl0Lg0KPiBIbW0sIG5vPyBUaGF0IHdvdWxk
IG1ha2UgdGhlIG1pbl9ucl9zcHRzIGFyZyBtZWFuaW5nbGVzcy4NCj4gUmV1c2luZyB0aGUgdG9w
cGluZyB1cCBvcCBmb3IgdGhlIGZhdWx0IGFsc28gc2NhbGVzIGJldHRlciwgZS5nLiwgaXQgY291
bGQNCj4gc3VwcG9ydCBzcGxpdHRpbmcgdW5kZXIgdGhlIGZhdWx0IHBhdGggaW4gdGhlIGZ1dHVy
ZS4NCg0KSSBkb24ndCBzZWUgaG93IG1pbl9ucl9zcHRzIGlzIG1lYW5pbmdsZXNzLiBXaGF0IGRv
IHlvdSBtZWFuPw0KDQpMZXQgbWUgc3BlbGwgaXQgb3V0IGEgYml0IG1vcmUuIEZvciBhIGZhdWx0
IGl0IHdvdWxkIGhhdmUgbWF0aCBsaWtlIHRoaXM6DQoNCmludCB0b3B1cChib29sIHJvb3QsIGJv
b2wgcHJpdmF0ZV9wYWdlLCBpbnQgbnJfZXh0cmFfc3B0cykNCnsNCglhZGRfdG9fY2FjaGUocHJp
dmF0ZV9wYWdlICsgbnJfZXh0cmFfc3B0cykNCn0NCg0KRm9yIGZhdWx0Og0KdG9wdXAodHJ1ZSwg
dHJ1ZSwgUFQ2NF9ST09UX01BWF9MRVZFTCAtIDEpDQoNCkZvciBzcGxpdDoNCnRvcHVwKGZhbHNl
LCBmYWxzZSwgMSkNCg0KDQpXaHkgaGF2ZSByb290IGFzIGEgc2VwYXJhdGUgYXJnIGV2ZW4gdGhv
dWdoIGl0IGlzIG5ldmVyIHVzZWQ/IEJlY2F1c2UgaXQgbWFrZXMNCnRoZSBsb2dpYyBtYWtlIHNl
bnNlIGZyb20gY29kZSBLVk0uDQoNCj4gDQo+IEJlc2lkZXMsIEkgYWN0dWFsbHkgaW50cm9kdWNl
ZCBhIHNlcGFyYXRlIGNhY2hlIGFuZCBvcCBmb3Igc3BsaXQgaW4gdjMsDQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDI2MDEwNjEwMjM0NS4yNTI2MS0xLXlhbi55LnpoYW9AaW50ZWwu
Y29tLg0KPiBTZWFuIG1lcmdlZCB0aGUgY2FjaGUvb3AgZm9yIHNwbGl0IHdpdGggdGhlIGNhY2hl
L29wIGZvciBmYXVsdCBpbg0KPiBEUEFNVCtIdWdlcGFnZSB2NS4NCg0KWWVhLCBidXQgaGUgZGlk
bid0IGhhdmUgYW55IGJpZyBhc3N1bXB0aW9ucyBpbiBpdCBsaWtlIHRoaXMuIEl0IHdhcyB3YXkg
c2ltcGxlci4NCg==
