Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DE3D75AB
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010802; cv=none; b=ljc2si7jm/QlatOoTPnRrhfAPaAqc9TnXWFlSL880HAt41r8udRLBaUWKuDpj0/HqAvJiykAMWZn4HTmNWipHuYurfvGbiJPh86KXWHudmkepGmnVN9YmyrX6hoh6/jj/xZdrSVrg54WZV/Xc0U/Tpn7MXk8PBJBjZDHuq6DjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010802; c=relaxed/simple;
	bh=D1zhYJbBOB61+H4UZMjf4+jfU+wYM//h7gA0HvL14Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF8uJPQg3XVIOp5ST2GND+6FJW6OhSQWDhswZ4roHgsxoy7bSsjBgqJibeAe20ZSE2QN3jxE6C95RA1YLj2jSlAqgtfykm+RtMKhEn2vy/42nUzVyoL/vXpvRBzVgw+TQACtfPYLEXvKAupfbjvhnZH/TeePKezbC91N9H0rXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PY7EUY/V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2DkgFNq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PY7EUY/V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2DkgFNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ul+fnq/919TIDb0iApWQrJPuaWdJH8uA/BhpwtXzr+4=;
	b=PY7EUY/VGJeqV1pLGlaHHZYwE4Z82G9DyxypM1h/lctZbT+YffVHYUP6VHUwwm66s1nwfU
	OdkT3aKyssqQoks8BXzr7iAgHPr9zZmghQoaKwjROBqJAHYIsX4+uIoTj59LJl6KJ1o2tB
	4hQ4PuxDVOGEM5zVhHD1t2gp2Ijzx7A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-3m0TrmCHPf2X2a_JVQJoCQ-1; Tue, 05 May 2026 15:53:18 -0400
X-MC-Unique: 3m0TrmCHPf2X2a_JVQJoCQ-1
X-Mimecast-MFC-AGG-ID: 3m0TrmCHPf2X2a_JVQJoCQ_1778010797
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso70678835e9.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010797; x=1778615597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul+fnq/919TIDb0iApWQrJPuaWdJH8uA/BhpwtXzr+4=;
        b=M2DkgFNqsXOf+8PAtorlEYVCNfT2G81kdyoqVnflLAz7sPoyhXMbfnDMXmKbMkmOXV
         y8nL7O7TRnPuBOBDGx3+K3+KF1B9R1w/lL/xE9yo7IVTMX2Z94IZUr/AJDDsvU1bVwI6
         k/i6RNyhu+iX4ZZL3K/B8F05ApKsXSQVhK8tZmsoNUWQHKgXUeLh6lRdb5gQG08ncgiZ
         ZmiyltLeDXlwu7MtoxVBpwH3ISRewMwTXvUfFBRaziEb6+qgC8HzUimF3JgrM9PKq9a4
         e8yx272oFW9rvRrF165wNpHnSvBgvqNR2xVq0yIog6iGES9JpAEwWzVXYWtAVD+Pp/Uj
         zgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010797; x=1778615597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ul+fnq/919TIDb0iApWQrJPuaWdJH8uA/BhpwtXzr+4=;
        b=KPb3GRGCss3LdJihj87KadDWCu2zVYBJrEHomQ5ueb2iUV4cjL2qfjPiGrV6cIS6AN
         tQpvTHdco9t30gGkEuHE9HmomdsKvxE3WWE4e4g2N9vIc97hmhmdAERJSQ5V9m84W0Up
         wXLYPuI5NqcnAZxFXsgPiumvKfco2faoMFLo8ddp4rV1qEy02rebncO613h0Zjyo/cUw
         4ZCZge546RC00LK4uGyYKeO+gojZo1WnJyDf1E5aIvsomdnw0BC9JZxCvr4AL45+WPVP
         NWj4fl7qVB31OZ7hrAeqd07wqQ97fpihdV5mrGHMeT8EofLXGzgyWzgbzBDYbgJJUsyx
         YKGA==
X-Forwarded-Encrypted: i=1; AFNElJ8RHVprjSiV0gx921sQ+AcIeXx2PoNxQaBOP8T4XofQLX91f2J/BExVJNGl0gpiENWMGas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb51zZjSWxCvWwPs5AAugpE+F3fnqMo+qHdwCAiPukdVMS6ZC2
	Txg4p0s3cmodFVf6gP0ddBcb4s/D8Trr0YOq3CQoIikSpvfFWahICpPOocHtU0RA4DgT30e5T+g
	T+hF5xaUukXutq25ewisvOOC3YshbjIfj8VfblurbFs9KjMLjqPosTw==
X-Gm-Gg: AeBDieuVN3y0Mwt3pbG8DtMf6pkKY+swFeXT8YArhnrJceED0ddkt4yC4iLcoRHsSD4
	JPW51Rqnrl2MFFJiR85T5BbgxpKCadLckEFlWE+r7RO2BKceLEe2dGgHwcVaf39GVB30m2rEqKt
	SboHHhMuVqRyCqTz3rMXLWfDpJJKqOk6nI+f0P9fY5KWObKMD4rS660G+6W9+cL8j+aUfnS8hFk
	mV6bjCcPlvyDsbo1tVbqiyoW07za4uD15PgOWy9liLkb2rcIgOBAh59F4IdBRJ0XSXSulH3Gbz6
	OyLGvCG+vXR6+nwFg8GigcMNEtlmcolRI8vuSgvvvyp+8EDi9s1XHVE7SYRIWVV82Nw5QCDfBdN
	2uZmmtAqFdDtmKQqk68Pgjw4Er1Ld7eiNQpIyYGsDHke12YsUtqRfINEYfVvsqGYr9+3auupmB+
	EWu2MnTEgxRwtcn8MMcIDeH0to4fKEiUAZlYAb3z8=
X-Received: by 2002:a05:600c:47d6:b0:489:1cda:bbb7 with SMTP id 5b1f17b1804b1-48e521d750fmr5444365e9.25.1778010797484;
        Tue, 05 May 2026 12:53:17 -0700 (PDT)
X-Received: by 2002:a05:600c:47d6:b0:489:1cda:bbb7 with SMTP id 5b1f17b1804b1-48e521d750fmr5444215e9.25.1778010797109;
        Tue, 05 May 2026 12:53:17 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e52859ac7sm1625355e9.1.2026.05.05.12.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 20/28] KVM: nVMX: allow MBEC with EVMCS
Date: Tue,  5 May 2026 21:52:18 +0200
Message-ID: <20260505195226.563317-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.54.0

