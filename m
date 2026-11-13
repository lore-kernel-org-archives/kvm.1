Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589448;
	b=m7Tw76dC4ZdM4MoeFTfXTxXy9hF/n9AGEBlHij6G37kK/4y8lq34DMEPRe+mRAOWNuXz
	 WtihoKF40PfEfQ0EvZ+nQeOMvGWWv+ybPxWS6hMm0m6BC1PBBthc8dQibsXdHylCvGiqw
	 AD2ZEEpnzt2ROH+XVw6GTwkhfxahLfG1tI5VQp9bZUgKF6OnOcX3zNdiuTFTfAthMIvsK
	 FYC8qDM7XY8oYZHDA5TG1P26/M567Nhcd3cToirp0AIBCm+W9oyykPfU2UzDgfE8cjytJ
	 aVufSB+46qej9YjC42ZBVbGUnUWqk6BRdVK+7hkdzJSNLnBCSQYiMBE3WCkHZcvEC/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kMtd5t/mzUd6oc3wbreBiNHvcldQ9qvyBkJYFQrEOd4=;
	b=jAWgrr95+/J/PhuAbNy+W1kt6laeXBL6Sp+HLrnyIEBaOMuhVzsBnV1y8ffQS3JAA1ps
	 +orYM7N7xMTIk/qZ8zNbVZICHMk0Erq+V3a4AOaBitPhTVaGJ6aa659lh7t4h6YEn2T3r
	 SdMZCKWFk8CEJn/oq+f4KHwLMW3B/dSYzDX2ehdw2eYjOC+oq1IThpLrxrHAGbp9hHIBQ
	 aK1dxEmlL6eSHxg3CzQJ/DQNdS6CgkGVbaNxG4xjQOgwc8fmPUNUKsLT7lHaNiy5SOZBJ
	 ppoIWljbtVgM5nV3Nb84W4BRc1ynwAL97ni9G6ipHF3lm2EZqxVV4GH5vVzknh7ErXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cnkXZsMc;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF0606A8A3
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 17:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97EF0606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cnkXZsMc
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b167bc8e16so1010068a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794589448; x=1795194248; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kMtd5t/mzUd6oc3wbreBiNHvcldQ9qvyBkJYFQrEOd4=;
        b=cnkXZsMcCKZzrJUFPCZxin22bdj9NtVESK6h+3n3XsDs3JCT75N1kZr86vA45z+0KN
         0enEvgU3440kMxfNz/eI3tlD6K0jy2MLKV4LzhmZ7kcjCX1JbAmM9WEwKdXuka2sX2pM
         9FEMTag87WSDb8l7BCJD4RnaIBKdaMJX+Yuhh1PKjl8+yLNBTfJMGG54kNEW7WbKyzjG
         9svf74cM3vJCAs7c9sgs9+15yAQiv/bgDlS7lSd1HeW4r2XmIwyMaDkiQcd2QPta8HDZ
         Vl6Yxt9gjb/C09q2E0Vk+kXy58GZL/BbdBfKOsB+Pw93Lsf+AnS78sFiFp5CxmPqQttE
         CqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589448; x=1795194248;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kMtd5t/mzUd6oc3wbreBiNHvcldQ9qvyBkJYFQrEOd4=;
        b=HZ+IgFwspdD/5RM3b/ByqPG89soOiMd3i6LMRVOa2xypBKU/FOnIRQSolu657CbYbE
         sZh0iElI0i3QOpnJW1o5HlEDqx+58C6cqFS2IVKvt3+E7ErEe0U1/mfDuz3gnqIp9ot4
         niqGnZcWFzhk+7jcUzCOtn71LwEOiXHTiKGO7brBvR1d+deOlS2rglrGw64d7kS4NAei
         pGSekjVnP1Kk/dUifeKa6B18wXNhPPpViFBilWANYsZEInA5QmMHgvULB9/R7VIqgk+C
         /wbHNIixxIYImnW+Ok/W9LMy78JGGvnWouFmpZeApH+9vgaGhk1iJ2uERE7DfCEkN4Fx
         XFtw==
X-Gm-Message-State: APuU4Z8dgyaCptDFazWAZuUDbr+XRCmjD2t6qUl4PcbS4yBEbv84ElzE
	tzrli9iN2/4QQUTPAbmDj/P1ul4PpEJPfqE+H4uNlW/Sn2BQTkN4+XArxuLugK0oalnqbjlilDL
	c/eVfww==
X-Received: from pjgp4.prod.google.com ([2002:a17:90a:4284:b0:3b1:8637:2aa9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:530d:b0:3ad:25f6:1dd0
 with SMTP id 98e67ed59e1d1-3b1b09f60d2mr3031796a91.11.1794589447758; Fri, 13
 Nov 2026 09:04:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Nov 2026 09:04:05 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113170405.473841-1-seanjc@google.com>
Subject: [PATCH] KVM: nSVM: Leave nested if loading CR3 fails at the end of KVM_SET_NESTED_STATE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Force the vCPU out of L2 if loading CR3 load at the end of setting nested
state fails, otherwise KVM will leave the vCPU in a half-baked state, e.g.
with L1's page walker, and if nested NPT is disabled, L1's PGD as well.

Fixes: e1779c2714c3 ("KVM: x86: nSVM: fix potential NULL derefernce on nested migration")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-210535@kernel.org
Closes: https://lore.kernel.org/all/sashiko-outbox-205939@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 07554089ec05..4b1cdc7798bb 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2114,8 +2114,10 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 */
 	ret = nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
 				  nested_npt_enabled(svm), false);
-	if (ret)
+	if (ret) {
+		svm_leave_nested(vcpu);
 		goto out_free;
+	}
 
 	svm->nested.force_msr_bitmap_recalc = true;
 

base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.56.1.703.gf848ed807c-goog

