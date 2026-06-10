Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E35E408007
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095683; cv=none; b=bMERB3gM50D+N6lfOspLRbPD64hjBPMAWkuxLru51AUgMzZwKNEgVDBkhNutX2sLjDNkhwNFkoodsP67zFZlGYj7tdnBFktPWn9c4xyzKUGH7nZeaETY7S5kmaSYRrF2ZBPS9IsZjDVicRoSpJM9oi3i0nng7mHu27mcgtwokds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095683; c=relaxed/simple;
	bh=vb8J9WPTwzLVB6z1mh6FgX4LLdfqg9muViMT6Ci00oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mxv/JBvimqiwQXTB+16qsDY5AdQsA+QdbX66tvaAN0SszQrcIZItIHr/Q0R4GGXq77+LGGC4JH3TfQrhOyGFaaFhHmWaJWgIlHU75URt6bBWBoNG0cs94Lbu/hlaM5yDmor90nme3aG8FEVimhRyBSRHiB4cOuo8BBMcvut03bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4ER7PYY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4ER7PYY"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so4334164a91.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095682; x=1781700482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzUuGXzS98sIHXJvfaHc1K4ylZrcF6IomhXuLR53Dbo=;
        b=m4ER7PYYdMTkkntXNImgMkr1Qu7Wuxa0DWZhwwYrXU0BS8RXA0pf600gMgcSBelzWp
         9/5fFpGZiK+mFEl024wIxvG8CbIdw9YMMdKbPnsBipRqmZzHRU/endYOQmSe2Bqq29lh
         Twd02glx6vHPgGF3XZ0CrDjqfUU5PqcwbvoTt/20bOYgn/BDU4dVafHAh9PSSo6ON49y
         nBnmS59qzOSYqgt0HZoecvctlj+01k1IllirbTkXUFzxFdH8hJrFDHjPChRpjtSmZc9h
         YyuyQxvmz44U8slx7JRawWHOjtH1hxvwt4l7WRULE4mgodNM/LjBJs7RTgCVqxRMmhz5
         EJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095682; x=1781700482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzUuGXzS98sIHXJvfaHc1K4ylZrcF6IomhXuLR53Dbo=;
        b=h5u69Ewb39Pamrd8UuwRNUo9R+kgXLtTqj9EYQ0hVfSbfJexA6WBrNRMtghITjjBZO
         K17ltG3M/1KQqAISpSHJwgzA4Lj7qBnljOXL82StPA6+8I84IBOLekjYli9qYcysApkv
         8xjP6NTglmtjUN+4g3MpR8oeO+/cJgo6rWFNv5P5JOPZciWUzHN2HOesb+K6/p05wlh5
         EmOf7NWpqg6OzKJFPOa+GqANXCGUYD7xJLLfj5kl7npO+xCT8gMGind5Jw6NexBcaDk8
         a56m4GChe6N0dw6VXWyNxVKfBeVd4mLIWEVF2UIMOVIer1sg+9X//qD1jEdB7eV6GJSY
         6/dQ==
X-Gm-Message-State: AOJu0YzTtF8QJEZobaSCrJniKecMAKi0at33nCrnis4sqTC1R5iwvRen
	YVGURa/ownLrWWpMndWpgDuvHYVcwXMh1oXFcjSfKOWtVcDB6N8nuO8aWqxOrQ==
X-Gm-Gg: Acq92OEWCpju93LDzUln9Y12Sjk0+MXq2+P4tpU//Te7TV2Q8nMK+cX79/XRI6ua5Bl
	x/Y9DS7edg9PBtqvyF3En9j6DcXkdXE2WxOIXyqRy9qA3jiKsyBkUNshA2KyYDE0xtkpdl/PnB5
	8KkVRMPO6xMC7JTsC7jIn2Qi3OPFIt7RsWt3EMMV30kwqWlcZeftpkjJX9b6PJAEYpiXHvwv0Ma
	zGwPICOjSbiFk52unEGhUoqMvE+XCWb3ECDq2Bk6G10mW8w0tOm8f/k+02wBpI607q4PjaVe9xg
	vw4BCkRzv4Mwk6IBEOxd55koh4bhouAnT0P3gMyp2LlOf1xMa7CsQ27qb1Uj+TH/VyfjvLlZzqN
	UBRVfJe3SIaGEjbWtKDhYxFGz7ofbTrHF17dbgzo1x2re+6E07W5EF5Vgtv1RW30uXJZLOjRymi
	31LQTMN6JR/ccyeowKbid6rRJbuBB7TmpJknAfLOUQ6lJCRn4juVClCu4t/6PA4Q==
X-Received: by 2002:a17:90b:390e:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-370ee447eebmr24964447a91.5.1781095681671;
        Wed, 10 Jun 2026 05:48:01 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.47.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:01 -0700 (PDT)
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
	Nicholas Piggin <npiggin@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 04/10] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
Date: Wed, 10 Jun 2026 18:17:20 +0530
Message-ID: <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com>
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
2.50.1 (Apple Git-155)

