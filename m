Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139141;
	b=BJ+Fmn6hx04fAMsE3yant7oHO/D+CaRaWDRDXhq2ZrCI4M2H2p9IXkJFOMtMLI2UYMzb
	 fX2LultviGwsQxbuvKINW3gQ4JuiWV19K/VyA7iPnBRp3QchQDKponKnYkwcTW2Rhpcnz
	 U8JHe3E/Bpz9vwqPtAziE6NiCWSom6rlSVEv7aHjX7YvIpUaar4aSy6lfMUZKnIKm1aT0
	 yddWg0Pill8KLVSoOX1jvSXytpO1W53Kbh/a0Vss5Z7vXfST+DWICvmRqqlw4gVRBIdch
	 qVL/du5HYS8IqfaOaPLN1gs1EWN3RWumJrjftIqYFhq/0XUE0IkQIJv26j0IhRDbRJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=EI446rcjrN0x44kbFFvKS4UWEA1sDeBtgZ/wnLAywEQ=;
	b=4WVDArpyiR1hoQBO5uA1lKAVUJ/wp2/NL579VWg5r3J1SV++u3uavW5PurENyvbkvl5z
	 OJIDdiWmJSqHAPuWWnYZCwoGaHnQW5EDhpPqZ73yr5S+/HKehBYP5cIRmnQmZkuLdr7BN
	 fzV/kznqJ2ex8kBwxnJwCeraXlD/BFlqmNAbrs74yllZejLuXAafEHjpg82WMczAeUyvu
	 xQhWxv0Dod2YwghNQiHCuCUAMXmNZsGVFe5eWmI1x5KzzbOVtlq3D9OwttD7YuGMcbvQT
	 NSargJ0ClD1GVdzJGL8EkQPMrGWqVHaHvmzX3oFwiNIdjeFco4W/dLSUYryg9xLIZTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AW3lw8ir;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2260A263D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98C2260A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AW3lw8ir
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e9821ca96fso3601905ad.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139141; x=1793743941; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EI446rcjrN0x44kbFFvKS4UWEA1sDeBtgZ/wnLAywEQ=;
        b=AW3lw8irvpQz1EVNO8y6ShweTTX/lFmzpHv/V3/DNtPpSDXF5/ewearHPBZhdtaDzh
         6UdXWCH7E0smNjLM3fBbRIHL0MqbvaMpPpX/eHvLBpOqBOrA11yfQUmt8Qq4yej/4ZNL
         Z4mxiuBgHIrf3RI7O6umg/+bXLQ0tO7dU2OtxpjalkMh9hEw07eJivrPhCdXxVAy4yh7
         Kk+lRgXUiaO5O0WpL30UYYgCRges0W52tQBy+BoHyF5mWgx7D9YzlwX0h4o4UP3noawF
         vJEoEiCU2mnP9FSSw9v29mQoowB3MWgR/nrArkJ/ugoNn4QOb0EZUUSYG8BcXIPT8ya1
         T2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139141; x=1793743941;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EI446rcjrN0x44kbFFvKS4UWEA1sDeBtgZ/wnLAywEQ=;
        b=H8limNW0YzuAfKb0U+CTTKyp9jOB4GekAUUXgkLom9jnffUfPlXqSJBGu5RTE/h5gb
         9ANH4SCLro+n5pH2Dfx9EwHsRvoo5fDwhVCURqnwm8h50LY8AleMC+KrjsR2ImWJh/2/
         zB5tKnB6aeau+/yd142QItDCKL/UMZjuyVq+VFrlTBLoM8KU+nByOsh8eFryXfIclnyk
         IieZvWXTRVm5m0GSCgbM6ikE/qAQB0RXBannlNxZiD34d1JZyA2ieklD8Rfx/0dItYdz
         4PEQCw0xmgqG5SbfN9hSKuJ3uKKG6rctjPHl8imgvn+5OTcrQxWacY5jkxxHBIIU6rFf
         YoDA==
X-Forwarded-Encrypted: i=1; AKwUvBz2cUYJuGjCsNbuk79VyjDZgmf6RLo/02Q/nsjv28TAzLkISwqhHLY95n8mR9RTlrSSsXw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8BhnMPqLmwDgdPuXtZg7ObyWZ5Hs3SSbMcnP+qS2E/3f+8ixp
	zT6tAlLjsh3RN/ZtsF6ii8C9ICaOIA0HVsi1u4oBFmvwlyDMSc00z1zmUw/5E5Ckl1nMNiUoZOJ
	/KbWpAw==
X-Received: from plnl5.prod.google.com ([2002:a17:902:fd85:b0:2e8:774e:e582])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54c:b0:2e9:a090:dd80
 with SMTP id d9443c01a7336-2eb0048632bmr5982595ad.22.1793139140855; Tue, 27
 Oct 2026 15:12:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:01 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-9-seanjc@google.com>
Subject: [PATCH v3 08/15] KVM: WARN and reject guest-based uaccess if VM is dying
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

WARN and reject user accesses to guest memory if the associated VM is dying
even if the current address space happens to be the correct address space.
Accessing guest memory after the last reference to the VM has been put may
be "fine" from a safety perspective, but it's still a KVM bug.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f3f59bdf7e18..ba8ea62b7304 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1355,7 +1355,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return !WARN_ON_ONCE(current->mm != kvm->mm);
+	return !WARN_ON_ONCE(current->mm != kvm->mm ||
+			     !refcount_read(&kvm->users_count));
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.307.g5fe7bd680c-goog

