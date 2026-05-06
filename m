Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF454657D6
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072810; cv=none; b=e3CdPsxG8YZdawteLyDRRIYO8DCAaXbhP+k4zT+rlSnJW+pn+KSPMd1p1mzBkPMqjK4tjQMdELkCXT847Jj1EZr0Xg/cc4vHCwL0ZAUCiuI4opEpM5ZphH9lBbOJYDzQpL/UbgBYin5FAnnI2obL9ajjSRRUg4T5O+6RgrxboLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072810; c=relaxed/simple;
	bh=R+iZhBMKQbOmZvWFbNk5Ebai+yiolzVmBEsTjhSfplY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BfVrmU9t03tQ9g6fJn4jPlfQCl19cwpFrbVgpsl1nqoPVXQAvk8AooDz5zKktLA/JmwBa7EKCrv5e3RmXCVO8QyeSZKWqVeYsrKzSDLvJJ3KllXSEA+ufwBjbp257FCUwNq8qOmA6xVNelpDcI1hMZ4VPQVl2nIUKw7KGmj+vwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbyZ74cC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbyZ74cC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778072806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3YNKhamFc8IBVqEo3jv4tnAaqLOXr+LzJhu4mXJKCOU=;
	b=bbyZ74cCD7S/UCgpl0c47C148WptX7SShE5W2khpj+5h6n4J1HP2Efw+QEZup7iXuKehY8
	btJBYdKKO3Dd9AZUwRuYE7YqM4rZBKV393E/JiuCIpiOA0i/Yop4XIz9basDf1VDl00x0j
	1kB938APTN+7Eb/hs83dc+lyRfSJ7Ao=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-oWi9J2xnPteZJ_bIqa9g2g-1; Wed,
 06 May 2026 09:06:45 -0400
X-MC-Unique: oWi9J2xnPteZJ_bIqa9g2g-1
X-Mimecast-MFC-AGG-ID: oWi9J2xnPteZJ_bIqa9g2g_1778072804
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B72BA180075C
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 13:06:44 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com [10.33.192.176])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E75371800671;
	Wed,  6 May 2026 13:06:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Subject: [kvm-unit-tests PATCH v2] realmode: load above stack
Date: Wed,  6 May 2026 15:06:42 +0200
Message-ID: <20260506130642.2571332-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Paolo Bonzini <pbonzini@redhat.com>

The bottom 32K of memory are generally reserved for use by the BIOS;
for example, traditionally the boot loader is placed at 0x7C00 and
the stack grows below that address.

It turns out that with some versions of clang, realmode.flat has
become big enough that it overlaps the stack used by the multiboot
option ROM loader.  The result is that a couple instructions are
overwritten.  Typically one or two tests fail and that's it...

Move the code above the forbidden region, in real 90s style.

Additionally, we've got to compile the test with -Os now, otherwise
the code might get too big when compiling with older versions of clang
(e.g. Clang v20), so linking fails with:

 x86/realmode.o: In function `realmode_start':
 realmode.c:(.text+0x79): relocation truncated to fit: R_386_16 against `.bss'
 realmode.c:(.text+0x82): relocation truncated to fit: R_386_16 against `.bss'
 realmode.c:(.text+0x8b): relocation truncated to fit: R_386_16 against `.bss'
 realmode.c:(.text+0x94): relocation truncated to fit: R_386_16 against `.bss'

Unfortunately, the -Os triggers compiler warnings in this code
with GCC v16:

 In function ‘test_int’,
     inlined from ‘realmode_start’ at x86/realmode.c:1781:2:
 x86/realmode.c:828:28: error: array subscript 0 is outside array bounds
  of ‘u32[0]’ {aka ‘unsigned int[]’} [-Werror=array-bounds=]
   828 |         *(u32 *)(0x11 * 4) = 0x1000; /* Store a pointer to address 0x1000 in IDT entry 0x11 */
       |         ~~~~~~~~~~~~~~~~~~~^~~~~~~~
 In function ‘realmode_start’:
 cc1: note: source object is likely at address zero
 In function ‘test_sti_inhibit’,
     inlined from ‘realmode_start’ at x86/realmode.c:1782:2:
 x86/realmode.c:841:28: error: array subscript 0 is outside array bounds
  of ‘u32[0]’ {aka ‘unsigned int[]’} [-Werror=array-bounds=]
   841 |         *(u32 *)(0x73 * 4) = 0x1000; /* Store IRQ 11 handler in the IDT */
       |         ~~~~~~~~~~~~~~~~~~~^~~~~~~~
 In function ‘realmode_start’:
 cc1: note: source object is likely at address zero
 cc1: all warnings being treated as errors

... so additionally we also have to compile this test with this warning
disabled now.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240604143507.1041901-1-pbonzini@redhat.com>
[thuth: Add -Os and -Wno-array-bounds to CFLAGS to avoid other problems]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 x86/Makefile.common | 1 +
 x86/realmode.lds    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/x86/Makefile.common b/x86/Makefile.common
index ef0e09a6..a251dd71 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -112,6 +112,7 @@ $(TEST_DIR)/realmode.elf: $(TEST_DIR)/realmode.o $(SRCDIR)/$(TEST_DIR)/realmode.
 	      -T $(SRCDIR)/$(TEST_DIR)/realmode.lds $(filter %.o, $^)
 
 $(TEST_DIR)/realmode.o: bits = $(realmode_bits)
+$(TEST_DIR)/realmode.o: CFLAGS += -Os -Wno-array-bounds
 
 $(TEST_DIR)/access_test.$(bin): $(TEST_DIR)/access.o
 
diff --git a/x86/realmode.lds b/x86/realmode.lds
index 0ed3063b..e4782a98 100644
--- a/x86/realmode.lds
+++ b/x86/realmode.lds
@@ -1,6 +1,6 @@
 SECTIONS
 {
-    . = 16K;
+    . = 32K;
     stext = .;
     .text : { *(.init) *(.text) }
     . = ALIGN(4K);
-- 
2.54.0

