Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8462389108
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934561; cv=none; b=aKvQ7MN7Ox7a3os/6YkTO4oCb6a9AoA4iLf8dsSwzPnSFlrie6zTXAtGp0hldmaWHbWRzv69sl0x8v19PxMNZGo2nzYHly7vZiAl/z+e2e2nHdODDvv2SuFCrefYlrN/TrM3iVpS5jDH1gFkdSb9E/aF+Cd9OPeQ75hio1Hzvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934561; c=relaxed/simple;
	bh=/1xQMlHTpDPPKdx9q0rSMVLO6gl3M86K+ccnqA5gdNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bD5MDHSe3CqSaHIYoUXTHGBlNPgMTaGcF9ohmECoi2YwJe4t6jKypG/A81PhzpvF+9S4jxLtutIgLUyalx02P5Q7R9GVGVxU5qwQwSwd+PD7fL6yX7QGeKtT3yAgHeMg4x6/3h9fgFOyrtv+Ig9tDQj1Ts+Eafm49JXVYg501cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVj5872W; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVj5872W"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b7c2ee830aso101429455ad.3
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 15:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777934559; x=1778539359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ua9DP8bxNVeP3OMgw66O02tdFbDSKg07QfaNr/ggdeQ=;
        b=TVj5872WcGbO5rkLygx+jdlTxLbs57qu3ge1RP8rRNjL09FJ1iCy1SRhb9gnfzMrzt
         bLLldOz6G3IFUpweOt/4QDTrU1V0LjluE3InA5sYuXSurrBpuo7ucviKjuVbzSfe7Yyj
         /srHsjmgOp4TLiunQBvEBBsX3DGMp5LgwKVxcJnpR0qHlpdCGlb8y5QSkPVKIqSPMb5H
         cGC/YPkxmWAkLs2axHIWk2t3nwB4kOygde++rosnAUlbgD72FYNTBw9cx5ktpRzRwJ7q
         ikIcf4QduCrz2zrDUUnXqUH688hsUzH6xb3QjgujRW33tlHXA6dPzYUjxvw+k6T/j43B
         kXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934559; x=1778539359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ua9DP8bxNVeP3OMgw66O02tdFbDSKg07QfaNr/ggdeQ=;
        b=IX0maBVLtrqkFFrC8IBbl6FVieo1WItS2V9qn2KpQ+v2IKoe0b6HxqKcdPztnrIY6J
         IXD7H/8PoKoQ5hmEj2BySuhhDwbvf8WQZcQRpX6JkxMLlxEG5cipNyhSIeCUKOZYLGVe
         JKX85VU+bZF6PIuF5O1ob5hgZDSYr1+ZG4gO4uw9mqHvQnDrf1OxPbixZ788haLnZj0H
         beCvQbC3qUwXUnoCV72N78yPPU/0H0GGv8kAoIwyoQZ18t4QZPPlnVy+aS0+FJjb+VaK
         GbniJ5EA25oCS5gtgCU4v1jdjM4dGK9+kT+EyW1pcLqCDsSEQ/oU+GQhQ3U8RGPVmln4
         YSCg==
X-Forwarded-Encrypted: i=1; AFNElJ83OXiPaeYYBItTnipwkZMMUMSlQwzSjdC8hEuGk1Pk5UcQkRMLGYw5UEgMTL5t3gFQoqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBlp8Z8gAo0XIDElvwuo2W6RAN5PaJRnBg9KW0QAdlRPJDlVZ
	+HLF9aSENEJVdHQk64Z7uEA8l1SO5kWWE78kJ/yt2mExnGlrXjyFncBT4Irw3RdwXolwffAAqSn
	n4P+yfjG4ml+ZHCV2gBHNJQ==
X-Received: from pgvh2.prod.google.com ([2002:a65:6382:0:b0:c79:81df:1175])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7e86:b0:3aa:3e4c:9182 with SMTP id adf61e73a8af0-3aa3e4c9385mr220269637.7.1777934558985;
 Mon, 04 May 2026 15:42:38 -0700 (PDT)
Date: Mon,  4 May 2026 22:42:09 +0000
In-Reply-To: <20260504224213.1049426-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504224213.1049426-1-jthoughton@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504224213.1049426-3-jthoughton@google.com>
Subject: [PATCH 2/5] KVM: loongarch: Grab MMU lock in kvm_arch_flush_shadow_all()
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Sean Christopherson <seanjc@google.com>, Gavin Shan <gshan@redhat.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Ricardo Koller <ricarkol@google.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, James Hogan <jhogan@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

kvm_arch_flush_shadow_all() may be called concurrently on the same
`kvm`. This could at least result in accounting mistakes (e.g.
underflows on `kvm->stat.*pages`).

Cc: stable@vger.kernel.org
Fixes: 752e2cd7b4fb ("LoongArch: KVM: Implement kvm mmu operations")
Signed-off-by: James Houghton <jthoughton@google.com>
---
Note: This is compile-tested only!

 arch/loongarch/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index a7fa458e3360..5dbce9b18e1c 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -486,7 +486,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
-	kvm_flush_range(kvm, 0, kvm->arch.gpa_size >> PAGE_SHIFT, 0);
+	kvm_flush_range(kvm, 0, kvm->arch.gpa_size >> PAGE_SHIFT, 1);
 }
 
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
-- 
2.54.0.545.g6539524ca2-goog

