Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0A5335B4
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169709; cv=none; b=qTPx/xi6rEF8BZtBXCP9gKeweM8mMrtVxeuqofjRaRBjaLHe0Z5hwkX+FNXo78kHwp+nmkwudSOIB+shpIvL7C0RdUkyfizVLcHyAU/acHilNeTR9RObV3t2/a60+5ZuMlYHCjJUEdQUXKv0/msAwGHMqb42Xv5Nw0g/xasM8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169709; c=relaxed/simple;
	bh=7AGHKT6bbEPJNns+yT6veipFv7H5mvnoArgoBoXh3gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ikx8OWoHB6gCUwV12+L9IL7sJTVTDrwtll6xAEwPd8Tf11l25dHxXr8rn7VXs/ih3SnvHIbU3NnPePnry5IAj2xL5f5RzFhJ+sAlHsGQN+bIJZgaw4DXg3k5BMXeQmDQBAWiQhM56TkJLpTeJKrVfK8Efm/NX1x413O5lSJ8HfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpEuhto2; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpEuhto2"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04edb5so1438851c88.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169701; x=1790774501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BQcT2TCunpJ4XJOGDsLRORw+wafc2yMdlkK9/vuTXoQ=;
        b=QpEuhto2Jhh5Fs1mbRxBz5Z2TnbyOBlJojuMMUf8FMaEjgX41xYl+e0yMxlRbo1RAs
         DpTsL/T+IrwYJXW7gq3B2TFEKKpvP+Hg30BfyY7rP5+Bk/H19LAiQ2z5FGnZhdTsYr4M
         ZyK0eEwQTRhMXfdkAtwvt/CZXzHFr2MRD5vsQE7actGoilEg+GgjztwucurKAz5gnlxt
         u6lAzqNuLRGDpbF6BfEjCh7y4oV7fcKxb4Cyr+MGtOC/o+YJAD22PlI/PBPNrrdHZHUl
         GpyKOdw6pC3FkYWmAc9d0v6Y4B6bujpe/tXgmHcVKVppmiF9/tkOg8P+fgJV7ek8XkH5
         tMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169701; x=1790774501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BQcT2TCunpJ4XJOGDsLRORw+wafc2yMdlkK9/vuTXoQ=;
        b=uadf2LAub1qId+HB6/AYABXls1ZGCR9C+blBQBu7FN9SWUaRSkwzM03kkIKGU7068o
         /71nzWGJaOfdD+Kqr+DhYs5Lyo2GQe35+YqJ9g0dRy2RZ9MNgELa9Ve3r1CwdKhg4IOW
         b9WH0XKMe33/NAIhQBXFuoDD1ywhxneWhC8iSQD5VhjW1e3/1skN+RS0kiIZMSol0ifp
         rF0X/zYysklej1X4147HDNGcpoeh/H1BQ39sxJLjdLJAwhy1uzk+3853wKSmXENSmBp7
         Qb+ItuhHHmR6mpJR6I2+HDRB/DydJowJlVW8kb8b7Fr/j9AZFrBAP+EuxivSlWWNiP4L
         X1eA==
X-Forwarded-Encrypted: i=1; AKwUvBxMIsg+mH2qgUfXvoJavgPmc6CzhB5obsDKj2BQ9sPZJyxPzV7XpHtT8BIpfPTlxmSrU/c=@vger.kernel.org
X-Gm-Message-State: AFuF++mROLezzoj8cFARJsYqv9JlL+qT7Dqt2+BHFDYQOA93Xf3xmDqa
	bKhJKtolRlY3xGlp6t3vcGvCCxyMhKmnxxoeF7iZOQ96h4WjA+Cc1eY6
X-Gm-Gg: AYBFou1UslCIlZY0LArgZLY91bE1DD3uKGhx+VEpcCfaNuevYhCjv0uaTABEaW3cBXc
	Hvj4AwIHa0LFy9B5NR1AydTULWJfUS+W/4gjOboubgVaakxCgS/GWoG8VhZrOEUnsAoW56WuvCI
	TPqrfMRNatT0wfUGXGk/4zVm8k51lnK8wqb8Z/OhXhZbwiF7oTwLg5xIv7IAI6nY2+s699b7sEH
	fGdbf5roEqR3fvisiz8KOoKgo1l6V3zjesZhqP6dQvtr2bUWy7at2Lk/yUXKhXm//apBf27hAax
	J4jEkShAzUxrag/QU6MWIpgzS6HRdQINY/c3LMYl33jnFarSs7iAsezoLh/h91SY7T/0TWDvPt8
	pYoCp9+jv9u+IX5QVPc5qJs4cYuNrH4xNz2Xjq5PcuKKLXR1GEAdtvm/blHvOaV71Oj7sj94/o8
	RUn29GNubYHxnUgIlDtNeOBP35LBsZWd8XSEugVHRxp2JbSs8gNdwA9To/dnoU23cW2sckdT+Jg
	zwnKlwJsBQPhVPkA8bMDn4msVqvKJeuMfaJZWMEVN4=
X-Received: by 2002:a05:701b:4551:10b0:144:fd7c:84f4 with SMTP id a92af1059eb24-144fd7c8641mr1564469c88.5.1790169700288;
        Wed, 23 Sep 2026 06:21:40 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:21:39 -0700 (PDT)
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
Subject: [PATCH v3 028/114] hw/intc: use kvm_enabled() in APLIC AIA helpers
Date: Wed, 23 Sep 2026 21:15:02 +0800
Message-ID: <20260923131635.1894-29-luoyonggang@gmail.com>
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

- Replace CONFIG_KVM ifdefs in riscv_use_emulated_aplic and
  riscv_aplic_set_kvm_msicfgaddr with kvm_enabled().
---
 hw/intc/riscv_aplic.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index d8e25bfda14..03a0852b8b8 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -167,7 +167,10 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode)
 
 bool riscv_use_emulated_aplic(bool msimode)
 {
-#ifdef CONFIG_KVM
+    if (!kvm_enabled()) {
+        return true;
+    }
+
     if (tcg_enabled()) {
         return true;
     }
@@ -177,21 +180,20 @@ bool riscv_use_emulated_aplic(bool msimode)
     }
 
     return kvm_kernel_irqchip_split();
-#else
-    return true;
-#endif
 }
 
 void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
 {
-#ifdef CONFIG_KVM
+    if (!kvm_enabled()) {
+        return;
+    }
+
     if (riscv_use_emulated_aplic(aplic->msimode)) {
         addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
         aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
         aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
                                  APLIC_MMSICFGADDRH_VALID_MASK;
     }
-#endif
 }
 
 /*
-- 
2.52.0.windows.1

