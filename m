Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109F4B2055;
	Wed, 14 Oct 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015516; cv=none; b=CHB5QYu3cPvbvkEHg6x+xBk9MtGUUTfxfNWL6schGWpchOGQSXmu7BQtFpAgciysgv75jZxuZWOS4AL+/Q97gMpCylxLqGbhr6lwqr0lzz81BazI1OMlQymhv7klqrfBDWhsTuphaGiYtTFnOfPXGOT55JNi4iX6PTUjYEkWgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015516; c=relaxed/simple;
	bh=nrT8rnwLX7FEwzpOG1YjtUE+SGJmPCH306xlTGwr+Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3OmA6rGEKCoyCrl5VOmBXxFi1UB+93MMDPk342vfPZcK0OuLyL6GBaFj+glSbHy/6/61ABCZz5uCeJCF09I3C4qb9KtrBWwX0GEiKA+hqGzZCUT96I1I+FCSJY7NyfWCSacK/FhFCEJCFCb3nFy20JrJHA5O29HoUM1czHnaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LeCKQ+P0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LeCKQ+P0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=afh7PvDa6u9yTDXTZzXANDjYMT9nGCt3D9mxK2ecVXk=; b=LeCKQ+P0wGT2du6ZksTSB9OAKg
	lh6liK337wrfXsIJzHp4vqRHX0UpwzXvpCDkHrJNMhQHRAfSgOFQ8t9vqvKeGRb6+p5i4QycXpsF3
	37W9J1nhcNUSlEbuGZJES8sf15LszRVUi2iTrRQ6k7luL5cPJrGfiBxoKA80D1sUwgFatsfAj6HDM
	s584B4N8KsDOuYJU/UsYz1PDj/rdfR8neDrZH1rakFfdOpWQwHCKWe67YTL86YAS1JT6V3YREa2lf
	3GVJOqI32ScZCf9nkVfWFG33PuoUeOR49HjUoZbcMXs43PIgIR1K61CIGT+ZS07ZeIb+MZdaMkzuN
	FaUo2hDQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75y-0000000HFAH-454G;
	Wed, 14 Oct 2026 22:05:11 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75w-00000002Axw-2yLO;
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
Subject: [PATCH v2 08/11] KVM: x86/xen: Explicitly tag "shared info" page as never being dirty tracked
Date: Wed, 14 Oct 2026 23:05:04 +0100
Message-ID: <20261014220508.518772-9-dwmw2@infradead.org>
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
 include/linux/kvm_host.h  | 10 ++++++++--
 include/linux/kvm_types.h |  1 +
 virt/kvm/pfncache.c       |  4 +++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 8491b4adaf51..df72ab95658b 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2500,7 +2500,7 @@ void kvm_xen_init_vm(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.xen.xen_lock);
 	xa_init(&kvm->arch.xen.evtchn_ports);
-	kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm);
+	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true);
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9031f4e3f4e1..debce84f4177 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1465,7 +1465,13 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
  * immutable attributes.  Note, the cache must be zero-allocated (or zeroed by
  * the caller before init).
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
@@ -1988,7 +1994,7 @@ static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
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

