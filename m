Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EAC424674
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329672; cv=none; b=bzD9k7teKbURIEk2gpZuL1W93saSvqMq4u3z9ZaLr23Aqv9xDykiYZnUSVLhDBq0BoL+O96rIUWSA3e4GAClUtQKFRpzSzkc6b1wUYus0xRHAw4eRnulRvlGNViC+0h7lHrcqGrALMbzebVwRqtEroeY2R97qMKpJfr9+ai46QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329672; c=relaxed/simple;
	bh=06SXRelpbqUU4pNe+CRRSmw4m8ygWaa7TxS0wX0k4+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uneiztjiLeBb8ozqHBkQRZqxh3X4KV3IWqe3fopnrTe/iUDaEcD9NulspvfLWcby9yDOvi+U1P0hamSThRlmWKaoIL4IyKCgySgiuJblb6ENTfOb2WmT903mErgKtA1nT/FbPrtIGie/A1kGkangZEo/xWz3BCFRsIRaMKdKcvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWCZN0Qo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWCZN0Qo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783329668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpghbnbNeZPa/J8LpjllYtlPIVi0zaZHyMflcJUuqeE=;
	b=XWCZN0Qo/ahuWBx9iLn3Qj0iUP+//8J3oJv2As6aZbiEIJsr5GSjdl0o2KNGYqkeiyCX52
	14SYEyr2o/IqBp403hyWY68N7myMutQy5SJU+Y1ifPwEU+mA8/MDIiDe4AcfTinOBMv/z8
	Zseohx5a5NdMJS2FNZoTT/umGg1vlbA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-8QKHiVgeP6WmsPrslUTANw-1; Mon,
 06 Jul 2026 05:21:05 -0400
X-MC-Unique: 8QKHiVgeP6WmsPrslUTANw-1
X-Mimecast-MFC-AGG-ID: 8QKHiVgeP6WmsPrslUTANw_1783329664
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5462C18001F6;
	Mon,  6 Jul 2026 09:21:03 +0000 (UTC)
Received: from work.fritz.box (unknown [10.44.49.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E2F93000714;
	Mon,  6 Jul 2026 09:21:00 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 4/4] KVM: x86: Reject user memory regions covering the APIC base
Date: Mon,  6 Jul 2026 11:20:19 +0200
Message-ID: <20260706092021.3625908-6-twiederh@redhat.com>
In-Reply-To: <20260706092021.3625908-2-twiederh@redhat.com>
References: <20260706092021.3625908-2-twiederh@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

User space must not map guest memory that covers the default APIC base
address (0xfee00000) when using an in-kernel irqchip.  Currently,
KVM_SET_USER_MEMORY_REGION does not check for this.  The violation goes
unnoticed until vcpu creation, which fails with the misleading error
-EEXIST.

Add an explicit check to kvm_arch_prepare_memory_region() so the
conflict is reported at the point where it is introduced.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 arch/x86/kvm/x86.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 07f348232a72..b38d4355137a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13684,12 +13684,19 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		return -EINVAL;
 
 	if (change == KVM_MR_CREATE || change == KVM_MR_MOVE) {
+		const gfn_t apic_gfn = gpa_to_gfn(APIC_DEFAULT_PHYS_BASE);
+
 		if ((new->base_gfn + new->npages - 1) > kvm_mmu_max_gfn())
 			return -EINVAL;
 
 		if (kvm_is_gfn_alias(kvm, new->base_gfn + new->npages - 1))
 			return -EINVAL;
 
+		if (irqchip_in_kernel(kvm) &&
+		    new->base_gfn <= apic_gfn &&
+		    apic_gfn < new->base_gfn + new->npages)
+			return -EEXIST;
+
 		return kvm_alloc_memslot_metadata(kvm, new);
 	}
 
-- 
2.52.0

