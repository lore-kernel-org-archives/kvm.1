Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF83559F2;
	Thu, 14 May 2026 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736679; cv=none; b=ioBM8wIIkmYkc0mbN728pUIBfc2/nTMKMzysqnDtLVSCKgxw1DZdVYbnZaBgz2uN1vURbuRQcfwPtRnCkDRVQAg2RAixp3/9F0pDOmjOBTF+yQ6rHfV5r4vxluP51iadW8blzOnysl1BthlYFcHZUKyANyEDbspktTp9BF5aI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736679; c=relaxed/simple;
	bh=bMuGIsTJEwYfknkuZSZnipqnNI+dfrHy/4PqUGcks0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYh5FpqHhqPYWX2clJcdhENkAkSD1JVcb6j931mE4X9WLSB9RmzPRA/a177XsQHlCEHuF7QJw5KnNRfmlC3Crpme/u8WLlBilYy9YlWEiAGLUw+pxnCBUsU8rtNVNKdj9riX9JlBh3ORTjdhCCUjqyRaL4wwllkz7sazgCwUDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=pvPU55jP; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="pvPU55jP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1778736666; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=K+ikfnKl77O2B1qPK6+Voix1zQj84xcmMX2VlX4NtWY=;
	b=pvPU55jPQ9m5DUT3we5vSrfU3aB1jStF/bq34cxAfyHpoeH42YjaxKn89jZIezW60TncXEA1z1Ty1id2AB4wDEPFjzZ55MYyFQuQ3Fn47e41doT8j5Kg46MCT827AwkAZO5BMa6tuiUgwVsBxUrpy/ON19gIJR6TqtwcRWR5NV8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.hWhXXso_1778736665;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.hWhXXso_1778736665 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 14 May 2026 13:31:05 +0800
Date: Thu, 14 May 2026 13:31:05 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] KVM: selftests: Verify 'BS' bit checking in
 pending debug exception state during VM-Entry
Message-ID: <20260514053105.GA109150@k08j02272.eu95sqa>
References: <cover.1766066076.git.houwenlong.hwl@antgroup.com>
 <e0df5d6812da0f508cdf697ac7627693199c8293.1766066076.git.houwenlong.hwl@antgroup.com>
 <agUFxrpUhBRv54ZV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agUFxrpUhBRv54ZV@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 13, 2026 at 04:14:14PM -0700, Sean Christopherson wrote:
> On Thu, Dec 18, 2025, Hou Wenlong wrote:
> > In the x86's debug_regs test, add a test case to cover the scenario
> > where single-step with STI in VMX sets the 'BS' bit in pending debug
> > exceptions state for #DB interception and instruction emulation in both
> > cases.
> 
> ...
> 
> > +static void guest_db_handler(struct ex_regs *regs)
> > +{
> > +	static int count;
> > +	unsigned long target_rips[2] = {
> > +		CAST_TO_RIP(fep_sti_start),
> > +		CAST_TO_RIP(fep_sti_end),
> > +	};
> > +
> > +	__GUEST_ASSERT(regs->rip == target_rips[count], "STI: unexpected rip 0x%lx (should be 0x%lx)",
> > +		       regs->rip, target_rips[count]);
> > +	regs->rflags &= ~X86_EFLAGS_TF;
> > +	count++;
> > +}
> > +
> > +static void guest_irq_handler(struct ex_regs *regs)
> > +{
> > +	unsigned long target_rip = CAST_TO_RIP(fep_bd_start);
> > +
> > +	__GUEST_ASSERT(regs->rip == target_rip, "IRQ: unexpected rip 0x%lx (should be 0x%lx)",
> > +		       regs->rip, target_rip);
> 
> This is wrong, and the test fails with your series applied verbatim.  The IRQ
> will arrive at fep_sti_start, because RFLAGS.IF=0 from the CLI at the end of the
> ss_start block, and remains that way across fep_bd_start.   And to make things
> even more confusing, the IRQ arrives on the CLI even though it's in an STI shadow
> due to #DBs not being subjected to _STI_ shadows on Intel, only to MOV-SS/POP-SS
> shadows.  I.e. the #DB lands on CLI, pushes RFLAGS.IF=1 on the stack, and then
> the subsequent IRET from guest_db_handler() fully unmasks IRQs, and voila.

Yes, the RIP here should be 'fep_sti_start'. This was a stupid mistake,
and I’m very sorry about that. In my reply to v1[0] I explained why an IRQ
handler is needed, so in v2 I added comments and an additional check,
and I tested it before sending. However, it looks like the patch differs
from what I had locally—my code management was a bit messy.

As you pointed out, this pending interrupt can make the test somewhat
confusing. So it might be better to consume the IRQ before running the
test, e.g.:

```
diff --git a/tools/testing/selftests/kvm/x86/debug_regs.c
b/tools/testing/selftests/kvm/x86/debug_regs.c
index 3ec2724697de..030d5cb58cc2 100644
--- a/tools/testing/selftests/kvm/x86/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86/debug_regs.c
@@ -21,7 +21,7 @@
 u32 guest_value;

 extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
-extern unsigned char fep_bd_start, fep_sti_start, fep_sti_end;
+extern unsigned char fep_irq, fep_bd_start, fep_sti_start, fep_sti_end;

 static void guest_db_handler(struct ex_regs *regs)
 {
@@ -39,7 +39,7 @@ static void guest_db_handler(struct ex_regs *regs)

 static void guest_irq_handler(struct ex_regs *regs)
 {
-       unsigned long target_rip = CAST_TO_RIP(fep_bd_start);
+       unsigned long target_rip = CAST_TO_RIP(fep_irq);

        __GUEST_ASSERT(regs->rip == target_rip, "IRQ: unexpected rip
0x%lx (should be 0x%lx)",
                       regs->rip, target_rip);
@@ -93,6 +93,14 @@ static void guest_code(void)
        if (is_forced_emulation_enabled) {
                asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" :
: : "rax");

+               /*
+                * Consume the pending interrupt, as the single-step #DB
delivery after
+                * STI removes the interrupt shadow, so the pending
interrupt will be
+                * delivered after guest #DB handling.
+                */
+               asm volatile("sti; nop\n\t"
+                            "fep_irq:");
+
                /* pending debug exceptions for emulation */
                asm volatile("pushf\n\t"
                             "orq $" __stringify(X86_EFLAGS_TF) ",
(%rsp)\n\t"
@@ -264,13 +272,10 @@ int main(void)
        memset(&debug, 0, sizeof(debug));
        vcpu_guest_debug_set(vcpu, &debug);

-       vm_install_exception_handler(vm, DB_VECTOR, guest_db_handler);
-       /*
-        * Install a dummy IRQ handler, as the single-step #DB delivery
         after
-        * STI removes the interrupt shadow, so the pending interrupt
         will be
-        * delivered after #DB handling.
-        */
-       vm_install_exception_handler(vm, IRQ_VECTOR, guest_irq_handler);
+       if (is_forced_emulation_enabled) {
+               vm_install_exception_handler(vm, DB_VECTOR,
guest_db_handler);
+               vm_install_exception_handler(vm, IRQ_VECTOR,
guest_irq_handler);
+       }

        vcpu_run(vcpu);
        TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
```

I have tested it on both Intel and AMD. Please let me know if I should
resend a v3 of this patch.

[0]: https://lore.kernel.org/kvm/20251218134026.GA118671@k08j02272.eu95sqa/

Thanks!

