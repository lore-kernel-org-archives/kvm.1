Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794257706;
	b=j80HCMa46BwHtI+jyYnPdpm38As0EdWWUHFsQ+aUaYrbf1LkihsVZyy2WZtjLHoxLZkZ
	 W5TSZUX05NWEaklZojS9Ge71GziB/DUI+m9cqY54ZcYiGPcRiYxQsphzNp5eYeDJA5xC4
	 /gj3ZGRYDGrG2mgw1pY2qA4nsM2drrwN6OIQibSQMC2Ml6LhS+EXv1VJs0h6yflkjoJM9
	 FkznMAYFLifsVqtBF9WDM+iLsJ3Hi/u5Uk0Oenku5RDZOEedVP1SfSLkGU3Lr/x5yc4b/
	 vcFFG+sNh+E6r8rujqxz0tR90Z3yhxh4wNyzzMsiox7wzgW7ebjL/W48imas5w2xWaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=y1VTS0UpwTi7iGDm58nlPTAXVAo5zOfjQYIrVOnYmzI=;
	b=tbmUsa+3qvWVlqKvV0fCsLPlOnhggqdlIvj7mvyuVr4uwdqRaaBjD1Xn/afjC0mSLju8
	 psYk6AxjH3n0AdYKAVONzLz56QnXq6aumLuGvVnRrmE9/O3G1ew5GGavBx7ObbvFFZPm5
	 qMZlPppKs+oll0P9YaGNElALg670dMc1Aa9TgPJCY5Jem1biS/EdqLavUoJir9pFz788Z
	 B3dBcPp6NykaNhqU4VIeLr3zBbp/ySERBLoCMjBElanLlfiWrSZEiZKOEkckU81Y4f9Va
	 31rtHQ5hpr9MG90nZ7FwKAEBxuLKWCrA/9dz8dD610K9fY5N+jMlK5JwuRMQwanof8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d8MErA6a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FF606A325
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4FF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d8MErA6a
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so661a12.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:55:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794257704; cv=none;
        d=google.com; s=arc-20260327;
        b=cQw6429xNwi8aYksKLn0nw8HrctRJ36f1oiE+g1AK1D9NuHNP4d+xGosRhdZ1XCeCb
         g1IpbQveMRzsqz15q687H3ECFiwktxgW8ORX+YyPeqART8530RB1YCXB1CSj0zkVO8h3
         vREJF7UGogyJbjgfnXihga6pW3kAgKD7/gJPve7164glM4ymqCwVzI1BI4cfAQrQKyhR
         haH/O4OboX9Zk75Z3E1uksanRIR9U9rJuQOjASfF2Lsyx3SUFxl3+loWC93jhKUwmVz8
         mkLknaEjZCVi5ljvLsJJWiMn39HIWQn4WD3RRuEDYZ3NZFBSdXZC+ZVjKC5bgB2/zKNi
         BKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y1VTS0UpwTi7iGDm58nlPTAXVAo5zOfjQYIrVOnYmzI=;
        fh=HZd/TUxqqQlyRXguYiIRz/YeSJAcyYo0DG3ranCLJps=;
        b=UfmJaNxOkfy/T976oBQZER+6b3c2GuLLycHBIXHVYYnmjkDObxHMvTP/4kzBBCewyS
         /1XH9ujamsDUl1qHjLmaTkrroMnSh5CcloND6/+SPxfaEfeP0OcM0Oy+yhiixAH3qKnA
         zU9cdNkaoD94sJqilT92GhELC7YvvPaEzDjoeI4xcQt6AKPs+1xhnDD9QFkLD67yefSa
         316uAAH7OXE8T4Q1CuLTvExqATFoz9DsG8U7nVorBuUnYKbAMDE7LbL21fhZIQT3KBVL
         avjQme99zTB9ASEHWrk2Qiu35G74E5S1rirVfjW6lSGOCSoK0JC8rhz7/B78dpRGe+Mk
         GD/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794257704; x=1794862504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y1VTS0UpwTi7iGDm58nlPTAXVAo5zOfjQYIrVOnYmzI=;
        b=d8MErA6aqpZN3ltM/9izwfImOK3J34lAFY7OkGWDXXtoN/UO0qzBxnyFLxX7uhgIpM
         QfoR55t7G706xABzrnQLgA2MNeFAgLNhoo+vk1ONKfNpVWwT/5ExOy4TgQ7vmUFvEs1b
         irBSL1f6gyOQJCinu6YfH9i9NF2Nfri6O22srAsDlncVyuJjNMwrS4KZ4s1zvt0bo78s
         F+R+fVib7cb+KBpjg4GHPpSWLCkTO2StsloEiLGxYzFwnroLyE2NyiMIYlz8QSLpfB6F
         FHS0yJ+Vj8mRFGt+ATOxkODnspZ4I16AQzE7/jn4ui89AZzqE2qh7+q/HO6JCfYnlkcJ
         raEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257704; x=1794862504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y1VTS0UpwTi7iGDm58nlPTAXVAo5zOfjQYIrVOnYmzI=;
        b=RJGfksKGCmLmsCL5i3UKsYb9CsPDydL7WxxAFfFl9S9yWrBPqq7Svg4HofeyuaID7x
         MshiIGbH5Y9a+lGzqLBnD80sMcv75Sh0OKaWuPkYQ3oZx8Igq/5Q9gXGx5SQMzi1MsLS
         af5TsRSLUNluVQXLQ7ry7RUE9Y8gtLHCdl6rpR0zZxB2eEsN8Fo1C8GfWoe3Q9nu0S7r
         I0M4TYEJNPEUjiBJH8EuHWLi4YKY5sClGjzjuCPsHBRlmF+xGfxGgYUp/6L5oMlXkdCf
         5HHGT43BZw9yc4mugRLas5zP+kl7Jzq9gxYKLVrKA96Mc3mqbxcVqiXhvMzC8pFaMhag
         6wEA==
X-Forwarded-Encrypted: i=1; AL+hErEHvXfFfYfkEg9DUknu4zAbYyv+HNJvA4cfVmgHb9CC2IPzOJ64f2yF7JwmkG+qKRzn1CE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NolTAl/AhwiE/3Q2q16VzT/yORNWHV9ttH3JmS1NwEcgqUNWc
	fb6WXuF3mAmhLWQ6g2bGmswjoKtVaXKiq73ZqyKMMBYngaMw0z9tK0khkpmCUKoKPOjis8SJ6zz
	cZr5sWvJrYlWU6QgVtv4fNrWQI6outB9iJtrwzBwG
X-Gm-Gg: AYBFou1ZokBNqYAtd9cleQBcGoW40kVhOFjnDEwnWpt2OzgwW4PhLDHE1JxDd/JR3A/
	5g5H5wKxtqKE4Vb+pFp/i3JZvl5rrYgo+mAwXRszlbZ3PnjFNFvkaTBMNxu0mOZU24N4avcLBBs
	XHy/nVpljgLifVB+fcFUkM5dBdqllO6QMCtmNZu0g7a5CSCp2LNqd+JhtCPRgF6zFiIvzHd+QMr
	KML/KLnvHq6AH+Ph7Y7iukqVrxQ6zGIE5wIKVaI6LkKyLAPm802ojb+tGSu8OBQXMKmDHAw/rh/
	eVPpAN9prb6jElvwbuS9eTjR9RoyrUDGNGTiZPCtg4ZGsDCNzukSGLi+r7YbigPEk6rxCyYAnL3
	WnNUKiA8Mxu8ApT5TXJbbuzZNYmroIb1/ITao/WNS0FGSJbYCvKTIjPQ6qZHya0Eo9OCTVoGP
X-Received: by 2002:a05:6402:a54d:10b0:6b4:18f4:94a0 with SMTP id
 4fb4d7f45d1cf-6b757764774mr18897a12.1.1794257703560; Mon, 09 Nov 2026
 12:55:03 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-13-zide.chen@intel.com>
In-Reply-To: <20261106013927.166209-13-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Nov 2026 12:54:51 -0800
X-Gm-Features: AclHuK9VL9SJI6W8IBlFA0E771PuPYFu-UHiXMvW4iz27b7sgHB5YrbQONTlYQE
Message-ID: <CALMp9eQRfFV8=e2QbeiV-eFWHYtCqp_wr7=V6jwnqmzo8OzHRg@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] KVM: x86/pmu: Emulate IA32_PERF_GLOBAL_INUSE MSR
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 5:50=E2=80=AFPM Zide Chen <zide.chen@intel.com> wrot=
e:
>
> Intel PerfMon v4 introduces IA32_PERF_GLOBAL_INUSE (0x392) to track
> which counters and the PMI are currently claimed by software agents,
> allowing independent software agents to check counter availability
> without a shared scheduler arbitrating between them.
>
> IA32_PERF_GLOBAL_INUSE is a read-only MSR, and any write attempt
> results in a #GP. The MSR is not part of the VM state, so it does
> not need to be advertised to userspace, nor saved and restored during
> live migration.
>
> Always intercept IA32_PERF_GLOBAL_INUSE to prevent the guest from
> erroneously observing filtered fixed counters as idle.
>
> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
