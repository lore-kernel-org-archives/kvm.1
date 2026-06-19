Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B03C10A4
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901120; cv=none; b=mEsJsmGBdDRdpLYsQqar+vRhKv1o3E73ZTtxGzK6rStofNnRFxV4yRBH1+3WSjaTPJILeqyqiNxie22/4DdqUQ92bM2eLx2IRVoc+BPQhqF56qhB1gBj5+mAxlhO9LyarmJpednYJmPvBRflYByl4R3B55az7cj0nbm2NIKUs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901120; c=relaxed/simple;
	bh=lqeXZvwKd2+gKyapbikEC8uszALCZyZ/DkHgKCMSiHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRbNOhuevmnf3izeXyYtySh020Qzfu4TLyOkT4pfcvhrm7RW3jNuxsHTRF8uVBiNfFcupK8z2c3M6/XyLj0zXExrsdsAxz+9KxktlbGn/kT7uE4JGyB5zOOJ+3tSy+OB9PekWhIyMRlHyxnRX9FGlZlKHVam3gq/hlySekMBUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQFqgbJi; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQFqgbJi"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9185503e6a5so294616985a.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781901116; x=1782505916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Rfwd7WJck9jEb6I6f8Juo4t1Gf+3WTqdnf32I0mINY=;
        b=UQFqgbJiqXW1j9nL3ahEAjmuNLPbFqp+JOMUClMofdKwv2rb2DF363xEt3VQC/2yt8
         53YwOJcfGjjGtZWY9/BcssSWG53PLW1sZZIQ7FkmYpN+YPkSMf/YTvO33H5QXDfRRU5N
         h+rPQ8SpqmcREFaWuQN5rQLyS6Z2SoEvboEs0NIIN4lzSEqjbZDkpjxT4nnRdk9PyyOb
         69SXB1z2SLDgsPTahyogy4hX2k67dbEfiXczVMXhhK7DR1mgjTFlS0BY5+X9Ko42ycyX
         KGf2OOqSv6bpWyxaIm2HwBPf2c89fIHo8dB0dJjTryRnIJBKjKOs2uwO2AaXBsW4T0tC
         lKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781901116; x=1782505916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Rfwd7WJck9jEb6I6f8Juo4t1Gf+3WTqdnf32I0mINY=;
        b=CVAFALpALjfuSbgip3OrZM3iLwdhK+lNPEzWPKWf3wFAtuy6C8+DyWBrUN218TlbEe
         R2qbmWqye9fjYAiUGis527nmoL/Vdd8wDvQi8UxI/ipZeNwtJE/Kifj4UzwcZpefUpMy
         xKHYgJRFxJwpQHUnQp/t3OBVf8LsboCe6N6b0gl/urlJGgi/45+gu8G83zJB57c60qnN
         IvXPpCigb5gugu3ZtszmZG7AYg/tsXefuyr6ZwnaN9j8KZ+z65BJVm2kQCAKaaZqV643
         Z/1HWSrO2asxM/Z1wwbJqtNMGTz+8v3vZt47lYyFjs9V0FiWlBEmQYONeXt4ikKKZN4A
         PqSw==
X-Forwarded-Encrypted: i=1; AFNElJ++tprHHqxT7sNmjivv30PKGxJqGW2zGYb91ZWw0W5/hm/jTEmbLgIQ60ghYiudJP/R5qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgIR41AU1BftAT4RZgn+HLiQmUL5pyyYRaaCM7xn1m5eWwpRq
	9z5QBjESvlwc74KyD6g5VBuXsZf4xEUlpYRaTiFiNyxkl0MTw7mf0vgS
X-Gm-Gg: AfdE7cmGzi3EmMH7/WJArJo9Em+cY/YWrkXZrDUQ8nhaAq6hACESv2+KO2ue23Jpl7d
	CDRfG1F1SxtePiszX92IOsP6PREIIB0J+g7+SZSX9DAe1ksQi8lN3KqIsWVzrWVfbK5acr19Kev
	uQgAprwxyY4Wgj/Hb1NtONWKf/ugUi4g7qk2zd3p8HNqo/svwdKT5UcxHmZsCc8Fd/mdIzTeNDb
	dWdTpsa2R4mmyQIb1e50s9IoDcLKSK4RvaMwEtURzL6Zgks8oq9GoBylNiwMeqHeIg0mYGXMUrj
	zcwRJF2lFht+vjRQA1IbTE9pHtcOvBYV0I23ucy0lWtxscgABCUHJ77L3l0thHZ88ZMpjaf/stU
	8GIZpTyj8KwGjqetgvgmZeJo+Yi3i06UXGIjz3ttkentAT6aXVpuJkquZtleXAk/yeGiXCFfo72
	a2EcPbICpqe1WI/rI=
X-Received: by 2002:a05:620a:2949:b0:915:9da9:b541 with SMTP id af79cd13be357-9208a8c738cmr623400585a.10.1781901116228;
        Fri, 19 Jun 2026 13:31:56 -0700 (PDT)
Received: from TurinLinux.. ([37.19.212.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015805sm11106986d6.1.2026.06.19.13.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:31:55 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: stable@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	gregkh@linuxfoundation.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	0wn@theori.io,
	mlevitsk@redhat.com,
	jmattson@google.com,
	Nicholas Dudar <main.kalliope@gmail.com>
Subject: [PATCH v2 6.1.y 2/3] KVM: nVMX: Check for pending posted interrupts when looking for nested events
Date: Fri, 19 Jun 2026 16:31:06 -0400
Message-Id: <20260619203107.2752678-3-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619203107.2752678-1-main.kalliope@gmail.com>
References: <20260619203107.2752678-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 27c4fa42b11af780d49ce704f7fa67b3c2544df4 upstream.

Check for pending (and notified!) posted interrupts when checking if L2
has a pending wake event, as fully posted/notified virtual interrupt is a
valid wake event for HLT.

Note that KVM must check vmx->nested.pi_pending to avoid prematurely
waking L2, e.g. even if KVM sees a non-zero PID.PIR and PID.0N=1, the
virtual interrupt won't actually be recognized until a notification IRQ is
received by the vCPU or the vCPU does (nested) VM-Enter.

Fixes: 26844fee6ade ("KVM: x86: never write to memory from kvm_vcpu_check_block()")
Cc: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/all/20231207010302.2240506-1-jmattson@google.com
Link: https://lore.kernel.org/r/20240607172609.3205077-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Nicholas Dudar: backport to 6.1.y. Prerequisite for the next patch, which
  folds its check into the vmx_has_nested_events() body this patch builds.
  Applies cleanly. The for_injection path still returns preemption_timer ||
  mtf, as the previous 6.1.y body did. ]
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7d8e18dbe..ad07e83d2 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3953,8 +3953,40 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
 
 static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	return nested_vmx_preemption_timer_pending(vcpu) ||
-	       to_vmx(vcpu)->nested.mtf_pending;
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	void *vapic = vmx->nested.virtual_apic_map.hva;
+	int max_irr, vppr;
+
+	if (nested_vmx_preemption_timer_pending(vcpu) ||
+	    vmx->nested.mtf_pending)
+		return true;
+
+	/*
+	 * Virtual Interrupt Delivery doesn't require manual injection.  Either
+	 * the interrupt is already in GUEST_RVI and will be recognized by CPU
+	 * at VM-Entry, or there is a KVM_REQ_EVENT pending and KVM will move
+	 * the interrupt from the PIR to RVI prior to entering the guest.
+	 */
+	if (for_injection)
+		return false;
+
+	if (!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
+	    __vmx_interrupt_blocked(vcpu))
+		return false;
+
+	if (!vapic)
+		return false;
+
+	vppr = *((u32 *)(vapic + APIC_PROCPRI));
+
+	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
+	    pi_test_on(vmx->nested.pi_desc)) {
+		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+		if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0))
+			return true;
+	}
+
+	return false;
 }
 
 /*
-- 
2.34.1

