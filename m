Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC813A75A4
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084238; cv=none; b=oYmoLIyg9976kp+aWh5QJ3+gHIN28BRU3/97WB/QbvKVYPtLcqElhtPggwQutIW00W6lK9C7jVGmw0B+72oDcyLPH6G0lXrWKju3l2RzhQ0kPh6wmvmqc6v5F11Y0A4KwC+6CRt4hQYELLjA6aHWoCruocqCVMoCRgw5R3dZRoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084238; c=relaxed/simple;
	bh=/pRqpc3UskVJecS2CxZ003edYm9v5ogG53B2DZE6EDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7fB473M+sHky5ltn2FxgiU+irnX3kGSJu8oeV1eF0kEqNXBC1APwqVKw1W3ASBrTFZXtOnEN5ewVKwabUKomiRxycmGCEVGvzs8Dx8ZoJPxZVcXXmnNoCKra7KJYuJEqLTGmldKYXcMa6mZoyjPrrOI3ypCPUoH2EpNZu6WRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjkGfz7P; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjkGfz7P"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so4926698f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084236; x=1780689036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiKly4HPenv8/ZKUBSNL5mBIXiH6MvoTy+hNbg4YgG0=;
        b=AjkGfz7PthhlJKgU/b2jBHU3jZHwlvmM8OW33YrwLcaR7dcjIrt9m3mnKRpBa4MKlz
         GVbRzTi9o/m90gSaIax/nVZJD0UrdCmVyt3BbT4CArJK0fJ86gtzEgGWKe03QmXdRfzK
         iEbqofPjOJOmjhbLAWiJLQbVvb3aGijYbRSihRgHskxJxS73EV12CVvMvzR51ZeqDRS6
         ySvw4VQvG6+ZkzXZKspqc7r+puk5MEjEkwggpuUXD+FOIn9fEjNdh/7VyWKMjd4IugiN
         1jwt7grT8dpJcWG+5sZKjtinn6hL0oRTnKm/VC+C82LE32PqZUoCCX0wIW0cL78gGNdn
         HAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084236; x=1780689036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LiKly4HPenv8/ZKUBSNL5mBIXiH6MvoTy+hNbg4YgG0=;
        b=eyYpSSmTv+Z41/UmWRY8JUFgiwiPoBWbfKWDBF7jYa/6P6QQtji2ERmtc/KD1tNQN5
         kCeBYfdcf0xTYdZz+JcaXmPhpArfPJeCTzuvDy/SzY476RBNTJW0k7aLjHLyP88bQxuX
         Zq+6pNQb9m00TSrgRXHH6l0W1TUNpZy2fxQzbVpfoX3goSpNPtXzuT1FHYGVeKLE8oSV
         esiKU+kBud9v+ApL086anMwzSjhiT1gAwOR/l4TGI7k4Tw0NNizmIPf+bkaHt1Fx7Ysp
         aRSBucJl03kl3oOHIcIwEHO8AeEtcCYKOhW8syxRTtR+uK4Frkt3Dkk2tAzvyZpg+6Bk
         M4Ww==
X-Forwarded-Encrypted: i=1; AFNElJ8nfcupaNktCSjJedYH5goSato81bwky+U6Ip7Sld/duIp0of+IUrp4NUq7luRBeXQgEsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJC38Jrolcb7Ph+VmZVdCL9ngcz+4oMK3rDRoTTiMjMxmgahs
	Wzcw+zPF7epES0RA7zyC8MRa1HVlGxwvZ+3wJ6mx9K3nwNcN/bVqb77OJPb86hKsGp0=
X-Gm-Gg: Acq92OEhh2GsPTpmyoj+tZQPuveLpyyMHOfzYHJgjIJjcgl7bNFJWzW/AlV46nvHmzj
	PngsKgn4cJHLh/lSpbHBK4ivgTbapgtgAKn7zsRFcM+rpoIsQKGimAnAr00V+jGTv1DjP2l1s5L
	Zb55jdHJyXsqeXwICc6kN1veWyxesuKcA5zYwuiY8AXJGZMLz5fK9aXIX8abcujKqFGFUMickhf
	K+ENoN13z69voNvExsKl2npcUQ0Qhu104QaHXm1XYGy9H33Rc1cCPnfKmlxFOzsmfc2O+d97DLy
	jwNMracr6CRfjSnrDBW5DvKyhtaGAI7uAdsrQUCzKVzzFopa8uOAPvEJWyyPAcVwsyinErK30hP
	p7sVuVVdeyAeQGl65cYLcF7tcpSKkGNtANgtT7W4AEgf4y/ZqGFpncz7eWFlIF5OAU9l/NVWpw4
	v9VRi8pA2X7BmVBFveo0fsVRHf9PrFwIjW/28USGFWURIEL2/IFxZbqgbCkOtapEeZxA==
X-Received: by 2002:a05:6000:2812:b0:45e:73b3:4515 with SMTP id ffacd0b85a97d-45ef6b8c2e1mr1557937f8f.35.1780084235811;
        Fri, 29 May 2026 12:50:35 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a03f8sm5924106f8f.7.2026.05.29.12.50.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:50:35 -0700 (PDT)
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
Subject: [PATCH v2 06/17] accel: Introduce AccelOpsClass::cpu_instance_init handler
Date: Fri, 29 May 2026 21:49:28 +0200
Message-ID: <20260529194940.97143-7-philmd@linaro.org>
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

accel_cpu_instance_init() currently dispatch via target specific
AccelCPUClass which we want to remove. Introduce a similar hook
in the generic AccelOpsClass structure.
We will convert implementations from one struct to the other, so
add an assertion to be sure only one implementation at a time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/accel-cpu-ops.h |  1 +
 accel/accel-common.c          | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index fd1307dad6d..9810cc27cd2 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -34,6 +34,7 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
+    void (*cpu_instance_init)(CPUState *cpu);
     bool (*cpu_realize)(CPUState *cpu, Error **errp);
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 176b03e0e90..b3bcd53a4c6 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -39,7 +39,15 @@ void accel_init_interfaces(AccelClass *ac)
 
 void accel_cpu_instance_init(CPUState *cpu)
 {
-    if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    if (acc->ops && acc->ops->cpu_instance_init) {
+        if (cpu->cc->accel_cpu) {
+            assert(!cpu->cc->accel_cpu->cpu_instance_init);
+        }
+        acc->ops->cpu_instance_init(cpu);
+    } else if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
         cpu->cc->accel_cpu->cpu_instance_init(cpu);
     }
 }
-- 
2.53.0

