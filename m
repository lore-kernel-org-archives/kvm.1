Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070330B533
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059087; cv=none; b=QR5RYYg+5HRzHcTgswTM+nfOJ/iyiH7zt5oMc76KxtN717AIDRSg/KvgmJ9ZKkl1Qm44gISs5nm/QeuxjuqWKVGHN9REvjLpzYDnGqWpwUujswd3bMKNhi2kJLpSGRX7bUd1LIBGsHR7jeEskH5eMgY8QagnbpiSZ0DgVrrTOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059087; c=relaxed/simple;
	bh=DF3MzSny1Am7eKIwk79qee/angPaE8IKQJ94fvbsu28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UkINrlnu+w8h/sDd+xcV4UcGx0buFozBFeatR7dLu2CPuWrfa1mczWJLN8sHnSNxcuSxoLblJG9C4Dodln07aNk9eHzMLMdExfsoVWHnXika+KAmZpF1vK/ddyvunpARqiqOFUTDh2HxO22vlPeTF6QOqpGy4pCMrWZWeZ4Vkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACXBKVy3; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACXBKVy3"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40438e0cba6so2356632fac.1
        for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 22:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776059084; x=1776663884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5VXrjV443bibQOd/tYM5XouxdJe5ZhAegjzCEygNJdw=;
        b=ACXBKVy3vjkzD+3XnN5t/Odyt9XDnX9YcOzCXQDg4ET3UTntw1tJ5e8JkcnHEcf5w4
         /85YNflNNoy16orqtF/vvKuI+TfC5bCCK7Kbg65IaCg/afP+iKoRCl7GR9Q2LhxLC6a2
         rc0TG+c76YuJrlgQuH4b1P1ZzuPT9JP2heKj6i8tSlyzxJuFW9fMLLFNHkasLJ45advD
         059iHbCVPpEBhkp4rexbB4F5tyU4GePF5ufxFuX9nBtQ9CJNCqly7rJObwQO2F7FS0sZ
         u+tkRcLSEvJ+imKBSYgbI17b8NkbbzL+rurHxFEnQwNaZ3+W7vh0YOBd02abHujyGXHA
         RGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776059084; x=1776663884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VXrjV443bibQOd/tYM5XouxdJe5ZhAegjzCEygNJdw=;
        b=swnodYA46fsffUZ3pH6elItHODp6ZkgCRIlwWrO4Bj1inWjSt6TU/zDLIP4bm7BAt8
         yXtK9DjcrjJFH3mAsSdQkNuoEplSnt8qdmhrx1fmqgIpm+Mqu4KkS3ilifkm0oAZh+Jg
         XimmuT0jDHZx4seEy9cTzWKMhNFvtxSSO1kDac+hlQog9wKJHQD2gPsT1YcSIPlkvU0H
         RU3x27kxe+yP3tw1a09ovYeIFSLYcKUbXouL/XRobVgN5tL6pc61PEfcsdxTpUli5SgB
         Tk6P29RkeDoLRPOZQ/f13qCejSbLCnHF7aDwuITgTzvBVjGJnUs9BBKuRBDe/rrJD9sW
         AkPw==
X-Forwarded-Encrypted: i=1; AFNElJ8RyKlVqJs9phVSIMhKm+ADGHXMo2VA7q46ka42sKBY3BzG0i+jEwSr/wHf0lV7v0kzfyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqALusl7ZkzAP8PFeIEmfdeC6w+VM1xMukARAf9Sdj25VgDe+
	w3XWlEzXQ98BWzg4mMEThKka+sLDZP1s67omjMIjV16ZBAN67NYnankg
X-Gm-Gg: AeBDietCoGXFi/ijnayEvmVTIMNJtRj1+hfQEx+0aWKqjXW6CMujLzH5X7A0vCs0yBW
	9KuwtITK6AUF9INWQE/lXzing0PqM+D0iIsR3qoMOq4DX1J57gPvke7cvpgWdFrLdu36Jlg8VLJ
	buhfdprVqWhmE5wtjiGSW+7EZzyZgrdE8dtS6dYhicS6k3BG65BfVU3XQqxpsJg1ntNMx5X6UNX
	/IC49m5x/7Rpl9c4zEqQ9WdphE+ad6fo2yyjYF05j4GLgYdcAGOLHHo+VlvVTy/AiLxCEb1OA0s
	1lro59gFDq3kbw/gR3apgxJ3MvUNaT9eG641X5IK+El0nzHDGklcKAkxRjVk8To6mc+F/f8PBi9
	GujKeSIkiRDv8nShvO44X9uSOA3DHQ26C9N6gUzOleJyevpRHklN2SSzEaht554sfv9XQzpoAys
	a9aS4JchOGYB8dSNJxTx7Ra4yu/W3jjM2L+fD8p7kiUWWb
X-Received: by 2002:a05:6871:8a5:b0:422:ba93:2150 with SMTP id 586e51a60fabf-423e0dcd14cmr6537796fac.4.1776059084209;
        Sun, 12 Apr 2026 22:44:44 -0700 (PDT)
Received: from ird-aus2.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dcf9726fsm8520703fac.0.2026.04.12.22.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 22:44:43 -0700 (PDT)
Sender: Michael Neuling <michael.neuling@gmail.com>
From: Michael Neuling <mikey@neuling.org>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kvm@vger.kernel.org,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	andy.chiu@sifive.com,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Neuling <mikey@neuling.org>
Subject: [PATCH] riscv: KVM: Fix memory leak in vector context allocation
Date: Mon, 13 Apr 2026 05:44:39 +0000
Message-ID: <20260413054439.1715082-1-mikey@neuling.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the second kzalloc() for host_context vector data fails,
the already-allocated guest_context vector data is not freed,
causing a memory leak. This is triggerable from userspace via:

  ioctl(vm_fd, KVM_CREATE_VCPU)
    → kvm_vm_ioctl_create_vcpu()
      → kvm_arch_vcpu_create()
        → kvm_riscv_vcpu_alloc_vector_context()

Note also that kvm_vm_ioctl_create_vcpu() does not call
kvm_arch_vcpu_destroy() on kvm_arch_vcpu_create() failure:

  kvm_arch_vcpu_create()           ← fails, returns error
      goto vcpu_free_run_page;     ← line 4209

  ...
  arch_vcpu_destroy:               ← SKIPPED
      kvm_arch_vcpu_destroy(vcpu); ← which would call free_vector_context
  vcpu_free_run_page:              ← lands HERE, below arch_vcpu_destroy
      free_page(vcpu->run);
  vcpu_free:
      kmem_cache_free(vcpu);

so kvm_riscv_vcpu_free_vector_context() is never called to
clean up the partial allocation.

Fixes: 0f4b82579716 ("RISC-V: KVM: Add vector lazy save/restore support")
Assisted-By: Claude Opus 4.6 (1M context)
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/riscv/kvm/vcpu_vector.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 05f3cc2d8e..46fbf48f25 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -80,8 +80,10 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
-	if (!vcpu->arch.host_context.vector.datap)
+	if (!vcpu->arch.host_context.vector.datap) {
+		kfree(vcpu->arch.guest_context.vector.datap);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.43.0

