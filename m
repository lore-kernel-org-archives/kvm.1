Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7845388E68
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990165; cv=pass; b=VyyOinkv9yZ9SNn+rVI29feYag4g95lOxiAfpWwarK62Vpreq7yV6ARFZtCK9uDjtMSTahifLPUB/U2vojBhepNfFjbktSiNOjX2SB6v9Ue7ZQSGBgPeekkUUaX5zLiW1Wi0aEwWzz+mWaYq9sQCTl6Q3h960oY6qvWL662Fdo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990165; c=relaxed/simple;
	bh=peUQ9Y2a5XEmnKO7ViaOJtAdf4c17RcSOD9PNqTPBgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgQ4tjJzu+j7k0ZvxBWCAo6bY3loU0KLowdMuhA6pBFZGWBflpbI2jVPLNh+rmO7izn69BN0HnJwq763+YWTcDcxZhYnarr8DtGxNLn9qkXsWAs6Ri6SFTitflRkuBS7YomCHio8WlT0vki/FLEtGgf/JZq9NcZEe7hooOWGJMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMB+WnaT; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMB+WnaT"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so43602a12.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 08:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791990162; cv=none;
        d=google.com; s=arc-20260327;
        b=hEWh6TGoGfNe/pJepSBOVws+3ilg8Lg/o7TqzDwbQSXvlctzCzbH+d7mAulwmsDWv6
         8cj6b6NYk+SUbviBzrKbtEnYXrgrW2JTfUjQp2Xfv7qWE4BzpPucYce5S4IDLBLfVE2b
         J/6A6a/YhOQtllOKaXHu7XqQtS065JvqkYyj98cI52ogccwGtz1qwrwXmcfIE+yc/89M
         7COvK5b9SCjV7PKyA5S7CDlGjaCNcHl7rCxPnIc1IVN4k/C7ZHrgktNl6ByZga2jVR2P
         Y935zLdDGwFHzvXD/K+ZqRGc8ogJp0QMCHNFbm3Vcs8iB+3OKUBbDQ5TzwrNAMVXRLt9
         3eCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=peUQ9Y2a5XEmnKO7ViaOJtAdf4c17RcSOD9PNqTPBgI=;
        fh=2cLRW4M9T+hETI4xASgfSy0o9g4ozEI7OjcKG6WesvM=;
        b=YD+++RWRsiq80+B6otHp56lyYJ/Zks/4ix2a0o4Vvt9dB1+cYiEcSKA6KxJeK2gzup
         1oKiQ59hVFygQHqM9DSe0oovrxRiy1CdatSnPtPfLk7uE9DSUF1LwIF1xaX8tKDXCHTe
         Wjzll4TRdcaEZCywhjr3TEReFrz4J/RXUzRd5/nUmM4HOfvf9NJhGkaHXAUibXUP+6Ub
         qzQvZKlZYAN5ovPZxBqXIarBw4Xi1ydGSmO69ZL2RK5TPHTfy47CZe8zM5VOSAE8IACF
         +YkJ36SIb0YEhnWhiBnOsgIzi2FlOnVdrdFE8Y9p9BSmb7N83TS8MOAaLzrUVp3wmWCY
         m//A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791990162; x=1792594962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=peUQ9Y2a5XEmnKO7ViaOJtAdf4c17RcSOD9PNqTPBgI=;
        b=nMB+WnaTXoFFghnw3y+ZLz2ymntwqyozoB1+GuCz13Sd4tNMIktmzoMTniQuYBCuYQ
         9nK5h+c4kzs6KTpDtMSj/R6zsSRvwaWIfHXJl3RnMCqmWDeGXRzWsTCzhgeyAOV1mdp/
         g7RA3KXwg0f6yq72zmR+8dNw3PdiSzxVoaO0CVufThA8X55e2uK7Ey5BRAG+nBUg8i/E
         nz/Z2IiGZrQCFs9boJ8jMKBH2Whqpf/iZMCEreB+00AvfJhpiu+iNejxaEpr5mWJDWxc
         0vvzZTVEETfE2Z1j6ekgqD+Jy09+t2y6LJJCg9C0jkWaR/i7cCYkTNM5f101sQqMUfkw
         UNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791990162; x=1792594962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=peUQ9Y2a5XEmnKO7ViaOJtAdf4c17RcSOD9PNqTPBgI=;
        b=Zj651FEfDdnmiwhFlpH0NzuI68Gp6rIx0OUYMzN8mGS7WN/rgoXuG5FxcgFCsz+WSo
         meuNnBZ083BsSTrriJRB+KqcBzn4RQ3WI5+dhPrCSohQeEN28EfuDMqUrrhC+yVlrssd
         spIqHsmdLWBc/nuni07ueKA4yHzIhJEvCVOxrpprrjOTy89lm7QWendVVtuOtO6XN8NY
         LbKbbDzajT3z7Pik/tMWHzCUf/MABwZYPJiBvQlzN+XbKHJZyMnFH8lIOa/0cAZ9soWa
         XlUnE6JpcmkREvyG5QhNOVO7vLv+C3k9eyT41Mgwh1254pdaWR8CaAYkUngOQH6GKqyI
         umvQ==
X-Forwarded-Encrypted: i=1; AKwUvByVyT/oAShY80wKwAHy2vklI/JlmiKXqcXTNc9OwS5EBWfAdHZNFQsxa3DzaqStMkuheTM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrYPXoHt6ylt4NNw/Oqy5lF1tWF4445EnPKWWv4lxzA7binbUS
	lIugnn4eyAgLRxwfUg62x2qC9eyYvusdtqjJbWji0Hr397+uBkK24mF8/N07FP0xGg9dM2M024G
	Mi5IYJEPRVkwZz3a4cSCOKIJOfNynTgrkRZiWpzcc
X-Gm-Gg: AYBFou3ASpitfbFnwRNzSF2CqrhPipjfeL/+XwfdMzd+6b3K1+UTkqzCrOmjWZcL4SW
	6j3oqulnM+rDZHUK/D7u7u32+IDniQwuY6PQwEZqr4bCSHUjtqCIKcyLrP0mvkiVW+ea7MAi4W8
	qxGqYHayvfibRNjcI6a7Q//ztu77BDzfdv/QpqjO3eSD1HDSjWh/RWwnxYOx2pspzqW3eUKuI1w
	YMiTGG+mVA6Y2TbAr5IICBcdCGmsTneGDh7uj+v1vd32qng9DSiaX4pMsDi27pVSvGrrokKfiOy
	RWq8v76j6zTnKRQ5d4YgTh3huyk+um+HH9QJNuGF5/Au9ZYfZ6lE5c0=
X-Received: by 2002:aa7:d407:0:b0:6b1:b607:a5db with SMTP id
 4fb4d7f45d1cf-6b20976e77emr47828a12.3.1791990160901; Wed, 14 Oct 2026
 08:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-2-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-2-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 08:02:28 -0700
X-Gm-Features: AclHuK_yhR3qanMwsfhsd_KJEDCodUKEAzljmDfv-F-Yz96nQUzINa-EzATGdNc
Message-ID: <CALMp9eSoidVrzHqTrq09LB1SCwsf5DuwAcys_q7o0TyrKM1Ciw@mail.gmail.com>
Subject: Re: [PATCH v3 01/27] KVM: nSVM: Flush the TLB after forcefully
 leaving nested
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> KVM flushes the TLB on nested VM-Enter and nested VM-Exit, but not when
> forcefully leaving nested. In this case, L2 TLB entries can leak into
> L1. Flush the TLB after forcefully exiting L2, similar to nested
> VM-Exits.
>
> Note that vmx_leave_nested() handles this correctly, as it reuses
> nested_vmx_vmexit(), which handles the necessary TLB flushes on an L2 ->
> L1 transition.

Fixes: ???
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
