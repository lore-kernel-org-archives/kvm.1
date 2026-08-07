Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3F38655C
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110985; cv=none; b=PxmeVUi7ptIo9JButDqQvV4yX61WeGJeTBPc/vCJPQOU4xj1RoLmSLvmreYaHay8OQgCoUYDmPbFue/qGY2Ct4YGzlp6cKYNm2lPuxxTn6OUwvbW6BJQprX9T8D0DxAWZRRtQTrrrU8qTtJixVdtzPQMbEJjwbSV43RI8rzs97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110985; c=relaxed/simple;
	bh=ZmH5Qk5yHlRf3tRlZYB3x8aw48MzqglALy4p1s4Q1BE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q2NLp/iq+KQ5i+MSbM3HRO6QjH9DxBYa+KVMc8kf/YZTNvJpmd+onNQXtjpHeVJxgqnomHdgA8JbKbeGYEfAlEobmVhVWdWwbS4bmoMezuEe6KD4ZYcYL160x5752zUdriYdUgChvhPfswjD3qNLAwXBGGUlWivtB/FbYGkTyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKZfZJ+0; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKZfZJ+0"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso2269144a12.0
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786110975; x=1786715775; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5Brd3fsBlkW7/lgwCn19iDGV7HYHFGxI21OU2HslXs=;
        b=SKZfZJ+0NWHEl3nRqF2WU+9QjVYoExM8dJGCJls+Rzh1k7GUTlo9P2yoFX2pm0spM7
         cA4FOCzRnZp+7kCgRgR3xt5ZAZCirlQSux5ePZxUos8kAbtip5HCWyrFR7Qjpg5xaK40
         CSyhdfHKObG4VJ9kOYrOUk4eImr4e7ruP2nGTpWvjpt8KnpvwAfiVBzqFkd9wj6q0xGg
         p/JQaCKd2CF+cZv1oeXQ0+C9mCeMSKwU9Zju/yfkdecm8q8xQS834766yzSn3f5b1j00
         uSpTqxNnArAl/OEg+PYcBZ8dbmiAqrFkIs0XqMQAWbiL6lfRbacTAVhNYX0vO6tjFW8j
         FZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110975; x=1786715775;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5Brd3fsBlkW7/lgwCn19iDGV7HYHFGxI21OU2HslXs=;
        b=AZ8HCe5hWjglE/bUULCjywWonwZAZCASdYGr1Vn0axR7Xnwr+AIGYlQFWhSYAspKsF
         IPKfAY0JX+iOmslnhgCA/hakv2HmEnsAuL593rEW5uhiQX9VIjoT5WZRjnPbuLM1PWGi
         mDNFLVXsv0k0qlTDvuHB73J2SoZTTQ1QMkT4lqSHcgWtAL33c+WIZSrYwgtNURrD7Plc
         WZ5k4yk1Gnc6SFOxRtfa2wPjQuIij7GW1Hy6LSgFxJMuu5mjtxA1wh0+UQONNk8Jhj8n
         ZP4Yw/n0vEhQ6orcbae0ZanQvqbqHKUteq0EwVq8MCdqv+79KMftAw6wXP2HSauz10wo
         HKbA==
X-Gm-Message-State: AOJu0YwkXgLn6VTESUy3OqtZ5Q8JfDWPuS3JHG/op+N17W4L2M6H9Db5
	OtL5LhyrWRmsD3yCpolEzMQdXzf9gbnH4YBsAgJUqEkBUfE4UHoEg9eeIBYzvsuLWS+fS8qgi5a
	HrZMaYA==
X-Received: from pjbjs15.prod.google.com ([2002:a17:90b:148f:b0:380:ce47:d7c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d444:b0:38f:240d:b857
 with SMTP id 98e67ed59e1d1-3909d79f918mr10094419a91.2.1786110974457; Fri, 07
 Aug 2026 06:56:14 -0700 (PDT)
Date: Fri, 7 Aug 2026 06:56:13 -0700
In-Reply-To: <bug-221841-28872-H4VjyfTP92@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <bug-221841-28872@https.bugzilla.kernel.org/> <bug-221841-28872-H4VjyfTP92@https.bugzilla.kernel.org/>
Message-ID: <anXj_SDnLHWL4IHh@google.com>
Subject: Re: [Bug 221841] KVM: nested VMX eVMCS VMPTRLD/VMPTRST causes
 infinite VM-Exit loop due to missing RIP advance
From: Sean Christopherson <seanjc@google.com>
To: bugzilla-daemon@kernel.org
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 07, 2026, bugzilla-daemon@kernel.org wrote:
> > > The eVMCS path should behave similarly to other unsupported nested VMX
> > > instructions.
> > 
> > Only if the TLFS allows it.  I assume it just says "unsupported" or
> > "undefined behavior", i.e. KVM can probably do whatever it wants.  Vitaly?
> 
> VMREAD/VMWRITE with eVMCS are explicitly called 'unsupported' in the TLFS:
> 
> "Any VMREAD or VMWRITE instructions while an enlightened VMCS is active is
> unsupported and can result in unexpected behavior.". 
> 
> As for VMPTRLD, we only have
> "No VMPTRLD instruction must be executed to make an enlightened VMCS active or
> current." but there's nothing about the expected result there. VMPTRST is not
> mentioned. 
> 
> So I guess we can do whatever we want in KVM and skipping the instruction is
> not a bad thing. Ideally, we can try and see what genuine Hyper-V gives us in
> this situation (by e.g. running an instrumented version of KVM there).

Heh, I agree, so long as Hyper-V's behavior is to either signal VM-Fail or inject
an exception of some kind.  If Hyper-V loops (like KVM does) or skips the
instruction without synthesizing an error of some kind, then I think we should
diverge from Hyper-V, as not signalling failure of some kind is pretty gross.

If we diverge from Hyper-V, think my vote would be to inject #UD or #GP, because
for all intents and purposes VMPTR{LD,ST} become unsupported instructions.  E.g.

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7ed79894d11d..e743c892eeb8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5888,6 +5888,12 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
        if (!nested_vmx_check_permission(vcpu))
                return 1;
 
+       /* Forbid normal VMPTRLD if Enlightened version was used */
+       if (nested_vmx_is_evmptr12_valid(vmx)) {
+               kvm_queue_exception(vcpu, UD_VECTOR);
+               return 1;
+       }
+
        if (nested_vmx_get_vmptr(vcpu, &vmptr, &r))
                return r;
 
@@ -5897,10 +5903,6 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
        if (vmptr == vmx->nested.vmxon_ptr)
                return nested_vmx_fail(vcpu, VMXERR_VMPTRLD_VMXON_POINTER);
 
-       /* Forbid normal VMPTRLD if Enlightened version was used */
-       if (nested_vmx_is_evmptr12_valid(vmx))
-               return 1;
-
        if (vmx->nested.current_vmptr != vmptr) {
                struct gfn_to_hva_cache *ghc = &vmx->nested.vmcs12_cache;
                struct vmcs_hdr hdr;
@@ -5961,8 +5963,10 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
        if (!nested_vmx_check_permission(vcpu))
                return 1;
 
-       if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu))))
+       if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu)))) {
+               kvm_queue_exception(vcpu, UD_VECTOR);
                return 1;
+       }
 
        if (get_vmx_mem_address(vcpu, exit_qual, instr_info,
                                true, sizeof(gpa_t), &gva))
