Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C43B27F5
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975329; cv=none; b=alvf89RutmyXwiay8KMMim/o5qlAUuopyJT176tIz4rwrBU05dq+8GVMa7QoVjUSVlguljf0qKzGAMeQp9/8ZSsDcu/2xpu6j1qRqJ0XmvlTDQvD+Z3vW57OTiOu55FbRA42GGcKS3XAdKXRyLYDB7rFVzBS29Z2soQPym9M1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975329; c=relaxed/simple;
	bh=900R6liU3Q7GEOvg5B8yWZxQI9b85wkBfgI1IrpZ7jE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kcTaOVpoTKHtvpNyJgH0NAhxtM98MOyJAdNpnGEhyvqu1BbHMxKl8WBfaXUMZJC3rYi+ugxLZeSo4dEXm7Bb6dihZfpRPF7UQSEAcOOhJ6DfJF8TuBEYpyxX7+mQSIs0vcMWaICoqI16D0bcZcrpkZGagCbkFxXRi1ZVWgUScMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnpNNCfU; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnpNNCfU"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2df7bc60df6so142785ad.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975328; x=1791580128; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YucoW3vEYBy9i8pzw6TjqgEMgLGWO+HSYPIgDedMYFo=;
        b=SnpNNCfUkpbZPuAMtrQmqYgLIULJZIaTA0ZcR4dvFXVoTSGrBknumRQ+J8iPStRWFG
         4BMxBenEi2P+trAicN4EkliOpvCTNYzn85qKCZ1PjgMWCAzBh7vZ/ruU3JuvGjw3ZYdo
         LaFlAX5yZgi0Bwn9wvJ38IWxfKIWF4v6+dWaagizHeukhRPbbEZyTItLWNKOoN2NokGe
         KBzFgpk149YoxSnIwb1ExR6Z/OsjDN5GLfZB9nUnAocQXU+xsLzCH0DOrMj3G4v0QXeM
         7+QOW3jh7p1hakHWHNicP9zVaCAf189OFzWwmWw+a3beT12okRXs9GlevXZum45kLmvR
         aJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975328; x=1791580128;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YucoW3vEYBy9i8pzw6TjqgEMgLGWO+HSYPIgDedMYFo=;
        b=m189LGUF4S50R3uTXo+txlu6dZoo5FX2sXqngHoycYjJ7Nmnpk4uGn4o/nm7pDWLB9
         BByINudPlH560/YhUviEBVIz4KcKTweO3dIMtfxYPMbaHQc96lu4zao78VCQh4fr8ttv
         EqON+2oDBmkNVRwp63/AChHeUPiDXzvtuuui6TckV0WN4Bb311GDEICCkNC0+6S23Q6/
         dRt6wLcfZezugFxeEq5AIPgWzW78DKocP9HdP2/dL/TuSkWQE/IhHK9RyoOPK3Kt6qNs
         AkEixU+SJRMxDfMQhBwQYDHbwP9ru6MghjNWVPxHJmOTM7naMopXaBD48MLsVweaGOkM
         lTjg==
X-Forwarded-Encrypted: i=1; AKwUvBzc65pM4Vg9QYYZj77U1ohrW3MXnGs4Pkkekk9tGiyTrVZJhgTV4WD04oeqnjCaQCrUffs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhidx3N+yISCQ1Q/SBtNB5dLoseXy5j3vVwX9a3MZhjzy6yvgN
	fQGPElt7YbdsIT6STwtdB/zexmehVdpKeHLu0rakg6La9CFufGLAPzMq62HkDewil6zmUsdZcxP
	A+FL1mA==
X-Received: from pjbml20.prod.google.com ([2002:a17:90b:3614:b0:3a4:d124:4dcf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:388d:b0:3a0:bdcc:51a1
 with SMTP id 98e67ed59e1d1-3a6ce7c5925mr3000785a91.33.1790975327515; Fri, 02
 Oct 2026 14:08:47 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:04 -0700
In-Reply-To: <20260917100320.21899-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917100320.21899-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097476669.4071828.3235436306643128791.b4-ty@b4>
Subject: Re: [PATCH] KVM: x86: remove "full" out-argument from flush_tlb_gva
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 17 Sep 2026 06:03:20 -0400, Paolo Bonzini wrote:
> The "full" out-argument in flush_tlb_gva is only ever set on AMD
> processors, where the TLB flush is little more than a memory write and
> thus extremely cheap anyway.
> 
> Simplify the code by letting the implementation of Hyper-V TLB flush
> hypercalls always go through all the addresses queued in tlb_flush_fifo;
> there are no performance concerns since that is already the case on
> VMX, and also was on SVM prior to commit 26505e1b5b54 ("KVM: SVM: make
> svm_flush_tlb_gva do a full asid flush if NPT enabled", 2026-08-06).
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: remove "full" out-argument from flush_tlb_gva
      https://github.com/kvm-x86/linux/commit/ba70065fec49

--
https://github.com/kvm-x86/linux/tree/next
