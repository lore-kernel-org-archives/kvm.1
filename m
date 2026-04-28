Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92A3F20FE
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374617; cv=none; b=qVQBWLmHF5Uxk/pBkQm9nO/0XWOjJxBdQUmikQQ7nhJFd+Y9g19/IVuqopySPMHyIvCE7R8V3g7mEtzAq8ZPUOwG7E5oFuqOgQkB7t1/BsSeZaudxtqXroYnE7ohhPhBNot5PghhiH3/yHVTge5rjorXKEKS695YBDz7fmxR0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374617; c=relaxed/simple;
	bh=hoTatyRYXoIBfLRHwPcxGG1+pSL5waPss30kc6PgoV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlXk4BiGZh+yMV3/ekFFcmgV4Urf90Pk5ElEhtYBz4HrRmlgn/9lDP94qX3VDGLKcqmXSNNonNAcFyiZyN8DupKn8JrnrXHqhS83hoyH6whtXPDRLuW4N7g7+qSUC6lBhUuOM9Y1VRYxmWYe9VIb6BDOG59c2vBnN8EGaxGryEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ao1czOYe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ao1czOYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1r/8zG7HzE0J0RSifY4zJKxgWsdJGMYRBoWC/B6KdE=;
	b=ao1czOYeLYuZJGUPJdY8ewFBr6Cc3ia/N2Gc92KtqNIpIJm1Oh7HWCukCedRqLvaIYA5WE
	IdEAYIQl1FQKV6Sr6pUkyG+7KAbt9QTi3BiLfeIyCoGEBu5Af8vhI1eQ2wPeOtjWpac/7V
	XHDuZeEkYA74i2tob4A8dCQx856OCMM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-mrbD650FMNaRnX_etdjdYw-1; Tue,
 28 Apr 2026 07:10:13 -0400
X-MC-Unique: mrbD650FMNaRnX_etdjdYw-1
X-Mimecast-MFC-AGG-ID: mrbD650FMNaRnX_etdjdYw_1777374611
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B82F195608F;
	Tue, 28 Apr 2026 11:10:11 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 856E219560AB;
	Tue, 28 Apr 2026 11:10:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 23/28] KVM: SVM: add GMET bit definitions
Date: Tue, 28 Apr 2026 07:09:41 -0400
Message-ID: <20260428110946.11466-24-pbonzini@redhat.com>
In-Reply-To: <20260428110946.11466-1-pbonzini@redhat.com>
References: <20260428110946.11466-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

GMET (Guest Mode Execute Trap) is an AMD virtualization feature,
essentially the nested paging version of SMEP.  Hyper-V uses it;
add it in preparation for making it available to hypervisors
running under KVM.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/svm.h         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1d506e5d6f46..35a2a0f9ab32 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -379,6 +379,7 @@
 #define X86_FEATURE_AVIC		(15*32+13) /* "avic" Virtual Interrupt Controller */
 #define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* "v_vmsave_vmload" Virtual VMSAVE VMLOAD */
 #define X86_FEATURE_VGIF		(15*32+16) /* "vgif" Virtual GIF */
+#define X86_FEATURE_GMET		(15*32+17) /* Guest Mode Execution Trap */
 #define X86_FEATURE_X2AVIC		(15*32+18) /* "x2avic" Virtual x2apic */
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index bcfeb5e7c0ed..aa63431ba92c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -243,6 +243,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_MISC_ENABLE_NP		BIT(0)
 #define SVM_MISC_ENABLE_SEV		BIT(1)
 #define SVM_MISC_ENABLE_SEV_ES	BIT(2)
+#define SVM_MISC_ENABLE_GMET	BIT(3)
 
 #define SVM_MISC2_ENABLE_V_LBR	BIT_ULL(0)
 #define SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE	BIT_ULL(1)
-- 
2.52.0


