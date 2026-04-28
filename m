Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB992D47E9
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362355; cv=none; b=ZQnNtm4EL9VlVzMO+SWIra+L7cFOc0ggahwQOkoe3V7TC9OUEVfCGKtOhdjH/mVOZbtYltNj3H+6jOkVpO4tLfY26PfQ1tVF8sInjXv93Yn9e/xHz7cYkyJzfU55m7rT7VyFmLJpOeUVB/Sy8qpHNWuxUt/4qyxOUxyewpoWt3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362355; c=relaxed/simple;
	bh=LZ8MuQxRueYHXDAtqmb7a65LgdoZNfkBe8+foL4T9PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8kB/kwNm9WZEHmlYWqCL6bJ5oK/MTqPQ6JC9jCEQWqNxxHsQdfuWGHHUepil5kwW/fNoxiFxur8FVzu+93wGOXuDtsjI19LCJH0Lvs/bObPf0IUVU2SFjHNkeAN2FDmGLFql73N2N9aTryE6LISQwnV/d+Jinpg6B0nMDLsb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqwUFEF+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqwUFEF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777362352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lt9z7gbB+sH5tPAx1Crpzrmulf9no2QVaPi/TGZHp+U=;
	b=SqwUFEF+OMR9Dc9KSGrKJhjlrOs6xl1XlOfRZblM4npOD14hkqK03patPi/MHOntmunJC+
	NOKwAM0yzepMVSIwg0EHpiqDUh86ZYEGWZRJRqxPT21l3H4HlO2NJZcakCrI2WzbikR5rh
	67Jdwz6THNhH/0Km93VbKlSXyd//fCw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-xrSYLDl7OY-6-KFgeCHxnw-1; Tue,
 28 Apr 2026 03:45:47 -0400
X-MC-Unique: xrSYLDl7OY-6-KFgeCHxnw-1
X-Mimecast-MFC-AGG-ID: xrSYLDl7OY-6-KFgeCHxnw_1777362346
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A308718005B6;
	Tue, 28 Apr 2026 07:45:45 +0000 (UTC)
Received: from [10.32.181.22] (unknown [10.32.181.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3983B180047F;
	Tue, 28 Apr 2026 07:45:44 +0000 (UTC)
Message-ID: <3235eb76-9b28-4000-920a-491659927e67@redhat.com>
Date: Tue, 28 Apr 2026 09:45:42 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: VMX: Fall back to IRR scan when PIR is empty despite
 PID.ON being set
To: Chenyi Qiang <chenyi.qiang@intel.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Jim Mattson
 <jmattson@google.com>, Gao Chao <chao.gao@intel.com>,
 Farrah Chen <farrah.chen@intel.com>
References: <20260428070349.1633238-1-chenyi.qiang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260428070349.1633238-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 4/28/26 09:03, Chenyi Qiang wrote:
> Fall back to kvm_lapic_find_highest_irr() in vmx_sync_pir_to_irr() when
> PID.ON is set but PIR turns out to be empty, to correctly report the
> highest pending interrupt from the existing IRR.
> 
> In a nested VM stress test, the following WARNING fires in
> vmx_check_nested_events() when kvm_cpu_has_interrupt() reports a pending
> interrupt but the subsequent kvm_apic_has_interrupt() (which invokes
> vmx_sync_pir_to_irr() again) returns -1:
> 
>    WARNING: CPU: 99 PID: 57767 at arch/x86/kvm/vmx/nested.c:4449 vmx_check_nested_events+0x6bf/0x6e0 [kvm_intel]
>    Call Trace:
>     kvm_check_and_inject_events
>     vcpu_enter_guest.constprop.0
>     vcpu_run
>     kvm_arch_vcpu_ioctl_run
>     kvm_vcpu_ioctl
>     __x64_sys_ioctl
>     do_syscall_64
>     entry_SYSCALL_64_after_hwframe
> 
> The root cause is a race between vmx_sync_pir_to_irr() on the target vCPU
> and __vmx_deliver_posted_interrupt() on a sender vCPU.  The sender
> performs two individually-atomic operations that are not a single
> transaction:
> 
>    1. pi_test_and_set_pir(vector)  -- sets the PIR bit
>    2. pi_test_and_set_on()         -- sets PID.ON
> 
> The following interleaving triggers the bug:
> 
>    Sender vCPU (IPI):              Target vCPU (1st sync_pir_to_irr):
>    B1: set PIR[vector]
>                                    A1: pi_clear_on()
>                                    A2: pi_harvest_pir() -> sees B1 bit
>                                    A3: xchg() -> consumes bit, PIR=0
>                                        (1st sync returns correct max_irr)
>    B2: set PID.ON = 1
> 
>                                    Target vCPU (2nd sync_pir_to_irr):
>                                    C1: pi_test_on() -> TRUE (from B2)
>                                    C2: pi_clear_on() -> ON=0
>                                    C3: pi_harvest_pir() -> PIR empty
>                                    C4: *max_irr = -1, early return
>                                        IRR NOT SCANNED
> 
> The interrupt is not lost (it resides in the IRR from the first sync and
> is recovered on the next vcpu_enter_guest() iteration), but the incorrect
> max_irr causes a spurious WARNING and a wasted L2 VM-Enter/VM-Exit cycle.
> 
> Fixes: b41f8638b9d3 ("KVM: VMX: Isolate pure loads from atomic XCHG when processing PIR")
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Assisted-by: GitHub Copilot:Claude Opus 4.6
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> ---
> There is a WARNING call trace during a nested VM stress test. AI
> provided an analysis of a race condition and the related fix, which
> looks reasonable to me. With the patch applied, the WARNING can not
> be reproduced in overnight stress testing.

The analysis of the race is correct and changing the logic is the
right thing to do; but I would change directly __kvm_apic_update_irr,
either like this:

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e3ec4d8607c1..5ee14d6bc288 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -669,12 +669,14 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
  	u32 irr_val, prev_irr_val;
  	int max_updated_irr;
  
+	if (!pi_harvest_pir(pir, pir_vals)) {
+		*max_irr = apic_find_highest_vector(regs + APIC_IRR);
+		return false;
+	}
+
  	max_updated_irr = -1;
  	*max_irr = -1;
  
-	if (!pi_harvest_pir(pir, pir_vals))
-		return false;
-
  	for (i = vec = 0; i <= 7; i++, vec += 32) {
  		u32 *p_irr = (u32 *)(regs + APIC_IRR + i * 0x10);
  

Or even ignoring altogether the return value of pi_harvest_pir(), always
going in the loop below for simplicity.

Paolo

> ---
>   arch/x86/kvm/vmx/vmx.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 8b24e682535b..e2da29371e00 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7153,6 +7153,16 @@ int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
>   		smp_mb__after_atomic();
>   		got_posted_interrupt =
>   			kvm_apic_update_irr(vcpu, vt->pi_desc.pir, &max_irr);
> +		/*
> +		 * If PID.ON was set but PIR is empty, another CPU may have
> +		 * set PID.ON via __vmx_deliver_posted_interrupt() after a
> +		 * previous sync already consumed the PIR bits.  In this
> +		 * case, kvm_apic_update_irr() will not have scanned the
> +		 * existing IRR, so fall back to scanning the IRR directly
> +		 * to correctly report the highest pending interrupt.
> +		 */
> +		if (max_irr == -1)
> +			max_irr = kvm_lapic_find_highest_irr(vcpu);
>   	} else {
>   		max_irr = kvm_lapic_find_highest_irr(vcpu);
>   		got_posted_interrupt = false;

