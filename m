Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641518;
	b=AeFAcpcVRUfni6K+bhXeQ7nWgq+vqOojl19+Pl6wk0TGCoWUz/rB/f7q0inZk9vXXA6W
	 BWsHTtfY5jg6IGtXTSYvxJoQX5aqcB517FjM7aQO/0NKj4wN8QlOgZvmIXnzUcwNrbwLG
	 o5uow992rKNTRCHTFJLTJC5f+4c0hosL2MacH94rnZQAsWK14oYHchcB6zDAs0XVKsqH3
	 VGMt1MH7D9vMSEmnQ3cb4olE6FfCH5aHOjjHa5BnNkzias15/m5ebJE9XHKWivZ5pL6nc
	 NXBxBTcN4Iha1EKMCXRWRYtj/3ytU+rGo9G7fPkveByMXDIw2xDd2o2ciWFCGDbezRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641518;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=57hzFQ9aHNHxTZLbv0cg8SsM/1NYNPFtfAgwV5HFcz4=;
	b=L2FpJVLxtMW5NAF8QYsw52OMbOgTdVOG3BNkhtMlJ1hs1jP/OcjkHlBgXsYipmCCy+VU
	 BZjtNKwVe2KHKx9GOSqZ08yFeGrlsPM2zCtfa92wQAEvq38rSlftPuCRVtYpxR+7DxOAa
	 ltuPQiu3QJ1Zi3MDL5SsOK0nGQAb269MUutXlT2NM2j/buzQ25DUHnGG2rRxpYeXzQgSy
	 3ISCxLKC/gkY5Dv/oS8FQoWvt8H+2Mzr2BRLQrSsUiClOvlcu4qgfucJqgSgHHaddqDDN
	 nqXz78CPwBWyF6P4a4R9/67qTvSqQWgSoz5+wYUx2OsSWkUGFFhzTYtseZD6ubAq1KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="f4/ZQDOS";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA8606D838
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66FA8606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f4/ZQDOS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57hzFQ9aHNHxTZLbv0cg8SsM/1NYNPFtfAgwV5HFcz4=;
	b=f4/ZQDOSFbTxiIL4POqqm5CF4+RkDl48qC3yITlEnR9+CDPZKuyD0wtfNQ/C3Y76NHGpSG
	JTsCtAZmBbbpO0wsm1fGC3BMMVD/hIiWU0GyCVHu00mzrA+qIAhXKixNLbivnYQDGOhgF6
	zFDgcfk4eEAextS1aSJdPXT9W+Ofqr8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-F9tak6jGNSWPqjdqz1LZlQ-1; Mon,
 02 Nov 2026 12:45:16 -0500
X-MC-Unique: F9tak6jGNSWPqjdqz1LZlQ-1
X-Mimecast-MFC-AGG-ID: F9tak6jGNSWPqjdqz1LZlQ_1793641515
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 264001955E96;
	Mon,  2 Nov 2026 17:45:15 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9142C195608B;
	Mon,  2 Nov 2026 17:45:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 19/45] KVM: Introduce kvm_fetch_guest_page() and use it for x86
Date: Mon,  2 Nov 2026 12:44:46 -0500
Message-ID: <20261102174512.8903-3-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Introduce a separate function so that the emulator will be able to take
into account execution memory attributes rather than read.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-16-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c       | 4 ++--
 include/linux/kvm_host.h | 2 ++
 virt/kvm/kvm_main.c      | 9 +++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 63d48ac4e1c6..ab7a859dda79 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4916,8 +4916,8 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 	offset = addr & (PAGE_SIZE-1);
 	if (WARN_ON(offset + bytes > PAGE_SIZE))
 		bytes = (unsigned)PAGE_SIZE - offset;
-	ret = kvm_vcpu_read_guest_page(vcpu, gpa >> PAGE_SHIFT, val,
-				       offset, bytes);
+	ret = kvm_vcpu_fetch_guest_page(vcpu, gpa >> PAGE_SHIFT, val,
+					offset, bytes);
 	if (unlikely(ret < 0))
 		return X86EMUL_IO_NEEDED;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3791e4290742..1974cd8d361f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1456,6 +1456,8 @@ DEFINE_VCPU_MAP_CLASS(_readonly);
 
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
+int kvm_vcpu_fetch_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
+			      int offset, int len);
 int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data, int offset,
 			     int len);
 int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa, void *data,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d3f074d7fd6f..41818ed5eb3a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3398,6 +3398,15 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_page);
 
+int kvm_vcpu_fetch_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
+			      int offset, int len)
+{
+	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+
+	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_fetch_guest_page);
+
 int kvm_read_guest(struct kvm *kvm, gpa_t gpa, void *data, unsigned long len)
 {
 	gfn_t gfn = gpa >> PAGE_SHIFT;
-- 
2.52.0


