Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E438237B;
	Mon, 23 Mar 2026 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305681; cv=fail; b=u4xgYWOfRZOzvYc/SK1CbdsI+eiJYhkf8QEuKtsI6frdMPa862rbp8Ok4UC5e4TrzteGHOSyYNJiVXyyKw6Y2iCGoaDc5t4BpIDyWiT8DliyjeS2YrCe7tdh/p7ckI+vZtn261uDYK1ai/lAmamDkkUvqkotPYe++qUGFkb55Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305681; c=relaxed/simple;
	bh=Vy2X0LKU/+3gi2p/REgQ/Y7rw7JsXMbnrUYs8FJtDmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ioaPmqth4KgyNcp5KbUUFfutf2qisrUllMuooqNpERdMwZSlQzqolIaG4v7JI8cR/e4G3fmhEPn/sJImElOyZoE5w9tLj+pUAkISS4Aiu9FAPRMoArT349td3GKFoERnAiviPnunqmUTil9QhVyRWdCNr2oaLQx4vsAjISm4Jo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaLzlaBp; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaLzlaBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774305680; x=1805841680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vy2X0LKU/+3gi2p/REgQ/Y7rw7JsXMbnrUYs8FJtDmM=;
  b=KaLzlaBpAREgLA/cS9/r1BmLmo6masKD1lfJg05EI96OmaoyQpa5OfR+
   eGN02vLPPxHKt2Qxf0BL65HS/x3pyIryrHTHSpb568t75uGHLbzGMnHiC
   h3Ds3J7zFG1d/EmykIECSiWNV6Xi5zqX7sjXUN0Ewz+jNuDuoRae7m1D2
   PJBifgQq6YMBpvzgZcrdfDTKeL7WTYcO/O2jwdG5W3dQmJNi0XJKwvkk1
   YBOG7syKdFmsHF9Vj/PrfCb4A6DlTWTRHatBCuUNyH2e+a9PkTo986lfy
   oa/PDR52hC0gFuJPORB3qMLs/9lpdvsue3uZTxsusSeDLZZU140z8XFjr
   w==;
X-CSE-ConnectionGUID: ozr1vyZnSgq/8BjBvq+ABQ==
X-CSE-MsgGUID: fqI4Ia3kRAKJM3r1a+4Hew==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75283711"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75283711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:41:20 -0700
X-CSE-ConnectionGUID: xXnHomK9TGGbp2A5GzIjKQ==
X-CSE-MsgGUID: 3fQN5igOQv+fWXhCPevEGA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:41:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 15:41:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 15:41:19 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 15:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6uqe3vnBoIaUMYjs5A6eVzO8XmLCYqDJaL+nZgsvsJ6B4Fm3tqUCo8g+fWxgO9s6xegiNVjQWXiRilCxrP7RfbeF3Lz1qrqcmVsHpOkLC+o4X9M7B2ljqbFVFXUaQUqTkplfXQtOQXaAL+KVnX0Yi32khCPWdrwksk+N/YfY4WYMlTQqZBpwaEQ8UzQ59h9tc3Nqv1Y0NFaAZgitW5Nb1E33hca80sGr+A3bbhYjPoascjLirlDIVUZL7FHdVTrss0XUzoKttd2ebcQvEc5tQEiVCXK1kXSDRdwnr5XvPqFWLxleG7NF45GiadtTlhXVga6D88VBmoPY1AfMlXOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy2X0LKU/+3gi2p/REgQ/Y7rw7JsXMbnrUYs8FJtDmM=;
 b=So5hKTavBbVA30jp3ExMUDQbaAz9ZKSwMmq2z25vFjzjCN+y4+4KpfGuqBZbdGayMTdM50Bfw+9ftSwcNMdJjPSIgLhh36zFb+h/dlV3dA3Lo22haGUlk5aL7GoXnFwy0R1Ar9G7Z5ARwGR9PV8GEGsad1dzP9nAOcbqahWhbChKJ2T0W4urqncfTK9T0veMzv86tAJnUwBqlEe93yEH+nCMQp6gKyYR4tz4kDMeixjsM+yS1OMl7NVi1xqc1IdUerWCY/rRt89NEDm2r2mR32hn0NJkedOU1UQbdFg9pOBoXDBs1V+bma+wYR28/F6tcIcrYovxGZ76UGFFMHDizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ5PPF3A51834D3.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::821) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 23 Mar
 2026 22:41:16 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 22:41:16 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] x86/tdx: Disable the TDX module during kexec and
 kdump
Thread-Topic: [PATCH v2 4/5] x86/tdx: Disable the TDX module during kexec and
 kdump
Thread-Index: AQHcuwiFcFyCY2aQuk2U7eSb7sExO7W8tj0A
Date: Mon, 23 Mar 2026 22:41:16 +0000
Message-ID: <3ac0e8a0aca7684716774d25eb5a298abeb1b518.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260323-fuller_tdx_kexec_support-v2-4-87a36409e051@intel.com>
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-4-87a36409e051@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ5PPF3A51834D3:EE_
x-ms-office365-filtering-correlation-id: 01e4843c-757f-4ff5-4210-08de892d4b88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: HcT4gorVIzlC9PzGSrZD1sk4hhZn39CaQZMFnsvkv9nmvgzo1KZu8gUH2gY973XVy5Eyh+ppp1/aaN9N6JroPiVC01XNnC15ttDx8ppxtAGCEuZWT26vQqZ1VvlK+U5N0/Qo+EOHXze9O/HiYpabZ40zq2QH4AOTB5jnmbFNt/C1MAB94lzKKTqgzPx6UOWlkTcxeKN+j1AoAN2gcinFegZIP3iWF/xCb/PoOTdFMC87AGCKn5Ed2CFk+VE2yoyrrfcevK2CdacQTOKmIGRhuZYiVjgUIou0y6e+nkMGWLHgCMCViq/EX6ZTahGs1Kd8IkSDbyQLoM44FU6wkjW+LexzU7Pea3JGy6n2qttZsXTD72TmqvKM0uRXSSYoUzzrrVfzDgZ+roDYb9Pt+Flyl2dD87tdW5XXvhWw9jVt+EwNe6vFYjiu4FbOBIUJWFjFdeEV6TznHVTphs/H327c67XkPzBe2oJR29jWQl/m0qk8MkFwakY/gKnvGdsSRy9RrkQ3/MsmdCC8NJzzATwU+wPYDnY25BK0JekqNM/CudljeWk8MidNgPhvpBaQHiJbMmsd2eaQo//GacX61sd37N+jZaCya7Yh4yRTosqk0YE4s73NAu7I3T+zGEGjUC23JTvm9eMhZaKazgvLCCRyahBSRwnu5q/ZX6RccjOkQaiKrRu5GPH//eF7qREJ88Zg/4XiZlTfbkPPIpB+uKzwsRCbXUtkb0JmEwVA2OznJsEd46YnrghgQuTRK8hrkfP3rwbmhKCdPXxwZUZcpze5tjLUEYBbbcAbgykwC3zzHOI8CCELp3odli6/JHt0Ie+f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0pCOFBTdVBMK2tDbjJlZVN0Q0VCRVlzMjJRcFdlYkFqa0VQeVdWa2MyYjBy?=
 =?utf-8?B?MTdZZlZ3d2lBeGFqdTR5R2JUNjd3d1JNd3hqL1AzdzJNSjZidUh6SnBOSmcv?=
 =?utf-8?B?N1hybCt2YTgvZWJFK2hjQkp3b2ZLZUVocTNtLzhDWCtUb1dheUo2aS9YTEd1?=
 =?utf-8?B?enVKanFpS1dJcmpBcEQya2l4SDIvQ05MTWU4U1RiS2l0TFpOcG9nUnl2bVJQ?=
 =?utf-8?B?VXBQVG1TVkM2ZVVMUXozZ2xhck5CK1M1amUzRnF5QlZpTDRmQ2MzcHFkYjE5?=
 =?utf-8?B?blE4RmlFaWdnZzh4YkVRZUVtenQyTnNmdE1RT1hrTzZ5N1FhcEtzblhmWjdF?=
 =?utf-8?B?SHpVbUlycW9oajdCQjFMRWFiSnF2a1hLbUNCLzU3QnJna0RyTXRYblVhLzFF?=
 =?utf-8?B?L3AvaGR6eU8zSFZKZmE0SHB1YmYxSElvejBKTVgrTWs4TFlNVFVqWGJ6NFZV?=
 =?utf-8?B?MHVkWXdiamdtdmtsaERyVmxKcFlPb3V4VkV0S3V3QVhBUHJIVmZiOXc1M3FK?=
 =?utf-8?B?V09yUTJOSlFIUGl1UTIvNlJoRmJtVGtTc1VJR0lNNlJNR0VJTk5sdmRVZjMx?=
 =?utf-8?B?RjJHUURDaVBNM0VORGE0MXNrRUtkeFUwQ3Jad0VwbGtaVW9wOHlKYW9XSW1x?=
 =?utf-8?B?djF2eWJuRXp0TWIyd0RMSEN6ZENQdjZkVk8vMHRkV0xiRVg1TXMyRnczTGVH?=
 =?utf-8?B?STRKOTFNMGo2Q1FKaTRJUTdjQzhIV2JMWlNoUWVGV1FjdUZsQzlxQWdCbDVR?=
 =?utf-8?B?cEJyWE1yV21uNzZSaDNyNlN1amhIbDk5c1hRY1dkLzQxRTQ0OXB5QzlLZVNT?=
 =?utf-8?B?Z2ZyMWpXUThBdUYyRDQrajA2SzhuVXk1T2k4L21HcytOa0g0U2ZjZkMxaGJW?=
 =?utf-8?B?MzFsUEUwNGxXa25PemxmOWtMeVdjMTZJYW15Wm1XWkZxOUxWeWhUS25QU01F?=
 =?utf-8?B?QVVvVjZqMHhiQ0pSTlZZcjh4WkJIb1FRZkgzZzlXcUJXMloySDhxd29KOWs5?=
 =?utf-8?B?dlBJb2xxUUZQN3l3L2xBRDZkeUNNMjMyamtnRThMaFBrUjNGSlJvb3hxVkx1?=
 =?utf-8?B?Ym8xVGhkMW54YWhsUm85U0hYWG51UDFTWXl3V2VwZEwwOVE5UFNISWpWNkNw?=
 =?utf-8?B?bE5tUUNYYXh3c093c0JoQkRXTHJQS2VENy80S2V1dUxNV25TMHVFR0tVK0dS?=
 =?utf-8?B?dkdoaTlWaUovcHFnR083RklPcXpUc1o1VWlBWGpRcmhMZXY5OVNJdkNDRU9T?=
 =?utf-8?B?ZlN4MFFTb1VwMXFhWVhSSmppN01BMkprcVdrZnJOYzNVa25NK1JUbkJnaFBD?=
 =?utf-8?B?SFk3M0pPTTd3WmJGU0xPV2g0eFJEaDZBN1pwTlZRRXU1YUQzeFA1MlFPb3ls?=
 =?utf-8?B?ZEo5bnRSd0VuT1Vja0o0RjExSkUyMjdiaitxcE56NFoxak81TWlMOW1LaVRU?=
 =?utf-8?B?N1V3bExzN3FZVlhkOFRvMmNYZEZFRnU2VkJQN3A2aGpmZzAyR3QyODQzSFk3?=
 =?utf-8?B?bU8vREN0RFNPM0NiOW1RZmFocUVXR1JBSzdYdkNvV01Jb1hhWEFpT3VqU1Qx?=
 =?utf-8?B?RFZmUlNHMEVhMGhzSHQzckV3VFRkL3ExejZuK1pLYWkvTGpDVDVZMS8rcjZF?=
 =?utf-8?B?MWxwNkJKTzVEY1pXeCthTWpadTBoYWU4NWQ5VVU3bzlDZE1HRXczSTI2Szhj?=
 =?utf-8?B?M0NZSXNCMzZ0MVh6OVl5NDhkai9OOFhRR3Q4VG0zSXNINjI4UERzTDV3bzRx?=
 =?utf-8?B?cm9nWjFqMmJib2pSN3lOTFFKdk9Ld2dUam1yM2NqUHlVWmd0ay9SY05DT2ZX?=
 =?utf-8?B?QU1wRW90d25QTVRoSnRGR3lFbXlqYVBGbm4waGpvWWlDUEE1UWZsdmdmV2Uz?=
 =?utf-8?B?bzR2UE1NeTVGRG5FcytBZ3Fna0F0T0lpcjNCUUhSN3JscC82UHNiRXVneU5j?=
 =?utf-8?B?bmR6V0J1WUc1RENaNmk1bmVydFpFRmlDS1h1MFUzYlFZc3FWQmEwOHRiMUEw?=
 =?utf-8?B?aHhyR2dWdklzb2dkbE5SRmpmTDAyZUZ2K05NSzkzUzFQYTFoQ3crd2d1NUZC?=
 =?utf-8?B?QnU3elJsQjh3OStvRUhjRnNpQzNSMG5Gc2laR0xaSjRtMmNuMlZkbU1CVlBX?=
 =?utf-8?B?R29janVIaCtVNWcvaUk1YURhYjFxWnZxMlhHQ0FjN0NnUUpKVFl2ZnFZUU5l?=
 =?utf-8?B?d3E3UzdmRzMwWXdWRE90WWUwVEJBc3dQajhqUTIwcEpHU0JnOE9Wazl3RG5Y?=
 =?utf-8?B?enBiY2EyMHFMcnowSTZGM2x5OXQ4UjQwT2s2bEd5SjRKMGk5UitlQzNwblVB?=
 =?utf-8?B?Um1vSnpMUDRHMHFJbGxZSkxPYmxMSUI4Zk0ySmhSN3pYVXN5aUxyQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9524C9410544D54FAADCF506B90C06B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gnqd2ErsICHA/9t/EMQQYlZihn18CEdLBTEKycvIi8RhbcyqLk8h2+lZYsaMJWFHmdiY85TtL9BT97tdQs48X0vAFqNdnrLaG6Kkuy0fxShLPEmyvaZxqk/54jAHg3la+EGQ/8PFBbpSENj7dhhqfz7vTaTMFqyHEt3yLzuB2efBJs2Ue6kGOfLlOIUMevWKm8g8SXDVHYBJxe/E52Z1g5IkFJ3OxcTrRplscOxT5S5sbV3/PTLc+dcz+mjdAQOYOL5S9qzYUP1Ch7fEXBHc1IT4h+KS1t1gatbxMiZnsavZrsNGi2HzcM6kowRiCwSpBJdN9NjveOAyqIa6sJlIJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e4843c-757f-4ff5-4210-08de892d4b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 22:41:16.6693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxuI+gJu4QpTi7kB2iOIwrKRFOijW1ga3UYFPc45kPfoBu+ZVDQCRqFRSVHkx9utF/Pw8dLvR36BjF114Qbf6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3A51834D3
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTIzIGF0IDE0OjU5IC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IFVzZSB0aGUgVERILlNZUy5ESVNBQkxFIFNFQU1DQUxMLCB3aGljaCBkaXNhYmxlcyB0aGUgVERY
IG1vZHVsZSwNCj4gcmVjbGFpbXMgYWxsIG1lbW9yeSByZXNvdXJjZXMgYXNzaWduZWQgdG8gVERY
LCBhbmQgY2xlYXJzIGFueQ0KPiBwYXJ0aWFsLXdyaXRlIGluZHVjZWQgcG9pc29uLCB0byBhbGxv
dyBrZXhlYyBhbmQga2R1bXAgb24gcGxhdGZvcm1zIHdpdGgNCj4gdGhlIHBhcnRpYWwgd3JpdGUg
ZXJyYXRhLg0KPiANCj4gT24gVERYLWNhcGFibGUgcGxhdGZvcm1zIHdpdGggdGhlIHBhcnRpYWwg
d3JpdGUgZXJyYXR1bSwga2V4ZWMgaGFzIGJlZW4NCj4gZGlzYWJsZWQgYmVjYXVzZSB0aGUgbmV3
IGtlcm5lbCBjb3VsZCBoaXQgYSBtYWNoaW5lIGNoZWNrIHJlYWRpbmcgYQ0KPiBwcmV2aW91c2x5
IHBvaXNvbmVkIG1lbW9yeSBsb2NhdGlvbi4NCj4gDQo+IExhdGVyIFREWCBtb2R1bGVzIHN1cHBv
cnQgVERILlNZUy5ESVNBQkxFLCB3aGljaCBkaXNhYmxlcyB0aGUgbW9kdWxlIGFuZA0KPiByZWNs
YWltcyBhbGwgVERYIG1lbW9yeSByZXNvdXJjZXMsIGFsbG93aW5nIHRoZSBuZXcga2VybmVsIHRv
IHJlLWluaXRpYWxpemUNCj4gVERYIGZyb20gc2NyYXRjaC4gVGhpcyBvcGVyYXRpb24gYWxzbyBj
bGVhcnMgdGhlIG9sZCBtZW1vcnksIGNsZWFuaW5nIHVwDQo+IGFueSBwb2lzb24uDQo+IA0KPiBB
ZGQgdGR4X3N5c19kaXNhYmxlKCkgdG8gdGR4X3NodXRkb3duKCksIHdoaWNoIGlzIGNhbGxlZCBp
biB0aGUNCj4gc3lzY29yZV9zaHV0ZG93biBwYXRoIGZvciBrZXhlYy4gVGhpcyBpcyBkb25lIGp1
c3QgYmVmb3JlIHRkeF9zaHV0ZG93bigpDQo+IGRpc2FibGVzIFZNWCBvbiBhbGwgQ1BVcy4NCj4g
DQo+IEZvciBrZHVtcCwgY2FsbCB0ZHhfc3lzX2Rpc2FibGUoKSBpbiB0aGUgY3Jhc2ggcGF0aCBi
ZWZvcmUNCj4geDg2X3ZpcnRfZW1lcmdlbmN5X2Rpc2FibGVfdmlydHVhbGl6YXRpb25fY3B1KCkg
ZG9lcyBWTVhPRkYuDQo+IA0KPiBTaW5jZSB0aGlzIGNsZWFycyBhbnkgcG9pc29uIG9uIFREWC1t
YW5hZ2VkIG1lbW9yeSwgcmVtb3ZlIHRoZQ0KPiBYODZfQlVHX1REWF9QV19NQ0UgY2hlY2sgaW4g
bWFjaGluZV9rZXhlYygpIHRoYXQgYmxvY2tlZCBrZXhlYyBvbg0KPiBwYXJ0aWFsIHdyaXRlIGVy
cmF0YSBwbGF0Zm9ybXMuDQo+IA0KPiBDby1kZXZlbG9wZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxy
aWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29t
YmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwg
VmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4gDQoNCkFja2VkLWJ5OiBLYWkgSHVh
bmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
