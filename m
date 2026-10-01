Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B414756BB
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886431; cv=fail; b=LlTUwKjwRo00Q6uNIxAVNhUS5Bfzz8I2xB5GFbfnNA/CGr9/W+sdnJhqcCRcmBbOTjU6KWGwEl1MQl7I1h1a7+toupKeYAmKEa/t2nExePohyZk8ls/hdeC9ctqxn0o05WDgFm2lNxm+rC0fNTc6suOZU9FryXBI7+LswOEbjCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886431; c=relaxed/simple;
	bh=B504UzveEx2Y8BDpx59zJ/BiYGCfqdk8XgDUz4FrYko=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eov9n1whOxdSONPqkn60LX4+IvscBcZLAxENlp9GjVyqyCyRR2D7SfU+XvtDYQaycV2DQzxcyMQKSjg9wkL0W+Xhfd3UnkQOCHsUZcJpTLZBKECospuukT2BBrvDBVAirAZrTVazfqnWEqMpFr2kbUon7IvuAx8jWrrYM2ti5DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ig2y8PcW; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ig2y8PcW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886429; x=1822422429;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B504UzveEx2Y8BDpx59zJ/BiYGCfqdk8XgDUz4FrYko=;
  b=ig2y8PcWVzsgheJBWSq99zDDOOa8mQu4IcFKoTTLlqGuhTw08yDedwjq
   wjGWDf0kbSHI9JYcJjczI+q0zR0LUGUXVVi9n1gBu4ac8ZoQDokGXTzy3
   7PecW3Eb2OBjkCYuEEjs7qGs2jfR5Hp0PrVwGeawHhwgNmmJesn9HSsBr
   2ORMj+3xsyjxr2G6TxekmTMYqOwGNRrMQ1wcNPK6BO4/UHOo6Gc5eZhzJ
   hqoV+aM4igZfSBDfMTnEN4kwyabESqktUYe7jRbH96TauW7Y2evX9bsl5
   trVcCybMtBrZSR36oZMZEZ1m4cpH/XFWgqOGhiFcTDzsCsWqTlM2X+Ckx
   w==;
X-CSE-ConnectionGUID: XiW8KpkaRRym6FL/UMQlUg==
X-CSE-MsgGUID: 4YGI3JrWS3eK3ysduU0mag==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90516359"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90516359"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:27:06 -0700
X-CSE-ConnectionGUID: ADfFzeGFQJWz1upL6SNWbw==
X-CSE-MsgGUID: wkx2iBDySXiM0QjyLuTxLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275199860"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:27:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:27:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:27:05 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:27:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ+UHV7Gtn2c7HllswB/Gh75+WlFnxZrLeXJm5bV0q7xb+ZtW8ap0a12asPHn+SJBiX0MCqjXcjuyg+Rger+v0qcLsn1MR4LYHNP1rOjmCKdkhlJuGRavtp7edbNF1Q4kEjKncKZKisdoBkG/0UPlUUw7LjdgVeOdWw160y4WKbHlRXGT3H49/60MxN5qY2+tBf2roPuECOY/6xCp2omIY1pQcbffdP9DVBJAQVUa4NVfspCdWXD2Z/PzxOh75Vsk25xP+E4ms5LE89nTCoIaClOBeKmrMFMqRM0DuQEC/44uyXGL1Do/bIFh8QooRYkr+P++PNge6/o1bg64ORBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YImUV2BEosVNFkHnAtJTFjkHeNijUAVQ0zTw6KxfWM=;
 b=qVgZ0AD5Tzrzr5qQLDyZ3fNcdHDQo1MfiUBxVh1aIHz7NSTkCI9D3NqzfWxfNlETICzMRTkeEC+JUs7TGluO5M2DxZAkd/t6T8fHObbMFejVMNkxg3IoB+amYt8eAk7jg2qwPY7eIeUBmmMvkzFaLDXYYhis7P8jZpOhftZcFd40E6QKRZ6Df9JAPyuMC1ZPRDBlihoGdBmg9dd91mUrvJfenerDrlTZH/bI4vLp5aBNkkTx8PElWUuvwOXUgRNspN4JbJ8RSnaL/znYZ/ZK/YN5sPa0UOBqMoSHw52CfnSY6/+xhK6KNyoqd69VKVhVxSrOxsP95upQvazGUCjj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 LVXPR11MB9708.namprd11.prod.outlook.com (2603:10b6:408:388::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Thu, 1 Oct 2026 20:24:58 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 20:24:58 +0000
Message-ID: <d74865ba-e955-4ffc-bd85-b72ffc6266f7@intel.com>
Date: Thu, 1 Oct 2026 19:58:03 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 03/20] KVM: x86: Support APX state for XSAVE ABI
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-4-chang.seok.bae@intel.com>
 <20260930215732.4F6A51F00898@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260930215732.4F6A51F00898@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|LVXPR11MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: e795b5c3-e128-4f0a-0e95-08df1ffa0fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: hhVjqip/me4xQsZt3PCPn2JgCftT0z/3qctquFfc/ksromsp4p0BMnB3TYBajWdaXw9dytZI3vLaW1Ay7Fo+JJfCQt4AbqqyIaH8bFkMniAZbXr3GIf7n68zdm+QPbz2DNuUqaYpm9AtvmiI/1FKP7KFiFlltazzAjdIIrseTBygbcH7ia1/2nV6GtBJD3AiFk9ARkfGonVVL22FQW8w4qpuwUp1GNu6JVqRL9EnV1sPabq3BhpcEKjRg+F/ufgff39HQop/2cCwuzh6BTBaFj+xS0kH0UR1CpZSW1w/0Is9u7raDbRUwA+iZyEslVDG+Ac/3d1OAk0rFdx2dCa2QcMQqJAvcXLGQGlzPYq5OeReHxwGmvWq/Z5eTImiLKvY8xRi8KEvK4amctQ4HIGFk8yufV9Y8hetrIBKj+C/36CcCDgZ7sKDmJt9lCemKzHYJjRyJQ/EszF3+I4ck+CkPbbjdNslFVAnWrDBHPNWtpQSZ2wiA1m0I9h6YkAkXpkSLW8lyM9Yo5dXyxmCRg6P0NRxKrEmhK3ZDM+g8K0qKqoBOx7dTCZTbwqoeqd9a+nWSPg1togs1xwJpflMEMgZSAahKHFOG8ZjXeb+6seo8NhBZX9ZJEhM8IUbK6oqbCBlJ2lO2+LLEUVxGXjgBzxY8Rd8+ME8cTCNRrTCsHD+nYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdmU1c2Sm5iNHZ5VlpnQmZka2tNeFpVVUtTUk8waUpoNUZmTXZnRmdFV0Ew?=
 =?utf-8?B?MGlTMVg0dkZnZFphMmx4WDdDTExRSjZ4OUhMalg1UGsyWlc2cDlKTUhMWVp4?=
 =?utf-8?B?UVFNOE5xaTZNY0ZLLzd6Rk42MENSU1lHZlc2aE5uRzJlNDJiUTBBTDl4UVF0?=
 =?utf-8?B?aFRXQitJK3VLeThzZWxLNzdMd2YxSDBWd1U4TjRIL1hUSFd3VnNUMWgvK3Rm?=
 =?utf-8?B?UUxSRm92MElQOVd1blhwakRaUzNvMGFUTi9NTmR4MUN6V01uNm9sZit3TG0w?=
 =?utf-8?B?RDNnbVdnaXRXdE1VcHkxaTBqUGRCS3BJUXNjRGVnWHRnSTVIRFg3djdZZTdy?=
 =?utf-8?B?VC9OUTJCNWJ4U2swVFlmV2hoSUJLbFN2a0J3Z01jSzVjazMra1ZIS2tkMDd5?=
 =?utf-8?B?NUhxT1JVOEhWMzlhM21wTlhadnBWSEd3b0hkbnhUV041bTZuaUhIV2FkTkZv?=
 =?utf-8?B?Yk5Xd3hTM1pDNzBrZlRDUlZyTE9kclhKWko2b1dndFNmQkw4MWtaVm9CNUtl?=
 =?utf-8?B?U3ZJNUhPQkx6RzllbHFESWRRTkNHaGJVVG9RTHRLdzFvUEJvNnNjQmJsYjZI?=
 =?utf-8?B?WlJjQ2ZrZVdXc3FXVjNtRHA2OFBaNU5iWHMxaDNWa3RmRmFkdDdaZlAyMmxm?=
 =?utf-8?B?U0RMQ2s0Ty83ditnWUlwM2p1VG1KdDdoNmNkSXhDYnM4Wkw1VWJxbCtUbHh6?=
 =?utf-8?B?eDNIZWNiSHpja2xLSUdoWG5QNlpNTFZXOHhURGZhUlBxU0pCTHB2Y3NNYUpx?=
 =?utf-8?B?L01GS2NXSHl3MThrbnh0M2c5bVZIWlQvNkdNQXRmeU1lSWM4dGp3U1Y5U2g0?=
 =?utf-8?B?dTgweXROQWNrMkFPUWJ5VXpzTytOcXBtcVk3YnFkRGFwdlMyb2traEw3UnY0?=
 =?utf-8?B?ZVVHL01zb3RteEJxV2JYc24rc0FncVJTcUt1TCttVkFjNy91MzhucUpiNTc5?=
 =?utf-8?B?anBlWVNWZnBaVGlieW5KT2FNZ1hOTHZac3FwbnRYczA4VkVHRVdzT2Uwb3VW?=
 =?utf-8?B?Rmo0aHJzbnNaS09pWE1QeVdMV1hSTzRrR3dXYkV2cnBjczhxQldFeXdJU3JC?=
 =?utf-8?B?OWNocTBSQTNyaXlGNUVYUktDZTIxMHIxSUtzaW5mL1NyZzF5a0MxbnNzMHZM?=
 =?utf-8?B?bTJxSUZocytlelpoWHQwaE9CUHNhTU15R0ZuMDlNTWpPWm1nQVB3dXRIL1gy?=
 =?utf-8?B?OUU1WFQ1bkw1NHl2U1hJdDdpeHZmNjI0OXhveHlmM3lMK1hlcGhwbWVSUzNr?=
 =?utf-8?B?b1F3ZDVpOTIxcmFURXFqTTVUWCt2aCtkVm1sa0dlamQvVTB6dy8wZzFGQmpw?=
 =?utf-8?B?S24xb2NTOEpWNW0wRUk4WTR5cmJONElSZUM2M1pjdWk0VHJGYkxESDRIc1pR?=
 =?utf-8?B?eDhYVFhQcmN0dnBVdExONldoMzBWSTNoRWtteW1zL29mVTVKOE1kTDdqYUY3?=
 =?utf-8?B?eitGZ3dPRk84VDRPQWU2L2s0allHZHY4NnpId1NDdFVzNzQ2QmVUaW1OUU5t?=
 =?utf-8?B?dDdXcjhmOUd4cnBwRmh3ZTUwUlFEQ2JIVStEU2ZWMm4xZHVQV3ptWU0rQW9Q?=
 =?utf-8?B?UUpJMEh4b2taNHJCcjdUQndZQU1rVHg3aFZCQnJKRXVqeWM3c0NjUVpzQmZ6?=
 =?utf-8?B?b081djE0eFc2RFVVY003bkdrYllralpwV2pibHQ2Q0hrcGZNaW1zQ1g4WnVI?=
 =?utf-8?B?ZjEvQnhJQWxJczQ5b3VsTHovRjd4bGFKMHcwQ3grSnZvQmo0dkUyNERPcUR0?=
 =?utf-8?B?dkdDZ28wMnBpak5xWXBEakVmdmNVN0EzVHRNK1V6eDd5WDZlSVJrMjFUejFa?=
 =?utf-8?B?ajlyamh3K3drMzBON0k5WWJOTjYrNUR3SmFwbmF3TXJ2TmVwV2NwRm5mVm8z?=
 =?utf-8?B?VDBDVFRkcm9QanJ1R0N1K2hiSnpEczV4QVZ4RnN2L1lxcElVMVV3T2V3WjFB?=
 =?utf-8?B?L0pjYkdCcVRDclB2bE1BVkxrUFZqeFBTRW0wSHY0WjBhRTBnQmg5Qzg1blY4?=
 =?utf-8?B?VE90RDdiM2FyS1h0eXFrMThTblRSYi9lc0dYYURVNThQcGVDR3d1c0x3RmNC?=
 =?utf-8?B?RlpRRUNLS2oveC9seVN6bktFdUhuSUtyWVAyd0lZQXk2TENhUlpFb1ZuNmFy?=
 =?utf-8?B?aDFQdFB4cmtReTd2LzQzdHR5SlZHdHZpcnRtcklFNU5mcndrTjREak5FTjBy?=
 =?utf-8?B?ZWlWeEN5ZkJHR1R3di9LdXRtZlpsSk5uV0dhMEZWM0UzOXUwWkhGcGU3VWRF?=
 =?utf-8?B?Y3ByV0Y0enhHTGxTRm55bC9oOEszSmtadDhWTjRRMUIvM1o0Mm1RNHlkQ2M3?=
 =?utf-8?B?cGFWRyt2eDZKc0xOQlVoa3Z1TmZyV2JyNzhVY3Uzem1vSVRGM0VXdz09?=
X-Exchange-RoutingPolicyChecked: dpWDxH5vClNHnIhMpKW2bsKHcmauKvJC+ylcuwqSFp6FSVMQvP2e9f09pavLWNYENqTUB/RsMYT/Iw5zCAzMfdOsHIi3vaauV2VpOlJO3NXGaxLW49yiVsmAvnt6gg5WsVPcf6RTNRA/JFq/o/t7EIMFiuA0PxLq5E7OZQ46PTYBVhFCc80Ap9te2VTG+tU8/9GYTDN913tSJl0W2BA3Svve5gv/o2eGMew5HM+hDLCTTgfFFAxTAKL8AIJG6piZeJpoCF8ebsfmiYXlkCnYrrK/f902UM3FPSnNcHaA8CJoMPmn+dgPDd2+YVGyzoiIon30beC2XTelA+bO6ykNpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e795b5c3-e128-4f0a-0e95-08df1ffa0fbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:24:58.0025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqZgZusuL+4Fc4SJZgvy6DwMUWQgS1NtzFRLvNIjn1oTALyKH+MnnwnAy5Q3J9fILUrRepTM5o5BvuFju0ZCsHJLs1IRRieQcMcjztIMBv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9708
X-OriginatorOrg: intel.com

On 9/30/2026 2:57 PM, sashiko-bot@kernel.org wrote:
> 
>> +static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *buf, u64 supported_xcr0)
>> +{
>> +	union fpregs_state *xstate = (union fpregs_state *)buf;
>> +
>> +	if (!(xstate->xsave.header.xfeatures & XFEATURE_MASK_APX))
>> +		return 0;
> 
> [Severity: High]
> Does this early return leave stale values in the APX registers instead of
> initializing them to zero?

The comment repeats the concern from:
https://lore.kernel.org/kvm/761b969a-2d2c-4233-b3ed-2f0f35f04864@intel.com/

I think my previous comment explains the intended behavior:

   This matches the existing XSAVE uABI semantics. XSTATE_BV specifies
   which state components are being updated. If userspace wants to zero
   the APX state, it must include the APX bit in XSTATE_BV; omitting the
   bit  means "leave this component unchanged", just like the generic
   XSAVE copy path.

Thanks,
Chang
