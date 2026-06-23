Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1324D363C6A;
	Tue, 23 Jun 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206165; cv=none; b=kNGYWXsNr+yZifHqzRbZXAz2gX2NRj1aHSkx2aj42Ze4TXoMbKjhIfLtvnqtnoXpcxrWTsdUbT8W/i8i7Rc4iWiO3hq3hP0K0v4951eat1yHvoD05jmtquQzJoCBWL+zp8iASklSDtp8lL56oaoKNRgU/+1bDe+96nd02bp1VsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206165; c=relaxed/simple;
	bh=woSZT/9pDCXxSsP4glVhuBhl2ALgJ2lKgcEJJCB2crA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv5CVcINvb1saLNUpVuo3OFGg7dMEXxvApCSardziEuGw+eN2ZLjfR4ipJ22QvKclEtB8SbQiE4AdZSz8d9ztEaGvhrln+66qv+oYZkWAhwjtqQKeDS/+NfAfGbC0HMzKNXcrUDvguuAN+3A5WfL1aADvUt/wmjk8HccSYx+syo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af4fc500cc95bb0c16cd4e45.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:cc95:bb0c:16cd:4e45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 49736203D41;
	Tue, 23 Jun 2026 11:16:03 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 3/4] KVM: guest_memfd: Add `write` parameter to kvm_gmem_populate()
Date: Tue, 23 Jun 2026 11:15:55 +0200
Message-ID: <20260623091556.1500930-4-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623091556.1500930-1-joro@8bytes.org>
References: <20260623091556.1500930-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

The call-path of kvm_gmem_populate() might subsequently write to the
page provided by user-space. This is used to provide detailed error
information in case the page population failed.

But since kvm_gmem_populate() only acquires a read-only reference to
the user-space page via get_user_pages_fast(), the error information
might be written to a read-only page later on.

Add a parameter to kvm_gmem_populate() to optionally acquire a
writeable reference to the source page to make sure page permissions
can be enforced.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/sev.c   | 2 +-
 arch/x86/kvm/vmx/tdx.c   | 2 +-
 include/linux/kvm_host.h | 4 +++-
 virt/kvm/guest_memfd.c   | 4 ++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f09d15f68964..dab8109edf26 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2475,7 +2475,7 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	sev_populate_args.sev_fd = argp->sev_fd;
 	sev_populate_args.type = params.type;
 
-	count = kvm_gmem_populate(kvm, params.gfn_start, src, npages,
+	count = kvm_gmem_populate(kvm, params.gfn_start, src, npages, 0,
 				  sev_gmem_post_populate, &sev_populate_args);
 	if (count < 0) {
 		argp->error = sev_populate_args.fw_error;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 04ce321ebdf3..46b1d84fddf2 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3185,7 +3185,7 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 		};
 		gmem_ret = kvm_gmem_populate(kvm, gpa_to_gfn(region.gpa),
 					     u64_to_user_ptr(region.source_addr),
-					     1, tdx_gmem_post_populate, &arg);
+					     1, 0, tdx_gmem_post_populate, &arg);
 		if (gmem_ret < 0) {
 			ret = gmem_ret;
 			break;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c14aee1fb06..622c0b04d8c3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2581,6 +2581,8 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
  *       (passed to @post_populate, and incremented on each iteration
  *       if not NULL). Must be page-aligned.
  * @npages: number of pages to copy from userspace-buffer
+ * @write: user-space provided buffer must be writable. The function
+ *	 will acquire a writable reference when set to 1.
  * @post_populate: callback to issue for each gmem page that backs the GPA
  *                 range
  * @opaque: opaque data to pass to @post_populate callback
@@ -2597,7 +2599,7 @@ typedef int (*kvm_gmem_populate_cb)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 				    struct page *page, void *opaque);
 
 long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages,
-		       kvm_gmem_populate_cb post_populate, void *opaque);
+		       int write, kvm_gmem_populate_cb post_populate, void *opaque);
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b2..7a245a402a1b 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -859,7 +859,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 }
 
 long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
-		       kvm_gmem_populate_cb post_populate, void *opaque)
+		       int write, kvm_gmem_populate_cb post_populate, void *opaque)
 {
 	struct kvm_memory_slot *slot;
 	int ret = 0;
@@ -893,7 +893,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 		if (src) {
 			unsigned long uaddr = (unsigned long)src + i * PAGE_SIZE;
 
-			ret = get_user_pages_fast(uaddr, 1, 0, &src_page);
+			ret = get_user_pages_fast(uaddr, 1, write, &src_page);
 			if (ret < 0)
 				break;
 			if (ret != 1) {
-- 
2.53.0

