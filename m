Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7131280035
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767353; cv=none; b=ZfKagDxLR0hFYcliy33riR8evSmPxOw2tAnlDRir44suk9VEnGHv3R8pvqjaAjjrguyZML66BbLib5tHqc3pkDH5Y3yKEkKnP92BrriTmgILoH9oVyt6PeVKVb5K1X5Wkh82ap8b4djeOr/7yYzvROglxe8+yfQQShL3dAJjN9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767353; c=relaxed/simple;
	bh=Bx/O6lIWL20XhaxWVmlBMU7Qc4gBrIph7d0QGpoP5hU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qzeplsZPkuGt0BN53XzMn9lKAjE3j3JAK5QhxXo2N66190lDHrmWHaJFxRKk4jC5UbK0Zl1yEpnSpGyHrtCeFhJh/JoYCmNyCJGLb7uDjTiXXI96vE1E2L1X1A4iObcgkg6gtaCLhMCDB5PQsJs3ijq+W3lKlsBWjZJ8yIVn7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VG62FFl8; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VG62FFl8"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cce14a21faso896725ad.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784767351; x=1785372151; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYT880AolYzsmucK5/M0IhhR2VakKdt11GAhNv55PqY=;
        b=VG62FFl8leMsVK7e76rzc+OBbrCcjus4mVw5FtwAENowMVee7vWJDfJV2XE3p+lpfA
         cBx/mLOyWWC0GaVtlkMXVnH4Hzx5NNHV/ejzwdmXMXDSRc2UVbUVtNsVAl4fMHuEANbu
         710gDWeyMgiJBxm1+IcJy/YZp9eseDW5lI0+LQtJkBftjGXD8mTST1v1JnUF7yYCaYlF
         8IPRaY6I3qpAqJL6DJOIiZNWg+FjFoeUPCV7P1JVFspxAxpCFOmwBnMDDv0+inbW0h3B
         v+QSlIXAaKbmk/SKKU3MAy0I7Gge4LMi/Wc66i4h4ZQYaCVUTVrGJsD7VvWmBTz38awq
         uPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784767351; x=1785372151;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYT880AolYzsmucK5/M0IhhR2VakKdt11GAhNv55PqY=;
        b=jeO4raDBzi8qPx1rEQajel4qM+LpVce9XvfMQqYkoLZhxlMBpSUUoxgNTVN4hEL9ET
         LWwPlOb0rhblOUxF0i3eqo3ixQSl0uhaou0Lzp8KAQKbkOgzqcaVAoWrrjRQcr9ePR2r
         ldZOXWnNUG7j4judYQH3+lhEpY9wuuY1HQ7dGJJaf7wBhXk5j4Z7Cfz6sTGTr1jnWC7k
         E4WgHhKwcoi9hQnduwcBP+7O2p/95no1UKUy2sUiamSKAC/dbPMmATHech33rpHgNksQ
         pwl1EFisZmZ9KepnmpFPSIqM7QjOB2M0h6wAFtJhzQ0h+bKjrsXygxFCmhS8LaS2OkaO
         JNtA==
X-Forwarded-Encrypted: i=1; AHgh+RoAYXku1NofyeHBKMAlSM7yQZXAF1rMrxa4CKm2NbelK++RQgW1ayVXTUdCu0lIdfSpo/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhWX8P18Zcn/XsV6VSVbjrUQRvLETCm3YBkkGGzM6mwUxGk6T
	YcfLlrw3oxn0BY+dvCNpK98t66RKEtZRRcRpciMjEs+2kOfgl7FkjwCbuH7EZYFl+R/S37ZKnnb
	kFjJdlA==
X-Received: from plbji11.prod.google.com ([2002:a17:903:324b:b0:2cc:b904:3254])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fa10:b0:2cc:92ae:b36
 with SMTP id d9443c01a7336-2cfa9551320mr3558095ad.24.1784767350952; Wed, 22
 Jul 2026 17:42:30 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:42:30 -0700
In-Reply-To: <20260616004155.1435766-16-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-16-yosry@kernel.org>
Message-ID: <amFjdi84r-tPgKqk@google.com>
Subject: Re: [RFC PATCH v2 15/25] KVM: nSVM: Call nested_svm_transition_tlb_flush()
 on every VMCB switch
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> Move the calls to nested_svm_transition_tlb_flush() in different
> transition code paths to svm_switch_vmcb(). This ensures that TLB
> flushes are not missed during switches, and makes it clearer that the
> TLB flushes are directly related to the active VMCB.
> 
> The ordering currently doesn't matter, but as more TLB handling is added
> for nested, requesting the TLB flushes *after* the VMCB switch will
> become a requirement.
> 
> No functional change intended (for now).
> 
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/nested.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 24a52aefe94ee..9a917d057aa8e 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -707,8 +707,12 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
>  
>  static void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
>  {
> +	struct kvm_vcpu *vcpu = &svm->vcpu;
> +
>  	svm->current_vmcb = target_vmcb;
>  	svm->vmcb = target_vmcb->ptr;
> +
> +	nested_svm_transition_tlb_flush(vcpu);

I'm not convinced this is the right place to do the flushing.  Yes, manually
doing the flushes requires more code, and arguably makes KVM less robust, but
IMO there's value in mimicking architectural flows because it's the architecture
that dictates the flushing.
