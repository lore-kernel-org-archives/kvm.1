Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C233DA7C0
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744559; cv=none; b=f/eMkrC4UIfQa4/E3lPTrifUI52xEmPp7+b4YBJQWuzhk8W6kIvhE0FfuAMJhQaqffHSsmmRFPsdSRN0SaYclIvhJfFz0a4GDShIK6cVm9uGDp8IRzLJHfCJwYmfWXgE+WbYU3mjjznjLCSLjYVHLIGNG/X6Kq5V0kCNGzTE260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744559; c=relaxed/simple;
	bh=Nv0LZ8ENNMjKtXEw/sa3+pR/wKA4qhD15enU3i1bbwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POhR5Uxt7X/bwsjdSbB7w9IS6/ytNsTO3PFQKFcyMyOVnkvLudR1flM347ATTV57xykj84Pxnmbg1RxCz0/cn5d0XW2tTdGti5rgPh36Alm5sPGkM5PosB8WuG4aqjyiBlg5uvD5m2VGqPzd7e49dfEJX9iqGkUQ210rmgnePEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=NXMF5gjb; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="NXMF5gjb"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so1057200a91.3
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1775744557; x=1776349357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKq0BhPwqLsy8JSNCzPJOdtUcEVYRgcelll+xkoETzs=;
        b=NXMF5gjbotf2O1t/5At4nL6pBYOyXebDPiieVBy/xc7pfIbQMrM4IPa7QH+TbXnKhm
         Xm9aPkYhJUnelizVgf2FfJKpQWLhXWAWkqNiBc3ZmeTjscO4YdUKK6SnwLMQ2CbN+DaE
         qvX6D32Kp81ol82ZzXTqs6hL/Vo/phFHFF/vEoe+MPTbqNN7LePOKntxX1Zb0UbefN9Y
         eW+ZtC0M+2LW/XppUL3H0m9jIWVIOG6OBb7/Nk+i9uoQawmPiIfX5f4PDRHHI5g/HZww
         6qPlS4vJpFf8MYk+I+whIvBUs+UCLTxPsDniFu27TSwSQCgm8aUfQ9KUIAm+xwUSoDcb
         fu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775744557; x=1776349357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uKq0BhPwqLsy8JSNCzPJOdtUcEVYRgcelll+xkoETzs=;
        b=m6Rqyggu2KRyZVQV5hP8dnZA79PyHmd6s9q9OA5OnIfab49MJdygP23q3NsO6QYM3S
         hcTZ3mi/oQ6d6dxIPmdWHkMDwqRSoFYlS2FPSi4dSXROP2QfeHSOpP4DAmiBxXia+2Tt
         zlDQ5UHNVwBTczdKpQBk0i+byBGynofzn5L3R2glao7vVWaN8UEBivkO/kY79WQgb9LQ
         8x5ZIIanQCIfnn2sB4Mr02Gw7rRLIqgxOs9+uxhp7QCAkyg0d7dTd4k4zOKMdUOPS3gH
         v/V0M7/u4iTCqbwpeEQSQ0a3k05/5z9zc2xQQ8DBuF2CYG2x2XExPLgvgxuWW+SzM2ld
         wlXA==
X-Forwarded-Encrypted: i=1; AJvYcCXRcX9wrq2Fkeh1wqHnufOwT9I+olR5ITJ8Jnpw5cffJpcMsuVcxf+k1NYD4kt44ku4Ruo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxldpQKqYQdDkpgLGvNvnIPN/TNwVyhsajKGSCPpnV/0S1/q6
	BoFx+YrVbTaaAWO65edm/kSv5o51zMxGvdezb8078TBzmBfkCmKz1kY8DtSvHtRSYae7QhPLymP
	FHvqVSVmwCC7PnI3Sx5gq6GbZnrFAx3LeYn/HkQhjGxeCYno=
X-Gm-Gg: AeBDievUXXNuKQ/iezLST9dTT7SOLTfxtY0RUCSjlaz/UjnNoz7qHtXeRPVki1KMKIt
	Vm8Fg5FDcg3sHGtlOXa1UzhUjdIHpYATytABz6ala7wWPr2fzxEZ5MfxBE1Eu+NoOwTuh0PnExX
	DngMThB6QddH3x9flT42mrC/eVkoD3+rHuYZjdjvEQ72B6Tjj4vTnijlNs3Le/JklRW0Oo6gdCm
	bvNO7EhIYkmVPmHuT+K3LIEbGXbBrGkPqaPkmHE9balb//UiizXzGtfKIuDt5DZGJLp2I0v5eO4
	XjLV/lBEOR0zrhBUJo1m376LWSTjFdtPMAGr/otWpXjTKHdH4UGxx294wnrpVPT8vzDD7jBgaK7
	md1cinm0wOgHQduLMal3elVXorcEw8Z26dFpn8Z5x/L/3dNIpUTkPI1KKhau1XfMFrjnY97vSoK
	h71TCinNszQo+z104C4A==
X-Received: by 2002:a17:90b:2f8f:b0:359:fd9a:c513 with SMTP id 98e67ed59e1d1-35e359a62c0mr3492121a91.24.1775744556676;
        Thu, 09 Apr 2026 07:22:36 -0700 (PDT)
Received: from DESKTOP-AMNC9SI.localdomain ([2407:cdc0:d00b::4])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-35e34ff0c58sm3662676a91.10.2026.04.09.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 07:22:36 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: seanjc@google.com
Cc: igor@gooddata.com,
	jan.cipa@gooddata.com,
	jaroslav.pulchart@gooddata.com,
	kvm@vger.kernel.org,
	lei.chen@smartx.com,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com
Subject: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
Date: Thu,  9 Apr 2026 22:22:26 +0800
Message-ID: <20260409142226.2581-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <adVGrJaRlRooO4su@google.com>
References: <adVGrJaRlRooO4su@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.

As a result, kvm_arch_vcpu_load() can queue global clock update requests
every time a vCPU is scheduled when the master clock is disabled or when
the vCPU is loaded for the first time.

Restore the throttling with a per-VM ratelimit state and gate
KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
scheduling does not generate a steady stream of redundant clock update
requests.

Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
Signed-off-by: Lei Chen <lei.chen@smartx.com>
Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
---
CHANGELOG:
v2:
- remove comment of kvmclock_update_rs
- make sure kvm_arch_vcpu_load make KVM_REQ_CLOCK_UPDATE for this vcpu
- add RATELIMIT_MSG_ON_RELEASE to kvmclock_update_rs

v1:
- initial version(https://lore.kernel.org/all/20260407070046.2336-1-lei.chen@smartx.com/)
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5a3bfa293e8b..5e750c49d21e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1453,6 +1453,7 @@ struct kvm_arch {
 	bool use_master_clock;
 	u64 master_kernel_ns;
 	u64 master_cycle_now;
+	struct ratelimit_state kvmclock_update_rs;
 
 #ifdef CONFIG_KVM_HYPERV
 	struct kvm_hv hyperv;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 63afdb6bb078..a534e8391611 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5210,8 +5210,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		 * On a host with synchronized TSC, there is no need to update
 		 * kvmclock on vcpu->cpu migration
 		 */
-		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1)
-			kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
+		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1) {
+			if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
+				kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
+			else
+				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+		}
+
 		if (vcpu->cpu != cpu)
 			kvm_make_request(KVM_REQ_MIGRATE_TIMER, vcpu);
 		vcpu->cpu = cpu;
@@ -13189,6 +13194,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	raw_spin_lock_init(&kvm->arch.tsc_write_lock);
 	mutex_init(&kvm->arch.apic_map_lock);
 	seqcount_raw_spinlock_init(&kvm->arch.pvclock_sc, &kvm->arch.tsc_write_lock);
+	ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
+	ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_RELEASE);
 	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-- 
2.51.0

