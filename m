Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992B346E40
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780757098; cv=none; b=VfGvQdk6+4NSIzR/Cscz8DW8D2gdM+yBC1xmODIzilqdDuhmrIlQlo2GD5hucQkiIoWStjkNQENDTW5SKXkGD1w5LW7RR4/akzafy2IR3wzGFkvqeSwAEdRtYPgnTWiS/2y7P4D1MYfXxxIW4GGcQe3XILR8VCcZsm5IioHsApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780757098; c=relaxed/simple;
	bh=y+Ou+RW/JftfJo+LY4g2rjPGS8YzJ/MKod2Duququq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Huro0JUsqVDqiPlSyYpeKYW+kmR6JNUc29O2ZjDg1AMz1p/9wZeOML6DQRTdjYjgNdjo7e/dkl/ISEdWd6o9xGUjJ1IHs4n3o9oUB7QSWGZ1zsVMO881vmldzVYyg6Gs2Ip3K+DukqUc/WIqnA8oEWI/BdPnb63aVRDtHlUz9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiBoYWIX; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiBoYWIX"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c85a2ca7bf7so1162798a12.3
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780757097; x=1781361897; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYTa3IP1cU4Gwp1J6lpE/7RLamYxGpI0KGLIZWeGb5M=;
        b=TiBoYWIX7twE56Ap7jBbj/ExTxlemPGs6cr4mpRURsW7xRJKeduuHmWXN3ZxdXYnXC
         SlG49wUB/XsMGJzm03hegjX1UtIn8J9Xqju+Yq4hHY2FUf6STgmu6eZQxY8Yd6ikcSm+
         fDc/tc46NxICqRxMLKZt1sp9b1lp/t8uHgTJJzEzeiOuydKYiAsE92N2yhLrw0DyI/NA
         /03diL+bpOuxiUeDg62NCb9uIOFqMd469PJ3VZsWF4t6FCXoCULXEBdeju69SJVn+RLz
         vm1YXuClERBYO5lEykhrNpmwAwL4gc8kzdjtWz3OFRrVl1GUNU8DRtk9hdKk9uA4mcGU
         zqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780757097; x=1781361897;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYTa3IP1cU4Gwp1J6lpE/7RLamYxGpI0KGLIZWeGb5M=;
        b=nfsGUZMP1gmk77sYAAL5X+cF2RUOGkby8SNvCGVcMIE5k0Sc41GHjxIBLsmFpneUmJ
         A303EGoxLoR9btaRR47aA2sp+SO0BdT/s5WQgW/wOFg4Qg2g+R8rghNh2wGSSpsP24Yg
         8p/ShoCzVu6vFpAHzH7VJM/FQoPTkBOvcLruauiZow/5MVkh+igCeJh4xNnGXlvwKxDO
         O1DRJLCfDCWPs/ue0GUrtjs8n4utGUOpbYWfEm70nXvk+VF7S3sBH0c7ywInMumIonLS
         Tz2IMUJRYKJRwci61TRHlEWvmTy/lLbmbfHXZ5zUsoTNNShUHVp6B4qLKjzqg/nkhuLm
         ah8g==
X-Gm-Message-State: AOJu0YyZJAYBI9g36OO2Zu1fmmQmarPy0e7nf8UQRhvb8YO6QrfP0POa
	E2i38Knz2WBIqnk71FlTWkTsgJbXorWYCcqI5PFdc+WD9P/pUnwzANlh
X-Gm-Gg: Acq92OGNOxyVWY78bjXPNm1M/x1SfAmuO37cQ4CB+A8dVCCgus4TYGA8DuxkwaP/ZnT
	RkwZOczEVmuJ0qjzevO5hvbB9QkWjrXALw+yKwQebayF20HmN9HtWJsxS2mjQcuD5u2gwMk28pF
	ly7+wx4BZ0JOMe4PAZOMwt03uRHm05opJ+7FwT1VWpwjVhOnI28RwHepEgiBocPYrssTvdP/IuL
	+dd/j1DUdWOSo1LYCkV8T6x78JpT9PkWQ+qhymhWPniSKpDCot0hLUW1b52V/LdzadcRh/cZxuZ
	fnbfMQbwJ+yWkaMw+oCuQBqqnzUI+ibvx11lLF/wohhez8/P00InbXwC02vcI73TWjgcM5JCTcq
	8Fz+2n74lZ7DsY5LblebOK1iFdLW9z0yK9okc9dq+QxQlrfHjybgXlspL7welOWycPFYmk2RZO4
	ILJmJCLGyKgjGAtKJ6b2f9P2PoRiDn6s7HCncmHhViU58LxDbuTCWynw==
X-Received: by 2002:a05:6a21:a38b:b0:3b4:68e3:f14f with SMTP id adf61e73a8af0-3b4cccf7fa1mr10545721637.1.1780757096535;
        Sat, 06 Jun 2026 07:44:56 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b2ddbsm10489084a12.24.2026.06.06.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 07:44:55 -0700 (PDT)
Date: Sat, 6 Jun 2026 23:44:52 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: vkuznets@redhat.com, seanjc@google.com, pbonzini@redhat.com,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: kvm@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] KVM: x86: hyper-v: Bound the bank index in
 hv_is_vp_in_sparse_set()
Message-ID: <aiQyZIJtO-2Aj_xN@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hv_is_vp_in_sparse_set() uses valid_bit_nr, i.e. vp_id divided by
HV_VCPUS_PER_SPARSE_BANK, as the test_bit() index into
valid_bank_mask. valid_bank_mask is a single u64 and a sparse vCPU
set holds at most HV_MAX_SPARSE_VCPU_BANKS banks, so valid_bit_nr
must be less than HV_MAX_SPARSE_VCPU_BANKS.

The caller in kvm_hv_send_ipi_to_many() passes kvm_hv_get_vpindex(),
which is below KVM_MAX_VCPUS and therefore always within that bound.
The L2 direct flush branch in kvm_hv_flush_tlb(), however, passes
hv_v->nested.vp_id, copied verbatim from the enlightened VMCS
without any bounds check, so valid_bit_nr can reach
HV_MAX_SPARSE_VCPU_BANKS or more and test_bit() then reads beyond
valid_bank_mask.

Return false before the test_bit() when valid_bit_nr is not below
HV_MAX_SPARSE_VCPU_BANKS, since such a VP cannot be present in the
set.

Cc: stable@vger.kernel.org
Fixes: c58a318f6090 ("KVM: x86: hyper-v: L2 TLB flush")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 arch/x86/kvm/hyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4438ecac9a89..d8782cb7ba02 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1839,6 +1839,10 @@ static bool hv_is_vp_in_sparse_set(u32 vp_id, u64 valid_bank_mask, u64 sparse_ba
 	int valid_bit_nr = vp_id / HV_VCPUS_PER_SPARSE_BANK;
 	unsigned long sbank;
 
+	/* A bank index beyond the mask can't be set, the VP isn't in the set. */
+	if (valid_bit_nr >= HV_MAX_SPARSE_VCPU_BANKS)
+		return false;
+
 	if (!test_bit(valid_bit_nr, (unsigned long *)&valid_bank_mask))
 		return false;
 
-- 
2.43.0

