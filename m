Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6983C2798
	for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392438; cv=none; b=nww75ZxZBL4Esq/tJftHrRU47DV+1i3eN2/diKl1ULSTjD6Q7pMqY005TrYIvGfhmdybLKt+luxXf9v2QkbY8pNbxyXM6JVuav/ddQalVFhdIynFqjxDFp8wQxUhrASJSPoDYJtt1E20LXL/N1X6zjNHZZBRd/HCq41Cys2WlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392438; c=relaxed/simple;
	bh=ah6a8+r9Fx1EVjERXoUoTSdBjhjWjPdaic29SNFB80I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkWV8btr7lym7Wz2Cgbz+cU/wuXzQATCwAADiX+Glwx2fKfL/kGbmeXUls5c3mbxINrLQBJw/+wYi2IATpQT0G94/2U0GwHTdIEjh2uybc9B2ZpUXv5b2YbNjyL29UTrbyYK1Et99rDMkaJ2PVVGOFZBiICOXJJZjE7iOPP5lY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAyrGwei; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAyrGwei"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a1542cdb53so2340444a12.2
        for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787392435; x=1787997235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqVzAbnyjF6+2pKtzAxu1aGHo1gAHNbWqpu34didy+A=;
        b=XAyrGweisfw4pM0l+/YelQmoAeRPWlzi8VsPUNfpMtFkScc1lxjH/NfQQgsAnJlWwZ
         gKh/flOxwDfMCyabiIp316Q4Aa9uXH6uU4kS3zlr20G3Br7hlQv4myTRkhnaKgefBua7
         pswwmNmxKT8WmoBpivK6mjfqq33Wcy1SglL+ojvTU07tSEwGaEx4HO20Gzt9tCWlTS1V
         h6TO4bnwBBlsvCrkK2tWG7QHuhke2dGqvU4h7nfJR3TXXELQd1wVatLvX50L7yt1xfLa
         rkAWLp4aLCaY8bGSBpR5O0i9Ws88V2n9aq3ty3gdWUYfEHu/XW9O20hJ6ccmz96IhJmr
         ErJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787392435; x=1787997235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqVzAbnyjF6+2pKtzAxu1aGHo1gAHNbWqpu34didy+A=;
        b=JsVtTGr+IkBQQxsJP4hnBylIbxwzQOM9YayQKYm643WzLTYjcM9cwFTRlw1pjDTD/t
         NDG439LobsySMreRlc7pq1Mx7Qoz+9C07ZVWuooQhj81JgmOg/lWMbtOrJY8xdjLU6gg
         1H28eAjB7xaapg1F7zvj85KOxI0H9bnLtCMRYxZ15LgTgj9wVnCxJmvNtUVZpKDnZwCP
         anraSFlrCCwC8/FP7OJYJZ2gijN+c1+42Ql1OABhGKwWbd1ouslI/VLMsCi6S44U8ivY
         GXcA0GxYUVg+dcXqF+tU9GWCSWb+NBbk5pw9PA4q5cWYi+258WLS3C3Mi7eRcpPvj5vI
         U8UA==
X-Forwarded-Encrypted: i=1; AHgh+RqkCZwlnf1/5gVfeIOhpwhPz+x9FEEwYeemo86thy3Ll3AqtPlE1DK6iKmciEV1bgMmjdE=@vger.kernel.org
X-Gm-Message-State: AFuF++mreMv4kvdaUFdNcoMBYhGdnsW5MAYAnyk9Ax8Ai2V+Brcgxhfi
	m+gtHVnk6XOHpwQEkgrOR4z9dUt+Vij7VoBg+LE4RPjRBK6VYqUxu5tx
X-Gm-Gg: AR+sD12EZlPhy0ZAhUPO9vYt3qKT3Jslsb7yHWq2vwXW7pYLGuSt37t67waCUWEIo54
	6rkWSBCm5iKaHOGnDjZu8HYQ3JEY6YXxfTM3lFDUMqXoBFnktYYGq5p5rQXA9zejZpE61VZ8/cC
	aA/NfwX9AFzITZ49ZgUlJrRamRU1z+KakViFOH/MHVcmdRlrhnfAoOO0za591GFFzP1rIEPkL06
	Eg9USdMM73QMMsz4khR6uoNDEVNeds4zrau5QR088zUATofxnBycROtuLWn/zbKOVwqfUgM2qeL
	9s9ifMgWbehSoh7IjLZijv7KkheGA7L2cBD9/uWea1l4Lh4nGtq+fxGwQIhScJ/D60Us42xLTbp
	ZqV69IIZrqrI2n2KWcC35pKA5VNiG6JJXESu9ZrhuFEhhQtFVSWH7gURw0UO999RpLF/iPZ8uHb
	O82kJKZM7gS0ZzYQFFIQ337O8Q4+gTmRFikhpQhU4CnwelbN+vBVLzRf0WNqTQYA1c+UIb2jTF+
	NtssTSndccodm8hUSzfxMQ2ozjYS0HD9UA+uMxluKHWPcouH4sN+VUq5uGIZFOzE7KdeawXHOoS
	YlH+xTMOObZiV6D0oBdYrYdQoYQyFjhGpFJGGq+iZRcxb6Wm+DItDnp91dcrnwbtyiF0
X-Received: by 2002:a05:6402:501f:b0:698:6084:db7f with SMTP id 4fb4d7f45d1cf-6a582b5f1a2mr5487769a12.10.1787392435123;
        Sat, 22 Aug 2026 02:53:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c327asm11151586a12.8.2026.08.22.02.53.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 02:53:54 -0700 (PDT)
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
	Christoffer Dall <christoffer.dall@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/5] KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
Date: Sat, 22 Aug 2026 11:53:42 +0200
Message-Id: <20260822095346.53882-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822095346.53882-1-kmehltretter@gmail.com>
References: <20260822095346.53882-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vgic_register_redist_iodev() assigns a redistributor region and base
address to the vCPU before adding its iodev to the MMIO bus. However, the
region's free_index is advanced only after registration succeeds.

If kvm_io_bus_register_dev() fails, the vCPU retains the assignment while
free_index still identifies the same slot as free. A later registration can
therefore reuse a slot that remains assigned to the vCPU.

Reserve the slot before registering its iodev. The caller holds slots_lock,
so a registration failure cannot race with a later assignment. Undo the
reservation and clear the cached assignment on failure.

Fixes: dbd9733ab674 ("KVM: arm/arm64: Replace the single rdist region by a list")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d8301..22897ce64dbf 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -766,6 +766,19 @@ unsigned int vgic_v3_init_dist_iodev(struct vgic_io_device *dev)
 	return SZ_64K;
 }
 
+static void vgic_undo_redist_assignment(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+
+	lockdep_assert_held(&vcpu->kvm->slots_lock);
+
+	guard(mutex)(&vcpu->kvm->arch.config_lock);
+
+	vgic_cpu->rdreg->free_index--;
+	vgic_cpu->rdreg = NULL;
+	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+}
+
 /**
  * vgic_register_redist_iodev - register a single redist iodev
  * @vcpu:    The VCPU to which the redistributor belongs
@@ -818,16 +831,17 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	rd_dev->nr_regions = ARRAY_SIZE(vgic_v3_rd_registers);
 	rd_dev->redist_vcpu = vcpu;
 
+	/* Protected by slots_lock */
+	rdreg->free_index++;
+
 	mutex_unlock(&kvm->arch.config_lock);
 
 	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, rd_base,
 				      2 * SZ_64K, &rd_dev->dev);
 	if (ret)
-		return ret;
+		vgic_undo_redist_assignment(vcpu);
 
-	/* Protected by slots_lock */
-	rdreg->free_index++;
-	return 0;
+	return ret;
 
 out_unlock:
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.39.5 (Apple Git-154)

