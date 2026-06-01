Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD039BFE5
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309600; cv=none; b=VEENt2O7f69xpFjZL/a3V5+x5zj9CB4NM4mfWkUDjj4d8TFCcvpouPqX40hXI0NYFcMQn7xcdXJNFDDWLh2gZNjV+Qs2S2XrQGDT0Pfhholn197a9wq8+KBFYwfmHKdIOzXkawEPyS+NBk79rJYpAfZSSFOylaLGCTRO3J80d+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309600; c=relaxed/simple;
	bh=gfnczZN+h+rWjSUF0BJooFipVgVWUQb9pSCmrwwRlAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoUDOXh3SNIB5ksLhclzKiXtku4Mxb1VZ7kRNffBN0zEbemVi6bE1jpddfRbnyQwK9a2wI2f5isPKg44pvzW5V2c5l5vesBWfvgoV2J7PUX7tHpr3uMegHtWj3nCDcUOJeN/h1bncs7vL6DisNqpmCM4MB2/ehBEuptfRLpVxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=U/7EQ9hK; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U/7EQ9hK"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-136b46c3540so9939857c88.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 03:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780309598; x=1780914398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkH+rbPYFBQOwWqBxudVceNf6H3KI5FVfOpH4WOZPq4=;
        b=U/7EQ9hK7nrN68oCR9unCLVDVO5Vgw37pQgKeH0SKTfeF48RT1z29TSQO6+Pz+3kpY
         5/MZRuwXxMFjRfcF6euovDyacF1e0VSHuywbGupa3RoeOAuowGDp+9k6gwjh8Eo1Q7dp
         RZfiVdc2oa6y8Dh4n4ANcmP8Mkg/Kd9cZfYg5Iuk981vcqhLgQk0vi8Yo9iR7oYgr4zd
         U+JOzfP1IBB6OaS7BZIETtlgU7VfhYURyvfGkBej5Xa2KsIG1CVak6Ew1eKgdmP0AnmN
         w9/AB6t311P1Rcz/D26ksKZXtjAcGF+Bg+1JTyWJNDfNfjq55IBbA06Ulid3Qls/c/ok
         Ch5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309598; x=1780914398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UkH+rbPYFBQOwWqBxudVceNf6H3KI5FVfOpH4WOZPq4=;
        b=LgXwZP+clkVIsUP4zrIut/14Jn/rWme1cgzD+W/32OEdL2cIubvsBnfsUbqmOXHMaW
         HLTnCJMweu/2Uuyx4U8IDRm31tgnZX4zhQ8j0P6eI3mM9MlsyvwGCxx+BHh+TdwKH+Sb
         qelWH1TnUfxKazrAJ5D4Ec4XEjOa9Ly8X5d6/33jrHTHCBjTBlGI0HGH4rkRZMKk5vmv
         82ieAXLgS4rnCKpvoYenN6i53qfp8TmHohblxzqh3/liV+j/jf8p2NqBtf3A1kgpms9L
         F4MwJ+NhQP2Qqfa8G0hBUho7uk+XLGncCRATWMtNJfFUW2jtRe2gy1AmKIOiEMJB440L
         7M6A==
X-Forwarded-Encrypted: i=1; AFNElJ/0EkFtT1alfyOsm4ymYvgcwAbkQJANvadnInBOnHr+HtQGSTEQzJNQjX2whcp3i3SxgGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAB5tMA5Rph9CnYbm0JxTvVyAL03JvkUuc9my79wmRtw6w4VnL
	faR+pUxXat+rfIvqD3HBZK+LicH4rYJn7oyFqC3Jc3PU7SWtaWlGZeFoheL5RZYdTlo=
X-Gm-Gg: Acq92OE83PLaytqYHUxzXaL6Fgco5D2vRnXK5RCT56T2unyCr0cbeRL25U0NXQtLykT
	ovy7DYTgpUgaNSfginAShi3sjuyP9QhDIfYLJwDsCoNJJ0+v2r9FOvW07ORDHz8EbGngi1tqwrM
	e1HaG2XJ3o26ksDz/uNOAiGEfCkziJrjgQUPiaFu7cP7+ucx1A0uqS08sf7AimwyrvHm6PLIHTc
	kCIBA2ybZ+fZxPTh3CccgP9reR+Av7w2jCtEIWUumoeHJoKHji96OX9ToZiqUNgWg90PJIlre+3
	ToUAszQ0jLWwQ5/4rWwbJud/EqC+Hdr6qW4Us18YuvNkYuyzStbIyPNgpjrprS6hPk9yws0Sz3G
	Smb8qCcirOQ54P5mbzk3bulcDkpcZW5oL9zvwST6Grnz8vlYMNzVLqneXNIx6hT/Sv1U06ns9Y9
	l6TDqpi3fgKSX0o/SZORbWUU2t74outJcLC+pkUhPrZZ9mkkdStyqPBA==
X-Received: by 2002:a05:7300:6c84:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-304fa67bcafmr4315278eec.26.1780309597890;
        Mon, 01 Jun 2026 03:26:37 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b9be7sm8176001eec.27.2026.06.01.03.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:26:37 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 01 Jun 2026 03:26:24 -0700
Subject: [PATCH v5 3/5] KVM: RISC-V: SBI FWFT: Fix stale feature exposure
 after runtime extension changes
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-kvm-get_reg_list-v2-v5-3-415d08a2813b@sifive.com>
References: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, inochiama@gmail.com, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780309592; l=3662;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=gfnczZN+h+rWjSUF0BJooFipVgVWUQb9pSCmrwwRlAE=;
 b=+qL9SVI0RXfE0tqzldQtvBLEC2mHZjs6gsmQCiAjT050VaVqPB7Gkj9XL3XjEOBKONYsNXAwg
 xUJ+NRYAep7D+DmPqqrsPG6bSMojxfLyj5wI5WYNqJxBrI1Z/pit3jK
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

Fix a bug where FWFT features could be incorrectly exposed to guests
after userspace disables their dependent ISA extensions at runtime.

The 'supported' field in kvm_sbi_fwft_config was set once during vCPU
initialization based on the initial hardware/extension availability.
However, when userspace subsequently disables ISA extensions via the KVM
ONE_REG interface, the 'supported' field was not updated. This caused
the following issues:
1. FWFT features would remain visible and accessible to guests even
   after their prerequisite ISA extensions were disabled
2. Guests could configure FWFT features that depend on disabled
   extensions, leading to undefined behavior
3. The static 'supported' flag and the dynamic supported() callback
   could disagree about feature availability

The fix introduces a two-layer checking mechanism:
1. Add an optional init() callback to the kvm_sbi_fwft_feature structure
   for features that require hardware probing during initialization. This
   separates the one-time hardware detection logic from the runtime
   availability check.
2. Add runtime checks in all FWFT-related functions that call
   feature->supported(vcpu) if the callback exists. This ensures feature
   availability is re-evaluated based on the current ISA extension state.

This approach maintains the cached 'supported' field for initialization-
time decisions while ensuring runtime availability is always determined
by the current vCPU configuration, not initialization-time snapshots.

Fixes: 6b72fd170592 ("RISC-V: KVM: add support for FWFT SBI extension")

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index aee951f2b8e6..ab39ac464ffd 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -303,6 +303,8 @@ static int kvm_fwft_get_feature(struct kvm_vcpu *vcpu, u32 feature,
 
 	if (!tconf->supported || !tconf->enabled)
 		return SBI_ERR_NOT_SUPPORTED;
+	else if (tconf->feature->supported && !tconf->feature->supported(vcpu))
+		return SBI_ERR_NOT_SUPPORTED;
 
 	*conf = tconf;
 
@@ -433,6 +435,8 @@ static unsigned long kvm_sbi_ext_fwft_get_reg_count(struct kvm_vcpu *vcpu)
 		conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
 		if (!conf || !conf->supported)
 			continue;
+		else if (conf->feature->supported && !conf->feature->supported(vcpu))
+			continue;
 
 		ret++;
 	}
@@ -455,6 +459,8 @@ static int kvm_sbi_ext_fwft_get_reg_id(struct kvm_vcpu *vcpu, int index, u64 *re
 		conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
 		if (!conf || !conf->supported)
 			continue;
+		else if (conf->feature->supported && !conf->feature->supported(vcpu))
+			continue;
 
 		if (index == idx) {
 			*reg_id = KVM_REG_RISCV |
@@ -490,6 +496,8 @@ static int kvm_sbi_ext_fwft_get_reg(struct kvm_vcpu *vcpu, unsigned long reg_num
 	conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
 	if (!conf || !conf->supported)
 		return -ENOENT;
+	else if (conf->feature->supported && !conf->feature->supported(vcpu))
+		return -ENOENT;
 
 	switch (reg_num - feature->first_reg_num) {
 	case 0:
@@ -527,6 +535,8 @@ static int kvm_sbi_ext_fwft_set_reg(struct kvm_vcpu *vcpu, unsigned long reg_num
 	conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
 	if (!conf || !conf->supported)
 		return -ENOENT;
+	else if (conf->feature->supported && !conf->feature->supported(vcpu))
+		return -ENOENT;
 
 	switch (reg_num - feature->first_reg_num) {
 	case 0:

-- 
2.43.7

