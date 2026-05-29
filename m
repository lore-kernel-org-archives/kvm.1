Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580402F8E8D
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084320; cv=none; b=HdAoeWJQpTJCZ2dElhH/xW7qxeHJSB1A30ZI9qzB4MRd1rjX1oIhixdowYqWCyXMnOCbVWtQupEq81RZV3FZA/3sbzoMIl2vY7Ubi8rrUvzrnbMZIivJqkBW/clSgMcPRACZSqghw8XLPAZQqlril81DjvQE4b3kdBdfSO6Pl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084320; c=relaxed/simple;
	bh=tE7ae8M9iFXrqDAV+tcG9kQgoNeOMzmvNQjpCO4Z9Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEFM0QJmjiCQ06gpG63BvHTDrn3gKjNJAtCMjVp/WdnPTJdXpTj5vydJm6F/XUbqYn0QRkd89rf63Omp+ZtOSXWPSTrjD0etE+pbAdYYwvzkUx3qCU31Z7jSrFaWpDUQbF6S5muQi4/I16tRIJvQZxTkjWsnl8rD23cf9LZFcDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mbtPRk5k; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbtPRk5k"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso69048465e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084318; x=1780689118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7VQCJEvvCPJhqeFVLwDWN0jMeOhEhmoHcnTRqEwJrI=;
        b=mbtPRk5ke3aZgwZ3jCdG5Jiz7FkFvpBlYQ/KfFnNB4j7WO95kQHECNBMrILanVU+Bs
         /RfclcOIlA755X5/jAmXonQ5/l1t+5LDG+PmG7gX9BvJYuGexr5nQAiO26yewjvh0P9z
         0MEDqAuQvPPLRGbqkwixpS18EB91QjKAJTjX4dezSEpq0zMiaoRRhbDpS9i6OxjY5Jfl
         zgfqgz8jCZgyilUj4XqXqo6PrWqxO99LnjEwVEzknIrHXE61m9I9Kxy/S3j/HJF5ehat
         qpkOL/5p9YLbN6G3TPLtG5ZKWWt+9DnBQRN8yC1pHCJ9ABZc4n9y+HZv62sls8apR72i
         WwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084318; x=1780689118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7VQCJEvvCPJhqeFVLwDWN0jMeOhEhmoHcnTRqEwJrI=;
        b=CczEd/elhFIQzteOif35PadENFWo5ubSo+8OMWRKMSO3bvfgdNfHVs7wQwAoQHQb8U
         W28WEVJPd96jTWZFKGiap2ICjeL+d9z3JQt92/YVvJvzPW/dNaEblFCfwL6OO4sZUrF0
         oqubMOuWgquejSnbaoI9/t/vahQixP4bIxnPKy8mYJ8Mmjdv8Ooh88k0NkybYAkWAYVQ
         AhSxDd5LynRudErpLxvlI/6EjP4SUV1PZuBqS7tQgozQBZzfR6QDyNY3u9GF7bcta9AO
         dvpNcEuZh0RKklhd/BCNOnAJ3CAPE7J0ZRIuxOJ+gqpVYgkvrZPBriuVBdKKuJF5Phpk
         Lvxw==
X-Forwarded-Encrypted: i=1; AFNElJ9ANoND2Lck4EoCy+T/gxu0r3Tm8xBd0s8agtJLS5iiOWxL7vrSChYqoYUojn8EDXIOd3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1F6puRTVa2xn6AnG1S+VZOEZmcXA4X/+UXDG6yYjEYGjaR0Sa
	Jk+g2KaTf+suBMbjwyZF23A/emGn1Cj39rcH9T91eOdzjd5dnJ1Wkv/DgquhvtYWKJI=
X-Gm-Gg: Acq92OF+puWyTXY5grdpLdEmQRZSadQRRG5fgaLRTimbMujj2E5hX9UWZF6zIVKx8aM
	wNLFvnY83+UlU3MjP6w5asRVqfgzaXKRVJB7cI9XkTjzTFO95cSH23UI6vCi4PRl8c9mxTzrIbd
	klpoilRhQ1O3gTAydedShp1X38TKtqHYqBvCNR5zp6ZcB0JM2BuaLDhZEeGUGs7V2GkBZpplCna
	Rzr80dUD+Hyy8JAdWBctdeiYpPG825kYbwt1YNIb5KhKE4dM1PunYU5x5u77kbnPfNf+PDG0QQV
	1Flnt+YYY8/FLePQQokmjFMyxSbEgwOpzXa8woAZPvoqOm4kLacX55xjwW5ASHjTBsVjh6IRveG
	5izA2Z00ulEwOFPYyLDHq4YSsKnfTBPLPoh62mqacBSzcW6KoKXNsF/xrGaJtwv95/3f8iXGgKj
	tb1k1yFOwW7+8a9tLFjciNYOoTpa3ORtNCcHtavBbpp4jjq2NA41R0XDXE/r8gwHgO37hxSRSgP
	wvh
X-Received: by 2002:a05:600c:4f05:b0:490:50e8:45c3 with SMTP id 5b1f17b1804b1-490a28cf434mr17780735e9.0.1780084317679;
        Fri, 29 May 2026 12:51:57 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68b853sm62908705e9.3.2026.05.29.12.51.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:51:56 -0700 (PDT)
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
Subject: [PATCH v2 16/17] accel: Remove AccelCPUClass::cpu_target_realize()
Date: Fri, 29 May 2026 21:49:38 +0200
Message-ID: <20260529194940.97143-17-philmd@linaro.org>
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

We removed all implementations of AccelCPUClass::cpu_target_realize,
remove the calls in accel_cpu_common_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/accel-cpu.h | 2 --
 accel/accel-common.c      | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index c42221f96cf..d7ea45ada2e 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -14,8 +14,6 @@
 
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
-
-    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
 
 #endif /* ACCEL_CPU_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 04482b6b57e..d8ee6d62667 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -52,13 +52,6 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
-    /* target specific realization */
-    if (cpu->cc->accel_cpu
-        && cpu->cc->accel_cpu->cpu_target_realize
-        && !cpu->cc->accel_cpu->cpu_target_realize(cpu, errp)) {
-        return false;
-    }
-
     /* generic realization */
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
-- 
2.53.0

