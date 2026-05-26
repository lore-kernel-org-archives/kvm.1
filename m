Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E9F1C862F
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 02:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763647; cv=fail; b=qr5r+kJFRxVgtBorfPcXgQRgLPX/1p8vtASjXFAFnRwG2gqG9MBuaNont6X3ROaPe/jAV31L0VnU0fByhSwTgwuUUSSnGonDbZkZ0kafeVXJ1kTiZKNLM1DAEW0dOMfCIRHE3AENccV7iH5N7IKW9rKKP6jAHPKSeecYNsR4iL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763647; c=relaxed/simple;
	bh=qacb1Rmx8YujD2c5kvwCIhNO9XwzD9Tl8dFoBb78Jtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U+5SY/Sr+82LgXOR+aJlb2guWEB5DKtjMvYmzqgjEIbEwx6QeaNmKy9iYVQnpD57L5ReUtfMtT8Sg8slDNRnnpnqEa6YJ1HSC4zEEOJshSpLQedPlYPHrFcyCVPhCpPkqU9Tmd3wzIc4uDiCVXAB80BqOEO0phi2yXePzoQeJPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mUB79gCe; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mUB79gCe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVoZzwxcxjd0CI8k7CNCcqPWV9rH8QELlldockoCGVFRl+vGht/g/Q7Mgilww6ZCkl39AOfTSmFNVcDDWQmly9mrB2JcEjddTzP/rp0dUEoAnp1nNmwhNaR3ihJAmnElOQojYtY7aVqTSLM1fOmpXYmOBI1FRYfwBtqVx99oR63tMCZOAZH9WNvBAekNmcOWQoBpPQL33EjpkrbpZkVy1HLpEgSUmSD4ZGCQWiPTUTvpEsSwVtlpoVJvHiJS3X6NswoGKqecBre7b1K+ml03IoMOyTcZwTZZFxd0JrKqCtq2mvGtv1aEY0BCdwK9VdtPX2+FDIvgaZkJZBRBwYkqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO9GZ17X2wU//jdqZoARj1FmaWnoyBiG720XlBdtytI=;
 b=bGwsX22Vf8Vfmnd7VvSD8WDlYl7oaZlsukg1cdFdTn/iTO7ONGWTbV9qJ8sM4newctlSkfZdC14ccwOGn2Yg1eeL6moE6zR8KvroKykTmIq2Kz2e18ZENAUeS4ZmogFtTb+5fJDj1jPSTtFbZBn+J4BAT19lGfQIh0EKvotxNNJovPkM+C2D2u1kuhnsUM2ahj868/z7exp5HalLHKffOWoVaZJmCms2kqGLHWaSx1lo5ufcp7oSWRf1L2JkyiuKdg+ro8eJw7WRGegOJPmGyHNgPcguOlOoQM2z10ijYQqlqLOTEARePOGqfHxF8Ke4V2h7Qwhbt8kExF89e3tfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO9GZ17X2wU//jdqZoARj1FmaWnoyBiG720XlBdtytI=;
 b=mUB79gCeO/XGoR8CR/xiiOagtYvFwtOkk7L6+yPVFpjGs1b5id4RXgMRtycRqvTdOnBEaa3OGT1+pes+VVu1ZgZthD8sRglF5SadvMUNER/rTnQpr2+uBWe7DHJW9WECsAcWPVP7XJvzqNN7MjMn0ozVbd0pZKrBJqjy5nFJENs=
Received: from SA9PR03CA0015.namprd03.prod.outlook.com (2603:10b6:806:20::20)
 by DS4PR12MB999099.namprd12.prod.outlook.com (2603:10b6:8:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 02:47:21 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::63) by SA9PR03CA0015.outlook.office365.com
 (2603:10b6:806:20::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 02:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 02:47:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 21:47:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 21:47:21 -0500
Received: from [10.136.36.13] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 21:47:19 -0500
Message-ID: <5d2296d0-5a8d-4be1-85ea-5054249db941@amd.com>
Date: Tue, 26 May 2026 08:17:18 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-unit-tests] svm_tests: access rflags and rax via
 this_cpu_guest_regs()
To: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>
References: <20260525120723.8265-1-pbonzini@redhat.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20260525120723.8265-1-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS4PR12MB999099:EE_
X-MS-Office365-Filtering-Correlation-Id: d3da4b84-a2e9-48de-fe9a-08debad11c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	uz5Z0/hUFs7vsV5L2B6Sr+XjgGMyxEt1Ihir+xHwNQDuBO16kocIJVSPpY/4NvayCVVnCCrgzAkx41HLooAaPGHB/ruWWA1BeiylNoC7YP3K+o1jQT6PyWjxaRYmxp71yOPBnRNU5vQctdCusMT8nycHy/WLXBaVIJ/Sh2eHHnqWbqbea6E2IAKtRDU/kDb05wvwK6IVXr9gJx86gdw8V54KO1SXdZaV6/+gZ4TzDeln3MZLqcD2eg+djzySSrVlX9tfzvrzQzAKmvnJPX6GVAEwM2tmzIi/Zb/v/EzA89S5zL8n9LUZNgXNDKfs6f6hSjC1eqWbQV8jv0RHEa0BJoUjz2EoFKNad8c7nvVLTlVV9X02i9Wgb39XA4ylUqSyMg8CdNprj5heg6s9GAYXh9s0HPq4AQqaLQ+pS1czMMxwD+gUPe3R0rAAwxvxZDZhnGIFi9izrucGdeBQp/938iq7+bKmJ4KhVj+4wQmhHrb0xfr+QUeTOT6VDRXjlnLtZoU1DbODAfLsERZlGjcSB9aDDdrri/9NIseLb5gr1T7CTJaTogNFsvf3W9FKw2n03/dx+EWUPqcGFdLYj4zrJs5mUCyQoBtYZ6QjGvKaksNZNPtlciU/xN0Wg1bOK1UE9InaJqlxfP7n/IFRU+JPPdTtabWqE1vnvrYBtd8XLYfkzCwxq8XHuDHrrd6nzafICrsqiGUHyvJH2llBimruZVjBqD61+2ZMoxu52vnOtw0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HLs8EAypyNijadlS4sbrHTwiez2Cs1SAit0snUK16uueaFFHt6rkbvdq1Yc6jJZCP0ReOW3jaCn6AiGM6Hzt2mGCvBnxQ4LGImK9mQnXwuRBwFKO/O/0b8q1+Rj2LsDomI/iRuPtT3qMTzuI5Va/qxvxycfv6I+qdT9x2rgCxM+Y/l4OHgo3OspI3BmLsgCKZviidEkabY5LrafzwLztIiZa8liLeEAlr0YAQNvEv6QBQX+qKnbCgZDHphmyfDpPJ/VWatplQlIMtoldfHL/pQ9/Eyqn8F/2PPL2HXJBw3+y8S31fsTDm4dcP7QfFpnFX09y8zYMpVIUXkkyB9zRvAKRKzksJP+mkzEURrfMk3WZhFLfOWSuVsPgtajGpCjTr5Rwhq1tJzLhUPHZX7DeKs2MkI8zJgSU9ArX/TVVXimdZp8fthFmJ0auHNJiHMt9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 02:47:21.5965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3da4b84-a2e9-48de-fe9a-08debad11c29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999099


On 5/25/2026 5:37 PM, Paolo Bonzini wrote:
> This is needed now that the VMCB save area is properly updated.
>
> Reported-by: Aithal, Srikanth <sraithal@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   x86/svm_tests.c | 31 ++++++++++++++++++++++---------
>   1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/x86/svm_tests.c b/x86/svm_tests.c
> index 8547e729..00552448 100644
> --- a/x86/svm_tests.c
> +++ b/x86/svm_tests.c
> @@ -650,7 +650,7 @@ static bool msr_intercept_finished(struct svm_test *test)
>   	 *      while RAX hold its lower 32 bits.
>   	 */
>   	if (vmcb->control.exit_info_1)
> -		test->scratch = ((regs->rdx << 32) | (vmcb->save.rax & 0xffffffff));
> +		test->scratch = ((regs->rdx << 32) | (regs->rax & 0xffffffff));
>   	else
>   		test->scratch = regs->rcx;
>   
> @@ -1871,9 +1871,11 @@ static bool virq_inject_check(struct svm_test *test)
>   
>   static void virq_inject_within_shadow_prepare(struct svm_test *test)
>   {
> +	struct guest_regs *regs = this_cpu_guest_regs();
> +
>   	virq_inject_prepare(test);
>   	vmcb->control.int_state = SVM_INTERRUPT_SHADOW_MASK;
> -	vmcb->save.rflags |= X86_EFLAGS_IF;
> +	regs->rflags |= X86_EFLAGS_IF;
>   }
>   
>   extern void virq_inject_within_shadow_test(struct svm_test *test);
> @@ -2710,12 +2712,14 @@ asm("guest_rflags_test_guest:\n\t"
>   
>   static void svm_test_singlestep(void)
>   {
> +	struct guest_regs *regs = this_cpu_guest_regs();
> +
>   	handle_exception(DB_VECTOR, guest_rflags_test_db_handler);
>   
>   	/*
>   	 * Trap expected after completion of first guest instruction
>   	 */
> -	vmcb->save.rflags |= X86_EFLAGS_TF;
> +	regs->rflags |= X86_EFLAGS_TF;
>   	report (__svm_vmrun((u64)guest_rflags_test_guest) == SVM_EXIT_VMMCALL &&
>   		guest_rflags_test_trap_rip == (u64)&insn2,
>   		"Test EFLAGS.TF on VMRUN: trap expected  after completion of first guest instruction");
> @@ -2724,7 +2728,7 @@ static void svm_test_singlestep(void)
>   	 */
>   	guest_rflags_test_trap_rip = 0;
>   	vmcb->save.rip += 3;
> -	vmcb->save.rflags |= X86_EFLAGS_TF;
> +	regs->rflags |= X86_EFLAGS_TF;
>   	report (__svm_vmrun(vmcb->save.rip) == SVM_EXIT_VMMCALL &&
>   		guest_rflags_test_trap_rip == 0, "Test EFLAGS.TF on VMRUN: trap not expected");
>   
> @@ -3319,6 +3323,7 @@ static void dummy_nmi_handler(struct ex_regs *regs)
>   
>   static void svm_intr_intercept_mix_run_guest(volatile int *counter, u64 expected_vmexit)
>   {
> +	struct guest_regs *regs = this_cpu_guest_regs();
>   	if (counter)
>   		*counter = 0;
>   
> @@ -3338,7 +3343,7 @@ static void svm_intr_intercept_mix_run_guest(volatile int *counter, u64 expected
>   	report(vmcb->control.exit_code == expected_vmexit,
>   	       "Wanted VM-Exit reason 0x%lx, got 0x%lx",
>   	       expected_vmexit, vmcb->control.exit_code);
> -	report(vmcb->save.rflags & X86_EFLAGS_IF, "Guest should have EFLAGS.IF set now");
> +	report(regs->rflags & X86_EFLAGS_IF, "Guest should have EFLAGS.IF set now");
>   	cli();
>   }
>   
> @@ -3354,12 +3359,14 @@ static void svm_intr_intercept_mix_if_guest(struct svm_test *test)
>   
>   static void svm_intr_intercept_mix_if(void)
>   {
> +	struct guest_regs *regs = this_cpu_guest_regs();
> +
>   	// make a physical interrupt to be pending
>   	handle_irq(0x55, dummy_isr);
>   
>   	vmcb->control.intercept |= (1 << INTERCEPT_INTR);
>   	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
> -	vmcb->save.rflags &= ~X86_EFLAGS_IF;
> +	regs->rflags &= ~X86_EFLAGS_IF;
>   
>   	test_set_guest(svm_intr_intercept_mix_if_guest);
>   	cli();
> @@ -3388,11 +3395,13 @@ static void svm_intr_intercept_mix_gif_guest(struct svm_test *test)
>   
>   static void svm_intr_intercept_mix_gif(void)
>   {
> +	struct guest_regs *regs = this_cpu_guest_regs();
> +
>   	handle_irq(0x55, dummy_isr);
>   
>   	vmcb->control.intercept |= (1 << INTERCEPT_INTR);
>   	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
> -	vmcb->save.rflags &= ~X86_EFLAGS_IF;
> +	regs->rflags &= ~X86_EFLAGS_IF;
>   
>   	test_set_guest(svm_intr_intercept_mix_gif_guest);
>   	cli();
> @@ -3418,11 +3427,13 @@ static void svm_intr_intercept_mix_gif_guest2(struct svm_test *test)
>   
>   static void svm_intr_intercept_mix_gif2(void)
>   {
> +	struct guest_regs *regs = this_cpu_guest_regs();
> +
>   	handle_irq(0x55, dummy_isr);
>   
>   	vmcb->control.intercept |= (1 << INTERCEPT_INTR);
>   	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
> -	vmcb->save.rflags |= X86_EFLAGS_IF;
> +	regs->rflags |= X86_EFLAGS_IF;
>   
>   	test_set_guest(svm_intr_intercept_mix_gif_guest2);
>   	svm_intr_intercept_mix_run_guest(&dummy_isr_recevied, SVM_EXIT_INTR);
> @@ -3447,11 +3458,13 @@ static void svm_intr_intercept_mix_nmi_guest(struct svm_test *test)
>   
>   static void svm_intr_intercept_mix_nmi(void)
>   {
> +	struct guest_regs *regs = this_cpu_guest_regs();
> +
>   	handle_exception(2, dummy_nmi_handler);
>   
>   	vmcb->control.intercept |= (1 << INTERCEPT_NMI);
>   	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
> -	vmcb->save.rflags |= X86_EFLAGS_IF;
> +	regs->rflags |= X86_EFLAGS_IF;
>   
>   	test_set_guest(svm_intr_intercept_mix_nmi_guest);
>   	svm_intr_intercept_mix_run_guest(&nmi_recevied, SVM_EXIT_NMI);


Thank you, this fixes the issue.

Tested-by: Srikanth Aithal <sraithal@amd.com>


