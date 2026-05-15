Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD20364935;
	Fri, 15 May 2026 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778810996; cv=fail; b=npg6jH3L+CBtechEx1xIocg0It8EAx/manaOiv7X1lkMAfbTQEZ9CslXlait+YtiH+7ErKZlUwGG2NGJgqG2u5CipSpYbw9va1ovIFCoGhxFRo/s0hwTRb5djxpGF9D+z23ifjz57ron9St1+bOzchx4EDhfHb6kJrtC0Y4rsww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778810996; c=relaxed/simple;
	bh=Fnm/FrG1qLzTH5nFIsW8XBEei2HTKgqXqlhPI05dui4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M2kT4n6x3f6mlzKrMpWsWcCy+t3NfNs+fUu1J1N9ih0DaliDvJt5MFzIirIS5BcOx9/saRocDabUETiCv0u3uTVcuWRlFiRgKOEXdVqmGkyE5Tr9n8jK9/veiiL1Xd369MSGJiu9xJjJRbI5zAu36Eq1ByZtPsfD7bchmxV5Hlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bF+4Gu2M; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bF+4Gu2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778810995; x=1810346995;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fnm/FrG1qLzTH5nFIsW8XBEei2HTKgqXqlhPI05dui4=;
  b=bF+4Gu2M91NQqeSqpI5aHFBICVz2eX1KkpquzJsC31CjwFRYvpsmDOC2
   JQJ05CyTquqSi4UukUie0kIg+M+kWDMx2VzHNH1lN6DuCSaK3rjF/gOxI
   kUsPRdZyhvQfRZGgbPvU9Ax8b1jKQdAYMHQ6cWOIo+WO25eF3Azhcn1cx
   iZTbApLn8CPHyKsrPSm8no08qfkU6rz3TsAbq+6LYpSBp6BjcFYvAiAkz
   XkUoErIsIVKtorlh8ZELSoGaNWzpjeHM7RShdn4Sym4hNtDkclaREwFoJ
   OqjQf2+eZl8bvR6Ioe/iFlQt8ikQmYIOF7bypPdLxXXPCOL2QgPtdksYX
   g==;
X-CSE-ConnectionGUID: YoWKsVLWQxuB+NXpUJldIQ==
X-CSE-MsgGUID: oXDBDZ8KQUqZ5uxuJmbKeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90073148"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="90073148"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 19:09:54 -0700
X-CSE-ConnectionGUID: bI5HuomcTImdlOSdS5etnQ==
X-CSE-MsgGUID: WaUuPxeLR/SBpJaRwghWEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="243532557"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 19:04:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 19:04:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 19:04:14 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.14)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 19:04:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpL+lFPkoEcp+/R2IYZQOCJili6Gyv48Va2eiNkYFaEzlPPNLoCBQF7Xz+36M5mW1Y02uxkD5m36IQPaOgcsPWDv7XrP6WHlfAFGjmqhHoGOlgi7N/9jRPO6jrouaZ0TOW+fUYLPYTnGYi0ZrRBDNqEaXOj6IPKhQKXWtMgoTDeI98266fkysgaoTsXCMMGhAIjwlXjH8sbPT63ZySQ4Dh/5j5F4vDHt6E7ARkSbxXCJ96d0cAtE2l9hDNqYACWRil1u0xXzpeNdWTYx9/2u0AILj1k/x1LUyhUYL+dTSDJSKoMlFLYwuFsPlRthMDfWtzXE+8XroUXkL1m7ubcZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMC9dXFdNbx08k9jhYSF+nh7zvZ3o4BCBps5nSQG1M8=;
 b=KgeVmLxmFZRsRvWTSVnUzkOYE62Z8iwf9I/wbUeQMl8AxIeQ0L6JO8pTKBxiQOTmVFF0ldo+7HycqP9DYpiWfHxmdveueHdeUzwBmMObXALu2Vpm7plIAYYUOfJOZ0usBhu1uER7sRA+vo1qdz0oKsTw/MqQK8FkqfdUISA+D+U//+3vNWNflJIXRk1/PKWAo38kMpQDG1kdJPUahffUmSRjCxXQGrDHf78xdnUS2WPa8qaiwtVtRu4qlwcLWqx5UDttbfRMBg5Jsz655NOkfMXgN9ySnZoLr7t/CAbf+cIzqr5lO5I08HjHwW29z6wHo/XTYgiBQhvUl1feu8tYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Fri, 15 May
 2026 02:04:10 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 02:04:10 +0000
Message-ID: <ef605dbd-6594-4ddf-9274-c8ad9252f35a@intel.com>
Date: Thu, 14 May 2026 19:04:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/21] x86/fpu: Ignore APX when copying from/to guest
 FPU
To: Paolo Bonzini <pbonzini@redhat.com>, Dave Hansen <dave.hansen@intel.com>
CC: <seanjc@google.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <chao.gao@intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
 <20260512011502.53072-7-chang.seok.bae@intel.com>
 <6adbdfb5-c4fa-455b-b427-2f8350bc9c2e@intel.com>
 <CABgObfZmFLDZPLEeLW5=yk8oyO8ibXr48JSVXaF7cKfz2SQw4A@mail.gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CABgObfZmFLDZPLEeLW5=yk8oyO8ibXr48JSVXaF7cKfz2SQw4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::34) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA2PR11MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: cab0b27d-3601-4ad9-ecbd-08deb22640fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: XtsA+w+naUkz9U6KAxBQYmpscM//Jf2g5/FKIOyluPnY91sEkqbxGhxrywoImp5Q1z92uXOmD0+C1tS1RPiItJtopPsTdUxbz13x+J5g2LzJ7fVZ5wwf+vNUgFuF6fk87ll53GxYOS2xtFXxBsiPvpd1Ke5jVFo0NxhqWICbOyuzRH6HcPQo7E6dbLdoZiVjkA4Q3iPdzVPfiyfgBREOEgZ0aYDVqSEYgSj1cIB8iy1nran+Yy6jlg00MVSGKuMlhbZUt0LdbSJM3SHYD/EKvTEmNLluvy8Ga0f5e4ApJRsCAejN9Q0VUfYa4SETbxnXCf/3qt2thOwoVV9xQvfXiljAeWICSxT79f569qdvXFXtCbL7KBZBhB+JF/nNS63rFDm+iGV3VI6yGUykyrxtrJG/2T1+l50S0IeQsHK/GCTlb9eeEQ4Gqj2sIfPel0O4UO93XuJY2LLXYwhkQ/zfj9f5PZpZcH85A26r8bD7vKN/byczMEMY4RW4ZWQxi8UDZZ/z8CINF9RooSC2IXFu+HefbCcO8Cji6R1XO63XrGf3jXbAoHbohzfb+LHHpEFB/7291QMdz9VV30uaqv3YGRm7YQFazy7hpkT3dIGaJQO0REbbTn3OjNZRbNTzW9s8Idq/+maZ6dU1vruynstgj2ntCKRdYavFjAqpEFNUCP58oXyHPnt6b/uusHQtAnrD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlQzV0M4cnlscGtaUmZXb3pBQ1RiTnczS1hMSlVadDRPUmRFY0hjN3hWWnQw?=
 =?utf-8?B?SDU1QWFJVTlmbnUrL0FlY2NLUVNyR1I5NTRpaFJDOGdISGxYWm5DVzhkT1hx?=
 =?utf-8?B?TlJLYkx3T0JvSFgrRjdscktMZHBUM1VEYVdmRk9mVEdzeVNBUm1oUWRROHAv?=
 =?utf-8?B?TWQxWnRqeG9rTHVkU2czR2JxOFpIU1N0VGdsa1NpZFVmOE1kMVNZSTVDR2NV?=
 =?utf-8?B?eUJxRVJIVWV3UXZjazR1b3Fkd0ptZDhENlkrekJkYitnM2NnRkRlcGQyWlJw?=
 =?utf-8?B?aDZLSndvbEN6VEF6YmVSRXFtRGFTU3ZpY0tUODdVVXZGVlRWM1RuTExQd2NY?=
 =?utf-8?B?a1VtVkVLdHhKV0lwT0VSUVh4azhJUUUvSUJxRzVEbG55TE02R2dqQmtQc1pk?=
 =?utf-8?B?bENWYktIak5rN2svK0YwYm0yWjRTbkl6aDJiNGgvYlpMQUUraHZGYlB4a3g4?=
 =?utf-8?B?Y0l5ODJPMEIrK05JaHpYZVhtWVJ5djFRZGtWamNBSHBINU9PZldPWGF6NmxR?=
 =?utf-8?B?SDl1Y3RTSEpZK0UvRWhHQ3lqaGdBbEdhbHg1ckQwV3lNVTNCRWVINUVLM00r?=
 =?utf-8?B?ZXd2UmQreWJzQ3NMUUt1RnBJRW1UU3ZuMG1aQ3Z1NFFZNmtldEd2ZWhIdVNh?=
 =?utf-8?B?WVRVWW5VVkhMNTBaeStrcG9HdkMrcHNUSVNJaC9CSnNVT0xjTHN3ek9ydU85?=
 =?utf-8?B?b29yamZpOXI0Y1pvcUM0YlovK0lyb1UwSVRMZWE0UzdZcUF6bFRoYkw1MThC?=
 =?utf-8?B?ZS9vYkpIQzZRS2VCenBoeXUrYlNVYUlheGlnTm9kdEJIa3dobnRwcDErM3Zl?=
 =?utf-8?B?bHFXRFBnVUhOTG5welVCZU9oMENJY29rNGNKeVF4bzNxZXRReUdpa0w1RkVM?=
 =?utf-8?B?Q3hLUCtEbStqeGFiOWgrTEwvUnFvMzJXdUZETWs5ZW50RWtEb1BtNHFKSTMy?=
 =?utf-8?B?emxxQ3VhY2x0QW5rbTl5SHN3dXVsNlR1TDBNQ0Y1TGZRWkpKckRQWTJYQ09i?=
 =?utf-8?B?RnE3L2hjNGJLWkpWMERuVjZNR0hzRXI1YU5oYTRWdXhuL00ySStTMHYzT1Z2?=
 =?utf-8?B?cTVHZGJDUlRKSmprTEZnaFFLV1k3dVV0MmY3VzNPV0JrRm9VQTJZempiVWlo?=
 =?utf-8?B?cEh2LzBFWWNxcXRFVU4zYXAzK2MybXozVy9ubllhNmdSeFpzUDl0bHFhYzV4?=
 =?utf-8?B?Vnp4d09veWhXQ25qWXhBZ2hReXFnRVVySjdBbDI1TzJZNGlrdGdkaVVEY1V0?=
 =?utf-8?B?UXlXeHhKdU1jV3pleERRc0VkTWdEdUdqK2RrZGNCbW8rMFB2RXVsZU95T0pF?=
 =?utf-8?B?ZjFsQzd5dEZ5VXdpNGJrb3d4ZG9Lam1GN1hyV0pMOGZDZGFTK1U0c0VhUTVn?=
 =?utf-8?B?NlBsSDd1TmlLMDJsZjhYNVc0ZGxEZGlSVVFJeDRTcnhwelp4TzdhNGxXR2Fi?=
 =?utf-8?B?aHZjZWN3Rk45ZTRrWklMaTdLdzlVRDhRSUhNL3owQmc5K1prQk1RMmg0a2xm?=
 =?utf-8?B?NktCKzR3RjNWSGFzckNicEZjVGxSU3NYdFNhUEI1Y2pxQjhxU28wSDByOWF6?=
 =?utf-8?B?RTNXcDdCWVZkZTAwM3pPeVRHeko2NmUyVG9ocUE2enlVV2FBNnpzTjUxL1hT?=
 =?utf-8?B?VzRlUW9SRkRyV0xkbkdqZUhVQVU1QnNndDlLYlVqdGwyKzhROFVZeXkxa0V1?=
 =?utf-8?B?YXZhVnNiVkM0a1ozRWgxZW9ZeXIwako2dmVkWHhJalRiOTBKa3YwNUJwWVdy?=
 =?utf-8?B?Y3pKUnEyR0NQY2p5djVKZkdST1NtT1NPTzdrYlovc05KbVdqcDA5QjhER1pj?=
 =?utf-8?B?VWQyK0FuZ3NRRFNja3BGRjdLQitRVGM2NkZET2IxcUNsUFFiOW9wbFpuaG5X?=
 =?utf-8?B?emdHU3A5RkxVbXVZTVVNK0FWOGNqY0d6L0I1T0FVM25WaGlNaVl4MVhmdVZF?=
 =?utf-8?B?ZWxRNVJhYzZOTitwaDBGK0F3SGhkL2QxTDB2Z2ZWZkhQWmhzdnBpVzNyVUFB?=
 =?utf-8?B?bkpTSTRHdURWNHZDSHVpa2xVNGgvMnZRS015QldtZXZGSWlRN3JEZE92YW5Q?=
 =?utf-8?B?S2RmSjdxNWdCKzhBMjNEM2llR2tuS3Qyb2xiSXptRkFvRUtvSXc1S1ZHV0RC?=
 =?utf-8?B?czlIUUJFZ0pGWDdyZnovb2FyU2NKR1NEYU1WNHp2Lzh3azRXTFZxZk1pT1Vp?=
 =?utf-8?B?Q2E3YkNOa3pXRnFIZ2VJMFRhYW41MUJGZmQzdE9QN1ZCcDNrVkxOTWNKOEpk?=
 =?utf-8?B?MlROT3RjT3dZUy9vS0VOSzVXSnVTS0pWb09ISTI5S3lKUTA3aGF1TXFzSlN0?=
 =?utf-8?B?VHA0VUdET0x1WTBuU2FRZGMwRVM2cDdSaWJUaXl1MDZhYm85THlmZz09?=
X-Exchange-RoutingPolicyChecked: mBMWK0dw+wJdFWSTuu21S4/lhesXk2Vg3f0kVOwCglZxW2wDMLaKceZmIkO8jnRz0Dj2WcCrNn7ny881CSCg05AMiqWAQ3mMsRcc442PJg1keNbBwCDey+RiWuP6Mdl6xreFmJO+71P8h+ESTK3I84XmXCV34YNplGGbfjtYHzmpu7JELjumWb0Vyn5yUCGwOr+a8tbHEBnb1Qv7AIY5prOpBh7b6Sy/yOGrtrCCK6WcVrRx61fUIdrU02ZRLycw6zmx/q8mm556W46WGUBkNAN9bPL5ZxEqnbzNWuQBHyGLtnkBw9LxNrEg6UBcNaXuIgmKYDqzKQuu7NFcO5w5jQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cab0b27d-3601-4ad9-ecbd-08deb22640fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 02:04:10.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NvwNzOLp6Oe0W9AWDSn4fZTNBIgxpLW7dFEtXvfe8HalmPOzOnlHlP1pb7M38rt+w+wGPmQaW/HCZjolI+I6M8XFj5LxxpXba7AqukJnMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com

On 5/14/2026 9:04 AM, Paolo Bonzini wrote:
> 
> Separately, it's possible to avoid hardcoding APX by passing a mask
> argument to fpu_copy_uabi_to_guest_fpstate and
> fpu_copy_guest_fpstate_to_uabi. KVM can then pass
> ~(u64)XFEATURE_MASK_APX.

Yeah, that’s possible, though it also needs to ensure XSTATE_BV[APX] = 0 
in the UABI buffer to avoid:

	if (ustate->xsave.header.xfeatures & ~xcr0)
		return -EINVAL;

V3 previously handled that on the KVM side. Then, V4 moved it to the 
x86/fpu core to make the exclusion more explicit.

Another option would be simply leave the UABI XSTATE_BV untouched. But 
then a few sub-optimal behavior remain:

   * On UABI => kernel, APX state gets copied twice: one into VCPU regs[]
     and again into guest fpstate. The latter 128B copy isn’t necessary.
   * On kernel => UABI, the generic copier zeros the APX area even though
     it will later be overwritten from regs[]
   * On XRSTOR before VM enter, APX state restore becomes redundant since
     the entry code reloads EGPRs from regs[] anyway.

That said, all of this happens on slow paths involving userspace 
interactions. So unless avoiding these still keeps code clear enough, 
this falls into mere optimization but with negligible practical benefit.

So perhaps patch7 could instead carry a note like:

  /*
   * Both functions copy APX state into each storage: VCPU regs[] and
   * guest fpstate. This is redundant, but lies on a slow path with IOCTL
   * handling already. Avoid additional tweaking of the generic copy
   * function and userspace XSTATE_BV, in order to keep the flow
   * straightforward.
   */

  kvm_copy_uabi_to_vcpu_regs();
  fpu_copy_uabi_to_guest_fpstate();

Thanks,
Chang
