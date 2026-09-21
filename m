Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753410F2
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012700; cv=none; b=tS4dcya5S3lNrCIAZ5CP/BIiu+ycKVfNPFw9AcnKhwTJsYntzn9wv6Y6SWgf4DqKXZetQGYZhARn5e8L8zv+7yoU32bFRnBsJdsSx4hlxRU4XgCd8obnWRVrEWzKUWBF6+bgy8CAgBtKwZY9NVjRXCnoZCwskkW5jh3hk+m3bKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012700; c=relaxed/simple;
	bh=cYA9lzFyBuFHQr7HU3AfB1/Agrqq855in7GcwhtndPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S+oSEjvpJVZwlTrFpXHtiljldHT9XD2WasA0E5Ie9R6iLizmKyop2aAc9gJuf0NMzLq+NhasMRhP/5W8dtAWEOckUPiUsI+Mj4xydGdxI2Z8oGYu0rfpbUMOQKMcNE2WLnHzH8/xrNqKgzOJlLEkqVUUsmfHZURgKMVYjLSNaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTTI1jS8; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTTI1jS8"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc73ab90ae7so2407851a12.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012696; x=1790617496; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YYqX0VJzWkRuy7Rww/xIfxaxsSEw1uv9+hGx8/FiNWw=;
        b=vTTI1jS8DXCi3X0tO7uOey2f0A9w3S6ONo3tdTCYkPVFtZx6ozR2NbGGh6qt7pzs9a
         DYTuMR71i2jDR1tiTcIZliLA+Ysz9XNPKRq3HKRMAeZjKGazHQomsOnFlhNwdb+DqtPC
         aOHwsTfVhdQSKzoOtM4MDVsGGwLJuAgybR446TbPvurb4SA1ROv3LnGB087ass98Nd7T
         vtf8D+JgsB/ul2aDhPfSIsWu/kmj6pKDhczCFu84kMgrZboOwDBj5Rk9OTdt+jCDF+4k
         Wl0trL5MgmOEjBO3by2Bg+IsxV6B5HTtzI6Wo3N4v0MeNqw69nHGJjWnqsvcCOFWl0pC
         WuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012696; x=1790617496;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YYqX0VJzWkRuy7Rww/xIfxaxsSEw1uv9+hGx8/FiNWw=;
        b=xNftM3wR6ctwwL20Xvtur2x+zmMPwwYuDVy6dXyvytLzLStcL0hhxwiCl49d0Y1yUA
         cklNtYaGPBLWCmnh7GH7kQZL2oR4DePq9xmgUVwz0OEaFT5pCsHpV6JhYTT14SYS8e62
         BLYLZRqBaDpvieKIJPWhsZDZNwSHx8zpM5lWSysXvmnAftSfgVmWVwSetXqgLCRfsKXO
         CtlLRFTSBRINggB6wYIM5C/0/gYA0tCzqXrNNf9ZwV1sEJgyY3H9uLym99RUj9j6Cfv+
         efw6XN/A1YEaC1+newr66P3B3PRSlh4Iz3CnxPfDkg5DY6CYAkRFYRsGSWX85sDcB16d
         vLpg==
X-Forwarded-Encrypted: i=1; AKwUvByy8bQUgCBrpVkpI0fNIpqVCmqXfYCxa5S7J0b/XIfx32Tvd5lZ3ehqxNgp5kl8EpdCR6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++m2avOjUv0cIvOLIttejk1CTqEbyafASClfzzYm4mDSVH1LUfYw
	RiHlQVzJdUGj4fqNiZgfjPJptYYH+UAAg7sKLJyZHSq92LfbuoUWQV3vRaWX4um5+kVYQv12XVw
	DudqtQQ==
X-Received: from pjro5.prod.google.com ([2002:a17:90a:b885:b0:3a0:645b:1c57])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d888:b0:39e:4c7f:8b16
 with SMTP id 98e67ed59e1d1-39e54cf8bdbmr17922638a91.27.1790012695572; Mon, 21
 Sep 2026 10:44:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:45 -0700
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921174445.911676-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-8-seanjc@google.com>
Subject: [PATCH v2 7/7] KVM: WARN if vCPU creation is in-progress when locking
 all vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM holds kvm->lock for the entirety of vCPU creation, from when
created_vcpus is incremented until the new vCPU is fully onlined, WARN if
the impossible happens and KVM somehow sees a discrepancy between the
number of vCPUs "created" and "onlined".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 985af39b980a..e66d9761ee49 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1363,7 +1363,7 @@ int kvm_trylock_all_vcpus(struct kvm *kvm)
 
 	lockdep_assert_held(&kvm->lock);
 
-	if (kvm_is_vcpu_creation_in_progress(kvm))
+	if (WARN_ON_ONCE(kvm_is_vcpu_creation_in_progress(kvm)))
 		return -EBUSY;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
@@ -1389,7 +1389,7 @@ int kvm_lock_all_vcpus(struct kvm *kvm)
 
 	lockdep_assert_held(&kvm->lock);
 
-	if (kvm_is_vcpu_creation_in_progress(kvm))
+	if (WARN_ON_ONCE(kvm_is_vcpu_creation_in_progress(kvm)))
 		return -EBUSY;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-- 
2.55.0.1082.g2b9226bbc0-goog

