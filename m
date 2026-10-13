Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA451DE12;
	Tue, 13 Oct 2026 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910328; cv=fail; b=Vupb6tP0oYsnkiGW+Gm63zi+49w115v/jDrBD/UXSVaIsJy1LX6fZ6Sh7CrlXbulto8WldrVgjWAoB0XIntDeue0kiUAqeqA168jYYUzEeoNm2kN3sH/Kq4kIUO2ozUqVXfmgwJKX2eqv5xXUKEukVIM30ipTqUQHw23kNTl1Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910328; c=relaxed/simple;
	bh=Mg9vj0yU13FbTDHwYAR+PyY3LhZaoXhBsWdYSbRqSds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wl7eNCHULR6wBigZQ8D80UOkO4t0uGsVLcQSrfriwt9q03v1RuNy6hlpsloI5tw1avNLpV8RxGlqMHBGCnvgWYrAT/OdD1FZx6Bxbd9lfYBbyaZGwJz4a6dAGzI/6QgSieYduB4SbIAITShN18RimCV82XBUOdxNUssPX0uyB9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kvtOJJqo; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kvtOJJqo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5hw4dHAy/1C6yNXkfvrkCdWL8qmTQ/1Fiu1KV18+sKXAQs4ma33Kln04mRoLlyhw/uzc2Ey6JRKpM2H83nrKnFjBNHpr+XGzGy3yB9myUGwh9LB+p01uNftmGSViJJKY/i2tuRHEu8WNaIRvDNJhVlij+b8HhkFmQVqNtO9PKP/ipyV22JDtjtgMuq1NattWRGAUNEEMroLGfI+9p+yBt9kgqWjrIOtiYf2PodUTjq0QABWIpfCRzpOwp1VB69Nr8qc93C+UJVY8C8l6xAOecEJPjsUISRVuqJUqzPr4TGVGY7yxcQABhoMQqBWuSa9zj1UtNeD6BVNKMW0k3BrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Xb6x8b4XdSt+gRA6gnkI1LRvQjE3PGcHoBmowL1s74=;
 b=Epg6ZFpqyqHTJrwqSr/8xlYrwfUZVcnVxEtCjtoYouGj9aD6L71JU5sWLmVIBZkEBhQy50pOWGZRGo0Buqn1pRynHMXmrJMfDBgqN+Xm0bzb6Fv+iL6oOyveWud3voourRncKehXo09FQi471/Km1z1IecVLBhMyk5CV/oUyKDFaTcSnDIqpCh/0h/oRjiuUdQMQoP+wm67/kDOrDs2rxcpFCDrCCfuTx4pu4+0KiuFNPypQ1RAEYfcyq0iii2ZeCNp3BvSLzkMpCsL4S+T2+9bSb6z11Zvg9aNJo++crQtkk9el0oJRFCxNUQG+PvhF+yULV6L/VC5/GNmlvm9qzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Xb6x8b4XdSt+gRA6gnkI1LRvQjE3PGcHoBmowL1s74=;
 b=kvtOJJqohKjEyonlB+wlfN4/21DgrznBUV2VSDLSFQ9w12DbyiKeHBUeKOFuUeyfbJTIjsftqKwnQfQhH6TZd0GaKJHRRESrwmYMyxYEG68BQa5OKn1naTlehhnir8LGmtbqNmC3wHmxvYvlVYUxWgqmvbPrS2cL7Cp8EdZCTao=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Tue, 13 Oct
 2026 16:52:00 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 16:51:59 +0000
Message-ID: <171f92a3-fa2e-44fb-b0d1-1250c72e31d1@amd.com>
Date: Tue, 13 Oct 2026 11:51:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Ben Horgan <ben.horgan@arm.com>, tony.luck@intel.com,
 reinette.chatre@intel.com, bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
 <f79c5f94-3c5e-4c64-9b6f-95f186e1bdd7@arm.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <f79c5f94-3c5e-4c64-9b6f-95f186e1bdd7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:610:32::10) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a117c2-1e08-49fb-b3ec-08df294a4c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003|6133799003|260925021911599003|260925021311599003|260925022911599003|261009223027099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	xxjzEmkToIyDnq4KA8NRyhwncbP8QweMCUMFTqkDRhBSkQ8WPvEQVXlQCluOGEPXIf2SlOmYmFE4GEM7ioGhfWbQgqm/Oze7A8WwW/1sFVl/A6JmWkHcEP//XZhzIQ54J+pRb+LeMftvz/kWyrkrgKksO8sA9zpaX6nl1FHwIBHldisV42vFuaGyf9P2PVQyjNWZ4guqdRsth4Zdoqzx1yYbnsnMj1wIIR/v3so3FwtEnK5OT/ekxjIFqK86EPYp2AZv0q8L2N26g1+Q3cDplbbXyutrMV5J0LweSgmPIi9Fb6wE4NxWk8skNeUH+otoRCkovZp45x17uweipipRPjd3OkYi6yOaNANNXuyJCjsVo5IQmLRytnUV64XaCy4+QvCawG6h4xqMyf9Mkja5UII0FppPioPUQ8bF9RPCMn8vheF6rjGpkY2b5KzBmcbylTQ+gkeVe7rT1eruevQAbEck4KLm0BzpTWKjoxnjRuCWSwy9gGzrc1gtDohDEbOEND5YVzmx9bWj4Vt+bqsOHuc8A/IX69LTZ4u1AoxLNs1dLouLrR6qu99/LXYowTX5CEwjBt0ar+GokxLtDn4JUrhTarYD4EZBKWbLRbTBNhs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003)(260925021911599003)(260925021311599003)(260925022911599003)(261009223027099003)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRBS2VPdll6d1JKYzltYW0rQXg1RytiUUppZzFGOENuYTBkT2ZLVWFEUEFS?=
 =?utf-8?B?K3IxTTFabUF5R2xmenI3MjZWb2lKbHJLdXhXUmpsYnJsWnhMYXBucXhFd2Vu?=
 =?utf-8?B?OUZHUmdjcmUxT1g2eUFvNHFuQURXcTVrTzZ1Vm1IajhreFVrbkZRbnQ1Z2lN?=
 =?utf-8?B?cmtmR005RXRlS3ZrU0tpbi9zSXNoQlgrcDc0MHJ0YW1sQ1VPeDgyb1FaM0xC?=
 =?utf-8?B?RmVjWkRBUlhOMmVkVUFWdEhIcXZVOGw0S0E1Nk50dnMzdVh5Z3pFbEdubFVv?=
 =?utf-8?B?bjk3a2Q2ZFhsajNvZU1Bd1ExZTNjWjZsZjBSSnpvMzRSd1VoUkhWRVNHRFpT?=
 =?utf-8?B?TEdrQUVIT0VhSmlKdGoyaUxqQ05FTHhqd1lsbzVOUWZiTUt3akgydHhHMjJW?=
 =?utf-8?B?OXN3MFpFTTB4TjNPZlo5bkhodkNxQk1TOHMvMzJYUGVpZ2ZQYmZIUTBjSU80?=
 =?utf-8?B?L0JCVWFxd2YrSWFReDNBejV2SlV5ZEFGbmNEVHJyRVppMjcwS2dzeHdiZVBp?=
 =?utf-8?B?V0Vsa1FkdjVVbUczK1BEaE53Z21zRFZDTXM2TXArL0dBckQrVllRTWRwWkRQ?=
 =?utf-8?B?YjJVYXNCNmUxdy9ubEtNRWVuS21BL05jbkNheUdpaXZ5c2lqcUZwM21VZUFU?=
 =?utf-8?B?MDdWeEpKNHhQS0RBZ0M5ZzhyV3BDTkNWL0V4cjZoVFA0Y2l6QzFOWVVWdTJ4?=
 =?utf-8?B?alhsbjRVSVhMUHJnYmZ2dWZmYWdieTdybmJzVFdQRFJwdkdweEVXMXkvRmRJ?=
 =?utf-8?B?Q3VqVzdjS25XMU5qZG1WOEJ4TERnOXlnNFRQMW1JNit0RmoyVUhiTzB6ejVD?=
 =?utf-8?B?M25SMmFqRnpjYTdVNDhwT3ZBaHpGWGlaYWozN0RYbGVuNGZ3U2IxMFdGU0Vt?=
 =?utf-8?B?SnRBSUk1azMzeHBaMUpkTUtXZFJFSGsvTGM4b0tYZ1h5UFRzRnQvcXMxMzVQ?=
 =?utf-8?B?TElodmd1NFkwamw4YUhuQjVZWFNkb21CMExhQVN4WHZTVjRIN3lHdEh2WDhy?=
 =?utf-8?B?ZkpiYWRRUkk1YXBNRmJDV3owdnREaCt5c0htdm1CRFpTZDZFYmo0dGZoc0RD?=
 =?utf-8?B?TlhSaGlndHE4SFNaQkhoY3NpRGhUQ0g3aUJPbDZSdDJpcUlUYkFMQlVaZVlZ?=
 =?utf-8?B?a1NXQXhCdENEck0zRDQ2WFVJaVg5WnFnY2hWZFhpSFh4WG5qemVTZjU0ZitQ?=
 =?utf-8?B?NTlvUFlQYXJSRSthMHk1SVJIMjhUcVFXVFQ3bzdQSXJyeURpNkhibjN1a0JP?=
 =?utf-8?B?VWhGTEk2TnJCd3lpNE9FZ1dFNGVCWDJGNW4vSXRJb3V6ODk1Q0xZZWtqcTlQ?=
 =?utf-8?B?N3FSaVA3SmFkYThUUjJwMmhhNDZnY01oRU1zZ28vdVJleDhWazlwUXBiaXJS?=
 =?utf-8?B?aUx1VkpZN3lOcTVMamtMUFBxQkZUemVwRTVNWkNWY3dKWStuWEtMNWIwQ3NX?=
 =?utf-8?B?OVBtTThXUk93dVlBOVJoTVFDMU5LZ0tSZWZBanFvcndwcTZqOTlLeGN4TXRs?=
 =?utf-8?B?R1VucytkeEZOY3QxWDI0SVd4b1pCUkhNdWNyR1BoeHJzNkthV3ZWZXNhdGZu?=
 =?utf-8?B?THVZaXhMTVdVRUo0cWdTYXJqYXRLRHl0MDZvMWJrMEVGRjZ2eUFXdWJ4SHB0?=
 =?utf-8?B?dHVpckxLaml0UUEyVUQrZ25lNnNITngrR0JYOTdib2pLOEtyMjY3RVhwZmxi?=
 =?utf-8?B?aHozYVJSMlI5eHpiOUMrVlNzZzNtSnpDaXVtN1d2NTZ1MFpDYUhWb0VmNUsw?=
 =?utf-8?B?WCtlaTIxV2pqZWc0UHlwR3E0dnQyY0JmZndXUTdBbTY5eWlqZndNcllYL0U3?=
 =?utf-8?B?ZEJDZHp2WFd6UXU5YWwxdWNJTXI3ajVRMWFrYkV2R2pWdkF5aDNENGhvZy9I?=
 =?utf-8?B?UTIrSlVVdFdISzAwR3FCU0Iyd0hTeG4zMXNxU3BpKzE4VW01SWl4cVNDVFJu?=
 =?utf-8?B?NGY2UlFuR3IzR1ZFZFB3WlZDL1JpSittMUVtd0orbjQ4cGlkZnpvMkRKUGlI?=
 =?utf-8?B?TkR3ZlhMU2ZXcVlnZENTUWRXakhvNGJFU1NnK0FqRzliUElvd1N3Nnhkckh1?=
 =?utf-8?B?WFFVcE9NU1NVeHY4WFFsRzZZcWtFMUY4UENSb09OZk9INlZoTVFrbDZnU2xS?=
 =?utf-8?B?NXI3dlJtZ0dyeDdqeHRJRnZ3UU5rMVUxT2Vab1pOM3RBU1Y0THYyTnlmMVBM?=
 =?utf-8?B?TmVHOVh6ZFNxUlhSR3JueEFoTWc1cThzWng4akNmSUtFV0N1czU1Ymt0UDcw?=
 =?utf-8?B?bmJiZFJhek5nY3lDZ3piOW1ob01QN3hKYzlHdW5CeE95ajUzUDAzSTU1by9G?=
 =?utf-8?Q?0UwFqCTSPOa26cpw65?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a117c2-1e08-49fb-b3ec-08df294a4c71
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:51:59.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5bnnfcv0KIAf6mImdNPcas37cOSt3zHjaQZfRwraeas5XJEVwNmYpQlfrop1OKC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715

Hi Ben,

On 10/13/26 10:57, Ben Horgan wrote:
> Hi Babu,
> 
> On 10/10/2026 00:44, Babu Moger wrote:
>> When the user switches counter assignment mode by writing "mbm_event" to
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
>> counters, resets per-domain RMID state, and enables counter auto-assignment
>> exposed to user space as mbm_assign_on_mkdir.
>>
>> Even though counter auto-assignment is enabled, groups that already exist
>> at the time of the switch, including the default group created at mount,
>> are not assigned a counter. All MBM events read "Unassigned" until the user
>> assigns a counter by hand.
>>
>> Walk every existing CTRL_MON and its MON children after the reset and
>> assign counters to their MBM events. Enabling "mbm_event" now leaves the
>> same per-group state that auto-assignment would have produced. There may be
>> fewer available counters than MBM events across the existing groups; in
>> that case stop assignment when no counters remain. Events in the remaining
>> groups read "Unassigned", matching the behavior of creating a group when no
>> counters are available. Also revise the rdtgroup_assign_cntrs() function
>> comments to account for the new callers.
>>
>> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Cc: stable@vger.kernel.org
>> ---
>> v4: Changelog update (Reinette's input).
>>      Function comment update for rdtgroup_assign_cntrs().
>>
>> v3: Changelog update.
>>      Code comment cleanup.
>>      Added Cc to stable.
>>      Added Reported-by and Closes tags.
>>
>> v2: New patch.
>>      This patch addresses the Sashiko comment about documentation issue where
>>      counters are not assigned automatically when mode is switched to mbm_event.
>>      https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>      In fact, it exposed a real issue. When switching to mbm_event mode, existing
>>      monitoring groups should be assigned counters whenever counters are available.
>>      This provides a smooth transition between modes and aligns the behavior with
>>      the existing auto-assignment mechanism.
> 
> 
> Given the name of the option is 'mbm_assign_on_mkdir' I expected the auto assignment to only occur
> on the creation of ctrl groups or monitor groups. That's not my concern though. As you are now
> treating this as more of a general auto assignment should the assignment also be done when a resctrl
> domain is brought back online.
> 
> For illustration on an MPAM model I see:
> 
> /sys/fs/resctrl# cat mbm_L3_assignments
> mbm_total_bytes:2=e;3=e
> 
> # offline one domain
> /sys/fs/resctrl# for i in $(seq 0 3); do echo 0 > /sys/devices/system/cpu/cpu$i/online; done
> /sys/fs/resctrl# cat mbm_L3_assignments
> mbm_total_bytes:3=e
> 
> # bring the domain back online
> /sys/fs/resctrl# cat mbm_L3_assignments
> mbm_total_bytes:2=_;3=e # Would it be better, or worse, for auto-assignment to occur here?
> 
Interesting.

We don't know the previous state. What if it looked like this before the 
CPU was taken offline?

/sys/fs/resctrl# cat mbm_L3_assignments
mbm_total_bytes:2=_;3=e

In that case, forcing auto-assignment may not be the right thing to do.
Since we don't know the previous state, we can only speculate.

It may be best to leave this decision to the user.
Thanks,
Babu


