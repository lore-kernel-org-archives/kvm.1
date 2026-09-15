Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C7E3C1D5F
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476808; cv=pass; b=iAHyBfBpFLgYI1mNrVxj/ldxSE6+8X8M+S6b8lPzA3pkcP9Nbz6mLZFYbAo/Pf5X11aHlQguhBgZX85AclfOboQ1Fue/Q1GkYO0Y3AY4eKyJ4FZYqgeI0qF8DVW+hO/M6k3JECRvkAkwteUG4KJNL0c7SuoqqzZrlLwmMc30ArM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476808; c=relaxed/simple;
	bh=JveBD4NjpdikQ0G4ZFLu6buTCcNw4yCNRgOH8W0zYCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBsvp2CALpMe81nnxWupdFtZvm7kB5MX+rMabvVTVd1+fqMQZTrGcn3sFrhtGQGrDTKeUWOBErXpgWHkykUebrmgaGWC0W/7ne+aMDIlh1pdsGgCrfsqYE+FmwMFCUOTvfsAaPcW0JGljKseQgfb0Qui8zBAIkIypv42hwe+m74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TL2hwbSc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDl1dwBz; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TL2hwbSc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDl1dwBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789476805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v8YiA/oJGna58idX6bHTg2NXYKQTwPzzs6n49mhKk8Q=;
	b=TL2hwbSctl732sw6xVW/i92U1LWzYCDsq1HyprgnZELVogS2Dfk0U6nZXC8lXNyZlTdOOk
	OX8NnRZOslNqv961slDI84Lp8oUHvjJK4tVjbueVRZAhZuOaZG6QebD6fPDN+/oq0fcrHC
	gTuCwTw+3iCrgr2kBjADXfcxA9RHbXw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Pi666VmJPVWLMl5cfrFLMA-1; Tue, 15 Sep 2026 08:53:21 -0400
X-MC-Unique: Pi666VmJPVWLMl5cfrFLMA-1
X-Mimecast-MFC-AGG-ID: Pi666VmJPVWLMl5cfrFLMA_1789476800
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39533bb224cso5743625a91.3
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 05:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476800; cv=none;
        d=google.com; s=arc-20260327;
        b=HLVho7yt3hKJ9nr/RnD4KLc7mA2JTQFdaX62TsOHGdaMnig90ocy39iD0/QwHTULms
         4oukoYvWu2Fb+WpAEZg8gkaCvML4WTXfMQZ7N9XeXMFJN+tGrfGpQ84vgBAZgY0QajrG
         PqyyMujNoBBhXeCudckBWSe3qxnMOflksfi0vOEByN/zTGGlAZpzAJHlY19AwxARaelQ
         VYaakM2CHJyu9Doo7VviVsLmiBn3YCPOn6f2fSe2kikHyUxrc3eMsTgfnJANsU1PSrWc
         XPsfc84K4VTE/6v/64At6GXKTOQEVeoHds8ltLLeMHjh2/7NmmSrBOJAmshIWwapMDRp
         ra0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v8YiA/oJGna58idX6bHTg2NXYKQTwPzzs6n49mhKk8Q=;
        fh=nffIcjvVPDoylRzHwKGKrc+2CX/DdziKEjZOEyeEpS4=;
        b=FW9pMKk6xGnoON2velezdLTTCAvfcqpyYaom6bSsdk7VYWwhWB8TgNZz/0TLTW6MKM
         ily2B95lPizoqL/TnkboXoSnFPDPCxBT1jgv8RlkKq9C3OAbdLCBQHIZhevftgJEY8M4
         VAFYomH9azLXiZV03MRM3DAaZWXJuyLjv0AcPyfqD/0R/d3xQWofymVhRwSj80n0metr
         NXp04zrjsAnXCf2Su9hVNpdRsBGV/QKFWhTFQfvipZebdt1VzBg0qpvXEFVYM8lkk8FQ
         E6UnIuCv5U6dqXhvGP/XxS1XJgU9+tU9Z9PnujTV5HGJF6UdDK7p10FwAETo23DTU/Kx
         JAuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789476800; x=1790081600; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8YiA/oJGna58idX6bHTg2NXYKQTwPzzs6n49mhKk8Q=;
        b=bDl1dwBzrfN5ytOiVw92XjWdjdaED8ybQluWTXs/MHiNDPh2peWNMkJHFlvszVyaYn
         OPeIQWfsemGgqJT7Z7uywt6Wpxe0hqmA4rftdkacJ0i8E03sONw3igq1siSbUhg8JH4o
         lD9LjFuBvbP5LANOIwCHGTTQQ6Utqtpa/IlOGt2Q8e+JJlSJAXzwb6bw/9vghmyWe+ie
         1kMcyEm4OSmm4xqxP/GQ2D/8Kiwz8EFahqSpoIsTVdXLi/71nVAA+7Ee9Cb0EKzcBgGN
         xWOgJsMvcCbyrjT8nDoVY2wBEYBu1tt1CLiTiwVxoYJeyOw7mgkzsPAv18rk/TqqOXLH
         adJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476800; x=1790081600;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v8YiA/oJGna58idX6bHTg2NXYKQTwPzzs6n49mhKk8Q=;
        b=zNHo7vA+aUwQja2ejdGQ2jUjf7q1QDiaiUZgvl0hlJchqtIiuUINsmEYPgVFOTpFq/
         LK3dOFzYxUEMluM1cYd0S9Cuy5em6fXBDrWiFd+VbMKMJUgwn0ZIBqJT0x2hHRa8eoif
         JH1KbS9VjkVQs2TsjgN3GCUadG3Pgw7Wbn7cN60cbAOwT2i2jGGcVvzslkscPHtm8rjb
         BKH0cuGhRg+y3zoIInSH8dRPC8ihYN1gQCR+Ov/TkOdS0Yn/AZwc1aLEW3piE1Dr/j6F
         Br1mSoYaSEB98GpdqRWYDzENbOGVz7lqdGSJdkqgQseEwhMlcuoefnqFt7cDVMP+2+He
         XLrw==
X-Gm-Message-State: AFuF++lth17rYMfZZtbqNxZY+krG+hda4DAsTSYjU2hWlwHCJyiJCgHT
	2/P6kXGxp6L4J5rtI6tuOvbvwKpBCXtraZuAPCCV/TrvfyQLIqJVxfSoFsgRPdEdY8yoNgseFey
	GCWFBnimijBpV/dXvHIXaAtA8MIdXdGwmlTkPjjdKDCMFS1n8S6xL+FclYKThQ/x6GqYGrmAHcQ
	3VxlUIrvexzPuGQrlgb4egVD0a3Wot
X-Gm-Gg: AYBFou2faU7/8XlUVZN0TXokIMnsteMvMX69/q4t4gyg9mUmqZOaMV/GAEjAQJqDpXW
	VuWzTwqu8KPHLIW5UpLglZ/3RJHqyTrufaD0fIkNPeNRpAAUfdVkNJUNNVVbG8AomNYDzNhg3xC
	cUK8al/ZYN+WjNk0jrjj5ArIKt25/FYM4++D1Lw9ZYiRtgV1imPs3bkMgfgDcnda/Yv+WBS2QS0
	NMA/5srohnUtuU=
X-Received: by 2002:a17:90b:582f:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39dec05fc8emr15169123a91.16.1789476800128;
        Tue, 15 Sep 2026 05:53:20 -0700 (PDT)
X-Received: by 2002:a17:90b:582f:b0:398:e96a:8999 with SMTP id
 98e67ed59e1d1-39dec05fc8emr15169052a91.16.1789476799542; Tue, 15 Sep 2026
 05:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914143702.915401-1-aharivel@redhat.com> <20260914143702.915401-3-aharivel@redhat.com>
 <aqgRj7mfDhCUqWw4@google.com>
In-Reply-To: <aqgRj7mfDhCUqWw4@google.com>
From: Anthony Harivel <aharivel@redhat.com>
Date: Tue, 15 Sep 2026 14:53:07 +0200
X-Gm-Features: AcwNN1WfdFR9kOF37UhlEyvnuaXz_s8wik_ywIeuUwqJPlrCykEaJJ9xTEj48V0
Message-ID: <CACUOEi8ff_jeA7chF=TQqLc=UPJnf-nVizsq0h4JdqyGepGVOg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/3] KVM: x86: add KVM_CAP_CSTATE_POLICY for per-VM
 C-state enforcement
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Sorry, NAK, this doesn't belong in KVM.  Given that the only way this can work
> is if vCPU are pinned 1:1 to pCPUs, then it should be very doable for the cpuidle
> subystem to provide an interface to let (privileged?) userspace restrict the
> maximum C-state on a per-CPU basis.
>
> My apologies for not responding to v1 or v2, I am guilty of Jim's axiom that
> upstream doesn't respond to RFCs without code.
>

Thanks for the review Sean, and no worries about v1/v2, I understand
the "no code, no review" reality.

I agree this belongs in cpuidle rather than KVM. A per-CPU userspace
interface is the right level of abstraction; it works for our pinned
vCPU use case and is useful beyond KVM (DPDK, bare-metal NFV, etc.).


> +      Option B: Use forced_idle_latency_limit_ns on the pCPU.
> +      Same per-CPU limitation, and latency-based rather than
> +      state-index-based, less precise.
>
> Conceptually, (b) seems like the right approach.  Per-task will be a mess because
> similar to a KVM-based interface, it can probably only work if tasks are pinned
> to pCPUs.
>
> And isn't abstracting away the exact C-state via forced_idle_latency_limit_ns a
> *good* thing?  Without that, userspace will need to tune its configuration for
> each individual uarch based on the properties of various C-states for a given CPU.

I also agree that latency-based is better than C-state-index-based. I
mean "Max 10us
wakeup latency" is portable across Intel/AMD/ARM without needing to
know the C-state table for each uarch and that's a real plus.

I looked at forced_idle_latency_limit_ns as a starting point, but it
doesn't quite fit as-is. Currently it is:

  1. Kernel-internal only, set by cpuidle_use_deepest_state(), called
     exclusively from play_idle_precise() (idle injection for thermal).

  2. A governor bypass, not a governor constraint, when set, the idle
     path skips the normal governor select() entirely and calls
     cpuidle_find_deepest_state() directly (in kernel/sched/idle.c).
     This forces the deepest state *within* the limit rather than
     letting the governor choose while *capping* at the limit.

  3. Not exposed via sysfs. No userspace interface exists.

For our use case, I want the governor to keep making its normal
decisions (considering load, predicted idle duration, etc.) but with
an upper bound on the exit latency it can select. More of a ceiling
than a "force deepest" override.

I see two paths forward:

  (a) Add a new per-CPU sysfs attribute under cpuidle, e.g.
      /sys/devices/system/cpu/cpuN/cpuidle/latency_limit_ns
      that sets a governor-respected ceiling. The governor's select()
      would filter out states with exit_latency_ns > limit. This is
      similar to how PM QoS cpu_latency works, but per-CPU rather
      than system-wide.

  (b) Reuse forced_idle_latency_limit_ns but change its semantics
      to be a governor ceiling rather than a governor bypass. This
      would affect the idle injection path though, so might not be
      desirable.

I tend to choose (a). I've already done a PoC that is working as expected.
I'll send a patch queue to the cpuidle maintainers (Rafael Wysocki,
Daniel Lezcano).

Thanks,
Anthony

