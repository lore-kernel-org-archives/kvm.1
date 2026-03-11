Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F98367F47
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189249; cv=none; b=JLw6Zan4yRBGumLmllgzU6zCI7HhD3GUZ/rJI6Hrw4uks4hiawP2KeBSaxQs+Z+SDWNrcfNwQSW4QRrUobqNJiHTn6780MIUck//Qee88oxATaPsyYSzwzMcweX1VCO4jpndL5M0HCxsoU38whePvrGlT5Oq8QhZC6v0L/gksuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189249; c=relaxed/simple;
	bh=7Om9PaNSbH3o9snTxwvrRdRO+tJyXxxbS8Gn1LzLrWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kfvck2j3+69Nqd1+Ewq3sDgoFN537tdenoH5gLgqSt+NNur3PcD24D/OAhdG/O3xXG0rgAayXBtLfGgfIgHOLFB1w6lLX/5RKv1GUCxvk5NdGUHm0JHBDQlFhs/O+OEKeoV6b4etg0Cf6vYKcN0k4mVuKTvCmuvQ0KpBdswHc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DLhqR0Pm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLhqR0Pm"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6e7f45e2ddso47742791a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773189247; x=1773794047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=r+juLCyU3+NAIYivhdo5Xlsn2qwlsyffxNBIS7NuIQ8=;
        b=DLhqR0PmuIu2Lwjc/KpEVLBvarxX+jQw4TB3RhkMpHXRjGkCZJr0L7L/c5qY2CPzGz
         OrdR6IrDWqM1Ixu3nXHn3gQkVROjWdL+1eaf1MPMRU7jKNGlusqLee2a9Aj2GAicXMEu
         S3x8wb3fto3y+P865PFFJmAU83PiGXTt1ZBQBY9H3B9f6URWuk54NRvL8LfW5UMamslX
         k+vovOFzBHDP/vPr/JVv0o5teNk66hlPjz52Jlwge8w5BxfhqW3PmrsLovc0AQFI3ipD
         cZB1aNUn8qR/7ctbqeZywqUS6HwmEsrl5KpWFGnHiVKrykRlzdezveBNc3o0iFWlBTtr
         qViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189247; x=1773794047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+juLCyU3+NAIYivhdo5Xlsn2qwlsyffxNBIS7NuIQ8=;
        b=qnN7sWH0zTXo7mtLYFQOyAenrhXqL0h7ROis+qDIh0/9IoBovxB1kNVY8FPgj4VYcW
         WvQLwnNaHstLx0FmRoKZ02Y+lj71tMA2Dtghz27LsYhpmX+gQUdnKIQUlCeHKiiYOOdI
         Cuz1qwVVGu9T0JLmFl/cwGfY4U86w4e0oXlG+JNcjKLARSINSfNT2TyQQcRKhH3BTdYq
         +L6ZD1ocQlMCk1hC7Xtq7Tsz9qp7vdqXnfzSvCeJO61Jh2yWCXUTlOmoJwdZPGjW1FRa
         Im8P2JfzDBW7ePpRM7fgwukSg8QrVK+Wl5qPfNLhDfJPHqNsC7atHGI0VI2e1va4zhOq
         x79w==
X-Gm-Message-State: AOJu0YxrlEbtCL4Py/767gQkk42ykp0lkIFyG1a363+n6ILM0XhxDUQH
	UDT0wJhsODi4GwK4jQ8ikxFOtYO/PuB7GSUwP0g+H0AZJsG6LE4u3DJAUD3A1NgpiBBVvOSpC7d
	uELgy+w==
X-Received: from pfkq5.prod.google.com ([2002:a05:6a00:845:b0:829:72ec:561c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:13a5:b0:824:b1bb:f6b5
 with SMTP id d2e1a72fcca58-829f71bcb9fmr777882b3a.63.1773189246869; Tue, 10
 Mar 2026 17:34:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 17:33:46 -0700
In-Reply-To: <20260311003346.2626238-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311003346.2626238-8-seanjc@google.com>
Subject: [PATCH 7/7] *** DO NOT MERGE *** KVM: x86: Pretend that APX is
 supported on 64-bit kernels
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cff9023f12c7..3d9c8cc9d515 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -190,6 +190,27 @@ enum kvm_reg {
 	VCPU_REGS_R13 = __VCPU_REGS_R13,
 	VCPU_REGS_R14 = __VCPU_REGS_R14,
 	VCPU_REGS_R15 = __VCPU_REGS_R15,
+#define CONFIG_X86_APX
+
+#endif
+
+#ifdef CONFIG_X86_APX
+	VCPU_REG_R16 = VCPU_REGS_R15 + 1,
+	VCPU_REG_R17,
+	VCPU_REG_R18,
+	VCPU_REG_R19,
+	VCPU_REG_R20,
+	VCPU_REG_R21,
+	VCPU_REG_R22,
+	VCPU_REG_R23,
+	VCPU_REG_R24,
+	VCPU_REG_R25,
+	VCPU_REG_R26,
+	VCPU_REG_R27,
+	VCPU_REG_R28,
+	VCPU_REG_R29,
+	VCPU_REG_R30,
+	VCPU_REG_R31,
 #endif
 	NR_VCPU_GENERAL_PURPOSE_REGS,
 
-- 
2.53.0.473.g4a7958ca14-goog

