Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502735B137
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786196321; cv=pass; b=tJwZDJOpymhH0uhaTcHJ5dDCB/IcPp9lhTgWEQZAhGcPd4rIJsnUusT3i+1kKLE2xBwKgh95NEseRMw26eqE3lCRTG8F5B6fui+tzjE4JLJyhg14ry/0+MNsmhcfeedopnlQ0mc08TFeF/0zDnhC654yKlYmWI+KRYYSC5zcI7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786196321; c=relaxed/simple;
	bh=71wg+Yx9OeDKkrBSUO/2kzZynVoRWwKwtzXMdscHdNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjYykCURRiNZzRLkTK7hQRcIIv27hcJ9KwDBSkoaTJ1TDXtliP8BK+3VSaAHVWrfjjY/nhbyzmQicMC2cpu4R7rgrkuKBVASL0IeA37QP8U+134RBJ763PKFLqMwRmQ/F2alp9D1jpv3fc/E5OoRqjwknnOhEbSGkZABGwZfHe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=khhJ1WJD; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="khhJ1WJD"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47fde295992so314396f8f.0
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 06:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786196318; cv=none;
        d=google.com; s=arc-20260327;
        b=mdldBNrnT2T+Qfnkc0NaMx5btMivgvf4n0SkXhpCjrVhY8ijz7MWCOsQ8/rGmUZSLQ
         fdZWddZ/O+XUuHGeKdoSaK3uAE4dLDzxNb/a/ypce5xeNMdE+q6REou+k/IqleR+uami
         OO2MOmXUb9m3JbjqK9fSFvIyoUfMabWNERT8gQO8WTjsiEPHU6N3SE9Yt/dX5xuKpD51
         A7lxCS1d1YIcbCUiqtf8vby30c7Uh2YtM1Esj+tJ6LiKQzRvZQWH4pCANoGBy4vdguNM
         j2rjGbOqg5AOGAUzd8yFrR1+RGgF5dKuCQxP6fgnaZbsvIYCib5P0Ek0jkkyF71nDsV5
         dHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LfZyWZCjJ1leqVfT0SG7I+7umcPy1TcL4EPeJOs9ZU8=;
        fh=BNVBoTKk4d4/xLoqOat8aGiFZ7RmpFVPyAN12OkpNXY=;
        b=WyHiy988ysRJEoJ2jh7pj9ySdHoA2gxngEQZorbbkWKsOriUXzR10O/oV2Q0nbSPGu
         sVSrbDdqt/e/3HC0n6gOaO1XhSdvjFwft/8dA/m+kdEbNV3vZIAxJDHyy2vLPVEJFZz5
         beLF7vqtXCL49CxHYBqBqcs1EyOPM4TOdU6x81YO8nNSKIyJXh7oF9PNa6OHV8OxM/3C
         S6vG3KTVymKBtwVJRXpDQfatMqilWMQxsu4LXOzVRlmrW+vXIpx3OdnzZkwGjh5Of85u
         n2UQJfs9QGHpjWFzZWysp5kcqbanpac0rFKyjqc2ijqnHaLl9Sw7XNgZJ1AWqMBkECUB
         43Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786196318; x=1786801118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LfZyWZCjJ1leqVfT0SG7I+7umcPy1TcL4EPeJOs9ZU8=;
        b=khhJ1WJDczt2RWIekDh2IxOrvdWhLjoMzqGCQVEIvPqFePLrF8UB9/XWtkaKFxM6ot
         2ohe8ATX/TTMXM3AoNxmweJvdTOJLyHOsuLVwVtXo1UszgGAd5Lo17Q+FXWDLGeuq40g
         GE8qo644YPVCtGdqHOh4G9UPjmJNy0AXNUdhPkqKWAQZgYby3/+4BRUOuaj4yy6B0+R4
         GHx/F0b7OfLA+eXOor4MtQY21kOjQU6W5WfxCCGAzyWsnKhjzy9ZqS5G/l7bekl/REj5
         ec1F2nuhxRkximtsr7rqgsBYbNm/S8zwEgrE7nXVy+cCI+RKcgTCuJXVlbHkgE2aVGAJ
         FSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786196318; x=1786801118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfZyWZCjJ1leqVfT0SG7I+7umcPy1TcL4EPeJOs9ZU8=;
        b=DfSyc88rsnmac7L2zODkOaT6ScTeqVPEFnWVFLH2EfK57UTWC8/2Y31knqtr5JD6e6
         EPlG0zCOwYyLJJLHiw8tYbKKKQbq35PSR281q6cn06eE8E29xkx9aChORqf7O/cdhcvz
         7IqcNAia+zNCYT/wRkklMCH+1qcpF5XcoRsbTYzOfzQGs9PZHL2mZpyv5fXHGTEX4aR2
         ZYoPvtrn8gRM1LepVZve8+oEgfTqXUEe7Cpfz97vtKtDi8UqW2HQrGkXiTtk6YKNxjA3
         ECXPJtPdqQozlPso0XZ2K+lUaCm7HUUqs7OP4sNom9umxFUkRUk4eBEflo3mw14Q3BL7
         1Twg==
X-Forwarded-Encrypted: i=1; AHgh+RoueV6SoWNzcjrhckV2LA4Ay5S1TgLOWJka2kYSvrW9SSehKSna4jm8ENwYp+NfCv/M0i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNO4HTr2QuW/d9t9ySM071sJk30PDEBx5bQu5oYu6xTxL6GCbQ
	3ScDfnWARErF9swB9YOPAc4gpARfexTdgayLc0bj81UFC9DfAGjwU987WS7oews2RFRfrr/3aid
	u0p3taJ561nndIoIvlinIV3ksFIZcmuHz73q9gKibNQ==
X-Gm-Gg: AR+sD12WniqMUAkWP2bOGUeJXhyyp7SNGex5vr9WLFXfijhebkVChFSTpybiMOIy9zT
	+rrQZx1AnaHLBD6pXxk6Xk+3dunSK5A3zqI/GkzJuz5p9UB2ZNmhD7xg5vFmxYG/nMrFWfhCLlh
	zZEDuTe6XNS4JD+OQBrkZExqCPH1wHkR5oQEGOX9O5hZwIpmpZOGx9/IcKLIPmIL9sV4xsSAFEl
	2jwum15zBIjUEByGGwYT1CW9RyDKoRfJAm4lw2K/IRVh0oeRJI6Wg+niitLVpepO+kGKyebq+t7
	nArSX4Wtg0x7HUDBfo5/v6gdgGuTMVn1j8yXXuCdhmpc5KfZaP1rll9fbwqDidmJYkotp1AdwUX
	TP8G7P53nlrzdMt6pONQsPi7a1DgIWzRBu+UdC/zgC9/9Xen5IoF5oSGLHcgUCH0=
X-Received: by 2002:a05:6000:1887:b0:47f:ec53:1d2d with SMTP id
 ffacd0b85a97d-481319549ddmr7552590f8f.7.1786196318049; Sat, 08 Aug 2026
 06:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721073612.137259-1-xb@ultrarisc.com>
In-Reply-To: <20260721073612.137259-1-xb@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 8 Aug 2026 19:08:26 +0530
X-Gm-Features: AUfX_mzyJKN77fdCLGM6gmkcr4GuDsVCUAGD0eNJkavB7H9aI1HM5JR4BzibWXc
Message-ID: <CAAhSdy3kDmRxcT_+dOpcUVAkvZ-F0kWdQett+mTy93gPDkwS+Q@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
To: Xie Bo <xb@ultrarisc.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 1:06=E2=80=AFPM Xie Bo <xb@ultrarisc.com> wrote:
>
> KVM device ioctls are not serialized against KVM_RUN. As a result,
> kvm_riscv_aia_imsic_rw_attr() can snapshot the physical CPU and HGEI of
> an IMSIC VS-file before a concurrent vCPU migration releases it.
>
> The HGEI can then be allocated to another vCPU before imsic_vsfile_rw()
> uses the stale tuple. A GET or SET attribute may consequently access the
> new owner's interrupt file.
>
> Serialize the entire IMSIC attribute operation with the target vCPU
> mutex. This prevents the VS-file from being migrated and recycled until
> the attribute access completes.
>
> Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IM=
SIC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>

Please address the new issue reported by Sashiko bot

Regards,
Anup

> ---
>  arch/riscv/kvm/aia_imsic.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index d38f5de08..2a4f88efe 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -969,9 +969,13 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, uns=
igned long type,
>         if (!vcpu)
>                 return -ENODEV;
>
> +       mutex_lock(&vcpu->mutex);
> +
>         imsic =3D vcpu->arch.aia_context.imsic_state;
> -       if (!imsic)
> -               return -ENODEV;
> +       if (!imsic) {
> +               rc =3D -ENODEV;
> +               goto out_unlock;
> +       }
>         isel =3D KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
>
>         read_lock_irqsave(&imsic->vsfile_lock, flags);
> @@ -995,6 +999,8 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsi=
gned long type,
>                 rc =3D imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr=
_eix,
>                                      isel, write, val);
>
> +out_unlock:
> +       mutex_unlock(&vcpu->mutex);
>         return rc;
>  }
>
> --
> 2.54.0
>
