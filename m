Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A67383333
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046994; cv=pass; b=m3iENvoc7LaX/cm+RV/a4m0bt1VG0B3TtlSuuZtlNruswOQ9vc59+ZwDFFK5VqPtnJTgNQvLIzQ6zYQNFltsCwBv+8AMZl039VUb1y4lB2nauwbJjx9vaWlfI5M9rLPXylXWa/rW//dXM6wrFAljoXnfn1xYxNPM9e4fATiqu/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046994; c=relaxed/simple;
	bh=nxcBcIIu8q5gjVlpoqJK0T82KS5DXH91pbYJkPqLAyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvOQg+RpAZdDnKP718nc695PdgYNH4Vb7ZfoVyzLKyFVPE/sCMIQqruKiV3IdbbrhDe98t/3NGSKrDy2yBV/KR+xQI6vHivOdS5WD3lvSzkqwBJE0sozx/jdaM7LuZZ3j06peK0PRlcQYU7dgrv3IvjTgZsawXhs3/xiM0VhEug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OttL4iFp; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OttL4iFp"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso30574095e9.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 20:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790046989; cv=none;
        d=google.com; s=arc-20260327;
        b=AnggvqhFaYDtM/nzyRjWkMsCSsm4tj/H8Tav2GKiVWruAHRsTZiEmSZIrSluL1mmmq
         hjWwV4TsSUrOSw+zYNxrMgbwb5f3TQviQzgOWgcMtqmLX0gg+kLK/MCh/bYcus2+QjVN
         GPemgCOBcz7/P5oHee+tA9A77ylNCgyttzb7GxCInO6BzboVV+WuO6rW4eKZabGMfAv8
         y2UI65PeyxQE5XWPp0S3HTT7I5N0a0NMCwdEZU72n5RmbtgPtVP2R9aMF1h9zO5lL3ms
         RjyDPgddO7QS8UG/trC7KgyJJeHAneVwCnqoSy4adSaokCrbYSMN2DEmcO8G6FnYpSIy
         wPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T0hVWGyySlLly+28D7LGfZKDh0uXJmKT1sB0yr2I6gM=;
        fh=CX0mdOvy8McEFIBpcUX9jbW9EBpvcsYky58/gKrhrmU=;
        b=TurGX5pISB+uSn/Kv8r9MdMOffF/HR8L9WbBVZotJEEhAkyzv99qbEEmYBVHoQiaoL
         Mm+vBf1Z6U1lOlKp9PA/S8girup8k0j0UvO7jNVcffOJE+DFJQXSfTkhzzhSOGV3YCZr
         e+Sox3ZuNndBMlxLSF2GovzOCAw3lo+LpCKrE44mjceMLTI7fuVtmJhLw+aulMayFWZW
         DmZk1wALVK0kLKnAY4DhSB9wgl2SexoNRVkJF3ZmJKLD8yFhU4tqiPWQ2QKoKmTKRQgG
         f+74kz+lb6NvTiNo4rudi8az6bxFmvsDN7BHEujHtPmBjCWgoGhplnvHaqo7rQLY4rFq
         8CCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046989; x=1790651789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T0hVWGyySlLly+28D7LGfZKDh0uXJmKT1sB0yr2I6gM=;
        b=OttL4iFp1xOGLN3gQnlMB1tq0xJngLmH/krKaax6xy5z4RxYekCTxh9Pp5E7snJIS8
         ZobS1E0MjajLMNyvFy7990rcYKr++EK/BWqlFO10y85xevVnAspMQkzcxXzPTMmBUn16
         O0G3myRMed/g5rzaHBAU3uWu/wfB21Dcma6GjYJPOPLx7aR9vC0WtB94c3WyUTdrpnoa
         H4qtZJ+iHtgMcAK09zQLOy0AZ4jCix0Ts7e+HOLW6ZGtcTJ0I4WtsWreqCdP5gC4ZD2G
         UAIvrnTEZ2sjIyjTwWzRwKmDL02BxsXALzX3e57Rz67SZ57uoZZTMabSsbMu01Fj6Hhi
         yRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046989; x=1790651789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0hVWGyySlLly+28D7LGfZKDh0uXJmKT1sB0yr2I6gM=;
        b=MAmEYrVfw2Tfe22xqQw2sFZmLGsgN+ybCZD2hcUxEKPLGjGmXqRcliQTf229tz0U2f
         qJftp3lynbbYRYQBECAcRi6MWc+rp5jrdj98LcdGjq72J50nI3hGQDnjkkcts1wY/sfr
         j34Hz7fFR7FWFdp0fbLNoqcoNCkkw4+Rsi7/uHdNPUUV6Ca612op2EOLa+x3vkT7NFWz
         +rLK9UckjeIwao+vNAP114AsgNTFieWVMmwLSoaGri12q+A8y/9jvpklRTP2X5smChpm
         gjhGBqB+lnGrGtAl18rABHTYwLBsyW4Guh3ZoSfx1yGYISvpxSFIVAjHDsCnIbyarIow
         xkwg==
X-Gm-Message-State: AFuF++lVuVSlWXHboMoZ4ZyiDX/62gLxkvkBw7M2bD40wRUGArmRukBg
	5pZgQzgTh/qAQAEq60RxXEc6fJEvFemXrK+BjCLJAK0KZHZfanEuz4hEWcsMYiTx02EdvwKMjW4
	3DLlMZmaPPwgfUst04W+QtRV0EjzYEe4=
X-Gm-Gg: AYBFou3h2nWz6JJeepXsbATf2Gw6myhLxw3ZCKRkzjholeCJpTXCubvcbQQhn9ImZ9n
	4ZFixE72mMac30vDZTqxpX+xBjnfhf0UAv2lqzlVVJNM+R8bDd8ujYSFwrgDKDKBINNmC1/uao6
	sllxO9WDauIeZtAg6LWECnEG0Kq5B1z+POEZcGda3CLRCTj75quQVhWbcXzED20xVknvpQ8o9yF
	vHjNWZk7nSFfn036oOrH+etUklP33V+pUF7xVvYFO39jHJE5fUmi5IwzBwT6oxEFMm7wdavNx4P
	GfVXpsl5AVXnJYW0T/NtK/pQmu0lr7B6gbb4FK9Jf1oUeEJUHxbhCgVvg9y1293aa9uS2KQceI1
	qwqX7DeBQuolORQ==
X-Received: by 2002:a05:600c:46cc:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-49fc566951dmr171043015e9.7.1790046989155; Mon, 21 Sep 2026
 20:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920211920.928306-1-dwmw2@infradead.org>
In-Reply-To: <20260920211920.928306-1-dwmw2@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 22 Sep 2026 11:16:17 +0800
X-Gm-Features: AcwNN1WrYNyWGp1bGXe-bJN9POYZPs3FjeCDYohf8fnVdXEdiDT26MiduZxqtjc
Message-ID: <CAN_Opa9YWJZxr=YEjnkS-Khm=83P-xqGVZ6tq2nVQzMNOiThbg@mail.gmail.com>
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Paul Durrant <paul@xen.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Zqiang <qiang.zhang@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Keir Fraser <keirf@google.com>, 
	David Matlack <dmatlack@google.com>, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for the series. I noticed the testing results, but didn't see
a performance comparison for the SRCU change itself.

Do you happen to have any numbers comparing the GPC invalidation
latency with regular SRCU vs. `synchronize_srcu_atomic()`? If there
are also numbers with the reader-free fastpath, that would be useful
for understanding its impact as well.

No need to run anything specifically if you don't already have the
numbers.

Thanks,
Kunwu

On Mon, Sep 21, 2026 at 5:19=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> Now that Paul et al have so kindly provided atomic SRCU for us, it would
> be churlish not to use it.
>
> Based on the merge of kvm/next (d4b7fb647204) with Paul's dev.2026.09.17a=
=C2=B9
> as posted last week=C2=B2, this series:
>
>  =E2=80=A2 Converts the GPC to use atomic SRCU, ditching the rwlock which=
 was a
>    scaling and latency problem, and which PREEMPT_RT hated because it
>    turned the rwlock into a sleeping lock.
>
>  =E2=80=A2 Cleans up the intentional lack of dirty-tracking of Xen shinfo=
 and
>    vcpu_info pages (Sean).
>
>  =E2=80=A2 Converts steal-time / preempted status to use gfn_to_pfn_cache=
. (Carsten)
>
>  =E2=80=A2 Reinstates guest-mode pinning: replacing the old GUEST_USES_PF=
N mode,
>    letting nested state pages be cached and pinned while in guest context=
.
>
>  =E2=80=A2 nVMX: Uses GPC for the L1 MSR bitmap, and guest mode for APIC =
access
>    and vAPIC pages. (Fred)
>
>  =E2=80=A2 nSVM: Uses GPC for vmcb12 / MSR-permissions / IO-permissions p=
ages. This
>    cuts the vmcb12 transition cost measurably (selftest included).
>
>  =E2=80=A2 Returns -EAGAIN from cache lookups which race with memslot upd=
ates,
>    and re-posts KVM_REQ_GET_NESTED_STATE_PAGES on memslot generation
>    bumps so pinned caches are revalidated lazily.
>
> Tested: rcutorture atomic-SRCU (srcud, reader_flavor=3D0x10) on three
> hosts; KVM selftests including new invalidation and transition tests;
> >1 week soak of VM lifecycle + invalidation reproducers on 128-way
> RT+KASAN+lockdep, 192-way RT and 192-way PREEMPT_DYNAMIC hosts. And
> booted an actual Xen guest in QEMU a few times...
>
> =C2=B9 https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.=
git dev.2026.09.17a
> =C2=B2 https://lore.kernel.org/rcu/20260919003521.3134552-1-paulmck@kerne=
l.org/
>
> There have been previous series which attempt to deal with various parts
> of GPC locking, and the steal time one has definitely been posted before
> a few times, but let's just call this v1:
> https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Dref=
s/heads/gpc-srcu
>
> Carsten Stollmaier (1):
>       KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status
>
> David Woodhouse (10):
>       KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
>       KVM: x86: Request the guest TLB flush from record_steal_time()
>       KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)
>       KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid me=
mslot
>       KVM: x86: Post KVM_REQ_GET_NESTED_STATE_PAGES on memslot updates
>       KVM: x86: Move nested GPC lock helpers to x86.h as kvm_gpc_lock_pag=
e()
>       KVM: nSVM: Use a gfn_to_pfn_cache for the vmcb12 page
>       KVM: nSVM: Cache L1's MSR permissions map pages
>       KVM: nSVM: Cache L1's IO permissions map pages
>       KVM: selftests: Add nested transition benchmark
>
> Fred Griffoul (3):
>       KVM: nVMX: Implement cache for L1 MSR bitmap
>       KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages
>       KVM: selftests: Add nested VMX APIC cache invalidation test
>
> Sean Christopherson (3):
>       KVM: x86/xen: Extract delivery of event to vCPU into a separate hel=
per
>       KVM: x86/xen: Explicitly tag "shared info" page as never being dirt=
y tracked
>       KVM: x86/xen: Don't dirty track "vCPU info" page
>
>
>  arch/x86/include/asm/kvm_host.h                    |   2 +-
>  arch/x86/kvm/msrs.c                                |   7 +-
>  arch/x86/kvm/svm/nested.c                          | 112 +++-
>  arch/x86/kvm/svm/svm.h                             |  16 +
>  arch/x86/kvm/vmx/nested.c                          | 356 ++++++++++--
>  arch/x86/kvm/vmx/vmx.c                             |  11 +-
>  arch/x86/kvm/vmx/vmx.h                             |  16 +-
>  arch/x86/kvm/x86.c                                 | 181 ++++---
>  arch/x86/kvm/x86.h                                 |  33 ++
>  arch/x86/kvm/xen.c                                 | 279 +++++-----
>  include/linux/kvm_host.h                           |  86 ++-
>  include/linux/kvm_types.h                          |  52 +-
>  include/linux/srcu.h                               |   7 +
>  tools/testing/selftests/kvm/Makefile.kvm           |   2 +
>  .../selftests/kvm/x86/nested_transition_bench.c    | 204 +++++++
>  .../selftests/kvm/x86/vmx_apic_update_test.c       | 299 +++++++++++
>  virt/kvm/kvm_main.c                                |   9 +
>  virt/kvm/pfncache.c                                | 596 +++++++++++++++=
++----
>  18 files changed, 1876 insertions(+), 392 deletions(-)
