Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52848C3E2
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629718; cv=none; b=CZ3D8X5Nlnpgj9aqYY0++4KAgKu8wcH3Z15n2EKdGTqknhlYfhq1LI7NvSjDphvamlw1w5rmwokxCdJIFkv/5B2gJnIxIshSFSm8Cd1zU3VR7Mq3fPCJhtF2e1ZQej/dm0MzzDd92CxbFpRb2fOzdQ9LSogCyu6JMobJIn0AwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629718; c=relaxed/simple;
	bh=flLnTzzvdktYAMXGKCG/ht6BWQVMu8ko2+dOzbhNc0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4sNQug09Fwo/D3aIluYOCKXWuybRPugL6Ih9F4ukdHSZ5eUom2m35e+bw7e/eN9rXiQltwUogqtHOz1vjbFlTiZShhSUrY9skZBeQfWQGKzM67HB+oeC7c8HpUujwIJ+Qqkt40hEDAJORazDkxDV0ZUC/voutI7fPt6RjlkbSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4Pm9ix+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFW2KGkm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4Pm9ix+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFW2KGkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784629715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qX+yOp5vEEJO47GrrgFjd6hpRsB9whe/kZX5TD9uf8A=;
	b=U4Pm9ix+2hPMkrSv3V1WGo1CFGbhONS3Y97fVKqDDkAi4KtAE7geOBXsvfTCljsuYGtBgl
	1RgvZWEbteyjgaE87ovqADs7Eq4nNlkDWunrO+h40GjSrdO0gCeM11gnLWFRZUHp4LbZEm
	lReePLb5XXiBSawTDxwjlFiYtTB4P1E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-GavqP9pzPameo3R6EAywhQ-1; Tue, 21 Jul 2026 06:28:34 -0400
X-MC-Unique: GavqP9pzPameo3R6EAywhQ-1
X-Mimecast-MFC-AGG-ID: GavqP9pzPameo3R6EAywhQ_1784629713
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so39076375e9.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784629713; x=1785234513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qX+yOp5vEEJO47GrrgFjd6hpRsB9whe/kZX5TD9uf8A=;
        b=HFW2KGkmOX203n1dk6XQ/3ewss8l2aL3ZbRRVhIXtQcpUDXvGZdgX/kX1F91DM7KMf
         4QaerTq31ay/RoZ4GqC6J6SX16AjqAZE73wFjKPCLwIgH0/xQKhyAcd92xIjegrBUcqH
         tgUSmidMLMsE4Kfx88Dt3ddFzAlodgUDjfUIvjzB1v1sgYiGkhleqLUnkJeZn29moGsp
         ZHe/BZ5hqJFDpuq1PJfpsyF6kM+5IRt6TOUny9+0DHS1CALDUVZGdR4RzOLMuqa4cOTQ
         ZyBY3ZqpXAmvdWH2Ts24OdzAOgea0nYbC56Qf7efPHh21LMMRHid44BsonKse7lsMUJ3
         yL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784629713; x=1785234513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qX+yOp5vEEJO47GrrgFjd6hpRsB9whe/kZX5TD9uf8A=;
        b=Yjt64bZAhKAmff/OwTQ0zSE0kjlm/LMGItpZ2f77kJwNxYDB4PACrFJtHv8d7RwLbu
         d04fSzzMLRICsveh9GYxGzrg667X2yWZuQKlA7qCdehYNDqXIiYsTcbmVlzcHWGeF3gn
         mkWsI9iFqfLcRk7YdRRU7Bx+5GKH4XNkYZRrRjRS4vzHCGshlkCYswwgp10y42K9djzm
         4jw77mLFRt5tR0mbhrfqJTz07g9qH4LnqtUMW1HmkmgBWtuDqYUk8sdH1Bpzz0RM4D47
         Sp2mmnonqH+2Wi3z0MBqoJCIxehuMShnY2g/evUBva/E+VWtPbWwv/v8THL0apB48abf
         zjMQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyFxs+AvIPvy/MIDp/wl2PcGw+8kXuBnbs8ResjEMzLzH6tH5m4aDRUHkRaKgMV5/EPKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+fM7BuOuXzrw/ldXtG6WuzaVJk9d0tcO0cCb4/uG9BuQLF/s
	hESWqaHmPmlKDQkNW1ky6fNITVzRKZHBIgm7MvWGbhskCOkfpXxoyqti3oqGgFfMLQcK7u4os/q
	JUTTg8+B6Y+Tkorz7RW3MD+/XT+N2fVasqb0GcyXgxBq9SKLtLtc5eA==
X-Gm-Gg: AfdE7cnXjpE33enJMv8/shLMsmK//4yU2hROPNZVc2mAFe9l/yvII185aRsrN+h1ikV
	Vjl+QyBdC/ANyaGpEwl8KkeZnjiCzDN3XmdjpEMZ6NnyyizrXc7uqctyO7lcm6g1duxL8WbyRHw
	q0XQZ5ZP9lzSMrjJAMpi40HHMNzXyde7Ym21AJweovwHflSbE4sZd0UY6R4Nuw8NsGnz28y1BOF
	FXRraDC0m7oZiiQPeDDd6nCncP5UfMULog1kfha904S4H73HMQzv2OQ3CoNWjOD7pKbTJqIvAvf
	Fk0LBl/bBgjRSHWMCD8G+pTKhiRkJMDefWwCfZJdzbFuR01qnMzQ76g7o4rq0YcN0oPv1uk0u3q
	/vZRrTvOA6SAuFnde5Vss3HHJfyggsxp/gSb8HGXFTjeapU8WUg6lZ0/QmXRiJcnkjEJwgdIsop
	WOSuqE
X-Received: by 2002:a05:600c:3510:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-4954a3e20b1mr207187175e9.8.1784629713270;
        Tue, 21 Jul 2026 03:28:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3510:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-4954a3e20b1mr207186825e9.8.1784629712755;
        Tue, 21 Jul 2026 03:28:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653687b2sm67947495e9.1.2026.07.21.03.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:28:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86: Check for invalid/obsolete root *after* making MMU pages available
Date: Tue, 21 Jul 2026 12:28:29 +0200
Message-ID: <20260721102829.313226-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Check for a "stale" page fault, i.e. for an invalid and/or obsolete root,
after making MMU pages available for the shadow MMU.  If reclaiming shadow
pages zaps an in-use root, i.e. marks it invalid, then KVM will attempt to
map memory into an invalid root.  On its own, populating an invalid root is
"fine", but because child shadow pages inherit their parent's role, any
children created during the map/fetch will be created as invalid pages,
thus violating KVM's invariant that invalid pages are never on the list of
active MMU pages.

Note, the underlying flaw has existed since KVM first started tracking
invalid roots in 2008 (commit 2e53d63acba7, "KVM: MMU: ignore zapped root
pagetables"), but the true badness only came along in 2020 (Linux 5.9)
with the invariant that invalid shadow pages can't be on the list of
active pages.

Note #2, inheriting role.invalid when creating child shadow pages is also
far from ideal; that flaw will be addressed separately.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Fixes: f95eec9bed76 ("KVM: x86/mmu: Don't put invalid SPs back on the list of active pages")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         |  9 +++++----
 arch/x86/kvm/mmu/paging_tmpl.h | 10 ++++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 234d0a95abf5..41f92ed1ca37 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4852,16 +4852,17 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	if (r != RET_PF_CONTINUE)
 		return r;
 
-	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault))
-		goto out_unlock;
-
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
 
+	if (is_page_fault_stale(vcpu, fault)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
+	}
+
 	r = direct_map(vcpu, fault);
 
 out_unlock:
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index df3ae0c7ec2c..1ba840a73b7a 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -864,15 +864,17 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	}
 #endif
 
-	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault))
-		goto out_unlock;
-
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
+
+	if (is_page_fault_stale(vcpu, fault)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
+	}
+
 	r = FNAME(fetch)(vcpu, fault, &walker);
 
 out_unlock:
-- 
2.55.0

