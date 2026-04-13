Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580121DF75A
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077328; cv=pass; b=hxuPY/JKHL53BjHRfW4FRhMHKZ0JFo3aC47vR8ysAGaQCY1ksjf/P/VesxUAMY2aFtxAJIZ3BzlK2vFXkCCntJW25Kb9i0wO0HYJ++FkZv1WeqlbfTbRmYSZT1ptOACL9bNmiC+3fyGgpX/7BnafFkKmPxL7VLbHLfXn8luKxBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077328; c=relaxed/simple;
	bh=DLrmXFsfnl46Cy2LBeh3ttWHw52IskeSuCm02y85cXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWSapyA+LaPZgav2pQO0wVWiomwU0WukAjeq/ggUjgxugqjTJvBxm5E2UoS0kYVm2rV0E5cjmTPrnlmIk0jVy+MCYT7rX6oWVEqy6c6y7DKH5eZsj/A7TSedunpENeDCmYvWLAkRkKFFQ7bc7s82WOGADeYAOKMoADR3L7JAeyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZduuJCAm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9rcctP8; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZduuJCAm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9rcctP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776077326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBE0qqxijYzt/5yrCnQTHVEZ7B2dtqLRE2l6crnji1s=;
	b=ZduuJCAmyb7Qh4lkH6ljNrm8L/2kaed4yfFx49wJnPSRCMAS4UxT60QUfrMZkKRN41Ge7/
	70Vn+UIr385rjBeGOn8u9ghzuQjrRRxi9frh5+xFdXb8Jnv2LGOY4wj+Lta9JvnBb4vbAY
	OJKv4JodqlngX9QgN+bL6GB/Lz4Dt84=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-u4K3GBY_Po6dZTxBUfYCQw-1; Mon, 13 Apr 2026 06:48:45 -0400
X-MC-Unique: u4K3GBY_Po6dZTxBUfYCQw-1
X-Mimecast-MFC-AGG-ID: u4K3GBY_Po6dZTxBUfYCQw_1776077324
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so2330201f8f.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 03:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776077323; cv=none;
        d=google.com; s=arc-20240605;
        b=DROvSN24iJVViLklNvPR9T2N5S1OHLCJMniCJc4oHiM/Oke29Xfxd45jDQpOzmjUAk
         n5c+SCl+wsxvLLfV8qzaq1f9Ss+Q0XGNq8G9KLfcCAsGCSGTwyfE8+tsqQvalJ2Fw6Gb
         /z2Yku5PmiSn4dgLhnn5ApsfuYQL4QH+nZgYq59+PSCXFkI90Z7thxX0UxDCB/U1VvNM
         xT9e1SQr8iNa6us/+L3lOjMsmvbRrzbbtAR5VoTPhWC9vtOTHDogK6W/VfMfOExu0UBz
         gDSU2GY/YU1QhXdo2nwPQgVVcS+Tck/R0HS1ZU7TsBUD/jPm714ZQgnzC7uFU9yIASPB
         Q7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qBE0qqxijYzt/5yrCnQTHVEZ7B2dtqLRE2l6crnji1s=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=elnMzyzMpxVgddHcKkL/z6eTlcFZTX+oLYRsAeJuDj5cctQXtJ4G9G4V2wsKUwpVsh
         F7pGTdxkdv9SG+qRjw8Lr0jkPKeGMHIddeZ/Oc3ANOaWd/4EM6pf1dzqYGU4mpjY+gxW
         fJZ+8N8E67rftpyQsm3/JQH8BCUmywpZCEcj258AD3KLRMgczvbT9aXnw5ohpYjw3TCE
         zQ6Y4O/xm8Xq+pnlDgJv171I0b9+W9Y8jNTmYblxJznwmoTK5Vn0RQlSDSQdysEJXufb
         KO/TdtaBwgh8sE3oPq7znZuc/IcR1U8saSBvDXHlMhCZubBZZY+lLIBLRpVH9w5dnfgh
         JX+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776077323; x=1776682123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBE0qqxijYzt/5yrCnQTHVEZ7B2dtqLRE2l6crnji1s=;
        b=L9rcctP8pz6rvbQwfMHze45i/O05stSJrjuhyRggCX68z6dnqSGcvjbl903wlV1O87
         Ue4W35SqmBUtwXh86vVy/jmmp0zQ7Hg8dFD1WTB5YHKFbwGr1ofiFl3+u91SXNVI0MxW
         IsS6M7g7sET7epWs6oxkX4QZNtFFTVd+p0iIT+P+3mfmkMehMlD3DO3dYwUsc5fiqxw8
         CPlON0p00FK7atugn3f9uAQ6pAPzRWSGAD+nqhVPIqqWASTTevQhdEqlUph5pUSO9V27
         3YaWZqxLM8UpceC60Yll99NLg/SiVyHHE2Z2Gabzn/S8QCz0vO8osjFhLWkfA4rrLMN2
         Qrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776077323; x=1776682123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qBE0qqxijYzt/5yrCnQTHVEZ7B2dtqLRE2l6crnji1s=;
        b=mH/k/wd1DNOJ+vMKSNF68YosrHWdjvEnTVZVNOY3Zx3KGD76tsI9mUnCPfqiZllWtU
         p02FtqdXplCrMkOQInXkw6v/cPs/qTD0cOiGf64+Y/YTR3beod+QqDTNyQlJvMqKDWRx
         B50Af1pyKScfltLOjTjNCaegkn1l6sU28W1hZwM2n2THGMu7AX9uv8RT2FQ/qduAFFM3
         M33YTuBs6pYOJnyZCIjf+U8M3jTIici94vkbCuB/LTbQQF6z+OG7XjsTEDUq700GR2A5
         29vwICdeTtJ6KwIH3HB/XtMyFY369nd2HqMviAEYJ1vCH6m6BNt+dYHbyfibm/IH1Z7F
         FOiQ==
X-Gm-Message-State: AOJu0YxAZwW+7YsPuaB4whkdae5OC4v86MJWawR3vO1aDXXEeZr4N96H
	0nlAEkY6px+jVINCbgaE25AinS5XTdH86um7bpIFS9kF4QQU3AdmiDfToh/XRrvfijLnyKFTYvc
	FBEbXlWuySLyntprJs36BicdbvrO4yK1OhaUUj7fRr1ZC1GhVEq0mMhDhrtd4h/DUNCDdQr6tkP
	4cMvNzChXtOEJMflngQgQ5JJTYCZH2GpxzIQQD
X-Gm-Gg: AeBDieuPkNSwWJycGMTZ7432eSn2S/tKWgGTwIayakqKEQmQpuMjvySHrrYbKPVwFsB
	xCE+1ijeISRVsaZZshUZPKUL9LT1llT9/rZfeURmNwOEMJrqYr8Icv645jQjcX3LygFZ9dLcdp5
	T6ut/S1j/JWvqpQwflitJnMswvSgwW2G3nktxLoDfFj3eoJekCWiHVbzwjrWytnLButjOpvpcZ+
	DzhLc6sEDIpcT35aD7AGctL+K5YsMhA4B1Ry4Cwn18s4P0wjBgsr7JyIM0XUgxg3MQ4xfWRm61I
	Criu
X-Received: by 2002:a05:6000:2803:b0:439:ccd7:cdcc with SMTP id ffacd0b85a97d-43d595c4d23mr16059589f8f.18.1776077323073;
        Mon, 13 Apr 2026 03:48:43 -0700 (PDT)
X-Received: by 2002:a05:6000:2803:b0:439:ccd7:cdcc with SMTP id
 ffacd0b85a97d-43d595c4d23mr16059568f8f.18.1776077322616; Mon, 13 Apr 2026
 03:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com> <20260410235832.2312342-8-seanjc@google.com>
In-Reply-To: <20260410235832.2312342-8-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 12:48:31 +0200
X-Gm-Features: AQROBzAtHZ6dNpQ0Qo1grutxKAhlX1_VxSSUrtRh93zuGPbpdPIdcYXOGt12CqY
Message-ID: <CABgObfaBWkUgtBWd8TDpHsU29XtmWheiBucDD8yNkCNJ5Jn_Dw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Selftests changes for 7.1
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 1:58=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add Hygon support, fix a related bug in the MSR test, and add MADV_COLLAP=
SE
> regression test for guest_memfd.
>
> I'm also going to post patches and send a pull request to convert selftes=
ts to
> kernel-style u{8,16,32,64} types after you merge all initial arch pulls.
> Please yell at me if you don't see anything on that front by ~Wednesday.
>
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a08048=
08:
>
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-7.1
>
> for you to fetch changes up to 9830209b4ae8c8eecae7e6af271cebf1e1285142:
>
>   KVM: selftests: Test MADV_COLLAPSE on guest_memfd (2026-03-04 14:57:27 =
-0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM selftests changes for 7.1
>
>  - Add support for Hygon CPUs in KVM selftests.
>
>  - Fix a bug in the MSR test where it would get false failures on AMD/Hyg=
on
>    CPUs with exactly one of RDPID or RDTSCP.
>
>  - Add an MADV_COLLAPSE testcase for guest_memfd as a regression test for=
 a
>    bug where the kernel would attempt to collapse guest_memfd folios agai=
nst
>    KVM's will.
>
> ----------------------------------------------------------------
> Ackerley Tng (2):
>       KVM: selftests: Wrap madvise() to assert success
>       KVM: selftests: Test MADV_COLLAPSE on guest_memfd
>
> Sean Christopherson (1):
>       KVM: selftests: Fix reserved value WRMSR testcase for multi-feature=
 MSRs
>
> Zhiquan Li (3):
>       KVM: selftests: Add CPU vendor detection for Hygon
>       KVM: selftests: Add a flag to identify AMD compatible test cases
>       KVM: selftests: Allow the PMU event filter test for Hygon
>
>  tools/testing/selftests/kvm/guest_memfd_test.c     | 70 ++++++++++++++++=
+++++-
>  tools/testing/selftests/kvm/include/kvm_syscalls.h |  1 +
>  .../testing/selftests/kvm/include/x86/processor.h  |  7 +++
>  tools/testing/selftests/kvm/lib/x86/processor.c    | 15 +++--
>  .../testing/selftests/kvm/x86/fix_hypercall_test.c |  2 +-
>  tools/testing/selftests/kvm/x86/msrs_test.c        |  4 +-
>  .../selftests/kvm/x86/pmu_event_filter_test.c      |  3 +-
>  tools/testing/selftests/kvm/x86/xapic_state_test.c |  2 +-
>  8 files changed, 92 insertions(+), 12 deletions(-)
>

