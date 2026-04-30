Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B3395DBF
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561693; cv=none; b=R7QxfRXp9vdpGnryb+Ygxb6rsJizqTPUy6kfl4fHRurvw4CbLzasz4V82cms9ugoBeKT8r/BOVZkAArYWUgt/jTOznGDYI87zYyp3o7s3pe+9KpDJxtvlJE93IWraZtk2VhxstyN57uOn2OdBUBANxhx0t3cOSjLe2IBVLRDxtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561693; c=relaxed/simple;
	bh=i3jQrAyLxnhA/t/BHsxb3+sqwKCc2Ml3j5/foser9aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQK7gQRv6B5w03LLmmchYbiYP0cIGkef0cad/YbNsd9VUsTRRpAFSbsQN7tyskScyCJabAtCDxUrpnhpm1NJzgyHMfPTjGnnEgkd3zWP40I5qyy1XuNwpbWVvNgaEaJFcZCdM5/Nalc0U9IBxfzJij4rHUHjt8CNimaWUCwXbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKYfotp4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKYfotp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YJGyvsFomEhH/bKnG38bbVfFx34TKz1rxdBHf//6Lw=;
	b=IKYfotp4SvyDHm7re02DojocqM+1pmwJ8wAFU6rrYI1I4creu4RXGxp+vHPx+tMDSiwjoc
	ZLXG0N1Ws4tHbZac3O/9D2x9zvpA4roW0ZuZigWeVUA3qTjDxALytZHDwxutBiyDhiTRgn
	REX/NkIYfDDBiYM3F34icLE4triWZ/o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-oMXG1ngJMIWpAgjX4mEO2A-1; Thu,
 30 Apr 2026 11:08:06 -0400
X-MC-Unique: oMXG1ngJMIWpAgjX4mEO2A-1
X-Mimecast-MFC-AGG-ID: oMXG1ngJMIWpAgjX4mEO2A_1777561685
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CBE019560A1;
	Thu, 30 Apr 2026 15:08:05 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04E6F180034F;
	Thu, 30 Apr 2026 15:08:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 20/28] KVM: nVMX: allow MBEC with EVMCS
Date: Thu, 30 Apr 2026 11:07:39 -0400
Message-ID: <20260430150747.76749-21-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

Extend EVMCS1_SUPPORTED_2NDEXEC to allow MBEC and EVMCS to coexist.
Presenting both EVMCS and MBEC simultaneously causes KVM to filter out
MBEC and not present it as a supported control to the guest, preventing
performance gains from MBEC when Windows HVCI is enabled.

The guest may choose not to use MBEC (e.g., if the admin does not enable
Windows HVCI / Memory Integrity), but if they use traditional nested
virt (Hyper-V, WSL2, etc.), having EVMCS exposed is important for
improving nested guest performance. IOW allowing MBEC and EVMCS to
coexist provides maximum optionality to Windows users without
overcomplicating VM administration.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-8-jon@nutanix.com>
Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/hyperv_evmcs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_evmcs.h
index fc7c4e7bd1bf..bc08fe40590e 100644
--- a/arch/x86/kvm/vmx/hyperv_evmcs.h
+++ b/arch/x86/kvm/vmx/hyperv_evmcs.h
@@ -87,6 +87,7 @@
 	 SECONDARY_EXEC_PT_CONCEAL_VMX |				\
 	 SECONDARY_EXEC_BUS_LOCK_DETECTION |				\
 	 SECONDARY_EXEC_NOTIFY_VM_EXITING |				\
+	 SECONDARY_EXEC_MODE_BASED_EPT_EXEC |				\
 	 SECONDARY_EXEC_ENCLS_EXITING)
 
 #define EVMCS1_SUPPORTED_3RDEXEC (0ULL)
-- 
2.52.0


