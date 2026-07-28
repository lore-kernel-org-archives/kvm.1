Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14D3321DC
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254044; cv=pass; b=GZtiCAmh5SOyOZiMMOSM/eWZ9Q8PptvFHUs2HXUT85V1Dj+rTQWkn1i9uyTbyy2Sl8hk8EfKJCT/jOsy6n5m7Vohjd3993QGDmJfMF+BQfu9mdzRWa6l2LmuDLNvy1aSyzd/YzhnZ/frzUDI4oiUQoOSnNAlAnbydNfj2MeYw7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254044; c=relaxed/simple;
	bh=VdgY403WdBNdk1xN9Bz16ZYD/M2uVC9qOnTtjXU5SSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vo2E4sUwZKD160m/JAAzxZnmZswyzaAb/BTDpTZ1N5xNDYH1yWKDm60WYXFAMS5m0Du5yxn5173nVGur2upemJpybNy+OfxAV0eh0/mPNjdWDZzLR6MH5q0OBtYN+eXw4BAkkn7pvTppXcEOfagMD8L29hd1kv6Wh8/6s3odGNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=xwSVATqO; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="xwSVATqO"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47de008b020so817932f8f.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 08:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785254041; cv=none;
        d=google.com; s=arc-20260327;
        b=Ygwr2v81/1bNRt4nKC2Uk6+HFVMRxXShbYyGMOMkK7IFjic7V4IztqtSG7BrrY6oRm
         fDxASk1cnSBM9tSOZYGK8Gth6PoPLq7GN5IWHLCK65CTIRXAUJwimHm4QYXp7XLwXSHv
         M7nXUQ1Fi36FbNHEuh9iRC6z2kKZe9tkE176GBi2RuTYNKmsxdOfofYVsRhbFMRLPLlE
         /D7zZFwHYtoijEKczaR6J7cYXrQigfj2oLjPu+W7A8rYoI0Rwbufc9712FU+cMLtG/Nc
         YyL/2L+C3mzNTMGneYDn+sV1isMKVcN/6ohMXbewzI7/yXxmWKbUm4yUjHxZObYfhktk
         y4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+U7EUowm/WpYWZVDDqRkyNBdiXnZeoZAf0Tk6pkUOwY=;
        fh=3obs5/69oyQ8othQ66tK4UFLWSKDaPudpncls5+msCI=;
        b=PaAKIIR201RaaR8zKh0xizs6qihx9xlCmSaGG0xieR4uuuGkPQoQM/hChreNirQimx
         kNelB1NGhUPC1mCXl7OlhjBM7h157ieCZAHLUOupv8Wg8tUaVZ6oEnlWs+rLR1BiUNfm
         vTL+mXDZXPKOlgN7JZN0GS8c8bFriOeZlifD+hRMZrriZiSVhsqd9Rs5miMdWz5pPN+f
         beuggqaoA3qz7PJp9ZF9UJaihX5Cza3wYM1IHNqUKAhmX584eljD7Z/7sUfq7/mpwu0h
         7rD3+jssaxUTsOYw1+pqa3xQa3ckHihn8llQ1uGNgUKaWwp/qDg7nvQWcIjmoqmK56b+
         twqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785254041; x=1785858841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+U7EUowm/WpYWZVDDqRkyNBdiXnZeoZAf0Tk6pkUOwY=;
        b=xwSVATqOIyzE+mwqBQHyrQ8C9WjxdeM53CK6wXHLMoUEjLfwdVeLsN4XB4zc7Mq8ny
         AaqMginj9jsqlmEyfu2b+II2F4z1YOaL9PHMG0M77KuUF1tIi/hilzXtvecOLtsSFBeN
         pTH/hRs+yeOc3uBx79ac4Nq+/zdvwdcwSoAqMrqK9NhkzJyOAiGCkwCcRSr6ZEAvbqlo
         oJPj47XipXNcR4jNCh+ZFV6YTwIC5dLjs25zYLvD7Hv7ql/zdOSR1jgLIF596t2RUj74
         znkTB6Lc9rorG3bi4SRl9BesHPrbF4FC0wtOqJJgydhj9UW7IoVzuesc4lZ3DsWoPW1e
         YrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254041; x=1785858841;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+U7EUowm/WpYWZVDDqRkyNBdiXnZeoZAf0Tk6pkUOwY=;
        b=NJYymuT6qU1Sb+taaueKfFcDz7Cljea5m4bXmXLQko4BJIZGrVavV5RbaGvSAX1ATR
         lCOGeSUX1iE3w9JYWDEI7oHUTXZByb5pxcE/ZyP7SjLZ+gYlUKKa2qmC/TsqQ5QLPnmc
         ZYY7Sg5Q+N99sMFNxwFjBYuoUimPB7/1MlsdzQk/2QMEb/d15GP4GCGW7C9CadXg/fOe
         9MaDvU09ChGupTUjb2xBrNsV8Ya2s8L2dcDI32bx+o++ikpAao7MvS1AYmUmLQtZMy7U
         sbAbxcrLVjiAPkS6z5SDh730t3KfXwm0Ua9GkzpJqAKmEzC2uC5CloWsHg0V4vmUbkb/
         zrGw==
X-Forwarded-Encrypted: i=1; AHgh+Rq59kzayvCBKZKTHdzTTxxSecxtZJMOm3tm7Tt1lIS57XHPnuIHjB0mObstBZ3gc6GwdQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwabWS25YwjCdM8TvRzL26GzZWOCrFCIP1D6Xf7cGJ8q9blfmAp
	8IZ5dJvjVvAn/TAHj0nlB9+8yUyWiDhK9PS7btu1yDQ+h3yUbqk4VCORkev9PQzcM0dHLJvmMZ3
	7rhzRQMj87QtKT/Ude0f4dXXbNLgYUjowzjQFopUHew==
X-Gm-Gg: AR+sD13afxlr7RxMN/SpZhT1aoihlE6Jy9/ILnvTgVTxyvRN2IxRnvqUtbG5QfzIJ3g
	ABxLat2oK95cQQbDlBhDotcifz1F3v9atkzJ10Dql8WNmDa/X94HiwTq4Yxgungc4iX3MG+8fFK
	i37X89tAUIqcaUnVG1K3ryudcNJe7tJyUB5hWEq8XV2PpXH6noYP6im2SXKoxxpYnrRLZCNi4de
	/kso166aX3jbqG/vl4i91SUeb3Ve4eWhuf0x5U1dr4+7AZCJbpLwzk2QNdqS6y0pTnxeisy180a
	wYYK/stXagdekuo4o1KcWJ1U9rFvb/5Vk7hBcQr9EHsPZkPtI0zAH1fWP2550v5Z/tuW+iodGdQ
	B7RZCRQvPI//L/xE=
X-Received: by 2002:a5d:5f51:0:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-47fb1e9992amr3932927f8f.12.1785254040632; Tue, 28 Jul 2026
 08:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709115610.287420-1-yhchen312@gmail.com>
In-Reply-To: <20260709115610.287420-1-yhchen312@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 28 Jul 2026 21:23:49 +0530
X-Gm-Features: AUfX_mwzsyiunp_bPATfO_O8RiK5DjkNzGjCdX_kznFgbSWBNjYBF0Izm64N9aI
Message-ID: <CAAhSdy2r8Ei9ESdSJB8McC1T=Atp0yNa2MxEbOWNVRTUM_8YFA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to control
 VS-mode WFI trapping
To: "Yuhang.chen" <yhchen312@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Quan Zhou <zhouquan@iscas.ac.cn>, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 5:26=E2=80=AFPM Yuhang.chen <yhchen312@gmail.com> wr=
ote:
>
> Add a kernel command-line option, kvm-riscv.wfi_trap_policy=3Dtrap|notrap=
,
> that controls whether a WFI executed by a VS-mode guest traps into KVM
> (HS-mode) or executes natively.
>
> Measured results (wfi_exit_stat delta / guest wake count over 3 s):
>
>   policy        WFI_EXITS   WAKE_CNT
>   ----------    ---------   --------
>   default       295         294      (=3D=3D trap, no regression)
>   trap          295         294
>   notrap          0         298
>
> Assisted-by: YuanSheng:deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 14 ++++++
>  arch/riscv/kvm/vcpu.c                         | 44 ++++++++++++++++++-
>  2 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..ee6603b30033 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3254,6 +3254,20 @@ Kernel parameters
>
>                         notrap: clear WFI instruction trap
>
> +       kvm-riscv.wfi_trap_policy=3D
> +                       [KVM,RISCV] Control when to set the WFI instructi=
on
> +                       trap for KVM VMs. When set, a VS-mode WFI traps i=
nto
> +                       KVM and is emulated; when clear, the guest execut=
es
> +                       WFI natively and blocks until a VS-mode interrupt
> +                       (e.g. the sstc timer) is pending.
> +
> +                       trap: set WFI instruction trap (HSTATUS.VTW=3D1)
> +
> +                       notrap: clear WFI instruction trap (HSTATUS.VTW=
=3D0)
> +
> +                       Defaults to trap, preserving the previous
> +                       unconditional behavior.
> +

This would mean that for the "notrap" policy the VCPU would never
sleep and increase host CPU utilization even when VCPU is idle.
Is this expected behaviour ?

Regards,
Anup
