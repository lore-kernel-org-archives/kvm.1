Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114621A6830
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309623; cv=none; b=bKgEWLr2Z8tDpRNyfnW+sXfbaGrV1ZJU+kjmbknUuSQJvBn6l1iRZz4pV/RgAhI7JWYKjBar/P8mRUMfhuQNd5JFi5bR11tXtJROSmTwqUiPQ/JYOD67+nPPXFoDQZk/t/+RgbJRIAcjnQ6m/cuSZpMEfZH1Aoz/wDgagw+cX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309623; c=relaxed/simple;
	bh=uWXrXU7zV0ucP6hOYN9p5hUEGvkRWkrjHTDBqRtNFQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M9u3/rEhoxOlkCNxgQdEL3/3Fre63cEwLqoOWgyConOfgw7QZhLnddb8WuaXtb0eQenOH5/wn+OCxcuNW1C7pTooi1CWHu1jFlDf97yi/VG+Q0KrldZQiPYv8L9fdxFlOaV7RxiNz0UQf8Bt8OExfD1DuyQjnX1satPiJO+7jKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vanqoMr/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vanqoMr/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c32faa62so16121285ad.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782309620; x=1782914420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+GnaUB9qp/nLMoVt45YRZ3NA9SXGagN6God624kPSw=;
        b=vanqoMr/gw/S7vhxvxefP31jJhy5hd+OKPk02mkfaOyVNKbk7jOaHY28tfiHznX1ps
         mXmvZEiKCbZxcbl/DpMYo4d09s2Io0yvlXIIWYe1iNuY0PJBAD4dxOkdFgN4/a2Hk9Zr
         CLEe/LMX7Pn9XDr4FnOf84T5OQc4ROSz5CZeQRXpFQ9XDEu0UW8byD5TCdeI32R70Gkt
         IJaxMZ1uw7w0PCV8z/Rn8gE02C62C1a3prKS5l39sn8efQyWcjc4kdHWqLtMTMN9bLXl
         KT/2CGYGiP/BV0kXYGROq9FYOz+P308XpEorczHuFuoz6F3iqMyijKcOZ7u7sRT5aCDR
         Nu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309620; x=1782914420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+GnaUB9qp/nLMoVt45YRZ3NA9SXGagN6God624kPSw=;
        b=NUr1tajWqi8gEa3yFs/isWqZn5lYGTxvw6qVxJ5keZFdWR6G7tNBEZN1569JVM8l25
         vNMSUVr/U6Mc6KcdNRSWpcS75UtVJPOrjylp8TRKf5fro0bYYfhgckYMlyDBF2RO1gRP
         hdKo3H6O6Op+NkoRwHYBM3FkbOClMRXjnvJeZJhBR0SZgiSSirZ+c58pDOcht39P7faG
         eSVCYdSVlbDX8Ecq5x837PGzeWVrp2GuiPZ27QGtjpMmdds60N3DqIFH8cPGi45Nxzic
         YMptTXVEUqZnuRdkGdyf936BEcD/4KlvkxzqUqDJkgaUPKL8egzFrbBeURvxcHVgI79J
         wUEA==
X-Forwarded-Encrypted: i=1; AHgh+RqxPfIVk6pYrkCvuD+Nw+ogJR+G9CXgd48vaIa2JCqEuciprUDZMuI93bHkHLQ64wJ3YHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZm4eiCiulBBStY+ZhpZPznaxS888uwABQ2+Xa2uabCIRaID9
	cwInO38WBxkNIBManlJpm3AkIi2W+peouOf3nuoHCawxN1Zr8fS8JtpbJTL3r2mBXGBIWkU/SLN
	90Exf+A==
X-Received: from plpa2.prod.google.com ([2002:a17:902:9002:b0:2bd:34d1:ea8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8cd:b0:2c7:9b3e:3987
 with SMTP id d9443c01a7336-2c7c76ce140mr81245405ad.25.1782309619894; Wed, 24
 Jun 2026 07:00:19 -0700 (PDT)
Date: Wed, 24 Jun 2026 07:00:19 -0700
In-Reply-To: <345e9d6c-d7d9-4bab-adb3-d6a7bd27599f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <345e9d6c-d7d9-4bab-adb3-d6a7bd27599f@mail.kernel.org>
Message-ID: <ajvi89dlwvirl4BI@google.com>
Subject: Re: [PATCH] KVM: x86: Drop WARN_ON_ONCE() for concurrently
 disappearing interrupts
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, syzbot@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, syzbot wrote:
> From: Alexander Potapenko <glider@google.com>
> 
> A warning can be triggered in kvm_check_and_inject_events() when an
> interrupt disappears between the time it is checked via
> kvm_cpu_has_injectable_intr() and the time it is fetched via
> kvm_cpu_get_interrupt(). This occurs because the warning incorrectly
> assumes that if an interrupt is injectable, fetching it must always return
> a valid interrupt vector (i.e., not -1).
> 
> However, this assumption is broken by level-triggered interrupts that are
> deasserted concurrently by another thread. For example, if a misconfigured
> PIT or a PCI device asserts and then immediately deasserts a
> level-triggered interrupt, the VCPU thread might see the pending interrupt
> during the check but find it gone during the fetch, resulting in
> kvm_cpu_get_interrupt() returning -1.

I think this the race is limited to the PIC case, no?  Because for all other
cases, mucking with pending IRQs requires holding vcpu->mutex.

So rather than removing the WARN entirely, can't we fix this by exempting the
in-kernel PIC case?  Given that we're pushing hard to move to a split IRQCHIP
model, this would preserve the WARN for the use case we care most about.

diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
index 3a2e4493516f..64f6592f5b23 100644
--- arch/x86/kvm/x86.c
+++ arch/x86/kvm/x86.c
@@ -7694,7 +7694,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
                if (r) {
                        int irq = kvm_cpu_get_interrupt(vcpu);
 
-                       if (!WARN_ON_ONCE(irq == -1)) {
+                       if (!WARN_ON_ONCE(irq == -1 && !pic_in_kernel(vcpu->kvm))) {
                                kvm_queue_interrupt(vcpu, irq, false);
                                kvm_x86_call(inject_irq)(vcpu, false);
                                WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);

> The warning manifests as follows:
> 
> ------------[ cut here ]------------
> irq == -1
> WARNING: arch/x86/kvm/x86.c:10860 at kvm_check_and_inject_events
> arch/x86/kvm/x86.c:10860 [inline]
> WARNING: arch/x86/kvm/x86.c:10860 at vcpu_enter_guest
> arch/x86/kvm/x86.c:11356 [inline]
> WARNING: arch/x86/kvm/x86.c:10860 at vcpu_run+0x57ec/0x7950
> arch/x86/kvm/x86.c:11770
> RIP: 0010:kvm_check_and_inject_events arch/x86/kvm/x86.c:10860 [inline]
> RIP: 0010:vcpu_enter_guest arch/x86/kvm/x86.c:11356 [inline]
> RIP: 0010:vcpu_run+0x57ec/0x7950 arch/x86/kvm/x86.c:11770
> Call Trace:
>  <TASK>
>  kvm_arch_vcpu_ioctl_run+0x1193/0x2070 arch/x86/kvm/x86.c:12125
>  kvm_vcpu_ioctl+0xa61/0xfd0 virt/kvm/kvm_main.c:4470
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
> 
> Since this is a legitimate Time-Of-Check to Time-Of-Use (TOCTOU) race
> condition that can occur during normal operation, WARN_ON_ONCE() must not
> be used for conditions that can legitimately happen. The patch removes the
> WARN_ON_ONCE() in kvm_check_and_inject_events() and replaces it with a
> pr_err_ratelimited() to log the event instead.

If we can't salvage the WARN, I don't want to log anything to dmesg.  The purpose
of the WARN is to find KVM bugs.  A ratelimited printk isn't going to help on that
front.

> Fixes: bf672720e83c ("KVM: x86: check the kvm_cpu_get_interrupt result before using it")
> Assisted-by: Gemini:gemini-3.1-pro-preview Gemini:gemini-3-flash-preview syzbot
> Reported-by: syzbot+dd769db18693736eee89@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=dd769db18693736eee89
> Link: https://syzkaller.appspot.com/ai_job?id=35cad3cd-95fd-4c0d-8ca8-812f58d56e59
> Signed-off-by: Alexander Potapenko <glider@google.com>
> 
> ---
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0550359ed..c5b4cddd9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10857,10 +10857,13 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
>  		if (r) {
>  			int irq = kvm_cpu_get_interrupt(vcpu);
>  
> -			if (!WARN_ON_ONCE(irq == -1)) {
> +			if (irq != -1) {
>  				kvm_queue_interrupt(vcpu, irq, false);
>  				kvm_x86_call(inject_irq)(vcpu, false);
>  				WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
> +			} else {
> +				pr_err_ratelimited(
> +					"KVM: interrupt disappeared between checking and fetching\n");
>  			}
>  		}
>  		if (kvm_cpu_has_injectable_intr(vcpu))
> 
> 
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> -- 
> See https://goo.gle/syzbot-ai-patches for information about AI-generated patches.
> You can comment on the patch as usual, syzbot will try to address
> the comments and send a new version of the patch if necessary.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
