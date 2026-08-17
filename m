Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6AD3B42EB
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954088; cv=none; b=kk+dFdGAsFqE0rzX4yWw5d6j9auZIEl/mg9IStT7PKws75bqSHakKC+ozww0P2EiE3xNWbop2wCWRXAL52XBPzrNPiUnJ57F/8shOLgvwSfh+mIlAp0UEbXX/SqLYcLMXH6JMmV0P8YYIx4MgpPD8gRE0ByOIPiCsmk/nODvwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954088; c=relaxed/simple;
	bh=J9oJgrAIUCZn9JbeqjQpmyapZg23D3IIgDBuYE4EdQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beRvkHw1KdpbfjnLsWpy0rsFeoxn/atDEMU3bnM3dsnKjyHlWYtpqCsxTdUMKFh6+cw7BZMBt+PCTMOHeojjQr0lcTYfw8GsdiS8hQ0gfC3YgQpX3fVAlBaZns86dTrefWUeK7C3gGB5erAYSyRWXd1/MRCQhSv0DXkasBkeWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sP2Xo+1j; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sP2Xo+1j"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so2332648b3a.3
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786954085; x=1787558885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/dRMPyHnGOaQMCEefUKS16OLUTw2HWkBp1hAitPH6SY=;
        b=sP2Xo+1jLc2PBESnKDuuwAjx8cHTpdlKY9XtWinU0OYZcHIutM5DA3tk5KnAKfutPK
         eMywZv+k3yQnOn+osPVWalflw5Y2qTf4x56suEc5NbMGnkCcdHpLU+hv5YpkEChqmnKz
         0S2nH0czyyIA1bdxp5kcDFpYanRlbUzxXS/fIbux6GKNPoMUsRauLkmeLeVG2+u9KH8B
         txoQoFatxicoiYQXA+L/D+cwH1/DN6SnLdOlY5YTJeR/xhcm+4yBF+TIdSyTh9T4FXDD
         H7BcnnJoh0iQC5bKomapCAiVtx6nzxHlsKAOC3HSltPduXEcpXcbLms3MuBAdGC+MwfE
         J4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954085; x=1787558885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dRMPyHnGOaQMCEefUKS16OLUTw2HWkBp1hAitPH6SY=;
        b=A6Hzckxg8SWyWytE0XiaCd16yDk9ItuHKPJQr/hkXna+1cjmwRV6I/lqtsLKh90x2B
         Kd9IvWSi8NvjqJ6fRGgVy5fvwySrhkuAphauq3ICYaFWx2TU8ZriHxwHJj1bNY9gJHaM
         pc6z5AT3WOXMfItxqv/AmC8BLFk+BUxBbrncTiQBMkzZXRBnKpGOU1EqUfL5rNlYBrIi
         6d2wLlGAmiSWAoOSo6RTHG/m6SqBvodJuICsusEpFo0FVq+A436rIJhSPVO9lhN3nc+T
         MlYJtPNS8cwPo4eHS+ysYGlea0+PreW8GVZB9z7461UbbIh0u0xZonXKWWVGZvsf6NLA
         el6g==
X-Forwarded-Encrypted: i=1; AHgh+RrKTRYDx9BeALi/deFgBFsd4bOW+/Emw7lcQ91LL+mlEW4EoPic0Jube0HpRvwC5++C0sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20R1x79MCG2DBS3nEvYFgWAFyUXIq9MlgnltPmtLkk81ztNA4
	AX9nBN9zx40UC+YQho0+QFHNg9dlUiXdF+aC2LJafYL3HJ4Fixl8YelmA2gX0lxjMB0=
X-Gm-Gg: AR+sD13QI4DNKI3Z3wCa+vyjnWlt0jsF7hKo1+LCoaP2uMrxHKJ87XECOa1AGyamw1U
	9Zv16FrWjCe1+OeXQpMQxRI8pq1Ixi38ULhbJe04rXilscfR7DD2Vf9HOfuQj9EIoq9Loz0Xe6J
	bcPMbadRRL0x8TEYCg8Z0dCm3d+LywQ1CJUVy4OKYm4I4NJ0uwV4n2z3QlfxebAo2GlVBEswEUj
	dTLOFw074mFYDCerd/FGRtEmaoeT97g3nshk+pSHzePfafQ/+Klf20iuEvr0ZlZGTdcu3m2p4ed
	oNMFz23RAYJGp5C9DKzuZnxvS1uacHawZhJJE8TwP3zkrfgDg7aAwdvH2Jjc38REm+T6I0chf/H
	3TvzoeCRAd3I9UABtaNfLXJw2YdRvS3Roalyq1si0fXNnmx3KoY1Sobb6DEvjpUxwhXfq4kyP55
	yeBKqyL9i60sPv97yPCVTJJo5WO5o38bHw5s8y+m75Xteo/keOtWu4Mhmtl8utpZmcAUNzBU7uC
	EFpTQ==
X-Received: by 2002:a05:6a00:3cca:b0:848:2c5e:305e with SMTP id d2e1a72fcca58-84fddfbf1a9mr23134966b3a.6.1786954085292;
        Mon, 17 Aug 2026 01:08:05 -0700 (PDT)
Received: from LIKEXU-MC4 ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223fcasm2442328b3a.34.2026.08.17.01.08.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 01:08:04 -0700 (PDT)
From: Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: kvmarm@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: arm64: Skip sea_to_user without 1GB hugepages
Date: Mon, 17 Aug 2026 16:07:59 +0800
Message-ID: <20260817080759.25601-1-likexu@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sea_to_user backs guest memory with 1GB hugepages but never checks any
are reserved, aborting instead of skipping when the host has none:

  kvm_syscalls.h:68: mem != MAP_FAILED, errno=12 (ENOMEM)
  not ok 1 selftests: kvm: sea_to_user # exit=254

Check for enough free hugepages up front so the test skips cleanly.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 tools/testing/selftests/kvm/arm64/sea_to_user.c |  6 ++++++
 tools/testing/selftests/kvm/include/test_util.h |  1 +
 tools/testing/selftests/kvm/lib/test_util.c     | 15 +++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c b/tools/testing/selftests/kvm/arm64/sea_to_user.c
index e96d8982c28b8..fc4f81702d0b6 100644
--- a/tools/testing/selftests/kvm/arm64/sea_to_user.c
+++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
@@ -260,6 +260,12 @@ static struct kvm_vm *vm_create_with_sea_handler(struct kvm_vcpu **vcpu)
 	alignment = max(backing_page_size, guest_page_size);
 	num_guest_pages = VM_MEM_SIZE / guest_page_size;
 
+	/*
+	 * The region is backed by 1GB hugepages; skip gracefully rather than
+	 * failing with mmap() -ENOMEM if the host has none reserved.
+	 */
+	TEST_REQUIRE(get_free_hugepages(backing_page_size) >= VM_MEM_SIZE);
+
 	vm = __vm_create_with_one_vcpu(vcpu, num_guest_pages, guest_code);
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(*vcpu);
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a56271c237ae9..0624922c2735d 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -168,6 +168,7 @@ struct vm_mem_backing_src_alias {
 bool thp_configured(void);
 size_t get_trans_hugepagesz(void);
 size_t get_def_hugetlb_pagesz(void);
+size_t get_free_hugepages(size_t page_size);
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(u32 i);
 size_t get_backing_src_pagesz(u32 i);
 bool is_backing_src_hugetlb(u32 i);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index bab1bd2b775b6..29f9c1d60b1b7 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -222,6 +222,21 @@ size_t get_def_hugetlb_pagesz(void)
 	TEST_FAIL("Error in reading /proc/meminfo");
 }
 
+size_t get_free_hugepages(size_t page_size)
+{
+	char path[128];
+	size_t free;
+
+	snprintf(path, sizeof(path),
+		 "/sys/kernel/mm/hugepages/hugepages-%zukB/free_hugepages",
+		 page_size >> 10);
+	if (!test_sysfs_path(path))
+		return 0;
+
+	free = get_sysfs_val(path);
+	return free * page_size;
+}
+
 #define ANON_FLAGS	(MAP_PRIVATE | MAP_ANONYMOUS)
 #define ANON_HUGE_FLAGS	(ANON_FLAGS | MAP_HUGETLB)
 
-- 
2.43.7

