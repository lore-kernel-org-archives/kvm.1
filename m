Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606051799F;
	Thu,  8 Oct 2026 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422178; cv=fail; b=WhZXEA3y2KcSKT3uFPSDG8cGBNynGY0O9DqKeK1tEJvSg5G4Yo4foRLHFLfF5y915Le/Vp2DZ4buGwPxTlef3TStNsC6CjcPJOZes+LZR2HFceCyUVGUJbTI3P3qbj+4L3bQZkf954L6KrhEKpLOAqi3jh/uwJ6l6gYiugo9/Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422178; c=relaxed/simple;
	bh=lveR+A1714S633ugMpkNDe5BkYC94aku1VWTJXKb7jE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c2/HpFjFULJiN1sH3cOH6Z0+AJMetzMqvj5oImB66cxBOYmgZgP7DRJW1faZrDjcTUn9gxvmuSZfb1eOx0rpvznDoB0yeKMvPZE/dRjRFksuDRolJHankPRNJlTpA2kxrCeeuPMxzAixH+Pk5tm37ER9DekoaLzLZdPJSnpML3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFHaF4QI; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFHaF4QI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791422177; x=1822958177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lveR+A1714S633ugMpkNDe5BkYC94aku1VWTJXKb7jE=;
  b=UFHaF4QI2gqtTeqAUp1CnW3Rt5j7hSFHAPknaf1WS5sVR8HC4cC97Npj
   Ya76XTGT/za58Ibmc4bp0nx3dgtWXeCQ/L0zIbsx68yWinu/4bdpp3AuL
   pC3iCyY59YdetYvJVMz/zGf0adZo6ho/78QncpghMePX5qAC6yNulJJ+w
   wWfFZeHydMKbG2Jpa3zgDggQxSHT2uYOwZTYvkW3qw9d8uru3JVLgQkAQ
   T1nso4Rj/ESyo9pAlHAIXPWvTF+MfsPTAJw31W4Lp1mh0ycDGTlQ1im9T
   hcVwVRkS7Wls4wkpJ7qlCNgGDPhUki+lodU/Pcn7vvcC0RQdyI8LZ5qFj
   A==;
X-CSE-ConnectionGUID: n+8oX5pUSRqFVEn+OP2l1A==
X-CSE-MsgGUID: /iKRJA9ARD6Zzk6bRBAe3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="90382"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="90382"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 18:16:17 -0700
X-CSE-ConnectionGUID: VVWleTTlQCuhESZv+NYnqQ==
X-CSE-MsgGUID: QH3UZ1iyRJepe5rHlbalyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="285532600"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 18:16:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 18:16:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 18:16:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.46)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 18:16:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGcs3HoPlCPOjCDJPfr6Dc8M/cwC3R6pC2gxzOO08rxMD4jrJuoUSg3RF5QHnr7ISXiNRLpP4MbMj4QZsMEmf/tAvuPPDcbz2uXJ0RGfnz6+JS1855bl8Bi+l5nf2eQfR1IdrrDIHXRl1Bxi8R46C5nky67RuYmj9GAf2CiRv/0sRZ/BE8FDuY8w5hPzko56+bDOHrLxgl2L/I/m3IccJGDOM3m68w4y/kCyPqIK23Pa4Zdadt4qADqEqnXh7qZ09l05GHfAdYEaq85Aywwk4bkrrCqfuKv3XufHbXq94ocMqbUYLdsmy7l8uHIK3kpV8ZvzzA6f2K+EF7FMExFEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lveR+A1714S633ugMpkNDe5BkYC94aku1VWTJXKb7jE=;
 b=WaupCNbnQ6iEkkZ6E8JO5yzO1aAR91LuN1YZrIWyLXlI93PFKKiyDfGhqJ4y9gCkrW8EM6T5gGX7dYdsMo78yGio2A7IXgbCW+9H0XuK/1Oi1aUI0JBrrHnTFYY2OaDr9kD/g/fDCB4cXvurPTH0Y+8pAFzqTIaF4W9oyuw7NJxXlctG7wdO9mSeuhtjfAuWLYqcJCPDF9IzOqhtECy9Or1z6uYdgqY+gi6kHr8G+dHFdEWmcyCamCJlV+PXJazzATJZTBOgQ1r3PxR6T4SwyPuIOIq1HH3xT5tR6XzwCK+D8g/SZ3FAO7rIFlMwBswpB9Eq8rAI6aHHG4gDal8ULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LVXPR11MB9779.namprd11.prod.outlook.com (2603:10b6:408:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 01:16:13 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 8 Oct 2026
 01:16:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Topic: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAApaAA=
Date: Thu, 8 Oct 2026 01:16:12 +0000
Message-ID: <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091035.15599-1-yan.y.zhao@intel.com>
	 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
In-Reply-To: <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LVXPR11MB9779:EE_
x-ms-office365-filtering-correlation-id: 1d088509-66ff-439c-1f71-08df24d9be32
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: y6V7rFVugnUTFw/G7Il9EbNggzNVsumoX2j7RtEAssBVnl3PpM5T7C8ihhklINT8Rr7TJLoZ0ZX0Mglpc252WlqcP0ol8LjVAoeYajo7Ivrttd61ubvai3gVsMoZo3ETxReBZgIgnTdgrZdJLFr4HHbuq6sWhoVC2+Xhxjn3Y6NX1jygWrzxqXjtt4jvv7KBoZW8RCAWJjkKwAd8Cxs2bdELQ+cdAaub4FnqvojX6wKrR/30hAzJJfiZCFKYZr5CNPiNFH/dj6k80PvV/C4Wc5tDBfb2WAJG8Q1XmvlrFxcNQjzj477e2RKOMC3OZEMlJP9r/mRWdh/3Gkb+hVZKqvo4k3fiS0DTjXBXBcIn+/lIC4ahZI7odxlhZLWpVkL1IHfu2MsAKU2+mGtSpC15GcCQxE6iE6suXcHBmhsjTbrlPfw1jnPUW8pVk2Eezqchyqfk0MUNT0KPxNbx6db5bnRCCpgM9DUSrxnlUPBX3yOKA51UxjHRdPqn0yN00PWu3um0Xc1jFH9ohtCUUcPfvgEHubD8BcdDg2iKT5MY1uYXaq0si1R3yR7ZPqdnkeemw7r1L54FHaIJWx6cBH/owLtB0UnlW3urzdzGElzIufqbPvqEzWCsxRgaAts0OIcQXTXubbkkqTcSXxvW1zbmeVHYGspfEN6LjYuVMJTX/U+b9qE/hmL3y1uqyy1fDNnboriVqtVSzCi0ebt30+WNnbPmxcPYN0WYYr+rhfnwgpk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEowNC85cHJLYjZoSFE2V1k1aGk4MjUxOC9nOUsvdjhrUFZLc3FGdkY0SjYr?=
 =?utf-8?B?YllTbkZsTmpnZ0tmQmN3bGsydFVuLzdrQXZhSEdFbHhGMUhOaGJHd0FjT0tj?=
 =?utf-8?B?N1NPZStkQjEyVWNmSDl5OVRiaSt4VG5jSk1iZlkwbUw5NUxUVUJqRzNoY0U3?=
 =?utf-8?B?OThRdXpkUFp0TC9POFA5WXVrNTdnd28xTDU5UzF3b01pLzRlUkVaWmthb205?=
 =?utf-8?B?WkJMWVVOeXhvRHY1K1E3WDhiNFY0dFVOTGtvY0tZemVtU05KdEQrSSswbkZp?=
 =?utf-8?B?ZXk4QWJHb2RGNm9BemJVR3lDODE4YjdOZFBoV0wzTlQwYmpKSEVYWFVEazBS?=
 =?utf-8?B?UGdpcG5iMEV2ZlRsVVhoRWtnNHgwUi9uUjNuZndxM1B6UnpkUGt1dTNjc3dO?=
 =?utf-8?B?THBmUEphSCtOVmo2MUJYQ1B3SWFpaUpFaDVWeUQ5dXhBSU1nSTdYeEd4eWd4?=
 =?utf-8?B?T0xvbm9ITXZFK0NLbDF6MFlRZHdSM3cvNk9zYkhNUHVRcmQyZXpNdm0xRzMz?=
 =?utf-8?B?VjdHN2pUNDkzZmpMVElvUXE3Y3I5SXZIY2dUNG1naW9GUjE5bmVJYUNnSFFl?=
 =?utf-8?B?eGNlVFRabWdxV3IzSnNqRTBiamRPQjZSU0dvWi9mN09NemxsQkV5Z2IrcVJG?=
 =?utf-8?B?YStzdUFNYm1VdWZUaUxWckFYc0dNSFEzQkhsSy9oTHU5TFZUckRrS2E3WnZz?=
 =?utf-8?B?Z3QzOTdLTEtvWXJVNlNpakNGNWlHU0tBM2tPakNaRUVSNGZLZ3FSbU1kWUFy?=
 =?utf-8?B?VitRT0dWcFV3VTRsQlZtdFRmdWFZZ2ZoQTgyYWx0SENXRWIzanp5S0c0VXI3?=
 =?utf-8?B?VUwwNER3OHN2d2hQcVpRdEtFNDBrS3hJenV3SitveitkcXVmK1RJZ0dISkVH?=
 =?utf-8?B?bXpvanhEN0pQQllRcXhrZlIxYm8wL1hRdEpjV0JOcUVBdXc2ZVhIaU9WUjlT?=
 =?utf-8?B?eEI0aExNM04zOG84TnRLTkd1WHNoT2pKTXdpZzVYM2FpZ0VRQlFLVStuSVhF?=
 =?utf-8?B?RGRjTXhxSTU2L3dTS3dySVN1NHlKUFZ4QXYyYXhSQ1hxRTNkaVFQaWgrb3d3?=
 =?utf-8?B?SHFoUTg1bDE2Qit3czhxa2tYb1N5WmllS2lMS2dJdllYSUVmVXhyKzVsM2Y3?=
 =?utf-8?B?ZkFkd3FqRkhBL1F0LzVHTCtXR0RUZEZ1dFIrNlNiYW9oRDR3U3hUMndBL2hE?=
 =?utf-8?B?L2lQWnRwQlRUNStvSW4xRlpWejRaa3dYeURYRkt4cGs5VFhqVDd1bVF2NnhB?=
 =?utf-8?B?NjBYeXpBcEEzMFFKRjh1dWNRTFRuV0xVODVrdDFtV1JxMkt1eWYwaXdpZXpV?=
 =?utf-8?B?RGljMmlSUmtCbk42U2h2SnU4WVV1cHByN3VBV0pzRkFSbkhQcjV5ZTkwdllm?=
 =?utf-8?B?SFhCKzl1eEsvVHpjQmFFTlpnM09BUkNIRFQwNVZRdi9GMWY5RVR1WVVFc1JF?=
 =?utf-8?B?YksxSHlWNWZjaDMvZ1h5MWw2dVpQOEVSdVhyOEtQcWtQVVJZRW91RHdYTDBh?=
 =?utf-8?B?MTFLQzJvTlpwaXUxTTRFRVJ2TjNoM1VtSzY2WFBBSVhQYXB6L0NyK05YTnJp?=
 =?utf-8?B?YWRRN0lzTytaUXg0elAvSTQzaGphLzBQU1A3Qm5sVHlORk8vNE9qRzlNblBs?=
 =?utf-8?B?Mk04Q0dtQ3pJMG5ReEVyTmFrUVVGN0xOL05VK0FCM2xEYTV1aEJ2TkJKb1lR?=
 =?utf-8?B?UTM3ckpmWkFRMDVFUk1DbmFteG9ReTVWK2taUEx3MzVzMVl2MnYxVGZZQ2cy?=
 =?utf-8?B?eW9iRXhXMzBoa2tZY3dLOXhnT05ERkRFektzMy9nRFQzeXkrUktybG9CbEdQ?=
 =?utf-8?B?Z3V6MDFrRSt4SVVjL0gvWWJqeWliK0RrK2U3MlNTQkZ4RzJoekdLVUowUFJp?=
 =?utf-8?B?ZE81SVRHZ25KZTNxZDAzeFNDczVCM2ZleU52QmdPemVnWWZBRVVHcmZMSjl0?=
 =?utf-8?B?VEIwODdINjVhVUJzbzNEaFdsR0J0eU1VeG4rR1lFOUhhNFUzbFluWUFDVFQ3?=
 =?utf-8?B?NkJRRVhEdVRDQ2pVb3F2b2YxblpJeWZTaUhaNE5PSlpiVHVFbmtmcXdYc1Iv?=
 =?utf-8?B?RTRBRkpuZTZoblhIcDVIQlVDTXVXNUhRM0RkOUVwY2xJcndEb3pRYWs1VzVw?=
 =?utf-8?B?bFhRZzZ0RXRoTFlRdnpPZ0g5NVE3OEpyTkZVa0dQWHBsamxoYm9VVnFPQmQ3?=
 =?utf-8?B?VXBRdi9GVHljc2F3VWR3TEpiNDJKNDBTd0xhdDEweXZvTWhMNy9QZTZxdFBD?=
 =?utf-8?B?UHBER3B0WWRpczYraXE2TEhSYmNhUEpJN3h5MDNYMUVtS0xUWHMzdE1PRExK?=
 =?utf-8?B?SHBEeDBTOHc4eGR4b25VanczK0VhU2NuRjNIZjdkcmpKMmpEZExjOTlnRWkw?=
 =?utf-8?Q?OCR/gwZoqrTlgUKU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C09AD9A41C158B4BB1E7D6B9072C72BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: turDWeU2vFbZdx3C5TQKsUs5rbWXAqN8I2WzPge+1zgeFVDr9uQhVN1ou64dwQ0UBhNFLdQ5X0pjov57jYTf50gnFDJlLwmq97L8zrCgAm12t3PlK/gIliNjIdrU3TSS+omiX/6RjlGL2haKq+kVAMeX10CTki9lM1FE0CxBozuv9L8UXVP/PfL0is095t7m41upz5h2ApH+FcWPW4sNKobyXdKEuF6GszE6YmuTu1g/OVZgDanqB8X0atulECA6x2tcGjC/gqHJA6XXhJo/2A/wFyx4Eo7vOLr6bLr0S3eftRyiQETxrFC1vzaKSrO1vAkS5xn9tdh7/qc2Q5D75Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d088509-66ff-439c-1f71-08df24d9be32
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 01:16:12.6691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qtFk6NNZDLaYJqjfFBfiGSASnvv+8QFeYhMowZxk4De4R2uz/Z8LN03ffH+acIDGRcgYkA0/arpGo0LVCO1x5bUoqBXcjAHS8UE+912al4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9779
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTEwLTA3IGF0IDE1OjQ3IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gQW5vdGhlciBpZGVhLCBjaGFuZ2UgdGhlIG9wIHRvIGJlOg0KPiBpbnQgdG9wdXBfZXh0ZXJu
YWxfY2FjaGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIHJvb3QsIGJvb2wgcHJpdmF0ZV9w
YWdlLA0KPiBpbnQgbWluX25yX3NwdHMpOw0KPiANCj4gTm9ybWFsIHRvcHVwIGNhbiBzZXQ6DQo+
IHJvb3Q9dHJ1ZQ0KPiBwcml2YXRlX3BhZ2U9dHJ1ZQ0KPiBtaW5fbnJfc3B0cyA9IFBUNjRfUk9P
VF9NQVhfTEVWRUwgLSAxDQo+IA0KPiBUaGVuIHdlIGNhbiBjYWxjdWxhdGUgZXhhY3RseSB3aGF0
IHdlIG5lZWQuIEFuZCBldmVuIGJldHRlciwgdGhlIGV4aXN0aW5nIGNvZGUNCj4gd29uJ3QgbmVl
IGEgY29tbWVudCB0byBleHBsYWluIHRoZSB3ZWlyZG5lc3MuDQoNCkFjdHVhbGx5IHNpbmNlIHRo
aXMgZ2V0cyBhIHN0cnVjdCBrdm0gYXJnIGxhdGVyIGluIHRoZSBzZXJpZXMsIG1heWJlIHdlIGNv
dWxkDQpqdXN0IGhhdmUgdHdvIG9wcy4gT25lIGZvciB0b3BwaW5nIHVwIGZyb20gYSBmYXVsdCBh
bmQgYW5vdGhlciBmb3IgYSBzcGxpdC4NCg==
