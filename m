Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80251DAF0;
	Tue, 13 Oct 2026 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932746; cv=fail; b=P3NkCX8Qyq6PP74kIQbxn0oLwcxW/7FSLTZuT9dClAfUaX2I2LFU4IM2rAWBOHOeHhyHw3W6/BKDRtN3I+JQECs9gRW9bG51pHbPwXwFUHwXj5ZGOpq2ue42vZ61uc2n+PQBdvs7FHX+bP/JUSAaw/yZsQlISLR3N6xjjk2/dDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932746; c=relaxed/simple;
	bh=mKBSVv8ArdSBVgR/5EZ0in8dVbGP1eCS+BLFX7AOYKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h0v7gOkKU3XGQymrK4mmEPJdxSrUYrqoH53y3p5dDrnXOPWQ5tntlDdzWrSqA+FOVrWjb/Nf94JTV1+/jnjsPf3/PpEWrNVdCzTe1jEwAeLqD3F/2GFVE/YLPs7iI5NJ8GKSUn/W3FAqmtFTz0fVSypFd5Ob2tNj6NgDmFP2Ls4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0GlL6GfL; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0GlL6GfL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1MR9sGbUmq4oIRkC1Ki3gBP+uqBA+eEM5pW0cZWjsPcoAkrmKv/JZjuWihvVGndel7d3N2R8AqcLqvmL9d7WOZEDrjOER9axJ+a/CybLjfHCdxf/pzGP8xrZGIzzAyoLN5HIg/QgjwLvI/zZRMjnGtkM9LDxSg9XZWRnbm4M2NaEQ5GXEZh/Tj0DIH5nIB3lVnOBR/VfSrKe7OuuPM+S0by+2ZxICPXbXaqBbWBNRuT2bIjnYFQpMF+RrDJep4/f+XwsA/YVeoLF6KlJ6U2JmhUf1tPYKKtm5J5bxoLF07V1afXO+CkLsKcYSYboD4T0k9jxhpnErlbx+6QliAwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8RNvEKtcpYXw1jdB0c8Ot2lvV5rS2mCIPtkQq4K41E=;
 b=Xnx/AArFjVf7iY9U9PR44f57QDU39XB8tx0OuDhikVobVP8egHBz9+aDFP7vLtNEIgrEY5RIPcCPXQowHtzOy3dNyCLQk74BelWjbdeqW1dY9kf4nBWSi2i77Xy8aI5BQUz8H03jb1s4xebZckEhRxYkaxXg8frcrZzPiS+CdbBk7el0Bh5QWfvR/nUbLJcPzbCkZ0KHE12/1wPiSw9XUeTIq5sdxYNlgenqUokRtRs7ri6jzA8+4mp/K8u/6CxDshnLYPfyATY4IEZ5nKalk8BW2yWHEN+vQKprFNqcq/Wnh+7tCOCk5frbBTw38zOArmO3+Qx8l3MKbs3k8UV7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8RNvEKtcpYXw1jdB0c8Ot2lvV5rS2mCIPtkQq4K41E=;
 b=0GlL6GfLI7rtD03ucdsudfU+JE/j8C0WTa3G/apVE3Rr6nf6aqIx6QDAXXk+oNc+hvBB/ZkDoYn1qAvAlK1ozwXCvdwinRUJ2SwG7eaBgjcteTqbSMJPNNEkwQH/9MVT8lvxhBTd8WNwmHNFxm2GwJvxpgZ419eDmclasO5LiK0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 23:05:40 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 23:05:40 +0000
Message-ID: <9202bea3-7746-4a24-8070-3f472198d3cd@amd.com>
Date: Tue, 13 Oct 2026 18:05:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
 tony.luck@intel.com, bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
 <f79c5f94-3c5e-4c64-9b6f-95f186e1bdd7@arm.com>
 <171f92a3-fa2e-44fb-b0d1-1250c72e31d1@amd.com>
 <4af177a1-7602-4b0a-a8ba-81575f1ec80f@intel.com>
 <655152e8-2076-4558-916c-d55f88f0f1ed@amd.com>
 <e91c9cc1-02cf-41ad-b636-8356e93b5dcc@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <e91c9cc1-02cf-41ad-b636-8356e93b5dcc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DSSP220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::8)
 To BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: a7296b5d-eb17-4feb-2ad8-08df297e7fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|260925021911599003|6133799003|18002099003|10067099003|13003099007|22082099003|11063799006|261009223027099003|260925021311599003|4143699003|56012099006|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	UUcSnmosERMq0rcg3NklYoHnO89m+U7FOXgv+2uSAj2ZRNi2mMUYJqMELPQ1qxGbTOx43T676WmSen3fjVYhpVvIzdR11W3V1axnJuAY385FLHxtizi+NrzVQSJMUDIpntlwW7yg1bCP4IJC0nxyiPNKabXh8mx6/3hI+GOWRZn20qDfpdgN/tvP2DZNiFkAY8hFFxhs9qWUuEfzjcB5//LJ03eioO127te2uuHKgawJ8P1rGur7/SQOXFm7nZnGJ0sYrc9rlqggwBGefHTvwG8cntMROdG3FzojseGgit0W2tTGmbUjLNFGjcmsTo7QLzP+n+2U+GKrZDHHjY4SVr/Hr/mFf2Yd2ZpYbjhj4uQ8igmLl9WUi6im19mIPCKMU95cAGsiFVCfNUGq83RTddjfAeAHDOCTDcOeSnFb0/xyYeYaK6Bl5bgAZ3Dhgev8aNyLOfWDOswaiF/bSmO95DrsjEsH2m0LdkiLnQEDBe7Me2SpO+d0jo9Ixas97yxnRpAOEaZcQutAUCzPGPHRpoP9v4ojcfQ7Uhr8p9IkUWVa9PIl/0n5X5cb28Op53BXWw49eb5JvzeYuvDnc27G4mBrQwICn4YKxHAneLPcqEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(260925021911599003)(6133799003)(18002099003)(10067099003)(13003099007)(22082099003)(11063799006)(261009223027099003)(260925021311599003)(4143699003)(56012099006)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0oya1Uza21xbE1jQjBPVklEbXdKaHVxUVVQTG44Q3BMZE52MWFCbkoxTitO?=
 =?utf-8?B?NXNFQjBNaThMTVp3MDRubE42TGpoM2pvTlB4WnNXSS90UzUxN0pJSlFJL3Jm?=
 =?utf-8?B?d2xRckhtM1BTVWNZMXZDV2drRlNDMkVqTWZaV3lvYnJpSFlRTlFSUzR2a0lp?=
 =?utf-8?B?MlQzWXI3cklpU2ZVamVZd1BFNCtialZCZ0xPNXg4T2tDTXAwdUZUMXlaa2RG?=
 =?utf-8?B?R1ZOSDdIbnZvcHlwb09oSDk1NHdOSHpGeEFyT29SUnFtMmsrUFNDOFRVeis4?=
 =?utf-8?B?dTBFRngvMkg5eTVYN2QrNEczcVJtcUExcnhnTmczWlFUL2R2Q0dlV2pGLzJB?=
 =?utf-8?B?dzdqcGg0eWJiUHd3QVh5Tlg5bVNWK0NrczVSRTdoYVg3SlQ1alhwNkFaSmJD?=
 =?utf-8?B?dytQekhJZVlkTjUyVE4wTnJ5QnN3WHBESFgxV0FCOWNkc3YrZ01vS0VEaWY5?=
 =?utf-8?B?T2hrMHVobEFsMXRuZGFob0hHMGlKaHlUZ2NIaCtOS0JBQzdkK1FaV29CdGFE?=
 =?utf-8?B?alZHM1l5RTEycm5JOTRwVlpERDdFMmQvRHcxbHR2RFlOSVQ0eFJpSlF0YmEy?=
 =?utf-8?B?WW5XRWEzT1ZxcjlPLzk1MHpEd25CbHZEM0NuWGNCRUkydjB5ZmFFZ0xhL3lU?=
 =?utf-8?B?OHhSTHc2c2FnZktsemEvR29aeGlneWhsN1pvN2doVzNNRXovbnhFNWx3K29l?=
 =?utf-8?B?N3Zsa1c4V3dmTE9JTFhXSXNuSzRoZkxZS1p4d1dZTnY5eGRGbUtqSUU2TWZI?=
 =?utf-8?B?c2VmWkRwbUVZSVpEei8yZWpCb1lhL2ZBT0ozNE5MaENXWUJRbHNDRytYR05J?=
 =?utf-8?B?L1NGL25sQ3FqaTJmb1AxdG5BU1UwSklXUytCWkNMMkQ2TndDUmdraGVYUWtj?=
 =?utf-8?B?Q3FnYVBvcGtMM3VLeS9QNE44MStmR1BBL0lBRWlUZEtGZ0t5Z2tkMktTY1I3?=
 =?utf-8?B?U3IrYVUxbVRTSTZPZmNSVFB4VVd4WFU3YUZBOWtVNi9BUkZkL3NDWFp6MzlU?=
 =?utf-8?B?U1JpS0dEUUVndCt5QklxZ2xpZkQwbDIxTDZ3K3pneGJvYS9vRFhCcnpnVlE4?=
 =?utf-8?B?T1VaMDFacFQvMU83TlFKa0RldVRFTk1CejdWYlZHcjM5eWcvRDhvdHhtVWhv?=
 =?utf-8?B?dThVWWlYQjFMSWdwQkFTUWd4Z2NrMm5YdEh1eXdDcXpuYm1CQmVtRWszdndQ?=
 =?utf-8?B?a0RmR3dIMUFpNlRXK3U5ZDFGTFQvSWtXaFhYcFF1a29NT3lsb0tmbVNvTUlZ?=
 =?utf-8?B?OU1RU1RRa3NZYURNVWE1SS9XbFBBcTdxbkJGMUFhcVJ0MGw1d1lvSDF4UzB3?=
 =?utf-8?B?dVFBRnZucVg0UElXdm8yQjUzdk9vZ0EzY1pwOVRGMTkrSjNIUGVMcVd2RUpD?=
 =?utf-8?B?VlBKTU40WTI4K2xicjFhOGZwckxoSFgrUnIvdjIzU0tUcTlIYjVNcWh1TEJZ?=
 =?utf-8?B?NGZVUEkwVWNTRU1IdUJlWC9EaXJpQ2R0UWxOU1E4RkFZREFCSUMwVXovMVBM?=
 =?utf-8?B?N0t0RWRqV1IzaXdLMzJnT3ltTEZnbUtQS2FhU1NNRVd6SXRiV0hSSCsxQ1lC?=
 =?utf-8?B?dDdqWmYzWkFoUHljN2xCZGJ5bFZmQmlSNmRCaHdYUncxUElqODh0Q1FIL1Ir?=
 =?utf-8?B?Mm1tUm0ralNPby94akNzaDNqYXN4d2ZCTXZyNCszK3Iwc2t3WllhOTJFYUFN?=
 =?utf-8?B?U2FHM0Z1cTZLZjVZOXR1cmZYNm8yUUdzYytTWmJQdmxraWZDZmhMdC9TYjBz?=
 =?utf-8?B?UTlEa0ZZU2tSbjdJdFd2dW9IWWozRTZ5ZFlnN01Ua1MzQmErcTJCbnU3QkY4?=
 =?utf-8?B?cGI5ZmxoZDIvY0MvMGtnS2dYZWdMSk5kUGVyMWtqTmc0V2N2WWxZVTNQMlhB?=
 =?utf-8?B?RVROeUtOMXE0S0RmMDR4Q0JPWEI4anFvYnJKSEUrNWUrMDUvRjQrUXZiY081?=
 =?utf-8?B?akNNOHlYZWthZmFXQnRrQ2NtZEZxclFLOFVIVU1ZRVpwWENXOFpnWVlmRjJz?=
 =?utf-8?B?WXE4cXVXTGx2VzNHc3J2b2JRdUFsWWx6RFlWOENrS3J6Q0pkaEhDTzJuTi8w?=
 =?utf-8?B?RXo1TGhpVC9PVHR6U1FQM1ZtbzE5dW14bnEvSVJ4R1ZuUHd4eUVFNHVnL1lE?=
 =?utf-8?B?QlRNaUJqNmlTTjVIOFVqTTRFZ01lMFNKRFk5WHVuU2E4YkFyaDltdUxXajJl?=
 =?utf-8?B?c281MTRRa244QU40WU12RWRnck5LaDhSNm1LbmFFc083WllqeWhDUzVNUm5S?=
 =?utf-8?B?VElnZHNFU0lLVThTUzUrRFF0V0dIVm00bkZ0YXlhbUV4VkpRUDB4eG9HTXM5?=
 =?utf-8?Q?CsbbjesWvCG0HQs2CO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7296b5d-eb17-4feb-2ad8-08df297e7fec
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 23:05:40.1209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EluoVka+YeBK8Hy19DHYc/FzjJWOnxEgpisCaBZWumYQsK7gxAPD0BfKeOUXFWGL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

Hi Reinette,

On 10/13/2026 3:25 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/13/26 11:52 AM, Babu Moger wrote:
>> On 10/13/26 13:22, Reinette Chatre wrote:
>>> On 10/13/26 9:51 AM, Babu Moger wrote:
>>>> On 10/13/26 10:57, Ben Horgan wrote:
>>>>> On 10/10/2026 00:44, Babu Moger wrote:
>>>>>> When the user switches counter assignment mode by writing "mbm_event" to
>>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
>>>>>> counters, resets per-domain RMID state, and enables counter auto-assignment
>>>>>> exposed to user space as mbm_assign_on_mkdir.
>>>>>>
>>>>>> Even though counter auto-assignment is enabled, groups that already exist
>>>>>> at the time of the switch, including the default group created at mount,
>>>>>> are not assigned a counter. All MBM events read "Unassigned" until the user
>>>>>> assigns a counter by hand.
>>>>>>
>>>>>> Walk every existing CTRL_MON and its MON children after the reset and
>>>>>> assign counters to their MBM events. Enabling "mbm_event" now leaves the
>>>>>> same per-group state that auto-assignment would have produced. There may be
>>>>>> fewer available counters than MBM events across the existing groups; in
>>>>>> that case stop assignment when no counters remain. Events in the remaining
>>>>>> groups read "Unassigned", matching the behavior of creating a group when no
>>>>>> counters are available. Also revise the rdtgroup_assign_cntrs() function
>>>>>> comments to account for the new callers.
>>>>>>
>>>>>> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
>>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>>> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> ---
>>>>>> v4: Changelog update (Reinette's input).
>>>>>>        Function comment update for rdtgroup_assign_cntrs().
>>>>>>
>>>>>> v3: Changelog update.
>>>>>>        Code comment cleanup.
>>>>>>        Added Cc to stable.
>>>>>>        Added Reported-by and Closes tags.
>>>>>>
>>>>>> v2: New patch.
>>>>>>        This patch addresses the Sashiko comment about documentation issue where
>>>>>>        counters are not assigned automatically when mode is switched to mbm_event.
>>>>>>        https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>>>>        In fact, it exposed a real issue. When switching to mbm_event mode, existing
>>>>>>        monitoring groups should be assigned counters whenever counters are available.
>>>>>>        This provides a smooth transition between modes and aligns the behavior with
>>>>>>        the existing auto-assignment mechanism.
>>>>>
>>>>>
>>>>> Given the name of the option is 'mbm_assign_on_mkdir' I expected the auto assignment to only occur
>>>>> on the creation of ctrl groups or monitor groups. That's not my concern though. As you are now
>>>>> treating this as more of a general auto assignment should the assignment also be done when a resctrl
>>>>> domain is brought back online.
>>>>>
>>>>> For illustration on an MPAM model I see:
>>>>>
>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>> mbm_total_bytes:2=e;3=e
>>>>>
>>>>> # offline one domain
>>>>> /sys/fs/resctrl# for i in $(seq 0 3); do echo 0 > /sys/devices/system/cpu/cpu$i/online; done
>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>> mbm_total_bytes:3=e
>>>>>
>>>>> # bring the domain back online
>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>> mbm_total_bytes:2=_;3=e # Would it be better, or worse, for auto-assignment to occur here?
>>>>>
>>>> Interesting.
>>>>
>>>> We don't know the previous state. What if it looked like this before the CPU was taken offline?
>>>>
>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>> mbm_total_bytes:2=_;3=e
>>>>
>>>> In that case, forcing auto-assignment may not be the right thing to do.
>>>> Since we don't know the previous state, we can only speculate.
>>>>
>>>> It may be best to leave this decision to the user.
>>> I think this raises an important point. To get a better idea I looked back at the original
>>> bug report referenced by the "Closes:" tag and I do not think this is a relevant fix for
>>> that bug.
>>>
>>> Let me elaborate ...
>>>
>>> The bug reported by Sashiko was in response to the patch that added a step to
>>> "Examples on working with mbm_assign_mode" to switch to mbm_event mode from default
>>> mode. The rest of the example was not changed to accommodate the assign mode change
>>> and the documentation thus reflected the state of a system that was in mbm_event mode when
>>> the resource groups were created, not in the new default mode.
>>>
>>> In this new version of the series the documentation change looks different - it does
>>> not imply that the system started out in default mode and thus does not imply any
>>> mode under which those resource groups were created.
>>>
>>> I agree with your final statement "It may be best to leave this decision to the user.".
>>> It is not possible for resctrl to know how user intends to assign counters. Why not just
>>> leave them all unassigned when switching to mbm_event mode?
>>>
>>
>> That is a good point. We can do that.
>>
>> Should we treat the default group as a special case and handle it differently?
> I am missing why the default group is special here. As I understand user space
> can allocate counters to the events belonging to the default group just the same
> as any other group. Could you please elaborate what sets the default group apart here?
> 

As you know, the default group is the "catch-all" container for the 
system, and users may expect it to report valid bandwidth measurements. 
That said, I'm not sure those considerations alone justify giving it 
guaranteed counter assignment.

Thanks,
Babu

