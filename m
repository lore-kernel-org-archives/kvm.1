Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793893119;
	b=u1qkjyt8CJ4gYJxv8269WVi7xVIpxlzm34gvXCZZQdYod2EZJjnF6cywgQB0BV7QFS/J
	 FpRuDYKkhl5VEmrcf97wFm0DkvautLQcPcQqn4bMCR8WEoprefCVtUxoYlmcv+bnx+yZu
	 yFoGz8DXByy7RFa+KP+W5TJ8tKrcYz1EzpeDjV/1ipI2mNgpa87mrPfRr/rAwRipt5/BT
	 5p6dOZq8AqhUiJ7nKx8JjvLbFi4TS/Ihhb1z8lrqNTtfbeif0j8nc7s1j82B+z8mhjjXY
	 v1ZfsCoWYf3KWxl0Mhgrk6sVzfy+a/opWWKqbShRWKPwqLUnVPP0iB96hG6f931xgpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893119;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Fuk94eUZkLg0myA0vTDKyJdZPFKdo59AULBUYwmWVfg=;
	b=SVdzBcoMT3svvaY0kylFrL5WcKUsDKRGuEVPGYnNJilCbQjIbZ7GKMofK8fg+4Nr/g4h
	 awwxMy5W94CBsHfiF5xiCu7XoxCtuS10JPBt/dTL2WNosDpvsS/sP5WACRnU6sx1AZTsU
	 ojkRAHsjmBQ2+43hJbjCgjj3FrZcZmjxjrbluynydMVJFyZ1VVp77QUDZHSXdPQR8IzsS
	 pDE0rPcaG7rDi7h94Gb1xziBY7NArhpMI/2ecSDAUCQljdTcXbm2JMX8PeXxWmpJOsVAV
	 Vq02ssapFizXzz6qCmhRH1oEmoG3k67jkNQxX1DF2J3PPBXoduhv8ENraSe/WtRTRWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=itOGTgnr;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B1606A332
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 15:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 921B1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=itOGTgnr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793893118; x=1825429118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lgC0w4/fhBQjL2B2HSjT4o1oHXz2GnA6M5Ll/UDf8aQ=;
  b=itOGTgnrlP9E689lpsGB1smszDGHleR8CWeTMaw8QzKjxhXxH6HBDnJj
   KyPwHUc5/Gosj+Zn/GnFGsvh7hU/teGGMYC+xXZZAAEj9PdFnFJJGOMVb
   n/ILk3nNddOCxufwD6Oi2botxTHVswm5MnpATI90PP4A0b2QFLkjbAfVc
   eH8KaojnN/mnB6HJ7lJzftFJld2YpvmHDnzmDucnUPKRcD6k2wiWe+781
   JNMJOfozmgITWnHdffqnLsXk07COMmDcmWs6D9/zfdIedHTfM3Ckqovvg
   cj1RfpuQA8rkRZYCDccA3lTpxHmI3CB2H94LXFv2flktyupgTFdyABMo9
   w==;
X-CSE-ConnectionGUID: 5GBYQZz0T8iRYwyHXgCUww==
X-CSE-MsgGUID: D2GlWNyaQACPa54gSE81Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2587846"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2587846"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:38:36 -0800
X-CSE-ConnectionGUID: CWl63/hOQrm7Z/WkAThPgg==
X-CSE-MsgGUID: 2JMGeCTATMeOdlibSDGO7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6870261"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:38:37 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:38:35 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 07:38:35 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:38:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hnw+oimEYvAkdYpPrz+mjUXdOK47ptHKU7v1sINv2EGNtlDVSVq10ImMPgh0totvGSjeoPTbGTApGQILWfiBZxtVEr8CZAWp0UOCOb9M+nxBdzHEvpVJ7QFIKzWmiB7Orj5DsIL9Yp4hgZomZEVhXxb9XXmQPAkHxsIeM6SMeorYSZtuqw1si9NylpqdYzCu0kgKUjSQj4YiOL9fzNAXVBf7IwUWLRD6FGGDTBNk7mKwWJgphAo7obsgcDuWeEF47EVlmzgeFTMvdLjn5tMKS2pdi2LOuU9OmQ6Ict0QsL9a9dIT/avfoNvFOo+r2Wi1t0csvOSw21S6f5rZsdMFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fuk94eUZkLg0myA0vTDKyJdZPFKdo59AULBUYwmWVfg=;
 b=VagnYGzqoGolEAUin78EKpLYCZRUzdIZSDmkq7Bo44DOM/s3CCFOsNaWnF0NM/cKucBLc3iGMNaUNX59rIv6rOibvvpk7DiXxb+1SMZH2IJ8OrhWlth+aV87tWzf28YHd4ePEAgrxifOTlZgul3g6lhapwKHfeWsbCeDwVjenuZk7Dabo/4ckI2WFg1Z01TArVjSjjfXmVmObHuSZr5ipkmfCGpW+y36YZ+fIkb4hu1IeHbVx+iLmUVsAITiN8ktzroLaFfG7iI6nnY3pogy1UayqrDsvFBgbHZxYKVpqvLZdQkx4ExMJCtwLaYrmqs1VAV+5fGtengBRJFoLlRdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18)
 by DS4PPFDB7809488.namprd11.prod.outlook.com (2603:10b6:f:fc02::56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:38:09 +0000
Received: from PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92]) by PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92%3]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 15:38:09 +0000
From: =?UTF-8?q?Pi=C3=B3rkowski=2C=20Piotr?= <piotr.piorkowski@intel.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <intel-xe@lists.freedesktop.org>, =?UTF-8?q?Piotr=20Pi=C3=B3rkowski?=
	<piotr.piorkowski@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas
	<yishaih@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: [RFC PATCH 4/4] vfio/xe: Hide BAR ranges by default per device ID
Date: Thu, 5 Nov 2026 16:37:38 +0100
Message-ID: <20261105153738.1938345-5-piotr.piorkowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
References: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0278.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::13) To PH8PR11MB8039.namprd11.prod.outlook.com
 (2603:10b6:510:25f::18)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8039:EE_|DS4PPFDB7809488:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f627ca3-530d-4f35-894d-08df3b52cae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: qoN+VyfXmmTf1VCYoTBfl4VWlR8GEkPfpA9YD7IwSwillJE4RHMs4Q12hLqjggVL4doDZx7Tlj3TLyMKQM4fI5d0sRdBDajmgjf6PKoLSQJUf12pkLB7gjY7G0K0dirtfgeRB+z5+j0cc/DcjGyMgCjkAZnbXU0zCXfof+cKHINQ8jYQO2rWiTnYk5kUDWwDgOg736Kuww7o0rZ6uMrirV3SY2B4H6z6DBqoRlYBLqEUYG8OyT73vU+rW4cmeDhKRF2Qa7pf2DqOXXPMsT+vaZUxSJIgCuFkbS1rV7Y6MFNyJlluXyocwFTLaRIN/oxTNoyBJlBpJ/2HI5lbCBad6uZkyLxNYQJibQ5UDpQpX7aZloAnhYD/4Gm3U+ztV/GHTk2TD1osoDlXZ0aYc8OAUllrQ9KJ/B3w61NxlTSWHUZJv4kS8UIyCsngNcFsgPtLKuYLD8ldcGrdLL6dSh6+A7IbCnByBzNN66pXXjqbgGKSQcRXwVJfVHxZGo5A1vRlKVyUVrbEWo1wj6mtxrQLv59rcCFkj1mUVPZIAUDamTl6QXFSFx1iFTND/eq112M4hOQ8KL9LZd1uIEMCTTKkxqhL2TgbogwRNHIyOtSgtBAL7j9gkyr8Tu5psXE1CvHJP9Jp619ncoKKlWHEtG7R3o0FgdR88iw35JoEeqT+m10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJyUTJzQWgvZSs0NGJiMlNTakUvKzhwM1RyT3Nna3VHWWFtOVVQbTZBcjdM?=
 =?utf-8?B?M0x3UW1hN1ZSeHdtR1Z4bDZ0VG1Xb1puUmFOdkpKL2J1NDJvNjcxb3ZDTEhQ?=
 =?utf-8?B?YkU3amtqZC9JOXV2TzJyWDNleHFCcDRqNGF1c1ZuZHFFaFRYYnYxTEhvQWVr?=
 =?utf-8?B?ekM3d0ZRd1F1M0hFaEtvZkZIVWxrSjMvNHNKcXo0U3Zhc3puVHFDZmk5VmRP?=
 =?utf-8?B?TE5NT2tRd3JCQWsxV2xJYldnMStiRnpTTFFMdDlUQyt4RktCRG01U2p5VWFQ?=
 =?utf-8?B?Z0FKdDcrWjlsZ2ZnNnMvNjdxM2xzNkYyRklmOUxUdXVaRjBTa3hXRDdNR2JT?=
 =?utf-8?B?V2tPYThMWEY1RmJ3R2FBQmVxQlJiOW94ZjN0S2lDeW96Ty9IY2VScnNteUhu?=
 =?utf-8?B?TUE4cGtwRlZZM0pMa1hsSXh1eTR3Rk1QZ3B4aHppVmt6bDc2M3JNMWJVSlcx?=
 =?utf-8?B?OTBlMkxNNXQ4d29NMGNGSGRic25NYUVnSk8wa0hVRWQrWVduMnMvMFQ0bG1D?=
 =?utf-8?B?eXlVYW9jNUFhQktoa05FRHJKbi8xWmJiVStOVTNEbUlSd1JiRFR1enpFM0Zx?=
 =?utf-8?B?ZFNGV3RCMDU1RzlORnNUbmJaS2IrU2RpazNmVWZ0cmJuTVdlb1lvMWEvclVR?=
 =?utf-8?B?aXpqbVp5cklrcUNLVlpDN3VVUVc4SDhKQkZ1dUZIWmd2TGYzRHhiSUF3Z1hx?=
 =?utf-8?B?WjlLZEdqZE11VmNISm9nUHdUNkQrTndCQW10Lzdua083RTVCL1BSenhQcita?=
 =?utf-8?B?dEh5Rk9CYUpiN0FoemIvQlhRamp4OTV3Z0FaRHFMdEVUVFB2ZHd6NnY2UHkv?=
 =?utf-8?B?MEpEemlMbmdIUUhpUHpvMlNxdlY5MDVGR3VINUU5OFZ4NERtK3RUek1UalVQ?=
 =?utf-8?B?R0FVemRhYmZmc1BxaHFlRk1uVWtpN1IySmRBYmxhZ2ZPRVhYMkhGV2tLK2ta?=
 =?utf-8?B?b2VsSWhKYmNPY0VpSzdJYnVzaEdaZHp0UjVQL2RyTFNmYUF4ZVg0QU9YVXU0?=
 =?utf-8?B?eWRlVXVkc1ZOeUNiYWlCTEZ1T01MdEplakx3cURadmxUdkErbDcvMW84aVpv?=
 =?utf-8?B?ajVFclY5aGR0Mk5ncnVxUW1Ubm1YT0J2MjJKSXVyNjZHMGR4amU0R293M2Vu?=
 =?utf-8?B?TU1mdFRhaU9jc3FJOFoxNzczV3FKaXMxUFlNQVI3Ym9ScG1UOFJzY0EyRzZE?=
 =?utf-8?B?ckE4Zk1Xd3E4alJLeElWZ0JzalVVMitsQjRONTU0WmY3UnhUNjBOZVQ4KzQx?=
 =?utf-8?B?QU5yVEl0cyt6L1FnWHlaYVpNazlVdHl4Nnp5QnJTYXAxRFVRMDJEZXc0Y01j?=
 =?utf-8?B?ZjREelFBaXNzS1lnSGVhWEVVWXpHMVFFdnQwR1d1ZllQcjAxZE1VU21JRndO?=
 =?utf-8?B?V28zS1dQbXByUk5yT3A4VWZEL3dFb0ZRRjBxR2N1TGhZUnpIZis5SDR3K3Fs?=
 =?utf-8?B?WG1lK0gvaGYzM2hiUmF2NXJVakZiZEljN010WklwTVJDdkpaeWZBZlNEOHlS?=
 =?utf-8?B?NlRlZlJqd0Z3UkRCTEhBY2R5WjRVdU0rcmVXM1RteGtUTXRVR2E3cElKN1JR?=
 =?utf-8?B?TjdmTE1PanowVm1KM1N3ZVovL1JNWFdKbVlzQTZRMXlZbzNHU1dJSUlHOTY5?=
 =?utf-8?B?SktEQnphRmJxUHZNUFJGcGVKWDd5ejFXcGx1WkVBWjM1UG9LOUQvb2hiUkhr?=
 =?utf-8?B?aGt3VGxyYkJjMEhSblEyNllaYUtZV3dndzBUb1FyVlBBc3FOWUx1em1sQkhP?=
 =?utf-8?B?U1lBN3B0QTIrTG5abHNtV2RzN1gxTXZHdVNtWnl0WGZTbDB0cUJpbk5GMGhG?=
 =?utf-8?B?dlZFTXNaUWNIMmhOdk5veXVBcTh4WHkyZHN4VHZlaXhUZW9OMHo4aFRpUmFM?=
 =?utf-8?B?K09HaVR5QlRqUVRsMms1UVBMSnpSOUVtSjU4d21sa0R0b0xFb2hEVUd0YStQ?=
 =?utf-8?B?WnRzOWZUTm5Ba1liRlAzWEFmSTg3RlkxV24xNGxEK0w2VGRZd216NnFubHZp?=
 =?utf-8?B?MllSVFd0eTRxNEhjU0wyN1Z2bWUzWDhpVzI1cDNjNTVONS8rd1NIYmdJZ3pI?=
 =?utf-8?B?aTdRNktLUTdpM1lRUGwwb0NHNlhJSlB4Tnh4cGk3ZmJ6anZkRUF4b0tnVEhZ?=
 =?utf-8?B?bTlpMkFsS3RnTWprM2pXRTdOOUlWcTBzRlcwZmFZdkJBK0w0N3R1REhvaVM5?=
 =?utf-8?B?QWdyZG1Od2ZkTWdodUpUcjBRbXRaRXRHMlB1S3RHam1wd1pReFk0dUNNR2Qy?=
 =?utf-8?B?ckVLcmNpQThyc2t4eTFQNittQjhmT3FLdEdWSUhIcDAxYkZ3cmRhdjY0Mk00?=
 =?utf-8?B?Ulhac0VJL2FaOU9uY0RjQmRlY0JzMUJ1dlc3ekQycUY5SlhLT0IvS3lhaFJr?=
 =?utf-8?Q?d+2Tcqlc/dWhktSw=3D?=
X-Exchange-RoutingPolicyChecked: Ba8yEYh8+8ACjMdNS4L+0W7fDu8erxu9aw+BFKNMhJH4/S9kmOwrYR+sit5E4zXCfwZF692zXRjpsSV1al65sIKogFEajFKivPmiEdPJztzdpQOuW2BAWkG/YzTzur9k6WQ5ZPwKfEiKIuX50T4kAd8rvd2l7sT/BaGEvoHIK01VWRPbYRm3ONDAn/vby22xD00ugyBNfY3yD564qSblLAbE8tX0ThsfokwQCdC+9MZF4cGhqr7ENtYohhjO9s+3V7JRtrwHegP+dMyUiFlTr6TqzRcLSQToMqPgS4OMY86IlJK/aOGJGfdPChngSBl/HaQIlY/jjL6S3tiqbvYHxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f627ca3-530d-4f35-894d-08df3b52cae8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:38:09.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFVvX8htz8cd4EvBqNWSDIYRGEGfTiUdNofrqcc1GyQl4dl78wYrSkKCidVoCrS1yTdPjVsY3y1ySk9yKBaV4hfbO4xcllVxDK7G/c609ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDB7809488
X-OriginatorOrg: intel.com

From: Piotr Piórkowski <piotr.piorkowski@intel.com>

xe-vfio-pci accesses the BARs only through vfio-pci-core, so opt in to
hidden BAR ranges.

Let each entry of the PCI ID table describe the ranges to hide by
default. The description is always looked up in the static table, so
binding through new_id or driver_override can't skip them.

No device defines any ranges yet.

Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
---
 drivers/vfio/pci/xe/main.c | 60 ++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index 7dab3e024aa8a..e63af6123f598 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -24,6 +24,16 @@ struct xe_vfio_pci_migration_file {
 	u8 disabled:1;
 };
 
+/**
+ * struct xe_vfio_pci_desc - device specific description
+ * @hidden_ranges: BAR ranges hidden from the VFIO user by default
+ * @num_hidden_ranges: number of entries in @hidden_ranges
+ */
+struct xe_vfio_pci_desc {
+	const struct vfio_pci_bar_range *hidden_ranges;
+	unsigned int num_hidden_ranges;
+};
+
 struct xe_vfio_pci_core_device {
 	struct vfio_pci_core_device core_device;
 	struct xe_device *xe;
@@ -543,8 +553,32 @@ static const struct vfio_device_ops xe_vfio_pci_ops = {
 	.detach_ioas = vfio_iommufd_physical_detach_ioas,
 };
 
+#define INTEL_PCI_VFIO_DEVICE(_id, _desc) { \
+	PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, (_id)), \
+	.driver_data = (kernel_ulong_t)(_desc), \
+}
+
+static const struct pci_device_id xe_vfio_pci_table[] = {
+	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
+	INTEL_CRI_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
+	INTEL_NVLS_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
+	INTEL_NVLP_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
+	INTEL_PTL_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
+	INTEL_WCL_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(pci, xe_vfio_pci_table);
+
 static int xe_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	/*
+	 * Dynamic IDs added through new_id are matched before the static ones
+	 * and carry no driver data, look the description up in the static
+	 * table so that they can't bypass the default hidden ranges.
+	 */
+	const struct pci_device_id *match = pci_match_id(xe_vfio_pci_table, pdev);
+	const struct xe_vfio_pci_desc *desc =
+		match ? (const void *)match->driver_data : NULL;
 	struct xe_vfio_pci_core_device *xe_vdev;
 	int ret;
 
@@ -554,6 +588,17 @@ static int xe_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		return PTR_ERR(xe_vdev);
 
 	dev_set_drvdata(&pdev->dev, xe_vdev);
+	xe_vdev->core_device.hidden_ranges_supported = true;
+
+	if (desc) {
+		ret = vfio_pci_core_hide_bar_ranges(&xe_vdev->core_device,
+						    desc->hidden_ranges,
+						    desc->num_hidden_ranges);
+		if (ret) {
+			vfio_put_device(&xe_vdev->core_device.vdev);
+			return ret;
+		}
+	}
 
 	ret = vfio_pci_core_register_device(&xe_vdev->core_device);
 	if (ret) {
@@ -572,21 +617,6 @@ static void xe_vfio_pci_remove(struct pci_dev *pdev)
 	vfio_put_device(&xe_vdev->core_device.vdev);
 }
 
-#define INTEL_PCI_VFIO_DEVICE(_id) { \
-	PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, (_id)) \
-}
-
-static const struct pci_device_id xe_vfio_pci_table[] = {
-	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE),
-	INTEL_CRI_IDS(INTEL_PCI_VFIO_DEVICE),
-	INTEL_NVLS_IDS(INTEL_PCI_VFIO_DEVICE),
-	INTEL_NVLP_IDS(INTEL_PCI_VFIO_DEVICE),
-	INTEL_PTL_IDS(INTEL_PCI_VFIO_DEVICE),
-	INTEL_WCL_IDS(INTEL_PCI_VFIO_DEVICE),
-	{}
-};
-MODULE_DEVICE_TABLE(pci, xe_vfio_pci_table);
-
 static struct pci_driver xe_vfio_pci_driver = {
 	.name = "xe-vfio-pci",
 	.id_table = xe_vfio_pci_table,
-- 
2.34.1

