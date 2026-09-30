Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CB4BE454;
	Wed, 30 Sep 2026 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812490; cv=fail; b=JViyTsO4UfDjwjylz9yGcniF9NNkyYEG/4SEeuEIr/6j588UZdK3qlsUpqFfppzxVThFJhYNqXMfAHcRNgTWBnrFZ8dLVWmIgWrt/58PjJZWgivXKQ2iReWuCaWiCo+jzDgGRRPsnUwtgz9dAfjHqMycNXZpS57Ce+aGUjYlBqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812490; c=relaxed/simple;
	bh=mDoyruGvy1ztJNO0mtA40K60OR8hjLeF5/jcim9kAg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OximG/rm8p0OXcCZBfVTXdaBsQ5JHrxLNSUBaR/amUBZgzxWaPklL2krqrmFVCZE4isAoUp9QAHe5HUNXQrLbqV+mVxJ8ueggkgvlYhkBpEwS8Ie/9H/oBy42M1PRjvgdAkblWAySNqijJhaiRt3dnFI1yYezyFTnEKdJWu5I5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klaA1Cpr; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klaA1Cpr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790812488; x=1822348488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mDoyruGvy1ztJNO0mtA40K60OR8hjLeF5/jcim9kAg8=;
  b=klaA1Cprx7amycbnQ0f243Y6YpsKOxdtvF9hypwITaHbSgYLQAyC8ek9
   X8bpY5mopYC/u+P0EgG9KSDdMUbCrS2LTTVOwD9zD9b0qVv4QfxHyrLMf
   jh8EtsZ0Fq4BAWan+I+X60MKXbVkdsBkYxyKkUZeLeZa1w3/imM1wcYfM
   6OuVoKXed65ByauucZVRhXmiQce5qO9IlJRDb/4X+tZG/M+DM5Ny/GOic
   QptJG/XZAArvwskaelFkZgn/o0/UW777yUoJ0q0q13MGzhVSNY0aK6b/5
   9dC+eCaxwSGSAS7wq+KvpAjPNwjOzIaXcYH7rWksZyAtc0wS6ZCAGPtWc
   Q==;
X-CSE-ConnectionGUID: Kt8ecJJ2Siq546jnl/ruGQ==
X-CSE-MsgGUID: QnrhK0h3RjSNpV2hLEvfMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90695952"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90695952"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:54:47 -0700
X-CSE-ConnectionGUID: eKUKrequRwKJ1mkxNEzahg==
X-CSE-MsgGUID: 7lO8qplfQJmSBny25ENCiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="274448101"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:54:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 16:54:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 16:54:47 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.52)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 16:54:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaxQxHH6f0dUJZAgemwaLEOWPcc4CRbIHiUW7wgDQaqPwzlue45Ryy+uO1qN3gEA6eHMJufovyvAPweqFKgLo3reJUEFuuJynvVb5Ak42EgTkDE98p/sTdv2Bcru25o+04GQ2kU30PNCrEvssPPYvNowQOdkgRP2zzuxW+SxvovaWaQSE8k5IuijtH4MecOWlCVLsATJ3/NLWlxly4kfz1BpOyqA7zBObl7i6uGEnBZvyHEewkIv5p2IrJZpSTwA6QTwUiUxuZnyCcbvHzGzIs2qcU0hbdBGk4uJQY4HYHoZN3j5b6u5JCHYFpHg3jD6ze3+ZjrVdoveV7Ad62/Shg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDoyruGvy1ztJNO0mtA40K60OR8hjLeF5/jcim9kAg8=;
 b=DdpHK6n0x2qJo6YOkRZ8IRAuiDW2gqdexo3886Q4/4ifPDgVJz4uQb6sRCszw6AREzF0eslnZzfYq34qquw7tz8i12HmadO5GcUnEShIh56lTerLdsyQlm3w1PzP6VrwM0VGml61M6v+7Ew1BDmC6BTpetJLlvvXID4IvJ85cB9Dw6BcMgGhi4gdpUjnG/gIYbt6ERJEPpUtuTuh9J8WNcJOrItz3tRBOWV5fLgG3/Zz3zZ6ARhf8TNINiHV6d+6VG8HTb57VH1FLLcERAlTiryO/EWmSiCXvWlN8VfCqvnnq0yFknd8lG0zh65wm11SPmCtba6VEybvNtl9INRKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB7826.namprd11.prod.outlook.com (2603:10b6:930:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 23:54:44 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 30 Sep 2026
 23:54:44 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 07/10] x86/virt/tdx: Convert the td_conf metadata
 reader
Thread-Topic: [PATCH v3 07/10] x86/virt/tdx: Convert the td_conf metadata
 reader
Thread-Index: AQHdUJ5P3MQ1gugT/EygKLwzJpWEjrbnzOSA
Date: Wed, 30 Sep 2026 23:54:43 +0000
Message-ID: <763dcf982570e0ffcc69a6e1922fd2cc266539aa.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-8-chao.gao@intel.com>
In-Reply-To: <20260930053901.22528-8-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB7826:EE_
x-ms-office365-filtering-correlation-id: 00af597c-4088-48c8-7cf0-08df1f4e3365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: MvBTVHXpHJ+v46CHzJUhdFE+2DYU9hC90szy+F5CHy7XLabmKXMqs/gz2AThyFJbkLVHuOxblUd5xpf8D9XbXo0aklt7GdaZ0hKsK29x3BGuE717wxlg59/8fPiZeYCW+JAErJJo0SUby4brnQpiwavVeoWorshCjzCguTRTim3V1WDuH2S59B9uVlVp/gnQxWRAnUuvDEKGGmzHh9xAIRj0uTtciE5F5/wKV00i6JC/QnuLj/JQR1s67k2RSm//D2S7Og5kxfo1D2PdPiANHiKntHUeTKMeqmc4i4Y7th7DlmBk2t/j/PJgmNhKUgHrOYN31SkTkJVWW5oJUeBdDD4jBmkKcgnaEo+SF34+S3cgkJkVeEbfSgbd5zWCmfLN3lzt/V3Vzc60pfwBt9pWOVeWY6vMpYk3kaG4muo2KLya0sdIRHBwabjwM36jwHxXwpnue1f7SlNpc2lyIu3rXQsEK+9O4AvmjfI5zEgycfQedli0Lh1tzru+1hjSXRnrc57gv9mDcTHfQmBQ+fMHVdYpBTAukNO0we1p1YIRcsccr4VTjMZErS9N28yOZsipdgUlbh5DqOIqDz36NfYh7eIJqwIuPRUe2m/COpmiuhsy6ZhEQ5KRHGa86mnU8QLy/fwODqB+q8Huto9UIYklq/3nIc/BQ8gC2ZuNnV4eM1xuLXB6svE3fhqdPCjFyzDYLPH1ZXUu1yWV1IrI01bJY+ZSpF4m2r3gOmoOkKVLmN0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWtqWlMyamVYSEpBNHVqeFAzYlRrN0paNDc2Y0I0S1hDY1RXZlBlU1ZYV2Rq?=
 =?utf-8?B?K01RRDRBbE84aCtBU3MvSDArdkEvQ1ZwM2phSWdBRWExZFRMd2xVZFRJeFho?=
 =?utf-8?B?SkRLN2MxNEErVk80dEFYUUJieE11TWVZOHMwNW84TzZWMi9xSEJ4MUFqK3lQ?=
 =?utf-8?B?cWZvekJQQWNPdnFrcmMwdEdUdXAyY3hiVzN0alpPLzdpRlpSakx6L2JCb2xW?=
 =?utf-8?B?bHNDeDNzNGoxc1RYTHNiYVRFanNhdmFZeHU1QUMzb1gxK1RqQlpLcVVyWFVW?=
 =?utf-8?B?ZVY1OEF2Qm83ZmxWbFhCY2R5VlZ6YWVLVFZoZXUrL3l4K2RzQkNZVHl3QkM4?=
 =?utf-8?B?WUFzam50djBwOGhaeEhMSDBmQWt0QTFrVDBicGdwVFV0QldWcldKYzJJWlIw?=
 =?utf-8?B?bzRCK1hFdUxoZ3VRYjZpWE9TYm11aXlDU2VGdndaSVpQdU1tWlVuSldROERG?=
 =?utf-8?B?RkpZUWU4NlRVb3FycTNBMElsSEF1dWIzTlNFZmVydDZEVnNicE5jYmgvaXJR?=
 =?utf-8?B?VFNNR3VySnF2bWpFRXJUZ21tL3hRMnd3d1B4d0l4QXgzSmlDK3VrMjVxS1R3?=
 =?utf-8?B?Z3UvYi91Si9rOEZOQkVwRGMzL2k0a1VHMGNiQUd2RWJReEFMNzJDK0RxckxR?=
 =?utf-8?B?S3JGbENHenVtTFdkVGpsczZFQVNNZ2Fvb1FhbnJUSGNhMWZFNno1TElmYThS?=
 =?utf-8?B?SmFFbUYrYndUdHhxZWpycE9wQzMvc24wTkNrbnIvd05WVnh5WU5tM1Z5RXQz?=
 =?utf-8?B?R2pDY3VGOUVZM0RnS3pvd2xUVWc1V3phelJ3em9BOWtYRmRJRm9xUm16R2RB?=
 =?utf-8?B?Y2k3aVlCVmpwT0MxbTdFOVE4VGhvSllBUURKcWJLSWNySU4yNG92SmxBYzE5?=
 =?utf-8?B?elJXbnBQT0hTemxqcDlNT3lFSFFWVDA2SzlSdzFYbnh1cHd2MkczUWRaYkRC?=
 =?utf-8?B?RGZSU1NnZTFPQ2lsbmh2UDM5dTg4b1Jib3NmTFZQaXgrTjhFVjAyWGtCdzEv?=
 =?utf-8?B?SDFlVmdRSFJjYU5lQWMycWFLdHBSNW9DUjFlMWZOQkZqcjQrWjN0UVd6VHRj?=
 =?utf-8?B?eXA0aDJQNHBDSzBEQWVCK0VsbFBnOVFxWFZhcmVSTzhpazVDSHp5Z0NXVTQ2?=
 =?utf-8?B?c2VpYUF0RTc5WnFrZHB4VUxWckgrQ3ZHLzM5bjE4Qm5ldWhRdkgydHhwcEhm?=
 =?utf-8?B?YkJlb051UEJMcVJGanFtV1FjMm4vclNCb205Tm9IeVJGWEVFc25IYjBRcXdN?=
 =?utf-8?B?ZUFHbU9EMGZVZGh6VGRaODAvTXUyMTRiR2ZRR2pZSHI3Ry9GRjFOSTIwOVh3?=
 =?utf-8?B?YmNJZittKzNYTFJlTVBDZ2lJVk4rY3ltZXIwOFFSYzFLS2hlK2x1S2d6Skty?=
 =?utf-8?B?MVJvbSt6eHZ3YmRsVGtRT3VNdnBVeWFZT2N4czdKbklmSUMzOGVlbEUvZGdF?=
 =?utf-8?B?U1RnOVZFdGI5OWZNbGRUUldKVXdXZ3UrVTc3MSt5d3lGakZWYUxEa0JZSXVt?=
 =?utf-8?B?TU5kNFhuMU9ZVmtZMkRiRHkrcDhmU2dXbjJjeU01cWdmWFk1MENoWUxRVUtk?=
 =?utf-8?B?REpPRjF4WVQxd2t3c3J2OHMxU0pVY1I1R0VxWUR4UWF5L1dTUGNlaVhkZFI1?=
 =?utf-8?B?eklsSUw3N3lkR3phZ3lVbWxDR0ptQmZoMEU5YUdNa3RUUEJMQ1FqUUdFdklZ?=
 =?utf-8?B?NTBnSTNvN2pKR000eGNVRGpZazVtU1hWMzlCN0hvUWFoTEtaZUNwVnAzM1lL?=
 =?utf-8?B?MERJMUV3SHNBV3Fyd1l2VDdDajdiZU00eFVLWDVCTHl1YUhkZjk5TFNNVGR6?=
 =?utf-8?B?cHpmZkljMyttcytRME52czhNU0paQXRjSjMxcktZejRMdWdvcWI1SXozV3Bj?=
 =?utf-8?B?YTZTNUJreSs1MElCYWRhek5DYmpQL1JrMS9sNFRHRGcyRnVQREFlUlBXV25C?=
 =?utf-8?B?UGdzbWV2MGpBQVp5QkcySzFJRDV6NDlVUDBEeVMxR3RwUk5OVVl3TWwzWjND?=
 =?utf-8?B?Qk9IMk5iN3JxSHIweDA0TFlsb0RYaVptWE9qSkdQWEdpc1pESkRNNTVlWTlZ?=
 =?utf-8?B?bVNpK3pnTVIyQVJEOU95NzZBSGVtTVNMV2FKM2tzRVhkNGdaNmY1cDR0N21X?=
 =?utf-8?B?OWZNdk8wLzBmT1FwZU92Z21IMkJrV3RzcnVsUjZ6bzNnNm9OVmlXbFVYRTNy?=
 =?utf-8?B?dDhNZk84aDJpMkEyNm03SUZuUU9sVmx5Mm9WL25nQlRYQUpvcmd2V1J3bENI?=
 =?utf-8?B?cUk3eEFkQ0NDdGJ5NmFwNmI5emJnQ1dGc2J6SHdLM2lUUnZJMWtsc3ZYK3F6?=
 =?utf-8?B?eVo2NDdiN3hNcDJxRWlJV1JXZk1BME1uNVZFL0RrbHVSdG9KajZsUlhUU0g0?=
 =?utf-8?Q?3m701IS7MRfRr6lw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <116CCA2ECBA4094A9BA7C1C685C67FBE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r1R+zT0Jny2LCQHWBNws0PXcdna9vRv6UgUmTZdQEndtoMwlr75GNrV6H/KKb0hCnG84f0pJJefFbBjSLqx8eT405/MIybeXlQ0osUGAyvNRUv4FtE2HKMpD4wBKeqcHl7f3VegzL/mU1mhihZYkjF1ASGxzTkrA2oZvco+IGVbt3WwwPiFc+Zmi6eEJFZd4paalK4c1CvFz2fPoCIWYaxz/0dfhv07apOVvPTSk+uD1+SxJfhqPkXTeYYzoLAOZH2mirSuXD75KoQV4OUEC6yQGuJgXi0Bedgr6+l4WsiwOR2opLkZNcIqfZUlQJQ1np+Sydt3DvmoTJbiMIdcEFQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00af597c-4088-48c8-7cf0-08df1f4e3365
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:54:43.9728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0k3qRLU65dypK54l1GzKAl9c89nko4iNJJY96P1f9ahSS43piqvBwK1Dqg3zcoR9jor8ht493XGCLYxXJl/2S3STvpY7vjTcRStaUTI5qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7826
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDIyOjM4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gKwkv
Kg0KPiArCSAqIFREWF9GSUVMRF9DUFVJRF9DT05GSUdfTEVBVkVTIGFuZCBURFhfRklFTERfQ1BV
SURfQ09ORklHX1ZBTFVFUw0KPiArCSAqIGdpdmUgdGhlIGZpZWxkIElEIG9mIGVhY2ggYXJyYXkn
cyBmaXJzdCBlbGVtZW50LiBUaGUgcmVtYWluaW5nDQo+ICsJICogZWxlbWVudHMgZm9sbG93IGNv
bnNlY3V0aXZlbHksIGluIHRoZSBvcmRlciB0aGV5IGFwcGVhciBpbiB0aGUNCj4gKwkgKiBzdHJ1
Y3R1cmUuDQo+ICsJICovDQo+ICsJZm9yIChpID0gMDsgaSA8IHRkX2NvbmYtPm51bV9jcHVpZF9j
b25maWc7IGkrKykgew0KPiArCQlyZXQgPSByZWFkX3N5c19tZXRhZGF0YV9maWVsZChURFhfRklF
TERfQ1BVSURfQ09ORklHX0xFQVZFUyArIGksDQo+ICsJCQkJCcKgwqDCoMKgwqAgJnRkX2NvbmYt
PmNwdWlkX2NvbmZpZ19sZWF2ZXNbaV0pOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJcmV0dXJuIHJl
dDsNCj4gKw0KPiArCQkvKiBFYWNoIGNvbmZpZyBoYXMgdHdvIHU2NHMgb2YgQ1BVSUQgdmFsdWVz
LiAqLw0KPiArCQlmb3IgKGogPSAwOyBqIDwgMjsgaisrKSB7DQo+ICsJCQlyZXQgPSByZWFkX3N5
c19tZXRhZGF0YV9maWVsZCgNCj4gKwkJCQlURFhfRklFTERfQ1BVSURfQ09ORklHX1ZBTFVFUyAr
IGkgKiAyICsgaiwNCj4gKwkJCQkmdGRfY29uZi0+Y3B1aWRfY29uZmlnX3ZhbHVlc1tpXVtqXSk7
DQo+ICsJCQlpZiAocmV0KQ0KPiArCQkJCXJldHVybiByZXQ7DQo+ICsJCX0NCj4gKwl9DQo+ICsN
Cj4gKwlyZXR1cm4gMDsNCj4gK30NCg0KVGhlIGNvbW1lbnRzIGFyZSBub3Qgc3RyaWN0bHkgcmVx
dWlyZWQsIGJ1dCBwcm9iYWJseSBmaXQgaW50byB0dXJuaW5nIHRoaXMgdGhpbmcNCmludG8gImhh
bmQgY29kaW5nIi4gSSB0aGluayBpdCdzIGEgbmljZSBhZGRpdGlvbi4gSSB3b25kZXIgaWYgd2Ug
c2hvdWxkIG1ha2UgdGhlDQoiaSAqIDIgKyBqIiBhIGJpdCBjbGVhcmVyIHRob3VnaD8NCg0KSSdt
IG5vdCBhZ2FpbnN0IGxlYXZpbmcgaXQgYXMgaXMgZm9yIG5vdy4gSXQgaGVscHMgdGhhdCBpdCBk
b2Vzbid0IG1vcnBoIHRvbw0KbXVjaCBmcm9tIHRoZSBjb2RlIGdldHRpbmcgbW92ZWQuIEJ1dCBJ
IHRoaW5rIHRoZSBhYm92ZSBmYWxscyBhIGJpdCBzaG9ydCBvZg0KaGFuZCBjb2RlZCBxdWFsaXR5
Lg0K
