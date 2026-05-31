Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C74362156
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240364; cv=pass; b=YhIUh4ZJj42LW9VVhjD42B++C8fPJrdtdoIxeN/Cq7upnmtVGaOg9jtEmkIeS6svQjlokl6yEm/+zy0Q+UDWSv6cP5Kza0STX/2q8rHOJdogz4+EhAv0CwDzRLRMlfoTLnAaRGwt93oaax64LDC+eJ8KnJx/HwhzCM6h2cYiwjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240364; c=relaxed/simple;
	bh=pQcs7hxst5S4iJJGnLs7TFFJGboN0rI4Cef7BLH+mbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhQcL7J4owcaCLyfgdGiQvgSG4WN/KStCEe/84Yu2CCsuUQ+eDivUu3k40qPO5ZZKbxqY5zx3dJjIqwkl+d1fS16kExr6NAyN8j1mUzxz0rZ3mVKrFOwLQPoNeCxkx5nNjEofToantjp52tPUs2j/nDtr6gVYOY8Sidt7iJnBl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=VHpNV6Td; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="VHpNV6Td"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43b4dad80a5so6553467fac.2
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 08:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780240362; cv=none;
        d=google.com; s=arc-20240605;
        b=dTMUc1UHIDjLAWX4b5wrhSEEpamaKP43NskqEVTWeQHfg8hxajHCEAJLdA9I5OftLN
         tNopuxwJfWWPD4xR4UFNE+wau5H9bDy6dpLsnoBYPho52RE8KMwBFtkIbKolD+4BuX5e
         xJZh9rgLPh5jLkTiseWGvWpkm8f0a2cvNamNs7GJEb6QX6ypXt/xLN/M3QjfSZDiP+Wy
         Y8zY3MLWdux99de9DbdBHbzrbvnyu12X25vZjfepJhBcevu9i3RsvV9FlUwmURFQxzSq
         ktOpl+f7bk6REz7Xkt/UqxRDpdd+8m+vxx3UXjq0BRgUmFmhnvc7mC8TCbMdBS6TyQns
         oELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ht2YVEPAer5B0FIawUvEH7O2krIPHZoNfVeG+2PYK1A=;
        fh=CTwUKBxTFUrBXCIzGcH/crbwZJN5NrCPKEZMq6GprjA=;
        b=AQ8/8FjgzuEpKBrpDP7RpTAqDXAwM7MMQtsh4ehd6wr6PWz+MKU/8wxqcXAEA7O8Px
         MglLj34xxvsOu5Rrup6Gtde/iYaRbY+FoIlTbwmzV6YlIpt2wZFkys6FJi8AZMymjqdB
         IfWMRqDlWQCF7/KanZcVv5REed/7cXoG6vhMXa39515Ts0j/VzbEJDywOSviZrE2eyKB
         2yUy/OD24EdYsP/bQgVpH5aYzOWlECoyWBBzapY4LFUYS5z1NskspJx2XajhdZi7WphB
         MiR1xpSkGUGVsy8wFavoO4SkiocTVr8d9tbjwa7ZW36wPYt51Ou4UiD02WDl2HNr2xJZ
         7yjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780240362; x=1780845162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht2YVEPAer5B0FIawUvEH7O2krIPHZoNfVeG+2PYK1A=;
        b=VHpNV6TdhNNJ2ykhVemslyCohoW/iL9IpXonEO1AnH/YtwtCWpgQ5GjVlItLzT3ALc
         inDmIGI3n2HVCemMM0lWRkPOav0hYR81+NRI9GNMHwFnFEyrN8/OxGrI/oa7osfo0pWp
         96SwJWmNEZ/nvdAP+cHWFgu8HYUysPHf2vK9qXSYujKGWiAfIpUL6XiItmEIr2XbBrSr
         rDJ017rQuLdTsblT3q4deLDrc8ix3BytjzVw0ddhp1UqcZgLJm4k4+QvCT9Hhb1SUXte
         uhWTSmH/9/DabSHMWU/yXEFWX7lBt+piOzCojHwdLoiaat3bWe6wpZG46jH/NzBWjcNn
         6QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780240362; x=1780845162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ht2YVEPAer5B0FIawUvEH7O2krIPHZoNfVeG+2PYK1A=;
        b=s41AMRU5obpXcbofbxE2QoI/QDVKU/fBK8CtNHUcl5gRYDqpaJ7QQDTiGcAUffTA0C
         DBaam/Lmy3OCFOljVFtOaReb90lhQZ8jgGAxELITuhok2fzFfrBAoa3KD86wgupC/63d
         /1Qn3ME2HZto9HWI1LZwLSIsYlo3sRf96y2VeKOA45s7FchvKq68zXlnfHz4BOh3eWBL
         +S+36aKyl1ZYHFE1e3JLBh/xkAj8fGVD64oLVPpQbdlKd9B+G3pj37MKrkzOlkgrscyI
         UQzy0LAadV77X20lTKTgfnmP596ryDwBhmIhK88Vjx4h7aRoYwmq/4/PUrFRs3e9rfGM
         +RbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9mG0AEcVIPTO/nyxMBSnEhjqDXwyIc+mn8CIfK0bTLRMCrZuryeE4Q/luFLZNJL5ee3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUtNE+Pn7fRcjasfXRAmUOkaoTjjkHOhzIFmTBTZ6ZD8+c/YCi
	R5A9x3n/O236P1+oSptC3335q7tYgcDusmR5xm3asw7FwQF28Axj5o2wHojDD6FxPCLrsYLV9Xe
	Xd44f49HuGcImlnVgH0mC2sAote1Lsc2AiPCCusb38w==
X-Gm-Gg: Acq92OEktsaWfcgwWNRaDwXzkDUx8pYWba/iULhF3BRofnPi/pAbgY5ZVWZPlpBWimH
	okOwD/ra2DfkRN++dTm4TU4DjHBKfDOc1jodF/eRRxGUaIGOf6N+NhFcke1V5mF3A2Icg80Gbws
	LUEHCuiEy0DZefwql+PaOcChzot42IriFm7oratDvoqPVoOjvFHuYx3vDm241bWhMIUEbW6vby8
	bRzXiLo52NKpy8jcfbJLuA7JSoU4s75UAT/drCp/h5/C/XtVt6VeLk4Mrd+wQK46NOrIDPtf4MF
	GnuleS6HHXUA/wVEcGD8PtxDLxib5iOsQM0kaWUSrRNc2Dk7VW7dJIWbauWQ1jJhkt/cvXlRn8x
	CjWAOllfaDLVLmGbKwoi0aywXFHXsGmP+YBDGiQ==
X-Received: by 2002:a05:6820:1a0b:b0:69d:f749:7d91 with SMTP id
 006d021491bc7-69e102c9f6dmr3770256eaf.7.1780240362243; Sun, 31 May 2026
 08:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525095930.3924905-1-mayuresh.chitale@oss.qualcomm.com>
In-Reply-To: <20260525095930.3924905-1-mayuresh.chitale@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 31 May 2026 20:42:31 +0530
X-Gm-Features: AVHnY4LvLumKC5bI-Kcv9TET475eaFGsQW_NjeCOc_gBN7nA1GLTHdnMHDbUw7s
Message-ID: <CAAhSdy3fVaLOWhBYNOPdrsQziPQ6wsyeodrjjwE7ftvqty=2bg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix ebreak self test failure
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 3:29=E2=80=AFPM Mayuresh Chitale
<mayuresh.chitale@oss.qualcomm.com> wrote:
>
> The ebreak self test enables/disables guest debugging as a part of the
> test. However the KVM_SET_GUEST_DEBUG ioctl doesn't actually do it.
> Fixing it by calling kvm_riscv_vcpu_config_guest_debug.
>
> Fixes: 6ed523e2b612 ("RISC-V: KVM: Factor-out VCPU config into separate s=
ources")
> Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.2

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index a73690eda84b..cf6e231e76e2 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -538,6 +538,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vc=
pu *vcpu,
>         else
>                 vcpu->guest_debug =3D 0;
>
> +       kvm_riscv_vcpu_config_guest_debug(vcpu);
>         return 0;
>  }
>
> --
> 2.43.0
>
