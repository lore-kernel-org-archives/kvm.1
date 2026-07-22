Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E313AEF49
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757317; cv=fail; b=X32DGD2REA/L0JbxuQYoq4wBfbojD2qmORnwBER1jvIc0nJJyrKQJ5/LZOUdLNIUiITEkirVJpWYRXjjf+YoYQhRjRRLSmxHSlS/ecvZPkxDrWwg7gpxmjGwLvM4abRahp1Zhr1NOIFTNpGQUPzmQ51XBrrn/3mUVB/oIYF/BRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757317; c=relaxed/simple;
	bh=RqxaHj8asxMZf08K9Acr7o2K00Dq7XnFAlS+79LRUxo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nEy3OuwNhB3/3iMeDhODtT5ptq8BlXBDH5e38tS1SYgyT2MOWiPTDZeScm0vyeoarroleu4avwTKs9yf6T4SXA77QmuK7hltrm6mYCks0w+4i1xFUx+8j0XQCNcKRP4NNT5cjFf8DyzoGmnAVcFj1FEdziQdtJgF5A42rizh3OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8bCFv6y; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8bCFv6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757316; x=1816293316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RqxaHj8asxMZf08K9Acr7o2K00Dq7XnFAlS+79LRUxo=;
  b=l8bCFv6ygiUrPEZ4GAL6RUhoG4vHjq7hLnrdTLh+MnbKOO6k2T5Z7e2w
   FHgqQm+M3S3aHwR8afPIoqsUOkVlEULXAnK3LFU9n8aTCACON3JJXdMsb
   IhZ9mR9NQKSvXNtAYMhdrQH2J7RFTYKoYNzNs+FtLkbodcYC7xO/MwMt2
   byiaprdFkIA1vRIbFjGRN3OzVw8tLAg9Rawe7lY/wUgVn22gWv6h1OEmZ
   U1o1JzfqqGRXh/U3e7vOU+9ZoIHaI6IhfKY3ECFFYclcH/Lo9ELzj1AhQ
   MnXB0xfiwz3j0fPo+rAZflD6OhfniUmh0CSDlq80GQRkjogUNwKJkyebL
   A==;
X-CSE-ConnectionGUID: aVFVKfuMRLSC8w7Nii0/Rg==
X-CSE-MsgGUID: Yzl7iFZpSJOCtOl+T3C8uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102950783"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="102950783"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:03 -0700
X-CSE-ConnectionGUID: vzJeEiJXQPajSWGSg9xqqQ==
X-CSE-MsgGUID: uNBhepdVQEuX9E5raL6v8Q==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:55:02 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAYelAhZ/hY1P81N0MSX3OX7RwoglB7JPriDvNNR+IIVhKoxI5icsVFV59nKl8+1FUSlGZFuPxLzjbOo9sCO1FH/oqdy8JiC/Cc3I3bL6c4dJZbml3o/7spufw50KqV44FqmAOm1Uj2Qlw8kzI1D+nlIeCHwWN9rZdhIxHoq0gmBLsFdeRtjpl+qeMY82711iB5A20szxBc647dflm2NBjhQygSci1nEX8vT1mDSIJiVEGMZmOwJ8sz/v2ob9bli1YisH2gvjSxI/511kqlh8dV6j5RV7w1a+C5eW2MuRCahujDvgGH9zJVRFh/nGwyJCf32Pgn8sgQETLzZV7TIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBODdXrdTv7Peb9wbRn6aVUtWyiByWaF9vck9C/WuDE=;
 b=L1i6cej7F9XNH1Y149y86rpNqT3F0zYFZHh/M7SkQqsXPzDxT5zcJTw6vu/MdIj3j/eM7BwaJioK+SEFcfQgrffyN1LtdqjE1kvJiwit1zKQb5X5BSp+Kmh/l2P0zgkATHMV5COFTw3dTfrluiPgAyGaUOK+r4pqKTP6x/Qgcr+Gl/3dpT43T0GaTieMNQpGKBFQuwmdmG0NeIEmSAPimucTq5QrgPhbVKnHmbiba1KAyZkxvUxKkGkgv2/t1q0sw0DtHwcu9re9RQurbx4FXvATVqZZtOLr4BpdW42YJOwDX9aKpTMMwnUP8vDhRvPMA00QBMeEabbRRx0cieom9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 21:55:00 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:55:00 +0000
Message-ID: <916eca60-f19d-43b2-96b2-b63943b3f3c5@intel.com>
Date: Wed, 22 Jul 2026 14:54:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/20] KVM: VMX: Support instruction information
 extension
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-9-chang.seok.bae@intel.com>
 <20260720181256.DA5711F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260720181256.DA5711F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 892b5687-933f-4397-a908-08dee83be0a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|4143699003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ta+c6oLnoUNgzj7ziHa/nrWr1LEVi63VOkOgTdwme3arizX4/GEa5pw67DpGP4N3XVms1LmHwlCn0CdlQOSfUssKwWwzSytDuN78T4A6QmxHozG52z6mdvJa5QRDc45s0zcYm7evigkcl5ROMGskeinlsuT6oyrr/PzGf6NyFRjAKrrCMKAoV+5bIumOJ1srScVgwyL6nC5x8lNiHzWfUsIOgoYJpewy4tW4jjGzDgacTVra7ZAx0Qrl17wiLpHzjq+OEOzO0ciaOdGA/E9rJZYqHRk/e+7xBNiDSEDr0EUC5xq1Ejn2p4J3DheymeDbw7Q9PFOVNqgSnv0DCIOWs/q03/qd518Vz+osPn2LnxAuUg11uSj3bazfrQ4ni1fS6qbSJ8mgBSlK8MesggEFEatEl74+e0l5Fgax1ZLOleR/hJh1xexZ/krRDL8jpIaR2Pzg8sclZ1ioLLQfE8kswmNlLl4obWCjVCAJDFCVgHnLMLX5l0eGv4yNZStmwXgbfgvmfO2+4FnFuRJOOuI7nROXyV4T+6yJ9WGiiunt+o8E6HWLqY+u6ZZFjbC5oQmNnoe1ik+oeKzke1yGBBegGo8WGivV7/iemcG3QI2JaF3JNFhAtUJhsu+IPPXKyyvKRddJvrqW3X4YaBKQEDoukioqPEonNMkvDCEeEnqpS2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TStRY3V6UzhGMlJueUFlMHk2K1FxWXFBcVFvaEZyb2x4Wkw4MElYWS9zR1U5?=
 =?utf-8?B?ODVPQkhxQkZFS3Z1QmdxSGRBdmRuZHh0MkZKZGdYbGxFWmEwem5jZnNXeGxO?=
 =?utf-8?B?U3ZQMW9EZWxGQ0hnVlNBU053Ym5ZSE4zd04yTlB0dk1YQ1NvajNKMkdaMTU0?=
 =?utf-8?B?RjdEekUzYk8rNENYVUZqdTdSYUlPWkdpNWNEbjlkWEgrTUl4SWZRdW9YYkNz?=
 =?utf-8?B?dFN4cnJBbFdqN0ZEaDZIeFdvYXdQOHFYeUNNSnRiRDBaOUtqMklXK1BGUDY3?=
 =?utf-8?B?RHpTaHlYcnJNYjRKUWhxNkxBRkxZUGc3MHpoQk51dHhiRE94aC9nYWFuQXQ5?=
 =?utf-8?B?dEhOQ0pFWmxtd3ZCUDZKSHRaZFNkR2NYTFZGTGgxb2hZWmFJZ0t0Q1JYQVFU?=
 =?utf-8?B?Ym9XWC9lZXZEemJ1enFzUnAvd0RkTUdIYS9UaGI1RStsTThraC9tbUhYQlYr?=
 =?utf-8?B?U1NuTWNVY3BvNDUrTTN0L05KZzR5UVBEc1ZQb080TVhCbDc2d2ZOMkJhOHRO?=
 =?utf-8?B?VFJHazlWdVpxVDFtK1JGWi81SU80KzdmVEhZTUZMbDg1eG4ySnRKM25vVU5W?=
 =?utf-8?B?U0xlMEVtUlVlSFQ5REw1d0N4SlNUbFVkeXE2TG5Fc2hVL1EwOVpVZE9uZ0h0?=
 =?utf-8?B?dWFnNXNkWmxtUVN3ZitOQ1JWSjFnOVFKdE0xNG4xNVNaS2cxSzJ5SmpkWllN?=
 =?utf-8?B?Vzl0ODJYak5jQWEwMktBQlJNOEhncFpQd2ZtNWhKVW1uL0J4YkFDU0tqbWNs?=
 =?utf-8?B?VFJIaXVHTCtwMVRKblUwd0gyYW1LVlNEL3NMWTY5dG45NDBkaFNlSE51SkJK?=
 =?utf-8?B?TnZwY1l6K1FMbjY5RjlpemdRa3hTOG0wVFl0bGRDMFQ4RUVBVEJsbGtrNU1Z?=
 =?utf-8?B?QnlUenQ4T0p5OVZIaFJHMUwxelhTSnpTZUQ1SEwyY2R1elhQWTZNSmtpNmpD?=
 =?utf-8?B?RlUyaHJMUGN2Nm5KZzBkZlpETWdUdm1PVUdDNW9ZcHlIRnlRZkFLblAxYURG?=
 =?utf-8?B?M2lpdnQwNHdQZ0o0ckpKUkRYRTVZcDBHdG53Zzlkb3lSUnl4NnFQYWh0bUhx?=
 =?utf-8?B?d1Z0dG1UZUFaOFA2YXNWU29HbEpRTVdUR2hyODhVTGtiT2lmWUVvdm1TRmVi?=
 =?utf-8?B?V1dueXZmNjBwWmRQWUdvREV2MmM0cFNsRUVMSklrVzNqdTlMcUFDQXBlZklZ?=
 =?utf-8?B?Q3dWVDNVNzFHZWEwSk9TaUZ6NXBYOEMzM3doOVhOUVhlN2pldTlkdzdta0Ux?=
 =?utf-8?B?eXkwK01CK3c1OEhlUHdJaGV2K0V1aEVsTWJTRTc5ZnF0V3NFMEpWaTVoNk9X?=
 =?utf-8?B?Z1F6aHhhMUV3QnlDK1VDOXFlT3dzcmZxWmZJU2xqTFRpSGdXRHdkMjg2d1lN?=
 =?utf-8?B?L0VacXlyZkgxZjMyT0wycXkvNDAyY2FwVXg5SGNyTmFhNkI5NERWQ1EvbFlG?=
 =?utf-8?B?akpyUlREZWl2QTlqZ3RiN1NmUmp6U09pSmRTWE9UQkFmRXdWM3BtblpqZWo4?=
 =?utf-8?B?WmlxUG5uUXlRTUZzZ2sxU2hVZlI2TFhRV3Qvb0pqNFBnSmhlRTA4QnhkRVZY?=
 =?utf-8?B?UkRsaVRLeGpMRlIzd3Y3K1dIVStOQTZXSEQxWStyUE5XbUZKOXFnQ2xIRlo1?=
 =?utf-8?B?N3I3dTNUVVJKVW1nWHJNdE5pOVZHNjVyc0JWQ3ozT2xCby8wT0owSjR2YUtr?=
 =?utf-8?B?Q2lGVHRYYjhGMktlWjViSHNCbEQwMmVidnlUYVdZMFFyckx4WUNReEliY1Zy?=
 =?utf-8?B?b2NYSzNCOGNxMlZlNTlZaDBPdDNSdld0MXNweGVvMi95R0FoZERWUTRnajhp?=
 =?utf-8?B?eEh3d0pFVDNFNnlNYW9yby9BTW1keWNqYWwzZDY4MVBwQk9Pd0xhMm14Sk9C?=
 =?utf-8?B?VVBUcGl1TzNkMFc1ZzZFOUNkZlp2OFBJcWxiUGgwYWJLZ09uVWZPcWFSdGJt?=
 =?utf-8?B?eUxIQVlvZ1ZMeFVpc2VrNmd5V0NCcnJDcXc3TjZmc3NnOWxDL21OTU9IVWEw?=
 =?utf-8?B?NC9PYTRFS1lINWFBblpMYzNUb2FDczBwdGpXdXMrY3hrd2lvbDMwRUZWcXVu?=
 =?utf-8?B?UUQ3V3EvSStXUldFeHNadFpQdGZmQTF3QnA3aWRPVFFuMlV5Q1I1clROSjV5?=
 =?utf-8?B?QU9WaGRTeXFFV2djUXlUajBteXdSc3k1aFc4SnhvSEpFZnlpYWxobHN6VTJs?=
 =?utf-8?B?V1hOdis5QXhGT1ZZYzV2eUtMbnF2dnVSMXhML0FsamNmbXVranQ1a094SFhU?=
 =?utf-8?B?bGVKR0dMdXlPaTBtTWh1alhMN1VmVnNQKzB4dXVvdDdPaDJrL2ZyZEh4aStC?=
 =?utf-8?B?NUladHJ0Y2IrcmxqS1JzQnF3ekdqZUQvamVrN0JNT3prOW8rSzJuZz09?=
X-Exchange-RoutingPolicyChecked: TOe/xvOyGTfVZ9pAym6m8Tkhs94tSj5xMNyzvPRMl9SkzfgjSX3UngkM19jVKQJZXWBWjUFiwOccuToukOD4t/KsQ34xzbsV+xKZZDhlNhRHOmRP3kF6Otib7hER9BBYpMWFHz0Iv+1i80RGzJ+gTlseDXALMIkwZT3XCvDBWjffaXg4+yKv6NKAC08qk3xUV39wEd4apM57uDB+9Hbimija8mZB8ol9nPgyLyVZUM0arAjSnh1OBuicQ+4nJuelL1h2vCy1XUSquHw0tNqCpVfJT5W2V1rOFHkAgthrWsY+XSMs2qYK6EdDlda197SZ6WwIl1kBNY4uhCGk5Gbrmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 892b5687-933f-4397-a908-08dee83be0a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:55:00.4380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4HWsoV0dwSfkyC/H5O/8gg/Kd59F2n4fg7VaIJJwEi/BU7tu3Z6E94afWZ6AdtpLRQjWo3lWXazRWHSB1zvLzfI3+b1807Fk3KKhw4wny8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

On 7/20/2026 11:12 AM, sashiko-bot@kernel.org wrote:
> 
>> +	EXTENDED_INSTRUCTION_INFO       = 0x00002406,
>> +	EXTENDED_INSTRUCTION_INFO_HIGH  = 0x00002407,
> 
> [Severity: High]
> Does this break nested VMX instruction parsing?

This is part of the preparatory work. Nested VMX support is added in 
patch9, and until then the new field is effectively unused. Also, this 
ordering `VMX changes before nVMX` was received as reviewer-friendly as 
per previous feedback.

>> +/*
>> + * The APX enumeration guarantees the presence of the extended fields.
>> + * The host CPUID bit alone is sufficient to rely on it.
>> + */
>> +static inline bool vmx_instr_info_extended(void)
>> +{
>> +	return static_cpu_has(X86_FEATURE_APX);
>> +}
> 
> [Severity: High]
> Can a guest trigger a host-side WARN_ON_ONCE by executing an APX instruction
> when KVM is compiled without CONFIG_KVM_APX?

I don't think so. This series is practically on top of the existing 
kernel model where the host itself does not use APX internally at all.

>> -/* A placeholder to smoothen 64-bit extension */
>>   static inline u64 vmx_get_instr_info(void)
>>   {
>> -	return vmcs_read32(VMX_INSTRUCTION_INFO);
>> +	return vmx_instr_info_extended() ? vmcs_read64(EXTENDED_INSTRUCTION_INFO) :
>> +					   vmcs_read32(VMX_INSTRUCTION_INFO);
>>   }
> 
> [Severity: High]
> Will this corrupt KVM's instruction emulation when Enlightened VMCS (eVMCS)
> is enabled on Hyper-V?

That's a Hyper-V specific integration question, which should be 
addressed separately with another enabling series.

Thanks,
Chang
