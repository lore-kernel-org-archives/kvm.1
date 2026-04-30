Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1F40B6C4
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777572906; cv=none; b=K5zIL1aSMUCxcb1BlIQJmBZtzeXFpcCnUu0AftWYbk1+a8YWqnabqQd+7lx/DNcBQrZHWeOwO7gJjs2yJ4IbLZZkUCgGY6NaXd4ofk/rhpV8osTGfwtF+IzvCv6r3aKTrF5YLRokIRg+dxSf5+y0PQCrFZIj/x0KN7WDjkaCWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777572906; c=relaxed/simple;
	bh=JrorKwYUHH4zZ4zy+pqcEJAl4tqafS2Mqv4yUo/QuME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FDU75j2jkhuLBLBvB44GQ/R/VJLyUxJQ/PzXlzLUDpHTuGLnL3q08c1ARgzCKlvtRvAAmOfg4E5Sdpn09NpdnrWzV5o5CeKtcs3ANun3uynnARu2VY8zy4wltylGsUu5nWTHaT/WnfMLIKJFBkEtTVHyNQk/ltKOepPOraBNoqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4vJLKU4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4vJLKU4"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b7c2ee830aso26595755ad.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777572905; x=1778177705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1+2Il3IVXV0VYL0NW7a1NeGzgz+qodUBQceYiBkkQc=;
        b=a4vJLKU4M+tUxBuivkM1puVBf1FjmzvjXKcoGjIALFQrogFC84KMk/r08NzBV8pYSa
         MLTbiDgvxn9BSXahJA9L097EQAKx/YMROSY2K77epTGUhGJO9rTmldeHIXBwniP7KIa5
         T8T3X/tRPAWWEEFboqMETcdsYve5Wi7c0e1BlLt2/7USMc+zvXEh67ZU1zrcdgteLW60
         B2mX9SPI5kN+DYHQm3NjzAZkXqOX7VFltXWWpjgikaTkOzRHGd/NdBRLt5dYL0e6xV3Y
         KD/OAL3WVs4IpDzhhzviYG7tAL4hGV9zJz2KTAqPFbC4MutzyV4e3tVqw3d1b8xsQ57J
         qdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777572905; x=1778177705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1+2Il3IVXV0VYL0NW7a1NeGzgz+qodUBQceYiBkkQc=;
        b=IAJBk46BEzu/eVX4iy0derxKqBGH6rC/frFVNazerA7d1XiaAWkeIEhSgBpJM54dHB
         zoxaHRtd1+/FaWIqZRhLncDwYcrKdR0Z0oyMa0Nf7yKeW+RT2L7ByzKju+2maY+OqynR
         UhEkHfk5ZD3B4YzWWGVhHSEpIInwwrpLQOVfeIN8kKoTvBg+WOodqorSSMAv74WDT+LL
         ZC2z85WZGp2Jo7a6GJhddUT9I0JFHvbquLZ1Ltzea7jtXxoW0/ZmF6b8KtYI2eGJGPs0
         NoypwWiFlIoee/PaiGvNxHi9PpMTugde29pz5Y/rlEy4paLz1ahmR60rnEy/IcwzrOqR
         hPNA==
X-Forwarded-Encrypted: i=1; AFNElJ9u76jxwFzCnrXCaJ1jlPU6hDNiB4zWoPdtW7qHJJjCFA0XAOv1QG9y6TJpwrjwYDq+xY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyroIM26m2I0FpJrT1BZba9yMgYLMGtp22jtbRD7YNunTvrK119
	J3eAYYJ53KenerPuWH9IOA5rrXHy0FNYi7pSlld6Gwg+P+E0rRF/08p6vffXGgbAS6uIMNybbrW
	WFn/lKQ==
X-Received: from plpa5.prod.google.com ([2002:a17:902:9005:b0:2b2:a488:ae47])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ed0:b0:2b2:4a9a:b168
 with SMTP id d9443c01a7336-2b9a23175c0mr42550985ad.11.1777572904545; Thu, 30
 Apr 2026 11:15:04 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:15:03 -0700
In-Reply-To: <20260430150747.76749-5-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-5-pbonzini@redhat.com>
Message-ID: <afOcJ052Cs1BKuqi@google.com>
Subject: Re: [PATCH 04/28] KVM: x86/mmu: shuffle high bits of SPTEs in
 preparation for MBEC
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> Access tracking will need to save bit 10 when MBEC is enabled.
> Right now it is simply shifting the R and X bits into bits 54 and 56,
> but bit 10 would not fit with the same scheme.  Reorganize the
> high bits so that access tracking will use bits 52, 54 and 62.
> As a side effect, the free bits are compacted slightly, with
> 56-59 still unused.

> @@ -84,8 +94,8 @@ static_assert(!(SPTE_TDP_AD_MASK & SHADOW_ACC_TRACK_SAVED_MASK));
>   * to not overlap the A/D type mask or the saved access bits of access-tracked
>   * SPTEs when A/D bits are disabled.
>   */
> -#define EPT_SPTE_HOST_WRITABLE		BIT_ULL(57)
> -#define EPT_SPTE_MMU_WRITABLE		BIT_ULL(58)

FWIW, I originally chose bits 57 and 58 so that HOST-writable and MMU-writable
would occupy the high byte, e.g. for faster access (in theory).  But that's
uninteresting in practice because the mask is stored in a global variable, i.e.
the compiler can't optimize the SPTE access anyways.
