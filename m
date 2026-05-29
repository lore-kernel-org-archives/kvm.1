Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0E3438A0
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064777; cv=none; b=ihpFJAKEbhjCoF/+Vh0BM4v6IwSdWvNcCVKjA846P/gXypVpLQgP8DYK4TUv1NZ59LLOQcqvu/u9ywSARLfjaoHZG7lHmzAc8d/bIlq+EtB5O/P+vqtJW73wz2JFSPuDumGObB2bG1LhX0lAqAtooFPgLCb/cbhGcJ1Ns6KfJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064777; c=relaxed/simple;
	bh=gweSzL6G1vxC4sYDfbhjxkwEBM/V0G2UqnsV+ZoOvwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sc33xgpH20OTp4TmdBC4gnaJqEx9vlOMVhH7Lt/Ripwgjtc6y05utBBrCS1v4Rh/6qm/WsDVUuPPgzX33bpsmuD8w+GQL2CU71YY99rbXZAkxAb30Ea6NHzaDUiiGlfHzR3NHPCHM4t4Kd1hmoYwnruDjSOspNwGFwQ3X+/5JZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ysKTqpO2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysKTqpO2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44a74032ff8so10481929f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064774; x=1780669574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/Ui1jevrZtyJRpeW9wEoANBK4xBgFParODxQakXLb0=;
        b=ysKTqpO2mU5Q1zP0KOIcCnWFyhjct5Aft2aqJG2nxGfNzXwo+4LAFbirgCqexC3fcV
         dSKZkdkuV8LUgq4VpyCoNIP517wzaRg67cB2nDE5GTvzOsr5aRpjTv/rThTLSa+inRgq
         0coiAJRhFVm39Mx1AbWAgENtQ00PbTfyaExEqjivUkQ4ByJ7AxaPW1BBhiyWFcsrA3Uh
         /tNq59PAo17Mgnh8z79foLHuo0sB5rMent5F9ww9nm2XCAVYiUFZlP61f6ic9RT7HIHR
         No4fzT/BjPmGvkJmzeRzXwLHs8pW+Nu0mtbNm+A2fRI7Itw8wm5qwuGL5169j1dL1E1I
         lp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064774; x=1780669574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/Ui1jevrZtyJRpeW9wEoANBK4xBgFParODxQakXLb0=;
        b=FO7pNgXH8CZ/3PfuecKFzq3rGXU3ty/g17bgdc7eIpvFXYl/aOsNIihzKK4NOVC9AF
         Vv38qoGwREJGXOTtJmC0nypvIELF6eF5YzsbfNAcBtYmx/cOOl84iOcMtvzKG8hjPJLU
         wGuB9kRKbXoCcLD+jONOUm6+0CtbQkTy7z/bEhjeGA0eB56zzQpFpw/YcYfoiDgvt+DX
         ucTTP74DpZJLLk72yF/8gDZJv75asHHAQSJN5U7AayE+SppYzAgLZinORAAOvaHbDLUB
         owXdl9DSzvAoVuAxftFA38xP3pVEUNZHnHvu25VC+GLyyZyS9dyz8SFrlTpDQSSymkcQ
         YP9A==
X-Forwarded-Encrypted: i=1; AFNElJ+DTktjMVLLrdS5MWEgD3YnDHHgy893yMLc7QZUm6y0IQyyDio7HmflvHtBvn5JkGNR4R0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32C1MO+Eki3gX5aup1zRNnTBG72Ss0jyGd8M8ZjjiZaqtbEn9
	GzN/C8l56lxa9mjopGE7hnRoGUamb8+h4Nh3pM1eOiP04fgja5Bv7Vl3Vftb9monVtY=
X-Gm-Gg: Acq92OFJQLemJJOrIaOds9Lx/KiQjo33DsJ2rlHvrB1ZGn+clC1Xq/ryyDJ3a5KKBkA
	BsTPagaOS6uFaPrQdGNUvQ4TAVUVPunb3KNqyKvFc8PSbe6LSXazlh+8Gya5hlqs6qJAxvRVbGd
	L3RlqIsVNE+dL1N+FjJj5sLHRkj/+aI/SvGewUJLJX63FJXuKNSb/UhrDbxCqb5akLiMB3WogIP
	1aktH24GIsrSeE8vnw7b7ieoTNsRS4OkIQ9+Nw2qbLMXYSfmI0o/ZJFv5X2uHJ1OOLtn7FbO+4Z
	CRF+KZrJ+ApWWKpLPfw5j4rE8+Ccpv/8xCCH76IAl3eU1A+a6Dg5lTUxNbYf4OdxjNlNZbQQcWb
	JhYqcW1II727yYdin5IjfbU2rCVk9HPbS1p0ztoVInTWbmC88WU/JzBmp61mqbFV88pJAoFAbm7
	WTpzJkCbH/yXJgs3KFcnhUpYWjwz/VARLyKuXPrz076Cb1S9OoGggE1ugyQSAYbt0YoQ==
X-Received: by 2002:a05:6000:1a8d:b0:45e:ed7e:f8f7 with SMTP id ffacd0b85a97d-45ef6ae96e5mr159213f8f.2.1780064774383;
        Fri, 29 May 2026 07:26:14 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c50f6sm4494831f8f.16.2026.05.29.07.26.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:26:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	qemu-arm@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Song Gao <gaosong@loongson.cn>,
	qemu-riscv@nongnu.org,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Alistair Francis <alistair.francis@wdc.com>,
	qemu-ppc@nongnu.org,
	Weiwei Li <liwei1518@gmail.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	kvm@vger.kernel.org,
	Claudio Fontana <cfontana@suse.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/17] accel: Remove AccelCPUClass::cpu_instance_init()
Date: Fri, 29 May 2026 16:24:28 +0200
Message-ID: <20260529142434.87880-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We removed all implementations: remove as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu.h | 1 -
 accel/accel-common.c      | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 88c0815e2d8..c42221f96cf 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -15,7 +15,6 @@
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
 
-    void (*cpu_instance_init)(CPUState *cpu);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index b3bcd53a4c6..04482b6b57e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -43,12 +43,7 @@ void accel_cpu_instance_init(CPUState *cpu)
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     if (acc->ops && acc->ops->cpu_instance_init) {
-        if (cpu->cc->accel_cpu) {
-            assert(!cpu->cc->accel_cpu->cpu_instance_init);
-        }
         acc->ops->cpu_instance_init(cpu);
-    } else if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
-        cpu->cc->accel_cpu->cpu_instance_init(cpu);
     }
 }
 
-- 
2.53.0

