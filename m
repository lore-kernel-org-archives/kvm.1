Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383B316902;
	Wed, 25 Mar 2026 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463330; cv=fail; b=UiLRtyUssY4/Ec3ctEszdteaHQdn7ttKQpcuNxiJNrFr3aSrTzhTrkQqmq7fvaMRyEiKwleNhEHE5r9RI8CYocP/yNLOiyWpIXpMzw4ssBKUNL4s7fD9gnxfHozw3srlcmwKyNmzPaEW5W/QH+Je9M0lDJNWLjxkaMxdEwZVOwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463330; c=relaxed/simple;
	bh=OflrVOfgoRa2FSN+RwfI1cCraXeZriuirYTIkZkPh4g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifbLlX44+qKneuRkwguHdIyLFoBO+1QsxEPe5fvw0t+wVh4J7ynqigrrwepjvooBP0hDwT0nEblYSDhclhRVDvaRZadinRVNFUnQs8qZAOgy9KhxoTCyJ0ZW1Ie27T4+4tlBP7rN0VhPxKsDF+xFU1hEFq2GhogKdaklXmGKImo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNrh1bKi; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNrh1bKi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774463328; x=1805999328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OflrVOfgoRa2FSN+RwfI1cCraXeZriuirYTIkZkPh4g=;
  b=bNrh1bKifaOJtX5Ssa5GCESr9BneSYOtDoqBD0Bv43lvxiBcqtUBFOJn
   sa+eWnqmIgpCPj2Whm5ajpDrHbnUSWnta1UOYjsjEkc6HUVXSEIegVswZ
   bRONMmdGX8wWBM7y+n62rYXecexGD0xcB6b3PdfK4DRE6uJY0jNyi+KaB
   J5lfMq56N90t3CNfFudPIPJn0/JNyHgzzlE67xnXt5oXp5NKiUqGiqP3d
   KvrnZ8znNAa8spFpCmQQc10/DrWy7gHQk0Qyjl9Owv9FNmw+XKrxMSZeg
   B6jcRo5NVFjYfGdqr+vkiioha3f6BU5cwlbDnIV6MW/ImJrdPVE9aaWFB
   g==;
X-CSE-ConnectionGUID: BFzTUuR9R3u3l4KkBwWOew==
X-CSE-MsgGUID: oW3l3Qd+TR6BrY8483PCuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75530856"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75530856"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 11:28:47 -0700
X-CSE-ConnectionGUID: C4Xr4VNXSbKDIfrRKkHFaQ==
X-CSE-MsgGUID: EAdLbaV/RD2bnzoaJIkWhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="223958610"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 11:28:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 11:28:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 11:28:45 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 11:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbI6LhQUzTraxbdPtOXFJVjIryqI4xM7Juy1blA2aNSo+IcfAVsZJxyxzzNTmKhixHbowdFxC6jd2nW0hH+UCkYxDr6RnNcaazW3Lqa0pDZqmcn7o5Z1OG2us1eguMPUBAxk2TT++Ae2DzIbyelo3LZQ1Bz3utajW+moXlqoDNkQXOko0FlD8od03R5JMfbHc9LLKKDoYGeUSddnUm1jOn4muXP47PLbf89eClRTNa9yn+KSEBODTZzQ6e8HUqX6PGUdn40vYcQDsDnZyyItum316LDmyeDdI3QmA6HzDiyZzeBl/uTjT7Mr1XCViuJPHqVuQWA04R7jeNu7zh93tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8DeeSG6/+S8rEGIKqtOeUPqCMvr88gHBm5acmJ/MJ0=;
 b=DEk0cPvY900Lt2VNIJfjLcyHgJERNw0shb2Y4LaBw00Yr/yilztGR0klfqw1s+SyQp7ycBuKJY85RtdsvKCY3S+Jdf3tVoagQaq+/0S/VLfDhDLvdCAY5ThvyKcel89krSups9fm6ysKuM0kPigiPpWs3uoUI7O97vyrNz2JK6E+gKJQdA2OS1o71zD9CfRe61Xf4IFAlyui0oUaL+xiiSlhtdBwrXVl4mHlNONZjroXFtqvrRcoM724LWU5c/ABxAD5CwWwGdTJhjRIbLu7xD9ZpCF8nAtn3tBjNJpxrvQwen4ifyP1aIkgPP9NABCisPcsvMENC02kj0fdARq5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 18:28:40 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 18:28:40 +0000
Message-ID: <3051c067-048e-4388-8c22-1e275d8d3b5a@intel.com>
Date: Wed, 25 Mar 2026 11:28:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260311003346.2626238-1-seanjc@google.com>
 <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <8853f8d5-57e6-4ea4-b9b5-8a0182d0d012@intel.com>
 <abL8SW5JS1aV5goa@google.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <abL8SW5JS1aV5goa@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::35) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|CH3PR11MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d71ee9-02c2-4e90-8b86-08de8a9c5615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KPJezImQjXtry9+BhwzbKOhZXhyLbAAT/WnLfETYpwCY/vyTxHYjvjLeEYX8jRSOIKUb4rVbMSEiIS6CAdJxqwTD3Lp5EwuP2sQCayOk0aebBecclAcjb/9u26GL1wEOJW1/rV1KDN1R9nwHU4OVbMSLpM0WgINLo7IimugP61QpN9earR1VhqPCf9O6FwnPy3C2eGcX4CGxGMNUGzb/EJFEN6nGZCSw4xWINLYILZPFlZQJxy4tOIZLAfa115iXFMZAH71vseN/1EchTZrLiFtpDJ7TniBsS/yl93BFW/+omkloRXTnxruU7Sbxc0uvg/XaUWunT/UCPo1IL0WS0z3Oe3D3WDZErfT9qbqECItRFaYOXEAO90R4kR7rCsunJ76YcGq/84fe1iIk0kWWB//bYq09v9tYDEOYorWzjhdtirPknSIVRyK55lA8J8Bi0qLW3O3EvskKEHxUwE4/eGXlEQMMfAppRXROPDw1CxxFATBfBpdn1Tr9QnYOhJoI0I00SpLuP4p/kDlPoDfPB47LisjNQN2eU+S9X2hg5RkXtiqH3ilifUCF7SNtbPFrBeiFZUSvNPePD4ETTJ1YANlUH/8VETrj1H9y8z28U/JnX1YO1ITndnS6BwtYN2286ZIKeqZwlY8o8yL7QIwHQmMayHuFJZvIu/0gtxGDi4ENwzwjJhgU/BOUT6pAWI+xu2T3c4BEm+euQxFUnxnadVGbtEcaoaw8BDg5kVq9lFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WThDMDFEeHV5NlJ0TTl1UFM5NnVINU9oRFgvbmxDaWZoVVF4Wmk5SWVyalRp?=
 =?utf-8?B?c3pqNnFLYjZ3dWZtQzBUWmI4SnlNTWtRdk5KV0czR05WZi9aeFNnbGJaM2N5?=
 =?utf-8?B?d01seVp0TWtiVHFibzA2U1VEb1F5c2xOZVA4azJiMVlWMUpDeWJON0NHZk5t?=
 =?utf-8?B?cERybU1DdDM0MDNXSVVHbUdiY3ZRRStDRGE2b0hYZ3J0cVVRemdCYjZTa2pY?=
 =?utf-8?B?UmdkY050VVBmck83WkFwVGRUZVNleFIvOTJiQ3hYdjAydFNtdzVLYWhQRExi?=
 =?utf-8?B?MXlDekpHQ1huRlEza3p1SlJXQ25uUWpHT3NLN1F4U2dnMHFyYzlreXRNTHJ5?=
 =?utf-8?B?YWRFdnVXNzUraVhYMVFYWHNJV2IrNTk4dGZ5K0lObW1nVlVqb0haK0M1eXR6?=
 =?utf-8?B?U3poMWx4b0l0WTRLTUc5ZjVBVkJwYW93VnVVcUF3SVFxQkFEa2xZSXRJb2tG?=
 =?utf-8?B?RFo5dXdhSUw5Ym9ESlQ1dkFLa00wOHg1V3BNSFZGdUJHZVB4bGpLVVJNS21I?=
 =?utf-8?B?UWdZUHEvK0JNRFRKc3FzcHlsVE05TENVc2hWVkhtbFU1OWQvcGxpVGt5MnVK?=
 =?utf-8?B?ZUNiZk1nUUgwZWZmMGJRR1piRnpFT1ZKSUJscFA3RXZjWnJvdTR3Z1A4U09l?=
 =?utf-8?B?UVpEMGc4RlphK2FBb3VLR0FkNEx1UW5aRTEybW13SEp2eTJvZmMxK0N3U1N5?=
 =?utf-8?B?TVM4VDE1elpjaXJLQkRwbVRwVkY1VUh4OEJyWmdPaEdPaXRaWndvRVpYQ0J1?=
 =?utf-8?B?bGIzZVI5SlFYSTNrWGZiek9COFRoRDVFVVdYN2RYL1lPWGdzdUJkeFo5THdu?=
 =?utf-8?B?cW01aTA2RmE0Yk53aW1QNnFQdXQ5bTdMUFBLMi8rTTg4dVR4dUJvdTFKOGpM?=
 =?utf-8?B?TFdXOVVtU0hJLzJnRzA2OTdnU3JkNlNhSGd5WVVZTlc5QU1lRWVGOTNpWnBM?=
 =?utf-8?B?ZXNFUXMvTVd2QTdaOXg5OU1ybi91ZzNPRlBscC9MNSt3cGdpSUJwYVllVFpV?=
 =?utf-8?B?eU8rM1BPUGNXT3NYc0djZk1jVWk5eHZEMnVQZmdVUHdNalVMWkpyaUZVb0tt?=
 =?utf-8?B?ZlhBdTB0S2NwUy9IbC9rc0NWRkVRUjFDT1l1bWR1UytYRWl4VWhUV1hmd2tL?=
 =?utf-8?B?U3VnOXpGbWVlckhveUgxK3ZjMDVxM3NzTlMxMkxKaXhDUnVPSE9JM20rOU1i?=
 =?utf-8?B?b3JwU3dDSWwvdUc5dmlVWFlDZGJMVW9WM29MUWpLcUZiM0lxMDFpNllCa0ZT?=
 =?utf-8?B?Tlppa0RTV0FIN0tCZldqYXl0UzJiZHFxaXMxSkU0cHMyVXJDbEMxQlR5Rk4v?=
 =?utf-8?B?alBiZHpwN1E1RGVRaEZDOUtuVER6WENlVnViVCtqVlM2QS9YM01mU2VlUmxW?=
 =?utf-8?B?N2pURVZ1eXRna1ZkcVRZYXQ3SEY1VGVnc0xvcFA4cGpUMU9XNjc4czNYcFpi?=
 =?utf-8?B?VEZma2RUN2NpakZ0T2R3eW81MlgyRmNhVmVyd1pBaHJ5MlBMOUlZTC9iZHRC?=
 =?utf-8?B?ZHBkWFFKUlAzOXM0Y3BzdU43N2tLRXBHUG8rb0xFUElsVkZQclduNFArQ3Rw?=
 =?utf-8?B?c1lMZHpOeElrTWpFQXdPeGJob20vaHE0aHdiTERmUGpuZnFuOGJaaitrekNu?=
 =?utf-8?B?bytZUG1jVmgrOHp4VHhndnFmcnlmMndqb0NaYUUvVVpzMGdONWwxUmt6UHgr?=
 =?utf-8?B?QkZDNHlid3AybUlaODA0UG0xZUdsNDBZaWZ1cnE0VG1UZmMwNmlHT0ZPNXEx?=
 =?utf-8?B?WE05OHFzYTArd1ZtRElmSitnYzVFajVCTmFiVCsyWUs2eHdHd3VvT0hMMU93?=
 =?utf-8?B?VkZYcG1SNFdiekQ2VDNxK2p5QmkyUGkzRGcrV2R5SU8ycUFVT3lTSWVOU3Nn?=
 =?utf-8?B?Vm1BS05iUHZSVkV3d2V5cXBmMmpob2xwVDF3SStaaUZJVEo1Q0Jqb2RNY2pq?=
 =?utf-8?B?N0F3UWkxZkJ0eE1wVXBYQXlSNlV4WklmVEpKblU4MEM5TGk0bmZqZVJaOWQw?=
 =?utf-8?B?Wm1mTXRrZnk1QkorL2M1bnhtVjUrem1jSFp1L0Q0bjU1d3ZxTTFZVjVIZzI2?=
 =?utf-8?B?NnlsZGJsSWRSOE5OanRtODlIUHhqbnNuY2ZHRWNFT2pNTXBMYjNlSnF3UHlQ?=
 =?utf-8?B?RWlkdHpoNklPV25YYXd5SEdiSDdhbjN4aDAzSytMMXNpZVNtbTU0bzlaRUJK?=
 =?utf-8?B?ZXBXZG1ubGRIU0FkdVd4SGx2aVo3Um8xc0wyMEZHQmg0enNudnh2N2oydmZi?=
 =?utf-8?B?ZitpYlBoWW1WM2lVbFBWcjBPbDZ5UTNVUW1BbnVvNmFKMUhPYUVuTTRyVlRr?=
 =?utf-8?B?NU15STI4WVpxckN1MFNiVW1qcWdUWGx3TzlCWE1PMXZWTGFuL1VWYVBOTGN2?=
 =?utf-8?Q?RPhEQEqIDtuKY8hQ=3D?=
X-Exchange-RoutingPolicyChecked: at7UDXE3jIqzMWpSs5Y4gewOOS4tRUbXE/dvR3iwuoK55VFo1naquR84XRsH4rf9c6QB2SU/UxBvvuo/cb/4e/Gy+8/1IXa5VWn80gH0rox/oyB2HZ7b0FgESniM2XJht+JnDxEvqV+/bJZA8F8IiPYMvbBJA2CZRQyLcqUGKnNYY5iNE0ijIREOYfqj3zfGET/nTMCNOLiM7ZlCTHiGs4aHmtmC9W9+IqZvApIYkFphGrBANNbck2HHrWooPG5KtZ7vyhDeBlr8UbDGEWLuSkEIzmHmRJUGK++wjhgOvvHCLebWjUd51/Mt0p1XBIfsuPrpBp9WcOtaGozv6iVd0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d71ee9-02c2-4e90-8b86-08de8a9c5615
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 18:28:40.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6myBiQmPkFe2B/XiisMzDRE81ODTA70qRgrjkkIH1CZEcASoxAt5EfQk8GPBxUCiUyLvno/4N5rN9aQ6S+Gl/rDp5Z9WCB4dbeXbF9r6Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com

On 3/12/2026 10:47 AM, Sean Christopherson wrote:
> On Thu, Mar 12, 2026, Chang S. Bae wrote:
>>
>> However, that is sort of what-if scenarios at best. The host kernel still
>> manages EGPR context switching through XSAVE. Saving EGPRs into regs[] would
>> introduce an oddity to synchronize between two buffers: regs[] and
>> gfpu->fpstate, which looks like unnecessary complexity.

No, this looks ugly. If guest EGPR state is saved in vcpu->arch.regs[], 
the APX area there isn't necessary:

When the KVM API exposes state in XSAVE format, the frontend can handle 
this separately. Alongside uABI <-> guest fpstate copy functions, new 
copy functions may deal with the state between uABI <-> VCPU cache.

Further, one could think of exclusion as such:

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 76153dfb58c9..5404f9399eea 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -794,9 +794,10 @@ static u64 __init guest_default_mask(void)
{
	/*
	 * Exclude dynamic features, which require userspace opt-in even
-	 * for KVM guests.
+	 * for KVM guests, and APX as extended general-purpose register
+	 * states are saved in the KVM cache separately.
	 */
-	return ~(u64)XFEATURE_MASK_USER_DYNAMIC;
+	return ~((u64)XFEATURE_MASK_USER_DYNAMIC | XFEATURE_MASK_APX);
}

But this default bitmask feeds into the permission bits:

	fpu->guest_perm.__state_perm    = guest_default_cfg.features;
	fpu->guest_perm.__state_size    = guest_default_cfg.size;

This policy looks clear and sensible: permission is granted only if 
space is reserved to save the state. If there is a strong desire to save 
memory, I think it should go through a more thorough review to revisit 
this policy.

> Have you measured performance/latency overhead if KVM goes straight to context
> switching R16-R31 at entry/exit?  With PUSH2/POP2, it's "only" 8 more instructions
> on each side.

Yup, when I check a prototype in the lab, it appears to be in the noise, 
with less than 1% overall variance.

> If the overhead is in the noise, I'd be very strongly inclined to say KVM should
> swap at entry/exit regardless of kernel behavior so that we don't have to special
> case accesses on the back end.

Note: The hardware request discussed looks to be on-going. I don't know 
the decision yet. But at least for now let me add you to the off-list 
thread for your info.

Right now, I think the entry path may live with guest XCR0 in this 
regard. Since XSETBV is trapped/emulated, the shadow XCR0 remains in 
sync. The entry function can take an additional flag reflecting guest 
XCR0.APX, and gate EGPR access accordingly.

Then, it looks to keep the behavior aligned with the architecture:
   * On initial enable, EGPRs are zeroed on entry following XSETBV exit
   * If APX is disabled and later re-enabled, regs[] retains the state
     while XCR0.APX=0 and restores it when returning from the re-enabling
     XSETBV exit.

