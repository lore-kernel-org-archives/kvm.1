Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C7524AE8
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789883; cv=none; b=kfoMwUWUmrJhFwEhsfP3qr3bjaVYKHgnQaFGVHjSIVhiCe9WMYpmzUd7zO6YUay5Mkya7mtWBLj1WGbU6cq2lNno4mkvXOz6II4oMqMDQKOe5wKX60Hfhjf3AIcdGkzsK80djsCCZA7oY5c6puklQsCOf/MabOVcuW2NXKzWIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789883; c=relaxed/simple;
	bh=3UL/O7JJtcbVlG+Lw38GP1NlGChJ2E5u5BgNXEqqqME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=npDtXLVWyCsD69Qp4qLiOF6HGJsaa3BzwijezufvjvzCyTvawYmFUooWBpVwSzF+oVYFIj+q0iPwh0UVDFnO3AXPbTWtCiVJmPZxP2QO5yGclPri4J4ubJkJiK7ORSDJ4WctTw8MX3wiGaegDla4ZxgT8OHwUFbmuuokj/p7yLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hqcrkKb2; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqcrkKb2"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e2f2bd5256so2507075ad.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789881; x=1791394681; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8uTYOk/MhFfjsdPif1vpatkjMmwikL+0Ht9vhlLQI1E=;
        b=hqcrkKb2GWl3iq/daL7JOrlD4PQyWybyJdNrq62a6F7gcAAKmYDFO3LCVsvXhe+aOy
         i1kr8GJcaah/pb7qGIbxjoFYu4Fnaegv8Vz3e86HFybvCG45A0g9HUh4SG9UYeBqUx1S
         C7qgdQeuwghI5NQjRZuSs15N8SvC+aS63zWagfu/jYUR73KogIQhaVphXawxeTyDVH1w
         epPOfKgOPZpb6Dr20eg9bCTuFv6e04Iefzx21vsZsh+I/v6uUqslzLcIQL0XZVIamDf3
         1j7149bHGrpYT2m7ojLGvQ8yVLfi1QQ/A3r5JZXMaiZPwCND9t0nDWs6DdnxEWeI1Dib
         zrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789881; x=1791394681;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8uTYOk/MhFfjsdPif1vpatkjMmwikL+0Ht9vhlLQI1E=;
        b=RHcz/62XPZHNJvZAGnJZnKkE9V6b+pmQOIBkZEhRpJZl3XmnOsSdS8Y2JNW/V3pEqn
         mvQk6EhpdpR3/wL/oP9PQzJlWRkwf5Kp9AOD+bCcB+zGzEC5cI4Br8wgqcTqA8/oHMal
         takaFTluuacStz6YLWgXvNRo7lff8kjm28Y8T3viHvp3nDyUsMtYvYMUJOnX9tzxUk3N
         4CrRE3Cl3O7V+DXluSSXO1qhA4jy2iFoV4r7gybQobb919FAYhMaf9aGDVa7LqOzAe/t
         mYBZrG0uMrlE4/5QELT510siYq+sr+wHqvOZNhHK5uM5XC6Z3iCnyEeyrU0Wu7Nr4yOj
         fKoA==
X-Gm-Message-State: AFq9FYLtq3r7HyhB+r8rq8KAx12D/5VrCtq8Gx8aanRi0oWmCdSi37WK
	t4i0bDvZR3ukYm1tApN1y9vYFuvwzRlwd0fdSJPCSMX3qjy/g4Pg6ezGzv3QIPY2OTA7pre4aYy
	OJnSZcg==
X-Received: from plao21.prod.google.com ([2002:a17:903:3015:b0:2dd:a96a:60ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f712:b0:2df:a392:276e
 with SMTP id d9443c01a7336-2e2e4a016cbmr19316765ad.49.1790789881110; Wed, 30
 Sep 2026 10:38:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:32 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-19-seanjc@google.com>
Subject: [PATCH v3 18/21] KVM: selftests: Test non-zero TSC offset on SVM in
 nested TSC scaling test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Set L2's TSC offset for SVM as well as VMX in the nested TSC scaling test.
Odds are good skipping SVM was pure oversight.

Fixes: e6bcdd212238 ("KVM: selftests: Extend vmx_nested_tsc_scaling_test to cover SVM")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index 4cacd87f129b..571fc214c925 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -75,6 +75,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 	guest_check_tsc_freq(UCHECK_L1);
 
 	generic_svm_setup(svm, l2_guest_code);
+	svm->vmcb->control.tsc_offset = TSC_OFFSET_L2;
 
 	/* enable TSC scaling for L2 */
 	wrmsr(MSR_AMD64_TSC_RATIO, l2_multiplier);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

