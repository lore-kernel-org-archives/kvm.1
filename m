Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6966B3A382B
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406075; cv=none; b=JaMjG8ajrVO8JwViIH2HJFfk4MuceJISyyA/SksRtkUSNOzSCmESbaz712dwcsX2Vx6XiiHPuxy/GIuOvvjhor9UMnHYgGzmfkD0u/aokUmKHEcbAN+DQUa8QIez6zA9I4vldbF1G3g0jKaPwkqGVvfBMwHtlVvWZ8dAh2CzKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406075; c=relaxed/simple;
	bh=9i5UhgWFE9VasJPvUQyXYl/uHLKSSe4x+d0QVzjn7aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diWZEP2DZHXPM3ElR1OuzT9c/+pYRhdmIuGvnfuNZ4A2Lr4HCDNGNF2iu+uSvvQMPVN40tJ8vlnFqkhiwqYcr2qoaXW/7AWOrjqZaKkHN6oKR5O2vGm+7njIMN2U2Kw0xMSZH+C+27JadXTDd2KAVxIEIPIrbMh1NcylnDBun5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgNRUOBg; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgNRUOBg"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33bb1a50f6fso848700eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406070; x=1791010870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNd0tofN11vkjQp4tb6Cnaia8Ve9dgyARU+ImhmM7as=;
        b=lgNRUOBgwXe+UdjZzrp2oaJgv3dUfaiWkvxx/UKTWoqtbQ1kkZ5Z+fRU00ooKoSCDK
         jYyz3A/8PB1B4mWE8AUmhNvKsgiyLlZrXFctZXDzfyOGUbzRCccl/1Spq0QRvcOTdHEa
         gnFaGGW63kHqbbNSQixFGRsPhFVHGdJrZynTWAB/bNfTie72iA/6n3iZpQxlpzgOQPxk
         Ig1xvJIrMDWNRNMViMv9cR/5F/7VrHi2KznMUfUx/McMcqlKLf1VXF+OgoFzPyjMfdhs
         U3SHHWzDpKjzTiXPS97RpUk8nnU9Z5igihvIhmZKuGCdcOgMKryrESienxEgFZl1D0lV
         uruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406070; x=1791010870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UNd0tofN11vkjQp4tb6Cnaia8Ve9dgyARU+ImhmM7as=;
        b=zEPPltoWSd/+lsxzU8IJPWDqaMoRMfMnlBMKyd9G6ihRfKez/7gDWfujd+WsLmAyqU
         ISVOyDAooFFnFUKdc+NfAU4I9uY/tkidOIJsw2hJbMSHXkTve0V470F8ZtknSY1z84L/
         /z4WsGrb0moOwH3XDCCzVvFbLGblkLOV0sNxkAI+LAq1Dy8tf2tgcvXkObocPORLgweG
         fIcs+axZ7lYwE/yRzIkp+LDtdOVLxaBGizYezzv0BNSRmtJOBsNF+TjbDJTGNQCVygpC
         2ykDzu40A8D8VImXFo0G2zUzswa9xM/v4Far29t15Jxc8O1fOA3i/cUGxziKkB9XwAMk
         /t/g==
X-Forwarded-Encrypted: i=1; AKwUvBzj9RYzmonclW9bj8C+FwhcjiPYBzd0HZWUcr3LHglkjAxqzw9/3K0bXCdKsPXfltEyfOI=@vger.kernel.org
X-Gm-Message-State: AFuF++mSDr5TGk4VP90YnLzMR1tYqlfi5EK7PPg9oQrMSJ46yk0OXW2D
	jKgEESIlC5SrwAULXqWZp88K+fP6jSkrxnjmfS8ADKHS/lzPiHpj2dQn
X-Gm-Gg: AYBFou3p2uP0vXFiXrLLG4hiyAH53hF2dx88DRd6vZVDSK6xwrzS+iZvzHtBzkaIV3V
	ljT7kd0WffhpkYy7DXQlZZu2eK2CM3iQdK7Ha6Oc0aOFmaG9z9Zg8anLhjPEGPuh5P+OYoktVlo
	SfYUEl/8sIb0TObLLVLB9NYCriyOtPjJ7Y4us6GeyecaJX+nI5iwS5vx9j/1cNkxCgmorzA+22S
	dFB7F7lpz2dqBfA37sCpAtiD9eoMcHCMlY3XdimCrsvgAFhRN0U6CqE6GWF88zujEP3OqyEcAl+
	uBdkafcjvtjAYGsEsDEnIpjvHKE1j+OQ6au3FHabf05A+uCdnFhf2pIX4iMsNlM/MxrqvB8+WoF
	UH7kR3N0yOKEiQgeFJFKeZWj96ZE1W623uT0Sni30DaggBAstAnkapkWwLbjDCroO56CvVqXJ5l
	S4chsalXW5tF5V1f1pZzV/BTXlj36VP69IntBuwzQmZ5uWAMJIPSUPNnPpVjK2aKR7vSNx/zEZP
	0cKNL35d3WjeszCh+C/oOJxpeVrZrPlm0vanWtPIg==
X-Received: by 2002:a05:693c:414d:10b0:33c:141b:73a5 with SMTP id 5a478bee46e88-34272c6023bmr2305190eec.41.1790406069766;
        Sat, 26 Sep 2026 00:01:09 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:09 -0700 (PDT)
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
Subject: [PATCH v4 01/55] target-info: Introduce target_riscv32
Date: Sat, 26 Sep 2026 15:00:00 +0800
Message-ID: <20260926070057.1234-2-luoyonggang@gmail.com>
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

From: Anton Johansson via qemu development <qemu-devel@nongnu.org>

Will be used in the following commit to filter machines using
TypeInfo::is_available, so a simple !target_riscv64() is not sufficient.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index b23e5bc5865..c09e5d2a3ec 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -91,6 +91,13 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_riscv32:
+ *
+ * Returns whether the target architecture is riscv32
+ */
+bool target_riscv32(void);
+
 /**
  * target_riscv64:
  *
diff --git a/target-info.c b/target-info.c
index 012b384036d..bba4503151a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -89,6 +89,11 @@ bool target_s390x(void)
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
 
+bool target_riscv32(void)
+{
+    return target_arch() == SYS_EMU_TARGET_RISCV32;
+}
+
 bool target_riscv64(void)
 {
     return target_arch() == SYS_EMU_TARGET_RISCV64;
-- 
2.52.0.windows.1

