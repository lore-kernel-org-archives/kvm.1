Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002FB42C4F6
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344796; cv=none; b=u9LXILffuwqpplIKE87qbgfqD8clRRnuMuXFpd8ivbjJQ+tISbVyS2cIeylALgVLfnAXuGD9CMPKt6AaAelHGZn1Z8kmSYWZJYuKlK/Gy7mk6u7hK4HCWTSvzV0kWilrdQFzU0nSlCdkP87rlge2+U6CqsOK+3bKaVX3QypMjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344796; c=relaxed/simple;
	bh=qy1ZrS34HWYINmCJTbWiTbYunsqnbS5NGry799vrNGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpO5K87N8paz24CO11rSEANsh5u4NZZnKSw0prcV80a0spECCVrOU0QuJPKioY4caY/VtBSueMW1h8aUUUagK2ZUWBRrohk/wt+nuU/dQRU4P4cvUw6JOnZSoHbTJ7qwZcm43fk0Xd3tB/9QAW6UolCjt767RsqykjwiSVN/XkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dwXMbekd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dwXMbekd"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1671ec8692so156734966b.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785344793; x=1785949593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TulM3ZhdLtGxFX94kWWm5LHhn5poNeK8dkvPkUfs8Zo=;
        b=dwXMbekdRxCxyvFO8D3xiQ+bWElTD0o7Qny378MzL9rpQPAajD0fagRQ40k9btwq/f
         5sVVVkpHol6Mak20kWBgrv8iC0UqFO1Zyt0/HEbgXUt49WHaZ2VbUFavSuIbgpWPAkGD
         Mj/g1ggIYlOFX7UJb8fWos56u+QGKgAWKr7Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344793; x=1785949593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TulM3ZhdLtGxFX94kWWm5LHhn5poNeK8dkvPkUfs8Zo=;
        b=BapFpPByxveCwk1xEmNtdFYkb2vETQGVzkp3DVyQd3yzVpY8CARV+hszCR7NP5S2ld
         xvzsLF0kJxpMIX+pcvUbQm/TjUc5kQNsTnaCv8QuopGsofRSS4keJA4IzUTWNiJ3tv6i
         EvBiNIeO69a4gmHZCMeGkPkt9KyBFQmdu/fl+b+rYhZoyg8lqPNMpsRWrMtNP+URaLPO
         LfVdm6XB9h6wogppHjBBFlKt8dXi4iu8qMtBkKeEJMSu0ggQdfcbAXcA+7tpmTz4fris
         6If3iO7VAqiZ9DlET8C5+5dWb5oG1anyZA/kvdf+107R1w8b5+m1wuvIPPHTAbpc8rZi
         Jg/g==
X-Forwarded-Encrypted: i=1; AHgh+Robo6w27UzxJJTu99N+N1BcJxCmmTGOH7G8HutwVQflKMWtCDKUvL2AjcG0uPLqJL7E7HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzhMPRGxaFHwY1BEBgMg9aEcNVo8LB/8MG+Ph/XovJY1N7LhJS
	qfS9C51LPwKkMtPc8YOSbaFhgDEYEKTIpJyzc6a95ZtYYlnZuGesXv0TYLOm7drW2w==
X-Gm-Gg: AR+sD13oAtIcaQVFQxYYJ0Jnsgue98SHXPah2yS0O6oy6ht+OQhSHIQ2beqfFVUPE0l
	b6Pev/ZtsP65+R4Exl20RrxJyJ4Dbys+DAml8srhg3HcGyUSqcBQwESd2TA/JltAwg9VynsaMzR
	ug3Thb8TcRt9MozSbzxVMOkN5ZrI5renpqXQvMO1Sc0u54g8Us4EtkD5JuDedLG1Taa6B1Bs1sH
	mo/ACWyNY9aaNKY/jMZXfOsnIJlLkdWs2nKav7IHsAifLpdTa16VknvcL4GMtyqL6uoFYRgQnYo
	2TBJXJMBovkIVcde09pVjO1TaAu7W9dyX+Oa0DBmdc5F/OhpOyjcla5aJYcRQLVLXpk57TbN11a
	dNhYbaszFoRuZ5ArrBxpC14P9z/cbmnBPebHTAic+kGDWmqe1dcjHKiNwubzz4QwrmXGU4NGEex
	jFstAp8Qe8ZT9w4ByW6p3JK9S3Xwti1PtAOPhD3cfPSiDSe8+6ML0ZgRNORzuDJbET5gVizFaBB
	QEpSZ0r3vI8QOmHjzxqSqeQG6yZ8kgzJe5vjBxr+S0HunxyQu+33o8=
X-Received: by 2002:a17:907:7a89:b0:c1f:6f31:37c3 with SMTP id a640c23a62f3a-c1f7218a993mr407297266b.54.1785344793273;
        Wed, 29 Jul 2026 10:06:33 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83c686a8sm142753566b.4.2026.07.29.10.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:06:32 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Naveen N Rao <naveen@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v2 2/2] KVM: VMX: Fix stale PID-pointer table entry left after vCPU free
Date: Wed, 29 Jul 2026 17:06:21 +0000
Message-ID: <20260729170621.308809-3-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260729170621.308809-1-dmaluka@chromium.org>
References: <20260729170621.308809-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vCPU creation in kvm_vm_ioctl_create_vcpu() may fail after
kvm_arch_vcpu_create() -> vmx_vcpu_create() already succeeded. In such
case kvm_vm_ioctl_create_vcpu() destroys the newly created vCPU in the
failure path. However, that leaves a side effect: the IPIv pid_table
entry remains configured with this vCPU's pi_desc address. As a result,
when another vCPU sends an IPI to the APIC ID of this failed-to-create
vCPU, it will cause HW to write to this (freed!) pi_desc memory. [*]

Fix this by clearing the pid_table entry when destroying the vCPU.

Note that the same issue exists for SVM AVIC as well [1], to be fixed.

[*] Although, since this memory is freed into the kvm_vcpu_cache kmem
    cache which is only used for allocating kvm_vcpus, _maybe_ this
    memory will only be reused for pi_desc of another vCPU, not for
    anything else. So _maybe_ this will only result in delivering the
    IPI to a wrong vCPU (possibly of another VM) in the worst case, not
    in a random corruption of kernel memory.

[1] https://lore.kernel.org/kvm/al4rNqpBYy8FGKPw@blrnaveerao1/

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 arch/x86/kvm/vmx/vmx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..f98c268b5150 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7665,6 +7665,9 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 	nested_vmx_free_vcpu(vcpu);
 	free_loaded_vmcs(vmx->loaded_vmcs);
 	free_page((unsigned long)vmx->ve_info);
+
+	if (vmx_can_use_ipiv(vcpu))
+		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id], 0);
 }
 
 int vmx_vcpu_create(struct kvm_vcpu *vcpu)
-- 
2.55.0.508.g3f0d502094-goog

