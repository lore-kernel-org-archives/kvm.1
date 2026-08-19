Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645A3BFE4F
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152807; cv=none; b=TyCH7pUKHD87AkP+ICxIpNvYWNVxdVXNP7VD7Nfs+yZ3uSCnoy5EbPOl4+BGRbGYeHrdSNRFkld0f5gVY/FcUsBsjfIGRERRTmdJoRepQcd9TwoY9Fq6I2ruaM3WzMfQBu2sgrrMDWLAFnDuR8rr0737eDKkc243nMdtooSlR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152807; c=relaxed/simple;
	bh=VwLovuvvNg6P60xPTLzzykQ0hYRx+IExxF7jqVLD/aU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l+05MUThJiObxR2sh7rd/kYgT2SHXr2l9/2w3swKkwp2Skk8zxANRQf/rxfqHIIxyuruNwcKKgD0xT7RR9LuuMXaNUssMs3s+9L8UCev1e1iIL1jy6Me6FpY4PmtcH4O4E8U7aIgUoahqNIwzPAB+Yd8hA/sWejuun45ih5UxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWgm7rO3; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWgm7rO3"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84870e7f498so1074986b3a.3
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787152805; x=1787757605; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=treBtxFhVA0yeZTvhfGYc5TmTsmiVdZChsOe1jV9/08=;
        b=oWgm7rO3Om7uQxndVxv1Chse+/hmS3wP2sih5IpAk4VxYrSMId8oMQ9D0ns+pDp8dA
         TM/RwTlGnuUsJeUENBKCcxsEG95BvppvIpwzOfcW4CO6Hv0KHluTkDy8dbHG50U7Q7wy
         sDLRhj+OC40YTX3rkSb9MfcvwEUz/Giq9Bp18aWl3Y2zPR0r0+aoAOcI2P5YvznU8Upn
         uI0538cPx9c0abDkL8NUiCTk5wbyYq4jE2qf8HeUo6GYfMDAUYs1edEQWIQlTOYUt6Vb
         jkx+Dr4ASvEinGD0/g/NBQmsGbTuL9tHTlxFI29jiM7gz1uRsuPNaLqqx4cLxJCT7K5/
         717g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152805; x=1787757605;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=treBtxFhVA0yeZTvhfGYc5TmTsmiVdZChsOe1jV9/08=;
        b=rIa1+CiQ9FXDtqGnQ6KXBggfgxpdDNcGSvNqxl9i5Hk2CWipKoWKP/U2j8U8z0xfHo
         qGoxwvJpSZi9tDnyWfVrl+79eAUy6RtIs1VhoYMpmj5Jqut7Bsiz6etx6whKucs/YjLy
         Xhf3SQqfD02MyxKC8qYmzI2G1tzm0KlJjCaJYYKJzojxD3mHUGpldYYbpZY3CyEBkShe
         Eoqi38ZcZ7QEcL0imdP3hJqpQ5WHZiZt8dsvSVn/p4LzwTfTAuZYEYGuz/QF+0o7WdTf
         rr2U9taCHYXs1fq2nPL1atr4mXWW2y69y1Fz/vf0j4QA0l86y8rX5OL0TKKqp3kfrgC0
         kuPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHDxiXeeQtWEUhqCjaGiFlLBwHVFuUTCsIp5gCDZbSAx5cbh6yhJQw48eWZE3Y1ye3aZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgzsxJPAMWB9uP/ZtPk0cYUtM7Zri/+0gl8UmgIyDFAFJMfZ5S
	Lue0csvKUdhzXL6t9J7j2e/iCJ9UdGRYcKewDmb8PVH6MRVLTQSqSGZs/qsPu61yCur1+obilQ/
	i7jVAZg==
X-Received: from pfbcg6.prod.google.com ([2002:a05:6a00:2906:b0:848:3f4b:c4da])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2995:b0:847:770f:da4c
 with SMTP id d2e1a72fcca58-851d39624d5mr9644194b3a.16.1787152805081; Wed, 19
 Aug 2026 08:20:05 -0700 (PDT)
Date: Wed, 19 Aug 2026 08:20:04 -0700
In-Reply-To: <aoW3fOhPuFY7Whia@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819034652.98938-1-duankeqiangcym@gmail.com> <aoW3fOhPuFY7Whia@intel.com>
Message-ID: <aoXJpPDqwu4IlmdX@google.com>
Subject: Re: [PATCH] KVM: VMX: Clear GUEST_ACTIVITY_STATE when userspace makes
 a vCPU RUNNABLE
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Keqiang Duan <duankeqiangcym@gmail.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 19, 2026, Chao Gao wrote:
> On Wed, Aug 19, 2026 at 11:46:52AM +0800, Keqiang Duan wrote:
> >Force a vCPU out of its hardware-tracked halted state when userspace
> >explicitly declares the vCPU RUNNABLE via KVM_SET_MP_STATE, i.e. clear
> >VMCS.GUEST_ACTIVITY_STATE if it says the vCPU is halted.  Add an optional
> >kvm_x86_ops hook to do the clearing, as SVM has no equivalent VMCB field.
> >
> >When HLT-exiting is disabled for a VM (KVM_CAP_X86_DISABLE_EXITS with
> >KVM_X86_DISABLE_EXITS_HLT, e.g. QEMU's "-overcommit cpu-pm=on"), a guest
> >HLT halts the physical CPU instead of exiting to KVM, and hardware saves
> >GUEST_ACTIVITY_STATE=HLT into the VMCS on the next VM-Exit.  That field is
> >sticky: it survives VM-Exit/VM-Enter and is only cleared by vmx_clear_hlt()
> >on event injection, or by vmx_vcpu_reset() on INIT / vCPU creation.
> >
> >Nothing clears it on a userspace-driven state change.  KVM_SET_REGS only
> >writes the software register cache and KVM_SET_MP_STATE only writes
> >vcpu->arch.mp_state; kvm_vcpu_running() likewise consults software state
> >only.  A VMM that emulates a machine reset therefore ends up with a vCPU
> >that KVM happily VM-Enters while hardware refuses to fetch instructions.
> >
> >Reproduce with a Linux guest by triggering a panic/kdump on a non-boot
> >vCPU: nmi_shootdown_cpus() parks the other vCPUs -- including vCPU0 -- in
> >crash_nmi_callback(), which does local_irq_disable() followed by a bare
> >HLT.  The capture kernel then resets the machine via port 0xCF9.  QEMU
> >rewrites RIP to 0xfff0 and sets mp_state to RUNNABLE, but vCPU0's
> >GUEST_ACTIVITY_STATE is still HLT, so the BSP never executes the reset
> >vector, never sends SIPIs, and the entire VM hangs at "reboot: machine
> >restart" forever.  Only destroying and recreating the VM recovers it.
> >
> >Clearing the state is always safe: waking from HLT is architecturally
> >permitted to be spurious, and every HLT in the kernel is inside a loop.
> >Hook KVM_SET_MP_STATE rather than the VM-Enter path so that the clearing
> >is driven by an explicit userspace declaration, and so that no work is
> >added to vmx_vcpu_run().
> >
> >Note, vmx_clear_hlt() loses its "static" qualifier as the kvm_x86_ops table
> >now lives in vmx/main.c.  TDX cannot disable HLT-exiting and KVM cannot
> >access a TD's VMCS, so vt_clear_hlt() short-circuits for TD vCPUs,
> >following the existing vt_*() wrapper pattern.
> >
> >Fixes: caa057a2cad6 ("KVM: X86: Provide a capability to disable HLT intercepts")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Keqiang Duan <duankeqiangcym@gmail.com>
> 
> There was an earlier attempt to fix this issue:
> 
> https://lore.kernel.org/kvm/20230630072612.1106705-1-aiqi.i7@bytedance.com
> 
> Sean suggested doing exactly this there, i.e. clearing the activity state in
> kvm_arch_vcpu_ioctl_set_mpstate() via a new kvm_x86_ops hook:
> 
> https://lore.kernel.org/kvm/ZMgIQ5m1jMSAogT4@google.com

Thanks Chao, I knew this sounded familiar!

As suggested in the above link, the call into vendor code should be gated on
kvm_hlt_in_guest().  Yes, vmx_clear_hlt() already does that, but it's a cheap
check and makes the common x86 code easier to understand.

The other difference between my suggestion and this patch is clearing HLT if and
only if the vCPU is being made RUNNABLE, versus clearing HLT if the vCPU is being
put into any state other than HALTED.  In practice it probably doesn't matter?

AP_RESET_HOLD is unsupported for VMX, SIPI_RECEIVED is deprecated and is now just
a variant off INIT_RECEIVED, and getting out of INIT_RECIEVED and UNINITIALIZED
requires stuffing RUNNABLE or going through vmx_vcpu_reset(), which explicitly
sets the activity state to GUEST_ACTIVITY_ACTIVE.

But I think my vote would still be to do:

	mp_state->mp_state != KVM_MP_STATE_HALTED

because I can't think of any reason not to?

Side topic, I think we should officially take an erratum in
Documentation/virt/kvm/x86/errata.rst to state that KVM doesn't support save/restore
of HLT state when HLT-exiting is disabled.  AFAIK, there's simply no sane solution
for SVM, and that would justify why the kvm_x86_ops would be clear_hlt() as opposed
to set_mp_state(), i.e. why KVM only handles taking vCPUs out of HLT, not putting
them into HLT.
