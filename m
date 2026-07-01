Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF70C431E7B
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935404; cv=none; b=f8FK5HmkunNz+Dzpnb2AQpn7DWftLPfqd3qJWSsecTgsD28ULQGtxJF4Gx2xoaBs7/aagXmQhOzBLtoLDtHncpTPG1fqI5TFSJe/9swGbr4SpG9zJR8l7ExxKjYuxrY2qKbGFDMAfj1W/0wExs69YirSqyPp+iWr26ZSfOiwRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935404; c=relaxed/simple;
	bh=5LknTZeklHoNiKFx5v2jzdgzNqY68L9Q1aRYw0sUOmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJYtQuCYfSedN8sAYWCF9H4WrLHA3z2dV0q/3gJAvsfaSr57bQffAbP+wf7XX5teaJKuaGHDZhWrAUXBvopoTj+I0Y/PLR5eQf62g2J+P0tL0ESgk7LS1aKi0BNuc9c31Yhxn9cWyqzeBNmEZ2FlpJKe8RRhc/BaC7Rw608ptkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQgIe3X/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQgIe3X/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8479f1a86ecso658002b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782935402; x=1783540202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwr9YVutqkbhl3uDhDv6Z3opOcU7ifecUaxHXT9tCHc=;
        b=qQgIe3X/89StHpjXW1PReNOwvyCfC9MAhnPLCGRVM0fb40W917eMOpaNGHkDt7NbBz
         fkDgjCw2wBsXvUYzPuYcREonUGtkUYkV+AfbMcU21nFE43IfVhLeIFvhApgGT5QD/9ph
         a4JgJx6U3jDFKphgX8iV1tVx3/tCvzFQT79QyQzLZE8n+k4YI6bZVL2DdNInGLzlus+R
         /1rosMakToZCXAJPTnsraLUIVXyonTTSGKBIOuJg1ZmoEL3bxX/QjIdZN7eWjE2u0+mI
         AyXjSpRaD151tkvV7ioLlSNsbu5y7th6bvSDOiM1Kh+LynCrYUJYthEX+Bw3Ju1yXBsY
         YhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935402; x=1783540202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gwr9YVutqkbhl3uDhDv6Z3opOcU7ifecUaxHXT9tCHc=;
        b=pcjMWXY8SEtbGe853yHTMhFqjK/ZTCNSI6II/KTZfOm1z5Y+/aS7gFzYwl5UMUo5YX
         TLUXXElGYuaJtlkp5YEj0WvjY84cnGueIy2IxGQuIM5QPvIGsaB70VOkxPiIZQNxUEZa
         lx1zDHCxf0DTR5eQyJvpkPLmepxRd2F8AWuDv7nq8e+vSkzfOfGt1q1+EsYFKtSpkjG/
         SLVZldfQqT3jPdylIm07wkDArguY5Z6rmL1YcPIitqZRGRAU/nkr3/uRGDqBwjT5+iqa
         bXcqJwsBh0jjm1e8xqsFw6Fi+chvOSEtsn0Pr6BA4YoK+4H3rJiuPy2t59C+pfOwLga/
         z1kQ==
X-Gm-Message-State: AOJu0YyeEM5U8no4lgq4Qaok9LtbtvCwwdTbHZClmWVZirYuX8FECd/+
	492J8wkGQ0trK7Mn0x88DFOPw5vcauTqekeI30+F95PqSyO/s4muo7x99LPO656CCiw=
X-Gm-Gg: AfdE7cncZMETFKp9NshCsDCXaWK3irybOgTNtJxJg2wbkUBy7oEzTo6gBCYpma8hpJX
	MTiv2AhHIGNs2Xe856DtCsNbtokcl/2wvjM3BHdloy5rwytvfGjV2/Cee4sOVyUVv24v4+M3BId
	pgZvamm3Csy53RDFOC7WWGOWH3+jDVPru8HvuDgeJT1trnkr3YfTjHTWbWStE7CKaEbXIgre+KZ
	ZZsTZd7JbDygruGpBKBYeFlom4yZoEINiJeQKx6qKebL4ck3gVmbisqWmZrH/qi55r/QsXtA7I0
	D6zeTIlc+ZOn0gfMv59SQunZVbYnsSB9Syg3AZcmBW1njNTBwYnXXuMA5zOWSqFZYRtfABhZ0z1
	TWJIxli3xWg6e6ndhYy6nzON7cv1nGUOEwv9mTFJbb+msXtnu6JhxZnuYhR75/KkLxxTiZoMAVX
	DlFtVPby5vURd+nvAx4/A1
X-Received: by 2002:a05:6a20:914c:b0:3bf:a0e5:999f with SMTP id adf61e73a8af0-3bff40fc2fdmr2507086637.22.1782935402043;
        Wed, 01 Jul 2026 12:50:02 -0700 (PDT)
Received: from RodriguezRyzen.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b81f3dbsm844143eec.11.2026.07.01.12.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 12:50:01 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kselftest@lists.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH 1/1] kvm: reject unknown flags in device and dirty-log ioctls
Date: Wed,  1 Jul 2026 16:49:46 -0300
Message-ID: <20260701194946.768731-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701194946.768731-1-ivanrwcm25@gmail.com>
References: <20260701194946.768731-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

KVM_CREATE_DEVICE only defines KVM_CREATE_DEVICE_TEST, but unknown
flag bits were silently ignored. kvm_device_attr.flags is documented
as unused yet was never checked centrally. KVM_ENABLE_CAP for
KVM_CAP_DIRTY_LOG_RING and KVM_CAP_DIRTY_LOG_RING_ACQ_REL requires
cap->flags to be zero per api.rst, but the generic handler did not
enforce it.

Reject unknown or non-zero flags with -EINVAL, consistent with other
KVM ioctls and dma-heap flag validation. Add a selftest covering all
three paths.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/ioctl_flag_validation_test.c          | 104 ++++++++++++++++++
 virt/kvm/kvm_main.c                           |   9 ++
 3 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/ioctl_flag_validation_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d28a057fa6c2..38c78838318c 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -59,6 +59,7 @@ TEST_PROGS_x86 += x86/nx_huge_pages_test.sh
 TEST_GEN_PROGS_COMMON = demand_paging_test
 TEST_GEN_PROGS_COMMON += dirty_log_test
 TEST_GEN_PROGS_COMMON += guest_print_test
+TEST_GEN_PROGS_COMMON += ioctl_flag_validation_test
 TEST_GEN_PROGS_COMMON += irqfd_test
 TEST_GEN_PROGS_COMMON += kvm_binary_stats_test
 TEST_GEN_PROGS_COMMON += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/ioctl_flag_validation_test.c b/tools/testing/selftests/kvm/ioctl_flag_validation_test.c
new file mode 100644
index 000000000000..30c22435bb14
--- /dev/null
+++ b/tools/testing/selftests/kvm/ioctl_flag_validation_test.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that selected KVM ioctls reject unknown flag bits with -EINVAL.
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+
+static void test_create_device_unknown_flags(struct kvm_vm *vm)
+{
+	struct kvm_create_device cd = {
+		.type = KVM_DEV_TYPE_VFIO,
+		.flags = 0x2,
+	};
+	int r;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DEVICE_CTRL));
+
+	r = __vm_ioctl(vm, KVM_CREATE_DEVICE, &cd);
+	TEST_ASSERT(r == -1 && errno == EINVAL,
+		    "KVM_CREATE_DEVICE with unknown flags");
+
+	cd.flags = KVM_CREATE_DEVICE_TEST | 0x2;
+	r = __vm_ioctl(vm, KVM_CREATE_DEVICE, &cd);
+	TEST_ASSERT(r == -1 && errno == EINVAL,
+		    "KVM_CREATE_DEVICE TEST with unknown flags");
+}
+
+static void test_device_attr_flags(struct kvm_vm *vm)
+{
+	struct kvm_device_attr attr = {
+		.flags = 1,
+		.group = KVM_DEV_VFIO_FILE,
+		.attr = KVM_DEV_VFIO_FILE_ADD,
+		.addr = 0,
+	};
+	int dev_fd, r;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DEVICE_CTRL));
+
+	dev_fd = __kvm_create_device(vm, KVM_DEV_TYPE_VFIO);
+	if (dev_fd < 0) {
+		pr_info("Skipping device_attr test, KVM_DEV_TYPE_VFIO unavailable\n");
+		return;
+	}
+
+	r = __kvm_ioctl(dev_fd, KVM_HAS_DEVICE_ATTR, &attr);
+	TEST_ASSERT(r == -1 && errno == EINVAL,
+		    "KVM_HAS_DEVICE_ATTR with unknown flags");
+
+	close(dev_fd);
+}
+
+static void test_dirty_log_ring_cap_flags(struct kvm_vm *vm)
+{
+	struct kvm_enable_cap cap = {
+		.flags = 1,
+		.args = { 4096 },
+	};
+	int r;
+
+	if (!kvm_has_cap(KVM_CAP_DIRTY_LOG_RING) &&
+	    !kvm_has_cap(KVM_CAP_DIRTY_LOG_RING_ACQ_REL)) {
+		pr_info("Skipping dirty log ring cap flag test, cap unavailable\n");
+		return;
+	}
+
+	if (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING)) {
+		cap.cap = KVM_CAP_DIRTY_LOG_RING;
+		cap.flags = 1;
+		r = __vm_ioctl(vm, KVM_ENABLE_CAP, &cap);
+		TEST_ASSERT(r == -1 && errno == EINVAL,
+			    "KVM_ENABLE_CAP DIRTY_LOG_RING with unknown flags");
+	}
+
+	if (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING_ACQ_REL)) {
+		cap.cap = KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
+		cap.flags = 1;
+		r = __vm_ioctl(vm, KVM_ENABLE_CAP, &cap);
+		TEST_ASSERT(r == -1 && errno == EINVAL,
+			    "KVM_ENABLE_CAP DIRTY_LOG_RING_ACQ_REL with unknown flags");
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+
+	vm = vm_create_barebones();
+
+	test_create_device_unknown_flags(vm);
+	test_device_attr_flags(vm);
+	test_dirty_log_ring_cap_flags(vm);
+
+	kvm_vm_free(vm);
+	return 0;
+}
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..a2aecc06ab67 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4719,6 +4719,9 @@ static int kvm_device_ioctl_attr(struct kvm_device *dev,
 	if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
 		return -EFAULT;
 
+	if (attr.flags)
+		return -EINVAL;
+
 	return accessor(dev, &attr);
 }
 
@@ -4811,6 +4814,9 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 	int type;
 	int ret;
 
+	if (cd->flags & ~KVM_CREATE_DEVICE_TEST)
+		return -EINVAL;
+
 	if (cd->type >= ARRAY_SIZE(kvm_device_ops_table))
 		return -ENODEV;
 
@@ -5061,6 +5067,9 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
 		if (!kvm_vm_ioctl_check_extension_generic(kvm, cap->cap))
 			return -EINVAL;
 
+		if (cap->flags)
+			return -EINVAL;
+
 		return kvm_vm_ioctl_enable_dirty_log_ring(kvm, cap->args[0]);
 	case KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP: {
 		int r = -EINVAL;
-- 
2.43.0

