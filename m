Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955E1DA23;
	Sat,  4 Apr 2026 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261482; cv=fail; b=hJSXGWrLri0q9diGwDyl+NZ8qSU6jbawa8d3Up0niHwt7tb4JHVgIS3NoWZFEOgknZA4hSxJJ/rQbNcDqsvL1Kex7db5fouaWzXuGfJtxwwpJFmXvXQmJGA4ffiywVT0gv4uLcS82D9uxhRTvHG6Sg98Ren1JbIBepSLwAgJrXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261482; c=relaxed/simple;
	bh=ML6udFepUneZqKYi9odAdyR1H/E+ipmv+aHEgaU6nqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YmVkukCY/qyI5kgGn2fXTK94xAI0BS+ccpuD2+RByz6PJB2h6mQNfSeP4PB9/l0ekwJARJECI57Lq3daU3+57Ge8qdg7oM4N8+4dwdEgQS4S3tNu3uQH3M1iSzWMMBNbsEmPVs1Y3P9YRwNIHTZKV37G8s2hGO5Gzp2bY9mrxwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEwfoOMf; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEwfoOMf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775261481; x=1806797481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ML6udFepUneZqKYi9odAdyR1H/E+ipmv+aHEgaU6nqs=;
  b=EEwfoOMfvzxP0H4yoKSaF+NQHie5mOZK8RV71lbVgYPI0e+r+qUkSGsc
   FoYHR5UIrHvL/ZT9XvNevuf677TxaUaJszkTyPAJ9qIJ6aDOwlyOvaagR
   Oevr3xyC7+JrLRmCtR5cqemc0YJOHgM41eoxcexjyQcSApjkNSppxn/No
   v/tnnnnomezjW+sd0SSI6IMOunQVAnoulm6TeqPKF+7GyHAqOUA7DfHkR
   YKuUCWX5sFOPfiQhPXwq5XZckH4fXJ+CD3i2wjZawAMajtPijJ5cM2d7Z
   WNdq/PD+J+YuZg8qKfwkr06wCi3gYkuLNnK+z4f6wDC2AEN4HFY9UPSiM
   Q==;
X-CSE-ConnectionGUID: vqC5xP5CR4GCUaE8rKV5kg==
X-CSE-MsgGUID: DtHd0+d8TcSxqfxePRCBpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="63872361"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="63872361"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 17:11:20 -0700
X-CSE-ConnectionGUID: MZ4v9BwwSSSLa14siUHNtA==
X-CSE-MsgGUID: /rhlmHQGSNuh13E9Svt+0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="227624613"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 17:11:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 17:11:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 17:11:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 17:11:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfF86V/8nPJwEWzPwuXeOBgnMP49vFrmzL62Ij/M8VUQtCcCM1Mbyfq06LVXRf8Hqeth2iB5SGXCcVuGKgVMgFKeoR3Bs+nl1ND4ZB1nU5tH5RPD7dXWOUPhYMk2U7goo0JGox2F1eVPmZqyy6c+99WtCp506Kbp27vWs99YtG/khev/tkudPBuUl9Re5XpXwuyrW/lPHQhCcInENqxOExCkTa09vnCr1Z2LDtdc7nh6xN/q3l750l5tWUcG1td+9Of9TVhOP/oBuyaSNzy4Jn7Ju4iKAPTr8Pi8dB0RMD2VBjVtOaTCcs6cDNxKdwTZ3AHYdOD728tDrLVzGBHNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ML6udFepUneZqKYi9odAdyR1H/E+ipmv+aHEgaU6nqs=;
 b=BBAAGbHMeMPIWlj9jTq3qcNEXI9bJqZV/HNodvit6KnnpoVICep4mWCME4uSaGg4K/W+8jQkO5ibWeVDEJkXEqWIBwjHDVPlu4CURXvX0/cP9GAmPG3Lc1EOiix3jWqagZ7mJSV7jt0dEz2ucKG1GduJ9W4mRFVYwu4ZDI+Y5SjyK1+eujSeBDkVnwQsdH9/GzN0JAS6IKh7ou5/A5cwp0FmdJt+jJKo9+KkMo6TN2N3jSiiz4zXv/nooUDl+DfJqYahYsUadxe4/GqcFxZOxYItC0ooqRFTouYW9psLmvLJbnw/MaB1/nuhWUFdQgvWi47UE6FWVw55FvIHG4ykWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB7124.namprd11.prod.outlook.com (2603:10b6:510:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sat, 4 Apr
 2026 00:11:15 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Sat, 4 Apr 2026
 00:11:15 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"dmaluka@chromium.org" <dmaluka@chromium.org>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "hpa@zytor.com"
	<hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
Thread-Topic: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
Thread-Index: AQHctwnFo9ayO2gQokudL8i/bTewfbW0sMWAgABcswCAAAmDAIAAYmaAgADG/ICAF2AAgIAAJEgAgAAHn4CAAAY9gIAAPMOAgAARwIA=
Date: Sat, 4 Apr 2026 00:11:14 +0000
Message-ID: <faac37c7ba9e3a2e8d996e18c74301d9cefad3dc.camel@intel.com>
References: <20260318190111.1041924-1-dmaluka@chromium.org>
	 <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com>
	 <cb99e44c-8bc9-4bab-b485-9f63a4d0b262@linux.intel.com>
	 <93358559-5ed1-4574-8951-24d7ea9354e4@intel.com>
	 <ee8d7ea3-0ece-43cf-ab07-6954df4c01ad@linux.intel.com>
	 <f67179d7050ae28ac261bb6227b1c045c10579c9.camel@intel.com>
	 <ac_rNT69TdocrMYc@google.com>
	 <401db97a254b356ad8539a5d637d68ee826179a5.camel@intel.com>
	 <adAQCXI-7Yj0wcKA@google.com>
	 <ec581571ab4141ed77e6979b3e03773e301a62c1.camel@intel.com>
	 <adBIPdBA-aJWcUrY@google.com>
In-Reply-To: <adBIPdBA-aJWcUrY@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB7124:EE_
x-ms-office365-filtering-correlation-id: 71a3c389-b725-4e87-0b0a-08de91deafb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: ZUKvu6oZZazj7ZqNoAlJVuWJLCMrGK43bLu7oqWVbEtsmv6OuzKz3Y4bZ33kS/0n6lWjJHEVEYQL0aVUMPHfhxuDI8VmqpH8PT//rDG04E/+1tHli2fCESSURAdPcQ+l19CUb/ehNFuf81tzjyNYwmXHQZY2oIc3Zyro9yof1J+GXXiEwM55miOJUN+5Mvnn2BUt5AKMZWBcKgm3/MKzjEeAkfBqxACbD5w44dEbsQK2y27MhgEnq93gDKfBVa6CHEMUi9m588K3qbXCQhUSj2vODu6h0GwdpYva/KEGWJvaKRBPea9x7zSIVD3HU7ckYTk5G5cGK/mEUvnpRk/0Yh5rH8whXth01NjKI3TUkGkneu25sjuGHi192xVBb3OZcxaqOUZznX9LKHxLKE1yG3wcGmNdrPPtr1ZGNW2AF6gBVLVt3b/X4rZ8WHKB+J0dMqS6MiBBK8muE1fzzd9W9m8OpkeO+cYKvqgdwqbipIkA+s5uMtjR/H8+ITOt3VCqieg01y1hV4NGMfoh5VKoACJ1WkZTfzs8+5wd4K3hKF7itozJv+tuyUO4LO3WZN2ccYjwmaQmQXBUohW7P+RpHpf6eoW/lS2OwUGrs614wbV9Q8VorW6QkDqrRluoe6++oYFHY/wa4R9m4as2oBueo5prnW/4hV0xUkkJkdRvv4U9q5RakAp/2IQoZeouTZY8I3WBmfa2u/fDiLCQM27s7BVbZ2mdPGvP9+PWhZoGqs++2bFmgWfREcSYf9GHVSmNRMFuIsSzvgLBAkNEnMf73HPz9MEQJZ2GbhHT3m6Y3nw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE10TFhEd3hyZzlpMWxUWTFYQkhISzFMZUJtc1lQaHROeEhKNUxpNnZJNGtv?=
 =?utf-8?B?ZzBmMldqK3UwN2Jod2xTRERENHQyTzUvR2IxL1I4K2JwVHY3NmQ4WURHZGMr?=
 =?utf-8?B?Z2JnSlloVGM2RFh3UFQyc3RuZWN1dys3bjhneXZ3NS9RNlJUQjV3dVA0WDFr?=
 =?utf-8?B?QXJwejRGNGdLbHZ5bHFBTnh5dlhXZ1ZuNFpUTThqL1Zua0ZXd25SbzBrdU9j?=
 =?utf-8?B?UlcvN1Z3ekNoVUdwcEFGK2xPZVJQUjZYL2ptSVZadVNIVThEbW5aTW51V3pl?=
 =?utf-8?B?NStoWENhZ0tFWHhCTFB1M2tReDVpZnVuRk8zN2lLL2htc3hSbGJ3U3NLZHpJ?=
 =?utf-8?B?VGNkdkdzL3hTQkRNMzFsZGJQb2cwUHQraEZ4aHBIUVBHa1JNTzBoVkROZWkz?=
 =?utf-8?B?SkE2TForenhwUWpZU1lhSlRMVHRzZjFmTWZxTk9vSWlubnh1T0FaUTZTMjEx?=
 =?utf-8?B?RTRNWlB4eUVQcXlBZGI5eEJ6SzZzMlFUc0hYQ1YxZVI4R3dNNVdadGtreVFv?=
 =?utf-8?B?ek1haTEyL0UwTEREbzhzYU1CMEVGOUZIUVZXYkV5MnBDQ1dBQXp2RzFPaElY?=
 =?utf-8?B?dU1XM1liM1FaUjNibVNIUG1FdG8wTk5TR3FiS0pVbG1mNDZxRXRBL3RwT2tv?=
 =?utf-8?B?NUZOU0V4Ty90T0dzTWZoSU9DT1V3eFdhWmptb2dINmRmWGFwNzZwSnVoRHV2?=
 =?utf-8?B?TldXV2dLNGZ3TStHQjVYbThXRmEzb090VUdJTEh0UUZxY09sM0QrbHpWWG9V?=
 =?utf-8?B?R2hYYXVWcFpJTDRVTmtENW5wQUtkeGtJVmVJN1lhSzJ5U0I1Vmh3VUNCOTB5?=
 =?utf-8?B?cnpreWpxbkZ0ZDExRnB2dmpCakRmSHB4RHFEbVpzMkdRdXovWHhydGF1UDNF?=
 =?utf-8?B?bUJDMDVRaDlTVlVDN2tUTEZmeU90RDlHbHViMWxRNEVsU1VIRVpESUp2ZU4v?=
 =?utf-8?B?aU1nekpteDcyTlY0SUJDejEwYWtZNWo0bkFCTFF1NG55bVhIWGU4L2Q5eWhD?=
 =?utf-8?B?RklJMUNabE1ZUmMrUkRvenpTWmxtV2F0Ujl6UmltY3dGQjZ3MG41djlKT0dN?=
 =?utf-8?B?UFFRN3kzeVRpR2VVckJZa09VREYxeWpwMVowUmJYdDRZS0JhWVpMM2h6OHc4?=
 =?utf-8?B?OHQwSjhTbmhUT09seWhFcXZrZ0FyajFTYTN0eHN1aG1pWk84TGhmSkEyZjUr?=
 =?utf-8?B?TGpxNEdPa09CY2RXMXpscUVnTUFEaVNWQ29PaTF6YkZVbmRQTlRsNkNLTy9V?=
 =?utf-8?B?c3RWTnFidENZQklxNUhnUmlnZlV1TTQ0TytFTE1ZSXlrVENkWWxnckxXa1JN?=
 =?utf-8?B?U3R1MkFSTXhwbmhIc2JRTWdYRHFyWTdXY05TK3dxdkp6VDA3K1BnRzdKeEZm?=
 =?utf-8?B?c3k5WkFzd1l4dmlsTUFBT3JqN3RIdWtoWWRLakxPNmZiMWE5RmU4Ry9uZUtN?=
 =?utf-8?B?NXBxSmdIZkU0UlBaMVNERWZIRDk4UUt5bHhoWXJSa1hkOGtqK2x0QzJQT2xJ?=
 =?utf-8?B?VXc2ZGkwTUlRbGJKWU5iMzN3S2IyRkMyQzJEUS9wcDc4V1NDSjQweDRqTy9X?=
 =?utf-8?B?RUZ4cmIyQklXNy9jbzhxeWNmQ1o0UDdva2hVL2lwWGtuWVB3YzZJY3RYcGxS?=
 =?utf-8?B?WGVTYXd0MmlMR0dJaDQ5R3dqenFzSWdNd0FCM2Z3WDE1M1gyQnVZM3MwamVw?=
 =?utf-8?B?RHBPSTNJMjBSVlRUSlNSUmYvcHpoSGVxVTNBR3NjcTNnNjlZN25CcXp0elZU?=
 =?utf-8?B?dFhOVkYrUnVYN3orZWtmMTVuWU44V2RDSDdTaTFJQ0RlZ2dLVnlRNU1rblhI?=
 =?utf-8?B?ODRVMHozK3lnQjd4VFp5M0IvZlN5RkRnbk5oa2htUi90bTZ0WGJCblV0dTBm?=
 =?utf-8?B?YkIzVmpLOWJ6cHJLWjAzMS9wdEd1RVNIbTVsRTc3TXY0NU5kV3I2MitURWFh?=
 =?utf-8?B?c1RaUllBbHRROHV4dDVUSGlIcFdKWm9uekFITTJyQ0dnRjVUWlpJYVBsK1pi?=
 =?utf-8?B?azM0SFlXMlQzOFZHN3ZWSFg4cmFsdEZYSlNNQlA1N21JdHpJZVpGVWlVR2E4?=
 =?utf-8?B?QytWQ2t0c0kxZUhNeVFwNFk5OHV6TDdOcGI2MkVaU0U0LzUyS0NPQ0Z5TzdK?=
 =?utf-8?B?R1grUGcyREk4clo4VzYxSndnbEwxc05MVFlIZFE0em5wZS9GSUNoV2JlL2sx?=
 =?utf-8?B?eGkxSjRDOVdkcnF4MnZsY2NrS25MeEprbXFsQ2dZR3hIeWc2NEdvdzZmaGh3?=
 =?utf-8?B?ZW5FT1puZ3gvbi9EMVBFUmJNc0NrZElNL1JDc0phdnJzZVZPWlIwRWNyUHFP?=
 =?utf-8?B?V2MrWG9vZG5tbisyNFo5b3lMcm5pcjRCaW9YeklxRXZ0Qnl3QVEvaXJNSVlV?=
 =?utf-8?Q?/lJyo+5qhXE+ZnDA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41EF5E862691F84F89544496DFCC68CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qWZStosdONlCKstG9Ass8sylYtnI+2WN+8mffeWftXmzo6a0OdmvpX2Vdk4paF1SEKDfjLvW9nfEsdtMzvSQxRaG4ZHZZjABDBNyM+AtqwBzUQBdCvxQg1Rq3PTCPU1RJqNtE8voahYrriLPqkcRRuan0pgePGoLM9hyMIzVjHGRTNKQglGC0yuf4KGmOoKsdVVq4hCHDUz7XEcTukOweuBlYom+YeNOUPqAJKuMaIWnuezGu50kCdhlR5M76ZZSRjQlX8gnKfjQX4KLObiVhdpj+DMsrP4KMZS4H897fLcAx1nR9Byec72toveaqa5612CfxWSBTrhHmtekkG5Pbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a3c389-b725-4e87-0b0a-08de91deafb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2026 00:11:14.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ciqHueSDPthzwaII+xG3KCSzonMDTnWWIhxWNBa6Ji6Sn3MAD7APfy9Av0PgXFjLYMPTvFtuoRMLAxtXschGRsb0f4xGCBhrzj/5Poh+0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7124
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA0LTAzIGF0IDE2OjA3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IEkgbWVhbiBvbmVzIHdoZXJlIHdybXNyIGlzIGhhbmRsZWQgYnkgdGhlIFREWCBt
b2R1bGUgaW5zdGVhZCBvZiBnZW5lcmF0aW5nIGENCj4gPiAjVkUgdGhhdCBnZXRzIG1vcnBoZWQg
aW50byBURFZNQ0FMTCBieSB0aGUgZ3Vlc3QuIEFjdHVhbGx5IHVzdWFsbHkgY2FsbGVkDQo+ID4g
Im5hdGl2ZSIsIGJ1dCBJIGp1c3QgcmV1c2VkIHlvdXIgImFjY2VsZXJhdGVkIiB0ZXJtIGZyb20g
dGhlIG1haWwuDQo+IA0KPiBJdCdzIG5laXRoZXIuwqAgUHJlY2lzaW9uIG1hdHRlcnMgaGVyZSwg
b3RoZXJ3aXNlIEkgY2FuJ3QgZm9sbG93IGFsb25nLsKgDQo+IEFjY2VsZXJhdGVkIG1lYW5zIHRo
ZSBDUFUgdmlydHVhbGl6ZXMgaXQgd2l0aG91dCBzb2Z0d2FyZSBpbnZvbHZlbWVudC7CoCBOYXRp
dmUNCj4gd291bGQgbWVhbiB0aGUgZ3Vlc3QgaGFzIGRpcmVjdCBhY2Nlc3MgdG8gYmFyZSBtZXRh
bCBoYXJkd2FyZS7CoMKgDQoNCk9oLCBzb3JyeS4gDQoNCj4gSUlVQywgd2hhdCdzIGhhcHBlbmlu
ZyBoZXJlIGlzIHRoYXQgdGhlIFREWC1Nb2R1bGUgaXMgZW11bGF0aW5nIHgyQVBJQyBzdHVmZi4N
Cg0KSSdsbCBzdGljayB0byB0aGlzIGxhbmd1YWdlLiBUaGUgdGR4IGRvY3MgY2FsbCB0aGVtIGRp
ZmZlcmVudGx5IG9mIGNvdXJzZS4NCiJuYXRpdmUiIHRoZXJlIGlzIGFib3V0ICNWRSBvciBub3Qu
IFNvIEkgY2FuIHRhbGsgYWJvdXQgaXQgd2l0aCByZXNwZWN0IHRvIFZFIG9yDQohVkUuDQoNCj4g
DQo+ID4gU28uLi4gIlJlZHVjZWQgI1ZFIiAoYWxzbyBjYWxsZWQgIlZFIHJlZHVjdGlvbiIpIHJl
ZHVjZXMgd2hpY2ggdGhpbmdzIGNhdXNlDQo+ID4gYSAjVkUuIFRoZSBndWVzdCBvcHRzIGludG8g
aXQgYW5kIHRoZSBURFggbW9kdWxlIHN0YXJ0cyBiZWhhdmluZw0KPiA+IGRpZmZlcmVudGx5LiBJ
dCdzIGtpbmQgb2YgZ3JhYiBiYWcgb2YgY2hhbmdlcyBpbmNsdWRpbmcgY2hhbmdpbmcgQ1BVSUQN
Cj4gPiBiZWhhdmlvciwgd2hpY2ggaXMgYW5vdGhlciB3cmlua2xlLiBJdCB3YXMgaW50ZW5kZWQg
dG8gZml4dXAgZ3Vlc3Qgc2lkZSBURFgNCj4gPiBhcmNoIGlzc3Vlcy4NCj4gDQo+IEFuZCBLVk0g
aGFzIG5vIHZpc2lsaWJpdHkgaW50byB3aGljaCBtb2RlIHRoZSBndWVzdCBoYXMgc2VsZWN0ZWQ/
wqAgVGhhdCdzDQo+IGF3ZnVsLg0KDQpZZWEsIG9uIGJvdGggYWNjb3VudHMuIFNvIHdoZXJlIHdl
IGFyZSBhdCB3aXRoIHRoaXMgaXMsIHN0YXJ0aW5nIHRvIHJlamVjdA0KY2hhbmdlcyB0aGF0IGJ1
aWxkIG9uIHRoZSBwYXR0ZXJuLiBXZSBoYXZlbid0IGdvbmUgc28gZmFyIGFzIHRvIGFzayBmb3Ig
YQ0KZmVhdHVyZSB0byBub3RpZnkgdGhlIGhvc3Qgb2YgdGhlIGd1ZXN0IG9wdC1pbnMuIEJ1dCBJ
IHdvdWxkbid0IHNheSB3ZSBoYXZlIGENCmdyYW5kIGRlc2lnbiBpbiBtaW5kIGVpdGhlci4gSWYg
eW91IGhhdmUgYW55IGNsYXJpdHksIHBsZWFzZSBmZWVsIGZyZWUgdG8gZHJvcCBhDQpxdW90YWJs
ZS4NCg0KPiANCj4gSWYgS1ZNIGhhcyBubyB2aXNpYmxpdHksIHRoZW4gSSBkb24ndCBzZWUgYW4g
b3B0aW9uIG90aGVyIHRoYW4gZm9yIEtWTSB0bw0KPiBhZHZlcnRpc2UgYW5kIGVtdWxhdGUgd2hh
dCBpdCBjYW4gYXQgYWxsIHRpbWVzLCBhbmQgaXQgYmVjb21lcyB0aGUgZ3Vlc3Qncw0KPiByZXNw
b25zaWJpbGl0eSB0byBub3Qgc2NyZXcgdXAuwqAgSSBndWVzcyBpdCdzIG5vdCByZWFsbHkgYW55
IGRpZmZlcmVudCBmcm9tDQo+IG5vdCB0cnlpbmcgdG8gdXNlIE1NSU8gYWNjZXNzZXMgYWZ0ZXIg
c3dpdGNoaW5nIHRvIHgyQVBJQyBtb2RlLg0KDQpMaWtlIHlvdXIgZGlmZj8gRXhwb3NlIGFueSBN
U1JzIHRoYXQgbWlnaHQgYmUgZW11bGF0ZWQgaW4gdGhlIFREWCBwYXJhZGlnbS4gQnV0DQpkb24n
dCBleHBvc2UgYWxsIE1TUnMgdGhhdCBLVk0gc3VwcG9ydHMuDQo=
