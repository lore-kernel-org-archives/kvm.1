Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93693421232;
	Wed,  5 Aug 2026 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927824; cv=none; b=SGjNNIHN8Ww15744EyVuR6YhxjtMhbSIFegNedXQ/cxscavH9trN1Cu8XQlOh7ALquy4hdEbfeJ+OzdwCrzxES80yahwK0FfxxIhvmKTP2jZpzyHLxhrTEzcg+5OCFbYlkpeHbOB0OOjzJpSzjEHgJz5Gle1JHzfhgcLUoUXCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927824; c=relaxed/simple;
	bh=3Y/tRcdbU+t1tVcQ91xWggoBpDmuM74MboE1DFiASVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCvj/lD/xHcAyBTkXNeeSqBQhHlvUPODmXddKotxP65o2ZcIrrqxd1PlL7YVnQJKSaVBLVtcQ0TuZHiJuoq1U76M02sP8eRzel/MXITjAXQQ/GuH7/YeZ9rilvvA8g3lGuwAtmRFDLHhbawQIkHEA3YeSYaYNM7j4HcSplkLW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YoWTgQAB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YoWTgQAB"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 66DE720B716C;
	Wed,  5 Aug 2026 04:03:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 66DE720B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927802;
	bh=w57Ramh9RwzEf5GMKjkCKRc6g8SfosvFKziATrRDyoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YoWTgQAB/J3P7QaG3DoEJWiJ26nY5opBXD8/TBJLtQ07IMDh62lAbMM2C/2Onb3pt
	 9d06G0Hkx3kme91gjchp9KlHSNGWs/uzE4X4AcSsrSJTonUmhqbzv9zgIsUfs3FWqt
	 8jec1iZraQBn4FSSPbYFfolA3DfXjbWqY5AIDBDI=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 02/42] Fix compilation
Date: Wed,  5 Aug 2026 04:02:44 -0700
Message-ID: <20260805110324.25067-3-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram Nambakam <snambakam@microsoft.com>

---
 arch/x86/kvm/irq_comm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 94f9db50384e..55f395f9d8af 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -122,7 +122,7 @@ void kvm_set_msi_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
 	irq->shorthand = APIC_DEST_NOSHORT;
 	irq->plane = e->msi.plane;
 }
-EXPORT_SYMBOL_GPL(kvm_set_msi_irq);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_set_msi_irq);
 
 static inline bool kvm_msi_route_invalid(struct kvm *kvm,
 		struct kvm_kernel_irq_routing_entry *e)
@@ -369,7 +369,7 @@ bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
 
 	return r == 1;
 }
-EXPORT_SYMBOL_GPL(kvm_intr_is_single_vcpu);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_intr_is_single_vcpu);
 
 #define IOAPIC_ROUTING_ENTRY(irq) \
 	{ .gsi = irq, .type = KVM_IRQ_ROUTING_IRQCHIP,	\
-- 
2.55.0

