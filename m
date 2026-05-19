Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE478221540
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151346; cv=none; b=KqUE8kKxw/flVVDFCtAP3O4pZ4jIn54vu/XTwDrMb12dcRv6wdA3h2RjS1y02Fgrl8jV+HQJt7XT6+DzaW0ufYfpcqBV/JczybOe+Ic39a4HvMymlhFKDBNJhQVB84MNhoYuq6b24PZ2aEbxeNuPejeYUgJ7uM+D4NSfbj0GPys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151346; c=relaxed/simple;
	bh=0ZXhg3ESzQMIrHvqN+Rk3iOjLKSaO3bVYaLDy6rC1cE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AxjWOtbM7qOZzZ8LcQ7eOeILhgRr1jgxk72PGV4SWn2c9XksUxDV17+9/RC2oIH12TgEJv9ItUk6L4YgcHReY0iP2IzyhTrhxGRwoKzxMD2cZ5Rb6gCvaIdi5ZVXylcaZeWVx3DWG/7Cznmy35CyJTIcBzb6yj66LqOyqc4jGaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYWv5ic5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYWv5ic5"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c799ee56bd6so1492039a12.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151344; x=1779756144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7QwZo6KxCL7PUVyCWizdC0ktl0P8L3MwdufqGhOMio=;
        b=dYWv5ic50bkwMgIt9AIKOSjPmD9m94zqmtAqX9QEczhCquWWegAh1l3w3Js4gi4ov2
         wt3Mb4kEyYl5Tgd8TTwMeRuQfl3++0hPBS1iUptBZtVSXJBEbaPiTUJka8K8oEe4ZsXu
         uAmcDuT06tP9VOjGn67/4KoMZkNr/offt0FFjK2/njDKHQ/LYTOjyJZk3OI1AodftP1/
         2YOCgaCGiS1JmHDR+fow6A/6rVpWyCoVO7cP1jh0GNMBLT8Gc4rLcx1d46V+tnepxpDO
         8TSC6aSH9+sWax3wtIalcOq66XLwY2/cccZFcTNry2y9MePMTmfQA5j6O6zhXng4yOMp
         h9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151344; x=1779756144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7QwZo6KxCL7PUVyCWizdC0ktl0P8L3MwdufqGhOMio=;
        b=As+0lykjD4nR1AGSFTUqVyO4uqIjnXtKbGnX2VFMZSwL7osqoJLuPhu77RPN52GXuf
         gpNNA+aTR4b/XdcpjFv1GltCQbVA4o/qZoMkMmcRleIq6yFw/nHcfOjXtp6+SBZaCMkW
         EyAZlxh99AqBl+sWs8S/mlZACJEtO/1BxpWLkoGK86wGp7s+YuD2gTFm8ZDfPg2tcJL3
         RPQOmygHPocx3sg/F8JuAw69kPdFP3JYqQF8Itsx+WDCIKhC6TwwXw7EMJ8GTHwqys8l
         5N4i7KOwLVgHAjB9RTHmM4+25R2QPFRg1W5JH/UEiT4cLPqQcbKOhTbt5WUw1JDIsEAS
         Tgeg==
X-Gm-Message-State: AOJu0YyTKkciQh5231tU5HhxJ9OS+tQjM9hIWtEKox+897TaPCoQLn4N
	gU8mkOWeD67n/NLABt2MPPHVuodVyZnsKg/ou8qkr3gJy3R/XELu16zOYtDKpYaY92RsPwMv67q
	yR2Dw9Q==
X-Received: from pgr17.prod.google.com ([2002:a63:1151:0:b0:c82:bdf7:4836])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:218e:b0:398:9662:10ff
 with SMTP id adf61e73a8af0-3b22e6685e2mr19937882637.4.1779151344014; Mon, 18
 May 2026 17:42:24 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:40 -0700
In-Reply-To: <20260423162628.490962-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423162628.490962-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915113628.2231260.17159960202588301938.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Fastpath userspace exit fix and hardening
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Nikunj A . Dadhania" <nikunj@amd.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 23 Apr 2026 09:26:26 -0700, Sean Christopherson wrote:
> Fix a found-by-inspection bug where KVM could fail to flush the PML buffer
> (VMX) or fail to grab the most recet CR0/CR3 (SVM) prior to exiting to
> userspace, which could prove to be fatal if that exit is that last exit prior
> to save/restore, e.g. the last exit before userspace commits to migrating the
> VM.
> 
> Patch 2 is related hardening, i.e. isn't fixing any existing bugs (AFAIK).
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86: Ensure vendor's exit handler runs before fastpath userspace exits
      https://github.com/kvm-x86/linux/commit/0ffedf43910e
[2/2] KVM: SVM: Refresh vcpu->arch.cr{0,3} prior to invoking fastpath handler
      https://github.com/kvm-x86/linux/commit/b21525756e82

--
https://github.com/kvm-x86/linux/tree/next
