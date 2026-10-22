Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682299;
	b=RUGDy1yDsseYoCTiWeEc8C3MZzLljpZJNU5OH8obnMjmgozsYrwLvUBAwI/9RzxKMj7k
	 JnLyA+76hAPdaisR6PKu1efBULsMbTn1jxe/Jz6nG/O9hQOkguMz/MK2MJ/4eodn4nNoy
	 zZrATijdHXl3Ie8ycxKaJ1fdYnyVozzryTP1ShmuXkuXIy4Ev5AXZ0neVEm8EnMQbIj4t
	 l/kYxc6qZy/nmsKLBP68Fg3itGDICeGKxFjJkK7spiXggAwAsVYD3N7RZI1WtPWQs8P16
	 PRzer1Pv+V2GsiBi4oJsin7C4utqAk3JGEB54NwAxLU9UtiDYj8M8thYkGnS17fFfIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HniuhSXVODkftgalbf0fI7rep8FcOjb4f6/hND3jnD4=;
	b=1r7LBAgzWnIL+RKaoIBakFuAOVD9U6AS1tHUNTkwATF6cchU7nNzo+A4xmkZ/3sZyaQI
	 j7i+E5nQdbZVOVzHmGg1z55lRoIL0dZnoGOlU9uY8ODrluhGRkbfuGHOeWR9e7dKiKbr4
	 dSd6WPud1SoClcZidM2XPspr2alCs8bsaf+Tlyc47nqYpPnfkbzTono4jOB3K/Z1SmeUO
	 N38WBj2MlCUDcNhmrlmKE5uQXvloDk1yTrpbdQUdOKIf3Lmz41ICYKP+yHAErQ0G6nt+3
	 pHKkH0Y5MOqQuv2efcbcMM7sXIjKcFifMDkUi/Wi09ytDsuIyk0FmeNtv6NTIwDq7DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iXuBBBOF;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF5606BE53
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 15:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0FF5606BE53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iXuBBBOF
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so2953720a91.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792682298; x=1793287098; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HniuhSXVODkftgalbf0fI7rep8FcOjb4f6/hND3jnD4=;
        b=iXuBBBOFv6muL9xjRDyIvX6rpd8gjK7ASghpV+nnqbcgt+23m55JUmSL2Ga0FNyWqi
         nhoyUw89f+UcRPlpBhPP0iW6Z5cOpniIUdpEhkCyCO3qcSe7DUCGYRCXe0EgGBx0YFbY
         TwZ4XsU2oFkT/r783+BkH67Axn8uDEOEgkYKt0neRWJDvP6rPBHECQlGwuway9wn/SwE
         J1dWz+30NqNg9O4kwTIpdr35npA2e4UV79IyrH2xIoFl/WCniV/gx26gZopXVIHjMPBl
         +14XqsXQnm5JJ4PEJH3tQ/dKbS/Oxsa6ylRDd98MGsTcYPEw30Frp9UoVoWR/QRbw+Vv
         lBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682298; x=1793287098;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HniuhSXVODkftgalbf0fI7rep8FcOjb4f6/hND3jnD4=;
        b=TXfWgCFtTqYkmx9rbXhjNRzz3va+4dS+STCwtGd6RDjv8o+Fn1GZGTVGOVlFH9GRGO
         M/lIjocF+NMzX9xdHcYG7rju9Rs3XpMNiak3pwIVnEmu1Zcywz22ZAUmYBSd7Kf0yoBH
         zxh8wDq44L+hXZdX9kZ+Nj813xDzbk85Hb2cqbB3nAGaDOUij/rc0VdBeqrYv2GnET2k
         6k1V/Vo6iaDDHRZfJEuyiv8vvpGPWcKv3sV5+xD8I7X6rKu0HAvXD795P9H+OdhguhF0
         PpjBK/AQhKzJAvuKVOca8kjGyzpnHoKW0QgxAcCojYkUnmwPztKkwc3yiKFwyuDnffmY
         f9CA==
X-Forwarded-Encrypted: i=1; AKwUvBwwnN4Qn6G7g2Ke5L5r6yO3UIj+xnqK9iH3IN2P+FsVu0NPTID/iih99S+RZaLRjhz/Jec=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjLKQQj06/Vrlz7lkMDF/eF6u30RCUY1rEur4CaKQZYRjAnhcz
	9EqBunv0/XIZbTJUIYlWy/WChlspQ5VsKr7411501VgHJUCwZVGYDfXFRvTmvH2daHKjCpSUryn
	4PRwFrQ==
X-Received: from pjst18.prod.google.com ([2002:a17:90b:192:b0:3ab:41e:dfcd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39ac:b0:3a0:9640:8039
 with SMTP id 98e67ed59e1d1-3ad86f454d8mr4908996a91.30.1792682298014; Thu, 22
 Oct 2026 08:18:18 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:18:17 -0700
In-Reply-To: <20261017093016.32348-1-amirmohammad.eftekhar@cispa.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261017093016.32348-1-amirmohammad.eftekhar@cispa.de>
Message-ID: <atopOWEJC9bDTtpi@google.com>
Subject: Re: [PATCH] KVM: nVMX: Clear nested.smm.guest_mode on a failed RSM-to-L2
From: Sean Christopherson <seanjc@google.com>
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 17, 2026, Amirmohammad Eftekhar wrote:
> vmx_leave_smm() consumes nested.smm.vmxon into nested.vmxon up front, but
> clears nested.smm.guest_mode only on the success path.  On either failure
> arm (nested_vmx_check_restored_vmcs12() < 0, or
> nested_vmx_enter_non_root_mode() != NVMX_VMENTRY_SUCCESS) it returns early
> with nested.smm.guest_mode still true while nested.smm.vmxon is already
> false.
> 
> em_rsm() turns that non-zero return into a triple fault, but the vCPU is
> left with the internal pair (smm.guest_mode=true, smm.vmxon=false).  That
> pair is not representable in migration state: vmx_get_nested_state()
> serializes KVM_STATE_NESTED_SMM_GUEST_MODE without
> KVM_STATE_NESTED_SMM_VMXON, and vmx_set_nested_state() rejects exactly
> SMM_GUEST_MODE && !SMM_VMXON with -EINVAL.  KVM thus serializes a state it
> refuses to restore -- a save/restore (live-migration) round-trip break.
> 
> The leak is sticky: free_nested() and vCPU reset do not clear
> nested.smm.guest_mode (kvm_vcpu_reset() gates the nested unwind on
> is_guest_mode(), false here), so a later VMXON re-exposes the bad
> KVM_GET_NESTED_STATE with no SMI/RSM involved, for the life of the vCPU.
> 
> Clear nested.smm.guest_mode before the consistency check and re-entry, so
> it is cleared on every exit from the block.  nested.vmxon is left true,
> which is correct (L1 does have VMX on) and round-trips cleanly on its own.
> Not a memory-safety issue; fidelity / migration only.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> ---
>  arch/x86/kvm/vmx/vmx.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1f802cdbe..56332a85c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -8381,6 +8381,18 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
>  	}
>  
>  	if (vmx->nested.smm.guest_mode) {
> +		/*
> +		 * Clear smm.guest_mode up front so the failure arms below, which
> +		 * triple-fault the vCPU, cannot leave the internal pair
> +		 * (smm.guest_mode=true, smm.vmxon=false): smm.vmxon was already
> +		 * consumed into nested.vmxon above, and KVM_GET_NESTED_STATE
> +		 * would then serialize SMM_GUEST_MODE without SMM_VMXON, which
> +		 * KVM_SET_NESTED_STATE rejects (-EINVAL), breaking the
> +		 * save/restore round-trip.  The flag has served its only purpose
> +		 * (bringing the vCPU into this re-entry) by now.
> +		 */

The gorty details of exactly how this shows up in migration are great for the
changelog, but the comment should focus on why this is "architecturally" correct.
Unless someone objects, I'll fixup to this when applying:

		/*
		 * Note, even if RSM ultimately fails (hits SHUTDOWN), the vCPU
		 * is no longer in SMM with the intent to return to L2.
		 */
		vmx->nested.smm.guest_mode = false;

> +		vmx->nested.smm.guest_mode = false;
> +
>  		/* Triple fault if the state is invalid.  */
>  		if (nested_vmx_check_restored_vmcs12(vcpu) < 0)
>  			return 1;
> @@ -8390,7 +8402,6 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
>  			return 1;
>  
>  		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
> -		vmx->nested.smm.guest_mode = false;
>  	}
>  	return 0;
>  }
> -- 
> 2.54.0 (Apple Git-157)
> 
