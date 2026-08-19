Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69DB37F748;
	Wed, 19 Aug 2026 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787100808; cv=fail; b=WJ5YskxqlpUToJvKAKxcmwozh3uN51uSr5UHfMtafYzhyGYdNOE0EMFlPG8FEILJpjfNKHNXXL5muajYRd1xqliIHS4oqjDbOCLuUa5ivjLDVvwkL5b3wbO06QdKg5mAm2GzZlkGctIqxu7twLGkAHG3oLLlGLWx5uyU/Y1pLfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787100808; c=relaxed/simple;
	bh=t9wRBYfh42oZrAHD2tTbnjMWLQQcAXqcFvt0z8Obswk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AG35v7GCdYix3jyrZG8jZ79gt6kXoVqHQjeCYFyrBZE2RrXxjoqkKWaGQUSGc72rVC+chr7xn56sFdU/dQWL4Tt4hvtuktBpYxQpFS/fcBf2GTVdboarcj1dsZnulIu2ACr2KjzxHJauohUu/TBMTvXhytN6k6X1ZknSVgw6BRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+6/MKAR; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+6/MKAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787100803; x=1818636803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t9wRBYfh42oZrAHD2tTbnjMWLQQcAXqcFvt0z8Obswk=;
  b=i+6/MKARlwe56EGbHZDZJa/Xw0GmdZA/J8vNWnvsej0AbUR6Bw1BVtHn
   zkbFq/vOIq3lo9MWSbahV7DrY1LMyFqhrnfBIwGU4bmRVKV2ek1vaXOaa
   AFm+YjjZQpLpHB40R0bx3AxaSLRjW5efMebJBBKK1xtkjKJCMzhU0CKPM
   Mk+Ca2YptmOzreFkHNKqG62WcVshgaLp5Cu6dKOT0plwPhZlE99BQljCP
   ER6esLPf+iPhZ7RUB7sqLKSPOh+Tpde3chBzSgo/x9eMk9sUH86ymu4Yx
   1ormHcgZpEQZtGiCeGB0FI1kJzy1JjG2NmFxmKoCfAp/B6hv0Pu8CgEz3
   Q==;
X-CSE-ConnectionGUID: rcaiPCjYRhGtGz/pvyeLOQ==
X-CSE-MsgGUID: bUbekfIPTuWcLs7awNgyqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87669304"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87669304"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 17:53:21 -0700
X-CSE-ConnectionGUID: yuEyejQgR5GrY3wMLcittg==
X-CSE-MsgGUID: MM7DNWs+T1yRpRB4j//MYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="295300442"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 17:53:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 17:53:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 17:53:20 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 17:53:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWKDqz5K18j18CUUoaGbO6fPuoiEpqmqqvbRh3hsfJvhnYBcY/NofwvLQHPqVG1V6364Z4ZPOVM7awJhET0Ai4dgLTsy5ra2tj+1GUQYAZ5ABSYFEYuy4/DQcryTXv5FzFSkDcWjejEp+CCnEij2+HAIs2giBly1PKf+a4NJUjwfss8Pyxzio55EBmQk/trJlyZbRUVeVlaPGFSoVEmtGY6IngIIpnfuMa6qy5oKUUR6DTjBX7sMWfCn4v4ILvDeGIu6KBqs1Yo2aO6ijv0Krq5Zj0Nb1ZNJRoyKTL95uaJxjCOmOB2SsFB37gLjRmAE41oOUTNyXFWWZjmniuVosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9wRBYfh42oZrAHD2tTbnjMWLQQcAXqcFvt0z8Obswk=;
 b=t5LEKiO+rZQxKSQpIcmb0Xvqs/I2fSminwe14NjceUZkjAun9gsLup2VSFfVq+h9hxXed6ErHYBsS3fJcHClH1/hD4/gEf7y0Gn8YTn+ofh4JLrEKRSCzWmb37Yk2txEW7e4jCNg3OiyKdJkTGb3c5yLPWANEVxYc2cXve7jW0v3HhFvGvXBG979H4E5DnOGTtKeegw42Fo6tkSgP8ZjzCnmvHyTu5qghlXcca5pmD3yedw8UinF8mM5d8E0cwySAvAsj3Uqxow29UqaU5SzIetrzX7kQHjEx1y2h0Eo4UD9CKrYnui5PNFPwEN2Db2ux97QVaJfX+gixCTiA4hl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB9856.namprd11.prod.outlook.com (2603:10b6:510:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 00:53:12 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 19 Aug 2026
 00:53:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Huang, Kai"
	<kai.huang@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead of
 guessing it from CPUID
Thread-Topic: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead
 of guessing it from CPUID
Thread-Index: AQHdLD6aIiIDquy/9EahH8lhDbokubakkrIA
Date: Wed, 19 Aug 2026 00:53:11 +0000
Message-ID: <3a622cdb03b553cc9f8ce55b6df3c0091b3b06b9.camel@intel.com>
References: <20260814224509.2342760-1-seanjc@google.com>
In-Reply-To: <20260814224509.2342760-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB9856:EE_
x-ms-office365-filtering-correlation-id: 8614da32-08c5-44bb-e8c0-08defd8c3e80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 68/w+nloOY+RL5SSVFmcexxaJjzL0L1TSXHFbloFVUqsJhmuG3xuY+pvngC6bzx+plKmq8LdZuNaI5IzPIxHwr3ixJxZTq1w4B0HDcU/IPPrqYbh3vRbyBJHBvG27g2627OWBQVUKc+cXWGA5/LrFHhqZWGpvpF5fF602Pb9CbzOKmKy2EYtfrLY7QwEwQQXx5T1p03jRi/SiMNryF7OnsQOVlonn0uGn3JLeYFuFbDrf+UlvFj2QhiXEowoUjsyB27cwBAC/MS6kqwcE0zBA/rk6WwwGJQ6Y8oAYCGxfCMG/CchCpDWvmvFUUUX3oqy65BaccendqdeQ4Ea+B/tr7o2H+eFwHtyKabWL6RKKMsLbkBxfvjX7IjYNAUw8vXdSX2a5BQAeBEMfIOqlRhyEbGBiLFFnbQGlvNrWJTNRm5j99Dsr//lRHnUur8MO7ji/bPsADOU0Bj790B2phmxB+f+urXeILzyXvDy8u+9/iPTjhBIz9l1D9mHFn7TW6og9uPUvgh0aD5hp75PxIPt/BCQk/NW/Vmy/zWDq1kNFyG3EYvA5nnRp+yGAn6yKdycOCn0YwBBCd0e9scYlAh7DgiH+K7mjvohRuGOC4XQ5GR64THm2JTuJvkcrghIHq+2eCAxEbj+wJVK++acHj61ShmROKCZwY2i9nixYJMJFm9Iu7kh6gC0mjKSyfTX+LLHFzTeQnttCcFHLcnETvPQIxFS2Su3qcFZDO64G3U8yjI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjZNRmJwN1U0dVBzalNRdk5qYzgzWXRwZnBVbEthS3NLYnlPbHZ0Qnl5aW8y?=
 =?utf-8?B?TlY1MXREVVlmT0tRanJpaDlMWHdrdjNqQ1BVZytzT29qZGdXa2wvNnFtcHgy?=
 =?utf-8?B?L3YwalQ0M3dSaTJMaGJJSTk2Sk5DNy9FU0RUbmNaT25oWGxKUnZ5Z2FCYm83?=
 =?utf-8?B?K2ZuTllkNXA1ZXlVVURkbWlZNFdQWlFNUVk1QnJvTXh6VE9acm51WEszbEpw?=
 =?utf-8?B?eGl6WjlZVGVkb1FwWWdORVhIcWo0ZnJXUlRrOWJKblZUSkxqTEhKZ2xCeS9a?=
 =?utf-8?B?TmFlUUpDb3FPVVFITmFvSSs2bHMxWHhGWS9GM29GaXV3Z2FxcUJHbVFrUlhm?=
 =?utf-8?B?SzgvTW5vODJQOXhnb1lWOVp5L1QybXB2Uy9vanNBMEpPZHlPOWp0WjBzQ0ZM?=
 =?utf-8?B?RWJlMk1JMWJqazh1UkxDbFNJLzlSSXgzSk5Ec3Z0M3diWVpYb2VmdG15dndJ?=
 =?utf-8?B?WlJPb3I2SFRJOUJsbFFESEFMbDlRV2F4QUVYUnFZakpnc0NLSlRJYTFGQURO?=
 =?utf-8?B?WGJpNEpDSm9EZ2JmU3BsbDR5Y1o4eGFKMVBiamRwNW80bFFQeW5BYU5pK1FB?=
 =?utf-8?B?T0dQUVZBVUNROTFhbjdLSlRScEdmN2R3OXBXekR6VDZaZWdwY2x6NjNGM2Uy?=
 =?utf-8?B?RHZia1h5bGtZcC83OUYxZnJQLzc5TTVRbTZXMXRROVFOSjdveW9VZEFPNlVu?=
 =?utf-8?B?LzMzYTh3NTJTM2paTzZHNWtBS09ySmpYanhadlI2QjVYem9Ldy90VUZlQ3gx?=
 =?utf-8?B?WnAxSjZrOTV2eHFLMHAwMmUzZmw5NUtVbDdpbWVVQlZMTWRScEVYNnhSYXJX?=
 =?utf-8?B?Uzg3NVFqem5qTVpNRzNqR3FJazA1M0wySnAyaDUyTUJCdHpQcVlqcGtRQ1JW?=
 =?utf-8?B?dkZmdnAvUFh5eWk5QTBuaGtvRlFOczgrZkZjQWc5ell4S3I1ZkozOXhLTjdO?=
 =?utf-8?B?Uy90YTc2OHhyRXREMWZLTnBCbTgvKzIvQUg0dzBsUHlRSEI3dzZwa0IwYVdG?=
 =?utf-8?B?YjJrTTlTaVlKZXBmYnVsNGFZeHJ4UUl5TDV2YzdDWGwxODhsdVFXbldyVFFw?=
 =?utf-8?B?QWJZOUpRVzc0OUMxZlVCZUp1UVBSNkJKOUs1YmhZa2U1bmNzOFFYWk1ZaXFr?=
 =?utf-8?B?RTc0Y3g4MmNOellpaXVjZXhpaVdNclI5ek04Vy84WEp2S3kxNW1IdlE5eElm?=
 =?utf-8?B?WFNBWElDN2JxbGdaSmEzdjlBNW9rSUJqY29lOHRMUzA4UlJ4anFQejRROE5U?=
 =?utf-8?B?bnBueGwrcUhDMlQvVFNOdFNuQkE4blFGZVAzWEFjbDRDWWJJVDlEQUpKeVA4?=
 =?utf-8?B?ZVYwNVk5MWthRnJTS0g0ZFNCYmdmY2ZaT2NIMllKb3FXT1BQVG5QVE80aHg0?=
 =?utf-8?B?aDhjTWQxMkNzK0FQcUpnNGFnQ1NVQ2Z3NWpPeElDZC8wZjUrcWVLVDFDSy9u?=
 =?utf-8?B?YXYycHM2MjMzcVhrUXdBYkIvNmE5SCtwb3h5VUhoOG1aSkI1RnJpa0QwVTF5?=
 =?utf-8?B?eS9yVytKOFBFTXgyYmZDd3pBZzVabVV6WGlNc0x5QUx6QVFCeEQxc2ZVQUNO?=
 =?utf-8?B?eTVwMkNmcGtUY2hXQ2hxLzhLOHZlbXhseFNPTlpDSVF2UzA2SDFQblFubFVJ?=
 =?utf-8?B?Q3FoVUNETWZPNkRFNnRvN0tQcER0cnBjd3FnYXUrN3Y2aVd0R055SzkwWlpY?=
 =?utf-8?B?VFVYUXVsTGJTenJZcjBjQVlHeGZBYzRpUlMvZkFBd0QwYlVvNndOZzMvOTg3?=
 =?utf-8?B?elYyOVYxTUZ2NVdid3IxQmhJRTdMYU1BUndTeWtGQWRGMzh3OGZNd2dGSG1t?=
 =?utf-8?B?VEcvbmhmZ1N1aW5lUW1QQ09sUWw2RnhWa0VIdjg3UU1UNVBZbXRFVk5Cd1No?=
 =?utf-8?B?OFRMVXVOWTh3a085YmVMUnlhSjNVcDR6WmF5dUlXWkh4UnNIRC92dHkybUJO?=
 =?utf-8?B?NEF0OXpxL0hsMDJ4cFZFVGhjbGhpSFNqV2x4ZU15MHcwL0RLWkZtak1qemhZ?=
 =?utf-8?B?VEp0Ukt1VnBobDFEVU5Gc0pBYTVTdDFRUmFOQ2dYZnJSajBnMXJ6ekQxdFRw?=
 =?utf-8?B?UmV4SGdma2hDL25IQXRzNHZvWUJpUjZBM1ljYWcxUmFkc1hvK1dHV211VFFC?=
 =?utf-8?B?YURQN2hUYTQ3NUNHVGZCK0cxcDhKRmdEaktRNTFiaEhjbi8vVExGOSt6all1?=
 =?utf-8?B?S0duVHVvc05vWUJNUlZMYjV6ZUMyR3JhN1d0cGVOQU9CYldWYytCdUUzc2t1?=
 =?utf-8?B?NFlVYnQvTVdtM1Brd3pINDhtU3E1bmp6UWdJb2ZlKzNHcm1UaUU2UXhFajVC?=
 =?utf-8?B?VWJGRUZtYkVwTkVzWDdxRGNxakwzOVFEUWlxN0MreGdVeWZ5RVVrVGgvOG4y?=
 =?utf-8?Q?cV5KUFgqUl3EKg5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E08E5E197791542B7F17801A8AD9D50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JZzbOyyyaEKe521c3tg+rtPsB+CwpViMQ0w+nUiS2fJlqTUQ0IqWaOSO7y1uskrNHbsOgrK0+MrzwZz0BMaKliR0ui/SkA5NePpgzxci1fP0ombamL1mvkcotLIo2SuX3uOZexb2Pp+DydmiirLGZ9iYQxsoZmLIEhffW3kywN1ffScF8i+60ex7yfzUSHiX0yXgKQssS4gSBGN4nbYKhBHGFspSli+O5j1XP19GJsHyrrwFnmga9G1l6/N9DxU//T4sgg0jsuhhUdnJoWrZWrsMJRHel90JLVmgX0uy1hh3RavJVkUM999u+eRQhzC8kSiJPBTLkI5o6zNGirOZUg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8614da32-08c5-44bb-e8c0-08defd8c3e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 00:53:11.9021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhsWrzuqlj1iIpPbBsva4xX+Snl4QcDocgV+lsIMXYCrxRx/8ZcCNREdRa9AuaPAmz5aomkurII0JUfewhDKBYD/3k8CKPTvIt+ft7RkwJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9856
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTE0IGF0IDE1OjQ1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBFeHBsaWNpdGx5IHRyYWNrIHRoZSByb290IGxldmVsIGZvciBURFggVk1zIGluc3Rl
YWQgb2YgdHJ5aW5nIHRvIGluZmVyIHRoZQ0KPiBkZXB0aCBvZiB0aGUgcGFnaW5nIHRyZWUgYmFz
ZWQgb24gYW4gaW5kaXZpZHVhbCB2Q1BVJ3MgQ1BVSUQgaW5mb3JtYXRpb24uDQo+IEFwcGx5aW5n
IEtWTSdzIGV4aXN0aW5nIGxvZ2ljIHRvIHNlbGVjdCB0aGUgcm9vdCBsZXZlbCB0byBURFggaXMg
Zmxhd2VkIGFzDQo+IG5vdGhpbmcgKnJlcXVpcmVzKiB1c2Vyc3BhY2UgdG8gZmlsbCBpbiB0aGUg
Y29ycmVjdCBndWVzdC5NQVhQSFlBRERSIGZvciBhDQo+IHZDUFUncyBDUFVJRC7CoCBHdWVzc2lu
ZyBhdCB0aGUgY29ycmVjdCByb290IGxldmVsIGlzIGFsc28gcmlkaWN1bG91cyBnaXZlbg0KPiB0
aGF0IHVzZXJzcGFjZSBoYXMgYWxyZWFkeSB0b2xkIEtWTSB0aGUgcm9vdCBsZXZlbCBkdXJpbmcg
VEQgaW5pdGlhbGl6YXRpb24uDQo+IA0KPiBSZWx5aW5nIG9uIHVzZXJzcGFjZSB0byBzZXQgdGhl
IGV4cGVjdGVkL2NvcnJlY3QgQ1BVSUQgbGV0cyBhIG1pc2JlaGF2aW5nDQo+IHVzZXJzcGFjZSB0
cmlwIHRoZSBLVk1fQlVHX09OKCkgaW4gdGR4X2xvYWRfbW11X3BnZCgpIGJ5IGNvbmZpZ3VyaW5n
IGd1ZXN0DQo+IENQVUlEIHRvIHVzZSBhbiAiaW5jb3JyZWN0IiBndWVzdC5NQVhQSFlBRERSLg0K
DQpIbW0sIHllYS4gQnV0IHRvIG1lIHRoZSB0ZXh0IGlzIGEgbGl0dGxlIGFtYmlndW91cyB3aGF0
ICJjb25maWd1cmluZyBndWVzdA0KQ1BVSUQiIG1lYW5zLiBUaGVyZSBhcmUgdGhlIHR3byBjb25m
aWd1cmF0aW9ucyBvZiBDUFVJRCB0aGF0IGhhcHBlbiBhbmQgdGhlIGdvb2YNCndhcyBkdWUgdG8g
Zm9yZ2V0dGluZyB0aGF0IHRoZXJlIGlzIG5vIGVuZm9yY2VtZW50IGJldHdlZW4gdGhlIGZpcnN0
ICJkaXJlY3RseQ0KY29uZmlndXJhYmxlIGJpdHMiICh3aGVyZSAidXNlcnNwYWNlIGhhcyBhbHJl
YWR5IHRvbGQgS1ZNIHRoZSByb290IGxldmVsIGR1cmluZw0KVEQgaW5pdGlhbGl6YXRpb24iIGhh
cHBlbnMpLCBhbmQgdGhlIHNlY29uZCB0aGF0IGhhcHBlbnMgdmlhIG5vcm1hbCBTRVRfQ1BVSUQu
DQoNCkRvaW5nIGEgS1ZNX0JVR19PTigpIGlmIHRkeCBjb2RlIHNlZXMgYSBkaWZmZXJlbnQgbGV2
ZWwgdGhhbiB3aGF0IHdhcyBwcm9jZXNzZWQNCmluIHNldHVwX3RkcGFyYW1zX2VwdHBfY29udHJv
bHMoKSBzZWVtcyBnb29kIHRvIG1lLg0KDQo+IA0KPiBLZWVwIGdmbl9kaXJlY3RfYml0cyBldmVu
IHRob3VnaCBpdCBjYW4gYmUgdHJpdmlhbGx5IGRlcml2ZWQgZnJvbQ0KPiBtaXJyb3Jfcm9vdF9s
ZXZlbCBhcyBzYXZpbmcgYSB3aG9sZSBlaWdodCBieXRlcyBwZXIgVk0gaXMgbWVhbmluZ2xlc3Ms
IGFuZA0KPiB0aGUgdmFsdWUgaXMgcXVlcmllZCBmYWlybHkgb2Z0ZW4gYW5kIGluIGhvdCBwYXRo
cy4NCg0KZ2ZuX2RpcmVjdF9iaXRzIGNvbWVzIGRpcmVjdGx5IGZyb20gdGhlIHRoZSBpbml0aWFs
IGNvbmZpZ3VyYXRpb24sIHNvIHdoeSBkbyB3ZQ0KbmVlZCB0byBhZGQgbWlycm9yX3Jvb3RfbGV2
ZWwgaW4gdGhpcyBwYXRjaD8gVGhlIG9sZCBjb2RlIGNhbGN1bGF0ZWQgc2hhcmVkIGJpdA0Kd2l0
aCBhIGNvbmRpdGlvbmFsLCBzbyB3ZSBjb3VsZCBlYXNpbHkgY29tcHV0ZSBsZXZlbCB3aXRoIGFu
IGludmVydGVkDQpjb25kaXRpb25hbC4gVGhlIG1pcnJvcl9yb290X2xldmVsIGNhY2hpbmcgaXMg
dGhlbiBhIHNlcGFyYXRlDQpjbGVhbnVwL2VuaGFuY21lbnRzLg0KDQpPaGhoLCBiZWNhdXNlIHRv
IGNhbGN1bGF0ZSBpdCBrdm1fbW11X2dldF90ZHBfbGV2ZWwoKSB3b3VsZCBlbWJlZCBzb21lIFRE
WA0Kc3BlY2lmaWNzIHRoZXJlLg0KDQpXYWl0LCBubywgdGhpcyBrbm93bGVkZ2UgZW1iZWRzIGlu
IGt2bV9tbXVfc2V0X21pcnJvcl9yb290X2xldmVsKCkgYW55d2F5LiBTbw0KSSdkIHRoaW5rIHRv
IGp1c3QgaGF2ZSB0aGUgYmVsb3cuIElmIGNvbXBhcmluZyBnZm5fZGlyZWN0X2JpdHMgdG8NCmdm
bl9kaXJlY3RfYml0cyBkb2Vzbid0IG1ha2Ugc2Vuc2UsIHRoZW4gbGV0J3MganVzdCBkcm9wIHRo
ZSBLVk1fQlVHX09OKCkuDQoNCg0KIGFyY2gveDg2L2t2bS9jcHVpZC5jICAgfCAxNCAtLS0tLS0t
LS0tLS0tLQ0KIGFyY2gveDg2L2t2bS9jcHVpZC5oICAgfCAgMSAtDQogYXJjaC94ODYva3ZtL21t
dS5oICAgICB8ICA1ICsrKysrDQogYXJjaC94ODYva3ZtL21tdS9tbXUuYyB8IDE2ICsrKysrKysr
LS0tLS0tLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL2NwdWlkLmMgYi9hcmNoL3g4Ni9rdm0v
Y3B1aWQuYw0KaW5kZXggZGRiMDIyY2IyMDNhLi4zNGM2MDlhNjBlZWYgMTAwNjQ0DQotLS0gYS9h
cmNoL3g4Ni9rdm0vY3B1aWQuYw0KKysrIGIvYXJjaC94ODYva3ZtL2NwdWlkLmMNCkBAIC00ODMs
MjAgKzQ4Myw2IEBAIGludCBjcHVpZF9xdWVyeV9tYXhwaHlhZGRyKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSkNCiAgICAgICAgcmV0dXJuIDM2Ow0KIH0NCiANCi1pbnQgY3B1aWRfcXVlcnlfbWF4Z3Vl
c3RwaHlhZGRyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCi17DQotICAgICAgIHN0cnVjdCBrdm1f
Y3B1aWRfZW50cnkyICpiZXN0Ow0KLQ0KLSAgICAgICBiZXN0ID0ga3ZtX2ZpbmRfY3B1aWRfZW50
cnkodmNwdSwgMHg4MDAwMDAwMCk7DQotICAgICAgIGlmICghYmVzdCB8fCBiZXN0LT5lYXggPCAw
eDgwMDAwMDA4KQ0KLSAgICAgICAgICAgICAgIGdvdG8gbm90X2ZvdW5kOw0KLSAgICAgICBiZXN0
ID0ga3ZtX2ZpbmRfY3B1aWRfZW50cnkodmNwdSwgMHg4MDAwMDAwOCk7DQotICAgICAgIGlmIChi
ZXN0KQ0KLSAgICAgICAgICAgICAgIHJldHVybiAoYmVzdC0+ZWF4ID4+IDE2KSAmIDB4ZmY7DQot
bm90X2ZvdW5kOg0KLSAgICAgICByZXR1cm4gMDsNCi19DQotDQogLyoNCiAgKiBUaGlzICJyYXci
IHZlcnNpb24gcmV0dXJucyB0aGUgcmVzZXJ2ZWQgR1BBIGJpdHMgd2l0aG91dCBhbnkgYWRqdXN0
bWVudHMgZm9yDQogICogZW5jcnlwdGlvbiB0ZWNobm9sb2dpZXMgdGhhdCB1c3VycCBiaXRzLiAg
VGhlIHJhdyBtYXNrIHNob3VsZCBiZSB1c2VkIGlmIGFuZA0KZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2t2bS9jcHVpZC5oIGIvYXJjaC94ODYva3ZtL2NwdWlkLmgNCmluZGV4IDhkODYzZjQ1NTg1ZC4u
NDZiZmU4Njk5ZTY3IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL2NwdWlkLmgNCisrKyBiL2Fy
Y2gveDg2L2t2bS9jcHVpZC5oDQpAQCAtNjgsNyArNjgsNiBAQCB2b2lkIF9faW5pdCBrdm1faW5p
dF94c3RhdGVfc2l6ZXModm9pZCk7DQogdTMyIHhzdGF0ZV9yZXF1aXJlZF9zaXplKHU2NCB4c3Rh
dGVfYnYsIGJvb2wgY29tcGFjdGVkKTsNCiANCiBpbnQgY3B1aWRfcXVlcnlfbWF4cGh5YWRkcihz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOw0KLWludCBjcHVpZF9xdWVyeV9tYXhndWVzdHBoeWFkZHIo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsNCiB1NjQga3ZtX3ZjcHVfcmVzZXJ2ZWRfZ3BhX2JpdHNf
cmF3KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7DQogDQogc3RhdGljIGlubGluZSBpbnQgY3B1aWRf
bWF4cGh5YWRkcihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL21tdS5oIGIvYXJjaC94ODYva3ZtL21tdS5oDQppbmRleCAyYWU3ZjllZDRjZjguLmU5NTBm
NjU2MDA3ZSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2t2bS9tbXUuaA0KKysrIGIvYXJjaC94ODYv
a3ZtL21tdS5oDQpAQCAtMzg5LDYgKzM4OSwxMSBAQCBzdGF0aWMgaW5saW5lIGdwYV90IGt2bV90
cmFuc2xhdGVfZ3BhKHN0cnVjdCBrdm1fdmNwdQ0KKnZjcHUsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4Y2VwdGlvbiwgcHRlX2FjY2Vzcyk7
DQogfQ0KIA0KK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGt2bV9tbXVfZ2V0X21pcnJvcl9y
b290X2xldmVsKHN0cnVjdCBrdm0gKmt2bSkNCit7DQorICAgICAgIHJldHVybiBrdm0tPmFyY2gu
Z2ZuX2RpcmVjdF9iaXRzID09IEJJVF9VTEwoNDcpID8gNCA6IDU7DQorfQ0KKw0KIHN0YXRpYyBp
bmxpbmUgYm9vbCBrdm1faGFzX21pcnJvcmVkX3RkcChjb25zdCBzdHJ1Y3Qga3ZtICprdm0pDQog
ew0KICAgICAgICByZXR1cm4ga3ZtLT5hcmNoLnZtX3R5cGUgPT0gS1ZNX1g4Nl9URFhfVk07DQpk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21tdS9tbXUuYyBiL2FyY2gveDg2L2t2bS9tbXUvbW11
LmMNCmluZGV4IDA2NGVjYzMzYjkyNi4uMDI1ODcxNDAzNTk3IDEwMDY0NA0KLS0tIGEvYXJjaC94
ODYva3ZtL21tdS9tbXUuYw0KKysrIGIvYXJjaC94ODYva3ZtL21tdS9tbXUuYw0KQEAgLTU5NTMs
MTkgKzU5NTMsMTkgQEAgdm9pZCBfX2t2bV9tbXVfcmVmcmVzaF9wYXNzdGhyb3VnaF9iaXRzKHN0
cnVjdCBrdm1fdmNwdQ0KKnZjcHUsDQogDQogc3RhdGljIGlubGluZSBpbnQga3ZtX21tdV9nZXRf
dGRwX2xldmVsKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCiB7DQotICAgICAgIGludCBtYXhwYTsN
Ci0NCi0gICAgICAgaWYgKHZjcHUtPmt2bS0+YXJjaC52bV90eXBlID09IEtWTV9YODZfVERYX1ZN
KQ0KLSAgICAgICAgICAgICAgIG1heHBhID0gY3B1aWRfcXVlcnlfbWF4Z3Vlc3RwaHlhZGRyKHZj
cHUpOw0KLSAgICAgICBlbHNlDQotICAgICAgICAgICAgICAgbWF4cGEgPSBjcHVpZF9tYXhwaHlh
ZGRyKHZjcHUpOw0KLQ0KICAgICAgICAvKiB0ZHBfcm9vdF9sZXZlbCBpcyBhcmNoaXRlY3R1cmUg
Zm9yY2VkIGxldmVsLCB1c2UgaXQgaWYgbm9uemVybyAqLw0KICAgICAgICBpZiAodGRwX3Jvb3Rf
bGV2ZWwpDQogICAgICAgICAgICAgICAgcmV0dXJuIHRkcF9yb290X2xldmVsOw0KIA0KKyAgICAg
ICAvKg0KKyAgICAgICAgKiBJZiB0aGUgVk0gaGFzIG1pcnJvciByb290cywgdGhlbiB0aGUgcm9v
dCBsZXZlbCBpcyBmaXhlZCBhcyB0aGUgZ2ZuDQorICAgICAgICAqIHVzZWQgdG8gc2VsZWN0IGJl
dHdlZW4gdGhlIG5vcm1hbCBhbmQgbWlycm9yIHJvb3QgbXVzdCBiZSBjb3ZlcmVkLg0KKyAgICAg
ICAgKi8NCisgICAgICAgaWYgKHZjcHUtPmt2bS0+YXJjaC5nZm5fZGlyZWN0X2JpdHMpDQorICAg
ICAgICAgICAgICAgcmV0dXJuIGt2bV9tbXVfZ2V0X21pcnJvcl9yb290X2xldmVsKHZjcHUtPmt2
bSk7DQorDQogICAgICAgIC8qIFVzZSA1LWxldmVsIFREUCBpZiBhbmQgb25seSBpZiBpdCdzIHVz
ZWZ1bC9uZWNlc3NhcnkuICovDQotICAgICAgIGlmIChtYXhfdGRwX2xldmVsID09IDUgJiYgbWF4
cGEgPD0gNDgpDQorICAgICAgIGlmIChtYXhfdGRwX2xldmVsID09IDUgJiYgY3B1aWRfbWF4cGh5
YWRkcih2Y3B1KSA8PSA0OCkNCiAgICAgICAgICAgICAgICByZXR1cm4gNDsNCiANCiAgICAgICAg
cmV0dXJuIG1heF90ZHBfbGV2ZWw7DQoNCg0KPiANCj4gQ2M6IFJpY2sgRWRnZWNvbWJlIDxyaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gQ2M6IFhpYW95YW8gTGkgPHhpYW95YW8ubGlAaW50
ZWwuY29tPg0KPiBDYzogQmluYmluIFd1IDxiaW5iaW4ud3VAbGludXguaW50ZWwuY29tPg0KPiBD
YzogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KPiBDYzogWWFuIFpoYW8gPHlhbi55
LnpoYW9AaW50ZWwuY29tPg0KPiBGaXhlczogMjBkOTEzNzI5YzExICgiS1ZNOiB4ODYvbW11OiBU
YWtpbmcgZ3Vlc3QgcGEgaW50byBjb25zaWRlcmF0aW9uIHdoZW4NCj4gY2FsY3VsYXRlIHRkcCBs
ZXZlbCIpDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29n
bGUuY29tPg0KPiAtLS0NCj4gDQo+IENvbXBpbGUtdGVzdGVkIG9ubHksIGFuZCBmb3VuZCBieSBp
bnNwZWN0aW9uLCBpLmUuIEkgaGF2ZW4ndCBwcm92ZW4gdGhhdCB0aGlzDQo+IHdvcmtzLCBvciB0
aGF0IHRoZXJlJ3MgYWN0dWFsbHkgYSBidWcuwqAgQnV0IEknbSBwcmV0dHkgc3VyZSB0aGVyZSdz
IGEgYnVnLg0KPiANCj4gQ2FtZSBhY3Jvc3MgdGhpcyB3aGVuIGxvb2tpbmcgYXQgb3VyIG91dC1v
Zi10cmVlIGludHJhaG9zdCBtaWdyYXRpb24gY29kZSwgYW5kDQo+IHdhbnRlZCB0byBhc3NlcnQg
dGhhdCBjb3VsZCBiZSBhdCBtb3N0IG9uZSBtaXJyb3Igcm9vdCBwZXIgVERYIFZNLg0KDQpJIHJl
Z3Jlc3Npb24gdGVzdGVkIGl0IGluIG91ciBDSS4gSSBkb24ndCBoYXZlIGEgVERYIHNldHVwIHRo
ZSBwYXN0IHR3byBkYXlzIHRvDQp0cnkgdG8gcmVwcm9kdWNlIGl0IHNwZWNpZmljYWxseS4gQnkg
aW5zcGVjdGlvbiBpdCBhbHNvIGxvb2tzIGxpa2UgYSBidWcgdG8gbWUuDQoNCg==
