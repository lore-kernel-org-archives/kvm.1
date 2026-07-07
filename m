Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56724DD17
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382463; cv=pass; b=nQ/fMYorjF1pYiXuJCmz9Pam9BhzDfvdnoO3DK3BQ/i8pXdJ5tKTRJ942pBtZmilpcVddVlQC8UYbgmyFufQDsB4v+TPy40QAFc/26jIG7U4HFL6608Ywsj0SUItmdwQCuNzlENwy+6YNbEN6P6rK4ftbXo7GQyEoRCuBZHRbL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382463; c=relaxed/simple;
	bh=fjwR/tDA2VxqyZIBirsgdoW6obdKD7AsH8tzTnZEgD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7yzEyxhxtmHmdvbZtpeEyQlRncP6oC+F0Pv81WZF3Jtk6FY2dqThGM3O1kvolS8wXExtHYuUaesKo8p5+m4vkEe8jzVXIwDo8yBrBhroQ6XQAEqeizOVl2fKAeS9X6SPUK2rNRrlTgUof3QFdUvHcaXxOxzepuJTBBfx1NJo9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WSfFRHCP; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSfFRHCP"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-74019ed06aeso2823030137.3
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 17:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783382460; cv=none;
        d=google.com; s=arc-20260327;
        b=PQZTtRz8fb1tMjO3QCFwG+M2VTPiRZuguGaelvhod3UoJEktUw04EZhDW5ziOfztRS
         VsmWXNixa+K+j+Mu7PfJE8MW/9ZuRpY7AcpIf6NC4RkSbbfhuQX0FFtnMAOKNwKyEO7Z
         ODGGyGrwFgytIqPRHys1Hn8Cef7dDsiP3mFei/1rKzNYP6Mk/HrnY0da4x+PspoqwXQ+
         Zw8JqIFftGN0HJLMwQaszUdhzGy7gWycki9oO7s9yX38hcTERCqhteSYFn5f75qm7yBK
         yR57bu3Vjd12nJXqT0Oyfxf4ghx4KgepalVTTZdwkXYhYJW0BHvVFKdt72OWIbuCvUw0
         h9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EdG+ly0t16GH0L5fTMO5Kzv86XVLEyZM4B6Ik8ybBFY=;
        fh=Lp8EwOrli9UfG54DZ/9jBS0J2UnW17cSROWBAvmyQMw=;
        b=LXZ/BPdtvyMA6LvXcgOeh/pAkTk2eson1QmwGbKjU6bc4H/KvYsD5dJdcQA0oWZZ7I
         60YRLaQ+S5L1vxGUfStABL41y7FzpqFTP6nS4f/4hr5kirpdnZIqc04bGSwgrBpAkJM+
         ed7eEhj2b9rXNESkhan0Y9EMAU3DDzLquqszjAI915aCx5wky5hRJtOBG6CPXe72w3hU
         cDpfseU+6UYPmpOHV/RBJ+4Q9tpP/0IiTBjdFjBC7FtMWaXHc2JJ5SQbiWWKgYl5oZOc
         Fd4Zd7nv7YHo4DX5nUdByVEMbnduwnp9t+SuxYrJYd0r51GPHZFk6uhXBJfMOWn6EECR
         XCUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783382460; x=1783987260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdG+ly0t16GH0L5fTMO5Kzv86XVLEyZM4B6Ik8ybBFY=;
        b=WSfFRHCP+HWaZGBnmBcJLuIEWGm9QBOmdOnofczb86jIoEJapnd+P9tAPyOJPU8Gqw
         jNdB7kvaX4uwvrCzvOzw3eh3kSJ1SwyYiv7D1xaOzWkjfn+mIBnD+2jWaubtIN1dL0hp
         sCbs4Tg0SUScDmnV7ggMET3GI4wa2leK24ENqvh0FNxds3Ty68tVCtGih5RsZ18wFp9e
         PSO7FHt+UVg7aL2mc7mxpEABOgXrigQQq+0mB7eSXqjGMwa9HvUhI3QDB8XUnoDTE+Db
         dzlMXB6X5G5GMB24f8f7N3fuoonNbc1YQvqq0FvMg/i3IJrzAkxVC3TRYwAGLxtUFlWa
         CUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783382460; x=1783987260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdG+ly0t16GH0L5fTMO5Kzv86XVLEyZM4B6Ik8ybBFY=;
        b=dI47iILEvCAfLF7oRGNkdwb4czvk6hm6uGHy1SP+BNYO1S7MJnUoquy/aeWHDMfXao
         CNe7hESpFf6ZBU5MSLMNczXFTwOrcdfobG37TV+DBzT6OoGoPnhyO/04yEinzcgpHNua
         ffctVj0B9y8pwF2O7Si0mnMKLjT1Q3eFEhJtXQeqQVf+1eF5chCjbPU4knmo3oV/wvE9
         k/NMCYJFyxIiJXI9ngvz+feA2q99OQ8OG9sV4m2itiPOk9zcfhaHWFdU+CmKaXTucIhZ
         vC/gt+yGN653SlnjLd/FldtT2oifm8CCwwy2XDxKj8O51tTt+6jE2SQiX3GGz2t3v1GF
         zUNw==
X-Forwarded-Encrypted: i=1; AHgh+Ronf2e6VK3sl0YS8PfYcWzLkpLNSUJFsYwmfaNYVJEJLARa/m3d1ZulOuqbRDZYCU/iiHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgDo7FAr+4IaGEJELt8kgQACvaJ+Xl7jOKfy0ztuy9xBC2sSq
	NH+yfy+ot8zdnaEYQDpPbB3mrvhUpddZH2Fwo16MRSNCwEtyH+oFn8J4NRzn64hozsOuppFmWQv
	5KxFjNNF18wqbnnuVCsN3GdgpewK6U7SyyYiotRP9
X-Gm-Gg: AfdE7ckYTKIrzp4dZf27AGBCn8d4T35LIms1oUJRnzv0YexqaA4CLKt9FQ5PKjgB7Q1
	6vOWQeXF+utMvonlAoX8OEgrKYp4kZyKvJHCxvLc42JWdAj7jwtQEV7rytuiP9W7g/UO44dG7Dq
	uDTZylRGDiQtF9cXnKmGDP9Huc2xiH7HnSPs/WGowtf/76o1hpDtIPdUwSzKjaJALJ5/ZvhBn7x
	6/5H86cfJ+GWJTbE85kosQEF9DZfRxp6r2qQND5a2PpyXhCv0JxaLVjQkvcuVckbXc6hAIdwYeS
	hpBzPQt6sdPDZjEIxQN/14z4K/3wv6I=
X-Received: by 2002:a05:6102:41a7:b0:739:64ad:bf56 with SMTP id
 ada2fe7eead31-744b7e912f2mr1611396137.28.1783382458892; Mon, 06 Jul 2026
 17:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com> <20260522232701.3671446-5-seanjc@google.com>
In-Reply-To: <20260522232701.3671446-5-seanjc@google.com>
From: Kevin Cheng <chengkev@google.com>
Date: Mon, 6 Jul 2026 20:00:47 -0400
X-Gm-Features: AVVi8CfLbO4Lr3SnbuEgi2z3GavgHmhD9PjOGmYCEyyxTENahBy0LvgfKJQlECY
Message-ID: <CAE6NW_bdHPgRDfs149JtTyAGfHYwpSr8k8C-cg3J-s5dywNsnw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] KVM: VMX: Synthesize nested EPT violation
 GVA_IS_VALID/GVA_TRANSLATED bits
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -516,6 +517,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>                 else
>                         walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
>
> +               /*
> +                * KVM doesn't emulate features that access GPAs directly, e.g.
> +                * Intel Processor Trace.  Assume the GVA is always valid; when
> +                * propagating faults from hardware, KVM will discard this info
> +                * and use the EXIT_QUALIFICATION bits from the VMCS.
> +                */
> +               walker->fault.exit_qualification |= EPT_VIOLATION_GVA_IS_VALID;
> +

Sashiko flagged this internally:

"Since this code asserts to L1 that the GVA is valid by setting
EPT_VIOLATION_GVA_IS_VALID, does it also need to populate the access
rights bits (EPT_VIOLATION_GVA_USER, EPT_VIOLATION_GVA_WRITABLE, and
EPT_VIOLATION_GVA_NX)?"

The Intel SDM states that if bit 8 is set, bits 9-11 support advanced
VM Exit information. Would a change like the following be needed to
populate bits 9-11 of the exit qualification?

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index cfc30695adf4..355150a21b0b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -449,8 +449,24 @@ static int FNAME(walk_addr_generic)(struct
guest_walker *walker,
        real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
                                     access | PFERR_GUEST_FINAL_MASK,
                                     &walker->fault);
-       if (real_gpa == INVALID_GPA)
+       if (real_gpa == INVALID_GPA) {
+#if PTTYPE != PTTYPE_EPT
+               /*
+                * Architecturally, bits 11:9 are only valid if bit 8
+                * (GVA_TRANSLATED) is set.  If bit 8 is 0, bits 11:9 are
+                * undefined and must be 0.
+                */
+               if (walker->fault.exit_qualification &
EPT_VIOLATION_GVA_TRANSLATED) {
+                       if (walker->pte_access & ACC_USER_MASK)
+                               walker->fault.exit_qualification |=
EPT_VIOLATION_GVA_USER;
+                       if (walker->pte_access & ACC_WRITE_MASK)
+                               walker->fault.exit_qualification |=
EPT_VIOLATION_GVA_WRITABLE;
+                       if (!(walker->pte_access & ACC_EXEC_MASK))
+                               walker->fault.exit_qualification |=
EPT_VIOLATION_GVA_NX;
+               }
+#endif
                return 0;
+       }
