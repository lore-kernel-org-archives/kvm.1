Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707863859F3
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227243; cv=none; b=kPnYdm25xTpc8CEyL7mwCNISVmXOZOIOmKAJ67vtBO0KSt3H+p2KnyNCYpd+cYkMH88Jp3HXLl8q/bLb5Y0Gjk/UJLax4A6yHj6hY1xvOB3f8MWZmzK/EQ7sGwGJBeANZTjf4Q3MO3QUAe1B/adueJp9OtSWY1vQCrW3FSGt83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227243; c=relaxed/simple;
	bh=0FRkHr5cfGUxhseN4HRI/EO1/gUn5h5UMAEf11ZlENc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZA9IWSQx0MmiBsSEMYHC/is4aKetzOw0mVmVmtZLUXrM3t0P3f6ZWgMmIVKos3OLw8JPh/Jqks+wVwG2Q6souD1CTFo25VtGAuPbNzkNpWiD+q00s3CO4K0ZwywractTnqAcUZMzElJw8wH5oHBcVPo4vFsKgelVmwAbugVX9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmSPkfXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmSPkfXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79711F000E9;
	Thu, 16 Jul 2026 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227242;
	bh=XA5z9BF7BPURecDveh7ZmG0BLqiV8EXR1bLuHFICwJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LmSPkfXOmatlSktN1L0XQy9I0CIsirJ9GwoLQ1GW8QMBy2HZD5WulY1ZqjifyizSt
	 lyVi4QrUG5cUtt6M3fzs5NRk+5Yns/xHm0wezgXdsSCAaBpRQOC1cic9oIXe8PlxqE
	 n058WnKZqdb5ocflhohp386hylFx67pP0grSYDLCdvmWlrNQYyi/690pPfsGQ3MY9G
	 l7L+Ky/FGuUUFnip7g7Xt+7/5Ko9Qq+Q/Q1JThJljoAxZwvixeLxGGNltq+VLULBAD
	 29ja3ybKpUG6P7gUHlsZLX0E5ApmyzZo5y2hdBalQG/HB+4NuQMZus4THJ8ka11z/x
	 /EcBHGLcZf77Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/24] KVM: x86/mmu: Do not update accessed/dirty if
 guest PTE is read-only
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-20-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-20-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:40:41 +0000
Message-Id: <20260716184041.D79711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Silently skipping Accessed/Dirty (A/D) bit updates for guest page =
tables protected by read-only memory attributes allows KVM to map writable =
SPTEs without updating the guest's dirty bit, causing silent data corruptio=
n in the guest OS.
- [High] When a guest page table walk fails due to a memory attribute read =
fault, KVM incorrectly reports the original instruction's access type (writ=
e/exec) to userspace instead of reporting a read fault on the page table.
- [High] KVM injects a fatal guest Page Fault instead of exiting to userspa=
ce when an emulated instruction's page table walk hits a memory attribute r=
ead fault.
--

--- Patch [19]: [PATCH 19/24] KVM: x86/mmu: Do not update accessed/dirty if=
 guest PTE is read-only ---
commit 0ad73786bede76212593913d2d0fa39e55055d34
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86/mmu: Do not update accessed/dirty if guest PTE is read-only
   =20
This commit modifies the guest page table walk in KVM's x86 MMU to check if
the guest page table's physical address is writable according to KVM memory
attributes. If not, it marks the PTE as not writable in the guest walker.
This appears to be an optimization to avoid exiting to userspace when guest
page tables are mapped read-only.

> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 23d7a7d9769fe..ee5c23d1b77a8 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -419,6 +419,9 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
>  			goto error;
>  		}
> =20
> +		if (!kvm_mem_attributes_may_write_gfn(vcpu->kvm, gpa_to_gfn(real_gpa)))
> +			walker->pte_writable[walker->level - 1] =3D false;
> +

[Severity: High]
Does this silently skip Accessed/Dirty (A/D) bit updates for guest page
tables?

When the VMM sets a page table's GPA as read-only via KVM memory attributes,
this sets pte_writable to false. Later, FNAME(update_accessed_dirty_bits)()
uses this flag to handle read-only ROM slots:

		if (unlikely(!walker->pte_writable[level - 1]))
			continue;

Since FNAME(update_accessed_dirty_bits)() reports success by returning 0, K=
VM
will proceed to map the leaf page as writable in the shadow page table (SPT=
E).

Could this lead to silent data corruption in the guest OS, since it can then
write to the page without faulting while its own page table is never update=
d?


[Severity: High]
Does KVM report the incorrect access flags to the VMM when a page table walk
fails due to a memory attribute read fault?

In FNAME(page_fault)(), KVM prepares the exit using fault->gfn =3D walker.g=
fn
but passes the original fault object:

		if (walker.memory_attributes_fault) {
			fault->gfn =3D walker.gfn;
			kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
			return -EFAULT;
		}

This passes the write/exec flags of the instruction attempting to access the
leaf page, rather than the KVM page walker's read access to the guest page
table. Could this confuse the VMM's fault handling logic?


[Severity: High]
Is the memory attribute read fault correctly handled by the instruction
emulator?

When FNAME(walk_addr_generic)() encounters a page table mapped as unreadabl=
e,
it sets walker.memory_attributes_fault =3D true and populates a synthetic #=
PF in
walker.fault.

In FNAME(gva_to_gpa)():

	r =3D FNAME(walk_addr_generic)(&walker, vcpu, w, addr, access);

	if (r) {
		gpa =3D gfn_to_gpa(walker.gfn);
		gpa |=3D addr & ~PAGE_MASK;
	} else if (exception)
		*exception =3D walker.fault;

The memory_attributes_fault flag is ignored, and the synthetic #PF is bubbl=
ed
up to the emulator, which will blindly inject it into the guest.=20

Should this trigger a KVM_EXIT_MEMORY_FAULT instead of injecting a fatal gu=
est
page fault?

>  		ptep_user =3D (pt_element_t __user *)((void *)host_addr + offset);
>  		if (unlikely(get_user(pte, ptep_user)))
>  			goto error;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D19
