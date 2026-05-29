Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A7450909
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093390; cv=none; b=nalr08HzgfhqlT5AIKIV3fwMzmSOMlPBwvP51SIFx2VeoipAApY29sPkYsPN+PTgvA2Ve8pusq0c7+VQTllR/rgQpjIc+88fMiEBWIE8qJ0hNnei/HLmhNsVfPGR87nC2lvUBCP7qF0pzkZHCfLAgskJ5unp4CxEZd67iYsyih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093390; c=relaxed/simple;
	bh=2QUq4Zntx/cN1Mlgi5UbFZ2Zk6wGbdYV96fOq/ek52U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sOLT0oPHlNnM05HUqIH3cxC1gaHdOFWBrXc2t7Qnmia8g+gtKX5HPYR84KrucgP2HDDiMdowqLmUzUkAm59AD21D+4B2tb1NqzgSqlofJZtTl724HFGP6KH12qnBfxNt7HcOPzgMN/83Z7KxvqXFSz0qTqD5C1CBtFd5AqB+hnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLVI+PNc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLVI+PNc"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422ca754d8so25623b3a.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093389; x=1780698189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cOprH2r2W4OfoUuNhxoH+2jlBeBKL8+G7nnMuVk5ujk=;
        b=pLVI+PNcj+/oJ1AC7B9DHSlHIxRdpuLve2yQoBHKCqB31uXrbJWek7nm0dvEplNdoF
         DuspBxB/ecUfmVPXAua1r8e20riG0ptA7upprXGzcrxrY2GGQx6BVCKcbYKRYWp8SZfl
         Z0M7RkzIzg9dEEhFUut1xEEOlGX5llOASJbBCcAMEIShdaiasURvPv/7MJ4IPLm8cnJc
         2pvkUf7yVlhtWp0ZCANRwTfiCCjLGSjTfNWltB+AVKgWFIwoFl3LDvEvC80NS4OtJ1T2
         dBkUeRPjdTXUMeuAO1kGjs8+NTeRCsRRFeuecGNqSApfUWI5kM4neZWiM6MTveLThiMM
         8AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093389; x=1780698189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOprH2r2W4OfoUuNhxoH+2jlBeBKL8+G7nnMuVk5ujk=;
        b=s3XbM6fgLaK0J8z2QsH7RWtZrGEyPul6RnBtLUJ3tgiven9BOyqi8HN2mJlkXOUypt
         6AUG+BpfAT24TJxZa6On+R+bCrkR04jmzEmpDSKVVGHDDGHp/Akd1XsEdKDcCe1E9FCk
         y7QPOBBA9oja0q2j7a77cZU25zHfFb0JqKktKSfFKgwGCzSeFIExw1lKH2G9oXrXzwtN
         a++ZPoXhZiYnVY7kTeILJ4VfxgPagk5IpSWWb0kTYIC8PMKLzSfGhq9wpt3Y2bcJ4HKN
         cORq74P3u0TEm5yBaXr7dnYUEERBvI1AdYn1kJRWixC2nsyqQTEJVcnAboKLtUQtcRFF
         J9cg==
X-Gm-Message-State: AOJu0Yx7wZ8ATl+IWrfT8DOCzKEmOCIJhKN1ngMo2OfD10bU3c6UHZC5
	3U4hsjtbn8Lj4ebvmdKH7XWQUNlX0IIPaTOMeVPKdfN7h6kZmh5VzUnO88mbo6uCFxtIGgOlado
	W8xOTFw==
X-Received: from pfbjs21.prod.google.com ([2002:a05:6a00:9195:b0:82f:96ee:b9ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4291:b0:835:4291:6975
 with SMTP id d2e1a72fcca58-842255c48camr1437165b3a.39.1780093388651; Fri, 29
 May 2026 15:23:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:05 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-23-seanjc@google.com>
Subject: [PATCH v3 22/40] KVM: x86/hyperv: Eliminate an unnecessary include of
 x86.h in hyperv.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Drop an mostly unused include of x86.h from hyperv.h, and instead pull in
regs.h, which is need for at least is_guest_mode().  This eliminates the
last include of x86.h from a common x86 header, i.e. solidifies that x86.h
is the top of the pyramid.

Add a missing x86.h include in cpuid.c to avoid build breakage.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c  | 1 +
 arch/x86/kvm/hyperv.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index fd3b02575cd0..db8be9173bd0 100644
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
2.54.0.823.g6e5bcc1fc9-goog

