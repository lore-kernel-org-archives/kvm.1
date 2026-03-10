Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691853D812F;
	Tue, 10 Mar 2026 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180335; cv=fail; b=ihHBYEzicxpi1/qYPAIiIm2kwSfgweLYHME6QuhJ/1gM0a/+LitJWOD7F+GX5pKHoTVpvq+LGV7VfLk52ErfJtC1+vYhEQmhKQfBIDJY9PhkWsTaCaqxZ0goJYSrmOOYYvLZj7+kvKABWX9tXiQ/PGLz4SMRtTV5TD3fWNx74cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180335; c=relaxed/simple;
	bh=Z5meh0t8BJdIghoOdnDYeLWLf05KfR9V31TWaRtqHvI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qdLcEhbquepyaSS9lTkCEkXBrRSeV7qffAmMUy/Q4M3eS7TWF/+k02OPvtfUTPxP5GObtzHLxJl2bo9Sfs67iOxOQ6vIGUYW6J7Zai4cSQNESCV/XPRDywobl1usrRwJF/nfEydY4Qgiv8WPfr5oI8qrfSyFaFFjMaas7HL8rpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRiaak2O; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRiaak2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773180330; x=1804716330;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z5meh0t8BJdIghoOdnDYeLWLf05KfR9V31TWaRtqHvI=;
  b=LRiaak2OaE4gk0/hm2MUyJYM3X6H/y5KZclaT/LC5cdYwNk7vZC3Qpw4
   afsvOwtCVMrYU/33KNFweLKvgjuzRnbpICiYNmWidatDgWdxwYuOLOQtJ
   xADPCt+lP0rCOtXSwSYYNfYtHxkZkYzn+w3yQ5102ARds3DvMEZw/e5fh
   2MsVXsnjNSkVVeuyVihOJFE7ov8RphAcPvjD7ZW3CjuvOVb/xJmBAF9MA
   Uw+XfZyPBBU58PMUVIuyoSqkkAJmKq5SO9K+2Z5mar0PSLY121YHsSeU0
   GWFI1jQAtlqFaxda6uJrngZ7d4eqi6ApOhyqpNEDLPC4aQfVnja+PsPPX
   Q==;
X-CSE-ConnectionGUID: O04t+jpuTIujsytrh2LiZg==
X-CSE-MsgGUID: Ouz/xJ6aTz6RdjezPK0+hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73264555"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="73264555"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:05:30 -0700
X-CSE-ConnectionGUID: v7PNWZnMQWaVIxckncdDig==
X-CSE-MsgGUID: aCh3oGeATUiF2FAmjBuKPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220213074"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:05:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 15:05:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 15:05:28 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 15:05:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLW9eUmjDTd985mmsOLllhqpIM5ptXDqZgZ1iGMM+1q9g02g78NNURf70aMZdMEeEboz+/T88sYth0dmu6oFBTLUq9+iVSBLK6sT0GWfUFRgYuc6Gqk2ZJuUjpF2usAoup4QaG9xGBvOa0/vSRkSelR/PD0gqCniltWrzWvDKEI7guCgQEeUo3z7xkluuuU1/N0hPy9yVwGwcZs9SbhZgdjmV4f/EfFiCO3Sv3X37IDeWMcwTV50IJZey5AW1iCwTA4b9eR5FOoPWQyPFpB5VgQ2P8LsRhnrcW01QbeUANq+4Ny+9148Lqc53K9JYlesBNl2T9SHQwi90dPBi95X6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5AehH8leCOiliHMMO3yAsIE8RLxihg05FW0uyUA4A8=;
 b=q3dTq5iBdQXUaBxTSq06YV7QwozCq9oFvLKXTJABWiDGwPeYWpKcZH6q+JF1Lt+0DTaaUzRhmz8DR9skrtjqH/JexAdmmtYNAK4Zi9JTfZQvAVlynvqZ/2/paOpfF4wgg0/aK690ZEDY+T8vyqprhDwRj1czUqrtjcwiC68yS+HaGSFsi001sjSKL4KZakhvRgRAJLwvOmHASz9bXmMfyp35h4lVgDjuUNyQXL0MnwyTr186ZzULlh905RHQFq0CC7+el7Sa37BMCJX9MmIxPZrSX9pxrsv91A1NWqlVD7w3mSkBOJq94OOaJ+lmx5NCtXg8p+20zF5EL29Zv9WqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Tue, 10 Mar 2026 22:05:25 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 22:05:23 +0000
Message-ID: <31093743-97e2-42a7-a989-84704f25f40e@intel.com>
Date: Tue, 10 Mar 2026 15:05:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] KVM: x86: Rename register accessors to be
 GPR-specific
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chao.gao@intel.com>
References: <20260112235408.168200-1-chang.seok.bae@intel.com>
 <20260112235408.168200-2-chang.seok.bae@intel.com>
 <aajd6Fa8gHz6lW78@google.com>
 <b5b9efce-9205-4282-acc2-380d348c4f50@intel.com>
 <aa9ym-SWeOdTrz0O@google.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <aa9ym-SWeOdTrz0O@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|BN9PR11MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b3a61c-7c8c-4d79-2ef9-08de7ef12087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BBCwpfcLu0pCeLkZNsQ/N6oTLryjom3MoJAXS3BGEUOUhYgLwnybBtAGekhurVKvVBYwhoN0QXK39Ernj0x2Fb4KCtRGztYKpcqOSpyQ+8k0dqAi8AST/yl8zEkBtWnQ5RLEuI+vMQ9dOeAq1/kXjrnT6xtFd9Nl/gxNj3t0FIx/yewyTGUJBFwK5NODyQlunZNWQWwp4P9WtuDMCXJ52ubZhTMIwyHK5Wo10khHGPYaL5q7gauN8dHpn2Qpf37t+RdfMQMxh4T3dGi4bA1mNoXIWRFOEWngza/sixJu+P73UAPmckjuMCeP/PTmHMrOW0yUQnX0N+aPhxGycf8YSTbUrkaYLNab/SuaM8z/mhBQU3HhtH2PmlSSfeeTqv6orX7DsuD8Ij13f3Q5+HNEAW0PTvhSfqB4BdmkeOKn/jJjv2VwPThxQgRkoEQPx+KLc0xOTAdYIGEmhjZOUhxzBdMsw6WCp0l5etP/wN31PF5aaZyF8P2MMeIRgaDGBSYvuNcq6lZRtiFplvld8dW8AcJLrnY1n2EuqeG1G3/VRE0iOgtlnR/2V8CXIZvzEqpxchvHTjTxrG+6ufrnfF5lNo6gEjueAENeSRjJ7UMa38DLQRFVcb1Dok/1CaJplqt6qOuFCGgDbvh0DEkl1tv4+5Zm+QB5n06X24YyykeCg7AW48VA12N42yPbfJ2QfRtgIdS72vbq1kr2mtWkHVIShaoLv/Y+vySogX70mHNLbKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUFJU3pEd083U1ppZktuYjZqODJwQXoreHM5Mk43YldRa2htbHZ5b2JPSVg5?=
 =?utf-8?B?SmtiOTkvdHJtRkpEMHZKcjQxK3VWN3JJYnlkOG91UjNzN285UVg3Yjd2a1RE?=
 =?utf-8?B?endCclEycTZaS056ZU0zWU1zdjd0VE5zMXdCSTNrWVBBTWJhdkd0eDJFQk9t?=
 =?utf-8?B?QnQvODBsZVNCekdzNERHeGx6NU9RZkhOaUxzcTNtYjJLWTU1bEN4a0s0Mjcv?=
 =?utf-8?B?SUliSE51Wk5tbm5lK016MERZb2g3WlpqckZkVERmRUdrOTNQQ3I3dmxLV1B5?=
 =?utf-8?B?YUtVVGYzS1VGL3IvWGswVE80a3poTkpFckR0aUhIeGNLWVVWV3FmVFNSYmJk?=
 =?utf-8?B?d2RkeVNvSndTd0VJQitMNkFIUzNmSmxPcEcySS9Mam1FYzRsVUFSL0NUeFdu?=
 =?utf-8?B?c1JLaURvbVVDbWNFaHl2QXRwZjdrM0laN3AzVnZmL1FLRGE1WG5PT3JKR2FI?=
 =?utf-8?B?dzRiQkczbWd1RjNsVFg1ZnJNNHBBUXozeDBkNFh2Z0YxL2xvUFdxdHJ4OE1F?=
 =?utf-8?B?czNHaEM2Nk5hU04xZDFzSHdwOUpwSmZna3ZWQUYvZmVvOXpuZ1ZhOUhZSHVa?=
 =?utf-8?B?djN6eGdUb0QweWorUjQ5dXpRNFdOSmQ0V0hoaTNnYi9HNFk4Qk9MZUl2WHMz?=
 =?utf-8?B?Zk9BSFFCZWRGYnRTS2NaUWZZNUZydTZEL2NrV3o2N2F4NTJQampDNXFMV1dE?=
 =?utf-8?B?YXhETlp4R3JmTkpRa1h3QlNTQW5tM1QyK1NZN3UrVGJEc0MvbEhCT2R4VEQw?=
 =?utf-8?B?S0lrK3JicGpXOFZHMmRVdnRiRSs4SGlpamtqTnByQ2ZiQU9YYjBUSS83eWlX?=
 =?utf-8?B?cGg3SloraTltcHJBVWRad0Jad1lIbE5oVWI5RkZqK1pyeHBaS1NZK3gxWk5a?=
 =?utf-8?B?VU5TTnNkS3B5S1hPUTJvSU1QdGdoY3p6YVkrRGJtbHBwUmg4MHFGb2JlZnB3?=
 =?utf-8?B?UFRuTmd2NHZ3T3NEeDVsUE8wVTlVQzRmMlpEbGh3OVNFZXBZVkFyQmM0VjFt?=
 =?utf-8?B?eE1LSGpENUU4ejNRaXF0NlJYandEMStUNzgrQkVKaDV2UmZRUExLVmVtczVC?=
 =?utf-8?B?TFFsQ0ZUK21iWmdQUXdDekRGbXdLSy9JWTNLaENPMkk4Rk9WNVVsZk9UZE80?=
 =?utf-8?B?YW1kZisvWUYrdVZSUElJTWJKYm9pYmRkNWQ4ci9URXhxZEJrcy9WbXRQcGdh?=
 =?utf-8?B?VStYWTdqcEpWc3k3bm54dUlSLzJ6NkdwQmE0T0hxczhFNWR6T0hWTUJ1dzJX?=
 =?utf-8?B?NTQ4T3ZiSUNqRWZMUlJsQjZOZURBeXpSU21IakVFYXlmbFBTTTQxRVdsbW9I?=
 =?utf-8?B?T2g1cS9HdzZTdVBCQjgvcHBxZUtyN05GcXVCMFVUeW5UVGZrbjhQWStacStQ?=
 =?utf-8?B?NTBxTndLOUw0OEcvV3NIN2JjMnRCTDJvSFpPcytieDhRQmhGdjMrZ2lPQWk0?=
 =?utf-8?B?V0F1eHRCOG82Zlpya0wzWVVjdUhqdWhNL3B2MmRpWmE3M2tUd003ZHliNFdE?=
 =?utf-8?B?Vm9oa1hRODNkTGc0cjhpaUdGU1RwY1FSZlJUSVZEVVJaNEZ4VTZWUjFaelVK?=
 =?utf-8?B?STc4YmREOVY0Vkthd0dNWDN4MTkzaHVrdnpDejRkRHpKUlZSSWhnZjM0eW9X?=
 =?utf-8?B?ZmVmNldQTmRLbkVtWEtYTXNzZGpyNFN6UjRDOXF1OHlUWU55YXdJeWN1WmFw?=
 =?utf-8?B?V3ZnOEl0cFFPV1gxM2VEYUJMd1dmenBPSXROK1R6SGczNTRjWFpVOVVLZ0M1?=
 =?utf-8?B?RXBPcTFGYVhFdXV0bng1TzkzQ2pJRk5aUkJCRlpGTVNSZ1REMVZ5Q3VhQW1T?=
 =?utf-8?B?Szl0RlZuRk1PNm9jYXE5WG53MC8wWTdxYU40YzZmU3IwZnVYdFlTK1JnQm9X?=
 =?utf-8?B?Y1JQeG1IN3dTT0dUTUx0RG9tNnRvd0VYdHBxMUJpZzk5R1RvZWU1N24raVNj?=
 =?utf-8?B?c0dGWlJBbTh3VDlhVUlkeTlDVVdrVWM5UUlDc3Jwd05iWDBkTmFzVEFZbkhO?=
 =?utf-8?B?aGs3QTgwOFVYMG0wUjQxZmRJQmVIeWM4TXo5bDBtTWtjTWxhT0RQSFZLVXRn?=
 =?utf-8?B?Umg5TXA4cng0Q0kzMWcxTVFycDVTWko3djdYL2cwTTYvSjVhSUladzlqaUVv?=
 =?utf-8?B?Uyt6L1lVaExvU2RsRExjUVZVWG9CRldMM0RRblZtcnVwQW5XS2g4eTE1T0ZG?=
 =?utf-8?B?c3czOU9GaFlJcm8vV2VQSE81SVZjMGc3MG1UK2FINWN3QlpGbjFuL1lZdUtW?=
 =?utf-8?B?YTZtRUMyK3NVVm5uMnZiQjA1Rlp0dlh6SC9OanJlSjdHS1ROLzJMMncxdmFF?=
 =?utf-8?B?RitYQ0d1QmNLMTl2bmRqdS83ZWpBZ1ZBbTR2UjJ1WnhTcVc3M3BPZz09?=
X-Exchange-RoutingPolicyChecked: wptmKXy0PT0Qx2xfc/TUrw0hQbzWP9QE78m/7grWW0YOvSg5qWTwuqULv0eOSMtfKt2OCAjBEPBboLfNxe0jknQXMvm5TFyDaQ6lnnz38EF2623FkIi8rVXHLbm3hPHz26Iy9MWEz5TM3AlOl/QWs8sAfHGq5NxKGIlJOm/VDpCPfFhw6updW545ObcNNk5u+8T0dDxDjupnLmnhGzuYN23n0gETz7Kmk7qu23ZE7ZMyZA6OyUSgD5OQ0jqb/ResERxCXLQ7dOMzrGyn4aDi+io7vpEBHj8cwyQco5vLVj2+GP674JDbC+ytanMYyDg1kcT0atU5qEfnp+HmERVZRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b3a61c-7c8c-4d79-2ef9-08de7ef12087
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 22:05:23.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgvBVJq2BVRnBggUYPRtM9Bd6CnPECqs8feH61r19SCkTZHmPoOoZ7HnEu0u1quRqeBHLsR/vVq0HvZTfzGSfO6VO6VD1JDe8UeyTmnvfuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
X-OriginatorOrg: intel.com

On 3/9/2026 6:23 PM, Sean Christopherson wrote:
> 
> Oh, yikes, I didn't even see that this series is playing games with the register
> indices.
> 
> Whatever we do, the changelog asbolutely needs to call out the real motiviation.

Given the discussion here, it looks so apparent the changelog is missing 
that detail. I'll ensure something like what you wrote here to the revision.

> I'll try to come back to this tomorrow with more complete thoughts and hopefully

Sure, you call it. I know you have a lot on your plate, so I hope you 
feel free to take your time. Thanks!

> E.g. passing in VCPU_REGS_RIP to kvm_gpr_read() will compile just fine, but will
> read the wrong register on APX capable hardware.

Right, so new semantics likely need to be established. As responded 
before, one option would be separate them in structure:

diff --git a/arch/x86/include/asm/kvm_host.h 
b/arch/x86/include/asm/kvm_host.h
index ff07c45e3c73..ff8a317be5cf 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -795,10 +795,14 @@ enum kvm_only_cpuid_leafs {

  struct kvm_vcpu_arch {
         /*
-        * rip and regs accesses must go through
-        * kvm_{register,rip}_{read,write} functions.
+        * regs accesses must go through kvm_register_{read,write}
+        * functions.
          */
         unsigned long regs[NR_VCPU_REGS];
+
+       /* rip accesses must go through kvm_rip_{read,write} */
+       unsigned long rip;
+
         u32 regs_avail;
         u32 regs_dirty;
