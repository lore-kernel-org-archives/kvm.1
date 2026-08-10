Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D037F725
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344758; cv=none; b=l1MbfALEQpF6g66w+d2FTPX1saw7FHlWgSsYAE75liGQJbjYUA4WrH1H2BGfn6RSBAfNzmXoBD0ScMPW0mBLXsQ0DNHi31rIY9K98GrX8DDECf4hcwe2jrO2W8Kk5nOklbW7fzIkR4tzDh0MyVFFf2S2l6/i2tbNjIbgQHWg0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344758; c=relaxed/simple;
	bh=GUNh6H4wQQPS1pj5SNgH2nk098iFIpijKEKdRnV6amM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjZYVIXlF8FUBONudUwsW8+3oJe0WNumaIq/uY86dsrdW5Jq6ckzmjoCj///r/kMMUojlKtfGXrFnMjJZOSpbDCjKIH+9bzBAz9973KroTiD95YmBNuT97UDzxXZXwLQEUC01xorh6VN9hsKP5TZDKR6fhK079yPrPhTxX0XkDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwi0fRKT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwi0fRKT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso17307385e9.1
        for <kvm@vger.kernel.org>; Sun, 09 Aug 2026 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786344755; x=1786949555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OqEuJEoPbKvmQ82yf9uvBWxpPYFbSngty6vt/ZB4aZ4=;
        b=mwi0fRKTiLhZUBeyHNzJbMlJJ4xKMDIXgJZvRrstN4ckFf6ko4NJh043vKFAyP/3bT
         Hp0+73XAcUrsJEl4RibKwzVW/d97O7Z6i4JOsujWszgLrb3fxVCIe5n9oLxt/GbctiJm
         0S2x5CzbQzKV17DCO183IWWBpdk5EvDi5YLjqpzJOpoULNF7HdzWnJV9Dj6ClRst68+n
         LfpYreU29oDwHlps2TCvi1kxxYZu7c8OBscU0FX81KHq1PnbL/YYq9tnB+yOxIwgTrIn
         gN5RjnOZZkbOSV6ANCybvIBJ17aPlBuKBHfL8I8QCQzuzrWNYIh4hMDuYHD4Tbvle3wU
         StlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786344755; x=1786949555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OqEuJEoPbKvmQ82yf9uvBWxpPYFbSngty6vt/ZB4aZ4=;
        b=kyYGsLK2JzX6Zhe/V4VWz/wDwTURiuhREyO7yYhL4e7ZsRT+os1mAKcfSHKudh1jXG
         px+DecYZMHfZArb8GbPws6r9Exk9ts+42XOxq/Ac8U2zfXFiuyr2K3qPpnN+98zFgzTc
         ttqlzz7RYaxT2xQ3QOaOoWOBCiJXH427JMtAnfqO4CWskbEWbRyNkyAXO5ZkY/asrub/
         APa6b3nUO4i0Ucb5pGH1DOvkFKWBaZGmC0qYxaLrb8coCXk36VIAK8gPL13bxSkzean6
         ocnQdRAsS87TUyTKL8Wp3LudU3VVF2R+SmEeUx4hVPvqsggigmN6fXlWZ82RrYSfHw+B
         W4Wg==
X-Forwarded-Encrypted: i=1; AHgh+RrCWxe+BcSFHP01677Ldt+HSg5iYyfMJEDevA/7QolVw6zMxs1aRGakKsOpTLv0sB9rXUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Pj+UMZQjWjKfB1D22eD5t0N+zhc+1DxQT/6VOAbLy/SZR+P9
	T5+BBJajQerpJUPLzyecaz756aR8jQkhGJdMMntvkmEiUhhMUr69q5Qh
X-Gm-Gg: AR+sD10MJ6fRUWbQ9R+y12WqSWtX+w0eH+V6RLuKwwg0Wyp8rQKjlo6sZBZYX8vrq3K
	K/+q9su/7pv8eB76c7175AUmS0BSYD5AvTh17/WI7edBzD93p6ZyZXWWfITcSHBf8aDD6G1e1Ct
	TFDGxWl4/sMM4vnIQQFmfiRJIKpFdgfxjeCjQkdz9hYmK1u/PNdJ7lqXjSwpQ38ikIABkUzLVrK
	c0ThFkFIvxaSDEo7g/ZGDqVHheKgVjwBXRWQrqJukhvkhGhbrO4Wmxb79somgsBXak2ZDKEzfq2
	tUzWz7VGRVYYlCWUXufFkJbLx6SU1SyM/A440Gmw9BCZQZrCoromjUadNYJfl1+LkAMXMJj3K4x
	k4LkFdJFtN+Z7vA0J8LSxS0PsMoDfzmzXInqIgAVYrp93R0F3x2L+V11mWQLB1nmZAzcmm9kS9V
	cs3NdYxurEnKG3SsHYQCP3zNOd4rZJ1EzMa8TlXQrjXKOfVYc9lnsZjHoOcdB5kjQs/ndxWpnn/
	kxxVzaSywqlA3ENyc/nnDHdVrUQcKyncY4/HSpIHCNUALyb+Kz5tj8z3rXxI9whXSWElCwwuB1P
	gJ0lnI7riXs4QBsLuMvlKM3qlqrPRRH/wsnLhcvm5piUp8eA8QL89O6oTNDXISVvXxCfsjpTsoQ
	hmQ==
X-Received: by 2002:a05:600c:c4a3:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-4994e71eaf3mr490380035e9.7.1786344754823;
        Sun, 09 Aug 2026 23:52:34 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-a1e8-7401-78b1-a175-5d13-e92e.310.pool.telefonica.de. [2a02:3100:a1e8:7401:78b1:a175:5d13:e92e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995420c68fsm358800705e9.1.2026.08.09.23.52.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 23:52:34 -0700 (PDT)
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
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 1/2] KVM: arm64: vgic-v3: Roll back failed redistributor region setup
Date: Mon, 10 Aug 2026 08:52:16 +0200
Message-Id: <4e00fc25aa61ec52e6ef033a53588ce3f5550982.1786344511.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1786344511.git.kmehltretter@gmail.com>
References: <cover.1786344511.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A later REDIST_REGION attribute can be inserted successfully and then
fail while registering redistributor iodevs. For example, a region that
overlaps the distributor is caught by vgic_v3_check_base() when the first
unassigned vCPU is processed.

The existing rollback unregisters all previously registered
redistributor iodevs. It leaves their rd_iodev.base_addr values set, so a
corrected retry skips re-registering those stale vCPUs and succeeds with
holes in the MMIO bus.

A failure from kvm_io_bus_register_dev() can leave another hole. The
failing vCPU already has its base address and region assigned, but the
old i < c rollback does not include it.

Preserve devices assigned by earlier successful setters. On failure,
unregister only vCPUs associated with the newly inserted region, clear
their cached base addresses, and free that region. This also includes the
current vCPU when iodev registration itself fails.

Fixes: c011f4ea106b ("KVM: arm/arm64: Check vcpu redist base before registering an iodev")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 42 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d83019..832a7fe65984c 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -841,6 +841,31 @@ void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
 	kvm_io_bus_unregister_dev(vcpu->kvm, KVM_MMIO_BUS, &rd_dev->dev);
 }
 
+static void vgic_v3_rollback_redist_region(struct kvm *kvm, u32 index)
+{
+	struct vgic_redist_region *rdreg;
+	struct kvm_vcpu *vcpu;
+	unsigned long c;
+
+	lockdep_assert_held(&kvm->slots_lock);
+
+	rdreg = vgic_v3_rdist_region_from_index(kvm, index);
+
+	kvm_for_each_vcpu(c, vcpu, kvm) {
+		if (vcpu->arch.vgic_cpu.rdreg == rdreg)
+			vgic_unregister_redist_iodev(vcpu);
+	}
+
+	guard(mutex)(&kvm->arch.config_lock);
+
+	kvm_for_each_vcpu(c, vcpu, kvm) {
+		if (vcpu->arch.vgic_cpu.rdreg == rdreg)
+			vcpu->arch.vgic_cpu.rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+	}
+
+	vgic_v3_free_redist_region(kvm, rdreg);
+}
+
 static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 {
 	struct kvm_vcpu *vcpu;
@@ -855,16 +880,6 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 			break;
 	}
 
-	if (ret) {
-		/* The current c failed, so iterate over the previous ones. */
-		int i;
-
-		for (i = 0; i < c; i++) {
-			vcpu = kvm_get_vcpu(kvm, i);
-			vgic_unregister_redist_iodev(vcpu);
-		}
-	}
-
 	return ret;
 }
 
@@ -984,12 +999,7 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 	 */
 	ret = vgic_register_all_redist_iodevs(kvm);
 	if (ret) {
-		struct vgic_redist_region *rdreg;
-
-		mutex_lock(&kvm->arch.config_lock);
-		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
-		vgic_v3_free_redist_region(kvm, rdreg);
-		mutex_unlock(&kvm->arch.config_lock);
+		vgic_v3_rollback_redist_region(kvm, index);
 		return ret;
 	}
 
-- 
2.53.0

