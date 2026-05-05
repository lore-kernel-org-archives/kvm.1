Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B735F5F0
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777945332; cv=none; b=dlBWyc7QPfCXrUQETctzwcJmJjxPq4I7Gt+itBUjplButY/qbf3G2YPwh6Dgv597Z4GmHhoA3nTmXiqzvPE1DyHP/XvXDET6rPT0gQqNA1YHyhN+S6OuUJhUy4g/r1sjkxEJ0BUxkVO5U/FV07rN8EyZVst/a4W7M1G985ZF+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777945332; c=relaxed/simple;
	bh=hOIfGjJBO7dWM3vNqgBUpAs2WEZ56NKlOdU2v5YYCV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sm451y5CcRcMOGzNXcZjPvPbS4lEMR6fZG4D1mMEIgj0Nciw2ImInI5/1vSqdBc684rzBBi4X/YQZj1Q3yf5aSpse1iC/Uy7oqgRH9Xvmg0OjFWzuZaPDxE7dIYEZdNBxzweT/P7p1PJAEUD6rg6U1LTg9QAFyuqoR0aFp9+oZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fhd01Vjh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhd01Vjh"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2e91add2aso45559705ad.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 18:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777945330; x=1778550130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0jG925w+PwOWFxE6KsVd//3hHwhv3NZ8wik32C8/2B8=;
        b=fhd01VjhZXP//QcxcSHM45BKFjxeWcKzQyXjpLAl0dvwWQ59jjfzTudGtMy3FTkUKr
         86XWTZrwXym4a/stHjySGd1tpLKC3yqWKCWBB1vGxG8s9H2M8nJbcfUmEfoHnEF0X3MD
         9p6b8n76ffuv9ADnEVDB9cslf+n2dLpjcIOSmpAYwXDE3Qz4uQKUeoyZffVilRu0v9aG
         QFzu+mq+ydrvU3/nBDaK7qudSwb3SO2yNFEVu3ifSgcx6PSeLeGmvafT4QGlYgrbGim4
         irnPkl798+aBSrTCY4yCSCJ2YWLu86/gU5jskYYR8ye5+KhVZ6zYVW+4XBojwqQyEdU2
         ZmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777945330; x=1778550130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jG925w+PwOWFxE6KsVd//3hHwhv3NZ8wik32C8/2B8=;
        b=CbIWULYlr3oimFpFq34/s1bLBdhaflxjE3X8jYiMS02w1V/pCQzF8yDPAvAwWR6MY9
         GseZdKURnxsJ1weFNtL+x7MJsNedzzdqQL09v5rjYDmA4M+fkQqzJmbX31Fy1dKkN7M5
         C2Xlzj7Htlnd2QfIaZoJ1D1kVvRNEGPFrnzrIJdwa5X9rnlOkJRISuMKz6HDks3z6f9H
         6TANNGPEq2CLLkqMfWFT74L95u1RsSOl5/grf760SMOGb2sTbqMypYHLR3OSgy9ml9mI
         glfR2OOnT3EdGkV5teZd/b3sQB3ERrNTFXSm7XaMGSYB3uAiDjmym141IoZkE5WEVv25
         6fRw==
X-Forwarded-Encrypted: i=1; AFNElJ8mTi1b51rkgAnDInf+oSic4+61z28Dnv5mNUH74GvBvtlTulIbSrbytwRxfLPNDayN1wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIcZ5LtBv6y0Rwt3MsKdWL1JnFaNzBOWh8VvUqwaRUqrxGsFJ
	9p6oUu6DJU3DqkvVR1byC8fSBihTxa56LBstAM8mxB+6zrRF8dMa7GYuRZ/8vyxpr22h7Tr72Cl
	Q/WpJCS9JYnVwlKR9LMcpLg==
X-Received: from plbku15.prod.google.com ([2002:a17:903:288f:b0:2ba:3222:5f0])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ca09:b0:2ae:826f:2c50 with SMTP id d9443c01a7336-2b9f25686f0mr84308055ad.12.1777945329439;
 Mon, 04 May 2026 18:42:09 -0700 (PDT)
Date: Tue,  5 May 2026 01:41:18 +0000
In-Reply-To: <20260505014118.3783476-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505014118.3783476-1-vannapurve@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505014118.3783476-3-vannapurve@google.com>
Subject: [PATCH 2/2] KVM: TDX: Disable pmu virtualization for TDX VMs
From: FirstName LastName <vannapurve@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com
Cc: rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Vishal Annapurve <vannapurve@google.com>

TDX module virtualizes PMU for TDX VMs[1]. Host has following
toggles to control the PMU functionality exposed to TDX VMs:
1) Configure TD_PARAMS to allow guests to use performance monitoring.
2) Restrict the TD to a subset of the PEBS counters if supported.
3) Limit the TD to setup a certain perfmon events using basic/enhanced
   event filtering.

KVM will need to be enlightened to support these toggles. Explicitly
disable PMU virtualization for TDX VMs by default until such a support lands.

[1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1e47c194af53..01498c25942d 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -638,6 +638,12 @@ int tdx_vm_init(struct kvm *kvm)
 	kvm->arch.has_private_mem = true;
 	kvm->arch.disabled_quirks |= KVM_X86_QUIRK_IGNORE_GUEST_PAT;
 
+	/*
+	 * PMU support is provide by the TDX-Module (if enabled for the VM).
+	 * From KVM's perspective, the VM doesn't have a virtual PMU.
+	 */
+	kvm->arch.enable_pmu = false;
+
 	/*
 	 * Because guest TD is protected, VMM can't parse the instruction in TD.
 	 * Instead, guest uses MMIO hypercall.  For unmodified device driver,
-- 
2.54.0.545.g6539524ca2-goog

