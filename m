Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337D3F2102
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186544; cv=none; b=ixNeWuGVziOZ8qZYHi0kmFec4qlwUYx7EZ8AIWmyaeZu1bcShoHe2fObMf1fzv71V4BRhceBCPw1/+KJxRRlAK5JOoMDVFJQngTk/DFM9yHNKuV9L51F5UL4Bk75xC0xu38Ch/r2qPmwgYc6x1Ex78LALyJXvCzqvb7zltZc6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186544; c=relaxed/simple;
	bh=s5PHNN6ivra7JTqKpFtmgQ4VhrnCt+DVMv2IumBMKZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nd6WMrX6PLKT95WZzezm2SKoAyw+5gY58wr2vm+aUm4mIX9PLcciyNac4caiWJG2LvdWUqIO1NUR2o/yEnQ5Rz/Fv39eTx+L7m7M9EKv9JWZ7k9DMZVnFDv9uQJttZlLGitjvNf5BTPJFPNPdDmNvDgAPoIj1eZXRVMX8E4h0Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MeMrgjih; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MeMrgjih"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae48a21d12so71538785ad.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186540; x=1773791340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=v+UG8GmpftbH/hU/LDZZ4z/cbiXMAWddtqqIMRz+5yA=;
        b=MeMrgjihuw22a+0ulO/nBGiAgTcFplvjDfNWUI40kLa07iJK+J55UXNSJFbiLonhrW
         yR+FVR2T82MwIXIIRHNb31ULw56ZWQ9tK53d0zTLWOe5Y06KYKUNBcBc0N3YrSOjvSHK
         xEFt5zbHPOKRDZjPZGsT5jM0q9LX4WQo6Q1Nf3HtSt64ixkCuzbPlRgF2IWHDdj3vLqI
         4r5dMkz9ND1zgOxg3Qt0svUVw0x1RXMuBjYDRMK3/YmpVuicMwnMIGCnWw8AXS8/QmZ9
         yP9Mm7Fia99h+HbdOh00KhW48DCyOQy5MWXRcf5yBNrgUgXGEbBF0HGCngD1KcCMih/Y
         ouTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186540; x=1773791340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+UG8GmpftbH/hU/LDZZ4z/cbiXMAWddtqqIMRz+5yA=;
        b=mijV4yUl8NX5tIl+7ENmDl9QfTem10YuIy7himspZKG7KN63cP9eA8rDbLHzpu/OFh
         5tVc/nZRj2V6V7/4sY2G1cfTWX9lPQ7wNjWfSyfNiEPTSJJblSvqZXfdoFtIiYwWZS8c
         KXpoTVDC3oy8mNTtO7Ld5eoyJiJc4mwQDadb52D+qSDe0lOLwvbfTJOk4crI+IQTlN3F
         +mQ09QRBUawLhLytUJ9gCKKnmrcazu57f92clIKg+gOhA/BVcu0/rhFmoDExuUxN5by6
         AFSKXvNjGnZVZ58yWcc1zsALtAEzH2wyhjPv/oaIM/NeaJ85+aslU74qKdrGJ5q7KSym
         xXjg==
X-Gm-Message-State: AOJu0YwWS3ElM5ckxL2BwbeRixrLnx1u6Hp5c6Kmff+BGn+bPKK+EDsC
	8iXeQ+94Q3gaJQ0J2MYftGUviI295FoXgmorIxlKZHjyESMp/ALG0cm8LbpbTXyQd1VDtV1xNWJ
	9UZkQ7g==
X-Received: from pldy4.prod.google.com ([2002:a17:902:cac4:b0:2ae:3a49:7600])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b4b:b0:2ae:5eab:1338
 with SMTP id d9443c01a7336-2aeae795720mr5642965ad.8.1773186539824; Tue, 10
 Mar 2026 16:48:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:22 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-15-seanjc@google.com>
Subject: [PATCH 14/21] KVM: SEV: Document that checking for SEV+ guests when
 reclaiming memory is "safe"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Document that the check for an SEV+ guest when reclaiming guest memory is
safe even though kvm->lock isn't held.  This will allow asserting that
kvm->lock is held in the SEV accessors, without triggering false positives
on the "safe" cases.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 9a907bc057d0..7bb9318f0703 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3296,8 +3296,14 @@ void sev_guest_memory_reclaimed(struct kvm *kvm)
 	 * With SNP+gmem, private/encrypted memory is unreachable via the
 	 * hva-based mmu notifiers, i.e. these events are explicitly scoped to
 	 * shared pages, where there's no need to flush caches.
+	 *
+	 * Checking for SEV+ outside of kvm->lock is safe as __sev_guest_init()
+	 * can only be done before vCPUs are created, caches can be incoherent
+	 * if and only if a vCPU was run, and either this task will see the VM
+	 * as being SEV+ or the vCPU won't be to access the memory (because of
+	 * the in-progress invalidation).
 	 */
-	if (!sev_guest(kvm) || sev_snp_guest(kvm))
+	if (!____sev_guest(kvm) || ____sev_snp_guest(kvm))
 		return;
 
 	sev_writeback_caches(kvm);
-- 
2.53.0.473.g4a7958ca14-goog

