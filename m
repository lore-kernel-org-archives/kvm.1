Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868244;
	b=I/yhhESyvlu+ybrbb2oE/kf+ZpA9oefu4RyQesgZ9dppIKLqSW624kzzAFkNU759dW8O
	 m7Q+tB+lZ0ewrBc0SHpydl2aDqlBDEWXEdQYCsR/Nx1gA8WPTwFBxLtoZ5Ov/Ekc+b3k5
	 Cth1Tirs/b0ZjVZTGCuJKqiUfgPUJoJQpgshyZN2/GI+YDh+93osDZjxtOCqf9E7RsvtQ
	 qjYoapzTBLu/9XBYAJqtkZhzWN4VQYOUaM6sqHrZFcJBt6zNWmKonFo5uYIZpbbQqHJ+6
	 WMSAhzncDhu0GVFbjt8rRddRt0ndK3XjDkX4SPZgbAnfSm1zGGJ85wq/Pk3DWgQeygA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B1pgJpHZxzaIzXBsZ+Z4vsnOXSIkO8E4tFap1dSVVuQ=;
	b=2gQMdMyebMNFTHUp3sADNZHYLcRzBwLMi7FRgSmPH4/TL+5Ggo+t9OwQ2xtv95wTxvN0
	 aacHe6CH19br7r9gJF3lU5vmnSrS2vlmERHFYJ7C0EiUWg1apQkMIIVZGRrK2cma5faeV
	 8UrREvisgupEzJPp2jdZggUWvaRcM/NR29tJNYLlQtjZixiKabZNPkctHVe7UHQclEuxl
	 qJGvUL7XMkGcyMf2XYu5SXKb4JW9WLZX5trpkRO5eov+UDCS8TG+ARVxZvau32T0qL6BJ
	 b5AS8jEfTJHmQos2/ik8fxgQgpiCkFAtFsYzwgCCii1bE5vnyD3B4vkapm746s/FLYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kus/1aZu";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A14606A89E
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 22:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0A14606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kus/1aZu
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e98798cbddso20870555ad.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 14:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794868240; x=1795473040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B1pgJpHZxzaIzXBsZ+Z4vsnOXSIkO8E4tFap1dSVVuQ=;
        b=kus/1aZukfsg70PNmTubeHsCUwpl3XDe0PNmK2yfumVvtCw1uxFs1sGc61sevvdntc
         uHeM9eREIbnoc2nAMukx5ay+tZIeDA47lOq0EFZk4VdnOPzfk/8DQqHuklgiFDXDVZeG
         PdRwPxC5ALuopi7lImBfPXTJCfokmdjEcc0xxqG1pz6ZY9zjjH/5Lq6xQp+GS/W0GTef
         R6SJusVqqwaxbFynnKeF9Q2zxTyGxL2WgVEpLJoLr7sE+8bUdiP4AtDJQcz9bFo23rlN
         +8l0fFBe2RYUQXKanY8qRwnupODs4umq3LHMP60Fnpr19u0ZZZPeTVE6N1A7/Jgh545a
         RszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868240; x=1795473040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B1pgJpHZxzaIzXBsZ+Z4vsnOXSIkO8E4tFap1dSVVuQ=;
        b=xjOJRdkBNHNncR+ZCw/rE2IKX1wnqKfg6GyFA/4cLNK3XJHhCjSZMsUgyee3sm398B
         wUgLqCnkRh4K28NqmBQrjOlDO9f8AM4tvRuEB1xo+qNI6dMvXnJdVfkknKrCFPdVtgv8
         HFc/FKLcSO0oa0P/RBR1WO4q/1mMAQgQypJCiRisFgkc7JVbv9GrcHHaljEIX8SeNDqe
         h5bF5kZWxVU70g6yMSTtRthzHhueCpNFM9ZjIvrC45ML82xkNKJsaqAeMSG07y2T+SLM
         retfKtxqobQFXrWO5hL8/QwKVn78x890LfMFxDN86oQ4qhR3uzxiUlvoH8MtP+gNyIga
         0baA==
X-Gm-Message-State: APuU4Z/9vLDGqkCiPn4zMBZNaiiyHTPhPLRN2oNJlilK5U88cYrMgy8J
	AdOhK4co+6keVfEJMEQSJELjx69JHJn11KT/T1kO9eJseFYQySmPk/oe
X-Gm-Gg: AZFdTZflCh437RhF2K8w+oZOSCf6gIU0U1H9YF5+f3M2b2Ij2jSOleUsrkB4KVyV1YV
	D/78TVqpA9V5a7HisMrNAmkYDlpJ1MOTbzDjv4xIjYg8+3CCMCgSbAEO7y+SHD5CPwG02VwB4QR
	R2nmccemm9fvnDCNfalH5clF8XV6zrka4hKb7ZMNG9Jfr2qcF9vMS+xckPjWPdpCTZuLbqLkvU1
	/DjGJkZg/PTJeAH4g3KdlpyhGQMS4zVlk3kInUBIUAZibgrbrvWKxy97dX8jMCa1ZLXOnMfdkC+
	t8fROppPxJKrsnZIaRoKMQZevDOmw2vSKoI3fOxAJcmqIfmtEtR4L6b6T5GmW2Am0j1o9btFB6u
	Jag6scjYwzMiFY18XrtCByWp+kfa2JuUJjnshZk31E7nNy6FYv5NW0oG/4oDKj+VOZRrplvo5bm
	6g3cNL/GNH4shwgoxscfhgQIeU27+CZB7leNmIWv5GoBkph9tDzklyoLMuw/NR91Ybp8ahOmQc+
	PwIKhnMKFuYIXwCTfvT6nUpvm4cATzRgzOI5THVbX/Qq/sw8uwGgU3V1BxoJxrF78jBglgp8eEq
	TSz33okEWcFOVOLLyruFhzHgTqJUF7XxCdjRXXJJqemVpctjwNcvI7vol/xnETtqw0pahVEK2Ma
	Nls0enDXoJEQOO9UUNqhCf8HLH64XqLnSlkoGJjcdPoc2IxwEJcUHI6vhRS3JuNlly5BLcElh6a
	s6VXOD5z/W0A==
X-Received: by 2002:a17:90b:1c81:b0:3b1:7329:a127 with SMTP id 98e67ed59e1d1-3b1b09f60bemr10600304a91.20.1794868239703;
        Mon, 16 Nov 2026 14:30:39 -0800 (PST)
Received: from cs-arch-srv04.cmpt.sfu.ca (cs-arch-srv04.cmpt.sfu.ca. [142.58.10.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac255634sm944375a91.5.2026.11.16.14.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:30:38 -0800 (PST)
From: Mahmoud Abumandour <ma.mandourr@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 2/3] KVM: nVMX: Don't clobber VM-Entry instruction length when saving soft INTn
Date: Mon, 16 Nov 2026 14:30:32 -0800
Message-Id: <20261116223033.3866283-3-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116223033.3866283-1-ma.mandourr@gmail.com>
References: <20261116223033.3866283-1-ma.mandourr@gmail.com>
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

When a nested VM-Exit occurs while L2 is vectoring a software interrupt,
save the INTn's length in vmcs12's VM-Exit instruction length, as is
done for software exceptions, instead of VM-Entry instruction length.

Fixes: 5f3d5799974b ("KVM: nVMX: Rework event injection and recovery")
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e8cc0fb308..2bf38db8e3 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3993,7 +3993,7 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 
 		if (vcpu->arch.interrupt.soft) {
 			idt_vectoring |= INTR_TYPE_SOFT_INTR;
-			vmcs12->vm_entry_instruction_len =
+			vmcs12->vm_exit_instruction_len =
 				vcpu->arch.event_exit_inst_len;
 		} else
 			idt_vectoring |= INTR_TYPE_EXT_INTR;
-- 
2.25.1

