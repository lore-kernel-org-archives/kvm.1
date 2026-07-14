Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A6429CFF
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070635; cv=none; b=UAOjnwQj2GZPD8r0BBt5wj31f4q56NQbsOV5ACjeVvGsXoonuJh4/Zc72w+a07uX0qJzXsti7dmBtOSrfkjDmGvjk3njGykDlK2ue6UL4KEWRIdMYGdQIBdFzkahU6NNI5o6AXghY4o5cwFT+jXEsuWKvA7lq+YAn21MORq7xCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070635; c=relaxed/simple;
	bh=UkkyQjvqNT2W6S+i7qozEefyt3of6Y2gOwMbSYTJvLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QsBCHJ/8MBXppslCepc/c82EiYUwHhhE+gDG3On4t8jG/2TzQInEXI95Piat6ahMesTzhGGE30EEW/4JPR9iNaNjqDzn7MJ+xld7ObtBypIIMyA63rsK1/2xN0ZOFD/UNNYxChzee6NnijOP26T62OP2VvSian7fAyv4OVwmSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoTW59HO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoTW59HO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38dc4401dc7so1620095a91.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784070628; x=1784675428; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VgYwcrtH4ra6/vlAi0spcnkFJPt2G+1EVF5ztYS5YEE=;
        b=OoTW59HOEe/qRMPKaHvBGMZ0TgGboVyNAx3vr0l4Et14SKpY9GP3FseUR771zc3n84
         jZHAwynHdsuuagcy3VouVVXtj4W8oP1gD6syCv7MCEWupEx/mgp9ikCffN6mR8el7uue
         ufbK9dJS5qCzEv/hJOFaJ3AdMYTjd+X8sT6WCS8xPEXsWBUbOi94E/FDCHXD3aBOEwa+
         grFvzPZA7HSVqFMvuWzDdyvshwnokXHX23IUmImzYjvIjberYIkafQsuYF6jxfKx78UO
         Ta3aaB7oKo4NWbjkqyfJV9r/D0x7XauATw24JFMgGKFoebWk9TpTsxgoVpThSuFpjulk
         ffWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070628; x=1784675428;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VgYwcrtH4ra6/vlAi0spcnkFJPt2G+1EVF5ztYS5YEE=;
        b=OljbvleHXYjd+F5xK0Twbc3jyThrWJvbd/wwqk4ZlF6lbnK/Umyf6cyvFih6/TWu0O
         vWL7u4H6FG028N51UjBg5TehhYCsqDeFomKcpTx8L1IJnJybrryrHDjqB2m9ny/F9A7X
         1mBUMpNM4Qu3UIHaLlOBI45Y92fbfPxtHSAcFkofjt6v7ZzQgqE9XJ8I8sCF3Mq1pSea
         R8Mx86V3qVc+HkPZhXQMHu/1pfJLA4nC5pOFRL7FU5fcSd73bvZgYCKSytIVufER73pG
         hAd4KT700ju01YKDW6UWMZHj7D/7JqaNUZCTuFVZOgEJ61yZkJXobFMJk6zYS9+rnGFF
         2jKA==
X-Gm-Message-State: AOJu0YzKHer7NsSjyJNY4A1AphFdmeWgdOUVGVTTasLvPoNcNIk5w2Za
	W8b3tl3hOxwg1BgjFuNIuLLvFoKPMXhZgxsFtrK/j1YuvktCEErd4gr0eqI18Bq068tqNNH1BVp
	XHGGvkA==
X-Received: from pjyj22.prod.google.com ([2002:a17:90a:e616:b0:381:171e:961c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:554e:b0:387:e0db:bc30
 with SMTP id 98e67ed59e1d1-38dc7bb6bf8mr13572712a91.38.1784070628299; Tue, 14
 Jul 2026 16:10:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 16:10:10 -0700
In-Reply-To: <20260714231015.3337831-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714231015.3337831-3-seanjc@google.com>
Subject: [PATCH v5 2/7] KVM: guest_memfd: Rename invalidate() arch hook to
 reclaim() and isolate it
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename guest_memfd's invalidate() hook to reclaim() and isolate it via its
own RECLAIM Kconfig, as the hook is called when a folio is freed, which is
far too late and lacks sufficient information for KVM to actually
invalidate its usage of the memory.  E.g. SNP uses the hook to convert
memory back to SHARED so that it can be safely accessed by the host, there
is no invalidation of guest mappings anywhere.  Isolating the hook will
also allow pKVM on arm64 to opt-in to reclaim() without also having to
differentiate between reclaim and conversions to shared for active VMs.

Keep guest_memfd's trampoline, even though it would be trivial to wire up
.free_folio() directly to an arch callback, to avoid bleeding guest_memfd
internals into arch code (specifically, avoid referencing folios in arch
code).

Leave the kvm_x86_ops hook as-is for the moment, as the hook can be dropped
entirely ("reclaim" on SNP is the same as convert-to-shared).

Cc: Fuad Tabba <tabba@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig     | 1 +
 arch/x86/kvm/x86.c       | 7 +++++--
 include/linux/kvm_host.h | 5 ++++-
 virt/kvm/Kconfig         | 4 ++++
 virt/kvm/guest_memfd.c   | 8 ++++----
 5 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 801bf9e520db..e0e7ad015839 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -161,6 +161,7 @@ config KVM_AMD_SEV
 	select ARCH_HAS_CC_PLATFORM
 	select KVM_GENERIC_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_PREPARE
+	select HAVE_KVM_ARCH_GMEM_RECLAIM
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
 	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a2cbf6fae118..08d24c6fffa4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10626,11 +10626,14 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 }
 #endif
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
 {
 	kvm_x86_call(gmem_invalidate)(pfn, pfn + nr_pages);
 }
+#endif
+
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	kvm_x86_call(gmem_invalidate_range)(kvm, range);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 996b39ebdb68..ee87ddd3294f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2613,8 +2613,11 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 		       kvm_gmem_populate_cb post_populate, void *opaque);
 #endif
 
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int order);
+#endif
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int order);
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 794976b88c6f..617876993225 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -111,6 +111,10 @@ config HAVE_KVM_ARCH_GMEM_PREPARE
        bool
        depends on KVM_GUEST_MEMFD
 
+config HAVE_KVM_ARCH_GMEM_RECLAIM
+       bool
+       depends on KVM_GUEST_MEMFD
+
 config HAVE_KVM_ARCH_GMEM_INVALIDATE
        bool
        depends on KVM_GUEST_MEMFD
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 99c070bfd446..d5d227476cda 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -527,11 +527,11 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	return MF_DELAYED;
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 static void kvm_gmem_free_folio(struct folio *folio)
 {
-	kvm_arch_gmem_invalidate(folio_file_pfn(folio, 0), folio_nr_pages(folio),
-				 folio_order(folio));
+	kvm_arch_gmem_reclaim(folio_file_pfn(folio, 0), folio_nr_pages(folio),
+			      folio_order(folio));
 }
 #endif
 
@@ -539,7 +539,7 @@ static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 	.free_folio = kvm_gmem_free_folio,
 #endif
 };
-- 
2.55.0.141.g00534a21ce-goog

