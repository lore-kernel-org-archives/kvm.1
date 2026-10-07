Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0149C4DE;
	Wed,  7 Oct 2026 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399287; cv=fail; b=bxK5KhtEtVcROYhwO3eEIjAfFVcLTmCqfDxUsNtNF/nUib0FCP74Oc7dGyMeYOjpr1KNKJyFFpEGAg+Wy6t+bmedNe0u6F2sIF+iwh3jhrfL7lESAaHINWHJSWO3LMkjEij697UqQVxNaA1wpqIgFeqThn3NbZC3HBWnV/Y3PzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399287; c=relaxed/simple;
	bh=+xbGeyUa/GMaJSqzyM8M8JNRH44d0KW+w6pfiGfpEv8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ad9NAQy+p1H75aTP9+q8Byly04uFm8RXAxWSQFNT7JSFTt+92T8sSth/aph8Bb1PBIdQtNy2KkNH5pygZKkiwzu6aCX4crUlIY4eNg9WKtXmfMBdZa5ySVxAydLA3Y36RWnMaq9IHWjfmuhWIGLoECu0Le5QOvnWaQsJ0Q3wEHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ryezgpU/; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ryezgpU/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnPzrsokCIZy3lIPj2VWd5SAgBCcNfwWVAztaxhY6dUoeKx4atR29LuQy1vqRUnw3vWI+UmXbeQ6baXocTOHnjNT7xh6IUhCyJal1ANELMS+PjGfxcxK2EEq+tr6G9rkhXGF8HD3K3f/X/PAzzzeRFlShjDLcvZNBULqxm+aO7WjVBQVQFDWV8o9oqrmXDP4ERsrSnAjlbYjucdECaY0qiLnFCYZk0vSIx49YLClXE91tP2s9z/VgU7BpOdnx3o6H8BVPbXwKQEHJO+CT/ZJLNYjPslzZb+7b/qw412s7l82Vi3GwMzlJZTdR1/AeuOGF0QpLnB/C9rOvhRp2rGqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0CFczehegK8pRpJ82XzAO/Gui7a4ZLrAjEhtmirS8A=;
 b=IAMS/f8lyPJxFTpvb7ByWlUVnFTDSRCCke0kMO+/QA0fPObzNQgJMZzutf+ue4krovCKGTUO4teVpNrn1HcaqsHa9fp70TJwpI1cgRMGlN8k8OYcrIWYsbbRah4jru+hj/fwe7lk/ft0GOiHywzE1QcJoO+hR/kVdDWdlMxD9kEm3h5zhEhHBPXDISyNRvvopgYju8rXsPDS/a8v29KmxGLFKJakXJ6OrdXrzy0x9cHRWZ94KJKNfz9Ml4avOANvzlyS52TOkYX5zU3/zicgZkZ6FCABfvyPaIxlwq6np1eO/FdR90HsbrfD5k/UR1mmyX3+4oeZ82Wjb4qpPRwZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0CFczehegK8pRpJ82XzAO/Gui7a4ZLrAjEhtmirS8A=;
 b=ryezgpU/iKsGRlPab4Knm17JpDOY0TSRlMxFbF4ympb5i56fff/EGD8qULGzFQBsrYvTNmDyO19NRaHlYcpbQqGv9aO5YqHMnl39R+QE1+G0EYfGwyeefE9nXVDXTE4F1RO6Mi54f9Lhw8kpXtMrxgL1HAvYQ/J+P5w9CStdhyI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 18:54:42 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 18:54:42 +0000
Message-ID: <c2ca9eec-57f2-41b2-b8fa-4ed193b5b2dc@amd.com>
Date: Wed, 7 Oct 2026 13:54:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1790976400.git.babu.moger@amd.com>
 <b969687be3162715e10242424b5a489857d67f2a.1790976400.git.babu.moger@amd.com>
 <200d21ee-3041-40f2-9032-18e8544a7030@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <200d21ee-3041-40f2-9032-18e8544a7030@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:610:33::13) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 30cda633-2295-49f3-ad3a-08df24a4725d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|56012099006|10067099003|5023799004|11063799006|4143699003|260925021911599003|260925022911599003|260925021311599003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	oReSShniMkHuwENzWjStD6MVCp5e2AFvabYIPKho+8gHUwRCdpBKRkpbOuC2dvA4gSr5HmYaVdd/wt4Fou8Hfqs3ffi3kc4jRb/g5t7GgkQ4VMaWUkkPRmq9FHrnnxUlJAMB6Qpq8+KDASqgWxjK41ZsrkWlrGc3JLqmcUzI9oiiwS1Vz8SHI1E6pw0I0mk6lyVQhEpZ7uZo+tZtf2uepOc5EhdQIX9SrZAfEee7l+MTsAsbbE+Shp+zY1U4EFnNmnbCXSvXfwVUecP0toYsMeMCDQ6GxpFObwMs5IFAQIJbZEl38BxtM6hW0urbz799DBn/rCnyhfRlTMEFdgqp5UVjuwiw1SYi2M+dKHtvVNtQ3vcoPzvFx0ELf2tQhVZAFTpL3FI4nTCAY9VdMfp5RD8wXaPrHEAdjrdkK8sBEXbL6BbVbc+1U+itQ7fp46w9N1fmBXQgbMdPY0KLHCvGm9uz0i+7zcvGxnOeeekOPz6TBn53MfIDu1UHq5ym3nhrbR+0VweqodLVK3YLmTwMklBtdYntFWopcGNAz5QDkqxjPWMEFXuREXsnjkphsysJyJd4Ht4ml6KkIULytLx6OQ4eBEHMjXx9IQTeok5mdVdx6DRdQpc0Utrx2p0U2YeuCXpWgqXo09xCyN8TqJKQQnfkm11NyZGx33XFmkaNgrg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(260925021911599003)(260925022911599003)(260925021311599003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDY1a0h2dHE1YmZZSG9SRWcyZHQ3d2xhZHdEeFFHNWVKd3JFRUhIR3dQVTBE?=
 =?utf-8?B?aFJoWXl6T1VtVTZER0ZDOC95Z2lZTWpNTHBIRGZjV0VWRWJlSUlnM2RBWWt2?=
 =?utf-8?B?VzBocU5uSXVVTC9GaE1OVjNra013TjF3dGZZTkU5SVNhbEY4Y3NXZ3ltU0Zr?=
 =?utf-8?B?R01PWlpEYWtOakhiVzlHQ0hGanorOHV5bElKeUgrYlBrT0NqM1oxdHl5VWg2?=
 =?utf-8?B?QjRQNFhTcFdQWGZjdWRFUWJNZ2pFbUlDaTJ0aVAydE9hYnF6ZEN4U21TL245?=
 =?utf-8?B?cHJQYmVaL2Rsdm5qc2c4RlNjbWFhV2V4ZzlUWWlNYytFVXRrZHRsUitCUlJJ?=
 =?utf-8?B?WWpkUWlpdTAveHBKMFV4NzZVcThzZWgrV1ZRa010VGxMS2VveTBITFE0VGJm?=
 =?utf-8?B?anQ1WCtEZFhLTGJ2OE9UOTdUdzFzWmxLaTM0YVNMY1d5NGZMMjZMemFOSFhY?=
 =?utf-8?B?ZS9kbWZhSVJBVXBUT0RMdUZibSsyMlYxVlR6akRPTFg0T3B6OGVSYys3ZDFT?=
 =?utf-8?B?N2hRSCtwbUtjQzhtY3Z6bXpTWEQ1YXlSNmNPMWhSOUxTR1cyNEpDRGN6VlJZ?=
 =?utf-8?B?cGNIUTFoTFlPVzlza0JnWC8zQjhmNFVzRkU0VWlFNVVaVTFCR3dtV29Ua2Ry?=
 =?utf-8?B?TSs0bUtwSGNHbStkVDFXQ2FuV2JxS1JIL0E5MGp1eUpZUW5lODFCRnE2ZjdD?=
 =?utf-8?B?cG81MjhrVUJVZ002aEYyUjF3dDRSTUVGbmhVQ1RJRi9RZ1pTdDM3Z1FzY2x3?=
 =?utf-8?B?aHlMdjNOV0x6bFg2aDdiVkVrOG5qNk9tM0w1NkVjQzEzNDBzOFA2R3FsSzd5?=
 =?utf-8?B?WFdraVRTcEFTVGxSeE5pYjVsQlZTdjhTOE1zQ0pFaWdpcE1wVTR3YXRTOTJP?=
 =?utf-8?B?cWpMNE5kZGt6VDhGbXR5YWZQYUVpa29NdGc1VkxyYm1YRnFrSnBFR28wTUE1?=
 =?utf-8?B?bzl6cGpnQ1RZbXA5WFFGZXQxSHM5UEgrblZsWkUyWHRVeUZJNk1UaE40cVJi?=
 =?utf-8?B?cmVoUENzTEgvYzZDSTdRQ1hSazdkYTVzNmVwWVVVWElwRW9QMFJRdmFKd0s2?=
 =?utf-8?B?ZGdObzUreXpPZ3ltV29lUHlCOVNZN3BQWE8zK1g4MU54WENTN2xSVkdTWjhG?=
 =?utf-8?B?Z1VCTUhlcE9rdldEWWY5Wk9sK3lRdmVlUG5iYnByRno5Mnk2Sm4xMmgxUmVK?=
 =?utf-8?B?TjJIeW5Eb2g5TkhVQm8rTVA3Q1lRUVR0TmhSU3BSdFlZWFpzc2FmRSsyeGxn?=
 =?utf-8?B?NU02cUROTDh1Tmp2VlBvdWk0S1R6OXNLYWZCOWxPaEZqak5GMm5saUV2aWJF?=
 =?utf-8?B?YU9wSk1adTAwbTBtVE91dldnSmlqdmRHY3MyVWliQVF4ZzdFZVJmVEtBdHNS?=
 =?utf-8?B?L2pWcmNNUDlkaXJoK0lINHRLczVJcWw4NjBYWmJDYkVUNVZJN0liYTFaUm5J?=
 =?utf-8?B?LzRIK3RkWEVVaW9FUDlmUXRZMk40L0NXamNFWS9QaGo0NUJPRDJoSDFtbHdr?=
 =?utf-8?B?ZS82L3k2cDkwUkJzaUpxUUVrclBsaTFrZEk5UkJZMllHT3ZxYVNSQmRwdnpj?=
 =?utf-8?B?TytJRDVrNWdTVHlyR0VWb2JDclFzNzBEUUhMZFRITTljN0JGQS90MTZHQzBj?=
 =?utf-8?B?Ull3VjkzMkovdnVDL1M1dFJtaVhBYThBN2V3UHBWV2pjcWx5UHVZTkFXK1ZU?=
 =?utf-8?B?aHR4bWp2Q1RsSndtRWtwcVpwZDhxQ01aaDBQUnFsTUsrL1hPM2h3YXV5WEhF?=
 =?utf-8?B?OUovYVY0ZWZUVTlBWk1ZV0lqcHNya0RmYVZzb0RHNjNDODB2dlBBekFZeUxs?=
 =?utf-8?B?NElzTjRuVGhrOGFYWWM2MFRwNTdabnJjbyttYTQ3L3VFZlduMXFXelJQUHhM?=
 =?utf-8?B?MnF5RjR2ZFYrdjBJWFdFdlNTdmMvSVNlUWYyd1ZET1d4c0VtUHYvcytjTUJq?=
 =?utf-8?B?eFJrU3Q3RHhyV1N2c2ZDb2E1KzB4dVQ4SmdPU05Yak5Sdlp0RzV3Z0RRTjQ5?=
 =?utf-8?B?OWJCMG8wZmw5cGRMZmMyS3hSa3FPTk1BY0EvcWlpRGdSR2NodGM2T2sxM1BR?=
 =?utf-8?B?MEkwWHJ4UmlJYTRtVGpyMTY4OC9OYnR3bE1uWmxwUXVqYmxXbktzUEo5d2E0?=
 =?utf-8?B?SXdXd011VFI5eVh4blcyZE9ObzI5RTM2UWVUOWQ2L3Uwa1ZKOGpiMXFRUU9i?=
 =?utf-8?B?NzU5dkZUajIwc1dXWVMrRDVWdk9oVStEbkhnYmR4ZmZnbzlyVzhaeTVrMnZ4?=
 =?utf-8?B?d2IyYzc1eS9TMnkvUEVBTi9mT2hOS3NYKzE5N3RHcE1pK3dmQzBULzZpMmhM?=
 =?utf-8?Q?UpNRBtiR4AJ740vtOM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cda633-2295-49f3-ad3a-08df24a4725d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:54:42.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lizAQ6ddxMhhezppaueStqnxT+J0ESIR8nDpaI1JtdBo/rVyYEewyyxCzeWHNQUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457

Hi Reinette,

On 10/6/26 12:53, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/2/26 2:26 PM, Babu Moger wrote:
>> The "mbm_event" mode assigns hardware MBM counters to RMID/event pairs.
>> It is intended for deployments that need to manage counter assignment on
>> platforms where the number of monitoring groups exceeds the available
>> hardware counters. Hardware counters are scarce, so mbm_event mode suits
> 
> "Hardware counters are scarce" -> "Hardware counters are scarce on these platforms"
> (to make it specific to the context and not a general statement)

Sure.

> 
>> workflows that monitor a subset of groups at a time and rotate
>> assignments as needed.
>>
>> resctrl enables the "mbm_event" mode by default on hardware that
>> supports it. That breaks the pqos tool [1], which assumes the historical
>> default mode. pqos treats a non-numeric event read as zero bandwidth. It
>> creates 16 or more monitoring groups and uses two counters per group.
>> On a platform with 32 counters per domain, that consumes the pool, so
>> further groups read "Unassigned" and pqos reports 0 MB/s for them:
>>
>>    $sudo pqos -m all:0-4
>>    CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>>       0        0.69         16k       192.0         0.0         0.0
>>       1        0.40          3k         0.0         0.0         0.0
>>       2        0.44          1k        64.0         0.0         0.0
>>       3        0.39          1k        64.0         0.0         0.0
>>       4        0.43          1k         0.0         0.0         0.0
>>
>> Leave mbm_assign_mode in "default" mode during initialization. Default
>> mode uses one counter per monitoring group. On existing AMD platforms
>> that pool is 64 counters and may be larger on newer hardware. The
>> "mbm_event" mode uses two counters per group, so 32 counters cover only
>> 16 groups.
>>
>> Deployments within that pool receive accurate bandwidth measurements
>> with default mode. The hardware supports 4096 monitoring groups. Beyond
>> that pool, readings may be misleading or "Unavailable", with no
> 
> At this point I am lost because the word "pool" is used to mean three
> different things. It is used for the number of "ABMC counters" as well
> as the number of "non-ABMC counters" that exist on the same platform,
> above it seems to be used for number of RMIDs (number of monitoring
> groups) also. Could you please add some context at beginning of
> changelog to introduce the various counts applicable to the description,
> associate unique terms to these counts at that time, and then use
> those unique terms in the rest of the changelog?

Sure.
I can name as "ABMC counters pool" and "default active counters pool"

And update the text in terms of the words.  RMID pool may not be 
required and will update the text around that.

> 
>> user-visible indication.
>>
>> Default mode is still limited once the number of monitoring groups
>> exceeds that counter pool. After hardware re-allocates a counter, a
>> read may return "Unavailable". pqos still treats "Unavailable" as zero.
>> Successive reads can be a count, "Unavailable", then another count.
>> pqos treats those jumps as wraparound and can report an inconsistent
>> rate:
>>
>>    $sudo pqos -m all:0-4
>>    CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>>    0        0.76         60k        32.0         0.0         0.0
>>    1        0.45          1k        32.0         0.0         0.0
>>    2        1.57        107k        64.0         0.0 17592186044184.9
>>    3        1.62        276k      4928.0         3.2         0.5
>>
>> Users that need stable measurements beyond that pool should use
>> "mbm_event" mode and rotate assignments as needed.
>> Enable it with:
>>
>>    $echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>
>> Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
>> Closes: https://github.com/intel/intel-cmt-cat/issues/311
>> Link: https://github.com/intel/intel-cmt-cat # [1]
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> See "Ordering of commit tags" in Documentation/process/maintainer-tip.rst

Ack.

> 
>> ---
>>   Documentation/filesystems/resctrl.rst | 48 ++++++++++++++++++---------
>>   arch/x86/kernel/cpu/resctrl/monitor.c |  1 -
>>   2 files changed, 33 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index c8507580474a..2efc99223bdc 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -354,8 +354,8 @@ with the following files:
>>   	::
>>   
>>   	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> -	  [mbm_event]
>> -	  default
>> +	  [default]
>> +	  mbm_event
>>   
>>   	"mbm_event":
>>   
>> @@ -363,6 +363,9 @@ with the following files:
>>   	pair and monitor the bandwidth usage as long as it is assigned. The hardware
>>   	continues to track the assigned counter until it is explicitly unassigned by
>>   	the user. Each event within a resctrl group can be assigned independently.
>> +	mbm_event mode uses one counter per event of one RMID. A monitoring group
>> +	can use two counters, one for mbm_total_bytes and one for mbm_local_bytes.
>> +	For example, 32 counters can monitor 16 groups.
> 
> This addition looks redundant to me. "mbm_event mode uses one counter per event of one RMID."
> just repeats earlier "...assign a hardware counter to an RMID, event pair ...", no?
> The example being added ("A monitoring group can use two counters ...") also looks
> to be specific to AMD's usage and including platform specific example as part of generic
> introduction seems unnecessary.

ok. Will remove this text.>
>>   
>>   	In this mode, a monitoring event can only accumulate data while it is backed
>>   	by a hardware counter. Use "mbm_L3_assignments" found in each CTRL_MON and MON
>> @@ -376,20 +379,37 @@ with the following files:
>>   	"mbm_L3_assignments" after switching to "mbm_event" mode for counter
>>   	assignment states of all monitoring groups.
>>   
>> -	The mode is beneficial for AMD platforms that support more CTRL_MON
>> -	and MON groups than available hardware counters. By default, this
>> -	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
>> -	Monitoring Counters) capability, ensuring counters remain assigned even
>> -	when the corresponding RMID is not actively used by any processor.
>> +	It is intended for deployments that need to manage counter assignment on
>> +	platforms where the number of monitoring groups exceeds the available
>> +	hardware counters. Hardware counters are scarce, so mbm_event mode suits
> 
> "Hardware counters are scarce" -> "Hardware counters are scarce on these platforms"?

Sure.

> 
>> +	workflows that monitor a subset of groups at a time and rotate assignments
>> +	as needed. The mode is beneficial for AMD platforms that support more
> 
> Text from "The mode is beneficial for AMD ..." does not seem necessary here
> since it just duplicates the text added below?

Sure.

> 
>> +	CTRL_MON and MON groups than available hardware counters. The mbm_event
>> +	mode ensures counters remain assigned even when the corresponding RMID is
>> +	not actively monitored.
>>   
>>   	"default":
>>   
>>   	In default mode, resctrl assumes there is a hardware counter for each
>> -	event within every CTRL_MON and MON group. On AMD platforms, it is
>> -	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
>> -	events between reads resulting from hardware re-allocating counters. This can
>> -	result in misleading values or display "Unavailable" if no counter is assigned
>> -	to the event.
>> +	event within every CTRL_MON and MON group. This mode is enabled by default.
>> +
>> +	On AMD platforms that support more CTRL_MON and MON groups than hardware
>> +	counters, hardware dynamically shares a smaller pool of counters among
>> +	RMIDs. One counter from this pool is used per monitoring group and counts
>> +	every MBM event of that group's RMID. The size of the pool is not
>> +	enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may be
>> +	much larger. For example, 64 counters in this pool monitor 64 groups.
>> +	Newer hardware may provide a larger pool.
>> +
>> +	While the number of monitoring groups does not exceed that pool, a counter
>> +	stays attached to each RMID and readings remain accurate. Creating more
>> +	groups than the pool can cause hardware to re-allocate those counters
>> +	between successive reads of an event. Bandwidth values may then be
>> +	misleading, or a read may return "Unavailable" if no counter is allocated
>> +	to the RMID. There is no user-visible indication when this begins.
>> +	Users who need stable readings beyond that pool should switch to mbm_event
>> +	mode, if supported, and assign counters to the groups of interest
>> +	(rotating assignments as needed).
>>   
> 
> Above usage of "pool" looks ok since it only uses the term for the "non-ABMC hardware
> counters" while using the accurate terms for the other counts.

Ack.

> 
>>   	* To enable "mbm_event" counter assignment mode:
>>   	  ::
>> @@ -1787,11 +1807,9 @@ View the llc occupancy snapshot::
>>   Examples on working with mbm_assign_mode
>>   ========================================
>>   
>> -a. Check if MBM counter assignment mode is supported.
>> +a. Check if MBM counter assignment mode is supported and enabled.
>>   ::
>>   
>> -  # mount -t resctrl resctrl /sys/fs/resctrl/
>> -
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>     [mbm_event]
>>     default
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 5d0d3b18f9b8..a6a9090c4808 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -472,7 +472,6 @@ int __init rdt_get_l3_mon_config(struct rdt_resource *r)
>>   		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>>   		/* cntr_id is 12 bits and can only encode 4096 counters. */
>>   		r->mon.num_mbm_cntrs = min((ebx & GENMASK(15, 0)) + 1, BIT(12));
>> -		hw_res->mbm_cntr_assign_enabled = true;
>>   	}
>>   
>>   	r->mon_capable = true;
> 
> Rest looks good to me.
> 
Thanks
Babu
