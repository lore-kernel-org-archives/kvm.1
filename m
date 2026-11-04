Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829048;
	b=EC+X6M8sMRjwIYcEluQ7ZnGv9Gi6y1LZayiQGcpGcQi8FKROere/GeJzucGv0qJ4Jylj
	 GQjqgP8NdyPNx8LJPuHb2vLdn8gLhvZBIK1znI57/2xSNCG+UulAaaHVnjVKD7MvuOu2l
	 jHm3ullN8LY9HhJ6PyJow/J0ZSBfbTQnE8JWF3exR1CQK2h0EZuNpRDjX8TU7SrPZh2nx
	 T1E7gxYsVHFUIJWz9mN6Z6Hj0VVR6F2mlIwpXzaNV80DzbvXClK0UE0geXo/BWkqcWw/H
	 BIol8A4RUF/Y4dVoJeYv4xaDmZdVLZQnz+Pzq5Gh39UjbEJKgIST+0WQNM0aNNCHWbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dFChQ0mLr2TKcvvcevcbTzUnz/dF2dQnZUL2ZukNc7M=;
	b=OHSyU3OF/ETiDpu53WHyDVU/zLPrvYoWiveXmKNFreFO2KzzK568CNi9KUpwWo6s4fjV
	 uojJU9Nu4ZgypP+1VCI4fxx83Yd8HT9roAUXDIp8Qg3EKPGlduffpHTZUZBHB45sAF+j3
	 YjPiuUORKPYaHud/4OO9aV7TZ7zQJS0g5QWR8RnKmILt+ZHVFNGwTkev71EcdyuntPPwa
	 /GjE3dKqQe9uwPBPI24m8YF2FRdAScdaJNb6FT4n+3GBvISNVYoaBFAVg9eOoORGymZZp
	 RrltU9bj/xfDfh6EJLY2nzHy9azkYeLrz5KFa9YrXW5fhY7YEkF9KoQfjazBlgceq/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M9S0tvwz;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB76070772
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 21:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70AB76070772
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M9S0tvwz
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso1353192a12.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 13:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793829048; x=1794433848; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dFChQ0mLr2TKcvvcevcbTzUnz/dF2dQnZUL2ZukNc7M=;
        b=M9S0tvwzc3cQs/jygskQ5D8xUmXs1a229U7+1Z0I98bqqBjLA/pme3j2jrHJ/tu3dg
         WXusFODXXGOllpNsB2M2bk++eeUlT5C/w6TJ8QxTlcWEVdsqHbnrTTwUeU/s3EZJREwQ
         vz9ebxujUXuZPxkwjDmh45JnUTNAOsh6QgzIMILNDcRqrVURkI75NvEvHq0RMj7K4etr
         PevPKnVPUQXSkiwaBr1C8NkgfhIYiMEcg77e78qhI9pZ5mF8LtDKZeNErJDulCMYsk4q
         62/Fhyk5Pc3R6YSq8BzBkUxAbD6dM3rPXfV+iHgXBsHecd37xPL98lsIWlMNeS99nYSJ
         hSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829048; x=1794433848;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFChQ0mLr2TKcvvcevcbTzUnz/dF2dQnZUL2ZukNc7M=;
        b=VhIapzKNfDKuITtsedzp0cziKqsOi2a3D5qcXA+Unxo3uIvR1XpvlAyoxLSsnOZtKv
         BsN73fq8mOt9LdMTszBZ9QrLtBKJJzOIRdAdh38FPYacFpCZd4uePW1D+iU0WG5cos+1
         fOF8rqh4Z1cEHVoMjTYqhGgHkDKntbXxdyEE3SZqO9s0aXtgKu4euO5GerF2ONfjNj7n
         cVfmwXy9Y1UEgxeyT65uOPmRBggMB0uqA8umDG04Mvwk7qsT7VMxSAJf2bxxw9trrqFl
         ATSYAAINXNE09jB1McZbEWknShZegUaVErxXTiqnlZevglMCwwuqXtnf8KS2kjmw4/PY
         C6bA==
X-Gm-Message-State: APuU4Z+nTr0aBjKtdfPD+gUlEN7LGbZ+J0BzssCZ7xAyZuo8BYHU+wSX
	i2ddcJyzuYO8Ik/2wocyx/dtH6kD8VyZj5oPYju6McASD+/PHR2U37INKOHnlYe9kuWDD2jNm+A
	XvxiYbw==
X-Received: from pleo5.prod.google.com ([2002:a17:903:2105:b0:2eb:15a2:31f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef03:b0:2d9:216a:cdd3
 with SMTP id d9443c01a7336-2eb3649be94mr173739735ad.18.1793829047606; Wed, 04
 Nov 2026 13:50:47 -0800 (PST)
Date: Wed, 4 Nov 2026 13:50:46 -0800
In-Reply-To: <auue7S_vdnGtTM3c@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103002205.3348519-1-dmatlack@google.com> <20261103002205.3348519-6-dmatlack@google.com>
 <autHA6aNrg4s5PkV@google.com> <auue7S_vdnGtTM3c@google.com>
Message-ID: <auuotv1vFpocCSeW@google.com>
Subject: Re: [PATCH v2 5/5] KVM: selftests: List the known IOMMU modes in
 irq_test's help output
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alex Williamson <alex@shazbot.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 04, 2026, David Matlack wrote:
> On 2026-11-04 06:53 AM, Sean Christopherson wrote:
> > const char *iommu_mode_names(void)
> > {
> > 	return __iommu_mode_names(false);
> > }
> 
> How about listing both? That keeps -h consistent with how other KVM
> selftests list the options for their arguments (e.g. backing_src_help()
> lists every backing src type), while also showing which modes can
> actually be used. e.g. on a system with only the legacy VFIO container:
> 
>   # ./irq_test -h
>   ...
>   -t	Override the IOMMU mode to use
>   	Options: iommufd, vfio_type1v2_iommu, vfio_type1_iommu, iommufd_compat_type1v2, iommufd_compat_type1
>   	Available: vfio_type1v2_iommu, vfio_type1_iommu

That'd be awesome!

> The available modes also get printed when the requested mode is not
> available, i.e. when the __TEST_REQUIRE() fails:
> 
>   # ./irq_test -d 0000:01:00.0 -t iommufd
>   1..0 # SKIP - IOMMU mode 'iommufd' is not available.  Available modes: vfio_type1v2_iommu, vfio_type1_iommu.
> 
> libvfio exposes iommu_mode_names_all() and iommu_mode_names_available()
> for this, built on your helper for juggling all vs. available.
