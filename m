Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD312EEE9D
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780813250; cv=pass; b=m9RGmm3Kr5GCdEEo7tsLco+JWNnt/PUVMFuVAFJKEnZm5z7iDtn/C0WzWo9/erboFO+hWmq+g3lmIKXRF8s9QH2CPicvau5FkQtSkB1v1L61pn57cQibZtL9E5SuHEu2grRQ7SKoDACSQeK/mjVd4HtuQIcrlvUb333OgNSoZgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780813250; c=relaxed/simple;
	bh=kLHb+tSwXmVCIRNqZSECys5wVvfa/d8RSHH9kzcCgxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaW8t6KbvivjkWlgBBb06FjlBdabGLVExaw2qHtom/moVU2jxWC0LdDxb3yRzXH3bMLM0VHixrocXg/cxbM0kmb8ehRqJ/3segyH96F0Tr0KDr9GrB1CFp8AaJmfQcVE8Trs8U+v7yE6qd0jcyRJMVx6CYLtNbfnWLmhrsOaE1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=CONZ2kY/; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="CONZ2kY/"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6b554044fso2581900a34.0
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 23:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780813247; cv=none;
        d=google.com; s=arc-20240605;
        b=XVzg9svQpk1uFWv8dwujuuw2E0Uz1rf91r3jGCvyD+MQD3h7BMzSNQICY3lqYx0qfM
         cV7II0sYGl71IASV6xaLjOShmOHGy/YrOJC7hRQekbbGGhlvfYFz/hT143duW3JHAg/i
         GdgCYovTPmDaZBNwoleYl+uPiS8MP28e9ownj85COjZAcxfmXQW9FkHyu0aawNUdgyBI
         7I0z5HsDAHb7q0M+iqR/cjgFlzMfXBYJGrO1c2Pba8PYYwvqnWxScyYeP4lvgCNsXtP9
         THDdMXYVtirrPxqeNEs3oqalMN1N/SIY17lM+o/jrb7ZYowFcccZkX5TkmT9xoLiZ8Ta
         6kXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gMO+4PHG/t939Q89oLYKxNGAoD1wvOTj1EN3jlptu/4=;
        fh=woxasNpmdn0aa10F811W79LPC234NOr3lzKkdY2oEFw=;
        b=FN4/h1Kblm7gBtICUUyy/iSsZBHF1aIvVWB4qssMJihzpkFVsCjyzJVLeBKzmOH6TT
         8rxtZWtv7i8r/roTr8baeq9ZK18y+r/wTkOXEEELzT/BUCQ06VEERcIqCrGL0hFiUrPU
         oVyTA8TvsowCU+0Ruv9U0UCjBUJjygZA+AjkVPQAmytMBQO+iWvRNTNXyNtIZFGSBV5e
         I/e8JmW5g5uafMxyHtmCAt0v0bpfNSAwYe0viIGXip6rHxrCGh+14t2PYCiLd4q71i2r
         GXWsDet3gihnZOwcLqQdGvsk2rp9XDIoWKRRwY4v9VszCA40aY/yEJ6LZyDrkN2S4T7x
         Fv6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780813247; x=1781418047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMO+4PHG/t939Q89oLYKxNGAoD1wvOTj1EN3jlptu/4=;
        b=CONZ2kY/EtfGSmalrswNCsa2c/IpiZY4UU/JMJaovodW/P8z2qSgRoCgfANI7X4Qz3
         Lv0ayybZAaqoDfIDhhP2V9GVufhjlV1m1Ab3mUcr3XHZui2IdYHzfz4OtEweWzaeIhUn
         2NaP7RbpVoKNpLGOFG85VhPd/7lay1PLKmGBL/anNZc7z8FPEorQSN2Ni1hQfvrgRWhH
         s+LKdfSIlTGVOxLCchE5aloQ4xzYcUUeUoXH1Jf1WvVkQwJQou+UpO9r38phR2xwxj9j
         6415uUXhi/GmRXb0xBIE+7Klqa58kW9Y+tuMxFHDIkkRo3Yl7NOhi+yuCyS3c+s5UPka
         Ut7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780813247; x=1781418047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMO+4PHG/t939Q89oLYKxNGAoD1wvOTj1EN3jlptu/4=;
        b=ZPuW4omDnGWb3uYOjttSyt9iDbkeAptWMSHVGbcw4XlheFc4jnDBS4NXVZz/zC+97j
         iBwUMl/YXJLf1oCCnJtuar6xVlYu2Z60XRzGN+7xmogp6NCy6k0xaQPy1dsD/afkkgLB
         MiL4fwRZp6S4AqCWJgtsqMvmHPLbcFcdst04Wb8D0THt3kbzN84X4keJ4xTUay08q1DP
         fga9qzSWQxu4mMdWKN7plEO6HjVmy366KSn4K/+Ir9zzwnlQKSJwqHO0zNH1TCw2xLF4
         G2skgq1CfT9+w5lY4M5iuPSOiBlK3WhpobsXjTbmWl1/YXntDR4EFWuaO+sfv0Z3QFBa
         e8mQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AmAyheOLhHW6RvAjPge7poFVuaAiGrMxUEhIDAeP2GSm/+WuEWz9dnaq1+nLDd6smPuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXzmc7hz0YdL/1urtYcEudeoYHXW8hJmfEzsJimGO04QAlRQQ
	BUUgHOmFdS9a1Fu7RtAy6V48dT+ui/X674Mml//HN1OSn+6+S2P1FcaezlwGWOUbLTM0OkjyRNO
	3nxp+jBJ2rw2FF3JD48f+8RqhtFZ492bzP2sl6Xbhww==
X-Gm-Gg: Acq92OHpOzKjD1jGixIOuhCqRbM9FH6PYVfl12X7Zg+Im2RSixgJ1vVTx+kVYG5BxPn
	g42MIEynaxdaTEkZuA2fAoJgK7jtruiX6x50qouSEYn1AfcvxZrCfw88VNaWwrD1QKuQvg2542G
	263rkeWveO+LKVZdPnbqXBw7A+dp8QU1X6UmYqwiiIeY3Oy8YZz/BS3z6Vy/pH1DrhOgiqsyZIx
	elAAZGyVOeiVcyVtLRzWMHPyT0TEkKnFN7IQrOSd9pL5lRQssqB85nQTLVkyFEvjEROFwQlkT7G
	vBo9+PdzrDO7Lkm5l8JpmnrtCsqgS4fbNUCysiQH9vj44j/clU8r8PobnI28WouNvxqopySXVkr
	yQQzeeVlqdzUKJQ7wnDlkZ4r8Id9/lQMdqqs6zQ==
X-Received: by 2002:a05:6820:818f:b0:69e:424a:8df1 with SMTP id
 006d021491bc7-69e68b4b285mr5462614eaf.19.1780813247371; Sat, 06 Jun 2026
 23:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604230317.30501-1-atwufei@163.com> <20260604230317.30501-3-atwufei@163.com>
In-Reply-To: <20260604230317.30501-3-atwufei@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 7 Jun 2026 11:50:35 +0530
X-Gm-Features: AVVi8CcWegt3ZsT9WLUI3VPXbOQxxt07m39USNjLbCcMB0d45zm2TY4QeUPVPog
Message-ID: <CAAhSdy0KLEaCevhDTR-vK4EFZuFV5Nc32eZHhqndOuXkqW4bEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_unmap_range
To: atwufei@163.com
Cc: seanjc@google.com, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Wu Fei <wu.fei9@sanechips.com.cn>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 4:33=E2=80=AFAM <atwufei@163.com> wrote:
>
> From: Wu Fei <wu.fei9@sanechips.com.cn>
>
> Same as kvm_riscv_gstage_wp_range, the possible valid pages should not
> be skipped if !found_leaf. Different from wp case, which can
> write-protect more than asked, unmap can't do that, no splitting is
> added right now but a warning is logged instead.
>
> Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.2

Thanks,
Anup


> ---
>  arch/riscv/kvm/gstage.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index 2b141a78ecac..d78f5aeb8b40 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -395,15 +395,19 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage=
 *gstage,
>                 if (ret)
>                         break;
>
> -               if (!found_leaf)
> -                       goto next;
> -
> -               if (!(addr & (page_size - 1)) && ((end - addr) >=3D page_=
size))
> -                       kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> -                                               ptep_level, GSTAGE_OP_CLE=
AR);
> +               if (!found_leaf) {
> +                       addr =3D ALIGN(addr + 1, page_size);
> +               } else {
> +                       if (!(addr & (page_size - 1)) && ((end - addr) >=
=3D page_size))
> +                               kvm_riscv_gstage_op_pte(gstage, addr, pte=
p,
> +                                                       ptep_level, GSTAG=
E_OP_CLEAR);
> +                       else {
> +                               WARN_ONCE(1, "Skip unmap range addr: %#ll=
x, end: %#llx, page_size: %#lx\n",
> +                                               addr, end, page_size);
> +                       }
>
> -next:
> -               addr +=3D page_size;
> +                       addr +=3D page_size;
> +               }
>
>                 /*
>                  * If the range is too large, release the kvm->mmu_lock
> --
> 2.51.0
>
