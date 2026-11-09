Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263499;
	b=bHcGsQJj8aGX8t5hHQ/F3UHyz4OuCZ0UNFN/gARZ6OQ0HaiDgIPAHoxKoHc3U1k5QwN7
	 5h2GRph7YqVIfK1FfE9VAeKkrARADWC2Ky/rG019R4cN4VkJXESX+8jl5zUyuS5afxLIS
	 OilmiFDQaSIV4ZwJWo8LT5JeQWC9MtNMtPSBCeuhqsxd4afn3TgBfb+QLGV9zhcP4T/bU
	 Tx3PDD8d+9j0LYoWdIOAks85TCtIalF/3gwGtUzH1vvQlHg7M3ZWHL5BMFc+Va1AgJtu6
	 TNvkUnEpRvVTTNIiP8wZbzxMETTOpBlAS7mYNtMlIYN7QqGB+J7GqQcCA50Es5kFVPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7X4i7OkHzRC4cMktPkHHhhvRPMlG5nmERGhXlWKYtTA=;
	b=sd0ilSOZqJu8REeBsiRXIerMD/E/IBQgssT+/iF6y3Tag0K9mvm0+c9hp1Q+9ojmycID
	 LQN0Rqbl1JL6ZlqB6Af3Olx4NvG51dRhJ3TslvpiDg4PIxhcWlF5xBzKRGbDM4yyW8XVj
	 vAaH3BJ7dYPbrQpd8b29xHzuLODDCcFWlnkfscK3d74ldePE703rOarNCiw1cNbvnFBt6
	 fWW30oD5bWqayq01A7ZC0ar/hQhMXYLrE13PDxk2eK21wxQ8QYSinHhz2/DSj9AgDYGVh
	 MnB7PwwPqilkVdvZjh1jVIGqRjrlTm1WGaOq1pEngjmz7O5d9u9835Teck26ccOKKrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Dbj6LKj6;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABB606A338
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAABB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Dbj6LKj6
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b6b22be970so509583b3a.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263498; x=1794868298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7X4i7OkHzRC4cMktPkHHhhvRPMlG5nmERGhXlWKYtTA=;
        b=Dbj6LKj66nXJrmxd3d9DTJGd7QKjQ9pGTyRm6MJksUsD31QhI4lLLBmMo2oNonCTU9
         dnUAMWf60icyyN/dFOAE0IGIC6G1qKjhyNAe8rhbgMgGSuNnI5cHtHFvuPEG5AttW/JA
         IDHxoLbciLTyAiBcbK+PHE5eydKvnqsYpGGqU3gm3HrB1+fBrLpvrk5ZjoKJbL3HCJBs
         1LtcF4xxdCjJISt/2COiAnDgXEk0mblQp7eYPpQuS3p9mcB5axzn9/wVaue6AxHr/WTP
         qQXWeo1vbEu7H5v2ygtGltLyvHFgYMBti/64OEZY3kSks0EJ6mA2OnTyyYJ6VrNTPCId
         Up5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263498; x=1794868298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7X4i7OkHzRC4cMktPkHHhhvRPMlG5nmERGhXlWKYtTA=;
        b=XaURmzAUf2XGqcSXabtIZ9La2u0o0MjY7Ajk/5J5a1HWXE7mjYStMrcQWNGIGXl2/h
         pp0vvM/KNTeT6yUueixnPbyq5Djjzi3/n/glRA/qCunlImEasWIoUiwyc8O2JC3ovG29
         Pr8i+eh23iD2lxLSmzOeW5Q8UP//IijQk08ZABiIrK4h10BCxmEHet3zvcQKbTPv1LW+
         8u5mpjyJZQ3t0cxUzb0RXsPpkOn9EmkyPxurQXRup3vRHM13xIvgbbm809FMPrO3Xv/g
         irlguzp/t9lpi1NHW/5Sxzj0B95Qnl7XP0H89DsZvPH/tCbn0dI2qQLNM0lWApYMtZvm
         a/tg==
X-Forwarded-Encrypted: i=1; AL+hErEkInmC8vUseTd99B21bwYyWSh3dYqVcnzX97F/4SPW+d8oBydFAi431+io5g4k7lPE1R8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0XimuQ3dJgEQKtkgcbV0R0gPAGT/+mO71VPuyywdESIAVTJGb
	t3gvvUUAgF4cRUUySg4mPS1/7fkvZEzfZd+UXl3XlHZu3vCfLHmhKw+KQozwP9GC8+U=
X-Gm-Gg: AYBFou116/p1UfnKdt5mKl7hU6xxCL3q2QUuUj+OttYFFJjy0gS7OLcQ/XLxTDu2+pi
	4EptFP+TELHQ8U5Yv852Jvqmcwb8WwvuPHq4QfkmHY9Xz+El13LbQn0V1Cxfd/FZO4p84mxHF1s
	4CD5JXtug+UAmP51fvnLzS1RpXzGoljPHRIZTPYReKdXPGLY4T3jXIhQ6SrRUyHOVNB26kijr74
	qsSSGbxlwwGMVLetFLYb3DglTxIacF0upH95lSVGzt7bTSBgrNNqnz8Rc9xLeV/igfaYLrs7zZE
	WJKrsC6H4mdwS3/xmTGKSpo9qmKJUuzoRwa0e0O2TLdHuSkG8jD6xTsz3djiio1yDAbhHsUUdLu
	VRUQzGyoHXjnr/5YZWZRCneKptsAbLB405ximJdV8qF9MBd5OIVHXKH2kFqn0PAu5H+sDa8FqqZ
	PrJa2oyxDCuckxbNyTfsTvxM0/TKJ9gZnTLcKICuW+yWtNCc2xtWplGvDOT/ZHXtvklwbZE0ey9
	gwqQXDWcQpXzvAOY1Qga80PxMPr7+Z6lS7J2L87l0m56ewiHto3PR5K9L3Rk/7eO1ImsuoWtXql
	Br+7dN7rE/Nxmzjeu98bRks+TJjNPbWqDc+p5T84AEpJe96QO+a4eA==
X-Received: by 2002:a05:6a00:414e:b0:8a0:4032:af85 with SMTP id d2e1a72fcca58-8ba81008565mr1028225b3a.0.1794263498163;
        Mon, 09 Nov 2026 14:31:38 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:37 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 13/23] target/arm/cpu: Don't read Realm registers
Date: Mon,  9 Nov 2026 16:31:00 -0600
Message-ID: <20261109223110.1619504-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The host cannot access registers of a Realm. Instead of showing all
registers as zero in "info registers", display a message about this
restriction.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 71681447b21d..75a482723ae0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -975,6 +975,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     const char *ns_status;
     bool sve;
 
+    if (MACHINE(qdev_get_machine())->cgs) {
+        qemu_fprintf(f, "the CPU registers are confidential to the realm\n");
+        return;
+    }
+
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
     for (i = 0; i < 32; i++) {
         if (i == 31) {
-- 
2.53.0

