Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D42F8E8D
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084296; cv=none; b=N07qf/BE2bjHVbapLAKE154U6ouXGaEWzmyUylsJ5P99umO/haYYu4nkCKNU7WPq8jOCQ+nfwgEPbBBKv07zyHUPKSqWEsx5zxp/GyoFu4b77yv3A36qRELwEzeVThjKIlDvzWTrENq6IvDmhTfHp+uwhvQm6AA3cjZvmb9PUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084296; c=relaxed/simple;
	bh=SLd/SEI+5T04898B2FPyIlIbj/QPfodYC225rfuFe6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufqRRxcBBya8P4ixF7YDKyC2rQmc/KhMSTT8dALbEjv4YhZdmtT6C7vNYytfeSlRRHLSrUQNDKX5FoEymUQr6ndDMtcCLTUavQGpHpcOag7eUKztg+LvD6Q6P/dWbU5vGmeFxNQMjiSALJYPjJpwAtwZ+0eK4UEf2wEMhdz/ZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uq8JvbK6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uq8JvbK6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so97412905e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084293; x=1780689093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riKUeVRs9ub8yVsjePlaRkCop7k1tSoe41wdpPTuHRg=;
        b=uq8JvbK6JXYw+l53KEgcv7sTBCwjYQg5W6wXbiYJuJuYMDqLHwHvgkbpLJIqXuUP0I
         aAXHbET/3y73CcP+SLChUZtHdNj/lfOKiEbkfZmeMMyYPYDNQtANGqtjBU7q6ggJiP5P
         /zdF/A5yJzRjrAIyjXSl42RNk1ed6T1OO7k7PWxRuK/AIcA//PKvZ2/Jgm0BwhkiSyRy
         vk61/TXSS1zQdMRWJlJ1Lcbiz84w9g6+2f+zWlkEooHDqlSRDGFbBb0prYTGtKsrkShx
         oAQ5eOktIx5oONBxyvl3vM73ZtvpV1GajNRQMltmaB87NloyaZZzQLE4I9IIGvUZWYQO
         uwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084293; x=1780689093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=riKUeVRs9ub8yVsjePlaRkCop7k1tSoe41wdpPTuHRg=;
        b=qFUZEYln1n6bLrSEcGR09VvxWh/j4+rkfiRMl6gZZnFMIBAls0jxcFtvsvIkrp3KA3
         GZJZ3w0uhqoedG6IskJKkKRELknp4iyYtKDapAmvqP5VdTq3QZNVQAKounrpUjTNAytq
         hG6segYjrDtiJELFOs0lClxyI+HpmykNylRy+iAMhwQeh3WwR3HpnWwtQ/mrTVUCcy3A
         1+jnzFou4nxNClSzgvPXWWV74VgBqETJ/Shp18/fs55AAn3RIjE31i7swEM8Ej+GpA2w
         ySjMXkcoSDIFz0/cRRQ0FsIbS8oTNBEG3eT28sIzHfEOnL23PvqcMnpeqby57UN6umWM
         QTGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ukv/QnESNyQD5FLJDrEbU+y1ySiorEruoanf7Ujg2FuAXeQcmKWvOgwzZfPkSZ5uH+yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYiX+gTxmuJReJ9fA7Zn7rL22TkJSxxXXOYV6ixsYPy9AXa1qR
	ULEU6aiRxAPT9qAnbkTsfrr/FJjsW59bxFk8cgD+P5Oh7CbwV2XoPendyFEK4EIw4CE=
X-Gm-Gg: Acq92OHpkuN+S0J3UIKeUbrR1IkpnOUZpSKNqBwbOYYRp5C1myXHVe76BPCUXJID+SP
	0LY/MfPn2rii/F+NoYtzr8YXHrnZcmiw7XSSeUbnnIU4nyPSUOFL7rlSzOuiYB8YUAM/cSUIoRu
	MquNCuzDTyA6UQQ7JY9soh2RI8thW9zR15y5dBPStzu0YYwKyFdiYBWjnhhnzHcysFGoOhynnvf
	y+uIf/GOmNKhygj/WGYHVEbVgw/pUw5F1xnWy+cUSYdEO1Dx9aj0fl6TrcKgbFLbPhhRv00y+qj
	A1bQvAWqlPcwirxT599bCftUjustJ8LcCRDUNKmOGEim0ucE1mxhFiAhbjIWRsopy+oIgyXJqfA
	+V3Y/BlO7siIVqsJPPvh+SSsTXnvz820yGolxJmYRhZH+VeX8+GWxrA7/xM7ZNHdYnm935Hx/K2
	7Ylj4YMNxwu3F3F5YkFUGJ8ElVur/gFAnEAsVuSwvyyYvQWNshzC7cppuO3eM+foxqEg==
X-Received: by 2002:a05:600c:4fc4:b0:490:6889:202 with SMTP id 5b1f17b1804b1-490a29639e6mr15945915e9.29.1780084293478;
        Fri, 29 May 2026 12:51:33 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a065esm6076264f8f.5.2026.05.29.12.51.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:51:32 -0700 (PDT)
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
Subject: [PATCH v2 13/17] accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize
Date: Fri, 29 May 2026 21:49:35 +0200
Message-ID: <20260529194940.97143-14-philmd@linaro.org>
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

Introduce a TCGCPUOps::cpu_realize hook and call it at
the end of tcg_exec_realizefn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h | 1 +
 accel/tcg/cpu-exec.c        | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index d7d329e419d..5eba6949ba1 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -49,6 +49,7 @@ struct TCGCPUOps {
      */
     void (*initialize)(void);
     void (*cpu_instance_init)(CPUState *cpu);
+    bool (*cpu_realize)(CPUState *cpu, Error **errp);
     /**
      * @translate_code: Translate guest instructions to TCGOps
      * @cpu: cpu context
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ef44c12b601..1efa3bbe53d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1056,11 +1056,11 @@ void tcg_cpu_instance_init(CPUState *cpu)
 
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
     static bool tcg_target_initialized;
 
     if (!tcg_target_initialized) {
         /* Check mandatory TCGCPUOps handlers */
-        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 #ifndef CONFIG_USER_ONLY
         assert(tcg_ops->cpu_exec_halt);
         assert(tcg_ops->cpu_exec_interrupt);
@@ -1081,6 +1081,10 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 #endif /* !CONFIG_USER_ONLY */
     /* qemu_plugin_vcpu_init_hook delayed until cpu_index assigned. */
 
+    if (tcg_ops->cpu_realize && !tcg_ops->cpu_realize(cpu, errp)) {
+        return false;
+    }
+
     return true;
 }
 
-- 
2.53.0

