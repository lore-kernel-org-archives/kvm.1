Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C657435539
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110466; cv=pass; b=lfljiwTtTOocIdiQk1UuqbHPDeEeT3K6pzCqxgvPeCWp1ysoo8ir855apsyOOI8hKYFzsg/w/ZOGs3bUaCBiuDX64KftkS63Pibh3CxZ8djsFEt8JJbAv13bd3Izx1ob1ze7mTrV5g4DOxDw0EcgObWuFdkrwEZ41p7lL9nYD2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110466; c=relaxed/simple;
	bh=bQhFfWQ2UxJga9eW4whcQbngDhCAqLTkvi+3GBBScv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9BvpPbQ/XbnuuKARspNBLtzERdWZMiM6GvCMbnTjgCJY8RA860kWrZ5jC0KZGowkjbBo24vOR9wkHkYJEGs5yh+bwkBozfnXujHkvfaMk2vBv7PLmyyYSoP/Ym+pWCpttBYKP/V6f8v+8eocsoMiBOki8pxikx6vwA1akAb5Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCz7Lmqj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUfKe2s4; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCz7Lmqj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUfKe2s4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784110463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTfS1o6FG2+VSRsM8RoeMYV4oV1nuMVaP/qPFLezgiM=;
	b=CCz7LmqjaBLeLgxGhJqmXaUUkUyu8fZ3koycP6UsOVGeab/4+X5XuOvCGST07T6hZEnX4x
	53AJZ1Cgv9a2C226HM0BQ33g9CPObAMW7BwXa2DIWJ9LRocHUzfyD5RV7+4fvj8nknjn88
	s5+MmTBkbngXe2MqVAFasfVK29afxi4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-tvNxO_U6Pg2SepsNejWRLA-1; Wed, 15 Jul 2026 06:14:21 -0400
X-MC-Unique: tvNxO_U6Pg2SepsNejWRLA-1
X-Mimecast-MFC-AGG-ID: tvNxO_U6Pg2SepsNejWRLA_1784110461
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47d81cf0c4cso3932050f8f.2
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 03:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784110460; cv=none;
        d=google.com; s=arc-20260327;
        b=XsqSthYCET4jXWs6uNB0apa83YEaUuwTnxCEpjTbhW1tpiVTPD7tMr8qt2TQdVAsZE
         Hl1MeMjYfTcnNR005r/inoZP/tD+wDWgcM648wb1LF7l93JI06MfJjbfbBMtmabj4kVx
         Wya2MYXJtUIgGyj9mz2dqLyvW0A68plRJI3Mm81A+9S5CO3UIJzYq/7BS6eo31vyQSYK
         4Z3SG1ylGd0IgTxqAV+pitYfxojA/MnrcTNRlfom00hurgUuvToUKW6HUum/kLsyJfDx
         GLYUlDlsH4oZEME3DVfDeMFo3KCiwGSrq8OtmTLzaHD9armkU632ujoBZC5jjNjQsL84
         66cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OTfS1o6FG2+VSRsM8RoeMYV4oV1nuMVaP/qPFLezgiM=;
        fh=SyjyeewRWQrNXAkqGCDCtYYgNDCQdCWD+lmI/eJkfs8=;
        b=Dca+6RyK5IbGpvnwB3jWVqcvTvayUc9YdoiPE1Ni8aptFN4y55p22+90gi8FCYBxoq
         bzaL6qY7919WJGQXrGhKUywKd4xP20UNZjoZCJIM5oUphgeGnmtnPz3QP/vMxVcuLUQK
         llvYsk+fqPzkWxw09o+fTF1s9mFqpkJ9zoOUVeo1Jg5SOC6+GT4sC47tJqjJvyDMR0T9
         teWYsLyC93niaF1Wuy2SAGjRl5H3SFCbuKa0ehQaom7lGXQvU4jIk4FTv/LF9febdyxc
         8FzeHrPhNWDpWi/+rt4ADdz4fCPL/QCCwVdL0KuFcfgmbtKuBs2Ubq0lGboPUXD5O31a
         Sh+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784110460; x=1784715260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OTfS1o6FG2+VSRsM8RoeMYV4oV1nuMVaP/qPFLezgiM=;
        b=OUfKe2s4H5Fh8CvctwoI3Sk8DOGmWHVzZrf2CHayVK1rJ9xUjayG9ip75/iH7MieTQ
         oJaJT5se/GjSTMbn80TPTvRM/NAXtpTUYvuqn6BgVGYfQ1HGL/8l/cVZ+mbU7d4h12DW
         51Co5kf4ZhxBHM2A6TqNZTm4YdzG6sjecApXWCoICEemrneIACpMhM6oNGzamJYprARY
         qgwhGjZC/eggVWXkGd1MT+ZbicweXsKKyz/XsfY1jeZnE7mm4sqKIHAESAGVeLbcWK9n
         GQo8zjGkCovJLvaGDvrBz3FEqiz0WG+36E/0wnbnMJ0qG1AjRGQ7xUQBzs/kJ5QbOnsi
         ZFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110460; x=1784715260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OTfS1o6FG2+VSRsM8RoeMYV4oV1nuMVaP/qPFLezgiM=;
        b=TRO9steC2436HIwJCwt0JT//yTMDPEecj5tKewsiU6/78gKTh4He23am8z/s3ct/6E
         rO+BHfSf/BmWkP26E3mQG2VCKfR0jvCdd0eCmcEM5Yn0S7b2OAaQj00A/qSgADYFtz8x
         AJfLE5fuTMf9Wn49RvQFHgoLnYx0sdCY6Wm5TubkqU6MxFDtjHX+pmToIInzmLldSCkn
         VDP6zGoBHLN80V7p9OZFloCQlMYnUd20Y6mQlMG9GkqLSYsaPiVzt2Oemb+7ZhmYAJi+
         bWyyjt24m7giOnj5GjmsPbK7fKX3k46wUTaJchYmNQ654fphRFhJpF70xRiBsqbs7rqf
         tMJw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9TWEGfdo88ERnvWGK+EzflGieAVTP351bIcJX+36VjJmRb5ny21lg3tTxqgtxsdS58D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2TVXgbwR3lBZaA2CK4hxYTN8M0mqDAQF97rmUY6TGCF6V9im
	BCm/3+QDGhGdotfjgCHiWvTSFOytS3v7vQ1wJKGSSvGXtHPwvdHjGkghJsWlw9CUluOz1bEv9Nu
	IXLL74hJ02lB4C6S7NPsSubR3bPlv+6hiLKiXyFwTxlxI0sd7zQw0fYQzc2SkozlXTetyT0/tKk
	iTkXeEoyRKcL6PWMcug2dIctR9R9ec
X-Gm-Gg: AfdE7clZCr6qj+pU3+tT01aHuJ9PLMzvddC+BUmlVlrCokPPkQdGWzfKtZLQC74mcvl
	U7vfaXsTYP4uGn8hUyT2Oy149rXraxQ8Ub8iZwJsyhpHDFdvLHgioVLs0zB8MsnPEzTsa+sEGsL
	ifNAzqvqI5+1XdUScLo1KD02LvskBmyffEaY97lhQgVVw13JC9R8rw06/7j8+JiGqjuGvOpjV0s
	tY2HADcGdDBKqqw8DlJK1P9f0X1RZVsAMsBKoBMI2ekw9W2r7KmulS6KnlOUGtJePxlwA==
X-Received: by 2002:adf:f0c3:0:b0:460:3233:beef with SMTP id ffacd0b85a97d-47f46386e3fmr7594774f8f.43.1784110460616;
        Wed, 15 Jul 2026 03:14:20 -0700 (PDT)
X-Received: by 2002:adf:f0c3:0:b0:460:3233:beef with SMTP id
 ffacd0b85a97d-47f46386e3fmr7594731f8f.43.1784110460011; Wed, 15 Jul 2026
 03:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708161242.1912769-1-maz@kernel.org>
In-Reply-To: <20260708161242.1912769-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 15 Jul 2026 12:14:08 +0200
X-Gm-Features: AUfX_mzYYojltzRopjsZWj-BSyvTHnDNy-EhsjgnxP0aoffOaIAQ3DKZpIh1JXg
Message-ID: <CABgObfbpDt2iATf=d-BiawY_41rLnYFzNiDLDx8W8c-iRCxEXA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.2, take #2
To: Marc Zyngier <maz@kernel.org>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Mark Brown <broonie@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>, Oliver Upton <oupton@kernel.org>, 
	Sebastian Ene <sebastianene@google.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Wei-Lin Chang <weilin.chang@arm.com>, 
	Will Deacon <will@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 6:13=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> Paolo,
>
> Here's the second drop of KVM/arm64 fixes for 7.2. This time around,
> we have a locking issue in kvm_io_bus_get_dev(), which is only used by
> arm64, a few S2 page table fixes, a set of FFA proxy fixes for pKVM,
> and finally a very esoteric fix for emulation of sign-extended loads
> from MMIO. Not only this is rather niche, it dates back to day one of
> KVM support for 32bit ARM...
>
> Note that this is on top of the kvmarm-fixes-7.2-1 tag pull request
> posted at [1] about 12 days ago.

Yes, pulled that first and then this one.

Paolo

> Please pull,
>
>         M.
>
> [1] https://lore.kernel.org/all/20260626133526.817232-1-maz@kernel.org
>
> The following changes since commit d098bb75d14fde2f12155f1a95ec0168160867=
ce:
>
>   KVM: arm64: account pKVM reclaim against the VM mm (2026-06-22 10:48:08=
 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.2-2
>
> for you to fetch changes up to 8d187d4b33c262c0f3e44842553521151d8629e8:
>
>   KVM: arm64: Fix propagation of TLBI level in kvm_pgtable_stage2_relax_p=
erms() (2026-07-07 17:43:39 +0100)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.2, take #2
>
> - Move locking for kvm_io_bus_get_dev() into the caller, ensuring
>   race-free checks that the returned object is of the correct type
>
> - Fix initialisation of the page-table walk level when relaxing
>   permissions
>
> - Correctly update the XN attribute when relaxing permissions
>
> - Fix the sign extension of loads from emulated MMIO regions
>
> - Assorted collection of fixes for pKVM's FFA proxy, together with a
>   couple of FFA driver adjustments
>
> ----------------------------------------------------------------
> Fuad Tabba (2):
>       KVM: arm64: Fix sign-extension of MMIO loads
>       KVM: arm64: selftests: Add MMIO sign-extending load test
>
> Marc Zyngier (2):
>       KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
>       KVM: arm64: Fix propagation of TLBI level in kvm_pgtable_stage2_rel=
ax_perms()
>
> Mostafa Saleh (3):
>       KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
>       KVM: arm64: Ensure FFA ranges are page aligned
>       firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmi=
t()
>
> Oliver Upton (2):
>       KVM: arm64: Ensure level is always initialized when relaxing perms
>       KVM: arm64: Only update XN attr when requested during S2 relaxation
>
> Sebastian Ene (3):
>       KVM: arm64: Validate the offset to the mem access descriptor
>       KVM: arm64: Zero out the stack initialized data in the FFA handler
>       firmware: arm_ffa: Fix Endpoint Memory Access Descriptor offset cal=
culation
>
>  arch/arm64/kvm/hyp/nvhe/ffa.c                     |  44 ++--
>  arch/arm64/kvm/hyp/pgtable.c                      |  15 +-
>  arch/arm64/kvm/mmio.c                             |   7 +-
>  arch/arm64/kvm/vgic/vgic-its.c                    |   2 +
>  drivers/firmware/arm_ffa/driver.c                 |  25 ++-
>  include/linux/arm_ffa.h                           |   9 +-
>  tools/testing/selftests/kvm/Makefile.kvm          |   1 +
>  tools/testing/selftests/kvm/arm64/mmio_sign_ext.c | 255 ++++++++++++++++=
++++++
>  virt/kvm/kvm_main.c                               |  16 +-
>  9 files changed, 331 insertions(+), 43 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/arm64/mmio_sign_ext.c
>

