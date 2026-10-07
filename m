Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334247404E;
	Wed,  7 Oct 2026 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390868; cv=fail; b=bgtejj8XLwSs2UZDOG/oV+EJNhnHF+3w0ieGS6TNBv7G53Cdx77ekeUH9sUdVwbtRQ93DpXvQEsP+4LKeLMWhOVflC02aQcjIl8B9s/hilSEU+zJk+IbLo79S5tfAogo9dhxbWeO17oKI3EVSkrAb2mj33hbGYb/CuZXo5ifbnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390868; c=relaxed/simple;
	bh=5IVFkApmNNDqsx3Hz+kDXIfVBOXdXzxksSluB1O9Ifs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/wHOv7xRy5zeLFQCM0fHbtg+viBOhNiz1g8r0AN5yGRkNkLp3GaItTBIzvCp3li8bPQXqhU9q9M/d8Pmh6PnwdnXMqmgLCX1ytBCmm9Bk2zHkhSMmHnUOFPSEYycikHi0F+Tg/zTuq1nJM73qGD49qodJIVp0xoifcI2pBgN2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WXpakY39; arc=fail smtp.client-ip=52.101.62.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WXpakY39"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxYx0ao3VI4wNaj+PXvjpzZBN7B6iZFKRFmIq4XjDYJ8pBK2Ok4Nzbvx+fb5WlgMShwZ1qeHtsiAxmYolQ8U5TyNbmqPPP4h1nQEGyKxMilNcaXtJh9lz47vVlsgKKCzF0yTL/HO3bGHn94gGy95UejlfTChHwtwcFHMtce6AKkxK9emqBKmZnqNZ4NIrugVceJ9HCRE2ApQ5tGw9WiMe3H94QSs5jXN8lqjZH3OX6aDaQ15MUjVJbC8aJ+3RzCdXbpOCEACxObQQDbRguKlFeo5zTXLmHx8E/kyKP5QR9WyUEx5AkUoo/XvEHzuyyWX8fHAocij1TsfNBrTeUZgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6Kam31Ry9DLDVSMrVyFH6cMoYWY8c3nDK/1SOenqpM=;
 b=VPRDgp0jH9OJua8tk5zOMWv/rexMMFb+h3DwKPNl61rtZJhG2pYUKbJSJVex0eQfnMCPfYVjKDIfsY5xDAQZJ2fdZhZPfYyQrds4/PR/GqBzD4HnSuZ7m8qmmWjF5zKNjzf4Yh5VBK0zD7QWNr+6LHaFGX3Uk0EiTtqm3DKCpKvOKWwCJ0vQI7g64/j8KTRkoVFWA4AwQ0b+qPwGfY6yWl5WfBV/Cqd/wbBi9OAWAd66gCV4DWwNxDakSWwbol2/l0cluHz2l7rMzR6kLLQ6BVmZq+P64Y0Jku8R5gahS6sY79atQxdtB+7VWrmkjagXr/ueeh4d6QXApaemh6u/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6Kam31Ry9DLDVSMrVyFH6cMoYWY8c3nDK/1SOenqpM=;
 b=WXpakY39+QdPdEW1vkErrXmAAViawX07De0phl0aaphXxHPixIAiIjH5K8UhH6nR8jmmWcXJmMrZuwhbislf6pwk8abErmeulLeGDN0WAknKRrnkM5/5u4oybO0hNv7rK/YOAH8upj16Rd2KmqQlDg24YoGqsjHbRjVXgEBkBKI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 16:33:24 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 16:33:24 +0000
Message-ID: <45209a1b-5e52-4c50-a755-04affe312360@amd.com>
Date: Wed, 7 Oct 2026 11:33:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/resctrl: Fix ABMC counter programming
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1790976400.git.babu.moger@amd.com>
 <95bbc2e322ac18e2566c4963b7e6d13ac8485e20.1790976400.git.babu.moger@amd.com>
 <f4a82716-5107-4f39-8c9f-94374f188857@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <f4a82716-5107-4f39-8c9f-94374f188857@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS3P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:45f::17) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c53ad9-c69b-4172-120e-08df2490b536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|3023799007|10067099003|56012099006|6133799003|5023799004|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Zr5jXQt1KfzYIYqtso/ZqzIhyyh0B1Oo6QnGX8aNsv7e9HT4hW+/b9hNdH2NpekNttBBgMyoDGpoUYs89bMtv/DpRPaGth8fAGJSF1Bu08+qV3HGhUDINulIcy0tMYKTot2i7TVB/n+Vlm8iy1pc3j8S4QKiYIePhzkf3XjbYKThtdjWHHjXz2BPmYL4IHai3D5NSJhzWYQfk0zBmje2ULRwzaWI7UIXpZG6+YNoRzB1K5q/Lo6cNPUMXmBMB+93yIyG3Swz5ETmHy9D3Jg01NASyhA56TfS3/mr1yfJWibueDPISrnioap8uDa6k5vl7axQk8dzcXitWfEa3N7hn2+VtzA6YGOwN2R7GzUTWaPzIdniKkruklM+V7EWmSgtv+CCRtvcqTs9RKGiTYRGOvhE95hXgK8sqKvZSsfMK0sYJUGZCCcFAGAJuh9isJG+N/sSvmgknZL48bRLIqyC0LQWIpA+D/5nkxr7jhBZMw3TgXh0k7cs2n0d401mCjxnAHre/M/kDg2v2p+Jld7OpD1CKgISG2sIPE84rh/TYL9CpwtMUWI5nCrfkGdj+Ag9bp9F8ZruJK7tgSGvIq2Bi7jKipp6H4ozGYD9uSlSJgJ5mw2b+8ZS+WcVav7MVkYxfZy2YH9pInDS5k0Kfg4b1D0PltOCKFFCpaRT+MS2mt0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(3023799007)(10067099003)(56012099006)(6133799003)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2FlVktRV0VKbWc4a1Y5RVBDTjNuK1cvMDQ0Vzk5WVRjVG1KN3ViM1R0MGJK?=
 =?utf-8?B?OVlnZTFkNm9sQmRzTXJVNjgxZm9IQnRyVnQ0L08xV2hrcXVrK25nd3MwLzV2?=
 =?utf-8?B?bEt4V0FyZDE3aW1ud1hvblNVZzF4bGJUYWhSc2RUKzR6dXdydWFaTHJZY3Za?=
 =?utf-8?B?TjB3UTltOGkvTmo5ZGt6RGhpT3dzajBPcWs4dnU5VXhoajJVblprV3IvckFI?=
 =?utf-8?B?SWJKT3pHNW9JNm5id3BlSXVqOXlGUWtQNG14bGVueTd6NVFzOVRpYm0xanJh?=
 =?utf-8?B?dzJyTkQ0UVRIcnBTdVAvQnM3dGFETitMMzBHdlZLbXh4NFNlTFVBdXlOVmJT?=
 =?utf-8?B?bnprb0lBaURHQ0pSQ2w2NnRDV2xUQ3ZySjJ6Sldrak9JSFY0ZXE3YWFacHA2?=
 =?utf-8?B?cWdMTDh0YWhFaEp6bU1iaEVvekFhV1gzOGpPS011YWlrbTI5enVVV0hyUEpi?=
 =?utf-8?B?c2ZySHhlUEtJRjZsWjhlUGwxa0VPNFo0M05JOGZGekN1TVJRL3lsYzNuaCth?=
 =?utf-8?B?MEozSVMwS1JHVWpnMUpZL0V6SlpXczJyelRZTmRDK25ha2tJNXZVdUpjNGl3?=
 =?utf-8?B?UGFrL0tnMWhNcGQzbXIxYS82UmROaWVaVUErQlZzVlN1dXZzNkRXL05QMDRj?=
 =?utf-8?B?Z0ZWWFhVRXlPN3ArSXZJM1ZId3JaQUhkZWFFd1JnTVgyNUIzZklkSU55RFlG?=
 =?utf-8?B?bGNuRU5lRW1HdTFyVzRkWlEzV1I0ODB5UFJnY0xaV1F4UURROWlwa1U4bVpx?=
 =?utf-8?B?NUxMYjAxRG4xeVBvZGJ1SlRONnBwYWJDTGNOZFlXaGZKRDM5SFM3VWY4RFVn?=
 =?utf-8?B?YjVBTDJONFlIOU95Rm1ZR3BseGp0Y01FYWplei84ei9WTk5CRXhNQnVIMnRa?=
 =?utf-8?B?ZmNFUGpGcnZ4UEFHMHVCQ2U5c1RqYzRGMzVuRTJGUjE0cTA2bTh6ZEtkZElr?=
 =?utf-8?B?NlhLaVdOVXdYOGczQ3M2NVdodWdWOG1mNzE2UDg4ZGZpc2pEb3F2VUpNeTRI?=
 =?utf-8?B?VEw4WncwQVRvTGpFT0lXdE1LS09BbER1M3pMdkdJOXlmTnJaNUdQSjRUdEFF?=
 =?utf-8?B?QXhuZjRiT3Y0N3lJSUVmdFdPVEZ0VllaZkFYZExyVWQ2VVBVV3hzUE1kSk5S?=
 =?utf-8?B?dGcxdjNHMVgrTEdMYnRzdUI5Nyt0SjVGMDVWTW5JcjQ1SEtXWERoaGllVjhL?=
 =?utf-8?B?VEw2WkpmanRvSGJDUEdSSldsQVFrUVJjSmo4YXpuQ0dERGRMOEpSdmYzbEZE?=
 =?utf-8?B?a2NLZVNzYjJZVjRmZW1uOVY5QXErZkdCa29pWDJoZ2k2anN3Qkc4aWVobGVo?=
 =?utf-8?B?ZkRaN2NlWWVtM0pER21VeVZjVnUzOTZZbUswTGV1bEZ0aWhwNUk2a3RPQTM2?=
 =?utf-8?B?M0tiN00yM2tDNzJTUkVMNGhwRW82ZDZzRGMyU0svWG9sN1NEeG5VYmhzeEY4?=
 =?utf-8?B?RVpzVGtISXJIY2ZYWmFZRnZmRFZJbHVPRnFJaHFTUUpxTWxTMm1icE04NkR5?=
 =?utf-8?B?QXEvNi9aMTNWTlNUM3lGeDRPbk5FdU5kUEhhYTJ2UFUyWTYwTDA5dzhQaDlU?=
 =?utf-8?B?TzdJcVRFTGVFdmkwbVZhNW93dEQvYXJkRno1dkt5Q2NmWDMyR1VZM1A5RG1D?=
 =?utf-8?B?THFnZmw3R3ArMUZNVXFUMFRpRXJhVHNTV0ltMXNPQWhVL0c0b3ZEaDF5cGJB?=
 =?utf-8?B?blJkcUNkS3djUmFRNFJJOVBUa1BMdW9uL0dqL3BKeWtHb3J3cGtPZ0ZFQXlK?=
 =?utf-8?B?ME1yVUUzR05wYXl0ZnBjSkovSU5Rb3oyS2p5MU0zWVlML1NiSTFLWkRXai9j?=
 =?utf-8?B?SitKelhKOXdMVmhlOHowcmdqMG1SUFYvT3hMbTRzQUlGU1VBbUU1cUJ4Rm9z?=
 =?utf-8?B?T0N5MDJMZ2xUVW1JYTVsMDdVNlUvODlDQjEySkR1M0FMM0NqK0p4eTBiWWVY?=
 =?utf-8?B?a2dOdjRtK1ZzL0c4Znh6c2I2dVQvWWRLQVhRWkJGVktmcWJPSVh2Vjc4M21h?=
 =?utf-8?B?ZG4xSUorMWdxT3hveTBFU003OE1HNHZnckJFck1JTTZJeEc5bU1uOENmVlY0?=
 =?utf-8?B?U0lxRkZqelVkM2tBOHhyNEwreWRZbFhoUnpJMC9tTjR2djJxdTFQbW5xSmF3?=
 =?utf-8?B?SHM0VTJ0YlpHUEtSVzlLQXBSbjd0NGhsVmFVeTd5RVYwOFlaNll3WmcyMzhJ?=
 =?utf-8?B?M0grM1IrSGxkYlBzemRQK2lXMnM5S1JGU0lsdmthQUpJd2RZRXZSR293ZjZL?=
 =?utf-8?B?TUhQOEZKNEhlMzBJMjBNZHhNV2F6YldTdWgxTFVvRHpJUmwyTnY3bllJbmRZ?=
 =?utf-8?Q?GXcaXtBpzVS56nzL7W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c53ad9-c69b-4172-120e-08df2490b536
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:33:24.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGq8iG4YqsC9IqO0x6ZosKMgURcqatKnlrTdcbFR2eQ+R4L2N1z/tXVbYGDpH9WU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054

Hi Reinette,

Thanks for the quick review.

On 10/6/26 12:47, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/2/26 2:26 PM, Babu Moger wrote:
>> AMD's Assignable Bandwidth Monitoring Counters (ABMC) are configured via
>> MSR_IA32_L3_QOS_ABMC_CFG. The architecture [1] received an update that
>> expands the counter ID field (l3_qos_abmc_cfg.split.cntr_id) from 5 to 12
> 
> This describes an architecture change as a code change (l3_qos_abmc_cfg)?
> 
> The subject also claims a "fix" but above establishes this just as an update because
> of architecture change without making clear what the problem needing fixing is.
> using the tip guidance when writing changelog will ensure that problem description
> is always clear.

Ack.>
>> bits.
>>
> 
>> Use the updated field width. The number of supported counters is enumerated
> 
> The second sentence of above paragraph seems out of place as it seems to add
> in a bit of additional context as part of the rest of the paragraph that describes
> the fix.
> 
>> separately. Mark this as a fix to the original ABMC support to avoid
> 
> Tag can speak for itself, just focus on describing the problem being fixed.
> 
> The problem and fix are fused together making it difficult to see what is being
> fixed here. Placing problem in its own paragraph helps to make this clear.
> 
>> misconfigurations caused by truncating counter IDs on hardware that
>> supports a large number of counters.
>>
>> Also limit the number of supported counters to the maximum value that can
>> be represented by the 12-bit cntr_id field if hardware reports more than
>> 12 bits.
> 
> This is the actual fix though but is added as an afterthought?
> 

Yea.

>>
>> The AMD64 Architecture Programmer's Manual [1], available at [2], will be
>> updated in a future revision to document the expanded cntr_id field.
> 
> 
> Consider an example changelog like below that aims to follow the x86 changelog
> guidelines:
> 
> AMD's Assignable Bandwidth Monitoring Counters (ABMC) are configured via
> MSR_IA32_L3_QOS_ABMC_CFG; MSR_IA32_L3_QOS_ABMC_CFG.cntr_id selects which counter
> the configuration applies to. The number of counters a platform supports (the
> number of possible values written to MSR_IA32_L3_QOS_ABMC_CFG.cntr_id) is
> enumerated separately via CPUID.
> 
> On a platform that enumerates more than 32 counters, writing a counter ID
> through the current 5-bit encoding truncates the ID and misprograms ABMC.
> 
> The AMD64 Architecture Programmer's Manual [1], available from [2], has been
> updated to widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id from 5 bits to 12 bits (the
> published revision 3.41 does not yet reflect this; a future revision will). The
> CPUID enumeration reports the maximum counter ID in a 16-bit field and can
> still report more counters than a 12-bit MSR_IA32_L3_QOS_ABMC_CFG.cntr_id
> can address.
> 
> Widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id to 12 bits to match the architecture. Cap
> the enumerated counter count at BIT(12) so every counter ID resctrl uses can be
> written to MSR_IA32_L3_QOS_ABMC_CFG.cntr_id without truncation.
> 
> 

Looks good.

>>
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
>>      Publication #24593, Revision 3.41, Section 19.3.3.3 "Assignable
>>      Bandwidth Monitoring (ABMC)"
>>
>> Fixes: 84ecefb76674 ("x86/resctrl: Add data structures and definitions for ABMC assignment")
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Cc: stable@vger.kernel.org
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
>> ---
> Patch looks good to me.
  Thank you.

Babu


