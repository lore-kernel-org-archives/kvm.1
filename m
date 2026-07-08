Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00A372EDD
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525688; cv=none; b=q1kmlfZavxtPCPGVqw42m4O6dfrMJ1GP2ZQW1YRA3Vb9iYKF4AkKSneuVbvP0cisG2SAlsSCIXbCIRn6kEvcxCvRMI+/D5xd5qxOwkLeMpf/hcSLmYM/WQYxAA0S8AbTGapP+vG2mcrZ1I3aOxJoL8UK9SlhEP70OLOtdpm56GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525688; c=relaxed/simple;
	bh=wKbZlrdMXTskiRZn3Ml2E3DIg60TMBjRD+RrQBRLe0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aEBWihjHHe9T/P8sNYHK0qZZE4lNm8pDnWaMV11/5ga07lHS5Hpyg2AI6oMR1qnoJOBWvjjK53gfB1vMEF7mOtcjBjwPr9tdXz9D9UxPbsM1bSyQn0amzT9nl/Y2zOgj39BM8GllKSn4ZvZxNjayxRYbsljm9n52OTNNhejrWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEqkgcyH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEqkgcyH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc88e22f92so20717465ad.1
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783525687; x=1784130487; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+3D1OcYubcY+wxAzMdz1HXxsjNsoivr4HC9rMwUTA8=;
        b=OEqkgcyHbFk0eMqwrdufzMJq5NaAV3M62c+CqPNdDhYBdNachhfks8vJQP+CBNYZs6
         tVOwgRuotq4WFMlCCoICg/FEY8kEMntk63ptgbtiwds+79gfi6Fs+HWaAjk1rj1pD9fc
         OHpG2x/9T2m4bM4vLyWAt2ebMMSfC2zg2upV3R3DAtXaE4NjDMERYHN11ha4L3dQnpNj
         8k64tucfcZ1zfsuISKdL5gzitlRxCDu8l+lM14IOEQ1gNWPq/4rBFZd4aIuZV7OMNjTo
         zd9I4wpsJ3qlijMxKuJDKItZ8z6Am7HtTVFguQS50vk1XxkTFDSSpKc9Mh+muoCaPvwA
         3KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525687; x=1784130487;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+3D1OcYubcY+wxAzMdz1HXxsjNsoivr4HC9rMwUTA8=;
        b=l5AoHDiLbpFVYeNohiP34ySMbTSp7J6atu9hSYb8edHzacvIBgns7wXCWpfQKqMIua
         tfVfq7oJgkGlyET+Z9zxZSCdqzI6oag28w9gDqApyUF2UE4duqQVVZBVNgPjkRdapVKm
         sRdbjgXfuL+spPJ5vsXWZC/vBgF00/c7rFtox76s7bhnspGYTug6tyIj/NagSX0Sgxc0
         ij7X2tREegpc8/e6B9KQbctZqIpOIUQ9zhYxwb1x0sAhHPBuayoh5sQ4DpHL/J5smNu7
         aDchu8wBaclyNCTGab2B7I2wIMqRmagUV2zkC4xrlDFBtTJ91tLHrMqAf1TSErls+qwL
         SbOw==
X-Forwarded-Encrypted: i=1; AHgh+RrYDmoBUpP+Ejn/RQJdr3CPOFpUM8Kuywd0lLo4WbAdnIa/qimOSQtaT2CIxR7dBkV+Qnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz989gIpLiEn0bQakE2kMdByBZr5g6B2X3Af2v81SwcVItjc27N
	1teeJ/LWnP+HmSyoBAWcVfgUkG5f8DLP6lW0IX7zNlrfykjpNn+PlpexLTnw/UcWMiRxleX4BvJ
	AqJ9bJw==
X-Received: from plblf6.prod.google.com ([2002:a17:902:fb46:b0:2ca:bb31:40b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2984:b0:2cc:7759:ffac
 with SMTP id d9443c01a7336-2ccea37b8c8mr32092505ad.30.1783525686681; Wed, 08
 Jul 2026 08:48:06 -0700 (PDT)
Date: Wed, 8 Jul 2026 08:48:06 -0700
In-Reply-To: <20260605143034.3603-8-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605143034.3603-1-dwmw2@infradead.org> <20260605143034.3603-8-dwmw2@infradead.org>
Message-ID: <ak5xNubAIov1QT6T@google.com>
Subject: Re: [PATCH 7/8] KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_sel
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>, Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Replace test_and_set_bit() on vcpu_info->evtchn_pending_sel with an
> explicit 'lock btsl' in kvm_xen_set_evtchn_fast(). The generic
> test_and_set_bit() uses a 64-bit locked operation ('lock btsq') on
> x86-64,

  x86-64, and the address of the per-vCPU info is guest-controlled and
  only required to be 32-bit aligned.

I would also add somewhere:

  Note, KVM reuses the local gpc.  The atomic accesses to pending_bits is
  on the page-aligned per-VM shared_info structure, i.e. doesn't need the
  same treatment as the access is guarantee to be 64-bit aligned.

Because without that knowledge it's very difficult to understand why the
test_and_set_bit(xe->port, pending_bits) is fine but the one the event channel
is not.

> which requires 8-byte alignment to avoid split-lock #AC
> exceptions.
> 
> Since evtchn_pending_sel is at most 64 bits wide and port_word_bit
> ranges 0-63, a 32-bit 'lock btsl' suffices for both native and compat
> vcpu_info layouts, and only requires the 4-byte alignment that is
> already guaranteed by the registration path.
> 
> This also eliminates the bogus cast of compat_vcpu_info's 32-bit
> evtchn_pending_sel to 'unsigned long *' which was the original source
> of the split-lock hazard.
> 
> Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
> Reported-by: sashiko-bot@kernel.org

Please add the Closes: link for publicly reported issues, especially for flaws
reported by review bots, as such "bugs" are generally unproven.

Closes: https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org

> Assisted-by: Kiro:claude-opus-4.6-1m
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/xen.c | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index ae0713718367..24e939ef5d64 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -1811,7 +1811,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
>  {
>  	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
>  	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
> -	unsigned long *pending_bits, *mask_bits;
> +	unsigned long *pending_bits, *mask_bits, vi_pending_sel_ofs;
>  	struct kvm_vcpu *vcpu;
>  	unsigned long flags;
>  	int port_word_bit;
> @@ -1844,11 +1844,18 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
>  		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
>  		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
>  		port_word_bit = xe->port / 64;
> +
> +		vi_pending_sel_ofs = offsetof(struct vcpu_info, evtchn_pending_sel);
>  	} else {
>  		struct compat_shared_info *shinfo = gpc->khva;
>  		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
>  		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
>  		port_word_bit = xe->port / 32;
> +
> +		vi_pending_sel_ofs = offsetof(struct compat_vcpu_info, evtchn_pending_sel);
> +
> +		/* test_and_set_bit() needs 64-bit alignment, but that's OK */
> +		BUILD_BUG_ON(offsetof(struct compat_shared_info, evtchn_pending) & 7);

		BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct compat_shared_info, evtchn_pending),
					 sizeof(unsigned long)));

>  	}
>  
>  	/*
> @@ -1864,6 +1871,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
>  		rc = -ENOTCONN; /* Masked */
>  		kvm_xen_check_poller(vcpu, xe->port);
>  	} else {
> +		bool old;
> +
>  		rc = 1; /* Delivered to the bitmap in shared_info. */
>  		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
>  		read_unlock_irqrestore(&gpc->lock, flags);
> @@ -1880,19 +1889,24 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
>  			goto out_rcu;
>  		}
>  
> -		if (has_64bit_shinfo) {
> -			struct vcpu_info *vcpu_info = gpc->khva;
> -			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
> -				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
> -				kick_vcpu = true;
> -			}
> -		} else {
> -			struct compat_vcpu_info *vcpu_info = gpc->khva;
> -			if (!test_and_set_bit(port_word_bit,
> -					      (unsigned long *)&vcpu_info->evtchn_pending_sel)) {
> -				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
> -				kick_vcpu = true;
> -			}
> +		/*
> +		 * Explicitly use btsl instead of test_and_set_bit() because
> +		 * a 32-bit guest is not required to align to 64 bits, and
> +		 * that might cause splitlock exceptions.
> +		 */
> +		asm volatile(LOCK_PREFIX "btsl %[bit], %[sel]"
> +			     : [sel] "+m" (*(u32 *)(gpc->khva + vi_pending_sel_ofs)),
> +			       "=@ccc" (old)
> +			     : [bit] "Ir" (port_word_bit) : "memory");

Use GEN_BINARY_RMWcc() to make this less ugly?  It'll still be ugly, but slightly
less so.  Completely untested, but I think it's this?

		old = GEN_BINARY_RMWcc(LOCK_PREFIX "btsl",
				       *(u32 *)(gpc->khva + vi_pending_sel_ofs),
				       c, "Ir", port_word_bit);

> +		if (!old) {
> +			struct vcpu_info *vi = gpc->khva;
> +
> +			/* No need for compat handling */
> +			BUILD_BUG_ON(offsetof(struct vcpu_info, evtchn_upcall_pending) !=
> +				     offsetof(struct compat_vcpu_info, evtchn_upcall_pending));
> +
> +			WRITE_ONCE(vi->evtchn_upcall_pending, 1);
> +			kick_vcpu = true;
>  		}
>  
>  		/* For the per-vCPU lapic vector, deliver it as MSI. */
> -- 
> 2.54.0
> 
