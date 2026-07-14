Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF544C640
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057490; cv=none; b=RR0aqP6QwwPhRDo2OOWw0Yijg8gxznGo9sF9p/ihkNBcdW0hj8ajozsWBQRHIi77gg0wVubpVxFLteceuSJCjNzjp4Y6ltxlkue6oyLCIRTSlx5AmKUbDdLnSgoS8Un2zDadRPbXF0neqTcR5ETHh5o8sRG6d+kVHn1944aqyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057490; c=relaxed/simple;
	bh=iG8hwp+rHHFEOMU7Zki8YFVmq0hCko/EZAd1I5tGeOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BSpghceoRql7OTKgOoNuIXAxnwf2vdPOIxTuPbhhiFJjlHYv9YVtk6sB/a8dPyo8YoROHfBMJvAFmmgkUGg3DNHxVn2Q4Hzs8tT4dzxlS7pB7qPI/4eiivdf7ebjK4nu+7JaZKNU0RrIer6iAkUYaegn+u3w1aSeZ3ZbsDPrsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXqOFvYT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXqOFvYT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc86a9ef97so98364995ad.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057488; x=1784662288; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/lTpCU/U4vEjJk+n9KMtNC2cd01M0QED221gVwRcMk=;
        b=vXqOFvYTXgffS4QFInwwr7r4U9s90vaTwbhkyXA/28dvBJsnUgwFnQ7gbFT9X4AJFg
         1Hqa+VwNaaj9imbc8amA/ZOL2/lVGYJ9/ksak+O9T5owPCRcfpxKcyWJV1EOoywVnejj
         eL1tDn7LiwPt1STeZ2XVkfm+QBEy2tc2TFKLY6TvWb7zIOqgQTKeVsa7on/Xmr5kMLHS
         cqPoAy0oO0dQo+yZaBYIhX8mHrZYEPYOmxgm65UBsSGIJbSRWyXkydiRz7tJH9sAlkhH
         swUt3N6/uSadAZc/ailqhunK5bk24BNwdgLkCeLb9CUaTlbTVDG8pahUtq2cuVqsFxR9
         q+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057488; x=1784662288;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/lTpCU/U4vEjJk+n9KMtNC2cd01M0QED221gVwRcMk=;
        b=e3B59ZPZIgbE5uBBEmWbXlLibVN6CjZABXFtAX43c8icBt/FiUR5zLiVStiUSM0BaU
         EAf25y2+3qYIqkpp9yxtyYmkBWwhkja0+3hebkVEVYhtCuk8blKJCdOZANxL5EKMdZRB
         7AHsXYe7nlHEj6sicGW3ZrTnnm2gG9he1rNukDxEDK8rJUQtsXoRXjk+ZDROfDPhdDuN
         P49e0Cg2hhwixh8deOOj4AI/A4PU82d47r6hTMyS2bH7jaaaoA5Ulob6FxHv2xOBAe8E
         V/A4fRhX84Xg/M8jRlYus5XeRnl0V57kcep8yOE8QuftnHAh/rOtjZbkEEsB9eGN/4qX
         NyzQ==
X-Gm-Message-State: AOJu0Ywuc8F2ZdtT2UCI59Gr2toU/YG3xRW+bYBlUxaoOH4/jRZh7gm7
	G7J4VHHZU2Q/7Myp8k3W1xSNYbVIxCxCnYZuHAkPJIu8EbC1jF9JQAWq8/y35QIJx4+dY3wkpkM
	iYlt9wg==
X-Received: from pgls18.prod.google.com ([2002:a63:5252:0:b0:c86:5eaf:dd87])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9203:b0:3c1:142e:762d
 with SMTP id adf61e73a8af0-3c34d5299f3mr6467344637.1.1784057488350; Tue, 14
 Jul 2026 12:31:28 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:31 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405363516.3123834.2010609317440120598.b4-ty@google.com>
Subject: Re: [PATCH v4 00/11] KVM: x86/hyperv: Fix racy usage of vcpu->arch.hyperv
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="utf-8"

On Tue, 30 Jun 2026 15:56:07 -0700, Sean Christopherson wrote:
> Fix a bug found by syzkaller (originally on a Google-internal kernel, but now
> on upstream as well) where KVM consumes a vCPU's HyperV structure before it's
> fully initialized, by concurrently triggering PV TLB flushes (queues flushes
> into a vCPU's FIFO without holding the vCPU's mutex) on a vCPU that is in the
> process of activating HyperV.
> 
> Harden against similar bugs by asserting the vcpu->mutex is held when using
> the "normal" to_hv_vcpu(), same as we did for get_vmcs12() and
> get_shadow_vmcs12() (also in response to cross-task races).  To avoid false
> positives when creating a vCPU, initialize vcpu_idx to -1, and treat the vCPU
> as unreachable (other than the caller, obviously) if its index is -1.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[01/11] KVM: x86/hyperv: Get target FIFO in hv_tlb_flush_enqueue(), not caller
        https://github.com/kvm-x86/linux/commit/d151ca6e1289
[02/11] KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in kvm_hv_get_tlb_flush_fifo()
        https://github.com/kvm-x86/linux/commit/b6de8bfdab32
[03/11] KVM: x86/hyperv: Ensure vCPU's Hyper-V object is initialized on cross-vCPU accesses
        https://github.com/kvm-x86/linux/commit/c84d86130f24
[04/11] KVM: x86/xen: Always route non-singleshot-timer vCPU hypercalls to userspace
        https://github.com/kvm-x86/linux/commit/e4ffb0ceb9f4
[05/11] KVM: x86/xen: Consolidate checks on Xen vCPU ID for singleshot timer hypercalls
        https://github.com/kvm-x86/linux/commit/32d7943e5179
[06/11] KVM: x86/xen: Punt singleshot timer hcalls to userspace if Xen vCPU ID isn't set
        https://github.com/kvm-x86/linux/commit/c10bd49bdcc9
[07/11] KVM: Initialize a vCPU's index to '-1' while it's being created
        https://github.com/kvm-x86/linux/commit/b29125ead04d
[08/11] KVM: Move nVMX's lockdep logic for vcpu->mutex to a common helper
        https://github.com/kvm-x86/linux/commit/e34be29ecd47
[09/11] KVM: x86: Treat a vCPU as unreachable if its index is invalid
        https://github.com/kvm-x86/linux/commit/c33aef581703
[10/11] KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
        https://github.com/kvm-x86/linux/commit/53ce2c773f00
[11/11] KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task synic->active accesses
        https://github.com/kvm-x86/linux/commit/09dd4de361dc

--
https://github.com/kvm-x86/linux/tree/next
