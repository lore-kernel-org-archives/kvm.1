Received: from smtp186.sjtu.edu.cn (smtp186.sjtu.edu.cn [202.120.2.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327553D9048;
	Fri,  5 Jun 2026 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653664; cv=none; b=WeD7mUUBlR5h0hhUTHERDcCbGa/eE5T3FvVFXO1c2Kg9K2KxMAOYCBUqFks0Gotiz3NCnrSAyRcu2sgMSMfYtjnIKLveh4RIPzyi4zo2450qQqIbBarRZF1Gv2DwM44JToewE33xOjkeKFObUWHTJHsSNWW0QHP7LU7XxJQC7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653664; c=relaxed/simple;
	bh=Nh5tKSIFCx2IJvjr4Rep5umPsNkr7T6yLxUkdg/o7VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oh5LlZOxNdNT4HduhBKRzLEowfoOW7ARqgh0OgNHC6m1Wx4blOKhu6558zrPgPQ7NLtf/YKyr3bqIJqtEgzQYYMKov8bt/9cpZAdPVtmFBuwfoZsGe0+P57SAnrduCY40dYVPejkxpmKGdthbzmgoU4Q5nsQOTN6MfTc/S4RbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b=KRdSGHuo; arc=none smtp.client-ip=202.120.2.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b="KRdSGHuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
	s=default; t=1780653639;
	bh=Nh5tKSIFCx2IJvjr4Rep5umPsNkr7T6yLxUkdg/o7VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KRdSGHuo1aDzCxcP+7iDUarwiaU3BrSC8tNQuBFbYn2uCXvoFlGRbBtQYWVIIzZzm
	 Cj9i50o0JRAGzyFhlc7KbXxcdrastH0gZ7J6FSw+g8pYxl9WYCJozob6H/D2iKyGNf
	 +sWDFy7rMXXyjPLlUai0ItwZKrR6FSmcWqc/r6SIQcSWL8SZZgxn6rmwIbt5/f9Nfv
	 ScxmDmfpoZ0Bg9l2yKhfZlnVUg8iFMRsrHgBNnH6ErH+d8uX7FIGPYVk9OeFZhPOCz
	 cHMEFlpYFxRBtNSwWofLX50Zde/IYoZr6ZwOwErgsUMvCNlCAFVYRp/cIlBHQPSkj7
	 MiAzI2F2Isnbw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 70EED2FF408;
	Fri,  5 Jun 2026 10:00:39 +0000 (UTC)
Received: from mshou-H610M-K-DDR4.. (unknown [202.120.40.100])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id C5EF037C98C;
	Fri,  5 Jun 2026 18:00:38 +0800 (CST)
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
Subject: [RFC PATCH v2 2/3] KVM: x86: forward LAPIC ICR writes to userspace
Date: Fri,  5 Jun 2026 18:00:30 +0800
Message-ID: <20260605100031.834938-3-muliang.shou@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605100031.834938-1-muliang.shou@sjtu.edu.cn>
References: <20260605100031.834938-1-muliang.shou@sjtu.edu.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intercept LAPIC ICR/ICR2 MMIO writes, record the forwarding payload, and
return to userspace with KVM_EXIT_DSM_SEND_IRQ when the pending request is
processed.

Signed-off-by: muliang.shou <muliang.shou@sjtu.edu.cn>
---
 arch/x86/kvm/lapic.c | 30 ++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c   | 14 ++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4078e624ca667..2485d50b45647 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2561,6 +2561,10 @@ static int apic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
 	struct kvm_lapic *apic = to_lapic(this);
 	unsigned int offset = address - apic->base_address;
 	u32 val;
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+	u32 reg;
+	u32 dest_id = 0;
+#endif
 
 	if (!apic_mmio_in_range(apic, address))
 		return -EOPNOTSUPP;
@@ -2583,6 +2587,32 @@ static int apic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
 
 	val = *(u32*)data;
 
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+	reg = offset & 0xff0;
+	if (reg == APIC_ICR || reg == APIC_ICR2) {
+		kvm_lapic_reg_write(apic, reg, val);
+		if (reg == APIC_ICR) {
+			if (apic_x2apic_mode(apic)) {
+				dest_id = kvm_lapic_get_reg(apic, APIC_ICR2);
+			} else {
+				dest_id = kvm_lapic_get_reg(apic, APIC_ICR2);
+				dest_id = GET_XAPIC_DEST_FIELD(dest_id);
+			}
+		} else {
+			dest_id = GET_XAPIC_DEST_FIELD(val);
+		}
+
+		vcpu->arch.dsm_irq_forward_pending = true;
+		vcpu->arch.dsm_irq_forward_reg = reg;
+		vcpu->arch.dsm_irq_forward_val = val;
+		vcpu->arch.dsm_irq_forward_dest_id = dest_id;
+
+		kvm_make_request(KVM_REQ_DSM_IRQ_FORWARD, vcpu);
+
+		return 0;
+	}
+#endif
+
 	kvm_lapic_reg_write(apic, offset & 0xff0, val);
 
 	return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0550359ed798f..42d6f8c977985 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11338,6 +11338,20 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 				goto out;
 			}
 		}
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+		if (kvm_check_request(KVM_REQ_DSM_IRQ_FORWARD, vcpu)) {
+			vcpu->run->exit_reason = KVM_EXIT_DSM_SEND_IRQ;
+			vcpu->run->lapic_irq.id = vcpu->vcpu_id;
+			vcpu->run->lapic_irq.val = vcpu->arch.dsm_irq_forward_reg;
+			vcpu->run->lapic_irq.val2 = vcpu->arch.dsm_irq_forward_val;
+			vcpu->run->lapic_irq.dest_id = vcpu->arch.dsm_irq_forward_dest_id;
+
+			vcpu->arch.dsm_irq_forward_pending = false;
+
+			r = 0;
+			goto out;
+		}
+#endif
 	}
 
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
-- 
2.43.0

