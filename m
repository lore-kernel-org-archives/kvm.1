Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227409;
	b=el04dSrKCXT8AKSGnQN0OCKnIcxFmKeee/zQYrkxepd9wH7s9r1ZfLmIf5u7+VqzzTe2
	 lG10HHaCyewNyf/qaYU9OzffrEaViUboou9fhLX4SfSXzsYMdxK0KwOfhnc5TMpDDl8Qr
	 jQxxCdtmCE53V0UzM16UvcsKiBJjwl9WkRPMjNUjNuMMe+Ny75m1ClDf96kN3mD4P2lJY
	 b5mpzbgWS4CC8z4R3JOecDNYsfv85S0fYoE6GlXQLlHohqrO4kopU3/MkxwimCBDNLMxr
	 /HS5Xs5OpKuhh9pPis/G78QFrATiEl1AsT5ySzejRA6slt5t9sHrrsuqOHdoocNZvnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dAZhtXQcONVBEEfX+FEqGwIc1UuckqT1BoM+QvmFfV4=;
	b=ucMmi6ytDZoZMrTFKdVuoIEqemRbBwNFTl1ULUr2lv7ptumLrabW56im101NFUXwb0Vz
	 xlm80tRVOeEN/oJnU1E+OIry9TasTgFh3fDFriB3iePBPVWC3dFe+PoQ3DzyqnhS7sZUT
	 PXSHYylgsYhMvBikWmdMcFfkW+FazGMA/7qpJqTBeNlH3LqyasY7viMyOceuAN9K4wZfm
	 IhJLH+Af0/lM446wU4ezJraoUPUdyoeP+MylRMNDClvOo31V846IhcYUlLaMvTeVgD4gG
	 A0wW0yiK57dd4FSJYNTdfFSesQE9QdAvBERPVUgDyQnvyY/5RRWH+YH897+xmn2FBhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDfAoReG;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9060A2609
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 22:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FC9060A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDfAoReG
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93ead211f14so16844285a.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793227408; x=1793832208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAZhtXQcONVBEEfX+FEqGwIc1UuckqT1BoM+QvmFfV4=;
        b=aDfAoReGszCY9w4sxolGpn+BnWh4d9neMfgdGDzZWuH6evLPJkLvIeM0fJaDtXvgTN
         Wv0w1TWqbbW4tF/rXcLGRL97XViGSqAKPWeXrYWXUS8ixyhLyyfwZdDZJPTphuScVpL2
         uCKLYcI8yEKzmarrVeflOdDUZ5j2hd5SZGZfktUV/FPNXFbvEMF48PRzE3F4JLBhefo/
         DSSWUBbNE1iqhla/+4PU/5A31q0oaFSd1A34eUmx2rzJnx7w01ws1+75wY4sKc+CRJFX
         F0I6tYB/9f6QRTawx2fzKFbEBqGmj4CFP5LcI+suJTrk18bHluD/3iGzTXIq3SqQnqK+
         1LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793227408; x=1793832208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAZhtXQcONVBEEfX+FEqGwIc1UuckqT1BoM+QvmFfV4=;
        b=sndZhJwPAi4dD9Q1jfKGvb1v8E9otX6TM/pEZsYtgmUoTTmwHKJDQFr1YXqoPpB341
         OXkYJ0ryFto1q5LU6FX+bFAKy2ZmT8V7/bgYwB0m9cLSbThEtkWZa+m0/eMPL2XHWEMu
         8XERzzMwco265e9W9SV+1NVQj8R8lX7St2AP8Cvk28d59UWvqYatHjLhBH99gemCUyLH
         C5YseAK8g655b18FQ824YF1iDkLGYkh954xgWh190PjZZ56ILbDG+p/mZ1e6e4pZSxbh
         flpG94+2KCNbCeJRlvba1NjErhTyd5MStSYJkAndXQnrq+oX9b4kQBLFuBf2LKgmiFFQ
         ZNNw==
X-Gm-Message-State: AFq9FYLwFoxqVe3FOZPtoD3iCVxZ3ruJDFYfvlDyyHDI2xP4oDqTH6P+
	gT4hrlUFG4eYDLoVA54WDN/hqB2jAEypaGMiq0OdfLsBcmvzKun9Apsb
X-Gm-Gg: AYBFou3CrxcTNd4XBFw12CsOtEIlh/nJz1j2QXyPMfZxT/oPKAHn/7wWGoKiXltJrr6
	HyUr7dpgzoDqxH8Gw76uOAaqxc/eilwbtkzwEoBsl/7YzDWQ7lO4n+NrTnAvqDrXQqCj7PthtGH
	H2HyuH51kgl5S3963y6+7Ub1TZel0MmH8dmuBHlION8jf0izTqbYnP3TSNEL6NRJEw0fn0Itgmt
	r1ryHG1KDREi7Ec1gobLbc5FRgRykg39rvdQ+I7NNda6Em7w9SKT1+ccFyXYB7mr6a6ZG7lffZV
	RS55bHwq0KqfzoxSFzspMUMAMW7vEHA8bLvfpgryzyACpQUMaBzF90fGmtez2A6WDFrYGtPaCj8
	8RdCNguNDi//s/CQHfKsSaZ90tksTA4MZJFa22VB+AqfFZptpbbJFqJPS24b6ntpQ8gCTVsjWYa
	QDEVq6wYj4C6D6S8m5oSJSyjCkyHIXMOhWJxFP/qCfJO2ijWYPkZ8J9WXm79ApJAhCye0vUFcLP
	6mgDCC/C22YHhr9XNmDy+22giLRvnZtNkagweCvRTFabPAjlSRkPKCvP86VMOnheuUxMEWGZ6p5
	0GD+x2Pcr3cdivGM5mZ22gZ99YkQMN1o4WpI6euBm0hCjv7o9FAcAvYaXb0PPLixms6XRXflH1j
	/bts0bYQnswPBf2Pybt4AHjD727nreL2x9BWv0LA0zOHRXyZSicQ=
X-Received: by 2002:a05:620a:410f:b0:93e:53db:d59e with SMTP id af79cd13be357-9441338b4cfmr150529085a.23.1793227407492;
        Wed, 28 Oct 2026 15:43:27 -0700 (PDT)
Received: from paul-white-HP-Pavilion-Laptop-15-cs1xxx.mynetworksettings.com ([2600:4040:ad65:1c00:b8:5aeb:4bda:886])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0787d96sm1370085685a.28.2026.10.28.15.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:43:26 -0700 (PDT)
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
Subject: [PATCH v2 2/2] KVM: riscv: Eliminate redundancy in set_reg function via pointers
Date: Wed, 28 Oct 2026 18:43:09 -0400
Message-ID: <7290d6f5bead955e7a4bcb5b7aba97962031f0cb.1793223506.git.paul.white.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793223506.git.paul.white.kernel@gmail.com>
References: <cover.1793223506.git.paul.white.kernel@gmail.com>
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
requested in a token so that it can write data into that register. It
differentiated it from the many other variables with the word reg in
it.

Signed-off-by: Paul White <paul.white.kernel@gmail.com>
---
v2:
 - only checked whether size token listed was either 32 or 64 which
   could create/allow tokens with mismatched sizes and types to pass,
   but should've checked if token's size was correct for its FP type.
   Did this by replacing u32 and u64 with byte_offset because it is a
   existing mode-dependent variable.
---
 arch/riscv/kvm/vcpu_fp.c | 62 +++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
index da4f83be6b19..b8e89107b6c3 100644
--- a/arch/riscv/kvm/vcpu_fp.c
+++ b/arch/riscv/kvm/vcpu_fp.c
@@ -142,41 +142,51 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
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
-			 reg_num <= KVM_REG_RISCV_FP_F_REG(f[31])) {
-			reg_num = array_index_nospec(reg_num,
-						     ARRAY_SIZE(cntx->fp.f.f));
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
-						     ARRAY_SIZE(cntx->fp.d.f));
-			reg_val = &cntx->fp.d.f[reg_num];
-		} else
-			return -ENOENT;
-	} else
+		reg_val = fcsr_addr;
+	} else if ((offical_first_reg <= token_reg_num) && (token_reg_num <= offical_last_reg)) {
+		if (KVM_REG_SIZE(reg->id) != byte_offset)
+			return -EINVAL;
+		token_reg_num = array_index_nospec(token_reg_num,
+						   32);
+		reg_val = (u8 *)f_array_addr + (token_reg_num * byte_offset);
+	} else {
 		return -ENOENT;
+	}
 
 	if (copy_from_user(reg_val, uaddr, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
-- 
2.53.0

