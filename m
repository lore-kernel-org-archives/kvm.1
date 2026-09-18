Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877946E011
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710272; cv=none; b=BKUgeWDidMJGBbpKQhsrOpNn3jJbGqvbbZTbcjkwukyHTVoKfC7f8M3NilnmCvh5dK8YdsXncPPtaG/zEXL3L1MSps3ZzIQI9vmt+IEQYmj1T6tGN/k2IbNvCiu+TqD9FJaSejxhqt8yg7anb1QYYTISm+Sjcp/WSz4oEzlKAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710272; c=relaxed/simple;
	bh=0EcWla/t7r2Is/Gsalb7DquSD5xPWNfAMnNZ1W4EqQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlYw9y3D8TTve2uASbO29BKEByO2JPo/4W4GKQOwaKG1bJzrzj6rpDiwxzxdmYfOVYmfZ4dbha+vD+KFL5L0R3BBY7u9qBFTH80Wl/bLKwTfXQDYFXFztQZ99tHOSHSlJOyLIpn/ZMKtKmF6Je6E2GRnTqzi+VN5v5vChgcWogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD6LUm8g; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD6LUm8g"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8748f34b1f2so396541b3a.0
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 22:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789710270; x=1790315070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DICFuZRT/wM26itDo1qul7ObG4+wCWuvarS8L5JEZpg=;
        b=iD6LUm8gu/+9qIkeAYgZ06uD8K2AzEfa/PjpUsXvIaANekpFA5IsIrTSTnHbJ7uhYi
         p8mm/ge2NatOxiLy0s01fxQcQUTq433w8dYKpxjh0ZeDAl4ukl0rNs4maYa2W6aejIiT
         dZrnRww3qyHAUdQpHPiWJdFVdYeOpsOe6Hmq9uKqkf7XnzPIi1QFZQzc/YIzMgfHJ+J6
         BFh9un4Cv2kJfDDHLvTHAs5qqT5Qoqy+3nTQc5lwtAPjTt95s2lLXJuR2KeyYWXdxr3p
         vYWkoSEF2+yO7L5X4xuBSV9PknyPYbxrHOz5vvF29MX373HbfNrkO7H/RtnpfPM+l7vp
         1OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789710270; x=1790315070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DICFuZRT/wM26itDo1qul7ObG4+wCWuvarS8L5JEZpg=;
        b=i+EEK7redMnWhP2AdxQ9e6TQ1zuj/FfQ+xOTNzXy252TALX8ycbDEEptGatEm5jE0t
         06UKFtMOrjAGA9QScHgTMUQdHJhiAiBpgRpdVykSe+L2coRztw7VstTy/Upik3oG820e
         oH7G2FQddn3Ts5lvOV8Sxyz3cI2lguTXlve9PMwaLsZIfVHEQvpuEwRnwoZJCI3++Kuz
         0gHfgX41poZ1UxHp6z74pnwG91rfGwlRH9P7H8i9lw8yDGLBkTptFQCGm2YBGzimvK4K
         BoiIZAR+W9D5u6LrQxM1W8IHbqmGNFrr9IX7pUTPrutgq0JpFo2pmkBSR6qV2geBZc0Q
         TTpA==
X-Forwarded-Encrypted: i=1; AKwUvBxaA5cnUIj7O9hyRN0dzZ27kC6DTUnRoEiOQwR3KqBX5bObDhsZu866DE/A5uI/oe9rQ3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lcRMih1asj8Yazcjjom7KuM9uJtyxzpNqhPsSIqG1MDi5kZK8G
	OvVLM1Jt4EkJg3H550e1Xp3WqY0brfPshZif3aOpyLSM65L8ywESY0+L
X-Gm-Gg: AYBFou2JqMbxXGc9FQG+7Ev/ryrjNCz46N+xYb9sLE6J4OjncxpOEsEm7jxI3lq9tZ1
	j7OZXOtE6qMTQKvMRTH7M22Z4aKcGsygmU3zs/anE5MQu5nU3GTGsldAU7EacyDVfIMCrYktNC6
	zUP6g2G2/1L5tXHmf1HiuDVqMf6yEbf6sJOnSv99DmJ8dK1AZ4pXZAbdvI1B84i2WrQY4vt5rXT
	sFNn0nX6GCZ/lQ9vPhZy/nIHXpURvS95kO6o+AOQo1Vvwf2xutvo9GOBWttmzdhZnV65lq44rhi
	AYvDzQTL7QYv0LMRRC5ofTNKrp5Ny8+Ijw2/DN+i7dRKiA7WTA/jCD3Rm5rDyN1iWvmHhbq+4Pf
	x4LboP5l0UvPG+re9zALOqsTQw5tqb5i82RfwLBjU7uOB6B+Q4V1Pxk9uzFZbbwDomwsOQzwPTT
	oAmpEz4KNtlHteo/zFz8Gt09VBJ7458gNPOU7KEIhirEEIsfysfL/VughsOiAlEREMy42ge1bHO
	tE/fAX3eNY3
X-Received: by 2002:a05:6a20:2d08:b0:3dd:85a8:4c61 with SMTP id adf61e73a8af0-3dd8c5c9c87mr2704565637.40.1789710269816;
        Thu, 17 Sep 2026 22:44:29 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce052a20sm1690447c88.12.2026.09.17.22.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:44:29 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] KVM: selftests: Move test_read() into elf.c and delete lib/io.c
Date: Fri, 18 Sep 2026 11:14:20 +0530
Message-ID: <20260918054420.338842-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lib/io.c has outlived its purpose.  test_read() has exactly one caller,
lib/elf.c; test_write() has none at all; and test_seq_read() is a
declaration in test_util.h with no definition anywhere in the tree.

Both surviving helpers open with

	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);

which can never fire, because @count is a size_t.  Building with -Wextra
points this out:

  lib/io.c:51:27: warning: comparison of unsigned expression in '>= 0'
                  is always true [-Wtype-limits]
  lib/io.c:128:27: warning: comparison of unsigned expression in '>= 0'
                  is always true [-Wtype-limits]

The comment above each assertion is worse than the assertion itself: it
cites the read(2) and write(2) manpages to claim that a count of zero is
allowed, but a zero count lands in "case 0" and fails the test outright.
The helper has never accepted what the comment promises.

Move test_read() into elf.c as a static elf_read(), named for what it
does rather than reading as "test the read() syscall", and assert that
@count is non-zero, which is what the code has always required and what
every caller already passes.  Drop the commentary describing retry
behaviour that the code makes obvious.  Nothing is then left in
lib/io.c, so remove the file along with test_write() and the stale
test_seq_read() declaration.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/aqxNbR9u5F1sqB3p@google.com
Signed-off-by: Gokul K <gokul02k@gmail.com>
---
v2: Implement Sean's suggestion instead of the original one-line
    deletion: move test_read() into elf.c as a static elf_read(),
    assert @count is non-zero rather than >= 0, and delete lib/io.c
    along with test_write() and the test_seq_read() declaration.
    v1: https://lore.kernel.org/all/20260917181028.288194-1-gokul02k@gmail.com

The only deviation from the diff Sean posted is the indentation of the
continuation line in the last elf_read() call: elf_read is one character
shorter than test_read, so checkpatch --strict flags the alignment.  With
that the patch is checkpatch-clean apart from the MAINTAINERS warning any
file deletion produces, and MAINTAINERS covers the directory rather than
lib/io.c individually.

Built with and without -Wextra: both -Wtype-limits warnings are gone, and
the patch introduces no diagnostic the tree did not already have.
kvm_binary_stats_test and ten other x86 selftests give identical results
before and after, which exercises the moved code for real -- every VM
goes through kvm_vm_elf_load(), which is the only caller of elf_read().

 tools/testing/selftests/kvm/Makefile.kvm      |   1 -
 .../testing/selftests/kvm/include/test_util.h |   4 -
 tools/testing/selftests/kvm/lib/elf.c         |  48 +++++-
 tools/testing/selftests/kvm/lib/io.c          | 157 ------------------
 4 files changed, 43 insertions(+), 167 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/lib/io.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 96bab7002d39..d12c1c738956 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -6,7 +6,6 @@ all:
 LIBKVM += lib/assert.c
 LIBKVM += lib/elf.c
 LIBKVM += lib/guest_modes.c
-LIBKVM += lib/io.c
 LIBKVM += lib/kvm_util.c
 LIBKVM += lib/lru_gen_util.c
 LIBKVM += lib/memstress.c
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a6a3e1657895..e558346c3b69 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -49,10 +49,6 @@ do {								\
 
 #define TEST_REQUIRE(f) __TEST_REQUIRE(f, "Requirement not met: %s", #f)
 
-ssize_t test_write(int fd, const void *buf, size_t count);
-ssize_t test_read(int fd, void *buf, size_t count);
-int test_seq_read(const char *path, char **bufp, size_t *sizep);
-
 void __printf(5, 6) test_assert(bool exp, const char *exp_str,
 				const char *file, unsigned int line,
 				const char *fmt, ...);
diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
index 1924a9895834..d5adb68fd7c0 100644
--- a/tools/testing/selftests/kvm/lib/elf.c
+++ b/tools/testing/selftests/kvm/lib/elf.c
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
@@ -186,8 +224,8 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 				"  expected: 0x%jx",
 				n1, errno, (intmax_t) offset_rv,
 				(intmax_t) phdr.p_offset);
-			test_read(fd, addr_gva2hva(vm, phdr.p_vaddr),
-				phdr.p_filesz);
+			elf_read(fd, addr_gva2hva(vm, phdr.p_vaddr),
+				 phdr.p_filesz);
 		}
 	}
 	close(fd);
diff --git a/tools/testing/selftests/kvm/lib/io.c b/tools/testing/selftests/kvm/lib/io.c
deleted file mode 100644
index fedb2a741f0b..000000000000
--- a/tools/testing/selftests/kvm/lib/io.c
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
-- 
2.54.0


