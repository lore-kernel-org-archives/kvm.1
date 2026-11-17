Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948340;
	b=O8FyopP6ee/GPHdea8S3lXDFzh51QjtZrORuQ6bQdihT/dK4gOhxuUPFB6EUUasLmCjt
	 7Dt27Dzyeu3u/+URI4I35fRytasAE3Dbcgm0IUvxa8y3DI6wr3cwLul9SoEyHJQPEHRGL
	 p3zEfr1njdNDBrgcQVT0T/ViTjd0SGnlQoXGrU2sj/aSYa47jCDxkrbazKZDcaazXa2c1
	 gEzgT2haqVHC6+th6ix03Cf+WPL8kwCg9kAAkIN6LUHl4z93lX3l2S3ZR28JaJAIDGs/w
	 kjx1isamRfi7xVNvT+QdvGX6LnQnT5mMVCrEiwLN2xDM3fW08rWUGML8MkIkJ+EhrYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=H5HOKL2EhRK71scz5F39xMdCNEmAUE6COZwQwhC/mXs=;
	b=KHU7OKtcefpZtqRf9ibwJqgMwaF/NvH2yNt71ui7fh2KzRks19UWMTVdleItry82kdvI
	 LJBiQjVrhAGtVt0jLvdADCGxihAJWNM4iP+UpaO54q2uLg83Q4afwHPF1VMxjiNYHhq+w
	 r9AaaifxTZiyEXb8kVLg10ipkZ/YJrjjpDgRT11Ac1HWCgsdv9JqCtIqEKlOaz05Q+yXi
	 ZyzWPdljh5pXjmGNSvyuxWPYixcM880CrCuW+FkXoiC2GFKY6tFltAj7Wp6xXTahzrUeH
	 4ihp+XNnCe5XFQ2kROxZWFnT0zx4QdqHpsiRqScoYJ9FMRqs8otWJgb11VABKSAB1xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TIwGkQTM;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF5606A888
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 20:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2CF5606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TIwGkQTM
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4cc89e86e4dso175587b6e.2
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794948339; x=1795553139; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H5HOKL2EhRK71scz5F39xMdCNEmAUE6COZwQwhC/mXs=;
        b=TIwGkQTMtlYihyV/DkdX8kDo2dmzT7E52E/RZ1arFd0jsVKlRoCDkgw2Jm86Wm7kDP
         E3QrLEKpR+T1MRb8kknGNEisvOEjQSzG6pO6McK7D5R+265b/8+zNMvK/PNdYXmmmxjq
         uK/1X7Odj7XOhoFrqfoVlJ6WA0aw/K5wGjmRUCUbUD5K2qUH4NHY0kEs4jIpk/eMPiU9
         S9JpY6/ihBHu+E4bRSAYLahEtPnuDGk8eEv4m2cOlMRPtyJUmjFrWAczHEJaQ9axkNYZ
         KdsFXsp7lyPJeG4sWhE7BFUqFz/06UPnwCzqFI2nlF1uXhtEq6isHxy9eXWu0Z8KnS7b
         Gbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794948339; x=1795553139;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5HOKL2EhRK71scz5F39xMdCNEmAUE6COZwQwhC/mXs=;
        b=y7RBmKxd5Yh6cIfI2gETYV0yIfuz9IRkXeHUgfvlDOwaIlRuGJ83jE1dJiaMo5oVTZ
         UIsvn+BiVpnf7o9hlAW0LuHvML2sFMYrtgsJx5mAmqaIU5OWRYFwv9Z0tAY/6GnyLBsL
         aTEWRUfOuKEhMNsaqtHN8MdqhJhwg2TNDY6exO+p1hGTlS5f/PZe3AZZfGmcuIwlwxM0
         dVJR3LOZXWUUOza9C/irzzAtnJbQg2bpeFa/H+TckQOqSq8aM/5cd41YrXt4KMZZO8sb
         K9Hc+UgsyqUZa3PyO+aUw4PM8TjFDMvqevcd6wdIivYlOpZmzeP3oq4rJCe1VYRTk6bw
         Fs6w==
X-Forwarded-Encrypted: i=1; AL+hErH+TNjyzG/FLO///r1kwpm5hk8GDD+/D8qXgd3eOqBNq7+DogcASE6EVB757hpQDqLzc+A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8P6Oh6wxF9Zr4XrdJQQlqM8+vf2oMNsHcBqwnl2RnD91iNDAEw
	Q7VSsqpu/HHfsWLNNC+zM8budHUMXAz0U760+5cWkA0KXpgDT+veeaeieB74VEEO7Ng3P0PGRpT
	ut+u3QIz99PeiYXjiLmtJKctm7A==
X-Received: from iobmp24-n1.prod.google.com ([2002:a05:6602:a2d8:10b0:9c7:7f8f:934f])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3096:b0:4e5:a74e:d6c0 with SMTP id 5614622812f47-57743d4c1e9mr1010823b6e.64.1794948338500;
 Tue, 17 Nov 2026 12:45:38 -0800 (PST)
Date: Tue, 17 Nov 2026 20:45:35 +0000
In-Reply-To: <20261117204535.4036191-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117204535.4036191-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261117204535.4036191-3-coltonlewis@google.com>
Subject: [PATCH v2 2/2] KVM: arm64: selftests: Verify HCR_EL2.NV1 is RES0 when
 E2H0 is NI_NV1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Leonardo Bras <leo.bras@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

In a VHE-only EL2 guest (KVM_ARM_VCPU_HAS_EL2 without
KVM_ARM_VCPU_HAS_EL2_E2H0), KVM advertises ID_AA64MMFR4_EL1.E2H0 as
NI_NV1, making HCR_EL2.E2H RES1 and HCR_EL2.NV1 RES0.

Extend hello_el2 to attempt clearing HCR_EL2.E2H and setting HCR_EL2.NV1
from userspace via KVM_SET_ONE_REG, verifying that HCR_EL2.E2H remains
RES1 and HCR_EL2.NV1 is masked to RES0.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/testing/selftests/kvm/arm64/hello_el2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/hello_el2.c b/tools/testing/selftests/kvm/arm64/hello_el2.c
index bbe6862c6ab16..5910497f8fbe4 100644
--- a/tools/testing/selftests/kvm/arm64/hello_el2.c
+++ b/tools/testing/selftests/kvm/arm64/hello_el2.c
@@ -45,6 +45,7 @@ int main(void)
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
+	u64 hcr;
 
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_ARM_EL2));
 
@@ -66,6 +67,13 @@ int main(void)
 		TEST_FAIL("Unhandled ucall: %ld\n", uc.cmd);
 	}
 
+	hcr = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2));
+	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2),
+		     (hcr & ~HCR_EL2_E2H) | HCR_EL2_NV1);
+	hcr = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2));
+	TEST_ASSERT(hcr & HCR_EL2_E2H, "HCR_EL2.E2H should be RES1");
+	TEST_ASSERT(!(hcr & HCR_EL2_NV1), "HCR_EL2.NV1 should be RES0");
+
 	kvm_vm_free(vm);
 	return 0;
 }
-- 
2.56.1.750.gf70dc682cf-goog

