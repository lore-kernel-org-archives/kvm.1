Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1E358375
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115297; cv=none; b=tVwZVxK/Nd4Bf0XSi+3aM9FDrQWrlmFtfJaGKesOJKbsL0Awm+lyLr+aCpCRqHon3snUDVTI5GXVmTrT7cbBhFYjpiaZkCdaFYQKO1rZHgDAMbbpad3u9OaTppy/8hd4GfaVqSmVBZGYqpOD4IRae/FnVNpWYT6Yjc6QtMlyX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115297; c=relaxed/simple;
	bh=7h23eZ03Vu8PJppPJ5U5tfWpMyfaA8Dr8G791fN+wKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NfgY5qiomGuKnMB//SBFaCCWdD3lQrB3aoa6Pskso9MgrpNZzUiBOxzg1ke8s5e/LrobL6GWZdDFdjt6nKUwzI4zxc6Kseu3L7DRFVWY7h6QCQnoi5Sx+FWueyjwRORMZe0F7uKPJgrEFMdnOPKm3u2yzddd6+HrxIJBU9OMlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bb5u3fPW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb5u3fPW"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f0f2b2641so2323435b3a.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776115296; x=1776720096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuf1A/mXvaOqnPgxRlEVC9WGHbewdpxj9Ox8YIGhSmw=;
        b=Bb5u3fPWUKZ4RfuOeqMptg72V+eO+shEL6erAnhb4VKWMKS8gBG8VH8rpkTijXdr+H
         eAYXxZVUmQ2QOink2ftC1BUbS1Bavu+lvm9kKGZgQRxiMWeZ6weVIhq77E3zAgbFyQDS
         pjT+XaHP3jGXFBRkpEN2c+bdt61VnywMsUWMiNsvnMbq3+ZTQuxS5Zh72YumRFyD+2G+
         L3m1ibGPCRKbycdf5vobAwtsdbimJt5vJjBfexGwrR9mKGFCEFxxyN0o/QyROYrQGgi8
         UbOOjoY+gAHNS/7zNUCees2Mu6550BN1aXsSfT1uBRXxr10kwadCC1C6P04DgLcyhac/
         +tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776115296; x=1776720096;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iuf1A/mXvaOqnPgxRlEVC9WGHbewdpxj9Ox8YIGhSmw=;
        b=fpzoUDGgOx7C6mfTvQjJHMcfPu7ebg9NtKPAXqG4uxhMEOYN+85JhB7tsuE91ubNn/
         yXy/aIhqhfwsONHo7Tm5zD7/qEro3dJwlyR21ogcOUEk7NpQLm3iASuESF8KhSETsLJG
         dOFg5l1A+xRnNbMdcHlpGMPxo29DxON4SOLc52m7BxeYzLOIX8CDW8CB6igrf2yzfcn3
         3pOrdP8qxGmVk4ryWZN/masVby81DZ8WCf6fb0HF30c3IGJgUx3Wj4eBfh9dO3J1uzfp
         0qBE+5YETvSi54/uwpipc0ZUE50wUaFsYLbW8UU8PACc2oc8TLFgrJgiYJtDyW55DJnh
         QP4w==
X-Forwarded-Encrypted: i=1; AFNElJ/PYW/10zM1DFq9N2q3BXQ56mNFhUVw6kit7fvCywuFfcO8cbyulqL24itAB85iWqZjfCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTeO3KEBPR/alJEx8Y6qPTXCdxk9RtiEWtmWDAP/MiP9ocuTE
	xdOgn9hEIEDW1aLawQJbTVs6NGlQ9raHjuPCyI7dGQFzHxZ1CcKq5vPvwBOHkNjLJxd/OvsmVmE
	/FJSMgQ==
X-Received: from pfuv22.prod.google.com ([2002:a05:6a00:1496:b0:829:8405:f4a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f5:b0:82f:44dc:f85c
 with SMTP id d2e1a72fcca58-82f44dcfb5dmr4246597b3a.34.1776115295604; Mon, 13
 Apr 2026 14:21:35 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:21:33 -0700
In-Reply-To: <279763ec-438a-46a2-b2fd-e5b445ab0160@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407180107.1603697-1-pbonzini@redhat.com> <20260407180107.1603697-2-pbonzini@redhat.com>
 <adf29Rn7q9Db0hxc@google.com> <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
 <adkFk3ZN4HJtpLA3@google.com> <CABgObfaE2g30D789zK1N8xMfcAzPG8gz8MPERQ+DYxd7Soi-Gw@mail.gmail.com>
 <adka_L18z24zsQpc@google.com> <279763ec-438a-46a2-b2fd-e5b445ab0160@redhat.com>
Message-ID: <ad1eXa_PirbQKqYJ@google.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Alex Williamson <alex.williamson@nvidia.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026, Paolo Bonzini wrote:
> On 4/10/26 17:45, Sean Christopherson wrote:
> > On Fri, Apr 10, 2026, Paolo Bonzini wrote:
> > > On Fri, Apr 10, 2026 at 4:13=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >=20
> > > > +Dan
> > > > > We could get rid of the reference count completely (get_file() as=
 a
> > > > > replacement for kvm_get_kvm(), get_file_active() as a replacement=
 for
> > > > > kvm_get_kvm_safe()). struct kvm would need to add a back pointer =
from
> > > > > struct kvm to struct file,
> > > >=20
> > > > I wasn't thinking of dropping kvm_get_kvm() entirely, rather just n=
ot exporting
> > > > it.  Forcing internal KVM usage to grab a reference to the file doe=
sn't add a
> > > > whole lot value.
> > >=20
> > > It adds not doing things in two different ways. The kvm_file is not
> > > always available (and if we need to add it, it should be added in
> > > struct kvm not struct kvm_device).
> >=20
> > My thought was to deliberately avoid putting it in "kvm", because as yo=
u're
> > effectively pointing out, the file really shouldn't be passed around wi=
thin KVM.
> >=20
> > Aha!  What if we bury it in kvm_vfio?  As an acknowledgement that passi=
ng around
> > a kvm_file is only intended for cases where an external, non-KVM entity=
 needs to
> > to propagate the VM reference.
>=20
> That would indeed be best but it doesn't compile as there's no file argum=
ent
> to device_ops.create.  And adding it to device_ops is ugly as well.

FWIW, extending device_ops.create() doesn't seem all that ugly to me.  It's=
 not
beautiful, but I think I'd vote for that over a kvm->file backpointer.  I'm=
 a-ok
with either though.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9faf70ccae7a..4e4e6b5c3b9c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4811,7 +4811,7 @@ void kvm_unregister_device_ops(u32 type)
                kvm_device_ops_table[type] =3D NULL;
 }
=20
-static int kvm_ioctl_create_device(struct kvm *kvm,
+static int kvm_ioctl_create_device(struct kvm *kvm, struct file *kvm_file,
                                   struct kvm_create_device *cd)
 {
        const struct kvm_device_ops *ops;
@@ -4839,7 +4839,7 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
        dev->kvm =3D kvm;
=20
        mutex_lock(&kvm->lock);
-       ret =3D ops->create(dev, type);
+       ret =3D ops->create(dev, kvm_file, type);
        if (ret < 0) {
                mutex_unlock(&kvm->lock);
                kfree(dev);
@@ -5354,7 +5354,7 @@ static long kvm_vm_ioctl(struct file *filp,
                if (copy_from_user(&cd, argp, sizeof(cd)))
                        goto out;
=20
-               r =3D kvm_ioctl_create_device(kvm, &cd);
+               r =3D kvm_ioctl_create_device(kvm, filp, &cd);
                if (r)
                        goto out;
=20
