Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E72DC791
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107743; cv=pass; b=oSPjUOvFIs1cbKj87M45o+o3mAFmrAvYdhN6D7xJRIT3rXLrMSXWxyGCWwniUE023sEwwMVPDytbZxeo1qEsbufGokdxtd3yvGeX8jcEtOGXONMyEzODTGJLkUVNlO/l3A9VW0DxMK5PDoB23x+RGGEKNbxf0jLWg6by2+XJkMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107743; c=relaxed/simple;
	bh=qnYBvLu3wP+0deufjLD9NX37QLMFMQZ9+Pr7pKVdW5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNU/ySTmXz2WL5amTki/+JEfMbLtqFBEPgoZS6G2n36RyWrtQJ7VlKoylTHuhWdbW21jO10XufcoZP8rj+ZG+qWRaPhFw+zGNgleNhEp5XFa/JOHRBXHR7yfB8gFCP9IzUelZYXzqmIdPCq2DqgzShHZQoeiRhi2oPI29XqwxYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hEBOcK5h; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEBOcK5h"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2588a12.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792107739; cv=none;
        d=google.com; s=arc-20260327;
        b=sAnPbUdardI/001ulfjEfoenKD4qJsmcJXlBM7SO3Z8vnx5sWo9TUZvLJ/xsfsuztF
         TCRsPYF3tYTmEWFSTApbDKGDPvEYLMyLQqNd0J5gLs08bVcNjxNmKlH2cpUluGTvV5mu
         djf9DdAwxG3xAsRw388bIKI4GpR/As19qvXpxzMUwIfsGXyrPknTVxRDXR0/Ealh4QM0
         CKaD6iCpGCZ+f+trpLkLyklLCyfE+O0o/aTMPe76XM3gV9liewBBMNT78LcRmUHapEwV
         t98ds6+c9hlwPStZsA5H78nfAP89yk2XZLd1He7nh19uEqicXpR2oeyj9Bjs/f4Qv/GU
         ABdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qnYBvLu3wP+0deufjLD9NX37QLMFMQZ9+Pr7pKVdW5g=;
        fh=3cEhsvuza6G6O3mEtTNjQHIewMU1n9X0/Oiet1K+G/w=;
        b=VPeM4Nt5CsscoSSYtpeL0+/iuNIkNJWHFx6jX12IyIICkM5M2vt4Yr1ZGTHMEr9whS
         M09q4po1jd+LG2vo2jzxxcvP9cKUNto69TCiNZM1WzmsT+tKXaDEGI/yHyKyDZZ7Ei5s
         RywWuO7ubzgpft0D7inM7eT9EU6awYeGEPoVGFLVRK9T1C+1BmE0WT4IEc7RtQq/NWOE
         fr9rDsXBApKboBvTzEDwY6smS1Uxx0ZhEpk9O8o2jc59GDG1p+pH41Mu46u7AlyR6nx6
         EIu/rjQN2Ib1tloLBzoTEcCllVAlnKAof7rzHs+cjQvWaQ7rXnBiUx/icA69IY73dHgB
         mo7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792107739; x=1792712539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qnYBvLu3wP+0deufjLD9NX37QLMFMQZ9+Pr7pKVdW5g=;
        b=hEBOcK5h+YyuWf6MFgtpAED/I0v0qKG/gwEAVyG8EWe3CIbyqsjyGmqZ78+A4tAAd0
         4cUtYTsnYOme9zkeXo79vdVtnLWcgj7ZXO2uKGsM8e9l+d6uu591vFNkwG5KdW/ys1aa
         DYtLwi2M5X2HLLZGZkWZeqDNMoTRMPI2aah7QdYQbenLtavr64Oyb7sjyGQX8/OW5SUD
         +kbTmCvIF+pymAezP7LBdBFj/KrOAsQ1FxHCv9QiMAKDjJV3xpMiR4gFY+mtrv9wMHtQ
         /0l51XDk4r+SjSEVhJRlE3FALN4zdgov+vkxtOD3R6uCERt/MyjuW/GgCqFIDMTAKJ5s
         qFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107739; x=1792712539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qnYBvLu3wP+0deufjLD9NX37QLMFMQZ9+Pr7pKVdW5g=;
        b=F2hX2j1Y+iFwQGEELpzBXYUM7f5sMdwNXKjQocaEnRCWaXp1D7Svsuqi8jYstO60y5
         HiREq1kAOpB+4SiHe9GjZmaBLNXy3pkrRkK4i23h4AZb5k6mxC4DkIvEUkG7KVxN/Xwx
         RkVst+78ol1p8Ezbf/ENKIqMMpRD5lww1WKWHS2FF9ysHBGeOu/X314McUQKAnnvrIOn
         9oEYkubd5wwdWtBlIiXm8P6Kji7X1FW7HU2sHi82O8Lv1aRLCobf2RY5HjSANWfyQB8s
         DoHRPOJQz41+s7wFb84Klv3ierZpxFfuRJ2/Z6gMTI4fgOzR8gg35BfCmHV+NCj9XuJj
         GPGw==
X-Forwarded-Encrypted: i=1; AKwUvBzepcKZNR+cgsigw4Z1j8ABLHrdWQQSI0e6KfjIolZ9s+jUR1ZJXDXm9GgIbez10Nozt/g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN4aKztd2sWOXehTzvrR5WXqVCqldx2dXabLAa/wzxpTwvzDym
	lpNoi9RjUQ4QCMScOCXcxQ6GTf0DGsxGRuj4fm8rHUQdMHCxqq/NJbjkSELqSEuwdRI5Q7S05f8
	cfMZJ/xE8XOFmLF2NrgZz6HotJjVHMWJP+oLrRQTP
X-Gm-Gg: AYBFou1WUuaK4Qm9k46ReQt/dUg8zXBppJ5VmmlTOu2BMzv7I9mAwyCo5kxcbTJSn1v
	hK2hjqZgSepYl/Z7kdiaA2f4JmGSSuGhauqPFd5+/PdVdBQS8r1oZeVFWMFNRDGy9KrSiUEQDkf
	EEXR9qHJEeiGJ2v0yKldfJ+v1xWYzlzAhC+WutKj8dSkAYw1RIx6hqbGAm5rg3+qWwHMlmOgbnr
	NfUPS8oR6eIv3aN52yBYrX7oqS0jW8i+dF7ZZu6558DVOYrbtDRA+PlvCLnB1204+q/r45YV1A3
	1CUc0guUVnK9a+WwOZGxCdHbo7DQ52hRgNgHSi9jitLP9dRW1QU9ILRRR2kBUJS9Qi6sOekFwxU
	2n2GjUfrjHlav0SKnxmxNxiesIGKKGMmxjV53
X-Received: by 2002:aa7:c2c3:0:b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b38c1d2c27mr13029a12.10.1792107738186; Thu, 15 Oct 2026
 16:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-26-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-26-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 16:42:05 -0700
X-Gm-Features: AclHuK8zmX5F0uZUL3_9yaYG8YILbTZauumuUb9eWsw9lpIUhMqrbcaBGQMe4t8
Message-ID: <CALMp9eQB_9UQ_qy8RNQUc16XhznasacBZxKQ-VNRrMOmyva49w@mail.gmail.com>
Subject: Re: [PATCH v3 25/27] KVM: nSVM: Flush the ASID on nested transitions
 if shared by L1 and L2
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> If L1 and L2 use the same ASID in hardware, always flush it on nested
> transitions to avoid using L1 TLB entries for L2 or vice versa, since
> from L1's perspective they are two different TLB domains.
>
> This is currently always the case, but KVM will start using separate
> ASIDs for L1 and L2 in most cases soon.
>
> Note that KVM_REQ_TLB_FLUSH_CURRENT is required here, not
> KVM_REQ_TLB_FLUSH_GUEST (used for L1 TLB flush requests). This is
> because KVM could be switching between different NPT roots on the same
> ASID. While this generally requires an ASID flush in the VMCB, which is
> done by both KVM_REQ_TLB_FLUSH_CURRENT and KVM_REQ_TLB_FLUSH_GUEST, it
> also requires a hypercall to specifically flush NPT mappings when
> running on Hyper-V, which is only done with KVM_REQ_TLB_FLUSH_CURRENT
> (as KVM_REQ_TLB_FLUSH_GUEST is only meant to flush translations created
> by the guest).
>
> Note that this is currently a noop as KVM requests
> KVM_REQ_TLB_FLUSH_CURRENT unconditionally on nested transitions, but
> this will soon be removed in favor of conditional flushes.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
