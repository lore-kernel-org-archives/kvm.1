Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3745A282
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886781; cv=none; b=Z3UIEIZHE+GDbetd4KW4KNHgmEGns9DKzo07LKXOi74F/aoHp4g5NgeFF9xbRubn+ZuA6qTTqFd2YMmEtYmg/r2f+vsfzhKXYkvSRFw0r7r1+JZvlEMKGGYteWAJJEsrAZqzsh316qH7HKbLDe8cvyJU7JPYJLsZTeYng48RrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886781; c=relaxed/simple;
	bh=ofnWi+mEcP4gnrXw/JHS+6wXyfOySBt8ocjZq/4zwWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cqjd/5eyU160ItFCwwy9fxZ9UTQJFyxZnvFbPaHnO18TTTIijTGzw7zN4epQnLp4nUKaY2P0qf7A6V8GQQLad52zBX+FpZaVB4j0ZaCB7iwXEZoxUnn4s3h/9HBp6TT8KtyluRx2nVAc7izbGFK1wgOIpRXNnBwmDkXCsmsTVkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MemqMn3x; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MemqMn3x"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8487eb67173so539697b3a.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886779; x=1786491579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WDzgu7ECyJ+WaNeJVkzUTS71kB1wuAWfhroN+BlFLXI=;
        b=MemqMn3xPCyNreAbomYY4xNWkz8a8b5TNeQ+rRC0Pq+v3iIb/w2Rc0fT/Pkoz1iCYc
         s7nUThFK+xThxPg+ncNKJ2ejPfSG+JWT5I+hu9/GQ/2Mwl4yuIiXOuNi6Ro8k1gCJKXC
         DudXqWILSc9eYatZTdbD6jRhZBsLKCuoNKtEW5RHME1hGLHk4r8sd/j2tCFuUJ32FsDb
         oxK0jBkX+beXIJgtCmg0bIZTZlmP3O6D2NHLGPv/CGDuEzFIfgEAAEdgPJL47K6J4ciI
         vbWQc+JKXaLwWOGn/7cILQUVrB3eYdzRLW+Hg25taFecZEs51SX+U/nvk3mhmyX4XnEk
         18ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886779; x=1786491579;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDzgu7ECyJ+WaNeJVkzUTS71kB1wuAWfhroN+BlFLXI=;
        b=CGWTsvcgMGFZv+7j3tHItK2U6D2fRLpBBs3fw8m04y6OPocsby2puZ9p5kQrF9/nYj
         jmXmCcbGm+r+P2WrdamEbU2fRoLTHzc6m7/NVDrd3EBJDACAIHq6JzWkoFzVm/VcITSn
         KtbQ9/xcL6pjDWglKKYvLYilFRRg6pdU2E6o1QDGQ5lE7ecxQFuySZW0MeiN22EmWknM
         S2TFYJh2B+C3UQdw6LqRViyFy7es3SrfvRkTvDE2oKDxCXgtqp6HAZklh21j8aybe/uo
         FMrxuFz1oUi6pX7oLKpq2eOOuxsFF0DI+GMO9rapJOTzDskgWSb6I5Ld8r8Kq7+BtLpR
         Dicw==
X-Gm-Message-State: AOJu0Yy1vFc9CO7bl150ZpWEYCeX+lB0OoNnOekMx/1yNrhTIRP+bmzZ
	HrxuUZpPGFKZCWlQXQFAAtHMkUQThIuv4HumJK0huIEQhv0vSjw8mgu8TyJHVCFbwo/Dxe/tDTB
	/PUQZow==
X-Received: from pgla35.prod.google.com ([2002:a63:b63:0:b0:c96:da8a:c09c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3026:b0:847:9ce5:d293
 with SMTP id d2e1a72fcca58-84f2e03b823mr2404474b3a.24.1785886779031; Tue, 04
 Aug 2026 16:39:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:15 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-12-seanjc@google.com>
Subject: [PATCH v8 11/17] KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
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
index f13100a7a63e..ec39ca82633b 100644
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
2.55.0.571.g244d577d93-goog

