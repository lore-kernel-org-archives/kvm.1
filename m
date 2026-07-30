Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CDD449B31
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435882; cv=none; b=GxDsDbh1im74LDJ/gpTBiV4gQm/zSjBPnbtdVf0ZE4vAk7f9M9FpAw1eRb3lFiBlW2LnlnXeelVDeDlLzpT2DxTfyFIMfEq1m8TvbyeKGBYTp1dgk5ehWsRLrbNch736dCcCJgvvImz2edrIGd3W/bISFxzsejx30mg/jIGwIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435882; c=relaxed/simple;
	bh=O14zjjovGhUS1oisSmIPImyZNtw8PEWRZRj6BhjFqXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5T9if0DsZo3I3HDThEDhV0czL38p8zBUsYTwV6glN3K2OPYs7JRulQ/OA79mKsXlqlgBRVmLUyWbQExOhysOzwgEVHvV5o9S+V/L05vEVznWnxfBzoZEO7jfiHxe+ovT0/NtBJfutxgP1aMSwIabgBWcMAZ8YipnfCaGQ4xJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mokaldYi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mokaldYi"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so651265e9.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785435875; x=1786040675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=flDxck68r8K2V0lreAAuQvFuepl9jlGM1LdPTHPMSDc=;
        b=mokaldYi7J7Pf10stqOrObcnJXzIGGGMd6j8NPwU6LrLjpFybAPW7BxrhTlDAKxtbo
         GyfLb9bUjmhr0dSsYqWV+ddiISgko7ojqKYRAi/Stm7Yir6Fv3LTcmk9yqJFev4c1dIt
         YW2LAaPXQqnoW4md+2+kdg4lVLvvYvzhgG62Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435875; x=1786040675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=flDxck68r8K2V0lreAAuQvFuepl9jlGM1LdPTHPMSDc=;
        b=CybTGhz+JaHFOU7AXeln4m/4cpYoGmSQXTLImImN1rb+mKOsZLMgNukbszf6o/jKfN
         IazM0Dt4mOahm3IJ6j8H/MZKytqxZzIiVRAnOFJYiQ5q/9DoVTWoWfhdpCifm1MxSr9U
         IhEqyPNBuXAtCsrFiGgqNp2Iiu0fCrEIT6mu3Uh/SQFE637OcgAsZraWLx041JFkRKx4
         BYUT724bGLYCCgcorRZanIecJVSBjDtAzVHwIkt/UvrDy04XzZ/Bhhx1k4vtsGGv6kE2
         CbfrfzRz9oCKDXpangwOoh28ECFlS8o4TqQP3wWukSmMtA4ICJ/mYPNyBGvq4NZ/SF96
         0ugA==
X-Forwarded-Encrypted: i=1; AHgh+RqeYw5yzFKoL+Y13GQ3pJAv4gwpDMQNhMnE3CDrdrLL44bzddhJTrlXb/sBsBxn9Xkcu+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPnNKl82T13b34tH/Z6IPRLChRjz7hG8veR2J2KmXRfotKWbOx
	7B0arCg/GBeD5y/jekoaT6euBvoQ0b3I6HetYJCQbgHTCYVNZJaiL0hA5CwTHAY3VA==
X-Gm-Gg: AR+sD109KYc0OvcIM4aHgfE94SBr6CFoiDoqDLjTWd5jsRlTc2Ilwl28LC1bqAOxxWd
	iPWcK3kbkOiIdyv6HNWnJG+y5XiSANVPUYHDkzyIy4zFkgy9l6epXJbQglV/iC1BtYcHeGjZJKD
	fQrNHoPoW7HVpi4qdtRy5wn3HegP36npbqmVtLyNZmz//r889Z8DJ886WLRDiymlRaseq2hcE9d
	PfOSiTi9WSSOE9kEGh02xzquluXYqzyZYQQNRLHc0Jst+ZdybM1Hv4U/3yv9A2hbIYWvYhGN8eI
	S0gOULtNlQIWi83Z2ga2IN+skIstCljYLcR+Miedj7gsBNOll9F+DaL5qBZOrp8W7O+86TVi0S5
	zpZGCocwv+nx1P5xyMq1nNfzGJ5ZrgnXjrQZPtDeoK+gPpdMKARvtRoaLKk55453gGPwJFzWnva
	+Dp39k4hw3fdnMSzTtQNUKuAiMi4BoAdEefZ7UHIvDU++HG+fKPz0O0ggLEsEWj3rLwB243KDAk
	qvBgzgpFcMva7m+NGAKhtJP0ydS4McMQprthcxRoOcTNG6+ywwVvHM=
X-Received: by 2002:a05:600c:4e89:b0:498:28b:1025 with SMTP id 5b1f17b1804b1-498028b10f7mr47675555e9.5.1785435874942;
        Thu, 30 Jul 2026 11:24:34 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498010aade3sm84008685e9.14.2026.07.30.11.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:24:34 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@grsecurity.net>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH 3/3] Documentation: KVM: Clarify that KVM_CAP_MAX_VCPU_ID is exclusive
Date: Thu, 30 Jul 2026 18:24:25 +0000
Message-ID: <20260730182425.1223530-4-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260730182425.1223530-1-dmaluka@chromium.org>
References: <20260730182425.1223530-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM_CAP_MAX_VCPU_ID capability value is exclusive, i.e. valid APIC
ID values are only values below this value, not including it. Its
documentation doesn't make that clear, and even suggests otherwise.
Fix it and explicitly state that it is exclusive.

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 Documentation/virt/kvm/api.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e3003a241d5b..dab9a28c0fb5 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8593,21 +8593,24 @@ KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT        By default, KVM for nested SVM guests
 
 :Architectures: x86
 :Target: VM
-:Parameters: args[0] - maximum APIC ID value set for current VM
+:Parameters: args[0] - maximum APIC ID value (plus one) set for current VM
 :Returns: 0 on success, -EINVAL if args[0] is beyond KVM_MAX_VCPU_IDS
           supported in KVM or if it has been set.
 
-This capability allows userspace to specify maximum possible APIC ID
+This capability allows userspace to specify a limit on APIC ID values
 assigned for current VM session prior to the creation of vCPUs, saving
 memory for data structures indexed by the APIC ID.  Userspace is able
 to calculate the limit to APIC ID values from designated
 CPU topology.
 
-The value can be changed only until KVM_ENABLE_CAP is set to a nonzero
+The limit is not inclusive, i.e. the maximum possible APIC ID value is
+args[0] - 1.
+
+The capability value can only be changed until it is set to a nonzero
 value or until a vCPU is created.  Upon creation of the first vCPU,
 if the value was set to zero or KVM_ENABLE_CAP was not invoked, KVM
-uses the return value of KVM_CHECK_EXTENSION(KVM_CAP_MAX_VCPU_ID) as
-the maximum APIC ID.
+uses the return value of KVM_CHECK_EXTENSION(KVM_CAP_MAX_VCPU_ID) - 1
+as the maximum APIC ID.
 
 7.33 KVM_CAP_X86_NOTIFY_VMEXIT
 ------------------------------
-- 
2.55.0.508.g3f0d502094-goog

