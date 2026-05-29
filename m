Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB4403E8D
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084212; cv=none; b=XPpaCu3hxbM47xjW+WKbP//WrjlH57sp5rrSkfwlaBhnascQf7ylFM9bBANDVj5/kolhSrw/L1y9YvLVImuDnb5Yp4tJEYoVRP9ahgQsEYwDuilIPDf9CtZp7sgIEAb8BS9ihQD3ilVIyrD5EzgYtjI4A/Plmqf1Gyobf5mKnUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084212; c=relaxed/simple;
	bh=8+1vrtC6CmgS0+q8xxjYbPNcApILSByUuJv2uSI05H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtC0t77gKGMGmTZn6xEAOFyyua1uyGXdI6HipkiVHcpGcIDiXFzDScccrSXRNNHgAL1gGxQ9z9ccVNvpVwT3mreyFmZbr6oIK2zHU4Sb07ww8IJ0JKIn3ZzctANH7dd1B7ur+SKXg9aIJmnDjZ7/iL5kkNOWPqTlRw/1xZzesb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SFOBxbJ0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFOBxbJ0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso86353245e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084209; x=1780689009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDALMDNynw3GUuarnrLNetX0Kec6G0245sRIZSxkHLs=;
        b=SFOBxbJ0LN4cQ53TevLUBNGfbFRvNpoTfqWijpQGOtghM9HTZdkfok9z7Wk/Z/JXqc
         oPKklBgpE8G6usKOHsI1IuSpKAgHEbP3gdsw35D4E1HxEuST+fkDvJhsh7e7KR8SEpos
         3Q9QoTF8x84kB6UJh0D0ctQijBrETC+iRr5OfOW/JrMctZ4/TszBV57txOMxVloYdE/Y
         DQPJalSwsxXJNznjWY0QI6TscuTNoOKrkvbiOiXGhL5bVqejkiqku7OiIwzbSD1CV5we
         5odQIeCi/IGBYCBQpKfbvVLoPlBXnRCiPqVOAK4vN1W8hfQeEGTWVUC79XnSl3WFQs8M
         VQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084209; x=1780689009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDALMDNynw3GUuarnrLNetX0Kec6G0245sRIZSxkHLs=;
        b=CfyWA3Qds+WFKuVb6x0h22haFWlW4netjlOCbTvr9v7kbnKlt0uVkvnzRekpW0ZB42
         dyoAWpzOO8Qtqmvr48XvtAQm2LRlxL0DcQaiAmarSDrAXpuApUs0XTyUtCI+lODqwORE
         PIP7Gqtp4Hc2OjRomPnvODhdEAbgehEnquo/M/jPXzPWE1c+YpfUOEIcsT2N/dGo93Np
         Ggf/MQ8udpjGDqhcK3y+ioz+fc2gHHEViC4Kk3oaRlEuIynUeHs5tiE00765AAG2GwPS
         aqoL8j9jFrpFT3MQaUhDCVbIDzU+u7qokC6e89n1K+wJPYuX8rnnJRqwuBeCmr/kDEOc
         xvQA==
X-Forwarded-Encrypted: i=1; AFNElJ/gpu3Y1d1O5XWmVxmapc1wvGh4QYWibfScHbBW3EnA0LPsjg4Vhc6RFpk2xcolY4q8PmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx739826D4jb0B1Krcco1kIGStDe/8LKL6OyBTcagX0ogQ9Xzu/
	Zpwt8Q+qZ6uHgBwgzYFkXZOC2hRPM7UwkM9nIsuQ0jIjWy0/8atAEfh6SEYgPCf02Go=
X-Gm-Gg: Acq92OGLcxrOo1kbjWIsBKPrzl/J+pnkE6RDMa8vekOKjhpE7Xkx6YmDP3G3z4a3Pfj
	bzEMxqKicywPBIiiCbrpre6j3iCbQVzVQX3GvopmDt8RTki4oRbCSIONC8W7kCU71W8tiqGFG4l
	Bn2wEItKJWs16Uk8AzjH3Bq9CwZv5TvkDGB6XBfbACc9fD+ykyTP7ctPWB+21nH0s/rlZEhvpjV
	ftwe9iAQLu+/8sTjYBr/k8wsdXuUcNzfBWXzY8nbsjnm3PCfyApy4dDZB6SaMC3PiUqfSpm7epC
	L57H/MABSYZjOcxxf9JEolND+AvBKv9bvx2DlaMko0iqjXl2+vgVR64YrzfMzoqPy9hoGFcaRZW
	/EchigXVbTvrDIu7zDYDufMWtx3xD6f2yYyP2knBho0kruQyFMi0jpEYgBjTNH8pAcRa4HOkaIe
	Fm0XXd63fFhcSHBLZpxFCWXW7a7aPG8c+zUthf5m0RQ4CD7YnsFN29MPLWHzO4cz8tfw==
X-Received: by 2002:a05:600c:8b53:b0:490:a29b:e72f with SMTP id 5b1f17b1804b1-490a29be7a4mr15412425e9.4.1780084209487;
        Fri, 29 May 2026 12:50:09 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0d4f4esm28563585e9.1.2026.05.29.12.50.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:50:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anton Johansson <anjo@rev.ng>,
	Claudio Fontana <cfontana@suse.de>,
	Eric Farman <farman@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	qemu-riscv@nongnu.org,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Reinoud Zandijk <reinoud@netbsd.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/17] accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()
Date: Fri, 29 May 2026 21:49:25 +0200
Message-ID: <20260529194940.97143-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cpu_target_realize() is misleading, we simply want the host
accelerator to realize its things on a vCPU. Rename more
generically.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/accel-cpu-ops.h | 2 +-
 accel/accel-common.c          | 5 +++--
 accel/hvf/hvf-accel-ops.c     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index 9c07a903ea0..fd1307dad6d 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -34,7 +34,7 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
-    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
+    bool (*cpu_realize)(CPUState *cpu, Error **errp);
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index ebc103053dc..176b03e0e90 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -60,9 +60,10 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+
+    /* specialize with target specific realization */
     if (acc->ops
-        && acc->ops->cpu_target_realize
-        && !acc->ops->cpu_target_realize(cpu, errp)) {
+        && acc->ops->cpu_realize && !acc->ops->cpu_realize(cpu, errp)) {
         return false;
     }
 
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b74a5779c3d..6edc2242ed9 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -356,7 +356,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->cpu_target_realize = hvf_arch_cpu_realize;
+    ops->cpu_realize = hvf_arch_cpu_realize;
 
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
-- 
2.53.0

