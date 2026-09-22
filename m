Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9F49F129
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095671; cv=none; b=QUpYzMdwLv7pn6fpBJ/bnrEKJ/RgSndl9oTdPMUuQGr/rW4Ntoj8+Fr/VwFO9eCeP4hZdZEcmy/ieTeDlpiEcM+1ND+fa5By6a6a37y8QFShxknFryXxAXsfFcT4uiI8xnD5/7SDjhjQCVtR2YQkUH+hiTUUmI5woqw1gSqo4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095671; c=relaxed/simple;
	bh=zsAYTkcc1X1tSVnI3BsdeV5QB/ck5n7c8wgb2S7PD/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qnjml1LHiWvgVXavhCPYYwmN3oRFzFTgHPYBMds9LUNq5fOvs6hs+TW9rudVplK/L1ioO4kh5EBuBchwJxys0y4tehuUvfoUTj+6hUiQ57uknZ/ENjdQ12VvdKu7KAiI/6GYZVdh2luzz2JxdBRTPlxd/auzKe8/z5AFUd1zDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpHi9SxM; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpHi9SxM"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39533bb224cso100996a91.3
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790095660; x=1790700460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=99MQ3qn5/we1iUZgu+PURjx9tpeSIpc3JRrMLkw7zUM=;
        b=fpHi9SxMt81Gp1LHBlEdyhfA3X5kSIMYh8BerFEDf8geV/7i70UAg0oFQKHuFz0ygy
         Yg3/qniAGBOXOOMa1g5BhcqzEzwA/T6rI/3Cs8doCYnN3rIiY6nw4lfjg/H9iehAAtVX
         fxqmEn3JoxpuCl/ZCfsDeLpWcjdtzlmdfeY4UvLxvus9qITaNK+lTUoXm2WPyW87Z2uJ
         aZ4ogkv5h0hs3VBv43FkMsOZxXpmHm+TyiLkl4fiZnjViScXMcL9NkmEaBWqj4LXvf8s
         fLjx39ttWC6WODiCqUCvdnUkktFskzcNYxbZ+0yOXJTXRy/eSUdMQv60SvnPd5nuO+lO
         5M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790095660; x=1790700460;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=99MQ3qn5/we1iUZgu+PURjx9tpeSIpc3JRrMLkw7zUM=;
        b=PvbuTOQJ8vuNv9VxYNZUrk6ee9CtDWkjvCqncwJzrBkJgS4mKUJGOAG+/3DVZjiTOF
         cR+Vd+LEtoophizO06bltFBAkOAJIxBbfhVjhqXlxv1e50sPY+XHQn7QCECB36buRZau
         nhdv1DZ6Uprf9rdAB6SHxFLq+5442WiXuo8btLUGvf7XcW7eOA+7TYdWz9w9yzSrLPHS
         0v34fZD4hknYY4s1Yj4SMiSYGuoGOpZbazRYK0SbjGs+2Ki+1iqlp0U0BAqnUyz6ORH9
         zSydneZTtTQ14yoK9zZ70d/UfL7NdJ1hJZajuWUh3UqqkCKGOO23K9E0ypI6ZObgVnUp
         vsOw==
X-Forwarded-Encrypted: i=1; AKwUvBz6aAQKYtxjUUU6op/ZM/MKfheJNAAkxTq7e2R5ukB7kKh/SmIadn9tHyevXprde+/iUqU=@vger.kernel.org
X-Gm-Message-State: AFuF++l6VYPf3Ru+TJ8ZFEv/BPBgcNs3i9BFn/0LKBAEJg1Y8XZaZlgU
	kh/9DoaANhaRirpaskjIy++TyCWKJgYJkOi7zrS9ZFJ4biIcPNYkpRcOAXhmfb0NTy+9gpxg/TW
	YgQ9xOg==
X-Received: from pgbgj9.prod.google.com ([2002:a05:6a02:4949:b0:cc7:532f:3df8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da8d:b0:3a0:5413:49b7
 with SMTP id 98e67ed59e1d1-3a07e6540d7mr36350a91.42.1790095660176; Tue, 22
 Sep 2026 09:47:40 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:47:39 -0700
In-Reply-To: <a3b8006c2953e6bda2e83d902fbbab1700fadd08.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
 <20260922135102.GA24134@fedora> <a3b8006c2953e6bda2e83d902fbbab1700fadd08.camel@infradead.org>
Message-ID: <arKxK-L85xIKIvdU@google.com>
Subject: Re: [PATCH] KVM: optionally post write on ioeventfd write
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, 
	John Levon <john.levon@nutanix.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Thanos Makatos <thanos.makatos@nutanix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026, David Woodhouse wrote:
> On Tue, 2026-09-22 at 09:51 -0400, Stefan Hajnoczi wrote:
> > On Fri, Mar 06, 2026 at 12:56:54PM +0000, Thanos Makatos wrote:
> > > Add a new flag, KVM_IOEVENTFD_FLAG_POST_WRITE, when assigning an
> > > ioeventfd that results in the value written by the guest to be copied
> > > to user-supplied memory instead of being discarded.
> > >=20
> > > The goal of this new mechanism is to speed up doorbell writes on NVMe
> > > controllers emulated outside of the VMM. Currently, a doorbell write =
to
> > > an NVMe SQ tail doorbell requires returning from ioctl(KVM_RUN) and t=
he
> > > VMM communicating the event, along with the doorbell value, to the NV=
Me
> > > controller emulation task.=C2=A0 With POST_WRITE, the NVMe emulation =
task is
> > > directly notified of the doorbell write and can find the doorbell val=
ue
> > > in a known location, without involving VMM.
> > >=20
> > > Add tests for this new functionality.
> > >=20
> > > LLM (claude-4.6-opus-high) was used mainly for the tests and to a
> > > lesser extent for pre-reviewing this patch.
> > >=20
> > > Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> > > ---
> > > =C2=A0Documentation/virt/kvm/api.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
> > > =C2=A0include/uapi/linux/kvm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 6 +-
> > > =C2=A0tools/testing/selftests/kvm/Makefile.kvm=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0tools/testing/selftests/kvm/ioeventfd_test.c | 624 ++++++++++++=
+++++++
> > > =C2=A0virt/kvm/eventfd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 +
> > > =C2=A0virt/kvm/kvm_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A06 files changed, 666 insertions(+), 2 deletions(-)
> > > =C2=A0create mode 100644 tools/testing/selftests/kvm/ioeventfd_test.c
> >=20
> > Sean, Paolo: Ping
> >=20
> > I would like to enable ioeventfd support in QEMU's NVMe device emulatio=
n
> > and this requires POST_WRITE for Windows guests (they don't support
> > NVMe's Doorbell Buffer Config feature so it's necessary to capture the
> > latest value written to the doorbell somehow).
> >=20
> > POST_WRITE applies to any device that has a doorbell register where the
> > latest value needs to be captured. This looks like a reasonable
> > extension to ioeventfd.
> >=20
> > I also looked into alternatives, like using userfaultfd, and didn't fin=
d
> > anything better.
> >=20
> > Please consider merging this. Thanks!
>=20
> I said I was working on using this for i82559 emulation; I have that
> working now, and POST_WRITE is perfectly sufficient.
>=20
> I think I'd prefer to see it use a WRITE_ONCE to the userspace address
> rather than a __copy_to_user() which could theoretically tear,

Hrm, I was going to say that's a "feature" of sorts, not a bug, as eventfd_=
signal()
provides ordering by way of its spinlock, but I'm guessing that the userspa=
ce side
wants to read the tail pointer multiple times per wakeup, i.e. wants to eag=
erly
process all transactions.

I don't see any explicit documentation with respect to put_user() providing
atomicity guarantees, but unsafe_atomic_store_release_user() uses unsafe_pu=
t_user(),
so presumably that's an undocumented requirement?  Ah, not a requirement so=
 much as
a "this will work so long as userspace isn't being stupid".  E.g. a 64-bit =
write
on a 32-bit x86 host is doomed unless KVM goes to extreme lengths.

So, if we want a best effort approach something end up with something like =
the
(compile-tested-only) below?  As ugly as it is, I think it has my vote, bec=
ause
it should Just Work for the majority of use cases.

#define ioeventfd_get_val(__ptr, __len, __unsupported_len)	\
({								\
	u64 __val;						\
								\
	switch (len) {						\
	case 1:							\
		__val =3D get_unaligned((u8 *)__ptr);		\
		break;						\
	case 2:							\
		__val =3D get_unaligned((u16 *)__ptr);		\
		break;						\
	case 4:							\
		__val =3D get_unaligned((u32 *)__ptr);		\
		break;						\
	case 8:							\
		__val =3D get_unaligned((u64 *)__ptr);		\
		break;						\
	default:						\
		goto __unsupported_len;				\
	}							\
	__val;							\
})

static bool
ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *v=
al)
{
	if (addr !=3D p->addr)
		/* address must be precise for a hit */
		return false;

	if (!p->length)
		/* length =3D 0 means only look at the address, so always a hit */
		return true;

	if (len !=3D p->length)
		/* address-range must be precise for a hit */
		return false;

	if (p->wildcard)
		/* all else equal, wildcard is always a hit */
		return true;

	/* otherwise, we have to actually compare the data */
	return ioeventfd_get_val(val, len, unsupported_len) =3D=3D p->datamatch;

unsupported_len:
	return false;
}

/* MMIO/PIO writes trigger an event if the addr/val match */
static int
ioeventfd_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this, gpa_t ad=
dr,
		int len, const void *val)
{
	struct _ioeventfd *p =3D to_ioeventfd(this);

	if (!ioeventfd_in_range(p, addr, len, val))
		return -EOPNOTSUPP;

	if (p->post_addr) {
		u64 _val =3D ioeventfd_get_val(val, len, unsupported_len);
		int r;

		switch (len) {
		case 1:
			r =3D put_user(_val, (u8 __user *)p->post_addr);
			break;
		case 2:
			r =3D put_user(_val, (u16 __user *)p->post_addr);
			break;
		case 4:
			r =3D put_user(_val, (u32 __user *)p->post_addr);
			break;
		case 8:
			r =3D put_user(_val, (u64 __user *)p->post_addr);
			break;
		default:
			WARN_ON_ONCE(1);
			r =3D 0;
			break;
		}
		if (r)
			return r;

	}

unsupported_len:
	eventfd_signal(p->eventfd);
	return 0;
}

