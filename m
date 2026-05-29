Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11043E9FB
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093385; cv=none; b=cL+rQP7GxBqTf3vjI+QTvE25IKrXkrGG67X6OFyu43VUA5G5ri0tu8ABo+JfC4Sb0bk8Lg4tHqb4Odt20dUsZkbhN/LFYdzL/2xLW20B1+SnnQ+1Wd4d6572SPxz8isjeifd9QQd0ILoMn68+H4328Nbkzg/i5Ya3Ufz06geKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093385; c=relaxed/simple;
	bh=+s7EmeMhycIHSHknTX3BroUkHXXTYHphV9Lyigv0Y2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CciM5jXbP3iU4+mPjQim/plptgf6gCpMYDi7mf2jKIErxWhrM/TxclJEde1PjOVwB2XJFAxhkwgA5+yfv/jStXaUA9pRIxXdvZlOgqc3LfM+EnptJKQnoZJg509m3caYReeJ141SNc+lRgpa7TBttAuBtJoR6qtZxXLOYxM7L64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFdytNM0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFdytNM0"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c857befe561so361716a12.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093383; x=1780698183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Or3Hjg0NqITAPRhpYIql5ziLytgduUzcn5JhR8+Ygug=;
        b=rFdytNM0OyYny1OX1ou+OpJkgJAksM2hAXlIHxxgtLYjDiRCAluKBJmmcIrKjaPfrh
         BhPoppL+QlJrl1ktrdWdprokdWi0z5+2sKjd4qYxx8og9wDVO+UaykUq/n0IZqrxFjF9
         R7nhAm0vVmzmA4zvsARgK4IPH1uq9ZRrlM9kFTrHVCg6j9EStNqnVsf7wL9F4X20XCHd
         HHyFX8v1o2i1hHYec1+vjPaZhD6Og0NhLlmUBXMEWEt/Tvqz65mH8giH8T59RXzXrEHx
         0YN6ur1D0rodcHz5AMSrTbH/Y/JryiAWAyHfa7pzxuiOaGYJ/mkNWIeUqx5RUXE2O/LW
         AqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093383; x=1780698183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Or3Hjg0NqITAPRhpYIql5ziLytgduUzcn5JhR8+Ygug=;
        b=Xn9GPtZhyvtlUtmKw5y+QIsmOEjyR0Dk8EsF+PgOSAp56SqCazmQVGGk4o5qpw4bya
         v8IVTT5VrY2T60wzTTFA9UrLkepvUIZvsvxPaYJeK03vlo6M/FHWUvi79ZxbAOKHvwLf
         p0BuYO/OvIY+hDlzFNXa00MNhbP/N8CJRP9Cqqj41RTSyF2FouRdo1j8zBnNCHNsXnRJ
         EOQreDcyhqj49yXn0lI9qdOWasQCdf1FFQlklEJfHavK1VYa6MvNl4T+ecypT1O9+lM6
         rJrHGYusttyThgiKHH2PzH6ghg3AEXHybaaFOAOH9MqTaApESToXbwlVc8xYYuSQX/ZX
         00Wg==
X-Gm-Message-State: AOJu0YwzcxrYWvB3RGjVdZ7SC4uvyMsEP31xOdKSUOV7AvR/ZBvAEdsI
	LkUrVICz8dtQzq5JS95eyNGEToQcmsr1p2rOwbIIK/Tk7IiHFMSNTz43BTdzfNFy+L/h9Iz2ATi
	PFNpPDQ==
X-Received: from pgbcm4.prod.google.com ([2002:a05:6a02:a04:b0:c76:6c2f:89d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:730e:b0:398:abe1:eaac
 with SMTP id adf61e73a8af0-3b427f2f9camr1282404637.27.1780093383252; Fri, 29
 May 2026 15:23:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:00 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-18-seanjc@google.com>
Subject: [PATCH v3 17/40] KVM: x86: Drop defunct vcpu_tsc_khz() declaration
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Remove a dead vcpu_tsc_khz() declaration.  No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ee205f8ad5af..2e535027dd5c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2146,8 +2146,6 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 
 extern bool tdp_enabled;
 
-u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
-
 /*
  * EMULTYPE_NO_DECODE - Set when re-emulating an instruction (after completing
  *			userspace I/O) to indicate that the emulation context
-- 
2.54.0.823.g6e5bcc1fc9-goog

