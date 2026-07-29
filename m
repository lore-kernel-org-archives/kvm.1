Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9963D0C18
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785364444; cv=none; b=aD1m0gkIEfCs5/WgFGwn2GdfWDjJubfFvB+UXYeu9QSNlkUaC6JF4qTaGRxYJcsFR1bDjcg2EACg3lchgzf8W1opKbWLWHdTBacmWw1fk3LcOfdw4YAbO9klIAs/xD1KI8EKVTgg+It+vN4fMSbjrYmHGJMSG04An5uzPnp1EME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785364444; c=relaxed/simple;
	bh=0d7s90ZVVazxLIkAIFc6fAAnvqb+0IdFdB9k+3p45E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJzinFTkgGEczy6cyujLUFTvxA3ugnYxSTDuSqEN3K3RKf3ey7dd7+38/r+mPcUoVk+fq2AWnF0Nfq8D4FCqJ+LQtjkEHLGdyU7ukg2irEW9vqdh8OIykWmngJ8XMVWVqw9Nwlc8uozwn3NJfHQr1yNaE+KEcQlmRY2b4apXKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H95hzxXO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H95hzxXO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d02b4c3601so10589765ad.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785364439; x=1785969239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XmJqv3LbtEXaKjjxddFIB/CCzuAW9BtsEymREcKNJvA=;
        b=H95hzxXO5wanvU1SI/N86iX84fmyh9EKgtvSTGA0KU7JMA53PurBLw/wpB4xC10dlI
         fzKVI8LUT1xB1q5QF6UBo85wBFZ2KFxO/qy6ARxnNbWZUYQVU+iPpq2V6zhP2Djl6z4v
         aJCD/4uEgdl5sIVc4ptlrob0veF5Z000nbwrUxJux3zepj6Nu+fWu2Ak0cieJpIhksFB
         YKTDjevNlHTl0H1TstyQRKUoPO/NV1vag+3uXJ6NUiKXb/+ar51izxvdUD8RYMLr2MN9
         bl538I93Qd6gyyDT/i5cnQ5tdtUn/MZOGVPacS0+ChQ1z57+kIeF2CtConjZMY+0oQWD
         M0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785364439; x=1785969239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XmJqv3LbtEXaKjjxddFIB/CCzuAW9BtsEymREcKNJvA=;
        b=jiMGH2n5TMHLfzzA2OtIS9S1KElZY/kgHsiv2CmNmE5xj6gLjEM9Bm7LEQTWK65eMw
         rxG8olYG960mgi3UkHF1RUO+Syz9CrLGX3jRfaBxzdFyWJjKqL+JIB4Gr/rl8iHfSzkG
         0sMjfJbFhu7XGnx2oA0WnVWXuf+PCud1hOMTVHUsi3Th+Lk3u4jwhwN0uKnow6UZngIy
         vT+XlZ5+CxRl+yEutz4qxprK2ktobLTA+pIeJWWAUeFCAfu5QqhSpTGFuVM54TEvAAtc
         cA8EzzOhFSPWimnrGG/X8AkC8ZpHU22E4HjSrnrwxxj8/z5h2ncuj5FZQZPmBP4kZWwf
         upQQ==
X-Forwarded-Encrypted: i=1; AHgh+RooLczP0vipYhsVsGRuumRKPaF5ZEWnqg0vLNCITkNljpn7w2+Rt4+vUJcvbO6d3DvQJls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNclzMwJSPeyOnOvkVXvVQ/9qSUDgBfpltlPkULqe6Db2xjDQn
	KVqzCf6qvQFFzDDfyoZtCRaeuCRW1DK74YCa+X2j5ijoymprIKYxME7x
X-Gm-Gg: AR+sD13FexTGQVjCtuCXOyiaYVSS+Bm0XycXz445ltQpiMyJQxCeUa0zinKSal3FQjg
	tDA9NzGPMLdfB8UZDyxKOjDXJVX4jzbw2VKMlFjK9nFMCRwOMf758Ki6sJUheGIsXcRSfO6BfuR
	VPz4T30urR4vBzs+5KR2zXmMs+7V880u9frBHdWMPRurT3ou/r5rFwZ7UcqziKMyqkjKW2snF35
	h1YgCP7mi0bbyAnYlMvjaeFDFTYOBYgKfw0gjISt1crSgKDGiVAVgRzNWjSal5eOBZuZLHq331o
	j7XgbjhKskCalV3AzI7EeuNdDpVbB/w3apW6oH5Cul6YM8BIurxqJzAV7kKcDzkLqnH5YsBsprV
	HbCnP3CqGmYOSWDAAnwge3P07Z2zKC6Oitp5VUEkOMZQXDVIhMagRGKSH5TwkO3qL0+v18H2k85
	zcHQ/oe4gYSfS2dhIF+YM/JtmffvNx7G6h67yj60lMIBFuUELhGZjThxeZ6D8=
X-Received: by 2002:a17:902:e888:b0:2ca:d151:383a with SMTP id d9443c01a7336-2d035c10f84mr2037815ad.20.1785364439062;
        Wed, 29 Jul 2026 15:33:59 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a468f7sm17125555ad.28.2026.07.29.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:33:58 -0700 (PDT)
Date: Thu, 30 Jul 2026 06:33:45 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 3/3] RISC-V: KVM: Reset the SBI extension when disable
 it
Message-ID: <amp_hOi78SGkPjAp@inochi.infowork>
References: <20260706021154.210289-1-inochiama@gmail.com>
 <20260706021154.210289-4-inochiama@gmail.com>
 <CAAhSdy3qnvWF1cdxJxnJxR9jf0_BUpKbauNAuJcY_AAVaJw9AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy3qnvWF1cdxJxnJxR9jf0_BUpKbauNAuJcY_AAVaJw9AQ@mail.gmail.com>

On Wed, Jul 29, 2026 at 01:32:40PM +0530, Anup Patel wrote:
> On Mon, Jul 6, 2026 at 7:42 AM Inochi Amaoto <inochiama@gmail.com> wrote:
> >
> > The SBI extension validation callback can only fix the parameter if
> > the extension is enabled. However, if the extension is disabled after
> > modifty some parameters, the state of the extension is still broken.
> >
> > Reset the extension when the extenion is disabled so it can have
> 
> s/extenion/extension/
> 
> > a clear context.
> >
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  arch/riscv/kvm/vcpu_sbi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> > index b737e9a7a12a..3eb7b7c57059 100644
> > --- a/arch/riscv/kvm/vcpu_sbi.c
> > +++ b/arch/riscv/kvm/vcpu_sbi.c
> > @@ -221,6 +221,7 @@ static int riscv_vcpu_set_sbi_ext_single(struct kvm_vcpu *vcpu,
> >  {
> >         struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
> >         const struct kvm_riscv_sbi_extension_entry *sext;
> > +       const struct kvm_vcpu_sbi_extension *ext;
> >
> >         if (reg_val != 1 && reg_val != 0)
> >                 return -EINVAL;
> > @@ -229,6 +230,15 @@ static int riscv_vcpu_set_sbi_ext_single(struct kvm_vcpu *vcpu,
> >         if (!sext || scontext->ext_status[sext->ext_idx] == KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE)
> >                 return -ENOENT;
> >
> > +       ext = sext->ext_ptr;
> > +
> > +       if (!reg_val && scontext->ext_status[sext->ext_idx] == KVM_RISCV_SBI_EXT_STATUS_ENABLED) {
> > +               if (ext->reset) {
> > +                       ext->reset(vcpu);
> > +                       vcpu->arch.csr_dirty = true;
> 
> Let's not blindly set "csr_dirty" when any SBI extension is disabled,
> instead we should set "csr_dirtry" in kvm_sbi_ext_fwft_reset() (just
> like we do in kvm_sbi_ext_fwft_set_reg()).
> 

Good, I will move this line to the kvm_sbi_ext_fwft_reset() in the new version.

> > +               }
> > +       }
> > +
> >         scontext->ext_status[sext->ext_idx] = (reg_val) ?
> >                         KVM_RISCV_SBI_EXT_STATUS_ENABLED :
> >                         KVM_RISCV_SBI_EXT_STATUS_DISABLED;
> > --
> > 2.55.0
> >
> 
> Regards,
> Anup
> 

Regards,
Inochi
