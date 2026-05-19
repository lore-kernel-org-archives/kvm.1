Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E733985A
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159831; cv=fail; b=D5h75klm2f8MReH9zs9eJrpumJ3BMvXt17Bztwetn/OVjWCqqIhz/hHHUuawnRGoyAVnHAZk8NmZAydIQNqZL6Tlg43AHkdC+kzvKQe6mJOn2u/QalB+iOnTtx+rBtJkH/+QpCdqGu/GzUoxrMls0qBJ6icqTYnKaxDLYj9jPYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159831; c=relaxed/simple;
	bh=s05pkETlGSrq83pEb67ywqeEE7pWHuQ3zGDESlue90s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mHUu/a5UcOIA5GYEVR5LNM0/1W16zbAeo+WMOHWxku2GnfyMGTDugOpH8LJ6BC5p3lGdJI0TD0ttalCnhSllWZvacawc0uEYOJ3189QibaGsb5l2vKPgOxuKikXBnbAzxjnYtTQszC9epWJGTIveMXVagFIYICerGU+U0CKeodc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l89YwSzK; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l89YwSzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779159830; x=1810695830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s05pkETlGSrq83pEb67ywqeEE7pWHuQ3zGDESlue90s=;
  b=l89YwSzK3olKwopP7KHogpmgF1jXnm1J4q8XD2n1BHyCkMBwmGkROgVi
   OcwY0Dq5MZd7/7bqqwB8t30matFHcS34gynJKBiH5PE3TG0Hc/jkSDWBc
   koTcS8+AVGxHsQJj5SE0Tdl4GFSrLWIvgDi5Il0xw1rfrOCFw6sXLNBgg
   hq6Xsoiwm3iNv/KHH/A1/nCTYojqQcIhw2/k8F95U9Rz/SH5jnmFF1Y7M
   tFpIucoYP8Zn3wExJDrZb3tXY0PDrvkNjVsflhrWzOnvccAk+B7JGKWyX
   Rijl8JfaLlxuY9iA9rsKSMeZJlgCjTCEf+gWAei9eyWbpgQgGCc73+NM7
   A==;
X-CSE-ConnectionGUID: gjSAUyqRRyOqnNFVN605kg==
X-CSE-MsgGUID: +Jc5H4/2QqazR7wsKIAsLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79050745"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79050745"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 20:03:49 -0700
X-CSE-ConnectionGUID: XksHqGmlTdGqs2TA22F3Zw==
X-CSE-MsgGUID: CqcNEg3kR/6JKyNZJJPlzg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 20:03:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 20:03:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 20:03:48 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 20:03:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CluNHVA3IO1O7pWgWgcw2QF+eJHL7EToZpozD0eaavTzR96V1rB/LBCjtkuFbCuHVcCK+ztB1bq1LSG3qbnft4WpjaNR9XfsPPuKA08zW3WjLA/RzliNpcLTsEMlvxJ3IazgR9gJXUgdZPkVnH7uYOoT5HC6S7fQmdNeQaM6ylyiAVMEInR2bRq7rC9y6Ia4/ItQ7LTw8kdWOlU6daAknjpDmePI6yIyAL3Zy8qeX1Gk+K11f3p1yIsPS7JgjnG2K2SWfS9Le3DzO1e87kvaqKEWe1wxKoEixaqHtKJESk9aemkGK2GZX3xmprMHUOdsIlX82lBxmAAIPcK6c3U27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s05pkETlGSrq83pEb67ywqeEE7pWHuQ3zGDESlue90s=;
 b=ObfsjKn2wZjxxjLN7CJYZbqsCcsD/KbtPoRuW8PG5zoUnafE484HJj9kMo10xQQg71yeceNrOCWnht68yrthKYTlMPnjnDztI7rT8JvBAH9OjIYg1P7yIg8e/i+vzH5g+xM3fcUMThQ3lNzXjU3rQpphCkUQexUdMvfxwugX4yzaLCK76BkZr9TTZbxnvzk6zO93WyvBde2qr+tAuvDjBzkABhW4FU7Xt4DZpQ9prmQuwWgH/1T74zT8cIjp4v9ooAd/JV+QOfi4pBK8pCDLHr6+DOXiWy+/fkRl/tzmS0uyGgOpqtQjMzp+rNK89xe/TJ5qqR72lv2wxAz4ttCjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV3PR11MB8673.namprd11.prod.outlook.com (2603:10b6:408:21c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:03:45 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 03:03:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Gao,
 Chao" <chao.gao@intel.com>, "Huang, Kai" <kai.huang@intel.com>
Subject: Re: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID
 verification
Thread-Topic: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID
 verification
Thread-Index: AQHczjxZm3NIUz3Mfka520SfE1BvJ7YO55KAgAS0S4CAAG0YAIAAa+iAgABfMACAAAewgA==
Date: Tue, 19 May 2026 03:03:45 +0000
Message-ID: <898dd45e6b8e0cab6c32098236a0550b5a42dd98.camel@intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
	 <50ccbe42-4b74-4c2a-b530-a367f7285de6@intel.com>
	 <bf569f46-8690-4f82-a2a0-d196970880de@linux.intel.com>
	 <agsiQGikhZA0CGTY@google.com>
	 <64ee4f0cbb158eeb21ce5581346359cb338d3ae5.camel@intel.com>
	 <823c8399-6068-49af-8481-230e2680679b@linux.intel.com>
In-Reply-To: <823c8399-6068-49af-8481-230e2680679b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV3PR11MB8673:EE_
x-ms-office365-filtering-correlation-id: f35af956-2973-42b5-4b01-08deb5533dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|4143699003|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: grcyaaaGWloxbXgzANYlHhDy8obCc+BQS0EE6iIuOtI5ZqtcUnzTbqRCy8eV8g4Nhdb92IyCsmE7HfLf3a7RUD2yx/A4kYdyyYiRclz9Ku+EeZ6nWNbkclcVYbOr1jIiQYLE1cLiuYVjUO9qUSiPsTGltlb41NKkay/Oj2AiiiRTpCENC2WhHv1fy1AjFBF94hscsCN0ZqH85Su+6f6FrSGU0YaGhCR3oKy91Oxr2bbb3Wj4j4+iWxH7E43nowOmYka4XN/E2iR0mcasdHOtm3wWUs7FLIgrrDqtoWOSa8Uz786vGAYKaYfy/Z2tC62xJsRVO9JAxa2iQlfmy9dsDTkK8Ab1UzzVEIqAKZvVsAoJzdWR7SPBr6pTPIr6Lkktjio1zMOeWuS67wmDsmBBZv05qo6VIKcD+D20SfGaIg32x1WIvzwfnqR77TCr+/uJ+Aqijox1n7EbktobIojXW0ZON98shjNmVYITvnLIVCSrkgZUNO6d05b5p56klxzp0Z/oKOUgT+PmXLPmjbp0obQe5gb6pwbBfFpNPwqIFCjtwOfx9P831vS9pVRzKUhbT4pxgccr4ZVvDk/y4DEJFD10cgwggLfgUcFMGNRNiq3qlX21MIYDotkDGEdqG+mN9yTbt49Yew0drGSDd0SMTtt/eGugwKCcTnYXxAnPBgqcGClb1nhsJb/SqC/w2ZEGAkNk0kJVhyfbHBMVu9sET2n4dY9x3YAAtY+OlqEaOninSaUCF8ONcPZwoXCLP3S3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(4143699003)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blNScnhDQU5CZEVmRXpZbzdnVG9RcS9LOWxlQ3ZMUkZlcHdLUEpmOWYvaHp1?=
 =?utf-8?B?eWhvd2d5QmtJNkdUbFpVSjE2MFNZdEF5RWlYcnZpMWdMZ002UWlqaXNXVUdo?=
 =?utf-8?B?TVR3OGtwcU94WlEyaG51TTRYZzU1VHozT2h0ZHdMSUJiaUk3N1hzYVN3L3ZG?=
 =?utf-8?B?cDFpdGpRaDdjdXhQWXZOZVdZY3ZtRG1SUm1RM29RR1BRdnFvN0RZTldwbjJN?=
 =?utf-8?B?QW42K0pnck1ZdkFuK3RvK2JmWkFiK29HVnVOVEVrRjhvTTNxUHVYNTAvazR1?=
 =?utf-8?B?Y3N6em9KbkJyZDF1RFZ6RGg1T2pXQmVxKzVKOVNLM0dNdW5qenV3Q2ljWk1p?=
 =?utf-8?B?MUlKc2k1WjhSSEhxOGozZjBEUmtMZWp0SmE3TlM3UVlUSkU1RXRLRmdLK0lz?=
 =?utf-8?B?OGh1Vi85VGx0NHFCVC9GTHpPZFZnSWptMEppVFI5WEkvUUc1SE1ReTcwdUxo?=
 =?utf-8?B?WVBLbkdKREd0MWU4OVEwRWNHYnFtbFk5VjF4ajZNUHBnb3l6MkdDWkVkNlkx?=
 =?utf-8?B?bXRMQlorem9XNUdOZVVPTHlyVHZMYmo0eFFzYjZqTU5BWkdTZE1wSy9CS2w2?=
 =?utf-8?B?WmxmMjhGVUJlRFVCcEhxVWl5RVErc0VFNmdqb2Q1YURqOFRVekVEOFUzQVFB?=
 =?utf-8?B?VTBvQXZWS2dsU2ZBaVdSVmFLZXRrb0pBS1ptZTVycVN6Uy9URkc3Z29oS1V6?=
 =?utf-8?B?NzZuQnpOQysxT3RaMk9DaHRKSjl5amtkODJ4MEJyRWs5RHNGWmxiZWJUMzBO?=
 =?utf-8?B?c1l6bVM2MEl5WUJNL2RRclVoVVVyWVo5SndpSUJiTi91ZjJrbTVRZWNZbnJk?=
 =?utf-8?B?b0dTR3ZJeTFmUi9zempRempkVFJ3UVZBSUNIOUkvZFgrN2JOdElGamJhSHdo?=
 =?utf-8?B?V3VIZGxXQ2dycUE2cFdKMWxySzN6eVAzRG5wVG1GRTRjVHJvcUhkdXE3Q0Iw?=
 =?utf-8?B?b3lDbW5oV1FPeHJxZmZKeDBERXY0RXdYR0p5QXRqb0ZUTmJtNGdRV0ZTdU5i?=
 =?utf-8?B?NjRKR1oxb1F4cDRJbnV3MlJBQUxmVmR3VWdHMStVaVZpMjBCY0Q3cVdtbkRJ?=
 =?utf-8?B?QU5QWllLUERhN3RGb2g5aUp2QitqYm9aRDAxWENmVXB3a2VyUW1IZ2doV21I?=
 =?utf-8?B?T3NwWGxaMmljUnB2WktUd0VhNStBUDh0SHBiOHc3Ujludm8zWFVXMlNpWkI3?=
 =?utf-8?B?NWFEYWtUQW1hYW9VbTh4TlBHVUZGTklJeVJncis2SGk4OEk3WFRoYWttSFk0?=
 =?utf-8?B?N3ZWM1RhQzdzM1lJZGpoNlJxUEpJQlNyTHNLTTFOa2Z3NlMzalhRWjFBOG1X?=
 =?utf-8?B?a09uWTIwM0laM3IyZ08rb2VjQncvcS90b3N3cGFkK3VDN3VhMm9NVlhoR2oy?=
 =?utf-8?B?alB1TTU5RzByeHdNemxBbjNmZGJNZVdHYUF4d0hiNHhiTnA3aFdtWmRndWR0?=
 =?utf-8?B?QUdvRmMzb0VXZVpuY1NXdUoxd0FjUjFBVUZGL3pQa0p0QVhQYlVlSXNGS24z?=
 =?utf-8?B?UXZHd0YxRXVsa21Za1Vja3ZBRkFXMk9uL3grenA2dE42TG1ueTFxd0J2RWUy?=
 =?utf-8?B?OVNzeTMvazkveDBrVGROMm9KNDV2ckMyL3RINXVJOGtoTjllQlRySHVsaC9T?=
 =?utf-8?B?ZkRuNklMRC9aK2tqT01XajdNeTc0ZTJ0SXFBUnNkWlJtR2c4cnNIMkhnZjBB?=
 =?utf-8?B?SnloRmlOcitxTk8zVUtRWHhSWjVScjRVYmthVW00Z1RrYjNDMlVkanZyWWJP?=
 =?utf-8?B?N0EvTjZZT1hJSUxkTFh3a2NpdEpjMm8zMkhSb1pFdnN0WHNlL0hyUjNwaHJn?=
 =?utf-8?B?NitHUC9TOHJNbXFnOGdMYUczMXYyb2ladzVBTHl0eXRCdGFLbzlSOFFyVUJz?=
 =?utf-8?B?VHNhSXdMSm9sSndGa01GT3dwZzZxSTBJcFJjL2hRYjNhSzRQb01QV0FKdDha?=
 =?utf-8?B?eHFQdFRYYmRGWUFKellnMklYdElqREdXMmYzMVlwUHoyRHhTNlJVNkI0TUpn?=
 =?utf-8?B?WlZjZ1pEeU93K2tMdEViRVRpZVJrUFdqbTV0L2F2eDVOTEErcmt4N01zVXNj?=
 =?utf-8?B?TnZiZ1p6anF2MWNHejBnWGdhbWZSbXVvUnJUTERLZVBUT2EvQmd0V0V4NTYv?=
 =?utf-8?B?Ky9ZUHhJMzBVVUJvZk54b0RZNHpDZjhMVHFOSWZsVzdsQlBQR0RKWjB3SHIv?=
 =?utf-8?B?WDkxMGc3SXowaFJPR1NpM1QwRHIydjhhaU9aTlRHVU1pUmVYRlF1WWladDBH?=
 =?utf-8?B?NHJmMzRVQVlJQzBJU3RXUG43SVoxY0szZE95QW14ZXlXMnJTQ3dsQi9FVS8r?=
 =?utf-8?B?dEp0bWZUZms1V2IxNHlkUlA0ZmcxL25HYnJnVUdRSmN1Nzc0R0d2RUdpZGNa?=
 =?utf-8?Q?8oDbj5H2m33NLKIA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECD0084CB3853A41A1C466CE4484F736@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IvKvoKkcO5SveJ7ur6CprV6i9UuJDctCMEx3vOL+mA8qNPUFRh58B/1OKw7ztADVtNreqBiUBZUQT3sZwNb3+awXnkYGlp4x8pvpIeHYB8TTAeS90Zms0acmLxt3OkD+j+8RA1x2xcPnM5mQ9xVdtM/2xWLQwueO7M0s56BRr2QbOA656S/c1SM20eV39c23etIHvlPM7vow4sQF2RpDjxYEyFMW/FtdSmisgBkWTpbaa+ka4g7VZqpmtNVWMwfJK9VzKbCvrEF+Yg0X1FNRAWJ+fw91QRlO1m5hhm3OApL5WlQuawoMHsYJ49MA0arGHT61xjM3vzshJ7rkEWrxfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35af956-2973-42b5-4b01-08deb5533dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 03:03:45.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZVzIYRs0jKbuCce/rZvgZWad8/4flVep423pKIi+UsmOn2LtmUQFrd5t7MBQov8v1nKSsOOFRHN+SJipTNQwugEKAk3CgJTgw0xx30lTX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8673
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA1LTE5IGF0IDEwOjM2ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IElm
IHdlIHNwbGl0IHRoZSBwYXRjaCBzZXQgaW50byB0d28gcGFydHM6DQo+IC0gTG9naWMgY29kZSB0
byBkbyB0aGUgcGFyYW5vaWQgbW9kZSAoaW5jbHVkaW5nIHVzZXJzcGFjZSBvcHQtaW4gaW50ZXJm
YWNlIGFuZA0KPiDCoCBkb2N1bWVudGF0aW9uKQ0KPiDCoCA3NDAgaW5zZXJ0aW9ucygrKSwgNDk4
IGRlbGV0aW9ucygtKQ0KPiDCoCBUaGlzIHBhcnQgZXZlbnR1YWxseSBhZGRzIDI0MiBMT0MuDQo+
IA0KPiAtIEJ1aWxkIGFsbG93ZWQgQ1BVSUQgZGF0YWJhc2UNCj4gwqAgNTU2IGluc2VydGlvbnMo
KyksIDQyIGRlbGV0aW9ucygtKQ0KDQoNCj4gwqAgVGhpcyBwYXJ0IGV2ZW50dWFsbHkgYWRkcyA1
MTQgTE9DLg0KDQpBZnRlciBpdCBpcyBhbGwgZG9uZSwgbWF5YmUgbm90IHRvbyBiYWQgU2Vhbj8g
SWYgdGhpcyBpcyBhIG5vbi1zdGFydGVyIHdlIG5lZWQNCnRvIGdvIGJhY2sgYW5kIGdldCB0aGUg
b3RoZXIgRlJFRCBzb2x1dGlvbiBnb2luZyBhZ2Fpbi4NCg==
