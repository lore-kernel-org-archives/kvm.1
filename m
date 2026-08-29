Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DBC299959
	for <kvm@vger.kernel.org>; Sat, 29 Aug 2026 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787982627; cv=none; b=qzeLGt+3K6/VR3Z45+cRUEwpRNwd+beByQONP89gi+lGLoxlP+lNiHzK44EaQONgm5qzk4pBYxvsWOgdlqbp5Q8rtZu8sJJ9eJPyAokXPSBThgy+kDzAcnyAXhvegKfVatt70fsVlvrhD9CaVO6DGr5Ry1Z2LUISjVhPHJh374M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787982627; c=relaxed/simple;
	bh=aru3gpZckcqhzLmD1P2HSOiefupvneO2iUB5oqNw958=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nv1FuCKWjV4nz97I4W0MjgLJml3I7BIDvEmRb8Om2Ysbo/Pr7TTi0oYDmdytO/MYn7/sArivk6moRUdGf7CkWhulIGrAxIT7TulCjbtC/IqWzNexUe523C2TsMwrdRNHTmBRmCYs2zueNlut+BoG7TLQiHw8pFjW5aD5OKpP/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjAKPDiH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjAKPDiH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495590dde14so15687465e9.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 22:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787982623; x=1788587423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBWN6j8OnBuuPy0FKZmRrD0AlW+PPdIjJrnUe6crviU=;
        b=GjAKPDiHLPFArNBvKMyLefBHvLNucNuoYwePhbhaGfb4sQLyCCXC09en94CFYNO1pC
         eH6fZ565GQSH1oU4WpjLr8tF+Xndp9TpBI49LrxFH2fWKaoRHfIGnH953h/MN26lUCuO
         Ergud5VSUpWpV+wWQyQJFmYNBqIPtQII/+xcudqKpXSB/Jzodj/0kc9eEkAlpcvlyc3R
         nR8FGnBuiZAuj/6LH9j/8jR/cj6+1bm8UMLvJDKGhE5w3DccTzdAyeE7OY9K2ebRzxKP
         zwVUOXuu5QdwZFPyirRxjYh7vSYQ0d721cBj6YGS98j18ct50NB67Vmk08T8F60LKVPW
         lZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787982623; x=1788587423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JBWN6j8OnBuuPy0FKZmRrD0AlW+PPdIjJrnUe6crviU=;
        b=K6aMNphCbtp468wj339P4so+orkb3CCrF7BfmbxnVn+zjoSoJE2L6NYID4Q5K2k/Lx
         50jKF9yWqbMLmrnn/tZOMgU3L4UMHdxqGtqEhyPxDWtcZJOAzrWmTX87EFIXMd1Td4T7
         dzuiKddxf5Y3WhVrrbQFN22EucbjG6DnHc709FVjLSRqM12F+2zGW8h/+spa/jH3axge
         1r0AWrrGj4+fuo2A3x/MasMoxvQgCUrfMW/O7tFWG8NjzWarUloYSBCwSpHZZFF6LY7I
         5z13iczS/JoOHPCVmR+EDoJS7wBHRoquaYzpo8m2SM9xEOVRBJRBoAVn/GnolcOqDQDt
         nMbg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6ExlvwcZuQcV5vNKoDC+JaabA0/eHcIvSg6r18ZO7M/vXarqHZqi0Lf5sLHSpv2YUnNA=@vger.kernel.org
X-Gm-Message-State: AFuF++l49FFJLDzxE3F63C6OiiZXvMN1f3IqN7WHgplAgIlaVSHh0+XB
	K1pjX2Ul79If09Lc5IWmIDhdeBzaQS2AwZpkfNqmxNZvd73WC9KYYBZR
X-Gm-Gg: AR+sD108ST+/6tti33QqKF8wt5REx22/d1rvU4UaPyiLrSFXKhFCpjhQ3sTo809hUeu
	JmgTw5rurowSYA8Rlnj8PF8Dsp8gyQ1e5ckooCHAHyUHRLTh9UNXDkL2QlqVnqN55227IoeraUP
	3p0lREvhFvrDaLFp8MoQKJpawLhACi+cNehufK0P+2yPEvZHMM72lCpuNwqkBo4SlmN0FxOMbLr
	LBU185K7XuQbqLemWyPKWhcvRbTA1hTtoqPRy/JItz9YuR2KVnwfUdUlXqxulBW3EKy9rTdOJ11
	sFtcenjmC6/a2KNMJ+0lu5w7DReAelYbacKFHASu06e9nQPWnPZyKrP0GDdZBDAx5U7w9kS35Wh
	Ns9/ILPIwT5B14KJxJcEJ+bsG+/MWVq4VrjJzmhuHHTwl8T5uNfvTUYovFagrV5xHnPe6pIbV4d
	sYqRRk7qGCu0ZcpAPAh0JXnzBQ2p8qvNfsxjLp/cJg5CsWXJgsaWoxKcM1++Ih3woEB7tstLfXW
	/R9K/cwxHZG/Ni3Qq2Ng4uWw3vCl+CxUT64a1JNyM4fzNJdTp6g88S/SC46Rmw8C2RN/AVWOEYv
	5MkBRPeHfoaQceAu5+w4
X-Received: by 2002:a05:600c:a47:b0:499:be9e:49c8 with SMTP id 5b1f17b1804b1-49b91c50957mr150918935e9.13.1787982622515;
        Fri, 28 Aug 2026 22:50:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-015-136.77.7.pool.telefonica.de. [77.7.15.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cca3e642dsm35357485e9.2.2026.08.28.22.50.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 22:50:22 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] KVM: arm64: Return -EINVAL for an empty SMCCC filter range at base 0
Date: Sat, 29 Aug 2026 07:48:55 +0200
Message-Id: <20260829054856.70549-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260829054856.70549-1-kmehltretter@gmail.com>
References: <20260829054856.70549-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_smccc_set_filter() only rejects a range if its inclusive end,
base + nr_functions - 1, is below base. That catches an empty range
(nr_functions == 0) at every nonzero base, but at base 0 the end wraps
to U32_MAX and KVM tries to insert [0, U32_MAX], which overlaps the
reserved Arm Architecture Calls ranges. KVM_ARM_VM_SMCCC_FILTER then
returns -EEXIST instead of the -EINVAL that the smccc_filter selftest
expects for an empty range.

Reject a zero function count explicitly.

Tested with a userspace reproducer on an arm64 VHE host under QEMU TCG:
EEXIST before, EINVAL after.

Fixes: 821d935c87bc ("KVM: arm64: Introduce support for userspace SMCCC filtering")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/hypercalls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index b11b8821c9fb..dfa25bb6f25d 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -185,7 +185,8 @@ static int kvm_smccc_set_filter(struct kvm *kvm, struct kvm_smccc_filter __user
 	start = filter.base;
 	end = start + filter.nr_functions - 1;
 
-	if (end < start || filter.action >= NR_SMCCC_FILTER_ACTIONS)
+	if (!filter.nr_functions || end < start ||
+	    filter.action >= NR_SMCCC_FILTER_ACTIONS)
 		return -EINVAL;
 
 	mutex_lock(&kvm->arch.config_lock);
-- 
2.39.5 (Apple Git-154)

