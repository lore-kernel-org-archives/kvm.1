Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D8226863
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145630; cv=pass; b=ot3X09SQeFO6qmSybAGJX+c0dVzUT2m3UAn6eAb2/qZxjZCULH/7QHoEMOiX4dfjcanoCvbfRjSW/hLqNKNOaJwNsmVfAhb8SxMTBWp9tYiydAJKRLbiaizUkFVFOX1E9wWuxEfBxXdlc3tir7olUzh9feYXo/tCmEbuUKuBULc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145630; c=relaxed/simple;
	bh=7YkuxUFn56TUXJI7/gBIV/bBF80lP9EXTcMtIG8OsN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2FR98IPOMiFgZ+/QNztER3p8WoXASdNdnDz86Uq1hpw3gIotqlCqdTtxTY/bXzgm3tQvbst5Rv6ktt1HenJNJL3z1pH8s1J7Lny0DXeDg6DmD1i07E4LPyDoN3s5KOZGkjPkTLI8hkR5BBbLtqmsuX06Dmf0TRttwIEGEwCLy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=kZWqPCKK; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="kZWqPCKK"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-67c20ed3076so624669eaf.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 09:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775145627; cv=none;
        d=google.com; s=arc-20240605;
        b=HZ1Tp+NeZp2hxr6TcsauEfZzUJ/UGyXxyq32QZ8wPUD6w2MDzoMGeivSCd5XFg6XYH
         SKLK4hdLHa+W40373fMQTXPQbgF1x1Vd6xzBnpVTlYXM0DCTuohXptcwa2CWof2JTCia
         LDuheTt9/N6XI7/01kaEq2peZuAfixy2RzRkTQsl2sQI72lBAY+qOAwv+YEoLFu0ZGCl
         rRyzXqTH8CPdim7x/wyOLaEbvWJ5zPE/MlLJjgzUJzMciL0IOg9CTTUvtjVuvgtHYMm2
         Ok0vXuzBu1ycTuupWnRiZ22JJzcFy6VKf2+mgT5KwgkKONAErX6CnuGwWKhAov8tTxWt
         k4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WtM2gelQtlkDLtUyeOY/RQAEzxS8kBtRhg00qUrjMDQ=;
        fh=3PRVefIgbF9HkDkaM+oxPoeZTQhnPl5aJwPfH6NC8QI=;
        b=DaLqJhXYbq5C6mPhvVPdI7lR+3eM98CfpFsQkqk2csRrswwGNTZbjZ/hyB9g1aoOlq
         hbEy2Dg2v1yJIuMhP9UA+mo5HH5lRP6QvyjucjgLti3AzCqQ0mmsHxGJ0TvPbkqqwboK
         Q4PBMcnUmAM+i1Tw/eNv9/db9SXnLcVHKQlk1BRl+kzB2Q29XBjjnyntNNBHqVJbm0BI
         sEvG/NsV1sxk4rgImlZJH68/YR+jxN7QJ3W9XHqY6LbaBQ4FeLM/fKN2ICatPRmXExCF
         9/Ez0sjw7vjZfhkWmiGFSEl2mwjysZCaSrzTOpsIB3R8COpOnOnwSNWop6gXreSqGwFo
         Cqfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1775145627; x=1775750427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtM2gelQtlkDLtUyeOY/RQAEzxS8kBtRhg00qUrjMDQ=;
        b=kZWqPCKK+rSvS0PU3djNTzI5Un6IliGJD2h3RwVVYHa9o43/OuOWGvh4kxlWHcLq72
         AAykxcYCTxYDzHitQysXNXtnQYiEcdubIw/Pos94tBK3B2gdpJ/K9IQzf4yWAtz1RCdt
         ErR+gQuXytJ2UyBA1e4EvXTDT1hlhe7Sz7CLwqD9EL/uRZfsG5Sh6nE2Tc+whD0jOYvs
         ZE6nbm6iMqyE34dwjkfTTKNIVCPIFC5FW0r4EGZ7BVRtQVAs0KviCTqhdlnK+LIzVafW
         WV0SsvSYE3LsJUbk7kYwyftDJazBWulpLrCLB8F68QxqUEcHLDi7fxK7QoWT/c1HR9yq
         C33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145627; x=1775750427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtM2gelQtlkDLtUyeOY/RQAEzxS8kBtRhg00qUrjMDQ=;
        b=puIA0Li50X+EquHbEF3Amq1mnMRMZxQw/XXYO5MuxDB6T6kt+XOO9rwPvKXUmFfD8j
         SJVXix+g3LRprbyERHc++qBzjFTnNh1SiI3Fg9n2vXeClg8/0IefNyxTUyoLDuSa0RBR
         UwnMYXg3fopjwK8uhoPLqwl+8SNT4wKNMnGRsJzkBLUZV5ZwLZlBFeyS3k11AlUaYj0B
         dSirt+TT6QqMhqs86RYwxNUEpnm0mZMddq/4JMt19HBAYLzkld+wpIYdpCGJit68ZTi2
         llnn0kJgTWFuNM65WLCwboQhWP3l76PgqFep98Ua5FgcsrnoD2MSjvr4xRRTopTYJsXw
         Geug==
X-Forwarded-Encrypted: i=1; AJvYcCVeodqyLNQw6cJXl25pAENPLvjNR1vGCMVECd819ApO+Cm/F+9g6Xc8J67P2EOlX/X3AGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtOtW51JLUlWohv3PN2U3VhqtDKmxyvoGHBHy7ZGWIUkkbd3c
	XHpRxi94YHi+M9A1mQeHtX+mzBG2ldr9iVdGyyxOuX/Uv6roRoDFVsOiENYY22O1E5vuuYErAVY
	gXmTEfpijJ6wLfHReQcDxOEAILZIKi5KpmETY3pKH8w==
X-Gm-Gg: ATEYQzx6VaWLVDEOijJCnNXbVdKajVe0FjijwkGHD7gCop5X51BJDmR+WLcFz9EKcmm
	FuCwbpodgvXW4QXfn2G3Nw/X55ppusGwiUB+1XrDKkDyVlNiWwAO6QW5IJy9/55PY2QoFPfvwWP
	4KHq2VGXc4fC1BEgBAHIInLCE8YFQlhjmGyMm4SPL1R172FDwUqn41+hH3r3ZUJ23kRw5rEx9EL
	D6mwzvYuZdb3Jzbjy0HoGkhghD98zOZePGRldO20SJDb5+8WDpmIzkVcbypC6maotTUMgXSY6q9
	CZolMFa/lHRa4Y353rIy411IYroMxK2IMQGRoKn60XwpgE/41Yd8IUiGKtGidmFlw4NT0/Fj9EL
	7/vMof0GYAN0UAX16iypBYuZ82Q==
X-Received: by 2002:a05:6820:1992:b0:67e:16b4:aa07 with SMTP id
 006d021491bc7-67fabd02b7emr4353699eaf.61.1775145627522; Thu, 02 Apr 2026
 09:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402101818.2982071-1-mayuresh.chitale@oss.qualcomm.com>
In-Reply-To: <20260402101818.2982071-1-mayuresh.chitale@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 2 Apr 2026 21:30:15 +0530
X-Gm-Features: AQROBzAd1C5PJZt0gGUQZy-ZILEi3rG_cTSfqG4yBNpRYZjiqBUpj0qc4P6OGJA
Message-ID: <CAAhSdy0FP=-KQV_QaMVWJz9gwEzm2BdVH857MWx28Jej+S+vMw@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: selftests: Implement kvm_arch_has_default_irqchip
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 3:53=E2=80=AFPM Mayuresh Chitale
<mayuresh.chitale@oss.qualcomm.com> wrote:
>
> kvm_arch_has_default_irqchip is required for irqfd_test and returns
> true if an in-kernel interrupt controller is supported.
>
> Fixes: a133052666bed ("KVM: selftests: Fix irqfd_test for non-x86 archite=
ctures")
> Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  tools/testing/selftests/kvm/lib/riscv/processor.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index 51dd455ff52c..067c6b2c15b0 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -566,3 +566,8 @@ unsigned long riscv64_get_satp_mode(void)
>
>         return val;
>  }
> +
> +bool kvm_arch_has_default_irqchip(void)
> +{
> +       return kvm_check_cap(KVM_CAP_IRQCHIP);
> +}
> --
> 2.43.0
>
