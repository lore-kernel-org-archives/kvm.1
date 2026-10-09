Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD44FB9DA
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571890; cv=pass; b=CUi2sHz8l7KY1oPbs6POTOto8Z1oSaJyrHOm7hSrxQ39Yia+ZsS8paaQV8hX0zPxadJeo7m/qCxa7F+HvfMbooBqMSjjH42cBmKyN1QjIabLISdKq6kTbRYpE9+GICj9H1JI1u9A/pQ56V4g6FE++9JeDZ8wpLoucQZ4FJtG5lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571890; c=relaxed/simple;
	bh=SaEwHTBxhGvxRikjH8R5QK6X6O0lBouPFtjb7tjhfUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXRrC5G4GDbRBmdAJwCNUxFrRkygL6xxdgOkMs4q2i2uzJs2OUO4tWXg441sqIXCDLQKWOTx8Zq+P+4zyWHWZ75o20mio9Ssx23ypsoiXUM2uZDJ8MhZeIBhEwGI24jl07aAum5yvZk8f5iZk509HT9GjO31MA3kAfvuHh2blXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=loiAJyQ6; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="loiAJyQ6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c45111bebso88938f8f.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 11:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791571887; cv=none;
        d=google.com; s=arc-20260327;
        b=bpOYBvlans8jKsPhnUCY5p9LfaL6KC3013C/fcooa88hWb6T2fQUv227SA3zgaTqEO
         Wky5VfjGKbzZ2tlSIB2KxCtZq9SyIrK50tZN0CRtRNRG2B7zkkP/tzLUa+3oy31mpOGe
         dPrpzuGfo0F9YIiG5z7x41Rd005R3qGnAliSKnKNz6vLq4PbY9bwbBm5z5j3ROZ3t5a7
         KcE7Xqm5+3RbtKZfAPVTmpmTvpqQ0qLa/VxbbPBRNxhTNyLu/rNJmjA8qqLEkTIFFjt9
         ZytBX/S/3IxSuK6qsqDAZu6pcx/ohneGEIpeIGQS+CoNJww8gMEtHeTpZwlf9XlBkLzX
         5amw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pTwMuIojjnToAANiKhe/g+cf/Y5TPrRL6sZUxpSOQdY=;
        fh=yIs2pE03AaA4BRljYbxbhdyOx29oq0Ig8+GNP8uCFgc=;
        b=jb6JX1wduFZCQf9VXcEi8P12BdgpkMJFN9Erux3+qmwy1FTrKsp8aTKJKjqUrKT/Mw
         Q7+PAiIa1H/Jhk+XY+4dK+gbtx+7ar/BTOqG7Saz6iItVYRuou3v4cZDXpPe1TMR4HQb
         SDGiRwaxSidBKzjE/oIWWHuS47v/C+dT+OC2kE4XDUWXVgZj6RE+1dIAGkTLrZLCl4nJ
         gYguhn+aF8Zjp+5Hzdy+M6zGXFXaWOo3SPNgk/0aKmLcByx6e8tWb6nPz0rnTys8ibvX
         DpwYvc6mlpcShx+L1ToA67h9P679PZqAserzu1RGmGjpeKFu4HcFzI996gZmGBikTU1f
         OVpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791571887; x=1792176687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pTwMuIojjnToAANiKhe/g+cf/Y5TPrRL6sZUxpSOQdY=;
        b=loiAJyQ6kyVgTBlHgifKV+O3164kKhiaPY+Cii46O3zqPUyk8S7aMGAZV5wrVV60st
         R5YT8R66l8o0bejxg4HwfQ/eNQCycsz5X7XsddC0P1e4gBEO8lbd5LoLD12dlbJh2m3q
         TYaeCVwY8LBxz+YckKXM9Mwo9q3Z5eslAVIY6Bx9AOqF3NW8iT+kHS1kkglDIP2haQVj
         PSJvD2PkjCIP0DcDQvvOAi6OMT/0WRAcGQMz2ytAM+XflV3k5BSg2BMlVztruXA6190u
         kqVolpbMlwXE/FuGoJrZ0C8lNCz4vYnZE1ulpV8laa+DTiJjIHpUwRMF3sOnxw/hGiVJ
         vBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571887; x=1792176687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pTwMuIojjnToAANiKhe/g+cf/Y5TPrRL6sZUxpSOQdY=;
        b=MEiJax/RIEi3UHH4Ta1og7vsgzritTsyJLCwSDTgId7XMhdBYSgPpVX96S91ctizfK
         55m2Vc6bZ9Bw9In3SJikjYSzYT+uxhEKQwaH4GgoqCV62S0VTXIeESr0isVbhgBiFbUW
         F2xMprJ2KZ826nmcZypy3djTmTD79+Djbhmg574yq6i4OFfhGzieA6bth1M47F/2VyOX
         Ud1TEi/803Xtn7+V0anTfgregf0qksLmM/YOsjhVJCSwM7NHf4gJISbHBMap1VTO0FmW
         uigcMGA1IOkPVT4D6+UOCIwQ2j0hkgokhMP6lRknKL94qt3iwDB+Cxdu4WF+O6T/POwJ
         c/EA==
X-Forwarded-Encrypted: i=1; AKwUvBy4mhdPtEiCtQkN7H4rNExUlNB5Ze7Fd0jXDCMY2z10wDcVRpCB7oGpbdvcPcG7+D8Ba2g=@vger.kernel.org
X-Gm-Message-State: AFuF++kfo/2QiDNYDAfw8YGfoK7b0Q7szNa8dTnpThYXBrks7b4Gu55i
	l7hAbleAIb93hI4g1p3UxV+d3GUlrHVucSsB6Tf3LF1CpJrA7E6P5PdyH4zyHuA3oHPNgiieUH0
	ijQpKba4VZfr5b1In6FB/PcaK4g2CUSqzaMsGRTR2Lg==
X-Gm-Gg: AYBFou05Cri/4PYLXYtZ1oHm7BU8CUEvmrjGfSGL0LP0HrjfTyrQDw3YEKX9SACnIxb
	PJSRra9g6hRQkQxGetTe/st19UOEWeYPMA1VUdY6r94AwVkCPFkij5Jn5ZTS11b2znDe0UlT9VA
	gDmRbpkRrZOFMaGaaqJwfagaHCw5NoEBQCDFisfdaxor1yvoddUf+gu3uJL0zXkpqPe/xomgneE
	38GitA8dasCpUSaGHkLeb8PZbcqhcfvp7VfBaGU9WRRNPJyTq/bV81B+Q9ZrnbbaWAQIyEXwjxZ
	Ws+modCa/T9cDQAeZMIy9veSlLE0JCqCNTEEOtS2BYau7LFbn/vvtX9TKu7WmQXuOd2SmDoOe1n
	lRV2LhyQOOzYvquY+tw+0m8Z5A1ya9n2h9+azQzP5VMVH28dyR6e+jv9eKMrdO+C+J7Qzdd3pIg
	==
X-Received: by 2002:a05:600c:1909:b0:4a0:159b:d283 with SMTP id
 5b1f17b1804b1-4a18e4d5412mr52437895e9.30.1791571886366; Fri, 09 Oct 2026
 11:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817102447.40259-1-guoyaxing@bosc.ac.cn>
In-Reply-To: <20260817102447.40259-1-guoyaxing@bosc.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 9 Oct 2026 20:51:13 +0200
X-Gm-Features: AclHuK-R8aeNbEa0DRQqSNimuLjIFPfg4YE0zWymfuyfO_mPCIzLXp3g4GDDc8A
Message-ID: <CAAhSdy2qwdHE7SB2gRK3_PQ6m_bMSfWpvcuSG-31W2yd3-UTKg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Flush VS-stage TLB before reusing a host CPU
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	majiuyue@bosc.ac.cn, anzoso@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 12:25=E2=80=AFPM Yaxing Guo <guoyaxing@bosc.ac.cn> =
wrote:
>
> Guest Linux uses mm_cpumask to decide whether an sfence.vma needs to be
> local or remote. Under KVM that mask tracks guest CPUs, not the host CPUs
> that previously backed a vCPU.
>
> This can miss stale VS-stage TLB entries when a vCPU migrates across host
> CPUs. For example:
>
>   - vcpu0 runs on host CPU1 and fills a VS-stage TLB entry.
>   - vcpu0 migrates to host CPU0.
>   - the guest updates the mapping on vcpu0 and issues a local sfence.vma.
>   - later, the guest task runs on vcpu1 while vcpu1 is backed by host CPU=
1.

When the vcpu0 is brought back to host CPU1, the kvm_riscv_local_tlb_saniti=
ze()
will ensure TLB entries associated with Guest/VM are nuked.

By default, kvm_riscv_local_hfence_gvma_vmid_all() will only do HFENCE.GVMA
for the associated VMID because most RISC-V H-extension implemenation will
tag VS-stage TLB entries with VMID and HFENCE.GVMA must remove both
G-stage and VS-stage TLB entries for given VMID.

If your HW does not tag VS-stage TLB enteries with VMID then it buggy
/ inefficient
so you have to set kvm_riscv_vsstage_tlb_no_gpa in
kvm_riscv_setup_vendor_features()
as work-around.

NACK to this patch from myside.

Regards,
Anup

>
> Host CPU1 did not observe the guest-local sfence.vma, and KVM can enter
> vcpu1 with a stale VS-stage translation left behind by vcpu0.
>
> The reported failure was seen on a XiangShan RISC-V system. A bash task
> ran on vcpu0 while vcpu0 was backed by host CPU1, and a read-only page wa=
s
> prefetched into CPU1's VS-stage TLB. vcpu0 later migrated to host CPU0,
> where the guest triggered COW, updated the mapping, and issued only a loc=
al
> sfence.vma. The stale VS-stage entry on CPU1 survived. When the same gues=
t
> task later ran on another vCPU backed by host CPU1, it hit the stale
> translation. The page contained a GOT pointer, and using the stale data l=
ed
> to a NULL dereference and a userspace segmentation fault.
>
> The existing local TLB sanitize path flushes G-stage entries when a vCPU
> migrates, and flushes VS-stage entries only for implementations selected =
by
> the Andes-specific kvm_riscv_vsstage_tlb_no_gpa static key. That handles =
a
> split two-stage TLB implementation where HFENCE.GVMA does not invalidate
> VS-stage entries, but it does not cover the generic guest-local sfence.vm=
a
> case above.
>
> Track, per VM and per host CPU, the last vCPU that entered the guest on
> that CPU. Before guest entry, flush the current CPU's VS-stage context fo=
r
> the VM if either the current vCPU migrated since its last exit, or this
> host CPU is switching from another vCPU of the same VM. Keep the existing
> HFENCE.GVMA behavior tied to vCPU migration.
>
> This also subsumes the Andes split-TLB workaround. That workaround was
> needed because the migration sanitize path previously relied on
> HFENCE.GVMA alone for most implementations, and only issued HFENCE.VVMA
> when kvm_riscv_vsstage_tlb_no_gpa was set. The new sanitize path always
> issues HFENCE.VVMA when reusing a host CPU for a VM context that may have
> missed a guest-local sfence.vma, so it no longer depends on HFENCE.GVMA
> invalidating VS-stage entries. The implementation-specific static key and
> setup hook are therefore no longer needed.
>
> Reported-by: Zhizun Wang <anzoso@outlook.com>
> Reviewed-by: Jiuyue Ma <majiuyue@bosc.ac.cn>
> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
> ---
>  arch/riscv/include/asm/kvm_host.h |  6 +++---
>  arch/riscv/kvm/main.c             | 15 ---------------
>  arch/riscv/kvm/tlb.c              | 31 +++++++++++++++++++++++--------
>  arch/riscv/kvm/vm.c               | 16 ++++++++++++++++
>  4 files changed, 42 insertions(+), 26 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 24585304c..396ac6209 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -91,6 +91,9 @@ struct kvm_arch {
>         /* G-stage vmid */
>         struct kvm_vmid vmid;
>
> +       /* Last VCPU that ran on each physical CPU */
> +       int __percpu *last_vcpu_ran;
> +
>         /* G-stage page table */
>         pgd_t *pgd;
>         phys_addr_t pgd_phys;
> @@ -330,7 +333,4 @@ bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
>
>  void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
>
> -/* Flags representing implementation specific details */
> -DECLARE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
> -
>  #endif /* __RISCV_KVM_HOST_H__ */
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 0f3fe3986..b1bbc0835 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -10,23 +10,10 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/kvm_host.h>
> -#include <asm/cpufeature.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_nacl.h>
>  #include <asm/sbi.h>
>
> -DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
> -
> -static void kvm_riscv_setup_vendor_features(void)
> -{
> -       /* Andes AX66: split two-stage TLBs */
> -       if (riscv_cached_mvendorid(0) =3D=3D ANDES_VENDOR_ID &&
> -           (riscv_cached_marchid(0) & 0xFFFF) =3D=3D 0x8A66) {
> -               static_branch_enable(&kvm_riscv_vsstage_tlb_no_gpa);
> -               kvm_info("VS-stage TLB does not cache guest physical addr=
ess and VMID\n");
> -       }
> -}
> -
>  long kvm_arch_dev_ioctl(struct file *filp,
>                         unsigned int ioctl, unsigned long arg)
>  {
> @@ -172,8 +159,6 @@ static int __init riscv_kvm_init(void)
>                 kvm_info("AIA available with %d guest external interrupts=
\n",
>                          kvm_riscv_aia_nr_hgei);
>
> -       kvm_riscv_setup_vendor_features();
> -
>         kvm_register_perf_callbacks();
>
>         rc =3D kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index ff1aeac4e..1541d059a 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -8,6 +8,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/percpu.h>
>  #include <linux/smp.h>
>  #include <linux/kvm_host.h>
>  #include <asm/cacheflush.h>
> @@ -160,12 +161,19 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long =
vmid)
>
>  void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
>  {
> +       bool vcpu_migrated;
> +       bool vcpu_switched;
>         unsigned long vmid;
> +       int *last_ran;
>
> -       if (!kvm_riscv_gstage_vmid_bits() ||
> -           vcpu->arch.last_exit_cpu =3D=3D vcpu->cpu)
> +       last_ran =3D this_cpu_ptr(vcpu->kvm->arch.last_vcpu_ran);
> +       vcpu_migrated =3D (vcpu->arch.last_exit_cpu !=3D vcpu->cpu);
> +       vcpu_switched =3D (*last_ran !=3D vcpu->vcpu_idx);
> +       if (!vcpu_migrated && !vcpu_switched)
>                 return;
>
> +       vmid =3D READ_ONCE(vcpu->kvm->arch.vmid.vmid);
> +
>         /*
>          * On RISC-V platforms with hardware VMID support, we share same
>          * VMID for all VCPUs of a particular Guest/VM. This means we mig=
ht
> @@ -176,16 +184,23 @@ void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *=
vcpu)
>          * To cleanup stale TLB entries, we simply flush all G-stage TLB
>          * entries by VMID whenever underlying Host CPU changes for a VCP=
U.
>          */
> -
> -       vmid =3D READ_ONCE(vcpu->kvm->arch.vmid.vmid);
> -       kvm_riscv_local_hfence_gvma_vmid_all(vmid);
> +       if (vcpu_migrated && kvm_riscv_gstage_vmid_bits())
> +               kvm_riscv_local_hfence_gvma_vmid_all(vmid);
>
>         /*
> -        * Flush VS-stage TLB entries for implementation where VS-stage
> -        * TLB does not cahce guest physical address and VMID.
> +        * Guest-local sfence.vma only invalidates VS-stage translations =
on
> +        * the Host CPU currently backing the VCPU. If a VCPU migrates, o=
r
> +        * if this Host CPU switches between VCPUs of the same VM, stale
> +        * VS-stage entries can be left behind on a Host CPU that missed =
a
> +        * guest-local flush. Flush the current CPU's VS-stage context be=
fore
> +        * entering the guest.
>          */
> -       if (static_branch_unlikely(&kvm_riscv_vsstage_tlb_no_gpa))
> +       if (kvm_riscv_nacl_available())
> +               nacl_hfence_vvma_all(nacl_shmem(), vmid);
> +       else
>                 kvm_riscv_local_hfence_vvma_all(vmid);
> +
> +       *last_ran =3D vcpu->vcpu_idx;
>  }
>
>  void kvm_riscv_fence_i_process(struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index 13c63ae1a..2907218a1 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -9,6 +9,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/percpu.h>
>  #include <linux/uaccess.h>
>  #include <linux/kvm_host.h>
>  #include <asm/kvm_mmu.h>
> @@ -30,7 +31,9 @@ const struct kvm_stats_header kvm_vm_stats_header =3D {
>
>  int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  {
> +       int *last_ran;
>         int r;
> +       int cpu;
>
>         r =3D kvm_riscv_mmu_alloc_pgd(kvm);
>         if (r)
> @@ -42,6 +45,17 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long ty=
pe)
>                 return r;
>         }
>
> +       kvm->arch.last_vcpu_ran =3D alloc_percpu(int);
> +       if (!kvm->arch.last_vcpu_ran) {
> +               kvm_riscv_mmu_free_pgd(kvm);
> +               return -ENOMEM;
> +       }
> +
> +       for_each_possible_cpu(cpu) {
> +               last_ran =3D per_cpu_ptr(kvm->arch.last_vcpu_ran, cpu);
> +               *last_ran =3D -1;
> +       }
> +
>         kvm_riscv_aia_init_vm(kvm);
>
>         kvm_riscv_guest_timer_init(kvm);
> @@ -54,6 +68,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>         kvm_destroy_vcpus(kvm);
>
>         kvm_riscv_aia_destroy_vm(kvm);
> +
> +       free_percpu(kvm->arch.last_vcpu_ran);
>  }
>
>  int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
> --
> 2.43.0
>
