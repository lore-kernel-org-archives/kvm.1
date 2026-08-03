Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F3377ED7
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766949; cv=pass; b=LH4aHC7sBNAD3oq8WYtITVVWLU0NU49CJOGXAmFNilYx3VA6sC5b2Y5BswFN2YblXYO2AdfsM9Qz6d3bq9Log2g0JqasNL4+YA6hGLwaR2sIhZ825KFc7the3c3D3cVhvdJBvFYxKhsJbuJFhFPcjAoDIOqaIGix9f0Ou9UHS34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766949; c=relaxed/simple;
	bh=BnEgOQvG5N65DRQI21tX00Ztj1aK3tL2lBUHc1cQ/rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvQoZrjTUwb9W+YTlLMn4wnOxDmuUB03mXPoDHW5XVvj+LwrPrNkXKDWONzgDKCRFUb179fdI1lmAPsKR+DehWQstfE/sgEbfso6mnabfO7KcY9B6yq0sZzGr9l8c/t4tb84qI97PXQXv7lWncWY6/eK+515xYzucFKllV5AHTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=CG7Spmv1; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="CG7Spmv1"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f9ab7ee38so1785725f8f.2
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 07:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785766946; cv=none;
        d=google.com; s=arc-20260327;
        b=eIaO1uGgvhcpJ1V59GrtOh/lrw76r37GnOj0WUsQ/ZhgZj7NGl3mtKBSifD+eqvBS+
         BcoqFQ9vrTGkESaW9hNRQNHnNY19aRDsBlfQ5SvYxyxC9xNpQK71QLAAmim5VvDlZ8vd
         0AnjE23R1iZOMrOwB0e1uEEZ9+0l1a0W5njtO/3YVCRYBWiOo9SfLRgrK5nKwidenNqU
         7jQF9fmLbZrO7f7ds2D+Z7bHSrxtA4U7XkgyzXgWJFM0t/XewbBFS4refUSJkKigO7E9
         e5w4Nd7qtzaOOHgqfNG2gVeT7lD9x9Smep4sch5dXZF7VpvPZPMSWkVyjLtDLTcbyOBH
         5YoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nnW4RZTqOdHnNX2YCN/ivfsmi8KlSc6lQLWkmG08CIs=;
        fh=PLGOSCTkZZSBA0RJEpb70nza/CuIyRoDoy/6NABDy1s=;
        b=Mel0mZHsIk0WfJickkTq6XhvM6mU4FDN1HS//7rGmR+xWJIvVvlRAzA3Xaxa4Nor/Z
         8Is2zIZl1ejGeKjVKlBy9cvnObU+xKlxq2y2KCjbpNdEB6yoA/7aP7iWXq9wNT4AR7CL
         Wun+irQ6jk3IoAYfHDpJlMUOQ/sBxMsKu7OPLaopZ0ialg4uhYfDULVNkWHSi7bpQe8F
         0lm1TBDYMr1LM3Gmp9SIrCF2fzouRF9PBjARTJ6HcHHlommY1P9l/UHByOnKR5JTl9hT
         mf7tYHzTylnlIg44sUb7oPPY8Vzij6/9N3c/wuxDF4BVAfLuE1+Dyf2Y99ewlAetViJS
         aMjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1785766946; x=1786371746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nnW4RZTqOdHnNX2YCN/ivfsmi8KlSc6lQLWkmG08CIs=;
        b=CG7Spmv1vi9sHtVatdjUvU0qmUaaH0mFZOk/ysjYwHFTAQUONUwemjCPYBnxIX7z3A
         On4UttoH3kBc+n/mrDzC3X17KKUoEZbIM6oW5tNkO4iez6UpKdXn3gh+E5deBTYETUTL
         iOSSRovPY0Tl+OF94ivYa8DsVHhOD8/Cx7hnaj057/q9/FrmFQ5zI1H5QaXrCOvH04pG
         UfX+mzK94NCuaZ8RHHahClIopp7udt88SYlUsGHX3k3bZEyXvBYS+y4KH21itj/1OZ+e
         udwt4Sra8KtO/xK1tT1w7mIAO09fn+VNwbqb9GC1o1Y1S546f2EpIN/RcMg75gu7Meo7
         scXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766946; x=1786371746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nnW4RZTqOdHnNX2YCN/ivfsmi8KlSc6lQLWkmG08CIs=;
        b=c209llr/LTrYAyFXPgA7LOrBUkG5onCJeoc4yG18hqs4toc2IbzPrTNk5IavoXot7P
         wy7qWHJ5auuQ0PiwB94uc/ODxfimpsCsR1/JYIXKfwTtvua2AAmtFEfSQDVQEHC/ATiw
         t80tARgGlXo6qNdLu6EnhQZpMgi/S8yX0AtnfubtNKr6AIdpg0OjFPgHXe9qZ48Urw/B
         tr+1NUSAQOv0VJDvk+EXsEN2E6chUJWxQyHeVEWHtIl0IX931xvKTepi+uCkABxVhAfD
         VeWE9vCx+Sts1Iblhj35hXs+Iz9v/ZkDuHYbKm46mF/04g/0iHaZamvuTvf0WcE0KJrV
         LePQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHfXnR3GHV8XrSomaTHaVJnH737e9FL2/PVkmBhNZB5zk0Z6pGRv9pLWrSUJRSP5wgR7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkkXh71Gm5Ydk5Okwbzm0aSA5CPUfyzSvPsLj/mHfsL/Z6aqBl
	AyQo/xiIJYyB4hRkZrkiZW+f6j+0UbB7VwcLbmmHbJaFqD+POST0LuZbNeR0wjkJjohHsbYL4w5
	jRASfHjm6nQ8eI50ciV7CHmY+FCvXz+9rvPmkIBcQxQ==
X-Gm-Gg: AR+sD13qqcPSAw5vo490yKyOCxBV9Eyjve+SjZ0hBkoqe2kT32qCqGA8/MUMjSpF4Dx
	dj1uRDQ2CbxMUtI0fvu9vOH+bAecMbQ508e1eG7HXATe556gTV8fHjQLYzY7sOdQ2zwDQsNMhmQ
	ET6ZrnDevZaHfdZty/gKv5KtxlEU1ML7vEEaVKqUyZlIAW7JKdUAxe8aULUFyPUPXz2Mn3dR76h
	dMprjHGTLKyf1BxwuNaV1LM5thGm9yqAddRXW9A5li8jS3YaaTrAYIwhLdqfTg1+De/p3VZz5yI
	lFVl0MMNVsM/RsNfUU3IIH0CSRLOQz6XIKhbQ/NM2/Gh3u46+S8XE1wlaiWrnNZdXcl6kvMY/PG
	D7Apy6Q0KuJ3xjZEjeC6P9nywgWvG3ule+/ihoTScPqxh95OuT0vGwtBj7HrU0jjI
X-Received: by 2002:a05:6000:2209:b0:47f:9822:d99b with SMTP id
 ffacd0b85a97d-47fd7251edamr27970002f8f.0.1785766945662; Mon, 03 Aug 2026
 07:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802050015.104795-1-guoyaxing@bosc.ac.cn>
In-Reply-To: <20260802050015.104795-1-guoyaxing@bosc.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 3 Aug 2026 19:52:14 +0530
X-Gm-Features: AUfX_myXIqx2WOmWzoJ4yL_SBCfdvCijmO0NjkJNDBHMHzLnarxMlDom9ViiKt8
Message-ID: <CAAhSdy3QE6Fe_fanKOLHLjDCb+vsVax=wy18UxzR23XN7ggJGw@mail.gmail.com>
Subject: Re: [RFC] RISC-V KVM: guest local sfence.vma may miss stale VS-stage
 TLB after vCPU migration
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Hui Min Mina Chou <minachou@andestech.com>, majiuyue@bosc.ac.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 10:30=E2=80=AFAM Yaxing Guo <guoyaxing@bosc.ac.cn> w=
rote:
>
> Hi all,
>
> I would like to ask whether RISC-V KVM has a gap around guest sfence.vma
> and VS-stage TLB invalidation when a vCPU migrates across host CPUs.
>
> On bare metal, Linux uses mm_cpumask in __flush_tlb_range() to decide
> whether to send a local or remote sfence.vma. That works because the cpum=
ask
> reflects physical CPUs. In a guest, however, the kernel only sees vCPUs, =
so
> from the guest point of view a task may never "migrate" even though the
> underlying vCPU moved to a different host CPU. In other words, guest
> mm_cpumask is effectively a vCPU mask, not a host CPU mask.
>
> There is also a related switch_mm()/set_mm_asid() aspect. With the ASID
> allocator enabled, RISC-V Linux does not flush on every context switch. A
> local_flush_tlb_all() is only done when a deferred ASID rollover flush is
> pending for the current CPU. That is fine on bare metal, because previous
> shootdowns are also based on physical CPUs. In a guest, however, the earl=
ier
> shootdown may have been only a guest-local sfence.vma and may have missed=
 an
> old host CPU where the same vCPU ran previously.
>
> A simplified sequence is:
>
> 1. A guest task with mm A runs on vcpu0 while vcpu0 is scheduled on host
>    CPU1. CPU1 fills a VS-stage TLB entry for that mm/ASID.
> 2. vcpu0 migrates to host CPU0. KVM's vCPU migration sanitization is loca=
l
>    to the current host CPU, so it does not invalidate the VS-stage TLB en=
try
>    that was left on host CPU1.

When vcpu0 migrates to host CPU0, the host CPU0 may or may not have
VS-stage TLB entry so VCPU migration sanitization does the right thing.

In the future, vcpu0 may again move back to host CPU1 containing stale
VS-stage TLB entries left in step1 above so the VCPU migration sanitization
will cleanup these stale TLB enteries.

> 3. The guest later updates mm A's page table from vcpu0, for example due =
to
>    COW. Since the guest still sees mm A as having run only on guest CPU0,
>    __flush_tlb_range() can choose a local sfence.vma. That local sfence.v=
ma
>    only affects host CPU0, where vcpu0 is currently running, so the stale
>    VS-stage entry on host CPU1 remains.

No need to worry about stale VS-stage entry on host CPU1 because these
will age-out or same guest may again move to host CPU1 resulting in
VCPU migration sanitization.

> 4. Later, the task is scheduled again while vcpu0 is running on host CPU1=
.
>    If the ASID is still valid and no deferred ASID rollover flush is pend=
ing,
>    set_mm_asid() may not issue any flush. The access on host CPU1 can the=
n
>    hit the old VS-stage TLB entry.

See above comments.

>
> We hit this on a XiangShan RISC-V system. A bash task in the guest was
> scheduled on vcpu0 while that vCPU was running on host CPU1. A read-only
> page was prefetched and cached in CPU1's VS-stage TLB. Later the same vCP=
U
> migrated to host CPU0, the guest triggered COW and updated the mapping, a=
nd
> the guest still issued only a local sfence.vma. The stale VS-stage entry =
on
> CPU1 was not invalidated. After running for some time, the task later
> accessed that mapping while running on host CPU1 again and hit the stale
> translation. The data in that page was a pointer from the GOT, so it
> dereferenced to NULL and eventually caused a segmentation fault.

The above example is already taken care by TLB flushes in KVM RISC-V.
This smells like some HW errata to me.

>
> I checked current upstream RISC-V KVM (v7.0.2) and I do not see HSTATUS.V=
TVM
> being enabled, so guest sfence.vma is not trapped. I found
> kvm_riscv_local_tlb_sanitize() on host CPU migration, which handles G-sta=
ge
> VMID entries on the current host CPU, but I do not think it generally sol=
ves
> the stale VS-stage TLB case described above.
>
> I also noticed the vendor-specific kvm_riscv_vsstage_tlb_no_gpa path in
> current upstream. It looks like a workaround for a particular implementat=
ion
> issue on Andes AX66, where the VS-stage TLB does not cache guest physical
> address and VMID, so the normal VMID/GPA-based invalidation model is
> insufficient. In that sense, it does not seem to be a generic solution fo=
r
> guest sfence.vma coherence across vCPU migration.
>
> I am wondering what the right direction should be. Enabling HSTATUS.VTVM =
and
> trapping guest sfence.vma would allow KVM to translate guest local sfence=
.vma
> into the required host-side hfence.vvma, but that may be too heavy for th=
e
> common case. Another possible direction may be to make the current
> Andes-specific vCPU migration flush logic more generic, so implementation=
s
> that need VS-stage TLB sanitization on vCPU migration can opt in through =
a
> common mechanism. A third possibility may be to define a lightweight SBI
> interface for guest local sfence.vma, so Linux could use it in
> __flush_tlb_range() for the local case when running under KVM, and KVM co=
uld
> then decide whether a local sfence.vma is sufficient or whether host-side
> hfence.vvma is also needed.

Enabling HSTATUS.VTVM has a big impact on performance so certainly
NACK from myside.

>
> My questions are:
> 1. Is the behavior above expected on current RISC-V KVM?

Yes, it should work fine unless there is some HW bug.

> 2. If not, what would be the preferred fix direction?
> 3. Should this be handled by trapping guest sfence.vma with VTVM, by
>    generalizing the existing vCPU-migration VS-stage TLB flush logic, or =
by
>    adding a lighter SBI-mediated path for guest local sfence.vma?
> 4. Or is there another intended mechanism to keep VS-stage TLB state cohe=
rent
>    across vCPU migration?
>
> If needed, I can send a reproducer and the exact hardware/kernel details.
>

Even if you share some reporducing code sequence, we still have don't
have access to your HW so it won't help much.

Regards,
Anup
