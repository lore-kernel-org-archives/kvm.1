Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46435893
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788840532; cv=fail; b=RHxBgz0x+NOHXHmtk7bjxbNKZ7ipTPDBXKk38gFEFgBf6tmmy2NSaXD5hjMytfDzOBDYRXy/zAqpq+t3TbMP5iT7y5PgRzEuTzp7v5ClauU9kYaDXq3p/cmvnp5MyRKB1jFvTDncrOjycwrqMG2ExnDa/+iE7wHrGUIp7+5AEWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788840532; c=relaxed/simple;
	bh=YvyGNI0d513iz+g0EidjWac0SYXcsNtS9ThUh6k/qW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=snMwiTkCs4VNeDDWHn81RuUOYUjCWW+JjIHAxKjr3k59OUMPPFsF7VpOhFfeRxxAWwN6pR4vAxRyslH9rqZ65kzjd+heZ0508YEX7yQS0UIVFD81+6Yw9ruFc2YHnZR6Yijkxn2FGr4Gau6JM21teXEQOPdWcbIl1+SNe66MGH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qXYXn6Er; arc=fail smtp.client-ip=52.101.57.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qXYXn6Er"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYv/6nrlQ2PNyxYKCbP8wf6IoNndYuIVM4ol839lA6J9YzIEmvhXr27wNZu1uRYTsYT6vJ97U59bSkNN9mfg99bcmKdmlecsi9+OWl+jGrMlyo4fPPPELct3T5qhhLJAEa2zcD6sz1uAKMm8vEjzbWC9AZaXRk4oVXqSD1tB9uAJ5kwl9S3nrt8HsGkIJVh1QGCbjKb7iy1itj2Wl2aqPSmFENjHWJy4+XrWQsruEaBN/me7dcKxyGJJOwFaz8cMo+cTnkBuKwoD9EsU1PIQ0F3phY3YqSsKLqjD2Fl+NAvEv+CIPbUZ6oSz4ylbKNZIYeKNhYMUEtdWa/AbKC0N5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKcTYoko7LilK9OSnESLCr1zbwNR98VHR74gR+HVchQ=;
 b=pvky1DX0fIYGizXf+18Qr3K0ulp8z3vQEVhJUIRWMe9HnLSJGo0l973wWjChlWZhC+TfiDoJXpJx+euaaTeBF96k7nlxzpOiUXUTX7a3rPQer0HSYZvNFFEaQTuei4g4AerID9tXP1XbRyzwT45MBqZp8N1OsOjOjcYPE4GT/ZIp6D5KJkPfg3sT2uQ6QWvEXvXN05a52J4p1d1gZ9wKxspQ9gaDNsDAY60/SYDEZExuBr4M8dPkXaXQpVDf0VvVuBAFzaIgUlG8Lr4uXuTtYFdrNTsXyZqsyPeNGpIeZAibnwSaGcWmyqJvQdyVpTMV6ejt2NzvhyohS5jtW6Y4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKcTYoko7LilK9OSnESLCr1zbwNR98VHR74gR+HVchQ=;
 b=qXYXn6Eryiqt8MNRsqS7e7A7OSkOfje84LJXZOrJncBshzEs28w9p9eCqtOLCdtHfKWFmAMREjgGzuupLUlx1FAM2eKfcsUyyMcdoADEEBcjqojnB3H4KB2kDyFeq59cSKBhhr+alKil8jkKmP/Pe5heZw/oi98wCliOYE6j5bk=
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:08:39 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::21) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 04:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:08:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 23:08:38 -0500
Received: from [10.136.37.6] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 7 Sep 2026 23:08:37 -0500
Message-ID: <9a5552de-0f36-41c6-8bb6-16cbba5425b6@amd.com>
Date: Tue, 8 Sep 2026 09:38:36 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] KVM: SVM: Add Page modification logging support
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260907063906.1964557-1-nikunj@amd.com>
 <20260907063906.1964557-9-nikunj@amd.com>
 <20260907070024.4A7E11F00A3D@smtp.kernel.org>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260907070024.4A7E11F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: cd01001c-c1bd-42a9-1a58-08df0d5edcce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|10067099003|4143699003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Y0WMxa+WQ7feJA6np4dGPjXG5Ay67Wn/2VMxg+a+Woo8sYe3EyW0wV4q/tF8OtwBl/pcUhYNvPYT0ORDhnPnnFrn8r8W+5jlwGBagsEZmxyFVK78cJema4XJ1fUw+z2wT9dnqhSsfazUZlnfIQc8CAFIY3xEHvqdSPiFpFw4l+T26vd2HN1e0wHxGqmYpjOkykvgcSwSdTfB+u9/I+CL9OUYmSaRcY8K6Sd3g8t0O4w+PRuGvVaaQrUOVBqtU7bqJQQNc8oh+i/ar4a/IohDXY+f9VHqlVKowo7o7Fbp48ln7iJ3AtKDIdzJ990zRqNTB1rPOHdlmeB6lbLhzA+I+84rl4GKKMXPorpTvx7o4U0u5bZl29P9kyMt1aQDmNFqrTYCwe0wzvujLCqihovh9ANJf8M2I2bK08W0A2yVczO43nsKqvjJ9zsJz7gkbhRMhVE5UQ9TYsW3Y+JW/ijhPiXmlQp0LZLHbA/NVuE0w9k5TUFucDuOyeiY4KCnIlHssZ8RCdpYt0M9OP7x55Ze/PCqT7la3K1464yIsX6EHlrRVp3ZzqVPH8x/3jde797E8czL9vDTIzTBXJ6t7D8yf10VpPGSFH7r2dR8uxqN7Eh5YHvhxWHicb4GgfjXdvNeHmJz/tpSktsz1DdA7F0xpWfRFJl3GCxFVohg6AqxiWnUPhzOJTMzgYRLmXcR+nyaZsq3SXQsNHVHKG0ivdBbLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IMHEhhc5f7si5vYFo3PpmlWAkuhJ2VIttNKtwEJEAR7ugNMcH9BmONjJHKkv3TVjfR2BREWElTB4LjZeYKR93qgVP6y8km7NZ9/gVi3obuTPSuj2wu3V477IubThvSE3aOtzHX1mUuYPgYDIFCM2DSVODx7+dAbrxPKhbAqhb0yeMY7YSBDIMfUf1KVaPGjM0JTnAnWpUZszjDSao1CZOvG/Rala4+EQUrgU0W47nWPrrOGuPQYpl0Hjoj0x1KyYXYvrtozdvKFYTNnAm10h5HSe2Sje9sSJ7/kTR9DDvFLPML5GAfc2fN/pfQtITpvW3G2In83ziE5CFPhu8e1X+5P+HSAAVwT773fLfUS+3jgLCPpVrn6dioCyunJtlQb40QR/N/cKcw6dzLwnE5QuT4HWCZBZdCLT/Svl/3miFST3cDJc+SN705aryTyabU1+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:08:39.1049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd01001c-c1bd-42a9-1a58-08df0d5edcce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683



On 9/7/2026 12:30 PM, sashiko-bot@kernel.org wrote:

>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index 73f37b050d0a0..da417c4c59154 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -901,6 +901,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
>>       vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
>>       vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
>>
>> +     /*
>> +      * PML is never enabled in hardware for L2.  Make sure that an
>> +      * unexpected PML write would trigger a PML_FULL VM-Exit.
>> +      */
>> +     if (pml)
>> +             vmcb02->control.pml_index = -1;
> 
> [Severity: Critical]
> By intentionally leaving hardware PML disabled for nested L2 guests in
> nested_vmcb02_prepare_control without informing the KVM MMU, doesn't this
> cause all memory dirtied by L2 to be silently lost?

No, kvm_mmu_page_ad_need_write_protect() returns true when
cpu_dirty_log_size is set and the shadow page is in guest_mode,
which forces write-protection on L2 SPTEs instead of relying on
hardware PML. L2 dirty pages are tracked via write faults, not PML.
This is the same approach VMX uses for nested guests.

> 
> When an L2 guest writes to memory and the host KVM has PML enabled, the KVM
> MMU creates L2 shadow NPT SPTEs as writable but clears the D-bit. If hardware
> PML is disabled for L2, the hardware will set the D-bit but will not log the
> GPA, potentially leading to silent memory corruption upon live migration.
> 
> [ ... ]
> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 7d59d301e1e54..950c250a77b51 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
> [ ... ]
>> @@ -3344,6 +3376,45 @@ static int vmmcall_interception(struct kvm_vcpu *vcpu)
>>       return kvm_emulate_hypercall(vcpu);
>>  }
>>
>> +static void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable)
>> +{
>> +     struct vcpu_svm *svm = to_svm(vcpu);
>> +     struct vmcb *vmcb01 = svm->vmcb01.ptr;
>> +
>> +     if (enable)
>> +             vmcb01->control.misc_ctl |= SVM_MISC_ENABLE_PML;
>> +     else
>> +             vmcb01->control.misc_ctl &= ~SVM_MISC_ENABLE_PML;
>> +
>> +     vmcb_mark_dirty(vmcb01, VMCB_NPT);
>> +}
>> +
>> +static void svm_flush_pml_buffer(struct kvm_vcpu *vcpu)
>> +{
>> +     struct vcpu_svm *svm = to_svm(vcpu);
>> +     struct vmcb_control_area *control = &svm->vmcb->control;
>> +
>> +     /* Do nothing if PML buffer is empty */
>> +     if (control->pml_index == PML_HEAD_INDEX)
>> +             return;
>> +
>> +     kvm_flush_pml_buffer(vcpu, control->pml_index);
>> +
>> +     /* Reset the PML index */
>> +     control->pml_index = PML_HEAD_INDEX;
>> +}
> 
> [Severity: High]
> Since the PML index is reset here without marking the VMCB_NPT field dirty via
> vmcb_mark_dirty(svm->vmcb, VMCB_NPT), will the CPU hardware ignore the reset
> and use a stale cached value?

No clean bits are defined for the PML_ADDR and PML_INDEX fields, so on a
VMRUN, hardware always loads them from the VMCB if the feature is enabled.

> 
> This could lead to a situation where the processor continuously generates a
> PML_FULL VMEXIT on every subsequent write because the cached index remains at
> zero, causing guest livelock and a performance collapse.
> 
> [ ... ]
>> @@ -5429,6 +5525,8 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>>       .check_intercept = svm_check_intercept,
>>       .handle_exit_irqoff = svm_handle_exit_irqoff,
>>
>> +     .update_cpu_dirty_logging = svm_update_cpu_dirty_logging,
>> +
>>       .deliver_interrupt = svm_deliver_interrupt,
>>       .pi_update_irte = avic_pi_update_irte,
>>       .setup_mce = svm_setup_mce,
> 
> [Severity: Medium]
> Is there a missing implementation of .flush_pml_buffer in svm_x86_ops?

No. flush_pml_buffer is not a kvm_x86_ops operation. SVM calls
svm_flush_pml_buffer() directly from svm_handle_exit() on every
VM exit, including SVM_EXIT_PML_FULL.
 
> Without .flush_pml_buffer exported to the generic KVM x86 ops,
> kvm_vcpu_flush_pml() might silently do nothing. This would result in
> KVM_GET_DIRTY_LOG returning incomplete data, potentially delaying live
> migration convergence or confusing userspace tools expecting an accurate
> snapshot.

Regards,
Nikunj
