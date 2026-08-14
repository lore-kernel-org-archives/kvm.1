Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512EB486BB4
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726966; cv=none; b=DMOurJt6Vr75Rh08Mhdov4EsLfcegcafYSFL9wICgJbmDEbMlEfJO4u7BctOITRbu6c2z6IxdBsqdPvJrXry+YD7X66qigoUDZ8wwgMU5BQJAxbsmCZ6t+mo4PM0QXXK+R+7waTpWoZ/rtFfdSPCd1gEtgc+jIomxNf18XZ2NgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726966; c=relaxed/simple;
	bh=JoZqmxpuuPNKAmYYoCdlkybFxzPOn0hNPVsF9oZo2WY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jOOFKjR6tKysNqFymM1hkeg9pubWTifwur6xYKrsH5X6V94cwA/K45VxZURoY9W2PovNJMVyusexXbuCCNG/8u5s8Oiz50lpuTi2m1bgaQknZ11EhNePERdZnedzcZodeHGqgY/OYhJmuN9CGPYj8pFwtfZPFI6YNmH0W0+qb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0e5ut7Q; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0e5ut7Q"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso893392a12.3
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786726965; x=1787331765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JoZqmxpuuPNKAmYYoCdlkybFxzPOn0hNPVsF9oZo2WY=;
        b=d0e5ut7QhAvb7W95+C04h7Xkqa1kBXgiHj6RIKAD2OqSWyP9WWQZmo5sarxcSZ5QoA
         9naNl/phGM3xOVyeG1oUDgfnRVuzijP6dLguN8k1BdEi+Oo8tPlFLpPPrPqaLYr1bEcZ
         D/ObU/DFR5soxnP2O4lhcqk7la1Bv339pPXPaRnknwOt0IJtrHDacuZ8fHFrITVI/y42
         9pYCId6GvUWUjxFwgYwyZ3Wm0ufGtoNJPbQEVpNSnSLxd+rzcXxIXdVyY/gP2AHFyxPs
         SbNxhzb98A7YoWTwWOM6mYkQJRK2hwVfvu2ApzIwcUyUU6oPhEUx7j4jP2d8AbvlagD4
         4F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726965; x=1787331765;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JoZqmxpuuPNKAmYYoCdlkybFxzPOn0hNPVsF9oZo2WY=;
        b=HX1BjcqtkfCAeXGxylFAiVcviUPzYu6UGqoqUJqWXMhdDyj0+jyO+kXQubRP7ulSys
         fyDpncnygWkKFS3qlTNkMGbhiNj7L4Y//g4Qlf9tPBFn5kVwOZTvLdnVmdqhDxPFzu97
         DCcVfFt7TxnbE+n/30uhzeDfBdor7ziOGnD1QNjtIg9+piIFOcuO9X+HLtF1vvhTe9ac
         KQ+hwEi+5zwiC8G/BwrC0uIif8m58diO4INMSc/h7IFusPJ9pN6K5QWRhsQ7a+DoV9D0
         GmyUPlH6oM5CsDKxJK53rVQ7Y94/WbeYQxmNWzbDXMXinyy4DYEUp32NN9IQ2/eWLsZg
         I2jA==
X-Gm-Message-State: AOJu0Yxc45rmLeuCCkFCy4HptqCV/+sNljvHX8xyoIr1L3xZZQmDxVV/
	GKrLH+hgmvgw2LnJ5WUxBbYufKbN3AebZo74SfTLZWula6ENlu9lfHe3tTQOsiiYBofg4Ns5pE+
	icDtuLw==
X-Received: from pgnd14.prod.google.com ([2002:a63:734e:0:b0:c9a:b3b0:a861])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0d:b0:3cc:1d29:f172
 with SMTP id adf61e73a8af0-3cc71fa83c4mr8041630637.22.1786726964456; Fri, 14
 Aug 2026 10:02:44 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:02:43 -0700
In-Reply-To: <20260814161950.136041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814161129.2177118-1-seanjc@google.com> <20260814161129.2177118-4-seanjc@google.com>
 <20260814161950.136041F000E9@smtp.kernel.org>
Message-ID: <an9KM3Ye-GX7WggF@google.com>
Subject: Re: [PATCH 3/3] KVM: VMX: Rename posted interrupt prefixes from "vmx"
 to "vt"
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Low] The function `vmx_needs_pi_wakeup()` was not renamed to `vt_needs_pi_wakeup()`.
> - [Low] The shared inline API `__vmx_deliver_posted_interrupt()` was not renamed to `__vt_deliver_posted_interrupt()`.
> - [Low] A comment inside `vt_can_use_vtd_pi()` references the old `vmx_pi_start_bypass()` function name.
> --

I also missed vmx_handle_nmi() and __vmx_handle_ept_violation().

I'll also add a blurb in the changelog for patch 1 to explain that keeping the
vmx_ prefix is intentional so that vt_op() doesn't require a one-line forwarder
when CONFIG_KVM_INTEL_TDX=y.
