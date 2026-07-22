Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EF3EDAC1;
	Wed, 22 Jul 2026 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739517; cv=fail; b=u6fKpDyWWbkup4Y8S9nwg3qCwn8D6g4p1STFxfqg2fp6pvZSbeGFbcDq8lWk5Fnssn8YivBJbVCFm8/8ZNc4x1j8wEvmfURFBPVzjWMPRkGH/3UKenMEJcVwFvGoOq6o/0UGLXoijulhtPdhgmYpc2P02FWKnMpFV9kBe3y0fGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739517; c=relaxed/simple;
	bh=aOF0xjj96KvPlg8NGBOW/pdK8LdM65/9P4QGKm6doSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aDzhseDXN+Pk47i6yjJxKeB7EYoWD5jSf4+udf1A4iXSiWA3VwT2oZh+6nd+fKsilyKQApU1f3cYKMMYMScvZ2SCrlEXQsWBCMhOyCV7cP+Utg/xl22mb4f8FSOep4au9PAyC+7Z0mMxry8CEH/3EPxK+W6xucz5Eykz8gE2s7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPAQ0lw1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPAQ0lw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784739515; x=1816275515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aOF0xjj96KvPlg8NGBOW/pdK8LdM65/9P4QGKm6doSc=;
  b=SPAQ0lw1nw6YFc+i3DpOprv48m/NFFmlQnXuyL6la9lbLz9GFKD6fepV
   f/Y+//W4m62Pl75blK9AWDhlWu5w9SXcegIF1AY+0v4ElcAGpoKIIedLt
   5J0YR6K9q3egHtXXKBmV383ZDcZROfuCXa8FIbflVQnWCqYkpktLypCdg
   3his1ZZjn/h0fxOI4CscrrdepbG2pghyadFw2l8X6C1j43tvl+ooSw7y6
   JLnmx5AsfuOAB8zjxWcKx0GD/hIVHN7yKUiHpYMJp4dRO7y7YRLukJsIy
   sSEHEys3RDB0kJ8vDjbTiPW1HKE71ndcs5q+nKGyNpM506+2985HoR/n0
   w==;
X-CSE-ConnectionGUID: tOVzU9LARri0/KJNn0ehLQ==
X-CSE-MsgGUID: ipk7nr0MSkmXQ1kode5U6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85254221"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85254221"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 09:58:34 -0700
X-CSE-ConnectionGUID: AzhZYkFHQdSeJ15VqftNyQ==
X-CSE-MsgGUID: TCpuJC/zSzyLN2EKcfAOiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="296356420"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 09:58:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 09:58:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 09:58:33 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 09:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niTdTftrgEWrNgYKBh3HIRRgDPCBlK39FAZuLjwwNQ8XR8xLMJuPumB7/aNPIrbTGEJ0P0dP3L/CUKlM83UDpG1GvmM2U6VTvDP1f/JPvcOA0cybQCuGdExoIjvuh2lOjiHDeuLi6OoIt8O5QX/whwmyuPwl2/v4l21kQHSBjg+BobkYhZzdFMvSuNA4rXYIf15K1gwehPYOQ1vvcfXPUK0a3Mbx69rApYo/jWgTW5FBOAmaf5hKOO2jVSGb+OUCfDXpTmhfJxxWkFJVQ327ov5Rh7AlDEVY8op1gmgIBiu77n4z5KqkUvVYvVujTbBYzhVGAvE1NKu9lMpJQIlyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOF0xjj96KvPlg8NGBOW/pdK8LdM65/9P4QGKm6doSc=;
 b=ueN8TNGrwhHqICOIq3Y3Jh7weJ6C6Pe7o9RkuN5fOljbbz4cdBKP7sN6CJ+lFyzVu0GrdR0t5o8lDbbKJqHg9NzW8MSMZ78Gcv8mwpGIU07pDDSgzRQbNzGrBLwjdcWP0LSvFwnVJssK2+sQFxbDi5uQ0RegO/HRuE7IjKjPlojcjviZaZvRcqK+Skq6yw3cqcxJgbo8+lYPMdqtwrUQScw3+mf5TsJNskKXFpFszhZwGOySHSinFQCC+Dc0LFmmNc/rX1HixaWIT2C7jwaLlqheo+Dq5fob7QftV5lXa4p+Tetg8WJ1Zu463Ti4vjFr+KtXWwgnPZYiWdCTvFHiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS7PR11MB7932.namprd11.prod.outlook.com (2603:10b6:8:e5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 16:58:26 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 16:58:26 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHdFlcgM4x/Hv8VdkeOGppLXPcVVLZ5nxMAgAArx4A=
Date: Wed, 22 Jul 2026 16:58:26 +0000
Message-ID: <85ebafddfca4fb83978dfae8cfcec92ccd3749c9.camel@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
	 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
	 <amDSvGlgaQRWnWfP@google.com>
In-Reply-To: <amDSvGlgaQRWnWfP@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS7PR11MB7932:EE_
x-ms-office365-filtering-correlation-id: ae2d4f50-2b77-4f6c-6c76-08dee81272e4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info: HDPqLaabSYDwC2GHcphhpdWT3t9o18gL6xKnpL0pCVGyFplD9rW2BKPXloCiGp/IX3VAzI8n4/JuIiq4PxdzB/3S356M8KDs+Ly0higaiKruyGacp2VGOZrL8qaaej6rM+rOt+pEuLePXdCrcYcd2qslfrJwOcXxEZ3HwgA6q86A9frd5Ek40K5SIaw8rydSxjKSC3OrzVaFBL6nJLEdhKrVVrjPNr0AYsAlu62fbK5rvU5A3k9RXNN/puLvtiPhOTs7xWuEm9LLNVIE8BuFSL9KWTv9MUwvzxpJCWFo3xRMH5B7oMmyR1VTyABsqJVoDDZF2lWl07uIOVrcnsTwFfMEf6MrX3NkdGJKCVlPi3YliZDCiGTmI3KnAD8W4PyzQrbWyr9CDWdI6C6kCJGsouA4uJSWCsfbc0BVvDzLVUcUIDKZOjYYTe5RNsKkDP5YamPai9cxEgw6OzRzGSghnquhq2nZQdJ7wK6LoUZ8ugmvTe7cLSSjyYsHhvkmbSkpsVqSc0zYLha3KRRFvqIKWS68GP2JDmlj1JuvV9qG0QzqH83Yxg6DsbSmuMCTu6SbwBdnbSQ3KBQIjyHoy4Au1R+lV0fGMAM0p1ECu2VdQBBRjf2Sv2iUYXnuHFk3dzImWS4hihvfz85SdXoisVvsck2XuBlXh7gXTw+X+lVnp27QAAOM8XdyOnQKismxd0WpZVCfro0QQ0USjePuWNe8Uy81qTFQLKdxg6T2LcFx23w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkFHYWJuT3BMbE9RT1FvMGVrZ0RDNjRCeDcvdlBmUEl2bmZ3TDJtZVhCRHRn?=
 =?utf-8?B?dnl6VitMWGtKRWtlNVZtMGl3RkZ6amd6TEZuRkRiVVcxMGlMWUx5NVRtRGJR?=
 =?utf-8?B?V0lvUXJhNnNiblFOUmlvcW9lUmh0RG1mSlJkT2xwTmVkWHdUMURZK21Kb2NJ?=
 =?utf-8?B?OWkxTmhOdmlRelZselRnRmNPZTBWMVA1Z2NVUnlEeWRrY1RYVXFvVTM5RjJz?=
 =?utf-8?B?OGx5NXNKWm9uWnRkcXg1UlRKL0g2MUN1eTRhem9lQ3FTREtmQWdsTWhLczVr?=
 =?utf-8?B?VE9zVTRVR0RTL0pYclRXVitBMXBsOWJ1TkJLUno3SjZabVFaalYvdlMwOTBS?=
 =?utf-8?B?VlduMDRoS1BpR2pzWndBNlJTZk9hVThJR0U2N3Jwc3lONWZrc05EMHphTy85?=
 =?utf-8?B?OTJ4U0tjWGhvN3dUTGg4RFJPWDd3N0JLV1RiN0VqeHpjeEF0VFl0TmNDamFL?=
 =?utf-8?B?TkZSUzhtcW1XanQ0a0FGRFc0aTI4dG9Wb25TUFZVUElrUzhGbFVPT1Y3UVBW?=
 =?utf-8?B?UnMxaEpYMXlvVGIwY1BmWmpRcmcwS252cW5WYmVhRnBYdUZFaU94N24xL3dw?=
 =?utf-8?B?WFBVcVdBd2hSRGVBZUh2dnlNZmFmWHNJd3NYdTZTWnkrdGZFNWpzSmUxZjMz?=
 =?utf-8?B?YmN3ZEJqT050UGVoT2VQZFN3WS9XOHpIQ0h4N2Vib0t0aEZuVXVGVFA4Wkpt?=
 =?utf-8?B?WnlLVng3RUZTVU16NTNHYUpyNzlHTWxJZ05pUUduT2k2MkJzcW5UWGFpdklu?=
 =?utf-8?B?RXBqTUN6QWpIcytPaGhMUTN3VEd2aE1ud0NRbGQ5dWZuMHBaVEJKUzh6RHVx?=
 =?utf-8?B?K1pqMkZPYTNNb0pQa0JYa1NWUWVhK1AzNUw2Wnp2Z1hOK1NFV2s1SXFQYUxB?=
 =?utf-8?B?WUdOYnpJOXJndFZHK1N4TzZXRHMvbFd4ZGhadGVvcWxHUG9LM1FlYlkwLzJC?=
 =?utf-8?B?blVJRzZhRkdIR0VScmFjNE0za2xwRkVBeGF3QWw3dGxtQ2VlWUF6Q0JkMHAz?=
 =?utf-8?B?TVZsUWd3K0NmWXhndzg4SDZkdCtoLzI2aWRkM25LMGdocjlNdE80eFdQMkdu?=
 =?utf-8?B?Z1RubEMwR1pBSTFoblFsOXd0RHptcXRlUEZDQjFDamxBeXpvbVh0Zm5IOStJ?=
 =?utf-8?B?Y25maTNBcUtZbDFHOXEzQ2N5QkNOMjRaSjdiQUY1ODRiUlpDSU5IY0tod2tH?=
 =?utf-8?B?bWRTZkJhVXZRSjdyN1pGTUlRQVQ5WU1jcmNYeEJDalNDRU1odk1raW9mRy9l?=
 =?utf-8?B?ZHlJbnJIcEt6dW5NL0lNd2lCbTByVFowS1dJZjA0bGthMkhMYVk5VjlkWFZu?=
 =?utf-8?B?TEV6Y0ZrK0dRZTV2eVk1Mk9uQzZmYmhnZHlIWHFpYVl1K0hqeXpNKy9kakRV?=
 =?utf-8?B?ZnBqSVQrWWZzU1BDNVd0Rkh1aFU4eU0zZ2hhS1kycW5XcUE5SFp1Vi9MeTdT?=
 =?utf-8?B?aFU0V3NSSlIyUGpHdXBNcURtQ1NPelo2OGR4eTBZYWxCell6TzFJRjE1Tk0w?=
 =?utf-8?B?RXlWYTJVcCs1T1lDdlQvQkwvZ0dVV2VDeXpzcjFYRXNDem1zWVdncWFsNnpy?=
 =?utf-8?B?dmVWT0lvK3NKQkl1V050WWFrRGEweFJlWTV3S1BRbnpHaWprNXpNaTlsV1hq?=
 =?utf-8?B?TUZvOFlZZ09VN0MxKzRFMXJKUER0YkxxSnJ0RUdpQnFHUSt2ZEZEVU1vaHV1?=
 =?utf-8?B?YitBMjdtVFRMVjhTakl2bEJ0aklydXh2N2ZuVmFHNGdIWHFGZzhPd3pWL3Rs?=
 =?utf-8?B?cE1EWGcyblIzNUNFNTViYVlqRWJPUVdLQ3pNd0NzbS9wb0pYRXNSTkVVMkM5?=
 =?utf-8?B?aVJDNE1DRXk3V25rT0RuaDZmR3BicEpjYTV5ajhHNXp5Tm83RUhtOWMyTFE4?=
 =?utf-8?B?cGZJOGZrVVU5MTFNU0Y2d3lmTmtkcXpiTVZCSGF4MUlMbG5UUjkrdjgxeUlB?=
 =?utf-8?B?a0IxZ0NYMVVkMTQ3VTVXR09yTzVQNlYvQ1FTMS9EZHp4NHNZczBBRWtHWkxO?=
 =?utf-8?B?RGUrUjAvYUU1a3RTZEUvay9hWW1wM0g3ajJ6bHZxUXVrc0k2NTNhczROM3ln?=
 =?utf-8?B?TGNYYzR2Y0wzQk95SGRHTlIzcVJUMHMyVTNMMnNzV2Y3TmhlK0h6eVRZRHVR?=
 =?utf-8?B?R1czQ3U2Y0gzQmFNcHFVeFE1K0d2WmFCYXA2SHJXM2FnL3V2dE1DMmZzUWhO?=
 =?utf-8?B?RHA3WTgzU0IvWjhLNjY2dUNqbzJJN1NhMXFUTkI2WlhmVUpLTExDYWVNei9U?=
 =?utf-8?B?UVd6K0lnQ1AreldqZ2cxZHpoTW4reW80Sy81eTJaSXhzSzVocVdrY0FhYWp5?=
 =?utf-8?B?M3dkM1VWdFZxVXYzNlMvaWtPTjBMaWRIUnd6N1AySTNtdHhWUGp5OWE4cVo3?=
 =?utf-8?Q?6NCNDqZB3y1P5Gfo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B52C27123F21094F9A5C9EEF7256E28A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UVS94a9+ntTtI3c993sC5i8jo1gxWGrCCbj74N8v69UzCxmON5BDXkWAvcP4XhH9/ECW1VjOKQ9o8QbYeUylFp0DNCSMYqdEZyE5blFLgZBlMFCFL1QEb9fXF+6HrVew7+gjH/W9Qzh98B+x0ulwLN5zfJ/vXPcNZiEqpUUWlNrtivYPR8oqTlhct7QZET5d+uS0gERxs7OGc/1Ahfkk8mvxPKGyZE6Dp8OWgXzg+9uqwB7/ABSE3lqdRCtfBTBV+4ecOWKCjX2+W39nopHN9mLsEBO5IEgKc/KazgA6Awg/ApSeQW0hWYso1MLwHlkBBTEYSZw7NYD6acW8c+Hpzw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2d4f50-2b77-4f6c-6c76-08dee81272e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 16:58:26.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /W2e4WMkQCQQNwcsqlkwcsRydDzAC9sAZKOe63DVVlesr9hRMFow4mmt5ukX0Sg2kXsGQ/TZO3oyFBi9pFdewDwq91uhhmz0smE0rvHaCjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7932
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDA3OjI1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IGluZGV4IDVmNmMxY2U5NjczYjcuLjFjNzA2ZTJkNzczYjAgMTAwNjQ0DQo+ID4g
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KPiA+ICsrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgNCj4gPiBAQCAtMTkyMiw2ICsxOTIyLDggQEAgc3RydWN0
IGt2bV94ODZfb3BzIHsNCj4gPiDCoMKgCS8qIFVwZGF0ZSBleHRlcm5hbCBwYWdlIHRhYmxlcyBm
b3IgcGFnZSB0YWJsZSBhYm91dCB0byBiZSBmcmVlZC4gKi8NCj4gPiDCoMKgCXZvaWQgKCpmcmVl
X2V4dGVybmFsX3NwdCkoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX21tdV9wYWdlDQo+ID4g
KnNwKTsNCj4gPiDCoCANCj4gPiArCWludCAoKnRvcHVwX2V4dGVybmFsX2NhY2hlKShzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUsIGludA0KPiA+IG1pbl9ucl9zcHRzKTsNCj4gPiArDQo+IA0KPiBVbm5l
Y2Vzc2FyeSBuZXdsaW5lIChub3QgeW91ciBmYXVsdCwgYnV0IGl0IHN0YW5kcyBvdXQgaGVyZSku
DQoNCkhtbSwgeWVhIEknbGwgbW92ZSBpdCB3aXRoIHRoZSBvdGhlciBleHRlcm5hbCBvbmVzLiBU
aGFua3MgZm9yIHRoZSBjb21tZW50cy4NCkknbGwgc3BpbiBhbm90aGVyIHZlcnNpb24uDQo=
