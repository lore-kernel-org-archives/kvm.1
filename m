Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9793AFCF8
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279857; cv=none; b=lJjHNpgdGkYfkuiMk99uVZfENAsomY1lbRf2wFBEo70LzqWFT/nA5EOEQf07KDdhTV1ux5E2xqPn/feHG2fcxMsB6PMDatImUBVCyFExabSWcRXlpbrcE1wqcgXYLETX/xFr9xtMdmIDkNwpwnUxTFR3dgyR+7DU8dcANjwdrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279857; c=relaxed/simple;
	bh=gHXZcf7IOMhEOJ4FGfr7TBj1sqZnBOL1N553RhUOdqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WD1bcKYa6DAaxpf8pb6PHzSHgXGZ38wL6OUaPQvDUlSH5JQXVvY94upesj7wvtk2UOBGTxCTuek9cDHE4DCshb+alqqb0P7Ur+9M6vYW9nayqFFQ1Wj1lDstxKAqjB2YGum9y3aPBpNpz+d4vxvS863cseP5/TO5o+JD/LIMV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=heZFKCD+; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="heZFKCD+"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfc52ddc55so4240745ad.3
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785279854; x=1785884654; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1l81sd+1Dt+3WFLZZe7rfpxDHFJTbu6GbcdYA+gInbc=;
        b=heZFKCD+UpC5cJDMlKsyfS9fO5rMQFmCMbMkPFIxMODXmNfk+Vf1n7alfZ+shsoVpu
         nnRdDRybxGWfkx8naPex6HHKVQnZc74i3fhZh2tyLjcZSJdgb12tWNISLDgzhxQigC15
         9qZUBS865xSuneihcIMKYrx/SkMf1nHCKXlgCSzhYofdZfZPukJmrFoAyWKsWhxy9dVe
         BS9E+S/cmosTJCR9csEVyaq5ZD5ScyPEH1ksak5KSgu45yABQHRh9GugkTqxYEB7RysJ
         IL6EvtNoTCLwLjtuf0lf641LxTw6Pn6HWsLsuEXLATtoY4OS5Y2bFwrxafehhad8RQ2P
         2hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279854; x=1785884654;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1l81sd+1Dt+3WFLZZe7rfpxDHFJTbu6GbcdYA+gInbc=;
        b=FWB8tSXfqNW2dyXbyGSCoIKag+jfqWv/y48ZGnXjfHFNHFoy98s42j6q1aIJ+2qRI4
         YYXmOnzrAiGUcT//eVH8uPy8GgIQLqTFuvAx1vFKLjUKp7sHdnFlBIFLmuWz2ZeO+ZuQ
         IipDSv5gwP76WoChsETQylxvgLH3n0VX/S3Qksm6yRc6wUFvKI7jAd4UXSve4GdeMdh5
         khdbCAt6+VaejHRKjn808iXrxR7odr9xIt6W3lDMjI1v3ri7ioB0Zbz/Ki6E6ooo/jAX
         a8gT+RSAAlCqd3BAyMaHciyj8HTZBLlCi0+WYfeGfdWv51Qu3f1Pg+c4hAyvn3jFJ0cl
         UnZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq46w2ZctzXZESUfzwjDr6fRR95TZhyuOjP2bvz/1VUKLjS1CoKEDFXvhfMzSW2gRKrRJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4NkzWk1L6eEKKxMHER9jy1HrCDlSL/9qteCJt8bZZwZgHYC0
	q0cpDM4GISmntZQS1vdHF/wYxJmSfzNhmJEOHL/sUQFiDGCjap+uJZKzWGEAMRfYCt9PWHSZrnw
	MZN8xUQ==
X-Received: from plkz12.prod.google.com ([2002:a17:902:708c:b0:2ce:d2e2:393])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef07:b0:2cb:2b84:f431
 with SMTP id d9443c01a7336-2d015d607d0mr51470645ad.47.1785279853901; Tue, 28
 Jul 2026 16:04:13 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:04:13 -0700
In-Reply-To: <20260728144954.355376-8-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-8-dwmw2@infradead.org>
Message-ID: <amk1bREQeZNNW10n@google.com>
Subject: Re: [PATCH v7 07/36] KVM: x86: Restructure get_kvmclock()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 28, 2026, David Woodhouse wrote:
> When the clock read fails (e.g. clocksource transitioning away from TSC),
> fall back to that path rather than proceeding with uninitialised data or
> spinning in the seqcount loop.

This is not restructuring, it is a logical change.  It's a good logical change,
but it needs to be isolated.  This is what I have locally (spoiler alert; I'm
working backwards a bit):

From: David Woodhouse <dwmw@amazon.co.uk>
Date: Tue, 28 Jul 2026 15:26:35 -0700
Subject: [PATCH] KVM: x86: Fall back to non-master-clock if clockread fails in
 get_kvmclock()

When computing kvmclock and the it's currently in master-clock mode, fall
back to the non-master-clock path if the clock read fils, e.g. if the
kernel's clocksource transitioning away from TSC but ka->use_master_clock
hasn't been udated yet.  The rdtsc() fall back was added (well, kept) in
commit c68dc1b577ea ("KVM: x86: Report host tsc and realtime values in
KVM_GET_CLOCK") purely to avoid uninitialized variables and compilation
problems on 32-bit kernels (already addressed).  In hindsight, keeping the
rdtsc() was a hack and a mistake.

Link: https://lore.kernel.org/all/CAOQ_QsgVqS_PuJo8F10Gg5Xw+tKt+5gDx+kJf1j3CiPO4MAOqg@mail.gmail.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: isolate from refactoring changes, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a0ed0969fcb3..895d3cf7bfcf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1657,14 +1657,13 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 	if (!tsc_hz)
 		return false;
 
-	if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
-		data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
-		data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
-	} else {
-		data->host_tsc = rdtsc();
-	}
+	if (!kvm_get_walltime_and_clockread(&ts, &data->host_tsc))
+		return false;
+
+	data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
+	data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC |
+		       KVM_CLOCK_TSC_STABLE;
 
-	data->flags |= KVM_CLOCK_TSC_STABLE;
 	hv_clock.tsc_timestamp = ka->master_cycle_now;
 	hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
 	kvm_get_time_scale(NSEC_PER_SEC,  tsc_hz,

base-commit: f8c5e70f5ed58dc9d39db90ecaba0ce76ac52189
--
