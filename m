Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8963DA7D9
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464202; cv=none; b=iY9Y3MHCMpxCFrZ2y5AgPGU6tm1GTleMAopXZYWtvA2tr60baBouvnAd/okrniTtyfQRGzUqoGGXSxueCW+vQfaKek6yfe2L4LZTmsNCMb+FL0lHRM1nr/4pNjUPjZgxwdIELbSUH3RCV1omNhIJzM4Wngr15IOe2HboNzMXJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464202; c=relaxed/simple;
	bh=Ow3wTv16dxQG97Qs0s08A0M7FwNiE+vb01Y47OvWpr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxGFixQBTCh80M0y+wYqJFJji9stMCnVExWlWF2gDWdA+prnHiHzMamIWRTzko9BfwhuIDlRtiawgupVl9rEghTxVH5S9Zc9rF5Yj+ucHW2MLcg6FsXjT6Vxr8RNxk2MX5DVxyBNC05SJKEruG7dN4W1XCs3zQcOe8bddB7asrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jCZwt9tK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCZwt9tK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d9db539a54so2021665ad.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464177; x=1789068977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CTa8ol54WmkLiwpxVbLa9gLi/D951jAni9gUZTC/0Gw=;
        b=jCZwt9tKtczMvL7ItmXz8yWvj0iBg0nkltfjT7w/DXJYUn93DLL+2Pyi9ENJu2nL+J
         VsT5GjY+M8A4DGXuGt1CAf/D5MmijlHfbbPYXdAxe5Oy9Ovx9dTG+zYq0n8xlTsd29k6
         Z7fSfCTriuc8+t4tJSviWP03QdVcnCT5fAnKqGl9TfHkHFTVAb15Z+vGWgwjgnUjEo1t
         E+gSWb+dBqkGzdy0F9sk1lnUm28Ljrwb/PS36ue/UThtQOoZaJxLUAiT4AmjrufXHLe8
         lTNrFzkaxOixhvb+uvSh4NYoPXRLXeFRRh/TOOx5Vt2gW5vaGjevMFO7mon3YZJ/tbhN
         s+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464177; x=1789068977;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTa8ol54WmkLiwpxVbLa9gLi/D951jAni9gUZTC/0Gw=;
        b=pfRJ7Wr/sUy4QLKB1WOYVBaeFjJwekU2eMzbLYvXv386v60r6lN90dc2+1fMEylRUI
         9QGYC8NK3h6IhcfNK4y42nmIvB6lIo15p4d0B/R2o7yLdomdAaV5L6Sjq4zPCCXItC90
         vrPALs/Mbm2bGnFve1+1fT0MTbh7t5s5pCv23BfLBXQ8FglRaZtCBcHcUN5UJ+eRUXOj
         hVU8sTke8Slgy6iUlOMdCRaERj5n+O0z3ZlzOoKvSJuSySwlJ01GGUclVeHaxDwSnj9n
         H6pDvLVUH+5VbmSC2ocYo/KOVY8UJ/dcmeg8mTsT1z96ujmmN+VbMnQZBhQVKKK4Gxaf
         dCQg==
X-Forwarded-Encrypted: i=1; AKwUvBzX7TXfrYr9GpHdXmiSvjFtoDGcsTc/0aAJwSvjgzjlVTyC0MoxcwYeJ0e5+CeAeNy37Ug=@vger.kernel.org
X-Gm-Message-State: AFuF++mScOucui8uB4AZnQeBZduiGua0DctRunoakC/pyCQBsSjT3421
	RjFL+iL/dg7Mbi4E+qt4Yqn/UiF2GduEQQW9vu/lrqSxIUWfvpIiB+yBKKIk2SeE64TPOtMomqX
	w7Bn7
X-Gm-Gg: AYBFou0cy7xlNckc4B1LghOOBrSI+AMEdHXyruTn4jyyw8wZOWV+DyCw9C9WrB9J9Ru
	ev53AnXnL+QOEb4ubMjo9lnoqIzqEcQT93+eAcqX9b+U/VpW3KmUl8p7gX2IXd3t0XtMtYFiB8O
	W+mNpPnq1EmtXM6simHnLef+0Lj7Fkh7VfFDRMxDWmOIYgTBp1kM88xaVwAXZ3eciTQFr5Wv/nm
	SFw2AfKSOiYLIv0g3FnmoYK8gLz5Y0HPSNthfNKLKF/9mmWUSKNs2pjdpnGL0NKl2qFgWF7/n3k
	lkDDVZ4t7DI/Haj8bedVafgxsgvkFIL3LORTeLBK6YaXt8gKkoTpg2KIZ+SOanpjFlqI/reCnvd
	cEIBWscTynQqRPjbdfMxSQAcBQ43k7GhI8nvVJZE6pbBeRnh1bX8fe9M5oB4AObvT+Jy93gI4Ab
	yc9mz5CI4DeyGsJYkqj66FQEIM0Mbn7lnDpTwfbSBmHJgSC8g85KSkmY6Evboxy+UVurqi5vVgp
	x/Js7Pf2DOPzYE=
X-Received: by 2002:a17:90b:57cb:b0:398:9be6:f998 with SMTP id 98e67ed59e1d1-39b262e2139mr1100782a91.23.1788464176850;
        Thu, 03 Sep 2026 12:36:16 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:16 -0700 (PDT)
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
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v4 02/24] target/arm/kvm: Return immediately on error in kvm_arch_init()
Date: Thu,  3 Sep 2026 13:35:49 -0600
Message-ID: <20260903193611.1058589-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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

