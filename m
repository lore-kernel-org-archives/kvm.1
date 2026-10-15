Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526525B091
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077677; cv=none; b=Pg1jXpGRpULomzov++48g7QwcxO5xslacjSTjL1rQ+fQvcRFe9tunx4/uqN93N8J4OuawTrcIwLefQ2WFqoV06ZmX449fAz5bnUpz9/Zv5z6ebNgcu3mZAdqjfHnWpV4Nd96Y6IRxpW81PvsI1u9zZauHJZfeo5TRMc7PZ+wPIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077677; c=relaxed/simple;
	bh=bMG/2cOgMM7JgeRqvzUIdnhn3sLkYPBn1qsyrRStR4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArOQnuquAOPUt5n7Y8NtnV2mGAfFtU0CvyXLvjAIxdWMs2Tea4WTIg7l971jP5ou51wkvEe/KY3z/q3rZpaIzTliKcTs4O/QPEOL5LCXVBtMwIkoPsCoC7itby5mCIJQzawxB0ax4j9wmDyxUs+X/xfhQ0uLWCo/pb+qXgX+CYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HynF03zZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HynF03zZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B961F000C6
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077676;
	bh=mu9FGXZ2MMcGUoDzfZ8NA1Fpk5jNUbWcqS4CHApa294=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HynF03zZPGW5/qK/wbRpHHvWC/9piFSo30qDUQBNwQM0yS1+ZSIZTiAqD1qlFNRzO
	 4tfNx5uHvkmPEr4MTSw8ScGdw3mYtEzZYQUTAffdMSmYwXNgkl/2RpXta5wIaD1CwE
	 yQT2DtkVEIPGTBqIeHOirnPAVsB8h3VB3T5gqOJdeN4Ab+L8yaiIiKqKRCwJ2kGkdf
	 mt89lgR89gW1toXYdpo5a0PTve59EG5LKgFtBUJetvVXoLqCJ2qxlHYPMS7Yxofarw
	 J82/LF/g4M0EWVtZGiH4vGtgslMj2a+6j7cGYXrVUpTa9dgAWZWNBFJMUdSBkq8XEf
	 6F0PoBlc5XFLg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c262f1186f0so724928266b.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 08:21:16 -0700 (PDT)
X-Gm-Message-State: AFq9FYK0C9OsVB79V/8EPdWn5oCI+MBWv30kRR3iGUEx2SA4QgY/oy8/
	eGmKv+3JuDCZh4RPH6va1tZzZi8s10PKPCGyP6c1xk+gdoq5mIKF8m5P1EYxHIhzWKxAkiV27ET
	pIXUAVHo46c2cy65VnrDF8XY1KYEdWRk=
X-Received: by 2002:a17:906:6205:b0:c3e:4f41:e2a6 with SMTP id
 a640c23a62f3a-c3e4f41e8c9mr337921966b.6.1792077675194; Thu, 15 Oct 2026
 08:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015103933.2088307-1-nikunj@amd.com> <20261015103933.2088307-2-nikunj@amd.com>
In-Reply-To: <20261015103933.2088307-2-nikunj@amd.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 15 Oct 2026 08:21:03 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOV6Js2GgjPXGcjs4ZG4CkqBivRnas0GR1Dd=22O89-AA@mail.gmail.com>
X-Gm-Features: AclHuK9-Fl2wev654spgk2hdjQE555fsrK0SB90dPHSLKRjCaEzPrSiDDhriZ8g
Message-ID: <CAO9r8zOV6Js2GgjPXGcjs4ZG4CkqBivRnas0GR1Dd=22O89-AA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] KVM: x86/mmu: Log dirty GPAs only for the nested
 GPA walk
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, mlevitsk@redhat.com, joao.m.martins@oracle.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 3:40=E2=80=AFAM Nikunj A Dadhania <nikunj@amd.com> =
wrote:
>
> Gate PML logging on the walk being the nested GPA walk, as only that walk
> yields an L2 GPA.
>
> No functional change intended, as the EPT template only backs the nested
> GPA walk.  The upcoming nested SVM PML support runs this code for PTTYPE
> 64, which other walks reach too.
>
> Assisted-by: LLM
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>  arch/x86/kvm/mmu/paging_tmpl.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 8e350095508c..043d0ec02b27 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -235,7 +235,9 @@ static int FNAME(update_accessed_dirty_bits)(struct k=
vm_vcpu *vcpu,
>                                 !(pte & PT_GUEST_DIRTY_MASK)) {
>                         trace_kvm_mmu_set_dirty_bit(table_gfn, index, siz=
eof(pte));
>  #if PTTYPE =3D=3D PTTYPE_EPT

Do we still need this?

> -                       if (kvm_nested_call(write_log_dirty)(vcpu, addr))
> +                       /* Only the nested GPA walk yields an L2 GPA to l=
og. */
> +                       if (w =3D=3D &vcpu->arch.ngpa_walk &&
> +                           kvm_nested_call(write_log_dirty)(vcpu, addr))
>                                 return -EINVAL;
>  #endif
>                         pte |=3D PT_GUEST_DIRTY_MASK;
> --
> 2.48.1
>
>
