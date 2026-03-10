Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464D2E7648;
	Tue, 10 Mar 2026 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157305; cv=fail; b=iJRlqBU/mdxTQO8AC1vAQOYIx8WWOo7l2a2Lq7cbdnmOYQaVAxfVJ5uuGgNM9bHV/RC5Ut9ePwgir5tPkcxjV/unl53LO8cMIwbEO+sdZQrmZakqa15ZEIrctRljhyRI7xYUZ/qPX6wu5HNQZLvwJ5tfExQVdpMT5S0vYtFOoiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157305; c=relaxed/simple;
	bh=qZtoqQQXvirBqofIoKobDJZFg9lR4mL3la7CHLyA5+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TaQsvSHTuzyhnjRWTQ31f9l9g0xtI0a/g1xTdjQQzzcIr+f0+Znhreaw2tu+69iV/ZOSYEGVWlA6LM0Pkl8x6+lKPsHOQd5ehicQMbHCiwsllA164rIAgUFWPpEUsgAEfAqYU/ZHzrIM4C7zx1Y+McrHKfidhR22g/fnvHeYBoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=in9bCO/M; arc=fail smtp.client-ip=40.93.198.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="in9bCO/M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cp+OrTOXTEsS00kRnl1GXKcYFQGLjEKhbS0BKeyhT06FNE0wMO6COqliOJDGTAs/Mb2fohNOnXLnNdZwnWDx3F1OtVldcajA5jzssb/SfNhEFCNq8hEkxfCnpopwEprPBQq0G6swYmhuTiGebk0tvF8zvIptGAdFVuj3rKjKNK6xkKIx8DJcH0H7AFjJbP/8N0YjCHG8+N2BfMSRZoBbu3GtqXAg1ulEUKdgD3w7KCWvtQpOCldEDY4zLY/9i+TGgloLcDFVIw3KzNmHWqpUDvsEUPmzK/nxcsTk0C8s8FBVi3Vgq8lGruebfKOP3XFyExjnX4cFQdAuLRhFPPz0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7UJCdDuLuXULhJzW1XnnlDi0dBKthKLiWAvbRQyBYM=;
 b=u4g07GeeePj8WwUInXTqDK7MC5pGUF3bKuRLEExXv2jXcUIWcSEizYNnJ5az+7dYfqv+0ysWOGcx8pFxKpoKk57B5hEh/r/QauK0JbAg0qxl0n4EQVnJi5mJIQAjVXt0uNKa/Ps3uj32gYz4FiElSaezYVcL9J3A6qA0hyGtNnN1alSpbIZ0z9JPnCGi9l2rxxkga/nLnSdUStPg/HgHNmTJ66jJ095zDUeACDPOi7b+mW7TFEzaNTC5HNaEIkHbzKcUQDJJK5/6FkECZ7UNASTqQc5tNf28a6HmQDmYUuKdLZ8A0/H1R6sfs+9fQj8Uf3X5n0ip5/TNHyyxGxsWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7UJCdDuLuXULhJzW1XnnlDi0dBKthKLiWAvbRQyBYM=;
 b=in9bCO/Msg00pWWXLevXYpVdAK544lcgerYous93kHf/5A+PHyekH21I0OHtxUYcLxZAMYF/SxlZRQM5gXD/dlXdGo2xhP3hghy1uDnGs8rjMZst9V9NbKNA8GkTq41FimXRrnlEiMu9Z48oTYAaubHWOjiCwDxDwsUrgyPFXbM=
Received: from BN9PR03CA0200.namprd03.prod.outlook.com (2603:10b6:408:f9::25)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 15:41:37 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::81) by BN9PR03CA0200.outlook.office365.com
 (2603:10b6:408:f9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Tue,
 10 Mar 2026 15:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 15:41:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 10:41:37 -0500
Received: from [10.143.197.5] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 10:41:34 -0500
Message-ID: <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com>
Date: Tue, 10 Mar 2026 21:11:34 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jim Mattson
	<jmattson@google.com>, Naveen N Rao <naveen@kernel.org>, "Maciej S .
 Szmigiero" <maciej.szmigiero@oracle.com>
References: <20260203190711.458413-1-seanjc@google.com>
 <20260203190711.458413-3-seanjc@google.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20260203190711.458413-3-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 993fba21-cd03-4c16-cdf5-08de7ebb8433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	u9APeVtKvTvIDsVocfPbqF592O23USHr+hfWRDo4hJnBoi1H848JGHyqSE5z4kZGWqGWI/cFkd3ikGxIzWgDMj/hNOhY36TVRGS6ymLUn67U08YaEls3vLS3z8B2UgkuLjgjncPz50z02Kua6qWFCPNE4o/ajKOvz8jy+hd5sJo613pLci0cLDLYMW9pO7HGRMkPpqXVUNDvwb8UtVvjsZqrW0pSwtIh7LhkqMDygnKqHGvssee+j4Eb5+JrxJ+JU91FW9YxjWDkrmNyskJwWYNn5LbTO8cjmCqotzqoqiLYbFLR3b5cpvzFi1T+z2fle4oE1d+tYI32zcMZSTEeTtRmXN0zaHL8bruGqyMm3HZWMxRQDPJgsPsBlfb1T+OTzpAbpXhAd7uM7piXCJKp6V7iJOW0UGUl6N/1x44s8NlSgGpK4LzMGdFsYKMo8tnU7JJt0eUAaz4ors0uUT2tp/CEvi99h2qDLWkLXoR851GihJ/KM72yH9XSDXyQpm6Twnx65boVo3VK0YfxtTa5TURVP6X+q9SAdKCKB+bRzjpTGyiQbuCKXu+CIcNzmVn8IriM1c8sD43TDxrHvnpYLZy/HUfiFQ/Z+/SDzvIMESY5MYzzQqaLE4RruUSOluxmj7sm5VhYUQzYNsW+q/WwtLJ9gG395KoBZOQsgMSWXHHd0JxLN93SkgeoRl0yNUvsYFhplraylVpJAECFYPmjJp2QAtsJc1gbYzW6HhpU+ro0P1HHSKEBao5J7ZxwCsixxCFC/IiqJG3E3jpvPnnvvw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9A1cXOi8/oKQ8NFnphOlEDT9+DuRZTU93xEI8/qIC/dE6OayjOaiyduVreHKKYshE/0EhPurDMrlvcn7Chvh/5oI5tt5a04tVPFUZwcgQOYR6NGPvpGfTu+nvgqcDfbzG6kg8cBWYPX1MflFAL94HBBK5uRROe0hpEM2A5A9Ccgxu6Yd20zR6FKcNFLvRGj2tBTMZFvcaGjFNzVtZ3L5l1iULg0P1WKi3A5/E1TnwEE0j/D0W3tdDZzqXVRY0y+AoKMddT92hx54RnWsf3xkRNh7TKF0/bGueHd81monDnCNx97W1cRM7acs2OkpDVAcQPBqikTA1Uo35/pL+r67mcZDcZvRBWW18ihZA3Pi6nFia1c+gIlXWXRYU42GiHDhKXzA6azWt55/ncq4rsYKmx1oE/jBUv0wzzxlj2l47AE4l4KMid7wLYNX1qD7M2WG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 15:41:37.4729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993fba21-cd03-4c16-cdf5-08de7ebb8433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385


Hello Sean,

 From next-20260304 onwards [1], including recent next kernel 
next-20260309, booting an SEV-ES guest on AMD EPYC Turin and AMD EPYC 
Genoa has been failing. However, on EPYC Milan, the SEV-ES guest boots 
fine.

I am using the same QEMU command line (given below) with the same 
versions of QEMU and OVMF on all three platforms.

"$QEMU_BIN" \
-machine q35,confidential-guest-support=sev0,vmport=off \
-object sev-guest,id=sev0,policy=0x5,cbitpos=51,reduced-phys-bits=1 \
-name guest=vm,debug-threads=on \
-drive if=pflash,format=raw,unit=0,file="$OVMF_PATH",readonly=on \
-m 2048 \
-object memory-backend-ram,size=2048M,id=mem-machine_mem \
-smp 1,maxcpus=1,cores=1,threads=1,dies=1,sockets=1 \
-cpu host \
-drive id=disk0,file="$DISK_IMAGE",format=qcow2,if=none \
-device virtio-scsi-pci,id=scsi0,disable-legacy=on,iommu_platform=true \
-device scsi-hd,drive=disk0 \
-enable-kvm \
-nographic \
-monitor tcp:localhost:4444,server,nowait

QEMU version: v10.2.1
OVMF version: edk2-stable202602

The SEV-ES guest crashes with the following QEMU trace:
error: kvm run failed Invalid argument
EAX=00000000 EBX=00000000 ECX=00000000 EDX=00a10f10
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=0000fff0 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 00000000 0000ffff 00009300
CS =f000 ffff0000 0000ffff 00009b00
SS =0000 00000000 0000ffff 00009300
DS =0000 00000000 0000ffff 00009300
FS =0000 00000000 0000ffff 00009300
GS =0000 00000000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT= 00000000 0000ffff
IDT= 00000000 0000ffff
CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000000
Code=30 17 4d 99 a6 74 ad 5a a1 1d d2 22 78 9f 73 25 ab 00 2f c0 <cd> d3 
ee 26 63 0d f5 de f3 ea c3 91 28 ba b5 ac ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? 
?? ?? ?? ??

KVM host serial log message that appears when the crash happens:
text

[ 4379.695497] kvm_amd: kvm [5809]: vcpu0, guest rIP: 0x0 vmgexit: 
unsupported event - exit_info_1=0x18, exit_info_2=0x0

Bisecting shows that this commit is the first bad one. When I revert it, 
I am able to boot the SEV-ES guest successfully on both Turin and Genoa 
platforms:

e992bf67bcbab07a7f59963b2c4ed32ef65c8431 is the first bad commit
commit e992bf67bcbab07a7f59963b2c4ed32ef65c8431
Author: Sean Christopherson <seanjc@google.com>
Date:   Tue Feb 3 11:07:10 2026 -0800

     KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git, 
next-20260304

Will be happy to get any more information required. Thank you.

Srikanth Aithal <sraithal@amd.com>

On 2/4/2026 12:37 AM, Sean Christopherson wrote:
> Explicitly set/clear CR8 write interception when AVIC is (de)activated to
> fix a bug where KVM leaves the interception enabled after AVIC is
> activated.  E.g. if KVM emulates INIT=>WFS while AVIC is deactivated, CR8
> will remain intercepted in perpetuity.
> 
> On its own, the dangling CR8 intercept is "just" a performance issue, but
> combined with the TPR sync bug fixed by commit d02e48830e3f ("KVM: SVM:
> Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active"), the danging
> intercept is fatal to Windows guests as the TPR seen by hardware gets
> wildly out of sync with reality.
> 
> Note, VMX isn't affected by the bug as TPR_THRESHOLD is explicitly ignored
> when Virtual Interrupt Delivery is enabled, i.e. when APICv is active in
> KVM's world.  I.e. there's no need to trigger update_cr8_intercept(), this
> is firmly an SVM implementation flaw/detail.
> 
> WARN if KVM gets a CR8 write #VMEXIT while AVIC is active, as KVM should
> never enter the guest with AVIC enabled and CR8 writes intercepted.
> 
> Fixes: 3bbf3565f48c ("svm: Do not intercept CR8 when enable AVIC")
> Cc: stable@vger.kernel.org
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/svm/avic.c | 6 ++++--
>   arch/x86/kvm/svm/svm.c  | 9 +++++----
>   2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 44e07c27b190..13a4a8949aba 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -189,12 +189,12 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
>   	struct kvm_vcpu *vcpu = &svm->vcpu;
>   
>   	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
> -
>   	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
>   	vmcb->control.avic_physical_id |= avic_get_max_physical_id(vcpu);
> -
>   	vmcb->control.int_ctl |= AVIC_ENABLE_MASK;
>   
> +	svm_clr_intercept(svm, INTERCEPT_CR8_WRITE);
> +
>   	/*
>   	 * Note: KVM supports hybrid-AVIC mode, where KVM emulates x2APIC MSR
>   	 * accesses, while interrupt injection to a running vCPU can be
> @@ -226,6 +226,8 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
>   	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
>   	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
>   
> +	svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
> +
>   	/*
>   	 * If running nested and the guest uses its own MSR bitmap, there
>   	 * is no need to update L0's msr bitmap
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e8313fdc5465..aa3ab22215f5 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1077,8 +1077,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
>   	svm_set_intercept(svm, INTERCEPT_CR0_WRITE);
>   	svm_set_intercept(svm, INTERCEPT_CR3_WRITE);
>   	svm_set_intercept(svm, INTERCEPT_CR4_WRITE);
> -	if (!kvm_vcpu_apicv_active(vcpu))
> -		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
> +	svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
>   
>   	set_dr_intercepts(svm);
>   
> @@ -2674,9 +2673,11 @@ static int dr_interception(struct kvm_vcpu *vcpu)
>   
>   static int cr8_write_interception(struct kvm_vcpu *vcpu)
>   {
> -	int r;
> -
>   	u8 cr8_prev = kvm_get_cr8(vcpu);
> +	int r;
> +
> +	WARN_ON_ONCE(kvm_vcpu_apicv_active(vcpu));
> +
>   	/* instruction emulation calls kvm_set_cr8() */
>   	r = cr_interception(vcpu);
>   	if (lapic_in_kernel(vcpu))

