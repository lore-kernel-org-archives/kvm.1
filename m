Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19337DEB5
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113199; cv=none; b=YdmwJbE8LQYv8N0rJDZq4ntU67bCCEyu83Xc0QPKcOfYELMnIA7eZVPTJVO5r/88X/N7V0PDNFLPQiVMDtYDfxnRqDRC3e7Mj10AgKyjGbxvHpIkIzJSuPuYVuCWTPz3QvAJbbGnJbXDUq0dh/Qd/kG+QHeSc1iawLBLyh6FpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113199; c=relaxed/simple;
	bh=nytkPeuVuYF1gSa2DYENLLMelJJmdQX/9/AB1+RPdwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hmvmy4Y2HRsEUdn1fVhwomETMwLX0IdR6EIQrjzFH38+3TxxnYctxKAnPqAbM2R1CfMmzn+gql/teMApzqws8Lq4AGX56f0CJYhiqE2a83h6XO5ZfXSvVI4O7dNHNcJAazHCFNBOXjkHZv0UkaroTKi4btl6GokFtJ1DGJn9d+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xkr24gNo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xkr24gNo"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2ed279eedso11689565ad.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776113198; x=1776717998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a217Abiua2nkP0DrXjLTU5nPmKdcak+GOPBQlaV8zNE=;
        b=Xkr24gNoqpwmKfkjGADf14TfHgdBruC30ZSdzEnOGvzmYNJBT3p/PO0iiutWaHTXpc
         /VdTXlElwVopW6TT6jfeDJpVEmwa7fL+jey/V+X1yqZX2vxsvVsEqlt8yu5YslYSDivb
         5JrtlHtiFshQVvN8ZFRmgM8Xr1KQ6yLyEsi/kFiwCMFeH38QENivsapWOm2Tag+PjpvV
         Vlwr2lKPvqgNxa9lj7tSIaOs3Eve8o5AL6wAvSungtubVcd+AGfODt9UAwwHZMn6Q14d
         RXtIfH5FDcQdwYrxTgXwFQtB6AwsGH+I6Y8On75qmSphnLIckbh0zN3SEA5cLxlJ1DkZ
         hXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776113198; x=1776717998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a217Abiua2nkP0DrXjLTU5nPmKdcak+GOPBQlaV8zNE=;
        b=qqk8zCsjy52oOFNps3fDQd4QJWEEnVQwanvNcfeQ8oCPNKwgnFo5l6biwKMeFa/f7w
         041ZXqNL6K5F9IK0evtJJoKTzY3eYA3aeK03BvOwfFQRRnKyYjd0/oAzflJT3lHOlfuk
         ihrVk6pTSa6VWQXjBUdjaMyE4quM5MOBG75ul94eizIBig6j5oK0cot6bZ45CbRO2T4O
         bmYvdWML7EkkozcrV57AiL+Gk9XFQkgEIW6aeKt3zo8e43jUaJTHeBY30uABTacmKHZK
         +Ed4jDMjW+wQ2bsLQqLFKeDC/Isau3fJT6cWlT21r75FFxIPGIDTPjFAitFcUoSJiN4a
         l0Mw==
X-Gm-Message-State: AOJu0YyyPLLUmrQKpJgYd80Q23pzFmahNEPWhU+pa4IcWOjWHhj5lbo1
	P7y/bTt5SjxCOiSlz7j8YTmY6WiZBKLLWzS07YgrOXUbHvO5DvpYko0P44XTTikMPX06QXLZIZZ
	LoU3hkCJakTOjXMkTxWgma81d2qHF3wqtLYMovdcSWpy27/HlB/r0QUrDJ7Vt7NzOVH2+pdbMvy
	qdioVA01pdZgSmQirxSv0SJp+L0lG9d5eKAKgGy7WX8t8qU6PAAdSBEhaCLSc=
X-Received: from plbl2.prod.google.com ([2002:a17:902:eb02:b0:2ae:c871:d739])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:27c5:b0:2ae:8253:1452 with SMTP id d9443c01a7336-2b2d593e9a0mr94369735ad.11.1776113197204;
 Mon, 13 Apr 2026 13:46:37 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:46:24 -0700
In-Reply-To: <20260413204630.1149038-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413204630.1149038-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260413204630.1149038-2-jingzhangos@google.com>
Subject: [kvm-unit-tests PATCH v2 1/7] lib: arm64: Generalize ESR exception
 class definitions for EL2 support
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Andrew Jones <andrew.jones@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Colton Lewis <coltonlewis@google.com>, 
	Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

Generalize some Exception Syndrome Register (ESR) definitions by
renaming EL1-specific macros to ELx equivalents. This allows these
constants to be shared between EL1 and EL2, supporting the upcoming
S2MMU library implementation.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 lib/arm64/asm/esr.h   |  5 +++--
 lib/arm64/processor.c | 10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/arm64/asm/esr.h b/lib/arm64/asm/esr.h
index 335343c5..8437916f 100644
--- a/lib/arm64/asm/esr.h
+++ b/lib/arm64/asm/esr.h
@@ -12,7 +12,7 @@
 #define ESR_EL1_CM		(1 << 8)
 #define ESR_EL1_IL		(1 << 25)
 
-#define ESR_EL1_EC_SHIFT	(26)
+#define ESR_ELx_EC_SHIFT	(26)
 #define ESR_EL1_EC_UNKNOWN	(0x00)
 #define ESR_EL1_EC_WFI		(0x01)
 #define ESR_EL1_EC_CP15_32	(0x03)
@@ -25,12 +25,13 @@
 #define ESR_EL1_EC_ILL_ISS	(0x0E)
 #define ESR_EL1_EC_SVC32	(0x11)
 #define ESR_EL1_EC_SVC64	(0x15)
+#define ESR_ELx_EC_HVC64	(0x16)
 #define ESR_EL1_EC_SYS64	(0x18)
 #define ESR_EL1_EC_SVE		(0x19)
 #define ESR_EL1_EC_IABT_EL0	(0x20)
 #define ESR_EL1_EC_IABT_EL1	(0x21)
 #define ESR_EL1_EC_PC_ALIGN	(0x22)
-#define ESR_EL1_EC_DABT_EL0	(0x24)
+#define ESR_ELx_EC_DABT_LOW	(0x24)
 #define ESR_EL1_EC_DABT_EL1	(0x25)
 #define ESR_EL1_EC_SP_ALIGN	(0x26)
 #define ESR_EL1_EC_FP_EXC32	(0x28)
diff --git a/lib/arm64/processor.c b/lib/arm64/processor.c
index f9fea519..bde3caa5 100644
--- a/lib/arm64/processor.c
+++ b/lib/arm64/processor.c
@@ -48,7 +48,7 @@ static const char *ec_names[EC_MAX] = {
 	[ESR_EL1_EC_IABT_EL0]		= "IABT_EL0",
 	[ESR_EL1_EC_IABT_EL1]		= "IABT_EL1",
 	[ESR_EL1_EC_PC_ALIGN]		= "PC_ALIGN",
-	[ESR_EL1_EC_DABT_EL0]		= "DABT_EL0",
+	[ESR_ELx_EC_DABT_LOW]		= "DABT_EL0",
 	[ESR_EL1_EC_DABT_EL1]		= "DABT_EL1",
 	[ESR_EL1_EC_SP_ALIGN]		= "SP_ALIGN",
 	[ESR_EL1_EC_FP_EXC32]		= "FP_EXC32",
@@ -82,7 +82,7 @@ void show_regs(struct pt_regs *regs)
 
 bool get_far(unsigned int esr, unsigned long *far)
 {
-	unsigned int ec = esr >> ESR_EL1_EC_SHIFT;
+	unsigned int ec = esr >> ESR_ELx_EC_SHIFT;
 
 	asm volatile("mrs %0, far_el1": "=r" (*far));
 
@@ -90,7 +90,7 @@ bool get_far(unsigned int esr, unsigned long *far)
 	case ESR_EL1_EC_IABT_EL0:
 	case ESR_EL1_EC_IABT_EL1:
 	case ESR_EL1_EC_PC_ALIGN:
-	case ESR_EL1_EC_DABT_EL0:
+	case ESR_ELx_EC_DABT_LOW:
 	case ESR_EL1_EC_DABT_EL1:
 	case ESR_EL1_EC_WATCHPT_EL0:
 	case ESR_EL1_EC_WATCHPT_EL1:
@@ -108,7 +108,7 @@ static void bad_exception(enum vector v, struct pt_regs *regs,
 {
 	unsigned long far;
 	bool far_valid = get_far(esr, &far);
-	unsigned int ec = esr >> ESR_EL1_EC_SHIFT;
+	unsigned int ec = esr >> ESR_ELx_EC_SHIFT;
 	uintptr_t text = (uintptr_t)&_text;
 
 	printf("Load address: %" PRIxPTR "\n", text);
@@ -158,7 +158,7 @@ void default_vector_sync_handler(enum vector v, struct pt_regs *regs,
 				 unsigned int esr)
 {
 	struct thread_info *ti = thread_info_sp(regs->sp);
-	unsigned int ec = esr >> ESR_EL1_EC_SHIFT;
+	unsigned int ec = esr >> ESR_ELx_EC_SHIFT;
 
 	if (ti->flags & TIF_USER_MODE) {
 		if (ec < EC_MAX && ti->exception_handlers[v][ec]) {
-- 
2.53.0.1213.gd9a14994de-goog

