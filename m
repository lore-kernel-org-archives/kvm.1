Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30144C65D
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792381141; cv=fail; b=USKqgOlIc+/ojDxkm9Ks4UPA0tHqrvPsK3hYTy0aUXHsw6++7cAU81Yp0cXKiYHyDb6Ah7JhjTW7KG4vVH00u0XSW9H8QfqOe23dp8Y3LIMi1l2e0p8F6Be1Po5+uvha/mL6Qt63wzAlQcBCozjbMZHJpaROt7oL+o/Gpb70nTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792381141; c=relaxed/simple;
	bh=XHzLuHpUA/cRNyhc3du6Rt4CMzTHrLbHnl7HegKCxc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BhYAg/8XAZtn6bjU0HsJKCgSyy2xLfwlPHTfhH0vNOA5yIbg/UU/r87sdVmdCgqUTnoM8iaZ5vTVlUzfhF0f+z/ZBgBxQjXRmnpxGiJ4/U+fFzoZlWkDS36M3yJgA8cAK2kPtLl4dmU9DWznpF2ngffOEMqwWKBOOGUx9PNZb8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MtueJfsz; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MtueJfsz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEG+uGpx0oMaY4h21BsO1OFxhF0uhFCvMOIxS9LYsHxIp7ZjD2yeSv1uDLVR6p1zkUrSe22HhRGtgftpTjNsJdV5dmpiHlAqtggnE2jMcbvW801bYwKzSCI3PwPQUqWKEfCAaagIlk7Dz+sulBBFx23XEz96e9aVlP0kSdaOG5Lfakx9VrX0T2Cbhob8z1UYAUfz95qcS/+nRBequzv2gY5hg3PWtEddtjZelNgIC+y5pJ1syANLPSflk1qZRtsdtdSKkRx7nNZjo9YWSiZ8xFyAW/2tWnDzHds/xoHquG5HkFYoFUZcEi5C5mEvc1ktqjttHeZoBNLxc4/9aVQJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8F1/P+8pz/a2FD15vCUH/9F8cy9Bb/VAx0vLHRZIhk=;
 b=VpY1SWjrs9P5110m1tO0jB6oJEXY6R8CIE5FHmtGoA+e+EUcLyaPY/4RDrTSTvI7OW8LebehfgeW/0Pe1oHVa+WPzu/GBHtvY/nthtUKbLynjLCRxFX3GtU/jQcjJS2v4wZ8tS8+cP7U/mFAVWI8w7Ic0rUDOfk0NZSuiOhzg1xtL4WAgRHB6jjz31j+v2Ml43WPJahugozvqybQlwUrR0ejMQO6WN2wYGDua+xtMHR5PFdMea8gapUGTi5L/YeoOhMPU9IYh9XJ+NRTw4DOnMp3PD/OZMAIUsRQjNU8T7Zuo4HiS2H6++TSz18Oo7DS/btvwFsUuCUlVILT2FhCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8F1/P+8pz/a2FD15vCUH/9F8cy9Bb/VAx0vLHRZIhk=;
 b=MtueJfszbjMuoxKc6BPNY2Mhi3o4cTNUE161W05+9B/Gdbyo8L3zYXeOHAzoL8Azk2Re9d+Yh6dHOd47ofPy5QaXB90PRxCKcrkfKKmcowBiZJVcq9dYN1qH0Qdkzf929nDPBCzfgvl7VkYIOyUUyEhwq+J3baaiHdzWp3Zmsmc=
Received: from BN9PR03CA0193.namprd03.prod.outlook.com (2603:10b6:408:f9::18)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 19 Oct
 2026 03:38:37 +0000
Received: from BN3PEPF00022BCC.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::28) by BN9PR03CA0193.outlook.office365.com
 (2603:10b6:408:f9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 19 Oct 2026 03:38:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BCC.mail.protection.outlook.com (10.167.248.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 03:38:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 22:38:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 22:38:28 -0500
Received: from [10.85.36.197] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 18 Oct 2026 22:38:27 -0500
Message-ID: <a55b6e7c-c8ef-4bdd-bc35-1a0bfd1eac3f@amd.com>
Date: Mon, 19 Oct 2026 09:08:21 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] KVM: selftests: nSVM: Add nested PML coverage to
 nested_dirty_log_test
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20261015103933.2088307-1-nikunj@amd.com>
 <20261015103933.2088307-6-nikunj@amd.com> <sashiko-outbox-172714@kernel.org>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <sashiko-outbox-172714@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCC:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fbee06-2ea2-48ed-635a-08df2d9274e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|6133799003|10067099003|22082099003|18002099003|13003099007|3023799007|11063799006|261009223027099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Q/bJF5usbuVSEcW3jx0TfO+pBW/RGMy0sKOZ0h66jZEHRX1Kcwja5yi119n6uB3yDRj7yc5CZowM74pgaDLuIDUvokVjTkhKI7aERNPXsMT4sBxrz6J+Rx44YJ9gZGwQ8SEtJramsuL6d2iop38ATYSes0wf5fmhIOBBwPBDAOwRSHnMW8IeCz+oRWImCWtIZvTfZw+11Y4pDGqtzZ8v93BG84AFrpt7ljOOeNjLdlmscRsf7oKWG1s7w3TrJOlCiezq2tmmXq2Oj31o2KHwNO67QNpFYtBMpw5XJQr6+dUhj05jVYeZXiIEdnJwLEnX0M8GQu9ibfmLcmCfbwFReJjz5wP4kJe71cmnlvjGwKkf5MIb5oX97RvfegoWqdvhWyx19bz6ZYD+khdeh+U21PcfhCHlIdgH01XgIHdcpS0ZrWZEqMkWQb0F1z04nrxp9+EvcMpSl97/r0RuEmy0fW2NvWvNcj8usqyzbvff9IPgcpeIzi3pRLM6fyxiUAoCVY+NQNKLS9JqTTRc6GrhqRzUix167n68Gqogy8BbUxkKtJu4GtuY7Pk9JynisTSD3Q4obnRUCrn8mzWQIOhBKY2c+VVy4h1jmF61nlboMbAxbesgLP3zZHVgYiDFLt2vMPnx2WedEkeeQsBuH45Gk8gH2GuOsUqxsmNmEJcX0tygSXMScfgS56CnmKJdqVIhyH9tFmeoEsSaBtmRGEq41A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(13003099007)(3023799007)(11063799006)(261009223027099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SMmicW7XiWM50IqtUrKDTnHahq5PciEr0DrnZ8jASxNVjMQ7wSl5t3XkjeErql6vHpXEea9wviSSz1mLchfretCMbIaAHmgr/vpt9gwOvI8w3Jl6y+IqkNoOQO/iUEN0O9Zf9Gv8DL8nnZ8jXqlmuRyOeWVBGW/KRN/rnubu5r1TEwLeCMuwP4aW5zeZLyRlT8geNjZxXAtkaM7wMKeGZpZgfFz2f35FBgfj1JU9zF7w5nnJlT/Hm3C/KB7UGxBj1dQHl8sitDJGotPdKQGlscKD+KqoxTcyP4zd59gcjEfYvFYVUSfELvZcluFkspujhIXZEHDEmOhijgcPrV/mEiwzuvtX8JT+AK3gkKpoMr6rt8YNEm0VKTkbcNwe9ECJAfC4HLGpo/0MjbcalCUETG1FhIZX9aFPa7r2dAIv7bBJqnJkpZ4qoNNCR83jAkF4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 03:38:35.9251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fbee06-2ea2-48ed-635a-08df2d9274e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421



On 10/15/2026 4:34 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] selftests: kvm: l2_pml_guest_code executes VMX-specific vmcall() on SVM
> --
> 
> commit cb64ef5e62e8854d8adff372ccbc0426babe6f16
> Author: Nikunj A Dadhania <nikunj@amd.com>
> 
> KVM: selftests: nSVM: Add nested PML coverage to nested_dirty_log_test
> 
> This commit extends the existing nested PML selftest to also cover AMD's
> nested Page Modification Logging (nSVM PML) by introducing an SVM-specific
> L1 guest code path.
> 
>> diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
>> index b1008724f46dc..cc49fa0c42937 100644
>> --- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
>> +++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
>> @@ -250,6 +250,45 @@ static void l1_pml_vmx_code(struct vmx_pages *vmx)
>>       GUEST_DONE();
>>  }
>>
>> +static void l1_pml_svm_code(struct svm_test_data *svm)
>> +{
>> +     struct vmcb_control_area *ctrl = &svm->vmcb->control;
>> +     int nr_pml_full = 0;
>> +
>> +     /* PML requires NPT. */
>> +     GUEST_ASSERT(svm->ncr3_gpa);
>> +
>> +     generic_svm_setup(svm, l2_pml_guest_code);
> 
> [Severity: High]
> Could this setup lead to an Invalid Opcode (#UD) exception on AMD systems?
> 
> Looking at l2_pml_guest_code(), it appears to unconditionally execute the
> vmcall() instruction:
> 
> tools/testing/selftests/kvm/x86/nested_dirty_log_test.c:l2_pml_guest_code() {
>     ...
>     vmcall();
>     ...
> }
> > If l2_pml_guest_code() emits the Intel-specific VMCALL instruction, won't
> executing VMCALL on AMD systems raise an Invalid Opcode (#UD) exception
> instead of causing a VM-exit to L1?

VMCALL does #UD on AMD, but KVM intercepts #UD and the emulator rewrites the
instruction to VMMCALL and re-executes it, see emulator_fix_hypercall() and
svm_patch_hypercall().  L1 intercepts VMMCALL, so L2 exits to L1 with
SVM_EXIT_VMMCALL. l2_guest_code() in this file already uses vmcall().

> 
> Since generic_svm_setup() does not intercept #UD, does this exception
> get delivered to the L2 guest, triggering the host's selftest abort
> handler and crashing the nested AMD guest?
> 
>> +
>> +     ctrl->pml_addr = svm->pml_gpa;
>> +     ctrl->pml_index = PML_LOG_NR_ENTRIES;
>> +     ctrl->misc_ctl |= SVM_MISC_ENABLE_PML;
>> +
>> +     run_guest(svm->vmcb, svm->vmcb_gpa);
>> +
>> +     for (;;) {
>> +             if (ctrl->exit_code == SVM_EXIT_VMMCALL)
>> +                     break;
> 
> [Severity: High]
> Will this loop exit condition ever be met?

Yes, for the reason above.  l1_svm_code() predates this series and already
breaks on SVM_EXIT_VMMCALL.

Regards,
Nikunj
