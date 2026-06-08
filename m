Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFF23EFD0B;
	Mon,  8 Jun 2026 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929811; cv=none; b=I7xFMSXyBOT8l/UWK27YnFuE/gpndqgOEs3RCELI7mLhsYMUitlFcoq/N8JVkyB6cPH1VE0Lve2EpYFbYn9ij9ct27hE8x7Sq78dmglpS3LsfElkT4nh5JhXB8GNkrTmYxI/bs8kPebHozeYsqzFJ8fn/DM2DSG8EDmg9Uh95x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929811; c=relaxed/simple;
	bh=pcp4odT3NNnPWZpyjZ6003LhvZo4f0DoCv0aN5fr2xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7nzmxM+YhOO/rJ4yc8VkOZLJsz92BUkOULAHlOS8aSCAje4MOstpiZywzJfLm2fRgsoj/hrSERZUqSTzm5ADbkP3CsHEWqHqT6zquvP3SC0NHkFK/IN7lvcloY+7jDYOgLcW4ge3S3QoVxCkKlXQ8KkGhaMw4VNHJDTHKeiK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B9A7C2028D0;
	Mon,  8 Jun 2026 16:43:14 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	nsaenz@amazon.com,
	anelkz@amazon.de,
	James.Bottomley@HansenPartnership.com,
	Melody Wang <huibo.wang@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	x86@kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [PATCH 45/60] kvm: x86: Update state for all plane VCPUs after CPUID update
Date: Mon,  8 Jun 2026 16:42:37 +0200
Message-ID: <20260608144252.351443-46-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144252.351443-1-joro@8bytes.org>
References: <20260608144252.351443-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Make sure to update CPUID dependent state for all VCPUs of a given
plane when CPUID state is updated.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/cpuid.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 27e2f7e25038..fab075bb6fdc 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -513,6 +513,8 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 {
 	struct kvm_vcpu_common *common = vcpu->common;
 	u32 vcpu_caps[NR_KVM_CPU_CAPS];
+	struct kvm_vcpu *v;
+	unsigned i;
 	int r;
 
 	/*
@@ -562,9 +564,11 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 
 #ifdef CONFIG_KVM_HYPERV
 	if (kvm_cpuid_has_hyperv(vcpu)) {
-		r = kvm_hv_vcpu_init(vcpu);
-		if (r)
-			goto err;
+		vcpu_for_each_plane(common, i, v) {
+			r = kvm_hv_vcpu_init(vcpu);
+			if (r)
+				goto err;
+		}
 	}
 #endif
 
@@ -572,10 +576,12 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 	if (r)
 		goto err;
 
+	vcpu_for_each_plane(vcpu->common, i, v) {
 #ifdef CONFIG_KVM_XEN
-	vcpu->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
+		v->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
 #endif
-	kvm_vcpu_after_set_cpuid(vcpu);
+		kvm_vcpu_after_set_cpuid(v);
+	}
 
 success:
 	kvfree(e2);
-- 
2.53.0

