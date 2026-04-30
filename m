Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5A43C059
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561696; cv=none; b=dTGfyApTcbSwB0ekpdvCv2ZXo4zpZWRnyWb25tVagUTA9/wl+4aNJVRRE4U1eWitxNecyT8D451wV0dKbzpLZlyF3Js790cfEWmDqFBRAprDAIbs1XAgX5D3SInMjHJ5K0cgVCGT1/LK9LWbuXCjx8b9tm/CS5AkeyWosZ4sfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561696; c=relaxed/simple;
	bh=yWXdoiQVh8ATDy6+edjM/jh5GvM/cnaOKN/EbxBl6do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOW/VMfsX5U62e/GZ0Ygsc+WQQTrmO7W1DOo3uCk+ZYPpCx7H2cnd7dlfyt/bK57wwhTVuGod45UiMtYerSEu4ksEkXpPEpsbM5XBFHINwlUA1gPujzVvSlCZ+HL1Dd3ic5nzyODhoDmRuwVWGVmUAl6xZdXhGXwT97aWn3JdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OowoG+QT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OowoG+QT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMXRbG836TtpgBO9IHiswDkh+14f6bX9mDfcP8XvT0M=;
	b=OowoG+QTFrzTYExnfrk9ZKY03Vo+kOP3mkmyfh8D/WQ0/svJsTUUg3NOhzZwUHBWZofe01
	IurSPhSw/pvJ556zGXXHuTFexY5wi13NKsodUrNqvp3Jq5Nqjg/oVlX+UmtdIMKZ2ZdTxX
	IOcE9QMIgvxz/WQNTlD1AzSkNiy8+zE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-eHQvP40FM5SU0V5qIRzPTQ-1; Thu,
 30 Apr 2026 11:08:09 -0400
X-MC-Unique: eHQvP40FM5SU0V5qIRzPTQ-1
X-Mimecast-MFC-AGG-ID: eHQvP40FM5SU0V5qIRzPTQ_1777561688
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3208A18003FC;
	Thu, 30 Apr 2026 15:08:08 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27BB6180045E;
	Thu, 30 Apr 2026 15:08:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 23/28] KVM: SVM: add GMET bit definitions
Date: Thu, 30 Apr 2026 11:07:42 -0400
Message-ID: <20260430150747.76749-24-pbonzini@redhat.com>
In-Reply-To: <20260430150747.76749-1-pbonzini@redhat.com>
References: <20260430150747.76749-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index de7bd88e539d..d58dbce83f45 100644
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


