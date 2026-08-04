Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73147F2CB
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863328; cv=pass; b=EpuEgwfxC2eNfBS8n+sbwLCCX36VY+5AlWjm2Ee+YLsQAH6PQNBYnsqR1bn4vRhGf51oSNtr+aNO5qNmP5qqXQFWYnLv7tJPnA2wSkyKrJKGH+Ue+FCsW+nRhiUVf9Q2qWVjG1Ywu+SCJFFU5zaaG3vLlOOhRRiCoR4F1w0xsQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863328; c=relaxed/simple;
	bh=2mxlSpICyIgsnOsL/5OPel7SuS/dpEi+GGklgaWSayg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoyJKw3tw7IkzzPYe7v272G5H+4R459SsBRl1py5EQqRg1OwrGAA5Etpk5oBtpubjOg7tX3+kKLyI41tQhiWJWv/Y3sjvq2dp8OXEErX3NZa9P1dbRu7t3DwAsG9kDxdFlpdZwjFS67cwkCRdYoGoy5NUKCUDVL6STY5KoWxXzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PqNrH/H6; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqNrH/H6"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c10e86e52so3901cf.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 10:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785863316; cv=none;
        d=google.com; s=arc-20260327;
        b=r8/uIl1qfKm1+ngSZ0btxLCbYWsPv5EFXgv0JsFGY1q5xgc13BoYIT6v1cE6/Ol3Bt
         y6nzr+Pwi/qFPV0Vr1OLyM9nbm9JyiFE5AnbrGfRz1UKKecRgWsC4RrY2MgfcWvv64j2
         sV3RuiIoZYfw0cEWR7T0hl6l2yH2PVOIIdBEkKnavHmh2PbnZCqzNLKyUvU/17at2noB
         CKik1S9CA1PO3INJchtyJei+EPyJJ5EyUxMl4sth6F+7qqPUxSOxlOb1Zk1J5B1sAODr
         N5xweLHCMzNCmwyq2obHNCwQNKLYYv0CeYGraTgjLm1m35bjPEbmKMwUX9x7YvKsgz4n
         bc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iXW2ANwN5OR87mI4XvAgL78m7CHvbtjcstTeQd3nLiw=;
        fh=JM1bP/DellM+Q6HsbxNoFyPUPOAetBmeje+K7gN41E8=;
        b=lak+XjD6SyySErTe+I8Hgx4E0NZNL/P6MjDfW9wWcE0YTWKdAxhr5fArkcn7vXish8
         i/3fJyZ1kQ4ME3ktXsPTrYVJrm9ta3AinY/5an3+QWprEyLRDFnNMvoZ1CwVtDkgNEQ2
         s2wmh7HyeixuNXPW/RkSbyHT1HQm1iM8+Ut5vQXhlEZuclboTt+uxaALjCeF7gT8WBIy
         0Rd4Dubx2EtWFKwbjMhctvOojWhZEWeYE6Rzz6T8BehrcILAR5ZAvRbvmh0x2Rlfh0oU
         dVFerjLBoKT50vQswJoG2kEW6gD8ZN7e0AABJXyLySArq1zJ1txueqtx5FA5fsuBZ7Ck
         Ym8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785863316; x=1786468116; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXW2ANwN5OR87mI4XvAgL78m7CHvbtjcstTeQd3nLiw=;
        b=PqNrH/H62+1M7mOiR46fOtiXWEece7FHKFeFXw97e5++eG2DESTs1oHvkNXQhuLLah
         r/uuJysMCnKSdeU+PFJb5uHhGJVm7oVaQ/XXe4wViUUMmmsTglPK/IAydqmAorcmXZhz
         xWSBJVinxIUkA5YY3ztrPZcJiIoK/2MQcxUmTOH6A+x6H4MTCgVzjOH1DCXsw50QgXU/
         hEUci1/Zzwio3imQOoTv5Sh9tww/svFvh15byNOVifQ4mJ5wJOh7YptB6cHFWAGg94rm
         yO0S6Y4+6e+Plibl0l6YRjeXlh6cZcW4wqQPtze3Sh5v+mVvJGqs1Af3wE9DyFraZMOC
         4Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863316; x=1786468116;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iXW2ANwN5OR87mI4XvAgL78m7CHvbtjcstTeQd3nLiw=;
        b=UjPQw/hb8S/9RVADkxVf1XVzLCe4nskcoD9sSdtSog9SZWc9JB4MShUGBI1KkLRG+Q
         p/RLWds0OCcZNrZFgiYR2S7anzveP7XvfpAWeuFtdGfwmGWrW/GTNfy9N3o0T7J6caAA
         LNo3fM4YVl5vABzeD1UgXqPMxaXCz+DsjJ0wKeoFFO4IPG0z6hle29snbXWaR0aJRl3l
         v537Df09yfR3qrx//zsClce8JOY7BLq0RCtOGLrULWiSRcQQ2QZizzGdNuSZ6Axh7V0f
         7Jv8NQ6TkzYfWFriaRqhcngFI/inLH3a7bJqa4/1D2bA6ABKLCHcTG6DMWtsEqohRqNv
         EekA==
X-Gm-Message-State: AOJu0YyBFvosHJSVxlnXogK2qlD2tzyL3tSx23u0Q1OSrFP30gniPxC2
	Qh+aHTDZS8339Cy11X8nLrpf58AyzXJ3jbl767k70iUkmqg6S3LjChmI63+jP0rotuC2TB9xZ0r
	C4nwl5A3gEsacgZROYoDAwwtiSEjR9Hdxop+P9yPU
X-Gm-Gg: AR+sD11aynxIIxXMYc1WZAv4M4/m+Qjggv324PLdS+wPqr8a6q4PlIfTeSqvAKxCdm0
	ifj5YBnrbXiLZRa1g/5+Ah2ReKEy8BwdgINyxNvMpn7NpAEs0lT4L5WAxak5JUMfZVi4gEjdGf8
	wu3zzltp7Bdo70hjymyOyVpxwrtCaNveW8rL8JA+RDtqTui7uNJ7zFvt6/zgHWGkHmJcdAB0CrA
	ombOdp/7jRgMVj0Bb8283LAVsT+e//cc5BKUWiQLbU8BeS6RwB9X6ibH3adCbPFmqszryx7aJk9
	N/4H0VhkHI8A3Zi0rZAmenmgHI7UVtBWHDNDoJuVYWPF
X-Received: by 2002:ac8:5e0a:0:b0:528:3186:5799 with SMTP id
 d75a77b69052e-52ce6ab8233mr201181cf.10.1785863315089; Tue, 04 Aug 2026
 10:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701203311.326798-1-aaronlewis@google.com>
 <20260701203311.326798-4-aaronlewis@google.com> <alZ2qLbk_g-NoM5u@google.com>
In-Reply-To: <alZ2qLbk_g-NoM5u@google.com>
From: Aaron Lewis <aaronlewis@google.com>
Date: Tue, 4 Aug 2026 10:08:23 -0700
X-Gm-Features: AUfX_mzOEVP8jn1pDvjcQ4aMKEycq1pTcAMTFSnk3kXak4NsE8k7PY9DAgrsfT4
Message-ID: <CAAAPnDGiZju2mNMpG9K+qdXSuJ84TC9mU24qNReoO4Onb=NzAg@mail.gmail.com>
Subject: Re: [PATCH 3/4] vfio: selftests: Allow a size for vfio_dma_mapping_perf_test
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > +             shift = 10;
> > +             break;
> > +     case 'b':
> > +     case '\0':
> > +             shift = 0;
> > +             break;
> > +     default:
> > +             VFIO_FAIL("Unknown size letter '%c'.", *scale);
> > +     }
> > +
> > +     VFIO_ASSERT_TRUE((base << shift) >> shift == base,
> > +                      "Overflow scaling size!");
> > +
> > +     return base << shift;
> > +}
>
> I'd like to put this in the library but it's going to conflict with KVM
> selftests parse_size() helper when we link libvfio into KVM selftests.
>
> I'd like to unify the common helpers between libvfio and KVM selftests
> library but that is future work. In the meantime I guess we can keep
> this local.
>

Agreed, this would be good to do as a follow up.

> > +
> > +static void help(char *name)
> > +{
> > +     puts("");
> > +     printf("usage: %s [-h] [-b bytes] [-a \"test harness args\"]\n", name);
> > +     puts("");
> > +     printf(" -h: Display this help message.\n"
> > +            " -b: Specify the size of the DMA region to be mapped\n"
> > +            "     and unmapped. e.g. 16M or 8G, (default: 1G)\n"
> > +            " -a: Args that are forwarded to the test harness,\n"
> > +            "     e.g. -a \"-t dma_map_unmap_from_file\"\n");
>
> Should this also call test_harness_run(1, "-h") to print its help
> message?
>
> > +}
> > +
> > +struct harness_args
> > +{
> > +     int argc;
> > +     char **argv;
> > +     wordexp_t exp;
> > +};
> > +
> > +static void populate_harness_args(struct harness_args *args, const char *argv_0,
> > +                               const char *cmdlne)
> > +{
> > +     if (wordexp(argv_0, &args->exp, WRDE_NOCMD) == 0 &&
> > +         wordexp(cmdlne, &args->exp, WRDE_APPEND | WRDE_NOCMD) == 0) {
> > +             args->argc = args->exp.we_wordc;
> > +             args->argv = args->exp.we_wordv;
> > +     }
>
> Is this missing error handling? Also maybe add some comments since
> wordexp() is not a very commonly used helper.
>
> > +}
> > +
> > +static void setup_test(struct harness_args *args, int argc, char *argv[])
> > +{
> > +     int opt;
> > +
> > +     test_params = (struct test_params) {
> > +             .size = SZ_1G,
> > +     };
>
> Do this where test_params is declared, not here.
>
>   static struct test_params test_params = {
>           .size = SZ_1G,
>   };
>
> BTW, this change will force all tests to use 1GiB instead of their
> current defaults (PAGE_SIZE, 2M, and 1G respectively).
>
> So this change is not purely adding a command line option. I think this
> change should probably go into the first commit that introduces the
> test, not this one.

The tests were explicitly set to 1GB in the previous commits for all
variants.  This commit allows the user to change that to a user
defined value, with the default still set to 1GB.  So it really should
just be additive.

I left this as its own commit because it is only additive and should
be easier to review on its own.  If you still think it should be a
part of the first commit I can do that.

>
> > +
> > +     while ((opt = getopt(argc, argv, "a:b:h")) != -1) {
> > +             switch (opt) {
> > +             case 'a':
> > +                     populate_harness_args(args, argv[0], optarg);
> > +                     break;
> > +             case 'b':
> > +                     test_params.size = parse_size(optarg);
> > +                     break;
> > +             case 'h':
