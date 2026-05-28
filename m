Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C4314A98;
	Thu, 28 May 2026 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780004159; cv=fail; b=WkKbmkwCO4hY4U4VfVYKg8zcMeT1VLiGLFcw6W1d9ShQO0uF29lI4iaCNjri1y9QxIJtxXgXNceJRj5McWqb0D1aEku2PDM43Ydgh+8+1e9Oj1QhxThfWUCupL1mzUZeFhc7fnPA8E6N90429wzK+4JPP6wPg4b5XssVpbLtFGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780004159; c=relaxed/simple;
	bh=+qnozMBwww6+9mPmLdVt9TiywgCfcPXqnZ+CVkAjpR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dc8hE5oIraGRizrsTEhqSQkD2Kd5d9eGMPOgKDe1oHSqD+B2ZheDMtHC4xg+81upJArXC854BHB2TBc/Xf3ErcnhImaTuAvbjCKNKBA9vTnMqGHjT8AuxY1LAPB1drpfRaWhDVDEqjTXgqsbX01gY6m6iIqxDam5yLynS1sQkhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJftOpc9; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJftOpc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780004159; x=1811540159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+qnozMBwww6+9mPmLdVt9TiywgCfcPXqnZ+CVkAjpR8=;
  b=XJftOpc9dWit1blQ3oWk6ZW41gyo2hdojXvjVRx+FcW+9/CK4yKqWFDg
   Oel+ByuFE3PydbcJPBCIpAG68TiqFWnIl84HuiLbkhckY3oHHUxt/nMjp
   N7rzkM0NUJot52LFXyLqcqQcOL84dagMzIM6O9V3H/qCZJg2H/Bqa3S/m
   FYA/uJYT70D4HwAPvbDwUlCSyUd4fWHGTKXfWMThMmPZDe5UnM67qzD6w
   Q40WD4l3WxiCwMiKg0QV9W4IGzpnBi7UdZmsx2XVIN0AC+1uKcIYJ900b
   SOwdpYGBFLLnaKdqfsMVe0NpFRNfVRkW033m7tMASYNSUDdc54eI1bk6E
   g==;
X-CSE-ConnectionGUID: TEzUGdMITMqA7KGqQACbdg==
X-CSE-MsgGUID: AjJCYGsUSj6aHuGIxo4s3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80580893"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="80580893"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 14:35:58 -0700
X-CSE-ConnectionGUID: IWQaXbV5Sba0zOkz4cpoxA==
X-CSE-MsgGUID: /wBYE4CVSwWOI9lWhYp2+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="247610911"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 14:35:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:35:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 14:35:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:35:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpFyjkGyZOwrzJ8RU07qdYb0lB10VDY5MGLkdYdkxeNk6vFfUrPXzLqJeDi5Nq/SubzJHMiSm288fdkVC+DNhAQ2FpBJ4KGXJKX5E+iSeEwVXkbQ4Uiayaa9BB88jQjHWXthfxV38OfNUaaii5Zbk87hutl4Gs9OC6cpvvPp8OXwqaJHPUeRs3sBIb1iNQNgC99lfRqT8LTARtBCGv30C9ZgNyW/7TtK8mCkqxpi9ygx/DXL0qyohLfMz987g7yn96FQJ9Sr4AioqtgQMqYexaz+nMHmf5U1PEDVcFYD4lWsJnBhZJcrJVf0ympoYzvrvvto6BZhZqEW2Gn4krygiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qnozMBwww6+9mPmLdVt9TiywgCfcPXqnZ+CVkAjpR8=;
 b=OsL4vO/oDGs4zQTM+uLq85MPU75CMyiab6UE3sOAhHyqT8fYvOaJoW0ygstALDPJTuR61VZEY0xig1KsUM9GR1lMA+kc0qZALG4tWchcLEORjkceLUtqk1nSHwZ+EuRXU5jSW29JYsBgEZnIrAJa4lXt07s381cCxIxBqSYLGQVwyOFvxBPagLLxaCO45M5fqsg+CYxh1yQ5kfPgwcN+m1/M11+kbTJC2HAlWokHaONsrq34er6ipanZje/E7xy6cWYimRC7xN3WhBnyhlbQuFsNFfAsSteULmxEcduC4YjVKUWmjRaRaFA58dzNUKgeOpdVdxvd9BlgtV27gn2KmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY5PR11MB6461.namprd11.prod.outlook.com (2603:10b6:930:33::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 21:35:49 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 21:35:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"djbw@kernel.org" <djbw@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension
 during bringup
Thread-Topic: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension
 during bringup
Thread-Index: AQHc6aBCQK9jyx7Br0y5BNUfodkS4bYkAKQA
Date: Thu, 28 May 2026 21:35:49 +0000
Message-ID: <f9ebc92839c94430055fe2a48114054a39b0e56e.camel@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
	 <20260522034128.3144354-7-yilun.xu@linux.intel.com>
In-Reply-To: <20260522034128.3144354-7-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY5PR11MB6461:EE_
x-ms-office365-filtering-correlation-id: 85282331-4daf-41d6-730c-08debd0115bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099006|6133799003|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: XNE1HBEhIcMzLyk3ikcsrEFaIRomIJbLFUNWEiJI71E1wrWAE8mjAYUHkXj9n0veH9ZxWGF/2JypzhN8jJh7AW0G73vXLBLU2FC1Hld5GFcs2XysHM8Btgu54E+u8gxd4O8ziXKLIUn7G+4AN4YvavqJJEVIhQezxhT7QN0hzlK3LvjwJlacscVz+Vy1Jmu65KE3IqCSSC+cSZDBWMZjScYx72+uw/4Q0RKFt3glbk5diA3Nd6Jd3kqMr7YI+GGUwTk6epYmrb50n/sNE7taNn3aCNSFhzCREfYlY67Bp4OR/HbQ+ObV+4Kz3u1QkaEndDwYAwawc8UjhY1OwZNTAyfrSSSq1mU8fKxxnI1vTtInK//Gvr+ODFad8pHpnVLg3v02nbZR+Ngq1FZ0p4eo8szlxL/PTlKTIz3qDK4OBcT6UMm0H2fyAe5+17fM3MWwZ+6pQEYTy64soMGwzcR9yFhIjyvNf8XNA6+1uvsNskHmjLZc4rc1yFvi72BkK3LcD8zVwARfb0Cdjm1/xE4HNhpueJMer6huE69ucwnNyLz213tAlDb8/M0Z3Ld2/IuOo4tC5KAEiKhUprLi0UbOZ6qq+SH/XAYjdSqzLRM6boDq8gauamNbC1ggUjSMK8ojA8YI7ltmrTAkSp0sHCs54tgIFub+GT2JJrwoaiN/mc5G1BlXewY7+9saRDVg+8Rr3CiPF0HX2pp7gAbj+Dj1Ge7nul1o514DiySxR1pDTlmICARdB6HlIC8Hhj20vBWB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099006)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2RiTlZkMENXWm9oWGhoWVpzb09KblVuR2J1cGJ6U0hSaGFyaElNUFJsMmNs?=
 =?utf-8?B?N3BlU3g5cnhTL3hUVml5WFZtTGQ1Mm5CQVFtVW83RkhKM0hZZ0EwYytJNHhp?=
 =?utf-8?B?ZGIrWmtHTnFsR0NvVzFKRnQwZVZod3JsaUw1dG82ZFltWkNwTUhmMHpObjJZ?=
 =?utf-8?B?L3NBWVArcURDV3lsZFhEejlIMFRXSmVxVEtuSXBWSURVWVV1WFJJZ2JLbFdO?=
 =?utf-8?B?S2FVV05UQ2VmaSsrVXdCK3A4MEM3clhyZDNOTWdhMXpMaDk3ZVdPeEpWU0Vy?=
 =?utf-8?B?OEtNamY5OUtjeHI2c1JNYVNPb2dyVC9Ra1NtYUQ2T2QrYWM3WHl1SEYyTHJG?=
 =?utf-8?B?UkVsbUF3MEhjMXVtV0MzMmhYMEx2U1FJaHh4aUpQUS9maHRpanJJTVcvOC9h?=
 =?utf-8?B?MmhmaWdEb3BLOVNjVjl5ZUgxVGVPdlJLUVI3b3JtRWJIWDhLLzBEYzhoeUhK?=
 =?utf-8?B?Ky9vL1pUY2MzWGhOM3dkeEFsbkFEbCtaY09uL2luWjJjRU9EWmFzZmJQNGVK?=
 =?utf-8?B?M1lKcHhIV1JzTzlsTnJ0SlFVbnhKWHRBbjZidEtsanFXL1c0cWxqaG5KQmMz?=
 =?utf-8?B?OUdYZXBmY2lYSlhXODBkVklnWGlEbndESzA3bkh4bGFCcUMxRThEeDczWEFL?=
 =?utf-8?B?dG5XNGRNay9HNzZMNmh3SjhSMCtGdjJMZzRUNkJ4NitvVG9yRGtXM1ZIbE0v?=
 =?utf-8?B?S2hsWEdtQ3dGcDg3cGdYZzUyZXdWOURMdzlRMzlUcklXZmljTndtZklnRU93?=
 =?utf-8?B?Q0dDY1NjbDkxRk5ldll3TVJuYmRURE5WL2c2dHpoUnVJenNUeU15Z2FpMkw2?=
 =?utf-8?B?ODRnaGppZXBtN3pKcjQzYXdZKzM0L1NNWUhhb1ZVbFZNUUpTOHVCRndDSXVD?=
 =?utf-8?B?a25WR24xelI5bEk5V2NPUkl3a2hnQnBYelRsbkJTbHgxNlRVMnRmQUE0Q1Na?=
 =?utf-8?B?YlE2dDR2ZG43Q2hPVndnc1UyNFZxdkVqWmZJcUVaTUZlcEwxeElXMzdCRzVC?=
 =?utf-8?B?UUU4R0ZKclNoY29ENU9uT0ZnTUpFMGdZSUJPcDlERzA5YTRKQlBNc0lzdlA2?=
 =?utf-8?B?U0tOdUdBNnNJdzlNdUR6TWxTRU9mOWdLSDVMM3RqYWxzcG5RWC9uby9FQXdE?=
 =?utf-8?B?VGx6UnBjZGpLSUZ1cEZSMWRXZy9jZ2FpdGZtdVpoODgrUDlIYU1NNk5OeVBw?=
 =?utf-8?B?RVR5V1dtZEowcDR1elBYaXFheHpSaGRQZjErcFRhUC9Gb2s3Z3MxQmk5QVlU?=
 =?utf-8?B?aTRVZkJCZkdhTVBJdDBIU0UyU040UitFWGtyU0U5SmcrbmhQQmZxWnE3YXUx?=
 =?utf-8?B?OTZaekhOeFNTRDRyUW02QmhKaWlNNXhqWG0zRjhCandvU3FHQTltcmR4REE3?=
 =?utf-8?B?Y1BWbGpaaHgzQzBuL251K3ZOVnowdUVzZzB0TGpuU1N4aDcvazZNREIzTnNh?=
 =?utf-8?B?cTBvaG5icnFhL3lYeXhaSlRaR3FzRElBVUoyK0xCUWhUdFMxM3FsU3JXMGox?=
 =?utf-8?B?d1l2NFEwVTF6cjJZTGxOaXNmZG0xRkVKTzJlSlZvSWxlMUpGSmJ1MG51Nllv?=
 =?utf-8?B?bTB5SGhDM0hjRTQ0MDZiTFN3K1MwNTdKUVc5a3hYdVUzR2JnMFFhRkQ5b0d1?=
 =?utf-8?B?aFRyd3BwS0ZmZjFhRmphN05xbjVXM2hPQWNtTzhRWW1jL0EyeitqZGJDV0Vp?=
 =?utf-8?B?Y2pIRUJEanBYeFNyM0prS1NLWCtoU1BGUmNoZVpLRXczR1M2Qk5RN0VtZ04w?=
 =?utf-8?B?MnllU2xia3NNVFFDRHplUWtZNEFMK2RodnhoamIwK3c0ZVdjUlE3ei9wcGlE?=
 =?utf-8?B?cExpaVBJODgwU1pLV0JNZUtHWnBsbVgydUVUdWZ0WVJ0MEZ1REU4VkZJc1Fa?=
 =?utf-8?B?UXUxVUhQb1Vvb0phRkJwZWNJSG9odit6Nzk5ajUyeDlyYlFrSXV4S3Z1RCtM?=
 =?utf-8?B?c2lMN0FwY2hRdy9vOTA0VlBXcWc1aUpXVWhkUTlqNWh6cjk1MjdBbXJpa29C?=
 =?utf-8?B?UlZ2UWVrbVN5RVFiekQ1MlR1RHpTVFdWU2VLTFlJeFZjMDJVcklvSGtNUTJK?=
 =?utf-8?B?SUFjK3RFRERhR05ITmJSWkE5ZTJ0bUUwTUVlMTlWcnFWNFdMNjlRcTlBbjhS?=
 =?utf-8?B?aTlobEh0bTVVSzlVRHVOK0NGY09MM3JYRGxLdmNSdUNhd2d1ZGs0TjY2N3JK?=
 =?utf-8?B?ZFhxOWRVbUlNSnY2VlN4QnBsR3BadFNyY1lLaDFYMXNaNWE4L2NIMCtycDNT?=
 =?utf-8?B?aWptWlJPQjJNRWJWNTFLcjIwRzVWWFBMVWlJeUtGSlZ0MjRHV0FpRWs1ZCtT?=
 =?utf-8?B?QVVPU3RudHlCYTFRTmFQRXBPRytIQm52M253N2hJS3pTR0hrQlhGaUZkY05n?=
 =?utf-8?Q?D9DxPT/TlgcElGbI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC6914A87109294A87070443FC65C610@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ScqPGWceCh1YmCKaX2/CCPavXEQ8QZ3zLkQXaS7OyBUvuNKj3sT5fxDkJoDFdd9BBOGpTPWm/h44R0RS48tBPxccYjBw7LcVSM1VOqckoT69k0xcYzU/ena9IG5X1KpqIBUZKm14S3mOCkbrgesmCL/V0+nFeOacvFLgt8eMF9ebQM2Ct75rGUVFRbLycqjhicPwALMmtWj4D8xHE3p1v1CDN//SOjLidP2eWLSCS5MfrdcFXTlc2JBEj+3Rt51jYJK3jlx7R21e9kzGoVTeagqqD0UDeDWl1EG4/muXq0J+4Q9WCyf7OhdmQbZqp0cFNUwJ+VSQtdEQvhmwsSQJ4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85282331-4daf-41d6-730c-08debd0115bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 21:35:49.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Q7uzUTz7cqJG7BNtRtThTpNrxUfuhKZ8uLinsRfhirLZS6QMbalbN9zr+WxBqZS4cIaisTVfqZsxswKqJsFLUlJGIheltUvUgam+sfzkqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6461
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDExOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gRnJv
bTogUGV0ZXIgRmFuZyA8cGV0ZXIuZmFuZ0BpbnRlbC5jb20+DQo+IA0KPiBJbml0aWFsaXplIHRo
ZSBRdW90aW5nIGV4dGVuc2lvbiBhbmQgZmV0Y2ggaXRzIG1ldGFkYXRhIGR1cmluZyBURFgNCj4g
YnJpbmd1cC4NCj4gDQo+IEJlY2F1c2UgUXVvdGluZyBpcyBhbiBvcHRpb25hbCBURFggZmVhdHVy
ZSwgZG8gbm90IGxldCBpdHMNCj4gaW5pdGlhbGl6YXRpb24gZmFpbHVyZXMgY2F1c2UgVERYIGJy
aW5ndXAgdG8gZmFpbC4NCj4gDQo+IFRoaXMgcGF0Y2gNCj4gDQoNCkRvbid0IHNheSAidGhpcyBw
YXRjaCIgaW4gdGlwIGxvZ3MuIFRoZSBwYXRjaCBpcyBhIHRlbXBvcmFyeSBmb3JtYXQsIGFuZCBz
b21lDQp4ODYgbWFpbnRhaW5lcnMgaGF0ZSB0aGUgdGVybSBpbiBsb2dzLg0KDQo+ICBkb2VzIG5v
dCBpbmNsdWRlIHRoZSBvcHQtaW4gcG9ydGlvbiBvZiB0aGUgaW5pdGlhbGl6YXRpb24uDQo+IEl0
IG1haW5seSBsYXlzIHRoZSBncm91bmR3b3JrIGZvciBURFggUXVvdGluZyBzdXBwb3J0LsKgT3B0
LWluIHdpbGwgYmUNCj4gYWRkZWQgaW4gYSBmb2xsb3ctdXAgcGF0Y2ggb25jZSB0aGUgZmVhdHVy
ZSBjYW4gYmUgcHJvcGVybHkgdXNlZCBieSB0aGUNCj4gc3lzdGVtLg0KDQpUaGlzIGNvdWxkIGJl
IGltcGVyYXRpdmUgbW9vZC4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgRmFuZyA8cGV0
ZXIuZmFuZ0BpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFh1IFlpbHVuIDx5aWx1bi54dUBs
aW51eC5pbnRlbC5jb20+DQoNCg==
