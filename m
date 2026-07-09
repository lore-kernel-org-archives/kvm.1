Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B98393DC8
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615684; cv=none; b=sWwYVIWi5QTAcB8vZNIFQhk9d+WOiB+6R830tu2Hv36i5BxWMW8B0QAbQKUDIpNYmpLP3uRsatOsmQXZ33t6WBvFHxxGELLXp4NXhEFQJ8lRpk3GMOQSHTVswRiEKdoTfJkA5UmWDrwau2tVYtUJqry8Wiwaqw96pz2ScVFjNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615684; c=relaxed/simple;
	bh=Z+4tqitCbQh3B8mckE0OIu/tA1vLQT+/k5COMzAKuIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiOXgY7cX4yydPhRAzpLyYvlN2Yfz1N9lbPL20WHtvLstm9MR+/7T87Jr+wFEYMs4IHVJ2RHJMJO1JCLhrk/PCE7MYwK6j+aBP1v/PoOSHu3l2NhvfojzUjradLCOZ1LbnE/T3aFOBJBNakksrR7CR/sjF8eCktzdu4h/45GD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhX235ki; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhX235ki"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so21293a12.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615682; x=1784220482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Vfm2VWY+NE5ImR2oYlfIdcchFPyhPWsazIC25E8Q0U=;
        b=PhX235kihY7Y3Ox4LcFJ/MLdFOVCXyQFE4ajwFRkr7xHAs+G1FoxwerkWMugy1NI2o
         iAxw8FgQspTdgSRjCL7NFVaICXseCNf9GaCgfuKxse/2luquGu4pPdmvvhwlE/GR8lPf
         7zCm/96cerkwbGpn+vZtcbTQilCDVcUp14Ftw1U4CgDJ5qPBPRa1wFcarlEpEQihTLxo
         U9nYHkDhlM0yjw6tQfcvmTNscQZFirlO5GjtHjRypTlrJf64B6yAQAyUHeJeNkNUuBEb
         dD8Pu8B69tbqOniLcZJKzeUFCvu2Wtrg38nq8u6SVvdTYpJHIZW49V8B2g2Qlkq2aTs8
         Q+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615682; x=1784220482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Vfm2VWY+NE5ImR2oYlfIdcchFPyhPWsazIC25E8Q0U=;
        b=CCnFDhbVf4fNYrGV/+rhWLqb3GUH71pG5L9BdQoYQVRAOwhB/VLncLy0zwnwn7x+y9
         gYlfDJ4oVzi9MA2yhupqvvtfJToAZSvJLKMxLaSY5u0OjhjekyViYLO6aw+1OtECJKCJ
         AZ/SOIhv7oMSzB1+Qun+u409XoV/x77jUUBcZfLrQ2d4NTHtCIKkEJthbOUBjtTkrtlB
         9t1ATQg2ds3T9OS2m9brawD/neSPUfLqsh8VaDF+SZyhchL2v2tGTDJPIRs5QdYXSyGN
         +JxZxX6Kf4XIcuYXRJU9/jE1skqpH+8SoueArIeg4Hrl7caThGix0vOIH6+hRQHRACVk
         IDFw==
X-Gm-Message-State: AOJu0Yy8U/W4YF5lHZ9aJUDSUlgzXW1CDrvYqPlTquyKK23KAeDM0pK/
	0NFtg+pG5uAL32RY4CITmzitVB0D5hURDyVZrt0jqiqrEFjL47pG8oYN
X-Gm-Gg: AfdE7clkvkt3vYgfp+v9l1MUBIbp/XeOl74Lafwv+XQWkgZIA+IH/VHizClgND2xc2r
	pFN3ZIFsQb2Zz0/GTWsR7H7UHZpl8OuXhn8IKIfKwXOWcGJZry5/ZgLNo8IKshyuknh/eSqfhy7
	gn80nn678KRkXQ2gSFwLfY/CTIowp9wJ1nOC3wTTZS36mKFyfqxRCtkA2KZdfjjXfo+RudDfh+v
	CVR6pGo0gM/EnoHf0c5tk2ns7CDDrIFZz94gVRkulnE46q/VLvQG8JD9dMlfXZffa1Fyq905TOy
	oqcUlbrjAkQkXU5Q1cvgQePWz2StnEiOwmPArqCqvHb0w+KRTwCrDdwzozW1I9TcaX+DHC8R1sL
	ph5nk4u4scbndHCaIHmClXVDPfd2/TCVVXyoDysWMnLOfw1ETxB4lvhBCqFgl7q0165LdwZft6k
	Lt8N7VWxrsjsV32PSdPgb4XkYvcfbXZfigGwY=
X-Received: by 2002:a05:6a21:1493:b0:3b7:d8d5:2326 with SMTP id adf61e73a8af0-3c0bcf49541mr9699509637.1.1783615681543;
        Thu, 09 Jul 2026 09:48:01 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c4ddsm35709287c88.1.2026.07.09.09.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:48:01 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hemanth Selam <hemanth.selam@gmail.com>
Subject: [PATCH v1 1/2] KVM: selftests: SEV: Verify unsupported VM types are rejected at creation
Date: Thu,  9 Jul 2026 22:17:50 +0530
Message-ID: <20260709164751.621326-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260709164751.621326-1-hemanth.selam@gmail.com>
References: <20260709164751.621326-1-hemanth.selam@gmail.com>
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

While here, stop shadowing the file-scope kvm_fd with a local in main()
so the new helper can use it.

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 .../selftests/kvm/x86/sev_init2_tests.c       | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 8db88c355f16..724ff11f16c9 100644
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
+
+	TEST_ASSERT(fd < 0 && errno == EINVAL,
+		    "KVM_CREATE_VM should reject unsupported type (%s), got fd=%d errno=%d",
+		    msg, fd, errno);
+	if (fd >= 0)
+		close(fd);
+}
+
 void test_vm_types(void)
 {
 	test_init2(KVM_X86_SEV_VM, &(struct kvm_sev_init){});
 
 	/*
-	 * TODO: check that unsupported types cannot be created.  Probably
-	 * a separate selftest.
+	 * Types that aren't supported by the platform must be rejected by
+	 * KVM_CREATE_VM itself, before any KVM_SEV_INIT2 can be attempted.
 	 */
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

