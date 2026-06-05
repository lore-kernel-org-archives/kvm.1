Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5C4DBD79
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676065; cv=pass; b=dpuC3GFARpq4hSWBafep+06VCzwm3wK59xdQkkCECdQvb7gyAwHiTQVnkG+jHEJ9c74mU+dztUZeurFlpOawUgvhF9Q/blqIi1U7CUwHnTz6JqhgVAahg2JJgTKPQUmjLIjAsTGKmh5wTnBEsKI/0F+zSptA/WWediFLhOQbIW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676065; c=relaxed/simple;
	bh=dLS4+xsww8K8sz3NhR74iFOWktUATnYG7ItzoaSDSh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUrjfB+Pr1UAox1gOjOFhST6tkdhHflcSxIKPOtJlFwuwrp/jICYsSVY4bQhBrtIn+umAUerM2Q/0YJ0jmuQ9hqqmAUC/pD1mRKUA1rjly6gLLqslO/FhMGfUwLoZnpR3+bBAx7jGF51ldQ96ot++M45W86PgWTqa8qB4wwW8Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=eGpvo7YL; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="eGpvo7YL"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69d92dbc420so1449317eaf.3
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 09:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676061; cv=none;
        d=google.com; s=arc-20240605;
        b=VOHfGkZmW+34lYMqoeBWjBGpp1Tfwrt1nbJrknBQi7xWz76BoZ5NZubgtvrNf+wF6n
         wlJgS1xqW5IqBoxwzqEEruNgJWUMUiDlr264uzGd4KqSGkFSo9HYX8ZIE8doOWxSXUjj
         N1FsGcFgJYZ3lwGkBbi2MW4JUgDljiKiO1U2xTDIiMcwBR2M6JERVDzlqOqgZaG6hHC/
         Ka8XPZ5Ad46CftQFa3QMmFfOWssCvFqkYyQtYPyU2HRAwZki9z3xEspWxA27kdqgbkF5
         9eT/OMRnv+IyDwmr8Yr4ylUafT4T8u6ulOFyQLSSBgM0/k3rAJW76Y81WaZ9z1DISSOj
         MN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7NtIoBpAV8Yt8sLUxmMCGh/qfsofFoAAgy815UWWYi4=;
        fh=Mmk9NXBME5TR4v86KpNE+Jx6muph2xM8nDpk2QFSPpQ=;
        b=MTawaYywMy2opssi/tn1ZBaF33Fh8ZZvVIuvpeWb7cW40Su4rUW1XFu6qFEHZZYAqU
         ieD55UhdyEy1T+1u7xuRrK0iv/SaXsCzoqWTPjvgmF7wcIhjowhzGJf5Jqq/Vje1nMJA
         SQTSgtIGTwruclOeRZmCaPqOMFx9Z/qwWb2tLR6LzwUgJSv6qyoDyKqIKKg3j13xFuHO
         q/EVyc+ZT0och2vBKw47zCP2oboPWJrxjpK2VZYtnKcLXHTbAH7PN3rm58bks+6xdnKq
         8wPK8OeJCSf72LIg47DZ72Lycj24jY3MJFr+PXiwrgPTdCbSP8s8S1CvA2WicJvVMQEN
         vH7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780676061; x=1781280861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NtIoBpAV8Yt8sLUxmMCGh/qfsofFoAAgy815UWWYi4=;
        b=eGpvo7YLwjsd9ZnVWrgkHjV4nWwMTioaaOK+i2V/Ui7kc0JXDGK3V3hdWCJAho7lkQ
         S0SPGeS4ENjwIpxDHwJjDXZF2ztUb7UmMHj/QGl0bGoZhsbCE4U63a2A8ursiNjtmFvf
         Jgeuo/Qub2wsT0qN1uw8ThvGSvZC+ME4+JQskXzOivXdS1ObUaponQxhY0TnWHnArD5w
         BH1C2hR0f32JJJT97JeaWlEy4Qyjj/06C5CMqh+P+ueD3oF+WSY+u9S99ur1s/2hMr9U
         clNGP5iPnZNdaB0FtBIZ8NV003NU0/izjPyioJtnoeJy6DJjWGk7ja+0AGusaXsxsEcq
         G7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676061; x=1781280861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NtIoBpAV8Yt8sLUxmMCGh/qfsofFoAAgy815UWWYi4=;
        b=PZeC76Rd4kYF9v8CBAFOraxtcI9BFZmEw/a9qmBSxieZEf5W3TxwXAOOBPXTG1adVJ
         ThDLlJfp3SREvjfpVLnMGal6+9hDOKUXUxp4OoZKihhMBAKU7tZSjvdlRUKd3K70q+VF
         /4qhWAF5CcAf9jb8YvUFWZ1qMYiG7H/vFRohcPBLd1c2CIfH8TidtmZ0TXY36fm3pxdf
         b+MxeyeLkxGcBzTqaz0eJ72M8P1Uhi4lw02K5hdn8iSOoeogHRYB813U7r4dFl7W0oAG
         gEHNb46FRMjxF0roAf2mrcHwZUxp6NRrG96k0zBIB8t+n7MHjgtxo0azg93xZ5yRXWfA
         XKFg==
X-Forwarded-Encrypted: i=1; AFNElJ+L1Nob7JLVZuAfNqIf5uLcIKEteADbaM58/ePx9qFHGmNzVboMpd4kx1lITQVQEfHZzck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0BKZMJ4qQvfk4jp2mr1Zt0UcPB4oCTY4WqlwfoxEJddvJCDK
	xuLsI/xA96QUZ4HE1/F0MVegdw3gDPkBCg5xAi0meOTHkGsxwlX98sMAXAdcBcqOn3tJ34ZP67i
	z8lv1ugg8jaK1MSyUKD41FlyfiwgOunbd/418LrtgaA==
X-Gm-Gg: Acq92OFMY5HDVh19cEfsSfKIFUTkgnoMeCSzNDP25ewWZd52ueWI4SXNMs50byjBkyx
	8alUPVaJtuKWHHOoMS3FbZRyV4nS+kzivKdt9Mt31klX84myMrdgkdKcaI5ke1b5QlrqX4rGNcb
	zsy4+ZQMbAlZyd0Wnv7XTfE8jap323Egmdrf6Im1nd152sd/HaQrWb56La+KngizFnYO5MmHhQ3
	BMIRDNwS92N3wXK0CuTgHOXuTSxue0kiaal6sEsWnW6otfaBkLk5zg1G/N7MH5woV/pymilSGF1
	fBruxiuu0JKYf5wucdi9jNgARoUsncINaL9eVehFP9sa/g6SfczqL91RQtx7IMmKETZJlxcn5lR
	SBl6SdPdglW+PmO0wx/Vamb8DVQcVixrEzoNu
X-Received: by 2002:a05:6820:188f:b0:69d:9288:66c8 with SMTP id
 006d021491bc7-69e68b41cc5mr2597061eaf.13.1780676061024; Fri, 05 Jun 2026
 09:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com> <20260601-kvm-get_reg_list-v2-v5-5-415d08a2813b@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-5-415d08a2813b@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 5 Jun 2026 21:44:08 +0530
X-Gm-Features: AVVi8Ce62RKsSjJXp-wBAJPsFgxeGW_0U3nJg8KcNtHwU-Je7pjwoDXpaiVHSug
Message-ID: <CAAhSdy2oeV=XjQp8YQ9iMwHVQ8B3HDmmUbhmbbYjRLvbp6daow@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] KVM: riscv: selftests: Split SBI FWFT into
 separate feature-specific sublists
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
> Divide the monolithic SBI FWFT (Firmware Features) register list into
> separate sublists, each testing a specific FWFT feature independently
> with proper dependency checking.
>
> Previously, all FWFT features were tested together in a single sublist.
> This caused issues because:
> 1. Not all FWFT features are available on all platforms
> 2. Some features depend on specific ISA extensions (e.g., pointer_masking
> requires Smnpm)
> 3. Tests would fail if any single feature was unavailable
>
> Add the feature-specific SBI FWFT sublists with the following
> improvements:
> - Add check_fwft_feature() helper to verify FWFT feature availability
>   at runtime
> - Update filter_reg() to handle per-feature FWFT register filtering
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 60 ++++++++++++++++++=
++++--
>  1 file changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 5033c09201ef..cb86cb6b3635 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -27,6 +27,7 @@ enum {
>  };
>
>  static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
> +static bool sbi_ext_enabled[KVM_RISCV_SBI_EXT_MAX];
>
>  bool filter_reg(__u64 reg)
>  {
> @@ -149,6 +150,14 @@ bool filter_reg(__u64 reg)
>         case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio1h):
>         case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio2h):
>                 return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA];
> +       /*
> +        * FWFT misaligned delegation registers are always visible when t=
he SBI FWFT
> +        * extension is enable and the host supports the misaligned deleg=
ation.
> +        */
> +       case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_R=
ISCV_SBI_FWFT_REG(misaligned_deleg.enable):
> +       case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_R=
ISCV_SBI_FWFT_REG(misaligned_deleg.flags):
> +       case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_R=
ISCV_SBI_FWFT_REG(misaligned_deleg.value):
> +               return sbi_ext_enabled[KVM_RISCV_SBI_EXT_FWFT];
>         default:
>                 break;
>         }
> @@ -193,6 +202,27 @@ static int override_vector_reg_size(struct kvm_vcpu =
*vcpu, struct vcpu_reg_subli
>         return 0;
>  }
>
> +void check_fwft_feature(struct kvm_vcpu *vcpu, struct vcpu_reg_sublist *=
s, u64 feature)
> +{
> +       unsigned long value;
> +       int rc;
> +
> +       /* Enable SBI FWFT extension so that we can check the supported r=
egister */
> +       rc =3D __vcpu_set_reg(vcpu, feature, 1);
> +       if (rc)
> +               return;
> +
> +       for (int i =3D 0; i < s->regs_n; i++) {
> +               if ((s->regs[i] & KVM_REG_RISCV_TYPE_MASK) =3D=3D KVM_REG=
_RISCV_SBI_STATE) {
> +                       rc =3D __vcpu_get_reg(vcpu, s->regs[i], &value);
> +                       __TEST_REQUIRE(!rc, "%s not available, skipping t=
ests", s->name);
> +               }
> +       }
> +
> +       /* We should assert if disabling failed here while enabling succe=
eded before */
> +       vcpu_set_reg(vcpu, feature, 0);
> +}
> +
>  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>  {
>         unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] =3D { 0 };
> @@ -235,6 +265,9 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu=
_reg_list *c)
>                         break;
>                 case VCPU_FEATURE_SBI_EXT:
>                         feature =3D RISCV_SBI_EXT_REG(s->feature);
> +                       if (s->feature =3D=3D KVM_RISCV_SBI_EXT_FWFT)
> +                               check_fwft_feature(vcpu, s, feature);
> +                       sbi_ext_enabled[s->feature] =3D true;
>                         break;
>                 default:
>                         TEST_FAIL("Unknown feature type");
> @@ -897,11 +930,15 @@ static __u64 sbi_sta_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_hi),
>  };
>
> -static __u64 sbi_fwft_regs[] =3D {
> +static __u64 sbi_fwft_misaligned_deleg_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_=
REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.enable),
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.flags),
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.value),
> +};
> +
> +static __u64 sbi_fwft_pointer_masking_regs[] =3D {
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_=
REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.enable),
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags),
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value),
> @@ -1129,7 +1166,6 @@ KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
>  KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
>  KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
>  KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
> -KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
>
>  KVM_ISA_EXT_SUBLIST_CONFIG(aia, SSAIA);
>  KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, F);
> @@ -1206,6 +1242,23 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zvksed, ZVKSED);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvksh, ZVKSH);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvkt, ZVKT);
>
> +static struct vcpu_reg_list config_sbi_fwft_misaligned_deleg =3D {
> +       .sublists =3D {
> +               SUBLIST_BASE,
> +               SUBLIST_SBI(fwft_misaligned_deleg, FWFT),
> +               {0},
> +       },
> +};
> +
> +static struct vcpu_reg_list config_sbi_fwft_pointer_masking =3D {
> +       .sublists =3D {
> +               SUBLIST_BASE,
> +               SUBLIST_ISA(smnpm, SMNPM),
> +               SUBLIST_SBI(fwft_pointer_masking, FWFT),
> +               {0},
> +       },
> +};
> +
>  struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_sbi_base,
>         &config_sbi_sta,
> @@ -1213,7 +1266,8 @@ struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_sbi_dbcn,
>         &config_sbi_susp,
>         &config_sbi_mpxy,
> -       &config_sbi_fwft,
> +       &config_sbi_fwft_misaligned_deleg,
> +       &config_sbi_fwft_pointer_masking,
>         &config_aia,
>         &config_fp_f,
>         &config_fp_d,
>
> --
> 2.43.7
>
