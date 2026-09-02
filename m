Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A9418359
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392139; cv=none; b=Ale+9EO9sJK10XmxlHd8FPSWiYHIbp9i2xcAm56YuKSf09D0YoV5dO4HXJDo1nGsAyAzOiSvdrXzf8/mMPZK9hrUqNsCOzug0ztMut6C3v+aC5Xhaqn6Ce1S7Hkj5GOc0o5/Qi5f8n0u/dJe+BDrDaXHKuV/5+gtiIQD6NiusUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392139; c=relaxed/simple;
	bh=+havlEfSjdaxmqdLZZHTVupSGtKQVzgR/eU2Sfq2USQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGJafCMKuJxEuzCbHodiwsrfBOOqvZbR4x894RpkMgACeDASGmFBsrVijLXtLsQQTXqnrfFEVyis8mGC7tVM6RQRY22kojYYgFacy1oCi3lY7f3DN/Wg0uNVgDlikVAw83EclSs/ifZWPQd+zf9Vw28WTkd28Sz4C10uH5kVcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmJoFuIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmJoFuIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29301F00A3E
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788392135;
	bh=kb70xRTsNPjhKX572APHISQVg+Jn2GsRSBYTPHfSA0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CmJoFuIS+QyXTyRNqZEXQTzDhmOGN7zEHPayXot9Lgi5Mc3Jd/j2b+sL5ZTC1lF5J
	 zOb2Z9QPI4ByjkSN0WW0s3JpNh5cZ4mc4zA/FZF7uPyR++ALch+xiaFaleuNoo6IHU
	 MDrZixqT1wIt4LmqXN7eKsBxT9jsgfUhBEcV8ulvZezLL1couc8EupoNnjLHNX2+9S
	 7yMt5FS2UoV9Yy9SRODxqLmBhRnzbmBaWd0HloXBbtQjpRFn0WQ8wNQruRkj6k7PXL
	 C7FZtPUR9JBsSw9fUpAXExq/RBcQjj9eyN3acygOu6z1Ndh7LZadWgWcTWEZTEUAGZ
	 FKUdcWZdu5rnw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2530cabcf4so276138766b.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 16:35:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByMz0KDGSUz5/B1Y3ewG5BKWO5VgLbeVeHtLJoX2l6gQtXFlTvczeoU9ItVvQ0eXvpXMWY=@vger.kernel.org
X-Gm-Message-State: AFuF++ncyJFkhFflzBbg48nvaG38CI2Idta4kbbvgmfqsabfSGEXcqBy
	SGXbZYD98Ko1rlICqgk20+w7y15GahMf5/lz841DFznDbshLGbQiGgT15juKRB8EZL/SLHNXvsd
	9XUlv9TyWhCZiS3lvIsEp0DzSdMrK6X0=
X-Received: by 2002:a17:906:6a03:b0:c24:d6f0:1223 with SMTP id
 a640c23a62f3a-c25d5474dfdmr471852366b.12.1788392134768; Wed, 02 Sep 2026
 16:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902232028.2767071-1-seanjc@google.com> <20260902232028.2767071-3-seanjc@google.com>
In-Reply-To: <20260902232028.2767071-3-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 2 Sep 2026 16:35:23 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPEqnp6Hcs9M8dz_n1MwSvH4H+kfr7EJfrMMqLgQ7fM4w@mail.gmail.com>
X-Gm-Features: AcwNN1VTQ0b-gqYZNC6IKW5EElpQHbrMGwLT8UH3ecNAOFD9bHMtMIZWx4LOwhg
Message-ID: <CAO9r8zPEqnp6Hcs9M8dz_n1MwSvH4H+kfr7EJfrMMqLgQ7fM4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when
 preparing L2 state
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:20=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Force EFER.LMA=3D0 if EFER.LME=3D0 when preparing L2 state for VMRUN, i.e=
.
> mimic real hardware's behavior of ignoring EFER.LMA if EFER.LME=3D0.  VMR=
UN
> unfortunately allows the nonsensical combination, i.e. doesn't fail, but
> KVM itself has an invariant EFER.LMA can be set et if and only if EFER.LM=
E
> is set.   Breaking that invariant can lead to a variety of issue,
> particularly in MMU code that keys off EFER.LMA when determining whether =
to
> emulate/virtualization 4/5-level paging versus PAE paging.
>
> Cc: stable@vger.kernel.org
> Cc: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 49fb10ad1f9f..23d29597d6bf 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -789,6 +789,10 @@ static void nested_vmcb02_prepare_save(struct vcpu_s=
vm *svm)
>
>         kvm_set_rflags(vcpu, save->rflags | X86_EFLAGS_FIXED);
>
> +       /* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing VMRUN=
). */
> +       if (!(svm->nested.save.efer & EFER_LME))
> +               svm->nested.save.efer &=3D ~EFER_LMA;

We sanitize control fields in __nested_copy_vmcb_control_to_cache().
Should we similarly sanitize this in
__nested_copy_vmcb_save_to_cache()?


> +
>         svm_set_efer(vcpu, svm->nested.save.efer);
>
>         svm_set_cr0(vcpu, svm->nested.save.cr0);
> --
> 2.55.0.970.g62bdec98f9-goog
>
