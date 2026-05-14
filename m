Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9B3CD8A9
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792718; cv=none; b=a6XPtUftcMXWgAo/Vtb2KKTAObX/WMAZU9cxA+6ouYQxEUL/Tduy3fH9rocA4nN0h756l/S05UWQkRv4+isdAXoWEK6ZLBzynyq9VpDxcl4UJAsVBk4D5KrC6k+t9XF8kGK1Djk9tqaZ2eHh7jo8qze3eKw/qArvyL+UPW0EL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792718; c=relaxed/simple;
	bh=Xktsb+EZGJ0O5wYa6cZIVh/oFRdhW/S6ru+cAqd520A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nbmmd0q+ZM/nmKXOChbhS1OEca4/sb6vic8lNcTpDWOHfJu2eWvJOvnx3yrehBNVXV7SppzCWu05un5srdkxjpfpx0WtC7hBjBw21a4pfhNry+0xPMq4aDRgshhTTgUH+247aseoru3cso0dF9iOqyX92f7r/daQCd3Jd9GFwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RD6B+DdD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RD6B+DdD"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828f0f5c23so2804874a12.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792717; x=1779397517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=k0Quhz7quHfrJptiAjYdwWC6DonsOfYE619OS34mY4E=;
        b=RD6B+DdDgrNJeCpWpP7VYsQYEEeyhRk9ifZ/VlWHTlsBDTJOeV+4ikS/Of3VimYRCN
         8DDL4naYHoGsfsNIqCweI8Hz984bC4XkHx9Yv1W30JtXypHJakPvtLPTdMGElHqd7quk
         TDsKV3jz6kKaBQhsZgRU/mAFGcTjnjYA5b35GMK1e2JM597N3sGGDGCVUPsaM6P2b9Pd
         8I8cCLX4rbClD9ljqf9X7DaG8ilkLG6Fl4EsS2P0qo+9gB+jbZbrq2d2ovvgGH+iHVSL
         mRP/GE1fPnCJ8BABk4VcPg3GBEUFv5a8htuV0zcNkNgW7pRptVOG9oLFFDb2Mm8tSqq6
         IlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792717; x=1779397517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0Quhz7quHfrJptiAjYdwWC6DonsOfYE619OS34mY4E=;
        b=r1o6N+mKEfj5IthotCmOGV8BO7vD4vXAq53TuLEnA3AbPUolIKkyCyOHQ9NF7N/F5g
         ioLEz/WEekNOXHJdq/HeAKh5G/mXH7XCa0i05Z7chHETlD6PJz+dWLdeqo9Ccmi4J+x3
         qk+DirAK6x/cSIVCS8u/hyJwTrThJf8Z8WWxd6MGOlm9K6McK5dbe5wkoTpAfCD3ZOqn
         orxhJLcFGK8p1kr+SZKqnruU9FM+Zd0pVE9PAKC5JWBfmMyLZRFwRyFYXPp46o3rzqVB
         IsOBKAgPdZu66EuxVPcuUK65tXxLwr6Q0mCs49MaYVuR+QnaQBBpZ3piDuZEOavPMaPL
         ZqDQ==
X-Gm-Message-State: AOJu0YzwpszLrhgsStJHXmVlr8lgq6jswAdJ87C/z7moaZcdMbLG7pNv
	a+n2crYWnLn2J51SVC3RIB23ZvDD7lryItuy0hKpFnK7JvQTULnSIr3AERJ2Qc+aevQ4KJ6WN3B
	Lq1gI0g==
X-Received: from pfbg8.prod.google.com ([2002:a05:6a00:ae08:b0:83e:b5cc:11c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3907:b0:82d:556b:7a01
 with SMTP id d2e1a72fcca58-83f33c25b5bmr1206687b3a.16.1778792716654; Thu, 14
 May 2026 14:05:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:52 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-13-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 12/20] x86/vmx: Communicate hypercalls via
 RAX, not a global field
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Communicate hypercall requests via RAX instead of a global field.  To
avoid false positives, use a larger magic value that is extremely unlikely
to be resident in RAX at the time of VMCALL (avoiding false positives is
is presumably why a global variable was used).

Using RAX instead of a shared variable ensures multi-vCPU tests won't
clobber each other's hypercalls (no such tests currently exist).

Use the "abracadabra" magic number first introduced by KVM selftests,
because if a dad joke is funny one time, it's funny every time.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx.c | 32 ++++++++++++++++++++------------
 x86/vmx.h |  6 ------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/x86/vmx.c b/x86/vmx.c
index 12e5d449..af7c4c20 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -59,7 +59,6 @@ static struct test_teardown_step teardown_steps[MAX_TEST_TEARDOWN_STEPS];
 
 static test_guest_func v2_guest_main;
 
-u64 hypercall_field;
 static int matched;
 static int guest_finished;
 
@@ -1635,28 +1634,37 @@ static void test_vmx_caps(void)
 	       "MSR_IA32_VMX_EPT_VPID_CAP");
 }
 
+#define VMX_HYPERCALL_MAGIC 0xabacadabaULL
+
+#define HYPERCALL_MASK		0xFFF
+#define HYPERCALL_VMEXIT	0x1
+#define HYPERCALL_VMABORT	0x2
+#define HYPERCALL_VMSKIP	0x3
+
 /* This function can only be called in guest */
 void __attribute__((__used__)) hypercall(u32 hypercall_no)
 {
-	u64 val = 0;
-	val = (hypercall_no & HYPERCALL_MASK) | HYPERCALL_BIT;
-	hypercall_field = val;
-	asm volatile("vmcall\n\t");
+	u64 val = (VMX_HYPERCALL_MAGIC << 12) | hypercall_no;
+
+	asm volatile("vmcall\n\t" : "+a"(val));
 }
 
 static bool is_hypercall(union exit_reason exit_reason)
 {
+	u64 hypercall_field = this_cpu_guest_regs()->rax;
+
 	return exit_reason.basic == VMX_VMCALL &&
-	       (hypercall_field & HYPERCALL_BIT);
+	       (hypercall_field >> 12) == VMX_HYPERCALL_MAGIC;
 }
 
 static int handle_hypercall(void)
 {
-	ulong hypercall_no;
+	struct guest_regs *regs = this_cpu_guest_regs();
+	u64 hypercall_field = regs->rax;
 
-	hypercall_no = hypercall_field & HYPERCALL_MASK;
-	hypercall_field = 0;
-	switch (hypercall_no) {
+	regs->rax = 0;
+
+	switch (hypercall_field & HYPERCALL_MASK) {
 	case HYPERCALL_VMEXIT:
 		return VMX_TEST_VMEXIT;
 	case HYPERCALL_VMABORT:
@@ -1664,7 +1672,8 @@ static int handle_hypercall(void)
 	case HYPERCALL_VMSKIP:
 		return VMX_TEST_VMSKIP;
 	default:
-		printf("ERROR : Invalid hypercall number : %ld\n", hypercall_no);
+		printf("ERROR : Invalid hypercall number : %ld\n",
+		       hypercall_field & HYPERCALL_MASK);
 	}
 	return VMX_TEST_EXIT;
 }
@@ -2060,7 +2069,6 @@ int main(int argc, const char *argv[])
 	int i = 0;
 
 	setup_vm();
-	hypercall_field = 0;
 
 	/* We want xAPIC mode to test MMIO passthrough from L1 (us) to L2.  */
 	smp_reset_apic();
diff --git a/x86/vmx.h b/x86/vmx.h
index c1c6eba4..098a5ef4 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -588,12 +588,6 @@ enum vm_entry_failure_code {
 #define VMX_TEST_VMABORT	4
 #define VMX_TEST_VMSKIP		5
 
-#define HYPERCALL_BIT		(1ul << 12)
-#define HYPERCALL_MASK		0xFFF
-#define HYPERCALL_VMEXIT	0x1
-#define HYPERCALL_VMABORT	0x2
-#define HYPERCALL_VMSKIP	0x3
-
 #define EPTP_PG_WALK_LEN_SHIFT	3ul
 #define EPTP_PG_WALK_LEN_MASK	0x38ul
 #define EPTP_RESERV_BITS_MASK	0x1ful
-- 
2.54.0.563.g4f69b47b94-goog

