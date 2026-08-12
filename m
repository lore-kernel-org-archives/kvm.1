Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2754947D927
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555591; cv=pass; b=VGbb6CrbvQ+qA93j7XIG4I5cmSVrxVopuAehy9ndOM+5BXPgDHyJ/RoxbG1ltmH/NkggGZeUNMxIxAEwbWtWd7GOdDq113770QjI+OLLkperyES7lC+bambYYeobUKpU+xSwZ5zFdquCSwTpvWfXrT/fqJzY5DV2L5NYcZKi3Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555591; c=relaxed/simple;
	bh=ta2r+MXrofiKskIPBz8zMDvkxB3jNjdiEPLMmGX+1zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uzilet73gp+CEhChUViszlWWC0P4/8PSneIQOPyaEgVci03QBfgFZJ8nrCF572g0KELTPQZu6mZ/mglN30KZZ1+ehqCdDzFvWIlDWCXbxTgnx//1rK3fWddetcSAyJ6iQJRHHHnY7bro5kTGt6PaHed5Ar3ch6seN3Iy4D0RAbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=aA07fkBC; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="aA07fkBC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49558ce01afso9822375e9.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 10:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786555586; cv=none;
        d=google.com; s=arc-20260327;
        b=lKRyHCEqR6mblvwu0A5SKr1TkPihnOu4QO4x8wwVHnz6G0qE6Mmxwb4KiR98jWY/hD
         tSImMRMI1rSl6OJ5MLTwr0Q7jZ4jZ71Q9+lwu1pCs7ZpgI7dTC1j5vCniezlBlAtuWzm
         jVnquVWsgKY6UDlnWaPHF9t2UR+vI8Xx5/6XsZiwIRy1lkdvuxt6T5Xv3W5yFV+qqCEo
         wD+mbhX4l+dkGneEkqBrL3jf33QiFGEy3XK9IiPZuc8FMI8YWiUeBx9nshUF/bxPqfwN
         c2NcfcTGaTqzOUtOla63R05CqaHEBUZjZj5WQ6iGqrumzJvU6FzWt9cTs7DZvdDwpPPV
         rWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dA6y6PhGE/45uAcglqNuchK/GS3YEtQSFjGCxv/WTsQ=;
        fh=MbcLnMniTsC08zKS/ELw2L75KFPPcNz4OSib9pCGrVc=;
        b=kpb/vB3om8XxYysnUEjMgyOhG8XhgqgivpAHtpRQ+YHwj5I0+1m+dm956baH2froyR
         Z1KDjjHyLnRAcwDcWhSXJ0uKsnHwsbg1Y7L7p+kzYEuxKJN0nOnThvTAswQAwaA8SlB3
         8wL95nJTmPu97+HjicNjfm0pGRK8R9xOfIQMt8PQEURcsrNFiGtXzMCpHm8hydO0TSAi
         JggIkhJyeWVr5gHVV96D5SiW+zLHJ8j2RCI708bf+wclJMQIRNmqd1m5FM2JtbD4VupU
         bbcwD5eYOGlqOFN2BY26pEMQdX5JXYu4Xq5W8xiMW7jpAKQpohcigVZBYy6H4gQOHh7d
         aOAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786555586; x=1787160386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dA6y6PhGE/45uAcglqNuchK/GS3YEtQSFjGCxv/WTsQ=;
        b=aA07fkBCdLY1QhnKT2SxEA6QJa4QCITbLh57ciSCQlDfab75KWOlQgERdymg4gykHM
         j4ml1wq2EfBQ4YZR38L5kFFT8kD3dYkqkYzXx7m3meLdsYis6RNQkkqRMLMFwrcN36oM
         ts9eGSMgK3AWioDsFoVl389Jw8OfJRBA630Shhvob/8NmPc4ZKcMsatWJAj8/RGgVN1r
         zxwA+g6OHT0DixwTCd2Kv/F9TKaUB3MVulM6bM56Y994/su8VTvmP+HixmlIh9au2O7t
         LjUT+ldpzp5n6UexocVUWRFUx3jVSVaUNlpJ/pqBxpi/P1MPR8ZOEOdvWbWxBWcHeccJ
         v4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786555586; x=1787160386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dA6y6PhGE/45uAcglqNuchK/GS3YEtQSFjGCxv/WTsQ=;
        b=KVTHpM/0/SkI0gOA304rTzxiXDru7biM/cipwahPEHN8nH2M9AnTdvILWf7GWDtnlP
         wbFs3UINVNDljAMPuW4dDvvMKdRPPnwJQUCnAjKaxu9SJhFpJFLK+sD0YP6KXHuCJktG
         Nmwy0Fndu4vzdaHmDXbanXtNqEtBCNI80suhe4pt9gKEDDJGS2nSnJ8q2Oa857b0gpPl
         mR9VCeRF9fYh82eSrv/Ic+cdW5/F2fR5P644mIHIqrazMVmbW840va/Na5S4vsSB4931
         c7MBL2bH3B/12Fjd2TiCBS8ax1u6eTbI2SeNf0g3jURaMsHZ0zYsoJ2+iC31MmsXIh1Q
         fsmw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9K+99PO63InDJG8IncTxge+KMjsd5IWTfqtb1X04PGUBsS0UP3fha87KvZBJCbgzIzJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bMzznQ6no6rhU7cwjerjAvooPr1WwViXtbtykSDpZjGlxzoh
	O0gRi4FzyIb5Ov6H0CNASC2YQopjHtLG8etelREucOYZJHbNwUdj4MmSp9rkdW3mt0YMvNSpLM4
	ox3BGuHx3YdK19LMANXYboQO8Gzvcuc/uL97HwNpD7g==
X-Gm-Gg: AR+sD10bia//3rfHYW9BQP0IMYsiBj3fuPUnjbXOVrcS4Z1sn6VZeFq44kOPHHxYvX6
	eMfzooZzIK01+yqWL8DBI45l0Ad+B9dvlV7Je+8M7hi/XwTIjRakOcxM26fQmoCrokbta6R93v7
	18pOKAzvxwlTqxTFGSpVFrPcxhyFyj2aPWOL5H1J67u+XlRg7aEa9aHBIYJRNiD6IwU5lMzZPwZ
	U0QjZSO2tKgJrLFAv3ETd8IcSkpcEvrcyeUVLMRBGrbxy1H0geQWgKpR86WNjgv0MPRvWvTqUmz
	C2tExL5LOGiGwNtKQ4EIPmJI8yU5K+CIgByHG4vzQpBIV7GW6r4b6EqGdDAG+m1wNePtu1tyP5n
	x8KRw1OrikXbQr3VLfewQnbysuwkhnFXwhs0urneUZK2ASpDxYr6lUXzKaqAmGbOE
X-Received: by 2002:a05:600c:3b19:b0:493:e983:806e with SMTP id
 5b1f17b1804b1-4997c0f7575mr91001305e9.3.1786555586180; Wed, 12 Aug 2026
 10:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722073344.771230-1-jinrui@haiwei.tech> <034CA48A67574B32+20260811085036.2862645-1-jinrui@haiwei.tech>
In-Reply-To: <034CA48A67574B32+20260811085036.2862645-1-jinrui@haiwei.tech>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 12 Aug 2026 22:56:14 +0530
X-Gm-Features: AUfX_mxTb8kd-0mF-_iQMqEbcxOgkLvwD2fPyWg4u1ceODY3a_3MOM_LK6jBndc
Message-ID: <CAAhSdy0K5H23AC9X_OA-cj6wppcw7fWPEHQZFzkTR+Rjnv6jBw@mail.gmail.com>
Subject: Re: [PATCH v9] KVM: selftests: riscv: Add lazy V extension enablement
 for guests
To: JinRui <jinrui@haiwei.tech>
Cc: pbonzini@redhat.com, shuah@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	alex@ghiti.fr, sashiko-bot@kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:21=E2=80=AFPM JinRui <jinrui@haiwei.tech> wrote:
>
> From: jinrui <jinrui@haiwei.tech>
>
> When the cross-compiler defaults to an -march that includes the V
> (vector) extension, -O2 auto-vectorization generates vector
> instructions (e.g. vsetvli, vadd.vv) in Guest binary code. If the
> Guest executes a vector instruction while sstatus.VS is Off, an
> EXC_INST_ILLEGAL (scause=3D2) is raised. KVM's hedeleg delegates this
> exception to the Guest, but the selftest has no way to handle it as a
> bare-metal program, causing all Guest tests to fail.
>
> In contrast, a real OS kernel handles this via riscv_v_first_use_handler(=
),
> which detects the vector instruction, sets sstatus.VS to Initial, and
> srets to re-execute.
>
> Fix this with four changes in processor.c:
>
> 1. Delete the now-unused guest_unexp_trap() handler, which is replaced
>    by the full exception vector table.
>
> 2. In vm_arch_vcpu_add(), notify KVM that the Guest is allowed to use
>    the V extension via __vcpu_set_reg(V, 1) (best-effort, silently
>    ignores errors on hardware without V). Also replace the raw stvec
>    handler with the full exception vector table, which provides
>    save_context/restore_context for safe lazy enablement.
>
> 3. In route_exception(), add a lazy V enablement check that runs
>    before any test-registered handler. When the cause is a non-IRQ
>    EXC_INST_ILLEGAL and sstatus.VS is Off, set VS to Initial and
>    return so the faulting instruction is re-executed via sret.
>    Track the epc per-vCPU via a flexible array member to avoid
>    infinite loops on hardware without V and eliminate races between
>    concurrent vCPUs.
>
> 4. Make vm_init_vector_tables() idempotent by checking vm->handlers
>    before allocation, so tests that manually call it (ebreak_test,
>    arch_timer, sbi_pmu_test) do not leak memory.
>
> The check runs before test-registered EXC_INST_ILLEGAL handlers
> (e.g. sbi_pmu_test) to ensure V enablement takes priority.
>
> Tested on a riscv64 host with KVM enabled: all 20 KVM selftest
> binaries pass (arch_timer, ebreak_test, steal_time, get-reg-list,
> sbi_pmu_test, etc.).
>
> Signed-off-by: jinrui <jinrui@haiwei.tech>
> ---
> Changes in v9:
> - Size the per-vCPU epc array by KVM_CAP_MAX_VCPU_ID instead of
>   KVM_CAP_MAX_VCPUS, since vcpu_id may be sparse and exceed the vCPU
>   count (found by sashiko-bot review).
>
>  .../selftests/kvm/lib/riscv/processor.c       | 115 +++++++++++++++---
>  1 file changed, 100 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f3..05e20ef40 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -17,6 +17,13 @@
>
>  static gva_t exception_handlers;
>
> +struct handlers {
> +       exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS=
];
> +       bool v_available;
> +       unsigned int v_epc_capacity;
> +       unsigned long v_epc[];
> +};
> +
>  bool __vcpu_has_ext(struct kvm_vcpu *vcpu, u64 ext)
>  {
>         unsigned long value =3D 0;
> @@ -298,13 +305,6 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *v=
cpu, u8 indent)
>                 core.regs.t3, core.regs.t4, core.regs.t5, core.regs.t6);
>  }
>
> -static void __aligned(16) guest_unexp_trap(void)
> -{
> -       sbi_ecall(KVM_RISCV_SELFTESTS_SBI_EXT,
> -                 KVM_RISCV_SELFTESTS_SBI_UNEXP,
> -                 0, 0, 0, 0, 0, 0);
> -}
> -
>  void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
>  {
>         vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_=
code);
> @@ -348,8 +348,33 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm,=
 u32 vcpu_id)
>         /* Setup sscratch for guest_get_vcpuid() */
>         vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(sscratch), vcpu_id);
>
> -       /* Setup default exception vector of guest */
> -       vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(stvec), (unsigned long)g=
uest_unexp_trap);
> +       /*
> +        * Enable the V (vector) extension in KVM so that the compiler ca=
n
> +        * safely generate vector instructions (e.g. via -O2 auto-
> +        * vectorization). Silently ignore errors; the test will still wo=
rk
> +        * without V.
> +        */
> +       __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_V), 1);
> +
> +       /*
> +        * Use the full exception vector table (which provides lazy V
> +        * extension enablement for EXC_INST_ILLEGAL in route_exception)
> +        * as the default exception handler. vm_init_vector_tables() is
> +        * idempotent; tests that call it again will get a no-op.
> +        */
> +       vm_init_vector_tables(vm);
> +       vcpu_init_vector_tables(vcpu);
> +
> +       /*
> +        * Record V extension availability in the handlers struct so that
> +        * route_exception() (called from Guest context) can check it
> +        * without relying on a host-side global variable.
> +        */
> +       {
> +               struct handlers *h =3D addr_gva2hva(vm, vm->handlers);
> +
> +               h->v_available =3D __vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA=
_EXT_V);
> +       }
>
>         return vcpu;
>  }
> @@ -408,19 +433,17 @@ void assert_on_unhandled_exception(struct kvm_vcpu =
*vcpu)
>         struct ucall uc;
>
>         if (get_ucall(vcpu, &uc) =3D=3D UCALL_UNHANDLED) {
> +               vcpu_dump(stderr, vcpu, 2);
>                 TEST_FAIL("Unexpected exception (vector:0x%lx, ec:0x%lx)"=
,
>                         uc.args[0], uc.args[1]);
>         }
>  }
>
> -struct handlers {
> -       exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS=
];
> -};
> -
>  void route_exception(struct pt_regs *regs)
>  {
>         struct handlers *handlers =3D (struct handlers *)exception_handle=
rs;
> -       int vector =3D 0, ec;
> +       int vector =3D 0;
> +       unsigned long ec;
>
>         ec =3D regs->cause & ~CAUSE_IRQ_FLAG;
>         if (ec >=3D NR_EXCEPTIONS)
> @@ -432,6 +455,46 @@ void route_exception(struct pt_regs *regs)
>                 ec =3D 0;
>         }
>
> +       /*
> +        * Handle V (vector) extension lazy enablement before any
> +        * registered handler. The compiler's default march may include
> +        * V, and auto-vectorization generates vector instructions that
> +        * trigger EXC_INST_ILLEGAL when VS (Vector Status) in sstatus
> +        * is Off. Enable VS to Initial and re-execute the faulting
> +        * instruction, mimicking what a real OS kernel does.
> +        *
> +        * This check runs before any test-registered handler, so tests
> +        * that install their own EXC_INST_ILLEGAL handler (e.g.
> +        * sbi_pmu_test) are not affected.
> +        */
> +       if (!(regs->cause & CAUSE_IRQ_FLAG) && ec =3D=3D EXC_INST_ILLEGAL=
) {
> +               /*
> +                * If KVM supports the V extension for this Guest and VS
> +                * (Vector Status) is Off in the saved sstatus, set it to
> +                * Initial and re-execute the faulting instruction.
> +                *
> +                * Use regs->status (saved at exception entry) rather tha=
n
> +                * reading the live CSR to avoid a TOCTOU race.
> +                *
> +                * Track the epc per-vCPU to avoid an infinite loop when
> +                * V is disabled or the hardware rejects the VS change.
> +                * Using a per-vCPU array avoids races between concurrent
> +                * vCPUs that would occur with a single shared (epc, vcpu=
)
> +                * pair.
> +                */
> +               if (handlers && handlers->v_available && !(regs->status &=
 SR_VS)) {

Treating all illegal exceptions as V instruction traps is not the right the=
 way.
We may have genuinely unexpected traps for which guest_unexp_trap()
should be called.

> +                       unsigned int vcpu_id;
> +
> +                       asm volatile("csrr %0, sscratch" : "=3Dr" (vcpu_i=
d));
> +                       if (vcpu_id < handlers->v_epc_capacity &&
> +                           handlers->v_epc[vcpu_id] !=3D regs->epc) {
> +                               handlers->v_epc[vcpu_id] =3D regs->epc;
> +                               regs->status |=3D SR_VS_INITIAL;
> +                               return;
> +                       }
> +               }
> +       }
> +
>         if (handlers && handlers->exception_handlers[vector][ec])
>                 return handlers->exception_handlers[vector][ec](regs);
>
> @@ -448,9 +511,31 @@ void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
>
>  void vm_init_vector_tables(struct kvm_vm *vm)
>  {
> -       vm->handlers =3D __vm_alloc(vm, sizeof(struct handlers), vm->page=
_size,
> +       unsigned int max_vcpu_id;
> +       size_t size;
> +
> +       if (vm->handlers)
> +               return;
> +
> +       max_vcpu_id =3D kvm_check_cap(KVM_CAP_MAX_VCPU_ID);
> +       if (max_vcpu_id =3D=3D 0)
> +               max_vcpu_id =3D 512;
> +
> +       /*
> +        * vcpu_id may be sparse and ranges from 0 to KVM_CAP_MAX_VCPU_ID
> +        * (which can be much larger than KVM_CAP_MAX_VCPUS), so size the
> +        * per-vCPU epc array accordingly.
> +        */
> +       size =3D sizeof(struct handlers) + (max_vcpu_id + 1) * sizeof(uns=
igned long);
> +       vm->handlers =3D __vm_alloc(vm, size, vm->page_size,
>                                   MEM_REGION_DATA);
>
> +       {
> +               struct handlers *h =3D addr_gva2hva(vm, vm->handlers);
> +
> +               h->v_epc_capacity =3D max_vcpu_id + 1;
> +       }
> +
>         *(gva_t *)addr_gva2hva(vm, (gva_t)(&exception_handlers)) =3D vm->=
handlers;
>  }
>
> --
> 2.53.0
>

Regards,
Anup
