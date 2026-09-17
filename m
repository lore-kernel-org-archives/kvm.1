Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB44A4842
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676912; cv=none; b=e91txIpeT78S1TNvztTSqkk4aCCkVKPxRiCoOLIU+6vRjJT+6Bw6TkmFa282jWSWNjKBlL9vS7XcwykFaYy2LsQRO6qPiBeN0xY3oZtaAlfnL8lMjPN+ZPfMSNQzkLye0k8bFhrbZ/+Q/gQBH64vIv/IhpuXl+XJMdSdvm4bCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676912; c=relaxed/simple;
	bh=uUjZWdIpWlAwaQPdNzoaWhOmXie5LnP8Gn87IaLOOnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O3/XXHov9BdHMeJNh91+egv3qr6T60sOL8no1vQsrnwDwW5/5g8ZeqD7LQsU8Zc+I7Mu7ovtz+7ZLdCGCgTs7DmeFshAjq8uBX63Az40S7O6BaP3iDBTpTB2Ym6awWtGFWRJNMXM9BPK3TapQRmECeJkRj/Jq7WvRRX+8x+Ptwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0kgWExT; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0kgWExT"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dd53f2b27cso759295ad.0
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789676910; x=1790281710; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJv/QmRLFs30Ez/o33oaP/4NGGWedRYL/v2RmSEliLQ=;
        b=X0kgWExTMAL5VwkkdIiTiedTZO7gy4pfj9SuYrCPe9tF26rvViS9jtPzBHAEve3TZK
         pR0EMO93hhGbczTI4KbweXmLR3VFr93SBevjVTIixEvZzeY/d3IFYyM769BcF5Ek8s+c
         L69oHw4m71u22ESza3zbOIcVTTzMSdNfofx0b/Q8c3+MSLWx+pfVKWeLNhzD94MOa95w
         Zj1gJ1Pk/6qCQWPlApz3C15Iq3/n7Ifu32DEwzXtv2HLRsbcWCqwZd/lZdk9qURwEiM+
         ZXo4W/c7rPQjSurj63jH7VfSi8pfrMn6O7hAAPTu5XjodfvfzsOXL4ycx9sKdOPxqGCY
         nHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789676910; x=1790281710;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJv/QmRLFs30Ez/o33oaP/4NGGWedRYL/v2RmSEliLQ=;
        b=V509oYAhW58na0H6TdtAmbho+s+5qRlyUbYzRfb2/hTBP9S09py3CqTifoK/+GsKz9
         GHerpbBq755Hdq+fhspUG6DaloFp56Zd95bfmjBgHDz9ApIjpdmBDqRThUighW5y0JHI
         +ilrk4lNJiYst8aHr36FnbBONZ7n27aiDjjmwFsvEwCelKsyCR0EeJQjmz0a/if4wFNd
         TEwu82xiwZhb7Uj+2evqM/T46yp3aKsxOYDV+vSYN+o+30pv2AGtgm1YAYn7pPWRbPXU
         zyeH7HIOnEfe6TJx3VXlDnrONIBTvwNxpHjuq4HIQ0PxQ6v6zJbHXfZblYp71PJepMy2
         T9qw==
X-Forwarded-Encrypted: i=1; AKwUvByRk6wzCuXO+4XUu8VSZ9UdMHGrhitQJF9qUYKHngKalMvQ946qEDViw9ZnHPoTCvdHdWI=@vger.kernel.org
X-Gm-Message-State: AFuF++mPN2s4JhSD8HChv8JuZWMqzuIlhx+qvKZZD3+nj8QVuBII+VMb
	NAyzb4zde0l4RtjroJxdKYUclx3vZ247by+Lv2rqnn8Thvf3KYLR08VHLTlGrqMAQ17pY5eVF0U
	UgsHmEA==
X-Received: from plcm18.prod.google.com ([2002:a17:902:f212:b0:2dd:31d9:e5c6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3e0c:b0:2da:e634:370e
 with SMTP id d9443c01a7336-2ddb1b79029mr4700125ad.14.1789676909742; Thu, 17
 Sep 2026 13:28:29 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:28:29 -0700
In-Reply-To: <20260917181028.288194-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917181028.288194-1-gokul02k@gmail.com>
Message-ID: <aqxNbR9u5F1sqB3p@google.com>
Subject: Re: [PATCH] KVM: selftests: Drop the unsigned >= 0 assertions in test_write/test_read
From: Sean Christopherson <seanjc@google.com>
To: Gokul K <gokul02k@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 17, 2026, Gokul K wrote:
> test_write() and test_read() both open with
> 
> 	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);
> 
> but @count is a size_t, so the condition is always true and the assertion
> can never fire. Building the selftests with -Wextra says so:
> 
>   lib/io.c:51:27: warning: comparison of unsigned expression in '>= 0'
>                   is always true [-Wtype-limits]
>   lib/io.c:128:27: warning: comparison of unsigned expression in '>= 0'
>                   is always true [-Wtype-limits]
> 
> @count has been a size_t since these helpers were added in commit
> 6089ae0bd5e1 ("kvm: selftests: add sync_regs_test"), so this has never
> guarded anything; nothing regressed and there is no behavioural change.
> 
> Note also that the message the assertion would have printed is wrong: %li
> takes a long, not a size_t. That has gone unnoticed precisely because the
> assertion is unreachable, which is a fair summary of the value it adds.
> 
> Delete both. The comment above each one is about a count of zero being
> legitimate, which remains true and is worth keeping.

I disagree.  This code is all rather non-sensical.  Keeping the comment with code
that doesn't handle it correct can't work.  Because per the manpage:

  a read() with a count of 0 returns zero and has no other effects.

which means passing in a size of 0 will hit the "case 0" and fail:

		rc = read(fd, ptr, num_left);

		switch (rc) {
		case -1:
			TEST_ASSERT(errno == EAGAIN || errno == EINTR,
				    "Unexpected read failure,\n"
				    "  rc: %zi errno: %i", rc, errno);
			break;

		case 0:
			TEST_FAIL("Unexpected EOF,\n"  <==========================
				  "   rc: %zi num_read: %zi num_left: %zu",
				  rc, num_read, num_left);
			break;

		default:
			TEST_ASSERT(rc > 0, "Unexpected ret from read,\n"
				    "  rc: %zi errno: %i", rc, errno);
			num_read += rc;
			num_left -= rc;
			ptr += rc;
			break;

The only user of test_read() is tools/testing/selftests/kvm/lib/elf.c, and all
users guarantee a non-zero count.  test_write() is dead code, and test_seq_read()
has a defunct declaration.

The names are also confusing, because it's easy to read it as "test the read()
sycall", not "do read() for this test".

So, I think we should move test_read() into elf.c, drop the absurdly verbose and
unhelpful commentry, then kill off io.c, test_write() and the stale test_seq_read().

diff --git tools/testing/selftests/kvm/Makefile.kvm tools/testing/selftests/kvm/Makefile.kvm
index 6a1482e3a286..610b4d959673 100644
--- tools/testing/selftests/kvm/Makefile.kvm
+++ tools/testing/selftests/kvm/Makefile.kvm
@@ -6,7 +6,6 @@ all:
 LIBKVM += lib/assert.c
 LIBKVM += lib/elf.c
 LIBKVM += lib/guest_modes.c
-LIBKVM += lib/io.c
 LIBKVM += lib/kvm_util.c
 LIBKVM += lib/lru_gen_util.c
 LIBKVM += lib/memstress.c
diff --git tools/testing/selftests/kvm/include/test_util.h tools/testing/selftests/kvm/include/test_util.h
index a6a3e1657895..e558346c3b69 100644
--- tools/testing/selftests/kvm/include/test_util.h
+++ tools/testing/selftests/kvm/include/test_util.h
@@ -49,10 +49,6 @@ do {								\
 
 #define TEST_REQUIRE(f) __TEST_REQUIRE(f, "Requirement not met: %s", #f)
 
-ssize_t test_write(int fd, const void *buf, size_t count);
-ssize_t test_read(int fd, void *buf, size_t count);
-int test_seq_read(const char *path, char **bufp, size_t *sizep);
-
 void __printf(5, 6) test_assert(bool exp, const char *exp_str,
 				const char *file, unsigned int line,
 				const char *fmt, ...);
diff --git tools/testing/selftests/kvm/lib/elf.c tools/testing/selftests/kvm/lib/elf.c
index 1924a9895834..d996e289f4af 100644
--- tools/testing/selftests/kvm/lib/elf.c
+++ tools/testing/selftests/kvm/lib/elf.c
@@ -12,6 +12,44 @@
 
 #include "kvm_util.h"
 
+static ssize_t elf_read(int fd, void *buf, size_t count)
+{
+	ssize_t rc;
+	ssize_t num_read = 0;
+	size_t num_left = count;
+	char *ptr = buf;
+
+	TEST_ASSERT(count, "Count must be non-zero");
+
+	do {
+		rc = read(fd, ptr, num_left);
+
+		switch (rc) {
+		case -1:
+			TEST_ASSERT(errno == EAGAIN || errno == EINTR,
+				    "Unexpected read failure,\n"
+				    "  rc: %zi errno: %i", rc, errno);
+			break;
+
+		case 0:
+			TEST_FAIL("Unexpected EOF,\n"
+				  "   rc: %zi num_read: %zi num_left: %zu",
+				  rc, num_read, num_left);
+			break;
+
+		default:
+			TEST_ASSERT(rc > 0, "Unexpected ret from read,\n"
+				    "  rc: %zi errno: %i", rc, errno);
+			num_read += rc;
+			num_left -= rc;
+			ptr += rc;
+			break;
+		}
+	} while (num_read < count);
+
+	return num_read;
+}
+
 static void elfhdr_get(const char *filename, Elf64_Ehdr *hdrp)
 {
 	off_t offset_rv;
@@ -31,7 +69,7 @@ static void elfhdr_get(const char *filename, Elf64_Ehdr *hdrp)
 	 * the real size of the ELF header.
 	 */
 	unsigned char ident[EI_NIDENT];
-	test_read(fd, ident, sizeof(ident));
+	elf_read(fd, ident, sizeof(ident));
 	TEST_ASSERT((ident[EI_MAG0] == ELFMAG0) && (ident[EI_MAG1] == ELFMAG1)
 		&& (ident[EI_MAG2] == ELFMAG2) && (ident[EI_MAG3] == ELFMAG3),
 		"ELF MAGIC Mismatch,\n"
@@ -79,7 +117,7 @@ static void elfhdr_get(const char *filename, Elf64_Ehdr *hdrp)
 	offset_rv = lseek(fd, 0, SEEK_SET);
 	TEST_ASSERT(offset_rv == 0, "Seek to ELF header failed,\n"
 		"  rv: %zi expected: %i", offset_rv, 0);
-	test_read(fd, hdrp, sizeof(*hdrp));
+	elf_read(fd, hdrp, sizeof(*hdrp));
 	TEST_ASSERT(hdrp->e_phentsize == sizeof(Elf64_Phdr),
 		"Unexpected physical header size,\n"
 		"  hdrp->e_phentsize: %x\n"
@@ -146,7 +184,7 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 
 		/* Read in the program header. */
 		Elf64_Phdr phdr;
-		test_read(fd, &phdr, sizeof(phdr));
+		elf_read(fd, &phdr, sizeof(phdr));
 
 		/* Skip if this header doesn't describe a loadable segment. */
 		if (phdr.p_type != PT_LOAD)
@@ -186,7 +224,7 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 				"  expected: 0x%jx",
 				n1, errno, (intmax_t) offset_rv,
 				(intmax_t) phdr.p_offset);
-			test_read(fd, addr_gva2hva(vm, phdr.p_vaddr),
+			elf_read(fd, addr_gva2hva(vm, phdr.p_vaddr),
 				phdr.p_filesz);
 		}
 	}
diff --git tools/testing/selftests/kvm/lib/io.c tools/testing/selftests/kvm/lib/io.c
deleted file mode 100644
index fedb2a741f0b..000000000000
--- tools/testing/selftests/kvm/lib/io.c
+++ /dev/null
@@ -1,157 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * tools/testing/selftests/kvm/lib/io.c
- *
- * Copyright (C) 2018, Google LLC.
- */
-
-#include "test_util.h"
-
-/* Test Write
- *
- * A wrapper for write(2), that automatically handles the following
- * special conditions:
- *
- *   + Interrupted system call (EINTR)
- *   + Write of less than requested amount
- *   + Non-block return (EAGAIN)
- *
- * For each of the above, an additional write is performed to automatically
- * continue writing the requested data.
- * There are also many cases where write(2) can return an unexpected
- * error (e.g. EIO).  Such errors cause a TEST_ASSERT failure.
- *
- * Note, for function signature compatibility with write(2), this function
- * returns the number of bytes written, but that value will always be equal
- * to the number of requested bytes.  All other conditions in this and
- * future enhancements to this function either automatically issue another
- * write(2) or cause a TEST_ASSERT failure.
- *
- * Args:
- *  fd    - Opened file descriptor to file to be written.
- *  count - Number of bytes to write.
- *
- * Output:
- *  buf   - Starting address of data to be written.
- *
- * Return:
- *  On success, number of bytes written.
- *  On failure, a TEST_ASSERT failure is caused.
- */
-ssize_t test_write(int fd, const void *buf, size_t count)
-{
-	ssize_t rc;
-	ssize_t num_written = 0;
-	size_t num_left = count;
-	const char *ptr = buf;
-
-	/* Note: Count of zero is allowed (see "RETURN VALUE" portion of
-	 * write(2) manpage for details.
-	 */
-	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);
-
-	do {
-		rc = write(fd, ptr, num_left);
-
-		switch (rc) {
-		case -1:
-			TEST_ASSERT(errno == EAGAIN || errno == EINTR,
-				    "Unexpected write failure,\n"
-				    "  rc: %zi errno: %i", rc, errno);
-			continue;
-
-		case 0:
-			TEST_FAIL("Unexpected EOF,\n"
-				  "  rc: %zi num_written: %zi num_left: %zu",
-				  rc, num_written, num_left);
-			break;
-
-		default:
-			TEST_ASSERT(rc >= 0, "Unexpected ret from write,\n"
-				"  rc: %zi errno: %i", rc, errno);
-			num_written += rc;
-			num_left -= rc;
-			ptr += rc;
-			break;
-		}
-	} while (num_written < count);
-
-	return num_written;
-}
-
-/* Test Read
- *
- * A wrapper for read(2), that automatically handles the following
- * special conditions:
- *
- *   + Interrupted system call (EINTR)
- *   + Read of less than requested amount
- *   + Non-block return (EAGAIN)
- *
- * For each of the above, an additional read is performed to automatically
- * continue reading the requested data.
- * There are also many cases where read(2) can return an unexpected
- * error (e.g. EIO).  Such errors cause a TEST_ASSERT failure.  Note,
- * it is expected that the file opened by fd at the current file position
- * contains at least the number of requested bytes to be read.  A TEST_ASSERT
- * failure is produced if an End-Of-File condition occurs, before all the
- * data is read.  It is the callers responsibility to assure that sufficient
- * data exists.
- *
- * Note, for function signature compatibility with read(2), this function
- * returns the number of bytes read, but that value will always be equal
- * to the number of requested bytes.  All other conditions in this and
- * future enhancements to this function either automatically issue another
- * read(2) or cause a TEST_ASSERT failure.
- *
- * Args:
- *  fd    - Opened file descriptor to file to be read.
- *  count - Number of bytes to read.
- *
- * Output:
- *  buf   - Starting address of where to write the bytes read.
- *
- * Return:
- *  On success, number of bytes read.
- *  On failure, a TEST_ASSERT failure is caused.
- */
-ssize_t test_read(int fd, void *buf, size_t count)
-{
-	ssize_t rc;
-	ssize_t num_read = 0;
-	size_t num_left = count;
-	char *ptr = buf;
-
-	/* Note: Count of zero is allowed (see "If count is zero" portion of
-	 * read(2) manpage for details.
-	 */
-	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);
-
-	do {
-		rc = read(fd, ptr, num_left);
-
-		switch (rc) {
-		case -1:
-			TEST_ASSERT(errno == EAGAIN || errno == EINTR,
-				    "Unexpected read failure,\n"
-				    "  rc: %zi errno: %i", rc, errno);
-			break;
-
-		case 0:
-			TEST_FAIL("Unexpected EOF,\n"
-				  "   rc: %zi num_read: %zi num_left: %zu",
-				  rc, num_read, num_left);
-			break;
-
-		default:
-			TEST_ASSERT(rc > 0, "Unexpected ret from read,\n"
-				    "  rc: %zi errno: %i", rc, errno);
-			num_read += rc;
-			num_left -= rc;
-			ptr += rc;
-			break;
-		}
-	} while (num_read < count);
-
-	return num_read;
-}

