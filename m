Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF353F107E;
	Thu,  1 Oct 2026 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886601; cv=fail; b=CB3I3aEbmufosmwllqU+zRbIR2Ams6E0CniZdse0GFzLDt/xnl51wntO3jZc8olOPusRxJajdYCrTZ7AmCvTvdvLLZw62VKfUCe4yD1RNrANDhWIbE5oiKydIqf3zr09EQn5YUHNvtslrUMbZ5nUSNwoc1zFR1DahizHCX77AI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886601; c=relaxed/simple;
	bh=1u62YcnQ5m1i8OvHjh8FSqZ1IbyZBu3w7rDKI8e9IpY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JjnIncwP9GeIqXObydKdKXRMehUrfRKnM+fdTcI+YOwaAspmtQovRMa1IZGlm5z4OEZpsf0Ft+9hIj4TpXd6aIGaNp4BTYCCaFj5zi60p2UZaec1MaO7teTGx2uclRapOJ96z2lqga1+DBl5/IlnG14KTFP66jwIlgnPv2XnWlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/oxSZ7i; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/oxSZ7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886601; x=1822422601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1u62YcnQ5m1i8OvHjh8FSqZ1IbyZBu3w7rDKI8e9IpY=;
  b=W/oxSZ7i3LurQ4QP0cey+7jIyTlspRVDuGXyaATJ/4gYLNcP4QxHU1tG
   QYA/hxIMMtUL/KoJdJ3wwwzn3ajKeepNg3erun56/IFeVdjZyVQBmtYZU
   kIzEG9B0by3mxF6Dlbmg1YyFHjs3sUcIhgp8ppBBcQCfEnMH+RzTXAN95
   +npo3m0/zQwv9VhuPjST54KakBT5DmdRydc5CuRgAfSmwaxBpQFQjrUgU
   OeyHZMxoZFS6yHIe78T0yQIPK2kTM4RUzvB8+vr0v782vJDH9TU5bJYMb
   0O+iEOolHs2YFWh3Xz3hqyyTOqUzQg3sEux6hIiFVWu7cS54u7ZezzvTE
   w==;
X-CSE-ConnectionGUID: hUD04lwjTyCZLMi5F8emMw==
X-CSE-MsgGUID: yJfdsPjcSwKF8cmP5+IGFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90868943"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90868943"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:30:00 -0700
X-CSE-ConnectionGUID: pdHaF0t/RJ6AODn57YQAgA==
X-CSE-MsgGUID: Gd9ul7f7RxChPQifvAr7Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="274163435"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:30:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:29:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:29:59 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:29:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwTm59lRjHWgEscyMlu2KEPfogzbfFqYpl1v/MqkVWrEDi0cHR1eGYsmESGb/LvIPu+cEoAoq1pPuvy2O3bsH7aaQNCSAxX2VRtDuC1xqbn63Xioi6u9MlBAm6ZxixhqUViPMvsYX85F0C8qFAaIEJ4mDvMwQh8GjAYU5mtJqppwPHVHEmIfSxGWOxFUPaOLrAm14l4qI0JucEiB7iEPx1jqhpPDQl57V2s4qMUjmUH+yHJrmyIPFrpbgkRrTvMPSJqGsgCFi/CQl3FZvBZMaEgtKt3WHcBxilCpFj7OpmhtqCQ6Bc4+xyDu2umpH9UWhGUxX/Nt7B6VmY2mq5CXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXx7kmeu6IlLMIkuNlJYdEIwp2o/AKtM9MAd01OYPrQ=;
 b=LSzD81MBWclcr71EfLgL48cmlF/2xl4llYsd7kY5WSBr1RWw7A8lLb2i+I6vzNaddBXsgpfL6zuWh0kUk3ILAb9Q1VLZKdHCIiUbucZ2HK7isrqurFQV9O0HQWM9prXywT+yd4o+zB77yDBh+lEwMOON8E47HziUYD5QfO8oejeg+muTXao6KzNh1au3ZUqRnq4oaml6yARkK9Ssp0mCpp6U8heYolQezk4xj/e79mGRCO+GZc4QlWwpcNdlMfSVJWbTxz7hXPz1CkXKORz3aBbjuFFJwTVl87bT8JSMtqU6zmrCJyxjyEJLd+dW4gx36ZGrBuoalPGJSLFZ2OagnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Thu, 1 Oct 2026 20:29:56 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 20:29:56 +0000
Message-ID: <a288d79b-5cba-4c9a-940f-984a0b7412ea@intel.com>
Date: Thu, 1 Oct 2026 13:29:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/20] KVM: x86: Enable APX for guests
To: <pbonzini@redhat.com>, <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhao1.liu@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a8c41d-b5e5-4815-3a9d-08df1ffac1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wgDRGmY4UC7O+s5NF7Nm0zKKVkJqrDfltiny81QECJX2lTc/JH+xbnytml8oM4IZsQLkX58OrQsk46uYoONptq7Gy15MNnfrN5ZA0PF3UFJ50SvOLsjM5f2yNLL/wffjhiqhGM/ewcwk8L6ApDe5ub1Zi16+HrCgYMK6lKl91Iq5116oBL39hqCxCVsI7U8k98PlUBBdWWs7g1Lmka88q1nxycrUPfAFogS9mDP778+5NQSc5Yvx4f6p8ZY88OJhQKGshaQRWkBUXP68rHZpL/EqdBgo1QFLZvn/ok7ondjciuNytexv7HY9pTkaC8Oz2Hz1Y/6tKb1vs637r6H2Fth+rrWSy0hm22fB7qA4X3IXRX45tDdZoJiE9YPHhAOcE0hS4C7dXgyLAvEiw7ysfgI0hIz4kpPGNBNdr8bq1/2dFylz9lGxaDmKpf9zKqopCXCN8AcKlho0uyC11D3XX8MvvJpynww6OQUvIUmMh3ZyD+4uk0VIqUgDTLztACZwRCPpCVjdzXVvBCPI2nIQAHDn8+INX4VuxTeiSuzIesk8fLtUCvTEsf0L1KsY3bk217ktGLNm/M9Ni0mswxpH46qmWz6bdJx+4OJ/99iv4nVTOUxJrrSCkhuk+OXndTKSxq+lKsrxNGghh8HONG2twZpzncOdrNuVeBh4MZvAPHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFYbk5vK29lVy9VVlBsZkJ5SmZjcFVPWitZQ0ZhUzVSNHhTaDJvZ1pKSEZw?=
 =?utf-8?B?QlR3YjNVZ2E1SmZkTG9Qa3pyOThqb3FlN25Vb0pPLzVlbFFqejhsang0RFR1?=
 =?utf-8?B?alBOTHlNYTM3YjBEOVVUang5THUrWlBNL3pIdlp5QjVRWStFazRXNE9xcjNh?=
 =?utf-8?B?c3o5SWNCMFVvcTdlWTlab3pkdi94OGhlS1FGUll5QWVBbjhsTDJ4dmUzSzBv?=
 =?utf-8?B?ZXhOVW0xV2FQSkhkeXdQVUVuK3AyTTdXNHJJV24yZkE1cnpoc3pEc0NmNXRl?=
 =?utf-8?B?QU16NHZzVXBxSEkvWHpCankxN1Y3WVg0Y1IrNUJNRzA0ejFxS3lJeExWbnRV?=
 =?utf-8?B?anJUVjhYRmVMUks3TURsS1Mrc20xemNPdFppOVd5WU1GaUZYVVR6aktlbzYv?=
 =?utf-8?B?SlgzNE80MjU1OVdvNmJLVTEvOWE0Y01Gb3BPMnVHY1o4dmpSRy9tV0t4cXBS?=
 =?utf-8?B?OEcxblYwcSszcEJPTmc3ZERFNC9rN1NUZnhqSE9UdytQd1NQL0QvS0g2STBq?=
 =?utf-8?B?aTJWdngzbVJuYnZwcEw2My9zMUl1ZGpia0o5djdwZVV5TUJkNU5KOC9nK0Ft?=
 =?utf-8?B?THdRRU5DU2VmK1BVSnZKNGl6TUQxcGxLeE9sNStHaVdVUmpRcDcwL1ZPTW9r?=
 =?utf-8?B?d0FpUVlHaW5aMXMzZFdkblBKS3I5VHd6eXdpTXFybUpCQWhmSmozM2ZCMGJ4?=
 =?utf-8?B?blV1bGhJemtJeGhpdnNvTGFtYzhDYlZXOTUvaTZtSmJPbm9nMGd1eW83bDJ4?=
 =?utf-8?B?NG9TYjBHOE9VOElySmxIRzJJWVZvNFZ3S0VzV3lsTVp2bGx5MWphdHlTdVJh?=
 =?utf-8?B?TzcwUGthTm5lTytSU0lXYWF5UjA3TkowbWpaY0pKaHZ2YXFmb1N5VWVORGdq?=
 =?utf-8?B?Q3RwUTd6d1Jvc08yRzVPMlJ0WTZ0RlRzcWRxR3VsOVRKWFNBTjZmNUFZbkRX?=
 =?utf-8?B?WDVCL3VXNE9pbnlkSk5CdHBkRm5PUys2VG00ZXBWa1lleU5rZmNRZWFyVEJj?=
 =?utf-8?B?U1N4bXVLaWN6OUlGdTMrdVhpNGsyS1JyYUc3RUVCazhBaFZlNkNScWpmMVdO?=
 =?utf-8?B?YlJlNTcydTNpOEcyd1RGLzk3MWJPd0dCak5MTllxSUVtZU5PWlFmTTE3Rmo5?=
 =?utf-8?B?OWpuNTc4aXB5SmJOOXluS1krdkJrbmprcjA5MEkzbkJNV1lEcDZ0MzBqZHR2?=
 =?utf-8?B?RTYxR1ZHeFRqaUxqdzhQODV5cWJNWGtFbEdBeUZ1ZHFMRENKOTN6dWdudmgy?=
 =?utf-8?B?RmxmMFVPVlA5MFpyWHk3ODdHVStNb05ELzhNY3RmcUMzRGo2UDU3Mm1OWXB4?=
 =?utf-8?B?Vkd1SE5MWTVVWHpRZzNTK084a1cycVFqSXlKK0VBam5XVEJpNEF6Qll2QW5R?=
 =?utf-8?B?V2xNdmN3eXkzbjVuNTFCNldrbENqSXBnNUYrVnhGcU1pYjNhZW9kc1RKUWg5?=
 =?utf-8?B?S1pzOUJLVDkyV1RGNTdyTDA1dTF0ZXlNQ1ZEWlBwVmlTN0xFVndLVFJxVCtl?=
 =?utf-8?B?SWZtQ1BoUGRVb3B6dkZoUjF4cXFqeFowVmUxNDFWOHM4eFdPWEFrN2tvTEhh?=
 =?utf-8?B?TW1kR3NFODI2amYxUFNMMGtQVVZjd2NVSzFQMTQ5QTdRbXN6ZThnTjBwTUdL?=
 =?utf-8?B?dUJ0U2NtS3pCUWdmQVcxaVNJendRRThPaTc3aEVaRTgwZ0hyZmU4WWU0WVJB?=
 =?utf-8?B?YVRROS9XUnp3SDY4MHJZQ0NwYjJFNFRkVWJGME1FbFBGeXJJWEtBSzJsMDBS?=
 =?utf-8?B?OWNqNnBCczAyZGd2WG11NVVyQU5vNUZIZ3c5RXVWaklVYkdVRjNoa3V4UjFv?=
 =?utf-8?B?YW5tRW9CRDY2cUN6WnpvRHdhT1gwZXFkRGwrZ25MdzJrYStjZVNQZ0VhbGht?=
 =?utf-8?B?TzVwY2VWYXpYWmVaeWZmb01yZ1BmK1EyaWk5YWtnV1R5aUZXVFF0MW9yeENF?=
 =?utf-8?B?eVVkbmFZbHZqMHY1bmNZV1FIMlVNNWJld3RxYzh5b20vNGUyUWNrUkswVDdW?=
 =?utf-8?B?S290WFJld2xXVnpBL2ZqSEg0aTZ6MnhId0dadWZwUWNWZDRxczdCS3ZPaGlF?=
 =?utf-8?B?b2ZYeXZJWDh5aUQ2c04vcEs4OU8wN0l2bW14cXFIb0pscFNuNjBoclV5QjlW?=
 =?utf-8?B?M0RQelk1SXFKSGVMTWZqczNsU3ZTQWY1c0o5c1gzdXJwVGRFUS9KSGt6bFFE?=
 =?utf-8?B?Z2NRVno5U2FmeXpTbkEybmlSbFowRW5xb2FMRjJ1TnFLVndLOHc1OVcwNDVX?=
 =?utf-8?B?NldEVUU2QTBTTXBKdWJaZExwWG1pNnJDVXB2aHRFWmdpcUFreEhwYXljNXg0?=
 =?utf-8?B?cmxQN1ZqWXNnT2x6NXNlSzBGajF5RmwxazlLMHJlRHpXRTRUYm1QUT09?=
X-Exchange-RoutingPolicyChecked: QCPrrfYjaT3XWMMpnVnNy/nrQlbjgyKIlm7nyk5iSnptyDLlfWDS7PGqqJkRJqvgZO2JRegE7cn5SUd7B/hqkbNooemvqLFPNLPyO1lajCkjLXrq2Ri3WQneaQMWNOxOuqghSPz2ScQ8LKentUKg3YkFXIJK6OhnO9PmmznQA2ldpc5oJCiCnTw9jXpcDKS7FA7avBBL8Zx3/Cpwp5IbpfDFBT6xsOquJFomxwn+4gacIn9rD86TW52v4z3SPPUZm/PgpzgR8r8ChwFLh18dJwhmabM6NEojz7Uk1vCxSEGx1POI4nq3lEc2nz5zjxPrUXkptMTR9oyvOe4LlQnGmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a8c41d-b5e5-4815-3a9d-08df1ffac1c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:29:56.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyYUHzrNNMJeamhRS+2nkmvzhvA5nzU7B8ZaUaz18hUk2latd2Q7MPraevdM/ncC9egl8o7XT8Lk6jQSP+Cxp7htn6lgYJDkKhYAAbLQE2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

On 9/30/2026 2:07 PM, Chang S. Bae wrote:
> 
> I expect Sashiko to reply to a bunch of patches. I previously found some
> false positives, so I will comment on them again in this posting.
Okay, I've provided my comments there.

Thanks,
Chang
