Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B53890F1
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452460; cv=none; b=cVpFzefVT/Hfcsg+Q501KG6AlFo6C+hQRSihb/nlhpJVUJClyIRmEbNy2IypaHjaBov0V/JbZXIM6gC4EfHjnujmNQL6GrE7WA287g4ZDT5B+sTIbCARb+TD1CVtzaw3zjg4p+OxxQVuM9+4ovXcTpxlLabTkDQQn/dvpP/y81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452460; c=relaxed/simple;
	bh=qYO89JPtgxwz3w3Lf500RTRaCVGqiC9XU19Hx897yVc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=swKZBmGtdzN1oW7EVSmfY/n71xNKWWyax2x7cNYCCPzYUzvKj+7NBe7VSz/wO/zSdv6DHCJCRdp8PTjEK89IgG7sY3DbDlDh9yRWs2kMz43R17NADkg1ZzQg8Y6cvTrNL5CofK0zcqIu+n8tMvxI+FS+u28l6Q6bGNAuIeBhPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=pass smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=jx8FM1Y4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="jx8FM1Y4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381b831d535so5252319a91.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1783452459; x=1784057259; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SWOrU0wzWskHBO1d6etEQEOvF1y8msjLLUX5KDQsIxI=;
        b=jx8FM1Y46hL46Y1ePM/1DiaadmtBlsklBOGqHZNODTPDBniwyrTtAIIPiXnDGVCzdt
         fi0VR/vFhT8WCBb6vI95LCDUg4CVqAXX2JnKQpZOjdKRBeCdABHBxXFF8UFgZJ/z8O90
         EsbsOSO6vJHiAAYXqgJoDhS6/vmDOJm4HU2gfi4DpqRb/8L3N4MjUj6OW/U3FFRp4+g0
         5zLNIgqNjJrLI5XUdBlbkxAF3raJdUG/W/jrPSRCTmZYXw0KEzLBg00nMIbreZLbZnpo
         sEbzQqMEQtDX+1jxpKFYWjfAd8Rgiknm89Z5zHGPcJP2vlMCJUrgv45X7yHbKJldZ/FK
         ujPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783452459; x=1784057259;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SWOrU0wzWskHBO1d6etEQEOvF1y8msjLLUX5KDQsIxI=;
        b=C//JZrJ8HetdJeTODlUFTvmFkAV6+ji2vjDN0Xul+SgOcvG/oLMZjzXSuGnFZqi4AG
         DK5/cd3K0spSr3lPbGVKAUvIhrhDLranQ94f0ojn1OaHPM94mBwQ6m55FtRktby6fXN6
         XzVU54esf4iXRPuGRli5Dn88qJw/MWZkvn+19rdOIptLbKZEVl07qYJh9/cVeMEarh2N
         UkZpixFwfLXZ6On9in+WzQrsFUdFfFLQjRXToWF4VfTN/I2tG5WkaLiAjFujijZ1+Lbn
         LSUCawJJyIKIpR47Vguj6MXmiPCPEPCPEhchRm90vZkNZkgJcH33H5TB7GBMCNMZGgX8
         kW4w==
X-Gm-Message-State: AOJu0Yxc3jcgowafObznyAPo/EA6xXhDPA586XaePx9G6rfX3ze62+uO
	1jTVzzI4dVjITLxWQK/bWIjX3bxGuwbUItlNiGm5JLcCaAlL0cXUFzlo6mpYoSS8Mqt8n4tIueh
	5Xl+RVMHNh+Q=
X-Gm-Gg: AfdE7ckLTH+eAMQbQi7R383Ll8YocXwbZ7AiAKesyPOodx1oo+7lcw/CVR4MFKM2tIG
	Vtam18kTlGs2pTq/4ppPHVZNITj3O5e9yxPzI6U7N8AWiElFZPcA4isMI6ONpG4DBKLV3P2Qjk0
	hc4ytfxbnu9dYZvhRhncU9VEcjk31Y7PfB2wxJJfc9BwOzQiv9HnYywmWF7E3anNKon/wWn9+6a
	MMCAAVNFCoyXS/9mgw5VsxqZYXavEhi9rxDh5QRt5dTM3u8o1zq3IgXEQC9GJMt9lgILMvLVEBm
	0H61FnUk6MUShKHsaZZWUW1L4H8Vj3UlW7flPKvDStnO0C+9GWbe0f58IAj6x+L7tSHASPQYKqb
	ixMPpsnfn6w5eUPw5IqGSKDBQ0EnGGE8VWA2kYl2r6F3CiwGX6227xBMw57IkrRFXsfWO12j9TX
	cgdo5lD1OITPWvLVFwfFumEBkHfLc5wmmFRyMPlXDDxlELaoULlROqmh1hnJ6VJPPqGpPDo59lc
	606mjCIdikOHmdD3mkgausKHUvyzkooz3XhcLg/RulhhhTHtoe2yYCnSftl4JmCQYb62s3H3yne
	JNv2qdywEm5YFBal+XDrjzmR9THabUf0lCokvEzS
X-Received: by 2002:a17:90b:2805:b0:387:e0db:3fae with SMTP id 98e67ed59e1d1-387e0db490cmr3464534a91.39.1783452458555;
        Tue, 07 Jul 2026 12:27:38 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2401:4900:62a5:8e1:38ee:5908:64f2:589])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm13243170eec.0.2026.07.07.12.27.36
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:27:38 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: kvm@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Fix heap overflow in SBI PMU event info handler
Date: Wed, 08 Jul 2026 00:57:33 +0530
Message-ID: <178345245327.72065.13249716450708539854@digiscrypt.com>
X-CodeOps-Marker: ee1dda2afc24499fbe0a218e3ded3f59
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

kvm_riscv_vcpu_pmu_event_info() implements the SBI PMU EVENT_GET_INFO
call. It sizes the temporary shared-memory buffer that mirrors the
guest's event-info array with:

	int shmem_size = num_events * sizeof(*einfo);

num_events comes directly from the guest (SBI argument a2) and is only
rejected when it is zero; there is no upper bound. sizeof(*einfo) is 16,
so the multiplication is evaluated as size_t but the result is then
truncated when it is stored into the 32-bit int shmem_size.

A guest can pass, for example, num_events = 0x10000001. The real size is
0x100000010 bytes, but shmem_size truncates to 16. kzalloc() then
allocates room for a single entry while the following loop still runs the
full 64-bit num_events times:

	for (int i = 0; i < num_events; i++) {
		...
		einfo[i].output = (ret > 0) ? 1 : 0;
	}

This is a guest-triggerable heap out-of-bounds read and write that
extends far past the allocation.

Compute the size with size_mul() into a size_t so the value used for the
allocation always matches the loop bound. For an oversized num_events the
multiplication saturates to SIZE_MAX, kzalloc() fails and the call
returns SBI_ERR_FAILURE before the loop runs; well-formed requests behave
exactly as before.

Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index bb46dcbfb2..ff940fa74b 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/kvm_host.h>
 #include <linux/nospec.h>
+#include <linux/overflow.h>
 #include <linux/perf/riscv_pmu.h>
 #include <asm/csr.h>
 #include <asm/kvm_isa.h>
@@ -479,7 +480,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata)
 {
 	struct riscv_pmu_event_info *einfo = NULL;
-	int shmem_size = num_events * sizeof(*einfo);
+	size_t shmem_size = size_mul(num_events, sizeof(*einfo));
 	gpa_t shmem;
 	u32 eidx, etype;
 	u64 econfig;
-- 
2.50.1 (Apple Git-155)
