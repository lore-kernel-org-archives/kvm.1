Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996677;
	b=S41SsSr3wZTDwiajNqPahgNYkIefJgxftFNaqogkzI2gyLdsB84BX97L1zxQmvnhwmWS
	 OR6jR/hl9pn7vHcONljwgWiBq4TLW+zJgd4TudoOhIdNWEt3QSzA+jOppyrU/8qxbNwBt
	 +AWL5jEEKkB2A61ToU3CFH2AgnArhriYzyJWh81DOggvUfSx8UKRD2NKFc0o7Rk5GcVP+
	 3WXmu5uWGv7tP/c3snD8p+fzfTm4M6YanVs+BYcMl89CVnqjSIhfuXHCbRiGp3QBI7R1R
	 plkUwQuzTiz5Q84GVt6tITgktkoBBCcqOXZBT4CDrOVP2q4LooTi3bh3DmqUaWJ+/1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996677;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=10vF1TNZE1jmUzR5IhA4Cr9+ZCuxH/DSuBr/E3tdBrQ=;
	b=blAoC3kfsgSRXfdGK/4ESBlpYaRHOPoG1cb4ibeOnWnuUAd3E8TTxLLbI9pF2VUlj0oD
	 qkXSpMYHZxHQKQUjkt24O0m6O4aXPnHEp/m0pGJLOY+1kcvk6emuI3BMlqiEa6eWjYD+d
	 +v74Tpv0gTWf6YAhhsPi7bCF/R5gvl4anlwN08g+54rigrnnqTe3O1BnkggwOUezf03Vg
	 l/c1yMzuqkG4otg2eCY9qci1SKFcl+H8+GYUDPx3Q4pf8FEbob4CjrxUO+xXde5KLyRJ1
	 pJjwJ+821hEZiLRgiAYE0yESNpgVb5BpY7RPSB10q1AaXWRNiTPG7LIqjMiC2VbJLDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XiTjr3A0;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F144606A320;
	Wed, 18 Nov 2026 10:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F144606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XiTjr3A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=10
	vF1TNZE1jmUzR5IhA4Cr9+ZCuxH/DSuBr/E3tdBrQ=; b=XiTjr3A0742JJy8J3g
	2GjHnhhuzFxw72XZJs08zxmKDvpS9bc2zkFZAMMUV20tXpaw6xrI9IM0delGgf28
	4tJElLPPI0Dc+/nfTiXKdWHSMy2tfFfzFmisZUNzIIKszIpg5cLZ9HqaYmRiKMAe
	gB8y8+NxMy7aqrH+rj9+PkK00=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_9WAef1qJpK6IA--.4941S2;
	Wed, 18 Nov 2026 18:10:10 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	jniethe5@gmail.com,
	gautam@linux.ibm.com,
	vaibhav@linux.ibm.com,
	kconsul@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] KVM: PPC: Book3S HV: Free nestedv2 state on vCPU creation failure
Date: Wed, 18 Nov 2026 18:10:08 +0800
Message-Id: <20261118101008.2242596-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_9WAef1qJpK6IA--.4941S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4fAw48WF4xKrWDtw1fZwb_yoWktFX_uw
	s2q3ZxWaykAay5uw1kAw45WF4Igr48JrW0kw10q3srC39YgrnrWws2qwn8uw1ruayjyFsx
	G3yvvFnxJ34xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRR7PEUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gKYB2r9eYJzIwAA3P

When nestedv2 is enabled, kvmppc_core_vcpu_create_hv() allocates guest
state buffers and messages through kvmhv_nestedv2_vcpu_create(). If
the subsequent vcore lookup or allocation fails, it returns without
releasing those resources.

The caller's error path only calls kvmppc_subarch_vcpu_uninit(), which
does not free the nestedv2 state. Call kvmhv_nestedv2_vcpu_free() before
returning from the vcore error path when nestedv2 is enabled.

Fixes: 19d31c5f1157 ("KVM: PPC: Add support for nestedv2 guests")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/powerpc/kvm/book3s_hv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..1a1a4e3ba412 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3097,8 +3097,11 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	if (!vcore)
+	if (!vcore) {
+		if (kvmhv_is_nestedv2())
+			kvmhv_nestedv2_vcpu_free(vcpu, &vcpu->arch.nestedv2_io);
 		return err;
+	}
 
 	spin_lock(&vcore->lock);
 	++vcore->num_threads;
-- 
2.25.1

