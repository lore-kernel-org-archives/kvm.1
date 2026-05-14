Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66A3D0BEC
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795650; cv=none; b=nHAZqpnLpaaWU8EeQKdbv5g2JRU/2NV/4OA9qnTkjVTOWXxv5sFe3CGNeBrsBzmOqnLAH+I6Tj5Rwlpn9pXXyzaiwdODSzJlb0MmFWukw3dJqF3Tpbyzz+BUGxy7U0qMV9lkamJxF5mmzc2rwvgOtr9alJddlM9WK3ffhR9XJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795650; c=relaxed/simple;
	bh=N92fSgTbRoFdGmTmYT2jdWK5Axf4rwJn0qavUPuZUdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ioWXQTp5Wu8oEDQoABbdaZ0652E/LKZE5wXCYR5+lmZnublKhom4lq8elOLJE//Y/NtgFe8GR+2l3NAkIA2vOnMLthM/GWxTQ9J+JxFGIxqtXuG5gBgVBjr7c4IXRI5DOWv64lYR85k8X6UHrjfQjaX7nehGe9Ys5WX8oKodgt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EP6doiyu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EP6doiyu"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c81086bf930so142832a12.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795647; x=1779400447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0lOseohsrh45pecTnMcOmR3eyEgHoLMULb1l21GrEmk=;
        b=EP6doiyuRkVULbl0xHTSlcOOViQowt+3TqFJoXs2eQfVOwa64tSnxKwyrkcgeQfBto
         6J3+Qup7O/gB/KZ1yKLFjpiJxdPgflA1KQCLbj5I78AsAOuu4f+Y6iYzy4Q8nTM5w89S
         EzvKEzyTQJzqUMf5G39MnG/WRIt3j9qfTzrJsfrBalpQ6QE+ROHNtLhVLMq3rzVeV5/t
         x5MVehleQm9BTiTcD1Eu9d5uHN3nPPIK3cOXW3xZbmJLX9pG5AnT+KZNvnMPIE/fSDyj
         R6n1Ro07jDiE+XzAB8ODV6megQpbj5aN22yMcq94lKToIW5bhgOSfPNKuxbtJYKtqOmG
         HAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795647; x=1779400447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lOseohsrh45pecTnMcOmR3eyEgHoLMULb1l21GrEmk=;
        b=PAJlyu3kPAm9VWs3htqkj166tyu/Frt7N5hbA8pab6m5quYbM+VC+d3PEGXMuXzKqB
         NMtV/egeqPokN4vH7y3rIuOZo7MmbQGFtKbqzBBNDrPfkHYhq56acXmRW1mji5Ob1DHN
         lWWWYnK0nS+mpL+P2j6Q9PUgkcL7jsDcBQRvBPokCKA4a870xyAmokrkRSDlgzz8zQEX
         tXNFuMl2JQuPSMzQDtPnEPNlvfrN1SXg72I4xDmh1ul7dBzoAuascbsNovGqxeHIVuM9
         ysd2dSOVBLfzakXCOESxhJnUjzMt3j8D4s+7Uh4s5VxoaFEV/nbo5eV8Vb2qVAKfi89f
         oB0A==
X-Forwarded-Encrypted: i=1; AFNElJ+p2lbEXqxE0T7YuySLuPqXipKOoHQH5RcykW953dVZdZzygOP4qoDKQlP67K3/ikjWcYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcvAlEQBe3j4EJ2HGtPAsWQ6/KPv7Ijy/sX5AMekgEvjh2qznV
	JinwuoouEvymCehI+/ngzeNSFJRE+RWPVjCbqhjx6Vn5t1Xw8+gG7qOxOFdUshSm6RUfRUsvew2
	h8JnPQw==
X-Received: from pgna27.prod.google.com ([2002:a63:705b:0:b0:c82:7a7f:9bf6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7349:b0:39f:3559:750d
 with SMTP id adf61e73a8af0-3b0c0abccb2mr4934624637.31.1778795647024; Thu, 14
 May 2026 14:54:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:49 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-10-seanjc@google.com>
Subject: [PATCH v2 09/15] KVM: x86: Drop non-raw kvm_<reg>_write() helpers
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
 arch/x86/kvm/regs.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index b28e71caed25..52bed14f43e3 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -61,11 +61,6 @@ static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)
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
2.54.0.563.g4f69b47b94-goog

