Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73A352C4F
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683604; cv=none; b=oLa2K8zpWKsMVfMf7BSAH+quM1zpJLX18tAYsKEUIMGEJ2DVEXEXRnFbHZPk9aICmdbyDaZnPdASFgsEo1zLX03XtLrdTSw1p77DBsWpLsp3Z6s8hZRwIhqm2mU0UCt9a742bAYViCZ2Dl4O6D7oBpGAxV0+ku+oEM7He4uKhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683604; c=relaxed/simple;
	bh=kQ3dV7FMIc12TN162fMRDc04PuIlvUYzuO79ZYptJ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBXRDS+pWG6LXgPAOmh4lKj3KiGD4YnrmHeDktHEEIJt/xE/DLbGNNLHMmhMKZm1hAT+sClR1ZawIdgtDD+ScEXgtF5mmas11NNwFY5lDpeOqahonGauYVHN22S49e3q2CrjDS8XrVeg0dcnMNc1YI42Bc8JCEQE3Sz8/b1iiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LWYoVxIi; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LWYoVxIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ZDeG3Pa9K+/Fl/S5AX9eRyV/HueefFNcPnhWOe87tic=;
	b=LWYoVxIix5Z7dM0UOK0xxAtiqJQvZGVIdoxaQ6TgvgBtTT8/sM2EWyhTXPbzpT
	xxcP2E/BoGTGgxg5Z5xpzA4hPtruSszy/BDs3Y/q8xM8nXw6ke807Zv9HHX5LErB
	ogZXz4XRnowjgPVU0iJoa7hpBuvkIpIJSYUnZinzNlWow=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnkyA5HGBqypXSIQ--.58947S2;
	Wed, 22 Jul 2026 09:26:17 +0800 (CST)
Date: Wed, 22 Jul 2026 09:26:17 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Hao Zhang <hao_zhang_kdev@163.com>, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: Re: [PATCH v3] KVM: x86: Mark nested RSM-created VM-Enter as
 untrusted
Message-ID: <amAcObySFW2LOtXH@192.168.1.215>
References: <al8wZQwqC9IhlBZc@192.168.1.215>
 <al-SKXoha-dqz047@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <al-SKXoha-dqz047@google.com>
X-CM-TRANSID:PygvCgDnkyA5HGBqypXSIQ--.58947S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr4fJFW5Gry8Xr4ktrW5Wrg_yoWxAFy5p3
	43trZ0kr4kJFyxZFyxJr48tFyS9r4Iv3WUX39xGryrZFyUGFn3JF18K3y5A398KrWrWryI
	vF4DurWUKw45Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pReWl9UUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+hrHumpgHDqXMQAA3X

On Tue, Jul 21, 2026, Sean Christopherson wrote:
> On Tue, Jul 21, 2026, Hao Zhang wrote:
> > From: Hao Zhang <zhanghao1@kylinos.cn>
> > 
> > RSM can restore state that indicates the vCPU was running L2 when SMI
> > arrived.  KVM then re-enters nested guest mode and marks nested_run_pending
> > so that the next KVM_RUN completes the pending nested transition.
> > 
> > Unlike a normal nested VMLAUNCH/VMRESUME, the state restored by RSM comes
> > from SMRAM.  Userspace can modify SMRAM before RSM.  The resulting L2 state
> > may require invalid-guest-state emulation.  If KVM trusts that pending run,
> > VMX can synthesize EXIT_REASON_INVALID_STATE before hardware VM-Entry
> > completes the pending run and trip the nested_run_pending invariant.
> > 
> > Do not treat an RSM-created pending nested run as KVM-trusted state.  Mark
> > the run as KVM_NESTED_RUN_PENDING_UNTRUSTED for both VMX and SVM, matching
> > the existing userspace-modified-state handling in kvm_x86_vcpu_pre_run().
> > 
> > Keep the VMX BUG check for trusted pending nested VM-Enters, but allow
> > untrusted pending state to reach the existing invalid-L2-state handling.
> > If that handling synthesizes a nested VM-Exit back to L1, retain the
> > pending state while synchronizing VMCS02 to VMCS12, and consume it before
> > restoring L1 state so that the flag does not leak into L1 and block event
> > injection.
> > 
> > Fixes: 2bb8cafea80b ("KVM: vVMX: signal failure for nested VMEntry if emulation_required")
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> > ---
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index cc75feec05da..cf5c3f78ebfc 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6715,12 +6715,14 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
> >  		return 0;
> >  
> >  	/*
> > -	 * KVM should never reach this point with a pending nested VM-Enter.
> > -	 * More specifically, short-circuiting VM-Entry to emulate L2 due to
> > -	 * invalid guest state should never happen as that means KVM knowingly
> > -	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
> > -	 */
> > -	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
> > +	 * KVM should never reach this point with a trusted pending nested
> > +	 * VM-Enter.  Short-circuiting VM-Entry to emulate L2 due to invalid
> > +	 * guest state after a normal nested VM-Enter would mean KVM knowingly
> > +	 * allowed an invalid vmcs12.  Pending VM-Enters restored from untrusted
> > +	 * state are handled below.
> > +	 */
> > +	if (KVM_BUG_ON(vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING,
> > +		       vcpu->kvm))
> 
> Ugh, I missed that my suggestion would require adjusting this KVM_BUG_ON().
> That's not the end of the world, but it's not great either because it further
> degrades the sanity checks provided by nested_run_pending.
> 
> And while Sashiko was hallucinating wildly with respect to a "mailicious L2
> modifying SMRAM", Sashiko did have a point about leaving nested_run_pending set
> beyond the emulated RSM.  KVM really should check for the impossible state after
> loading vCPU state from SMRAM in emulator_leave_smm(), so that forcibly leaving
> nested mode to synthesize TRIPLE_FAULT into L1 naturally Just Works.
> 
> The only reason I didn't suggest that is because I didn't want to add another
> SMM-specific kvm_x86_ops hook, but I think we can avoid that and (arguably)
> improve other paths at the same time.
> 
> Rather than provide a generic .vcpu_pre_run() hook, which is somewhat confusing
> because SVM has it's own pre_svm_run(), what if we provide separate hooks for
> unhandleable_emulation_required() and vcpu_needs_initialization()?  That bleeds
> some vendor specific details into common x86, but in many ways, that's a _good_
> thing in this case because I think it's helpful to highlight the need for
> additional initialization for CoCo vCPUs.
> 
> Do you happen to have a reproducer I can test?  Either way, I'll try to add a
> testcase to tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c to
> cover the SMRAM => RSM path.
> 

I don't have a standalone C reproducer, but I do have the syzkaller program
that hit the original WARNING.  It uses syz_kvm_setup_cpu$x86 and includes the
RSM path; I used it via syz-repro against the original crash bucket.

The repro seed is below.  It is not yet converted into a KVM selftest, but it
should be useful as a starting point for the SMRAM => RSM coverage in
vmx_invalid_nested_guest_state.c.

r0 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000000), 0x2, 0x0)
r1 = ioctl$KVM_CREATE_VM(r0, 0xae01, 0x0)
r2 = ioctl$KVM_CREATE_VCPU(r1, 0xae41, 0x1)
syz_kvm_setup_cpu$x86(r1, r2, &(0x7f0000000000/0x18000)=nil, &(0x7f0000000080)=[@text64={0x40, 0x0}], 0x1, 0x54, 0x0, 0x0)
madvise(&(0x7f000010c000/0xe000)=nil, 0xe000, 0x66)
ioctl$KVM_RUN(r2, 0xae80, 0x0)
r3 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000000), 0x2, 0x0)
r4 = ioctl$KVM_CREATE_VM(r3, 0xae01, 0x0)
r5 = ioctl$KVM_CREATE_VCPU(r4, 0xae41, 0x0)
syz_kvm_setup_cpu$x86(r4, r5, &(0x7f0000000000/0x18000)=nil, &(0x7f0000000080)=[@text32={0x20, &(0x7f0000000180)="6526f30f09660faade7e07b805000000b9ce8400000f01c1dd5d140f00d4ea000000008600440f20c03504000000440f22c0360f01d10f07", 0x38}], 0x1, 0x20, 0x0, 0x0)
syz_kvm_setup_cpu$x86(r1, r2, &(0x7f0000d9e000/0x18000)=nil, &(0x7f00000001c0)=[@text32={0x20, &(0x7f0000000240)="66ba4000edb8cd0000000f23d00f21f835100000020f23f8b99f0b00000f32dd1f66ba6100ec670f00d3b9800000c00f3235000100000f30c4e2e19274b900b9800000c00f3235008000000f3026650fc76c5589", 0x54}], 0x1, 0x8, &(0x7f0000000200)=[@cstype0={0x4, 0x8}], 0x1)
r6 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000080), 0x0, 0x0)
r7 = ioctl$KVM_CREATE_VM(r6, 0xae01, 0x0)
r8 = ioctl$KVM_CREATE_VCPU(r7, 0xae41, 0x0)
syz_kvm_setup_cpu$x86(r7, r8, &(0x7f0000fe1000/0x18000)=nil, &(0x7f0000000040)=[@text64={0x40, &(0x7f00000000c0)="0f6f2848b802000000000000000f23d80f21f835c00000b00f23f8470f220240a6dae9643644a5410f01c80f0fb500800000aeb9cb020000b851320000ba000000000f300f006b00", 0x48}], 0x1, 0x51, 0x0, 0x0)
ioctl$KVM_RUN(r8, 0xae80, 0x0)
syz_kvm_setup_cpu$x86(r1, r2, &(0x7f0000fe5000/0x18000)=nil, &(0x7f00000002c0)=[@textreal={0x8, 0x0}], 0x1, 0x22, 0x0, 0x0)
ioctl$KVM_RUN(r2, 0xae80, 0x0)

--
Thanks,
Hao

