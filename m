Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891433E34B
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248307; cv=pass; b=a+IT8LQeSiNtslsALWemDcgocW941srNNX6jj3H1b7twuuuJpsK6anPtOAjNzgJfxZG99YwhylcEes2wACtsbtz0cnEC+fK/Am/xUnNVRq48PZtxhie4MDJaAa+AS3DhgOAb0E0cTCjEA/43a7cnAdlUV798QL6quM/6auuVp3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248307; c=relaxed/simple;
	bh=yB8eckpxqLTfm0m7JZgR9uwgsENotliNu4GC0dI5J24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDCKQYT0eX3o09zNtNnvj3F5F1iy0dZgkMle/IQcFmDvKnGJAzhWijkzTUftx2axmUcKz8GOEJdl8dGhUr809SoyZuaqhiOPp1C+ZdfPiq3toAZYCCSrKKCDpQ4FUQiSjtAkj2YXCXnUwtHNW43eva/TyRsh+eJYzG5aPLhJOEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyuiNT2f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aN1STQGp; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyuiNT2f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aN1STQGp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773248304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ve22NUc/82DrGKVPMAAR5+gY8/ChLtz+87jud+TMA=;
	b=RyuiNT2frQYrJE+av9MsxOoDEqpQzOkXEO8juWRcKNrC4r9xHLUTZH+uFOdeiB5Vc9pFe6
	3QOrvOfQjhh2TGl33um/nLRpcpwA3hlrgq0jSOkzLjkO4g1gfYbesPN9Zl3x8Yb7SEhDkQ
	kECtmQGDlKTcSSIuBmZmwPsR861AFbQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Ea_cgARFMc63yAdQFidFMA-1; Wed, 11 Mar 2026 12:58:22 -0400
X-MC-Unique: Ea_cgARFMc63yAdQFidFMA-1
X-Mimecast-MFC-AGG-ID: Ea_cgARFMc63yAdQFidFMA_1773248301
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48534941525so536505e9.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 09:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248301; cv=none;
        d=google.com; s=arc-20240605;
        b=kOUUn/oHFeO7LpTtOFWjux6Qooq1mtG3/J+KF3Jpe6LeNZM4O0HuyVjYIxoSaX+tMx
         ydTzgHhCUBz0PkVCtmzYAEA8DXyjSpTTL1S3lAwsPe0pNmFpYF3e76fzGC6qXJYVud3s
         CN3CCmwo//LQO/AxZrsmxo245RYem7XQBX6zRjE6JvMRt0w7q9lLi1dxLO5yB7fQdDL8
         MmuSEjlFynOQ7oNmckQP1AAhcgSCuZ0cTLAJ37OAOpdUhhGVfDiqMa3h5We7IZRN8w7X
         zrCa28exlcrp90In/i5ciOH3zwVUIogDfshpSV6PtF0kCH4njy0NzjIxryxCHdCiNUC9
         PVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H+ve22NUc/82DrGKVPMAAR5+gY8/ChLtz+87jud+TMA=;
        fh=SQeFpQqdAd1qp+cXexooj3T/hGsmMbAKPugC10D3RR8=;
        b=W96UnlK/OT12RAg+5qvnfgXsQTiGNRiv/UAsSdrXQN652iayF8QMr4wNK9wotT3uxi
         HixqsC7jBksyzPFIBhsIvgQFKIK2VWOZbA7B5E5j3kUk6fwOZNLkhIiCOYPMkL6Fxpkr
         wHKbv5pgYM/9do3cq9ZuMwViNSzDb0/kMqbRxo/AbDHGP6xwlTSfAAU7zIhARgtVRbht
         B7DQpOyLNz0rUXNq0H07+riSmT+O7wfwinxmn0EBMw9uQAYY9CNJdPXb5ltpH56unI9H
         ZXIM3xFuuXMXnCB0s0be6HVo9Yzgsc15Mrm/Ar1AVJbYkcf0FBIvzNUDmOgwin7HBfKF
         NZ+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773248301; x=1773853101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+ve22NUc/82DrGKVPMAAR5+gY8/ChLtz+87jud+TMA=;
        b=aN1STQGpBrR643l5iXBzgmFHM2i+WZy0PdJcaru0lFmjNmAF56GOFM2+h9vF4H3vgX
         kREpAlC335NTtdMyiipUwFw8rp4SoKC9ZqV39HSvyKepFYxW3IqWtexfYzz9B7Er9VWc
         Ohsikq3SII2KQlH0s0RzyQUW1HmpzpnZ+L+aRfg7kxrGMgN9/vhAzKV6DU/QI3eK5qz0
         eHDGwM/N4h5kxqXpdl9zvUligrdyjx++XmmyNNaHPaulAuQj2t2yoQEUNOuTnSlg7Fau
         z2LEQY7U4Ry52E0pfzbnlXmRmDILl88J7/ELUwgiJdJ/N2NtST0zh6PvusWjTU2wz6YM
         jSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248301; x=1773853101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+ve22NUc/82DrGKVPMAAR5+gY8/ChLtz+87jud+TMA=;
        b=BPEy5pBtE+ZhdA4EyoNhktLi9KrDhb2Uhi3Fwc42+AtNG8G0SCjSD4wnPmdLg9XLmC
         SU3WxV+S6IbFlXfLWg2Y2vWWIm1jJsyevsMc3p97vIPRuz+MJpUZm8LjnbPfL1yn6Xz0
         pxIKqpK9SFrm1WDyF6TThNLIlIN5NeKgwoNefOXYEifjYdqJyWqzKQfpomT8kKVrWO5v
         Q4Tq62ZVLzTzKfXcpTYWTQPfDtSiZ7dfz906HusUP7k/pCbq3TNE9TFXvrZp/hEgZIQQ
         9d0PBbl0PmQ2rQ5sTVhz5S1ln7sHs3YdNBeG7Fed3yd6Pe6dknrtxzWjePCiNaF4jW+B
         0VVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFYfzLQ0JLl8jfCONmLKcuv/VXar2Ny9ZVwMvDWe5VhWI+ITlhpDa+Gp3nPTqryDWtnSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH5oAI46uTN1EqBOGel7JbobO75z6Pd0zbNb4oi1qpvtCZnlyd
	UMk38rnkfG4zyeM0d2e+JiM7Ktk2voYvPZy98ZgG3S8cW9BnEMTmwx/wRGTYbcAgmHwiTl9LsRD
	ww0bkzp9H2OtcAFY96ymcgoWUStw+bLI4yr+JKDPq4NovpJtkFZSCSeDvDOuQMrjpG9uLzsJRnl
	Gr3LJnIrh9icqX36H/nFxIjiDFFVMd
X-Gm-Gg: ATEYQzxXaY8CZVJTAj485qBUR4Oaex6Igouctkiqm23R7Urg3RvecKQniMAoBYE/PEC
	aAJxNItS0meFZ/YzcGVMYufci4PxY0x1yhguG5v0srSmy33IxG6I8J5Ow2EkXIxxEYIwqqv2+0r
	1ilrwEUcmKZcYS9JZbr9wZvsth6pDrs9Q+EiyjSqACrwqdtWjtnM0N4V8kB2Y7XbOzrRU3UQbe5
	6rFHBi9LV1hPwTK/K7h6GgjP8aoYeteB7KMuTeoNVhIsFUe71AY0+qG6RiBQJocJRSZIqzQS3rf
	I7PtKsw=
X-Received: by 2002:a05:600c:6090:b0:485:4278:24fb with SMTP id 5b1f17b1804b1-4854b13c02emr57397975e9.32.1773248301271;
        Wed, 11 Mar 2026 09:58:21 -0700 (PDT)
X-Received: by 2002:a05:600c:6090:b0:485:4278:24fb with SMTP id
 5b1f17b1804b1-4854b13c02emr57397665e9.32.1773248300826; Wed, 11 Mar 2026
 09:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306112231.3201502-1-maz@kernel.org>
In-Reply-To: <20260306112231.3201502-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2026 17:58:08 +0100
X-Gm-Features: AaiRm51PO38kqfZhsYIxd7YNAH5su9wzPy7usJFrA0GOUWAfWq8bIhgO0jdmos0
Message-ID: <CABgObfYJqhj3xiM4_+7gCE1x5v5JQhyS0ox4+obrsZwA2W4GYg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.0, take #2
To: Marc Zyngier <maz@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Quentin Perret <qperret@google.com>, 
	Yuan Yao <yaoyuan@linux.alibaba.com>, Zenghui Yu <zenghui.yu@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 12:23=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Paolo,
>
> Here's the second set of fixes for 7.0. The only interesting fix is
> one affecting pKVM and preventing the host from making forward
> progress when a memblock is not page-aligned.
>
> The rest is a bunch of low-severity fixes affecting the page-table
> code, some of which Fuad has promised to start cleaning up!
>
> Please pull,

Pulled, thanks.

Paolo

>
>         M.
>
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a08048=
08:
>
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.0-2
>
> for you to fetch changes up to 3599c714c08c324f0fcfa392bfb857c92c575400:
>
>   KVM: arm64: Remove the redundant ISB in __kvm_at_s1e2() (2026-03-06 10:=
42:21 +0000)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.0, take #2
>
> - Fix a couple of low-severity bugs in our S2 fault handling path,
>   affecting the recently introduced LS64 handling and the even more
>   esoteric handling of hwpoison in a nested context
>
> - Address yet another syzkaller finding in the vgic initialisation,
>   were we would end-up destroying an uninitialised vgic, with nasty
>   consequences
>
> - Address an annoying case of pKVM failing to boot when some of the
>   memblock regions that the host is faulting in are not page-aligned
>
> - Inject some sanity in the NV stage-2 walker by checking the limits
>   against the advertised PA size, and correctly report the resulting
>   faults
>
> - Drop an unnecessary ISB when emulating an EL2 S1 address translation
>
> ----------------------------------------------------------------
> Fuad Tabba (2):
>       KVM: arm64: Fix page leak in user_mem_abort() on atomic fault
>       KVM: arm64: Fix vma_shift staleness on nested hwpoison path
>
> Marc Zyngier (2):
>       KVM: arm64: Eagerly init vgic dist/redist on vgic creation
>       KVM: arm64: pkvm: Fallback to level-3 mapping on host stage-2 fault
>
> Zenghui Yu (Huawei) (4):
>       KVM: arm64: nv: Check S2 limits based on implemented PA size
>       KVM: arm64: nv: Report addrsz fault at level 0 with a bad VTTBR.BAD=
DR
>       KVM: arm64: nv: Inject a SEA if failed to read the descriptor
>       KVM: arm64: Remove the redundant ISB in __kvm_at_s1e2()
>
>  arch/arm64/kvm/at.c                   |  2 --
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c |  2 +-
>  arch/arm64/kvm/mmu.c                  | 14 +++++++++-----
>  arch/arm64/kvm/nested.c               | 27 ++++++++++++++++-----------
>  arch/arm64/kvm/vgic/vgic-init.c       | 32 ++++++++++++++++-------------=
---
>  5 files changed, 42 insertions(+), 35 deletions(-)
>

