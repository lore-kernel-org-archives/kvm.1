Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485C4A6881;
	Wed, 14 Oct 2026 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015514; cv=none; b=YCUO5dM902zq68Mbvs6AN5wi1nT72O8yJ2WBStbiE7G6oEgan+J4qPGXPDB01EuUz+7sEQhpdsRKKXEDs3UHvwwnIhfhNp5YAiJfXZVIZe9UlPbdC1ij1BuluqLZwaoSOyThuD+Cml0zjc/ySuAplsI2TTKxLuo+a8iGTIaCFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015514; c=relaxed/simple;
	bh=oUYLctzFTPNv1h1fZK+rALzeqWRn8Xf5fK0mzSlOb7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiydCXswi7RHz7NJb0uNI5HZTcJzLBi2mcDQvc7JMJncrIMku+oCjcBQyNm+ndb+fPYjO0TfUwy2uBqtZu+DnuRoCPNHShpobsAb9DKnP6VN8BWuYd1IXjW4Fxo93tVVHBC8FEhZk7s9LCNpUaz73c0nz6sEu4912mmTsHMImlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n/Pkz7Lm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/Pkz7Lm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=d5silyuAralAhbfBjGh06jyKUpYwbbsz9nTuchjDQFM=; b=n/Pkz7LmGicBdURdArKWtsIPC+
	SpaoA/QncmwUzdK9hdpFBpotDZHBHXbAfkKKpYIsxmzy4SmlJGCWeg2e9VAgtomGiRB5jILtqEcrj
	bMhAR8x7BDt3Zv3i6hQTpOqzz70nDXpC/1uVLpXfatMRZ8xrcZQVMeHz471UgKxTXrsaiDNLWmjAC
	pvB8nVkCntickBW+QBKTWjvz0lG+dkmlXyP4HlgZjdBjMqR//lZvhhWl1nw9wYGTZE3PQ8cmkJ3pa
	YGXay+cIWHi29tF9jRmCpSh9HEHVjD4TrBh17Fo08+j0ZDMJQlL0DIlWHOOdp4QgRASb0FYNEM17c
	sXkgoAhg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH75w-00000007ibg-2Pww;
	Wed, 14 Oct 2026 22:05:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75w-00000002Axb-1Ybw;
	Wed, 14 Oct 2026 23:05:08 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 03/11] KVM: x86/xen: Don't block on xen_lock within the vCPU's kvm->srcu section
Date: Wed, 14 Oct 2026 23:04:59 +0100
Message-ID: <20261014220508.518772-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014220508.518772-1-dwmw2@infradead.org>
References: <20261014220508.518772-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The next commit lets the Xen attribute ioctls wait out a memslot
update while holding xen_lock. A memslot update in turn waits for
all kvm->srcu readers, so a vCPU which blocks on xen_lock inside its
own read section would close a three-way cycle. The hypercall page
MSR write is the only such acquisition; step out of the read section
around it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/include/asm/kvm_host.h | 4 ++++
 arch/x86/kvm/xen.c              | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3af7395c2430..6bebc4a79a33 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1108,6 +1108,10 @@ struct kvm_hv {
 #ifdef CONFIG_KVM_XEN
 /* Xen emulation context */
 struct kvm_xen {
+	/*
+	 * Never taken inside a kvm->srcu read section: holders may wait
+	 * out memslot updates (synchronize_srcu).
+	 */
 	struct mutex xen_lock;
 	u32 xen_version;
 	bool long_mode;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index d64630a417a7..74dad6789e42 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1320,7 +1320,15 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 	bool lm = is_long_mode(vcpu);
 	int r = 0;
 
+	/*
+	 * The attribute ioctls wait out memslot updates while holding
+	 * xen_lock; a memslot update waits for this vCPU's kvm->srcu
+	 * read section to quiesce. Blocking on xen_lock inside that
+	 * read section would close the cycle, so step out of it first.
+	 */
+	kvm_vcpu_srcu_read_unlock(vcpu);
 	mutex_lock(&kvm->arch.xen.xen_lock);
+	kvm_vcpu_srcu_read_lock(vcpu);
 	if (kvm->arch.xen.long_mode != lm) {
 		kvm->arch.xen.long_mode = lm;
 
-- 
2.43.0

