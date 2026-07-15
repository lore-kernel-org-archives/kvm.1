Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C92FFF9D
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103727; cv=none; b=DdMbE/eTJHb97NDs4MiNGvOLR7s14S1WQybTL56XytNtSaPkdZQLdHc1giDfq0K8zYtrD538opKXJkucXJibeBe5+YcERo8O0de1y/Cv2vAeWaCh1NHKy8AexVrjOAYGrADmP6u9JNh1S3Pb96eYFKSDTycxAaiQEkYuMVwmZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103727; c=relaxed/simple;
	bh=kpijIj8aSEzzsZVkTI6v9ZdrTGL2je27uFs0jnCwIGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1b5vfHa4Wf3+7VEc44yBszTmpYZapc3ZWyor2fkXDB4krA1eUrd/VyygwSWolJCj02Ux00KQWhURQiYsmhYN+gABALbWfNIv5t4gqk4OVGT668WlVM/3hzFMWhi+Aup3rrIzTyPBSlaWTKWroHdfw25ooSgA05HnVilxhZpgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i8tALlsa; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i8tALlsa"
X-Forwarded-Encrypted: i=1; AHgh+RoGSkJJ+RRvFnusWtdSO8Dw9aPh3/2qUnorHQzpQlF+sku0gdbcToNhlirJeoPNjeTDf+k=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784103723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X9zPQo9Xuiq+9adYW0RkmSkTcUNVfAxuOnJE4Eack3Y=;
	b=i8tALlsaRIrUKy0amrA4gSetb3nsWbEqvqeeN0eEwDjBPniTRhT+v76ccZrJrGpXFqsbFu
	tnTMOB8U68oi/CWOf3BTXFbSWVT/J3qLq0usZxRP2BsZD7O8M1sGykXPk6wkkI0FY/osre
	VbQHmQeT0+p3l7+7U+OaVPf1gxMAqAI=
X-Gm-Message-State: AOJu0YxYRtn3ZFsUY3u7VsFpO46PZ6GRicagbFqRnAG3rnTUgmoD6bNv
	L6Wv3XFJopBrdIXcvJ1poO8MetYai/L9kEG37RoPGPKV+BMNmIWhjvapWA/rMRmCrHqhpAbBA++
	+QprZe9LRHjtb69g2JlcUfTtxjGJ7E2EozRLSZPRY
X-Received: by 2002:a05:622a:a591:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-51d71543adamr24625141cf.3.1784103702868; Wed, 15 Jul 2026
 01:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-4-seanjc@google.com>
In-Reply-To: <20260714231015.3337831-4-seanjc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 15 Jul 2026 09:21:06 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyj1gZXRx9BR1wSE1C3QgdGqTUb73XnNauYFQcjjDZiMA@mail.gmail.com>
X-Gm-Features: AUfX_myXny1yGrA0sg1LY86lx6g_Vcx99eYhh4ULiKxvYShgodf2CF_xmLhZVAE
Message-ID: <CA+EHjTyj1gZXRx9BR1wSE1C3QgdGqTUb73XnNauYFQcjjDZiMA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] KVM: guest_memfd: Drop the redundant printk on
 arch gmem_prepare() failure
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Wed, 15 Jul 2026 at 00:10, Sean Christopherson <seanjc@google.com> wrote:
>
> Drop guest_memfd's ratelimited printk to log "preparation" failures, as KVM
> SNP alreads logs more precise messages in all error paths, and whether or

nit: already

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> not failure to convert the pfn to private is "unexpected", i.e. warrants
> logging, is firmly an architecture specific detail.
>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/guest_memfd.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index d5d227476cda..62c2c157f0c1 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -66,15 +66,11 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>         kvm_pfn_t pfn = folio_file_pfn(folio, index);
>         gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
> -       int rc = kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
> -       if (rc) {
> -               pr_warn_ratelimited("gmem: Failed to prepare folio for index %lx GFN %llx PFN %llx error %d.\n",
> -                                   index, gfn, pfn, rc);
> -               return rc;
> -       }
> -#endif
>
> +       return kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
> +#else
>         return 0;
> +#endif
>  }
>
>  /*
> --
> 2.55.0.141.g00534a21ce-goog
>
