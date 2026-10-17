Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3363B995E;
	Sat, 17 Oct 2026 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229433; cv=none; b=agy7UIB051j43gawzq6Lr4lSDId0YR19ZagfgGH4e08XqFw0asKK9GqPEQdrLuMwEP1KX3MeBnFzrp902vz1n/WBJCl2oDx3i51Xv7pyfjXVKdhtI7q0PhgUtGabEZjlpQXsCF2mGhdR/hEHMbiZ2UGk5bKUDYuSgVKpZQSlll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229433; c=relaxed/simple;
	bh=r8cKGRBqsYjnJFWDi8fKBlWqviaF9bxzB+auIWBji+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c1DaT9FJazSuBy50GYe+UH0XJZvjmB1Ew8x9eKANdYMSqkeaZ7Iv/7umKEtk4fLp3IR979e3VZxjGEMNA8aO7fw+trxRYNZ0/bP5w7ZUGHyRG+TCM2YnRF1nSusrv0SyRgY4ckRUok8XTp6UjeI93JJVq8iVueBRsOkSBS+IGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=gvxR0fj3; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="gvxR0fj3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KdWZJwkAUdc3ZRhBUWX6FNsNH4wlcD+eOGy6SuDB1Rs=; b=gvxR0fj3HXZ5IvIg5t/Vj3eWH3
	+cWvXW+H4gp/qxqrXXlTigvIHw5G34OA08dhkSe6zJpzCAj1iI55GWkoXHpikkYdS4Y7vELYq6YGV
	mSljMDKOZogeGvkgH9CQRQ8rSd3ZMxjrl6MYEVld3chFLfYY3zuCMjnQl/1vY5E3Wu22u1q8Hz8LD
	Q4xFp3HrS2QTkMxqRSTuZrgcLw6GMJONL3+YlG8vICCO4J6wY6yZ2hPC+HYzY5/P9+ElstJ29s1uo
	4Z052+9uSW2abRustN4QIcEMLRLK/MA332xj8mcloAkvDkqpGBerXR7WjxQK3q4EVCsSozCfwQ3QS
	WBhLEEQw==;
Received: from mailer.gwdg.de ([134.76.10.26]:58589)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kI-00BAXK-20;
	Sat, 17 Oct 2026 11:30:30 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kI-000VXT-0g;
	Sat, 17 Oct 2026 11:30:30 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 17 Oct
 2026 11:30:29 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM: VMX: Load the EOI-exit bitmap into vmcs01, not the active VMCS
Date: Sat, 17 Oct 2026 11:30:11 +0200
Message-ID: <20261017093016.32348-2-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-07.um.gwdg.de (10.108.142.66) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

vmx_load_eoi_exitmap() writes EOI_EXIT_BITMAP0..3 directly with
vmcs_write64() and, unlike its siblings vmx_hwapic_isr_update() and
vmx_sync_pir_to_irr(),
does not take guard(vmx_vmcs01).  The EOI-exit bitmap belongs to L1's APIC,
but with nested virtual-interrupt-delivery an L2 can be active when KVM
refreshes it (e.g. via kvm_vcpu_reload_apic_access_page() /
vcpu_scan_ioapic()), so the writes land in vmcs02 instead of vmcs01: L2's
EOI-exit bitmap is corrupted and vmcs01's is left stale until the next L1
refresh.

Add guard(vmx_vmcs01), matching the sibling APICv callbacks.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/vmx/vmx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6..1f802cdbe 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7082,6 +7082,13 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	if (!kvm_vcpu_apicv_active(vcpu))
 		return;
 
+	/*
+	 * The EOI-exit bitmap tracks L1's APIC, so it must land in vmcs01, not
+	 * whichever VMCS is currently loaded; a nested VID L2 can be active
+	 * here.  Mirror vmx_hwapic_isr_update()/vmx_sync_pir_to_irr().
+	 */
+	guard(vmx_vmcs01)(vcpu);
+
 	vmcs_write64(EOI_EXIT_BITMAP0, eoi_exit_bitmap[0]);
 	vmcs_write64(EOI_EXIT_BITMAP1, eoi_exit_bitmap[1]);
 	vmcs_write64(EOI_EXIT_BITMAP2, eoi_exit_bitmap[2]);
-- 
2.54.0 (Apple Git-157)

