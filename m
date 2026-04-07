Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4538C2B4
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545256; cv=none; b=giDVZawDucYOtp6xxEbMKMM28SHzZ036vDbvlkie3RC1dXzOMWx5L5wOK/jNW3UnhXE01phmn34qacyfltCV6Bgr2PUb26IDX8c5ftg8QQwTJibnyuP032ZKHwIpTUNHaqRJPmfpFOYKN5WPsEHKXhutjGuXXOAgX4nae/RqYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545256; c=relaxed/simple;
	bh=mQR+a8OPBvteI0W4O45g2Imlr9m8CgVQu0HSfanxxx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9+arjbPz/pZG/MmQCIESs1+soElxPJSpSUTzOJYSWcp25hwvqMZ4rk0wLWPHZ+sB42li4HqPYvpiZ5nWGZOKR/NpwZD7lTtZUmEWJT8/3OJx77PTKcA/JWDZhn251t3wck+izFD5f+v7WDONfACdHMP1xzmpE2R6z+HBwN0BuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=bPxESway; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="bPxESway"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso3398073a91.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 00:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1775545253; x=1776150053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycWHTJCFcSaHWVinTdmZisX3flH8CquJ9HqYIsGNcVo=;
        b=bPxESway5wmN4CWlc4R+XT/EJf5q5uD+Q01+ameb2Hs/TUOc2beiLlPt8Zgh9HPyp9
         FWu0bN9nbkv+FJU1H34PyN3l3B8NFlNvexiVZ/8wEPM+QrUdJw/VBuoXFmwZYgOzTTqB
         FhrFthzq2jaNwdcGBABLFwmCfsWLJcumKU9u8Kyi/I/syRsQuw41SrHPW1SVT7iZ8Zhw
         B2nbdJHnqLXjdq/I5xX+96sQX27zVxJomHQHrAmphp+Jd8cHXsD8TifEpDeC+AXKBwhT
         t+SHVdbv1aQOBpkMfOp8u6MrXdsnRu/W4ylTirLCz73hew9agYA/cOU2LLlEGCr3htjS
         BHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775545253; x=1776150053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ycWHTJCFcSaHWVinTdmZisX3flH8CquJ9HqYIsGNcVo=;
        b=olNs8D5ulloXKLWnPrSetZ2TZgEs21cuDFJ0+gRnBAED7qAxfA10trlxOLHoAGRCoq
         wIxQ/dC3E8zrPzHGhK7CCV7r0l8KwxLas4VCZsPxMdJOSYBVexf11C70LN24DqEe5qkL
         YF9TvIHgR/3XiURxxRyWdLNG8OhiCDhuppGDJp1VUauKMhsCpOzetMwdMXR8X0J1avHf
         QLFi9/qkUM+BpPmysHt3QaSFmKKsef4UqQURlgdVoiWWTV8XWe8IMKjVaJKeaJ2h5Nuh
         eUkf0DcNY4EaiXvfOf8E103UlEQmQtOFwBrgxfTHtA0bRM1t2bC5j3xyTakZTmFpEWWm
         viaw==
X-Forwarded-Encrypted: i=1; AJvYcCXH3LEPMpzPeDw3cDE6mtAAOMZ0Toc5lMupJLFqcIg35wwDnsJsXCa82rAJkVHPXJrtzrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3wbrpxUdvvJ0S6fzw/zhgeBbQbTTmmvBLXC46reK8Pi2u2p/V
	87Fi2xBQTaHA1H9+xC6heCZSi/91KhtfMTc3JN2hcvX5EoGeSTQYSGPvN6Sb1JBm6raGfpkYWP5
	fkNIzukODstlm2xC3600YRqXFM/H6jr9aCbOBydA1QM7s54Y=
X-Gm-Gg: AeBDietQZj4L8KpuyveT28Z+2rTgnhkEfcogJ/gIHPOJBDuK1hHlTk8fw3JJaldWbPz
	d5q8bVPQ2iycWjXH5EbO9OL2WZ/cQ1+UB1ISyp0u4xEyQl1o77bA0OkrqyaAj1zKLbhTGVgEHp6
	RJ1ojE52BweQggNqB1Rfu/7RLwAwMqVLyZNFAxj+JYIiovwZUWlbAKkEM8+JXDaqy3BZbwf/Pvq
	khatYYgfRTQcymAV6UEB63znCY25y2yo4nnj6zDVd/B3lCASU0EXW9q2zLQItecLl+hYFFnPArt
	q+WgS5k22x4V/G/N6Y+FNuHP6PkXLs55wh+n7KpiHkwvSOOt/T4TkkkIYtEtXeJjtbbVK56NehR
	iA+iHHmIHJWBkEVF03sac1Yj5gOuKwuqkc6JYktCn65wo/lIr2Q13NwHH97h0dYVN7f1MtvR4y5
	aGVK1EUrEa8Rqjues7zEQp/wEPJGQ6Iw==
X-Received: by 2002:a17:902:c405:b0:2b2:549f:7d2b with SMTP id d9443c01a7336-2b2816c2d9bmr172080735ad.11.1775545253443;
        Tue, 07 Apr 2026 00:00:53 -0700 (PDT)
Received: from DESKTOP-AMNC9SI.localdomain ([2407:cdc0:d00b::3])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b2749a2e42sm149648315ad.56.2026.04.07.00.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:00:53 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: seanjc@google.com
Cc: igor@gooddata.com,
	jan.cipa@gooddata.com,
	jaroslav.pulchart@gooddata.com,
	kvm@vger.kernel.org,
	lei.chen@smartx.com,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com
Subject: [PATCH v1] KVM: x86: Rate-limit global clock updates on vCPU load
Date: Tue,  7 Apr 2026 15:00:46 +0800
Message-ID: <20260407070046.2336-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ac2LI_UPPrf45vmp@google.com>
References: <ac2LI_UPPrf45vmp@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.

As a result, kvm_arch_vcpu_load() can queue global clock update requests
every time a vCPU is scheduled when the master clock is disabled or when
the vCPU is loaded for the first time.

Restore the throttling with a per-VM ratelimit state and gate
KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
scheduling does not generate a steady stream of redundant clock update
requests.

Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
Signed-off-by: Lei Chen <lei.chen@smartx.com>
Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/kvm/x86.c              | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5a3bfa293e8b..6d3d3f19af01 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1453,6 +1453,8 @@ struct kvm_arch {
 	bool use_master_clock;
 	u64 master_kernel_ns;
 	u64 master_cycle_now;
+	/* how often to make KVM_REQ_GLOBAL_CLOCK_UPDATE on vcpu sched*/
+	struct ratelimit_state kvmclock_update_rs;
 
 #ifdef CONFIG_KVM_HYPERV
 	struct kvm_hv hyperv;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 63afdb6bb078..4a37027cc0b8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5211,7 +5211,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		 * kvmclock on vcpu->cpu migration
 		 */
 		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1)
-			kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
+			if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
+				kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
+
 		if (vcpu->cpu != cpu)
 			kvm_make_request(KVM_REQ_MIGRATE_TIMER, vcpu);
 		vcpu->cpu = cpu;
@@ -13189,6 +13191,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	raw_spin_lock_init(&kvm->arch.tsc_write_lock);
 	mutex_init(&kvm->arch.apic_map_lock);
 	seqcount_raw_spinlock_init(&kvm->arch.pvclock_sc, &kvm->arch.tsc_write_lock);
+	ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
 	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-- 
2.51.0

