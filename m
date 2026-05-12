Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E63B9D8D
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620134; cv=none; b=AUgHQekAFoJ4nhHUizuQ5KlhMY1Qb2uqGEOk3AkTODou2teAWpSKIOi2wgtLjSnpkaF0xO0wG9LND6gB2E++D1lZQm4O14QFowIAlsKL8irHs43lKOano9Qo8GzIu8D8hIDCxTeoihvGl99xvqgzJY6E7wdbZz4drZmHW9KIXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620134; c=relaxed/simple;
	bh=lVQULdD/A4RjT0zUZMk3M8iSFtlqF65QiAkLantxi7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7DADtoqHQDaFCDzcbb9wOs/aKkhRwAOZqyMcfi0MaNW//OPhveKPQ7EH7FvXU73I/GojJXYx8UwhneC0oHwY2WUPTem+4aymzs+udbfX2XwGYiyN2E+fkPI2j3sarVFvwg+QJuZcl1elRwJCekGGfh+a6FlSQiX3bhoBlkM1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QO/TzThk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9N3OjJ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QO/TzThk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9N3OjJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g/8gnhE1UQWtU4rtDGjUph1rzOQHdUIwoTJ2mkb4wrw=;
	b=QO/TzThkBmSEXgZFCgNgXuxjvjqRNmM7eCIioIHaW9g7XyOT/wg/wNdowr34R1xoYzCCOr
	jbLp5VtcTFXQ560WznQ+FFOPN+Nn1kSdAWEB+GLvNPhyf37Z4ZVr04UCjrpeFiblEVbyaG
	UI2USTHbs/JCW3C8KL9gJlMwCrtIUIY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-PIRi6-TqMm6xfMi31Ln2GA-1; Tue, 12 May 2026 17:08:51 -0400
X-MC-Unique: PIRi6-TqMm6xfMi31Ln2GA-1
X-Mimecast-MFC-AGG-ID: PIRi6-TqMm6xfMi31Ln2GA_1778620130
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4411a1f9601so4550373f8f.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 14:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778620130; x=1779224930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/8gnhE1UQWtU4rtDGjUph1rzOQHdUIwoTJ2mkb4wrw=;
        b=f9N3OjJ4enGAae7MXij+G6Z03o/7EphAoEtbxFgZ5PcKApSvGEGXCgXAP1egCGe7IF
         hB/Ga9tA8WG14hQrxxLyBAze0Awt3oiqK6+6zLn+ZCU33On1v7pCs9VCiby8hvbP+u1Y
         5pD0xTBRdkk4un9j7dYABvlm+3cw7EXbqq+DUEnxsBmlA4mRQq2NeykN9sbFuGa7wMcn
         k3aBwXn81kChoWdOwiFsmhNKbiR2wVtz3VbkEmM9TUWng3jtn6/vFgJ305fcwXuYRbVM
         55pjoDCbNqHGwIFvAlF+Aj0Skwn58SQuwCQbVsexc4ehY5xA5gMao2IJ1YgIQKoSlYbW
         pNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620130; x=1779224930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/8gnhE1UQWtU4rtDGjUph1rzOQHdUIwoTJ2mkb4wrw=;
        b=Cx2WUeVXJDoEzBEUWUVqI76FfBQ0IFgQzVOH32ZmeAyUfeo8AP4OOd8R8W3Q+UZNK3
         pV/ChjMpUcG/fvbSrdEEgCkDWqQaJuqs6EYxBEk2s/AOy9MLKV8Gw10QNe4jyVWw2h7W
         fi3E+Va4vIKsI9ugV9/rjhb5DJw4uDVxS1j7vdx6mt+8QtxanNNSSzHQeZe5iP8NOTvF
         Qh1b8//Uw2fR25IFSh1xlpgnME5RE6ddq+qGS/J4DTw/kEqvLEJXtj1FzOesbHSdi7TQ
         Ik7No+eFuyFQuuMlxFczT0iFBU7DfI2zauoGSiAUhyQa8Aj/y4nW3+m0yBOaXK+PZq/B
         Th2Q==
X-Gm-Message-State: AOJu0YzLOUeNrbaHBC+RZ/h/U3xFYVtBM38I4VXwbi/4tOj+4F/yuncv
	wGkCkY+EtGTUZQo/gZBzuNdl+vwaDagZ+MAS0FeA8uDXM5rinm8Yovb0opSgpuZhyN/4fAJPujM
	TodHWrpxSHGe/7ey6pnSFr3jGi8TPJ73mJjM7Y9i3yTbjnw//DrIz34wQWNOrmfqOi2YbIBJof9
	kESVPw3yVyXYkF92K59wC+4y9F1n77/8wZmciOZA==
X-Gm-Gg: Acq92OECp0nSVwSqsxYLV7xbTguVCpNgvXv4DxTPkMZDEdL1EnPffs8YHPNbh0iV/7X
	lp6jbGck5bKWSaqwgSUWf9HV7yvkyehFyGRS3UPnt8pyHfVHAJTk3GUAPRJRS0ciR9KCxtPYdow
	SztmxDTo3etEBSbZHOqtsj1N7an6cwhUxUgrxg7Ab/SK/81FKl9Ndle3Hida22qTiHrZgdOQh5r
	hi9S7+Axw6LuCJ/evZ8ajlEObqxExFVzoPuw5KDOPjMEtqL59y8B75OPX3JfNukqAQl+ksscWes
	H7Sui09X6r6qFdf/ZzF1WrCCDRHhIkXgWlqPXkg0YPCAGx/bpj3Vpg5ZThUQ2K1PpznNWwIOTh1
	VTNhQqCtEqMfgxdX6FlV/KDXbiyrF1eoWPp51zgxPK9adimHjHlLwnFXFCCv0xGqjUDVe7UOZQg
	rFnmcZUjstALIgnnSajT8GGupjMWL3
X-Received: by 2002:a05:600c:8b5c:b0:48a:7f90:2231 with SMTP id 5b1f17b1804b1-48fc9a3c5e9mr6096405e9.19.1778620129745;
        Tue, 12 May 2026 14:08:49 -0700 (PDT)
X-Received: by 2002:a05:600c:8b5c:b0:48a:7f90:2231 with SMTP id 5b1f17b1804b1-48fc9a3c5e9mr6096105e9.19.1778620129264;
        Tue, 12 May 2026 14:08:49 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e5efe71sm29289205e9.1.2026.05.12.14.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:08:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: dwmw@amazon.co.uk
Subject: [PATCH kvm-unit-tests] taskswitch: add test for ICEBP delivery via taskgate
Date: Tue, 12 May 2026 23:08:47 +0200
Message-ID: <20260512210847.3039048-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ICEBP (INT1, opcode 0xF1) generates #DB as a trap, and this
triggers a corner case in SVM.

When you get TASK_SWITCH (which always has fault semantics), you look at
the vectoring event type to decide whether it was logically caused by a
trap, and therefore whether to move %rip forwards before entering the
new task.

AMD CPUs don't distinguish instruction-induced #DBs (i.e. ICEBP) from
exception-induced #DBs (all others), and also don't report an
instruction length for an ICEBP-induced TASK_SWITCH.  For this
reason hypervisors have to intercept ICEBP unconditionally, handle the
FAULT->TRAP conversion in the hypervisor, at which point the #DB-induced
TASK_SWITCH occurs with %rip on the correct instruction boundary whether
it was instruction-induced or exception-induced.

[description by Andrew Cooper]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/taskswitch.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/x86/taskswitch.c b/x86/taskswitch.c
index 0d311498..7f5df7fe 100644
--- a/x86/taskswitch.c
+++ b/x86/taskswitch.c
@@ -7,11 +7,13 @@
 
 #include "libcflat.h"
 #include "x86/desc.h"
+#include "x86/processor.h"
 #include "vmalloc.h"
 
 #define TSS_RETURN		(FIRST_SPARE_SEL)
 
 void fault_entry(void);
+void icebp_entry(void);
 
 static __attribute__((used, regparm(1))) void
 fault_handler(unsigned long error_code)
@@ -33,19 +35,59 @@ asm (
 	"	jmp $" xstr(TSS_RETURN) ", $0\n"
 );
 
+/*
+ * Handler invoked via a #DB task gate.  When the CPU switches to this task
+ * via the IDT task gate, the outgoing task's CS:EIP is saved to the main
+ * TSS, so reading tss[0].eip yields the saved EIP at the point of #DB.
+ */
+static volatile u32 icebp_eip;
+
+static __attribute__((used)) void
+icebp_handler(void)
+{
+	print_current_tss_info();
+        icebp_eip = tss[0].eip;
+
+	/* catch invalid AMD behavior */
+	if (*(unsigned char *)icebp_eip == 0xf1)
+		tss[0].eip++;
+}
+
+asm (
+	"icebp_entry:\n"
+	"	call icebp_handler\n"
+	"	iret\n"
+);
+
 int main(int ac, char **av)
 {
 	const long invalid_segment = 0x1234;
 
 	setup_tss32();
-	set_intr_task_gate(13, fault_entry);
+	set_intr_task_gate(GP_VECTOR, fault_entry);
 
 	asm (
 		"mov %0,%%es\n"
 		: : "r" (invalid_segment) : "edi"
 	);
 
-	printf("post fault\n");
+	report(1, "jump to task gate");
+
+	/*
+	 * ICEBP causes a trap-like #DB, so the saved EIP must point past the
+	 * 0xF1 byte regardless of how #DB is delivered.  On SVM, when #DB is
+	 * delivered via a task gate the hardware-saved EIP points at the
+	 * ICEBP instruction; the hypervisor has to fix this up by advancing
+	 * RIP before the task switch.
+	 */
+	extern unsigned char after_icebp;
+
+	set_intr_task_gate(DB_VECTOR, icebp_entry);
+	icebp_eip = 0;
+	asm volatile(".byte 0xf1; after_icebp:");
+	report(icebp_eip == (u32)&after_icebp,
+	       "ICEBP via #DB task gate: saved EIP %#x, expected %#x",
+	       icebp_eip, (u32)&after_icebp);
 
 	return 0;
 }
-- 
2.54.0

