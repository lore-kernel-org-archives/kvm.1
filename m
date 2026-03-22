Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8E192B90
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774165778; cv=pass; b=KN0+zPsXQpVZp8D7aZAnRwoTDePoXffl/cQ9YhLcrj6+ECMEQ5Gu8Ixi/nLKHJjrrF/rwcGBx79b7iUlMIimWRHU0hwo0NifidKeiyN1pazGx12VLVOpL00nQgBn66pGBDYUHqDEZ777hOR0v2+UEZl1q7eSkfnMytFnSQrIL8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774165778; c=relaxed/simple;
	bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiBlS3WPJjxhYMWhmoJvQAANHR3WWQwkpp4V0AxGuh4M9X5e8hWrIE3rUAShrYbw6JvJTvWvS7UYWq1GoLxIKlrYlJwmOfw6NMHaPdVQFYkijryyl6Upjq43UYKHqE25Hrj8dpootI/TMM1qTA1tPkgz/ONfseQDP66c/d8nAUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+CuJxU+; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+CuJxU+"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfc795ca97so182698185a.0
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 00:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774165776; cv=none;
        d=google.com; s=arc-20240605;
        b=XJeRxfBqdhMhxdni/blnfrE8nlTsULkzoTUZAq2QzCVZfW1vcbUvnpVFptDR/+v09Z
         Ikrv3Erxf3AHaylR77y1P9JFf5N7hSCLkV+fzsKGPcbnguPlJrf0SXP9P/LkgDfHqVuv
         Vg+lQf8xGb9JMjOgQxHEmR+Y8JAMUn4edXP64ZsJPingOfnoaUT2oC/ytiYSPPIYSYtj
         T8vXvZiqzlk8zYD9OYUHRIfTRz6dzg0jwRyFUhboOM3pW7fr4lppwoWajmzAam1Q/STl
         IjupXFuUvt8lTRQZrjLK6gfvU0jjAxcRHeASRY4Z9TWJNPgBNj6OtuvL7bhDqpQ+6vrP
         rXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
        fh=QYj4+Ph8oWHM5EKi4RsOfSwDFneEtqelfr83RmPwLPo=;
        b=IW0UeXZQTYooos40bADXgLEcWTy5Ga7U9Cb7G3AZTYbqPs7u04cqkdtyETdXVDmKhC
         je9cbpbiE6JhNgP20gcEjpP7/J5zRGvBTZbv+RIAy2z5Ii7VyMYKD8TY3fR3+js4a3Yf
         Xfe6wxDWD5Ao+KpU+WCYnNuQocKlHBHUNYm44M/thZHuDHPxAOhK4vbYpSxV29jO2J8Q
         Tc7p2yKG5FQrFhNmexK+eVbUUGqjr8IhzhoSAalH381FY4O68gC1mB5vOlcM7bygUNkt
         cQIsUTcg6YXMz4R9YWiETQoHfGotXgtupXppjg01JUXM8EY/+X5lS2j0p5XxkcO0E4zM
         HK8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774165776; x=1774770576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
        b=F+CuJxU+Q4DrEWvnxfFZ6jPFM75VPl0dxcjCrPgbCqN0AhmcmkblSYnzZnEsS7vxkP
         vHC8AdYlsqyn6lAhvSMgCDqakyX1MIzoAA339knHj5Kl5q4UiAVlKJtsANx3uJGt109m
         p98dI6ZA66tY0PTsGKOaFaG1q1yxTVNhkEXtqcUqU8k4lWXPva1NNnuRlrlhMGF95Vnb
         daHT0XTCoJ6JUVmWVelfHb4FhbSk31LAeMPARQTidrjhfFLc61cwpqqZSDds3lPRu1uV
         8AIIH+VI5bQO/VS9VHlWfMfncDCVXUsDqoeRjU6+4LeeX2OUjv0/ogiOXHjqtZF+V0Ii
         UBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774165776; x=1774770576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
        b=JRjHIedgUwxjhZ/jKl1gAUtfU2wDS87BenNhYec6wwHXqW7WwK4M+dtmjsTlSNNNld
         ACBHxPolF+az3d5JBqVi0h694O7yS2HZXvupZJrup7CArcXy9ZtR0JTicMU0ruOyn3Wi
         fX/1M3lY0mWRmhR5mRT9Suo1igWpZIN91+vB7UvwlttK9J9Fa4TzxGTV2FozBb8Jy2+y
         vUJHEpxDYV5ffbW0Yqk8gNc9Fb7iyXoYAPFfJr2Nh0cnnt2r3zYFTcc7GchInRXwAQyY
         1odCsQB7JF4eElNJIauQ3lkSKNnvO0Jl3DUot8S0m8o8hBd4ZVdgLPMoWsNXhY+HVGs1
         eAHw==
X-Forwarded-Encrypted: i=1; AJvYcCXnknuTNfv6GqTJdSYX0RDZracRz7KwVam1VEa4mC8pNS9m55l5d/mnyi6U22HpSy3+mNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynFJNV17NRJfHHCRHBXoEq0WgwYPatGe7YC3YjFz6QzuWpGCgQ
	slBa+4acZ2p8263URfYwGDxL6EyZFqTNpynWmF2QT6mymuxEdWYD3z8BIjdlEcj6JnY4i5lV9kL
	dakvNoUl+SoafkRy4zzI9NhpRvNt6/Es=
X-Gm-Gg: ATEYQzwn21Oj5TisU9iwsR330BOBRjw/lWF0GiirtYlo3TM4Q/t1luwU25mEAU3t+Ur
	7w293z8yZUNIqNynRh/22yow2+FkLiuIONSGN5S1eihQKmUkWpmGXZo/qMFrgTZaDFvowcbcg06
	h02yE/4iITsm16QP9db2AF5XbgtfNUKNhjFyiTVSzpX69QyE7CROPwMUrDQpg752NtrwOmABjZl
	nt/cjLh/nKuflMkMRESe7jyu58dGE4zT7RmWioc542P4xCZIc1lkz9bF/3PtwLFRmfkY8RegAu1
	RQsYYJ0GjA==
X-Received: by 2002:a05:620a:318b:b0:8cf:db7b:6224 with SMTP id
 af79cd13be357-8cfdb7b68e2mr439093885a.59.1774165775634; Sun, 22 Mar 2026
 00:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-2-surenb@google.com>
In-Reply-To: <20260322054309.898214-2-surenb@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 22 Mar 2026 15:49:24 +0800
X-Gm-Features: AaiRm53R0BSIBZ-7kcLpHy3OcZIzoW6AMt3M9APBFS4L2dJIHsEh5rSFscqFXrY
Message-ID: <CAGsJ_4yAWxty2PAm0Lp-iDnAm6DpReedRvus7FFQb3A2dKPTYw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm/vma: cleanup error handling path in vma_expand()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 1:43=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> vma_expand() error handling is a bit confusing with "if (ret) return ret;=
"
> mixed with "if (!ret && ...) ret =3D ...;". Simplify the code to check
> for errors and return immediately after an operation that might fail.
> This also makes later changes to this function more readable.
> Change variable name for storing the error code from "ret" to "err".
>
> No functional change intended.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

LGTM,
Reviewed-by: Barry Song <baohua@kernel.org>
