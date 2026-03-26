Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D1426ED1
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549097; cv=none; b=nPT6kWKoRI6GQyuZXntS0l0iaxTixWrVBvVjuk78CIfaGb3GwVuMQc23ARd3DDGWskPhByjhxNhya43gXqbf/fRS+/ep5IUp+m9SKmgAY51vgQH/I3N5IJj7vfrB8LTgWGcXlRHlHWcEQrNbQ30n5Qi/Z04ZC0fFtXy+4le3QPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549097; c=relaxed/simple;
	bh=xKUgHxugBoabM3fxRuQQHWI7f4LSHWH/O9NGxy6QQUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjH94hmPlFrzSvSD9lKAV1rbbFzdOp7JkJ3gzCp3zl2WqhYBw0IWZotF+vqVOn6MIhqIEoclFJXB+YVQxqNZggh06z2ML28rj78xRWQz3vFQLOLG0+ovyTlh/RuxrfQaVZxJ2Vp1jMilrtmucxWOnaI3hkoyIjy4k2L1FAbA1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUDIHAYi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IB5QlVKT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUDIHAYi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IB5QlVKT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WfiNNSEjHN6RC7jg/KmpV4mpRSoDFEjBNWlKFZH7iQI=;
	b=LUDIHAYiIyhMM1QBQY66uZZELoYD01vjW4etyeDPgDyg7f1b51yGH4Vv2/mu5ffu1ofdgd
	sX8Mh37H082xfJOTYPrfIVfnM59jweVOVw2WtYZbzK14sLnd1VRQ2KrRp9OrQuORZw0ir2
	GlUB6V5Jl5nAWj9Ei343ucUrKLViGcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-1YYFlURDNFiG3mip_yoTwQ-1; Thu, 26 Mar 2026 14:18:13 -0400
X-MC-Unique: 1YYFlURDNFiG3mip_yoTwQ-1
X-Mimecast-MFC-AGG-ID: 1YYFlURDNFiG3mip_yoTwQ_1774549092
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso21442125e9.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549092; x=1775153892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfiNNSEjHN6RC7jg/KmpV4mpRSoDFEjBNWlKFZH7iQI=;
        b=IB5QlVKTu1D7q8C2qjcGgR7SDCRJDdMuTjKcmcVhX+8i0utlGQxK09no5NPU2HNQ3a
         msFLIizggc9IbUfwIRkuZlsYxMZyQJyBunFyoD3v+Bbg0Z87k+tMwuJ/4X+lB2Ff2RiF
         yh3V67NiODLL9ZlsjCg5LcVgajGnJnfz8f2GfWNY9XHdGoDGr1cx+AeVAOETDEoYJWpC
         DhZPfu6/sFhqzEZRBstNmBvr8lTLTZy15lq9Ctz+4ZHOX+zLHK1M1UCgIzNtzXr8/u1q
         h79xpiN3AVmwuvfiAv/SoNUCJUe2Wk/cSwNg+1Qn5+ZSCBYTBnzvQWE5lmxyCR92bqzn
         wg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549092; x=1775153892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfiNNSEjHN6RC7jg/KmpV4mpRSoDFEjBNWlKFZH7iQI=;
        b=Tx70mWf6LWN2rcQ6yyyhuU687O7lDU/jAuBI8y9tEvGkFxE9IFkF0Wqx0xO3NlNTyI
         5dm0NKFpHOs4GWbPEbmo7YfcLrVKdifY2ZXmIuiSgrIktquiCcsu7uXjb7LDmhtFyMpB
         p79WUEiMoi9WjfQPJKtlu1LXax7NJkvsM585l0rb7p3RX54sh4punxua8NBggsRGR/v6
         g0GLGUHlZw6Ba5jmIIR7k9h4qfNWq8UaOj2BjZ38XgEuPxH3aY4+Gw7liqDaWkZKEuvp
         cEpfiMALLQ+r/XiEQZfDVQNdjyQkU+KpxM5zOcVLt5gcOqo5rCXNPjpu9DukK28jM2g7
         GZAg==
X-Forwarded-Encrypted: i=1; AJvYcCVlA4TNtPdsKJht77199E4MH5cySccokzT59rx/iZ++qzmkLvwRXzn9vbznTjftoFKK09c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/b961qXWHOizJnL6VjfdyP8ntrVFGdALvLMpIIxZrsHrTali
	y+LLEU+CcbNb0wBAr4eYyEDedymJyfjCBEFignXsnF7axbW8aH3zhbktBfqAH4AfsiMSDS9WmQn
	goy8JWHNETcYd2fXmkSpvJs//1dc2gZdl7BgTzKIsND2/hLG7CcCs0A==
X-Gm-Gg: ATEYQzw70vj7lH905ZmbPU0+7bf0NwfcUk4kEU6Yr0cSF4SV4gt+zeznM8Nawcpy/1B
	SJzNgjz4CY9y2GqUVlm5Mm5f/Y1wLv9agqotRRTKKFJvfW4G5EzJhFRhfcdTTec3FE9Bxoaxbax
	rkoc3xTkmtIv4uYnMoMqhNXFoxdrA2siY+3zN+l3hVwh7PAcWQXwXvR+SQzOuExmCdEKxYi+OEB
	Cqa2NRzVjjSZIvFIo8b/ERHLmyX6tfcmBcE3dzO4Cc6sd67aBAHY+VeVIRPZF6MeZnLv8KI/LVq
	heSaQVa16hHWD3+gg5rcALNTiB+qw0qvndo1L7YvSre/msjOGd+O54J34OkknSMCgvO62u7N6Q4
	5Uxs67C5yV873F62WLPE7kSq2AHgswQky5TSnv0C53TbHoEr1a7ELp81c/UI8oPq8YbR+gFDfL7
	cyCnAJoiNWIzowmh6R/hE+CKb3
X-Received: by 2002:a05:600c:4685:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-48715fc3562mr140300065e9.4.1774549091894;
        Thu, 26 Mar 2026 11:18:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-48715fc3562mr140299445e9.4.1774549091379;
        Thu, 26 Mar 2026 11:18:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cefd7sm9662731f8f.17.2026.03.26.11.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 17/24] KVM: nVMX: allow MBEC with EVMCS
Date: Thu, 26 Mar 2026 19:17:15 +0100
Message-ID: <20260326181723.218115-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
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
2.53.0

