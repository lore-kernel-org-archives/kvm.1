Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE547A890;
	Wed,  5 Aug 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943540; cv=none; b=Z9Qjtszl+GyTfYSoMJoQVc3uZLG4aC/CgL9Um837mkieEy6li3v27/rQbZ/5O5tIL+PDBsy20GkFH6m60UTZVa8EUkLdjOlLLS01RCur2lISglp6hW47bTvkEQcNsZ/vDejmEBAfbNDFE1aK6H3dxAZG0zIqRIrojLsT3BgeFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943540; c=relaxed/simple;
	bh=dhBTKL16K328jyw8hT8g7F3T7FBviAVqjnPnelMyyuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAuqiCQTyZEAtqY4gTZsbrzStyp1IHtvNK1dXIMmD0tf6X7hDrp+9YkvvgxsJ878VKRBsuQarOHRd9h30JMcIBUu1ZsG9GFiqnWxdIb7c68RaEBcimyeLsPUd8yvmTPyyW6gIGdGHL1PPvsn5K7XE5UdS8/OGmgibvfJSqWlgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9egFU5h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9egFU5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6487A1F000E9;
	Wed,  5 Aug 2026 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785943520;
	bh=IwNrsz2+3MvVxMSy1TiR5BJ4B0kyVtbbSFpIIrUW7rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G9egFU5hPPdJFCh9TZH868HrPU13JXX8vfZ0Pa+nOPER6OjYVlo15AdJvhH/sl1XV
	 rsZuAcCCbaUwO93xhBCMJ/rpxLDK7DgCuMmHND/fHiERl7xwtMRailI7Y99hmpYz4r
	 dRyevezNoYgDns0N49PabTy5Ds3t795Qkx+FhT85TIsWlY5ZjGzTZtQXIr+gVDcjgb
	 /rfL0uMDURhYFec7rX5obz5FYObRhVwj2q7u54GDIjRBLjWEfyN0t4TGe4+NvYWgil
	 u7ESVAbzS9JE1KDx4QrSJT8/yWUIY0DsNrqPci/U6/JKHfZa6X6urIh7MniXfwgoFG
	 NA3wIb6VKeWbA==
Date: Wed, 5 Aug 2026 15:25:19 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/28] KVM: nSVM: Add a placeholder ASID for L2
Message-ID: <anNSYpoXYXoGBewo@google.com>
References: <20260728003557.1136583-1-yosry@kernel.org>
 <20260728003557.1136583-13-yosry@kernel.org>
 <CAO9r8zPoeV6H61vwO06Wj=ed+5_tUC8LVqEf=zp-U-axvxNt3g@mail.gmail.com>
 <anKCocdyhY6PFT3l@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anKCocdyhY6PFT3l@google.com>

On Wed, Aug 05, 2026 at 12:26:30AM +0000, Yosry Ahmed wrote:
> On Fri, Jul 31, 2026 at 11:34:34PM -0700, Yosry Ahmed wrote:
> > On Mon, Jul 27, 2026 at 5:36 PM Yosry Ahmed <yosry@kernel.org> wrote:
> > >
> > > In preparation for introducing a separate ASID for L2, introduce a
> > > 'placeholder' ASID that is still the same as L1's ASID. This will
> > > facilitate future changes that need to distinguish L1 and L2's ASIDs,
> > > before actually using a different ASID for L1 and L2.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 5 +++--
> > >  arch/x86/kvm/svm/svm.h    | 2 ++
> > >  2 files changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index ed4af5a08f794..eb60d6b959d86 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -698,7 +698,6 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
> > >          *  - Honor L1's request to flush an ASID on nested VMRUN
> > >          *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
> > >          *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
> > > -        *  - Flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST
> > >          *
> > >          * [*] Unlike nested EPT, SVM's ASID management can invalidate nested
> > >          *     NPT guest-physical mappings on VMRUN.
> > > @@ -928,7 +927,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
> > >         else
> > >                 vmcb02->control.bus_lock_counter = 0;
> > >
> > > -       vmcb02->control.asid = vmcb01->control.asid;
> > > +       vmcb02->control.asid = svm->nested.asid02;
> > >
> > >         /* Overwritten later if necessary.  */
> > >         vmcb_clr_flush_asid(vmcb02);
> > > @@ -1498,6 +1497,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
> > >         if (!svm->nested.msrpm)
> > >                 goto err_free_vmcb02;
> > >
> > > +       svm->nested.asid02 = svm->asid;
> > > +
> > 
> > From internal Sashiko:
> > ---
> > Does caching the ASID here risk leaving nested.asid02 stale during an
> > intra-host SEV VM migration?
> > 
> > If userspace restores EFER.SVME on a destination vCPU before completing
> > the migration, svm_allocate_nested() is called and nested.asid02 is
> > initialized with a normal non-SEV TLB tag.
> > 
> > Later, when KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM completes the migration,
> > sev_migrate_from() updates the primary ASID but misses this new
> > nested.asid02 field:
> > 
> > arch/x86/kvm/svm/sev.c:sev_migrate_from() {
> >         ...
> >         dst_svm->asid = dst->asid;
> >         sev_init_vmcb(dst_svm, false);
> >         ...
> > }
> > 
> > When L1 subsequently executes VMRUN to enter L2,
> > nested_vmcb02_prepare_control() will assign this stale non-SEV
> > nested.asid02 to vmcb02->control.asid.
> > 
> > Does this mismatch cause L2 to run with an invalid non-SEV ASID while the
> > VMCB's SEV bit is set, resulting in an unconditional #VMEXIT_INVALID
> > hardware fault?
> > ---
> > 
> > I am starting to hate SEV..
> > 
> > This would also be correct if the vCPUs are created on the destination
> > VM before it's marked as an SEV VM. This is a recurring theme at this
> > point.
> 
> So for this problem and the other two SEV migration problems reported in
> patch #10, I am thinking we end up with something like this over both
> patches (untested) -- any feedback would be appreciated as I have ~0
> knowledge of SEV and ~0 testing capabilities:
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 087d18a5eda69..09a0572996352 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2019,6 +2019,29 @@ static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
>         atomic_set_release(&src_sev->migration_in_progress, 0);
>  }
> 
> +static void sev_vcpu_migrate_asid(struct vcpu_svm *dst_svm, struct vcpu_svm *src_svm,
> +                                 unsigned int asid)
> +{
> +       /*
> +        * Free the (potentially non-SEV) ASID on the destination vCPU before
> +        * setting the new SEV ASID. Clear the ASID on the source vCPU to avoid
> +        * mistakenly attempting to free an SEV ASID after the vCPU is no longer
> +        * an SEV vCPU.
> +        */
> +       free_asid(dst_svm->asid);

Actually this doesn't solve the problem of leaking the non-SEV ASID,
because is_sev_guest() will return true for the destination vCPU at this
point AFAICT.

It's probably best to have free_asid() not key off is_sev_guest() at
all, and explicitly check if the ASID is reserved. Something like:

static inline void free_asid(kvm_tlb_tag_t asid)
{
	if (asid >= svm_nr_reserved_asids && asid != fallback_asid)
                kvm_free_tlb_tag(asid);
}

, or even better, we can have fallback_asid be a reserved ASID as well
(if all ASIDs are not allocated to SEV), then we can just check reserved
ASIDs and we don't have to worry about freeing the fallback_asid.

> +       dst_svm->asid = asid;
> +       src_svm->asid = 0;

..and the above would also remove te need to clear src_svm->asid here.

> +
> +       /*
> +        * If nested is already initialized on the destination vCPU, update the
> +        * nested ASID as well to match the new SEV ASID.
> +        */
> +       if (dst_svm->nested.vmcb02.ptr) {
> +               dst_svm->nested.asid02 = asid;
> +               dst_svm->nested.vmcb02.ptr->control.asid = asid;
> +       }
> +}
> +
>  static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
>  {
>         struct kvm_sev_info *dst = to_kvm_sev_info(dst_kvm);
> @@ -2071,12 +2094,6 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
>         kvm_for_each_vcpu(i, dst_vcpu, dst_kvm) {
>                 dst_svm = to_svm(dst_vcpu);
> 
> -               dst_svm->asid = dst->asid;
> -               sev_init_vmcb(dst_svm, false);
> -
> -               if (!dst->es_active)
> -                       continue;
> -
>                 /*
>                  * Note, the source is not required to have the same number of
>                  * vCPUs as the destination when migrating a vanilla SEV VM.
> @@ -2084,6 +2101,12 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
>                 src_vcpu = kvm_get_vcpu(src_kvm, i);
>                 src_svm = to_svm(src_vcpu);
> 
> +               sev_vcpu_migrate_asid(dst_svm, src_svm, dst->asid);
> +               sev_init_vmcb(dst_svm, false);
> +
> +               if (!dst->es_active)
> +                       continue;
> +
>                 /*
>                  * Transfer VMSA and GHCB state to the destination.  Nullify and
>                  * clear source fields as appropriate, the state now belongs to
> 
> 
