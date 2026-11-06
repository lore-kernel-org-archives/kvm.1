Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793999959;
	b=NuOqsoR7HHl2w7L9BkD+jq6LK/jA9LHHzOJpslbjeS924WeYes1Rtj9K0+NWZjeZ1amP
	 b0ajA0pxqchx0xiatVtom9vp8SrRYLwal+k3dMmQxHdvppbNBRllT3xoDX0p/9MrsVgzU
	 VFyb6bnrXs/dnb4KVYs0fu4Z/CHvlDuHJT6Hbq5N/bSAKUvvdGXJISQmSCENzf46rwF9A
	 Z2qVUYP3GEPPC4mNUcTXPoBTMAGY+N/UfTzuHQcmsZjUpgAorUjeJ4F4Eh3QFZ72V443I
	 a9bIfnnDB21EIzkBcHjDikgvIBDohQy9lsUuL/GM274MDKhvBL4gqLJ9Ryo0tVLpUGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cjYHmUqxGl1gIMoX463n6uK9Cl8H9jhL6J91Ez5YTbo=;
	b=G0C6/VTazYRDa15wQQZkezGFI1OBSkfZ/0HEKrRWcQVPZkOtOhtDQ4YT0sOGUNQW4fz3
	 A2XJxWlPwyUYQUurKRRkIRi5hSOvj3kxJb9TV0h2sm7NLcVZcEw66q4cWouPMlCuuCM0Z
	 XqEMX0ZSs7Sc6XCwx8WByxbuglw59knFXYE9a3EBbentkufH9QmUp8ZQsu2d8xi9uwlTY
	 Lv+VsUaarmcJNknQz6jw5GbwYSucpSfP0yieDH8EzDbIev8qgR+xFDSClyjELbS9I+ryJ
	 vlVGSWEde9kleyCI3j7PefVC8pDYdz86Ks6VTzGqPgXca1wSAPyATqSZR8KpieSdjVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="nGu/a0P2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2BF606A32D
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 21:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C2BF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nGu/a0P2
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso1813a12.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 13:19:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793999957; cv=none;
        d=google.com; s=arc-20260327;
        b=DGYuGXvoRD+Fgod6/cVoiNMEWeJ+/qyEg5c3iIZ2k9VjyNqB/NOJvjP5rWAWjNXiHQ
         fLcUeRXtFmvHICQ7aD/Ns5lrNx1GGKyjmBUKxMOz+gKqmkeHo9IonxpAf1gnoM/Xnnbk
         8VwNPIXkxzm9UbDePSnv1oxSDp7B/ZcPzXTOtjY3lNxcCspTT8i9tE+Lt/NVIrziODjm
         Tk4rnDrqA89qb0rdRZeOTjTzeMcyoFmu+xUBK5wfXjT55OaGcsA9IyIdfUpWislK8xXN
         yWsvi7rOfwmkDRZKNl6RNM22kCZ1BM2J/vmguT8PiG3SzYwU1V29Xj7l8G+D0Ebq8Z7g
         8lUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cjYHmUqxGl1gIMoX463n6uK9Cl8H9jhL6J91Ez5YTbo=;
        fh=9asQYKMJ717xKuUw3pRQP4R96pQ2kS5ehLluLd6nx6k=;
        b=Rq4Pj3HUcvSnYlmzVZDWIC87lOLjv/p/Dv8EL6HDywjxm6i/5ah7+gkJ2xCvw8nvHV
         CtnXQVbSuA73QcGVVDK61RJ3YclpwvFZXgy3aMDfOxX+EZpYiwqO/KmCl3yrjTwROLRt
         a282jOq1WICm+MMJ+UET1aMvlxmqKp7ZbqjzGa9ZEG/gRKcpF+Gc24QAv/t/2nDZkvL9
         0b4ZgDHcyyP1xKaGld5KIr+dYoa4vO0kXVqFe/YBwgDk5J/ywn9OZxbx1VWVl+0kyYzc
         2hpoS3/iBk47myeW2eRXwLnFmp2NfSeaSQlz19G3b75XH0NP37ZeotI/xMeTTYfKtPFQ
         YFhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793999957; x=1794604757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cjYHmUqxGl1gIMoX463n6uK9Cl8H9jhL6J91Ez5YTbo=;
        b=nGu/a0P2ZPgTxXDLZqgXVDqVkDHlObPQh7ris5tCGNoEEX3e0MOY2/D7uMy9A5v+OA
         LOoo8QnY7GM64gQncZaTjeEP1tzLXHJpKpUtbCpamwpmM7ARo/RfpslN9HqzFhOD5sqh
         nPorodsw2iI39/hQVCRUscVspUllnJm+uczjRcozaStSrj756CQ9rtdXIWVvDTb8qvhl
         Kc9kAIMoYm/YY5/Nhdn6bF5aP3mZfF/Q6mxPEggYntwk4qR/E41H2G8IaGtavjalJH8o
         FnCIOv6PKjN/LbY5aUY2iLDcfnJ/fCw55ttvQmmoFxqmE2s5esxzlsl8cbtjZz+KjIY4
         BPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793999957; x=1794604757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjYHmUqxGl1gIMoX463n6uK9Cl8H9jhL6J91Ez5YTbo=;
        b=nHiaTEicsPdNjJGU1c3Ob2Ch3l/WzlDgtvF5DVEkpGLZeFC29BvlzaqN2X2VT4tcNy
         dL6H8B6m4FBsaDC+cUQva7SEvaDRWTdHoBjUW6mDBCNu05ndOMJtDOoyjYMHOew+cL5a
         GwPveshym8uHlNSYF6ZasOkknBLvCF5+BOc0pAU8FZ/vHvpqUKECI3F0+x5l/5zN7coY
         60LTXKaRCtvlRrMlYMn0IIXUz6QATwlIiu4XUNEJGJrEvy1GAYY/oxzlFtWNkSNQJmyR
         q4oohaQubr6wm6xneCpxnMvw36ECfibSCNhFc499LzJtIBBWR3tzfimTl+6fwXDq/cJj
         2T2w==
X-Forwarded-Encrypted: i=1; AL+hErG+3PCZAaj1VN88EmxK52clwrkkSKHQqwAoNpVnKe4Yxu1ixoHeId9PfcDFustOh1pVM/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PJsBXVagTN0wH/QIX51OVgUBJ772OuqIiji3N/AtA/+lcfuvG
	kKEahT6o+23Ri7aayTyK2d2Q+13f1KMT6EkMuCbz3LdEd58tWh/G5bS8bnPjw1JJKykhIHNMnk/
	Eau1IG6laj+jQ63JBbq72ou1Rkkkm4r1QM61kFQpO
X-Gm-Gg: AYBFou1JNceycA8K2/xNlqSieCn6dA6DeSFltau1GxJHHLuJb9m57Ki6Wm2GKbsPGwE
	CdL37suSL9HN3kk7fcLAv7ziiruZVCtMoWoi4PdXSQ/fu17kP33ECED5paXH9jTYX2PdjYIAI4C
	Lplzm8hTrFEQ3DiLT61pCg7WpZVgu4OBoQm5GQ8ksftz1sMI5VyECyFtYbbelSgZJ82rgfrL9SO
	JcfW+u1e5iNYVs9lqfxFHVd8AUGc3P0ER6aK4of8ap3CJcOP3Vny7ymX/xAyyRtJ41yWkzJ8KJx
	GO9rBvY2Vvbdd3O+VFKHNiG8fL+tgaLsW/+4QodL9tSK8jJbqWuhKrFfeINNTo3vIyQGzyhDnkS
	6BM2fR8xmHOeAIY9sK0uY9m8p4GUk/VoQU7umC8gP0T5wTIqkFLVyRHefnby3G3u7mwy8m5YS
X-Received: by 2002:a05:6402:23d0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b6f845ff3cmr21307a12.15.1793999956326; Fri, 06 Nov 2026
 13:19:16 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-16-zide.chen@intel.com>
In-Reply-To: <20261106013927.166209-16-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 6 Nov 2026 13:19:04 -0800
X-Gm-Features: AclHuK97vQGFWhElUQz9Hvlo0UtCkuHVJtTKpojbcuYIAmqir0YZFds3plYc-IQ
Message-ID: <CALMp9eSC61v=xo8V_zm6AJjFUxyV-EphhwQxm80WjwNvWR7Xtg@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] KVM: x86/pmu: Mask only OS/USR bits when
 filtering fixed counters
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
> In preparation for supporting AnyThread deprecation and Fixed Counter 3,
> mask only INTEL_FIXED_0_KERNEL and INTEL_FIXED_0_USER when updating
> fixed_ctr_ctrl_hw in kvm_mediated_pmu_refresh_event_filter().
>
> Masking the full 0xf nibble would cause two issues:
>
> 1. AnyThread for Fixed Counters 0-2: When a counter is allowed, copying
>    the full nibble from guest-visible pmu->fixed_ctr_ctrl back into
>    hardware-visible pmu->fixed_ctr_ctrl_hw would resurrect AnyThread in
>    hardware, defeating SMT cross-VM isolation.
>
> 2. Metrics Clear for Fixed Counter 3: If an event filter denies Fixed
>    Counter 3, clearing 0xf inadvertently strips METRICS_CLEAR_EN from
>    hardware. If the guest sets METRICS_CLEAR_EN and executes native RDPMC=
,
>    metrics will remain un-cleared, returning stale data.
>
> This gates hardware counting without clobbering other control bits,
> matching general-purpose counter filtering which only masks the event
> ENABLE bit.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
