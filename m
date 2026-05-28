Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1DD33F8AA
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952212; cv=pass; b=elTUMW38ZGNiVbSoDAY4nw7SP6mSlHQieT4G5dRPSgaMk+m8aFb+KnjIT/8AoZQ93DToJYM7Un0jlaF2/HIkr5wFiyUcl/IecP9esVFOHjbZhy67k6u4vFtK0FwDeBs8jF9E5LXq9xJQUald7aO+fjMbjj4P9YZW5bOpMz/ywT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952212; c=relaxed/simple;
	bh=qb0+MrmCF7DVBeJVMnkF+COBZ4mo98rk7ENOXbazzec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfPaC3uYHbqgUFNTALB23IhdtH+ZdLv0upxsox27HjOFV4tyercdWKzXjlH1sxUPKcJNZtQsCSaQuanH0b9vSA7+LiLM2uIfUq2sh2Symb03oOll+fwHq8VM6DeLSSasK1WcCLr9MritM1f075HyN6cm6URoGsWySio+EhEDJ3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7WzAft9; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7WzAft9"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so158398426d6.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779952210; cv=none;
        d=google.com; s=arc-20240605;
        b=QlD/vrVEmtVEJospON4D00fylUd8GypM55JzyR9Ey1hEwSW5Z1g7geHAuyv+Zr7zFD
         JL++eUdQoG4S9DEoAdMfojUwGv9NlrUiGRHmpc69fn+dyq7XE5pomHs6DeRRpbPpQFdJ
         Ry9l9aZdbpGb6cblDa6Z28Ij1y3MmCx78TIg9OED+xL45FrfcI9kxy64rWfdeUsUzaqU
         ZUFvgyksnrqXFPxrWOkF4iTJCnaZ30Yj+Ch/qt+cFqnos9C8OYl5x/CeDtH8coK/cu9Q
         hr5ugdZ6TphiBhjfp3BDac90zAASQuJASC3Yw85tMuMgyj+jhKMeCDA1xX7yDes1HenI
         jgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aoUYOMPrMmAsyTOdHWz12f2+LnWGrx2lB+tf8/EVVcg=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=P0WD2su593B7e3ibGRMe4BUhzQpR1PXsNijXNO2+CB8vfsVkPdfYZB94XYekjy4UvN
         NIH+LJEOXA5XORdYJCHJsgUIF+hlHZ4lRFrT0IFMwaqlm4Vvr2tA4F2ccWKPT7ioAgmh
         ucenK2j9j3PyMqsHhF1H+FsdvqlWRnm5sQEnsmpzb8ahmwVFUYgqSmfDnqPW36K9nX6x
         +MiNXhbZQH+yI1QoxX3qm6foVSXoICXykzMeb8aFeON+7No4Yx02pqRqJ52BVmsLA2il
         8Nkv6Q6279o15gL4/KOM3rP1I1VHLpS67lLBuKxlUrtTnVljD/bC3w2gCoeOK35LIvfp
         5e1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779952210; x=1780557010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoUYOMPrMmAsyTOdHWz12f2+LnWGrx2lB+tf8/EVVcg=;
        b=h7WzAft9Or1fNBr0xxua7954gp4Wcymm9k+GA4kcEITlhRQvHicg5qeMM4z7CMXU+h
         y/v8UlFhb7LljtmfjNyOzdMlwgcRvELNZ5f6LrYLpfnzFuKJeLOCB+e1/tiipQkuJndc
         eyh/mpDZ9nTL3VkACJzXQWCrvXLrJY4QoEdYfuPpkP+zAAuPkJCNzIC5tHlbU5UPAHc8
         DxN8tF5UVclzSOPP0CcSgYt57pQgCMWgWtEoo0QcCy7LqmlFcWpmQXTA1DzySfey8XBv
         sKgkLG6oDZvaRtG/KvCMvLcX31nNuZUacKgoizfhZncRAbRVJbNzAs37P5YGkw/4Ankr
         +6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779952210; x=1780557010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aoUYOMPrMmAsyTOdHWz12f2+LnWGrx2lB+tf8/EVVcg=;
        b=M0o91V95eVdcHL+wNX8mur/KodnfvfYg7hCeYVx7pp+QVX2CN60cVRfCZoAp0TfdrJ
         FLBYR4kd/v5ZOFI86WfHzer9Fqle6ov7EBQClRcO/+PWtroQooYyTiaBvDwnj9CE91FN
         G8B8y7VmsRYuQSAeT4C+n0G5zeYAefzl3aM1mfnaquIUYHe0t4TyGV9kKRsSow45iY/3
         dQXSwYCt4LpN+KQsiNd4wOUzLWXLwXh360S9TREAtg1ftDp71NPYFfIxbPhaVeoSJKFQ
         nRlbfItxJnZgB1kVCmBe/w8GwBj9kfdbSux+YajfiXnsTdyYupvmuKl0+RN4Lk2wgEYG
         PJQA==
X-Gm-Message-State: AOJu0YzNxLDn0zbWRHg+fz+aVkpQqECTGhZzHz+AoTllBAlZyT4tx82M
	B1TRhIJCJ1IMo7Vnw4quR8+YXKXo//oVRbG6jPAkmkk4AIbBlnDl5aYRRG7U8i25PJcZGt7XPTW
	nNwFhyYFmRlCfU/lHgbQR2NEV5el2jdI=
X-Gm-Gg: Acq92OGe0SRkcz0Dx6FEDLcVhenBN3H4Mj42a9Uq7a4oh2zpxKVpsTWGX4NgYDSJBXR
	StWUCR9iUBGAMQGSidw3xJlRJVwlnIZTe9DvQfxfa4xP9K9Z2Xnb1+yaIza8fvwRI7kK0qbuOWX
	RH7IUIinDD8DBQenzXUW7myvvg/1F4sPYq9fzhACih5rZ08rq+Q3DQtvK+FB+JI3SjUUo+XuiRI
	USvP8NgBjwtHkI4a5vXjc1zJqXhx0TU+083wrxLcOMcyiGeAlts8dMGsLH3BQMsbMxyeVVwkU9i
	GXIbmugWzdnIRzAG54cr5BeMTdQ2W/LRvu6XmAaZBsKHERUF
X-Received: by 2002:a05:6214:2e48:b0:8ca:1cee:7c4b with SMTP id
 6a1803df08f44-8cc7b67e09cmr449902556d6.39.1779952210399; Thu, 28 May 2026
 00:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528032234.1322565-2-ewandevelop@gmail.com> <20260528034244.DC8041F000E9@smtp.kernel.org>
In-Reply-To: <20260528034244.DC8041F000E9@smtp.kernel.org>
From: Ewan Hai <ewandevelop@gmail.com>
Date: Thu, 28 May 2026 15:09:58 +0800
X-Gm-Features: AVHnY4JtvNNQuQK0gvq8q01WbU5goPZysAGYoyRmic0X0pah3tanl9wIKzGWgnk
Message-ID: <CAG2uPc4E4mW9Rvxb7PdzRByd9teW0KcJaKHB=ZBHQWLa_6iiJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

good catch, I'll fold that into v3.

On Thu, May 28, 2026 at 11:42=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The patch modifies `arch/x86/include/asm/cpufeatures.h` without s=
yncing the changes to the tooling copy at `tools/arch/x86/include/asm/cpufe=
atures.h`.
> --
>
> commit 17e8fbfd326bc812ee6f132253d520b0c7201874
> Author: Ewan Hai <ewandevelop@gmail.com>
>
> KVM: x86: Expose Zhaoxin SM2 CPUID feature
>
> This commit advertises the Zhaoxin SM2 algorithm and SM2_EN features to K=
VM
> guests via CPUID 0xC0000001 EDX bits 0 and 1. It updates the CPU features
> header and the KVM CPU caps initialization.
>
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> > index 1d506e5d6f46a..20b33413189c2 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -136,6 +136,8 @@
> >  #define X86_FEATURE_HYPERVISOR               ( 4*32+31) /* "hypervisor=
" Running on a hypervisor */
> >
> >  /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, wor=
d 5 */
> > +#define X86_FEATURE_SM2                      ( 5*32+ 0) /* "sm2" SM2 a=
lgorithm */
> > +#define X86_FEATURE_SM2_EN           ( 5*32+ 1) /* "sm2_en" SM2 enable=
d */
>
> [Severity: Low]
> Since arch/x86/include/asm/cpufeatures.h is modified here, should this pa=
tch
> also update the tooling copy at tools/arch/x86/include/asm/cpufeatures.h?
>
> Without syncing the tooling header, tools/perf/check-headers.sh will emit=
 a
> warning during the perf tools build process indicating that the kernel AB=
I
> header differs from the tooling version.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528032234.13=
22565-1-ewandevelop@gmail.com?part=3D1
