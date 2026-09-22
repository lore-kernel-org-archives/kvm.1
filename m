Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5433A700
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096615; cv=none; b=Tz83xXMRas9dIDkgCrXeXO2HCHYLe8JOo89hIwGgp5y8uYzDXAwxwZJ3IBq98xSzlpf0iabemjC2ZGfQh96y6iV7ODipn9I6IBaFNu153vocPoSku/AOJFge7p3jHfRZSWkxPMDR7nya2fiRZ5V34S45aacPGfaRxIrNVcSpZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096615; c=relaxed/simple;
	bh=5zhFwtdbH8A1nvjTaU97xvvi4MRuVSW3RFASvYBSPZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dw0e8/dVOemCmJvtBKj83dMCdxCy04rw+SlN02KoLR10AevQPmeBBXPAhEn3flKUjspSp+I+Aem5LwkrJicHRY2a8DRb9T8o03SgmvJ8mDeBbxpt97AWBdL9elqB0+68T7Mv8Tf7lAwq7PgmAGpBxrERpoDIv+UoEzCick3QR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKmnHUub; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKmnHUub"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1a439db36so112587a12.2
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790096613; x=1790701413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bQE0UUvSwKEzQaYQqhDMRss/riPZ+xnoXle1sabNegQ=;
        b=LKmnHUub5XAEnoG8HGR+8/fO4a8m4XmImuEmsGLxS+tbbZyR+76bTKmovF5XJsYlxV
         0xQnFsDBdBwzvMCyDlQ3qtwWRYrbWSob6GXnFom891nEMoM2E86SEsEkrUz0kulrAxLe
         qjXaipeJ5ZHf4YOvgYvdlqcg2qE/ahXdGXFMUO9vZX3yfKrGBn9XOP2K/rPOCeZt7jzj
         JvsUJx2JMU28noVgKRjsWYGCN2xRacuMeyG2jTS8HIvvjq04YtHEfuT5rjApRdBGyOCm
         2kjJjE/oMr2/EaMWCpVzKbUp8M6XLrTjK/rVML9TgKneSW/X/xslRANOK48vBas1Lyx5
         sHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096613; x=1790701413;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bQE0UUvSwKEzQaYQqhDMRss/riPZ+xnoXle1sabNegQ=;
        b=nHaU87RdXLXUvBJuukbps7BjfnHk2g4qp3c/mA/eqM2HzQ4dMbPk1URtnqKSJ1J73n
         ja9bWPWOpyvtxhMs7r5fMio3C9hgtUyznXqU8q/ioE3fXIpNgf6zPZvVQKb5f/L1Ytqo
         v9YyxhYkilw8mLX/t0/N6KaYRyHhCumkHYf2KgnAkw3wrhx86n2Q47/lWNavcIZnBdq7
         ++PMEPyO6sylS3KClNeURomEVRUT0jwlz6KLM8AE8wV8HMnYfa1RXZBhH7JQjHAeEanP
         krRm9Hrj0ZMPUaMDlU0RBunbA6fzLbt0fbRgP7+0Epc/m99FpGcX4gMpwyHIZUw1xMwB
         NuQA==
X-Forwarded-Encrypted: i=1; AKwUvBx+oOQGhH/gli4UW9XVW3Zq41qQnUz1H6v9bd1kIwia5HV5CyjOh4wNKMcvQawwjWeN8ks=@vger.kernel.org
X-Gm-Message-State: AFuF++n8C07KDfzUsiC/y46fjDfBT9TK503Sad7WPuRw2PWDHP8fnXH9
	F/XU6TMWexV95JUOtuwRimVaG8CjJl9MXENOAJHSDdPn05EDH/whhj+Fl4p4RN2ie6frVWGfZgu
	pOYCMHA==
X-Received: from pgbgf16.prod.google.com ([2002:a05:6a02:2cd0:b0:cc5:1124:470d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c90a:b0:3dd:a197:735f
 with SMTP id adf61e73a8af0-3ddf8296566mr95261637.56.1790096612810; Tue, 22
 Sep 2026 10:03:32 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:03:32 -0700
In-Reply-To: <20260306125651.2485-1-thanos.makatos@nutanix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
Message-ID: <arK05GrLtiBvbfmm@google.com>
Subject: Re: [PATCH] KVM: optionally post write on ioeventfd write
From: Sean Christopherson <seanjc@google.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, John Levon <john.levon@nutanix.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026, Thanos Makatos wrote:
> @@ -656,7 +658,8 @@ struct kvm_ioeventfd {
>  	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
>  	__s32 fd;
>  	__u32 flags;
> -	__u8  pad[36];
> +	__aligned_u64 post_addr; /* address to write to if POST_WRITE is set */
> +	__u8  pad[24];
>  };

I would prefer to have explicit padding:

  struct kvm_ioeventfd {
	__u64 datamatch;
	__u64 addr;        /* legal pio/mmio address */
	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
	__s32 fd;
	__u32 flags;
	__u32 pad0;
	__u64 post_addr;   /* address to write to if POST_WRITE is set */
	__u8  pad[24];
  };

that way it's more obvious there's a hole we can use in the future.


> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index fdec90e85467..7ab470981c31 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -64,6 +64,7 @@ TEST_GEN_PROGS_COMMON +=3D kvm_binary_stats_test
>  TEST_GEN_PROGS_COMMON +=3D kvm_create_max_vcpus
>  TEST_GEN_PROGS_COMMON +=3D kvm_page_table_test
>  TEST_GEN_PROGS_COMMON +=3D set_memory_region_test
> +TEST_GEN_PROGS_COMMON +=3D ioeventfd_test

Please name this ioeventfd_posted_write_test, as it isn't a generic ioevent=
fd
test.  And maintain the alphabetical sort.

Does this actually work on s390?  Which doesn't have MMIO...

> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index 0e8b8a2c5b79..22bc49a41503 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -741,6 +741,7 @@ struct _ioeventfd {
>  	struct kvm_io_device dev;
>  	u8                   bus_idx;
>  	bool                 wildcard;
> +	void         __user *post_addr;
>  };
> =20
>  static inline struct _ioeventfd *
> @@ -812,6 +813,9 @@ ioeventfd_write(struct kvm_vcpu *vcpu, struct kvm_io_=
device *this, gpa_t addr,
>  	if (!ioeventfd_in_range(p, addr, len, val))
>  		return -EOPNOTSUPP;
> =20
> +	if (p->post_addr && len > 0 && __copy_to_user(p->post_addr, val, len))
> +		return -EFAULT;
> +
>  	eventfd_signal(p->eventfd);
>  	return 0;
>  }
> @@ -866,6 +870,7 @@ static int kvm_assign_ioeventfd_idx(struct kvm *kvm,
>  {
> =20
>  	struct eventfd_ctx *eventfd;
> +	void __user *post_addr;
>  	struct _ioeventfd *p;
>  	int ret;
> =20
> @@ -873,6 +878,16 @@ static int kvm_assign_ioeventfd_idx(struct kvm *kvm,
>  	if (IS_ERR(eventfd))
>  		return PTR_ERR(eventfd);
> =20
> +	post_addr =3D u64_to_user_ptr(args->post_addr);
> +	if ((args->flags & KVM_IOEVENTFD_FLAG_POST_WRITE) &&
> +	    (!args->len || !post_addr ||
> +	     args->post_addr !=3D untagged_addr(args->post_addr) ||
> +	     !access_ok(post_addr, args->len))) {
> +		/* In KVM=E2=80=99s ABI, post_addr must be non=E2=80=91NULL. */

Maybe elaborate just a bit?  And I vote to drop the local "post_addr", even=
 though
it's more "work", because it's super easy to overlook that KVM *must* do th=
e cast
before checking for a NULL pointer.

E.g.

	/*
	 * Disallow posting to virtual address 0 so that KVM can treat
	 * a NULL user pointer as "no posted write".
	 */
	if ((args->flags & KVM_IOEVENTFD_FLAG_POST_WRITE) &&
	    (!args->len || !u64_to_user_ptr(args->post_addr) ||
	     args->post_addr !=3D untagged_addr(args->post_addr) ||
	     !access_ok(u64_to_user_ptr(args->post_addr), args->len))) {
		ret =3D -EINVAL;
		goto fail;
	}

