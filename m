Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96343F58FE
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886233; cv=none; b=r1lQc9ySszRSEF2l1AesEm05GLFWKeLd5d6WmbbY5VdczoyrZSFNARQuddZf+sxAomjW2JyruszkQh9mXeIV63F7UlgQX/8gLV+M6G8h+5RZOAAaip3Rh7XxmD5n46JCnMGPOXy8vTAp+TeugvQxLOX3ap0VgsTrUbJUmDEfgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886233; c=relaxed/simple;
	bh=KLO6h2CiB1/rteH5f840+2wKPqI5HPLzKE9w5TFO6+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+85Nrvu9ZGn87tjeOcjKvqMjCfe5YnzphTOHtJGBN4b88IGi+SG0jazbVZMEzy2WFtTvbbjrI3pnxX6+0ndwXHxhc49hmHHi0+ytDs1r6TRlDf46z+4/QaKGXFCOL7QZZtvZ69RNE+FkXYAlptbiQQmfGdyDygtxBKCMPf0Vqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUTkYAVk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUTkYAVk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba856db1c0so85491085ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886232; x=1780491032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHUxe7lnPztFxDQVjPCLiqbcKDb3U3X7b1X5k1GLWTA=;
        b=JUTkYAVkcfNHC0TMgEPNLdHTQhB6447RGkvG+vRcQjZ8Z3lYikJ6dTIPV/A2PIPB8m
         3Ku/6CKPKVsd9CHJtLdAlXCjb27+m35VdUMYl67QFFOKl6dsxI3WA3cdchk9CdYTd6pR
         J4VVmYBgMkdQLWx2J5IANQYKDjV+oqrEsWMEDh5BxZyaAQ82MCcHZ1sBQFPLtlYwdGVf
         7JaSe1mELY7h8zTdpCRB56pBDsEtl/brBd+Mnji5uVGcWLhTx08J+66sGjbWeFM+iC+a
         6jEDClx9V6iTrSZgoyEM6M6b8cwVpQhA3H5KU/urUGAiYdhJZyMrpzEnRiV4/32Mtt7z
         ztKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886232; x=1780491032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHUxe7lnPztFxDQVjPCLiqbcKDb3U3X7b1X5k1GLWTA=;
        b=DzoDIAtm91PLCOy1ElsakBtjZjhV+AsJjVvbfdJ/TaS4ejfZoSsoigsBpF0m0wLty4
         Wrs2BhsuiZQvRMHusyvZI1EQAoqj6Qug5AGlFd+Ha1+psubmBl25+3M03Hgqkv7xopBh
         SLJIPRxDvGmn6pATIUAo5Qs+RGcPtye3nlqRxMqj6gbfE6B+GYax1MZstR8u1z/iMEgS
         Tfg36vGk/0OO/1rwCZy0Z8fmq9rknnZpy1/OujKoE3a4JDBJ3A/97LHYxq2CsE08RjXY
         BWMwV4jWZdnnGPu3hvgPT+u2TXNu6PnHTDqR+Fnr6FF/HW5czjJ510DIaI13JGyfngT+
         5YXg==
X-Gm-Message-State: AOJu0Yzm6TtThfkjG5/i7uzxnxMuAaH/8xJ+b8LoNeraRXvpdQDplIsa
	dbWX5JA5syz/15Lz0jmwakWS2Y9PJTpcsD6fiPuEVV1lLDT6FPJIXqL5xpKMyg==
X-Gm-Gg: Acq92OFUWKwxI4m8Pls3urmDKV+kw0kAaeQ0ZW/tH/wdhWhw6UnpvUVLI5zyIhxxFCB
	2ngH5uRWKpfWlqKM3BIiPXjzQFl0QL6tjmYbRGn6E+I/D9nKjyhOCUuDUJvWzaOkUfWZqJHMb2D
	rF//dbUHernKNunSwvFlW5kAf+LORQ10SZ+Gsi75P39+Q7mswiSkq0CYA6NS3tM08ErnpHoL28y
	dM1Y21d8kX3CRE+33Ok7+ZcE3JQbXKfWcVQVS8zsKgvd6B767wVAIw2htHEKsq+z3voN0BUFYBv
	ZX3Gg49lpbenyMaNukRL8LEAUksQtosrUg8G5HqXBzY4A7WfoM5Ktec9/T4UBzAe9TGPi17AQ7o
	dWKpMOaj+5qESJ5Q7M4Q9Y8F4dyMd012ui/OwTL+ScxbcF2McFlg2lALcw6HqVI9ixolT6zZZbQ
	juK/MpPu+0YvRtd8DI3N62I+YUL+3FyVVMdcbjrlfkB2+B8/u8Ew==
X-Received: by 2002:a17:902:f70e:b0:2bc:8ebd:af76 with SMTP id d9443c01a7336-2beb03466afmr244325935ad.0.1779886231867;
        Wed, 27 May 2026 05:50:31 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:31 -0700 (PDT)
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
Subject: [RFC v3 04/10] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
Date: Wed, 27 May 2026 18:19:53 +0530
Message-ID: <5233755b872c4b97ca5a8aa06f06ee9fc73b4c40.1779885589.git.ritesh.list@gmail.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
VM's limit.

The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
to the kvm_create_max_vcpus test case to limit vCPU IDs to
KVM_CAP_MAX_VCPUS on powerpc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
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

