Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB438F251
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460870; cv=fail; b=kVdiv2Eepxnr7XaIHA8umaBVD+0FqY3bXag+xxtq7DVwcWfqnzV0AhlLm7iDy9a77KYRL5F4B49BrQCMT9FwRo7lTj/xcdd5rGnDCeY1NBmC0TSkCYPWWSAX0Hl5njcqphYWmwjFyWEHhrpfnh9lnVqPfK644PGv64ZMKP+qF0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460870; c=relaxed/simple;
	bh=7ipFuQ48FUFZAyHb0o9eILm8+/1bakVYO4rKogwfl4c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JtfHOaWHcmj6ETUG4DekULxJNtcbaCeGo171gLHQay68ns4Q0uq+RZs/LWcuuuVxnfyz0dwEZaXNXWVy00k+U+1bqfOZBzXlZU31ZDJUE8ndlCdQ/OjZ/1oM6n6a96SPEzhgw20/R44ndhJNTnM21e5qQ1Dlxza9S6j6tNAGv4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vrvdJ/48; arc=fail smtp.client-ip=40.107.209.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vrvdJ/48"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgkNn8o8K4S56isKPdLPP/n4mx6VMzTvEt4p3sJTzQtdfWdQ9RlLVCKHsHATQeYOrj8Q/hdSyuzk81dfK+36e+7Hr+FQJDdQgS+ulxHZ3rd7JMcVb51w80zVRZfr6soxi01EkakhzTylAQHT4pnk/Sq/bEvhWdAFd0hMdarFrMbVaNayrTV538u4W70TLyVrDOcfQuZwmwVg/8IROgFRugNfDyqghcE1Wce0KKnmlI7NUwlNcwB8dQhvIYTfnrmtT82aWxApG/RZnK/YrRNWmd+zHeFAW8yS9oPjSKozzzaXrNAJ7W78G1SYH4LpHBMvhmf+Mp/hpMNqI5ZADeLgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKSFm13sFbA/fstvF2Ygae4D2K4m+pIoSW7d6/kvOZQ=;
 b=I8Wa4lKLdlet+H7Tf6g9jlBcw82vA2WFOFb+WdIbYpR6VP7fa9th6tg/oiHWzHb3o6FG+h8vbai4eRgUyJfDOyYLBzTFfHGXP08+43bFtACWKn5+ZM7zbW5OyUmCMy/7zrTvY/TuHeGvPqmq1/8GYhynPGQHUSM94ZI1gi07r4Z38S936PzjdN5p9B+tqMM+R6hkXDgeBQ0xumD4P1wlFj1JEtPlfGZNAC4tjOTfvtSnTpakCXoQAtKJXGUXa0tEJsn0I620lclmj8H5afvzaxCEvAbIuh+qN71A6FEwh/DG4bBml+CkKjAbBDSqX+sbeTgXMJWCGf1n6ypj3wSd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKSFm13sFbA/fstvF2Ygae4D2K4m+pIoSW7d6/kvOZQ=;
 b=vrvdJ/48RuKNBME8elPZhETyPCFrhAdEgHE3UJh9ouUB6n2TFoaC/uzUySafCD687xJZ+mEVKs6AxIzE/XbaQ58GHyzUylBMSnEj3ODv0lIL5DOx3NApN7PgVov3zjU0rRwuWRqUfxUhid/E+Qj6C9YMISvpc2piSS21NTb7+wY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:07:42 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 15:07:42 +0000
Message-ID: <abbf6464-9c72-47e0-bf48-3e80c70287bd@amd.com>
Date: Tue, 11 Aug 2026 20:37:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] KVM: Add support for hardware-switched mediated PMU
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Yosry Ahmed <yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>,
 Zide Chen <zide.chen@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 "Nikunj A . Dadhania" <nikunj@amd.com>, Manali Shukla <manali.shukla@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
 <32239a68-5ba8-4985-b959-1959f331f30a@linux.intel.com>
 <c240acb1-22ac-48cd-9243-792f415171c3@amd.com>
 <ee4968b8-c40e-49f5-9f9d-46c007e78ae7@linux.intel.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <ee4968b8-c40e-49f5-9f9d-46c007e78ae7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::7) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c6644e-4696-4d87-df4e-08def7ba4a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	UtECRQj5YJeAM+v0/jqYMpMTd6B0h8YpULIkueA+6GW0C18ldMJqBFwQDujCPwOinvEAtoaYVV70YNS3DPT7RC0OA0gygz57Wqr407WYLjTysrFa9DUV8+Xja29WABjzn6+o2DNXsFEcQhC+2I8bWQd1S09Wjl4cqeX6UIWfxiub98I2mnCKyjjSgsbz8VSPc4ZytHSqclN36a+cQ35/h2HdvMs2oLn3sRN/TbkoAhujSmpi84vIRWaOVIHBLhy2823HB6EIsiVKGkbQGoF0iJ4VYBt9S+m7Esmada1K5eSQUxqy+ZPqHpXOE5ub6d2AYslDZhf7Mg9+Ug28362sLdVUMJHDoKD2Pvxxrmx+v10n2ByaCfTGNO9wf3QmYNeMSQCJhjFx5zNu3wsFFD8Po3PZAJrFfsTQapDgQb8GdVHI3ry/+mD2y95KWeEMTzfiFznQG516nvY1FTkft7snyBuMec0FFfqWRjQXcq3kWpHRpnUysXQv6k50HjNFDDjaBGm3TBwS5pP2Rxtiav84l6qTeIe7S+jAjiTncoBXrtxWlfreUgwRBI0tFYJRdkh+Ld1xsVFN/qarwzIAsfs9oyPrluepYD55qk+u+Vsp9pnJzoGhImJ1lmzZm5Cofme8kVgDkQSGFLs7kKI9l3Bj0llfSPrYQ47Hd0h5inuYSlc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UCs3Z2VtWW1IamZhT3VKTWxjUlE2NFo5SjFTejVsZDZKV2xSRW9xZU1KTTAv?=
 =?utf-8?B?cVJzTkhnTVRMczZxRk1Fc0x2cTFuY0F4SUlNd0lYb2RIbTg5NUpHb0FqR2tZ?=
 =?utf-8?B?ZXdLN084clFBcjNTR1A2M1VMSElKQVZZTllwS3BxMGNyVGpDY2dwZzcweloz?=
 =?utf-8?B?OEp1Ky9MRzc1b3c4RllhNTBFSDZ3aFNaS3NXOUNlUFhzMkpURHhJMmI3SE9N?=
 =?utf-8?B?dmRTQ0NaY3daMElISWhHYjN2Sk5zTFIwS05naCtkeVFmZVpWZ2ZVemkxKzVm?=
 =?utf-8?B?eFB2djltVTRGTDloTkJNZHJQUC9MOURsTTJub3MzSUowWnJudVFXQmFNQWhQ?=
 =?utf-8?B?NkltdyttSUpQQ1BCWmtlUDBxZHgxMDYrV2E5OGwyeW9Eb0doTWlmM1d3V1B5?=
 =?utf-8?B?dlpIeHBtNDQ0NklhUXE5M0NZM09BcGFPamQvLzlvZjBiLzdYeDVEY1h4amJm?=
 =?utf-8?B?T0R4OGJ3TU5tTUxScDRUeXlZbFdicEtHWm1CWnJuOUFhckxPcDhIRDZCalhh?=
 =?utf-8?B?VFBLZzNNR0gxOWFKaXk5U3hVdjJiOUdBYi9MQzRIeUxKMGlaVzdTaVVVODhs?=
 =?utf-8?B?MGpJMnpXSTFRODNDYnNxcGQyeEdyQ0V2Ylc1TU1sYStWVHRJenRxaml1M2ds?=
 =?utf-8?B?aXRsL2xxZEVmbU0wTzk2dUlBdjNyS2RvaXA4S29NbTZHMTNYSmpXd2lHMTN4?=
 =?utf-8?B?bUMxSCtpY0lRcUZlV2pvU2RPSXo0Z1g5MDVQeGRRdU5zWVcvWWR0b240bHN0?=
 =?utf-8?B?R3g4SlpZMmVveSt4Zk1heEJ1czIwNkVnSDNiTVpTdUVQeWV1ZGUyZmM2Tm4y?=
 =?utf-8?B?WENNb1NpVFJlbXd5YlB4L3dmWkYzOTg5a2pXcE1tSHlQbXZDMU03Umt5ZCsz?=
 =?utf-8?B?MWJSWmlKRUdlTlAyQUViYXhHSXJmYU1ENENQY2dhdTZYaW9IbVNYVUpBYUZV?=
 =?utf-8?B?eXNPU1lSWE5nT1JJWmJybEQwK01Zd2ZZWmlCMGQxbDlCdmd1eGdFZjBaQzFJ?=
 =?utf-8?B?MlQwKys2SVJyWkpFKzVsWGJYSUgzdE9zRkJHMnFFRVllRlBWUU1NS2xHWVRi?=
 =?utf-8?B?NjhVMVAzRjBzSUJnek5mejlyUHlpNkR5RzFxRThqODJVN1hwbVpQbkRKV1pj?=
 =?utf-8?B?NXB2a0hxNFE4QjVKZ1U3Wnk1dFZHRGVaeGxkTUpQamZUV3NTNURKbGhUR3RC?=
 =?utf-8?B?a1l1TjF0Rmw2OFZvd1ZQNUdpV3hsOERRbjJMZE5IQ0J4d1lPcHZxSGJnQi9x?=
 =?utf-8?B?ZWpOZlU5VHRIeGUyM0FsWFpSN25WZHlSa2dTUFZpUHVra0I0ZDZQWWRFODdE?=
 =?utf-8?B?K2twZzJKcWJsQXdoRXJrNUxGMWI4QU0yOWV0RjZZQ216RFRDRkZ0Y1ZKY0x5?=
 =?utf-8?B?ekZFVEc4V0JTZFdBdWYvQ1hodnlwcWlEV3BjdDFOckJIaDBYM3FKRUVUck9F?=
 =?utf-8?B?c25NWDB1QjJUb2pWeUp1aUMyeTdUQ01remtUVEpIQm5neksvSCtHdStKMUhv?=
 =?utf-8?B?WFJYekI5VnZiQTNwWldrYlNKOFEzcEZiVU42M0lVM0dhNWlqeE5ScFlmWXU5?=
 =?utf-8?B?UUJUSXB5V2pTMkJheUtEOUI3ZFA4WCtjeVhkSzhwQ1VLaE1idjlIWjRuTmh4?=
 =?utf-8?B?ZVB4WlVscnRNR25ISEpZZ0VGZFNUYk42TEYxaUZWQ1ZYTldvbVRlWldTeG5S?=
 =?utf-8?B?TVBkK3pqMGxlek92SFUyZmxyVjE1ZzBIUTVtMVo3aXVWQ1lUKzBPaVlhcktN?=
 =?utf-8?B?ZEhBMUR0ZVZwcUdRaEQ1ZW1wdVlJRXVqTzZKcFg3alpNYzJJM081enlRaHgv?=
 =?utf-8?B?Q3NCVUtvc2J1RjliT2JZZ2RUaXBmU3JBTHpKenc5L3ZBTzhJRHVia1ZWWndL?=
 =?utf-8?B?ek9JeFJDSHFrOFR6L2twZ3A3eUhIbkJ6RWdWWmZxR3lxdGlSL05ETE9NWmRE?=
 =?utf-8?B?Uks4UEJlajlRaEJJZmlieHdoV0dvWWJuZU5XSDJmNDhiay9mY0lIM2U2ODlO?=
 =?utf-8?B?YVF1WUwrdzNtb3prSHlXOERUM3lEdU9qYkFBd0JhY0kvVzcwVzJmQ21Zcngz?=
 =?utf-8?B?MDZZbkpHT3ZKNDJ5NG5CbnVielBRN1FyRFlwLzdSQlJCRHdxVDM3bnZQTHM2?=
 =?utf-8?B?V3h3TGU4RWh4Tm1ZOTBaRGlPL2k3T1U1RzYvMGJuZFZ6dXdkRjcwWnVYYWpv?=
 =?utf-8?B?amJEeDllNHlRNXovTW5RR1A2Sm9yODczaUI3V0l1b1FLVmxBaGREVmpGbWYw?=
 =?utf-8?B?eXphVWlWci9VV29nbVcwYXN4d1Z2QjZ4enRYT2Fnak04Q0MyMDQ0Wkd2UlRD?=
 =?utf-8?B?Z1pmTkljQlFxdWhZVnBDSWlRbUJnZUtLK0ZycHdzMFlpSXdLSG8yQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c6644e-4696-4d87-df4e-08def7ba4a3e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:07:41.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIrD5unIvV4jP95dCAjRwaxHNpPlm84SjqTnRyExRMB/t/9/s/t5CbgrX9VOe9+EWwQVMEIcVmiFpgJdVoOMwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

On 11-08-2026 17:22, Mi, Dapeng wrote:
> 
> On 8/11/2026 4:37 PM, Sandipan Das wrote:
>> On 11-08-2026 13:19, Mi, Dapeng wrote:
>>> On 8/10/2026 6:14 PM, Sandipan Das wrote:
>>>> Mediated PMU currently saves and restores the guest PMU state in
>>>> software on every world switch. On Zen 5 and later processors, it is
>>>> possible to offload this to the hardware, which automatically saves and
>>>> restores the guest counter state to and from a vendor save area (VMCB)
>>>> during world switches. This feature is called PMC virtualization and
>>>> detailed information about it can be found in Volume 2 of the AMD64
>>>> Architecture Programmer's Manual under Section 15.39.
>>>>
>>>> This series extends the mediated PMU framework with a hardware-switched
>>>> mode and adds the AMD (SVM) implementation, including nested support.
>>>>
>>>> Performance
>>>> -----------
>>>> The difference in the world switch overhead between software-switched
>>>> and hardware-switched modes is measured with the x86/vmexit test from
>>>> kvm-unit-tests on a system with an AMD EPYC 9755 processor. The values
>>>> are in cycles per operation (lower is better), averaged over 5 runs.
>>>>
>>>> ------------------------------------------------------------------------
>>>> test                               sw-switched  hw-switched         gain
>>>> ------------------------------------------------------------------------
>>>> cpuid                                     5333         2592       +51.4%
>>>> vmcall                                   15858         7619       +52.0%
>>>> wbinvd                                    5256         2517       +52.1%
>>>> invd                                      1857         2147       -15.6%
>>>> mov_from_cr8                                18           18         0.0%
>>>> mov_to_cr8                                 157          156        +0.6%
>>>> inl_from_pmtimer                         25934        21176       +18.3%
>>>> inl_from_qemu                            25881        21156       +18.3%
>>>> inl_from_kernel                           5521         2772       +49.8%
>>>> outl_to_kernel                            5522         2778       +49.7%
>>>> mov_dr                                     114          114         0.0%
>>>> self_ipi_sti_nop                          1020         1015        +0.5%
>>>>   ipi self_ipi_sti_nop                     310          307        +1.0%
>>>>   eoi self_ipi_sti_nop                     242          241        +0.4%
>>>> self_ipi_sti_hlt                          2714         2704        +0.4%
>>>>   ipi self_ipi_sti_hlt                     310          307        +1.0%
>>>>   eoi self_ipi_sti_hlt                     242          240        +0.8%
>>>> self_ipi_tpr                              1272         1263        +0.7%
>>>>   ipi self_ipi_tpr                         309          307        +0.6%
>>>>   eoi self_ipi_tpr                         241          240        +0.4%
>>>> self_ipi_tpr_sti_nop                      1304         1295        +0.7%
>>>>   ipi self_ipi_tpr_sti_nop                 309          307        +0.6%
>>>>   eoi self_ipi_tpr_sti_nop                 242          241        +0.4%
>>>> self_ipi_tpr_sti_hlt                      3003         2991        +0.4%
>>>>   ipi self_ipi_tpr_sti_hlt                 309          307        +0.6%
>>>>   eoi self_ipi_tpr_sti_hlt                 242          240        +0.8%
>>>> x2apic_self_ipi_sti_nop                    899          895        +0.4%
>>>>   ipi x2apic_self_ipi_sti_nop              191          190        +0.5%
>>>>   eoi x2apic_self_ipi_sti_nop              242          241        +0.4%
>>>> x2apic_self_ipi_sti_hlt                   2592         2587        +0.2%
>>>>   ipi x2apic_self_ipi_sti_hlt              191          190        +0.5%
>>>>   eoi x2apic_self_ipi_sti_hlt              242          241        +0.4%
>>>> x2apic_self_ipi_tpr                       1159         1151        +0.7%
>>>>   ipi x2apic_self_ipi_tpr                  193          193         0.0%
>>>>   eoi x2apic_self_ipi_tpr                  241          240        +0.4%
>>>> x2apic_self_ipi_tpr_sti_nop               1189         1180        +0.8%
>>>>   ipi x2apic_self_ipi_tpr_sti_nop          193          193         0.0%
>>>>   eoi x2apic_self_ipi_tpr_sti_nop          242          241        +0.4%
>>>> x2apic_self_ipi_tpr_sti_hlt               2887         2875        +0.4%
>>>>   ipi x2apic_self_ipi_tpr_sti_hlt          194          192        +1.0%
>>>>   eoi x2apic_self_ipi_tpr_sti_hlt          242          239        +1.2%
>>>> ple_round_robin                             19           19         0.0%
>>>> wr_kernel_gs_base                           73           73         0.0%
>>>> wr_ibpb_msr                                563          557        +1.1%
>>>> wr_tsc_adjust_msr                         5352         2603       +51.4%
>>>> rd_tsc_adjust_msr                         5330         2586       +51.5%
>>>> toggle_cr0_wp                            11319         5810       +48.7%
>>>> toggle_cr4_pge                           11743         6242       +46.8%
>>>> mmio-no-eventfd:pci-mem                  31890        26835       +15.9%
>>>> mmio-wildcard-eventfd:pci-mem             6461         3666       +43.3%
>>>> mmio-datamatch-eventfd:pci-mem            6449         3671       +43.1%
>>>> portio-no-eventfd:pci-io                 25218        21455       +14.9%
>>>> portio-wildcard-eventfd:pci-io            5512         2774       +49.7%
>>>> portio-datamatch-eventfd:pci-io           5524         2780       +49.7%
>>>> ------------------------------------------------------------------------
>>> Just curious what causes the gain difference between these test cases?
>>> Different vm-exit/vm-entry number in each test case? Suppose the cost for
>>> saving/restoring PMU MSRs on each vm-exit/vm-entry should be same or close.
>>>
>> In this case, the cost is actually lower when hardware handles save-restore
>> of PMU MSRs. Hardware can use fastpaths and optimizations which an usual
>> RDMSR/WRMSR sequence cannot.
> 
> Thanks. My question is why the different test case show so much difference
> on the gains, e.g., cpuid has +51%, while invd has -15%. Per my
> understanding, the cost of saving/restoring PMU MSRs for most vm-exits
> (exclude the fastpath vm-exit) should be fixed even for different vm-exit
> reasons. Is it true? 
> 

I see. Yes, the absolute savings for the PMU context switch is roughly the
same across all the test cases. I will clarify this in the next version.

> 
>>
>>>> The largest gains are for wbinvd (+52.1%), vmcall (+52.0%), and cpuid
>>>> (+51.4%), followed by the TSC-adjust MSR accesses (~+51%), the
>>>> kernel-handled port I/O paths (~+50%), and the control-register toggles
>>>> (~+47-49%). The wildcard and datamatch MMIO / port-I/O paths improve by
>>>> ~+43-50%, while the slower no-eventfd MMIO / port-I/O and pmtimer/qemu
>>>> port-I/O paths improve by ~+15-18%.
>>>>
>>>> The only meaningful regression is invd (-15.6%). The self-IPI and EOI
>>>> subtests move by at most 1.2% and wr_kernel_gs_base is unchanged, all
>>>> within run-to-run noise.
>>>>
>>>> Design
>>>> ------
>>>>   * The entity responsible for switching the guest PMU state is tracked
>>>>     per-VM via a new set of mediated PMU capability flags in kvm_arch.
>>>>     In software-switched mode the state resides in struct kvm_pmu; in
>>>>     hardware-switched mode it resides in the vendor save area.
>>>>   * Event filtering, instruction emulation, and intercepted RDPMC still
>>>>     need the state in struct kvm_pmu, so new vendor state-sync PMU ops
>>>>     synchronize specific MSRs between struct kvm_pmu and the vendor
>>>>     save area on demand.
>>>>   * On SVM, the feature depends on VNMI for guest PMI delivery and is
>>>>     controlled by the new "vpmc" kvm_amd module parameter, enabled by
>>>>     default when the host supports it and mediated PMU is enabled.
>>>>
>>>> Limitations
>>>> -----------
>>>>   * Not supported for SEV-ES and SEV-SNP guests: the guest PMU state
>>>>     resides in an encrypted VMSA that is inaccessible to the event
>>>>     filtering logic.
>>>>   * With VNMI and no AVIC, overflow interrupts are always delivered as
>>>>     NMIs because the APIC is emulated and the LVTPC is ignored. This
>>>>     shows up as expected behavioral differences in the x86/pmu test of
>>>>     kvm-unit-tests.
>>>>
>>>> Overview
>>>> --------
>>>> Patches 1-3 extend the mediated PMU framework with hardware-switched
>>>> mode: the capability flags, the vendor state-sync ops, and the generic
>>>> support. Patches 4-6 add the SVM enablement: the PerfCtrVirt feature
>>>> bit, the VMCB save-area fields, and the SVM implementation. Patch 7
>>>> adds nested (nSVM) support to use the feature with L2 guests. Patch 8
>>>> explicitly disables the feature for SEV-ES and SEV-SNP guests.
>>>>
>>>> Tested with kvm-unit-tests (KUT) and perf fuzzer. KUT's x86/pmu test
>>>> requires patching to accept overflow interrupts as NMIs (limitation
>>>> because of VNMI ignoring the LVTPC). It is recommended to apply the
>>>> following patches before testing.
>>>> https://lore.kernel.org/kvm/3bfbf15c22652ba00cf4a16fe9e0a3bfe7071f97.1784096302.git.sandipan.das@amd.com/
>>>> https://lore.kernel.org/kvm/b075ec13e95167da1f2229626713c91d291bb75b.1784097178.git.sandipan.das@amd.com/
>>>> https://lore.kernel.org/all/106bc3a4660653cb7750f3ae07a4dbca42c2762c.1786356229.git.sandipan.das@amd.com/
>>>>
>>>> base-commit: 6cf46b37b0356b3408f8ba949e10462cc71b533d
>>>>              (tag: kvm-x86-next-2026.08.07)
>>>>
>>>> Previous versions can be found at:
>>>> rfc: https://lore.kernel.org/kvm/cover.1762960531.git.sandipan.das@amd.com/
>>>>
>>>> Changes in v1:
>>>>   * Introduce mediated PMU capabilities for hardware PMU virtualization
>>>>     features instead of perf PMU capabilities.
>>>>   * Make VNMI a hard requirement since AVIC can be inhibited.
>>>>   * Introduce new PMU ops to access VMCB PMU state instead of relying
>>>>     on host-initiated {get,set}_msr() ops.
>>>>   * Make VMCB PMU state accessible via KVM_{GET,SET}_MSRS for migration.
>>>>   * Implement support for nested SVM.
>>>>   * Disable support for SEV-ES and SEV-SNP guests explicitly.
>>>>
>>>> Sandipan Das (8):
>>>>   KVM: x86/pmu: Add mediated PMU capability flags
>>>>   KVM: x86/pmu: Add PMU ops for vendor state sync
>>>>   KVM: x86/pmu: Add support for hardware-switched PMU
>>>>   x86/cpufeatures: Add PerfCtrVirt feature bit
>>>>   KVM: SVM: Add VMCB fields for PMC virtualization
>>>>   KVM: SVM: Add support for hardware-switched PMU
>>>>   KVM: nSVM: Add support for hardware-switched PMU
>>>>   KVM: SEV: Disallow the use of hardware-switched PMU
>>>>
>>>>  arch/x86/include/asm/cpufeatures.h     |   1 +
>>>>  arch/x86/include/asm/kvm-x86-pmu-ops.h |   3 +
>>>>  arch/x86/include/asm/kvm_host.h        |  11 +++
>>>>  arch/x86/include/asm/svm.h             |  13 ++-
>>>>  arch/x86/kvm/cpuid.c                   |   1 +
>>>>  arch/x86/kvm/pmu.c                     | 102 +++++++++++++++++----
>>>>  arch/x86/kvm/pmu.h                     |  29 ++++++
>>>>  arch/x86/kvm/svm/nested.c              |  45 +++++++++-
>>>>  arch/x86/kvm/svm/pmu.c                 | 117 +++++++++++++++++++++++++
>>>>  arch/x86/kvm/svm/sev.c                 |   3 +
>>>>  arch/x86/kvm/svm/svm.c                 |  58 +++++++++++-
>>>>  arch/x86/kvm/svm/svm.h                 |  19 ++++
>>>>  arch/x86/kvm/vmx/pmu_intel.c           |   2 +
>>>>  arch/x86/kvm/vmx/vmx.c                 |   3 +-
>>>>  arch/x86/kvm/x86.c                     |   2 +
>>>>  15 files changed, 384 insertions(+), 25 deletions(-)
>>>>

