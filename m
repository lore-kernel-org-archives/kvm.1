Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493006;
	b=Fi9nGoM7MflHoFYVJ+yCNhovAzh1VNxGsXsEuD0B1cTl9AG/hz/4WsnsuYgdg/r7cUl6
	 VPQ8on83oClD9pagHJXESPYQ82NwmGWdl2spHMN8JsLtDTg+LiPNlhBLAqTH9R6gODPoU
	 T56bBm1YbDBcmYFlw4y+Jeh9tPWtcgCPaFrbO8qLezNSfzBmK0xNGq/JIyFE/ktPqKcwx
	 Rn3OfASV3faFRKpK8P2TYozuQbiCPc7raTS7CvTb0ABYF8rZllAjQFHYzxf5NtqyRg0Lc
	 ig2V02rM2c4xYcGlsgygUcO06dk3DswKXfR/PsvM7W/mpl94qEHcuc6aajqR4Njmbew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=W1YwD7IMkeAO6OcLReHpxRqQRfDPA/W1esQDN17JAFU=;
	b=SOjhtnBTK66z3dtYVy9zwe6/doPpzct827+V9pKmwuUVAaXCbGK2XCAhAOiEj8ol3IFi
	 GbODJpSUR0/iIpnw535wTHn6aZQycxXDczcdJ9Y4NgDjegpEZyMlrDcvgTclOpPVOr9ul
	 tgjAqqeBJqjcmBRptwKRuiZdBIlQvPnL0gkMqP38oo0vHOu6TeZYkSbg1vnnbGyq4uEsu
	 z8oMyp0RpMNJ+33EQjFJoLenOTh5ZX30FTFYKWsWo+k3NAwblyv2lJMqs9w4Bkb3W/5/B
	 7aMlGF/RymKVFjlV6gatVmym1iMS5NiWSUz8VLVbe0NS+8AhI69/ZrR/WU8P3PQgm+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="qZM4G/5F";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AF606A33E
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD2AF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qZM4G/5F
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48afbd2c386so1529617f8f.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493004; x=1793097804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W1YwD7IMkeAO6OcLReHpxRqQRfDPA/W1esQDN17JAFU=;
        b=qZM4G/5FfFiYqI3Zl8+wv61PamEQz1bh9Tf1xQ4U8zlaurI/j97gARE8Sps/bNQYVz
         8fY1XG8bA10fbmxbuqa6kBxbs4yUYGW4D6yHdEfkCA9fWRfe6MoZ2GjWpQwExsyFIttD
         EU3gg4rmUDocEyfDc3KOlrs0FiPpElF8C4ySLSXjYRzJl2lxul+SnBcDNVl9sM+EXpDJ
         YRnLqqMLQj3snHDy/IStiHag4S6g0Qw9ckgXgjgYe2mRdiC2Rsa+05S4K1mHeMMP4g5+
         YAJR6lylWJURnDa5az7cKbppE/dkmPja9v4UDVXDn9lhOSUsppTcyrRftbRQevKkFO/Y
         ow6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493004; x=1793097804;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1YwD7IMkeAO6OcLReHpxRqQRfDPA/W1esQDN17JAFU=;
        b=ejBZ0oESo2DVPgcCuFu9/s2s4RY7F2NFCYKyaCRPw6Qb1MBaJsdQlzY63eKhEgq0sm
         BnbMts+zbnv+uiZcbEaweH131sz9H45IRSmeCRLkHpdU73KY44cYkNmswT08Jj7VXHZs
         mhE393BdwjdfEDU7zstYkaF2vaPnkZHfz21gADTqqNgz4aN3R0yrj2USTuDQVZATy4T6
         nbqYTdARurHwV6eAGxUsY/H+P4LWG+2IfboR5IolekHv7p63DS5YdX9apJnHC8ylgkVo
         HXvjrAwhgUIs9zuvzC5eHk1UQkBcDV8THTLGJ6cU761xc4I2TxFe+Q0nIvq+i5265sGd
         l+Bw==
X-Forwarded-Encrypted: i=1; AKwUvBxCoFq3sU/j5kol0f3mvAQPK/JarD3CE/tKo2+LKYcaqoVPsr9vre+lwWfv7htqvtXgn5k=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/GYs8v9bDxwVFco/RzXyqoGuwsWwStDL66AXpeys38xqBhn8n
	oEaPRJccgPrK7MNoaoZNO8IaMxWYfWWX51iticoar4hOXEjtaL9JT8CerR5EJNBft7U=
X-Gm-Gg: AYBFou2EU+TNDH98N9i0+8Xs7wH6qY1fNhqkTSFAibKjA5GLG0K3pwbnx7RdApvKNlm
	hLfWUMsp9ofHJ0iu8ihaRqdIEbEpBcx4HqUwqEMwOzcIX9YDY6+0b6Mw7VbvTJLjvy0GklhtSIy
	Cyly5p2MEHieOIm1LzWHVOvtqrTtuKBfc4ZN4Uqk8nXH3jurGjwhT5fnB3NkAzwJ9KEtqDSj4OO
	21uw8pcV88Ula6iUtn/HKYx0qo+IG97dWdGeyE0u0ULthS37CC4Kv5uoDnfT7fniscLyV/vbwXI
	z0iVBJdzAWu22wojndvwLRy3ub8pfzzZPc9gZSDgPsLXs7ox4kVoSjkWDOBTPdBeMBRXe6oKn22
	/d8pIUHAVqqW9Dir/nPbZiN8yvan59E096vcgIchB3OctziEocqESHeH4y77vH7cLUhqt2MN/tx
	uuFC32RZs7Wx4wqHdaKpfepjb2cc06s5fmDgpyuMQO958+/ZG3I8N5iyplmdn6Jp2PRopqIQ==
X-Received: by 2002:a05:600c:8b6f:b0:4a1:d307:d578 with SMTP id 5b1f17b1804b1-4a1d75e6d1amr197176025e9.11.1792493004251;
        Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2c9e9c3sm56999645e9.3.2026.10.20.03.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id B08A65FA43;
	Tue, 20 Oct 2026 11:43:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Song Gao <17746591750@163.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Bernhard Beschow <shentey@gmail.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Durrant <paul@xen.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Walk?= <bwalk@linux.ibm.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	qemu-s390x@nongnu.org,
	David Woodhouse <dwmw2@infradead.org>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	qemu-ppc@nongnu.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	linux-edac@vger.kernel.org,
	Glenn Miles <milesg@linux.ibm.com>,
	Chao Liu <chao.liu@processmission.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Xianglai Li <lixianglai@loongson.cn>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Chinmay Rath <rathc@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-riscv@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 04/23] target/riscv: wire up empty KVMAccelCPUClass
Date: Tue, 20 Oct 2026 11:42:58 +0100
Message-ID: <20261020104320.3686723-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We will fill in the functions in future commits.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/riscv/kvm/kvm-cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 45ad5e1525a..b3fa0548c8a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -33,6 +33,7 @@
 #include "cpu.h"
 #include "trace.h"
 #include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
@@ -2195,18 +2196,23 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
 
+static const KVMCPUOps riscv_kvm_cpu_ops = {
+};
+
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+    KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(oc);
 
     acc->cpu_instance_init = kvm_cpu_instance_init;
     acc->cpu_target_realize = kvm_cpu_realize;
+    kacc->cpu_ops = &riscv_kvm_cpu_ops;
 }
 
 static const TypeInfo kvm_cpu_accel_type_info = {
     .name = ACCEL_CPU_NAME("kvm"),
 
-    .parent = TYPE_ACCEL_CPU,
+    .parent = TYPE_KVM_ACCEL_CPU,
     .class_init = kvm_cpu_accel_class_init,
     .abstract = true,
 };
-- 
2.47.3

