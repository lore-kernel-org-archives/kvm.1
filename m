Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AF346ADC
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329713; cv=none; b=ZSdvToK5IY+viknH7vFU1rvEOqLnjtkEthHlbZCAgd2UKNhuqaVdbQtdtonxBc50bPmvGbrKVGVG39ABbbEBg7qIJ/UdjVoWpogta/C+7NuiscpIXcp08o2UBNdGg/7XUkAA7pD/TrKSZhVv6rCvMJYCWW1H0M3canx6XJIP/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329713; c=relaxed/simple;
	bh=UwOA8LjM0NSCFy3j2zt1k5HHkmtLxl/qmELRahsK2hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GI9vTSgntcyxO9VlhtJovUYflHJPr6dHwBme1uXrS4xOxMuFRudJavoMC/j4xFhrJWjjG+Rovs1A1pvmkdg95OON8bOPoq75NeKxkd0gZt9nO6bmLOaVMqZNeAoR+kfbdxG7Akuvc82tqx697jnVNCubT+cr5ch+qJRMJGE3eyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gPST44Yt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gPST44Yt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d944747d41so7454465ad.0
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 23:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788329711; x=1788934511; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eu4ymMPYKZBtIpuaapdXbFgIh8ENIgqZKDyMhyBzO+s=;
        b=gPST44YtzCBLYwFHrypRJU0ZeqCR2wZT1ZWzDUXqiGd0Vuw4e02cX6Gnc03LpWoLso
         RuVw+LWD5NT2DAima9OLOryQpHJBncQSLO64acgLEEUUl4VWWY25t3QlXN6iPvbUi6Sd
         mp42OQdgkCBvHqUUBceSfQV1z0jyF22Zh8uhW8h+KSx7z+/RoCbhme5q19v16Srpizp5
         ovbwWAhstMp5UBB+6UzHmpLY6D1Z1ZhOcH0pkLtJMm5bUC0dX59fEkj7GJz4/J+j4Lrg
         azFo74EGF2LDKvIY0o5sx9oPPX/6pmMGvUf9fR1MSagMiUvK8Ow8oOMfcMQXk7P33GXH
         4P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788329711; x=1788934511;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eu4ymMPYKZBtIpuaapdXbFgIh8ENIgqZKDyMhyBzO+s=;
        b=ikq/wG3noPt58Mfh5BC9YU5kbng647GEtgTBtkus03HuWdcqOvnT6bwQOew52n4RPw
         JrmWm9r48yTSurfmILm9CywoH59E9p4DX4nn+rdHl04M0Fqng4Kk6yLa32aMzXhK4uJT
         YsQneuZP7/U/WZ3706FqluyrTw52+tY7oxMVlMg57m5MsjuFLKk/Zi5zQBJbXy+mq3oS
         YvOLhOlX4g1T9QcXaWJwz2gHF7EJm0xUiSZ7IqExSg9jLbnN78XrxDoIJYlWDjm58xXa
         Drhf+28onLoNSYp5qNeEU0nelmZaP8ehclO8BH6oRmfjkIi3KcF3+GS2a3rAq0i/cXPI
         zb7A==
X-Forwarded-Encrypted: i=1; AKwUvBwVFm3jq4rfzRKl74Kt0qf4J7FxVhjF9it05srNkTYUFvaBIUnULD5Ox6Whgqi7dT4YBzs=@vger.kernel.org
X-Gm-Message-State: AFuF++kVW9N1p0VOIGqnJj6MFk9sTmMf+rRTKPDGZ4ftkI35XoaCRvrl
	YCcJoe/4AS4Y5sRcODvWBimiB8/vi10g3tCLjDy3VwDeBWq0QJaetEtLGgiZr6Cf8Rc=
X-Gm-Gg: AYBFou1lKpl3LDbxmLzYRhW977Owk76psEYdDNV3lbZmWV5f5Bas+lY/0yz4YL7n1hW
	DozVrk9SLGLc+jLIPXXyvsk/bk0m2H+e7v0D0DahgQfuPwfLawXbLBYUGnkNtNEDD8xLcdAkHwv
	P+eS3kA5vaa9td55TjTWAeSIHKKr1EioxWpLsbxwlYKwE8/8wPNSxpZUqsXCW5RBPJCTggXN2oT
	jMkVBmQEsGb7bKEWxuaCZVx4WxHowriligZW+d3mufhQUNGtjm2dXrDIUtpfUszteeWZr0tJYWT
	ADAAU8q8o3Y8XyGvyiv7fVC5z3XbMMfXTLRnW2SgQd8D1LWX+oK7/CERvtDLw/S88baIsnrAYKA
	htzsSsmvAXOcMY0r2ZTKUbd5m2MhaNHHizjfvMT4673vUViYARDuS13CsXWspjLNMGlor7rGgqZ
	/27wd/+NlitUA3fuTmYGHP3Km6sURzJd9B4reMj5O3FvtnJr5BO9yZzDY1/3SFJZG9SW/UJ7LJk
	TihONQe
X-Received: by 2002:a17:902:e804:b0:2d1:134:b86e with SMTP id d9443c01a7336-2daec5ad579mr31546085ad.2.1788329711119;
        Tue, 01 Sep 2026 23:15:11 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079f1f4fsm3462624eec.11.2026.09.01.23.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:15:10 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 01 Sep 2026 23:15:08 -0700
Subject: [PATCH] KVM: riscv: selftests: Disable vector extension in build
 flags
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-kvm_kselftest_disable_v-v1-1-fe73aca5bf95@sifive.com>
X-B4-Tracking: v=1; b=H4sIAOu+l2oC/yXMQQqDMBBA0avIrBuIEST1KqWEjE7sqLUlE0NBv
 HvTunyL/3cQikwCXbVDpMzCr7WgvlTQP/w6kuKhGIw2rbZNreb8dLPQEhJJcgOLx4VcVqZBDB5
 bq68WSv2OFPjzP9/up2XDifr028FxfAF5qXhSewAAAA==
X-Change-ID: 20260831-kvm_kselftest_disable_v-23bbfab68098
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 anup@brainfault.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788329710; l=1384;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=UwOA8LjM0NSCFy3j2zt1k5HHkmtLxl/qmELRahsK2hE=;
 b=Wu6dcMEbHae6NcaOo3PXMhRBifeLnVbHpjN50VxkDCm33Rv81KHvvaw2L4qt/n0WHkwTsJNJs
 8+5SSom61XiCmQ1TrwA1tilfCToI+4AHBSI3tH+M6wUcvuvmXA6LVs3
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

Guest vCPUs never enable Vector state (sstatus.VS), so any vector
instruction traps as illegal. If the toolchain's default -march
includes the V extension, the compiler may auto-vectorize routines
like memset() into vector instructions, crashing guests.

Build with -march=rv64gc, probed the same way as x86's
-march=x86-64-v2, to ensure vector instructions are never emitted.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6fc34e9bf8e1..46c54948f4b1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -297,6 +297,11 @@ CFLAGS += -I$(GEN_HDRS)
 $(GEN_HDRS): $(wildcard $(arm64_tools_dir)/*)
 	$(MAKE) -C $(arm64_tools_dir) OUTPUT=$(arm64_hdr_outdir)
 endif
+ifeq ($(ARCH),riscv)
+ifeq ($(shell echo "void foo(void) { }" | $(CC) -march=rv64gc -x c - -c -o /dev/null 2>/dev/null; echo "$$?"),0)
+	CFLAGS += -march=rv64gc
+endif
+endif
 
 no-pie-option := $(call try-run, echo 'int main(void) { return 0; }' | \
         $(CC) -Werror $(CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)

---
base-commit: b5060a4aa33d7d78a8c1837ab08ef0c81ea96650
change-id: 20260831-kvm_kselftest_disable_v-23bbfab68098

