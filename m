Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423690;
	b=WZ78ONkGsCaUU1unEV7MG0jBh2aknuAZbjkvxNKgo3y9uUhE6HwEFlKexSHRhHW5+ZZ7
	 MplhSmIIGNMXdjnpkn1f7CZ3/UKIZF1MBULOa1iKGMVMb6rsu7zr94ZRBJWCiDePEhNqP
	 1cSdGCJZukKiRTJ8/i5Yv1A5JOZJ23thO/c6QAs5Ksjjxa5FJJ+xryxfVkJ4BnEetpYPH
	 Wd6udPKO5HUQgfFT4S75b3B/tEf66TURUs6v3istumgsdSHaZFXScohBBX5WVXooHdmPg
	 f9EkoRhP9E4fc+T/50tJXm/JB1yCbqem+0zebPyWf4h5F7ELaFzem3veR+bNcI8CEZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=04CmMlHtyA+HZtytO/qkm53kP2CS5CYWPfp8WeZQAe8=;
	b=1KIXruflyS8Gb3PtgmH2eSBQyQBX44ERNIxHEnvhBZ/FYa15NyOZgO6W0ya7rDLGfg+9
	 qVwfFl5cLWnucqNBxH18em/Gw1mW1DXIMMcPatjZXAYYXF07DEeeEMJW0x4j0McZ+SsOU
	 Two0XPcbNyMtTgGA+0VMBbbq84agCzd52hmn1nZMwd3ynIuj6FzotNI1SMTguR6B12HOV
	 99lUelW78ex3S5u+GdzuYjkXWMXFMryp4+2R+UIJr21kEWu5Jh5bpCg7nV/IYUe6XbUcA
	 XgCwoyqtLE4a6qYa+mEMWg2puCQHkf+Foa+rUNhtK8KQRTjqnE39okPQsDc5HPm3hJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tenstorrent.com;
	spf=pass smtp.mailfrom=tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=KWXpn2n4;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C3C606A882
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 19:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8C3C606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=KWXpn2n4
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67c08c7adadso3033029d50.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 11:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1794423689; x=1795028489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04CmMlHtyA+HZtytO/qkm53kP2CS5CYWPfp8WeZQAe8=;
        b=KWXpn2n49e53R03JJkYNnRsbr3Hlg485ZMj1LWiO7b/ZYZmxB5hymIG+jrKnj4yJiF
         2VqC3woerV9BzzvrZeHlOdB3ocRNH1IxZb1ELVj38DpmV3AHutF8djYW4f4WnvT6TKFS
         Bn+50Yoft8BQEFVm1xczaIlIsB3sV/S+RNC4aZMb2ofnQVwf1W3MCoVyIY28+9wk+N6d
         JjxylBmH/rfvCHaEEEbtB994x1wq9ddOZrdOhHs0RAOkbfUsXNrQTA/nBIN6PZguB7B6
         XbYjKjTyMcQt7uERdwcy+KXoQQVci03j0FZZN3sZbJ04OIgdCvIhUa8I3yAV+yUSNO0n
         5o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423689; x=1795028489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=04CmMlHtyA+HZtytO/qkm53kP2CS5CYWPfp8WeZQAe8=;
        b=1IeqaFjravp5Ow+f8aPmFJtSX/Z5jv5ADnW+yPLn3Ss+Pexw2k4wRPQB25nKK6r4K3
         VzbmAnLssaDa62ftVzP6rrOe09JIkZU8I7nYW8qNeW4DVz2k901iC3/k/Na255d+h/Nl
         AEUBoz6DrAwauBVhKUe2ZL/hZ3lv0YpJDwZPzq4KHAkTeJcjI83ELNKwPh/5FkQ4Awnj
         HJd6wsjbZIE04ZFTw/FfYWo3j8+wSaMphgO5VM3ln6SGM5r1YQG/mvJ0FnZ07+1rZyhr
         TkaPxWbRjopNldJP48jlLr+cWUQ/FQfPOt5w62lO8DLGI0dt82jAPdjEc2bAuozmO9sj
         6FoQ==
X-Forwarded-Encrypted: i=1; AL+hErGrtm428osMykpxzaqpmX6EvPVPiSXs1shCUtNrgaonsmqH0pak4ZLTSvhkTBmsTJPAYFQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zzW9srEN/qmRGVcHACmVQC54cGPd0iFmMNdqroGYS9ExpF9Rg
	vbhIaZsZ51MY1wRuHdfAsWUk5kOOWStHsPGRzefF4ZartB5dKzzGoYMZohQO5NY6yjw=
X-Gm-Gg: AYBFou2yMeyWJNXWL4Pjs2IfpuRtumx0dXQUZh+NCaie2PERU8yNsGJY7+8oLK2uqwx
	SGcvWcgkym8rD0MOUdq2LlDouAULiWT4tGXcsVYG6Extf8wULBwainhqMTP/4+ehBLUXJd+reXk
	+KpY048P7dmLlXjALK6P7p7bgio686LkwpQhyI2SWVf56Cucdji1O5fpnx91uBRRd9fXYwrGDuu
	hj4+vC3HcQyWUnFv7+y9kUDryMUvqcWLzk4cBfOYHdMszfu5QETRzwHCKv0zmXH6FoUJA/h1CPU
	XMG63q4c6f7WzM6Cg7n/nXyjPi60vB4RWq9L77AcYynWDNOjjXm/NlCqVNhZ8k6kTG6txlSKkCH
	eg6UGlLhI7cJOovsfKZa9ACxSW/ypTPJgKO/CF+TTuZV60+vSFTWLxAYI+bHbPSlG1yuQ1cCPV4
	rRkbtv1cC6FGINdqw3J1+Yyo5Tihy3yw8Z+pAuYPhGWah5H0uWwMZa2ddnCPW6sDedLjtHbeSOm
	1VHdDnulrrIPPKIR477E0bvh3dO2BbHVRxJ1SoIEpFtloLwKhWiI/w3zNBPRGJC1YxzmxPi3eLs
	ddPaA5+kYW8Ub3thOpVGwXyq/tKY7lOr4XljLMzMFmMrqlh+gyXF1LFBaJ4F95cBcvWW6GtsSRO
	APZZA6XOagqethL2ptj0At3fk8boeDnQOPKZDuE10ves1AwY=
X-Received: by 2002:a05:690e:1381:b0:67b:f85b:737 with SMTP id 956f58d0204a3-67c68051586mr1824026d50.57.1794423688530;
        Wed, 11 Nov 2026 11:01:28 -0800 (PST)
Received: from lima-default.tail89d63.ts.net (108-196-157-19.lightspeed.austtx.sbcglobal.net. [108.196.157.19])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589a2354sm5209197d50.6.2026.11.11.11.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:01:27 -0800 (PST)
From: Andy Chiu <tchiu@tenstorrent.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: andybnac@gmail.com,
	Andy Chiu <tchiu@tenstorrent.com>,
	dfustini@oss.tenstorrent.com,
	greentime.hu@sifive.com
Subject: [PATCH v7 6/6] riscv: KVM: do not save host vector context for vcpu
Date: Wed, 11 Nov 2026 12:43:28 -0600
Message-ID: <20261111184359.1239821-7-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111184359.1239821-1-tchiu@tenstorrent.com>
References: <20261111184359.1239821-1-tchiu@tenstorrent.com>
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

Host's vector contexts are already managed in per-thread's struct by
regular context switch routines. Saving and restoring the context in
preempt-notifier is redundant.

Signed-off-by: Andy Chiu <tchiu@tenstorrent.com>
---
Note: I haven't been able to get a statistically significant result on
how this help/regress KVM performance running a nginx server in guest.
I am happy to carry out a test again and post the number if there is any
suggestions on what workload can benefit from this, thanks!

Changelog v7:
 - new patch since v7
---
 arch/riscv/include/asm/kvm_vcpu_vector.h |  9 ++-------
 arch/riscv/kvm/vcpu.c                    |  3 +--
 arch/riscv/kvm/vcpu_vector.c             | 20 ++------------------
 3 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
index 60fa28030944..06409c870a06 100644
--- a/arch/riscv/include/asm/kvm_vcpu_vector.h
+++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
@@ -35,8 +35,7 @@ void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_context *cntx,
 				      unsigned long *isa);
 void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
 					 unsigned long *isa);
-void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx);
-void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx);
+void kvm_riscv_vcpu_host_vector_restore(void);
 int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu);
 void kvm_riscv_register_vctx_callback(void (*func)(void));
@@ -77,11 +76,7 @@ static inline void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *c
 {
 }
 
-static inline void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx)
-{
-}
-
-static inline void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
+static inline void kvm_riscv_vcpu_host_vector_restore(void)
 {
 }
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index caf6e0ad72ef..d9d31851ee62 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -650,7 +650,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_riscv_vcpu_guest_fp_restore(&vcpu->arch.guest_context,
 					vcpu->arch.isa);
 	get_cpu_vector_context();
-	kvm_riscv_vcpu_host_vector_save(&vcpu->arch.host_context);
 	kvm_riscv_vcpu_guest_vector_restore(&vcpu->arch.guest_context,
 					    vcpu->arch.isa);
 	put_cpu_vector_context();
@@ -677,7 +676,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	get_cpu_vector_context();
 	kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context,
 					 vcpu->arch.isa);
-	kvm_riscv_vcpu_host_vector_restore(&vcpu->arch.host_context);
+	kvm_riscv_vcpu_host_vector_restore();
 	put_cpu_vector_context();
 
 	if (kvm_riscv_nacl_available()) {
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 730c32f7de50..6129a6e18404 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -61,17 +61,9 @@ void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
 	}
 }
 
-void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx)
+void kvm_riscv_vcpu_host_vector_restore(void)
 {
-	/* No need to check host sstatus as it can be modified outside */
-	if (!kvm_riscv_isa_check_host(V))
-		kvm_riscv_vector_save(cntx);
-}
-
-void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
-{
-	if (!kvm_riscv_isa_check_host(V))
-		kvm_riscv_vector_restore(cntx);
+	riscv_v_vstate_set_restore(current, task_pt_regs(current));
 	riscv_v_flags_set(riscv_v_flags() & ~(RISCV_V_VCPU_CTX | RISCV_V_VCPU_NEED_RESTORE));
 }
 
@@ -81,20 +73,12 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
 	if (!vcpu->arch.guest_context.vector.datap)
 		return -ENOMEM;
 
-	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL_ACCOUNT);
-	if (!vcpu->arch.host_context.vector.datap) {
-		kfree(vcpu->arch.guest_context.vector.datap);
-		vcpu->arch.guest_context.vector.datap = NULL;
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
 void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu)
 {
 	kfree(vcpu->arch.guest_context.vector.datap);
-	kfree(vcpu->arch.host_context.vector.datap);
 }
 
 void kvm_riscv_vcpu_flush_vector(void)
-- 
2.43.0

