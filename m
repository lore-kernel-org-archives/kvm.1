Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B90443A8D
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225709; cv=none; b=WyyRUfCe6xHUNXQ38t/V+FXMlUnv0RLgR9sHiENh4WeiN87bz0CKRjbytkMI/VWKyX1VmD1lQG+i1/+FXME4JBtk9/HwcMJRDnLxklZghkR9PrZ/JbDx7KkaGQwdLjHIS8VszvhVUCREAiUDEOrPVx1cH9JT8FQIcMT7yoGNURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225709; c=relaxed/simple;
	bh=a8PF7SbM0fd04w0iq2kodW9LEQN4/g9z3k0clpm7csA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzSy1oxkRaJPzhRbMf39EgtIoksSZohAmv1/cEiggdBiFfYgUXONtjhQuzWzm8apq13W1KpzQUG2+djfK44qLytJmntui+zMh9HkPECNKhrMPSj61tFmYf4P2uNn+ZikzSTWzKjqQYrf3dQvHTKtYG3R2RglzhXM9spNuHzaKqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYSkxA7W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYSkxA7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNzIu7vEv4oBxoHkiuC1yFCUUcwdFOHiiEk7gNbeV+M=;
	b=RYSkxA7WeTKq9iX7d7cRrgKLvT3SldPQ7T+A1A7KKfg4kZYH7Nq2Lrqs9n2Ri2/G3hRMdx
	GI+bAfwCi6za0ASnnoxQQ6UvdG3qda3frF6ymbw/gsBsA3xr9POl6JG7KdGh+DtEl4vMYq
	hbg7ePJgLnQxpDt5ZwjXoYfvw693m2g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-tNiJotxWN2iLopizr2b6qA-1; Thu,
 16 Jul 2026 14:15:01 -0400
X-MC-Unique: tNiJotxWN2iLopizr2b6qA-1
X-Mimecast-MFC-AGG-ID: tNiJotxWN2iLopizr2b6qA_1784225700
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 128FF1800667;
	Thu, 16 Jul 2026 18:15:00 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E068195604E;
	Thu, 16 Jul 2026 18:14:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 03/24] KVM: x86: hyperv: Introduce memory fault on hcalls with bad ingpas
Date: Thu, 16 Jul 2026 14:14:35 -0400
Message-ID: <20260716181456.402786-4-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/hyperv.c           | 32 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |  7 +++++++
 include/uapi/linux/kvm.h        |  1 +
 4 files changed, 41 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b517257a6315..d0c1d0ab03c2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1274,6 +1274,7 @@ struct kvm_hv {
 	struct kvm_hv_syndbg hv_syndbg;
 
 	bool xsaves_xsavec_checked;
+	bool hcall_fault_exit;
 };
 #endif
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 1ee0d23f8949..d688759df081 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2531,11 +2531,30 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 	return true;
 }
 
+static unsigned int kvm_hv_hypercall_mem_access(u16 code)
+{
+	switch (code) {
+	case HVCALL_SIGNAL_EVENT:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE:
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
+	case HVCALL_SEND_IPI:
+	case HVCALL_SEND_IPI_EX:
+		return KVM_MEMORY_EXIT_FLAG_READ;
+	}
+
+	return KVM_MEMORY_EXIT_FLAG_WRITE;
+}
+
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	struct kvm *kvm = vcpu->kvm;
 	struct kvm_hv_hcall hc;
 	u64 ret = HV_STATUS_SUCCESS;
+	unsigned int access;
+	unsigned long addr;
 
 	/*
 	 * hypercall generates UD from non zero cpl and real mode
@@ -2590,6 +2609,19 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		kvm_hv_hypercall_read_xmm(&hc);
 	}
 
+	if (!hc.fast && kvm->arch.hyperv.hcall_fault_exit) {
+		bool writable = true;
+		access = kvm_hv_hypercall_mem_access(hc.code);
+		addr = kvm_vcpu_gfn_to_hva_prot(vcpu, gpa_to_gfn(hc.ingpa), &writable);
+		if (addr == KVM_HVA_ERR_BAD ||
+		    (access == KVM_MEMORY_EXIT_FLAG_WRITE && !writable)) {
+			kvm_prepare_memory_fault_exit(vcpu, hc.ingpa, PAGE_SIZE,
+						      access == KVM_MEMORY_EXIT_FLAG_WRITE,
+						      false, false);
+			return -EFAULT;
+		}
+	}
+
 	switch (hc.code) {
 	case HVCALL_NOTIFY_LONG_SPIN_WAIT:
 		if (unlikely(hc.rep || hc.var_cnt)) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..352d289076f6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2224,6 +2224,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_CPUID:
 	case KVM_CAP_HYPERV_ENFORCE_CPUID:
 	case KVM_CAP_SYS_HYPERV_CPUID:
+	case KVM_CAP_HYPERV_HCALL_FAULT_EXIT:
 #endif
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
@@ -4190,6 +4191,12 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_unlock(&kvm->lock);
 		break;
 	}
+#ifdef CONFIG_KVM_HYPERV
+	case KVM_CAP_HYPERV_HCALL_FAULT_EXIT:
+		kvm->arch.hyperv.hcall_fault_exit = cap->args[0];
+		r = 0;
+		break;
+#endif
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 720b1ffe880b..3b235e953923 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1000,6 +1000,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_HYPERV_HCALL_FAULT_EXIT 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.52.0


