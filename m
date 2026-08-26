Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055648B371
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780003; cv=none; b=ZJ08K6ub73a7z7lYGZcxDyxJYR4ORAjl79FFP40ceXiPsBWvttoeXPulbdaFhkEdCbxWfxHerfPpG2u2mbfaJErgk/uw6nrzDIuaY+xHOuKObS+c99DURKeQLu+aWBG+8xA/pg8U3cFEZJJOXozZtPpn9iE78Cs0QIfs/dPzqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780003; c=relaxed/simple;
	bh=9z6mjzl2SjhTUWaBxckfGZ0ZvIf2SOECpcAYHrhr2/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aRBOjC5/q/sYGIwAG+g36/hZtfBfMppnlh2jXqBqBa+pPSrjD6f29qMQr2Sd+PYa01tFHhksrS/RSB7YhfAms+Mb/lqeN5B8YYgEFMSBxv1CC5P7OGvLjPvQPdDeE4FQzlehC08PDFlCnJZugubr+t5qZSuZiWZNdsVlNhRHSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKlYsRwq; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKlYsRwq"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cacd6d37edso20773905ad.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779999; x=1788384799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=szdnMJ3ntif5HGVUZlK4HU9owrFtRnFNddqnadYAxEQ=;
        b=MKlYsRwq/aOElDtEVcAID6wClnNd2uxQelNuAn5r9F1HBnd2JFahMkRWSXiKLDwdp/
         7vXbfH/h/I7oFdFGrG5VXlOEAhJHw4M+Fg2h4sV8TnGtoRZLnr6eQPcw6ZsCOpRQle1b
         7mKl8kdiEDSU9tAy6pZ0+H3Em7TIcHqwOuE9STdh4ICUi1eXi+pJnW1I2+pSqFFyO4Wt
         u5Lf4wbtetIDLEEx/sHtS071m3xdkR7zQDHAC9NivcDvJ29zswKA8vqzddb1AZju7LmQ
         /2Q09gYgGGqnp06FZLILfEV8lWTOqCQvGJmUzuphiU4CDffIa6ITsVOXihQjbQQ1LlKb
         HAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779999; x=1788384799;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=szdnMJ3ntif5HGVUZlK4HU9owrFtRnFNddqnadYAxEQ=;
        b=Pe6pp3lZEm5DC3Hc3mwKsBLlsvO0nfXrO5VG61w4EQtIHoLNjFOgKDGVuMU5HDqtsQ
         xbI/9BGZkTV6Ss29EqGJKjOlDXiffG6OjAkvVdLr4cBeGwtSZ8KVAS7Ncmz0UVAdXxYQ
         AogSap+fxq2q/RFKJFSY2k7Z6SM/xLNgxAGVl0dRaPfWDGLA5J3bNTM2JsMBfIfXZVTq
         JbnwNq6X1JPTkRoWOzfTExTC116VZBeZxa/UBrPVopTpb/Xwd74N2127uEB0GfIYg+5b
         x9eW8L5sjXGWc4C11jsObIDcjWAq82a4nyUantbg6EP40RNXlN7EFPYIUna8z9G5HwRI
         BMLw==
X-Gm-Message-State: AFuF++nFd4JL62O7Tc0iL2njWIU73UAFZLaJrYeuYsRCWUpIb0mC6e2q
	RlROF1qMrYYXVhMRicHOfsGx1PlzhbUpSZh9Kp3zepJv4lloNuXZz9JKlP1PQFBmqk67/Sjc0n3
	Mqc+g/A==
X-Received: from plgm5.prod.google.com ([2002:a17:902:f645:b0:2c8:903:9ae7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:98b:b0:2c8:248a:5dbb
 with SMTP id d9443c01a7336-2d707a37141mr187514975ad.7.1787779998570; Wed, 26
 Aug 2026 14:33:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:52 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-13-seanjc@google.com>
Subject: [PATCH v10 12/21] KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
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
index 1da7b60fe274..b9b7ae965d6d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1941,63 +1941,22 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
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
2.55.0.887.g758fc8c411-goog

