Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1002F7EE8
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318687; cv=pass; b=TnqY7aCPxOhNbapsjNhnfbuZXUmvjjxai1ZbbxP+V5Hrl/Ky1YREcR72MjnFoZ1Fc9VMpBZez5Nc+1HBHBURkvxPQRf+pCVBYiYgyEtyHl855MqNKCEziHiRikHFpJhAsAug/cSE0BZWfB2ioND/+9fO7mGLCohQzZR+JhHlOEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318687; c=relaxed/simple;
	bh=2YQBN+nmkvvFhuD/Rgh7VA8+emeoZTJiETXgPH2ynuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZJfPZt6ZC7rwb+9Rq4WwkU4kzOwQu+mRNoQmp5TtNyRy203Mv3qebWLm8jg66VyZNwYbAprn+7G1WGujBkZdfX0ItW0E16hSlsQwKhIwkVAuga2Xhpsyu3kwo5AqhDVrNbOCgYC/nKTM5/GE4QzV6/eY1qhtVIYikewqfey4YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmlX7rlP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhoX+TDG; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmlX7rlP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhoX+TDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782318684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQOMCeDkLTISYEifw5sJoCnj9y0RnfVPgEIfIGjjlDg=;
	b=OmlX7rlPJMiwoD/dBS1QbUI1yEBbk/iPOI4xEzJ8cWKzTEfnl6SHPmTNkZ8i57cEds8K42
	5ReTUVBjbIuCcCwfEzmJnFdLaJgePwHSaeZWcw5gerzGAZfZnhz9ez5N90x9lbxmOkmqxG
	nxP0VH/5wyWs4QEODpOrT8kckkTblzk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-yMDWm0YpOPKlB4J9KxLs9Q-1; Wed, 24 Jun 2026 12:31:23 -0400
X-MC-Unique: yMDWm0YpOPKlB4J9KxLs9Q-1
X-Mimecast-MFC-AGG-ID: yMDWm0YpOPKlB4J9KxLs9Q_1782318682
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4642a5651d4so1214858f8f.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782318682; cv=none;
        d=google.com; s=arc-20240605;
        b=dqM754Vi1u8hlpPghLc56rJSCdO+/mZRQuZiQNOWK9DWTm7rDS5H07JFfFtHq8Ixze
         RanUvWEY+wYwjS46+RShQNkK5/CPwk6r2FGCm6RB5FwQ90wox2cujK5T1q95189H0MbE
         mobnAb8owzm3KPpGtvO9bVfThZaw5zQw/gHSizI6UQBvBQ7bV47NFEwsceI4r2rd82+T
         vIPMS4c+NHwDZ2B5hp4MWf4Qpz+EFZ8FCy32XzB4VaoE/pxsi/Ry/lXYJWBxIt0Fy5Lg
         wZ8fXc+V8CCksArSGlju/TBzR2d4nNkA9mJNy2Dkdv0BZ3ytDQ2HnJ3MmyUliGGQjqX/
         g7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQOMCeDkLTISYEifw5sJoCnj9y0RnfVPgEIfIGjjlDg=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=APsotn8CVeJ2rMsgJ3lwFDDcTnMHTN9NUYyqp5LUOOWNgVkDSs1n0fqvNU1y9BrvCy
         FS7hyETuAUUPKxKA7/1v/IKqG9lnR0kV4Pfsy2zOKxxwR5DajHdY5n2vtNBQBbwd7Umt
         Q3oUNseScqGHXinugsCWfSHQKrfJOLYpzfmOtabvrN9qFD3GPqMbrPzqlD6SAZIA6WHi
         OVrLg66jvcM6Ucb3VVsmjze4qFDJJW51A52UC2D4n5FxLiOrKd3PS6UKd5CDDXU67RcU
         WC6eCndx6YODLE5ILUA3LJMoUh+7yXTtWLVWXhBTBgaIoWvCqXpVEfwUWYxyphiPlsqh
         bMvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782318682; x=1782923482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQOMCeDkLTISYEifw5sJoCnj9y0RnfVPgEIfIGjjlDg=;
        b=bhoX+TDGDP4iKRQuTPT0b3W5YnOtIr7Cj5OBlVVfzOeboxBVTKmU/eVXMX8+X7xoq/
         ZhTD0J+Pyau+GvqObpqLmRkawtheHOuj/HLYpSVui3daAB7kVGMzTHcZlEHXfzlsryQn
         JrX/Xb5d2qCvcSL3jBJ2YuvHaJtFOsq+fQxrV8jujlRoyyIBMtT2ZQYpNgN2YXtINm7/
         gqhp3k2IYqfsdqXTXc7Lxjj1KlG4kwsEhAyA3WkQ/ZLYJ8JirDFGzyCTMWZ2IbEBHziB
         mgYl2y/8Hl8vIrMrlWWlolS0Jg2DKqeapBaK8W+nxCt930fSgloqb1cCbN0ydNMS8soW
         cq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782318682; x=1782923482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQOMCeDkLTISYEifw5sJoCnj9y0RnfVPgEIfIGjjlDg=;
        b=e12He/B7E34LjSZMn5l9rO6BZ/lWKnFEYsFxTVrs9qigXG7YTI4Gf2TeJ/CBbEGnKr
         lZjSjgAPKU6sYuQXUr37QACVyFVyNvvrR79bPVUF26eBFLSp6GrCKId4tgCHh8PxeIOg
         3IdRUPQdlED+8PHDpMuuHPFRfaSb58TuWpdota9ChvCsYUoMupZNDwF+HGoUOL4N8gUX
         kRgg/jy/te5bF4yWqtPgpTSLzOAmM8QiR5DqIc/1e9rRAP/3E7r5/EpJUyf4lWf/wnu0
         Ky/331VSzUso0FZSAyrkPei+tVni1PWihqSKkKvYoPLeXMehSje5X3R13s2ycDVVmTeX
         dC8Q==
X-Gm-Message-State: AOJu0YyyPIEvChy8frXdg33etmsxqIZa2pFt2Fv+WTKd9J0JCqQLZn7R
	3gkuDLtcN2XNpG41tDNilGbxBUtw3fvJ0FVgqa+7T/i7Qpp8nkXDp85C/6ajgDxt8qs7NpsP3tU
	zctQXBG4SCLiVprDXXp3Px7mgOMyqAa3Gdpx+XfZ9TVbck8ijQFNUQZNxr96RpAHhi+JHrwQSl3
	21zMNY4uTv7EbdKA/EhpFgxhOdEchc
X-Gm-Gg: AfdE7ckXCDQVHMN6I8A3xLYBtxikRD87kyZQU785BPfq+AzDNi7Jetp5gPKFyEbHXj8
	SZc3TSNioPDcrJrvv6uL0H/6gQet3IofpYD+oOg/xbz/eMFqpG8RfQoHUxnNBY0hk+d++5hsHdy
	NQvUy9tOMNRBw6ck6y8FVJ5/Mpr8TC0vgwtGbfg1vKf4Gezxfdne9TR57JBjKmjJVWuYNh7tm0W
	Rs1b7m4xkXKxnTnIJkgWZngdfPWfA+McElAD2brQngRlGWtPJGNrLWtvr49mLBlF0Dxj0RR
X-Received: by 2002:a05:6000:41f1:b0:45d:77f4:1ac2 with SMTP id ffacd0b85a97d-46c068f00bamr6805756f8f.0.1782318681860;
        Wed, 24 Jun 2026 09:31:21 -0700 (PDT)
X-Received: by 2002:a05:6000:41f1:b0:45d:77f4:1ac2 with SMTP id
 ffacd0b85a97d-46c068f00bamr6805655f8f.0.1782318681078; Wed, 24 Jun 2026
 09:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624155633.2874939-1-seanjc@google.com>
In-Reply-To: <20260624155633.2874939-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 24 Jun 2026 18:31:08 +0200
X-Gm-Features: AVVi8CeDw7L9PseHVtXMBz6RDRw8N4r1oP69nX6vP0KpoXHT6Xi2TL6Oj4pMXSM
Message-ID: <CABgObfaA2VAmJnHvd1UeHsVMXEdYO4kiwyJN+1tpKCV8eYim6w@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Early selftests changes for 7.3
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 5:56=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> If it's possible to get this into to kvm/next before you disappear on hol=
iday,
> please pull a set of selftest changes that (lightly) touch all x86 tests =
that
> use nested virtualization in any way.
>
> If it's too late to get this into kvm/next, I'd say just ignore this pull
> request and I'll include them in the normal 7.3 selftests pull requests. =
 I
> don't think there will be any cross-branch conflicts to juggle?  But I've=
 had
> these sitting in -next for a few weeks now, and getting them into kvm/nex=
t
> "now" would all but guarantee I won't end up having to play weird games w=
ith
> selftests patches.
>
> Thanks!

Sure; placed on kvm/queue for now as well, I'm building a kernel to
test the rest.

Paolo

> The following changes since commit ef057cbf825e03b63f6edf5980f96abf3c5308=
9d:
>
>   KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping=
 level (2026-06-16 00:39:57 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests_l2_stacks-7=
.3
>
> for you to fetch changes up to 70f4701c12e4bb6214f0ec762f928e96ff3dacc3:
>
>   KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only bi=
ts (2026-06-17 17:56:17 -0700)
>
> ----------------------------------------------------------------
> KVM selftests for 7.3, early edition
>
>  - Automatically allocate a full page for L2 guest stacks on x86 instead =
of
>    requiring test-specific L1 guest code to carve out a portion of the L1
>    stack for L2 usage, and to ensure the L2 stack also adheres to the x86=
-64
>    calling convention ABI.
>
>  - Add a selftest to verify {Guest,Host}-Only behavior in x86's mediated =
PMU.
>
> ----------------------------------------------------------------
> Jim Mattson (1):
>       KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Onl=
y bits
>
> Sean Christopherson (1):
>       KVM: selftests: Add a helper to query enable_mediated_pmu module pa=
ram
>
> Yosry Ahmed (3):
>       KVM: selftests: Refactor allocating guest stack into a helper
>       KVM: selftests: Allocate a dedicated guest page for x86 L2 guest st=
ack
>       KVM: selftests: Drop L1-provided stacks for L2 guests on x86
>
>  tools/testing/selftests/kvm/Makefile.kvm                         |   1 +
>  tools/testing/selftests/kvm/include/x86/pmu.h                    |   6 +=
++
>  tools/testing/selftests/kvm/include/x86/processor.h              |  10 +=
++++
>  tools/testing/selftests/kvm/include/x86/svm_util.h               |   5 +=
+-
>  tools/testing/selftests/kvm/include/x86/vmx.h                    |   4 +=
-
>  tools/testing/selftests/kvm/lib/x86/memstress.c                  |  19 +=
+-------
>  tools/testing/selftests/kvm/lib/x86/processor.c                  |  45 +=
++++++++++----------
>  tools/testing/selftests/kvm/lib/x86/svm.c                        |   6 +=
+-
>  tools/testing/selftests/kvm/lib/x86/vmx.c                        |   6 +=
+-
>  tools/testing/selftests/kvm/x86/aperfmperf_test.c                |   9 +=
----
>  tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c        |   5 +=
--
>  tools/testing/selftests/kvm/x86/hyperv_evmcs.c                   |   6 +=
--
>  tools/testing/selftests/kvm/x86/hyperv_svm_test.c                |   6 +=
--
>  tools/testing/selftests/kvm/x86/kvm_buslock_test.c               |   9 +=
----
>  tools/testing/selftests/kvm/x86/nested_close_kvm_test.c          |  12 +=
-----
>  tools/testing/selftests/kvm/x86/nested_dirty_log_test.c          |   8 +=
---
>  tools/testing/selftests/kvm/x86/nested_emulation_test.c          |   4 +=
-
>  tools/testing/selftests/kvm/x86/nested_exceptions_test.c         |   9 +=
----
>  tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c        |  10 +=
----
>  tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c          |   9 +=
----
>  tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c         |  10 +=
----
>  tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c        |  10 +=
----
>  tools/testing/selftests/kvm/x86/nested_vmsave_vmload_test.c      |   6 +=
--
>  tools/testing/selftests/kvm/x86/smm_test.c                       |   8 +=
---
>  tools/testing/selftests/kvm/x86/state_test.c                     |  11 +=
-----
>  tools/testing/selftests/kvm/x86/svm_int_ctl_test.c               |   5 +=
--
>  tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c           |   6 +=
--
>  tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c     |   7 +=
---
>  tools/testing/selftests/kvm/x86/svm_nested_pat_test.c            |   8 +=
---
>  tools/testing/selftests/kvm/x86/svm_nested_shutdown_test.c       |   5 +=
--
>  tools/testing/selftests/kvm/x86/svm_nested_soft_inject_test.c    |   6 +=
--
>  tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c          |  13 +=
+----
>  tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c        | 215 +=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++
>  tools/testing/selftests/kvm/x86/svm_vmcall_test.c                |   5 +=
--
>  tools/testing/selftests/kvm/x86/triple_fault_event_test.c        |   9 +=
----
>  tools/testing/selftests/kvm/x86/vmx_apic_access_test.c           |   5 +=
--
>  tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c         |   4 +=
-
>  tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c |   6 +=
--
>  tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c     |   5 +=
--
>  tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c      |   5 +=
--
>  40 files changed, 323 insertions(+), 215 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_te=
st.c
>

