Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986274;
	b=lTYeehRCFWH0m6oy++z2z8L0fPSobROATf7tfOFOIRAFTctwTSLM+wFTx8VMaHYxq/hs
	 2i4GJ8cs7YzR1AaVCCPfOIqXxvQC8RhfDBLccg2WJVEkgwSpQ6j0pKqOKJssGEOPLSTYC
	 TsizjOCagCg/rNZkaExhimHGXRjSmhONWAs4yKtzt2ZER5eQBq8hZ785M7dN/RBBKn6FO
	 +dypQsMf2zVPICvyrwL592NuLHBar9EZAEyT6BrRyYY26TxMkSTvtztN7RotNrlTN7QJo
	 I9DwA7KAknlp4uwX6GNX/N/sDOGNu3QQofHPJV4kiPkl0OP8BmhgSwFQQuy+LSggwfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=epO44nguKeOQQCjQUMlL4Yq07v1OlIx6nj2eYc7j0sg=;
	b=Xp2is2c+KgIfLV/QGCowgvRvTWduHk+P7ga/8YBnHiDK2OcVvCG3DI5jyhZypTBCqgRj
	 pXTrCvYqNIeWnBFcF1eggeVGfhEN9SdII0koxnqNKebTnt0iP5/iYBQo5WHpABkW4+par
	 Bu18KBDgauA4gsk94Zlno7rcWhjqVrhhqlURaoE+Dy/ll/H/WSFEuvhwcw94WmyM19sLy
	 4FW4blJ3ztSzTotyTxQ3GC/fTonzwB962Nsvx5SLx9U2qfa6vwvaUoUlIEKB4t3oJIjeb
	 5Dv/PZVsv13VGaJ+yjkXvakUn/Lwq3mtY8WU6DR7650Q/4y+hfg5qvKfpK9xT46lY3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pARMttdt;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA3606A322
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 03:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45FA3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pARMttdt
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5364648ae07so32956391cf.1
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 20:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792986272; x=1793591072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=epO44nguKeOQQCjQUMlL4Yq07v1OlIx6nj2eYc7j0sg=;
        b=pARMttdt5sIHUR6snNn2w+A8GAyfTtIb+GNhfxyv9r2teQJoncLOOzbyLmIelYfiVF
         1qEDkiXunBGuxl3tJ7D5/ZfDRbWSi/N9Yj1IGFHKPaThtmpsZjzAMZFXEEc7co7PHaGY
         pZX/d00f7g79OOOltSthIDkHQyUM8DxSaOC5mlrPgNa/lMnUCIF6s/OELJloKQHOod52
         xyzg0SKCdw07T1XBvDIgzvOS6jLkQHy0lTpWuSCTuKT8/8CDSfVX+bpujjd3T9mFmSwu
         UJ41d/HqW5aMYQGHEotLhY6aqx5OaWIkUlFAHnyUfguFdAjIXGJ8I9Xb9ZwK4hQLpX9I
         cs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792986272; x=1793591072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=epO44nguKeOQQCjQUMlL4Yq07v1OlIx6nj2eYc7j0sg=;
        b=S5RwtQatADCuf/rh7dxOp1c1/7EHFJL0QlF+fDLrz2YZBxl4mUOHhS+p84S9OlZC1P
         7prj84zRhx3VM+8dOjriP//Fk3xUmdgS/elqpB/I5+6ktCX7ElnyCrlCMTwxO1OspD2r
         ZpuYH/ckyJjnPKI2G5m3+EVEPIKLjAGGj+FFdMtv/ZQxs/6y0+3n5c8R+gjh/WBlNigM
         7/vXz4r9nmCNrAb6fDDLzVODl2Dp6TpVMn1r12HMAoJtezFgAL3eJCxLdK5CjkP+e2op
         tJW+QEAcBqWBXLMVISZlM/KCO9/IzJwUZ0U3dwWO5f8y8UR9qHIpnEK8nVmFSL52lgyQ
         tJBg==
X-Gm-Message-State: AFq9FYKYd/n0t/v31q8zesgy/rC2w8P/vh/qHkxVuQcQ7/OZCZ023BO7
	kP8ptl114v3M8Y7tkyzTtjHJ7rpJf5fsUZPrBsDNAvbvpOafo22Ut3GS
X-Gm-Gg: AYBFou1Xt276Nm0ZcCcaD1ZAs3fV5ogQqiUICQ4zGjjbInKd5aKvwoR9BZ9jMo9pCLf
	jHx1dW5GGzgYZBL/aGJ1RBlAvKjcRZuIJZAaPrCMjq5rbxNXHe+dSDGXSBjDw9dBli9aL13unwn
	up12Jz/0Y1fTSLA+cfW3mKJtra/n1wLxufBaOWKjONN5LsrlMabe/ppX//opCqAXz3jiPW+w7I0
	LWzrh4C7ihY3a0DjBnX6DjuAoAzoWSJnfBP0clHMd1j2CITQtQhhXBjV/1tx0mkMIq7Xl6fC+CQ
	t0SmaXfjBs4HVtd/9RiM6ZTxv8ZA4pSNJGhHEqk3CyO9EHv84nTN0UnVzPId/Me0BZH+o/HgDgY
	5ZARfwI3kl/InjwsD4SRNfiPecrXaXFEGpa6o3QixbgGIqlnc6zVoh35LGqA7oOzAM0bVe909ir
	oBiBLE8upXsLFSgbL2Z2SlHcqFsbAx2TrtQbAlNiq3EpDXxtaEuUTzUpgIo1mm3XGsqRaQxAtzA
	FPQSyzySZLSVhNbyXjiFQNK/fLxuFO85qXCsAN1n4PgXIpOGM3pSBZyyeLl4zWPUjWQXq109C4L
	gM6om1GfjYaC4ahnpV8ur6moN9wTn1paOQoKXDMzeX+TDnUAlO0ogK50aeD/8OK9SS8JcpXvXtT
	KXUxDNA==
X-Received: by 2002:a05:622a:64f:b0:535:13c1:ce94 with SMTP id d75a77b69052e-5383b5d830emr85091791cf.38.1792986272132;
        Sun, 25 Oct 2026 20:44:32 -0700 (PDT)
Received: from paul-white-HP-Pavilion-Laptop-15-cs1xxx.mynetworksettings.com ([2600:4040:ad65:1c00:4cc4:d0be:4ab6:9a0b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c5273sm46202121cf.9.2026.10.25.20.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:44:31 -0700 (PDT)
From: Paul White <paul.white.kernel@gmail.com>
To: anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Paul White <paul.white.kernel@gmail.com>
Subject: [PATCH 1/2] KVM: riscv: Eliminate redundancy in get_reg function via pointers
Date: Sun, 25 Oct 2026 23:41:26 -0400
Message-ID: <f7fcf15c1117ce734247cf951c0afff1f5eb54c8.1792982932.git.paul.white.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792982932.git.paul.white.kernel@gmail.com>
References: <cover.1792982932.git.paul.white.kernel@gmail.com>
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

The original code is essentially asking: for each possible floating
point mode, ask if reg_num is a status control register or a data
register. It is redundant to ask those same questions for every
possible floating point mode case.

In order to only ask the "status control register or data register"
question once, the variables in the status control if statement and
the data register if statement that would be different depending on
the type of floating point mode (for example,
KVM_REG_RISCV_FP_F_REG(fcsr) would be KVM_REG_RISCV_FP_D_REG(fcsr) if
the floating point mode was double) were made local variables of the
entire function so that once the cpu passes the if statement inquiring
whether it is double point mode or single point mode, all the
variables that change depending on the type in the status control if
statements and data register if statements will be set to the
appropriate values they should be when in that mode before/when it
enters the status control and data register if statements, allowing me
to only have to ask those questions once and creating a dynamic code
that changes based on the information. This results in a "asking the
type then asking status control or data register question once"
structure rather than a type-questions, type-questions redundant
structure like before.

This results in faster cpu execution because despite the longer lines
of code the cpu has to make less decisions, which saves time in case,
due to its tendency to make assumptions about what an if statement will
evaluate to, it has to backpedal because it realized it needed to go
down a different if statement/path. Finding an address via my
bare-metal approach is also faster than looking up an object properties
and then an array. It is also more maintainable in the future. If the
original code needed to be changed, you would have to remember to do
the same thing to both type blocks whereas mine would just require a
change in the beginning if statements. If a new floating point mode was
added you have to ask those same questions all over again, which may
make the code longer in the long run.

I also renamed reg_num to token_reg_num in my code as I felt it made
it clearer that it was the register number the application wants and
requested in a token. It differentiated it from the many other
variables with the word reg in it.

Signed-off-by: Paul White <paul.white.kernel@gmail.com>
---
 arch/riscv/kvm/vcpu_fp.c | 70 +++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
index bb11e6757d34..16999a5c45de 100644
--- a/arch/riscv/kvm/vcpu_fp.c
+++ b/arch/riscv/kvm/vcpu_fp.c
@@ -83,41 +83,53 @@ int kvm_riscv_vcpu_get_reg_fp(struct kvm_vcpu *vcpu,
 	struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
 	unsigned long __user *uaddr =
 			(unsigned long __user *)(unsigned long)reg->addr;
-	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
+	unsigned long token_reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
 					    KVM_REG_SIZE_MASK |
 					    rtype);
 	void *reg_val;
 
+	u32 *fcsr_addr;
+	void *f_array_addr;
+	size_t byte_offset = 0;
+	unsigned long offical_fcsr_num = 0;
+	unsigned long offical_first_reg = 0;
+	unsigned long offical_last_reg = 0;
+
 	if ((rtype == KVM_REG_RISCV_FP_F) &&
 	    riscv_isa_extension_available(vcpu->arch.isa, F)) {
+		fcsr_addr = &cntx->fp.f.fcsr;
+		f_array_addr = &cntx->fp.f.f;
+		byte_offset = 4;
+		offical_fcsr_num = KVM_REG_RISCV_FP_F_REG(fcsr);
+		offical_first_reg = KVM_REG_RISCV_FP_F_REG(f[0]);
+		offical_last_reg = KVM_REG_RISCV_FP_F_REG(f[31]);
+	} else if  ((rtype == KVM_REG_RISCV_FP_D) &&
+			   riscv_isa_extension_available(vcpu->arch.isa, D)) {
+		fcsr_addr = &cntx->fp.d.fcsr;
+		f_array_addr = &cntx->fp.d.f;
+		byte_offset = 8;
+		offical_fcsr_num = KVM_REG_RISCV_FP_D_REG(fcsr);
+		offical_first_reg = KVM_REG_RISCV_FP_D_REG(f[0]);
+		offical_last_reg = KVM_REG_RISCV_FP_D_REG(f[31]);
+	} else {
+		return -ENOENT;
+	}
+
+	if (token_reg_num == offical_fcsr_num) {
 		if (KVM_REG_SIZE(reg->id) != sizeof(u32))
 			return -EINVAL;
-		if (reg_num == KVM_REG_RISCV_FP_F_REG(fcsr))
-			reg_val = &cntx->fp.f.fcsr;
-		else if ((KVM_REG_RISCV_FP_F_REG(f[0]) <= reg_num) &&
-			  reg_num <= KVM_REG_RISCV_FP_F_REG(f[31])) {
-			reg_num = array_index_nospec(reg_num,
-					ARRAY_SIZE(cntx->fp.f.f));
-			reg_val = &cntx->fp.f.f[reg_num];
-		} else
-			return -ENOENT;
-	} else if ((rtype == KVM_REG_RISCV_FP_D) &&
-		   riscv_isa_extension_available(vcpu->arch.isa, D)) {
-		if (reg_num == KVM_REG_RISCV_FP_D_REG(fcsr)) {
-			if (KVM_REG_SIZE(reg->id) != sizeof(u32))
-				return -EINVAL;
-			reg_val = &cntx->fp.d.fcsr;
-		} else if ((KVM_REG_RISCV_FP_D_REG(f[0]) <= reg_num) &&
-			   reg_num <= KVM_REG_RISCV_FP_D_REG(f[31])) {
-			if (KVM_REG_SIZE(reg->id) != sizeof(u64))
-				return -EINVAL;
-			reg_num = array_index_nospec(reg_num,
-					ARRAY_SIZE(cntx->fp.d.f));
-			reg_val = &cntx->fp.d.f[reg_num];
-		} else
-			return -ENOENT;
-	} else
+		reg_val = fcsr_addr;
+	} else if ((offical_first_reg <= token_reg_num) && (token_reg_num <= offical_last_reg)) {
+		if ((KVM_REG_SIZE(reg->id) != sizeof(u32)) &&
+		    (KVM_REG_SIZE(reg->id) != sizeof(u64))) {
+			return -EINVAL;
+		}
+		token_reg_num = array_index_nospec(token_reg_num,
+						   32);
+		reg_val = (u8 *)f_array_addr + (token_reg_num * byte_offset);
+	} else {
 		return -ENOENT;
+	}
 
 	if (copy_to_user(uaddr, reg_val, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
@@ -144,9 +156,9 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
 		if (reg_num == KVM_REG_RISCV_FP_F_REG(fcsr))
 			reg_val = &cntx->fp.f.fcsr;
 		else if ((KVM_REG_RISCV_FP_F_REG(f[0]) <= reg_num) &&
-			  reg_num <= KVM_REG_RISCV_FP_F_REG(f[31])) {
+			 reg_num <= KVM_REG_RISCV_FP_F_REG(f[31])) {
 			reg_num = array_index_nospec(reg_num,
-					ARRAY_SIZE(cntx->fp.f.f));
+						     ARRAY_SIZE(cntx->fp.f.f));
 			reg_val = &cntx->fp.f.f[reg_num];
 		} else
 			return -ENOENT;
@@ -161,7 +173,7 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
 			if (KVM_REG_SIZE(reg->id) != sizeof(u64))
 				return -EINVAL;
 			reg_num = array_index_nospec(reg_num,
-					ARRAY_SIZE(cntx->fp.d.f));
+						     ARRAY_SIZE(cntx->fp.d.f));
 			reg_val = &cntx->fp.d.f[reg_num];
 		} else
 			return -ENOENT;
-- 
2.53.0

