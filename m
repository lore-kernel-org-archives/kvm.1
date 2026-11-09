Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258776;
	b=5EPzwNicZxQSMMhDbaqtib0ZRlMNyPkEOY+BIsvh6NhEylRNSUMG59Ga1XSOUwXt0oGY
	 9OX7bhTkbyeJX3xvJNuli/Cn7339c7FYxRSorZKUsJoW37kKTD6S54YUlVzYfqm9a+fK5
	 ZNbcZxwKcLLEBz62eoGtE0oe85gyzX9cw5ITTsrSxgVwLCzLg8faWHqWaK3Td3FOBclzS
	 EUTTP8F7keBMP6gmQlfViTtnNgtG2VQMzz86gCBy5YGpmZamUbRJzZf3Skt/JtZA2ffwu
	 pV9W3yzRmg+OR0rsX8G+hlV7PM0m4USkZgjDOqwHHR1tMG0W+DbCjWB0oKkJBr5BMTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258776;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JHrppgA7c5vnhADYpuHpchb5s70MCJWWwpUTs4/LSoQ=;
	b=SzCXcadpKgBK1i3eqm3/N3QCCSqGI8G4He+mDdYGd+iv+5+hi8Z4nrH9XnJThCx7kFsn
	 U7zdLQvhAvbbGEMaXeOxLZeNAX/ucPJJ1O2g0b95B5tcB3qNuKjEDZY68waaTqMXKj0su
	 exBwuDZMA59OOuTvRiUOtMglr/yY/93rkUo1C9ReNCA7xitxS4am0EOvpe9AcTwj8DSUW
	 eusIn5OjeM4uQDvX4GIkbFJxvjeSD5+1bQuXfFEXecfJtjL+ejTzUhjnsoAQTNc2fNhek
	 l+rYpNFl/43EcfRHWXR8JC6Yf0ESFWjND4eSF1a0T9eLJLanQ9ujy+4y+FCYircf0tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8UQ4AtF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA785606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8UQ4AtF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A47A1F008A1;
	Mon,  9 Nov 2026 21:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258775;
	bh=JHrppgA7c5vnhADYpuHpchb5s70MCJWWwpUTs4/LSoQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=n8UQ4AtFDAkKm2lWmVjghpahsdgb90k5x1CItBk7IoG46rEAMoksrHd0CKAxc/DNo
	 ktuchLl6jWPcsCFTAOxWDQINZYGDsszJRVPdX+vKHP2wJGwJbvkuCCWQOG4wX1gWuA
	 v3wqySdHSln71HxBPUg4MtX+PgsX2Ej2DqAMyECWhfMIn1c9XJRA/9Z0fx4cTNG4RL
	 EJUE3cJyqQVvs25/gZCFBsWoQyBC8Jnz1vcKR93YDrGSVhLPrv6Ssxk09XF9ISskp2
	 helneBt1Rn7vYnLEJPScr5sX2aMALpxpfAbGEM3xGJl26l7q7faH/sHn+7Xzwn8EMT
	 bClDtjIFuOL/Q==
Message-ID: <sashiko-outbox-205643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 2/4] KVM: SVM: Add host support for Enhanced SMT
 Protection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratik R. Sampat" <prsampat@amd.com>, kvm@vger.kernel.org
In-Reply-To: <ea20a52f49c15a4b59fc64f7791c9834e52d757f.1794244450.git.prsampat@amd.com>
References: <cover.1794244450.git.prsampat@amd.com>
 <ea20a52f49c15a4b59fc64f7791c9834e52d757f.1794244450.git.prsampat@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:12:54 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] KVM: SVM: spurious LAPIC timer interrupts from
  sev_esmtp_enable_wakeup_icr()
- [Low] KVM: SVM: 32-bit truncation breaks SVM_EXIT_ESMTP_* in
  trace_kvm_exit()
--

commit 3f8afd82427b162ada6d9e482a251e8b54f02146
Author: Pratik R. Sampat <prsampat@amd.com>

KVM: SVM: Add host support for Enhanced SMT Protection

This commit adds KVM host support for AMD Enhanced SMT Protection (ESMTP)
for SEV-SNP guests, including feature detection, VMSA and VMCB setup, idle
wakeup ICR configuration, and handling of the new ESMTP VMEXITs.

> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/=
svm.h
> index e806761850921..141386d680a04 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -136,6 +136,10 @@
>  #define SVM_EXIT_SW				0xf0000000ull
> =20
>  #define SVM_EXIT_ERR           -1ull
> +/* Enhanced SMT Protection VM exits taken during VMRUN sibling sync */
> +#define SVM_EXIT_ESMTP_ILLSIB  -5ull	/* Illegal ESMTP sibling */
> +#define SVM_EXIT_ESMTP_TIMEOUT -6ull	/* ESMTP_TIMEOUT expired */
> +#define SVM_EXIT_ESMTP_RETRY   -7ull	/* Internal event; retry VMRUN */
> =20
>  #define SVM_EXIT_REASONS \
>  	{ SVM_EXIT_READ_CR0,    "read_cr0" }, \
> @@ -248,7 +252,10 @@
>  	{ SVM_VMGEXIT_EXT_GUEST_REQUEST, "vmgexit_ext_guest_request" }, \
>  	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
>  	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
> -	{ SVM_EXIT_ERR,         "invalid_guest_state" }
> +	{ SVM_EXIT_ERR,         "invalid_guest_state" }, \
> +	{ SVM_EXIT_ESMTP_ILLSIB,	"esmtp_illsib" }, \
> +	{ SVM_EXIT_ESMTP_TIMEOUT,	"esmtp_timeout" }, \
> +	{ SVM_EXIT_ESMTP_RETRY,		"esmtp_retry" }

[Severity: Low]
Will trace_kvm_exit() ever match these 64-bit SVM_EXIT_ESMTP_* values in
SVM_EXIT_REASONS?

svm_get_exit_info() truncates the 64-bit control->exit_code into a u32
*reason, and TRACE_EVENT_KVM_EXIT stores exit_reason as an unsigned int.
When kvm_print_exit_reason() passes that 32-bit field to
__print_symbolic_u64(exit_reason, SVM_EXIT_REASONS), it zero-extends to
0x00000000fffffffbULL instead of matching -5ull (0xfffffffffffffffbULL),
so ftrace prints raw hex values instead of the symbolic names.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index fad72cab76cf4..4748be617134f 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -3312,6 +3329,31 @@ int sev_cpu_init(struct svm_cpu_data *sd)
>  	return 0;
>  }
> =20
> +void sev_esmtp_enable_wakeup_icr(void)
> +{
> +	unsigned int cpu, sibling, shift;
> +	u32 core;
> +
> +	if (!(sev_supported_vmsa_features & SVM_SEV_FEAT_ESMTP))
> +		return;
> +
> +	cpu =3D raw_smp_processor_id();
> +	shift =3D topology_get_domain_shift(TOPO_CORE_DOMAIN);
> +	core =3D per_cpu(x86_cpu_to_apicid, cpu) >> shift;
> +
> +	for_each_present_cpu(sibling) {
> +		u32 apicid =3D per_cpu(x86_cpu_to_apicid, sibling);
> +		u64 icr;
> +
> +		if (sibling =3D=3D cpu || (apicid >> shift) !=3D core)
> +			continue;
> +
> +		icr =3D (u64)apicid << 32;
> +		icr |=3D LOCAL_TIMER_VECTOR;
> +		WARN_ON_ONCE(wrmsrq_safe(MSR_AMD64_IDLE_WAKEUP_ICR, icr));
> +	}
> +}

[Severity: Medium]
Does programming MSR_AMD64_IDLE_WAKEUP_ICR with LOCAL_TIMER_VECTOR inject
spurious local APIC timer interrupts on the sibling CPU whenever this
thread wakes from idle while the sibling is running an ESMTP vCPU?

When the sibling exits guest mode and enables interrupts,
LOCAL_TIMER_VECTOR runs sysvec_apic_timer_interrupt() ->
local_apic_timer_interrupt(), which unconditionally increments APIC_TIMER
IRQ stats and calls evt->event_handler(evt).  When high-resolution timers
are disabled, tick_handle_periodic() and tick_nohz_lowres_handler() do not
check whether dev->next_event has been reached, so every ESMTP wakeup IPI
prematurely advances jiffies and charges a full tick of CPU time via
update_process_times().

Using RESCHEDULE_VECTOR (which KVM already uses to kick CPUs out of guest
mode) would avoid invoking the clockevent handler.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794244450.gi=
t.prsampat@amd.com?part=3D2
