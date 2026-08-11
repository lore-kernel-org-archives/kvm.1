Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F65188CC9;
	Tue, 11 Aug 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454575; cv=none; b=DUmpAxqUJurRY8C7c/yx3yz6p2NO8UT5/jCaNbjQQvZYeKyKJOPYcM9Wupm4kuwoIdbvz2Qj7KuLXZzcDyRuANfiq0LYpiHybrw5TazK9E3+ol1T5IwTh0k9EY0yk/jTpkMTX1C+CAoaxwhaHbXxxz2zQneppRRWZ8Ii7EaxT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454575; c=relaxed/simple;
	bh=JAxpfyOzRShUM3aetn4jtcB9opZ/qGfCoc2Fd/FMQlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PokV4KBS2kGAfwoIEZvLEuxTXv4TK+hSpk7xfDTZNgk6buYx9wSjoPtz1Sf/rP4I+EyAR1pFFM+fisbED14esDqUUm73X3N6kUmFBUq+2FYmezovh9in/T9PvlGbFjKWj+gIUXgqXN21GhilBZIhdoLeh+z4l19emdQYGCwsH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vzrwpBUL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vzrwpBUL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ScdNk4Mc4txgD05pFXbeLZfLevYP2xjCgGErsx2bQ1k=; b=vzrwpBULc60auXHrbsm3YfTQDZ
	JKoGspBrS3g/RpwKIP/W/sh+aj7O6m+TftfLoET1nkLNIsZKnZ2nwRBbYM9QGodKhDM2zGi7I3zUI
	+qami8ZuVkxTWTgy0YtuzYTL1P8QzDuzkF8lsi7C1FPUNU0AJ9X0m//P13Lih5Z9aHIWYGGZznHSz
	w+NNgwPai+m9RKebHT4FiGQtZdqG6eAdDZhxGZvvYPKSC9tmfgKjaXesq/LVtI9EiCCLCOCAOqPjC
	v8v3lL6w+MdTbjcxC1ICuin+K6FUaM+EpL/YKkC9/tR8LDDMBa4brQMZqQfRsuYRFiw5Cn97YVU/h
	HF1ZoV8g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmRC-00000000TZ2-2SCx;
	Tue, 11 Aug 2026 13:22:39 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtmRC-00000000Qlm-1eEG;
	Tue, 11 Aug 2026 14:22:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	stollmc@amazon.com,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] KVM: x86/xen: Explicitly tag "shared info" page as never being dirty tracked
Date: Tue, 11 Aug 2026 13:49:53 +0100
Message-ID: <20260811132237.102400-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811132237.102400-1-dwmw2@infradead.org>
References: <20260811132237.102400-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: Sean Christopherson <seanjc@google.com>

Explicitly mark the Xen shared info page as never being dirty tracked so
that higher-level gpc APIs can be added to automatically take care of
things like dirty tracking, without reintroducing the bug fixed by commit
55749769fe60 ("KVM: x86: Fix wall clock writes in Xen shared_info not to
mark page dirty").  And because the code _looks_ buggy.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/xen.c        |  2 +-
 include/linux/kvm_host.h  | 10 ++++++++--
 include/linux/kvm_types.h |  1 +
 virt/kvm/pfncache.c       |  4 +++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 40cb56621e25..fab215a522be 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2396,7 +2396,7 @@ void kvm_xen_init_vm(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.xen.xen_lock);
 	idr_init(&kvm->arch.xen.evtchn_ports);
-	kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm);
+	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true);
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9da947eb08ed..7b2dbbd6b104 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1474,7 +1474,13 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
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
@@ -1983,7 +1989,7 @@ static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
 	RCU_LOCKDEP_WARN(!srcu_read_lock_held(&gpc->kvm->gpc_srcu),
 			 "kvm_gpc_mark_dirty_in_slot() without kvm->gpc_srcu read lock");
 
-	if (!gpc->memslot)
+	if (!gpc->memslot || gpc->never_dirty)
 		return;
 
 	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpa_to_gfn(gpc->gpa));
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index 31f3eb0dd2aa..22393f97266a 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -109,6 +109,7 @@ struct gfn_to_pfn_cache {
 	 * instead.
 	 */
 	atomic_t state;
+	bool never_dirty;
 };
 
 /* The cache is valid: pfn and khva may be used by readers. */
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index a6a7cfd13246..97958af667fb 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -597,7 +597,8 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva);
 }
 
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
+void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
+		    bool never_dirty)
 {
 	mutex_init(&gpc->refresh_lock);
 
@@ -607,6 +608,7 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 	gpc->uhva = KVM_HVA_ERR_BAD;
 	gpc->active = false;
 	atomic_set(&gpc->state, 0);
+	gpc->never_dirty = never_dirty;
 }
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
-- 
2.55.0

