Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0141A90C
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054644; cv=none; b=i/uAWuTMlKjngcOAY9usU6T2InreOo6r6jO1cNnaVtqMxuTAoxetxs9hld7jYI8tqE/M+j9dTDG+OMgYDu2eTkdXVy1MaoA92YfNlsKZAaRxc8MiOv1BqmXfSe+ffz3YUrfJ2/Gz5IUqd9rTRtUkUiV9lHW+Qx2iY+DC4d2Fp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054644; c=relaxed/simple;
	bh=f61YfrHgaU0Gbcv/vF9d46tj6vQwe1xvPLFY/OqKJfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PvKWFSViuTsbetorxvueLLSp29eMdKUQCATNMZSK752FHZRO/qiRXLJe3PWwutleKp28XGbW/qwDMhHKs/j9ag1l6gJYhQ0POn+Z/JYkM0R322Je6fICFMpMzYap2UafU26EdJck1nF7K/OiLVXvArDP/RZGWWLWuPFzTXl1oUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjoRPaGR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjoRPaGR"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ccb687f82eso71095375ad.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054641; x=1784659441; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ygbRz4moN46SryCnSw8cMhgO4ezp2ZeqDLdJ0obBds0=;
        b=RjoRPaGRX9vId/STSyPYELOAyPWCBc1MvfxyYZMH3d2RJLHdDM7q9gntMpR4kFEYKT
         mCpmj/IUK5MU0e8GmJMDy3W0qVTF+0ZSFLfWBbe4k+lWph6hnNzVNOOOB/hJBG74xKcH
         TtB7A39dAzb2SGzCOApdDf62H51vf/l/Lgp/wy6eBifd+I0HMWXl9/bW648Wr+hQ8PdE
         OEgN98rXoBhvnR7G15RNJd9yyKiWKwvSAH0lpeZYRCGGYs03yvU7aJFByNAgWqlhWtjb
         xkvPLBE0/o+sZx5EbHcYSKWb9HEhv/GYHvUvX9pixSGLoPsN4qs4gmn+vSRsqyR4/gIh
         tCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054641; x=1784659441;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ygbRz4moN46SryCnSw8cMhgO4ezp2ZeqDLdJ0obBds0=;
        b=LTt07DJYnhJaWUlrw5kpvjA38RyEWfwExJRZ7dbS9xF5pEXUE2z0MCNaLYPRz+x2gd
         I1EVfdc3oMsAE8oUr+ORcGxZ8HJaTo/MCSXmKumNPq3p/oE0yEi0/CPZvHu7xi0TW92d
         2J96gvPl4bp+KArhkeoBLovzjaFmG/+TwCglx3ffoBe8DXqes58Bvi06ZafJnnybTYWL
         ZvmIb4nrwjHGp7h4bA8d41hZf/4bf52qBdqleDoTkVq2ocl9099zCqy05vWvcEnr4EmT
         R3vtw4OWwB67FYnIlzsWRmxcZWt+iNeTL4UxkQ+NlsFh5HRsTF/mJ0IdDYUPA4ZEvakc
         1/cg==
X-Gm-Message-State: AOJu0YzIU9fcSwogBLU85ieOi83qLPn8cB3p8ZOhN+jgjX+73jFWOs6V
	SdJFypVNbJCv0DltXDjspZGmGLA5JhjQCfWnR9P6H5HWxWLBlYNhJunnQu6YJLgZQM8pTjQPZNW
	AyjFnhg==
X-Received: from plblk15.prod.google.com ([2002:a17:903:8cf:b0:2cc:b305:dd6f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f706:b0:2ca:5671:b219
 with SMTP id d9443c01a7336-2ce9f052e7cmr141030155ad.22.1784054640528; Tue, 14
 Jul 2026 11:44:00 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:13 -0700
In-Reply-To: <20260612145642.452392-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612145642.452392-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405353768.3120713.14326474027099250936.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: nVMX: Fix ept=n bugs where KVM runs L2 with
 guest CR3
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 12 Jun 2026 07:56:40 -0700, Sean Christopherson wrote:
> Fix two bugs where KVM can run L2 with a guest-controlled CR3.  The underlying
> flaw dates back to commit f087a02941fe ("KVM: nVMX: Stash L1's CR3 in
> vmcs01.GUEST_CR3 on nested entry w/o EPT").  Past me claimed:
> 
>   Smashing vmcs01.GUEST_CR3 is safe because nested VM-Exits, and the unwind,
>   reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is guaranteed to be overwritten with
>   a shadow CR3 prior to re-entering L1.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/2] KVM: nVMX: Move vTPR vs. TPR Threshold consistency check into "normal" checks
      https://github.com/kvm-x86/linux/commit/ebdac7554abb
[2/2] KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3 when EPT is disabled
      https://github.com/kvm-x86/linux/commit/3e6dd2b9b7b2

--
https://github.com/kvm-x86/linux/tree/next
