Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608351;
	b=YWj660Fcy4xAVi2e1wQxS+p24iwcMlIFaO8PI5+JCeXXbaLPeRPzDxqJcDV1KvKuMcGY
	 Uu8N0X+rcS/UcbqPoUy2abi62oxu9do7zz8V6v/98qtgupMLifbmp/37CAyME8GkiJ1vU
	 rI8JX2K6EFdUuYEEBGa/MOwxppo7NLxLlGnHuqH5Q/gfJHVRdhUox1f4eC4/ED5fZl495
	 TM7T1v3227E/DKv84F560JG7OY9/7Rlo+1FMLlI+/kj71GGxiLbXGwDxTf2Wv7DRvf+8N
	 wJPFIj1px+uMZTGhIWRUWVuuW1IbSdJKdSc6TpdvKnUdeD5oX4jbj4WNN301NRI6fNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608351;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=25FRF5LL9YttW+e5pbqV/SkZJfROnfCIDEeVPeA55RU=;
	b=KUA/Zmevu1kgCvyXi1/7Cd5B5b6ejA5C6o8kkUQWETmUGvSTeI0H0rrYBV7C2T8clxtq
	 BVWdOQyjgn9Yx9uktZ18bdI8btvPvreBuTmwpOxRFGT8OKuHKDuySN23c2w7yrwAxphJH
	 HVNKlqCAY0Xkmg3H4rVV2M4WstDBz4gwKVuyDOen2+IE42FRa1pDrtEOfapMEZ/lsb7v2
	 9n+puYtGIZuF/McZ/bmQ7jiW5132ZJ0q7ydVGoW4AhCt3RjLCwt6I9G4lLXO8E1rhJfSF
	 WVek9eEKwD9ogkZN2a2DtTlRtssgt3y0f27ZJwyJrq4W8Rb9oM2pNJlVcBqlWvMJycg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g1bBXFR7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.38
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC18606A319;
	Wed, 21 Oct 2026 18:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC18606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g1bBXFR7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Imdg4dY8AIleEaRgehiPD478ww19pGLw77SPPADrevzgsvOY9wmxeXVfnnoJHGyOZdpjEzSefP+/O7WpuJ/Ij4i7TPtI5FOeBwEu4ijnugkinhJ8FlffjirjOiJgR18qE7CU3EUB06QmwOadpz0lRPgv0xQrokIRW2z5JngR4TXkliruUq5OU2cB1JkB/MYnDLnurRB86AYtVTP8e+0kNKKPRx0I24KwVoDLiKtyEFzQDQIwo2oKSQGsKgRkHhkGMf0SGhy2FSXSGhpbVfF96SnQTQgFkjC/TmBmTxIpkqoYVzz4qVcdH0ggE1zBlx/BiUlVpRnYJDmOc2M3sWDDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25FRF5LL9YttW+e5pbqV/SkZJfROnfCIDEeVPeA55RU=;
 b=QBVCUtj9HViJXIGwt0FqfhNz7TqrZAUcZblok6yELg3aAA0sv7MFbtutvnzDPVLowB8l+RuSLqE1zGtMcSVVS41gDwGa5cWwubAV6ItSMx2fNbBD1sBgUkwkEDKOq/KqfYBYHL2GXTrVY6UJBBErUghItrKqswk7Zbihpmvskq0ybDDr2Jm1cmpgZazccrpTqJc83kS7XGcvmPkUMtCgMWNPrJyfDN9xbDsaz9PlM0wAX6RNYHHg/SCToQNgWnr8p4az+y1V3yNFDd0Z3eAdm28BlkgyNVX3JjJBT2cpWfwn/ENPtHH/wvIl+fypTLP1h/DuFtjOSbkuncRB3vrpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25FRF5LL9YttW+e5pbqV/SkZJfROnfCIDEeVPeA55RU=;
 b=g1bBXFR7/Zm0FIRbC5+evoGH/C0GLzw0igltTXpV6zgyk/xn8lLy6s7Bq/eaovU/dorj4neF0hzJVBwZmVWUryNVj8cKaHjOOsoEP/CqOdEMnWi+uxVJqeQs2CNcRzVddKR9pUvzx0BWHJ2Lcbo+gKvfDd74x6IeLukAhHMDIIQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 18:45:46 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 18:45:45 +0000
Message-ID: <72328ebb-ec1b-4c6d-ad0e-d422e488a9cb@amd.com>
Date: Wed, 21 Oct 2026 13:45:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/18] x86,fs/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Drew Fustini <fustini@kernel.org>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, tony.luck@intel.com,
 reinette.chatre@intel.com, bp@alien8.de, ben.horgan@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, x86@kernel.org,
 Dave.Martin@arm.com, james.morse@arm.com, tglx@kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, fenghuay@nvidia.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, akpm@linux-foundation.org,
 rppt@kernel.org, dapeng1.mi@linux.intel.com, elver@google.com,
 enelsonmoore@gmail.com, jlayton@kernel.org, kuba@kernel.org,
 ebiggers@kernel.org, seanjc@google.com, ewanhai-oc@zhaoxin.com,
 binbin.wu@linux.intel.com, peterz@infradead.org, ashish.kalra@amd.com,
 superm1@kernel.org, chang.seok.bae@intel.com, prathyushi.nangia@amd.com,
 kim.phillips@amd.com, ackerleytng@google.com, elena.reshetova@intel.com,
 naveen@kernel.org, darwi@linutronix.de, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, eranian@google.com, peternewman@google.com
References: <cover.1790867441.git.babu.moger@amd.com>
 <atK9u7Wm6jYQdqfy@thelio>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <atK9u7Wm6jYQdqfy@thelio>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:610:cc::23) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a1a16c-c326-4c68-e955-08df2fa383d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	9uyg/pIBdNup7ImNE429Mf+xudEAlQnacygZszdIx4j/gLweciKTBEsFZ5f2i2Ih5nQQIn7aP2A3ywwrNdBShVl1NFYCZZdfxYAJGcxQ++LVVa5FGx9D2TNZM5X9pqXuksmA1zMrMQ7DwGun1DvOmEZczwzyaQ8W27urKuIrA3cSMVMz7zEQxnr9zvePZ4OnlGIhk47rDMKfIKYCplyXip96fhhhoSMQgus5Chcy2Fj7ECNGCk0OzXSjJOJRwPGW2JSEghbwnFDiS1wwF3WdZ2BpOsTMsNyMOhlLt4MxhLhMYP+jYwCDYEp1IOae0o3ND+miRLwNd/Sr8f6M4cD4BscHucTG9Rx6cJiehP3F0oXV3cdTym+c18BkHhUAUNzOTz7d+eTiFIsZ/V61E2mPEC00i/Y8rtMHc+0j8KK35sePMfaBWARrHAJoWzGomSL07ljrd+ZnyYJgInjhurK8GeNl1Q7Qtba9BIqUk+sxTbWsCypAes7nqvhucB/rAifoNbhuULDGKL3KRVu2MwGOPhz2eRi13AA90T/STZolz/5eYfnEA0yu2kDFFttRfKpXEN4hgCuCB4Sm0rx8AdG1uvzWbvwm6/kbO3pjVkU+25qN64MYJ7kcCjtp8X6XC6ibbXJECMx+Lr6Pu8wGzNeQ8ySmgjoWWX7CwaH1kSs/0UI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzJqMGxFZVdrOTV6bm12TlVlbzl2Z25hQ2dpcE9DUGRmOHAxU2p0K004SmEw?=
 =?utf-8?B?T1h1aTFiMG9Yak9BaVRha1NrejJ1S01mMDkyaWFMMGFIa0tYdnl5bzJGZHdX?=
 =?utf-8?B?N1dvUmlCaVBJYnRJL0JiSk1ERnUzSDd0WWR0bFl2ekRkRit2V2NncmUxekxv?=
 =?utf-8?B?ZUtqUGRnaGZuMHNwRTF2bk5ya3dIVmYvOGxHekE1bkZ6bHVJWmkzRU10S0xZ?=
 =?utf-8?B?dkUrNXRtOW5ldUhXK3dYM2JCckQyVzllV3YyRWZueE1IUWZ0T0gvTXRpbzdC?=
 =?utf-8?B?aklPNmJQQkZJZ1pEa1d5T3FHa0phNHVqVmQvNlBCV3RibzgwSEE1amhnZ1Ju?=
 =?utf-8?B?SUpzWDRhMTNzTm0yVXE4SExkTlNjVVRVK05FMFBOT1cvNk1mNnJ5dHo0Vlc3?=
 =?utf-8?B?c1JMZk1OVTlydVNtQmw1QndwTU1Hd2drajgrRm4yOU5xeUs4Y0xoOEIwNUQ1?=
 =?utf-8?B?eU10QXJFdGdXejNyVGREcE5JSEhBNTI3WEtGbGlmVjNkTStybnFmVVhzYnJX?=
 =?utf-8?B?cHZrM3lpTHA2RWZvdndqM3ViYUkyTEFYZDdTM3dGTEUwajhWZTJrcE9kenRU?=
 =?utf-8?B?U0NPY1FaOUMxN2FsSys1Z3JSZzQ0RHBqTXY2N2p0SEN0SEI0Yk1OSW1KVm5D?=
 =?utf-8?B?VG8xUWJ6ei9vd1Bzc056TG5zODdnSHh3SHA2U1lrSkVXUHNxeUxwSkp3UGE0?=
 =?utf-8?B?VDR4SEpwN2E2c3pMbWVIS2ZmYmRTQkJ3YkJhek1MOGFyUlA1dUN1UnBET1ht?=
 =?utf-8?B?OHU4NzFJNUo3bEZHVXZKby93ckg1akV3R2d2emkwcnVzY2pYaStIQjRCZmt5?=
 =?utf-8?B?SENMZG51VkFadm5sdmVIcndqM0lrbURHQzZUUXBEMFJnZmd5UndFeWNQTzk4?=
 =?utf-8?B?NHZRNnVBMHZscFV2bU04U0FBV0hlWlczUXo4NnBkOHlZTUpjR1dWVTlvZ3Y5?=
 =?utf-8?B?SklTTTlJNHN1VEtIVFc5VndOZW1uV3g2T1p4eFBxZVJwQUp2cUtweEN5ODYw?=
 =?utf-8?B?V3d1R0lXbGxTZHBmZHNVYzl5TVV0allsQ0FmV0JwcFB2UlYvQTNPMUdIa1ZV?=
 =?utf-8?B?V3RVbTUreEtKSllwK0svL3M4eU1EMEkwS1JkVHR3eHdCbGdwZFFWb1p1K2Ey?=
 =?utf-8?B?dnc0ZWJjNkNpVHhDMFBreTNuMGJXdEt5Z3BwM0pNZDUydjlFQ2c3eElsODkr?=
 =?utf-8?B?bVZXSjN4a2tPa0J6WUpvWmdQUHZIZGdZWm1HOWFESUl4alU2WDBkemI2VGdR?=
 =?utf-8?B?S3ZFQUlEZDZNTlNheGRPR3VPeHFta0JiZ3hmOTJKeE9EYU10MWRKa2lpZld6?=
 =?utf-8?B?cUN2YW5MM3M4Y0liWXo0RGlWRlJtc2JHT2ZtMDdKS2dCZmFjbGk0eHU0Qjhq?=
 =?utf-8?B?aVJrQVp4eVliMkhjYmUrSk1sUjhtRkhBR3g4QjV4L1p5RTViWHFEWUY1QThM?=
 =?utf-8?B?UitTNDFLRjJVVmorM00zMHptdzFhdzNQK2oybnRUdVRSRGNZNVBCckFzZkdr?=
 =?utf-8?B?a2RHSkZ2dE45akU2bVJraGJONk90ajdHT3hkNWpiUnQ2aUx4ZGNEM3pzZC9w?=
 =?utf-8?B?QlVjTWl3NTdVR0FYVkhnUGlxb1hmbDREVXpGb0xRRXFiMThWQnh5Q1N4eFl5?=
 =?utf-8?B?NE0zMGVUbjlMbkNweEVJVDZEMDZMVmFLV1MwYjRsV1F5ZDRsN0ZKS2o2VTYw?=
 =?utf-8?B?RkUyQ2hINVIwWGdtM1pyUXN6Uno0cG81SU5hWTFLczkveDd1R24vdWlQeU4y?=
 =?utf-8?B?UFNoT0hrdXI2dDVOc0k0RktzOHFmOHZtNVo4SFpmZDYrVkVkSHVHNUY0MXAy?=
 =?utf-8?B?ZnpGZ0tvYWdISXFFMTVURXhJU3pEem1Ma1JRN1FBcHhvdDh3d296WEVVeEFr?=
 =?utf-8?B?TUYzOVNpZjEvVkJHYUgxdFVKaTJnaytBYk5LRnVKdEVncFhxdmp3NlgyaFho?=
 =?utf-8?B?T0NpbjhlTXhWUDA4UjBMd2d2cEFSVFZ1ekk5U1lGcmw2amFJYmxHdTJZWitC?=
 =?utf-8?B?cTBPQlozZmthT0tvMDMvc1dmT2FBNHA2eVNFZVpiSHA4c1N0ZEd5Sjk1VDZk?=
 =?utf-8?B?ZVNSZGZPK0ZqOVBzN1Z1Z1Vvc3d1MFdWVjNLV1ZkVUl5Nk9EU0pjbk9OWENj?=
 =?utf-8?B?dFFUb0FHdVp4cnZkSkp2c2xuMmdoejZhUGVLQUV1cFZ1clZTWGMzV2pBVXhQ?=
 =?utf-8?B?SStYOFpKNGRGR0hSSE80d2RMc0Fla0tTNVhsZlFOYkszV0hYZzRJOThxZWdi?=
 =?utf-8?B?cG1PYkRuaklhSmFRRFQrTDZDd0RYaFFjcUtvUzlTcmNoOExCZDFHRXhIWEdE?=
 =?utf-8?Q?QBW/ymHLXsestR+RP6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a1a16c-c326-4c68-e955-08df2fa383d9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 18:45:45.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4IoOLb2B4jkJf1fLZ+zY7rKDlsmtS2m7mrI+xc/0Bebrddhob5DZja4qkY/2s28
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008

Hi Drew, Yunhui,

On 10/16/26 19:13, Drew Fustini wrote:
> On Thu, Oct 01, 2026 at 10:10:23AM -0500, Babu Moger wrote:
>>
>> Hi All,
>>
>> This series adds support for AMD's Privilege-Level Zero Association
>> (PLZA) so kernel work can use a separate resource allocation and/or
>> monitoring association from the user task, and wires it up through a
>> small generic "kernel mode" (kmode) layer in fs/resctrl so future
>> architectures can plug in without touching (hopefully) core resctrl.
> 
> Hi Babu,
> 
> Yunhui Cui (cc'd) recently proposed a RISC-V extension [1] with similar
> functionality. It adds a new CSR with a RCID (like CLOSID) and MCID
> (like RMID) to use when the cpu switches to the privilege level that the
> kernel runs in (supervisor-mode in RISC-V terminology). The srmcfg_assoc
> register is defined as:
> 
>      Bits      Field
>      --------  --------
>      11:0      RCID
>      12        RCID_EN
>      15:13     Reserved
>      27:16     MCID
>      28        MCID_EN
>      30:29     Reserved
>      31        ASSOC_EN
> 
> It is similar enough to PLZA that I believe that this series could work
> for RISC-V. Hopefully Yunhui Cui can comment further.
> 
That's great to hear. Please feel free to share any feedback or 
suggestions that would make this easier for RISC-V.

Thanks,
Babu
