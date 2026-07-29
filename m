Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D33D5228;
	Wed, 29 Jul 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354247; cv=none; b=W1uZCExkxxOsJulQhl6hCGS0RBVuIhrK/1gFG7tIGU5cHedbVixDbUwl72daIGv4qv0Y1/KmgAzWUHcb5I2JVnRl6dL7uvOEMeWIDbzl7EQZxKok/snKeXDq4VcSvBYMsrhqmj5OV1pXWWtPdIVsKm74cmtuQJZ3FJk1RU5e2mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354247; c=relaxed/simple;
	bh=dWEdx2vtF+kR8c3/Y7QXeQKcBYYo4wB2YJK9sr/AYLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDcSLIgYJTAKtWIy8dWsPCOmxHDX1vMbmlsHXzhN5lMjKQG4XzSuNYJVBpYrksnq78O4FC5lYS1HHfSC4u6W4NU2ExMad3El9KdNYWN1jaTuPhz5AM3BLeAQndwIg6IbRPaKctVB6yvC/9gjSJUls+b11sQJPJkw2lS8cJNBeS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2l5I8cj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2l5I8cj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354241; x=1816890241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dWEdx2vtF+kR8c3/Y7QXeQKcBYYo4wB2YJK9sr/AYLs=;
  b=S2l5I8cjRrKY/epQDxJzzJ/xk5v99yNq9nZfa7NwMCMXCi/rJk2aeeP8
   KCK7j1/yedkZa241q1HEIbc9hNqGMUv40tYxbFIailZeT84s3CdrOAD72
   k8i5YBq21TIInWGdBEbYD4946kTPK9SplrUNYXm+blY/k0QypW7qDMBQn
   nOv3Sx3b9ADDhWkWJ0HTkBnsq7YoLa66pSMQbA/To8e6B13ptdHVMxwbq
   OSNM5Eq3vaUhvi+cuCj0HXf+7xRn6Bnm5O851rBuq4PPIkD5iUWjOzVSA
   3SnxSobF+0EDX214f7Pr69L8vA2+9MQTTsVpw6RVh1e8RjuTHkUqAxEDP
   w==;
X-CSE-ConnectionGUID: 31Nn6ADwQU6I0e0r9dxYEg==
X-CSE-MsgGUID: +OTnYvWOR4WRXYD2KQVvjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508307"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508307"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:32 -0700
X-CSE-ConnectionGUID: nMq8HTrpSaOWW/pbrPxm5Q==
X-CSE-MsgGUID: ZMNXyCGUTWCkZ0YOKFbdIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769271"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:31 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 16/20] KVM: x86: Add APX to supported XCR0
Date: Wed, 29 Jul 2026 19:16:52 +0000
Message-ID: <20260729191656.598771-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729191656.598771-1-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set kvm_caps.supported_xcr0[APX] when the host has enabled the APX state
along with CONFIG_KVM_APX=y.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V4 -> V5: Separate out from userspace exposure (Sean)
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 266d7a02855b..48f8a2d69987 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7082,6 +7082,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
 		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
+		if (IS_ENABLED(CONFIG_KVM_APX))
+			kvm_caps.supported_xcr0 |= kvm_host.xcr0 & XFEATURE_MASK_APX;
 	}
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
-- 
2.53.0

