Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34C25392C;
	Mon, 15 Jun 2026 02:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491646; cv=fail; b=HlP0Sqa9Y9qaN4eBJyFmHSV/hwLQKaPIm5TGAcjRW8GPpxB2on7pnexTuHV8PJimEdFRp3jTyAhwZzj7TPjPYucjc6GC84NOy3LiZoGWsusRn0MIoeJ8Dybi4WHvyUe4yWdDUalwvtLHxG68/2dH+Z19XUTxPXbU+wxZN93jMVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491646; c=relaxed/simple;
	bh=kpIJ7En6m7eNWekU3hRB3ie8z9qaXqrpFT06Gl8DeDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pf2Wuu2d0dCr2F4XuLXeoQlblsjuIb2F7KmX2umeX7HF4GE3UUFqtyETX4SHuVnH8HVVB5E4HbUvni9yQWeIIKYGRfG0aZgIevJ5oN8Uf2ZPz3ij38hEqzYxQZ2eAvqTwHn6AHVUJupZmr05h+vkypGh0EsFdUwXc+uLoYFiUUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=az4o7C6K; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="az4o7C6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781491644; x=1813027644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kpIJ7En6m7eNWekU3hRB3ie8z9qaXqrpFT06Gl8DeDI=;
  b=az4o7C6K5P3XRMux20+NFktLbw1P1Sqplze0X5T5uc+L9Mpw7HmckHhz
   NqAekVX0QvTARgoe9CwSQI+pF6yY0aH24XZWdAHOpOusbxjGjaVOSJzut
   3vgk5FTI8+EXCMRs15UOd2rpS5hkp7RrWVxhOB8oKSl1CNxnQGV3Yrqda
   Q/zpclv4JYfpME2wk8jWi8nFOnuMXtxIZCKPnX/jaBkkxjSRoEFVnAs6V
   EsiF+o6e8olo1Vi9Z3CDrCM1+3v09X/03H8Wsj1wSOihO1uKpxe8SwjbB
   /YblfbsrDWYp3cdAG1uMK4A1ewSbabRkAEo44wtHl+0RbCph84EftkGw9
   Q==;
X-CSE-ConnectionGUID: Ws6Z4Z3VTliXwOwh6ape/g==
X-CSE-MsgGUID: Hj8ZyVnLR8mUcXJ14W1sQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="104896961"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="104896961"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:47:24 -0700
X-CSE-ConnectionGUID: /OSRiqLjScW5ymJS3zms0Q==
X-CSE-MsgGUID: PXu+hG/fTbKHDOCMVlB6sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="271023920"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:47:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:47:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 19:47:22 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:47:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtZq+wTeCf6/Br2FwL2L5P50r1ufZLbDojTTMkwc9V+eYNx/INWTJKfvJ0mfx3LO89WV3g3ERjkQzn+Rta4EfatlWu2lvJG2bIZgH9OO0/5jAAHlvH2LTNy48AN+JpadVTo0pvXlCBoT9kw2vdNmgLHBUyr1pIcczYwsifK/c0PSXftbmdBjeBvQLTAv/4MELVQFqo4WUdRjwUtBTiqOpbHFJk7svpD4MisC6q1okNEKeDWhQfXieotBliAEbgsGOOxuyC0qszVbSiC36EPBbo+YMgmNCDa2AqOysFt1kz2IYll/RZShkKAtk5j9bH1adKmNJQ7l4v8inIDCC0QCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpIJ7En6m7eNWekU3hRB3ie8z9qaXqrpFT06Gl8DeDI=;
 b=pg8YtInn6xKRLPYWYQySZn1YGLhLjuBIaYTI6HxEU/TOLeZeb6/bj9MfcQ27sdxNcyLsX0zrOlpsuc/pM/D0yNvy7gLpVFhwpj68aCAZsnZZxreaDGCXOHJX8+suYY24hIopoaaNt7M2JeS6D2x0UuYA0jxoWPo+PPwnXhpyAZoqW5sugHzmms3/I3sg7esYl/tpx7Kp0z1Q/WgFXyojl/HP0E9Wpka2RxPGM5bBB6fx+ypl4uBlSWdn7ujXaSurjurD52711JEyDJL3lN4yw9P1CnzmfuxBUg4ul5xedyzJ2L9JDSygDhqqIUGKTbO0XhALgesKm2yGHDUE39xeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 02:47:21 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 02:47:21 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
Thread-Topic: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
Thread-Index: AQHc+sgqXLeuA1RU9kGzdjSHRH7/w7Y+7P6A
Date: Mon, 15 Jun 2026 02:47:21 +0000
Message-ID: <f1f466da5867d4afb5035da60ada4c8fd77b87c2.camel@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
	 <20260613000329.732085-19-seanjc@google.com>
In-Reply-To: <20260613000329.732085-19-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SABPR11MB9937:EE_
x-ms-office365-filtering-correlation-id: 19ea806f-2286-4299-bad4-08deca886c27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|4143699003|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: yfiZVtqy4WA9Pb5NMo4FSy1K6Y9a0sfufdLnq7rMccYjXZOK28PgQGImLlQ5fAF2f6EAO0yUODe3wnGEc7M9FIwAW0G3yJ00I4E7Ye1IbyVKKNkHm6cjBceQBW49lK9E/bGuaXPde0wySupOmDId6O+NbRnonrw6o+BtxbbHz0XFlhLzHHaxRyA1A1w0WG8QPvhRGaYLWEFdv6C6cKJI2YeN1xvA8boimQhEqd20JHEgWwafYi+uIAAMuqdWGYec/G+yqIM00buhJr6ZlSlFltiC6A9DPnpIvo3QinNOhRsNEwiDeDq+UJNltzQduoYJHsey13zTrysDBPH/F8cniNp0Et63ERE7kfDX0+G8W+x+6X1lfb/0BP3zC2ytWWlaVTf4NE4mcbJTqaPVBZctcUpxh8pevPko9G6KdTEzsm6eJK9VsDtZOIVFJChfYLuPHb+6IHJTdh2T1oS9tDr0KXdJTkY1x4LzGz4NxI8Z9ReHYH5na+n58zOETTXOux5sdQKOpRn74q60nlxb6aN1gmCcbw5XND7mFv4qNiynWkeHbTZ0oehVXXGhqqJ/6k8gZaxZKI0qQ4N4XnMGY0/ZvHkau9MbwJJVwLgQr+lCOHy1TlAn0zx3Xq8jCtX1ylqzebY4MoQsKddKZtLTwzP8LW4lHi9xmxOYCwM2b7GWNJu+i/4wqaYQ2toQwOrlqrmpO5wmL6B+JC+u3vKU8ckjNkIu72EtUS3nkoxpVFICPN/lxUuIOUviccqrzK9cfOF9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDM5OHhIQmZPZjRsZmJCRVV2cGFkMmZqMlcwOXMwNE5tZVFvZDJVT0l5M2p2?=
 =?utf-8?B?Y2Z6UzRnZWNhaDBrMnpzTUU2ZjFoVno5NHZVVjhVTThmUWw0bE4xTm9xM2Uv?=
 =?utf-8?B?UUdvQTZhcmh5aXNkUDNEM0pLYzlUYUZKWk1UMTc1ZGNvai9yWGJ0cU5VdUlu?=
 =?utf-8?B?Myt4SjdjOGl5b2FJREdXNUdHVWRwTXVrVFJVQUg1ZUVVcDhUQXlCMDFrTlZ5?=
 =?utf-8?B?QjZNcndtallMeERyK0xxcVVHOUJldjlJRXpXVVhERmtaYVdWUEs3cDRHcUZw?=
 =?utf-8?B?QnJRRUtHSHlyQ2FQZjVsdnpkRjVlMHM4WEREZGN5SFpXTlowMVVMbFVZempo?=
 =?utf-8?B?L1FUYXRORVJUZXVNdC8xQWM5M2paVE41a2ZuR3dVbmQzM2EyanFCM29XRGNu?=
 =?utf-8?B?TjdETk5RdDNoempCa3IvYk9SNjF1NDdRVG1TQTFtTUtJNklYMXNrSHFYSnh3?=
 =?utf-8?B?eEp6ZXlsNkpiMGpqYnJ5cU83c1pFMGZHRlRTVlBUMXNVdjA1WVYzQW9nQnM3?=
 =?utf-8?B?R0xlMFhjMDhCd01vSHpuUTVnRlBqNUdJZ2lEc0pmakF3bHJjcC9VUnJESSs3?=
 =?utf-8?B?VWRaMlF4UVN0bWltSkFtRERIM3hML25YWmJKMEt6SHlzQk5VRDBWZHFHZGpS?=
 =?utf-8?B?bEpKSzRNQ3cwOXRjZkExbS9wMVdYeTFtL3lxYk5ocWhrR3NUdkttZTdDTnpL?=
 =?utf-8?B?K0dOcUVzNmlZYUhLdVBpM1BZUVV4NWF0WU85SjMvS0Z6cjNVeVN3Zzhqb054?=
 =?utf-8?B?OEJJUHI2ZHZCT05LWk12eEpoMXNRS1RiL0NZV29kL3lCajFPdTVFVmlPMzEy?=
 =?utf-8?B?NURtd3pEU3FEU3o4TGdUYlI0OWZaZjA4UTkvK05ua2dpOGhSNnJUa2E1ZGZ3?=
 =?utf-8?B?dCtKeVNNTlJ6UEp0c0tGenFJYWY5dDZpeUJWazAzK2RFQWJKcTNZVHloK0lz?=
 =?utf-8?B?MzRSb0xhUldJdkFoK244MGx0R3o2SUdrNFBZRUVIQksvRW4vMm1pdFlNUkx0?=
 =?utf-8?B?Z1dxK05aY2FNSkJMYkVRT0hUeUhTZVFKNDJBUTFiRDZPcFpMQTIzVlhaeUxy?=
 =?utf-8?B?dEZYbGxPQlg2VUZjZjI3QmpXeDAzSnE0OC8xYkVHQ2RaNmw3bEtNZHRwU3B3?=
 =?utf-8?B?TW55T1FNMWlHSjBWREUwWmVqWjF0eExxZ0U4SHl2R3ZwYndtWEtrR25SUjZ2?=
 =?utf-8?B?NnB3SmRtNTMvc3FJSnJpckZpNzVmS1MxM1ZTRlllUXQ3amhPRDkwaWtZSlY2?=
 =?utf-8?B?MFdvaCtweEpjaGV2U2xQOXovL2FaUW1vU1l3eVR0S3BqUU52WE1IajJ2R1pE?=
 =?utf-8?B?K25VVEI5ZWkzRTNOOEpXdys3bEQ2VUkzYWpkaFFkVmJLNGk4Ui9PNXRXZ1Jh?=
 =?utf-8?B?ejFiOWFlNTgxcUxCVnJnZGlJbWdpTThiSXJtd2NjN0x5eWFuSXM5MzhsK0VX?=
 =?utf-8?B?S3lHd2NoQ2FTeHhmRHgrOEZlblVWcTg4UWgvY0V5VC8zeEJ6WjFwNVhPSFBB?=
 =?utf-8?B?U1dZQWJIYXZBWHBmck9lbVlZVjZ2L1FoS1M4cHBPVzk2RnJMU0wxNUlWUjUv?=
 =?utf-8?B?WDNJejgzVzBvenQxQ2h2eldoV1JTNUpsUUxRMTNMSFhaS3BTWEtWZ3FQTlRh?=
 =?utf-8?B?UTdFOG9jSTI3QURvbDhJcDVkVEZqTlZwYThqK3hzUnBtOGRFWkpBVGV0Rk5h?=
 =?utf-8?B?YTRFNXBpWXVLOEtlSEg4enRFM1JySDkxNU8vVkNkOUdEYVFMN0lEUGJ0N093?=
 =?utf-8?B?UFdjL0RBbzdocTRxNFhTOEtXd2JIN09nbUtucG9jemJWZ2tVTjU1d1NIR3Rw?=
 =?utf-8?B?NENYRFVJcTJOQ2JPaUtydTArektDWDE5V2JScFNyY053cWZNZ0tITkdHMDJ1?=
 =?utf-8?B?UFhhYjRET2JLcEZnQkdBQ3MyYXAwbkVURFVuampZc1YzekRLMXBBSUhPY0hv?=
 =?utf-8?B?Y0VyM0lFck5zREhCTUhJTmFnMXJ2Q2x4emVGRmFwY09TL1F6TTF3OVBGMVI3?=
 =?utf-8?B?cndSQUNnU2luSVh4V2I1cmZUZEhRL3FsbU15eTNuOUFHR1VvZ2VRUEJiWUZi?=
 =?utf-8?B?ZjhvVXVRamRNamVJZkc3UXJqUTRCVHEyeEY3UEhYN2JoLzZ3VEpRV0d1OVNW?=
 =?utf-8?B?V3FDU3ZMWUVTOVhXZ0xENllnRjd6VlZVNTJtZnhPeERvSzMzcUljS3dPTC9r?=
 =?utf-8?B?QlZJMElFUWFadDZZRm40b05FNm5SYkVYTHBWSFZGOUIrMlFrRjBFVEEwWjBX?=
 =?utf-8?B?VVNXdnVFaVdyUmY4S2MxMzQ3RnRCVnNrYnhJQUprTG5RN0JlMkFVUm03QVdw?=
 =?utf-8?B?VU1HMm9lK2VJVFRiQzljRUFFRzZLdTZqVUJQdDB6L0M3VSs4V0JWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D91DF653111F249AE9A5DDA5C714378@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mL64oof1pYvb3LFFijKIw0pn3LNdf2EagvUN1REy/5Ka2qeBtV0DJOPNSwiBE0lV7Fi1Oz2/LTvphKOCwZkhPbjUbp8xbG4VZhAJ9nXfovvQSLXspS3BivZl+ewZSydp6Zgg1Ppjv+PsM46TpQN3qCi1QNt6qiDYYSY8SxnTOlRZSDS2bP8P6R25+zVClV7+j3UmhbpKK0GlifbBAS3nfaz5RZAh0Bjk8xtmEb2oHnQ1NVL1Iy1aEjt8AO4TYiee9Tr6ktDwe4cLlZm+XcA3yV1nCvszoprYvEzBIBjxvRbP6YGqHhkc/e+Ei93y0nTPbDjEXvLfIk+gf1NZULiljA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ea806f-2286-4299-bad4-08deca886c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 02:47:21.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: havvKiWNwHjmReU7Hm4kY/R0vfsEcVbn0uT7qoGmAbnnmM9Vg0a84LgGbIbeUEzzh5bpoOo0kks8iYmGAbH1uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9937
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTEyIGF0IDE3OjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIHRoZSBkZWZpbml0aW9uIG9mICJzdHJ1Y3Qga3ZtX3g4Nl9tc3JfZmlsdGVy
IiBhbmQgaXRzIGFzc29jaWF0ZSwNCj4gInN0cnVjdCBtc3JfYml0bWFwX3JhbmdlIiwgdG8gbXNy
cy5jLCBhcyB0aGUgZGV0YWlscyBvZiB0aGUgZmlsdGVycyBhcmUNCj4gdmVyeSBtdWNoIGltcGxl
bWVudGF0aW9uIGRldGFpbHMgdGhhdCBjYW4gYW5kIHNob3VsZCBiZSBidXJpZWQgaW4gbXNycy5j
Lg0KPiBXaGlsZSB0aGUgX2V4aXN0ZW5jZV8gb2YgZmlsdGVycyBpcyBwdWJsaWMga25vd2xlZGdl
LCBhbG1vc3QgYnkgZGVmaW5pdGlvbiwNCj4gdGhlIGNvbnRlbnRzIGRvbid0IG5lZWQgdG8gYmUg
ZXhwb3NlZCBvdXRzaWRlIG9mIHRoZSBNU1IgY29kZSBhcyB0aGUgZmlsdGVyDQo+IGRhdGEgaXMg
cHJvdmlkZWQgYnkgdXNlcnNwYWNlLCBpLmUuIGl0IHByZXR0eSBtdWNoIGhhcyB0byBiZSBkeW5h
bWljYWxseQ0KPiBhbGxvY2F0ZWQsIGFuZCB0aHVzIG5ldmVyIHNob3VsZCBiZSBmdWxseSBlbWJl
ZGRlZCBpbiBhIGdsb2JhbGx5IHZpc2libGUNCj4gc3RydWN0dXJlLg0KPiANCj4gTm90ZSwgdGhp
cyBjcmVhdGVzIGEgZGlzY3JlcGFuY3kgd2l0aCB0aGUgUE1VIGV2ZW50IGZpbHRlciBzdHJ1Y3R1
cmU7IHRoYXQNCj4gd2lsbCBiZSByZW1lZGllZCBzaG9ydGx5Lg0KPiANCj4gTm8gZnVuY3Rpb25h
bCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1
YW5nQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vh
bmpjQGdvb2dsZS5jb20+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRl
bC5jb20+DQo=
