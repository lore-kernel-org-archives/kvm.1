Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E96395AE6
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620378; cv=pass; b=ZausLwTOBHm63R1ltADLcrbDkfXrx7JLRZKfO1t4Z6PKC+nmN0kDf48NqXnMt/AVgo1IdRLfaUGhH1xHaPQwAe4hcZeeTtptZKR8brC6nTiCzEJ+8+j1YCXSBmuDrgox44A4w4RAvuo1Uf3pP7gWk+02+JF4J9/IXeq+ZB5IuCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620378; c=relaxed/simple;
	bh=Q6kS7dp0Ju7mzF/V5lLg76g0UFGylETcp1Q8cP3duxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmYaahUoatzabuyXjAwzTrPNV15+xmFc2vGrsBAh+yCJlGmxjtRLLhU8nG5Zv8HA771ZZd0GYdAS4SWuh7CBv6vpYUiePxhdEXdnMX+pnWOx+6Q8Ai1SGVr8yrcuG/TSq3GMUnnWkuQt/mI+SxBFo856b+Bme8kPFWdgpINZyFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=kNzzP4Z7; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="kNzzP4Z7"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b060ec084so242199f8f.0
        for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 01:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791620372; cv=none;
        d=google.com; s=arc-20260327;
        b=rLiRRGnA/9c1qmAjV3ntxPAoMOcqqdC+mDjxOI6xTpowc0rNLmCmci2XOAsYnIvvLj
         uQLouQ4/uRTQH/Tqr+K5rV7oKqPlj3wVHKaKH7MoyaCRFY3Ao+T4LcPI5CNMlCXvp6gh
         wnU8kgyFwegWovzhFKtDz7gnjoVrjPs41M6UVXHa3BEOY3YN23LD4f8Sv0DnFVZpQ0IX
         ETFJ+m+bNjmoSeRKx05Ci0SN3QM8biHR7cvX0F2NGJ+34xsoFAjLnGcmBG2SdF+vqPo2
         iB5173hHB9VGLxOXsSBdVSUedFtMxHOndSaGKR+EiB+qwdA4GlbUICgbBXv0FE3E7xpu
         cs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eJAcUqXJGt/vgXa9GZ7GShb6d7iyVL+vOjTHPKzbgBQ=;
        fh=mo5+2j41SUMI8UZ6XKBMp7tGsW7xiFK/rgTfa6qRrPg=;
        b=MxTsyC7c+23qf2125IM5vngLwuvW9UcTXfHnTMe7YrK39+37sx9FALMyAlkAM4mcbZ
         2naE0jDoASuS2FkBHXHi2dmLhOG8dw0p6wKGVpoXteo6GRwK4IcaYWa0N11MK1gJByrX
         ZtvV0IRtJaD07vP19+bdqJB9WJfzxr13tWutBHJ8jfxKjUr2NGC79C8VWRE4GxHWVy6Y
         ICCV9qaaO/2ewwHZOKBvFJj6ZY5vaKUadqCPvnwQlttc+ABJmSZ7Fawh/+17ZpmYRA4C
         l7Aoe4FTTD2DQgxOtOlAGBUFyxDw5lvyVkjWlNB2E2XbDprvKQEuObFNk3GucR7q1pfc
         lV6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791620372; x=1792225172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eJAcUqXJGt/vgXa9GZ7GShb6d7iyVL+vOjTHPKzbgBQ=;
        b=kNzzP4Z7Dvg95MozCdiIMFb6sTIk9kATp2Q5BojOYdzAEorSvm4HF6K9EzYliLPMvR
         li4ZBowEf3JGjSNWqyj1OwSwDHMJcXdYmfx6cMJdOEwb6ZDYlu5L/EM6WGHeaEuUU/n2
         Ua45HaqRpD12zM5fMLn6oBMPmJE8rC5qxqE7DulR1kHxZV5XCa/aHH7RjRJiZPpPqZBw
         51kkvJ004tF0c6j6mHOk9tj2w3uHC+xS2Y3uS531K8SaVMUjCCFaLUUZLGoEs1jv0eh5
         g1lUHmlccyZXhgKTMXs9FQSDrGC91WBAwVePfo4V+AJnj4RPJ0RPCKcGUZHjQYi1G5qh
         ErGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791620372; x=1792225172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJAcUqXJGt/vgXa9GZ7GShb6d7iyVL+vOjTHPKzbgBQ=;
        b=e4/0zZVutNaoleQu78KqnIhl08QvymZBbYztymqW2ykIGaT9adJdCS6bTFZb5GD3SY
         R6LZhEcYydImbFecywemNkhJIawP8lAZ9UBB+/H/eYPjwLbCRvNkLcD2ksWfb1pjJny6
         hDKWZ/uDRZ4T+2X8Ms/PHn/35cy5wJiKQTXzVtSn3Ovby082iUMFCqGezr9KX0CrSWDT
         aF9P9Bqaws0KpYI6sYa7vJHiM09pFM4IqHEiYRp20OZwbO/FNzqhSi8YMecpLobH3lgQ
         xNmionkTKH6+UFb89V+vwzklWMEoMAeIM/98BPFBdnubi+OBLImH5tfD2ABjs+c32esg
         2xCA==
X-Forwarded-Encrypted: i=1; AKwUvBwqIGMR4AbDf/6a5upV8hAi+YXmEsLqCvkW9KAy9c9dkaAjz/lxZMQhpWbODmO9bgtB6M4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0GMXvhx3jxrOXY/isRl8GbOK7EpSRKd5zqkoD2ra5RpaiAz1v
	pop3p9H7NeyqgjeX0fnqGE2oVOaA4/5h253+EWOoKkDIDikalAtmrm2yYI2kbxlMuRIgaqtFqFV
	SI4xpLWDcdm2EZSbGcxbUlcydSK/pIB0cGNZnC0evMQ==
X-Gm-Gg: AYBFou1kkgymV3+Zhb0sn8JJPlnYHGdswmHpvv3tAdOMpCFRpn+Exc+KtG9wg41DzFa
	Kx8V6T80Wp+4JlmGOC/5UtgZyfMsNzuAjBtzJfJP5NHykm/sJBaEFc7G2TRxgVe/JmRSBytqsM/
	xJWMnGRUSNy8lrjMD82JD0f40Il8NcMt33psjKRMRheAqAjds4eAquAOwUh4ORkbCHKj//UTvWP
	wfjmrcKgU4Z969CtA7ofuM03jAiuOrAuqz/dXl/wQa3EQiVQiTrrzKu6Q9r6v9l6H7ZwxrpWnld
	VKfiQik9D3lbbgV7DDREwaZJ7xNMc0FxjzSESBzOhIJEj0W3NSIFGEtIaRDhtim/Zz/2f9ZNg8p
	4BvpWU37Nu7oRZ2t32OipG8EaKGFnddUIHM3mh71o/AjxyPT6b/G/ieJXyqKir6dDxMs1MC436g
	==
X-Received: by 2002:a5d:62d1:0:b0:488:898b:5c78 with SMTP id
 ffacd0b85a97d-48dbacdaa8cmr5627615f8f.29.1791620372560; Sat, 10 Oct 2026
 01:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917121411.2445-1-yuanxiaofeng@eswincomputing.com>
In-Reply-To: <20260917121411.2445-1-yuanxiaofeng@eswincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 10 Oct 2026 10:19:20 +0200
X-Gm-Features: AclHuK_H8g4fbdkxc2asMP_7tuI8E-2FjvrSJcbpkWIFCSu4mU5mOnQvBEl1rNk
Message-ID: <CAAhSdy1KEZZR+QPa0QeEh6_t9eW3=aHD-CZW6fHRZndQVuB8FA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Replace imsic switch-case macros with range checks
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Cc: Atish Patra <atish.patra@linux.dev>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:14=E2=80=AFPM Xiaofeng Yuan
<yuanxiaofeng@eswincomputing.com> wrote:
>
> The imsic_eix_read/swap/write/set accessors use a family of macros
> that expand into a switch with 128 cases covering the EIP and EIE
> register windows. This mirrors the csr_read_num() idiom required where
> a CSR number must be encoded as a csrr instruction immediate (e.g.
> drivers/perf/riscv_pmu.c), but here the register number is merely
> written to vsiselect as data, so the expansion solves no real
> constraint. It costs ~90 lines of nested macros and trips ~30
> checkpatch errors and warnings.
>
> Since the generated cases form two contiguous windows, [IMSIC_EIP0,
> IMSIC_EIP63] and [IMSIC_EIE0, IMSIC_EIE63], the same behavior is
> expressed with a simple range check. Introduce imsic_eix_ireg_is_valid()
> and use it in the four accessors, removing the macros along with the
> ~30 checkpatch errors and warnings they caused.
>
> No functional change intended. Compile tested with riscv64-linux-gnu-gcc
> and tested on QEMU (RISC-V virt, AIA).
>
> Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup

> ---
>  arch/riscv/kvm/aia_imsic.c | 124 +++++--------------------------------
>  1 file changed, 15 insertions(+), 109 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index c1af23e79..5b6927733 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -67,36 +67,17 @@ struct imsic {
>         __r;                                    \
>  })
>
> -#define imsic_read_switchcase(__ireg)                  \
> -       case __ireg:                                    \
> -               return imsic_vs_csr_read(__ireg);
> -#define imsic_read_switchcase_2(__ireg)                        \
> -       imsic_read_switchcase(__ireg + 0)               \
> -       imsic_read_switchcase(__ireg + 1)
> -#define imsic_read_switchcase_4(__ireg)                        \
> -       imsic_read_switchcase_2(__ireg + 0)             \
> -       imsic_read_switchcase_2(__ireg + 2)
> -#define imsic_read_switchcase_8(__ireg)                        \
> -       imsic_read_switchcase_4(__ireg + 0)             \
> -       imsic_read_switchcase_4(__ireg + 4)
> -#define imsic_read_switchcase_16(__ireg)               \
> -       imsic_read_switchcase_8(__ireg + 0)             \
> -       imsic_read_switchcase_8(__ireg + 8)
> -#define imsic_read_switchcase_32(__ireg)               \
> -       imsic_read_switchcase_16(__ireg + 0)            \
> -       imsic_read_switchcase_16(__ireg + 16)
> -#define imsic_read_switchcase_64(__ireg)               \
> -       imsic_read_switchcase_32(__ireg + 0)            \
> -       imsic_read_switchcase_32(__ireg + 32)
> +static bool imsic_eix_ireg_is_valid(int ireg)
> +{
> +       return (ireg >=3D IMSIC_EIP0 && ireg <=3D IMSIC_EIP63) ||
> +              (ireg >=3D IMSIC_EIE0 && ireg <=3D IMSIC_EIE63);
> +}
>
>  static unsigned long imsic_eix_read(int ireg)
>  {
> -       switch (ireg) {
> -       imsic_read_switchcase_64(IMSIC_EIP0)
> -       imsic_read_switchcase_64(IMSIC_EIE0)
> -       }
> -
> -       return 0;
> +       if (!imsic_eix_ireg_is_valid(ireg))
> +               return 0;
> +       return imsic_vs_csr_read(ireg);
>  }
>
>  #define imsic_vs_csr_swap(__c, __v)            \
> @@ -107,36 +88,11 @@ static unsigned long imsic_eix_read(int ireg)
>         __r;                                    \
>  })
>
> -#define imsic_swap_switchcase(__ireg, __v)             \
> -       case __ireg:                                    \
> -               return imsic_vs_csr_swap(__ireg, __v);
> -#define imsic_swap_switchcase_2(__ireg, __v)           \
> -       imsic_swap_switchcase(__ireg + 0, __v)          \
> -       imsic_swap_switchcase(__ireg + 1, __v)
> -#define imsic_swap_switchcase_4(__ireg, __v)           \
> -       imsic_swap_switchcase_2(__ireg + 0, __v)        \
> -       imsic_swap_switchcase_2(__ireg + 2, __v)
> -#define imsic_swap_switchcase_8(__ireg, __v)           \
> -       imsic_swap_switchcase_4(__ireg + 0, __v)        \
> -       imsic_swap_switchcase_4(__ireg + 4, __v)
> -#define imsic_swap_switchcase_16(__ireg, __v)          \
> -       imsic_swap_switchcase_8(__ireg + 0, __v)        \
> -       imsic_swap_switchcase_8(__ireg + 8, __v)
> -#define imsic_swap_switchcase_32(__ireg, __v)          \
> -       imsic_swap_switchcase_16(__ireg + 0, __v)       \
> -       imsic_swap_switchcase_16(__ireg + 16, __v)
> -#define imsic_swap_switchcase_64(__ireg, __v)          \
> -       imsic_swap_switchcase_32(__ireg + 0, __v)       \
> -       imsic_swap_switchcase_32(__ireg + 32, __v)
> -
>  static unsigned long imsic_eix_swap(int ireg, unsigned long val)
>  {
> -       switch (ireg) {
> -       imsic_swap_switchcase_64(IMSIC_EIP0, val)
> -       imsic_swap_switchcase_64(IMSIC_EIE0, val)
> -       }
> -
> -       return 0;
> +       if (!imsic_eix_ireg_is_valid(ireg))
> +               return 0;
> +       return imsic_vs_csr_swap(ireg, val);
>  }
>
>  #define imsic_vs_csr_write(__c, __v)           \
> @@ -145,35 +101,10 @@ do {                                              \
>         csr_write(CSR_VSIREG, __v);             \
>  } while (0)
>
> -#define imsic_write_switchcase(__ireg, __v)            \
> -       case __ireg:                                    \
> -               imsic_vs_csr_write(__ireg, __v);        \
> -               break;
> -#define imsic_write_switchcase_2(__ireg, __v)          \
> -       imsic_write_switchcase(__ireg + 0, __v)         \
> -       imsic_write_switchcase(__ireg + 1, __v)
> -#define imsic_write_switchcase_4(__ireg, __v)          \
> -       imsic_write_switchcase_2(__ireg + 0, __v)       \
> -       imsic_write_switchcase_2(__ireg + 2, __v)
> -#define imsic_write_switchcase_8(__ireg, __v)          \
> -       imsic_write_switchcase_4(__ireg + 0, __v)       \
> -       imsic_write_switchcase_4(__ireg + 4, __v)
> -#define imsic_write_switchcase_16(__ireg, __v)         \
> -       imsic_write_switchcase_8(__ireg + 0, __v)       \
> -       imsic_write_switchcase_8(__ireg + 8, __v)
> -#define imsic_write_switchcase_32(__ireg, __v)         \
> -       imsic_write_switchcase_16(__ireg + 0, __v)      \
> -       imsic_write_switchcase_16(__ireg + 16, __v)
> -#define imsic_write_switchcase_64(__ireg, __v)         \
> -       imsic_write_switchcase_32(__ireg + 0, __v)      \
> -       imsic_write_switchcase_32(__ireg + 32, __v)
> -
>  static void imsic_eix_write(int ireg, unsigned long val)
>  {
> -       switch (ireg) {
> -       imsic_write_switchcase_64(IMSIC_EIP0, val)
> -       imsic_write_switchcase_64(IMSIC_EIE0, val)
> -       }
> +       if (imsic_eix_ireg_is_valid(ireg))
> +               imsic_vs_csr_write(ireg, val);
>  }
>
>  #define imsic_vs_csr_set(__c, __v)             \
> @@ -182,35 +113,10 @@ do {                                              \
>         csr_set(CSR_VSIREG, __v);               \
>  } while (0)
>
> -#define imsic_set_switchcase(__ireg, __v)              \
> -       case __ireg:                                    \
> -               imsic_vs_csr_set(__ireg, __v);          \
> -               break;
> -#define imsic_set_switchcase_2(__ireg, __v)            \
> -       imsic_set_switchcase(__ireg + 0, __v)           \
> -       imsic_set_switchcase(__ireg + 1, __v)
> -#define imsic_set_switchcase_4(__ireg, __v)            \
> -       imsic_set_switchcase_2(__ireg + 0, __v)         \
> -       imsic_set_switchcase_2(__ireg + 2, __v)
> -#define imsic_set_switchcase_8(__ireg, __v)            \
> -       imsic_set_switchcase_4(__ireg + 0, __v)         \
> -       imsic_set_switchcase_4(__ireg + 4, __v)
> -#define imsic_set_switchcase_16(__ireg, __v)           \
> -       imsic_set_switchcase_8(__ireg + 0, __v)         \
> -       imsic_set_switchcase_8(__ireg + 8, __v)
> -#define imsic_set_switchcase_32(__ireg, __v)           \
> -       imsic_set_switchcase_16(__ireg + 0, __v)        \
> -       imsic_set_switchcase_16(__ireg + 16, __v)
> -#define imsic_set_switchcase_64(__ireg, __v)           \
> -       imsic_set_switchcase_32(__ireg + 0, __v)        \
> -       imsic_set_switchcase_32(__ireg + 32, __v)
> -
>  static void imsic_eix_set(int ireg, unsigned long val)
>  {
> -       switch (ireg) {
> -       imsic_set_switchcase_64(IMSIC_EIP0, val)
> -       imsic_set_switchcase_64(IMSIC_EIE0, val)
> -       }
> +       if (imsic_eix_ireg_is_valid(ireg))
> +               imsic_vs_csr_set(ireg, val);
>  }
>
>  static unsigned long imsic_mrif_atomic_rmw(struct imsic_mrif *mrif,
> --
> 2.34.1
>
