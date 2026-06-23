Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681321CC5A
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207216; cv=none; b=JgpCVORt9N/rP1d7ChqvaOErgQuOY/pnG1l5QqhqNYnKT7MgcUfL1iL5AvHnpNaOzhGTfZISD4+o90r0b2e+N45MZ3EDx5k1C9egIy47mB9SEUKfj4vxXch4I/qpQI3egnsURT1OYC/av4E0X/S2GRGJjuHP32MsfaEsuACAQ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207216; c=relaxed/simple;
	bh=1b7BXu7Co9ggmh31T5fMXny31EQ9XMHROhWx2Ot9xiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p0ad8WpneZxfwUgXMnJh02xjQgo4vqF/lJPBgrlJ1+Gq8aMl5FPvlV84BH3XspCC09rFgBQ7lSGLro3FSAiYEakhsDalhTzB1cwtimsomxssKzIVpe1zpLNtZ5eD6y5GrbpPXPmp+g90QmLZpWB5IcMXRuTJN3CKIOK1Mx9DtCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwNb+Ms5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwNb+Ms5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1F91F00A3A;
	Tue, 23 Jun 2026 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782207215;
	bh=l/hYpcZd5N9RyEd9g0BO46ukdpO9LCsyKjoUgwHd/6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cwNb+Ms5KFGTFo2zLQtx2j00hL7joX/rif+rti4JMhwtxfLity2El8KCareUWwC2t
	 KvpCsW9/zfeXvIZlh+6rSYzDoyliMOX85uXA1NVpZTmdZZ4Rv5QoFmTmfs+ejWVToP
	 wpaGI3KTG+e9G7UuTmrbkfdyS1LK9VBrcWbo0FI6Nlqrr95+m13psOwH3zzWfGppCG
	 9/xyh9QcESaVGkqcLpakCs8ylqqYAKCkttPJjhrHA12k1qC6Ffrn5xdGeg2j2zt07S
	 I/A7iz/P6QMZZS3yfQAzjm8lhJ+WFhVYnF4fD7hiEUQOdGy0fNR4bQY0qnJZlaFjr8
	 ZWlUxWum1JTWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] kvm: sev: Acquire a writeable page reference for
 CPUID pages
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260623091556.1500930-5-joro@8bytes.org>
References: <20260623091556.1500930-1-joro@8bytes.org>
 <20260623091556.1500930-5-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:33:34 +0000
Message-Id: <20260623093335.3C1F91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incorrect unmap order for `kmap_local` mappings in the CPUID e=
rror reporting path leads to host kernel crashes.
- [High] Missing dirty tracking for user pages modified by the kernel, lead=
ing to potential silent data loss.
- [High] Data race and Use-After-Free on `kvm_memory_slot` between memslot =
teardown and `kvm_gmem_error_folio`.
--

commit 53ff0fbc410035f0e257e032a520eacbc8269a5c
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: sev: Acquire a writeable page reference for CPUID pages

When the PSP checks on a user-provided CPUID page fail KVM will write
back the detailed error information to the user-provided buffer.

Make sure this buffer is actually writable to not write the errors to
a read-only page.

Fixes: 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populatin=
g guest memory")
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2415,6 +2415,7 @@ static int snp_launch_update(struct kvm *kvm, struc=
t kvm_sev_cmd *argp)
>  	struct kvm_memory_slot *memslot;
>  	long npages, count;
>  	void __user *src;
> +	int write;
> =20
>  	if (!sev_snp_guest(kvm) || !sev->snp_context)
>  		return -EINVAL;

[ ... ]

> @@ -2475,7 +2476,10 @@ static int snp_launch_update(struct kvm *kvm, stru=
ct kvm_sev_cmd *argp)
>  	sev_populate_args.sev_fd =3D argp->sev_fd;
>  	sev_populate_args.type =3D params.type;
> =20
> -	count =3D kvm_gmem_populate(kvm, params.gfn_start, src, npages, 0,
> +	/* Acquire a write-reference for CPUID pages as kernel might write to i=
t */
> +	write =3D params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_CPUID;
> +
> +	count =3D kvm_gmem_populate(kvm, params.gfn_start, src, npages, write,
>  				  sev_gmem_post_populate, &sev_populate_args);

[Severity: High]
This isn't a bug introduced by this patch, but does kvm_gmem_populate()
handle dirtying the page correctly after sev_gmem_post_populate() modifies =
it?

When a user-provided CPUID page triggers SEV_RET_INVALID_PARAM, the error
path modifies the page directly via memcpy():

arch/x86/kvm/svm/sev.c:sev_gmem_post_populate() {
    ...
    memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);
    ...
}

Since this bypasses hardware PTE dirty tracking, and kvm_gmem_populate()
releases the page without marking it dirty:

virt/kvm/guest_memfd.c:kvm_gmem_populate() {
    ...
    if (src_page)
        put_page(src_page);
    ...
}

Could this result in the userspace VMM permanently losing the error details=
 if
the memory is file-backed or pushed to swap and discarded without writeback?


[Severity: Critical]
This is a pre-existing issue, but does sev_gmem_post_populate() unmap pages
in the correct order?

If __sev_issue_cmd() fails, it maps src_vaddr and dst_vaddr, but appears to
unmap them in FIFO order:

arch/x86/kvm/svm/sev.c:sev_gmem_post_populate() {
    ...
    kunmap_local(src_vaddr);
    kunmap_local(dst_vaddr);
    ...
}

Since the kmap_local API strictly requires LIFO unmapping, could an untrust=
ed
VMM intentionally passing an invalid CPUID page trigger a host kernel crash=
 or
corrupt the per-CPU kmap_ctrl stack?


[Severity: High]
This is a pre-existing issue, but is there a data race and use-after-free
risk on kvm_memory_slot between memslot teardown and kvm_gmem_error_folio()?

When KVM destroys a memslot, kvm_gmem_unbind() fast-paths the teardown if
there is no file:

virt/kvm/guest_memfd.c:kvm_gmem_unbind() {
    if (!file) {
        __kvm_gmem_unbind(slot, slot->gmem.file->private_data);
        return;
    }
    ...
}

This deliberately skips acquiring filemap_invalidate_lock(file->f_mapping).

If a hardware memory failure concurrently triggers kvm_gmem_error_folio(),
it iterates over f->bindings holding only filemap_invalidate_lock_shared().

Because xa_for_each_range() drops the internal RCU lock for each element,
could it yield the slot pointer right as kvm_gmem_unbind() completes and
frees it, leading to a dereference of freed memory here?

virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_begin() {
    ...
    .start =3D slot->base_gfn + max(pgoff, start) - pgoff,
    ...
}

>  	if (count < 0) {
>  		argp->error =3D sev_populate_args.fw_error;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623091556.1500=
930-1-joro@8bytes.org?part=3D4
