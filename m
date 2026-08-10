Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A05425886
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402515; cv=none; b=J3B9uByHko4iemo3i4HrQpXkcF/vsJv23dtQIFnGWgx9pXL526axWYP5M/VI/CsEuFAnACegIuS7iT0Oq2LlyMOtQ8N4X6OPfAKbVSYe5jx1svH+7UTu4cA35GZpk6lKC1uTJRg9CeVS2Mx/0NwLn+FVO/5XWmL1jk6zDYum0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402515; c=relaxed/simple;
	bh=es4fCK6dWHmOsuq74FJz6dq2gHBwrNsXF0MHmvd49x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kuNk7ingglK1nonf5Z6aIv7U2znVrDCwkJ1dB37GLEy4fLqTLUPjUIXfNjyFf9NfCG6bZwIRNxv06iauYq6qGOowrUFHNDRijsdac+KVAmBF9FNHVXSh7S4tMW5P5MePCYYHv1uvXP72q20UqSXO+cr0ofjbnNJH3QCKtsU6gyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIsPqNPa; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIsPqNPa"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84eee2147ffso3094043b3a.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402513; x=1787007313; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6mJNwRsIdlgcDx1k8DwIZJ30uuN1iHndQUOpDPZR580=;
        b=bIsPqNPasVfvxZyKkp4PenPvUlebq2+0r1UxFcYdFRRvy9UY4tmluknNt60g6FuUNP
         /CJ8dIJjOatLfvK3zXDrCav9BJjCMgZKJGWPe06MyYZV3EftqjUh/cc+LrSMQv+Gfd+C
         Srn3re9OUlqcgo4BFymm6Ovr/miIJue29t4RbaZT+8eC9KKognEquT/isVavBJjyUq6d
         6dGZrYT5uD17WWQvK/I/AyqRz2GDh+KffCu34q1EwNx0VRZDonLtL0y06F+ZgAZS/ljZ
         TACCuahtX1RWETo+uRNl7a6Ol+vjEycV/fHDLc7V1BbJTs7DmTkBNRvZ8MoET5WQwAez
         kqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402513; x=1787007313;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6mJNwRsIdlgcDx1k8DwIZJ30uuN1iHndQUOpDPZR580=;
        b=g3CTU+kjU76KETzMhUERsynDp3cKvvOYQ0m/tGlds39QGp4AMIlK+taFPA3oc1Fam4
         HrS2sBUnL2MfmHgIRtQxtv5k3P/XOXoScGujwkorIWaUqSFWH4l0Z1w9bM5mXDNtWLWs
         YTuBQ8vdaik7o1LNfvM7ADnlq/OyZ6AHlUAC4vWTJcHDnBKkgqLAtK2SsSHnIrEQ2X3i
         kSzEG20LZeygxX3Oz2pIkbkuU9vllZNA6TPTswfz74TrYYzxUb7T1hZKLrn9bnCZdKTu
         wsG08PoZxDTdJ7gHb2ZtOD2TF6NwGRnGWJlsB2rksd+THqotDvHf8C6CBkwHaWd7iGFi
         b6qQ==
X-Gm-Message-State: AOJu0YzxkfSbVG80De8FzU23n2d1wwSfrOU5tVEZzbmjqxvn8vIdv/ng
	B1bySzN5MfsESkE7ll7Fre0p3fMSZozl9C/D5dzrqVq5LdktJ/COQz6E1SK7wt7f2w4iJ06gNJG
	mG+nXzA==
X-Received: from pfx36.prod.google.com ([2002:a05:6a00:a464:b0:84b:44f4:2d62])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3316:b0:845:36a0:9eb2
 with SMTP id d2e1a72fcca58-84f69770781mr26628844b3a.34.1786402512910; Mon, 10
 Aug 2026 15:55:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:46 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-9-seanjc@google.com>
Subject: [PATCH v9 08/21] KVM: x86: Move "no master clock" fallback from
 __get_kvmclock() to get_kvmclock()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Move the fallback logic for getting the current kvmclock when not in master
clock mode out of __get_kvmclock() and into its sole caller, get_kvmclock().
This will allow using early-return logic in the master clock code, without
having to resort to a do-while() loop and/or gotos.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 56e095b14441..e0d623a122eb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1651,12 +1651,16 @@ static unsigned long get_cpu_tsc_khz(void)
 }
 
 /* Called within read_seqcount_begin/retry for kvm->pvclock_sc.  */
-static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
+static bool __get_kvmclock_master_clock(struct kvm *kvm,
+					struct kvm_clock_data *data)
 {
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
 	u64 tsc_hz;
 
+	if (!ka->use_master_clock)
+		return false;
+
 	/*
 	 * Snapshot and validate the TSC frequency as kvmclock_cpu_down_prep()
 	 * zeros the per-CPU value when a CPU is going offline.
@@ -1665,8 +1669,10 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 	tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
 	put_cpu();
 
-	data->flags = 0;
-	if (ka->use_master_clock && tsc_hz) {
+	if (!tsc_hz)
+		return false;
+
+	{
 #ifdef CONFIG_X86_64
 		struct timespec64 ts;
 
@@ -1684,9 +1690,9 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 				   &hv_clock.tsc_shift,
 				   &hv_clock.tsc_to_system_mul);
 		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
-	} else {
-		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 	}
+
+	return true;
 }
 
 static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
@@ -1695,8 +1701,11 @@ static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 	unsigned seq;
 
 	do {
+		data->flags = 0;
+
 		seq = read_seqcount_begin(&ka->pvclock_sc);
-		__get_kvmclock(kvm, data);
+		if (!__get_kvmclock_master_clock(kvm, data))
+			data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

