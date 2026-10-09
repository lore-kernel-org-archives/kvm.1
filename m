Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD640471432;
	Fri,  9 Oct 2026 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574846; cv=fail; b=I45XeOaR4/pc1LYEGZzn10UlMDCTyZAt2ZYnYtRGLrKrWgEKy1am/lcEi1OzM/5deDd2A/PCEHAPmhA7JAxxMMqNRyCTcB5EprDu08l/Eem+R/8FTqzceF3CYSj2YIK9ZidL6bjbDkQ09RU7FgjpvcROLjF0AmfNgPSQEMKDCws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574846; c=relaxed/simple;
	bh=ADEV4cXWcOVCHBTnjtdWBnM9brDDpOvZN8isu/CqH2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qw26EgGAsEiaHso6psMPSDtNycAU5XleFyxARtN9stJgCZbpa5BeZgPolenoQbbeWrd3gDvNXNkVGOZJBi22+uueKCvBDboUdBPsbPsZ9aDER6r6rimLP99WnegNdzcocT/ScMNC201a1zUtwjWohUZD+TyUDvxVsbPDWQ62M7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=py7tOfgo; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="py7tOfgo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpS3zmY+v6MskZX/Fn3/nQAyd3XsfLmWWkALkSqn7NdLPlYFLUjY0ohTg8XwG86aHXAFYwUdEUjwp2Ruh0qdfrd2DKLbqgzRJSbKYHxL32nfvBNphKFhopiotsKWAmwHX7OLVuh4gSRD2bLragY362oanPY/jVKQIX8KLzaAiBYJojReXEHbRmFh6Mp2HGTY/yBWvJ9ru1f8MCafczQyqK1q0oVFquMVisepK3PwOuhFnQMiQdQJEWjFNgxolaihpNAhXFZqhIhs93zycO6n9+7IOO9njVwXOzLQlVQkfHvwcK7ocqbJFvtn8nzsbL9mc3eFAmfnnt/h00iUtXK44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV7duCg4WM78mILFv1iQ6/CGekYOpKh4DuzLzCLAsfw=;
 b=EsXHynHdpwfwqvl373tLzKxez8BIOxZ+UlPlAOP8qm65yh/xsoRU/jAhXRu+d7CB4pFnLkp0LdDy9mugOV6oRC2uz3nqTouy2Bq5chLGE/EkB3h89GXvk89cMQY0LvHbUUuAtSxDdZFszLABINvGxQuII/LGbeQjCnaZI1DIjwviWWrWc7ed1kaeZJ4Sj/6I5XrAT7tKF2mtze1hjGwh1M3hlclsKubQAvnmut19+4RS9qcEM1hSUOdk5lVSodIwIOlEsQwT2B9HTHIgowrPLeQeGZbFOjTCavXZ5C6YCEuUroI+4Be0T544ZY9qP0TE/02XxaT7ZdGbUkpJTplBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV7duCg4WM78mILFv1iQ6/CGekYOpKh4DuzLzCLAsfw=;
 b=py7tOfgo6+kWX4SuOSoaPVWm5T0kKz7OpQKFe50cBIuBFCE04FCUfbqameMBJo7Ul+itwtUlITZDYmg1+VKRv1NcxNFECrxaAiHWSbK8le3WNXLfheX7MVBvzH28jfTT3I6xdNi/65vAGjcr6rLjIYQ0/MB93qX/+0nnYrw3OJI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 19:40:27 +0000
Received: from SJ1PR12MB6217.namprd12.prod.outlook.com
 ([fe80::bdbb:19b0:4f1b:44e5]) by SJ1PR12MB6217.namprd12.prod.outlook.com
 ([fe80::bdbb:19b0:4f1b:44e5%6]) with mapi id 15.21.0451.034; Fri, 9 Oct 2026
 19:40:27 +0000
Message-ID: <b1145255-a272-4f92-982d-ea3131463287@amd.com>
Date: Fri, 9 Oct 2026 15:40:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/4] KVM: SVM: Add host support for Enhanced SMT
 Protection
To: Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, seanjc@google.com, pbonzini@redhat.com,
 kim.phillips@amd.com, nikunj@amd.com, michael.roth@amd.com,
 ashish.kalra@amd.com
References: <cover.1791302373.git.prsampat@amd.com>
 <64ea6ba62315d33b7bfb48ec6cab29ac4ee2fa06.1791302373.git.prsampat@amd.com>
 <961ba3a4-3fe2-45de-af56-92efa43ca2b2@amd.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <961ba3a4-3fe2-45de-af56-92efa43ca2b2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:610:e6::16) To SJ1PR12MB6217.namprd12.prod.outlook.com
 (2603:10b6:a03:458::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6217:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cb04c9-5763-4490-c9ec-08df263d2b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|20046099003|56012099006|11063799006|10067099003|6133799003|3023799007|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	XpCqU7Yt835pqPdiutlcYp+kgWoELkTETrqqG2v0phHpSqwBt05X/Wp8ia+u3YsCJZoBvzVZ1W5uuSw0SMvkfQmQvp8YoHjFJoTxv2wOyaRP9mWmglKrAUA/jKT62wXZvO6bpF/cm9H5oejn+whbiR9fcC3C6kmU2mdtR5OSyEJLDEpjEi808Ik/b084/ri+6FnjgnmJvQ1GBmFSVWqvDejlWKGJkpuRp0frfDw6pTR8bqj7FYD9qofL2+DUUolJnN6ZjbuxluxBne8sBR6VXIVoh+qlWwj2TSUAmi20semz/azGkJXH0WGPP+rFEaJ+pfME7PaUMcskpSESagJR4DqPDbhIxavCVSBsesmzpwvVhUHJL60xuyVCr1znqU5ysTyMktdf6oByPNY31cB+13GU3YAGcKv7IoxBKw2yO5L+n8QLJaSDpALu9HJPffCk+qxykNVNAYkwW6G4osLuPoJ/54Xfjmpbzdmh0wPllB35EGOfKqxO1DtCrUlgoYG7L9yHlH3RIqUBdQktZ2ibJOFp5vDDzmRbeakmya2ZPtkNTmaDyDruxSqpFazPk3T8D8EhG6BHAlHBLmESUxU3mosGFZ1aRURUXMfbbdHNkeIwOnuFrAEJ4Cf4M7KT8Z+u+GKcqL5GF9qi5ieCaVN9KaKMaZ6LSvsFirw5WR9VyrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6217.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(20046099003)(56012099006)(11063799006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnFldXY3QzJCVG50TXl6WnZhMjltdnlYSVBGNy9kbFhzMHhvWFJ2TjVqK3lj?=
 =?utf-8?B?SzdFYUJtczk1Q29jM0RSWGdDNGc0eitmb0Z5RUl2VUhobjNGaUJ5SHpZV1Yw?=
 =?utf-8?B?MkdVaVB1ejRzREg4Y083ZFpPYmdsOXdMZjBsL3AydDVYLzRtNGNxRVJ1VTJp?=
 =?utf-8?B?NGxubTdidWVTOHl2MGdqU2lUbzNrZ1M5WmNxdDdrSGE0dzFkZWhpa1RoN25m?=
 =?utf-8?B?VkVCS0IvQ2cyK0FOZ1lxUFdkMmtYNlpqckg0QUN0Skx6eHVpWGJyamRGU1hS?=
 =?utf-8?B?YkcxZzdMY0Q0SkRWWUJjYVRUaHdoVGZYWkFaVnp6dDM5dXYrcWIrWjExNTVH?=
 =?utf-8?B?QW82OEpkTTRISDc5WlpYOEJDdDhwQnAwdWI1MEVYWVhMTnFRTmh4NzFRSmlT?=
 =?utf-8?B?K0FGOWFwOWJWdkgrdFBHRkpoRW1uWDRWVEdLd1B1K2tvRHFiVTFHZTczUXY1?=
 =?utf-8?B?aitPZkVMYlRSS2xGNWR2STBDMWxxR3M0djUyaURhM3lkODc5Q2FTZ0hZUHRm?=
 =?utf-8?B?TUlZK3poRzY5d2RLcEEwbVQ5NVJHTytWL0hPSDk0NnRadFhlK1Jid1V6eU4y?=
 =?utf-8?B?MURvaHVLNlR3ZVZyNlIyYVluSmxDM25UL1N6a29henBhZ0VWd2hjZUNXd0VB?=
 =?utf-8?B?L1o1ei9uYU1vb2hINHpPd1J2WHRBUlByT2tFdk56Z0pkakw1UG1hL0F1UEtx?=
 =?utf-8?B?ZjhtdGVVb05pMjBReEwyUUpUWURub1A0RkRxMVFkNjgrVkQ3NE1OOGNvSy8z?=
 =?utf-8?B?UzhCMjhSK011Mm5Ra2UxcWpBWEFzamNyRVBOQlI3NndJM2g5YVZ3UzdEL1FP?=
 =?utf-8?B?eFdOUHNaZ2VUZE9FN3drZkpzR29oSm5HOTQ2NjV5dG1zakkvK092U3MxTlM2?=
 =?utf-8?B?OVNLME9UbTN1NUtKdjdiWnZKd1RHQ3FMUUJiN3ZCS1hJV2lwck9BWWZUZGlo?=
 =?utf-8?B?S3BLUXdsTTNVcTRkY3JUTXAvUTVIbU4zYk5EUFdBTVNUSXh3U0dVbklLZ1hT?=
 =?utf-8?B?WnpNallzVm5zVlA4YmI5dkhBemVqSEp1TThMZk1kTzNHTExNMkxnam0xbHlB?=
 =?utf-8?B?b0hjR0dkb2swUHlTRkZYZEhEdmk0eDBLME1BcUViRk54M2hVbHlOMVltV2Rq?=
 =?utf-8?B?dzdSekE3dzd4cU1Tdmp0OGRDekNiZ3J0MGZJenMrcmUzbHRWM0VJMUxZL3Vr?=
 =?utf-8?B?VUJmOWIzVHZ0LzZuZW4rdG1obkRJRVd3N1VndG5WVGdmS0RoZHcwY0NYRkwv?=
 =?utf-8?B?amozamZUb1NmMklOUVhzTmovM0J3SjFHSGxrWWY5VFVwRlg5aUhOa1dvQkEv?=
 =?utf-8?B?Ymo3SzNFdE5OTkFpS3FBdDVhdUZNQU1jQVdzWGlpdGVodkZRdjFqS1R5amR2?=
 =?utf-8?B?ajNlRUFiUk9OVzhsL085SzhsViszNWhBeGJFOFUzS2YrS1hPYjdmMlpoS1NT?=
 =?utf-8?B?M0JnM3BYVlJVVStNekh5Nk1IK2NPcitMMDRDKzBTekVxQUJIZElXMURSRjRt?=
 =?utf-8?B?eGpBTjF6Q1ZrUXk1N2pYdVVQamx0UTMyV2p1TDM2N2dsdjhBRDk5NEJMVkhE?=
 =?utf-8?B?Wm9OS0VDeDBaL20wYnJyWHBZZmhLYll3VU9iS2lyZGp0TTkyZC9EUnR2RmtW?=
 =?utf-8?B?cHN1aWtWdFQ5MEtGakFWbStLRkdrVU5yMFRNMDJoVEQwdlFpamxQcXdXNUpk?=
 =?utf-8?B?RU01L2pWR0VmSkp4cG1zSmJ0d09pczNsRXNtL1o1U3BLVXRqRWl0emdKYWgx?=
 =?utf-8?B?Ui95a3ZUSVFwT2xHa01Tc1JxZEtFWkF5SytSVlZ2elJEcEw2ZkxmL1U3Rzhp?=
 =?utf-8?B?SkUxMXNnWW55ZXJFcGNUUUQvQkxjM0paOVNoYkRRaEhkcm1rSjhKQ01mQTVa?=
 =?utf-8?B?VUJSNVZsV0c3T0ZlUEovak9QUjFBMWJPYlJvRW5VVFBVM2htS3VLVEU2NjlG?=
 =?utf-8?B?cjdqUzMwdWhYQnJRZjhhTnFDSDI3UStRL1pwK1pIM2N4SlBBcjBmZDlzaFpG?=
 =?utf-8?B?OE85dFFBSlVUSy9jdDRJZkIvaVhRMTljQVd6TlFoM24yZDVQdytSUjkyQ2Fl?=
 =?utf-8?B?ZmlKekNFSzFGcTgxUWcrbytiNHNwVGxzbzBhNUIrUTB0dXRVVmF5ZUlpMFdM?=
 =?utf-8?B?S1g3dVZJbnVoaWY5Rnh5MHFmanM0Wk9zRmhIdWh2ZFBxdm5ld2I0SE1JUlhV?=
 =?utf-8?B?dnNhTzMrbkV1VHpWWk82Yy80S0h5cWxmMEVsVjI4QXo4Z0FHb0MxMTVlMFB1?=
 =?utf-8?B?L2RnM3Zia00zbWgwaDVRSVRpam1vd0hPQi82VXFVMkZsekM0OWlaaVB5M3NF?=
 =?utf-8?Q?4EZBcVzKn2SBjFkMqh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cb04c9-5763-4490-c9ec-08df263d2b3b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6217.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 19:40:27.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nE/OPtbBPS9uyn2lWuNCMQDSZI0OaBr++N2eK2PUFHXTJLzfrpI4cnuKHhG4u7d6TqEmU2K2wLUf0rpCFk1I5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877

Hi Tom,

On 10/9/26 3:05 PM, Tom Lendacky wrote:
> On 10/6/26 11:54, Pratik R. Sampat wrote:
>> Enhanced SMT Protection (ESMTP) protects an SEV-SNP guest from SMT side
>> channels by requiring that, while a vCPU is in guest mode, its SMT sibling
>> thread is either idle in host mode or executing a vCPU the guest has
>> declared to be a legal sibling. A legal sibling is another ESMTP vCPU of
>> the same guest that carries the same VCPU_SIBLING_MASK and agrees on
>> VCPU_ID outside that mask.
>>
>> Hardware enforces this at VMRUN, which no longer enters guest mode right
>> away but stalls until the condition holds. Three new exits report that it
>> could not be met, all of them non-fatal:
>>
>> ESMTP_ILLSIB: a sibling thread is running a vCPU that is not a legal
>> sibling of this one.
>>
>> ESMTP_TIMEOUT: the stall exceeded the timeout programmed in the VMCB. The
>> timer bounds how long VMRUN waits for the core to settle. A module
>> parameter exposes an interface to program this timer.
>>
>> ESMTP_RETRY: If DBREQ is detected, VMRUN exits. ESMTP_RETRY indicates an
>> internal event and the hypervisor should execute a VMRUN.
>>
>> Refer to the AMD64 APM Vol 2, section "AMD64 Enhanced SMT Protection".
>>
>> Acked-by: Borislav Petkov (AMD) <bp@alien8.de> # non-virtualization changes
>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>> ---
>> v1..v2
>> * Move idle wakeup ICR programming to svm_enable_virtualization_cpu()
>>   instead of sev_hardware_setup()
>> * Remove cond_sched() in ESMTP exit paths
>> * Program the IDLE_WAKEUP_ICR for all present CPU siblings
>> * Add documentation for ESMTP timeout
>> ---
>>  .../admin-guide/kernel-parameters.txt         | 19 ++++++++
>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>  arch/x86/include/asm/msr-index.h              |  1 +
>>  arch/x86/include/asm/svm.h                    | 12 ++++-
>>  arch/x86/include/uapi/asm/svm.h               |  9 +++-
>>  arch/x86/kernel/cpu/scattered.c               |  1 +
>>  arch/x86/kvm/svm/sev.c                        | 48 ++++++++++++++++++-
>>  arch/x86/kvm/svm/svm.c                        |  8 ++++
>>  arch/x86/kvm/svm/svm.h                        |  2 +
>>  9 files changed, 97 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 68647ff4bdd2..e09f18c0de34 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3240,6 +3240,25 @@ Kernel parameters
>>  			max_snp_asid == min_sev_asid-1, will effectively make
>>  			SEV-ES unusable.
>>  
>> +	kvm-amd.esmtp_timeout_ns=
>> +			[KVM,AMD] Enhanced SMT Protection (ESMTP) VMRUN
>> +			timeout, in nanoseconds, for SEV-SNP guests that enable
>> +			ESMTP.  When an ESMTP vCPU executes VMRUN, hardware
>> +			waits for every sibling thread to either be idle or
>> +			run a legal sibling vCPU of the same guest before
>> +			entering guest mode.  If the wait exceeds this timeout,
>> +			VMRUN exits with VMEXIT_ESMTP_TIMEOUT and KVM retries
>> +			the VMRUN.
>> +
>> +			The value is converted to TSC cycles and programmed
>> +			into the VMCB when a vCPU is initialized, so changing
>> +			it at runtime only affects vCPUs that are created or
>> +			reset afterwards.
>> +
>> +			Default is 0, which disables the timeout, i.e. VMRUN
>> +			waits until the sibling condition is met or a physical
>> +			interrupt arrives.
>> +
>>  	kvm-arm.mode=
>>  			[KVM,ARM,EARLY] Select one of KVM/arm64's modes of
>>  			operation.
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index f70ee74b5f92..4cf477e95c58 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -529,6 +529,7 @@
>>  						      * and purposes if CLEAR_CPU_BUF_VM is set).
>>  						      */
>>  #define X86_FEATURE_X2AVIC_EXT		(21*32+20) /* AMD SVM x2AVIC support for 4k vCPUs */
>> +#define X86_FEATURE_AMD_ESMTP		(21*32+21) /* AMD Enhanced SMT Protection */
>>  
>>  /*
>>   * BUG word(s)
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 3a8e51a0c9e8..fbcb3313e946 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -761,6 +761,7 @@
>>  #define MSR_AMD64_SEG_RMP_ENABLED_BIT	0
>>  #define MSR_AMD64_SEG_RMP_ENABLED	BIT_ULL(MSR_AMD64_SEG_RMP_ENABLED_BIT)
>>  #define MSR_AMD64_RMP_SEGMENT_SHIFT(x)	(((x) & GENMASK_ULL(13, 8)) >> 8)
>> +#define MSR_AMD64_IDLE_WAKEUP_ICR	0xc0010137
>>  
>>  #define MSR_SVSM_CAA			0xc001f000
>>  
>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index aa63431ba92c..323ab7089302 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h
>> @@ -165,7 +165,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>>  	u8 reserved_9[22];
>>  	u64 allowed_sev_features;	/* Offset 0x138 */
>>  	u64 guest_sev_features;		/* Offset 0x140 */
>> -	u8 reserved_10[664];
>> +	u64 esmtp_timeout;		/* Offset 0x148 */
>> +	u8 reserved_10[656];
>>  	/*
>>  	 * Offset 0x3e0, 32 bytes reserved
>>  	 * for use by hypervisor/software.
>> @@ -310,6 +311,7 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
>>  #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
>>  #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
>>  #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
>> +#define SVM_SEV_FEAT_ESMTP				BIT(17)
>>  
>>  #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
>>  
>> @@ -482,6 +484,11 @@ struct sev_es_save_area {
>>  	u8 fpreg_x87[80];
>>  	u8 fpreg_xmm[256];
>>  	u8 fpreg_ymm[256];
>> +	u8 reserved_0x670[560];
>> +
>> +	/* Enhanced SMT Protection */
>> +	u32 vcpu_id;
>> +	u32 vcpu_sibling_mask;
>>  } __packed;
>>  
>>  struct ghcb_save_area {
>> @@ -554,7 +561,7 @@ struct vmcb {
>>  
>>  #define EXPECTED_VMCB_SAVE_AREA_SIZE		744
>>  #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
>> -#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
>> +#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		2216
>>  #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
>>  #define EXPECTED_GHCB_SIZE			PAGE_SIZE
>>  
>> @@ -589,6 +596,7 @@ static inline void __unused_size_checks(void)
>>  	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
>>  	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);
>>  	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x3f0);
>> +	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x670);
>>  
>>  	BUILD_BUG_RESERVED_OFFSET(ghcb_save_area, 0x0);
>>  	BUILD_BUG_RESERVED_OFFSET(ghcb_save_area, 0xcc);
>> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
>> index 010a45c9f614..e59baf4b3c3f 100644
>> --- a/arch/x86/include/uapi/asm/svm.h
>> +++ b/arch/x86/include/uapi/asm/svm.h
>> @@ -135,6 +135,10 @@
>>  #define SVM_EXIT_SW				0xf0000000ull
>>  
>>  #define SVM_EXIT_ERR           -1ull
>> +/* Enhanced SMT Protection VM exits taken during VMRUN sibling sync */
>> +#define SVM_EXIT_ESMTP_ILLSIB  -5ull	/* Illegal ESMTP sibling */
>> +#define SVM_EXIT_ESMTP_TIMEOUT -6ull	/* ESMTP_TIMEOUT expired */
>> +#define SVM_EXIT_ESMTP_RETRY   -7ull	/* Internal event; retry VMRUN */
>>  
>>  #define SVM_EXIT_REASONS \
>>  	{ SVM_EXIT_READ_CR0,    "read_cr0" }, \
>> @@ -246,7 +250,10 @@
>>  	{ SVM_VMGEXIT_EXT_GUEST_REQUEST, "vmgexit_ext_guest_request" }, \
>>  	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
>>  	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
>> -	{ SVM_EXIT_ERR,         "invalid_guest_state" }
>> +	{ SVM_EXIT_ERR,         "invalid_guest_state" }, \
>> +	{ SVM_EXIT_ESMTP_ILLSIB,	"esmtp_illsib" }, \
>> +	{ SVM_EXIT_ESMTP_TIMEOUT,	"esmtp_timeout" }, \
>> +	{ SVM_EXIT_ESMTP_RETRY,		"esmtp_retry" }
>>  
>>  
>>  #endif /* _UAPI__SVM_H */
>> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
>> index 8665a6474806..16620fa0e290 100644
>> --- a/arch/x86/kernel/cpu/scattered.c
>> +++ b/arch/x86/kernel/cpu/scattered.c
>> @@ -67,6 +67,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>>  	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
>>  	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
>>  	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
>> +	{ X86_FEATURE_AMD_ESMTP,		CPUID_EDX,  1, 0x80000025, 0 },
>>  	{ X86_FEATURE_AMD_HTR_CORES,		CPUID_EAX, 30, 0x80000026, 0 },
>>  	{ 0, 0, 0, 0, 0 }
>>  };
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 5705723f1f41..df836dfe3e55 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -67,6 +67,11 @@ module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
>>  static unsigned int __ro_after_init nr_ciphertext_hiding_asids;
>>  module_param_named(ciphertext_hiding_asids, nr_ciphertext_hiding_asids, uint, 0444);
>>  
>> +static unsigned long esmtp_timeout_ns;
>> +module_param(esmtp_timeout_ns, ulong, 0644);
>> +MODULE_PARM_DESC(esmtp_timeout_ns,
>> +		 "ESMTP VMRUN sibling-wait timeout in nanoseconds (0 disables the timer)");
> 
> "ESMTP VMRUN sibling-wait timeout, in nanoseconds. 0 (default) disables
> the timer."
> 
> Not sure if that reads any better, main point is just to highlight the
> default is 0, timer disabled.
> 

Sure, your example reads fine. As an alternative:
"ESMTP VMRUN sibling-wait timeout in nanoseconds (default: 0, timer disabled)"

>> +
>>  #define AP_RESET_HOLD_NONE		0
>>  #define AP_RESET_HOLD_NAE_EVENT		1
>>  #define AP_RESET_HOLD_MSR_PROTO		2
>> @@ -506,7 +511,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
>>  		return -EINVAL;
>>  
>>  	if (!snp_active)
>> -		valid_vmsa_features &= ~SVM_SEV_FEAT_SECURE_TSC;
>> +		valid_vmsa_features &= ~(SVM_SEV_FEAT_SECURE_TSC | SVM_SEV_FEAT_ESMTP);
>>  
>>  	if (data->vmsa_features & ~valid_vmsa_features)
>>  		return -EINVAL;
>> @@ -1021,6 +1026,15 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>>  
>>  	save->sev_features = sev->vmsa_features;
>>  
>> +	if (sev->vmsa_features & SVM_SEV_FEAT_ESMTP) {
>> +		save->vcpu_id = vcpu->vcpu_id;
>> +		/*
>> +		 * All vCPUs of a guest are put into one group and can be run
>> +		 * co-resident on the sibling thread of the same core.
>> +		 */
>> +		save->vcpu_sibling_mask = U32_MAX;
>> +	}
>> +
>>  	/*
>>  	 * Skip FPU and AVX setup with KVM_SEV_ES_INIT to avoid
>>  	 * breaking older measurements.
>> @@ -3259,6 +3273,9 @@ void __init sev_hardware_setup(void)
>>  
>>  	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
>>  		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
>> +
>> +	if (sev_snp_enabled && cpu_feature_enabled(X86_FEATURE_AMD_ESMTP))
>> +		sev_supported_vmsa_features |= SVM_SEV_FEAT_ESMTP;
>>  }
>>  
>>  void sev_hardware_unsetup(void)
>> @@ -3290,6 +3307,31 @@ int sev_cpu_init(struct svm_cpu_data *sd)
>>  	return 0;
>>  }
>>  
>> +void sev_esmtp_enable_wakeup_icr(void)
>> +{
>> +	unsigned int cpu, sibling, shift;
>> +	u32 core;
>> +
>> +	if (!(sev_supported_vmsa_features & SVM_SEV_FEAT_ESMTP))
>> +		return;
>> +
>> +	cpu = raw_smp_processor_id();
>> +	shift = topology_get_domain_shift(TOPO_CORE_DOMAIN);
>> +	core = per_cpu(x86_cpu_to_apicid, cpu) >> shift;
>> +
>> +	for_each_present_cpu(sibling) {
>> +		u32 apicid = per_cpu(x86_cpu_to_apicid, sibling);
>> +		u64 icr;
>> +
>> +		if (sibling == cpu || (apicid >> shift) != core)
>> +			continue;
>> +
>> +		icr = (u64)apicid << 32;
>> +		icr |= LOCAL_TIMER_VECTOR;
>> +		WARN_ON_ONCE(wrmsrq_safe(MSR_AMD64_IDLE_WAKEUP_ICR, icr));
>> +	}
> 
> Can you use cpu_sibling_map here instead of going through every present cpu?
> 

I think cpu_sibling_map only covers the list of online CPUs. If SMT was say
turned off and then on again the CPU that stayed online would never be
reprogrammed with its new sibling's APIC ID. Walking the present CPUs avoids
that, because x86_cpu_to_apicid is already valid for offline siblings.

I had used topology_sibling_cpumask() in v1 when Sashiko pointed out this case
to me.

Thank you!
Pratik

> Thanks,
> Tom
> 
>> +}
>> +
>>  /*
>>   * Pages used by hardware to hold guest encrypted state must be flushed before
>>   * returning them to the system.
>> @@ -4792,6 +4834,10 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
>>  		svm->vmcb->control.allowed_sev_features = sev->vmsa_features |
>>  							  VMCB_ALLOWED_SEV_FEATURES_VALID;
>>  
>> +	if (sev->vmsa_features & SVM_SEV_FEAT_ESMTP)
>> +		svm->vmcb->control.esmtp_timeout = mul_u64_u32_div(esmtp_timeout_ns,
>> +								   tsc_khz, 1000000);
>> +
>>  	/* Can't intercept CR register access, HV can't modify CR registers */
>>  	svm_clr_intercept(svm, INTERCEPT_CR0_READ);
>>  	svm_clr_intercept(svm, INTERCEPT_CR4_READ);
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 5d15c706e43b..624675a12d51 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -591,6 +591,8 @@ static int svm_enable_virtualization_cpu(void)
>>  		__svm_write_tsc_multiplier(SVM_TSC_RATIO_DEFAULT);
>>  	}
>>  
>> +	sev_esmtp_enable_wakeup_icr();
>> +
>>  	svm_init_os_visible_workarounds();
>>  
>>  	svm_init_erratum_383();
>> @@ -3743,6 +3745,12 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>>  		return 0;
>>  	}
>>  
>> +	if (svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_RETRY ||
>> +	    svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_ILLSIB ||
>> +	    svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_TIMEOUT) {
>> +		return 1;
>> +	}
>> +
>>  	if (exit_fastpath != EXIT_FASTPATH_NONE)
>>  		return 1;
>>  
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index e958943b8162..8cd8b825c9a0 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -1008,6 +1008,7 @@ void __init sev_set_cpu_caps(void);
>>  void __init sev_hardware_setup(void);
>>  void sev_hardware_unsetup(void);
>>  int sev_cpu_init(struct svm_cpu_data *sd);
>> +void sev_esmtp_enable_wakeup_icr(void);
>>  int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>>  extern unsigned int max_sev_asid;
>>  void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
>> @@ -1036,6 +1037,7 @@ static inline void __init sev_set_cpu_caps(void) {}
>>  static inline void __init sev_hardware_setup(void) {}
>>  static inline void sev_hardware_unsetup(void) {}
>>  static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
>> +static inline void sev_esmtp_enable_wakeup_icr(void) {}
>>  static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
>>  #define max_sev_asid 0
>>  static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
> 

