Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A362448D1C
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115733; cv=fail; b=XDvi9qtFKKKmLXqDc314BChozColRjoFGJWgD7Ws9RiZWXoFd7TF+eD3RPXGtsOkb/jSlU0gbbdMD7tf1TYb9cgRfum83Cm39Ti/ncfgrx0iQIpQojM0YvUXlwHU7Q5eQ1pU6733RXEMjtc9495bnHQ52chU22ZMUZnJDtRJIWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115733; c=relaxed/simple;
	bh=FGzUJFBrakKawPy8GOSbRR1pEZWcJxmNR/YkIca/Suc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iwY1F2pLXont8HQaCb2D0Iqf7tIKJRYZQeptQadSCzgUq4C4/4Y7wlwxZ83lDQF3UeUe0L6gXqMRiq1KI7cBiVOtnt4WGyOM1Hgug0WwWAcTO4ZDBWGGf3L4y81yZOoHhYe3ssg7MWcguQdEqSKDwIWHrno6GRwq1CLPhXfQE7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yK3FZiAv; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yK3FZiAv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wbn/HkHEA+PMwFyllEVSYVfW37XXMEwMoDU0t6wjn5YhxDrmIoe5u2Z/ASNxzLpOyDdtJSgQpKw91p7Sh89idghCQG8Eub/COpU1VAqOuW/uB9+I9gt/Z768/tz9WJRcdQvvbOvCi7RaSzJ8YRFj/bYthKbceGU+bnly/7N37kHGQsQVqj010oa8CjGe9XIfhBH28gGvkICmJ7GIHXjiCmVfQHIAajEfnRLlzfv02LZ6/Thucr3Sadni18llnm1Bx1Jro/R6avNpmn+C0fnB1AoRUJXE68E9e7h4jjgGBRFmnYv6gKRKC1QsXlzoIw7vf8NNrx5UG8V0wiBq8ovKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COAEwB+/9zQA6NdCpcJoKaQbXqkSyZ8mQFvWOtB8+Gk=;
 b=p8VZ7JSAJS6qv6SX2/op5TDnBd6DAziQuF1ZkJmxlBdlS/CFXYj+qPWsgaCKd9XsXd9a++WBexzxtiJKtLm2DhiLc5ezRyl+uCv5XcOBBNClsMZ2CaDo/hj0arDDMHStTavUpI58J6i8nVj3NOTm5TvdLKdcghVJrhHVVti0C8FE29OTJo/pnYbB95ZHfc2D03U31X2w8tTin3tIGhFwSQ+Kmrw2fsVOhuZEdYW6H4Lg3n5MFSb9Keqn8tXACaKNuT88BWsfaXmfjDVqnfc8VDKDNmRIxhChtBXgKwGGOwiZy75y8lrEZ5hywXL37MS7h2BoUF1+TVP66Dx+S4HhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COAEwB+/9zQA6NdCpcJoKaQbXqkSyZ8mQFvWOtB8+Gk=;
 b=yK3FZiAvL3tRIVOZtfJPFj1JNUJia49AC8bIOmyO+LZF1aJ2Gi8NKeMUNB6vjhR/oWM/ARHNuII+vVMxlBovJ9IdW2pcLWRaZaoPP2HH2Zr3RsApH27dblkhYNFKL7oB6qQOTTL1XEgkfc/xY9qDNantvS3+QBLBVaEno05mWeA=
Received: from SJ0PR03CA0072.namprd03.prod.outlook.com (2603:10b6:a03:331::17)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 11:42:03 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::8c) by SJ0PR03CA0072.outlook.office365.com
 (2603:10b6:a03:331::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 11:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 11:42:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:42:02 -0500
Received: from [10.252.195.157] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 06:42:00 -0500
Message-ID: <024fdb87-b16c-4a6c-b9ea-e4953a7abe21@amd.com>
Date: Wed, 15 Jul 2026 17:12:00 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] KVM: SVM: Add Bus Lock Detect support
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-6-shivansh.dhiman@amd.com>
 <20260709085535.3D8F81F000E9@smtp.kernel.org>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260709085535.3D8F81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 2180d35c-0084-4fba-ebe0-08dee266167f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|3023799007|4143699003|10067099003|18002099003|22082099003|56012099006|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	3EapNhhT7TYFS2SkFKtWYYoxcXcgk6quiTxr0mr4zmB+F3l6/3WTnrDt8QMKrpmqNq3Vzj8/5ZmD9WpNMRhAaxlXZlz6mU5xQwwpWlr9caUp5R7bRmSQp+foiexsOqLU1NV/bUJ2orz87eNXlRWeOf8BGsusyDpjLVJ4XLnVOEq8LDzK6MJWGIhfHwG/wVF87n+rrJvz5Lh+sbfgoyTnIg1zWcWYKaamt1DjnXzF0TRO+bXeHt23tGZ31d0kIzWrk0gaM1zUR+TN6khkqB2r+pNtJX2qsqiEXAKMgx4mAG7KL0KlJv6rATQbYGalq9NhrKI7iQsNIhurf1j1Rh/Pi0ok4cvAwIEuX7Tr657OYBHG9QdxGqVqXSZTikiE7lCGhU5SUH9nMVZZtEEw5Qu5s/uwu64yEaZq9J/Wv7ARf8iqSnSC7rpIhfZRA4uVkaaDy1wlcafKHqi6WXRZw9JVUD55RyvPDJIpOf6vyFV2PJTK3SgTex1tJ3oGbhWtlLAvSagw6fmenelnxTPUvDdGCqyfbz5uVQgcQF4w0KuXpTu1vxheY52pyxdMQNZEzcyuOUg18tWOSbyCL/jDtIp9npGsFgBD4yS85kj4REqfRVRpi3+sk6nuIq9+kPJJJEbET6f1Hkip0J1kmAJS5CiBSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(3023799007)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mRf20c0kSt0ZRDZhL6a1AXXVdJ04GDLmFTN/lRf80OTRhXvjx83vVPgh5qYUI5InZ7UBjmIQBxeTNI5fuXaZQRk8D3pUcz1CeFXXTal1OG//q+Owxjn4XqLsZyLXgloOPqRkK5kb6jV7YdYowJXwZ7dazKjdjwl9eNYCIvQuVnuPsFmj6jv8skKBZxtVmPRAPJ/b3p9LsFptwcFOj0gj2rPdxwkYkpD8zHxDJAoaeWRDlIWSgTT8q6Z3iDqx4KDFBLtmO5sLyBibyCaQPIvwSbEbRnm6YP/lk0/Rer7MJvtbsBKBmd4sF0Valjpqsq2Jfism1JapTDVcTe4Y5kYhXJw47PU43xySrQSym5JVzFwL/eEmV9gErQv7cWyhnym9Y05z1RQmw+VHLbifpklJCFiAlgbWoJdtvYSrfBs5LZGRm15pyWtMVZ2/dgWym6SI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 11:42:02.4113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2180d35c-0084-4fba-ebe0-08dee266167f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562



On 09-07-26 14:25, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Unprivileged host userspace can trigger a KVM_BUG_ON (resulting in a WARN_ON_ONCE and potential host panic) by dynamically toggling MSR_IA32_DEBUGCTLMSR for a SEV-ES guest.
> - [High] Enabling Bus Lock Detect inadvertently un-intercepts LBR MSRs, granting the guest unauthorized hardware access to LBRs.
> 
> Pre-existing issues:
> - [High] L2 guest can bypass MSR intercepts and overwrite L1's MSR_IA32_DEBUGCTLMSR and LBR state when L1 enables Bus Lock Detect or LBR.
> - [High] Bus Lock Trap #DB causes are lost during reinjection, rendering the feature non-functional in the guest.
> --
> 
> --- Patch [5]: [PATCH v3 5/5] KVM: SVM: Add Bus Lock Detect support ---
> commit d2f71feda9dbdbb51e59bc110b5518d4f10bcf93
> Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> KVM: SVM: Add Bus Lock Detect support
> 
> Add Bus Lock Detect support in AMD SVM. Bus Lock Detect is enabled through
> MSR_IA32_DEBUGCTLMSR and MSR_IA32_DEBUGCTLMSR is virtualized only if LBR
> Virtualization is enabled. Add this dependency in the SVM.
> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index a59389c322da1..bd204aa33e47f 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -882,7 +882,8 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>>       bool current_enable_lbrv = svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
>>       bool enable_lbrv = false;
>>
>> -     if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
>> +     /* Bus Lock Detect in guest depends on LBR Virtualization */
>> +     if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
>>               enable_lbrv = true;
> 
> [Severity: High]
> Could this change allow unprivileged host userspace to trigger a kernel panic
> on systems with panic_on_warn=1?
> 
> If userspace calls KVM_SET_MSRS for a SEV-ES vCPU before the guest is
> finalized and sets MSR_IA32_DEBUGCTLMSR with DEBUGCTLMSR_LBR or
> DEBUGCTLMSR_BUS_LOCK_DETECT, svm_update_lbrv() will set enable_lbrv = true.
> 
> If userspace subsequently writes 0 to clear the bit, enable_lbrv becomes
> false, causing KVM to call __svm_disable_lbrv().
> 
> This would then hit the following assertion:
> 
> arch/x86/kvm/svm/svm.c:__svm_disable_lbrv() {
>     ...
>     KVM_BUG_ON(is_sev_es_guest(vcpu), vcpu->kvm);
>     ...
> }

For SEV-ES guests, LBRV is always enabled once guest_state_protected is set,
and the LBR MSRs are left un-intercepted. From that point on,
guest_state_protected makes sev_es_prevent_msr_access() block any further
MSR writes, so LBRV can no longer be toggled.

> 
> 
> [Severity: High]
> Does enabling Bus Lock Detect inadvertently grant the guest unauthorized
> hardware access to LBRs?
> 
> When a guest with Bus Lock Detect sets DEBUGCTLMSR_BUS_LOCK_DETECT,
> enable_lbrv becomes true. This leads to a call to
> svm_recalc_lbr_msr_intercepts():
> 
> arch/x86/kvm/svm/svm.c:svm_recalc_lbr_msr_intercepts() {
>     ...
>     bool intercept = !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
>     ...
> }
> 
> Because intercepts are disabled entirely based on SVM_MISC2_ENABLE_V_LBR,
> could this un-intercept all LBR MSRs (e.g., MSR_IA32_LASTBRANCHFROMIP) even
> if the guest does not possess the LBRV CPUID feature?

LBR is always available on AMD x86 processors. There's no CPUID feature
gating guest access to them. Un-intercepting them via V_LBR bit just
exposes the guest's own LBR state, not host state.

> 
> 
> [Severity: High]
> This is a pre-existing issue, but can an L2 guest bypass MSR intercepts and
> overwrite L1's state if L1 enables Bus Lock Detect or LBRs?
> 
> If L1 enables these features but does not expose LBRV to L2, KVM populates
> vmcb02->save.dbgctl with L1's state. When svm_update_lbrv() sees these bits,
> it appears to activate hardware LBRV (SVM_MISC2_ENABLE_V_LBR) for L2.
> 
> This would un-intercept MSRs for L2, allowing L2 to modify DEBUGCTLMSR
> natively. Upon nested VMEXIT, KVM copies this modified state back to L1:
> 
> arch/x86/kvm/svm/nested.c:nested_svm_vmexit() {
>     ...
>     if (!nested_vmcb12_has_lbrv(vcpu)) {
>         svm_copy_lbrs(&vmcb01->save, &vmcb02->save);
>         vmcb_mark_dirty(vmcb01, VMCB_LBR);
>     }
>     ...
> }
> 
> Would this allow a malicious L2 guest to corrupt L1's state?
> 
> [ ... ]
> 

This is intentional. When L1 doesn't enable LBRV for L2, L1 and L2 share the
LBRs. The L2's branches are recorded into L1's LBRs and copied back on
#VMEXIT which lets an L1 profiler record L2's branches.

If L1 wants isolation, it enables LBRV for L2, giving L2 its own virtualized
LBR state. So it is not a corruption or an isolation breach.

>> @@ -5595,9 +5596,17 @@ static __init void svm_set_cpu_caps(void)
>>        * Clear capabilities that are automatically configured by common code,
>>        * but that require explicit SVM support (that isn't yet implemented).
>>        */
>> -     kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>>       kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
>>
>> +     /*
>> +      * LBR Virtualization must be enabled to support BusLockTrap inside the
>> +      * guest, since BusLockTrap is enabled through MSR_IA32_DEBUGCTLMSR and
>> +      * MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
>> +      * enabled.
>> +      */
>> +     if (!lbrv)
>> +             kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but are Bus Lock Trap exceptions
> actually reaching the guest?
> 
> According to the AMD APM, when a #DB is intercepted, the CPU provides the
> new DR6 value (containing the DR6_BUS_LOCK bit) in EXITINFO1 and does not
> update the guest's DR6.
> 
> However, when KVM reinjects the exception, it reads the stale save.dr6:
> 
> arch/x86/kvm/svm/svm.c:db_interception() {
>     ...
>     u32 payload = svm->vmcb->save.dr6 ^ DR6_ACTIVE_LOW;
>     kvm_queue_exception_p(vcpu, DB_VECTOR, payload);
>     ...
> }
> 
> Does this cause the DR6_BUS_LOCK bit to be lost during reinjection, rendering
> the feature non-functional in the guest?

False positive. Per APM 15.12.2, on a #DB intercept the saved DR6/DR7 match
what a #DB handler would see and EXITINFO1/2 are undefined. So DR6_BUS_LOCK is
in vmcb->save.dr6, not EXITINFO1.

> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709082953.69434-1-shivansh.dhiman@amd.com?part=5

