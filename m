Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC1149C6F
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673466; cv=pass; b=VL82c5tT76nOYuShDXz5k4Cpyl+6cR6t8/QW7yAeCY1h4mmOhnZDs6rpT3AkXJnq4Hcb/8lwVif9MtjSC9NDNlyLFZzWKRjE2Clps3nl4g0BGdATxIuv5w35doRMbBuulbfH7oeb0Z2eNRuIsR/a7p/fnGdLhLDCvPqRE/tt/tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673466; c=relaxed/simple;
	bh=eMelHGD3cdQRkDg51khj7jdfPOgIx10EdmbVBnS2vYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzPv+BXqX26RkG4tBdNXAE0rKm2yor4dsYwjxIQuqg8R0ddbknU4IPWK3w0AxQrrJXxeFBpVmzOdmJJJ8tKT3nGJdWIV7Duyz9W5UYdTlfLVl08Kf+X8iiDMw71SDMgIvcWbCZI5csOBa+zcxu3V9C48TzUnamXdB5X++Pnfito=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=duCt5yFX; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="duCt5yFX"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e67e90ac4so638144eaf.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 08:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780673464; cv=none;
        d=google.com; s=arc-20240605;
        b=l0wVoelVmHQJdAZmOBBdMugocSA8dIQpZF3owVASPgal/RKGaRU2XGdoOKhzZKTqRK
         8DvKS8Ud+p+py4v2peLK+lbe8mW794Nf4WTGIZcjOAXE/KdkZVk6n4N7z8GuNoDxVZDs
         8ZhOkI56HC0UMMmfAuaImbOWjar7POuTdmJzR3m5eOaVeHLGrYArIx1C9Z4VQzkXXD8Y
         5Djcxrx5yvhwo/toCdjF0MFp8LUbOI+qW4U3jgOvOzPmtSgorH4yKGQY1L32pR3GFSUs
         NdfunFTdxiQT8a0xg31uQUDzerq1/QFpsFZfEywtspcM8SodMjNXlhjL7TlElOzmhoj/
         QE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yLv7V9PhIjsPqwrVWbCtbGOYDdOFpGh6+/cNhdyXtio=;
        fh=oDAkt8vwZH/ra2WYwxCXogNUFiaVKW45AZCBxhtqGFo=;
        b=Hi95Cl1m+XSYTV4B93EeKMeAezQDtdxR5vUC6uolrIAPcfMEFmlwm+L81/M2ihOKw4
         YHmnFfPB9KWGJESkDoYBp6jfvctkcwjSGtJtMcxkgpyR7CgjBVFhJvz7nRFbrmRVIcaR
         /23KI+RI5i4Lon4qmyrjTUbdp39bmIPxivT0VHSMIdzeN1nJZy1mDRr8jTwXlSLbN99m
         r2X88o8SBH1iKRuo4AQaS0xtYaXsJxhHPNd6q4rqrUea4EagXk60YKacumNgoTefhOEK
         E+TAeDAYnV7CqZc5bIcUORmtTuReok7n1wQhEBzmi7cDh8vvAkLsPLDiDRHAEu67oXNo
         SkcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780673464; x=1781278264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLv7V9PhIjsPqwrVWbCtbGOYDdOFpGh6+/cNhdyXtio=;
        b=duCt5yFXYu1pPhDZ7h0i0kxC3ArWOHaA7MW9IQX7D277BsppANKXCWoMAIF22gIngW
         MGwli/M4dRoKIz5w+wBJds2dieIeYOsZfoFIs0aIjAtHLfgEHCXOKxaCuzesMVZA4slo
         CnAa2qwH2x3jEGWFs/0akj4pREiSm6zzs3WFGyz54r2CMHit/B03QNdA1CdKO22t1ED6
         9VYlK95clnTL4NBLQwjVPy+ZwEGL7g4kAa5agCelFPh9E28WT6dFeNTDwR6YiIYQ9gUI
         l5PPwzT9it31YbK1UZ5qSpTCYFsDdkIx2JKJUlu7pttxHvmgRnWaAHqW81nPEG5RvBq7
         YfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673464; x=1781278264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLv7V9PhIjsPqwrVWbCtbGOYDdOFpGh6+/cNhdyXtio=;
        b=aOMwtbfe6YFZgh9GCS68PKfRPxp65RICna49zSp0tFlziuZytnFKvr028mXFxYYf/+
         cA3ABe2gvJC2720uo6CBcaf8WRKU7a5O8ciZdzx+TnXCI21clNs/jenSkJi6V+wiUc34
         jirXt1ClNjfl6KuS+uE/kowKa07lErhPLTAZ0cMGfHRYI26m88F1AuCrT1iuLmEtr01l
         5A1QxWfzOODWT+3ehro+JYs1U8XwwyP8GQ8ByXdO1mSAuKjBCw08TPHroZu5/SftbtLS
         FQr0VnGjM4cvG0wAMuJARSWltBWwbY14Dud0PTBf9lVOJH6enTcoG4bfRCJcbNV+08jP
         8ozw==
X-Forwarded-Encrypted: i=1; AFNElJ/9BdvcAoCAsRCMZlmxcVG2pgXKdRcJC1ME0vEqTeQthlAAmGAviXBJ12UTPK95HXWvpSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSMfkrewEicrbCNIVMB2mvR0gp4ySJhVmbtonM0Vy1ZCklZIK
	0um9zUBbNnSmwgioZqzWCisphI8iiKpxOeVBiUBcNKucNkCa+mY7xLYuyLfoLIZWBjUMkx7jLRq
	SOEwwvv2O2RNVhdIg4qklj40Yis1r9qFVl1CDWau6ig==
X-Gm-Gg: Acq92OH0lNOOBWiWUy7aJwey+tBkiS9PTb7qWk6a8E9xXiyq2Z7fqDeepLwMwVc2PMa
	egM79YcUlwcuQL5ZGqE4OVBYnlXOcoXd3AB1jaWIlIc1p0k4PuDfVul6PMRHzQQhsnQXpHN049K
	iVzOcXtyMstscVR7GQJlYMoUqQIWxhwpWX6V7D09ZhT7z9qRGlqqFTMEQiN2croKpoYCx9f3INf
	YnadEnha3sLqCK1UdweNnqdydR9NjgcgqmfLMkN7A9yjzaEbsOCp8ULfk0wzKzZ8MSS+sNjo8Ak
	2wOGKD1yH2taqTt/BwZmOGzLpgJmwMGaLlIBFcud3HtLLeAKwVrGv0RldTqh5S4jziJCx3YHMe0
	R6hleHvxI7IcE34cd7Tfp3lUScp4dxm7J3V8q
X-Received: by 2002:a05:6820:570a:10b0:69e:7061:1ad7 with SMTP id
 006d021491bc7-69e7061218amr765816eaf.11.1780673464357; Fri, 05 Jun 2026
 08:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com> <20260601-kvm-get_reg_list-v2-v5-1-415d08a2813b@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-1-415d08a2813b@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 5 Jun 2026 21:00:52 +0530
X-Gm-Features: AVVi8Cce39tEXaZNh-7VPeh51marCJL4-w1WK5dzfxiMGfPYAU1071UHao6Z9nE
Message-ID: <CAAhSdy0m+ZpxBznL-gx5ozpbyLzU7rO6zZnnB=5eZt=eLvV+sA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] KVM: RISC-V: SBI FWFT: Mark vCPU CSRs dirty after
 setting feature value
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
> Mark the vCPU CSRs as dirty after successfully setting an FWFT feature
> value. FWFT features may modify CSRs (e.g., pointer masking modifies
> henvcfg.PMM), and failing to mark them dirty can lead to the guest
> observing stale CSR state after vCPU scheduling or migration.
>
> Fixes: 1323a5cfe52c ("KVM: riscv: Skip CSR restore if VCPU is reloaded on=
 the same core")
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 2eab15339694..5e4aafb0cbf1 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -521,6 +521,7 @@ static int kvm_sbi_ext_fwft_set_reg(struct kvm_vcpu *=
vcpu, unsigned long reg_num
>                 break;
>         case 2:
>                 ret =3D conf->feature->set(vcpu, conf, true, value);
> +               vcpu->arch.csr_dirty =3D true;
>                 break;
>         default:
>                 return -ENOENT;
>
> --
> 2.43.7
>
