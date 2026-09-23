Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E36531627
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169715; cv=none; b=qGtgGImAKavKMJRSwSm+mL0si10bM0bG7hO/urvKq/NWUpODxdTA4v7s7NvIpQi/5zxFf3sPiHItBqTsPWeGZdGWlGT0DPi9/S78BUqqU+IIhYUJE7v9faWywfz+o3NaPnjJWy/1rlKxGKudd6gPvcB9f6ukXD1yjs+VxtjA11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169715; c=relaxed/simple;
	bh=AEuGPyx4dV85dxdIAHlkxgc4PFYP7rFWKG1GA7MAdoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fydWbhu5106NX8F/2PKd6ItaQqA9pwwKwcVZeI6t/rmanLfh1S8htuIEs6tS3SaAEU/wLXJR9pzXnif0O+SSKdJSIt4Cwv69jpxFhVNH8/TqPyJBS3FGEHvuS9XGRx1nFAj3Kpe44DUFSXnAgXj36M0CwuD/QcQBknoxeooFSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sat83Vxg; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sat83Vxg"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso752657eec.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169710; x=1790774510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RGdh00utr6Q+OpO6+8fa0s0hS8SKHylDK/Tx/Y6cmu0=;
        b=Sat83Vxgid7JEd4e0ZlKLdR6Q/UiqYWkbysvtQDjdBpJaxjU7vJ2tDaHzr6UxJHLCd
         QnRrq0WQGmBs9PmBSiqBbCuzM+hkdjgFE+QxRqeDUngUusuxreE+/Ak5kuJfIdfUqO26
         OXXRbU7yJop45b+BIovZp3V8pmTLPw2VpBjkaTmRSUANJvI8PMbc00cOqhbD2DEy7V6O
         0DVIJDHnLPFAxDGnoWYSSiGXWHK3BxTbbL+/FZUnDEFl7G3XjwxPjtFGBimQY53WinTu
         CR9+/t5Ev6Y1cyGIpbtax1J9yItj5jKAMU+3KuZqXzs3D9dfLYj0ea4K5x8rfm1lrzgI
         cWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169710; x=1790774510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RGdh00utr6Q+OpO6+8fa0s0hS8SKHylDK/Tx/Y6cmu0=;
        b=X1h1L0gcRX5FqwobTTWKYsquLrkazDHSKF/YHveAT4N45CXOaZu7eFf49KQhDKlny8
         7UxsgWDV85qoVOIT1acahVUWvkFLCac4mJ671bP0uWagn8JWFLJwdXD8u/v1flesPSzz
         s8hOJgYbt709sJFORtoAqJWjzJW8l/x5pdZVbftFYjiMAiVR08vLe78VJrt1Hw9zL8YH
         pDH5tN/lUwK/nbot6Xe1RHS3Rxgxa+EcybJ8IGqDhKDrdqYrT/yC0sTFhQyYe6iShB4E
         +Jltw6YYzAnVBq+OFdkfaokr2L+2WixY/M4GfeZbxBY60sKP05LJ8Bg5a7GwDLIWJv8l
         XVcg==
X-Forwarded-Encrypted: i=1; AKwUvBza4WO3DZXtGQ45fXgmdge2DeSmlk0Dp4OQWOTD7cOOLqBqOO9fkD6a21wvE3WGFLKedRw=@vger.kernel.org
X-Gm-Message-State: AFuF++n6WGmGOhMTtkGqbAb0HEX0czEAh7+d3+7YdamW3odYxpu1D68B
	3mIM+DoczGonCC/vf9BQ+eYDC03H6B9uREXfq5T62ra+NOsnd3LzWXtJ
X-Gm-Gg: AYBFou22KrUwmXZBu7WilwsMbid7mS5wj1Y/IAcEU6w7VSfnZPXTH/0QpRAqqAsJtY3
	da0mscy4N7O+q2TjvxK9dhVdsBWxOE7QD4FCQnoZ4Vt2VmVzblv1/6OmadbJEcIgP0p7k+y609i
	bBcqh823zLF31tJ0UXXbv+XT1EpDnLZkJoS0/PKxXSkMX1yxMZsjKwNZoTtTdfjd0CSqArEftl5
	/2fyZ3XILpnYFXRSmoE845nsi+9ZN5Old77+KzWu1/Ztpd6RfsBlA/jNoMsVIQbL7fTZ++kkX7k
	sgJO35H0Z7Wz0YIx7uyHJpeczPge5jW8DyfbsH9Xj5GA51UQqaZThVnHDsFCBA8rMCFZ5h+CLZH
	kNlJt1BnF6Fv8J6y9actZftF38r5ne8MtIuu4Ev8aXCuekrdQx6Y2Fl+AEj7bcEIuqDYfLH7D3e
	QURx+mQNKmSh9tcwFSEhosa7IJj1UG8iN+MsIp4gZ8zciOj309YD0L8yVaeZjreCZblHc/EAZi5
	ConT6xVg1/nsjaH530UmwglcpLAFc0=
X-Received: by 2002:a05:693c:88d4:10b0:33b:dcbc:6046 with SMTP id 5a478bee46e88-33e8bc70ee6mr2596067eec.7.1790169709341;
        Wed, 23 Sep 2026 06:21:49 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:21:48 -0700 (PDT)
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
Subject: [PATCH v3 029/114] hw/intc: send IMSIC MSI via kvm_irqchip_send_msi()
Date: Wed, 23 Sep 2026 21:15:03 +0800
Message-ID: <20260923131635.1894-30-luoyonggang@gmail.com>
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

- Drop the CONFIG_KVM ioctl path and call kvm_irqchip_send_msi() when
  KVM and an in-kernel irqchip are enabled.
---
 hw/intc/riscv_imsic.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 30fb60cc312..033b7813060 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -311,19 +311,15 @@ static void riscv_imsic_write(void *opaque, hwaddr addr, uint64_t value,
         goto err;
     }
 
-#if defined(CONFIG_KVM)
-    if (kvm_irqchip_in_kernel()) {
-        struct kvm_msi msi;
-
-        msi.address_lo = extract64(imsic->mmio.addr + addr, 0, 32);
-        msi.address_hi = extract64(imsic->mmio.addr + addr, 32, 32);
-        msi.data = le32_to_cpu(value);
-
-        kvm_vm_ioctl(kvm_state, KVM_SIGNAL_MSI, &msi);
+    if (kvm_enabled() && kvm_irqchip_in_kernel()) {
+        MSIMessage msg = {
+            .address = imsic->mmio.addr + addr,
+            .data = (uint32_t)value,
+        };
 
+        kvm_irqchip_send_msi(kvm_state, msg);
         return;
     }
-#endif
 
     /* Writes only supported for MSI little-endian registers */
     page = addr >> IMSIC_MMIO_PAGE_SHIFT;
-- 
2.52.0.windows.1

