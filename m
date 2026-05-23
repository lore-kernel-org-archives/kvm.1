Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764A3890E4
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534919; cv=none; b=CRPlTvq8cMpmmBj1ZGYP9bNtiKdk7kljx3ldidzlJgq6A1rGzaeUtGbreMoI6Ml4AWg/hCmBhqOIyklzRboU6Y+r1KRTBCKeC2fNvuMCYPyODMh4tsCnXYAYPphMcod534GYJCSJcVETgE39z0o5O2AcBMmAIgDOYggeaYnGMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534919; c=relaxed/simple;
	bh=a7mQhiqXWN/25mXiIq3tddj8NgbgZO493+WAfl016O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv89Q4jC0FWIDXlFkKBq/e2rbE2Jrj/tR++SG0X2YbJRTbZELu2D/iWBXqFVN1DuoNu87Sx+MMtFJFKZRG8eJ81qwLOcfp7LCGbZff5LIYpGROvSculex1c3TOOIxkg15BCq9yoTMBQVF7nCdk+R8ou1J6yMVKmwKUwAuEHQTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omvgpJAK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omvgpJAK"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8413ac3d82fso3067605b3a.0
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 04:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534918; x=1780139718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTfV5I/6+8PKgpUetxyiP6m2rwpoR69hVt3JVVxbU6o=;
        b=omvgpJAKIN7TtEVwLwgmRV+/BpLhcsM7iinpuapGMZNJE2s1zdQp0q/kFFihepbBQm
         M+ytKvtVXx7XpHqM8eyJDm+7fML5mjwPgm9/L85A0c6LHEn6hGDxzInYF31QG1pRX/Y9
         jYsURFL51qFbu9pL8EU2XIfmTLSP7rsFAEIy5g+CNyFL8Xqr1MT+YhoJBlQTHrG/1zL8
         7KxW+DCK+YvtZAiKRLm6+Xydmz4t3QtpoHu5JpotEU6JwZCtbP2ybZ970TMH9mKrNo+h
         tTTBybdJ+DmymZY7DtWwIW3UM59XgCoe+YTUjQyG8NM6B2NLKgdUyiT0yq1316X580LL
         IB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534918; x=1780139718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTfV5I/6+8PKgpUetxyiP6m2rwpoR69hVt3JVVxbU6o=;
        b=p1A8ARCiGc16pJRFI1PH9Fp7G74RY/e/YUrYmcjorByNe8yi4cy/1jeH8t9AGEVN66
         rRUh/+FkvM3sjxnQiQTHRMDXJWgDg/k52fBu7XlYzvo3OJbetiFKWo97aEElXKzy1XO0
         DKYTbWgidofw0dmryWiuI0psFbNnFWnrZUVgO6ot6PGoq4DWbRVTaotwE5mKOzkarjL2
         fSGoSBmi48s7G/S03nTfLD77P2wveosU9D2marIlbbejP+OXVxTyTZP5dt4fawoKckyX
         cEg+B2SFvTWEBjv+q1yzVA/YFIHu4Jq9cam/wPy0cCDClNzyA0Bkg1E+oPqLH41wgNt/
         Iw6g==
X-Gm-Message-State: AOJu0YzSZs+CLULku8Fktxmrm0BsB3OSwAfh8J/3zdSAW3D0hgfZTV4i
	j1cR37GuhbR14qprO9gwDbOpNl8EnHw4bkF6bI4sXcdIpWpYImRfGbCuMszEDg==
X-Gm-Gg: Acq92OGWuPqtWCrfIVjExRp/xUIj1AFGmP2YWPwevTXSsOLZoRMLuQ934SulkpPiMoq
	rp1dAz7EkCthiCrZCJyj4P9m03F4sJn3ir4ZoWpw4poZuYyi8y525INtCwKSVHcZ4a5rIq/k/yn
	TAeI1RnRUNEkW9QMZqBVddAXHkeMRi8V1nykjD9X/jCWY574zuzTxk9uEP/z0LszxybBiLx9Ias
	yop6LkAH+OGX4wVBPReDI/AUTkf4fKf3fIsiCqav4hT87JmS9u/LfSuQubKqqj9uKYmMSrAaAGW
	PMVBGmRfYTsJj66s6HyaKZAt+ZC0joxMAuGbWB93OTfuM0ISaaTatk0xqU0PwHq43+Z6hoOPlYV
	7lntvTzPoWWCsUHMIsjbElLVwRT7sJZ7H14zaW2nMq23rE0JQ5YJXQIg+Gwzj0Azh8L6l+A/Ij+
	VT+l3+T8DjgRR7vVE86AQrU88A+49uQFM5AGznkXM=
X-Received: by 2002:a05:6a00:3d08:b0:83e:f75d:828d with SMTP id d2e1a72fcca58-8415f15a770mr7487815b3a.16.1779534917676;
        Sat, 23 May 2026 04:15:17 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.15.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:15:17 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 5/5] KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
Date: Sat, 23 May 2026 16:44:24 +0530
Message-ID: <12184d5eda089814659d5a861b3ebc30d42733a3.1779524962.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779524962.git.ritesh.list@gmail.com>
References: <cover.1779524962.git.ritesh.list@gmail.com>
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
 tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 0dc67c1502cf..6a0ee6803623 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1354,6 +1354,9 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	vcpu->vm = vm;
 	vcpu->id = vcpu_id;
 	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
+	if (vcpu->fd < 0)
+		pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
+			vcpu_id, errno);
 	TEST_ASSERT_VM_VCPU_IOCTL(vcpu->fd >= 0, KVM_CREATE_VCPU, vcpu->fd, vm);

 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
--
2.39.5

