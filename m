Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227407;
	b=2OaNlnvCfgC3Pwgx1KZSnfKEdQdkStac6IGLIoEGu03bj8R9ODjhiYElqFwkmeIQ+HcS
	 P2S+8+zZ+jbYZWK1T/dw4Q1QVSTxrnKGu/m99PFudtA4QZHyx1D0HMUgoL2UB4+ocUH8t
	 wjDF/QBSUduaMp6+WIYWarjZc3asEIrHtj4PhMrha2ZsieyaIFOmBuZl0eFWhP4kCxZ+g
	 AjoZ8yAqf43x3UlEjr5bUSspQDwQe9UygykmvIVYfyXt19OsFaTifpm3hPeJcxDG65IHW
	 ll5Se7gsRdQ5a4YMhUn4SYzm8pG5lf2QhFVHqR+/dhvRLMcznCdU1UOHa5sZj+uivLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qy3A1Vkwd/cDXLut21ZiXnCP/BKq6y64SvmrcYwH9Tc=;
	b=PxW8JsBpAVE4O3w1JcLoor9wEaqf+X/LZVwQc8oBL8fGCT8zg7keSWiKst4DRcF6JoQV
	 ++9U2oRCNz+Z+YTvIvpZy8EgB5lsQOGCKJkUp41/oSxWmPWyYrPZuXv2r537VJMKPypG5
	 1ffxA/UFs6O+0IrDYBUNnf+93ficEvNA0dCAVHv+wCy731x6MyHfRjrTF984tG9M4mzn4
	 yP+b/CORyzQXxrVtZAIILSyBsf1S/+NBtHNPjYaA12Scq0vVt0SRBpF1yKSKrV7+Cd/7o
	 i/dm+524Ee5TN1kwo7+L4XX6F1ipwZjyGE+PJCFNsgX9Nq8YsuLpKst1GPiyAnlGeig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YKfTsW0W;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E070606A32F
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 22:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E070606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YKfTsW0W
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91befbcad6dso22386876d6.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793227406; x=1793832206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qy3A1Vkwd/cDXLut21ZiXnCP/BKq6y64SvmrcYwH9Tc=;
        b=YKfTsW0WhzHsSvgIRpwRO4gmA5dPuQiVZilgiylIQK+wa6jofYHO6Cp+GEcBEI6JsC
         6ME6fh08RtefwmOh9625NhVq9JqHOcYuvzvar0M0HImQBqxrtcyisPpVy5OxhsfXw2YT
         xUrT/VXZU5sVAfQXa0q0WXjSS+nvDv2LRap9cA6+TcKzS8BglWJ1+nqSbuzPEcIMJbOs
         Dnkrh/zPQBbUw65w9R2lAjwE3qQaGWXtaj0NqDbExqTaMuLTMwx6etI9S1ZYWrVgax7q
         W/fQaJi3Pmooa294lcu4yQfRl3KfgBJSFsAqrWrDzJEaotrwtUO7XHBui5dbiP9+oYWK
         CqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793227406; x=1793832206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qy3A1Vkwd/cDXLut21ZiXnCP/BKq6y64SvmrcYwH9Tc=;
        b=NS0Jp8AUvYEeV2yasFfuf9uzpvuleDkum7Eb+hzrW1ACAiAzi7OOYCUfBSMsUXRmh8
         gUZFb18/6pnqwb5FKowiPPwV6NHP3GvhvC1b1SoQiPqnGp/FVErTGSLL5hecOUELSSQp
         7qs7+zdq6x1L4HTUUPEEHe0AHiZ6Wf91zG5wUmnhWPPqehKg4viu9sIJMYYDQKqO8KPd
         BiT5ubDw5Eem6ieIuadZEXXtesHNaw12kwOzNwmBjIbgM54TsxJTYWS9u53a6ueNLSdy
         VH6rgosO4hsTH3JxKC6qSPm5Z+VcSWyBe6zucA+7U+ui06vq6Y/4r1SmG//uL/5XCr9b
         SSRA==
X-Gm-Message-State: AFq9FYLpaIuuZxKi7z49rMdS3aoMuAeoIvuYR1Mju6y5uQmsY4dJY03e
	TB6vIv0lAOtcEZdUFeKMR17zoSfjnLbd3wqBGiWqWqLjqlASsyCY+FHF
X-Gm-Gg: AYBFou0aNfq9HKHFz7SEnM4c8UlwCjkagckl8OKTz1VUq+c3lfj/xVDaC/Bln6LtqdH
	/nj7r+al8GbmMvEkh7cMMDUcuhURFnbXKOSTMPIk/iiVZb6r0vTXFVmA8WJiEaMvSuQELY3CkVA
	5ZMHelBLrjl89weBeOwJbsUFlIcaJRhq3q790ciY2gX9RGyU98+D4NOvpCCyEJ75MD9/OZO3CGG
	wzBQmPjzSgx95FoX+kQW1M/cil2WRdAkNWOlcT66nxuk7PYb8SVeNqKE7QoZi4L3KDuFZRJHtCt
	JweSHDeEMaUr8bBdoB36sAd9Np/GPwmwu1tBv3C/0i6BOsYAMoEVOaFXwBCmn1eEQ8/wt2BXsnv
	sF55JhEaWxyAe+Ki4miu5QbKSBjG0i5bPJHBQaMhqmP4sudyOakQIXfwFnloseg2nbQabQVugTS
	2CBSQlodRykPuIoY6G+K26D54UKlmKN3XiIg1kU0ridRfLFptwNJEQPd5WyN9ROvXqBbomVEX2+
	36SgnDYx3r4KJktAqFa50n2JCiGvgK4ClOF1Fsefrg12kcv7DI2rMxQ6oTwDmKEfud3K9Ycz8ds
	ju4kmwtn62fn8ISEFctokkahjU0VEVFGpqTIJM2HKS0EBS1RYhQH75ivsJqWyICgOrLc/A6X0s6
	tFtqazIB4Xwye/EvLJZqWy9PUCSRsXlLNLcVOB1BIY/wMQcsnoOo=
X-Received: by 2002:a05:620a:2629:b0:93e:c12c:9b77 with SMTP id af79cd13be357-94408d68de4mr575691585a.82.1793227405973;
        Wed, 28 Oct 2026 15:43:25 -0700 (PDT)
Received: from paul-white-HP-Pavilion-Laptop-15-cs1xxx.mynetworksettings.com ([2600:4040:ad65:1c00:b8:5aeb:4bda:886])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0787d96sm1370085685a.28.2026.10.28.15.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:43:25 -0700 (PDT)
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
Subject: [PATCH v2 1/2] KVM: riscv: Eliminate redundancy in get_reg function via pointers
Date: Wed, 28 Oct 2026 18:43:08 -0400
Message-ID: <072bcc0994a5d2a0c21778a7a6f9e395395535c6.1793223506.git.paul.white.kernel@gmail.com>
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
requested in a token. It differentiated it from the many other
variables with the word reg in it.

Signed-off-by: Paul White <paul.white.kernel@gmail.com>
---
v2:
- Only checked whether size token listed was 32 or 64 bits, which could
  create/allow tokens with mismatched sizes and types to pass.
  Should've checked if token's size was correct for its FP type. Did
  this by replacing u32 and u64 parts with byte_offset because it is
  mode-dependent local variable.
---
 arch/riscv/kvm/vcpu_fp.c | 68 +++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
index bb11e6757d34..da4f83be6b19 100644
--- a/arch/riscv/kvm/vcpu_fp.c
+++ b/arch/riscv/kvm/vcpu_fp.c
@@ -83,41 +83,51 @@ int kvm_riscv_vcpu_get_reg_fp(struct kvm_vcpu *vcpu,
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
+		if (KVM_REG_SIZE(reg->id) != byte_offset)
+			return -EINVAL;
+		token_reg_num = array_index_nospec(token_reg_num,
+						   32);
+		reg_val = (u8 *)f_array_addr + (token_reg_num * byte_offset);
+	} else {
 		return -ENOENT;
+	}
 
 	if (copy_to_user(uaddr, reg_val, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
@@ -144,9 +154,9 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
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
@@ -161,7 +171,7 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
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

