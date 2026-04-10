Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC139B48A
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865539; cv=none; b=WzHAwhqf5Ttj5rJW7B+IWVJ55WWUEncbSnlZAFWH38nFXon1APcM4wWh+Up1P6GhmeuSMnjF8lTy24YrKT8l2AR4VM2wp9zXV5A8gaqAt+uExF0XmUsyLcCKDm9YSrDlfQZ0msdpX2Hr6ApWwpxpO7vZxx56VRsXv1VRkR31orE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865539; c=relaxed/simple;
	bh=nXR3G53f0zpLUseB8nzJCOsQoqOFkC28INXNCJ4wdSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=msUY/im/Oqpsu+WSDWVYv+MkgrI5aKvCgPoA7TX0cDLRty3foZ0/45FMPaVa9NMI28Kn9eutLmN4HfDfBvSnOw/V23Z9DeKrMDeSvWvprpYqknexmMUh1n8b8u43XzVqsZqJoaRRcAvT7Ftfjn67D5JAi7KI+mOLvgaKnNY86xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6gr1W1g; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6gr1W1g"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c7a84a43eso3199155b3a.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865538; x=1776470338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=v3bm8d3hsyiWzBAicAtQtt5LoIkZQ59PYizqk25Kq4I=;
        b=f6gr1W1gYEnN2um8o+DOViYKvZ6S+ZfLvXYVdTh7fUpen9y2JpsEwM0dbOb/60GMyU
         s7nahYEtgRGPEWwXsfcfZSS3k6vr2ShsH8ufNwIyki5jG2RVZfpH8faUmOjC8BUPkQpk
         uBv1tmc2+2lVD5H2mNDMbpPPPG2zXjvhYm4Hu5NTs9Q8CGH+W02mNvktlUjPvTLNbjAM
         3KynRC5IF34nbwUD7AWrh7hE3+xDWQ1HmjbJinHzilF9bV5/RPYE4M9dZ6ASKwQo/h/x
         iARPE5eNFzZV6KrIMTXmAa6qUhmvI744o9ZeMFTO3ToYz24PnsWdq0b8Bb6mFZsaPoYM
         grMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865538; x=1776470338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3bm8d3hsyiWzBAicAtQtt5LoIkZQ59PYizqk25Kq4I=;
        b=oYeC464Ci0jy9GY4ulfqi15VMKZK+3uyz1tPqZiPfzr6L5ttrs7XuOvuGIBOadcM6Y
         W8anNaBTCjeyuxXQuIw61NfH2chutpFlIPC8qNUHFWYDMc9uBUhpnoldg3fvrnExCCu7
         bYls6xO7c/3+T669wM5CKHX73AsnSwDKZBM9qXem9PXYgRLjUmo5PVRYyGEnOrRIJYoc
         crlABKor8X1Orn+LKXN7uZVCq2ro5ICVEz0pyGMyaSLM7onCx9gFgn9iyf8jIw2CMroT
         CHYvKXV8vL9sr4NkddSy32/LEPxqdN4FlWtL9nbqAMEfeshpQMDouATgCsI/S/oqcP97
         9aiw==
X-Gm-Message-State: AOJu0YwzBsFPELwyDm/Xomwho5bb50UoIKn8foDgZa+VaJYgnbtziGF2
	KEC7Gdv+2Y4v1bpXHsK4Sv+R3ZtspqNYSz800OfUg7EtkQasN5WsdNP/V4aOuwg5+2MlDjER3Vd
	bjh1slA==
X-Received: from pfbem35.prod.google.com ([2002:a05:6a00:3763:b0:82f:12e6:82f9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a245:b0:82c:6d88:2a8e
 with SMTP id d2e1a72fcca58-82f0c28903fmr6054272b3a.20.1775865537483; Fri, 10
 Apr 2026 16:58:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:29 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-11-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX changes for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Two perf tweaks for Uros and a minor cleanup.

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-7.1

for you to fetch changes up to 577da677aa7cbc13040e4951170d39ec7663ad8a:

  KVM: VMX: Remove unnecessary parentheses (2026-03-12 09:05:56 -0700)

----------------------------------------------------------------
KVM VMX changes for 7.1

 - Drop obsolete (largely ignored by hardwre) branch hint prefixes from the
   VMX instruction macros, as saving a byte of code per instruction provides
   more benefits than the (mostly) superfluous prefixes.

 - Use ASM_INPUT_RM() in __vmcs_writel() to coerce clang into using a register
   input when appropriate.

 - Drop unnecessary parentheses in cpu_has_load_cet_ctrl() so as not to suggest
   that "return (x & y);" is KVM's preferred style.

----------------------------------------------------------------
Uros Bizjak (2):
      KVM: VMX: Drop obsolete branch hint prefixes from inline asm
      KVM: VMX: Use ASM_INPUT_RM in __vmcs_writel

Xin Li (1):
      KVM: VMX: Remove unnecessary parentheses

 arch/x86/kvm/vmx/capabilities.h | 2 +-
 arch/x86/kvm/vmx/vmx_ops.h      | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)
