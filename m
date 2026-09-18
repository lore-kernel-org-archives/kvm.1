Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD03D6CD4
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699598; cv=none; b=AoegZwFf554I9fCuUlE1JR33iQ7/tg8waLVkxdrwlplS0JVNzyeCxEWGv10OKCr17+hlh7FIMY5ntxLNkb4aGqlUuyGeoyItp9C06P5GNCS/207BRx6aBqtHoHHtGVcPFgunEHGSAmViU34iNhOU7RrsTpuBZCT8xZNVHyfvOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699598; c=relaxed/simple;
	bh=LjJ5sJnEi5EE0IvALN7ryhHg4MlSKSnPS1b4dRznO70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwczLdURZU54WaZddKICxsMPM8IpIVy4/ez/bbzt1zK4lggPL/HCAoZU8T0mm2+9K76u/f5JMNfTErMVWxnj/ckrzTi3pItqUkN5ggUn+OVt+GuO+Lf7ZLRCTITnds+KJ5y9NuC7I3oHhNZq7AW/H94LEkYwFtC0uL9CKO4kkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JapdOEl8; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JapdOEl8"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so185457a91.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 19:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699593; x=1790304393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGnBH0JUMzyPu3dd9hYfJ7ZyZxE1z3RVWLOS62okldY=;
        b=JapdOEl8JJ09r9zDhLzltwOZw4miYVxvzvfdaPDbzwfUkwOfh8Booh3hBOC3XC96j/
         mINCO7Q7H4cWRQvGNvYOQ6d0vQCtI+GP/cWdSHXbNY6nWCwu76gNLbkhuP58ADPEiId2
         lbtJCQ+tA6tTBUjapg+aee20WzxrsOCbbje3k1bPXhHYxXLFulk1WLqo2tiBuvgWvusI
         ctFxz18SlxCxgrga899Q+NbHS6gBxv3cWmE+KGi7bcjJ8Icg8bA+qyBqDy2HVAYP+pG/
         2uoDAjQtUY2aJ5VcWvve/NnqEMd0rZcG57O1jk01wvkrlSQNx5fNEMnGukfjcfQuhnva
         oVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699593; x=1790304393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGnBH0JUMzyPu3dd9hYfJ7ZyZxE1z3RVWLOS62okldY=;
        b=UtAdFfW1rPuAyeU3Kyi70jkJJ5QiDZ8jwhm/TBTPDY8B8bK/ileIQBQh7y5fYJsjDN
         ZYtSqZkS/koBMS0+x4r03TjYIXE232/u2G9Pc+z9xozmpfvEu+ywv71n5k874HXJg8fe
         rXi7Jaj9ibx6tQ1T7c4MMDeSale1kM0h1ZIi2O0FZjNEEZYgUuuQMRz72X2MtFZ/fIEs
         tIVSUv4N+BCvPrn+XVqrCf2iS6/JiERo8ZF9AbD6hMfNLuoQpFGVRa72LT2MnL6V28WT
         FOdHmW5uwDkxV07nNeDzo2Oo7UCGro+u8SwHDi4WFP+ca7VHFmkOLoAZwkxI8ZeSQy4y
         EJaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwo8ISLaYYXk8/h/dmxG/q9S3haKtw5dUQRF0NedJ7Yo7/6oINTx2NEH5plYMhbQ/Kd07o=@vger.kernel.org
X-Gm-Message-State: AFuF++kadNjBWBzW0sYSRK2uNcnViljf9OW3tIqQ58skhzf+1N4em8Ph
	OVZKCEiNzk1TVXhF7Yx9jbEVkx3mdu7NEth+o7xMg9w4H6XxZA8CRJ7m
X-Gm-Gg: AYBFou2Xnf1YQWrdr8+6i7gGZUHfBLCC2xfb6P52VMHGT42rjWSp0JYtPA3P63JkKQy
	/pQpeaK3df/oLSvFWN1Z7iQwqa/O0nNAxloIQAosUbsC5T/2tAp5EUGYbPB4RTQMkHSaMGvnYJa
	ekfeg6Oim0lFsLtapgfTP20XgsB7BUCtaNF712Opbc/I4Uz2irZL3ho749LWvkUuUWhFVEG66TX
	rX92+WEqkHjN+exqfCFdnw8Xqx/X48xtrRREyvEWHbjRuHsfnCjiOFg3a8l0ig+QxZlEeJC8aEb
	F76VqILo+YRZurNeSA5R+jGer6JDp8/XzeYP2jBNdGNi12tOh82ZW25ZHA26EpIkt/NnGt9edgj
	RXxY5WHUAQDvUeg4aF8LCHafAAuqml8Wu+6OUd71AeuVkrthCgnGZ+XBrL8AVBULOVKmwZIFXpu
	lrWu5xON3tdwHkFr7DV27YpxD2hvFcAb5SQ4iJZRkGGzdrL0UARTBnXe+I2vdRUm96RBTtzgQv2
	740MvzNR6dvy9G64pk+GNtGCuhoMoeLAKGiCfw=
X-Received: by 2002:a17:90b:3c05:b0:399:1f8b:d255 with SMTP id 98e67ed59e1d1-39e54af0c87mr2618598a91.5.1789699593167;
        Thu, 17 Sep 2026 19:46:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:ec74:2ce6:f939:d0ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b0293sm349521eec.24.2026.09.17.19.46.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:46:32 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 0/1] KVM: arm64: vgic: fix UAF/crash on remote LPI disable
Date: Fri, 18 Sep 2026 10:46:19 +0800
Message-ID: <20260918024620.83869-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuchao Zhang <ndaugoing@gmail.com>

Hi Marc, Oliver, and KVM/arm64 maintainers,

By code inspection of commit 6da5e537f5af ("KVM: arm64: vgic: Pick EOIcount
deactivations from AP-list tail"), a race condition exists when a remote
vCPU disables LPIs while the target vCPU has an in-flight LPI in a List
Register (LR).

Specifically:
- vgic_flush_pending_lpis() unconditionally unlinks all LPIs from ap_list
  without checking whether the interrupt is in an LR (irq->on_lr).
- If the LPI in the LR happened to be the last one populated, the per-CPU
  pointer *host_data_ptr(last_lr_irq) on the target vCPU is left dangling.
- When the target vCPU exits guest mode, vgic_v3_fold_lr_state() starts
  traversing ap_list via list_for_each_entry_continue() from this unlinked,
  poisoned (or freed) last_lr_irq, leading to UAF or an immediate panic
  when locking irq->irq_lock.

Solution & Scope:
This patch prevents unlinking LPIs that are currently on an LR in
vgic_flush_pending_lpis(), ensures *host_data_ptr(last_lr_irq) is cleared
after folding, and skips the ap_list walk when eoicount is zero.

Note: this closes the primary race (the last_lr_irq node itself is no
longer unlinkable while in-flight), but the fold traversal can still
race with a remote flush unlinking a subsequent non-LR node in the
ap_list tail. Fully closing that window needs the fold side to take
references before dropping locks (in the spirit of the prune-side fix
in commit 7258770e5814 ("KVM: arm64: vgic: Handle race between
interrupt affinity change and LPI disabling")) and is left as a
follow-up.

Any feedback is greatly appreciated.

Thanks,
Yuchao Zhang

Yuchao Zhang (1):
  KVM: arm64: vgic: Do not remove in-flight LPIs from AP list on disable

 arch/arm64/kvm/vgic/vgic-v2.c |  3 +++
 arch/arm64/kvm/vgic/vgic-v3.c |  3 +++
 arch/arm64/kvm/vgic/vgic.c    | 10 +++++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.53.0
