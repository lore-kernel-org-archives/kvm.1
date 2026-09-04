Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC064A3F04
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536216; cv=pass; b=Ml2ycVJ/VlumUw3HcOeMzPNN/NlzX2EZxoB1lFRo3NBianEQ07KoyDynw5PPkY7s40G3zptOwYxQGIJ5xGJPl8HCa5r2+Dv5ElI5fF8vktEWpUI0yS0zwdMyD2ir817QC4YlKxs2/JRVH8WJKyajX94iPPzqTVYJvENP+sGJPLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536216; c=relaxed/simple;
	bh=o8HNsLeZzORg+lffL2AzJCaTytWq6/qRqD0NFejzqwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXXZo9mB0J8JSP5fHCcLsLq/Yh+FUX4wNRy5LCFyFv0WgmE5kV/zy3yMkCVj+uNUEBd3poGTH+7LTVSB8evI5eM5VwPygq2jQlAugJdP4nmBviAZ0WAtW5JHQHYE9b10GQJRNK0jUN1pwsityGXG0RP1RfDV7D/MZyy2Uz//S6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5zNtLFc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eO/wWNUt; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5zNtLFc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eO/wWNUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788536212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhUfCEAvWX3HQ4TKnpOsQaNeGPkBhU8moeSBLrDZbeE=;
	b=X5zNtLFcCk4S3wlw7qyn42tTGaMF6xIBwAiEng6SAoBV6pfltS7hgnb0HRSeN0xfPpGsu/
	mzQBcA4Td4IQnXzVc7T4ic3XlTOg2Yji1yiKRLvgdzgEsvsLdkviFFZlQzF350YrBl2227
	AhguLbxwLluSjnNgl6ADT4CQWIj18k8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-F_x5ZY2UPrC8WcbQNozkOw-1; Fri, 04 Sep 2026 11:36:49 -0400
X-MC-Unique: F_x5ZY2UPrC8WcbQNozkOw-1
X-Mimecast-MFC-AGG-ID: F_x5ZY2UPrC8WcbQNozkOw_1788536208
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-484362cb000so796503f8f.0
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 08:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788536208; cv=none;
        d=google.com; s=arc-20260327;
        b=ZKt6ZoM+Bo+L0eJipxnP97iXz5GIKLZcLY6v81MgBYpycCZzlzmnN09IFeL7CLUNF0
         EoZtpBN9IULN+sHXe9nZVh57Sfa+xEWiJPsrlZNr+J0ho5CUcCgY5bCfCg1dFpnyx2Z6
         ljtRVuduE/QInrhlmtR1PuNQDDvcIE+Q9idX7uhoYHGrY9ssa77S1l2FTvLGpXbdgu3O
         AWLG7KQ1ew4O/lJjv5bnd2LUFwylInNISI71NOrHqe4aWteU7FLgmlQ2/C6GHIRNPVhq
         qmaL9WPT4+MPIkYObWYKreAMdNlj8t8Gg98BsKiiXqSE1YpnAbIo1ZYVtOe6yHGLaMaD
         xsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UhUfCEAvWX3HQ4TKnpOsQaNeGPkBhU8moeSBLrDZbeE=;
        fh=5Lw/HGKJ+8zJXISiApHzH9cgJ56F3WHZbEDIJ+izNqs=;
        b=ZD+D4mLESCFUTBb7XBap8WxYFKaoIqtdyYK7ArSQlMffyF1TxcX9AnG6DXpqL1UFbN
         xSYBreScFeG3ieVfmWEpHVpeuEybtvhtg9+FiHCff8g9gpfetnB6kxvAdmEz/vtN/tbL
         8NbfrRl2iCT2S931p5TJpU1LuFFuwNs5qCVa8cSY7RMrO31pSAcKaV6kYGi6FE9NpWWk
         UlBMsc2QngRG/Q1bNs6XB3wZ9ws/oVjMIMQVCHiRlsrHyw+so7YAilIt6HBhl7xRL94/
         oSDYuX5pzIJrirpgpMOLuIEMA7hIHm1F3EguG/oYiJ1GFYaEhc+7GNd90rsUUk5Qr22e
         lNGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788536208; x=1789141008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UhUfCEAvWX3HQ4TKnpOsQaNeGPkBhU8moeSBLrDZbeE=;
        b=eO/wWNUtNTyaAQsu4ON53RQOyGfTC7N3dEhhsJmLvvUxr/nyjJtd9XcAWiFARKdKqq
         iQbcaUKGE3su/Z9vddix+Zl4kQtB8uoPlx9dLWDT5NWzj3sYuFKPYJma3C+2emX98jat
         BUiyeO+FCYGi407GzDuAwk1ZEFrMdHCfsneUDq7ViaWq9+rv8qVVTVQt00Lc1fWZ3yjf
         QEphYiKXQurHdghIPRstOzzupt1O3iiXKWfGbFUeloxCOn5/NgfkrwQcd4cD/0vpcNwP
         uhw9l/ctYEzo3dJkjzTuXPhsgJcIpc79N6lFYbwDXxz8ULs9MG6V7WltZYzshvFUfRP0
         Dh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536208; x=1789141008;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhUfCEAvWX3HQ4TKnpOsQaNeGPkBhU8moeSBLrDZbeE=;
        b=gxRjUq3FQCJrnZfUTqYV6oe1ApyxVSdwhRL9lkueoarUGCvj/M8/JSUDl8tho2QVHd
         uuX4kzh2qqxGTvPoJhOoaMbyld+a6GMNt2hTn/lww35l+as0ZFWAllQMv5RGW1s0bBg4
         qYiJEcPZ1clUWroMVaL8dY5Y6GRmOqDQGVAc+ovro/4+4QBK7DAEcAoIVTBSlBlC9RKl
         /7T7VeVeyibqcShpySK+xMzg+EBFeIVQsY5vyytis7v71tvben53Tz3x6bZyXeK6nSeo
         wrOGz/zg+pG4kR3kqujE6dtQ6jja7wJ6qjzAuUr7hfoIzeOunGaRp4mJrW728RXWTUFA
         h5nA==
X-Gm-Message-State: AFuF++kjeopkSk9d+Z7Lkt1QWm6LnXoHRZ6vPako0gCVHDMhYT74Qi2r
	1oK3XoLdWLU5j0Txdrhbd7DxNP0l9pulp/Eh4Uj7VpezUECpFWkFnf3CpK2G4USlzxFjWPRFXls
	hGbO9Y65yuvQDjgTM1tRlj+7h08VakFzMTzbSLlj7TfWtDk1iKRfGNbLgWI3rT18H0rYs9bbGHc
	K6BMu41XJeKTmGHdWMJnPkQuqxIU+f
X-Gm-Gg: AYBFou3j5k1SVr1lQZRqnwbDvoZ+jr6AajtZLG/OTdkLrPBjgS7ztjBGjIc1CC+2xSd
	jCfZUIea2UqK2/n5L5Mr6dOEaP7yO7voXYQTO6RJ65Mv4vQw2SxrrKwBi2cIXPspeeOxBgnNxVp
	8lwkQWEctlFx/s3rM+FUXDsUKrMerKUI861I5em5JgE9s59uwFotgSDYQ84E85SzWUHt32y9xWT
	mhim/ZtNpL2Q/R0+mPQVq31EGl3LBkLqqhEsYNtl0+caZmUunuhcfcap+2QIA==
X-Received: by 2002:a05:6000:4105:b0:485:8226:c694 with SMTP id ffacd0b85a97d-4858226c967mr11829098f8f.19.1788536208211;
        Fri, 04 Sep 2026 08:36:48 -0700 (PDT)
X-Received: by 2002:a05:6000:4105:b0:485:8226:c694 with SMTP id
 ffacd0b85a97d-4858226c967mr11829033f8f.19.1788536207632; Fri, 04 Sep 2026
 08:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 4 Sep 2026 17:36:28 +0200
X-Gm-Features: AcwNN1UM7o-vZcW8Wc3wn3D5DYydTSSdA81i2MBw2kUOwZogbcxlqjZ4yCZ7sPI
Message-ID: <CABgObfZ1E2+-KmM=dGm8S=jLX1vWb_qrFg00xt4u3VB94EzmRA@mail.gmail.com>
Subject: Re: [GIT PULL v1 00/11] KVM: s390: Misc fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:07=E2=80=AFAM Claudio Imbrenda <imbrenda@linux.ibm=
.com> wrote:
>
> Ciao Paolo,
>
> Here you have a bunch of fixes to bugs found in the past few weeks.

Pulled, thanks.

Paolo

>
>
> Anthony Krowiak (1):
>   s390/vfio-ap: fix KVM GISC and page leak when queue removed from host
>     config
>
> Claudio Imbrenda (8):
>   KVM: s390: Fix dirty marking in adapter_indicators_set*()
>   KVM: s390: Fix compile warning for kvm_s390_update_cmma_dirty()
>   KVM: s390: Fix _gaccess_shadow_fault()
>   KVM: s390: Refactor dat_set_slot()
>   KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()
>   KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
>   KVM: s390: Fix potential races in dat skey functions
>   KVM: s390: Fix race in _destroy_pages_crste()
>
> Steffen Eiden (2):
>   s390/uv: Fix loop condition in uv_find_secrets
>   s390/uv: Prevent potential out-of-bounds read
>
>  arch/s390/kernel/uv.c             |  8 ++-
>  arch/s390/kvm/gmap/dat.c          | 65 ++++++++++++----------
>  arch/s390/kvm/gmap/dat.h          | 10 ++--
>  arch/s390/kvm/gmap/gmap.c         |  6 +-
>  arch/s390/kvm/gmap/kvm_mmu.c      | 91 +++++++++++++------------------
>  arch/s390/kvm/gmap/kvm_mmu.h      |  4 --
>  arch/s390/kvm/s390/gaccess.c      | 13 +++++
>  arch/s390/kvm/s390/interrupt.c    | 79 ++++++++++++++-------------
>  arch/s390/kvm/s390/s390.c         |  3 +-
>  arch/s390/kvm/s390/s390.h         |  2 +-
>  drivers/s390/crypto/vfio_ap_ops.c | 18 ++++--
>  11 files changed, 156 insertions(+), 143 deletions(-)
>
> --
> 2.55.0
>
> The following changes since commit 786262be6048deab760f68c8acc2c856071658=
94:
>
>   Merge tag 'edac_updates_for_v7.3_rc2' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/ras/ras (2026-08-31 20:10:39 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-7.3-1
>
> for you to fetch changes up to f47190b08b71e8482072978373ee88cb2dfbdaf4:
>
>   s390/uv: Prevent potential out-of-bounds read (2026-09-02 18:50:42 +020=
0)
>
> ----------------------------------------------------------------
> KVM: s390: Misc fixes
>
> A bunch of fixes to bugs found in the past weeks.
>
> ----------------------------------------------------------------
> Anthony Krowiak (1):
>       s390/vfio-ap: fix KVM GISC and page leak when queue removed from ho=
st config
>
> Claudio Imbrenda (8):
>       KVM: s390: Fix dirty marking in adapter_indicators_set*()
>       KVM: s390: Fix compile warning for kvm_s390_update_cmma_dirty()
>       KVM: s390: Fix _gaccess_shadow_fault()
>       KVM: s390: Refactor dat_set_slot()
>       KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()
>       KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
>       KVM: s390: Fix potential races in dat skey functions
>       KVM: s390: Fix race in _destroy_pages_crste()
>
> Steffen Eiden (2):
>       s390/uv: Fix loop condition in uv_find_secrets
>       s390/uv: Prevent potential out-of-bounds read
>
>  arch/s390/kernel/uv.c             |  8 ++--
>  arch/s390/kvm/gmap/dat.c          | 65 ++++++++++++++++------------
>  arch/s390/kvm/gmap/dat.h          | 10 ++---
>  arch/s390/kvm/gmap/gmap.c         |  6 ++-
>  arch/s390/kvm/gmap/kvm_mmu.c      | 91 ++++++++++++++++-----------------=
------
>  arch/s390/kvm/gmap/kvm_mmu.h      |  4 --
>  arch/s390/kvm/s390/gaccess.c      | 13 ++++++
>  arch/s390/kvm/s390/interrupt.c    | 79 ++++++++++++++++-----------------
>  arch/s390/kvm/s390/s390.c         |  3 +-
>  arch/s390/kvm/s390/s390.h         |  2 +-
>  drivers/s390/crypto/vfio_ap_ops.c | 18 ++++++--
>  11 files changed, 156 insertions(+), 143 deletions(-)
>

