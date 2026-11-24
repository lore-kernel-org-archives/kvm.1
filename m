Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795554680;
	b=gAZ4xaTiyC+8tT6PieBFiXt4MenHJ/qTSljOGNxDAZd9TXeAlrDKm6qUHMo1/lwkXLjy
	 PdS6pa9jgy32BeLXDmfSH3iT45PV/M0RP/dE+N4d+GGAio75lCYpXUJ0HtsPTAab80rNP
	 tAoko8SjkkeWDD6cJr/g34eQUSI9ixXikj3ry+iCjH3fybyTIxMf9qOOe7ZaLol9s/fpa
	 dce6SsS/il1KTuflMrbBc5vtigMTVAfc1FdW0VAV/GBPi5R0OxgnCFE0X3TT0ssekLpDv
	 2d+E6hEDdIJTedXdRsWrXTg0S57/GFau8dXfgq7qASBzLvf8Fj630OEXcnWeXUSuyuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554680;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=1rcewsM2UzlqGH+QdwntIGJUYvniBAAGQc3FXzQJ+Xg=;
	b=c2QMdXOB59q6MJ8eRl+QG8qyK+kc2DT3MMnYdOaa4qbwt0jWrpXgDtGlwCkJ/P3dq6ny
	 9AVxVISmLjhuZQDbvA/xvwyKWo+rCTlxl4m6hTah9rHPyXQCs1vmQiuke7tN0rse+LDLy
	 vfkkWBU5LlKni7B5vYVOhLoObtbt3nxkUFi8jZn+lXLlfuv+b4Nzdpk0cd2E0GIqStU4s
	 iiCvkGAmHCX7u7qIB4cWSJJIDjduv0AtM34lV6Hfd7xq8QUCVXJixRqhd1CuhQyZPJ1gR
	 6J/XHKOC0MLq0x+nNjf+DLgsBySueL2LZj6twtsXGCj9QM3MRW8Jz/z40hS/2XvdRxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kmZ4p099;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=F4Tq4bUa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0709606A327;
	Tue, 24 Nov 2026 21:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0709606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kmZ4p099;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=F4Tq4bUa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795554680; x=1827090680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1rcewsM2UzlqGH+QdwntIGJUYvniBAAGQc3FXzQJ+Xg=;
  b=kmZ4p0998FPtF5GvX5Q5Xc5pYTmZPcGnVUJKs2SJkWzeU9DkybvylfH2
   hpyv9EiOHnaWUxW5E8LQL5tLVaVLyc4KHlck3z1dnFCjtD/ahtg1iemuz
   1HGYWQkoEh2zGz1t+Y7p+8dGGUkUZ8Ukvb61TUjvO1blRfkFdp0wjMken
   N+tKBDycCAJv1FNzgE+fSP7l/Y0yq3x5vgrFOTh3h8ysZ1r3H0dYZ4q5f
   SXYkIE7NNI9jg4qTZ6dFnf/Q957H6jlrEb6wNib2uptDm0WP3Vx2YMW9C
   rnO6H2w39qhR7ICnx69/SR42gVLKkJbzAzk+0EuKwujxCw4LnM+M1TFa/
   g==;
X-CSE-ConnectionGUID: DOfhA9oTSKCRhT9DR3P5kA==
X-CSE-MsgGUID: pcHxk7qYTDyGDl5oIWLYzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4471489"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4471489"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:11:20 -0800
X-CSE-ConnectionGUID: BVgBHqrzTr6Nli3g72HEog==
X-CSE-MsgGUID: +FiF4ssaSaSncSSzBVjZFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11873835"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:11:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 13:11:18 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 13:11:18 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 13:11:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLn0ezj11jeRLALjSukPtRyo+51sFR9Ja3xmKoR3JRfai5rA1Q1X45W0VZMWAWTYN5BJhmtziOsicQbEFH7cqdmM4vTY7Zy/mQIhIdcWP2m/LmV6UA7ckSaH4VselFI6jW61i5qrLgAkN2T2aL1RIboPFfVTTqRYejXRzzQF9jJ0V77tw70HIW1uhdP37+G1L/iGoadvYLyI7QF6PZBuPcEz4DadMHaItbUNR8ZugzyjJt7kv98g+TUtONSqv0zDfjNH0QW8w5ZNE0Vo1gvg7Iw33cj+wcT6Cnm89tz1eG9js84w8gevCPoxZIppSCTxSa7nuczzae84N0mWvsJzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rcewsM2UzlqGH+QdwntIGJUYvniBAAGQc3FXzQJ+Xg=;
 b=FhRFD/fWV6P2sL4erePFpsZu+uZPtFAHSHAx054wb1+YYi38UH+syKfX7NBum5LpxAGkqNQeus9tGv4pctxR7+BWE2YkOjn4G4LrNNBJxDdobbc+3epkcSyYaYfkPHcY276CUBa9t4aQ8AUeZDgUOOz7LHt+AjIXIXiEeNQc02Oi1FgkdKV7xsaszdSamqWvlQP86WTL1wayWLsrlvf1O7y5+KQBkhTDQn9zkO7ScEj9cFIbmmp7rosB/jrpqSgW5/s3K3qyE6h21zatw2DESgKMpwwRmnEoeYfEeqS7/6wEeujY9Z7ePXeRIAqVDdJwaGd1yIHkgSmVj3USgodSCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rcewsM2UzlqGH+QdwntIGJUYvniBAAGQc3FXzQJ+Xg=;
 b=F4Tq4bUaDVcI87HSfPD9W/0/wVeu1iv1u4pTuCsGzYzJxTqbBOu/2ZD+ucrJHDQc7Q1zUbXoF4/Ym0iqv80+z8mW8/6i7h+cgm6YE9yGtI68DIZoxpz14r7l2pvOtiTCr08Kd+/nLaPdEg7NKc+8fWyppvcVfPfgiZwLCSAYaHs=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by SA1PR11MB529852.namprd11.prod.outlook.com
 (2603:10b6:806:51a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 21:11:10 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 21:11:10 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Tian, Kevin" <kevin.tian@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kas@kernel.org" <kas@kernel.org>
Subject: Re: [RFC PATCH 2/7] coco/tdx-host: Establish an SPDM session with the
 device
Thread-Topic: [RFC PATCH 2/7] coco/tdx-host: Establish an SPDM session with
 the device
Thread-Index: AQHddbsMp5EiD4IiPE+yzoiB4hQRbrc8V7wAgADkLACAAIlIgA==
Date: Tue, 24 Nov 2026 21:11:10 +0000
Message-ID: <30852ad50fb3085de04145342aaf1caf145488fe.camel@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
	 <20261116111037.3478844-3-chao.gao@intel.com>
	 <ac7befe5081a489172d87402e55355852a9e62ac.camel@intel.com>
	 <awWKRJQ3_rIgxJVC@intel.com>
In-Reply-To: <awWKRJQ3_rIgxJVC@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|SA1PR11MB529852:EE_
x-ms-office365-filtering-correlation-id: 8e537530-084c-46ae-8048-08df4a6f76dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|261026121527099003|10067099003|4143699003|261022105027099003|11063799006|5023799004|56012099006|261026140227099003|261021123027099003|261021121427099003|261022115727099003|261022075727099003|261028144727099003|261102123227099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: dOnFK34SQlzt+fp5Bq9IsnY0m7kskhwnk/DWfvdC1nMRhwodor91C0A5HcsNnnpsepwstZY2gYfj8rlv1FRY1VpFA6rVp6iXUUgWN/t6XEGXe3OWlEGtJS1m3XZkuZKqZF8Dfu59aoZk3E+7k4/g8WrgLgxwoqoaQ2jbMBhW45GpqKVnuZ2AMK8zLOrPnh1Td3ub01ALBjh+EIzrflVCtqMLN1/r0PQPhrzcRvNLXwH2mu1zfo7pPjn5Flg0Nbjzt4uBwgR4b9dUXxRyX40AhHsuXVgji/fAnufTQXHcoUU9SjNU4gDX9D6S5CLPs1Oc8IZgDNqJOUa5maC3FrbcxISiRHQ1S7PwKl51qYL6iWi4SQvRTWCAEnOQGZM4iVZg4d6JzyzHggxfFL92TAAwPAPgHJExfy/JiWB9BBnWJDyEk763pHmtPtBe/YA9UTqq5XmPuW5jbz5326lZ2+RuxetDEwkFIkXcJWoHkfE/RVl0k+z47m83LUVpLDS0YdP1U7vtakXKdSaEwp4wfX6puLvd5AJrbpDhwqz/xzNc9krrCvOA9FAQlDU2J8kFPWJ8iHyc656ioR2TgibzlOtOtri1vINUz6VavLmKj9LMu9GhCrW5aAa7gXp2j+FqpV+CjU5TFLbkvEj9sGnO0E4iVo03qgJMRsm1k5Kca1CmvRUByn1p1zpTSOTy3iI5gnkc3YRr7hcsYfV32S1yeQlJyMLOW9243/OzRb5LRV9gdRo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(261026121527099003)(10067099003)(4143699003)(261022105027099003)(11063799006)(5023799004)(56012099006)(261026140227099003)(261021123027099003)(261021121427099003)(261022115727099003)(261022075727099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHhWazBlWnhIY01lMlZ3TjlGakVTWUNvdHpmRkZXWEw0UGdSbTNJR1lrT1Np?=
 =?utf-8?B?RENZUk43N3ZIeVNkUWV4SUJGUUR1MHZBMHo2dG5FS1JkTWhZekFxMThpVTZC?=
 =?utf-8?B?UXJRNHR3cmFEZ0ZYNzNEbEtweTJ5cWF1MGt4dzI3OU13Y2R2dVZpUjdQWkdu?=
 =?utf-8?B?UnJMbnlZdlo1RVdHWDVDTVhPeTF6U1lia1FZUURBNURXbUJzaXd3L2U3WjlX?=
 =?utf-8?B?VDJKc3lETGpqZGJEaFBJc3BtSkI0eWFnMFp1ZnVUWkkxZ0padDkzMWNFUHJL?=
 =?utf-8?B?c3pUU3NTWFFaOVptaUtVTTF1bGdpWkozM2p3WVhKWktFa095bnNJSE9sQ0Qr?=
 =?utf-8?B?ME1jNktncVV2U1NORWJIVHo0eDBIQmF6SGNiczNBaVdHS2w4alpteTZNOEpU?=
 =?utf-8?B?eFBCQ0l4VUt4SStCMFYyMDZqM201TEhPTmtBdmplWEJ0VG1LeWZueFNXM2pw?=
 =?utf-8?B?aFBDQkhCVnc3b0M2ZjlSQklMb3BwNmsrOElIdDZnK0xDNUw1TnRjK09iUHd6?=
 =?utf-8?B?bzFhL3NTbGs1VjkvVUhxWG5tTU13OXdPZnFYTy9QY1FCOVBiZ1EybXpXMlpP?=
 =?utf-8?B?WFRrRmtiVHROTDNqR3BGRFdRMVk3Y0ZIQ3NmS2djd1NPMXdlbDdhMUZQZ3BE?=
 =?utf-8?B?SldXVDdNK0h1TVFZSzZucWd0dDlCdWV1WWlGejhxZkZoTEZ4cVl2N2pEcUJt?=
 =?utf-8?B?WWQyUlV5a0xzVkRtRmg5T0p0bEJ0QzdsdUV4aHhjL1htREJFU1B6bEE2VG5Q?=
 =?utf-8?B?WjVzN3RzSVE1S0dIclZDSXNTY2NKU3dWdXJERWx3VUFTV3JHTnUvWlpPcXEx?=
 =?utf-8?B?QTU5dExINzloZjJTR0FJMnR5SGtpYXVVQklUN0RaV3NSSmNVbGtGbkNuNVJC?=
 =?utf-8?B?L3RkVGxJSWZnUHg4MUNlbkhNdGU0c1Y1VXowRzBVRjJ2cFZ0SFNvWTduclBF?=
 =?utf-8?B?anFIYWZrczdaSW5LbndWVE93MmxpcXF4Y2txVFpwQVhTYUM1Z3ArRWVydnJu?=
 =?utf-8?B?aDVJT2NsSnBKVFF2bTk0OUtwRXRDZXVpdGFVYkRYMTQ3VmtyVXQ1MjE0Njgw?=
 =?utf-8?B?WDRlRHRxbTlGN0lHQWpsQW1NdTdUWVY0Y2lUZzMyV0ZHeVlmdk5MRlRGR1lr?=
 =?utf-8?B?QnY2K1dWMTJwcWFLWGRSallTUXEwMzFHMGNoOEpVUkhlTzJ3SDFSdHk5bkg3?=
 =?utf-8?B?d1F2SE1IL3hrYTVwOHVYUDlEOXdnd3BGKzg3NHVFZHZsMko4cjVBQWdkYml3?=
 =?utf-8?B?NVd1NlpGZTEvbUdLY2xTYXNldHNvU0xZejNLQjA5STA2ZWxXZ0dnakNQaWRW?=
 =?utf-8?B?OXp3cXFvdUlWMWJ2NjJuYmllZnBhNkxiU0s0WjJLMGhvWERNVFd6V1NQZG5h?=
 =?utf-8?B?VTNYR1pJaThOUTRLVHAvQmpqZ2h6a2VqZUtQbVFta3ZTVFZGMlhkYU90elZ6?=
 =?utf-8?B?cm5SY1RwS25VL1hPc0p1THZYcjA2WDVNU2QwK1hrTWFTUFlwWnlUd1JYc1RX?=
 =?utf-8?B?TmRQc3lFYXJNaDFpUmhDNE16d0RtVElMbnNWNk9PUWdmcjljRzBVQjl1N0dU?=
 =?utf-8?B?eitPeVE0aVRQNU9iVGY3czE1OXFmbEd1SE9VMWpQVDVkNitHRytWRWs0dWky?=
 =?utf-8?B?YVUxekk0U1p1YkMzTEhhbHVmQzJKV1dxbzhDZmVDTiszY3lIeTUvTkJQZ05x?=
 =?utf-8?B?cHpIZ2JBR2I4RW0reGtDYlQ1d0N5MW9RY1NURGZmWEY1dlpucFRYbDIzUm9K?=
 =?utf-8?B?ZW9EL2w4WUdMd3U3Q3NaQ0dlREt3b3NJNGE5K09LQ085TkxUUU55RVZtREMv?=
 =?utf-8?B?WHduZmhPUnJUcGNhRElDZjU3Yk8wQlVNaHpDaXk5S0cwUVpYN0M1QXlXU052?=
 =?utf-8?B?N0FFejB5Q0FEZG41cjZaVlZIbEppbzR3SHpoc0NxazFaeURreCtvdlc2UzVk?=
 =?utf-8?B?RFZodEg3TFA2UVl3Z2xlaG5RNE1iSXJhcTZSeS8zdTFKZWdmSkpQeXhYZCtp?=
 =?utf-8?B?RWJ2VExHOU15SmZZdElMcjdPeWdISDFVSlMyS254cFdkK2JOWTFFMkc1RDBW?=
 =?utf-8?B?a0xtU0FYYzNQL3VCQy8zSUt1MFhNY2s5UWd0YjdlYnN6TWphdDF4MzVWZmV1?=
 =?utf-8?B?aVdBS0VSKzRqNG44Z2dnYWV0b0FuNTcwaEljL0RIdW9GSzdkSDExcFNZeDgw?=
 =?utf-8?B?Ynl2K1NSQUVYL08wc1liaHdaZDVQZysza0tWU2xrRFVvNDBJYTZ1MVFZcHRR?=
 =?utf-8?B?OXg2aVFOd0sydzVHUGJDTkJrc0pOQm80U3ZEY1p3ZzJPbFZOdUR2NGxYQkE3?=
 =?utf-8?B?MjFWSjkxTFczVTFVMS9hS3NMQVAyc1NkaTlRSXpWRGRXa2wvTnhLNEhXaDBR?=
 =?utf-8?Q?+ebAcZRzBuQBSmZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1887C744F3EA494590A68697047C5C45@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RVXLkXakz2BXSTdWKa+CKt131SdncUsCg+/bBMMS8DpI0Y1I12FigVsXPVZUZI9NQSxHgqS1XkSnBNrFMWRx9/GjKcOOzTqTVKgr9TExYsN0I+M5XQF7Bg2bzRFvXuhxlOhzSAB5q0YEuU6k04euxB65tJiF5NE1u316G4QT2G5uPUOLJovvoPP7psGGSWNMY3Kye5QH/7IoRnI+hHe4HXnfpFQ8Bu9ZOtnK0zpoIegD5qboxhHgjgx2ng/y/8vpYqzgr7G277jOwCm69qz9cq97GVMEIN/NqRWo6oVeODfwYfP4bwM2YqOz0IuMK2IR34HVZNBfCj8As77uDutT0g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e537530-084c-46ae-8048-08df4a6f76dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 21:11:10.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0IkktAp/VLbal5b067bVZvyZ9AuGqodJDkBpWLP14AymDT2xnfE5p2JryM0vJrnRT1b4RjA2Xf6zMHcwYg2iYYflYkomQ4IX4Fq1LQA0MP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB529852
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTExLTI0IGF0IDIwOjU5ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT24g
VHVlLCBOb3YgMjQsIDIwMjYgYXQgMDc6MjM6MDlBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gTW9uLCAyMDI2LTExLTE2IGF0IDAzOjEwIC0wODAwLCBDaGFvIEdhbyB3
cm90ZToNCj4gPiA+IFNldHRpbmcgdXAgUENJZSBsaW5rIGVuY3J5cHRpb24gcmVxdWlyZXMgYSBz
ZWN1cmUgY2hhbm5lbCB0byB0aGUgZGV2aWNlDQo+ID4gPiB0byBleGNoYW5nZSBrZXlzLiBUaGlz
IGNoYW5uZWwgaXMgYW4gU1BETSBzZXNzaW9uIG92ZXIgdGhlIGRldmljZSdzIFBDSQ0KPiA+ID4g
RE9FIG1haWxib3guDQo+ID4gDQo+ID4gUHJvYmFibHkgU1BETSBhbmQgRE9FIG1haWxib3ggbmVl
ZCBzb21lIDEwLDAwMGZ0IHN1bW1hcnkuDQo+IA0KPiBEb2VzIHRoaXMgc291bmQgYmV0dGVyPw0K
PiANCj4gICBTUERNIGlzIGFuIGluZHVzdHJ5LXN0YW5kYXJkIHByb3RvY29sIGZvciBlc3RhYmxp
c2hpbmcgdHJ1c3QgYmV0d2Vlbg0KPiAgIGNvbXBvbmVudHMuIEZvciBURFggdHJ1c3RlZCBJL08s
IHRoZSBURFggbW9kdWxlIHVzZXMgaXQgdG8NCj4gICBhdXRoZW50aWNhdGUgdGhlIGRldmljZSwg
Y29sbGVjdCBpdHMgbWVhc3VyZW1lbnRzIGFuZCBleGNoYW5nZSBJREUNCj4gICBrZXlzIHdpdGgg
aXQuDQoNClllYS4NCg0KPiANCj4gICBET0UgaXMgYSBtYWlsYm94IGluIHRoZSBkZXZpY2UncyBj
b25maWd1cmF0aW9uIHNwYWNlLCB0aHJvdWdoIHdoaWNoDQo+ICAgc29mdHdhcmUgZXhjaGFuZ2Vz
IG1lc3NhZ2VzIHdpdGggdGhlIGRldmljZS4gRE9FIGlzIG9ubHkgYSB0cmFuc3BvcnQNCj4gICBh
bmQgY2FuIGNhcnJ5IGRpZmZlcmVudCBwcm90b2NvbHMuIFNQRE0gaXMgb25lIG9mIHRoZW0uDQoN
CkNhbiB3ZSBleHBsYWluIHRoYXQgaXQgaXMgYSBQQ0llIHRoaW5nIHRvbz8NCg0KPiANCj4gPiA+
IFdoZW5ldmVyIHRoZSBURFggbW9kdWxlIGhhcyBhIG1lc3NhZ2UgZm9yIHRoZSBkZXZpY2UsIHRo
ZSBTRUFNQ0FMTA0KPiA+ID4gcmV0dXJucyB3aXRoIGEgZGVkaWNhdGVkIHN0YXR1cyBjb2RlLiBU
aGUgaG9zdCBzZW5kcyB0aGUgbWVzc2FnZSB0byB0aGUNCj4gPiA+IGRldmljZSBhbmQgY2FsbHMg
dGhlIFNFQU1DQUxMIGFnYWluIHdpdGggdGhlIGRldmljZSdzIHJlc3BvbnNlLCB1bnRpbA0KPiA+
ID4gdGhlIFNFQU1DQUxMIGNvbXBsZXRlcy4NCj4gPiANCj4gPiBTRUFNQ0FMTCBjb21wbGV0ZXM/
IENvdWxkIG1lYW4gdGhlIGZ1bGwgZXh0ZW5zaW9uIG9wZXJhdGlvbiBvciBhIHNpbmdsZSBzZWFt
Y2FsbA0KPiA+IGV4ZWN1dGlvbi4NCj4gDQo+IEkgbWVhbnQgdGhlIHdob2xlIG9wZXJhdGlvbiwg
aS5lLiBzZXR0aW5nIHVwIG9yIHRlYXJpbmcgZG93biB0aGUgU1BETQ0KPiBzZXNzaW9uLiBXaWxs
IHJld29yZCB0byBtYWtlIHRoaXMgY2xlYXIuDQoNCkxldHMgbWFrZSBpdCBjbGVhciB0aGVuLg0K
DQo+IA0KPiA+ID4gQ2FsbCBib3RoIFNFQU1DQUxMcyBpbiBzdWNoIGEgbG9vcC4gVGhlIERPRSB0
cmFuc2ZlciBpdHNlbGYgaXMgYSBzdHViDQo+ID4gPiBmb3Igbm93Lg0KPiA+IA0KPiA+IEknZCBw
dXQgc29tZXRoaW5nIGhpZ2hlciB1cCBleHBsYWluaW5nIHRoaXMgaXMgbGF5aW5nIHRoZSBncm91
bmQgd29yaywgcmF0aGVyDQo+ID4gdGhhbiBhbm5vdW5jaW5nIHRoZSBnYXBzIGF0IHRoZSBlbmQu
DQo+IA0KPiBPSy4gV2lsbCBhZGQgb25lIHNlbnRlbmNlIHJpZ2h0IGFmdGVyIHRoZSBiYWNrZ3Jv
dW5kIHRvIHNheSB0aGF0IHRoaXMNCj4gcGF0Y2ggbGF5cyB0aGUgZ3JvdW5kd29yay4NCj4gDQo+
ID4gPiBQYXNzIHRoZSBtZXNzYWdlcyB0aHJvdWdoIHR3byBwYWdlcyBwZXIgZGV2aWNlLCBvbmUg
Zm9yIGVhY2ggZGlyZWN0aW9uLg0KPiA+ID4gT25lIHBhaXIgaXMgZW5vdWdoIGJlY2F1c2UgUENJ
L1RTTSBzZXJpYWxpemVzIG9wZXJhdGlvbnMgb24gYSBkZXZpY2UuDQo+ID4gDQo+ID4gVGhpcyBw
cm9iYWJseSBuZWVkcyBtb3JlIGV4cGxhbmF0aW9uLg0KPiANCj4gU2V2ZXJhbCBmdW5jdGlvbnMg
b2YgYSBkZXZpY2UgbWF5IHdhbnQgdG8gdGFsayB0byB0aGUgVERYIG1vZHVsZSBhdA0KPiB0aGUg
c2FtZSB0aW1lLCBhbmQgZWFjaCBvZiB0aGVtIG1heSBuZWVkIFNQRE0gbWVzc2FnZSBleGNoYW5n
ZXMuIEJ1dA0KPiBQQ0kvVFNNIHNlcmlhbGl6ZXMgYWxsIG9wZXJhdGlvbnMgb24gYSBkZXZpY2Us
IHNvIHRoZSBwYWdlcyBhcmUNCj4gYWxsb2NhdGVkIG9uY2UgcGVyIGRldmljZSBhbmQgbm90IG9u
Y2UgcGVyIGZ1bmN0aW9uLg0KDQpJIG1lYW4gdGhlcmUgaXMgYSBidWZmZXIgZm9yIHJlcXVlc3Qg
YW5kIGEgc2VwYXJhdGUgYnVmZmVyIGZvciB0aGUgcmVzcG9uc2UuDQpPbmNlIHRoZSByZXF1ZXN0
IGlzIHNlbnQsIHdoeSBjYW4ndCB0aGUgc2FtZSBidWZmZXIgYmUgdXNlZCB0byByZWFkIGJhY2sg
dGhlDQpyZXNwb25zZT8gVGhpcyBtYXkgYmUgYSBsYWNrIG9mIHVuZGVyc3RhbmRpbmcgYnkgbWUg
b2YgRE9FLg0KDQo+IA0KPiBAWWlsdW4sIGxldCBtZSBrbm93IGlmIHRoaXMgdW5kZXJzdGFuZGlu
ZyBpcyB3cm9uZy4NCj4gDQo+ID4gPiArI2RlZmluZSBTUERNX0NBUF9IQkVBVAkJQklUKDEzKQ0K
PiA+ID4gKyNkZWZpbmUgU1BETV9DQVBfS0VZX1VQRAlCSVQoMTQpDQo+ID4gPiArDQo+ID4gPiAr
c3RydWN0IHNwZG1fY29uZmlnX2luZm9fdCB7DQo+ID4gPiArCXUzMiB2bW1fc3BkbV9jYXA7DQo+
ID4gPiArCXU4IHNwZG1fc2Vzc2lvbl9wb2xpY3k7DQo+ID4gPiArCXU4IGNlcnRpZmljYXRlX3Ns
b3RfbWFzazsNCj4gPiA+ICsJdTggcmF3X2JpdHN0cmVhbV9yZXF1ZXN0ZWQ7DQo+ID4gPiArCXU4
IHJlc2VydmVkWzQwODldOw0KPiA+ID4gK30gX19wYWNrZWQ7DQo+ID4gDQo+ID4gVGhpcyBsb29r
cyBsaWtlIG1vcmUgU1BETSBzcGVjaWZpYyBzdHVmZiBpbiBURFguIERvIHJlYWxseSBrbm93IG90
aGVyIHZlbmRvcnMNCj4gPiBuZWVkIGl0PyBXZSBzaG91bGQgYXQgbGVhc3QgZ3JvdXAgaXQgaW4g
YSBoZWFkZXIgc3VjaCB0aGF0IGl0IGlzIGNsZWFyIHdoaWNoDQo+ID4gdGhpbmdzIGFyZSBTUERN
IHNwZWMgYW5kIHdoaWNoIGFyZSBURFguDQo+IA0KPiBUaGlzIHN0cnVjdHVyZSBpcyBub3QgZnJv
bSB0aGUgU1BETSBzcGVjLiBJdCBpcyBhbiBBQkkgc3RydWN0dXJlDQo+IGRlZmluZWQgYnkgdGhl
IFREWCBtb2R1bGUsIGFuZCBpdCBpcyBwYXNzZWQgdG8gVERILlNQRE0uQ09OTkVDVC4NCg0KQWgg
b2ssIGxldCdzIG5hbWUgaXQgdGR4IHNvbWV0aGluZyB0aGVuLg0KDQo+IA0KPiBCdXQgeWVzLCB0
aGVyZSBpcyBzb21lIFNQRE0tc3BlY2lmaWMgc3R1ZmYgaW4gdGhpcyBzZXJpZXMuIEkgd2lsbCB0
cnkNCj4gdG8gc2VwYXJhdGUgaXQgZnJvbSB0aGUgVERYIHN0dWZmLg0KPiANCj4gPiA+ICsJc3Ry
dWN0IHBhZ2UgKmluX21zZzsNCj4gPiA+ICsJc3RydWN0IHBhZ2UgKm91dF9tc2c7DQo+ID4gDQo+
ID4gU05QIGFuZCBURFggYm90aCBoYXZlIHRoZSBET0UgbWFpbGJveCBzaHVmZmxpbmcgZG9uZSBi
eSB0aGUgaG9zdCwgcmlnaHQ/IFNvIHdoeQ0KPiA+IGRvZXNuJ3QgVFNNIGFsbG9jYXRlIGFuZCBw
cm92aWRlIHRoZXNlIGJ1ZmZlcnM/DQo+ID4gDQo+ID4gT2ggbG9va2luZyBhdCB0aGUgY29kZSBJ
J20gbm93IHZlcnkgY29uZnVzZWQuIFRoZSByZXF1ZXN0IGZvciBTTlAgaXMgaW4gcHJpdmF0ZQ0K
PiA+IG1lbW9yeT8gVGhlIFNOUCBjb21taXQgaGFzIHZlcnkgbGl0dGxlIGluZm8gdG8gZXhwbGFp
biB3aGF0IGlzIGdvaW5nIG9uIHRoZXJlLg0KPiANCj4gVERYIGFuZCBTTlAgaGF2ZSBkaWZmZXJl
bnQgcmVxdWlyZW1lbnRzIGZvciB0aGUgYnVmZmVycy4gVERYIG5lZWRzIG5vDQo+IHNwZWNpYWwg
aGFuZGxpbmcsIGFuZCBib3RoIHBhZ2VzIGFyZSBub3JtYWwgaG9zdCBtZW1vcnkuIEFzIGZhciBh
cyBJDQo+IGNhbiB0ZWxsIGZyb20gdGhlIGNvZGUsIFNOUCBtYWtlcyBpdHMgcmVxdWVzdCBidWZm
ZXIgYSBmaXJtd2FyZS1vd25lZA0KPiBwYWdlLiBTbyBpdCBpcyBub3QgZ3Vlc3QgcHJpdmF0ZSBt
ZW1vcnksIGJ1dCBpdCBpcyBub3QgYSBub3JtYWwgaG9zdA0KPiBwYWdlIGVpdGhlci4gSSBndWVz
cyB0aGF0IGlzIHBhcnQgb2YgdGhlIHJlYXNvbiB3aHkgZWFjaCBUU00gZHJpdmVyDQo+IGFsbG9j
YXRlcyBpdHMgb3duIGJ1ZmZlcnMuDQoNClllYSB0aGF0IGlzIGhvdyBpdCBsb29rZWQgdG8gbWUg
dG9vLg0KDQo+IA0KPiA+ID4gKwlzcGRtX2NvbmYtPmNlcnRpZmljYXRlX3Nsb3RfbWFzayA9IDB4
ZmY7DQo+ID4gDQo+ID4gQ2FuIHdlIG5vdCBoYXZlIHRoZSBtYWdpYyBudW1iZXI/IEkgZ3Vlc3Mg
aXQgbWVhbnMgYW55Pw0KPiANCj4gU3VyZSwgd2lsbCByZW1vdmUgdGhlIG1hZ2ljIG51bWJlci4g
MHhmZiBtZWFucyBnZXR0aW5nIHRoZQ0KPiBjZXJ0aWZpY2F0ZXMgaW4gYWxsIHNsb3RzICgwLTcp
IG9mIHRoZSBkZXZpY2UuDQo+IA0KPiBBcyBhIGhlYWRzLXVwLCB0aGlzIGNvZGUgd2lsbCBnbyBh
d2F5IGFueXdheSB3aGVuIHdlIHN3aXRjaCB0byB0aGUgbmV3DQo+IENUTFYgYXR0ZXN0YXRpb24g
ZnJhbWV3b3JrLg0KPiANCj4gPiA+ICsJZG8gew0KPiA+ID4gKwkJbXV0ZXhfbG9jaygmdGR4X3Nw
ZG1fbG9jayk7DQo+ID4gDQo+ID4gVGhlIGZhY3QgdGhhdCBUU00gcHJvdGVjdHMgdXMgZnJvbSB0
aGUgYnVmZmVycyBnZXR0aW5nIGNsb2JiZXJlZCBieSBhbm90aGVyDQo+ID4gcmVxdWVzdCwgYnV0
IHdlIHN0aWxsIG5lZWQgdGhlIG11dGV4IG9ubHkgYXJvdW5kIHRoZSBjYWxsIGlzIGEgYml0IGhp
ZGRlbi4gSSdkDQo+ID4gdGhpbmsgaXQgYXQgbGVhc3QgbmVlZHMgYSBjb21tZW50LiBCdXQgc2lu
Y2UgdGhlIHRkeF9zcGRtX2xvY2sgaXMgcmVhbGx5IGEgVERYDQo+ID4gbW9kdWxlIHNwZWNpZmlj
IGxpbWl0YXRpb24sIHdoeSBub3QgcHV0IGl0IGluc2lkZSB0aGUgU0VBTUNBTEwgd3JhcHBlcnM/
IEl0DQo+ID4gc2VlbXMgbW9yZSByZWxhdGVkIHRvIGNvcmUgVERYIG1vZHVsZSBzZXR1cCB0eXBl
IHRoaW5ncy4NCj4gDQo+IEkgbGlrZSB0aGlzIGlkZWEuIFRoZSBjb25jdXJyZW5jeSBsaW1pdCBp
cyBvbiB0aGUgU0VBTUNBTExzDQo+IHRoZW1zZWx2ZXMsIG5vdCBvbiB0aGUgU1BETSBzZXR1cC90
ZWFyZG93biBmbG93LCBzbyB0aGUgbG9jayBmaXRzDQo+IGJldHRlciBpbiB0aGUgU0VBTUNBTEwg
d3JhcHBlcnMuDQo+IA0KPiA+ID4gKwlyZXQgPSAtRU5PTUVNOw0KPiA+ID4gKwlpbl9tc2dfcGFn
ZSA9IGFsbG9jX3BhZ2UoR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOw0KPiA+ID4gKwlpZiAoIWlu
X21zZ19wYWdlKQ0KPiA+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiA+ICsNCj4gPiA+ICsJb3V0X21z
Z19wYWdlID0gYWxsb2NfcGFnZShHRlBfS0VSTkVMIHwgX19HRlBfWkVSTyk7DQo+ID4gPiArCWlm
ICghb3V0X21zZ19wYWdlKQ0KPiA+ID4gKwkJZ290byBvdXRfZnJlZV9pbl9tc2c7DQo+ID4gDQo+
ID4gTWF5YmUgZHVtYiBxdWVzdGlvbiwgYnV0IHdoeSBkbyB3ZSBuZWVkIHR3byBidWZmZXJzIGZv
ciB0aGlzPyBBZnRlciB3ZSBwb3N0IHRoZQ0KPiA+IHJlcXVlc3QgY2FuJ3Qgd2UganVzdCByZWFk
IGl0IGJhY2sgdGhlIHJlc3BvbnNlIHRvIHRoZSBzYW1lIGJ1ZmZlcj8gSXQgZG9lc24ndA0KPiA+
IHNlZW0gRE9FIGNvZGUgaXMgc2V0dXAgZm9yIHRoYXQgdGhvdWdoLg0KPiANCj4gcGNpX2RvZSgp
IHRha2VzIHNlcGFyYXRlIGJ1ZmZlcnMgZm9yIHRoZSByZXF1ZXN0IGFuZCB0aGUgcmVzcG9uc2Us
IGFuZA0KPiBzbyBkb2VzIFRESC5TUERNLkNPTk5FQ1QuDQo+IA0KPiA+ID4gK291dF9zcGRtX2Rl
bGV0ZToNCj4gPiA+ICsJdGR4X3NwZG1fZGVsZXRlKHRsaW5rKTsNCj4gPiANCj4gPiBXZSBtaWdo
dCBzb21lIGJhc2ljcyBleHBsYW5hdGlvbiBvZiB0aGUgU1BETSBvcGVyYXRpb25zIGFyZS4gY3Jl
YXRlLCBkaXNjb25uZWN0LA0KPiA+IGRlbGV0ZSwgZXRjLiBXaGF0IGFib3V0IGFkZGluZyBzb21l
IGNvbW1lbnRzIGFjcm9zcyB0aGUgcGF0Y2hlcyB0aGF0IG1ha2UgaXQNCj4gPiBjbGVhciB3aGVu
IGFuZCB3aGVyZSBlYWNoIG5lZWRzIHRvIGJlIGNhbGxlZD8NCj4gDQo+IFllcy4gV2lsbCBhZGQg
YSBoaWdoLWxldmVsIGRlc2NyaXB0aW9uIG9mIHRoZSBTUERNIG9wZXJhdGlvbnMgdG8gdGhlDQo+
IGNoYW5nZWxvZywgYW5kIGNvbW1lbnRzIGFib3ZlIHRoZSBmdW5jdGlvbnMgd2hlcmUgbmVlZGVk
Lg0KDQo=
