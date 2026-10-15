Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6C2941A
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022562; cv=none; b=HVgWNw1rGKz/i2AX9sp9sFA7Ijk4JqTCMvZtWcZCI/8iDm8BGxh+QEht3IIksUAADSQwYmUGYMd7/IcE1ed0i+Pj7gxDmyGYkKQeJtbLgrvLL6ntCkdmtevQPnihp/BtVk5F6a1j7qhF4qxYbxWZkSR2wanM5jI4aklwKGagjds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022562; c=relaxed/simple;
	bh=jHs6Ep25XbagiR77Ler/EP2Jxm1DGCisLXFrcRDFU3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeM8rdzwrQM671gVETFPoy7Z80N5omRJmrTYjdD2ckJne9zB1K2beRCQGUDdYDt8+0tuKa1rMm2jhyidQAwq00vjsdrBkPVuaF4Hohu1RjAD4fo3/bGDZLHlFrX3mAiMVDpK5WwdMk9qeCwV91y35TAnQtURYs6ImCbXk/go4LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amgXjLmB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amgXjLmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8489C1F000C8
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 00:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792022561;
	bh=GsdhuBnsgt0/eltyk14xRrMsHGzthLpmrA5ybctz0/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=amgXjLmBcGpt3aaCA1x54cUiSK1lfQBGpjE+XXB8RIiBLZJAKLzdJtLw5JndJRVYV
	 ARg8SAfK0PSOkU1j3CjWWGlUtnPoRjbEAGbxm4LWfvIg2k6ibsmixSDcO3GOf5sFqC
	 SrxmHYj8ZxSQ4FlV47p0T+xeS5bvEJmlMKpNMlFXQXqu6qkLnKxDv7hlCdi8F89BYw
	 FUDADpijL/YVxyEdPP9SOf+zBSsEj06OzB/rS8gp4GznmzwBC3+oX0UPtk/HAh3lDD
	 ooBqyC//VpfpQrRPDRh77VvlJEmGQchiVclOrmKiKbajttCcF38lUd78pXvNTU4VNz
	 MhZLoVR5SiB+A==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c350db5a761so619815266b.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 17:02:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz1st3YsnnuS4eW5XNnDMGun5D+U8HKdpIV025L8axw1IgPi+WfmDnPwIZEff6tWXKYMpk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGVgzP0f2HBfQ32yuQJPJWnciMTwBkZWePIQFP61rqLZqM2TqZ
	Eu2dwZx03t7xBvV8OJtC54cxoRkSQrFZ/Smp3e/4oCUirxj0g9Ldf2U7ofjJ0dYJ/duMv0y0IS2
	VOjoLjMFQB5jK+TGfUF8uq8jxgq0dF4E=
X-Received: by 2002:a17:907:c60f:20b0:c32:4e81:fe1f with SMTP id
 a640c23a62f3a-c324e820e1emr955136066b.27.1792022560440; Wed, 14 Oct 2026
 17:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008001425.2458927-1-yosry@kernel.org> <20261008001425.2458927-11-yosry@kernel.org>
 <CALMp9eTE4DB7Ek4BiHheD-Jr_GjwhiFpcQNHco4uYKQvMbBvWQ@mail.gmail.com>
In-Reply-To: <CALMp9eTE4DB7Ek4BiHheD-Jr_GjwhiFpcQNHco4uYKQvMbBvWQ@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 14 Oct 2026 17:02:28 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN=qCpNyP-Mwaf=T-=g=z_QecNDNm3hSh0Eh0STg=tCZw@mail.gmail.com>
X-Gm-Features: AclHuK_BK_E61LKABH8heGvv7N2k_f18GSEWf9kbUtlMaZbOdJL9dPwSJkxeb2E
Message-ID: <CAO9r8zN=qCpNyP-Mwaf=T-=g=z_QecNDNm3hSh0Eh0STg=tCZw@mail.gmail.com>
Subject: Re: [PATCH v2 10/29] KVM: SVM: Use a static ASID per vCPU
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > @@ -1375,6 +1370,12 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
> >                 goto error_free_avic;
> >         }
> >
> > +       svm->asid = allocate_asid(vcpu);
> > +       if (!svm->asid) {
> > +               err = -EINVAL;
>
> It seems like -ENOSPC is more appropriate, and would make triaging
> this failure easier.

Can do!
