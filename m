Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31184531633
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178683; cv=none; b=hngfXkS3jCI6mP/rHC9koTRS9oaRplzryQwkyc0F4QfDPTjrAP9IAaRaIW3gyCzpDwHv4GoU8C8OO2DWxvbTbUI/y2Q4m6A+yaiKFyIjiUEASGKPgR5e8FAnQmhyT85W6JceFAZWxxyIUncaQnhEdTQE50UCIl9c+BBOug0qyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178683; c=relaxed/simple;
	bh=hAGeqAtPkGOS41f5bDyMSpg3ysHNF8998MztkXzdvV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GEn+tcvKvHCb6BGBUPSTd+aN7QQvzWv0mMdX/8W43IDRz6Ky2nZPa6ZMlv8rdFazrZGc5bYYjKxImG5auvwlQuND91DSpDi8ix3wx9W82YVioFHIZnbtI/8AXDe6OMJiFo9kMj2tzrCHBi8xHUyBsvJVmm4H+X6YjbUCeg5uEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aluaDtGt; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aluaDtGt"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39deb05ef51so1135736a91.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790178673; x=1790783473; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BZvXYDcMxG9QzYOllEJznxsL4DUn8KPA1psb/Zru+OQ=;
        b=aluaDtGtzecMttII5rgAmNOnwBDgPK7j7OheAHVdzhmrLZ92YPieDi3YB9lMyYmep7
         RRX8j9DlR5RTiNGe+5u5Ot75jx0554s279+YoqzBdte0gDKNkMk0NXGr6XPblIsJ2cqm
         NuyjfNlbfJ8WSas5yzJOKKp+Z8vxjZrviJ64PQx33hzEZLxZ6C4rDn3oiIRvNDt7p+S/
         GUd8pztChr7V9l3k0BxwoiGbbF4JnhyM+OPIDRBnXG1L61cescoa8/jH62DkwLMF6bNA
         KAGfZAZiYX898EcCjRlu9uP7rhoaIDD6YOkWX8zI48nHL8qXyf6820amFP7ulUDNF4vn
         2gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178673; x=1790783473;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BZvXYDcMxG9QzYOllEJznxsL4DUn8KPA1psb/Zru+OQ=;
        b=dzK46ZsVEY3DZ1g93Z0LJgZRVYzY9JAd3f4CIynedBBtK0wxft/nc6oU3eLrFRxbQO
         SRkZDnbYlsEPtUvaCXEtqhVXYt+RL2yYC2+tSJGjQesaZCeaENAFtZgF8Oyf54C2rrxM
         iVs+4OY/9XaYAfg8z6w1p/yNLkOwEaYNzJnbx2vpXy3Du7KwUqyvZsbZT7llBwk9KwXm
         4LQU8QdTmyXEw8iFexEHfpYSK2kz0g10OdznTYfXMHz2xGYprD36tgg75jCSgNv7p9g3
         UURW6lZNAQk0PqUhYG+I/PJvmnhnsIgFeltedi+cFf2TfjLRGBpXPt8tZPgu5GWkq2CA
         XQZA==
X-Gm-Message-State: AFuF++mROVebTE0u1dK0P8g80EqKDgyztBoqohxlTUr8HVLGamX2F2W7
	rzktGKIMAJlZj789IZ1vjFnA/aaKhl1lj8GCEQ0NeqJsjSLV+6drx5+xKMGe7+nI/XU1uWWMMnz
	5wxfE4g==
X-Received: from pjbkw10.prod.google.com ([2002:a17:90b:220a:b0:3a0:6d58:1c3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fce:b0:3a0:3881:eabe
 with SMTP id 98e67ed59e1d1-3a07e4ee868mr2520155a91.5.1790178672821; Wed, 23
 Sep 2026 08:51:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 23 Sep 2026 08:51:07 -0700
In-Reply-To: <20260923155108.1550622-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923155108.1550622-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923155108.1550622-3-seanjc@google.com>
Subject: [PATCH v2 2/3] KVM: SVM: Use "is AVIC-addressable" helper to sanity
 check load()/put()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Atish Patra <atishp@meta.com>
Content-Type: text/plain; charset="UTF-8"

Use avic_is_addressable_vcpu() instead of open coding a check on the bounds
of the allocated table for the sanity checks when loading/putting AVIC
state for a vCPU.  If KVM botches the allocation, then KVM will already
have performed an OOB write in avic_init_backing_page(), i.e. being super
paranoid in load()/put() doesn't provide meaningful protection in practice.

Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 0e4b5eb6ac82..4173a30dfe60 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1049,8 +1049,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 	if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
 		return;
 
-	if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >=
-			 PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm)))
+	if (WARN_ON_ONCE(!avic_is_addressable_vcpu(vcpu)))
 		return;
 
 	/*
@@ -1112,8 +1111,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 
 	lockdep_assert_preemption_disabled();
 
-	if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >=
-			 PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm)))
+	if (WARN_ON_ONCE(!avic_is_addressable_vcpu(vcpu)))
 		return;
 
 	/*
-- 
2.55.0.1082.g2b9226bbc0-goog

