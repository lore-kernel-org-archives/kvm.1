Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067D472F7C;
	Wed, 19 Aug 2026 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141312; cv=fail; b=A2aqzdXYWpIQgEPpRzVFPMDlzlGMmBWsh6rSexIO0/6S20JbvWvRiQrbtqoUZMGVjL7frrHhgQeC9IjckOaAa/RT0hPeWMt1PQYbPl4vvZfSOh7CzMHeohN/v9h1UPeoDmnGXZAEvgfkC+zklrwUE75u8g2dF1QX1fu/XxRXK2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141312; c=relaxed/simple;
	bh=h9c+ZKvsCXUnXTxAY1u/ICk8nKoNb0ykWBTvhLqjOJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QKT3/ZWh4SriEZds3ULSn2hLUmh4uHHBH2Jq0RQBTRmeAeZZorNSyT8ppgnrfw5k3VNkHwfhpPTIuc9Phg6D2UOWh2RrIANe0DefKXn1QVUv592C2hTu9EARO8hqH+GjL/HRGB2cHVrByBrroLEQX7eZSufXTe905V8aDxP2Fsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bl4JGGG5; arc=fail smtp.client-ip=52.101.43.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bl4JGGG5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2K58RvQ5Ki2T2fzjEjhF+Z54h9jgi0bi0BCfnc7p9NnCk2IuvWQFd/zVUwH7gPQkO4vyx4PPnOnxts4oVhqAlFUnXgrMEBvra+lg+/oiggSmTVg/SuPSD/LJBRVWTSwNBpFaQ+0hGsU2FXEnQFGtf5Wc+DzjLCBi4NfNV5z3ll48SQB8jVrlQlsAl+cG1jHhafSrMq6RHt3tcaJwiKLTjfGhjY6ukogUqS77+gRWT7rqU9aiHSTRXaXV8LpLqnpNO8C8y/+3QYgfcMOlULjvYg6+Zw00N24ITRS7ZkaUWRqgrITtK0pBwgdeG5DEkiYcFSgbjOp2B0JIzwGIKVsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvIxacTodszEefkQ86Z0KOY+QRNp/itzoTa/CGO1dtM=;
 b=cZ0UdjVfFu34S90jCQ30NSdw/iKGj1xNm8AXtYLhhObYoNlgBkH2B/em6BAb/g07DOCxK75okujT8KAhQ1YNSb/fZ99vMG2lWmpqmuV8pGm87bQWIilz8C/tUzIwM0LpgiMSgFCB0S4mR4ZfDs9TkmDAe0uFi3wWG3vBAvtsbkgKC1KZt67Jvvks8VVoaiOt9yaB1c8BCpTaQg5xYQeszRnypDqg0aU6l5ft7mHrQlmKkdGR+DMfGaKdPAWPR7NtBfncwCCTL9fOkjpSeQtE3VRbzCn4tAS6StaB5EdALKQpmXqd22Lrw+7v2lY9IHWfe7Cb9KD1Bd+ySNy3JK2U2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvIxacTodszEefkQ86Z0KOY+QRNp/itzoTa/CGO1dtM=;
 b=bl4JGGG5JkZnObPAYWosWYSmBBWL/YB2XkYzX/ahLwyAbwfDyI9KWsRW4Oz9lMEOQZZEMMbiIKCwHT4OHBGRWSYNJZpn+Olo+Y/MzWp2oAWR7qeNptnAfL04hRoTDgVbklPj/x1VywezZ/UY5T/QA2SxEGLXaCuupVEQxk2VqiI=
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 12:08:26 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:59d:cafe::5b) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 12:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 12:08:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 07:08:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 07:08:21 -0500
Received: from [10.85.46.157] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 07:08:17 -0500
Message-ID: <829b5c18-6ffe-46fe-bfed-03d5ddde92d9@amd.com>
Date: Wed, 19 Aug 2026 17:38:16 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] KVM: SVM: Enable save/restore of FRED MSRs
To: Sean Christopherson <seanjc@google.com>, Nikunj A Dadhania
	<nikunj@amd.com>
CC: <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <xin@zytor.com>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-8-shivansh.dhiman@amd.com>
 <aauJ80pZrw_SfF31@google.com> <db768f80-dfda-42a2-8601-8d0af35c2959@amd.com>
 <an0BbcxUNRKqnUSJ@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <an0BbcxUNRKqnUSJ@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 62977b8a-c002-433a-78fe-08defdea9325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|36860700016|1800799024|3023799007|56012099006|10067099003|4143699003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S45QeYzrlBC+PEbjBKcr4WulZ0TaMz+mHyWa0hAQ4xTnZTXLvkmMN9LaPPn3V3hUUyAQLd8E1snLw+YkPij8rR2t6g+WvSxRr5ceBqTnaR9eT4RzFvSYGh7qtGMNA0QdqOPHmT1+9wUBi74LV7UZOsxqiThtu9f5HnBejMavdQqYUWk81hDj7jxx0U/OVidoH6IzUgV/JnpfEdxgLvr5Rc8CeCQvUcu8cHM86q8ufqM6CgrJgayKJPMxnCDzeXxjsUaZUKLscgeUjynLMjVw1vrrpJIJUHU/sSEOtcfwjp+kgzJhHea64MTbsxbaoUrojxkft//XmHTgXMxBSCDuuDZ5tXgO/tAcX+RgSBGQ+vkf6EapuvX64yEvj2H/bTGeHcHpVgn53x0KPsIPum1/fm6xWFQXFJG68rhjl7ON4ZKax5W+IRpSLL/norkLS6XyU/U6siSulCz3LcCZdKmJnzyyImcAzPJ1Rdj4jsO6KjJp0YvVJduca/7NZPAHiq5WIKQPTf23R2eRBDguF6UTMJNZoRNMCLWierv0GixwqYVZPeTs7M53W5aNUCYOrsoD4YANGlpxYbtKxkD30LYGo6Mf9rOqnFtwbN5B0lJAW6KSO7feLkizB56V4fngkv8wB0IkxXHzEMx0VZIdDOUkEB+vVp8MGjLa6rQl4G/iJVUG1Td3RlCswk1vmcIFy+Qv19X93PMNvWdFJY6gNdkhWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(36860700016)(1800799024)(3023799007)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WoOlAGsGV+wGHR/HOnGCEgwA1eIPFHDkar7M5ULkgo5ukN0Eg+Rioi4OjFU4KOObdfzipsVFp/0WwCdrF0m5YZWYLt4BoU8WYiszfrVcT1WtB0K3MEB7JPambdEZRj/lQvP4YJ0a7qx8VlcM9Eo1zwf/A/9rDxQpKlckOA8vAGhUaIEGh6M4lkPWbfyPtXPYqlyPv0EML+MSuV9AbX/bL8YpdCkLpS+aSmEFPbdw3BNiaK/eNblF1BHi23LMMLX8caMLwydtU9WMtiqrETOUIzmTaC22CHo16QK9f9t1bPuamCSgaj9BVgqfwQPVuz8vGf4AfkdzfOgfu7oO2q+UW5+r1ivc/fjaQFWo0+uKSo1uOmekEeVbGt/uiLsroHbjiSLTK+id8S/ElQWoeT7qg8nObg3gFYsNBIztfjmr9qI6mhWIrqzbQwu68INKpn8g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 12:08:26.5247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62977b8a-c002-433a-78fe-08defdea9325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888



On 13-08-26 04:57, Sean Christopherson wrote:
> +Nikunj
> 
> On Mon, Aug 10, 2026, Shivansh Dhiman wrote:
>> On 07-03-26 07:44, Sean Christopherson wrote:
>>> On Thu, Jan 29, 2026, Shivansh Dhiman wrote:
>>>> Set the FRED_VIRT_ENABLE bit (bit 4) in the VIRT_EXT field of VMCB to enable
>>>> FRED Virtualization for the guest. This enables automatic save/restore of
>>>> FRED MSRs. Also toggle this bit when setting CPUIDs, to support booting of
>>>> secure guests.
>>>>
>>>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>>>> ---
>>>>  arch/x86/kvm/svm/svm.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>>>> index 954df4eae90e..24579c149937 100644
>>>> --- a/arch/x86/kvm/svm/svm.c
>>>> +++ b/arch/x86/kvm/svm/svm.c
>>>> @@ -1144,6 +1144,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
>>>>  	save->fred_ssp3 = 0;
>>>>  	save->fred_config = 0;
>>>>  
>>>> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
>>>> +		svm->vmcb->control.virt_ext |= FRED_VIRT_ENABLE_MASK;
>>>
>>> This is completely unnecessary, no?  CPUID is empty at vCPU creation and so FRED
>>> _can't_ be enabled before going through svm_vcpu_after_set_cpuid().
>>
>> Hi Sean,
>>
>> You're right for vCPU creation, CPUID is empty there and the hunk does
>> nothing, so I dropped it in v2. While preparing v3 I hit a case that does
>> need it though, a triple fault:
>>
>>  1. The guest enumerates FRED, so the FRED MSRs are passed through and
>>     FRED_VIRT_ENABLE is set in virt_ext.
>>
>>  2. The guest triple faults and KVM intercepts SHUTDOWN.
>>
>>  3. shutdown_interception() does clear_page(svm->vmcb), which wipes
>>     virt_ext along with the rest of the VMCB, and then INITs the vCPU.
>>
>>  4. init_vmcb() runs, but svm_vcpu_after_set_cpuid() does not.
>>
>>  5. CPUID still enumerates FRED, so the intercept recalc puts the FRED
>>     MSRs back into passthrough.
>>
>>  6. Nothing restores FRED_VIRT_ENABLE, as only svm_vcpu_after_set_cpuid()
>>     ever sets it.
>>
>>
>> So the guest ends up with direct access to the FRED MSRs while hardware is
>> no longer context switching them, i.e. it can clobber the host's FRED state.
>>
>> Setting the bit in init_vmcb() is the smallest fix I came up with, so I'd
>> like to add the hunk back in v3.
>>
>> Would you prefer it handled in svm_recalc_fred_msr_intercepts() instead
>> while setting intercepts? Or is there a better way to deal with this?
> 
> Take a hard dependency on an upcoming APM update that states the control area
> is valid after shutdown, and rework KVM to not clobber control fields on shutdown
> interception.

Sure, Sean. I'm thinking something like the diff below. It contains three
parts:

1. Clear the save area and offsets 60h, 61h, and 68h of the control area,
   as per the APM.

2. Zero the intercepts as well. The APM doesn't require it, but it seemed
   worthwhile so that the new intercepts are computed on a clean slate
   rather than on top of whatever survived the triple fault. Is that worth
   doing?

3. For nested, same fields are copied to vmcb12 when a shutdown is intercepted
   in L2. Clear them while copying so L1 gets a deterministic value
   rather than whatever the hardware left behind. Does that seem like right
   thing to do?


diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 83de3456df708..38843b29b21ec 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1149,6 +1149,11 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
        vmcb12->control.event_inj         = svm->nested.ctl.event_inj;
        vmcb12->control.event_inj_err     = svm->nested.ctl.event_inj_err;

+       if (vmcb02->control.exit_code == SVM_EXIT_SHUTDOWN) {
+               vmcb12->control.int_ctl &= ~GENMASK(15, 0);
+               vmcb12->control.int_state = 0;
+       }
+
        if (!kvm_pause_in_guest(vcpu->kvm)) {
                vmcb01->control.pause_filter_count = vmcb02->control.pause_filter_count;
                vmcb_mark_dirty(vmcb01, VMCB_INTERCEPTS);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 519249e75420d..62b4feb9c3909 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2090,7 +2090,11 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
         * cannot be reinitialized, i.e. synthesizing INIT is futile.
         */
        if (!sev_es_guest(vcpu->kvm)) {
-               clear_page(svm->vmcb);
+               struct vmcb_control_area *control = &svm->vmcb->control;
+               memset(&svm->vmcb->save, 0, sizeof(svm->vmcb->save));
+               memset(control->intercepts, 0, sizeof(control->intercepts));
+               control->int_ctl &= ~GENMASK(15, 0);
+               control->int_state = 0;
 #ifdef CONFIG_KVM_SMM
                if (is_smm(vcpu))
                        kvm_smm_changed(vcpu, false);


Cheers,
Shivansh

