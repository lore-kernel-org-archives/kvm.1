Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C93A75B8
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051890; cv=pass; b=Qww99MmJBnXTY/w5gQEWXrwGc8Mw9tt0+STUj10ML4ig29VwsY34Q0xAO6KcslAqLIXtlb9tgN+wifcAYcyDRWUdQWrKkk7gO9Na9e0IVp3NPUlIzcQQBab1lf6h6XrbWBR19Di0R8YQ8/JHXe8nmqOkv6I4aaH4A8GmVUhDrEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051890; c=relaxed/simple;
	bh=bYhSjLf5WrSoCs/E/8lvKysNkSO2u4ZmPv8HYT3BhVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6zCE5T+ePCUb1EH6xOYHfB0/QhbGvi+urEMse7Km9RHEDPS6+Oe8NLjeF62Ex2MU7Dbxt1lO8ZMVpujnibUR46TyXN3w8LrD/PiL+VLCr82R5bJEYKawdUdES7NftEtTb5Ru8qZ/Sr+cyOJnyKto2lXockpJWFFudBoM1zgo0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkanmpDx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sfinb5vs; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkanmpDx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sfinb5vs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMVr2MEZLG1T0pxhT+eh8Oo5NondvJT+SQtFk5sRheo=;
	b=SkanmpDxKdj4/A/6fNfZB/FcchTD+YLv7u8QLeigCie1JqY7H/j2eSHk36DzHONGN7rRLH
	lZMuizFSaLb8qcUf+Ves6ogjbEP2BwaP2QUS8AAh/Xk3LPpTLZE0wPnydGdJkrxcMHV9Op
	t/IW8g0qHESzzBNhYPqmB0+z4Y8mNlI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-xJQ000D5OJufQVy04xRY5g-1; Tue, 18 Aug 2026 07:18:05 -0400
X-MC-Unique: xJQ000D5OJufQVy04xRY5g-1
X-Mimecast-MFC-AGG-ID: xJQ000D5OJufQVy04xRY5g_1787051885
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767b782so34245105e9.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787051884; cv=none;
        d=google.com; s=arc-20260327;
        b=YXwfewTPFGqplu4KzD6fVR11r1EmqxQrHgrZtWZqHbfSEan15fsOMo3g6lajONqRYc
         rtetFDuWY5rI5yJEQNc+IeXPWNa69k4ps8tof41xvl/KiZtzSD17GiFyTTCo8syZwe02
         esPPz1O6j6YoU8aVJzm5ssWOYhGPXyfcumWJmnELKZD+U4L6TdrSqlvAOJtSc1bdN0ON
         8GNxefQUyb5G1BQ90oL2S1IXRMjlFArvk5TQOKscP46nbaxPwV4c2ebnbqf31kTtr6J9
         +axpm8R0fHC+hKMIJhsS/h0pqNE3ZQoSpUwNrvCGU4SN4J1ORbVkg46LV+LsJkAs9gmU
         2zQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pMVr2MEZLG1T0pxhT+eh8Oo5NondvJT+SQtFk5sRheo=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=EyZIFAqAZeB86cQCvtgHfM5BbFfN80+QRUKcJcROtxg81bD2jLy5cBwKz7o8nu+yvJ
         G3NOI0r5dLToLLjgBKmf7I8CMWKMdrAW1fEw4xuBDFdw6MB8AYFBaq9nb0C3uwNL7dXd
         MoYPbftMH+Xly8m/dYnnut1KblqPGaLjV6UmSl5Zt9YZu7vbvVlVoss7VwIvrCywjpw+
         WtwZXATqRjLK8PXa6wnJ4z+JETFuO9Ry6adQhWuFWFmH6T2VkQvjTzwVHiG7HPv/odcl
         ZoTVw6rNt43NJP+eSIaufM15oPIJwOGrzrVi3f7wf19ri6iskGKxkzU8bTFNB4qqmM7j
         YHjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787051884; x=1787656684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pMVr2MEZLG1T0pxhT+eh8Oo5NondvJT+SQtFk5sRheo=;
        b=sfinb5vsWQlhCzVZOhMDvDLJKtbVcSNuoQaYuE0rzH5ovjROHYgC4FOYDQBXdezu9g
         KHq7g6Hicy24I+9DXhWtnTKLZWb5rCPxw+4JdUrDz5vImq6j7GjUzXRvRk5jmtrpR5v9
         NPRGqN5RmwlWQynIlQ0ziPWI/AbKPRmAXuX6sUvJBBWzSpSNQvpz2Nrp7fG1Kw+MxKLy
         JzNk5qqq0xj5fyXSLAD5pODdfykdr7Z7fAn8aBNzhS+kvLpXHrl0fY2L2pLsTgcvZEgX
         /fev96/F0c1WYSYvgp9kv7p1S96K3jOgscKTSn1X0u4YIPxuiA7qf9/2FPuwSIyqxwtU
         CrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051884; x=1787656684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pMVr2MEZLG1T0pxhT+eh8Oo5NondvJT+SQtFk5sRheo=;
        b=AAfhhOTube/Cw85tb4Irin/GLODCLVTCMK0/YmZurQAnsjkTyUkaXX5ISC7Aj7GX7R
         VamjxYcTHGhoA0FkeZxj10oBgpaC7LseNaYDHDQJGPdBodQ2HpVUyKhiekD88IRW0hxC
         CE3GBoT31UgI8BieFO8MEBZHATppv9BkOOOW2IJk8Tw2fIm758TnoZ+kdcwYHZIeyD2K
         0buhO29yVAYilpZM9+rVIj4iyWxgeigpTyb7+cMbo9DgL40k0iNJMUTz3biGGrImPvgp
         mtYAvW5aEWuLU8BtDJmGVERW6YwIVRouCHLRH3Gr9JXhE6o/YtyFLDtqVP6+UK3ud/Uv
         zgxw==
X-Gm-Message-State: AOJu0YwVePMl+IIQ8bgUi+Hy/WDTVNXddpMO9exKtJLcso4DucubN0pg
	oGQ64mXHOq1W39wq+l/2g9gGq1FEbWR5HiXsuaNbygz2u0YnqGV2RKyLkbwhM2AeLVWJ5/85GIg
	zHV4cejc8lnTGeu0G1kOAooSGRGioGMjW3unalipfHM8XF68i92WoH20CIeXb5cAOvQZEdnuWOy
	Z0J+wvGB2x8MvY9WGHMKHLbmjyl2d9
X-Gm-Gg: AR+sD10AuiDGFAgFUjV0u7cEb74f4f+h3yFVqsyEbZyqIh4K00V5wMgDMI8+5Ep+Pei
	gWDxq9o6f1QNmOUQKlYggN3pX2Qh6ko89BLbMmfneJJpyd/WNxumFo9QAII9YECR1To2MSfFb5M
	jwoF80wBvl/3tztK4NfayBSdbPzGNsjtb1GYT+fsa5+/xD4KbvDAZjucWCKHOGHOhfAmh4GtbAc
	20n+ollnlhS1a1239pBYT5L2LuIVEwW3Lr9v2O03msl4Yu1q4JEAIhAiKs=
X-Received: by 2002:a05:600c:5307:b0:499:8c68:a3aa with SMTP id 5b1f17b1804b1-4998c68a830mr537492735e9.13.1787051884459;
        Tue, 18 Aug 2026 04:18:04 -0700 (PDT)
X-Received: by 2002:a05:600c:5307:b0:499:8c68:a3aa with SMTP id
 5b1f17b1804b1-4998c68a830mr537491065e9.13.1787051883983; Tue, 18 Aug 2026
 04:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com> <20260812213206.1564354-8-seanjc@google.com>
In-Reply-To: <20260812213206.1564354-8-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 13:17:52 +0200
X-Gm-Features: AcwNN1VqQAePVv83itLSpe1FLCvt4fRq5vI6bOtkcO6v-qRCJZNpNiVaN8tKnOw
Message-ID: <CABgObfY8vwGngi9SzFcO5=8eiAeQr4D0G5Zwd85mFg23712JBw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Selftests change for 7.3, part 1
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:32=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> This was supposed to be the "main" selftests pull request, but it ended u=
p being
> about half the size of the second pull request.  Yosry's work on the nest=
ed
> virtualization infrastructure is by far the most notable thing here.
>
> The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f3=
70:
>
>   Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-7.3
>
> for you to fetch changes up to b18ee21055a77eb1fb6070cb3f819cd3372c466e:
>
>   KVM: selftests: Add a test for KVM_CREATE_VM VM type enforcement (2026-=
07-31 15:47:25 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM selftests changes for 7.3, part 1
>
>  - Clean up nested SVM's handling of GPRs on L2<=3D>L1 transitions, reuse=
 the
>    functionality for nested VMX, and drop the ucall hack that was fudging
>    around the lack of GPR switching on nVMX.
>
>  - Add a stress test to verify KVM doesn't clobber/drop #PF state, e.g. C=
R2,
>    across save/restore, including when L2 is active.
>
>  - Add a test to verify KVM_CREATE_VM accepts exactly what is reported by
>    KVM_CAP_VM_TYPES.
>
>  - Misc selftests fixes and cleanups
>
> ----------------------------------------------------------------
> Hemanth Selam (1):
>       KVM: selftests: Add a test for KVM_CREATE_VM VM type enforcement
>
> Sean Christopherson (2):
>       KVM: selftests: Drop superfluous use of pthread_attr_setaffinity_np=
()
>       KVM: selftests: Randomize pCPU in steal time test
>
> Shivank Sharma (1):
>       KVM: selftests: Fix typos in x86 and riscv tests
>
> Wang Yan (1):
>       KVM: selftests: Fix a spelling error in an xapic_ipi_test comment
>
> Yosry Ahmed (13):
>       KVM: selftests: Use __stringify() instead of custom XSTR() macros
>       KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
>       KVM: selftests: Rework GPR registers switching for SVM (and fix off=
sets)
>       KVM: selftests: Handle rflags save/restore for SVM in guest_regs
>       KVM: selftests: Reuse GPR switching logic for nVMX
>       KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
>       KVM: selftests: Add a blank line before logging assertion failures
>       KVM: selftests: Expose PTE masks to guests as part of an MMU
>       KVM: selftests: Do not intercept #PF by default in nVMX tests
>       KVM: selftests: Add basic stress test for save+restore and #PF hand=
ling
>       KVM: selftests: Trigger save+restore randomly in the #PF stress tes=
t
>       KVM: selftests: Support running stress save+restore and #PF test in=
 L2
>       KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF te=
st
>
>  tools/testing/selftests/kvm/Makefile.kvm           |   2 +
>  tools/testing/selftests/kvm/include/test_util.h    |   1 +
>  tools/testing/selftests/kvm/include/x86/evmcs.h    |  46 ++--
>  .../testing/selftests/kvm/include/x86/processor.h  |  52 +++-
>  tools/testing/selftests/kvm/include/x86/vmx.h      |  69 +++--
>  tools/testing/selftests/kvm/lib/assert.c           |   2 +-
>  tools/testing/selftests/kvm/lib/x86/processor.c    |  14 +
>  tools/testing/selftests/kvm/lib/x86/svm.c          |  62 +++--
>  tools/testing/selftests/kvm/lib/x86/ucall.c        |  32 +--
>  tools/testing/selftests/kvm/lib/x86/vmx.c          |   2 +-
>  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |   4 +-
>  tools/testing/selftests/kvm/steal_time.c           |  15 +-
>  tools/testing/selftests/kvm/vm_types_test.c        |  48 ++++
>  .../selftests/kvm/x86/evmcs_smm_controls_test.c    |   5 +-
>  .../testing/selftests/kvm/x86/fix_hypercall_test.c |   1 -
>  tools/testing/selftests/kvm/x86/hyperv_clock.c     |   4 +-
>  tools/testing/selftests/kvm/x86/hyperv_evmcs.c     |   2 +-
>  .../kvm/x86/save_restore_pf_stress_test.c          | 288 +++++++++++++++=
++++++
>  tools/testing/selftests/kvm/x86/sev_init2_tests.c  |   4 -
>  tools/testing/selftests/kvm/x86/smm_test.c         |   5 +-
>  .../kvm/x86/vmx_invalid_nested_guest_state.c       |   2 +-
>  tools/testing/selftests/kvm/x86/xapic_ipi_test.c   |   2 +-
>  22 files changed, 502 insertions(+), 160 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/vm_types_test.c
>  create mode 100644 tools/testing/selftests/kvm/x86/save_restore_pf_stres=
s_test.c
>

