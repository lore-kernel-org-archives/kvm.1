Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE53A168E
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406214; cv=none; b=odj9t8qhMVTkjSQzSww82N2392DOR5EiHVT5IPz2tt+OLnNzdaNsOGuju2paEhO0dzjBLdcT17MuLDbECe6uVI2iUuN864MSExpuO1XDi6mrO35PmMqu1UMejLFBwJWNYkFFDhPLTN6i0IC6UJg41GMXQqCmSYOi5oGlvx8L43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406214; c=relaxed/simple;
	bh=H9OoxlVPYF7cxXQBeYB4nYP5kFqUmxXy3jo3XsCMaAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oROqmkrU/ZbH2pXlYZLkdCLvu7zhUPEpskoIpam4mQTuEcw/e2VG+XUGBBTn1YI6g1kCaFmghS+SoV9Kq+kA15EUGBKsVBhk8K3SgrHc/SVci//Sppj3ws++60hqWWHXgSJoCR22xv+ULIT7j48Y2Y+NFYUewR7T5YXRE1kJMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrFTD+LZ; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrFTD+LZ"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33b9e805130so1111080eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406212; x=1791011012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzW6PsmtOZwl+8GHz3e9WkPlmisOxZZN4sxAfBryYXI=;
        b=TrFTD+LZNczNu6wKhW3eQDk3CvzvZc6GpZ83CF1zrAFrlPsbsYy8P451hQOFUZyGnZ
         AYFXr/GGaCe//hOhbb22+bV7oD04FWn1u9RE5btnKXnCNqcWwhpoieuvVLncS1ENKelN
         kCBGQpHd9yuVnri/pWV34PdMuwmIScrzDETGSvCVpNNZsXbOTYgqZ/S65+w5R7RQjR+T
         IVUCms9mYJ3IXHW4M+kZjIbkYxV1BMlrWnQhA/hb+bZlhqMr1Mj/1mCw12chRK9M/0nZ
         figGza+JnWvrhtJ5tBk21DABg+M+jrzzD8EHmF6vOaV87HvOFQvVf7s21yQF8ey//nbR
         tY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406212; x=1791011012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rzW6PsmtOZwl+8GHz3e9WkPlmisOxZZN4sxAfBryYXI=;
        b=a5lJxjheRdZ59DxGhfafwMer0rxmZ4/7pttA7hlMr2XxwOfV3kikXylS4UhqwDR7e/
         dxNHr9uHAwDEIkmcwsp5SiTCdZnPg0ab7b0YSETfs9hqtw43i1aWJHC7djKcbhUZsuK2
         DMcHgq277tMd7ftfGMGsXusUxBXsib5+bLWckAXMi748LtflQGVWT2wdoyX1JLWyJrgW
         zL2MI46BGrh0GXBOpGP2fIoIQ4nkMjyE4FWW2JgU5DeGoblBEJvXEp+6C8isTlid1/3L
         9b2DY3+PM4/ClDllt09lszHV4q5iz4aMXJlXvAHzWPBitB5XOCxSkU3U2l+TLhFX/JLF
         RNCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzt7g9TdgeAe7zYJ3EajuXMhbqZVLDHl5pry3T8PaV1MDpRSJTMCbqOXI1hhEtAoBgFkgE=@vger.kernel.org
X-Gm-Message-State: AFuF++kt0lMoP0xlAX12cx+x9Bs25s1d88GZSeLpG5WwrAZpRCpcJUMs
	pz/s1n2UnDhE+5KQHN66ldHtrd0TYMOS3j18UbMOnnX5vKs4VSUkBhc+
X-Gm-Gg: AYBFou0UDXsknc9mu2DR/mIE7rlBcCJWbnBKPznhpweajmWsls7LRoS7CiLFrqdg2is
	6fPQacbe0MsMDgJhA5dYbbDO9EouCcZgATH6sbBU3zrS1TcVyxDiPgHTEFuzO+TUvvzlOwkx1Nc
	IcBpM6lExbVL8wBgHAqmX7PTxrApMp6YHjKg6P2Q4l0aZ87UnHgvvOK8PcRi9s+YrPbs2j5KcW2
	3TZlMQfeXCutc2FxP6yVBCX39y1IONbCC/bMrkeu4PdR+8CY4t/FTLQcnPQoPxiDfRFGSqxpbJ9
	/Wfgu+cEhtjY67+90qfahaG1Lr3+mSzeFYYSdd8DT3GJNscwloNTUHOouLEpu11E2mp96YQyfu8
	RdZfg9Puau7uero7kuzQxZXixp9JuYKZVVk1p82GFIT730qrbFBZncJ72HfbQQ4kJzQAu+uM2/a
	rRV1WTxGBWhReyH7MW/NqC/DgcV0KBx+va1Rfpy4IoZMvN6MDjCpG+vfkAc7c44ZNqbyQsflrpe
	VF8X26mgNHSF9sL+fmGLsv1kiCWlLhX
X-Received: by 2002:a05:7300:cacb:b0:33e:a0c3:4176 with SMTP id 5a478bee46e88-342738466b6mr1902861eec.27.1790406211560;
        Sat, 26 Sep 2026 00:03:31 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:30 -0700 (PDT)
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
Subject: [PATCH v4 37/55] accel/tcg: keep cpu-ldst endian aliases per-target
Date: Sat, 26 Sep 2026 15:00:36 +0800
Message-ID: <20260926070057.1234-38-luoyonggang@gmail.com>
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

Wrap the TARGET_BIG_ENDIAN cpu_ld*_data aliases in
COMPILING_PER_TARGET so common code can include cpu-ldst.h.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/accel/tcg/cpu-ldst.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 1facabccb23..e3082db53e5 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -1,5 +1,5 @@
 /*
- *  Software MMU support (per-target)
+ *  Software MMU support
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -423,6 +423,7 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
+#ifdef COMPILING_PER_TARGET
 #ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
@@ -470,5 +471,6 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
 # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
 #endif
 #endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
+#endif /* COMPILING_PER_TARGET */
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.52.0.windows.1

