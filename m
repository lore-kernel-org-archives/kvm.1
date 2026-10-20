Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502104;
	b=iCk91iRRTL4YwjRXUFml2WBbE2JKYNEbVNx17YzsoEtskz64RFMLOHOQcfCLD/bgEEeZ
	 dl1R4Uk1FHWtcOvUkg9tD76ePnPP5L854NH7RQlg0I0UKD7i5I/X4H9JjIIkU1LEXOH+O
	 RJ08MTH7Z11p2waATu9Dp4UNOMGNv3E0l6HSyqFhkIyH/lUgKFwafANs5W/LknjOvq+iV
	 HduFHx9kHZqx/KkPPx/FTdbPZ8Hz6ywMbnqtCkrlIO9/xKFM8RqQ0ea1m0P3FZOw/v8M6
	 7hGbWHz8V1oUu8rSwYQv5EKx/iFU2KUoifSe51D3wVajQfXb4FpIxMIadiwQp8rkfCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502104;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=tsfijHWj5yiL3PfPaMBC2xoqgBnzTVwpsDkyBfvT4BM=;
	b=FS0lOXVJctrHAUjdYNtAi7pKHcXAWJEkqiPSuwe+qYy4NS/ZXBG557ZMrD0AobTw+CU6
	 3HRK07W8iNpq1/b/eyTZVeoEA1kxwyUNIo89bNKQMCESAQxQNMAlOD4GSC5SEa6aY8JWy
	 z0mseN0lIfOl7kt0vxsCN9H4RZqRN80ZiYSqIartAu8fZnMDvoN2pCbnTK9i8+Pr4Whs4
	 VoVGAg+jhAYd+a0Y/2P212Nk/5PFRylNkZGQBbsXDBDZM22il50CCoQk8lWhxskql69Be
	 GADkXoaiN1lolMMFyglNjNWri9zQc0KNtJUfd9/i/iyQFpnI6Kpg4G3qlqpOf3PpstQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QZml+izb;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E578606A32F
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 13:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E578606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QZml+izb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792502102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsfijHWj5yiL3PfPaMBC2xoqgBnzTVwpsDkyBfvT4BM=;
	b=QZml+izb0XwB56O3YDVTzR8HgB+srztrK4XaYHzKH7xS5TnSIK6f+ejQGvCMc5IiSjUlNa
	Vk7ALN2ZuDGh7gK7o3uixLWPaqbwSXIi6UF3xBrrAUiBmXTflImy2r/JrgYV5g9yPCOEQZ
	2+8OCFaZm7kJyqaRkXJw9tevgbe+UUY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-oIp48KxdMl-T4I5atqLrpw-1; Tue,
 20 Oct 2026 13:14:52 +0000
X-MC-Unique: oIp48KxdMl-T4I5atqLrpw-1
X-Mimecast-MFC-AGG-ID: oIp48KxdMl-T4I5atqLrpw_1792502091
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 073E518052E5;
	Tue, 20 Oct 2026 13:14:51 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA3CF1800257;
	Tue, 20 Oct 2026 13:14:49 +0000 (UTC)
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
Subject: [PATCH 1/3] KVM: split CONFIG_KVM_PRIVATE_MEMATTR_VM out of KVM_VM_MEMORY_ATTRIBUTES
Date: Tue, 20 Oct 2026 09:14:45 -0400
Message-ID: <20261020131447.122096-2-pbonzini@redhat.com>
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

With Linux 7.4 the "private" memory attribute was moved from the VM
to the individual guest_memfd file descriptor.  The old semantics are
available for backwards compatibility via CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

However, this ties support for VM memory attributes entirely to
a backwards compatibility symbol, which is a problem when adding
VM memory attributes other than PRIVATE.  Thus, make
CONFIG_KVM_VM_MEMORY_ATTRIBUTES the equivalent of the old
CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES, and use a more descriptive name
for the private memory attribute.  Do this now, instead of waiting
for more attributes to come, before distros start adjusting
their build configuration.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 arch/x86/kvm/Kconfig                            | 3 ++-
 include/linux/kvm_host.h                        | 4 +++-
 virt/kvm/Kconfig                                | 3 +++
 virt/kvm/kvm_main.c                             | 6 +++---
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 410a3eed3a3d..42ff19defe16 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3178,8 +3178,8 @@ Kernel parameters
 			userspace VMM design.
 
 			Note, this parameter is only available when
-			CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
-			CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
+			CONFIG_KVM_PRIVATE_MEMATTR_VM=y. When
+			CONFIG_KVM_PRIVATE_MEMATTR_VM is not set, in-place
 			conversion is enabled (and cannot be disabled) if KVM
 			is built with private memory support.
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 796d33f629d3..01a683a9042a 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -76,9 +76,10 @@ config KVM_WERROR
 
 	  If in doubt, say "N".
 
-config KVM_VM_MEMORY_ATTRIBUTES
+config KVM_PRIVATE_MEMATTR_VM
 	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
 	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
+	select KVM_VM_MEMORY_ATTRIBUTES
 	help
 	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
 	  memory attributes.  Using per-VM attributes is deprecated in favor of
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4d4e76a50d77..09c57d31d153 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2582,12 +2582,14 @@ bool kvm_arch_pre_set_vm_memory_attributes(struct kvm *kvm,
 					   struct kvm_gfn_range *range);
 bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
 					    struct kvm_gfn_range *range);
+#endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
+#ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
 static inline bool kvm_vm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
-#endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
+#endif  /* CONFIG_KVM_PRIVATE_MEMATTR_VM */
 
 #ifdef kvm_arch_has_private_mem
 extern bool gmem_in_place_conversion;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index c5bfaa1f7749..99c9969e77a4 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -101,3 +101,6 @@ config HAVE_KVM_ARCH_GMEM_INVALIDATE
 config HAVE_KVM_ARCH_GMEM_POPULATE
        bool
        depends on KVM_GUEST_MEMFD
+
+config KVM_VM_MEMORY_ATTRIBUTES
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a97aa5b92616..3e35766f5c7e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -105,8 +105,8 @@ static bool __ro_after_init allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
 #ifdef kvm_arch_has_private_mem
-bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_PRIVATE_MEMATTR_VM);
+#ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
 module_param(gmem_in_place_conversion, bool, 0444);
 #endif
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
@@ -2713,7 +2713,7 @@ static void kvm_init_memory_attributes(void)
 {
 	if (gmem_in_place_conversion)
 		static_call_update(__kvm_is_private_gfn, kvm_gmem_is_private_gfn);
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
 	else
 		static_call_update(__kvm_is_private_gfn, kvm_vm_is_private_gfn);
 #endif
-- 
2.52.0


