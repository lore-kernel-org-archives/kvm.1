Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94D3C0607
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861096; cv=none; b=cGpDHk9HSNhpjsdQ1GfaOXg1DncKF3V+6sm+6YKx7PZGXFcko42mNsjIoGqjfO6Z3D+bgkd+5SPOcHjcaLP7RGZv15MDosgSBXBdSIybvt1bQ+5nQ/NLMM6no8NbNg0LlndnTu1npZhmLHqhJICwZqLvsZSsJb/kLMxBYZmX3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861096; c=relaxed/simple;
	bh=hGVAQIOSZVX+OOxyi3w8w+qe9kLA9gh1RSXqVgqXZ5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+5vkCxRZ6fmhbEbPtGmVOH1VedoAwrazJWstbqTvx2lzd8ER8BdfAo7yZ8l+VZkjb2fQj3ffyglusAU7b0seSXjJb2qkyM+9hU9orIlVsCse158g9baQ3uk7Fff9JxuXn3pJqbVML3n/kb/kySqvRn4k6cXga3Ucnoy0VyqLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irnabj42; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irnabj42"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-83945063f70so592618b3a.0
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861094; x=1779465894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWSTcJ0lUIenOrMKgCBsi4dMZXBhfxtLdXUWtU/7JTQ=;
        b=irnabj42CBvDID/L/gPzZTgciPwcTWIx7P8ttBvZ15A/z8mCjq1hAkeGPE54d7E8mm
         3BWSg+esELXlw+ilIYOD+vXqM/62cxjt9cyo+Y+AdFOHgpGQj3kMvt49i93uZnCjXdfH
         mNx6YppHT2ElZqjdXZzWNcr7Av3hdcVThU8kDyHBgy6W4TaxtWvYrqKkXDj//rnud3p6
         GTQhlQzTdxEkSzUkcbn959QbjD5uAR9UuQGLH2xGBPqIU9oBmdYndXB7ZT+u/SbPPEDj
         4KcVRI7/Iz3hEe6j9RWT4dRFuXisVpf3LQ0bJhXELOns62XTdv58D8/U0RtV4RjI5fcy
         J3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861094; x=1779465894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CWSTcJ0lUIenOrMKgCBsi4dMZXBhfxtLdXUWtU/7JTQ=;
        b=O/6ITVhg0zHwbf04SoTGiSatzrv1gVe14FtVnyKKJra8UuKDjYuqY8mArqik8SFcyc
         Nelm0wAsBxR16qTj3eH3mKmIcP3jWUaBqGPF/QzvkVwknEDNYA9zdYEPODeLlpIeQV70
         9+nCJ9UcoBkBPWEGsBbzRn3qiS+wWrERMU7709z+jZHDq04O8C1J6d18Mc9KN+4Wmfgc
         Vhn/ssX8mfw8ibAs9qfFN0JUmxXKeMKXwZEtfn7SfG+jaDYDMjyeyihr9zfYIjY3YzoA
         dxr32V1a5EuLioU/dzDVJEsjsn11jdxIhjV6S4h717uCmSXuPG+c3YwqWzmZv+NKCFJL
         jqNg==
X-Gm-Message-State: AOJu0YzKO1s+cSKMborNUU2WfDActx7rM/vug3sEZ5tlR34+TiBgIF/z
	ir6xZ61voVcnUGxXPTHgr9QA41EltPn058yYl+7BFT8Ht5TIjyxfXkk3CND9lwVV
X-Gm-Gg: Acq92OFlEbdA761Lt4vSxmzw+BuFZXv2BJIr6JU1QOjLV4IEitT3GwywGgXjqSayAs4
	bJbi/IhTbSj6O7DjaiJf3DxGFHg/gAJagJzBM5Y5ZFa8wvkoXjJdY1MtmGD+Gp3qNHsFEQCfymi
	WlPzmHHrm4e7M2ALrg/OqShwBGk0GkMmdRj7+/KJcSo0k9d57u213RWRR+Jo+KG3lDo+qhZFtxX
	qmikzyv7dIpmtqObvCu8fmWwW8TPDVAP6zGD4BufxFh1bQmabKKFDGHAQ3pojEflfxylqRfucIg
	js02+lggvp2Pd1DvIeRHT8aPImeNw6Wvg5q8YlhJTu822biC98YHYdr6MLbFtQXmQVGPVdqVgZ/
	qlwovRLsGHkmJaBQ2FITtPagCvAqQ+UvDjIrubECsyOtS8l0KCf2Nm35HzS39DyVP/+8QF3+Xnb
	puR84BkQ/4fOdgOpYeUf6nRtseutgUpN/TO+vqWvEtG7vpLwmPZmiL
X-Received: by 2002:a05:6a00:39a0:b0:829:8083:472b with SMTP id d2e1a72fcca58-83f33ada10cmr4070840b3a.4.1778861094440;
        Fri, 15 May 2026 09:04:54 -0700 (PDT)
Received: from localhost.localdomain ([171.76.86.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm7920262b3a.49.2026.05.15.09.04.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 09:04:53 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 4/4] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
Date: Fri, 15 May 2026 21:34:23 +0530
Message-ID: <0050c451633ae8e22ac80368587aca70e96457d0.1778857539.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1778857539.git.ritesh.list@gmail.com>
References: <cover.1778857539.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicholas Piggin <npiggin@gmail.com>

powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
VM's limit.

The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
to the kvm_create_max_vcpus test case to limit vCPU IDs to
KVM_CAP_MAX_VCPUS on powerpc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to laest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index c5310736ed06..a82c13d6cdf5 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -56,6 +56,15 @@ int main(int argc, char *argv[])
 		    "KVM_MAX_VCPU_IDS (%d) must be at least as large as KVM_MAX_VCPUS (%d).",
 		    kvm_max_vcpu_id, kvm_max_vcpus);
 
+#ifdef __powerpc64__
+	/*
+	 * powerpc has a particular format for the vcpu ID that depends on
+	 * the guest SMT mode, and the max ID cap is too large for non-SMT
+	 * modes, where the maximum ID is the same as the maximum vCPUs.
+	 */
+	kvm_max_vcpu_id = kvm_max_vcpus;
+#endif
+
 	test_vcpu_creation(0, kvm_max_vcpus);
 
 	if (kvm_max_vcpu_id > kvm_max_vcpus)
-- 
2.39.5

