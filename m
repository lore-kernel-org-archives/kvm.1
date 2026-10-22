Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705369;
	b=dJPHrZqZ8v5MCFaMF3clO+M6J+GS9mSjzEG+wprWbgUPJxK4O8EV+UfCcbVz4EULR1Pe
	 j5vwr1pXjHd+Q9efi0heBRgGtpnVL3jHjQg5J2ZQrqMcP/nzMZnMWgzPRZNp8aVxXWVi3
	 UvBnyig2AAkL1dtP5T1ENG23ONcsqpYDysyubp2PPSaqQFMiEgpYAqY4qUO0R1J/alVOh
	 VkrofMLz3jptDMAZLXNFSfgMRmLyOhiwxFE/EQ4kOWjLroSXaW+XuYNxR6RuX0pTMkKLJ
	 SGbMa6ZgieyzF2pPf5pb4NStqieQxYBXVU58O2Ru2Nlc949QlfzXX9pA40JLFNDAMjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kgSv+3JntvG4qYk7wWMozN9I9rFPuCtquT0WOgdlsiA=;
	b=HO76BTkfo7QFbJg0hTKjCXNkGIODhOhjX/7GTJPimhzs5xpGFhlMujrFDayLrHferXab
	 kmy6yjqEX8kmc9/RUJGttkEc986G8k3HGR6+rMPoOl2rT2rEBnUHcJpbT/xUf9Q37HfCk
	 uNt9FlsZJHpgKAs56jLPPKnHOlbdrX3j5E6e9q8TRU5GDQkuqq+HJCVRqPkoYSRr9I9yC
	 04UZF44FcMu941gyILHdQ6h8dVgpey0P7ntk+mnm6ljo9fb9y5np9+y6534npRG7o8n26
	 a+zNXwbWoIE7gwAXjDk8RDUlBGPZn9tgvCw2iTkizp2eTl4F9UlfMGJkf3de4XIQH1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hpcex3Hs;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1BA606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 21:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D1BA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hpcex3Hs
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a08e315b5cso111596b3a.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792705368; x=1793310168; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kgSv+3JntvG4qYk7wWMozN9I9rFPuCtquT0WOgdlsiA=;
        b=hpcex3HsHKU585aQ967agINzYie/OPDoAvP4LxEjwth6ttkAFhPZcJQ4vqPc/ckozM
         OCaZAzPlWrmWHf3n//2IuRsSKWbyDTsDL95pfVauEyq0BuoblSYx8zrw+/OVUtcriXKy
         ft2cKOcJUK/gPXGhZFv/+O+2OeraZOrqYISMweKxfGXJ26xw5L33/MSzchBhmVrgi3hm
         jkF9Vy6Tdl0UldERjHgHfGTQQrYeXf6cFtYlNsBjitmd1Uh6utsPq7clRFw/bEz2ih7j
         PfYA/JfIy/QZ8A8EqRnEURPq9d3A2LYlBRutSIGq64JwOVCSz5keuWVa63YV4NyDDkot
         SarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792705368; x=1793310168;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kgSv+3JntvG4qYk7wWMozN9I9rFPuCtquT0WOgdlsiA=;
        b=d+u9VcXqNvOpv+D4e3SYokVlWWeG3Ohe/61KXdB6+QikdRfktdvOOZle+hsQnAPP9X
         zntClP3UBLBALOhasMQBQ31bxpHqFhCkraq+UH6ynFlD2L1f4KEhn0L1pVELCGynCs5Y
         hZOPg11DVJmCaVTiTIur3Mnqx9fC6fi5CP0cswbnKlM+vY+gpMafxY28cs0DY1RDTSbT
         OJI/x5I0VAWq08FmbfxsmGTF3/SvZU3lun6Fzwd/C2Wfy49H9RgDKE/RhyUPc5hb9DhV
         UGL73+Ad0sr+Ap6eg72E46F01It8h+LEjRfKpwxSBpYZcGoT+ahi+Wit8hGWfpAPOmo5
         Ldyg==
X-Forwarded-Encrypted: i=1; AKwUvByAiYyqvxNcPFu0A2utxX76c1/2FomMLw+MHSewGQje+clG9z/K41bugrzmocv9su63E/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv1KgAl1dr/t48BSnuSIfVulqDyZNj4engA/zA/d6W45w4Ii3K
	36+FOBPcKh1YeEkSvNuGyteEGA7gEARhdSWeU61/6AaL+ChzINMIKQh3CK0agLraidsk5GTQc4C
	iP0WERw==
X-Received: from pfbbd9.prod.google.com ([2002:a05:6a00:2789:b0:89e:a4f5:3f5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d0e:b0:89f:ec29:913d
 with SMTP id d2e1a72fcca58-8a2c5e36c99mr418590b3a.16.1792705367535; Thu, 22
 Oct 2026 14:42:47 -0700 (PDT)
Date: Thu, 22 Oct 2026 14:42:46 -0700
In-Reply-To: <cfe12756-208a-4a3c-bd46-cfdfeae6cdb1@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cfe12756-208a-4a3c-bd46-cfdfeae6cdb1@gmail.com>
Message-ID: <atqDVkHjdJ2iF9Uv@google.com>
Subject: Re: [PATCH] KVM: nVMX: Reject nested VM-entry in wait-for-SIPI with a
 pending event injection
From: Sean Christopherson <seanjc@google.com>
To: Amirmohammad Eftekhar <amirmohammadeftekhar@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 22, 2026, Amirmohammad Eftekhar wrote:
> nested_check_guest_non_reg_state() only verifies that
> guest_activity_state is one of ACTIVE, HLT or WAIT_SIPI; it performs
> none of the activity-state cross-checks that VM entry requires.  Per
> Intel's SDM, "Checks on Guest Non-Register State", when the valid bit of
> the VM-entry interruption-information field is set the interruption to
> be delivered "must not be one that would normally be blocked while a
> logical processor is in the activity state", and for the wait-for-SIPI
> state "No interruptions are allowed".  The same section also requires
> that the activity state indicate the active state when the
> interruptibility-state field blocks by STI or MOV SS.
> 
> KVM accepts a vmcs12 that violates both rules, and hardware does not
> catch the miss: prepare_vmcs02() never writes GUEST_ACTIVITY_STATE, so
> vmcs02 always carries active, and wait-for-SIPI is emulated in software
> only after a successful entry (the mp_state = INIT_RECEIVED arm).  The
> injection, in contrast, is copied into vmcs02.  The physical VMLAUNCH
> therefore sees {active, valid injection} -- a legal pair -- and
> succeeds.  Because the offending field is stripped before hardware sees
> vmcs02, the missed-exit WARN in __nested_vmx_vmexit() can never fire for
> this class either.
> 
> From L1's point of view a VMLAUNCH that bare metal rejects with a
> VM-entry failure (invalid guest state) instead succeeds, with L2 left
> parked in wait-for-SIPI holding a stale VM_ENTRY_INTR_INFO in vmcs02.
> 
> Add the two activity-state cross-checks that KVM strips before hardware
> can enforce them. 

Please split this into two patches, one for each consistency check.  The justification
for why KVM needs these checks is the same, but the changes themselves are
independent.

> The HLT state additionally restricts which
> interruption types may be injected (external interrupt / NMI / #DB / #MC
> / pending-MTF only); that matrix is left for a follow-up as it needs the
> per-type table, whereas the two checks added here are unconditional and
> cover the fields KVM elides.
> 
> Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> ---
>  arch/x86/kvm/vmx/nested.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 9b0bfa2f8..66c9d1ffe 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3311,6 +3311,24 @@ static int nested_check_guest_non_reg_state(struct
> vmcs12 *vmcs12)
>  	       vmcs12->guest_activity_state != GUEST_ACTIVITY_WAIT_SIPI))
>  		return -EINVAL;
>  +	/*
> +	 * The activity state must be active if the interruptibility state
> +	 * blocks by STI or MOV SS.
> +	 */

Eh, drop this comment, it's pretty much just restating the code verbatim.

> +	if (CC(vmcs12->guest_activity_state != GUEST_ACTIVITY_ACTIVE &&
> +	       (vmcs12->guest_interruptibility_info &
> +		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS))))
> +		return -EINVAL;
> +
> +	/*
> +	 * An injected event must not be one that would be blocked in the
> +	 * guest's activity state; no interruptions are allowed in the
> +	 * wait-for-SIPI state.
> +	 */

I think a TODO would be helpful.  Actually, what if we structure the entire
function as a switch-statement?  Gah, never mind, the check on MOV-SS and STI
blocking makes that annoying to deal with.

Anyways, how about this?

	/* 
	 * Injected events are disallowed if they are blocked by the activity
	 * state.  All injectable events are allowed in the active state, all
	 * are blocked by Wait-For-SIPI, and a small subset are allowed for HLT.
	 *
	 * TODO: Add consistency checks for HLT with an injected event.
	 */
	if (CC(vmcs12->guest_activity_state == GUEST_ACTIVITY_WAIT_SIPI &&
	       vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK))
		return -EINVAL;


> +	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_WAIT_SIPI &&
> +	    CC(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK))

Put the whole if-statement in the CC(), otherwise the error that shows up in the
trace will just be "vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK"
without any context.

> +		return -EINVAL;
> +
>  	return 0;
>  }
>  -- 2.54.0 (Apple Git-157)
> 
