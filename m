Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B6325485;
	Thu, 28 May 2026 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003977; cv=fail; b=Qt0sXVFMg1Ygpp3WLWU+Jrh0/tCe2lsutitRFflG8zhLA86yrgTgrp/orL+6u4jde33AZsUV0iw8hENrApLDedLtuy00jLlPgAUC9xudPnURyECfCfyddyYSLhD61t1pm0lr0JsOxk14Gjr0IRINAQ7HWjR0jYeE3NNxBr+t5u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003977; c=relaxed/simple;
	bh=DOCfr70QB+/Hp9KFALtFOC4rNmMlQP2ox+nuJQSarjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JbehnROdeR9q4U3egkD8svg0qqMQ+5D2w1KLZt32ZJpU2CdIHC4j5JY1dk3BgJHr47NscmuL8/BeRKeBh+wgyb62E0wax6fD6PqJb9N58v4NhKMq5fDvjQcBwJH7otjILMnfc4TyI6VHFsCaT4Db7oAqnNI35ccTz5COs3NhEg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVPBT8mt; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVPBT8mt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780003976; x=1811539976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DOCfr70QB+/Hp9KFALtFOC4rNmMlQP2ox+nuJQSarjA=;
  b=RVPBT8mtJ3UnApYVNgaN2yfAPp4VfKpySLDhwyKU6MpyWSC5ZnIRLsz1
   ojbTI7xX+43W20zeh3peYbEz82mbEoIFLLNjzeLSVSNkE/J/pe9XgxIoD
   XxtDVAQEIcSYzYh/4sT0Sy4tI00BH4TYCUWLWOcAik2IfFoNHzO97QjcJ
   umxRCqG527J3YGonLJ7s8C/wBQIGWCwNAygU3q+czQjEUyyIdrEZQQwvs
   I4nz7sjAYdVxQHQFVfRmrHVtIQe+cqo8hks9kfhpmxL4x6KD3ZwnPA5tG
   HNnXfumpvg6qD9xNVJefuvTzJ8y3a6rn2jy5G8lEq53AlLlkhdznNqhR9
   g==;
X-CSE-ConnectionGUID: iFTjLnWeRf+rns2f9HhtIg==
X-CSE-MsgGUID: z7wzddjaRmiW0dILr6nnlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106307756"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="106307756"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 14:32:55 -0700
X-CSE-ConnectionGUID: yCzSM5LJQnGdCeywKGTgqA==
X-CSE-MsgGUID: z500BzGXSeiG0pJok5lSAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="242819097"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 14:32:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:32:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 14:32:54 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4Du+J8RUGaGAAHLtLain7L3dZKJ04JcPL/4nJN2E4UXJ5NqKo/5+kbWaTFnD1QmBUYGYk5nFR2dE/Rb0jkbS9Fgj3zkZMhibA3340PKMVMbjmcNUl5BFZialMn3txFvb3JpKlhwxpGNsN55zgnMtHn+o1vg3GWlLeP8Rv6VB8cdYkTt7QvD6/L0WfOuJCnKUzLSnqeQuDuQP/sbgAYGTd2tioemxe+Q0Y1jsfNkAFyMS8rAlYaWtlxyfU7lC6WlqqjPQvITwrbVJpsjnqL6KKOg3iyqbyp3HgiHd+7i+hoq2n1DvuEVRjkRkCWGCoJK32MRDEYMyGuNWZHYv3EzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOCfr70QB+/Hp9KFALtFOC4rNmMlQP2ox+nuJQSarjA=;
 b=y4c0I1L6V5NRNxtjH3hJQPo7gAZiLxrYOP2vRtjZs91OEkRUmPTyzMibz85+llxnGJ1xTtlAgPJk3NOtz6alIg51Ak3AcIArGR5EJumn9BO/tGHwoNfQSBCllLOBqubJyJPxR81RAhswzdAphaIHZExxlWd55XTDz5OKPxgWY55L9gniGcHuF9BgxNhgZkdITqXNkrnCVLd6ZD/oGP53+SotK9CEt4d9CNOQUkYxPNra8lLUv5b2XBM8okD/yiAGSv3r1RpV2xT0m4ra67oejQ1TYV2rfN8PS8CcYVZRGT5ZdoqUZrwZtF9Y+DGwX2vFEPuoZ/xagvNmlKGzAaJZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 21:32:52 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 21:32:52 +0000
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
Subject: Re: [RFC PATCH 05/15] x86/virt/tdx: Move tdx_tdr_pa() up in the file
Thread-Topic: [RFC PATCH 05/15] x86/virt/tdx: Move tdx_tdr_pa() up in the file
Thread-Index: AQHc6aA/QFl0D+JAmkaDUskicNGBEbYj/9GA
Date: Thu, 28 May 2026 21:32:52 +0000
Message-ID: <db108d45db665fb60395113c6e19bbf053fa9001.camel@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
	 <20260522034128.3144354-6-yilun.xu@linux.intel.com>
In-Reply-To: <20260522034128.3144354-6-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA2PR11MB5161:EE_
x-ms-office365-filtering-correlation-id: 94bd119c-b942-491f-01c9-08debd00ac72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|4143699003|56012099006|18002099003|11063799006|22082099003;
x-microsoft-antispam-message-info: qV2YXjUo/Fc4mfeYFJ4PDAYDtJL/KKmEcy7P3IKRpYFF3f9GyhzuEQgj+2lNvwycDlhSo5wEDZWVX7jQh0ekE+c6iG0TUiN9rPFpGTPsr3q3Mut5RCXPLFKkOAWk+aixQ/nsaau45iCPqZTg1xDFiYIzwG9cNDHkRQIEEAIqN+0jKvol7QgX4q77aw3GN3zf+bepXLeJfTYoT+ItL3pcDTgTw0dRLEklzABi3FuX0SLRrH/s/LkQcoGFjQJp73lueE0sksMHZR3sRZFgnpmrNRwTjdqaKcJq6JZQwvGk027+1W7cpMSXKE0cMvqKXLJO3kar1x1KEMQTAEMPeKl6YJcgEUsNQt0gfIV0MY+DBXPXhfLIlt/A1lXCGWT27U0oe2ijmERLl2gTrpBva7PNTtZdheobQle4YxlJUBEv82tNN1BaX0F0du9DrhwsVZC1+f7hsKTev7WOFw1gPYhJ3Lw8lOBz3vDbEJPgMk/R0fX9co+zjd4Bn5LxG/CXBlWlDGsfXL6Du/mkgNdT7CGCd/0LSbn7H7JjB9O5TJLzRwqZI3aHoW3RwFXLVRtwqpKah6HmCpKUBZmSq+PJO9Tqg/l8Vozb9cvjxvuQ9JFW65C3hGuONxOutquavnqWNCwnzkagT2zEYDH1o45Og2OhB4j8iWn5hEvCdeL57ZBhn9QOtD3eIBr7MjetB2/y0j7eLlxmJoz4PUcyk6jpQ4XErvNpW06C69z8x+fd+OOeQAcpvgPNTI/lOHiR+qrHq60t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXVUOW9JM1FxVDRwWGZrOG03TnZRMFJPYXhIcjBQUjIvbk9NaW93eFZVQzFD?=
 =?utf-8?B?OHRZTlFmTFZ2M2QxVzA5TGRvUlZRUlVpcXNVWll6Q0k0VUR3WTBmNmFnMG5n?=
 =?utf-8?B?cnBFM1VJdkQ0V2JZRG43ZENxdEFxWGtYQ1lrVzh3UmlTNXhidW9WOFRIQi9a?=
 =?utf-8?B?bUt0SXdjb204VkRDdVhyUU9xRmxjUysrQjJSWWZEYnMxUVpVdGw4VzVzR0Yz?=
 =?utf-8?B?c0Nzd3hmL3VjMUZqRlNtWWRhZnNTRU1RekFTemdsSkFEOXRrc1lTVUJVdklJ?=
 =?utf-8?B?TTUvWHBmUWZ5OUF6dzVZOUVVa0FidGFMb1dONElLTFFETGF4NXI0V25rUVFj?=
 =?utf-8?B?c2NNQjNmNElOTXlsdEtYWlFiWndobEdyajlQZlNWbFNBK1NlaTU5Y3ZGVncv?=
 =?utf-8?B?U2RzZk82Wm9wREFzVnh2RkpRekxsbTFpY05seEYvR2tYMDN3bEl4cmU0azJX?=
 =?utf-8?B?WjVUMVlxN20wY2tJejZqcXpkaENUZnd3Ylg3THNPM3BZV2JvZG9JTzBVUEhi?=
 =?utf-8?B?VHRUaFdMWnZ0V1VrK0lJN0cvNFRlSmRCWjZGQjdCQ1VlNkdhQXpkYXFZNlk5?=
 =?utf-8?B?emhYSVpYRmUybTVNbDUyYng3cDZvTnNDSVp6NmhNRkkxeHpQUG9najArOGdQ?=
 =?utf-8?B?SnA4bFpqS1V4eVFyNTM1K3ZrcHFiRk1TZFVWUUw3ODZ5NHRNNkVqQzRmYkMw?=
 =?utf-8?B?dlNLdHVDcUdSVWJJdkFqR0pHRmRrK2dOdnlwTUc4dmlpUmxLSmUzNVYxaFhq?=
 =?utf-8?B?cmpSZVZ1UHYvTkxvam1wT3BSUXB2b281NDJjd0pZTkdrMlhIMjBQNklEMUha?=
 =?utf-8?B?aUhrVG9wbnorNC9FemhrT1hNQWZLdkNDYTJvRlFmQ3pkc2RMMDY2NnVzMmRk?=
 =?utf-8?B?aUkyMWdsRW1xRWdpbVJZbjBRclJqSzhaL0pBRENycEE0MzVSRnovdjNDalpM?=
 =?utf-8?B?NEthYU5tVitKNnlkQmQwWTVPdGt3ZWZHVEF3Z29CdDdNR2FwM3FKVis0S21q?=
 =?utf-8?B?NkFIZmRxTXMvTzNpR0xsaWxrUzNBTWRYRWQwZWR2WmFBNVVpTWRjZXlhUHo1?=
 =?utf-8?B?ZTlQUkVmMURlbG9wSmtUL3NncVN2Y0M0TktXZWM0bHlsclhiamt6c2U2UWlo?=
 =?utf-8?B?Z2JmSzYwZnJsd1FxYUJUN0ZvVmhQQ3l4Z2MyZUgxKy96dGd4WWVzL0RtSFlh?=
 =?utf-8?B?M3ZqaEcxS01JRzREYnNrWWI4K2ZrTW1DV3FCeHpqYWl0YTVZN2VFWHV5Q1lF?=
 =?utf-8?B?L21vdEdjRDBtd1pMTGoxREFQaUxKKzZuOG11WmhlYzVtQXczR096b0lyWDBN?=
 =?utf-8?B?NGZGYUNqNGtVb0daQjJIeGpFcHovckRJTDJ1VWRnMUpLTWFCMXRoN0sxdmph?=
 =?utf-8?B?dTRhTUI2RlUvZEFPdUJWNGlVRTFiSU5mdURlK3dsUTVvZEZ3WlpnNmJmVFlL?=
 =?utf-8?B?bUV1NHJ6ZzVJNlNiMHFINlJvZjRmZVBNN21EMTBUUThnS1A1YlZJSDY5TFFh?=
 =?utf-8?B?cE1FRkE3bEhWUERzVk1vMUgwVVVUcmt0YmgxMTJ3VlZKZnhQdmVybURqbk5V?=
 =?utf-8?B?RS9ESGVRVFdzQzFZOTczQ2czK2x5REpxL2FjTFdHc0xXRjVwd3p5VmxEZmg5?=
 =?utf-8?B?c2xJWVhsb2hMa1hwY2hCNUdnZTAwTlNsUDFwRXk4YmdVbEhPeS9XbFM5eENz?=
 =?utf-8?B?bVMvM0c5d2cwTmwwRUlOaitCRlordCsyNmFMK0tydmxGUHhxNkhmcWgwTjho?=
 =?utf-8?B?ak1aVmE2NVJrWnZ4bWFtdjhDQ3RPQmdWR1crUE1aOU40by9udllTQzhvR3J2?=
 =?utf-8?B?aGZYcFZnM0lhMFlpVWw1VlVjbUVPaWJUMllEc0V4ZVBSUklaa0ZKZGJJTW54?=
 =?utf-8?B?cEhtbkRYaERaRWlpT1JoQzE0VGxyMzJqejBNMk0yTHJwQUloYTlSaHF0Rk1I?=
 =?utf-8?B?RGtTdHFVTVBoUjBzU1ZBR1Jqd2srWU0yaVJZVnBObVYxU0plbnEwNnh4dzlk?=
 =?utf-8?B?bHlYWWEvTzdCZXgwVUVGSFlIb0lpUnlrUkVkWVNNeUFrSjZLNmgrQ05JY1hX?=
 =?utf-8?B?WHlGY1YxNmpOM1I3K3FNdXRtVkdpM1hpbjVXbTlTT0lrTGxBTFRJcU41bytK?=
 =?utf-8?B?MVZvNEtQQlpTZk5YejFuRzREelVmZEoxNHhHN2VBSjV4NzFCZEt1TFkzdmda?=
 =?utf-8?B?cm8xQnJsQldtWTlBRk5EWHNDcE1EM3FwN2ZiSkNsMitrSUJVRDRvSFBRYWRl?=
 =?utf-8?B?bTVyaEJUQTQ5dUY4TmUvUitUc0J1MTNsVnhoNnRxR0F4M0paeGlCTjcyTlV2?=
 =?utf-8?B?aCswc3pOTEd4RUhZWGNpUWxqa1VGSnRDMkxXVUpDSCtVam5XREdaQzEzWFZh?=
 =?utf-8?Q?m9Lhd39N7vxHysPo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EBBFDDC66113944AB915BC00CA808A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PxgRqOz1vCbQPROoG4dBvC+7BMfFF+XjwLcu0p2nJgJp7/uiwHk4aimCgoJuf04XFT/RPItYBjszKNZkKjCmsWQ61FSl8uvkjLMCl3aE2j2bEIByFMcY/mc/mkzN2P2VhF932GIVpaxH5LDb8slSFCNAjKF0XRFwN3NwiD0EVI0W+FtRMnYFqV/zaDJpl2Tp/VnDD96fgfdQHtIivX2LEWraRP1kOqVdWcbPzkMB14v3pVfkTnqA+xWGWapOs/5PIjJyADzuNSv4oeKWKULGQTBXoYF6MtgsZn6R2CvYyjz+PY3i59AsnYqQmMcrCBzA0ve3iC12Ktha6+dIWWE8VQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bd119c-b942-491f-01c9-08debd00ac72
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 21:32:52.3750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vs6vkZGhxmiB3LlfoNNTWSGGmdBt/V7WKXWXuMEYyGQB33CwGydVg1wRHtSwIPJzvRdhJ3Hq5liSH4Kw6KBEtKwhCyGkmEYMcuS3mDvwKI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDExOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gRnJv
bTogUGV0ZXIgRmFuZyA8cGV0ZXIuZmFuZ0BpbnRlbC5jb20+DQo+IA0KPiBNb3ZlIHRoZSB0ZHhf
dGRyX3BhKCkgaW4gcHJlcGFyYXRpb24gZm9yIHVwY29taW5nIGNoYW5nZXMgdG8gdXNlIHRoZW0N
Cj4gZHVyaW5nIFREWCBicmluZ3VwLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5k
ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBGYW5nIDxwZXRlci5mYW5nQGludGVsLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNv
bT4NCg==
