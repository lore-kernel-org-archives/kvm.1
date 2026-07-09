Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FAD4DA53B
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619407; cv=none; b=Pkb1t3JfEy4NnUpTjWbLiL/Jj6Twol4CSFixdaKug3o3AoISBdV/w3ZIxBSzOEP+45fI/HKeMj01qrfrDw+4tJT7h0rEgOxlRyI1xN+nA+vrHcgCokwjXW1OdLss7magVmjl8PdkUshl42c3OCH49NW/jFPY3oZbtQDkPACNH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619407; c=relaxed/simple;
	bh=NINPbgfWAFZPM9X858x1O8rMfSvtYHuE/EpBXP/sbuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWgBUyDLeRGYX7eozmxnP7CyftOxOaMeG32i/3gJVRa384vNtbmZ3BnUcxQz9L7mrF2TUanIL/3QQuJ3usDEGuEwNBVW+6kpoN7OOO3MZMLRmrJR5HOQpaeMBr1Ygw6TVNQGK5MLnXd31qa/0nW3+vFXRlhZCnecwkqeJaBave8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/8bLBTi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/8bLBTi"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3817f800c8bso189394a91.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783619405; x=1784224205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hLRdI6+J0mg7/olAsLtQydfnWeoptTveOjexzjiBEPo=;
        b=O/8bLBTi1kcn4CjGBB0l/HCq9nRZ2/cN1ciem1G8hqIeGGehjn7clFQ29x58iUcmWG
         I53TisiqUMaGJ3buJaFrhV3t+1dxuCZaHsdTQhT6wZVsg4oT6Kp8QSZuIQa9+gngR06F
         98Nz8x4oMn7m9JeDwpRCGSD5LM3IAlaPrSpaZ+V5wOh66FX8/bzDSmItXPchDK03Lgqc
         a5iGbVrTpUh4Din8DOMeVUlZ4tGTTVE7iIMK4YUA7CRb/Zc+4fvoCyi4G38vGHwCCp9C
         s/Xxwm5txM0+eBp9/xvO1TGPf7x7cKWrotQ/zCrpfenCiLRr42+1fsKbRLvMOLp3xn10
         wJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783619405; x=1784224205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hLRdI6+J0mg7/olAsLtQydfnWeoptTveOjexzjiBEPo=;
        b=HiNdU1m/pCnMHsz87AmGXxqARsefPkmr79fzM4yyaOKmp85KQ7dnbqV+0YOf/hnpT3
         JeLjN8FVuRBdzheB/Ndx2qehiVNXvYG0FdRP0gqEc93AAeBlJikwhlXV9cgN1/e1cDnQ
         t41hsDHbMbwU8DwsjkO8BVng8YFsPvp/6zsavZq53s3m0V8Zn8EOupLW74tGK5zmlKtO
         Pz/hvUasmyawu7nr2RzI68APc/PkE2iFSYebFdlCOgP/3/aIqsxpSG839VUJrU+Kvob4
         qQKqwpm3C0G0Hs5m3Ejbha73VYplWvpHFj0/shoqHJdWp8Xs7VGFXHnPB4y5OqLhORpP
         JOlg==
X-Gm-Message-State: AOJu0YwKG+ZAAGpXNww1yldYZfRSMpg1ZB9Yyy283vE+gOD7tKASMZwy
	U7z1SB4S1BNaDTf5XIyJ0or+7n9SlLcpgb/jg89Wn9WiW/4SUzBx5AiV
X-Gm-Gg: AfdE7cltGxK3wyVppppU2MLIZnQLumIXUdCLba2e7bRsCd4eZAlMJbnSzSvAtwkIo14
	YZAiGzdfHAvvX/ET+LEfo+/dMXq5GpC2adj5ts6NFgJHe1bq52gdJaxnJd80q3p9r2cZ2mslstc
	aQnE6YoSJMTVX7Qs87wQfxBrY3zxaESGxW9t8gQ166VWgB27pApijZs7DtApmhl+1l2j25IhtqQ
	hPU3FxwzoIqZ9PdiVNfcWL3QoMzGsNPXnmkOs4MCGFRskkAzfGg7tc/VOh21luNW7/yj1UiCdBS
	/DvFiXfEZuJPNQ8E5Lc9EKeJLnZpuWiwHMZzkOtbdPAVxoKbh6geMJ3kvs/QXeC9A/AHwhBjMCg
	sAe7p34hmLyE5Kf/wrcJGGcEJLVF/5UUUvX7b/GK5Z9lV/9nbNkP3/LgmNKIqPZy8LovA6gWzCq
	zBWCvmV3qt4+sxmVv1txQITAJy1PXNYDoG5sQ=
X-Received: by 2002:a17:90b:5845:b0:37d:f0dd:e715 with SMTP id 98e67ed59e1d1-3894024d8e6mr8531603a91.10.1783619405328;
        Thu, 09 Jul 2026 10:50:05 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm2206765eec.15.2026.07.09.10.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 10:50:05 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hemanth Selam <hemanth.selam@gmail.com>
Subject: [PATCH v2 1/2] KVM: selftests: SEV: Verify unsupported VM types are rejected at creation
Date: Thu,  9 Jul 2026 23:19:54 +0530
Message-ID: <20260709174955.628913-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260709174955.628913-1-hemanth.selam@gmail.com>
References: <20260709164751.621326-1-hemanth.selam@gmail.com>
 <20260709174955.628913-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_vm_types() only exercised creation of the SEV/SEV-ES/SEV-SNP VM
types that the platform actually supports, leaving the previously noted
TODO ("check that unsupported types cannot be created") unaddressed.

Add test_create_invalid_type() which issues a raw KVM_CREATE_VM for a
given type and asserts it fails with -EINVAL, and invoke it for
KVM_X86_SEV_ES_VM / KVM_X86_SNP_VM whenever the corresponding capability
is not advertised. Because vm_create_barebones_type() asserts that
KVM_CREATE_VM succeeds, the check is issued directly against the KVM fd
so the negative path can be observed.

TEST_ASSERT() aborts the program when its condition fails, so the helper
releases the fd and latches errno before asserting: if KVM_CREATE_VM
ever wrongly succeeds, the VM fd is closed rather than leaked, and errno
is captured before close() can clobber it.

While here, stop shadowing the file-scope kvm_fd with a local in main()
so the new helper can use it.

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 .../selftests/kvm/x86/sev_init2_tests.c       | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 8db88c355f16..7663418b3fa8 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <pthread.h>
+#include <unistd.h>
 
 #include "test_util.h"
 #include "kvm_util.h"
@@ -73,19 +74,34 @@ static void test_init2_invalid(unsigned long vm_type, struct kvm_sev_init *init,
 	kvm_vm_free(vm);
 }
 
+static void test_create_invalid_type(unsigned long vm_type, const char *msg)
+{
+	int fd = __kvm_ioctl(kvm_fd, KVM_CREATE_VM, (void *)vm_type);
+	int err = errno;
+
+	/* Clean up before asserting; TEST_ASSERT() aborts on failure. */
+	if (fd >= 0)
+		close(fd);
+
+	TEST_ASSERT(fd < 0 && err == EINVAL,
+		    "KVM_CREATE_VM should reject unsupported type (%s), got fd=%d errno=%d",
+		    msg, fd, err);
+}
+
 void test_vm_types(void)
 {
 	test_init2(KVM_X86_SEV_VM, &(struct kvm_sev_init){});
 
-	/*
-	 * TODO: check that unsupported types cannot be created.  Probably
-	 * a separate selftest.
-	 */
+	/* Unsupported types must be rejected by KVM_CREATE_VM itself. */
 	if (have_sev_es)
 		test_init2(KVM_X86_SEV_ES_VM, &(struct kvm_sev_init){});
+	else
+		test_create_invalid_type(KVM_X86_SEV_ES_VM, "SEV-ES is unsupported");
 
 	if (have_snp)
 		test_init2(KVM_X86_SNP_VM, &(struct kvm_sev_init){});
+	else
+		test_create_invalid_type(KVM_X86_SNP_VM, "SEV-SNP is unsupported");
 
 	test_init2_invalid(0, &(struct kvm_sev_init){},
 			   "VM type is KVM_X86_DEFAULT_VM");
@@ -121,9 +137,10 @@ void test_features(u32 vm_type, u64 supported_features)
 
 int main(int argc, char *argv[])
 {
-	int kvm_fd = open_kvm_dev_path_or_exit();
 	bool have_sev;
 
+	kvm_fd = open_kvm_dev_path_or_exit();
+
 	TEST_REQUIRE(__kvm_has_device_attr(kvm_fd, KVM_X86_GRP_SEV,
 					   KVM_X86_SEV_VMSA_FEATURES) == 0);
 	kvm_device_attr_get(kvm_fd, KVM_X86_GRP_SEV,
-- 
2.43.7

