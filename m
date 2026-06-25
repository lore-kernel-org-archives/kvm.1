Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68723379990
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425098; cv=none; b=FEEdrZSrJ5YdHcc6WcLVNY1fSQTwpOVn+liQ8UA79ntHlyQ/8AjhLIgxfohVP0bnQAHJ64VOhijl0tcLWAYR+dNLjmQK5aAVQhKEe2YUBqyC9avtEv2mqtSgm6jVC3/RSJE3cER597YqT/5mhTBqpg+KiQ3EznToyVaMX7X6oC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425098; c=relaxed/simple;
	bh=/cBorCarlxDR97YiEGmq4dtsm1PpKjyia8yStQo5i3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YFWpn9TXSvw8+ZCmC6Qfiysq2t6vxs/oVrqV9TZmAnzGNhyqVfNNwejCwCgwmISDnBII3rMWkrVVmjGYaia9cH/0uN/L1Iqs6xRUF7ui+HkYxQquoqll+6s23GSpXvU6Non54wfEOUFF0NeTKWifk71MRfuaB2OCF6yWjyisrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwC/eL7t; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwC/eL7t"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423f3e4728so119289b3a.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425097; x=1783029897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WEw3Rm0Xhw6WdW5PTXYk51nRebahdmwmFrTIU4C+35g=;
        b=fwC/eL7tR57IjhAic625OjUKpXNVZFK1VefBYDrRdgCX2zKpHEjiVYnowAeXMbLYcf
         GHtSgXJVzYmWhuq3sPfHvr38n+94qfsV5jLlTIp5vEKcwmv0Qy6ygQGFthFWL6r8LO+d
         zvVFmryiLUeKofbfAFHc0wH5DUzXCjGYs+zkfHKfImEcIc0N0X0C5kL+koP8/7wIBh6l
         CuVXzlRfXSPyuRow7FRE0N6/w0YSBYbOwBJbmdS/4EMEJkCCoOk4fMVgAGjy9YSVnZoA
         hckIHwnUlQV2mxthSldxLmDlJYJ9x0f9JMy5CzGCT5xg6EGj986vVg3wAclzw5THPqnb
         YLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425097; x=1783029897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEw3Rm0Xhw6WdW5PTXYk51nRebahdmwmFrTIU4C+35g=;
        b=GSU6DDUrDGeHn/Keo5bTWesvn6RA2zObgNHkb1o4rO434CdKv8W8Pa51HgGXTraJKw
         zD8gWpQmNiSo7XurRs/Ty7YLT6mN9qHo9daRjiPAv7UV7umvkmissPjIKEs4ZXSvA177
         R7mxGXgt+D4woc6gtcrgRH1+yI7PW/n6DQXAQ7FWgah69S524lu1rKsAeZCFHsG+dNkz
         kv8REa2aFVJRz5Nww+WAB2ZSV64vU8i6MP4RQEDhGQ3QIeVfAiYBJFizWCkVRcDVmWss
         5/LlacI9yYKiRDUowBa/gzXWsjcKjG4UMFuQxKgK+XW+GhOQO9Ulubbn9b77fbO7tKaY
         sQ2A==
X-Gm-Message-State: AOJu0YxfOA7ir2hhoitui9YapSnIakQYwqDiD4rHeCQTZxLbuX60zNsg
	Hi8OpLxbWtdeWIfzygm7z/mGkWehOgD1/PPpM/izew31yoL042loOaupVJcdUYVYB2u4HWwST4n
	jx4vd2g==
X-Received: from pgjd1.prod.google.com ([2002:a63:d641:0:b0:c92:864:4328])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3991:b0:3a0:c325:aa11
 with SMTP id adf61e73a8af0-3bd4af208damr5489299637.34.1782425096555; Thu, 25
 Jun 2026 15:04:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:04:44 -0700
In-Reply-To: <20260625220450.3354415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220450.3354415-4-seanjc@google.com>
Subject: [PATCH 3/9] KVM: x86: Pluralize the macro guard name for msrs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add an 'S' to msrs.h's macro guard so that both the file and guard names
are plural.

No functional change intended.

Fixes: 7a2683080158 ("KVM: x86: Move the bulk of MSR specific code from x86.c to msrs.{c,h}")
Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
Closes: https://lore.kernel.org/all/ead7d7fd-aa4e-4c18-b399-90fb448e0af6@linux.intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/msrs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index b698983e37fb..9c5c6b33e58f 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ARCH_X86_KVM_MSR_H
-#define ARCH_X86_KVM_MSR_H
+#ifndef ARCH_X86_KVM_MSRS_H
+#define ARCH_X86_KVM_MSRS_H
 
 #include <linux/kvm_host.h>
 #include <linux/user-return-notifier.h>
-- 
2.55.0.rc0.799.gd6f94ed593-goog

