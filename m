Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793840894;
	b=0G8I2IPKx9oVs55YJ9fTak30J7fyhEKaml+akTFogpXWACuBb1uAlK+Tyrly7NAP5kB4
	 qFR8a47aHzsoyB1MR/KPy1uWfGlLdRVOfESGhZcmjEsW0wn9wb0q5tJvbnokCVgVqLKF3
	 gPBaHIXzIPgo97h8GtDeK4efjNY5HEk11OH2oD/NeZ/kKFQU1rpkkMts6qp7qbtOzxKpd
	 cYISvfDNRT30ulEjueJSN5JPQqXwpOFqT+S0FvoF6Ihvmb04DypfMCc0mvuu2Vm8udJtr
	 ZemBjaOPnqtlET5QFq0tIVAUTDLYErLG7fvE4msrvYrIuHn0W5iJhh9FQ/K7us5ZNAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840894;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Mg8vfd6TGfv7e/m/wPeXz9JTkx32Zr68jEyn9RPl/BU=;
	b=QUB4Eoz3TaM9pJx5v5Uosb1Imyn6JnrlLWob3BgzvXpGmW+1A9M9CEU8zSNUP70CZJ4V
	 f+SKAoEEDxfj7gs2r/TEPHGXiHe5tfkmQhpGFBu5SIVwRjFn4s1JHL7mqkoZZEfPPY9AA
	 A3+4C+JAX/4YjyTmQke6jQ3do4fkhN66b5U1ReYdPvC6EDBKpO/wN6SL0JTnyuzEevFIL
	 72vhni6VXpC/VSD4ZwPr0dQfUGSE/FHMg7eedsJn9qpHmhkTjukcS9MgGRaMMlXgGRhGo
	 bvjnE/slvcqw+LX28t+k8fTRQe4BYVG/uFEoZghitUoi0DMDwPv4fkltnPIl7HBvoqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SRoEcq71;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69151606A31B;
	Thu,  5 Nov 2026 01:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69151606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SRoEcq71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793840893; x=1825376893;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ACrlQmdUQpdxOv3WkgHGrq05+Avl52552FA/MZORiZY=;
  b=SRoEcq719CTSL8/QqDsPtVbWjDU3y1FG1ROXiVvf05/v96su8Z52/GLX
   JN3+6cjuEzLxQ9VA8yvHUL0NoURMWy7WS3fcXSzBTKB1vzCYBKROSC34i
   O9U9I3A8GLBPV98Wy287rZyNcSn0Z61ShepgK2QhvRfMnaTF/nGNc8lBJ
   ++x5MClyezooL5JYpw8ajDxY5QBsouzE2yrMeNR6DzC7e3jIahnTcJLCX
   CuO/sNUdboEdQvIwbabJzQ5PSlX2EzcMDhVknsxkO1/jX5JIRfwdOyrpw
   M7AF4XVFYw8V+xS5ZuCdCYGoGxovkyv9d2fIZpiFPH5pVyl3F8FckgwhU
   w==;
X-CSE-ConnectionGUID: lzA8AZZtR1+B4X9DSmuF9A==
X-CSE-MsgGUID: fohauDhdTOSio+sICPjBPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2487749"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2487749"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 17:08:11 -0800
X-CSE-ConnectionGUID: oDTO6ne1TXKWb/e8zthADQ==
X-CSE-MsgGUID: Z6SfxGGpSvOfnQlQRHO6Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7206571"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 17:08:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 17:08:10 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 17:08:10 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 17:08:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=me3cXC3STGP7xaWOZGoBordPDYVVw8XMAY604ngWEYHaaAkDDdEofbqnEHDCUB6WSkAJ39fqKySq1da9kqYxFIgON3aHVqeKiBa9T0gmw4sMMSvpnWE0hWvHo2QBFKvBIIut0m7QqAS9JZpdmLkJSSYnIHktxZaZEqdmq6xIrAMiSFWV3BogzhAvzgqlDKR/NqS+LYRvmKok1tOWLwWHonoILx9RTGxwiS2hZDRIje6uwp++pSTR5zclMhbrloiciycaOb43djpJtMCDVzAN6vS3kOxpJ94hQnyk3lhIEnT27G4Az4mcE3HrsLgPq5xEu9/9FasPS2EvsHAzETUW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg8vfd6TGfv7e/m/wPeXz9JTkx32Zr68jEyn9RPl/BU=;
 b=qNfrwjAnZ9sr2Qr3XVGXIKEyhOHmWYPM5VZR1sQ4hJFrwxJqeaXqVbGkuBBa74Ad+NJEu8FSW8nROVg+pDACrf0kJq6dy3gfDIxODrZqHfh7q8vlNbiMMRnJJ9IAGYBAGrqbNEE0c+/WpCvySjzaoRa7Kf38TLmOdJ+udxxTwww77P6ryf4dLiYCSQp/ooOd6SHTw9+umRoy6mFll6vPsQY4Fd55Ipf3lAHcLpP1kZEqqeVBNywMbNlDY9TZVteLT/YcC3y8tZ+uzR3gHDTpK+fWecwlWg9NZduX8mVeqgdozLLNooL2D2sQhL80f1wUDY6QiK+1x5u4W/4/Kn8Vxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by PH3PPFBA2AA2BA3.namprd11.prod.outlook.com (2603:10b6:518:1::d46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 01:06:24 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 01:06:23 +0000
Message-ID: <1b8df4a0-ff0f-47a6-a494-7433864eb00e@intel.com>
Date: Wed, 4 Nov 2026 17:06:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/28] KVM: x86: Add a new save/restore flag for FRED
 metadata
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Nikunj
 A Dadhania" <nikunj@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>,
	"David Woodhouse" <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao
 Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-13-sohil.mehta@intel.com>
 <dce3875c-d590-4539-b19a-324cbfa6d4e9@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <dce3875c-d590-4539-b19a-324cbfa6d4e9@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|PH3PPFBA2AA2BA3:EE_
X-MS-Office365-Filtering-Correlation-Id: 8517b7b1-22a5-45c4-7eb8-08df3ad90259
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: ezIqTItIxXCwPdGnIDSvkdyS03B6cHffJdk9tA7/1Ty2OztjlzKFhzM8inRUZA/6fJ9UOhQ1TOHGf/MhJmYCWLYXmMVncLT12oefBuM73IxTJHPnagD0t6WVpjVPwMYUW9sSNJb3rVq5GHhrD0sqCR0I3bxlGvNNJ2h+DrQAOcRLOZTfNk6rrOy5UNgrIbZigtLbb7xWLAc5XzntGdcjL8nQkygxWkioXFKlgGsupPW/BROh0GseCnvPDpknPiesjJP3tBATTIru4zHBMfruuYCz06hziVyp0DvwGEyH2iGp5UGj2CW4acvY0xH7vt5dTbBq0y/btZdoXYHtTrmLIeZuTSC90l5VDpMsnYZHuZT3RxienwE+mKiY2Lj51/pRYDokOODhjiRh0cfNbfOlDu0Fi9dbiJ7V7XXGvtk7iGuodj/YtTyTu6q9tFA90yLowVGAJfMfMXKO9gMRDBlia7yNmBj/B09HUbgp6OSKKF4kM4NOOWwJDcVnCWgUTwzk05X2R1k0eER6Z772TMceMADy+TkYZc/oXxuIfAP3GRj5dQWDMnqwVhUODDr88VPZykNWSwq5w10hpjW9EIPk0vjhZVF4vfgsk8r/qbz54thVK2WboXKwly993G8K+RC5ZsIt7H7xdWZgEXRGWYCZyp6pKZPE0ljoEfajGFHx6hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdiRkFSOFE4NmNTSDFEaWsyT1R3bkVsRDJVUlFEQTJVMjYxc1NySk5pWnM2?=
 =?utf-8?B?Z0YxOFlDLzlkRGZPMUJPMDhUdVFIOFdSNkRBYWhqYmJrRDFKT2R5MHdQbGpR?=
 =?utf-8?B?aHJBYm9WZHpPcTg4TnRkYmR4aHlOSy9nZzJSdUF6LzVob2hjaVVEZWFWZ2tj?=
 =?utf-8?B?RmVPS2lEb0RzMzAzM2VzS1RqNWVLZlpUQXVQNEJ0Q0ZHdlNSKzI5UWtSNWdN?=
 =?utf-8?B?bzJpaU9mL2ZENlBXT2RSaTlLWjA5V3lHc3hqTjJoU2VqZS9zZGFtQldpaHkw?=
 =?utf-8?B?bDMxYmxvTXRheWU4RXNOK3pRQUdBWWZJbStDQkxJakRjSEwwNkk3Yk91L2ZE?=
 =?utf-8?B?cWVmNWlxalpnU1lwSjRISFZsU3N1aDQwQkJpMFpnUnNPdWhIcGdvNmF4ZTky?=
 =?utf-8?B?aEQraW95TDRjbElKRyt5dDR0dzV5L3JQa293ODhrcjd4akgxbXJQU3BmTlF1?=
 =?utf-8?B?c1JJT25TYVF5cklBazIxSktoVGRQbHE4cWVSb0tLdTFNZ0tKNzFmaW9xTFBv?=
 =?utf-8?B?QmJiV3ozajkyaUo1Y0lob09rNW9LZXJ0QnFPUDlXQWVqcWFIUGlScDdoeHFH?=
 =?utf-8?B?OGFBZmZQV240VW1EMEZ3SEdpUkdvNjVGTGtMeGVyb1lESzlYVmZPcFRlYVNv?=
 =?utf-8?B?T1JVT0E4NmJVeE9KSC9EcGMyazdqcU5hVlFqc2FLUDNIOVA3T1puSEl6Slpn?=
 =?utf-8?B?d2tzTGdxZk1aNlFmclN6aGw2OWVGMkNWVHprUlhWMWpWb0ZqZStMbVhMakJ6?=
 =?utf-8?B?Q09PVXhjWkZaczc4dUNBU05FZFIremVKcWhxMmdjbWVtWlRyRjZlZWFlTmQx?=
 =?utf-8?B?Mk04TS9TdXlERmZlTmh3RjVVTjA2Z3JsSHFvdURobDkxeEV6WU0wSW10UDVn?=
 =?utf-8?B?T2gyNWlXZTEwQVkvSURvQlhjN1Y5UktMOVN6NkE3QjZuZzFldVNlcmlhdXBs?=
 =?utf-8?B?VUZtRlBtNWN5czZ1cWZQU25QZkYxUFdGcGswYUxVWTJOeG9LWkZLQ0tRMUNq?=
 =?utf-8?B?RzJsMkFWWGJybEZ6dWZJbWo4R2h5c0Q5NGpxL292OXA5SWU4YUhxOFR3Mmpa?=
 =?utf-8?B?NUJTakJmK01ySWdKZllNNWxURmNPWWFibGtVejB4cEpXWFBoanRuT2hKbWVa?=
 =?utf-8?B?Q1hybWZaVGdEc3VybklLTkVuU1U2U2ZjLzZBUTdDVFlWUGZJU2tjVHVpclZP?=
 =?utf-8?B?bFJTc002dWxTMFlUWCtZdTZiYVl6Sll2VGN3Nkc3UWpqUkhKU0RYYUhQSWxN?=
 =?utf-8?B?b1FxVkZWNHphdUJyYjF4cEpOYmRzR2c0OG5xdVEzcFJ5dEFjdzU5SXBST3FZ?=
 =?utf-8?B?MTFFQmZtbmg1OFd1RHRKNm1oRmd5V2RuSFVVWVI4ZVF2QmdtTCs5bXBCSzNZ?=
 =?utf-8?B?eSt4MmJGZEphUHEyZC9WV1VYL1dJcm0rck1VWlY1VC81MHJUejAwYS9BeGFY?=
 =?utf-8?B?WSt4emVLM1NxUExreEkxZGF0ZHFJVDkyc2wrR3E2eDc3dHFldVJYUmxTbnVI?=
 =?utf-8?B?TEdsQXZUbFo4emJvdDI3em5kb0JRY0NjQ2JWYzNRdVlTVGUrajlqQlcrUVhC?=
 =?utf-8?B?ejl1OCtsOUgwWlc5SitRdDQwMG1NTkdlRWZOUmtCdnNCQ1VRSnEyOUJ2N2VQ?=
 =?utf-8?B?ZGxNY29nRGQ5RGtLTFdrZGs3VkV0VGV3RWpqanFMV2pwdDFwOHlHaEpSMmVM?=
 =?utf-8?B?Nk1VeFlqNTIzeXZ2VEptRHBHL0p1cCt4K0gwVkZXaldqQTVqZnVIb0xtakgx?=
 =?utf-8?B?NjNmNTFreDRLeGFIYjNtUmlIQVJFamVVaE90OVRuU2Y5b3ZsMnBQRkh2QTcx?=
 =?utf-8?B?Q1RCcWRwbUZHOGZTVE1Bb096b005b3RqWU1DYjZWcHhSTW5MUWdlWlBWbkpQ?=
 =?utf-8?B?emlVM2FwYzV5cDl3ekpzS0lwZHplRmlYejFac2RIMmFzUzIzZjNVY2N6M3FQ?=
 =?utf-8?B?U0lvV2ZoMkM5RkprV3hSdTFKTWovTHprSXJtOW5ROUpXRUtZNk1tak5mQWtw?=
 =?utf-8?B?U3FjOWc3OUlEWmNvZ1RqaHM2MjFPRElLSzJWTUxmYmVWMEkrbm9Xb2k1bElO?=
 =?utf-8?B?MmhwWkdZdXZMYlVaVmFnc1o2TzZzeGFIL1k2VTc1QW5VNjFscnp0a3FBNGFn?=
 =?utf-8?B?bS8wdlBOR01NUnM2Z2FhT1dRMUVXN2Q2RWc5anV6Z0ZWemZTMHVLTE41d09m?=
 =?utf-8?B?di9BZVlCRWM1bG1hK1RnNGlyMWh1Y3BUdWFDTTBiTzhjNUxPZzJRNzhMNkVD?=
 =?utf-8?B?SElFSnh5NXZvNHJndlA3MGhmbXExNnJ6MmdwMHFrRjkxU1ozakJhaittU1py?=
 =?utf-8?B?OGhUc2N3cVNFOWFkcU1jd2xwYWRwQXdKYzRwSnR5L0haUkRIRmZsdz09?=
X-Exchange-RoutingPolicyChecked: B7i1p4sAl5LbyqcIxQG6hLN37qut7fApOKLbDDZ+VWcAWBaWbmOByOP1BlRq28386CQ3AIh4YAAO6vT3uz15jwxs7Z1ZAPvDlwLSFHPcNm7efp5OIfUQsmk3jeBjZ+iJHSgk4en7mfVhAM+rRRO1jVWyQaDeaANJcUfEtwHWnhUkYWuTshYdF8NwtsjQT/hTTupVmqLAiFXemJtcCLJaT9tuQvUogk/6LHQ3iF6MW6CRxmo1n7tiYqGGEdpI6pv91/Qrihv/xFrhOOY9jFqz0m9AYefNBVtHTzfCNYYw/01Qeh7GoDPK8/HT7qjvapv6ZQJSFToo11ru+f64yw/DnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8517b7b1-22a5-45c4-7eb8-08df3ad90259
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 01:06:23.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGzY1iUhBwBWbsweHeEuFz+5ht0MV2465J0E+jidN0+wd7Hhze4mO8EfBXKHvKSWkMr7NDJCQiBTBC7O7T88cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBA2AA2BA3
X-OriginatorOrg: intel.com

On 10/28/2026 8:10 PM, Binbin Wu wrote:
> On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>> From: Xin Li <xin@zytor.com>
>>
>> Introduce a new save/restore flag for FRED metadata (specifically, the
>> event nested flag and data) being saved and restored during VM save/
>> restore and live migration.
> 
> Nit:
> Would it be more natural to move this patch after patches 13 and 14?
> The commit message and the document reference changes introduced
> in later patches.
> 
It is arguable. I think Xin's idea was to introduce the interface first
and then provide the implementation. Chang also had some suggestions on
the structure of the series. I'll reevaluate the ordering once I am
through all the feedback.

Thanks!
