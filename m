Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665332;
	b=o8ZK4eiXlOvcBJkLUZYauBsyZQ132zRWzGw4vWvWDEcZu8yUU2Txs+MgnDQY1ms/LLPy
	 bP+FzlVttPyLgjkPkT9SOYetCb9Wl9K8aeH4mLOXiTp2nvnhUiM5f98VLfMiZg2mz1qoF
	 I/6cI75ZXE9EoZ6T6KnQRnKtTfjW0JqgQRVbGtvmzK72wbJB8U2VyPFuQfpONUMkkxQvz
	 lLQAmXehG/hUv5+mKaYkOqN2ZbQT9AQWwUeePqg24uD0SA3z6gmJ/47SariawA9uXzZvp
	 tI8VwB4IeZ24o+yKWrPbc5WFd/b94/HAjte+2/igaSdaFi5BMLoQ0Z8XmbB4BUS1XCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Go21w0LdVBqY6FPfPI/Y6M16uSx3gBaNjR6JdWqO5xk=;
	b=qrJ4wqrDrpRZQAlMizMAxTZvyGz1MCr3dIx2af+llbTM4UGjTkkVkORsu+8RueNlIGt2
	 EmPEMpScFPRFStoDypB+tFSpKUddik1RyaHfcZKhhL/enrm2AICfvbBR9CGWULie8QKUn
	 47iKs7Jl+oA1fkMJFHGE6drz3NLD5kAbeZ9y7fMUU4u5i8TVXR5JKLqBUOnVCtWfVsxFH
	 nyyH1/kp5D9DY6o2AgaQMk/W1H8VXAtMzlsf2u79IHG/4427nj6VnG4Sba5yVFHru8PVe
	 CONSqv3kpqy/iXJoBqLnibZER/oFMKnLQ/OSioe9DGMlUs1lnMFI+8mbZSAHEVUpVUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jUoLQ2xJ;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A7606D832
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 754A7606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jUoLQ2xJ
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e93e2f72bfso59690665ad.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 16:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793665332; x=1794270132; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Go21w0LdVBqY6FPfPI/Y6M16uSx3gBaNjR6JdWqO5xk=;
        b=jUoLQ2xJ1uKcy+mkG/rXIDATkyV05kgRWar4BDUeTEnfrdhv06zzth71BahSfNyH8D
         7QqhIWhSKFQErkT4B2kRI180+02pD+YX32igh1MJmdlcnh2s9jBJaYd5YSEZ0GVgyxD7
         fE8epssf+fSNZS/Zropkq2FlUxhMkg5zA+NC4GTMUZjyRJKBX0lbeBD922vjniamU5Bq
         AhjUl+dyGEj3Lxy4Fq4MVbVcj1gb6RLzXT+0dVigVyFK2xHwSuoB70HVW/dntuopR7vy
         Kv19rJOMr7o3J3rgy1QmkhiXjGnwreNDi6xxdAO5DmGYJRd+zzmcDvYl88vXFm8LjGla
         WQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793665332; x=1794270132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Go21w0LdVBqY6FPfPI/Y6M16uSx3gBaNjR6JdWqO5xk=;
        b=w7vq/lp5jf2LEMWavTVUeVXG0NU9ecI8QjZnHZ4vs0Vk8DcYYZyLdb5wc6flA9DwiI
         TXGLM8mz7LgwVMnWc235Tvs2sJvJKpuyyNPQFOpc6Dmef5j8Bk1Q8aAc1KCs2XDCjxX6
         hAsAx3NhWDwSQtRx7FDOuk4F/mXggeUmd1Mc99Kldx1CZQY8A3cph6Nl1GEDDeHcXxiJ
         +O9aevyQUGPj4I1an6k5z+c8tvJnZzcuiEMg5igbWfXNh/UfBA2ua1AGObxc7v3QsHhA
         e+2bZs+4uRP3dvnhRPghX4f+egoPzhZvjuTSwqkIxtig5JdbDxuiLV/L1JvCNi7E8+7Q
         4czA==
X-Gm-Message-State: APuU4Z+vhhaxFtk7pWHQzBUDvNF8ih7EiiN6eFEfouq77Pgf3nOhtL6Q
	q6G6vRvWg5V0nFPaDo8qAN0NdrL8eG1ir1BkaoOyPSG+burMDMvec7bqJjvLuOr8vVAdvZIBrkP
	AFTDNJ2UV25bcqgdlDDb6qJDmwoNboFagtV0190upFe7kkxKU17dGfvGqoYzMg7Fy6X6gylXA02
	t066exKCv4dMwVcqft23q3GHWWWFURenGy+5mPMwVGrcU=
X-Received: from plek1.prod.google.com ([2002:a17:903:4501:b0:2e9:8ef0:cf73])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f549:b0:2e9:5eee:e071 with SMTP id d9443c01a7336-2eb3652ddf9mr104229635ad.57.1793665331267;
 Mon, 02 Nov 2026 16:22:11 -0800 (PST)
Date: Tue,  3 Nov 2026 00:22:04 +0000
In-Reply-To: <20261103002205.3348519-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103002205.3348519-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103002205.3348519-5-dmatlack@google.com>
Subject: [PATCH v2 4/5] KVM: selftests: Use VFIO selftests library to pick
 IOMMU mode in irq_test
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use the VFIO selftests library to pick the IOMMU mode in irq_test and drop
probe_iommu_type(). Pass NULL to iommu_init() when the user does not
specify a mode with -t, and skip the test if the requested mode (or, if
NULL, any mode) is not available.

The VFIO selftests library now automatically picks the IOMMU mode that is
most likely to work on the current system, so there is no need for each
test to probe for a mode itself.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/aiIG2L_KdPwuxYA1@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 791e576c334c..8a345472df5f 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -148,22 +148,6 @@ static void kvm_set_empty_gsi_routing(struct kvm_vm *vm)
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing);
 }
 
-static const char *probe_iommu_type(void)
-{
-	int io_fd;
-
-	io_fd = open("/dev/iommu", O_RDONLY);
-	if (io_fd >= 0) {
-		close(io_fd);
-		return MODE_IOMMUFD;
-	}
-
-	io_fd = __open_path_or_exit("/dev/vfio/vfio", O_RDONLY,
-				    "Is VFIO (or IOMMUFD) loaded and enabled?");
-	close(io_fd);
-	return MODE_VFIO_TYPE1_IOMMU;
-}
-
 static void help(const char *name)
 {
 	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type] [-v nr_vcpus] [-x]\n", name);
@@ -266,8 +250,8 @@ int main(int argc, char **argv)
 	}
 
 	if (device_bdf) {
-		if (!iommu_type)
-			iommu_type = probe_iommu_type();
+		__TEST_REQUIRE(iommu_mode_is_available(iommu_type), "%s",
+			       iommu_mode_unavailable_msg(iommu_type));
 		iommu = iommu_init(iommu_type);
 		device = vfio_pci_device_init(device_bdf, iommu);
 		msix = vfio_setup_msi(device);
-- 
2.56.0.385.gac671c819a-goog

