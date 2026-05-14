Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D13D0BFB
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795641; cv=none; b=fJ/8U28m6yVRCrD/9I5ho3dCsvS4MpjA8RspL/5jkUSVE2izfmIoPooqQfRhqGmjFEtNkWtZjktpV4LtyGCldndJY7GGaV4QF6+tqNS3JxkjVEsht85CFHXor7Zo2HJtiqgXTu4e46bm42PMr+k10BfhNvLe7tz3HTjl2Uf8d4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795641; c=relaxed/simple;
	bh=GvpQ3pTchK+W71vrs1lzAcwN2FhY6JiRsu+aYrsO2y8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G5u9cSH5zadzDKnI9N+8aZXFJ1IrgleyOvzPlrd/BSXWpJZlAbYi2vkYp4wKxNlIacLiUDvp6w6MEMaxqTTX0U7Wa4AoCfVQD+mH1/3Ss3S5Cbdf1RNOl3NNM9bB7LY6HQZmL6uz820tN1GctgAjcLdegpHYiD5CrrDHIBE3Rjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibZKTRd8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibZKTRd8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b458add85aso88920775ad.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795639; x=1779400439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=g2qOpbXP0VS/5/XuoZ/aUTxf2CmnbBXQvkx3/ML8B9c=;
        b=ibZKTRd8Iz6ZjnMN7o+8dn41kItXMavo/kbCMI/6TrFpOWDVLSTJX7WM6dT8nhxLQK
         jpU3rQohRpdUlRUEAfkWrLqhfJYS6pOTqythHmyTFmXodGMmXrgK62tPoY09lUHxx4Bo
         Eyli2f9A6PhIg3itzs7vLo98lYquRZ/lJ8tn/AdqRkGWPDWIL8zokU0PfscYQ8s9Dc7U
         ehNqYjLvIyY1mqgaCVChAoN9hTgE0CGR/fJj6cpQ0TPDNf//TCwpUNR8DHw9ORgVs/iX
         HzwuSHPRNsLFoJ16sQD8YDKqFg5vN2o7SOkm6ErqmaDMsG/u7DJyjIt30GTBRMsrVUuU
         YjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795639; x=1779400439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2qOpbXP0VS/5/XuoZ/aUTxf2CmnbBXQvkx3/ML8B9c=;
        b=myAqdF0rwh6imVy5yDg46FIpeYKMWXNKqeq02LyijEndYp8VPn5kVh9tQSZETwE/J0
         1RCoY7EcBO41v0ocHxROv/F9iFftS5gJ9SIKFcscl8S63F0X1mRXjXcxWQBgWYliKp2J
         4Ht5ElEclvDNP5N1hAMAj+V3kVhgBFxs5I0/OHENg+GKBKxF2nxQ1lze0iMH2eVMRVKm
         FyA9P3dleQ676LY2eOcRs/jeVx+9zdnMBIgXP1/4I+pdtmEenHuIV0Rg9y4Gu8eEwz/y
         oH92Pq3EPYYoKfDX4VZmiiJH3szIR7PGZkvdFdyhC9sl0YGG6c6mzxk9YzX4kXBOEw89
         OJXg==
X-Forwarded-Encrypted: i=1; AFNElJ/i65sXFHKuU/+LrAPhYmPJ0y7y4AVbsldDL1ZkDUJywsIeVImBb7oDiSNYPqnHcV7Bm24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ+u6WPUJjyNSWau1T30p5HLMGN0nIEg/SG/74qNuR37UNTK8I
	Ks2pwUg4A2tf5ULQwdYLiJ8OD34UUe0per60uAaJP6zu2xnU6W4s6i1awIJw80BmNz9lXq3scUJ
	TM+xUpQ==
X-Received: from pldt9.prod.google.com ([2002:a17:903:40c9:b0:2b4:62bc:c2a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ae7:b0:2b2:49a7:a5bc
 with SMTP id d9443c01a7336-2bd7e9e5458mr11350815ad.39.1778795639070; Thu, 14
 May 2026 14:53:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:42 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-3-seanjc@google.com>
Subject: [PATCH v2 02/15] KVM: x86/xen: Bug the VM if 32-bit KVM observes a
 64-bit mode hypercall
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

Bug the VM if 32-bit KVM attempts to handle a 64-bit hypercall, primarily
so that a future change to set "input" in mode-specific code doesn't
trigger a false positive warn=>error:

  arch/x86/kvm/xen.c:1687:6: error: variable 'input' is used uninitialized
                                    whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
   1687 |         if (!longmode) {
        |             ^~~~~~~~~
  arch/x86/kvm/xen.c:1708:31: note: uninitialized use occurs here
   1708 |         trace_kvm_xen_hypercall(cpl, input, params[0], params[1], params[2],
        |                                      ^~~~~
  x86/kvm/xen.c:1687:2: note: remove the 'if' if its condition is always true
   1687 |         if (!longmode) {
        |         ^~~~~~~~~~~~~~
  arch/x86/kvm/xen.c:1677:11: note: initialize the variable 'input' to silence this warning
   1677 |         u64 input, params[6], r = -ENOSYS;
        |                  ^
  1 error generated.

Note, params[] also has the same flaw, but -Wsometimes-uninitialized
doesn't seem to be enforced for arrays, presumably because it's difficult
to avoid false positives on specific entries.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 91fd3673c09a..6d9be74bb673 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1694,16 +1694,19 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 		params[4] = (u32)kvm_rdi_read(vcpu);
 		params[5] = (u32)kvm_rbp_read(vcpu);
 	}
-#ifdef CONFIG_X86_64
 	else {
+#ifdef CONFIG_X86_64
 		params[0] = (u64)kvm_rdi_read(vcpu);
 		params[1] = (u64)kvm_rsi_read(vcpu);
 		params[2] = (u64)kvm_rdx_read(vcpu);
 		params[3] = (u64)kvm_r10_read(vcpu);
 		params[4] = (u64)kvm_r8_read(vcpu);
 		params[5] = (u64)kvm_r9_read(vcpu);
-	}
+#else
+		KVM_BUG_ON(1, vcpu->kvm);
+		return -EIO;
 #endif
+	}
 	cpl = kvm_x86_call(get_cpl)(vcpu);
 	trace_kvm_xen_hypercall(cpl, input, params[0], params[1], params[2],
 				params[3], params[4], params[5]);
-- 
2.54.0.563.g4f69b47b94-goog

