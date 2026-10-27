Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141645;
	b=PscqS6JbQ1ANmT7TBfkHya7+Op9AziTNNwi1M9Efd3wAeTUbQ2UqGl7SdAb4Yd9gwEKX
	 EzE69t2PfJkl2yj1o1K2TKhfXR4i40K/paHDgyDlwausnQqKb774YlbQH7w+KDIDSgz/T
	 tcqL0N/jMxJ1XJbc19IyBpEcCBYIAatjq2l0Eiaw9sk1NmD1tz/KqjRnYJ8EbBrV+Rsz0
	 uJzlkF6LZbgWSauHnuDNAEoES/i+EUt9DcKGTVtLI6qyNiMKjwaepp7vRUs0aEBbb9aD8
	 qQgG6HPsf7vm0S5FHau5+cslOlbdtvB5CpcsxFro3S+E3C0UID2vvDS1NCFHA2xJyUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=aTRn4SWx70tTlL1t7OA3leiDcQwKF7nF9/sYzOx9ZSQ=;
	b=MNfrMhs/f9vN7iat1A8BJPw9Ez6xjwLtMQiImg+UHH7KhhQPeO7BKijdIXw5QO9Z12u4
	 eXeaQlCGQcJTl8yj8l6v+GcQV/gULtf5iGclKnNEE+nbDARUfG+Eb/viCs7AtHjfYTCgd
	 00yfi1JB+QbsyKoqkzR0wRbfAG1X1Xg5CYojxksw4sCanpzECvbR0pUkyEfQDyb01fWHc
	 VwFwOSLnAydWmyFLTc5jzqv8uCvps997ZEr3kZL1TFQRZ7sud/gXIE8WlMuhSOsQM0CUS
	 G1ul6myIp1S1+L8FpZ/4TDQRbaEG6XZMMh0UaVBB9/N+/0snid+EYr2wbLY9Fw5LHDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tjvm4OTH;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7E606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05C7E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tjvm4OTH
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3addd73e66bso326309a91.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793141644; x=1793746444; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTRn4SWx70tTlL1t7OA3leiDcQwKF7nF9/sYzOx9ZSQ=;
        b=Tjvm4OTHubuauVIdpvdpK6Lbof0ner3JY88hCht1u/p+BdFkDn1u0Vnsgz6I9aSUUl
         Wi5/m+oFw3/Cis2MIuCbYFm7O9EdXdEdjrGLPtFwKPgG8oX27lWUNcx5T4wk4EROnsWI
         jxedGJJAoe5UeYy4AanNI2PoDr8fsLYZtbv8xyjIWXCdDhpLhYj4pAlOZK/OA+AxGZ0Z
         +6gQYZSBtVt4KyBrXoH7MCspG9686tVJ0hW6AIocV4RpUSGN+zZCH3bGkFKItgPRqo4y
         /z2lh6+ZbW/LUVDPxXMPuEqfV9Ecya/acr9Kk6+gDu4zzTEkX3moGLYrUqU18X94FJ/E
         2rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141644; x=1793746444;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aTRn4SWx70tTlL1t7OA3leiDcQwKF7nF9/sYzOx9ZSQ=;
        b=jaCtgNc+YmvZ+0brXB7cLXFGbqrJnu3HIi6+P1M8CDBjXgu0ESLvIG1haqn1koUV9m
         j/zsTM+EFRKwhjqrhuoruz44Ia7i6d6+3ooIJIoNAGQf7Diod3q/9efGO/ip6GhOTwOO
         CednZXelhW+ucgPZPFCSJKDn8m2tTBe3T+1m+UfoLynr/eBYV3OUDLfj9Kq5+zoiWWTr
         34BBM7tYw+u0nB56QZavsK3vSm4FAtH+W7W4yoZ6pyLut3zJOYcB558XqxRX66UIhILc
         T9GvLiXSpHz5OGI8sLOq8kWC3v/mIhmfIq3t9jDGGC5omxGPbr1BlYJFhyWZvaiatq1S
         LZ/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZKuUE5p17M4y4W/zPO+EJqog7LGRsPx0cFErZdUJr6ANvetvqp2euVqFqqcXZkfrvWiA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbOl+EC00O1Drqtn53yfYSIroBgfGp64R0PaTGYRVr8VhZu+tB
	P9ICa53tQNnsixnVwmCStScwh6XicameHg0kihbA7Zh/Abw1Wc+iulnA0M7HdoDwy9rbjHERn3U
	IlRW1Vw==
X-Received: from pjx16.prod.google.com ([2002:a17:90b:5690:b0:3ab:3069:a58c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c5:b0:3ac:a11a:7c7f
 with SMTP id 98e67ed59e1d1-3ae581006c1mr311269a91.23.1793141643965; Tue, 27
 Oct 2026 15:54:03 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:54:03 -0700
In-Reply-To: <20261027221209.1560865-3-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com> <20261027221209.1560865-3-seanjc@google.com>
Message-ID: <auEri3Ld3sp0515i@google.com>
Subject: Re: [PATCH v3 02/15] KVM: nVMX: Don't force a full nested VM-Exit
 when destroying a vCPU
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Content-Type: text/plain; charset="us-ascii"

+Hyunwoo

On Tue, Oct 27, 2026, Sean Christopherson wrote:
> For all intents and purposes, revert commit b4b65b5642d6 ("KVM: x86: cleanup
> freeing of nested state") and go back to manually tearing down nested state
> when freeing a vCPU.
> 
> When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
> VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:
> 
>   vmx_vcpu_free()
>   |-> nested_vmx_free_vcpu()
>       |-> vmx_leave_nested()
>           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
>               |-> nested_flush_cached_shadow_vmcs12()
>                   |-> kvm_write_guest_cached()
>                       |-> __copy_to_user(ghc->hva, ...)
> 
> Accessing user memory via a memslot during VM destruction is broken, as
> there are no guarantees that current->mm == kvm->mm when the VM is dying,
> because the last reference to the VM can be put from a different process
> than the original creating processes.
> 
> And even if the original process does put the final reference, during
> process exit, do_exit() calls exit_mm() before closing file descriptors, so
> vCPU destruction runs with current->mm == NULL on a borrowed lazy TLB
> active_mm.  If the borrowed address space has a writable mapping at the
> to-be-written userspace address, KVM will corrupt an unrelated task's
> memory since uaccess APIs, including __copy_to_user(), don't sanity check
> current->mm (and *can't* sanity perform KVM's current->mm == kvm->mm check
> since that is firmly a KVM-only concept).
> 
> Furthermore, the shadow VMCS flaw is only the tip of the iceberg, as the
> MSR load/store lists mean that emulating a nested VM-Exit can read or write
> an arbitrary set of MSRs, e.g. if MSR_KVM_SYSTEM_TIME_NEW is in L1's MSR
> load list:
> 
>       kvm_arch_vcpu_destroy()
>         kvmclock_reset() - takes pv_time off kvm->gpc_list
>         vmx_vcpu_free()
>           nested_vmx_free_vcpu()
>             vmx_leave_nested()
>               nested_vmx_vmexit()
>                 __nested_vmx_vmexit()
>                   load_vmcs12_host_state()
>                     nested_vmx_load_msr() - writes the MSRs that L1 listed
>                   kvm_cpu_has_injectable_intr() - reads Xen's vcpu_info
>         kvm_xen_destroy_vcpu() - deactivates the vcpu_info cache
> 
> processing the MSR write puts the "pv_time" cache back on kvm->gpc_list,
> and the next list_del() writes into the freed vCPU.  And as effectively
> pointed out by syzbot[*], attempting to fix each case individually is a
> losing game of whack-a-mole.
> 
> Deliberately leave "nested_run_pending" as-is, because even though doing so
> creates potentitally inconsistent state, KVM should *never* consume said
> state while freeing a vCPU.  I.e. if leaving nested_run_pending set trips a
> sanity check or bug, then that just means there's more fixing to be done.
> 
> Open code only the "free vCPU" path, i.e. keep emulating a nested VM-Exit
> when forcing a vCPU out of L2 via vmx_leave_nested(), as there are a number
> of updates buried in the nested VM-Exit flow that are needed if the vCPU is
> going to run in L1, e.g. clearing pending exceptions and MTF traps, setting
> the TSC offset+scale information back to L1, and so on and so forth.  Note,
> this means svm_leave_nested() is all but guaranteed to be buggy, but that's
> basically an open secret at this point and at least any bugs "only" break
> L1, i.e. don't corrupt host state as is the case for abusing nested VM-Exit
> when freeing a vCPU.
> 
> Link: https://lore.kernel.org/all/6ac0145f.34119e79.2f92f3.0003.GAE@google.com [*]
> Fixes: b4b65b5642d6 ("KVM: x86: cleanup freeing of nested state")
> Cc: stable@vger.kernel.org

I completely forgot that Hyunwoo also reported this, so this also needs:

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/all/am3Bs0DjZ5kay9NJ@v4bel
