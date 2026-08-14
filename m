Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5348C3E3
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723902; cv=none; b=LL4S9NbfYLk9P4mRXA8RiHsDdJPF4V70Lw9u7h8zq74NwTm6o+LK1KZkqJU+xRJxnvrBetye3IsditSdOU00wjPLZG+cyAbDcJ89t6IzKCjGTikhh+iydrZS5BZ4+ZtY0gd9Te0IZOoZ98ebC8YZ0Lt/cZhc1D8Q7opQKC6iv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723902; c=relaxed/simple;
	bh=jVDZ6RnPX9na/oXpRc2RUSVKCpg/b4zH+emyqfa+r6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UdPGMuh/Q6Qh/Nt4wza/Kjiozl4asfkBeDkxy+p6G5c7yP8uAzS3rvfUxxm5pplkQSfIecyIo1IM9gGBMSQ4+TIYP/WQ/b+h0bZnL+r/5OtiedW1XwLC2YR6GmIFjjR4Rdf+ty5+9FXvKaiVMBRDJljskB0OgO8AyesJhx/8rkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WGJtYjT/; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGJtYjT/"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so15800205ad.3
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786723894; x=1787328694; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=npuY0OiAv0Qcgrb1+8fGuXoJuldQQTrhGouNj7zkH78=;
        b=WGJtYjT/1WAVWPtP7VwUJYF99H4zegvdZoXUWtc6LP+H41erJtTIAsfjmIqmYXPgmw
         1ZrrneyH1UawgZx1ppU4sJOhdE8T2j8nPAWheXg3Sh5Gux+p1qK9a/jItHq4MSMxk2x8
         NqPACZJWUbrb4vb5Bn+nEGmVG6u3Q46cFyjbMLeDky0G3+8RhpSjUtJGF0UUvFoc3vpw
         OcINpCRMdtD7Zpx+4JFMlhPPcxUpQmeQ4nuydjG9uZyeQC2QhVWc6SGBm0yO28ydrtbD
         hi5Ir4qyMa7ixIQ3IU2vgQ8idNTw6CsdOCNID9+7S3OBAE96mHEtaYAzaKWFPWYHx7sk
         UD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723894; x=1787328694;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=npuY0OiAv0Qcgrb1+8fGuXoJuldQQTrhGouNj7zkH78=;
        b=QfgYX7PIhPLElEuO1RbPKUV8XZhYoe7rMC+N40aK2+IWsL8DnsaAi5f2iHPYH+mQs1
         pLCgX5Et95ltVW3bVMsrS2svojwm15gu6lcYUzTg9lo3pqh99i33RMgx1EebyOJhGw+4
         s0aMO1MuvVbNpc06ZB8ckO6MecJL2GvOxll9nFb8q5dfpuQXQRFunQaR5hBwS2VfhGbS
         YdapLoJsTXFs9aLv2Jr5qlxglLe7RC26PwUWAA4T50e6oNf6Xyix9cyiPCZeXffFc8D/
         +BYTR6wQqC7KNhuwRBNmVq03e9Gz8Xj0SzdZZlLLtHHAvY/pVUmK+LLbiy8Mzis4h2gg
         fgQg==
X-Forwarded-Encrypted: i=1; AHgh+RrHzdbnRlKp76rL3eTMKTpNcC0qC31DT5ITIKo2fFK5nWtbmKkEE1zimUP4f8K+niEWOQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JjxTWtQfHuBqfbAo8UuMNJZwL42rhqAOfrpdpDjC/oIW+AHB
	AnWQ0PFQcKzROfEqxVU66ofExSOk1nDqBrn4N/un+flqWvCuyPKvcHbfoquCdkTnyKDxwV58Pvn
	ToBiEzA==
X-Received: from plou15.prod.google.com ([2002:a17:903:1aef:b0:2d1:1cee:1618])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce86:b0:2c8:f34c:82c0
 with SMTP id d9443c01a7336-2d3b0aeeb6cmr71992085ad.2.1786723893656; Fri, 14
 Aug 2026 09:11:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Aug 2026 09:11:28 -0700
In-Reply-To: <20260814161129.2177118-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814161129.2177118-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814161129.2177118-3-seanjc@google.com>
Subject: [PATCH 2/3] KVM: VMX: Disallowing using to_vmx() in common VT code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Poison to_vmx() in main.c and posted_intr.c so that attempting to interpret
the vCPU as a VMX vCPU will fail at compile time, as opposed to failing at
runtime, or worse corrupting state without outright failing.

Note, to_tdx() is buried in tdx.c, i.e. isn't broadly reachable, and so
doesn't need the same treatment as to_vmx().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/main.c        | 2 ++
 arch/x86/kvm/vmx/posted_intr.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index aa5b44bb212b..95d89d809c19 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -11,6 +11,8 @@
 #include "tdx.h"
 #include "tdx_arch.h"
 
+#pragma GCC poison to_vmx
+
 #ifdef CONFIG_KVM_INTEL_TDX
 static_assert(offsetof(struct vcpu_vmx, vt) == offsetof(struct vcpu_tdx, vt));
 
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 4a6d9a17da23..24221ba553be 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -14,6 +14,8 @@
 #include "vmx.h"
 #include "tdx.h"
 
+#pragma GCC poison to_vmx
+
 /*
  * Maintain a per-CPU list of vCPUs that need to be awakened by wakeup_handler()
  * when a WAKEUP_VECTOR interrupted is posted.  vCPUs are added to the list when
-- 
2.55.0.691.gc56d675ccc-goog

