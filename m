Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163694;
	b=gUVzBcruB5/GlUBPLQ7znWrb2ujWZHxRHUlxZ9DU0Fi4VprqY9MIC0nBwMxo0N9Z1j+q
	 f8cv9BOQrsM/BaILxpG5vCOuSOSmxZFYDVkmgslAz9SQuPD1NdDfE3fbFw8aaB2mj49md
	 k77zLVe6PTzWnZoazWRlu+IyupbQ1MPJw41qQ8IrJm7T6IsWVdQWadPsBN3URXj6eYVt/
	 Yqx881Nh1RTxq+rJueuL9VHJ6Y00qWiiYH7HrSjgkTfgsHOxipMRMl6an15abjkZVTmDD
	 n40QAz7I0WHaEKxOTZa1gMfWxWwetRMDcPP8EIfWmlHc6xIoJILvOWJhNo5Lp9ADDdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OLhUG1hLaXa/kF9EnkdPlvaJj5GdsFAdoHncTvXoPzg=;
	b=la6j0lXV+MLOw1Av0ut7bHeU0J8k3Fu5KMk/zf90N3uxfg5ycX8kFxgq11cV4bW9einF
	 mp+7xUF63iBZMXEg+F6zmFXJIEg4Hulo1EkFmEVCanJIINrlBtdHFCMNoDckCbYWZ+LUd
	 7xr/ulVMPkN70/ifvEBli5bhOlSKzP2kky3LZ8/0FLV7FWVvBYNt8woETJTUyPR5B257Q
	 3LGbg0kkwMihajsi3NoDlHYsMRCwWoRopND/Afe31cYuctA77cnAt6+VgoijiCaSLQJ3i
	 JcHRYey7gWzHNOnD72utJ6NcjTwD/0iqXsoUL8P3a5Yvw7VtTGnpTc/5xJ68iyWla4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLjQdggB;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EC060A5BE3
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 05:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2EC060A5BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLjQdggB
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so4765515e9.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793163692; x=1793768492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLhUG1hLaXa/kF9EnkdPlvaJj5GdsFAdoHncTvXoPzg=;
        b=MLjQdggBVL2AD1h0GOcUcWDuqReZnYU3b9qfaK8ue5A9xcWUG6KfpRAt0Wl6NXqoER
         fZ1HDrz1QiQL3FfIvS4zjI4dCab7S7x0XYqx41AGuJWbB+x77iAlWot635Lg8zYPfePc
         xaMfwHlgUr2ujy60Q+jW6fuwDFqHRv1GG4wR2Zl1k5422MUalyNd3NnsxhEOpsjwWEKl
         13T0iNnDFY5yXvRG6aFInUIBY5ZBHOFFWg+Ol/tNBtk+i0Jiqqp6SZCVRLoJSfyzvVfU
         mpcmx99srpecN3aTgQNnxt5ls9I8+fAg3ynhU2jWvJ2Vlrpas79RjuwjSUmvzI2B3YUH
         59AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793163692; x=1793768492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLhUG1hLaXa/kF9EnkdPlvaJj5GdsFAdoHncTvXoPzg=;
        b=SSIQ/fQR6a9u9oOh+J+Kejw9UGq3Wwqy7SJ+YdUnUPppohg2NFbgyhp6MZJxrm+CTx
         bOKKLFzJfJ7z0BymlP5RUIV7/qCCiqmTa1qFwoNpWrbjP5mW8Qzku/3P/gv0rHQTODIN
         ATaTOUBlXEeuqQkNjKwX+5KAZij9kU9/dAlVrx0CBPSkdtGxdN8czt5vjSvlquF5ryt6
         fWdAcCPtqk9iWS8bnu4yPifergLutcgEeDN+735WtNxCX0Jmfrvd8qQzfkBBlR3XJ4/m
         ahGJQJ6KHbn5q7DiaG3GpJmezMsyZ1hPorfUkxFLfpfa4jlrxC3glVbHJ0A81nXuznHp
         9OlQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3rofgg+xYPJ3ltmF+GXTP+N/Fax8utdMPBbuydQxj/ECg2wbuOP2BMR3D3rG/En0nc4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6EVJ73eIBQGWdW78HffXrvSiu4qMixOQS5giYf5twP7IDoQFW
	4hBnjPfwfmUgHAKfqt20YsocQJw8wS+nibd8iFaBhV8je5XxS6PGfyCS
X-Gm-Gg: AYBFou3srKJsUDXDIirMxuYEAis65GNePm06QpXWpdku5nAmgb28b3/g91qE3BhYkGq
	Nla1DWfL+WYsAAmRMzpqlObtJkHsZhHq0xuted20mltogFeRrxt5wSV6ZjnAAKBYViLpPJWHwWD
	0XlP0d/kdYutD3oEj1uHeeIH1Q9ftsE+mKmI69tawN+70cqFHQtDYT8nWvLiHkyseCkE/1J2vgk
	b6ozo/N5fxK1D5SpAL/KynFIYP+YPKOnmaq+PeCrBkptcZ9XxxPyZk9+LwC+7NcbBWuLeZ+qRLn
	05wclh+aYsf0zFhttqSerLxmBQ3umzCj1xMkTcMzUSji3rQW5V8ITKMpotaH9iCwhImNB4Nj2FK
	kB/2GfINEPntDZV9ghKfKthgewPuJulpAukWnVcoKLdu5NxH6/qplfioxf8yFo71Jy0djuNOrXq
	PMHvbhl8ORxpLGWQJJhczQab2bq/K1+D017cbAEqENQob/n/U1zNwIfmFSGzA9LShxRfdhVyxfT
	HvTXgMT+KUpBjkWpRYG9N31X25FZu+AB/qbVjbNDx8CtuOXPwMF7R0uo6LVTm7KV6mOmN7Y+N6C
	zHofexe/gCarsozpc6Bfp1YvwxatmaI1Wfno40ciuazHdbXw29FasD3WvVB2G2gCykwoi9XK0wT
	glywYBqOhzWwradxoTJQome9DMbFK+D1P3fOFlsByBfEdocwUJuR+G1CNU5CJYeSIuoSShh718u
	wt5O1y/bVCBOn85ef+ziftXRyJv5VPXfKSs8Cthw==
X-Received: by 2002:a05:600c:3e15:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4a9961f3d36mr12218315e9.6.1793163692052;
        Tue, 27 Oct 2026 22:01:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94eb8a60fsm13523365e9.3.2026.10.27.22.01.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 22:01:31 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Eric Auger <eric.auger@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] KVM: selftests: arm64: Test pending writes to active level IRQs
Date: Wed, 28 Oct 2026 06:01:13 +0100
Message-Id: <20261028050113.10046-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028050113.10046-1-kmehltretter@gmail.com>
References: <20261028050113.10046-1-kmehltretter@gmail.com>
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

Add a two-vCPU GICv3 test for a level SPI set pending through
GICD_ISPENDR. Re-pend the interrupt while it is active, first from the
handling vCPU and then from the other vCPU. Require a second delivery
after deactivation in both cases.

Also check that the other vCPU observes the initial pending state
before the interrupt is acknowledged, and that a remote GICD_ISPENDR
write before the ack merges with the initial pending state without
causing a second delivery.

Without the VGIC fix, the pending state written while active is cleared
on deactivation and the test fails before the second delivery.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 tools/testing/selftests/kvm/arm64/vgic_irq.c | 140 +++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_irq.c b/tools/testing/selftests/kvm/arm64/vgic_irq.c
index 3cb85932ee85c..83091e0384c22 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_irq.c
@@ -959,6 +959,145 @@ static void guest_code_timer_spi(struct test_args *args, int cpuid)
 	GUEST_DONE();
 }
 
+#define REPEND_READ		1
+#define REPEND_READ_DONE	2
+#define REPEND_WRITE		3
+#define REPEND_PRE_ACK		4
+#define REPEND_PRE_ACK_DONE	5
+
+/*
+ * A level-sensitive SPI that is set pending through GICD_ISPENDR stays
+ * pending for every vCPU until it is acked. If it is set pending again while
+ * it is active, it becomes active and pending and must be taken a second time
+ * once it has been deactivated. The second pending state comes from the vCPU
+ * that handles the interrupt in the first round, and from the other vCPU in
+ * the second. A remote GICD_ISPENDR write before the interrupt is acked merges
+ * with the initial pending state without causing a second delivery.
+ */
+static void guest_code_level_repend(struct test_args *args, int cpuid)
+{
+	int i;
+
+	gic_init(GIC_V3, 2);
+
+	gic_set_eoi_split(1);
+	gic_set_priority_mask(CPU_PRIO_MASK);
+
+	if (cpuid == 0) {
+		u32 intid;
+
+		local_irq_disable();
+
+		gic_irq_set_config(MIN_SPI, false);
+		gic_set_priority(MIN_SPI, IRQ_DEFAULT_PRIO);
+		gic_irq_enable(MIN_SPI);
+
+		for (i = 0; i < 2; i++) {
+			gic_irq_set_pending(MIN_SPI);
+
+			if (i == 1) {
+				/* Not acked yet: the other vCPU sees it pending */
+				WRITE_ONCE(args->shared_data, REPEND_READ);
+				dsb(ishst);
+
+				do {
+					dsb(ishld);
+				} while (READ_ONCE(args->shared_data) != REPEND_READ_DONE);
+			}
+
+			GUEST_ASSERT(gic_irq_get_pending(MIN_SPI));
+			intid = wait_for_and_activate_irq();
+			GUEST_ASSERT_EQ(intid, MIN_SPI);
+
+			if (i == 0) {
+				gic_irq_set_pending(MIN_SPI);
+			} else {
+				WRITE_ONCE(args->shared_data, REPEND_WRITE);
+				dsb(ishst);
+
+				do {
+					dsb(ishld);
+				} while (READ_ONCE(args->shared_data) == REPEND_WRITE);
+			}
+
+			GUEST_ASSERT(gic_irq_get_active(MIN_SPI));
+			gic_set_eoi(intid);
+			gic_set_dir(intid);
+			isb();
+
+			/* The second pending state must not have been lost */
+			GUEST_ASSERT(gic_irq_get_pending(MIN_SPI));
+			intid = wait_for_and_activate_irq();
+			GUEST_ASSERT_EQ(intid, MIN_SPI);
+
+			gic_set_eoi(intid);
+			gic_set_dir(intid);
+			isb();
+
+			GUEST_ASSERT(!gic_irq_get_active(MIN_SPI));
+			GUEST_ASSERT(!gic_irq_get_pending(MIN_SPI));
+			GUEST_ASSERT_EQ(gic_get_and_ack_irq(), IAR_SPURIOUS);
+		}
+
+		/*
+		 * A remote ISPENDR write before the interrupt is acked merges
+		 * with the initial pending state and must not cause a second
+		 * delivery after deactivation.
+		 */
+		gic_irq_set_pending(MIN_SPI);
+
+		WRITE_ONCE(args->shared_data, REPEND_PRE_ACK);
+		dsb(ishst);
+
+		do {
+			dsb(ishld);
+		} while (READ_ONCE(args->shared_data) != REPEND_PRE_ACK_DONE);
+
+		GUEST_ASSERT(gic_irq_get_pending(MIN_SPI));
+		intid = wait_for_and_activate_irq();
+		GUEST_ASSERT_EQ(intid, MIN_SPI);
+
+		gic_set_eoi(intid);
+		gic_set_dir(intid);
+		isb();
+
+		GUEST_ASSERT(!gic_irq_get_active(MIN_SPI));
+		GUEST_ASSERT(!gic_irq_get_pending(MIN_SPI));
+		GUEST_ASSERT_EQ(gic_get_and_ack_irq(), IAR_SPURIOUS);
+	} else {
+		do {
+			dsb(ishld);
+		} while (READ_ONCE(args->shared_data) != REPEND_READ);
+
+		for (i = 0; i < 64; i++)
+			GUEST_ASSERT(gic_irq_get_pending(MIN_SPI));
+
+		WRITE_ONCE(args->shared_data, REPEND_READ_DONE);
+		dsb(ishst);
+
+		do {
+			dsb(ishld);
+		} while (READ_ONCE(args->shared_data) != REPEND_WRITE);
+
+		gic_irq_set_pending(MIN_SPI);
+
+		WRITE_ONCE(args->shared_data, 0);
+		dsb(ishst);
+
+		do {
+			dsb(ishld);
+		} while (READ_ONCE(args->shared_data) != REPEND_PRE_ACK);
+
+		GUEST_ASSERT(gic_irq_get_pending(MIN_SPI));
+		gic_irq_set_pending(MIN_SPI);
+
+		WRITE_ONCE(args->shared_data, REPEND_PRE_ACK_DONE);
+		dsb(ishst);
+	}
+
+	GUEST_DONE();
+}
+
 static void *test_vcpu_run(void *arg)
 {
 	struct kvm_vcpu *vcpu = arg;
@@ -1073,6 +1212,7 @@ int main(int argc, char **argv)
 		test_vgic_two_cpus(guest_code_asym_dir);
 		test_vgic_two_cpus(guest_code_group_en);
 		test_vgic_two_cpus(guest_code_timer_spi);
+		test_vgic_two_cpus(guest_code_level_repend);
 	} else {
 		test_vgic(nr_irqs, level_sensitive, eoi_split);
 	}
-- 
2.39.5 (Apple Git-154)

