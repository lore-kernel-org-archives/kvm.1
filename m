Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B01F94F
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309031; cv=none; b=m9UYd/bTfDEIHCN3iTHpl9lJ3FmR7i5GlVnCFRFLlH4pWlx0tgEKy9u/NPhCtchom1AvMTXG0s4o3IVYdMYUF7AmWFMzZvgWQVeHLslm6YPqCpq1bZKwb1InaABJ7m6a52jIRwEo5w5Ka3RuKUngsSHNv9VwFLjHFhZHarJqqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309031; c=relaxed/simple;
	bh=spkvsYJxIJ/bt30ONrUQHX3Q8fh8GhoPa04C0mbnnDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tm3AsvMQluMOIOTj1FhoOphPcHVlaUcZ9xp3J9xh1r7ikil3nF9LznXawYpXDBq1G22pIZsYWD/xSM8UPbjE1ECDosVtKcbe+V1Lnsg/IEZlM50JAM64phrx9n1KU6Ch4dSNSTLZH3jQpjR3nL6TWC1bnIv433UoNjuu1q9zRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D36rl4fs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D36rl4fs"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2f1d1e5so777963a12.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309028; x=1781913828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XsqX8ul31omnahVYm0CzB5wNanpXhf4DkeREH1vPrD8=;
        b=D36rl4fsuOwoVExh/PE3RNnU72CpM+GwofYuualelClggr/wLTP8jbr+StR7vWyzOo
         86qw8QbgSRUXLfwibGS8o521OXTkQcBYq4GuQhv4EPBGC1vhKXoJEhZjcIokOpE4gLlv
         C6HmURXlM0saoxQn3EXDhoUXEgrUgADWJhSokDvQTKsUp4TryDwVJJp/ITQ8iZ96GStp
         Awdv/CxLHSxChMF2g7rmjZ795tnyZLbInJdgx+Yln7lQjkhhR8dVn97DObysQkb8NgKj
         fp3m9hlFN/pSCTrnj4Xo/37zU5yXg/ZRc9D8vmHdvI4ferdk20cHVcGw5rU2dtKXynvv
         rIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309028; x=1781913828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsqX8ul31omnahVYm0CzB5wNanpXhf4DkeREH1vPrD8=;
        b=AJjL3Y9QkE6wOqA9DxcsuHZAflQgT/MQeJM36GZKYzCJYY5DAZWQgkcoIo2xo+tDc3
         UwDjy4zfBU0KJJ63zEPkDZin/hkNAJijTdUbNd5CeduOGbjYeL7QA7yX8xOjchj80kLA
         1x3NrNUVSQKjEGk1fQ3l8kojMghYsNnoIp3PCfv1Og3KH/HUEOY2p7hUzGYQ63649xW5
         DDIyNkHiykrArPgxUTEVfzfztR2sc4HlZS+ElHGg6Qj02t9o2w2Znt7o/R12ByChKDsi
         wkUwu1icDEuHT3zlSHsawcbHHbmA7hktOXLpnr+WR1dBDQtBoT3RdXpTKOti/zuWrPUj
         aHdA==
X-Gm-Message-State: AOJu0Yzqams7RJJcJfHUrPnG7sY/kDhO3fJlTUouSmi9iSZmfiMF0sOu
	7/mqwjD5ba7gh6JCQUC0Hk9JTaKt78CVndu+8itAkJDSyn/hiaevGLRZoVlOKVqYmLFm9V6bAew
	3lJ34oQ==
X-Received: from pfbmt10.prod.google.com ([2002:a05:6a00:6e6a:b0:83c:61b2:176b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f8e:b0:842:6a97:52f7
 with SMTP id d2e1a72fcca58-8434ceddc63mr5238911b3a.19.1781309027449; Fri, 12
 Jun 2026 17:03:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:09 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-11-seanjc@google.com>
Subject: [PATCH v4 10/30] KVM: x86/hyperv: Eliminate an unnecessary include of
 x86.h in hyperv.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Drop an mostly unused include of x86.h from hyperv.h, and instead pull in
regs.h, which is need for at least is_guest_mode().  This eliminates the
last include of x86.h from a common x86 header, i.e. solidifies that x86.h
is the top of the pyramid.

Add a missing x86.h include in cpuid.c to avoid build breakage.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c  | 1 +
 arch/x86/kvm/hyperv.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 591d2294acd7..2698fa42cd97 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -28,6 +28,7 @@
 #include "trace.h"
 #include "pmu.h"
 #include "xen.h"
+#include "x86.h"
 
 /*
  * Unlike "struct cpuinfo_x86.x86_capability", kvm_cpu_caps doesn't need to be
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 65e89ed65349..1c8f7aaab063 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -22,7 +22,8 @@
 #define __ARCH_X86_KVM_HYPERV_H__
 
 #include <linux/kvm_host.h>
-#include "x86.h"
+
+#include "regs.h"
 
 #ifdef CONFIG_KVM_HYPERV
 
-- 
2.54.0.1136.gdb2ca164c4-goog

