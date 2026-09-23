Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5265326B8
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169680; cv=none; b=hQM8HuD+GpL7hBkdAdOZ6pYBbxt70r+ENBSlEvsbYpBm1v+dRVPp/TvemEXCGZXTNi3NAvL5TGFUpRoFPS16ggVPHLFzNwwZCdG0TeuEXSmvPbiBUou9Y+FKRZz2ljeKWDZjB8mtAgfhwvpWp5LGQ1Dk5FWOdzdJaGMcvvTyw0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169680; c=relaxed/simple;
	bh=YuEx8RuWPYGUpMhAjYFdyyFPadMa1hs5LDkA+3BwS1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWales7xVN3Kld7zSDQcGu3KKtLJWMxY21LtEckLsPpULLcIYRDYzQSO/nFbL4xTC27B7c/21+ztL+AWMOiUofb/AEY5LtLNvWbO8377Ned8zPvgg1C2NfKKySLvwFD+FCBwCeeS/PTza3qmAPBDyZks0K9VXMNzDdgKpfpTpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5PHPZiJ; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5PHPZiJ"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33bb1a50f6fso374874eec.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169667; x=1790774467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qin3vLUrrbcXuVdau3Ouu4JIt8wWynB3TLlDqfsVk5s=;
        b=p5PHPZiJs1cL7DSdNM0iJAICneE4aZLBRBc7CHLUtpWWJXdZD+IgXitUymoEC7lDXd
         EsKPIOMj1kewxR+EzQAtQkaHeq9GKyruIOXxQ886xVA81AISd3AFSiOJCeN84HYmR0OD
         qpnTRudNEBdu9pP+Nkru/poXXA8ZRN47W4NzN/7UjYDX3SllSExzaZuHYOywDEgXDUuQ
         T808RttceXk29E5I4/WHHX0tI8EFyxtN+IONuWe6iI62/zQvVboQ1S+bIqKBDGH7+fZb
         6n3V3gKRwejaGg8vyA2rnKy0dwwTSclq9wr2IuW0D+MzgHONP88VOmY1huRn3N5kj5K7
         ttiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169667; x=1790774467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qin3vLUrrbcXuVdau3Ouu4JIt8wWynB3TLlDqfsVk5s=;
        b=AzpgVeAMVM0dJ1sY9NrIj6xAyPuuUD5TtBwU0tkYnRCUdE4lhg3BmAiXJzyvGc3P5R
         CNl4IlDV3XJm+jxJu+O2Qz1I1ae0FDtEyGqDa5+p1QdWpJ3lwkC8q4UiDlXLGhDF2qNn
         60vcCf+j+w0fLL5BC7z5SIWAHUkmEdnpCMGxU1J1oBk8UhKefzx9IzclMaLU3Vag8Llq
         bJ2ucB/L2s5BnQQmxLWv2O4r7zWPu0zpDWlrxyhcGkZzQrnEnMGNuL7djQVmH8tFGtDT
         xwYWOHPjyinEAvmcGXDIUZm10gFHL/wajDERfOE82Md+Q+09URfuw7zMGmuemgzetabN
         esyA==
X-Forwarded-Encrypted: i=1; AKwUvBzvgVFXG6reUeBYMm6HUce/dwnpaygNz1gqais+RbWAZIlWBEUdFFFsiuZIamV1dFP8+Lw=@vger.kernel.org
X-Gm-Message-State: AFuF++l4tfbcDittP62wZweQufiEupBiREocS3ZplVvjJYPUTiCo0nB1
	ntNk4VeMLKO9OTukbBpS+N5ZTOEYiRBA1Ak6Ms3ppI0k9VShUVDfPFej
X-Gm-Gg: AYBFou2/MZLCwuNR5KQtyoBABdWwvBJWKr1vBSJQ8gb+dv6WW4rIwI5GqV1HHZWDSju
	UHNHuBhOJhLqx3vBuf3q3IsVRF8hxRUjYgBy2lfCB+e6KjAHDfGA08excqht4UZgh1Yj2A9miBl
	jXLIurqoRn3VBLDTRmWSGZAT0IZ9pcIzcrpyBh4vF0VFT1wMZ6fNGsIeE+AGybnLiYfLFbN9IrE
	K2UrS18H0THdhK9ABXqIGf3KuslrgEZYgD+6bJhVHogqPDI2gvqeC0AL8gpYXUpCOl4ppqskFlT
	TZ6vTJ/XEkyusMD2fvd3mIRDKq7/LLrxj+H6BWpzASFtJvEwgx0IbgC95rGpH7QcJiCZYQPw9mZ
	+WgSp70WeMUZNXn+d8XQLTvIgt+UbgMt/2LQ1mzAeEr4WtyyekTci3dTDNGFPqy9ShSfljmfnMK
	ZJNR+VJyJh5OqWsV9QV2wbRcaQ49xz68YlJxZSpbeyeU/UOEEZT+lsy9W2GCmN8gLAdNEJjl4AI
	HogBT19RzpvuAv2FMSiKoPA85dt5Dfse3eVH6LFnA==
X-Received: by 2002:a05:7300:a224:b0:33c:141b:73a5 with SMTP id 5a478bee46e88-33e8e1afe12mr2620027eec.41.1790169661766;
        Wed, 23 Sep 2026 06:21:01 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:20:59 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 024/114] target/riscv: uniquify TCG crc32, crc32c, and wfi helper names
Date: Wed, 23 Sep 2026 21:14:58 +0800
Message-ID: <20260923131635.1894-25-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- ARM already exports helper_crc32, helper_crc32c, helper_wfi, and the
  matching helper_info_* objects. RISC-V used the same DEF_HELPER names,
  which collide in a combined qemu-system link.
- Rename the RISC-V helpers to riscv_crc32, riscv_crc32c, and riscv_wfi
  so the generated C symbols are unique without meson -D prefixes.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/helper.h                              | 6 +++---
 target/riscv/tcg/bitmanip_helper.c                 | 4 ++--
 target/riscv/tcg/insn_trans/trans_privileged.c.inc | 2 +-
 target/riscv/tcg/insn_trans/trans_xlrbr.c.inc      | 4 ++--
 target/riscv/tcg/op_helper.c                       | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 9458a5152be..ef629b3c650 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -83,8 +83,8 @@ DEF_HELPER_FLAGS_1(unzip, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(zip, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(xperm4, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_FLAGS_2(xperm8, TCG_CALL_NO_RWG_SE, tl, tl, tl)
-DEF_HELPER_FLAGS_2(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl)
-DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl)
+DEF_HELPER_FLAGS_2(riscv_crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl)
+DEF_HELPER_FLAGS_2(riscv_crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 
 /* Floating Point - Half Precision */
 DEF_HELPER_FLAGS_3(fadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
@@ -134,7 +134,7 @@ DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(ctr_clear, void, env)
-DEF_HELPER_1(wfi, void, env)
+DEF_HELPER_1(riscv_wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 DEF_HELPER_1(tlb_flush_all, void, env)
diff --git a/target/riscv/tcg/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
index d8d94bca7ba..5af3efe194d 100644
--- a/target/riscv/tcg/bitmanip_helper.c
+++ b/target/riscv/tcg/bitmanip_helper.c
@@ -117,7 +117,7 @@ target_ulong HELPER(xperm8)(target_ulong rs1, target_ulong rs2)
     return do_xperm(rs1, rs2, 3);
 }
 
-target_ulong HELPER(crc32)(target_ulong rs1, target_ulong sz)
+target_ulong HELPER(riscv_crc32)(target_ulong rs1, target_ulong sz)
 {
     for (target_ulong i = 0; i < sz; i++) {
         rs1 = crc32_table[rs1 & 0xFF] ^ (rs1 >> 8);
@@ -126,7 +126,7 @@ target_ulong HELPER(crc32)(target_ulong rs1, target_ulong sz)
     return rs1;
 }
 
-target_ulong HELPER(crc32c)(target_ulong rs1, target_ulong sz)
+target_ulong HELPER(riscv_crc32c)(target_ulong rs1, target_ulong sz)
 {
     for (target_ulong i = 0; i < sz; i++) {
         rs1 = crc32c_table[rs1 & 0xFF] ^ (rs1 >> 8);
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index a8eaccef67e..0df78e89745 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -144,7 +144,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
     gen_update_pc(ctx, ctx->cur_insn_len);
-    gen_helper_wfi(tcg_env);
+    gen_helper_riscv_wfi(tcg_env);
     return true;
 #else
     return false;
diff --git a/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc b/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
index 01da2b6ce1d..795231f0839 100644
--- a/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
@@ -29,11 +29,11 @@ static bool gen_crc(DisasContext *ctx, arg_r2 *a,
 #define TRANS_CRC32(NAME, SIZE) \
     static bool trans_crc32_##NAME(DisasContext *ctx, arg_r2 *a) \
     { if (SIZE == 8) { REQUIRE_64BIT(ctx); }; \
-      return gen_crc(ctx, a, gen_helper_crc32, tcg_constant_tl(SIZE)); }
+      return gen_crc(ctx, a, gen_helper_riscv_crc32, tcg_constant_tl(SIZE)); }
 #define TRANS_CRC32C(NAME, SIZE) \
     static bool trans_crc32c_##NAME(DisasContext *ctx, arg_r2 *a) \
     { if (SIZE == 8) { REQUIRE_64BIT(ctx); }; \
-      return gen_crc(ctx, a, gen_helper_crc32c, tcg_constant_tl(SIZE)); }
+      return gen_crc(ctx, a, gen_helper_riscv_crc32c, tcg_constant_tl(SIZE)); }
 
 TRANS_CRC32(b, 1);
 TRANS_CRC32(h, 2);
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index a00370a7973..4f4932614f1 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -591,7 +591,7 @@ void helper_ctr_clear(CPURISCVState *env)
     riscv_ctr_clear(env);
 }
 
-void helper_wfi(CPURISCVState *env)
+void HELPER(riscv_wfi)(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
     bool rvs = riscv_has_ext(env, RVS);
-- 
2.52.0.windows.1

