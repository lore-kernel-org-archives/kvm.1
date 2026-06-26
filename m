Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712233DF001
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462242; cv=none; b=Y4bszbnPLngfvMr/xPwAwv+jR/MtqP+eb1ckgrCqaBjRtTOZoIIlov+40LNwrWISZqF2lNINlgJyupLL62DxYTo6B/cZr7ESI8zPDHplGCWyCKYDadV3ElCDgBTnHFt4L4aWVQzQ3WXGxpvlqEY0ryw0yhmN0WwmA/mPNrhERwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462242; c=relaxed/simple;
	bh=VCtdpA7YF5advtu0bupY3qxS+FfCYS20j33S3YKJEL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GWWZp79HxcAfOXpiKV79Jo9a9S4TFmYhFATQhWSl98vTs9EMQSrVfYTB03VlN2f0BaGS5jToqAJ9v7CDAbhcrLdxl7dlq/498iQ5dU+DEOEJoYKkNcN1jUD6ZxFjl3/BX5wAcGwBJ6XFlhy8abs6gizjXJfNfSWFPy16s0ugPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZFfB8sbG; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZFfB8sbG"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1384ebe7a10so529155c88.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782462241; x=1783067041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8TjMER5gISFlQ4SyOMczlZr2aeQOkgr25LHVZl1LkM=;
        b=ZFfB8sbGw6PYU726rPQYVhJksyYvYa2B+reA9AocpI8M1LXBXakEdSkos+9vatXn6l
         klJIXvhdlfcMGA0GGxzC7Nv/nwqGiTAVt3V8b9ZPyVuozKbiHn0r1vUjbiM3JDEssDWR
         hFK4f3UIhLFPP4IzYq6UrdWBtWlYl7x7LKVN/bX8c2v+XL3ELvG/36EpoN/h00xWchwc
         iasuOxQNemLhNcJZnNkjHiIWB9pvFxBnM67XsoUrGhS1+y1ZvYW3gZAYkbTvjV2ypqgE
         qJ7nAPCUTHo29ej6erdoD6jBcwP/G/AA90VrYLGYlzZ62m0t5OytDhYhfbLxAknKg0uP
         xRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782462241; x=1783067041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k8TjMER5gISFlQ4SyOMczlZr2aeQOkgr25LHVZl1LkM=;
        b=J3315Macljy7JhRJql6zB9SJXr9YUwnsHrkjV2HQctZZiU+8s8aFsZwtfLIF32AXup
         kGoFaLPNF0bN+y2Yn7ftB7BrD8uD3NmhUpqa+rg0y+IJOYLnLTHbtXgDCcIB/TXKRzHP
         t5AlAIQvPVT+pt5els4ZDm/pK5T5bF69VX6MH6l4Vud/HiHo3niqoO+Ip1h19lA+abD0
         zh3ZV58HKd+ZqIsgFezWqyxs0XUBRLOm+q5X8g1CSczR1jDRLpm/OYIJY8EPMY7dteB7
         wJS8EjoAw4nFNo9rkJ9sV1zr82CFMvJnqZE8ew8Sf3EKGIrl79T8VzHIb3q9tub+0jyg
         JYnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8LtfgixxJUNT9dmxDxTZW0hkx0XwA8OOIWv6xzBHGtOXuvPYIF5I3gsqTYHS6SK9Rpls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Qo06W3WM3W/Cmud+emKvqyHllizhKE4PiiWheWGWpg1HO6bG
	+ItJg+L4I58ZA4iNi0SPHXDjJp0BBJRrZ+/C9L1ddWo8dvsbrbz88TLj3eEpSPpRggc=
X-Gm-Gg: AfdE7cm015mCCEBtHyxnVGU2qlrLj3ZrcAuaUQz6ZJGq5VyGgtFPofsfvDmH80Km3s7
	O+7HqvkdG1xt/TyVzFScX7HVQqz3aRVXhISbMMQk7jwQoaDcMnNstmBhUW+RcAslJvbycFY5MWg
	dglCXYywWLL2XKi8pPa/jUmf44QKjJ3f0+1vt8a5Y2SgL3AgVPlhiz0YDtOIgpQqBgJneaeei4y
	RQm4vp209yCsb35JUu1br6ZvWinX2qqDVLdG9Opfl3LrADWFTaxsjT9a+f+2aGRTyLGpT70zpmu
	r0GgEp+tJV/blkosMbhO9N63k0gny5owD6MGEuhasO9wC0xDZYxeRsMNin76Sq+PByP/uQkOu8d
	7FOc0QPVVb/Ru1+qDtRF8WHym38SAviyQn3IqKV32Ekod9zM+0i3VpngDC+3o4ix69/qXgLhVpp
	UwagxKFoCjrcYLN9z1VNwa80myuhV8dNiP
X-Received: by 2002:a05:7022:ebc5:b0:137:feeb:3fc9 with SMTP id a92af1059eb24-139dbb5b2d9mr6090271c88.18.1782462240516;
        Fri, 26 Jun 2026 01:24:00 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f318e7sm15557199c88.3.2026.06.26.01.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:23:59 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Fri, 26 Jun 2026 01:23:21 -0700
Subject: [PATCH v2 1/2] KVM: RISC-V: Clear former VCPU cache on
 virtualization disable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-kvm-cpu-pm-v2-1-478e5ef8dc9b@sifive.com>
References: <20260626-kvm-cpu-pm-v2-0-478e5ef8dc9b@sifive.com>
In-Reply-To: <20260626-kvm-cpu-pm-v2-0-478e5ef8dc9b@sifive.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Nutty Liu <nutty.liu@hotmail.com>, Jinyu Tang <tjytimi@163.com>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782462237; l=2593;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=VCtdpA7YF5advtu0bupY3qxS+FfCYS20j33S3YKJEL0=;
 b=PLsuyWmTEcgztSc4jAigjlQNrBKATP06+H1C5DMVQ6nyjljp9p0vtpvzJiWdtN2jkenD9DYIc
 v2Jc5qMTS2+D+On88Jk0ju4NdP5P1vHLUHdxSAETIrJn4I7SmX333Ra
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

When a CPU is taken offline or enters deep idle states, hypervisor CSR
state is lost. The kvm_former_vcpu fast-path optimization caches the
last VCPU that ran on each CPU to avoid expensive CSR restoration when
the same VCPU is re-scheduled on the same CPU. However, if this cache
is not cleared when CSR state is lost, the next VCPU entry will
incorrectly skip CSR restoration, leading to corrupt hypervisor state.

Add kvm_riscv_clear_former_vcpu() to invalidate the per-CPU cache and
call it from kvm_arch_disable_virtualization_cpu() to ensure proper CSR
restoration after CPU offline or system suspend events.

Fixes: 1323a5cfe52c ("KVM: riscv: Skip CSR restore if VCPU is reloaded on the same core")

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/include/asm/kvm_host.h |  2 ++
 arch/riscv/kvm/main.c             |  2 ++
 arch/riscv/kvm/vcpu.c             | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 60017ceec9d2..808b4ee1bd10 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -319,6 +319,8 @@ bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
 
 void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
 
+void kvm_riscv_clear_former_vcpu(void);
+
 /* Flags representing implementation specific details */
 DECLARE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
 
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 0924c75100a2..350e4f097d6e 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -69,6 +69,8 @@ void kvm_arch_disable_virtualization_cpu(void)
 	csr_write(CSR_HEDELEG, 0);
 	csr_write(CSR_HIDELEG, 0);
 
+	kvm_riscv_clear_former_vcpu();
+
 	kvm_riscv_nacl_disable();
 }
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index cf6e231e76e2..e48338f907f4 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -26,6 +26,17 @@
 
 static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_former_vcpu);
 
+void kvm_riscv_clear_former_vcpu(void)
+{
+	/*
+	 * Clear the per-CPU former VCPU pointer because hypervisor CSR state
+	 * will be lost. This ensures that the next VCPU entry will properly
+	 * restore all CSRs instead of incorrectly skipping CSR restoration
+	 * via the fast-path optimization.
+	 */
+	__this_cpu_write(kvm_former_vcpu, NULL);
+}
+
 const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, ecall_exit_stat),

-- 
2.43.7

