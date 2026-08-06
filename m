Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A3C39CCE2
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024116; cv=pass; b=mfChcI/Ezd83D7vEdSgZKo+daQWrRkYdmDmIqLmiECP5j6eoPxtfsvvX38XuRCzCbWHIQG+uRw76SmVsBK9I6cj91L1jUXpr3e6fKWtgysJVU96Yw4e3MI4Icyc3ejkuDX0NPkoYtpwOtkPZw+QKS/YGsVUibxUF9UHSddhuhI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024116; c=relaxed/simple;
	bh=6gtl7710ZFeRPvJ4cGlV0w1ug+lUsGrDAXKe3A0xqm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3UJQYuJBzuHSlv7+4+tqz8nEuOEvKZbeMpEpx1wQyihYO9eag6icEp/VvFRYuS0DLJnJsH11T/TSXiNGBOR7YwA2zV/Q/To5S1z6wAMkuaiGbTZA1ty0Gtwb16MQDr6xAs3f6ycjssSBlR9MY8KqYfflbNMv67pIeLCYXRmT04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ippVKS/B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mPnDQHHR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ippVKS/B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mPnDQHHR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786024109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8Y0ExwL5RJmYW1fILSeng5LBvxhpRt1TCM0nL/CNRQ=;
	b=ippVKS/BOqgUjrRT4ef8HZ7MN0xWkCwxyTd6FFVjSpCHH4deWeXgVmQcLOaF1j59t8xSFP
	ZemNJE11I9IfIyjS6Kp81LrZ7axYbyA1Nx3Sb9PyZ/Y3wwpBkNeBZBtoaPIVS/jjJqR4dL
	Pc+3M7KnOARacl9XVb0up6PCf1vUJV0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-_MTbReW1MlSqGJU5D3w_IQ-1; Thu, 06 Aug 2026 09:48:22 -0400
X-MC-Unique: _MTbReW1MlSqGJU5D3w_IQ-1
X-Mimecast-MFC-AGG-ID: _MTbReW1MlSqGJU5D3w_IQ_1786024101
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-475e540a0ffso1383471f8f.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 06:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786024101; cv=none;
        d=google.com; s=arc-20260327;
        b=UNKRsJ6/JEq31yibHxKUAifR95uvdXddxNtCWnn/Y1Gj+T70kG9pdB1H8sdJQGly1/
         wkKS4Yg1iS6eLmiB3lZUHdTU16+bLbHNflrJrPhmB7YDMCxZ4tF3DINBnOlpzZOHzQTY
         nL80K6kJWdtTsMGZKigrXTiLbuNpiBL7AQv8t2AAylvVbBXzkc2zFzQl4azRF48h4g97
         OzPU9JlwrFoQ+eDKxexevMRe+4ch8rm08a/iwwiyU9HBqkLsyrrl4bFp8C9xCTiIr2hm
         a12lKOUVBeTnUJcjWm+wrfBeNnGocKFecV/LF57W8l5PckxHRQMC74d6oX6QCPP+KL9+
         1/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v8Y0ExwL5RJmYW1fILSeng5LBvxhpRt1TCM0nL/CNRQ=;
        fh=5Lw/HGKJ+8zJXISiApHzH9cgJ56F3WHZbEDIJ+izNqs=;
        b=WF+QytHOdwx2yJdY9wl2fk69K1hrg/wI37ofDdQlyoMfBbL9rwJ8G+t6e898FGXsUZ
         BhcQhvg9e3j9QToLzNo0GSIqaWK+QE2nFRatJSTPqo0e+FkKNvheSxDfYybI4kym3HjU
         UuNZjvjtn8oZRVtH5wfoYw5XouktfwjDhyOd6FlI6Lfod4xBT2aYb6mBX/aHWkxsSvtA
         Swj6tIuzip8Orkq/5MU1rGSAADrgpx5QOPQrhIadSGc71y+W8q+tf98qaSC+CXIjzIpw
         xJvARfWjLTKToAZdSGH/FrsMvVnqAmoIeUW+bC2DT5Dqf2x+X33arCHmKayTg6JZYNBc
         rOWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786024101; x=1786628901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v8Y0ExwL5RJmYW1fILSeng5LBvxhpRt1TCM0nL/CNRQ=;
        b=mPnDQHHRIWNCq4d2K97hriEog7COkh3nwXwMmd0g2e5NUQhXR6+ji6Q05Oc+DUktSO
         s5bn/B0kxJjnTJuYraF1XrjE8Ekdtghen8fT0AoZyiUYSZ4EQWbW0yaNhv6lEDKwdQBy
         mZhfaipI1WY6QRqP/G4r66u8Whk2xs0vC98q92Z5WagH5vmZgJJmTLcfouFqG1BSpeyx
         oB2vfPQPapuy896jFNybUw+4uPLaPa6mNT285DEeJm4kqcEsfTHaL2m1f9cvUTjHgAwm
         wCQFI9GKcCRMt/wfBw93OmwHfJsJ+DfjGEvSscfbwfyyaZ8pm71EuUlAj39rdPt+R5MS
         Q+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024101; x=1786628901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8Y0ExwL5RJmYW1fILSeng5LBvxhpRt1TCM0nL/CNRQ=;
        b=mlTxhc2xwdecPvQfJVc0P0JRFsxLDpNC97tqvcaPI6CVdlm8rVbWec+OWnO9qXxsXO
         b+k5rcSWaYWY5fFlO3Gs02pW13Lnz/TSF1y4WptIGGBpQnvhv3XPRa/ch0+eVRf1sCpR
         JPvcwj8Ge3mVH+JQP76QwPOIFF6oeaKMwF9lQ1N2T9AFWE0Hauf2Q3e1QSwYmoKID7W1
         MBmXpeegLZUYPhRQhH7wdxX1YBLmUgh0zexoP/a+VZFjrwFbJBlf8alpvJbje2LpnMTI
         YThbVkdTzOfzhm96O+cpfAOwI/275Bdf9wKLJRPEn4XxqLHMyqbXxcIgBVpSfAuQF9Hb
         wHRA==
X-Gm-Message-State: AOJu0Yw49/WAM2gV0M9t7PzcB4ZX1UHofuEug+j+M6WeSNxCNxYoDC+i
	bCnBkpGw71Gk2Uh9AzCwDPHbsoDhqBCXRqZ7Und4v46Js33AxQleyE13UQ/PQMUBdLBLjPgwoz0
	eoLjOLIo6+BATC6mlMxuPhi5yHS4CZKphPxcgpXYxFPHnvMxdBUkmTiKpbYC5sOg+1JRre8dwzq
	gpAq2uVvPtiQenvDNIfsSOxbE1nGNp
X-Gm-Gg: AR+sD133Fsm0wDBONvLzIo0E2WE8rYLVrOAg+LrBfSKPOOxIw6zJsOLysssbuFQzJkW
	dsghp1+uua2kwjFO6x/rQb1b6/ivRnooybOZexWBZ3uh9T/ayM8g5PkKKvTYZL5qtWj5xMgy6F0
	qAdGACScKsOdClNOISOXWQNBXjey+h6QhsIQ9HulJMBlck54JZRS0Ft6HMDyUG2uRdwQoDfYH3B
	BOMm1e1rNl7DI9UvIsxT/Yrb7XTNJbLCWCA8+b6a+q7M1m+OY6OPNajubg=
X-Received: by 2002:a05:6000:4808:b0:47f:80ee:744f with SMTP id ffacd0b85a97d-47fec5222dbmr23617564f8f.16.1786024101304;
        Thu, 06 Aug 2026 06:48:21 -0700 (PDT)
X-Received: by 2002:a05:6000:4808:b0:47f:80ee:744f with SMTP id
 ffacd0b85a97d-47fec5222dbmr23617499f8f.16.1786024100926; Thu, 06 Aug 2026
 06:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Aug 2026 15:48:08 +0200
X-Gm-Features: AUfX_my4ahHsSjtDt_RgC7cSARlv-tVLJYAEL3hBv5okb1db2aWHdU6uSuJOe1s
Message-ID: <CABgObfb6K-GJgxvYtbOhzmdy-gO=Uyz-tbXWm3Hr+JkKg1rhtA@mail.gmail.com>
Subject: Re: [GIT PULL v1 00/23] KVM: s390: Misc KVM and vfio-ccw fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 6:09=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ibm=
.com> wrote:
>
> Ciao Paolo,
>
> In this pull request there are a bunch of fixes to various KVM/s390 and
> vfio-ccw issues.
>
> There are still some small known bugs, which will be addressed later in
> a different series.
>
> The following changes since commit 9972befc3e34ff8b6847198c84f11bfc312dde=
40:
>
>   KVM: s390: Fall back to short-term pinning in MAP ioctl (2026-07-27 09:=
23:53 +0200)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-7.2-3
>
> for you to fetch changes up to feadc5e84dcb53422a437556c35af9efd9826fd5:
>
>   KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu() (2026-08-03 17:09:46=
 +0200)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM: s390: Misc fixes for 7.2
>
> Fix a bunch of small issues that came up during the previous round of
> fixes.
>
> They are mostly extremely unlikely races, but they should be fixed
> nonetheless.
>
> ----------------------------------------------------------------
> Claudio Imbrenda (13):
>       KVM: s390: Fix unlikely NULL gmap dereference
>       KVM: s390: Do not free SCA if it was not allocated
>       KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
>       KVM: s390: Fix overclearing ESCA in case of error
>       KVM: s390: ucontrol: Fix sca_clear_ext_call()
>       KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
>       KVM: s390: Fix race in __do_essa()
>       KVM: s390: cmma: Fix dirty tracking when removing memslot
>       KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
>       KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
>       KVM: s390: Return -EINTR if a signal is pending while faulting-in
>       KVM: s390: Fix ordering when adding to SCA
>       KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()
>
> Eric Farman (10):
>       s390/vfio_ccw: Free all memory if cp_init() fails
>       s390/vfio_ccw: Limit the number of channel program segments
>       s390/vfio_ccw: Fix out of bounds check on CCW array
>       s390/vfio_ccw: Ensure first IDAW remains constant
>       s390/vfio_ccw: Calculate idal length based on idaw type
>       s390/vfio_ccw: Ensure index for read/write regions are within range
>       s390/vfio_ccw: Cancel existing workqueues
>       s390/vfio_ccw: Move cp cleanup out of not operational
>       s390/vfio_ccw: Selectively expand io_mutex
>       s390/vfio_ccw: Implement a crw lock
>
>  arch/s390/include/asm/kvm_host.h    |   1 +
>  arch/s390/kvm/dat.c                 |  23 +++++--
>  arch/s390/kvm/dat.h                 |   2 +-
>  arch/s390/kvm/faultin.c             |   6 +-
>  arch/s390/kvm/interrupt.c           |  19 ++++--
>  arch/s390/kvm/kvm-s390.c            | 125 +++++++++++++++++++++++-------=
------
>  arch/s390/kvm/priv.c                |  10 +--
>  arch/s390/kvm/pv.c                  |  43 +++++++------
>  drivers/s390/cio/vfio_ccw_async.c   |  16 +++++
>  drivers/s390/cio/vfio_ccw_chp.c     |  31 +++++++--
>  drivers/s390/cio/vfio_ccw_cp.c      |  74 +++++++++++++++------
>  drivers/s390/cio/vfio_ccw_cp.h      |  10 +++
>  drivers/s390/cio/vfio_ccw_drv.c     |  21 +++++-
>  drivers/s390/cio/vfio_ccw_fsm.c     |   8 ++-
>  drivers/s390/cio/vfio_ccw_ops.c     |  39 +++++++++--
>  drivers/s390/cio/vfio_ccw_private.h |  10 ++-
>  16 files changed, 320 insertions(+), 118 deletions(-)
>

