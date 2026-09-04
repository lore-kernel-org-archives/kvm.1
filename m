Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890836E46F
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521419; cv=none; b=rgLI9dZThhPDBo72xqLBDUhveWu9R9HeHQXbDMokalKixBqtB2U8DFoCAjunQJEJV7Dp6HvJaYrEMMG6p/IQtuTG0bPvdSrUuxON+lRglDmh3ERUsHpaxjM73lgXS00Nga0bGCFD6X9K5jTSSD+pZEW1IGVTs5EdbnXZ2uoq1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521419; c=relaxed/simple;
	bh=216/wYizxGLHD+qkqJ2pEnNxRVF4UfK2elr3VXYWuzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ip2QOcUGFgkxyDf6Yi8LAO2HC8M+lkHx839k1G/8vqyff+ggoKoj53tHr1fUI981eNv3P7DQIzDH2G7niQbRnBl9fhvwWaCbHNjbp219ieLGEcrL1LRq+3rT0Sv2nPXxqJpKsGjKaJGg1okf4lyFsKWJAdEZzMfJtybTnBimikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAkr+sfR; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAkr+sfR"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb6573bd52so935424a34.3
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788521417; x=1789126217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bHwdXwsbeX7yXRjUhV4YagL8g4TaRsbjc2G3J2vsLYo=;
        b=eAkr+sfRBFvzf3GtNYbAkUIN2zGSW+L9ZtpZlujGJfD8cSt5RCys7VEQ0idIcHqXfu
         KQwScQxyCaFozTzbiEsUMT4GgoHXIF+YIlmGU5u96VoWIcMvJJZxTgm04/ut/ZVpjj78
         g6EfZ+ZrLRUQEHgDnWzulJ22IfGIQmdbGJOFl4+IqwwclwVrDQXrDAw2w/TDICoWTYW5
         iBl/kPWp49M89VClOqya57nx9OXBwU16Job2lLJQM6R50Sh14sd98E58AD56N7h94hxR
         9Iu40MwS4dWXe7DKp4/XSg1r4ymglHhpe30mq+YggzPqFc0kUBvq40Lg3fnWbQ8yGewQ
         uCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521417; x=1789126217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bHwdXwsbeX7yXRjUhV4YagL8g4TaRsbjc2G3J2vsLYo=;
        b=jnCjQR771uGmLfFh6iH0JMEFMtTx9iYrUlEfXQwn/9J/wrgO1/IDJALok50qcIRQNK
         8YLA4Kgv26rBhQN0qBCczGv/96jgRl1CAESYLFmMChaIOciSyZdOoGehqtoswDf/oLZO
         8OgeO8Tg81QyWAWs/+rROBOsTlWVrO1X3eXvb2awxzZ+74OQY80HYVKxoDLjtSVr5vOQ
         qMPSfjB7uYj402r+tsx0dBYAI9MYeygUCQpCPOwc20kSQlkoFbPE/setepqCf0U/azSP
         XECW8vw5W/RkpDS9L2/drz9gnnsj8W2ItuVy26oqaNR/z3xVkzBwEXtCVBUwN93ULmYz
         zJ9g==
X-Forwarded-Encrypted: i=1; AKwUvBzdShS1AbeXKOJaTIN7Ijmkm6Bv+V1PWmD74yi3sK+tNKTttljlK/Jy/j3bY/88qPqR2j4=@vger.kernel.org
X-Gm-Message-State: AFuF++nXcMWmxnzieGsz4hewlZRxknMZ6GwRRL9xZABiwbr3oPmRF5eD
	TY/WcUwzJlHXCT2f/9Nig6YwvPQLmYm7G9Mj9YZH78RoZsVdMuK6Rjr0
X-Gm-Gg: AYBFou3pa1FY9oaC+df5fb5+1oVSzeWkPtfz2xGzMRk2VzKXBt+xLgfdAf8xoREytBm
	s0fWtubUqjBAy3uDAYt7uWgZ0wzOXZWrVEgxHSEKZCNwui4/P6vVHO6iKV8Np/d8TyljThSm0a8
	wnWbVXiWuj5NDkHg24EUY/t5jUuZD5LEYY2EQNYzApW819GHe4ZXYvqC340gWYJbXcTw2gbrupx
	SA6RkvXUK4HkpWPOtIMRjAFbhrgIMX97sTZd5jcBv1QVhAAnoiEEGu05WM9qX5ACqRdPjdbWYvi
	NcZjZ4PnQogjr+nIUoCVZpDgZLedfaTBL4x54I9bUOMTVqYfiJklJSQp97sPD1SX0LS600+NuUz
	QkjjJZGLafzHbuN5omRQ9U5j7F2CGWEBka/Y9TRP3l3giDpLmfTZdYcM+P/pZEz706YleAcmyJU
	GAmNDdUppB785Tq1K2/0YOxVw6cNVLe4zXK8tJpPsUFYLqghdvcqymakD909OJJBhTxgZNI20Kx
	qr0gXK2hIDs5XQ=
X-Received: by 2002:a05:6820:c3d7:b0:6b7:46fa:16aa with SMTP id 006d021491bc7-6b746fa1b6bmr1532019eaf.63.1788521415450;
        Fri, 04 Sep 2026 04:30:15 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243908a9sm5509827c88.9.2026.09.04.04.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:30:15 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH] x86: fix typos in comments
Date: Fri,  4 Sep 2026 17:00:07 +0530
Message-ID: <20260904113009.9836-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/x86/include/uapi/asm/kvm.h | 2 +-
 arch/x86/kvm/lapic.c            | 2 +-
 include/linux/kvm_host.h        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 1585ec804066..79bfd945e5c4 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -551,7 +551,7 @@ struct kvm_nested_state {
 	} hdr;
 
 	/*
-	 * Define data region as 0 bytes to preserve backwards-compatability
+	 * Define data region as 0 bytes to preserve backwards-compatibility
 	 * to old definition of kvm_nested_state in order to avoid changing
 	 * KVM_{GET,PUT}_NESTED_STATE ioctl values.
 	 */
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e1f3cea14765..d48615a1a275 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2699,7 +2699,7 @@ void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
 	 * virtual APIC state, but KVM needs to conditionally modify the value
 	 * in certain cases, e.g. to clear the ICR busy bit.  The cost of extra
 	 * conditional branches is likely a wash relative to the cost of the
-	 * maybe-unecessary write, and both are in the noise anyways.
+	 * maybe-unnecessary write, and both are in the noise anyways.
 	 */
 	if (apic_x2apic_mode(apic) && offset == APIC_ICR)
 		WARN_ON_ONCE(kvm_x2apic_icr_write(apic, kvm_x2apic_icr_read(apic)));
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..b9d3ce31a9ab 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -101,7 +101,7 @@
 #define KVM_PFN_ERR_NEEDS_IO	(KVM_PFN_ERR_MASK + 4)
 
 /*
- * error pfns indicate that the gfn is in slot but faild to
+ * error pfns indicate that the gfn is in slot but failed to
  * translate it to pfn on host.
  */
 static inline bool is_error_pfn(kvm_pfn_t pfn)
@@ -2461,7 +2461,7 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
 
 #ifdef CONFIG_HAVE_KVM_INVALID_WAKEUPS
-/* If we wakeup during the poll time, was it a sucessful poll? */
+/* If we wakeup during the poll time, was it a successful poll? */
 static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
 {
 	return vcpu->valid_wakeup;
-- 
2.48.1

