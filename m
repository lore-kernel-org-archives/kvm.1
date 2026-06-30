Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5AC33A00C
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858378; cv=none; b=PQECb4M3161VPB6fsqHPPcU72xeCMaoO/UHiPqIxGH5sSCWPKC6GCyvI8e8dvlJy0JNI+gd/9M0VCjlp2mTAxz8NYOouLlENSBefuz9xq24Wom84J1tCxENYTRp5w5qUOPx+CvH4NBD70yUKdhYimvJ4bhXIreYTTyzXi9YtFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858378; c=relaxed/simple;
	bh=RwpYBpcGDK0P48KUDsM77pgrtpeX5obZ2rf5Lhy2ofs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DsXwBrG0udwot3TDuZEXq7fNlH1EuNh49WapNt/tEvCAxP4Jbl8ceJUDMAZEFKzyXWIyPagqppPP1G7D9qSy4uXFoFQGbijhIpk0coHOzSy5Huihw6P0L2PNIbc+lwh55duEatrJcLsvreEkQDPaZvBjsBsEfbFiNGvjaoRUtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xmio4t3/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xmio4t3/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c79e5de32cso282345ad.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858375; x=1783463175; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zBuQFsLI7VP5AM9G5y6t2gjs4kfKXwW3Z1IvuFsYReo=;
        b=Xmio4t3/7BX6HgWnTFD16mIYF4wdcKICwVg8nLPdjU0GQJK4fjI9OPUj/iQn7+RYbO
         fTOSjppZVrCfN7tYtIw6CIJntO517ycou++SAAtZZh53sEgy/Apql2nDXQxuiEf3HQ5m
         vrBnKg+O+OP0ILep2x9MvYcuZ/54HcYrl+c8QcflunmcuXmbqLchOGuXhRHAoNwPiHWr
         cKX+RqNJQIJ9J5BxDXTbRU/LeRN4pBytOxJ0yU8zENPr7akX/wjWQaDDBTLwE9Pat27V
         21YC76pS30yzen7YPw+3rC2b3g3h7LzKeJRp2CLDqueTRSJGVDhx4xa2CXgNyGYlh555
         PqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858375; x=1783463175;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zBuQFsLI7VP5AM9G5y6t2gjs4kfKXwW3Z1IvuFsYReo=;
        b=lag2b2bCIFmG0HXxJVq+0Wl/DA/ur4NYG1vPeajN77NrHRlIi+e9aPrLnLGzUlidzM
         NsjGv9GJ17sleDNIL97HHnnAocmwwLCTeePNeu1VvTm4RTQt7qucJnFofGY9FKOZn4U6
         Ts00Xzr/kA1reur6pBQG2SNJnuNKArp1z50oO8tsi7MDIoSRk9a6DKGufayYg4LoGI3T
         agqhaq0+qR+a20hrKQ8Tv2b+aqCHddEFXNJ2uslFbH95IeojUrB3DDPHckcoTl7ferKs
         EED2emj6DSGOfvDcFpjVrLwUU/ooCnxfXlWXlDqvuURoIDJc2HW+WI2o47ho44hcpiYy
         4CAQ==
X-Gm-Message-State: AOJu0Yy30MX/N+5RHbUMoJYyrIjb4HcYN/GB3/zDOhLO1pv7ZfU7Q4Kp
	U1BoKUNUm5nUiTkw/PzxKvEZ04Tt+WnUQ7kiFyVxuOie5JJFeVH3H1Hy9JSvOsHgfLGhMna02Ik
	LeG2ZKA==
X-Received: from pgg2.prod.google.com ([2002:a05:6a02:4d82:b0:c9a:37aa:b17d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:493:b0:3bf:a11c:176e
 with SMTP id adf61e73a8af0-3bfc53362c7mr4743781637.57.1782858375420; Tue, 30
 Jun 2026 15:26:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:26:01 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-7-seanjc@google.com>
Subject: [PATCH v3 06/12] KVM: x86: Ensure runtime reads of disabled_quirks
 are resolved once
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Wrap the sole reader of disabled_quirks with READ_ONCE(), and wrap the
post-VM-creation write to disabled_quirks with WRITE_ONCE(), to ensure
checking the status of a quirk doesn't re-read disabled_quirks *if* the
caller needs such a guarantee.  This will allow splitting the "fast" MMU
zap into front and back halves, without potentially skipping the back
half if SLOT_ZAP_ALL were concurrently disabled (which would be "fine" in
the current code base, but far from ideal).

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 arch/x86/kvm/x86.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 74f1d7169218..bc0c3163f4a3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3940,7 +3940,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		fallthrough;
 	case KVM_CAP_DISABLE_QUIRKS:
 		mutex_lock(&kvm->lock);
-		kvm->arch.disabled_quirks |= cap->args[0] & kvm_caps.supported_quirks;
+		WRITE_ONCE(kvm->arch.disabled_quirks,
+			   kvm->arch.disabled_quirks | (cap->args[0] & kvm_caps.supported_quirks));
 		mutex_unlock(&kvm->lock);
 		r = 0;
 		break;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 8ece468087a8..75f13d88db58 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -304,7 +304,7 @@ static inline bool vcpu_match_mmio_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
 
 static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
 {
-	return !(kvm->arch.disabled_quirks & quirk);
+	return !(READ_ONCE(kvm->arch.disabled_quirks) & quirk);
 }
 
 static __always_inline void kvm_request_l1tf_flush_l1d(void)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

