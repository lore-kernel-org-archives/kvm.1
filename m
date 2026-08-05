Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7527743B3F6;
	Wed,  5 Aug 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927843; cv=none; b=A05d/PKTZDE028MLuA6wdFoWLSEmF1wLooxWNaEeC61PH4D0I6axYjoQi6i6RgcZYITPbvNHm23vQlBgQ7NPjnV2wCVdkRud/1oHzvmXzdYcNwz9RE33sg1fUrienP1UP+btp0V7Vn2NXzxsfoCzY7Cc1EOFS+wcpzFD5MLhXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927843; c=relaxed/simple;
	bh=fd1fZGkKlRI0hsVdzhb2l4RtI1jIs/V9mpyhR9PBfEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJJBhkMiSLoIvq0wLEQulaXyjF93DBWD1QavLg22/i/l34cJUuyOPa9xePHIh5LPTMyoOADfbg8i3WUreuFJx/B2y5aIzYf7aTlp/GwErdJGWdL9dxfxK+Wq8dcPFEjHMEnylQhKvp5SIL0OdFh/UI9kt7vJWk8shdk+pseB1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T5DO/7Vt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T5DO/7Vt"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id C617D20B716A;
	Wed,  5 Aug 2026 04:03:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C617D20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927821;
	bh=67aOwmHOj/Q52K+V5Ek1yk9wbvv+XpwwjutWPwsyzDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T5DO/7VtUathSgXOq+CnarGbw7kLvSYGcG/eiyvh26+fgo7zbwYm9s/4rPSKvKWe1
	 3KsN04n5qtQ+fzvEDEu14uGRZMz6Mx9wXkWcFFy0Hg96AL1Bw924uDzH68BYAEPIHa
	 R7cBrXwOVShJWgHqJNmOBfoIYeIZtcLHLzeF6NiU=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 21/42] KVM: x86: exit VM planes and VBS hypercalls to userspace
Date: Wed,  5 Aug 2026 04:03:03 -0700
Message-ID: <20260805110324.25067-22-snambakam@linux.microsoft.com>
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

---
 arch/x86/kvm/x86.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d4210053e6b8..00dcdd0e22a4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -119,10 +119,11 @@ u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
 static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 #endif
 
-#define KVM_EXIT_HYPERCALL_VALID_MASK (BIT(KVM_HC_MAP_GPA_RANGE) | \
-					 BIT(KVM_HC_VM_PLANES_CONFIG) | \
-					 BIT(KVM_HC_VM_PLANES_ACTIVATE) | \
-					 BIT(KVM_HC_VBS_VTL_CALL))
+#define KVM_EXIT_HYPERCALL_VALID_MASK		\
+	((1 << KVM_HC_MAP_GPA_RANGE)		|	\
+	 (1 << KVM_HC_VM_PLANES_CONFIG)		|	\
+	 (1 << KVM_HC_VM_PLANES_ACTIVATE)	|	\
+	 (1 << KVM_HC_VBS_VTL_CALL))
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
 
@@ -478,7 +479,7 @@ static unsigned int num_msr_based_features;
 
 unsigned kvm_x86_default_max_planes(struct kvm *kvm)
 {
-	return 1;
+	return 2;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_default_max_planes);
 
-- 
2.55.0

