Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907904C6EE6
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343236; cv=none; b=Fd8sdZbH3hcGkFXoMjKvoQrbJ82I1xIx2c5eCWv4y99rqfflB9N1RrmdT/mpHYNIbLQEhwn10b2/NlzH68+NtsayYga1d/SuBnJoCJubQErtFjdQwbS+wPZbV8D8l7rjtSdxXkatZsQXi6JuN/Oueqg6aFMFxvQpDbDAtKWcd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343236; c=relaxed/simple;
	bh=P1CBFuFn5URk4XkWKPaomxNCNRYuE86ueT9NGJQmOPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXZAbjNmWOyrgT1O0LfKiS+Fo8s6LM2G9T/Nn6vVf4NVxmmE9jwMNZYCjx2IIyhjW/OKrtfowTI/MUJzup+irFFQIHI5pCRio7ZMmtNyP2LtBVqcGUrzci4JaCMTUsXsNec+MOYTKCg4E9PT0t/toZuvLYw9IV+g+WZOi4nKLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XaMm7rjV; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XaMm7rjV"
X-Forwarded-Encrypted: i=1; AHgh+RqHNBVY4Uc/O9+/7fY47Pa8i6XNSq5456BG0gnXAXu0+aIn0X2sp7VQsilj9OAENLFeMFg=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785343229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hTKtf9y0sAvMzfV5x7XnlOJ9LjJuEUBlqCkfsXA/OVA=;
	b=XaMm7rjVahJ18DKqLrBqetibqJVEQoCbrOtAVxkjvBaaqSGsQW0HBp8WlikQS8pBdvZqlU
	88hdnCut+0pTeYUMWPtd/8UfeV6hHnhY5nVdoVmDD6RZLlisMQCuq8PFjR4DPm3Q+YuPgs
	juTWWp2bMN7OAdiry/5v9FsO4GcCPeY=
X-Gm-Message-State: AOJu0YzJizImiLpcVBsz9CGaYzXF8gBcENEPbn8akAbVpc7RQQ6VSqOC
	5KLzC9SwoGEUjPfcF5Rb//tJWmeFkgEPqhMOKiiTk1tIYwpwEpvUJ6gbVP3aJEweVPBWGem3RGh
	uGVjPblZw0xvNC2K6lFKK2Me78x9uW5E/0Bn7AOWc
X-Received: by 2002:a05:622a:c4:b0:517:5ac7:332e with SMTP id
 d75a77b69052e-52b34fbe0femr1827251cf.6.1785343198660; Wed, 29 Jul 2026
 09:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720-hybrid-v9-11-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260720-hybrid-v9-11-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 29 Jul 2026 17:39:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyY3PnJLHBVWCx1Mjy09a+AztByawZxcSSVtBUfzObC_A@mail.gmail.com>
X-Gm-Features: AUfX_myAfVdxJqe8mBkarWtUgPMModQPrWR0zonAtg_LmKu_beXtJUxWvL2MWRA
Message-ID: <CA+EHjTyY3PnJLHBVWCx1Mjy09a+AztByawZxcSSVtBUfzObC_A@mail.gmail.com>
Subject: Re: [PATCH v9 11/16] KVM: arm64: PMU: Protect the list of PMUs with RCU
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Eiden <seiden@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Mon, 20 Jul 2026 at 06:39, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Convert the list of PMUs to a RCU-protected list that has primitives to
> avoid read-side contention.
>
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  arch/arm64/kvm/pmu-emul.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index 9ac5f307ea31..c5c505b6fc61 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -7,9 +7,9 @@
>  #include <linux/cpu.h>
>  #include <linux/kvm.h>
>  #include <linux/kvm_host.h>
> -#include <linux/list.h>
>  #include <linux/perf_event.h>
>  #include <linux/perf/arm_pmu.h>
> +#include <linux/rculist.h>
>  #include <linux/uaccess.h>
>  #include <asm/kvm_emulate.h>
>  #include <kvm/arm_pmu.h>
> @@ -20,6 +20,10 @@
>  #define MDCR_EL2_PMU_RECREATE_MASK     (MDCR_EL2_HPMN | MDCR_EL2_HPMD | \
>                                          MDCR_EL2_HLP)
>
> +/*
> + * arm_pmus is append-only. kvm_supports_guest_pmuv3() feeds persistent
> + * VM state, so a true result must remain valid after the check.
> + */
>  static LIST_HEAD(arm_pmus);
>  static DEFINE_MUTEX(arm_pmus_lock);
>
> @@ -29,7 +33,6 @@ static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc);
>
>  bool kvm_supports_guest_pmuv3(void)
>  {
> -       guard(mutex)(&arm_pmus_lock);
>         return !list_empty(&arm_pmus);
>  }
>
> @@ -807,7 +810,7 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
>                 return;
>
>         entry->arm_pmu = pmu;
> -       list_add_tail(&entry->entry, &arm_pmus);
> +       list_add_tail_rcu(&entry->entry, &arm_pmus);
>  }
>
>  static struct arm_pmu *kvm_pmu_probe_armpmu(void)
> @@ -816,7 +819,7 @@ static struct arm_pmu *kvm_pmu_probe_armpmu(void)
>         struct arm_pmu *pmu;
>         int cpu;
>
> -       guard(mutex)(&arm_pmus_lock);
> +       guard(rcu)();
>
>         /*
>          * It is safe to use a stale cpu to iterate the list of PMUs so long as
> @@ -836,7 +839,7 @@ static struct arm_pmu *kvm_pmu_probe_armpmu(void)
>          * carried here.
>          */
>         cpu = raw_smp_processor_id();
> -       list_for_each_entry(entry, &arm_pmus, entry) {
> +       list_for_each_entry_rcu(entry, &arm_pmus, entry) {
>                 pmu = entry->arm_pmu;
>
>                 if (cpumask_test_cpu(cpu, &pmu->supported_cpus))
> @@ -1088,9 +1091,9 @@ static int kvm_arm_pmu_v3_set_pmu(struct kvm_vcpu *vcpu, int pmu_id)
>         int ret = -ENXIO;
>
>         lockdep_assert_held(&kvm->arch.config_lock);
> -       mutex_lock(&arm_pmus_lock);
> +       guard(rcu)();
>
> -       list_for_each_entry(entry, &arm_pmus, entry) {
> +       list_for_each_entry_rcu(entry, &arm_pmus, entry) {
>                 arm_pmu = entry->arm_pmu;
>                 if (arm_pmu->pmu.type == pmu_id) {
>                         if (kvm_vm_has_ran_once(kvm) ||
> @@ -1106,7 +1109,6 @@ static int kvm_arm_pmu_v3_set_pmu(struct kvm_vcpu *vcpu, int pmu_id)
>                 }
>         }
>
> -       mutex_unlock(&arm_pmus_lock);
>         return ret;
>  }
>
>
> --
> 2.55.0
>
>
