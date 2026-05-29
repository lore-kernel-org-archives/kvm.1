Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0D38B125
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084256; cv=none; b=fT4Dtv8SGdq38dh/zUH1R3IJ4RJjOIKixQXJ6ZVfpeYxArveruu94FGuFu/E3B4fQRnv3pMGDBIBozxsGtUlg2HboH1qhxAvNvsH2rIU4W/bTG9b9SDdxhACzDJvBS6j0HTRoTZzhl3Hoqz8VAsVQMfuvzBKJb7H3JhcOQWCSEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084256; c=relaxed/simple;
	bh=YhMvEBayKamylMQnb5APUmpmVimZ9LX/3AZonK8Ox34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5pFcnzaKdsgGquCfqwuzZICh+LDjwzABH/pQTDqamyBYZIfh9DMWX3rUgWjQa0uNNxuAmrgGc6SN63X0aMpEd1ijuA8mqse+5vLZtikbpbhO9cSINENthh+5vE5BFbDHmHr/yqjTcr5Pp8E+oKVleSjtu2Y4Oh1SlmI2mDcfKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nC6jleyE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nC6jleyE"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe62837baso8291388f8f.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084253; x=1780689053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8R24Vi/05knbM4BrOIv7zp9N+sUYsxpoHxdxBqTbhc=;
        b=nC6jleyEEF9W1zSWnBL34Cr98T1uZAtoLmNo5Al9vzDHEser1naQ3Hu+sx3t9cPJkn
         yFJWGwWYHX60ARFqKPwGik+WPZ7mmCt/M9mv6MxDvpfs0CHBbFQDEOF93/yY6Q6j9FLr
         /VBUTqYybC9bnyu9ry7fmPMnPePk1UtJzRli2aovjK0jx/1Eqlp801ov7gcwkjuKHlG9
         1omkCqf4xQOcgX30Uyc70tqLLLIAds+tVVHiiY/RV/XsCrTYrnb0dxsS9oBkaMWK5uC+
         0uD1+EMHwziXJxSGGthvw/oDzzC2KiaUrnoH9f7pt9f/EYlYoQQPHN/gtVERZMr49gvp
         m69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084253; x=1780689053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8R24Vi/05knbM4BrOIv7zp9N+sUYsxpoHxdxBqTbhc=;
        b=Fx8aEc1Zqeq/IkuNgg7qF9acMzhYDuvroNWBl258Oe3VGqALgXdWZFKGDuuA7WlCRX
         pb/O7ULAUAy+3Bmayyy73lLdqu+slHNeres/z9Bxn/vBJ5+BahNpCsZ47CpIjwsekaeF
         UtRsFUEJWrV9jTimbkaO2Qq1eAQsLsgmEgwh7qb8Ze7+rMBo0BUQLMkWGnbO1SvYS7R8
         X0NZ+4n96C8ZplY6rfd2L3JbJ7i+9OSvD7UygqIWRyWpCoxh+RKvSYG6XShdPLQY1hDK
         84yWiwXg+T7G/ADLYrYTTQ1MDjqNkk2FYZNfDlSVeRkncc0udJzXj1ur9dmUxBN3fFg5
         spdw==
X-Forwarded-Encrypted: i=1; AFNElJ+pNIfju5SReqMBE9fMnOyvidgImICOx57wkGfCKJI+w0h9yk885zkZhdRwfjEcpUraERM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsh9KZIIW9CZx5drzCvEhMzxx7drV146SoNkuvGSImMErITcjE
	5t0jem3lQijGhxVtqogfXj8OgEsiRM23Bwl7OHmG+I5xBKMbgltpjGtm/IUNY7WteVA=
X-Gm-Gg: Acq92OFBJNfOi+NRsdP6Nmrpg2HsdmAR1Y73XsOpbHcqnLmQBk2vpEH86ozrVJEJakP
	wZpd6PBU9nnNwGy9FmfpcaewM/tMnAiyAiMQRAbSfgdHDu688Ceij2iTsT8izU5hF+9YNIrerb6
	TKuYAbvWOP7UEi6YzxtjByadOmQNAoEHSUI6LIg41JuHNeL2NXqglAVfQc8eWfjuUcszDcPRRDD
	Na3d0pvvJAF9xRUDeeNdX04B27kGmI3emsqFPaIEmNf+Vf2VRMb6VxE5rLTv9K4IvQGd8bdcq9u
	reyA2If/nME9y3cWPOo+BFaOAGBGqnGSBOscKI/ddv7jcyaCiw/HhXBtVr7UibGZszuAkW8x2Gk
	j12Wuv+OuHsc9RxLcyHthAI4uWMqPu4jZ2VnrImmSTVpWS7jSgHbKWnMWQTsKUAjS/yRgOWHAEc
	fPNl3CzRBBcPGYfINo0r6dUdlKMs/KKeLrUD9fX1f03OvWdnK4ctgtJZQOHb74Us27sw==
X-Received: by 2002:a05:6000:4388:b0:449:9aee:4581 with SMTP id ffacd0b85a97d-45ef6b2a726mr1711046f8f.12.1780084253181;
        Fri, 29 May 2026 12:50:53 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3559645sm5427442f8f.26.2026.05.29.12.50.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:50:52 -0700 (PDT)
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
Subject: [PATCH v2 08/17] accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 21:49:30 +0200
Message-ID: <20260529194940.97143-9-philmd@linaro.org>
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

Register the new AccelOpsClass::cpu_instance_init hook.

ACCEL_CPU_NAME("nvmm") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/i386/nvmm/nvmm-accel-ops.h |  2 ++
 target/i386/nvmm/nvmm-accel-ops.c |  2 ++
 target/i386/nvmm/nvmm-all.c       | 19 +------------------
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/i386/nvmm/nvmm-accel-ops.h b/target/i386/nvmm/nvmm-accel-ops.h
index 931bb5ca243..f2a78c12110 100644
--- a/target/i386/nvmm/nvmm-accel-ops.h
+++ b/target/i386/nvmm/nvmm-accel-ops.h
@@ -16,6 +16,8 @@ int nvmm_init_vcpu(CPUState *cpu);
 int nvmm_vcpu_exec(CPUState *cpu);
 void nvmm_destroy_vcpu(CPUState *cpu);
 
+void nvmm_arch_cpu_instance_init(CPUState *cpu);
+
 void nvmm_cpu_synchronize_state(CPUState *cpu);
 void nvmm_cpu_synchronize_post_reset(CPUState *cpu);
 void nvmm_cpu_synchronize_post_init(CPUState *cpu);
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index dd5d5428b1c..60044b83527 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -87,6 +87,8 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
     ops->handle_interrupt = generic_handle_interrupt;
 
+    ops->cpu_instance_init = nvmm_arch_cpu_instance_init;
+
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = nvmm_cpu_synchronize_post_init;
     ops->synchronize_state = nvmm_cpu_synchronize_state;
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 8a1af35ed32..2973e28122a 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -22,7 +22,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
-#include "accel/accel-cpu-target.h"
 #include "host-cpu.h"
 #include "migration/blocker.h"
 #include "strings.h"
@@ -1212,33 +1211,17 @@ static const TypeInfo nvmm_accel_type = {
     .class_init = nvmm_accel_class_init,
 };
 
-static void nvmm_cpu_instance_init(CPUState *cs)
+void nvmm_arch_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
 }
 
-static void nvmm_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = nvmm_cpu_instance_init;
-}
-
-static const TypeInfo nvmm_cpu_accel_type = {
-    .name = ACCEL_CPU_NAME("nvmm"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = nvmm_cpu_accel_class_init,
-    .abstract = true,
-};
-
 static void
 nvmm_type_init(void)
 {
     type_register_static(&nvmm_accel_type);
-    type_register_static(&nvmm_cpu_accel_type);
 }
 
 type_init(nvmm_type_init);
-- 
2.53.0

