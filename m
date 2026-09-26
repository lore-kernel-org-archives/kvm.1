Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509338D011
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 04:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790397656; cv=pass; b=PtgEmU3Zj/GsRBDJtr+OYEkiiaB76/DcDvJJ/02s0zxzbD0sSW1NKGd7gaqF8YF1skjv1YR3/sFPgsuSrUw6uNRq30H0FUkZlmttZ3nsGtW1Ag50TQxESkVhCZ3q8PBzx3xLWiA2v28Eu9ie6/xoMU6ywgPXvaDP8X6hu84iefU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790397656; c=relaxed/simple;
	bh=BZAAORgGy6Ms3KnxsVv8dFpiAsr6V0VyBa8kffO+g4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cwd9nPvoN1432Ip/zG6LIwfW4wgJ1EADl8NL1Ra/v4qAQmbQGu/E2a7G5RP1HlfwQtD6X5SDzFxOqkTV+ZzGKKgEbdJgdRvPHqUuFkYnq+qo6CZERsYjWZSgY2migvVVChkgq70T9+zCyNBHw67TC6sE0BhEVJcoNTR+qavflxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4r6y+GX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0C8x8GB; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4r6y+GX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0C8x8GB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790397653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDMDQqBFeguZLrOJapnDiNiCw4jrA0CzviqQJznXwac=;
	b=c4r6y+GXFyklMDhuJ7xQGjnhXYXqU52j3oyLTWI9203UotqV/xRJRrY+k6nuwcu/n/X5z+
	fnIKEUeeKvhCrT3YAw1x3NswJfNWZvF7rDReYRSmHWrAPMpS6E/rXQg3H3HMhz9A5yoanP
	svjDa7649haw3JUBYkG//Wl/k1vh4BA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-mBJfmrY5NNGxHXEZnv2AJw-1; Sat, 26 Sep 2026 00:40:49 -0400
X-MC-Unique: mBJfmrY5NNGxHXEZnv2AJw-1
X-Mimecast-MFC-AGG-ID: mBJfmrY5NNGxHXEZnv2AJw_1790397648
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-488872aa05fso299090f8f.3
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 21:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790397648; cv=none;
        d=google.com; s=arc-20260327;
        b=rL4qKGZZZzaDCAjHEZu/9NgKX1Aq/1ixEh/wrw+b290Qfidz830vSv1AWIK6SZl9Kj
         WwRcqwiwQg+LdwxaX4xB2AOLQkF2RmFD1WTKdWgFjqRjo9rt1q2IxgIui6w1pq9KGz/4
         kpK9Mxs4aQTIHgG6sXj3ikU2N60MA/SHGj/YVF4q2b9GLLd7imMX1Wijg7biYpjUXNdV
         CKzqPC4TWH9b4L6z+8queyBg3GPIon0Utc7yt4ehqG0yTCrht4Eoz3anfUJtVR6VYqxw
         GKvKnbZXJsDkzgngO8tqK9uwWDdzmCtJu/7lHKq47MPVFD6AjvGfejGk3IRIRrNTpGQS
         uZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JDMDQqBFeguZLrOJapnDiNiCw4jrA0CzviqQJznXwac=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=KLAkmivIn+l56J39wSeVAh8H5EmgCJ2dhjbNfSyGvsqSqS8qlXv7bKb35YzUkJI1Gr
         fOMpIxq/mf10qUtars/7nxx79vEna/1aZULXxp4VyPWthKskmZjQnN9wojlelHVWrG+r
         jGZMg67DQfd0D4n06rzSup5fmg/eYj1wUPsnxHJZGTh2LTaAfuCFZmqayFU+2GvWIE2M
         bNXnwLK6V7MjpzWWxAs5bmxpVhHJ2vKRPv+HiJPn3HJzXTsmvWNrK/f4i4ddwX1bXlh/
         VLDOTFYxiz9osdT6SAfVsgVEX10HmG6/VXaBpGjpDx1jhxpj2UpLgtFf2OG0kRGZJDzm
         EjsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790397648; x=1791002448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JDMDQqBFeguZLrOJapnDiNiCw4jrA0CzviqQJznXwac=;
        b=U0C8x8GBfoiqUG2a9EZT01iRBzPpNl6VKJFUkCnztue0IgziJwk/Cm4BBQ5OubK7vh
         VvWg83eY0DwPXCqJk6iTAbxANMiFrr1NApShmyWaDFCYrodzrt0DkICcoy4zszDFR7qT
         rtZ44X+vMTevtJGINcnyllEmc5WdTDE9ukdKMLiEIE9Hxa0yT+693PEPyzA4AzAScmHN
         YnsHnJLH19LS89iOso5ddugHsrp1kgSwSaIC7ZRa+7NMr7nSBLWBIVL2ntAoRY1QATLr
         5vfpc/0DwzWw4GnOcS2dV0RDDnzm2hb/UTQLi7xy9TK2SAXd/R+hFW/RkZ5z7npHK49V
         lslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790397648; x=1791002448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JDMDQqBFeguZLrOJapnDiNiCw4jrA0CzviqQJznXwac=;
        b=zWjraoP50UyuNaqyAICkzX1DVmVhXgxz8aMooF1VXLNxkklE7xN9Hs9Od83ufbR1PG
         IcVDSbMmfcwo/NcYJ2Dq4Fx6xgMJR49xRPKU5dhLti5VcMHg+WolMHAtfgtAmSRyLZH4
         z1mFgn1Q4DoVZSARratGGfJx7Jzg3JDVC6IdeEWL2buxogGrMA+r6E2p8a6Yd/K0t1E0
         GprcxNx+j0ZQeyDahF9A0VNhDwi2D8r6D4T38XFHuXqRTlOat2jemN/FAcceJ65I8Bv4
         cBQqd/OS/iHklcj2RNGv4lUps2iUScOXthiWdd4OnkOGm1wFmI7K/Qxpc0vXmAgFtzuh
         mWqQ==
X-Gm-Message-State: AFuF++mKODAYoiaMBmBpC+0N9QI48tHGVVZYW3Dr0Pu63a+XntVaGUYV
	UhArH03LcjJjrVbQNVWK31A+Bi7kv0waUMvgyQcOPL2PmjH30dQ8ffFtXBQWVXOCNwDT8hqX9Qx
	PIRzUV2nGknFx98CIWM8E3dbRhYWkwkH9LGSXjaRGMmE7hKU9FOiZLbPHRsmd0s927oxzsdv63L
	MUU9Q8OXkFwPOwZeCUnQp5Yv4iodZ4
X-Gm-Gg: AYBFou35zKsL9vIkuITGuerD5j3IHqIB/dYf4cjYxJlwjvw7DVwDSx2Fwgy70n4mRwd
	JbFQv8hPKXO5CuDJg+KRaqHrlKXlScY4NQDXQUC04pZ55KLTtE7mPyj1MtfhWFwhYxKetmtu40N
	dtqerjDWPbyajQ3yxajHW2bkbtLK7XAOxG37oUJXPkwAHeP0O9hUyuvNecyEYTEMSWSIT6PpOlc
	/8YSub3PQbF/3gOPMlsXP7z2FG15RpybArjmE0YwbQeoIHY9pvpDxAw9bG4Vg==
X-Received: by 2002:a05:600c:8486:b0:49e:745d:c317 with SMTP id 5b1f17b1804b1-49fe66b426bmr138635025e9.12.1790397647688;
        Fri, 25 Sep 2026 21:40:47 -0700 (PDT)
X-Received: by 2002:a05:600c:8486:b0:49e:745d:c317 with SMTP id
 5b1f17b1804b1-49fe66b426bmr138634725e9.12.1790397647309; Fri, 25 Sep 2026
 21:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925233321.2381319-1-seanjc@google.com>
In-Reply-To: <20260925233321.2381319-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 26 Sep 2026 06:40:34 +0200
X-Gm-Features: AclHuK_Yq44dj9CGbs6sF4OIA_FkwcvYoMqBVDfogFZ_KeuJ9XSHG47vC6oNiI0
Message-ID: <CABgObfZeA_q_prxJhbdNqYpE8quPD360LhVBQv8ypcPpLA-Mhg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Fixes for 7.3-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 1:33=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull a variety of fixes.  Nothing is super urgent, but all of thes=
e can
> be fatal to the host and/or guest (except for the selftest change, which =
fixes
> a regression that was introduced in 7.3).
>
> The following changes since commit d599822bdb66aeec5ec76297b0fc6efaaeefe0=
7c:
>
>   Merge tag 'kvm-s390-master-7.3-1' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/kvms390/linux into HEAD (2026-09-04 17:34:28 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-7.3-rc5
>
> for you to fetch changes up to 119e9db233ad0f4cbd4cfb9f9385a7bca378b37d:
>
>   KVM: Don't pre-reserve xarray entries when storing empty/NULL attribute=
s (2026-09-22 08:36:16 -0700)

Pulled, thanks. I added on top the SEV cache writeback patches which
are not present here.

Paolo

> ----------------------------------------------------------------
> KVM fixes for 7.3-rcN
>
>  - Fix a brown paper bag bug where KVM would incorrectly treat Intel PMU =
MSRs
>    as valid on AMD.
>
>  - Fix a regression in the hardware disable selftest where it checked the=
 wrong
>    macro when detecting glibc support (breaks at least musl).
>
>  - Never clear KVM_REQ_VM_DEAD so that dead VMs stay dead, which is espec=
ially
>    important for KVM_BUG_ON() flows, which often guard more dangerous bug=
s.
>
>  - Re-pend GET_NESTED_STATE_PAGES if getting the pages fails, to fix a bu=
g
>    where KVM would let userspace run a broken setup with stale vmcs12 pag=
es.
>
>  - Fix a class of bugs where KVM would fail to fill kvm_run exit fields i=
f
>    getting nested pages failed.
>
>  - Treat reserved entries in the memory attributes xarray as "no attribut=
es",
>    to fix false positives when checking for mixed attributes.
>
>  - Fix memcg accounting for the memory attributes xarray (the xarray libr=
ary
>    subtly requires the xarray to be configured for accounting upfront; th=
e gfp
>    flags taken at runtime are used only rarely).
>
>  - Don't pre-reserve xarray entries when storing empty attributes, as sto=
ring
>    NULL must not require memory allocation (KVM and other subsystems heav=
ily
>    rely on this behavior).
>
> ----------------------------------------------------------------
> David Ballesteros (1):
>       KVM: Ensure memory attributes xarray nodes are accounted to the cal=
ler's memcg
>
> Jim Mattson (1):
>       KVM: x86/pmu: Move Intel PMU global MSRs to intel_is_valid_msr()
>
> Sean Christopherson (4):
>       KVM: selftests: Use __GLIBC__, not _GNU_SOURCE, to detect actual gl=
ibc
>       KVM: Never clear KVM_REQ_VM_DEAD from a vCPU's requests
>       KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fail=
s
>       KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages=
() error paths
>
> Zeng Chi (2):
>       KVM: Don't treat reserved xarray entries as having memory attribute=
s
>       KVM: Don't pre-reserve xarray entries when storing empty/NULL attri=
butes
>
>  arch/arm64/kvm/arm.c                               |  2 +-
>  arch/x86/kvm/mmu/mmu.c                             |  2 +-
>  arch/x86/kvm/pmu.c                                 |  8 -----
>  arch/x86/kvm/svm/nested.c                          |  7 +----
>  arch/x86/kvm/vmx/nested.c                          | 15 ++++------
>  arch/x86/kvm/vmx/pmu_intel.c                       |  3 ++
>  arch/x86/kvm/vmx/tdx.c                             |  2 +-
>  arch/x86/kvm/x86.c                                 |  6 +++-
>  include/linux/kvm_host.h                           |  9 ++++--
>  .../testing/selftests/kvm/hardware_disable_test.c  |  6 ++--
>  virt/kvm/kvm_main.c                                | 35 ++++++++++++++++=
++----
>  11 files changed, 56 insertions(+), 39 deletions(-)
>

