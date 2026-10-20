Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792519390;
	b=bvPYGeud0euUjQ3MMm1XK9FKDE1OZhrsdtxmSF5bjXlAJpUrUl0mM0gk3+a8M8VTuaDK
	 52H50YaGiSmrzEH0NxE/oPP5DQ7l5dIRPeMVxRKCUVNxEDNmPge0SHWyKcYHmRp3FoRdX
	 RKWNdTW64b+vd5LN3Bv9pkLOVXQlRYzJ+blBkRYvo+pqqsdoEoVi+Cj3jzTurP8pQZStn
	 KDnKABfS4lbbOA1rPX9Fq66ta++YZY9w9MMyyicSQTgHQM2yJf5FuDd1H7OhVrVh1Dwt6
	 k2Wf15GeEcE03/zpVlbcvGnZGfbqwUW0zPkbqmTG4M1BiCDYjD6RZP6/NUNcFcuDAFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519390;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gtTzYTmMhR+j2b358MN5O3NMPfyjCr5UZIUGV7LRA9g=;
	b=P3s+6hf7g2+wtL4EBIlKajiAW8xHu2CJpvnBaMDWFHaGVqtL/fr2DhimZW7H/v8XvuLT
	 MvTNyEkxTpgNU0tPcNLydlbKeBKhpu98votUrcS88Sl5lm6b/EpBq6aAHHZ33VplBV8N6
	 8rJAJHCR6jl+q4S+oQ5I7dYhsj9YKjK9GomXn2vlDQjGRulIp/an1rU+CRkHv0Db1DRUo
	 g5va5C7uRAmzeOxDXJKJRFKwgEAxUMID+Gggb1I/fabHfpE06CYSRI49PB9L459c/y8tU
	 /j+LSaxtNUnIkZUIotrlaDlpLAVgJMPHXiDexFXZqmpb3iYwFfdmiuNwo5sspfO2GYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f156nkyK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.42
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8A606A31A;
	Tue, 20 Oct 2026 18:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A8A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f156nkyK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gom50RA+jMJ0j0L2AqyRmNcwuDMluDYaQuQ26WHICohTnzzn9DrjWgZUM880W3xx36dH7UO1VUfrrhZiaJ8J1Gi28gTbZVNSPYM631u7080BpTwPg0DKEve8+cC4/qHQoA8pWUG7hNIMKmee4nzjoA/eDdBkiHS8RgcuHPpJ0mOB0Myd8VssEXQyaiixJwpE9CIDafBN6LDD+DLxDJGluzy7Or9U/rCnXcoHU6YlKnH+ihXw+zr/k6NcwGwxBL0OnTUiOU3DgZfNur3l7adwKTPK7Sj51xcSD5rRhVpQRO8nSDX0hMJ6zDdyTmH/sf0rHhtMStctAMWFu5bFgArAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtTzYTmMhR+j2b358MN5O3NMPfyjCr5UZIUGV7LRA9g=;
 b=ODkptS/vv7sjM2SjYNMbmxmse4DdG9nBbuT/pcbVccxAcGx7QRvfjhE700jl1X9sHVAFoRc6mw82MWLlelBIGF9GbAEe8CFlkSQH9KqV3biQ6q2gv+i/0MNiSFNtGoXqcdVBwsHe665afMJ84sDO6/zMTcu6+x1GvTngRJ+QXHS/CUjDFsnFFFUPM1olMx/kWCFL7rS1v0fa9i+PbGCC+QnmT2VMl816ZzdFeqSMftRfWQUMr2ZD406lu+Ud+EHOzeUdx2y9/z6mdJw3shlyH3UeJfzeHsmGSNMyIi/isMqLeMafqeZhoRW2LtIfLFaIlV7abzz8MKB8GDAzeBOIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtTzYTmMhR+j2b358MN5O3NMPfyjCr5UZIUGV7LRA9g=;
 b=f156nkyKBqysyCb36y/8IJjRYK6FxjC/7Uy/PTyGPuNXVZlKi5OCT8l36dRwLc1PGGcHj0aMQSIKjvEMN4ELUZdZLS5HoX17LFrnYqAYr3aYMVPTCGTH6Yjcm3wK3FDGkZbKd+GimVuwKUuTTS4d7pOpOzu13BlUZBY7OVW1PWE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Tue, 20 Oct 2026 18:03:02 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 18:03:02 +0000
Message-ID: <ae45849d-8260-4a34-a860-51a309dafa29@amd.com>
Date: Tue, 20 Oct 2026 13:02:58 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 03/18] x86/resctrl: Add PLZA configuration definitions
 and data structures
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, ben.horgan@arm.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 fenghuay@nvidia.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 akpm@linux-foundation.org, rppt@kernel.org, dapeng1.mi@linux.intel.com,
 elver@google.com, enelsonmoore@gmail.com, jlayton@kernel.org,
 kuba@kernel.org, ebiggers@kernel.org, seanjc@google.com,
 ewanhai-oc@zhaoxin.com, binbin.wu@linux.intel.com, peterz@infradead.org,
 ashish.kalra@amd.com, superm1@kernel.org, chang.seok.bae@intel.com,
 prathyushi.nangia@amd.com, kim.phillips@amd.com, ackerleytng@google.com,
 elena.reshetova@intel.com, naveen@kernel.org, darwi@linutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, eranian@google.com,
 peternewman@google.com
References: <cover.1790867441.git.babu.moger@amd.com>
 <608876cedf5eece3f8b9297bcf21663a86a6380d.1790867441.git.babu.moger@amd.com>
 <bf4bd727-eac2-48ba-ad85-539a818524d6@intel.com>
 <c557ea83-11aa-4747-b305-93d554d3fbc4@amd.com>
 <dde507b4-6592-4450-80c6-41af64c1796b@intel.com>
Content-Language: en-US
In-Reply-To: <dde507b4-6592-4450-80c6-41af64c1796b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:8:243::10) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 3145f20f-7c8d-4440-b7f0-08df2ed4621d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	RS786e2hH/C7yA7/UPuhM7oD0fuacZwacTID5VYpHuTdvvZUkl6ze/Ei6ZizeJQpp2i6uu+wWWVr2f1S+uiFGl23g0GJFT2tryPGolS4RPV5gTRxNzz3s7gcguDtgYd3MRZJhdeDWzbdTbyVLdb3QPb0HE26YzqHyn61QAWQlVZDQHO0j0xCXXrn7RSl8vAB1svnih7/C+dMawSFnWXqrgA24lDyM1ckBAQUIUTYbMZDzMmDDjPXY/bycZv1MnM+9Rde5lQNPOLqOYAy62dvZaGWZssj9pQ+insdYMb5mauFMLanpFAYEq8zc137j+zpTqphPD1ytatgPDpKCS0UZ1YuG6/OruRgSuOoBmWMOyDf+JMtd0PXZ1rlyjhBtt/ojoALv8V0ntja05aYyZltpx3cE9qUJoMcVaaE0NK1bBjd25RCGUZ7Tt3+i5r0UdfYYQbK+1ak3sf6ZLUeT4bvbjzKGQN4jITqG6YNOD2N0smnCK+oNV7Rnn1UkAhf8RhE94r69q3A/nNlMGyW0EsKqjC06Dy4sV/qNUBDFJtr3fl9WUOxFt18u2LsnVOT79OjJe8ZdEnY90gluXvy0KmLl5+fOEkVxQihsMRlfhjU+q005zZVjKon796Y118muomN97jEeSUsUPFvDeMmBpf0//ZdndxyLioeyPGQjQq+tiI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXVLQW5CaW4rNGY4VmRzdTNIUmNraEJZR3ZFckhqUWZGQ3ZQd2tVTzY2UDZw?=
 =?utf-8?B?dUd5bzBEanBuNXJ1S1YzSEh5Uk9zYk93OHE3ZWxNVktGakdQZjRzYWQyclJ3?=
 =?utf-8?B?Y0lINmROWWJuMW9MRWt2VXJaZkF6aE80UUpvdGt6elQyektDb09aNUdwRWZC?=
 =?utf-8?B?WnJXS3NaNE1xL2xYOFF3UkpDRjNUWURjaUpYMDYvMHZETGV3UDZQNTdPMUFO?=
 =?utf-8?B?cE5QdDd1aUkwbjN6NzN6MEFvSjg5eStjek1FOUY4L3hZTzZjMVRSOGY5Z2d2?=
 =?utf-8?B?dWE1RCtURktCSTJvMndONUo1MjNNTFljZVh5RWhFR3phMjZnRFpWeHh5ZDdX?=
 =?utf-8?B?R25xa3NFODdnWWxBdWRuczNmTy8zQXprbkdZRE8zL2xSS0dtNzVzMmxETzQ3?=
 =?utf-8?B?SytEQXVTN0toY1h4eHFweDdSYzY2WFk5ajRUSURZbFA1SXVVRnBMLytlRllw?=
 =?utf-8?B?azJ2cUMyQ3pudDdoakptY1lnRlJ1RDJ1a3B5Rmw3VFdrcUpNNDVMRU9GZkpl?=
 =?utf-8?B?cW51ZFJhcndCMHlSd0sxSU1GczVBdUpGMmd2SEQ1cXVrTXlQMFdZMnFzWXRL?=
 =?utf-8?B?TjJvTjBaL3c0bXdTeUVFRHVVVGhpbnp2VEE1M0lNYWNGZERySlFQSk5KL01k?=
 =?utf-8?B?ZUZiUUFVSXlmV3kzQXYvS2dHUm4raGlleWNLTlFnRVdiLzNyVjhTODZGQXJX?=
 =?utf-8?B?MXErNFZuamJMeEVDUk1tUE5tYUNCV1RxS1o5eWVDYUZtZTR5WmcvRWpkbmZi?=
 =?utf-8?B?Q29GTmpqWldpeStPczdhSVFzRnZDaGd0YjFtcjFDd1diS2xvL1M4L0U2YzEz?=
 =?utf-8?B?aUxFY1prZnFnbXdOQmVWN0x5d0hzTC9pLzIxcUxJRXdXT08vTVVscmg4enhy?=
 =?utf-8?B?L2p2YmFLbzRFU3duOCs1TTJkOURRNkZFN05mc1JPbUhVZURURWtpOW1tQTZM?=
 =?utf-8?B?YjdWS2lXZHpvME5GaE1ranBuaEVmT2tadFZDZlYvY0pMeDRWeXlMa09qakZ1?=
 =?utf-8?B?ajZtK0VyeHNoRzUyc1JRMXRza1lEd28ycTgxWmVvYjh5R1RPUVZ1eXZMYW40?=
 =?utf-8?B?cXRqNUx4SWg5anhqNkNTVUFidEFLaC8vUk50eE1RY3ZkV1JrYXdYVmUvV1p0?=
 =?utf-8?B?c0gvbHJ6TmFFeU1sQm1Wem5XYmYrVmlpdU5UR1JJQ2JFdlJEY1h2VUx2bG5a?=
 =?utf-8?B?Q21leWFSM2Qwb3pjSzNFNWlib0xzK2E4aFVQMGJ0blQ0cWNtZ05IK2ZrSW9C?=
 =?utf-8?B?QitNK0FyYkNxbURqRGZiWVVOWEdPVndteTUvVTk1cHJGTDhqSUp6REdsdzlh?=
 =?utf-8?B?WnJkNWRySmJUMDJPT1JsbkVYd2lqRzlOM3Y2UDZzMGI5QjhqTldUVVdxbFdt?=
 =?utf-8?B?YzlXU0Rha0o1SERBakhrWFBieXYzMnVuUUxKSG8zTUlpdmtrbm91dGdKZzZO?=
 =?utf-8?B?Sld1aDduQVZXRXNpOFYrQ3JFd1pMOEsxNzEzVWl3UnNNdjgwQmVjZEdsak1S?=
 =?utf-8?B?WThWL25nRGZ2SkhaVzl4YjFBNGErWU9iYVZvMzc3bUV1NCtyNnBBR3pqOFN6?=
 =?utf-8?B?WjdLdXlsb0lqUm5UbXRDa2c1Y3BjdlB5TXJ5NWtLTXNxZkxOZGlDbjBWZmN5?=
 =?utf-8?B?eW8ydVlTUDVUTm1pSkE3Tk5hTERza2FNeVJZU3ZJcThkL09hUm9OVUJ5UklB?=
 =?utf-8?B?TlRwYWJvVVhpWE0rM0c0bWdlSFRBZ3pYUjBLMDBNbm1kVW02aU84TTNSOHM0?=
 =?utf-8?B?N3FwOEwwcHZQTUNoU3FKMGhJbkJ0RURTVEtVUVcwVS94K0VrWDBoUXZBcldV?=
 =?utf-8?B?d09PQ0MrN2ZJSzFFRGo5bXlBRmEwWmtibmFIM0U0SzZnWkVZVGJqWm9oTjY0?=
 =?utf-8?B?ZjZVK3ZSZm1sV29oN01xYUlTL0xTZ25Ia0RGRGZUdXpkMmxleEgvYU5Ed2R1?=
 =?utf-8?B?OUw1RDU5emVvZXFOdDlYcVk0bmE1QkFFS2IrT0M3R25meHVhZDhicVRCVVI3?=
 =?utf-8?B?b3pjWmJURUFvenVLSlRhYXU5ekVXb3l2MWtJejlkRjVJdklOaTZWRTUzcVU0?=
 =?utf-8?B?aHllRnlsbGpCK2dyUU5DcndkbUthUzlPcHVKVWVUVHBWWDdRandJdlVMcEhH?=
 =?utf-8?B?SmpWMDBHdXJGT2NnbGx4akI4aS9SV3Axd2kwRytuNys5WFVKU0tDTzhweW0y?=
 =?utf-8?B?WitodXFaZm9GakpORWlobU9PajVnNTZyLzc1cS83dStqVEpLenpkUnRYU0cv?=
 =?utf-8?B?ZFplWm4zMGVWRDdrRXFFM1JWNnJkYUgvbnNTZXRTTWk4ekJsR21UZkNacHgr?=
 =?utf-8?Q?ichASFU0sLJfh8mXFu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3145f20f-7c8d-4440-b7f0-08df2ed4621d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:03:02.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bB5GCOIvQ3Y8wg6xgzZSBBZwATkMH8UlcBi/DPX+fVZrgrVHptr7ZX0A7fmcGzw8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023

Hi Reinette,

On 10/19/26 11:16, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/15/26 4:07 PM, Babu Moger wrote:
>> On 10/15/26 09:22, Reinette Chatre wrote:
>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>> Privilege Level Zero Association (PLZA) enables the kernel to switch to
>>>> a different CLOSID and/or RMID than those used in user mode when entering
>>>> kernel mode. CLOSID and RMID selection are independent and can be
>>>> configured separately.
>>>
>>> That CLOSID and RMID are independent on x86 is clear to me. That they can be
>>> configured separately is not clear to me in this context. What does this
>>> "separate configuration" refer to? Looking at the later patches kernel
>>> mode allocation and monitoring associations are always configured together
>>> and written to same MSR at the same time?
>>
>>
>> Good point. Its confusing.  What I meant is that allocation (CLOSID)
>> and monitoring (RMID) associations are independent PLZA features and
>> can be enabled independently in hardware. For example, a platform
>> may enable kernel mode CLOSID association without enabling kernel
>> mode RMID association, or vice versa.
>>
>> Yes. The kernel interface configures both together because they are carried in the same IA32_PQR_ASSOC MSR update.
>>
>> How about?
>>
>> Privilege Level Zero Association (PLZA) enables the kernel to use a
>> different CLOSID and/or RMID in kernel mode than in user mode.
>> Allocation (CLOSID) and monitoring (RMID) associations are
>> independent PLZA features and may be enabled independently by
>> hardware.
> 
> Which CLOSID (MSR_IA32_PQR_PLZA_ASSOC.closid) and/or RMID (MSR_IA32_PQR_PLZA_ASSOC.rmid)
> is used in kernel mode is different from whether the CLOSID (MSR_IA32_PQR_PLZA_ASSOC.closid_en)
> and/or RMID (MSR_IA32_PQR_PLZA_ASSOC.rmid_en) is used in kernel mode.
> 
> This series uses the high level "allocation and monitoring association" term
> interchangeably for both of these meanings and doing so causes confusion.
> 
> Please pick specific terms to refer to the CLOSID/RMID assigned to kernel mode vs
> whether the CLOSID/RMID assignment is enabled and use it throughout the series.
> 

Another attempt to capture all the details:

"Privilege Level Zero Association (PLZA) enables the kernel to use a 
different CLOSID and/or RMID than those used in user mode when executing 
in kernel mode. CLOSID and RMID selection can be configured independently.

The kernel mode CLOSID and RMID are specified by 
MSR_IA32_PQR_PLZA_ASSOC.closid and MSR_IA32_PQR_PLZA_ASSOC.rmid, 
respectively. plza_en activates the PLZA operation, while closid_en and 
rmid_en independently control whether the corresponding kernel mode 
CLOSID or RMID is used.

Make the register and its field layout available so kernel mode 
allocation (CLOSID) and monitoring (RMID) selection can be configured 
independently."

Thanks
Babu
