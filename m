Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958492C159A
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561678; cv=none; b=k7A4aculmHuSWy7HUGBmeA/yBljp0MzbX1/Dk4rnS2d+1aa6sU5qiuApUiPmDaJkRxL7tkgr99jwR7w4pKyrczuyQaOOsG5FCphuoJHw9+kG0xn2DrxSgS81OpQctQiXOSF+oc8mxrwPyQRKqxfSwId7EilIsrsRPIrBPfO5og4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561678; c=relaxed/simple;
	bh=uoR0FXK9mGMvTToC/wIA4BhxmTH60bS/XJ0L3zm8OHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMzkhj2+BrjVCfMr1Q165MzPKMucEsE9ndoguz/Juoh88WbW1t1NrHKInjq8f4kWNlSN1ZgGRknBD//osfKcLSwXiabg4tk28fR9Tb7EK34Fx24mu4RPXDw0YAuHvVJ5E/ebo+Htmg+aIvZqYzpkmbQIa9rzSjAQZZiIAvbfScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IaJhUccj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaJhUccj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6obxhOSXhhEiKG2m9zciOCfCB3jjUQpgTbvMPVwc6To=;
	b=IaJhUccj7ppCAQ6DHDj2zeSxcQkoOvmSCLmEccDxwDyvZs7jwzIAGPbh28KuGtmuyrnQe1
	u4ys1gWzvz/MUv8wz3qy1LSXWhLxZ73P9IOiJxV6ykkIGza/slUzuvwVq09hvlOHBuXr1O
	rByNKODlMvy4dchWqcEPabmSKK6Pjyc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-p_kAsxbhMw-csVOf-VgdoA-1; Thu,
 30 Apr 2026 11:07:52 -0400
X-MC-Unique: p_kAsxbhMw-csVOf-VgdoA-1
X-Mimecast-MFC-AGG-ID: p_kAsxbhMw-csVOf-VgdoA_1777561671
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 118C11800282;
	Thu, 30 Apr 2026 15:07:51 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B3721800347;
	Thu, 30 Apr 2026 15:07:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 02/28] KVM: x86/mmu: remove SPTE_PERM_MASK
Date: Thu, 30 Apr 2026 11:07:21 -0400
Message-ID: <20260430150747.76749-3-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Jon Kohler <jon@nutanix.com>

SPTE_PERM_MASK is no longer referenced by anything in the kernel.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-3-jon@nutanix.com>
Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 91ce29fd6f1b..28086fa86fe0 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -42,9 +42,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define SPTE_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-1))
 #endif
 
-#define SPTE_PERM_MASK (PT_PRESENT_MASK | PT_WRITABLE_MASK | shadow_user_mask \
-			| shadow_x_mask | shadow_nx_mask | shadow_me_mask)
-
 #define ACC_EXEC_MASK    1
 #define ACC_WRITE_MASK   PT_WRITABLE_MASK
 #define ACC_USER_MASK    PT_USER_MASK
-- 
2.52.0


