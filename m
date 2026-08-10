Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC03B7B71
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402524; cv=none; b=IZH3/FpKfZRXtCg5rbM+WGzjkBnLgUVgzQDgHiyDL8s93If8MKicLvTTAdTYTNgnshbcKm1UkyP/ETP+xqigXUP73KnxqWKX0MAKEK1m+VRf6TO4typH8mUdSMcgxBscM0GEP/0/NZn19YK0P0TseY1hvwLOQKPS7smpmovNu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402524; c=relaxed/simple;
	bh=a4k1aVZHVVzjhch66sZIH3Bx+qyvEkl4jDBTXagNTDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cKf2wogZ0Ti+yctaUg/jlU3Vm0o+bN0e16yV4uHLM9UIGPdRa3UwNIgNsMGVyCs8IBOM3uQjq1HzVjuEVclNKDq4zoRxbvEf9mqsfZ8K1eY7kAfwDelKucVL/EjI6QUt2ww+HUkOOc8sNw6RYzQLmJwYrUVnvvd/MXctE6TMt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czUvW8OY; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czUvW8OY"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso448036b3a.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402518; x=1787007318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0X71CL0KX6+LAhAdItGgBlh9OhvJ66AL4rVV3P4B+SE=;
        b=czUvW8OYmBgsRgor4129IlqZxrKrmQ+fiMI2DGtPVkF4twkgQ3yyps8x1JoV0Rx10N
         BkhGWo1zLCTBJfUZkgzq6C0Ubdyaez5q9zlv3Zy/J8oCuHHoj2Sz094lrdy2oDJKD/dq
         /EgOK4UZ+SRchWHIcGMA+YYpxICFGLBfZb3PrasETWQskSVT8/yqp3BGEw/5Zh8eKZ+Y
         p+Xupz/vjernQBONvka4svhV+zT2IUTZYB5xrHomSVNNJEDNBQaamjF/7r3GBZYDp0Ko
         CTj4bBj+/alChc9v9GHRyQ7YS58xipsxny09C/kycWGt/WaYLaQzZ4oXn2I7UnUk5372
         Bbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402518; x=1787007318;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0X71CL0KX6+LAhAdItGgBlh9OhvJ66AL4rVV3P4B+SE=;
        b=pjC9cGJ+IWZmsdJglmYBj01jOL1zPbf/sQ59UeuFO5z3fmwRyPmjJMHKUwzQpiSvTD
         9+rGkx9V07X0vncWogz48wnNJ6zvM5FqoynFaiB2YHXrPRlyqMk7YA7pAQFbUXNu3I+7
         boNvcFMiraLCoflQAmXVqwVr/8/RDmixGH3UOdrpgtvVa2gKEERxsa96y141Xyga4fgD
         f8V9Ky+UvF62UOJ/C+Y8qCfnh3Cl84d6V+GehZ205BlZ+luZHpvcbX/MlUF+dTtaQKJR
         uzkF6DNoPHT3dp1C2z9chOw26HMPXg+75/jGHBvLsYxp7PF0CwHMvrRVNFQjpX9r24V6
         T6/w==
X-Gm-Message-State: AOJu0YxWgD3BNXEnoDN/fbghofiejbVwdhZJ1OmQup1EEpPAKhPpwf9G
	tAYeFBOTEr51YJ9kTBVcMfv/BXLQXhTOK3HlIu2358WXYlcF016CbZ/eLwKPnqYNAXSy0FSpJzp
	guE9YgA==
X-Received: from pgo11.prod.google.com ([2002:a63:e4b:0:b0:c9a:8872:2a15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9293:b0:842:446a:4cb5
 with SMTP id d2e1a72fcca58-84fa14bb837mr2038335b3a.0.1786402517678; Mon, 10
 Aug 2026 15:55:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:50 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-13-seanjc@google.com>
Subject: [PATCH v9 12/21] KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

Now that get_kvmclock() correctly handles TSC scaling and captures both
wallclock and kvmclock from the same TSC reading,
kvm_get_wall_clock_epoch() can simply call it instead of duplicating
the pvclock computation.

This eliminates the last instance of the "definition C" kvmclock
calculation =E2=80=94 as described in commit 633d7652f80f ("KVM: x86/xen: D=
o not
corrupt KVM clock in kvm_xen_shared_info_init()") =E2=80=94 which computed
nanoseconds directly from the host TSC without accounting for guest TSC
scaling.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 59 +++++++---------------------------------------
 1 file changed, 9 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 61c65241554d..50e92090ba65 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1939,63 +1939,22 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
  * wallclock and kvmclock times, and subtracting one from the other.
  *
  * Fall back to using their values at slightly different moments by
- * calling ktime_get_real_ns() and get_kvmclock_ns() separately.
+ * calling ktime_get_real_ns() and get_kvmclock() separately.
  */
 uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
 {
-#ifdef CONFIG_X86_64
-	struct pvclock_vcpu_time_info hv_clock;
-	struct kvm_arch *ka =3D &kvm->arch;
-	unsigned long seq, local_tsc_khz;
-	struct timespec64 ts;
-	uint64_t host_tsc;
+	struct kvm_clock_data data;
=20
-	do {
-		seq =3D read_seqcount_begin(&ka->pvclock_sc);
-
-		local_tsc_khz =3D 0;
-		if (!ka->use_master_clock)
-			break;
-
-		/*
-		 * The TSC read and the call to get_cpu_tsc_khz() must happen
-		 * on the same CPU.
-		 */
-		get_cpu();
-
-		local_tsc_khz =3D get_cpu_tsc_khz();
-
-		if (local_tsc_khz &&
-		    !kvm_get_walltime_and_clockread(&ts, &host_tsc))
-			local_tsc_khz =3D 0; /* Fall back to old method */
-
-		put_cpu();
-
-		/*
-		 * These values must be snapshotted within the seqcount loop.
-		 * After that, it's just mathematics which can happen on any
-		 * CPU at any time.
-		 */
-		hv_clock.tsc_timestamp =3D ka->master_cycle_now;
-		hv_clock.system_time =3D ka->master_kernel_ns + ka->kvmclock_offset;
-
-	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
+	get_kvmclock(kvm, &data);
=20
 	/*
-	 * If the conditions were right, and obtaining the wallclock+TSC was
-	 * successful, calculate the KVM clock at the corresponding time and
-	 * subtract one from the other to get the guest's epoch in nanoseconds
-	 * since 1970-01-01.
+	 * If get_kvmclock() captured both wallclock and kvmclock from the
+	 * same TSC reading, use them for a precise epoch calculation.
 	 */
-	if (local_tsc_khz) {
-		kvm_get_time_scale(NSEC_PER_SEC, local_tsc_khz * NSEC_PER_USEC,
-				   &hv_clock.tsc_shift,
-				   &hv_clock.tsc_to_system_mul);
-		return ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec -
-			__pvclock_read_cycles(&hv_clock, host_tsc);
-	}
-#endif
-	return ktime_get_real_ns() - get_kvmclock_ns(kvm);
+	if (data.flags & KVM_CLOCK_REALTIME)
+		return data.realtime - data.clock;
+
+	return ktime_get_real_ns() - data.clock;
 }
=20
 /*
--=20
2.55.0.679.g6767b8d81c-goog

