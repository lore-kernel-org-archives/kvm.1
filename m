Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0AF37B022
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787501; cv=none; b=jWR99NHLppEo/XXX5zzJWBuLmqW+o5nN3g5gV6/HMe+o/3/egJQeE85A7wVHEuQT+2rNjN2u3eXhl0+XbD5UGSDLxwn0yeU1/G0hMzrae3393S1PfZ91NLssukUx5VYjRak2lw6rDClnW+l253LgoalfDkTjbMZ+nzRl4MBGKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787501; c=relaxed/simple;
	bh=5tBZ0Lp6Mtupk3SqAudUdIW44a3ph9FaTgWVVua/8yM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u6tMb/PKLZLeMmjCsuO2SJ1zLH3RQmKbyQohgNkLAog1b4LYVGusX31SC07Vet4rNI2Gs/z3eXA12LFLsUjy6S7FiYjUHiKRnjGG19cZfYL9Reqb6Wt1hDToaba1a6Ai5ozDSy2FfgsJXEGSEltjEn/gOZx+iYZnWjGC02LtX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0fCJVtG; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0fCJVtG"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc6dd43737so21949585ad.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787500; x=1788392300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HC0L0IhxTSjXe4UbRtdaQNXjymrT4RVRL+ppaVsTI8g=;
        b=k0fCJVtGzhX4RY8ovUzSX1t1FeGLbP3eM/njYU15xa/h7uI0DFb0p38en5XfO4sMHN
         YaOikFeSSkmYwhVT27XYokdFqPpzei6s8MwSDliH6j/WeA34rQd29Z4pXYP8jBoAZ3nj
         25g1l7WpCx9z9DqMxRToqa0TTBFMzjTS0v+p3vbiBxBwbIWZsJFsDN3gQC1a0p2E3GnS
         YiOsf9m/yMp8prAp2Fc4WndPScWku/cbylOARMDYxqfwV6rerHUbg/I6mo8aOecZD0MF
         3clOjYylSsbEYlQ63q2rq3Sbq261UpnbD0cz7BS4ksIIz0najfznd13smBU+Hw02YRSu
         rGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787500; x=1788392300;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HC0L0IhxTSjXe4UbRtdaQNXjymrT4RVRL+ppaVsTI8g=;
        b=If7wMlfJq/M7EHmCNaYAtmEyLc8kxiWl+lC39uB2xbHkQnvZmyLjjv5F5dn2ozMEgF
         j02549yfSxzDuYW6r1ZGyGnt1xf1E0m4u4RtSU2ylbjm5m+uE+wAJMVZ/lu92n6xBFbW
         hSEFOrZTtUZ4igFBl7ViWzQF9RwkjoiA8RT+cWTk165W7vNvn0RqOpmZH0q00dqKF0Wi
         4sHLi7BNs7JR8XqiB5dDv5VjSnvdzQU4bTlQHMQU7hw6oFk8WNTuXvOmr94gZ9XzRaV6
         1ODKqB+nTLRARoL1WTslJQG+lH4XbBF3uBKfLUhlh6/Nf7Cp3JpSkmn/LG+LCSe8OPd4
         uY8w==
X-Gm-Message-State: AFuF++moZP0FBJ3o5fSth8k/3sWHetvMlabIGl65olq2H9xbB0x20/pu
	cDD+mw00Y0nB0dQlRrP2QVG8P2P78pCJht7K2tUDlK/dzUUkVNkqHUXPIhh4KnEFAoqkKS6bX6G
	1EJbHEA==
X-Received: from plfn17.prod.google.com ([2002:a17:902:e551:b0:2d3:2362:d799])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78e:b0:2c9:deec:f564
 with SMTP id d9443c01a7336-2d707c0d370mr139890095ad.13.1787787499444; Wed, 26
 Aug 2026 16:38:19 -0700 (PDT)
Date: Wed, 26 Aug 2026 16:38:18 -0700
In-Reply-To: <20260826232224.782021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com> <20260826230511.972824-3-seanjc@google.com>
 <20260826232224.782021F000E9@smtp.kernel.org>
Message-ID: <ao946gGsIkSkEwAs@google.com>
Subject: Re: [PATCH 02/20] KVM: selftests: Bump the minimum GPA for page
 tables to 0x200000
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Marc Zyngier <maz@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+LoongArch folks (question below for you)

On Wed, Aug 26, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/tes=
ting/selftests/kvm/include/kvm_util.h
> > index 5a7a455b53875..70906a0d1003c 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -175,7 +175,7 @@ static inline struct userspace_mem_region *vm_get_m=
em_region(struct kvm_vm *vm,
> > =20
> >  /* Minimum allocated guest virtual and physical addresses */
> >  #define KVM_UTIL_MIN_VADDR		0x2000
> > -#define KVM_GUEST_PAGE_TABLE_MIN_PADDR	0x180000
> > +#define KVM_GUEST_PAGE_TABLE_MIN_PADDR	0x200000
>=20
> [Severity: High]
> Does bumping the minimum GPA to 0x200000 cause the guest page tables to o=
verlap
> with the VGIC redistributor on ARM64?

This is definitely a Marc/Oliver question.  FWIW, I didn't see failures on =
arm64,
but I also have no idea if the hardware I was using supports the v3 tests, =
so
it's entirely possible this is a real and obvious problem.

> In tools/testing/selftests/kvm/arm64/vgic_init.c:subtest_v3_redist_region=
s(),
> the redistributor is hardcoded to be placed at the same address:
>=20
>     addr =3D REDIST_REGION_ATTR_ADDR(2, 0x200000, 0, 0);
>     kvm_device_attr_set(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
>                         KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr);
>=20
> Because KVM maps the redistributor over memory, wouldn't the hardware MMU=
's
> stage-1 page table walk attempt to read page table entries from an emulat=
ed IO
> region?
>=20
> This seems like it would cause a stage-2 fault that KVM cannot handle for=
 a
> stage-1 page table walk, leading to an infinite exception loop.
>=20
> Additionally, does starting allocations at 0x200000 severely reduce the
> available memory in memslot 0?
>=20
> In tools/testing/selftests/kvm/lib/kvm_util.c:vm_nr_pages_required(), mem=
slot 0
> is sized to be just slightly larger than 2MB:
>=20
>     nr_pages =3D 512;
>    =20
>     /* Account for the per-vCPU stacks on behalf of the test. */
>     nr_pages +=3D nr_runnable_vcpus * DEFAULT_STACK_PGS;

Ugh, right, because this doesn't change the base of the memslot.

Why does LoongArch use 0x200000 instead of 0x180000 as the base?  I switche=
d the
common macro purely because I thought it would be the path of least resista=
nce,
but maybe "fixing" LoongArch to use KVM_GUEST_PAGE_TABLE_MIN_PADDR is easie=
r?

> It seems like this leaves only a few pages for page tables. If a test has
> multiple vCPUs, wouldn't it exhaust this tiny pool and trigger the abort =
in
> tools/testing/selftests/kvm/lib/kvm_util.c:____vm_phy_pages_alloc()?
>=20
>     enomem:
>         fprintf(stderr, "No guest physical page available, min_gpa: 0x%lx=
 "
>                 "page_size: 0x%x memslot: %u\n",
>                 min_gpa, vm->page_size, memslot);
>         fputs("---- vm dump ----\n", stderr);
>         vm_dump(stderr, vm, 2);
>         abort();
>=20
> > =20
> >  #define DEFAULT_GUEST_STACK_VADDR_MIN	0xab6000
> >  #define DEFAULT_STACK_PGS		5
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826230511.97=
2824-1-seanjc@google.com?part=3D2
