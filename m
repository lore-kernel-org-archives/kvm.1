Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C0546E010
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491629; cv=none; b=XjSdRpE8jOBe9AQTP/EuCNGQ85ATT2bQmUxv5FdNJ4imBW3R86ZpG11x0dRhOFDomORyJSunEBzboZMzZMROO39wkefvtkSUxUCe7SAgepSS+6mGeynoXdXfjp76bQzqAgddwoz5C/9CV/PsVmnE++D76v324rgMFxbAvaSY6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491629; c=relaxed/simple;
	bh=LWX8eDrFpn0O1sl7XVBhLcCVcXXH7HP3dHxQ8HmNZPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=huKJ2JuE+QKU+5JxiaQjuRLYax6v7lJk49xSAvLm+nYgwMke6gr9B4vKxRgYyNtRbJQunBcTG9N/WQE7LpJvVaHLkXxmm9AymZPRSswi/aT3mA+2JqCzYWHWIlmsEiZy0jYn2ViZuiYucR4MI7+EvM2cg7JkJyexeah6Ue+XNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbQN/Lms; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbQN/Lms"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1101157a12.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 16:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786491626; x=1787096426; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45PzVi6GlKpHz3+ZRxW2EDnuD1UWmkJmuMSYxMTtVTA=;
        b=DbQN/Lmsn3+QG9Nl2qmxu19rr7RgyoGsFsf3YfHCukJMPwAahg9W3eWKbiecoHWQq4
         AUowti408mIZjVUU1rotRaydKnWBUA0YOwRjqYPE7BcYxkOHc4HDz0357x9cmNBBU3W5
         1aYSdSH65c7a9vf6nJpIHBrtkeF6z6CoOgslH0XefC5WdiXHS5PtkbpfTexFFFKBN6IH
         8M23djyBuQFqI7iRQLVa41z10pT5FGBtpBSqUhMaZ0AbUOahzBpk/nNXKFWIsWdjalOD
         4XOxegZrxFEO1pU3anz4w4CjrhgIaATIlud3MNAkozFD4SMyrRmWfZ4rvU4Gjzr1N4nP
         1PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786491626; x=1787096426;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45PzVi6GlKpHz3+ZRxW2EDnuD1UWmkJmuMSYxMTtVTA=;
        b=GwRnitvnZ3vVphWAD8larrsvmaSkign/Zg04cOO2J6/rCoyFX8m8bszq0gwix15ldS
         8QAUxkJoO9UlyJJOlyLUn7OxG5xzD+YXdOEsIGdHgG+OMTQ2yU4PCiRxAr91GZXGQEn+
         y538uFWfvepowjFLuDJ3xHnkIzHPNRVyErjqgSq1KNB62wQsDq7+CYnCIySOvNu4LnqA
         XnPLGbN7i7uNGlYHJ1g82FWFebw3NKcOW2xig9nB76j5Z8E+yO+tPP6zDsI0SBmMWqKB
         2Mygam4tNCWGm5QKqqV7O39EV13s5Ln2/K4gt1Z1VITUvfJfAWRTqmlmn9Crq+a2J5cH
         YrVw==
X-Forwarded-Encrypted: i=1; AHgh+RqF/G1Dv62xh0E76N4mADXjxs2M2WoCJQbBgE6GVgvS2mnDmDk99Vcww4lk/X4nw/erF68=@vger.kernel.org
X-Gm-Message-State: AOJu0YypiUtvRNMF5ddoLIWJ35bkclZ1WEZRVQxF7pkKYXzxdZMxLmra
	BQln0rEpbeR7VMVUVYi35Ua8R1vh31TtMu59xGv3RNFhdsfgkaZAa4L+wzg7kaXjv5JRCgsMzkm
	IsIMigQ==
X-Received: from pghr4.prod.google.com ([2002:a63:e504:0:b0:cbe:3df6:a1aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1c:b0:3c4:1916:9d44
 with SMTP id adf61e73a8af0-3cc3f913cbfmr444625637.16.1786491626070; Tue, 11
 Aug 2026 16:40:26 -0700 (PDT)
Date: Tue, 11 Aug 2026 16:40:25 -0700
In-Reply-To: <20260728144954.355376-32-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-32-dwmw2@infradead.org>
Message-ID: <anuy6QxUVLcSSVCn@google.com>
Subject: Re: [PATCH v7 31/36] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 28, 2026, David Woodhouse wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5c78dd1e4c69..0680332d7d45 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3435,6 +3435,169 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  	}
>  }
>  
> +#ifdef CONFIG_X86_64
> +static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __user *argp)
> +{
> +	struct pvclock_vcpu_time_info hv_clock = {};
> +	struct kvm_vcpu_arch *vcpu = &v->arch;
> +	struct kvm_arch *ka = &v->kvm->arch;
> +	unsigned int seq;
> +
> +	/*
> +	 * If KVM_REQ_CLOCK_UPDATE is already pending, or if the pvclock
> +	 * has never been generated at all, call kvm_guest_time_update().
> +	 */
> +	if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, v) || !vcpu->hw_tsc_hz) {
> +		int idx = srcu_read_lock(&v->kvm->srcu);
> +		int ret = kvm_guest_time_update(v);

Invoking kvm_guest_time_update() here is probably a deal-breaker.  Updating the
master clock and other internal state is far from ideal, but should be ok.

However, writing guest memory is not.  Specifically, dirtying memory after the
last KVM_RUN is a non-starter for many usecases, as is modifying state that is
visible via other GET uAPI (though I don't think that applies here?).  E.g. see
commits:

  118964562969 ("KVM: Mark a vCPU as preempted/ready iff it's scheduled out while running")
  e800decd9c0a ("KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN")

One idea would be to simply punt to userspace, i.e. return -EBUSY without trying
to update guest time.  Which is pretty darn ugly, but might be tolerable?  And a
slightly crazy idea to lessen the pain would be to process select requests in
KVM_RUN before bailing for vcpu->run->immediate_exit==true.

That doesn't completely solve things as it's still possible for KVM_REQ_CLOCK_UPDATE
to be set after KVM_RUN, but I think they're mutually exlusive with the majority
of relevant use cases?  And we'd probably want to build on my idea to report that
KVM_RUN needs completion[*], but that'd be a good thing overall.

https://lore.kernel.org/all/20250111012450.1262638-1-seanjc@google.com 
