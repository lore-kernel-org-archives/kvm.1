Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792734842;
	b=jSjnomqDLVGTZu6UVp+5PS5ghgcbhn6loBNHinHEmFN/Mx9IFXowQkm0JR7aFaAt9WPJ
	 ej8dWs5qm3HEjiEdLMVe9k9WDrcyPcWnSXtXbOnqAmvqEQ0gNcaC7U4cliW0CpsCClMia
	 yOCXDAeAbKc9i2zGLM7DeRrVCRKdxsSTqN0yCOXpyxR7QqO8jq3r7+AAtsrYLHtH/EhFi
	 uoO5qol5DPNtiqpOXluPhQNdaP5OUYJytX5tNtpkBMpS6hkFLBreqXMPKRNf2WW4DQ6Pk
	 BFctwpYfsUiq6E78XUJqo1bJiiMNfN/QIgWOQcftH91lj3tDWQ2yccI84wLEcFIRN5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734842;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=L8SDGsG4Isk4tzJcm8/8vLWzjK8STfu7wgfcf16uVAA=;
	b=4biJr22jmbX1RQSYYXGds6y85vQKMvu6FYu+nfYAyhbjIlmddoLI8hKgDykWRkGsK5H6
	 6S0Syctgy3V7opf1Y0IzaGKv2gi+lKWtflA3EIST4RzPbGOEKr9TYNRHRPM/n4NxzDv8f
	 yKGhHd7TqI3OyPIJLF0sj8Xs4LrrUInXF8nXbZsxVKJUEr/oMvURVIt1z6kyKMSIJDZGr
	 i4lNRDpG5Ux5gb9c4VRb1xUIso5ySPMXsUWqEjjfyZvGxGYTEjkq6kDQfdiyVuYy0vdn6
	 43h6KrBoIfyx6LW9Dr/Nu27+BoyLBMIm+kx0J1Y4rVIfM++Aq6axYs1laEyA7Z4nnJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PYRiKGIw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.11
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02243606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 05:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02243606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PYRiKGIw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1X3J2x70fboU56udrGwSQUj1ruN5qB+Oo9TMuXbAk9l4t9tUAavl57/fdsCzxaasgzo5x5WjbHjH59xMFFkgcdwmIa4q1/9oLQ3Gfif+o9k/5JyjPkNHi3/wKKJoMbkBQggmVpTqYN6XNP4au8SlInHlS8wK+DbZX20Va7NEIUDrqzevsWXd5Lo8yhteEcmLnSyA5qGxOy4C6fc2DoWWQE91kU+8iQknShEAaf+YNMaL/hGg6EHgWIfVsXGTkfAWE7wxW2h+wg4zcYTmvCOKo2nANzNo6kIkxhmq9mcK7HSD+dutG+eQas7RxhSnKVbkETqBJmDl0sUofKWFrb+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8SDGsG4Isk4tzJcm8/8vLWzjK8STfu7wgfcf16uVAA=;
 b=YdIp/fzv0r0Oov10eJZ6CTVNEZ08b8u8ewaQVnnjd1KTedqhfKkBe6H5QnssaFYsl4Vgj8ewlZIKfs6czEivzXx8pv5/50XTrHQOL+dCUy1lhkj+tp4VGvrD9k3XzraOCGE+UYk6kGr9qYc9RfVzWaiKGWqMkmxqPFzSTn6h2Naq027IuGiSsrTa7rRwRKhjaBmrcPfEIbeheOKfyxdsNLXg16w+uZJdeTorApHZYHnUfYKoPhyc3il2mjBV/1hGMDT00I3x9D90VgeQGVeTetTaIWf9bpjOLHWBDJjGR0k2lJMUIslLeKV+5OMLEnyREZPZXnQlwz2CLYukw6JBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8SDGsG4Isk4tzJcm8/8vLWzjK8STfu7wgfcf16uVAA=;
 b=PYRiKGIwtrSizeIU/6vDFDz+b4ulEMmF57SRQ1EJqZjuPigR4Csvw9Tp8OAeDHOmQNj4tPSWsYjN7fh+RAbFoKdaA2OM58Md7C1xAUSXjKROaLu4yy3boBiI9cQImDAZSKc7g5M9KL4EIxEdZxk1YlQqV5CWhS6afY1+7XiHV3A=
Received: from BN8PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:d4::38)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 05:53:56 +0000
Received: from BN3PEPF00022BD4.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::a1) by BN8PR04CA0064.outlook.office365.com
 (2603:10b6:408:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 05:53:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD4.mail.protection.outlook.com (10.167.248.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 05:53:55 +0000
Received: from [192.168.1.4] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 00:53:54 -0500
Message-ID: <086e0c4b-66e0-41d5-b84a-3405b4a22e8b@amd.com>
Date: Fri, 23 Oct 2026 11:23:51 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>
Subject: Re: [PATCH v6 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20261022140425.27465-1-sarunkod@amd.com>
 <20261022140425.27465-7-sarunkod@amd.com> <sashiko-outbox-181641@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-181641@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD4:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 68170917-7b9f-4aee-35bc-08df30ca067b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|261021123027099003|261022105027099003|56012099006|261022075727099003|4143699003|5023799004|11063799006|261009223027099003|6133799003|13003099007|10067099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gXWxU85M8PCTr1d4FOpTEmtxDLbnO+qoFZZaAnL0Vo8K89gbemxcsA82XY1WMmYlOJZrj/M9YI0Q/O5sflEwXuQzhR+jdZb3ZI+P9UBUeGHmRvMszKowR+0wFmSLKiLaghpgpOlmLv/58EV/Q21nfWLyx2RxbjGIY1FjZJOcV+UGMgvgn/fwu5b0yLlFchmREl1W2uRBHydONk/Ihs0dzw0aeV1wtX2u1FMVqFSOxHXDv8uHlNxEsNI4xuRm9DGKjXWUCheRUL8mPFuaCWzgj3r/ZACopmPtOoWlmIhaSJBolPKbqX92VlDjIA2xBHs89+K5mBIdDD6B8UMBEy9uz/wFaQmtgh+81n+PlvoJo2JL1RSmeY4mOrbUtIGDijh/IezvzEhWNXQAkch+NiTKwT4QJai1RLpv2khPZjk71TybN0CaPMkAh90dFjqX6un4w8YcyIuCYwGjArJ7xgKN2nBT2xN/EmJgXhGnMzLVMWCVNplaXC4Eq2jXiIWqh9DjBaQv8atf65BPCMJeXEnTC1dI2R4P5RS3N08+P/xh7wca4WwY3I2nnoCW7SmDpQ6hyaaAFXAj8GCs0pkwr8PEZbqrCDno4wC0qhL0CisvFrZmYKgpto2/GMQ9rms9X6PtEZI7+q97/Vb8Yotq8rkGDm63jiTFGzmRKmSkOKpHCS4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(261021123027099003)(261022105027099003)(56012099006)(261022075727099003)(4143699003)(5023799004)(11063799006)(261009223027099003)(6133799003)(13003099007)(10067099003)(261021121427099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ujabbXzuMsMMWhajIMgm9e6zcvZdm2Bw5GvDeqhkiEv1ZS7jL6op2VzDHaTUFMxMmPWNiLGctFdx959FlvN9MpurfTZPfGLnmBtamgYxgehkWAxElGxEu4YBBDu7MEPrxIXkT6+Diev1TRcrzWS8EogXNyzkYrBP6petdxsHqaU0LTVq3IJAxuskKNQwmykYXaVD+God+US3Bgk+6fXy66hT07Cih+ZYKNqW/X5N7A0nJ74YK+IVHQ394hFIs+Jm5Gi35LNnsxPMZ4Ar4BeSD8KwyTiIm9fy8zu92AZ3/8OtYZitC+xqKmU10igAfM8kBk0TKtwIogAcwBGQzS3Mm1BwE4f09XNDjqnviLMq9pYe7/EkDPeC+lRKYyuMXtC7+vLF1WvfXMQ8G9IlcBxVQZkZE2lM4qIhv5+YPiE1fA+oEw4QIMWes9l4gfsjyhBh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 05:53:55.9732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68170917-7b9f-4aee-35bc-08df30ca067b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873



On 10/22/2026 8:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] KVM: SVM: avic_update_iommu_vcpu_affinity() sets IRTE destination to -1
> - [High] KVM: SVM: avic_update_iommu_vcpu_affinity() skips gappi_cpu on activate
> - [High] KVM: SVM: circular lock dependency in __avic_vcpu_load() with GAPPI
> --
> 
> commit eadb6986c75d5c64b26f6497306bb267961e5f78
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt (GAPPI)
> 
> This commit adds KVM SVM support for AMD IOMMU Guest APIC Physical Processor
> Interrupt (GAPPI) as an alternative to the legacy GA log mechanism for waking
> non-running vCPUs when device interrupts are posted to the guest vAPIC
> backing page. When a vCPU blocks, SVM places it on the previous pCPU's posted
> interrupt wakeup list and programs the IOMMU IRTE destination with that
> pCPU's physical APIC ID and POSTED_INTR_WAKEUP_VECTOR.
> 
>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>> index b975f08825ce2..baeca0ad8dfee 100644
>> --- a/arch/x86/kvm/svm/avic.c
>> +++ b/arch/x86/kvm/svm/avic.c
> 
> [ ... ]
> 
>> @@ -1018,7 +1038,7 @@ enum avic_vcpu_action {
>>  };
>>  
>>  static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
>> -					    enum avic_vcpu_action action)
>> +					    int cpu, enum avic_vcpu_action action)
>>  {
>>  	bool wakeup_intr = (action & AVIC_START_BLOCKING);
>>  	bool is_running = apicid >= 0;
>> @@ -1027,6 +1047,25 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
>>  
>>  	lockdep_assert_held(&svm->ir_list_lock);
>>  
>> +	if (action & AVIC_TOGGLE_ON_OFF)
>> +		/*
>> +		 * When AVIC is disabled, IOMMU switches to legacy IRTE and
>> +		 * does not genrate wakeup notification. Hence there is no
>> +		 * need to add vCPU on wakeup list. This reduces the number of
>> +		 * vCPUs on the list, effectively reducing interrupt handler
>> +		 * time and avoiding spurious wakeup to the vCPU.
>> +		 */
>> +		goto skip_wakeup_handler;
> 
> [Severity: High]
> When AVIC is activated on a vCPU via avic_refresh_apicv_exec_ctrl() ->
> __avic_vcpu_load(vcpu, vcpu->cpu, AVIC_ACTIVATE), action is AVIC_ACTIVATE
> (which is aliased to AVIC_TOGGLE_ON_OFF). Won't jumping to
> skip_wakeup_handler here skip updating svm->gappi_cpu = cpu?
> 
> While APICv is inactive or temporarily inhibited (for example at vCPU startup
> before the guest LAPIC is enabled, or due to nested virtualization or IRQ
> window inhibits), svm_vcpu_load() in arch/x86/kvm/svm/svm.c does not call
> avic_vcpu_load() when the vCPU migrates to another pCPU:
> 
> 	if (kvm_vcpu_apicv_active(vcpu))
> 		avic_vcpu_load(vcpu, cpu);
> 
> When APICv is later enabled or uninhibited on the current pCPU,
> avic_refresh_apicv_exec_ctrl() calls __avic_vcpu_load(vcpu, vcpu->cpu,
> AVIC_ACTIVATE). Because AVIC_TOGGLE_ON_OFF jumps over svm->gappi_cpu = cpu,
> svm->gappi_cpu remains at its previous value (or 0 if the vCPU started on a
> non-zero pCPU).
> 
> If the vCPU then blocks via avic_vcpu_blocking() ->
> __avic_vcpu_put(vcpu, AVIC_START_BLOCKING) before another schedule-out and
> schedule-in cycle, or if avic_pi_update_irte() runs while it is not running,
> won't KVM enqueue the vCPU on the wrong pCPU's wakeup_vcpus_on_cpu list and
> program IRTE[Destination] with the stale pCPU's physical APIC ID (which may
> even belong to an offline CPU if the previous pCPU was offlined while APICv
> was inhibited)?

You are right, I think I can rearrange code as follows to resolve this issue,

 	  if (!amd_iommu_gappi)
                  goto skip_wakeup_handler;

          if (action & AVIC_TOGGLE_ON_OFF) {
                  /*
                   * When AVIC is disabled, IOMMU switches to legacy IRTE and
                   * does not genrate wakeup notification. Hence there is no
                   * need to add vCPU on wakeup list. This reduces the number of
                   * vCPUs on the list, effectively reducing interrupt handler
                   * time and avoiding spurious wakeup to the vCPU.
                   */
                  if (is_running)
                          svm->gappi_cpu = cpu;
                  goto skip_wakeup_handler;
          }

          if (is_running) {
                  kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
                  svm->gappi_cpu = cpu;
          } else {
                  apicid = cpu_physical_id(svm->gappi_cpu);
                  kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
          }

  skip_wakeup_handler:

This will record gappi_cpu while activating the AVIC for vCPU.


>> +
>> +	if (amd_iommu_gappi && is_running) {
>> +		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
>> +		svm->gappi_cpu = cpu; /* Store cpu number as target for GAPPI */
>> +	} else if (amd_iommu_gappi && wakeup_intr) {
>> +		apicid = cpu_physical_id(svm->gappi_cpu);
>> +		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
>> +	}
> 
> [Severity: High]
> What happens when a running vCPU with an assigned device is scheduled out
> without blocking (for example, preempted via kvm_sched_out() ->
> kvm_arch_vcpu_put() -> svm_vcpu_put() -> avic_vcpu_put(), or put via
> vcpu_put() on exit to userspace)?
> 
> In that path, avic_vcpu_put() calls __avic_vcpu_put(vcpu, AVIC_STOP_RUNNING),
> which invokes avic_update_iommu_vcpu_affinity(vcpu, -1, -1,
> AVIC_STOP_RUNNING). Both is_running (apicid >= 0) and wakeup_intr
> (action & AVIC_START_BLOCKING) are false, so apicid is not updated to
> cpu_physical_id(svm->gappi_cpu) and remains -1 (unlike avic_pi_update_irte(),
> which sets pi_data.apicid = cpu_physical_id(svm->gappi_cpu) whenever
> !is_running && amd_iommu_gappi).
> 
> avic_update_iommu_vcpu_affinity() then passes apicid = -1 to
> amd_iommu_update_ga(data, -1, false, false), where __amd_iommu_update_ga() in
> drivers/iommu/amd/iommu.c unconditionally writes apicid into
> IRTE[Destination]:
> 
> 	if (amd_iommu_gappi) {
> 		entry->lo.fields_vapic.gappi_dis = !wakeup_intr &&
> 					check_feature2(FEATURE_GAPPIDISSUP);
> 		entry->lo.fields_vapic.is_run = false;
> 		entry->lo.fields_vapic.destination =
> 					APICID_TO_IRTE_DEST_LO(apicid);
> 		entry->hi.fields.destination =
> 					APICID_TO_IRTE_DEST_HI(apicid);
> 	}
> 
> Doesn't this program the live guest-mode IRTE destination fields to
> 0xffffffff (the broadcast APIC ID), causing the IOMMU to deliver broadcast
> POSTED_INTR_WAKEUP_VECTOR interrupts across host CPUs on hardware that
> supports GAPPI without FEATURE_GAPPIDISSUP?
> 

Right, although this will not cause any issue on IOMMU with GAPPIDISSUP feature, 
It will break things for IOMMUs that do not support this feature. I think it is
best to revert back this change.

>> +
>> +skip_wakeup_handler:
>>  	/*
>>  	 * Here, we go through the per-vcpu ir_list to update all existing
>>  	 * interrupt remapping table entry targeting this vcpu.
>> @@ -1093,7 +1132,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
>>  
>>  	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
>>  
>> -	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
>> +	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, cpu, action);
>>  
>>  	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
>>  }
>> @@ -1135,7 +1174,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
>>  	 */
>>  	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
>>  
>> -	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
>> +	avic_update_iommu_vcpu_affinity(vcpu, -1, -1, action);
> 
> [Severity: High]
> Can calling kvm_pi_disable_wakeup_handler() inside
> avic_update_iommu_vcpu_affinity() while holding svm->ir_list_lock in
> __avic_vcpu_load() trigger a circular lock dependency with the scheduler and
> posted-interrupt wakeup locks?
> 
> 1. In the POSTED_INTR_WAKEUP_VECTOR interrupt handler,
>    kvm_pi_wakeup_handler() in arch/x86/kvm/x86.c acquires
>    wakeup_vcpus_on_cpu_lock at subclass 0 and calls kvm_vcpu_wake_up() ->
>    rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), which acquires
>    p->pi_lock and rq->__lock:
> 
>    wakeup_vcpus_on_cpu_lock(0) -> p->pi_lock -> rq->__lock
> 
> 2. When a vCPU is preempted during schedule(), prepare_task_switch() holds
>    rq->__lock and invokes fire_sched_out_preempt_notifiers() ->
>    kvm_sched_out() -> kvm_arch_vcpu_put() -> svm_vcpu_put() ->
>    avic_vcpu_put() -> __avic_vcpu_put(), which acquires svm->ir_list_lock:
> 
>    rq->__lock -> svm->ir_list_lock
> 
> 3. In __avic_vcpu_load() (called from svm_vcpu_load() and
>    avic_vcpu_unblocking()), svm->ir_list_lock is held when
>    avic_update_iommu_vcpu_affinity() calls
>    kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu), which in
>    arch/x86/kvm/x86.c acquires wakeup_vcpus_on_cpu_lock at subclass 0 before
>    PI_LOCK_SCHED_OUT:
> 
>    svm->ir_list_lock -> wakeup_vcpus_on_cpu_lock(0)
> 
> Holding svm->ir_list_lock across kvm_pi_disable_wakeup_handler() bridges
> rq->__lock to wakeup_vcpus_on_cpu_lock(0), defeating the PI_LOCK_SCHED_OUT
> subclass separation and completing the lockdep cycle.
> 
> [ ... ]
> 

This has already been discussed here [1]

[1] https://lore.kernel.org/all/6adaf312-84ff-4fea-b072-61588fd73b40@amd.com/

