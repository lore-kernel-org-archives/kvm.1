Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40713CFF6E
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186527; cv=none; b=LK0EkCDiUvIzwjVol8d+JAhiuU/p0rou7npJEn3nlR38zEYEYT4Yt7ezhWNU93Ezwos3cn81i7hpv5m1X5VAAaL7x6FnmEMliNk63maNvwlK6HdWvXcePWoyg5c47/o2/VY80iaWldqZIXyC3az59X8dZAMuWVZNcZlUjTmUuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186527; c=relaxed/simple;
	bh=np7yKuIzh2g5DJEKgMDoaxNWOTXyqLqKAdcesC7LCQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U3/yIbBp9QKDsBC4PeHlkkuX31YRUr4+Aq0vpNJt4U/3coSuoUaphUQeMa4wc+qFG3NYtGS1J6OH98GTuXkMmAKnKM1ceMI7ahVtSnminJkzrGtQuuqwlIaILhbZGioMJrtzIgLJUUpOk4zLR9WDhRZTjCYCF9AEr9ag/NuyYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3eJA4Nxv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3eJA4Nxv"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c738f71723aso3401810a12.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186526; x=1773791326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FpG980lWE241naOxLLMlz2TI3FNz63t0Ji/1Q07E1+Y=;
        b=3eJA4NxvXDWHYwTFu6EIrKJRwPwBOVrg2vfZNRifLHiwDjHbAKwFvZxJtcDa/gF9P2
         tVc+TeKI5xd0fAnb/F4qge9LIkP0IEkdQCJ6G/v75xwhh2sOIUn84ta3f4qVPiRSEu+s
         c88lPUTmFR9W3usCkV2zvNtwUMnODbYl/BKc885vLs2faNYB9aXXFeKM96x3mUtkx16w
         ghNgswh/Gef5SKdAnVZVtXTDXmUBFaD/kZAoCCtvThBduKsCR7tTvsXZ2Bg4EXdDf00F
         Usa0UFL3UzvNUfYc+EIjBmm9xpEigbxd83AFaVMmRARBpDz3asCAnkst/ocHAQdmc/c1
         HMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186526; x=1773791326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpG980lWE241naOxLLMlz2TI3FNz63t0Ji/1Q07E1+Y=;
        b=eiL/q44LleAYiPswx8FVEQiz/x8uTaYUFbcsCCGozzLQjkobScB4LVDoPzKO8gmqlH
         W+9sGz8FtbXTgBtHh+XGnFiG54S0O802DudVaontfZ5f98BtjNEQKxM3Q2UTaBbn0uEf
         wPM/22jAzMR0oLtRi4KVIhQf9yY7YT1Ksq4gtlSvLCDFlXe3jaa689j3Bj+zkMdQXLU4
         Vwp3okfDfGO9cZhZe9AqN46ZnG6Yd2L+FUmJFk6bQzb635sMqNRI+orec80oVpldOXDH
         bbha4at6fThdHbY0wV76jt3vAR+++xizQDkgh05cr68TnWKqB50mhbtfKq5lPIBsJUFC
         tpOA==
X-Gm-Message-State: AOJu0Yy+ZYi1xG9MFNr7IGGvKX+NbhEISqop6OjDVSi5voeWETwnQNnP
	+m4aVxC1r3vYz+/OKnZOxf03olgDD9j99yx8yfmyf2k1mBCqCThTKXF3CftejXx2wcyBd0R7NiQ
	oDzeT5Q==
X-Received: from pgc27.prod.google.com ([2002:a05:6a02:2f9b:b0:c65:e8e7:d481])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9090:b0:394:6208:6623
 with SMTP id adf61e73a8af0-398c5f3bf2emr387226637.27.1773186525978; Tue, 10
 Mar 2026 16:48:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:14 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-7-seanjc@google.com>
Subject: [PATCH 06/21] KVM: SEV: Lock all vCPUs for the duration of SEV-ES
 VMSA synchronization
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Lock and unlock all vCPUs in a single batch when synchronizing SEV-ES VMSAs
during launch finish, partly to dedup the code by a tiny amount, but mostly
so that sev_launch_update_vmsa() uses the same logic/flow as all other SEV
ioctls that lock all vCPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c10c71608208..1bdcc5bef7c3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1035,19 +1035,18 @@ static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (kvm_is_vcpu_creation_in_progress(kvm))
 		return -EBUSY;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		ret = mutex_lock_killable(&vcpu->mutex);
-		if (ret)
-			return ret;
+	ret = kvm_lock_all_vcpus(kvm);
+	if (ret)
+		return ret;
 
+	kvm_for_each_vcpu(i, vcpu, kvm) {
 		ret = __sev_launch_update_vmsa(kvm, vcpu, &argp->error);
-
-		mutex_unlock(&vcpu->mutex);
 		if (ret)
-			return ret;
+			break;
 	}
 
-	return 0;
+	kvm_unlock_all_vcpus(kvm);
+	return ret;
 }
 
 static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
-- 
2.53.0.473.g4a7958ca14-goog

