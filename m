Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262823EC80B
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390091; cv=none; b=WHlFU4kFT2k1yfHBaCwLwvxgKliw0ECBJR/oaohJjj381GbYQ6SFpb+MWk261c/DiGoCkuYn3v58I/p/MnxwKTdi98LUb/unVtEJj/t7Fr/zdnOo+XMI8cQ0doURnXA9WDs3IBZhI2OYWtdBYbd0+odT95OVaA7j31D0zrhu49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390091; c=relaxed/simple;
	bh=jkKXEIPOwBCki7hEhUKs4g/CFbe6ChFGK0eVQgaU6nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vw4MK2f1dtPHwXyEBuyFNrY42CaWzUBn4EmifBWMV1iDr7lA1hgt7pSwBC8NfpBlnaVwkx/ORcz9szA1KMh/sJgWYW6xWpUVT22Uqp2j0ZVZbfuLMafE9qiV7gHalIa+or0brDT0aQ5m1vXHe/Gzg0DR88u1q1Q1kojPbsNQUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hokODlGZ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hokODlGZ"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-46a4870536fso1217408fac.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390082; x=1788994882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SPSwC6FIuR2igZB1JOk61BDdzgs1mNnqoV9+SaxkZ8=;
        b=hokODlGZV9B+JuieLJ932AouOKFaQ2dpL1Lsn2rq5uRPMKbvjRfvde7JU/JkC8in4L
         FsqxSbBcjNrPdOBVtEZFbZZqL6HzxyWFgMnuVYpDO9ER0TXs6KBrv0ga02eMvZpUvs3O
         KkDPRQUSlr7SwCS+ddFo1PzFE1jlNNq7zrncaV9Msp3a/vC31kWygiNUMt5FBhsiqJBV
         olYX9MDYVrjSPFF/6a4Je4LPqi4IJCGAkMZ6Y04XKtuIK1GvSMiAqLWHAZODx8Ru8c9K
         3r8B62HofTd1NN1RU7U0Tb5TYiwUVBEGVtxCTqAJcENjd9c70vtmv/utkYStl9SObxxV
         LMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390082; x=1788994882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SPSwC6FIuR2igZB1JOk61BDdzgs1mNnqoV9+SaxkZ8=;
        b=Dz59gsoNentT6TrqkXzTGbyuzsmpJHof/K7VaWqtvMAPRiCO6OuGnIO2+j/mGOM8vZ
         ObFDFVpfiHbRidMPhuKGPMPTpjDYCPIud0xU+oqk07DtgECCg7Fvvkpef62I9PN/3nB+
         dmxFo/ExSd95C9RK7l7M03ct3ame1Ue3RdB6Jlwg1s8tnj/9Cy4bxuc2jfaGLy9zlUgK
         5OTIN+EYpqsk9Nkg7tv3HJU1Rn4ZP3znUH6VlWC0zIaKKAC9T7eCWsIJSBfVxINc4R82
         xQvpPN0/WJiO9IpXzae4N15QsxqtohtPm+V5MI24WrG2CGycvfmeWz2WdMpAJ5IBGZ9d
         WI/w==
X-Forwarded-Encrypted: i=1; AKwUvByucVOkUExJ0b83cT7iEioCOp5Bw2slAsOPuRqBPRff2OTxbZD38dVJR8dnRoaz6m+7UoM=@vger.kernel.org
X-Gm-Message-State: AFuF++m3BpUDHM8lYqQzxw7ztBLlYVc0eGBvj0j5+JZFtiRIX0SYp7fo
	TyrXx8EzdFeXL+5b6jsXyFVUZsJ99aIC8A1eK+xGd9VnRkRLNGa7qI0v
X-Gm-Gg: AYBFou0XsYpvzL3B33+EIGyRxrXqiaLIDRb+czd8bb50L2k+2nVGgtE6yrMzImsvUJz
	u09abwbc1PRBLpcCT8U8Ac5zN2hUFIMmbm1JgJIVaPyqe6fHZp8jKShCFlCr1JFqI2aTiM102f6
	QZRK/CT7tF436kEe3QOJ/cPDDuw6J8eQ9NkYkGso1RfIof8voueIO3h3BsH3zZg18HLcy8I+w9b
	YGeDR5MyeFmraAOBy+WFFZXTPz4aXndoD36NLhOtvwM4xpAnOMnpJWKbpClSFmsxm/NbZk+Z34p
	QWctwpQK3qyiJ+VbbVUUMzTLqhQ4Qb9xjKt2eQFOMJPgXvtfBy2HptwFJrgXvQJ4frjD2Ef4m1D
	S7XXVrSmPXIKRm30lWpxDfIN5Y0XkI3tmUJTo5XSJL6WHREY83tYYls73WdKXsHQzmlIPfwja9Z
	pXx1RZtD2Lk9iJ9Lud3JXnrjHjHpPEwrpOF8rcNfKEKCI0YaeEkQ7FcV8l
X-Received: by 2002:a05:6870:1426:b0:46a:dfdc:c77a with SMTP id 586e51a60fabf-46f86ce6964mr7916129fac.10.1788390081873;
        Wed, 02 Sep 2026 16:01:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f336c72fdsm4762834fac.17.2026.09.02.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:01:19 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 02 Sep 2026 16:00:50 -0700
Subject: [PATCH net-next 4/6] selftests/vsock: add a helper to assign the
 g2h device to a netns
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-vsock-guest-ns-v1-4-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
In-Reply-To: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

No shell tool can issue IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, so anything
that wants to move the guest's vsock device from a script needs a small
program to do it.

It exits with the ioctl's errno so a caller can differentiate the
reasons for failure.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/.gitignore           |  1 +
 tools/testing/selftests/vsock/Makefile             |  3 +-
 .../selftests/vsock/vsock_assign_g2h_netns.c       | 45 ++++++++++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
index 9c5bf379480f..ffca0d9c34b1 100644
--- a/tools/testing/selftests/vsock/.gitignore
+++ b/tools/testing/selftests/vsock/.gitignore
@@ -1,2 +1,3 @@
 vmtest.log
+vsock_assign_g2h_netns
 vsock_test
diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
index c407c0afd938..d7170a15150f 100644
--- a/tools/testing/selftests/vsock/Makefile
+++ b/tools/testing/selftests/vsock/Makefile
@@ -11,7 +11,6 @@ $(OUTPUT)/vsock_test: $(VSOCK_TEST_DIR)/vsock_test
 $(VSOCK_TEST_DIR)/vsock_test: $(VSOCK_TEST_SRCS)
 	$(MAKE) -C $(VSOCK_TEST_DIR) vsock_test
 TEST_PROGS += vmtest.sh
-TEST_GEN_FILES := vsock_test
+TEST_GEN_FILES := vsock_test vsock_assign_g2h_netns
 
 include ../lib.mk
-
diff --git a/tools/testing/selftests/vsock/vsock_assign_g2h_netns.c b/tools/testing/selftests/vsock/vsock_assign_g2h_netns.c
new file mode 100644
index 000000000000..6f15629af607
--- /dev/null
+++ b/tools/testing/selftests/vsock/vsock_assign_g2h_netns.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Assign the guest->host vsock transport, i.e. the guest's virtio-vsock
+ * device, to the network namespace of the invoking process.
+ *
+ * Exits with the ioctl's errno, so that callers can tell why it was refused.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <linux/vm_sockets.h>
+
+#ifndef IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
+#define IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS	_IO(7, 0xba)
+#endif
+
+int main(void)
+{
+	int fd, ret;
+
+	fd = open("/dev/vsock", O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "open /dev/vsock: %s\n", strerror(errno));
+		return -1;
+	}
+
+	ret = ioctl(fd, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS);
+	if (ret < 0) {
+		ret = errno;
+		fprintf(stderr,
+			"IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS: %s (errno %d)\n",
+			strerror(errno), errno);
+	}
+
+	close(fd);
+
+	return ret;
+}

-- 
2.53.0-Meta

