Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6D34E766
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406201; cv=none; b=BXKESKpjC0uuc5SdQH4lA7p8QBs2xNAd2qqzNzmuynza4VDKWbNPz3OVJnvsepnaXsYKVhxpRKZPLYUBPrL+uFg2igZhTJvj/FgzXoDswXduZZd7nN1zjQBa8Q8loxt9LgLB68m40bgLM2dIpU6eEetF9RXqjMaMkd14DQG5Gig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406201; c=relaxed/simple;
	bh=/8d38BdcOlmrDkeQ4Uf1nhDeV1YJlD/JDVhkE6lBvCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tH/Kzc2fEdBIjaQD4orNVRbi9DguuLiGOGZcDUNSh8ptpRQJwZBG7sATcOGWaeU3kU4D91w2PmQTpDOzILdF1IpnHU1BdeKO9OsBldCzXCl5QKAAaMTS+U3cix+2BAhwnNsQXVgPsOVIgnkt+vHEO8SWxynmBTgyRXwITDytZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0UgX2ZH; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0UgX2ZH"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso1865853eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406199; x=1791010999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mzk09wMbsBzxAEmjnfDm9veq+liYVS/t1qc3bHMs1F0=;
        b=D0UgX2ZHYkfciD3OBLzJn5VTeIsodhafHXAziv0rM7YVMtJPUl1UOmn/70x9R6CC8O
         D7WO5s4S2sdNjcf3lIM1LldBUbdNzMGxWL8bLrHxI220Xv/o2K+lzqWpN0K4yHm6wG1D
         PzgsO8/vM6Me3ji0mwzTcte3FYjXw6zftJvMbgD2UqseZzDRsU2oy1C60cuVu2joZjao
         eK8yA1o5jCcO20n6WVXpFnuMLi6KQEF2rami9XPmeTfX2q3JPCbRYXw1GdT/HU/W0G+K
         siTOFHC6pU4HzZsdJPWT8v7gNMIqFZB8wO4E0QE4tXA3iW6vLQk4MgHLeSvV4ScMMxgf
         QmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406199; x=1791010999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mzk09wMbsBzxAEmjnfDm9veq+liYVS/t1qc3bHMs1F0=;
        b=q5evSKBSzIyg9Z5ukpBF0SNLdZy2k65bjHAhhqtbZANSayKWz+WtS/VKZVdrG0zLq+
         CIBKeI4IU6rW82EZ4/22yrphTwRbM5vzJL8hllw+W2/cNrhGz8pYXRLrgirdigTHY7Dg
         Jl+hRL1OBXFwLANGI1FtboSQw/fqk7P00yGhJVyispf373hMWl23QC4zNXb1RRVmnTxd
         4BwG9m9UAPEWm9qgmoGW8A+bOkKDZtg9GXQwvM+dkN1wwA45Cq4RbSA9Or5E9jHdh7vm
         /jxCZtjJXz5yP4sOPb7zgtsZpPxv/osRz5cFZxsKbmzr5/Uu4bNkCJgspWFMmATiugH5
         rbIg==
X-Forwarded-Encrypted: i=1; AKwUvBwVzc1rJjognj71fDQrEJKEtDXwZgRbxeDiYh/Odsq54g998lROXX0NHYP7q2OYlUeC8FM=@vger.kernel.org
X-Gm-Message-State: AFuF++mAPJ4gwsBPm+3uf2Hzy1oiF0de3vFe67GHPc9YbPS9Cg6I6LC+
	Cs9w0Uv1PjKwOOInZhhtV4mE1k6bg6MBmleNpqqXCueTUWZqLUIX6SYq
X-Gm-Gg: AYBFou1RTnNVMj34Wb3YHOLEDLROxQeLbP4fg9MmcU0vMdWBjZzD6nQUlz9oQp/u5q0
	QM7V8TBkM3HL8q9tpeK/jqPKVnyrLATvtxfgjVGcayideFs/t4H+FL5iM7wbTwLPt2JZMTsJLsN
	CCJHSWwo7J4AzJuy74Iaihrddgi0IWDHSk4kEqqyQHOSXeBHtHlD+uTmC4/4cxlcmmyX5qTy2BP
	oMBUm3xvqUofdgM7vEhlPknNI2Li1Sk7euLl/QPHsnrsq/t047XiZ3IBb/z1YBrog6HP+wW+vFj
	YZtGwSyEK+mYO4CpzdB4Z2Jp0UiO0sht+gPOiifWF02dF1fi7qXNWgIUpQJksKPbNzW8DZZxgWM
	vncWsFutzRZN3ueOEcFWGq1Nt+WnfWKn1Bq4nNOh6sqzE57grfo67W/yb7/sYSrwHE28xOd7P3Z
	bB4om3k2Et9JaTkrINSqe8XtnpwvsPZV3Hztv8bpFIcyNWv7AJP9U7Go9AixS9lYFo7xOBPgUU/
	6ATBpjJMOETEKAOS1wcJnN86IRtK5E=
X-Received: by 2002:a05:7301:1506:b0:33b:e529:4446 with SMTP id 5a478bee46e88-3426febb75bmr2204414eec.5.1790406199112;
        Sat, 26 Sep 2026 00:03:19 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:18 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 34/55] target/arm: pass tl temps into SVE and SME helpers
Date: Sat, 26 Sep 2026 15:00:33 +0800
Message-ID: <20260926070057.1234-35-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SVE and SME helpers take tl, which is TCGv. A64 addresses and
cpu_reg() are TCGv_i64, so convert with tcg_tl_from_i64. Truncate the
SME tile index with extrl_i64_i32.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/tcg/translate-sme.c |  5 +++--
 target/arm/tcg/translate-sve.c | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 08b25b0be9d..e34e7d8744f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -64,7 +64,7 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
 
     /* Compute the final index, which is Rs+imm. */
     tmp = tcg_temp_new_i32();
-    tcg_gen_trunc_tl_i32(tmp, cpu_reg(s, rs));
+    tcg_gen_extrl_i64_i32(tmp, cpu_reg(s, rs));
     /*
      * Round the vector index down to a multiple of vec_mod if necessary.
      * We do this before adding the offset, to handle cases like
@@ -469,7 +469,8 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 
     desc = make_svemte_desc(s, streaming_vec_reg_size(s), 1, a->esz, a->st, 0);
 
-    fns[a->esz][be][a->v][mte][a->st](tcg_env, t_za, t_pg, addr,
+    fns[a->esz][be][a->v][mte][a->st](tcg_env, t_za, t_pg,
+                                      tcg_tl_from_i64(addr),
                                       tcg_constant_i64(desc));
     return true;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 10375577b1e..9fd10168876 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -36,9 +36,9 @@ typedef void gen_helper_gvec_flags_3(TCGv_i32, TCGv_ptr, TCGv_ptr,
 typedef void gen_helper_gvec_flags_4(TCGv_i32, TCGv_ptr, TCGv_ptr,
                                      TCGv_ptr, TCGv_ptr, TCGv_i32);
 
-typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv_i64, TCGv_i64);
+typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv, TCGv_i64);
 typedef void gen_helper_gvec_mem_scatter(TCGv_env, TCGv_ptr, TCGv_ptr,
-                                         TCGv_ptr, TCGv_i64, TCGv_i64);
+                                         TCGv_ptr, TCGv, TCGv_i64);
 
 /*
  * Helpers for extracting complex instruction fields.
@@ -5378,7 +5378,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     t_pg = tcg_temp_new_ptr();
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
-    fn(tcg_env, t_pg, addr, tcg_constant_i64(desc));
+    fn(tcg_env, t_pg, tcg_tl_from_i64(addr), tcg_constant_i64(desc));
 }
 
 /* Indexed by [mte][be][dtype][nreg] */
@@ -5861,7 +5861,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     gen_helper_gvec_mem *fn
         = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][0];
     desc = make_svemte_desc(s, 16, 1, dtype_msz(dtype), false, zt);
-    fn(tcg_env, t_pg, addr, tcg_constant_i64(desc));
+    fn(tcg_env, t_pg, tcg_tl_from_i64(addr), tcg_constant_i64(desc));
 
     /* Replicate that first quadword.  */
     if (vsz > 16) {
@@ -5945,7 +5945,7 @@ static void do_ldro(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     gen_helper_gvec_mem *fn
         = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][0];
     desc = make_svemte_desc(s, 32, 1, dtype_msz(dtype), false, zt);
-    fn(tcg_env, t_pg, addr, tcg_constant_i64(desc));
+    fn(tcg_env, t_pg, tcg_tl_from_i64(addr), tcg_constant_i64(desc));
 
     /*
      * Replicate that first octaword.
@@ -6286,7 +6286,8 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
     tcg_gen_addi_ptr(t_zt, tcg_env, vec_full_reg_offset(s, zt));
 
     desc = make_svemte_desc(s, vec_full_reg_size(s), 1, msz, is_write, scale);
-    fn(tcg_env, t_zt, t_pg, t_zm, scalar, tcg_constant_i64(desc));
+    fn(tcg_env, t_zt, t_pg, t_zm, tcg_tl_from_i64(scalar),
+       tcg_constant_i64(desc));
 }
 
 /* Indexed by [mte][be][ff][xs][u][msz].  */
@@ -8682,7 +8683,7 @@ TRANS_FEAT(SQCVTUN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
 static bool gen_ldst_c(DisasContext *s, TCGv_i64 addr, int zd, int png,
                        MemOp esz, bool is_write, int n, bool strided)
 {
-    typedef void ldst_c_fn(TCGv_env, TCGv_ptr, TCGv_i64,
+    typedef void ldst_c_fn(TCGv_env, TCGv_ptr, TCGv,
                            TCGv_i32, TCGv_i64);
     static ldst_c_fn * const f_ldst[2][2][4] = {
         { { gen_helper_sve2p1_ld1bb_c,
@@ -8747,7 +8748,8 @@ static bool gen_ldst_c(DisasContext *s, TCGv_i64 addr, int zd, int png,
     t_zd = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_zd, tcg_env, vec_full_reg_offset(s, zd));
 
-    f_ldst[is_write][be][esz](tcg_env, t_zd, addr, t_png, t_desc);
+    f_ldst[is_write][be][esz](tcg_env, t_zd, tcg_tl_from_i64(addr),
+                              t_png, t_desc);
     return true;
 }
 
-- 
2.52.0.windows.1

