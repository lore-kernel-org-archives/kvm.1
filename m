Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20B3E3DBD
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630199; cv=none; b=H/zqn3t+Yi4HleaGmYdHBlFaVsE52BEoi/stHcr/ZYIC+jtECfBA0edps0rbdFb68L3VQS4TZP+Ey7DaT8ECNh1I8fFfM/Gll0husaNkpVmjxcQw11z/LSGvNT6tY3tlx5Xw6h9XioPYlTBhXCw0oCu6VJjya6Y0VNSjEKtrPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630199; c=relaxed/simple;
	bh=fUi3B030MRtUu1Tk2SS1jA119Y4OjgAi//oMeDREpo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RpjBV/Jj61mIYo043sE9B2QGMfh4OkZJDqlGQP7vza9luJ21D61QB6gM8WLBnSNsQ1Riig+vQwhEIG+z2Nc4LweMs7vKpzfGJ74dmfiRh7e8D9q2ulayYYMwZa5Qc04ZJdwTI4t/S9xOzO1GXeB3bdpobpDnHVxDjbWyw3r0k+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uP6giWTo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uP6giWTo"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cccfa32670so2169695ad.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630197; x=1784234997; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4BzSn+Kil8qoX+iPCeloFJGpFdDxWSEAoAwG+VxDy/M=;
        b=uP6giWTo1QXpTU/S2AYQN3JgTiJwG8hjm9ckgdKdBMe+sNZZ/iK6bWmHVcA7okleto
         jk53J+9itX/eZwQAT/tlqGwEEML8e+0l6si3efYXELt5iiRbX49hMZl5TKy2kdLW8gaw
         RB7bseewme8GWyQak55y3+Nfw5n0sNzABDbFVQIe4+i4NpoGQOItbr/ziM4nyWrlbDZp
         A/lo0WlEuGuBD8MIkYZ9iN8q/pJnpD0olpvZ+aLk20wlJipB8+r3I6mze1vjfWuaq2dV
         0Q3Hs1LRepzf+VfUcRKWq3e3YgXrg89XhQoNnCcJX/yABNFFUkr7pSgyxJeeR59pNEgW
         3vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630197; x=1784234997;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4BzSn+Kil8qoX+iPCeloFJGpFdDxWSEAoAwG+VxDy/M=;
        b=k2MZM5DKkStXNq0EsyZg8hXbMiXddGZ19FM/0vLOJ30IiXFbJgJGkjiLy+Q7RnkSZO
         Y5Vys8fdOqTBMZ2RhaDciABfLyd1JqqdzQZFadHmzGSG5P812SPoKjGdO9GVYWt3Vrfh
         nxvOrGcUyTHGQYeVedeiu4hs4Fzp9eminW+GUSJHCy7iQ4PwDlBLWZm++z+4dNK9VL/1
         D3hyA2pvXrkfd+A+Kwpm11Et5WfOtW4sLvJxWnv1wN47a+F0sUqtPVp3zqmKeeN15H21
         eYYzjE8gMlIMFwTp+pjRv8smKR/+9oXP4E08Vndz5G3kn0rW3ETma+ftFcgt213wINga
         4xxw==
X-Gm-Message-State: AOJu0Ywmx8tQKQovnbIJxvJ/kmTkfSitFmQpOUP+6kSvZiA//YQa3EVq
	N1hyh4oow6PgD5GAQOuFn3G6eVhpDlvciCtmdgaERwNpa2ttdEAqjLf5vZW0EpaI409pPs7YjHQ
	ak0pDhw==
X-Received: from plnm13.prod.google.com ([2002:a17:902:fdad:b0:2ca:e8ca:4459])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a84:b0:2c7:ebfb:618f
 with SMTP id d9443c01a7336-2ccea3c7bdcmr94503505ad.14.1783630197416; Thu, 09
 Jul 2026 13:49:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:36 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-7-seanjc@google.com>
Subject: [PATCH v4 06/18] KVM: x86: Ensure runtime reads of disabled_quirks
 are resolved once
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Wrap the sole reader of disabled_quirks with READ_ONCE(), and wrap the
post-VM-creation write to disabled_quirks with WRITE_ONCE(), to ensure
checking the status of a quirk doesn't re-read disabled_quirks *if* the
caller needs such a guarantee.  This will allow splitting the "fast" MMU
zap into front and back halves, without potentially skipping the back
half if SLOT_ZAP_ALL were concurrently disabled (which would be "fine" in
the current code base, but far from ideal).

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 arch/x86/kvm/x86.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 226c6cfe8062..8abd733d5173 100644
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
2.55.0.795.g602f6c329a-goog

