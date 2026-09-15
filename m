Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481333E024F;
	Tue, 15 Sep 2026 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506870; cv=fail; b=L/gMwAHwvF+6zlcyum9do6NEx+Pum7b5CSZ3ShZL40Se6tYhmBdQ0ZnDzj4q6GqoTPHNn8CrFbhNFkT1XixqUeBgrl51qy6s/xJxETwwC0Rk6RUc1BzzD1QxAhPYk/l1kQl6rHTlTdsqiZ6XBWFHGNLYGdU0aPvD+r4z3Uac1L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506870; c=relaxed/simple;
	bh=wTLZ7vIw8JLEHgLPWgVXi9YUw437JeaBIVHfp5LhHKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VuN6DbMRNFjTvuc8HaY/InFm3grHfBu+YOWrIp101cnizvKzdQVG/6fOqKLDcCxidJzKDSbcdEA7EsT1TemdOr308aJpORhuiA/kEI1GLBguEoAz7rJdkjwS9jOxlzwzr5C6UjNhgixcqog87mqosts64/1iWT24VAfHA2vGVLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDP3w7O8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDP3w7O8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789506866; x=1821042866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wTLZ7vIw8JLEHgLPWgVXi9YUw437JeaBIVHfp5LhHKE=;
  b=fDP3w7O8zZTj1CPm7F467Rus1IpV3w3SvOC0vbL/2LSENN62ch0o65wz
   ZIiCOf/vIMcDQNkgMvjzSmLkvzVQKzXA1y7JZm+CklIPufgvHqVnfjGNQ
   VAKC4uxqShd1duNkN1NaVP/1P2BpvRi+HVyab7RNaMuLNQl1Nn2fWu6Hd
   bO17b/nSU0LWmeUDJGEX9c7p03J1VwzmQnu/mZVA0ajUODI1VbzQ9Xydu
   UOMRFw7RVqquMfwx0tsih/8Jtape/fNMo3wDrKUp+IbFZXGDvzaOBDRrL
   goT/73zsBKe7qanHkY1vcSPooS9nI+JKsgS/Xb9HvDav1yqbfTYHXMRf4
   A==;
X-CSE-ConnectionGUID: +cRDJmaxSfW80+wp7glqew==
X-CSE-MsgGUID: WcMy55X0R46Su9fnqPda+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89019019"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89019019"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 14:14:26 -0700
X-CSE-ConnectionGUID: LqmQfSB6ROShLqvnN4U4Xg==
X-CSE-MsgGUID: p0SwQHw5RZ2WxyDCYHx2AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269450369"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 14:14:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 14:14:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 14:14:25 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 14:14:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsY6akkukSlpNu/01ax7x6Ct2fT7JLqf2kw6DNbd4X+P45C7ABVi+qaShxW0le9/u5hx+AdW6jV3UXc8EG8T+DCaBycOUvwqyhITAV7gZ/QAXH60GQgvc7LHE0gvHk7Y6ltRhXr3bwPORCplO7Nwk7xXQp0zdgxlSMHYajTMC6Sjkyfudc3LdxyVLTMfbD1vOgjKeRlgdFwCH530Zr1Y13/fXOLSWnKuODwysZ3Nf1JqxsnUZY2U+w7HPmKi+ktPS+8/XW41Q9MlsoKA3mnihhUQy3mE3bsSV7xWHPY9CL/xeUGvIrrZnHUEH/8Byby+buanqjZNRMKNL86v+QcgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTLZ7vIw8JLEHgLPWgVXi9YUw437JeaBIVHfp5LhHKE=;
 b=DGfBpVmBnAQoo0iYdkPr0T3xEXpTaYjKlA2NPaiFjKQGHH45W+HSX5+xx8EsWkrc/v46CjfZ75gq3fuL0To1ynClMbiCS73TjhlJJLx32Sb1fLQJgQFUFbTCbJy+9hSKbn3JH4LY7v4DsCl0my/DI1YbmxgZjYlcVuCtLgBDmvZoDhymZPNFnqhbUhM6nZ1UiDIvrMUAi5NqVKROGHBUpfYXEr2W5Bzg6Gfq2SP7T5RlhXUVZsXZRdu6INorvjJjPZ9ot1emokra1BBcMJOuP/84JA/cqTgYZlpE5p7Dqot+cKHDhrf+QCdUp7WqxYQLa+Hmbt0fqz3+GNb9Ti+oJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS6PR11MB203949.namprd11.prod.outlook.com (2603:10b6:8:49a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 21:14:17 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 21:14:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Topic: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Index: AQHdRPzRHohuXeHMhkaF5CbyB+xzBLbQJFoA
Date: Tue, 15 Sep 2026 21:14:17 +0000
Message-ID: <8c7a630c25f04dcf5b19e29d3b271c611bf90378.camel@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
	 <20260915102658.713079-4-yilun.xu@linux.intel.com>
In-Reply-To: <20260915102658.713079-4-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS6PR11MB203949:EE_
x-ms-office365-filtering-correlation-id: 5a97ca5d-42d3-4601-f5b5-08df136e4d4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|6133799003|4143699003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 5PqCRwb8JhidQaUOXsJxPO6gTIR9HV5zXlUdTcE964Yd0Ns0eNeeax/xIzN7Av9qjFMQUs57ufF3gRNVIapKre0paLCE7wmSVA39BBVpTMHs7nUn4RQgZiPdMAiXK5teh1HmD6VnYEyE7J2XmHHG4Y2f80vtxfI0HmLN051OcAxnvq3+7hQsM7ypW5DFFMAOMoRH0RzlJtrU13OhLDkTgRo9vDmcVPMsYZRKRt02RyroFsfCoC3aXZzP4+vDnYuutgRftbO4+mqC7eMMJtS0HgsNi7qMAZP+4ZyBjXElQoin4MLnR1gqRIe3+llGIPHTkV7Ioa2Ys9gwW7wgapq995FTnBa28Jsl4/nnlzW3MWmPLWVraLmwE08E8kTB5gbGm7/8V+khq3YDBkT8jRGdYn20qHnaG1KQnyyWG8SzyqnuKAAA+3nt207Q0MIYuAob1S+E7XUGjb8ggb1wOSSQswkuuOaXC/gi/XEzihQhleFIr9lddpHeJNaDaZy/3FkNF7BVS9HrMPgyWiUyNI6hmqjAb1uSLzZKxnGuEqfkDw79oPyPDHDTdGDT1sSr2hmnIGYybdzOAVXnkNvDR4bSpiZWZIWvQXCD61k9HLsxNcbkWUMa7oMajD5duG2e6F0L6kf7TIu1yiBaNmk4/zUuCR7ILI13Gj61P3yLZBJnSaZ0Ul1GpaUuYRL170K1HkMSxj+iIGSgUgD7UsH9YdNEwef6PakwSAAbCRoBYOwD0QE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzdrRkplYnZHNnFQWlcrTlBIWGptQk1XYTJjNy9xZ0NoVFR0dkFicDR3UUhQ?=
 =?utf-8?B?RFM0THhGdGFXTEZPTWR6Y1krOXZXZFY2QnQwdEN2VGx4WXJYSlZHQUcrazJ2?=
 =?utf-8?B?NGdWRmo1STNiYkxRNFc5V0hyZU5vbnhHbks5WkcxY0Q2U1NDOENPa2ptYXlh?=
 =?utf-8?B?dFpmZi9UYXQwalF5OFFxV3ZzUzF4Z051R1B2T0hKaHJNL21VeUc4V3oxSjdt?=
 =?utf-8?B?K1Ztd3BLZXBqTUFzMTQ2MU1sT2p1ZXk2YXdhQWk5TGp1elkyV3VrbGN0U3gv?=
 =?utf-8?B?ajNKNlg4RzNNUi9VWkEvMHdBMy9aQ2hPa0pUSC9NbTR4d1VtTmNYSHpzQlRK?=
 =?utf-8?B?WEVhZDE4K0lEU2hCd2ZKdEE3YXhvUHhYT0tVM1l6cTZwaXZWZjNLcG1qdUl6?=
 =?utf-8?B?WFZjbG8rTUZFM1RVd3dZWHVYNnRvdEVYZlNTWjlUV25BS0VhV1BnSmNYNUto?=
 =?utf-8?B?V2sreUtvdzVKQitOOVhXN08yaUdKM2Q4RnVLc2tRR2F6cEpvT1crbEYzcXUy?=
 =?utf-8?B?NDhRYm1PWmh2Ri9INWxTaUZRTENjeWIrcC9GY1EybGRZaXNUdGc1d0lOY05z?=
 =?utf-8?B?blJnVDJZUnF1WnJNQjFZb0RiMDhSeUxWSXlwYTZKbnRYemhhYUJIcGVRdnUr?=
 =?utf-8?B?aEtxK3BCUkdjSmRaR2VzNXNWd1NHRHdsZGI2L3A0RVQyRi9OOGloQ3djS1Rp?=
 =?utf-8?B?NFpsNk9WZFJ5L3IzZ2o3emJ4VVAyM0lGckhLbXpWcXZ6QlBBU216S1NScFEx?=
 =?utf-8?B?c2hWNDIzaCtwMnVOTWVTTGU4T1RWbFhFU3M0SFYxVkx3clZwRVN2dFd1K1ZP?=
 =?utf-8?B?YithbExyNnZOMk1LbHFkbC96Znp6WUlBMU14WmxhbGJZRVl6d3Y2SmcyWEhK?=
 =?utf-8?B?d2lhdlpHSE05YzlPck1hVUorQzA4WDZSZU9xbktsOVlXNlkwM2FYVCtETStP?=
 =?utf-8?B?TVhTVmM2dHNqQVRWNFYwemI0MFNzM0pkL2grTVg5S0NTcDkzaFhGYXBCc2hX?=
 =?utf-8?B?OGNsZHNVdUNZZzRKdDFWNlFlVWhXcGp6QmVocXVCQm1YN2ZNRldGY2h1SWVR?=
 =?utf-8?B?ZEtaQVlaWU8xL25YMW9xY3V3SUlMbU01Nk9wZGFMMXdoWURqNVMxRmVhZ1Yx?=
 =?utf-8?B?ODZoM0NLSWw2ZGI1bDBVai80Z2NhMTRoSVphNVpmMnVJN1VqaGpVUWtKbzBU?=
 =?utf-8?B?b0xURnk1SzM4U2NBb2QwTFA1U1g2NUVDUkRkdk14dWgwcWxCMHN3UUFYVUdn?=
 =?utf-8?B?cmJreFNTS1FmR3lESWFtS3VwMDhrV05sak1LRDZrcUFxck9jbkJpWGJzQ0tY?=
 =?utf-8?B?TTBwM3dPOWRrTDQrSnMxRXlwNVU1YXgzOFk2aDVZOFdKblczdXMzZ1d5RWdi?=
 =?utf-8?B?VzR4TTdWSWRaRnlzVGV3NGZ0Q3pCVVdnbWNvKzM0R1JUdjQ3TkQzb0FZaUFI?=
 =?utf-8?B?d2NlTmk0VjZYN1Vha0lUdHA2emRIajZTNlUrdHo2eVRvSWhOSGxVaTZLMmRY?=
 =?utf-8?B?N0w5RTE5MzJIU3IwS0ZIT2lRWnJkSEhEQmJEa09tR29TOTRUUnNUN2QzZUNR?=
 =?utf-8?B?RFA2bXozT3VBUHJPN3JnaS9lM1JGa2Ftc0s3WWJEZVh1TmNVb3NyWld1ZFFQ?=
 =?utf-8?B?Ymp2Zm8vcnlLbUdONSt4MFJ6eGJzSWRNNi9rWTZLWkYvUDczQXlaZUwyekRY?=
 =?utf-8?B?SmZxUXAzdjUwWDRMU0VkZkdmQTBTZEluY1BDcGlHeXUwcVdVeFJrdjlwZzln?=
 =?utf-8?B?MjVuU1oyMUk0S3JtdWc5R3VEb1NCRlVJYmRDVFZkZnNtTFlSMWZ1SXhXbWFq?=
 =?utf-8?B?WHU5alprRHdnOGNEcStmT0ZHS2c1VkNBTFAzZ2JzTCtHdWcxM3cxdFVidjJh?=
 =?utf-8?B?bXR4MlV3V1BRQjYrbWE3Z3lPRFJoOUdUeHVRRi9rZUIyUVZWZkxwdkNNZVFY?=
 =?utf-8?B?bTJna3o0bEJMZDV0dlVESXRZVUFUKy9TemNWV1ZadGlYU2g1WTdITkRUTVhq?=
 =?utf-8?B?UXFlRDFHUVFsRnlhSDZycy9SWXp6R3RnL3YzSktrclhRU1BBR042R2RHdHA1?=
 =?utf-8?B?SjJhTUNyWGVMOVV5QXY3WXVtR0hXTlFHaW50a2RLeElDVjYzb1RmQWh2OGdZ?=
 =?utf-8?B?UitIb3o2Q3FxUFg4RzJsQXFFWnh5TkpoRmZDWkdjRExNbCtqbXJKU3RxRXkx?=
 =?utf-8?B?ME5uTHNnT1JCMThhMjZWVi9RNmh4NmdWbWhFR3d0VEpxb1RwN0ZHZUxpeGJ2?=
 =?utf-8?B?UjNQZXF3TXhPRGY4YWpOenI4MUxFRlFJMytkK0RkS0Nqb0xWNy92RHhRZUJx?=
 =?utf-8?B?NUY2WXdId3RtVzFhUzkwVnFNQXh6d25nYkxVai9RNHNpUEYzNnpVclRvUTcr?=
 =?utf-8?Q?/4YlayVxcyiNgewc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B5CDEA3A76F344E9A821F8D52F58FF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rQ3XPPceObpoKdGenP4P9KYY2gAQ2sEXYxDoNLPpoW/e/TFafew6R32h7PEjkfAjwWEb7adBDGP6YgBNaNaeksFZfxVGqOlN4G7XfzRs8n/9BBClJLWoeldCZRCbcbYMbQL2brg8lW5J5wjrYxH8+ljrZqXql+8iqo/ZxHD88GIezem36Ddkgvk/LxK2aV4cQay4+nU4AB0KPlefzqwlfWLeYmDspsAcJv5knxi+Aixop725IzJgqkwgJkRugsxO5/uOdIgKa3GtHGS0DLp2HmF5kvL1bH4E3JWmOoG2NDE3QPpQm0rcjsxztaUQcZSMfm2TRZWoA8VESlb7Iq17Ng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a97ca5d-42d3-4601-f5b5-08df136e4d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 21:14:17.3726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SA+LS1apmsKT36EqwP1TAKvknkj5yjo5tiVdIRtSP2M1QR3o++ZbEzn10A7MI5tAepM2oxcCY/b5sXizrQC8uFiPdnwGZWvUzS6vyxXfQqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB203949
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDE4OjI2ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gU29t
ZSBhZGQtb24gZmVhdHVyZXMgcmVxdWlyZSBURFggbW9kdWxlIGV4dGVuc2lvbnMuIFRoZSBURFgg
bW9kdWxlDQo+IHByb3ZpZGVzIGEgbWV0YWRhdGEgZmllbGQgImV4dF9yZXF1aXJlZCIgdG8gaW5k
aWNhdGUgdGhpcyByZXF1aXJlbWVudC4NCj4gDQo+IEFkZCB0aGUgZmlyc3Qgc3RlcCBvZiBURFgg
bW9kdWxlIGV4dGVuc2lvbnMgaW5pdGlhbGl6YXRpb24gYnkgZGV0ZWN0aW5nDQo+IGlmIHRoZSBl
eHRlbnNpb25zIGFyZSByZXF1aXJlZDoNCj4gDQo+ICAgMS4gQ2hlY2sgaWYgdGhlIGV4dGVuc2lv
bnMgYXJlIHN1cHBvcnRlZCB2aWEgVERYX0ZFQVRVUkVTMF9FWFQuIElmDQo+ICAgICAgbm90LCBl
eHRfcmVxdWlyZWQgaXMgbm90IHJlYWRhYmxlLg0KPiAgIDIuIENoZWNrIGlmIGFueSBURFggZmVh
dHVyZSBuZWVkcyB0aGUgZXh0ZW5zaW9ucyB2aWEgZXh0X3JlcXVpcmVkLg0KPiANCj4gU2tpcCB0
aGUgZXh0ZW5zaW9ucyBpbml0aWFsaXphdGlvbiB3aGVuIGl0IGlzIG5vdCByZXF1aXJlZC4NCj4g
DQo+IEN1cnJlbnRseSBhbGwgbWV0YWRhdGEgZmllbGRzIGFyZSByZWFkIGF0IHRoZSB2ZXJ5IGJl
Z2lubmluZyBvZiBURFgNCj4gbW9kdWxlIGluaXRpYWxpemF0aW9uLiBIb3dldmVyLCBleHRfcmVx
dWlyZWQgaXMgb25seSB2YWxpZCBhZnRlciB0aGUNCj4gYWRkLW9uIGZlYXR1cmUgY29uZmlndXJh
dGlvbiwgc28gaXQgY2Fubm90IHVzZSB0aGUgZXhpc3RpbmcgbWV0YWRhdGENCj4gcmVhZGluZyBt
ZXRob2QuDQo+IA0KPiBBZGQgYSBkZWRpY2F0ZWQgbWV0YWRhdGEgcmVhZGluZyBpbnRlcmZhY2Ug
Zm9yIHRoZSBleHRlbnNpb25zLCBjYWxsIGl0DQo+IGFmdGVyIGFkZC1vbiBmZWF0dXJlIGNvbmZp
Z3VyYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAbGludXgu
aW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueS5saW5kZ3JlbkBs
aW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiB2MToNCj4gIC0gSW5jbHVkZSBzdHJ1Y3QgdGR4X3N5
c19pbmZvX2V4dCBpbiBzdHJ1Y3QgdGR4X3N5c19pbmZvLg0KPiAtLS0NCj4gIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL3RkeC5oICAgICAgICAgICAgICAgICAgfCAgMSArDQo+ICBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS90ZHhfZ2xvYmFsX21ldGFkYXRhLmggIHwgIDUgKysrKw0KPiAgYXJjaC94ODYvdmly
dC92bXgvdGR4L3RkeC5jICAgICAgICAgICAgICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKysr
Kw0KPiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeF9nbG9iYWxfbWV0YWRhdGEuYyB8IDE0ICsr
KysrKysrKysrDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaCBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3RkeC5oDQo+IGluZGV4IDg5ZTk3ZDU3NjFkOC4uNjY1N2YyZGIwMzMwIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS90ZHguaA0KPiBAQCAtMzYsNiArMzYsNyBAQA0KPiAgLyogQml0IGRlZmluaXRpb25zIG9m
IFREWF9GRUFUVVJFUzAgbWV0YWRhdGEgZmllbGQgKi8NCj4gICNkZWZpbmUgVERYX0ZFQVRVUkVT
MF9URF9QUkVTRVJWSU5HCUJJVF9VTEwoMSkNCj4gICNkZWZpbmUgVERYX0ZFQVRVUkVTMF9OT19S
QlBfTU9ECUJJVF9VTEwoMTgpDQo+ICsjZGVmaW5lIFREWF9GRUFUVVJFUzBfRVhUCQlCSVRfVUxM
KDM5KQ0KPiAgDQo+ICAjaWZuZGVmIF9fQVNTRU1CTEVSX18NCj4gIA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvaW5jbHVkZS9hc20vdGR4X2dsb2JhbF9tZXRhZGF0YS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vdGR4X2dsb2JhbF9tZXRhZGF0YS5oDQo+IGluZGV4IDQxMTUwZDU0NjU4OS4uZmUz
ZmU5MWRlNzFmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHhfZ2xvYmFs
X21ldGFkYXRhLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4X2dsb2JhbF9tZXRh
ZGF0YS5oDQo+IEBAIC00NCwxMiArNDQsMTcgQEAgc3RydWN0IHRkeF9zeXNfaW5mb19oYW5kb2Zm
IHsNCj4gIAl1MTYgbW9kdWxlX2h2Ow0KPiAgfTsNCj4gIA0KPiArc3RydWN0IHRkeF9zeXNfaW5m
b19leHQgew0KPiArCWJvb2wgZXh0X3JlcXVpcmVkOw0KPiArfTsNCj4gKw0KPiAgc3RydWN0IHRk
eF9zeXNfaW5mbyB7DQo+ICAJc3RydWN0IHRkeF9zeXNfaW5mb192ZXJzaW9uIHZlcnNpb247DQo+
ICAJc3RydWN0IHRkeF9zeXNfaW5mb19mZWF0dXJlcyBmZWF0dXJlczsNCj4gIAlzdHJ1Y3QgdGR4
X3N5c19pbmZvX3RkbXIgdGRtcjsNCj4gIAlzdHJ1Y3QgdGR4X3N5c19pbmZvX3RkX2N0cmwgdGRf
Y3RybDsNCj4gIAlzdHJ1Y3QgdGR4X3N5c19pbmZvX3RkX2NvbmYgdGRfY29uZjsNCj4gKwlzdHJ1
Y3QgdGR4X3N5c19pbmZvX2V4dCBleHQ7DQo+ICB9Ow0KPiAgDQo+ICAjZW5kaWYNCj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQvdm14L3Rk
eC90ZHguYw0KPiBpbmRleCA3NjNjMmQxYjI1ZDAuLjkxNmE4OTA2ZGExMCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14
L3RkeC90ZHguYw0KPiBAQCAtMTE4MSw2ICsxMTgxLDMwIEBAIHN0YXRpYyBfX2luaXQgaW50IGlu
aXRfdGRtcnMoc3RydWN0IHRkbXJfaW5mb19saXN0ICp0ZG1yX2xpc3QpDQo+ICAJcmV0dXJuIDA7
DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBfX2luaXQgaW50IGluaXRfdGR4X21vZHVsZV9leHRlbnNp
b25zKHZvaWQpDQo+ICt7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWlmICghKHRkeF9zeXNpbmZv
LmZlYXR1cmVzLnRkeF9mZWF0dXJlczAgJiBURFhfRkVBVFVSRVMwX0VYVCkpDQo+ICsJCXJldHVy
biAwOw0KPiArDQo+ICsJcmV0ID0gZ2V0X3RkeF9zeXNfaW5mb19leHQoJnRkeF9zeXNpbmZvLmV4
dCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCS8qDQo+ICsJICog
ZXh0X3JlcXVpcmVkIGluZGljYXRlcyBpZiBhbnkgYWRkLW9uIGZlYXR1cmVzIHJlcXVpcmluZyBU
RFggbW9kdWxlDQo+ICsJICogZXh0ZW5zaW9ucyBhcmUgY29uZmlndXJlZCB2aWEgVERILlNZUy5D
T05GSUcuIElmIG5vbmUsIHNraXAgdGhlDQo+ICsJICogaW5pdGlhbGl6YXRpb24uDQo+ICsJICov
DQo+ICsJaWYgKCF0ZHhfc3lzaW5mby5leHQuZXh0X3JlcXVpcmVkKQ0KPiArCQlyZXR1cm4gMDsN
Cg0KSG1tLCBub3cgdGhhdCB3ZSBkb24ndCBuZWVkIHRvIGRvIHRoaXMgb24gdXBkYXRlLCB3ZSBk
b24ndCBuZWVkIHRvIHNhdmUNCmV4dC5leHRfcmVxdWlyZWQgbWV0YWRhdGEuDQoNCkFsc28sIHBl
cjoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9hb3g4RGdwblNuaFpSZkN2QHlpbHVueHUt
T3B0aVBsZXgtNzA1MC8NCnRoZSByZWFzb24gd2UgZXZlbiBuZWVkIHRvIGNoZWNrIGFueXRoaW5n
IGlzIGJlY2F1c2UgVERIX0VYVF9JTklUIHJldHVybnMgYQ0Kc3RyYW5nZSBlcnJvciBjb2RlIFRE
WF9FWFRfTUVNT1JZX1BPT0xfUkVRVUlSRUQuIEluIHRoZSBjYXNlIG9mIGEgVERYIG1vZHVsZQ0K
dGhhdCBzdXBwb3J0cyBleHRlbnNpb25zLCBidXQgbm9uZSB0aGF0IHRoZSBrZXJuZWwga25vd3Mg
YWJvdXQuLi4gd2hhdCBpZg0KVERIX0VYVF9JTklUIHJldHVybmVkIFNVQ0NFU1MgbWVhbmluZyB0
aGF0IGFsbCByZXF1ZXN0ZWQgZXh0ZW5zaW9ucyAoMCBvZiB0aGVtKQ0KYXJlIGluaXRpYWxpemVk
Lg0KDQpBRkFJQ1QgdGhlIHNwZWNzIGRvbid0IGRlc2NyaWJlIHdoYXQgdG8gZG8gaW4gdGhpcyBz
aXR1YXRpb24uIEJ1dCBkb2VzIGRlc2NyaWJlDQpTVUNDRVNTIGFzIGEgcG9zc2libGUgZXJyb3Ig
Y29kZS4gQW5kIFREWF9FWFRfTUVNT1JZX1BPT0xfUkVRVUlSRUQgaXMgd3JvbmcuIFNvDQppdHMg
cHJvYmFibHkgdGhlIG1vc3Qgc2Vuc2libGUgYnVnIGZpeCBhbnl3YXkuDQoNClRoZW4gYmFzaWNh
bGx5IHRoaXMgcGF0Y2ggZ29lcyBhd2F5PyBXZSBzdGlsbCBjaGVjayBURFhfRkVBVFVSRVMwX0VY
VCwgYnV0IGl0DQpjYW4gYmUgc3F1YXNoZWQgaW50byB0aGUgb3RoZXIgb25lPw0KDQoNCj4gKw0K
PiArCS8qIFRPRE86IGFkZCB0aGUgZXh0ZW5zaW9ucyBlbmFibGluZyBzdGVwcyBoZXJlICovDQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIF9faW5pdCBpbnQgaW5pdF90
ZHhfbW9kdWxlKHZvaWQpDQo+ICB7DQo+ICAJaW50IHJldDsNCj4gQEAgLTEyMzUsNiArMTI1OSwx
MCBAQCBzdGF0aWMgX19pbml0IGludCBpbml0X3RkeF9tb2R1bGUodm9pZCkNCj4gIAlpZiAocmV0
KQ0KPiAgCQlnb3RvIGVycl9yZXNldF9wYW10czsNCj4gIA0KPiArCXJldCA9IGluaXRfdGR4X21v
ZHVsZV9leHRlbnNpb25zKCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJZ290byBlcnJfcmVzZXRfcGFt
dHM7DQo+ICsNCj4gIAlwcl9pbmZvKCIlbHUgS0IgYWxsb2NhdGVkIGZvciBQQU1UXG4iLCB0ZG1y
c19jb3VudF9wYW10X2tiKCZ0ZHhfdGRtcl9saXN0KSk7DQo+ICANCj4gIG91dF9wdXRfdGR4bWVt
Og0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeF9nbG9iYWxfbWV0YWRh
dGEuYyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhfZ2xvYmFsX21ldGFkYXRhLmMNCj4gaW5k
ZXggZTQ5YzMwMGYyM2Q0Li5iOWUxYzAxMWE5OTAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3Zp
cnQvdm14L3RkeC90ZHhfZ2xvYmFsX21ldGFkYXRhLmMNCj4gKysrIGIvYXJjaC94ODYvdmlydC92
bXgvdGR4L3RkeF9nbG9iYWxfbWV0YWRhdGEuYw0KPiBAQCAtMTMxLDMgKzEzMSwxNyBAQCBzdGF0
aWMgX19pbml0IGludCBnZXRfdGR4X3N5c19pbmZvKHN0cnVjdCB0ZHhfc3lzX2luZm8gKnN5c2lu
Zm8pDQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiArDQo+ICtzdGF0aWMgX19pbml0IGlu
dCBnZXRfdGR4X3N5c19pbmZvX2V4dChzdHJ1Y3QgdGR4X3N5c19pbmZvX2V4dCAqc3lzaW5mb19l
eHQpDQo+ICt7DQo+ICsJaW50IHJldDsNCj4gKwl1NjQgdmFsOw0KPiArDQo+ICsJcmV0ID0gcmVh
ZF9zeXNfbWV0YWRhdGFfZmllbGQoMHgzMTAwMDAwMDAwMDAwMDAxLCAmdmFsKTsNCj4gKwlpZiAo
cmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJc3lzaW5mb19leHQtPmV4dF9yZXF1aXJl
ZCA9IHZhbDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KDQo=
