Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641303;
	b=4jLHogp05i6y1e/89+u3W4baW1DFk7jVIpZyKnT4+E5TBpymBzNCZfzhs+vNntfleA9T
	 l+nguCioiHgbkNSwzf5FyOS61NdEfKDGr4gS/VCUFFbZCv0PD+pOs2IEwBwxz3nLu30sj
	 huu/KXJgPBG6hiBydsUhqUSSICloKwRrxSVwzKmCaXx0i7PFD6VSZdiom4tYuo11tyjZ7
	 6HbLx3SPyW+8pg0UrRKMP1TOw77LI6BZE3xwPSQAN8YquMQKYgFgRXD3T83dlZ80Jb/6z
	 AN/BVBzJ8fEr0lmJLZykOyRTSErh4W5tI/5lKw/UUswm8Wco7eac+FaSMqA/OSSFMqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641303;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=FOYEkGmoQHAdW6dClUNHWKW771i/hP3Ezfm16raQjns=;
	b=kWZslqvTJf2iWSQqqK2OMqY7y80yH1u7Vo94mLlxSlD9XKAyM2e/MARvTHlDq6p+WlCD
	 zRzEPMHbg7V9x2zT9YARpVPExTgZ/Hy2Aqx8CZp2jl8OpC9SqyiTaP2/3jy3Zqmgjb2r5
	 TKeKnXEJ1PlZOIHgntYC1QMss0TRuD3WmPnZ0Udedt203YlUFWv2NF9E9XpuoJhp/RLxb
	 LuM0PwV6U/OzYvoKTOFSYfM0FpoLC8lHz+YK9r5dkwXvVVG67GTBXlg+6WaiSScy42++4
	 JbCjtub62JNcRgJUI+sI9v+AA3FpE+lqVN+wfU7xjfk+H68o67P9iLxF2aA+bHZy+ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AhAbhKc7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088286072230
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 088286072230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AhAbhKc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOYEkGmoQHAdW6dClUNHWKW771i/hP3Ezfm16raQjns=;
	b=AhAbhKc7VGZn5Vusno1D2czFNXTzbCCOVdPJPEhcU2XUtfv3Zjr3PT/tUjvJWS56GYHCk2
	uMT20DIBdYmtJsPYbRtJZsKSaZgPYqWqmeTtUS9h9Zv4Nu/prVvqPnBiEpIUPD3aLLHSH1
	GswLH6Vx43OkfSmq30KxWCuc9AbbL8U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-Mhbcu1qvMcek65bVj2ef7w-1; Mon,
 02 Nov 2026 12:41:41 -0500
X-MC-Unique: Mhbcu1qvMcek65bVj2ef7w-1
X-Mimecast-MFC-AGG-ID: Mhbcu1qvMcek65bVj2ef7w_1793641300
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E97741801239;
	Mon,  2 Nov 2026 17:41:39 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6271E18005AD;
	Mon,  2 Nov 2026 17:41:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 14/45] KVM: x86/mmu: Init memslot hugepage information for non-private_mem VMs too
Date: Mon,  2 Nov 2026 12:40:58 -0500
Message-ID: <20261102174130.8779-15-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

The list of supported memory attributes is about to grow, and they will
be available on any VM type (as opposed to only ones targeted at
confidential computing). As such, update the check in
kvm_mmu_init_memslot_memory_attributes() to initialize huge page
information if any kind of memory attributes is available for the VM.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-11-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c   | 3 ++-
 include/linux/kvm_host.h | 6 ++++++
 virt/kvm/kvm_main.c      | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5be24b67f212..3755393de4ca 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8361,7 +8361,8 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
 {
 	int level;
 
-	if (!kvm_arch_has_private_mem(kvm))
+	if (!kvm_arch_has_private_mem(kvm) &&
+	    !kvm_supported_vm_mem_attributes(kvm))
 		return;
 
 	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5e386c3d2495..3d0293ebc864 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2589,6 +2589,12 @@ bool kvm_arch_pre_set_vm_memory_attributes(struct kvm *kvm,
 					   struct kvm_gfn_range *range);
 bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
 					    struct kvm_gfn_range *range);
+u64 kvm_supported_vm_mem_attributes(struct kvm *kvm);
+#else
+static inline u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
+{
+	return 0;
+}
 #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..2fd595a901bd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2474,7 +2474,7 @@ static u64 kvm_supports_private_mem(struct kvm *kvm)
 #endif
 
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
-static u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
+u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
 {
 	if (gmem_in_place_conversion || !kvm_supports_private_mem(kvm))
 		return 0;
-- 
2.52.0


