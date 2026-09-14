Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB749C4DB
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409557; cv=none; b=alf16TxUXuOQWPXzUJL6quCJXAEztEPnw58PIE1F20BuX0Z8nzGYdPesDAsbsqVcIFm+fgtSFdlKw3Gh9gxh7tzJPW1G4LtXL5PsrnL6x9KB3LEpmyP1WUlpkUiXF4z2negHBWvHJIFegNlt/lwZqVinpPcAO9d81bUeceWdIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409557; c=relaxed/simple;
	bh=/IdUyLNiMdGu0jrgGR9Q1GZN+1EphXX7mT7YjuCIqIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QG54mk6u9/45XqC7XaJfoiO5MCdXIJxy8bRzqnHS3kX0PxUB870YGvG6pDffqx9kkMskLRALU8tNoTHC2QycxAYg/mkXyxfafJi9GypC2fioTqPFcP0ewCzcu0i4v1OXM2utKN/KsqGEIYildFTOEehSE6bpWC8S/ddx7TE910U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mOugi3ZT; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOugi3ZT"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso4594092a91.2
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789409548; x=1790014348; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZO1urm4Fark0kk4FfGgKDyyN0dzql0DO01I8NkWQ2as=;
        b=mOugi3ZTM5REKyYD+tE/9Q04x+mflskhf479f69cTl7Yr6Nyv+PWK3CMeK9UGmx2bP
         1n8no7kk9inVZcah97wDhRyQbeSoYa4Q/pcARGYpbFCBPRbXLB7ggxHuIbd/BPicP6EK
         0GKRIQp5Ij4RIXgy0kxTj82aklzOj7Ttjq+lryAPBzZkk3RNX66Ucdbf9LuO8V3UIsdo
         2WAi8bcWnPb8VSlIct6/A73YvLU6Hg6ENRC78biexQFPceRKistP5zCtwpzqGFX44TnF
         KdJ0Mwi2mR+OvpHKuV93EwBUEOfJQN84kxg5C7Bompyp5qkcN+e4fTaj/TTUoiWKcb8b
         KxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409548; x=1790014348;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZO1urm4Fark0kk4FfGgKDyyN0dzql0DO01I8NkWQ2as=;
        b=qloTdHbc7/UNdXb/WLldn/vy8x6CnqsNVkO5RMP24iLmXt8W85+QmmQtEvpXcFDJSe
         /cXFUpytPzuRnON3ZGV5zhyWz5siL+IQo7nITH7eEbL94yAn3kKA9e1VZtfcqeRakX5T
         c0BOo2yDaBnnE8LckSJA9QVtsB+ieRoP8Iul+naje0O5kBrsSGuyoHwufavciaq6Uq9d
         aVoJZ5UcHzgrgYvVFA47A2AnwJNp+OBwB0tBXMKqt87HqWQAaGIm+oJhnrmBctKeXgA8
         wSOd9uVs4osBYHjIAcT3weFBqFK4AIBB+hZcoRHB8bLznjCLxu4RAwOirDojs4RumRK+
         8KWw==
X-Gm-Message-State: AFuF++mXc2o/l+6c7TezUqmR3Bu52J7VQs+lbSbf4fImydmuPk84Tay6
	g0jeJzNGzTkdIJjsii4CJ6Ome/lkUlx26RuFW2zabWG4d+2d4IouIAUJb/GVG2p0M68BEihjiCP
	NtYNpFg==
X-Received: from pjbkx24.prod.google.com ([2002:a17:90b:2298:b0:39d:c134:415])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc1:b0:39d:fce7:f63a
 with SMTP id 98e67ed59e1d1-39dfce7f7fbmr1445324a91.6.1789409548252; Mon, 14
 Sep 2026 11:12:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 14 Sep 2026 11:12:21 -0700
In-Reply-To: <20260914181223.289061-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914181223.289061-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260914181223.289061-4-seanjc@google.com>
Subject: [PATCH 3/5] KVM: Move check for existing vCPU ID to the top of vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Now that kvm->lock is held for the entirety of vCPU creation, check for a
conflicting vCPU ID at the begnning of vCPU creation, before the arch
precreate() hook is invoked.  This will allow reverting commit 97d65b544f48
("KVM: Check for duplicate vcpu_id as early as possible").  For now, keep
the redundant vcpu_ids tracking as a sanity check.

No functional change intended (absent KVM bugs, checking vcpu_ids and
walking kvm_get_vcpu_by_id() should yield the same result).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c17cc8dd371b..d5524ac8c5cf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4182,7 +4182,10 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	if (kvm->created_vcpus >= kvm->max_vcpus)
 		return -EINVAL;
 
-	if (test_bit(id, kvm->vcpu_ids))
+	if (kvm_get_vcpu_by_id(kvm, id))
+		return -EEXIST;
+
+	if (WARN_ON_ONCE(test_bit(id, kvm->vcpu_ids)))
 		return -EEXIST;
 
 	r = kvm_arch_vcpu_precreate(kvm, id);
@@ -4221,11 +4224,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 			goto arch_vcpu_destroy;
 	}
 
-	if (WARN_ON_ONCE(kvm_get_vcpu_by_id(kvm, id))) {
-		r = -EEXIST;
-		goto unlock_vcpu_destroy;
-	}
-
 	/*
 	 * Set the vCPU's index *before* the vCPU is reachable by other tasks.
 	 * Unwind the index back to -1 on failure so that KVM can use the index
-- 
2.55.0.1032.g73a4cd73de-goog

