Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066BA3D1CDB
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886252; cv=none; b=Yf7sBqtwYPDnvYJnHPhyvDUAUJfCjpZpTXIM+OVLBVzJZ5S6RzInmCRIvlwmwXCq8M/guw/8gywCSp2rS1Kpn4gIwH2tfy/MvB0DFoJUOAZ/iQoByX77SNyDtXFGlwfR3gtYIL/1n2P0Ol/LnVqADntM0sH395S83Pda7wcqEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886252; c=relaxed/simple;
	bh=E4xmxJt1GeEWmipyPkRcfS5k8eAh7SdmfFX/EoP92dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OthAvcOmKsEIMIM3dO5CR6o4OhQuIrbDks9oXjmIwjbr6TS0YF4cjG0dO2OD7tuPT6NIo7czSibaDoJgSYBDt9QodhBHLLV7t/MmoxloQ/JdLztjCwSjFWwCh2qZEHedYVImX331M7OmkaSJOyPJj/UnU3oJd0Ttmpyp/sBDKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qK+yqqSM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK+yqqSM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bd2c147abaso70630085ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886250; x=1780491050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMs/uXhPHvjv8tK0rG5PcV9J3YapP9N2N0Ynmb7Sr+A=;
        b=qK+yqqSMKEMKpBe9hbdT1HIuSsK3Cu6QN9tQQS37K6l/7u9IuyMESDXzM6dRS9VPDH
         Fc3xbcQeg/sIUA3aJlAlmztMU1u5soNxtF8+6T9nTaCha0Ogg9PPpVk+86hxpeMF7nOI
         ZdPa20gfdqC/gmgxUm9uXPzmlum718HLvYkcrf/2FPdFvpLhupxO6buuEYLEzQ+TxRye
         D4DVQKL+FZvNKAw5PwpvVWqXYZLdtNuAi5h9J6HQ9OJROIGJappxap36kwe+bZBIiSeQ
         kQ5PIx2IMGDJMyOjcBW8Qfc/GhwkANGGwNmWX7utqAIQxzSCqFD4A3RiFs9kaw/xK7eb
         869g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886250; x=1780491050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YMs/uXhPHvjv8tK0rG5PcV9J3YapP9N2N0Ynmb7Sr+A=;
        b=OD4Ma0BwbCnqyTlbCO207FDNBK//fY2K9h2xbftKhTMV5ezfMKLGks/gGH5Od64LVs
         +ZU/qgU0+bsngthYSt1AY96KOH2OZFfd7Rsoqju2NQXnP/12SrOgat9kHwoVnfUU2pXD
         7jhErio0+vsussWxD4AuBM8+hEB81R2AMvErNzSnAbmfYEPOy4AajzpJIyfgBFGWNMX7
         WPUDDPGz45R/cnsMzU2nXq/MRNMJsEWqbKFD0AnuJ2UxV89bOeqArUN5geJouaP+D3oU
         1ayeW8G3K2M/Ok1JTCQfQTyUVQGZSqn1IDCG/5L1hVOmLIVCFBqndyZVJ/EP4vh6V2oM
         PgjA==
X-Gm-Message-State: AOJu0Yx0HZNbR7+63xW+pOFF6a0Ti6XQHRh6XbXk+AG7rWfMBk1PNDaw
	XE0NxwgXG4eMkR7HwCsK1EoGaVLEJL3Sw7g1BTHIIbBbVwGRGBcC2BWsFF1cag==
X-Gm-Gg: Acq92OHg0Ld4ZcF2e+7ayyu8rfZdnrWeHvNpgOBFArKfn9qzdRn278qMzreFJiU/mhQ
	lRTI2zTocMbwjya9W/IiJ0BECYvnNUDxYOvzSsxcp76w5UXHf23XR8TKcRGD2vXTud0EPnXC5Dw
	ra+k1/WNOs6Mk6CEJJCGSwGAfiC0zSZObJGsL0xS3gpwlO1hpX5jo+yhJLyZY3lX4ATSoWJdPYO
	SFuN7ITH503MfgXqKs1aIDlAS3zKhUqblIUyK2ZNtwLcDnWgYnVwPInF6w5+69jRoufdBuTKT+5
	nMngJVIPevR8WZz8efd3S6wQ18l8gzF44gtTTw0FIl09n1nbZeiielVl/BR5JG4UX3rq8qACEFS
	bItClfixIMr7Nh3e+MPdiVNytwBkfFAqe1/ThPSZY83A3gmDmgw1MMYpsV+j0607uoKpApwm6ad
	1F+6HfbegtzbYh+owMMqyYAjtXtFX27QjotWfwT4Y=
X-Received: by 2002:a17:903:1b68:b0:2bd:9da9:a29b with SMTP id d9443c01a7336-2beb031a83fmr252499005ad.5.1779886250352;
        Wed, 27 May 2026 05:50:50 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:49 -0700 (PDT)
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
Subject: [RFC v3 08/10] KVM: PPC: selftests: Use u32 instead of uint32_t
Date: Wed, 27 May 2026 18:19:57 +0530
Message-ID: <a7ad48d63d55a08e9d5bd3f63e5a5d2d14445932.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 0c3a8774692aa ("KVM: selftests: Use u32 instead of uint32_t")
made this change from uint32_t -> u32 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.

It uses the same method described in above commit.
  git ls-files tools/testing/selftests/kvm | xargs sed -i 's/uint32_t/u32/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/powerpc/processor.h | 4 ++--
 tools/testing/selftests/kvm/lib/powerpc/processor.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index cbbe390ae244..95ec3debc83c 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -22,8 +22,8 @@ struct ex_regs {
 	u64	lr;
 	u64	ctr;
 	u64	xer;
-	uint32_t	cr;
-	uint32_t	trap;
+	u32	cr;
+	u32	trap;
 	u64	vaddr; /* vaddr of this struct */
 };
 
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index ac5c3421ec81..0a65fc3a8d9a 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -312,7 +312,7 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 	vcpu_regs_set(vcpu, &regs);
 }
 
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 {
 	const size_t stack_size = SZ_64K;
 	gva_t stack_vaddr, ex_regs_vaddr;
-- 
2.39.5

