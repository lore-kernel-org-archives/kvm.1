Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B138B130
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077614; cv=none; b=LbJrSd79AztTbIebpNKa9dIK5JB/BYwKcf1Z+xaIUcMDPRcvL6yWw6wHth1h9m9G1chA1E/kSJ52qVVdZUQEMV69PnU81yeEvaQV1wnq54QX93MJS0kdDdvhLI3a+XYGKh3lN8xJVA2+IGkrYIh7sCVBXnC99ESwS3SZvrZvcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077614; c=relaxed/simple;
	bh=IVMeq5PmQFqgtmIrVHmRx7jScotEF2e24AQdmrVUQGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXmgCmIYEHXp6+vBQjgTuJYTWHjqS3TL2s7c2cgF7GNYia4qHZu+OOjvOlXhFdO1ztrrSVTDl6zeO/y0maVlm4SIHaWW33/DCg2zorrXQxKvIeUF0yQpJ/+8HgE5i2BfZuNoTe9MwbWO8LyS8IBVX59yUIRpRrSiV5PV0ObhCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwFFSZfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwFFSZfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7D41F000C5
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077610;
	bh=wdvq1TIvAWtzFc3HXM7Tr/rT9YVco7vknc2L3C19iyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LwFFSZfHRye2vhUZWsJ95k/OST87D7zhcaXnQWoffEqmN7HfkLHJD4rxVLaPLoPhR
	 0mzpI0Si3rkQJxNVX3zkyo44xFwMTSwYJ7ssEikE9+XYZ/mj52V4OyqKC7+cCVprbX
	 lLPHoOf56rm98qVWPSJ+n8zxWA2dm1PXKDiEy2Leps/jK6Ml+8nUD93fSYkL16q9lP
	 Pq5RcDywPYEvUhonidxoLz9ZdmFGvEy73HJXz8RH4LpttSRqySNfJwe/AqH+lbXyGQ
	 dDlgRxa9vWiaujxYdDJFXtVrZH+37yv4RkAeHndIL2xknXgbazq4JW97INbc75hlqV
	 RtGowLQUZNkBg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c263415982eso706144766b.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 08:20:10 -0700 (PDT)
X-Gm-Message-State: AFq9FYK6wGrz+qWMtHWNwurU1EVMTUbBf44/NXl5emVD1QXMTErbdNxF
	WOYvrsiCq47fTFphF5qV3gZD9E/KlNMwdDMlfklPraTxF0mLvSrVMW8yqMoXpgNQ/fQDaIw8BBG
	1HhGrqh45f20PPID1RE3/l269LHx2bLk=
X-Received: by 2002:a17:907:7ba3:b0:c29:f5d5:5aa1 with SMTP id
 a640c23a62f3a-c31aa097acdmr1920251066b.43.1792077609662; Thu, 15 Oct 2026
 08:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015103933.2088307-1-nikunj@amd.com> <20261015103933.2088307-3-nikunj@amd.com>
In-Reply-To: <20261015103933.2088307-3-nikunj@amd.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 15 Oct 2026 08:19:57 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPCetZ0S-Ve193gKKX3_TmHFeTEzuNvB-6qwie22a3n8Q@mail.gmail.com>
X-Gm-Features: AclHuK_vqDCJDAJ8st17HI1jfYFzD3RaLLiZtirzIRZF-rgKx8vnx3zelGshdm0
Message-ID: <CAO9r8zPCetZ0S-Ve193gKKX3_TmHFeTEzuNvB-6qwie22a3n8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] KVM: nSVM: Add nested PML emulation
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, mlevitsk@redhat.com, joao.m.martins@oracle.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 3:40=E2=80=AFAM Nikunj A Dadhania <nikunj@amd.com> =
wrote:
>
> Emulate Page Modification Logging (PML) for nested SVM guests, allowing
> L1 hypervisors to use PML to track dirty pages in their L2 guests.
> KVM emulates PML in software by write-protecting L2 SPTEs and logging
> dirty GPAs to L1's PML buffer via the write_log_dirty hook.
>
> PML_FULL exits are prioritized over NPF exits to ensure L1 processes
> the PML buffer before continuing L2 execution.
>
> Clear any pending PML Full on nested VMRUN.  The flag is derived from L1'=
s
> log index, and a fault that KVM discards instead of injecting can leave i=
t
> set after L1 has drained its buffer.  No event is lost: if the buffer is
> genuinely full, the next dirty write raises PML Full again.
>
> Assisted-by: LLM
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>  arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
>  arch/x86/kvm/svm/nested.c      | 75 +++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/svm/svm.h         |  8 ++++
>  3 files changed, 83 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 043d0ec02b27..c9ec05620e44 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -234,7 +234,7 @@ static int FNAME(update_accessed_dirty_bits)(struct k=
vm_vcpu *vcpu,
>                 if (level =3D=3D walker->level && write_fault &&
>                                 !(pte & PT_GUEST_DIRTY_MASK)) {
>                         trace_kvm_mmu_set_dirty_bit(table_gfn, index, siz=
eof(pte));
> -#if PTTYPE =3D=3D PTTYPE_EPT
> +#if (PTTYPE =3D=3D PTTYPE_EPT) || (PTTYPE =3D=3D 64)
>                         /* Only the nested GPA walk yields an L2 GPA to l=
og. */
>                         if (w =3D=3D &vcpu->arch.ngpa_walk &&
>                             kvm_nested_call(write_log_dirty)(vcpu, addr))
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index af0ef678433d..8251b38d1479 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -17,6 +17,7 @@
>  #include <linux/kvm_types.h>
>  #include <linux/kvm_host.h>
>  #include <linux/kernel.h>
> +#include <linux/mm.h>
>
>  #include <asm/msr-index.h>
>  #include <asm/debugreg.h>
> @@ -63,7 +64,14 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu=
 *vcpu,
>         if (WARN_ON_ONCE(hweight64(fault_stage) !=3D 1))
>                 fault_stage =3D PFERR_GUEST_FINAL_MASK;
>
> -       vmcb->control.exit_code =3D SVM_EXIT_NPF;
> +       /*
> +        * Only the exit code differs for a PML Full; hardware leaves the
> +        * EXITINFO fields as the nested page fault that filled the buffe=
r
> +        * would set them.
> +        */
> +       vmcb->control.exit_code =3D svm->nested.pml_full ? SVM_EXIT_PML_F=
ULL : SVM_EXIT_NPF;
> +       svm->nested.pml_full =3D false;
> +
>         vmcb->control.exit_info_1 =3D fault_stage |
>                                     (fault->error_code & ~PFERR_GUEST_FAU=
LT_STAGE_MASK);
>         vmcb->control.exit_info_2 =3D fault->address;
> @@ -416,6 +424,16 @@ static bool nested_vmcb_check_controls(struct kvm_vc=
pu *vcpu,
>                !kvm_vcpu_is_legal_gpa(vcpu, control->nested_cr3)))
>                 return false;
>
> +       if (control->misc_ctl & SVM_MISC_ENABLE_PML) {
> +               if (CC(!(control->misc_ctl & SVM_MISC_ENABLE_NP)))
> +                       return false;
> +               if (CC(!IS_ALIGNED(control->pml_addr, PAGE_SIZE)))
> +                       return false;
> +               if (CC(!nested_svm_check_bitmap_pa(vcpu, control->pml_add=
r,
> +                                                  PAGE_SIZE)))
> +                       return false;
> +       }
> +
>         if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
>                                            MSRPM_SIZE)))
>                 return false;
> @@ -556,6 +574,8 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_v=
cpu *vcpu,
>         to->nested_cr3          =3D from->nested_cr3;
>         to->pause_filter_count  =3D from->pause_filter_count;
>         to->pause_filter_thresh =3D from->pause_filter_thresh;
> +       to->pml_addr            =3D from->pml_addr;
> +       to->pml_index           =3D from->pml_index;
>
>         /* Copy asid here because nested_vmcb_check_controls() will check=
 it */
>         to->asid           =3D from->asid;
> @@ -909,6 +929,13 @@ static void nested_vmcb02_prepare_control(struct vcp=
u_svm *svm)
>         if (pml)
>                 vmcb02->control.pml_index =3D -1;
>
> +       /*
> +        * Clear any pending PML Full, as L1's log index has just been
> +        * reloaded from vmcb12.  A fault that KVM discards instead of
> +        * injecting can leave the flag set after L1 drained its buffer.
> +        */
> +       svm->nested.pml_full =3D false;
> +
>         /*
>          * Stash vmcb02's counter if the guest hasn't moved past the guil=
ty
>          * instruction; otherwise, reset the counter to '0'.
> @@ -1311,6 +1338,8 @@ static int nested_svm_vmexit_update_vmcb12(struct k=
vm_vcpu *vcpu)
>         vmcb12->control.event_inj         =3D 0;
>         vmcb12->control.event_inj_err     =3D 0;
>         vmcb12->control.int_ctl           =3D svm->nested.ctl.int_ctl;
> +       vmcb12->control.pml_addr          =3D svm->nested.ctl.pml_addr;
> +       vmcb12->control.pml_index         =3D svm->nested.ctl.pml_index;
>
>         trace_kvm_nested_vmexit_inject(vmcb12->control.exit_code,
>                                        vmcb12->control.exit_info_1,
> @@ -1886,6 +1915,8 @@ static void nested_copy_vmcb_cache_to_control(struc=
t vmcb_control_area *dst,
>         dst->misc_ctl2            =3D from->misc_ctl2;
>         dst->pause_filter_count   =3D from->pause_filter_count;
>         dst->pause_filter_thresh  =3D from->pause_filter_thresh;
> +       dst->pml_addr             =3D from->pml_addr;
> +       dst->pml_index            =3D from->pml_index;
>         /* 'clean' and 'hv_enlightenments' are not changed by KVM */
>  }
>
> @@ -2169,6 +2200,47 @@ static gpa_t svm_translate_nested_gpa(struct kvm_v=
cpu *vcpu, gpa_t gpa,
>         return w->gva_to_gpa(vcpu, w, gpa, access, exception);
>  }
>
> +static int nested_svm_write_pml_buffer(struct kvm_vcpu *vcpu, gpa_t gpa)
> +{
> +       struct vcpu_svm *svm =3D to_svm(vcpu);
> +       u16 index;
> +       gpa_t dst;
> +
> +       if (WARN_ON_ONCE(!is_guest_mode(vcpu)) || !nested_pml_enabled(svm=
))
> +               return 0;
> +
> +       /* The flag can be set here if the fault that raised it was disca=
rded. */
> +       if (svm->nested.pml_full)
> +               return 1;
> +
> +       index =3D svm->nested.ctl.pml_index;
> +       if (index >=3D PML_LOG_NR_ENTRIES) {
> +               svm->nested.pml_full =3D true;
> +               return 1;
> +       }
> +
> +       gpa &=3D ~0xFFFULL;
> +       dst =3D svm->nested.ctl.pml_addr + sizeof(u64) * index;
> +
> +       /*
> +        * Drop the entry if the write fails.  VMRUN only verifies that L=
1's
> +        * buffer address is a legal GPA, not that it is backed, so a fai=
lure
> +        * here means L1 has pointed PML at memory it does not have, and =
only
> +        * L1's own dirty tracking suffers.
> +        */
> +       if (kvm_write_guest_page(vcpu->kvm, gpa_to_gfn(dst), &gpa,
> +                                offset_in_page(dst), sizeof(gpa)))
> +               return 0;
> +
> +       /*
> +        * Decrement PML_INDEX after logging the GPA (buffer fills backwa=
rds
> +        * from index 511 to 0)
> +        */
> +       svm->nested.ctl.pml_index =3D index - 1;
> +
> +       return 0;
> +}

This implementation is essentially the same as Intel, with the main
difference being where the data (pml_full, pml_address, pml_index)
live. I wonder if there's a way to share the implementation. I don't
have good ideas to be honest. One of them is getting pointers to these
vendor-specific variables at the top of a vendor-neutral function and
use them (ew?), or maybe have copies in vcpu->arch and sync them back
to the vmcb12/vmcs12 at some point (less ew?).

I always fail at predicting what Sean will think, but I think I am 90%
sure he won't like either of these ideas, so hopefully he will come up
with something better!
