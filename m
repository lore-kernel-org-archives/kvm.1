Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983AC23C4E9;
	Fri,  6 Mar 2026 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770294; cv=none; b=okDOy7ufumQohVWJiK0tqXlOmuC9VKaItnrIEC+WKTyWAKNpppr6T9UjvTAjeefb1hTyxFN0Vua66wLMC2BCwHqqsYd12edBgmo9TMEyQp76f2JJaam7rkngQbYBsQb/tRAek8QRIUyGHAup4kfyQkj3Ld/woaXnhYUon0b+SRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770294; c=relaxed/simple;
	bh=clXPVBM+2Yj8Gljst4rfD7Tj6SieZZ4xnfFi/IAdOEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hgxBbpCEYw5CZb8JuQxTLPf1Pj11Frmvv8yq2p/vKRjsZHt7kJm4yk8DX4BK31XyxeNbJuf6j02sgobwIq8ztm5X0nZ6j+XpP30of54Y2LuPWIbR7W7iu4cD7k+S9re3rWoHmbOXxBKrwCyoIyHqDYOfnNWeSCvFSxKxIb7E/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95D79497;
	Thu,  5 Mar 2026 20:11:25 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 172F13F694;
	Thu,  5 Mar 2026 20:11:30 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH] KVM: Change [g|h]va_t as u64
Date: Fri,  6 Mar 2026 04:11:25 +0000
Message-Id: <20260306041125.45643-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change both [g|h]va_t as u64 to be consistent with other address types.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/kvm_types.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..c901ad01eb5d 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -61,15 +61,15 @@ enum kvm_mr_change;
  *  hfn - host frame number
  */
 
-typedef unsigned long  gva_t;
-typedef u64            gpa_t;
-typedef u64            gfn_t;
+typedef u64  gva_t;
+typedef u64  gpa_t;
+typedef u64  gfn_t;
 
 #define INVALID_GPA	(~(gpa_t)0)
 
-typedef unsigned long  hva_t;
-typedef u64            hpa_t;
-typedef u64            hfn_t;
+typedef u64  hva_t;
+typedef u64  hpa_t;
+typedef u64  hfn_t;
 
 typedef hfn_t kvm_pfn_t;
 
-- 
2.30.2

