Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BACE3BB10C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387250; cv=pass; b=DzA+NG/cMYl7cmIMXqhpayE8E9I1rw9TWEAZivqcaYtWsZcpuecwmh7cFW0BoPFeJE64IOEgpfK75tYVsjGWnpc6FU77nLO264SZASf1Vd2ioGTGAGDuApIe0E5l7wwsGBIvhuJZNXgq3vGqKrDPzwF+HKJGk29wbo2NIIxTu8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387250; c=relaxed/simple;
	bh=0QwXYwBvg675psDiJIcuodozupH0wLewizlDulSLAJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SURsNDGHLwefDbaac7r38YPS2/fv3mkdlswLyXk2Wom/cBLsidHkQiN4L2+3RK83F8a5yw7hoQDVAalexheTLaG9xIxERHs5yCxUA6aPguORdqG5o5ZHu6hfgs2DKN7efVF3sKq2TINdnWydWJBceBBb7S6bnn3HpyhyILLhd8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=ORxXpxaz; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="ORxXpxaz"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43ca73487d2so1701811fac.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 01:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780387247; cv=none;
        d=google.com; s=arc-20240605;
        b=Q2v5kXgUbuTV80akMb9o+NoKmh/bOXy8jEdHrdLExjzPYThAe7e9QRD7J3TwgP9tdT
         8hYdqAgLpYn9y+3YVogohMMMI9c4EIGXLyt1VHG5ScBEjhKP3PWWiQSob60mR7TAz34d
         5mg4tBeGzS8l5qJ1gkzefIeq/HoZB+jtjvfegzEo/CvpRVROq+RZJN+LJn5Fr5Kfsq3M
         7Yss7PW+j4DPJHH3TvI/CDfFhG/CdIvuN5QreepqzBUa9yoQrURof7xEEW+EoZVkPduW
         9ku70EtprIwnZNfNJT2T0KP87LsEgvJyBe4SxpJWB7inwFRpfzFJngcjztrEuNM6K4IW
         ZzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IgrLvh/X4k97Px4HlbHkqTDpeesPxMpXfPyUt4B4fe8=;
        fh=1seGPhCiiVH/6SE3FRINKUBhE/2ryEy5v8/0iVulQUw=;
        b=gEzybUAri9oKHCygU/OBBplPBsCdbFzHrAkDxe/OlL43cX7HSKJILPwhucu+DSz0rl
         USowzOXP8a8h2bVp7OOqMTtlOuivaMAFp4Ct6OI9owZ+vS4IUjpLR3KeBTjr+BDkW4vW
         2nn6JmYxc7tyDnoI+l4dEsVMvelNPgZsztRYt+cZFT6UWI3m4dnvv2sI5iXifz9x5/md
         ANaaKXFPCyCV3S03FOwvwqKC1mrbCQRKCxZIBmKgsLgmV1DKXm5qr5BcScg+Wi3F+9vd
         um31JsaRSmnVW6Grh49ylqEunk7zTAz05a163ZWX8NPZA2t8OG63XnxT4jXajRednWHB
         3Yuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780387247; x=1780992047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgrLvh/X4k97Px4HlbHkqTDpeesPxMpXfPyUt4B4fe8=;
        b=ORxXpxazX1GZW/gAMGVnTDgkK2Z0euMod3awh8yJ5XkSzKJg/fUeKn0RUUr+ygvOCo
         tQKvVNhPPwm+0mq/zlz9odjTYlH+VV+DoJ4c3S8yFFb4rSmR6HU2mHQvBd9O//w0agLv
         ISmGobt4FHytmbOEG/QtlkIlvvi20AZEJ3PlkyCpW2HslL8/5SUupCO1qgHHYpnr6lSc
         JxAeEpN40ckMUWEhCnDdzcet02AzPqlszoe144LsmxbWL2tVrXV0Z1Qf8pncxKLIKvZd
         +9evwLe4FBEz+7NgrWbZSFdQ7RuhXKA9ffQaGqxQaZu529oz3CHU6WMTzQO9K6PP82QK
         EszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780387247; x=1780992047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IgrLvh/X4k97Px4HlbHkqTDpeesPxMpXfPyUt4B4fe8=;
        b=dC4DP3Gd1pZUeop8T4L0QIl0SJaKFNzmkV9SfWXTfjHBoatmG2axZ1djjzJj4WjwH/
         eq/pscSNDZmPs8gF+Z5rWvbXuAVSpF9Q/tJ5tNOTnKD9efQKZFDnQgL15wlgPdjsJFOA
         w8vUvmd11/WD+/MT6UmjdJ9oS0o1ZbZVZOblu8ejBzqoWr1yvFN8xGmE1bUoSY64JhiF
         2zGJLAjeemqZrLH0L1DYDqvGXN1O9oj/s3A2imqubmkuMdef26ZXsvbSqtjc4DAJlQKZ
         6aedcE4ZyZFeMjmUByxjUoWtp7s7B4XyPjrbi9CkdNi7h52oIK5iwsiARePZ/iIAfQzH
         jwlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oFbHLGKkaC1IBv6fb/p3qBgNU/elNL7NW7tpPLz7Lcp1Q5vzSEX6WOCBSCn8rKEJ9QHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7Uer8Wd5Ph6/XjuG5ZSdZGGRXmt61ga+j7385WApEQjaEjnh
	C3G88pNnywqgJsb5eyaT9Kzbia4bMkvVRS3Zgf8dWaekomszYzNlQf1HsmMZCl9aEOT4RbABnKp
	18+97V+zIVsuIK3E9irYBUQtoGFHVNFJtf9IpY6UhEA==
X-Gm-Gg: Acq92OFYxUXrWCqgMu960p3xOSdz/o93rR/7utAEqYN9G/CeNf13UFZk2uiAoo/QlHa
	/tzcwATEtpYlvdGRDA6WsNIIUAaLfo5Le5sndvxHW27l3x5kd30P0ljjpI/PBQMvAko56TLe8Z2
	YOiZWXUro01zvoGn82EwpA3A3g4i69UN9I8bSPC4gxzFZdv3/jp3WG6xw3vM/XSEi6FALOck8mz
	lVpYPHq5EM92hZWQoyb7rSdy3mI1p6WI7P9yA3uEW3J5fFovR5NzY5z5ZO9wFFABv2k67mQCF76
	vPrNoFhzt5hxPyKxiHaCmTG/Fx8ZYjEPxw6ZcEFFrrznnBnNbeJocFQXgtFaHW/09Mf/L46vnZ8
	0rB9IComls/7ebgSXT66bS10x/PqwnxAeydoYNo+fJKH8Hu8A
X-Received: by 2002:a05:6820:4d06:b0:69d:5138:5540 with SMTP id
 006d021491bc7-69e368628ecmr1455529eaf.9.1780387246859; Tue, 02 Jun 2026
 01:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn> <202605111130.64BBUjU6013213@mse-fl2.zte.com.cn>
In-Reply-To: <202605111130.64BBUjU6013213@mse-fl2.zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 2 Jun 2026 13:30:34 +0530
X-Gm-Features: AVHnY4Ly_ncquhNUG3b2y2WGAOsB8396bhb2a_G3mSJVFu24acqBWILI6kpavM8
Message-ID: <CAAhSdy25JUiM2QnJbvqsQBu5eaB4L2TdSNfkmaaqFMjNOk+Stg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_2=2F3=5D_RISC=2DV=3A_KVM=3A_Fix_skip_of_valid_pages?=
	=?UTF-8?Q?_in=C2=A0kvm=5Friscv=5Fgstage=5Fwp=5Frange?=
To: wu.fei9@sanechips.com.cn
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, pbonzini@redhat.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 5:00=E2=80=AFPM <wu.fei9@sanechips.com.cn> wrote:
>
> The current gstage range walker unconditionally advances by 'page_size'
> when a leaf PTE is not found, e.g. when the range to wp is
> [0xfffff01fc000, 0xfffff023c000) and page_size is 2MB, if found_leaf of
> 0xfffff01fc000 returns false, it skip the whole range, but it's possible
> to have valid entries in [0xfffff0200000, 0xfffff023c000).
>
> Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>

I see all tabs converted to spaces. Looks like this patch was
not send using git send-email.

Please rebase and send updated series using git send-email.

Regards,
Anup

> ---
>  arch/riscv/kvm/gstage.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index d9fe8be2a151..2b141a78ecac 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -429,14 +429,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *g=
stage, gpa_t start, gpa_t end
>                 if (ret)
>                         break;
>
> -               if (!found_leaf)
> -                       goto next;
> -
> -               addr =3D ALIGN_DOWN(addr, page_size);
> -               kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> -                                       ptep_level, GSTAGE_OP_WP);
> -next:
> -               addr +=3D page_size;
> +               if (!found_leaf) {
> +                       addr =3D ALIGN(addr + 1, page_size);
> +               } else {
> +                       addr =3D ALIGN_DOWN(addr, page_size);
> +                       kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> +                                               ptep_level, GSTAGE_OP_WP)=
;
> +                       addr +=3D page_size;
> +               }
>         }
>  }
>
> --
> 2.43.0
