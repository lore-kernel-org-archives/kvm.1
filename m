Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3F2F5A0E
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510566; cv=pass; b=iKF4KFIOFSYFkLDxYuPkkOsz3zBLRxOHSJdhdPIYQbgvgtKFPAJqDuI1sAb7NjchasFXAhd78sNTbilrYLrDE6cQVAAFl3qGIDViQVbN2qeVwbaeCY25L0Fg0Wj62AiV7zWCtJRYUyECGZ5U6GNPrsUl6ATZRFKW+XswB9jnE4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510566; c=relaxed/simple;
	bh=0+IeSPqNw2KbqfGmFRu0WOwcVJjzIsJn1LgqgmtBNR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6QV2oAvdgAZaFyYXFtZyfaD/gfml5XNFthERhi6+SKGnoicqhQ/dScBS+sqOMIaXioH6L1FmhjmaROLtqv4mP5duaYw/r4KGvxuU04gWwmHlbLSapaNb8sFUYnC2QogLW9Mus7ZeJbvGlwlLAD4o5NaVUYPKQ1Y2p+rFV7SHAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g7JtCvfS; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7JtCvfS"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso49345e9.0
        for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 11:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787510562; cv=none;
        d=google.com; s=arc-20260327;
        b=PFMMI5wJHjFKWFr3B+f8JVOwNx8Xkl/eSgs1If9dcPouyQQAtrrMx1VXwuFBpVymGU
         m+0NPIdKFowRufZr+1JY3QowKeiAzWepwtRAJAEisBjDf8m2zWo2ZqJfSqjsRRiNTUyq
         tYLGnGAJl4+MlZV7IF0X1TTMc22x6rwwKTWk109cfsFPGCkWObU+ABKSzKWT6ZBkIgUZ
         nQSfdtgABrImgc1zWDCM635/1maUVoKLj5Eo9Fn+GKCs/LI2tehBvIrOpEVWQDv2Au/v
         JQoV47jkES3+mSfFeSOddMVhpg5JWaGGbl24RSdFdRawuUG1IvWBqo45xtz1kdN75kpk
         iv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7QqxmDSu9ZKigGwHfW3p68zaiz3lbhfuyJNk3aAmOE4=;
        fh=3AH7skWoInEaOMjbujGylv2r8p0/ZCUr5SdZ16G4BIQ=;
        b=ZonT4VIRjfVgyJhckHzwGlEQgnYNgO9JKbyceOa7paK6xxYhOzEwpX78yQ9MM+7pFb
         SfPAGElFwxKBqKNOTQra/MzwmZKjMM4/3vPoh7K0r/sZ6zsGO0SVc01jPKZq0dkNycRL
         FZ5CaKdtbqQCyio3a9FkXl9VJ5f174ecvtzCRDSZVIU1WIhes283NGMVPpLNgb4RGsX2
         dIerM//iRlxdji5WfBPVPf9mBAN4N6fIRBlAm3qplY9I0k5Suo1IRhqUEPIrwdkOLPHc
         p4ZCN+xan47eEWR0w5baGDt4d/VQxgo7N53sU4qIVT4UJV85coknhrHLxnvKouf4rry7
         UaVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787510562; x=1788115362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7QqxmDSu9ZKigGwHfW3p68zaiz3lbhfuyJNk3aAmOE4=;
        b=g7JtCvfS2oYdb8Fx7LFvjYxUJQM0cL8cZjMQkNSiViMKLatNAlvHfq10a/9t+DQtq6
         Cx0gZ+E26kntT7xEUBXjEzd9KPIssFksvLkn0BE2CTeAP3ouT9BaOQoAK3X1i1FAwgBx
         rWkg0PtZE7YbHcINe3IEeBxVNJ6jCX+8e9zZ4KRmj7WmrJwWx/Pca15KztHh4I8bEfxZ
         MskHLWWUzctBy067G5YEgY9GscmbSIcEHYZciLOmwseDBxJE8hmMQJgbpiseMJXW2uH3
         U3m4mhkcrcEQ9T7pxHe2p4423k+pjx1Mi9mgBgXORFOEeeV3tqJHGQkGMMEaaNRJgH1i
         cc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787510562; x=1788115362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7QqxmDSu9ZKigGwHfW3p68zaiz3lbhfuyJNk3aAmOE4=;
        b=BEctYAeAj04CMWDeA0F28Rt9Wws/wM07p63EnMVPBZtHM1+muxN8cFK8hbuEIFz1jO
         dIpjKqMradE9JyW2KJfpRB8Od9qRIFP7ixCod66jhcQcRAvGx3MZRclQXcnjCgYZctPT
         EQ93D9eCMB0bQ4TaWP7sJP52yh39WbzmsodfT2exDRngRDKyWh5FUZAs8Ibt7AO8grvD
         g4CWB07/irzntd0tHbIBHnitIj05dSyrOSoYHFGkZ8GUPvzKTn1pWXNFin9DoqopUn64
         sgEGdcRQy25u87RJgfeXS8Qu0lqtePLxqRa+qThjdG0R1bFQmChornsCB+KJgDrKQAGJ
         jm3g==
X-Forwarded-Encrypted: i=1; AHgh+RqhOvg8+XlzXmPN9Nh4GQFrZG8JvbSHjWhszT6B8VcNC4OREvaqtPosp28u/TYcOmZUcMU=@vger.kernel.org
X-Gm-Message-State: AFuF++m4iJDsZR9J2/pLIXuNjzmKe/hys1c2BCb1iMSeizJR5jyZfoPI
	YhNBWAN6gh0JCxTOqz4OYNpKlPzSvnwp4AEQGx52vplHHxRQ89e9aJepIGYUdRnjLtkor2W8U9E
	EnNBjDU82Bewa38HKzc4nAUllpErCqrjJrArb9f1n
X-Gm-Gg: AR+sD10Q4erGW2+lzTXWazVzmh+SEEAmGCJhgR3VRXLtfIg/8wCHdewkS6AG+EE+doQ
	EoBe/iqeeXQNO0FSFpzqPGHrBA9+6QijToI3fQGhZEoSMpx/ov2OztmdNvx78qmhydyEH8z/vKO
	Jcz3XrNXpE3l6PbK95XOfIufMClJ5rqLHcgHTIl3czSMPLMeOqGFQSgdWhIodacvHf2eBV0ufMs
	cK5WIiN64jXMz7jTRMvGYotIy5gvTnhJnOSnhD06yEStxfxDTQ5IjDH5sRxU2Setpl1YkL5MUSm
	fqico1hJvhmuxGz2o+k37+ivVvyNl/PKPlTppfRW0AoVLx6uoG9cmM9jLu6Zq11k0XDmROVzxpb
	O
X-Received: by 2002:a05:600c:58d0:b0:495:7a0b:3b4a with SMTP id
 5b1f17b1804b1-499c241397dmr1168755e9.7.1787510562110; Sun, 23 Aug 2026
 11:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818112920.26252-1-likexu@tencent.com> <20260818112920.26252-3-likexu@tencent.com>
In-Reply-To: <20260818112920.26252-3-likexu@tencent.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Sun, 23 Aug 2026 11:42:29 -0700
X-Gm-Features: AcwNN1UVfQ0nU8MkI-sMZoCVlDC1rLeZSnymDq9F6Xx7kDJeK1PGVfv6PmTTlDI
Message-ID: <CACw3F51WrQ=5=DaKChPtwmf0030R3GSOPjrAZ9Og+V0VHuRhEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: selftests: arm64: Skip sea_to_user without
 1GB hugepages
To: Like Xu <like.xu.linux@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 4:29=E2=80=AFAM Like Xu <like.xu.linux@gmail.com> w=
rote:
>
> sea_to_user backs guest memory with 1GB hugepages but never checks that
> any are reserved. On a host with an empty pool it aborts instead of
> skipping:
>
>   kvm_syscalls.h:68: mem !=3D MAP_FAILED, errno=3D12 (ENOMEM)
>   not ok 1 selftests: kvm: sea_to_user # exit=3D254
>
> The mmap() of the hugetlb region fails with -ENOMEM because no 1GB pages
> are available, and the test treats that as a hard failure even though it
> simply cannot run without the backing pages. Check the free 1GB hugepage
> count up front and skip cleanly when the host cannot satisfy the region.

Looks good to me, just one nit below.

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>

>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  tools/testing/selftests/kvm/arm64/sea_to_user.c |  6 ++++++
>  tools/testing/selftests/kvm/include/test_util.h |  1 +
>  tools/testing/selftests/kvm/lib/test_util.c     | 15 +++++++++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c b/tools/test=
ing/selftests/kvm/arm64/sea_to_user.c
> index 1c2a743ca8e23..7cf95da8e594d 100644
> --- a/tools/testing/selftests/kvm/arm64/sea_to_user.c
> +++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
> @@ -281,6 +281,12 @@ static struct kvm_vm *vm_create_with_sea_handler(str=
uct kvm_vcpu **vcpu)
>         alignment =3D max(backing_page_size, guest_page_size);
>         num_guest_pages =3D VM_MEM_SIZE / guest_page_size;
>
> +       /*
> +        * The region is backed by 1GB hugepages; skip gracefully rather =
than
> +        * failing with mmap() -ENOMEM if the host has none reserved.
> +        */
> +       TEST_REQUIRE(get_free_hugepages(backing_page_size) >=3D VM_MEM_SI=
ZE);

How about moving the src_type to main or global? Then we can
TEST_REQUIRE() in main().


> +
>         vm =3D __vm_create_with_one_vcpu(vcpu, num_guest_pages, guest_cod=
e);
>         vm_init_descriptor_tables(vm);
>         vcpu_init_descriptor_tables(*vcpu);
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/test=
ing/selftests/kvm/include/test_util.h
> index a56271c237ae9..0624922c2735d 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -168,6 +168,7 @@ struct vm_mem_backing_src_alias {
>  bool thp_configured(void);
>  size_t get_trans_hugepagesz(void);
>  size_t get_def_hugetlb_pagesz(void);
> +size_t get_free_hugepages(size_t page_size);
>  const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(u32 i);
>  size_t get_backing_src_pagesz(u32 i);
>  bool is_backing_src_hugetlb(u32 i);
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/=
selftests/kvm/lib/test_util.c
> index bab1bd2b775b6..29f9c1d60b1b7 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -222,6 +222,21 @@ size_t get_def_hugetlb_pagesz(void)
>         TEST_FAIL("Error in reading /proc/meminfo");
>  }
>
> +size_t get_free_hugepages(size_t page_size)
> +{
> +       char path[128];
> +       size_t free;
> +
> +       snprintf(path, sizeof(path),
> +                "/sys/kernel/mm/hugepages/hugepages-%zukB/free_hugepages=
",
> +                page_size >> 10);
> +       if (!test_sysfs_path(path))
> +               return 0;
> +
> +       free =3D get_sysfs_val(path);
> +       return free * page_size;
> +}
> +
>  #define ANON_FLAGS     (MAP_PRIVATE | MAP_ANONYMOUS)
>  #define ANON_HUGE_FLAGS        (ANON_FLAGS | MAP_HUGETLB)
>
> --
> 2.50.1 (Apple Git-155)
>
