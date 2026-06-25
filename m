Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B837C91B
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425105; cv=none; b=CCQ4VTFwLyQNhnZUSHDkjBlSJbQ2Bcr+zNMyn98D/v/qvkDm8+z8BIKegvAp6C/nL2aJzNJCYzUrGLR5zjnEA9nOOeYPrKJA6+FZIC8vbzwJjVnLEsCDraz7aSbjN24dJyGE3ZN6blSoR2EVwxlO+Ju5p56Ul9lKijulxktf+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425105; c=relaxed/simple;
	bh=gGrl1QnRrIHgKxMqkj52qix+onSiD5qn5e5RZzDKZ7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mnwpnErAEa4YBrxvZz56cvyphExmQOhIBJGFXe+Ih+xQ/NI2UHSKKh5AGqve+6AsM8A1sXtqOe4g7Zr6A2JMVjEiV2ghrUw6cIjSiO6RG33xANTs6dwnVl119gNtQyxJpwVlnM3yCJBWe6EalEvG2LPSLDF/2QTKIIUHm0gP7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRXK+HuT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRXK+HuT"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37e09f9c4dbso210459a91.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425100; x=1783029900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=u6No93sMWAWPDG2KkgdSV9mtTDMO1MEgDwmas8ljtKU=;
        b=qRXK+HuTeXfn9efmQPd9OIOl+PhQzlSMm/xaU7yu9zub2dQIoudQnk/IbpPoCLuZL7
         VlpD20LMAQp6HLOlFBG/Kcp8KuPTeeX68bXTHFj59wlnUSE31FkVzkr5IRDW7Lb+EkrM
         bYtQSoYuTuKfhNvv7i8NBAg4hlLkcbregHwV18nelLnMlwQ/1elSHEcTG7hzsAorEZf6
         lmBhjD2ThcjXTScO2HrKgGi5SQ39XMBk6l48x0nCj5MVw2qEPEUamNQ0gSQr+960Jima
         n/VNgmoO/CnxieTqOc2EW3PExsWQamwfB+w4joAdy27PS4FvBWa+oeByfTzmDd4N9MLQ
         xWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425100; x=1783029900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6No93sMWAWPDG2KkgdSV9mtTDMO1MEgDwmas8ljtKU=;
        b=jyipxLQFSqyONTGlRhFcmmlILnsyxOKdSADkiiEx+j2n0yJlrAkLbH1xfKS6F6v3Pp
         7YiMopLc3aarbeM20ULxeQo+tpST0wQt8GaY2D9yIZSZJFc+bFlkjxHlxDUPecG1rcfk
         AkVyfeh3TE3SalDbJ1HwWdJUcYdg8jYbmOTnS68n6IMRkjZ6aG1xOIVVwhIOGJkYKrai
         HMHpIR+3tFhogwX5R3xYL/dU39/CCNUrZ7Tjjvy29DJ0LbmM2t0AwxeYYvle+iSVFGqY
         IFG8Ty1PkM6gBfyYzaQ2bNNd/vQNmlLBzqQbc89VZrXHuAGw8TOUuyGZnDPrsFwjU76R
         NebA==
X-Gm-Message-State: AOJu0YwnRXTKPXaR30JCOR1So4lfxHtGJk7TU4SUQbNTuq88YXVD8JRI
	fnjHAHYFwlWCTt7Cbi10LToZkQhDYcsXcXVZWEKQfP7dRLa3ihaL5GItLaxgzFwzjOK+qU7ZF1O
	wAP1/bA==
X-Received: from pjbgb9.prod.google.com ([2002:a17:90b:609:b0:36b:8d3f:d147])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8e:b0:37d:f887:dc9f
 with SMTP id 98e67ed59e1d1-37dfa2860demr4563491a91.21.1782425100089; Thu, 25
 Jun 2026 15:05:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:04:47 -0700
In-Reply-To: <20260625220450.3354415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220450.3354415-7-seanjc@google.com>
Subject: [PATCH 6/9] KVM: x86: Add static asserts to document connection b/w
 TSS structs and macros
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add static asserts to sanity check the I/O permission map and TSS size
macros against tss_segment_32.  Alternatively, the macros could simply use
offsetof() and sizeof(), but having literal numbers makes it easier to
understand the bigger picture, and provides a good excuse for the sanity
checks.

Opportunistically add the necessary includes to make tss.h self sufficient.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/tss.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/tss.h b/arch/x86/kvm/tss.h
index 117bf8bec07d..55ced8975840 100644
--- a/arch/x86/kvm/tss.h
+++ b/arch/x86/kvm/tss.h
@@ -2,6 +2,10 @@
 #ifndef __TSS_SEGMENT_H
 #define __TSS_SEGMENT_H
 
+#include <linux/build_bug.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
 struct tss_segment_32 {
 	u32 prev_task_link;
 	u32 esp0;
@@ -64,4 +68,7 @@ struct tss_segment_16 {
 #define RMODE_TSS_SIZE							\
 	(TSS_BASE_SIZE + TSS_REDIRECTION_SIZE + TSS_IOPB_SIZE + 1)
 
+static_assert(offsetof(struct tss_segment_32, io_map) == TSS_IOPB_BASE_OFFSET);
+static_assert(sizeof(struct tss_segment_32) == TSS_BASE_SIZE);
+
 #endif
-- 
2.55.0.rc0.799.gd6f94ed593-goog

