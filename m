Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224FA3D1716
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795642; cv=none; b=Tej6zegr50VeGZ0WdSU1XObg/1c16v74mL75DhPbne3NjI0QdHtf0EOPxwXqzU7fYUKlIKsPXohBOsb11YJ1a2QMRFgUpO/i7C48z4G2CZB1OGO648Tgu+HEjZiEBzayIW+2yIjFL+uS9IxV9KswfZqtVNT+KlSjktaa8RLQS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795642; c=relaxed/simple;
	bh=alOj0ulkorrTMebS435FX8VSWcJfgxZS2VP50saGg/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cu3vkJsXP5hTJ4C+AVJP0zydgr8+mvF7Uclk91PBKdYStzUDznHdxVnRTXw9vFmMwYO7LLVBAh5c7D9vJVGRT7GNwIw647rGfmzRW+Cw26+84wdV0UIUCk6rrolKlRJoLEKMANq866Dn5acoXv5jofulkOyJH9GJyBPuShP0vqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BAKVKFXr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAKVKFXr"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-836d0184333so8284242b3a.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795640; x=1779400440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OSIIeDvi5cUuvLPtbPSIJ0wDOFHmUc0VllK+0XWeleY=;
        b=BAKVKFXr5kMm11OUaGbZK+Yu0SKersIp2codoWihh5yDxxjmr6aTQetszrD8ngytgS
         aCN2cAjLsnWryhltZvgCswV5ryjrmUbjKaNIdn3O7KPPYE3rb4JilBTrVNTyC9404wwR
         Zcd8FsieMcBDAOeuHr37eEQDsgpmZx+YFfeXZlVabq2oKMkfb99q8TPY3Pm2cKQRXaK/
         UyMYQhAQp414LnLy76HgohfGAjxjqFC7xjAdVTfSzE+pcVNoAyqUZ9O6fiNglAyDZQxM
         i/TcL1c2emC+SVPWVzAeGoeprlNGdHs0ovZp6J/2o8IIig+sdKoWpkzAfSUnDA8WBwEV
         C6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795640; x=1779400440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSIIeDvi5cUuvLPtbPSIJ0wDOFHmUc0VllK+0XWeleY=;
        b=S0QN/WpSihiLiQtP8kQoyF/53phqvvHOags5xrMKeEEZSB9F3YG8mSz7ox/jojtyty
         VvhbT7JMldCImL9ux49U3JXqf35uGvA+KMz5MFnTK9vBboZ2I1gsdLInvsFetGrQscVZ
         m24ab3UItW42y2vla6kQAVUWDk5N6QxntFHSO7XewyKrcoaPcQ4BtUX06DX+34Ov7gd5
         FSqZ5iNnsi0dT5wNVU86ISsD2Q3ygS0ntzKGxEsk88zaWgBFCk0KGkUqhr5LANxGd2UT
         xyS5falqnUI8cSJJF+7I639L7PV2vlH3hTggx/NnDkVkkxopq38cp93/Hd58ryFGaWgl
         f4yQ==
X-Forwarded-Encrypted: i=1; AFNElJ+voHFksfpf4EuJYf/m4Dcs1aoI8b0n/tiT/4Sl7tBAjJLh098+cxRKvvRpS5y+6V2B36Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGFGH7NhEr8h61itqld3cLuTxoXLMhpC07uOHhTyyOYo9YuJE
	nFC865Kj+xWWo0wcYFzFIhG7PqoKAMZKo8iXeI5glipauDVKbb3oda5sCtBfibb0CDo1RHblBWY
	Qc8Z+Nw==
X-Received: from pflb19.prod.google.com ([2002:a05:6a00:a93:b0:835:4315:3453])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e22:b0:823:d2c:b156
 with SMTP id d2e1a72fcca58-83f33c4f71cmr1244822b3a.5.1778795640146; Thu, 14
 May 2026 14:54:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:43 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-4-seanjc@google.com>
Subject: [PATCH v2 03/15] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Don't truncate RAX when handling a Xen hypercall for a guest with protected
state, as KVM's ABI is to assume the guest is in 64-bit for such cases
(the guest leaving garbage in 63:32 after a transition to 32-bit mode is
far less likely than 63:32 being necessary to complete the hypercall).

Fixes: b5aead0064f3 ("KVM: x86: Assume a 64-bit hypercall for guests with protected state")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 6d9be74bb673..895095dc684e 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1678,15 +1678,14 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	bool handled = false;
 	u8 cpl;
 
-	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
-
 	/* Hyper-V hypercalls get bit 31 set in EAX */
-	if ((input & 0x80000000) &&
+	if ((kvm_rax_read(vcpu) & 0x80000000) &&
 	    kvm_hv_hypercall_enabled(vcpu))
 		return kvm_hv_hypercall(vcpu);
 
 	longmode = is_64_bit_hypercall(vcpu);
 	if (!longmode) {
+		input = (u32)kvm_rax_read(vcpu);
 		params[0] = (u32)kvm_rbx_read(vcpu);
 		params[1] = (u32)kvm_rcx_read(vcpu);
 		params[2] = (u32)kvm_rdx_read(vcpu);
@@ -1696,6 +1695,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	}
 	else {
 #ifdef CONFIG_X86_64
+		input = (u64)kvm_rax_read(vcpu);
 		params[0] = (u64)kvm_rdi_read(vcpu);
 		params[1] = (u64)kvm_rsi_read(vcpu);
 		params[2] = (u64)kvm_rdx_read(vcpu);
-- 
2.54.0.563.g4f69b47b94-goog

