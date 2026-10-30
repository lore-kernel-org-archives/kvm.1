Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384586;
	b=pqg3Xk60K80WPIt8r40un3Wm+ET3S7D4eynNDEvU46lPcjgdM8U+DOj/am2lE/SVFgLC
	 2Hd2ODLuJDJaXsl3GwvgJfIiMO6aDb72zEupiddy4l1tK7T65oCVOTGoTgwun9+e44ryW
	 dwDYxZrUxO+26QPwyEowN1xHMcUTsuvdDazcGYtFdnKBLt19to5jfFtdySwdYQo0s8Y4C
	 m1Ay0l3QMOu3waY6jPC2ODtW2nAjl4WY91lRF7UqJUDrVbmCt4VvYPjzlT5v9JWX/4rh3
	 PDUyDXn/PXEQKXQVcy/I7/xzRJmnlR+0Dk/58lpzKMo/rsw6lFMrFVnfCz90Yr+I8jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ZuCTTJahYnNgXBnjJFa/P9r47QdaMC3kb1A3Ip9nQnk=;
	b=TCqolVB2GObG0PYerQpRqLajb6RTTnmfhIIBs/3AaANBQc9bBnXrJIGr+Qv/kBH8daSq
	 EyBWweNuV7PMJesdHnwOvSoXoRdtZrrO85hWkBMdz9xR9RzKhE+f/cqbXhBzj6ESQLLZ7
	 n/35uLA3+d0/Jw3ttmQgCD3X6J5/dts3G1K1AJCn6d8oBcdfcZMad3Ln+2rUdD1ODsbs6
	 8tPPcC4gPpdLeN43oOB8XZT77mNuDtNRJeaegHJUbZAXp1ue6iSZR5yafohqWy8HqHAZx
	 kn31WviEcmeZkbg6EAOZ82pBeZWzBj/CpDLJbawIdULuByqUCuqw8AQMzOso+bcD35w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WFeyBdSS;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BB606A31D
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 18:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 155BB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WFeyBdSS
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac77c3ff6aso1311532a91.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793384584; x=1793989384; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZuCTTJahYnNgXBnjJFa/P9r47QdaMC3kb1A3Ip9nQnk=;
        b=WFeyBdSS4AnKpqCBN25WUsGg3QoMITt/+KAANL75ZYyHsdllbu3798KDB/id0sDalA
         13IwC+gNFLjM5IkgfuD/ErD7n0MUTIjAArggtWf8mQSz9V6SWy7dQIX2NG236jL7KMQH
         narDBsQkbDNVd6k4qGX7mXW8Kqz4NK0WwKQMUVtyuBBwgTAN7YNShVqINkTuPhviDBla
         ZwmjmMBJChdvKe4IbjghOUqDkR3ydUNvN/PdHkHvhCtmVncr6ZpP7UCJ3cWIYC2f6wQ7
         ja/7G5/sOMrcYRCTI0zj/7HMKpyy4O1Je3+y0uarOokC8dwdFwMOZKGcYXRrnh4O1c/1
         46MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793384584; x=1793989384;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZuCTTJahYnNgXBnjJFa/P9r47QdaMC3kb1A3Ip9nQnk=;
        b=Vo0baOgqoLjFA+Zn1hXtl7ye94XRn8DfEkU1GZhnZ0WVYtBc0QUrqPBk+RcbSANw2Q
         RJUWSetMDvqPjQkoitsv2eRot8rzcj7uWWU/ixH1Ov2n0DlWBFFYzr+eHJKZBb6czFCO
         lnEwFNpdaRL7oOKknT/2mD/7Yl44Vm/CieLulVNRxFBYIoduja2SppDlWVOjls5/O/Rn
         IWw5RNqUalShFcVWIkYSPUTNcUCFlYFGGFv6qmOrnoNxbi6ZsXLyLmRqr6eR8c9yQptD
         +ZtFkV2AgDo+II9kPQ600ZmSqYfkidVwt994LNyPqaXZVt66cqlB8+f9uhypU7iiMFMZ
         pnZg==
X-Forwarded-Encrypted: i=1; AKwUvBxZvE2qdaFNqz/wQuaEpoR+JpqAbBGdiMGtVPzpYrBbf/Hwxp2rbPR4dE6s+A6NxQ3cKFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbekyX8ppNu3FVC3fEa/VO2JXcvnszIC3CADE92uo1NbrJZtdP
	OBqIL00rvL0ufteT/pBIMMZFOO0FkifuRreNVNwBaj0bxUxgvkJ4IL3TmsW4GES5EqFom3yXYE7
	FnR05Lg==
X-Received: from pjbpj10.prod.google.com ([2002:a17:90b:4f4a:b0:3ad:6c5f:feb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e70c:b0:3ab:2737:3393
 with SMTP id 98e67ed59e1d1-3ae89835d94mr2612585a91.40.1793384584151; Fri, 30
 Oct 2026 11:23:04 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:23:03 -0700
In-Reply-To: <20261030032937.2813-2-ma.mandourr@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030032937.2813-1-ma.mandourr@gmail.com> <20261030032937.2813-2-ma.mandourr@gmail.com>
Message-ID: <auTgh5uP5tpL8BlP@google.com>
Subject: Re: [PATCH v2 1/2] KVM: nVMX: Don't let L2's LMSW modify CR0 bits
 owned by L1
From: Sean Christopherson <seanjc@google.com>
To: Mahmoud Abumandour <ma.mandourr@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 29, 2026, Mahmoud Abumandour wrote:
> When L2's LMSW exits to L0 but not to L1, emulate it through
> handle_set_cr0(), as is done for MOV to CR0.  kvm_lmsw() ignores
> vmcs12's CR0 guest/host mask, so L2 could change CR0 bits that L1 owns,
> e.g. clear TS, and read their effective values instead of the read shadow.
> 
> Fixes: eeadf9e7558c ("KVM: nVMX: Handling of CR0 and CR4 modifying instructions")
> Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b341af4c60..3633496299 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5748,6 +5748,21 @@ static int handle_cr(struct kvm_vcpu *vcpu)
>  	case 3: /* lmsw */
>  		val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
>  		trace_kvm_cr_write(0, (kvm_read_cr0_bits(vcpu, ~0xful) | val));
> +		if (is_guest_mode(vcpu)) {
> +			struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> +			unsigned long mask = vmcs12->cr0_guest_host_mask;
> +			unsigned long cr0;
> +
> +			/*
> +			 * LMSW leaves the bits L1 owns unmodified, as does a MOV
> +			 * to CR0 that writes their read shadow values.  Emulate
> +			 * it as that MOV: L2's view of CR0 with LMSW's bits.
> +			 */
> +			cr0 = (kvm_read_cr0(vcpu) & ~mask) |
> +			      (vmcs12->cr0_read_shadow & mask);

This is quite confusing.  This *looks* like it incorrectly handles CR0.PE for the
case where PE=1 in guest_cr0 and the guest/host mask, but PE=0 in cr0_read_shadow.
In that insane scenario, LMSW with PE=0 won't be intercepted by L1, but needs to
preserve PE=1 in the "hardware" value while also keeping PE=0 in the read shadow.

The above initially preseve CR0.PE=1, but then drops it from the effective @val
passed to handle_set_cr0().  Which works in the end handle_set_cr0() preserves
L1-owned bits using guest_cr0, but piecing that all together is confusing because
at first (and second, and third...) glance, it's very easy to think that *this*
 code is taking responsibility for enforcing the cr0_guest_host_mask, but the
ownership is super weirdly split across this code and handle_set_cr0().

I also don't like that this duplicates logic for kvm_lmsw() and handle_set_cr0().

Unless I'm missing something, we can handle all of this in handle_set_cr0() simply
by ensuring handle_set_cr0() (and handle_set_cr4() for completeness) preserve bits
that are L1-owned in the read shadow.  handle_set_cr{0,4} currently squeak by
without explicitly doing so, because straight writes via MOV CR will generate a
nested VM-Exit to L1 if the incoming value toggles any of the shadowed bits.  I.e.
it's only LMSW that can kinda sorta toggle bits in violation of the intercept
controls.

So, as a prep patch, this:

diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
index b341af4c6057..544b7840897c 100644
--- arch/x86/kvm/vmx/vmx.c
+++ arch/x86/kvm/vmx/vmx.c
@@ -5629,22 +5629,19 @@ static int handle_set_cr0(struct kvm_vcpu *vcpu, unsigned long val)
 {
        if (is_guest_mode(vcpu)) {
                struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
-               unsigned long orig_val = val;
+               u64 mask = vmcs12->cr0_guest_host_mask;
 
                /*
-                * We get here when L2 changed cr0 in a way that did not change
-                * any of L1's shadowed bits (see nested_vmx_exit_handled_cr),
-                * but did change L0 shadowed bits. So we first calculate the
-                * effective cr0 value that L1 would like to write into the
-                * hardware. It consists of the L2-owned bits from the new
-                * value combined with the L1-owned bits from L1's guest_cr0.
+                * L2 is writing a CR0 value that isn't modifying any of L1's
+                * shadowed bits (see nested_vmx_exit_handled_cr()), but *is*
+                * modifying L0 shadowed bits.  Set the "hardware" CR0 and the
+                * read shadow using the L2-owned bits from the new value,
+                * combined with the L1-owned bits.
                 */
-               val = (val & ~vmcs12->cr0_guest_host_mask) |
-                       (vmcs12->guest_cr0 & vmcs12->cr0_guest_host_mask);
-
-               if (kvm_set_cr0(vcpu, val))
+               val &= ~mask;
+               if (kvm_set_cr0(vcpu, val | (vmcs12->guest_cr0 & mask)))
                        return 1;
-               vmcs_writel(CR0_READ_SHADOW, orig_val);
+               vmcs_writel(CR0_READ_SHADOW, val | (vmcs12->cr0_read_shadow & mask));
                return 0;
        } else {
                return kvm_set_cr0(vcpu, val);
@@ -5655,14 +5652,13 @@ static int handle_set_cr4(struct kvm_vcpu *vcpu, unsigned long val)
 {
        if (is_guest_mode(vcpu)) {
                struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
-               unsigned long orig_val = val;
+               u64 mask = vmcs12->cr4_guest_host_mask;
 
                /* analogously to handle_set_cr0 */
-               val = (val & ~vmcs12->cr4_guest_host_mask) |
-                       (vmcs12->guest_cr4 & vmcs12->cr4_guest_host_mask);
-               if (kvm_set_cr4(vcpu, val))
+               val &= ~mask;
+               if (kvm_set_cr4(vcpu, val | (vmcs12->guest_cr4 & mask)))
                        return 1;
-               vmcs_writel(CR4_READ_SHADOW, orig_val);
+               vmcs_writel(CR4_READ_SHADOW, val | (vmcs12->cr4_read_shadow & mask));
                return 0;
        } else
                return kvm_set_cr4(vcpu, val);


and then the fix becomes:

diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
index 544b7840897c..2d5feeb8a059 100644
--- arch/x86/kvm/vmx/vmx.c
+++ arch/x86/kvm/vmx/vmx.c
@@ -5743,8 +5743,10 @@ static int handle_cr(struct kvm_vcpu *vcpu)
                break;
        case 3: /* lmsw */
                val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
-               trace_kvm_cr_write(0, (kvm_read_cr0_bits(vcpu, ~0xful) | val));
-               kvm_lmsw(vcpu, val);
+               val |= kvm_read_cr0_bits(vcpu, ~0x0eul);
+
+               trace_kvm_cr_write(cr, val);
+               (void)handle_set_cr0(vcpu, val);
 
                return kvm_skip_emulated_instruction(vcpu);
        default:

> +			err = handle_set_cr0(vcpu, (cr0 & ~0x0eul) | val);
> +			return kvm_complete_insn_gp(vcpu, err);

This needs to (a) be a separate patch and (b) apply to L1 as well (though I'm not
even sure if you/AI realize this is a bug fix).   Emulation of LMSW originally
suppressed the return value, because outside of VMX operation, LMSW can't #GP on
a bad value.  LMSW can't set reserved bits (for the CPU models KVM supports), and
it can't toggle any bits that trigger additional checks, e.g. can't try to clear
CR0.PG while in 64-bit mode.

But with VMX, must-be-1 and must-be-0 bits become a thing, and so LMSW could #GP
if it tried to set/clear a bit in violation of those masks.

Ugh, never mind, screw this.  KVM doesn't support arbitrary MSR_IA32_VMX_CR0_FIXED1
values, i.e. doesn't let userspace require that arbitrary bits always be '0', and
instead relies on common CR0 reserved bit checks.  KVM (very, very stupidly) does
allow userspace to expand the set of must-be-1 (MSR_IA32_VMX_CR0_FIXED0) bits), and
so *in theory* LMSW could fault when clearing EM, MP, or TS.  Of course, no sane
VMM sets those as must-be-1 bits.  And to make this a complete trainwreck, KVM
doesn't update its own guest/host masks, i.e. it's own intercepts, to ensure it
enforces the must-be-1 bits.

E.g. if userspace made CR0.TS a must-be-1 bit, then the guest could violate that
so long as it doesn't toggle any other bits that would trigger a VM-Exit.

I see absolutely zero reason to try and fix KVM.  Letting userspace make CR0.TS
a must-be-1 bit is beyond stupid.  KVM already requires CR0 and CR4 must-be-1
masks to be a superset of KVM's "defaults", so userspace can only make things
more restrictive.

So, rather than synthesize #GPs, I think we should prevent nVMX MSRs from inducing
#GPs in the first place, and then WARN.

> +		}
>  		kvm_lmsw(vcpu, val);
>  
>  		return kvm_skip_emulated_instruction(vcpu);
> -- 
> 2.25.1
> 
