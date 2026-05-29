Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191138F949
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075914; cv=pass; b=l2FurmWE7dKTzPXKlmDzJ9XURnSJ77aNZ240uYqPcgpL0qZhQe0AdiL4MGuWrBktArOMBRMbuFEWiD0Fpkkdl/FBGHKO7C7tukys1A7Ih2lmKG7vRaljUVxN0DKpw93vEjO1FxzAsqUYfDRh3iCJUjtBiX2URjSMvr1z3pGypww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075914; c=relaxed/simple;
	bh=Z7cy/0MKQJENPuwSBSOm4VNTpLV6AOAfKhRbl+j3Wi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipRCtdBVzEt5yPdse/3fabhaZQS3enwNJsLKnwPfG8/n8EbO8/6VPqmqaGko7Q71lCiEpMaTyaiEgfPLvGHZ1naqVwDy5XGeGEyrnMvv4OPDbb0cwO+iThaQVY43UhpEmW6+L9vSdkXfIvbBz419AKBc4dGUpIccTwZeOkCk+p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1vvRooN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m+I3tp6P; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1vvRooN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m+I3tp6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780075912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDPjSZ0W1ixFetVDM7vbYVUk5f0pY0gAdryhOcsw67I=;
	b=c1vvRooNumX6slPSyH7QVXIQMDFd5NpeZLDzPhg+gYiv/7BjJiqp3wj8uy/+bMZ2J0p/Fi
	DoCfS/oSLT/vimY0q7K2xQoAeVqVOMYf6oEMKjHl94jLtDI2VuoACLWb2RBtrtFpvqODHt
	vBugBd1RiHO++ZXHw+V00QlsnRGIKWQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-oVKd19_aPoapS3mekvHwqA-1; Fri, 29 May 2026 13:31:50 -0400
X-MC-Unique: oVKd19_aPoapS3mekvHwqA-1
X-Mimecast-MFC-AGG-ID: oVKd19_aPoapS3mekvHwqA_1780075909
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4909e29e78fso6049975e9.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 10:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780075909; cv=none;
        d=google.com; s=arc-20240605;
        b=iSnlYf94rK6G6tfgITUhQnd87bXj4NmiliP8cIALNzUTzhWil4QPvrZHDs3jfiy4UY
         fUX7mz/3jkcS/mDzVo8kST5pC28J7mANyk96sdVf0zH1wg3HqlvmsNPmUAOi0urI6Qca
         Jz1hGBLkSSK/Dh9k5cwNuvfdPAsA3vUswLre3NXJGEVsNq6aRbDNX2FM8j1rQVRFm5H1
         GBOXBaQH0gzAfzn23BvUqUz1WcvwQuKu8NCx9drm4GJ7OduzJmNgngXegjrfB5R465uU
         yEILSUJZGBQRlE8sIJk+aJCVcf4MRrzTvbLpWcY27I+jZL/uIEW1Au5TXENRFF4gGnBU
         sYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wDPjSZ0W1ixFetVDM7vbYVUk5f0pY0gAdryhOcsw67I=;
        fh=Gp4+0W4fZBWwTA6dl7m9C1+NjIbPaPiPnZyIFDKwGug=;
        b=G6GFUbUMOS1xVYwEm/ScobKFyxhjrw3zmIYu9BxExruF8kvqzy9Ui3UKyB/w6mK9kO
         mdCjwV/CUil1NKCTR2sdy8oU5KAfp2FYq3TT/lVnaqoxFhxHFu716s1hyGiQ1cglc/Sd
         KfACSoUhgzYObCOOu4bXt3zFEGbxgbFH4A7d1UIR2rwqprHUzG99J5m93232VQkDy75Q
         oP7gbk2Np/sweUOkQXHZhvHcHNGsAaQ+Oxf7qVR+V5NNqcFcZZCwWwOE8zSbbqE3NrXL
         5pE/RAIojDsQ9VjGdydx5lxPwR5bgx+WwlrDXsEzhFhW1f8j8o0yuRF8lgvGg8fuXX8Q
         tWbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780075909; x=1780680709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDPjSZ0W1ixFetVDM7vbYVUk5f0pY0gAdryhOcsw67I=;
        b=m+I3tp6P7POV3VhCOJ4LnNvJFykJSgqtubD5hJep5QO5pJxH19yT7Phdn4JpXzISVN
         2aC6f2tjM4ijgBfPuLsLMbEqlG+FeXyeUGy2wps3ztW58MKhKtjiqPy3jP1+b4nWL/Rb
         lnh+77TQrBpI0hKrtbJoqE7qkEu13lqM/OEfe2xpHCnlhZ1WmMD5kAJPx4w88BP56O8q
         pEmq1t86zuTTgkKSqfsUbVb228YQVdAzJugj8eV8GvR/qhDYkwk9VhmmqjaQsJvGmJXY
         y6sO+5C8mwpZbKIHDtc06JfIAwRCi4ritAlqXFN0trDJmyoCz7LBnwPm8E4mVMUMHBvI
         QQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780075909; x=1780680709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDPjSZ0W1ixFetVDM7vbYVUk5f0pY0gAdryhOcsw67I=;
        b=IlLPm3v8RbvStASSwBuyFVUPDYqQRDUZOHc4euu6ZlYPV7183GyHVc4HSLX9c/Hma3
         P1WHvABjJQwBrc6zWNsOF4HgK5Gb3n+aBksGw78hwVQV9gQQlcGg5a/NgNVJl1Gcg21w
         Aufd6nAcFRjES5uSNleGkjkAdwI8WQJKorAwkaVgYKTGqlQeTsR9No/NNRxQ5tk9RzAf
         A72Kt871hqc2cVeuCiGnOk/lwxQx0UnLkYcqtiCVWgaEbaLstS+T2kbxUKzYaZZcIHYK
         3iuG8YgO8XTJ8AZJBa7/BAERXmqE2JPe/IY9DqR39qPUz+dMMIb2s18RE3r6yw4LjGSR
         uP5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+b9vq/iLOXKDCUC9c2YVCQANZE2n0pVSvxPv3UB/CgagCDw5TQ9bm/XE3lmPzKJkr6COI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXO5Qwzb+waki2pt2TD2oSl62539Ri0bT0vwtwd8u9lexE9mvu
	c7t+eO06tyuAJhR8Ce1eOiEi8KO8rF2g6BoRE6sRh4Vckr0Fpb9D3slKvkq3RGFJg0iPXq7yJxj
	RmtqLxbHgGKIV+55W99xx3mbWJ6GslgTW/4Wm7veGzauzswHVr7etr4Xhs2ECHSGROycgbAAmyc
	OrE/pCI1+ecL+7GeeFJevM/3iqImit
X-Gm-Gg: Acq92OGXK/Y//pvWXtFPLpN7Tr80TOTrPmlA2NO+UXhT96JNehc2CGhwjknEVKgctKe
	K+i5/tCq99UHb62Foik4nv61YZPc6De4BEZ2USB51ibENv2CwCget5sYEifo6Uky1gW3Knt41a8
	YIoec7rIAVxqUbxLYUtDYapT1BAC/hrupDPgVWLBBi1O8iKcRCw//bdYWiwL8dZcJM2nefXHIRQ
	23xV/b8DEce6kvX9jpa68bYQSAcNnJKi6LJ/MiTk4d5QEGjIStemvgWbHkvlMPwD61+e83A03JS
	z/Ejn2L72B7QcIHEGw==
X-Received: by 2002:a05:600c:1989:b0:490:51b9:2309 with SMTP id 5b1f17b1804b1-490a297e1e1mr8600905e9.29.1780075909423;
        Fri, 29 May 2026 10:31:49 -0700 (PDT)
X-Received: by 2002:a05:600c:1989:b0:490:51b9:2309 with SMTP id
 5b1f17b1804b1-490a297e1e1mr8600305e9.29.1780075908958; Fri, 29 May 2026
 10:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529105405.1839362-1-maz@kernel.org>
In-Reply-To: <20260529105405.1839362-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 May 2026 19:31:35 +0200
X-Gm-Features: AVHnY4KaJCOFob7wQLVfZdIu2G30xvMt9_hks8OfF0JM1D0ZM-lUBdSqwLPd7jg
Message-ID: <CABgObfbnG1gPBiZbq9o_W9LRqiYY2XCdLjJne-Ldz0cKbpwqww@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.1, take #4
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Qiang Ma <maqianga@uniontech.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 12:54=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> Paolo,
>
> This is hopefully the last round of fixes for 7.1 on the KVM/arm64
> front.
>
> We have yet another batch of fixes for the newly introduced tracing
> code (memory leaks), a fix for a config symbol misspelled in the
> source code (therefore being permanently disabled), a fix for an
> embarrassing bug in the PMU emulation (write any value as long as it
> is zero), and an SVE sanitisation bug in nested virt resulting in a
> guest being able to access more than it really should.
>
> I've purposely refrained from adding another lot of fixes for more
> benign issues since His Majesty has announced he'd be picky about
> that. Fear not, they'll be in the 7.2 pull request.

I'm afraid I'll already have enough reasons to be shouted at this
week. :)  Pulled, thanks.

Paolo

> Please pull,
>
>         M.
>
> The following changes since commit 1702da76e017ae0fbe1a92b07bc332972c293e=
89:
>
>   KVM: arm64: Fix nVHE/pKVM hyp tracing error on invalid desc (2026-05-20=
 08:08:37 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.1-4
>
> for you to fetch changes up to 83726330748981372bde86ed5411d7b306612991:
>
>   KVM: arm64: Correctly cap ZCR_EL2 provided by a guest hypervisor (2026-=
05-29 10:04:00 +0100)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.1, take #4
>
> - Restore CONFIG_PKVM_DISABLE_STAGE2_ON_PANIC to its former glory by
>   making sure the config symbol is correctly spelled out in the code
>
> - Don't reset the AArch32 view of the PMU counters to zero when the
>   guest is writing to them
>
> - Fix an assorted collection of memory leaks in the newly added tracing
>   code
>
> - Fix the capping of ZCR_EL2 which could be used in an unsanitised way
>   by an L2 guest
>
> ----------------------------------------------------------------
> Mark Brown (1):
>       KVM: arm64: Correctly cap ZCR_EL2 provided by a guest hypervisor
>
> Qiang Ma (1):
>       KVM: arm64: PMU: Preserve AArch32 counter low bits
>
> Vincent Donnefort (4):
>       KVM: arm64: Fix CONFIG_PKVM_DISABLE_STAGE2_ON_PANIC
>       KVM: arm64: Fix meta-page unsharing in pKVM hyp tracing
>       KVM: arm64: Fix rollback in hyp_trace_buffer_share_hyp()
>       KVM: arm64: Fix memory leak in hyp_trace_unload()
>
>  arch/arm64/include/asm/kvm_host.h       |  2 +-
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 16 ++++++++++------
>  arch/arm64/kvm/hyp/nvhe/host.S          |  2 +-
>  arch/arm64/kvm/hyp_trace.c              |  9 ++++++---
>  arch/arm64/kvm/nested.c                 |  5 +++++
>  arch/arm64/kvm/pmu-emul.c               |  4 ++--
>  arch/arm64/kvm/sys_regs.c               | 11 +++--------
>  7 files changed, 28 insertions(+), 21 deletions(-)
>

