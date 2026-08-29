Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7328305677
	for <kvm@vger.kernel.org>; Sat, 29 Aug 2026 05:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787982626; cv=none; b=LA+Edv811EKKEJnZ0CC/kpZtQHyBLNU4p3+g3vbkGTZKsJ8o97UuGZ8P6pXZPotTvYgMC6Bmm1u1o4zGmcluHKDLMeVttEzIgy6SXE510M3x2XTBc6mntGXKbz9Wtai1bJkeOWRnJpVR0hW/so3vRuhammxrnNNhbI43GjAkKfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787982626; c=relaxed/simple;
	bh=Z+A8Tz7FckQ9L2HOE2LwzbrR7eujbvyPlVNZTZIai2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IiXV+r4coRTdOZ0zO9dTGVAG8IDQylybNYGjjRiPTlsm2BszdPrKvxC/yk1AKkkMbotnsxl1lZTNk3xjbsZb1Sd9C2drr5fNYhISdjalfwd76dZIhaePHnY4BwctGIKDzd9HbjQAbZVI+Fwn69fKzbzHunRxwUAMSBzX6KEYh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GicLlpl+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GicLlpl+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495590dde14so15687375e9.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 22:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787982621; x=1788587421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ukS+6O6VUnt+grJqSVzkQJWIYuNE2DdB1/VCqDk7Wk0=;
        b=GicLlpl+0dShPSzzFHsX+0hw752r/IAaqQdMRk81ppy7F8ryPOJQX7oGojnRirEM7N
         wdIqOY20pTEr7hFLb55QfMpUk9bEk2ikoJNmf7EgX05jbjuR+gnn1d6kRZ+RDubCkqZN
         IopSkTmu5DShb7DlLpC+dG1v1vSj7IZpmVSmvm4V+0SF7N4aF8cuF5cyCPCg32qxYJu6
         wVTz4lzHpGgeY70OZMYO3sLTuz1SBn2+YcSVZE3kqwDWd+rduClgiY6Z4JCci/Bw1NS6
         A+UUKUP0BvoxkUPt5W0tpBo0VkDowT6Ph75zczE/cm3BK9i5N+b4zkkqADVhYVbDkVPB
         LzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787982621; x=1788587421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ukS+6O6VUnt+grJqSVzkQJWIYuNE2DdB1/VCqDk7Wk0=;
        b=Sd1drV4pGWRAzbLBaaRC0hInVmGTT32itqlQVm8nYywl5DACZtH0oLMwlEF/duspZi
         HGE+p+lWteBmcn11PK/BlXeLa1F2M0iSc+CyLaRQrzqD2IRJckkt3YQGF9UMSr2prd0F
         D2atRoj1ePO0ujuFMf/lOFSTYKg39Bs7v2ccCRpEIsb2QNBT1g+yW0LkHl7NWC80jeMx
         Keq5TJi/bKE3tnbmZNv3gaissEQjfDlqWxDDAITKj6BEbUnBBZ8hWXQuVrDg1IPtajXK
         /OXNSOv19rW6trn6MqcBXafVAyH5DBUu9knMgbmTUjAdswiL9O2WW6GbtEFDVlBQYVMm
         E5sg==
X-Forwarded-Encrypted: i=1; AHgh+RrWZmWCkCOgHgxw13aRy0bqLblpcpTEHjvjU5uzcaybgVvJrWz/wMO37DBDJ9sRwQ+ZR5w=@vger.kernel.org
X-Gm-Message-State: AFuF++nkMQiVvJaUOdE/ZJ9BVoN6bER72Kjvnnu6KRpBL17cffe3kGnq
	yyk1q4ugkQxOwJKZ+qEvf2wRPQmpug1EQTblmUxxBRaj2yoey6hcENjQ
X-Gm-Gg: AR+sD11SBIrbZh8OfYEOYwz6zUhMOB+jJ3EWHskSxyPeEz7JKrherAK0rNOjcOpQ9wk
	rB8Jt0G2d48pwBVQBuuGzE5hqGUM7DC+NJWbagihDGVIZOdPJ6sUBoLqh+K27oGv2eegrVaY+N7
	Qoedkf2AtIcbjEwFeKfhX2XWxathy7ZEUqHSJKLLaF6p3a9ixS6Y12Z116H/5SC7J/k8o8XoRGt
	nBZuK+QURw0+riJKNIWyKoSJvwCy0eArqpMROAx2VOLHjSVJJPPDLzWPMJcgZLb4EexOgTLhkUY
	ge+AxDq4faKYdt111/Wk5HJD48XqD0LUOX31BYOvmf8XHK8yY6NBtw85u+SFG+5LeyfjLEp8MJ0
	K7EQbJyr8SFyju6FMxKbSi8r7cZkFrGz4Nu6TPPlqD5j4ezC/C+Ni6mTI9oms0t37Am/q/5x6su
	zXBYTwR/4ucKfZ9z7YXL29+VVro8EibnpG9GYmoNJ0+QNylsHi99NFa2EJUEImHmMGAsrXnrvkf
	yl4fjYi8T3bYbXjPYEKF8bo7tBWT42oXmC+aypv2BFH9kHrFqqGFdQp4iUexoGLS7F7in/LlTqr
	DwpBVVmHurNlpZK411WF
X-Received: by 2002:a05:600c:4715:b0:499:cd34:f7c with SMTP id 5b1f17b1804b1-49b91c26a01mr172319715e9.5.1787982621199;
        Fri, 28 Aug 2026 22:50:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-015-136.77.7.pool.telefonica.de. [77.7.15.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cca3e642dsm35357485e9.2.2026.08.28.22.50.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 22:50:20 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] KVM: arm64: Return -EINVAL for an empty SMCCC filter range at base 0
Date: Sat, 29 Aug 2026 07:48:54 +0200
Message-Id: <20260829054856.70549-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM_ARM_VM_SMCCC_FILTER rejects an empty range (nr_functions == 0) with
-EINVAL for every base except 0. kvm_smccc_set_filter() only rejects a
range if its inclusive end, base + nr_functions - 1, is below base; for
base 0 that end wraps to U32_MAX, and KVM then tries to insert
[0, U32_MAX], which overlaps the reserved Arm Architecture Calls
ranges, so the attribute returns -EEXIST instead of -EINVAL.

The request is rejected either way; only the errno is wrong, so this is
a minor UAPI validation fix.

Patch 1 rejects a zero function count explicitly. Patch 2 adds the base
0 case to test_invalid_nr_functions(), which only covered a nonzero base
and therefore never caught this.

Tested on an arm64 KVM host in VHE mode running under QEMU TCG: a small
userspace reproducer gets EEXIST before patch 1 and EINVAL after it, and
the smccc_filter selftest including the new assertion passes with patch 1
applied and fails at the new assertion with EEXIST without it.

Karl Mehltretter (2):
  KVM: arm64: Return -EINVAL for an empty SMCCC filter range at base 0
  KVM: arm64: selftests: Test empty SMCCC filter range at base 0

 arch/arm64/kvm/hypercalls.c                      | 3 ++-
 tools/testing/selftests/kvm/arm64/smccc_filter.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)


base-commit: 548e7bcd0c5460ddcbca9600cea603ebeebf4da7
-- 
2.39.5 (Apple Git-154)

