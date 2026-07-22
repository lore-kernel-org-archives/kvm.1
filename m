Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA7E383333
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761153; cv=pass; b=slee38dGG0E/hZQmPyFTsqgFHTCCVLLVV2NP9EFLCWv2T6tASGvBsTEt8M0EfsJsUA85N3oqzWkhc++7AsAQ1niEvQ5f4e/sqvt46Omd/udTcw6LfwtqDkHz5bViE0zz2HSeTxPb9sOkQxS1gBLsWHTKyMMpBxqd/nfE41yf4RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761153; c=relaxed/simple;
	bh=tEG01jzeBNHsuJLWA5mT/0teyT+9sXASAz9C8jn0SoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdnSmcHvia3p4eShIYgluaVr8qKmtDTT/LOtKy3Y0zM1vZB0ah2VXQItkFPQp4iD/2LXPcArO68emI2VZPj1WzeCxM6S8QiyZ0ErQWrZt2kVsKtUNJ3oz7XbHuSIS5PgPxqH2jnwziQqgczSxRbwazqG+NuyIrry3KwHDnQevbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPB6Ypln; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPB6Ypln"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01c79467so96581cf.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 15:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784761151; cv=none;
        d=google.com; s=arc-20260327;
        b=k+s8r31ApfnNE/lyhdbGWmqq9ANnpRjJkku2D4LWknixaj3yBmFnvZxLsYScsMelVj
         IUyX/jZqtZeteWQ4BSY8Dyv6Xg7+We0xzY9e/a5UTARnkeB05O5bzLiXYaknlPugXUI+
         80nEmxPGh/5PlYwI69ImH06KxKw0c9Zb8M25CAhgd1VLB6Z+thPaFvoPpO62Qv1YJ1dN
         tgBhspPbDzovspteZbnnwTQDv/VeiySuPDFEjXGD7DJ8uLHvkXF38pLcQpEVBQGzgs5D
         6Znhaqv+yDRs7IvYN4M01TvvCVw1OzsLRXYDKgvP899VEKwZhJey6IHKXWephXBPPaAL
         Pptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tEG01jzeBNHsuJLWA5mT/0teyT+9sXASAz9C8jn0SoU=;
        fh=pYXacMR4TU/25UX8Aa4h3bY+Vn8plCjkBqOjrr8ZIQo=;
        b=Pl96o2UQXlbvql5uxCWOUOB4qhTFqDFBtcmaHbLIFVrVwuHnubIy+S9j+zabWeQIyD
         Sj3QLzmvuqnWzJyIjPm6UP2KglSckhwlS20i+Ivyb58UQUGC1vKxtvK7FdFecdOuh1Jy
         u7nzKRT/IhBm4mJuss5mZvAV8M6pb9aqRLZlo1/4mL1uUTzJURuasK3iLico6Kc73erL
         X39VW/6FkxPQ5k4HTsI3b/oIJ7JiIrcXFTcKz6bnyTzBbXG4moU8OSOBTOaP7Nw/dqKH
         aaOmCyDKaPxIfxytBlJDXc+qhoKKMLbV/nT9OBXxNZ8tzdQ5qKRWe4dayhgPw4XTjoQV
         SsZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784761151; x=1785365951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tEG01jzeBNHsuJLWA5mT/0teyT+9sXASAz9C8jn0SoU=;
        b=LPB6Yplnp2YaT2wNke+tKncTAg73MIdObXyuLAtHU5Bpik4PUNhcjmq0bfcoytR1nP
         SHToQDdh4YPDD23DV2pY2edVLOQceQVBf+aHgGGKbOW39v9lsczX+IQplNUNAr2H4sV7
         zouxt1iWuo2qc+aTY0nKYNUh5pCplgt93Tq8y23nkb0Q9VF/PO+s0tu1CF4XAewry0KH
         TdvApWnBretofWNLJDq98Lrf7SqvHRmbVFXqweR3WPE0XgSjyYgDGjYtE9akjPjiTg96
         Uh5XtVAyivoo1oLLqSOKhLVjdFboW3Fh6iTQ5tCq0JktLsRjX5NQbOldFCt/jIiFo/+u
         vP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784761151; x=1785365951;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEG01jzeBNHsuJLWA5mT/0teyT+9sXASAz9C8jn0SoU=;
        b=L32PJkelyRWTUZvo2/NUDjn6JtuzEvzmn5xyHpnhIIxuNVtRI3g6SJ92t0CuzIirS2
         GCHd3MzbompjVqnJySdcINsHJ5nkYt89r6U8JU6TzJYKXRAGaofwfofG00p76XuJYNlq
         liqglzVrDmF1IEoIKAqibTseXMgpYhMviU9usHq1ZgW9ZQSwMwT68qzR20pKTgH+PnMi
         YsyuZ88Ej+FVo5m2NPa9IEGUw8yNswsFVQAhGSJ6CyuQGHKQCm22pJ3mtR90U7fHQnpn
         x0VE8OLtK9R45l8r8bVK75Plg/76VfPErwyX/fTy9aBdClnjhBzIfWmjtQC6oe8drDrK
         dO0w==
X-Forwarded-Encrypted: i=1; AHgh+RqYuGh8To1qpphG8CjvsEoJNP4T8iq90JEKnMiNpQh9Nikuqig0mfSSVYiwhF/4djaFEz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTf2/C5P2VCOaMZxsIqtkSTPOvmP6m3yGu5d+RtHHSCGSRfx9c
	BVczb0dafD64Hj+dKuSzkBLspSpV/Vl7oahbVImG2XlcuFg1uge4Po71h9XlAqmO1pWuuwsgaSn
	V9YucmsUj5C0V7WwQnXz4JN+A2W4XtYxUvQ3wppyMwvN8NqDNxW39o3lC
X-Gm-Gg: AR+sD13PyPr2Sv+TcYM3+F32Dd5Jawxfql2Ba/UDhjvDU9SKDvAZOSI+W21539HAKHZ
	oHdwUrpom8Z6Uw1dE6OCWXC5V6kxksHaW627kJlyNdw3Di3BN/UYaWtD0X2VRKgplIaUs3Ad9VA
	5n84sDZiJwBT+ZQaUq5dPZco2mxwn2cpy0XLFTgivdxkIAfNvfawwz4w88T5z4BccY6kARVxIPI
	XglAhqirpH9jLQtQoWK39hbNnTRsoZN3oGl6x0108oS4RjSHu6wsg3FW8zeBAWTs0ladBcM
X-Received: by 2002:a05:622a:304:b0:51a:72e5:9b2f with SMTP id
 d75a77b69052e-5283bbe7eb1mr3613901cf.20.1784761150179; Wed, 22 Jul 2026
 15:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-5-zide.chen@intel.com>
In-Reply-To: <20260629231938.15129-5-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 15:58:57 -0700
X-Gm-Features: AUfX_mz6-YemfistKag9t-GNCG3JUJyeZeysgc5PJgPi1rfz49H0IXj3Hm6ujFw
Message-ID: <CALMp9eQJSCnNV=++u1v=ChJqW_Cf9uUtdf-FFVKtNk32xyfxpA@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES
 in kvm_host
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:28=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> From: Mingwei Zhang <mizhang@google.com>
>
> Cache the unadulterated snapshot of perf_capabilities so that KVM can
> compare guest vPMU capabilities against raw hardware capabilities.
>
> For example, if the host supports PERF_METRICS but it is not configured
> for the guest, KVM can use it to determine that RDPMC accesses must be
> intercepted.
>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
