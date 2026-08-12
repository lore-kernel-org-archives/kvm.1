Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490432AAB5
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567532; cv=none; b=mPF+3F0NvL6c4VHSMuXFTjvZ2C88J68Wv64bXCPRTwGzmL/l8rwyPXlHYfaHjRST9fZeTVR7kNDB7Ys/BTgKWqQtJ88KrGhuEek9nOK+Ve5NkbKbkC1+gjjfsPGo/eDh3Xks9VqNDL+rNedO6aa/aVlaedX8CQxgS4fDvZt97VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567532; c=relaxed/simple;
	bh=rFwUI1O6iAgNzWLgm/J9bi1SgsUeg3/DyEX1T2M8KIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SdXT9m77TFKGQiVnB/gxCIsSdfQxcVeFq5gJ/DaMpNZGseN86zaa0602Rm4M7WodLi0m1MMB7j6ZeRZYvUZ+CJ0XYrrhFZKciXgdbh7ORzCqgN2Nx4wB5VUojtjfwDevjBv9SA4Felfnhu41VE4dQnNqx7QwEbP5HayR9TpC5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnQucr4u; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnQucr4u"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso1603294a91.3
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786567530; x=1787172330; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPeKxQgdY4MheVucVURWAKOB7JzvLvW2CiBPsSMFwIc=;
        b=wnQucr4uq4aDL6+0nMGoJRmqA6n30Vos+2VM1d5oWLKbHLkWZ5EbQWm1GKy8pq2BWN
         V/FA9quiBGePMupt2EVHPLhGhgg50Wzqzvt7z6B83zauidMC2P4+q5/plLA1LGYij0GT
         U++CAOoznRdFLaAsTtshzX7WwUIvhwU3E87Hg4Yo4lZtXI5LoH+DOz0PiBD7R+GYdy+U
         LJzsSbUBP0nMPLbT887bp+Pbuu8hW6C/z1wbY1ulstyutgo9s6pQoR0wwgURoje3Ifou
         LV4Qh7jACiOPIvuUiU6QvZqB/6oL46iku/iO4zkSJt4tqGdgRLNg4mtqvx1pSX+5F5fw
         xVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786567530; x=1787172330;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPeKxQgdY4MheVucVURWAKOB7JzvLvW2CiBPsSMFwIc=;
        b=J7TkAAXHMtQ+AIbxJmaxdQarO66kCWrYU+KYOLiQbm5DE8GFQMrtn8EgzEQJ8uu8xw
         F8/HHBvRhOXokmuTQHrEJ9jCPbit/fLthxOfV1byhb1kdMRH2YqdE96QcA+gqflCCcp+
         zfE2cAgJcGgXjnEFoFw/G4VmHW8Wuo+DntnS7wMH1de8d5gO0kWrFQk89OZtn4IHtQ5U
         CeBBx6E6YFjKDnx/s70yp2rOyvxVVFS3Wtau1klfZuEp4fpOPDbNG/JS9+CYZTCNSSvb
         S/uXYl9gxSs8v5F9j9TNvZijUgCAtdOaMxhv/5xDF0NpPnVTbB5CSs8UiNNE014E53ad
         iOHQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCE1aeg4/EBM141lGQvLrmgNrp1Im6wki4H1bJ/iStGAXyyDsHb7SeYRBi/X/4h4dGIFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ffAkYPv8Rj/K3OgwBdLWMCC5Z988dsnhLhQtOUheVAviznA9
	/eTJdwrv0JLJK6NSw4nXzOkE+EkJME45M06qI6VriDnQ7TePuVhItWUsKoHH+EMd68xPIfQe2Xf
	zJMO0xw==
X-Received: from pjbgi9.prod.google.com ([2002:a17:90b:1109:b0:38e:ffcd:b70f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc8:b0:38e:e9b:ffa4
 with SMTP id 98e67ed59e1d1-3931e0262aemr1153095a91.6.1786567530369; Wed, 12
 Aug 2026 13:45:30 -0700 (PDT)
Date: Wed, 12 Aug 2026 13:45:29 -0700
In-Reply-To: <20260810225500.869288-7-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com> <20260810225500.869288-7-seanjc@google.com>
Message-ID: <anzbaS86UUGNOmfn@google.com>
Subject: Re: [PATCH v9 06/21] KVM: x86: Avoid NTP frequency skew for KVM clock
 on 32-bit host
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 10, 2026, Sean Christopherson wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to monotonic raw
> clock") did so only for 64-bit hosts, by capturing the boot offset from
> within the existing clocksource notifier update_pvclock_gtod().
> 
> That notifier was added in commit 16e8d74d2da9 ("KVM: x86: notifier for
> clocksource changes") but only on x86_64, because its original purpose
> was just to disable the "master clock" mode which is only supported on
> x86_64.
> 
> Now that the notifier is used for more than disabling master clock mode,
> enable it for the 32-bit build too so that get_kvmclock_base_ns() can be
> unaffected by NTP sync on 32-bit too.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>
> [sean: rebase on top of ktime_mono_to_any() usage]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

...

> @@ -7118,9 +7111,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  
>  	if (pi_inject_timer == -1)
>  		pi_inject_timer = housekeeping_enabled(HK_TYPE_TIMER);
> -#ifdef CONFIG_X86_64
>  	pvclock_gtod_register_notifier(&pvclock_gtod_notifier);

From https://sashiko.dev/#/patchset/20260810225500.869288-1-seanjc%40google.com:

 : Does this add unnecessary overhead to the timekeeper update path on 32-bit
 : builds?
 : 
 : The commit message notes a rebase on top of ktime_mono_to_any() usage. Because
 : of that rebase, get_kvmclock_base_ns() now uses ktime_mono_to_any() directly
 : and no longer reads from pvclock_gtod_data.
 : 
 : Since all other readers of pvclock_gtod_data remain guarded by CONFIG_X86_64,
 : is pvclock_gtod_data now effectively write-only on 32-bit? This would mean
 : update_pvclock_gtod() runs on every host core timekeeping update just to
 : populate an unused struct.

Huh.  Indeed.  Now that "Compute kvmclock base without pvclock_gtod_data" will
land before this patch, there's no need to register KVM's notifier on 32-bit,
and this patch is simply:

diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
index 67c762b3bf28..edafe13f74cf 100644
--- arch/x86/kvm/x86.c
+++ arch/x86/kvm/x86.c
@@ -926,19 +926,13 @@ static void update_pvclock_gtod(struct timekeeper *tk)
 
        write_seqcount_end(&vdata->seq);
 }
+#endif
 
 static s64 get_kvmclock_base_ns(void)
 {
        /* Count up from boot time, but with the frequency of the raw clock.  */
        return ktime_to_ns(ktime_mono_to_any(ktime_get_raw(), TK_OFFS_BOOT));
 }
-#else
-static s64 get_kvmclock_base_ns(void)
-{
-       /* Master clock not used, so we can just use CLOCK_BOOTTIME.  */
-       return ktime_get_boottime_ns();
-}
-#endif
 
 static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
 {

I'll post a v10, since this is a non-trivial change.
