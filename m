Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51C41D11A;
	Mon,  3 Aug 2026 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779474; cv=none; b=WwvslDVNPyiZIxu7Kbnd/ZOXoZfUH0DM5ZWJpvq+8At6g8pey9osncwsDsNZrgVaSG1PxEOz68mAsHn/oiMLXMsrmOOVpecdNwgri9/Zlb5gUXn883bqHrTPD3byQnPEaO3gKuhhJd/wyYLhBQ648+12aKIsj4vtQDgd5U34mqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779474; c=relaxed/simple;
	bh=1UDhPnUSydRl7lOQQClxkhAQC93+37EVJrF+p0ktoSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coMwlOdfcy3cMQV93x8Cp/u34h04z/5hR5GSdGfjLh1qxdKVtFoViVEcsFPVLPyGwwHxZ6ISPUui1hM+tvWz9eIhfvbr4E9Rn5ALweR/tpF6V3iEO2nh43Gi/+VGfnTMzF3je9AhYg06CFsLq8aGgEuLYo9MrZeNu3BrfMCWDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEc7XjCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEc7XjCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B2D1F000E9;
	Mon,  3 Aug 2026 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785779472;
	bh=j+fezG2slGTcKmRIKvLGV2PQNFZwf7YDKjAGfLUQTqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OEc7XjCcx0EWSn+KrRPQATqsS2xE3dTy1X82rlvwqm8YYjPg+SN0GTMWYKoBWASd9
	 nJ98xouHQsyPz9MgjDxzkTUOB4Bvb3ITZKwUKhBZF78u9uKQp5Pr4dRU5x3dJfvBJo
	 21yGkucSGfEMgN+medEvXVX8B7RKzuFWGp2zzNXfqjV0oaiKo+VCgdFruPzHAEx61Q
	 gQ4lC7+NRK/4w4R5Xd4c//uWf1mThoiIvqDBNZsUH0RFUD0WbPDJ8jEkQ7asNSRqib
	 TU14R0FnLricBI24ReTvjww8J2VRilgf9ZiFXijqqnU1PfxpqKCx/dxzqw1fH8xn37
	 g6mcZXc84PuUg==
Date: Mon, 3 Aug 2026 13:51:04 -0400
From: Guo Ren <guoren@kernel.org>
To: Anup Patel <anup@brainfault.org>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, Atish Patra <atish.patra@linux.dev>,
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Hui Min Mina Chou <minachou@andestech.com>, majiuyue@bosc.ac.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] RISC-V KVM: guest local sfence.vma may miss stale VS-stage
 TLB after vCPU migration
Message-ID: <anDVCJftl9Ag/uvD@gmail.com>
References: <20260802050015.104795-1-guoyaxing@bosc.ac.cn>
 <CAAhSdy3QE6Fe_fanKOLHLjDCb+vsVax=wy18UxzR23XN7ggJGw@mail.gmail.com>
 <anDNs9KCzz3DTXdu@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anDNs9KCzz3DTXdu@gmail.com>

On Mon, Aug 03, 2026 at 01:19:47PM -0400, Guo Ren wrote:
> On Mon, Aug 03, 2026 at 07:52:14PM +0530, Anup Patel wrote:
> > On Sun, Aug 2, 2026 at 10:30 AM Yaxing Guo <guoyaxing@bosc.ac.cn> wrote:
> > >
> > > Hi all,
> > >
> > > I would like to ask whether RISC-V KVM has a gap around guest sfence.vma
> > > and VS-stage TLB invalidation when a vCPU migrates across host CPUs.
> > >
> > > On bare metal, Linux uses mm_cpumask in __flush_tlb_range() to decide
> > > whether to send a local or remote sfence.vma. That works because the cpumask
> > > reflects physical CPUs. In a guest, however, the kernel only sees vCPUs, so
> > > from the guest point of view a task may never "migrate" even though the
> > > underlying vCPU moved to a different host CPU. In other words, guest
> > > mm_cpumask is effectively a vCPU mask, not a host CPU mask.
> > >
> > > There is also a related switch_mm()/set_mm_asid() aspect. With the ASID
> > > allocator enabled, RISC-V Linux does not flush on every context switch. A
> > > local_flush_tlb_all() is only done when a deferred ASID rollover flush is
> > > pending for the current CPU. That is fine on bare metal, because previous
> > > shootdowns are also based on physical CPUs. In a guest, however, the earlier
> > > shootdown may have been only a guest-local sfence.vma and may have missed an
> > > old host CPU where the same vCPU ran previously.
> > >
> > > A simplified sequence is:
> > >
> > > 1. A guest task with mm A runs on vcpu0 while vcpu0 is scheduled on host
> > >    CPU1. CPU1 fills a VS-stage TLB entry for that mm/ASID.
> > > 2. vcpu0 migrates to host CPU0. KVM's vCPU migration sanitization is local
> > >    to the current host CPU, so it does not invalidate the VS-stage TLB entry
> > >    that was left on host CPU1.
> > 
> > When vcpu0 migrates to host CPU0, the host CPU0 may or may not have
> > VS-stage TLB entry so VCPU migration sanitization does the right thing.
> > 
> > In the future, vcpu0 may again move back to host CPU1 containing stale
> > VS-stage TLB entries left in step1 above so the VCPU migration sanitization
> > will cleanup these stale TLB enteries.
> > 
> > > 3. The guest later updates mm A's page table from vcpu0, for example due to
> > >    COW. Since the guest still sees mm A as having run only on guest CPU0,
> > >    __flush_tlb_range() can choose a local sfence.vma. That local sfence.vma
> > >    only affects host CPU0, where vcpu0 is currently running, so the stale
> > >    VS-stage entry on host CPU1 remains.
> > 
> > No need to worry about stale VS-stage entry on host CPU1 because these
> > will age-out or same guest may again move to host CPU1 resulting in
> > VCPU migration sanitization.
> 
> void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
> {
>         unsigned long vmid;
> 
>         if (!kvm_riscv_gstage_vmid_bits() ||
>             vcpu->arch.last_exit_cpu == vcpu->cpu)
>                 return;
> 
> You're right that kvm_riscv_local_tlb_sanitize() can correctly detect a
> CPU migration via the above check. This check runs before
> kvm_riscv_vcpu_enter_exit(), so last_exit_cpu still holds the previous
> CPU and the migration case is properly handled.
> 
>         vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
>         kvm_riscv_local_hfence_gvma_vmid_all(vmid);
> 
> The XiangShan team seems to read the specification as not requiring
> HFENCE.GVMA to invalidate VS-stage TLB entries. Could you please point
> me to the exact wording in the RISC-V Privileged Specification that
> indicates otherwise? I would really appreciate the reference.
Oh, I found this in the specification:

Conceptually, an implementation might contain two address-translation
caches: one that maps guest virtual addresses to guest physical addresses,
and another that maps guest physical addresses to supervisor physical
addresses. HFENCE.GVMA need not flush the former cache, but it must flush
                                          ^^^^^^ ^^^^^
entries from the latter cache that match the HFENCE.GVMA’s address and
                 ^^^^^^ ^^^^^
VMID arguments.

This non-normative text describes two possible hardware designs, which
cause HFENCE.GVMA to behave differently:
 - In a two-cache design, stale VS-stage entries can remain after
HFENCE.GVMA.
 - In a single-cache design (GVA → SPA), HFENCE.GVMA will also clean up the
corresponding stale VS-stage entries.

> 
> > 
> > > 4. Later, the task is scheduled again while vcpu0 is running on host CPU1.
> > >    If the ASID is still valid and no deferred ASID rollover flush is pending,
> > >    set_mm_asid() may not issue any flush. The access on host CPU1 can then
> > >    hit the old VS-stage TLB entry.
> > 
> > See above comments.
> > 
> > >
> > > We hit this on a XiangShan RISC-V system. A bash task in the guest was
> > > scheduled on vcpu0 while that vCPU was running on host CPU1. A read-only
> > > page was prefetched and cached in CPU1's VS-stage TLB. Later the same vCPU
> > > migrated to host CPU0, the guest triggered COW and updated the mapping, and
> > > the guest still issued only a local sfence.vma. The stale VS-stage entry on
> > > CPU1 was not invalidated. After running for some time, the task later
> > > accessed that mapping while running on host CPU1 again and hit the stale
> > > translation. The data in that page was a pointer from the GOT, so it
> > > dereferenced to NULL and eventually caused a segmentation fault.
> > 
> > The above example is already taken care by TLB flushes in KVM RISC-V.
> > This smells like some HW errata to me.
> > 
> > >
> > > I checked current upstream RISC-V KVM (v7.0.2) and I do not see HSTATUS.VTVM
> > > being enabled, so guest sfence.vma is not trapped. I found
> > > kvm_riscv_local_tlb_sanitize() on host CPU migration, which handles G-stage
> > > VMID entries on the current host CPU, but I do not think it generally solves
> > > the stale VS-stage TLB case described above.
> > >
> > > I also noticed the vendor-specific kvm_riscv_vsstage_tlb_no_gpa path in
> > > current upstream. It looks like a workaround for a particular implementation
> > > issue on Andes AX66, where the VS-stage TLB does not cache guest physical
> > > address and VMID, so the normal VMID/GPA-based invalidation model is
> > > insufficient. In that sense, it does not seem to be a generic solution for
> > > guest sfence.vma coherence across vCPU migration.
> > >
> > > I am wondering what the right direction should be. Enabling HSTATUS.VTVM and
> > > trapping guest sfence.vma would allow KVM to translate guest local sfence.vma
> > > into the required host-side hfence.vvma, but that may be too heavy for the
> > > common case. Another possible direction may be to make the current
> > > Andes-specific vCPU migration flush logic more generic, so implementations
> > > that need VS-stage TLB sanitization on vCPU migration can opt in through a
> > > common mechanism. A third possibility may be to define a lightweight SBI
> > > interface for guest local sfence.vma, so Linux could use it in
> > > __flush_tlb_range() for the local case when running under KVM, and KVM could
> > > then decide whether a local sfence.vma is sufficient or whether host-side
> > > hfence.vvma is also needed.
> > 
> > Enabling HSTATUS.VTVM has a big impact on performance so certainly
> > NACK from myside.
> > 
> > >
> > > My questions are:
> > > 1. Is the behavior above expected on current RISC-V KVM?
> > 
> > Yes, it should work fine unless there is some HW bug.
> > 
> > > 2. If not, what would be the preferred fix direction?
> > > 3. Should this be handled by trapping guest sfence.vma with VTVM, by
> > >    generalizing the existing vCPU-migration VS-stage TLB flush logic, or by
> > >    adding a lighter SBI-mediated path for guest local sfence.vma?
> > > 4. Or is there another intended mechanism to keep VS-stage TLB state coherent
> > >    across vCPU migration?
> > >
> > > If needed, I can send a reproducer and the exact hardware/kernel details.
> > >
> > 
> > Even if you share some reporducing code sequence, we still have don't
> > have access to your HW so it won't help much.
> > 
> > Regards,
> > Anup
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
