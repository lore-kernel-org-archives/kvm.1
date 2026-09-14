Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12ED481256
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405997; cv=none; b=uN4afDz92BxFYU8l9LiKXVvUXwe0iysbfYKe5JkB2T4sAC0/u9ArwIBcvyJ5tOY989P5dwGFVY8h4mcyumW4wAV73DOAjMZ2j4nnwYocjswT2myy2aWgzcw3J9tVQUsw7yzqLFjoJ0tabTx0CiTbe5SbKd1K88IWWKlW/08TtWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405997; c=relaxed/simple;
	bh=PO/TAgjSz60/wq3uc4eCjqprL6ZUR5xOTIzaFPJo3kk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qn+8OaDqJys7tbVUkFf6YBtJj+Otgt2W0+h03fm4MAiq+0nPcQToOMdHaI++XHVG0tw9CnyOWYiLWwnxZFwT0CBXfSxKAikcpHwCHIILwql+Zy6qqyxNUNPFzvn0CW4HN+7wNf9DtBu6wUEFi9moyBcbjjA1kZLu6XPsfOhjonc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEYmBf05; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEYmBf05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BC41F000FF;
	Mon, 14 Sep 2026 17:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789405996;
	bh=1YBrXDTRUp7lWVBOmr3gnu6g6nLlSB/AQx4bDtI0TDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PEYmBf05sYl2pu51BX9AOpLQu6v7avrVa6psQuOU1JPPtfW9kU9lLepMfZDwqUFFG
	 3zMhu/GevbhQ9Ps9uDXVMx+m3LLiLzlQdyh6JF2NNnuX58fSx/Ljyp4z0yP9rLZ2IS
	 uAguccyi9FkDOEBgbUhVZRf/fwAw6+RPydveGNe8+uWZN6iU5AjoXJreWD1iQeYhqA
	 tqrWzRFhFFDqvacNZpXQVCuTKKmzP6OSC9r4B7TFSZIr4s9tBBTvXo0Z78D52TJAKK
	 H4i6euk/KUvEUhUXnGX3+WBjfBuQAqVSRvWwaeR8iYa+WKQIhKLzV3WzDoMNySuGv9
	 zQh7+WaiCgX5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] KVM: SVM: Add host support for Enhanced SMT
 Protection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <df22a9879871f5f926ff74b203e06b58ed505503.1789399214.git.prsampat@amd.com>
References: <cover.1789399214.git.prsampat@amd.com>
 <df22a9879871f5f926ff74b203e06b58ed505503.1789399214.git.prsampat@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:13:15 +0000
Message-Id: <20260914171316.43BC41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] MSR_AMD64_IDLE_WAKEUP_ICR is only programmed for online CPUs durin=
g module load without CPU hotplug locks, breaking ESMTP on hotplugged CPUs.
- [High] Immediate retry on ESMTP_ILLSIB and ESMTP_TIMEOUT exits with cond_=
resched() causes a kernel livelock and violates SRCU locking invariants.
- [Medium] Missing teardown of MSR_AMD64_IDLE_WAKEUP_ICR on KVM module unlo=
ad leads to permanent spurious IPIs.
--

commit 6679aa4cd87f7de484f6cabf547ea6d6220bfceb
Author: Pratik R. Sampat <prsampat@amd.com>

KVM: SVM: Add host support for Enhanced SMT Protection

This commit introduces support for Enhanced SMT Protection (ESMTP) to prote=
ct
SEV-SNP guests from SMT side channels. It adds logic to program the host's
wakeup IPIs and handles three new non-fatal VMRUN exits (ESMTP_ILLSIB,
ESMTP_TIMEOUT, ESMTP_RETRY) by yielding the CPU.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 944aaea6501f2..9bafb671a8b7f 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -3045,6 +3059,30 @@ static const char * __init sev_str_feature_state(b=
ool is_supported, bool is_usable)
>  	return is_supported ? is_usable ? "enabled" : "unusable" : "disabled";
>  }
> =20
> +static bool sev_esmtp_setup_wakeup_icr(void)
> +{
> +	unsigned int cpu, sibling;
> +	bool wrmsr_success =3D true;
> +
> +	for_each_online_cpu(cpu) {
> +		for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {

[Severity: High]
Could this break ESMTP on hotplugged CPUs?

This loop only touches currently online CPUs during module load and does so
without holding cpus_read_lock(). Because this is a one-time invocation
during module init, any CPU brought online after the KVM module is loaded
will lack the required MSR programming.

Hardware will then fail to wake the sibling upon CC6 idle, causing VMRUN
to indefinitely stall and trigger ESMTP_TIMEOUT exits on those hotplugged
CPUs.

> +			u64 icr;
> +			int ret;
> +
> +			if (sibling =3D=3D cpu)
> +				continue;
> +
> +			icr =3D (u64)per_cpu(x86_cpu_to_apicid, sibling) << 32;
> +			icr |=3D LOCAL_TIMER_VECTOR & 0xff;
> +			ret =3D wrmsrq_safe_on_cpu(cpu, MSR_AMD64_IDLE_WAKEUP_ICR, icr);
> +			if (ret)
> +				wrmsr_success =3D false;
> +		}
> +	}
> +
> +	return wrmsr_success;
> +}
> +
>  void __init sev_hardware_setup(void)
>  {
>  	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
[ ... ]
> @@ -3221,6 +3259,10 @@ void __init sev_hardware_setup(void)
> =20
>  	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_S=
ECURE_TSC))
>  		sev_supported_vmsa_features |=3D SVM_SEV_FEAT_SECURE_TSC;
> +
> +	if (sev_snp_enabled && cpu_feature_enabled(X86_FEATURE_AMD_ESMTP) &&
> +	    sev_esmtp_setup_wakeup_icr())
> +		sev_supported_vmsa_features |=3D SVM_SEV_FEAT_ESMTP;

[Severity: Medium]
Will this lead to permanent spurious IPIs when the KVM module is unloaded?

MSR_AMD64_IDLE_WAKEUP_ICR is programmed globally on all online CPUs to send=
 a
local timer IPI when a CPU enters CC6 idle. However, I don't see a teardown
path (like in sev_hardware_unsetup) restoring this MSR to zero.=20

After the KVM module is unloaded, the CPUs will permanently continue sending
spurious local timer IPIs to their siblings upon idling, which could cause
host power regressions and prevent deep sleep.

>  }
> =20
>  void sev_hardware_unsetup(void)
[ ... ]
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e2be2cd86c320..0b128f7911348 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -3732,6 +3732,13 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, =
fastpath_t exit_fastpath)
>  		return 0;
>  	}
> =20
> +	if (svm->vmcb->control.exit_code =3D=3D SVM_EXIT_ESMTP_RETRY ||
> +	    svm->vmcb->control.exit_code =3D=3D SVM_EXIT_ESMTP_ILLSIB ||
> +	    svm->vmcb->control.exit_code =3D=3D SVM_EXIT_ESMTP_TIMEOUT) {
> +		cond_resched();
> +		return 1;
> +	}

[Severity: High]
Does this immediate retry create a kernel livelock and violate SRCU invaria=
nts?

If the runqueue has no other tasks (TIF_NEED_RESCHED is false), cond_resche=
d()
does nothing. The vCPU immediately attempts VMRUN again, hits the exact same
hardware conflict, and exits again. This creates a tight spin loop that can
peg the host CPU at 100% utilization.

Additionally, if a task is pending, cond_resched() yields the CPU while
holding KVM's SRCU read lock, because svm_handle_exit() is invoked within
the vcpu_enter_guest() SRCU critical section. This would stall
synchronize_srcu() indefinitely and bypass KVM's safe
xfer_to_guest_mode_handle_work() protocol.

> +
>  	if (exit_fastpath !=3D EXIT_FASTPATH_NONE)
>  		return 1;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789399214.gi=
t.prsampat@amd.com?part=3D2
