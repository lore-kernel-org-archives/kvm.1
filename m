Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502105;
	b=lY+rQPTbIwhKoX3jiWnivVQcqkxq9K35hYFIRfhPaAuqgMUA4L1aQOkKJPcSoUkm7aTw
	 tnGAEhkesKjCG/1p1poZw1XGlIiRpAsgFy6iuAcDGIf5c4/wD1llYiC5r88yqofIl5T6C
	 N1WCWhK1tYaX5l/wX7lKBlM+yW0IZxIvb91fSvNFBliZorWZe2sr7l9SDLPLL4ujQ3UAE
	 2PMX8kUXmI3hmK0vyeFMY1vfQWlXvQWevce7bweRfOey4Fjx81/wcFW7IjiAMS2R+Wu8F
	 p8KONbqQGWBoQnK8z8qIdAp2kps/unAcu0eDeOS00POw1zHfVmQhrtbt407nFbvcatA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502105;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=wuHPetm5Hb7ibKe3xHEO7sF7ztYpaU2uZ5fmHRe9Uro=;
	b=00TYIECQLeBJBuFmHMvDPcfZETPlZvuRZkwO0e7Y27AtpEGl33eIvTVTArLEmjVKhYNO
	 ei3AI75CRFXce4Cv8cOl91Khw/q92Cd5pK1LYqWlTYpoVtMMoXRj3M8uHCeoR4RmXr/3P
	 KU+liPrpRdufCTIH+u2bZV6gy51mxo5Z+xpmNchjYRUQoKUM4rKfvfHuJPFpDJ9uuC/dG
	 xoynLRkIFgj+jmqJfDufo4VO43NIKqlnhgwguLizpHXNgyra/hHtVnPx66witC+wvDzjh
	 28qr60pXPi/0y3d3zivnb+1GEz5rI04GiCFNjd3gyw7T+oZbsRsP5ErJ/NojWbolGOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c1E1RWgH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025DC606A331
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 13:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 025DC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c1E1RWgH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792502104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuHPetm5Hb7ibKe3xHEO7sF7ztYpaU2uZ5fmHRe9Uro=;
	b=c1E1RWgH5uap556oiRkCZbes64pgtafscADb7i7C4/x9Ty8ElX/U3AlvgDY9XE8we8FyZE
	vjUaOQQL7n0xSVlT3UdzlrByk3CKVsc4Yg3YK4japkpUV7aY5FMx3/Ss9p67Gb/iXSdiFR
	mxG6k6R1qhkORQYEtchEIRrXm1bcQnY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-biXO6FXcOvW1x_kpDJyERg-1; Tue,
 20 Oct 2026 13:14:55 +0000
X-MC-Unique: biXO6FXcOvW1x_kpDJyERg-1
X-Mimecast-MFC-AGG-ID: biXO6FXcOvW1x_kpDJyERg_1792502093
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5489319540D6;
	Tue, 20 Oct 2026 13:14:53 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47DF21803A55;
	Tue, 20 Oct 2026 13:14:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Shivank Garg <shivankg@amd.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 3/3] KVM: always make in-place conversion a compile-time constant when possible
Date: Tue, 20 Oct 2026 09:14:47 -0400
Message-ID: <20261020131447.122096-4-pbonzini@redhat.com>
In-Reply-To: <20261020131447.122096-1-pbonzini@redhat.com>
References: <20261020131447.122096-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Remove the unnecessary static call indirection and make
gmem_in_place_conversion a constant if CONFIG_KVM_PRIVATE_MEMATTR_VM
is false.

Require that CONFIG_KVM_PRIVATE_MEMATTR_VM is y only if
kvm_arch_has_private_mem is also defined.  This way, the three
possible cases can be expressed without nested #ifs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h | 13 +++++--------
 virt/kvm/kvm_main.c      | 13 +++++++------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 09c57d31d153..e7fc94e2910a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2585,15 +2585,7 @@ bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
 #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
-static inline bool kvm_vm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
-{
-	return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
-}
-#endif  /* CONFIG_KVM_PRIVATE_MEMATTR_VM */
-
-#ifdef kvm_arch_has_private_mem
 extern bool gmem_in_place_conversion;
-
 typedef bool (kvm_is_private_gfn_t)(struct kvm *kvm, gfn_t gfn);
 DECLARE_STATIC_CALL(__kvm_is_private_gfn, kvm_is_private_gfn_t);
 
@@ -2601,6 +2593,11 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	return static_call(__kvm_is_private_gfn)(kvm, gfn);
 }
+
+#elif defined kvm_arch_has_private_mem
+#define gmem_in_place_conversion true
+#define kvm_is_private_gfn kvm_gmem_is_private_gfn
+
 #else
 #define gmem_in_place_conversion false
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3e35766f5c7e..a356a29be985 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -104,11 +104,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
 static bool __ro_after_init allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
-#ifdef kvm_arch_has_private_mem
-bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_PRIVATE_MEMATTR_VM);
 #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
+bool __ro_after_init gmem_in_place_conversion = false;
 module_param(gmem_in_place_conversion, bool, 0444);
-#endif
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
 #endif
 
@@ -2705,18 +2703,21 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
-#ifdef kvm_arch_has_private_mem
+#ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
 DEFINE_STATIC_CALL_RET0(__kvm_is_private_gfn, kvm_is_private_gfn_t);
 EXPORT_STATIC_CALL_GPL(__kvm_is_private_gfn);
 
+static bool kvm_vm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
+{
+	return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
+}
+
 static void kvm_init_memory_attributes(void)
 {
 	if (gmem_in_place_conversion)
 		static_call_update(__kvm_is_private_gfn, kvm_gmem_is_private_gfn);
-#ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
 	else
 		static_call_update(__kvm_is_private_gfn, kvm_vm_is_private_gfn);
-#endif
 }
 #else
 static void kvm_init_memory_attributes(void) { }
-- 
2.52.0

