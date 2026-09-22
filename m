Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD593A71AD
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100362; cv=pass; b=uKTk7z7eFaH12Wg2BHiZe+QzYIMy33VwkXnibwBtmOtT0A7BvLcCoFngTWwNqcaOGPlolE4ysY9QOneKAIVXqFWVoZ/u+zqd/KnQ/3/Zin99jHwirrtgae4HM7G4h5rASS+TQ2SnDtqFLAN6exelr4FZix35BckzQT6KkO99934=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100362; c=relaxed/simple;
	bh=m++GKzPyuU7UHVuvb7Ivk6mNPNP0mzBVQQ4H9v+ex2g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtTv6aia7+2fdINUfCzUC7pzxTR5CJaHNtBAUXyqkxWzQltq90jrqugHDXoMIUPY6PuX8rfRFgBOucqttFk/bbxZrVu6VbIc1lqynlEiCVBVjSeBpltuBvVYfqxaHEitpIaks6noZBP3Wz4Gwattza579muk9bw8I4PBPhPuMhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TF7OwM9d; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TF7OwM9d"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e56a1fe83so97035d50.2
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790100360; cv=none;
        d=google.com; s=arc-20260327;
        b=U178ZAv1Hu7TMHVAFpD7wNhMfMC7vNK+h79YZQh4NsTx2XbyS4Y73T7c9ZJ8qEnJ7w
         o/wdN+TqD8rBpG8lQuSvVhX1EchEqjXzCdPpG2ChAVmTNGZGvh5lDaSHPkGf2D+gsZD5
         cUV6rMYeEkuJg5bZbbdr+2nxKJq/tSIc2K2z/lzC0+oAzpaoaYgHr3d+CKC81qM00z4b
         +SsDeJEt+QKCeZKK0W/0cxLdxoXMtsG9i64CAxFBOp63XwzHcRv8IX8Rzuhk+l0b+CxI
         yqybjNXZfeLLZytTI4E8obLNfo06Jse+9iUD8m7WpQFHNK8fYjLIsWwEr5xjY0FkD0pu
         WW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lf7w8zPr6dt4VhD0eugxOymopbvSQ3RHlj+JN+XDuo8=;
        fh=KM1WQt2MVUpxTCNr+guAxDZK4DUgK4cQgsDAG5Mr04I=;
        b=jBLSc3vdKChVHnxVLy2VA5wSmXHehpK2mO46W6f8/ADL+KFhsyu1SjUpNu+DpmRgBP
         WePHB9Wy/knGw16BFMOd7DxmLLIndOnlxiPD9kaZ32DCsJJCzUp7dWlMzp+s9rTI274S
         j9Pte/BsvMK5QgI9iOie2oPTSGkHnbAbT6AQDNxPjwDKYOqbFKJiWxIBUZNmQGEn6sg0
         ELhSzEctiNgwRF+FDS3sJsm07s2WIjJgOwWloXJKl0y6+TmVOXsgdyy2FroV0K5n9fX7
         nvSytgBXMyVAoU6q/6uFV7ExVNHrNqSEe91wr6z2vmxLPtbZj40UVfKSr+JpHDyJCNGo
         Kdyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790100360; x=1790705160; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lf7w8zPr6dt4VhD0eugxOymopbvSQ3RHlj+JN+XDuo8=;
        b=TF7OwM9d87e88gdlAAFs/xW9gM3CHo5HBAMw7enXZJL9z/zMQ2OzNCPkGpnkH2KlkT
         /Ib0P3bAQchVr1qFiWwCY7LXdJtLxH2kcy1tr1IuFb0RjtKPio+pDBAAUgJeubd2iRoi
         IZzV6OulXPxBgSCJmKwMTz6qlf/uyThW+chdC1HTWp6E7FrjMZ2uIAJL0WRbHN3HbGuT
         +3yVLhjdXs/fkjGPkSGhzgZEfgZhiBlWlhLHjd7lLJ5rQjJVGsf97SnPwGLWIk+ch92x
         BnxFQyYLa5m/T7GI5VP7JSJGaEJHm5BhKasgE5jviAvCklsFDQT+j0FPJ3TmriL7pyLw
         xHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100360; x=1790705160;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lf7w8zPr6dt4VhD0eugxOymopbvSQ3RHlj+JN+XDuo8=;
        b=HWgjNIXQMnHcTqabpftzMumPwRD1nynCS8gwIXVX3Bn7yD+7GOE37cfEKc2XAVisDe
         JaIijBWeNYEchP5af6j9x8nN4pYCdT9iNpp/eMmpZcBgb0WqOBjC5onjkwreo5cRUrXO
         eAsmNonnHwZmOT3bKAZdEgN12GNgVFDKKS+0yr+lTaWOibl1WXpvYdROeFoSJwWPHR8R
         1OhvfMNXRJbyR5x6ZOBtKfC/J3CAyyBa8novCP4UaY8M8zBfy6aWIvyIqz/fE6UqI/Ks
         a6pUFb2g7CTWT8T/0wMptuupkFjOWrI8lxUXFEORlfKpP1MAwo6RlPoXguw60mLv19gp
         pb2g==
X-Gm-Message-State: AFuF++kCrrm9Y7jj1Ydjl1jnrl+qp2g2/vwWXROSmZXuFg9qh4UonjRc
	HQ3voKXWqhfy+sF5O2TnztBXlDit5h5yhs7E96dSxBFSUZiuyXomrVbYVWUm98Tl8sGfQ3vvjyk
	PdPGiIYkvulBpHMastx84VDWZS1+TW17OSQorH6gL
X-Gm-Gg: AYBFou2p/o+pm9Fsy4dM0ZlFqVxIMVX/VXWvSysdwwfKWOtSYZLvqTkH++zJxVTuXWm
	/M8lFyTEd8+09qqKZnYjB956Sge0PY2MzzOD91GaLiGKKT5Q7FmgTck9U/CmAM1upeJs4t+ICUY
	6DySEhLtejRq5qPyQYEQl0ieKIHGassaILpa22bJJwzeNblp4CubFinelaZMPcCy8PG/W2OnLUt
	oe9vTHASVYVWMVmDCiHpE5yOYyRxHrzzMM1jjqNdaMvgbHdRZcEEQ3v48c0KDQU8s/jZnH3BC/1
	hBNoKtvyVv2vLgbwohcwLa1uft2dVRS0NwKMgqhi1manG3+J6c94TxPRn1y0medyJyuel1dSFf+
	AG3cr2t5XJDEjf08QSTMZlMAQ2DcGF6tPyRfG3m8Hdg==
X-Received: by 2002:a05:690e:1286:b0:672:c272:f6ec with SMTP id
 956f58d0204a3-672d59bebf8mr157304d50.80.1790100358515; Tue, 22 Sep 2026
 11:05:58 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 11:05:57 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 11:05:57 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260806170602.4112602-1-seanjc@google.com>
References: <20260806170602.4112602-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 11:05:57 -0700
X-Gm-Features: AcwNN1Vwfxfy5stGyMAgpGhv0mGDDhp716mx7weUKBt_bAXRsWwCzdRg7UtOnP4
Message-ID: <CAEvNRgFZBHqiZuXawTjDU1oPR=u3yqBzXW5ku+B2rvMAbBM3vA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] KVM: TDX: INIT_MEM_REGION fixes
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Haotian Jiang <jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> I completely lost track of this, meant to post these patches weeks ago.
> Compile tested only.
>
> v2:
>  - Fix an off-by-one bug.
>  - Use gpa_t instead of raw u64.
>  - Tweak the order of checks to bundle similar checks together, and to perform
>    the super basic checks (alignment, size, etc.) first.
>
> v1: https://lore.kernel.org/all/ak0skG064rhKUC8d@google.com
>
> Haotian Jiang (1):
>   KVM: TDX: Reject INIT_MEM_REGION if number of bytes would overflow a
>     u64
>
> Sean Christopherson (1):
>   KVM: TDX: Fix a benign off-by-one bug on the end GPA for
>     INIT_MEM_REGION
>
>  arch/x86/kvm/vmx/tdx.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
>
> base-commit: a806d364ef288a6443a1337820ea8410a7ccc6b3
> --
> 2.55.0.679.g6767b8d81c-goog

Looks good to me, just a question on the use of check_*_overflow: I
thought Sean didn't like burying an out-param in an if-statement? [1]

[1] https://lore.kernel.org/all/ag8BmtzxTlcuA_zy@google.com/

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
