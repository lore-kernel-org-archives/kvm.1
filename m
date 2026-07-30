Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE0A400966
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404220; cv=pass; b=hxH18ncxBWwfl5KIW6+fauSvTfb0/O0/fUwmIf+1iB+XxmAmPvhEEPgHXd1aVefmxgBXVweJ+sZjcZz11ddxyRVQ0+sCcu+OHfxjzM+e1o6CVTPLTNeXvGTeav4HMHFud4CH6xXQkc0wcnqj0qO36HaUwZFPrwpx1WV3aCNPVyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404220; c=relaxed/simple;
	bh=ILzfmwUXg3GMOH2fNnwuPr2GE5O+eslWBv/w4b4Puz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKxYfqoB34OwpBSYQ3OBsUDG4dE9iSRyQYE3hpK+5hRYnCWjcJGcypex81hA25qPmv+4bJWSBOS3MOSwA17bqhYquqiKlcd5rL/B71XQYU9XTo32SVvJCRD+frpmhbo95jGNUW+sadCzdLJScKNFT5cEbv4PbA6R0uJyzRINAyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln4BMKNf; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln4BMKNf"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so3160834a12.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 02:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785404217; cv=none;
        d=google.com; s=arc-20260327;
        b=FzN9PDA2unTzvvelVTT+1Ea2FV0BRVgYSQ3MMzvj3rKRUWKYLoXQY7FTAF3BpELkJe
         Hj1R955Ha/0zAhw2zQ4L6lQOtOOYFcaFY0EiABsmlGObX9Sb1VdK7JC8PX9FxuueGmHJ
         ZLuXUvVlB1nzKQ3HqEJQNZLx78bHgTWnzqmBuMx90cnFYWV1gVW4wxQZfy0NJOFDJlWt
         efPejGbqhmY6jwMY+ITP4vLOJbC+s0DGw3YRMSOsNJgXrMLJMKsxMud/avCiN+HjMnwo
         j2hR6xON4aflsfoTdZh9EjJ+kjkjt49x7LIhpbclv2cTr5sZWcO+N3yLMtNNIPoQGbvO
         mXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ozUuSmNdhlKHiyOphMBueEUOvz/5sgYbLE8fquvwg+4=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=KIi9XtfkQ4SLMvmj8qKFVXciHkJlBpufJM8t5ibAEtYBwe5MI4zv2A6/fO1gVfKLSv
         RXGWUsKKsYq4/dVZaZlGlJBDRBv91Pz1wunBCjXl5iv95qdQYxM9AOwD0vKbyXhjAo5o
         CY9RfH0tn4460El+Ycmwri5y0F0akHWYjgP3xBWOn8STXuwNRH+xBzZi4yXbgzjbZ4+W
         hVVziNOa+wCEhiJFgKtsb2zdT2cDoe3qe4ZapIwQMOBrlznFK73YExvWdFbjl9xYy8+e
         R1l4eQlv9h/WnmdRqy9aQjQ/Et9s1Cq9vxErHbUwoLwVLdTsBLCOz3QcQSJOgFmHqw+B
         3/VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785404217; x=1786009017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ozUuSmNdhlKHiyOphMBueEUOvz/5sgYbLE8fquvwg+4=;
        b=ln4BMKNfS3gxXGECKXKcrL/lUnzQDlFPEDwkV2vPNqFzD4li2SCWN43jrm+Rfj4Ylc
         +ZhZI5V6nb7BSdSyzgyzDG7vTBFJYJjnpXdhLMDSV4Xdr00sVYrcvmMtuatfp5NTQyFw
         p2hY2QKdU/DDuq8ZL/Q0StUAOuL49MwWvIGmZxTsxKPfrigo6coiHNWo15L1Xchw5ksr
         RsUTNSEsxop9iABEjyl5RzxZgdvSJWbEjXIdMdMk0OZNEvzmGwNLyPngyah+smS0+Q5U
         /QaCpSonNpI1rzX+gp0zOJouDgwlAuWntIpnx3eIkMFHV0Kq5NGzWWvrL6N5ezwJ8F2S
         UrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404217; x=1786009017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozUuSmNdhlKHiyOphMBueEUOvz/5sgYbLE8fquvwg+4=;
        b=ovyPbHQTfh6Qq6dlRZVPYlnCY/W7yvtPLQgbA6AJqoqMPjgoKPf8YS7Fj+pgLvpVrE
         dC56RsbDAvxaDeqjRC683+KBVoi6ju9EGj2216PMyGg03GSke2GWcBxLdnQXlj9pCmLq
         bHEBcVxbz9iYxLsRH6+5CQkUCCoxkV9VFLhgb9wBTCmWbYZSYhxOCg3CXkMlZxf8QMER
         DOc6pvW8+KI65tfJlyP/nO6MiUFnT/437hI83da1TkzR3PAAE2tq6k9UuKOfqw2r7JV7
         Rtis3Kq6cQjxHT+/DE3ge9DNVve+4yBdNrCg+9d+QdOhfolVEy+ZWhB9X0V1Sdjp7npc
         sYRQ==
X-Gm-Message-State: AOJu0YwhFxmIqAslmzeZc2V3wf69FaAC72tPWS96vBFXoG/cKFeu5MhG
	aRwUR3kQV4l6YnW1pc4dMT6rHam8/SoczhsK8j95pExkwwys5cfK7U4Ynsk/GiINOEVQqugUge/
	Z+3epx1XTlmdnEjF8InPaNj/L45uytto=
X-Gm-Gg: AR+sD13h/hFv44IpR1k3404+MS1ypm2nU1EJ/3nDDHOKOFh3kk8HQJmeFeKYQlr8xGg
	1P+nbmtWbPgieUQ5CtLNk4W2C05m0SoZ7oejzGRmAxmZCNWk4CT3B0xmRMAiyepRyZi77TjG6LO
	NTiNEUAGCAp1KaQbH+rVN7TKk78dnqR2ZZKRIGas0QE3j7HKapkhnadG8wgEEmACWPw89Qj+j8I
	vEN5dBCwBuarEtSbf0rYatTUbDFsUXZ195x9Y9CDVXjonzg9uxT/EbtYiWXKn4E6HTqFkdUiIuQ
	7rWziokFc5IT+rnlGHpSpj6A2rbr+I51ZNnDgbWy95g=
X-Received: by 2002:a05:6402:2b8c:b0:69e:a9ca:58fa with SMTP id
 4fb4d7f45d1cf-6a07b89314bmr800887a12.40.1785404217141; Thu, 30 Jul 2026
 02:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718153620.829378-1-2045gemini@gmail.com> <20260718154914.891C81F000E9@smtp.kernel.org>
In-Reply-To: <20260718154914.891C81F000E9@smtp.kernel.org>
From: Guidong Han <2045gemini@gmail.com>
Date: Thu, 30 Jul 2026 17:36:22 +0800
X-Gm-Features: AUfX_mww5oBvzltvKFLOTW_sUsjC1AZV-2L7Cj7yijTdZWDWVjDQXhzvW5gwQWE
Message-ID: <CAOPYjvb63kHmba4JFgsNjMcjbei-wEBu7oRCiZZQC6-XApsvEw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix PMU event info array size overflow
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 11:49=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Guest-controlled large allocation lacks __GFP_NOWARN and __GFP_A=
CCOUNT, allowing host log spam and memcg limit bypass.

You're right, this was helpful. Fixed in v2. Thanks!

> --
>
> --- Patch [1]: [PATCH] RISC-V: KVM: Fix PMU event info array size overflo=
w ---
> commit f0a5b0643b60a1981804276ca1f91780cd681469
> Author: Guidong Han <2045gemini@gmail.com>
>
> RISC-V: KVM: Fix PMU event info array size overflow
>
> The patch prevents an integer overflow when calculating shmem_size from
> guest-controlled num_events in the SBI PMU EVENT_GET_INFO handler. It
> introduces check_mul_overflow and rejects sizes beyond KMALLOC_MAX_SIZE.
>
> > diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> > index bb46dcbfb24da..8b489fc3051f4 100644
> > --- a/arch/riscv/kvm/vcpu_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_pmu.c
>
> [ ... ]
>
> > @@ -479,16 +481,21 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu=
 *vcpu, unsigned long saddr_low
> >                                 unsigned long flags, struct kvm_vcpu_sb=
i_return *retdata)
> >  {
> >       struct riscv_pmu_event_info *einfo =3D NULL;
> > -     int shmem_size =3D num_events * sizeof(*einfo);
> > +     size_t shmem_size;
> >       gpa_t shmem;
> >       u32 eidx, etype;
> >       u64 econfig;
> >       int ret;
> >
> > -     if (flags !=3D 0 || (saddr_low & (SZ_16 - 1) || num_events =3D=3D=
 0)) {
> > +     if (flags !=3D 0 || (saddr_low & (SZ_16 - 1)) || num_events =3D=
=3D 0 ||
> > +         check_mul_overflow(num_events, sizeof(*einfo), &shmem_size)) =
{
> >               ret =3D SBI_ERR_INVALID_PARAM;
> >               goto out;
> >       }
> > +     if (shmem_size > KMALLOC_MAX_SIZE) {
> > +             ret =3D SBI_ERR_FAILURE;
> > +             goto out;
> > +     }
>
> [Severity: High]
> This is a pre-existing issue, but is it safe to allow a guest-controlled
> allocation up to KMALLOC_MAX_SIZE using kzalloc() without __GFP_ACCOUNT
> and __GFP_NOWARN?
>
> Later in kvm_riscv_vcpu_pmu_event_info(), the code does:
>
>         einfo =3D kzalloc(shmem_size, GFP_KERNEL);
>
> Since the allocation uses GFP_KERNEL without __GFP_ACCOUNT, this memory i=
s
> not charged to the guest's memory cgroup. Could an untrusted guest coordi=
nate
> concurrent SBI_EXT_PMU_EVENT_GET_INFO hypercalls across multiple vCPUs to
> temporarily hoard host memory, potentially causing a host OOM?
>
> Additionally, without __GFP_NOWARN, won't allocation failures for these
> high-order pages on a fragmented system generate rate-limited page
> allocation failure stack traces, causing host log spam?
>
> Since these allocations can be large and are guest-driven, would it be be=
tter
> to use kvcalloc() with GFP_KERNEL_ACCOUNT | __GFP_NOWARN so it falls back=
 to
> vmalloc() if physical memory is fragmented?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718153620.82=
9378-1-2045gemini@gmail.com?part=3D1
