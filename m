Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F838839E
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934564; cv=none; b=TSrpNXU075RktwGsQcPR6XZNP6hQwapel0B8vfaMtmRlZM6OMvQy1L/+6MohfYgVz2VsPejd9PeIxLC0KOjeGc2/fYxfY6Itt9TnqwpUUPNcdONKAcIzRNL8oUd3Mpn8/wVsdryM0XY7f7VCTvtA5OtcYRTu+2FMs5Du2WyoR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934564; c=relaxed/simple;
	bh=CUOCTJmVRKCTLlMSZJdBYm2KCJJFvArAmComUQyKG2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OvVj3vUJW/ZM4blusG7z+InA5JtXZWXP4TGiu1TenPWo98pRnq1nx0e1+YedHp8LoHsfKHgdmd7HoW9bm5aIzNTHmEpFEvotLjWFdvKq9yK1YNAM0Rzx5kS07OZJaSvxg1gaRYhU+drt9lZm+5hJfLnSS9+NfjgO27kpqMONaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNCJCJOs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNCJCJOs"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c79798cd9b9so1303676a12.2
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777934562; x=1778539362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPDlks8S40wU9ZB94GBJYrEHqJjoYpfybndF76KRr9U=;
        b=pNCJCJOswO7K0JMYh1I3F/+isDgwdbxdEw4UIMAmGDvBvyz28YtVXt7eyd5EW5JvUm
         Puju2oC7k7acSosIAEADK+iQq6aw+vpi/dgjtIxltMHLajPeIR29ZlWyumfp2UVn/i+N
         ECet1OB++24jQSDQKV23E0KetxYMuBaAq/JnjJXpB+js6l7t/tIF+HUJIf0OKNtmwN0H
         CMlTJOQjil+3a+wUNSVwpXjvDbXriag2MjW2CRj2989wJJxxL8GsXK4fcYMIQ141goSB
         QxMoONNha3nCdZBy9QtC2HumKJtyEdhNAnESZ2ipqoqgMljGQHDGiKPn0bBt0zNcMRke
         jRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934562; x=1778539362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPDlks8S40wU9ZB94GBJYrEHqJjoYpfybndF76KRr9U=;
        b=nd40BjH1oT+Pse87TJlboaeyGjR5N74bt6ncfR6fCZOjKcjmka0aUfdifmjqZURDst
         8qokLvXS1iso2JW5Fs93ULhuy0MLJHtGkASOZRsc/CR4q0cgc+QBcWXTKVqbhItUgkOj
         bT4FtMkAIqbVlTcarJPKmwfnCkhS12iolc7+C4cCM+DDdmHvll4LIa1itFfFUkam7rpm
         n0htDJv1zK9NJ12cWUItzT7WZSlLL7dN6OZQqIxXvkFrWSCY4lLMuZ83QJpWeAg/6hP5
         y2LEsmUZW+vNKIEre+4hGAG7CyNPkA8+zEOdA+MSOdo29/322QAkOD8hFH8+SbZfCpe0
         8j9A==
X-Forwarded-Encrypted: i=1; AFNElJ8hbCSW5+Noweq05cPauPRBoUwAc9P+WEFSoepvQhLB/azsK2TWfIhxWQdAtl92B45YghU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqXYZp9MO1SKBwDPQHruaHtGJg3sqtEiY5hJyqLBnV6v7bP/v
	xXtSX3nfFW2WEtWzGkB3CVxaMPqLS/O8TD4kbhELKfkcMJGBKEGjbfWrnl+3iC+KUD9qTxq9eo2
	PU5yZVVST9y+FFxuPEz+3Eg==
X-Received: from pgbcp9.prod.google.com ([2002:a05:6a02:4009:b0:c79:8315:4734])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:918a:b0:3a2:e0d3:37d1 with SMTP id adf61e73a8af0-3a7f1eb20dbmr12044574637.41.1777934561428;
 Mon, 04 May 2026 15:42:41 -0700 (PDT)
Date: Mon,  4 May 2026 22:42:10 +0000
In-Reply-To: <20260504224213.1049426-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504224213.1049426-1-jthoughton@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504224213.1049426-4-jthoughton@google.com>
Subject: [PATCH 3/5] KVM: mips: Grab MMU lock in kvm_arch_flush_shadow_all()
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

kvm_mips_flush_gpa_pt() expects the MMU lock to be held; it is not in
this path.

This can lead to a double-free of page table entries if
kvm_arch_flush_shadow_all() is called twice on the same `kvm`
concurrently; such a scenario is possible.

Cc: stable@vger.kernel.org
Fixes: b62091108633 ("KVM: MIPS: Implement kvm_arch_flush_shadow_all/memslot")
Signed-off-by: James Houghton <jthoughton@google.com>
---
Note: This is compile-tested only!

 arch/mips/kvm/mips.c | 2 ++
 arch/mips/kvm/mmu.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a53abbba43ea..463b6c4aa62c 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -180,6 +180,8 @@ long kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl,
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
+	guard(spinlock)(&kvm->mmu_lock);
+
 	/* Flush whole GPA */
 	kvm_mips_flush_gpa_pt(kvm, 0, ~0);
 	kvm_flush_remote_tlbs(kvm);
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index d2c3b6b41f18..5045833f8116 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -269,6 +269,8 @@ static bool kvm_mips_flush_gpa_pgd(pgd_t *pgd, unsigned long start_gpa,
  */
 bool kvm_mips_flush_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
 {
+	lockdep_assert_held(&kvm->mmu_lock);
+
 	return kvm_mips_flush_gpa_pgd(kvm->arch.gpa_mm.pgd,
 				      start_gfn << PAGE_SHIFT,
 				      end_gfn << PAGE_SHIFT);
-- 
2.54.0.545.g6539524ca2-goog

