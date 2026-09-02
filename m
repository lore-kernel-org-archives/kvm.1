Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3DC45D5CC
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788391235; cv=none; b=Kj3AL6V65d9elWlA/YSGdSC7o5sNBuUq48BS4XEj/Foyf1bgPsvCDGmldnTA1scrx5ceylssF1cwhd6nNXP/UN6jOaVCCQnZ0x1gO9/vDXrcay1QEBvrppBTg72qhpdTxRjxU0wKyyXHq8X6plt8ngRe99XX3aXX0oWa7/ZL/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788391235; c=relaxed/simple;
	bh=Cjjfciu6Yrbk8TQm+bLXiRt8OKbDv1+8Ce4prQ3HDfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C6mq2eTyOPNPggiQ4fbO4lG3g9mH5j0vTLe9rUngguUYDwqbzeMQJTc34m3zUdh0KZ4YlU8fPphGB6jJ2x8DZSdOOEW6DUec4LmDt+WaPgXx4XWAauO6Ga8XsC/XPOLcpSDBwMLpSvcUwJ2c+mhTxIqGP92jTNX/Jr/f7h1Ap+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIFxvuJk; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIFxvuJk"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso1261373a12.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788391233; x=1788996033; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mkiR9odrgpXoU7TeaqfCDaUE1/ZRycIEI7gHGOfzeQs=;
        b=GIFxvuJkX3qdMvCnIdXz5V/Hle39T7Cmpkf0uHV3OT7VdbTlqlv35jzog+k/tNzFzY
         vykEwfTVuA/9Et/t4Tm6nYdSHa0ydSmAbAhDeEatfHnpQZVhomEzzY0B/8tKtBeCp2KT
         VvVP2HJGkdmIkLfAMctZMU9clQG/Rb8VklBx1vVQlYLYdji3vY220yA5HKHIh2sQaIqb
         ZSCLCE3sH4BFM+rMAqtDrFwZPxjS9FG0Fu4y9Gxc5rmFseF4twsq5ME4+knnMAtbgfVh
         EdDfOWWZv2DfFWoxGES48+4G6TU7s/mD/K0Z79TvC6c0/oim5Kq9rnRoMHxiU6w3ZNDc
         FVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788391233; x=1788996033;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mkiR9odrgpXoU7TeaqfCDaUE1/ZRycIEI7gHGOfzeQs=;
        b=eX/5jqR2TQtbGr/2jlXT73PeGy9rBHj8JzBHYSlEffMyAJ/cgEo08eF2onpTesuUKV
         v8oeO4Ld+IRADKCtJcdCH1DQheRaqdKMjCKp67ckKuXwcqBYJSgCVJaD/0SCew+snQEn
         3KeDY1plb6YilsOmvK/ZgKvAKeurVL3hkCa/E8cqjyrIr1pthY5vVsaAH6CqUAAMU+Gp
         kTsyAac1YiNrZlvKwV/nW3ZKopI66VFELtKe+Mh6mFhN0ijOhesn7FN+yT8LbfTZbQxd
         l28u4k0xS7GpoRrilE/mq8xDRSe1Y4Ni9SFr/npZI1cN+OLYsVHGothywCu3XtGm5rxZ
         4kTw==
X-Gm-Message-State: AFuF++nXCXiAg/dHTd37JzpEpj+RRRXfk2eU7Wq0nO0DYfJLCcJMOyzG
	MDDDMPuCO35E5yAh3i/31LIjmivxtTZ/pO2K+jFrw+/I8n+lWemrKzu53aEsaHUD7Dc2V6YHBmW
	3ct4zhg==
X-Received: from pfff13.prod.google.com ([2002:a05:6a00:bd0d:b0:848:8b93:1295])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:806:b0:845:c694:5c3d
 with SMTP id d2e1a72fcca58-85ed20eeab2mr10809152b3a.1.1788391233139; Wed, 02
 Sep 2026 16:20:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 16:20:26 -0700
In-Reply-To: <20260902232028.2767071-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902232028.2767071-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902232028.2767071-4-seanjc@google.com>
Subject: [PATCH v2 3/5] KVM: x86/mmu: Bug the VM if KVM attempts to walk more
 levels than the MMU has
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the "EFER.LMA && !CR4.PAE" check, which exists largely to guard
against KVM configuring a paging32 MMU with more than 2 levels of paging,
with a very explicit check for exactly that: that KVM isn't trying to walk
more levels of paging than the MMU template provides.  I.e. harden KVM
against all bugs that would cause KVM to generates accesses beyond the
bounds of guest_walker's arrays, regardless of how KVM ended up with the
misconfigured MMU.

Note, don't use w->cpu_role.base.level directly as the paging64 template
only provides two levels of page tables for PAE paging on 32-bit hosts, and
handles the third level by manually emulating the PDPTR access.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 27427e7f22fa..f925b11d76dd 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -368,13 +368,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	pte_access = ~0;
 
 	/*
-	 * Queue a page fault for injection if this assertion fails, as callers
-	 * assume that walker.fault contains sane info on a walk failure.  I.e.
-	 * avoid making the situation worse by inducing even worse badness
-	 * between when the assertion fails and when KVM kicks the vCPU out to
-	 * userspace (because the VM is bugged).
+	 * Queue a page fault for injection if any of the below assertions fail,
+	 * as callers assume that walker.fault contains sane info on a walk
+	 * failure.  I.e. avoid making the situation worse by inducing even
+	 * worse badness between when the assertion fails and when KVM kicks
+	 * the vCPU out to userspace (because the VM is bugged).
 	 */
-	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm))
+	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm) ||
+	    KVM_BUG_ON(walker->max_level > PT_MAX_FULL_LEVELS, vcpu->kvm))
 		goto error;
 
 	++walker->level;
-- 
2.55.0.970.g62bdec98f9-goog

