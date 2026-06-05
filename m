Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB235AC1E
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675942; cv=pass; b=AZdfNHWaBG0qLcz48+EvQPBPI3t0dW0dqeaOvT1ZvRHmsGJ8PiopWdRl4AbxWMBeMpgHSAHpF8Y8mYhzciKE5Ri8fnNz07wTV/oDHrvFH598zZa1FWMovSE4zKv7P8a8ra+pWmHt37KpSHqb9uehfAhBulBEMKMwT3LAB/C+BTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675942; c=relaxed/simple;
	bh=/XfO5uK9c17TupHijoryKtiPHIhJ4G1dC+CFKMbv2gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbJYRwd9lvOi05q5YUxFSH+GrS7P4wsClJ9FcA8PaaH183p59a0v+sj7YriMO+iCghnqgR1RmpOguUF7ouZwPh47ohBhhHjhGJXoIjphkAS4rirBKDCzd+Wqm3glYeDeYCR4vK1mEL3+sXFBisGfYdz9FNtpXCUgspm5TSjCWF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=zof01yvl; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="zof01yvl"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8cce22e029cso39810916d6.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 09:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780675939; cv=none;
        d=google.com; s=arc-20240605;
        b=WjN29pgGcOT25BNy0fvSwXl1UuONSkSnpSpaEvjCkdMwHstTqxgJyrinGoWpdwH1Xl
         4n1H/Lp4dKMAl5BWPKoKeihPaAA8naM2RsPbC7rgw6n5onE73bU6Tarh94RvBzPkk1d9
         ANei6JqHOVAS39AHy8MggL7y7X0CnrCCMsUkuzrjqBqkgE7GpCIJuxszeYeWY/RAhNNG
         uw1KK/dbqASW+7s5HsmlFeMe68r77YPVtdaXG6s1/62ozHPg5BtRc1LiYkP9C7EKuGtX
         2OMZUL4avjD4FMJdR7LV/mGCtbCgyPHuZx2Kbs9viPw7cHknO9XhTOZDjFGNijUHkVFb
         CrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xPaw6mSt+SZ0+7hkZ5t+m28KWYkm5UvxnSOV1wRbNvc=;
        fh=RutLvX4NWwbSIZxUmYuJtsuRyTr1UcJagUcefNmndBM=;
        b=RbiBcPMWjq3uUXWidyEb/zI+aBneYYSf8wIaYMjxPlKrXJVD5+gbPy79qdMKvGIGVB
         uTYXzdLYI9cXsr9PyOX5CisVAuImiFGsYshX80MMSfwc0Xcs6bki8TeNawfIaqkjyxJj
         I8evdGQhkFXHCYeapncTkHxg0ojV026MfCuUc/l1mA/qc+Gms+x4FoDpXD8rT7CaIbRi
         4r1F0EhyoaTiZZ/TSEYjNMPQo20wlMjH+qwyQkPnfPQbIywBDAY+FR3z2o/j7vBokYU6
         ACcmd3qupEtXQw6tSG0RhzsVBLBOVzA+L1mMHC28qpHkMNB2PZzHK66Y0GP976MSpR06
         8S0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780675939; x=1781280739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPaw6mSt+SZ0+7hkZ5t+m28KWYkm5UvxnSOV1wRbNvc=;
        b=zof01yvlb1tEoUKrh1SpQLq1jYRg3ht5DNjAPnHlBuO4H/4BCBZ8icKKst4KP7s2D+
         M4HlTfezv+EbEUjaTbB3OPyBeqShSnG/k9kTAHEOfMMJ2AWM+w1ov4vnsA24V+q3niUJ
         VD01QRx7JYZLd+OIaQpBfe6OOtQRP8uvlov+NIguHQQ6mgzeYcIFSwSlwIjop3G1myIM
         MpPIlU/dRNMlWNNmysgdNO9qPmL8WqYQn17e5mH6S43POQ3KsvPXC9QncYLkgr+m82+P
         SsrX1kDehNpZFyMWzaWcZrkTO6+UIw3sHyl8zwXDrJcNsjGjTZQzjrCnMoOInCsTMuxg
         jqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675939; x=1781280739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPaw6mSt+SZ0+7hkZ5t+m28KWYkm5UvxnSOV1wRbNvc=;
        b=tPmbR08ScEz1rYeqoGQOB6QG+GA1R/pl26wZKC38Sd15wxuueUtPwk//tmXOHHfF66
         02C3nz4H9RNia3HA6Iq3GqGK1yt+uUd+Lputm/GNcs1tz5q5ggns3rIlzUPIMfsYjqQX
         pNJTkYCNrSFBHpH7arqKwlOK/ooFtz7OsH7kF+suvwzqoZrVtgW2FMUd45jJ7x3N9o+E
         V1tKRuDhfBHq5zRRtvwP+GNE8OR7bDge3l1DXKu2yCQt6aZFXRCsmYwPnL/CqF4L/I8P
         h2WFMVgsvKzQ0/MX5S6GaezR5BZmkuBaQR3pW9JkR4nDM+gB9qny9/lbl5y0He+UIAhd
         difw==
X-Forwarded-Encrypted: i=1; AFNElJ/2F6chn+fOkWnlfHcmleuUcugG8gedicnScEAgtRpM8l23pJ5D4iIdlpQp5mfs/c8mGDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Hg/+QfqZ9qaxI8yL+/AHOo0l+p2TehgxuwtdvnK9oS65MYmL
	4E1rK4ykVxvdRIob3zWYNOdAFmb6nxp2ChrUMfGdExW5AjV1aCTpif4ILN5WsTMWAyY+vnAjNne
	Ej6jmwHPp810uCqJldZTTYPFBxpSD3aEtmuorhP0xnQ==
X-Gm-Gg: Acq92OFABOqO4ASgAmf/G8ku5mwq9jugDUz+EaC88ZTspzk86+lj3gtyu1Ti5UenSMX
	OkqeSIKC0q1Xl0qZtolrdLFY60zn/7+Z+14WiawTMooDms7phUqJgWOvdN8yu/Wk9npNnx/PBfx
	WZ4BxRExmZZnRCKO++kzqiyMrEnaf/kQvt01YpQjGgJBq13Hc/MeMvY0njmufx9SSShWAtBtO6I
	DBs3jsqBXweRfu+s5JL6aG2QcMjyd4dvdC+Fc9Vn2VQUIugDrPPkRFFpxdStF+HucbiVjCSC4EZ
	1vh0DQ6OK5fChwcgdA7Bl+u5muH6xBs5Nbx5kLeDs0t7sXCZBEOjkCxn4NFj7xNsMjP73umRS4W
	DRINboYlHImAG8mPlYvO8H+XHgfkO9+6rUEey
X-Received: by 2002:a05:622a:1144:b0:50f:c403:7ffb with SMTP id
 d75a77b69052e-517987acbbcmr40203221cf.18.1780675939140; Fri, 05 Jun 2026
 09:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com> <20260601-kvm-get_reg_list-v2-v5-3-415d08a2813b@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-3-415d08a2813b@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 5 Jun 2026 21:42:07 +0530
X-Gm-Features: AVHnY4Jd3LwHzYiVtfabtRsTfsG1iw3bev0LUzu4pHEM1i3Lnky8Ia0dxnf5nH8
Message-ID: <CAAhSdy25VTfezS2zUsuTCTZ+Bwie7c-oHQYOWod1ix1y5rWOWQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] KVM: RISC-V: SBI FWFT: Fix stale feature exposure
 after runtime extension changes
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, greentime.hu@sifive.com, vincent.chen@sifive.com, 
	zong.li@sifive.com, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, inochiama@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:56=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> Fix a bug where FWFT features could be incorrectly exposed to guests
> after userspace disables their dependent ISA extensions at runtime.
>
> The 'supported' field in kvm_sbi_fwft_config was set once during vCPU
> initialization based on the initial hardware/extension availability.
> However, when userspace subsequently disables ISA extensions via the KVM
> ONE_REG interface, the 'supported' field was not updated. This caused
> the following issues:
> 1. FWFT features would remain visible and accessible to guests even
>    after their prerequisite ISA extensions were disabled
> 2. Guests could configure FWFT features that depend on disabled
>    extensions, leading to undefined behavior
> 3. The static 'supported' flag and the dynamic supported() callback
>    could disagree about feature availability
>
> The fix introduces a two-layer checking mechanism:
> 1. Add an optional init() callback to the kvm_sbi_fwft_feature structure
>    for features that require hardware probing during initialization. This
>    separates the one-time hardware detection logic from the runtime
>    availability check.
> 2. Add runtime checks in all FWFT-related functions that call
>    feature->supported(vcpu) if the callback exists. This ensures feature
>    availability is re-evaluated based on the current ISA extension state.
>
> This approach maintains the cached 'supported' field for initialization-
> time decisions while ensuring runtime availability is always determined
> by the current vCPU configuration, not initialization-time snapshots.
>
> Fixes: 6b72fd170592 ("RISC-V: KVM: add support for FWFT SBI extension")
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index aee951f2b8e6..ab39ac464ffd 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -303,6 +303,8 @@ static int kvm_fwft_get_feature(struct kvm_vcpu *vcpu=
, u32 feature,
>
>         if (!tconf->supported || !tconf->enabled)
>                 return SBI_ERR_NOT_SUPPORTED;
> +       else if (tconf->feature->supported && !tconf->feature->supported(=
vcpu))
> +               return SBI_ERR_NOT_SUPPORTED;
>
>         *conf =3D tconf;
>
> @@ -433,6 +435,8 @@ static unsigned long kvm_sbi_ext_fwft_get_reg_count(s=
truct kvm_vcpu *vcpu)
>                 conf =3D kvm_sbi_fwft_get_config(vcpu, feature->id);
>                 if (!conf || !conf->supported)
>                         continue;
> +               else if (conf->feature->supported && !conf->feature->supp=
orted(vcpu))
> +                       continue;
>
>                 ret++;
>         }
> @@ -455,6 +459,8 @@ static int kvm_sbi_ext_fwft_get_reg_id(struct kvm_vcp=
u *vcpu, int index, u64 *re
>                 conf =3D kvm_sbi_fwft_get_config(vcpu, feature->id);
>                 if (!conf || !conf->supported)
>                         continue;
> +               else if (conf->feature->supported && !conf->feature->supp=
orted(vcpu))
> +                       continue;
>
>                 if (index =3D=3D idx) {
>                         *reg_id =3D KVM_REG_RISCV |
> @@ -490,6 +496,8 @@ static int kvm_sbi_ext_fwft_get_reg(struct kvm_vcpu *=
vcpu, unsigned long reg_num
>         conf =3D kvm_sbi_fwft_get_config(vcpu, feature->id);
>         if (!conf || !conf->supported)
>                 return -ENOENT;
> +       else if (conf->feature->supported && !conf->feature->supported(vc=
pu))
> +               return -ENOENT;
>
>         switch (reg_num - feature->first_reg_num) {
>         case 0:
> @@ -527,6 +535,8 @@ static int kvm_sbi_ext_fwft_set_reg(struct kvm_vcpu *=
vcpu, unsigned long reg_num
>         conf =3D kvm_sbi_fwft_get_config(vcpu, feature->id);
>         if (!conf || !conf->supported)
>                 return -ENOENT;
> +       else if (conf->feature->supported && !conf->feature->supported(vc=
pu))
> +               return -ENOENT;
>
>         switch (reg_num - feature->first_reg_num) {
>         case 0:
>
> --
> 2.43.7
>
