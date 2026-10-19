Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427100;
	b=DEoGectesNo97vs4g80zg9G8CTl3leQO/HM1dQjlmcZRt2AOmshOKwM9TslGBsKrx7w2
	 vpiQvqABUoc5JoSF97Bwz7UHHY6TbiHIeMItyd7B5yZsd2xDZbwDMMTX3kWRI+Y/DXPeH
	 H+j82mXQlhoLAB8tYC7nDeM9V1wSpFp1BYjyLB2y86Fjfb/o6CfY0t3yLptVZkFYCL9mr
	 JGkbvmwmyFeRuaNrD/DFIb4xJe7tykEn479c4vxg3My3lYfQ10701JXoClYiR0rElOGlF
	 ljQHXCHiKDzaFqqiTuNwKJo+IGFnumXvLZuiuZrBiYRyu0L+c5nJ8Dty5ovTg+emLhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427100;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=sxmo9YnZnRqj76uOw3248z+dlkVfVDS2Xn4tGIzz6Pk=;
	b=l6ceCldY8qsnRVDeVLZsq9k9782WALlVwEytFZDW9DfHWN82cE/dq8ajQYOD3zIZvC0m
	 Tt+msH2ZDPjrnTdgrTamcyFFojkbkOU/RoRzDzgIL1kg9ZGtPT6+ZmejAiyJnnOAxMbqC
	 hXnUmH2h8GeKmKLvQWVdefEVJ2G/qrvyeAuOXuRUCEedubMBM4cF0n+XjUXR9XPPUK4vW
	 0ZRSjv+g/TRUtEA3ZIE4gE0DI+Q4kRAdT03pcyVeDGyy6e0HMGqi2f0cripw+If/8b1zx
	 AbSvdYKgpHQMCrPEZd8961fQGyNoZ1vIriOegfpxVrf4IPpTFdOG1UXDEvcyOACayfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=J9O7A103;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8B606A322;
	Mon, 19 Oct 2026 16:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74A8B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=J9O7A103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sxmo9YnZnRqj76uOw3248z+dlkVfVDS2Xn4tGIzz6Pk=; b=J9O7A1030rwCLfMGhbZvOdUW1G
	pIv+VdrlLMVZmCNlnH/xKAdzYSH75+784CmQS1CFRl8+5E7yEk9TGf0mORLNkzzsNq6HQhOlr+sTa
	reObJ0BFFmKSmZ02CLxPdnkLEen7vVDsFqL+rHER0YK+/5GXvgPscMR8FdhkmqvV2hoHQzCrZcbr6
	E7H3PyebzE04VhwQ2qBtfLFGWhkh7dlFnSaK0omy3gE0cqK0e8JUOt64VaJkwAFRllNTUChBWpWia
	2glRipQddRosbYcpap8vVq4DoUOxBWopPhSlf8F+/5vK/tsgdYAJRnG/XFtMJUCYdZMXUp3sTFtlk
	gaflDsVA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAK-00000003qsn-1Hdh;
	Mon, 19 Oct 2026 16:24:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009gs-2WHw;
	Mon, 19 Oct 2026 17:24:45 +0100
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
Subject: [PATCH v4 08/12] KVM: x86/xen: Explicitly tag "shared info" page as never being dirty tracked
Date: Mon, 19 Oct 2026 17:24:39 +0100
Message-ID: <20261019162445.37219-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019162445.37219-1-dwmw2@infradead.org>
References: <20261019162445.37219-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: Sean Christopherson <seanjc@google.com>

Explicitly mark the Xen shared info page as never being dirty tracked so
that higher-level gpc APIs can be added to automatically take care of
things like dirty tracking, without reintroducing the bug fixed by
commit 55749769fe60 ("KVM: x86: Fix wall clock writes in Xen shared_info
not to mark page dirty").  And because the code _looks_ buggy.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/xen.c        |  2 +-
 include/linux/kvm_host.h  | 15 +++++++++++----
 include/linux/kvm_types.h |  1 +
 virt/kvm/pfncache.c       |  4 +++-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 6a1162caee9b..0ba684bf01d3 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2577,7 +2577,7 @@ void kvm_xen_init_vm(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.xen.xen_lock);
 	xa_init(&kvm->arch.xen.evtchn_ports);
-	kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm);
+	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true);
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 94989a705ee6..ba23f4e0a4c0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1456,16 +1456,23 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 			 unsigned long len);
 
 /**
- * kvm_gpc_init - initialize gfn_to_pfn_cache.
+ * __kvm_gpc_init - initialize gfn_to_pfn_cache.
  *
  * @gpc:	   struct gfn_to_pfn_cache object.
  * @kvm:	   pointer to kvm instance.
+ * @never_dirty:   the cache never needs to mark its page dirty in its memslot.
  *
  * This sets up a gfn_to_pfn_cache by initializing locks and assigning the
  * immutable attributes.  Note, the cache must be zero-allocated (or zeroed by
- * the caller before init).
+ * the caller before init).  Most callers want the kvm_gpc_init() wrapper.
  */
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
+void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
+		    bool never_dirty);
+
+static inline void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
+{
+	__kvm_gpc_init(gpc, kvm, false);
+}
 
 /**
  * kvm_gpc_activate - prepare a cached kernel mapping and HPA for a given guest
@@ -1990,7 +1997,7 @@ static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
 {
 	lockdep_assert_held(&gpc->lock);
 
-	if (!gpc->memslot)
+	if (!gpc->memslot || gpc->never_dirty)
 		return;
 
 	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpa_to_gfn(gpc->gpa));
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..e850adc3f47e 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -94,6 +94,7 @@ struct gfn_to_pfn_cache {
 	kvm_pfn_t pfn;
 	bool active;
 	bool valid;
+	bool never_dirty;
 };
 
 #ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 0e700c337f5a..8498abb746ad 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -437,7 +437,8 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len, bool wait)
 	}
 }
 
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
+void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
+		    bool never_dirty)
 {
 	rwlock_init(&gpc->lock);
 	mutex_init(&gpc->refresh_lock);
@@ -447,6 +448,7 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 	gpc->gpa = INVALID_GPA;
 	gpc->uhva = KVM_HVA_ERR_BAD;
 	gpc->active = gpc->valid = false;
+	gpc->never_dirty = never_dirty;
 }
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
-- 
2.43.0

