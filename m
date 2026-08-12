Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B5495500;
	Wed, 12 Aug 2026 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786575498; cv=fail; b=dh/g9KIO5Abr9YdW5X+/LAhBUNvYUIIdNTTRj6X8b48npkJQyKCA8sSEpafz/TjfCpWxlNiXJYCXdV4vdlIlIrQjikVoki66q3Mj8wo86tpoZ31kw/NThcxOT0PniDAPKtVkMU+QyM8pMj6cABghL+KOUk/gtI9ah8I4WQk8Jxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786575498; c=relaxed/simple;
	bh=W9Tg4JT7DTG1JsoJz7X70CiD1Or/OXUkbeNA0sSi8xc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cweO6iGFTrFpYnpW6MnOmDa5okxHdoWy58Dw42XXzawDnlCt1GtFRbM7DpxG/yeV+ZsWfux9gNT1s85bOn+isdQIyJ2jdQKoC1s7mXwf9Bo4Us6378KFvP9+mfnMG+K47eAyuLO9n+Smcrx4wnXCfF75o/nygVO4Ou+udmTNBHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ykr6BEd4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ykr6BEd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786575496; x=1818111496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W9Tg4JT7DTG1JsoJz7X70CiD1Or/OXUkbeNA0sSi8xc=;
  b=Ykr6BEd4jc2E7BjGRQIpj9g6zkSrSDupP9VMIblOFBAYi8TUoQ+tQz65
   NVUhpzyhI2RXYvsNBE3OWWvg6V6XSQCbJIbt2v72Y7wr1x6149Rn7+D62
   /wbx9lRQQRbTE0v9SLuFf38RW+Iph+0jmCaIo8qdQbzqwWleIJPoFnB1s
   6eOC2ao6abVH7M9mewQZGVkOii47N74nNlDqCB+XwNzgv8QwZjFF2Namb
   8lSVFiFqkXPSkO4PXsxRT5TQmTXztlMQuh69HT0KYxSQJxiv7tqZQ77Jc
   31Jwt15Zi7SdpgdRHcOYOIkADEV3LBI5S50LTuZsxWmxUxL0Vup8ZrnVK
   g==;
X-CSE-ConnectionGUID: TXqYhGE/TyOdxx73jgqqTw==
X-CSE-MsgGUID: qLsfR2TkTtmMqYyNv6inSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="104678795"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="104678795"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:58:15 -0700
X-CSE-ConnectionGUID: JopYlROsRzuDKX+yBBP/ww==
X-CSE-MsgGUID: +HMEd4vlQMSfRANVeaQ8Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="268033219"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:58:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:58:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 15:58:14 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:58:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyTMGssWMOJ2yyh8DlEH2fgcoex7kbH/6ra7gqhnZiLKcuWtgjAuqRYK8q7B9cy0F5t1TlURwOIpwKY4SAJ/bsqPLxorHVMBkiuLA6ZA1ZuDwoUzqhXidjskFwwa3/YYJImV/DI3/fP5lficIowDneeq0xL8dF6P5H4aLxhO6eFNv8U6wkwT0VqnQisx8/2FK19PKVTeMy6t4ALmDk6L/oD/xm6G6/zyvi2tWE02cqIZVHHMkR6CFZqLiXfAUPLqPuEmT+M6mdnkkezfOAKgH41n0HK8uqUimeRBx3L8jy9QaNYhF3q1CLYA9/cH6PQf6NCgCe1nMH2s97TAO8OixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9Tg4JT7DTG1JsoJz7X70CiD1Or/OXUkbeNA0sSi8xc=;
 b=T+jTxSxX2QEP345Mg5Ex7cqCrFhKu0wioEGYG6tnZYnQyXeP2oc00AFGcUZb6eFuxrYiLyujLjE6KYWXCok6nsPF4WluqTmBUsmGEndFFsXddKP8z2P4QHcSmkIfruOYR/2Mq151Lfn1UKpingQncISneD1Sucf2zrW9KH1CNBVZAk6sIJ57N+TQqVsozxjEmkq3JJXU9XiyYgmyhy4sPVoKS2R/nODEcLrndqhG1MXfcnJ8OsfCwEcifjrdgHPXYIVW+mZh0L/tF+PwXatnQ98jz1NbnTp/aZDhA06IvFVob4s1FDJmiy3OJyESG5V6P7nAiY4czowsc9UD7U6F7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW4PR11MB6933.namprd11.prod.outlook.com (2603:10b6:303:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 22:58:10 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 22:58:10 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
Thread-Topic: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
Thread-Index: AQHdKjGvmd1dotL3zkaQuXIR1pjv/babB7KA
Date: Wed, 12 Aug 2026 22:58:10 +0000
Message-ID: <868c0d3c792d789347c767031612977c31cc227f.camel@intel.com>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
	 <20260812080229.2481439-5-xiaoyao.li@intel.com>
In-Reply-To: <20260812080229.2481439-5-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW4PR11MB6933:EE_
x-ms-office365-filtering-correlation-id: a1ca216a-cafa-4b0b-5c23-08def8c52e6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|38070700021|10067099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: rSICWSN26+ZMrYceF8kta6RSx2KC1jNRv1nHAKkDXKBdJJ/6CQgIlsBQp4ckb1G+ix8N2SZQMPAJ3Fq89/oMSNovagryfOYHtTI1GJTpYcJ2FtTEnBh5cwfX8I83IRkPQlwG3gqZZZ5yi8VKfLtvhRMeBuzgiabrxf5u9Y5Hl/HGf8KRtmAqz265s2t3wgInqqx3c9/Cz1aPBobadHha1SKcjSKWTBvSYcAYLaMzELKUSFdxz7jiD957OEVqQXPTrMDV6aGedQCjgm/2OBUCE8ppiN6/yvqUk+CTG/NvCy639Gwx/WcmRe0E4ixI14/6BP6xJh5oj4LgYUNNP9w5jAUyUNz82u7q1fZPLMI9ldwoitGfUJh2nZ3jlAwzUZVogeOb76nUkjQPsJhjqs2bB2u/wU3aP+6NZXCaQXiafAH8cotdh0iJABfHZAmsUGL7twuO1qYabiD9HoCD2CGen+KR6I0rZd6CgxXekk/QBijBx8T47X9uOJIvktUQKv01LQak8qbPfgymUYLAD+m5pogUlCad3G+vfyB6NBOb+Fok74enfUJGsKErsavyt8EXGHfjpTNLjaWm16lh1ajjEb4+Cp5g14CC2ISlVBOH7pSe0ko7AyVhuvfdpUldMvT5JiHxgUkcS1sSJJmncvEfNI8k046jMbG7EK9BVZ3DDT+uni20jQXIhq3LVZoBiwFd/xQbo2K4ebtX6nu5qKCS6QA0Q4anHXrf0DXkh8Qhb+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2hMcS9rSkZXOFowT3B6NitkZjRHV085bEhndlNmSDA2UW1VWVRTNTVrZEtF?=
 =?utf-8?B?ek9SbTc5aGtiUFJndVhUZVI4U2tlU09oelRaN3h0ck1DN3dtcG9SVjNnN1Jl?=
 =?utf-8?B?SGtrM1Bwd0JVNEZkbGk4NUl6SjFqSnVESjMxSWFEbmozSUloQ2FRRGdMSko0?=
 =?utf-8?B?S2lTN1JHRC9mSHR2U0tzMFEvaHJ4Mi9jS0krMXJMS2NvOW5rYzhIMU9MZmR1?=
 =?utf-8?B?UnJrdityWFJ1L2pQa3lqbUdMTFJCYlVEQVBIWnA5MkNpV2tJK3pFU1Z6Qjky?=
 =?utf-8?B?QlJZanFOSHBXOFlRdDdGZlNXY3JkS2pidXoxUURvemZ0SGRiUmdyT0xQVDdM?=
 =?utf-8?B?QVpGOXNKR0p0aVB6Q2ljd3ZqL2JoaTg3VE52SEo0b1lrbDF4eS9UQXpqdzd0?=
 =?utf-8?B?aGp2SHJISzk1NEkvTzh6SUJMSFF1OE95eFBUc0hmUFVNUHNiU2tlOG9xTHNy?=
 =?utf-8?B?QnRrcXdGcXVFWXNRSXQzWkR6RjlhVlFZSmNLY1NjOHdjYnpkN29LUk4rYllX?=
 =?utf-8?B?WU9YdUN3T05OT2gxZXdnbXFKazNXZTc5YVF0aUxWTXFqOE0wSm5UbUpOb3ZB?=
 =?utf-8?B?VjAyU2xKb3hKS1p3ckNRT0tjY0lVTUhNUmFPVjR5NHJueDIwRnZOY0t3eUNw?=
 =?utf-8?B?VWdDU0d0QzZLem5lOXRMQTFNdG9RRXpha29wQ2VZd2lyLzVlaStuaER5SUxt?=
 =?utf-8?B?UUNUdUxqLzBJVXRYN0x1RHFnRitEZGQ0NVZrNnpob0hNTitYZGVxVS8rNkZF?=
 =?utf-8?B?K0pvMTdPcThjdHFZaEJpOUg1NFR2cExkc3VzSlgwcWhOMEFNT2NqaVlGRUpx?=
 =?utf-8?B?Zjl4c2FldVVBMGw0RTNhYmRuajVuaGZxSXhaWnZhZGpra05tT05vaEl6MFlX?=
 =?utf-8?B?QXAxVXU5cDRpNWZCUVhzTGRPcWo4SFFUZWtTYUZIeEZ4Z3lIRUtib3FUN0Vq?=
 =?utf-8?B?MThlTjM5OXk2czNKVVlkSW1Vakd5NjFBaHBRVmMzcFhwaTdwN1h1V1I0bitw?=
 =?utf-8?B?OWM2Z0tMbG51czBIM0QvMUNtQVNDei83a01WVGVLMmYva2taYXhKV0habzF6?=
 =?utf-8?B?Wm1ueWtheFpMbndRVEY3WmcwT0hIWE5RVG0rMVN6YWxjQ2ovQzFpL0kzT3Vn?=
 =?utf-8?B?UVpCNFhQZDRJUW4yNWFoWXVHdmJtMVF2ZFVvRUxpMElOeW83dWlUUHBWTlNU?=
 =?utf-8?B?b1NYRlIvTStpeVc3V1Bsbk94b25sbGsvSlBvYlI1Sk9BT2Q5TCsvK2VwS0Rr?=
 =?utf-8?B?NTlwNFdMckEzaW5xM2ZzMTIxWGFTcitjYmVMSjVheEl3WmkrNGdNeHJnWG9V?=
 =?utf-8?B?Zm1Rby9vVVhuWEYyOFNhd0l0TkVaTDU1c25YQlhCYTczTUV3YjBDRTJSTGNu?=
 =?utf-8?B?d2RidkNGbUhwb25GbHFkYk9ObThiRHN0bDV6TTNseUhlYldYcGMrMDU2d0do?=
 =?utf-8?B?QjF6c0dPRzJqUHplaHluRXhxVUhYK1ZLTDN1blp2MHhNUEVIT0lEcWhOQlQz?=
 =?utf-8?B?bytLVnRkZlVtb1lranNqV3N2aGgzc20zWlp5RG1HWHFoOXFsOHd2ZGlaVEVj?=
 =?utf-8?B?N2lSaWpqTHN3cXRYb1ZNbnZCNHNiamFJMHdWcWttR3NaUS9EWjlYRmtZdzli?=
 =?utf-8?B?MXFmeEUvVUJSeEZvSkVDYjdTL3ZZNC9xblpDa2d2RmpNMGF0TjlEVFB6NUpw?=
 =?utf-8?B?QVcwVEVzU0F1dVB1Z2NKejlUa2ZWNUdlbW03aXBCZXUxd3BJZ2FGdjFwdVN1?=
 =?utf-8?B?bjZQcWpXTnU0UWxNWnM2bld6QmI5TFVMMUZRZ2tWckl2OWY5UmUzSVE4Qkho?=
 =?utf-8?B?VkpITmo0Zkl1b3FBS2g5UHhJV2JqSDFwRUF5L3FyVjZWNnZ3a2RwL2FxNEJC?=
 =?utf-8?B?MHRhMGRkU0M4OTJKOXE3MkpaOW5obEJhUTFoVUd1U2d0aFF3ZVJxaWUxVG4w?=
 =?utf-8?B?d3pqK1Fwbzg3TG5QWWRTa0d0dGdyVldpKytkRWNpK0k0MnNnSHhwUzNiQWx2?=
 =?utf-8?B?di83Tys0RW9WbXp4WW1mUVNFSUYxU2hwQVhIY2ZDSlovYnpjVVNNQm9mL003?=
 =?utf-8?B?bjFEUEtmUHlzQ0c0RWYySmFGbU8zMG8va2tRT2ZyZ1FqN2JYSkVxaVl6elh3?=
 =?utf-8?B?eWVRMzd1Zmd3S0VUaS9EM2xyQUI4R2o3bHcyYmorbk5YeFd4TWRUY3U2OGZq?=
 =?utf-8?B?alRJdUVXMjBCaUFVUVRIWjh1TnEyOUQ5Yzk0MUN4VUpjVTF0bWJjcUVGWHI3?=
 =?utf-8?B?dTNpYlhuT0hIakRhMmdhZnhwRXVoOW50djZxbUNKeFZBZVhSc1Z2cm9wQis1?=
 =?utf-8?B?VTZvUXhDZm1oOVpDbEtpZmljZTN0b1pMTlprWnJvRHdBK0NuUVd4VHNqSW5M?=
 =?utf-8?Q?RaHsYPKannAVc31o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0CDFF0BBB4544429552320754EF3B2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gQMKjDUO69QEqL0kjFhflOl/47FM9rmPEJOwfdkFGbFxSeqwXhF+jgEgG23DYzvDOl7gGcjYanNHBcpGeNnN1pYxLmw0ISmJooRA5EIKSqmumwWOuGHJ133FKYcHgZk5y37wZ5hVU3TjKNCN/Auo+e+W3LdfsAwM9RrdwA7k9hvf3eGHIXYe90PhTuJ2fbL6cuChcjRAd7p4VsCkLGfb5L3gDubRM+R5sJoEYiNjOZ8s8x17lwEJh7/DhFafMqHs1z+ocjCCplQiMe/K3y7NZjrsciSM5ge/zJsKzQDiOJEyPHKXebgva3QEA4V4VMFfTacgZYadsx+zjWm4zyphTw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ca216a-cafa-4b0b-5c23-08def8c52e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 22:58:10.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGVE7lRJ252NVT3Nhc78O8EYk6kujx4i30B3BIpG5S8YtRfvL34EO2vZX4ZWLG1O15r5JLLlXohrpSZPob7Pr3TD2wymMV+ZUqfXT4Te8UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6933
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE2OjAyICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiAt
CWlmICh1bmxpa2VseShSRUFEX09OQ0UodG9fa3ZtX3RkeCh2Y3B1LT5rdm0pLT53YWl0X2Zvcl9z
ZXB0X3phcCkpKQ0KPiArCWlmICh1bmxpa2VseShSRUFEX09OQ0UodG9fa3ZtX3RkeCh2Y3B1LT5r
dm0pLT53YWl0X2Zvcl9zZXB0X3phcCkpKSB7DQo+ICsJCXZ0LT5leGl0X3JlYXNvbi5idXNfbG9j
a19kZXRlY3RlZCA9IDA7DQo+IMKgCQlyZXR1cm4gRVhJVF9GQVNUUEFUSF9FWElUX0hBTkRMRUQ7
DQo+ICsJfQ0KPiDCoA0KDQpUaGlzIHN0aWxsIGZlZWxzIGhhY2t5IHRvIG1lLiBJdCBhdCBsZWFz
dCBkZXNlcnZlcyBhIGNvbW1lbnQgSSB0aGluay4gSWYgeW91DQpzcGluIGFub3RoZXIgdmVyc2lv
bi4NCg==
