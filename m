Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D433ADB9
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293963; cv=none; b=U014RHWYj+Gn+2+DrLHQ+uJ378innDpGFxvNJljZ4Bm9IlcJrbq3+lDD0kNJduxXIRA4kAAYouXX8UHz+bo8unMkN7slJSiM2BDU3vi9N0zMDvz2N+PsK9KBJrE0w1G2afGPQ2BARZszjTXNfd8hi+taElQ6u6vKAvw0MuuAH2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293963; c=relaxed/simple;
	bh=JESk8fzbVfL/MwuI24RLNrPxL+cg5zyEjqsViWeknvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EMBdJV2fDfv7N7oBLS5AM1bzE3zlousTIkGuRvQBxeHa4oSbPHq2BGXjOga7hHkHZpuLdFHEPiG4hJ2huo2W1s36B7VOPlychMaCT4D9maxJOgIPOUW7yoWtUk0/HwXTr2kQTfFCGuBcoXaUuGBvu2j7BrQBxXq8qaoHgYedSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c2oh30gO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2oh30gO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso56985375ad.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779293960; x=1779898760; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0g28V3DslRSZVzdjcC1vE0SgoTvJEgyoXcUj1wZGdo=;
        b=c2oh30gOgadCy0LbCp/DAiGYQuTMp1kbLvVN/qIy1TdA8NfpNmBKwOzKolxVk9jTjQ
         Zzz4lQy0MkMK4eKvEZKJOmL3PPd4jv6ftOUqJPnNmumCvYSmA9naYWLVIdHFBzOzR7Hf
         EK8citTSVEJRI/0uncTkM9UvqIDU5xGJWZZxQI/IxNrcLihJvwUbp5S2AYxcJ0ZzjGMV
         99bW+BPiAwJfJCP29B3bDhvtn5WcttRODVgPo56ln/Ab0wJPpcr9AaTXvyKVkEHm47f3
         b9lBxH/zRtSChV4HOjoMYL9Gjnift5XsW73bXAngvHIUfElFAibCyFqnf0ZnkWzttA/C
         IzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293960; x=1779898760;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0g28V3DslRSZVzdjcC1vE0SgoTvJEgyoXcUj1wZGdo=;
        b=eot0vtSJqJzf7CVf9nBchicyc3wGBaBiLOdS5bx1SMkCAX3Eh3D6G0HHkhmqXnNlM0
         PydAGqR3W0qnxvpYwMxU/vGfOdaCEPZEb2yOk7Jlh2WQGcJa5kTihbHbjbUxCCOSgqp0
         lxePl/7XKLK7cj50V3r7vkwBHzAgrDxrJ+UcQx3OlKgze9bm6MvqoFlWwe16NTR/lVTz
         GkjsUjDg/L2ZXK3Bbj4WkQXy77YMtDeJ7sNtPch7+DTV3WbSfwmeKl63QVDFPPRE9tG0
         a9FSE0I8bFpwr5CCpy6tk1XMGgajS9QIZS+nUp01g0tvVzAoSWQKw5oDl3fOjGw01XBK
         rwIA==
X-Forwarded-Encrypted: i=1; AFNElJ+nthZHBKHh1SZ2TsUri8Qzo8wiulfwXZJvTckGuutD4iguu4xxsWWv83vbjAP35sxEsWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZgTXU5MAzfZoAaOBNNxFY3SoJkaQBHtBkuuMfzzUx4zLuM9O
	5Y0RjiZ/8Rrb/e9qxNMam1Jc+JcvW166Up6h0YCLnytdbkrWIWmuLY5f5xs/M7jLl8/ZHAF4X6S
	d1Ztc/A==
X-Received: from pgt38.prod.google.com ([2002:a63:1366:0:b0:c82:798f:628b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0a:b0:398:787c:d2e4
 with SMTP id adf61e73a8af0-3b22e7536c1mr27558941637.17.1779293959848; Wed, 20
 May 2026 09:19:19 -0700 (PDT)
Date: Wed, 20 May 2026 09:19:19 -0700
In-Reply-To: <20260515222638.1949982-11-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com> <20260515222638.1949982-11-seanjc@google.com>
Message-ID: <ag3fB0wB8-DHjUMC@google.com>
Subject: Re: [PATCH v3 10/10] KVM: selftests: Verify VMX's GUEST_PENDING_DBG_EXCEPTIONS.BS
 Consistency Check
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 15, 2026, Sean Christopherson wrote:
> From: Hou Wenlong <houwenlong.hwl@antgroup.com>
> 
> In x86's debug_regs test, add a test case to cover the scenario where a
> single-step #DB occurs in an STI-shadow, in which case KVM needs to stuff
> vmcs.GUEST_PENDING_DBG_EXCEPTIONS.BS in order to satisfy a flawed VM-Entry
> Consistency Check.
> 
> Wire up an IRQ handler to gain a bit of bonus coverage, as the subsequent
> IRET from the #DB sets RFLAGS.IF, but *without* STI-blocking, and so the
> pending IRQ is expected on the instruction immediately following STI.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> [sean: expect the IRQ on the CLI, and explain why]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/x86/debug_regs.c | 64 ++++++++++++++++++--
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86/debug_regs.c b/tools/testing/selftests/kvm/x86/debug_regs.c
> index ee9d0f3a5807..6299e921dc27 100644
> --- a/tools/testing/selftests/kvm/x86/debug_regs.c
> +++ b/tools/testing/selftests/kvm/x86/debug_regs.c
> @@ -15,11 +15,46 @@
>  
>  #define IRQ_VECTOR 0xAA
>  
> +#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
> +
>  /* For testing data access debug BP */
>  u32 guest_value;
>  
>  extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
> -extern unsigned char fep_bd_start;
> +extern unsigned char fep_bd_start, fep_sti_start, fep_sti_end;
> +
> +static void guest_db_handler(struct ex_regs *regs)
> +{
> +	static int count;
> +	unsigned long target_rips[2] = {
> +		CAST_TO_RIP(fep_sti_start),
> +		CAST_TO_RIP(fep_sti_end),
> +	};
> +
> +	__GUEST_ASSERT(regs->rip == target_rips[count],
> +	               "STI[%u]: unexpected rip 0x%lx (should be 0x%lx)",
> +		       count, regs->rip, target_rips[count]);
> +	regs->rflags &= ~X86_EFLAGS_TF;
> +	count++;
> +}
> +
> +static void guest_irq_handler(struct ex_regs *regs)
> +{
> +	/*
> +	 * The pending IRQ should finally be take when KVM_GUESTDBG_BLOCKIRQ is
> +	 * cleared and IRQs are enabled.  Note, the IRQ is expected to arrive
> +	 * on the instruction immediately after STI, even though its in an STI
> +	 * shadow.  Because the next instruction has a coincident #DB, and #DBs
> +	 * are not subject to STI-blocking, the #DB will push RFLAGS.IF=1 on
> +	 * the stack, and the eventual IRET will unmask IRQs and obliterate the
> +	 * STI shadow in the process.
> +	 */
> +	unsigned long target_rip = CAST_TO_RIP(fep_sti_start);
> +
> +	__GUEST_ASSERT(regs->rip == target_rip,
> +		       "IRQ: unexpected rip 0x%lx (should be 0x%lx)",
> +		       regs->rip, target_rip);

From Sashiko:

 : Is an End of Interrupt (EOI) acknowledgment required here?
 : 
 : The handler is triggered by an APIC interrupt injected earlier in the test,
 : but does not write to the APIC_EOI register to acknowledge it.
 : 
 : While it might not fail this specific test since it ends immediately after,
 : does failing to send an EOI leave the interrupt permanently marked as
 : in-service in the local APIC state machine?

Yes, this will leave the IRQ dangling in the ISR.  It doesn't really matter, but
I'll throw in a:

	x2apic_write_reg(APIC_EOI, 0);

when applying.

> +}
>  
>  static void guest_code(void)
>  {
> @@ -66,14 +101,32 @@ static void guest_code(void)
>  	/* DR6.BD test */
>  	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");
>  
> -	if (is_forced_emulation_enabled)
> +	/*
> +	 * Note, the IRET from the #DB that occurs in the below STI-shadow will
> +	 * unmask IRQs, i.e. the pending interrupt will be delivered after #DB
> +	 * handling, on the CLI!
> +	 */
> +	if (is_forced_emulation_enabled) {
>  		asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" : : : "rax");
>  
> +		/* pending debug exceptions for emulation */
> +		asm volatile("pushf\n\t"
> +			     "orq $" __stringify(X86_EFLAGS_TF) ", (%rsp)\n\t"
> +			     "popf\n\t"
> +			     "sti\n\t"
> +			     "fep_sti_start:"
> +			     "cli\n\t"
> +			     "pushf\n\t"
> +			     "orq $" __stringify(X86_EFLAGS_TF) ", (%rsp)\n\t"
> +			     "popf\n\t"
> +			     KVM_FEP "sti\n\t"
> +			     "fep_sti_end:"
> +			     "cli\n\t");
> +	}
> +

Also from Sashiko:

 : Does the test verify that the expected #DB and IRQ events actually occurred?
 : 
 : The assertions are placed inside guest_db_handler() and guest_irq_handler(),
 : but if a bug causes the exceptions to be dropped completely, the guest
 : will simply proceed to execute GUEST_DONE() without error.
 : 
 : Should there be a shared state variable to assert that the handlers fired
 : the expected number of times before concluding the test?

Another "yes".  I'll add an assert that the IRQ actually fired.

