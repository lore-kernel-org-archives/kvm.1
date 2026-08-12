Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC0486BA7
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786575338; cv=fail; b=gYpkcdMM5+5NbIaDkTprnIShCo0FofTyfxVT694td+xJMZ16Kh5JTeTc/7n1URo5sot2D+9gxC++5/fBRPIYfd3pQFqNIb/uDymKFVRfqsGER94eAelf0l76mY7SYV5ibZzA2s9MllE7BR6OYkjYtzHAUry5Ze0Lr2wKPv1LKKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786575338; c=relaxed/simple;
	bh=+3xGE8q8Rq4//1yc03gUtmZ2ySPRLaq2tTVwI7P7EX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OOhdR34UesOd0/OQW3juEGcspXFLuvo3Nc/dL8rIBx3g8FbKJV1VumQF6B67b2XOjdYIVVyNNke4tnJ379o0oE5x/1qB4LR/tBU7Q8NIBVjyq2/RMjvum2J2YgQ7Lg8gFtNtZ2PMpSrF0bZHdqikDUGB2zskYMPCI+UhfuccClw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpHKTl9M; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpHKTl9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786575337; x=1818111337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+3xGE8q8Rq4//1yc03gUtmZ2ySPRLaq2tTVwI7P7EX4=;
  b=QpHKTl9MnSUVAVe28A2D3PGuH1P1lPj06DSV+IPFRiGUKyWO1I9M84nX
   2stJ0tng4ruBBu9LGQHRdwxt0zY0I2N7pAT5wcP6/Kvjmtm0azNTVfqoZ
   NsQY8a23qNvyiTRGPdo5kFgAWVqC589BXYQbQkWNA+rJybQGKmYhgFUi8
   uKBsDcrq2fIL1oftiBh18jQWUHL2vzyRJCDDBmCDpFz4Lo7HXiOE50f2Q
   iBVVcWqjptr51h7TRUWrIjkKyy3eWLFDYoZ6Kp1U7vnsvCFGllnaNSrx+
   Xc2r7jdzuEwLLJuBYaoRmoDjXpDUiu8pBjN9D4ctXFZLxoOkVQk8arCY3
   w==;
X-CSE-ConnectionGUID: Pfghmqb3S16zbHV83nuwZw==
X-CSE-MsgGUID: baPxG0xtT+WbrifCGhVmKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="104678603"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="104678603"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:55:36 -0700
X-CSE-ConnectionGUID: 7nk0K8ZoT6S4jrsaRyTrhQ==
X-CSE-MsgGUID: urEzlLjzQ5aBvb6/OUNJXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="268032995"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:55:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:55:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 15:55:36 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:55:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZl5EbufXoM5D5Bo0azu6Oj9vIkgRa/eeBlTWFZhbnDhhkKrU8KYWKA06JZktJMcA3+g/zC5qXPYPfGzgioRt0zaRExbzPttLpnBbWPHue7lkuQW+84LjnNTF0f+GgOGgV+qxqXCOCxO4BHfNC6nX6geTus3pPQQrwwmc7QxPJH9pUzgTMgCzLO+7gQpNS4F7BjTqIXed/9G5C5eeMQMn687zBCWitubj9NC/FLTz9bSLI1AiE94Sp0tjo7BWLeotKkxW2P5xU57m3nyQk6D7UckSsqq4OWWhuSg41hqorlIU4SII0j1wO1VnbF116jD8UkaySjfIjoH9Q7bQOew0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3xGE8q8Rq4//1yc03gUtmZ2ySPRLaq2tTVwI7P7EX4=;
 b=apgLWTN2fAkcLxbJBf5fD693gD4KTwIBg1wBe4TnAgKqoR2Tt/TfbHYQWFI+fbVqViw9D3/WDBGi5LGCXJyo9KCyxSxdeNZwP2HJCQKeyHLfaiFfyK7yYdvVuzPF+548MeVgEKmlMV2fh3J8hynomeGb6J9y5AwjQIE5lVQhD5f7xsveDK2V7REdpYx5Jlx1NX15IGehvW019Vi0fRK5X9uinyUNbSGip3rtTbhTnWUUYmxWlDJDH7S70OlglB2GXr+fGyS8Pk2tWtiTF/3Z3zI/48D42pI4s4DGbbSefafvOMN6xHKg5X+1fnfZLFj3ganxBOwYraJMlpxjkOkBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW4PR11MB6933.namprd11.prod.outlook.com (2603:10b6:303:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 22:55:32 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 22:55:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0
 in tdx_to_vmx_exit_reason()
Thread-Topic: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as
 all-0 in tdx_to_vmx_exit_reason()
Thread-Index: AQHdKjGuvp/PJLcw/0+CLkQCRzSh9Q==
Date: Wed, 12 Aug 2026 22:55:32 +0000
Message-ID: <138969948dac13369ddebd72bf523dda4dda6b85.camel@intel.com>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
	 <20260812080229.2481439-4-xiaoyao.li@intel.com>
	 <20260812082306.11E8B1F000E9@smtp.kernel.org>
	 <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com>
In-Reply-To: <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW4PR11MB6933:EE_
x-ms-office365-filtering-correlation-id: 92018b6c-9f5f-4bed-2596-08def8c4d04f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 2tttQlm9eL+rQOvTIIUIUi3M8XSEd5iYSozGYhPP+kPFnOYzr0CbJkyvC1uCf95KGm20iR3UKdYIljU2+m87ZdWw+Gfn44b/5JkTLPw6YkbUXNm64MEJepYicCgO0LdXjd5A8Bytt9mwVvBdXiDm4QitEwVDWxbW2fC5uss1aN7vcpdNsnjwiCyuJhOuyUrXMuvLYkw4E+vs0JpZj1EsJgkzhl5gjMIIpdCgnOfcpskK+nRnuTCyD88kfssxxtJDAceEdUw6nehLDiPytcmlrZiPhJUS6sl58fH380pQv9p7V6LLMJx6GeHgebJcvN1GEqwPKQ/nPNQv6Q9mMDyLo9oPXZO3B9K6CAvJ5MXaEhdcgNHOkmeQlsHlA5nNDSt/ykWisZpmUXjyH9ACFuhLx0qkh318+nC8F4XlF0NcylHtN1zbo3QxnzFqq7IICpphkKX1EoB7+9gB86ZMWuVXTC65WbY6nAKKlfMpG1kWpx8UCYzjOGXQ1Us/Xv8xvbGkXFNnwswKWiRUvG+rmaz8aEMqD2M07UwT/wqByz56Xk5UCYRC3FUm1QzVQS+gafQbETJmQ6K3jOHqPXI/DMTS3/ftoGMT/27QYTpzEresEwiRbMeiarN6fh132N/Rtk+JCPwiHTNRl21Po/YdGQEQHGcFgWhRXTn3u3GDy/p0scgSP91g67Yv+tWc1KOsY2oJ5M0BnTg1OH7QvP3snJtis3WN54CnY76Wun5Ozv1eV6M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlhUdTIrWWx3cVV2NVlaWEtCci9XNU9pV0twZGdvK3RQbWhRTDdwRFA0Ritu?=
 =?utf-8?B?UlpBaFZNVGZVT3F2WFlXYkFqZ25CK3c3Q1lrVDdsQk9hbXNkN0RUV0czaWhV?=
 =?utf-8?B?bUMySGFCZkwybjErMk42Y09QbDZCWmdORmJVQ0k5bzAyekJVWEN5WUtHRlkz?=
 =?utf-8?B?L3Y4TmFONk9xdW5Xa0RLWTVFQ1I4VHBjcXlSOGRJQUNtZEI2M3AzNW9mK2Nm?=
 =?utf-8?B?NnoxcDZYRVpudEsvYmxST1BldnZmWUp3VFY4OGdlam5QZXRNa3BtVHZZRWZy?=
 =?utf-8?B?dFR6MG13ZVV0RTlsWTVpcEt3QjB0SWpHbVIzMXNyVUNVRm85QW9mcnlzUWtO?=
 =?utf-8?B?SUFjaXVmYlNNOTNoVDBjeDl3cXc3ZmltWHNoTkt0b092VFJDSFJrNW1TQ3lO?=
 =?utf-8?B?NUxBMmw3WVdyRzRIemt2SG9aWWN2cWlBZll6ckdIdlFXVnVkaUovS3F1SUZt?=
 =?utf-8?B?d29td1VXaVpWK2t4aFlGd1VadS9ZbDRjWDJFb3g3YkJSRGhVYWxLTDBVQjQ2?=
 =?utf-8?B?SGNoMVZyMEs3enU1UVF0SWdIMXpJWlNXem05U20yV0xHVDhrWkV5ZktpWS9t?=
 =?utf-8?B?YmNLVVAwZTFaMUNCU05iMVpIdUN6ZldUOXBBbGxVNU5aamhpZkVZN216SmFw?=
 =?utf-8?B?bU1XUGFRUU9uYWRlcWNLTklGSk9HWVNXTE9SNklsQWpmRStIa3cyUGtnclhv?=
 =?utf-8?B?WC84MnRnQWpTZzBWbURNSXVNbTN0UVBMMWdNZTNMUWl2bmVyYTJZZFdvUW9L?=
 =?utf-8?B?UG1PcG5CbGt1OG81QWFqckNCZ3hyZmpCck5tZnN3Zkc4WTd4emlVelI4RStU?=
 =?utf-8?B?b283N0ZOS2JOTHRuQ3hSVmRlTmM5UUJCenZDNWdkVC9QenU3clp1Zmdabmlo?=
 =?utf-8?B?WkZrZ3dFbWhPL2duOVVvN2ZWQ0I5MCsrb3MrQzIzelJtcVFPZm1nR0pMZVRy?=
 =?utf-8?B?a1U1UzF3d2NYWVlIWC9FbWFWcW1JZnJVd1J6Q0xBTXlxSStzZGRoRU9HRzlE?=
 =?utf-8?B?aUdrcE8zdy9tb2EzSEEwQndGbXFvZ2NkODlkY0Rrd1M0b1pOOWM5MlQ2M2kr?=
 =?utf-8?B?SVRNWGh4NEZYeitPdi8ydmlwd3czSm9laEhHbXRXTytJcG9PbG5Kakc0SnhO?=
 =?utf-8?B?MzVWYVdXYXkvRWVjL3RZT2JFa0RBSFJ4R2J3dTkxVGplWG8wRzg1YmJwZ3dK?=
 =?utf-8?B?emUzSzJDZzg1bzlkWVArRkl2YzYvK0drTXJ6d3dsVWFLSUl6UGJsTS95T1J2?=
 =?utf-8?B?R3RQa2tpQWVHRFNGOE1rYUFZemxzSkpjQnNtSy9mWHJlMFBvRll1d1lDNTlV?=
 =?utf-8?B?NXNRWWphL2o0QWNTMEZTN3NDY0NKY1R0TmhuK1QrUnI3UG1xSnVBRS9rMjBY?=
 =?utf-8?B?Qy9CT1ZnYzBVY2VrRTl6OGJzS2l5ZFN0dlVoTlJwU2Z0dFc5UndEbVpQK2hn?=
 =?utf-8?B?SEVTRkFGNlVqV2xJWmpVUjFlNzR5b056dHdyRjRPMlZBaUtGWGh0a3V0MmtX?=
 =?utf-8?B?Z2hvaGwySFYyTGh1ZDF4WVBLL29jaktPQk5mcVVYNUc5NTBpR05PaUhORjF1?=
 =?utf-8?B?ZGZpQ2hMMlhPMjkzcGJqRDMwa3JwMk5VTks4MThtYThUcS9kSGdySFBJdHp5?=
 =?utf-8?B?RmJGK21tQ3FQbCtwOWc1RGc2WTI2RCttYllNWWxMRFdFQzAvbTRscklsWk1s?=
 =?utf-8?B?VUFqTGt5NW5QRDZrZmNnMHlWMVJqY1ZGak5LRndSRDdPV21wNG5iSzZqVVZo?=
 =?utf-8?B?cUZpbjZGUkFBYjQveCsxUW1oODJBN0lMQ1djUHprSGtVOVVqUi80dWNIVUlu?=
 =?utf-8?B?bHp2aTBwcXIxOWJMakc5bjcvVXMrTmhiZmVCMHhoNExFSGFIak5qaHpjeXBa?=
 =?utf-8?B?ZUoyTEc2NUtRZDJhTjVtcmRYUkpqQ3lKV3dFdjdwa0RhRzhMRWVUTXpzelk0?=
 =?utf-8?B?VU5NZ21tR0tkRStLM2QvMkZmaUVLckRPODBydThHOE1wakRGWDl0UVdhOFg2?=
 =?utf-8?B?bVpHdWJObm50a0lGNVFORlllS1NQbVRmUzFKSEpHbjhXekxvRW55NEc4ZWZr?=
 =?utf-8?B?UUNTYXRoL01FTG1uNjdNRHAwa1pVdTFKWHpXeXlwL3o1VmdvcGs2L1FCNUpC?=
 =?utf-8?B?ZzFNOHljZWZMZG1KSUJtWGh0cTVXWXloaW1TcU9tSWJHd2s0YTBxcWVFMnRw?=
 =?utf-8?B?QWxScTc5NFE0V2dCL1pNbU9kdGxIb3BmSDIxSFM3ZnRCTFl2czJUZ2M2OGxu?=
 =?utf-8?B?K0MyQjNTbzgwUis0WTFkSm1Fczk5Znc2cmNzMzZKZGdOVE44SGYxQkhnTWV1?=
 =?utf-8?B?cjFwc1BzNTJFMnQzM21PWmJmNkFYSnFIN01nczZIclpISnVBcFJCQ2FqOFEz?=
 =?utf-8?Q?sK2808Awrm+tQIw8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2D45E22402D6F4EAEA53168342938AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VsGLUB8T1aRHB6DF7mAK2hHwRtr+MnKzBYjlrfWzZwbZV9A33L9rKYDeS5D999DWZB1R96DM96tZn5Z5Cdwc4iidCmsRQ9AAfWPCdiSNIqyLx+pVz7PcfkzWyVJ7Agf53rXup2SbcORbdrNRFIysZA5JmTHs3a6iXdQ1bTFxhZERuM1CYzesgL3Y3E/5WvH2YHCYQrCs7NVaboTYKPYKJyPeOUlP9aXGceMs7XrnjaolZEFP1tHbhe8rqAwZIbQbEbzkWHmex6N6iObKY1IfHUugNBONYCUxpOpIrCPHnhey4zSwVDheJDQxeFqJFsli+wfUfqv42ZqNNl6/rHy8oQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92018b6c-9f5f-4bed-2596-08def8c4d04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 22:55:32.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSxE2g3KBN7+s/S7Q+G5Kd1WPWx1XHo1r4YOhJv8w79cY6DgV0Xf9PvCTqRmWxIx8z+a1l077q9c2mb4bhbg6zdra3lt568NnWIT9BXP1sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6933
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE3OjA3ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
IEluIHRkeF9nZXRfZXhpdF9pbmZvKCksIGl0IGV2YWx1YXRlcyBhZ2FpbnN0IHRoZSBmdWxsIDMy
LWJpdCBleGl0IHJlYXNvbjoNCj4gPiANCj4gPiDCoMKgwqDCoMKgICpyZWFzb24gPSB0ZHgtPnZ0
LmV4aXRfcmVhc29uLmZ1bGw7DQo+ID4gwqDCoMKgwqDCoCBpZiAoKnJlYXNvbiAhPSBURFhfSU5W
QUxJRF9FWElUX1JFQVNPTikgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCAqaW5mbzEgPSB2bXhf
Z2V0X2V4aXRfcXVhbCh2Y3B1KTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uDQo+ID4gDQo+
ID4gU2luY2UgVERYX0lOVkFMSURfRVhJVF9SRUFTT04gaXMgdGhlIDE2LWJpdCAweEZGRkYsIHRo
aXMgY2hlY2sgd2lsbCBwYXNzIGlmDQo+ID4gYW55IHVwcGVyIGJpdHMgYXJlIHNldCwgZXZlbiBp
ZiB0aGUgYmFzaWMgcmVhc29uIHdhcyBtYXJrZWQgaW52YWxpZCwNCj4gPiBpbmNvcnJlY3RseSBl
eHBvc2luZyBtZWFuaW5nbGVzcyBoYXJkd2FyZSBzdGF0ZS4NCj4gDQo+IE9oLCBJIHNob3VsZCBo
YXZlIGNhbGxlZCBpdCBvdXQgaXQncyBpbnRlbnRpb25hbCB0byBjaGVjayB0aGUgZnVsbCAzMiAN
Cj4gYml0cyBFeGl0IFJlYXNvbiBpbnN0ZWFkIG9mIGNoZWNraW5nIHRoZSBsb3dlciAxNiBiaXRz
IC5iYXNpYyBmaWVsZCBhcyANCj4gd2hhdCBpdCBkaWQgaW4gdGhlIHYyLg0KPiANCj4gVGhlIHB1
cnBvc2UgaGVyZSBpcyB0byByZXR1cm4gemVybyB2YWx1ZSBmb3IgaW5mbzEvaW5mbzIvaW50cl9p
bmZvIHdoZW4gDQo+IHRoZXJlIGlzIG5vIHJlYWwgRXhpdCBSZWFzb24sIGkuZS4sIG5vIHJlYWwg
Vk0tRW50ZXIgaGFzIGhhcHBlbmVkLiAiRnVsbCANCj4gMzIgYml0cyBFeGl0IFJlYXNvbiBlcXVh
bHMgVERYX0lOVkFMSURfRVhJVF9SRUFTT04iIGluZGljYXRlcyB0aGUgY2FzZSANCj4gb2Ygbm8g
cmVhbCBFeGl0IFJlYXNvbi4NCj4gDQo+IFRoZXJlIGlzIG9uZSBleGNlcHRpb24gdGhvdWdoOiB3
aGVuIHJlYWwgRVBUX01JU0NPTkZJRyBoYXBwZW5zIHdpdGhvdXQgDQo+IGJ1c19sb2NrX2RldGVj
dGVkIGJlaW5nIDEuIEluIHRoaXMgY2FzZSwgaXQncyBhIGZhbHNlIHBvc2l0aXZlIGFuZCBLVk0g
DQo+IHNob3VsZCBnbyB0byB0aGUgZWxzZSBwYXRoIHRvIHJlYWQgdGhlIGluZm8xL2luZm8yL2lu
dHJfaW5mby4gQXMgbm90ZWQgDQo+IGluIHBhdGNoIDIgdW5kZXIgIi0tLSIsIHRoaXMgaXMgYW4g
cHJlLWV4aXN0aW5nIGlzc3VlIGFuZCBpdCB3aWxsIGJlIA0KPiBhZGRyZXNzIGluIGEgZnV0dXJl
IHNlcmllcy4NCj4gDQo+IEZvciB0aGUgY2FzZSB0aGF0IFNhc2hpa28gY2FyZXMsIHRoZSBvbmx5
IHBvc3NpYmxlIG9uZSBpcyB0aGF0IHJlYWwgDQo+IEVQVF9NSVNDT05GSUcgaGFwcGVucyB3aGVu
IGJ1c19sb2NrX2RldGVjdGVkLiBJbiB0aGlzIGNhc2UsIHBhc3NpbmcgdGhlIA0KPiBjaGVjayBv
ZiAoKnJlYXNvbiAhPSBURFhfSU5WQUxJRF9FWElUX1JFQVNPTikgdG8gcmVhZCB0aGUgdmFsdWUg
b2YgDQo+IGluZm8xL2luZm8yL2ludHJfaW5mbyBoYXBwZW5zIHRvIGJlIHdoYXQgd2UgZXhwZWN0
LiAoSG93ZXZlciwgdGhlIGV4aXQgDQo+IHJlYXNvbiBpcyAweEZGRkYgaW5zdGVhZCBvZiBFUFRf
TUlTQ09ORklHKS4gQW55d2F5LCBpdCB3b24ndCBleHBvc2UgDQo+IG1lYW5pbmdsZXNzIGhhcmR3
YXJlIHN0YXRlLg0KPiANCj4gU28sIGNvbnNpZGVyaW5nIHRoYXQgdGhlIGZhbHNlLXBvc2l0aXZl
IG9uIEVQVF9NSVNDT05GSUcgY2Fubm90IGJlIGZ1bGx5IA0KPiBhZGRyZXNzZWQgd2l0aCBlaXRo
ZXIgY2hlY2tpbmcgdGhlIGZ1bGwgMzIgYml0cyBvciBjaGVja2luZyB0aGUgMTYgYml0cyANCj4g
YmFzaWMgZmllbGQsIGFuZCBjaGVja2luZyB0aGUgZnVsbCAzMiBiaXRzIGNhbiBlbnN1cmUgaWRl
bnRpZnlpbmcgdGhlIG5vIA0KPiByZWFsIEV4aXQgUmVhc29uIGNhc2VzLiBJIGp1c3QgbGVhdmUg
aXQgYXMtaXMgaW5zdGVhZCBvZiBjaGFuZ2luZyBpdCB0byANCj4gY2hlY2sgdGhlIGJhc2ljIGZp
ZWxkLg0KDQpPaCwgSSB3YXMgYWJvdXQgdG8gY29tbWVudCB0aGUgc2FtZSB0aGluZy4gSXMgbm90
IGV4cGVjdGVkLCBidXQgdGhlIGNvZGUganVzdA0Kc3RhbmRzIG91dCBhcyB3cm9uZyBsb29raW5n
IHRvby4gU3RpbGwsIHRoZSBwYXRjaCBpcyBhbiBvdmVyYWxsIGltcHJvdmVtZW50IGFuZA0KY2xl
YXJzIHRoZSB3YXkgZm9yIHRoZSBtb3JlIGltcG9ydGFudCBmaXguIFNvIEknbSBvayB3aXRoIGNh
bGxpbmcgaXQgZ29vZA0KZW5vdWdoLg0KDQpTaWRlIG5vdGUuIEkgcmVhbGx5IGRpc2xpa2UgaG93
IHRhbmdsZWQgdGhpcyBhcmVhIGlzIGZvciBzb21ldGhpbmcgdGhhdCBzZWVtcw0KbGlrZSBpdCBz
aG91bGQgYmUgbXVjaCBtb3JlIHN0cmFpZ2h0Zm9yd2FyZC4gRGVyaXZpbmcgcGFydGlhbGx5IEkg
dGhpbmsgZnJvbSB0aGUNCm92ZXJsb2FkaW5nIG9mIHRoZSBURFZNQ0FMTCBsZWFmcyB3aXRoIHRo
ZSBleGl0IHJlYXNvbnMuIFNvIHdlIGhhdmUgdGhpbmdzIGxpa2U6DQouLi4NCgljYXNlIEVYSVRf
UkVBU09OX0VQVF9WSU9MQVRJT046DQoJCXJldHVybiBFWElUX1JFQVNPTl9FUFRfTUlTQ09ORklH
Ow0KLi4uDQo=
