Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493004;
	b=eGarfTkHC+VS+gv7nnHCya+RVjpjiczB1GK9/2c5osepjNIrSAnaybJnK6QOmIqli7nO
	 voh4BgIaEiOL92qLztOAQMnvaasPWPWsuCrn+LG+Z65ijzhWQMnNBeuWYviap3aphOHPk
	 zrXMA0fHpKfsCjIX9cnMNu5UtRCCyP9BTfQDELjmeSQxDvQZNUQKsYHhvFbYJQdEhmkj5
	 Lb6/EDVglk7ABQ7MWvNvgouf8T5QP1heUJ9qRsiDyrmuPolpk9j39qKvMESkML5eWi2cg
	 xJiQFZ6YOUeOhoCtRXN8rpJn4WWBV2ZscNP3oLkvWhCDUw7tCgl08aOUgTSiSK+p8Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GObncgmEUBUSeoRmmw6cdeZcoKrwnIqxlNvyYUwUu+A=;
	b=4+9kpDnMddIBLpiYz6XgwjILHlddaHSnP9xk+omRxsOOOpO+NUXuHqx7ms9WzDgWhh2Y
	 KAQCT2M6KuNqhfPz4PrkgpRjiaylsAzgpdpjYLkfWs4BWL6F+Qcar9fNBhRHzJNKXWQbL
	 +c9QfRb4YjsIm9ofCiL1iY66crN/mfQq9LvB78RS8ohf4ZqlJVZ57jtEyGdPLoZhWlivA
	 jMpDVUjli3b9zO6xMi2XNE3A9xXpdv7wVB8E5b1T2T8GA5JPdvXrOOOINmR033u0+2Ipl
	 Io/cJ8B9amQTkZZ7kNWyqRz5Xi8UoHhB/gN9573n5duhMdbOqUryl1Ugy+Ncd/fc0gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SQfeOoZZ;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504F606A321
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B504F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SQfeOoZZ
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so21973715e9.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493002; x=1793097802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GObncgmEUBUSeoRmmw6cdeZcoKrwnIqxlNvyYUwUu+A=;
        b=SQfeOoZZfH+0OxpDoCwSYb0malqlpMFLo5DrWncfJA79uYTuW+qspWYKUz1XPv1mnK
         OGOwY+FN42Oegke3uA8Tb22NcJAakOvfvp0HaLE8XuT6SajXmLxYvK8vnA1cK4hHyR+T
         3sRX0hrIYLVmp96Zj0ti+ylkGMUDMC7YwlhWeAOaBoFcXt61uPio+o5dQOZ0jaI4pQUK
         D4dWdQfagpVeilmq5sx1GW3YDud8ndHuWQNkAph/fm5Dr/v5UFPMJg+gB6VSR7sBZd1j
         BYKJHQuIJv0n7t0wX/b761/tiBDmM//mqwjKMxwiCj3zoweU7PURh3Ukd/OLjQsWz8se
         ABtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493002; x=1793097802;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GObncgmEUBUSeoRmmw6cdeZcoKrwnIqxlNvyYUwUu+A=;
        b=GPrzT8FzlwEYL6W7l9nfivtr3p88r+ysf+S2GOKAuda/om8aGEpvxVYL2+B0VZ/m2/
         izIYgodZ6BlRE80gQH5m0pgM3sXPP1LVhDzb/0rzOsz7+RpXCQ6XsNgxxKGF/UqEk8Jz
         zVHyIwXkgQZxw2eladSHgMWXoyu1lUeDDv5WwP8VMYdsYcrqwNwfZmMNSSY7qLZKAi0n
         pdvy3LbaFvjoOfQ8LuQPn4iYBA78kqrawnurordmo+FoaCWVoJE8JyJ45Rr28fjHeJs6
         lo6+ivarTVT8oQikQfd+qn539GH3SqHj1AXR40auyitA+M5qiWJAVj2L3IeuJzW1V0bu
         6Mng==
X-Forwarded-Encrypted: i=1; AKwUvBw0nWM43TVVyhOx5n9dX04uveibN6k8l92eDS2jFg+WzLwp/l0MBAmQaJfWG9SiSOsdszA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdKqrMbFnbTrzn9TOElD6qIDWlK7t908QRrHoW2Ls/fhfICeAS
	5TrKppzv08iOiQ0IuFfOQIe1ZPOuditkYi9AerFwRrI4Mfcmk0h5ygPicxrlTDk7oPk=
X-Gm-Gg: AYBFou2NIDyl64RlqGxw75yDnjMbPh4vdANNbFUBhuDnroIi+IxedyBEOFVPVD/h5E2
	Cqyhe2uYnqNkhD1oOUDhLEOUB9ErPtN7h4o191B6a5pR32Tz6jozByCi8ZVrB47EohXypX7ptFy
	xg4iXVNwlVDtn/SemyjFrewJYRiwUsX9V1dDfJDO7pH8+htS1HCCuYg1p43lbDADTmTsvl0YiLF
	8U/9fNn4Ti1C7FjW+UTUTeXmHmVsHD1cZ41lw65+OoN+aW74lvCJVe4K/gJeXjofkMBH1AqiPU6
	UgmSBAvAk6Nmt8rAwEJ+9rCZ4HREUkXGcxePieDvS0MJ+Js/c4/ggPw7e5zclyQyiz6aUy16xvl
	gQvcOSeSqMivvVegq0cAEO9YxjYmyGazT8APzAL3fIpHeAAG8JSa+hO5TNvNSz3rqzjBz+wVS2Y
	eBI+4A2wnHlneg6f6Q4rt6V+N5tZEGGIlM7Db1/bIp/iLv3IZeMLSZp/5BRJ9ME5OdHN+6qHG46
	VAui/YX
X-Received: by 2002:a05:600c:c0c7:b0:4a1:d743:77f1 with SMTP id 5b1f17b1804b1-4a1d7bc2e33mr147348455e9.24.1792493001951;
        Tue, 20 Oct 2026 03:43:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cc8e98sm67312705e9.9.2026.10.20.03.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 743535F957;
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
Subject: [PATCH 02/23] target/i386: wire up empty KVMAccelCPUClass
Date: Tue, 20 Oct 2026 11:42:56 +0100
Message-ID: <20261020104320.3686723-3-alex.bennee@linaro.org>
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
 target/i386/kvm/kvm-cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index da8d77ade06..9de107a18d5 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -17,6 +17,7 @@
 
 #include "kvm_i386.h"
 #include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 
 static void kvm_set_guest_phys_bits(CPUState *cs)
 {
@@ -233,17 +234,22 @@ static void kvm_cpu_instance_init(CPUState *cs)
     kvm_cpu_xsave_init();
 }
 
+static const KVMCPUOps x86_kvm_cpu_ops = {
+};
+
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+    KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(oc);
 
     acc->cpu_target_realize = kvm_cpu_realizefn;
     acc->cpu_instance_init = kvm_cpu_instance_init;
+    kacc->cpu_ops = &x86_kvm_cpu_ops;
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

