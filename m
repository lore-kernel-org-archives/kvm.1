Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F85346FA1
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184074; cv=none; b=dmK44b6wGzG9VMD34pila7ulqIFXxJTHMEsDaB+FRSJqWQoYYgFpmytwpp5qG8jst++aqRLEJNN5IF3RMojBHkx2yTb2xgP5WlDiXSgnLCBqYsW+omdOJe3rZLL5WubQQXWupxrd774FCXyo5tngKohLWli8/kP338eQWdC/t6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184074; c=relaxed/simple;
	bh=ARwBqNXy7iYAR/zvzCQFr6JDEhfZR9bP5dOWQAURFD4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEwwdM+486jn+PH/StoRy2P539BFB0M0ie++uiW8mZ90P7NARuuGQ001D6kzJ/sHk0ZV6VJYWrj3KDrnWVOFUQCqwvIyTLKgb8BJVUoIOshoP/sjmLxs1I69y2R7FT23xLi9uoZGxLxb5Pwo3P+SavkA7FSP2sqczumwwYHiqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNKBabSz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNKBabSz"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so2568414a12.3
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784184072; x=1784788872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8J2PB70MWAXXQG95F609SxeXRC3aZLcryE0e4szEh2g=;
        b=mNKBabSzr7e6d9eYDXFsrOOIme6opLnCbMqdxVWsqFAZoqisYQzpmAP+aheZO+ojE9
         8R6il7HTeF9hkN5QDo9Wlx+3QLYmefBW2zzwV3+LDVOxsM0xuk9Xi+G+B+VNXe1jQAwT
         dISrkmT334aKh39dqI2q2uvjwEc6CbOjjUiYJfrfOGY4YJDx+orRX6D7iFGiXAKMIxke
         aM28OOLNLB9ce5snzFG1SMLt9NZNHu3HTBYHXk5HNNxTCX99GpmuKLmHE07jtvONY4Hc
         QRvs+zWI53ojl1ZwE8RH0P/0TA8mDC8SHWnc85HF054MKQhLGqFs0zACvQqWS7kiCEyW
         0QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784184072; x=1784788872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8J2PB70MWAXXQG95F609SxeXRC3aZLcryE0e4szEh2g=;
        b=RzUUBBHHgueNEr8vXiA1fBqVOmB8cTyPoYdpGJw9C9oBcFr90nygnbRJi9mD3P/l/0
         vYpiyOv4IjM2BL9MmKpo1i4r4QIR8P/HAR/rcJMrEluQeztWBUaRPVDKwKPkfxjbudNC
         n/SQD4yWAtyKtKLvF4coDHl94H6Jr2oOQpzPpYOQAprQwDxlKtjxokmfcMPpgtc3h0NS
         8gCBaU5qPxjfcjpzb9TUjmqQNh5xMV2FzFX5z/3msuV18LuV1wkKE7xya5XMGuMN1RPd
         QDaBiXBKsce+c3+mhK2Ng+KcwVtZadd/rAP8tk205n3bn0BPxF57u4p+J6IFkLmX/fqk
         syYQ==
X-Forwarded-Encrypted: i=1; AHgh+RpG/vWT2VbxvSoxWcQXWnGHUVV9kbY8HWp7LobWttJIey+k45MmGVKGPyuKYWKeKU4FPFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsWkOyysUi8jj8pKIdd1zETJYAD7q63gLojj+YfIEMmLx+6iB
	7KLpWo7isoJgZj9F1aZDYS0WPcSY/GOFuvTecv2VQmyh4h6vcvZTtyWv
X-Gm-Gg: AfdE7cmpGzgmSSHrt872e7iC60ov8gQHavKZ9oN67OPvY4tdPStxswDnjsqCm8vjKBk
	hIj/TinYJXc0J6x1An8je5OEh5Bi4FgXzQn/KlcwBZBp0LfxJJWB0DbW1y62BsA59wmxbMRx5s7
	lMDAA33KgHUDmFt6WkDOxTY3+yTaaGfrJi8P756vnMG0Qzb0B+f4oUmZ7EfjNrxB6pl4Y/MNthn
	VjUSNnnaljGZ/M2iMc3Scy0BQ6yA9O1YR3vl147SFal6mWZEkA7doEwsrdJdKW7o0JffTVZW8Jv
	UEEEh96O74xSuOeGaDbmpgXwPIXWdmnhkVQWeT8cR4OFBMJt3PyKAKJuxOrkIKB8KHw0NIujhSG
	4YGvBe1Ny2+2r9KSjdAeCK/k76qZOhDmQqK8dRwVScCiuAsCGLVURfK3boh113RP8fqd0CbDf44
	5slty8067P9rFKhz3YKRwi
X-Received: by 2002:a05:6a21:495:b0:3c0:9c1b:d0b5 with SMTP id adf61e73a8af0-3c1109f44ebmr22579230637.64.1784184072215;
        Wed, 15 Jul 2026 23:41:12 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eb856dsm1412425a12.6.2026.07.15.23.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:41:11 -0700 (PDT)
From: yhchen312@gmail.com
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	"Yuhang.chen" <yhchen312@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH] RISC-V: KVM: Use raw_spinlock for VMID update critical section
Date: Thu, 16 Jul 2026 14:40:11 +0800
Message-Id: <20260716064011.2387501-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yuhang.chen" <yhchen312@gmail.com>

The VMID update critical section performs an IPI broadcast via
on_each_cpu_mask() on VMID version rollover, which must not be preempted
under PREEMPT_RT. Convert vmid_lock to raw_spinlock_t and use plain
raw_spin_lock()/raw_spin_unlock() (interrupts stay enabled, since
on_each_cpu_mask() requires it).

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
---
 arch/riscv/kvm/vmid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
index c15bdb1dd8be..21c2b276b55d 100644
--- a/arch/riscv/kvm/vmid.c
+++ b/arch/riscv/kvm/vmid.c
@@ -21,7 +21,7 @@
 static unsigned long vmid_version = 1;
 static unsigned long vmid_next;
 static unsigned long vmid_bits __ro_after_init;
-static DEFINE_SPINLOCK(vmid_lock);
+static DEFINE_RAW_SPINLOCK(vmid_lock);
 
 void __init kvm_riscv_gstage_vmid_detect(void)
 {
@@ -78,14 +78,14 @@ void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vcpu)
 	if (!kvm_riscv_gstage_vmid_ver_changed(vmid))
 		return;
 
-	spin_lock(&vmid_lock);
+	raw_spin_lock(&vmid_lock);
 
 	/*
 	 * We need to re-check the vmid_version here to ensure that if
 	 * another vcpu already allocated a valid vmid for this vm.
 	 */
 	if (!kvm_riscv_gstage_vmid_ver_changed(vmid)) {
-		spin_unlock(&vmid_lock);
+		raw_spin_unlock(&vmid_lock);
 		return;
 	}
 
@@ -117,7 +117,7 @@ void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vcpu)
 
 	WRITE_ONCE(vmid->vmid_version, READ_ONCE(vmid_version));
 
-	spin_unlock(&vmid_lock);
+	raw_spin_unlock(&vmid_lock);
 
 	/* Request G-stage page table update for all VCPUs */
 	kvm_for_each_vcpu(i, v, vcpu->kvm)
-- 
2.34.1

