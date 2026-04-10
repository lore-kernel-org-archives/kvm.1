Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB33D8903
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835906; cv=none; b=syphviSmZEvfdvnWx8c/nhJVZRODtpVipirapxKn+FiMG1JkK3b0VrwQ7iioqkFYVZ6KmTllcMdBjgYSdya63Lqp3ZXcyc73XnSSV06BJY2bHXwwax5vbvUaLfap5fKJqdOs6ksCsevGTd3MD/dLo2vRovn1mmOm1vm2ECttn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835906; c=relaxed/simple;
	bh=Ra4A1uA4orckwYMKGyuuBdPCAu/OQSIbSy8OXzWm2u8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kq1ROVa4T7b3iWkISQZz93POs3ej287hLyHlfryyRp1hJkw9IQ2M4217OC+XUCgBuWe+sxrvNAfnBIbpyfquWXp2GluBdVjTZhvlnA8NaLwrFAJQMVU4P8sru0Fg4Kj/LL1bphJqFEMNBUMc1oVUuq1V9xvMIAmrROydUkHLC7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sblZZ9da; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sblZZ9da"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2471321dcso53240205ad.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775835903; x=1776440703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TswAppJsEI2l6fMCBwuMFg1b8zYj2e7a0LADz2whr0=;
        b=sblZZ9daYQrCgj56mnDH4wZMf7lwSDgDP15HYBYAJwca/YWMCFOiWFPh+kXSjpM767
         E/byqM+8EzGbGXIMo41cDV5r8RBEBwFhsmwAltuAkY9prkpvYUegL67ZqMssL5GJondB
         uizg4UksrjZG8wFcbCHHGp2V9XKVYboZe2RdKgsuBRXD8OVnSNzRRKjbHBgxIPmh8fu2
         sBUOiPfwsAJ7A74kAjDL6tsKEjl0abnv1Gqzkj2Iz5IXec3tPwFJxHgLMbmHcuiebLqU
         MvCetdP0exXhGsObm2N+pTxW31CcVz4uj6Yuh01DdIhanx/7dFW6DNDStOHCGpEv3NOO
         0Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835903; x=1776440703;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5TswAppJsEI2l6fMCBwuMFg1b8zYj2e7a0LADz2whr0=;
        b=FVlcFCHFXNiFjGKCNSdiACDrGg+yKm4ZrS1cndQ/yY25PZS+2ZZvbCzKJS8mQmiosw
         qlb3tIuzhQ806o+6pGTw2gAHXzTYqfkx6zpiG7ZGbxsbxd4z0lYkfHVZ4n+se/ttbGrM
         VtXcX5e8HVIu+SGQ1mJ9Z1xpEKDhMJAN/gqvULcB0O24lrF/HerjO1WqFQMmX0/HjVym
         UoCZIohuECzS0LvBHCEPIBGdhDAqf8hlCDlj9qiaHVlKIyxoHhlGRZCo9ZUbqzRl8RgU
         mi+9AKCzdOB3m/EuRtpE32UYhZ9DXLZ3TaAkKZNQGzMk/osDYjpE7xNpVMqp9nsAuIjs
         yXSw==
X-Forwarded-Encrypted: i=1; AJvYcCWO3F6DiK3OTVfKX3VRkvCNjcZMKpPnbwy53/mGrxTQZ+wlctcWkfwfESnqJETLfDSEvTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa0KaOCH18TO+5YtFXY8f5mntwWIESIu4XgJWPiDhlj+UbMO8S
	iPn0554uXdKaOlpqpgjc7QgARlEVXynHX9Hcd8UdSSSvS37KhaD6ZvltvSQmOM3kAoGUQ3NR4MZ
	uIccobA==
X-Received: from plox8.prod.google.com ([2002:a17:902:8ec8:b0:2b0:4f4f:fe19])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38cc:b0:2b0:60f1:de58
 with SMTP id d9443c01a7336-2b2d5a95893mr41105345ad.45.1775835902936; Fri, 10
 Apr 2026 08:45:02 -0700 (PDT)
Date: Fri, 10 Apr 2026 08:45:00 -0700
In-Reply-To: <CABgObfaE2g30D789zK1N8xMfcAzPG8gz8MPERQ+DYxd7Soi-Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407180107.1603697-1-pbonzini@redhat.com> <20260407180107.1603697-2-pbonzini@redhat.com>
 <adf29Rn7q9Db0hxc@google.com> <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
 <adkFk3ZN4HJtpLA3@google.com> <CABgObfaE2g30D789zK1N8xMfcAzPG8gz8MPERQ+DYxd7Soi-Gw@mail.gmail.com>
Message-ID: <adka_L18z24zsQpc@google.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Alex Williamson <alex.williamson@nvidia.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026, Paolo Bonzini wrote:
> On Fri, Apr 10, 2026 at 4:13=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > +Dan
> > > We could get rid of the reference count completely (get_file() as a
> > > replacement for kvm_get_kvm(), get_file_active() as a replacement for
> > > kvm_get_kvm_safe()). struct kvm would need to add a back pointer from
> > > struct kvm to struct file,
> >
> > I wasn't thinking of dropping kvm_get_kvm() entirely, rather just not e=
xporting
> > it.  Forcing internal KVM usage to grab a reference to the file doesn't=
 add a
> > whole lot value.
>=20
> It adds not doing things in two different ways. The kvm_file is not
> always available (and if we need to add it, it should be added in
> struct kvm not struct kvm_device).

My thought was to deliberately avoid putting it in "kvm", because as you're
effectively pointing out, the file really shouldn't be passed around within=
 KVM.

Aha!  What if we bury it in kvm_vfio?  As an acknowledgement that passing a=
round
a kvm_file is only intended for cases where an external, non-KVM entity nee=
ds to
to propagate the VM reference.

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 9f9acb66cc1e..2d9bce646136 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -30,14 +30,15 @@ struct kvm_vfio_file {
 };
=20
 struct kvm_vfio {
+       struct file *kvm_file;
        struct list_head file_list;
        struct mutex lock;
        bool noncoherent;
 };
=20
-static void kvm_vfio_file_set_kvm(struct file *file, struct kvm *kvm)
+static void kvm_vfio_file_set_kvm(struct file *file, struct file *kvm)
 {
-       void (*fn)(struct file *file, struct kvm *kvm);
+       void (*fn)(struct file *file, struct file *kvm);
=20
        fn =3D symbol_get(vfio_file_set_kvm);
        if (!fn)
@@ -175,7 +176,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, un=
signed int fd)
        kvf->file =3D get_file(filp);
        list_add_tail(&kvf->node, &kv->file_list);
=20
-       kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
+       kvm_vfio_file_set_kvm(kvf->file, kv->kvm_file);
        kvm_vfio_update_coherency(dev);
=20
 out_unlock:
@@ -372,6 +373,7 @@ static int kvm_vfio_create(struct kvm_device *dev, u32 =
type)
        mutex_init(&kv->lock);
=20
        dev->private =3D kv;
+       kv->kvm_file =3D file;
=20
        return 0;
 }
