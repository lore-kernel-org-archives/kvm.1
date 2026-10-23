Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715841;
	b=mQO/zGcwdTb8lCZldtWXd6FG28U0ddfbdeH2sj0MtzPNv+OCBuUEMZ/upgOBEDYdeQAB
	 cjYSX9Ex5tI3CRHNoif0rEQ04HOgSFBo49LiyxFCqmhHnavSVVOt6ptrxm/UfxjxFF2xd
	 KK5Op0RSF8uSfFmhFuaAmgviH9/Okq8rtJQ9HWyazyhjFtEhqhcb6V7u/VKJlUtWyymTM
	 q7VltlTZceN/4QwyddSOm62RP5WbqXqQtwYbgVBhtLG/ZErzIfwIgDUYnvPhANIGCaeBe
	 //zxeDYxgGGdjTrCmPjYm2jIAosuLaMsBP2oj5JPklaMVjnTfJSsmKvv1/oPL4PfOfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YVFoARRyDhWwCcbd94jHo7cx2P86k2KOzjvIxa+ATEE=;
	b=wxwDLaUVpA2YkgeE49Kb4QpDoxQfRKqReah4ubit6yT/0qu3WjOS/fROxqqWFCpGdfvs
	 3MWUYe43D1Y2RNnSzsxrsXiqMsX7c6A9i579CBzUTP4MiV1LnVY36OHH14rQOxWKcAxiL
	 S0fzrRQ4UkDvbx9sztLbT8HPRCUKRsW4uwFFy+8LwKKRXNsk0ZJEpEyEWkkqghhlon0aZ
	 NmjAhB2em/XCAYVKxlDZcvxbDmWgffmLB+FQkxHbOOoICKEGAX+pow32j8yqrHV7xTitK
	 gnT0mgfn0XM3X2pP1gAZYyfIok07Vag6QogqZ/SicBZe9CI8bMfFfWlCHRsDWSzWX/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LjfOx0RY;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271E606A321
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 00:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0271E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LjfOx0RY
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso308380a91.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 17:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792715840; x=1793320640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVFoARRyDhWwCcbd94jHo7cx2P86k2KOzjvIxa+ATEE=;
        b=LjfOx0RY6nzvohY17V4qx6pTgelLdrZfXpySoTk5b6OrVV6t5b5Lj8HBwFvyE1gSxu
         4XN+NGGw4p8uYMZDvFbR2amjRjnG+CmwwNPohSteERFxSOmyRVzwPOOIfsvVKJRhtHed
         aBHqTRthBCpoDWPNtHV04t+g203RqNUOEFDtBmOhVWPfu0cxzMJv1LhZrg5hJ3FB1WCB
         6TVYKY5fYlBknl9kj7rHRw9rrf9piZYyQcVrD5vFDrgJxY/A2R4HqY4n+pB9ZtBTGAhY
         6YE2z/Lcjdl3y5lwlIzWTgrzJ4xWMSPOeChOQZTbIEchKanMlcxZgi8ofpUMoOT1fq2t
         CuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792715840; x=1793320640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVFoARRyDhWwCcbd94jHo7cx2P86k2KOzjvIxa+ATEE=;
        b=WwGWiKzSOkj2Akn5v7kJbE8evuw4peJo5s6gDfSlFjtatev/Tam3hFtvULPKOkP3OC
         VJRnjny2KIs3+ZGq6N3vuSyQ+U+On0XGFTMt6TpikkOfACscbPzhBP/TesERNk3cMqoW
         P8+fagGrdn1z+FDjk02yaXX1UVbaAQpR/hhGj/RyX8HVvWmy4a6bnGsJcYkZbAqv2h6j
         TPt9U6lLOj/OQg+Qz6u8b4x4tvLcmBHI+RkVdiaT7GAwpDqu677haPMG+DtFKlUuMD24
         1vQn4QGpLpy1ENmwwoZsGB8tA/hjrFiQAvwHnpw1528dGdbqPL1SivgvclqpOxSQQf8o
         umvg==
X-Gm-Message-State: AFq9FYLX8DR+LGe3zxk2Z9eyNaIS1trnsioRbEF54RT8yuzLZcMV2jLp
	dXdglBJnROW3s3k9FtoRff5KTG1lRV+0ynx+YCxETH7TOvgMg8rbG5m4
X-Gm-Gg: AYBFou0x4ay9fujP5NFzoS0RA3rja4sZ1YE1IMrnO7vmmwQtN4hOqO7DlZlibjNSrph
	4EpwHOhIzLaW5k+dC/MtQ8buOozas5Q4JIhd+IzTk1HMfhNzrgXPHr1RaAYhbRdeY/t+pKATfSK
	5jHOenoz6RFl8pM0EPbW98ggBq8BU2wj1WDwRNWNJVhutKrlxJDRo8c4JtPKWEyvWbeBxzNT8/u
	ztxRzz7AxvEnjssiRK32kvsZqM0t22TfNMt5zxaTWQnGV1epCJHch/YJm8uPyYMidXt+bAG/DBv
	GXqeyM2HhkA3j+FnKtbjYoV1BvUILu9Y1LwX0ExZediWztzxr9DkFPk+yVWzqAU1Q1uq9c87IU8
	YS3gqbXLditybHJmGPcRD+9imZWxOStRotNbRxzE+GxFiW+g63uTX0JPeIONDjzrQHxaeyKA7pm
	vX9vPtOxdenVoVhp5a7iJnOizZ7WbTyj323J0egJVrWxWO31sCUgCUGq3opIu4CsI/1U5QHhCPJ
	6r06Pb6N4Ktt80f+U5KATkJ+xAXbFDd/C1R0Scd2139uIaFbxpU56fQ9BYEbhC8Cyyw1Y7E4gE1
	uHQDhBl6VHYkevYwjL5c8LWWRa663mjorVqTxyLK/GNIPfVN0ypD9ffIyjJi/Va1DnviR8XATSr
	E4CZ23bPD04nz
X-Received: by 2002:a17:90b:1fcf:b0:3ab:afca:1d79 with SMTP id 98e67ed59e1d1-3adce7a7ab4mr421783a91.21.1792715839221;
        Thu, 22 Oct 2026 17:37:19 -0700 (PDT)
Received: from monk.wireless.sfu.ca (border-p1.nat.sfu.ca. [192.75.244.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a28f3sm964360a91.3.2026.10.22.17.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:37:18 -0700 (PDT)
From: ma.mandourr@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ma.mandourr@gmail.com
Subject: [PATCH v2 1/3] KVM: nVMX: Fill VM-Exit instruction length before saving pending event
Date: Thu, 22 Oct 2026 17:37:01 -0700
Message-ID: <20261023003703.450577-2-ma.mandourr@gmail.com>
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

Fill vmcs12's VM-Exit instruction length before calling
vmcs12_save_pending_event(), so that the length it saves for a software
exception isn't overwritten.  Commit c3634d25fbee ("KVM: nVMX: Leave most
VM-Exit info fields unmodified on failed VM-Entry") moved the assignment
after the call.

L1 sees no difference since both lengths are read from vmcs02's VM-Exit
instruction length.

Link: https://lore.kernel.org/all/sashiko-outbox-179791@kernel.org
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..6f7c00083beb 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4764,6 +4764,9 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		 * instead of reading the real value. */
 		vmcs12->vm_entry_intr_info_field &= ~INTR_INFO_VALID_MASK;
 
+		/* vmcs12_save_pending_event() may override this. */
+		vmcs12->vm_exit_instruction_len = exit_insn_len;
+
 		/*
 		 * Transfer the event that L0 or L1 may wanted to inject into
 		 * L2 to IDT_VECTORING_INFO_FIELD.
@@ -4772,7 +4775,6 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 					  vm_exit_reason, exit_intr_info);
 
 		vmcs12->vm_exit_intr_info = exit_intr_info;
-		vmcs12->vm_exit_instruction_len = exit_insn_len;
 		vmcs12->vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
 
 		/*
-- 
2.43.0

