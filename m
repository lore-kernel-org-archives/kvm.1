Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47C47F2CB
	for <kvm@vger.kernel.org>; Tue,  3 Mar 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556635; cv=none; b=VjTfHC10M8RAFhB9IcmXfsGX50Nj3PKyIZ+8+j2tK499rJngKc2mu8MJBwasqHfS5YJCwTb6MCxEY0ZgQPmNLK8ZjQzAT7AfFA4iF05bb5YxodIcfbwKo4jOjx9WgUonmiDJoMjYFl6lgRU31PXzBsXhZwoltGgB1ypz59wU2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556635; c=relaxed/simple;
	bh=hCyX9uSwl3jnp1a2q2tCc6hQMVokAPgBe3H9js5yKT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fb9uOEQNa3LnaTkVNPOJVVdAYSamENggpVzyQ4a/dVSaZgE9k8HJvBd0E9PFwN07XybR9DzKdaWFZtVTpbegSpBBXkEu6pPcO4TWmhsgzQXp0m7kutl+cDssIFX2OaVtaTrYkDyywGHVd2zTsUwwJq0z9mWu7nFkar1z8RGDgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+D4dOzE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+D4dOzE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4e20a414so117635515ad.3
        for <kvm@vger.kernel.org>; Tue, 03 Mar 2026 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772556633; x=1773161433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/l2cZgMpviDP0V+61Og9F5X9FaDhWq9sL3pv6ZfXjns=;
        b=v+D4dOzE7HbUX2rTk/pdMP1PjIyfDK52y2AA1uTLflEfAPWoeWt3/h+7P3lOzhE9ep
         0CGGfXcd+/kbsB9tF+QVyVoKYhWLQ2uHNsVxuo2CvlI70OUVwjJrCJEjfZEx9MNf7w91
         60sUWkss8uasGo9863alX1/NTFFz3M+g4xC0y7xVBrHZ9Cgdz6wKZsf91aPB8i1xDeVw
         cwfugfV9iNZzewoQ6whTW5ULe0Okl4yPgYlniV//qioKNi2GWopKRWkjBJ6gWeV4K5rw
         B0uMvVOmCHW8kLb9Ho+PaZEV8CjIsXJi5FCwZWuSV8fNX1EiDokZwZWn0bUK4FvvLkO+
         dd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772556633; x=1773161433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/l2cZgMpviDP0V+61Og9F5X9FaDhWq9sL3pv6ZfXjns=;
        b=h+ECbdPJKJn1hPd6KOb0mZNmGcV79o1AB85SGCvk0/EKH3g0p3KTUbQ45rwA9C46a0
         MrWzRYQvKyXCNOg2VqeX2W6gO9txGGRPGeD6Pwm8wi0P5cH5OKz4hIa/akYWhdZnaRXv
         khB+uzZA5El3atCh/sih//++obSCueyQqWXGzlDbiIP2P88yivBi7za1srr4rR5HOMiq
         9Yhg/Z3XB2FgjvpXDKO/fsTvZxtRJ0IPba4XGNYWUgCXCXkUeI43BAfujyVi6kUcDsz/
         Qy7Yt0k5whUCna6Auue4zZ9+KcVJylnBUXn+oq8oiyLFaTTDj7xiioHTmC8xwhIQZAjB
         lDXA==
X-Forwarded-Encrypted: i=1; AJvYcCVlqEwOyJiYFDOVY8N+nQRWhJ3VM7t4hVAc2u3wLWshegVnPEolpKRb5GwcugXwXVKsKvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTtPJFch1LhoC+/wwEBDZl6tXvs/zkGkv2YLxkhqsLSw3xPNhE
	mSAVK75Gu0oudKLGWCBtZm4FLIFbSbbtshdtpeccFnKT1Np2Q1ECgpjWcffmY9ZtXMTtw+G4QHh
	nCF5dtQ==
X-Received: from plki15.prod.google.com ([2002:a17:903:1a0f:b0:2ae:525a:f974])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b85:b0:2ae:517a:6c28
 with SMTP id d9443c01a7336-2ae517a8175mr78595715ad.29.1772556633152; Tue, 03
 Mar 2026 08:50:33 -0800 (PST)
Date: Tue, 3 Mar 2026 08:50:31 -0800
In-Reply-To: <20260303003421.2185681-13-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303003421.2185681-1-yosry@kernel.org> <20260303003421.2185681-13-yosry@kernel.org>
Message-ID: <aacRVwsI0x_kDZ0u@google.com>
Subject: Re: [PATCH v7 12/26] KVM: nSVM: Clear tracking of L1->L2 NMI and soft
 IRQ on nested #VMEXIT
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 03, 2026, Yosry Ahmed wrote:
> KVM clears tracking of L1->L2 injected NMIs (i.e. nmi_l1_to_l2) and soft
> IRQs (i.e. soft_int_injected) on a synthesized #VMEXIT(INVALID) due to
> failed VMRUN. However, they are not explicitly cleared in other
> synthesized #VMEXITs.
> 
> soft_int_injected is always cleared after the first VMRUN of L2 when
> completing interrupts, as any re-injection is then tracked by KVM
> (instead of purely in vmcb02).
> 
> nmi_l1_to_l2 is not cleared after the first VMRUN if NMI injection
> failed, as KVM still needs to keep track that the NMI originated from L1
> to avoid blocking NMIs for L1. It is only cleared when the NMI injection
> succeeds.
> 
> KVM could synthesize a #VMEXIT to L1 before successfully injecting the
> NMI into L2 (e.g. due to a #NPF on L2's NMI handler in L1's NPTs). In
> this case, nmi_l1_to_l2 will remain true, and KVM may not correctly mask
> NMIs and intercept IRET when injecting an NMI into L1.
> 
> Clear both nmi_l1_to_l2 and soft_int_injected in nested_svm_vmexit() to
> capture all #VMEXITs, except those that occur due to failed consistency
> checks, as those happen before nmi_l1_to_l2 or soft_int_injected are
> set.

This last paragraph confused me a little bit.  I read "to capture all #VMEXITs"
as some sort of "catching" that KVM was doing.  I've got it reworded to this:

Clear both nmi_l1_to_l2 and soft_int_injected in nested_svm_vmexit(), i.e.
for all #VMEXITs except those that occur due to failed consistency checks,
as those happen before nmi_l1_to_l2 or soft_int_injected are set.
