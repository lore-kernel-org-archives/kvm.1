Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621B36404E
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378980; cv=fail; b=Mu5JQitu/aWX4kVyA85FnZ4rI4vlgi0q7/20cBLSrA3nuAn91Y5M5nYaACgFTZ/uGqyScaVS71DQ/N5F22oZBM7e1Jjlmi+dZfIvdyMKftAp1wlJ/Bt7yZ3kYcLfpY/QtaMWcAOFqO2IBoijCkXbVX99twEu7kVkbirOtP0s+x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378980; c=relaxed/simple;
	bh=NbK2nsdTCFp6fdZRAhhlq2AzOw/SjR7i3FFnvUslV8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KUesd7NgZZnwIOEz+kwGKcr7optTkQYZJlj0XFm70BvRjHAVHbHkY8+b5A7RfUJHKVwzL/lmLpt1QTy/PnlaUPrbhfjzwk7FIXc3bgpSw6ryG8RTiezKE/yWqO5xO4qLf/iZ/dlwMBOzurVaSURB9j8CRqhtI/sh2ZH/fsFkpKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tQFSMhei; arc=fail smtp.client-ip=52.101.57.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tQFSMhei"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOW87VlkZf3DzBWm4DqT8bGasj5KGp/JYjxzF1COLbx3HJvgJP2L8quXGbfIrplNYTJV+xayh9ndSB1zNA50K6qgDQiTaQWH541Ho05rECzvSPLHCfjGVbR/KxT2xBV9cT6MpaQlMC3bgIm9ioKzbu4TtTvaoWZJlWO1tuegdbV9HSDGUrluyqa1tq0uyHLgYoqYYhiR0DeUyt4Y3pwrGihrZQQskcYLoAABJylcFzL5h5QT3dTcZ1/34BWfZiRgeshr4leIu58fOXOIzAxn6XD6hfJ5yE8lEaPaMq3N5UV2+FPSr+/grN96lVRTaObc1SJT/SoNWVZKYV9OlkIMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vYpkylCXNDdnaDTf0m2KMLD+WW7fm5W1hibDb4AR0A=;
 b=qNHUR0VvYh/ca0ccMBkLSWD9F4RAX25y5l+gXqfwYc7OXm45pz9ljw6TI3pgMJiAkF6k4nmk639058GSbhqtdeKvjJclV1miZWCUGK042/AvVF3gnjPhIolV0E7KaxB/iz6Nw7Fl3hcjjbvLmGnSDrAARmxNkiHAQlgICTYSeptrmMw/mP3iU73ummB1r8gNrSAY26yJTfd+Rg1Gr1vlbwRfSeayTMgrB6e8rLn2Fc2gmnnrISG7kCbb4cRTRKfaMjUBr9wH+HybYFjPfT7cIIgxayfN9XZIRirowaVXCLFsLh2bGI+gnbNwVu0V7JvM0jNXyyCD3ISLSclKn0mLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vYpkylCXNDdnaDTf0m2KMLD+WW7fm5W1hibDb4AR0A=;
 b=tQFSMheiOG96spLW+AbWj6h3WPl7aftlPGC/MXzk6oWwdVgEcf2xcR3vJKDSUfXuqsXh/6Y8vtRBgYiHzZ14CuuPBiCoMhWC+Kyy+YdKfM4Rd/gUiF+zbMr5lVBdgaQ4XZqrz7SDyVQ8v38ax11VFsFBM9UxeakalGD4jUVKWMU=
Received: from BLAPR03CA0044.namprd03.prod.outlook.com (2603:10b6:208:32d::19)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Mon, 19 Oct
 2026 03:02:55 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::17) by BLAPR03CA0044.outlook.office365.com
 (2603:10b6:208:32d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Mon,
 19 Oct 2026 03:02:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 03:02:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 22:02:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 22:02:46 -0500
Received: from [10.85.36.197] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 18 Oct 2026 22:02:45 -0500
Message-ID: <18f7b615-7723-49ef-9b11-d30a4118f92a@amd.com>
Date: Mon, 19 Oct 2026 08:32:39 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] KVM: nSVM: Add nested PML emulation
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>,
	<seanjc@google.com>
References: <20261015103933.2088307-1-nikunj@amd.com>
 <20261015103933.2088307-3-nikunj@amd.com> <sashiko-outbox-172711@kernel.org>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <sashiko-outbox-172711@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: ec01229e-3d7a-49a2-f3d8-08df2d8d785f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|10067099003|22082099003|18002099003|13003099007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JDgK60hJcsWvbsbDvFXiALGhNgDEzXdreXqZbjEEPLvH16e+QeRFXyWdNwCkj3T7gbwQeQXEmmRaroBMIkx5Aw0uq4QidKHdv498iUfyrFYn++lY+t8kO3WP5gB7xHhL7Eaki47eMla9NneQNgTxTiUzfRTCGnFo9juTnL3hWb/xmNkyHyY4lYvEkxPcLlmoJ6RmazFDapsR4D4kpDAFP41zt7Ruy8YE1p8Ukn8M9VXlLJ+TMMNEs7pJYF5HYTEluTIEotdeFElMVMBzn8KsrfNb/AzgzCS9RE05WL18KIdNdfgo5HzFZc9Txy+eZ/36b7cmGz4s8xM3IY1YoTRAEWnMWySXb0n3rew0uSqbiEIxyOPT1jSJb/7Z2TK8+JCcfuKfEzjlQtvnCx4N7HdeXS817SDAvhP3XPZRUrkxoxCO6Jn9Oii0CT8NZK4+Xx5Borqz3/VK5dOBG5Ef8MY06NLYA66908+sh7o1pxdPPx5o5rM9Ztv8DMCKaLfVo2zR8wESYxGcVqxkFYFg7ozpvA/YlB3Ye2A4jQEdbim0IhPQOjh0DDP6nw4R2KLzNc15jSBR3mUPNBZVe22B+4ca63/S7cWAG6WYNGN2fwp2m4I07XjmxVgIO64VJDaH01LlE5JPgiiCvQyqGZ8jwySuUWGbmPAKqIRxqkr/wBe8fKb8ggGBPewetK3Pa1xuI+K1zO5QgV2bWgiomlFrTkOAGw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(13003099007)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gTFw4FZ4/f7u8l7b26FTLeZaMPstpoy4kFWKfx/0dkensH0+Obu1W2vUGUHMeC2392kjYEH3QrG9O6hvMY9qkOcqSQbfyi22Ihym4ENFyozzeE+LxbTV8eQnLfMl0T+9lR++tChrS5JbZ9zudlGoPEdVrGEVW+5IMBtGo8WQ4Jim7Qzr0XAYT8pf1j7otazlpm07mp9Nyp/30JZJnCdOS6AywEGk9wqxs0O/G5yiJOlk+ZNq35Lq2y1IeRWVFIquU3crLl9ahIhMUxipIK0o3w0x/Q75zrCR9WZ/7TI8jF2+kxl5Q3/cDcxbNAyPUgjNTOfaK1tPml/S6tuEzrzd4ZGVn3aItH57tGGMF4yR8NhEUJSbQ5kYLgupHdAg3HhzjT2NRsMLWV8rrb4UEZ7qc5zEJUuO6SpVpjdzrirP/bP1nTt1Iz1IB8qRw+ESlsGe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 03:02:54.2663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec01229e-3d7a-49a2-f3d8-08df2d8d785f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782



On 10/15/2026 4:33 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: nSVM: spurious PML_FULL VM-Exit injection on discarded faults
> --
> 
> commit ac3a6ec9423b67a67c9dfb9dd5ebd698f451f130
> Author: Nikunj A Dadhania <nikunj@amd.com>
> 
> KVM: nSVM: Add nested PML emulation
> 
> This commit emulates Page Modification Logging (PML) for nested SVM guests,
> allowing L1 hypervisors to track dirty pages in their L2 guests. KVM emulates
> PML in software by write-protecting L2 SPTEs and logging dirty GPAs to L1's
> PML buffer.
> 
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index af0ef678433d7..8251b38d14790 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
> 
> [ ... ]
> 
>> @@ -63,7 +64,14 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
>>       if (WARN_ON_ONCE(hweight64(fault_stage) != 1))
>>               fault_stage = PFERR_GUEST_FINAL_MASK;
>>
>> -     vmcb->control.exit_code = SVM_EXIT_NPF;
>> +     /*
>> +      * Only the exit code differs for a PML Full; hardware leaves the
>> +      * EXITINFO fields as the nested page fault that filled the buffer
>> +      * would set them.
>> +      */
>> +     vmcb->control.exit_code = svm->nested.pml_full ? SVM_EXIT_PML_FULL : SVM_EXIT_NPF;
>> +     svm->nested.pml_full = false;
>> +
>>       vmcb->control.exit_info_1 = fault_stage |
>>                                   (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
>>       vmcb->control.exit_info_2 = fault->address;
> 
> [Severity: High]
> If L2 triggers a legitimate but unrelated nested page fault (such as a read
> fault) after a previous discarded fault left pml_full set, does this blindly
> consume the lingering pml_full flag?

Yes.  Both findings are about the same flag - one at the point it is
consumed, one at the point it is left set - so this answers both.

nVMX does the same: vmx->nested.pml_full is set in
nested_vmx_write_pml_buffer() and consumed unconditionally in
nested_ept_inject_page_fault(), with the same discard paths in shared MMU
code.  I kept the flag here to match that rather than introduce a
different mechanism in a first posting.

The effect is bounded: L1 takes one spurious PML Full, and as
pml_full_interception() ignores the EXITINFO fields, L1 drains,
re-enters L2 and gets the real fault on the retry.

The clean fix could be to carry the indication on the fault rather than
on the vCPU - a synthetic PFERR bit, set by the walk that raised it and
tested in nested_svm_inject_npf_exit(). Something like the below, roughly:

      #define PFERR_PML_FULL          BIT_ULL(50)
      #define PFERR_SYNTHETIC_MASK    (PFERR_IMPLICIT_ACCESS | \
                                       PFERR_PRIVATE_ACCESS | PFERR_PML_FULL)

      /* update_accessed_dirty_bits() */
      if (w == &vcpu->arch.ngpa_walk &&
          kvm_nested_call(write_log_dirty)(vcpu, addr))
              return -EBUSY;

      /* walk_addr_generic(), tagging the fault it is about to raise */
      if (unlikely(ret == -EBUSY))
              errcode |= PFERR_PML_FULL;

      /* nested_svm_inject_npf_exit() */
      pml_full = fault->error_code & PFERR_PML_FULL;
      vmcb->control.exit_code = pml_full ? SVM_EXIT_PML_FULL : SVM_EXIT_NPF;

It would also let nVMX drop its flag and the WARN_ON_ONCE in
nested_ept_inject_page_fault().

Separately, Yosry asked on this thread about factoring
nested_svm_write_pml_buffer() and its nVMX counterpart into common code.
I will wait for Sean's input on both before reworking either.

> 
> It looks like this would inject an SVM_EXIT_PML_FULL exit into L1 carrying
> the error code of a read fault. Since hardware PML only logs writes, could
> this architecturally impossible state crash or confuse the L1 hypervisor?
> 
> [ ... ]
> 
>> @@ -2169,6 +2200,47 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
>>       return w->gva_to_gpa(vcpu, w, gpa, access, exception);
>>  }
>>
>> +static int nested_svm_write_pml_buffer(struct kvm_vcpu *vcpu, gpa_t gpa)
>> +{
>> +     struct vcpu_svm *svm = to_svm(vcpu);
>> +     u16 index;
>> +     gpa_t dst;
>> +
>> +     if (WARN_ON_ONCE(!is_guest_mode(vcpu)) || !nested_pml_enabled(svm))
>> +             return 0;
>> +
>> +     /* The flag can be set here if the fault that raised it was discarded. */
>> +     if (svm->nested.pml_full)
>> +             return 1;
>> +
>> +     index = svm->nested.ctl.pml_index;
>> +     if (index >= PML_LOG_NR_ENTRIES) {
>> +             svm->nested.pml_full = true;
>> +             return 1;
>> +     }
> 
> [Severity: High]
> If KVM resolves or discards the page fault internally without injecting it
> into L1, this leaves the pml_full flag set while L2 execution resumes.
> 
> The comment acknowledges that the flag can be left set by discarded faults.
> However, is it safe to leave it set if the next fault isn't guaranteed to be
> a write?

Regards
Nikunj
