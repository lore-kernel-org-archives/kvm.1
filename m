Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BB3DDAEE
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589310; cv=none; b=gj5QbwMZ0+8RzxeilHsPpTVRDxxndo+r/nn8QcydY9bf1f38EGT9F30JLnJ8SKylhtZsqOgaAVILRZwCwdb3EzlXztjeiaZIGm+V5J5pFakyn2URsTgObyaLvPCDUCJ3UvXifz81j5DtJ2l9SeKXFW+P6YaKfKvNQ1G/pCRlmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589310; c=relaxed/simple;
	bh=gefUwafK2JtQlDyL1IIPxdZVmH8sjXIKk8BRTGYCg4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kJEHKH7xtlO/aZZvfWDlMxBDdtGfjH/myM1GSVZbK4nTv8pzNSrChp5HfZ/ldQqtW/Igrnsuk5NUGtSNUhAwuLg72UYKE5aNZZlYXBkSTstW9oA8SVIOcC0+NBiuQi8aZwec9Dcw3tCdyhnUkcX4WqCXeD+T77EGXkGaj3B+oYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8nIkMTs; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8nIkMTs"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8487eb67173so16684108b3a.2
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 16:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784589308; x=1785194108; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8FFT9Ej5mRVQAJ4VSOKR8iYUmF6Z8RdPi6xtLVTt8mQ=;
        b=i8nIkMTsMhGLtQ9vfGGsxuHZhkAMDaQ7qugnQv8M9p0oBOtnvKiMxsAz+WK39CQBAi
         OEHVBP364n3KHrX9J6iMshfwU6H8xzBDL3n96aIkWO+86imcT36pr03tduCYFq67WJie
         9z6vFZJpbkywlDXCeDpPqQ9qbSCbBWNH7o4/Ofe54eY4iIOitJGKUlN5O28u0HyzVv91
         nJJ8tgBAq8FBkHFNlJ9DNxO/bWoYb1TybRbzJVqBT6/ymbDIOI0uRPrWicMKvF5bvwBq
         HCazyqaa1cv7szsBtFB33bfg0rkZNvMBmtIfEzOzMh3iu14XXtc473uOgDbB07BWMIni
         81zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784589308; x=1785194108;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8FFT9Ej5mRVQAJ4VSOKR8iYUmF6Z8RdPi6xtLVTt8mQ=;
        b=nYZfkqPK+U4QkBU0A82eVMdqPeZT/nkBFoM1fY3W4G09CMEDgF++MSnBwY6jGPVvrT
         TmFpPAOkXclNwJBInfjNS27RUkDaeJFVsFfNQWK1KnzO0eaA3XtwUdhfK4JSHNiKA5Jt
         Uvf0EVtwsWgUtV3kDay22+79+7tjdzF83nyyBe6Zl43JujByLbX9gwvBF8bVvKMUpIkE
         qzoaHkC1c35URD4vnBQjPEmFepw9Fyevhk9LC4PzhBnQF7JnMUjsmqRvK7zuq6RquSWp
         0fM7QYdavfH3bcJT2VfMqP0mJzGsR1VTDRD7l0WEi1Rfdfr8b3yEktTeqo5uybVWzkHd
         X37w==
X-Forwarded-Encrypted: i=1; AHgh+RpeZQw9rTapS184NqnpJd9eKyil7IaDrdBdDqVzlnPvh4oJzTPp8tiBqDMsuKbEzMQo1cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWzjK6BcI2vHn/YSuqft9Unb0+LouuPAf/+askS8x2/bEd1dK
	e/SZenHlF83LWAeqr1yUNhfw98sUSEvYfBm77bkxmXvet8jGBPg6o2yPksve23WxrpiBs2hjWMB
	rPlWFZQ==
X-Received: from pgmc6.prod.google.com ([2002:a63:1c46:0:b0:c9b:5bf6:f971])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:408a:b0:84a:2dcb:5aca
 with SMTP id d2e1a72fcca58-84c2954df26mr16284618b3a.77.1784589307791; Mon, 20
 Jul 2026 16:15:07 -0700 (PDT)
Date: Mon, 20 Jul 2026 16:15:07 -0700
In-Reply-To: <a4f683a52c096d8a7cd7d6c4ab895fd41f197eda.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716160801.3155582-1-dmaluka@chromium.org>
 <792366b7d918faca3f40bccab56bab965e7e34f5.camel@intel.com>
 <alpWONLi8h2T5WhZ@google.com> <af8fc5537970157b693a9bcdf134e14b29b1f1ff.camel@intel.com>
 <al6eg7C-2sDBEAFD@google.com> <a4f683a52c096d8a7cd7d6c4ab895fd41f197eda.camel@intel.com>
Message-ID: <al6r-2sAm2tVh1Wn@google.com>
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, 
	"aashish@aashishsharma.net" <aashish@aashishsharma.net>, "guang.zeng@intel.com" <guang.zeng@intel.com>, 
	"dmaluka@chromium.org" <dmaluka@chromium.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"vineeth@bitbyteword.org" <vineeth@bitbyteword.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jaszczyk@chromium.org" <jaszczyk@chromium.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 20, 2026, Kai Huang wrote:
> > E.g. for the xarray approacy (sketch only, completely untested):
> > 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index fdbd697d0337..e34ca5920393 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -791,6 +791,7 @@ struct kvm {
> >         /* The current active memslot set for each address space */
> >         struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
> >         struct xarray vcpu_array;
> > +       struct xarray pending_vcpu_ids;
> >         /*
> >          * Protected by slots_lock, but can be read outside if an
> >          * incorrect answer is acceptable.
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 2df8ee9ecf6c..8bc4f7ffd76d 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -4179,6 +4179,12 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
> >                 return r;
> >         }
> >  
> > +       r = xa_insert(&kvm->pending_vcpu_ids, id, xa_mk_value(id), GFP_KERNEL);
> > +       if (r) {
> > +               mutex_unlock(&kvm->lock);
> > +               return r;
> > +       }
> > +
> 
> (No preference between xarray vs bitmap)
> 
> Should we move this before kvm_arch_vcpu_precreate() to avoid any "precreate"
> for duplicated vcpu_id?

Hmm, I'm not sure.  I'm leaning "yes".  At a glance, I like the idea.  My only
concern is that we could consume a garbage @id if kvm_arch_vcpu_precreate()
performs additional checks on @id, as x86's implementation does.  However, I
don't think that's a meaningful concern since kvm_vm_ioctl_create_vcpu() *must*
perform at least basic sanity checks.

So yeah, I think moving the check before precreate() makes sense.
