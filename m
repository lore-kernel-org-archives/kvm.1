Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0941A4F1
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764398; cv=none; b=MW9XfvWwN8E1NG8smgvsont4uToVJIVx6Uq8ErkF4S0ip2ohxujCbutOe7ZHKIm9A8vLc0aUJe9AGASZ4TO4B2J99rUxWZc1LoWL7+lJlyP5KW+yaoGII3Mx81o/oqZyrUzMfrBbjLHZ3f73cKYnGM5NA/Mq6/5EesdDj2lzUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764398; c=relaxed/simple;
	bh=cKAhG59+Iq84FY0AbDSTajeiuMFZn2chwTWn175Vj/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JGlwt64dWB+ocoU4V/1sjHvsIq30+tswzTtFIjknzHkt7bzTAM56mEDEA4j8TIOymUtCxc8iZWqu8vagHlZSBk0ZLm9063TrvF24syg14a1ua5UmGqcvqzJGPQVM0H7GQDpHqOgGl7T78hOISHWRmKKjqlETwZXQ7H9JwoQHglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PiAX40uW; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiAX40uW"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8486c3411c8so1624064b3a.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787764373; x=1788369173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dhx91tSB6ociAKcQKQZdcjUCezd51Vy1x/2McQZk6Qc=;
        b=PiAX40uW4NQBCMnGivNybQdTm5BvwREYNPVXbIRgoGitLTQbeMBAFqcxVDkes5Y0nA
         bXSLU8hrIGWvdxIH4YMNkz/sBFoHsL0FehbjSJsUamAZGfwBN8QI8n2UuJOaYZijFODi
         DNt6GQeNYWyRemjZKG/EP3D9aCuyvZOPQmw/qQc0ppL1cDOw7nhP/d+U9bP8acnPC4n+
         kDy+Q0VeFY3VJZ2vJIP8HFLBkWMklATjA60QDzJiAEnCPkW03RtfRjxeSgY8STTEG2Lo
         6e+aruHxACNBkMm1wlTR7/nUZZ8q/Tpux27tsZpXH+tnWRvWaDkPNpD9ucZrE9qLeO5c
         2hAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764373; x=1788369173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dhx91tSB6ociAKcQKQZdcjUCezd51Vy1x/2McQZk6Qc=;
        b=dkjBej2KXIUEkFReDpggvRBI5eUhCx2l2qvkUPEb/lsqawbdnUMLetIW5vqsnNm9cv
         2IlPrGprhZUA25aRmLIZvQXI2o2nQFacl/39G/v6fFPdAq2c4pERZx5caGYM4Qdu6WM0
         JNERxtEWl7NafEtXn6v0jEv1KqfwwUGOfhVjjP2c2hivcJJ/qVaLzay7clejtYIXidqG
         8cNftDlP8NSX4yy2UHvkDholTY1DRjhAhbqMhw0CyIZpoCQ+c33JkG+fWZpLqXJ8vcMX
         XOj518GopYKrs9SAtdOirmEch4jN9WWWsgzgmk6fKbWOHeEGolqNRlr8/mOAXrK9GLqM
         sAhA==
X-Gm-Message-State: AFuF++my8SwLxW/nx/A7qRsV3dI8yVgls6KcKC4vHbhmXpTqsccKKaH0
	vIGsmRX7adtuPm3+G1UPmQ7j3zoXVupIEBUNm/3I6z1uFsG1qMniLUJk+289TaM3x2h+GMNV8pE
	W1/a9rQ==
X-Received: from pfaz6.prod.google.com ([2002:aa7:91c6:0:b0:852:3a88:2817])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4289:b0:83e:b443:965e
 with SMTP id d2e1a72fcca58-85371ba8271mr16961098b3a.3.1787764372164; Wed, 26
 Aug 2026 10:12:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 10:12:41 -0700
In-Reply-To: <20260826171246.777729-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826171246.777729-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826171246.777729-4-seanjc@google.com>
Subject: [PATCH v2 3/8] KVM: VMX: Disallowing using to_vmx() in common VT code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
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
index 684b87692864..b1069a8e30a7 100644
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
2.55.0.887.g758fc8c411-goog

