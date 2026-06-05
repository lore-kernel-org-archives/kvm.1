Received: from smtp186.sjtu.edu.cn (smtp186.sjtu.edu.cn [202.120.2.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2853B841B;
	Fri,  5 Jun 2026 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652388; cv=none; b=B/xu94Ee7ZzJioH3ZWuO/kItaY8rXDKvu1X5gGgTglZONQTLCJ9Mj1g5Pfjq5uIJzG4bHUpmxD+e9jtKkePzROX+mXu+mv1/AcQovWIasfHRllLv5Iq+h4GEVBQRqibwWgGn8BmZrEzKeef+kLMp7VRo4bzGlEcDVy2pXNIBsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652388; c=relaxed/simple;
	bh=91I8gKovLUZ0ITZOyIiUijFIcgcDYuZYN++HHQn56Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+5sptjPiNN98jiK9mkTdLx5JFw7SMXgcThq9kAurtjJreHKauFPPME/kykdRIK6/tnI6thvFdp9ywnM7cw6Zh6rw05kGkn5d1XoSP+HF6CitqXMjJmTIKUcifB6/Wf23JK4rPz7kDC6YffVUq0u7LzlVMWe3HuUTukgX+9TOzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b=cf1tKtLO; arc=none smtp.client-ip=202.120.2.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b="cf1tKtLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
	s=default; t=1780652347;
	bh=91I8gKovLUZ0ITZOyIiUijFIcgcDYuZYN++HHQn56Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cf1tKtLONXwK1etQgQIbdaxAyrpOy6gW7LAyCcmpb50VAQ8gGMO6rGts9agKqNMNE
	 Q6p6exSTJHvlchgHmrdWefKuzuCA5xmvWWtWU/MG0KGeyNK2e30asML+xGfXsKfVSe
	 v0zL/HerelbhMs3lHrPiPxZnpy82Qn7E5atxL4wkrEexZ5AlAUWAOa14XVhbZjvtb8
	 siDkUMpB4Im5swngef5NIzMrJk0iI6PTcsmDEQiXjDEr3PNA1Gvu43CaDRf4k8+II3
	 qk+WsIGGdKbKulq7drvB335r1g0dNaLAkRjZQf7qv5WVprR18KtKOAyR+/+nP3pDLH
	 0EdyDCQfK/5Mw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id DECB52FF559;
	Fri,  5 Jun 2026 09:39:07 +0000 (UTC)
Received: from mshou-H610M-K-DDR4.. (unknown [202.120.40.100])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 46F5B380C9A;
	Fri,  5 Jun 2026 17:39:07 +0800 (CST)
From: "muliang.shou" <muliang.shou@sjtu.edu.cn>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	olivier.hault@level-it.be,
	jon@nutanix.com,
	"muliang.shou" <muliang.shou@sjtu.edu.cn>
Subject: [PATCH 3/3] KVM: x86: add DSM APIC forwarding ioctls
Date: Fri,  5 Jun 2026 17:38:57 +0800
Message-ID: <20260605093857.747735-4-muliang.shou@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605093857.747735-1-muliang.shou@sjtu.edu.cn>
References: <20260605093857.747735-1-muliang.shou@sjtu.edu.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add userspace ioctls that apply forwarded APIC, x2APIC ICR, and APIC
base updates on a target vCPU.

Signed-off-by: muliang.shou <muliang.shou@sjtu.edu.cn>
---
 arch/x86/kvm/lapic.c     |  8 ++++++++
 arch/x86/kvm/lapic.h     |  4 ++++
 arch/x86/kvm/x86.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h | 27 +++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 2485d50b45647..a7b691aa9f020 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2555,6 +2555,14 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 	return ret;
 }
 
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+int kvm_lapic_reg_write_remote(struct kvm_lapic *apic, u32 reg, u32 val, u32 dest_id)
+{
+	return kvm_lapic_reg_write(apic, reg, val);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lapic_reg_write_remote);
+#endif
+
 static int apic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
 			    gpa_t address, int len, const void *data)
 {
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 274885af4ebc4..67828d7fc3be1 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -146,6 +146,10 @@ int kvm_lapic_set_vapic_addr(struct kvm_vcpu *vcpu, gpa_t vapic_addr);
 void kvm_lapic_sync_from_vapic(struct kvm_vcpu *vcpu);
 void kvm_lapic_sync_to_vapic(struct kvm_vcpu *vcpu);
 
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+int kvm_lapic_reg_write_remote(struct kvm_lapic *apic, u32 reg, u32 val, u32 dest_id);
+#endif
+
 int kvm_x2apic_icr_write_fast(struct kvm_lapic *apic, u64 data);
 int kvm_x2apic_msr_write(struct kvm_vcpu *vcpu, u32 msr, u64 data);
 int kvm_x2apic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 42d6f8c977985..06a1c5045606c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7633,6 +7633,46 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = kvm_vm_ioctl_set_msr_filter(kvm, &filter);
 		break;
 	}
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+	case KVM_DSM_IPI: {
+		struct kvm_dipi_params params;
+		struct kvm_vcpu *vcpu = NULL;
+		u32 reg;
+		u32 val;
+
+		r = 0;
+		if (copy_from_user(&params, argp, sizeof(params)))
+			goto out;
+		vcpu = kvm_get_vcpu(kvm, params.vcpu_id);
+		reg = params.val;
+		val = params.val2;
+		kvm_lapic_reg_write_remote(vcpu->arch.apic, reg, val, params.dest_id);
+		break;
+	}
+	case KVM_DSM_X2APIC: {
+		struct kvm_x2apic_params params;
+		struct kvm_vcpu *vcpu = NULL;
+
+		r = 0;
+		if (copy_from_user(&params, argp, sizeof(params)))
+			goto out;
+
+		vcpu = kvm_get_vcpu(kvm, params.vcpu_id);
+		kvm_x2apic_icr_write_fast(vcpu->arch.apic, params.data);
+		break;
+	}
+	case KVM_DSM_APIC_BASE: {
+		struct kvm_apic_base_params params;
+		struct kvm_vcpu *vcpu = NULL;
+
+		r = 0;
+		if (copy_from_user(&params, argp, sizeof(params)))
+			goto out;
+		vcpu = kvm_get_vcpu(kvm, params.vcpu_id);
+		kvm_apic_set_base(vcpu, params.data, params.host);
+		break;
+	}
+#endif
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 75a11e72e232e..65d7094aa06e9 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -231,6 +231,33 @@ struct kvm_exit_snp_req_certs {
 #define HINT_UNSAFE_IN_KVM(_symbol) _symbol
 #endif
 
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+struct kvm_dipi_params {
+	int vcpu_id;
+	__u32 val;
+	__u32 val2;
+	__u32 dest_id;
+};
+
+#define KVM_DSM_IPI _IOW(KVMIO,  0xf3, struct kvm_dipi_params)
+
+struct kvm_x2apic_params {
+	int vcpu_id;
+	__u64 data;
+};
+
+#define KVM_DSM_X2APIC _IOW(KVMIO, 0xf4, struct kvm_x2apic_params)
+
+struct kvm_apic_base_params {
+	int vcpu_id;
+	bool host;
+	__u32 index;
+	__u64 data;
+};
+
+#define KVM_DSM_APIC_BASE         _IOW(KVMIO, 0xf5, struct kvm_apic_base_params)
+
+#endif
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
 	/* in */
-- 
2.43.0

