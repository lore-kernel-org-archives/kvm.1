Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363A403AF7
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095887; cv=none; b=YCAXatgJVGIVyED/2MVUVgJFYLkPXdHyWW9Rx+5mjrhY1IqpgE2KzfJ4c0MCodtXSn6c4c0NC83XXH/h7uUIGuJOfeUHsprzij4elFid398lyybkYSOhSci+uy91otuB/Mhgf1fLcJW7KGJuHsLB+NChTtScZ5nvw0LjhnpVUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095887; c=relaxed/simple;
	bh=5WxGgmlTamW+SUKpDZmh9qCRSGbX5nYB07biNhkMiXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E7llOP+AZwtxjqV2yWsiD2JRQ5kYLuSM62UFo37/NEi4j7ynvVbUMTwydcpgn6xH0tpJgySG66IT5AiNgE/7eQmw9jh9Z4ZRHcqi8JCGaLAqgb9SY78ndeKgAr0WcE0D8cdpfb7OYhoZcdTNutQjuoZIZWm8SIpUvlCzarN2kI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=raGZ7QNe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="raGZ7QNe"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so48478205ad.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781095885; x=1781700685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/o+UCNV6jZFXH7IOUDDk1tmgi6aBRIROCOUfOa2J4c=;
        b=raGZ7QNeuirzqFyi0Gffy4xerIzagI/SP1ucYRjYsqjk7rLxZAMpW0tzDhswuOdtqd
         5cLPXMNK7iGdSKmBKQ1wVEWODZjNW51D5DQarvmhYDBENaelKBqIcTzMucKDGVEv1NKK
         M9OMctk68hAadTZXl9MF3w/FPsnaFKu/l8VSNYNEEY4bjn8ycJua019elKRyxmtQIFeR
         yuehGovAo+bajvLYDen7q9hLwvBdsjxvvkBkSELUJFfLPqiWdvTNSHlpK13uGbG/3THJ
         Aqf7NeMDH9hUG5k/g8Jb2xvNgzNyazUVp7kryWp7pyUb4N3cLwXEQ35fLO1L59knhAmI
         KVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095885; x=1781700685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/o+UCNV6jZFXH7IOUDDk1tmgi6aBRIROCOUfOa2J4c=;
        b=iBoG6/CAsn0llnsi7WIeD1sRe9VaAd4AZuAyHdUbf/TCgFEmXtJXMRZ+0huLc8kdZW
         WTmtgKQCOIujuune11jHajTnuxRQEQvZvkaJqHcYSqUAyAuoekzCwBPTasZ4Fu5/qdhp
         YzD5vYg5gfUlyR8O54EXyJHijnuSrcmUQoWDNyQ6LSpylbuCFYfKKFwWZseVJWFe3wKR
         lXStNRLqpbe27zTv0XRXdhFApNHmINMRvUxIqyJQmF9Rt6Pw1MtQNGQT+gXt1xa5DUjT
         6WnSBuVWVw8d63+FnDdt0RCleCGNwruOsiIBRpxYfwlEysVB8yz0qM8c8+KLZWS8i1j7
         TgIg==
X-Gm-Message-State: AOJu0YyQFdZ1oCkqzCWhjLjgeSbFR0siJ6uLwb70oASf90YnN6NdovNs
	zRLbHwC8bHHKc78sCK3qgyszdlzxcGdC8Aq2m7sqyoTeIMRZcjllsLmna/M6AMAUa+GYvugQcNA
	S3k/4Ig==
X-Received: from plch21.prod.google.com ([2002:a17:902:f2d5:b0:2bc:ae06:63be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3888:b0:2bd:606d:b339
 with SMTP id d9443c01a7336-2c1e80ec394mr315606005ad.21.1781095885232; Wed, 10
 Jun 2026 05:51:25 -0700 (PDT)
Date: Wed, 10 Jun 2026 05:51:18 -0700
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1781093720.git.ritesh.list@gmail.com>
Message-ID: <aildxtZhqEFYygp2@google.com>
Subject: Re: [PATCH v3 RESEND 00/10] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> Nicholas Piggin (4):
>   KVM: selftests: Move pgd_created check into virt_pgd_alloc
>   KVM: selftests: Add aligned guest physical page allocator
>   KVM: PPC: selftests: add support for powerpc
>   KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
> 
> Ritesh Harjani (IBM) (6):
>   KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
>   KVM: PPC: selftests: Use u64 instead of uint64_t
>   KVM: PPC: selftests: Use s64 instead of int64_t
>   KVM: PPC: selftests: Use u32 instead of uint32_t
>   KVM: PPC: selftests: Use u8 instead of uint8_t
>   KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and
>     gva_t

Squash these typedef changes into the patch where the "bad" typedefs are used.
Give yourself attribution for Co-developed-by if desired, but don't introduce
code only to immediately fix it.
