Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751437;
	b=NxljycdBUWB4b/dU+umZx+cGSBGG2yOvpsENVfnlcanfgAr0YbRELzwx07In56aqIzTD
	 VmoY33rxh9ESIiV1utgwKe4zvw/Pt66lo9ODieFgonJJqadB9WH+1g2XDKeXcOcmwkT+8
	 +vdkODWqfh8/tKLNecW25GJ+nVDvQbFMNpncY/D+JQIU/JJ8ukzrPro8NSZ3V2uhECG3x
	 fm9mMphid/ei+P8453NCkjrV26XS/tGBAI6sdkQbYuUqEWzrdJME2fyzumXkVzTxtzD2G
	 CnxRn7LpFyzuSFJfrijJJeCbYxWcrbM4XpVZTFi7xWOgvjzZca8gbRZqgSv5tUeycgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LhyvKds25xNhoCjxUA6XF46cL6FC3po2ea3t+x75DYw=;
	b=hpl4edi1vowr97FCPy6S1usGL7gT1DMooue/l+v3Wx+qmF5jXFeotwuiOi6nBc8v9nLw
	 XbJ+wTAWAwwi/1/8GiuxUeQOOHEjOAMvV1XlhTj7acd9fL4Tf5bFaLrkryMQjjiCkQ9Ou
	 9fAhn5zW8EjMERSP/m8HOMDuE+vQ0ySflKSJz2psI7SKwbLf33niJPbg26LyqoIGlUoWM
	 8Fwp9uShXlXYWLUORkqLNN82/0dlrWm8iwTfiIh/fOZD9wUDbPW3/XOuyEK3ye4Bokqou
	 YbROMP8vrz4P3LQ5h7J/AjVwUAosisC/ygDoTdxwG8WQJrxmZ+fp5znCUi7yWKBbnKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dM37UUpx;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F42606A329
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 00:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F42606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dM37UUpx
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-89e05d31e54so151076b3a.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 16:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793751436; x=1794356236; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LhyvKds25xNhoCjxUA6XF46cL6FC3po2ea3t+x75DYw=;
        b=dM37UUpxJVzXkZ0mhV32s9w22jq5BNSFORhX99K+DghMAbLEB1S7xNYLXZKfmTlRiJ
         +OyxNHQI13LXrL6H76G/VN+GLtLk/NH6vixFqOLbuu4OevAHc18NJkao45Tu++wo9Zi+
         shgTlr2cTCeO/aKRt6NJEvxmt+WL0+yKyzrO6KqwFjZrHDRtsTnJawVRqgJ/k+PDcJxx
         Da0uhSF8ULDol35fXSThz/snCQqwy24flrl4NWV3XTchk0iq1TMRDGTi+rssZUg5Co+q
         OXAujGjTWy3i94qwDpXpKMRFnUtiR39Py0u8h+xLXXCD4806JeRfLcmFh4zzQ1GWbHP4
         M72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751436; x=1794356236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LhyvKds25xNhoCjxUA6XF46cL6FC3po2ea3t+x75DYw=;
        b=r8BtKGsoASa3WE0f8zdaMGADAklWtcs9zJvk0Hb99DnQw6zEB1r8hko6R/0F1sEpPT
         mFmYEOuwAuCvDkgAglteDD4v0e/D85axrSDoAxLzTxVQf+dfGYSxNWlViJpha49h5Mrm
         eSsWwzThDLEiaLuMyuRT5gnNGAqZL8be0WiD+vJDVHM0utbfTi+IQRZy81BrQSW20LXu
         lH/F9JY1iTiVaEG4ppe1WFEY5JKKlCaoQzN8tfsynPkm7jv2vCmgMPyArdiMi42zZP+t
         KopugJHXpTA326UbpmCKjMZrcfYthvaXC4gJ8FEFtWAW4O8ybBwCrqWMuGzIYdsfn1FY
         bWHQ==
X-Forwarded-Encrypted: i=1; AKwUvByh1pgGeJe8PpITblRhJb6y0PTnIYmZ+4fJ50Q1pYw4IIF8woUeAf0+tGB10ZzwCM1kyR8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8piJvLjAQHm1gKUR2hMXZbKASQQFpHUo4LTuPyqYXYOblre82n
	eH31EE9voJl4hIyqzLzynu0dq2zMfbPwCeWG+Z6Vg1heHx5L/H/D3TgarvkcneqTroal78O63bU
	cVAos9w==
X-Received: from pfgg3.prod.google.com ([2002:a05:6a00:bd83:b0:8a0:cc:2b89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b4a:b0:89e:cfbb:e8af
 with SMTP id d2e1a72fcca58-8a9ba8fb9c0mr10230607b3a.6.1793751436089; Tue, 03
 Nov 2026 16:17:16 -0800 (PST)
Date: Tue, 3 Nov 2026 16:17:15 -0800
In-Reply-To: <se1h6b4t.ritesh.list@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-13-seanjc@google.com>
 <sashiko-outbox-191627@kernel.org> <auitWWkOopYYbBH3@google.com> <se1h6b4t.ritesh.list@gmail.com>
Message-ID: <aup5i73T5aOKqcYS@google.com>
Subject: Re: [PATCH v4 12/23] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 03, 2026, Ritesh Harjani wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > +Gautam and PPC lists/maintainers
> > On Fri, Oct 30, 2026, sashiko-bot@kernel.org wrote:
> >> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> >> - [Medium] KVM: PPC: Book3S HV: rmap_nested memory leak in kvmhv_release_all_nested()
> >> > @@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
> >> >  		kvm->mn_active_invalidate_count = 0;
> >> >  	else
> >> >  		WARN_ON(kvm->mmu_invalidate_in_progress);
> >> > +	kvm_destroy_memslots(kvm);
> >> > +
> >> >  	kvm_arch_destroy_vm(kvm);
> >> >  	kvm_destroy_devices(kvm);
> >> > -	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> >> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
> >> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
> >> > -	}
> >> 
> >> [Severity: Medium]
> >> Does hoisting kvm_destroy_memslots() above kvm_arch_destroy_vm() leak
> >> struct rmap_nested allocations in slot->arch.rmap on PowerPC Book3S HV when
> >> destroying a VM with nested virtualization enabled?
> >
> > I don't think so?  Patch 3[*], "KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()",
> > should free the rmaps in response to kvm_arch_flush_shadow_all().   From what I
> > can tell, the page tables have to be in radix mode, and so the rmaps are freed via:
> >
> >   kvmppc_radix_flush_memslot()
> >   |
> >   -> kvmppc_unmap_pte()
> >      |
> >      -> kvmhv_remove_nest_rmap_range()
> >         |
> >         -> kvmhv_remove_nest_rmap_list()
> >
> 
> That's correct. Maybe, I think Sashiko didn't consider patch-3 of the series
> during review of this patch-12.
> 
> > And if that doesn't work, it means memslot deletion on an active VM is completely
> > broken.
> >
> > However, it means the memslot code in kvmhv_release_all_nested() is
> > dead code,
> 
> Not really. I do see a caller of this, for when we switch from radix
> to HPT. So we still need it.

Oh, nice, I somehow missed that.  Yay, less work to do!

> INCOMING CALLS
> - f kvmhv_release_all_nested
>   - f kvmppc_switch_mmu_to_hpt    [arch/powerpc/kvm/book3s_hv.c:5591]
>     + f kvmppc_alloc_reset_hpt    [arch/powerpc/kvm/book3s_64_mmu_hv.c:144]
>     + f kvmhv_configure_mmu       [arch/powerpc/kvm/book3s_hv.c:6330]
>   + f kvmppc_core_destroy_vm_hv   [arch/powerpc/kvm/book3s_hv.c:5930]
> 
> 
> 
> So FWIW patch-12 as such looks good to me from PowerPC perspective,
> since those rmap entries will get freed up as part of the
> mmu_notifier_unregister() (after patch-3). Agreed that Sashiko
> comment does not look correct.
