Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352AC3655D1
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792101925; cv=pass; b=oNm2X52R/a8KKoDs3Ur/5P5ykYYbwWNZFZqI2zsQHhU5gpqHxSalh+Rsvv8ZvJO/xFU1L8UdcaefzvF6G4Dldc/GS+DtOK56jhl3bv5LAX1wy4D+7G3FkfXeaJohfoKumLMPoNJ/dvIg3q5g46by+sjmgZ6Z7VBZSz+oeFFQrDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792101925; c=relaxed/simple;
	bh=yMcZrh624HxVdcx0+mbpO4kZXBb94MKHsaPeyPDSENw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/hVrBneAOSckgUMphOCYnDgDeDwpt1aIFkdPv7Pzh8nCqmTccGWcIahdgVOGTWkBeTHocuCn56QUP9pFXKW3jwP3fC7tvEAjgoyWA9j64kryEiIITGLYJXXQPT3xkg7oktXXrd4L7E6/P0XQHpfyJ6gb9SHw/wkwZMER7mOrOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnWzXkGA; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnWzXkGA"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so4220a12.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792101922; cv=none;
        d=google.com; s=arc-20260327;
        b=Sn/qj7Ro+eQUcwHWGvRon9uU0BPkSENHUMtDHlfv9wssGntW64L2WVyqQkaJS9FY8s
         ifpdjLafIJXI3aXlRa+KFxI8SJOnE5m1cLa2psJ+3BUucfZ2Bkt2lGwdKZ/TSjIespp3
         WtsVCJLqi9QzUASH7mNsRv/4dnv68OxmtzN/TiqJXsy30EUTUMHX0Fi350wHVcIWWaXA
         8ZG/yqyke2CJvWg9n/nELdgc7GzRwzNxyp+OcfVHqnvm4XgmUmxXh10sGabHm962bwCa
         TQA9C1nO6KpCTAuskgJq4Bok7mvVSyZiajjcxv0aNRAhj2NocXogwKdJcm5aFwJ3F6Et
         qOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yMcZrh624HxVdcx0+mbpO4kZXBb94MKHsaPeyPDSENw=;
        fh=ySgDyBc/PujvYUbsFgr56SuL7x7ID2I/fU1xml37ohQ=;
        b=AXiWoMppwUfT+6loee7YbYZRs6KknwFwvJEPOGwLzlb7ZKtZNWWt+4J3z7DnXHSszK
         yCMKdwIVcqJmVpvLmIexFU6b4QHOgFnVBZ7kT6HLl39n0SI9iRkTLiNID64I7j+Ylpnf
         A3G49UINgpm+4j+sahEfOqIerVkD6yS0U+Dkm0ibUlOhCzCapEPU8bdCFaUGfAY+LQBC
         w984HomH1Ue94wgl12oyVWUqfkTrt5CyQndDg3LRmqMuL4Ziye66N0X9ZZCOzN7DD+Ly
         i4wQwv9uEu9gUhwmPUyon4RAac2SwAgFfEGjedip2C+ANcNPtZ+6JMiZCZo5SsfZaYyC
         vUHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792101922; x=1792706722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yMcZrh624HxVdcx0+mbpO4kZXBb94MKHsaPeyPDSENw=;
        b=SnWzXkGARnOGv12rVr12vkIxseRkR9wKB8p6IuBBsrL4qvKH6vGg4vnLHPrBQySYSQ
         agVgt+EuGiXegzWaWSYiLwwq534MQtkdsf6Mb/c2DYedquWKCitxGZ1TfRQri5gwzFV7
         wzwsWFp2Pf/bbyzuYd3S3VdxL2jr1sk4Leh0pcq/sUVBHzJ5JrnMOJhQhMqgU8ckyn4H
         lEHRY1PapSTxnIAIEj/wgvFEx//z0H2/VHi8v/9VGbISLL3KXmePjSo//CnIK4APQP/n
         QppeHDE3F+z1MjGl4L/UvoKbqnL5Mmm63D8CB6sLw3HrG8sPrfdvpc9+KCNjaIiSJyGA
         qzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792101922; x=1792706722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yMcZrh624HxVdcx0+mbpO4kZXBb94MKHsaPeyPDSENw=;
        b=juXRvwINXKDa+A9ssL2Xtfh12rLahh1XorUDsHmjlXp6h5tVl3yEosaLsycIPbKyLu
         CUfvxmxJGV84UmAnKIhPcMfZ/DLjsCN2ji4Madux3sE8Y81vSlMv3zf/SLcBh06H0UcS
         14xd4wjgF5X5pJwo55lZ0V68EPbaMgJbP0MFW63g0FM/kl0o5y+G7wViBRnb/rymvLM/
         w3qB16hS+utgqrGYRQzYzg3l+inCJ7oo+9MGi5hAs/Xe0icK5DudnmcAU29Ykm0ewSEB
         Um470C175paEyPE2C3EtxXSravHqzWUYthrVS8Sy6cmO9FSa/nn8MglkZgdNkl8Z8Mx1
         UtNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaCWI7xhOXC80fv6/Q3B5NuRN9auwbGyYpNwS/wRpfIGlV5/NlaHRXhu8DJXQI2S4xddM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvljKb/keNetmL0e1AxKfkv0xXzcwfXw3k6MeOHfUVPUIYTCKQ
	FkTa8PDpQd75TgaXWeG31VnoLISkBtt/nOGBD3TUWRdbtl0fPdKnixG5IxMkQt0iOEUzzh9Lru8
	pszPPo3F/ALv68RQaTUqUbbjeOBVGw0pqQrsLAI8I
X-Gm-Gg: AYBFou3sdzTOA97BzHaXkShlXZYoCkNrzIHRDF1T7BRkH3PfVqEA9432YKLAxLF0XlC
	zI7XSjHg870IrvsjtcENRJb2X+aOgnYm3/R8DpQGqMD87c4F2dya4iTNPtxDdbhZlMctNG+2AfC
	lDEqt/jLPcaf0P4l5Ct1UkTCp4z/HIyZ3sA/lznlD62wu9sBS3PxVXaP0Mw5Gy22wLJIL2M79yy
	ZKxORBuPA8SW11k2qZTkl6u/2RNf5IGlJqABceBv2tFLWwkJ8eyH+crdVwlKYv8zG492ww+yioY
	V85sLB3cciUhHNh/R2fFKbjIfz8rj1S7JegLGKQ9Eg/01FptXmGwocY=
X-Received: by 2002:aa7:c2c3:0:b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b38c1d2c27mr8512a12.10.1792101921872; Thu, 15 Oct 2026
 15:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-17-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-17-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 15:05:09 -0700
X-Gm-Features: AclHuK-L1bJQOeiBybz_HSG7H8fNC-dGTKSw_e8PKvf95DAN0dcFDflyFkrefZ0
Message-ID: <CALMp9eQGyPC8oU_cKjYeJkUhrhvxZR1NASD22bauOb4xhBDgyw@mail.gmail.com>
Subject: Re: [PATCH v3 16/27] KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Flush both L1 and L2 ASIDs in svm_flush_tlb_all() to appropriately
> handle KVM_REQ_TLB_FLUSH by flushing all TLB entries in all contexts
> (e.g. for kvm_flush_remote_tlbs()). Since both L1 and L2 currently share
> an ASID, this is effectively a noop, but it won't be once L2 has a
> separate ASID.
>
> Purge all Hyper-V TLB FIFOs (for both L1 and L2), since both ASIDs are
> flushed, and an ASID flush is a superset of Hyper-V's fine-grained
> flushing (see comment in svm_flush_tlb_asid()).
>
> Note that if one TLB flush FIFO is purged (e.g. as a result of
> KVM_REQ_TLB_FLUSH_CURRENT), it will consume KVM_REQ_HV_TLB_FLUSH, and a
> subsequent KVM_REQ_TLB_FLUSH will not flush the other FIFO. This is
> alright as flushing both FIFOs is a (newly introduced) optimization
> anyway. The other FIFO will be checked after a nested transition, as
> KVM_REQ_HV_TLB_FLUSH is always set on nested transitions.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
