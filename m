Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47517223708
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790299873; cv=none; b=ZrJHOzzjHHPtJH81TBM0qSCQsjgoyKIdZcXQVlRRqjZSc+MPh24Sr/89tMgaRPUCAbu0tufXlCLWZ/NRyOKuJRGTAUKVdtWD5y9b1bsehwKxE9/BhzTZ0pG3LNtgt4jwb/w88LYnptZE/g+XQ4khketwwNcBpEz6LXLOgX9Ndtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790299873; c=relaxed/simple;
	bh=wQKRtKLqGJCDEPvz/iqrGK9BVlTgRu7XZjqe2Rl0nXs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O9FW3RWo0ynRoTrDWP1EQzkooQT5tdkl5zLVU1dw4euFfgigCQqVIRtT/kJ364C/Yxz+ZLEOLLySoLVGnk3NnIPzEJV1JBabqBk7/zYnohrIMlLmorcqAxkqzgt6Qqt6uYIBn42ntDXjYizX6hm1rmH9pzoypvilScLdXEltbTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muwa7T1w; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muwa7T1w"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d7443e0f0bso4437445ad.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 18:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790299872; x=1790904672; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RweWv4r3+tfjVI8UGCUJFPVFEYFdP24TgU4ruOZ3H6U=;
        b=muwa7T1wQ2KVoaw0oqoDpwpajVIn8JcQlKrdUqYZt5u41V1O6NtE7016R2c2eqes6q
         +FaGz+LaiagSrk+OeaKHuy6QJ59mEX7fttK7G3Rl0JSREyaBmMuHupVvnbRnFK8kTk60
         WYVKsEC2MVi+KegittYxRdQaNCB/6onFEEvVcstdkRL73Sh15k2+Gtn+HSzaLP59Zspb
         ghkqsr1qvUuT0ndwfQ3+/uEvXuaurxI/kU8YIgVAn3p/zJ1NHrPb0k/I/FJasfhQT/wM
         /a7oCF77FF9nFAC6SkYI26WuihH74kl21T8GkncMzbee6ndWhVm8aD2ZYMoJ9YZQv4qI
         kFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790299872; x=1790904672;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RweWv4r3+tfjVI8UGCUJFPVFEYFdP24TgU4ruOZ3H6U=;
        b=ksx7OC+afQLBX9tFssvIb0DcKweD3dEBYM6QNTiRtZDx3+dtv0KrEyI6DtoAfpY+2v
         OYwrIHyxI+DQOvpzQU1kvlnhxS7QqFOdqIxyLvwxC687LbeBrjHoHiCtf0jXJ14DOeEg
         r1cMyC7QYCm3lX2PxXiy1Z1iMaqjfa4I1PEYn+emqxUgjb7+6Sj6DDtfLhzrVX3HYHxP
         PToP4BYUzWRIgcBPwzp9vZ2HKFlL2Q2TCjthZNln7V5/SVCkBnT20IxJ46dmDhsCjxbQ
         RtS+IpZXTYBc++rt2pMnrSayzh3nSkSVOfboPvqDSXUCP71kmiG4otiw19nEi/ab5iTV
         MsbA==
X-Forwarded-Encrypted: i=1; AKwUvBxHori2Lz0ruK75pimzjTYgmEYorP1mLHP0KD7qVybBt1nrePf7gOQb3Avj6BsvjfKoFCE=@vger.kernel.org
X-Gm-Message-State: AFuF++kd4ETvSf7c7ToGDO4nAWwn1w6ryvkYZCN7bN0l5lwq1tYmAiRo
	WzRAS7WcWD5wY0OVNbaMgfgwyMEYeqNfg7gs5hmPHCs88r90x0WewWcjrWor6MoFylRf7UjaCfL
	X438/oJPj0DFMQQ==
X-Received: from plmo2.prod.google.com ([2002:a17:903:18c2:b0:2df:7a17:a791])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c8:b0:2dd:ad73:c938 with SMTP id d9443c01a7336-2df7daa9ba8mr31900875ad.25.1790299871207;
 Thu, 24 Sep 2026 18:31:11 -0700 (PDT)
Date: Fri, 25 Sep 2026 01:30:55 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925013110.3447626-1-skhawaja@google.com>
Subject: [PATCH] vfio: selftests: Remove libuuid dependency
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	Alex Mastro <amastro@fb.com>, Sean Christopherson <seanjc@google.com>, Rubin Du <rubind@nvidia.com>, 
	Josh Hilke <jrhilke@google.com>, Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Libvfio depends on an external dependency libuuid for parsing vf_tokens.
Building it in cross compilation environments gives the following error,

 ld: cannot find -luuid: No such file or directory

As it is only used for parsing vf_tokens, remove the dependency by open
coding the parser where it is required.

Tested by running vfio_pci_sriov_uapi_test selftest.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 tools/testing/selftests/vfio/lib/libvfio.mk   |  2 -
 .../selftests/vfio/lib/vfio_pci_device.c      | 57 ++++++++++++++++---
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index bcfa74ae040e..7d6916ca3940 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -29,8 +29,6 @@ $(LIBVFIO_O_DIRS):
 
 CFLAGS += -I$(LIBVFIO_SRCDIR)/include
 
-LDLIBS += -luuid
-
 $(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c | $(LIBVFIO_O_DIRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4063a0e2b3df..774d1e90ec0e 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -23,11 +23,54 @@
 #include <linux/types.h>
 #include <linux/vfio.h>
 
-#include <uuid/uuid.h>
-
 #include "kselftest.h"
 #include <libvfio.h>
 
+/*
+ * Minimal replacement for libuuid's uuid_parse(). libuuid is part of
+ * util-linux and is routinely absent from cross-compilation sysroots, which
+ * makes the vfio selftests unbuildable for non-native architectures. The only
+ * thing needed from it is parsing a VF token, so open-code that instead.
+ */
+#define VFIO_UUID_LEN		16
+#define VFIO_UUID_STR_LEN	36
+
+static int vfio_uuid_hexval(char c)
+{
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	if (c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	return -1;
+}
+
+static int vfio_uuid_parse(const char *in, unsigned char uu[VFIO_UUID_LEN])
+{
+	const char *p = in;
+	int i, hi, lo;
+
+	if (strlen(in) != VFIO_UUID_STR_LEN)
+		return -1;
+
+	for (i = 0; i < VFIO_UUID_LEN; i++) {
+		if (i == 4 || i == 6 || i == 8 || i == 10) {
+			if (*p++ != '-')
+				return -1;
+		}
+
+		hi = vfio_uuid_hexval(*p++);
+		lo = vfio_uuid_hexval(*p++);
+		if (hi < 0 || lo < 0)
+			return -1;
+
+		uu[i] = (hi << 4) | lo;
+	}
+
+	return 0;
+}
+
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
@@ -167,13 +210,13 @@ static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data
 
 void vfio_device_set_vf_token(int fd, const char *vf_token)
 {
-	uuid_t token_uuid = {0};
+	unsigned char token_uuid[VFIO_UUID_LEN] = {0};
 
 	VFIO_ASSERT_NOT_NULL(vf_token, "vf_token is NULL");
-	VFIO_ASSERT_EQ(uuid_parse(vf_token, token_uuid), 0);
+	VFIO_ASSERT_EQ(vfio_uuid_parse(vf_token, token_uuid), 0);
 
 	vfio_device_feature_set(fd, VFIO_DEVICE_FEATURE_PCI_VF_TOKEN,
-				token_uuid, sizeof(uuid_t));
+				token_uuid, sizeof(token_uuid));
 }
 
 static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
@@ -415,10 +458,10 @@ int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
 		.argsz = sizeof(args),
 		.iommufd = iommufd,
 	};
-	uuid_t token_uuid;
+	unsigned char token_uuid[VFIO_UUID_LEN];
 
 	if (vf_token) {
-		VFIO_ASSERT_EQ(uuid_parse(vf_token, token_uuid), 0);
+		VFIO_ASSERT_EQ(vfio_uuid_parse(vf_token, token_uuid), 0);
 		args.flags |= VFIO_DEVICE_BIND_FLAG_TOKEN;
 		args.token_uuid_ptr = (u64)token_uuid;
 	}

base-commit: 3d7783543c2646af69ad65825e810060494bea21
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

