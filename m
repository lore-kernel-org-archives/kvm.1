Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09648A8AC
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053106; cv=none; b=ZTukvD2U1sGbYT06ITn0+aiDLv9LaPc3F27JnWu1TgfSVyOk9jq98C4NkOT99gXSUAd+m8EqajpubTvg6WXkdHvOCCCKS2Am377GQbDRMQn+8Nn0oPgCQpZ6saqsfM/Sk7giuZbw9WJXM7uNXzr2Ozrt3RlhMGMqpWRaRFIxLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053106; c=relaxed/simple;
	bh=+5OhdJLKSbRNoRiwvXpio5W1d+tZemFWqHA9zhT9EN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtQFbSxktSybZsECufkJt6whBVqbaljvCdhp1HvyNkII4tGM8T+XNjBYZXyEOP0c6AB+X23SIZ1hAIxStyESQ57UJHj+epLtmMLAwcJyiid8FIXxy0X4Hu8xdndxfc1Zgn5ol+c2DSKpflHR95G31x3AvoQaD8BRTDAARZ0FRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSShRQ/m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXPXI53l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSShRQ/m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXPXI53l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792053103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0fSuS85qjgfYBkcBtEXHUunAA4roYAXdy4Psad89UE=;
	b=MSShRQ/mS0gZF9h532aIYI7PQTsi9job5lfmcgEyl/FvDKCXSOvLw7pEj2Vk9gK/K4AoFg
	A+5I/seC8yaCEEzbumU+VPffaBaKBJWYTtZthGYDArtsdpetfSPTmr2FfBHy9nhnCGArWq
	215A/Dmdn4SAVF6rKYsFpZL0AbeUAIY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-zrHRJl8yNl-exC81pMRmPA-1; Thu, 15 Oct 2026 08:31:35 +0000
X-MC-Unique: zrHRJl8yNl-exC81pMRmPA-1
X-Mimecast-MFC-AGG-ID: zrHRJl8yNl-exC81pMRmPA_1792053094
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a16fefb7acso39293155e9.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792053094; x=1792657894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0fSuS85qjgfYBkcBtEXHUunAA4roYAXdy4Psad89UE=;
        b=MXPXI53l53KydYPIdNVRtFNFQW9G8lE6k18M7qoEjROur+1bui03f7Iez/lExQeJsM
         z3cGbyhObnSnSToqn6WZ1Ht+8h0uL0ctwIUnlca/Yyz/1gJFhNnA8+N5Yrzcdmo1WPu5
         qkDdbyPc+9jdNAjW8044lRYt30wRIdikRhf+EAO2akDMs9b5/68CgUwsfinr4PPl8q4X
         LeDHEREy6ddyneDTKVe0xxw7sh8DFdv58nKrYVF6F/ll2VDfJ93D468FCUpL6pkLZlX6
         uHMtbELuvm+SuLug892p/9O9U4y50+CfbzQATpbzHeM8V1M0neq7Sjls1yKOpqXRUPkz
         wZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792053094; x=1792657894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0fSuS85qjgfYBkcBtEXHUunAA4roYAXdy4Psad89UE=;
        b=DYoB3xkHSBMIbPJccn6tGD286uCZBuSBz/n17iBs69SBTkoSdI2arg4aqW/ymaab+K
         Ign+LrmOgJNqXJdamrn03V47UU2F7B4pbq99jS4B3OCitGKWoEfEOaaXB2Qv09wOyGDp
         jXpmMNXNM+pWc9PCvhGIGfr6ys+Fy1pg4diR9P/VE9y9jg5yiO6te+ht77yfrNa+WhgZ
         F6oa9KIrL2nLxIBmfZxJwWvl9aT5fpEuiHHSt7qTQfsPkIJn8h0qUbS1G4sQC9e8wXT2
         w++mWO42E6z39NOJpSu+hQFWkqqztklqBZ7oi7MlnoneFLq8gtuZfcbI2YnjSdf7ds+T
         wpuA==
X-Forwarded-Encrypted: i=1; AKwUvByCZFYf+O4ANetWJOll6XmYpXT2CoGBHi9+MhA1C7B7aowoTfrXw7Xz/ooLnorYtzSQZ5I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDl8xnpFWg2L6RDqZ8R6m6dBIJ4fVFX77+41Gi0tG7m3YgKuKd
	pISx6jV4d896vZivIRzyMN+CMoXMtoc1Etj2EVaCi6mnU/Cd6pw8ytsw+AAhwdnkAV8EX35Z1jc
	z2gfqz2ytHQf8PkWWUQSVt9PK1P912GwAHhVCheTLoLP0RHc31nG/xg==
X-Gm-Gg: AYBFou0KHmbrnXjgbOBLMeiVf8lZlddKg+1yln7GQIu8LBU8VCkoHtBYYgmTMm+vY49
	fBRX/ZFIgS1uay1Wzw2xvW18NytdeppuaaFwDyJqfUfeaSeA4dDY0I3bnK9Lzw3FTZGrzQ9EsYf
	EcsX10inN6bjx1ttE7RsdMshpZ2efagrsDXCjkEPdeVGU0j/DG7DwXwwobb0HZSR4R1WI5nYcnW
	6+v1Cmk4YZlhoFJMKpkw1bZKEG9wj//MTP6VEi9vB44a40DzKv3Dg+f2ym8VJBzbSrchDKAUfvU
	o133H3HmgC/j+fG03iw7k3e9rsSBlrX4bNi6CM46+yx8aR9uQ2mD1iEmqF1p0ttQBxW/c5HVRfG
	3CuqYkVmKWab1p0MRK6KZZmJgyRfEi3ymf5k/ZVsOCQU1cBvN48U9c5H0frX3ghRvFT8DUA1NaY
	e5qdJM
X-Received: by 2002:a05:600c:5391:b0:49e:7a10:1b71 with SMTP id 5b1f17b1804b1-4a18e4a003cmr365070745e9.11.1792053094356;
        Thu, 15 Oct 2026 01:31:34 -0700 (PDT)
X-Received: by 2002:a05:600c:5391:b0:49e:7a10:1b71 with SMTP id 5b1f17b1804b1-4a18e4a003cmr365070425e9.11.1792053093920;
        Thu, 15 Oct 2026 01:31:33 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd972affsm51496405e9.2.2026.10.15.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:31:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Amirmohammad Eftekhar <amirmohammadeftekhar@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 1/2] KVM: nVMX: Reset MMU back to the root MMU if loading L2 state fails for !VM-Entry
Date: Thu, 15 Oct 2026 10:31:22 +0200
Message-ID: <20261015083123.790030-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015083123.790030-1-pbonzini@redhat.com>
References: <20261015083123.790030-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amirmohammad Eftekhar <amirmohammadeftekhar@gmail.com>

Reset the vCPU's MMU pointer back to the root MMU if loading L2 state fails
in the "not from VM-Entry" case, i.e. when emulating RSM or handling
KVM_SET_NESTED_STATE.  Failure to unwind the MMU pointer results in KVM
trying to run L1 with a nested MMU, and is especially problematic if the
vCPU manages to free its nested state before the VM crashes.  Constructing
the root for a nested EPT MMU goes through vmcs12, which is dynamically
allocated/freed when nVMX is enabled/disabled.  And so if the nested state
is freed with the MMU still pointing at the nested MMU, KVM will hit a NULL
pointer deref when attempting to get L1=>L2 EPTP.

  BUG: kernel NULL pointer dereference, address: 0000000000000078
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 114a2d067 P4D 111743067 PUD 11141f067 PMD 0
  Oops: Oops: 0000 [#1] SMP
  CPU: 20 UID: 1000 PID: 1272 Comm: nested_tdp_faul Not tainted 7.3.0-rc4-8c89f11d1a99b-sink-vm #1914 PREEMPTLAZY
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:nested_ept_get_eptp+0xb/0x10 [kvm_intel]
  Call Trace:
   <TASK>
   kvm_mmu_load+0xcd/0x870 [kvm]
   kvm_arch_vcpu_ioctl_run+0x18f5/0x1f80 [kvm]
   kvm_vcpu_ioctl+0x2c7/0x970 [kvm]
   __x64_sys_ioctl+0x90/0xd0
   do_syscall_64+0x9c/0x4d0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x47491b
   </TASK>
  Modules linked in: kvm_intel kvm irqbypass
  CR2: 0000000000000078
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:nested_ept_get_eptp+0xb/0x10 [kvm_intel]

Cc: David Woodhouse <dwmw2@infradead.org>
Fixes: 72e9cbdb4338 ("KVM: nVMX: fix SMI injection in guest mode")
Fixes: 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
Cc: stable@vger.kernel.org
Signed-off-by: Amirmohammad Eftekhar <amirmohammadeftekhar@gmail.com>
[sean: write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20261001214356.3825100-2-seanjc@google.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b25216862740..5165275128fc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3770,8 +3770,10 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit:
 	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 
-	if (!from_vmentry)
+	if (!from_vmentry) {
+		nested_ept_uninit_mmu_context(vcpu);
 		return NVMX_VMENTRY_VMEXIT;
+	}
 
 	nested_put_vmcs12_pages(vcpu);
 
-- 
2.56.0

