Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37D2D322F
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185874; cv=none; b=baBO/s4NzsIJZurRuYCuhNuzqaBVUp0Gte+JiFcSMjXCWNOyK2pet+DwhulVge6fJvljRA7aplJIJf0Lxz3/TnnUJy31B59PwnnmiqU2f+zltfBN4wmkRaNucPDjOplBQ092PXlilX0h+GC04pcOpcgseXO4YfM/vLhHr7pPcEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185874; c=relaxed/simple;
	bh=fgIT6NXFX75i4wBbICjNJooj+ikk7ad/9/UQl0shUXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mePzCPFxZwyOs4cu5vsv5ZFAsn1MpBRIb0RH/N/zR9mNBHXdhpJ8D4z2I/qU+FRRquKoH40Vu0JljVHHjEDaI9/LWJTA1Poh0CXVYF6nVmAmj5w/lBRB1uHiJ+uNjQAGMVhpLtCY7M73Xp5j0NByGaRI4bbatwtzs2+MmE3uuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k82NVE3K; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k82NVE3K"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12a74039dc6so1328543c88.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 20:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775185872; x=1775790672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=126xskp8qqls/apbRtHP6pYF24zxyLnHKVBvZLaDTas=;
        b=k82NVE3KfoqNtF83IrkAqVcp9v3j+wkus6DBJNs0y4lXsmVXZkGVQF2RgGNSUT+Puv
         LrT+JP8rqFq+AjDVh+24L2lHrbg4gdA0wP67LbB5uvruyx7FAjoMeFkVLc4Co9Dc00Ia
         /v+p9YbUeyr5+hVUJZ9K+MeiOGNPjMcAKm4+2uYB+fJ3qYQAyHaqj2aEG7NBq5wKiIpm
         Xi/chhVu5+5lIkkc47GkvuIFDZmY6wYlbNDcpie75kuLePMDFJorL+4OrZkSdoinG+6w
         1X7lH5NEfLShHE6uZjnzPltlMAF3a2FDUNMxLN/szL8QFQu46Zqfa6VrkeWm24o8K71+
         CwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775185872; x=1775790672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=126xskp8qqls/apbRtHP6pYF24zxyLnHKVBvZLaDTas=;
        b=NzvwifhxPZQmALq5X1t5ZR+jhvRAy4gW8fqMMlmN3KZE+1TP3PVIvo4tdOUan8wxnO
         tz/v7ykPd1s61ORZ0/DkO7SmRI3EvhIPLo18tGNZTpDFciOAWpPf640EDDsLpqTSRZaR
         DbHhZbzZdWZW67njyI1MPNQbqXhEBxwiuV4Wsfe72WgjVpHd2RPnMaQQO3Rxapu7V32y
         IG19I8Zdoxx9JIOfc4gUp8nR1ew84E8U7b/GyWtH2BRIfF6zoagXmOOuBSfuJOGrm3NW
         uOKx9zuWCl9sWSD863tzrtHqtgFpnQy3+iKY8q7WjQkE77fkPfUOklCG2xzoMjIeK5Yd
         oUGA==
X-Gm-Message-State: AOJu0YwIS2H+ZVdvYfLbswh7xWvqP1Wbml4vUJDRzLpymRmUb3ACF/ya
	7OJsHUfK9jCHV+4vyb3exW8H2ePvEE2+Gw9VRh55VoWmZEEe9Bm5ZGGBuBc+muqtasj3mG0X
X-Gm-Gg: ATEYQzzTjK7Hz4aP26UscjdkOSufyp4eVQ6O/+U6P7SAozTflEjlx3cviThDOEntEzy
	L5bCpfej7k55sOfcDXqvIkw6p25p+d3H192VAiKebJz01DY40DH+ZTqQL4M+v2SVcDble0s2fpR
	g7nqqev0NfA9A4+Lc4e65Qw21EbSU9dMi3eo1LrkmgRpLOcL+dRrK9E8s5BYenHqa1b/w1CNsSY
	k6hLrPsi1SQNBUf/5iIf8a+HMjLrYkQEtHSzb6zCR+SlSm28lMSTMyXbXwb9Mku8qfOGx/of6Yh
	eOGhX7LTbaQfzjH/w8hGeulpR9NpI7+7fdMDfTpLqFim9Mjr9f5ZDTP7XU0eEwqBh6HGRAhRoPL
	YOrLeXZ+uzNYqyBrRI8WKHUu4leUYlqiOiXahnkQIVLc3H/Bry/uEAtvAbsfQ+wknp7yZVm3RgF
	h+mNg9+l8Jv+M9vpkp/gREd2F879ye7Pm+1NNiLluwNw==
X-Received: by 2002:a05:7022:6b8a:b0:129:fe5:117e with SMTP id a92af1059eb24-12bfb75ea8dmr696019c88.26.1775185871997;
        Thu, 02 Apr 2026 20:11:11 -0700 (PDT)
Received: from gmail.com ([20.168.117.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm4180153eec.0.2026.04.02.20.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:11:11 -0700 (PDT)
From: Ethan Yang <ethan.yang.kernel@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	x86@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	glider@google.com
Subject: [PATCH] KVM: x86: Don't leave APF half-enabled on bad APF data GPA
Date: Fri,  3 Apr 2026 03:11:11 +0000
Message-ID: <20260403031111.3171-1-ethan.yang.kernel@gmail.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <6877331d.a00a0220.3af5df.000c.GAE@google.com>
References: <6877331d.a00a0220.3af5df.000c.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_pv_enable_async_pf() updates vcpu->arch.apf.msr_en_val before
initializing the APF data gfn_to_hva cache. If userspace provides an
invalid GPA, kvm_gfn_to_hva_cache_init() fails, but msr_en_val stays
enabled and leaves APF state half-initialized.

Later APF paths can then try to use the empty cache and trigger
WARN_ON() in kvm_read_guest_offset_cached().

Determine the new APF enabled state from the incoming MSR value, do cache
initialization first on the enable path, and commit msr_en_val only after
successful initialization. Keep the disable path behavior unchanged.

Reported-by: syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc0e18379a290e5edfe4
Link: https://lore.kernel.org/r/aHfD3MczrDpzDX9O@google.com
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ethan Yang <ethan.yang.kernel@gmail.com>
---
 arch/x86/kvm/x86.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd1c4a36b59..c355bbd36c3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1041,11 +1041,15 @@ bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_require_dr);
 
-static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+static bool kvm_pv_async_pf_enabled_data(u64 data)
 {
 	u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
+	return (data & mask) == mask;
+}
 
-	return (vcpu->arch.apf.msr_en_val & mask) == mask;
+static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+{
+	return kvm_pv_async_pf_enabled_data(vcpu->arch.apf.msr_en_val);
 }
 
 static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
@@ -3645,17 +3649,20 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 	if (!lapic_in_kernel(vcpu))
 		return data ? 1 : 0;
 
+	bool new_enabled = kvm_pv_async_pf_enabled_data(data);
+
+	if (new_enabled &&
+		kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
+			sizeof(u64)))
+		return 1;
 	vcpu->arch.apf.msr_en_val = data;
 
-	if (!kvm_pv_async_pf_enabled(vcpu)) {
+	if (!new_enabled) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
 		return 0;
 	}
 
-	if (kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
-					sizeof(u64)))
-		return 1;
 
 	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
 	vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
-- 
2.47.3

