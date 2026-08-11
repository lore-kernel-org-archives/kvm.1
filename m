Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53441A554
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437498; cv=fail; b=pQxOdxJ3bIzC5EfuuMAlQKsSE6NM/GeC/Abhr2y4PzwBHX97J9Nv+tOLqZOECtZovrEw2zBzOCg/jVbRa4vRvz+phBVJ2ytJjHx3EI3IujUc8c2mEl7UCMJXZnOYBREMuFIITXkyPAjKkIlCzMv0hQF4sB2uwXF/e5k+vDbWyAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437498; c=relaxed/simple;
	bh=sxcgHkqBqRBxH0M5I2rk/hXiAghYdiUqczuCLmxGPZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uoj6FVaS3kBU1iUtcxt25YVMyfjdHKvGHgHiZ6HEizvz2rzuK+lnt3OGoKVWsXYBmg9RZYL27OoHEl1659I+gZ11VKeMEfTT70khnCdQ4HU8VGNFZ/9dBqEWdZ5CwLtRHSYJWZ1eaN2D3IymNMJ2oUsmchwq7k3nRvM77YVHe4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Du8oHzSz; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Du8oHzSz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReSEcC4L51dITVP1eAjNOcyEkTKMKjtth85DqdVcF1+4ovbm7h7VjBtddnHf0WiVpDg51KjEtCFp06GkcaoHGR9JkfDVNpAfX9DUfPko4+6ijxFbAxoPxu5/ZhtVHIk+E/hntPGSNA0JYf3nBJBEecgPFU8O+uwSqXgscXpgcGufTDEfrNMK2g4TTrM5c/2UHJdWza1E6I5+bcpDkgbEnfmcmjJ2DBjd8OR3OGEm5SZahoU26HoH5nYuuTtPNnBAj/VMtwZwTMiqc2ZwIZfoa+/sM5fyYzJNbFJlM56HGVQUAlSGPXwa/9HPglbQ9eIXSNr/z812ruVFxr4jsjusqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XnTLK4M1pGpBIwFBL1L2uZZYQ7bYqSoYPFnMkJ2Pr0=;
 b=JbOJzgokodB+Soa3jMjVkQVSB7btTS0D0j5EuLw/md+n11EC/emm68iRwVP6aIAirUl+TKFu8sGvRQrxCQ9xqHxlu1TnlVZzhyPxlymCUBU7s4A8QwkNJIRvv7S1YKorp+3wGGuC4t9Rvo96A8UbJ1e9Beb0jRao2soodMyRytUqucht2jj97ypgVq6/nb/IFDPpsd9sjpC8Qsrwof/sS/LXtQvUHzMOwm+BrkHDnzbIyWJ2cv4sAKZ1E4Y+0UTZ/lIenqqzbO6Ss9Kn7gkTjeYjXQwug4+r+Ay6KtsbU2IYphxr74BWZydZbHoyD7YVpjfS5qYWXl5sXvpCr/JPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XnTLK4M1pGpBIwFBL1L2uZZYQ7bYqSoYPFnMkJ2Pr0=;
 b=Du8oHzSzVAIRs5vu5UmUEONCFZ34ovKp9qkRN5JXPFYMSqSkSRjbmrxXD+TWxx9pAnhM2PzPk+IAJM/t9W3qHmsqlUgz0nyeSp7J4R4Cv76FPn6fngqGjG9BMrNJW3Dtv/IAfpAI3UYXfC6PLkEc1Xb8QoCx7xqXul6x7zjo/c4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 08:38:07 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 08:38:06 +0000
Message-ID: <c240acb1-22ac-48cd-9243-792f415171c3@amd.com>
Date: Tue, 11 Aug 2026 14:07:53 +0530
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
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <32239a68-5ba8-4985-b959-1959f331f30a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:260::9) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d13a579-a5ec-4306-ec28-08def783dd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|6133799003|3023799007|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xqcc1sYJYeYKnqlDgTEyGRqeNYRCXJkpd2Ai3ZCbbMlSAvwZHlB37F68jjT4vYNdfEAmTMi1kIqSxSvNlOvbL/DBS1jqu5I1vNi8x6I5OX2UtHD11rpPNmApPzMBcump/0nEVHFRlLW7T9y8gUspyOQUK/eKz7YakZSp8apn1liRrkKcj1gW2EWBIyrZskkoyNg52iRTtU4A3ZRQtmixY5679oWqdKO+w5AHpECrZbiUBXQnw+myctixqh4d/njk6LC99wkPRawZnqUHMuUeqfh0lGjXjwKvFWxihp5Ko2HxTD20cdQK4qzU4KRAjukAB+u/YY3WPDqec691CjSO9e/1YmjuZjqb2LWx53dHgPzLlh/3NPmnA51LkJ/gbImWQN3VxqBoV/0qfNyosarVA14sJQu+zARkKODxSQgHw6XBSl3meVwCPl8baClOikwRslJLKT4+WytWBxUXzIm65lALnuqPhLk5/8MQofbUMNPxCFO5WUXvCTr49Cjcj1Ya0VJANyFO9b7IL3L4rmwFhw/VejT7uizZTNiwMUXceoY0/v3KJ3BHRioosLEi1aIqC3L+/ZrbhaRYBqK5AnjXqLd5nSLeJAiK/HnaCKXYohgBN41I2Q3APW7WUcQM9RgL2KdfeeabGds7BGQVjN41ztVUymSl2zKfIsovhL6P4qA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(6133799003)(3023799007)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkp6V05ORC9OM3p1Q1U2ZVpKMWpJbWJad0ZvczFVVHF5S2dZS2QxejM4TTEw?=
 =?utf-8?B?bUh0eDFGeU9JUm14OVRXQnBzVkh0UGpmODNqTHU2bm1HYXovM0NRdDVMNS91?=
 =?utf-8?B?SE0wMFd0Y1c4T0toS1kxRVIzUXdrVEs5TkF3N0Rsai9UcXptM2xiTlRtRjYw?=
 =?utf-8?B?ZE9mUlV2R3BveHZ2TjZaTndGNkh6cGhPeVVmWEVvU3JhVEtpWW1VYmdXZlVN?=
 =?utf-8?B?TlptVGpXZnBLYnlHWVFzaG1YZGsvdjNrTDM1RksybitvUVlNYmk1KzVBcXcz?=
 =?utf-8?B?bzRwRFU4TkdnZmplbkNrWkxnRlJ3c2daY0FrVlRXNlRpMHhBN2VqUmNKdTE5?=
 =?utf-8?B?WWpiMnFORVBKQkNnR3N1cUozSXF2L3k2emZ6ZHNvVG5kcWRMZjdhbGkwNzlr?=
 =?utf-8?B?K2xRekVjM1BsL2pJUURYUEFHZHoyWWVxcTlSRmZWVFdJOG5FblN1RE0zTHAz?=
 =?utf-8?B?K2s4eEsxa0t0dnFMeFFqKy82LzhaSDR0WmcrbnZmc3FXZCsxTnBuWktHN0sr?=
 =?utf-8?B?c2Z4MmtiS2kyemk1bisvWjl1ZXZiRU9IZkF3QTV2dndXSERoK1NLd0lBL0Z3?=
 =?utf-8?B?d3VwRFRGZVhNS2dWcGlNZzA1NWpVQjR5U2FDaEFrazY4ZXY0NlZ6YWFtUlU0?=
 =?utf-8?B?OWRGRHRlZ2Rrcy9SNEhlYnZFTFJ5YU9PZUVBcWZiMlI3eWxOZGdSdDhzSERz?=
 =?utf-8?B?dUNkYnBObjgwV1hEU3c2WE1Lc1VlRTV2R2xtcHA1ZkdpdVVrYXpVYkViczFQ?=
 =?utf-8?B?QnU0a05XLzNwazVZNFMwVktMRTZUUERPNGcyZmxMWTlGdTR3blZ5VlpkbkN3?=
 =?utf-8?B?M0VCNFpQSzdxQjVhOXRvb256eFJBUTlhSHFBYloyTE5jR0RLTmhXUU4vVHpC?=
 =?utf-8?B?VlM0b1hMSGRkTC9KcGVHZzAvYUwydnpMNmIwN2pIcnhTR2k2QW05Z2I4SnB6?=
 =?utf-8?B?TmpJbVlkOGVIR2pYQjBRZ3NsM096ZDRMZzhocG92bEE1bFZXc3ZtWDdnQXNI?=
 =?utf-8?B?RDRlNFJpZXpOTndqQU5vK25wM0FzSzZ4MnhTSVRQNGRGN0tqY3U2cVl6emVr?=
 =?utf-8?B?K3RPRy9lVGhDeWg1NHNLdmhCYUZPNDRCZndqcmY1bXlHN1lPUWFKVndWdWRJ?=
 =?utf-8?B?UmFhbFYvbDl1WUZKRHpsOUhNekNjSTFaQkJqbkpmd0t4YTBXaHZLS1BlZ0FD?=
 =?utf-8?B?cC9ValoxUUUyR25TYlVCc1d5VmJocjR5REczYjdvMzVSbDlFSkdQRzZrMGhY?=
 =?utf-8?B?N00vL1IvM0ZTdElQRFlzQ1NYNlg0cEx4QndRd2VITmNmeEJSQmtnMGpxM3hv?=
 =?utf-8?B?ZWtHSDdwK1gzRkd1bGtWRDNta2t2N3R6cnBQaXdjNVJrZ1RnektneWJ1c3Bp?=
 =?utf-8?B?dG9xa0lvcWRLRDBJb0pHaUlvZDFVUE91a1F6bTRkMkwyTU5EV3c2NkU5dnJl?=
 =?utf-8?B?OVA2N2xQa0RPckl3RGpsQVRIcHpueUc5RFRuN1JGcGZyOWRtN3NsZEFSWmcr?=
 =?utf-8?B?N0NRS1FsbGxQbmlxOFZnZTd1ZUlpUGUzYU0vQVdrWWRkTVF1cnAyZnJVdmFF?=
 =?utf-8?B?MUJtcTJiOUFLcDJ6TlJIY1RMOXBpU29oWmN6YVhMQ1hpdTBDM2VURnhzN3hS?=
 =?utf-8?B?SDJhQjJxUGJTQ3dFd0ZPN2NLdHkzWWJIbDNhclJuMWQ4UzlsT29KcFRHUDEr?=
 =?utf-8?B?SzBxdmdndzJGOW1adGVMSjV6Nzh4bmgyYU1tUU0zS2ZVbTJKcGZkVHY4VG0r?=
 =?utf-8?B?eTNRbEh2VHk2c3FqSzFqMEI4V1psc3RtS21ONVFXbUhNakdYYXBOdmYyL2Np?=
 =?utf-8?B?STI2RTc5cFlmMStrZGV5enJKa3l6YlNQaGNIZTd3VjdaT3dNZ29UNGdrZjlh?=
 =?utf-8?B?NUhzUGhEdngwckVmNDFyWWYxQzNaM01leERUSzg2VllFTFBOa2FrbStKdDNt?=
 =?utf-8?B?NkVUZHBEQXdQMHhyZHNKRWY3ZlFOVmpTN2k1dXlPUUcrZDF6Q2wxOUoxUXFi?=
 =?utf-8?B?NGRMODV3N3VtOUdZdTFLNjcxcUU4OXUyYmVIdDBtS1BLdzJKQzZpdllCUUZD?=
 =?utf-8?B?c0ZWNDFPUTZEOEFrTGk1OEZZTUhwR0lpcEticWVZVm54TG9FOGk4V0NPZzJt?=
 =?utf-8?B?Qjl1a3pPWHVuU1k3a3FwYzZISFB3QzVyeEwrdVV4dXpEdmhlWmp1YTdWQzhE?=
 =?utf-8?B?Y1phenVMSFBCSkxVNFM0eU1TVGdQZSttby9jV3UwWjVkeUE3c2dzclVaZ2lF?=
 =?utf-8?B?TFVjeUlyTGpNUms1SkdlbzlWaTh4OWxaNHNyVmJYdmY1dHlydzZGd0hxQ3Ux?=
 =?utf-8?B?ZHFFYVZBZnFsY2FpVVIrWWplS2VlOFFIU2NBTGc0bDFCeW1xNVIyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d13a579-a5ec-4306-ec28-08def783dd87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 08:38:06.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTcgpXBWep06TQpS8a9LA+WnhaMjtC3WP62sHN6RSlLvrzrdHOw40HAV1Q0g66kTlmUEsYdjRItZSmB1Tn8sVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444

On 11-08-2026 13:19, Mi, Dapeng wrote:
> 
> On 8/10/2026 6:14 PM, Sandipan Das wrote:
>> Mediated PMU currently saves and restores the guest PMU state in
>> software on every world switch. On Zen 5 and later processors, it is
>> possible to offload this to the hardware, which automatically saves and
>> restores the guest counter state to and from a vendor save area (VMCB)
>> during world switches. This feature is called PMC virtualization and
>> detailed information about it can be found in Volume 2 of the AMD64
>> Architecture Programmer's Manual under Section 15.39.
>>
>> This series extends the mediated PMU framework with a hardware-switched
>> mode and adds the AMD (SVM) implementation, including nested support.
>>
>> Performance
>> -----------
>> The difference in the world switch overhead between software-switched
>> and hardware-switched modes is measured with the x86/vmexit test from
>> kvm-unit-tests on a system with an AMD EPYC 9755 processor. The values
>> are in cycles per operation (lower is better), averaged over 5 runs.
>>
>> ------------------------------------------------------------------------
>> test                               sw-switched  hw-switched         gain
>> ------------------------------------------------------------------------
>> cpuid                                     5333         2592       +51.4%
>> vmcall                                   15858         7619       +52.0%
>> wbinvd                                    5256         2517       +52.1%
>> invd                                      1857         2147       -15.6%
>> mov_from_cr8                                18           18         0.0%
>> mov_to_cr8                                 157          156        +0.6%
>> inl_from_pmtimer                         25934        21176       +18.3%
>> inl_from_qemu                            25881        21156       +18.3%
>> inl_from_kernel                           5521         2772       +49.8%
>> outl_to_kernel                            5522         2778       +49.7%
>> mov_dr                                     114          114         0.0%
>> self_ipi_sti_nop                          1020         1015        +0.5%
>>   ipi self_ipi_sti_nop                     310          307        +1.0%
>>   eoi self_ipi_sti_nop                     242          241        +0.4%
>> self_ipi_sti_hlt                          2714         2704        +0.4%
>>   ipi self_ipi_sti_hlt                     310          307        +1.0%
>>   eoi self_ipi_sti_hlt                     242          240        +0.8%
>> self_ipi_tpr                              1272         1263        +0.7%
>>   ipi self_ipi_tpr                         309          307        +0.6%
>>   eoi self_ipi_tpr                         241          240        +0.4%
>> self_ipi_tpr_sti_nop                      1304         1295        +0.7%
>>   ipi self_ipi_tpr_sti_nop                 309          307        +0.6%
>>   eoi self_ipi_tpr_sti_nop                 242          241        +0.4%
>> self_ipi_tpr_sti_hlt                      3003         2991        +0.4%
>>   ipi self_ipi_tpr_sti_hlt                 309          307        +0.6%
>>   eoi self_ipi_tpr_sti_hlt                 242          240        +0.8%
>> x2apic_self_ipi_sti_nop                    899          895        +0.4%
>>   ipi x2apic_self_ipi_sti_nop              191          190        +0.5%
>>   eoi x2apic_self_ipi_sti_nop              242          241        +0.4%
>> x2apic_self_ipi_sti_hlt                   2592         2587        +0.2%
>>   ipi x2apic_self_ipi_sti_hlt              191          190        +0.5%
>>   eoi x2apic_self_ipi_sti_hlt              242          241        +0.4%
>> x2apic_self_ipi_tpr                       1159         1151        +0.7%
>>   ipi x2apic_self_ipi_tpr                  193          193         0.0%
>>   eoi x2apic_self_ipi_tpr                  241          240        +0.4%
>> x2apic_self_ipi_tpr_sti_nop               1189         1180        +0.8%
>>   ipi x2apic_self_ipi_tpr_sti_nop          193          193         0.0%
>>   eoi x2apic_self_ipi_tpr_sti_nop          242          241        +0.4%
>> x2apic_self_ipi_tpr_sti_hlt               2887         2875        +0.4%
>>   ipi x2apic_self_ipi_tpr_sti_hlt          194          192        +1.0%
>>   eoi x2apic_self_ipi_tpr_sti_hlt          242          239        +1.2%
>> ple_round_robin                             19           19         0.0%
>> wr_kernel_gs_base                           73           73         0.0%
>> wr_ibpb_msr                                563          557        +1.1%
>> wr_tsc_adjust_msr                         5352         2603       +51.4%
>> rd_tsc_adjust_msr                         5330         2586       +51.5%
>> toggle_cr0_wp                            11319         5810       +48.7%
>> toggle_cr4_pge                           11743         6242       +46.8%
>> mmio-no-eventfd:pci-mem                  31890        26835       +15.9%
>> mmio-wildcard-eventfd:pci-mem             6461         3666       +43.3%
>> mmio-datamatch-eventfd:pci-mem            6449         3671       +43.1%
>> portio-no-eventfd:pci-io                 25218        21455       +14.9%
>> portio-wildcard-eventfd:pci-io            5512         2774       +49.7%
>> portio-datamatch-eventfd:pci-io           5524         2780       +49.7%
>> ------------------------------------------------------------------------
> 
> Just curious what causes the gain difference between these test cases?
> Different vm-exit/vm-entry number in each test case? Suppose the cost for
> saving/restoring PMU MSRs on each vm-exit/vm-entry should be same or close.
> 

In this case, the cost is actually lower when hardware handles save-restore
of PMU MSRs. Hardware can use fastpaths and optimizations which an usual
RDMSR/WRMSR sequence cannot.

> 
>>
>> The largest gains are for wbinvd (+52.1%), vmcall (+52.0%), and cpuid
>> (+51.4%), followed by the TSC-adjust MSR accesses (~+51%), the
>> kernel-handled port I/O paths (~+50%), and the control-register toggles
>> (~+47-49%). The wildcard and datamatch MMIO / port-I/O paths improve by
>> ~+43-50%, while the slower no-eventfd MMIO / port-I/O and pmtimer/qemu
>> port-I/O paths improve by ~+15-18%.
>>
>> The only meaningful regression is invd (-15.6%). The self-IPI and EOI
>> subtests move by at most 1.2% and wr_kernel_gs_base is unchanged, all
>> within run-to-run noise.
>>
>> Design
>> ------
>>   * The entity responsible for switching the guest PMU state is tracked
>>     per-VM via a new set of mediated PMU capability flags in kvm_arch.
>>     In software-switched mode the state resides in struct kvm_pmu; in
>>     hardware-switched mode it resides in the vendor save area.
>>   * Event filtering, instruction emulation, and intercepted RDPMC still
>>     need the state in struct kvm_pmu, so new vendor state-sync PMU ops
>>     synchronize specific MSRs between struct kvm_pmu and the vendor
>>     save area on demand.
>>   * On SVM, the feature depends on VNMI for guest PMI delivery and is
>>     controlled by the new "vpmc" kvm_amd module parameter, enabled by
>>     default when the host supports it and mediated PMU is enabled.
>>
>> Limitations
>> -----------
>>   * Not supported for SEV-ES and SEV-SNP guests: the guest PMU state
>>     resides in an encrypted VMSA that is inaccessible to the event
>>     filtering logic.
>>   * With VNMI and no AVIC, overflow interrupts are always delivered as
>>     NMIs because the APIC is emulated and the LVTPC is ignored. This
>>     shows up as expected behavioral differences in the x86/pmu test of
>>     kvm-unit-tests.
>>
>> Overview
>> --------
>> Patches 1-3 extend the mediated PMU framework with hardware-switched
>> mode: the capability flags, the vendor state-sync ops, and the generic
>> support. Patches 4-6 add the SVM enablement: the PerfCtrVirt feature
>> bit, the VMCB save-area fields, and the SVM implementation. Patch 7
>> adds nested (nSVM) support to use the feature with L2 guests. Patch 8
>> explicitly disables the feature for SEV-ES and SEV-SNP guests.
>>
>> Tested with kvm-unit-tests (KUT) and perf fuzzer. KUT's x86/pmu test
>> requires patching to accept overflow interrupts as NMIs (limitation
>> because of VNMI ignoring the LVTPC). It is recommended to apply the
>> following patches before testing.
>> https://lore.kernel.org/kvm/3bfbf15c22652ba00cf4a16fe9e0a3bfe7071f97.1784096302.git.sandipan.das@amd.com/
>> https://lore.kernel.org/kvm/b075ec13e95167da1f2229626713c91d291bb75b.1784097178.git.sandipan.das@amd.com/
>> https://lore.kernel.org/all/106bc3a4660653cb7750f3ae07a4dbca42c2762c.1786356229.git.sandipan.das@amd.com/
>>
>> base-commit: 6cf46b37b0356b3408f8ba949e10462cc71b533d
>>              (tag: kvm-x86-next-2026.08.07)
>>
>> Previous versions can be found at:
>> rfc: https://lore.kernel.org/kvm/cover.1762960531.git.sandipan.das@amd.com/
>>
>> Changes in v1:
>>   * Introduce mediated PMU capabilities for hardware PMU virtualization
>>     features instead of perf PMU capabilities.
>>   * Make VNMI a hard requirement since AVIC can be inhibited.
>>   * Introduce new PMU ops to access VMCB PMU state instead of relying
>>     on host-initiated {get,set}_msr() ops.
>>   * Make VMCB PMU state accessible via KVM_{GET,SET}_MSRS for migration.
>>   * Implement support for nested SVM.
>>   * Disable support for SEV-ES and SEV-SNP guests explicitly.
>>
>> Sandipan Das (8):
>>   KVM: x86/pmu: Add mediated PMU capability flags
>>   KVM: x86/pmu: Add PMU ops for vendor state sync
>>   KVM: x86/pmu: Add support for hardware-switched PMU
>>   x86/cpufeatures: Add PerfCtrVirt feature bit
>>   KVM: SVM: Add VMCB fields for PMC virtualization
>>   KVM: SVM: Add support for hardware-switched PMU
>>   KVM: nSVM: Add support for hardware-switched PMU
>>   KVM: SEV: Disallow the use of hardware-switched PMU
>>
>>  arch/x86/include/asm/cpufeatures.h     |   1 +
>>  arch/x86/include/asm/kvm-x86-pmu-ops.h |   3 +
>>  arch/x86/include/asm/kvm_host.h        |  11 +++
>>  arch/x86/include/asm/svm.h             |  13 ++-
>>  arch/x86/kvm/cpuid.c                   |   1 +
>>  arch/x86/kvm/pmu.c                     | 102 +++++++++++++++++----
>>  arch/x86/kvm/pmu.h                     |  29 ++++++
>>  arch/x86/kvm/svm/nested.c              |  45 +++++++++-
>>  arch/x86/kvm/svm/pmu.c                 | 117 +++++++++++++++++++++++++
>>  arch/x86/kvm/svm/sev.c                 |   3 +
>>  arch/x86/kvm/svm/svm.c                 |  58 +++++++++++-
>>  arch/x86/kvm/svm/svm.h                 |  19 ++++
>>  arch/x86/kvm/vmx/pmu_intel.c           |   2 +
>>  arch/x86/kvm/vmx/vmx.c                 |   3 +-
>>  arch/x86/kvm/x86.c                     |   2 +
>>  15 files changed, 384 insertions(+), 25 deletions(-)
>>

