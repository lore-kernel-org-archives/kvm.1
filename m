Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F211EA7DB
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062117; cv=pass; b=VCKqAfs1c0W3KNgery/puYxBLliRZ38cetXs6Eo0yfNIW5XbWi2ocJs5CMpMnqoij+eVKMRePo4EjxE2KsySnwj3/D54/nFIfnhC+UFH1i5P5JCI3FQvF0j5Sm5v4Fvwk/K7k53taTV0Nkf1SoFJppUgpiUOjegkx0ZAHqDYHaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062117; c=relaxed/simple;
	bh=qwGi9qS1BY2SEMgjzwDaeYHyN+nv7dANGBkDPxu3jnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gY3WPhMTXni678IugcXt0UO0cFanTZA1HT4Myp1vVjxmHe8ycWkuKwjdx54fwWYol8zVGfFFOE5vREmOF8I15ouMhP7MPehkEke7maRM0dVYG5kUqVLuKevcJ/Rtf18od/TiNEqFr9Iqt6awKz65wE7CjR6BjYdruvMhPmRp9/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=zZTAHdsO; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="zZTAHdsO"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6830f4f34f3so1401716eaf.2
        for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 23:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776062115; cv=none;
        d=google.com; s=arc-20240605;
        b=MaVph4ZUsTwUWaxrSeU7O+fd6vF1GIZNlNBjvn1AneOtD5bMjK+KAKUzRoIvFP9vLP
         +au5W9lgjLy7IEfJNd7yBnyAqHa+1ieSQfF2Tkted2f8ILl4xW+q9QL8tZetKI9zZrqQ
         VFHEnnpa00KimhLVj6ipTwNQpMY+f1yWGhEYkWmo4rP1WbRp/N321SCNdf/e50G8rU79
         Ktq55o97Hq7XuDcDJPfaUvFYPGRMIECaUH6molVqN7HY1ACP5kwgyegG+LxUZORu9zf/
         /49jsPFFMKMiNBSzLJzTL1udJsnftetMS6SJxS/9lgw0m7aS0fjzkR/5Vx+kWqK77MGK
         PREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhmEYjR6/quzdnxRuC7TxxzEx+eEg6dd48C0268iWf4=;
        fh=w2vBcacVkCkTPamCF8cfzkSYRi6hcJa8nAG+OjoqN9Y=;
        b=S4gQGu7Jvphly7JYvQsP6JChTyrCwvr7xwaPJUVaOqH98NJSd2W55m4nH4upoWJ36s
         TNtWq8k1RBKXWLuH1emY9xzcN1JhhcVqGK1vv3gGK4HzmUkwMF2Se4o5JU2JHFfILMdY
         Xa/8e1nAckc5It77RmOjPIenzgBi/U+Jwd9DYvLg/3sPs+QVtiOse6WQ5w2gQa84Cz6i
         C+HDhErJPAqdOCt5L40ZQfXT33YFKj4q5EH/rhSeEgmSbYU3VUROmhEEEALwHX1beaMm
         ocOdwnhCCkD98PFErWMKlJnijTbTP9wnoA3X8nlWzSMQG4sNCBP2IC8PE/Tgj95AAq5U
         Tckw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1776062115; x=1776666915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhmEYjR6/quzdnxRuC7TxxzEx+eEg6dd48C0268iWf4=;
        b=zZTAHdsOQnkm3Sqlmv/bs1jb2qTGHqsGHYED19zClke46E/vluibeU3MlVirr36Hk0
         rUoRFXdoZtz+vnO7LKNxZe9mq4LIKT8JKl6fMATfGmE67p0tUEgjA3rZhYPIlTRXZDDS
         hicE9ni1DHw4qMfN7JxK3xJiCF15wEDvcaAKW1dLyxX8yAvwAwfYGrViR3uBPshSCCsP
         zVuw5I7vaqCh+82+GMdfetz8aanKOUqgA6ghTNh50gwuCbnHjakf4mTkdUpykQtybvTG
         BEyN6hREh8MtTkVUJIuGsrafvB1BS6fJGhd8Sm22Re9MgmPxo9eAcaSrbOcvP6h1wvAu
         LnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062115; x=1776666915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhmEYjR6/quzdnxRuC7TxxzEx+eEg6dd48C0268iWf4=;
        b=gr8YTuRPBy/GDQhij++OYg2Nl1Qp2hnsxDkCiE/x+oFfHDEdJJvtXQHr7Q2oY6YyGd
         6Fi5RwXB2ydRT2JNMmB4kwqdV+1VoggP7cFQDbAGTUPmmbuLhFb49zt0SuHvwd9XVkpO
         rw/FfnMHulGVLmMLH7I3zOutRYvc0nCKlcS0IkeWcUc9bqr1v6cmuaq4+3tKTey6q+Bx
         WpKPH8uJOMvv5lsVwYqsoueNI6ZS7zUCjv/L1Pk4Z0eucYBJySKxQYq5ngiARtqWnfMg
         F13HLNadTfPdwZeg8dj//C8RqLLrdOAKc45Le7s9hXzAxUi56IHA47NQMMNkMtqrb2qO
         Wq1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4xg9UxaP3uo8oC5kb25KXko2UOGHJOLkEwY4vmx2rQK9VwHK8BeXWPko+3LHEIxVMiCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsdRhudNyRKirwcTaDZ4EBsSwkt55M/jTxYrOOO2LZEdyW/cX
	JT2wpPxdpXLibxDxqdHZESf6UjlLiAbJQAN+QhSQEM0SIf3Pj7ZsdZblAy83mKkdbOE1OjI51qg
	OjCLPiB5kjRbzhQvj7tdI/MofwCaYXveYlC70QDsBnA==
X-Gm-Gg: AeBDievJ73mdcMXq8wLKER2M92/y1S0cw5zzMeT8redTwdOgTnU3h8dyOND+H2iN1gg
	5gWY+KBVZFoGrZLedaso2ub1JM+EsIA1I8AnSs65qpDD7W2ifu9AuBarY23QJcaTALxZcBp1Ph7
	JJdWpPPA7ccnvQzhiRRhQ4P/WMNhPfoI5Peq4Og+9ai3cLb3M9wsDyNwTi20B/C5oiMczz8CZao
	GXow/6UnwfrJclen9e/bw6eKRxCatP6+mpqK5HSV8OU+/Gr3WodNsOwbp1S3PgMszol/U+N4Wy0
	nxkm/wRq8uTjnkJJY56QhyEAKzsDay47gwX/TW2pVhfKk5KCBpk/oHySenni8l+m2qUSFxw3qT+
	euHc+SbD4OHkaKgY9MudVnlW3uR3Z7GnPu71U
X-Received: by 2002:a05:6820:1843:b0:67e:aa1:8825 with SMTP id
 006d021491bc7-68be7ee694fmr5678237eaf.35.1776062114774; Sun, 12 Apr 2026
 23:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413054439.1715082-1-mikey@neuling.org>
In-Reply-To: <20260413054439.1715082-1-mikey@neuling.org>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 13 Apr 2026 12:05:03 +0530
X-Gm-Features: AQROBzCcl-LJ0nMVT4pylFo0k7IEEc2v2cILLcr4BVOVjWfJLHs-ruU1CPsIK8A
Message-ID: <CAAhSdy1AG8N3iGJ9FLK+JPurnDv24ABP0LNhvx19ig1WHo8FxQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: KVM: Fix memory leak in vector context allocation
To: Michael Neuling <mikey@neuling.org>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	vincent.chen@sifive.com, greentime.hu@sifive.com, andy.chiu@sifive.com, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 11:14=E2=80=AFAM Michael Neuling <mikey@neuling.org=
> wrote:
>
> When the second kzalloc() for host_context vector data fails,
> the already-allocated guest_context vector data is not freed,
> causing a memory leak. This is triggerable from userspace via:
>
>   ioctl(vm_fd, KVM_CREATE_VCPU)
>     =E2=86=92 kvm_vm_ioctl_create_vcpu()
>       =E2=86=92 kvm_arch_vcpu_create()
>         =E2=86=92 kvm_riscv_vcpu_alloc_vector_context()
>
> Note also that kvm_vm_ioctl_create_vcpu() does not call
> kvm_arch_vcpu_destroy() on kvm_arch_vcpu_create() failure:
>
>   kvm_arch_vcpu_create()           =E2=86=90 fails, returns error
>       goto vcpu_free_run_page;     =E2=86=90 line 4209
>
>   ...
>   arch_vcpu_destroy:               =E2=86=90 SKIPPED
>       kvm_arch_vcpu_destroy(vcpu); =E2=86=90 which would call free_vector=
_context
>   vcpu_free_run_page:              =E2=86=90 lands HERE, below arch_vcpu_=
destroy
>       free_page(vcpu->run);
>   vcpu_free:
>       kmem_cache_free(vcpu);
>
> so kvm_riscv_vcpu_free_vector_context() is never called to
> clean up the partial allocation.
>
> Fixes: 0f4b82579716 ("RISC-V: KVM: Add vector lazy save/restore support")
> Assisted-By: Claude Opus 4.6 (1M context)
> Signed-off-by: Michael Neuling <mikey@neuling.org>

A similar fix is already merged for Linux-7.1
(Refer, https://lore.kernel.org/all/20260316151612.13305-1-osama.abdelkader=
@gmail.com/)

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_vector.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 05f3cc2d8e..46fbf48f25 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -80,8 +80,10 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcp=
u *vcpu)
>                 return -ENOMEM;
>
>         vcpu->arch.host_context.vector.datap =3D kzalloc(riscv_v_vsize, G=
FP_KERNEL);
> -       if (!vcpu->arch.host_context.vector.datap)
> +       if (!vcpu->arch.host_context.vector.datap) {
> +               kfree(vcpu->arch.guest_context.vector.datap);
>                 return -ENOMEM;
> +       }
>
>         return 0;
>  }
> --
> 2.43.0
>
