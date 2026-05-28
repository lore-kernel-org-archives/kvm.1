Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1042343893
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927257; cv=none; b=uWRVMxCw3/vudDaJT9+I2+g4uzFulQQlskMdRtmvRtr6T6D2DG8qY+stdhZBxwMs8ogZlKxU29IkaJzPIVAncwYAFhcOhqjUr+aNfjWjMYYO1R7r2kr/+vSQgS0dE0A4zzy8R7KIxLAL31NFWh2kQ7DTQ4RVOwnHzc6ujWQz/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927257; c=relaxed/simple;
	bh=8HnSLy4ot1aYCosD/gG1bQ0+hEo0+hbo1CxoMKVzGEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NYsPyTB5mAgVHYMRblj8ufEiHuyQ8NhPjeKBJf0LWnvZpCjSjOk3QFTE97hq72u8QTx22wrOkKQS0QwKN/hUKf0bhX405lZR5xtCPy40wzyq7QMtW02N4ytd601yDQwR5rnj2kE0ZNujVRNmzJzHiSlAcJPg35SF2LadxVITeo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJy5TYxZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJy5TYxZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2befe912949so4629645ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779927254; x=1780532054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrIZ9K4QbitiO96jnl3s85zCFXsrBTuum6gLzlFg8Ns=;
        b=OJy5TYxZ9LoLnOabKLhOG6uNONgI83yryPSkSb3FihBzHFtTQmhY3N1f1bB46tfMen
         3T2SRmOoe3iXYGhVOg3+6sIvgQspmwqzjDqA2mMUuMG65daXgUB6UBsuMjgNdB0/KkHQ
         g8EsGihbz+0O92RApVN2eP1dPeVMjQUiZbokbIdf0S81Eb/0kQsaKW/FSrVGWg+Qgfj2
         KExReR1+LyGaXpct/QOwJpW007jIYVJWlhSslrPZB+nzo03L/cMJzpN6GgNTmklqIlw6
         TMBVBHIh0hsoEZktMdiYjAPuwzRsDAZd7NBIbp2/DD+L613LTTJa9ivufEjtZzD1i41H
         rRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779927254; x=1780532054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrIZ9K4QbitiO96jnl3s85zCFXsrBTuum6gLzlFg8Ns=;
        b=bAquNCuP+gnO3Dz8pWqmVcJ2QiiVxzWwPKn4Ew1B6skGd4otrkMTl9dAClMNWLWCow
         qgH0u81nR0ozoaJwUG0nDA17zZXkKqrrb4H/gFxUu6G3sVUODw667v/hSTJBy5g0euKO
         b/vMTQEI73sm4KHBm2zjFOi67FlHdp/k4XOWIvFpbDTh4+MtcAjm3jG56r8PO9w32rmM
         RvB5ahBiRZZrOXRdiGKtD7kQLIMEut1TRGV/SIrSMLa9okJbESDcigXsJ6nYNP9FOn75
         d6A/mNsXpeSbUXdLal+s7lpTnARS448UJKjl/+aQn7xEaEDAB6R9XVmLvEWWJZpmkOja
         GGTA==
X-Forwarded-Encrypted: i=1; AFNElJ8mbnGUTsq+f+6WIf3JVWUuBLH02uwgUryFCtUEKoKs0rJx8xUjwNt3BJ6SBFCVXmTPSpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Abeqk5ogMo+DeWc9zDXd194pQC8AhOWXoqxYM7bVSBjebNyi
	FUjfD7eWd7bw+PgIkRCS04omG8YS+XTpqWkaaIT14ekevPW02XI0fkyenW7CFSxHOaOCzKCtKfi
	hZrPfxA==
X-Received: from plpl7.prod.google.com ([2002:a17:903:3dc7:b0:2bd:45ef:9393])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc8e:b0:2bf:2d0:8878
 with SMTP id d9443c01a7336-2bf02d08950mr12743505ad.15.1779927253937; Wed, 27
 May 2026 17:14:13 -0700 (PDT)
Date: Wed, 27 May 2026 17:14:13 -0700
In-Reply-To: <20260527120600.20696-3-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527120600.20696-1-pbonzini@redhat.com> <20260527120600.20696-3-pbonzini@redhat.com>
Message-ID: <aheI1QcLxDO-cksw@google.com>
Subject: Re: [PATCH 2/4] KVM: nVMX: remove unnecessary code in prepare_vmcs02
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Paolo Bonzini wrote:
> The late vmwrite of the PDPTRs in prepare_vmcs02() is redundant, because
> every write it does was already performed by prepare_vmcs02_rare earlier
> in the same prepare_vmcs02 call.
> 
> In particular:
> 
> - load_guest_pdptrs_vmcs12 == true implies that prepare_vmcs02_rare() ran
> 
> - the assignment to load_guest_pdptrs_vmcs12 matches the gate in
>   prepare_vmcs02_rare(), other than having one that checks
>   !hv_evmcs and the other !nested_vmx_is_evmptr12_valid(vmx)
> 
> - the condition for the late move is a strict subset of the one in
>   prepare_vmcs02_rare(), because the former checks
>   nested_cpu_has_ept(vmcs12), which implies enable_ept, and on top
>   it narrows it further by ANDing is_pae_paging(vcpu)
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index c1be8ef882b8..f86a12fc29ec 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2721,14 +2721,10 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
> -	bool load_guest_pdptrs_vmcs12 = false;
>  
>  	if (vmx->nested.dirty_vmcs12 || nested_vmx_is_evmptr12_valid(vmx)) {
>  		prepare_vmcs02_rare(vmx, vmcs12);
>  		vmx->nested.dirty_vmcs12 = false;
> -
> -		load_guest_pdptrs_vmcs12 = !nested_vmx_is_evmptr12_valid(vmx) ||
> -			!(evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
>  	}
>  
>  	if (vcpu->arch.nested_run_pending &&
> @@ -2831,15 +2827,6 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  	if (enable_ept)
>  		vmcs_writel(GUEST_CR3, vmcs12->guest_cr3);
>  
> -	/* Late preparation of GUEST_PDPTRs now that EFER and CRs are set. */
> -	if (load_guest_pdptrs_vmcs12 && nested_cpu_has_ept(vmcs12) &&
> -	    is_pae_paging(vcpu)) {
> -		vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
> -		vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
> -		vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
> -		vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);

Hah!  Fixing your own mistakes, but making it look like it was my fault.  :-D

In the original version[1] of what ended up being commit c7554efc8335 ("KVM: nVMX:
Copy PDPTRs to/from vmcs12 only when necessary"), the writes in what is now
prepare_vmcs02_rare() (and I at least am still amused by the meat pun[2]) were
removed.  When the mega-collection of optimizations was posted[3], the removal
of that code got dropped.

AFAICT, it was completely unintenional.  Maybe a rebase goof?

I don't care terribly about the performance, and I 100% agree the extra complexity
to do the "late" loading is ugly, but I still think I'd prefer to keep the "late"
loading so that there's symmetry with the vmcs02 => vmcs12 sync, and so that we
don't try to optimize the prepare_vmcs02_rare() code and consume incorrect state
via is_pae_paging().

Alternatively, expand the comment in prepare_vmcs02_rare()?

[1] https://lore.kernel.org/all/20190507160640.4812-16-sean.j.christopherson@intel.com
[2] https://lore.kernel.org/all/525f4ee1-c111-aaa0-2dcd-6c5ce26e3088@redhat.com
[3] https://lore.kernel.org/all/1560445409-17363-31-git-send-email-pbonzini@redhat.com
