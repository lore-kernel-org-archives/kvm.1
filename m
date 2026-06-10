Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D893F8717
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095690; cv=none; b=JfDv9uZzMXpBDWvX5+ie9lnvx54MLe5X2qbbKeQR5Bfarf2RUC0iWjPg6T5QuM22kv0ChocmMZN/MK1hKTejsLCoQCOoTlDeUzr1uO3yjKs+NX7ivj8SxfYB9wBL0CqYuMW8v2xnOQz5zlaDPb+ltuFVb26F7UpgVtzYJ6533Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095690; c=relaxed/simple;
	bh=2LroV12QDHXlJWFdk5Jo33toYJgSdnDGipf5x6qtCco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHmx5Qnmslycy5e3Jn0nD9yvMGP0BcLZ/zWWq/Rl5mcJoIBZiqoVGp7ariZXTHMdwDSpvkQyGghCoOBsc64PNbdirswwzu34Yzh10iQekVnpdoFdckOP41hrv59TBqH93+a0KaJl33a5litSITHtYQBm84T0wovBVdHVdTAza7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtUHPGAb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtUHPGAb"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b9033d230so3587180a91.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095688; x=1781700488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrxTcenItW2gu16uj0ViHf2ekVBrXj9Zuq6BUQC9S+E=;
        b=UtUHPGAbWkkMw4Yml4p3Hlxna0oD8URX5rZdMxxcyJjMtu21cmRwngQbZCopP9V43A
         MVB0jrGfKDF2DqlgIIa14OHJvftIuwwDCdAt58uyaMhl5LZZcbpI20d8yHUVe7m8GInE
         RtTT1u+F2LdC67NXmkoj+s0abgDbMIqIXPN85ZBoblIqiY1nB03/3vSFU9adEcMmt8zU
         9BMTsum6NdKU4FzBbSTIIDKeEwEqXRCRs8ZDDsZXMXLbkIAaHH1TDKHYyDdA5PNy5xMi
         hVBJ1okOtCUnqbcF7E6IgtRzdQ6YHZBfe7CtIuER4PUOYe2rvtHMY1QWHzLrF8yBtPcM
         pWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095688; x=1781700488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrxTcenItW2gu16uj0ViHf2ekVBrXj9Zuq6BUQC9S+E=;
        b=lcIzXTV3CLMdDnOYUiF1cLVWOJoAtHveoE2RpmDsj0/0Ww6vKQCFA4Z5q0SsOPlk46
         R8BV4xJ+oOZulJtr5qZpK83ftw8P3Lx512g6TPamZnZXHqpuQWQZN4SbALi1RRXbkyV4
         OzmHI2wtLnp3cpBtafb/xdjH/mVyBFuQpXyUJlxj8fjouhTEb+XCvtDRF2d7fWyYdqaU
         r4qXJFAXt2BxFD/j7ldXeETpH2xwevXalJ2eNGkvkOMRulf8CUKXZ+XOjCv4p/MIgN/X
         R8O3X8tjwJiw4A/cir1znxbeAZvPvlbJTPqyKSKv2xT7XYMX+zmCdxiGm3lHOj7A7Lak
         hp0Q==
X-Gm-Message-State: AOJu0YzVij00/apD2a0ZAoNkYcjkC2QQHqOIaZxQMHpev+9Tk/0Js1W+
	5ygCMEQuh2Xs2PQYLxKT7OEkEll06mu6kiaHgFWgKbAZSMSZF+GD9MV1I66+fw==
X-Gm-Gg: Acq92OFhN9v6cB+nTDCDkSpbZkf5J2xu0hoAzxKyv17bCbFKtgphgVK0pGtBWecSLfb
	m9zPG3U02x0Zziuugqa9W5RsrospRgnlVb57Bn/W5blked6WwDOcPpqccYwImTKlSorAL7NLGlX
	nDoXk28oktXeEyJSPnFSYfHon/nLm+wxj3c3oBennS86TI3Ps6tl635vVNmnmCnfdfwqhzuTjKl
	Vev1PnMH0kSuhAbvIKX4RBI/SX/9gYYmJk+x16WNCi2RlECSF33L5vjAFuRHm+hFMCXsgJVrnvq
	LZKzW27v1lapJLGAKGG3G0ibyjp5m0MN4WdxVIgsfETiAaWr0qyiguZHetalzGs1mxtE4lo9MIS
	BTEs1SSpsTAzianlVgVR8pvo4QtRADao4W7qOvFAnLbuoWz6UF/n8EHG9aopyI8PppnOsRk3epQ
	Nz38NpPnd3Uk1vfyM2JP2JOKyYKOwt3B61MKYuaW02EYGZ+58KL4PFflxY3/Sk3A==
X-Received: by 2002:a17:90b:560d:b0:36d:630a:c4e4 with SMTP id 98e67ed59e1d1-3712ffaa11fmr18804464a91.3.1781095687672;
        Wed, 10 Jun 2026 05:48:07 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:06 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 05/10] KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
Date: Wed, 10 Jun 2026 18:17:21 +0530
Message-ID: <2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print the vcpu_id and errno when the KVM_CREATE_VCPU ioctl fails, for
debug purposes.
This helped in debugging an issue with KVM on PowerVM, where KVM_CREATE_VCPU
only supports max 2048 vcpus, because the PAPR_HCALL H_GUEST_CREATE_VCPU
("Documentation/arch/powerpc/kvm-nested.rst") supports only up to 0-2047
vcpu_id. However KVM_CAP_MAX_VCPUS capability extension always reports max_vcpus
as NR_CPUS of the host.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e00a25f59416..6319e2037882 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1354,6 +1354,13 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	vcpu->vm = vm;
 	vcpu->id = vcpu_id;
 	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
+	if (vcpu->fd < 0) {
+		int saved_errno = errno;
+
+		pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
+			vcpu_id, saved_errno);
+		errno = saved_errno;
+	}
 	TEST_ASSERT_VM_VCPU_IOCTL(vcpu->fd >= 0, KVM_CREATE_VCPU, vcpu->fd, vm);
 
 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
-- 
2.50.1 (Apple Git-155)

