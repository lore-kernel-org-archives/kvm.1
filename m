Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8F1C5F27
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 04:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777005934; cv=fail; b=cYLF7+/d8NwaXGAlB1h9c0pRwalzi2GScJkt4/mMbKWpQqXfJjfmeI6YNMiD9iRjBXrjh936SlVt/vXfkuUSFZa1cvJ59dJiNWJwhnO6Kj4BBCKjmuysa1Zr+56ak1nzraDy+dZp6acAhx5F7aFkKhKBSwrpsWflAOxGQBr5t1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777005934; c=relaxed/simple;
	bh=Gh4k6m97ZkTARhME1W+uBbgMAGhMXFcIyU1g3utHYsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=crHrxQdI+XW/vZpa3axZtNusZUatiSOinGTzZZem1PjefXOQHtKkscFrUIwKXhXna9Se5/o3DWpqfYaj4CafifypbdX6j59ZQTUbS5jNmu7tW7hJ3X+/jd+CqFZSPp7TSXxI9p1TlB0QusmZoM2A93TksOgQg1Fa16T+hz5F0DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bfa7WSF7; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bfa7WSF7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycZTEL75uQGIj3RUsLgHAfKwiFmzTLnxBX69FIDAnzXp9VpN71963nUhYgBifDfpaZEKm9CB2zGEj7bLGfS39nGrBEtSkWrLmy44kuUaAvq7JCtOCy/N7DuGnyMRCSpTQaOZLvVBbx0Uk99Cso76zPmH4CCignvI5M6qyk25BSpGtD5OKL6RGbRfTWf0A9bS/DpTS+eI+ZyBr5wMKKGIVQ2hn7aUWjoHWprCGeWH/f+lTPyCTR0TiAMMDO/awVF/Pc2KSf8kLQ86vGIgTIih+VAt6IaF/6ZkOhgeTLFMyJhQoTilGVvetjspcOoUA1KGyFn3v1wycuJUV+L0Kndqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6sWPAbS0sNK94qf6Ttc954qESa0zEECvGEDJimDMHc=;
 b=ANUHSKA33IGAITnG9fY1OZ4uXVMqj3YOCtrc/EXGduNrdqD+RUXM66FU1cB8f9duET2Ck7Eo+xlR513rW5gmPn91wm0JE5nljV6+Hv5NvCgYst1Bvnfvfakg9pY7Xo0hG0gYqEZnFgDhA20/CKTr3eJ+TwbWW7NrROyuJ5BKdhQS1QJOuHYRsgwLxkXeQXJmUmAmcek3YMRNVz7djHKHGaO2vviZKeAVfWBISTzK+SIJgRloqZ3pgVxoCK/opMwcaOKeWChx6j7pGe5j1eMq8MIJ0re8D55ugFpg2+H9eMDzUb6rAauq91Wm7E5Btw8wnGOBhWl18eR5NanE6NRAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6sWPAbS0sNK94qf6Ttc954qESa0zEECvGEDJimDMHc=;
 b=bfa7WSF7sCv7LTO+vPHZhJjYkfAEyTLM+fG63AVGyZKkmHxfEqTZyry0PWVTa3ePBgk/fUyKE6lqCBtv98H28uUwftonabExhM7Ax8xw26ch707T6R8lf2qZ2tBI3Y5XV8JqRW14NGaiZwyGQTvYJXdrszGETYhadvIt353bk60=
Received: from MN2PR20CA0010.namprd20.prod.outlook.com (2603:10b6:208:e8::23)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 04:45:28 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::36) by MN2PR20CA0010.outlook.office365.com
 (2603:10b6:208:e8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 04:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 04:45:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 23:45:27 -0500
Received: from [10.136.45.190] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 23:45:25 -0500
Message-ID: <bbbcdb11-1195-4e56-9fe4-c99ad2c00826@amd.com>
Date: Fri, 24 Apr 2026 10:15:24 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: SVM: Add Bus Lock Detect support
To: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: <yosry.ahmed@linux.dev>, <nikunj.dadhania@amd.com>
References: <20251121081228.426974-1-shivansh.dhiman@amd.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20251121081228.426974-1-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c17c58-a4c5-42f8-c237-08dea1bc4eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|13003099007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QcbnQSYwmb/ikfQIbsCv9/I6FaUlEF7TzscrROeToyOY9+FE4YSoU7QGwqwd0kda6w37976G+yZQBUujGF2XeIAFcf0E4Lc8XcZqaZNLFsqNx4AHn7AOQGcjA5z4UIUkEITIPbtJ+XjcdY+xZzy6BdNzCHsdgph4TDfnUh0S2epAdvHgvpBxDqsAoxc1DkHZ88d6bScWx91SIU54gt6GYbKT2+A7cuoTPyh9oFYR9h5WU2qxoS0ji189sd1hK1eGZOULNo9/f55EQS+tpD8XqfjDlJZYFPZT5ul5kX0IVGqn6ijRVuE/KfWTJaACFp534NrUU6yrYUN7XjxENt07r9XHE9JxWHXfTQJ+Zxf6B7glNjIbmu0+KUwx+wnhqy37CZ8ArPh4+6muN33bZZFyLh9bY+SFQR/ci9W4t//CQYWUCtTWcQVVsJ764Z8KrlfCxEJeEOQjFwQ9GaWfTA8crlXvIPJcLXcRrf/uoOzdGernP6YFOH9gXaCqz4OGneHZe0vW1gflLhcKTZ6wzrV531i978mJdbTysf7IeVD9RNRlESw9DR5B/HmHoNYRlbuPZWYNmQgq+qDFn/L+26Q/LpEEpDaVFWA3vnA5h2Ao1iYTLyR9a9rhVjUzWVjYTzGeyCi3TuFWB9AgPWXFLl/8ryUrj3zcAOR2znC8DLkpEMNgd88Qi4ERdoOsyTuEx9D+LQaXMztdKQiFltvjjDh0+uUXbQC+Ak2PwiosFyaT0s0596BWAgZT1ZvhrePfstedTRexg1dcZe36t8YJU411RQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(13003099007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7M6o2eoL6BEgreQPAdWczywfmiqNl4ro3KMyPWwv4QJWJWVpcbq59RHZ0LYXIWwQZnCh8tNS6sWUdTfmAhOSuF17Wze6TV0C9L7sgosmIIH30c4r1Fcvgkpiukdg8N/7XzyKHxzdGHcUQ7ER7SyqCnE2730EWE7tMYmpijjXiOY81ctjoIm2h/5JkQdmcBj42gWbA1HxofZEnzLvZViPUJ4y/vUNE+cGoEd8Zp0TlhGbgnvvKluPbVC2d9uXf88nDsfGOs5beZ1xKXASyXp+t/vma2DWe1cuQ0qtky3bIw4+QHRoX6aMZhOuKLPk1FeHLjTfxZ1800eSlpyR411sh0YQe3ruQL5cvDC4+X2IZ3n7t5lh8P1D8yhMKOC2sS3M0i3EM2fQbVNIYYRtmy7wac2vdXgTErWY5iNSy9wI1RUluOL+PMBGoHBYpkAEnr6Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 04:45:27.9539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c17c58-a4c5-42f8-c237-08dea1bc4eba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

Hi,

Gentle ping for reviewing this patch for Bus Lock Detect. Would appreciate
any feedback or guidance on next steps.

Thanks,
Shivansh


On 21-11-25 13:42, Shivansh Dhiman wrote:
> From: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Add Bus Lock Detect support in AMD SVM. Bus Lock Detect is enabled through
> MSR_IA32_DEBUGCTLMSR and MSR_IA32_DEBUGCTLMSR is virtualized only if LBR
> Virtualization is enabled. Add this dependency in the SVM.
> 
> While adding Bus Lock Detect support, also fix DR6 handling in nested
> virtualization. Using DR6_FIXED_1 to prevent reset of BLD bit (bit 11)
> between VMRUNs. However, it preserves DR6_RTM, which is a reserved bit
> on AMD processors. So, DR6_RTM bit must always be set to 1.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
> Changelog:
> v1 --> v2
>  * Rebased and used guest_cpu_cap_has() instead of guest_cpuid_has().
> 
>  v1: https://lore.kernel.org/all/20240808062937.1149-5-ravi.bangoria@amd.com
> ---
>  arch/x86/kvm/svm/nested.c |  3 ++-
>  arch/x86/kvm/svm/svm.c    | 17 ++++++++++++++++-
>  arch/x86/kvm/svm/svm.h    |  2 +-
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index da6e80b3ac35..5af7fbf5c536 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -665,7 +665,8 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
>  	/* These bits will be set properly on the first execution when new_vmc12 is true */
>  	if (unlikely(new_vmcb12 || vmcb_is_dirty(vmcb12, VMCB_DR))) {
>  		vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
> -		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
> +		/* DR6_RTM is a reserved bit on AMD and as such must be set to 1 */
> +		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_FIXED_1 | DR6_RTM;
>  		vmcb_mark_dirty(vmcb02, VMCB_DR);
>  	}
>  
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 10c21e4c5406..ceef5b697e11 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -831,6 +831,9 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>  			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
>  			    (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK));
>  
> +	/* Bus Lock Detect depends on LBR Virtualization */
> +	enable_lbrv |= (svm->vmcb->save.dbgctl & DEBUGCTLMSR_BUS_LOCK_DETECT);
> +
>  	if (enable_lbrv && !current_enable_lbrv)
>  		__svm_enable_lbrv(vcpu);
>  	else if (!enable_lbrv && current_enable_lbrv)
> @@ -2984,6 +2987,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  			data &= ~DEBUGCTLMSR_BTF;
>  		}
>  
> +		if ((data & DEBUGCTLMSR_BUS_LOCK_DETECT) &&
> +		    !guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
> +			return 1;
> +
>  		if (data & DEBUGCTL_RESERVED_BITS)
>  			return 1;
>  
> @@ -5258,8 +5265,16 @@ static __init void svm_set_cpu_caps(void)
>  	 * Clear capabilities that are automatically configured by common code,
>  	 * but that require explicit SVM support (that isn't yet implemented).
>  	 */
> -	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>  	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
> +
> +	/*
> +	 * LBR Virtualization must be enabled to support BusLockTrap inside the
> +	 * guest, since BusLockTrap is enabled through MSR_IA32_DEBUGCTLMSR and
> +	 * MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
> +	 * enabled.
> +	 */
> +	if (!lbrv)
> +		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>  }
>  
>  static __init int svm_hardware_setup(void)
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index c856d8e0f95e..8e8d31788c9c 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -675,7 +675,7 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>  
> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
> +#define DEBUGCTL_RESERVED_BITS (~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
>  
>  /* svm.c */
>  extern bool dump_invalid_vmcb;

