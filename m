Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13647AF4B
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181225; cv=none; b=nIjqJRQOJfIOU8C5mUXWpHo8S+43poh0xgBILR59I1mI5Q1x/Kf3oXp5tabosDZ6IBNEif8fBpzpxe3z2km39vzTYkXXWTsuCkyvtLAPmGjYqs9+XOVr3s7V2QJVvUPu5dvAZT7yqa8nX2xlLtuy/K0912vq8gwswRB1jHNrzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181225; c=relaxed/simple;
	bh=FZbzaU2LUxJzETVXbc9pj0jxkaw7GCMbdBzEzfvdCfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XbN8sCI3LH2seX/DlXGhvhLIl1eCxARLfkhJTvOQyr0Ub6wlx9oclvjQgrwtJtyFsIPserBY3IgnhNLlW/zaSgS5hfuv19fSQex3CTNhuq0+znhqUH9V8qQn2D7qdXrx4XX4kkT2elRLdACIA+yG9moNXtblQhIQLQhG6ONIZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AK0kYWo8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AK0kYWo8"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62da7602a0so857212a12.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778181207; x=1778786007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWh64iTYCNQdm+zuXCNjZRmYSyIHS5N+G4ZxsqlfGdI=;
        b=AK0kYWo8+3GGKWMTNamOWXKs/VpHdtaEi4St83eKnj/6Q3DchBqCisR4petiLtA01b
         zXFU1n2QrxaexKe2KR93lHbBe1VSYHeif9dLDUQSLFCMd7hr9In8s9UZnKwtE3GqmRWF
         Dv9pJ8vBxAJvp4t0CKGSBTWfw8rsI1MwE7Du5XjsGCenoU7nji+sAA3j58GcQWBfo5C+
         zJkfoGb7LkDA89nCHLQ3t6x7exiErxD7fEqwi4N0sQm4OamBHr0Cxpq6V4YF7jVcNlew
         yguqCjc+HJTs0Djl4aC3QAHqkq6OxtuFB5Kd7noIn63S7w0q5qcc2w3fhYPd9gdLCBiZ
         mPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181207; x=1778786007;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VWh64iTYCNQdm+zuXCNjZRmYSyIHS5N+G4ZxsqlfGdI=;
        b=XRwe2gjPoOt5LO/QN3BLF+ra1yj0KqK7/h+7bpC5BvZrag2QAoWZWtnQIRE3d/g9Wx
         XnTitaPhAcxVIJQICqHW8EDKmc27+gCDbX7Mq4gcENp42cPCWz6w38yJZPXxO/i1/d/P
         ZUCi6By3wUnK5N0966ApUqTc8L6PeVG9juudQ1AX9oGwoNNGDFCWncDmqk2Gz1DjXw9W
         EuBvrsAzPqEx6y04bRRCnVObZ0ZfT7b0rMFI0Zt1wolJDuDdjhEvCrMGlgfeSQmbLNpo
         Im5Dfl5u7YlHYulPZ+b/F7zkbi9dzuhgsL4On2BGWKdqa3oFpaM8lMapMpCZe/og8AM5
         Y/iQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4Xh+IPPMAjz0eLWCS5I3yMLtknsdziJ/rFo/hwq0zWA+4L2ryXKYcYJbBYJacFPvWdnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+upiKQY6vVK2RHxPqqXFyx8juE9Lss2gErHpL2KCdFOcdWZA2
	9dDpkKiQIIWk4Q3kpQgEzWwnGRYS9lLv7ZSUY6StfAuriHRjHRdwia1nQx1asbRqhemdKDwT2jJ
	kLVbkcQ==
X-Received: from pgbcq13.prod.google.com ([2002:a05:6a02:408d:b0:c80:26d4:20ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3390:b0:39f:94cb:1bc
 with SMTP id adf61e73a8af0-3aa5a901f0amr10596349637.1.1778181206910; Thu, 07
 May 2026 12:13:26 -0700 (PDT)
Date: Thu, 7 May 2026 12:13:26 -0700
In-Reply-To: <CABgObfYR1NLbzsgoe=agkpjVJ7hs3E_ftrJ5zNnu_xF5moeKLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503210917.121840-1-pbonzini@redhat.com> <afjW63q5KqkwHMK4@google.com>
 <afjnKSeSX2IegtW1@google.com> <CABgObfYR1NLbzsgoe=agkpjVJ7hs3E_ftrJ5zNnu_xF5moeKLQ@mail.gmail.com>
Message-ID: <afzkVvq6l5VDCfpI@google.com>
Subject: Re: [PATCH] KVM: x86: use again the flush argument of __link_shadow_page()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026, Paolo Bonzini wrote:
> On Mon, May 4, 2026 at 8:36=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > An amendment to that: I thought this was just switching back to the mor=
e targeted
> > range-based flushed, I didn't realize you applied the version that hard=
coded the
> > @flush param to kvm_mmu_remote_flush_or_zap() with "true".
>=20
> Yes, I was hoping to simplify stable backports a bit.  Here is my
> version of your comment (yes, I did try adding batched zapping to
> shadow_mmu_split_huge_page() and failed):
>=20
> /*
>  * Note: while normally KVM uses a "bool flush" return value to let
>  * the caller batch flushes, __link_shadow_page() flushes immediately
>  * immediately before populating the parent PTE with the new shadow page.
>  * The typical callers, direct_map() and FNAME(fetch)(), are not going
>  * to zap more than one large SPTE anyway.
>  *
>  * The only exception, where @flush can be false, is when a large SPTE

Can we use "huge" instead of "large"?  KVM has lots of references to both, =
but
the kernel generally uses "huge", so I've been trying to opportunistically =
switch
to "huge".

>  * is replaced with a large SPTE with a fully populated page table,

I think you want "a shadow page SPTE" here?

>  * which can happen from shadow_mmu_split_huge_page().  In this case,
>  * no memory is unmapped across the change to the page tables and no
>  * immediate flush is needed for correctness.
>  *
>  * Even in that case, calls to kvm_mmu_commit_zap_page() are not
>  * batched.  Doing so would require adding an invalid_list argument
>  * all the way down to __walk_slot_rmaps().
>  */
>=20
> What do you think?

Other than the nit and the goof, LGTM.
