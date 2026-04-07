Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DAF339714;
	Tue,  7 Apr 2026 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582496; cv=fail; b=Jujwk2YjFZEYG1gr3XqVG38MCAvldogQouQef6oIYeHOrERKPYA22aIEhYN4VjZLBUFpxyNU5RuPsnPOUJUV67DbBs2UGr6hwOrJckCu0NhQFzqzxK3vKXvOQiNeHEwlFk52rMYnijwPnH0s0FnHFut3ONuArQ1H6DFm+dXWKYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582496; c=relaxed/simple;
	bh=2pYIaMA+fIe4B1rP1YKLStOypEi3uZzIdTvSedWumm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zs/MkuoHHP4zD7cd4MjexevHci+jy4pn/W/hMB5+L7e11MWGlbUtK80hZ6/VviXDrwPGNF4vLwrQknWgEfg7sOBMErKOC8B3WoRsdKKfuc6RTiMg5IrdVQ/+DKESA9NFcIFSTV6XtAD6IkaY55701ZMmCnkehECug0jCQAu+/B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dF2slRBl; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dF2slRBl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775582494; x=1807118494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2pYIaMA+fIe4B1rP1YKLStOypEi3uZzIdTvSedWumm0=;
  b=dF2slRBl7YjXx/b4Xp/14cREMn6yBL7VBG5FtkkZ1fSEHvsfOfjo9GNx
   Kz9diFv7HZPSaljcXi5FKusBKupbrBUy+wPlG3YgYfBIR32ZpGYwr9yWK
   89HZ8CAFt/1YLqsJh+30vXjhnFerlcryYYGDnyzsjbK4ecWEuwYE82neS
   IutZhV+UiRblim8KFsXne7Mc63XgXynbNtH8gx0zAa+H0LApkghkw/Qw8
   3GL5Wy4Ruq1zyCieNto8pcr3Avjn7WFRyfzeZrvkQC91y1w3+d9PRwxa8
   6pU28ak39gRUj5q/TqATM8FGU0+5fwpQ0et/izEq0SjwAJ03sOx8qlwWI
   Q==;
X-CSE-ConnectionGUID: r4n2mXFSQCG/+/8jTf9TyQ==
X-CSE-MsgGUID: +l9gC1cHT5u/3siDt4tl3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76272067"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="76272067"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 10:21:34 -0700
X-CSE-ConnectionGUID: yUKALQB+T8K594/uixcxZw==
X-CSE-MsgGUID: LBmnpe77Qiy6glf/QLzj5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="266204688"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 10:21:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 10:21:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 10:21:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 10:21:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2LxvwwNnnLwyeYkfJFRBsnO9+YHtU6lGZXQjgZT0JW27YQKj0YtG8Z8EjenJbAYMjfl4pkN+8r81BZ6rp5JvjEe85WrVJGcd7x46zc3NzQUSK91UMUErA3hpXrPwoHP8jwFsgPGY4nlqjbuzk1fVnpcC7HYseGgAYE3BUuzr7QDVS378RtYP6ItIK3BraWeYUA9ElGnWpXwyWFo7ECYriCZA0sh820zW6U7LdCufT8MOCPd9O5AqXcb/gPPadMrAO7Ul+M8bzrkyqzo+Sg5LH0M/x2Cqe3+v8JDksb8tftt3oH1rZMM9PLsoo6iPllxJidQkCF9t3igrrZYwmXUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pYIaMA+fIe4B1rP1YKLStOypEi3uZzIdTvSedWumm0=;
 b=TuSDogQTWLBxZK7tu33Q/jzcNdw94DLaRgswz/ZsJwrLwB53whg5Q6kWbifmhFhAyhTuto/iBBHUGobiLsBCEoNNbAnTq8+zor2Rbdv4rsC7Y8IqISWEBGFRid/vU8KjHwvuB9wo6yhxYpig6BwNeIhdqpVfMdtFaHyrAuw6hP7x3drJu/rywg5f3jUhgikGqcyCLu+ir1yC0nJdBqrVvbrjkRrys5OjM/MiFpZ4V5uTsAAxKsGxDKBAwmNog61zo//ib+A0ppqXAEDkWb6St/psHxjWZmbpxkcHYEMzGacrmvzoQTk21lLrFdI3i9cBEXhBV554NeIGHNdGk7IUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB8396.namprd11.prod.outlook.com (2603:10b6:806:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 17:21:27 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 17:21:27 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Topic: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Index: AQHcviZXKVkTxmL/NkWOkEaa1Zh4L7XGnJGAgARKfICAACVXgIABYwyAgAAFGoCAAKFSAIAA/hEAgAVCaQCAAJNKAA==
Date: Tue, 7 Apr 2026 17:21:26 +0000
Message-ID: <10949597e3e49a0e59ecb2345be9e06554646d96.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
	 <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
	 <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
	 <ac3Ng7IZpzJczZ2x@yzhao56-desk.sh.intel.com>
	 <4dfb4c106c834cd13da78872bfb262e98581fa55.camel@intel.com>
	 <ac77oSNltyE6vkVD@google.com> <ac+C9FdF34JRNLWH@yzhao56-desk.sh.intel.com>
	 <d4319635e971e38534509b7424c6c08fa729209c.camel@intel.com>
	 <adTBiKPanE15vtjS@yzhao56-desk.sh.intel.com>
In-Reply-To: <adTBiKPanE15vtjS@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB8396:EE_
x-ms-office365-filtering-correlation-id: 76466275-3b3a-49f1-5119-08de94ca19c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: xDY+wa2WOAxbe+UwzFb5/j9bB+u21kpoF9PlVAqOEMUPsdPNRvtluOU1Rh15jZmAdBwtO3Ynp4kr/rC+5vgL5VkcSjEIYjMGumyOuJFqf3mdUMrWJT9eRrF0BrGRA/VIuVzW3UOj/4s55rJ1jn4P7I/TJASUjtGSMFCJaPYWqK2QFTiwMY0lkaEhskXhd2/hXPdnm0uGGLfytgoZP9mY1GpVTi1fHqlSp/zn1WZ9hD6YNhYp0rFq7EZhxWBMVbIhX7pIjddQYGb42FnH2K5EQjDyAI8783V0znVpS6rL4eyDkGm/WstB1fqc8ax94gUVna2cQIrLw9qOmKdm+/Zk1zWbZlDct9k+RzDtobYoMHwoPEqdw4j/c4jBjy1zn+i8T2n3zwmYwpgobipVsravaAGBzbr33mw+0oziaL8DkRGLJiomczo2dgugU6KU1Jtus9vb7wj/T2FnmKYO+k7rq4Wk38lmTw60i6ugaa2QY2faMfLPxSCxDEMD+uiZRORu5NyZDKIqhpqk5cgSJ0dTfoK7lv4n0PcBy4tRyw9JfQDHU7QbDNN0dwCz1i1jHE0f0AUWZj1LJPDkWpW3PwElYnByeGcI0TDul5r/9Erir2FAhpnuFwUa493NdoIHRZ+w6i6xsIkgNbqL5zwd/toEaW7oF6zZ6y9bQJxM8p7TlcajEwDk8Fyu4DcYQ5xjBPmWOLNIuPmINFiOtxKKqi2KTdFiuI8EecOYRCED/cCh73ZEVRge/1lqNjJ3wnK6Kv42fp6cLOiBcKSdtL2SR2MZsYYIPWXLhtucQY98+uDKyFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXhVUHhmVmhGbEhuZTFvaVZWM3hxVnZGRklid01xQ2R0UW1YR3MreCtJQnpx?=
 =?utf-8?B?VzF5S2xMRTRIR1NBY01OVHowajlaRTQxaVNRY0JWL3EyUSt5UW5DU3lIc1Q1?=
 =?utf-8?B?Z3I5RzFHN0FmaHhpNDJRR2NhNWVZT3ZYa3I5UzlaU0ZheXZkTGhPRzc0dUx5?=
 =?utf-8?B?b1huZnRqbDdtVE16ZldZS29wOHdsa2tpNGdvVGtoSmtHd25DR2FxcFd2Tm5j?=
 =?utf-8?B?NDN2UlZjSFF6elNIWEZKZ0N4cUExZWlQd0dYV3V2NmRSVTBmVkkvcU5qTkpj?=
 =?utf-8?B?Q3E0ZW9jeVI4aWR3RVdMQzVXYUh5enFYMFpUK2paVHN3T244WlBZdDA4U1c2?=
 =?utf-8?B?ajk1c0c1K2todzRQM09JUkNhSHRjZlo0Z3JnTWNrL2xxWnY0WGMzUzI5T01Y?=
 =?utf-8?B?QTFOVHozUFBxNUVKNGdBRDNmaXFQQmdHV1VYdzN3ZGtMNmFlTEsrQ2hPZnc5?=
 =?utf-8?B?dkxIazlMSm5iQWd0NDhYUzBVMVJlQ3VXVy95WXE4Y1c1VUFwSWhMR2lXQXBj?=
 =?utf-8?B?ODArb1FEVXNGUDBaTUo5QnNrVEhnTlVpcmlmWUJ4NHVnQWhoRXpCSWszSkNi?=
 =?utf-8?B?bzhJaDhYamRzbC9aVW5iY0lKWGZBOEpCMlZJV2tmLzBPUlRIKzlXTmY2Zzd5?=
 =?utf-8?B?Y2JGdVJXYU9mRDNiOXJRMmc3RHQrOW96NXJRZENRUERFdU04OWdmMzRwc2Qv?=
 =?utf-8?B?S0hSVEFqcG00MlBrSzBUNVR4bzhSNmZwNkpaVTBiYzNiOUZCaXJ6T0IxNWtj?=
 =?utf-8?B?Y3U1RDYvUjdZbUF0L1U2bDVHOElEYzZSUDdSa005YTBNOVpUUWk2cXR5WUpF?=
 =?utf-8?B?ZFhXZTlrRVVLKzlFT0kxbnpSR1JVOVQ2dWg0RlJmTVlySksva3VSRER1NWJ3?=
 =?utf-8?B?dFRpZHVSdDFka3IzdU5ScGJsUytWUCtCVFROeDl5VVg5cDhlVmRGM3dKNnh1?=
 =?utf-8?B?cHJlZGptcVFhQWlLRGhvSmc1T3cySDBiVGZxeFgwTGVuU3pPaXk2TjV2eUJG?=
 =?utf-8?B?S2N5bXJhWnN1R2VtQnFTaU5XRjM1NDVBZXBiNUoxMDVzR0lwazBBdlQ5MWl1?=
 =?utf-8?B?KytEaGlUNmxvVTUwRSt1d0lzSWhIMEhMTWhJcUpsOUwwVUcyZ1NxT2U1ajVl?=
 =?utf-8?B?QlQwakViOHM4a085aFlETkF5VGlrcWRFMnNCZnM1YXJjUnNIWUN5YVV3VDhB?=
 =?utf-8?B?aW0xWlVEc3dBMUpjNitVTWpjMjRQRWpSRDdSQkpDMzNmK0NXUW9uVXE3bCt1?=
 =?utf-8?B?S1RxVm1OZlV6dVUrcHo4aEdXTjRzaEZHaWcvaGJnWTVsd2tWVzUwM1QrTndm?=
 =?utf-8?B?RTJRS2lmZVZhYTQvNDcxS2NwYkZRN1Y4NlZvdkw0K0hBT3Axbll3SlROOTlP?=
 =?utf-8?B?WnRtbnNaNFhBVm1meWtzN2U1VnpzZlpoNnE3aXhicGVqNXpKY2xxZXE3YXBa?=
 =?utf-8?B?VjJLMkNKRVp1NU5LNzZ0ekE1MGU3U0xROXhFYWJRNjVlWEw0WUhabVdoQndX?=
 =?utf-8?B?b3hqaWllc3ladTk5T3RBWjhRZldtUHdTZENOajdoTVZST3VDU3czOGt4S2Nv?=
 =?utf-8?B?azNBTmdSNzdaTDlDZk5OUitOQy9XRnNENWIrVGZDandFd1ZYUVZUN1BOTHZ3?=
 =?utf-8?B?NmZ5VlNqVFRJZy9UYmp2ZUlXaTZ2cmFsWW9xZmFpWHBqV284cHZYR0xob1ha?=
 =?utf-8?B?YVJibWhlbFNKSUtGQkYxVFp6UXE3ZWdUVysxNVhYVVF3bUdBRkRjZ2tReEZs?=
 =?utf-8?B?eGFzY3U1RCtVV21ZdFd1ZVU1eUFMMTRHMVhjTmlzOUdNbjZGQllXUVhUS0Nx?=
 =?utf-8?B?ejI0R2FKa1NqN0kyVmEyZEYyTHVxZEJLWW4wY2ZwbWxjQU9ueW1GeXl4T095?=
 =?utf-8?B?dkJOVzVxV1dHNnRVWTZYZ05XZzUva0NVc1VXeHNlN0VWVEwreUI3RTE1c0dz?=
 =?utf-8?B?a0cvUTFIVERwaTVwZmZWbnFQVGE4S3RTelRyQzVMZ1RSdE5vdExTRENnNCti?=
 =?utf-8?B?N1dtNVJLd2doU2RtMXRaQXFoR0ZKSDNPb25WMVFEdHBoYitNWXZqUEFVODU2?=
 =?utf-8?B?WElmTHZMdzVhY2g2WnNhUzNpU2ozc2diM2dSc1ZYUUxPSW5xcG1FY0JEOU5y?=
 =?utf-8?B?eVdETy9ZOEdCVk83bzNwS2lpS3BYVll1bUpzOUJ5VExBQzJxeFdBNDcvM2Zj?=
 =?utf-8?B?QnRvT1hmUDlKblcvaFJlYmtDMnVoWTZjelBnVlpOUlV0RlJ0NlhtT2R5cnNm?=
 =?utf-8?B?S3VSNVdUaXp1SHFaQjJsSWM3SndIWS94M3lqWGVYQ2hqNW5hQlYxMDRMakZu?=
 =?utf-8?B?ZDNwZDgzT0xQY2xaZ0tCT0d3SlBFZmJEcklubk0vb3hzLzRvanRBc0RKbFdP?=
 =?utf-8?Q?/Jz0SVmZeY74A6Fc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D35997CDC6D9E4CADE938E8406E04FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P9M0KWL2pM+jVy/ZBO5kyhzJKhYaoAUHxTWUY079NVH8yQueSXuEYY6/YLEJHb3ZnMwae3eN1/TYqz9vXDaCpoNl5DM5Hl+8uQ5vEQ6N/BPE1BjhpIoeL4ByFDbAzvxSG1V2v1yRUvgaj/B8+IZpC6HbOqaUJqw1J3lfFMF4wTOsiX2opL5QhvaxkP1IOBhBtdGjOgFi+XVx/RO97k3WWWmKIaAImzlG+L29iLeVkd+gdvNbGyWGg+fhXz4ST0W6SLySpOs+DZYSG3MEvKPasvUUGvtILVo7jlyYZ9aEEpad+QDJ2nEZ6rP450d+iDq0ycOFkywNc0qeqebGFIPdmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76466275-3b3a-49f1-5119-08de94ca19c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 17:21:26.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5g3A2YaQiICt2psybuNWqgpWNosoOIGIEaMbuCSE3KC8KjSMPgdk/TH9kBu29vbvp24PvYY4k/oq+L7l5OQneX6Wm1RCh1CjaFSH4TB2Y30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8396
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTA3IGF0IDE2OjM0ICswODAwLCBZYW4gWmhhbyB3cm90ZToKPiBCZWxv
dyBpcyB0aGUgbGlzdCBvZiBhbGwgaGFuZGxlX2NoYW5nZWRfc3B0ZSgpLXJlbGF0ZWQgc2NlbmFy
aW9zLgo+IAo+IExlZ2VuZHM6Cj4gTlA6ICFzaGFkb3ctcHJlc2VudCBTUFRFCj4gUDrCoCBzaGFk
b3ctcHJlc2VudCBTUFRFCj4gWDogWWVzIG9yIE5vLgo+IHNoYXJlZDogaG9sZCBzaGFyZWQgbW11
X2xvY2sgb3Igbm90Cj4gdmFsaWQ6IHZhbGlkIHNjZW5hcmlvIGluIFREUCBNTVUKPiBtaXJyb3Ig
cm9vdCBhbGxvd2VkOiBjb3VsZCB0aGlzIHNjZW5hcmlvIG9jY3VyIGluIHRoZSBtaXJyb3Igcm9v
dCAoYWZ0ZXIgYmFzaWMKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgVERYIGh1Z2UgcGFnZSBzdXBwb3J0KQo+IEtWTV9CVUdfT04oKSBoaXR0YWJsZTogaXMgS1ZN
X0JVR19PTigpIGluIGhhbmRsZV9jaGFuZ2VkX3NwdGUoKSBoaXR0YWJsZS4KPiAKPiBTY2VuYXJp
b3MgMS01IGFyZSBmb3IgbWFwcGluZywKPiBTY2VuYXJpb3MgNi0xMCBhcmUgZm9yIHNoYWRvdy1w
cmVzZW50IHRvIHNoYWRvdy1wcmVzZW50IHRyYW5zaXRpb25zLgo+IFNjZW5hcmlvcyAxMS0xNCBh
cmUgZm9yIHphcHBpbmcuCj4gCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfG1pcnJv
ciByb290fCBLVk1fQlVHX09OKCkKPiDCoCMgfCBvbGRfc3B0ZcKgIHwgbmV3X3NwdGXCoCB8IHNo
YXJlZCB8IHZhbGlkIHwgYWxsb3dlZMKgwqAgfCBoaXR0YWJsZQo+IC0tLXwtLS0tLS0tLS0tLXwt
LS0tLS0tLS0tLXwtLS0tLS0tLXwtLS0tLS0tfC0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4gwqAxIHzCoMKgwqAgTlDCoMKgwqDCoCB8wqDCoMKgIGxlYWYgUCB8wqDCoCBZwqDC
oMKgIHzCoCBZwqDCoMKgIHzCoMKgwqDCoCBZwqDCoMKgwqAgfMKgwqDCoCBOCj4gwqAyIHzCoMKg
wqAgTlDCoMKgwqDCoCB8wqDCoMKgIGxlYWYgUCB8wqDCoCBOwqDCoMKgIHzCoCBZwqDCoMKgIHzC
oMKgwqDCoCBOwqDCoMKgwqAgfMKgwqDCoCBZIChhMSkKPiDCoDMgfMKgwqDCoCBOUMKgwqDCoMKg
IHwgbm9ubGVhZiBQIHzCoMKgIFnCoMKgwqAgfMKgIFnCoMKgwqAgfMKgwqDCoMKgIFnCoMKgwqDC
oCB8wqDCoMKgIE4KPiDCoDQgfMKgwqDCoCBOUMKgwqDCoMKgIHwgbm9ubGVhZiBQIHzCoMKgIE7C
oMKgwqAgfMKgIFnCoMKgwqAgfMKgwqDCoMKgIE7CoMKgwqDCoCB8wqDCoMKgIFkgKGEyKQo+IMKg
NSB8wqDCoMKgIE5QwqDCoMKgwqAgfMKgwqDCoCBOUMKgwqDCoMKgIHzCoMKgIFjCoMKgwqAgfMKg
IE7CoMKgwqAgfMKgwqDCoMKgIE7CoMKgwqDCoCB8IHdhcm4gIW1taW9fc3B0ZSAmJiAhZnJvemVu
X3NwdGUKPiAtLS18LS0tLS0tLS0tLS18LS0tLS0tLS0tLS18LS0tLS0tLS18LS0tLS0tLXwtLS0t
LS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IMKgNiB8wqDCoMKgIGxlYWYgUCB8wqDC
oMKgIGxlYWYgUCB8wqDCoCBYwqDCoMKgIHzCoCBOwqDCoMKgIHzCoMKgwqDCoCBYwqDCoMKgwqAg
fMKgwqDCoCBOCj4gwqA3IHzCoMKgwqAgbGVhZiBQIHwgbm9ubGVhZiBQIHzCoMKgIFnCoMKgwqAg
fMKgIFnCoMKgwqAgfMKgwqDCoMKgIE7CoMKgwqDCoCB8wqDCoMKgIE4KPiDCoDggfMKgwqDCoCBs
ZWFmIFAgfCBub25sZWFmIFAgfMKgwqAgTsKgwqDCoCB8wqAgWcKgwqDCoCB8wqDCoMKgwqAgWcKg
wqDCoMKgIHzCoMKgwqAgTgo+IMKgOSB8IG5vbmxlYWYgUCB8wqDCoMKgIGxlYWYgUCB8wqDCoCBY
wqDCoMKgIHzCoCBZwqDCoMKgIHzCoMKgwqDCoCBOwqDCoMKgwqAgfMKgwqDCoCBZIChiKQo+IDEw
IHwgbm9ubGVhZiBQIHwgbm9ubGVhZiBQIHzCoMKgIFjCoMKgwqAgfMKgIE7CoMKgwqAgfMKgwqDC
oMKgIFjCoMKgwqDCoCB8IHdhcm4gcGZuX2NoYW5nZWQKPiAtLS18LS0tLS0tLS0tLS18LS0tLS0t
LS0tLS18LS0tLS0tLS18LS0tLS0tLXwtLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+IDExIHzCoMKgwqAgbGVhZiBQIHzCoMKgwqAgTlDCoMKgwqDCoCB8wqDCoCBZwqDCoMKgIHzC
oCBZwqDCoMKgIHzCoMKgwqDCoCBOwqDCoMKgwqAgfMKgwqDCoCBOIChjKQo+IDEyIHzCoMKgwqAg
bGVhZiBQIHzCoMKgwqAgTlDCoMKgwqDCoCB8wqDCoCBOwqDCoMKgIHzCoCBZwqDCoMKgIHzCoMKg
wqDCoCBZwqDCoMKgwqAgfMKgwqDCoCBOCj4gMTMgfCBub25sZWFmIFAgfMKgwqDCoCBOUMKgwqDC
oMKgIHzCoMKgIFnCoMKgwqAgfMKgIFnCoMKgwqAgfMKgwqDCoMKgIE7CoMKgwqDCoCB8wqDCoMKg
IFkgKGQpCj4gMTQgfCBub25sZWFmIFAgfMKgwqDCoCBOUMKgwqDCoMKgIHzCoMKgIE7CoMKgwqAg
fMKgIFnCoMKgwqAgfMKgwqDCoMKgIFnCoMKgwqDCoCB8wqDCoMKgIE4KCldvdyBZYW4hIFRoaXMg
aXMgYW1hemluZy4KCj4gCj4gCj4gQ3VycmVudGx5LCBvbmx5IDQgc2NlbmFyaW9zIChhMSksKGEy
KSwgKGIpLCAoZCkgbWF5IHRyaWdnZXIgS1ZNX0JVR19PTigpIGluCj4gaGFuZGxlX2NoYW5nZWRf
c3B0ZSgpLCBidXQgbm9uZSBvZiB0aGVtIGFyZSBjdXJyZW50bHkgcmVhY2hhYmxlIGJ5IG1pcnJv
ciByb290LgoKR3JlYXQuCgo+IAo+IAo+IChhMSkoYTIpIE1heSBoaXQgS1ZNX0JVR19PTigpIGlu
IGhhbmRsZV9jaGFuZ2VkX3NwdGUoKSBpZgo+IMKgwqDCoMKgwqDCoMKgwqAgdGR4X3NlcHRfc2V0
X3ByaXZhdGVfc3B0ZSgpIGZhaWxzIGR1ZSB0byBjb250ZW50aW9ucy4gZS5nLiwKPiDCoMKgwqDC
oMKgwqDCoMKgIHRkaF9tZW1fc2VwdF9hZGQoKSwgdGR4X21lbV9wYWdlX2F1ZygpLCBvciB0ZHhf
bWVtX3BhZ2VfYWRkKCkgbWF5Cj4gwqDCoMKgwqDCoMKgwqDCoCBjb250ZW5kIHdpdGggdGRoX3Zw
X2VudGVyKCkgZHVlIHRvIHplcm8tc3RlcCBtaXRpZ2F0aW9uIG9yIG1heQo+IMKgwqDCoMKgwqDC
oMKgwqAgcG90ZW50aWFsbHkgY29udGVuZCB3aXRoIFREQ0FMTHMuCj4gKGIpIFByb21vdGlvbiBj
YXNlLiBDdXJyZW50bHkgdW5yZWFjaGFibGUgaW4gbWlycm9yIHJvb3QuCj4gwqDCoMKgIE5lZWQg
bW9yZSBjb21wbGV4IGNoYW5nZXMgaW4gVERQIE1NVSBpZiB3ZSB3YW50IHRvIHN1cHBvcnQgaXQg
aW4gdGhlIGZ1dHVyZS4KPiAoYykgV2lsbCBub3QgaGl0IEtWTV9CVUdfT04oKSBpbiBURFAgTU1V
LCBidXQgd2lsbCB0cmlnZ2VyIHdhcm5pbmdzIGluCj4gwqDCoMKgIHRkeF9zZXB0X3JlbW92ZV9w
cml2YXRlX3NwdGUoKSBkdWUgdG8gbG9ja2RlcF9hc3NlcnRfaGVsZF93cml0ZSgpIG9yCj4gwqDC
oMKgIFREWF9CVUdfT04oKSBjYXVzZWQgYnkgY29uY3VycmVudCBCTE9DSywgVFJBQ0ssIFJFTU9W
RS4KPiAoZCkgTWF5IGhpdCB0aGUgS1ZNX0JVR19PTigpIGluIGhhbmRsZV9jaGFuZ2VkX3NwdGUo
KSBkdWUgdG8gZmFpbHVyZSB0byByZW1vdmUKPiDCoMKgwqAgY2hpbGQgUy1FUFQgZW50cmllcyBh
bmQgd2lsbCB0cmlnZ2VyIHdhcm5pbmdzIGluCj4gwqDCoMKgIHRkeF9zZXB0X3JlbW92ZV9wcml2
YXRlX3NwdGUoKSBkdWUgdG8gbG9ja2RlcF9hc3NlcnRfaGVsZF93cml0ZSgpIG9yCj4gwqDCoMKg
IFREWF9CVUdfT04oKSBjYXVzZWQgYnkgY29uY3VycmVudCBCTE9DSywgVFJBQ0ssIFJFTU9WRS4K
PiDCoMKgwqAgTWF5IGFsc28gdHJpZ2dlciBURFhfQlVHX09OKCkgaW4gdGR4X3NlcHRfcmVjbGFp
bV9wcml2YXRlX3NwdCgpLgoKT2shIEkgd29uZGVyIGlmIHdlIGNvdWxkIChub3QgZm9yIHRoaXMg
c2VyaWVzKSBlbmNvZGUgdGhpcyBpbmZvcm1hdGlvbiBpbnRvIHNvbWUKY2VudHJhbGl6ZWQgaGVs
cGVyIG9uIHRoZSBURFggc2lkZS4gSXQncyBuaWNlIHRvIHNlZSBpdCBhbGwgdG9nZXRoZXIuIE5v
dCBzdXJlCm9uIHRoZSBpZGVhLgo=
