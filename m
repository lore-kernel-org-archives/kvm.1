Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6147AF56
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936568; cv=none; b=DIkd0LA9OXs+nb0/BDJYoDxbUVYNmRa8cD/wQQjd+EAb6ZxSfLNX89oMPskkuzjvLl3Wqr7biBzYZj6zS8H9OL7u70hkUZ0FwZyF3OZHaYGF3bVmUg7kzxOlMv/hmyGHD9vioYxjrVcaPbkFgFSU+Xxiqi/JoOkr45vr3mcnnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936568; c=relaxed/simple;
	bh=gSQsdKqRxlPFD27O0hzPqHzC55Q1HhAp6Y1Myq35tXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqNKD7GdPjB0Bl3tSUFUVER+2yhQSSwWU/DmDKMgftJnUD15jeYNYweMqNIno7VfnPYenHF9QsArxy8Frljd4byySg/ZYSfpWOE0nbn2pMLnDx/zf0hhPmh+fUrwYL/GIV82i1j5D4ySCcZbD1Q2v/68vqmLs87v2XmKiZknC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atZOxVyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atZOxVyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE95D1F00A3E
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 23:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784936564;
	bh=E4DylxVQgQIDI8iVbv9cXjLus3Rn/u6mG02HzQir6yk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=atZOxVyta9ckhOAwyEwTPE5lDxePrxs+15yM8Or7niHpsYrI972TeZ0baezIXm5o1
	 ur5SgwBq/11J8SUkwkPC9DA0Db7IifGbUOaOdLwg7kDnrSdkngyy0bw1z4lWia3Ocy
	 5E4eueB1TeHzuREGue3o9nIaSxUpWy7Yeo8dKktsXL+mb4VWSpRMakKETuVNiJRU4i
	 qM4W++WWwNpi3jIeAsAPB4ku0+cKl6uLDk837L6vvoVwE4fnkB1z+pJYzd22YwaBdd
	 WtypHtb+E8Mc6fSc3XVgdocru+pOYGHnMUTxLBg80wZzB6mrtaXkcukoNhxpUvOV2G
	 sRquTFj3cbUgg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6986287534eso1366986a12.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:42:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp6vBIrH16ko6tJ17uvGmL62l7oQIOY+sa5EOJhXTaRkIR3r8PHSxvMMx0KgwsXNILnrQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Ff5SO84epKNuIr+p69uaL7KE+D2/Cgp1kSFGTR7Uz34ob6Tn
	ymBYwGjA5wmlnlFKszgXOQRF/RRhNybNKMeiYuciCHX4dAwFPtDVLi8OK4Z8SDo6uCJWlVbPkqi
	wavG4mGK9RqfdofPvHjKvaldKkb7srgA=
X-Received: by 2002:a17:907:e1c7:20b0:c15:df6d:4b45 with SMTP id
 a640c23a62f3a-c1f1f027133mr8362266b.36.1784936563616; Fri, 24 Jul 2026
 16:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723094419.630204-1-pbonzini@redhat.com>
In-Reply-To: <20260723094419.630204-1-pbonzini@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 16:42:32 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com>
X-Gm-Features: AUfX_mxTcx12fGede82RbvO8BeWhFRS-eSl4qskYhc1u-XQBrhVY3KJYFnVdZiM
Message-ID: <CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Lougovski <alougovsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:44=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Red Hat is seeing multiple reports of Windows memory corruptions
> (and consequent BSODs) with hv-tlbflush=3Don, on AMD processors only.
> The crashes, while extremely rare, happen even with a stock configuration=
,
> but with Driver Verifier enabled they can be detected after approximately
> 200 VM hours.  In particular, Alexander Lougovski measured the following:
>
> - on AMD Turin, 15 crashes in 3300 VM hours
>
> - on AMD Milan, 2 crashes in 500 VM hours (there are fewer hours
>   here due to the host being smaller)
>
> - on Intel Sapphire Rapids, 0 crashes in 8000 VM hours
>
> - on AMD Turin with full TLB flush (not exactly this patch but
>   similar), no crashes in ~2 weeks of run time which should also
>   be ~7000 VM hours
>
> For Turin, the microcode version was 0x0b002162, which (assuming
> this is the same issue) should not be affected by the problem listed in
> https://knowledge.broadcom.com/external/article/419026/bsod-on-virtual-ma=
chines-running-on-amd.html;
> on the other hand that problem should not apply to earlier processors.
> AMD has not provided any information or analysis yet, and when we asked
> we didn't know yet that it reproduced on Milan as well.
>
> As to the workload, Alexander threw more or less everything at the same
> time at the VM:
>
> - a full Windows Defender scan every 30 minutes
>
> - a disk I/O job
>
> - a loop doing repeated mmap of system files (mostly to hope that
>   it triggers some consistency check in the Windows memory manager)
>
> - SQL Express 2022 + StressDB (1.6M rows), with the host doing queries
>   (75% write/25% read) via sqlcmd
>
> Driver Verifier is able to detect BSODs more or less at the same time as
> the pages are freed.  They mostly happen in the Windows Defender filter
> driver, but occasionally also in the networking stack (e.g., afd.sys)
> or elsewhere in the filesystem stack (e.g., fltmgr.sys).
>
> The flush is issued from kvm_hv_vcpu_flush_tlb(), which receives the
> cross-CPU requests from the Hyper-V TLB flush hypercalls via a kfifo
> and is invoked by the KVM_REQ_HV_TLB_FLUSH request.  The mechanism is
> the same for both Intel and AMD, and the handler for both vendors is
> a simple INVVPID(ADDR)/INVLPGA instruction.
>
> Because the request is handled on the destination CPU, there is a questio=
n
> of what happens if the VM is migrated across physical CPUs.  In that case=
,
> the INVLPGA instruction would use a stale svm->vmcb->control.asid; but
> if anything that might do an *unnecessary* flush (on an asid that's being
> used for another VM) and then pre_svm_run() would force a full TLB rebuil=
d.
>
> So, for lack of better ideas, this patch forces a full ASID bump in
> svm_flush_tlb_gva().  To avoid paying the price on Intel and also to
> avoid unnecessary loops on AMD, the flush_tlb_gva op now returns whether
> it did a full flush or not; kvm_hv_vcpu_flush_tlb() takes note and exits
> its loops immediately.  While there is an obvious performance impact,
> about half of the benefit from Hyper-V tlbflush is preserved (10% vs. 20%
> on the SQL Server workload).
>
> kvm_mmu_invalidate_addr() is the only other caller of the flush_tlb_gva o=
p.
> The change would have a performance impact on every intercepted INVLPG an=
d,
> for nested SVM, on every L1 INVLPGA.  For INVLPGA specifically, this cove=
rs
> the same suspected issue but for nested hypervisors, so it is correct to
> apply the workaround; for INVLPG on shadow paging, instead, the impact
> would be stronger and, due to lack of data, for now the use of INVLPGA is
> left in place in svm_flush_tlb_gva().
>
> Analyzed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Analyzed-by: Alexander Lougovski <alougovsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[..]
> +static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva, bool *fu=
ll)
> +{
> +       struct vcpu_svm *svm =3D to_svm(vcpu);
> +
> +       /*
> +        * INVLPGA has had errata on Genoa and Turin, and even on older
> +        * generations there were reports of Windows BSODs if INVLPGA
> +        * was used for Hyper-V tlbflush.  Use it only for shadow paging
> +        * where it seems to be okay.

Is this an actual errata documented by AMD, or is this just an
empirical observation?

I ask because the APM says:
---
The input address is always interpreted as a guest virtual address, so
INVLPGA is typically meaningful only when used with shadow page
tables; it does not provide a means to invalidate a nested translation
by guest physical address
---

While this is terrible wording, it seems like KVM should *not* be
using INVLPGA when TDP is enabled. Looks like
kvm_mmu_invalidate_addr() might be doing the right thing, but it seems
like kvm_hv_vcpu_flush_tlb() shouldn't be calling flush_tlb_gva() with
TDP enabled to begin with, at least on AMD?

I don't have enough context about what kvm_hv_vcpu_flush_tlb() is
doing to know if flush_tlb_gva() makes sense on Intel. But at least on
AMD, looks like it should always just do a full ASID flush (since it
falls back to a full flush with TDP disabled anyway)?

So maybe something like:

int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
{
       ...
       if (AMD CPU)
              goto out_flush_all;
       ...
}


I also love Sean's idea, I think it's good to harden against this by
nullifying flush_tlb_gva, and maybe add a helper that does the
fallback:

static void kvm_vcpu_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
{
       if (kvm_x86_ops.flush_tlb_gva)
              kvm_x86_call(flush_tlb_gva)(vcpu, addr);
       else
              kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
}

Hmm actually we check KVM_REQ_TLB_FLUSH_GUEST before
KVM_REQ_HV_TLB_FLUSH, so maybe just call kvm_vcpu_flush_tlb_guest()
directly for the fallback:

static void kvm_vcpu_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
{
       if (kvm_x86_ops.flush_tlb_gva)
              kvm_x86_call(flush_tlb_gva)(vcpu, addr);
       else
              kvm_vcpu_flush_tlb_guest(vcpu);
}

And if we go this route, I think we can key off the presence of
flush_tlb_gva in kvm_hv_vcpu_flush_tlb() instead of checking for an
AMD CPU. We can probably break it down into a stable-friendly fix that
just jumps to out_flush_all on AMD CPUs, then the hardening on top.
