Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715841;
	b=aWdBBo2VsD7h0I9AT6r9G1jMAlJ/5ly9p6Y224FnwcE8Wqnl7353UE8sm+M/KchvVQbf
	 on/T/BLr1PH6Mq4IiL1FMsdFZcgpSgAiTBiZP6fAa2x7k/UlMjfdyoZw9yXt3xNql4z8p
	 SuiRXCW96lXeJHFPuCrcccvkGs1JCuQ99al5WephFfJFrQ2snrnRVNhMZWRrfSFHABZfF
	 XynnhmwN4hU0A7YBATFA+XJlimgdBaUA6wOB8PTt/lpSF4mFNEzm3w304volinUjLwiAZ
	 8bpq42fEOjDXlwZ3orGlpRXWb94tSQx4U7uh2OOxvoo63MvPNN2PfkU0u5xzYCHeulg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qeq68Q+CJWiMtIHtxnnAZC5/gq7FwITJWmPi8p3IhTY=;
	b=gzcilxciQMoncS9svJ6dNXb9+ikCeOeSY+QwtroyRbJDbf0nqvDuFCE0T+dsIUQRmRB+
	 qFxvmGhTJVBNEEQciuABAalQhLvOFvyTtWYbGEzUT0LBi+XYxZ+i9PxGw0wRL4F8mce4+
	 kmF3NlF4yy4G7njcI2E2KSpBgbTANEl/qewXR9Y1Ve4EesHSmskYOgNuDJY3WOJk38l0X
	 NFprucdSW3b1y6nXbcRONPqTb9P4kV7CvD3/hZfmt5FBABZE8QXC77oa53C7Y9Bmjv8LQ
	 xGhm/YOjRJ0Q5QY+8neAScL/OEPbeVMKG7P550H0kxEEjpoGulL4aey3Fl8nQ13lZRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SdOAjaja;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D025606A31B
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 00:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D025606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SdOAjaja
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so277558a91.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 17:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792715840; x=1793320640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qeq68Q+CJWiMtIHtxnnAZC5/gq7FwITJWmPi8p3IhTY=;
        b=SdOAjajaplVPPBwB71aA1nIf3KSbB2lRyIewUEZjhub9eYlcYp9QJ2OOhzE8GwOzg6
         smD6BfYamd1Ir/oKrOkPyoB1efap1Iem9Yp5qkqsRLfOl6Aq2Umy3dnNfQgZLn0so6vX
         0BYuq/cmi6Da576GfuiXscF3YIXug2mxrad1Ya/RA1aPIR9aoxU0wiCNn5xI5ul2VNRh
         KvuTKEpXNf1c8gg1ReiA6GWmGM6NaqfMPj/LelmkS08FcXzx9EDKLCMk1pK243Yu9c8g
         znND1eRsmByOk8PMO0egZRqZf1isYbANkuj1Sj/3xF8Xeeh7twClubkW8rcdytvy2vOD
         fK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792715840; x=1793320640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qeq68Q+CJWiMtIHtxnnAZC5/gq7FwITJWmPi8p3IhTY=;
        b=rhMi+di1XNLeP6JG+pQQWKjbHULMXEGl6u2owGsrMArdvpfDYbXBrARrdSpogfWm43
         PTaNN82Kz8MJFhWajHZQAxBNBFDLljgT6D5NrPuwgPmpJVxcAT7Eax6bVjpE2ikX/Nun
         5bFf81r+aBwbpzfH4S002ccl1gztR8j0AK9c97MCdTAfKwbB293iA5JaDGXiXft7sToP
         2peSt/jf1DvbScWFdJxDD2rIGDxFqUb6LJ7zcVYb0jUyUR/YqX9tgl+aJ+R8B4JT9PWq
         l3CNS4aQ34Q//9W65uvwMvDyBqyzJdSCvLeQU82gh1I0+AaKdvAWIWNdpn+7oxkX81m5
         BEyw==
X-Gm-Message-State: AFq9FYIH5yIClXz3UW2AXlDlemm9FO7QQ5iEj+mhGhYUHGxO/pML4VHt
	+wkoKAuTNINu2X+9hqz4vAwGvNZuSCJmt9D3VtCzgAhJSSDoqwSIQvZ75leYVA==
X-Gm-Gg: AYBFou28Z8NF08zapSFUw+A92ws86KnFd/pJLKNYgCTLlZz9P+19dxAzUTiOJ782q49
	7UeyIS0nRWsT9n/lxQOStPn+qrv3e0JG/6e9USvUcstLxcZ1s/OqNnndDz09ssvPHTHC8JSLQGT
	mXFHUYJDCgYDAah1ua23+e95iH6vUQHDDG95lKPCxNsbB/t1aTY9Sh3gpL4VqgtqDH1um+yWrof
	wbJtIkcAIc7EJTJQVl7LiKjExoEjLXhTZEsRHk4k/i2wurOAV6iicxBVNqcDVfrdzy8aztB6KuZ
	DxD7ee4HRQ7ypQHhnBCVlh9pU30bvseeGsF3NToAeoQCqxs93xAvjL+LGAJLKwIuFCWzVoJ5qxy
	gVKxbxWyrV7znpK9Kl1w+lbiqk5j9YIVmHS2oAbwKMacFZazMXHvmNBjmYvi9cm7yGxlIoulpfN
	wXVWxeD2DiD0FY76rAGtO3Pe8usXs1yVYJ7Akr1T3BGCMxJrEElCUs6hZha+yJT2VPwc3hkcQN/
	Lj8i/aSyg1tCVnegBpjTFhIMJOKTbwE7tlXOIbwT8ygbU6vZzEIAEQsPFO9iM63+spFrdWyhu+l
	nRezy1wviQ1gKGRZ+mr31H3+7LTxHNzuG835+vSRRbu2j/O5o4/5bISo1D7BSrZmy+MubXCZq3B
	Ko/sx5AM6+APY
X-Received: by 2002:a17:90b:2281:b0:3ac:adce:60be with SMTP id 98e67ed59e1d1-3adce02ec73mr376652a91.21.1792715839853;
        Thu, 22 Oct 2026 17:37:19 -0700 (PDT)
Received: from monk.wireless.sfu.ca (border-p1.nat.sfu.ca. [192.75.244.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a28f3sm964360a91.3.2026.10.22.17.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:37:19 -0700 (PDT)
From: ma.mandourr@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ma.mandourr@gmail.com
Subject: [PATCH v2 2/3] KVM: nVMX: Don't clobber VM-Entry instruction length when saving soft INTn
Date: Thu, 22 Oct 2026 17:37:02 -0700
Message-ID: <20261023003703.450577-3-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023003703.450577-1-ma.mandourr@gmail.com>
References: <20261023003703.450577-1-ma.mandourr@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mahmoud Abumandour <ma.mandourr@gmail.com>

When a nested VM-Exit occurs while L2 is vectoring a software interrupt,
save the INTn's length in vmcs12's VM-Exit instruction length, as is
done for software exceptions, instead of VM-Entry instruction length.

Fixes: 5f3d5799974b ("KVM: nVMX: Rework event injection and recovery")
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6f7c00083beb..4286b0503046 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4016,7 +4016,7 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 
 		if (vcpu->arch.interrupt.soft) {
 			idt_vectoring |= INTR_TYPE_SOFT_INTR;
-			vmcs12->vm_entry_instruction_len =
+			vmcs12->vm_exit_instruction_len =
 				vcpu->arch.event_exit_inst_len;
 		} else
 			idt_vectoring |= INTR_TYPE_EXT_INTR;
-- 
2.43.0

