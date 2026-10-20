Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493020;
	b=glgyPRR6Lds5DLZYEnHwdXoL3vEkdPJRKsZb4963+U5mv11zAho26f9P8qZI8MWtewVM
	 rjjWTd7by53b8fHy8OCMFUm/uzhOrtGt41gMWEtszuXamAKJulfKbJTTJsMUovX02QZ9m
	 k3BaNlP6VDMD1cNmHRwJtyeuYHD/UzEGhfHshX5ZRZ1FuiDRpY4oeUCQyvQZm1X8cIkZH
	 jWKPfRHcAGr7SqHtIr4cKtWeFztuSqRnFeh0lB3V34p7AiFmWDsFb5Q3/MesEfrxV9Kk5
	 NyITviUGoI72ihgBk5V+OAj0pSSGOj6ENHLzXi/K0O/2b1Y8JR+Mxjlg8LHptjHKocA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FGqirORdiYAHpa8WKE6kkRgcY8UYqpJTtFDjbgGTNq4=;
	b=c0MGMqNOvs00wt1rVwNc7sv0cGdxSPSsKLCt1MNEQD4bAjexiwZsuirW2VJ/a4n8QdD1
	 RGxgNbPEAO+W7Rw8kqrV7a9vV9qGVt03UGTXrydKxn95+NqIuBXWexi9O0Wzj9kB0TAhg
	 pURoDmAAvQX0bPXdhT+fM2F2uxCEj8ERAyVXJLkD/VQsZswZKrEhK2O7tpJeYqI/4mIwa
	 YVJUA/IMAwEPeZpVMVpdSoWYWWNDkOgDe+7mSBwTaE10LEgK+jPdTfpGQ02aGpV3WO/Ks
	 DAHCcu419AI3bVUm/CbPH1xHsg3ayy+RKbKnTjZVW5zbFrVyx1CSofhqBvQPzZOrXXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DWFqZ4LO;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1E60A5BEB
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17D1E60A5BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DWFqZ4LO
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b042c0728so917819f8f.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493018; x=1793097818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FGqirORdiYAHpa8WKE6kkRgcY8UYqpJTtFDjbgGTNq4=;
        b=DWFqZ4LO2HuDnGWPeLIZP2abG30jA4IBPhFfa5fZsaIvCmv9zRAfHnxU9gcCokAfwT
         IceWU1u3YCB85iGeLpzfEH7jwKLI1rPSROnbUPMdCnTD8ggjar9e6W1zrU9tIZ3dK4SI
         fXaX4WcGbSJFfcUrz6n1ly2NR3rYoRyFI/Pax18pnn2ZaulweOSrtqCUKRsSh9RmqgLY
         Wi5EIudVrNDtQkHmlsOXCfqFQtiP4c1I7Fggjh90f4Lgub0Iwq5xSnN95mm4FYi0/b0T
         qWXvTUJuyahPMCCWdBQF1dE5JTrlt15z6bgSOsgTOBH8n2D9ZNXrbyyqXNDHNPX/wfq9
         AD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493018; x=1793097818;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGqirORdiYAHpa8WKE6kkRgcY8UYqpJTtFDjbgGTNq4=;
        b=EH9bfoyK/UhUIxQD3HQRbgdieGl5czToRhqUeRQAA736w8/jKraupG/AzVCobJ6gKQ
         KoyQGKpkeux9yd/UqwUobpjr4mC9GGIftf8VlUryjC7BhTLuKSRNSZqa2qmk3OHinDrM
         FjpScHHx7jF3dkos4At2ExWQhQELck1jdBbm28ZvkMuf5j34dRSs1jx/ArSZLzomauxJ
         HNNGjjcfe0N/kEwWeh0WkK63+x2jwCjor04Oii+JwM5C7YYWgBxlsnolS7KlUIVAsgng
         Oe1V2Rw3kEEGFdAqXY3tqq92USJEoamETRjokylQn+po9CjpOuoUzpvYP8xenx0fmU6e
         LHDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzQAsArvoX3X3mZoc94DknGnFthBZMeUmzC5cnQhAqOQd13IfM+cRcojZ+Ni+UtjfrcAE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiEf1d11FLlipMq7iqu8TteGyfaS5kd9EHBL4jTZamd7G5OVzP
	IAJdy0irBqD3QLGhPM3wTZPS9pL5zYuG5JLb3bjN59X71/JzxTgyhSi2GJAm6f+wjSg=
X-Gm-Gg: AYBFou12up+6RvQKttu0dDtl/7uSK3SWXXMrz3fKPutPNzbZtK93V/MZZgueR0uJATW
	JFxHBzkxhxif3JMlxquOMdc5+metPSmE88SZrzzcG/0330oHrrzaVBEKiIvjsGYTiL0Y4hhloU+
	5J7f9Tudz0oZx7lklO0f0rY8/PpHMtMN/hs8el5TdfNPrLt1bZA8DEXA6uN6mjLUfa+9Eqjc9ei
	aNYzRbkfHmX/Guu9JkGtPqdUk/cGnFUmc1sIiGBECiXH97Vz9K95MC8Et4MBpUPqdIyH2ZDyQMY
	tTvSLG8e8xYZBfUmA2VHnEiyrzwi/tNm+vGVv5sPWsewvEmVloer69QtAlxWs4pjaAXYzqK5I3R
	KY5rZ5MECH65ZfgvEs2zMER9VuDSpczS5L1C3/K0VaN/or3vVjzW6O4AN9jFQsU6gc4oJTygGSo
	kzoPxiNw4Zp+DnjXK38kJWpR/HqKietmrgSpmGcEP2WN+xXrE/MGiT1IDNnoNlbec2NDgC+w==
X-Received: by 2002:a05:6000:186e:b0:48d:ee0d:8b3d with SMTP id ffacd0b85a97d-48e07f9d49fmr23637520f8f.28.1792493018396;
        Tue, 20 Oct 2026 03:43:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d83a338sm5303864f8f.59.2026.10.20.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id B49C25FF9E;
	Tue, 20 Oct 2026 11:43:24 +0100 (BST)
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
Subject: [PATCH 23/23] accel/kvm: remove redundant ops checks for kvm_get_cpu_ops
Date: Tue, 20 Oct 2026 11:43:17 +0100
Message-ID: <20261020104320.3686723-24-alex.bennee@linaro.org>
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

We assert that we should always be able to retrieve KVMCPUOps on an
initialised system so remove the redundant checks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/kvm/kvm-all.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 041113ed9b5..8b719d6eb44 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -455,11 +455,7 @@ static void kvm_create_vcpu_internal(CPUState *cpu, KVMState *s, int kvm_fd)
 unsigned long kvm_vcpu_id(CPUState *cpu)
 {
     const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
-
-    if (ops && ops->vcpu_id) {
-        return ops->vcpu_id(cpu);
-    }
-    return cpu->cpu_index;
+    return ops->vcpu_id ? ops->vcpu_id(cpu) : cpu->cpu_index;
 }
 
 static int kvm_rebind_vcpus(Error **errp)
@@ -3190,7 +3186,7 @@ static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
         bool stop = true;
 
         fprintf(stderr, "emulation failure\n");
-        if (ops && ops->stop_on_emulation_error) {
+        if (ops->stop_on_emulation_error) {
             stop = ops->stop_on_emulation_error(cpu);
         }
         if (!stop) {
@@ -4004,7 +4000,7 @@ void kvm_remove_all_gdbstub_breakpoints(CPUState *cpu)
     QTAILQ_FOREACH_SAFE(bp, &s->kvm_sw_breakpoints, entry, next) {
         int ret = -ENOENT;
 
-        if (ops && ops->remove_sw_breakpoint) {
+        if (ops->remove_sw_breakpoint) {
             ret = ops->remove_sw_breakpoint(cpu, bp);
         }
         if (ret != 0) {
@@ -4021,7 +4017,7 @@ void kvm_remove_all_gdbstub_breakpoints(CPUState *cpu)
         QTAILQ_REMOVE(&s->kvm_sw_breakpoints, bp, entry);
         g_free(bp);
     }
-    if (ops && ops->remove_all_hw_breakpoints) {
+    if (ops->remove_all_hw_breakpoints) {
         ops->remove_all_hw_breakpoints(cpu);
     }
 
@@ -4116,7 +4112,7 @@ int kvm_on_sigbus(int code, void *addr)
     assert(code != BUS_MCEERR_AR);
     assert(first_cpu);
     ops = kvm_get_cpu_ops(first_cpu);
-    if (ops && ops->on_sigbus_vcpu) {
+    if (ops->on_sigbus_vcpu) {
         ops->on_sigbus_vcpu(first_cpu, code, addr);
         return 0;
     }
-- 
2.47.3

