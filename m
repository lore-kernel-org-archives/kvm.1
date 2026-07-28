Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA659472F7F
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266799; cv=none; b=Cdfa69OxvDZ+DNlr2Smk9cAK7KL/B5nzFLDj26aGwOL9zHqm9vhf+m/DMgDg9LJfEIERLb5GHw+B+B6suI4Ojsn90C1XuJVt5N90r001YAl+SKep3Vqp+L1Q50asDKMw4yWUj3nnZ44VaIh1wBg4hF7oCA+Ji3PAj9AhDTVa1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266799; c=relaxed/simple;
	bh=Ow3wTv16dxQG97Qs0s08A0M7FwNiE+vb01Y47OvWpr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvvVaLslcM5cV39a9ox3/uBkDtFCEUcubMCHhsphbeppTCDQQTXqQ+i6/0Er3xnv8tBwGHwJxH6LdBSH7hWnkzPyDoNtKgfUDHcFdbRYgVoQJQZi1/GHzlLPRwsFPBKooOzvzStT/PEXaSKdHgJM96gORMl2mZxjZOPBmzyveMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AX47tdB9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AX47tdB9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso190815a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266797; x=1785871597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CTa8ol54WmkLiwpxVbLa9gLi/D951jAni9gUZTC/0Gw=;
        b=AX47tdB93q3xwNlgi5LPMCFEMSsDiOTNsq5JKgov8m12D+MCADWnesd4dkulBaUnBr
         AxXhGbARpPitLrssk4uckTki+btjzC1UCG9QseBMMWEUlQnyKkY3pIsJkZKMtz5I/T9A
         eIkLXGbGzLJ7g4nnDdzPL5pJr0vdnsaq4sUj71EuFQmlxXszbBF9+F3+mblfI+ZUvpv+
         mrVmCsQwdhROSCdDiJaWm9ttVV6YYH6j8xLroSd7UZYu5vFtpthVV/+3HtgZasPuJJcs
         RCozUBo283AMLSmf0QTKYEu/bdFoZUvJMXeqeNCc75jhclx5cMTfeTMghmkQEUWGN4JS
         L4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266797; x=1785871597;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTa8ol54WmkLiwpxVbLa9gLi/D951jAni9gUZTC/0Gw=;
        b=Ajb52vPEnOtnQwXRVPuOPzzqTVaVxa0QChcKYeyPmDTy+rFyBqdxaeIqO8iX2Vt+A/
         tH6EIzkLKhrcDMAUQ33wPVl5FktO7p06hQj9dZkJSZB0y1uNk0zJ/0SDmLROOzf38qId
         LInoYnlEZJ2AuSWwYTLpsp/WXc57bRBbBy4ozFXndcsLLVNW+TTJ+50PNvD01RIQtBnZ
         gWhqw0TVJ1CTJwbVCjzIPInZ0kvsd4DJXN0ga81sVbuNLfNCkOMC1DECjV65lOxRHHmH
         w4qyPsl5A09PyBFztS/EzwpJQzro/At2FJk2DL6Q7+gZhpsMrcU6ALOIT+1bc2f3BSk5
         +n6g==
X-Forwarded-Encrypted: i=1; AHgh+Rq6j7goDtJRrtlkidOh7FFc8RDDyjvpei0NzkF++dz5+4zW/m5GWyTKXzlezuL6eNaPkmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKOKnzkkV4fU3fCJILLCA4NkBojd14naC7wr+1UYDCA+uz0iE
	RHy5dyx/3mrNKjBO+dKZ5hm3rEEk7QiTer6aPCkrROB0tQAgri4D57jq+ie8E+e0yGo=
X-Gm-Gg: AR+sD12xmMsw1RJHBAOgX7W52hm0XPtN7CTwH58Wy8nOfqco9mUN9Q46MTvUeXqQVog
	EGxwiP2M1hVewOR2ynJ6MMHnrmv2OzT3pu9eHqlkDPOvgFLYbthGhv8nAjE9sDF6fBROTFaFZgk
	I4Zpx2wjj09r/9E7GxiCCk0nzfsFJQULupoxAn975ZBMca+Bo14RAlLJEdHH9r9sOZjWejlkPgh
	l7RhHCQWrXyz250z9Aa9Zi1Ifuk5AwyXcQSfrNJ3Ie4tc1QMWIyGKOcQa8tzRWnps+LJaQJo3g8
	PB8hNXhqJ1eHWGAGxVJhVEby0H/wOJ7cV22HjGrFywFlskKgU7T1ngxEzYcq5GiMxMDEg4BRkF1
	He4ZsZAnqPoUB+B+TQPLIqJ10MeNaVTdbejz5lJvpNBmHcR9TDhwYczfRLKru9bNWuaZKj77VO7
	/ZVah8lU4Xd1X+x7t7L+KIW+V81MMZzOXpl8TYnqbb9zfnpySwHWlWfefqzf0hbXBNRiZGHIW7f
	+R/WMs93uUHa+k=
X-Received: by 2002:a17:90b:2d87:b0:38e:5ce1:ae30 with SMTP id 98e67ed59e1d1-38f6a336e0cmr3477306a91.14.1785266797109;
        Tue, 28 Jul 2026 12:26:37 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:36 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 02/24] target/arm/kvm: Return immediately on error in kvm_arch_init()
Date: Tue, 28 Jul 2026 13:26:08 -0600
Message-ID: <20260728192630.240375-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Returning an error to kvm_init() is fatal anyway, no need to continue
the initialization.

Leave the `ret` variable in the function scope because it will be reused
when adding RME support.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d40a6a985914..ed99be7fd80c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -596,7 +596,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret = 0;
+    int ret;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -618,7 +618,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
         error_report("Using more than 256 vcpus requires a host kernel "
                      "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
-        ret = -EINVAL;
+        return -EINVAL;
     }
 
     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
@@ -640,13 +640,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             warn_report("Eager Page Split support not available");
         } else if (!(s->kvm_eager_split_size & sizes)) {
             error_report("Eager Page Split requested chunk size not valid");
-            ret = -EINVAL;
+            return -EINVAL;
         } else {
             ret = kvm_vm_enable_cap(s, KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE, 0,
                                     s->kvm_eager_split_size);
             if (ret < 0) {
                 error_report("Enabling of Eager Page Split failed: %s",
                              strerror(-ret));
+                return ret;
             }
         }
     }
@@ -659,7 +660,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return ret;
+    return 0;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.43.0

