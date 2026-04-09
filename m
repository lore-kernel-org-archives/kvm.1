Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208973A6B6B
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779005; cv=none; b=LK2ZLMKoEwL42/aGeIuEDcL+sFxmLQD9WvPCCmSeOWQIIJTgPt3/FTpyqB0K1pjl2wl2oiII0huu6yJtuwf2AE3KyDJUdztbfC16NV93z23KLuxoeJ1gD0m0EeZV4QYH5ORtK4OeYmdWsKj/njgcBgfM66wg2NmNFDhwzxNqmTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779005; c=relaxed/simple;
	bh=km6YOj5goX/XvbVUtkoW3Xk9iRiy++c/4OSOnwn/Er8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WcolCHMxfZ+9pyBuZL/wGCw/2vox5eDIeaaFO9gkO6X6NGZpUblPP/iRpwaddYQxxx4TCcVtgzlzRudEG70H8GCPEpxhaKQYbQzVFARx2OXxZwcPuFsGbd19kNg1FCgklRDOKL/zXmYXOCoePmpgkOkb0CbLE06uR7GyMBMntLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEwfkDMz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEwfkDMz"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso1693979a91.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775779003; x=1776383803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qgfsXecMrfEVfBnUgRnO6VRKUmU+TYegYj1eRe4Wi0Q=;
        b=ZEwfkDMzIG/BamCLeoN4mDzvvgPYpjaSyWSYzSSNgHiGKcN4FELOYd1ycrOK1//ons
         +Q38OErqyoEWYhIm/j85UMcZZzUKkZE7yqMYom0upLqM+jHx11y63qYW5bp4FSdFXSaQ
         HLh1S0ctElW1XDkFd6DWzfhHjNk6XgXtrl37+pZxEYqJrhx8w8TgzmpFTSSAHzklIucj
         3vHhKSdc8qrdi2W36txuKQmqae2Nmt9XU0u8NOSHebcZNFMyAF0+Y6YTuYBsGlI6qldr
         kT56QDMsaKXWeQcoU9xUyBQlcGBQbrne2hpzIapQP8qtFQ8OBeI9/STcCxmCtAy1Jl5a
         bGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775779003; x=1776383803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgfsXecMrfEVfBnUgRnO6VRKUmU+TYegYj1eRe4Wi0Q=;
        b=AM/76V5QsYxOPXalp9UwmYv1CS7bYQ75fyxaE7ZEuT/VLHyznDehD28wqvnvabe+DW
         QXABd0eU/5hBekz9RM/FbGErz28XWD5BCL6qxopbJ0lakh/0YydT3Yyw4MdStsX0k+sY
         c1sdxNKj+1+CnznipBmNCHoO6g5iepVO1Lgwok6Gxa6tZTGXQeNR5HYo6QNK5Mbr0Qyg
         6wizpn/hXgc5c3XU8qAclR9wY1YbHf8GwgSHSbWOlflkyB4G+olA7l6cpoiRiDdL4MdE
         J2yLGjqf8jhe6oIhIg9DmfcXz2k9Bo8OaXGk2bgvDT/+mRimsw0E5rAQ9ozOWn46aQIQ
         y84A==
X-Gm-Message-State: AOJu0YzUfXPdgF1OuyWH/UVCKpl/UtQho9I3CTlg3CTCzihrJpTvcn0S
	PzhqG6IsQqcqSN3SWh/pYgNAnbN0kohtttu0/iofI7xkL4PxzSmWUjoR5uBeMhcjGoi9iSG4L0z
	AxH4cRQ==
X-Received: from pjbei2.prod.google.com ([2002:a17:90a:e542:b0:35c:251c:2305])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d83:b0:359:8a78:569c
 with SMTP id 98e67ed59e1d1-35e42827fd2mr992968a91.25.1775779003015; Thu, 09
 Apr 2026 16:56:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:19 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-9-seanjc@google.com>
Subject: [PATCH 08/11] KVM: x86: Drop non-raw kvm_<reg>_write() helpers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Drop the non-raw, mode-aware kvm_<reg>_write() helpers as there is no
usage in KVM, and in all likelihood there will never be usage in KVM as
use of hardcoded registers in instructions is uncommon, and *modifying*
hardcoded registers is practically unheard of.  While there are a few
instructions that modify registers in mode-aware ways, e.g. REP string
and some ENCLS varieties, the odds of KVM needing to emulate such
instructions (outside of the fully emulator) are vanishingly small.

Drop kvm_<reg>_write() to prevent incorrect usage; _if_ a new instruction
comes along that needs to modify a hardcoded register, this can be
reverted.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 2550380fa79e..cebea89b296c 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -435,11 +435,6 @@ static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)
 {											\
 	return vcpu->arch.regs[VCPU_REGS_##uname] & kvm_reg_mode_mask(vcpu);		\
 }											\
-static __always_inline void kvm_##lname##_write(struct kvm_vcpu *vcpu,			\
-						unsigned long val)			\
-{											\
-	vcpu->arch.regs[VCPU_REGS_##uname] = val & kvm_reg_mode_mask(vcpu);		\
-}											\
 static __always_inline unsigned long kvm_##lname##_read_raw(struct kvm_vcpu *vcpu)	\
 {											\
 	return vcpu->arch.regs[VCPU_REGS_##uname];					\
-- 
2.53.0.1213.gd9a14994de-goog

